/**
 * The report (ARCHITECTURE.md section 7): every choice explained. For the
 * class, its tier and why. Per node: its keys with their evidence; the
 * handler and preset chosen and how (best, chosen together, General); every
 * score term of the candidates; the handlers filtered out with the
 * resolver's reason; the values lost. And the versions a run depends on.
 */
import type { Evidence } from '../../../Latex-Lib/schema/evidence.ts';
import type { Json, NodeId, WayId } from '../../../Latex-Lib/schema/ids.ts';

import type { ClassMatch } from './classes.ts';
import type { Candidate } from './score.ts';
import type { Weights } from './weights.ts';
import type { Lost, Placed } from './params.ts';
import type { Selection } from './select.ts';

export type NodeReport = {
  readonly node: NodeId;
  readonly keys: readonly { readonly description: string; readonly evidence: readonly Evidence[] }[];
  readonly chosen: { readonly way: WayId; readonly preset: string | null; readonly params: { readonly [name: string]: Json } } | null;
  readonly how: 'best' | 'together' | 'general';
  readonly whyNotBest?: readonly string[];
  readonly candidates: readonly Candidate[];
  readonly filtered: readonly { readonly way: WayId; readonly reason: string }[];
  readonly lost: readonly Lost[];
};

export type Report = {
  readonly source: string;
  readonly class: ClassMatch & { readonly name: string };
  readonly nodes: readonly NodeReport[];
  /** Document-level keys: read, not searched, until the library has handlers for them. */
  readonly documentKeys: number;
  readonly search: { readonly total: number; readonly explored: number; readonly complete: boolean };
  readonly versions: { readonly weights: Weights; readonly embedder: string | null };
};

export const buildReport = (input: {
  readonly source: string;
  readonly className: string;
  readonly cls: ClassMatch;
  readonly keys: readonly { readonly description: string; readonly evidence: readonly Evidence[] }[];
  readonly selection: Selection;
  readonly placed: readonly Placed[];
  readonly filtered: ReadonlyMap<NodeId, readonly { readonly way: WayId; readonly reason: string }[]>;
  readonly documentKeys: number;
  readonly weights: Weights;
  readonly embedder: string | null;
}): Report => ({
  source: input.source,
  class: { ...input.cls, name: input.className },
  nodes: input.selection.nodes.map((n): NodeReport => {
    const placed = input.placed.find((p) => p.node === n.node);
    return {
      node: n.node,
      keys: n.keys.map((i) => input.keys[i] ?? { description: '', evidence: [] }),
      chosen: n.chosen === null ? null : { way: n.chosen.way, preset: n.chosen.preset, params: placed?.params ?? n.chosen.params },
      how: n.how,
      ...(n.whyNotBest === undefined ? {} : { whyNotBest: n.whyNotBest }),
      candidates: n.options,
      filtered: input.filtered.get(n.node) ?? [],
      lost: placed?.lost ?? [],
    };
  }),
  documentKeys: input.documentKeys,
  search: { total: input.selection.total, explored: input.selection.explored, complete: input.selection.complete },
  versions: { weights: input.weights, embedder: input.embedder },
});

const terms = (c: Candidate): string =>
  (['features', 'params', 'packages', 'description'] as const)
    .filter((t) => c.terms[t] !== undefined)
    .map((t) => `${t} ${(c.terms[t] ?? 0).toFixed(2)}`)
    .join(', ') || 'no term';

const cell = (s: string): string => s.replace(/\|/gu, '\\|').replace(/\s+/gu, ' ');

export const renderReport = (r: Report): string => {
  const out: string[] = [`# ${r.source}`, ''];
  out.push(`**Class:** ${r.class.name} → ${r.class.profile ?? 'no profile'} (${r.class.tier}): ${r.class.reason}.${r.class.refused === undefined ? '' : ` **Stopped:** ${r.class.refused}.`}`, '');
  out.push(`Weights ${r.versions.weights.version}; embedder ${r.versions.embedder ?? 'none'}; ${r.search.explored} sets judged${r.search.complete ? '' : ', stopped at the budget'}; ${r.documentKeys} document-level keys not searched.`, '');
  for (const n of r.nodes) {
    out.push(`## ${n.node}`, '');
    for (const k of n.keys) out.push(`- ${cell(k.description)}`);
    out.push('');
    const chosen = n.chosen === null ? "General's way" : `\`${n.chosen.way}\`${n.chosen.preset === null ? '' : ` (${n.chosen.preset})`}`;
    out.push(`**Chosen:** ${chosen}, ${n.how === 'best' ? 'the best match' : n.how === 'together' ? 'chosen to go with the rest' : 'no handler went'}.`);
    if (n.whyNotBest !== undefined) out.push(`The best match does not go with the rest: ${n.whyNotBest.join('; ')}.`);
    out.push('', '| Handler | Preset | Score | Terms |', '|---|---|---|---|');
    for (const c of n.candidates) out.push(`| \`${c.way}\` | ${c.preset ?? '(defaults)'} | ${c.score.toFixed(3)} | ${terms(c)} |`);
    if (n.filtered.length > 0) out.push('', 'Filtered out:', ...n.filtered.map((f) => `- \`${f.way}\`: ${cell(f.reason)}`));
    if (n.lost.length > 0) out.push('', 'Lost:', ...n.lost.map((l) => `- ${l.name} = ${JSON.stringify(l.value)}: ${l.why}`));
    out.push('');
  }
  return out.join('\n');
};
