import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'abs.class-native',
    node: 'containerBlock/abstract',
    description:
      "The class's own abstract, unstyled: \\begin{abstract} … \\end{abstract} as acmart, IEEEtran or elsarticle print it, or \\abstract{…} in the preamble where the class makes it a command that \\maketitle prints (sn-jnl, mdpi, aa). 140 templates.",
    ctan: ['latex-base'],
    features: ['class-styled'],
    params: {
      form: { type: 'enum', values: ['environment', 'command'], default: 'environment', description: "the class's environment, or its \\abstract{} command" },
    },
    presets: PRESETS,
    zerotex: 'untested',
  }),
);
