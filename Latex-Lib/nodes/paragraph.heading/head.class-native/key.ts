import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'head.class-native',
    node: 'paragraph/heading',
    description:
      "The class's own heading looks: the kernel commands with nothing restyled and nothing loaded, as acmart, llncs, IEEEtran or a thesis class's \\@startsection want them. 274 templates.",
    ctan: ['latex-base'],
    features: ['class-styled'],
    presets: PRESETS,
    requires: [
      'counter:{kind}',
    ],
    zerotex: 'untested',
  }),
);
