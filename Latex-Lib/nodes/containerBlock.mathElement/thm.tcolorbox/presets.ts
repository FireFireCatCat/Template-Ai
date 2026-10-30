/**
 * thm.tcolorbox's presets, each from the templates (or the Flouest handler) that use it.
 */
import type { Preset } from '../../../schema/params.ts';

const solution = (file: string, lines: string) => ({ kind: 'solution', file: `Solution/${file}.md`, lines }) as const;

export const PRESETS = {
  boxed: {
    description: "General's coloured statement: a light blue box with a darker frame, 0.8pt rule, 4pt rounded corners, 6pt padding, breaking across pages.",
    features: ['framed', 'background', 'colored', 'rounded-corners', 'breakable', 'numbered', 'numbered-within', 'shared-counter'],
    params: { colback: 'blue!5', colframe: 'blue!55!black', boxrule: '0.8pt', arc: '4pt', extra: 'left=6pt,right=6pt,top=6pt,bottom=6pt', breakable: true },
    evidence: [{ kind: 'flouest', file: 'JSON->Latex Compiler/src/Profile/Profile_General/containerBlockShape/mathElement.ts', line: '268-277' }, solution('0580-federicobruzzone-scribe', '69')],
  },
  sharp: {
    description: "kaobook's framed statements: a yellow background with no rule and sharp corners, tight padding, breaking across pages (kaobook's Goldenrod!45!white needs xcolor's dvipsnames; yellow!35!white is the nearest without it).",
    features: ['background', 'colored', 'breakable', 'numbered', 'numbered-within', 'shared-counter'],
    params: { colback: 'yellow!35!white', colframe: 'yellow!35!white', boxrule: '0pt', arc: '0pt', sharp: true, extra: 'top=5pt,bottom=3pt,left=2pt,right=2pt', breakable: true },
    evidence: [solution('0068-kaobook', '110')],
  },
  titled: {
    description: 'A title bar: no frame, a large bold title on a tinted bar over a lighter body.',
    features: ['title-bar', 'background', 'colored', 'numbered', 'numbered-within', 'shared-counter'],
    params: {
      colback: 'green!5!white',
      colframe: 'green!25!white',
      coltitle: 'black',
      colbacktitle: 'green!25!white',
      fonttitle: '\\bfseries\\large',
      boxrule: '0pt',
      arc: '0pt',
      extra: 'titlerule=0mm,toptitle=1mm,bottomtitle=1mm',
      breakable: false,
    },
    evidence: [solution('0728-kcajc-math-notes-template', '37')],
  },
} as const satisfies { readonly [name: string]: Preset };
