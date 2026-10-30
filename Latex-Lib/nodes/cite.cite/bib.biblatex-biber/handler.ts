/**
 * bib.biblatex-biber (cite/cite): biblatex's citation commands: \autocite{key} as the style formats it, \parencite, \textcite, \footcite, \supercite.
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param, textOf } from '../../protocol.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  return {
    preamble: () => ({}),
    emit: (node) => (textOf(node) === '' ? '' : `\\${param(p, 'command', 'autocite')}{${textOf(node)}}`),
  };
};

export default realize;
