import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * The EasyChair class: article underneath (report with the thesis option), listings, amsthm and empheq loaded.
 * Read from its requirement document and source, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.easychair',
  name: "easychair",
  base: 'class.article',
  zerotex: 'untested',
  preloads: [{"pkg": "listings"}, {"pkg": "amsthm"}, {"pkg": "empheq"}],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:proof", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {"thesis": {"adds": ["counter:chapter"], "description": "the class loads report instead of article, so chapters exist"}},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [{ kind: 'requirement', file: 'Template/template-requirement/EasyChair.md', line: '20' }, { kind: 'requirement', file: 'Template/template-requirement/EasyChair.md', line: '23' }, { kind: 'requirement', file: 'Template/template-requirement/EasyChair.md', line: '35' }],
});
