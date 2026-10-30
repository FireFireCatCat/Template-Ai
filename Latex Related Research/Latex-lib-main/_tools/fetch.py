"""Download and safely unpack the selected zips into _stage/.

    python3 -I fetch.py <selection.tsv> [--workers 4]

selection.tsv columns: stage (folder name under _stage/), url, source.
Appends one row per zip to _fetch.tsv: stage, status, zip_bytes, sha256, files, unpacked_bytes, note.
Resumes: a stage folder already in _fetch.tsv with status ok is skipped.

A downloaded zip is untrusted data and is only ever unpacked, never run. It is
refused whole (nothing written) when any entry is unsafe, as the app's own zip
reader does (docs ADR-253): an absolute path, a `..`, a symlink or device, a
duplicate name, a zip that lies about a size, or a limit passed.
"""
import concurrent.futures as cf, hashlib, io, os, shutil, stat, sys, threading, time, urllib.parse, urllib.request, zipfile

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
STAGE = os.path.join(ROOT, '_stage')
LOG = os.path.join(ROOT, '_fetch.tsv')
UA = 'flouest-template-research/1.0 (research notes; contact yulin@flouest.com)'
MAX_ZIP = 40 * 1024 * 1024
MAX_UNPACKED = 400 * 1024 * 1024
MAX_FILE = 100 * 1024 * 1024
MAX_FILES = 5000
SKIP_DIRS = {'__MACOSX', '.git', '.svn', '.hg', 'node_modules'}
SKIP_FILES = {'.DS_Store', 'Thumbs.db'}

_hosts, _hosts_lock, _log_lock = {}, threading.Lock(), threading.Lock()


def polite(url, delay=1.0):
    host = urllib.parse.urlparse(url).netloc
    with _hosts_lock:
        lock = _hosts.setdefault(host, [threading.Lock(), 0.0])
    with lock[0]:
        wait = delay - (time.time() - lock[1])
        if wait > 0:
            time.sleep(wait)
        lock[1] = time.time()


def download(url):
    polite(url)
    req = urllib.request.Request(url, headers={'User-Agent': UA})
    last = None
    for attempt in range(3):
        try:
            with urllib.request.urlopen(req, timeout=60) as r:
                declared = int(r.headers.get('Content-Length') or 0)
                if declared > MAX_ZIP:
                    return None, f'too large ({declared} bytes)'
                buf = io.BytesIO()
                while True:
                    chunk = r.read(1 << 16)
                    if not chunk:
                        break
                    buf.write(chunk)
                    if buf.tell() > MAX_ZIP:
                        return None, f'too large (> {MAX_ZIP} bytes)'
                return buf.getvalue(), ''
        except Exception as e:  # noqa: BLE001
            last = e
            time.sleep(3 * (attempt + 1))
    return None, f'download failed: {last}'


def safe_name(name):
    if not name or name.startswith('/') or '\\' in name or ':' in name.split('/')[0]:
        return None
    parts = [p for p in name.split('/') if p not in ('', '.')]
    if not parts or any(p == '..' for p in parts):
        return None
    return parts


def unpack(data, dest):
    """Returns (files, bytes, note) or raises ValueError, writing nothing on refusal."""
    if data[:2] != b'PK':
        raise ValueError('not a zip (no PK header)')
    zf = zipfile.ZipFile(io.BytesIO(data))
    entries, seen, total = [], set(), 0
    for info in zf.infolist():
        parts = safe_name(info.filename)
        if parts is None:
            raise ValueError(f'unsafe entry name {info.filename!r}')
        mode = info.external_attr >> 16
        if mode and (stat.S_ISLNK(mode) or stat.S_ISCHR(mode) or stat.S_ISBLK(mode) or stat.S_ISFIFO(mode)):
            raise ValueError(f'link or device entry {info.filename!r}')
        if info.flag_bits & 0x1:
            raise ValueError('encrypted entry')
        if any(p in SKIP_DIRS for p in parts) or parts[-1] in SKIP_FILES:
            continue
        key = '/'.join(parts)
        if key in seen:
            raise ValueError(f'duplicate entry {key!r}')
        seen.add(key)
        if info.is_dir():
            continue
        if info.file_size > MAX_FILE:
            raise ValueError(f'file too large {key!r}')
        total += info.file_size
        entries.append((info, parts))
    if len(entries) > MAX_FILES:
        raise ValueError(f'too many files ({len(entries)})')
    if total > MAX_UNPACKED:
        raise ValueError(f'unpacked too large ({total} bytes)')
    # A single top-level wrapper folder (GitHub, CTAN) is dropped, so evidence paths are short.
    tops = {p[0] for _, p in entries}
    strip = 1 if len(tops) == 1 and all(len(p) > 1 for _, p in entries) else 0
    tmp = dest + '.part'
    shutil.rmtree(tmp, ignore_errors=True)
    os.makedirs(tmp)
    written = 0
    for info, parts in entries:
        out = os.path.join(tmp, *parts[strip:])
        os.makedirs(os.path.dirname(out), exist_ok=True)
        with zf.open(info) as src, open(out, 'wb') as dst:
            n = 0
            while True:
                chunk = src.read(1 << 16)
                if not chunk:
                    break
                n += len(chunk)
                if n > info.file_size + 1024:
                    raise ValueError(f'entry {info.filename!r} larger than it declares')
                dst.write(chunk)
        written += n
    shutil.rmtree(dest, ignore_errors=True)
    os.rename(tmp, dest)
    return len(entries), written, ('wrapper dropped' if strip else '')


def one(row):
    stage, url, source = row['stage'], row['url'], row['source']
    dest = os.path.join(STAGE, stage)
    data, note = download(url)
    if data is None:
        return [stage, 'failed', 0, '', 0, 0, note]
    sha = hashlib.sha256(data).hexdigest()
    try:
        files, size, note = unpack(data, dest)
    except (ValueError, zipfile.BadZipFile, NotImplementedError, RuntimeError) as e:
        shutil.rmtree(dest + '.part', ignore_errors=True)
        return [stage, 'refused', len(data), sha, 0, 0, str(e)]
    return [stage, 'ok', len(data), sha, files, size, note]


def main():
    sel = sys.argv[1]
    workers = int(sys.argv[sys.argv.index('--workers') + 1]) if '--workers' in sys.argv else 4
    rows = [dict(zip(('stage', 'url', 'source'), line.rstrip('\n').split('\t')[:3])) for line in open(sel, encoding='utf8')][1:]
    done = set()
    if os.path.exists(LOG):
        done = {l.split('\t')[0] for l in open(LOG, encoding='utf8') if l.split('\t')[1:2] == ['ok']}
    os.makedirs(STAGE, exist_ok=True)
    todo = [r for r in rows if r['stage'] not in done]
    print('to fetch', len(todo), 'of', len(rows), flush=True)
    n = 0
    with cf.ThreadPoolExecutor(workers) as ex:
        # Logged as each finishes, so one slow download never holds back the record of the others.
        for future in cf.as_completed([ex.submit(one, r) for r in todo]):
            result = future.result()
            with _log_lock, open(LOG, 'a', encoding='utf8') as f:
                f.write('\t'.join(str(x) for x in result) + '\n')
            n += 1
            if n % 25 == 0 or result[1] != 'ok':
                print(n, result[0], result[1], result[6], flush=True)


if __name__ == '__main__':
    main()
