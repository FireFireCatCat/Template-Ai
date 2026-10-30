import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'bib.biblatex-biber',
    node: 'containerBlock/refContainer',
    description:
      'biblatex with Biber: \\usepackage[style=…, backend=biber, sorting=…, maxbibnames=…, giveninits, backref]{biblatex}, the entries in \\jobname.bib (filecontents*), \\addbibresource, \\printbibliography[title=…]; Biber runs outside TeX. 110 templates.',
    ctan: ['biblatex', 'biber'],
    features: ['numeric-citations', 'author-year', 'sorted-compressed', 'external-tool'],
    params: {
      style: { type: 'enum', values: ['node', 'numeric', 'numeric-comp', 'authoryear', 'authortitle', 'alphabetic', 'ieee', 'apa'], default: 'node', description: "the citation and list style; node takes the node's data.referenceStyling (numeric by default)" },
      sorting: { type: 'enum', values: ['style', 'nty', 'nyt', 'ynt', 'ydnt', 'none'], default: 'style', description: "the list's order (sorting=); style keeps the style's" },
      maxnames: { type: 'number', default: 0, description: "names listed before et al. (maxbibnames=); 0 keeps the style's" },
      giveninits: { type: 'boolean', default: false, description: 'given names as initials (giveninits=true)' },
      backref: { type: 'boolean', default: false, description: 'pages that cite each entry, after it (backref=true)' },
      heading: { type: 'string', default: '', description: "the list's heading (\\printbibliography[title=…]); ''" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'biblatex', options: ['backend=biber'] },
    ],
    claims: ['bibliography-engine'],
    conflicts: [
      { pkg: 'natbib', reason: 'biblatex refuses natbib', evidence: [] },
    ],
    zerotex: 'untested',
  }),
);
