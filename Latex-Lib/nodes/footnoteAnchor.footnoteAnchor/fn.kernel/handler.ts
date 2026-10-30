/**
 * fn.kernel: the kernel's \footnote{…}, which Flouest's emitter writes
 * itself (only the preamble is read); the marks (\thefootnote as \alph,
 * \roman or \fnsymbol) and \counterwithin for per-chapter numbers.
 * CTAN: https://ctan.org/pkg/latex-base
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import key from './key.ts';

const MARKS: { readonly [m: string]: string } = { symbols: '\\fnsymbol{footnote}', alph: '\\alph{footnote}', roman: '\\roman{footnote}' };

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const marks = MARKS[param(p, 'marks', 'arabic')];
  const declarations = [
    ...(marks === undefined ? [] : [`\\renewcommand{\\thefootnote}{${marks}}`]),
    ...(param(p, 'numberWithin', 'none') === 'none' ? [] : [`\\counterwithin{footnote}{${param(p, 'numberWithin')}}`]),
  ];
  return {
    preamble: () => (declarations.length === 0 ? {} : { declarations }),
    emit: (node, content) => content,
  };
};

export default realize;
