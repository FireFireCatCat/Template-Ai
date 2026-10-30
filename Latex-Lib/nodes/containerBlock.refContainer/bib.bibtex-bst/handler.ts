/**
 * bib.bibtex-bst: BibTeX with a .bst style, \bibliographystyle{plain} and
 * \bibliography{\jobname}, the entries written to \jobname.bib; the standard
 * styles plain, unsrt, alpha, abbrv, ieeetr, acm, siam, apalike; the heading
 * through \refname or \bibname.
 * CTAN: https://ctan.org/pkg/bibtex
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { bibFile, headingLines } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const declarations = headingLines(param(p, 'heading'));
  return {
    preamble: (_params, _parentType, node, content) => ({ beforeDocument: bibFile(content), ...(declarations.length === 0 ? {} : { declarations }) }),
    emit: () => `\\nocite{*}\n\\bibliographystyle{${param(p, 'bst', 'plain')}}\n\\bibliography{\\jobname}\n\n`,
  };
};

export default realize;
