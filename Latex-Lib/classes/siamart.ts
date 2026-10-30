import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * SIAM's article class: amsmath, ntheorem and hyperref loaded; theorem, lemma, corollary, proposition, definition and proof predefined, and declaring them again errors.
 * Read from its requirement document and source, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.siamart',
  name: "siamart251216",
  zerotex: 'untested',
  preloads: [{"pkg": "amsmath"}, {"pkg": "ntheorem"}, {"pkg": "xr-hyper"}, {"pkg": "ifpdf"}, {"pkg": "hyperref"}, {"pkg": "graphicx"}, {"pkg": "epstopdf"}],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:theorem", "env:lemma", "env:corollary", "env:proposition", "env:definition", "env:proof", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {},
  evidence: [{ kind: 'requirement', file: 'Template/template-requirement/SIAM_Siamart.md', line: '52' }, { kind: 'requirement', file: 'Template/template-requirement/SIAM_Siamart.md', line: '100' }, { kind: 'requirement', file: 'Template/template-requirement/SIAM_Siamart.md', line: '114' }, { kind: 'requirement', file: 'Template/template-requirement/SIAM_Siamart.md', line: '123' }],
});
