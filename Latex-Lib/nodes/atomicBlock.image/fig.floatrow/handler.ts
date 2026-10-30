/**
 * fig.floatrow: a caption beside the image. sidecap's SCfigure (options
 * leftcaption, rightcaption, outercaption, innercaption;
 * \sidecaptionrelwidth, \sidecaptionvpos), or floatrow's \fcapside under
 * \floatsetup[figure]{capposition=beside, capbesideposition=…}.
 * CTAN: https://ctan.org/pkg/sidecap, https://ctan.org/pkg/floatrow
 */
import { withDefaults } from '../../../schema/params.ts';
import type { Realization } from '../../../schema/realization.ts';
import { field, param } from '../../protocol.ts';
import { captionLines, pathOf, placementOf, widthOf } from '../node.ts';
import key from './key.ts';

const VPOS: { readonly [v: string]: string } = { t: 'top', c: 'center', b: 'bottom' };

export const realize = (given: { readonly [name: string]: unknown } = {}): Realization => {
  const p = withDefaults(key.params, given as never) as { readonly [name: string]: unknown };
  const sidecap = param(p, 'engine', 'sidecap') === 'sidecap';
  const position = param(p, 'position', 'outer');
  const vpos = param(p, 'vpos', 'b');
  return {
    preamble: () => {
      if (sidecap) {
        const declarations = [
          ...(typeof p['relWidth'] === 'number' ? [`\\renewcommand{\\sidecaptionrelwidth}{${Math.round(p['relWidth'] * 100)}}`] : []),
          ...(vpos === 'b' ? [] : [`\\sidecaptionvpos{figure}{${vpos}}`]),
        ];
        return { packages: ['\\usepackage{graphicx}', position === 'outer' ? '\\usepackage{sidecap}' : `\\usepackage[${position}caption]{sidecap}`], ...(declarations.length === 0 ? {} : { declarations }) };
      }
      const side = position === 'outer' || position === 'inner' ? position : position === 'left' ? 'left' : 'right';
      return { packages: ['\\usepackage{graphicx}', '\\usepackage{floatrow}'], declarations: [`\\floatsetup[figure]{capposition=beside,capbesideposition={${VPOS[vpos] ?? 'bottom'},${side}},capbesidesep=quad}`] };
    },
    emit: (node, content, context) => {
      if (pathOf(node) === '') return '';
      const image = `\\includegraphics[width=${widthOf(node, 'linewidth')}]{${pathOf(node)}}`;
      if (sidecap) return `\\begin{SCfigure}[][${placementOf(node, 'h')}]\n\\centering\n${image}${captionLines(node, context)}\n\\end{SCfigure}\n\n`;
      const label = field(node, 'label');
      return `\\begin{figure}[${placementOf(node, 'h')}]\n\\fcapside[\\FBwidth]{\\caption{${(context ?? '').trim()}}${label === '' ? '' : `\\label{${label}}`}}{${image}}\n\\end{figure}\n\n`;
    },
  };
};

export default realize;
