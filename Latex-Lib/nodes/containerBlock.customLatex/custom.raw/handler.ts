/**
 * custom.raw (containerBlock/customLatex). A block of raw LaTeX the author wrote, with its preamble (data.preamble) when it has one.
 * CTAN: https://ctan.org/pkg/latex-base
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { field } from '../../protocol.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: (_params, _parentType, node, content) => field(node, 'preamble') === '' ? {} : { declarations: [field(node, 'preamble')] },
    emit: (node, content, context, parentType) => `${content}\n`,
  };
};

export default realize;
