"""Does the lib stop growing? Reads Solution/*.md in id order.

    python3 -I curve.py [--window 50]

For each window of zips: how many distinct ways have been used so far, and how
many of those were first used in this window. Ways are the backticked ids of the
Component map tables. Class ways (class.*) are counted apart from component ways,
because a new publisher class is expected to keep appearing while the question for
packages is whether they saturate. Also yes-rate by source and by kind from the manifest.
"""
import collections, csv, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
SOL = os.path.join(ROOT, 'Solution')
CORE = {'page', 'cols', 'pg', 'hf', 'pgnum', 'sp', 'font', 'color', 'bg', 'lang', 'meta', 'xref', 'front', 'abs', 'toc', 'head',
        'num', 'list', 'quote', 'mark', 'fn', 'note', 'math', 'thm', 'alg', 'fig', 'tbl', 'cap', 'code', 'box', 'bib', 'idx'}
FILE_EXT = {'tex', 'cls', 'sty', 'bst', 'dtx', 'ins', 'bib', 'cfg', 'def', 'clo', 'md', 'txt', 'sh', 'py', 'pdf', 'png', 'json', 'yml', 'ist', 'lco', 'csv', 'ldf'}


def section(text, head):
    m = re.search(re.escape(head) + r'\n(.*?)(?=\n## |\Z)', text, re.S)
    return m.group(1) if m else ''


WAY = re.compile(r'`((?:NEW:)?[a-z][a-z0-9-]*\.[a-z0-9][a-z0-9+_.:-]*)`')


def rejected_ways():
    out = set()
    d = os.path.join(HERE, 'alias')
    for fn in os.listdir(d):
        if fn.endswith('.json') and fn != 'renames.json':
            try:
                import json
                for k, v in json.load(open(os.path.join(d, fn), encoding='utf8')).items():
                    if isinstance(k, str) and v is None:
                        out.add(k.replace('NEW:', ''))
            except (ValueError, AttributeError):
                pass
    return out


REJECTED = rejected_ways()


def main():
    window = int(sys.argv[sys.argv.index('--window') + 1]) if '--window' in sys.argv else 50
    manifest = {}
    mpath = os.path.join(ROOT, '_Manifest.tsv')
    if os.path.exists(mpath):
        for r in csv.DictReader(open(mpath, encoding='utf8'), delimiter='\t', quoting=csv.QUOTE_NONE):
            manifest[r['id']] = r
    files = sorted(f for f in os.listdir(SOL) if f.endswith('.md'))
    seen_c, seen_k, seen_d = set(), set(), set()
    print(f'{len(files)} solutions; window {window}')
    print(f'{"zips":>6} {"core ways":>10} {"new":>5} {"doc-kind":>9} {"new":>5} {"class":>6} {"new":>5} {"yes%":>6}')
    win_c = win_k = win_d = 0
    yes = 0
    stats = collections.defaultdict(lambda: [0, 0])
    for i, fn in enumerate(files, 1):
        text = open(os.path.join(SOL, fn), encoding='utf8', errors='replace').read()
        verdict = text.split('\n', 1)[0].strip()
        yes += verdict == 'yes'
        m = manifest.get(fn[:-3], {})
        for key in (('source', m.get('source', '?')), ('kind', m.get('kind', '?'))):
            stats[key][0] += verdict == 'yes'
            stats[key][1] += 1
        for w in set(WAY.findall(section(text, '## Component map') + '\n' + section(text, '## Class setting'))):
            w = w.replace('NEW:', '')
            if w.rsplit('.', 1)[-1].lower() in FILE_EXT or ':' in w:
                continue
            if w in REJECTED:
                continue
            if w.startswith('class.'):
                bucket, seen = seen_k, 'k'
            elif w.split('.', 1)[0] in CORE:
                bucket, seen = seen_c, 'c'
            else:
                bucket, seen = seen_d, 'd'
            if w not in bucket:
                bucket.add(w)
                if seen == 'k':
                    win_k += 1
                elif seen == 'c':
                    win_c += 1
                else:
                    win_d += 1
        if i % window == 0 or i == len(files):
            print(f'{i:>6} {len(seen_c):>10} {win_c:>5} {len(seen_d):>9} {win_d:>5} {len(seen_k):>6} {win_k:>5} {100 * yes / i:>5.0f}%')
            win_c = win_k = win_d = 0
    print()
    for dim in ('source', 'kind'):
        print(f'yes-rate by {dim}:')
        for (d, name), (y, n) in sorted(stats.items(), key=lambda kv: -kv[1][1]):
            if d == dim:
                print(f'  {name:<14} {y:>4}/{n:<4} {100 * y / n:>4.0f}%')


if __name__ == '__main__':
    main()
