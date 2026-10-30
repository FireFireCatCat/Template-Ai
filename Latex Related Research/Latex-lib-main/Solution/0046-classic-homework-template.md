yes

# 0046-classic-homework-template: Classic Homework Template

- Unverified: read from the source, not compiled.
- Source: Source/0046-classic-homework-template/ (origin: https://latextemplates.com/downloads/classic-homework-template.zip; licence: MIT)
- Kind: assignment
- Lib: v1
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (one file, `main.tex`; no zip-local class or style. The look is the preamble at main.tex:18-130 plus the `homeworkProblem` environment at main.tex:68-77)
- Class origin: tex-distribution-unbundled (`article`, kernel class, not in the zip; source not read)
- Main file: main.tex (other samples: none)
- Read: main yes (all 250 lines), zip-local classes and styles none present (the zip is one file, `main.tex`, 250 lines; no .cls/.sty/.def/.cfg/.clo/.bst)

## Verdict
`yes`, on one decision that a stricter reader could flip. The page and look are plain published pieces: `article`, raw margin lengths, `fancyhdr`, kernel `\section` with `secnumdepth=0`, `amsmath`/`amsthm`, `algorithm`+`algpseudocode`, and a TikZ figure that is content. The template's one distinctive part is the zip-local `homeworkProblem` environment (main.tex:68-77): it only steps two counters and writes `\section` and `\extramarks` calls. All of it depends on document order alone, never on pagination, so an emitter can fold it to literal `\section{Problem k}` and `\nobreak\extramarks{...}{...}\nobreak` lines with no copied macro logic (reduction under "Bespoke code"). The page-dependent part (the "(continued)" and "continued on next page" marks) lives entirely in the published `extramarks` package, proposed here as `hf.extramarks`. The decision that could flip: if counters plus `\ifnum` that decide printed text are read as irreducible whatever their inputs, this becomes `no` (`BESPOKE/preamble`). The rubric's closing test (could an emitter write it with no zip-local macro logic) is met, so `yes`. The W1 evidence for `extramarks` could not be fetched (see Lib changes).

## Blockers
none

## Class setting
- Class: `class.article` options: none (main.tex:1 `\documentclass{article}`; 10pt, letter paper by default)
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (main.tex:100-109, 134), `\section` (main.tex:72, inside the environment), `\part` is redefined (main.tex:111) but not used in the body. No `abstract`, `\chapter`, `\tableofcontents`, `\bibliography`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | no options |
| page geometry | main.tex:18-23 | `page.setlength` | `\topmargin=-0.45in`, `\evensidemargin=0in`, `\oddsidemargin=0in`, `\textwidth=6.5in`, `\textheight=9.0in`, `\headsep=0.25in` |
| line spacing | main.tex:25 | `sp.linespread` | `\linespread{1.1}` |
| paragraph indent | main.tex:37 | `sp.lengths` | `\setlength\parindent{0pt}`; `\parskip` left at the class default |
| header and footer | main.tex:3, 27-35 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\lhead{\hmwkAuthorName}`; `\chead{\hmwkClass\ (\hmwkClassInstructor\ \hmwkClassTime): \hmwkTitle}`; `\rhead{\firstxmark}`; `\lfoot{\lastxmark}`; `\cfoot{\thepage}`; `\headrulewidth` and `\footrulewidth` both `0.4pt` via `\renewcommand`; `\rfoot` left at the fancy default |
| running marks | main.tex:4, 30-31, 43-52, 58 | `hf.extramarks` | `\usepackage{extramarks}`; `\firstxmark` in `\rhead`, `\lastxmark` in `\lfoot`; body wrappers `\extramarks{<left mark>}{<right mark>}` with plain strings, e.g. `{Problem 1 (continued)}{Problem 1 continued on next page\ldots}` |
| mark placement | main.tex:44-45, 49, 51, 58 | `pg.break` | kernel break control `\nobreak` (TeX `\penalty10000`) around each `\extramarks`; same kernel family as `\pagebreak`, but no lib line names `\nobreak` itself, so this is the nearest home |
| section numbering depth | main.tex:54 | `num.secnumdepth` | `\setcounter{secnumdepth}{0}` |
| counters | main.tex:50, 55-57, 73, 111 | `num.counters` | `\newcounter{partCounter}`, `\newcounter{homeworkProblemCounter}`, `\setcounter{homeworkProblemCounter}{1}`, `\stepcounter`, `\arabic`, `\Alph` |
| problem headings | main.tex:72 | `head.kernel` | `\section{Problem <n>}`, unnumbered by `secnumdepth=0`, default `article` section look (no `titlesec`); the words "Problem n" are the heading text |
| problem block | main.tex:68-77, 138-248 | `head.kernel`, `hf.extramarks`, `num.counters` | composition of the three ways; see "Bespoke code" for the folded form |
| `\part` relabel | main.tex:111 | `head.kernel` | `\renewcommand{\part}[1]{\textbf{\large Part \Alph{partCounter}}\stepcounter{partCounter}\\}`; drops its argument; no use in the body; also touches `mark.kernel`, `font.size-commands`, `sp.manual-space`, `num.counters` |
| title block | main.tex:100-109, 134 | `front.maketitle` | `\title{...}` holding `\vspace{2in}`, `\textmd{\textbf{...}}\\`, `\normalsize\vspace{0.1in}\small{Due ...}\\`, `\vspace{0.1in}\large{\textit{...}}`, `\vspace{3in}`; `\author{\hmwkAuthorName}`; `\date{}`; `\maketitle` |
| title spacing and sizes | main.tex:101-105 | `sp.manual-space`, `font.size-commands`, `mark.kernel` | `\vspace{2in}`/`{0.1in}`/`{3in}`, `\\`; `\normalsize` `\small` `\large`; `\textmd` `\textbf` `\textit` |
| page breaks | main.tex:136, 216 | `pg.break` | `\pagebreak` after the title and before problem 4 |
| inline emphasis | main.tex:143, 160, 162, 222, 225 | `mark.kernel` | `\textbf`, `\texttt` |
| math | main.tex:5, 7, 139-155, 219-247 | `math.amsmath`, `math.amssymb` | `amsmath` (`split` at 148, `\dfrac` at 219, `\text` at 198, `\[ \]` and `\( \)` display and inline maths); `amsfonts` loaded at main.tex:7 |
| proof | main.tex:6, 221-236 | `thm.amsthm` | `amsthm` `proof` environment with default style; no `\newtheorem` or `\theoremstyle` |
| algorithm float | main.tex:9-10, 195-213 | `alg.algorithmicx` | `\usepackage[plain]{algorithm}`; `\usepackage{algpseudocode}`; `\begin{algorithm}[H]` (placement `H` comes with the `algorithm` package's float support); `\begin{algorithmic}[1]` (number every line); `\Function`, `\State`, `\While`, `\If`, `\ElsIf`, `\Else`, `\EndIf`, `\EndWhile`, `\EndFunction`, `\Return` |
| algorithm caption | main.tex:212 | `cap.kernel` | `\caption{Binary search over a sorted array}` |
| figure float | main.tex:168-183 | `fig.graphicx` | `figure[h]`, `\centering` around the tikzpicture (no `\includegraphics`) |
| figure caption and label | main.tex:181-182 | `cap.kernel`, `xref.kernel` | `\caption{...}`, `\label{fig:dfa-ab}` (not referenced elsewhere) |
| figure picture | main.tex:8, 12, 170-180 | `art.tikz` | content only, see Content-opaque |

Not defined by the zip, so no row: fonts (Computer Modern default, no font package), colours, language, hyperref, lists, tables, code, bibliography, index, table of contents.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\hmwkTitle`, `\hmwkDueDate`, `\hmwkClass`, `\hmwkClassTime`, `\hmwkClassInstructor`, `\hmwkAuthorName` | main.tex:89-94 | yes | String aliases. Inline their text into `\lhead`, `\chead`, `\title`, `\author` (`front.maketitle`, `hf.fancyhdr`). |
| counters `partCounter`, `homeworkProblemCounter` | main.tex:55-57 | yes | Kernel counters (`num.counters`). Their values depend only on the order of problems in the document, so the emitter computes them and writes the numbers as literal text. |
| `\enterProblemHeader{#1}`, `\exitProblemHeader{#1}` | main.tex:43-52 | yes | Only `\nobreak\extramarks{..}{..}\nobreak` with `\arabic` of a counter, plus one `\stepcounter`. Fold per problem k (below). |
| initial mark in the preamble | main.tex:58 | yes | Literal `\nobreak\extramarks{Problem 1}{}\nobreak{}` before `\begin{document}`. |
| `homeworkProblem` environment with optional argument `[#1]` default `-1`, and `\ifnum#1>0` | main.tex:68-77 | yes | Folded form, no macro logic in the output. For a problem numbered k: START `\section{Problem k}` then `\nobreak\extramarks{}{Problem k continued on next page\ldots}\nobreak{}` then `\nobreak\extramarks{Problem k (continued)}{Problem k continued on next page\ldots}\nobreak{}`; END `\nobreak\extramarks{Problem k (continued)}{Problem k continued on next page\ldots}\nobreak{}` then `\nobreak\extramarks{Problem k+1}{}\nobreak{}`. The `\ifnum` only sets k when an explicit number is given (main.tex:240 `[7]` gives k=7, and the next mark is "Problem 8"); the emitter knows that when it writes the node. `\setcounter{partCounter}{1}` (main.tex:73) only feeds `\part`, which the body does not use. The pagination-dependent part is resolved inside the published `extramarks` package at shipout. |
| `\part` redefinition | main.tex:111 | yes | Unused. If a `\part` appears, write the literal `\textbf{\large Part A}\\` with the letter computed by the emitter (counter resets to 1 at each problem start). |
| `\alg{#1}` | main.tex:118 | yes | `\textsc{\bfseries \footnotesize #1}`: `mark.kernel` plus `font.size-commands`; inline at main.tex:190. |
| `\deriv`, `\dx`, `\bigO` | main.tex:121, 124, 130 | yes | Math aliases over `\frac`, `\mathrm`, `\mathcal` (`math.amsmath`); inline at main.tex:139, 154, 241, 246. `\deriv` has no use. |
| `\solution` | main.tex:127 | yes | `\textbf{\large Solution}` alias, unused (the body writes `\textbf{Solution}` by hand). |

No `\def`, `\let`, `\newif`, output routine, `\halign`, expl3 or Lua in the file (grep of main.tex found only `\newcommand`, `\renewcommand`, `\newenvironment`, `\newcounter`, and the one `\ifnum`).

## Content-opaque
- TikZ automaton drawing inside `figure[h]` with caption (main.tex:170-180; `\usetikzlibrary{automata,positioning}` at main.tex:12). It is figure content, not a page frame or banner.
- The pseudocode text, the math, the proof text and the problem statements are content.

## Lib changes
- New ways proposed: `hf.extramarks` `extramarks` package (`\extramarks{left}{right}`, `\firstxmark` `\lastxmark` and the other `\...xmark` readers), pdfLaTeX. W1: believed published (in TeX Live; CTAN `macros/latex/contrib/extramarks`, Piet van Oostrum), but NOT confirmed here: all three allowed CTAN reads (`/pkg/extramarks` twice, once the JSON form) returned HTTP 404, and there is no local TeX tree to check, so this rests on memory and is Unverified. W2: behaviour is chosen by two plain strings per call and no options. W3: serves any "text of the first or last mark on this page" running head or foot, not one document. W4: a preamble `\usepackage{extramarks}`, the `\firstxmark`/`\lastxmark` calls inside `hf.fancyhdr` fields, and a body wrapper `\extramarks{..}{..}` around a node. Nearest existing lines are `hf.titleps` (marks and running heads) and `hf.pagestyle-kernel` (`\markboth`); neither names this package.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
