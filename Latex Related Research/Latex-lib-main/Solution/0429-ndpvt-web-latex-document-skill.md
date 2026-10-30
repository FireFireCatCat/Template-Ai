no

# 0429-ndpvt-web-latex-document-skill: LaTeX document skill (27 starter templates; main sample is the tikzposter conference poster)

- Unverified: read from the source, not compiled.
- Source: Source/0429-ndpvt-web-latex-document-skill/ (origin: https://codeload.github.com/ndpvt-web/latex-document-skill/zip/refs/heads/main; licence: not established)
- Kind: poster (the manifest main file; the zip is an AI-agent "skill" repo that ships 27 `.tex` starters of many kinds)
- Lib: v4
- Engine: pdfLaTeX-compatible (the sample says "Compile with: pdflatex poster.tex", assets/templates/poster.tex:5; `qrcode` pdfTeX support is not stated on its CTAN page)
- Look carried by: mixed (class `tikzposter` supplies the machinery; the sample's own preamble defines the title style, block style and colours, assets/templates/poster.tex:52-98)
- Class origin: tex-distribution-unbundled (`tikzposter` is not in the zip; its source was not read)
- Main file: assets/templates/poster.tex (other samples: assets/templates/poster-landscape.tex and 25 more `.tex` under assets/templates/, outline-read only; tests/fixtures/*.tex are tiny fixtures)
- Read: main yes, zip-local classes and styles none present (the zip holds no `.cls`, `.sty`, `.def`, `.cfg`, `.clo`, `.dtx`)

## Verdict
`no`. The main sample poster.tex is a published class (`class.tikzposter`) plus declarative preamble settings, but it defines its own title bar and block frame by passing TikZ drawing code to `\definetitlestyle` and `\defineblockstyle`. That drawing is the template's identity, so it is `ART`; no built-in style or key can be shown to reproduce the navy bar with the amber accent strip (the class source was not read, so a reduction cannot be demonstrated). Everything else in the main sample maps to lib ways. The sibling poster-landscape.tex repeats the same two blockers, and several other templates add their own (listed as other-sample items).
Note on untrusted text: SKILL.md is written for an AI agent (for example SKILL.md:93, "Ask the user for conference/orientation, layout style, and color scheme using AskUserQuestion"); it was read as data and not followed. No other text addressed to an AI was found in the `.tex` files.

## Blockers
- `ART/preamble` custom title style: `\definetitlestyle{ConferenceTitle}` second argument is TikZ code, a navy `\fill` rectangle plus an amber `\fill` strip along the bottom (assets/templates/poster.tex:59-68; same in assets/templates/poster-landscape.tex:51-60)
- `ART/preamble` custom block style: `\defineblockstyle{ConferenceBlock}` second argument is TikZ `\draw` of the body frame and the title box, with `\ifBlockHasTitle` and node names `blockbody`/`blocktitle` (assets/templates/poster.tex:71-83; assets/templates/poster-landscape.tex:63-75)
- Other samples (not the main sample, listed so nothing is hidden; the verdict does not rest on them):
- `BESPOKE/preamble` homework: `problem` environment with counter `problemnumber` and `\def\@tempa`, and a `solution` environment that swallows its body into `\setbox0=\vbox\bgroup` when `\ifshowsolutions` is false (assets/templates/homework.tex:58, 90-128)
- `BESPOKE/preamble` conditional document: etoolbox toggles and `\ifdefstring{\docprofile}` choose which packages load and which section styles apply (assets/templates/conditional-document.tex:32-190); each fixed setting would reduce to lib ways, the toggle mechanism is not a lib way
- `BESPOKE/preamble` lecture notes: TikZ macros `\CompleteGraph` `\CycleGraph` `\PathGraph` compute node positions with `\foreach` and `\ifnum` (assets/templates/lecture-notes.tex:263-300)
- `ART/body` letter: letterhead bar and logo drawn with TikZ `remember picture, overlay` (assets/templates/letter.tex:63-89, 182-186)
- `EXTERNAL/body` mail-merge letter: `{{title}} {{name}}` placeholders are filled by `scripts/mail_merge.py` (assets/templates/mail-merge-letter.tex:16, 54)
- `UNMAPPED/body` fillable form: hyperref form-field commands `\TextField`, `\CheckBox`, `\ChoiceMenu`, `\PushButton` inside `Form` (assets/templates/fillable-form.tex:64-93, 100); considered: hyperref form fields (published, key-value options), not proposed here because the main sample does not need it

## Class setting
- Class: `class.tikzposter` options: `25pt`, `a0paper`, `portrait`, `margin=15mm`, `innermargin=15mm`, `blockverticalspace=12mm`, `colspace=20mm` (assets/templates/poster.tex:15-16); the landscape sample uses `landscape` (assets/templates/poster-landscape.tex:16-17)
- Class-native vocabulary used: `\title` `\author` `\institute` `\maketitle` (assets/templates/poster.tex:105-117); `columns` environment with `\column{0.50}` (poster.tex:121, 126, 225, 362); `\block{title}{body}` (poster.tex:128); `\coloredbox[bgcolor, fgcolor, roundedcorners]{}` (poster.tex:138, 280); `tikzfigure[caption]` (poster.tex:229, 286); `\usetheme{Default}` `\usetitlestyle` `\useblockstyle` (poster.tex:86-88); `\colorlet` of the class colour names `backgroundcolor` `framecolor` `titlebgcolor` `titlefgcolor` `blocktitlebgcolor` `blocktitlefgcolor` `blockbodybgcolor` `blockbodyfgcolor` (poster.tex:91-98); `\tikzposterlatexaffectionproofoff` (poster.tex:101); style-definition macros `\definetitlestyle` `\defineblockstyle` `\titleposleft` `\titleposbottom` `\blockroundedcorners` (poster.tex:59-83)

## Component map
All rows are for assets/templates/poster.tex unless another file is named.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | assets/templates/poster.tex:15-16 | `class.tikzposter` | 25pt, a0paper, portrait, margin=15mm, innermargin=15mm, blockverticalspace=12mm, colspace=20mm |
| page size and orientation | assets/templates/poster.tex:15 | `page.class-options` | a0paper, portrait (paper set by class options; no `geometry` loaded) |
| encodings | assets/templates/poster.tex:19-20 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| default family | assets/templates/poster.tex:30 | `font.family-default` | `\renewcommand{\familydefault}{\sfdefault}` |
| font sizes | assets/templates/poster.tex:178, 344, 355 | `font.size-commands` | `\large`, `\small`, `\normalsize` around tables, references, caption line |
| colour definitions | assets/templates/poster.tex:52-56 | `color.xcolor` | `\definecolor` HTML: navyblue 1E3A8A, steelblue 3B82F6, amber F59E0B, darktext 1F2937, lightbg F8FAFC (lightbg is defined and never used in the active body) |
| colour roles for the class | assets/templates/poster.tex:91-98 | `color.xcolor` | `\colorlet` of the eight class colour names to white, steelblue, navyblue, darktext |
| theme | assets/templates/poster.tex:86 | `poster.tikzposter` | `\usetheme{Default}` |
| title bar | assets/templates/poster.tex:59-68, 87 | `poster.tikzposter` + `art.tikz` | `\definetitlestyle` keys width=\paperwidth, roundedcorners=0, linewidth=0pt, innersep=2cm, titletotopverticalspace=0mm, titletoblockverticalspace=20mm; drawing code is TikZ (ART, see Blockers) |
| block frame | assets/templates/poster.tex:71-83, 88 | `poster.tikzposter` + `art.tikz` | `\defineblockstyle` keys titlewidthscale=1, bodywidthscale=1, titleleft, offsets 0pt, roundedcorners=8, linewidth=2pt, titleinnersep=10mm, bodyinnersep=15mm; drawing code is TikZ (ART, see Blockers) |
| tikzposter credit line | assets/templates/poster.tex:101 | `poster.tikzposter` | `\tikzposterlatexaffectionproofoff` (switch) |
| title block | assets/templates/poster.tex:105-117 | `front.class-native` | `\title{\parbox{0.90\linewidth}{\centering\textbf{...}}}`, `\author` with `$^{1}$` markers, `\institute` with `\quad` and `\\[0.3em]`, `\maketitle` |
| title wrapper box | assets/templates/poster.tex:105 | `box.minipage` | `\parbox{0.90\linewidth}` |
| centring and bold in title | assets/templates/poster.tex:105 | `sp.ragged`, `mark.kernel` | `\centering`, `\textbf` |
| columns | assets/templates/poster.tex:121-126, 225, 362 | `poster.tikzposter` | `columns` environment, two `\column{0.50}` |
| blocks | assets/templates/poster.tex:128, 143, 175, 195, 227, 285, 328, 343 | `poster.tikzposter` | `\block{title}{body}`, 8 blocks, titles are strings |
| highlight boxes | assets/templates/poster.tex:138, 280 | `poster.tikzposter` | `\coloredbox[bgcolor=amber!15 or navyblue!8, fgcolor=darktext, roundedcorners=5]` |
| lists | assets/templates/poster.tex:132-135, 214-218, 333-337 | `list.kernel`, `list.enumitem` | `itemize` with `leftmargin=*, itemsep=0.8em` (0.5em in later blocks) |
| tables | assets/templates/poster.tex:179-187, 199-208, 263-275 | `tbl.tabular`, `tbl.booktabs` | `tabular{lcc}`/`{lcccc}`, `\toprule` `\midrule` `\bottomrule`, wrapped in `center` and `{\large ...}` |
| figure float with caption | assets/templates/poster.tex:229-256, 286-325 | `fig.class-native` | `tikzfigure[caption text]{...}` (caption is the optional argument) |
| inline maths | assets/templates/poster.tex:133, 192, 215 | `math.amsmath`, `math.amssymb` | `$10^3$`, `$\times$`, `$<$`; packages loaded at poster.tex:21 |
| bold, italic, mono marks | assets/templates/poster.tex:133, 345, 112 | `mark.kernel` | `\textbf`, `\textit`, `\texttt` |
| manual spacing | assets/templates/poster.tex:131, 137, 176 | `sp.manual-space` | `\vspace{1em}`, `\vspace{0.5em}`, `\\[0.2em]`, `\quad` |
| centring blocks | assets/templates/poster.tex:148, 177, 353 | `sp.ragged` | `center` environment |
| graphics loading | assets/templates/poster.tex:22 | `fig.graphicx` | package loaded; no `\includegraphics` in the active body |
| References block | assets/templates/poster.tex:343-360 | content | three typed lines in `{\small ...}`; not `thebibliography`, no `\cite` anywhere |
| QR code | assets/templates/poster.tex:27, 354 | `art.content-package` | `\qrcode[height=3.5cm]{URL}` (CTAN `qrcode`, LPPL 1.3, no external tool); data-driven graphic, content |
| running head, foot, page numbers, abstract, contents, cross-references, hyperref, language | none in poster.tex | none | no `\pagestyle`, `\label`, `\ref`, `\hypersetup`, babel or abstract; tikzposter draws no page numbers |

Other samples (outline-read only; preambles and custom definitions, not every body): article-based starters use `geometry`, `titlesec` `\titleformat`, `fancyhdr`, `enumitem`, `tabularx`, `booktabs`, `xcolor`, `hyperref` (for example assets/templates/academic-cv.tex:1-12, assets/templates/report.tex:1-19); book and thesis use `class.book` with `fancyhdr`, `titlesec`, `epigraph`, `lettrine`, `amsthm`, `algorithm`, `natbib`, `imakeidx`, `cleveref` (assets/templates/book.tex:1-183); lecture-notes uses `class.scrartcl` with `tcolorbox` theorem boxes `\newtcbtheorem` (assets/templates/lecture-notes.tex:6, 70-142); presentation uses `class.beamer` with `\usetheme{Madrid}` and `\setbeamercolor` (assets/templates/presentation.tex:1-25); exam uses `class.exam` with option `addpoints` (assets/templates/exam.tex:9). These were not mapped row by row.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\definetitlestyle{ConferenceTitle}` TikZ body | assets/templates/poster.tex:59-68 | no | TikZ drawing of the template's title bar and accent strip; a built-in `\usetitlestyle` plus `\colorlet` was considered, but no built-in key gives the amber strip and the class source was not read, so equivalence is not shown |
| `\defineblockstyle{ConferenceBlock}` TikZ body | assets/templates/poster.tex:71-83 | no | TikZ drawing of body frame (steelblue!40, 1pt) and navy title box; differs from the Default block style only in colours and widths, but that cannot be shown without the class source |
| colour names `navyblue` `steelblue` `amber` `darktext` `lightbg` | assets/templates/poster.tex:52-56 | yes | `color.xcolor` `\definecolor` with HTML values |
| `box`/`arrow` TikZ styles in the method diagram | assets/templates/poster.tex:149-155 | n/a | inside content-opaque TikZ picture |
| `problem`/`solution` environments, `\ifshowsolutions` | assets/templates/homework.tex:58, 90-128 | no | other sample; hand-rolled counter and conditional that hides printed text |
| etoolbox toggles and profile switch | assets/templates/conditional-document.tex:32-190 | no (as a mechanism) | other sample; a fixed configuration reduces to `page.geometry`, `head.titlesec`, `hf.fancyhdr`, `bg.watermark`, `sp.draft-lineno` |
| `\CompleteGraph` `\CycleGraph` `\PathGraph` | assets/templates/lecture-notes.tex:263-300 | no | other sample; `\foreach`/`\ifnum` position computation in TikZ |
| company-info `\newcommand` strings | assets/templates/letter.tex:41-54 | yes | other sample; inline expansion into text |
| `\FormField` `\FormTextArea` `\FormCheck` `\FormDropdown` | assets/templates/fillable-form.tex:64-93 | yes in form, but no lib way holds the hyperref form fields they wrap | other sample; see `UNMAPPED/body` |

## Content-opaque
- TikZ method-flow diagram (nodes and arrows) in a `center` environment, not in a float, but document content and not template identity (assets/templates/poster.tex:148-169)
- pgfplots bar chart inside `tikzfigure` (assets/templates/poster.tex:229-256) and scatter plot inside `tikzfigure` (assets/templates/poster.tex:286-325); `pgfplotsset{compat=1.18}` at poster.tex:26
- QR code via `qrcode` (assets/templates/poster.tex:354)
- Commented-out alternative "#BetterPoster" layout (assets/templates/poster.tex:366-522) is inside `%` comments and was not counted; the same TikZ and `\fontsize{72}{80}\selectfont` calls it contains would be `art.tikz` content and `font.size-commands`
- Commented colour-scheme alternatives (assets/templates/poster.tex:35-50) are parameter choices for `color.xcolor`

## Lib changes
- New ways proposed: none (considered: `qrcode` package, kept under `art.content-package`; considered: hyperref form fields for the other-sample fillable form, not proposed)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
