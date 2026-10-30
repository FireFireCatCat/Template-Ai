import { defineClass } from '../schema/class.ts';

/**
 * llncs, as the class probe measured it (llncs.A: loads, preloads,
 * names it already defines, refused packages, layout), with what its
 * requirement document says it defines and forbids.
 */
export default defineClass({
  id: 'class.llncs',
  name: "llncs",
  zerotex: "yes",
  preloads: [{"pkg": "multicol"}],
  defines: ["counter:chapter", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:theorem", "env:lemma", "env:corollary", "env:definition", "env:proposition", "env:remark", "env:example", "env:property", "env:note", "env:conjecture", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [{ pkg: "titlesec", reason: "its load test stops: Argument of \\subparagraph has an extra }.", evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/llncs.A.json' }] }, { pkg: "amsthm", reason: "its load test stops: LaTeX Error: Command \\proof already defined. Or name \\end... illegal, see p.192 of the manual.", evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/llncs.A.json' }] }],
    policy: [],
  },
  layout: { columns: 1, textwidth: "347.12354pt", fontsize: "10pt" },
  vocabulary: {"\\institute": "affiliations", "\\keywords": "keywords", "\\orcidID": "an author's ORCID"},
  evidence: [{ kind: 'compile', cell: 'testing-pipeline/out/profiles/llncs.A.json' }, { kind: 'requirement', file: 'Template/template-requirement/Springer_LNCS.md', line: '81' }, { kind: 'requirement', file: 'Template/template-requirement/Springer_LNCS.md', line: '79' }],
});
