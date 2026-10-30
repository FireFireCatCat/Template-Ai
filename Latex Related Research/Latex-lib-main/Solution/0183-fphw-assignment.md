yes

# 0183-fphw-assignment: FPHW Assignment

- Unverified: read from the source, not compiled.
- Source: Source/0183-fphw-assignment/ (origin: https://latextemplates.com/downloads/fphw-assignment.zip; licence: Unlicense)
- Kind: assignment
- Lib: v3
- Engine: pdfLaTeX-compatible
- Look carried by: zip-local (fphw.cls defines the whole look as `\LoadClass{article}` plus published packages; the main.tex preamble only adds amsmath, amssymb, graphicx)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
yes. `fphw.cls` (126 lines) is a thin zip-local class: it loads `article`, sets `titlesec`, `geometry` and `fancyhdr`, redefines `\maketitle` from kernel commands, and defines one boxed `problem` environment from kernel box commands. Every piece reduces to existing lib ways, because the only conditionals are presence tests on four optional strings, which an emitter resolves at emit time and leaves out of the output. No artwork, no external tool, no way outside the lib is needed. Class origin: `https://ctan.org/pkg/fphw` returned HTTP 404 (one read), and the README's claim that the class was delisted from CTAN (README.md:12-18) is unverified, so it is treated as zip-local; the verdict is the same if it were treated as published.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (forced by the zip-local class, fphw.cls:58); the sample passes no option (main.tex:1). All other options are forwarded to article (fphw.cls:60). `twocolumn` and `twoside` are swallowed with `\OptionNotUsed` (fphw.cls:44,47), so the page is always one column, oneside. 10pt default size, no size option.
- Class-native vocabulary used: from `article`: `\title` `\author` `\date` `\maketitle` `\section` `\section*` (main.tex:3,4,8,16,24,44,57). From the zip-local `fphw`, which is not published and is reduced below: `\class` `\professor` `\institute` (main.tex:5-7) and the `problem` environment (main.tex:18,38). Optional `spanish` class option exists (fphw.cls:51-56), unused by the sample.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1; fphw.cls:71 | `class.article` | `\documentclass[a4paper]{article}`, no `\LoadClass` options |
| paper size | fphw.cls:58,60 | `page.class-options` | `a4paper` |
| page geometry | fphw.cls:86,88 | `page.geometry` | left=2.5cm, right=2.5cm, top=2.5cm, bottom=2.5cm |
| running header and footer | fphw.cls:36,90-97 | `hf.fancyhdr` | `\fancyhead{}` `\fancyfoot{}` `\pagestyle{fancy}`; `\headrulewidth`=0.4pt, `\footrulewidth`=0.4pt (93,94); `\fancyhead[RO]{\footnotesize\thepage}` (95); `\fancyhead[LO]`: `\footnotesize`, then class name in `\itshape` followed by ` -- `, then the title in upright type (96); `\fancyfoot[RO]{\footnotesize\itshape <author>}` (97) |
| first page uses plain style | fphw.cls:101 | `hf.pagestyle-kernel` | `\thispagestyle{plain}` at the start of the title block |
| title data | main.tex:3,4,8 | `front.maketitle` | `\title{Problem Set 3: ...}`, `\author{Jamie Rivera}`, `\date{\today}` |
| title block (redefined `\maketitle`) | main.tex:16; fphw.cls:100-117 | `front.maketitle` | `\renewcommand{\maketitle}` whose body is only kernel commands (see the next four rows); set fields: institute, title, author, course, professor, date; each unset field is simply not emitted |
| title block centring | fphw.cls:102,116 | `sp.ragged` | kernel `center` environment around the whole block |
| title block rules | fphw.cls:104,109 | `sp.rule` | two bare `\hrule` (full width, default thickness) |
| title block spacing | fphw.cls:103,105,106,108,110,113,115 | `sp.manual-space` | `\\[10pt]` after institute; `\vspace{10pt}`; `\\[5pt]` after title; `\vspace{8pt}`; `\vspace{10pt}`; `\\`; `\vspace{20pt}` |
| title block type | fphw.cls:103,106,107,111,112,114 | `font.size-commands` | title `\LARGE`; the labels "Student name:", "Course:", "Professor:", "Due date:" are fixed strings (fphw.cls:30-33) |
| title block shapes | fphw.cls:103,106,107,111,112,114 | `mark.kernel` | institute `\scshape`; title `\bfseries`; author, course, professor, date `\itshape` |
| headings | fphw.cls:75,77 | `head.titlesec` | `\titleformat{\section}[block]{\normalsize\bfseries\filcenter}{\thesection.}{.3cm}{}`; no `\titlespacing` call, so the class defaults stay; the sample uses `\section*` (main.tex:24,44) and `\section` (main.tex:57) |
| run-in subheadings | fphw.cls:80-83 | `head.titlesec` | `\subsection`: `[runin]`, `\bfseries`, label ` \thesubsection.`, sep 1mm, after `[.\quad]`; `\subsubsection`: `[runin]`, `\bfseries\itshape`, label ` \thesubsubsection.`, sep 1mm, after `[.\quad]` (defined, not used by the sample) |
| problem box | fphw.cls:120-123; main.tex:18-22,38-42 | `box.fancybox` | `\fbox{\usebox{\problembox}}` around an `lrbox` (`\newsavebox{\problembox}`, line 120) |
| problem box inner width | fphw.cls:122 | `box.minipage` | `\begin{minipage}{.98\textwidth}` |
| problem box centring | fphw.cls:122,123 | `sp.ragged` | kernel `center` environment around the framed box |
| lists | main.tex:59-64 | `list.kernel` | `enumerate`, two `\item`, default labels |
| display maths | main.tex:10,29-32,47-50 | `math.amsmath` | `\usepackage{amsmath}`; `align*` (also `\tfrac`, `\frac`) |
| display maths without numbers | main.tex:34-36,52-55 | `math.kernel` | `\[ ... \]` |
| math symbols | main.tex:11 | `math.amssymb` | `\usepackage{amssymb}` (no symbol from it is used in the body) |
| graphics | main.tex:12 | `fig.graphicx` | `\usepackage{graphicx}`; loaded, no figure in the sample |

Not set anywhere, so no row: fonts (class default Computer Modern, no font package), colour, language packages, bibliography, index, theorems, tables, captions, floats, footnotes.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| the whole `fphw` class | fphw.cls:1-126 | yes | `\documentclass[a4paper]{article}` + `titlesec` + `geometry` + `fancyhdr` + the rows above; the class holds no counters, no output routine, no `\@startsection`/`\@makecaption` redefinition |
| setters `\professor`, `\class`, `\institute` | fphw.cls:23,25,27 | yes | each is `\newcommand{\...loc}{#1}` storing a string; the emitter inlines the string into the title block and into the header (or writes the `\newcommand` itself); strings are content |
| label macros `\CourseLang` `\DateLang` `\StudentLang` `\ProfessorLang` | fphw.cls:30-33 | yes | four fixed English strings, inlined as "Course:", "Due date:", "Student name:", "Professor:" |
| `spanish` option | fphw.cls:51-56 | yes | swaps those four strings for Spanish ones; no `babel` is loaded, so the emitter just writes the other four strings (not used by the sample) |
| option filtering | fphw.cls:44,47,58,60,62 | yes | `twocolumn` and `twoside` are dropped, `a4paper` is forced, the rest goes to article; the emitter writes `\documentclass[a4paper]{article}` and never passes the two dropped options |
| `\renewcommand{\maketitle}` with `\ifx...\undefined` tests | fphw.cls:100-117 (tests at 103,111,112) | yes | the tests only ask whether one of three optional strings was set; the emitter knows that, so it writes the body with the unset lines left out and no conditional. Example for the sample: `\thispagestyle{plain}\begin{center}{\scshape Department of Physics}\\[10pt]\hrule\vspace{10pt}{\LARGE\bfseries <title>}\\[5pt]Student name: {\itshape <author>}\vspace{8pt}\hrule\vspace{10pt}Course: {\itshape <class> -- }Professor: {\itshape <prof>}\\Due date: {\itshape <date>}\vspace{20pt}\end{center}` |
| conditional in the left header | fphw.cls:96 | yes | same presence test on `\classlocal`; resolved at emit time to `\footnotesize{\itshape <class> -- }<title>` |
| `\@title`, `\@author`, `\@date` read-backs, `\makeatletter` wrappers | fphw.cls:96,97,106,107,114 | yes | kernel data macros read, never redefined; the `\makeatletter` calls are no-ops inside a class file; the emitter can print the title and author strings instead |
| `problem` environment and `\newsavebox` | fphw.cls:120-123 | yes | `\newenvironment` whose start is `\begin{center}\begin{lrbox}{\problembox}\begin{minipage}{.98\textwidth}` and whose end is `\end{minipage}\end{lrbox}\fbox{\usebox{\problembox}}\end{center}`: kernel box commands only (`box.fancybox`, `box.minipage`, `sp.ragged`) |

## Content-opaque
none (the two `align*` blocks and two `\[ \]` blocks are equation content; no figure, table or picture in the sample)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
