/**
 * The plan (ARCHITECTURE.md section 5, stage 3): every branch to test, each
 * with an id made from its own path.
 *
 * Ported from Flouest's split tree (`splitting.ts`, ADR-206). Each place
 * becomes one node per variant of its node, and everything below the place is
 * split again under each of them, so a root-to-leaf path is one branch: one
 * variant of every node on it, every combination of them (ADR-199).
 *
 * What changes is that no choice depends on position (section 6). Flouest
 * rotates each variant's members through one counter and numbers branches in
 * order, so one inserted variant moves every member after it. Here the member
 * a node takes comes from a hash of the branch's own path above it, the node
 * and its variant. Adding a way adds branches and moves none: every branch
 * that existed keeps its path, so its id.
 *
 * A member the host keeps only under one parent's values (`Member.needs`) is
 * taken only there. A variant none of whose members can sit under the parent
 * it meets is stranded there: that place gets no node of it.
 *
 * Hashing does not promise that the first `cover` members of a variant are
 * each taken, as Flouest's rotation does. So every one of them no branch took
 * gets one more branch, as in Flouest: the node alone at its shallowest place,
 * each node above at its first variant. A top-up branch's path depends only on
 * its own member, so it too keeps its id. When a new way's branches take a
 * member that was topped up, that top-up branch leaves the plan; its document
 * stays filed.
 *
 * Whether a branch carries the marked runs or the escape run (Flouest
 * ADR-201) is read from its id as well (`markedOf`).
 */
import { canonical, hashJson } from './hash.ts';
import { branchId, variantKey } from './ids.ts';
import type { BranchId, BranchSpec, HostVariant, Member, MemberValues, NestingNode, NestingTree, NodeId, PathStep, Variant } from './model.ts';

/** A node's variants, as the host holds them under the library's ways. */
export type VariantsOf = (node: NodeId) => readonly HostVariant[];

/** How one variant of one node was used: its places (top-ups included) and the members taken there. */
export type VariantUse = {
  readonly node: NodeId;
  readonly variant: string;
  readonly places: number;
  /** Each member taken, by its index in the host's list, ascending. */
  readonly shown: readonly number[];
  readonly members: number;
  readonly cover: number;
};

export type Plan = {
  /** In the order of the split: the tree's branches, then the top-ups. */
  readonly branches: readonly BranchSpec[];
  readonly toppedUp: readonly BranchId[];
  /** `node variant` where no member could sit under the parent met, so that place has no node of the variant. */
  readonly stranded: readonly string[];
  /** Nodes the nesting holds that no variant covers: nothing below them is planned. */
  readonly bare: readonly NodeId[];
  readonly uses: readonly VariantUse[];
};

/** Whether the branch carries the marked runs (else the escape run): half of all ids, by their last hex digit. */
export const markedOf = (id: BranchId): boolean => Number.parseInt(id.slice(-1), 16) % 2 === 1;

/** A number from 0 to `n` - 1, the same for the same seed. */
const pick = (seed: string, n: number): number => Number.parseInt(hashJson(seed).slice(0, 12), 16) % n;

/** Whether `values` hold every one of `wanted`; a host may add values of its own beside them (a library way's preset). */
const holds = (values: MemberValues, wanted: MemberValues): boolean =>
  Object.entries(wanted).every(([name, value]) => canonical(values[name] ?? null) === canonical(value));

/** Whether a member can sit under `parent` (the step above it, if any): it needs no parent, or that one holding those values. */
export const fits = (member: Member, parent: PathStep | undefined): boolean =>
  member.needs === undefined || (parent !== undefined && parent.node === member.needs.node && holds(parent.member, member.needs.values));

/** The member a node takes at a variant under `above`: a hash of all three, among the members that fit the parent. */
const memberAt = (above: readonly PathStep[], node: NodeId, hv: HostVariant): number | undefined => {
  const candidates = hv.members.flatMap((member, i) => (fits(member, above.at(-1)) ? [i] : []));
  if (candidates.length === 0) return undefined;
  return candidates[pick(canonical({ above, node, variant: hv.variant }), candidates.length)];
};

const stepOf = (node: NodeId, hv: HostVariant, index: number): PathStep => ({ node, variant: hv.variant, member: hv.members[index]?.values ?? {} });

/**
 * A node at one variant and member alone, at its shallowest place (`chain`
 * ends with it): each node above at its first variant, or, right above, the
 * variant holding the parent values the member needs. Each step's variant
 * and member, or nothing when no member above lets it sit there.
 */
const placeAlone = (
  chain: readonly NodeId[],
  hv: HostVariant,
  index: number,
  variantsFor: (node: NodeId) => readonly HostVariant[],
): { readonly path: PathStep[]; readonly taken: readonly (readonly [NodeId, HostVariant, number])[] } | undefined => {
  const target = hv.members[index];
  if (target === undefined) return undefined;
  const path: PathStep[] = [];
  const taken: [NodeId, HostVariant, number][] = [];
  for (const [d, node] of chain.slice(0, -1).entries()) {
    const needs = d === chain.length - 2 ? target.needs : undefined;
    let at: [HostVariant, number] | undefined;
    if (needs !== undefined && needs.node === node) {
      for (const candidate of variantsFor(node)) {
        const i = candidate.members.findIndex((m) => holds(m.values, needs.values) && fits(m, path.at(-1)));
        if (i >= 0) {
          at = [candidate, i];
          break;
        }
      }
    } else {
      const first = variantsFor(node)[0];
      const i = first === undefined ? undefined : memberAt(path, node, first);
      if (first !== undefined && i !== undefined) at = [first, i];
    }
    if (at === undefined) return undefined;
    path.push(stepOf(node, at[0], at[1]));
    taken.push([node, at[0], at[1]]);
  }
  if (!fits(target, path.at(-1))) return undefined;
  const node = chain.at(-1) ?? '';
  path.push(stepOf(node, hv, index));
  taken.push([node, hv, index]);
  return { path, taken };
};

/** A node's variants, asked of the host once each. */
export const remembered = (variantsOf: VariantsOf) => {
  const known = new Map<NodeId, readonly HostVariant[]>();
  return (node: NodeId): readonly HostVariant[] => {
    let list = known.get(node);
    if (list === undefined) {
      list = variantsOf(node);
      known.set(node, list);
    }
    return list;
  };
};

/** Each node's shallowest place: the nodes above it, outermost first (Flouest's `shallowestPlaces`). */
const shallowestPlaces = (roots: readonly NestingNode[]): Map<NodeId, NodeId[]> => {
  const places = new Map<NodeId, NodeId[]>();
  let level = roots.map((node) => ({ node, up: [] as NodeId[] }));
  while (level.length > 0) {
    for (const { node, up } of level) if (!places.has(node.node)) places.set(node.node, up);
    level = level.flatMap(({ node, up }) => node.children.map((child) => ({ node: child, up: [...up, node.node] })));
  }
  return places;
};

export const planBranches = (nesting: NestingTree, variantsOf: VariantsOf): Plan => {
  const variantsFor = remembered(variantsOf);
  const uses = new Map<string, { node: NodeId; variant: string; places: number; shown: Set<number>; members: number; cover: number }>();
  const record = (node: NodeId, hv: HostVariant, index: number): void => {
    const key = variantKey(hv.variant);
    const at = `${node} ${key}`;
    const use = uses.get(at) ?? { node, variant: key, places: 0, shown: new Set<number>(), members: hv.members.length, cover: hv.cover };
    use.places++;
    use.shown.add(index);
    uses.set(at, use);
  };
  const stranded = new Set<string>();
  const bare = new Set<NodeId>();

  const branches: BranchSpec[] = [];
  const split = (place: NestingNode, above: readonly PathStep[]): void => {
    const variants = variantsFor(place.node);
    if (variants.length === 0) bare.add(place.node);
    for (const hv of variants) {
      const index = memberAt(above, place.node, hv);
      if (index === undefined) {
        stranded.add(`${place.node} ${variantKey(hv.variant)}`);
        continue;
      }
      record(place.node, hv, index);
      const path = [...above, stepOf(place.node, hv, index)];
      if (place.children.length === 0) branches.push({ id: branchId(path), path });
      else for (const child of place.children) split(child, path);
    }
  };
  for (const root of nesting.roots) split(root, []);

  // Every member of each cover no branch took: the node alone at its shallowest place.
  const shallowest = shallowestPlaces(nesting.roots);
  const toppedUp: BranchId[] = [];
  const topUp = (chain: readonly NodeId[], hv: HostVariant, index: number): BranchSpec | undefined => {
    const placed = placeAlone(chain, hv, index, variantsFor);
    if (placed === undefined) return undefined;
    for (const [n, v, i] of placed.taken) record(n, v, i);
    return { id: branchId(placed.path), path: placed.path };
  };
  for (const [node, above] of shallowest) {
    for (const hv of variantsFor(node)) {
      const shown = uses.get(`${node} ${variantKey(hv.variant)}`)?.shown;
      for (let i = 0; i < Math.min(hv.cover, hv.members.length); i++) {
        if (shown?.has(i)) continue;
        const branch = topUp([...above, node], hv, i);
        if (branch === undefined) {
          stranded.add(`${node} ${variantKey(hv.variant)} member ${i}`);
          continue;
        }
        branches.push(branch);
        toppedUp.push(branch.id);
      }
    }
  }

  return {
    branches,
    toppedUp,
    stranded: [...stranded],
    bare: [...bare],
    uses: [...uses.values()].map((u) => ({ ...u, shown: [...u.shown].sort((a, b) => a - b) })),
  };
};

/** What a solo branch stands for: a node at a variant, with or without the marked runs. */
export const soloKey = (node: NodeId, variant: Variant, marked: boolean): string => canonical({ node, variant, marked });

/**
 * The solo branches (ARCHITECTURE.md section 5, stage 2): each variant of each
 * node alone, placed as a top-up is (`placeAlone`) with its first member that
 * can sit there, once with the marked runs and once with the escape run. A
 * matrix branch's failure that the solo branch of one of its steps shows too
 * comes from that step's way, not from where the branch sits (`origin.ts`).
 */
export const soloBranches = (nesting: NestingTree, variantsOf: VariantsOf): BranchSpec[] => {
  const variantsFor = remembered(variantsOf);
  const solos: BranchSpec[] = [];
  for (const [node, above] of shallowestPlaces(nesting.roots)) {
    for (const hv of variantsFor(node)) {
      let placed: ReturnType<typeof placeAlone>;
      for (let i = 0; i < hv.members.length && placed === undefined; i++) placed = placeAlone([...above, node], hv, i, variantsFor);
      if (placed === undefined) continue;
      for (const marked of [false, true]) solos.push({ id: branchId(placed.path, marked), path: placed.path, marked });
    }
  }
  return solos;
};
