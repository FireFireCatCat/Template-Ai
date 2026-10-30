import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'bib.cite-pkg',
    node: 'containerBlock/refContainer',
    description:
      'The cite package: numbered citations sorted and compressed ([1-3]), nosort to keep their order, super for superscript numbers, with a numbered BibTeX style. 27 templates.',
    ctan: ['cite'],
    features: ['numeric-citations', 'sorted-compressed', 'superscript', 'external-tool'],
    params: {
      sort: { type: 'boolean', default: true, description: 'several citations sorted (nosort when false)' },
      superscript: { type: 'boolean', default: false, description: 'superscript numbers (super)' },
      bst: { type: 'enum', values: ['plain', 'unsrt', 'abbrv', 'ieeetr'], default: 'plain', description: 'the BibTeX style' },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'cite' },
      { pkg: 'cite', options: ['nosort'], when: { sort: false } },
      { pkg: 'cite', options: ['super'], when: { superscript: true } },
    ],
    claims: ['bibliography-engine'],
    requires: [
      'env:thebibliography',
    ],
    zerotex: 'untested',
  }),
);
