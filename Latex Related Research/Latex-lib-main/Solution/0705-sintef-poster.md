yes

# 0705-sintef-poster: SINTEF Poster (beamer + beamerposter A0 starter)

- Unverified: read from the source, not compiled.
- Source: Source/0705-sintef-poster/ (origin: https://latextemplates.com/downloads/sintef-poster.zip; licence: CC-BY-4.0, ATTRIBUTION.txt:3; derived from Federico Zenith's Overleaf template, ATTRIBUTION.txt:1,4)
- Kind: poster
- Lib: v5
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (published `beamer` plus `beamerposter`; the whole look is the sample's own `\definecolor`, `\setbeamercolor` and `\setbeamertemplate` lines, main.tex:9-18; no zip-local class or style)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip holds one 90-line `main.tex` (plus README and ATTRIBUTION) and no zip-local `.cls`/`.sty`, and it defines no `\newcommand`, `\def`, counter or environment. Everything is `beamer` and `beamerposter` (both on CTAN, read at ctan.org/pkg/beamer and ctan.org/pkg/beamerposter), `xcolor`, `booktabs` and kernel commands. The block look is two `\setbeamertemplate` calls built from beamer's own `beamercolorbox`, which reduces to `slide.beamer-template`. The one TikZ picture (main.tex:53-58) is a sample pipeline diagram, so it is content and not template artwork. Verdict `yes`, with that judgement as the one risk.

Note on mislabelling (data, not followed): main.tex:1-2, main.tex:39-42 and README.md:8-9 say the file is a `tikzposter` rendering. The code loads `beamer` (main.tex:3) and never loads `tikzposter`, and the `block` and `column` it uses are beamer's. I analysed what the code loads.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `final` (main.tex:3). Poster page size comes from `\usepackage[size=a0,scale=1.1]{beamerposter}` (main.tex:4). No `orientation` key is given in the source. README.md:3 says portrait, and the CTAN page does not state beamerposter's default, so I did not settle it (beamerposter's documentation was not read).
- Class-native vocabulary used (beamer):
  - `\title`, `\author` (main.tex:19-20); `\inserttitle`, `\insertauthor` (main.tex:24-25); `\insertblocktitle` (main.tex:17)
  - `frame[t]` (main.tex:22)
  - `block` environment, six uses (main.tex:37,51,61,66,76,81)
  - `columns` environment with `\column{0.47\paperwidth}` (main.tex:35-36,60,86)
  - `beamercolorbox[wd=,sep=,leftskip=,rightskip=]{<beamer colour>}` (main.tex:17,18,23,28)
  - `\setbeamertemplate{navigation symbols|block begin|block end}` (main.tex:13,17,18)
  - `\setbeamercolor{normal text|block title|block body}` (main.tex:14-16)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:3 | `class.beamer` | option `final` |
| page size and font scale | main.tex:4 | `poster.baposter` | `beamerposter` with `size=a0`, `scale=1.1`; no `orientation` key in source |
| font encoding | main.tex:5 | `font.fontenc-t1` | `fontenc` option `T1` |
| text font | main.tex:6 | `font.lmodern` | `lmodern`; no beamer font theme is set, so the beamer default applies |
| image package | main.tex:7 | `fig.graphicx` | `graphicx` loaded; no `\includegraphics` or figure float in the sample |
| colours | main.tex:9-12 | `color.xcolor` | `\definecolor` HTML model: sintefgreen 00843D, sintefdark 173F35, sinteflight E9F4EE, sintefgray F2F4F3 |
| navigation symbols off | main.tex:13 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` |
| page text and background colour | main.tex:14 | `slide.beamer-template` | `\setbeamercolor{normal text}{fg=sintefdark,bg=sintefgray}` |
| block title and body colours | main.tex:15-16 | `slide.beamer-template` | `block title` fg=white bg=sintefgreen; `block body` fg=sintefdark bg=white |
| block frame shape | main.tex:17-18 | `slide.beamer-template` | `block begin`: `beamercolorbox[wd=\linewidth,sep=0.65em]{block title}` holding `\Large\bfseries\insertblocktitle`, `\nointerlineskip`, then `beamercolorbox[wd=\linewidth,sep=0.9em]{block body}` left open; `block end`: close box, `\vspace{0.9em}` |
| title and author fields | main.tex:19-20 | `front.class-native` | `\title{...}`, `\author{...}`; no `\maketitle`; the author string joins name, group and URL with U+00B7 |
| single poster frame | main.tex:22,89 | `class.beamer` | `\begin{frame}[t]` ... `\end{frame}`; one frame, no overlays |
| title banner | main.tex:23-26 | `front.class-native` | `beamercolorbox[wd=\paperwidth,sep=1.5em,leftskip=2em,rightskip=2em]{block title}` around `\inserttitle` and `\insertauthor` |
| banner type size and weight | main.tex:24-25 | `font.size-commands` | `\fontsize{43}{50}\selectfont` (title), `\Large` (author) |
| banner bold | main.tex:24 | `mark.kernel` | `\bfseries` |
| banner and block spacing | main.tex:24,27,73,87 | `sp.manual-space` | `\vspace{0.25em}`, `\vspace{1.1em}`, `\vspace{0.5em}`, `\vfill` |
| intro summary box | main.tex:28-34 | `slide.beamer-template` | `beamercolorbox[wd=0.96\paperwidth,sep=0.9em]{block body}`; it is a plain paragraph in a coloured box, not a beamer abstract environment |
| two columns | main.tex:35-36,60,86 | `cols.minipage` | beamer `columns` with two `\column{0.47\paperwidth}` (closest lib way: fixed-width side-by-side boxes; beamer's source was not read) |
| poster blocks | main.tex:37-50,51-59,61-65,66-75,76-80,81-85 | `slide.beamer-template` | six `block{title}` environments styled by the `block begin/end` templates; no `\innerblock` hierarchy (tikzposter wording only in the text) |
| run-in headings | main.tex:43,47 | `mark.kernel` | `\textbf{...}` with `\par\medskip` (`sp.manual-space`) |
| run-in heading colour | main.tex:43,47,88 | `color.xcolor` | `\color{sintefgreen}`, `\color{sintefdark}` |
| code-face words | main.tex:39-41,83-84 | `mark.kernel` | `\texttt{...}` |
| alignment | main.tex:52,67,73,88 | `sp.ragged` | `\centering` (two blocks), `\raggedright`, `center` environment |
| body size | main.tex:73,88 | `font.size-commands` | `\small`, `\Large`, `\normalsize` |
| results table | main.tex:67-72 | `tbl.tabular` | `tabular{lrrr}`, no float, no caption or label |
| table rules | main.tex:7,67-71 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| closing footer text | main.tex:88 | `sp.ragged` | `center` with `\Large\color{sintefgreen}\bfseries` slogan, then `\normalsize\color{sintefdark}` contact line; body text at the end of the frame, not a running footer (colours: `color.xcolor`; sizes: `font.size-commands`; bold: `mark.kernel`) |

Not defined or used in the sample: running header or footer, page numbers, headings and numbering, lists, quotes, notes, maths, theorems, captions, code, bibliography, index, cross-references.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `block begin` / `block end` templates | main.tex:17-18 | yes | Preamble calls of `\setbeamertemplate`. The body uses only beamer's `beamercolorbox` and `\insertblocktitle`, plus `\Large`, `\bfseries`, `\nointerlineskip` and `\vspace`. It is `slide.beamer-template` free box code with `font.size-commands`, `mark.kernel` and `sp.manual-space`. |
| four colours | main.tex:9-12 | yes | `color.xcolor` `\definecolor{name}{HTML}{hex}` |
| beamer colour assignments | main.tex:14-16 | yes | `slide.beamer-template` `\setbeamercolor` |

No zip-local class, style, macro, counter, conditional or environment exists: the only files with TeX code are the 90-line `main.tex`, read in full, and it has no `\newcommand`, `\def`, `\newenvironment` or `\newcounter`.

## Content-opaque
- TikZ pipeline diagram (three `node` boxes, two arrows) inside the Pipeline block at main.tex:53-58, with `\usetikzlibrary{arrows.meta,positioning}` at main.tex:8 (`art.tikz`). Judged content because it is a fictional "measure, estimate, act" illustration. It is not the poster's block shape, page frame or banner; those come from `beamercolorbox` at main.tex:17-18 and 23-26. If a reviewer counts it as template artwork the verdict would flip to `no`.
- Fictional text, the numbers in the results table (main.tex:68-71) and the author string (main.tex:20) are content.

## Lib changes
- New ways proposed: none. Considered: beamer's `beamercolorbox` as a separate box way; not proposed, it is beamer's own vocabulary, recorded under `class.beamer` and used inside `slide.beamer-template`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
