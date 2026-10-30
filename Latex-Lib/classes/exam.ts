import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * exam: article with questions, parts and choices; \part is a question's part, not a heading.
 * Read from the research's Solution files and CTAN, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.exam',
  name: "exam",
  base: 'class.article',
  zerotex: 'untested',
  preloads: [],
  defines: ["counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:questions", "env:parts", "env:choices", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [{ kind: 'solution', file: 'Solution/0355-sexam.md', lines: 'class' }, ctan('exam')],
});
