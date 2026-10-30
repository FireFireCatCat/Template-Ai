/**
 * abs.kernel: the class's \begin{abstract} … \end{abstract}; \abstractname
 * renamed, the first-line indent dropped.
 * CTAN: https://ctan.org/pkg/latex-base
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: () => (param(p, 'name') === '' ? {} : { declarations: [`\\renewcommand{\\abstractname}{${param(p, 'name')}}`] }),
    emit: (node, content) => `\\begin{abstract}\n${p['noindent'] === true ? '\\setlength{\\parindent}{0pt}\\noindent ' : ''}${content.trim()}\n\\end{abstract}\n\n`,
  };
};

export default realize;
