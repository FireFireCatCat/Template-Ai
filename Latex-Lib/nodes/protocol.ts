/**
 * How Flouest's emitter passes children to their parent (its own
 * conventions, not LaTeX), so a library handler of either side keeps to them:
 *
 * - a table row ends its cells with `ROW`, a cell ends with `CELL`; the table
 *   splits them apart (`containerBlockShape/tableRow.ts`, `tableCell.ts`);
 * - a code escape is wrapped in `ESCAPE_OPEN` … `ESCAPE_CLOSE`, an `@` in code
 *   text is `ESCAPE_AT` (`inlineAtomicShape/codeEscape.ts`);
 * - a list item paragraph prints `\<level>[label] text` on a line of its own,
 *   and the list turns those lines into its environment
 *   (`paragraphShape/lstParagraph.ts`, `containerBlockShape/listing.ts`).
 */
import type { Subject } from '../schema/realization.ts';

export const ROW = '\u0000tiptap-latex-table-row\u0000';
export const CELL = '\u0000tiptap-latex-table-cell\u0000';
export const ESCAPE_OPEN = '\u{e000}';
export const ESCAPE_CLOSE = '\u{e001}';
export const ESCAPE_AT = '\u{e002}';

/** A node's `data` attr, or nothing. */
export const dataOf = (node: Subject | undefined): { readonly [name: string]: unknown } => {
  const data = node?.attrs?.['data'];
  return data !== null && typeof data === 'object' && !Array.isArray(data) ? (data as { readonly [name: string]: unknown }) : {};
};

/** A string field of `data`, trimmed, or the fallback. */
export const field = (node: Subject | undefined, name: string, fallback = ''): string => {
  const v = dataOf(node)[name];
  return typeof v === 'string' ? v.trim() : fallback;
};

/** A node's own text: its children's text joined (a citation key, a reference label). */
export const textOf = (node: Subject | undefined): string => (node?.content ?? []).map((c) => c.text ?? '').join('').trim();

/** `\label{…}` on a line of its own, or nothing. */
export const labelLine = (label: string): string => (label === '' ? '' : `\n\\label{${label}}`);

/** A string parameter, or its fallback. */
export const param = (params: { readonly [name: string]: unknown }, name: string, fallback = ''): string => {
  const v = params[name];
  return typeof v === 'string' ? v : fallback;
};
