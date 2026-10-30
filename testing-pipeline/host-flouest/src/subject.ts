/**
 * What is tested: General to a depth (Flouest's variants, marks and escapes),
 * its package methods as the library with any extra ways (the dummy), the
 * host over them, and the plan core makes of it.
 */
import { planBranches, type Plan } from 'compat-core';

import { FlouestHost, loadGeneral, type General } from './host.ts';
import { FlouestLibrary, generalWays, type FlouestWay } from './ways.ts';

export type Subject = {
  readonly depth: number;
  readonly general: General;
  readonly library: FlouestLibrary;
  readonly host: FlouestHost;
  readonly plan: Plan;
};

/**
 * General to `depth`, built once; `withWays` gives the subject with General's
 * ways and any extra ones. `compat`: where the library writes its compat tables.
 */
export const loadSubject = (flouest: string, depth: number, compat?: string, library?: string) => {
  const general = loadGeneral(flouest, depth);
  const libraryRoot = library;
  // The host's fingerprint: the bundle that runs, Flouest's code included (compat.mjs).
  const fingerprint = process.env['COMPAT_BUNDLE'] ?? 'unknown';
  const withWays = (extra: readonly FlouestWay[] = []): Subject => {
    const fromLibrary = new Set(extra.filter((w) => w.plugin !== undefined && !w.id.startsWith('thm.compat-')).map((w) => w.id));
    const library = new FlouestLibrary([...generalWays(general.variants), ...extra], compat, libraryRoot === undefined ? undefined : { root: libraryRoot, ways: fromLibrary });
    const host = new FlouestHost(general, library.all, fingerprint);
    const plan = planBranches(host.nesting(depth), (node) => host.variants(node, library.ways(node)));
    return { depth, general, library, host, plan };
  };
  return { general, withWays };
};
