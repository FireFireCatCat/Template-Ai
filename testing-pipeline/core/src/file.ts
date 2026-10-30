/**
 * Filing (ARCHITECTURE.md section 5, stage 4): the plan's branches into
 * documents, append-only.
 *
 * A filed document never changes. Each one is saved with its branches' paths
 * (`documents/<id>`) and named in the manifest. Filing again files only the
 * branches no document under the same rules holds, into new documents, so
 * every document filed before keeps its id, its LaTeX and its saved results.
 * The manifest is history, like the ledger: it is never rewritten.
 *
 * New branches are packed as Flouest's filer packs them (`filing.ts`,
 * ADR-207), in plan order:
 * - branches that need different things of their document (`Host.requires`:
 *   a bibliography for a citation) never share one, so a document holds only
 *   what its own branches need;
 * - a branch holding a node the rules keep `alone` (the title) is a document
 *   of its own;
 * - the rest go by root, a root being the top node of the split with its
 *   variant: a root's branches go in one document while they fit in what is
 *   left of it, else they start the next, and a root of more than `size`
 *   fills documents in a row;
 * - a document holds no more branches holding a node than the rules' `limits`
 *   allow (26 appendices, which the class letters A to Z): a branch over the
 *   limit starts the next document;
 * - within a document, the branches holding a node the rules keep `last` (an
 *   appendix) come after the others.
 *
 * A document is used while it holds a branch of the plan. One whose branches
 * have all left it (a removed way's) drops out, and nothing compiles for it.
 */
import { canonical } from './hash.ts';
import { documentId } from './ids.ts';
import type { BranchId, BranchSpec, DocumentId, DocumentRules, FiledDocument, Json } from './model.ts';
import type { Store } from './ports.ts';

export const MANIFEST = 'manifest';

/** One manifest line: a document filed, under which rules, holding which branches in order. */
export type ManifestLine = {
  readonly document: DocumentId;
  readonly rules: string;
  readonly branches: readonly BranchId[];
};

/** What a branch needs its document to hold (`Host.requires`). */
export type Requires = (branch: BranchSpec) => readonly string[];

export type FileOptions = {
  /** At most this many branches to a document (Flouest's M). */
  readonly size: number;
  /** Nothing, for every branch, when left out. */
  readonly requires?: Requires;
};

export type Filing = {
  /** Every document holding a branch of the plan, in the order filed, with those branches. */
  readonly documents: readonly { readonly document: FiledDocument; readonly current: readonly BranchId[] }[];
  /** The documents this call filed. */
  readonly filed: readonly DocumentId[];
};

export const documentAt = (id: DocumentId): string => `documents/${id}`;

export const readDocument = (store: Store, id: DocumentId): FiledDocument => {
  const saved = store.get(documentAt(id)) as FiledDocument | undefined;
  if (saved === undefined) throw new Error(`file: the manifest names ${id}, but it was not saved (${documentAt(id)})`);
  return saved;
};

const holds = (branch: BranchSpec, nodes: readonly string[]): boolean => branch.path.some((step) => nodes.includes(step.node));

/** New branches as documents, by the rules (see the header). */
export const packBranches = (branches: readonly BranchSpec[], rules: DocumentRules, size: number, requires: Requires = () => []): FiledDocument[] => {
  if (!(size >= 1)) throw new Error(`file: a document holds at least one branch, not ${size}`);
  const byNeeds = new Map<string, BranchSpec[]>();
  for (const branch of branches) {
    const needs = canonical([...new Set(requires(branch))].sort());
    byNeeds.set(needs, [...(byNeeds.get(needs) ?? []), branch]);
  }
  return [...byNeeds.values()].flatMap((list) => packTogether(list, rules, size));
};

/** Branches that need the same of their document, as documents. */
const packTogether = (branches: readonly BranchSpec[], rules: DocumentRules, size: number): FiledDocument[] => {
  const groups: BranchSpec[][] = [];
  const byRoot = new Map<string, BranchSpec[]>();
  for (const branch of branches) {
    if (holds(branch, rules.alone)) {
      groups.push([branch]);
      continue;
    }
    const first = branch.path[0];
    const root = canonical(first === undefined ? null : { node: first.node, variant: first.variant });
    let group = byRoot.get(root);
    if (group === undefined) {
      group = [];
      byRoot.set(root, group);
      groups.push(group);
    }
    group.push(branch);
  }

  const limits = Object.entries(rules.limits ?? {});
  /** Whether `branch` keeps `doc` within every limit. */
  const withinLimits = (doc: readonly BranchSpec[], branch: BranchSpec): boolean =>
    limits.every(([node, most]) => !holds(branch, [node]) || doc.filter((b) => holds(b, [node])).length < most);
  const documents: BranchSpec[][] = [];
  let open: BranchSpec[] | undefined;
  for (const group of groups) {
    const alone = group.length === 1 && holds(group[0] as BranchSpec, rules.alone);
    if (open !== undefined && (alone || open.length + group.length > size)) open = undefined;
    for (const branch of group) {
      if (open === undefined || open.length >= size || !withinLimits(open, branch)) {
        open = [];
        documents.push(open);
      }
      open.push(branch);
    }
    if (alone) open = undefined;
  }

  return documents.map((list) => documentOf(list, rules));
};

/**
 * Branches as one document, as they are, with those holding a `last` node
 * moved after the others. The explainer's trials are documents of this kind,
 * never filed: some of a filed document's branches, or one branch changed.
 */
export const documentOf = (branches: readonly BranchSpec[], rules: DocumentRules): FiledDocument => {
  const paths = [...branches.filter((b) => !holds(b, rules.last)), ...branches.filter((b) => holds(b, rules.last))];
  const ids = paths.map((b) => b.id);
  return { id: documentId(ids, rules.version), branches: ids, rules: rules.version, paths };
};

/** Files the plan's branches no document holds yet, and returns every document the plan uses. */
export const fileBranches = (store: Store, branches: readonly BranchSpec[], rules: DocumentRules, options: FileOptions): Filing => {
  const lines = ([...store.read(MANIFEST)] as unknown as readonly ManifestLine[]).filter((line) => line.rules === rules.version);
  const filedIn = new Set(lines.flatMap((line) => line.branches));
  const seen = new Set<BranchId>();
  const fresh = branches.filter((b) => !filedIn.has(b.id) && !seen.has(b.id) && seen.add(b.id));
  const filed = packBranches(fresh, rules, options.size, options.requires);
  for (const document of filed) {
    store.put(documentAt(document.id), document as unknown as Json);
    store.append(MANIFEST, { document: document.id, rules: document.rules, branches: document.branches });
  }

  const current = new Set(branches.map((b) => b.id));
  const listed = new Set<DocumentId>();
  const documents: Filing['documents'][number][] = [];
  for (const line of [...lines, ...filed.map((d) => ({ document: d.id, rules: d.rules, branches: d.branches }))]) {
    if (listed.has(line.document)) continue;
    listed.add(line.document);
    const here = line.branches.filter((b) => current.has(b));
    if (here.length === 0) continue;
    documents.push({ document: readDocument(store, line.document), current: here });
  }
  return { documents, filed: filed.map((d) => d.id) };
};
