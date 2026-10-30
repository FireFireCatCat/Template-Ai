/**
 * The Host port over Flouest's General (ARCHITECTURE.md section 4).
 *
 * Everything that decides what a branch is comes from Flouest's own dynamic
 * tests, unchanged: the nesting the editor allows (`nesting.ts`), each node's
 * variants and members as the editor keeps them and the compiler prints them
 * (`variants.ts`), the marked runs and the escape run (`marks.ts`,
 * `escapes.ts`), the branch builder, footnote pairing and the app's document
 * rules (`filing.ts`), and unique labels (`labels.ts`). What is ported is only
 * what depended on a branch's position:
 *
 * - a branch is built from its own path, and its paragraph marks start from a
 *   value its id picks, not from a counter across the run;
 * - a label's suffix is the branch's place in its document, which never
 *   changes once filed (`file.ts`).
 *
 * `build` places one sentinel in the deepest plain paragraph of the branch,
 * in running text and never in a heading or caption. Inside a margin note it
 * is placed as outside. A branch with one footnote also places the note's
 * mark and text, for the footnote probe.
 *
 * A branch that cites, or holds a reference container, needs a bibliography
 * (`requires`), so core files it only with branches that need one too, and
 * no other document loads one. `pack` ends such a document's text with a
 * reference container holding an entry for every key it cites, as a paper
 * that cites holds one: Flouest's sample documents cite a key no sample
 * defines. That container belongs to no branch.
 *
 * `emit` is the app's own `docJsonToLatex`, then the class line and preamble
 * swapped for the class setting. A node a branch binds to a plug-in way is
 * printed by that way's handler (`plugins.ts`). Each branch's lines are found
 * as Flouest's runner finds them (`branchLines` in `texlog.ts`): its blocks
 * compiled alone, their body found in the document's. That costs a compile
 * per branch, so it is done only when the oracle asks which branch a line
 * belongs to.
 */
import { dirname, join } from 'node:path';

import { Fragment, Slice, type Node as ProseMirrorNode, type Schema } from 'prosemirror-model';

import { stripFootnoteReferencesForMovingArgument } from '@flouest/JSON->Latex Compiler/src/Profile/Profile_General/inlineAtomicShape/footnoteAnchor.ts';
import { docJsonToLatex } from '@flouest/app/src/lib/latex.ts';
import { createEditorSchema } from '@flouest/mvp-editor-version-3/src/editor-state.ts';
import { hydrateRichAttrs } from '@flouest/mvp-editor-version-3/src/Ingest/transform/hydrateRichAttrs.ts';
import { buildEscapes, type EscapesResult } from '@flouest/Template/test/dynamic-testing/escapes.ts';
import { createBranchBuilder, createFootnotePairing, documentRules as appRules } from '@flouest/Template/test/dynamic-testing/filing.ts';
import { uniqueLabels } from '@flouest/Template/test/dynamic-testing/labels.ts';
import { buildMarks, type MarksResult } from '@flouest/Template/test/dynamic-testing/marks.ts';
import { createSettler, labelOf, nodeAt, type NestingNode as FlouestPlace } from '@flouest/Template/test/dynamic-testing/nesting.ts';
import type { SplitNode } from '@flouest/Template/test/dynamic-testing/splitting.ts';
import { buildVariants, type Combination, type VariantsResult } from '@flouest/Template/test/dynamic-testing/variants.ts';
import {
  canonical,
  hashJson,
  markedOf,
  type BranchId,
  type BranchSpec,
  type BuildProbes,
  type DocumentRules,
  type Emitted,
  type EmitUnder,
  type Host,
  type HostVariant,
  type Json,
  type Member,
  type MemberValues,
  type NestingNode,
  type NestingTree,
  type NodeId,
  type Way,
  type WayId,
} from 'compat-core';

import { generalWayId, type FlouestWay } from './ways.ts';
import { quietly } from './quiet.ts';
import { withClass } from './classLine.ts';
import { GENERAL_DECLARATION, pluginTemplate } from './plugins.ts';

/** Raised when filing's meaning changes (not its rules): every branch is filed again. 2: by what a branch needs; 3: document limits. */
const FILER_VERSION = 3;

/**
 * How many branches holding a node one document can hold. General writes
 * `\appendix` once and each appendix as a section after it, which the class
 * letters with `\Alph`: A to Z, then "Counter too large".
 */
const LIMITS: Readonly<Record<NodeId, number>> = { 'containerBlock/appendix': 26 };

/** What a branch that cites, or holds a reference container, needs of its document. */
export const BIBLIOGRAPHY = 'bibliography';

/** A BibTeX entry for a cited key: a plain `@misc`, enough for every citation style to print. */
const entryFor = (key: string): string => `@misc{${key}, author = {Author, Sample}, title = {A cited source}, year = {2000}}`;

/** Keys BibTeX takes as they are. */
const BIBTEX_KEY = /^[^\s,{}%#"'()=]+$/;

/** What Flouest's dynamic tests build for General to a depth: compiler and editor only, no TeX. */
export type General = {
  readonly depth: number;
  readonly variants: VariantsResult;
  readonly marks: MarksResult;
  readonly escapes: EscapesResult;
};

export const loadGeneral = (flouest: string, depth: number): General => {
  const tests = join(flouest, 'Template/test/dynamic-testing');
  const variants = quietly(() => buildVariants({ template: 'general', maxDepth: depth, samples: [dirname(tests)], skip: tests }));
  const marks = quietly(() => buildMarks({ template: 'general', nesting: variants.nesting, samples: variants.samples }));
  const escapes = quietly(() => buildEscapes({ template: 'general', nesting: variants.nesting, samples: variants.samples }));
  return { depth, variants, marks, escapes };
};

type Flags = { readonly [name: string]: Json };

type NodeJson = {
  readonly type: string;
  readonly attrs?: Readonly<Record<string, unknown>>;
  readonly content?: readonly NodeJson[];
  readonly marks?: readonly { readonly type: string; readonly attrs?: Readonly<Record<string, unknown>> }[];
  readonly text?: string;
};

/** One branch as built: its own node, its blocks in the text (a footnote's carrier, then itself), and those stored at the end (notes). */
export type FlouestPart = {
  readonly branch: BranchSpec;
  readonly main: ProseMirrorNode;
  readonly text: readonly ProseMirrorNode[];
  readonly end: readonly ProseMirrorNode[];
};

/** A filed document as the editor holds it. */
export type FlouestDoc = {
  readonly doc: ProseMirrorNode;
  /** The part each top-level block belongs to; -1 for the document's own (its bibliography). */
  readonly order: readonly number[];
  readonly parts: readonly BranchSpec[];
  /** Each part's own block in `doc`; -1 where the editor did not keep its path. */
  readonly mains: readonly number[];
};

/** A combination's values as a member: JSON, as it is stored and hashed. */
const valuesOf = (c: Combination): MemberValues => JSON.parse(JSON.stringify({ values: c.values, look: c.look, stored: c.stored })) as MemberValues;

const memberOf = (c: Combination): Member =>
  c.parent === undefined ? { values: valuesOf(c) } : { values: valuesOf(c), needs: { node: c.parent.label, values: valuesOf(c.parent.combination) } };

const toNesting = (places: readonly FlouestPlace[]): NestingNode[] => places.map((p) => ({ node: p.label, children: toNesting(p.children) }));

const labelOfJson = (json: NodeJson): string => (json.attrs?.['kind'] !== undefined ? `${json.type}/${String(json.attrs['kind'])}` : json.type);

const isProse = (json: NodeJson): boolean => json.type === 'paragraph' && json.attrs?.['kind'] === 'paragraph';

/** The address (child indices) of the deepest plain paragraph in `json`, the last on a tie. */
const deepestProse = (json: NodeJson): number[] | undefined => {
  let best: number[] | undefined;
  const visit = (node: NodeJson, at: number[]): void => {
    if (isProse(node) && (best === undefined || at.length >= best.length)) best = at;
    node.content?.forEach((child, i) => visit(child, [...at, i]));
  };
  visit(json, []);
  return best;
};

/** `json` with `change` made to the node at `address`. */
const changeAt = (json: NodeJson, address: readonly number[], change: (node: NodeJson) => NodeJson): NodeJson => {
  const [first, ...rest] = address;
  if (first === undefined) return change(json);
  return { ...json, content: (json.content ?? []).map((child, i) => (i === first ? changeAt(child, rest, change) : child)) };
};

const rawLatex = (latex: string): NodeJson => ({ type: 'customLatex', attrs: { id: null, preamble: '' }, content: [{ type: 'text', text: latex }] });

const append = (node: NodeJson, inline: NodeJson): NodeJson => ({ ...node, content: [...(node.content ?? []), inline] });

/** `json` with `inline` right after its first footnote anchor; unchanged when it holds none. */
const afterAnchor = (json: NodeJson, inline: NodeJson): NodeJson => {
  let done = false;
  const visit = (node: NodeJson): NodeJson => {
    if (done || node.content === undefined) return node;
    const at = node.content.findIndex((c) => c.type === 'footnoteAnchor');
    if (at >= 0) {
      done = true;
      return { ...node, content: [...node.content.slice(0, at + 1), inline, ...node.content.slice(at + 1)] };
    }
    return { ...node, content: node.content.map(visit) };
  };
  return visit(json);
};

/** Every node in `value`, in content and in attrs, where a caption's nodes are an attr's value. */
const nodesIn = function* (value: unknown): Generator<NodeJson> {
  if (Array.isArray(value)) {
    for (const item of value) yield* nodesIn(item);
    return;
  }
  if (value === null || typeof value !== 'object') return;
  const node = value as Record<string, unknown>;
  if (typeof node['type'] === 'string') yield node as unknown as NodeJson;
  for (const item of Object.values(node)) yield* nodesIn(item);
};

const isBibliography = (json: NodeJson): boolean => json.type === 'containerBlock' && json.attrs?.['kind'] === 'refContainer';

/** The keys a cite node names: its text, split at commas. */
const citedKeys = (json: NodeJson): string[] =>
  (json.content ?? []).map((c) => c.text ?? '').join('').split(',').map((k) => k.trim()).filter((k) => BIBTEX_KEY.test(k));

const count = (json: NodeJson, type: string): number => (json.type === type ? 1 : 0) + (json.content ?? []).reduce((s, c) => s + count(c, type), 0);

const bodyOf = (latex: string): string => /\\begin\{document\}([\s\S]*)\\end\{document\}/.exec(latex)?.[1] ?? '';

const linesBefore = (latex: string): number => latex.slice(0, latex.indexOf('\\begin{document}')).split('\n').length;

export class FlouestHost implements Host<FlouestDoc, FlouestPart> {
  readonly id = 'flouest-general';
  readonly #general: General;
  readonly #fingerprint: string;
  readonly #schema: Schema = createEditorSchema();
  readonly #settle: (doc: ProseMirrorNode) => ProseMirrorNode;
  readonly #build: ReturnType<typeof createBranchBuilder>;
  readonly #pair: ReturnType<typeof createFootnotePairing>;
  readonly #ways: ReadonlyMap<WayId, FlouestWay>;
  readonly #kinds: ReadonlyMap<NodeId, VariantsResult['kinds'][number]>;
  /** Each node's members, by their values: the Flouest variant and member that hold them. */
  readonly #members = new Map<NodeId, Map<string, readonly [number, number]>>();
  readonly #template: string | undefined;
  readonly #latex = new WeakMap<FlouestDoc, { readonly json: NodeJson; readonly latex: string }>();
  /** Each document's branch lines in General's LaTeX: the same under every class setting, shifted by its preamble. */
  readonly #lines = new WeakMap<FlouestDoc, readonly { branch: BranchId; from: number; to: number }[]>();
  readonly #requires = new Map<BranchId, readonly string[]>();

  constructor(general: General, ways: readonly FlouestWay[], fingerprint: string) {
    this.#general = general;
    this.#fingerprint = fingerprint;
    this.#settle = createSettler(this.#schema, 'general');
    this.#build = createBranchBuilder(this.#schema, general.variants, general.marks, general.escapes);
    this.#pair = createFootnotePairing(this.#schema, general.variants);
    this.#ways = new Map(ways.map((w) => [w.id, w]));
    this.#kinds = new Map(general.variants.kinds.map((k) => [k.identity.label, k]));
    for (const kind of general.variants.kinds) {
      const byValues = new Map<string, readonly [number, number]>();
      kind.variants.forEach((variant, v) => variant.members.forEach((c, m) => byValues.set(canonical(valuesOf(c)), [v, m])));
      this.#members.set(kind.identity.label, byValues);
    }
    this.#template = pluginTemplate(ways.flatMap((w) => (w.plugin === undefined ? [] : [w.plugin])));
  }

  fingerprint(): string {
    return this.#fingerprint;
  }

  nesting(depth: number): NestingTree {
    if (depth !== this.#general.depth) throw new Error(`host: built to depth ${this.#general.depth}, asked for ${depth}`);
    return { depth, roots: toNesting(this.#general.variants.nesting.tree) };
  }

  variants(node: NodeId, ways: readonly Way[]): HostVariant[] {
    const kind = this.#kinds.get(node);
    if (kind === undefined) return [];
    return ways.flatMap((way): HostVariant[] => {
      if (this.#ways.get(way.id)?.plugin === undefined) {
        return kind.variants
          .filter((v) => generalWayId(node, v.packages) === way.id)
          .map((v) => ({ variant: { way: way.id, compat: {}, flags: v.flags as Flags }, members: v.members.map(memberOf), cover: v.cover }));
      }
      // A plug-in way prints the node's content as General keeps it with no look picked.
      const groups = new Map<string, { flags: Flags; members: Map<string, Member> }>();
      const plain = kind.variants.some((v) => v.members.some((c) => c.look === ''));
      for (const v of kind.variants) {
        for (const c of v.members) {
          if (plain && c.look !== '') continue;
          const key = canonical(v.flags as Flags);
          const group = groups.get(key) ?? { flags: v.flags as Flags, members: new Map<string, Member>() };
          group.members.set(canonical(valuesOf(c)), memberOf(c));
          groups.set(key, group);
        }
      }
      return [...groups.values()].map((g) => ({ variant: { way: way.id, compat: {}, flags: g.flags }, members: [...g.members.values()], cover: g.members.size }));
    });
  }

  build(branch: BranchSpec, probes: BuildProbes): FlouestPart {
    const last = branch.path.length - 1;
    const path = branch.path.map((step, depth): SplitNode => {
      const at = this.#members.get(step.node)?.get(canonical(step.member));
      if (at === undefined) throw new Error(`host: ${step.node} has no member ${canonical(step.member).slice(0, 160)}`);
      return { label: step.node, depth, variant: at[0], member: at[1], children: [], ...(depth === last ? { branch: 0, marked: probes.marked } : {}) };
    });
    this.#build.restart();
    let built = this.#build(path);
    if (probes.marked) built = this.#rotateParagraphMarks(built, branch.id);
    const paired = this.#pair(built);
    return this.#withSentinels(branch, probes, paired);
  }

  /** The paragraph marks the builder gave, each moved on by the same number of values, which the branch's id picks. */
  #rotateParagraphMarks(node: ProseMirrorNode, id: BranchId): ProseMirrorNode {
    const uses = this.#general.marks.paragraphMarks.filter((p) => p.kept.length > 1);
    if (uses.length === 0) return node;
    const by = Number.parseInt(id.slice(1, 9), 16);
    const visit = (json: NodeJson): NodeJson => {
      const label = labelOfJson(json);
      const marks = json.marks?.map((mark) => {
        const use = uses.find((p) => p.label === label && p.mark === mark.type);
        if (use === undefined) return mark;
        const j = use.kept.findIndex((v) => JSON.stringify(v) === JSON.stringify(mark.attrs?.[use.attr]));
        return j < 0 ? mark : { ...mark, attrs: { ...mark.attrs, [use.attr]: use.kept[(j + by) % use.kept.length] } };
      });
      return { ...json, ...(marks === undefined ? {} : { marks }), ...(json.content === undefined ? {} : { content: json.content.map(visit) }) };
    };
    return this.#schema.nodeFromJSON(visit(node.toJSON() as NodeJson));
  }

  #withSentinels(branch: BranchSpec, probes: BuildProbes, paired: { main: ProseMirrorNode; text: ProseMirrorNode[]; end: ProseMirrorNode[] }): FlouestPart {
    const outside = branch.path.some((step) => this.#ways.get(step.variant.way)?.loads.includes('marginnote') === true);
    const mainJson = paired.main.toJSON() as NodeJson;
    const isBody = paired.main.type.name === 'footnoteBody';
    const others = (list: readonly ProseMirrorNode[]) => list.filter((n) => n !== paired.main).map((n) => n.toJSON() as NodeJson);
    let text = others(paired.text);
    let end = others(paired.end);
    const anchors = [mainJson, ...text].reduce((s, j) => s + count(j, 'footnoteAnchor'), 0);
    const bodies = (isBody ? 1 : 0) + end.reduce((s, j) => s + count(j, 'footnoteBody'), 0);
    const footnote = anchors === 1 && bodies === 1;

    let main = mainJson;
    const at = deepestProse(mainJson);
    if (at !== undefined) {
      const role = footnote ? (isBody ? 'footnote:text' : undefined) : undefined;
      main = changeAt(main, at, (p) => append(p, rawLatex(probes.sentinel(`${branch.id}.0`, { ...(outside ? { outside } : {}), ...(role ? { role } : {}) }))));
    }
    // A note with no plain paragraph to hold its text sentinel gets no mark sentinel either.
    const noteText = footnote && !isBody && end.some((json) => count(json, 'footnoteBody') === 1 && deepestProse(json) !== undefined);
    if (footnote && isBody && at !== undefined) {
      // The anchor stands in a carrier block in the text: the mark right after it.
      text = text.map((json) => (count(json, 'footnoteAnchor') === 1 ? afterAnchor(json, rawLatex(probes.sentinel(`${branch.id}.m`, { role: 'footnote:mark' }))) : json));
    } else if (noteText) {
      main = afterAnchor(main, rawLatex(probes.sentinel(`${branch.id}.m`, { role: 'footnote:mark' })));
      end = end.map((json) => {
        const p = count(json, 'footnoteBody') === 1 ? deepestProse(json) : undefined;
        return p === undefined ? json : changeAt(json, p, (n) => append(n, rawLatex(probes.sentinel(`${branch.id}.t`, { role: 'footnote:text' }))));
      });
    }
    const node = (json: NodeJson) => this.#schema.nodeFromJSON(json);
    const mainNode = node(main);
    const textNodes = paired.text.includes(paired.main) ? [...text.map(node), mainNode] : text.map(node);
    const endNodes = paired.end.includes(paired.main) ? [mainNode, ...end.map(node)] : end.map(node);
    return { branch, main: mainNode, text: textNodes, end: endNodes };
  }

  documentRules(): DocumentRules {
    const rules = appRules(this.#schema);
    const labels = this.#general.variants.kinds.map((k) => k.identity.label);
    const alone = labels.filter((l) => rules.once(l));
    const last = labels.filter((l) => rules.last(l));
    const limits = Object.fromEntries(Object.entries(LIMITS).filter(([node]) => labels.includes(node)));
    return { version: `flouest-general:${hashJson({ alone, last, limits, filer: FILER_VERSION }).slice(0, 12)}`, alone, last, limits };
  }

  /** A bibliography, when the branch as built cites or holds a reference container. */
  requires(branch: BranchSpec): readonly string[] {
    let needs = this.#requires.get(branch.id);
    if (needs === undefined) {
      // Built as for its document; the sentinels' text only has to be text.
      const part = this.build(branch, { marked: markedOf(branch.id), sentinel: (id) => id });
      const nodes = [part.main, ...part.text, ...part.end].flatMap((n) => [...nodesIn(n.toJSON())]);
      needs = nodes.some((n) => n.type === 'cite' || isBibliography(n)) ? [BIBLIOGRAPHY] : [];
      this.#requires.set(branch.id, needs);
    }
    return needs;
  }

  /** A reference container with an entry for each key, for a document that cites. */
  #bibliography(keys: readonly string[]): ProseMirrorNode {
    return this.#schema.nodeFromJSON({
      type: 'containerBlock',
      attrs: { kind: 'refContainer' },
      content: keys.map((key) => ({ type: 'paragraph', attrs: { kind: 'refPara' }, content: [{ type: 'text', text: entryFor(key) }] })),
    });
  }

  /**
   * The parts as one document, filed as the app stores one (Flouest's
   * `createFiler`), in the order given. A document that cites ends its text
   * with its bibliography, before the footnote bodies the app stores last.
   */
  pack(parts: readonly FlouestPart[]): FlouestDoc {
    const schema = this.#schema;
    const keys = new Set<string>();
    for (const p of parts) {
      for (const node of new Set([p.main, ...p.text, ...p.end])) for (const n of nodesIn(node.toJSON())) if (n.type === 'cite') for (const k of citedKeys(n)) keys.add(k);
    }
    const blocks = [
      ...parts.flatMap((p, i) => p.text.map((node) => ({ node, part: i }))),
      ...(keys.size === 0 ? [] : [{ node: this.#bibliography([...keys].sort()), part: -1 }]),
      ...parts.flatMap((p, i) => p.end.map((node) => ({ node, part: i }))),
    ];
    const raw = schema.topNodeType.create(null, blocks.map((b) => b.node));
    const settled = this.#settle(schema.topNodeType.create(null, hydrateRichAttrs(new Slice(raw.content, 0, 0), schema).content));
    const order = blocks.map((b) => b.part);
    const settledBlocks: ProseMirrorNode[] = [];
    settled.forEach((node) => {
      settledBlocks.push(node);
    });
    // Each label made unique by the branch's place in the document, which filing never changes.
    const doc = settled.copy(Fragment.fromArray(uniqueLabels(schema, settledBlocks.map((node, i) => ({ node, branch: order[i] ?? -1 })))));
    const mains = parts.map(() => -1);
    let at = 0;
    for (const { node, part } of blocks) {
      const owner = parts[part];
      if (owner === undefined || node !== owner.main) {
        at++;
        continue;
      }
      const labels = owner.branch.path.map((s) => s.node);
      let i = at;
      while (i < doc.childCount && labelOf(doc.child(i)) !== labels[0]) i++;
      const kept = i < doc.childCount && nodeAt(schema.topNodeType.create(null, [doc.child(i)]), labels) !== null;
      if (kept) {
        mains[part] = i;
        at = i + 1;
      }
    }
    return { doc, order, parts: parts.map((p) => p.branch), mains };
  }

  emit(doc: FlouestDoc, { classSetting, setup, preamble }: EmitUnder): Emitted {
    const { json, latex: general } = this.#generalLatex(doc);
    const latex = withClass(general, classSetting, setup, preamble);
    const shift = linesBefore(latex) - linesBefore(general);
    let spans: Emitted['spans'] | undefined;
    const lines = () => {
      let found = this.#lines.get(doc);
      if (found === undefined) {
        found = this.#spans(doc, json, general);
        this.#lines.set(doc, found);
      }
      return found.map((s) => ({ ...s, from: s.from + shift, to: s.to + shift }));
    };
    return {
      latex,
      files: [],
      get spans() {
        spans ??= lines();
        return spans;
      },
    };
  }

  #compile(json: NodeJson): string | undefined {
    const result = quietly(() => docJsonToLatex(json as unknown as Record<string, unknown>, null, this.#template === undefined ? {} : { template: this.#template }));
    return result.ok ? result.latex : undefined;
  }

  /** The document's LaTeX as the app writes it, each node bound to a plug-in way given its style. */
  #generalLatex(doc: FlouestDoc): { readonly json: NodeJson; readonly latex: string } {
    const saved = this.#latex.get(doc);
    if (saved !== undefined) return saved;
    let json = doc.doc.toJSON() as NodeJson;
    doc.parts.forEach((branch, part) => {
      const block = doc.mains[part] ?? -1;
      if (block < 0) return;
      branch.path.forEach((step, depth) => {
        const style = this.#ways.get(step.variant.way)?.plugin?.style;
        if (style === undefined) return;
        json = changeAt(json, [block], (root) => bindAt(root, branch.path.slice(1, depth + 1).map((s) => s.node), style));
      });
    });
    const latex = this.#compile(json);
    if (latex === undefined) throw new Error('host: the app\'s compiler refused a filed document');
    if (!latex.includes(GENERAL_DECLARATION.join('\n'))) throw new Error(`host: General's class and preamble lines changed; update GENERAL_DECLARATION in plugins.ts. The document begins:\n${latex.slice(0, 600)}`);
    const made = { json, latex };
    this.#latex.set(doc, made);
    return made;
  }

  /**
   * Each branch's lines in the document's LaTeX (Flouest's `branchLines`),
   * each running on over the blank lines after it, where TeX reports a
   * paragraph it ends.
   */
  #spans(doc: FlouestDoc, json: NodeJson, latex: string): { branch: BranchId; from: number; to: number }[] {
    const text = stripFootnoteReferencesForMovingArgument(latex);
    const lines = text.split('\n');
    const lineAt = (offset: number) => text.slice(0, offset).split('\n').length;
    let at = text.indexOf('\\begin{document}');
    const blocks = json.content ?? [];
    const found: { branch: BranchId; from: number; to: number }[] = [];
    for (const part of [...new Set(doc.order)]) {
      if (part < 0) continue;
      const own = blocks.filter((_, i) => doc.order[i] === part);
      const alone = this.#compile({ type: 'doc', attrs: json.attrs, content: own });
      const body = alone === undefined ? '' : stripFootnoteReferencesForMovingArgument(bodyOf(alone)).trim();
      const k = body === '' ? -1 : text.indexOf(body, at);
      const branch = doc.parts[part];
      if (k < 0 || branch === undefined) continue;
      at = k + body.length;
      found.push({ branch: branch.id, from: lineAt(k), to: lineAt(k + body.length) });
    }
    return found.map((span, i) => {
      const next = found[i + 1]?.from ?? lines.length;
      let to = span.to;
      while (to + 1 < next && (lines[to] ?? '').trim() === '') to++;
      return { ...span, to };
    });
  }
}

/** `root` with the node down `labels` (the first match at each level) printed in `style`. */
const bindAt = (root: NodeJson, labels: readonly string[], style: string): NodeJson => {
  const [first, ...rest] = labels;
  if (first === undefined) return { ...root, attrs: { ...root.attrs, rendering: { style } } };
  const i = (root.content ?? []).findIndex((c) => labelOfJson(c) === first);
  return i < 0 ? root : changeAt(root, [i], (child) => bindAt(child, rest, style));
};
