import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'box.awesomebox',
    node: 'containerBlock/note',
    description:
      "awesomebox: an admonition block with a FontAwesome icon and a rule at its side; noteblock, tipblock or warningblock by the note's tone, cautionblock, importantblock, or an awesomeblock of its own (icon, colours, rule width, a title over a short or long line). Needs fontawesome5. 2 templates.",
    ctan: ['awesomebox'],
    features: ['icon', 'left-rule', 'colored', 'title-bar'],
    params: {
      block: { type: 'enum', values: ['tone', 'note', 'tip', 'warning', 'caution', 'important', 'custom'], default: 'tone', description: "the block: chosen by the note's tone, a named one, or custom (awesomeblock)" },
      icon: { type: 'tex', default: '\\faInfoCircle', description: 'custom: the FontAwesome 5 icon' },
      iconColor: { type: 'color', default: 'black', description: "custom: the icon's colour; an xcolor colour; 'tone' stands for the note's tone colour (info blue, tip green, warning amber), also inside an expression (tone!10!white)" },
      ruleColor: { type: 'color', default: 'black', description: "custom: the side rule's colour; an xcolor colour; 'tone' stands for the note's tone colour (info blue, tip green, warning amber), also inside an expression (tone!10!white)" },
      ruleWidth: { type: 'dimen', default: '2pt', description: "custom: the side rule's width" },
      hrule: { type: 'enum', values: ['none', 'short', 'long'], default: 'none', description: 'custom: a line under the title (\\abShortLine, \\abLongLine)' },
      leftMargin: { type: 'string', default: '', description: "the icon column's width (\\aweboxleftmargin; the content takes the rest); ''" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'awesomebox' },
      { pkg: 'xcolor' },
    ],
    gives: { floats: false, boxDepth: 1 },
    zerotex: 'untested',
  }),
);
