no

# 0324-sabirdvd-latex-template-for-upc-thesis: LaTeX template for UPC thesis (ociamthesis-based, with Beamer, Cover, Table and Figure demos)

- Unverified: read from the source, not compiled.
- Source: Source/0324-sabirdvd-latex-template-for-upc-thesis/ (origin: https://codeload.github.com/sabirdvd/LaTeX-template-for-UPC-thesis-/zip/refs/heads/main; licence: not established; Beamer/main.tex:6 says the Beamer part may not be used commercially)
- Kind: thesis
- Lib: v3
- Engine: pdfLaTeX-compatible (the thesis needs nothing else; the Beamer demo needs shell escape and a Python pass, see Blockers)
- Look carried by: mixed (zip-local class `ociamthesis.cls` carries the title page, front-matter environments, margins and page-number switch; the sample preamble carries fonts, `fancyhdr`, `hyperref`, `natbib`)
- Class origin: zip-local (`ociamthesis` is an Oxford OCIAM thesis class edited for UPC; https://ctan.org/pkg/ociamthesis is a 404; README.md:15 says it derives from the GitHub project OxThesis, not an official release)
- Main file: ociamthesismain.tex (other samples: Beamer/main.tex, Cover/cover.tex, Table/main.tex, Figure/*/main.tex, Figure/spider_chart/Spider_chart.tex)
- Read: main yes, zip-local classes and styles all (`ociamthesis.cls`, `cornell.cls`, `hangcaption.sty`, `ltxdoc.cfg`; the three `.mf` crest sources: heads only, they are option-gated METAFONT). Beamer/main.tex, Cover/cover.tex and Table/main.tex read in full; Figure samples: preambles only.

## Verdict
No. The thesis sample on its own is mostly a composition of lib ways (a zip-local class that is `report` plus `\setlength`, hand-laid title page and page-style environments), but the class also ships an irreducible TikZ text-fading macro (`\fadingtext`), and the zip's other templates add `ART` (the TikZ ornament cover), `EXTERNAL` (`minted` and `pythontex` loaded in the Beamer deck) and several irreducible preamble macros. Read as a whole zip, it cannot be rebuilt from published ways alone. If only the thesis sample is judged, the sole irreducible item left is the never-called `\fadingtext` (ociamthesis.cls:93-102); the rest reduces as written under "Bespoke code".

## Blockers
- `BESPOKE/class` `\fadingtext`: TikZ `tikzfadingfrompicture` mask plus `\shade` that gradient-fills glyphs; no lib way (`art.tikz` is restricted to content); defined, never called by the thesis chapters, called by the Beamer deck (ociamthesis.cls:90-102; Beamer/main.tex:486-495, 1118-1123)
- `ART/body` Cover sample: full-page TikZ ornamental title page, spiral ornaments and compound squares drawn with `let` expressions, `name path`, `intersections` (Cover/cover.tex:94-195, 198-241, 247-285); `\tikzexternalize` at Cover/cover.tex:51 also calls out to the shell
- `EXTERNAL/package` Beamer sample loads `pythontex` and `minted` unconditionally; the body calls neither, but the document does not compile without shell escape and the PythonTeX pass (Beamer/main.tex:36, 39; Beamer/main.pytxcode and Beamer/code.py ship in the zip)
- `BESPOKE/preamble` Beamer sample, expl3 line buffer `\scroll` (Beamer/main.tex:90-110), `\ApplyGradient` and the `R` column type computing a cell colour from its content (Beamer/main.tex:614-619), `\overwrite`, `\overwritee`, `\overwriteee` width-conditional boxes (Beamer/main.tex:208-254), `xcoffins` `\Vcentre` and counter surgery `\@removefromreset` (Beamer/main.tex:454-466); all defined, none called
- `BESPOKE/body` Beamer sample calls the copied `\fadingtext` inside a table (Beamer/main.tex:1118-1123)

## Class setting
- Class: `class.report` options: `12pt` (passed on through `\DeclareOption*`, ociamthesis.cls:12), `a4paper` (ociamthesis.cls:14); the sample loads the zip-local wrapper `ociamthesis` (ociamthesismain.tex:1), which is `\LoadClass[a4paper]{report}`. Other samples: `class.beamer` (Beamer/main.tex:9), `class.book` (Cover/cover.tex:14), `class.article` (Table/main.tex:1), `class.standalone` (Figure/Scatter/main.tex:1).
- Class-native vocabulary used: `\chapter`, `\appendix`, `\tableofcontents`, `\listoffigures`, `\bibname`, `\cleardoublepage`, `\markboth`/`\leftmark`/`\rightmark`; from the zip-local wrapper: `\college`, `\degree`, `\degreedate`, `\maketitle`, `dedication`, `acknowledgements`, `abstract`, `romanpages` (ociamthesismain.tex:190-194, 211-219).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ociamthesismain.tex:1; ociamthesis.cls:12-14 | `class.report` | 12pt, a4paper |
| paper size | ociamthesis.cls:14 | `page.class-options` | a4paper |
| margins | ociamthesis.cls:77-81 | `page.setlength` | topmargin 0.0in, oddsidemargin 0.33in, evensidemargin -0.08in, textheight 9.0in, textwidth 6.0in |
| page bottom | ociamthesis.cls:21 | `pg.flush` | `\raggedbottom` |
| line spacing | ociamthesismain.tex:204 | `sp.lengths` | `\baselineskip=18pt plus1pt` |
| hyphenation | ociamthesis.cls:86 | `sp.hyphenat` | `\hyphenation{op-tical net-works semi-conduc-tor}` |
| ragged text package | ociamthesismain.tex:14 | `sp.ragged` | load only |
| line numbers | ociamthesismain.tex:108, 118 | `sp.draft-lineno` | `\modulolinenumbers[4]`, `\linenumbers` never called |
| body font | ociamthesismain.tex:17 | `font.palatino` | `palatino` |
| input encoding | ociamthesismain.tex:135 | `font.fontenc-t1` | `inputenc` utf8 |
| colours | ociamthesismain.tex:44, 46, 64, 67 | `color.xcolor` | ao (0,0.5,0), darkblue (0,0,0.5), bluegray (0.4,0.6,0.8) |
| legacy colour | ociamthesismain.tex:19 | `color.color` | load only |
| language | ociamthesismain.tex:134 | `lang.babel` | english |
| CJK support | ociamthesismain.tex:127 | `lang.cjk` | `CJKutf8`, load only, no CJK environment used; the package itself runs under pdfLaTeX |
| hyperlinks | ociamthesismain.tex:32, 93-106 | `meta.hyperref` | colorlinks=true, urlcolor=black, linkcolor=red, citecolor=darkblue, linktoc=page (a later `linktoc=all` is overridden) |
| running head | ociamthesismain.tex:136, 145-148, 158-161 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, head L `\rightmark`, head R `\thepage`, `\chaptermark` -> `\markboth{#1}{#1}` |
| blank-page style | ociamthesis.cls:113, 120 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| title page | ociamthesis.cls:116-147; ociamthesismain.tex:183, 190-194, 211 | `front.titlepage-env` | centred stack: `\Huge\bfseries` title, `\vspace*{40mm}`, logo, `\Large` author, college, institution lines, `\vspace*{25mm}`, submitted text, degree in italics, date |
| title-page fields | ociamthesis.cls:33-37, 24 | `front.class-native` | `\college`, `\degree`, `\degreedate`, `\submittedtext` (string slots) |
| title-page logo | ociamthesis.cls:72 | `fig.graphicx` | `\includegraphics[width=20mm]{upclogo.pdf}` |
| title, author | ociamthesismain.tex:183 | `front.maketitle` | `\title{title}`; `\author` is commented out (185) |
| dedication page | ociamthesis.cls:178-187; dedication.tex:1-47 | `front.dedication` | own page, `\vspace*{1.5cm}`, body in `quote`, centred name and copyright lines |
| acknowledgements | ociamthesis.cls:201-209; acknowlegements.tex:1-3 | `front.dedication` | `\Large\bfseries` centred title, body in `quote` |
| abstract | ociamthesis.cls:262-269; abstract.tex:1-3 | `abs.class-native` | `\renewenvironment{abstract}`, `\Large\bfseries` centred title, body in `quote` |
| quote body | ociamthesis.cls:186, 208, 268 | `quote.kernel` | `quote` |
| contents, figure list | ociamthesismain.tex:217-218 | `toc.kernel` | `\tableofcontents`, `\listoffigures` |
| roman front pages | ociamthesis.cls:308-310; ociamthesismain.tex:216-219 | `pgnum.pagenumbering`, `num.counters`, `pg.break` | `\setcounter{page}{1}`, `\renewcommand{\thepage}{\roman{page}}`, `\cleardoublepage` |
| headings | chapter1.tex:1, chapter2.tex:1, conclusions.tex:1 | `head.kernel` | report default `\chapter`, no restyling |
| numbering depth | ociamthesismain.tex:207-208 | `num.secnumdepth` | secnumdepth 3, tocdepth 3 |
| appendix | ociamthesismain.tex:231-233; appendix1.tex:1 | `num.appendix` | `\appendix` |
| bibliography | ociamthesismain.tex:128-131, 236-239 | `bib.natbib`, `bib.bibtex-bst` | natbib `\bibpunct{(}{)}{,}{a}{}{;}`; style `abbrvnat`; `\bibliography{refs}` |
| bibliography in contents | ociamthesismain.tex:236 | `toc.kernel` | `\addcontentsline{toc}{chapter}{Bibliography}` |
| cross-reference | conclusions.tex:2 | `xref.kernel` | `\label{ch:7}` |
| caption setup | ociamthesismain.tex:109-110 | `cap.caption` | `\captionsetup[table]{skip=10pt}` |
| caption variant | ociamthesismain.tex:15; hangcaption.sty:86-109 | `cap.caption` | `\hangcaption` is never called; if used, `format=hang` with single-line check |
| grey box | ociamthesismain.tex:71-88 | `box.tcolorbox` | libs `breakable, theorems, skins`; colback=colframe=gray!20, width=\textwidth, boxsep=5pt, arc=0pt, outer arc=0pt, left/right/top/bottom=0pt; `\mybox` never called |
| highlight | ociamthesismain.tex:38, 47, 49-52 | `mark.ulem` | `soul` `\hl` with `\sethlcolor`; `\hlc` never called |
| algorithms | ociamthesismain.tex:23, 35-36, 56 | `alg.algorithm2e`, `alg.algorithmicx` | algorithm2e `linesnumbered, ruled`, `\SetKwRepeat{Do}{do}{while}`, `\DontPrintSemicolon`; algpseudocode `noend`; load only |
| maths | ociamthesismain.tex:6, 21, 28, 31 | `math.amssymb`, `math.amsmath`, `math.bm`, `math.nicefrac` | `\DeclareMathOperator*{\argmax}{argmax}` |
| list package | ociamthesismain.tex:137 | `list.enumitem` | load only |
| table notes package | ociamthesismain.tex:34 | `tbl.threeparttable` | load only |
| figure packages | ociamthesismain.tex:7-12, 20 | `fig.graphicx`, `fig.subcaption` | `graphicx`, `graphics`, `epsfig`, `subfigure` (twice); load only, no figure in the chapters |
| verbatim package | ociamthesismain.tex:9 | `code.verbatim` | `moreverb`, load only |
| filler text, comment | ociamthesismain.tex:13, 27; abstract.tex:2; chapter2.tex:3 | `draft.todo` | `\lipsum[2-2]`, `\lipsum[2-4]`; `comment` load only |
| PSTricks | ociamthesismain.tex:7 | `art.pstricks` | `pstricks` loaded, nothing drawn |
| TikZ | ociamthesismain.tex:30; ociamthesis.cls:88 | `art.tikz` | loaded, no picture in the thesis body |
| [Beamer] class, theme | Beamer/main.tex:9, 12, 73 | `class.beamer`, `slide.beamer-theme` | `\usetheme{Madrid}`, `\useoutertheme{infolines}` |
| [Beamer] colours, templates | Beamer/main.tex:26-28, 112-123, 517-523, 632-640 | `slide.beamer-template` | `\setbeamercolor` palettes with cvut_navy, headline template, navigation symbols off, caption template |
| [Beamer] overlays, notes | Beamer/main.tex:132, 721, 840 | `slide.beamer-mode` | `\setbeamercovered{dynamic}`, `\note[item]`, `\visible<2->` |
| [Beamer] fonts | Beamer/main.tex:25, 77, 481, 663, 496-498, 29 | `font.family-default`, `font.mono`, `font.palatino`, `font.lmodern`, `font.nfss`, `font.icons` | sfdefault, courier, palatino, lmodern, fourier `futs` glyph 66, `tikzsymbols` |
| [Beamer] colours, page colour, opacity | Beamer/main.tex:14-16, 481, 526, 528, 989 | `color.xcolor`, `color.pagecolor`, `tbl.colortbl`, `color.transparent` | HTML colours; `\pagecolor{gray!5}`; `\rowcolor{Gray}`; `\texttransparent{0.1}` |
| [Beamer] bibliography | Beamer/main.tex:13, 17, 24 | `bib.biblatex-biber` | `maxbibnames=99`, `\addbibresource{biblatex-examples.bib}` (file not shipped) |
| [Beamer] boxes, tables, maths | Beamer/main.tex:37-38, 46, 80, 1044-1071, 1108-1136, 1150-1152 | `box.tcolorbox`, `code.tcblisting`, `math.physics`, `tbl.threeparttable`, `tbl.tabular`, `math.amsmath`, `fig.graphicx` | tcolorbox skins and listings; `empheq`, `cancel[makeroom]`; `\resizebox` table; `equation*` |
| [Beamer] misc packages | Beamer/main.tex:31, 35, 475, 527, 661, 666 | `sp.parskip-pkg`, `mark.ulem`, `pg.pgfpages`, `box.stackengine`, `art.content-package`, `page.adjustwidth` | `parskip`, `soul`, `pgfpages`, `stackengine`, `qrcode`, `changepage`; all load only |
| [Beamer] code | Beamer/main.tex:36, 39 | `code.minted` | **EXTERNAL**, load only |
| [Cover] geometry | Cover/cover.tex:20, 245, 287 | `page.geometry` | `\newgeometry{margin=0mm}`, `\restoregeometry` |
| [Cover] table, colour packages | Cover/cover.tex:16-18 | `color.xcolor`, `tbl.tabularx`, `sp.ragged` | `svgnames,table`, `tabularx`, `ragged2e`; load only |
| [Cover] cover drawing | Cover/cover.tex:247-285 | `art.tikz` | used as template identity: **ART** |
| [Table] demo | Table/main.tex:3-8, 17-28, 33-41 | `class.article`, `page.geometry`, `tbl.tabular`, `tbl.booktabs` | margin=1in; `array` column type `L`; plain `tabular` with `\hline` and `\multicolumn`; booktabs rules `\toprule` `\cmidrule(lr)` `\bottomrule` |
| [Figure] demos | Figure/Scatter/main.tex:1, 20-23; Figure/spider_chart/Spider_chart.tex:2, 6 | `class.standalone`, `art.tikz` | `standalone` with border=10pt or varwidth; pgfplots charts: content |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `ociamthesis` | ociamthesis.cls:7-310 | Yes, except `\fadingtext` | `class.report` [a4paper, 12pt] + `page.setlength` + `pg.flush` + `sp.hyphenat` + `fig.graphicx` + the environments below |
| `\fadingtext` | ociamthesis.cls:90-102 | No | TikZ fading mask plus shade over glyphs; no lib way (BESPOKE/class) |
| `alwayssingle` | ociamthesis.cls:107-113 | Yes | In this configuration (report, one column, no `openright`) it is `\clearpage` before and `\newpage\thispagestyle{empty}` after: `pg.break` + `hf.pagestyle-kernel`; the `\if@twocolumn` and `\if@openright` branches are never taken |
| `\maketitle` redefinition | ociamthesis.cls:116-147 | Yes | `front.titlepage-env` with `\null\vfill`, `center`, `\Huge\bfseries`, `\vspace*`, `\includegraphics`, `\Large`, `\it` (`font.size-commands`, `sp.manual-space`); the institution and "Supervisors: xxx" lines are fixed text at 133 and 136 |
| `dedication`, `acknowledgements(long)`, `originality(long)`, `abstract(long)`, `abstractseparate` | ociamthesis.cls:178-300 | Yes | `alwayssingle` + `\thispagestyle{empty}` + `center` + `\vspace*{1.5cm}` + `\Large\bfseries` title + `quote`: `front.dedication`, `abs.class-native`, `quote.kernel` |
| `romanpages` | ociamthesis.cls:308-310 | Yes | `\pagenumbering{roman}` before, `\pagenumbering{arabic}` after, with `\cleardoublepage` (`pgnum.pagenumbering`, `pg.break`) |
| logo option switch | ociamthesis.cls:9-13, 44-73 | Default branch yes | Default `squarelogo` is `\includegraphics[width=20mm]{upclogo.pdf}`. Not selected by the sample (ociamthesismain.tex:2-3 are comments): `beltcrest` and `shieldcrest` call METAFONT fonts `oxcrest40`, `oxbeltcrest` (ociamthesis.cls:48, 58; oxcrest40.mf, oxbeltcrest.mf, oxbeltcrestletters.mf), a drawn trademark crest: would be ART/class and a font build step if selected; not counted |
| `\hlc` | ociamthesismain.tex:49-52 | Yes | `mark.ulem` `\sethlcolor` + `color.xcolor` `\colorlet`; never called |
| `\mybox` | ociamthesismain.tex:72-88 | Yes | `box.tcolorbox` with the options listed in the map; never called |
| `\renewcommand{\citep}` | ociamthesismain.tex:131 | Yes | natbib `\citealp` inside literal brackets (alias) |
| CVPR abbreviation macros `\onedot`, `\eg`, `\ie`, `\cf`, `\etc`, `\vs`, `\wrt`, `\dof`, `\etal` | ociamthesismain.tex:164-174 | Yes (content level) | Look-ahead only avoids a doubled full stop; an emitter writes the abbreviations as literal `\emph{e.g.}` text (`mark.kernel`); never called; `\xspace` is used but `xspace` is not loaded |
| `\bert` | ociamthesismain.tex:150-155 | Yes | `fig.graphicx` `\includegraphics[height=2ex]` per math style; never called; `Figure-Ch5/Bert.png` is not shipped |
| `hangcaption.sty` | hangcaption.sty:84-111 | Published | On CTAN (https://ctan.org/pkg/hangcaption, macros/latex209/contrib/misc); defines `\hangcaption`, `\captionwidth`; never called; equivalent `cap.caption` `format=hang` |
| `cornell.cls` | cornell.cls:1-499 | Yes in principle; not loaded | Cornell thesis class edited for UPC (278, 347), https://ctan.org/pkg/cornell is a 404, no sample loads it (Cover/cover.tex:21 mentions only `ociamthesis`). Kernel-hook redefinitions (`\@makechapterhead` 122-163, `\section` 166-169, `\@makefntext` 173-179, `thebibliography` 229-248, `\ps@cornell` 200-223, `\normalsize` 436-446, `\@floatboxreset` 491-496) map to `head.titlesec`, `fn.footmisc`, `hf.fancyhdr`, `sp.setspace`, `font.size-commands`; option switches `phd`, `final`, `cornellheadings`; the `11pt` option text is broken (`\final`, cornell.cls:73) |
| `ltxdoc.cfg` | ltxdoc.cfg:1-6 | Yes | Config read only by the `ltxdoc` class: `\PassOptionsToClass{letterpaper}{article}`, `hyperref` at end of package; no sample uses it |
| Beamer expl3 `\scroll`, `\clearbuf` | Beamer/main.tex:90-110 | No | Line buffer in `seq` variables computing printed lines (BESPOKE/preamble); never called |
| Beamer `\ApplyGradient`, column type `R` | Beamer/main.tex:614-619 | No | `\pgfmathsetmacro` percentage turned into `\cellcolor` through `collcell`; never called |
| Beamer `\overwrite`, `\overwritee`, `\overwriteee`, `\alignedbox` | Beamer/main.tex:208-254, 436-448 | No | `\settowidth` + `\ifdim` choose a box width around `\stackrel`; never called |
| Beamer `\Vcentre`, `\@removefromreset{subsection}{section}` | Beamer/main.tex:454-466 | No | `xcoffins` coffin typesetting and counter-reset surgery; never called |
| Beamer `problock`, `\uncovergraphics`, `\FourQuads*` | Beamer/main.tex:138-164, 169-418 | `problock` and `\FourQuads*` yes; `\uncovergraphics` no | `problock` is beamer templates; `\FourQuads*` is `columns` + `block`/`alertblock` + `minipage`; `\uncovergraphics` is a TikZ overlay; none called |
| Beamer `\fadingtext` (copy) | Beamer/main.tex:486-495, called 1118-1123 | No | same as the class macro (BESPOKE/body) |
| Beamer `lcg`, `\ra`, `\uv`, `\danger`, `\trad*` | Beamer/main.tex:496-498, 524-525, 543-593, 676-681 | Yes (unused) | `\ra` random number never called; `\uv` conditional quote macro never called; `\danger` is `font.nfss`; `\trad*` are `\includegraphics` aliases |
| Cover `\DrawOrnament`, `\DrawOrnamentHelper`, `\FillDrawSquare`, `\DrawTitle` | Cover/cover.tex:94-241 | No | TikZ spirals and squares (ART/body) |
| Table `L` column type | Table/main.tex:8 | Yes | `tbl.tabular` `array` `\newcolumntype` with `\raggedright\arraybackslash` |

## Content-opaque
- pgfplots/TikZ charts in the Beamer deck (Beamer/main.tex:1176-1442, 1450-1649); standalone chart files under Figure/ (Figure/Scatter/main.tex:23-, Figure/bar-plot/main.tex:29-, Figure/heatmap-stand-alone/main.tex:854-, Figure/spider_chart/Spider_chart.tex:31-, Figure/histogram-plot-overlaping/main.tex:10021-, Figure/two-histograms-side-by-side/main.tex:80033-); data files `*.csv`, `*.dat`
- Missing assets: `Figure-Ch5/Bert.png` (ociamthesismain.tex:151), `biblatex-examples.bib` (Beamer/main.tex:24), `Bert-pic-removebg-preview.png` (Beamer/main.tex:66); `upclogo.pdf` and `oxlogo.png` are shipped. Nothing in this zip addresses an AI reader.

## Lib changes
- New ways proposed: none. Considered and mapped to existing ways: `hangcaption` (a never-called caption variant, `cap.caption` `format=hang`), `comment` (load-only drafting aid, `draft.todo`), `qrcode` (load-only, `art.content-package`), `lcg` (never-called random-number package, no printed output, no way needed).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
