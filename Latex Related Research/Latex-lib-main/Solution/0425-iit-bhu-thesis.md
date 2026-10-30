no

# 0425-iit-bhu-thesis: IIT BHU Thesis (IDD/PhD thesis class, fork of the CUED PhDThesisPSnPDF template)

- Unverified: read from the source, not compiled.
- Source: Source/0425-iit-bhu-thesis/ (origin: https://latextemplates.com/downloads/iit-bhu-thesis.zip; licence: MIT)
- Kind: thesis
- Lib: v4
- Engine: pdfLaTeX-compatible (pdfTeX primitives `\pdfglyphtounicode`, `\pdfgentounicode`, `\pdfbookmark`; the class also has a DVI/dvips branch, Classes/IITBHUThesisPSnPDF.cls:403-417)
- Look carried by: zip-local (Classes/IITBHUThesisPSnPDF.cls over `book` sets page, heads, fonts, front-matter environments; Preamble/preamble.tex adds float, table, math and caption packages; the title page is hand-laid in Titlepage/titlepage.tex)
- Class origin: zip-local
- Main file: main.tex (other samples: none; Chapter1-3, Titlepage, Certificates, Acknowledgement, Abstract files are `\include`d bodies)
- Read: main yes, zip-local classes and styles all (one .cls, no .sty; `glyphtounicode.tex`, `mnras.bst`, `apj.bst` read in outline only)

## Verdict
no. The look is carried by a zip-local class that is `\LoadClass{book}` plus published packages, and almost all of it reduces (see Component map). It is blocked by hand-written macro logic in that class that no lib way expresses: `\tochide` (called by the sample at Chapter2/chapter2.tex:82) removes one contents entry by nulling `\addcontentsline`; `\maketitle` measures box heights and splits free height into fixed fractions; a draft-mode stamp does clock arithmetic; and `\doi`/`\eprint`/`\mniiiauthor` do catcode and `\csname` dispatch with global state. Only `\tochide` is both defined and called by the sample; the others sit in the class file, which Scope 1 puts in scope, and each is tagged so a narrower "reachable from the sample" reading can be applied (it would leave `\tochide` alone).

## Blockers
- `BESPOKE/class` `\tochide` and `\nocontentsline`: `\bgroup\let\addcontentsline=\nocontentsline#1{#2}\egroup` suppresses a single toc entry of a numbered heading; no lib way hides one entry (Classes/IITBHUThesisPSnPDF.cls:870-874; called Chapter2/chapter2.tex:82)
- `BESPOKE/class` `\maketitle` with `\computeTitlePageSpacing`: boxes measured with `\totalheightof` (calc), free height shared as `.25`, `.2`, `.2` of the remainder (cls:1068-1128, 1277-1360); not called by the sample, which hand-lays its title page (Titlepage/titlepage.tex:1-36)
- `BESPOKE/class` draft-mode block: hand-rolled hour and minute counters for a timestamp (cls:476-487), `\DraftContent` stamped on every page through `\AddEverypageHook` and `textblock*` with computed anchors (cls:559-594), amsmath environment patch loop for `lineno` (cls:518-538); option `draft` is not given by the sample (main.tex:7)
- `BESPOKE/class` `\doi`, `\eprint`, `\mniiiauthor`, `\@urlcharsother`: catcode switch, `\@ifnextchar`, colon-delimited argument parsing, `\csname` dispatch, global per-key flags (cls:196-275); not reached by the sample: `mnras.bst` sets `threeauthorvar` to 0 (mnras.bst:164-167) and writes its own `\mn@doi`/`\mn@eprint` macros into the .bbl (mnras.bst:1809-1822); no `\doi` or `\eprint` in any .tex

## Class setting
- Class: `class.book` options: `a4paper`, `12pt`, `twoside`, `openright`, `fleqn`, `pdftex`, reached through the zip-local class (main.tex:7; cls:339, 353, 356-357, 411). The zip-local class's own options used by the sample: `times`, `print`, `numbered`, `index` (cls:47-48, 55-56, 62-71, 124-134).
- Class-native vocabulary used: `\frontmatter`, `\mainmatter`, `\chapter`, `\chapter*`, `\cleardoublepage`, `titlepage` (zip-local `\renewenvironment`, cls:1044-1064). Zip-local vocabulary used: `dedication`, `declaration`, `acknowledgements`, `abstract` environments, `\printnomencl`, `\printthesisindex`, `\tochide`, `\ifdefineChapter` (cls:1135-1167, 1193-1211, 1253, 870; main.tex:101, 132, 182).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:7; cls:406-415 | `class.book` | a4paper, 12pt, twoside, openright, fleqn |
| paper and size | main.tex:7; cls:343-353 | `page.class-options` | a4paper, 12pt, twoside |
| page geometry (print branch) | cls:738, 763-764 | `page.geometry` | pdftex, paper=a4paper, hmarginratio=1:1, vmarginratio=1:1, scale=0.75, bindingoffset=10mm; inactive: custommargin 25mm four sides (Preamble/preamble.tex:7-10) |
| running heads | cls:882-922 (default branch 911-919), 924, 939 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, LO `\nouppercase\rightmark`, LE,RO `\bfseries\thepage`, RE `\nouppercase\leftmark`; `\chaptermark` `\markboth{#1}{}`, `\sectionmark` `\markright{\thesection\ #1}`; headheight 14.5pt; inactive PageStyleI and II (cls:888-907) |
| plain page style | cls:927-930 | `hf.fancyhdr` | `\fancypagestyle{plain}`: empty head, `\headrulewidth` 0pt |
| empty pages | cls:1052, 1140, 1153, 1166, 1256 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| blank verso pages | cls:943-947 | `pg.emptypage` | reduction of the `\cleardoublepage` redefinition (emptypage does the same on blank pages) |
| page breaks | main.tex:158; Chapter2/chapter2.tex:80; cls:1137 | `pg.break` | `\cleardoublepage`, `\clearpage` |
| page numbering | main.tex:108, 137 (book `\frontmatter` `\mainmatter`) | `pgnum.pagenumbering` | roman then arabic; zip-local `romanpages` unused (cls:955-958) |
| title page counter | cls:1053, 1063 | `num.counters` | `\setcounter{page}\z@` then `\addtocounter{page}{1}` |
| line spacing | cls:854; main.tex:111, 150-170 | `sp.linespread`, `sp.setspace` | baselinestretch 1.2; `\doublespacing`; `spacing` env 0.9 around the bibliography |
| justification | cls:858-866 | `sp.ragged` | `\raggedright` only with option `flushleft` (not given: justified) |
| widow and club penalties | cls:717-718 | `sp.penalties` | clubpenalty=10000, widowpenalty=10000 |
| microtype | cls:721 | `sp.microtype` | final |
| text and math font | cls:674-677; main.tex:7 | `font.mathptmx` | via option `times`; inactive branches: `fourier` (cls:679-681) `font.fourier`, none given `lmodern` (cls:702) `font.lmodern` |
| encodings | cls:672, 705-706 | `font.fontenc-t1` | textcomp; inputenc utf8; fontenc T1 |
| ToUnicode map | cls:708-714; Classes/glyphtounicode.tex | `meta.glyphtounicode` | `\input{glyphtounicode}` (a glyph-list data file of 4499 `\pdfglyphtounicode` lines, header Classes/glyphtounicode.tex:1-18), five ligature entries, `\pdfgentounicode=1` |
| colour | cls:454; Preamble/preamble.tex:73; main.tex:83 | `color.color`, `color.xcolor` | color [usenames, dvipsnames]; xcolor; `\definecolor{shadecolor}{rgb}{0.8,0.8,0.8}` (unused) |
| hyperref | cls:733, 738-754, 768-769 | `meta.hyperref` | unicode=true; final, plainpages=false, pdfstartview=FitV, pdftoolbar, pdfmenubar, bookmarksopen, bookmarksnumbered, breaklinks, colorlinks with link, url, cite, anchor colours black; pdfpagelayout=TwoPageRight |
| PDF metadata | cls:837-846 | `meta.hyperref` | pdftitle, pdfauthor, pdfsubject, pdfkeywords from class macros (the sample sets none of them) |
| toc bookmark | cls:446-451 | `meta.hyperref` | `\pdfbookmark[0]{\contentsname}{Contents}` before the contents (reduction of the `\tableofcontents` wrapper) |
| url style | cls:817-822 | `meta.url` | `\urlstyle{leo}` with `\UrlFont` `\normalsize` (url's documented style hook) |
| title page | Titlepage/titlepage.tex:1-36; cls:1044-1064 | `front.titlepage-env` | `\centering`, `\Large\bfseries`, `\vspace{2cm}`, `\vfill`, `\scshape`, `\textit`, `\textbf`; `\setcounter{page}\z@` |
| title page logo | Titlepage/titlepage.tex:6-9 | `fig.graphicx` | `figure[htbp]`, `\includegraphics[scale=0.3]{IITBHULOGO.png}` |
| title page roll table | Titlepage/titlepage.tex:27-33 | `tbl.tabular` | `table*[bthp]`, `tabular{cc}`, `\hspace{6cm}` |
| title page spacing macro | cls:1068-1128, 1277-1360 | none (`BESPOKE/class`) | see Blockers; sample does not call `\maketitle` |
| dedication | Certificates/dedication.tex:3-7; cls:1135-1142 | `front.dedication` | `\cleardoublepage`, `\vspace*{0.2\textheight}`, `\thispagestyle{empty}`, `\centering` |
| certificate page | Certificates/certificate.tex:2-21 | `front.dedication`, `tbl.tabular` | `\chapter*{\vspace{-3cm} \centering \Large Certificate}`; bold `tabular{llcc}` in `table[htbp]` |
| declaration page | Certificates/declaration.tex:3-33; cls:1150-1154 | `front.dedication`, `tbl.tabular` | `\chapter*{\vspace{-3cm} \centering \Large Declaration}`, `\thispagestyle{empty}`, `\vfill`, `\flushleft` |
| copyright page | Certificates/copyright.tex:3-13 | `front.dedication` | `\chapter*{...Copyright Transfer Certificate}`, `\hspace*`, `\\` |
| acknowledgements page | Acknowledgement/acknowledgement.tex:3-9; cls:1162-1167 | `front.dedication` | `\cleardoublepage`, `\chapter*{\vspace{-3cm} \centering \Large Acknowledgements}` |
| abstract page | Abstract/abstract.tex:3-5; cls:1253-1270 | `pg.break`, `head.kernel`, `sp.manual-space`, `sp.ragged`, `font.size-commands`, `hf.pagestyle-kernel` | normal branch: `\cleardoublepage`, `\chapter*{\vspace{-3cm} \centering \Large Abstract}`, `\thispagestyle{empty}` (inactive `abstract` option branch: title and author page, cls:1254-1261) |
| contents lists | main.tex:123-127; cls:441-443 | `toc.kernel` | names "Table of contents", "List of figures", "List of tables"; `\addtocontents{toc}{\protect\thispagestyle{empty}}` (cls:876) |
| contents entries for lists and bibliography | cls:437 | `toc.etoc` | tocbibind [nottoc] |
| depth | Preamble/preamble.tex:149-150 | `num.secnumdepth` | secnumdepth=2, tocdepth=2 |
| headings | Chapter1/chapter1.tex:6, 17; Chapter2/chapter2.tex:16, 30; Chapter3/chapter3.tex:20-38 | `head.kernel` | `\chapter`, `\section[short]{long}`, `\section*`, `\subsection`, `\subsubsection`; no titlesec (Preamble/preamble.tex:123-133 commented) |
| hidden toc entry | Chapter2/chapter2.tex:82; cls:870-874 | none (`BESPOKE/class`) | see Blockers |
| appendix | cls:439; main.tex:174-179 | `num.appendix` | appendix [title, titletoc]; `appendices` env, empty |
| nomenclature | cls:1172-1198; Chapter1/chapter1.tex:39-46, 73-101; main.tex:132 | `idx.glossaries` | nomencl, `\makenomenclature`, `\nomenclature[z-cif]{sym}{text}`, `\nomgroup` letter to title table (A Roman, G Greek, Z Acronyms, R Superscripts, S Subscripts, X Other; cls:1174-1187), `\nompreamble` `\markboth` (cls:1190), toc line `\addcontentsline{toc}{chapter}{\nomname}` (cls:1197) |
| index | cls:1202-1208; main.tex:182; Chapter1/chapter1.tex:32 | `idx.makeidx` | `\makeindex`, `\index{key@text}`, `\cleardoublepage\phantomsection\printindex` |
| lists | Chapter2/chapter2.tex:44-77; Chapter3/chapter3.tex:54-57, 70-78 | `list.kernel`, `num.counters` | enumerate, itemize, description, two levels; `\setcounter{enumi}{2}` |
| maths | Chapter1/chapter1.tex:29, 35-37; Preamble/preamble.tex:67-69 | `math.amsmath`, `math.amssymb`, `math.eqnumber` | `align`; amsfonts, amssymb; `fleqn` (cls:411) |
| footnote | Chapter2/chapter2.tex:93 | `fn.kernel` | `\footnote{...}` |
| cross-references | Chapter1/chapter1.tex:7, 57; Chapter2/chapter2.tex:20 | `xref.kernel` | `\label`, `\ref` |
| figure | Chapter2/chapter2.tex:22-27; cls:455-461 | `fig.graphicx`, `fig.epstopdf` | `\includegraphics[width=1.0\textwidth]`; `\DeclareGraphicsExtensions{.png, .jpg, .pdf}`; `\graphicspath{{Figs/Raster/}{Figs/}}`; epstopdf loaded, no EPS file in the sample |
| subfigures | Chapter2/chapter2.tex:107-126; Preamble/preamble.tex:54 | `fig.subcaption` | three `subfigure[b]{0.3\textwidth}` |
| landscape page | Chapter2/chapter2.tex:101-129; cls:426 | `pg.landscape` | lscape, `landscape` environment |
| captions | Preamble/preamble.tex:36-37 | `cap.caption` | labelsep=space, tableposition=top; `\figurename` "Fig." |
| tables | Chapter3/chapter3.tex:83-157 | `tbl.tabular`, `tbl.multirow`, `tbl.booktabs` | `\hline`, `\cline`, `\multicolumn`; `\multirow{2}{*}`; `\toprule` `\cmidrule` `\midrule` `\bottomrule` |
| loaded, not used | Preamble/preamble.tex:59, 70 | `fig.wrapfig`, `mark.siunitx` | wrapfig; siunitx |
| bibliography | cls:635; main.tex:156-159; Preamble/preamble.tex:112 | `bib.natbib`, `bib.bibtex-bst` | natbib [numbers, sort&compress]; `\bibliographystyle{mnras}` with zip-local mnras.bst (also in the CTAN `mnras` bundle); `\bibname` "References" |
| citations | Chapter1/chapter1.tex:20, 27; Chapter3/chapter3.tex:18 | `bib.natbib` | `\citep`, `\citet` |
| multi-file | main.tex:101-103, 110-119, 139-141 | `struct.input` | `\include`, `\includeonly{Chapter3/chapter3}` under option `chapter` (inactive, cls:1219-1221) |
| date format | cls:474, 982 | `front.datetime` | datetime package; `\monthname` in the unused `\degreedate` default |
| draft mode (inactive) | cls:512, 567-568 | `sp.draft-lineno`, `pg.textpos` | lineno [switch, pagewise, mathlines]; textpos [absolute]; the rest is bespoke (see Blockers) |
| manual spacing and fonts | Titlepage/titlepage.tex:4, 14-25 | `sp.manual-space`, `mark.kernel`, `font.size-commands` | `\vspace`, `\hspace`, `\vfill`; `\textbf`, `\textit`, `\scshape`; `\Large` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option switches (`\newif`, `\DeclareOption`, nested `\ifPHD@...`) | cls:47-152, 282-322, 620-703 | yes | write the branch the options select: natbib [numbers,sort&compress], mathptmx, geometry print line, hyperref print line |
| `\LoadClass` pdf/DVI branching | cls:403-417 | yes | take the pdfTeX branch: `class.book` [pdftex, fleqn, openright] |
| `\renewcommand\pdfshellescape{1}` | cls:425 | yes | no printed effect; drop |
| `\renewenvironment{titlepage}` | cls:1044-1064 | yes | `\thispagestyle{empty}`, `\setcounter{page}{0}`, then `\clearpage\addtocounter{page}{1}` (`num.counters`, `hf.pagestyle-kernel`) |
| `\cleardoublepage` redefinition | cls:943-947 | yes | `pg.emptypage` |
| `\tableofcontents` wrapper | cls:446-451 | yes | `\cleardoublepage` then `\pdfbookmark` then the kernel command |
| `dedication`, `declaration`, `acknowledgements`, `abstract` | cls:1135-1167, 1253-1270 | yes | inline kernel commands, rows in Component map |
| `romanpages`, `alwayssingle`, `\setsinglecolumn` | cls:955-958, 1022-1033 | yes | `\pagenumbering{roman}`; `\onecolumn` is a no-op in the one-column `book` |
| `\nomgroup` chain and `\printnomencl` | cls:1174-1198 | yes | nomencl's documented `\nomgroup` heading table plus `\printnomenclature` and `\addcontentsline` (`idx.glossaries`, `toc.kernel`) |
| `\url@leostyle` | cls:819-822 | yes | `\urlstyle{leo}` with `\UrlFont`: `meta.url` |
| front-matter data macros `\subtitle` `\degree` `\dept` `\college` `\university` `\crest` `\keywords` `\subject` | cls:977-1017 | yes | storage macros; unused by the sample |
| `\Myperm` `\Mycomb` `\lspc` `\rspc` | Preamble/preamble.tex:203-206 | yes | `\hspace{0.1in}` aliases; the two maths macros call `\prescript` (mathtools, not loaded); never used |
| journal-name aliases | Preamble/adsjournals.tex:3-57 | yes | 55 `\newcommand` text aliases; file not loaded (main.tex:91) |
| `\tochide`, `\nocontentsline` | cls:870-874 | no | `BESPOKE/class`, see Blockers |
| `\maketitle`, `\computeTitlePageSpacing` | cls:1068-1128, 1277-1360 | no | `BESPOKE/class`, see Blockers |
| draft-mode timestamp, stamp, lineno patch | cls:476-487, 518-538, 559-594 | no | `BESPOKE/class`, see Blockers |
| `\doi`, `\eprint`, `\mniiiauthor`, `\@urlcharsother` | cls:196-275 | no | `BESPOKE/class`, see Blockers |

## Content-opaque
none (the figures are included PNG images: Figs/IITBHULOGO.png, Chapter2/Figs/Raster/PlaceholderA.png, PlaceholderB.png, PlaceholderC.png; shipped, no missing assets)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes: `nomencl` and `makeidx` need `makeindex`, and `mnras.bst` needs `bibtex`; these are standard TeX-distribution passes, as for `idx.glossaries` and `bib.bibtex-bst`, so no EXTERNAL blocker is raised. `epstopdf` is loaded unconditionally (cls:457) but the sample includes no `.eps` file, so `fig.epstopdf` is not EXTERNAL here. The kernel name strings `\contentsname`, `\listfigurename`, `\listtablename`, `\figurename`, `\bibname` (cls:441-443; Preamble/preamble.tex:37, 112) are set under the way of the command they name (`toc.kernel`, `cap.caption`, `bib.bibtex-bst`). `apj.bst` is shipped but not selected (main.tex:156). The class is a renamed fork (cls:30-38); ctan.org/pkg/phdthesispsnpdf returned 404, so it is zip-local.
