/**
 * `compat stability`: the acceptance test for growing the library
 * (ARCHITECTURE.md section 6) on the real host.
 *
 *   npm run compat -- stability [--classes article] [--setups A] [--depth 2] [--size 64]
 *
 * The matrix as it is, then again with a dummy theorem way plugged in
 * (`src/dummy.ts`), then again without. With the way, every added branch
 * must hold it, and only documents of its branches may be filed and compiled.
 * A new document may still come from the store: results are keyed by LaTeX,
 * so one filed again under new rules with the same LaTeX compiles nothing.
 * Without it again, nothing is filed or compiled, and every old cell's latest
 * ledger line is as it was. Under `article` with setup A unless picked.
 */
import { canonical, latestByCell } from 'compat-core';

import { DUMMY_WAY } from '../src/dummy.ts';
import { runMatrix } from '../src/matrix.ts';
import { n, printRun } from '../src/report.ts';
import { loadSubject } from '../src/subject.ts';
import { numberOption, openWorkspace } from '../src/workspace.ts';

const depth = numberOption('depth', 2);
const size = numberOption('size', 64);

const ws = openWorkspace({ classes: ['article'], setups: ['A'] });
const subjects = loadSubject(ws.flouest, depth);
try {
  const base = subjects.withWays();
  const first = await runMatrix(ws, base, { size });
  printRun('as it is', first);
  const before = latestByCell(ws.store);

  const grown = subjects.withWays([DUMMY_WAY]);
  const oldIds = new Set(base.plan.branches.map((b) => b.id));
  const added = grown.plan.branches.filter((b) => !oldIds.has(b.id));
  const kept = base.plan.branches.filter((b) => grown.plan.branches.some((g) => g.id === b.id)).length;
  const holding = added.filter((b) => b.path.some((s) => s.variant.way === DUMMY_WAY.id)).length;
  console.log(`dummy way    ${n(added.length)} branches added (${n(holding)} hold the dummy way); ${n(kept)} of ${n(base.plan.branches.length)} old branches kept`);
  const second = await runMatrix(ws, grown, { size });
  printRun('with it', second);

  const third = await runMatrix(ws, base, { size });
  printRun('without', third);
  const after = latestByCell(ws.store);
  const same = first.jobs.every(({ cell }) => {
    const was = before.get(cell.id);
    const is = after.get(cell.id);
    return was !== undefined && is !== undefined && was.result === is.result && was.status === is.status && canonical(was.verdicts ?? []) === canonical(is.verdicts ?? []);
  });
  const checks = [
    ['every added branch holds the dummy way', holding === added.length],
    [
      `with the way, nothing compiled outside its new documents (${second.compiledIn.size} of the ${second.filed} compiled; the rest had LaTeX already in the store)`,
      [...second.compiledIn].every((d) => second.fresh.has(d)),
    ],
    ['without it again, nothing filed or compiled', third.filed === 0 && third.compiled === 0],
    ["every old cell's latest ledger line is as it was", same],
  ] as const;
  for (const [what, ok] of checks) console.log(`  ${ok ? 'pass' : 'FAIL'}  ${what}`);
  if (checks.some(([, ok]) => !ok)) process.exitCode = 1;
} finally {
  await ws.close();
}
