"""Numbers for the summary, read from Solution/*.md and _Manifest.tsv.

    python3 -I stats.py [--json]

Verdicts by what carries the look and where the class came from, the blockers behind every no
(by kind and scope), the engine, the yes-rate under three definitions, and how concentrated the
ways are (a way used by one zip only does not shrink the lib: it is a list entry).
"""
import collections, csv, json, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
SOL = os.path.join(ROOT, 'Solution')
WAY = re.compile(r'`((?:NEW:)?[a-z][a-z0-9-]*\.[a-z0-9][a-z0-9+_.:-]*)`')
FILE_EXT = {'tex', 'cls', 'sty', 'bst', 'dtx', 'ins', 'bib', 'cfg', 'def', 'clo', 'md', 'txt', 'sh', 'py', 'pdf', 'png', 'json', 'yml'}
CORE = {'page', 'cols', 'pg', 'hf', 'pgnum', 'sp', 'font', 'color', 'bg', 'lang', 'meta', 'xref', 'front', 'abs', 'toc', 'head',
        'num', 'list', 'quote', 'mark', 'fn', 'note', 'math', 'thm', 'alg', 'fig', 'tbl', 'cap', 'code', 'box', 'bib', 'idx'}


def rejected_ways():
    """Provisional ways a consolidation rejected (alias value null): they are not lib ways and are not counted as ways."""
    out = set()
    d = os.path.join(HERE, 'alias')
    for fn in os.listdir(d):
        if fn.endswith('.json') and fn not in ('renames.json',):
            try:
                for k, v in json.load(open(os.path.join(d, fn), encoding='utf8')).items():
                    if isinstance(k, str) and v is None:
                        out.add(k.replace('NEW:', ''))
            except (ValueError, AttributeError):
                pass
    return out


REJECTED = rejected_ways()


def section(text, head):
    m = re.search(re.escape(head) + r'\n(.*?)(?=\n## |\Z)', text, re.S)
    return m.group(1) if m else ''


def header(text, key):
    m = re.search(r'^- ' + re.escape(key) + r':\s*([^\n(]+)', text, re.M)
    return m.group(1).strip().rstrip('.') if m else ''


def main():
    manifest = {}
    mp = os.path.join(ROOT, '_Manifest.tsv')
    if os.path.exists(mp):
        for r in csv.DictReader(open(mp, encoding='utf8'), delimiter='\t', quoting=csv.QUOTE_NONE):
            manifest[r['id']] = r
    rows = []
    for fn in sorted(os.listdir(SOL)):
        if not fn.endswith('.md'):
            continue
        text = open(os.path.join(SOL, fn), encoding='utf8', errors='replace').read()
        verdict = text.split('\n', 1)[0].strip()
        blockers = []
        for line in section(text, '## Blockers').split('\n'):
            m = re.match(r'^\s*-\s*`?((?:BESPOKE|ART|UNMAPPED|EXTERNAL|NOTEMPLATE))(?:/(\w+))?`?', line)
            if m:
                blockers.append((m.group(1), m.group(2) or '?'))
        ways = sorted({w.replace('NEW:', '') for w in WAY.findall(section(text, '## Component map') + '\n' + section(text, '## Class setting'))
                       if w.rsplit('.', 1)[-1].lower() not in FILE_EXT and ':' not in w.replace('NEW:', '', 1) and w.replace('NEW:', '') not in REJECTED})
        eng = header(text, 'Engine')
        rows.append(dict(
            id=fn[:-3], verdict=verdict, carried=header(text, 'Look carried by').split()[0] if header(text, 'Look carried by') else '?',
            origin=header(text, 'Class origin').split()[0] if header(text, 'Class origin') else '?',
            kind=header(text, 'Kind').split()[0] if header(text, 'Kind') else manifest.get(fn[:-3], {}).get('kind', '?'),
            source=manifest.get(fn[:-3], {}).get('source', '?'), blockers=blockers, ways=ways,
            xelua=bool(re.search(r'XeLaTeX|LuaLaTeX', eng)), notemplate=any(k == 'NOTEMPLATE' for k, _ in blockers)))
    n = len(rows)
    out = {}
    yes = [r for r in rows if r['verdict'] == 'yes']
    real = [r for r in rows if not r['notemplate']]
    out['zips'] = n
    out['yes'] = len(yes)
    out['no_template'] = len(rows) - len(real)
    out['yes_rate_all'] = len(yes) / n if n else 0
    out['yes_rate_excluding_notemplate'] = (len([r for r in real if r['verdict'] == 'yes']) / len(real)) if real else 0
    out['by_carried'] = {k: [sum(r['verdict'] == 'yes' for r in rows if r['carried'] == k), sum(r['carried'] == k for r in rows)]
                         for k in sorted({r['carried'] for r in rows})}
    out['by_origin'] = {k: [sum(r['verdict'] == 'yes' for r in rows if r['origin'] == k), sum(r['origin'] == k for r in rows)]
                        for k in sorted({r['origin'] for r in rows})}
    out['by_kind'] = {k: [sum(r['verdict'] == 'yes' for r in rows if r['kind'] == k), sum(r['kind'] == k for r in rows)]
                      for k in sorted({r['kind'] for r in rows})}
    out['by_source'] = {k: [sum(r['verdict'] == 'yes' for r in rows if r['source'] == k), sum(r['source'] == k for r in rows)]
                        for k in sorted({r['source'] for r in rows})}
    # the no's, by the kinds of blocker (a file counts once per kind)
    nos = [r for r in rows if r['verdict'] == 'no']
    out['no_by_kind'] = collections.Counter(k for r in nos for k in {b[0] for b in r['blockers']})
    out['no_by_kind_scope'] = collections.Counter(f'{b[0]}/{b[1]}' for r in nos for b in set(r['blockers']))
    only = collections.Counter(next(iter({b[0] for b in r['blockers']})) for r in nos if len({b[0] for b in r['blockers']}) == 1)
    out['no_single_cause'] = only
    # three definitions of the yes-rate
    strict = [r for r in rows if r['verdict'] == 'yes' and r['carried'] != 'class']
    out['yes_not_class_carried'] = len(strict)
    out['yes_if_class_scope_blockers_ignored'] = sum(1 for r in rows if r['verdict'] == 'yes' or (r['blockers'] and all(b[1] == 'class' for b in r['blockers']) and not r['notemplate']))
    out['pdf_engine_yes'] = sum(1 for r in yes if not r['xelua'])
    # ways
    use = collections.Counter(w for r in rows for w in r['ways'])
    cls = {w: c for w, c in use.items() if w.startswith('class.')}
    core = {w: c for w, c in use.items() if w.split('.', 1)[0] in CORE and not w.startswith('class.')}
    dock = {w: c for w, c in use.items() if w not in cls and w not in core}
    def hist(d):
        return {'ways': len(d), 'used_by_1': sum(1 for c in d.values() if c == 1), 'used_by_2_to_4': sum(1 for c in d.values() if 2 <= c <= 4), 'used_by_5_plus': sum(1 for c in d.values() if c >= 5)}
    out['ways_core'], out['ways_doc_kind'], out['ways_class'] = hist(core), hist(dock), hist(cls)
    out['top_ways'] = use.most_common(25)
    # a yes that rests on a way no other zip needed
    single = {w for w, c in use.items() if c == 1 and not w.startswith('class.')}
    out['yes_resting_on_a_singleton_way'] = sum(1 for r in yes if any(w in single for w in r['ways']))
    if '--json' in sys.argv:
        print(json.dumps(out, default=dict, indent=1))
        return
    print(f"{n} zips: {len(yes)} yes ({100 * len(yes) / n:.0f}%), {n - len(yes)} no; {out['no_template']} have no template at all (NOTEMPLATE)")
    print(f"yes-rate excluding NOTEMPLATE zips: {100 * out['yes_rate_excluding_notemplate']:.0f}%")
    print(f"yes where the look is NOT carried by a published class: {out['yes_not_class_carried']}  |  yes if blockers that sit only inside zip-local classes were ignored: {out['yes_if_class_scope_blockers_ignored']}")
    for dim in ('by_carried', 'by_origin', 'by_source', 'by_kind'):
        print(f"\n{dim}:")
        for k, (y, t) in sorted(out[dim].items(), key=lambda kv: -kv[1][1]):
            print(f"  {k:<28} {y:>3}/{t:<3} yes  {100 * y / t:>3.0f}%")
    print('\nno by blocker kind (a file counts once per kind):', dict(out['no_by_kind']))
    print('no by kind/scope:', dict(out['no_by_kind_scope'].most_common()))
    print('no with a single cause:', dict(out['no_single_cause']))
    for name in ('ways_core', 'ways_doc_kind', 'ways_class'):
        print(f"\n{name}: {out[name]}")
    print('\nyes verdicts resting on a way no other zip used:', out['yes_resting_on_a_singleton_way'], 'of', len(yes))
    print('top ways:', out['top_ways'][:15])


if __name__ == '__main__':
    main()
