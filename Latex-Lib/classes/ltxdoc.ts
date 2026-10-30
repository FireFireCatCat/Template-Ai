import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * The LaTeX project's documentation class: article with the doc package (macrocode, macro and environment environments, \DescribeMacro), for .dtx files.
 * Read from its requirement document and source, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.ltxdoc',
  name: "ltxdoc",
  base: 'class.article',
  zerotex: 'untested',
  preloads: [{"pkg": "doc"}],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:macrocode", "env:macro", "env:environment", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [ctan('ltxdoc'), ctan('doc')],
});
