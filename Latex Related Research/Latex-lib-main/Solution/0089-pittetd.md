yes

# 0089-pittetd: pittetd (University of Pittsburgh ETD thesis class: DocStrip source plus its ltxdoc manual)

- Unverified: read from the source, not compiled.
- Source: Source/0089-pittetd/ (origin: https://mirrors.ctan.org/macros/latex/contrib/pittetd.zip; licence: LPPL 1 or later, manifest `lppl1`, pittetd.dtx:8-11)
- Kind: thesis (Ph.D. dissertations and M.A./M.S. theses, pittetd.dtx:104, 318)
- Lib: v1
- Engine: pdfLaTeX-compatible (the class passes the options `pdftex` and `dvipdfm` on to hyperref, graphicx and color, dtx:128, 621, 771; no fontspec, no Lua; the manual driver asks hyperref for the `dvipdfm` driver at dtx:22-23, a DVI-to-PDF route; not compiled here)
- Look carried by: class (the thesis look is the published class `pittetd`, shipped here only as DocStrip source: `pittetd.ins` extracts `pittetd.cls`, `pitetd10/11/12.clo` and three `.pit` patches from the unprefixed lines of `pittetd.dtx`, ins:10-16; the manual page is `ltxdoc`; the driver preamble adds only package loads)
- Class origin: ctan (https://ctan.org/pkg/pittetd read once: v1.618, LPPL 1, "included in TeX Live and MiKTeX"; matches `\ProvidesClass` at dtx:666. The driver's `ltxdoc` is tex-distribution-unbundled, not in the zip)
- Main file: pittetd.dtx (the `%<*driver>` block, lines 14-39, is the only `\documentclass` and `\begin{document}`; it typesets the manual, and the class code is typeset inside it by `\DocInput`; other samples: none, no `.tex` document uses `pittetd`. `pittetd.pdf` is a shipped output and was not read: no PDF renderer in this session)
- Read: main yes (all 2239 lines of pittetd.dtx, with the manual text at 102-656 and the class code at 665-2234), zip-local classes and styles all (no `.cls`, `.sty`, `.clo` or `.def` is shipped; the class code, the three size modules at 803-875 and the three patch modules at 1141-1146, 1679-1742, 2165-2186 were read in full; `pittetd.ins` read in full)

## Verdict
`yes`, on two rulings. First, `pittetd` is published on CTAN and in TeX Live (W1 met), so the thesis format is one way, `class.pittetd`, whose parameters are its options; an emitter writes `\documentclass[12pt,final,phd]{pittetd}`, the front-matter commands and the body, and copies no class code. Second, the manual is `class.ltxdoc` plus kernel components, and its zip-local macros (the `\ex` and `\ample` pair, the logo and alias macros) are plain compositions of kernel spacing, font and `\index` commands, so they reduce. The class code itself is irreducible (state machine, `.etd` memory file, replaced kernel internals, listed below as not counted); read as a zip-local class instead of the published one, the answer would be `no` (BESPOKE/class). No template-defining artwork exists, and no new way is needed.

## Blockers
none

Recorded, not counted (all sit inside the published class, which the rubric counts as one way; same ruling as the other CTAN class sources in this project):
- `BESPOKE/class` (not counted) preliminaries order checker: each preliminary "enables" and "disables" the others through `\csname @<name>message\endcsname`, raising a warning or, with `final`, an error (dtx:1289-1327, 1337-1471, 1528-1552, 1580-1633)
- `BESPOKE/class` (not counted) the `\jobname.etd` file: the end of a run writes whether tables and figures exist and the widest chapter, section, subsection, subsubsection and float label; the next run reads it to indent the contents and lists and to decide whether a list page is typeset (dtx:926-945, 1846-1863, 1920-1964, 2217-2234; two or more runs needed, dtx:505, 535)
- `BESPOKE/class` (not counted) kernel internals replaced: `\@startsection` twice (dtx:1750-1767, 1772-1799), `\@makecaption` (1969-1980), `\normalsize` and the size family with the 1.5 spacing built into the font size (805-875), list internals `\@listi`..`\@listiv` (2004-2029), `\l@chapter`..`\l@subsubsection` (938-945), `\@makefntext` (2097-2100)
- `BESPOKE/class` (not counted) bookmarks for lists of tables and figures: the `.out` file is made to read `.lot` and `.lof` through `\prepare@bookmarks`, with `\BOOKMARK` lines written by hand and hyperref internals patched (dtx:1345-1349, 1561-1569, 1590-1593, 1622-1625, 1193-1197)
- `BESPOKE/class` (not counted) section-number switch `sectionnumbers`/`sectionletters` built on the group-local `\period@or@not` and `\gobble@or@not` (dtx:984-1015), title and heading capitalisation by `\uppercase` inside `\@chapter` (1807-1818), appendix count kept in an aux-written counter `@appno` (1871-1901)
- `BESPOKE/class` (not counted) committee list kept in a token register, advisor taken from its first line by `\@getadvisor`, `\@coadv` (dtx:1385-1460)
- `BESPOKE/class` (not counted) patch loader `\patch`, `\usewithpatch` and the `.pit` modules for `pitthesis`, `pittdiss`, `achicago` (dtx:1204-1210, 1679-1742, 2165-2186)
- Observation, not a blocker: the list code looks defective as written, `\@listiii` uses `\leftmariniii` (dtx:2016, a misspelling of `\leftmarginiii`) and `\@listiv` is defined three times (2021-2029), so only the last definition would stand.
- Not a blocker: the manual needs `makeindex -s gind.ist` between runs (dtx:183), the standard tool behind `idx.makeidx`; the `dvipdfm` driver option (dtx:22-23) is a hyperref option value and the class documents the `pdftex` route (dtx:128-132).

## Class setting
- Class: `class.pittetd` options: `10pt`, `11pt`, `12pt` (default, dtx:716-719, 776); stage `draft`, `semifinal` (default), `final` (760-763); degree `phd` (default), `ma`, `ms` (738-752); `sectionnumbers` (default), `sectionletters` (753-754); `leqno`, `fleqn` (720-721); `openbib` (722-730); `nohyperref` (768); `pdftex`, `dvipdfm` are not declared and pass through to packages (771). Paper size, orientation, columns, sides and `titlepage` options are deliberately not implemented (dtx:310). No `\LoadClass`: the class declares its own counters and environments (698-705).
- Class-native vocabulary used (documented usage, no sample): preamble `\title[pdf title]{}`, `\author`, `\year`, `\degree` (or `\previousdegree`), `\school[the]{}`, `\degreesought`, `\subject`, `\keywords`, `\chapterfloats`, `\date` (defense date); body `\maketitle`, `\committeemember`, `\coadvisor`, `\makecommittee`, `\copyrightpage`, `abstract` and `abstract*` with optional keyword title, `\tableofcontents`, `\listoftables`, `\listoffigures`, `\preface`, `\preliminarychapter`, `\chapter`, `\appendix`, `\safebibliography`, `\singlespace`, `\Small` `\SMALL`, `\acro`, `\regularenum`, `\patch`, `\usewithpatch` (dtx:305-535, 1204-1471, 1640-1669). `\thanks`, `\part`, `\paragraph`, `\subparagraph` and the `\frontmatter` family are disabled (1227, 1839-1841, 1906-1908).
- Class: `class.ltxdoc` options: `11pt` (dtx:18) for the manual driver.
- Class-native vocabulary used (ltxdoc): `\ProvidesFile` (16), `\GetFileInfo` (24), `\EnableCrossrefs` (25), `\IndexPrologue` (30, 2238), `\CodelineIndex` (31), `\setcounter{IndexColumns}{2}` (29), `\DocInput` (37), `\DoNotIndex` (54-93), `\DescribeMacro`, `\DescribeEnv` (463), `\meta`, `\cs`, the `macro` and `macrocode` environments (663-2234), `\PrintIndex` (655, 2239), `\StopEventually` (656), the short-verbatim bars; `\OnlyDescription` is present but commented out (32).

## Component map
`dtx:` is pittetd.dtx, `ins:` is pittetd.ins. Rows 1-24 are the manual (the only sample); rows 25-60 are the look the class defines inside `class.pittetd` (read from its code and documentation, no sample uses it): each row names the lib way that realises the part inside the class, and an emitter reaches all of them with the one `class.pittetd` line.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| 1 manual class | dtx:18, 37 | `class.ltxdoc` | `11pt`; DocStrip driver `\DocInput{\filename}`; `macrocode` blocks hold the class code (content) |
| 2 manual paper and size | dtx:18 | `page.class-options` | `11pt` only; no geometry call, paper left to the ltxdoc default |
| 3 manual packages | dtx:19-21, 168, 313 | `tbl.tabular`, `math.amssymb` | `array` (column types `>\ttfamily ll` and `m{3.5cm}`); `latexsym` is load-only, `$\leadsto$` at 149 (a symbol-font package, same way, package is the parameter); `xspace` is loaded for the alias macros only (see Bespoke code) |
| 4 manual links and metadata | dtx:22-23, 33-34 | `meta.hyperref` | `hyperindex=false,colorlinks,bookmarks,dvipdfm,citecolor=blue,urlcolor=blue,bookmarksnumbered,bookmarksopen`; `\hypersetup{pdftitle=ETD at Pitt (a LaTeX class),pdfauthor=Federico Garcia}` |
| 5 manual URLs | dtx:98-100, 595 | `meta.url` | `\url{...}` from hyperref |
| 6 manual title block | dtx:26-28, 36 | `front.maketitle`, `front.thanks` | `\title{... \\ at Pitt \\ (a \LaTeXe\ class)}`, `\date{2004/08/17}`, `\author{... \thanks{...}}` |
| 7 manual contents | dtx:95 | `toc.kernel` | `\tableofcontents` |
| 8 manual index | dtx:25, 29-31, 655, 2238-2239 | `idx.makeidx` | `\index{a>b}` entries (some with a `textit` encap) throughout (98-100, 122-124), `\PrintIndex`, two columns, `makeindex -s gind.ist` (183) |
| 9 manual headings | dtx:102, 120, 162, 218, 305, 570, 631, 658 | `head.kernel` | `\section`..`\subsubsection` at the class defaults, with `\label` |
| 10 manual lists | dtx:97-101, 635-643 | `list.kernel` | `description`, one inside `\small` |
| 11 manual quote | dtx:236-244 | `quote.kernel` | `quote` with `\newline` lines |
| 12 manual verbatim | dtx:513-523 | `code.verbatim` | `verbatim` inside `\small`; the short-verbatim bars for inline code throughout |
| 13 manual tables | dtx:168-180, 312-323 | `tbl.tabular`, `cap.kernel` | `table[h]` with `\centering`, `tabular{\|m{3.5cm}\|m{7cm}\|}`, `\hline`, `\caption`, `\label`; second `tabular{>\ttfamily ll}` |
| 14 manual figures | dtx:337-345, 365-380, 416-439 | `fig.graphicx`, `box.fancybox`, `box.minipage`, `cols.minipage` | `figure[h]`; `\fbox{\begin{minipage}{.45\textwidth}...}` pair joined by `\hfill` (366-377); `\fbox{\begin{minipage}[c][.65\textheight][c]{.78\textwidth}}` (416); `\shortstack` (340); text boxes only, no `\includegraphics` |
| 15 manual rules | dtx:339, 343 | `sp.rule` | `\rule{.8\textwidth}{.4pt}` |
| 16 manual captions | dtx:322, 344, 379, 439 | `cap.kernel` | `\caption{...}\label{...}` |
| 17 manual footnotes | dtx:122, 124, 128, 136, 183, 224 | `fn.kernel` | `\footnote` |
| 18 manual bibliography | dtx:645-652 | `bib.thebibliography` | `thebibliography{9}` with five `\bibitem`; `\addcontentsline{toc}{section}{References}` (646); `\cite` |
| 19 manual cross-references | dtx:110, 322-323 | `xref.kernel` | `\label`, `\ref`, `Section~\ref{...}` |
| 20 manual marks and sizes | dtx:45, 340-342, 391 | `mark.kernel`, `font.size-commands` | `\textsf`, `\textbf`, `\emph`, `\texttt`, `\scshape` (42); `\small`, `\scriptsize`, `\tiny`, `\large`..`\Huge` shown as a size ladder |
| 21 manual spacing | dtx:96, 365, 408, 409, 465 | `sp.lengths`, `sp.manual-space`, `sp.ragged` | `\parskip4pt plus .2 ex minus .2ex` (96), `\parskip10pt` (365); `\vskip-4pt`, `\smallskip`, `\bigskip`, `\vfill`, `\\[2mm]`, `\enlargethispage*{1cm}` (465, a manual page nudge by a length, filed here); `\raggedleft` (409) |
| 22 manual page breaks | dtx:395, 467 | `pg.break` | `\clearpage` |
| 23 manual math | dtx:149, 310, 584-586 | `math.kernel` | inline `$...$` only |
| 24 manual document macros | dtx:41-53, 94 | `sp.manual-space`, `idx.makeidx`, `mark.kernel` | zip-local aliases, reducible, see Bespoke code |
| 25 thesis class | dtx:665-666, 776-777 | `class.pittetd` | `\NeedsTeXFormat{LaTeX2e}[1995/12/01]`; defaults `12pt,semifinal,hyperref,phd`; `\ProcessOptions` |
| 26 page geometry | dtx:1082-1095, 973-976 | `page.setlength` | letter paper 8.5in x 11in, `\textwidth` 6.5in, `\textheight` 9in, `\oddsidemargin` 0, `\topmargin` 0, `\headheight` 0, `\headsep` 0, `\footskip` .5in, `\marginparwidth` 0, one side, one column; no option changes them (310) |
| 27 point size | dtx:716-719, 803-881 | `page.class-options` | `10pt`, `11pt` or `12pt` loads `pitetd10/11/12.clo` (881) |
| 28 size commands and leading | dtx:804-875, 882-883 | `font.size-commands` | `\normalsize` 10/18, 11/20.4, 12/21.75 pt (the 1.5 spacing is built into the size); every other size single-spaced; extra size `\singlespace`; `\Small` = `\footnotesize`, `\SMALL` = `\scriptsize`; display skips set per size |
| 29 acronym size | dtx:1149-1171 | `font.size-commands` | `\acro{ETD}` one size below the surrounding text (adapted from `ltugboat`) |
| 30 text typeface | dtx:267, 1127-1135 | `class.pittetd` | the class sets no family, so Computer Modern; PSNFSS packages and `ae` are accepted from the user side (267); old switches `\rm \sf \tt \bf \it \sl \sc \cal \mit` re-declared |
| 31 paragraph and skips | dtx:824, 849, 874, 1064-1072 | `sp.lengths` | `\parindent` 15, 17, 19 pt by size; `\parskip` 0pt plus 1pt; `\lineskip` 1pt; `\smallskipamount` .25, `\medskipamount` .5, `\bigskipamount` 1 times `\@singleline` |
| 32 penalties | dtx:1073-1077, 2118-2120 | `sp.penalties` | `\clubpenalty` 250, `\widowpenalty` 250, 4000 for both in the bibliography; low, medium and high penalties 51, 151, 301 |
| 33 user line stretch | dtx:329-331 | `sp.linespread` | `\renewcommand\baselinestretch{1.3}` raises the built-in spacing by 30 percent |
| 34 page style | dtx:965, 1350, 2199 | `hf.pagestyle-kernel` | `\pagestyle{plain}`; `\thispagestyle{empty}` on the title page; `plain` on the index page; no running heads |
| 35 page numbering | dtx:966, 1773 | `pgnum.pagenumbering` | roman for the preliminaries, arabic from the first `\chapter` (`\@startbody`) |
| 36 title page | dtx:1223-1282, 1337-1381 | `front.class-native` | `\maketitle`: `\thispagestyle{empty}`, centred, `\fontsize\@xviipt{1.5\@singleline}`; uppercase bold `\@title`, "by", bold `\@author`, `\@degree`, "Submitted to the Graduate Faculty of", `\@school`, "in partial fulfillment of the requirements for the degree of", `\@degreesought`, "University of Pittsburgh", `\@year`, spaced by `\vfill`; `\title[pdf]{}`, `\year`, `\degree`, `\school[the]{}`, `\degreesought`; `\thanks` ignored with a warning (1227) |
| 37 committee page | dtx:1388-1459 | `front.class-native` | `\makecommittee`: "UNIVERSITY OF PITTSBURGH", uppercase school, "This Dissertation/Thesis was presented by", author, "It was defended on" with `\date`, "approved by" with the members, advisor line "Director/Advisor/Advisors: ..." at the bottom; `\committeemember`, `\coadvisor` |
| 38 copyright page | dtx:1465-1470 | `front.class-native` | `\copyrightpage`: centred "Copyright (c) by author, year" between `\vfill`s |
| 39 abstract | dtx:1477-1522 | `abs.class-native` | `abstract` and `abstract*` with optional keyword title: 1in drop, centred bold uppercase title, "author, degree", "University of Pittsburgh, year"; `abstract*` adds the word ABSTRACT; `\newpage` after |
| 40 keywords | dtx:1278-1282, 1494-1497 | `abs.keywords` | `\keywords{...}` set at the end of the abstract in a `description` item, with a period appended, when the optional argument is given; also feeds the PDF info |
| 41 contents and lists | dtx:938-945, 1528-1633 | `toc.kernel` | bold centred headings CONTENTS, LIST OF TABLES, LIST OF FIGURES after a 1in drop and `\vspace{54pt}`; `\@pnumwidth` 1.55em, `\@tocrmarg` 2.55em, `\@dotsep` 4.5; entry indents from the `.etd` file |
| 42 preface and extra preliminaries | dtx:1640-1669 | `front.class-native` | `\preface` (the only preliminary listed in the contents), `\preliminarychapter{...}` (bookmarked, not listed) |
| 43 chapter heading | dtx:1807-1818 | `head.class-native` | 1in drop, bold centred uppercase title with number, `N.0` for arabic numbering, `\vspace{2\@singleline}` after; contents entry bold; `\chapter*` treated as `\chapter` with a warning |
| 44 section headings | dtx:1750-1799, 1823-1841 | `head.class-native` | `\section` centred bold uppercase, before -2 `\@singleline`, after 1 `\@singleline`; `\subsection` bold, before -1, after .5; `\subsubsection` bold run-in (after -1em); `\part`, `\paragraph`, `\subparagraph` disabled |
| 45 numbering schemes | dtx:753-754, 992-1006, 1022-1042, 958-960 | `num.counters` | `sectionnumbers` 1, 1.1, 1.1.1; `sectionletters` I, A, 1, a; floats numbered straight through, within chapters after `\chapterfloats` (A1 in appendices); equations numbered within chapters |
| 46 numbering depth | dtx:914-915 | `num.secnumdepth` | `secnumdepth` 3, `tocdepth` 3 |
| 47 appendices | dtx:1871-1901 | `num.appendix` | `\appendix`: one appendix gives APPENDIX, several give APPENDIX A, B...; contents entry bold; second run needed |
| 48 lists | dtx:1047-1057, 1987-2050 | `list.kernel` | `\leftmargini` = `\parindent`, `\leftmarginii` 2.2em, iii 1.87em, iv 1.7em, v and vi 1em, `\labelsep` .5em; item labels bullet, bold en dash, asterisk, centred period; `enumerate` labels follow the section scheme, `\regularenum` restores arabic, letter, roman, Letter; `description` label bold |
| 49 quotations | dtx:2055-2084 | `quote.kernel` | `quote` and `quotation` in `\small` (single-spaced), `\topsep` `\medskipamount`, quotation `\listparindent` 1.5em; `verse` indent 1.5em |
| 50 footnotes | dtx:822-823, 2092-2100 | `fn.kernel` | rule 0.3 `\columnwidth` (kern -3pt, kern 2.6pt); text `\parindent` 1em, mark box 1.8em; counter reset per chapter (2096); single-spaced because `\footnotesize` |
| 51 floats | dtx:1106-1121, 1916-1964 | `fig.graphicx` | `table` and `figure` with `\singlespace` inside, default placement `tbp`; top 2 and .5, bottom 1 and .3, total 3, `\textfraction` .2, page fraction .5; label `Table~N`, `Figure~N` |
| 52 captions | dtx:507-511, 1120-1121, 1969-1980 | `cap.kernel` | `\caption[alternate]{...}`; one line centred, longer than one line set as a paragraph with a warning; `\abovecaptionskip` and `\belowcaptionskip` one `\@singleline` |
| 53 table spacing | dtx:950-957 | `tbl.tabular` | `\tabcolsep` 6pt, `\arraycolsep` 5pt, `\arrayrulewidth` .4pt, `\doublerulesep` 2pt, `\fboxsep` 3pt, `\fboxrule` .4pt |
| 54 equation options | dtx:720-721 | `math.eqnumber` | `leqno`, `fleqn` through the standard `.clo` files |
| 55 bibliography | dtx:2107-2159 | `bib.thebibliography` | heading BIBLIOGRAPHY bold centred in the contents, single spacing, `\itemsep` .5 `\@singleline` plus 4pt; `\safebibliography` for any `.bst` style (`bib.bibtex-bst`) and for `natbib` (`bib.natbib`, `\bibsep` at 2158-2159); `openbib` (722-730) |
| 56 index | dtx:2193-2211 | `idx.makeidx` | `theindex` two columns, `\columnsep` 35pt, `\small`, `\hangindent` 40pt, `\subitem` 20pt, `\subsubitem` 30pt |
| 57 PDF links and bookmarks | dtx:1177-1197 | `meta.hyperref` | loaded `\AtEndOfClass` as `bookmarks,hyperindex=false`; `\hypersetup{letterpaper,bookmarksnumbered,colorlinks,bookmarksopen,linkcolor=blue,citecolor=blue,urlcolor=blue,pdftitle,pdfauthor,pdfkeywords,pdfsubject}`; `pdfcreator` set |
| 58 names and language | dtx:899-909 | `class.pittetd` | fixed English names in capitals (CONTENTS, LIST OF FIGURES, BIBLIOGRAPHY, INDEX, APPENDIX); no `babel` |
| 59 stage and messages | dtx:760-763, 784-795 | `class.pittetd` | `draft` and `semifinal` set `\overfullrule` 5pt and warn, `final` sets 0pt and turns warnings into errors |
| 60 patches | dtx:1204-1210, 1677-1742, 2164-2186 | `class.pittetd` | `\patch{name}` and `\usewithpatch` read `name.pit` if present; modules for `pitthesis`, `pittdiss`, `achicago` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\lowBibTeX` and `\BibTeX` logo | dtx:41-44 | yes | text logo built from kerns, `\raise`, `\lower` and `\scshape`; becomes `\textsc` and `\hspace` and `\raisebox` (`mark.kernel`, `sp.manual-space`); it is a word in running text |
| aliases `\pdf` `\PDF` `\FG` `\ETD` `\pittetd` | dtx:45-49 | yes | `\newcommand` aliases of `{\small PDF}`, `\textsf{pittetd}` plus an `\index` call, with `xspace`; inlined as content (`font.size-commands`, `mark.kernel`, `idx.makeidx`); `xspace` then drops out |
| `\ex` and `\ample` pair | dtx:50-51 | yes | one macro opens a group and the other closes it; effect is `\hfil\penalty50\hskip1em` and a small bold "Ex.:" label pushed to the right of the last line, closed by `\parfillskip0pt\par`; each use inlines to `\hfill{\small\textbf{Ex.:\ }...}` (`sp.manual-space`, `sp.lengths`, `font.size-commands`, `mark.kernel`); documentation formatting, not template look |
| `\package`, `\option`, `\options` | dtx:52-53, 94 | yes | wrappers around two or three `\index{...}` calls; `\options` is defined under a catcode change only so that a bar can sit inside an index key (`idx.makeidx`); each use inlines to the `\index` calls |
| preliminaries order checker | dtx:1289-1327 | no (not counted) | in the published class; see Blockers |
| `.etd` memory file and width tracking | dtx:926-945, 1846-1863, 2217-2234 | no (not counted) | in the published class |
| replaced kernel internals | dtx:805-875, 938-945, 1750-1799, 1969-1980, 2004-2029, 2097-2100 | no (not counted) | in the published class |
| float bookmarks through `.out`, `.lot`, `.lof` | dtx:1561-1569, 1590-1593, 1622-1625 | no (not counted) | in the published class |
| numbering switch, capitalisation, appendix counter | dtx:984-1015, 1807-1818, 1871-1901 | no (not counted) | in the published class |
| committee list register and advisor extraction | dtx:1385-1460 | no (not counted) | in the published class |
| patch loader and `.pit` modules | dtx:1204-1210, 1679-1742, 2165-2186 | no (not counted) | in the published class (generated by `ins:14-16`) |

## Content-opaque
none (the three manual figures are `\fbox`, `minipage`, `\shortstack` and `\rule` text drawings, kernel boxes recorded in rows 14 and 15; no TikZ, picture or image is used)

## Lib changes
- New ways proposed: none. `class.pittetd` is written plainly as a class way (vocabulary under Class setting). Two mappings to note for the consolidator: `latexsym` is filed under `math.amssymb` (symbol-font package, package is the parameter) and `\enlargethispage` under `sp.manual-space` (manual vertical room by a length).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
