"""Candidate discovery for the Latex Lib Coverage research. Metadata only: no zip is downloaded here.

    python3 -I discover.py lt        # latextemplates.com: sitemap, then each template page's JSON-LD
    python3 -I discover.py ctan      # ctan.org topic pages, then each package's JSON
    python3 -I discover.py github    # api.github.com repository search by topic and keyword
    python3 -I discover.py pub       # publisher kits cited in the requirement docs

Every response is cached under cache/ so a run resumes where it stopped. One
request a second to each host. Sources: only hosts whose robots.txt allows it
(latextemplates.com, ctan.org, api.github.com) and the publisher URLs the
requirement documents already cite. arXiv (robots.txt disallows /e-print) and
Overleaf's gallery (zips need a login) are not used.
"""
import hashlib, html, json, os, re, sys, time, urllib.parse, urllib.request

HERE = os.path.dirname(os.path.abspath(__file__))
CACHE = os.path.join(HERE, 'cache')
CAND = os.path.join(HERE, 'cand')
UA = 'flouest-template-research/1.0 (research notes; contact yulin@flouest.com)'
DELAY = 1.0
REQUIREMENTS = '/Users/alisonswiftie/Desktop/StartUp/Flouest/Ai/JIT/JIT-Template/template-requirement'

_last = {}


def get(url, kind='text', headers=None, delay=DELAY):
    """GET with an on-disk cache and a politeness delay per host."""
    key = hashlib.sha256(url.encode()).hexdigest()[:24]
    path = os.path.join(CACHE, key)
    if os.path.exists(path):
        return open(path, 'rb').read().decode('utf8', 'replace')
    host = urllib.parse.urlparse(url).netloc
    wait = delay - (time.time() - _last.get(host, 0))
    if wait > 0:
        time.sleep(wait)
    req = urllib.request.Request(url, headers={'User-Agent': UA, **(headers or {})})
    for attempt in range(4):
        try:
            with urllib.request.urlopen(req, timeout=40) as r:
                body = r.read()
            _last[host] = time.time()
            open(path, 'wb').write(body)
            return body.decode('utf8', 'replace')
        except Exception as e:  # noqa: BLE001
            _last[host] = time.time()
            if attempt == 3:
                print('FAIL', url, e, file=sys.stderr)
                return ''
            time.sleep(3 * (attempt + 1))
    return ''


def write(name, rows, fields):
    with open(os.path.join(CAND, name), 'w', encoding='utf8') as f:
        f.write('\t'.join(fields) + '\n')
        for r in rows:
            f.write('\t'.join(str(r.get(k, '')).replace('\t', ' ').replace('\n', ' ') for k in fields) + '\n')
    print('wrote', name, len(rows))


def lt():
    sitemap = get('https://latextemplates.com/sitemap.xml')
    urls = [u for u in re.findall(r'<loc>([^<]+)</loc>', sitemap) if '/template/' in u]
    rows = []
    for i, u in enumerate(urls):
        page = get(u)
        meta = {}
        for m in re.finditer(r'<script type="application/ld\+json">(.*?)</script>', page, re.S):
            try:
                d = json.loads(m.group(1))
            except Exception:  # noqa: BLE001
                continue
            for node in d.get('@graph', [d]):
                if node.get('@type') == 'SoftwareSourceCode':
                    meta = node
        if not meta:
            continue
        media = meta.get('associatedMedia', {}) or {}
        slug = u.rstrip('/').split('/')[-1]
        rows.append(dict(
            source='lt', key=slug, url=media.get('contentUrl', ''), name=meta.get('name', ''),
            category=(meta.get('about') or {}).get('name', ''), license=meta.get('license', ''),
            runtime=meta.get('runtimePlatform', ''), size=media.get('contentSize', ''),
            repo=meta.get('codeRepository', ''), desc=html.unescape(meta.get('description', '')),
            files=','.join(p.get('name', '') for p in meta.get('hasPart', []) or [])))
        if i % 100 == 0:
            print('lt', i, len(urls))
    write('lt.tsv', rows, ['source', 'key', 'url', 'name', 'category', 'license', 'runtime', 'size', 'repo', 'desc', 'files'])


CTAN_TOPICS = ['class', 'journalpub', 'confproc', 'dissertation', 'article-like', 'report-like', 'cv', 'letter',
               'poster', 'presentation', 'exam', 'magazine', 'memorandum', 'invoice', 'calendar', 'titlepage',
               'doc-templ', 'book-pub', 'covers', 'course-material', 'publisher', 'ebook', 'card-gen', 'advert',
               'form-fillin', 'labels', 'file-card']


def ctan():
    members = {}
    for t in CTAN_TOPICS:
        page = get(f'https://ctan.org/topic/{t}')
        for p in set(re.findall(r'href="/pkg/([A-Za-z0-9._+\-]+)"', page)):
            members.setdefault(p, []).append(t)
    print('ctan packages', len(members))
    rows = []
    for i, (p, topics) in enumerate(sorted(members.items())):
        raw = get(f'https://ctan.org/json/2.0/pkg/{p}')
        try:
            d = json.loads(raw)
        except Exception:  # noqa: BLE001
            continue
        path = (d.get('ctan') or {}).get('path', '')
        if not path:
            continue
        rows.append(dict(
            source='ctan', key=p, url=f'https://mirrors.ctan.org{path}.zip', name=d.get('name', p),
            category=','.join(d.get('topics', topics)), license=d.get('license', ''), runtime='',
            size='', repo='', desc=html.unescape(re.sub(r'<[^>]+>', ' ', d.get('caption', ''))),
            files=(d.get('version') or {}).get('date', '')))
        if i % 100 == 0:
            print('ctan', i, len(members))
    write('ctan.tsv', rows, ['source', 'key', 'url', 'name', 'category', 'license', 'runtime', 'size', 'repo', 'desc', 'files'])


GH_QUERIES = [
    'topic:latex-template', 'topic:latex-templates', 'topic:thesis-template', 'topic:latex-thesis', 'topic:thesis-latex',
    'topic:phd-thesis', 'topic:master-thesis', 'topic:dissertation-template', 'topic:cv-template', 'topic:resume-template',
    'topic:latex-cv', 'topic:latex-resume', 'topic:beamer-theme', 'topic:beamer-template', 'topic:latex-beamer',
    'topic:latex-class', 'topic:latex-style', 'topic:poster-template', 'topic:latex-poster', 'topic:report-template',
    'topic:lecture-notes', 'topic:homework-template', 'topic:journal-template', 'topic:conference-template',
    'topic:letter-template', 'topic:latex-article', 'topic:university-thesis', 'topic:latex-book', 'topic:book-template',
    'topic:cover-letter', 'topic:latex-slides', 'topic:latex-report', 'topic:cheatsheet latex',
]


def github():
    seen = {}
    for q in GH_QUERIES:
        for page in (1, 2, 3):
            url = ('https://api.github.com/search/repositories?q=' + urllib.parse.quote(q + ' stars:>=8')
                   + f'&sort=stars&order=desc&per_page=100&page={page}')
            raw = get(url, headers={'Accept': 'application/vnd.github+json'}, delay=7)
            try:
                items = json.loads(raw).get('items', [])
            except Exception:  # noqa: BLE001
                items = []
            for r in items:
                if r['full_name'] not in seen:
                    seen[r['full_name']] = (q, r)
            if len(items) < 100:
                break
        print('github', q, len(seen))
    rows = []
    for name, (q, r) in seen.items():
        rows.append(dict(
            source='github', key=name.replace('/', '__'),
            url=f"https://codeload.github.com/{name}/zip/refs/heads/{r['default_branch']}", name=name,
            category=q.replace('topic:', ''), license=(r.get('license') or {}).get('spdx_id') or '',
            runtime=r.get('language') or '', size=r.get('size', 0), repo=f"stars={r['stargazers_count']}",
            desc=(r.get('description') or ''), files=r.get('pushed_at', '')))
    write('github.tsv', rows, ['source', 'key', 'url', 'name', 'category', 'license', 'runtime', 'size', 'repo', 'desc', 'files'])


def pub():
    rows, seen = [], set()
    for fn in sorted(os.listdir(REQUIREMENTS)):
        if not fn.endswith('.md') or fn.startswith('_'):
            continue
        text = open(os.path.join(REQUIREMENTS, fn), encoding='utf8', errors='replace').read()
        for url in sorted(set(re.findall(r"https?://[^ )>\"'`]+\.zip", text))):
            if url in seen or 'web.archive.org' in url:
                continue
            seen.add(url)
            rows.append(dict(source='pub', key=fn[:-3] + '__' + hashlib.sha256(url.encode()).hexdigest()[:6], url=url,
                             name=fn[:-3], category='publisher', license='', runtime='', size='', repo='', desc='', files=''))
    write('pub.tsv', rows, ['source', 'key', 'url', 'name', 'category', 'license', 'runtime', 'size', 'repo', 'desc', 'files'])


if __name__ == '__main__':
    os.makedirs(CACHE, exist_ok=True)
    os.makedirs(CAND, exist_ok=True)
    {'lt': lt, 'ctan': ctan, 'github': github, 'pub': pub}[sys.argv[1]]()
