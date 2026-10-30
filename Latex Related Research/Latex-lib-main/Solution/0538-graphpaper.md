yes

# 0538-graphpaper: graphpaper (a class that prints graph paper)

- Unverified: read from the source, not compiled.
- Source: Source/0538-graphpaper/ (origin: https://mirrors.ctan.org/macros/latex/contrib/graphpaper.zip; licence: LPPL 1.3c, graphpaper.dtx:24-26, README:12-18)
- Kind: misc
- Lib: v4
- Engine: pdfLaTeX-compatible (graphpaper.dtx:3 names pdflatex; README:56; the class loads only xkeyval, article, geometry, euclideangeometry/curve2e/pict2e, graphicx, xcolor, graphpaper.dtx:298-328)
- Look carried by: class (the graph papers are drawn by the CTAN class `graphpaper`, whose source is the .dtx; the only in-zip document, the manual driver, is `ltxdoc` plus a preamble of published packages, graphpaper.dtx:64-104)
- Class origin: ctan
- Main file: graphpaper.dtx (driver block graphpaper.dtx:55-122, the only `\documentclass` and `\begin{document}`; it loads `ltxdoc`, not `graphpaper`; no .tex sample of the class exists; other samples: none)
- Read: main yes, zip-local classes and styles none present (no .cls or .sty file in the zip: `graphpaper.cls` is generated from the .dtx by DocStrip, graphpaper.dtx:41; the class code inside the .dtx, graphpaper.dtx:298-1039, was read in full). README read. `graphpaper.pdf` (binary manual, 6 pages, derived from the .dtx) was not read: no PDF renderer was available.

## Verdict
The zip is the source of the published CTAN class `graphpaper` (ctan.org/pkg/graphpaper: LPPL 1.3c, in TeX Live) and its manual. Every look it defines is carried by that published class, loaded as `\documentclass[a4paper]{graphpaper}` and driven by declarative commands (decade counts, lengths, one colour), and the manual's driver reduces to `ltxdoc`, `geometry`, `multicol`, `listings` and kernel commands, so the answer is yes. The picture-environment loops that draw the grids (`\carta`, `\PolarChart`, `\SmithChart`) are the class's own implementation and are not copied by an emitter. If a reader counted a published class's internals as zip code, those loops would be irreducible (BESPOKE/class, with ART/class for the drawn grids); I did not count them, because W1 holds for the class and nothing in the sample draws outside the class's own commands.

## Blockers
none

## Class setting
- Class: `class.graphpaper` options: `a4paper` (default), `a3paper`, `letterpaper` (graphpaper.dtx:306-310; doc :169-172); orientation is always landscape (graphpaper.dtx:327, doc :171-172); any other option is a `\ClassError` (graphpaper.dtx:311-313). The class loads `article[a4paper,11pt]` internally (graphpaper.dtx:320); the emitter writes only the `graphpaper` line. Second class, for the manual only: `class.ltxdoc` with `11pt,a4paper` (graphpaper.dtx:64).
- Class-native vocabulary used (defined and documented, no .tex in the zip calls it): body commands `\bilinear`, `\semilogx{decades}`, `\semilogy{decades}`, `\loglog[0/1]{decades x}{decades y}`, `\polar`, `\logpolar{decades}`, `\smith` (graphpaper.dtx:1003-1009; doc :183-195), built on `\carta[0/1]{x}{y}`, `\PolarChart[diameter]{decades}`, `\SmithChart[diameter]` (graphpaper.dtx:455, 786, 914); each starts with `\newpage` (graphpaper.dtx:463, 794, 915). Settings placed before a paper command: `\setxside{len}`, `\setyside{len}`, `\setminimumdistance{len}`, `\setgridcolor{colour}`, `\setmajorlinethickness{len}`, `\setmediumlinethickness{len}`, `\setminorlinethickness{len}` (graphpaper.dtx:1016-1026), and the hook `\customcode[0/1]{picture commands}` (graphpaper.dtx:1027-1031). `\logpolar` accepts fewer than 3 decades and warns otherwise (graphpaper.dtx:829, 855-857).

## Component map
Rows 1 to 8 are the class's own look (what the class gives any document that loads it). Rows 9 to 29 are the manual driver and the documentation text, the only document in the zip.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| 1 document class | graphpaper.dtx:59, 320, 163 | `class.graphpaper` | options a4paper (default), a3paper, letterpaper; landscape fixed |
| 2 paper size | graphpaper.dtx:306-310, 363-374 | `page.class-options` | a4paper, a3paper or letterpaper, forwarded to geometry inside the class; default grid rectangle 260 x 180 mm (A4), 250 x 190 mm (letter), 380 x 280 mm (A3) |
| 3 graph-paper pages (rectangular, polar, Smith) | graphpaper.dtx:455-614, 786-898, 914-994, 1003-1009 | `class.graphpaper` | body commands above; arguments are integers (decades, 0/1) and a diameter length; ink is the class's own picture-environment drawing |
| 4 grid size and fineness | graphpaper.dtx:354-355, 361-374, 1020-1026 | `class.graphpaper` | `\setxside` `\setyside` `\setminimumdistance`; default minimum distance 1 mm |
| 5 grid colour | graphpaper.dtx:333, 1016 | `class.graphpaper` | `\setgridcolor{colour}`; default RGB 250,153,89, a named xcolor colour `gridcolor` |
| 6 line weights | graphpaper.dtx:343-348, 1017-1019 | `class.graphpaper` | 1pt, 0.6pt, 0.25pt (major, medium, minor) |
| 7 user drawing hook | graphpaper.dtx:1027-1031 | `class.graphpaper` | `\customcode[0/1]{picture commands}`; not used anywhere in the zip |
| 8 per-sheet page set-up (inside the class, not emitted) | graphpaper.dtx:327, 463-467, 511, 794-799, 915-920 | `class.graphpaper` | the class itself sets geometry landscape with `\newgeometry` margins computed per grid, empty page style, `\parindent=0pt`; the emitter writes none of it |
| 9 manual class | graphpaper.dtx:64 | `class.ltxdoc` | options 11pt, a4paper |
| 10 manual encoding | graphpaper.dtx:65 | `font.fontenc-t1` | T1 |
| 11 manual font | graphpaper.dtx:66 | `font.lmodern` | load only |
| 12 manual page geometry | graphpaper.dtx:67 | `page.geometry` | a4paper, lines=50 |
| 13 manual columns | graphpaper.dtx:68, 112-113, 115, 120 | `cols.multicol` | `multicols{2}` wraps the contents (through `\addtocontents{toc}`); `\columnseprule` 0.4pt, `\columnsep` 1.5cm |
| 14 overfull tolerance | graphpaper.dtx:69 | `sp.lengths` | `\hfuzz` 10pt |
| 15 doc-markup aliases | graphpaper.dtx:70-84 | `mark.kernel` | `\texttt`, `\textsf`, `\itshape`, `\slshape`, `\normalfont` aliases (see Bespoke code) |
| 16 syntax box | graphpaper.dtx:86-89, 441-443, 770-772, 905-907 | `box.minipage`, `box.fancybox`, `sp.ragged` | `\fbox` around a `minipage` of width `\linewidth-2\fboxrule-2\fboxsep`, `\ttfamily`, in `center` (see Bespoke code) |
| 17 colour definition | graphpaper.dtx:91-92 | `color.color` | `color` package, `\definecolor{sfondoblu}{rgb}{0.94,0.97,1}` |
| 18 code listings | graphpaper.dtx:93-104, 162-164, 182-196, 219-225, 243-253 | `code.listings` | `\lstset`: language=[LaTeX]TeX, basicstyle `\footnotesize\ttfamily`, keywordstyle blue bold, commentstyle gray, backgroundcolor sfondoblu, frameround=tttt, frame=tlrb, escapechar bar, morekeywords (the class commands), columns=flexible; four `lstlisting` blocks |
| 19 title block | graphpaper.dtx:107-110 | `front.maketitle` | `\title`, `\author` with `\and`, `\date`, `\maketitle` |
| 20 author note | graphpaper.dtx:108 | `front.thanks` | `\thanks` |
| 21 .dtx file info and input | graphpaper.dtx:56, 106, 109, 119 | `dtx.doc` | `\ProvidesFile`, `\GetFileInfo`, `\fileversion` `\filedate`, `\DocInput{graphpaper.dtx}` |
| 22 .dtx structure and code blocks | graphpaper.dtx:54-63, 283, 297-299, 1046 | `dtx.doc` | `macrocode` environments, `\StopEventually{}`, `\Finale`, `%<*tag>` guards, `\iffalse` wrappers |
| 23 DocStrip batch block | graphpaper.dtx:4-46 | `dtx.doc` | `\input docstrip.tex`, `\keepsilent`, `\preamble` `\postamble`, `\generate{\file{graphpaper.cls}{\from{graphpaper.dtx}{class}}}`; prints nothing in the manual (considered: docstrip, filed under the .dtx format, see Lib changes) |
| 24 contents depth | graphpaper.dtx:111 | `num.secnumdepth` | `tocdepth` 2 |
| 25 contents | graphpaper.dtx:116-117 | `toc.kernel` | `\tableofcontents` |
| 26 contents size | graphpaper.dtx:116 | `font.size-commands` | `\small` |
| 27 abstract | graphpaper.dtx:125-129 | `abs.kernel` | `abstract` environment |
| 28 headings | graphpaper.dtx:131, 148, 154, 289, 295, 377, 383, 438, 619, 624, 766, 902, 998, 1035 | `head.kernel` | `\section`, `\subsection`, `\subsubsection`, default numbering |
| 29 page breaks and labels | graphpaper.dtx:153, 288, 155, 1001, 1014 | `pg.break`, `xref.kernel` | `\newpage`, `\clearpage`; `\label{sec:howto}`, `\ref{sec:howto}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\meta` wrapper (`\let\originalmeta\meta`, `\renewcommand\meta`) | graphpaper.dtx:70-71 | yes | inline expansion: `{\normalfont\meta{x}}` (`mark.kernel`); `\meta` itself is `ltxdoc` vocabulary (`class.ltxdoc`) |
| aliases `\marg` `\Marg` `\opz` `\Opz` `\amb` `\env` `\cs` `\Benv` `\Eenv` `\eTeX` `\prog` `\pack` `\class` | graphpaper.dtx:72-84 | yes | each is one `\texttt`, `\textsf`, `\itshape` or `\slshape` span with literal braces, brackets or a backslash glyph (`\char92`, the glyph of `\textbackslash`); expands inline (`mark.kernel`); `\eTeX` is inline maths `$\varepsilon$-\TeX` |
| environment `ttsintassi` / `ttsyntax` | graphpaper.dtx:86-89 | yes | `\begin{center}\fbox{\begin{minipage}{\dimexpr\linewidth-2\fboxrule-2\fboxsep}\ttfamily ...\end{minipage}}\end{center}`; `\obeylines` (graphpaper.dtx:87) only changes line ends, and each use has one source line (graphpaper.dtx:442, 771, 906); with several lines each would be its own paragraph |
| the class implementation `\carta` `\PolarChart` `\SmithChart` `\hlines` `\vlines` `\Rbox` `\Xcircle` `\Ycircle` `\GradResist` `\GradPolar`, counters `\I` `\J` `\K`, fp loops | graphpaper.dtx:399-435, 455-614, 630-762, 786-898, 914-994 | not zip-local: published class (W1) | loaded as `class.graphpaper`, never rewritten; helpers such as `\Pbox`, `\Circlewithcenter`, `\segment`, `\Arc`, `\fptest`, `\fpdowhile` are not defined in the .dtx and are supplied by the loaded `euclideangeometry`/`curve2e` (not read; the CTAN page of `euclideangeometry` says it extends `curve2e` and does not name the fp helpers) |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered: `docstrip` (LaTeX base `docstrip.tex`, the extraction batch at graphpaper.dtx:4-46): filed under `dtx.doc` as the .dtx container, since it prints nothing and only generates `graphpaper.cls`; the lib line speaks of typesetting a .dtx, so a reader may want it widened.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this). `class.graphpaper` is a class way, written plainly (ctan.org/pkg/graphpaper: class, LPPL 1.3c, TeX Live), with its vocabulary under "Class setting".
