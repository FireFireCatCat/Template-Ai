no

# 0604-sdasrc-thesis-template-iitbhu: IIT (BHU) Varanasi IDD/PhD thesis template (class PhDThesisPSnPDF, a fork of the CUED thesis template by K. Kumar)

- Unverified: read from the source, not compiled.
- Source: Source/0604-sdasrc-thesis-template-iitbhu/ (origin: https://codeload.github.com/sdasrc/thesis-template-iitbhu/zip/refs/heads/master; licence: MIT)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (the class branches on `\pdfoutput`, Classes/PhDThesisPSnPDF.cls:395-409, and uses pdfTeX primitives at cls:700-706 and 726-727)
- Look carried by: zip-local (the wrapper class Classes/PhDThesisPSnPDF.cls loads `book` and a package list; Preamble/preamble.tex adds a few packages; the front-matter pages are body files)
- Class origin: zip-local (a student fork of kks32/phd-thesis-template, cls:1-24; not on CTAN, ctan.org/pkg/PhDThesisPSnPDF is a 404; not an official IIT BHU release)
- Main file: thesis-template.tex (other samples: Abstract-standalone/abstract-standalone.tex)
- Read: main yes, zip-local classes and styles all (the one .cls read in full, lines 1-1352; data file Classes/glyphtounicode.tex read to line 40 of 4613; mnras.bst read only at lines 128-167, 1548-1567, 1796-1837; apj.bst not read, the sample does not use it)

## Verdict
The sample's active path reduces to lib ways: a zip-local wrapper that is `\LoadClass{book}` plus published packages, with front-matter environments, a `fancyhdr` style, `nomencl`, `makeidx`, `natbib` and `mnras.bst` all composed from kernel commands and package options. The verdict is `no` because of one class-scope blocker: the class defines an adaptive title page (`\maketitle` with `\computeTitlePageSpacing`) that measures six saved boxes with `\totalheightof` and spends fixed fractions of the leftover height. That is a box-measuring layout algorithm that no lib way with parameters expresses, and the README advertises it (README.MD:30, 151). The sample hand-lays its own title page and never calls `\maketitle` (Titlepage/titlepage.tex:1-36; no `\title`, `\author` or `\maketitle` in any .tex), so under a sample-only reading everything else is reducible; the rubric puts all of the class in scope (item 1), so it stays `no`, tagged `class` for re-reading.

## Blockers
- `BESPOKE/class` adaptive title-page spacing: `\computeTitlePageSpacing` measures six `lrbox` boxes with calc `\totalheightof` and subtracts them from `\textheight` (Classes/PhDThesisPSnPDF.cls:1343-1351); `\maketitle` spends .25, .2 and .2 of that length as `\vspace` (cls:1079, 1083, 1093); unused by the sample (Titlepage/titlepage.tex:1-36)

## Class setting
- Class: `class.book` options: `pdftex,fleqn,openright` fixed by `\LoadClass` (cls:403), plus `12pt`, `a4paper`, `twoside` passed through (cls:331, 345, 348-349; main file thesis-template.tex:5). The wrapper's own options `print`, `numbered`, `index`, `times` select branches in the class (cls:40, 117-126, 48, 54-63). Wrapper itself is zip-local (reducible, see Bespoke code).
- Class-native vocabulary used: from `book`: `\frontmatter` `\mainmatter` `\chapter` `\section` `\subsection` `\subsubsection` `\include` `\appendix`-style env (thesis-template.tex:106, 135, 137-139); from the wrapper: environments `dedication` (cls:1127), `declaration` (cls:1142), `acknowledgements` (cls:1154), `abstract` (cls:1245), commands `\printnomencl` (cls:1185), `\printthesisindex` (cls:1197), `\tochide` (cls:863), `\setFancyHdr` (cls:877). Unused by the sample: `\maketitle`, `\subtitle`, `\degree`, `\dept`, `\college`, `\university`, `\crest`, `\submissiontext`, `\keywords`, `\subject` (cls:969-1009).
- Second sample: `class.article` with `11pt,a4paper` (Abstract-standalone/abstract-standalone.tex:1).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | thesis-template.tex:5; cls:395-409 | `class.book` | `\LoadClass[pdftex,fleqn,openright]{book}`; ifs on `\pdfoutput` pick the pdftex branch (dvips branch cls:398 unselected) |
| paper and size options | thesis-template.tex:5; cls:321-345 | `page.class-options` | a4paper, 12pt, twoside |
| page geometry | cls:755-756 | `page.geometry` | pdftex, paper=a4paper, hmarginratio=1:1, vmarginratio=1:1, scale=0.75, bindingoffset=10mm (option `print`); online branch the same without bindingoffset (cls:793-794); `custommargin` branch left/right/top/bottom=25mm in Preamble/preamble.tex:8 (unselected) |
| pdf page size, head height | cls:726-727, 916 | `page.setlength` | `\pdfpagewidth=\the\paperwidth`, `\pdfpageheight=\the\paperheight`; `\headheight` 14.5pt |
| running heads | cls:874-914 | `hf.fancyhdr` | default style: `\fancyhf{}`, LO `\nouppercase\rightmark`, LE,RO `\bfseries\thepage`, RE `\nouppercase\leftmark`; `\chaptermark` is `\markboth{#1}{}`, `\sectionmark` is `\markright{\thesection\ #1}` (cls:905-910); PageStyleI and II unselected (cls:880-899) |
| plain page style | cls:919-922 | `hf.fancyhdr` | `\fancypagestyle{plain}{\fancyhead{}}` and `\headrulewidth` 0pt |
| empty heads on front pages | cls:1044, 1132, 1145, 1158, 1260 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| blank pages before odd pages | cls:935-939 | `pg.emptypage` | reduction of the redefined `\cleardoublepage` (empty style on the inserted page); load-only |
| page numbering | thesis-template.tex:106; cls:1045, 1055, 947-950 | `pgnum.pagenumbering` | `\frontmatter` (book: roman); titlepage `\setcounter{page}\z@` then `\addtocounter{page}{1}`; `romanpages` env unused |
| line spacing | cls:846; thesis-template.tex:109, 148, 168 | `sp.linespread` | `\renewcommand\baselinestretch{1.2}` |
| spacing package | cls:419; thesis-template.tex:109, 148; cls:1068 | `sp.setspace` | `\doublespacing` after the title page; `spacing` env {0.9} around the bibliography; `singlespace` in `\maketitle` |
| widows and clubs | cls:709-710 | `sp.penalties` | `\clubpenalty=10000`, `\widowpenalty=10000` |
| microtype | cls:713 | `sp.microtype` | `final` |
| alignment | cls:850-858, 1133, 1259 | `sp.ragged` | `\raggedright` only with option `flushleft` (unselected); `\centering` in front pages |
| manual spacing | cls:1131, 1144; Preamble/preamble.tex:205-206 | `sp.manual-space` | `\vspace*{0.2\textheight}`, `\vspace{-3cm}`; `\lspc`=`\hspace{0.1in}`, `\rspc`=`\hspace{0.1in}\\` |
| text and math font | cls:666-669 | `font.mathptmx` | `mathptmx` (option `times`); `fourier` (cls:672, `font.fourier`), `lmodern` (cls:694, `font.lmodern`), `helvet` under `customfont` (Preamble/preamble.tex:20, `font.helvet`) unselected |
| encodings | cls:664, 697-698 | `font.fontenc-t1` | `textcomp`; `inputenc` utf8; `fontenc` T1 |
| font sizes | cls:1071, 1086, 1090; Titlepage/titlepage.tex:3 | `font.size-commands` | `\Huge` `\Large` `\large` |
| emphasis | Titlepage/titlepage.tex:11, 14, 19; Chapter1/chapter1.tex:29, 31 | `mark.kernel` | `\textbf`, `\scshape`, `\textit`, `\em` |
| colours | cls:446; Preamble/preamble.tex:73; thesis-template.tex:81 | `color.color` and `color.xcolor` | `color[usenames,dvipsnames]`; `xcolor`; `\definecolor{shadecolor}{rgb}{0.8,0.8,0.8}` |
| hyperlinks and PDF info | cls:725, 732-746, 761, 829-837 | `meta.hyperref` | unicode=true; print: final, plainpages=false, pdfstartview=FitV, pdftoolbar, pdfmenubar, bookmarksopen, bookmarksnumbered, breaklinks, colorlinks, linkcolor/urlcolor/citecolor/anchorcolor=black, pdfpagelayout=TwoPageRight; online branch blue/green (cls:768-798, unselected); `\hypersetup{pdftitle,pdfauthor,pdfsubject,pdfkeywords}` at begin document |
| url style | cls:809-814 | `meta.url` | `url`; `\urlstyle{leo}` with `\url@leostyle` setting `\UrlFont` to `\normalsize`; `breakurl` only on the dvips branch (cls:819-821) |
| ToUnicode map | cls:700-706 | `meta.glyphtounicode` | `\input{glyphtounicode}`, `\pdfglyphtounicode{f_f}{FB00}` and four more ligatures, `\pdfgentounicode=1` |
| cross references | Chapter1/chapter1.tex:19, 56; Chapter2/chapter2.tex:19, 29, 85 | `xref.kernel` | `\label`, `\ref` |
| link helpers | Chapter1/chapter1.tex:16; Chapter2/chapter2.tex:22; cls:441, 1199 | `xref.hyperref` | `\texorpdfstring`, `\href`, `\url`, `\pdfbookmark[0]`, `\phantomsection` |
| title page (sample) | Titlepage/titlepage.tex:1-36; cls:1036-1056 | `front.titlepage-env` | kernel `titlepage` with `\centering`, `\Large\bfseries`, `\scshape`, `\vfill`; logo in a `figure` (lines 6-9), `table*[bthp]` with a `cc` tabular (lines 27-33); the class env adds `\thispagestyle{empty}`, page 0, and `\addtocounter{page}{1}` after |
| class title commands | cls:969-1009, 1060-1120 | `front.class-native` | `\maketitle`, `\subtitle` `\degree` `\dept` `\college` `\university` `\crest` `\submissiontext`; not called by the sample; adaptive spacing is the blocker |
| default date | cls:466, 974 | `front.datetime` | `datetime`; `\monthname[\the\month]\space\the\year`; timestamp counters cls:468-479 are draft-only |
| dedication, certificate, declaration, copyright, acknowledgements | Certificates/dedication.tex:3-7; Certificates/certificate.tex:2-21; Certificates/declaration.tex:3-33; Certificates/copyright.tex:3-13; Acknowledgement/acknowledgement.tex:3-9; cls:1127-1159 | `front.dedication` | envs of `\cleardoublepage`, `\setsinglecolumn`, `\vspace*{0.2\textheight}`, `\centering`; `\chapter*{\vspace{-3cm} \centering \Large <name>}` plus empty page style; end code is the implicit `\par` of the blank line after each begin group (cls:1135, 1147, 1160, 1263) |
| abstract | Abstract/abstract.tex:3-5; cls:1245-1262 | `abs.class-native` | `abstract` env: `\cleardoublepage`, `\chapter*{\vspace{-3cm}\centering\Large Abstract}`; option `abstract` swaps in a title and author block (cls:1246-1254); text `\input` from Abstract/abstract-text.tex (abstract.tex:4) |
| contents lists | thesis-template.tex:121-125; cls:433-443, 868 | `toc.kernel` | names "Table of contents", "List of figures", "List of tables"; wrapper `\cleardoublepage\pdfbookmark[0]{\contentsname}{Contents}`; `\addtocontents{toc}{\protect\thispagestyle{empty}}`; `\tochide` (cls:862-866, used Chapter2/chapter2.tex:76) |
| bibliography in contents | cls:429 | `toc.etoc` | `tocbibind[nottoc]` |
| depths | Preamble/preamble.tex:149-150 | `num.secnumdepth` | secnumdepth=2, tocdepth=2 |
| headings | Chapter1/chapter1.tex:6, 16; Chapter2/chapter2.tex:15, 33; Chapter3/chapter3.tex:14-37 | `head.kernel` | book chapter and section styles, `\section[short]{long}`, starred; `titlesec` block commented (Preamble/preamble.tex:123-133) |
| appendices | cls:431; thesis-template.tex:172-177 | `num.appendix` | `appendix[title,titletoc]`; `appendices` env, includes commented |
| counter set | Chapter3/chapter3.tex:69 | `num.counters` | `\setcounter{enumi}{2}` |
| lists | Chapter2/chapter2.tex:38-71 | `list.kernel` | `enumerate`, `itemize`, `description`, nested |
| footnote | Chapter2/chapter2.tex:79 | `fn.kernel` | `\footnote` |
| math | Preamble/preamble.tex:67-69; Chapter1/chapter1.tex:28, 34; cls:403 | `math.amsmath`, `math.amssymb`, `math.eqnumber` | `align` env; `amsfonts` `amssymb`; `fleqn` from `\LoadClass` |
| units | Preamble/preamble.tex:70 | `mark.siunitx` | load-only; the `\si` example is commented (Chapter2/chapter2.tex:18) |
| figures | cls:450-453; Chapter2/chapter2.tex:9, 25-30 | `fig.graphicx` | `graphicx[pdftex]`; `\DeclareGraphicsExtensions{.png, .jpg, .pdf}`; `\graphicspath` Figs/Raster, Figs and per chapter; `figure[htbp!]`, `\includegraphics[width=1.0\textwidth]{minion}` |
| EPS conversion | cls:449 | `fig.epstopdf` | loaded on the pdf branch; EXTERNAL only if an EPS is included: the pdf path includes png files only (Chapter2/chapter2.tex:27, 91, 96, 101; Titlepage/titlepage.tex:8), the .eps copies serve the dvips branch (cls:456-457) |
| subfigures | Preamble/preamble.tex:54; Chapter2/chapter2.tex:88-107 | `fig.subcaption` | three `subfigure[b]{0.3\textwidth}` with captions and labels |
| wrapped figures | Preamble/preamble.tex:59 | `fig.wrapfig` | load-only, unused |
| landscape page | cls:418; Chapter2/chapter2.tex:82-110 | `pg.landscape` | `lscape`, `landscape` env |
| tables | Chapter3/chapter3.tex:82-156; Certificates/certificate.tex:14-21 | `tbl.tabular` | `tabular` with `|l|c|c|c|c|` and `\hline`, `\cline`, `\multicolumn`; `table` float, `\centering` |
| table rules and cells | Preamble/preamble.tex:57-58; Chapter3/chapter3.tex:113, 138-154 | `tbl.booktabs`, `tbl.multirow` | `\toprule` `\cmidrule{2-5}` `\midrule` `\bottomrule`; `\multirow{2}{*}{..}` |
| captions | Preamble/preamble.tex:36-37; Chapter2/chapter2.tex:28 | `cap.caption`, `cap.kernel` | `caption[labelsep=space,tableposition=top]`; `\figurename`=Fig.; `\caption[short]{long}` |
| nomenclature | cls:1164-1190; thesis-template.tex:130; Chapter1/chapter1.tex:38-100 | `idx.glossaries` | `nomencl`, `\makenomenclature`; `\nomgroup` list A=Roman Symbols, G=Greek Symbols, Z=Acronyms / Abbreviations, R=Superscripts, S=Subscripts, X=Other Symbols (cls:1166-1179); `\nompreamble` is `\markboth{\nomname}{\nomname}`; `\printnomencl[len]` adds `\addcontentsline{toc}{chapter}{\nomname}`; `\nomenclature[z-cif]{..}{..}` calls |
| index | cls:1194-1203; thesis-template.tex:180; Chapter1/chapter1.tex:31 | `idx.makeidx` | `makeidx`, `\makeindex`, `\cleardoublepage\phantomsection\printindex`; `\index{a@b}` |
| citations | cls:627; Chapter1/chapter1.tex:19; Chapter3/chapter3.tex:17 | `bib.natbib` | `natbib[numbers,sort&compress]`; `\citep`, `\citet`; authoryear branch `round,sort,numbers,authoryear` (cls:618) unselected |
| bibliography | thesis-template.tex:154-157; Preamble/preamble.tex:112 | `bib.bibtex-bst` | `\bibliographystyle{mnras}`, `\bibliography{References/references}`; `\bibname`=References; mnras.bst (CTAN `mnras`, LPPL 1.3, mnras.bst:83-88) is self-contained: it writes `\mn@doi` and `\mn@eprint` into the .bbl (mnras.bst:1815-1821) and keeps `threeauthorvar` at 0 (mnras.bst:167) |
| bibliography, unselected | cls:614, 623, 643; Preamble/preamble.tex:106 | `bib.biblatex-biber` | biber backend, `natbib=true`; `custombib` hook |
| file inclusion | thesis-template.tex:87, 99-101, 108-139; Abstract/abstract.tex:4 | `struct.input` | `\input`, `\include`, `\includeonly{Chapter3/chapter3}` under `\ifdefineChapter` |
| page breaks | thesis-template.tex:156; Chapter2/chapter2.tex:74 | `pg.break` | `\cleardoublepage`, `\clearpage` |
| single column | cls:1014-1025 | `cols.twocolumn-cmd` | `\onecolumn` inside `\setsinglecolumn` and `alwayssingle`; a no-op in this single-column class |
| title-page boxes | cls:1104-1118, 1273-1340 | `box.minipage` | `minipage`, `lrbox`; inside the blocked `\maketitle` only |
| draft mode, unselected | cls:498-606 | `sp.draft-lineno`, `bg.eso-pic`, `pg.textpos`, `color.xcolor`, `fig.graphicx` | `lineno[switch,pagewise,mathlines]` and `\linenomath` wrappers (cls:504-530); every-page banner by `everypage` `\AddEverypageHook` (cls:559, 564-568; considered under `bg.eso-pic`) with `textpos[absolute]` `textblock*` (cls:560-567); `\textcolor[gray]` (cls:554); `\setkeys{Gin}{draft=false}` (cls:500) |
| build run | compile-thesis.sh:71-78 | `bib.bibtex-bst`, `idx.glossaries` | pdflatex, bibtex, makeindex, `makeindex -s nomencl.ist`: TeX distribution tools, not EXTERNAL; the Makefile (generic latex-makefile, Makefile:1-60) is not used by the template |
| second sample | Abstract-standalone/abstract-standalone.tex:1-29 | `class.article`, `page.geometry`, `font.mathptmx`, `sp.setspace`, `pgnum.pagenumbering`, `math.amsmath`, `fig.graphicx` | `11pt,a4paper`; `geometry[margin=25mm]`; `times`; `\doublespacing`; `\pagenumbering{gobble}`; `\section*{\centering..}` headings |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| wrapper class `PhDThesisPSnPDF` | cls:1-1352 | yes | `class.book` plus the packages in the map; `\newif` flags and `\DeclareOption` (cls:39-390) are chosen statically from the sample's options |
| adaptive title page | cls:1060-1120, 1269-1352 | no | measure-then-allocate length algorithm (`\totalheightof` over six boxes); stretch glue only approximates it (the measured length ignores the 1em and 1ex gaps); BESPOKE/class |
| redefined `titlepage` env | cls:1036-1056 | yes | kernel `titlepage`, `\setcounter{page}{0}`, `\addtocounter{page}{1}`, `\thispagestyle{empty}` (`front.titlepage-env`, `num.counters`, `hf.pagestyle-kernel`) |
| redefined `\cleardoublepage` | cls:935-939 | yes | `pg.emptypage` |
| `\tableofcontents` wrapper | cls:438-443 | yes | `\cleardoublepage`, `\pdfbookmark`, original command |
| `\tochide`, `\nocontentsline` | cls:862-866 | yes | `{\let\addcontentsline\nocontentsline <heading>}` with `\newcommand{\nocontentsline}[3]{}`: kernel commands only |
| front-matter envs `dedication` `declaration` `acknowledgements` `abstract` | cls:1127-1262 | yes | begin code written out as in the map; implicit `\par` end code |
| `alwayssingle`, `\setsinglecolumn`, `romanpages` | cls:1014-1025, 947-950 | yes | `\onecolumn`, `\newpage`, `\setcounter{page}{1}`, `\renewcommand{\thepage}{\roman{page}}` |
| `\setFancyHdr` | cls:877-914 | yes | `hf.fancyhdr` calls with the branch chosen by option; also called at cls:931 |
| `\nomgroup`, `\nompreamble`, `\printnomencl`, `\printthesisindex` | cls:1166-1203 | yes | `idx.glossaries` and `idx.makeidx` parameters; the `\ifthenelse{\equal{#1}{A}}` chain is a letter-to-title table |
| `\url@leostyle` | cls:811-814 | yes | `\renewcommand{\UrlFont}{\normalsize}` (`\selectfont` is always defined) |
| info macros `\subtitle` ... `\subject` | cls:969-1009 | yes | string stores feeding `\hypersetup` (cls:829-837); not called |
| draft block and timestamp counters | cls:468-479, 498-606 | yes | `sp.draft-lineno`, `bg.eso-pic`, `pg.textpos`; the `hh:mm` counters reduce to `datetime`'s `\currenttime` (its documentation not read here); unselected |
| `\renewcommand\pdfshellescape{1}` | cls:417 | yes | omit: no printed effect; it only makes `epstopdf` believe write18 is on, relevant when an EPS is converted |
| `\doi`, `\eprint`, `\mniiiauthor` | cls:188-267 | yes | omit: no caller in the sample or in this mnras.bst (`threeauthorvar`=#0, mnras.bst:167, 1555-1560); `\mniiiauthor` would be irreducible if called (per-key global `\let` state) |
| `\Myperm`, `\Mycomb`, `\lspc`, `\rspc` | Preamble/preamble.tex:203-206 | yes | aliases of `\hspace` and math prefixes; `\prescript` needs `mathtools`, which is not loaded; unused in all .tex files |
| journal-name macros | Preamble/adsjournals.tex:3-57 | yes | 55 `\newcommand` text aliases; not loaded (thesis-template.tex:89 commented) |

## Content-opaque
none (the logo and the three figure images are raster files in figure floats, content only; no TikZ or picture code)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
