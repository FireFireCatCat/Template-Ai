/**
 * para.kernel: a paragraph, its text and a blank line, indented by \hspace*
 * for each indent step; an empty one keeps its line with \strut. How
 * paragraphs are set apart: the class's way, the parskip package (skip=,
 * indent=), or \parskip and \parindent set directly.
 * CTAN: https://ctan.org/pkg/latex-base, https://ctan.org/pkg/parskip
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const separation = param(p, 'separation', 'class');
  const [skip, indent] = [param(p, 'skip'), param(p, 'indent')];
  const options = [...(skip === '' ? [] : [`skip=${skip}`]), ...(indent === '' ? [] : [`indent=${indent}`])];
  const preamble =
    separation === 'parskip' ? { packages: [`\\usepackage${options.length === 0 ? '' : `[${options.join(', ')}]`}{parskip}`] }
    : separation === 'lengths' ? { declarations: [...(indent === '' ? [] : [`\\setlength{\\parindent}{${indent}}`]), ...(skip === '' ? [] : [`\\setlength{\\parskip}{${skip}}`])] }
    : {};
  const step = Number.parseFloat(param(p, 'indentStep', '1.5em')) || 1.5;
  const unit = param(p, 'indentStep', '1.5em').replace(/^[\d.]+/u, '') || 'em';
  return {
    preamble: () => preamble,
    emit: (node, content) => {
      const level = Math.max(0, Math.floor(Number(node.attrs?.['indent'] ?? 0)) || 0);
      const lead = level > 0 ? `\\hspace*{${level * step}${unit}}` : '';
      return content.trim() === '' ? `${lead}\\strut\\par\n\n` : `${lead}${content}\n\n`;
    },
  };
};

export default realize;
