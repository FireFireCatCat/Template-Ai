no

# 0064-korogodin-nslreport: NSLReport (NavSysLab GOST kit: report, book, dissertation, ESKD document)

- Unverified: read from the source, not compiled.
- Source: Source/0064-korogodin-nslreport/ (origin: https://codeload.github.com/Korogodin/NSLReport/zip/refs/heads/master; licence: GPL-3.0 per manifest, class header says "GNU GPL v2 and compatible", sty/NSLReport.cls:2)
- Kind: book (the manifest hint "misc" is wrong; the main sample is a university textbook draft, the kit also holds a dissertation and a GOST 2.105 form)
- Lib: v1
- Engine: pdfLaTeX-compatible (Makefile:4 `LATEX=pdflatex`; fontenc T1,T2A + inputenc utf8 + babel russian, biblatex with biber)
- Look carried by: zip-local (the zip-local class NSLReport.cls, NSLExtra.sty and NSLBook.sty define the look; the sample preamble adds only `\sloppy` and the .bib, examples/book/preamble.inc.tex:1,26)
- Class origin: zip-local (NSLReport.cls is a hand-edited copy of report.cls, sty/NSLReport.cls:25; ctan.org/pkg/nslreport returned 404)
- Main file: examples/book/rpz.tex (other samples: examples/disser/rpz.tex, examples/eskd_fo/rpz.tex)
- Read: main yes (rpz.tex and every file it includes, 00-acro.tex too), zip-local classes and styles all (NSLReport.cls, NSLExtra.sty, NSLBook.sty, NSLDisser.sty, NSLEskd.sty); disser and eskd_fo samples only skimmed (their rpz.tex, preambles, title pages, 11-description outline)

## Verdict
no. Most of the class and style code reduces to published ways (extreport 14pt, titlesec, tocloft, fancyhdr, caption, float, biblatex, listings). Three things do not: the book cover frame drawn with a `picture` environment (ART), the figure/table/appendix totals that are counted by hand-rolled counters and written to the .aux for the annotation page (BESPOKE), and the hand-written GOST Cyrillic counter alphabet that feeds list labels and appendix letters (BESPOKE).

## Blockers
- `ART/body` book cover frame: `picture(0,0)` with five `\put(..){\line(..)}` rules, the outer rectangle 176.26 x 277 mm plus an inset rule under the top (examples/book/00-titleBook.tex:5-11). It is the template's cover identity; a fixed-size `\fbox` plus `\rule` would not give the inset rule or the page-relative placement, so no declarative way is shown.
- `BESPOKE/class` float/table/appendix totals: counters `totfigures` `tottables` `totappendices`, summed at every `\chapter` (sty/NSLReport.cls:425-426), summed again and `\immediate\write\@mainaux{\gdef\totfig..}` at `\AtEndDocument` (sty/NSLExtra.sty:235-268), with `\NSL@HaveAppendicestrue` set in `\appendix` (sty/NSLReport.cls:835), printed with `\ifnum\totfig>0 ...` in the annotation page (examples/book/00-abstract.tex:41-56). The lib's `pgnum.lastpage` gives page count only; no lib way counts floats across chapter resets.
- `BESPOKE/class` Cyrillic counter alphabet: `\russian@realalph`/`\russian@realAlph` are `\ifcase` letter tables (GOST 7.32 letter set, calling babel-russian internal `\xpg@ill@value`) behind `\asbuk`/`\Asbuk` (sty/NSLExtra.sty:95-106), registered with `\AddEnumerateCounter` (sty/NSLExtra.sty:110-111) and used for `\theenumi..iii` (sty/NSLReport.cls:699-701) and appendix chapter letters `\gdef\thechapter{\Asbuk{chapter}}` (sty/NSLReport.cls:839). No lib way holds a custom counter alphabet; borderline (it is a data table) but it is code, not a parameter.
- Outside the main sample's scope, not counted: `ART/class` the ESKD page frames and title blocks in `picture` (sty/NSLEskd.sty:61-218), loaded only by examples/eskd_fo (eskd_fo/rpz.tex:7), with `\def\@oddhead{\titleFrame}` in eskd_fo/00-title.tex:4.

## Class setting
- Class: `class.extreport` options: 14pt, a4paper, oneside, onecolumn, final, openany (the zip-local class defaults, sty/NSLReport.cls:101; 14pt loads `size14.clo` at :56,:104, which is extsizes, not shipped in the zip). The original is zip-local; `class.extreport` is the published class it reduces to.
- Class-native vocabulary used: `\chapter`, `\chapter*`, `\section`, `\section*`, `\subsection`, `\subsubsection`, `\paragraph{}` and `\subparagraph{}` as numbered clauses (not run-in headings of report), `titlepage` environment, `\appendix`, `\tableofcontents`, `\thispagestyle`, `itemize`, `enumerate`, `equation`, `figure`, `longtable`. Not used by the book sample but defined: `\maketitle`, `abstract` (`\chapter*{\abstractname}`, cls:758-768), `quote`/`quotation`/`verse`, `theindex`, `thebibliography`, `\listoffigures`, `\listoftables`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | examples/book/rpz.tex:2; sty/NSLReport.cls:25,101,104 | `class.extreport` | 14pt (size14.clo), a4paper, oneside, openany |
| paper and size | sty/NSLReport.cls:45-60,101 | `page.class-options` | a4paper, 14pt, oneside, onecolumn |
| page geometry | sty/NSLExtra.sty:286; sty/NSLBook.sty:28-32 | `page.geometry` | right=15mm, left=30mm, top=20mm, bottom=20mm, headsep=0pt, includefoot then `\geometry{ignorefoot}` |
| vertical offset, head separation | sty/NSLBook.sty:84-85 | `page.setlength` | `\voffset`=-6mm, `\headsep`=5mm |
| running heads and feet | sty/NSLBook.sty:63-82 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\lhead{\small \nouppercase{\leftmark}}`; chead, rhead, cfoot empty; `\fancyfoot[LE,RO]{\thepage}`; headrulewidth 0.5pt, footrulewidth 0pt |
| chapter-opener page style | sty/NSLBook.sty:78-82; examples/book/02-intro.tex:2; 20-analysis.tex:3; 40-simulation.tex:3 | `hf.fancyhdr` | `\fancypagestyle{chapterpage}`: lhead, rhead empty, headrulewidth 0pt; `\thispagestyle{chapterpage}` after each chapter |
| hand-set running head | examples/book/02-intro.tex:3-5; 20-analysis.tex:4; 90-conclusion.tex:2,8 | `hf.fancyhdr` | `\renewcommand{\leftmark}{...}` and `\let\oldleftmark`; reduction `\markboth{..}{..}` |
| page numbering | sty/NSLReport.cls:1251,822,826; examples/book/00-abstract.tex:106 | `pgnum.pagenumbering` | arabic; `\setcounter{page}{2}` after the annotation page; titlepage env resets page to 1 |
| last page reference | examples/book/00-abstract.tex:40; sty/NSLExtra.sty:235 | `pgnum.lastpage` | `\pageref{LastPage}` |
| line spacing | sty/NSLReport.cls:1274,108-109 | `sp.linespread` | `\linespread{1.3}`; lineskip, normallineskip 1pt (`sp.lengths`) |
| paragraph shape | sty/NSLReport.cls:333,1276; sty/NSLBook.sty (inherits) | `sp.lengths` | `\parindent`=12.5mm (`12,5mm`), `\parskip`=0mm |
| penalties | sty/NSLReport.cls:114-116,1003-1004 | `sp.penalties` | `\clubpenalty`=10000, `\widowpenalty`=10000, `\@lowpenalty` 51, `\@medpenalty` 151, `\@highpenalty` 301 |
| hyphenation | sty/NSLReport.cls:1001; sty/NSLExtra.sty:82-83; examples/book/preamble.inc.tex:1 | `sp.hyphenat` | `\righthyphenmin`=2, `\lccode`\-=`\-`, `\defaulthyphenchar`=127, `\sloppy` (raw hyphenation primitives, see Lib changes) |
| microtypography | sty/NSLExtra.sty:290 | `sp.microtype` | defaults |
| encodings | sty/NSLExtra.sty:86-87,284 | `font.fontenc-t1` | fontenc T1,T2A; inputenc utf8; textcomp |
| text fonts | sty/NSLExtra.sty:4-22 (list of packages); Dockerfile:22 | `font.size-commands` | no font package is loaded; default CM with T2A; `\large` `\Large` `\huge` `\footnotesize` `\small` only |
| language | sty/NSLExtra.sty:88; sty/NSLBook.sty:16-23 | `lang.babel` | [english,russian]; `\addto\captionsrussian{\def\contentsname{Содержание}}` |
| quotation marks | sty/NSLBook.sty:40 | `lang.csquotes` | load-only |
| hyperlinks | sty/NSLExtra.sty:46-50; examples/book/02-intro.tex:222 | `meta.hyperref`, `meta.url` | bookmarks=true, colorlinks=true, unicode=true, all link colours black; `\url` |
| maths | sty/NSLExtra.sty:144-146; examples/book/20-analysis.tex:33-35 | `math.amsmath`, `math.amssymb`, `math.icomma` | equation environment, `\left..\right`, `\[ \]` |
| symbol set | sty/NSLExtra.sty:283 | `math.amssymb` | `gensymb` (degree, micro): closest home, a load-only symbol package |
| `\leq` `\geq` aliases | sty/NSLReport.cls:921-922 | `math.amssymb` | `\renewcommand\leq{\leqslant}` |
| equation numbering | sty/NSLReport.cls:911-913 | `num.counters` | `\@addtoreset{equation}{chapter}`; `\theequation` chapter-prefixed when chapter>0 |
| title page | examples/book/00-titleBook.tex:2-41; sty/NSLReport.cls:814-829 | `front.titlepage-env` | `titlepage`, `\thispagestyle{empty}`, `centering`, `\Large \textsc`, `\vspace` in ex and `\vfill` |
| title-page frame | examples/book/00-titleBook.tex:5-11 | `art.pstricks` | ART, see Blockers |
| annotation (imprint) page | examples/book/00-abstract.tex:3-106 | `front.dedication`, `box.minipage`, `sp.manual-space` | `\parbox[t]{.45\linewidth}`, `minipage` 0.94 and 0.06 `\textwidth`, `\hfill`, `\small`, `\textcopyright` |
| totals in the imprint line | examples/book/00-abstract.tex:41-56 | none | BESPOKE, see Blockers |
| colophon page | examples/book/99-lastpage.tex:1-30 | `front.dedication`, `sp.manual-space`, `mark.kernel` | `center`, `\textsf`, `\textbf`, `\vspace{3cm,10mm,5mm}` |
| table of contents | examples/book/rpz.tex:20-21; sty/NSLReport.cls:1031-1095 | `toc.kernel`, `toc.tocloft`, `num.secnumdepth` | tocdepth 1 (class default 2); `\@pnumwidth`=1.55em, `\@tocrmarg`=2.55em, `\@dotsep`=4.5; chapter `{1}{0mm}{1.2em}`, section `{1}{.8em}{2em}`, subsection `{2}{3.8em}{3.2em}`, subsubsection `{3}{7.0em}{4.1em}` |
| chapter heading | sty/NSLReport.cls:425-479; sty/NSLBook.sty:44-60 | `head.titlesec` | book style: `\huge\bfseries`, `\Large \chaptername~\thechapter` above the title, 3cm space after; `\raggedright`, `\interlinepenalty\@M` |
| unnumbered chapter | sty/NSLReport.cls:483-500; examples/book/02-intro.tex:1; 90-conclusion.tex:1 | `head.titlesec` | `\large\bfseries\centering`, 5pt after; adds a toc line (cls:486) |
| section, subsection, subsubsection | sty/NSLReport.cls:348-367,511-547 | `head.titlesec` | indent `\parindent`; before 3.2ex, after 1.2ex; `\normalfont\bfseries`; positive before skip keeps first-paragraph indent |
| starred sections | examples/book/02-intro.tex:55,97,132 | `head.kernel` | `\section*` |
| numbered clauses | sty/NSLReport.cls:576-618; examples/book/40-simulation.tex:9-26 | `head.titlesec`, `num.counters` | `\paragraph{}` and `\subparagraph{}` as run-in numbered items: `\theparagraph\hspace{2mm}#1\hspace{-3mm}`; numbers built from chapter.section.subsection.subsubsection with `\ifnum` guards (cls:415-416) |
| numbering depth | sty/NSLReport.cls:404,834 | `num.secnumdepth` | secnumdepth 5, 4 after `\appendix` |
| counter display | sty/NSLReport.cls:405-416,934-936,957-959,1219 | `num.counters` | section counters reset per chapter; figure and table counters `[chapter]` with chapter prefix; footnote reset per chapter |
| appendix | examples/book/rpz.tex:35; sty/NSLReport.cls:833-868 | `num.appendix`, `head.titlesec` | `\appendix`; chapter label "Приложение А." (`\appendixname`, `\Asbuk`); toc line `\@chapapp\space\numberline`; letters depend on the blocker alphabet |
| unordered lists | sty/NSLReport.cls:626-642,693-696; examples/book/02-intro.tex:24-30 | `list.kernel`, `list.enumitem` | leftmargini 2.5em, leftmarginii 0mm, labelsep .5em; labels `~--` at all levels |
| ordered lists | sty/NSLReport.cls:699-709; examples/book/02-intro.tex:105-111 | `list.kernel`, `list.enumitem` | labels `\theenumi)`, `(\theenumii)`, `\theenumiii.`, `\theenumiv.`; alphabet from the blocker; `\AddEnumerateCounter` (NSLExtra.sty:110-111) |
| figures | examples/book/40-simulation.tex:32-37,53-58; 95-appendix1.tex:13-18 | `fig.graphicx`, `fig.float`, `fig.placement` | `[ht]`, `[H]`; `\includegraphics[keepaspectratio,width=0.8\textwidth]`; default `tbp` (cls:944) |
| float placement parameters | sty/NSLReport.cls:117-126 | `fig.placement` | topnumber 2, bottomnumber 1, totalnumber 3, topfraction .7, bottomfraction .3, textfraction .2, floatpagefraction .5 |
| example float | sty/NSLBook.sty:87-96; examples/book/20-analysis.tex:75-94 | `fig.float` | `\floatstyle{ruled}`, `\newfloat{example}{thp}{lop}[chapter]`, `\restylefloat*{example}`, `\floatname{example}{Пример}` |
| captions | sty/NSLExtra.sty:197-212 | `cap.caption` | options normal,nooneline; labelsep=emdash (`\DeclareCaptionLabelSeparator*`); aboveskip 10pt, belowskip 0pt, position bottom; figure justification centering, labelformat "Рисунок #2"; table position top, aboveskip 5pt, justified |
| long table | examples/book/95-appendix1.tex:22-72; sty/NSLExtra.sty:216-218 | `tbl.longtable`, `tbl.tabular` | `{|c|p{4cm}|p{11cm}|}`, `\endfirsthead` `\endhead`, `\hline`; `\LTleft`=0, `\LTright`=`\fill`; `multirow` loaded (NSLExtra.sty:223, `tbl.multirow`), unused in this sample |
| table and box lengths | sty/NSLReport.cls:899-907 | `sp.lengths` | arraycolsep 5pt, tabcolsep 6pt, arrayrulewidth .4pt, doublerulesep 2pt, fboxsep 3pt, fboxrule .4pt |
| code listings | examples/book/listings.inc.tex:3-76; sty/NSLExtra.sty:293 | `code.listings` | `\lstset` (footnotesize, breaklines, numbers=left, frame=single, tabsize=4, inputencoding=koi8-r), four `\lstdefinestyle`, two `\lstdefinelanguage` (Pseudocode over Python, BNF, with `literate`), `\lstlistingname`=Листинг; not called in the book sample |
| bibliography | sty/NSLBook.sty:35-39; examples/book/92-biblio.tex:8-12; 20-analysis.tex:141-144 | `bib.biblatex-biber`, `bib.multi` | backend=biber, bibencoding=utf8, style=gost-numeric, sorting=none, refsegment=chapter; `\defbibheading{subbibforcha}`; `\printbibliography[heading=..,segment=\therefsegment]`; `\bibfont` small; `\bibname`→`\gostbibname`; `\addbibresource{rpz.bib}` |
| cross references and citations | examples/book/20-analysis.tex:2,50,84 | `xref.kernel` | `\label` `\ref` `\pageref`; `\cite`, `\autocite` through biblatex |
| footnotes | sty/NSLReport.cls:1215-1223 | `fn.kernel`, `num.counters` | class feature, no footnote in the sample; rule .4`\columnwidth`, reset per chapter |
| text marks | examples/book/02-intro.tex:53; 99-lastpage.tex:4,10 | `mark.kernel` | `\textbf`, `\textit`, `\textsf`, `\textsc` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| NSLReport.cls as a whole (copy of report.cls) | sty/NSLReport.cls:1-1329 | Yes, except the two rows marked No below | `class.extreport[14pt,a4paper,oneside,openany]` + `head.titlesec` + `toc.tocloft` + `hf.fancyhdr` + `cap.caption` + `num.counters` + `sp.lengths` + `fig.placement`; kernel copies (verse, quotation, quote, theindex, `\DeclareOldFontCommand`, `\today`, names) come with the base class |
| `\@startsection` section levels | sty/NSLReport.cls:511-547 | Yes | `head.titlesec` `\titleformat`/`\titlespacing` with the parameters in the map |
| `\chapter` internals, `\@makechapterhead`, `\@makeschapterhead` | sty/NSLReport.cls:425-500; sty/NSLBook.sty:44-60 | Yes, apart from the totals call at cls:425-426 | `head.titlesec` display shape for chapters |
| numbered `\paragraph`, `\subparagraph` | sty/NSLReport.cls:576-618 | Yes, with a caveat | `head.titlesec` runin shape plus `num.counters`; the `\raggedleft` and `\hspace{-3mm}` effect is not shown to match |
| `\appendix` with `\gdef\@chapter` | sty/NSLReport.cls:833-868 | Yes, apart from the alphabet | `num.appendix` + `head.titlesec` re-issued after `\appendix` |
| `\@makecaption` | sty/NSLReport.cls:988-997 | Yes | superseded by `cap.caption` (NSLExtra.sty:197-212) |
| toc `\l@...`, `\tableofcontents` | sty/NSLReport.cls:1031-1095 | Yes | `toc.tocloft` indents and number widths |
| counter display macros | sty/NSLReport.cls:404-416,911-913,934-959 | Yes | `num.counters` |
| `\subsubsubsection` | sty/NSLExtra.sty:37-42 | Yes | `head.titlesec`, unused in the sample |
| totals counters and `\write\@mainaux` | sty/NSLReport.cls:425-426; sty/NSLExtra.sty:235-268; examples/book/00-abstract.tex:41-56 | No | no lib way counts floats across chapter resets (BESPOKE/class) |
| `\russian@realalph` tables, `\asbuk` `\Asbuk` | sty/NSLExtra.sty:95-111 | No | no lib way holds a custom counter alphabet (BESPOKE/class) |
| NSLBook.sty `\ifrusver` switch | sty/NSLBook.sty:13-14,92-96 | Yes | constant true; reduces to `\floatname{example}{Пример}` |
| `\gostbibname`, `\gostacronymsname`, `\No`, `\Code` aliases | sty/NSLBook.sty:24-25; sty/NSLExtra.sty:282; examples/book/macros.inc.tex:2 | Yes | `\newcommand` aliases of text and `\textnumero` |
| `\newif\ifNSLHaveLRI/LY/ESKDFrame` | sty/NSLExtra.sty:270-280 | Not exercised by the book sample | switches drive printed pages only in eskd_fo (eskd_fo/rpz.tex:38-44) |
| NSLEskd.sty frames | sty/NSLEskd.sty:61-218 | No, outside main scope | ART/class, see Blockers |
| hand-set `\leftmark` | examples/book/02-intro.tex:3-5; 90-conclusion.tex:2,8 | Yes | `\markboth` with `hf.fancyhdr` |
| `\include` used in the preamble | examples/book/rpz.tex:10-11; sty/NSLExtra.sty:293 | Yes | published kernel command used out of its usual place; an emitter writes the files inline (no claim about behaviour) |
| NSLDisser.sty | sty/NSLDisser.sty:35-63 (rest is commented out) | Yes | `lang.babel` caption, `page.geometry`, `bib.biblatex-biber`, `hf.fancyhdr`; not loaded by the main sample |

## Content-opaque
- Figure artwork: `inc/svg/simulation/LegacySignalsOscSpectr`, `inc/svg/analysis/hgraph0` (examples/book/40-simulation.tex:34,55) and `inc/img/appx/xkcd` (examples/book/95-appendix1.tex:15). Those `inc/*.pdf` files are not in the zip; the Makefile makes them from `graphics/svg` and `graphics/img` with inkscape, pdfcrop and ImageMagick `convert` (Makefile:67-92). Treated as missing assets plus content, not a blocker; the SVG/JPEG sources are in the zip.
- Display equations (examples/book/20-analysis.tex:33-44; 40-simulation.tex:42-44), the `\[ \]` maths in the `example` float (20-analysis.tex:85-91), the long Russian prose, the bibliography (rpz.bib, 227 entries) and longtable cell contents (95-appendix1.tex:33-70).
- Build helpers that never shape the output: `utils/texdepend` (make dependency lists), `utils/gsconv.sh` (post-print Ghostscript colour split), `iconv` to KOI8-R for `inc/src` listings (Makefile:30-35,95-97; unused by this sample). Not run, only read. No text addressed to an AI was found in the zip.

## Lib changes
- New ways proposed: none. Observations for the consolidator: (1) `class.extreport` is written plainly as a class way. (2) Raw hyphenation primitives (`\lccode`, `\defaulthyphenchar`, `\righthyphenmin`) are filed under `sp.hyphenat`; if the lib wants them apart they parallel `sp.penalties`. (3) `gensymb` and `blindtext` (NSLExtra.sty:283,288) have no clean home; `gensymb` is filed under `math.amssymb`, `blindtext` is a dummy-text aid with no look effect and is not mapped.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
