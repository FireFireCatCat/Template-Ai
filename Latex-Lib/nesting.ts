/**
 * The parent universe (ARCHITECTURE.md section 7, Nesting): which node may sit
 * directly in which, read from Flouest's `general-nesting.json`. The library
 * never decides legality; a rule may only name a parent this list gives the
 * node, or the document body, which may hold any container or atomic block.
 */
import { readFileSync } from 'node:fs';
import { join } from 'node:path';

import type { NodeId } from './schema/ids.ts';

export const NESTING_FILE = 'Template/template-functions/nesting/general-nesting.json';

/** The document body, as a parent. */
export const BODY = 'body';

export type Nesting = {
  /** Every node, with its family (`container`, `atomic`, `paragraph`, `inline`) and its legal parents. */
  readonly nodes: { readonly [node: NodeId]: { readonly family: string; readonly parents: readonly NodeId[] } };
};

export const readNesting = (flouest: string): Nesting => {
  const file = JSON.parse(readFileSync(join(flouest, NESTING_FILE), 'utf8')) as {
    nodes: { [node: string]: { family: string; parents: string[] } };
  };
  return { nodes: Object.fromEntries(Object.entries(file.nodes).map(([node, n]) => [node, { family: n.family, parents: n.parents }])) };
};

/** The node's legal parents, the document body first when it may sit there. */
export const parentsOf = (nesting: Nesting, node: NodeId): NodeId[] => {
  const entry = nesting.nodes[node];
  if (entry === undefined) return [];
  const body = entry.family === 'container' || entry.family === 'atomic' ? [BODY] : [];
  return [...body, ...entry.parents];
};
