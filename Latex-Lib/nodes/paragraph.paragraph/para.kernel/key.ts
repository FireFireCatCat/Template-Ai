import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'para.kernel',
    node: 'paragraph/paragraph',
    description:
      "A paragraph: its text and a blank line, indented by \\hspace* for each indent step; an empty one keeps its line with \\strut. Paragraphs set apart the class's way, by the parskip package (skip=, indent=), or by \\parskip and \\parindent.",
    ctan: ['latex-base'],
    features: ['indented'],
    params: {
      separation: { type: 'enum', values: ['class', 'parskip', 'lengths'], default: 'class', description: "the class's indented paragraphs, the parskip package, or \\parskip and \\parindent set directly" },
      skip: { type: 'string', default: '', description: "space between paragraphs (parskip's skip=, or \\parskip); ''" },
      indent: { type: 'dimen', default: '', description: "the first-line indent (parskip's indent=, or \\parindent); ''" },
      indentStep: { type: 'dimen', default: '1.5em', description: "one step of the node's indent (\\hspace*)" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'parskip', when: { separation: 'parskip' } },
    ],
    zerotex: 'untested',
  }),
);
