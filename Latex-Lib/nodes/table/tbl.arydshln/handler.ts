/**
 * tbl.arydshln: dashed rules in a tabular. \hdashline between rows,
 * ;{dash/gap} (or :) between columns, \dashlinedash and \dashlinegap for
 * the dash shape; solid \hline at the edges when asked.
 * CTAN: https://ctan.org/pkg/arydshln (section 2)
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { columnSpec, floated, gridOf, ruledRows, rowLines, withSetup } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const [dash, gap] = [param(p, 'dash'), param(p, 'gap')];
  const declarations = [...(dash === '' ? [] : [`\\setlength{\\dashlinedash}{${dash}}`]), ...(gap === '' ? [] : [`\\setlength{\\dashlinegap}{${gap}}`])];
  return {
    preamble: () => ({ packages: ['\\usepackage{arydshln}'], ...(declarations.length === 0 ? {} : { declarations }) }),
    emit: (node, content, context) => {
      const g = gridOf(node, content);
      const edge = param(p, 'outer', 'dashed') === 'solid' ? '\\hline' : '\\hdashline';
      const rows = ruledRows(rowLines(g), 'all', false, { top: edge, mid: '\\hdashline', bottom: edge, between: '\\hdashline' });
      const spec = columnSpec(param(p, 'colspec', 'l'), g.columns, p['vertical'] !== false, ';{2pt/3pt}');
      return floated(node, withSetup(p, `\\begin{tabular}{${spec}}\n${rows.join('\n')}\n\\end{tabular}`), context);
    },
  };
};

export default realize;
