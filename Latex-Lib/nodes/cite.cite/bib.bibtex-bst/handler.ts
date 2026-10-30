/**
 * bib.bibtex-bst (cite/cite): The kernel's \cite{key}, the label as the .bst style makes it, joined to the text by a tie when asked.
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param, textOf } from '../../protocol.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: () => ({}),
    emit: (node) => (textOf(node) === '' ? '' : `${p['tie'] === true ? '~' : ''}\\${param(p, 'command', 'cite')}{${textOf(node)}}`),
  };
};

export default realize;
