/**
 * thm.tcolorbox: `\newtcbtheorem` per kind (Flouest's `tcolorboxEnvironment`
 * and `tcolorboxLibraries` print the plain box, `Packages/tcolorbox.ts`).
 * The header note is the box's title. A label goes in the body, where it
 * takes the statement's number. Breaking is asked for where the box opens
 * (`\begin{theorem}[breakable]`), not in the declaration, so a statement in a
 * footnote (adapted unbreakable) and one in the body share one environment.
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { bodyOf, declarations, displayName, elementOf, environmentOf, labelLine, numberingOf, text } from '../statement.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const params = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const numbering = numberingOf(params);
  const breakable = params['breakable'] === true;
  const titleBack = text(params, 'colbacktitle', '');
  const extra = text(params, 'extra', '');
  const options = [
    `colback=${text(params, 'colback', 'blue!5')}`,
    `colframe=${text(params, 'colframe', 'blue!55!black')}`,
    `coltitle=${text(params, 'coltitle', 'white')}`,
    ...(titleBack === '' ? [] : [`colbacktitle=${titleBack}`]),
    `fonttitle=${text(params, 'fonttitle', '\\bfseries')}`,
    `boxrule=${text(params, 'boxrule', '0.8pt')}`,
    `arc=${text(params, 'arc', '4pt')}`,
    ...(params['sharp'] === true ? ['sharp corners'] : []),
    'enhanced',
    ...(extra === '' ? [] : [extra]),
  ].join(',');
  return {
    preamble: (_p, _parent, node) => {
      const packages = ['\\usepackage{tcolorbox}'];
      if (node === undefined) return { packages };
      return {
        packages,
        declarations: [
          `\\tcbuselibrary{theorems,skins${breakable ? ',breakable' : ''}}`,
          ...declarations(elementOf(node), numbering, (env, element, counter) => {
            const counting = 'shared' in counter ? `use counter from=${counter.shared}` : counter.within === 'none' ? 'auto counter' : `auto counter,number within=${counter.within}`;
            return `\\newtcbtheorem[${counting}]{${env}}{${displayName(element)}}{${options}}{${env}}`;
          }),
        ],
      };
    },
    emit: (node, content, note) => {
      const env = environmentOf(elementOf(node), numbering.rename === 'yes');
      return `\\begin{${env}}${breakable ? '[breakable]' : ''}{${note ?? ''}}{}\n${labelLine(node)}${bodyOf(content)}\n\\end{${env}}\n\n`;
    },
  };
};

export default realize;
