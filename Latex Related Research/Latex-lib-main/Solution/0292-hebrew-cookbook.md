yes

# 0292-hebrew-cookbook: Hebrew Cookbook (bilingual Hebrew/English recipe page)

- Unverified: read from the source, not compiled.
- Source: Source/0292-hebrew-cookbook/ (origin: https://latextemplates.com/downloads/hebrew-cookbook.zip, upstream Overleaf gallery per ATTRIBUTION.txt:4; licence: CC-BY-4.0)
- Kind: misc (a recipe-page starter: a centred title block and repeated ingredient/method grids)
- Lib: v3
- Engine: needs XeLaTeX (`fontspec` main.tex:3, `polyglossia` main.tex:5; README.md:3 says XeLaTeX)
- Look carried by: preamble (kernel `article` loaded unchanged; the whole look is the sample's own preamble and one `\newcommand`, main.tex:1-22)
- Class origin: tex-distribution-unbundled (`article` ships with LaTeX; no class or style file in the zip)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds main.tex, README.md, ATTRIBUTION.txt only)

## Verdict
Every construct is a published package or a kernel command: `article`, `geometry`, `fontspec`, `polyglossia`, `xcolor`, `enumitem`, `tabularx`, kernel boxes and spacing. The only zip-local code is the `\dish` `\newcommand` (main.tex:17-22), a straight composition of lib ways with no counters, conditionals or layout algorithm, so it is reducible. There is no artwork and no tool outside TeX; the missing FreeSerif font is an asset to ship (not a blocker). Nothing was compiled.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `12pt` (main.tex:1)
- Class-native vocabulary used: none beyond the `center` environment; no `\maketitle`, no `abstract`, no sectioning commands, no bibliography (main.tex:24, 30)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | a4paper, 12pt |
| paper and text size | main.tex:1 | `page.class-options` | a4paper, 12pt |
| page geometry | main.tex:2 | `page.geometry` | margin=20mm |
| main font | main.tex:3-4 | `font.fontspec` | `\setmainfont{FreeSerif}`; the font is not shipped (system or TeX Live `gnu-freefont`; assumption, not checked) |
| language | main.tex:5-6 | `lang.polyglossia` | `\setmainlanguage{english}`, `\setotherlanguage{hebrew}`; Hebrew runs sit as raw Unicode in the text (main.tex:20, 24, 26, 28); the sample never calls `\texthebrew`, the `hebrew` environment or any `\RL`/`\LR` switch, so `lang.bidi` is not used by the sample itself (polyglossia's right-to-left support loads `bidi` on its own; not read here) |
| colour definitions | main.tex:7, 10 | `color.xcolor` | `\definecolor{olive}{HTML}{6D7041}`, `\definecolor{pomegranate}{HTML}{A63D40}`; used by `\textcolor` (main.tex:17, 18, 24) and `\color` (main.tex:24) |
| header and footer | main.tex:11 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| list defaults | main.tex:8, 11 | `list.enumitem` | `\setlist{nosep,leftmargin=*}`; preamble only, no list environment appears in the body |
| line-breaking looseness | main.tex:12, 16 | `sp.lengths` | `\emergencystretch=3em`, `\hfuzz=20pt` (raw TeX dimension parameters; the comment at main.tex:14-15 is only a rationale) |
| sloppy breaking | main.tex:13 | `sp.hyphenat` | `\sloppy` |
| title block | main.tex:24-25 | `sp.ragged`, `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.manual-space` | `center` environment; `{\Huge\bfseries\color{pomegranate} ...}`; `\par\vspace{2mm}`; `{\Large ...}`; `\smallskip`; `\textcolor{olive}{...}`; then `\bigskip`; hand-set, no `\maketitle` |
| recipe top rule | main.tex:17 | `sp.rule`, `color.xcolor` | `\noindent\textcolor{pomegranate}{\rule{\linewidth}{1pt}}\par` |
| recipe title line | main.tex:18 | `font.size-commands`, `mark.kernel`, `sp.manual-space`, `color.xcolor` | `{\Large\bfseries #1}\hfill\textcolor{olive}{#2}\par\smallskip` |
| ingredient/method grid | main.tex:19-20, 22 | `tbl.tabularx`, `tbl.tabular` | `tabularx` width `\linewidth`, column spec `@{}p{0.34\linewidth}X@{}`; header row of `\textbf` cells with `\\[-1pt]` and `\tabularnewline[2pt]` (`mark.kernel`, `sp.manual-space`) |
| grid cells | main.tex:21 | `box.minipage` | `\begin{minipage}[t]{\linewidth}...\end{minipage}` in each cell |
| spacing after a recipe | main.tex:22 | `sp.manual-space` | `\par\medskip` |
| repeated recipes | main.tex:26-29 | the `\dish{title}{note}{ingredient lines}` calls expand to the rows above (see Bespoke code) | content: Hebrew and English titles, "Serves 4", ingredient lines separated by `\\` |
| closing note | main.tex:30 | `sp.ragged`, `font.size-commands`, `mark.kernel` | `center`, `\small`, `\textit` |

Not used by the sample: headings and numbering, `\maketitle`, abstract, contents, floats and captions, theorems, code, bibliography, index, cross-references, hyperref.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\dish}[3]` | main.tex:17-22 | yes | Pure composition: `sp.rule` + `color.xcolor` (rule), `font.size-commands` + `mark.kernel` + `sp.manual-space` (`\hfill` title line), `tbl.tabularx` + `tbl.tabular` with two `box.minipage` cells. No counters, conditionals or computed layout. An emitter writes the same lines inline for each recipe node, or prints the `\newcommand` as an alias. |
| `\definecolor` x2 | main.tex:10 | yes | `color.xcolor`, HTML model, two named colours |
| `\hfuzz=20pt`, `\emergencystretch`, `\sloppy` | main.tex:12-16 | yes | `sp.lengths` and `sp.hyphenat` parameters, not code |

## Content-opaque
none (the Hebrew and English recipe text is ordinary content that `lang.polyglossia` and the body ways hold; no drawing or picture in the file)

## Lib changes
- New ways proposed: none. `lang.bidi` was considered and not used: the sample has no direction switch (main.tex:5-6, 20, 24).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
