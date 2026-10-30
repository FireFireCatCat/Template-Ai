/**
 * `compat run` (ARCHITECTURE.md section 8): General planned, filed, compiled
 * under each class setting and setup, judged and recorded.
 *
 *   npm run compat -- run [--classes id,id] [--setups A,B] [--depth 2] [--size 64] [--library] [--plan-only]
 *
 * `--library` adds the handler library's ways (`../Latex-Lib`) as plug-in
 * ways beside General's.
 *
 * Every class setting and every setup that applies to it, unless picked. The
 * plan is printed beside Flouest's own split of the same variants. The solo
 * branches (each variant of each node alone) are compiled under the same class
 * settings and setups, and every failure is said to come from its ways alone,
 * from the class or setup (against article with setup A), from the document,
 * or from the nesting; `compat explain` takes it from there. Every compile
 * goes through the store, so a second run compiles nothing, and a change
 * compiles only the documents whose LaTeX it changed.
 */
import { latexLibWays } from '../src/latexLib.ts';
import { branchIndex, runMatrix } from '../src/matrix.ts';
import { printFailures, printOrigins, printPlan, printRun, seconds } from '../src/report.ts';
import { runSolo } from '../src/solo.ts';
import { loadSubject } from '../src/subject.ts';
import { flag, numberOption, openWorkspace } from '../src/workspace.ts';

const depth = numberOption('depth', 2);
const size = numberOption('size', 64);

const ws = openWorkspace();
const started = performance.now();
const subject = loadSubject(ws.flouest, depth).withWays(flag('library') ? await latexLibWays(ws) : []);
console.log(`compat run: General to depth ${depth}, ${size} branches to a document, under ${ws.under.length} class setting and setup pair(s). Flouest's variants, marks and escapes in ${seconds(performance.now() - started)}.`);
printPlan(subject);
try {
  if (!flag('plan-only')) {
    const run = await runMatrix(ws, subject, { size });
    printRun('run', run);
    const branches = branchIndex(subject);
    printFailures(run, branches);
    printOrigins(run, await runSolo(ws, subject), branches);
  }
} finally {
  await ws.close();
}
