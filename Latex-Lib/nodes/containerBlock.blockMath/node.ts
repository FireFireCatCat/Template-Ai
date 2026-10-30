/**
 * Display maths: its rows (the math paragraphs, separated by blank lines), its
 * kind (`data.latexStyle`: display, equation, multiequation) and its label
 * (General's `containerBlockShape/blockMath.ts`).
 */
import { field, labelLine } from '../protocol.ts';
import type { Subject } from '../../schema/realization.ts';

export const rowsOf = (content: string): string[] => content.trim().split(/\n\s*\n/u).map((r) => r.trim()).filter(Boolean);
export const kindOf = (node: Subject): 'display' | 'equation' | 'multiequation' => {
  const k = field(node, 'latexStyle', 'display');
  return k === 'equation' || k === 'multiequation' ? k : 'display';
};
export const labelOf = (node: Subject): string => labelLine(field(node, 'label'));
/** Whether a row aligns on `&` or breaks with `\\`. */
export const aligns = (rows: readonly string[]): boolean => rows.some((r) => /(?<!\\)&|\\\\/u.test(r));

/**
 * amsmath's displays (mathtools' too): one row in \[ … \] or equation, several
 * in the environment `multiline` names (`auto`: align when a row aligns on &,
 * else gather), starred when unnumbered.
 */
export const amsDisplay = (node: Subject, content: string, multiline: string): string => {
  const rows = rowsOf(content);
  if (rows.length === 0) return '';
  const k = kindOf(node);
  if (rows.length === 1) return k === 'display' ? `\\[\n${rows[0]}\n\\]\n\n` : `\\begin{equation}\n${rows[0]}${labelOf(node)}\n\\end{equation}\n\n`;
  const env = multiline === 'auto' ? (aligns(rows) ? 'align' : 'gather') : multiline;
  // multline and gather take one row per line; split sits inside equation.
  if (env === 'split') return `\\begin{equation${k === 'display' ? '*' : ''}}\n\\begin{split}\n${rows.join(' \\\\\n')}\n\\end{split}${k === 'display' ? '' : labelOf(node)}\n\\end{equation${k === 'display' ? '*' : ''}}\n\n`;
  const name = k === 'display' ? `${env}*` : env;
  return `\\begin{${name}}\n${rows.join(' \\\\\n')}${k === 'display' ? '' : labelOf(node)}\n\\end{${name}}\n\n`;
};

/** The numbering and break declarations amsmath and mathtools share. */
export const amsDeclarations = (p: { readonly [name: string]: unknown }): string[] => {
  const within = typeof p['numberWithin'] === 'string' ? p['numberWithin'] : 'none';
  const breaks = typeof p['allowBreaks'] === 'number' ? p['allowBreaks'] : 0;
  return [...(within === 'none' ? [] : [`\\numberwithin{equation}{${within}}`]), ...(breaks > 0 ? [breaks === 4 ? '\\allowdisplaybreaks' : `\\allowdisplaybreaks[${breaks}]`] : [])];
};

/** amsmath's package options as the parameters ask: fleqn, leqno. */
export const amsOptions = (p: { readonly [name: string]: unknown }): string[] => [...(p['flushLeft'] === true ? ['fleqn'] : []), ...(p['leftNumbers'] === true ? ['leqno'] : [])];
