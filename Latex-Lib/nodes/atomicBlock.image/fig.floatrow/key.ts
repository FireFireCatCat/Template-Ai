import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'fig.floatrow',
    node: 'atomicBlock/image',
    description:
      "A caption beside the image: sidecap's \\begin{SCfigure} … \\end{SCfigure} (leftcaption, rightcaption, outercaption, innercaption; \\sidecaptionrelwidth, \\sidecaptionvpos), or floatrow's \\fcapside under \\floatsetup[figure]{capposition=beside,capbesideposition=…}. 11 templates.",
    ctan: ['sidecap', 'floatrow'],
    features: ['side-caption', 'floating', 'captioned', 'scaled'],
    params: {
      engine: { type: 'enum', values: ['sidecap', 'floatrow'], default: 'sidecap', compat: true, description: "sidecap's SCfigure, or floatrow's \\fcapside" },
      position: { type: 'enum', values: ['outer', 'inner', 'left', 'right'], default: 'outer', description: 'which side the caption goes' },
      vpos: { type: 'enum', values: ['t', 'c', 'b'], default: 'b', description: 'the caption at the top, centre or bottom of the image' },
      relWidth: { type: 'number', default: 1, description: "sidecap: the caption's width relative to the image (\\sidecaptionrelwidth, 1 = as wide)" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'graphicx' },
      { pkg: 'sidecap', when: { engine: 'sidecap', position: 'outer' } },
      { pkg: 'sidecap', options: ['innercaption'], when: { engine: 'sidecap', position: 'inner' } },
      { pkg: 'sidecap', options: ['leftcaption'], when: { engine: 'sidecap', position: 'left' } },
      { pkg: 'sidecap', options: ['rightcaption'], when: { engine: 'sidecap', position: 'right' } },
      { pkg: 'floatrow', when: { engine: 'floatrow' } },
    ],
    requires: [
      'env:figure',
    ],
    deny: [
      { class: 'class.beamer', reason: 'beamer ignores float placement; figure is a centre environment', evidence: [{ kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '85' }] },
    ],
    zerotex: 'untested',
  }),
);
