/**
 * The AI layer's commands (ARCHITECTURE.md section 9).
 *
 *   node src/cli.ts gold    every Solution file as a target document with its answers, checked; written to out/gold/
 */
import { mkdirSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

import { flouestRoot } from '../../Latex-Lib/flouest.ts';
import { loadLibrary } from '../../Latex-Lib/library.ts';
import { readNesting } from '../../Latex-Lib/nesting.ts';

import { checkTarget } from './check.ts';
import { goldContext, readGold, readSolution, solutionPaths, targetOf } from './gold.ts';

const ai = join(dirname(fileURLToPath(import.meta.url)), '..');
const lib = join(ai, '..', 'Latex-Lib');
const [command] = process.argv.slice(2);

const pct = (n: number, of: number): string => `${n}/${of} (${of === 0 ? 0 : Math.round((1000 * n) / of) / 10}%)`;

if (command === 'gold') {
  const { library } = await loadLibrary(lib);
  const nesting = readNesting(flouestRoot(lib));
  const context = goldContext(library);
  const out = join(ai, 'out', 'gold');
  mkdirSync(out, { recursive: true });
  const problems: string[] = [];
  const count = { valid: 0, keys: 0, inLibrary: 0, withPackages: 0, document: 0, profiled: 0, shipped: 0 };
  const paths = solutionPaths();
  for (const path of paths) {
    const gold = readGold(readSolution(path), library, context);
    const found = checkTarget(targetOf(gold), library, nesting);
    if (found.length === 0) count.valid++;
    problems.push(...found);
    count.keys += gold.nodes.length;
    count.inLibrary += gold.nodes.filter((g) => g.answer.way !== null).length;
    count.withPackages += gold.nodes.filter((g) => g.key.packages.length > 0).length;
    count.document += gold.document.length;
    if (gold.class.answer.id !== null || gold.class.answer.base !== null) count.profiled++;
    if (gold.class.key.local !== undefined) count.shipped++;
    writeFileSync(join(out, `${gold.source.id}.json`), `${JSON.stringify(gold, null, 2)}\n`);
  }
  console.log(`gold: ${pct(count.valid, paths.length)} Solution files read into a valid target document; written to ${out}`);
  console.log(`  node keys: ${count.keys}; the answer is a library way for ${count.inLibrary}, a way the library lacks for ${count.keys - count.inLibrary}`);
  console.log(`  node keys naming a package the library knows: ${count.withPackages}`);
  console.log(`  document-level keys: ${count.document}`);
  console.log(`  classes: the answer is a profile (the class's or its base's) for ${count.profiled}; ${count.shipped} templates ship their own class`);
  for (const p of problems.slice(0, 40)) console.log(`  ${p}`);
  if (problems.length > 0) {
    console.log(`gold: ${problems.length} problem(s)`);
    process.exitCode = 1;
  }
} else {
  console.error('Usage: node src/cli.ts gold');
  process.exitCode = 1;
}
