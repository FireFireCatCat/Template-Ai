/**
 * The oracle (ARCHITECTURE.md 4.6): what "works" means for a branch in a cell.
 * A branch passes only when all four checks hold.
 *
 * 1. No TeX error in its lines.
 * 2. No damaging warning in its lines (`warnings.ts`).
 * 3. Every sentinel it placed shipped exactly once, inside the text block
 *    unless placed as `outside` (`sentinels.ts`).
 * 4. Each feature it declares passes its probe (`features.ts`).
 *
 * An error or warning the log cannot tie to a branch's lines (a preamble
 * error, a missing glyph, a page that overflowed) belongs to the document.
 * Every branch of that document then carries it with a `:document` suffix,
 * until the explainer (step 6) typesets branches alone to separate them.
 *
 * The order sentinels ship in is recorded but not judged. Floats and
 * footnotes move by design, so content after a float can rightly print before
 * it.
 */
import type { BranchId, CellId, Emitted, Failure, RawResult, SentinelSpec, Verdict } from './model.ts';
import { FEATURE_PROBES } from './features.ts';
import { readLog } from './log.ts';
import { inTextBlock, ptOf, readSentinels } from './sentinels.ts';
import { damagingWarnings } from './warnings.ts';

/** Raised whenever what the oracle decides changes: every saved result is judged again, and nothing compiles. */
export const ORACLE_VERSION = 3;

/** What one branch of the document is expected to show: the sentinels its host placed, and the features its ways declare. */
export type Expected = {
  readonly branch: BranchId;
  readonly sentinels: readonly SentinelSpec[];
  readonly features: readonly string[];
};

export type JudgeOptions = {
  /** How far past the text block, sideways, a sentinel may sit (and an overfull hbox may reach) before it fails. */
  readonly horizontalTolerancePt?: number;
  /** How far above or below the text block a sentinel may sit. */
  readonly verticalTolerancePt?: number;
};

export type Judgement = {
  readonly cell: CellId;
  readonly verdicts: readonly Verdict[];
  /** What the log could not tie to one branch. */
  readonly document: readonly Failure[];
  /** The engine gave no result, so there is nothing to judge. */
  readonly noVerdict?: string;
};

const DEFAULTS = { horizontalTolerancePt: 10, verticalTolerancePt: 4 };
const SP_PER_PT = 65536;

const branchAt = (spans: Emitted['spans'], line: number): BranchId | undefined =>
  spans.find((s) => s.from <= line && line <= s.to)?.branch;

export const judge = (input: {
  readonly cell: CellId;
  readonly emitted: Emitted;
  readonly result: RawResult;
  readonly expected: readonly Expected[];
  readonly options?: JudgeOptions;
}): Judgement => {
  const { cell, emitted, result, expected } = input;
  if (result.threw !== undefined) return { cell, verdicts: [], document: [], noVerdict: result.threw };
  const options = { ...DEFAULTS, ...input.options };
  const reading = readLog(result.log, emitted.latex);
  const { hits, geometry } = readSentinels(result.log);

  const own = new Map<BranchId, Failure[]>(expected.map((e) => [e.branch, []]));
  const shared: Failure[] = [];
  const fail = (branch: BranchId | undefined, failure: Failure): void => {
    const list = branch === undefined ? undefined : own.get(branch);
    if (list === undefined) shared.push(failure);
    else list.push(failure);
  };
  const at = (line: number | undefined): BranchId | undefined => (line === undefined ? undefined : branchAt(emitted.spans, line));

  // 1. Errors.
  for (const error of reading.errors) {
    fail(at(error.line), { check: 'error', evidence: error.line === undefined ? error.message : `${error.message} (l.${error.line})` });
  }
  if (reading.fatal) shared.push({ check: 'fatal', evidence: 'TeX stopped at a fatal error; nothing after it ran' });

  // 2. Damaging warnings.
  for (const damage of damagingWarnings(reading, { hboxTolerancePt: options.horizontalTolerancePt })) {
    fail(at(damage.line), { check: `warning:${damage.name}`, evidence: damage.text });
  }

  // 3. Sentinels.
  const placedAny = expected.some((e) => e.sentinels.length > 0);
  if (placedAny && geometry === undefined) {
    shared.push({ check: 'sentinel:preamble', evidence: 'no text block in the log: the sentinel preamble is missing or never ran' });
  }
  const h = options.horizontalTolerancePt * SP_PER_PT;
  const v = options.verticalTolerancePt * SP_PER_PT;
  for (const e of expected) {
    for (const spec of e.sentinels) {
      const found = hits.get(spec.id) ?? [];
      const first = found[0];
      if (first === undefined) {
        fail(e.branch, { check: 'sentinel:missing', evidence: `${spec.id} never shipped: its content was lost` });
      } else if (found.length > 1) {
        fail(e.branch, { check: 'sentinel:duplicated', evidence: `${spec.id} shipped ${found.length} times (pages ${found.map((f) => f.page).join(', ')})` });
      } else if (!spec.outside && geometry !== undefined && !inTextBlock(first, geometry, h, v)) {
        fail(e.branch, {
          check: 'sentinel:outside',
          evidence: `${spec.id} shipped outside the text block, at x ${ptOf(first.x ?? 0)}, y ${ptOf(first.y ?? 0)} on page ${first.page}`,
        });
      }
    }
  }

  // 4. Features.
  for (const e of expected) {
    for (const name of e.features) {
      const probe = FEATURE_PROBES[name];
      const evidence = probe === undefined ? 'no probe for this feature' : probe({ placed: e.sentinels, hits });
      if (evidence !== undefined) fail(e.branch, { check: `feature:${name}`, evidence });
    }
  }

  const documentWide = shared.map((f) => ({ check: `${f.check}:document`, evidence: f.evidence }));
  const verdicts = expected.map((e): Verdict => {
    const failures = [...(own.get(e.branch) ?? []), ...documentWide];
    return { branch: e.branch, cell, pass: failures.length === 0, failures };
  });
  return { cell, verdicts, document: shared };
};
