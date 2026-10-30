import { defineClass } from '../schema/class.ts';
import { ctan } from '../schema/minimal.ts';

/**
 * tikzposter: a poster of \block{title}{content} in columns, drawn with TikZ; \maketitle draws the title box; content sits in macro arguments, so no floats and no verbatim.
 * Read from the research's Solution files and CTAN, not yet measured by the class probe.
 */
export default defineClass({
  id: 'class.tikzposter',
  name: "tikzposter",
  zerotex: 'untested',
  preloads: [{"pkg": "tikz"}],
  defines: ["cmd:\\maketitle", "env:thebibliography"],
  options: {},
  forbids: {
    technical: [],
    policy: [],
  },
  layout: null,
  vocabulary: {"\\block": "a titled block", "\\column": "a column of blocks", "\\usetheme": "the poster theme"},
  evidence: [{ kind: 'solution', file: 'Solution/0436-jacobs-landscape-poster.md', lines: 'class' }, { kind: 'solution', file: 'Solution/0707-tu-delft-poster.md', lines: 'class' }, ctan('tikzposter')],
});
