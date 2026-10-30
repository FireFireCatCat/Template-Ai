/**
 * Contexts (ARCHITECTURE.md 4.2): what a place in the document allows. Each
 * handler says what its body gives its children and what it needs where it
 * sits. Contexts fold down the ancestor chain, so a constraint any ancestor
 * sets reaches every descendant:
 *
 * - an allowance (`breakable`, `floats`, `paragraph`, `verbatim`,
 *   `footnotes`) holds only while every ancestor allows it: one that turns it
 *   off turns it off below, and a body cannot turn it back on;
 * - a situation (`argument`, `math`, `columns`) holds once any ancestor is in
 *   it;
 * - `boxDepth` counts the boxes above.
 *
 * Derived verdict for a child at a place: its needs met by the folded context
 * gives ok, else deny, unless an authored rule says otherwise (section 4.3).
 *
 * The list stays at about ten flags. A rule that does not fit one is an
 * authored rule, not a new flag.
 */
import type { NodeId } from './schema/ids.ts';

export const ALLOWANCES = ['breakable', 'floats', 'paragraph', 'verbatim', 'footnotes'] as const;
export const SITUATIONS = ['argument', 'math', 'columns'] as const;

export type Allowance = (typeof ALLOWANCES)[number];
export type Situation = (typeof SITUATIONS)[number];
export type Flag = Allowance | Situation;

/** What a place allows: every flag, and how many boxes enclose it. */
export type Context = { readonly [F in Flag]: boolean } & { readonly boxDepth: number };

/** What a body gives its children. An allowance may only be turned off, a situation only on; `boxDepth` adds. */
export type ContextChange = { readonly [A in Allowance]?: false } & { readonly [S in Situation]?: true } & { readonly boxDepth?: number };

/** What a handler needs where it sits: each flag it names must have that value; `maxBoxDepth` caps the boxes above. */
export type ContextNeed = { readonly [F in Flag]?: boolean } & { readonly maxBoxDepth?: number };

/** Directly in the document body. */
export const DOCUMENT: Context = {
  breakable: true,
  floats: true,
  paragraph: true,
  verbatim: true,
  footnotes: true,
  argument: false,
  math: false,
  columns: false,
  boxDepth: 0,
};

/** The context below a body that gives `change`, at a place with `context`. */
export const below = (context: Context, change: ContextChange): Context => {
  const next: { -readonly [K in keyof Context]: Context[K] } = { ...context };
  for (const a of ALLOWANCES) if (change[a] === false) next[a] = false;
  for (const s of SITUATIONS) if (change[s] === true) next[s] = true;
  next.boxDepth = context.boxDepth + (change.boxDepth ?? 0);
  return next;
};

/** The context at the end of a chain of bodies, outermost first. */
export const fold = (changes: readonly ContextChange[], start: Context = DOCUMENT): Context => changes.reduce(below, start);

/** What the context lacks of the need, one phrase each; empty when the need is met. */
export const unmet = (need: ContextNeed, context: Context): string[] => {
  const lacks: string[] = [];
  for (const flag of [...ALLOWANCES, ...SITUATIONS]) {
    const wanted = need[flag];
    if (wanted !== undefined && context[flag] !== wanted) lacks.push(`${wanted ? 'needs' : 'cannot have'} ${flag}`);
  }
  if (need.maxBoxDepth !== undefined && context.boxDepth > need.maxBoxDepth) lacks.push(`at most ${need.maxBoxDepth} boxes above, not ${context.boxDepth}`);
  return lacks;
};

/**
 * What each node's body gives its children as General prints it: the context
 * of a parent no library way covers yet. These are hypotheses, read from
 * General's handlers and from how LaTeX treats what they print; the matrix
 * confirms or rejects them (section 4.6). A node not listed gives nothing.
 */
export const GENERAL_GIVES: { readonly [node: NodeId]: { readonly gives: ContextChange; readonly why: string } } = {
  'containerBlock/columns': { gives: { floats: false, columns: true }, why: 'multicol refuses column floats' },
  'containerBlock/note': { gives: { floats: false, boxDepth: 1 }, why: 'a box: nothing inside it floats' },
  'containerBlock/mathElement': { gives: { floats: false, boxDepth: 1 }, why: "General's default statement is a coloured tcolorbox" },
  'containerBlock/footnote': {
    gives: { floats: false, footnotes: false, argument: true },
    why: 'the body reaches \\footnote as an argument; Flouest keeps verbatim working there (keepVerbatim)',
  },
  'containerBlock/blockMath': { gives: { math: true, paragraph: false, floats: false, verbatim: false }, why: 'display maths' },
  table: { gives: { floats: false }, why: 'the table is itself a float' },
  table_cell: { gives: { breakable: false, floats: false, footnotes: false }, why: 'a cell is a box; a footnote in a tabular is lost' },
  table_header: { gives: { breakable: false, floats: false, footnotes: false }, why: 'a header cell is a box' },
};
