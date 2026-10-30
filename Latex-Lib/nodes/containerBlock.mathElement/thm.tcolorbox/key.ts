import { defineKey } from '../../../schema/key.ts';
import { NUMBERING, STATEMENT_DEFINES } from '../statement.ts';
import { PRESETS } from './presets.ts';

const solution = (file: string, lines: string) => ({ kind: 'solution', file: `Solution/${file}.md`, lines }) as const;
const profile = (setting: string) => ({ kind: 'compile', cell: `testing-pipeline/out/profiles/${setting}.json` }) as const;
const confined = {
  kind: 'flouest',
  file: 'JSON->Latex Compiler/src/Profile/Profile_General/containerBlockShape/mathElement.ts',
  line: '279-290',
} as const;
const unbreakable = { way: '*', set: { breakable: false }, reason: 'a confined parent: a box there cannot use the page-breaking machinery', evidence: [confined] } as const;

export default defineKey({
  id: 'thm.tcolorbox',
  node: 'containerBlock/mathElement',
  description:
    "tcolorbox's theorems library: \\newtcbtheorem per kind, a box with its own colours, rule, corners and title, the header note as its title. Breaks across pages when breakable, which needs the box's place to break.",
  features: ['framed', 'background', 'title-bar', 'colored', 'rounded-corners', 'breakable', 'numbered', 'numbered-within', 'shared-counter'],
  params: {
    colback: { type: 'color', default: 'blue!5', description: 'body background' },
    colframe: { type: 'color', default: 'blue!55!black', description: 'frame and title background' },
    coltitle: { type: 'color', default: 'white', description: 'title text' },
    colbacktitle: { type: 'color', default: '', description: "title bar background; '' for the frame colour" },
    fonttitle: { type: 'tex', default: '\\bfseries', description: 'title font' },
    boxrule: { type: 'dimen', default: '0.8pt', description: 'frame rule' },
    arc: { type: 'dimen', default: '4pt', description: 'corner radius' },
    sharp: { type: 'boolean', default: false, description: 'sharp corners' },
    extra: { type: 'tex', default: '', description: 'further tcolorbox keys (padding, title rules)' },
    breakable: { type: 'boolean', default: true, compat: true, description: 'the box breaks across pages' },
    ...NUMBERING,
  },
  presets: PRESETS,
  zerotex: 'yes',
  loads: [
    { pkg: 'tcolorbox', libraries: ['theorems', 'skins'] },
    { pkg: 'tcolorbox', libraries: ['breakable'], when: { breakable: true } },
  ],
  defines: [...STATEMENT_DEFINES],
  claims: [],
  requires: ['counter:{numberWithin}'],
  classes: {
    deny: [
      {
        class: 'class.llncs',
        reason: 'llncs already defines theorem, lemma, corollary, definition, remark; and LNCS numbers statements consecutively, never within the section ("Theorem 1", not "1.1")',
        evidence: [profile('llncs.A'), { kind: 'requirement', file: 'Template/template-requirement/Springer_LNCS.md', line: '79' }],
        unless: { rename: 'yes', numberWithin: 'none' },
      },
      { class: 'class.acmart', reason: 'acmart already defines theorem, lemma, corollary, definition', evidence: [profile('acmart-manuscript.A')], unless: { rename: 'yes' } },
    ],
  },
  packages: { conflicts: [] },
  context: { gives: { floats: false, boxDepth: 1 }, givesWhen: [{ when: { breakable: false }, gives: { breakable: false } }], needs: {} },
  parents: {
    'containerBlock/footnote': { scope: 'direct', adapt: [unbreakable] },
    'containerBlock/listing': { scope: 'direct', adapt: [unbreakable] },
    table_cell: { scope: 'direct', adapt: [unbreakable] },
    table_header: { scope: 'direct', adapt: [unbreakable] },
  },
  fallback: { way: 'thm.amsthm' },
  evidence: [solution('0728-kcajc-math-notes-template', '37'), solution('0580-federicobruzzone-scribe', '69'), confined],
  status: 'draft',
});
