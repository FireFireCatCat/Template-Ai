yes

# 0411-aanda: Astronomy & Astrophysics (A&A) LaTeX class v9.4, EDP Sciences official kit

- Unverified: read from the source, not compiled.
- Source: Source/0411-aanda/ (origin: https://www.aanda.org/doc_journal/instructions/macro/aa/macro-latex-aa.zip; licence: not established)
- Kind: journal
- Lib: v5
- Engine: pdfLaTeX-compatible (aa.cls loads `etex`, `inputenc`, `fontenc` T1; aa.cls:185-192 picks the `pdftex` or `dvips` geometry driver by `\pdfoutput`; no shell escape, no Lua)
- Look carried by: class (aa.cls defines every look; the sample adds only content and six published packages)
- Class origin: publisher-official (the zip is EDP Sciences' own author kit: macros/aa.cls:2-11, readme.txt:2-9 with its documentation URL)
- Main file: none unpacked in Source/0411-aanda/. The sample `aa_example.tex` (1137 lines) sits inside the nested `aa_example.zip` (entries: aa_example.tex, aa.cls, lineno.sty, linenoaa.sty, bibtex/aa.bst, bibtex/natnotes.pdf, figure.eps). It was read by copying that one entry out in read-only mode; cited below as `M:<line>` = `aa_example.zip!aa_example.tex:<line>`. `aa.cls`, `lineno.sty`, `linenoaa.sty` and `aa.bst` inside the nested zip are byte-identical (SHA-256) to those in macros/. `aa_example.pdf` is the compiled output (could not be rendered here). Other samples: none. Cited as `C:<line>` = macros/aa.cls, `L:<line>` = macros/linenoaa.sty.
- Read: main yes (all 1137 lines), zip-local classes and styles partly (aa.cls all 2155 lines and linenoaa.sty all 145 lines; macros/lineno.sty is the published CTAN `lineno` v4.41 of 2005/11/02, header and require lines only, not read in full; macros/bibtex/aa.bst first 120 of 1695 lines)

## Verdict
`yes`, on the rubric's second ruling. The look is carried entirely by `aa.cls`, which is the publisher's official kit (W1 holds for an official kit whether or not it is on CTAN), so it is one way, `class.aa`, whose options and native commands are the parameters. The sample defines no macro, environment or counter of its own, uses only published packages (`graphicx` `txfonts` `lipsum` `subcaption` `lscape` `placeins`), and nothing needs a tool outside TeX. The class's own internals are heavily hand-written (listed under Bespoke code for the record); they belong to the published class way, not to what an emitter has to write. This is evidence about the class dimension, not about the component ways. If the kit were ever read as zip-local, the verdict would flip to `no` (BESPOKE/class: `\maketitle`, `\longtab`, `\sidecaption`, `\@sect`, `\halign` symbols).

## Blockers
none

## Class setting
- Class: `class.aa` options: none given by the sample (M:18 `\documentclass{aa}`); class defaults `a4paper,twocolumn,utf8,hideoverfull,bibauthoryear` (C:154); `aa` does `\LoadClass[fleqn]{article}` (C:35). Option list: `referee` `onecolumn` `twocolumn` `longauth` `letter` `onlletter` `online` `contents` `contentsAut` `bibyear` `bibnumber` `bibauthoryear` `a4paper` `letterpaper` `legalpaper` `wideboxfn` `wideboxlafn` `longfn` `ascii` `latin1` `latin9` `ansinews` `applemac` `utf8` `cm` `showoverfull` `hideoverfull` `openbib` (C:36-153; the sample lists some in comments at M:8-16).
- Class-native vocabulary used by the sample: `\title` `\subtitle` `\author` with `\inst{n}` `\and` `\corrauth{addr}` `\email{addr}` `\fnmsep` `\thanks{}` (M:62-67), `\institute{..\and..}` (M:70-71), `\date` (M:73), `\abstract{}{}{}{}{}` five arguments Context/Aims/Methods/Results/Conclusions (M:78-91, C:814-837, C:479-483), `\keywords{a -- b}` (M:93-96), `\maketitle` (M:98), `acknowledgements` environment (M:625-628), `appendix` environment (M:727-1136), `\sidecaption` (M:230), `\longtab[n]{longtable}` (M:329, M:437), `\tablefoot` `\tablefootmark` `\tablefoottext` `\tablebib` (M:543, 557, 565, 607), `\object{}` (M:857). Defined by the class and not used by the sample: `\idline` `\msnr` `\headnote` `\dedication` `\titlerunning` `\authorrunning` `\offprints` `\doi` `\AANum` `\journalname` `\topics` `\mail`, theorem environments (C:1625-1637), `\ion` `\element` `\vec` `\tens` `\sq` `\la` `\ga` and the other symbol macros (C:1808-1975), the journal abbreviations `\aap` ... (C:1976-2035).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | M:18, C:33-35 | `class.aa` | no options; defaults a4paper, twocolumn, utf8, hideoverfull, bibauthoryear (C:154); article base with `fleqn` |
| paper and column choice | C:50-55, C:70-79, C:154 | `page.class-options` | a4paper (fullwidth 184mm, fullheight 705pt), letterpaper, legalpaper; onecolumn or twocolumn |
| columns | C:154, C:75-78 | `cols.twocolumn-option` | twocolumn is the class default |
| columns, mid-document switches | M:755, M:793, M:865, M:870, M:980, M:1039, M:1044 | `cols.twocolumn-cmd` | bare `\onecolumn` and `\twocolumn` around wide appendix floats |
| page geometry (inside class) | C:193-198 | `page.geometry` | driver pdftex or dvips (C:188-192), a4paper, left=(21cm-184mm)/2 (C:53), textwidth=184mm, textheight=705pt, columnsep=4mm, headheight=12pt, headsep=12pt, footskip=20pt, twoside unless referee, marginpar=0in; set by the class, the emitter writes nothing |
| running heads and folios | C:697-741, C:986, C:532 | `hf.class-native` | page styles `firstpage` (footer only) and `otherpage` (head: author-title text, or `A&A proofs: manuscript no. \jobname`; foot: article number, page); rules 0; built on `fancyhdr` (C:203) |
| header/footer package (inside class) | C:203, C:698-741 | `hf.fancyhdr` | `\fancypagestyle{firstpage}`, `\fancypagestyle{otherpage}`, `\fancyhf{}`, `\fancyhead[CO]`, `\fancyhead[CE]`, `\fancyfoot[RO]`, `\fancyfoot[LE]` |
| font sizes | C:489-515 | `font.size-commands` | `\normalsize` 10/11, `\small` 9/10, `\large` 11/13, `\Large` 14/16, `\LARGE` 17/20 via `\@setfontsize`; role fonts C:516-571 (title `\LARGE\sffamily\bfseries\boldmath` C:543) |
| encodings (inside class) | C:156-160, C:108-110 | `font.fontenc-t1` | `fontenc` T1, `inputenc` utf8 by default, `textcomp` with option `cm` |
| text and maths face | M:21 | `font.mathptmx` | `\usepackage{txfonts}` |
| math alphabet | C:2036 | `font.nfss` | `\DeclareMathAlphabet{\mathsfsl}{OT1}{txss}{m}{sl}` (needs the `txfonts` family, loaded by the sample) |
| language (inside class) | C:234, C:461 | `lang.babel` | `\RequirePackage[english]{babel}`, `\figurename` set to `Fig.` |
| title block | M:42-44, M:62-73, M:98, C:985-1233 | `front.class-native` | `\title`, `\subtitle`, `\author`+`\inst`+`\and`, `\institute`, `\date`, `\maketitle` build a centred title, numbered institutes (C:915-954) and a boxed head line (C:1026-1040) |
| author note, corresponding author | M:62-63, C:812, C:598-616 | `front.thanks` | `\thanks{}` and `\corrauth{}` become footnotes with symbol marks (`\@fnsymbol`) |
| abstract | M:78-91, C:814-837, C:1145-1169 | `abs.class-native` | `\abstract` with 5 arguments; headings Context. Aims. Methods. Results. Conclusions. (C:479-483); name font `\small\sffamily\bfseries\MakeUppercase` (C:549); 300-word warning (C:303-304) |
| keywords | M:93-96, C:861-869, C:1170-1175 | `abs.keywords` | `\keywords{a -- b}`, label `Key words.`, max 6 (C:305) |
| acknowledgements | M:625-628, C:1351-1372 | `class.aa` | `acknowledgements` environment, `\tiny` run-in italic name, spacing 0.81 |
| headings | M:102, M:105, M:200, M:290, M:619, C:1299-1343 | `head.class-native` | section `\large\sffamily\bfseries\boldmath`, skips -16dd / 6dd; subsection `\normalsize\sffamily\itshape`; subsubsection and paragraph `\normalsize\sffamily`; number then `.` then 3.33pt (C:1243-1245, C:410); `\part` and `\subparagraph` raise errors |
| appendix | M:727, M:1136, C:237-296 | `num.appendix` | class `appendix` environment: section numbers A, B ..., equations A.1, float numbers A.1 (C:249-257) |
| lists | M:297-303, C:1441-1469, C:2112-2136 | `list.kernel` | `itemize`; class sets `\leftmargini=\parindent`, `\labelitemi` `\normalfont\bfseries --`, `\labelsep` .5em |
| footnotes | M:350, M:459, M:896, M:1072, C:1373-1375 | `fn.kernel` | `\footnote` inside longtable cells; `\@makefntext` set by the class |
| inline and display maths | M:114-164, C:205-207 | `math.amsmath` | class loads `amsmath` with `tbtags,fleqn`, `\mathindent=0` |
| equations without amsmath commands | M:114, M:125-132, M:134-141, M:149-164 | `math.kernel` | `equation`, `eqnarray`, `array`, `displaymath` |
| equation numbering and alignment | C:35, C:205 | `math.eqnumber` | `fleqn` (flush-left display equations) |
| math symbols (inside class) | C:206 | `math.amssymb` | `\RequirePackage{amssymb}` |
| theorem-like statements (defined, unused by sample) | C:1522-1637 | `thm.class-native` | class `\newtheorem` replacement; `theorem` numbered in section; `corollary` `definition` `lemma` `proposition` `remark` ... share its counter; `proof` unnumbered; spacing lengths C:321-328 |
| figures | M:171-183, M:209-214, M:219-224 | `fig.graphicx` | `figure`, `figure*`, `\includegraphics[width=\hsize]`, `[angle=-90,width=2cm]`, `[bb=..,clip]` |
| continued figure numbering | M:177, M:274, M:280 | `fig.subcaption` | `\usepackage{subcaption}` for `\ContinuedFloat` |
| rotated floats | M:985-1035, C:297 | `fig.rotating` | class loads `rotating[figuresright]`; `sidewaystable*` |
| side caption | M:229-234, C:1656-1705 | `fig.class-native` | `\sidecaption` before the graphic, caption to its right (min room 5cm C:394-395, gap 12pt C:392-393) |
| float placement | C:1638-1655, M:209 | `fig.placement` | `\fps@figure`=`\fps@table`=tbp, topfraction .9, bottomfraction .5, textfraction .05, floatpagefraction .95, topnumber 4, bottomnumber 2, totalnumber 6; sample passes `[ht!]` |
| float barriers | M:27, M:792, M:864, M:979, M:1038, M:1132 | `pg.afterpage` | `\usepackage{placeins}`, `\FloatBarrier` |
| captions | M:212, M:309, C:1706-1721 | `cap.kernel` | `\caption`; class `\@makecaption`: label bold, `Fig.` and `.~`, `\small`, 5pt above figure captions (C:398), 10pt below table captions (C:400) |
| tables | M:308-320, M:528-544, M:579-612 | `tbl.tabular` | `tabular` with `\hline\hline` head rule, `\multicolumn`, `\noalign{\smallskip}`, `table` and `table*` |
| long tables | M:330-430, M:874-976, M:1049-1128, C:212-231 | `tbl.longtable` | `longtable` with `\endfirsthead` `\endhead` `\endfoot`; class patches its caption (C:213-231) and end spacing (C:2037) |
| long table moved after appendices | M:329, M:437, C:1385-1422 | `class.aa` | `\longtab[n]{...}` (class command that defers a long table to the document end) |
| table notes and references | M:543, M:557, M:565, M:607, C:1722-1753 | `class.aa` | `\tablefoot` `\tablefootmark` `\tablefoottext` `\tablebib`; names `Notes.` and `References.` bold `\small` |
| landscape pages | M:25, M:438, M:1045, C:2038-2042 | `pg.landscape` | `\usepackage{lscape}`, `landscape` environment |
| page breaks | M:287, M:614, M:1133 | `pg.break` | `\clearpage`, `\newpage` |
| flush bottom | C:1347 | `pg.flush` | `\flushbottom` |
| spacing after periods | C:1344 | `sp.frenchspacing` | `\frenchspacing` |
| widow and club control | C:1345-1346, C:1781, C:1783 | `sp.penalties` | `\clubpenalty=10000`, `\widowpenalty=10000`; 4000 inside the bibliography |
| sloppy setting | C:1349 | `sp.hyphenat` | `\sloppy` when twocolumn |
| list and label lengths | C:2112-2121 | `sp.lengths` | `\leftmargini`..`\leftmarginvi`, `\labelsep` .5em, `\labelwidth` |
| double spacing for referee copy | C:199-202, C:1363 | `sp.setspace` | `\doublespacing` under `referee`; `spacing` environment 0.81 in acknowledgements |
| line numbers | C:1755-1757, L:34-40 | `sp.draft-lineno` | `linenoaa` options `modulo,mathlines,switch,running,columnwise,pagewise` over `lineno`; every 10th line, `\normalfont\scriptsize\sffamily`; `\linenumbers` appended to `\maketitle`; `\runningpagewiselinenumbers` |
| dummy text | M:22, M:103, M:787 | `draft.todo` | `\usepackage{lipsum}`, `\lipsum[1]`, `\lipsum[1-2]` (filler content) |
| cross references | M:109, M:298 | `xref.kernel` | `\label` `\ref` |
| citations | M:107, M:112, M:607-610, C:142-146 | `bib.natbib` | `natbib[nonamebreak]`, `\bibpunct{(}{)}{;}{a}{}{,}`, `\citet`, `\citeyear`; `bibnumber` option uses `[sort&compress]` and square brackets (C:132-136) |
| bibliography | M:644-676, C:1759-1794 | `bib.thebibliography` | hand-written `thebibliography{}` with `\bibitem[Baker(1966)]{baker}` labels; class redefines the environment (`\tiny`, `\bibindent`=1em, `\section*{\refname}`) |
| bibliography style (kit file, optional) | M:639-640, macros/bibtex/aa.bst:1-3 | `bib.bibtex-bst` | `\bibliographystyle{aa}` and `\bibliography{..}`; `aa.bst` is an ApJ-derived author-year style for `natbib` |
| url and enumerate packages (inside class) | C:211 | `meta.url` | `\RequirePackage{url, enumerate}` (the `enumerate` package is `list.enumerate-pkg`, not used by the sample) |
| conditional note package | C:161-167 | `note.marginnote` | loaded only under `referee`, `\marginparwidth` 50mm |

## Bespoke code
none in the sample (it defines no `\newcommand`, `\def`, environment or counter) and none in the preamble. For the record, and for the class profile in the lib, the class internals that are not expressible by lib ways are listed here; they are not counted as bespoke because the class is the publisher's official kit, so they sit inside `class.aa` (W1):

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\maketitle` / `\aa@maketitle`, author and institute counting by `\and` recursion, automatic running head | C:750-784, C:915-973, C:985-1233 | n/a (published class internals) | none needed: the emitter calls `\maketitle` |
| `\longtab` / `\aalongfloat` (`\AtEndDocument` float relocation with counter save and restore) | C:1385-1422 | n/a (published class internals) | none needed: the emitter calls `\longtab` |
| `appendix` redefinition with `longauth` author strip and `aa@strip` (`\vsplit`) | C:237-296, C:576-595 | n/a (published class internals) | none needed |
| `\sidecaption` (box measurement) | C:1656-1705 | n/a (published class internals) | none needed |
| `\@sect`, `\@makecaption`, `\@floatboxreset`, `\@fnsymbol`, `\newtheorem` redefinitions | C:1246-1279, C:1706-1721, C:1795-1807, C:598-616, C:1522-1637 | n/a (published class internals; `titlesec` and `caption` would only approximate them) | none needed: inside `class.aa` |
| symbol macros with `\halign`, `\mathchoice`, `\ooalign` (`\la` `\ga` `\grole` `\diameter` `\sq`) | C:1831-1846, C:1862-1975 | n/a (published class internals) | none needed; not used by the sample |
| `linenoaa.sty`: copies of amsmath environments patched with `\linenomath` | L:42-144 | n/a (part of the official kit) | none needed: `sp.draft-lineno` plus the class |
| `\AALogo` built from fonts, `\rule`, `\rlap`, `\raisebox` | C:435-453 | n/a | only drawn when `\idline` is set (C:1024, C:1042-1047); the sample does not set it, so it is not exercised |

## Content-opaque
- `figure.eps` is included many times (M:173-181, M:211, M:221, M:231, M:242, M:254-256, M:269-281, M:777). It is an EPS, which pdfLaTeX converts only through Ghostscript (the type of `fig.epstopdf`, EXTERNAL when selected); it is figure artwork, hence content, and an emitter would ship PDF or PNG instead. Not counted as a blocker. The file is only inside `aa_example.zip`.
- Equations, table data, lorem ipsum, author and affiliation text, bibliography entries.

## Lib changes
- New ways proposed: none. The class is written `class.aa` plainly (the lib's class section is filled from the solution files).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Sample quirks that stay inside kernel constructs: a `\section` placed inside `table*` and `sidewaystable*` to avoid a blank page (M:803, M:986); an emitter writes them as wrappers.
- `\email` is ignored in PDF output (readme.txt:25-28; C:970, C:1117 blank it inside `\author`).
- No text addressed to an AI was found in the zip.
