/**
 * A code block: its language (`data.language`), caption and label, and its
 * text with Flouest's escape markers (`protocol.ts`) for escaped LaTeX
 * (General's `containerBlockShape/code.ts`).
 */
import { ESCAPE_AT, ESCAPE_CLOSE, ESCAPE_OPEN, field } from '../protocol.ts';
import type { Subject } from '../../schema/realization.ts';

export const languageOf = (node: Subject): string => {
  const l = field(node, 'language');
  return l === 'text' ? '' : l;
};

/** The code text, each escape rendered by `escape` (dropped when it gives ''). */
export const codeText = (content: string, escape: (latex: string) => string): string => {
  let out = '';
  let at = 0;
  for (;;) {
    const open = content.indexOf(ESCAPE_OPEN, at);
    if (open < 0) break;
    const close = content.indexOf(ESCAPE_CLOSE, open);
    if (close < 0) break;
    out += content.slice(at, open) + escape(content.slice(open + ESCAPE_OPEN.length, close));
    at = close + ESCAPE_CLOSE.length;
  }
  return (out + content.slice(at)).replaceAll(ESCAPE_AT, '@').replace(/\n+$/u, '');
};

/** A caption and label after the code, as `\captionof{…}` from the caption package needs. */
export const captionLines = (node: Subject, caption: string | undefined, counter: string): string => {
  const label = field(node, 'label');
  return caption !== undefined && caption.trim() !== '' ? `\n\\captionof{${counter}}{${caption.trim()}}${label === '' ? '' : `\\label{${label}}`}` : '';
};

/** listings' names for the languages it knows, from General's code shape. */
export const LISTINGS_LANGUAGES: { readonly [language: string]: string } = {
  c: 'C', 'c++': 'C++', cpp: 'C++', java: 'Java', python: 'Python', html: 'HTML', xml: 'XML', tex: 'TeX', latex: 'TeX', sql: 'SQL', bash: 'bash', sh: 'sh', r: 'R',
  matlab: 'Matlab', haskell: 'Haskell', ruby: 'Ruby', php: 'PHP', perl: 'Perl', fortran: 'Fortran', lisp: 'Lisp', pascal: 'Pascal',
};

/** The language as listings names it, or nothing. */
export const listingsLanguage = (node: Subject): string | undefined => LISTINGS_LANGUAGES[languageOf(node).toLowerCase()];

/** A caption under code that is not in a float: centred, as General prints it. */
export const plainCaption = (caption: string | undefined): string => (caption !== undefined && caption.trim() !== '' ? `\\begin{center}${caption.trim()}\\end{center}\n` : '');

/** Whether any of the TeX values sets a colour, so xcolor is needed. */
export const colours = (values: readonly string[]): boolean => values.some((v) => v.includes('\\color') || v.includes('\\textcolor'));
