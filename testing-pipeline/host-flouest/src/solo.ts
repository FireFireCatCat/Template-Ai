/**
 * The solo baseline (ARCHITECTURE.md section 5, stage 2): each variant of
 * each node alone in a document of its own, with the marked runs and with the
 * escape run (`soloBranches`), under every class setting and setup. What a
 * solo branch fails is what its way fails wherever it sits, so the matrix
 * counts it against the way, not against the nesting (`attribute`).
 *
 * Solo documents are not filed: one branch each, they are the same document
 * however often they are made. Their compiles go through the store like any
 * other, so a second run compiles none.
 */
import { checkOf, documentCells, judge, packBranches, runCells, soloBranches, soloKey, type SoloFailures, type SoloVerdict } from 'compat-core';

import type { Subject } from './subject.ts';
import type { Workspace } from './workspace.ts';

export type SoloRun = {
  readonly branches: number;
  readonly compiled: number;
  readonly cached: number;
  readonly ms: number;
  /** Per class setting and setup (`underName`): the checks each solo branch fails. */
  readonly failures: ReadonlyMap<string, SoloFailures>;
  /** Per class setting and setup: how many solo branches fail. */
  readonly failing: ReadonlyMap<string, number>;
  /** Every failing solo branch's verdict, with the branch and its pair. */
  readonly verdicts: readonly SoloVerdict[];
};

export const runSolo = async (ws: Workspace, subject: Subject): Promise<SoloRun> => {
  const started = performance.now();
  const { host, library, depth } = subject;
  const solos = soloBranches(host.nesting(depth), (node) => host.variants(node, library.ways(node)));
  const rules = host.documentRules();
  const jobs = solos.flatMap((branch) =>
    packBranches([branch], rules, 1).flatMap((d) => documentCells(host, d, ws.classSettings, ws.setups, ws.classFiles).map((job) => ({ job, branch }))),
  );
  const outcomes = await runCells(ws.store, await ws.engine(), jobs.map((j) => j.job));
  const failures = new Map<string, Map<string, Set<string>>>();
  const failing = new Map<string, number>();
  const verdicts: SoloVerdict[] = [];
  outcomes.forEach((outcome, i) => {
    const entry = jobs[i];
    if (entry === undefined) return;
    const { job, branch } = entry;
    const verdict = judge({ cell: outcome.cell.id, emitted: job.emitted, result: outcome.result, expected: job.expected }).verdicts[0];
    const leaf = branch.path.at(-1);
    if (verdict === undefined || verdict.pass || leaf === undefined) return;
    const under = `${job.cell.classSetting}.${job.cell.setup}`;
    const here = failures.get(under) ?? new Map<string, Set<string>>();
    here.set(soloKey(leaf.node, leaf.variant, branch.marked ?? false), new Set(verdict.failures.map(checkOf)));
    failures.set(under, here);
    failing.set(under, (failing.get(under) ?? 0) + 1);
    verdicts.push({ pair: { classSetting: job.cell.classSetting, setup: job.cell.setup }, branch, verdict });
  });
  return {
    branches: solos.length,
    compiled: outcomes.filter((o) => !o.cached).length,
    cached: outcomes.filter((o) => o.cached).length,
    ms: performance.now() - started,
    failures,
    failing,
    verdicts,
  };
};
