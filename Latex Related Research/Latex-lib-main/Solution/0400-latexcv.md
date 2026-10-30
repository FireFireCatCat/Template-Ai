yes

# 0400-latexcv: latexcv (classic style)

- Unverified: read from the source, not compiled.
- Source: Source/0400-latexcv/ (origin: https://latextemplates.com/downloads/latexcv.zip; upstream jankapunkt/latexcv per README.md:3; licence: MIT, main.tex:2)
- Kind: cv
- Lib: v4
- Engine: pdfLaTeX-compatible (README.md:30 says `pdflatex main`; main.tex:28 uses `inputenc`, `fontenc` T1; the `raleway` CTAN page names XeLaTeX/LuaLaTeX for the OpenType fonts and tags Type 1, pdfTeX support is not stated there; nothing compiled)
- Look carried by: preamble (a plain `article` plus three zip-local `\newcommand` macros and one column type in main.tex:46-95; no class or style file in the zip)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is one `main.tex` on the kernel `article` class, with no zip-local `.cls` or `.sty`. Every part of the look is a composition of lib ways: geometry, `fancyhdr` with the page number emptied, the Raleway sans face, `array` column type, kernel rules, boxes and spacing, `color` colours. The three `\newcommand` macros (`\cvsection`, `\metasection`, `\cvevent`) only wrap those ways and reduce by inline expansion; the one `\foreach` iterates the content list and is unrolled by an emitter. `tikz` is loaded but draws nothing, so there is no `ART` blocker. Nothing needs a tool outside TeX.

## Blockers
none

## Class setting
- Class: `class.article` options: `10pt`, `A4` (main.tex:26; `A4` is not one of article's paper options, which are `a4paper` and its siblings; paper size is set by `geometry` at main.tex:35)
- Class-native vocabulary used: none (no `\maketitle`, `abstract`, `\section`, `thebibliography` in the body; sample read in full)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:26 | `class.article` | 10pt, A4 (see above) |
| paper and size | main.tex:26, 35 | `page.class-options` | `10pt`; paper comes from `geometry` `a4paper` |
| input and font encoding | main.tex:28, 32 | `font.fontenc-t1` | `inputenc` utf8; `fontenc` T1 |
| text face | main.tex:30 | `font.helvet` | package `raleway`, option `default` (a sans text-face package is the parameter) |
| default family | main.tex:31 | `font.family-default` | `\familydefault` = `\sfdefault` |
| size commands | main.tex:33, 68, 74, 103, 104, 117 | `font.size-commands` | `\HUGE` (package `moresize`, title), `\large` (section heading), `\footnotesize` (meta lines), `\small`, `\normalsize` |
| page geometry | main.tex:35-36 | `page.geometry` | `a4paper`, top=1.25cm, bottom=-.6cm (negative), left=1.5cm, right=1.5cm |
| header height | main.tex:40 | `page.setlength` | `\headheight` = -5pt (raw layout length) |
| running head and foot | main.tex:38-39, 60-61, 99 | `hf.fancyhdr` | `\pagestyle{fancy}` (twice); `\headrulewidth`=0pt, `\footrulewidth`=0pt; no `\fancyhf`/`\fancyhead`/`\fancyfoot` call (grep), so fields stay at package defaults |
| page number hidden | main.tex:62 | `num.counters` | `\renewcommand{\thepage}{}` |
| section number hidden | main.tex:63 | `num.counters` | `\renewcommand{\thesection}{}` (no `\section` in the sample, so unused) |
| paragraph indent | main.tex:41 | `sp.lengths` | `\parindent` = 0mm |
| colours | main.tex:55-58 | `color.color` | package `color`; `sectcol` RGB 0,150,255; `bgcol` RGB 110,110,110; `softcol` RGB 225,225,225 |
| right-aligned column type | main.tex:45-47 | `tbl.tabular` | `array` `\newcolumntype{x}[1]{>{\raggedleft\hspace{0pt}}p{#1}}` |
| packages loaded, never called | main.tex:43, 44, 49, 50, 51 | `cols.multicol`, `tbl.multirow`, `fig.graphicx`, `fig.wrapfig`, `fig.float` | no `multicols`, `\multirow`, `\includegraphics`, `wrapfigure` or `figure` anywhere in the body (grep) |
| tikz loaded, nothing drawn | main.tex:52-53, 88 | `art.tikz` | `tikz` plus libraries `shapes`, `backgrounds`, `mindmap`, `trees`; load-only: the sample has no `tikzpicture`, `\node`, `\draw` or `\path` (grep), and uses only pgffor's `\foreach` at :88. Not ART |
| `xifthen` loaded, never called | main.tex:29 | none needed | no `\ifthenelse`, `\isempty` in the sample (grep); load-only package with no printed effect, dropped by an emitter |
| title block (hand-laid) | main.tex:101-105 | `sp.ragged`, `font.size-commands`, `mark.kernel`, `color.color`, `sp.rule`, `sp.manual-space` | `center` environment; `\HUGE \textsc{name} \textcolor{sectcol}{\rule[-1mm]{1mm}{0.9cm}} \textsc{Resume}\\[2pt]`, then `\small` subtitle. No `front.*` way applies: no `\maketitle`, no `titlepage` |
| contact and meta lines | main.tex:72-75, 109-114 | `font.size-commands`, `sp.manual-space`, `mark.kernel`, `sp.rule`, `color.color` | `\footnotesize{#2} \hspace*{\fill} \footnotesize{#1}\\[1pt]` x4; `\vspace{-2pt}`, `\textcolor{softcol}{\hrule}`, `\vspace{6pt}` |
| section heading | main.tex:65-70, 120, 126, 143 | `sp.ragged`, `font.size-commands`, `color.color`, `mark.kernel` | `\cvsection`: `center` env, `\large`, `\textcolor{sectcol}`, `\textbf`; written by hand, not by `\section` |
| entry header line | main.tex:80-82 | `tbl.tabular`, `mark.kernel`, `color.color`, `sp.manual-space` | `tabular*` width `1\textwidth`, columns `p{13.6cm}` and `x{3.9cm}`; `\textbf{title} - \textcolor{bgcol}{org}` left, `\vspace{2.5pt}\textcolor{sectcol}{date}` right |
| entry rule and spacing | main.tex:84-86, 92 | `sp.manual-space`, `sp.rule`, `color.color` | `\vspace{-8pt}`, `\textcolor{softcol}{\hrule}`, `\vspace{6pt}`; closing `\vspace{3pt}` |
| entry bullets | main.tex:88-90 | `math.kernel`, `sp.manual-space` | per item `$\cdot$ item\\[3pt]` (the `\foreach` is unrolled, see Bespoke code) |
| strut | main.tex:95, 156 | `sp.rule` | `\rule[-.3\baselineskip]{0pt}{\baselineskip}` |
| summary and entry text | main.tex:119-152 | content | `\normalsize`, `\vspace{-6pt}`, paragraph and entry arguments are text |
| page-bottom link line | main.tex:154-156 | `sp.manual-space`, `box.fancybox`, `color.color`, `mark.kernel`, `sp.rule`, `math.kernel` | `\null`, `\vspace*{\fill}`, `\hspace{-0.25\linewidth}`, `\colorbox{white}`, `\makebox[1.5\linewidth][c]`, strut, `\textnormal`, two `\textcolor{sectcol}` strings joined by `$\cdot$` |
| not present | main.tex:97-158 | none | no bibliography, index, footnote, theorem, math display, figure, table float, caption, code or list environment in the sample (read in full) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcolumntype{x}` | main.tex:46-47 | yes | `array` declaration: `>{\raggedleft\hspace{0pt}}p{w}`; `tbl.tabular` |
| `\cvsection` | main.tex:65-70 | yes | inline body wrapper: `center` env + `\large` + `\textcolor{sectcol}{\textbf{..}}` (`sp.ragged`, `font.size-commands`, `color.color`, `mark.kernel`); `head.titlesec` with `\titleformat` would be an alternative realisation, not used by the source |
| `\metasection` | main.tex:72-75 | yes | `\footnotesize` + `\hspace*{\fill}` + `\\[1pt]` (`font.size-commands`, `sp.manual-space`) |
| `\cvevent` | main.tex:77-93 | yes | `tabular*` header, `\hrule` in `softcol`, `\vspace`s; bullet lines written out one per item (`tbl.tabular`, `sp.rule`, `sp.manual-space`, `color.color`) |
| `\foreach \desc in {#4}` | main.tex:88-90 | yes | pgffor (published, via `tikz`) repeats the fixed pattern `$\cdot$ item\\[3pt]` over a content list; it keeps no counter and tests no condition, so an emitter writes the lines out and `tikz` is no longer needed |
| `\mystrut` | main.tex:95 | yes | alias of `\rule[-.3\baselineskip]{0pt}{\baselineskip}` (`sp.rule`) |
| `\renewcommand` of `\headrulewidth`, `\footrulewidth`, `\thepage`, `\thesection` | main.tex:60-63 | yes | declarative parameter and counter-print settings (`hf.fancyhdr`, `num.counters`) |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and folded into existing lines: `moresize` (`\HUGE`) into `font.size-commands` (the same type of effect, a font-size switch, with the package as the parameter, as `font.helvet` into `font.helvet`; W1: ctan.org/pkg/moresize, LPPL, in TeX Live); `raleway` into `font.helvet` (a sans text-face package, W1: ctan.org/pkg/raleway, LPPL 1.3 and OFL, in TeX Live).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
