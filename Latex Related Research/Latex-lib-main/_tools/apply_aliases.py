"""Replace provisional NEW:<id> ways in Solution/*.md with the ids the consolidator settled on.

    python3 -I apply_aliases.py alias/<batch>.json [--dry]

Also rewrites plain (backticked, no NEW:) ids that an earlier consolidation merged into
another way, from alias/renames.json ({"font.opensans": "font.helvet", ...}), but only
where the old id is not itself a line of _Lib.md.

The alias map is {"NEW:<provisional>": "<canonical id>" | null}. A null means the
consolidator rejected the proposed way (it failed W1 to W4); the provisional id
is left in place and every file that still holds one is listed, because that
zip's verdict has to be re-checked. Prints the files changed and the files with
a rejected or unknown NEW: id.
"""
import json, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
SOL = os.path.join(ROOT, 'Solution')


def lib_ids():
    ids = set()
    for line in open(os.path.join(ROOT, '_Lib.md'), encoding='utf8'):
        m = re.match(r'\|\s*`([^`]+)`', line)
        if m:
            ids.add(m.group(1))
    return ids


def main():
    alias = json.load(open(sys.argv[1], encoding='utf8'))
    rpath = os.path.join(HERE, 'alias', 'renames.json')
    renames = json.load(open(rpath, encoding='utf8')) if os.path.exists(rpath) else {}
    known = lib_ids()
    renames = {k: v for k, v in renames.items() if k not in known}
    dry = '--dry' in sys.argv
    changed, unresolved = [], {}
    for fn in sorted(os.listdir(SOL)):
        if not fn.endswith('.md'):
            continue
        path = os.path.join(SOL, fn)
        text = open(path, encoding='utf8').read()
        new = text

        def sub(m):
            key = m.group(0)
            target = alias.get(key)
            return target if target else key

        new = re.sub(r'NEW:[a-z][a-z0-9-]*\.[a-z0-9][a-z0-9+_.:-]*', sub, text)
        plain = {(k[4:] if k.startswith('NEW:') else k): v for k, v in alias.items() if v}  # the bare id too: prose and other tables write it without NEW:
        if plain:
            new = re.sub(r'`([a-z][a-z0-9-]*\.[a-z0-9][a-z0-9+_.:-]*)`', lambda m: '`' + plain.get(m.group(1), m.group(1)) + '`', new)
        if renames:
            new = re.sub(r'`([a-z][a-z0-9-]*\.[a-z0-9][a-z0-9+_.:-]*)`', lambda m: '`' + renames.get(m.group(1), m.group(1)) + '`', new)
        if new != text:
            changed.append(fn)
            if not dry:
                open(path, 'w', encoding='utf8').write(new)
        left = sorted(set(re.findall(r'NEW:[a-z][a-z0-9-]*\.[a-z0-9][a-z0-9+_.:-]*', new)))
        if left:
            unresolved[fn[:-3]] = left
    print(f'{len(changed)} files rewritten{" (dry run)" if dry else ""}')
    for sid, left in unresolved.items():
        print(f'  still provisional in {sid}: {", ".join(left)}')


if __name__ == '__main__':
    main()
