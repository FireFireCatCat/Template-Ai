/**
 * tbl.colortbl: row colours through xcolor's table option (colortbl):
 * \rowcolors{start}{odd}{even} for stripes, \rowcolor{…} for a header band,
 * \arrayrulecolor for the rules' colour, \hline where asked.
 * CTAN: https://ctan.org/pkg/colortbl, https://ctan.org/pkg/xcolor (table option)
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { columnSpec, floated, gridOf, hasHeader, ruledRows, rowLines, withSetup } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const [odd, even] = [param(p, 'odd'), param(p, 'even')];
  return {
    preamble: () => ({ packages: ['\\usepackage[table]{xcolor}'] }),
    emit: (node, content, context) => {
      const g = gridOf(node, content);
      const lines = rowLines(g);
      const headerColor = param(p, 'headerColor');
      const text = param(p, 'headerText');
      if (headerColor !== '' && hasHeader(node) && lines.length > 0) {
        const fields = g.rows[0] ?? [];
        lines[0] = `\\rowcolor{${headerColor}}${text === '' ? fields.join(' & ') : fields.map((f) => `\\color{${text}}${f}`).join(' & ')} \\\\`;
      }
      const rows = ruledRows(lines, param(p, 'rules', 'none'), hasHeader(node));
      const setup = [
        ...(odd === '' && even === '' ? [] : [`\\rowcolors{${typeof p['start'] === 'number' ? p['start'] : 2}}{${odd === '' ? 'white' : odd}}{${even === '' ? 'white' : even}}`]),
        ...(param(p, 'ruleColor') === '' ? [] : [`\\arrayrulecolor{${param(p, 'ruleColor')}}`]),
      ];
      return floated(node, withSetup(p, [...setup, `\\begin{tabular}{${columnSpec(param(p, 'colspec', 'equal'), g.columns, p['vrules'] === true)}}\n${rows.join('\n')}\n\\end{tabular}`].join('\n')), context);
    },
  };
};

export default realize;
