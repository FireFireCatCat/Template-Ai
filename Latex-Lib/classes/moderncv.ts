import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * moderncv: a CV class that does not load article; it defines \section, \subsection, its lists and its bibliography itself, prints the header with \makecvtitle (no \maketitle), and has no floats, abstract or chapters.
 * Read from the research's Solution files and CTAN, not yet measured by the class probe.
 * Its \section takes an icon, not a short title, in brackets (Solution 0196).
 */
export default defineClass({
  id: 'class.moderncv',
  name: "moderncv",
  zerotex: 'untested',
  preloads: [],
  defines: ["counter:section", "counter:subsection", "env:thebibliography"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {"\\cventry": "one CV entry", "\\makecvtitle": "the CV header", "\\moderncvstyle": "the style"},
  evidence: [{ kind: 'solution', file: 'Solution/0196-moderncv.md', lines: 'class' }, { kind: 'solution', file: 'Solution/0410-moderncv-cv-and-cover-letter.md', lines: 'class' }, ctan('moderncv')],
});
