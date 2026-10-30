/**
 * bib.apacite (cite/cite): apacite's citation commands: \cite{key} (Knuth, 1984), \citeA{key} Knuth (1984), \citeNP without parentheses.
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param, textOf } from '../../protocol.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: () => ({}),
    emit: (node) => (textOf(node) === '' ? '' : `\\${param(p, 'command', 'cite')}{${textOf(node)}}`),
  };
};

export default realize;
