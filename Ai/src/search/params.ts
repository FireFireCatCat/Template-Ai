/**
 * Parameters (ARCHITECTURE.md section 2, step 7): each chosen handler's preset,
 * with the template's own values over it where the handler has a parameter
 * for them and the value fits. A value with nowhere to go is lost, with why.
 * If the template's values make the chosen set stop resolving, a node goes
 * back to its preset alone, least confident first, and its values are lost.
 */
import { resolve } from '../../../Latex-Lib/engine/resolve.ts';
import type { Json, NodeId, WayId } from '../../../Latex-Lib/schema/ids.ts';
import { paramProblem, withDefaults } from '../../../Latex-Lib/schema/params.ts';
import type { Library } from '../../../Latex-Lib/schema/validate.ts';

import { CONFIDENCE, type TargetDocument } from '../model.ts';
import { refusing, type ClassMatch } from './classes.ts';
import { KINDS } from './nodes.ts';
import type { NodeChoice } from './select.ts';

export type Lost = { readonly name: string; readonly value: Json; readonly why: string };

export type Placed = {
  readonly node: NodeId;
  readonly way: WayId;
  readonly preset: string | null;
  /** Every parameter the handler is given: defaults, then the preset, then the template's values. */
  readonly params: { readonly [name: string]: Json };
  readonly lost: readonly Lost[];
};

export const placeParams = (choices: readonly NodeChoice[], target: TargetDocument, cls: ClassMatch, library: Library): Placed[] => {
  const chosen = choices.filter((c): c is NodeChoice & { chosen: NonNullable<NodeChoice['chosen']> } => c.chosen !== null);
  const planned = chosen.map((c) => {
    const key = library.keys.find((k) => k.id === c.chosen.way && k.node === c.node);
    const base = key === undefined ? { ...c.chosen.params } : withDefaults(key.params, c.chosen.params);
    const own: { [name: string]: Json } = {};
    const lost: Lost[] = [];
    for (const index of c.keys) {
      for (const [name, value] of Object.entries(target.nodes[index]?.params ?? {})) {
        const spec = key?.params[name];
        const why = spec === undefined ? `${c.chosen.way} has no parameter ${name}` : paramProblem(spec, value);
        if (why === undefined) own[name] = value;
        else lost.push({ name, value, why });
      }
    }
    // A node is as confident as its most confident key: high 0, medium -1, low -2.
    const confidence = -Math.min(...c.keys.map((i) => CONFIDENCE.indexOf(target.nodes[i]?.confidence ?? 'low')));
    return { choice: c, base, own, lost, confidence };
  });
  const judge = (): string[] =>
    refusing(resolve(library, {
      classId: cls.resolveAs,
      classOptions: cls.options,
      choices: planned.map((p) => ({ way: p.choice.chosen.way, node: p.choice.node, params: { ...p.base, ...p.own } })),
      kinds: Object.fromEntries(planned.map((p) => [p.choice.node, KINDS[p.choice.node] ?? []])),
    }), cls, false);
  // Least confident first, then by node, so the same set always gives up the same values.
  for (const p of [...planned].sort((a, b) => a.confidence - b.confidence || a.choice.node.localeCompare(b.choice.node))) {
    if (judge().length === 0) break;
    if (Object.keys(p.own).length === 0) continue;
    p.lost.push(...Object.entries(p.own).map(([name, value]) => ({ name, value, why: 'does not go with the other choices' })));
    p.own = {};
  }
  return planned.map((p) => ({ node: p.choice.node, way: p.choice.chosen.way, preset: p.choice.chosen.preset, params: { ...p.base, ...p.own }, lost: p.lost }));
};
