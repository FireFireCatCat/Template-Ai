/**
 * note.marginpar: the kernel's \marginpar{…}, a float in the margin;
 * \reversemarginpar for the other side, \marginparwidth and \marginparsep
 * for the column.
 * CTAN: https://ctan.org/pkg/latex-base (usrguide, \marginpar)
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { titled } from '../node.ts';
import key from './key.ts';

export const ALIGN: { readonly [align: string]: string } = { ragged: '\\raggedright', justified: '', center: '\\centering' };

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const declarations = [
    ...(param(p, 'side', 'outer') === 'reverse' ? ['\\reversemarginpar'] : []),
    ...(param(p, 'width') === '' ? [] : [`\\setlength{\\marginparwidth}{${param(p, 'width')}}`]),
    ...(param(p, 'sep') === '' ? [] : [`\\setlength{\\marginparsep}{${param(p, 'sep')}}`]),
  ];
  // A reversed note sits left of the text, so ragged means flush against it.
  const align = param(p, 'side', 'outer') === 'reverse' && param(p, 'align', 'ragged') === 'ragged' ? '\\raggedleft' : ALIGN[param(p, 'align', 'ragged')] ?? '';
  return {
    preamble: () => (declarations.length === 0 ? {} : { declarations }),
    emit: (node, content) => `\n\\marginpar{${param(p, 'font')}${align}\n${p['title'] === false ? content.trim() || '\\mbox{}' : titled(node, content)}}\n`,
  };
};

export default realize;
