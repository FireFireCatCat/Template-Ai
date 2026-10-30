/**
 * The oracle on logs written by hand in TeX's shapes: each of the four checks,
 * what is tied to a branch and what to the document, and an engine that gave
 * nothing.
 */
import assert from 'node:assert/strict';
import { test } from 'node:test';

import { judge, type Expected } from '../src/oracle.ts';
import type { Emitted, RawResult } from '../src/model.ts';

const PT = 65536;
const GEOMETRY = [
  ['paperWidth', 612],
  ['paperHeight', 792],
  ['oddLeft', 90],
  ['evenLeft', 90],
  ['textWidth', 432],
  ['textTop', 700],
  ['textHeight', 600],
]
  .map(([name, pt]) => `COMPAT-GEOMETRY{${name}}{${pt}pt}`)
  .join('\n');

const hit = (id: string, page = 1, x = 100, y = 600) => `COMPAT-SENTINEL{${id}}{${page}}{${x * PT}}{${y * PT}}`;

/** Two branches: A on lines 10 to 19, B on lines 20 to 29. */
const emitted: Emitted = {
  latex: Array.from({ length: 40 }, (_, i) => `line ${i + 1}`).join('\n'),
  spans: [
    { branch: 'A', from: 10, to: 19 },
    { branch: 'B', from: 20, to: 29 },
  ],
  files: [],
};

const expected = (a: Partial<Expected> = {}, b: Partial<Expected> = {}): Expected[] => [
  { branch: 'A', sentinels: [{ id: 'A.0' }], features: [], ...a },
  { branch: 'B', sentinels: [{ id: 'B.0' }], features: [], ...b },
];

const result = (...lines: string[]): RawResult => ({ log: [GEOMETRY, ...lines, 'Output written on main.xdv (1 page, 9 bytes).'].join('\n'), pages: null, ms: 1 });

const checksOf = (judgement: ReturnType<typeof judge>) =>
  Object.fromEntries(judgement.verdicts.map((v) => [v.branch, v.failures.map((f) => f.check)]));

test('a clean log passes every branch', () => {
  const judgement = judge({ cell: 'c1', emitted, result: result(hit('A.0'), hit('B.0')), expected: expected() });
  assert.deepEqual(checksOf(judgement), { A: [], B: [] });
  assert.ok(judgement.verdicts.every((v) => v.pass && v.cell === 'c1'));
});

test('an error inside a branch fails that branch only; one outside every branch fails the document', () => {
  const inA = judge({ cell: 'c', emitted, result: result('! LaTeX Error: Not in outer par mode.', '', 'l.12 \\begin{figure}', hit('A.0'), hit('B.0')), expected: expected() });
  assert.deepEqual(checksOf(inA), { A: ['error'], B: [] });
  assert.match(inA.verdicts[0]?.failures[0]?.evidence ?? '', /Not in outer par mode\. \(l\.12\)/);

  const inPreamble = judge({ cell: 'c', emitted, result: result('! Undefined control sequence.', 'l.3 \\foo', hit('A.0'), hit('B.0')), expected: expected() });
  assert.deepEqual(checksOf(inPreamble), { A: ['error:document'], B: ['error:document'] });
  assert.equal(inPreamble.document.length, 1);
});

test('damaging warnings fail the branch whose line they name; harmless ones fail nothing', () => {
  const judgement = judge({
    cell: 'c',
    emitted,
    result: result(
      "LaTeX Warning: Reference `nowhere' on page 1 undefined on input line 22.",
      "LaTeX Font Warning: Font shape `TU/lmr/m/sc' undefined",
      '(Font)              using `TU/lmr/m/n\' instead on input line 12.',
      'Overfull \\hbox (150.2pt too wide) in paragraph at lines 14--14',
      'Overfull \\hbox (2.1pt too wide) in paragraph at lines 24--24',
      hit('A.0'),
      hit('B.0'),
    ),
    expected: expected(),
  });
  assert.deepEqual(checksOf(judgement), { A: ['warning:overfull-hbox'], B: ['warning:undefined-reference'] });
});

test('a page that overflowed or a missing glyph belongs to the document', () => {
  const judgement = judge({
    cell: 'c',
    emitted,
    result: result(
      'Overfull \\vbox (312.0pt too high) has occurred while \\output is active',
      'Missing character: There is no ☃ (U+2603) in font lmroman10-regular!',
      hit('A.0'),
      hit('B.0'),
    ),
    expected: expected(),
  });
  assert.deepEqual(checksOf(judgement).A, ['warning:page-overflow:document', 'warning:missing-character:document']);
});

test('a sentinel lost, shipped twice, or outside the text block fails its branch', () => {
  const judgement = judge({
    cell: 'c',
    emitted,
    result: result(hit('A.0'), hit('A.0', 2), hit('B.0', 1, 560, 600), hit('B.1', 1, 560, 600)),
    expected: expected({ sentinels: [{ id: 'A.0' }, { id: 'A.lost' }] }, { sentinels: [{ id: 'B.0' }, { id: 'B.1', outside: true }] }),
  });
  assert.deepEqual(checksOf(judgement), { A: ['sentinel:duplicated', 'sentinel:missing'], B: ['sentinel:outside'] });
  assert.match(judgement.verdicts[1]?.failures[0]?.evidence ?? '', /x 560\.0pt, y 600\.0pt on page 1/);
});

test('sentinels placed with no text block in the log fail the document', () => {
  const judgement = judge({ cell: 'c', emitted, result: { log: hit('A.0'), pages: 1, ms: 1 }, expected: expected({}, { sentinels: [] }) });
  assert.deepEqual(checksOf(judgement).A, ['sentinel:preamble:document']);
});

test('feature probes: a box that never broke, a note away from its mark, a feature with no probe', () => {
  const judgement = judge({
    cell: 'c',
    emitted,
    result: result(hit('A.start', 2), hit('A.end', 2), hit('B.mark', 1), hit('B.text', 2)),
    expected: expected(
      { sentinels: [{ id: 'A.start', role: 'breakable:start' }, { id: 'A.end', role: 'breakable:end' }], features: ['breakable', 'teleport'] },
      { sentinels: [{ id: 'B.mark', role: 'footnote:mark' }, { id: 'B.text', role: 'footnote:text' }], features: ['footnote'] },
    ),
  });
  assert.deepEqual(checksOf(judgement), { A: ['feature:breakable', 'feature:teleport'], B: ['feature:footnote'] });
  assert.match(judgement.verdicts[0]?.failures[0]?.evidence ?? '', /both shipped on page 2/);
  assert.match(judgement.verdicts[1]?.failures[0]?.evidence ?? '', /mark on page 1, text on page 2/);

  const broke = judge({
    cell: 'c',
    emitted,
    result: result(hit('A.start', 1), hit('A.end', 2), hit('B.0')),
    expected: expected({ sentinels: [{ id: 'A.start', role: 'breakable:start' }, { id: 'A.end', role: 'breakable:end' }], features: ['breakable'] }),
  });
  assert.deepEqual(checksOf(broke).A, []);
});

test('an engine that gave nothing leaves nothing to judge', () => {
  const judgement = judge({ cell: 'c', emitted, result: { log: '', pages: null, ms: 0, threw: 'Chrome went away' }, expected: expected() });
  assert.deepEqual(judgement.verdicts, []);
  assert.equal(judgement.noVerdict, 'Chrome went away');
});
