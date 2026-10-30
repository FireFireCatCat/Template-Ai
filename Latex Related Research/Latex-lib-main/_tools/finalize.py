"""Content-level de-duplication, trimming to the target, ids, and the move into Source/.

    python3 -I finalize.py plan  [--target 1000]     # decide, write cand/final.tsv and cand/dropped.tsv, move nothing
    python3 -I finalize.py apply                     # move _stage/<stage> to Source/<id>, write _Manifest.tsv

Inputs: _fetch.tsv (what downloaded), cand/features.tsv (features.py on _stage/),
cand/selection-*.tsv and cand/reserve.tsv (where each zip came from).

A zip is dropped when: it did not download; it holds nothing LaTeX
(.tex .cls .sty .dtx .ins .bst); an earlier zip has the same bytes; or it is a
near-duplicate of an earlier one (same main document class, same zip-local class
names, structural similarity >= 0.88). If more than the target remain, the least
different are dropped, by farthest-first sampling over each zip's structure.
Ids follow a seeded shuffle, so every batch of ids mixes sources and kinds.
"""
import csv, os, random, re, shutil, sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
CAND = os.path.join(HERE, 'cand')
STAGE, SOURCE = os.path.join(ROOT, '_stage'), os.path.join(ROOT, 'Source')
SEED = 20261023
NEAR = 0.88

KIND = [  # (substring in source category/topic, kind), first match wins
    ('academic-journals', 'journal'), ('journalpub', 'journal'), ('journal-template', 'journal'),
    ('confproc', 'conference'), ('conference-template', 'conference'), ('conference-posters', 'poster'),
    ('theses', 'thesis'), ('dissertation', 'thesis'), ('thesis', 'thesis'), ('phd', 'thesis'),
    ('curricula', 'cv'), ('resume', 'cv'), ('cv', 'cv'),
    ('cover-letter', 'letter'), ('formal-letters', 'letter'), ('letter', 'letter'), ('memorandum', 'letter'),
    ('poster', 'poster'), ('presentation', 'presentation'), ('beamer', 'presentation'), ('slides', 'presentation'),
    ('assignments', 'assignment'), ('homework', 'assignment'), ('exam', 'exam'),
    ('newsletters', 'newsletter'), ('magazine', 'newsletter'), ('calendar', 'calendar'), ('invoice', 'invoice'),
    ('books', 'book'), ('book-pub', 'book'), ('lecture-notes', 'book'), ('book', 'book'),
    ('business-reports', 'report'), ('laboratory', 'report'), ('report', 'report'), ('essays', 'report'),
    ('articles', 'article'), ('article-like', 'article'), ('publisher', 'journal'),
]


def kind_of(category, source):
    c = category.lower()
    for key, kind in KIND:
        if key in c:
            return kind
    return 'misc'


def tsv(path):
    if not os.path.exists(path):
        return []
    with open(path, encoding='utf8') as f:
        return list(csv.DictReader(f, delimiter='\t', quoting=csv.QUOTE_NONE))


def structure(f):
    s = {'cls:' + f['docclass']} if f['docclass'] else set()
    s |= {'lc:' + x for x in f['local_class'].split(';') if x}
    s |= {'pkg:' + x for x in f['pkgs'].split(';') if x}
    s |= {'ls:' + x for x in f['local_sty'].split(';') if x}
    s |= {'h:' + x for x in f['hints'].split(',') if x}
    s |= {'size:' + ('tiny' if int(f['n_files']) <= 3 else 'mid' if int(f['n_files']) <= 40 else 'big')}
    return s


def jaccard(a, b):
    return len(a & b) / len(a | b) if a and b else 0.0


def plan(target):
    meta = {}
    for fn in sorted(os.listdir(CAND)):
        if fn.startswith('selection') or fn.startswith('reserve'):
            for r in tsv(os.path.join(CAND, fn)):
                meta[r['stage']] = r
    # _fetch.tsv has no header; a later line for the same stage (the archive retry) replaces an earlier one.
    fetched = {}
    for line in open(os.path.join(ROOT, '_fetch.tsv'), encoding='utf8'):
        p = line.rstrip('\n').split('\t')
        fetched[p[0]] = dict(zip(('stage', 'status', 'zip_bytes', 'sha256', 'files', 'unpacked', 'note'), p))
    feats = {r['folder']: r for r in tsv(os.path.join(CAND, 'features.tsv'))}
    dropped, kept, seen_sha = [], [], {}
    order = sorted(feats, key=lambda s: (meta.get(s, {}).get('source', ''), int(meta.get(s, {}).get('rank', 0) or 0)))
    # Prefer zips with a sample document, then those with more structure.
    order.sort(key=lambda s: (0 if feats[s]['has_sample'] == 'True' else 1))
    for stage in order:
        f, fe, m = feats[stage], fetched.get(stage, {}), meta.get(stage, {})
        if fe.get('status') != 'ok':
            dropped.append((stage, 'not downloaded: ' + fe.get('note', 'no record')))
            continue
        if int(f['n_tex']) + int(f['n_cls']) + int(f['n_sty']) + int(f['n_dtx']) + int(f['n_bst']) == 0:
            dropped.append((stage, 'no LaTeX files'))
            continue
        sha = fe['sha256']
        if sha in seen_sha:
            dropped.append((stage, 'same bytes as ' + seen_sha[sha]))
            continue
        seen_sha[sha] = stage
        s = structure(f)
        # Too little structure to compare (a package that ships only .dtx, say) is not evidence of a copy.
        thin = len([t for t in s if not t.startswith('size:')]) < 4
        twin = None if thin else next((k for k, ks, kf in kept if kf['docclass'] == f['docclass'] and kf['local_class'] == f['local_class'] and jaccard(s, ks) >= NEAR), None)
        if twin:
            dropped.append((stage, f'near-duplicate of {twin}'))
            continue
        kept.append((stage, s, f))
    print(f'{len(feats)} unpacked; {len(kept)} distinct; dropped {len(dropped)}')
    if len(kept) > target:
        sets = [s for _, s, _ in kept]
        first = max(range(len(kept)), key=lambda i: len(sets[i]))
        taken, nearest = [first], [1 - jaccard(sets[i], sets[first]) for i in range(len(kept))]
        nearest[first] = -1
        while len(taken) < target:
            nxt = max(range(len(kept)), key=lambda i: nearest[i])
            taken.append(nxt)
            nearest[nxt] = -1
            for i in range(len(kept)):
                if nearest[i] >= 0:
                    nearest[i] = min(nearest[i], 1 - jaccard(sets[i], sets[nxt]))
        keep_idx = set(taken)
        for i, (stage, _, _) in enumerate(kept):
            if i not in keep_idx:
                dropped.append((stage, 'least different of the surplus'))
        kept = [k for i, k in enumerate(kept) if i in keep_idx]
    short = target - len(kept)
    print('final', len(kept), ('SHORT by %d' % short) if short > 0 else 'at target')
    rng = random.Random(SEED)
    rng.shuffle(kept)
    rows = []
    for n, (stage, _, f) in enumerate(kept, 1):
        m, fe = meta.get(stage, {}), fetched[stage]
        slug = re.sub(r'[^a-z0-9]+', '-', (m.get('name') or stage).lower()).strip('-')[:40] or 'zip'
        rows.append({
            'id': f'{n:04d}-{slug}', 'stage': stage, 'source': m.get('source', ''), 'url': m.get('url', ''),
            'name': m.get('name', ''), 'kind': kind_of(m.get('category', ''), m.get('source', '')),
            'category': m.get('category', ''), 'license': m.get('license', '') or 'not established',
            'zip_bytes': fe['zip_bytes'], 'sha256': fe['sha256'], 'files': f['n_files'], 'main': f['main'],
            'docclass': f['docclass'], 'local_class': f['local_class'], 'has_sample': f['has_sample'], 'hints': f['hints'],
        })
    fields = list(rows[0].keys()) if rows else ['id']
    for fn, data in (('final.tsv', rows),):
        with open(os.path.join(CAND, fn), 'w', encoding='utf8') as out:
            out.write('\t'.join(fields) + '\n')
            for r in data:
                out.write('\t'.join(str(r[k]).replace('\t', ' ') for k in fields) + '\n')
    with open(os.path.join(CAND, 'dropped.tsv'), 'w', encoding='utf8') as out:
        out.write('stage\treason\n' + ''.join(f'{s}\t{r}\n' for s, r in dropped))
    by_kind = {}
    for r in rows:
        by_kind[r['kind']] = by_kind.get(r['kind'], 0) + 1
    print('by kind', dict(sorted(by_kind.items(), key=lambda kv: -kv[1])))


def apply():
    rows = tsv(os.path.join(CAND, 'final.tsv'))
    os.makedirs(SOURCE, exist_ok=True)
    for r in rows:
        src, dst = os.path.join(STAGE, r['stage']), os.path.join(SOURCE, r['id'])
        if os.path.isdir(src) and not os.path.exists(dst):
            shutil.move(src, dst)
    manifest = os.path.join(ROOT, '_Manifest.tsv')
    fields = [k for k in rows[0].keys() if k != 'stage']
    with open(manifest, 'w', encoding='utf8') as out:
        out.write('\t'.join(fields) + '\n')
        for r in rows:
            out.write('\t'.join(r[k] for k in fields) + '\n')
    print('moved; manifest', len(rows))


if __name__ == '__main__':
    if sys.argv[1] == 'plan':
        plan(int(sys.argv[sys.argv.index('--target') + 1]) if '--target' in sys.argv else 1000)
    else:
        apply()
