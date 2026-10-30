/**
 * A minimal key (ARCHITECTURE.md section 3): what a way prints and loads, its
 * one default preset, the CTAN page it comes from, what it needs of the class
 * (`requires`), and the class rules a document or a measurement gives; parent
 * rules come with the matrix and the explainer. The key stays a draft.
 */
import type { Evidence, Support } from './evidence.ts';
import type { Feature } from './features.ts';
import type { ClassId, NodeId, WayId } from './ids.ts';
import type { ClassRule, Definition, HandlerKey, OrderRule, PackageLoad, PackageRule, Requirement } from './key.ts';
import type { ParamPredicate, ParamSchema, Preset } from './params.ts';
import type { ContextChange, ContextNeed } from '../contexts.ts';
import type { Exclusive } from './features.ts';

/** A package's CTAN page (`latex-base` for the kernel). */
export const ctan = (pkg: string): Evidence => ({ kind: 'manual', of: pkg, section: 'CTAN package page', url: `https://ctan.org/pkg/${pkg}` });

export type MinimalWay = {
  readonly id: WayId;
  readonly node: NodeId;
  readonly description: string;
  /** The CTAN packages it is documented in, for its evidence. */
  readonly ctan: readonly string[];
  readonly features?: readonly Feature[];
  readonly params?: ParamSchema;
  readonly presets?: { readonly [name: string]: Preset };
  readonly loads?: readonly PackageLoad[];
  readonly defines?: readonly Definition[];
  readonly claims?: readonly Exclusive[];
  readonly requires?: readonly Requirement[];
  readonly only?: readonly ClassId[];
  /** Classes it must not be used under, each with its reason and evidence. */
  readonly deny?: readonly ClassRule[];
  readonly conflicts?: readonly PackageRule[];
  readonly loadOrder?: readonly OrderRule[];
  readonly gives?: ContextChange;
  /** What it gives below only when its parameters match (a box that does not break: `breakable: false`). */
  readonly givesWhen?: readonly { readonly when: ParamPredicate; readonly gives: ContextChange }[];
  readonly needs?: ContextNeed;
  readonly zerotex?: Support;
};

export const minimal = (w: MinimalWay): HandlerKey => {
  const evidence = w.ctan.map(ctan);
  return {
    id: w.id,
    node: w.node,
    description: w.description,
    features: w.features ?? [],
    params: w.params ?? {},
    presets: w.presets ?? { default: { description: w.description.split('.')[0] ?? w.description, features: w.features ?? [], params: {}, evidence } },
    zerotex: w.zerotex ?? 'untested',
    loads: w.loads ?? [],
    defines: w.defines ?? [],
    claims: w.claims ?? [],
    requires: w.requires ?? [],
    classes: { deny: w.deny ?? [], ...(w.only === undefined ? {} : { only: w.only }) },
    packages: { conflicts: w.conflicts ?? [], ...(w.loadOrder === undefined ? {} : { loadOrder: w.loadOrder }) },
    context: { gives: w.gives ?? {}, ...(w.givesWhen === undefined ? {} : { givesWhen: w.givesWhen }), needs: w.needs ?? {} },
    parents: {},
    evidence,
    status: 'draft',
  };
};
