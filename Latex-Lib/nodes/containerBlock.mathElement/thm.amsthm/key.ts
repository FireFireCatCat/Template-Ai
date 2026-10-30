import { defineKey } from '../../../schema/key.ts';
import { NUMBERING, STATEMENT_DEFINES } from '../statement.ts';
import { PRESETS } from './presets.ts';

const solution = (file: string, lines: string) => ({ kind: 'solution', file: `Solution/${file}.md`, lines }) as const;
const profile = (setting: string) => ({ kind: 'compile', cell: `testing-pipeline/out/profiles/${setting}.json` }) as const;

export default defineKey({
  id: 'thm.amsthm',
  node: 'containerBlock/mathElement',
  description:
    "amsthm: each kind declared with \\newtheorem under a \\theoremstyle (plain, definition, remark) or a style of its own (\\newtheoremstyle). Unboxed statements, a list-based environment, bold head; the proof environment and its QED mark come with it. The way 109 of the research's templates use.",
  features: ['numbered', 'unnumbered', 'numbered-within', 'shared-counter', 'bold-head', 'italic-body', 'upright-body', 'custom-head', 'qed-mark'],
  params: {
    style: { type: 'enum', values: ['ams', 'plain', 'definition', 'custom'], default: 'ams', description: "ams: General's style by kind; plain or definition for every kind; custom: the style below" },
    ...NUMBERING,
    spaceAbove: { type: 'dimen', default: '\\topsep', description: 'custom style: space above' },
    spaceBelow: { type: 'dimen', default: '\\topsep', description: 'custom style: space below' },
    bodyFont: { type: 'tex', default: '\\itshape', description: 'custom style: body font' },
    indent: { type: 'dimen', default: '', description: 'custom style: indent of the head' },
    headFont: { type: 'tex', default: '\\bfseries', description: 'custom style: head font' },
    headColor: { type: 'color', default: '', description: 'custom style: an xcolor colour for the head, or none' },
    headPunct: { type: 'string', default: '.', description: 'custom style: punctuation after the head' },
    headSpace: { type: 'string', default: '.5em', description: "custom style: space after the head, ' ' or \\newline" },
    headSpec: { type: 'tex', default: '', description: "custom style: the head from \\thmname, \\thmnumber, \\thmnote; '' for amsthm's" },
    qedSymbol: { type: 'tex', default: '', description: "the end-of-proof mark; '' keeps amsthm's square" },
  },
  presets: PRESETS,
  zerotex: 'yes',
  loads: [{ pkg: 'amsthm' }, { pkg: 'xcolor', when: { style: 'custom' } }],
  // proof and \\qedsymbol come with the amsthm package (packages/amsthm.ts), so a class that already carries it does not clash.
  defines: [...STATEMENT_DEFINES],
  claims: ['theorem-engine'],
  requires: ['counter:{numberWithin}'],
  classes: {
    deny: [
      {
        class: 'class.llncs',
        reason: 'llncs defines proof and the theorem environments: loading amsthm stops at "Command \\proof already defined"',
        evidence: [profile('llncs.A'), { kind: 'compile', candidate: 'rc2592b799580ae26151f' }],
      },
      {
        class: 'class.acmart',
        reason: 'acmart already defines theorem, lemma, corollary, definition (and loads amsthm itself); declaring them again clashes',
        evidence: [profile('acmart-manuscript.A'), { kind: 'requirement', file: 'Template/template-requirement/ACM.md', line: '85' }],
        unless: { rename: 'yes' },
      },
    ],
  },
  packages: {
    conflicts: [
      {
        pkg: 'ntheorem',
        reason: 'two theorem engines: amsthm cannot go with ntheorem, which siamart loads itself',
        evidence: [{ kind: 'requirement', file: 'Template/template-requirement/SIAM_Siamart.md', line: '52' }],
      },{ way: 'thm.ntheorem', reason: 'two theorem engines: ntheorem and amsthm cannot both be loaded', evidence: [] }],
  },
  context: { gives: {}, needs: { paragraph: true } },
  parents: {},
  fallback: { way: 'thm.kernel' },
  evidence: [
    { kind: 'flouest', file: 'JSON->Latex Compiler/src/Profile/Profile_General/containerBlockShape/mathElement.ts', line: '165-224' },
    solution('0015-malaysian-journal-of-mathematical-scienc', '31'),
  ],
  status: 'draft',
});
