yes

# 0914-oup-authoring-template: OUP journals authoring template (class `oup-authoring-template`)

- Unverified: read from the source, not compiled.
- Source: Source/0914-oup-authoring-template/ (origin: https://mirrors.ctan.org/macros/latex/contrib/oup-authoring-template.zip; licence: lppl1.3)
- Kind: journal
- Lib: v6
- Engine: pdfLaTeX-compatible (the sample text speaks of latex and pdflatex, oup-authoring-template.tex:320-323; the PostScript `\special{ps: ...}` page-box code at oup-authoring-template.cls:504-519 is emitted at shipout but is a DVI/dvips device that pdfTeX ignores, and the `\rotstart` specials at cls:2095-2103 are called only by `\rotl` `\rotr` for `processtable`, which the sample does not use; `\XeTeXLinkBox` in `\ORCID` at oup-authoring-template.cls:3024 comes from hyperref, not checked here)
- Look carried by: class (OUP's own `oup-authoring-template.cls` sets page, heads, front matter, headings, floats, lists, theorem styles and boxes; the sample adds only options, `\newtheorem` calls and an empty `\societylogo`)
- Class origin: ctan
- Main file: oup-authoring-template.tex (other samples: doc/oup-authoring-template-doc.tex is a plain `article` user manual, not a template sample)
- Read: main yes, zip-local classes and styles all (the one `.cls` read in full, all 3234 lines; the two `.bst` files, which the sample leaves commented out, read at their headers only)

## Verdict
Yes. The look comes from one published class: OUP's `oup-authoring-template` (a CTAN package, read at ctan.org/pkg/oup-authoring-template: maintainer Peter Jones, copyright Oxford University Press, LPPL 1.3, v1.5 of 2026-07-14; the file header says the same, oup-authoring-template.cls:1-28), so by the rubric's second ruling it is the single way `class.oup-authoring-template`. The sample only sets class options, declares theorems on class-defined styles, sets `\graphicspath` and defines an empty `\societylogo`; all of that reduces to lib ways. Three things inside the class are recorded and not counted: kernel redefinition (`\@startsection`, `\@maketitle`, `\@makecaption`, a two-column `\@outputdblcol`), TikZ drawing (`\dhorline`, the ORCID logo) and one unconditional `\immediate\write18{texcount ...}` at oup-authoring-template.cls:3229. They would be BESPOKE/class, ART/class and EXTERNAL/class if the class were zip-local; it is published (W1). The texcount call only writes `wordcount.txt` for the optional `\wordcount` (cls:3230, never called in the sample or the manual), so no page output depends on it and TeX continues if the call is refused; this is a judgement against ruling 1, which concerns packages the document cannot compile without.

## Blockers
none

## Class setting
(Short forms used inside prose and parameter cells: `tex:N` is oup-authoring-template.tex:N and `cls:N` is oup-authoring-template.cls:N; Evidence cells spell the paths out.)
- Class: `class.oup-authoring-template` options: `unnumsec` (no section numbers printed, oup-authoring-template.cls:62,1671), `webpdf` (cropped PDF page, no crop marks, cls:65,345-350,471-474), `contemporary` (layout family, cls:69), `large` (paper size, cls:71,112-115). Alternatives `modern`/`traditional`, `medium`/`mediumone`/`small`, `namedate`, `numbered`, `final`, `otherarticle`, `draft` are options in the class (cls:51-75) and commented lines in oup-authoring-template.tex:23-37.
- Class-native vocabulary used: `\journaltitle \DOI \copyrightyear \pubyear \vol \issue \access \appnotes \firstpage` (tex:67-76); `\title[short]{}` (tex:80); `\author[1,$\ast$]{}` with `\ORCID{}` (tex:82-86); `\address[n]{\orgdiv \orgname \orgaddress{\street \postcode \state \country}}` (tex:88-91); `\corresp[]{}` (tex:93); `\received \revised \accepted` (tex:95-97); `\abstract{}` (tex:113); `\keywords[label]{}` (tex:115,117); `\otherabstract[heading]{}` (tex:119-121); `\boxedtext{head}{body}` (tex:123-128); `\maketitle` (tex:130); environments `unlist` (tex:623), `boxtext[title]` (tex:631), `tablenotes` (tex:271), `biography{image}{text}` (tex:826), `appendices` (tex:835), `table*`, `figure*`, `sidewaystable`, `sidewaysfigure`; rule commands `\toprule \midrule \botrule`; `\figalttext[short]{long}` (tex:331); theorem styles `thmstyleone`, `thmstyletwo`, `thmstylethree` (tex:50-60) and the class `proof`; `enumerate[label template]` (tex:570-581). Present in the class but only commented out or unused in the sample: `\subtitle`, `\editor`, `\FMAUBIO`, `\history`, `\lastpage`, `epigraph`, `methods`, `\wordcount`, `\societylogo` (the sample defines it empty, tex:44).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | oup-authoring-template.tex:22 | `class.oup-authoring-template` | unnumsec, webpdf, contemporary, large |
| paper size and text block | oup-authoring-template.cls:112-115, 734-754 | `page.class-options` | contemporary+large: paper 210 x 276 truemm; textwidth 185mm, textheight 58 baselines, side margins 12.5mm, topmargin 7.1mm, headsep 5.8mm, footskip 16pt, columnsep 6mm; the class sets them with raw `\setlength` |
| PDF page boxes, two-sided | oup-authoring-template.cls:165, 345-350, 407, 471-474 | `page.class-options` | webpdf: crop box = trim box, `\crop[cam]` only when not webpdf; `\@twosidetrue` |
| columns | oup-authoring-template.cls:2517-2523; oup-authoring-template.tex:39 | `cols.twocolumn-cmd` | class calls `\twocolumn` unless mediumone/small; the sample's `\onecolumn` is commented out |
| full-width floats | oup-authoring-template.cls:145, 1959, 2019; oup-authoring-template.tex:278, 334 | `cols.cuted` | `stfloats` loaded; `figure*`, `table*` |
| running heads | oup-authoring-template.cls:870-918 (contemporary 895-900) | `hf.class-native` | 8bp/10bp sans line: page number (9bp medium series), short vertical rule (.3pt x 8pt), journal title, year, volume, issue; mirrored on odd pages; empty foot (cls:872-873) |
| first-page head and foot | oup-authoring-template.cls:928-1019 (contemporary 968-985, 997-1017); oup-authoring-template.tex:67-74, 95-97 | `hf.class-native` | opening head: journal, year, pages, DOI, access, appnotes, grey 55 x 20pt logo box, `\societylogo`; foot: 0.5pt rule, received/revised/accepted history, copyright line |
| page numbering | oup-authoring-template.tex:76; oup-authoring-template.cls:1021-1074 | `pgnum.pagenumbering` | `\firstpage{1}` sets the page counter; the class redefines `\pagenumbering` and keeps first and last page through the aux file |
| title block | oup-authoring-template.tex:67-98, 130; oup-authoring-template.cls:1339-1388, 1428-1659 | `front.class-native` | contemporary: centred 20bp bold title, 12bp authors with superscript affiliation marks (`\author[1,$\ast$]`), 7bp sans centred addresses and correspondence, `\vskip`s per layout |
| ORCID mark | oup-authoring-template.tex:86; oup-authoring-template.cls:3021-3029 | `front.class-native` | `\ORCID{id}` prints a linked logo drawn by TikZ inside the class |
| abstract | oup-authoring-template.tex:113; oup-authoring-template.cls:1205, 1578-1656 | `abs.class-native` | `\abstract{}`; contemporary: dotted rule above and below (`\dhorline`, cls:1580, 1643), centred bold 12bp heading "Abstract", 8bp bold sans text |
| keywords | oup-authoring-template.tex:115, 117; oup-authoring-template.cls:1229-1247 | `abs.keywords` | `\keywords[label]{list}`, default label "Keywords", bold italic sans label |
| other abstract | oup-authoring-template.tex:119-121; oup-authoring-template.cls:1251-1271 | `abs.class-native` | `\otherabstract[heading]{text}`; the graphical-abstract sample is a grey `\colorbox` placeholder (content) |
| key-messages box | oup-authoring-template.tex:123-128; oup-authoring-template.cls:1281-1283, 2358-2359 | `abs.class-native` | `\boxedtext{head}{body}` = `\fbox{\parbox{.97\textwidth}{...}}`, fboxsep 6pt, fboxrule 1pt |
| headings | oup-authoring-template.tex:139-182; oup-authoring-template.cls:1671-1767 (contemporary 1683-1685, 1697-1698, 1709-1710, 1721-1722, 1733-1734) | `head.class-native` | 5 levels: section 10.5/14bp sans bold centred, subsection 10/12bp sans centred, subsubsection 9.5bp italic sans centred, paragraph 8.5bp bold centred, subparagraph 8.25bp centred; section skips -15pt plus -3pt / 6pt; `unnumsec` drops the printed number |
| heading depth | oup-authoring-template.cls:1669, 2367 | `num.secnumdepth` | secnumdepth 3, tocdepth 4 |
| counter formats | oup-authoring-template.cls:1076-1106 | `num.counters` | `\thesection`...`\thesubparagraph` renewed as arabic dotted chains |
| appendices | oup-authoring-template.tex:835-992; oup-authoring-template.cls:2717-2988 | `num.appendix` | `appendices` environment; the class inlines the code of the CTAN `appendix` package (options toc, title, titletoc, header, page, cls:2737-2742); sections become A, B, C |
| lists | oup-authoring-template.tex:570-618; oup-authoring-template.cls:2147-2293 | `list.kernel` | itemize and enumerate; the class's `\enumerate[template]` sizes the label from its argument (cls:2204-2239); labels `1.` `a.` `i.`, `(1)`; bullets and dash (cls:2147-2161) |
| unnumbered list | oup-authoring-template.tex:623-629; oup-authoring-template.cls:2295-2305 | `class.oup-authoring-template` | `unlist` environment: list with zero label, leftmargin 2em, itemindent -2em, itemsep 2pt (contemporary) |
| quotation | oup-authoring-template.tex:714-717; oup-authoring-template.cls:2311-2338 | `quote.kernel` | `quote` is `\let` to the class's `quotation`; contemporary: sans, dotted rules above and below (cls:2331, 2334), margins 9pt |
| footnotes | oup-authoring-template.tex:143; oup-authoring-template.cls:829-838, 2400-2405 | `fn.kernel` | `\footnote`; footnotesep 7pt, `\skip\footins` 12pt plus 6pt minus 1pt, 0.5pt rule |
| footnote layout package | oup-authoring-template.cls:150 | `fn.footmisc` | `footmisc[bottom]` |
| display maths | oup-authoring-template.tex:193-210, 922-938; oup-authoring-template.cls:139, 2487, 2710 | `math.amsmath` | `equation`, `align`, `\nonumber`; `\jot` 5pt |
| math alphabets | oup-authoring-template.tex:211-213; oup-authoring-template.cls:143, 2711 | `math.amssymb` | `\mathbb` (amssymb) |
| math script letters | oup-authoring-template.tex:211-213; oup-authoring-template.cls:2711 | `math.bm` | `\mathscr` (mathrsfs) |
| theorem declarations | oup-authoring-template.tex:50-60, 660-697 | `thm.amsthm` | `\theoremstyle{thmstyleone,thmstyletwo,thmstylethree}`, `\newtheorem{theorem}{Theorem}`, `{proposition}[theorem]`, `{example}`, `{remark}`, `{definition}` |
| theorem styles and proof | oup-authoring-template.cls:2621-2630, 2639-2692 | `thm.class-native` | four `\newtheoremstyle`s (contemporary: sans medium body with leftskip 12pt, sans bold head, 11.5pt above and below, head space .5em); `proof` with italic head and open-square QED (`\opensquare`, cls:2617-2619) |
| figures | oup-authoring-template.tex:327-338, 857-878; oup-authoring-template.cls:137, 1951-1960 | `fig.graphicx` | `figure`, `figure*`, default placement `tbp`; `\graphicspath{{Fig/}}` (tex:43); the sample draws grey rules in place of images |
| rotated floats | oup-authoring-template.tex:298-315, 355-359; oup-authoring-template.cls:146, 1962-1967, 2041-2062 | `fig.rotating` | `rotating[figuresright]`: `sidewaystable`, `sidewaysfigure` and starred forms |
| figure alt text | oup-authoring-template.tex:331; oup-authoring-template.cls:1958 | `fig.class-native` | `\figalttext[short]{long}` is a class macro that swallows its arguments |
| float placement | oup-authoring-template.cls:839-860 | `fig.placement` | totalnumber 10, topnumber 5, topfraction .9, textfraction .06, floatpagefraction .94, floatsep 12pt, textfloatsep 20pt, intextsep 18pt |
| wrapped figure in bios | oup-authoring-template.cls:2558, 2580 | `fig.wrapfig` | `wrapfig` places the author photo left of the biography text |
| tables | oup-authoring-template.tex:260-315, 652-657; oup-authoring-template.cls:140, 1831-1837, 1996-2062 | `tbl.tabular` | `tabular*{\columnwidth}{@{\extracolsep\fill}llll...}`, `\multicolumn`, `\cline`; arraycolsep and tabcolsep .5em, arrayrulewidth .5pt; the style table at tex:652-657 is a plain `tabular{|l|p{0.6\columnwidth}|}` with `\hline` |
| table column gap | oup-authoring-template.tex:280, 300, 884 | `sp.lengths` | raw `\tabcolsep=0pt` inside `table*` and `sidewaystable`, `\tabcolsep16pt` inside the appendix table |
| manual spacing | oup-authoring-template.tex:257, 651, 713 | `sp.manual-space` | `\medskip`, `\break`, `\newline`, `\noindent` around the sample text |
| dashed table rules | oup-authoring-template.cls:1977-1980, 2000-2002 | `tbl.arydshln` | contemporary: `\toprule` `\midrule` `\botrule` become `\hdashline` plus `\vspace` inside the table environments; dashlinedash 0.5pt, dashlinegap 1.5pt |
| rule commands | oup-authoring-template.tex:263-269; oup-authoring-template.cls:1910-1948 | `class.oup-authoring-template` | `\toprule \midrule \botrule` are defined by the class (not booktabs); `\cline` followed by 3pt (cls:1946) |
| table notes | oup-authoring-template.tex:271-275; oup-authoring-template.cls:1084-1098 | `class.oup-authoring-template` | `tablenotes` environment: zero-margin list, 6.5bp/8.5bp (contemporary large), `\item[$^{1}$]` marks |
| captions | oup-authoring-template.tex:261, 279, 330; oup-authoring-template.cls:1858-1906, 1853-1854 | `cap.kernel` | `\caption` through the class's `\@tablecaption` (8bp/9.5bp sans, bold label) and `\@figurecaption` (7.5bp/9.5pt sans); abovecaptionskip 13pt, belowcaptionskip 2pt (the `\if@traditional` test at cls:1849 sits inside the contemporary branch, so 13pt and 2pt win over the 11pt and 5.5pt of cls:1843-1847) |
| caption package | oup-authoring-template.cls:138 | `cap.caption` | loaded; the manual suggests `\captionsetup{labelformat=empty}` for a graphical abstract (doc/oup-authoring-template-doc.tex:271) |
| listings | oup-authoring-template.tex:411-421; oup-authoring-template.cls:2715 | `code.listings` | `\lstset{language=Pascal}`; `lstlisting[frame=single,framexleftmargin=-1pt,framexrightmargin=-17pt,framesep=12pt,linewidth=0.98\textwidth]` |
| minipage wrapper | oup-authoring-template.tex:411-421, 880-896 | `box.minipage` | `\begin{minipage}{\hsize}` around the listing; `{.52\columnwidth}` around an appendix table |
| algorithms | oup-authoring-template.tex:383-406; oup-authoring-template.cls:2712-2714 | `alg.algorithmicx` | `algorithm` float, `algorithmic[1]`, `\Require \Ensure \State \If \Else \EndIf \While \EndWhile` |
| verbatim examples | oup-authoring-template.tex:232-254, 341-347, 444-556 | `code.verbatim` | `\verb+...+` and `verbatim` blocks show commands |
| text box | oup-authoring-template.tex:631-644; oup-authoring-template.cls:3079-3129 | `class.oup-authoring-template` | `boxtext[title]`: 6pc half rules above and below, label "Box n", inner sections remapped to `\boxsection` and kin (cls:3105-3122), leftskip 8pt; a hand-built box, the `tcolorbox` version is commented out (cls:3131-3182) |
| author biography | oup-authoring-template.tex:826-831; oup-authoring-template.cls:2571-2587 | `front.class-native` | `biography{image}{text}`: 8bp/9.5bp text, optional photo in a `wrapfigure` |
| bibliography list | oup-authoring-template.tex:743-815; oup-authoring-template.cls:2412-2422 | `bib.thebibliography` | `\bibitem[Author et al.(2014)]{key}` with `\newblock`; class list: leftmargin 4mm, itemindent -4mm, `\small`, heading `\section{\bibname}` |
| citations | oup-authoring-template.tex:560-561; oup-authoring-template.cls:44, 52-53, 2424, 2435, 2447-2450 | `bib.natbib` | `\cite`, `\citep`; numbers forced by default, `namedate` gives `authoryear,round`, `numbered` gives `numbers,square`; label `#1.` plus 10pt, bibhang 12pt, bibsep 0 |
| BibTeX styles (unused here) | oup-authoring-template.tex:817-823; oup-plain.bst:1-9; oup-abbrvnat.bst:1-15 | `bib.bibtex-bst` | `\bibliographystyle{oup-plain}` or `{oup-abbrvnat}` with `\bibliography{reference}`; oup-plain.bst is the standard plain style renamed (its header, lines 1-9), oup-abbrvnat.bst a modification of abbrv.bst for natbib (header, lines 2-14), so the style name is the parameter |
| cross-references | oup-authoring-template.tex:149, 214, 229, 431 | `xref.kernel` | `\label{sec5}`, `\ref`, `Table~\ref{tab1}` |
| hyperlinks | oup-authoring-template.cls:2991; oup-authoring-template.tex:93 | `meta.hyperref` | `hyperref[hidelinks]`; `\href{email:...}{...}` in `\corresp` |
| urls | oup-authoring-template.tex:143; oup-authoring-template.cls:2709 | `meta.url` | `url` loaded; `\url` in a footnote |
| colour | oup-authoring-template.tex:121, 329; oup-authoring-template.cls:141-142, 1330-1333, 1425-1426, 3004 | `color.xcolor` | `black!20`, `black!50`, `black!60`; cmyk gray .15, grayfifty .5, jnlclr, jnlruleclr, orcid green A6CE39 |
| type sizes | oup-authoring-template.cls:233-241, 275-324 | `font.size-commands` | `\normalsize` 8bp/11.5bp (contemporary large), `\small` 7/10, `\footnotesize` 6.5/9.5, `\large` 11.5/12 ... `\Huge` 30/30, set with `\@setfontsize` |
| cm font scaling | oup-authoring-template.cls:149 | `font.exscale` | `fix-cm`, load-only (same type as the lib's `fix-cm` entry) |
| sans family and series | oup-authoring-template.cls:152-159, 1452, 1683-1685 | `mark.kernel` | `\sffamily`, `\bfseries`, `\itshape`, `\fontseries{m}`; no font package, Computer Modern (doc/oup-authoring-template-doc.tex:125) |
| paragraph lengths | oup-authoring-template.cls:533-538, 551-553 | `sp.lengths` | parindent 1em (contemporary), parskip 0, lineskip 1pt, small/med/bigskipamount |
| penalties | oup-authoring-template.cls:554-563 | `sp.penalties` | clubpenalty 10000, widowpenalty 10000, displaywidowpenalty 100, predisplaypenalty 10000, postdisplaypenalty 2500, brokenpenalty 10000 |
| hyphenation and tolerance | oup-authoring-template.cls:564-565, 2506-2510, 2554 | `sp.hyphenat` | lefthyphenmin and righthyphenmin 3, tolerance 9999, vbadness 9999, demerits set beside them, `\hyphenation{Figure Table Figures Tables}` |
| word spacing | oup-authoring-template.cls:2490-2491, 2514 | `sp.frenchspacing` | the class redefines `\frenchspacing` with sfcodes 1500 and calls it |
| page fill | oup-authoring-template.cls:2513 | `pg.flush` | `\flushbottom` |
| contents list | oup-authoring-template.cls:2364-2392 | none | the class defines `\l@section` and kin, but the sample never calls `\tableofcontents` (not in scope) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\societylogo` empty definition | oup-authoring-template.tex:44 | yes | class hook, referenced by the class's opening head (cls:976, 984); empty value means no logo; one `\newcommand` under `class.oup-authoring-template` |
| `\newtheorem` calls on class styles | oup-authoring-template.tex:50-60 | yes | `thm.amsthm`: `\theoremstyle{thmstyleone}`, `\newtheorem{theorem}{Theorem}`, `[theorem]` sibling for proposition, styles two and three for example, remark, definition |
| `\graphicspath{{Fig/}}` | oup-authoring-template.tex:43 | yes | `fig.graphicx`; folder `Fig/` is not shipped and no `\includegraphics` is called |
| class kernel redefinitions (`\@startsection`, `\@maketitle`, `\@makecaption`, `\enumerate`, `\@outputdblcol`) | oup-authoring-template.cls:1769-1791, 1428-1659, 1858-1906, 2204-2239, 3186-3223 | not applicable | published class (W1), carried by `class.oup-authoring-template`; BESPOKE/class if zip-local |
| TikZ dotted rule `\dhorline` and ORCID logo | oup-authoring-template.cls:2993-3029 | not applicable | same; ART/class if zip-local; `\ORCID` is called at oup-authoring-template.tex:86, `\dhorline` through the abstract and quotation (cls:1580, 1643, 2331) |
| `\immediate\write18{texcount ...}` | oup-authoring-template.cls:3229-3230 | not applicable | same; EXTERNAL/class only if `\wordcount` were used, the sample does not call it (grep: no `wordcount` in the .tex files) |
| PostScript page-box specials (`\SetCrop`, `\pdf@page@parameters`) and `\rotstart` | oup-authoring-template.cls:439-519, 2095-2103 | not applicable | published class; the `\special{ps:}` code targets dvips and is ignored by pdfTeX, `webpdf` skips the crop-mark branch (cls:352-408); `\rotstart` is reached only through `processtable`, unused here |

## Content-opaque
- grey rectangle placeholders for figure artwork: oup-authoring-template.tex:329, 336, 357, 859, 876; graphical-abstract placeholder: oup-authoring-template.tex:121; author photo placeholder: oup-authoring-template.tex:826
- equations, table cell data, the Pascal listing and the algorithm lines are content
- alt-text strings of `\figalttext` (oup-authoring-template.tex:331) go to a no-op macro
- optional hooks left commented in the sample, so not in scope: `lineno` (tex:47-48), `showframe` (tex:41), `draftwatermark` (tex:62-64), `\FMAUBIO` (tex:101-103), `epigraph` (tex:132-137), `\bibliographystyle` lines (tex:817-823)

## Lib changes
- New ways proposed: none (considered, not proposed because the class loads them internally and the sample calls none of them: `crop`, `chngpage`, `totcount`, `flushend`, `footnote`, `subfloat`, `anyfontsize`, `tikz` with `svg.path` and `decorations.markings`)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
