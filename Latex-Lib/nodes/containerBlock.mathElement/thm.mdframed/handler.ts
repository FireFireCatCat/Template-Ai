/**
 * thm.mdframed: `\newmdtheoremenv[options]{env}[shared]{Name}[within]` per kind,
 * the same arguments as `\newtheorem` after mdframed's options.
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { declarations, displayName, elementOf, environmentOf, numberingOf, statementIn, text, withinArgument } from '../statement.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const params = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const numbering = numberingOf(params);
  const extra = text(params, 'extra', '');
  const options = [
    `linecolor=${text(params, 'linecolor', 'black')}`,
    `backgroundcolor=${text(params, 'backgroundcolor', 'white')}`,
    `linewidth=${text(params, 'linewidth', '0.4pt')}`,
    ...(params['leftLineOnly'] === true ? ['topline=false', 'rightline=false', 'bottomline=false'] : []),
    ...(extra === '' ? [] : [extra]),
  ].join(',');
  return {
    preamble: (_p, _parent, node) => {
      const packages = ['\\usepackage{mdframed}'];
      if (node === undefined) return { packages };
      return {
        packages,
        declarations: declarations(elementOf(node), numbering, (env, element, counter) =>
          'shared' in counter
            ? `\\newmdtheoremenv[${options}]{${env}}[${counter.shared}]{${displayName(element)}}`
            : `\\newmdtheoremenv[${options}]{${env}}{${displayName(element)}}${withinArgument(counter.within)}`,
        ),
      };
    },
    emit: (node, content, note) => statementIn(environmentOf(elementOf(node), numbering.rename === 'yes'), node, content, note),
  };
};

export default realize;
