import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'note.todonotes',
    node: 'containerBlock/note',
    description:
      'todonotes: \\todo[keys]{…}, a coloured note in the margin joined to its place by a line; color, linecolor, bordercolor, textcolor, size, line, noline, fancyline, inline, shadow per note; colorinlistoftodos and disable as package options. Uses TikZ. 17 templates.',
    ctan: ['todonotes'],
    features: ['margin-note', 'connector-line', 'background', 'colored', 'shadow', 'small-type'],
    params: {
      color: { type: 'color', default: '', description: "the note's fill (color=); '' keeps todonotes' orange, none for no fill" },
      lineColor: { type: 'color', default: '', description: "the connecting line's colour (linecolor=); ''" },
      borderColor: { type: 'color', default: '', description: "the border's colour (bordercolor=); '', none for no border" },
      textColor: { type: 'color', default: '', description: "the text colour (textcolor=); ''" },
      size: { type: 'tex', default: '', description: "the text size (size=\\tiny); '' keeps the package's" },
      line: { type: 'enum', values: ['line', 'noline', 'fancyline'], default: 'line', description: 'the connecting line: straight, none, or curved' },
      inline: { type: 'boolean', default: false, description: 'the note in the text instead of the margin (inline)' },
      shadow: { type: 'boolean', default: false, description: 'a drop shadow (shadow)' },
      colorInList: { type: 'boolean', default: false, description: "each entry's square in \\listoftodos in the note's colour (colorinlistoftodos)" },
      disable: { type: 'boolean', default: false, description: 'every note hidden (disable), for the final version' },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'todonotes' },
      { pkg: 'todonotes', options: ['colorinlistoftodos'], when: { colorInList: true } },
      { pkg: 'todonotes', options: ['disable'], when: { disable: true } },
    ],
    defines: [
      'cmd:\\todo',
    ],
    zerotex: 'untested',
  }),
);
