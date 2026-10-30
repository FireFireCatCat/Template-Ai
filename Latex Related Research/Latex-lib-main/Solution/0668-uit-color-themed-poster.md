no

# 0668-uit-color-themed-poster: UiT Color-Themed Poster

- Unverified: read from the source, not compiled.
- Source: Source/0668-uit-color-themed-poster/ (origin: https://latextemplates.com/downloads/uit-color-poster.zip; licence: MIT)
- Kind: poster
- Lib: v5
- Engine: needs XeLaTeX or LuaLaTeX (`fontspec` at main.tex:3; README.md:15 says compile with LuaLaTeX)
- Look carried by: preamble (the zip holds one `main.tex` and a README; colours, block templates and the header band are the sample's own preamble and body over the published `beamer` class and `beamerposter`)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Everything the sample uses maps to a lib way: `beamer` with `beamerposter`, beamer colour and block templates, `fontspec`, `booktabs`, plain lists, `ragged2e`. The one local macro (`\stripe`) and the two block templates reduce by inline expansion. The title banner, however, carries a hand-drawn TikZ mark (two filled circles in the template colours) that is part of the header's identity and has no declarative lib way (`art.tikz` is a restricted way), so the answer is `no` on `ART/body`. The README states that no logos or upstream theme files are bundled (README.md:11-13), so the circles stand in for an institutional mark. If a reviewer treats that mark as logo content, nothing else blocks; I did not take that reading.

## Blockers
- `ART/body` two TikZ filled circles (`\fill[sun]` radius 0.32cm at (0,0), `\fill[fjord]` radius 0.32cm at (0.7,0)) inside the header banner, the poster's identity mark (main.tex:25-27). Considered: `pifont` `\ding` dots under `font.icons`; rejected because a font glyph is not the drawn mark and the emitter would be inventing a substitute.

## Class setting
- Class: `class.beamer` options: `final` (main.tex:1); loaded together with `beamerposter` `size=a0,scale=1.08` (main.tex:2)
- Class-native vocabulary used: `frame[t]` (main.tex:23), `columns[t,totalwidth=0.96\paperwidth]` and `column{<width>\paperwidth}` (31-32, 51, 75), `block{title}` (34, 39, 46, 53, 64, 77, 82, 89), `beamercolorbox` with keys `wd` `sep` `leftskip` `rightskip` `rounded` (16, 21, 24), `\title` `\author` (with `\and`) `\institute` (18-20), the accessors `\inserttitle` `\insertauthor` `\insertinstitute` `\insertblocktitle` (16, 28-29), `\setbeamercolor` `\setbeamertemplate` (12-17), `itemize`/`enumerate` with beamer's default item templates (40, 83). Beamer is not in the zip; its source was not read.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.beamer` | option `final` |
| poster paper size and scale | main.tex:2 | `poster.baposter` | `\usepackage[size=a0,scale=1.08]{beamerposter}`; orientation not set (package default); the page is one `frame` |
| text font | main.tex:3-4 | `font.fontspec` | `\setmainfont{TeX Gyre Heros}` (a TeX Live font, not shipped in the zip; beamer's default font theme is sans, so whether the main-font setting reaches body text is not established here) |
| colour definitions | main.tex:8-11 | `color.xcolor` | `\definecolor` HTML model: arctic 12304A, fjord 1B7F8C, sun F4B942, snow F4F8FA |
| beamer colours | main.tex:12-14 | `slide.beamer-template` | `\setbeamercolor`: normal text fg=arctic bg=snow; block title fg=white bg=arctic; block body fg=arctic bg=white |
| page background | main.tex:12 | `slide.beamer-template` | background colour is `bg=snow` of `normal text` (not `color.pagecolor`) |
| navigation symbols | main.tex:15 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` (empty template) |
| block look (begin and end) | main.tex:16-17 | `slide.beamer-template`, `font.size-commands`, `mark.kernel`, `sp.ragged`, `sp.manual-space` | begin: `beamercolorbox[rounded=true,sep=0.75em]{block title}` holding `\Large\bfseries\insertblocktitle`, `\nointerlineskip` (kernel vertical-glue switch inside the template body), then `beamercolorbox[sep=0.95em]{block body}` and `\justifying`; end: close the box and `\vspace{0.8em}` |
| ragged2e package | main.tex:7 | `sp.ragged` | `\usepackage{ragged2e}`, used for `\justifying` (16) and `\centering` (54, 65) |
| tikz package load | main.tex:6 | `art.tikz` | `\usepackage{tikz}`; uses are the ART mark (25-27) and the content plot (55-62) |
| title fields | main.tex:18-20 | `front.class-native` | `\title{Signals across the northern shelf}`, `\author{... \and ...}`, `\institute{... \quad \texttt{...}}`; strings are content |
| header banner box | main.tex:24, 30 | `slide.beamer-template` | `beamercolorbox[wd=\paperwidth,sep=1.5em,leftskip=2em,rightskip=2em]{block title}`, closed then `\vspace{1em}` |
| header banner content | main.tex:28-29 | `font.size-commands`, `mark.kernel`, `sp.manual-space`, `front.class-native` | `\fontsize{48}{54}\selectfont\bfseries\inserttitle`; `\hspace{0.5em}`, `\par\vspace{0.35em}`; `\Large\insertauthor`, `\hfill`, `\large\insertinstitute` |
| header mark (two circles) | main.tex:25-27 | `art.tikz` | ART blocker, see Blockers |
| frame | main.tex:23, 97 | `class.beamer` | `frame[t]`, one frame for the whole poster |
| three columns | main.tex:31-32, 51, 75, 95-96 | `class.beamer` | native `columns[t,totalwidth=0.96\paperwidth]`; `column` widths 0.31, 0.36, 0.23 of `\paperwidth` (the lib has no beamer-columns way; `cols.minipage` does not cover beamer's alignment key) |
| column heading stripe | main.tex:21, 33, 52, 76 | `slide.beamer-template`, `font.size-commands`, `mark.kernel`, `sp.manual-space` | the `\stripe{text}` macro expands to `beamercolorbox[wd=\linewidth,sep=0.55em]{block title}` holding `\Large\bfseries text`, then `\vspace{0.35em}` |
| content blocks | main.tex:34, 39, 46, 53, 64, 77, 82, 89 | `slide.beamer-template` | the beamer `block{title}` environment, styled only by the begin/end templates above |
| enumerate | main.tex:40-44 | `list.kernel`, `sp.lengths` | `enumerate` with `\itemsep0.35em` |
| itemize | main.tex:83-87 | `list.kernel`, `sp.lengths` | `itemize` with `\itemsep0.35em` |
| alignment in blocks | main.tex:54, 65 | `sp.ragged` | `\centering` before the plot and the table |
| results table | main.tex:66-72 | `tbl.tabular`, `tbl.booktabs`, `mark.kernel` | `tabular{lccc}`, `\toprule` `\midrule` `\bottomrule`, `\textbf` on the best row; no float, no caption |
| inline facts | main.tex:47-48 | `sp.manual-space`, `math.kernel` | `\quad`, `\\`, inline `$\cdot$` as separators |
| column footer note | main.tex:93-94 | `sp.manual-space`, `font.size-commands`, `mark.kernel` | `\vfill`, `\small`, `\textbf{...}`, `\\[0.3em]` |
| header/footer, headings, numbering, theorems, bibliography, captions | none | none | not used: the sample has no `\section`, no footline setting, no `\caption`, no citations (main.tex:22-98) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\stripe` macro | main.tex:21 | yes | one `\newcommand` alias of `beamercolorbox[wd=\linewidth,sep=0.55em]{block title}` + `\Large\bfseries` + `\vspace{0.35em}`; inline expansion into `slide.beamer-template`, `font.size-commands`, `mark.kernel`, `sp.manual-space` |
| `block begin` template body | main.tex:16 | yes | two `beamercolorbox` nodes with `\insertblocktitle`, `\nointerlineskip`, `\justifying`: `slide.beamer-template`, `sp.ragged`, `font.size-commands`, `mark.kernel` |
| `block end` template body | main.tex:17 | yes | `\end{beamercolorbox}\vspace{0.8em}`: `slide.beamer-template`, `sp.manual-space` |
| header circle mark | main.tex:25-27 | no | `ART/body`; no lib way draws a fixed two-circle emblem |

## Content-opaque
- TikZ plot (axes, two smooth curves, two labels) in the "Quality-aware seasonal model" block (main.tex:55-62): figure artwork inside a block, content. No float and no caption.
- Text, station numbers, table cells and the example.org address (main.tex:34-94) are content.

## Lib changes
- New ways proposed: none. Considered: `pifont` for the header dots (kept as `font.icons`, not proposed, since it would not reproduce the drawn mark).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
