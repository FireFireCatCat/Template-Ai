yes

# 0326-attinormativi: attinormativi (LaTeX class for Italian normative acts)

- Unverified: read from the source, not compiled.
- Source: Source/0326-attinormativi/ (origin: https://mirrors.ctan.org/macros/latex/contrib/attinormativi.zip; licence: LPPL 1.3c, LICENSE.md:4, attinormativi.ins:8-13)
- Kind: misc (a municipal regulation with articles, annexes and indexes; no lib kind fits a legal act)
- Lib: v3
- Engine: pdfLaTeX-compatible (the sample's active configuration; the optional `accessible` option, commented out in the sample, needs LuaLaTeX + `\DocumentMetadata`, dtx:1186-1212)
- Look carried by: class (the sample adds content, class options, `cleveref` and `hologo`; every look and structure command is the class's own, dtx:1352-2187)
- Class origin: ctan (the zip is the CTAN package, README.md:108 "distributed via CTAN ... included in TeX Live"; `attinormativi.cls` is not in the zip, only its source `attinormativi.dtx` and `attinormativi.ins`, which extracts it, attinormativi.ins:65)
- Main file: attinormativi-esempi.tex (other samples: the minimal example inside attinormativi.dtx:676-729)
- Read: main yes, zip-local classes and styles all (no .cls or .sty ships; the class source `attinormativi.dtx` was read in full, lines 1-2194, the code is dtx:935-2189)

## Verdict
Yes. The look is carried entirely by one published CTAN class, `attinormativi` (a `book`-based class, dtx:1064-1068); the sample defines no macro, environment or counter of its own (only `\usepackage{cleveref}` and `\usepackage{hologo}`, attinormativi-esempi.tex:104-105) and sets class options and metadata strings. Read for transparency, the class code is a composition of `titlesec`, `enumitem`, `geometry`, `babel`, `hyperref` and kernel counter, toc and box commands, with no output routine, box algorithm, TikZ or external tool. An emitter writes `\documentclass[bozza,sansserif,simplex,12pt]{attinormativi}`, the two packages and the class's own body commands, with no copied macro logic. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.attinormativi` options: `bozza` (draft: editorial notes and banner print, dtx:961), `sansserif` (alias `sanserif`) or `serif` (default), `simplex` (alias `oneside`, default) or `duplex` (alias `twoside`), `left=` `right=` `top=` `bottom=` margin keys (defaults 35, 30, 25, 25 mm, dtx:1021-1024), `accessible` (PDF/UA-1 tagging, dtx:978); every other option goes to `book` (dtx:1035-1041), e.g. `12pt`. The sample uses `bozza,sansserif,simplex,12pt` (attinormativi-esempi.tex:82-89).
- Class-native vocabulary used: metadata `\tipoatto` `\numeroatto` `\dataatto` `\autoritaatto` `\titoloatto` `\oggettoatto` (attinormativi-esempi.tex:111-119); `\maketitle` = `\frontespizioatto` (dtx:1489); hierarchy `\libro` `\titolo` `\capo` `\sezione` `\articolo` `\comma`, each `[manual number]{title}[label]` (attinormativi-esempi.tex:169, 172, 174, 333, 579, 675); environments `preambolo` (155), `lettere` (186), `numeri` (306), `definizioni` with `\definizione{term}{text}[label]` (199-204); typed final provisions `\normatransitoria` `\abrogazioni` `\entrataInVigore` (406-421); `\allegato[id]{title}[label]` (427); indexes `\indicearticoli` `\indiceallegati` `\indicedefinizioni` (149, 726-727); draft `\bozzainfo` `\notaredaz` `\notaredazinline` (144, 230, 327); references `\artref` `\articoloeref` `\artcomma` `\defref` (571, 652, 658, 212). Unused but defined: `\libro`, `\sezione`, `relazione`, `\commaref`, `\allegatoref`, `\ANLibroName`-style name macros (dtx:1352-1357).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | attinormativi-esempi.tex:82-89; dtx:1064-1068 | `class.attinormativi` | options `bozza,sansserif,simplex,12pt`; loads `book[oneside,openany]`, or `book[twoside,openright]` for `duplex` |
| paper, size, sides | attinormativi-esempi.tex:85-87; dtx:1062-1068 | `page.class-options` | `12pt`; simplex = oneside+openany, duplex = twoside+openright |
| page geometry | dtx:1128-1146 | `page.geometry` | a4paper, top=25mm, bottom=25mm, left=35mm, right=30mm (duplex: twoside, inner=left, outer=right); margins overridable by class keys (variant commented at attinormativi-esempi.tex:93) |
| serif text face | dtx:1109, 1120 | `font.mathptmx` | `tgtermes` (default); xe/lua branch `fontspec` below |
| sans text face | dtx:1105, 1110 | `font.helvet` | `tgheros` (`scale=0.92` as companion); with `sansserif` it is the main face |
| mono face | dtx:1106, 1111 | `font.mono` | `tgcursor` |
| encodings | dtx:1102-1103 | `font.fontenc-t1` | `inputenc[utf8]`, `fontenc[T1]`, pdfTeX only (`iftex` switch, dtx:1092, 1101) |
| xe/lua fonts | dtx:1114-1123 | `font.fontspec` | `\setmainfont{TeX Gyre Termes}` or `{TeX Gyre Heros}`, `\setsansfont[Scale=0.92]`, `\setmonofont{TeX Gyre Cursor}` (not the sample's engine) |
| default family for `sansserif` | dtx:1107 | `font.family-default` | `\renewcommand{\familydefault}{\sfdefault}` |
| type sizes | dtx:1425-1481, 1573-1590 | `font.size-commands` | `\Large` `\huge` `\LARGE` `\large` `\normalsize` on title-page lines and heading levels |
| language | dtx:1150, 1359-1362 | `lang.babel` | `babel[italian]`; `\addto\captionsitalian` sets `\partname`=Libro, `\chaptername`=Titolo |
| microtypography | dtx:1151 | `sp.microtype` | defaults |
| emergency stretch | dtx:1226 | `sp.lengths` | `\emergencystretch=2em` in `\AtBeginDocument` |
| hyperlinks | dtx:1166, 1247-1253 | `meta.hyperref` | `colorlinks`, link/cite/url colours black, `pdfborder={0 0 0}` |
| colour | dtx:1155, 1311 | `color.xcolor` | `\textcolor{red}` for the inline editorial note |
| PDF/UA tagging (option off in sample) | attinormativi-esempi.tex:75-79, 88; dtx:1186-1216, 1612-1622 | `meta.documentmetadata` | `\DocumentMetadata{pdfversion=1.7,pdfstandard=UA-1,lang=it-IT}` before `\documentclass`; `tagpdf` `\tagpdfsetup{add-new-tag={part/H1} ... {subsubsection/H5}}`; LuaLaTeX only |
| title page | attinormativi-esempi.tex:111-119, 140; dtx:1383-1395, 1418-1489 | `front.class-native` | six metadata strings; `\maketitle` alias; each field printed only when non-empty; reduction in Bespoke code |
| running heads, page numbers | dtx:1916, 2105, 2172 (no `\pagestyle` anywhere in the class) | `hf.pagestyle-kernel` | `book` default `headings`; `\markboth` set by the three index chapters |
| heading levels (vocabulary) | attinormativi-esempi.tex:169-174, 333; dtx:1754-1766 | `head.class-native` | Libro=`\part`, Titolo=`\chapter`, Capo=`\section`, Sezione=`\subsection`, Articolo=`\subsubsection`, Comma=`\paragraph` (dtx:1754-1766) |
| heading formats | dtx:1572-1603 | `head.titlesec` | `\titleformat{\part..\subsubsection}[display]{\normalfont\Huge..\normalsize\bfseries\centering}{<Name>~\the<ctr>}{1ex or 0.5ex}{}` (articles `\itshape`); `\titleformat{\paragraph}[runin]{\normalfont\normalsize}{\theparagraph.}{0pt}{}`; `\titlespacing*` per level |
| numbering depth | dtx:1236-1237 | `num.secnumdepth` | `secnumdepth=6`, `tocdepth=3` |
| counters and number forms | dtx:1506-1518 | `num.counters` | `\thepart` `\thechapter` `\thesection` `\thesubsection` Roman; `\counterwithout{subsubsection}{subsection}` (article numbers run through the whole document); `\counterwithin*{paragraph}{subsubsection}`; arabic article and comma numbers |
| manual article, comma and annex numbers | attinormativi-esempi.tex:579, 603, 641, 675, 702-712; dtx:1698-1717, 1766-1805, 2142-2160 | `num.counters` | optional `[n]`: group, save counter, `\renewcommand\the<ctr>{n}`, emit the heading, `\setcounter` restore |
| preamble clauses | attinormativi-esempi.tex:155-166; dtx:2006-2013 | `head.class-native` | `preambolo` = `\chapter*{Preambolo}` + `\addcontentsline{toc}{chapter}` |
| typed final provisions | attinormativi-esempi.tex:406-421; dtx:2047-2060 | `head.class-native` | `\articolo{Entrata in vigore}`, `\articolo{Abrogazioni}` or `\articolo{Norma transitoria}`, then `\comma{text}` (optional `[n]` and `[label]` forwarded, dtx:2047-2056) |
| annexes | attinormativi-esempi.tex:427, 446; dtx:2098-2160 | `head.class-native` | `\allegato` = `\clearpage` + `\chapter*{Allegato <A..>\\ \large title}`, counter `ANallegato` as `\Alph`, toc and annex-index entries |
| table of contents | attinormativi-esempi.tex:148 | `toc.kernel` | `\tableofcontents` |
| article, annex and definition indexes | attinormativi-esempi.tex:149, 726-727; dtx:1914-1928, 2103-2123, 2170-2187 | `toc.kernel` | `\chapter*` + `\markboth` + `\@starttoc{art\|alg\|dfn}`; `\addcontentsline{art\|alg\|dfn}`; `\l@ANarticolo` = `\@dottedtocline{1}{0pt}{8.5em}`, annex 10.5em, definition 0em |
| lettered and numbered lists | attinormativi-esempi.tex:186-191, 306-314; dtx:1841-1857 | `list.enumitem` | `\newlist{lettere}{enumerate}{1}` label=`\alph*)`; `\newlist{numeri}` label=`\arabic*)`; leftmargin=2.5em, itemsep=0.2ex, topsep=0.5ex |
| definitions list | attinormativi-esempi.tex:199-227; dtx:1910-1971 | `list.kernel` | kernel `list` environment: leftmargin 2.5em, labelwidth 2em, labelsep 0.75em, itemsep 0.4ex, topsep 0.6ex; label `\textbf{a)}`, term in bold; entry also written to the `dfn` file; counter `ANdefinizione` as `\alph` |
| cross references | attinormativi-esempi.tex:571, 652, 658; dtx:1640-1646 | `xref.kernel` | `\artref` = `art.~\ref`, `\articoloeref`, `\commaref`, `\artcomma` as aliases of `\ref`; `\label` optional last argument |
| cleveref names | attinormativi-esempi.tex:104, 257, 269; dtx:1648-1669 | `xref.cleveref` | `\crefname`/`\Crefname` for part..paragraph, `ANdefinizione`, `ANallegato`; set in `\AtBeginDocument` only if `cleveref` is loaded |
| definition citation | attinormativi-esempi.tex:212; dtx:1970-1971 | `xref.hyperref` | `\defref` = `\emph{\nameref{label}}` |
| draft banner and notes | attinormativi-esempi.tex:144, 230, 327; dtx:1283-1338 | `box.fancybox` | `\bozzainfo` = `center` + `\fbox` + `minipage` 0.85\linewidth + `\today`, then `\newpage`; `\notaredaz` = `\fbox` + `minipage` 0.96\linewidth `\small`, counter `ANnotaredaz`; `\notaredazinline` = red `[Nota redazionale: ...]`; all print only with class option `bozza` |
| minipage inside notes | dtx:1294-1297, 1325-1330 | `box.minipage` | widths 0.96, 0.85 of `\linewidth` |
| lists inside editorial notes | attinormativi-esempi.tex:256, 1075 | `list.kernel` | `itemize`, `enumerate` (content of the test notes) |
| TeX logos | attinormativi-esempi.tex:105, 762 | `font.icons` | `hologo` `\hologo{LuaLaTeX}` |
| inline marks | attinormativi-esempi.tex:253, 258, 437, 484, 496 | `mark.kernel` | `\textbf` `\textit` `\emph` `\texttt` `\underline` |
| form blanks and breaks in annex B | attinormativi-esempi.tex:448-469 | `sp.manual-space` | `\underline{\hspace{4cm}}` fields, `\\[1em]`, `\bigskip` |
| inline maths | attinormativi-esempi.tex:566-567 | `math.kernel` | `$b$`, `$b+1$` (content) |
| floats, tables, code, bibliography, footnotes, display maths, abstract | none in the sample; none defined by the class (grep of dtx for `\caption` `\footnote` `\bibliography` `\newtheorem` finds nothing) | none | not used |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| sample-side macros | attinormativi-esempi.tex (no `\newcommand`, `\def`, environment or counter outside comments; only :104-105 load packages) | n/a | none exist |
| `\AN@emit` manual-number wrapper | dtx:1698-1717 | yes (published class, W1; also a pure composition) | `num.counters`: `\begingroup`, `\edef` save, `\expandafter\renewcommand\csname the<ctr>\endcsname{n}`, heading command, `\setcounter` restore, `\endgroup`; the same shape in `\comma` (dtx:1785-1803) and `\allegato` (dtx:2151-2157) |
| `\comma` run-in paragraph number | dtx:1766-1805 | yes | `head.titlesec` runin `\paragraph{}` + text + `\par`, counters in `num.counters`; labels `a+c:` via `\refstepcounter{articoloecomma}` (`xref.kernel`) |
| margin-option parser `\AN@parseMarginOption` | dtx:1031-1049 | yes | class option keys `left/right/top/bottom` feeding the `page.geometry` values (dtx:1128-1146); other options forwarded to `book` |
| secondary toc files `.art` `.alg` `.dfn` | dtx:1914-1928, 2103-2123, 2185-2187 | yes | kernel toc mechanism (`\@starttoc`, `\addcontentsline`, `\l@<type>`), `toc.kernel`; no `makeindex` run is needed (dtx:805-808; the `makeindex` steps at dtx:744-748 are for the documentation's own index) |
| PDF/UA tagging blocks `\ifAN@accessible` | dtx:1186-1216, 1291-1300, 1423-1479, 1612-1622, 1769-1796, 1866-1873, 1918-1966, 2008-2022, 2107-2133 | yes | `meta.documentmetadata` (`\DocumentMetadata` + `tagpdf` `\tagstructbegin` `\tagmcbegin` `\tagpdfsetup` `\SetEnumitemValue`); off unless the option is given |
| aliases and switches | dtx:957-961, 1489, 1640-1646 | yes | `\let\maketitle\frontespizioatto`; `\newcommand` aliases of `\ref`; booleans `\newif` driven by class option `bozza` |
| `\frontespizioatto` | dtx:1418-1487 | yes | `front.titlepage-env`: `titlepage` + `\centering` + `\vspace*{2cm}` + sized, optionally printed lines (`\Large`, `\huge\bfseries`, `\LARGE\bfseries`), `minipage` 0.82\textwidth for the subject, `\vfill`; each line printed if non-empty (`\ifx..\empty`, class-native vocabulary, not copied by the emitter) |

Note: all of this sits inside a published class, so it counts as the class's own implementation, not as zip-local bespoke code. The reductions are written so the verdict also holds if the class source is read under the stricter rule.

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and rejected: `draft.todo` for the draft notes (the class uses its own `\fbox` notes, not `todonotes`); `legal.contract` for the numbered articles (a different package, `contract`/`scrjura`, whose commands the class does not use; the class's own vocabulary is recorded under `class.attinormativi`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes for the reader
- Missing asset: `attinormativi.cls` is not shipped (README.md:34 lists it; the zip has `attinormativi.dtx` and `attinormativi.ins` only); DocStrip, a TeX run, extracts it (attinormativi.ins:28-65), and TeX Live carries it with the TeX Gyre fonts (dtx:276-279).
- Possible defect, read not tested: `\AN@parseMarginOption#1=#2\relax` is called as `<key>=<value>=\relax\relax` (dtx:1031, 1048), so `#2` for `left=40mm` seems to be `40mm=` with a trailing `=`; it only concerns the margin keys, which the sample's active configuration does not use (attinormativi-esempi.tex:93 is commented out), and it does not change the verdict.
- Text addressed to an AI: none found in the zip.
