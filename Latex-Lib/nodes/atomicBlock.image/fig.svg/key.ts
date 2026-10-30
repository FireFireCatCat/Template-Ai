import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'fig.svg',
    node: 'atomicBlock/image',
    description:
      "svg: an SVG file through \\includesvg[width=…]{file} in a figure float, converted by Inkscape at compile time (shell escape, which ZeroTeX-NG does not have); inkscapelatex=false keeps the drawing's own text, \\svgpath a folder. 6 templates.",
    ctan: ['svg'],
    features: ['vector-graphics', 'floating', 'centered', 'captioned', 'scaled'],
    params: {
      latexText: { type: 'boolean', default: true, description: "the drawing's text typeset by LaTeX; false keeps Inkscape's (inkscapelatex=false)" },
      svgPath: { type: 'string', default: '', description: "a folder SVG files are looked up in (\\svgpath); ''" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'svg' },
    ],
    requires: [
      'env:figure',
    ],
    zerotex: 'no',
  }),
);
