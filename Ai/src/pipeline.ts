/**
 * The search, stage after stage (ARCHITECTURE.md section 2): a checked
 * target document to a class, a handler per node with its parameters, and the
 * report. Everything here reads the target document and the library, nothing
 * else, and the same input always gives the same output.
 *
 *   check (extract/check) → class (search/classes) → nodes (search/nodes) → select → params → report
 */
import type { Nesting } from '../../Latex-Lib/nesting.ts';
import type { NodeId, WayId } from '../../Latex-Lib/schema/ids.ts';
import type { Library } from '../../Latex-Lib/schema/validate.ts';

import { checkTarget } from './extract/check.ts';
import { matchClass, type ClassMatch } from './search/classes.ts';
import { allowedHandlers, matchKey, topHandlers, type Allowed, type KeyMatch } from './search/nodes.ts';
import { featureWeights, type DescriptionSimilarity, type Scoring } from './search/score.ts';
import { WEIGHTS, type Weights } from './search/weights.ts';
import type { TargetDocument } from './model.ts';
import { placeParams, type Placed } from './search/params.ts';
import { buildReport, type Report } from './search/report.ts';
import { selectTogether, type Group, type Selection } from './search/select.ts';

/** How many handlers per node go on to be chosen together. */
export const TOP = 5;

export type Search = {
  readonly library: Library;
  readonly nesting: Nesting;
  readonly scoring: Scoring;
  readonly embedder: string | null;
  /** The handlers each node allows under a class, worked out once per class. */
  readonly allowed: Map<string, Allowed>;
};

export const searchContext = (library: Library, nesting: Nesting, description?: { readonly similarity: DescriptionSimilarity; readonly embedder: string }, weights: Weights = WEIGHTS): Search => ({
  library,
  nesting,
  scoring: { weights, featureWeight: featureWeights(library), ...(description === undefined ? {} : { description: description.similarity }) },
  embedder: description?.embedder ?? null,
  allowed: new Map(),
});

export type Outcome =
  | { readonly problems: readonly string[] }
  | {
      readonly cls: ClassMatch;
      readonly keys: readonly KeyMatch[];
      readonly allowed: ReadonlyMap<NodeId, Allowed>;
      readonly selection: Selection;
      readonly placed: readonly Placed[];
      readonly report: Report;
    };

export const runSearch = (target: TargetDocument, search: Search): Outcome => {
  const { library } = search;
  const problems = checkTarget(target, library, search.nesting);
  if (problems.length > 0) return { problems };
  const cls = matchClass(target.class, library, search.scoring.description);
  const allowedFor = (node: NodeId): Allowed => {
    const at = `${cls.resolveAs} ${cls.options.join(',')} ${node}`;
    const known = search.allowed.get(at);
    if (known !== undefined) return known;
    const found = allowedHandlers(node, cls, library);
    search.allowed.set(at, found);
    return found;
  };
  const nodes = [...new Set(target.nodes.map((k) => k.node))].sort();
  const allowed = new Map(nodes.map((n) => [n, allowedFor(n)]));
  const keys = target.nodes.map((k, i) => matchKey(i, k, allowed.get(k.node)!, search.scoring));
  // A node's options: the best of each handler over all its keys.
  const groups: Group[] = nodes.map((node) => {
    const mine = keys.filter((k) => k.key.node === node);
    return { node, keys: mine.map((k) => k.index), options: topHandlers(mine.flatMap((k) => k.ranked), TOP) };
  });
  const empty: Selection = { nodes: groups.map((g) => ({ ...g, chosen: null, how: 'general' as const })), total: 0, explored: 0, complete: true };
  const selection = cls.refused === undefined ? selectTogether(groups, cls, library) : empty;
  const placed = placeParams(selection.nodes, target, cls, library);
  const filtered = new Map<NodeId, readonly { way: WayId; reason: string }[]>([...allowed].map(([n, a]) => [n, a.filtered]));
  const report = buildReport({
    source: target.source.id,
    className: target.class.name,
    cls,
    keys: target.nodes,
    selection,
    placed,
    filtered,
    documentKeys: target.document.length,
    weights: search.scoring.weights,
    embedder: search.embedder,
  });
  return { cls, keys, allowed, selection, placed, report };
};
