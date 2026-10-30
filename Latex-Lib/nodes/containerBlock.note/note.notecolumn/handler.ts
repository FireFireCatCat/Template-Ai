/**
 * note.notecolumn: KOMA's scrlayer-notecolumn. \makenote[column]{text} into
 * the marginpar column, or a column of its own declared with
 * \DeclareNewNoteColumn[font=…,width=…]{name}; reversemarginpar puts it in
 * the other margin.
 * CTAN: https://ctan.org/pkg/koma-script
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { titled } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const column = param(p, 'column', 'marginpar');
  const options = [
    ...(param(p, 'font') === '' ? [] : [`font=${param(p, 'font')}`]),
    ...(param(p, 'width') === '' ? [] : [`width=${param(p, 'width')}`]),
    ...(param(p, 'side', 'normal') === 'reverse' ? ['reversemarginpar'] : []),
  ];
  const declare = column === 'marginpar' ? (options.length === 0 ? [] : [`\\DeclareNoteColumn[${options.join(',')}]{marginpar}`]) : [`\\DeclareNewNoteColumn${options.length === 0 ? '' : `[${options.join(',')}]`}{${column}}`];
  return {
    preamble: () => ({ packages: ['\\usepackage{scrlayer-notecolumn}'], ...(declare.length === 0 ? {} : { declarations: declare }) }),
    emit: (node, content) => `\n\\makenote${column === 'marginpar' ? '' : `[${column}]`}{${titled(node, content)}}\n`,
  };
};

export default realize;
