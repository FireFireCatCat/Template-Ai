/**
 * abs.class-native (containerBlock/abstract). The class's own abstract, unstyled: \begin{abstract} … \end{abstract} as acmart, IEEEtran or elsarticle print it, or \abstract{…} in the preamble where the class makes it a command that \maketitle prints (sn-jnl, mdpi, aa).
 * CTAN: https://ctan.org/pkg/latex-base
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: (_params, _parentType, node, content) => param(p, 'form') === 'command' && node !== undefined && content !== undefined ? { declarations: [`\\abstract{${content.trim()}}`] } : {},
    emit: (node, content, context, parentType) => param(p, 'form') === 'command' ? '' : `\\begin{abstract}\n${content.trim()}\n\\end{abstract}\n\n`,
  };
};

export default realize;
