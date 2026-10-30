/**
 * tbl.tabular: the kernel's \begin{tabular}{spec} in a table float; the
 * columns (equal p-columns, or l, c, r), | rules, \hline where asked, and
 * \arraystretch, \tabcolsep and a size inside the float.
 * CTAN: https://ctan.org/pkg/latex-base (usrguide; array for p-columns)
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { columnSpec, floated, gridOf, hasHeader, ruledRows, rowLines, withSetup } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: () => ({}),
    emit: (node, content, context) => {
      const g = gridOf(node, content);
      const rows = ruledRows(rowLines(g), param(p, 'rules', 'all'), hasHeader(node));
      return floated(node, withSetup(p, `\\begin{tabular}{${columnSpec(param(p, 'colspec', 'equal'), g.columns, p['vrules'] !== false)}}\n${rows.join('\n')}\n\\end{tabular}`), context);
    },
  };
};

export default realize;
