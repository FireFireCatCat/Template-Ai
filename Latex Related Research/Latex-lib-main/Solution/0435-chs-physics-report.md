no

# 0435-chs-physics-report: CHS Physics Lab Report package (Gary Zhang, Carmel High School) and its manual

- Unverified: read from the source, not compiled.
- Source: Source/0435-chs-physics-report/ (origin: https://mirrors.ctan.org/macros/latex/contrib/chs-physics-report.zip; licence: cc-by-sa-3 and pd, per the manifest and ctan.org/pkg/chs-physics-report, version 2017-11-23; the README says CC0 except the Kottwitz square-root code under CC BY-SA 3.0, README.txt:16-19)
- Kind: report (physics lab report style; the sample is the package's own manual)
- Lib: v5
- Engine: needs XeLaTeX (the sample loads `fontspec` with system fonts and `\setmathsf`, chs-physics-report.tex:44-47, and types literal Unicode letters at tex:61-62 and tex:318; the header comment at tex:1 says XeLaTeX). The package file itself needs nothing beyond pdfLaTeX (not tested).
- Look carried by: mixed (the CTAN style file chs-physics-report.sty carries title, section, header, footnote and math-style look, sty:43-155; the sample preamble adds fonts, side margins, a custom title box and a `\LaTeX` redefinition, tex:43-62)
- Class origin: ctan (the one style file in the zip is the CTAN release of the package; the document class `ltxdoc` is not in the zip and ships with the TeX distribution, source not read)
- Main file: chs-physics-report.tex (other samples: none; the zip also holds README.txt, chs-physics-report.sty and the compiled chs-physics-report.pdf, which was not read)
- Read: main yes, zip-local classes and styles all (the single .sty, 170 lines)

All paths below are relative to Source/0435-chs-physics-report/: `tex:N` is chs-physics-report.tex, `sty:N` is chs-physics-report.sty.

## Verdict
no. The look is carried by `chs-physics-report.sty`, a published CTAN package, so it is taken as one doc-kind way, `class.chs-physics-report`, and its internals reduce to lib ways except one hand-rolled square-root redefinition, which does not count under that reading (see Bespoke code). The sample's own preamble, though, redefines the kernel `\LaTeX` logo with NFSS internals and box-and-glue code (tex:56), a retuned copy of kernel logo code that no lib way expresses. That is an irreducible `BESPOKE/preamble` item, and a wrong yes costs more than a wrong no. Everything else in the sample maps to lib ways, so this is the only counted blocker.

## Blockers
- `BESPOKE/preamble` `\def\LaTeX{ L\kern -.21em{\sbox \z@ T\vbox to\ht \z@ {\hbox {\check@mathfonts \fontsize \sf@size \z@ \math@fontsfalse \selectfont A}\vss }}\kern -.1em\TeX}`: the kernel logo rebuilt from boxes and font internals with retuned kerns (tex:56). `\hologo{LaTeX}` (`font.icons`) prints the stock logo, not these kerns.
- Not counted, recorded so the result can be re-read under other definitions: `BESPOKE/class` the `\r@@t` and `\sqrt` redefinition (`\setbox`, `\dimen0`, `\vrule`, `\lower`) inside the CTAN `.sty` (sty:31-38). It counts only if the package is not accepted as a way.

## Class setting
- Class: `class.ltxdoc` options: `12pt` (tex:2). The look-carrying package `chs-physics-report` is loaded with no options (tex:42), so its defaults `display,standard` apply (sty:119).
- Class-native vocabulary used: `\DescribeMacro` (tex:152, 157, 219, 232, 282, 290, 299, 325, 327), `\cs` (tex:153, 155, 158), `\marg` (tex:167). `multicols` is used at tex:89 with no `\usepackage{multicol}` in the sample, so it must come from `ltxdoc` or `doc` (class source not read, not established). `LTXexample` is `showexpl` (tex:5), not the class.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | tex:2 | `class.ltxdoc` | 12pt |
| paper and size | tex:2 | `page.class-options` | 12pt |
| look-carrying package | tex:42; sty:9-10 | `class.chs-physics-report` | sample loads with defaults `display,standard` (sty:119); `light` documented (tex:118) and coded (sty:51-81) but not used; style strings by `\sectionstyle` `\subtitlestyle` `\titlestyle` (sty:48-50), fields by `\title` `\name` `\ww` (sty:166-167); internals reduced under Bespoke code |
| page geometry | sty:14-15; tex:43 | `page.geometry` | package sets top=2.5cm, bottom=2.5cm; sample adds left=4cm, right=4cm |
| fonts (sans, math sans, mono) | tex:44-47 | `font.fontspec` | `\setsansfont[Ligatures = TeX]{Calibri}`, `\setmathsf{CMU Sans Serif}`, `\setmonofont[Scale = .9]{Courier New}` |
| title font inside title box | tex:51 | `font.fontspec` | `\fontspec{Latin Modern Roman}[Scale = .93]` |
| body family switches | tex:66, 199, 221, 230 | `mark.kernel` | `\sffamily` for the body from tex:66; `\rmfamily` and `\sffamily` toggled around examples |
| family by NFSS name | tex:61, 304 | `font.nfss` | `\fontfamily{lmss}\selectfont` |
| sizes | sty:85-86; tex:7, 12 (lstset), 137 | `font.size-commands` | `\Huge`, `\small`, `\Large`, `\scriptsize`, `\normalsize`; `\fontsize{.9cm}{1cm}` (tex:61-62) |
| colour | sty:20-21; tex:15, 38-40 | `color.xcolor` | `xcolor` with `svgnames` (sty:21); `\color{black!10}` listing background; link colours black and blue |
| title block | sty:84-88; tex:51-52, 55, 65 | `front.maketitle` | package `\maketitle` is a `center` of `\Huge\textbf{title}` over `\small` author and worked-with line (sty:84-88); sample title is `\hspace*{-3.25cm}\parbox{\textwidth + 6.5cm}{\centering ... \\ ...}\vspace{2mm}`; `\maketitle\vspace{13mm}` |
| title box wrapper | tex:51 | `box.minipage` | `\parbox` with a `calc` width `\textwidth + 6.5cm`; `calc` is loaded by the package (sty:17) |
| title alignment and shifts | tex:51, 65 | `sp.ragged`, `sp.manual-space` | `\centering`; `\hspace*{-3.25cm}`, `\vspace{2mm}`, `\vspace{13mm}` |
| abstract | tex:68 | `head.titlesec` | no `abstract` environment; a numbered `\section{Abstract}` |
| section headings | sty:133-151; tex:49 | `head.titlesec` | `\titleformat{\section}{\@sectionArgs}{label}{0cm}{}`, no `\titlespacing`; label is `\hspace{-\@boxwidth}\makebox[\@boxwidth][l]{\thesection\hspace{\fill}` bullet `\hspace{\fill}\hspace{.3mm}}`, `\@boxwidth` = 13 mm, bullet `\raisebox{1.7pt}{\fontsize{14.4pt}{0pt}\selectfont$\bullet$}`; sample sets `\sectionstyle{\rmfamily\bfseries\Large}` |
| subsections | tex:116, 150, 217 | `head.kernel` | `\subsection` left at the class default; the package styles only `\section` |
| paragraph skip | sty:124 | `sp.lengths` | `\parskip` = 2.5mm |
| header and footer (light option) | sty:51-72 | `hf.fancyhdr` | `\fancypagestyle{light}`: `\cfoot{\textsf{\textbf{-\raisebox{-.7pt}{\thepage}-}}}`, `\headrulewidth` 0pt; `light-first-page`: `\lhead` `\rhead` title and author, `\headrulewidth` .6pt, `\fancyhfoffset{13mm}`; not used by the sample |
| page style selection | sty:71-72 | `hf.pagestyle-kernel` | `\pagestyle{light}`, `\AtBeginDocument{\thispagestyle{light-first-page}}` (light option only) |
| lists | tex:90-101, 106-114, 161-165 | `list.kernel` | `itemize`, `description`; `\renewcommand{\descriptionlabel}[1]{\hspace{\labelsep}\bfseries\sffamily{#1}}` (tex:105) |
| two-column list | tex:89-102 | `cols.multicol` | `multicols` with `{2}`; source of the load not established |
| footnotes | sty:153-155; tex:77, 325 | `fn.kernel` | package wraps `\footnote` to print `$^\text{Note }$` before the mark (reduced under Bespoke code); sample bodies use `\footnote{\sffamily ...}` |
| author note | tex:52 | `fn.kernel` | `\footnoteDuplic@teDuplic@te{...}` is the package's saved kernel `\footnote` (sty:153), used inside `\author` |
| math style | sty:115, 117; tex:285-296, 306-322 | `math.amsmath` | amsmath loaded by the package (sty:12); `\everymath{\displaystyle}` for `display`, `\everymath{}` for `inline-math`; `\frac`, `\sum`, `\dfrac`, display `\[ \]` |
| math symbols | tex:4, 302 | `math.amssymb` | `amssymb`; `\renewcommand{\geq}{\geqslant}` |
| math operators | sty:129-130; tex:59-62 | `math.amsmath` | `\DeclareMathOperator*{\sfsum}` `{\sfprod}` with sans Sigma and Pi; sample redefines them after `\let\sfsum\undefined` (tex:59-62) |
| listing defaults | tex:6-19 | `code.listings` | `\lstset`: `basicstyle`, `keywordstyle`, `commentstyle`, `numbers = left`, `numbersep = .5em`, `numberstyle`, `breaklines`, `escapeinside={/*}{*/}`, `backgroundcolor`, `breakautoindent`, `captionpos=t`, `language = TeX` |
| listing style | tex:20-28 | `code.listings` | `\lstdefinestyle{mc}`: `name`, `language=[LaTeX]TeX`, `columns=fullflexible`, `numbers=left`, `numberfirstline=1`, `firstnumber=auto`, `numbersep` |
| listing bodies | tex:122-128, 172-191, 249-258, 346-540 | `code.listings` | `lstlisting` with `numbers = none`, `pos = t`, `style = mc` |
| code with live result | tex:5, 222-229, 235-241, 284-288, 292-297, 330-335 | `code.showexpl` | `\usepackage{showexpl}`; `LTXexample[pos = o, numbers = none]` |
| inline code | tex:93, 118-120, 167 | `code.verbatim` | `\verb\|...\|` |
| boxes | tex:81, 132-148, 171-212, 248-275, 306-322 | `box.minipage` | `minipage` widths such as `.5\textwidth - 2\fboxsep-2\fboxrule`, with `[c][4cm][t]` |
| framed boxes | tex:137, 143, 197, 262, 315 | `box.fancybox` | `\fbox`, `\setlength{\fboxsep}{0pt}` |
| spacing and shifts | tex:91-100, 160-165, 171, 196, 282, 288 | `sp.manual-space` | `\vspace{-.8\parskip}`, `\hspace{-25mm}`, `\raisebox`, `\\[2.5mm]` |
| page breaks | tex:130, 215, 280 | `pg.break` | `\pagebreak` |
| links and metadata | tex:33-41, 77, 84 | `meta.hyperref` | `pdftitle`, `pdfauthor`, `pdfnewwindow=true`, `colorlinks=true`, `linkcolor=black`, `urlcolor=blue`; `\href`, `\url` |
| TeX logos | tex:30, 111 | `font.icons` | `metalogo` (`\XeLaTeX`) is a TeX-logo package of the type of `hologo`; the lib line names only `hologo`, so this is a widening by package |
| text marks and case | tex:61-62, 75, 219 | `mark.kernel`, `mark.case` | `\emph`, `\textbf`, `\texttt`, `\textsc`; `\MakeUppercase{π}` (tex:62) |
| load-only packages in the style | sty:16, 18, 20, 22 | `color.transparent`, `fig.graphicx`, `color.color` | `transparent`, `graphicx`, `color`, `letltxmacro`; no `\includegraphics`, `\transparent` or figure appears in the sample |
| load-only in the sample | tex:32 | `tbl.booktabs` | `booktabs` loaded, no `\toprule`, `\midrule` or table in the sample |
| `\LaTeX` logo | tex:56 | none (`BESPOKE/preamble`) | see Blockers |
| contents, floats, tables, theorems, bibliography, index, cross-references, appendix | none | none | the sample has no `\label` `\ref`, `\cite`, `\tableofcontents`, float or table (grep over the main file) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\LaTeX{...}` kernel logo retuned | tex:56 | No | box-and-glue (`\sbox\z@`, `\vbox to\ht\z@`) and NFSS internals (`\check@mathfonts`, `\sf@size`, `\math@fontsfalse`) with kerns -.21em and -.1em; no lib way sets these kerns (`BESPOKE/preamble`) |
| local logo hack for XeLaTeX and LuaLaTeX | tex:111 | Yes, but rests on tex:56 | `\begingroup\let\nLaTeX\LaTeX\def\LaTeX{\!\makebox{\nLaTeX}}\XeLaTeX\endgroup` is a negative thin space and `\makebox`: `sp.manual-space`, `box.minipage` |
| `\r@@t` and `\sqrt` redefinition (Kottwitz) | sty:31-38 | No, in the box-and-glue sense | `\setbox0=\hbox{$\oldr@@t#1{#2\,}$}`, `\dimen0=\ht0`, `\vrule height\ht0 depth -\dimen0`, `\lower0.478pt`; no option switches it; inside the published CTAN package, so not counted when the package is a way (`BESPOKE/class` otherwise) |
| `\everymath{\displaystyle}` (`display`) and `\everymath{}` (`inline-math`) | sty:115, 117 | Yes | a TeX token-list assignment printed in the preamble; inside the package, so no way is proposed |
| `light` option page styles | sty:51-72 | Yes | `hf.fancyhdr` styles plus `hf.pagestyle-kernel`; parameters in the Component map |
| `light` `\maketitle` and haiku macros | sty:73-80 | Yes | `\def` of a warning and of `\hspace{-55pt}\emph{Haiku:}\hspace{35.25pt}`: `sp.manual-space`, `mark.kernel`; the sample does not use `light` |
| `standard` `\maketitle` | sty:84-88 | Yes | `\renewcommand{\maketitle}` of `center`, `\Huge\textbf`, `\small`: `front.maketitle`, `font.size-commands`, `mark.kernel` |
| `standard` haiku macros | sty:95-96; tex:236-240 | Yes | `\newcommand{\haiku}[1]{\begin{center}#1\end{center}}` |
| `\@title` `\@author` `\@workedWith` placeholders | sty:43-44, 89-93, 99-113 | Yes | `\ifx...\undefined` guards print a reminder only when a field is missing; the emitter always sets `\title`, `\name` and `\ww`, so they never print |
| `\@titleArgs` `\@subTitleArgs` `\@sectionArgs` and their setters | sty:45-50 | Yes | `\def` holders of font-switch strings; the emitter writes the string into `\titleformat` or `\maketitle` |
| `\titleformat{\section}` label with `\@boxwidth` | sty:133-151 | Yes | `head.titlesec`, `box.minipage`, `sp.manual-space`, `font.size-commands`; parameters in the Component map |
| `\footnote` wrapper | sty:153-155 | Yes | `\let` plus a one-argument `\def` printing superscript "Note " then the saved kernel `\footnote`: `fn.kernel`, `mark.kernel` |
| `\degree` `\degrees` `\fig` `\diff` `\name` `\ww` | sty:125-126, 162-163, 166-167 | Yes | `\providecommand` and `\newcommand` aliases of `^\circ`, `\textsc{Figure~#1}`, `\mathrm d`, `\author`, `\def\@workedWith{\\Worked with #1}` |
| `\sfsum` `\sfprod` | sty:129-130; tex:59-62 | Yes | `math.amsmath` `\DeclareMathOperator*` over `font.nfss`, `font.size-commands`, `mark.case` |
| `\def\@workedWith{\\2017-11-23}` | tex:55 | Yes | a plain string assignment to the package's subtitle-line macro, with no logic; the emitter writes `\makeatletter\def\@workedWith{...}\makeatother` (tex:51, 57) |
| `\renewcommand{\geq}{\geqslant}`, `\renewcommand{\descriptionlabel}` | tex:302, 105 | Yes | alias and kernel hook: `math.amssymb`, `list.kernel` |

## Content-opaque
none (the sample has no figure, table or picture; the math and `LTXexample` bodies are example content)

## Lib changes
- New ways proposed:
  - `class.chs-physics-report` (`chs-physics-report`, CTAN, version 2017-11-23, Gary Zhang, CC BY-SA 3.0 and public domain, page read at ctan.org/pkg/chs-physics-report; engine pdf, not tested): a lab-report look from one `\usepackage`. W1 CTAN package. W2 options `light`/`standard` and `display`/`inline-math`, font-switch strings through `\titlestyle` `\subtitlestyle` `\sectionstyle`, strings through `\title` `\name` `\ww`. W3 it serves any science lab report (the manual says "any type of science class", tex:77), not one document, though the name is one school; the consolidator may treat it as a house-style package, as v3 did for similar cases. W4 one preamble line `\usepackage[options]{chs-physics-report}` plus preamble string commands and `\maketitle`. The fixed square-root redefinition (sty:31-38) is part of the package and has no option, as the fixed grid of `cal.kalender`.
  - `code.showexpl` (`showexpl`, CTAN and TeX Live, LPPL 1.2, Rolf Niepraschk, version 0.3s, "typeset LaTeX source code and the related result in the same document", page read at ctan.org/pkg/showexpl; engine pdf, its source was not read): a listing plus its typeset result. W1 CTAN. W2 `pos`, `numbers` and the listing keys of `listings`. W3 any manual or tutorial. W4 `\usepackage{showexpl}` and an `LTXexample[keys]` environment wrapper. Not `code.listings`, which prints source only.
- Considered, not proposed: a way for the TeX primitive `\everymath` (it occurs only inside the package, sty:115, 117, and the sample never calls it); `metalogo` as a separate way (filed under `font.icons`, a TeX-logo package like `hologo`, see the Component map).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

No text addressed to an AI was found in the zip.
