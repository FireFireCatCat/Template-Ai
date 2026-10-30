/**
 * tbl.tabularx: \begin{tabularx}{width}{X…} … \end{tabularx}, a table of a
 * fixed width whose X columns share the room; X columns ragged or centred
 * with >{\raggedright\arraybackslash}X, a natural first column, | and \hline.
 * CTAN: https://ctan.org/pkg/tabularx
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { floated, gridOf, hasHeader, ruledRows, rowLines, withSetup } from '../node.ts';
import key from './key.ts';

const ALIGN: { readonly [a: string]: string } = { justify: 'X', left: '>{\\raggedright\\arraybackslash}X', center: '>{\\centering\\arraybackslash}X', right: '>{\\raggedleft\\arraybackslash}X' };

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: () => ({ packages: ['\\usepackage{tabularx}'] }),
    emit: (node, content, context) => {
      const g = gridOf(node, content);
      const x = ALIGN[param(p, 'align', 'justify')] ?? 'X';
      const first = param(p, 'firstColumn', 'X');
      const letters = Array.from({ length: g.columns }, (_, i) => (i === 0 && first !== 'X' ? first : x));
      const sep = p['vrules'] === false ? '' : '|';
      const rows = ruledRows(rowLines(g), param(p, 'rules', 'all'), hasHeader(node));
      return floated(node, withSetup(p, `\\begin{tabularx}{${param(p, 'width', '\\linewidth')}}{${sep}${letters.join(sep)}${sep}}\n${rows.join('\n')}\n\\end{tabularx}`), context);
    },
  };
};

export default realize;
