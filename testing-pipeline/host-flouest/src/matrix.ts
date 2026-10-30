/**
 * The matrix (ARCHITECTURE.md section 5, stages 4 to 8): the plan's branches
 * filed, every document emitted under each class setting and setup, compiled
 * through the store, judged by the oracle and written to the ledger. Telling
 * a branch's own failures from those of the company it kept is the
 * explainer's (`compat explain`).
 */
import {
  documentCells,
  fileBranches,
  judge,
  newRun,
  recordRun,
  runCells,
  type BranchId,
  type BranchSpec,
  type DocumentId,
  type JudgedJob,
  type Judgement,
  type PairRun,
  type Verdict,
} from 'compat-core';

import type { Subject } from './subject.ts';
import type { Under, Workspace } from './workspace.ts';

/** One class setting under one setup: every branch of the plan's verdict there. */
export type UnderRun = PairRun & { readonly under: Under };

export type MatrixRun = {
  readonly documents: number;
  readonly filed: number;
  /** The documents this run filed. */
  readonly fresh: ReadonlySet<DocumentId>;
  /** The documents with a cell compiled this run, not taken from the store. */
  readonly compiledIn: ReadonlySet<DocumentId>;
  /** Documents whose branches need a bibliography (`Host.requires`). */
  readonly withBibliography: number;
  readonly compiled: number;
  readonly cached: number;
  readonly emitMs: number;
  readonly ms: number;
  readonly jobs: readonly JudgedJob[];
  readonly runs: readonly UnderRun[];
  /** The branches of the document each branch of the plan is filed in, in order. */
  readonly byBranch: ReadonlyMap<BranchId, readonly BranchSpec[]>;
};

export type MatrixOptions = { readonly size: number };

/** The branches by id, the plan's and any filed earlier (a document holds branches that may have left the plan). */
export const branchIndex = (subject: Subject): Map<BranchId, BranchSpec> => new Map(subject.plan.branches.map((b) => [b.id, b]));

export const runMatrix = async (ws: Workspace, subject: Subject, { size }: MatrixOptions): Promise<MatrixRun> => {
  const started = performance.now();
  const { host, plan } = subject;
  const filing = fileBranches(ws.store, plan.branches, host.documentRules(), { size, requires: (branch) => host.requires(branch) });
  const withBibliography = filing.documents.filter((d) => d.document.paths.some((p) => host.requires(p).length > 0)).length;
  // Each document is built and packed once, then emitted under every class setting and setup that applies.
  const jobs = filing.documents.flatMap((d) => documentCells(host, d.document, ws.classSettings, ws.setups, ws.classFiles));
  const emitMs = performance.now() - started;
  const engine = await ws.engine();
  const outcomes = await runCells(ws.store, engine, jobs);
  const judgements = new Map<string, Judgement>();
  outcomes.forEach((outcome, i) => {
    const job = jobs[i];
    if (job !== undefined) judgements.set(outcome.cell.id, judge({ cell: outcome.cell.id, emitted: job.emitted, result: outcome.result, expected: job.expected }));
  });
  const summary = recordRun(ws.store, outcomes, newRun(), engine.fingerprint(), judgements);

  const current = new Set(plan.branches.map((b) => b.id));
  const runs = ws.under.map((under): UnderRun => {
    const verdicts = new Map<BranchId, Verdict>();
    jobs.forEach((job) => {
      if (job.cell.classSetting !== under.classSetting.id || job.cell.setup !== under.setup.id) return;
      for (const v of judgements.get(job.cell.id)?.verdicts ?? []) if (current.has(v.branch)) verdicts.set(v.branch, v);
    });
    return { under, pair: { classSetting: under.classSetting.id, setup: under.setup.id }, verdicts };
  });
  return {
    documents: filing.documents.length,
    filed: filing.filed.length,
    fresh: new Set(filing.filed),
    compiledIn: new Set(outcomes.filter((o) => !o.cached).map((o) => o.cell.document)),
    withBibliography,
    compiled: summary.compiled,
    cached: summary.cached,
    emitMs,
    ms: performance.now() - started,
    jobs,
    runs,
    byBranch: new Map(filing.documents.flatMap(({ document, current: here }) => here.map((id) => [id, document.paths] as const))),
  };
};
