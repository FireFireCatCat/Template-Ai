import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'bib.natbib',
    node: 'containerBlock/refContainer',
    description:
      'natbib: \\usepackage[numbers]{natbib} (authoryear, super; round or square; sort, sort&compress; comma or semicolon) with an natbib style, \\bibliographystyle{plainnat} (unsrtnat, abbrvnat), \\bibliography{\\jobname}; \\bibsep and \\bibfont for the list. 107 templates.',
    ctan: ['natbib'],
    features: ['numeric-citations', 'author-year', 'sorted-compressed', 'superscript', 'external-tool'],
    params: {
      citeStyle: { type: 'enum', values: ['numbers', 'authoryear', 'super'], default: 'numbers', compat: true, description: 'numbered, author-year, or superscript citations' },
      brackets: { type: 'enum', values: ['style', 'round', 'square'], default: 'style', description: 'round or square brackets' },
      sort: { type: 'enum', values: ['none', 'sort', 'sort&compress'], default: 'none', description: 'several citations sorted, and compressed to ranges' },
      separator: { type: 'enum', values: ['style', 'comma', 'semicolon'], default: 'style', description: 'between several citations' },
      bst: { type: 'enum', values: ['plainnat', 'unsrtnat', 'abbrvnat'], default: 'plainnat', description: 'the natbib BibTeX style' },
      bibsep: { type: 'dimen', default: '', description: "space between entries (\\bibsep); ''" },
      bibFont: { type: 'tex', default: '', description: "the list's font (\\bibfont); ''" },
      heading: { type: 'string', default: '', description: "the list's heading (\\refname, \\bibname); ''" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'natbib', options: ['numbers'], when: { citeStyle: 'numbers' } },
      { pkg: 'natbib', options: ['authoryear'], when: { citeStyle: 'authoryear' } },
      { pkg: 'natbib', options: ['super'], when: { citeStyle: 'super' } },
      { pkg: 'natbib', options: ['round'], when: { brackets: 'round' } },
      { pkg: 'natbib', options: ['square'], when: { brackets: 'square' } },
      { pkg: 'natbib', options: ['sort'], when: { sort: 'sort' } },
      { pkg: 'natbib', options: ['sort&compress'], when: { sort: 'sort&compress' } },
      { pkg: 'natbib', options: ['comma'], when: { separator: 'comma' } },
      { pkg: 'natbib', options: ['semicolon'], when: { separator: 'semicolon' } },
    ],
    claims: ['bibliography-engine'],
    zerotex: 'untested',
  }),
);
