yes

# 0278-bilingual-homework-template: Bilingual Homework Template

- Unverified: read from the source, not compiled.
- Source: Source/0278-bilingual-homework-template/ (origin: https://latextemplates.com/downloads/bilingual-homework.zip; licence: MIT)
- Kind: assignment
- Lib: v3
- Engine: needs XeLaTeX (`ctex` is loaded unconditionally, homework.cls:49; main.tex:16-18 and README.md say xelatex is required)
- Look carried by: zip-local (the look is defined in `homework.cls`, which is `\LoadClass{article}` plus packages, settings and two small macros; `main.tex` only sets four strings and writes the body)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
Every component maps to an existing lib way, and every piece of zip-local code (the class, the problem environment, the `\solution` macro, the helper macros, the three `\def` toggles) is a composition of lib ways with parameters. The one judgement call is `homeworkProblem` (homework.cls:141-155), which uses a hand-written counter and an optional-argument `\ifnum`. Its whole effect is a heading "Problem n" plus `\extramarks` strings, so it reduces to kernel counter commands or to literal numbers written by the emitter (reduction below). A stricter reading of "hand-rolled counters" in the rubric would make it `BESPOKE/class`. There is no artwork: `tikz` is only loaded, never drawn with.

## Blockers
none

## Class setting
- Class: `class.article`, no options. `homework.cls` is zip-local: main.tex:13-14 credits Yuzheng Cai (GitHub, MIT), the class file itself carries no author header (homework.cls:1-30), and the CTAN package named `homework` is a different class by Jinwen XU (one ctan.org/pkg/homework read; README.md:16-21 says the same). It loads the kernel class with `\LoadClass{article}` (homework.cls:28).
- Class-native vocabulary used: kernel article `\title` `\author` `\date` `\maketitle` (main.tex:37), `\section`; nothing else from article. The zip-local vocabulary `homeworkProblem`, `\solution`, `\hmwkTitle` `\hmwkDueDate` `\hmwkClass` `\hmwkAuthorName` is reduced below.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | homework.cls:28 | `class.article` | no options (article defaults) |
| page geometry | homework.cls:63-68 | `page.setlength` | topmargin=-0.45in, evensidemargin=0in, oddsidemargin=0in, textwidth=6.5in, textheight=9.0in, headsep=0.25in |
| line spacing | homework.cls:70 | `sp.linespread` | `\linespread{1.1}` |
| paragraph indent | homework.cls:94 | `sp.lengths` | `\parindent=0pt` (parskip left at the article default) |
| header and footer | homework.cls:35, 72-92 | `hf.fancyhdr` | `\pagestyle{fancy}`; lhead=author name, chead="class: title" (75-76); rhead=`\firstxmark` (86); lfoot=`\lastxmark` (87); cfoot=`\thepage` (89); headrulewidth=0.4pt, footrulewidth=0.4pt (91-92) |
| running marks | homework.cls:36, 86-87, 101-131 | `hf.extramarks` | `\extramarks{first}{last}` with "Problem n (continued)", "Problem n continued on next page\ldots", "Problem n" (101-121, 128) |
| no-break around marks | homework.cls:103-104, 113-115, 128 | `pg.break` | `\nobreak` before and after each `\extramarks` (kernel break-control family, as `\nopagebreak`; not `sp.penalties`, which is for penalty parameters) |
| section headings | homework.cls:147, 149 | `head.kernel` | `\section{Problem n}` with the article default look; no `\titleformat` |
| numbering depth | homework.cls:123 | `num.secnumdepth` | secnumdepth=0 (headings unnumbered, the text carries "Problem n") |
| problem counter | homework.cls:124-126, 143-144, 114, 118 | `num.counters` | `\newcounter{homeworkProblemCounter}`, `\setcounter{...}{1}`, `\stepcounter`, `\arabic`; `partCounter` is created (124) and set (151) but never read |
| problem wrapper spacing | homework.cls:145 | `sp.manual-space` | `\vspace{0.2in}` before each problem heading |
| "Solution" label | homework.cls:159-177; main.tex:46, 59, 74 | `mark.kernel` | `\textbf{\large Solution}` or `\textbf{\large Solution of (n)}`, with `\vspace{0.2in}` before and `\vspace{0.1in}` after |
| label size and spacing | homework.cls:163-175 | `font.size-commands` | `\large` |
| label spacing | homework.cls:161-175 | `sp.manual-space` | `\vspace{0.2in}`, `\vspace{0.1in}` |
| title block | homework.cls:189-237; main.tex:37 | `front.maketitle` | `\title{...}` holding class and title in `\huge\textbf`, "Due on date" in `\normalsize`, `\author{name}`, `\date{}` |
| title block spacing and sizes | homework.cls:191-205 | `sp.manual-space` | cover branch: `\vspace{3in}`, `\vspace{0.4in}` twice, `\vspace{2.4in}`; no-cover branch (215-229): `\vspace{0.05in}`, `\vspace{0.2in}` |
| title block fonts | homework.cls:193-197 | `font.size-commands` | `\huge`, `\normalsize` (`\Huge` in the Chinese branch, 199-203) |
| title block emphasis | homework.cls:193-195 | `mark.kernel` | `\textbf` |
| cover page break | main.tex:38-40 | `pg.break` | `\pagebreak` when `\hmwkCoverPage`=1 |
| Chinese text and fonts | homework.cls:49; main.tex:47-50, 65-67 | `lang.cjk` | `ctex` with no options (the default scheme and font set), XeLaTeX |
| maths | homework.cls:37; main.tex:61-64 | `math.amsmath` | `equation` with `\frac`, `\text{}` |
| maths symbols | homework.cls:39 | `math.amssymb` | `amsfonts` loaded, no options |
| bold maths | homework.cls:48 | `math.bm` | `bm` loaded, no options |
| helper maths macros | homework.cls:248-260 | `math.kernel` | `\deriv`, `\pderiv`, `\dx`, `\E` `\Var` `\Cov` `\Bias` as `\mathrm`/`\frac`/`\partial` aliases |
| helper text macro | homework.cls:245 | `mark.kernel` | `\alg` = `\textsc{\bfseries \footnotesize #1}` (also `font.size-commands`) |
| theorem package | homework.cls:38 | `thm.amsthm` | `amsthm` loaded; no `\newtheorem` in class or sample |
| caption and proof names | homework.cls:178-182 | `cap.kernel` | `\renewcommand{\figurename}{Figure}`, `\tablename` `Table`; `\proofname` `Proof` belongs to `thm.amsthm` (default-English reset after `ctex`) |
| lists | homework.cls:43 | `list.enumerate-pkg` | `enumerate` loaded; no list in the sample |
| algorithms | homework.cls:41-42 | `alg.algorithmicx` | `algorithm` + `algpseudocode` loaded; no algorithm in the sample |
| figures | homework.cls:47 | `fig.graphicx` | `graphicx` loaded; no figure in the sample |
| pictures | homework.cls:40, 56 | `art.tikz` | `tikz`, libraries `automata,positioning`; loaded for use in solutions, no picture in the sample (not template artwork) |
| colours | homework.cls:45, 267-271 | `color.xcolor` | `\definecolor` codeRed RGB 160,21,21; codeGreen 0,64,0; codeBlue 10,70,196; codeGrey rgb 0.5; backgroundGrey 248,248,248 |
| code listings | homework.cls:44, 272-296 | `code.listings` | `\lstset`: backgroundcolor, basicstyle=\footnotesize, breaklines=true, captionpos=bl, commentstyle, escapeinside={\%*}{*)}, frame=none, keepspaces, keywordstyle, numbers=left, numbersep=5pt, numberstyle=\tiny\color{codeGrey}, stringstyle, tabsize=2, showspaces/showstringspaces/showtabs=false |
| inline verbatim | main.tex:75-76 | `code.verbatim` | `\verb\|...\|` |
| citation | homework.cls:46; main.tex:72 | `bib.cite-pkg` | `cite` loaded, `\cite{LatexHomeworkTemplate}` |
| bibliography | main.tex:79-80; references.bib:1-8 | `bib.bibtex-bst` | `\bibliographystyle{abbrv}`, `\bibliography{references.bib}` (one `@misc` entry) |
| metadata strings | main.tex:31-34 | none (content) | `\hmwkTitle`, `\hmwkDueDate`, `\hmwkClass`, `\hmwkAuthorName` are plain strings; the emitter writes them straight into title and header fields |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `homework.cls` as a whole | homework.cls:1-296 | yes | `class.article` + the `\usepackage` list (35-49) + the settings above; no `\@startsection`, `\@maketitle` or output-routine code |
| toggles `\hmwkLanguage`, `\hmwkPageHeader`, `\hmwkCoverPage` and every `\if` on them | homework.cls:5-6, 12-13, 19-20, 72-88, 101-131, 146-149, 162-176, 178-182, 189-237; main.tex:38 | yes | compile-time constants, never changed while typesetting. The emitter picks one branch: this sample is E / 1 / 1. The C branch is the same ways with Chinese strings (`问题`, `解答`, `截止日期：`) and `\Huge`/`\vspace{0.3in}`; it needs `\hmwk*CN` strings that this sample does not define |
| `\enterProblemHeader`, `\exitProblemHeader` | homework.cls:101-121 | yes | `hf.extramarks` calls and `\nobreak` (`pg.break`) with `\arabic` of the counter; emitted inline around each problem |
| counter `homeworkProblemCounter` | homework.cls:125-126, 143-144, 114, 118 | yes (judgement call) | `num.counters` kernel commands (`\newcounter`, `\setcounter{...}{1}` in the preamble, `\setcounter` where a problem forces its number, `\stepcounter` at the end of each problem), or literal n written by the emitter. It is read only in the heading text and the mark strings, not in layout |
| counter `partCounter` | homework.cls:124, 151 | yes | dead: set to 1, never printed or tested; omit |
| environment `homeworkProblem[n]` | homework.cls:141-155 | yes | per problem: `\vspace{0.2in}` `\section{Problem n}` (`sp.manual-space`, `head.kernel`, `num.secnumdepth`), then `\nobreak\extramarks{}{Problem n continued on next page\ldots}\nobreak` and `\nobreak\extramarks{Problem n (continued)}{...}\nobreak` at the start; at the end `\nobreak\extramarks{Problem n (continued)}{...}\nobreak`, `\stepcounter`, `\nobreak\extramarks{Problem n+1}{}\nobreak`. Preamble: `\nobreak\extramarks{Problem 1}{}\nobreak` (homework.cls:127-128) |
| `\solution[n]` | homework.cls:159-177 | yes | alias: `\vspace{0.2in}\textbf{\large Solution}\vspace{0.1in}`, or `Solution of (n)` when a number is given; the emitter writes the chosen form per use |
| helper macros `\alg` `\deriv` `\pderiv` `\dx` `\E` `\Var` `\Cov` `\Bias` | homework.cls:245-260 | yes | `\newcommand` aliases over kernel maths and font commands |
| `\hmwk*` strings | main.tex:31-34 | yes | `\newcommand` strings; emitted as literal text in the title and header |
| body test `\if\hmwkCoverPage 1 \pagebreak \fi` | main.tex:38-40 | yes | with the toggle resolved: `\pagebreak` after `\maketitle` |
| `\lstset` block | homework.cls:272-296 | yes | one `code.listings` call; the keys are listed in the table |

## Content-opaque
none (the sample has no figure or table; the Chinese solution text, the equation and the `@misc` entry are content)

## Lib changes
- New ways proposed: none. Considered and not needed: a way for a named auto-numbered problem environment, since `head.kernel`, `num.counters` and `hf.extramarks` already compose it, and a macro that exists only in this zip would fail W1.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Engine and assets: no fonts or images are shipped. Chinese glyphs come from the font set `ctex` selects on the build machine, so a CJK font must be installed (missing asset, not a blocker). The README builds with `xelatex`, `bibtex`, `xelatex`, `xelatex` (README.md:33-36), a normal TeX toolchain.
- Loaded but unused in the sample (in scope because the class loads them): `tikz`, `algorithm`, `algpseudocode`, `enumerate`, `graphicx`, `amsthm`, `bm`.
- Unread: nothing. Both `.tex` and `.cls` were read in full; `references.bib` has one entry.
- No text addressed to an AI was found in the zip.
