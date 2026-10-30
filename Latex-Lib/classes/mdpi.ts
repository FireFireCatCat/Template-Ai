import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * MDPI's journal class: it loads some thirty packages itself (titlesec, enumitem, tocloft, hyperref, cleveref, natbib…), prints the title block by itself, \abstract{} as a command, capitalised theorem environments.
 * Read from its requirement document and source, not yet measured by the class probe.
 * \maketitle runs by itself after the preamble and is then disabled (line 55), so the profile does not offer it.
 */
export default defineClass({
  id: 'class.mdpi',
  name: "mdpi",
  zerotex: 'untested',
  preloads: [{"pkg": "fontenc"}, {"pkg": "inputenc"}, {"pkg": "graphicx"}, {"pkg": "float"}, {"pkg": "amsmath"}, {"pkg": "amsthm"}, {"pkg": "lineno"}, {"pkg": "setspace"}, {"pkg": "enumitem"}, {"pkg": "booktabs"}, {"pkg": "titlesec"}, {"pkg": "xcolor"}, {"pkg": "colortbl"}, {"pkg": "soul"}, {"pkg": "microtype"}, {"pkg": "tikz"}, {"pkg": "changepage"}, {"pkg": "tabularx"}, {"pkg": "tocloft"}, {"pkg": "marginnote"}, {"pkg": "enotez"}, {"pkg": "subfig"}, {"pkg": "caption"}, {"pkg": "newfloat"}, {"pkg": "natbib"}, {"pkg": "geometry"}, {"pkg": "hyperref"}, {"pkg": "cleveref"}],
  defines: ["counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "cmd:\\abstract", "env:Theorem", "env:Lemma", "env:Corollary", "env:Proposition", "env:Property", "env:Problem", "env:Example", "env:Remark", "env:Definition", "env:Hypothesis", "env:Notation", "env:Assumption", "env:figure", "env:table", "env:thebibliography", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [{ kind: 'requirement', file: 'Template/template-requirement/MDPI.md', line: '55' }, { kind: 'requirement', file: 'Template/template-requirement/MDPI.md', line: '66' }, { kind: 'requirement', file: 'Template/template-requirement/MDPI.md', line: '83' }, { kind: 'requirement', file: 'Template/template-requirement/MDPI.md', line: '127' }, { kind: 'requirement', file: 'Template/template-requirement/MDPI.md', line: '143' }],
});
