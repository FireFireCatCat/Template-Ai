"""Pick which candidates to download: as different from each other as the metadata allows.

    python3 -I select.py [--quota lt=400,ctan=380,github=180,pub=45] [--reserve 0.2] [--tag name]

Reads cand/{lt,ctan,github,pub}.tsv. For each source, farthest-first sampling
over word sets (name, description, category, topics, underlying class): start
from one item, then repeatedly take the item whose nearest already-taken item is
farthest away. Writes cand/selection-<tag>.tsv (download these) and cand/reserve-<tag>.tsv
(the next picks, to refill after content-level duplicates are dropped).
Metadata only: nothing is downloaded here. Content-level distinctness is
checked after download (features.py, dedup.py).
"""
import csv, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
CAND = os.path.join(HERE, 'cand')
STOP = set('the and for with from that this are was were has have not you your use using used can will into its their '
           'template templates latex class classes document documents style styles package packages tex file files '
           'based provides provide support supports typeset typesetting create written write new more one two all any '
           'also which when such other than these those only just like out our them what how may must should '
           'journal article articles pdflatex xelatex lualatex main'.split())


def rows(name):
    path = os.path.join(CAND, name)
    if not os.path.exists(path):
        return []
    with open(path, encoding='utf8') as f:
        return list(csv.DictReader(f, delimiter='\t', quoting=csv.QUOTE_NONE))


def tokens(r):
    text = ' '.join([r.get('name', ''), r.get('desc', ''), r.get('category', '').replace(',', ' '), r.get('repo', ''),
                     r.get('runtime', '')]).lower()
    t = {w for w in re.findall(r'[a-z][a-z0-9]{2,}', text) if w not in STOP}
    t |= {'cat:' + c for c in re.split(r'[,\s]+', r.get('category', '').lower()) if c}
    t |= {'run:' + r.get('runtime', '').lower()} if r.get('runtime') else set()
    return t


def distance(a, b):
    if not a or not b:
        return 1.0
    return 1.0 - len(a & b) / len(a | b)


def farthest_first(items, k):
    """Indices of up to k items, in the order taken."""
    if not items or k <= 0:
        return []
    toks = [tokens(r) for r in items]
    first = max(range(len(items)), key=lambda i: len(toks[i]))
    taken = [first]
    nearest = [distance(toks[i], toks[first]) for i in range(len(items))]
    nearest[first] = -1
    while len(taken) < min(k, len(items)):
        nxt = max(range(len(items)), key=lambda i: nearest[i])
        if nearest[nxt] < 0:
            break
        taken.append(nxt)
        nearest[nxt] = -1
        for i in range(len(items)):
            if nearest[i] >= 0:
                nearest[i] = min(nearest[i], distance(toks[i], toks[nxt]))
    return taken


def usable(r, source):
    if not r.get('url'):
        return False
    if source == 'github':
        lang = r.get('runtime', '')
        text = (r.get('name', '') + ' ' + r.get('desc', '')).lower()
        if lang not in ('TeX', 'Makefile', 'Shell', '') and 'latex' not in text:
            return False
        try:
            if int(r.get('size') or 0) > 40000:  # KB
                return False
        except ValueError:
            pass
    if source == 'ctan':
        topics = set(r.get('category', '').split(','))
        text = (r.get('name', '') + ' ' + r.get('desc', ''))
        # Not LaTeX templates: Plain TeX, ConTeXt, LaTeX 2.09, obsolete packages, documentation-only entries.
        if topics & {'obsolete', 'latex209', 'context', 'context-doc', 'doc-supp', 'docu-pkg', 'bibtex-supp', 'bibtex-doc'} and not topics & {'class', 'doc-templ'}:
            return False
        if re.search(r'plain\s*tex|context|2\.09|tex 2\.09', text, re.I) or r['key'].startswith('context'):
            return False
    if source == 'pub' and 'ctan.org' in r['url']:
        return False  # the CTAN list covers these
    return True


def stage_name(r, source):
    key = re.sub(r'[^A-Za-z0-9._+-]+', '-', r['key'])
    return f"{source}__{key}"[:90]


def main():
    quota = dict(lt=350, ctan=470, github=240, pub=60)
    if '--quota' in sys.argv:
        quota = {k: int(v) for k, v in (p.split('=') for p in sys.argv[sys.argv.index('--quota') + 1].split(','))}
    reserve_frac = float(sys.argv[sys.argv.index('--reserve') + 1]) if '--reserve' in sys.argv else 0.2
    tag = sys.argv[sys.argv.index('--tag') + 1] if '--tag' in sys.argv else '1'
    chosen, reserve = [], []
    for source, file in (('lt', 'lt.tsv'), ('ctan', 'ctan.tsv'), ('github', 'github.tsv'), ('pub', 'pub.tsv')):
        items = [r for r in rows(file) if usable(r, source)]
        k = quota.get(source, 0)
        order = farthest_first(items, int(k * (1 + reserve_frac)))
        print(f'{source}: {len(items)} usable, quota {k}, order {len(order)}')
        for rank, i in enumerate(order):
            r = items[i]
            out = dict(stage=stage_name(r, source), url=r['url'], source=source, name=r.get('name', ''),
                       category=r.get('category', ''), license=r.get('license', ''), rank=rank)
            (chosen if rank < k else reserve).append(out)
    fields = ['stage', 'url', 'source', 'name', 'category', 'license', 'rank']
    for fn, data in ((f'selection-{tag}.tsv', chosen), (f'reserve-{tag}.tsv', reserve)):
        with open(os.path.join(CAND, fn), 'w', encoding='utf8') as f:
            f.write('\t'.join(fields) + '\n')
            for r in data:
                f.write('\t'.join(str(r[k]).replace('\t', ' ').replace('\n', ' ') for k in fields) + '\n')
        print(fn, len(data))


if __name__ == '__main__':
    main()
