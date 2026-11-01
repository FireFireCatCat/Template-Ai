/**
 * The AI layer's commands (ARCHITECTURE.md section 9).
 *
 *   node src/cli.ts gold        every Solution file as a target document with its answers, checked; written to out/gold/
 *   node src/cli.ts embed       the library's descriptions as vectors, written to Latex-Lib/embeddings.generated.json
 *   node src/cli.ts evaluate    the search on every gold target, without its answers, scored against them; written to out/evaluate/
 *                               (with the embeddings when they are current; --no-embeddings for the search without them)
 */
import { mkdirSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

import { checkEmbeddings, EMBEDDINGS_FILE, embeddingTexts, readEmbeddings, textHash, type EmbeddingsFile } from '../../Latex-Lib/embeddings.ts';
import { flouestRoot } from '../../Latex-Lib/flouest.ts';
import { loadLibrary } from '../../Latex-Lib/library.ts';
import { readNesting } from '../../Latex-Lib/nesting.ts';

import { checkTarget } from './extract/check.ts';
import { goldContext, readGold, readSolution, solutionPaths, targetOf } from './evaluate/gold.ts';
import { newTally, renderTally, scoreOutcome } from './evaluate/tally.ts';
import { cachedEmbedder, descriptionSimilarity, encodeVector, localEmbedder, MODEL_ID, vectorCache } from './search/embed.ts';
import { runSearch, searchContext } from './pipeline.ts';
import { renderReport } from './search/report.ts';

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
} else if (command === 'embed') {
  const { library } = await loadLibrary(lib);
  const texts = embeddingTexts(library);
  const embedder = cachedEmbedder(await localEmbedder(join(ai, '.cache', 'models')), vectorCache(ai, MODEL_ID));
  const vectors = await embedder.embed(texts.map((t) => t.text));
  embedder.save();
  const file: EmbeddingsFile = { model: MODEL_ID, dimensions: vectors[0]?.length ?? 0, entries: texts.map((t, i) => ({ id: t.id, hash: textHash(t.text), vector: encodeVector(vectors[i]!) })) };
  writeFileSync(join(lib, EMBEDDINGS_FILE), `${JSON.stringify(file, null, 1)}\n`);
  console.log(`embed: ${file.entries.length} library descriptions, ${file.dimensions} dimensions, ${MODEL_ID}; written to Latex-Lib/${EMBEDDINGS_FILE}`);
} else if (command === 'evaluate') {
  const { library } = await loadLibrary(lib);
  const nesting = readNesting(flouestRoot(lib));
  const context = goldContext(library);
  const golds = solutionPaths().map((path) => readGold(readSolution(path), library, context));
  // The embeddings when they are current and asked for: every key's and class's description, made before the search.
  let description: Parameters<typeof searchContext>[2];
  const libraryVectors = readEmbeddings(lib);
  if (!process.argv.includes('--no-embeddings')) {
    const stale = checkEmbeddings(lib, library);
    if (stale.length > 0 || libraryVectors === undefined || libraryVectors.model !== MODEL_ID) throw new Error(`evaluate: ${stale[0] ?? `the embeddings are not ${MODEL_ID}'s`}; run npm run embed, or pass --no-embeddings`);
    const embedder = cachedEmbedder(await localEmbedder(join(ai, '.cache', 'models')), vectorCache(ai, MODEL_ID));
    const texts = [...new Set(golds.flatMap((g) => [g.class.key.description, ...g.nodes.map((n) => n.key.description)]).filter((t) => t.trim() !== ''))];
    const vectors = await embedder.embed(texts);
    embedder.save();
    description = { similarity: descriptionSimilarity(libraryVectors, new Map(texts.map((t, i) => [t, vectors[i]!]))), embedder: MODEL_ID };
  }
  const search = searchContext(library, nesting, description);
  const out = join(ai, 'out', 'evaluate');
  mkdirSync(join(out, 'reports'), { recursive: true });
  const tally = newTally();
  for (const gold of golds) {
    const outcome = runSearch(targetOf(gold), search);
    scoreOutcome(tally, gold, outcome);
    if ('report' in outcome) {
      writeFileSync(join(out, 'reports', `${gold.source.id}.json`), `${JSON.stringify(outcome.report, null, 2)}\n`);
      writeFileSync(join(out, 'reports', `${gold.source.id}.md`), renderReport(outcome.report));
    }
  }
  const summary = renderTally(tally, `The search on gold (weights ${search.scoring.weights.version}, embedder ${search.embedder ?? 'none'})`);
  writeFileSync(join(out, 'summary.md'), summary);
  writeFileSync(join(out, 'summary.json'), `${JSON.stringify(tally, null, 2)}\n`);
  console.log(summary);
} else {
  console.error('Usage: node src/cli.ts gold | embed | evaluate [--no-embeddings]');
  process.exitCode = 1;
}
