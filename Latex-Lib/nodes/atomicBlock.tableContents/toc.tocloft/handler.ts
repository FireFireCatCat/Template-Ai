/**
 * toc.tocloft: the contents restyled by tocloft's hooks: \cftsecleader with
 * \cftdotfill{\cftdotsep} for dot leaders, \cftsecfont and \cftsecpagefont,
 * \cftsecaftersnumb after the number, \cfttoctitlefont and
 * \cftaftertoctitle for the title; then \tableofcontents.
 * CTAN: https://ctan.org/pkg/tocloft
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { contentsBody, contentsDeclarations } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const set = (name: string, command: string): string[] => (param(p, name) === '' ? [] : [`\\renewcommand{\\${command}}{${param(p, name)}}`]);
  const declarations = [
    ...contentsDeclarations(p),
    ...(param(p, 'leaders', 'sections') === 'sections' ? ['\\renewcommand{\\cftsecleader}{\\cftdotfill{\\cftdotsep}}'] : param(p, 'leaders') === 'all' ? ['\\renewcommand{\\cftsecleader}{\\cftdotfill{\\cftdotsep}}', '\\renewcommand{\\cftsubsecleader}{\\cftdotfill{\\cftdotsep}}'] : []),
    ...set('sectionFont', 'cftsecfont'),
    ...set('pageFont', 'cftsecpagefont'),
    ...set('afterNumber', 'cftsecaftersnumb'),
    ...set('titleFont', 'cfttoctitlefont'),
    ...set('titleAfter', 'cftaftertoctitle'),
  ];
  return {
    preamble: () => ({ packages: ['\\usepackage{tocloft}'], declarations }),
    emit: () => contentsBody(p),
  };
};

export default realize;
