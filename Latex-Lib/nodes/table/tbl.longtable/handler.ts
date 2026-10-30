/**
 * tbl.longtable: \begin{longtable}{spec} … \end{longtable}, a table that
 * breaks across pages, not a float; its caption the first row, the header
 * row repeated with \endfirsthead and \endhead, a "continued" line with
 * \endfoot and \endlastfoot; \hline or booktabs rules.
 * CTAN: https://ctan.org/pkg/longtable
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { field, param } from '../../protocol.ts';
import { columnSpec, gridOf, hasHeader, rowLines, setupLines } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const rules = param(p, 'rules', 'hline');
  const [top, mid, bottom] = rules === 'booktabs' ? ['\\toprule', '\\midrule', '\\bottomrule'] : rules === 'hline' ? ['\\hline', '\\hline', '\\hline'] : ['', '', ''];
  return {
    preamble: () => ({ packages: ['\\usepackage{longtable}', ...(rules === 'booktabs' ? ['\\usepackage{booktabs}'] : [])] }),
    emit: (node, content, context) => {
      const g = gridOf(node, content);
      const label = field(node, 'label');
      const cap = context !== undefined && context.trim() !== '' ? `\\caption{${context.trim()}}${label === '' ? '' : `\\label{${label}}`} \\\\` : '';
      const lines = rowLines(g);
      const header = hasHeader(node) && p['repeatHeader'] !== false && lines.length > 1 ? lines[0] : undefined;
      const body = header === undefined ? lines : lines.slice(1);
      const between = rules === 'hline' ? body.flatMap((l, i) => (i === 0 ? [l] : ['\\hline', l])) : body;
      const head = header === undefined
        ? [cap, top, '\\endfirsthead']
        : [cap, top, header, mid, '\\endfirsthead', ...(p['continued'] === true ? [`\\multicolumn{${g.columns}}{l}{\\tablename\\ \\thetable{} (continued)} \\\\`] : []), top, header, mid, '\\endhead'];
      const foot = p['continued'] === true ? [mid, `\\multicolumn{${g.columns}}{r}{(continued on the next page)} \\\\`, '\\endfoot', bottom, '\\endlastfoot'] : [bottom, '\\endlastfoot'];
      const all = [...setupLines(p), `\\begin{longtable}{${columnSpec(param(p, 'colspec', 'equal'), g.columns, p['vrules'] !== false)}}`, ...head, ...foot, ...between, '\\end{longtable}'];
      return `${all.filter((l) => l !== '').join('\n')}\n\n`;
    },
  };
};

export default realize;
