// Node port of batch_items.py: print the workflow ids for a range, skipping zips that already have a solution file.
//
//   node batch_items.mjs 406 505              # ids 0406..0505 inclusive, as compact JSON of ids
//   node batch_items.mjs 406 505 --all        # include zips that already have a solution
//   node batch_items.mjs --pick 0434,0440     # exactly these numbers
//   node batch_items.mjs --missing            # every id with no solution file yet
//   node batch_items.mjs --missing --take 70  # the first 70 of those
//
// Prints a JSON array of id strings on stdout; the counts go to stderr.
import fs from 'node:fs';
import { SOL, manifest } from './common.mjs';

const argv = process.argv.slice(2);
const rows = Object.values(manifest());
const have = new Set(fs.readdirSync(SOL).filter((f) => f.endsWith('.md')).map((f) => f.slice(0, -3)));
const num = (r) => parseInt(r.id.split('-')[0], 10);
let chosen;
if (argv.includes('--pick')) {
  const want = new Set(argv[argv.indexOf('--pick') + 1].split(','));
  chosen = rows.filter((r) => want.has(r.id.split('-')[0]));
} else if (argv.includes('--missing')) {
  chosen = rows;
} else {
  const lo = parseInt(argv[0], 10), hi = parseInt(argv[1], 10);
  chosen = rows.filter((r) => num(r) >= lo && num(r) <= hi);
}
let skipped = 0;
let ids = [];
for (const r of chosen) {
  if (have.has(r.id) && !argv.includes('--all')) { skipped++; continue; }
  ids.push(r.id);
}
if (argv.includes('--take')) ids = ids.slice(0, parseInt(argv[argv.indexOf('--take') + 1], 10));
console.error(`${ids.length} ids, ${skipped} skipped (already have a solution)`);
console.log(JSON.stringify(ids));
