/**
 * Flouest's `Realization` (`Profile_General/types.ts`), as a handler is typed
 * while the library incubates outside Flouest (ARCHITECTURE.md section 7).
 * The shapes are Flouest's own, cut to what a handler reads, so a handler
 * plugs in unchanged: the testing pipeline assigns each one to Flouest's type
 * when it builds a plug-in, and its type check fails if the two drift.
 *
 * So the library runs with no Flouest import, and a handler prints its own
 * LaTeX. Once the library moves into Flouest (`Handler-Lib/`), its handlers
 * call the `Packages/` printers they name.
 */

/** A node as the compiler hands it over: its type, attrs, children and text (`EditorNode`). */
export type Subject = {
  readonly type: string;
  readonly attrs?: { readonly [name: string]: unknown } | null;
  readonly content?: readonly Subject[];
  readonly text?: string;
};

export type PreambleRequirement = {
  beforeDocument?: string[];
  /** Full `\usepackage` lines, emitted verbatim and de-duplicated. */
  packages?: string[];
  /** Other preamble lines, de-duplicated. */
  declarations?: string[];
};

export type RealizationLocation = {
  readonly enclosingSpecialStructure?: 'caption' | 'headerNote';
  readonly keepVerbatim?: (text: string) => string;
};

export type Realization = {
  preamble: (params?: Record<string, unknown>, parentType?: string, subject?: Subject, content?: string, location?: RealizationLocation) => PreambleRequirement;
  /** For a statement, the third argument is its emitted header note. */
  emit: (subject: Subject, content: string, context?: string, parentType?: string, location?: RealizationLocation) => string;
};
