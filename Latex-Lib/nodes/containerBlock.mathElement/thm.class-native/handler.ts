/**
 * thm.class-native: each kind by the class's own environment. A kind the
 * class does not define (acmart has no remark, as its guide shows how to add)
 * is declared with the class's own command only if still undefined:
 * `\newtheorem` as the class has it, or, for upright kinds, the command the
 * preset names (elsarticle's `\newdefinition`).
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { amsStyleOf, displayName, elementOf, statementIn, text } from '../statement.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const upright = text(withDefaults(key.params, given as never), 'uprightCommand', '');
  return {
    preamble: (_p, _parent, node) => {
      if (node === undefined) return {};
      const element = elementOf(node);
      const command = upright !== '' && amsStyleOf(element) !== 'plain' ? upright : '\\newtheorem';
      return { declarations: [`\\makeatletter\n\\@ifundefined{${element}}{${command}{${element}}{${displayName(element)}}}{}\n\\makeatother`] };
    },
    emit: (node, content, note) => statementIn(elementOf(node), node, content, note),
  };
};

export default realize;
