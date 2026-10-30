import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'tbl.multirow',
    node: 'table_cell',
    description:
      "A table cell: its text (blank lines as \\par), \\cellcolor for a background (colortbl), \\multirow{n}{=}{…} for a row span (multirow; * for natural width), then Flouest's cell separator.",
    ctan: ['multirow', 'colortbl'],
    features: ['cell-spans', 'background'],
    params: {
      width: { type: 'enum', values: ['=', '*'], default: '=', description: "a row span's width: the column's (=, text wraps) or natural (*)" },
    },
    presets: PRESETS,
    loads: [
      { pkg: 'multirow' },
      { pkg: 'xcolor' },
      { pkg: 'colortbl' },
    ],
    zerotex: 'untested',
  }),
);
