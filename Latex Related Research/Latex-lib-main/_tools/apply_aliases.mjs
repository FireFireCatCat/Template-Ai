// Node port of apply_aliases.py: replace provisional NEW:<id> ways in Solution/*.md with the ids the
// consolidator settled on.
//
//   node apply_aliases.mjs alias/<batch>.json [--dry]
//
// Also rewrites plain (backticked, no NEW:) ids that an earlier consolidation merged into another way, from
// alias/renames.json ({"font.opensans": "font.helvet", ...}), but only where the old id is not itself a line
// of _Lib.md.
//
// The alias map is {"NEW:<provisional>": "<canonical id>" | null}. A null means the consolidator rejected
// the proposed way (it failed W1 to W4); the provisional id is left in place and every file that still holds
// one is listed, because that zip's verdict has to be re-checked.
import fs from 'node:fs';
import path from 'node:path';
import { HERE, NEW_ID, SOL, libIds, read, solutionFiles } from './common.mjs';

const aliasPath = process.argv[2];
const alias = JSON.parse(read(path.resolve(aliasPath)));
const rpath = path.join(HERE, 'alias', 'renames.json');
const known = libIds();
const renames = Object.fromEntries(Object.entries(fs.existsSync(rpath) ? JSON.parse(read(rpath)) : {}).filter(([k]) => !known.has(k)));
const dry = process.argv.includes('--dry');
const PLAIN = /`([a-z][a-z0-9-]*\.[a-z0-9][a-z0-9+_.:-]*)`/g;
const plain = Object.fromEntries(Object.entries(alias).filter(([, v]) => v).map(([k, v]) => [k.startsWith('NEW:') ? k.slice(4) : k, v]));   // the bare id too: prose and other tables write it without NEW:
const changed = [], unresolved = {};
for (const fn of solutionFiles()) {
  const p = path.join(SOL, fn);
  const text = read(p);
  let next = text.replace(NEW_ID, (key) => alias[key] || key);
  if (Object.keys(plain).length) next = next.replace(PLAIN, (m, id) => '`' + (plain[id] || id) + '`');
  if (Object.keys(renames).length) next = next.replace(PLAIN, (m, id) => '`' + (renames[id] || id) + '`');
  if (next !== text) {
    changed.push(fn);
    if (!dry) fs.writeFileSync(p, next, 'utf8');
  }
  const left = [...new Set(next.match(NEW_ID) || [])].sort();
  if (left.length) unresolved[fn.slice(0, -3)] = left;
}
console.log(`${changed.length} files rewritten${dry ? ' (dry run)' : ''}`);
for (const [sid, left] of Object.entries(unresolved)) console.log(`  still provisional in ${sid}: ${left.join(', ')}`);
