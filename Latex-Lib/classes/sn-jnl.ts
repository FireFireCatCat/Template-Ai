import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * Springer Nature's journal class: article underneath, no chapter, \abstract{} as a command, amsthm with four styles and no theorem environments, tables in threeparttable.
 * Read from its requirement document and source, not yet measured by the class probe.
 * Each bibliography option loads natbib (or apacite); with none, neither is loaded (line 37). Some Springer journals ask that files compile with pdfLaTeX (line 39).
 */
export default defineClass({
  id: 'class.sn-jnl',
  name: "sn-jnl",
  base: 'class.article',
  zerotex: 'untested',
  preloads: [{"pkg": "amsthm"}, {"pkg": "rotating"}, {"pkg": "threeparttable"}],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "cmd:\\abstract", "env:proof", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [{ kind: 'requirement', file: 'Template/template-requirement/Springer_Nature_SN_Jnl.md', line: '37' }, { kind: 'requirement', file: 'Template/template-requirement/Springer_Nature_SN_Jnl.md', line: '39' }, { kind: 'requirement', file: 'Template/template-requirement/Springer_Nature_SN_Jnl.md', line: '53' }, { kind: 'requirement', file: 'Template/template-requirement/Springer_Nature_SN_Jnl.md', line: '60' }, { kind: 'requirement', file: 'Template/template-requirement/Springer_Nature_SN_Jnl.md', line: '75' }, { kind: 'requirement', file: 'Template/template-requirement/Springer_Nature_SN_Jnl.md', line: '91' }],
});
