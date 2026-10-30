/**
 * A table cell as Flouest's table reads it (General's
 * `containerBlockShape/tableCell.ts`): its text with blank lines as `\par`,
 * bold in a header, its background through colortbl, a row span through
 * multirow, then the cell separator (`protocol.ts`).
 */
import { CELL } from '../protocol.ts';
import type { PreambleRequirement, Subject } from '../../schema/realization.ts';

const span = (v: unknown): number => {
  const n = Number(v);
  return Number.isInteger(n) && n > 0 ? n : 1;
};
const backgroundOf = (node: Subject): string => (typeof node.attrs?.['background'] === 'string' ? node.attrs['background'].trim() : '');
/** An xcolor colour argument: `[HTML]{RRGGBB}` for a hex colour, else the name. */
const colour = (c: string): string => (/^#?[0-9a-f]{6}$/iu.test(c) ? `[HTML]{${c.replace('#', '').toUpperCase()}}` : `{${c}}`);

export const cellPreamble = (node: Subject | undefined, shade = ''): PreambleRequirement => {
  if (node === undefined) return {};
  const packages = [...(span(node.attrs?.['rowspan']) > 1 ? ['\\usepackage{multirow}'] : []), ...(backgroundOf(node) !== '' || shade !== '' ? ['\\usepackage{xcolor}', '\\usepackage{colortbl}'] : [])];
  return packages.length > 0 ? { packages } : {};
};

/**
 * A cell's LaTeX: `font` around a header's text (bold, General's), its own
 * background or else `shade`, a row span `width` wide (`=` the column's,
 * `*` natural; a cell that also spans columns is always natural).
 */
export const cell = (node: Subject, content: string, header: boolean, look: { readonly font?: string; readonly shade?: string; readonly width?: string } = {}): string => {
  const trimmed = content.trim();
  let text = trimmed === '' ? '\\strut' : trimmed.replace(/\n[ \t]*\n+/gu, '\\par ');
  if (header) text = `{${look.font ?? '\\bfseries'} ${text}}`;
  const background = backgroundOf(node) || (look.shade ?? '');
  if (background !== '') text = `\\cellcolor${colour(background)} ${text}`;
  const rows = span(node.attrs?.['rowspan']);
  if (rows > 1) text = `\\multirow{${rows}}{${span(node.attrs?.['colspan']) > 1 ? '*' : look.width ?? '='}}{${text}}`;
  return `${text}${CELL}`;
};
