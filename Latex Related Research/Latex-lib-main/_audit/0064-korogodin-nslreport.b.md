no

# 0064-korogodin-nslreport: NSLReport (NavSysLab report/book/dissertation/ESKD framework)

- Unverified: read from the source, not compiled.
- Source: Source/0064-korogodin-nslreport/ (origin: https://codeload.github.com/Korogodin/NSLReport/zip/refs/heads/master; licence: GPL-3.0 per manifest, `LICENSE.md`; class header says "GNU GPL v2 and compatible", sty/NSLReport.cls:3)
- Kind: book (main sample is a Russian textbook draft, GOST R 7.0.11 style; the zip also holds a dissertation sample and an ESKD GOST 2.105 form sample)
- Lib: v2
- Engine: pdfLaTeX-compatible (Makefile:4 `LATEX=pdflatex`; `fontenc[T1,T2A]`, `inputenc[utf8]`, `babel[english,russian]`, sty/NSLExtra.sty:86-88; biblatex backend biber)
- Look carried by: zip-local (a hand-modified `report.cls` copy `NSLReport.cls` plus two zip-local styles `NSLExtra.sty` and `NSLBook.sty` carry the look; the title page and the imprint page sit in the sample body)
- Class origin: zip-local (ctan.org/pkg/nslreport is a 404; the zip is the author's GitHub master, not an official release)
- Main file: examples/book/rpz.tex (other samples: examples/disser/rpz.tex, examples/eskd_fo/rpz.tex)
- Read: main yes (rpz.tex, preamble.inc.tex, macros.inc.tex, listings.inc.tex and every included part 00-titleBook, 00-abstract, 02-intro, 20-analysis, 40-simulation, 90-conclusion, 92-biblio, 95-appendix1, 99-lastpage; 00-acro is commented out in rpz.tex:23, read anyway), zip-local classes and styles all (NSLReport.cls, NSLExtra.sty, NSLBook.sty, NSLDisser.sty, NSLEskd.sty; NSLDisser.sty lines 65-512 are all comments and were skimmed by grep for non-comment lines). Of the other two samples I read rpz.tex, title/abstract/appendix/lri/ly parts, and only grep-outlined eskd_fo/11-description.tex (659 lines).

## Verdict
No. The look is carried by zip-local code, and most of it reduces to lib ways (see the component map and bespoke table), but three things do not: the title page of the main sample is framed by a hand-placed `picture` drawing (ART), the "total figures/tables/appendices" statistics line on the imprint page runs on hand-rolled counters written into the `.aux` file (BESPOKE), and the Russian GOST alphabetic counter format is a hand-written `\ifcase` table (BESPOKE, small). The ESKD sample adds a much larger ART blocker (three full page frames drawn with `picture`). Nothing was compiled.

## Blockers
- `ART/body` title-page frame drawn with `\begin{picture}(0,0)` and five `\put(..){\line(..)}` rules at fixed mm coordinates (examples/book/00-titleBook.tex:5-11)
- `BESPOKE/class` hand-rolled total counters: `\chapter` adds `\value{figure}`/`\value{table}` to `totfigures`/`tottables` (sty/NSLReport.cls:425-426); `\AtEndDocument` writes `\gdef\totfig...` into `\@mainaux` (sty/NSLExtra.sty:235-268); printed through `\ifnum\totfig>0 ...` on the imprint page (examples/book/00-abstract.tex:41-56)
- `BESPOKE/class` GOST 7.32 Cyrillic alphabet counter format: `\asbuk`/`\Asbuk` redefined through `\ifcase` letter tables that skip letters, falling back on babel-internal `\xpg@ill@value` (sty/NSLExtra.sty:95-106), used by enumerate labels and appendix letters (sty/NSLReport.cls:699-709, 839)
- `ART/class` (other sample, eskd_fo) three page frames `\titleFrame`, `\zaglavFrame`, `\posledFrame` drawn with `picture`/`\put`/`\line`/`\rotatebox` incl. the GOST 2.104 title block (sty/NSLEskd.sty:61-218), installed through raw `\def\@oddhead{\titleFrame}` (examples/eskd_fo/00-title.tex:4, 00-abstract.tex:8,37, 99-ly.tex:4)

Not counted as blockers (recorded): the Makefile turns `graphics/svg/*.svg` into `inc/svg/*.pdf` (inkscape + pdfcrop, Makefile:67-81) and `graphics/img/*` into `inc/img/*.pdf` (ImageMagick, Makefile:83-92), and converts `src/` to KOI8-R with iconv (Makefile:32,95-97) for listings. The `.tex` sources are not generated; the three included figures (examples/book/40-simulation.tex:34,55; 95-appendix1.tex:15) are figure artwork, i.e. content with missing assets. The book sample calls no listing. biber is the backend of the accepted way `bib.biblatex-biber`.

## Class setting
- Class: zip-local `NSLReport` (examples/book/rpz.tex:2 `\documentclass[14pt]{../sty/NSLReport}`), no published way of that name. Published reduction target: `class.extreport`, options `14pt`, `a4paper`, `oneside`, `onecolumn`, `openany`. Basis: NSLReport is report.cls with `\input{size14.clo}` (sty/NSLReport.cls:101-104; `size14.clo` is the extsizes file) and `\ExecuteOptions{a4paper,14pt,oneside,onecolumn,final,openany}` (line 101). Stock `report` has no `14pt`.
- Class-native vocabulary used by the sample: `\chapter`, `\chapter*`, `\section`, `\section*`, `\subsection`, `\subsubsection`, `\paragraph{}` and `\subparagraph{}` (redefined as numbered run-in points with empty titles, 20-analysis.tex:27-29, 40-simulation.tex:9-26), `titlepage`, `\tableofcontents`, `\appendix`, `figure`, `table`, `itemize`, `enumerate`, `\today`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | sty/NSLReport.cls:36-104; rpz.tex:2 | `class.extreport` | 14pt, a4paper, oneside, onecolumn, final, openany (reduction of the zip-local class) |
| paper size | sty/NSLReport.cls:46,101 | `page.class-options` | a4paper |
| page geometry | sty/NSLExtra.sty:286; sty/NSLBook.sty:28-32 | `page.geometry` | right=15mm, left=30mm, top=20mm, bottom=20mm, headsep=0pt, includefoot then ignorefoot |
| raw page lengths | sty/NSLBook.sty:84-85 | `page.setlength` | `\voffset`=-6mm, `\headsep`=5mm |
| running head and foot | sty/NSLBook.sty:63-82 | `hf.fancyhdr` | `\pagestyle{fancy}`, lhead=`\small\nouppercase{\leftmark}`, chead/rhead/cfoot empty, `\fancyfoot[LE,RO]{\thepage}`, headrulewidth 0.5pt, footrulewidth 0pt, `\fancypagestyle{chapterpage}` (heads empty, no rule) |
| per-page style switches | 02-intro.tex:2; 20-analysis.tex:3; 40-simulation.tex:3; 00-titleBook.tex:16; 00-abstract.tex:3; 99-lastpage.tex:1 | `hf.pagestyle-kernel` | `\thispagestyle{chapterpage}` and `{empty}` |
| page numbering | sty/NSLReport.cls:1251; 00-abstract.tex:106 | `pgnum.pagenumbering` | arabic; `\setcounter{page}{2}` |
| total page count | sty/NSLExtra.sty:235; 00-abstract.tex:40 | `pgnum.lastpage` | `\pageref{LastPage}` |
| line spacing | sty/NSLReport.cls:1274 | `sp.linespread` | 1.3 |
| paragraph lengths | sty/NSLReport.cls:333,1276 | `sp.lengths` | parindent=12,5mm, parskip=0mm |
| penalties | sty/NSLReport.cls:1003-1004 | `sp.penalties` | clubpenalty=10000, widowpenalty=10000 |
| hyphenation | preamble.inc.tex:1; sty/NSLReport.cls:1001; sty/NSLExtra.sty:82-83 | `sp.hyphenat` | `\sloppy`; raw TeX parameters `\righthyphenmin=2`, `\lccode`\-=`\-`, `\defaulthyphenchar=127` (nearest home; the lib line names `hyphenat`, `\hyphenation`, `\sloppy`) |
| microtypography | sty/NSLExtra.sty:290 | `sp.microtype` | defaults |
| manual spacing and alignment on the pages | 00-titleBook.tex:14-37; 00-abstract.tex:12-100; 99-lastpage.tex:7-28 | `sp.manual-space` | `\vspace` 1ex..25ex and mm/cm, `\hfill`, `\vfill`, `\noindent` |
| alignment | 00-titleBook.tex:20; 00-abstract.tex:14,102 | `sp.ragged` | `centering`, `center`, `flushright` |
| encodings | sty/NSLExtra.sty:86-87,284 | `font.fontenc-t1` | fontenc T1,T2A; inputenc utf8; textcomp |
| font sizes | 00-titleBook.tex:24-30; sty/NSLReport.cls:361-363 | `font.size-commands` | `\large`, `\Large`, `\huge`, `\small`, `\footnotesize` |
| symbol glyphs | sty/NSLExtra.sty:283 | `font.icons` | `gensymb` (degree, micro) |
| language | sty/NSLExtra.sty:88; sty/NSLBook.sty:16-23 | `lang.babel` | english,russian; `\addto\captionsrussian{\def\contentsname{Содержание}}` |
| quotation marks | sty/NSLBook.sty:40 | `lang.csquotes` | loaded after biblatex |
| PDF links and bookmarks | sty/NSLExtra.sty:46-50; 02-intro.tex:222 | `meta.hyperref` | bookmarks=true, colorlinks=true, unicode=true, all link colours black; `\url` |
| cross-references | 20-analysis.tex:2,84,97; 95-appendix1.tex:4,7 | `xref.kernel` | `\label`, `\ref`, `\pageref` |
| title page | 00-titleBook.tex:2-41 | `front.titlepage-env` | `titlepage`, centred author, title `\Large\textsc`, `Москва~2022` at `\vfill`; the frame inside it is ART |
| imprint / copyright page (UDK, BBK, reviewers, ISBN, annotation) | 00-abstract.tex:1-106 | `front.dedication` | built from `box.minipage` and `sp.manual-space`; statistics line depends on the bespoke counters |
| imprint boxes | 00-abstract.tex:4,28,35,38,62,69,83,93 | `box.minipage` | `\parbox[t]{.45\linewidth}`, `minipage` widths 0.94/0.06/0.3 `\textwidth` |
| colophon page | 99-lastpage.tex:1-30 | `front.dedication` | centred lines, `\textsf`, `\textbf` |
| contents | sty/NSLReport.cls:1036-1047; rpz.tex:20-21 | `toc.kernel` | `\tableofcontents` on `\chapter*`; `\setcounter{tocdepth}{1}` |
| contents entry layout | sty/NSLReport.cls:1031-1033,1084-1095 | `toc.tocloft` | reduction: indents chapter 0mm/1.2em, section .8em/2em, subsection 3.8em/3.2em, subsubsection 7em/4.1em; pnumwidth 1.55em, rmarg 2.55em, dotsep 4.5 |
| depth counters | sty/NSLReport.cls:404,1035; rpz.tex:20 | `num.secnumdepth` | secnumdepth=5 (4 after `\appendix`), tocdepth=2 then 1 |
| section heads | sty/NSLReport.cls:511-547 | `head.kernel` | `\@startsection{section}{1}{\NSLTitleIndent}{3.2ex}{1.2ex}{\normalfont\bfseries}`; subsection, subsubsection alike; sty/NSLExtra.sty:37-42 adds `\subsubsubsection` |
| chapter heads, chapter*, run-in numbered paragraphs, appendix chapter head | sty/NSLReport.cls:425-500,576-618,858-868; sty/NSLBook.sty:44-60 | `head.titlesec` | reduction: chapter `[display]` book look (`\huge\bfseries`, "Глава N" in `\Large`, 3cm after), chapter* centred `\large\bfseries`, paragraph/subparagraph `runin` with `\theparagraph` |
| counters and numbering | sty/NSLReport.cls:404-416,911-913,934-936,957-959,1219 | `num.counters` | section/figure/table/equation/footnote reset by chapter; `\thesection` etc. hierarchical; `\thefigure` with chapter prefix |
| appendix | sty/NSLReport.cls:833-868; 95-appendix1.tex:3 | `num.appendix` | `\appendix`, `\thechapter`=`\Asbuk{chapter}`, `\appendixname` in head and toc entry |
| unordered and ordered lists | 02-intro.tex:24-38,105-111; 95-appendix1.tex:50-56 | `list.kernel` | itemize with `~--` labels (sty/NSLReport.cls:693-696); enumerate labels `\asbuk{enumi})` (699-709) |
| list label machinery | sty/NSLExtra.sty:109-111 | `list.enumitem` | `\AddEnumerateCounter{\Asbuk}{\@Asbuk}{Я}` and `\asbuk`; eskd sample uses `[itemsep=0ex, leftmargin=0.6cm]` (eskd_fo/11-description.tex:98) |
| list indents | sty/NSLReport.cls:624-642 | `sp.lengths` | leftmargini 2.5em, leftmarginii 0mm, labelsep .5em |
| display maths | 20-analysis.tex:33-44; 40-simulation.tex:42-44 | `math.amsmath` | amsmath, `equation`, `\[ \]`, `\left..\right` |
| math symbols | sty/NSLExtra.sty:144; sty/NSLReport.cls:921-922 | `math.amssymb` | `\leq`/`\geq` redefined to `\leqslant`/`\geqslant` |
| decimal comma | sty/NSLExtra.sty:146 | `math.icomma` | load only |
| equation numbering | sty/NSLReport.cls:911-913 | `num.counters` | `\@addtoreset{equation}{chapter}`, `\theequation`=chapter.number |
| figures | 40-simulation.tex:32-37,53-58; 95-appendix1.tex:13-18 | `fig.graphicx` | `\includegraphics[keepaspectratio,width=0.8\textwidth]`, `[width=0.75\textwidth]`, `\centering` |
| float placement | sty/NSLReport.cls:117-126,944,961; 95-appendix1.tex:13 | `fig.placement` | `\fps@figure`=tbp, topnumber 2, topfraction .7, bottomnumber 1, textfraction .2 |
| `[H]` and new float | sty/NSLExtra.sty:225; sty/NSLBook.sty:87-96; 20-analysis.tex:75 | `fig.float` | `\floatstyle{ruled}`, `\newfloat{example}{thp}{lop}[chapter]`, `\restylefloat*`, `\floatname{example}{Пример}` |
| tables | 95-appendix1.tex:22-72 | `tbl.longtable` | `longtable` `{|c|p{4cm}|p{11cm}|}`, `\endfirsthead`, `\endhead`; `\LTleft=\z@`, `\LTright=\fill` (sty/NSLExtra.sty:216-218) |
| table cells | 95-appendix1.tex:25,49-56; sty/NSLExtra.sty:223 | `tbl.tabular` | column specs, `\hline`, `\multicolumn`, itemize inside a cell; `multirow` loaded (used in eskd_fo/98-lri.tex:9) |
| table lengths | sty/NSLReport.cls:899-902 | `sp.lengths` | tabcolsep 6pt, arraycolsep 5pt, arrayrulewidth .4pt |
| captions | sty/NSLExtra.sty:197-212 | `cap.caption` | `normal,nooneline`; labelsep=emdash (`\DeclareCaptionLabelSeparator*`), aboveskip=10pt, belowskip=0pt, position=bottom; figure: justification=centering, labelformat "Рисунок #2"; table: position=top, aboveskip=5pt, justification=justified |
| caption command | 40-simulation.tex:35; 95-appendix1.tex:23 | `cap.kernel` | `\caption`, `\label` |
| source code listings | examples/book/listings.inc.tex:3-76; sty/NSLExtra.sty:293 | `code.listings` | `\lstset{basicstyle=\footnotesize, breaklines, numbers=left, frame=single, tabsize=4, inputencoding=koi8-r...}`, three `\lstdefinestyle`, two `\lstdefinelanguage` with `literate=`, `\lstlistingname`=Листинг; loaded unconditionally; no listing in the book sample |
| bibliography | sty/NSLBook.sty:35-39; preamble.inc.tex:26; 92-biblio.tex:8-12 | `bib.biblatex-biber` | `backend=biber, bibencoding=utf8, style=gost-numeric, sorting=none, refsegment=chapter`; `\addbibresource{rpz.bib}`; `\defbibheading{subbibforcha}`; `\printbibliography[heading=subbibforcha,segment=\therefsegment]`; `\renewcommand*{\bibfont}{\small}` |
| citations | 02-intro.tex:67; 20-analysis.tex:50,137 | `bib.biblatex-biber` | `\cite`, `\cite[стр. 8, 11]{..}`, `\autocite` |
| emphasis | 02-intro.tex:53; 20-analysis.tex:25,53 | `mark.kernel` | `\textbf`, `\textit`, `\textsc`, `\textsf` |
| running-head override in chapter* parts | 02-intro.tex:3-4; 20-analysis.tex:4; 90-conclusion.tex:2,8 | `hf.fancyhdr` | `\let\oldleftmark=\leftmark`, `\renewcommand{\leftmark}{Пролог}`; reduction `\markboth{Пролог}{}` (see bespoke table) |
| title-page frame | 00-titleBook.tex:5-11 | `art.pstricks` | `picture` lines; ART blocker |
| ESKD page frames (other sample) | sty/NSLEskd.sty:61-218 | `art.pstricks` | `picture`; ART blocker; uses `pg.landscape` (`lscape`, eskd_fo/preamble.inc.tex:19; 11-description.tex:504) |
| footnotes (defined, not used in the book body) | sty/NSLReport.cls:1215-1223 | `fn.kernel` | `\footnoterule` kern/hrule .4\columnwidth, `\@makefntext`, reset per chapter |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| NSLReport.cls option block and size file | sty/NSLReport.cls:36-104 | yes | `class.extreport` options as listed |
| `\maketitle`, `titlepage`, `\@maketitle` copies | sty/NSLReport.cls:172-259,800-829 | yes, not exercised | the sample hand-lays its own title page and calls `\title{}` empty (rpz.tex:16); report-like `front.maketitle` |
| `ps@headings`, `ps@myheadings` | sty/NSLReport.cls:129-168 | yes, inert | replaced by `\pagestyle{fancy}` in NSLBook.sty:64 |
| heading machinery (`\@chapter`, `\@makechapterhead`, `\@schapter`, `\@makeschapterhead`, `\paragraph`/`\subparagraph` via `\secdef`) | sty/NSLReport.cls:425-500,576-618; sty/NSLBook.sty:44-60 | yes | `head.kernel` for section levels, `head.titlesec` for chapter, chapter*, run-in numbered paragraphs; the `\NSL...` lengths are lengths (NSLReport.cls:348-358) |
| appendix: `\gdef\@chapter` redefinition and `\@makeappendixhead` | sty/NSLReport.cls:833-868 | yes | `num.appendix` plus `head.titlesec` with `\thechapter`=`\Asbuk{chapter}`; depends on the alphabet item below |
| toc line macros `\l@*`, `\@pnumwidth`, `\@dotsep` | sty/NSLReport.cls:1031-1096 | yes | `toc.tocloft` parameters in the map |
| list and enumerate label macros | sty/NSLReport.cls:624-709 | yes (except the alphabet) | `list.enumitem` / `sp.lengths` |
| `\@makecaption` and `\abovecaptionskip` | sty/NSLReport.cls:983-997 | yes, inert | the `caption` package (NSLExtra.sty:197) takes over |
| `thebibliography`, `\newblock` | sty/NSLReport.cls:1141-1160 | yes, inert | biblatex replaces it |
| `\leq`/`\geq` aliases | sty/NSLReport.cls:921-922 | yes | alias to `\leqslant`/`\geqslant` (`math.amssymb`) |
| total-figures/tables/appendices counters | sty/NSLReport.cls:425-426; sty/NSLExtra.sty:235-268; 00-abstract.tex:41-56 | no | hand-rolled accumulation hooked into `\chapter`, `\AtEndDocument` and a `\gdef` written to `\@mainaux`, driving printed text; no lib way holds it (`pgnum.lastpage` gives only the last page; a `totcount`-style total would still need the chapter hook) |
| GOST `\asbuk`/`\Asbuk` alphabet | sty/NSLExtra.sty:95-106 | no (small) | an `\ifcase` letter table that omits letters, with a babel-internal overflow call; no published declarative alphabet parameter found; the smallest of the blockers, a reader who accepts a custom counter-format macro as reducible may reclassify it |
| `\subsubsubsection` | sty/NSLExtra.sty:37-42 | yes | `head.kernel` counter plus `\@startsection` |
| `\newif\ifNSLHaveLRI/LY/ESKDFrame` switches | sty/NSLExtra.sty:270-280; eskd_fo/rpz.tex:38-44 | yes | decided at emit time: include or omit the page |
| `\No` alias | sty/NSLExtra.sty:282 | yes | `\textnumero` |
| `\newif\ifrusver` and `\floatname` switch | sty/NSLBook.sty:13-14,92-96 | yes | constant `\floatname{example}{Пример}` |
| `\gostacronymsname`, `\gostbibname`, `\ifdefined\gostbibname \renewcommand\bibname...` | sty/NSLBook.sty:24-25; 92-biblio.tex:10 | yes | string alias, caption-name override (`lang.babel`) |
| `\let\oldleftmark=\leftmark` / `\renewcommand{\leftmark}` toggling | 02-intro.tex:3-4; 20-analysis.tex:4; 90-conclusion.tex:2,8 | yes | `\markboth` on the starred chapter; the redefinition as written depends on which page is shipped out while it is in force |
| `\chapter` heading line `\\ \Large \chaptername~\thechapter \\ \p@` | sty/NSLBook.sty:50 | yes | covered by the `head.titlesec` reduction; effect of the trailing `\p@` not established (read, not compiled) |
| `\include{listings.inc}` inside a style | sty/NSLExtra.sty:293 | yes | `code.listings` declarations; the style needs `listings.inc.tex` next to the document |
| `\newcommand{\Code}` | examples/book/macros.inc.tex:2 | yes | alias for `\textbf`; not called in the book sample |
| ESKD string macros (`\decim`, `\docType`, `\razrab`...) | sty/NSLEskd.sty:16-25 | yes | strings |
| ESKD frames `\titleFrame`, `\zaglavFrame`, `\posledFrame` and header takeover by `\def\@oddhead` | sty/NSLEskd.sty:61-218; eskd_fo/00-title.tex:2-7 | no | `ART/class`; absolute-coordinate drawing of the GOST 2.104 frame and title block |
| title-page rules | examples/book/00-titleBook.tex:5-11 | no | `ART/body` |

## Content-opaque
- Figures inc/svg/simulation/LegacySignalsOscSpectr and inc/svg/analysis/hgraph0 (40-simulation.tex:34,55) and inc/img/appx/xkcd (95-appendix1.tex:15): artwork inside figure floats. Their `inc/*.pdf` files are not in the zip (sources in graphics/svg and graphics/img; produced by the Makefile), a missing-asset note.
- Display equations (20-analysis.tex:33-44, 40-simulation.tex:42-44), the two example-float formulas (20-analysis.tex:85-91), long table contents (95-appendix1.tex:33-70).
- `blindtext` loaded (sty/NSLExtra.sty:288); it supplies placeholder-text commands, none is called in the main sample.
- `rpz.bib` (2205 lines of entries).

## Lib changes
- New ways proposed: none.
- `class.extreport` is written plainly as a class way (the lib's class section is filled by script); `NSLReport` itself is zip-local.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
