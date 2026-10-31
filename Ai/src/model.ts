/**
 * The target document (ARCHITECTURE.md section 3): what a template is, in the
 * handler library's words. The model writes it; the search over the library
 * reads it. Every word is the library's (node ids, feature words, parameter
 * names, package names, evidence), so `check.ts` holds it to the library's own
 * vocabulary.
 *
 * It describes; it never chooses. There is no way id and no class id in it:
 * which handler and which class profile a key stands for is the search's
 * answer, found in the library alone. A target key has the fields a handler
 * key describes itself with, so the search compares like with like.
 */
import type { Evidence } from '../../Latex-Lib/schema/evidence.ts';
import type { Feature } from '../../Latex-Lib/schema/features.ts';
import type { Json, NodeId } from '../../Latex-Lib/schema/ids.ts';
import type { PackageLoad } from '../../Latex-Lib/schema/key.ts';

/** A file of the template, by its path in the template's folder. */
export type SourceFile = { readonly path: string; readonly sha256: string };

/** The class key: the class as the template names it, matched to a class profile by the search. */
export type TargetClass = {
  /** The class as `\documentclass` names it, and its options. */
  readonly name: string;
  readonly options: readonly string[];
  /** A class the template ships itself: its file, and the class it loads (`\LoadClass`), by name. */
  readonly local?: { readonly file: string | null; readonly loads: string | null };
  readonly description: string;
  readonly evidence: readonly Evidence[];
};

export type Confidence = 'high' | 'medium' | 'low';

/** Not a library way: logic that needs layout state, fixed artwork, code the sample never runs (the research's tiers). */
export type Tier = 'handler-logic' | 'approximate' | 'asset' | 'drop';

export type TargetKey = {
  /** The node, or `doc` for a document-level part (page, fonts, headers). */
  readonly node: NodeId;
  readonly features: readonly Feature[];
  /** Values by the library's parameter names, each a parameter of some handler of the node. */
  readonly params: { readonly [name: string]: Json };
  /** The packages the template loads for this part, with their options. */
  readonly packages: readonly PackageLoad[];
  /** The look in words, for the embedding match. */
  readonly description: string;
  readonly evidence: readonly Evidence[];
  readonly confidence: Confidence;
  readonly tier?: Tier;
};

/**
 * One template. A node may have several keys when the template styles it more
 * than one way (amsthm with thmtools); the search weighs them. A node with
 * none keeps General's way.
 */
export type TargetDocument = {
  readonly source: { readonly id: string; readonly files: readonly SourceFile[] };
  readonly class: TargetClass;
  readonly nodes: readonly TargetKey[];
  /** Document-level parts: read now, searched once the library has handlers for them. */
  readonly document: readonly TargetKey[];
};

export const CONFIDENCE: readonly Confidence[] = ['high', 'medium', 'low'];
export const TIERS: readonly Tier[] = ['handler-logic', 'approximate', 'asset', 'drop'];
