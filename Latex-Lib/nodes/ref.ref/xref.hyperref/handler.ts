/**
 * xref.hyperref: \autoref{label}, the target's kind and number linked;
 * \nameref{label} for its title; \hyperref[label]{text} when the node gives
 * its own name.
 * CTAN: https://ctan.org/pkg/hyperref
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param, textOf } from '../../protocol.ts';
import { refNameOf } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: () => ({ packages: ['\\usepackage{hyperref}'] }),
    emit: (node) => (refNameOf(node) !== '' && param(p, 'command', 'autoref') === 'autoref' ? `\\hyperref[${textOf(node)}]{${refNameOf(node)}}` : `\\${param(p, 'command', 'autoref')}{${textOf(node)}}`),
  };
};

export default realize;
