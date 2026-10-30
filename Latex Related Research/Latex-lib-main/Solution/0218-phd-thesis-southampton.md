yes

# 0218-phd-thesis-southampton: PhD Thesis (Southampton)

- Unverified: read from the source, not compiled.
- Source: Source/0218-phd-thesis-southampton/ (origin: https://latextemplates.com/downloads/phd-thesis-southampton.zip; licence: BSD-3-Clause, LICENSE:1-3, copyright 2017 Alexandra K. Diem; phdthesis.cls:5 names GitHub akdiem/phd_thesis_template as its home)
- Kind: thesis
- Lib: v2
- Engine: pdfLaTeX-compatible
- Look carried by: zip-local (phdthesis.cls defines the look: `\LoadClass{book}` plus about 340 lines of preamble-style settings and redefined front-matter commands; lstdefinitions.tex defines the listing styles; main.tex adds only natbib, booktabs, `\hypersetup`, `\bibname`)
- Class origin: zip-local (ctan.org/pkg/phdthesis is a 404; the class is a personal GitHub template repackaged by latextemplates.com, not a publisher or university release)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (phdthesis.cls 1-376, lstdefinitions.tex 1-63, chapter1.tex, chapter2.tex, appendixA.tex, references.bib all read)

## Verdict
yes. The look is carried by the zip-local `phdthesis.cls`, which is `\LoadClass{book}` plus ordinary preamble settings (vmargin, fancyhdr, caption, listings, amsthm, hyperref, float parameters) and hand-laid front-matter commands that are straight-line kernel code (`titlepage`, `\vfill`, `\chapter*`, `\addcontentsline`, `longtable`). No part uses an output routine, box-and-glue algorithm, expl3 or Lua code, and there is no TikZ or other artwork. Every zip-local macro reduces to lib ways with the parameters recorded below, so an emitter can write `\documentclass[a4paper]{book}` and move the class body into the preamble without copying macro logic. Two filings rest on a judgement and are marked in the map and the bespoke table (`\doublehyphendemerits` under `sp.penalties`, `\MakeUppercase` under `mark.kernel`).

## Blockers
none

## Class setting
- Class: `class.book` options: `a4paper` (main.tex:4, also forced at phdthesis.cls:30); size options pass through (phdthesis.cls:19) and 10pt is added when none is given (phdthesis.cls:29), which is the book default anyway. The zip-local `phdthesis.cls` is the bespoke wrapper (`\def\baseclass{book}` phdthesis.cls:18, `\LoadClass{\baseclass}` phdthesis.cls:32), reducible to `class.book` plus the preamble ways below.
- Class-native vocabulary used: `\frontmatter` `\mainmatter` `\backmatter` `\appendix` (main.tex:18,58,63,67), `\chapter` `\section` (chapter1.tex:1,8,15), `titlepage` environment (phdthesis.cls:140), `\contentsname` `\listfigurename` `\listtablename` `\bibname` (renamed to "References", main.tex:12), `\@chapapp` and `\@mkboth` (phdthesis.cls:65,226), `\if@openright` (phdthesis.cls:368).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:4; phdthesis.cls:18,32 | `class.book` | a4paper; 10pt by default; every other option goes to book |
| paper size | main.tex:4; phdthesis.cls:30 | `page.class-options` | a4paper |
| page geometry | phdthesis.cls:44-52 | `page.vmargin` | `\setmarginsrb` left 1.5in, top 0.6in, right 1.0in, bottom 0.8in, head height 20pt, head sep 0.25in, foot height 9pt, foot sep 0.3in |
| page flow | phdthesis.cls:53-54 | `pg.flush`, `sp.lengths` | `\raggedbottom`; `\topskip` = `1\topskip plus 5pt` |
| paragraph shape | phdthesis.cls:42-43 | `sp.lengths` | `\parindent` 0pt; `\parskip` 2.0ex plus0.5ex minus0.2ex |
| line spacing | phdthesis.cls:40-41 | `sp.setspace` | `\onehalfspacing` |
| break penalties | phdthesis.cls:55-59 | `sp.penalties` | doublehyphendemerits 10000, brokenpenalty 10000, widowpenalty 9999, clubpenalty 9999, interfootnotelinepenalty 9999 (judgement: `\doublehyphendemerits` and `\interfootnotelinepenalty` are integer TeX parameters assigned in the preamble, the same type as the penalties, so filed here and no new way proposed) |
| running heads | phdthesis.cls:60-64 | `hf.fancyhdr` | `\lhead[\rm\thepage]{\fancyplain{}{\sl{\rightmark}}}`, `\rhead[\fancyplain{}{\sl{\leftmark}}]{\rm\thepage}`, `\chead{}` `\lfoot{}` `\rfoot{}` `\cfoot{}` empty, `\pagestyle{fancy}` |
| head marks | phdthesis.cls:65-67 | `hf.fancyhdr` | `\chaptermark` -> `\markboth{\@chapapp\ \thechapter\ #1}` on both sides (the idiom fancyhdr documents); `\sectionmark` and `\subsectionmark` emptied |
| blank pages | phdthesis.cls:68-72 | `pg.emptypage`, `pg.break` | `\cleardoublepage` = kernel version plus `\thispagestyle{empty}` on the inserted page (book is twoside by default) |
| page numbering | main.tex:18,58,67 | `pgnum.pagenumbering` | set by book's `\frontmatter` (roman) and `\mainmatter` (arabic) |
| title page | phdthesis.cls:135-184; main.tex:19-28 | `front.titlepage-env`, `front.maketitle`, `front.thanks`, `fn.kernel`, `sp.manual-space`, `font.size-commands`, `mark.kernel`, `hf.pagestyle-kernel`, `meta.hyperref`, `pg.break` | `\thispagestyle{empty}` (139); `titlepage` (140); `\null\vfill\vskip 60pt` (145-146); centered block with `\parskip` 0pt (147-148); UNIVERSITY `\large\textbf` uppercased (149), `\vfill`, title `\huge\bf` (151), `\vfill`, "by" `\LARGE` (153), author `\LARGE` (155), `\vfill`, "A thesis submitted for the degree of / Doctor of Philosophy" `\large` (157-158), "in the" faculty department `\large` (161-163), date `\Large` (167), `\@thanks` (171), `\vfil\null` (172); footnote hooks `\let\footnote\thanks`, `\let\footnoterule\relax` (141-144); then `\cleardoublepage` (183) |
| title data | phdthesis.cls:123-133; main.tex:19-26 | `front.maketitle` | `\title` `\author` `\date` kernel; `\university` `\department` `\faculty` stored by `\gdef` and printed in 149,162-163,192-196; `\supervisor` and `\group` are stored and never printed (phdthesis.cls:123,128 against 135-184) |
| abstract | phdthesis.cls:185-209; main.tex:30-41 | `abs.kernel`, `front.titlepage-env`, `sp.manual-space`, `mark.kernel`, `mark.ulem`, `hf.pagestyle-kernel`, `pg.break` | `\newenvironment{abstract}`: `\thispagestyle{empty}`, `\null\vfil`, centered `\parskip` 0pt block: university, `\underline{ABSTRACT}`, faculty, department, `\underline{Doctor of Philosophy}`, title `\bf` uppercase, "by author"; end `\vfil\vfil\vfil\null\cleardoublepage` (`\underline` is the kernel command of the underline type that `mark.ulem` stands for) |
| contents | phdthesis.cls:216-232; main.tex:43 | `toc.kernel`, `sp.setspace`, `sp.lengths`, `pg.break` | kernel `\tableofcontents` wrapped in `\begin{spacing}{1}`, `\parskip` 1pt, then `\cleardoublepage`; the body is the kernel book definition (`\chapter*`, `\@mkboth` uppercase, `\@starttoc{toc}`) |
| list of figures, tables | phdthesis.cls:233-268; main.tex:44-45 | `toc.kernel`, `sp.setspace`, `sp.lengths`, `pg.break` | same wrapper; `\addtotoc{...}` first, so the lists appear in the contents |
| list of listings | phdthesis.cls:269-288; main.tex:46 | `code.listings`, `toc.kernel`, `sp.setspace` | `\lstlistingname`=Algorithm (269), `\lstlistlistingname`=List of Algorithms (270), same wrapper around `\lstlistoflistings` (`lol` file) |
| contents entry for starred chapters | phdthesis.cls:210-215,367-375 | `toc.kernel`, `num.counters`, `meta.hyperref` | `\addcontentsline{toc}{chapter}{#1}` after `\refstepcounter{dummy}` (the counter only makes a hyperref anchor); used for lists, nomenclature, declaration, acknowledgements and the bibliography |
| nomenclature, acronyms | phdthesis.cls:289-310; main.tex:47-55 | `tbl.longtable`, `head.kernel`, `toc.kernel`, `hf.fancyhdr`, `pg.break` | `\chapter*{Nomenclature}` / `{Acronyms}` with `\@mkboth` uppercase; `\begin{longtable}[c]{llc}` / `{ll}` with rows as argument; `\par\cleardoublepage` |
| declaration | phdthesis.cls:311-343; main.tex:56 | `front.dedication`, `list.kernel`, `head.kernel`, `sp.manual-space`, `hf.pagestyle-kernel`, `toc.kernel` | `\chapter*{\@mkboth{DECLARATION OF AUTHORSHIP}...}`, `\thispagestyle{plain}`, `\null\vskip 60pt`, `\Large\bf` centered heading, `\normalsize` text with author and title substituted, `enumerate` of 7 items (item 7 takes the argument), "Signed:" "Date:" |
| acknowledgements | phdthesis.cls:344-357; main.tex:57 | `front.dedication`, `head.kernel`, `sp.manual-space`, `toc.kernel` | same pattern; `\Large\bf` centered heading then `\normalsize` text |
| dedication (defined, unused) | phdthesis.cls:358-366 | `front.dedication` | `\null\vfil`, `\vskip 60pt`, centered `\normalsize\sl`, `\vfil\null` |
| headings | chapter1.tex:1,8,15; chapter2.tex:1; appendixA.tex:1 | `head.kernel` | book's default chapter and section look; nothing restyled (no titlesec) |
| section numbering depth | phdthesis.cls:210-211 | `num.secnumdepth` | `\addtocounter{secnumdepth}{1}` (book default 2, so 3); `tocdepth` 6 |
| appendix | main.tex:63-64; appendixA.tex:1 | `num.appendix` | kernel `\appendix` then `\chapter` |
| theorem statements (defined, unused in the body) | phdthesis.cls:73-84 | `thm.amsthm` | `\theoremstyle{plain}`: example and theorem numbered within chapter; corollary, lemma, proposition, axiom share theorem's counter; `definition` style: definition; `remark` style: remark |
| math packages | phdthesis.cls:73 | `math.amsmath`, `math.amssymb` | amsmath, amsfonts, amssymb; `amscd` from the same AMS-LaTeX bundle, loaded and not used by the sample |
| lists | chapter1.tex:17-25; phdthesis.cls:327-335 | `list.kernel` | `itemize`, `enumerate`, default labels |
| figure float | chapter1.tex:27-31; main.tex:10 | `fig.graphicx`, `sp.ragged`, `cap.kernel`, `xref.kernel` | `\center` (kernel centring), `\includegraphics[width=0.6\linewidth]{figure.png}`, `\caption{...\label{fig:1}}`, `\graphicspath{{.}}`; phdthesis.cls:39 loads graphicx |
| float placement | phdthesis.cls:94-103 | `fig.placement` | topfraction .85, bottomfraction .85, textfraction 0.1, dbltopfraction .85, floatpagefraction .75, dblfloatpagefraction .75; topnumber 9, bottomnumber 9, totalnumber 20, dbltopnumber 9 |
| table | chapter1.tex:35-47; main.tex:7 | `tbl.tabular`, `tbl.booktabs`, `cap.kernel`, `xref.kernel` | `\center`, caption above, `tabular{cc}`, `\toprule` `\midrule` `\bottomrule` |
| caption look | phdthesis.cls:85-86 | `cap.caption` | options `centerlast,small,sc` as written (caption's legacy option names); `\captionmargin` 20pt (not checked against the caption version) |
| cross-reference aliases | phdthesis.cls:87-93; chapter1.tex:33,49; chapter2.tex:15 | `xref.kernel` | `\fref`=`Figure~\ref`, `\tref`=`Table~\ref`, `\eref` Equation, `\cref` Chapter, `\sref` Section, `\aref` Appendix, `\alref` Algorithm |
| code listings | phdthesis.cls:104-114; lstdefinitions.tex:13-31,43-63; chapter2.tex:6-13,19-22 | `code.listings` | `\lstset{captionpos=b, frame=tb, basicstyle=\scriptsize\ttfamily, showstringspaces=false, keepspaces=true}`; style matlab (keywordstyle `\color{blue}`, commentstyle rgb 0.13,0.55,0.13 `\em`, stringstyle rgb 0.7,0,0); `python` env: language=Python, basicstyle `\footnotesize`, otherkeywords self, keywordstyle `\bfseries\color{black}`, emph MyClass,__init__, emphstyle deepred, stringstyle deepgreen, frame=tb; `algorithm` env: same with all colours black and captionpos=t; both via `\lstnewenvironment{...}[1][]{\style\lstset{#1}}{}` |
| colours | lstdefinitions.tex:6-9; phdthesis.cls:112-114 | `color.color` | `\definecolor` deepblue rgb 0,0,0.5; deepred 0.6,0,0; deepgreen 0,0.5,0; `\color[rgb]` in the matlab style |
| fixed fonts | lstdefinitions.tex:2-3 | `font.nfss` | `\DeclareFixedFont{\ttb}{T1}{txtt}{bx}{n}{10}`, `\ttm` ... `{m}{n}{10}`; neither is called anywhere |
| fonts, default | (none set) | `class.book` | Computer Modern from the class; no font package |
| PDF links and metadata | phdthesis.cls:115-121,137-138; main.tex:9 | `meta.hyperref` | options pdfpagemode UseOutlines, bookmarks, bookmarksopen, bookmarksopenlevel=0, bookmarksnumbered, hypertexnames=false, linkcolor/citecolor/urlcolor black, pdfstartview FitV, unicode, breaklinks; `\pdfstringdefDisableCommands{\let\\\space}`; `\hypersetup{pdftitle,pdfauthor}` from title and author; `colorlinks=true` |
| citations | main.tex:6,68-69; chapter1.tex:6,12; chapter2.tex:26; references.bib | `bib.natbib`, `bib.bibtex-bst` | `natbib` option round; `\citep`; `\bibliographystyle{plainnat}`; `\bibliography{references}`; `\bibname` -> References (main.tex:12) |
| date format (defined, unused) | phdthesis.cls:35-38 | `front.datetime` | "Month Year" with no day, from `\ifcase\month`; the sample never calls `\today` (main.tex:20 gives a literal date) |
| language | (none) | `class.book` | no language package; English strings and month names are fixed |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `phdthesis.cls` as a whole | phdthesis.cls:16-376 | yes | `class.book` `a4paper` plus every preamble way in the map |
| option plumbing `\@checkoptions`, `\DeclareOption*` | phdthesis.cls:18-31 | yes | passes options to book and adds 10pt when no size is given, which is book's default; class options only |
| `\bhrule`, `\btypeout` | phdthesis.cls:33-34 | yes | `\typeout` writes to the log only; no effect on the PDF, omitted |
| `\def\today` | phdthesis.cls:35-38 | yes | `front.datetime` `\newdateformat` for month and year; unused by the sample |
| `\cleardoublepage` | phdthesis.cls:68-72 | yes | `pg.emptypage` |
| `\chaptermark` etc. | phdthesis.cls:65-67 | yes | `hf.fancyhdr` `\markboth` idiom |
| `\fref \tref \eref \cref \sref \aref \alref` | phdthesis.cls:87-93 | yes | `\newcommand` aliases: literal word, `~`, `\ref` (`xref.kernel`); sample quirk, not template: `\aref` prints "Appendix" but is used on an algorithm label (chapter2.tex:15) |
| info macros `\supervisor \university \department \group \faculty`, `\UNIVERSITY` etc. | phdthesis.cls:123-133 | yes | `\gdef` string stores; the emitter writes the strings (uppercased) straight into the title page and abstract; judgement: `\MakeUppercase` (phdthesis.cls:125-131) is a kernel text-case command filed with `mark.kernel`, or the emitter prints the already-uppercased string |
| `\maketitle` | phdthesis.cls:135-184 | yes | `front.titlepage-env` with fixed vertical glue, sizes and strings (map row); the `\global\let...\relax` lines (174-182) only stop reuse, no layout effect |
| `abstract` environment | phdthesis.cls:185-209 | yes | `\newenvironment` built from `abs.kernel`, `front.titlepage-env`, spacing, `\underline`, `\cleardoublepage` |
| `\addtotoc` and counter `dummy` | phdthesis.cls:212-215 | yes | `\refstepcounter` (anchor) + `\addcontentsline{toc}{chapter}`; or `\phantomsection\addcontentsline` |
| `\tableofcontents`, `\listoffigures`, `\listoftables`, `\lstlistoflistings` | phdthesis.cls:216-288 | yes | kernel book definitions inside `\begin{spacing}{1}`, `\parskip` 1pt, plus `\addtotoc` and `\cleardoublepage`; the `\if@twocolumn` branches are inert in a one-column book |
| `\listofsymbols`, `\listofacronyms` | phdthesis.cls:289-310 | yes | `\chapter*` + `\@mkboth` + `longtable[c]{#1}#2` |
| `\declaration`, `\acknowledgements`, `\dedicatory` | phdthesis.cls:311-366 | yes | `front.dedication` pages from `\chapter*`, `\null\vskip`, centered heading, text, `enumerate` |
| `\backmatter` | phdthesis.cls:367-375 | yes | book's `\backmatter` (same `\if@openright` branch) plus `\addcontentsline{toc}{chapter}{\bibname}` |
| `xspace` | phdthesis.cls:73,323 | yes | only restores the space after `\@title` in the declaration sentence; the emitter writes the title text inline, so the package is not needed |
| `\pythonstyle`, `python`, `\pythonexternal`, `\pythoninline`, `\algstyle`, `algorithm` | lstdefinitions.tex:13-63 | yes | `\lstset` aliases and `\lstnewenvironment` (`code.listings`); `\pythoninline` is `\text{}` from amsmath |

## Content-opaque
- Image figure.png inside the figure float (chapter1.tex:29).
- Listing text inside the `algorithm` and `python` environments (chapter2.tex:7-11,20-21).
- Table cells (chapter1.tex:40-45) and longtable rows for symbols and acronyms (main.tex:48-51,53-55).
- Bibliography entries (references.bib:1-16).

## Lib changes
- New ways proposed: none. considered: `xspace` (its one use sits inside a bespoke macro and an emitter does not need it, so no way is proposed).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
