no

# 0135-chronology-project-calendar: Chronology Project Calendar

- Unverified: read from the source, not compiled.
- Source: Source/0135-chronology-project-calendar/ (origin: https://latextemplates.com/downloads/chronology-project-calendar.zip; licence: LPPL-1.3, from the manifest)
- Kind: calendar
- Lib: v2
- Engine: pdfLaTeX-compatible (article, geometry, tikz with arrows.meta, xcolor, booktabs, tabularx; no fontspec, no Unicode engine feature)
- Look carried by: preamble (no zip-local class or style; the look is `article` defaults plus the sample's own two-line preamble and its body markup)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; the zip holds this one 12-line file only)
- Read: main yes, zip-local classes and styles none present

## Verdict
Everything except the timeline reduces to existing lib ways (`class.article`, `page.geometry`, `color.xcolor`, `head.kernel`, `tbl.tabularx` with `tbl.booktabs`, `list.kernel`, and a title block of kernel font, colour and spacing switches), and the sample defines no macro, environment or counter. The hand-drawn timeline (main.tex:6-10) is placed with `\draw`, `\fill`, `\node` and `\foreach` coordinates, which is `art.tikz` (restricted); it sits outside any float, has no caption, and is the one element that makes this a chronology/calendar template, so I class it as template artwork (ART), not figure content. A reviewer who reads it as a data diagram (content-opaque) would flip this to yes since nothing else blocks; I chose `no` because a wrong yes costs more than a wrong no.

## Blockers
- `ART/body` hand-drawn project timeline: `tikzpicture` with a month axis, three phase bars and five milestone markers, not in a float, no lib way holds a timeline (main.tex:6-10; `\foreach` loops at main.tex:7 and main.tex:9; `\draw` phase bars at main.tex:8)

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:1). The class source ships with the LaTeX base and was not read.
- Class-native vocabulary used: only `\section*` (main.tex:5, main.tex:11, main.tex:12) and the `center`, `enumerate` environments. The sample does not call `\title`, `\author`, `\date`, `\maketitle` or the `abstract` environment; its title is set by hand (main.tex:4).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 11pt, a4paper |
| paper and base size | main.tex:1 | `page.class-options` | `a4paper`, `11pt` as class options |
| page geometry | main.tex:2 | `page.geometry` | `margin=2cm` (one value for all four sides) |
| colour definitions | main.tex:2 (xcolor loaded, no options), main.tex:4 | `color.xcolor` | `\definecolor{navy}{HTML}{223A5E}`, `\definecolor{orange}{HTML}{D97735}` (redefines xcolor's built-in `orange`) |
| title block wrapper | main.tex:4 | `sp.ragged` | kernel `center` environment around title and subtitle (the `\centering` family) |
| title size and colour | main.tex:4 | `font.size-commands`, `color.xcolor` | `\Huge` and `{\color{navy}...}` for "PROJECT ROADMAP"; `\large` for the subtitle line |
| title weight | main.tex:4 | `mark.kernel` | `\bfseries` (a kernel font-switch command) |
| title to subtitle gap | main.tex:4 | `sp.manual-space` | `\par\vspace{.2cm}` |
| section headings | main.tex:5, main.tex:11, main.tex:12 | `head.kernel` | `\section*` (unnumbered) three times; no `\renewcommand`, no `titlesec`; default article heading look |
| milestone table | main.tex:11 | `tbl.tabularx` | `\begin{tabularx}{\textwidth}`, one `X` column; header row is plain text, no bold |
| table column types | main.tex:11 | `tbl.tabular` | `p{.16\textwidth}p{.2\textwidth}X p{.2\textwidth}`, rows ended by `\\` |
| table rules | main.tex:11 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` only; no `\cmidrule`; not in a `table` float, no `\caption` |
| ordered list | main.tex:12 | `list.kernel` | `enumerate`, three `\item`, default labels |
| timeline wrapper | main.tex:6, main.tex:10 | `sp.ragged` | `center` environment around the `tikzpicture` |
| timeline drawing | main.tex:6-10 | `art.tikz` | `tikzpicture[x=1.65cm,y=1cm,>=Latex]`; navy axis `very thick ->` (0,0) to (7.2,0), eight month ticks via `\foreach \x/\m` (main.tex:7); three orange `very thick` phase bars at y=.4 with `midway` labels (main.tex:8); five milestone circles (3pt) with stems and `\scriptsize` labels via `\foreach \x/\y/\t` (main.tex:9). **ART/body** |
| TikZ libraries | main.tex:3 | `art.tikz` | `\usetikzlibrary{arrows.meta,positioning,calc}`; `tikz` loaded at main.tex:2 |
| prose paragraphs | main.tex:5 | content | the how-to-use paragraph is text, no template way needed |

Not present in the sample, so no way is needed: running heads and page numbers (class default `plain` style, no `\pagestyle` call), font packages (Computer Modern default), language, `hyperref`, `\maketitle`, abstract, contents, quotes, notes, maths, theorems, floats and captions, code, boxes, bibliography, index, cross-references (grep for `\caption`, `\label`, `\cite`, `\pagestyle` finds none).

## Bespoke code
none. `grep` for `\newcommand`, `\renewcommand`, `\def`, `\let`, `\newenvironment`, `\newcounter`, `\newif`, `\input`, `\include` finds nothing; the only definitions are the two `\definecolor` calls (main.tex:4), which are `color.xcolor` parameters. The `\foreach` loops (main.tex:7, main.tex:9) are pgffor inside the published TikZ picture, not zip-local macros.

## Content-opaque
none declared. The text inside the timeline (month names, "discover", "build", "pilot and learn", "brief", "review", "release", "checkpoint", "decision", main.tex:7-9) would be content if the picture were read as figure content; here the whole picture is classed ART (see Blockers). Table cell text (main.tex:11) and the list items (main.tex:12) are ordinary content.

## Lib changes
- New ways proposed: none. Timeline-package alternatives considered: `pgfgantt`, `chronology`; not used by the sample, and either would change the look, so neither is a reduction of this picture and neither is proposed.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
