import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * IOP Publishing's journal class: article underneath, no chapter, an abstract with a fixed heading.
 * Read from its requirement document and source, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.iopjournal',
  name: "iopjournal",
  base: 'class.article',
  zerotex: 'untested',
  preloads: [],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [{ kind: 'requirement', file: 'Template/template-requirement/IOP_Journals.md', line: '35' }, { kind: 'requirement', file: 'Template/template-requirement/IOP_Journals.md', line: '41' }, { kind: 'requirement', file: 'Template/template-requirement/IOP_Journals.md', line: '42' }],
});
