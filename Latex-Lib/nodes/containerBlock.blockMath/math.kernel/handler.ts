/**
 * math.kernel (containerBlock/blockMath). Display maths without amsmath: \[ … \] for one unnumbered line, equation for a numbered one, eqnarray for several lines.
 * \counterwithin (the kernel's since 2018) numbers equations within a section.
 * CTAN: https://ctan.org/pkg/latex-base
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { aligns, kindOf, labelOf, rowsOf } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: () => (param(p, 'numberWithin', 'none') === 'none' ? {} : { declarations: [`\\counterwithin{equation}{${param(p, 'numberWithin')}}`] }),
    emit: (node, content, context, parentType) => (() => { const rows = rowsOf(content); if (rows.length === 0) return ''; const k = kindOf(node); if (k === 'display' && rows.length === 1) return `\\[\n${rows[0]}\n\\]\n\n`; if (k === 'equation' && rows.length === 1) return `\\begin{equation}\n${rows[0]}${labelOf(node)}\n\\end{equation}\n\n`; const env = k === 'display' ? 'eqnarray*' : 'eqnarray'; return `\\begin{${env}}\n${rows.join(' \\\\\n')}${k === 'display' ? '' : labelOf(node)}\n\\end{${env}}\n\n`; })(),
  };
};

export default realize;
