yes

# 0464-zbmath-review-template: zbMATH Open review template (class zbMATH)

- Unverified: read from the source, not compiled.
- Source: Source/0464-zbmath-review-template/ (origin: https://mirrors.ctan.org/macros/xetex/latex/zbmath-review-template.zip; licence: GPL-3 for the class, style and manual; CC-BY-SA 4.0 for zb-example.tex and zb-example.pdf, README.md:71-73)
- Kind: misc (a one-page review of a published maths paper for the zbMATH Open database; a house format, not an article or report)
- Lib: v4
- Engine: needs XeLaTeX (`fontspec` is loaded unconditionally, zbMATH.cls:38; README.md:3; zb-manual.tex:61)
- Look carried by: class (zbMATH.cls with its companion zb-basics.sty, loaded at zbMATH.cls:50; the manual's own preamble adds only `hyperref`, zb-manual.tex:14-16; zb-example.tex adds nothing)
- Class origin: ctan (the class is inside the CTAN package `zbmath-review-template` v2.1, 2021-06-24, also in TeX Live and MiKTeX per the one ctan.org/pkg read; it is also FIZ Karlsruhe's own kit, README.md:82-84)
- Main file: zb-manual.tex (other samples: zb-example.tex)
- Read: main yes, zip-local classes and styles all (zbMATH.cls, zb-basics.sty, README.md, zb-example.tex read in full; the two PDFs and figures/screenshot.png are compiled output and an asset, not read)

## Verdict
Yes. The whole look sits in one published class, `zbMATH`, from the publisher's own CTAN kit (W1), so the emitter writes `\documentclass{zbMATH}` plus the class's own commands and never copies macro logic. Every macro in the class and in `zb-basics.sty` is class vocabulary, and each one also reduces to lib ways (table below). The only drawings are `tikz-cd` commutative diagrams in the manual's maths, which are content. XeLaTeX and the Computer Modern Unicode fonts are required, recorded and not a blocker. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.zbMATH` options: none. `\DeclareOption*` forwards every option to a class named `scartcl` (typo for `scrartcl`, zbMATH.cls:16), which is never loaded, so any option is silently dropped and neither sample passes one (zb-example.tex:14, zb-manual.tex:13). Base class loaded inside it: `class.scrartcl` with `a4paper,10pt,leqno` (zbMATH.cls:19).
- Class-native vocabulary used: `\title{}` and `\author{}` (strings of the reviewed article, zb-example.tex:16-17), `\maketitle` (zbMATH.cls:78), `\makefooter` (zbMATH.cls:53), `\reviewer{name (place)}` (zbMATH.cls:118), `\msc{codes separated by spaces}` (zbMATH.cls:105), `\keywords{items separated by ;}` (zbMATH.cls:96), `\blue{}` and colour `zbMATHBlue` (zbMATH.cls:74-75), and the maths macros `\Im \Re \Aut \Hom \ran \1 \fint \Sha` from zb-basics.sty:21-41 (shown in the manual, zb-manual.tex:77-88). No environment is defined by the class.

## Component map
Rows marked (in class) are done inside the class or its companion style and are not emitted separately; they show that the class itself is built from lib ways.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | zb-example.tex:14; zb-manual.tex:13 | `class.zbMATH` | no options |
| base class (in class) | zbMATH.cls:19 | `class.scrartcl` | a4paper, 10pt, leqno |
| paper and size (in class) | zbMATH.cls:19 | `page.class-options` | a4paper, 10pt |
| equation numbers on the left (in class) | zbMATH.cls:19 | `math.eqnumber` | leqno (also moves `\tag` to the left) |
| page geometry (in class) | zbMATH.cls:21 | `page.geometry` | margin=2.5cm, tmargin=2cm, bmargin=3cm |
| colour (in class) | zbMATH.cls:23, 74-75 | `color.xcolor` | `\definecolor{zbMATHBlue}{rgb}{0, 0.289, 0.6}`; `\blue{x}` = `\textcolor{zbMATHBlue}{x}` |
| language (in class) | zbMATH.cls:25 | `lang.babel` | UKenglish |
| fonts (in class) | zbMATH.cls:38-48 | `font.fontspec` | `[no-math]`; `\setmainfont{cmun}` Extension=.otf, UprightFont=*rm, BoldFont=*bx, ItalicFont=*ti, BoldItalicFont=*ti, SlantedFont=*sl, SmallCapsFont=*rm, SmallCapsFeatures={Letters=SmallCaps} |
| font sizes | zb-manual.tex:24; zbMATH.cls:56 | `font.size-commands` | `\LARGE` on the manual's title; `\footnotesize` in the footer |
| paragraph shape (in class) | zbMATH.cls:67-69; zb-example.tex:31 | `sp.lengths` | parindent=0cm, parskip=1ex, parfillskip=0pt plus 1fill, footheight=19pt (zbMATH.cls:70); sample group `{\parindent5mm ...}` |
| space after a period (in class) | zbMATH.cls:122 | `sp.frenchspacing` | `\frenchspacing` |
| manual spacing | zbMATH.cls:79, 82, 97, 119; zb-manual.tex:26 | `sp.manual-space` | `\vspace{7ex}`, `\vspace{2ex}`, `\hspace*{0pt plus 1filll}`, `\vspace{4ex}` |
| footer | zb-example.tex:24; zb-manual.tex:21; zbMATH.cls:53-71 | `hf.class-native` | the class command `\makefooter`, called once after `\maketitle` |
| footer implementation (in class) | zbMATH.cls:27, 54-65 | `hf.scrlayer-scrpage` | `\pagestyle{scrheadings}`; `\setkomafont{pageheadfoot}{\rmfamily\footnotesize\color[rgb]{.5,.5,.5}}`; `\lofoot{\makebox[\linewidth][s]{Edited by FIZ Karlsruhe, ...}\\ \copyright{} \the\year{} FIZ Karlsruhe GmbH}`; `\cofoot{}`; `\rofoot{\\Page \thepage}` |
| title block | zb-example.tex:16-21; zbMATH.cls:78-83 | `front.class-native` | `\maketitle` = `\vspace{7ex}`, authors in bold `\blue`, then the title in bold with a full stop, then `\vspace{2ex}` |
| reviewer line | zb-example.tex:59; zbMATH.cls:118-120 | `front.class-native` | `\reviewer{}`: `\par\nopagebreak`, flush right by `\hspace*{0pt plus 1filll}`, "Reviewer:" then the name in blue |
| keywords | zb-example.tex:65; zbMATH.cls:86-100 | `abs.keywords` | bold "Keywords:" then `\par\nopagebreak`, items split at `;` and set in blue, joined with "; " |
| MSC codes | zb-example.tex:63; zbMATH.cls:103-115 | `abs.classification` | bold "MSC:" then `\par\nopagebreak`, codes split at spaces, one blue code per row |
| MSC table (in class) | zbMATH.cls:111-113 | `tbl.tabular` | `tabular[t]{@{}lp{\msclen}}`, `\msclen` = `\textwidth` minus `\wd\citationbox` minus 5em (the box is never filled, zbMATH.cls:103, 108, so its width is 0) |
| graphics and enumitem loaded (in class) | zbMATH.cls:29-30 | `fig.graphicx`, `list.enumitem` | no options |
| URL breaking (in class) | zbMATH.cls:35 | `meta.url` | hyphens |
| sectioning | zb-manual.tex:33, 63, 99, 127, 159, 225, 258, 266 | `head.kernel` | `\section*`, `\subsection*` only; the look is the KOMA default of scrartcl (`head.class-native`, no heading option set) |
| lists | zb-manual.tex:66-74, 76-89; zb-example.tex:32-35 | `list.kernel`, `list.enumitem` | `itemize[nosep]`; `\item[1)]` with a hand label |
| font switches | zb-manual.tex:24, 123, 233 | `mark.kernel` | `\textbf`, `\textit`, `\texttt` |
| verbatim | zb-manual.tex:36-38, 41-44, 103, 112-116 | `code.verbatim` | `verbatim` environment, `\verb\|..\|` |
| display maths | zb-manual.tex:113-120, 144-151; zb-example.tex:37-39 | `math.amsmath` | `equation*` with `\tag{1}\label{eq:1}`; `cases`; `pmatrix` `bmatrix` `vmatrix` `smallmatrix`; `\[ \]` and `\( \)` |
| maths packages (in class) | zb-basics.sty:13-14 | `math.amsmath`, `math.amssymb`, `math.mathtools` | no options |
| maths operators (in class) | zb-basics.sty:21-29, 41 | `math.amsmath` | `\DeclareMathOperator` for `\Im \Re \Aut \Hom \ran \Sha` (`\Sha` = `\textup{Ш}`; `\Im` `\Re` are first `\let` to `\relax`) |
| maths symbol fonts (in class) | zb-basics.sty:32-38 | `font.nfss` | `\DeclareSymbolFont{bbold}{U}{bbold}{m}{n}` and `\DeclareMathSymbol{\1}{\mathord}{bbold}{`1}`; `\DeclareSymbolFont{esint}{U}{esint}{m}{n}` and `\DeclareMathSymbol{\fintsymbol}{\mathop}{esint}{'037}`; `\def\fint{\fintsymbol\nolimits}` is an alias |
| other maths symbol packages (in class) | zb-basics.sty:15-16 | `math.amssymb` (stmaryrd), `math.bm` (mathrsfs) | nearest ways, package as parameter; the samples never call stmaryrd |
| text symbols (in class) | zb-basics.sty:18 | `font.fontenc-t1` (textcomp), `font.icons` (gensymb) | no options; nearest ways, package as parameter |
| cross-references | zb-manual.tex:121-123, 229 | `xref.kernel` | `\label{eq:1}` `\ref{eq:1}`, `Figure~\ref{fig:cite}` |
| figure | zb-manual.tex:245-250 | `fig.graphicx`, `cap.kernel` | `figure[bth]`, `\centering`, `\includegraphics[width=\textwidth]{figures/screenshot.png}`, `\caption`, `\label{fig:cite}` |
| hyperlinks | zb-manual.tex:14, 16, 67-73, 229 | `meta.hyperref`, `xref.hyperref` | `\hypersetup{colorlinks=true,allcolors=[rgb]{0,.289,.6}}` (the same blue as zbMATHBlue); `\href{url}{text}` is another hyperref command |
| bibliography, footnotes, contents, index | none in either sample | none | the manual says no reference list is wanted (zb-manual.tex:227); citations are typed text |

## Bespoke code
Nothing here is bespoke under W1: the class and its companion style are the publisher's released kit. The reductions are written down anyway.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option handler | zbMATH.cls:16-17 | yes | none needed: it drops every option (typo `scartcl`), so the emitter passes no option |
| `\makefooter` | zbMATH.cls:53-71 | yes | `hf.scrlayer-scrpage` fields as in the table plus `sp.lengths` (`\parindent` `\parskip` `\parfillskip` `\footheight`); the `\makebox[\linewidth][s]` spread line is a kernel LR box, nearest `sp.manual-space` |
| `\maketitle` redefinition | zbMATH.cls:78-83 | yes | `sp.manual-space` + bold `\textcolor{zbMATHBlue}{author}` + bold title; reads `\@author` and `\@title` |
| `\blue`, `zbMATHBlue` | zbMATH.cls:74-75 | yes | `color.xcolor` alias |
| `\keywords`, `\kwx`, `\helper`, toggle `first` | zbMATH.cls:86-100 | yes | inline expansion: the emitter splits the string at `;` and writes the blue items joined by "; "; the toggle is set once at load and never reset (zbMATH.cls:87, 89), so the class supports one `\keywords` per document |
| `\msc`, `\blueitem`, `\msclen`, `\citationbox` | zbMATH.cls:103-115 | yes | `tbl.tabular` with a `p` column of `\textwidth - 5em`; the savebox stays empty |
| `\reviewer` | zbMATH.cls:118-120 | yes | `sp.manual-space` (`\hspace*{0pt plus 1filll}`) + `color.xcolor` |
| `\Im \Re \Aut \Hom \ran \Sha` | zb-basics.sty:21-29, 41 | yes | `\DeclareMathOperator` (`math.amsmath`) |
| `\1`, `\fintsymbol`, `\fint` | zb-basics.sty:32-38 | yes | kernel NFSS math declarations (`font.nfss`); `\fint` is an alias for `\fintsymbol\nolimits` |
| `xparse`, `etoolbox` | zbMATH.cls:32-33 | yes | macro-programming support for the keyword and MSC code only (`\providetoggle`, `\SplitList`, `\ProcessList`); no printed component, gone once the code is expanded inline |

## Content-opaque
- `tikz-cd` commutative diagrams inside display and inline maths: zb-manual.tex:165-168, 183-186, 191-194, 208-212 (`art.tikz`; the copies at 171-174, 177-180, 197-203, 214-220 are verbatim text). The package is loaded by the style (zb-basics.sty:17) to serve reviewers' maths and draws nothing of the template's own look.
- Image `figures/screenshot.png` in the figure at zb-manual.tex:247 (a shipped asset).
- Hand-formatted citation lines typed as text: zb-manual.tex:233, 237, 243, 256.
- Assets not shipped: the Computer Modern Unicode OTF fonts (`cmun*`, zbMATH.cls:39-48) and the `bbold` and `esint` math fonts (zb-basics.sty:32, 36) come from TeX Live; ship or install them.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes for the consolidator: `class.zbMATH` vocabulary is listed under "Class setting". The `stmaryrd`, `gensymb` and `\href` rows use the nearest existing ways with the package as the parameter (`math.amssymb`, `font.icons`, `xref.hyperref`); the verdict does not depend on them because the class is a published way. Nothing in the zip is addressed to an AI.
