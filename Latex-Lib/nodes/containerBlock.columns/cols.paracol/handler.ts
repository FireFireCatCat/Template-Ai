/**
 * cols.paracol: \begin{paracol}{n} … \switchcolumn … \end{paracol},
 * parallel columns, the blocks shared out across them in order;
 * \columnratio{r} for unequal widths, \columnsep for the gap, \columnseprule
 * and \colseprulecolor for a rule.
 * CTAN: https://ctan.org/pkg/paracol (paracol, \switchcolumn, \columnratio, \colseprulecolor)
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { countOf, gapOf } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const color = param(p, 'ruleColor');
  return {
    // paracol takes over the output routine, so it is not put in a group: its settings go in the preamble.
    preamble: (_params, _parentType, node) => ({
      packages: ['\\usepackage{paracol}', ...(color === '' ? [] : ['\\usepackage{xcolor}'])],
      declarations: [
        ...(node === undefined ? [] : [`\\setlength{\\columnsep}{${gapOf(node)}}`]),
        ...(param(p, 'ratio') === '' ? [] : [`\\columnratio{${param(p, 'ratio')}}`]),
        ...(param(p, 'rule') === '' ? [] : [`\\setlength{\\columnseprule}{${param(p, 'rule')}}`]),
        ...(color === '' ? [] : [`\\colseprulecolor{${color}}`]),
      ],
    }),
    emit: (node, content) => {
      const blocks = content.trim().split(/\n\s*\n/u);
      const n = countOf(node);
      const per = Math.ceil(blocks.length / n);
      const parts = Array.from({ length: n }, (_, i) => blocks.slice(i * per, (i + 1) * per).join('\n\n'));
      return `\\begin{paracol}{${n}}\n${parts.join('\n\\switchcolumn\n')}\n\\end{paracol}\n\n`;
    },
  };
};

export default realize;
