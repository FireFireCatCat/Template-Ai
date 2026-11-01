/**
 * Choosing together: the best total that resolves, General's way when
 * nothing goes, and why a node's best option was passed over.
 */
import assert from 'node:assert/strict';
import { join } from 'node:path';
import { test } from 'node:test';

import { loadLibrary } from '../../Latex-Lib/library.ts';

import { matchClass } from '../src/search/classes.ts';
import type { Candidate } from '../src/search/score.ts';
import { selectTogether } from '../src/search/select.ts';

const { library } = await loadLibrary(join(import.meta.dirname, '..', '..', 'Latex-Lib'));
const article = matchClass({ name: 'article', options: [], description: '', evidence: [] }, library);
const option = (node: string, way: string, score: number): Candidate => ({ node, way, preset: null, params: {}, score, terms: {} });

test('the best options that go together win: natbib citations take the natbib bibliography over a better-scored biblatex', () => {
  const s = selectTogether(
    [
      { node: 'containerBlock/refContainer', keys: [0], options: [option('containerBlock/refContainer', 'bib.biblatex-biber', 2), option('containerBlock/refContainer', 'bib.natbib', 1.5)] },
      { node: 'cite/cite', keys: [1], options: [option('cite/cite', 'bib.natbib', 3), option('cite/cite', 'bib.biblatex-biber', 0.5)] },
    ],
    article,
    library,
  );
  assert.deepEqual(s.nodes.map((n) => [n.node, n.chosen?.way, n.how]), [['cite/cite', 'bib.natbib', 'best'], ['containerBlock/refContainer', 'bib.natbib', 'together']]);
  assert.deepEqual(s.nodes[1]?.whyNotBest, ['bib.natbib: needs package natbib']);
  assert.deepEqual([s.total, s.complete], [4.5, true]);
});

test('a node whose options never resolve keeps General\'s way', () => {
  const s = selectTogether([{ node: 'cite/cite', keys: [0], options: [option('cite/cite', 'bib.natbib', 3)] }], article, library);
  assert.deepEqual(s.nodes.map((n) => [n.chosen, n.how]), [[null, 'general']]);
});
