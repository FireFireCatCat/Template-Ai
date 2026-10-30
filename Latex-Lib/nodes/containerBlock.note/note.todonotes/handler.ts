/**
 * note.todonotes: \todo[options]{text}, a coloured note in the margin. The
 * command's keys (color, backgroundcolor, linecolor, bordercolor, textcolor,
 * size, line, noline, fancyline, inline, shadow) and the package options
 * colorinlistoftodos and disable.
 * CTAN: https://ctan.org/pkg/todonotes (sections 1.2 and 1.3)
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { param } from '../../protocol.ts';
import { titled } from '../node.ts';
import key from './key.ts';

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const pkgOptions = [...(p['colorInList'] === true ? ['colorinlistoftodos'] : []), ...(p['disable'] === true ? ['disable'] : [])];
  const packages = [`\\usepackage${pkgOptions.length === 0 ? '' : `[${pkgOptions.join(',')}]`}{todonotes}`];
  const keys = [
    ...(param(p, 'color') === '' ? [] : [`color=${param(p, 'color')}`]),
    ...(param(p, 'lineColor') === '' ? [] : [`linecolor=${param(p, 'lineColor')}`]),
    ...(param(p, 'borderColor') === '' ? [] : [`bordercolor=${param(p, 'borderColor')}`]),
    ...(param(p, 'textColor') === '' ? [] : [`textcolor=${param(p, 'textColor')}`]),
    ...(param(p, 'size') === '' ? [] : [`size=${param(p, 'size')}`]),
    ...(param(p, 'line', 'line') === 'line' ? [] : [param(p, 'line')]),
    ...(p['inline'] === true ? ['inline'] : []),
    ...(p['shadow'] === true ? ['shadow'] : []),
  ];
  return {
    preamble: () => ({ packages }),
    emit: (node, content) => `\n\\todo${keys.length === 0 ? '' : `[${keys.join(',')}]`}{${titled(node, content)}}\n`,
  };
};

export default realize;
