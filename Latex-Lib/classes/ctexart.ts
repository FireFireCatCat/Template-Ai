import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * ctex's article: the standard article with Chinese typesetting (ctex: fonts, spacing, \ctexset).
 * Read from its requirement document and source, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.ctexart',
  name: "ctexart",
  base: 'class.article',
  zerotex: 'untested',
  preloads: [{"pkg": "ctex"}],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [ctan('ctex')],
});
