/**
 * tbl.threeparttable: \begin{threeparttable} \caption … tabular …
 * \end{threeparttable} in a table float, caption and notes kept to the
 * tabular's width; the package options flushleft and para shape the
 * tablenotes; \hline or booktabs rules.
 * CTAN: https://ctan.org/pkg/threeparttable (the package's usage notes)
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { field, param } from '../../protocol.ts';
import { columnSpec, gridOf, hasHeader, ruledRows, rowLines, setupLines } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const booktabs = param(p, 'rules', 'hline') === 'booktabs';
  const notes = param(p, 'notes', 'normal');
  return {
    preamble: () => ({ packages: [notes === 'normal' ? '\\usepackage{threeparttable}' : `\\usepackage[${notes}]{threeparttable}`, ...(booktabs ? ['\\usepackage{booktabs}'] : [])] }),
    emit: (node, content, context) => {
      const g = gridOf(node, content);
      const label = field(node, 'label');
      const cap = context !== undefined && context.trim() !== '' ? `\\caption{${context.trim()}}${label === '' ? '' : `\\label{${label}}`}\n` : '';
      const rows = ruledRows(rowLines(g), 'header', hasHeader(node), booktabs ? { top: '\\toprule', mid: '\\midrule', bottom: '\\bottomrule', between: '' } : undefined);
      const placement = field(node, 'positioning') === 'fixed' ? 'H' : 'tbp';
      return `\\begin{table}[${placement}]\n\\centering\n${setupLines(p).map((l) => `${l}\n`).join('')}\\begin{threeparttable}\n${cap}\\begin{tabular}{${columnSpec(param(p, 'colspec', 'l'), g.columns, false)}}\n${rows.join('\n')}\n\\end{tabular}\n\\end{threeparttable}\n\\end{table}\n\n`;
    },
  };
};

export default realize;
