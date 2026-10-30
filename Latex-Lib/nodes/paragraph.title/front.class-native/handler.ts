/**
 * front.class-native (paragraph/title). The class's own title block: \title, \author, \date and \maketitle as the class lays them out (acmart, llncs, IEEEtran restyle \maketitle themselves).
 * CTAN: https://ctan.org/pkg/latex-base
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { titleLines } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: (_params, _parentType, node, content) => node === undefined || content === undefined ? {} : { declarations: titleLines(node, content) },
    emit: (node, content, context, parentType) => '\\maketitle\n\n',
  };
};

export default realize;
