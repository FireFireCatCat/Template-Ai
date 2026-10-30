import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'abs.abstract-pkg',
    node: 'containerBlock/abstract',
    description:
      "The abstract package over the class's abstract: \\abstractnamefont and \\abstracttextfont for its fonts, \\absleftindent and \\absrightindent for its width, the runin and addtotoc options. 4 templates.",
    ctan: ['abstract'],
    features: ['small-type', 'sans-serif', 'run-in-head', 'in-contents', 'indented', 'centered'],
    params: {
      nameFont: { type: 'tex', default: '\\normalfont\\small\\bfseries', description: "the heading's font (\\abstractnamefont)" },
      textFont: { type: 'tex', default: '\\normalfont\\small', description: "the text's font (\\abstracttextfont)" },
      indent: { type: 'dimen', default: '', description: "the left and right indents (\\absleftindent, \\absrightindent; \\leftmargin by default); ''" },
      runIn: { type: 'boolean', default: false, compat: true, description: 'the heading run into the first line (runin)' },
      inContents: { type: 'boolean', default: false, description: 'the abstract listed in the contents (addtotoc)' },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'abstract' },
      { pkg: 'abstract', options: ['runin'], when: { runIn: true } },
      { pkg: 'abstract', options: ['addtotoc'], when: { inContents: true } },
    ],
    zerotex: 'untested',
  }),
);
