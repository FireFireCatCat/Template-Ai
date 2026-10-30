import assert from 'node:assert/strict';
import { test } from 'node:test';

import { LOG_WIDTH, readLog, shapeOf } from '../src/log.ts';

const wrapped = `Package tcolorbox Warning: ${'x'.repeat(LOG_WIDTH - 'Package tcolorbox Warning: '.length)}`;

const LOG = [
  'This is XeTeX, Version 3.141592653-2.6-0.999996',
  wrapped,
  'and the rest of the warning.',
  'LaTeX Warning: Reference `thm:x\' on page 1 undefined on input line 12.',
  '! Undefined control sequence.',
  'l.3 \\foo',
  '         {bar}',
  'Overfull \\hbox (3.2pt too wide) in paragraph at lines 5--6',
  'Underfull \\hbox (badness 10000) in paragraph at lines 7--8',
  'Missing character: There is no ☃ in font lmroman10-regular!',
  'Output written on main.xdv (2 pages, 3456 bytes).',
].join('\n');

const LATEX = '\\documentclass{article}\n\\begin{document}\n\\foo{bar}\n\\end{document}\n';

test('readLog reads pages, errors with their source line, warnings, boxes and missing characters', () => {
  const reading = readLog(LOG, LATEX);
  assert.equal(reading.pages, 2);
  assert.deepEqual(reading.errors, [{ message: 'Undefined control sequence.', line: 3, source: '\\foo{bar}' }]);
  assert.equal(reading.fatal, false);
  assert.deepEqual(reading.warnings, [
    `${wrapped}and the rest of the warning.`,
    "LaTeX Warning: Reference `thm:x' on page 1 undefined on input line 12.",
  ]);
  assert.equal(reading.overfull, 1);
  assert.equal(reading.underfull, 1);
  assert.deepEqual(reading.missing, ['There is no ☃ in font lmroman10-regular!']);
});

test('readLog without the LaTeX still gives each error its line', () => {
  assert.deepEqual(readLog(LOG).errors, [{ message: 'Undefined control sequence.', line: 3 }]);
});

test('readLog tells a fatal stop and a run with no pages', () => {
  const reading = readLog('! Emergency stop.\n!  ==> Fatal error occurred, no output PDF file produced!\nNo pages of output.\n');
  assert.equal(reading.fatal, true);
  assert.equal(reading.pages, 0);
  assert.deepEqual(reading.errors.map((e) => e.message), ['Emergency stop.']);
  assert.equal(readLog('').pages, null);
});

test('readLog joins a package warning across its (package) lines, and reads each box report', () => {
  const reading = readLog(
    [
      'Package hyperref Warning: Token not allowed in a PDF string (Unicode):',
      '(hyperref)                removing `\\compatSentinel\' on input line 30.',
      'Overfull \\hbox (150.2pt too wide) in paragraph at lines 14--15',
      'Overfull \\hbox (3.0pt too wide) detected at line 20',
      'Underfull \\hbox (badness 10000) in alignment at lines 40--44',
      'Overfull \\vbox (312.0pt too high) has occurred while \\output is active',
    ].join('\n'),
  );
  assert.deepEqual(reading.warnings, [
    "Package hyperref Warning: Token not allowed in a PDF string (Unicode): removing `\\compatSentinel' on input line 30.",
  ]);
  assert.deepEqual(reading.boxes, [
    { kind: 'overfull', box: 'h', amount: 150.2, lines: [14, 15], output: false },
    { kind: 'overfull', box: 'h', amount: 3, lines: [20, 20], output: false },
    { kind: 'underfull', box: 'h', amount: 10000, lines: [40, 44], output: false },
    { kind: 'overfull', box: 'v', amount: 312, output: true },
  ]);
  assert.equal(reading.overfull, 3);
  assert.equal(reading.underfull, 1);
});

test("readLog joins a message the log cut short of its width, as ZeroTeX's log does", () => {
  const reading = readLog(
    [
      '! LaTeX Error: Command \\proof already def',
      'ined.',
      '               Or name \\end... illegal, see p.192 of the manual.',
      '',
      'See the LaTeX manual or LaTeX Companion for explanation.',
      '! Argument of \\subparagraph has an e',
      'xtra }.',
      '<inserted text> ',
      'l.1635 \\ttl@extract\\subparagraph',
      'Class memoir Warning: The titlesec package is not recommended with memoir. on ',
      'input line 2.',
      '(/texmf/tex/latex/titlesec/ttlkeys.sty',
    ].join('\n'),
  );
  assert.deepEqual(
    reading.errors.map((e) => [e.message, e.line]),
    [
      ['LaTeX Error: Command \\proof already defined. Or name \\end... illegal, see p.192 of the manual.', undefined],
      ['Argument of \\subparagraph has an extra }.', 1635],
    ],
  );
  assert.deepEqual(reading.warnings, ['Class memoir Warning: The titlesec package is not recommended with memoir. on input line 2.']);
});

test('shapeOf takes numbers and quoted names out, so the same message groups', () => {
  assert.equal(
    shapeOf("LaTeX Warning: Reference `thm:x' on page 12 undefined on input line 40."),
    "LaTeX Warning: Reference `…' on page # undefined on input line #.",
  );
});
