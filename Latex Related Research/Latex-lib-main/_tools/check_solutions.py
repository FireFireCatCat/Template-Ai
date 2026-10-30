"""Deterministic checks on Solution/*.md. Nothing here judges the analysis; it finds files that cannot be trusted.

    python3 -I check_solutions.py [id-prefix ...]     # default: every file
    python3 -I check_solutions.py --json              # machine-readable summary on stdout

Per file: first line is exactly yes|no; the required sections are present; the
verdict agrees with the Blockers section; every way id in backticks is in
_Lib.md or written NEW:<id>; every cited file:line exists inside Source/<id>*/.
"""
import json, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
SOL, SRC = os.path.join(ROOT, 'Solution'), os.path.join(ROOT, 'Source')
REQUIRED = ['## Verdict', '## Blockers', '## Class setting', '## Component map', '## Bespoke code', '## Content-opaque', '## Lib changes']
WAY = re.compile(r'`((?:NEW:)?[a-z][a-z0-9-]*\.[a-z0-9][a-z0-9+_.:-]*)`')
CITE = re.compile(r'(?<![\w/])([\w@+\-./]*?[\w+\-]+\.(?:tex|cls|sty|bst|dtx|ins|bib|cfg|def|clo|ldf|md|txt|sh|py|bbx|cbx|lbx|ist|tikz|code|bbl)):(\d+)')
FILE_EXT = {'tex', 'cls', 'sty', 'bst', 'dtx', 'ins', 'bib', 'cfg', 'def', 'clo', 'ldf', 'md', 'txt', 'sh', 'py', 'bbx', 'cbx', 'lbx', 'pdf', 'png', 'jpg', 'eps', 'tikz', 'code', 'bbl', 'ist', 'json', 'yml', 'yaml', 'toml', 'makefile', 'mk'}
BLOCKERS = {'BESPOKE', 'ART', 'UNMAPPED', 'EXTERNAL', 'NOTEMPLATE'}


def lib_ids():
    ids = set()
    for line in open(os.path.join(ROOT, '_Lib.md'), encoding='utf8'):
        m = re.match(r'\|\s*`([^`]+)`', line)
        if m:
            ids.add(m.group(1))
    return ids


def lib_prefixes(ids):
    return {i.split('.', 1)[0] for i in ids}


def source_dir(sid):
    for name in os.listdir(SRC):
        if name == sid or name.startswith(sid + '-'):
            return os.path.join(SRC, name)
    return None


def section(text, head):
    m = re.search(re.escape(head) + r'\n(.*?)(?=\n## |\Z)', text, re.S)
    return m.group(1).strip() if m else ''


_by_base = {}


def resolve(sdir, rel):
    """A cited path as written, or (agents cite basenames) the one file with that name in the zip."""
    full = os.path.join(sdir, rel)
    if os.path.isfile(full):
        return full
    if sdir not in _by_base:
        idx = {}
        for dp, _, fs in os.walk(sdir):
            for f in fs:
                idx.setdefault(f, []).append(os.path.join(dp, f))
        _by_base[sdir] = idx
    base = os.path.basename(rel)
    hits = _by_base[sdir].get(base, [])
    if not hits:
        hits = [h for n, ps in _by_base[sdir].items() if n.lower().endswith(('-' + base).lower()) or n.lower().endswith(('_' + base).lower()) or n.lower().endswith(('.' + base).lower()) for h in ps]
    if len(hits) > 1:
        return hits  # several files share the name (examples/*/main.tex): the caller takes the longest
    if len(hits) == 1:
        return hits[0]
    # a path ending in the cited one
    tail = [h for h in hits if h.endswith('/' + rel.lstrip('./'))]
    return tail[0] if len(tail) == 1 else (hits[0] if hits else None)


def check(path, known, cache):
    fn = os.path.basename(path)
    sid = fn[:-3]
    problems = []
    text = open(path, encoding='utf8', errors='replace').read()
    lines = text.split('\n')
    verdict = lines[0].strip() if lines else ''
    if verdict not in ('yes', 'no'):
        problems.append(f'first line is {verdict!r}, not yes|no')
    for head in REQUIRED:
        if head not in text:
            problems.append(f'missing section {head}')
    if 'Unverified' not in text:
        problems.append('no Unverified line')
    carried = re.search(r'^- Look carried by:\s*(class|zip-local|preamble|mixed)\b', text, re.M)
    origin = re.search(r'^- Class origin:\s*(ctan|publisher-official|tex-distribution-unbundled|zip-local|none)\b', text, re.M)
    if not carried:
        problems.append('header lacks a valid "Look carried by"')
    if not origin:
        problems.append('header lacks a valid "Class origin"')
    blockers = section(text, '## Blockers')
    kinds = set(re.findall(r'`?([A-Z]{3,10})`?', blockers)) & BLOCKERS
    has_blockers = bool(blockers) and not re.match(r'(?i)^\W*none\b', blockers)
    if verdict == 'yes' and has_blockers:
        problems.append('yes, but Blockers is not none')
    if verdict == 'no' and not has_blockers:
        problems.append('no, but Blockers says none')
    if has_blockers and kinds:
        loose = [l.strip()[:60] for l in blockers.split('\n') if re.match(r'^\s*-\s*`?(?:BESPOKE|ART|UNMAPPED|EXTERNAL|NOTEMPLATE)\b', l)
                 and not re.match(r'^\s*-\s*`?(?:BESPOKE|ART|UNMAPPED|EXTERNAL|NOTEMPLATE)/(?:class|preamble|body|package|zip)\b', l)]
        if loose:
            problems.append(f'{len(loose)} blocker lines without a scope tag')
    if verdict == 'no' and has_blockers and not kinds:
        problems.append('no, but no blocker kind (BESPOKE|ART|UNMAPPED|EXTERNAL|NOTEMPLATE) named')
    prefixes = lib_prefixes(known)
    mapped = section(text, '## Component map') + '\n' + section(text, '## Class setting')
    ways = {w for w in WAY.findall(mapped) if w.rsplit('.', 1)[-1].lower() not in FILE_EXT and ':' not in w.replace('NEW:', '', 1)}
    unknown = sorted(w for w in ways if not w.startswith('NEW:') and w not in known and not w.startswith('class.')
                     and w.split('.', 1)[0] in prefixes)
    if unknown:
        problems.append('way ids not in _Lib.md: ' + ', '.join(unknown[:8]))
    sdir = source_dir(sid)
    if sdir is None:
        problems.append('no Source folder for this id')
    else:
        missing = []
        cites = 0
        for cm in CITE.finditer(text):
            rel, line = cm.group(1).strip(), cm.group(2)
            before = text[max(0, cm.start() - 6):cm.start()]
            if '!' in text[max(0, cm.start() - 40):cm.start()].split(' ')[-1] or before.endswith('[cls] ') or '[cls]' in text[max(0, cm.start() - 8):cm.start()]:
                cites += 1   # a member of a nested archive, or a labelled file outside the zip: not checkable here
                continue
            cites += 1
            found = resolve(sdir, rel) or os.path.join(sdir, rel)
            fulls = found if isinstance(found, list) else [found]
            for full in fulls:
                if full not in cache:
                    cache[full] = sum(1 for _ in open(full, 'rb')) if os.path.isfile(full) else -1
            n = max(cache[f] for f in fulls)
            if n < 0:
                missing.append(f'{rel} (no file)')
            elif int(line) > n + 1:
                missing.append(f'{rel}:{line} (file has {n} lines)')
        short_form = len(re.findall(r'\b[A-Za-z]{1,12}:\d{2,5}\b', text)) >= 5  # e.g. "S:7301", the file named once in a header
        if cites == 0 and verdict and not short_form:
            problems.append('no file:line evidence cited')
        if missing:
            problems.append(f'{len(missing)} bad citations: ' + '; '.join(missing[:5]))
    return {'id': sid, 'verdict': verdict, 'blockers': sorted(kinds), 'ways': sorted(ways), 'problems': problems, 'lines': len(lines),
            'carried': carried.group(1) if carried else '', 'origin': origin.group(1) if origin else ''}


def main():
    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    known, cache, rows = lib_ids(), {}, []
    for fn in sorted(os.listdir(SOL)):
        if fn.endswith('.md') and (not args or any(fn.startswith(a) for a in args)):
            rows.append(check(os.path.join(SOL, fn), known, cache))
    bad = [r for r in rows if r['problems']]
    if '--json' in sys.argv:
        print(json.dumps({'files': len(rows), 'bad': len(bad), 'rows': rows}))
        return
    yes = sum(r['verdict'] == 'yes' for r in rows)
    print(f'{len(rows)} files: {yes} yes, {len(rows) - yes} no, {len(bad)} with problems')
    for r in bad:
        print(f"  {r['id']}: " + ' | '.join(r['problems']))


if __name__ == '__main__':
    main()
