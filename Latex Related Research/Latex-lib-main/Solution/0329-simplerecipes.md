yes

# 0329-simplerecipes: simpleRecipes

- Unverified: read from the source, not compiled.
- Source: Source/0329-simplerecipes/ (origin: https://latextemplates.com/downloads/simple-recipes-latex.zip; licence: not established, manifest says UNKNOWN and README.md:5 says the upstream licence was not exposed)
- Kind: misc (a page of recipe cards)
- Lib: v3
- Engine: pdfLaTeX-compatible (T1 plus `lmodern`, main.tex:3-4; no fontspec, unicode-math or luacode anywhere)
- Look carried by: preamble (kernel `article` carries nothing; the sample's own preamble sets geometry, colours, list spacing and one `\newcommand`, `\simpleRecipe`, that wraps kernel boxes, main.tex:1-10; the zip ships no .cls, .sty or other style file)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; README.md is two sentences of prose, no code)
- Read: main yes (16 lines, all of it), zip-local classes and styles none present

## Verdict
The look is a kernel `article` page plus six published packages and one four-argument `\newcommand`, `\simpleRecipe` (main.tex:10). That macro holds no conditional, counter, box algorithm or kernel redefinition: its whole effect is `\fcolorbox` around a `minipage` that holds a coloured heading row, a coloured `\rule`, two bold labels and the two arguments. Every piece maps to an existing lib way, so an emitter can print the same wrapper inline for each recipe (or keep the macro as a preamble line). There is no artwork, no external tool and no unmapped component, so the answer is `yes`.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt`, `a4paper` (main.tex:1). The source of the class is the LaTeX base distribution and was not read.
- Class-native vocabulary used: none. The sample never calls `\title`, `\maketitle`, `\section`, `abstract` or `\bibliography`; the title is hand-set in a `center` environment (main.tex:12).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 11pt |
| paper size | main.tex:1 | `page.class-options` | a4paper |
| page geometry | main.tex:2 | `page.geometry` | margin=18mm |
| font encoding | main.tex:3 | `font.fontenc-t1` | T1 (`\textdegree` at main.tex:13 is a textcomp symbol, content) |
| text and sans family | main.tex:4, 10, 12 | `font.lmodern` | Latin Modern; the sans switch below picks Latin Modern Sans |
| colour declarations | main.tex:5, 9 | `color.xcolor` | `\definecolor` HTML: blueberry 3F5873, apricot D58A55, cream FFF8EC |
| table package loaded, never used | main.tex:6 | `tbl.tabularx` | no option; no `tabularx` environment appears in the sample (a load-only line, not a table in the sample) |
| list spacing | main.tex:7-8 | `list.enumitem` | `\setlist{nosep,leftmargin=*}` |
| page style | main.tex:8 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no header, footer or page number) |
| paragraph indent | main.tex:8 | `sp.lengths` | `\parindent` = 0pt |
| title block (hand-set, no `\maketitle`) | main.tex:12 | `sp.ragged` (the kernel `center` environment, the `\centering` family) | one `center` environment holding three lines |
| title line 1 | main.tex:12 | `font.size-commands`, `mark.kernel`, `color.xcolor` | `\fontsize{30}{34}\selectfont`, `\sffamily\bfseries`, `\color{blueberry}` |
| title lines 2 and 3 | main.tex:12 | `font.size-commands`, `color.xcolor` | `\large`; `\textcolor{apricot}` |
| title spacing | main.tex:12 | `sp.manual-space` | `\par\smallskip` twice, `\bigskip` after the environment |
| recipe card frame | main.tex:10 | `box.fancybox` | `\fcolorbox{blueberry}{cream}{...}` (border colour blueberry, fill cream, default `\fboxrule` and `\fboxsep`) |
| recipe card inner column | main.tex:10 | `box.minipage` | `\begin{minipage}{0.96\linewidth}` |
| card heading row | main.tex:10 | `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.manual-space` | `\textcolor{blueberry}{\Large\sffamily\bfseries #1}`, `\hfill`, `\textcolor{apricot}{#2}` |
| card divider | main.tex:10 | `sp.rule`, `color.xcolor` | `\textcolor{apricot}{\rule{\linewidth}{0.6pt}}` |
| card labels "Ingredients" and "Directions" | main.tex:10 | `mark.kernel`, `sp.manual-space` | `\textbf{...}`, `\par\smallskip` before and after |
| card gap | main.tex:10 | `sp.manual-space` | `\par\medskip` after the frame |
| ingredient lists | main.tex:13-15 | `list.kernel`, `list.enumitem` | `itemize`, spacing from the `\setlist` line above |
| not present in the sample | main.tex:1-16 | none needed | headings, abstract, contents, theorems, math, floats, tables, captions, code, notes, bibliography, index, cross-references and hyperref are not used |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\simpleRecipe` (4 arguments) | main.tex:10 | yes | Pure composition, no `\if`, counter, `\def` internals or box measurement. Expand per use: `\fcolorbox{blueberry}{cream}{\begin{minipage}{0.96\linewidth}\textcolor{blueberry}{\Large\sffamily\bfseries <name>}\hfill\textcolor{apricot}{<yield>}\par\smallskip\textcolor{apricot}{\rule{\linewidth}{0.6pt}}\par\smallskip\textbf{Ingredients}\par\smallskip<list>\par\smallskip\textbf{Directions}\par\smallskip<method>\end{minipage}}\par\medskip` = `box.fancybox` + `box.minipage` + `font.size-commands` + `mark.kernel` + `color.xcolor` + `sp.rule` + `sp.manual-space`. A `\newcommand` alias of kernel calls is the rubric's own reducible example. |

The colour names `blueberry`, `apricot` and `cream` are `\definecolor` declarations (main.tex:9), parameters of `color.xcolor`, not bespoke code.

## Content-opaque
none (the recipe names, yields, ingredient lists and method text at main.tex:13-15 are content; the sample has no figure, table or TikZ picture)

## Lib changes
- New ways proposed: none. Considered and not used: `front.titlepage-env` (the title is a `center` environment, not a `titlepage` environment) and `front.maketitle` (the sample never calls `\maketitle`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
