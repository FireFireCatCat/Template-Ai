import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { NUMBERING } from '../node.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'head.kernel',
    node: 'paragraph/heading',
    description:
      "The kernel's sectioning commands, \\part to \\subparagraph: \\section[short]{Title}, starred when unnumbered, with its \\label. The class's look; only the numbering can change, its depth (\\setcounter{secnumdepth}) and a chapter's or section's number style. The way 496 of the research's templates use.",
    ctan: ['latex-base'],
    features: ['numbered', 'unnumbered', 'lettered', 'bold-head', 'hang-head'],
    params: {
      ...NUMBERING,
    },
    presets: PRESETS,
    requires: [
      'counter:{kind}',
    ],
    zerotex: 'untested',
  }),
);
