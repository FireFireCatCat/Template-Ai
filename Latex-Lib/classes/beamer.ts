import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * beamer: slides in frames; sections print nothing on a slide; floats are placed where they start; its own theorem blocks.
 * Read from its requirement document and its source, not yet measured by the
 * class probe (its preloads, names and refused packages are the documents').
 */
export default defineClass({
  id: 'class.beamer',
  name: "beamer",
  zerotex: 'untested',
  preloads: [{"pkg": "amsmath"}, {"pkg": "amsthm"}, {"pkg": "amssymb"}, {"pkg": "xcolor"}, {"pkg": "enumerate"}],
  defines: ["counter:part", "counter:section", "counter:subsection", "counter:subsubsection", "env:theorem", "env:corollary", "env:fact", "env:lemma", "env:problem", "env:solution", "env:definition", "env:example", "env:abstract", "cmd:\\note", "env:figure", "env:table", "env:thebibliography", "cmd:\\maketitle", "cmd:\\tableofcontents", "cmd:\\appendix"],
  options: {"notheorems": {"removes": ["env:theorem", "env:corollary", "env:fact", "env:lemma", "env:problem", "env:solution", "env:definition", "env:example"], "description": "the class predefines none of its theorem blocks"}},
  forbids: {
    technical: [],
    policy: [{ pkg: "geometry", reason: "beamer: \"you should refrain from changing the paper size\", set by the aspectratio option", evidence: [{ kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '30' }] }],
  },
  layout: null,
  vocabulary: {"\\frametitle": "a frame's title", "\\institute": "affiliations", "\\titlepage": "the title page inside a frame"},
  evidence: [{ kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '34' }, { kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '53' }, { kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '57' }, { kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '65' }, { kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '77' }, { kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '80' }, { kind: 'requirement', file: 'Template/template-requirement/Beamer.md', line: '85' }, ctan('beamer')],
});
