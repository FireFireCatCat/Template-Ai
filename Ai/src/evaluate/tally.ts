/**
 * Evaluation 1 (ARCHITECTURE.md section 8): the search alone, scored on gold.
 * Each Solution file's target document goes through the search without its
 * answers; then:
 *
 * - the class: whether the profile found is the research's (the class's own,
 *   or the one a shipped class builds on), by tier;
 * - each node key whose answer is a library way: where that way ranks among
 *   the handlers the search allows (top 1, 3, 5, against chance), or that the
 *   class filtered it out; split by whether any term gave the search a signal;
 * - each node: whether the handler chosen together is one the research names.
 *
 * Keys answered by a way the library lacks are counted, not scored.
 */
import type { NodeId } from '../../../Latex-Lib/schema/ids.ts';

import { topHandlers } from '../search/nodes.ts';
import type { Outcome } from '../pipeline.ts';
import type { Gold } from './gold.ts';

type Rate = { scored: number; right: number };
type Ranks = { scored: number; top1: number; top3: number; top5: number; chance: number };

export type Tally = {
  templates: number;
  invalid: number;
  refused: number;
  incomplete: number;
  class: Rate & { byTier: { [tier: string]: Rate } };
  keys: { lacking: number; filtered: number; filteredWhy: { [reason: string]: number }; all: Ranks; signal: Ranks; noSignal: Ranks; byNode: { [node: NodeId]: Ranks & { filtered: number } } };
  select: Rate & { general: number; together: number };
};

const ranks = (): Ranks => ({ scored: 0, top1: 0, top3: 0, top5: 0, chance: 0 });
const count = (r: Ranks, rank: number, choices: number): void => {
  r.scored++;
  if (rank === 1) r.top1++;
  if (rank <= 3) r.top3++;
  if (rank <= 5) r.top5++;
  r.chance += choices === 0 ? 0 : 1 / choices;
};

export const newTally = (): Tally => ({
  templates: 0,
  invalid: 0,
  refused: 0,
  incomplete: 0,
  class: { scored: 0, right: 0, byTier: {} },
  keys: { lacking: 0, filtered: 0, filteredWhy: {}, all: ranks(), signal: ranks(), noSignal: ranks(), byNode: {} },
  select: { scored: 0, right: 0, general: 0, together: 0 },
});

/** One template's outcome against its answers, added to the tally. */
export const scoreOutcome = (tally: Tally, gold: Gold, outcome: Outcome): void => {
  tally.templates++;
  if ('problems' in outcome) {
    tally.invalid++;
    return;
  }
  if (outcome.cls.refused !== undefined) tally.refused++;
  if (!outcome.selection.complete) tally.incomplete++;
  const answer = gold.class.answer.id ?? gold.class.answer.base;
  if (answer !== null) {
    const tier = (tally.class.byTier[outcome.cls.tier] ??= { scored: 0, right: 0 });
    tally.class.scored++;
    tier.scored++;
    if (outcome.cls.profile === answer) {
      tally.class.right++;
      tier.right++;
    }
  }
  gold.nodes.forEach((g, i) => {
    const way = g.answer.way;
    if (way === null) {
      tally.keys.lacking++;
      return;
    }
    const node = (tally.keys.byNode[g.key.node] ??= { ...ranks(), filtered: 0 });
    const allowed = outcome.allowed.get(g.key.node);
    const why = allowed?.filtered.find((f) => f.way === way)?.reason;
    if (why !== undefined) {
      tally.keys.filtered++;
      node.filtered++;
      const reason = why.replace(/^[^:]+: /u, '');
      tally.keys.filteredWhy[reason] = (tally.keys.filteredWhy[reason] ?? 0) + 1;
      return;
    }
    const match = outcome.keys[i];
    if (match === undefined) return;
    const handlers = topHandlers(match.ranked, Infinity);
    const rank = handlers.findIndex((c) => c.way === way) + 1 || Infinity;
    count(tally.keys.all, rank, handlers.length);
    count(match.signal ? tally.keys.signal : tally.keys.noSignal, rank, handlers.length);
    count(node, rank, handlers.length);
  });
  for (const n of outcome.selection.nodes) {
    const answers = new Set(n.keys.map((i) => gold.nodes[i]?.answer.way).filter((w): w is string => w != null));
    if (answers.size === 0) continue;
    tally.select.scored++;
    if (n.chosen !== null && answers.has(n.chosen.way)) tally.select.right++;
    if (n.how === 'general') tally.select.general++;
    if (n.how === 'together') tally.select.together++;
  }
};

const pct = (n: number, of: number): string => (of === 0 ? '–' : `${((100 * n) / of).toFixed(1)}%`);
const rankRow = (name: string, r: Ranks): string => `| ${name} | ${r.scored} | ${pct(r.top1, r.scored)} | ${pct(r.top3, r.scored)} | ${pct(r.top5, r.scored)} | ${pct(r.chance, r.scored)} |`;

export const renderTally = (t: Tally, heading: string): string => {
  const k = t.keys;
  return [
    `# ${heading}`,
    '',
    `${t.templates} templates; ${t.invalid} target documents failed the check; ${t.refused} stopped at a class that does not run in ZeroTeX-NG; ${t.incomplete} choices stopped at the search budget.`,
    '',
    '## Class',
    '',
    `The profile found is the research's for ${t.class.right} of ${t.class.scored} templates whose answer is a profile (${pct(t.class.right, t.class.scored)}).`,
    '',
    '| Tier | Templates | Right |',
    '|---|---|---|',
    ...Object.entries(t.class.byTier)
      .sort((a, b) => b[1].scored - a[1].scored)
      .map(([tier, r]) => `| ${tier} | ${r.scored} | ${pct(r.right, r.scored)} |`),
    '',
    '## Node keys',
    '',
    `${k.lacking} keys are answered by a way the library lacks and are not scored. Of the rest, the class filtered the research's handler out for ${k.filtered}; the others rank as below. "Chance" is the top-1 rate of picking a handler at random. A key with no signal gave no term anything to compare, so its order is the way ids'.`,
    '',
    '| Keys | Scored | Top 1 | Top 3 | Top 5 | Chance |',
    '|---|---|---|---|---|---|',
    rankRow('all', k.all),
    rankRow('with a signal', k.signal),
    rankRow('with no signal', k.noSignal),
    '',
    '| Node | Scored | Top 1 | Top 3 | Top 5 | Chance | Filtered |',
    '|---|---|---|---|---|---|---|',
    ...Object.entries(k.byNode)
      .sort((a, b) => b[1].scored - a[1].scored)
      .map(([node, r]) => `${rankRow(`\`${node}\``, r)} ${r.filtered} |`),
    '',
    'Why the class filtered the research\'s handler out:',
    '',
    ...Object.entries(k.filteredWhy)
      .sort((a, b) => b[1] - a[1])
      .slice(0, 10)
      .map(([why, n]) => `- ${n}: ${why}`),
    '',
    '## Choosing together',
    '',
    `The handler chosen is one the research names for ${t.select.right} of ${t.select.scored} nodes (${pct(t.select.right, t.select.scored)}); ${t.select.together} took another handler to go with the rest, ${t.select.general} kept General's way.`,
    '',
  ].join('\n');
};
