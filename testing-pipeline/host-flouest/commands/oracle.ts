/**
 * `compat oracle`: the oracle checked on the app's ZeroTeX-NG (ARCHITECTURE.md
 * section 10, step 2). Each case is a small `article` document with sentinels, and
 * what TeX does with it is known: a footnote in a `tabular` is lost, a float
 * in a box is an error, a breakable box with three pages of text breaks and an
 * unbreakable one runs off the page. A case passes when the oracle says what
 * TeX did. One case is only observed, not asserted: how the engine's
 * tcolorbox treats a breakable box in a footnote.
 *
 *   npm run compat -- oracle [--only name,name]
 *
 * Compiles go through the store, so a second run compiles nothing. Nothing is
 * written to the ledger: these are checks of the oracle, not cells.
 */
import { join, resolve } from 'node:path';

import {
  cellId,
  FsStore,
  judge,
  loadConfig,
  looseDocumentId,
  readSentinels,
  recordingProbes,
  runCells,
  SENTINEL_PREAMBLE,
  type BuildProbes,
  type CellJob,
  type Emitted,
  type Expected,
} from 'compat-core';

import { flouestEngine } from '../src/engine.ts';

type Sentinel = BuildProbes['sentinel'];

type Case = {
  readonly name: string;
  readonly about: string;
  readonly packages?: readonly string[];
  readonly body: (s: Sentinel) => string;
  readonly features?: readonly string[];
  /** `pass`; or each check listed must be among the failures; or only report what happened. */
  readonly expect: 'pass' | { readonly fails: readonly string[] } | 'observe';
};

/** `n` paragraphs of two lines or so: three pages of text, enough to make any box break. */
const filler = (n: number): string =>
  Array.from({ length: n }, (_, i) => `Paragraph ${i + 1} of a statement long enough that the box holding it must run on past the end of the page it starts on.`).join('\n\n');

const longBox = (options: string, s: Sentinel) =>
  [
    `\\begin{tcolorbox}${options}`,
    `The box opens here.${s('box.start', { role: 'breakable:start' })}`,
    '',
    filler(60),
    '',
    `The box closes here.${s('box.end', { role: 'breakable:end' })}`,
    '\\end{tcolorbox}',
  ].join('\n');

const marginNote = (s: Sentinel, outside: boolean) =>
  `Text with a note in the margin.\\marginpar{A margin note.${s('note', outside ? { outside: true } : {})}}${s('text')}`;

const CASES: readonly Case[] = [
  {
    name: 'paragraph',
    about: 'plain text',
    body: (s) => `Some text${s('p.1')} and some more.`,
    expect: 'pass',
  },
  {
    name: 'footnote',
    about: 'a footnote in running text',
    body: (s) => `Text with a note.\\footnote{The note's text.${s('f.text', { role: 'footnote:text' })}}${s('f.mark', { role: 'footnote:mark' })}`,
    features: ['footnote'],
    expect: 'pass',
  },
  {
    name: 'footnote-in-tabular',
    about: 'a footnote in an l column: TeX drops its text',
    body: (s) =>
      ['\\begin{tabular}{l}', `Cell text\\footnote{A lost note.${s('t.text', { role: 'footnote:text' })}}${s('t.mark', { role: 'footnote:mark' })}\\\\`, '\\end{tabular}'].join('\n'),
    features: ['footnote'],
    expect: { fails: ['sentinel:missing'] },
  },
  {
    name: 'float',
    about: 'a figure in running text',
    body: (s) => ['\\begin{figure}[ht]', '\\centering', `Figure body.${s('fg.body')}`, '\\caption{A figure.}', '\\end{figure}', `Text after it.${s('fg.text')}`].join('\n'),
    expect: 'pass',
  },
  {
    name: 'float-in-box',
    about: 'a figure inside a parbox: not in outer par mode',
    body: (s) => ['\\fbox{\\parbox{6cm}{', '\\begin{figure}', `Figure body.${s('fb.body')}`, '\\end{figure}', '}}'].join('\n'),
    expect: { fails: ['error'] },
  },
  {
    name: 'breakable-box',
    about: 'a breakable tcolorbox holding three pages',
    packages: ['\\usepackage{tcolorbox}', '\\tcbuselibrary{breakable}'],
    body: (s) => longBox('[breakable]', s),
    features: ['breakable'],
    expect: 'pass',
  },
  {
    name: 'unbreakable-box',
    about: 'the same box, not breakable: it cannot break and runs off the page',
    packages: ['\\usepackage{tcolorbox}', '\\tcbuselibrary{breakable}'],
    body: (s) => longBox('', s),
    features: ['breakable'],
    expect: { fails: ['feature:breakable'] },
  },
  {
    name: 'margin-overflow',
    about: 'an unbreakable run far wider than the line',
    body: (s) =>
      `\\noindent\\mbox{An unbreakable run of words far too wide for any line of this page, made wider still by these words}${s('mo.end')}`,
    expect: { fails: ['warning:overfull-hbox', 'sentinel:outside'] },
  },
  {
    name: 'margin-note',
    about: 'a margin note, its sentinel placed as outside',
    body: (s) => marginNote(s, true),
    expect: 'pass',
  },
  {
    name: 'margin-note-unflagged',
    about: 'the same LaTeX, its sentinel not placed as outside',
    body: (s) => marginNote(s, false),
    expect: { fails: ['sentinel:outside'] },
  },
  {
    name: 'typeset-twice',
    about: 'a saved box used twice',
    body: (s) =>
      ['\\newsavebox\\compatDemoBox', `\\sbox\\compatDemoBox{Saved text.${s('tt.saved')}}`, '\\usebox\\compatDemoBox{} and again \\usebox\\compatDemoBox'].join('\n'),
    expect: { fails: ['sentinel:duplicated'] },
  },
  {
    name: 'discarded',
    about: 'a saved box never used',
    body: (s) => ['\\newsavebox\\compatDemoBox', `\\sbox\\compatDemoBox{Never shown.${s('dc.lost')}}`, `Text.${s('dc.text')}`].join('\n'),
    expect: { fails: ['sentinel:missing'] },
  },
  {
    name: 'undefined-reference',
    about: 'a reference to a label that does not exist',
    body: (s) => `See section~\\ref{nowhere}.${s('ur.text')}`,
    expect: { fails: ['warning:undefined-reference'] },
  },
  {
    name: 'missing-glyph',
    about: 'a character Latin Modern does not have',
    body: (s) => `A snowman: \u2603.${s('mg.text')}`,
    expect: { fails: ['warning:missing-character:document'] },
  },
  {
    name: 'breakable-box-in-footnote',
    about: "observed: the engine's tcolorbox with a breakable box in a footnote",
    packages: ['\\usepackage{tcolorbox}', '\\tcbuselibrary{breakable}'],
    body: (s) => `Text.\\footnote{\\begin{tcolorbox}[breakable]In a note.${s('bf.text')}\\end{tcolorbox}}${s('bf.mark')}`,
    expect: 'observe',
  },
];

const arg = (name: string): string | undefined => {
  const at = process.argv.indexOf(`--${name}`);
  return at < 0 ? undefined : process.argv[at + 1];
};

/** A case as a document: its LaTeX, its one branch's lines, and what the oracle should expect of it. */
const documentOf = (c: Case): { readonly emitted: Emitted; readonly expected: readonly Expected[] } => {
  const { probes, placed } = recordingProbes(true);
  const head = ['\\documentclass{article}', ...SENTINEL_PREAMBLE, ...(c.packages ?? []), '\\begin{document}'];
  const body = c.body(probes.sentinel).split('\n');
  const latex = `${[...head, ...body, '\\end{document}'].join('\n')}\n`;
  return {
    emitted: { latex, spans: [{ branch: c.name, from: head.length + 1, to: head.length + body.length }], files: [] },
    expected: [{ branch: c.name, sentinels: placed, features: c.features ?? [] }],
  };
};

const only = arg('only')?.split(',');
const cases = CASES.filter((c) => only === undefined || only.includes(c.name));
const config = loadConfig(join(process.cwd(), 'compat.config.json'));
const flouest = resolve(config.root, String(config.host.root));
const documents = cases.map((c) => ({ c, ...documentOf(c) }));
const jobs: CellJob[] = documents.map(({ c, emitted }) => {
  const document = looseDocumentId({ oracleCase: c.name, latex: emitted.latex });
  const cell = { id: cellId(document, 'article', 'A'), document, classSetting: 'article', setup: 'A' };
  return { cell, job: { id: cell.id, latex: emitted.latex, files: [] } };
});

const store = new FsStore(config.out);
const engine = await flouestEngine({
  flouest,
  out: config.out,
  engines: config.engines,
  atMost: new Set(jobs.map((j) => j.job.latex)).size,
  log: (line) => console.log(`  ${line}`),
});
try {
  const outcomes = await runCells(store, engine, jobs);
  const pad = (text: string, width: number) => text.padEnd(width);
  console.log(`\nStep 2 oracle check: ${cases.length} cases, ${outcomes.filter((o) => !o.cached).length} compiled.\n`);
  console.log(`  ${pad('case', 27)}${pad('expected', 40)}${pad('oracle says', 52)}as expected`);
  let unmet = 0;
  const details: string[] = [];
  documents.forEach(({ c, emitted, expected }, i) => {
    const outcome = outcomes[i];
    if (outcome === undefined) return;
    const judgement = judge({ cell: outcome.cell.id, emitted, result: outcome.result, expected });
    const verdict = judgement.verdicts[0];
    const checks = verdict === undefined ? [`no verdict: ${judgement.noVerdict ?? '?'}`] : verdict.failures.map((f) => f.check);
    const said = verdict?.pass ? 'pass' : checks.join(', ');
    const wanted = c.expect === 'pass' ? 'pass' : c.expect === 'observe' ? '(observed)' : `fails ${c.expect.fails.join(', ')}`;
    const met =
      c.expect === 'observe' ? '-' : c.expect === 'pass' ? (verdict?.pass ?? false) : verdict !== undefined && !verdict.pass && c.expect.fails.every((f) => checks.includes(f));
    if (met === false) unmet += 1;
    console.log(`  ${pad(c.name, 27)}${pad(wanted, 40)}${pad(said, 52)}${met === '-' ? '-' : met ? 'yes' : 'NO'}`);
    for (const failure of verdict?.failures ?? []) details.push(`  ${c.name}: ${failure.check}: ${failure.evidence}`);
    if (c.name === 'paragraph') {
      const { hits, geometry } = readSentinels(outcome.result.log);
      const hit = hits.get('p.1')?.[0];
      const pt = (sp: number | null | undefined) => (sp == null ? '?' : `${(sp / 65536).toFixed(1)}pt`);
      if (hit && geometry) {
        details.unshift(
          `  paragraph: p.1 shipped on page ${hit.page} at x ${pt(hit.x)}, y ${pt(hit.y)}; text block x ${pt(geometry.oddLeft)} to ${pt(geometry.oddLeft + geometry.textWidth)}, y ${pt(geometry.textTop - geometry.textHeight)} to ${pt(geometry.textTop)}`,
        );
      } else {
        details.unshift(`  paragraph: the sentinel or the text block is missing from the log`);
      }
    }
  });
  console.log(`\nEvidence:\n${details.join('\n')}`);
  const asserted = cases.filter((c) => c.expect !== 'observe').length;
  console.log(`\n${asserted - unmet} of ${asserted} asserted cases behaved as expected.`);
  if (unmet > 0) process.exitCode = 1;
} finally {
  await engine.close();
}
