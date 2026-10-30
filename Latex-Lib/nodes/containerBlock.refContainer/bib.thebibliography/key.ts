import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'bib.thebibliography',
    node: 'containerBlock/refContainer',
    description:
      "A hand-written thebibliography: \\begin{thebibliography}{99} with one \\bibitem{key} per entry, read from the entries' BibTeX source; its size, item spacing and heading; no BibTeX run. 95 templates.",
    ctan: ['latex-base'],
    features: ['numeric-citations', 'hand-written', 'small-type', 'compact'],
    params: {
      widest: { type: 'string', default: '99', description: 'the widest label, which sets the label column' },
      font: { type: 'tex', default: '', description: "the list's size (\\small); ''" },
      itemsep: { type: 'dimen', default: '', description: "space between entries (\\itemsep); ''" },
      heading: { type: 'string', default: '', description: "the list's heading (\\refname, \\bibname); ''" },
    },
    presets: PRESETS,
    claims: ['bibliography-engine'],
    requires: [
      'env:thebibliography',
    ],
    zerotex: 'untested',
  }),
);
