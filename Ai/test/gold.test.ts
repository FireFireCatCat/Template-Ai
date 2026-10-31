/**
 * Gold: a Solution file read into a target document, the research's answer
 * kept beside each key and never inside it.
 */
import assert from 'node:assert/strict';
import { join } from 'node:path';
import { test } from 'node:test';

import { flouestRoot } from '../../Latex-Lib/flouest.ts';
import { loadLibrary } from '../../Latex-Lib/library.ts';
import { readNesting } from '../../Latex-Lib/nesting.ts';

import { checkTarget } from '../src/check.ts';
import { goldContext, readGold, readSolution, targetOf } from '../src/gold.ts';
import { folder } from './fixtures.ts';

const lib = join(import.meta.dirname, '..', '..', 'Latex-Lib');
const { library } = await loadLibrary(lib);
const nesting = readNesting(flouestRoot(lib));
const context = goldContext(library);

const solution = (classLine: string, origin: string, rows: string[]): string =>
  [
    'yes',
    '',
    '# 0999-demo: Demo',
    '',
    `- Class origin: ${origin}`,
    '- Main file: main.tex (other samples: none)',
    '',
    '## Class setting',
    `- Class: ${classLine}`,
    '',
    '## Component map',
    '| Component | Evidence | Way | Parameters |',
    '|---|---|---|---|',
    ...rows,
    '',
    '## Bespoke code',
    '| Item | Where | Reducible? | Reduction |',
    '|---|---|---|---|',
    '| macro | main.tex:3 | no | `thm.amsthm` is not it |',
  ].join('\n');

const read = (text: string) => readGold(readSolution(join(folder({ '0999-demo.md': text }, 'Solution'), '0999-demo.md')), library, context);

const ROWS = [
  '| class | main.tex:1 | `class.article` | 11pt |',
  '| theorems | main.tex:5 | `thm.amsthm` | `amsthm`, style plain (as `thm.amsthm` does) |',
  '| more theorems | main.tex:9 | `thm.amsthm` | `\\newtheorem{lemma}` |',
  '| citations | main.tex:7 | `bib.natbib` | `natbib`, round |',
  '| flush | main.tex:8 | `NEW:pg.flushy` | `\\flushbottom` |',
  '| fonts | main.tex:2 | `font.lmodern` | Latin Modern |',
];

test('each way in a row gives a key of each node the way serves, its answer beside it; repeated rows merge their evidence', () => {
  const gold = read(solution('`class.article` options: `11pt`', 'tex-distribution-unbundled', ROWS));
  assert.deepEqual(
    gold.nodes.map((g) => [g.key.node, g.answer]),
    [
      ['containerBlock/mathElement', { way: 'thm.amsthm' }],
      ['cite/cite', { way: 'bib.natbib' }],
      ['containerBlock/refContainer', { way: 'bib.natbib' }],
      ['atomicBlock/pageBreak', { way: null, named: 'pg.flushy' }],
    ],
  );
  const theorem = gold.nodes[0]?.key;
  assert.deepEqual(theorem?.evidence.map((e) => ('lines' in e ? e.lines : '')), ['15', '16']);
  assert.deepEqual(theorem?.packages, [{ pkg: 'amsthm' }]);
  assert.deepEqual(gold.document.map((g) => [g.key.node, g.answer]), [['doc', { way: null, named: 'font.lmodern' }]]);
});

test('no answer reaches a key: way ids leave the descriptions, and the search gets the keys alone', () => {
  const gold = read(solution('`class.article` options: `11pt`', 'tex-distribution-unbundled', ROWS));
  const target = targetOf(gold);
  const text = JSON.stringify(target);
  assert.equal(text.includes('thm.amsthm'), false);
  assert.equal(text.includes('bib.natbib'), false);
  assert.equal(text.includes('"answer"'), false);
  assert.match(target.nodes[0]?.description ?? '', /^theorems: `amsthm`, style plain \(as does\); more theorems: `\\newtheorem\{lemma\}`$/u);
  assert.deepEqual(checkTarget(target, library, nesting), []);
});

test('a published class is named as the template names it, and its profile is the answer', () => {
  const ieee = read(solution('`class.ieeetran` options: `conference`', 'publisher-official', ROWS));
  assert.deepEqual([ieee.class.key.name, ieee.class.key.options, ieee.class.answer], ['IEEEtran', ['conference'], { id: 'class.ieeetran', base: null }]);
  const unknown = read(solution('`class.fancyclass` options: `12pt`', 'ctan', ROWS));
  assert.deepEqual([unknown.class.key.name, unknown.class.answer], ['fancyclass', { id: null, base: null }]);
});

test('a class the template ships is named, with what it loads; the answer is the profile it builds on', () => {
  const gold = read(solution('`class.article` (loaded by the zip-local `demo` at demo.cls:3) options: `11pt`, `a4paper`', 'zip-local', ROWS));
  assert.deepEqual(gold.class.key.local, { file: 'demo.cls', loads: 'article' });
  assert.deepEqual([gold.class.key.name, gold.class.key.options, gold.class.answer], ['demo', ['11pt', 'a4paper'], { id: null, base: 'class.article' }]);
  assert.match(gold.class.key.description, /^`article` \(loaded by the zip-local `demo`/u);
});
