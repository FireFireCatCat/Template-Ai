/**
 * code.listings: \begin{lstlisting}[style=lib, language=…, caption={…},
 * label=…] … \end{lstlisting}, its look in one \lstdefinestyle: basicstyle,
 * keywordstyle, commentstyle, stringstyle, numbers and numberstyle, frame,
 * backgroundcolor, breaklines, columns, tabsize, captionpos; escaped LaTeX
 * between (*@ and @*) (escapeinside).
 * CTAN: https://ctan.org/pkg/listings
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { field, param } from '../../protocol.ts';
import { codeText, colours, listingsLanguage } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const tex = (name: string, k: string): string[] => (param(p, name) === '' ? [] : [`${k}=${param(p, name)}`]);
  const background = param(p, 'background');
  const style = [
    ...tex('font', 'basicstyle'),
    ...tex('keywordStyle', 'keywordstyle'),
    ...tex('commentStyle', 'commentstyle'),
    ...tex('stringStyle', 'stringstyle'),
    ...(param(p, 'numbers', 'none') === 'none' ? [] : [`numbers=${param(p, 'numbers')}`, ...tex('numberStyle', 'numberstyle')]),
    ...(param(p, 'frame', 'none') === 'none' ? [] : [`frame=${param(p, 'frame')}`]),
    ...(background === '' ? [] : [`backgroundcolor=\\color{${background}}`]),
    `breaklines=${p['breaklines'] === false ? 'false' : 'true'}`,
    'showstringspaces=false',
    ...(param(p, 'columns', 'fixed') === 'fixed' ? [] : [`columns=${param(p, 'columns')}`]),
    ...(typeof p['tabsize'] === 'number' && p['tabsize'] !== 8 ? [`tabsize=${p['tabsize']}`] : []),
    ...(param(p, 'captionPos', 't') === 't' ? [] : [`captionpos=${param(p, 'captionPos')}`]),
  ];
  const xcolor = background !== '' || colours([param(p, 'keywordStyle'), param(p, 'commentStyle'), param(p, 'stringStyle'), param(p, 'numberStyle')]);
  return {
    preamble: () => ({ packages: ['\\usepackage{listings}', ...(xcolor ? ['\\usepackage{xcolor}'] : [])], declarations: [`\\lstdefinestyle{lib}{\n  ${style.join(',\n  ')}\n}`] }),
    emit: (node, content, context) => {
      const lang = listingsLanguage(node);
      const options = ['style=lib', ...(lang === undefined ? [] : [`language=${lang}`]), 'escapeinside={(*@}{@*)}', ...(context !== undefined && context.trim() !== '' ? [`caption={${context.trim()}}`] : []), ...(field(node, 'label') === '' ? [] : [`label=${field(node, 'label')}`])];
      return `\\begin{lstlisting}[${options.join(', ')}]\n${codeText(content, (latex) => `(*@${latex}@*)`)}\n\\end{lstlisting}\n\n`;
    },
  };
};

export default realize;
