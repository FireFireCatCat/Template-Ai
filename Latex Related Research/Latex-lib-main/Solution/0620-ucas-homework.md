yes

# 0620-ucas-homework: UCAS Homework (homework.sty over article)

- Unverified: read from the source, not compiled.
- Source: Source/0620-ucas-homework/ (origin: https://latextemplates.com/downloads/ucas-homework.zip; licence: MIT)
- Kind: assignment
- Lib: v5
- Engine: needs XeLaTeX (`fontspec` `\setmonofont` at homework.sty:64, `ctex` with `UTF8` at homework.sty:15; README.md:18-21 says xelatex is required)
- Look carried by: zip-local (homework.sty loads the packages and sets page, header/footer and the problem environment; main.tex only fills strings and the title block)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
yes. The zip is `article` plus one zip-local `homework.sty` (no `\ProvidesPackage`, no `.cls`). That file only loads published packages, assigns kernel lengths, sets `fancyhdr` fields, and defines `\newcommand` aliases and one `\newenvironment`, `homeworkProblem`. The environment is a counter-numbered `\section` plus `\extramarks` calls, so an emitter can write it with the problem number resolved at emit time and no copied macro logic. There is no artwork (`tikz` is loaded but nothing is drawn), no external tool, and every component maps to a lib way. Not compiled: the `ctex` defaults (heading look, caption names) were not read.

## Blockers
none

## Class setting
- Class: `class.article` options: none (main.tex:21 `\documentclass{article}`)
- Class-native vocabulary used: `\title` `\author` `\date{}` `\maketitle` (main.tex:27-51), `\section` (via the environment, homework.sty:94), `equation`, `enumerate`; no `abstract`, no `\tableofcontents`, no bibliography in the sample.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:21 | `class.article` | no options (default size and paper) |
| page geometry | homework.sty:29-34 | `page.setlength` | `\topmargin=-0.45in`, `\evensidemargin=0in`, `\oddsidemargin=0in`, `\textwidth=6.5in`, `\textheight=9.0in`, `\headsep=0.25in` |
| line spacing | homework.sty:36 | `sp.linespread` | `\linespread{1.1}` |
| paragraph indent | homework.sty:41-42 | `sp.lengths` | `\setlength\parindent{0pt}` then `\setlength{\parindent}{2em}` (last one wins, 2em) |
| indent after headings | homework.sty:21 | `sp.indentfirst` | load-only, no options |
| header and footer | homework.sty:6, 38-39, 47-54 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\headrulewidth` 0.4pt, `\footrulewidth` 0.4pt; `\lhead{\hmwkClass\ : \hmwkTitle}`, `\rhead{\hmwkAuthorName}`, `\cfoot{\thepage}` (strings from main.tex:35-36, 40; `\chead`, `\rhead{\firstxmark}`, `\lfoot{\lastxmark}` are commented out, homework.sty:50-53) |
| running marks | homework.sty:7, 72-80, 86 | `hf.extramarks` | `\extramarks{..}{Problem N continued on next page\ldots}` pairs at problem start and end; no head or foot field reads them (`\firstxmark`, `\lastxmark` commented out at :52-53), so no printed effect in this sample |
| CJK support | homework.sty:15 | `lang.cjk` | `ctex` with option `UTF8`; Chinese strings at homework.sty:107-112, main.tex:35 |
| fonts | homework.sty:20, 64 | `font.fontspec` | `fontspec` loaded; `\setmonofont{DejaVu Sans Mono}` (patched from Consolas, :57-63); no main or sans font set; the font is not shipped |
| math | homework.sty:8, 10 | `math.amsmath`, `math.amssymb` | `amsmath`, `amsfonts` load-only, no options |
| theorems | homework.sty:9 | `thm.amsthm` | `amsthm` load-only; no `\newtheorem` or `\theoremstyle` anywhere in the zip |
| drawing package | homework.sty:11, 23 | `art.tikz` | load-only: `tikz`, `\usetikzlibrary{automata,positioning}`; no picture in main.tex, so not template artwork |
| algorithms | homework.sty:12-14, 148-149; main.tex:95-105 | `alg.algorithmicx` | `algorithm`, `algorithmicx`, `algpseudocode`; `\algorithmicrequire` set to `\textbf{Input:}` and `\algorithmicensure` to `\textbf{Output:}`; body `algorithm` float with `algorithmic[1]`, `\If` `\State` `\EndIf` |
| algorithm caption | main.tex:96 | `cap.kernel` | `\caption{MergeSort($A$, $p$, $r$)}` inside the `algorithm` float |
| float package | homework.sty:17 | `fig.float` | load-only (no `[H]` or `\newfloat` used) |
| table helper package | homework.sty:16 | `tbl.multirow` | `multirow` load-only |
| table cell helper | homework.sty:142 | `tbl.tabular` | `\tabincell` alias for `tabular{@{}#1@{}}`; defined, not used in the sample |
| lists | homework.sty:18; main.tex:57-61, 65-72 | `list.enumitem`, `list.kernel` | `enumitem` load-only, no `\setlist`; body uses plain `enumerate` with default labels |
| code blocks | homework.sty:19 | `code.listings` | `listings` load-only; no `\lstset` or `\lstdefinestyle`; not used in the sample |
| section numbering | homework.sty:82 | `num.secnumdepth` | `\setcounter{secnumdepth}{0}` |
| counters | homework.sty:83-85 | `num.counters` | `\newcounter{partCounter}`, `\newcounter{homeworkProblemCounter}`, `\setcounter{homeworkProblemCounter}{1}` |
| problem heading | homework.sty:94 (inside :90-99) | `head.kernel` | `\section{Problem N}`, unnumbered because secnumdepth is 0; look from `article` and `ctex` defaults (not read) |
| lettered part heading | main.tex:47 | `head.kernel`, `num.counters` | `\renewcommand{\part}[1]{\textbf{\large Part \Alph{partCounter}}\stepcounter{partCounter}\\}` (ignores its argument; not called in the sample) |
| title block | main.tex:27-33, 43-45, 51 | `front.maketitle` | `\title{...}` with `\\` lines, `\author{\hmwkAuthorName \\ \hmwkAuthorStuID}`, `\date{}`, `\maketitle` |
| title text and spacing | main.tex:28-32 | `mark.kernel`, `font.size-commands`, `sp.manual-space` | `\textmd` `\textbf` `\textit`; `\normalsize` `\small` `\large`; `\vspace{0.1in}` twice, `\vspace{1in}` |
| Solution label | homework.sty:130; main.tex:63, 79, 107 | `mark.kernel`, `font.size-commands` | `\textbf{\large Solution}` as its own paragraph |
| algorithm helper | homework.sty:118 | `mark.kernel`, `font.size-commands` | `\alg` = `\textsc{\bfseries \footnotesize #1}`; defined, not used |
| display maths | main.tex:84-86 | `math.amsmath` | `equation` environment (equation text is content) |
| math shorthands | homework.sty:121-136 | `math.amsmath` | `\deriv` `\pderiv` `\dx` `\E` `\Var` `\Cov` `\Bias` aliases of `\frac`, `\mathrm`, `\partial`; defined, not used in the sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `homework.sty` as a whole | homework.sty:1-150 | yes | Only `\usepackage` of published packages (no options except `UTF8` on `ctex`), kernel length assignments, `fancyhdr` fields and `\newcommand` aliases; rows above |
| `homeworkProblem` environment | homework.sty:90-99 | yes | Per problem node write `\section{Problem N}`, the `\extramarks` pairs of :72-73 after it and those of :77, :79 before the next one, with N known at emit time; the optional-argument test `\ifnum#1>0` only selects an explicit number, which the emitter resolves statically. Ways: `head.kernel`, `hf.extramarks` |
| `\enterProblemHeader`, `\exitProblemHeader` | homework.sty:71-80 | yes | Inline expansion of `\nobreak\extramarks{..}{..}\nobreak` with literal strings and numbers |
| counters `partCounter`, `homeworkProblemCounter` | homework.sty:83-85, 92, 95, 78 | yes | Plain kernel counters (`num.counters`); the emitter replaces the printed values by literals ("Problem 1", "Part A") |
| preamble mark call | homework.sty:86 | yes | One `\extramarks{Problem 1}{}` line; no head or foot field reads it |
| `\hmwk*` string macros | homework.sty:107-114; main.tex:35-41 | yes | `\newcommand` and `\renewcommand` aliases of text; expand the final values into `\lhead`, `\rhead`, `\title`, `\author` |
| `\solution`, `\alg`, `\tabincell` | homework.sty:130, 118, 142 | yes | Aliases of `\textbf`, `\large`, `\textsc`, `\footnotesize`, `tabular` |
| `\deriv`, `\pderiv`, `\dx`, `\E`, `\Var`, `\Cov`, `\Bias` | homework.sty:121-136 | yes | Aliases of `\frac`, `\mathrm`, `\partial`; content macros, unused in the sample |
| `\renewcommand{\part}` | main.tex:47 | yes | Fixed text "Part A", "Part B" by letter; the macro takes #1 and never prints it |
| `\renewcommand{\algorithmicrequire}`, `{\algorithmicensure}` | homework.sty:148-149 | yes | Parameters of `alg.algorithmicx` (string values) |

Origin check: the zip's `homework.sty` has no `\ProvidesPackage` and is a preamble file adapted from Josh Davis's template, and README.md:13-16 and main.tex:6-7 say it is not on CTAN (README.md:1-5 credits the adaptation). One read of https://ctan.org/pkg/homework shows a CTAN `homework` that is a class by Jinwen XU, a different artefact, so the zip's file is treated as zip-local (not published) and reduced as above. The sample's `\usepackage{homework}` (main.tex:22) loads the zip's copy.

## Content-opaque
none (the `algorithmic` body at main.tex:98-104 and the equations are held by `alg.algorithmicx` and `math.amsmath`; no TikZ picture is drawn)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes: `Get-Content` counts 140 lines in homework.sty and 114 in main.tex; the line numbers cited here are the Read and ripgrep numbers (homework.sty 150 with a final blank line, main.tex 114). Missing assets: DejaVu Sans Mono is not shipped (TeX Live and most systems carry it).
