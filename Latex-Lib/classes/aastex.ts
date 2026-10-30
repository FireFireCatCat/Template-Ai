import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * The AAS journals' class: no chapter, no usable \part or \subparagraph numbers, no theorem environments; it refuses cite, mcite and multicol, and loads hyperref itself.
 * Read from its requirement document and source, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.aastex',
  name: "aastex701",
  zerotex: 'untested',
  preloads: [{"pkg": "hyperref"}],
  defines: ["counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "env:abstract", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [{ pkg: "cite", reason: "the class stops at \\begin{document}: \"The cite package cannot be used with\" it", evidence: [{ kind: 'requirement', file: 'Template/template-requirement/AASTeX.md', line: '38' }] }, { pkg: "mcite", reason: "the class stops at \\begin{document} with mcite", evidence: [{ kind: 'requirement', file: 'Template/template-requirement/AASTeX.md', line: '38' }] }, { pkg: "multicol", reason: "the class stops at \\begin{document} with multicol", evidence: [{ kind: 'requirement', file: 'Template/template-requirement/AASTeX.md', line: '38' }] }],
    policy: [{ pkg: "hyperref", reason: "AAS: \"Please do not import hyperref as a package\"; the class loads it with its own options", evidence: [{ kind: 'requirement', file: 'Template/template-requirement/AASTeX.md', line: '39' }] }],
  },
  layout: null,
  vocabulary: {},
  evidence: [{ kind: 'requirement', file: 'Template/template-requirement/AASTeX.md', line: '38' }, { kind: 'requirement', file: 'Template/template-requirement/AASTeX.md', line: '39' }, { kind: 'requirement', file: 'Template/template-requirement/AASTeX.md', line: '61' }, { kind: 'requirement', file: 'Template/template-requirement/AASTeX.md', line: '78' }, { kind: 'requirement', file: 'Template/template-requirement/AASTeX.md', line: '79' }],
});
