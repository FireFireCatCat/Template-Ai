yes

# 0704-evweek-weekly-calendar: evweek Weekly Calendar (a weekly focus planner)

- Unverified: read from the source, not compiled.
- Source: Source/0704-evweek-weekly-calendar/ (origin: https://latextemplates.com/downloads/evweek-weekly-calendar.zip; licence: LPPL-1.3a per the manifest, no licence text inside the zip)
- Kind: calendar
- Lib: v5
- Engine: pdfLaTeX-compatible (kernel `article` plus `geometry`, `xcolor`, `tabularx`, `array`, `booktabs`, `fancyhdr`; no `fontspec`, no `inputenc` line, the file holds only ASCII bytes)
- Look carried by: preamble (the zip is one 15-line `main.tex` over the kernel `article` class; the look is the package options and `\definecolor` lines at main.tex:1-3 plus the table and heading markup in the body)
- Class origin: tex-distribution-unbundled (`article` is the LaTeX base class, not in the zip; its source was not read)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only `main.tex`, 15 lines, 1999 bytes; no `.cls`, `.sty`, `.def` or other file)

## Verdict
The whole template is the kernel `article` class, six published packages and kernel commands, all steered by option values, lengths, colours and column specs. The only zip-local macro is `\slot` (main.tex:4), a `\newcommand` row alias that no body line calls, so it reduces to nothing or to its inline expansion. There is no artwork, no external tool and no zip-local class or style, so the answer is `yes`; the look is carried by the preamble and body, so this is evidence about the component ways, not about a carrying class. The manifest name "evweek" appears in no line of the zip (no package or class of that name is loaded).

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:1)
- Class-native vocabulary used: kernel sectioning only (`\section*`, main.tex:14 and main.tex:15) and `itemize` (main.tex:15); no `\maketitle`, `\title`, `\date` or `abstract` is used, the title is hand-laid (main.tex:5)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | `11pt`, `a4paper` |
| paper and base size | main.tex:1 | `page.class-options` | `a4paper`, `11pt` |
| page geometry | main.tex:2 | `page.geometry` | `margin=1.4cm` (one value, all four sides) |
| colour package | main.tex:2 | `color.xcolor` | option `table` (this also loads `colortbl`, see the striped-rows line) |
| colour definitions | main.tex:3 | `color.xcolor` | `\definecolor{green}{HTML}{2E6B55}` (redefines xcolor's built-in name `green`), `\definecolor{pale}{HTML}{EEF6F1}` |
| coloured title text | main.tex:5 | `color.xcolor` | `{\color{green}\Huge\bfseries WEEKLY FOCUS}` |
| header and footer | main.tex:2, main.tex:3 | `hf.fancyhdr` | package loaded at main.tex:2; `\pagestyle{fancy}`, `\fancyhf{}` (clears all six fields, so no footer and no page number), `\lhead{Weekly focus planner}`, `\rhead{Week of 9 February 2026}`, `\renewcommand{\headrulewidth}{.4pt}` |
| title block (front matter) | main.tex:5 | none (hand-laid; no front-matter way applies, it is composed of the colour row above and the four rows below) | no `\title` or `\maketitle` is used, so the kernel title way is not involved; the block is a `center` environment of two lines |
| title block: centring | main.tex:5 | `sp.ragged` | `center` environment (the environment form of `\centering`) around the two title lines |
| title block: sizes | main.tex:5 | `font.size-commands` | `\Huge` on the title line, `\Large` on the date line |
| title block: weight | main.tex:5 | `mark.kernel` | `\bfseries` (title line) |
| title block: spacing | main.tex:5 | `sp.manual-space` | `\par\vspace{.2cm}` between the two lines, `\vspace{.4cm}` after the block |
| spacing before section | main.tex:14 | `sp.manual-space` | `\vspace{.8cm}` before `\section*{Three outcomes}` |
| paragraph indent off | main.tex:6 | `sp.lengths` | `\noindent` before the first table (the one-paragraph form of `\parindent=0pt`, same type; a filing judgement, see Lib changes) |
| weekly schedule table | main.tex:6-13 | `tbl.tabularx` | `\begin{tabularx}{\textwidth}{>{\bfseries}p{2.1cm}X X X}`; header row `Day`, `Must move forward`, `Meetings / fixed time`, `Notes and follow-up`; seven day rows (main.tex:7-13) |
| schedule table columns | main.tex:6 | `tbl.tabular` | `array` column syntax: `>{\bfseries}` before a `p{2.1cm}` column, then three `X` columns |
| outcomes table | main.tex:14 | `tbl.tabularx` | `\begin{tabularx}{\textwidth}{p{.08\textwidth}X p{.25\textwidth}}`; three rows (number, outcome, owner) |
| outcomes table columns | main.tex:14 | `tbl.tabular` | `p{.08\textwidth}`, `X`, `p{.25\textwidth}` |
| table rules | main.tex:6-14 | `tbl.booktabs` | `\toprule` (main.tex:6, main.tex:14), `\midrule` after the header row and after each row (main.tex:6-12, main.tex:14), `\bottomrule` (main.tex:13, main.tex:14) |
| striped rows | main.tex:2, main.tex:6 | `tbl.colortbl` | `xcolor[table]` plus `\rowcolors{2}{pale}{}`: striping starts at row 2, one stripe colour `pale`, the other empty (xcolor assigns odd and even). The call is ungrouped, so whether the second table (main.tex:14) is also striped is a scope detail of xcolor, not a way matter; not compiled |
| unnumbered headings | main.tex:14, main.tex:15 | `head.kernel` | `\section*{Three outcomes}`, `\section*{Parking lot}`; `article` default heading look, no `\titleformat` |
| bullet list | main.tex:15 | `list.kernel` | `itemize` with two `\item`, default labels and spacing |

No component is defined for fonts (no font package: the kernel Computer Modern default), language (no `babel`), metadata or links (no `hyperref`), cross-references, floats, captions, math, theorems, code, boxes, bibliography or index: main.tex has none of them (15 lines, all read).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\slot}[2]{\textbf{#1} & #2\\\midrule}` | main.tex:4 | yes | A table-row alias: `\textbf` (`mark.kernel`) in the first cell, `&`, then `\midrule` (`tbl.booktabs`). A search of main.tex finds `\slot` only on line 4, so no body line calls it and an emitter can drop it; if kept, inline expansion gives `\textbf{a} & b\\\midrule`. |

No other `\newcommand`, `\def`, counter, conditional, environment, class or style exists in the zip.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Filing note, no proposal: `\noindent` (main.tex:6) has no line of its own in the lib; it is filed under `sp.lengths` as the one-paragraph form of `\parindent`, on the rubric's rule that a way covers other commands of its type. If a reviewer reads that as a stretch, the verdict does not change: `\noindent` is a kernel command that passes W1 to W4.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
