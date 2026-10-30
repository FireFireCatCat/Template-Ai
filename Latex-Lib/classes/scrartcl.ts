import { defineClass } from '../schema/class.ts';

/**
 * scrartcl, as the class probe measured it (scrartcl.A: loads, preloads,
 * names it already defines, refused packages, layout), with what its
 * requirement document says it defines and forbids.
 */
export default defineClass({
  id: 'class.scrartcl',
  name: "scrartcl",
  zerotex: "yes",
  preloads: [],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: { columns: 1, textwidth: "418.25555pt", fontsize: "10.95pt" },
  vocabulary: {},
  evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/scrartcl.A.json' }, { kind: 'requirement', file: 'Template/template-requirement/KOMA_Scrartcl.md', line: '105' }],
});
