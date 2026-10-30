import { defineClass } from '../schema/class.ts';

/**
 * amsart, as the class probe measured it (amsart.A: loads, preloads,
 * names it already defines, refused packages, layout), with what its
 * requirement document says it defines and forbids.
 */
export default defineClass({
  id: 'class.amsart',
  name: "amsart",
  zerotex: "yes",
  preloads: [{"pkg": "amsmath"}, {"pkg": "amsthm"}],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: { columns: 1, textwidth: "360.0pt", fontsize: "10pt" },
  vocabulary: {},
  evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/amsart.A.json' }, { kind: 'requirement', file: 'Template/template-requirement/AMS_Amsart.md', line: '68' }, { kind: 'requirement', file: 'Template/template-requirement/AMS_Amsart.md', line: '125' }],
});
