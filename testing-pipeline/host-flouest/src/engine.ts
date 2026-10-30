/**
 * The Engine port over Flouest's own engine runner: `openEngines` from the
 * dynamic tests' `engine.ts`. That is the app's ZeroTeX-NG in headless
 * Chrome, each job compiled as the app's Download compiles it (Flouest
 * ADR-325), so a result here is the result the app would give.
 *
 * Every job is typeset under one job name with Download's two passes, so a
 * job's id never reaches TeX. The fingerprint is Flouest's own key for an
 * empty job without files: the hash of everything every compile reads besides
 * its LaTeX and files (the page with its package mirror, the engine build, the
 * epoch).
 *
 * A job's files (a class the engine cannot fetch) are written into its
 * project, as the app writes a template's files (Flouest ADR-254). Flouest's
 * runner takes its files when it opens, and two runners cannot share the
 * Chrome profiles at once. So jobs are compiled one file set at a time: the
 * jobs handed in together are grouped by their files, and the runner is
 * reopened only to change sets.
 *
 * Chrome keeps the engine's format and the packages it fetched in profiles
 * under `out/_shared/`, where Flouest's runner looks for them (`out.ts`,
 * `sharedDir`, from the folder the run started in). That folder is linked to
 * Flouest's own, so nothing is fetched twice. For the same reason, Flouest's
 * dynamic tests and this pipeline must not run at the same time.
 */
import { createHash } from 'node:crypto';
import { existsSync, lstatSync, mkdirSync, symlinkSync } from 'node:fs';
import { join } from 'node:path';

import { defaultEngines, jobOf, openEngines, type Engines } from '@flouest/Template/test/dynamic-testing/engine.ts';
import type { Engine, EngineFile, Job, RawResult } from 'compat-core';

const JOB_NAME = 'main';
const PASSES = 2;

export type FlouestEngineOptions = {
  /** The Flouest checkout. */
  readonly flouest: string;
  /** The workspace's `out/`: the runner's own result cache goes in `engine-cache/` under it. */
  readonly out: string;
  readonly engines: number | 'default';
  /** No more engines than this, for a run with few jobs. */
  readonly atMost?: number;
  readonly log?: (line: string) => void;
};

/** Points `link` at Flouest's shared profiles, unless something is already there or Flouest has none yet. */
const linkShared = (flouestShared: string, link: string, log: (line: string) => void): void => {
  if (existsSync(link) || lstatSync(link, { throwIfNoEntry: false })) return;
  if (!existsSync(flouestShared)) return;
  mkdirSync(join(link, '..'), { recursive: true });
  symlinkSync(flouestShared, link, 'dir');
  log(`linked out/_shared to ${flouestShared}: the engine's format and fetched packages are reused`);
};

/** One name for a set of files: their paths and contents, in path order. */
const setOf = (files: readonly EngineFile[]): string =>
  [...files]
    .sort((a, b) => (a.path < b.path ? -1 : 1))
    .map((f) => `${f.path}:${createHash('sha256').update(f.bytes).digest('hex')}`)
    .join(',');

type Waiting = { readonly job: Job; readonly resolve: (result: RawResult) => void; readonly reject: (error: unknown) => void };

export const flouestEngine = async ({ flouest, out, engines, atMost, log = () => {} }: FlouestEngineOptions): Promise<Engine> => {
  const tests = join(flouest, 'Template/test/dynamic-testing');
  linkShared(join(tests, 'out', '_shared'), join(process.cwd(), 'out', '_shared'), log);
  const count = Math.max(1, Math.min(engines === 'default' ? defaultEngines() : engines, atMost ?? Number.POSITIVE_INFINITY));
  const open = (files: readonly EngineFile[]): Promise<Engines> =>
    openEngines({
      here: tests,
      cacheDir: join(out, 'engine-cache'),
      engines: count,
      files: files.map((f) => ({ path: f.path, bytes: Buffer.from(f.bytes) })),
      onReady: (setupMs) => log(`${count} engine(s) ready in ${(setupMs / 1000).toFixed(1)} s${files.length > 0 ? ` with ${files.length} class file(s)` : ''}`),
    });

  let current = { set: setOf([]), opened: await open([]) };
  const fingerprint = `flouest-zerotex:${current.opened.keyOf(jobOf('fingerprint', JOB_NAME, '', PASSES))}`;
  const waiting = new Map<string, Waiting[]>();
  let draining: Promise<void> | undefined;

  const typeset = async (opened: Engines, job: Job): Promise<RawResult> => {
    const part = jobOf(job.id, JOB_NAME, job.latex, PASSES);
    const result = opened.saved(part) ?? (await opened.typeset(part)).result;
    return { log: result.log ?? '', pages: null, ms: result.ms, ...(result.threw === undefined ? {} : { threw: result.threw }) };
  };

  /** Compiles every waiting job, the open set's first, then each other set in turn. */
  const drain = async (): Promise<void> => {
    // Let every job handed in together arrive before the first set is chosen.
    await Promise.resolve();
    for (;;) {
      const set = (waiting.get(current.set)?.length ?? 0) > 0 ? current.set : [...waiting.keys()].find((k) => (waiting.get(k)?.length ?? 0) > 0);
      if (set === undefined) return;
      const batch = waiting.get(set) ?? [];
      waiting.delete(set);
      const first = batch[0];
      if (first === undefined) continue;
      if (set !== current.set) {
        await current.opened.close();
        current = { set, opened: await open(first.job.files) };
      }
      const opened = current.opened;
      await Promise.all(
        batch.map(async (w) => {
          try {
            w.resolve(await typeset(opened, w.job));
          } catch (error) {
            w.reject(error);
          }
        }),
      );
    }
  };

  const kick = (): void => {
    draining ??= drain().finally(() => {
      draining = undefined;
      if ([...waiting.values()].some((list) => list.length > 0)) kick();
    });
  };

  return {
    fingerprint: () => fingerprint,
    compile: (job: Job): Promise<RawResult> =>
      new Promise((resolve, reject) => {
        const set = setOf(job.files);
        waiting.set(set, [...(waiting.get(set) ?? []), { job, resolve, reject }]);
        kick();
      }),
    close: async () => {
      await draining;
      await current.opened.close();
    },
  };
};
