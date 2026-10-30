/**
 * cols.vwcol: \begin{vwcol}[widths={…}, sep=…] … \end{vwcol}, columns of
 * chosen widths that paragraph text flows through (no floats, no displays).
 * CTAN: https://ctan.org/pkg/vwcol
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { countOf, gapOf } from '../node.ts';
import key from './key.ts';

const WIDTHS: { readonly [style: string]: { readonly [count: number]: string } } = {
  equal: { 1: '1', 2: '0.5,0.5', 3: '0.33,0.33,0.34' },
  'wide-first': { 1: '1', 2: '0.6,0.4', 3: '0.5,0.25,0.25' },
  'wide-last': { 1: '1', 2: '0.4,0.6', 3: '0.25,0.25,0.5' },
};

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: () => ({ packages: ['\\usepackage{vwcol}'] }),
    emit: (node, content) => `\\begin{vwcol}[widths={${(WIDTHS[param(p, 'widths', 'equal')] ?? WIDTHS['equal'] ?? {})[countOf(node)] ?? '0.5,0.5'}}, sep=${gapOf(node)}]\n${content.trim()}\n\\end{vwcol}\n\n`,
  };
};

export default realize;
