import { defineKey } from '../../../schema/key.ts';
import { minimal } from '../../../schema/minimal.ts';
import { NUMBERING } from '../node.ts';
import { PRESETS } from './presets.ts';

export default defineKey(
  minimal({
    id: 'head.memoir-style',
    node: 'paragraph/heading',
    description:
      "memoir's own heading interface: \\chapterstyle{…} for chapter openings (default, section, hangnum, ell, veelo, madsen, pedersen, demo3, bianchi …), \\setsecheadstyle and its siblings with \\setbeforesecskip and \\setaftersecskip for the lower levels, \\chaptitlefont and \\parttitlefont for the top ones, \\hangsecnum, \\setsecnumdepth. memoir only. 15 templates.",
    ctan: ['memoir'],
    features: ['chapter-opening', 'ruled', 'flush-right', 'colored', 'sans-serif', 'bold-head', 'italic-head', 'hang-head', 'compact-spacing', 'numbered'],
    params: {
      chapterStyle: { type: 'enum', values: ['class', 'default', 'section', 'hangnum', 'companion', 'article', 'bianchi', 'bringhurst', 'crosshead', 'dash', 'demo2', 'demo3', 'ell', 'komalike', 'madsen', 'pedersen', 'tandh', 'thatcher', 'veelo', 'wilsondob'], default: 'class', description: "memoir's chapter style (\\chapterstyle); class leaves the one memoir starts with" },
      font: { type: 'tex', default: '', description: 'family, series and shape of the level (with its size by the scale)' },
      scale: { type: 'enum', values: ['class', 'kernel', 'larger', 'smaller', 'text'], default: 'class', description: "each level's size: kernel the standard classes', larger or smaller one step, text the text size (chapters and parts stay large); class leaves the class's sizes" },
      color: { type: 'color', default: '', description: "an xcolor colour for the heading, or '' for none" },
      hangNumbers: { type: 'boolean', default: false, description: 'section numbers hang in the margin (\\hangsecnum)' },
      beforeSkip: { type: 'string', default: '', description: "space before the level's heads (\\setbeforesecskip, \\beforechapskip); '' keeps memoir's" },
      afterSkip: { type: 'string', default: '', description: "space after the level's heads (\\setaftersecskip, \\afterchapskip); '' keeps memoir's" },
      ...NUMBERING,
    },
    presets: PRESETS,
    loads: [
      { pkg: 'xcolor' },
    ],
    requires: [
      'counter:{kind}',
    ],
    only: ['class.memoir'],
    zerotex: 'untested',
  }),
);
