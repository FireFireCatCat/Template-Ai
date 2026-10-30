no

# 0046-classic-homework-template: Classic Homework Template

- Unverified: read from the source, not compiled.
- Source: Source/0046-classic-homework-template/ (origin: https://latextemplates.com/downloads/classic-homework-template.zip; licence: MIT)
- Kind: assignment
- Lib: v2
- Engine: pdfLaTeX-compatible (fancyhdr, extramarks, amsmath, amsthm, tikz, algorithm, algpseudocode: none needs XeLaTeX or LuaLaTeX)
- Look carried by: preamble (the zip is one `main.tex` on kernel `article`; everything that gives the template its look, the page, the running heads, the title block and the `homeworkProblem` environment, is in the sample's own preamble, main.tex:18-130)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex, 250 lines)

## Verdict
No. Nearly every part of the page maps to a lib way: kernel `article`, raw page lengths, `fancyhdr` with `extramarks`, kernel `\maketitle`, `amsmath`/`amsthm`, `algorithm`+`algpseudocode`, and a `figure` float. What defines the template is the zip-local `homeworkProblem` environment (main.tex:43-77), and it is not a composition of lib ways with parameters. It is hand-rolled counter code: an `\ifnum` test on an optional argument, a `\newcounter` that is stepped when the environment closes, and "Problem N" heading text and `\extramarks` strings computed from that counter. The `\part` redefinition (main.tex:111) adds a second counter-driven printed label. This is the rubric's "hand-rolled counters and conditionals that drive what is printed", so it is irreducible, and the `hf.extramarks` way covers only the mark primitive, not the logic that decides which marks to set. Borderline call, taken as `no` under "a wrong yes costs more": with every problem number known statically, an emitter could unroll each environment into `\section{Problem n}` plus fixed `\extramarks` calls, but then the numbering and continued-mark logic would live in the emitter, and no published way supplies it.

## Blockers
- `BESPOKE/preamble` `homeworkProblem` environment with `\enterProblemHeader`, `\exitProblemHeader`, counters `homeworkProblemCounter` and `partCounter` and the initial mark: optional-argument `\ifnum` counter override, `\stepcounter` at exit, and "Problem N", "Problem N (continued)", "Problem N continued on next page\ldots" strings generated from the counter and fed to `\extramarks` (main.tex:43-58, 68-77)
- `BESPOKE/preamble` `\renewcommand{\part}` replaced by a counter-driven "Part A, Part B..." label that discards its own argument (main.tex:111); defined but never called in the sample body

## Class setting
- Class: `class.article` options: none (main.tex:1)
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle`, `\section`, `\part` (redefined), `\pagebreak`, `figure` and `\caption`; no `abstract`, no `\tableofcontents`, no bibliography

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | no options (default 10pt, letter or a4 by distribution default) |
| page geometry | main.tex:18-23 | `page.setlength` | `\topmargin=-0.45in`, `\evensidemargin=0in`, `\oddsidemargin=0in`, `\textwidth=6.5in`, `\textheight=9.0in`, `\headsep=0.25in` |
| line spacing | main.tex:25 | `sp.linespread` | `\linespread{1.1}` |
| paragraph indent | main.tex:37 | `sp.lengths` | `\setlength\parindent{0pt}` |
| running header and footer | main.tex:3, 27-35 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\lhead{\hmwkAuthorName}`, `\chead{\hmwkClass (\hmwkClassInstructor \hmwkClassTime): \hmwkTitle}`, `\rhead{\firstxmark}`, `\lfoot{\lastxmark}`, `\cfoot{\thepage}`; `\headrulewidth` and `\footrulewidth` = 0.4pt |
| marks in header and footer fields | main.tex:4, 30-31, 44-51, 58 | `hf.extramarks` | `\usepackage{extramarks}`; `\extramarks{left}{right}` strings read back by `\firstxmark` and `\lastxmark` (the call sites sit inside the bespoke environment, see Bespoke code) |
| heading numbering depth | main.tex:54 | `num.secnumdepth` | `\setcounter{secnumdepth}{0}` (sections unnumbered; the number is printed by hand in the title text) |
| section heading | main.tex:72 | `head.kernel` | kernel `\section{Problem \arabic{homeworkProblemCounter}}`, default look, no `titlesec` |
| counters | main.tex:55-57, 70, 73, 111 | `num.counters` | `\newcounter{partCounter}`, `\newcounter{homeworkProblemCounter}`, `\setcounter`, `\stepcounter`, `\Alph`, `\arabic` (the logic using them is the blocker) |
| title block | main.tex:100-109, 134 | `front.maketitle` | `\title{...}` carries the whole cover layout, `\author{\hmwkAuthorName}`, `\date{}`, `\maketitle` (not a `titlepage` option, so the block sits on page 1) |
| title block spacing and sizes | main.tex:101-105 | `sp.manual-space` | `\vspace{2in}`, `\vspace{0.1in}`, `\vspace{3in}`, `\\` |
| title block font sizes | main.tex:103-104 | `font.size-commands` | `\normalsize`, `\small`, `\large` |
| title block and body emphasis | main.tex:102-104, 143 | `mark.kernel` | `\textmd`, `\textbf`, `\textit`, `\texttt` (main.tex:160 and others) |
| page breaks | main.tex:136, 216 | `pg.break` | `\pagebreak` |
| centred figure body | main.tex:169 | `sp.ragged` | `\centering` |
| math | main.tex:5, 148-151, 198 | `math.amsmath` | `amsmath`: `split` in `\[ \]`, `\text`, `\dfrac`; `\mathcal`, `\mathrm` in the macros at main.tex:121-130 |
| math fonts and symbols | main.tex:7 | `math.amssymb` | `\usepackage{amsfonts}`; `\leq`, `\geq`, `\gets`, `\lfloor` are kernel/amsmath |
| proof environment | main.tex:6, 221-236 | `thm.amsthm` | `amsthm` loaded with no options; only `proof` is used, no `\newtheorem`, no `\theoremstyle` |
| figure float | main.tex:168-183 | `fig.graphicx` | `figure[h]`; contains a `tikzpicture`, no `\includegraphics` |
| figure caption | main.tex:181, 212 | `cap.kernel` | kernel `\caption`, no `caption` package |
| label | main.tex:182 | `xref.kernel` | `\label{fig:dfa-ab}`; never referenced in the body |
| algorithm float | main.tex:9-10, 195-213 | `alg.algorithmicx` | `\usepackage[plain]{algorithm}` plus `algpseudocode`; `algorithm[H]` with `algorithmic[1]` (line numbers every line), `\Function` `\State` `\While` `\If` `\ElsIf` `\Else` `\Return`, `\caption`. The `[H]` specifier comes from the `float` package, which `algorithm` loads itself (published package source not read here) |
| TikZ libraries | main.tex:8, 12 | `art.tikz` | `tikz` with `automata,positioning`; used only inside the figure (content-opaque, below) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `homeworkProblem` environment (optional arg, `\ifnum` counter override, `\section`, `\setcounter{partCounter}{1}`, enter and exit hooks) | main.tex:68-77 | no (irreducible) | Hand-rolled counter and conditional driving printed text. The best-case static unrolling per problem n is `\section{Problem n}` plus `\extramarks{}{Problem n continued on next page\ldots}`, `\extramarks{Problem n (continued)}{...}` at entry and at exit, then `\extramarks{Problem n+1}{}` (`head.kernel`, `hf.extramarks`, `num.counters`). That moves the counting into the emitter and no published way does it, so it is not accepted as a reduction |
| `\enterProblemHeader`, `\exitProblemHeader` | main.tex:43-52 | no | Same blocker: they generate the mark strings from `\arabic{#1}` and step the counter (`\stepcounter{#1}`) |
| counters `partCounter`, `homeworkProblemCounter`, initial `\extramarks` call in the preamble | main.tex:55-58 | no | State held across environment instances; part of the same blocker |
| `\renewcommand{\part}[1]{...}` | main.tex:111 | no | Counter-driven letter label ("Part A", "Part B") that swallows its argument; a static "Part A" literal would again put the counting in the emitter. Unused in the sample body |
| `\hmwkTitle`, `\hmwkDueDate`, `\hmwkClass`, `\hmwkClassTime`, `\hmwkClassInstructor`, `\hmwkAuthorName` | main.tex:89-94 | yes | Plain string aliases (`\newcommand`); the emitter writes the literal text into the `hf.fancyhdr` fields and the `front.maketitle` block |
| `\alg` | main.tex:118 | yes | `\textsc{\bfseries \footnotesize #1}`: `mark.kernel` + `font.size-commands` alias |
| `\deriv`, `\dx`, `\bigO` | main.tex:121, 124, 130 | yes | Math notation aliases over `\frac`, `\mathrm`, `\mathcal` (`math.amsmath`); `\deriv` is not called, `\dx` and `\bigO` are |
| `\solution` | main.tex:127 | yes | `\textbf{\large Solution}` alias (`mark.kernel` + `font.size-commands`); not called, the body writes `\textbf{Solution}` |

## Content-opaque
- `tikzpicture` DFA diagram inside the figure float (main.tex:170-180, with `\usetikzlibrary{automata,positioning}` at main.tex:12): figure artwork, `art.tikz`, content and not template identity.

## Lib changes
- New ways proposed: none (every component has a lib v2 way; `hf.extramarks` already exists for `extramarks`)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
