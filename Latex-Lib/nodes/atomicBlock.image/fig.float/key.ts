import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'fig.float',
    node: 'atomicBlock/image',
    description:
      "float's [H]: the figure exactly where it is written, \\begin{figure}[H] … \\end{figure}; \\floatstyle{plain|plaintop|boxed|ruled} with \\restylefloat{figure} for the float's look. 88 templates.",
    ctan: ['float'],
    features: ['here', 'centered', 'captioned', 'scaled', 'ruled', 'framed'],
    params: {
      style: { type: 'enum', values: ['plain', 'plaintop', 'boxed', 'ruled'], default: 'plain', description: "the float style (\\floatstyle); plain leaves the kernel's figure" },
      unit: { type: 'enum', values: ['linewidth', 'textwidth', 'columnwidth'], default: 'linewidth', description: "the length the node's width fraction is of" },
      center: { type: 'boolean', default: true, description: 'the image centred (\\centering)' },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'graphicx' },
      { pkg: 'float' },
    ],
    requires: [
      'env:figure',
    ],
    zerotex: 'yes',
  }),
);
