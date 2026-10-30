/**
 * front.maketitle: \title, \author and \date in the preamble, \maketitle
 * where the title stands; \date{} for no date, \date{\today} for today's.
 * CTAN: https://ctan.org/pkg/latex-base
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { titleLinesWith } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: (_params, _parentType, node, content) => (node === undefined || content === undefined ? {} : { declarations: titleLinesWith(node, content, param(p, 'date', 'given')) }),
    emit: () => '\\maketitle\n\n',
  };
};

export default realize;
