yes

# 0838-fnspe: fnspe (math-notation macro package for FNSPE CTU students, with its documentation sample)

- Unverified: read from the source, not compiled.
- Source: Source/0838-fnspe/ (origin: https://mirrors.ctan.org/macros/latex/contrib/fnspe.zip; licence: LPPL)
- Kind: misc (a package manual in `article`; the manifest hint `thesis` is wrong)
- Lib: v6
- Engine: pdfLaTeX-compatible
- Look carried by: mixed (`article` sets page, headings and lists; the CTAN package `fnspe.sty`, shipped in the zip, sets the math macros, their option-chosen notation and the `listings` look)
- Class origin: tex-distribution-unbundled
- Main file: fnspe.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (fnspe.sty, 218 lines, read in full; `fnspe.pdf` is the binary output of the sample and was not opened)

## Verdict
`yes`. The sample is `\documentclass{article}` plus `\usepackage[arrowtensor,oldcomplex]{fnspe}` and `\usepackage{hyperref}` (fnspe.tex:11-13), and the body is kernel sectioning, lists, `equation*` and `lstlisting`; the sample defines no macro of its own (a grep for `\newcommand`, `\def`, `\renewcommand` in fnspe.tex finds none). The only non-kernel code is `fnspe.sty`, and that is a **published** package: the zip is its own CTAN release (manifest url), and ctan.org/pkg/fnspe (read) shows v1.2a, LPPL, in TeX Live and MiKTeX. It is chosen by boolean options (fnspe.sty:30-77) and prints through `\usepackage` plus macro calls, so it is the parameter of `math.physics` ("another math-notation package is the parameter"), as `tensind` was merged there at v6. No new way is needed.
Sensitivity, stated so a reviewer can re-read it under another definition: if `fnspe.sty` were treated as zip-local instead, two parts would be irreducible and the answer would be `no`: `\xvec` (a measure-and-draw TikZ arrow, fnspe.sty:81-105) and the active-underscore subscript parser built on `xstring` (fnspe.sty:122-130). Everything else in the file reduces to aliases of lib ways. I did not take that reading because rubric W1 counts a CTAN package as published.

## Blockers
none

## Class setting
- Class: `class.article` options: none (fnspe.tex:11)
- Class-native vocabulary used: `\section*` `\subsection*` `\subsubsection*`, `enumerate`, `itemize` (fnspe.tex:15-47). No `\maketitle`, no `abstract`, no `\tableofcontents` in the sample.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | fnspe.tex:11 | `class.article` | no options, so the class defaults apply |
| page geometry | fnspe.tex:11 | `page.class-options` | none set; class defaults only (no `geometry`, no `\setlength` of text width) |
| sectioning | fnspe.tex:15, 43, 44, 47 | `head.kernel` | starred `\section*`, `\subsection*`, `\subsubsection*`, no renewals, no numbering |
| lists | fnspe.tex:18-41, 54-67 | `list.kernel` | `enumerate` containing `itemize`; `itemize` holding `equation*` blocks |
| inline marks | fnspe.tex:21, 34, 38, 52 | `mark.kernel` | `\texttt`, `\textbf`, `\textit` (kernel font switches); `\LaTeX{}` logo at fnspe.tex:34 |
| size switch | fnspe.tex:342; fnspe.sty:111 | `font.size-commands` | `\tiny` in the def-text formula; `\scriptsize` in the listings `basicstyle` |
| paragraph control | fnspe.tex:446, 507 | `sp.lengths` | `\noindent` (paragraph-indent switch, the kernel companion of `\parindent`); the nearest lib home, not stretched further |
| display maths | fnspe.tex:56, 60, 342 | `math.amsmath` | `equation*` environments; `\overset` at fnspe.sty:139; amsmath loaded by the package at fnspe.sty:17 |
| math symbols | fnspe.sty:18, 21, 168-173 | `math.amssymb` | `amsfonts` + `amssymb`: `\mathbb{R,C,Z,Q,N}` at fnspe.sty:168-172 |
| math alphabets | fnspe.sty:15, 19, 216 | `math.bm` | `bm` (`\bm{\mathrm{..}}` in the `isotensor` branch, fnspe.sty:136, 139); `mathrsfs` `\mathscr{C}` at fnspe.sty:216 |
| paired delimiters | fnspe.sty:27, 204-205, 208 | `math.mathtools` | `\DeclarePairedDelimiter` for `\ceil` `\floor`; `\mathclap` in the `deftext` `\df` |
| math notation package | fnspe.tex:12; fnspe.sty:14-218 | `math.physics` | package `fnspe` with options `arrowtensor,oldcomplex`; it loads `physics` itself (fnspe.sty:24, `\dv` at fnspe.sty:143, the sample calls `\grad` at fnspe.tex:433, `\div` at 443, `\divisionsymbol` at 452, `\rot` (which is `\curl`, sty:177) at 462, `\laplacian` at 482; `\curl` at 467 sits inside a listing). Macros the sample calls: `\ci` `\oi` `\rci` `\lci` (sty:145-151), `\vec` `\mat` (sty:133-139), `\allset` `\allsetzero` `\cclass` `\ccof` `\ccinf` (sty:213-218), `\Re` `\Im` (sty:189-199), `\floor` `\ceil`, `\df` (sty:207-211), `\realn` etc. (sty:168-173), `\rot` `\lapl` (sty:177-180), `\degree` `\varun` `\unit` `\expv` (sty:159-184), `\hlf` `\oover` (sty:157-166), `\hem` `\htem` `\impem` (sty:162-175) |
| manual spacing inside the package | fnspe.sty:94, 162-163 | `sp.manual-space` | `\hspace{#1em}` for `\hem` `\htwoem`; `\raisebox` `\rlap` `\kern` inside `\xvec` |
| colour | fnspe.sty:22, 114-115 | `color.xcolor` | `xcolor` loaded; `\color{blue}` and `\color{magenta}` used by the listings keys |
| code listing | fnspe.tex:49-51 and 45 more `lstlisting` blocks (46 in all); fnspe.sty:23, 107-116 | `code.listings` | `\lstset{language=[LaTeX]TeX, breaklines=true, basicstyle=\tt\scriptsize, morekeywords=[28]{ci,oi,lci,...}, keywordstyle=\color{blue}, identifierstyle=\color{magenta}}`; body `lstlisting` environment with the code text as content |
| theorems | fnspe.sty:20 | `thm.amsthm` | `amsthm` loaded and never called (no `\newtheorem` in the sample); recorded because the package loads it unconditionally |
| vector arrow drawing | fnspe.sty:25, 94-103; used via fnspe.tex:163, 194 | `art.tikz` | `tikz` loaded; under option `arrowtensor` `\vec{x}` becomes `\xvec{x}` (fnspe.sty:133-134), a one-line TikZ arrow sized from the argument (`\mat` takes the other branch, `\overset{\leftrightarrow}`, fnspe.sty:139). A math glyph made inside the published package, not a template banner or frame; the sample draws no picture itself |
| hyperlinks | fnspe.tex:13, 421 | `meta.hyperref` | `\usepackage{hyperref}` with no options; one `\href{url}{here}` (same package family) |

Absent from the sample, so no row: title block, abstract, header/footer (article default), contents, floats, tables, captions, bibliography, index, cross-references, language, fonts beyond the Computer Modern default.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| sample-level definitions | fnspe.tex | none exist | the sample defines nothing |
| `fnspe.sty` as a whole | fnspe.sty:11-218 | not bespoke: published (CTAN, TeX Live, MiKTeX, LPPL) | `\usepackage[arrowtensor,oldcomplex]{fnspe}`; emitter writes the option list and calls the macros |
| boolean option switches `\if@..` | fnspe.sty:29-79 | internal to the published package | ten options `isointerval` `isoointerval` `fnspeinterval` `isotensor` `undertensor` `arrowtensor` `oldcomplex` `isocomplex` `deftext` `defcolon` (booleans, W2); `isointerval`, `isotensor`, `isocomplex`, `defcolon` set a flag that no conditional reads, they are the defaults |
| interval, set, number-set, unit, shortcut aliases | fnspe.sty:145-218 | reducible even if zip-local | `\newcommand` wrappers over `\left..\right`, `\frac`, `\mathbb`, `\mathrm`, `\hspace` and physics `\dv` `\curl`: `math.amsmath` `math.amssymb` `math.physics` `sp.manual-space` |
| `\Re` `\Im` redefinition | fnspe.sty:189-199 | reducible | `\renewcommand` to `\mathfrak{Re}` (option `oldcomplex`) or `\mathrm{Re}\;`: `math.amssymb` |
| `\df` | fnspe.sty:207-211 | reducible | `\stackrel{\mathclap{\normalfont\mbox{\tiny def.}}}{=}` or `\mbox{:=}`: `math.mathtools` `font.size-commands` |
| `\lstset` block | fnspe.sty:107-116 | reducible | one `\lstset` call: `code.listings` + `color.xcolor` |
| `\xvec` (measure and draw arrow) | fnspe.sty:81-105 | irreducible only under the zip-local reading; inside a published package it is not emitted | would need `\settoheight` `\settowidth` boxes and a `tikzpicture` (`art.tikz`); not reproducible from lib ways with parameters. See the sensitivity note in Verdict |
| active `_` subscript parser | fnspe.sty:122-130 | irreducible only under the zip-local reading | catcode change of `_` and `\IfCharInString`/`\StrBehind` from `xstring` split `A_{!word}` into a roman subscript; package-internal. `xstring` and `substr` (sty:14, 26) are macro-body helpers with no printed effect or node to wrap, considered and not proposed (as `sp.xspace` was rejected at v4) |

## Content-opaque
none. (The `\vec` arrow under `arrowtensor` is a TikZ glyph made by the package, fnspe.sty:94-103; the listing texts and equations in fnspe.tex are content.)

## Lib changes
- New ways proposed: none. The package maps to `math.physics` (a math-notation package is the parameter, as for `tensind`); considered: a separate fnspe way, dropped because the `math.physics` line already admits it.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
