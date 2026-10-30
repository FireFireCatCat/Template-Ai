/**
 * The four ports: the whole surface between core and the outside
 * (ARCHITECTURE.md section 4). A host binding implements Host, Engine and
 * Library. Store has defaults in `fsStore.ts` and `memoryStore.ts`.
 */
import type {
  BranchSpec,
  ClassSetting,
  CompatTable,
  DocumentRules,
  Emitted,
  Job,
  Json,
  HostVariant,
  NestingTree,
  NodeId,
  RawResult,
  Setup,
  Way,
  WayId,
} from './model.ts';

/**
 * What `build` places in a branch's document. `sentinel` gives a sentinel's
 * raw LaTeX for an id, and records that the host placed it, so the oracle
 * expects it in the log. The host places each sentinel in running text inside
 * the node's content, never in a moving argument (a heading, a caption), where
 * the table of contents or a running head would print it again. `marked`: the
 * branch carries the marked runs, not the escape run.
 */
export type BuildProbes = {
  readonly sentinel: (id: string, options?: { readonly outside?: boolean; readonly role?: string }) => string;
  readonly marked: boolean;
};

/** What `emit` works under: the class setting, the setup, and preamble lines core needs (the sentinel macro). */
export type EmitUnder = {
  readonly classSetting: ClassSetting;
  readonly setup: Setup;
  /** Placed right after the class setting's own preamble lines and the setup's. */
  readonly preamble: readonly string[];
};

/**
 * What a host knows: its nodes, which places are legal, how its documents are
 * built, and their LaTeX. `D` is the host's own filed document and `P` one
 * branch as built, both opaque to core; a host may use one type for both.
 */
export interface Host<D = unknown, P = D> {
  readonly id: string;
  /** Changes whenever the host's nesting, settings or emission may have changed. */
  fingerprint(): string;
  /** Every legal place down to `depth`, as the host's own rules decide it. */
  nesting(depth: number): NestingTree;
  /**
   * A node's variants under these ways, each with its members as the host
   * holds them. Only the host knows which combinations of a node's settings
   * it keeps, which need a parent's, and how the ways' presets land on them:
   * Flouest learns that by settling and compiling each one.
   */
  variants(node: NodeId, ways: readonly Way[]): readonly HostVariant[];
  /** One branch, built around its leaf, with the probes placed. */
  build(branch: BranchSpec, probes: BuildProbes): P;
  /** What filing must respect. */
  documentRules(): DocumentRules;
  /**
   * What the branch needs its document to hold besides itself (`bibliography`
   * for a citation), by name. A branch is filed only with branches that need
   * the same, and `pack` provides it, so a document holds what its branches
   * need and nothing more. Changing what a branch needs is a change of the
   * document rules' version.
   */
  requires(branch: BranchSpec): readonly string[];
  /** Several built branches, in the order filed, as one document. */
  pack(parts: readonly P[]): D;
  /** The document's LaTeX under a class setting and a setup, each node emitted by the way its branch binds. */
  emit(doc: D, under: EmitUnder): Emitted;
}

/** What compiles. */
export interface Engine {
  /** Changes when the engine build, its format, its package snapshot or its options change. */
  fingerprint(): string;
  compile(job: Job): Promise<RawResult>;
  close(): Promise<void>;
}

/** The handler library: ways in, verdicts out. */
export interface Library {
  nodes(): readonly NodeId[];
  ways(node: NodeId): readonly Way[];
  /** Changes when the way's LaTeX may have changed: its handler or presets, not its prose. */
  fingerprint(way: WayId): string;
  writeCompat(table: CompatTable): void;
}

/**
 * Where results live: JSON under path-like keys (`results/<hash>`,
 * `artifacts/plan/<key>`), plus append-only logs (`ledger`, `manifest`).
 */
export interface Store {
  get(key: string): Json | undefined;
  put(key: string, value: Json): void;
  append(log: string, line: Json): void;
  /** A log's lines in order, one at a time, so a log of any length can be read. */
  read(log: string): Iterable<Json>;
}
