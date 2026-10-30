/**
 * A handler where it sits (ARCHITECTURE.md 4.5, "when the document is
 * emitted"): the compiler tells a realization its parent, and the handler's
 * key says what changes there. An adapt rule for every parent way sets its
 * parameters; a deny for every parent way emits the fallback instead.
 *
 * Only rules for every parent way (`way: '*'`) apply here. The compiler gives
 * a realization the parent's kind, not the parent's way, until the ancestor
 * context change lands in Flouest (section 7, change 2); a rule for one
 * parent way waits for it.
 */
import { parentsOf, type Nesting } from '../nesting.ts';
import type { NodeId, WayId } from '../schema/ids.ts';
import type { HandlerKey } from '../schema/key.ts';
import type { Realization } from '../schema/realization.ts';

export type Handler = (params?: { readonly [name: string]: unknown }) => Realization;

/** Flouest's `parentType` for a node: a container's or paragraph's kind, a fixed-shape node's type (`table_cell`). */
export const parentTypeOf = (node: NodeId): string => node.split('/').at(-1) ?? node;

export const adapted = (input: {
  readonly key: HandlerKey;
  readonly params: { readonly [name: string]: unknown };
  readonly handlerOf: (way: WayId) => Handler | undefined;
  readonly keyOf: (way: WayId) => HandlerKey | undefined;
  readonly nesting: Nesting;
}): Realization => {
  const { key, params } = input;
  const own = input.handlerOf(key.id);
  if (own === undefined) throw new Error(`adapt: no handler for ${key.id}`);
  const byType = new Map(parentsOf(input.nesting, key.node).map((node) => [parentTypeOf(node), node]));
  const cache = new Map<string, Realization>();
  const at = (parentType: string | undefined): Realization => {
    const kind = parentType ?? '';
    let realization = cache.get(kind);
    if (realization !== undefined) return realization;
    const node = byType.get(kind);
    const entry = node === undefined ? undefined : (key.parents[node] ?? key.parents['*']);
    const fallback = entry?.fallback ?? key.fallback;
    const denied = (entry?.deny ?? []).some((r) => r.way === '*' && r.when === undefined);
    if (denied && fallback !== undefined) {
      const to = input.keyOf(fallback.way);
      const handler = input.handlerOf(fallback.way);
      if (to === undefined || handler === undefined) throw new Error(`adapt: ${key.id} falls back to ${fallback.way}, which has no handler`);
      realization = handler(fallback.preset === undefined ? {} : (to.presets[fallback.preset]?.params ?? {}));
    } else {
      const set = (entry?.adapt ?? []).filter((r) => r.way === '*' && r.when === undefined).reduce<{ readonly [name: string]: unknown }>((p, r) => ({ ...p, ...r.set }), {});
      realization = own({ ...params, ...set });
    }
    cache.set(kind, realization);
    return realization;
  };
  return {
    preamble: (p, parentType, ...rest) => at(parentType).preamble(p, parentType, ...rest),
    emit: (node, content, context, parentType, location) => at(parentType).emit(node, content, context, parentType, location),
  };
};
