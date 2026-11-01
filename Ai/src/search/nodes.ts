/**
 * The node search (ARCHITECTURE.md section 5): each target key against the
 * handlers of its node, in the library alone. First the filter: a handler
 * goes when it runs in ZeroTeX-NG and, with one of its presets (renamed when
 * the class already defines its names), resolves on its own under the class,
 * leaving aside what another node's choice could supply (`classes.ts`,
 * `refusing`). A handler filtered out is kept with the resolver's reason. Then every
 * handler and preset that goes is scored, best first; ties fall to the way id
 * and then the preset, so the order never depends on how the library was read.
 */
import { resolve } from '../../../Latex-Lib/engine/resolve.ts';
import type { Json, NodeId, WayId } from '../../../Latex-Lib/schema/ids.ts';
import type { HandlerKey } from '../../../Latex-Lib/schema/key.ts';
import type { Library } from '../../../Latex-Lib/schema/validate.ts';
import { ELEMENTS } from '../../../Latex-Lib/nodes/containerBlock.mathElement/statement.ts';

import type { TargetKey } from '../model.ts';
import { refusing, type ClassMatch } from './classes.ts';
import { score, type Candidate, type Scoring } from './score.ts';

/** The kinds a document's nodes use, for the resolver's `{kind}`: every statement kind, and the heading levels every class has. */
export const KINDS: { readonly [node: NodeId]: readonly string[] } = {
  'containerBlock/mathElement': ELEMENTS,
  'paragraph/heading': ['section', 'subsection', 'subsubsection'],
};

/** A handler with a parameter set that resolves on its own under the class. */
export type Variant = { readonly key: HandlerKey; readonly preset: string | null; readonly params: { readonly [name: string]: Json } };

export type Allowed = { readonly variants: readonly Variant[]; readonly filtered: readonly { readonly way: WayId; readonly reason: string }[] };

/** The handlers of a node that can go under the class, each with the presets that resolve. */
export const allowedHandlers = (node: NodeId, cls: ClassMatch, library: Library): Allowed => {
  const variants: Variant[] = [];
  const filtered: { way: WayId; reason: string }[] = [];
  for (const key of library.keys.filter((k) => k.node === node).sort((a, b) => a.id.localeCompare(b.id))) {
    if (key.zerotex === 'no') {
      filtered.push({ way: key.id, reason: 'does not run in ZeroTeX-NG' });
      continue;
    }
    const presets: [string | null, { readonly [name: string]: Json }][] = Object.keys(key.presets).length === 0 ? [[null, {}]] : Object.entries(key.presets).map(([name, p]) => [name, p.params]);
    let first: string | undefined;
    for (const [preset, params] of presets) {
      const tries = 'rename' in key.params ? [params, { ...params, rename: 'yes' }] : [params];
      for (const p of tries) {
        const violations = refusing(resolve(library, { classId: cls.resolveAs, classOptions: cls.options, choices: [{ way: key.id, node, params: p }], kinds: { [node]: KINDS[node] ?? [] } }), cls, true);
        if (violations.length === 0) {
          variants.push({ key, preset, params: p });
          break;
        }
        first ??= violations[0];
      }
    }
    if (!variants.some((v) => v.key === key)) filtered.push({ way: key.id, reason: first ?? 'does not resolve' });
  }
  return { variants, filtered };
};

export type KeyMatch = {
  /** The key's place in the target document's nodes. */
  readonly index: number;
  readonly key: TargetKey;
  /** Every handler and preset that goes, best first. */
  readonly ranked: readonly Candidate[];
  /** Whether any term set any candidate apart from zero: without it the order is the way ids'. */
  readonly signal: boolean;
};

const order = (a: Candidate, b: Candidate): number => b.score - a.score || a.way.localeCompare(b.way) || (a.preset ?? '').localeCompare(b.preset ?? '');

export const matchKey = (index: number, key: TargetKey, allowed: Allowed, scoring: Scoring): KeyMatch => {
  const ranked = allowed.variants.map((v) => score(key, v.key, v.preset, v.params, scoring)).sort(order);
  return { index, key, ranked, signal: ranked.some((c) => c.score > 0) };
};

/** The best preset of each handler, best handler first, the first `k`. */
export const topHandlers = (ranked: readonly Candidate[], k: number): Candidate[] => {
  const seen = new Set<WayId>();
  return [...ranked].sort(order).filter((c) => !seen.has(c.way) && seen.add(c.way)).slice(0, k);
};
