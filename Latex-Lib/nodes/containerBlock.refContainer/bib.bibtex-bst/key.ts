import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'bib.bibtex-bst',
    node: 'containerBlock/refContainer',
    description:
      'BibTeX with a .bst style: \\bibliographystyle{plain} (unsrt, alpha, abbrv, ieeetr, acm, siam, apalike) and \\bibliography{\\jobname}, the entries in \\jobname.bib; the heading through \\refname or \\bibname. 190 templates.',
    ctan: ['bibtex'],
    features: ['numeric-citations', 'author-year', 'external-tool'],
    params: {
      bst: { type: 'enum', values: ['plain', 'unsrt', 'alpha', 'abbrv', 'ieeetr', 'acm', 'siam', 'apalike'], default: 'plain', description: 'the BibTeX style' },
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
