import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'bib.apacite',
    node: 'containerBlock/refContainer',
    description:
      "apacite: APA author-year citations and reference list, \\usepackage{apacite} ([natbibapa] for natbib's commands), \\bibliographystyle{apacite}, \\bibliography{\\jobname}. 18 templates.",
    ctan: ['apacite'],
    features: ['author-year', 'external-tool'],
    params: {
      natbib: { type: 'boolean', default: false, compat: true, description: "natbib's citation commands (natbibapa)" },
      heading: { type: 'string', default: '', description: "the list's heading (\\refname, \\bibname); ''" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'apacite', when: { natbib: false } },
      { pkg: 'apacite', options: ['natbibapa'], when: { natbib: true } },
    ],
    claims: ['bibliography-engine'],
    requires: [
      'env:thebibliography',
    ],
    zerotex: 'untested',
  }),
);
