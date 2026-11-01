/**
 * Choosing together (ARCHITECTURE.md section 6): one handler per node, so the
 * choices go in one document under the class. Each node offers its best few
 * handlers and, last, General's way (no handler, score 0). The search goes
 * depth first, the most constrained node first, best option first, and cuts a
 * branch that cannot beat the best total found or that the resolver refuses.
 *
 * A part-made set is refused only for what more choices cannot mend (a class
 * rule, a conflict, a claim owned twice); a requirement nobody supplies yet
 * (`pkg:natbib` for the citations) waits for the nodes still to choose, and
 * refuses as soon as none of them could supply it (`classes.ts`, `refusing`). The
 * first complete set found takes each node's best option, so when the best
 * options go together the search ends there.
 */
import { resolve, type Choice } from '../../../Latex-Lib/engine/resolve.ts';
import type { NodeId } from '../../../Latex-Lib/schema/ids.ts';
import { matches, withDefaults } from '../../../Latex-Lib/schema/params.ts';
import type { Library } from '../../../Latex-Lib/schema/validate.ts';

import { refusing, type ClassMatch } from './classes.ts';
import { KINDS } from './nodes.ts';
import type { Candidate } from './score.ts';

/** A node to choose for: its keys' places in the target document, and its options, best first. */
export type Group = { readonly node: NodeId; readonly keys: readonly number[]; readonly options: readonly Candidate[] };

export type NodeChoice = Group & {
  /** The handler chosen, or null for General's way. */
  readonly chosen: Candidate | null;
  /** `best`: its best option; `together`: another, because the best did not go with the rest; `general`: none went. */
  readonly how: 'best' | 'together' | 'general';
  /** When the best option was not chosen: why it does not go with the rest. */
  readonly whyNotBest?: readonly string[];
};

export type Selection = {
  readonly nodes: readonly NodeChoice[];
  readonly total: number;
  /** Sets the resolver judged. */
  readonly explored: number;
  /** False when the search stopped at its budget, with the best set found so far. */
  readonly complete: boolean;
};

/** The most sets the resolver judges for one template. */
const BUDGET = 20000;

const choice = (c: Candidate): Choice => ({ way: c.way, node: c.node, params: c.params });

export const selectTogether = (groups: readonly Group[], cls: ClassMatch, library: Library): Selection => {
  const nodes = [...groups].sort((a, b) => a.options.length - b.options.length || a.node.localeCompare(b.node));
  const kinds = Object.fromEntries(nodes.map((g) => [g.node, KINDS[g.node] ?? []]));
  const judge = (cs: readonly Candidate[]): string[] => refusing(resolve(library, { classId: cls.resolveAs, classOptions: cls.options, choices: cs.map(choice), kinds }), cls, false);
  // What the rest of the nodes could add at most: score, packages, claims.
  const ahead = nodes.map((_, i) => nodes.slice(i).reduce((s, g) => s + Math.max(0, g.options[0]?.score ?? 0), 0));
  const supplies = (c: Candidate): { pkgs: string[]; claims: string[] } => {
    const key = library.keys.find((k) => k.id === c.way && k.node === c.node);
    const params = key === undefined ? {} : withDefaults(key.params, c.params);
    return { pkgs: (key?.loads ?? []).filter((l) => matches(l.when, params)).map((l) => l.pkg), claims: [...(key?.claims ?? [])] };
  };
  const later = nodes.map((_, i) => {
    const offers = nodes.slice(i + 1).flatMap((g) => g.options.map(supplies));
    return { pkgs: new Set(offers.flatMap((o) => o.pkgs)), claims: new Set(offers.flatMap((o) => o.claims)) };
  });
  /** Whether a node still to choose could mend this sentence. */
  const mendable = (v: string, i: number): boolean => {
    const pkg = /: needs package (\S+)$/u.exec(v)?.[1];
    if (pkg !== undefined) return later[i]?.pkgs.has(pkg) ?? false;
    const claim = /: needs something to own (\S+)$/u.exec(v)?.[1];
    if (claim !== undefined) return later[i]?.claims.has(claim) ?? false;
    return false;
  };
  let best: { total: number; picks: (Candidate | null)[] } | undefined;
  let explored = 0;
  let complete = true;

  const explore = (i: number, total: number, picks: (Candidate | null)[]): void => {
    if (!complete || (best !== undefined && total + (ahead[i] ?? 0) <= best.total)) return;
    if (i === nodes.length) {
      explored++;
      if (judge(picks.filter((p): p is Candidate => p !== null)).length === 0) best = { total, picks: [...picks] };
      return;
    }
    for (const option of [...(nodes[i]?.options ?? []), null]) {
      if (explored >= BUDGET) {
        complete = false;
        return;
      }
      const next = [...picks, option];
      if (option !== null) {
        explored++;
        // A part-made set is refused for what the nodes still to choose cannot mend.
        if (judge(next.filter((p): p is Candidate => p !== null)).some((v) => !mendable(v, i))) continue;
      }
      explore(i + 1, total + (option?.score ?? 0), next);
    }
  };
  explore(0, 0, []);

  const picks = best?.picks ?? nodes.map(() => null);
  const chosen = nodes.map((g, i): NodeChoice => {
    const pick = picks[i] ?? null;
    const top = g.options[0];
    const how = pick === null ? 'general' : pick.way === top?.way ? 'best' : 'together';
    if (how === 'best' || top === undefined) return { ...g, chosen: pick, how };
    // The best option in place of this choice, with every other choice kept.
    const others = picks.filter((p, j): p is Candidate => p !== null && j !== i);
    return { ...g, chosen: pick, how, whyNotBest: judge([...others, top]) };
  });
  return { nodes: chosen.sort((a, b) => a.node.localeCompare(b.node)), total: best?.total ?? 0, explored, complete };
};
