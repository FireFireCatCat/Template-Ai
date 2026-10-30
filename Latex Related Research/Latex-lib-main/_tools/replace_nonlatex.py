"""Swap CTAN zips that are not LaTeX2e templates for the best-different surplus ones, keeping every other id.

    python3 -I replace_nonlatex.py <pool-folder> [<pool-folder> ...] <removed-folder> [--apply]

Not LaTeX2e templates: CTAN's macros/latex209, macros/plain, macros/generic,
obsolete/, support/ trees, and graphics/ or language/ packages that are drawing
or typography tools (a few are allowed by name). Removed folders are moved to
<removed-folder>, never deleted. Each takes the replacement's slug and keeps its number.
"""
import csv, os, re, shutil, sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
CAND = os.path.join(HERE, 'cand')
EXCLUDE = re.compile(r'mirrors\.ctan\.org/(macros/(latex209|plain|generic|eplain|context|texinfo)|obsolete|support)/')
TOOLISH = re.compile(r'mirrors\.ctan\.org/(graphics|language)/')
ALLOW = {'ctan__xebaposter', 'ctan__tikzcalendarnotes', 'ctan__luatex-cn'}


def tsv(path):
    with open(path, encoding='utf8') as f:
        return list(csv.DictReader(f, delimiter='\t', quoting=csv.QUOTE_NONE))


def excluded(row):
    url = row.get('url', '')
    if EXCLUDE.search(url):
        return True
    return bool(TOOLISH.search(url)) and row.get('stage') not in ALLOW


def structure(f):
    s = {'cls:' + f['docclass']} if f['docclass'] else set()
    s |= {'lc:' + x for x in f['local_class'].split(';') if x}
    s |= {'pkg:' + x for x in f['pkgs'].split(';') if x}
    s |= {'h:' + x for x in f['hints'].split(',') if x}
    return s


def jaccard(a, b):
    return len(a & b) / len(a | b) if a and b else 0.0


def main():
    pool_dirs = [a for a in sys.argv[1:] if not a.startswith('--')][:-1]
    removed_dir = [a for a in sys.argv[1:] if not a.startswith('--')][-1]
    locate = lambda stage: next((d for d in pool_dirs if os.path.isdir(os.path.join(d, stage))), None)  # noqa: E731
    apply = '--apply' in sys.argv
    final = tsv(os.path.join(CAND, 'final.tsv'))
    feats = {r['folder']: r for r in tsv(os.path.join(CAND, 'features.tsv'))}
    meta = {}
    for fn in os.listdir(CAND):
        if fn.startswith('selection') or fn.startswith('reserve'):
            for r in tsv(os.path.join(CAND, fn)):
                meta[r['stage']] = r
    fetched = {}
    for line in open(os.path.join(ROOT, '_fetch.tsv'), encoding='utf8'):
        p = line.rstrip('\n').split('\t')
        fetched[p[0]] = p
    remove = [r for r in final if excluded(r)]
    print('to replace:', len(remove), [r['id'] for r in remove])
    dropped = {l.split('\t')[0]: l.split('\t')[1] for l in open(os.path.join(CAND, 'dropped.tsv'), encoding='utf8').read().splitlines()[1:]}
    in_final = {r['stage'] for r in final}
    # Downloaded but not chosen: dropped as surplus, or fetched after the plan. Not near-duplicates, not empty.
    spare = [s for d in pool_dirs for s in os.listdir(d)
             if s in feats and s not in in_final and (s not in dropped or dropped[s].startswith('least different'))]
    # A replacement is an actual template: a sample document that is not a package's ltxdoc driver.
    pool = [s for s in spare if locate(s) and not excluded(meta.get(s, {'stage': s}))
            and feats[s]['has_sample'] == 'True' and feats[s]['docclass'] not in ('ltxdoc', 'l3doc', 'ydoc')]
    print('replacement pool:', len(pool))
    kept = [structure(feats[r['stage']]) for r in final if not excluded(r)]
    chosen = []
    cands = {s: structure(feats[s]) for s in pool}
    for _ in remove:
        best = max(cands, key=lambda s: 1 - max((jaccard(cands[s], k) for k in kept), default=0))
        chosen.append(best)
        kept.append(cands.pop(best))
    for old, new in zip(remove, chosen):
        print(f"  {old['id']}  ->  {new}")
    if not apply:
        return
    os.makedirs(removed_dir, exist_ok=True)
    rows = {r['id']: r for r in final}
    for old, new in zip(remove, chosen):
        number = old['id'].split('-')[0]
        m, f = meta.get(new, {}), feats[new]
        slug = re.sub(r'[^a-z0-9]+', '-', (m.get('name') or new).lower()).strip('-')[:40] or 'zip'
        new_id = f'{number}-{slug}'
        shutil.move(os.path.join(ROOT, 'Source', old['id']), os.path.join(removed_dir, old['id']))
        shutil.move(os.path.join(locate(new), new), os.path.join(ROOT, 'Source', new_id))
        fe = fetched[new]
        row = dict(old)
        row.update({
            'id': new_id, 'stage': new, 'source': m.get('source', ''), 'url': m.get('url', ''), 'name': m.get('name', ''),
            'category': m.get('category', ''), 'license': m.get('license', '') or 'not established',
            'zip_bytes': fe[2], 'sha256': fe[3], 'files': f['n_files'], 'main': f['main'], 'docclass': f['docclass'],
            'local_class': f['local_class'], 'has_sample': f['has_sample'], 'hints': f['hints'],
        })
        del rows[old['id']]
        rows[new_id] = row
    out = sorted(rows.values(), key=lambda r: r['id'])
    fields = list(final[0].keys())
    with open(os.path.join(CAND, 'final.tsv'), 'w', encoding='utf8') as o:
        o.write('\t'.join(fields) + '\n' + ''.join('\t'.join(str(r[k]) for k in fields) + '\n' for r in out))
    mf = [k for k in fields if k != 'stage']
    with open(os.path.join(ROOT, '_Manifest.tsv'), 'w', encoding='utf8') as o:
        o.write('\t'.join(mf) + '\n' + ''.join('\t'.join(str(r[k]) for k in mf) + '\n' for r in out))
    print('replaced', len(remove), '; manifest rows', len(out))


if __name__ == '__main__':
    main()
