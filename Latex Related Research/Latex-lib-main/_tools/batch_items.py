"""Print the workflow `items` for a range of ids, skipping zips that already have a solution file.

    python3 -I batch_items.py 25 125            # ids 0025..0125 inclusive, as compact JSON
    python3 -I batch_items.py 25 125 --all      # include zips that already have a solution
    python3 -I batch_items.py --pick 0034,0040  # exactly these numbers

Also prints, to stderr, how many were skipped and the ids of every zip in the range.
"""
import csv, json, os, sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)


def main():
    rows = list(csv.DictReader(open(os.path.join(ROOT, '_Manifest.tsv'), encoding='utf8'), delimiter='\t', quoting=csv.QUOTE_NONE))
    have = {f[:-3] for f in os.listdir(os.path.join(ROOT, 'Solution')) if f.endswith('.md')}
    if '--pick' in sys.argv:
        want = set(sys.argv[sys.argv.index('--pick') + 1].split(','))
        chosen = [r for r in rows if r['id'].split('-')[0] in want]
    else:
        lo, hi = int(sys.argv[1]), int(sys.argv[2])
        chosen = [r for r in rows if lo <= int(r['id'].split('-')[0]) <= hi]
    skipped = 0
    items = []
    for r in chosen:
        if r['id'] in have and '--all' not in sys.argv:
            skipped += 1
            continue
        items.append({'id': r['id'], 'origin': r['url'], 'license': r['license'], 'kindHint': r['kind']})
    print(f'{len(items)} items, {skipped} skipped (already have a solution)', file=sys.stderr)
    print(json.dumps(items, separators=(',', ':')))


if __name__ == '__main__':
    main()
