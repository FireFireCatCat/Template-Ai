/**
 * A table as every way builds it: the rows and cells Flouest's row and cell
 * handlers emitted (split on `protocol.ts`'s separators), placed on a grid
 * that knows each cell's column span and the rows a span from above still
 * covers; then the float with its caption and label (General's
 * `containerBlockShape/table.ts`, its plain grid).
 */
import { CELL, field, ROW } from '../protocol.ts';
import type { Subject } from '../../schema/realization.ts';

const span = (v: unknown): number => {
  const n = Number(v);
  return Number.isInteger(n) && n > 0 ? n : 1;
};

export type Grid = { readonly columns: number; readonly rows: readonly (readonly string[])[] };

/** The grid: each row's fields, `\multicolumn` for a span, '' under a span from above. `multicolumn` writes a spanning cell. */
export const gridOf = (node: Subject, content: string, multicolumn: (n: number, cell: string) => string = (n, cell) => `\\multicolumn{${n}}{c}{${cell}}`): Grid => {
  const rows = node.content ?? [];
  const emitted = content.split(ROW).filter((chunk, i, all) => i < all.length - 1 || chunk !== '').map((chunk) => chunk.split(CELL).filter((c, i, all) => i < all.length - 1 || c !== ''));
  const columns = Math.max(1, ...rows.map((r) => (r.content ?? []).reduce((n, c) => n + span(c.attrs?.['colspan']), 0)));
  const covered: number[] = [];
  const out = rows.map((row, r) => {
    const fields: string[] = [];
    let column = 0;
    (row.content ?? []).forEach((cell, c) => {
      while ((covered[column] ?? 0) > 0) {
        fields.push('');
        column++;
      }
      const cols = span(cell.attrs?.['colspan']);
      const text = emitted[r]?.[c] ?? '\\strut';
      fields.push(cols > 1 ? multicolumn(cols, text) : text);
      const rowspan = span(cell.attrs?.['rowspan']);
      if (rowspan > 1) for (let k = 0; k < cols; k++) covered[column + k] = Math.max(covered[column + k] ?? 0, rowspan);
      column += cols;
    });
    while (column < columns) {
      fields.push('');
      column++;
    }
    for (let k = 0; k < covered.length; k++) covered[k] = Math.max(0, (covered[k] ?? 0) - 1);
    return fields;
  });
  return { columns, rows: out };
};

/** Each row as `a & b \\`. */
export const rowLines = (grid: Grid, separator = ' & '): string[] => grid.rows.map((fields) => `${fields.join(separator)} \\\\`);

/** The table float: caption above (or below, `captionPosition: bottom`), label, `[H]` when fixed. */
export const floated = (node: Subject, body: string, caption: string | undefined, environment = 'table'): string => {
  const label = field(node, 'label');
  const cap = caption !== undefined && caption.trim() !== '' ? `\\caption{${caption.trim()}}${label === '' ? '' : `\n\\label{${label}}`}` : '';
  const below = node.attrs?.['captionPosition'] === 'bottom';
  const placement = field(node, 'positioning') === 'fixed' ? 'H' : 'tbp';
  return `\\begin{${environment}}[${placement}]\n\\centering\n${below ? `${body}\n${cap}` : `${cap}\n${body}`}\n\\end{${environment}}\n\n`.replace(/\n\n+\\end/u, '\n\\end').replace(/\\centering\n\n/u, '\\centering\n');
};

/** Whether the first row is all header cells, so a rule can set it apart. */
export const hasHeader = (node: Subject): boolean => (node.content?.[0]?.content ?? []).length > 0 && (node.content?.[0]?.content ?? []).every((c) => c.type === 'table_header');

/**
 * Every column's letter: `equal` p-columns sharing the line (General's),
 * `l`, `c` or `r` for every column, `first-left` an l then c; `|` between
 * them and at the edges when ruled; `sep` in place of `|` (arydshln's `:`).
 */
export const columnSpec = (spec: string, columns: number, vrules: boolean, sep = '|'): string => {
  const equal = `p{\\dimexpr(\\linewidth/${columns})-2\\tabcolsep\\relax}`;
  const letters = Array.from({ length: columns }, (_, i) => (spec === 'equal' ? equal : spec === 'first-left' ? (i === 0 ? 'l' : 'c') : spec));
  return vrules ? `${sep}${letters.join(sep)}${sep}` : letters.join('');
};

/**
 * The rows with horizontal rules: `all` above, between and below every row,
 * `header` above, under the header row and below, `outer` above and below
 * only, `none`. `rule` is the rule command (\hline, \hdashline); `top`,
 * `mid` and `bottom` replace it where booktabs-like rules are wanted.
 */
export const ruledRows = (lines: readonly string[], rules: string, header: boolean, rule = { top: '\\hline', mid: '\\hline', bottom: '\\hline', between: '\\hline' }): string[] => {
  if (rules === 'none') return [...lines];
  const body = lines.flatMap((line, i) => (i === 0 ? [line] : rules === 'all' ? [rule.between, line] : rules === 'header' && i === 1 && header ? [rule.mid, line] : [line]));
  return [rule.top, ...body, rule.bottom];
};

/** The setup lines a table sets inside its float: the font size, \arraystretch, \tabcolsep. */
export const setupLines = (p: { readonly [name: string]: unknown }): string[] => {
  const text = (name: string): string => (typeof p[name] === 'string' ? (p[name] as string) : '');
  return [
    ...(text('fontSize') === '' ? [] : [text('fontSize')]),
    ...(typeof p['stretch'] === 'number' && p['stretch'] !== 1 ? [`\\renewcommand{\\arraystretch}{${p['stretch']}}`] : []),
    ...(text('colsep') === '' ? [] : [`\\setlength{\\tabcolsep}{${text('colsep')}}`]),
  ];
};

/** The setup lines, then the body. */
export const withSetup = (p: { readonly [name: string]: unknown }, body: string): string => [...setupLines(p), body].join('\n');
