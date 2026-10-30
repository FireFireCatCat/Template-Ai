/**
 * xref.kernel: the kernel's \ref{label}, the number only, after the target's
 * name and a tie when the node gives one (Figure~\ref{…}).
 * CTAN: https://ctan.org/pkg/latex-base
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { textOf } from '../../protocol.ts';
import { refNameOf } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: () => ({}),
    emit: (node) => `${p['name'] === false || refNameOf(node) === '' ? '' : `${refNameOf(node)}~`}\\ref{${textOf(node)}}`,
  };
};

export default realize;
