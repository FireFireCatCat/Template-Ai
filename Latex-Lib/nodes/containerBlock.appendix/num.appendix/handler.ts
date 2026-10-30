/**
 * num.appendix: \appendix once before the first appendix, then each
 * appendix as \section{Title} (lettered A, B …) or \chapter{Title} ("Appendix
 * A" in chaptered classes); with the appendix package, \appendixpage for an
 * "Appendices" heading and \addappheadtotoc for its contents line; the word
 * through \appendixname.
 * CTAN: https://ctan.org/pkg/latex-base, https://ctan.org/pkg/appendix (section 2)
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { dataOf, field, labelLine, param } from '../../protocol.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const pkg = param(p, 'form', 'kernel') === 'package';
  // Run once, at the first appendix: the switch, then the package's heading and contents line.
  const start = ['\\appendix', ...(pkg && p['toc'] === true ? ['\\addappheadtotoc'] : []), ...(pkg && p['page'] === true ? ['\\appendixpage'] : [])].join('');
  return {
    preamble: () => ({
      ...(pkg ? { packages: ['\\usepackage{appendix}'] } : {}),
      ...(param(p, 'name') === '' ? {} : { declarations: [`\\renewcommand{\\appendixname}{${param(p, 'name')}}`] }),
    }),
    emit: (node, content) =>
      [
        `\\ifdefined\\LibAppendicesStarted\\else${start}\\global\\let\\LibAppendicesStarted\\empty\\fi`,
        `\\${param(p, 'level', 'section')}${dataOf(node)['numbered'] === false ? '*' : ''}{${field(node, 'title', 'Appendix')}}${labelLine(field(node, 'label'))}`,
        content.trim(),
      ]
        .filter(Boolean)
        .join('\n') + '\n\n',
  };
};

export default realize;
