yes

# 0303-uassign: uassign (university assignment question and solution package) and its short manual

- Unverified: read from the source, not compiled.
- Source: Source/0303-uassign/ (origin: https://mirrors.ctan.org/macros/latex/contrib/uassign.zip; licence: LPPL, per the manifest and the CTAN page ctan.org/pkg/uassign, which also gives v1.01 of 2015-09-23, author Nathan Esau, TeX Live and MiKTeX)
- Kind: assignment (the zip is the CTAN package for assignment question and solution sheets; the sample is a short two-column manual that demonstrates its environments, manifest hint `misc`)
- Lib: v4
- Engine: pdfLaTeX-compatible (nothing in the sample or in uassign.sty needs XeLaTeX or LuaLaTeX; every package it loads is ordinary pdfTeX-side TeX, uassign.sty:17-25)
- Look carried by: mixed (kernel `report` defaults, the sample's preamble at uassign.tex:1-14, and the published `uassign` package, shipped in the zip as the CTAN release `uassign.sty`, whose environments draw the question and solution look; none of the three is zip-local code)
- Class origin: tex-distribution-unbundled (kernel `report`, uassign.tex:1; the class file is not in the zip and its source was not read)
- Main file: uassign.tex (other samples: none; README.md is a plain-text summary of the package)
- Read: main yes (all 186 lines), zip-local classes and styles all (uassign.sty, 202 lines; README.md, 27 lines; `uassign.pdf` is the author's compiled manual and was not read)

## Verdict
The zip is the CTAN release of the `uassign` package plus its manual. The package is published (CTAN, TeX Live, MiKTeX, LPPL), is steered by five option names and serves any assignment sheet, so it passes W1 to W4. It is a question-bank package, so it needs no new line: the existing `exam.questions` way ("other question-bank packages; the package is the parameter") holds it, as `esami` and `mcexam` do. Everything else in the sample is a published kernel, `geometry` or `hyperref` setting, and the one zip-level macro, `\def\arraystretch{1.2}`, reduces to a kernel parameter. There is no `EXTERNAL` tool, no artwork and no template-defining drawing, so the answer is `yes`.

Three things to know when re-reading this verdict:
- The `yes` rests on treating `uassign.sty` as the published package, not as zip-local code. Its environments are hand-rolled (see "Bespoke code"); under the other reading they would be `BESPOKE/class` and the answer `no`.
- The sample loads `assign` (uassign.tex:3), but the zip ships `uassign.sty`, whose `\ProvidesPackage` line says `assign` (uassign.sty:2); the zip holds no `assign.sty`. An emitter writes `\usepackage{uassign}` (the CTAN name). The option `nobox` (uassign.tex:3) is not declared by the package, so it only reaches the warning at uassign.sty:108.
- README.md:17 writes `hidequestion` and README.md:25 writes `hideanswer`; the code declares `hidequestions` and `hideanswers` (uassign.sty:50-51). The code spelling is the one to emit.

## Blockers
none

## Class setting
- Class: `class.report` options: `twocolumn,twoside,11pt` (uassign.tex:1)
- Class-native vocabulary used: `\chapter` (uassign.tex:25), `\section` and `\subsection` (uassign.tex:27, :37, :39), `\title` `\author` `\date` `\maketitle` (uassign.tex:16-22), the `table` float and `\caption` (uassign.tex:41-53), `itemize`. The class source was not read.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | uassign.tex:1 | `class.report` | `twocolumn,twoside,11pt` |
| paper size and type size | uassign.tex:1 | `page.class-options` | `11pt`, `twoside`; no paper option, so the class default |
| columns | uassign.tex:1 | `cols.twocolumn-option` | `twocolumn` |
| page geometry | uassign.tex:5 | `page.geometry` | `\usepackage[margin=1.0in]{geometry}` |
| assignment package | uassign.tex:3; uassign.sty:2 | `exam.questions` | `\usepackage[nobox]{assign}` as shipped; the emitter writes `\usepackage[<options>]{uassign}`; the options that exist are `hideanswers` `hidequestions` `assignheader` `notesheader` `links` (uassign.sty:50-51, :53, :64, :95); the sample selects none of them, so questions and solutions are both shown (defaults uassign.sty:44, :48) |
| question environment | uassign.tex:115-117; uassign.sty:115-140 | `exam.questions` | `question` environment, numbered by counter `questioncounter` (uassign.sty:39), label `\thequestioncounter .`; hidden into a save box when `hidequestions` is set (uassign.sty:131-140) |
| solution environment | uassign.tex:131-133; uassign.sty:143-170 | `exam.questions` | `solution` environment, optional argument `[1.5em]` declared and unused (uassign.sty:145), counter `solutioncounter` (uassign.sty:40), bold "Solution: " line when questions are shown (uassign.sty:155); hidden when `hideanswers` is set (uassign.sty:161-170) |
| example, example solution, definition | uassign.tex:147-149, :163-165, :179-181; uassign.sty:172-200 | `exam.questions` | `example`, `exsolution`, `definition` environments: bold run-in head "Example n", "Solution n", "Definition n" with counters `examplecounter` `exsolutioncounter` `defcounter`; the `\numberwithin` lines are commented out (uassign.sty:173, :175, :177) |
| bold index entry | uassign.tex:180; uassign.sty:34-35 | `exam.questions` | `\ientry{mean}` is `\index{mean}\textbf{mean}`; the sample has no `\makeindex` or `\printindex`, so by kernel default the entry writes nothing printable and `idx.makeidx` is not used |
| end-of-solution box | uassign.sty:30-32 | `exam.questions` | `\ebox` is `\hfill$\qed$` (argument ignored); not used by the sample (uassign.tex:64 is commented out) |
| packages the package loads | uassign.sty:17-25 | `math.amsmath`, `thm.amsthm`, `list.enumerate-pkg`, `meta.bookmark`, `color.color`, `head.titlesec`, `hf.fancyhdr` | unconditional load-only lines; `ifthen` is also loaded (uassign.sty:17) but only serves the package's own boolean code, see "Lib changes"; none changes the page look until an option below is chosen |
| header and footer (option, not selected) | uassign.sty:53-62 | `hf.fancyhdr` | `assignheader`: `\pagestyle{fancy}`, `\fancyhf{}`, `\headrulewidth` 0pt, `\headheight` 27.18335pt, `\cfoot{\thepage}` |
| header, footer and headings (option, not selected) | uassign.sty:64-93 | `hf.fancyhdr`, `head.titlesec` | `notesheader`: `\chaptermark` to `\markboth{#1}{}`, italic centred heads on even and odd pages, page number at `LE,RO` (uassign.sty:68-74); `\titleformat{\chapter}[display]{\bfseries\filcenter}{\huge\thechapter}{1ex}{...\LARGE}[...\titlerule[1.0pt]...]`, `\titlespacing*{\chapter}{0pt}{-30pt}{40pt}` (uassign.sty:77-88); `\titleformat*` of `\section` (centred, `\large\bfseries`) and `\subsection` (centred, `\normalsize\bfseries\itshape`) (uassign.sty:91-92) |
| link colours option (not selected) | uassign.sty:95-106 | `meta.hyperref` | `links`: `colorlinks`, `linkcolor={blue}`, `linktoc=page`, `urlcolor=blue` |
| hyperlinks | uassign.tex:4, :8-12 | `meta.hyperref` | `\usepackage{hyperref}`; `\hypersetup{colorlinks, linkcolor={blue}, linktoc=page}` |
| row stretch | uassign.tex:6 | `tbl.tabular` | `\def\arraystretch{1.2}` (a kernel and `array` parameter) |
| section numbering | uassign.tex:14, :24 | `num.secnumdepth` | `\setcounter{secnumdepth}{0}` in the preamble, then `{-1}` after `\maketitle`, so chapter and section heads print unnumbered |
| title block | uassign.tex:16-22 | `front.maketitle` | `\title{The \texttt{uassign} package}`, `\author{Nathan Esau}`, `\date{\today}`, `\maketitle` (the `report` class's own title block) |
| headings | uassign.tex:25, :27, :37, :39, :56, :69, :85, :104, :106, :122, :138, :154, :170 | `head.kernel` | one `\chapter{Overview}`, `\section` and `\subsection` at the class defaults |
| bullet list | uassign.tex:30-35 | `list.kernel` | `itemize` with three items, each opening with a `\textit{...}` label |
| inline marks | uassign.tex:16, :28, :31-33 | `mark.kernel` | `\texttt`, `\textit` (kernel font switches) |
| table floats and captions | uassign.tex:41-53, :58-67, :71-83, :87-102 | `tbl.tabular`, `cap.kernel` | four `table[!htpb]` floats, `\centering`, `tabular{l l l}` or `{l l}`, `\hline` rules, `\caption` below each table |
| centring | uassign.tex:42, :59, :72, :88 | `sp.ragged` | `\centering` inside each table float |
| verbatim code | uassign.tex:108-112, :124-128, :140-144, :156-160, :172-176; :63 | `code.verbatim` | five `verbatim` blocks and `\verb|\ientry|` |
| rules between demos | uassign.tex:114, :120, :130, :136, :146, :152, :162, :168, :178, :184 | `sp.rule` | bare `\hrule` |
| manual spacing | uassign.tex:55, :119, :135, :151, :167, :183 | `sp.manual-space` | `\vspace{10mm}` once, `\vspace{3mm}` five times |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\arraystretch{1.2}` | uassign.tex:6 | yes | one preamble assignment, `tbl.tabular` parameter; `\renewcommand{\arraystretch}{1.2}` is the same value |
| `question`, `solution`, `example`, `exsolution`, `definition`, `\ientry`, `\ebox`, counters, booleans, `\trashcan` hide box | uassign.sty:30-200 | not reduced; treated as the published package's implementation | `uassign` is on CTAN (ctan.org/pkg/uassign: LPPL, TeX Live, MiKTeX), so the emitter loads the package and does not copy this code (way `exam.questions`, W1 to W4 above). If the file were instead read as zip-local code, it is hand-rolled behaviour: `\list{...}{... \item \begingroup}` with the `\item` inside the list's setup argument (uassign.sty:122-128, :150-157), `\ifthenelse` on booleans choosing between two `\newenvironment` bodies (uassign.sty:115-140, :143-170), and hiding by `lrbox` plus `minipage` (uassign.sty:134-139); that reading would give `BESPOKE/class` |
| option handlers | uassign.sty:50-109 | yes | `\DeclareOption` and `\ProcessOptions` only set booleans or issue published-package calls (`\pagestyle`, `\fancyhf`, `\fancyhead`, `\titleformat`, `\hypersetup`), each listed in the map above |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and not proposed: a separate doc-kind line for `uassign` (the lib's `exam.questions` line already names "other question-bank packages" with the package as the parameter, the same merge the v4 log made for `esami` and `mcexam`); `ifthen` (`\newboolean`, `\setboolean`, `\ifthenelse` appear only inside uassign.sty's own code, so there is no node content to wrap and W4 fails, the same ground on which v4 rejected `sp.xspace`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
