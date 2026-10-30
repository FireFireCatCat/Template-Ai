/**
 * head.fncychap: \usepackage[<style>]{fncychap}, then the manual's
 * customisation commands (\ChNameVar, \ChNumVar, \ChTitleVar, \ChRuleWidth,
 * \ChNameUpperCase … \ChTitleAsIs) when a preset sets them. Only chapters
 * change; every heading prints with the kernel command.
 * CTAN: https://ctan.org/pkg/fncychap (section 2.1)
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { headingCommand, levelOf, numberingLines } from '../node.ts';
import key from './key.ts';

const CASE: { readonly [c: string]: string } = { upper: 'UpperCase', lower: 'LowerCase', asis: 'AsIs' };

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const packages = [`\\usepackage[${param(p, 'style', 'Sonny')}]{fncychap}`];
  const custom = [
    ...(param(p, 'nameFont') === '' ? [] : [`\\ChNameVar{${param(p, 'nameFont')}}`]),
    ...(param(p, 'numberFont') === '' ? [] : [`\\ChNumVar{${param(p, 'numberFont')}}`]),
    ...(param(p, 'titleFont') === '' ? [] : [`\\ChTitleVar{${param(p, 'titleFont')}}`]),
    ...(param(p, 'ruleWidth') === '' ? [] : [`\\ChRuleWidth{${param(p, 'ruleWidth')}}`]),
    ...(CASE[param(p, 'nameCase', 'style')] === undefined ? [] : [`\\ChName${CASE[param(p, 'nameCase')]}`]),
    // The manual names \ChNameAsIs for the title's default case too; \ChTitleAsIs is what the package defines.
    ...(CASE[param(p, 'titleCase', 'style')] === undefined ? [] : [`\\ChTitle${CASE[param(p, 'titleCase')]}`]),
  ];
  return {
    preamble: (_params, _parentType, node) => {
      const declarations = node === undefined ? custom : [...numberingLines(p, levelOf(node)), ...custom];
      return declarations.length === 0 ? { packages } : { packages, declarations };
    },
    emit: (node, content) => headingCommand(node, content),
  };
};

export default realize;
