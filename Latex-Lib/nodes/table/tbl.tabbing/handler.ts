/**
 * tbl.tabbing: the kernel's \begin{tabbing} … \end{tabbing}, columns at tab
 * stops set by a first line ended with \kill, cells separated by \>; no
 * rules, no float, no caption.
 * CTAN: https://ctan.org/pkg/latex-base (usrguide, tabbing)
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { gridOf, rowLines } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: () => ({}),
    emit: (node, content) => {
      const g = gridOf(node, content);
      const first = param(p, 'firstStop');
      const stops = Array.from({ length: g.columns }, (_, i) => (i === 0 && first !== '' ? `\\hspace*{${first}}\\=` : `\\hspace{${(0.9 / g.columns).toFixed(3)}\\linewidth}\\=`)).join('');
      return `\\begin{tabbing}\n${stops}\\kill\n${rowLines(g, ' \\> ').join('\n')}\n\\end{tabbing}\n\n`;
    },
  };
};

export default realize;
