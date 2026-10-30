import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * Astronomy & Astrophysics' class: \abstract{} as a command, a dozen theorem environments predefined, \newtheorem with two more arguments, no chapter, and \part and \subparagraph errors.
 * Read from its requirement document and source, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.aa',
  name: "aa",
  zerotex: 'untested',
  preloads: [{"pkg": "calc"}, {"pkg": "etex"}, {"pkg": "fontenc"}, {"pkg": "inputenc"}, {"pkg": "geometry"}, {"pkg": "setspace"}, {"pkg": "fancyhdr"}, {"pkg": "cuted"}, {"pkg": "amsmath"}, {"pkg": "amssymb"}, {"pkg": "url"}, {"pkg": "enumerate"}, {"pkg": "longtable"}, {"pkg": "natbib"}, {"pkg": "xspace"}, {"pkg": "babel"}, {"pkg": "rotating"}, {"pkg": "linenoaa"}],
  defines: ["counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "cmd:\\abstract", "env:proof", "env:theorem", "env:corollary", "env:definition", "env:example", "env:exercise", "env:lemma", "env:note", "env:problem", "env:proposition", "env:question", "env:remark", "env:solution", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [{ kind: 'requirement', file: 'Template/template-requirement/AandA.md', line: '63' }, { kind: 'requirement', file: 'Template/template-requirement/AandA.md', line: '82' }, { kind: 'requirement', file: 'Template/template-requirement/AandA.md', line: '83' }, { kind: 'requirement', file: 'Template/template-requirement/AandA.md', line: '84' }, { kind: 'requirement', file: 'Template/template-requirement/AandA.md', line: '113' }, { kind: 'requirement', file: 'Template/template-requirement/AandA.md', line: '132' }],
});
