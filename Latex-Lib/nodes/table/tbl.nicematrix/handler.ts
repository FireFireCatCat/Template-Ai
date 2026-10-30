/**
 * tbl.nicematrix: a key-value table. tabularray's \begin{tblr}{colspec={…},
 * hlines, vlines, hline{1,Z}={1pt}, row{1}={font=\bfseries},
 * row{even}={bg=…}} with spans by \SetCell[c=n]{c}; or nicematrix's
 * \begin{NiceTabular}{…}[hvlines] with \rowcolors in its \CodeBefore and
 * spans by \Block{1-n}{…}.
 * CTAN: https://ctan.org/pkg/tabularray (chapters 2 and 3), https://ctan.org/pkg/nicematrix (sections 4 to 6)
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { floated, gridOf, rowLines, withSetup } from '../node.ts';
import key from './key.ts';

const TBLR_LINES: { readonly [l: string]: readonly string[] } = {
  all: ['hlines', 'vlines'],
  horizontal: ['hlines'],
  outer: ['hline{1,Z}={0.8pt}'],
  three: ['hline{1,Z}={1pt}', 'hline{2}={0.5pt}'],
  inner: ['hline{2-Y}={0.4pt}', 'vline{2-X}={0.4pt}'],
  none: [],
};
const NICE_LINES: { readonly [l: string]: string } = { all: 'hvlines', horizontal: 'hlines', inner: 'hvlines-except-borders', outer: '', three: '', none: '' };

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const nice = param(p, 'package', 'tabularray') === 'nicematrix';
  const lines = param(p, 'lines', 'all');
  const zebra = param(p, 'zebra');
  return {
    preamble: () => ({ packages: [nice ? '\\usepackage{nicematrix}' : '\\usepackage{tabularray}', ...(zebra === '' ? [] : ['\\usepackage{xcolor}'])] }),
    emit: (node, content, context) => {
      const colspec = param(p, 'colspec', 'X');
      if (nice) {
        const g = gridOf(node, content, (n, cell) => `\\Block{1-${n}}{${cell}}${' &'.repeat(n - 1)}`);
        // X columns share the width given by the width key (nicematrix, 8.3).
        const keys = [...(colspec === 'X' ? ['width=\\linewidth'] : []), ...(NICE_LINES[lines] === '' || NICE_LINES[lines] === undefined ? [] : [NICE_LINES[lines]])].join(',');
        const before = zebra === '' ? '' : `\\CodeBefore\n\\rowcolors{2}{${zebra}}{}\n\\Body\n`;
        const letters = colspec === 'X' ? 'X'.repeat(g.columns) : colspec.repeat(g.columns);
        return floated(node, withSetup(p, `\\begin{NiceTabular}{${letters}}${keys === '' ? '' : `[${keys}]`}\n${before}${rowLines(g).join('\n')}\n\\end{NiceTabular}`), context);
      }
      const g = gridOf(node, content, (n, cell) => `\\SetCell[c=${n}]{c} ${cell}${' &'.repeat(n - 1)}`);
      const inner = [
        `colspec={${(colspec === 'X' ? 'X' : colspec).repeat(g.columns)}}`,
        ...(TBLR_LINES[lines] ?? []),
        ...(p['headerBold'] === true ? ['row{1}={font=\\bfseries}'] : []),
        ...(zebra === '' ? [] : [`row{even}={bg=${zebra}}`]),
      ];
      return floated(node, withSetup(p, `\\begin{tblr}{${inner.join(', ')}}\n${rowLines(g).join('\n')}\n\\end{tblr}`), context);
    },
  };
};

export default realize;
