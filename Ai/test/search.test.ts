/**
 * The search end to end on a small target document, and its evaluation
 * against gold: the class found, a handler per node, the report, the tally.
 */
import assert from 'node:assert/strict';
import { join } from 'node:path';
import { test } from 'node:test';

import { flouestRoot } from '../../Latex-Lib/flouest.ts';
import { loadLibrary } from '../../Latex-Lib/library.ts';
import { readNesting } from '../../Latex-Lib/nesting.ts';

import { newTally, scoreOutcome } from '../src/evaluate/tally.ts';
import type { Gold } from '../src/evaluate/gold.ts';
import type { TargetDocument } from '../src/model.ts';
import { runSearch, searchContext } from '../src/pipeline.ts';
import { renderReport } from '../src/search/report.ts';

const lib = join(import.meta.dirname, '..', '..', 'Latex-Lib');
const { library } = await loadLibrary(lib);
const search = searchContext(library, readNesting(flouestRoot(lib)));
const evidence = [{ kind: 'solution' as const, file: 'Solution/0999-demo.md', lines: '1' }];

const target: TargetDocument = {
  source: { id: 'demo', files: [] },
  class: { name: 'article', options: [], description: '', evidence },
  nodes: [
    { node: 'table', features: [], params: {}, packages: [{ pkg: 'booktabs' }], description: 'three rules', evidence, confidence: 'high' },
    { node: 'containerBlock/mathElement', features: [], params: {}, packages: [{ pkg: 'tcolorbox' }], description: 'boxed theorems', evidence, confidence: 'medium' },
  ],
  document: [],
};

test('a target document gets its class, a handler per node, and a report saying why', () => {
  const outcome = runSearch(target, search);
  assert.ok(!('problems' in outcome));
  assert.deepEqual([outcome.cls.tier, outcome.cls.profile], ['exact', 'class.article']);
  const chosen = Object.fromEntries(outcome.selection.nodes.map((n) => [n.node, n.chosen?.way]));
  assert.equal(chosen.table, 'tbl.booktabs');
  assert.match(chosen['containerBlock/mathElement'] ?? '', /tcolorbox/u);
  const md = renderReport(outcome.report);
  assert.match(md, /\*\*Class:\*\* article → class\.article \(exact\)/u);
  assert.match(md, /`tbl\.booktabs`.*packages 1\.00/u);
});

test('a document the check refuses goes no further', () => {
  const outcome = runSearch({ ...target, nodes: [{ ...target.nodes[0]!, node: 'nope' }] }, search);
  assert.ok('problems' in outcome && outcome.problems.length === 1);
});

test('the tally counts the class, each key\'s rank, and the choice against the answers', () => {
  const gold: Gold = {
    source: target.source,
    class: { key: target.class, answer: { id: 'class.article', base: null } },
    nodes: [
      { key: target.nodes[0]!, answer: { way: 'tbl.booktabs' } },
      { key: target.nodes[1]!, answer: { way: null, named: 'thm.unknown' } },
    ],
    document: [],
  };
  const tally = newTally();
  scoreOutcome(tally, gold, runSearch(target, search));
  assert.deepEqual([tally.class.right, tally.class.scored], [1, 1]);
  assert.deepEqual([tally.keys.all.scored, tally.keys.all.top1, tally.keys.lacking], [1, 1, 1]);
  assert.deepEqual([tally.select.right, tally.select.scored], [1, 1]);
});
