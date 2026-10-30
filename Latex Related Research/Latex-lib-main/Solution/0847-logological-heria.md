yes

# 0847-logological-heria: heria (LaTeX class for Horizon Europe RIA and IA grant proposals, Part B)

- Unverified: read from the source, not compiled.
- Source: Source/0847-logological-heria/ (origin: https://codeload.github.com/logological/heria/zip/refs/heads/master; licence: LPPL 1.3c per README.md:38-41 and heria.dtx:6-12; manifest says "not established")
- Kind: misc (EU grant proposal, Part B skeleton)
- Lib: v6
- Engine: pdfLaTeX-compatible (`graphicx` and `hyperref` forced to the pdftex driver, heria.dtx:662, 664; pdfTeX primitive `\pdfpageattr` at heria.dtx:1676, 1679)
- Look carried by: class (the published class `heria`; its source is the `class` guard of heria.dtx:647-1901, no .cls ships; the sample adds only `caption`, metadata and content)
- Class origin: ctan (ctan.org/pkg/heria read: v5.1.1.0 of 2026-08-16, LPPL 1.3c, in TeX Live and MiKTeX; the Makefile packages it for CTAN, Makefile:3-4, 50)
- Main file: heria.dtx, guard `heria-proposal` at lines 2875-3254 (no standalone .tex ships; heria.ins:58-62 generates five skeletons for template versions 3.2 to 5.1 from this one guard) (other samples: none)
- Read: main yes, zip-local classes and styles all (class code heria.dtx:33-1901 and the 31 `hi-*` instruction texts 1902-2874 read in full; README.md, heria.ins, Makefile read; `.gitignore` not read, not a TeX file)

## Verdict
yes, and it is a class-carried yes. The sample is `\documentclass[showinstructions]{heria}` (heria.dtx:2876), one `\usepackage{caption}` (2884), and class-native commands; it defines no macro of its own. `heria` is a published class (CTAN, TeX Live, MiKTeX), so under W1 its code is not bespoke and an emitter writes the `\documentclass` line and the class vocabulary. The class source does contain irreducible code (aux-file round trip, `\csname` data store, `\whiledo` table generators, shipout rotation hook, listed under Bespoke code); it would be `BESPOKE/class` had the class been zip-local, so this yes is evidence about the class dimension only. The Makefile is not `EXTERNAL`: it only runs `pdflatex heria.ins` (docstrip, Makefile:35-36; README.md:16-24 gives the same steps by hand), and the installed package needs no generation.

## Blockers
none (class-internal code is listed under Bespoke code and is not counted because the class is published)

## Class setting
- Class: `class.heria` options: `showinstructions` (boolean through `kvoptions`, family `heria`, heria.dtx:1859-1865); `\templateversion{3.2|3.3|3.4|4.0|5.1}` picks the Part B template version (heria.dtx:708-719). Inside the class: `\LoadClass[11pt,a4paper]{article}` (heria.dtx:650)
- Class-native vocabulary used: `\templateversion` `\callname` `\callidentifier` `\calltopic` `\maketitle` (2886-2892); `\heinstructions` and `\heinstructions*` (2894 onward); `\section` `\subsection` `\subsubsection` with three trailing optional arguments (tags, tags, page limit) (2897, 2924, 2933); `\participant` `\makeparticipantstable` (2899-2914); `\workpackage` `objectives` `descriptionofwork` `\task` `\deliverable` (3021-3051); `\makeworkpackagestable` `\makedeliverablestable` (3017, 3121); `\milestone` `\makemilestonestable` (3127-3140); `\criticalrisk` `\makecriticalriskstable` (3145-3153); `\staffeffort` `\makestaffefforttable` (3158-3172); `\subcontractingcost` `\makesubcontractingcoststable` (3178-3183); `\equipmentcost` `\makeequipmentcoststable` (3190-3195, 5.1 variant); `summarycanvas` `summarybox` `SidewaysFigure` (2972-3001). Variants for templates up to 4.0 also use `\opentag` `\closetag` (2896, 2961, 3248), `\purchasecost` `\makepurchasecoststable` (3203-3213), `\othercost` `\makeothercoststable` (3219-3228), `\inkindcontribution` `\makeinkindcontributionstable` (3232-3240)

## Component map
Rows marked "(inside class)" are set by the class code, not by the sample; they show what `class.heria` bundles.
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | heria.dtx:34, 36, 2876 | `class.heria` | `[showinstructions]`, version v5.1.1.0 |
| base class (inside class) | heria.dtx:650 | `class.article` | 11pt, a4paper |
| paper and size (inside class) | heria.dtx:650 | `page.class-options` | a4paper, 11pt |
| page geometry (inside class) | heria.dtx:652-661 | `page.geometry` | left=top=bottom=right=15mm, includehead, includefoot, headheight=10pt, headsep=5mm, footskip=18pt |
| font encoding (inside class) | heria.dtx:651 | `font.fontenc-t1` | T1 |
| text and math face (inside class) | heria.dtx:1687-1688 | `font.newtx` | `newtxtext`, `newtxmath`, no options |
| typewriter default (inside class) | heria.dtx:1689 | `font.family-default` | `\ttdefault`=lmvtt |
| font switches in heads, header, footer, boxes | heria.dtx:1700, 1786, 1705, 1050 | `mark.kernel`, `font.size-commands` | `\sffamily` `\bfseries` `\textsc`; `\scriptsize` `\footnotesize` `\large` |
| colours (inside class) | heria.dtx:692, 699-702 | `color.xcolor` | option `table`; HTML colours taggrey B5B5B5, footergrey D8D8D8, tablegrey F2F2F2, summaryblue 00B0F0; `blue!5!white` (1874) |
| links and PDF metadata (inside class) | heria.dtx:664-673 | `meta.hyperref` | pdftex, pdfusetitle, colorlinks=true, breaklinks=true, urlcolor=linkcolor=citecolor=black, pdfsubject={}, pdfkeywords={} |
| graphics driver (inside class) | heria.dtx:662 | `fig.graphicx` | option pdftex |
| running head (inside class) | heria.dtx:1698-1702 | `hf.fancyhdr` | style fancy; `\headrulewidth`=0pt; lhead `\sffamily\scriptsize Call: <id> --- <name>`; rhead, chead empty |
| footer (inside class) | heria.dtx:1695, 1703-1714 | `hf.fancyhdr`, `box.tcolorbox`, `pgnum.lastpage`, `sp.manual-space` | cfoot is a tcolorbox: nobeforeafter, fontupper=\scriptsize\sffamily, colback=footergrey, boxrule=0.75pt, halign=center, boxsep=0mm; text "Part B -- Page \thepage\ of \pageref*{LastPage}"; `\raisebox{\dimexpr..}` |
| title block | heria.dtx:1722-1736; sample 2886-2892 | `front.class-native`, `box.fancybox` | `\title` `\callname` `\callidentifier` `\calltopic` `\maketitle`; title in `\framebox[\textwidth]`, sans bold small caps, `Topic:` line when `\calltopic` is set |
| headings | heria.dtx:1784-1793 | `head.titlesec` | option explicit; `\titleformat` of section, subsection, subsubsection: `\normalfont\normalsize\bfseries\sffamily`, label `\thesection` etc., sep 1em, text `#1 \sectiontag\sectionpagelimit` |
| headings with tags and page limits | heria.dtx:1794-1851; sample 2897, 2924, 2933, 3013 | `head.class-native` | `\section{T}[open tags][close tags][page limit]`, star form for table titles (`\subsubsection*`) |
| tags and page-limit notes | heria.dtx:1745-1778 | `head.class-native` | `\opentag` `\closetag` print `#@TAG#` in `\textcolor{taggrey}` sans footnotesize, only for template versions below 5.1; page limit printed only with `showinstructions` |
| instruction switch and texts | heria.dtx:1859-1865, 1883-1898 | `class.heria`, `struct.input` | option `showinstructions`; `\input{hi-<name>}` (file name is a string) |
| instruction box | heria.dtx:1871-1881 | `box.tcolorbox` | fontupper=\sffamily, fonttitle=\sffamily\bfseries, colback=blue!5!white, colframe=blue!75!black, parbox=false, breakable |
| instruction texts (content of hi-* files) | heria.dtx:1902-2874 | `box.tcolorbox`, `list.kernel`, `list.enumitem`, `quote.kernel`, `mark.kernel`, `mark.ulem`, `fn.kernel`, `meta.hyperref`, `meta.url`, `font.icons`, `xref.kernel` | `tcolorbox[standard jigsaw,opacityback=0]` (1970, 1988, 2058, 2078, 2392, 2584); `itemize[label=\twarn]` (2140); `quote` (2002, 2341); `\uline` (2134); `\footnote` (2047, 2150); `\href` (2054); `\url` (2294); `\twemoji{warning}` through package `twemojis` (1867-1869); `\ref` (1956) |
| participants table | heria.dtx:732-787; sample 2899-2914 | `tbl.longtable`, `tbl.tabular` | `xltabular{0.9\textwidth}{\|l\|X\|l\|}`, `\hline`; rows come from `\participant{name}{short}{country}` |
| work package list table | heria.dtx:850-868; sample 3017 | `tbl.longtable`, `tbl.multirow`, `tbl.colortbl` | `xltabular{1.0\textwidth}{\|c\|X\|c\|c\|c\|c\|c\|}`, `makecell` `\thead`, `\theadfont`=\normalsize\bfseries, `\rowcolor{tablegrey}` |
| work package title box | heria.dtx:819-826 | `tbl.tabularx`, `tbl.colortbl` | `tabularx{1.0\linewidth}{\|>{\columncolor{tablegrey}}l\|X\|}` |
| objectives | heria.dtx:882-895; sample 3029-3033 | `box.tcolorbox`, `list.enumitem` | tcolorbox colback=white, parbox=false, boxrule=0.75pt, boxsep=0mm, breakable; `enumerate*[nolistsep,noitemsep,itemjoin={~---~},label=\textbf{O\arabic{@wpcount}.\arabic*}]` |
| description of work and tasks | heria.dtx:901-922; sample 3035-3043 | `box.tcolorbox`, `mark.kernel`, `num.counters` | same tcolorbox keys; `\task{name}{lead}{others}{months}` prints "Task n.m: name" bold and "(Lead; Participants; Month)" italic |
| deliverables table | heria.dtx:966-990; sample 3045-3121 | `tbl.longtable`, `tbl.colortbl`, `tbl.multirow`, `sp.ragged` | `{\|c\|>{\raggedright\hsize=.667\hsize\linewidth=\hsize}X\|>{\hsize=1.333\hsize\linewidth=\hsize}X\|c\|c\|c\|c\|p{15mm}\|}` |
| milestones table | heria.dtx:1024-1043; sample 3127-3140 | `tbl.longtable`, `tbl.colortbl`, `tbl.multirow` | `{\|c\|X\|p{26mm}\|c\|p{26mm}\|}` |
| critical risks table and tags | heria.dtx:1049-1063, 1094-1113; sample 3145-3153 | `tbl.longtable`, `box.tcolorbox` | `{\|p{60mm}\|c\|X\|}`; `\newtcbox{\risktag}[1][black]`: fontupper=\scriptsize\sffamily\bfseries, on line, arc=3pt, colupper=white, colback=#1!50!black, colframe=#1!50!black, boxrule=1pt, boxsep=0pt, left=2pt, right=2pt, top=1pt, bottom=.5pt |
| staff effort table | heria.dtx:1162-1208; sample 3158-3172 | `tbl.longtable`, `tbl.colortbl`, `tbl.multirow` | `{\|>{\columncolor{tablegrey}}l\|*{\value{@wpcount}}{r\|}>{\columncolor{tablegrey}}r\|}`; sums by `\fpeval` |
| subcontracting, equipment, other, purchase, in-kind cost tables | heria.dtx:1228-1272, 1303-1347, 1377-1419, 1458-1539, 1565-1610; sample 3178-3195 | `tbl.longtable`, `tbl.colortbl`, `tbl.multirow`, `sp.ragged` | `xltabular{\textwidth}{\|>{\columncolor{tablegrey}}l\|r\|X\|}` (1252, 1327, 1400); purchase `p{43mm}` first column (1519); in-kind `{\|>{\raggedright}p{40mm}\|>{\raggedright}p{35mm}\|r\|X\|}` (1589-1590) |
| summary tableau | heria.dtx:1629-1647; sample 2972-3001 | `box.tcolorbox` | `tcbraster[raster columns=3,raster equal height]`; box colframe=summaryblue, colbacktitle=summaryblue, fonttitle=\bfseries\sffamily, halign title=center, title={#1} |
| sideways float | heria.dtx:1657-1681; sample 2972, 2987 | `fig.class-native`, `fig.rotating`, `pg.landscape` | `SidewaysFigure` = `figure[p]` with `\rotatebox{90}`; page rotated by a shipout hook; `pdflscape` loaded at 1628 |
| captions | sample 2884, 2984, 3000 | `cap.caption`, `cap.kernel` | `\usepackage{caption}`, `\caption{..}`, `\ContinuedFloat` |
| cross-references | sample 2957, 2968-2970, 3000 | `xref.kernel` | `\label` `\ref` `\pageref`, `\IfLabelExistsTF` |
| verbatim package (loaded, unused) | heria.dtx:1870 | `code.verbatim` | `\RequirePackage{verbatim}` |
| not present | none | none | no contents list, bibliography, index, language package, theorems, abstract, code listing or maths in the sample |

## Bespoke code
The sample defines no macro, counter or environment (heria.dtx:2876-3253). All rows below sit in the published class `heria`, so they are not bespoke under W1 and are not blockers. They are recorded so the result can be re-read if class internals counted; "Reducible?" is the answer in that reading.
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\csname` data store with a counter per record (participants, work packages, deliverables, milestones, risks, staff effort, cost items) | heria.dtx:732-745, 795-808, 928-943, 996-1004, 1065-1074, 1119-1121, 1214-1222, 1289-1297, 1364-1371, 1436-1452, 1545-1559 | no (class scope, `BESPOKE/class` if counted) | layout computed from stored data |
| aux-file round trip for the work package table, with `\AtBeginDocument` `\AtEndDocument` `\AtVeryEndDocument` and a "Rerun" warning | heria.dtx:809-817, 828-844 | no (class scope) | `\protected@write\@auxout` plus hooks |
| `\whiledo` row generators and `\fpeval` person-month sums | heria.dtx:781-784, 984-987, 1037-1040, 1107-1110, 1132-1153, 1184-1204 | no (class scope) | loops and arithmetic drive printed rows |
| purchase-cost row sort (`\swap`, three `\ifthenelse` comparisons) | heria.dtx:1478-1516 | no (class scope) | sorting in macros |
| `\@maketitle` redefinition | heria.dtx:1722-1736 | no under the rubric's kernel-internals rule (class scope); the look alone is `box.fancybox` | `\framebox`, `\textsf\textbf\textsc` |
| `\extendedsection` family wrapping `\section` with `\NewCommandCopy` | heria.dtx:1794-1851 | no (class scope) | macro logic around `head.titlesec` |
| `SidewaysFigure` (`\NewEnviron`, `abspage` counter, aux write, `shipout/background` hook setting `\pdfpageattr{/Rotate ..}`) | heria.dtx:1657-1681 | no (class scope) | shipout code, adapted from a tex.stackexchange answer (1650-1654) |
| expl3 helpers `\showpagelimit`, `\hetag`, `\templateversion` check; `\ifdim\@templateversion pt<..` switches in the `hi-*` texts | heria.dtx:710-719, 1743-1778, 2084, 2218, 2438 | no (class scope) | conditional printing from a stored version |
| Package, option and colour lines, tcolorbox wrappers (`objectives`, `descriptionofwork`, `summarycanvas`, `summarybox`, `instructions`, `\risktag`), `\titleformat`, `\cfoot` | heria.dtx:650-702, 882-911, 1049-1063, 1629-1647, 1687-1714, 1784-1793, 1857-1881 | yes | the ways in the Component map |
| Not traced: `\ifthenelse`, `\whiledo` (762, 781) and `\IfEq` (1144) are used but `ifthen` and `xstring` are not in the class's `\RequirePackage` list (650-1870); the transitive loader was not found | heria.dtx:762, 781, 1144 | not decided | no compile here |

## Content-opaque
none (no TikZ or image content; the summary tableau is boxes of text, and the person-month sums are values the class computes)

## Lib changes
- New ways proposed: none (`twemojis` maps to `font.icons`, a package printing a pictogram by name; `class.heria` needs no proposal, record its vocabulary from Class setting)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
