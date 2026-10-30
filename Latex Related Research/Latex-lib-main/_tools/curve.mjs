// Node port of curve.py: does the lib stop growing? Reads Solution/*.md in id order.
//
//   node curve.mjs [--window 50]
//
// For each window of zips: how many distinct ways have been used so far, and how many of those were first
// used in this window. Ways are the backticked ids of the Component map tables. Class ways (class.*) are
// counted apart from component ways, because a new publisher class is expected to keep appearing while the
// question for packages is whether they saturate. Also yes-rate by source and by kind from the manifest.
import path from 'node:path';
import { CORE, SOL, WAY, manifest, read, rejectedWays, section, solutionFiles } from './common.mjs';

const FILE_EXT = new Set(['tex', 'cls', 'sty', 'bst', 'dtx', 'ins', 'bib', 'cfg', 'def', 'clo', 'md', 'txt', 'sh', 'py', 'pdf', 'png', 'json', 'yml', 'ist', 'lco', 'csv', 'ldf']);
const REJECTED = rejectedWays();
const man = manifest();
const argv = process.argv.slice(2);
const windowSize = argv.includes('--window') ? parseInt(argv[argv.indexOf('--window') + 1], 10) : 50;

const files = solutionFiles();
const seenC = new Set(), seenK = new Set(), seenD = new Set();
console.log(`${files.length} solutions; window ${windowSize}`);
console.log(`${'zips'.padStart(6)} ${'core ways'.padStart(10)} ${'new'.padStart(5)} ${'doc-kind'.padStart(9)} ${'new'.padStart(5)} ${'class'.padStart(6)} ${'new'.padStart(5)} ${'yes%'.padStart(6)}`);
let winC = 0, winK = 0, winD = 0, yes = 0;
const stats = new Map();   // "dim\tname" -> [yes, n]
const bump = (dim, name, isYes) => { const k = dim + '\t' + name; const s = stats.get(k) || [0, 0]; s[0] += isYes; s[1] += 1; stats.set(k, s); };
files.forEach((fn, idx) => {
  const i = idx + 1;
  const text = read(path.join(SOL, fn));
  const isYes = text.split('\n', 1)[0].trim() === 'yes' ? 1 : 0;
  yes += isYes;
  const m = man[fn.slice(0, -3)] || {};
  bump('source', m.source || '?', isYes);
  bump('kind', m.kind || '?', isYes);
  for (let w of new Set([...(section(text, '## Component map') + '\n' + section(text, '## Class setting')).matchAll(WAY)].map((x) => x[1]))) {
    w = w.replace('NEW:', '');
    if (FILE_EXT.has(w.split('.').pop().toLowerCase()) || w.includes(':')) continue;
    if (REJECTED.has(w)) continue;
    if (w.startsWith('class.')) { if (!seenK.has(w)) { seenK.add(w); winK++; } }
    else if (CORE.has(w.split('.')[0])) { if (!seenC.has(w)) { seenC.add(w); winC++; } }
    else if (!seenD.has(w)) { seenD.add(w); winD++; }
  }
  if (i % windowSize === 0 || i === files.length) {
    console.log(`${String(i).padStart(6)} ${String(seenC.size).padStart(10)} ${String(winC).padStart(5)} ${String(seenD.size).padStart(9)} ${String(winD).padStart(5)} ${String(seenK.size).padStart(6)} ${String(winK).padStart(5)} ${String(Math.round((100 * yes) / i)).padStart(5)}%`);
    winC = winK = winD = 0;
  }
});
console.log();
for (const dim of ['source', 'kind']) {
  console.log(`yes-rate by ${dim}:`);
  for (const [k, [y, n]] of [...stats].sort((a, b) => b[1][1] - a[1][1])) {
    const [d, name] = k.split('\t');
    if (d === dim) console.log(`  ${name.padEnd(14)} ${String(y).padStart(4)}/${String(n).padEnd(4)} ${String(Math.round((100 * y) / n)).padStart(4)}%`);
  }
}
