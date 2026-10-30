import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * The LIPIcs proceedings class: article underneath, its own theorem environments and list settings, which must not be overridden; times, enumitem and paralist are forbidden.
 * Read from its requirement document and source, not yet measured by the class probe.
 * Its theorem environments are the class's (line 60); their names here are the usual set and not read from its source.
 */
export default defineClass({
  id: 'class.lipics',
  name: "lipics-v2021",
  base: 'class.article',
  zerotex: 'untested',
  preloads: [],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "counter:paragraph", "counter:subparagraph", "env:abstract", "env:theorem", "env:lemma", "env:corollary", "env:proposition", "env:definition", "env:example", "env:remark", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {},
  forbids: {
    technical: [],
    policy: [{ pkg: "times", reason: "LIPIcs: the checklist forbids times (no change of main font)", evidence: [{ kind: 'requirement', file: 'Template/template-requirement/LIPIcs.md', line: '33' }] }, { pkg: "enumitem", reason: "LIPIcs: the checklist forbids enumitem (keep the class list settings)", evidence: [{ kind: 'requirement', file: 'Template/template-requirement/LIPIcs.md', line: '33' }] }, { pkg: "paralist", reason: "LIPIcs: the checklist forbids paralist", evidence: [{ kind: 'requirement', file: 'Template/template-requirement/LIPIcs.md', line: '33' }] }],
  },
  layout: null,
  vocabulary: {},
  evidence: [{ kind: 'requirement', file: 'Template/template-requirement/LIPIcs.md', line: '33' }, { kind: 'requirement', file: 'Template/template-requirement/LIPIcs.md', line: '49' }, { kind: 'requirement', file: 'Template/template-requirement/LIPIcs.md', line: '54' }, { kind: 'requirement', file: 'Template/template-requirement/LIPIcs.md', line: '60' }, { kind: 'requirement', file: 'Template/template-requirement/LIPIcs.md', line: '73' }],
});
