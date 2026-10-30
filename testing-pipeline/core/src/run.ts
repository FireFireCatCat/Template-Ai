/**
 * Compiles cells (ARCHITECTURE.md section 5, stage 5).
 *
 * Each cell's result is found in the store under the hash of everything the
 * engine reads (`resultKey`), or compiled and saved there. Cells whose LaTeX is
 * the same share one compile. A result the engine could not give (it threw, or
 * a package could not be fetched) is not saved, so the next run tries again.
 *
 * Nothing here waits on a timer. As in Flouest (ADR-209), a compile that never
 * returns holds its engine until the run is stopped, and the engine's own
 * watchdogs end a build that loops.
 */
import { resultKey } from './ids.ts';
import type { Cell, Job, RawResult } from './model.ts';
import type { Engine, Store } from './ports.ts';

export type CellJob = { readonly cell: Cell; readonly job: Job };

export type CellOutcome = {
  readonly cell: Cell;
  /** Where the result is saved: `results/<key>`. */
  readonly key: string;
  /** The result was in the store before this run. */
  readonly cached: boolean;
  readonly result: RawResult;
};

export const resultAt = (key: string): string => `results/${key}`;

const messageOf = (error: unknown): string => (error instanceof Error ? error.message : String(error));

export const runCells = async (store: Store, engine: Engine, jobs: readonly CellJob[]): Promise<CellOutcome[]> => {
  const fingerprint = engine.fingerprint();
  const once = new Map<string, Promise<{ readonly result: RawResult; readonly cached: boolean }>>();

  const compile = async (job: Job, key: string) => {
    let result: RawResult;
    try {
      result = await engine.compile(job);
    } catch (error) {
      result = { log: '', pages: null, ms: 0, threw: messageOf(error) };
    }
    if (result.threw === undefined) store.put(resultAt(key), result);
    return { result, cached: false };
  };

  const resultFor = (job: Job, key: string) => {
    let pending = once.get(key);
    if (pending === undefined) {
      const saved = store.get(resultAt(key)) as RawResult | undefined;
      pending = saved === undefined ? compile(job, key) : Promise.resolve({ result: saved, cached: true });
      once.set(key, pending);
    }
    return pending;
  };

  return Promise.all(
    jobs.map(async ({ cell, job }) => {
      const key = resultKey(job, fingerprint);
      const { result, cached } = await resultFor(job, key);
      return { cell, key, cached, result };
    }),
  );
};
