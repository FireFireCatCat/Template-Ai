import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * KOMA-Script's report class: chapters, an abstract, KOMA's fonts and options.
 * Read from its requirement document and its source, not yet measured by the
 * class probe (its preloads, names and refused packages are the documents').
 */
export default defineClass({
  id: 'class.scrreprt',
  name: "scrreprt",
  zerotex: 'untested',
  preloads: [],
  defines: ["counter:chapter", "counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [{ kind: 'requirement', file: 'Template/template-requirement/KOMA_Scrartcl.md', line: '68' }, ctan('koma-script')],
});
