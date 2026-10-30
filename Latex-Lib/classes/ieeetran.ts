import { defineClass } from '../schema/class.ts';

/**
 * IEEEtran, as the class probe measured it (ieeetran-journal.A: loads, preloads,
 * names it already defines, refused packages, layout), with what its
 * requirement document says it defines and forbids.
 */
export default defineClass({
  id: 'class.ieeetran',
  name: "IEEEtran",
  zerotex: "yes",
  preloads: [],
  defines: ["counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: { columns: 2, textwidth: "516.0pt", fontsize: "10pt" },
  vocabulary: {},
  evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/ieeetran-journal.A.json' }, { kind: 'requirement', file: 'Template/template-requirement/IEEEtran_Journal.md', line: '100' }, { kind: 'requirement', file: 'Template/template-requirement/IEEEtran_Journal.md', line: '102' }],
});
