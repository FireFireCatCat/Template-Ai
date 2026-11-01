/**
 * The score: each term between 0 and 1, by the parameter's type for values,
 * a rare feature weighing more, and a term the key says nothing about absent.
 */
import assert from 'node:assert/strict';
import { join } from 'node:path';
import { test } from 'node:test';

import { loadLibrary } from '../../Latex-Lib/library.ts';
import type { Feature } from '../../Latex-Lib/schema/features.ts';

import { featureWeights, score, valueSimilarity, type Scoring } from '../src/search/score.ts';
import { WEIGHTS } from '../src/search/weights.ts';
import type { TargetKey } from '../src/model.ts';

const { library } = await loadLibrary(join(import.meta.dirname, '..', '..', 'Latex-Lib'));
const scoring: Scoring = { weights: WEIGHTS, featureWeight: featureWeights(library) };
const amsthm = library.keys.find((k) => k.id === 'thm.amsthm')!;
const key = (over: Partial<TargetKey>): TargetKey => ({ node: 'containerBlock/mathElement', features: [], params: {}, packages: [], description: '', evidence: [], confidence: 'high', ...over });

test('values are compared by their type: lengths in points, colours as colours, words by the words they share', () => {
  assert.equal(valueSimilarity({ type: 'dimen', description: '' }, '10pt', '1em'), 1);
  assert.equal(valueSimilarity({ type: 'dimen', description: '' }, '6pt', '12pt'), 0.5);
  assert.equal(valueSimilarity({ type: 'color', description: '' }, 'red', 'red!100'), 1);
  assert.ok(Math.abs(valueSimilarity({ type: 'color', description: '' }, 'black', 'white')) < 1e-9);
  assert.ok(valueSimilarity({ type: 'color', description: '' }, 'blue', 'blue!50') > 0.5);
  assert.equal(valueSimilarity({ type: 'enum', values: ['a', 'b'], description: '' }, 'a', 'b'), 0);
  assert.equal(valueSimilarity({ type: 'string', description: '' }, 'bold italic', 'bold upright'), 1 / 3);
  assert.equal(valueSimilarity({ type: 'number', description: '' }, 2, undefined), 0);
});

test('a rarer feature weighs more', () => {
  const weight = featureWeights(library);
  const counts = new Map<Feature, number>();
  for (const k of library.keys) for (const f of k.features) counts.set(f, (counts.get(f) ?? 0) + 1);
  const [common, rare] = [...counts].sort((a, b) => b[1] - a[1]).filter((_, i, all) => i === 0 || i === all.length - 1);
  assert.ok((weight.get(rare![0]) ?? 0) > (weight.get(common![0]) ?? 0));
});

test('a key that says nothing scores nothing, and has no term at all', () => {
  const c = score(key({}), amsthm, null, {}, scoring);
  assert.deepEqual([c.score, c.terms], [0, {}]);
});

test('packages count as the share of the key\'s packages the handler loads; a parameter the handler lacks counts 0', () => {
  const c = score(key({ packages: [{ pkg: 'amsthm' }, { pkg: 'tcolorbox' }], params: { style: 'plain', colour: 'red' } }), amsthm, null, {}, scoring);
  assert.equal(c.terms.packages, 0.5);
  assert.equal(c.terms.params, 0.5 * (amsthm.params.style?.default === 'plain' ? 1 : 0));
  assert.equal(c.score, Math.round(((c.terms.packages ?? 0) * WEIGHTS.packages + (c.terms.params ?? 0) * WEIGHTS.params) * 1e6) / 1e6);
});

test('the description term is the similarity it is given, against the preset and the handler', () => {
  const asked: string[][] = [];
  const c = score(key({ description: 'bold heads' }), amsthm, 'plain', {}, { ...scoring, description: (_, entries) => (asked.push([...entries]), 0.8) });
  assert.deepEqual(asked, [['handler:containerBlock/mathElement:thm.amsthm', 'preset:containerBlock/mathElement:thm.amsthm:plain']]);
  assert.deepEqual([c.terms.description, c.score], [0.8, 0.8 * WEIGHTS.description]);
});
