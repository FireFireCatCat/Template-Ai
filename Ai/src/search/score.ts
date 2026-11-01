/**
 * The score (ARCHITECTURE.md section 5): how close one target key is to one
 * handler with one of its presets, as a sum of terms, each between 0 and 1:
 *
 * - features: weighted Jaccard of the key's features against the preset's and
 *   the handler's, a rare feature weighing more;
 * - params: each of the key's parameters against the preset's value (or the
 *   default), compared by its type; a parameter the handler lacks scores 0;
 * - packages: the share of the key's packages the handler loads with that
 *   preset;
 * - description: cosine of the key's description against the preset's or the
 *   handler's, from the embeddings (A2).
 *
 * A term the key says nothing about (no features, no parameters…) is absent,
 * not 0: it neither helps nor hurts any handler.
 */
import type { Feature } from '../../../Latex-Lib/schema/features.ts';
import type { Json, NodeId, WayId } from '../../../Latex-Lib/schema/ids.ts';
import type { HandlerKey } from '../../../Latex-Lib/schema/key.ts';
import { matches, withDefaults, type ParamSpec } from '../../../Latex-Lib/schema/params.ts';
import type { Library } from '../../../Latex-Lib/schema/validate.ts';

import type { TargetKey } from '../model.ts';
import type { Weights } from './weights.ts';

export type Terms = { readonly features?: number; readonly params?: number; readonly packages?: number; readonly description?: number };

/** One handler with one preset (or its defaults, `preset: null`), scored against a key. */
export type Candidate = {
  readonly node: NodeId;
  readonly way: WayId;
  readonly preset: string | null;
  /** The parameters the candidate stands for: the preset's, with `rename` when the class needs it. */
  readonly params: { readonly [name: string]: Json };
  readonly score: number;
  readonly terms: Terms;
};

/** Cosine of a key's description against a library entry's, when both have a vector. */
export type DescriptionSimilarity = (description: string, entries: readonly string[]) => number | undefined;

/** A feature's weight: rarer across handlers and presets, heavier (log(1 + N / df)). */
export const featureWeights = (library: Library): Map<Feature, number> => {
  const sets = library.keys.flatMap((k) => [k.features, ...Object.values(k.presets).map((p) => [...p.features, ...k.features])]);
  const df = new Map<Feature, number>();
  for (const set of sets) for (const f of new Set(set)) df.set(f, (df.get(f) ?? 0) + 1);
  return new Map([...df].map(([f, n]) => [f, Math.log(1 + sets.length / n)]));
};

const weightedJaccard = (a: readonly Feature[], b: readonly Feature[], weight: Map<Feature, number>): number => {
  const [x, y] = [new Set(a), new Set(b)];
  const w = (f: Feature): number => weight.get(f) ?? Math.log(1 + 1000);
  const union = [...new Set([...x, ...y])];
  const total = union.reduce((s, f) => s + w(f), 0);
  return total === 0 ? 0 : union.filter((f) => x.has(f) && y.has(f)).reduce((s, f) => s + w(f), 0) / total;
};

/** A TeX length in points, when it is a plain number and unit (an em taken at 10pt). */
const UNITS: { readonly [unit: string]: number } = { pt: 1, pc: 12, in: 72.27, bp: 72.27 / 72, cm: 28.4528, mm: 2.84528, dd: 1238 / 1157, cc: (12 * 1238) / 1157, sp: 1 / 65536, em: 10, ex: 4.3, mu: 10 / 18 };
const points = (value: string): number | undefined => {
  const m = /^\s*(-?(?:\d+(?:\.\d+)?|\.\d+))\s*(pt|pc|in|bp|cm|mm|dd|cc|sp|em|ex|mu)\s*$/u.exec(value);
  return m === null ? (value.trim() === '0' ? 0 : undefined) : Number(m[1]) * (UNITS[m[2] ?? 'pt'] ?? 1);
};

/** xcolor's base colours, as RGB in [0, 1]. */
const BASE: { readonly [name: string]: readonly [number, number, number] } = {
  black: [0, 0, 0], white: [1, 1, 1], red: [1, 0, 0], green: [0, 1, 0], blue: [0, 0, 1], cyan: [0, 1, 1], magenta: [1, 0, 1], yellow: [1, 1, 0],
  gray: [0.5, 0.5, 0.5], darkgray: [0.25, 0.25, 0.25], lightgray: [0.75, 0.75, 0.75], brown: [0.75, 0.5, 0.25], lime: [0.75, 1, 0], olive: [0.5, 0.5, 0],
  orange: [1, 0.5, 0], pink: [1, 0.75, 0.75], purple: [0.75, 0, 0.25], teal: [0, 0.5, 0.5], violet: [0.5, 0, 0.5],
};
/** A colour as RGB: a base name, `#RRGGBB` or `RRGGBB`, or an xcolor mix (`blue!20`, `red!50!black`). */
const rgb = (value: string): readonly [number, number, number] | undefined => {
  const v = value.trim().toLowerCase();
  const hex = /^#?([0-9a-f]{6})$/u.exec(v);
  if (hex !== null) return [0, 2, 4].map((i) => parseInt(hex[1]!.slice(i, i + 2), 16) / 255) as [number, number, number];
  const parts = v.split('!');
  let colour = BASE[parts[0] ?? ''];
  for (let i = 1; colour !== undefined && i < parts.length; i += 2) {
    const share = Number(parts[i]) / 100;
    const other = BASE[parts[i + 1] ?? 'white'];
    if (!Number.isFinite(share) || other === undefined) return undefined;
    colour = colour.map((c, j) => share * c + (1 - share) * (other[j] ?? 0)) as [number, number, number];
  }
  return colour;
};

const tokens = (s: string): Set<string> => new Set(s.toLowerCase().match(/\\?[a-z0-9]+/gu) ?? []);

/** How alike two values of one parameter are, in [0, 1], by the parameter's type. */
export const valueSimilarity = (spec: ParamSpec, a: Json, b: Json | undefined): number => {
  if (b === undefined) return 0;
  if (JSON.stringify(a) === JSON.stringify(b)) return 1;
  if (spec.type === 'number' && typeof a === 'number' && typeof b === 'number') return Math.max(0, 1 - Math.abs(a - b) / Math.max(Math.abs(a), Math.abs(b), 1e-9));
  if (spec.type === 'dimen' && typeof a === 'string' && typeof b === 'string') {
    const [x, y] = [points(a), points(b)];
    if (x !== undefined && y !== undefined) return Math.max(0, 1 - Math.abs(x - y) / Math.max(Math.abs(x), Math.abs(y), 1e-9));
  }
  if (spec.type === 'color' && typeof a === 'string' && typeof b === 'string') {
    const [x, y] = [rgb(a), rgb(b)];
    if (x !== undefined && y !== undefined) return 1 - Math.hypot(x[0] - y[0], x[1] - y[1], x[2] - y[2]) / Math.sqrt(3);
  }
  if ((spec.type === 'string' || spec.type === 'tex') && typeof a === 'string' && typeof b === 'string') {
    const [x, y] = [tokens(a), tokens(b)];
    const union = new Set([...x, ...y]).size;
    return union === 0 ? 0 : [...x].filter((t) => y.has(t)).length / union;
  }
  return 0;
};

/** The library entries whose description stands for a candidate: its preset's and its handler's (ids as `Latex-Lib/embeddings.ts` writes them). */
export const descriptionEntries = (key: HandlerKey, preset: string | null): string[] => [`handler:${key.node}:${key.id}`, ...(preset === null ? [] : [`preset:${key.node}:${key.id}:${preset}`])];

export type Scoring = { readonly weights: Weights; readonly featureWeight: Map<Feature, number>; readonly description?: DescriptionSimilarity };

/** One key against one handler with these parameters (a preset's, perhaps renamed). */
export const score = (target: TargetKey, key: HandlerKey, preset: string | null, params: { readonly [name: string]: Json }, scoring: Scoring): Candidate => {
  const terms: { -readonly [K in keyof Terms]: Terms[K] } = {};
  if (target.features.length > 0) terms.features = weightedJaccard(target.features, [...key.features, ...(preset === null ? [] : (key.presets[preset]?.features ?? []))], scoring.featureWeight);
  const asked = Object.entries(target.params);
  if (asked.length > 0) {
    const values = withDefaults(key.params, params);
    terms.params = asked.reduce((s, [name, value]) => s + (key.params[name] === undefined ? 0 : valueSimilarity(key.params[name]!, value, values[name])), 0) / asked.length;
  }
  if (target.packages.length > 0) {
    const values = withDefaults(key.params, params);
    const loaded = new Set(key.loads.filter((l) => matches(l.when, values)).map((l) => l.pkg));
    terms.packages = target.packages.filter((p) => loaded.has(p.pkg)).length / target.packages.length;
  }
  const cosine = target.description.trim() === '' ? undefined : scoring.description?.(target.description, descriptionEntries(key, preset));
  if (cosine !== undefined) terms.description = Math.max(0, cosine);
  const w = scoring.weights;
  const total = (terms.features ?? 0) * w.features + (terms.params ?? 0) * w.params + (terms.packages ?? 0) * w.packages + (terms.description ?? 0) * w.description;
  // Rounded, so a last-digit difference between machines never reorders candidates.
  return { node: key.node, way: key.id, preset, params, score: Math.round(total * 1e6) / 1e6, terms };
};
