no

# 0088-tinoryj-uestc-thesis-latex-template: UESTC thesis template (thesis-uestc class, with a beamer defence-slides style)

- Unverified: read from the source, not compiled.
- Source: Source/0088-tinoryj-uestc-thesis-latex-template/ (origin: https://codeload.github.com/tinoryj/UESTC-Thesis-Latex-Template/zip/refs/heads/main; licence: MIT per the manifest and LICENSE:1; thesis-uestc.bst:5-17 carries an LPPL notice for the .cls and .bst)
- Kind: thesis
- Lib: v2
- Engine: needs XeLaTeX (thesis-uestc.cls:9 `\RequireXeTeX`; `fontspec` :67, `xeCJK` :51, `unicode-math` :49; latexmkrc:3-4 runs `xelatex --shell-escape`)
- Look carried by: zip-local (the whole look is one hand-written 1773-line class, thesis-uestc.cls, on `book`; main.tex only fills metadata and content)
- Class origin: zip-local (thesis-uestc is a student's repository class, not an official UESTC release; ctan.org/pkg/thesis-uestc returned 404)
- Main file: main.tex (other samples: slides/masterThesisSlides.tex with slides/UESTC.sty; pic/figure.tex and pic/logo.tex are standalone image-build sources, not samples)
- Read: main yes, zip-local classes and styles all (thesis-uestc.cls, slides/UESTC.sty, slides/masterThesisSlides.tex read in full; thesis-uestc.bst outlined (lines 1-140 plus grep of the entry writers), its 653 lines of BibTeX code were not read line by line; pic/figure.tex read for lines 1-30 only, it is a 674-line TikZ path file)

## Verdict
No. The look lives in a zip-local class that is mostly composable from published packages (`geometry`, `fancyhdr`, `titlesec`, `tocloft`, `caption`, `subcaption`, `listings`, `algorithm2e`, `glossaries`, `footmisc`, `amsthm`), but it also holds irreducible kernel-level code: a leaders/`\prevdepth` underline box, patches of `\@addtocurcol`, `\@getpen`, `\@chapter` and `\@makefntext`, a PDF-literal fake-bold hack for CJK, and a per-page `\AddEverypageHook` counter that drives roman folios and toc widths. It also needs shell escape for platform detection (`ifplatform`) and `glossaries[automake]`. The README itself tells users to hand-edit the class (comment/uncomment lines 1008-1011, 1126-1129, 1215-1216), so the options are not declarative.

## Blockers
- `BESPOKE/class` `\UnderlineCentered`: adjustbox minipage measured with `gstore totalheight`, `\xdef` of `\prevdepth`, `\leaders\hrule` and `\xleaders\vbox` rule lines per baseline; used for the class/secrecy/UDC lines of the title page (thesis-uestc.cls:1102-1115, used at :1123-1124 and :1243-1244)
- `BESPOKE/class` kernel float-spacing patch: `\patchcmd{\@addtocurcol}` twice and `\patchcmd{\@getpen}` rewrite output-routine penalties and skips (thesis-uestc.cls:414-439)
- `BESPOKE/class` footnote internals: whole `\@makefntext` re-written with `\llap`/`\hb@xt@`/`\parshape` and `\footnoterule` rebuilt with `\vfill` (thesis-uestc.cls:515-549)
- `BESPOKE/class` CJK fake bold: `\special{pdf:literal direct 2 Tr ...}` around `\CJKsymbol`, `\dimen255` kern save/restore, then bound to `\emph` and the title page (thesis-uestc.cls:73-105, 1127, 1132)
- `BESPOKE/class` front-matter state machine: `\pretocmd`/`\apptocmd` on `\@chapter` with an `\@BODY` flag that switches headers, page numbering and `page=1` at the first chapter (thesis-uestc.cls:1471-1497)
- `BESPOKE/class` page counters by hook: `pseudopage` stepped from `\AddEverypageHook`, `\blankpage` that undoes a page, `\checkoddpage` parity logic in the abstract, toc and lists, and per-page `\addtocontents` writes of `\cftsetpnumwidth{\widthof{\thepage}-1pt}` (thesis-uestc.cls:551-561, 563-608, 616-626, 1430-1448)
- `BESPOKE/class` re-written `proof` environment using `\pushQED`, `\trivlist`, `\@addpunct`, `\@endpefalse` (thesis-uestc.cls:1740-1750); minor, W2 fails (code, not parameters)
- `EXTERNAL/package` `ifplatform` is loaded unconditionally (thesis-uestc.cls:55) and chooses the font files by `\ifwindows`/`\ifmacosx` (:107-141); the package relies on shell escape (CTAN page read); `glossaries[automake]` (:47) also runs `makeglossaries` through shell escape, and latexmkrc:3-4, 8-18 adds a custom makeglossaries dependency
- Not a blocker, noted: the cover emblem is a TikZ drawing (pic/figure.tex:11-674) but the class includes only the compiled `logo.pdf` image (thesis-uestc.cls:1045-1046), so I treat it as a shipped image asset, not `ART`

## Class setting
- Class: `class.book` (thesis-uestc.cls:3, `\LoadClass[12pt, openany, twoside]{book}`) under the zip-local wrapper `thesis-uestc` (not a published class, so no `class.thesis-uestc` way); slides use `class.beamer` (slides/masterThesisSlides.tex:1)
- Class options of the wrapper (zip-local): `bachelor` `master` `promaster` `doctor` `engdoctor` (select degree names and header strings, thesis-uestc.cls:758-827, default `master` :827) and `english` (:747-752)
- Class-native vocabulary used by main.tex: `\title{zh}{en}`, `\author{zh}{en}`, `\setdate[submit|oral|confer]`, `\advisor`, `\school`, `\major`, `\studentnumber`, `\ProfessionalDegreeArea`, `\ClassificationNumber`, `\ClassifiedClass`, `\UDCNumber`, `\Chairman` (main.tex:3-17); `\makecover`, `\originalitydeclaration`, `chineseabstract`/`englishabstract` with `\chinesekeyword`/`\englishkeyword`, `\thesistableofcontents`, `\thesisfigurelist`, `\thesistablelist`, `\thesisglossarylist`, `\thesissymbollist`, `\citing`, `\algref`, `\thesisacknowledgement`, `\thesisbibliography[large]`, `\thesisappendix`, `thesistheaccomplish`, `\thesistranslationoriginal`/`\thesistranslationchinese` (main.tex:31-229)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | thesis-uestc.cls:3 | `class.book` | 12pt, openany, twoside |
| page geometry | thesis-uestc.cls:377-381 | `page.geometry` | a4paper, inner=outer=top=bottom=3cm, bindingoffset=0cm; `\headheight`=15pt via `page.setlength` |
| page class options | thesis-uestc.cls:3, 377 | `page.class-options` | 12pt, twoside |
| headers and footers | thesis-uestc.cls:342, 383-384, 1418-1428 | `hf.fancyhdr` | headrulewidth 0.75pt; `\fancyhead[CE/CO]` degree string and `\leftmark`; `\fancyfoot[CE,CO]` page; 10.5bp/9bp sizes |
| per-page head/foot switching | thesis-uestc.cls:570-574, 843-847, 1438-1447 | `hf.fancyhdr`, `pgnum.pagenumbering` | `\fancyhf{}` then new head/foot per front-matter part; Roman folios from `pseudopage` (bespoke, see below) |
| empty cover pages | thesis-uestc.cls:1031, 1120, 1202 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| page numbering | thesis-uestc.cls:564, 1476, 1098 | `pgnum.pagenumbering` | `Roman`, `arabic`, `\setcounter{page}{0}` |
| line spacing | thesis-uestc.cls:322, 385, 1372, 1636 | `sp.linespread`, `sp.setspace`, `sp.lengths` | `\linespread{1.391}`, `\baselineskip` 20pt, `spacing` env 2.14 and 1.667 |
| paragraph shape | thesis-uestc.cls:338, 386 | `sp.indentfirst`, `sp.lengths` | `\parindent`=24pt |
| microtype, flush | thesis-uestc.cls:45, 369 | `sp.microtype`, `pg.flush` | defaults; `\raggedbottom` |
| penalties, hyphenation | thesis-uestc.cls:1512, 1635; main.tex:20-23 (commented) | `sp.penalties` | `\interlinepenalty` 0 / 10000 |
| rules and manual space | thesis-uestc.cls:515, 1134-1138, 1386, 1197 | `sp.rule`, `sp.manual-space` | `\rule` widths 2.0in/6.05in/4.1cm, `\vspace` |
| latin text and math font | thesis-uestc.cls:67, 128-139 | `font.fontspec` | `\setmainfont[Path=fonts/, BoldFont=timesbd.ttf, ItalicFont=timesi.ttf, BoldItalicFont=timesbi.ttf]{times.ttf}`; `\newfontfamily\codefont`, `\heiti@letter`, `\titlefonten`; Windows/macOS branches use system fonts (:107-126) |
| math font | thesis-uestc.cls:49, 114, 125, 138 | `font.unicode-math` | `math-style=ISO, bold-style=ISO, warnings-off={...}`; `\setmathfont{times.ttf}` |
| CJK fonts | thesis-uestc.cls:51, 103, 108, 118, 128-131 | `lang.cjk` | `xeCJK` `\setCJKmainfont[AutoFakeBold=true, Path=fonts/]{fzsong.ttf}`, `\newCJKfontfamily\heiti{fzhei.ttf}`, `\titlefontzh{STZhongsong.ttf}` |
| Chinese numerals | thesis-uestc.cls:323, 392 | `lang.cjk` | `zhnumber` (CTAN, beside xeCJK) in `\thechapter` = 第`\zhnumber`章 |
| size commands | thesis-uestc.cls:29, 507-509, many `\fontsize{15bp}{15bp}\selectfont` | `font.size-commands` | `\small`=10.5/12.6bp, `\footnotesize`=9/10.8bp redefined |
| math alphabets | thesis-uestc.cls:321, 1762-1768 | `font.nfss`, `math.bm` | `\DeclareMathAlphabet{\mathbb}{U}{msb}{m}{n}`, `\mathcal` OMS/cmsy; `\bm`=`\mathbfit` alias |
| symbol glyphs | thesis-uestc.cls:324, 511-513 | `font.icons` | `pifont` `\ding{172}`..: footnote marks (:513 has a brace slip) |
| calligraphic text (slides) | slides/masterThesisSlides.tex:7, 399 | `font.display` | `calligra` `\calligra` |
| colours | thesis-uestc.cls:16, 57-66, 208-210, 247-252; slides/UESTC.sty:127-128 | `color.xcolor` | `[usenames,dvipsnames,svgnames,table]`, named RGB values |
| front: cover page 1 | thesis-uestc.cls:1030-1100 | `front.titlepage-env`, `tbl.tabular`, `tbl.multirow`, `fig.graphicx` | hand-laid tabulars with `\cline`, 22bp/42bp sizes, `logo.pdf` 180bp square; variants by degree |
| front: title page 2 and English page | thesis-uestc.cls:1118-1237, 1239-1361 | `front.titlepage-env`, `tbl.tabular`, `box.minipage` | fixed-width `p{}` cells (1.60in, 4.22in...), minipage 1.52cm, plus `\UnderlineCentered` (blocker) |
| declaration page | thesis-uestc.cls:1369-1404 | `front.dedication`, `sp.setspace`, `sp.rule` | `spacing` 2.14, `\rule[-3pt]{4.1cm}{0.5pt}`, 14.04pt text |
| scanned PDF pages | thesis-uestc.cls:1363-1367, 1406-1414 | `pg.include-pdf` | `\includepdf[pages=-]` |
| abstract (zh, en) | thesis-uestc.cls:563-614 | `head.kernel`, `hf.fancyhdr` (zip-local environments, see blockers) | `\chapter*` 15bp; head 10.5bp; keywords via `\@hangfrom\makebox[48pt]`/`[2.1cm]` |
| keywords | thesis-uestc.cls:584-588, 610-614 | `abs.keywords` | `\textbf{关键词：}` hung label |
| contents, lists | thesis-uestc.cls:362, 373-375, 616-646, 841-894; main.tex:45-47 | `toc.kernel`, `toc.tocloft` | `tocloft[titles]`: `\cftdotsep` 0.4, `\cftchapleader`, `\cftsetindents{section}{21pt}{22pt}`..., `\cfttoctitlefont` 15bp; `\tocloftpagestyle{fancy}` |
| toc extras | thesis-uestc.cls:355, 485-486, 855 | `toc.etoc`, `num.secnumdepth` | `tocbibind[nottoc]`; secnumdepth 3, tocdepth 2 |
| headings | thesis-uestc.cls:343, 387-390, 488-501 | `head.titlesec` | `\titleformat{\chapter}[block]` centred 15bp; section/subsection 14bp, subsubsection 12bp, label gaps 7.5/7/6pt; `\titlespacing` 0/18pt, 18/6pt, 12/6pt |
| heading numbers | thesis-uestc.cls:392-397, 1525-1536 | `num.counters`, `num.appendix` | `\thechapter`, `\thesection`=ch.sec, equation/table/figure `ch-n`; `appendix` package (:344); `\appendix` + 附录A/`\Alph` |
| lists | thesis-uestc.cls:347, 50, 1753-1754 | `list.enumitem`, `list.enumerate-pkg`, `list.kernel` | `\setlist{noitemsep}`, `\setlist{nolistsep}`; `enumerate` package loaded |
| footnotes | thesis-uestc.cls:503-515 | `fn.footmisc`, `num.counters` | `footmisc[hang, perpage]`, `\footnotemargin`=13.5pt, `\thefootnote` circled digits; custom `\@makefntext` is the blocker |
| equations | thesis-uestc.cls:41-42, 1756-1771; main.tex:59-63 | `math.amsmath`, `math.amssymb`, `math.kernel` | `amsmath[tbtags]`, display skips 6pt, `\allowdisplaybreaks[4]`; `$$..$$` at main.tex:61 |
| theorems | thesis-uestc.cls:43, 1706-1735 | `thm.amsthm` | `\newtheoremstyle{dotless}{0pt}{0pt}{\normalfont}{24pt}{\strong}{}{ }{}`; theorem/axiom/corollary/lemma/definition/example/proposition, numbered `[chapter]` and by `[theorem]`; `\qedsymbol` $\blacksquare$ |
| theorems (slides) | slides/UESTC.sty:115-125 | `thm.kernel`, `slide.beamer-template` | `\newtheorem{lem}{引理}`; `\setbeamertemplate{lem}[numbered]` |
| name strings | thesis-uestc.cls:831-839, 1598-1600, 1617-1619, 1630, 1737 | `NEW:lang.kernel-names` | `\contentsname`, `\bibname`, `\figurename`, `\tablename`, `\lstlistingname`, `\listfigurename`, `\listtablename`, `\appendixname`, `\proofname` |
| figures | main.tex:67-116; thesis-uestc.cls:17, 360, 402-410, 441-443 | `fig.graphicx`, `fig.placement`, `cap.kernel` | `\graphicspath{{./pic/}}`, `\floatsep`/`\textfloatsep`/`\intextsep`=6bp, `\@floatboxreset{\centering}` hook |
| float package | thesis-uestc.cls:340, main.tex:188 | `fig.float` | `[H]` on the algorithm float |
| subfigures | thesis-uestc.cls:363-366; main.tex:87-116 | `fig.subcaption` | `subcaption[labelformat=simple]`; `\captionsetup[subfigure]{font=small, belowskip=6pt, width=40pt, justification=centering}`; `\thesubfigure`=(\alph) |
| image box helper | thesis-uestc.cls:39, 1105-1114 | `fig.adjustbox` | used inside `\UnderlineCentered` (blocker) |
| float captions | thesis-uestc.cls:18, 407-410 | `cap.caption` | `font={doublespacing,small}, labelsep=space, skip=6bp`; width=`\textwidth - 84pt`, figureposition=bottom, tableposition=top; per-float above/belowskip |
| tables | thesis-uestc.cls:20-35, 463-473; main.tex:118-132 | `tbl.tabular`, `tbl.booktabs`, `tbl.multirow` | `array` `\newcolumntype{L,C,R}` on `m{}`; rule widths 1.5/0.75pt; `\arraystretch` 1.4, 10.5bp; `makecell`, `multirow` |
| long tables | main.tex:135-179; thesis-uestc.cls:471-473, 925-960 | `tbl.longtable` | `\LTleft`/`\LTright`=0pt, `\LTcapwidth`=`\textwidth`, `\endfirsthead`..`\endlastfoot` |
| listings | thesis-uestc.cls:68, 145-313, 399, 410 | `code.listings` | `\lstdefinestyle` c++, shell, json, python, solidity (frame=trbl, frameround=tttt, breaklines, numbers=left, `rulesepcolor`, `backgroundcolor`); `\thelstlisting` ch-n |
| verbatim loaded | thesis-uestc.cls:341 | `code.verbatim` | `fancyvrb` loaded, no use in the sample |
| algorithms | thesis-uestc.cls:349-350, 896-904; main.tex:188-204 | `alg.algorithm2e`, `xref.hyperref` | `algorithm2e[algochapter, boxruled, linesnumbered]`, `\SetAlgorithmName{算法}{算法}{算法列表}`, `\SetAlgoCaptionSeparator{\null}`, `\algref` via `\hyperref` |
| algorithmic loaded | thesis-uestc.cls:53 | `alg.algorithmicx` | `algpseudocode` loaded, no use in the sample |
| acronyms and symbols | thesis-uestc.cls:47, 907-1028; main.tex:25-27, 48-50 | `idx.glossaries` | `glossaries[sort=use,nopostdot,style=long,automake,acronym]`, `\newacronymstyle`, three `\newglossarystyle` over `longtable`, `\printglossary[type, style, title, nonumberlist, nogroupskip]` |
| citations | thesis-uestc.cls:69, 345, 1752; main.tex:55-57 | `bib.cite-pkg`, `mark.kernel` | `cite[noadjust]`; `\citing`=`\textsuperscript{\cite{}}` |
| main bibliography | thesis-uestc.cls:1633-1670; main.tex:210 | `bib.bibtex-bst`, `bib.thebibliography` | `\bibliographystyle{thesis-uestc}` (zip-local .bst); `\bstlabelmark` lo/loo; `\@biblabel` `[#1]\hfill`; `spacing` 1.667 |
| achievements list | thesis-uestc.cls:354, 1672-1704; main.tex:216-221 | `bib.multi`, `bib.thebibliography` | `multibib[resetlabels]` `\newcites{accomplish}`; hand-written `thebibliography` with `\bibitem` |
| links, urls, bookmarks | thesis-uestc.cls:326-336, 368; 566-568 | `meta.hyperref`, `meta.url`, `meta.bookmark`, `xref.kernel` | `hyperref[hyperfootnotes=false, bookmarksnumbered, bookmarksdepth=4]`, `colorlinks` all black; `xurl[hyphens]`, `\urlstyle{rm}`; `\pdfbookmark` |
| emphasis, underline | thesis-uestc.cls:105, 346 | `mark.kernel`, `mark.ulem` | `\emph` re-defined (title font); `ulem[normalem]` |
| page breaks | thesis-uestc.cls:556-560, 1473 | `pg.break` | `\newpage`, `\cleardoublepage` |
| slides: class and themes | slides/masterThesisSlides.tex:1-2; slides/UESTC.sty:9, 111, 14 | `class.beamer`, `slide.beamer-theme` | `\useoutertheme[footline=authorinstitutetitle,subsection=true]{smoothbars}`, `\useinnertheme{circles}`, `\usefonttheme[onlymath]{serif}`, `\setbeamersize{text margin left=6mm,...}` |
| slides: templates | slides/UESTC.sty:19-21, 23-60, 69-97, 125-171 | `slide.beamer-template` | title page, headline, footline templates; `\setbeamercolor` (uestc #115EA2, greywhite), `\setbeamerfont`, rounded shadow blocks |
| slides: modes | slides/UESTC.sty:1, 183; slides/masterThesisSlides.tex:53, 263 | `slide.beamer-mode` | `\mode<presentation>`, `[<+-\| alert@+>]`, `\pause`, `allowframebreaks` |
| slides: fonts, CJK, code | slides/masterThesisSlides.tex:3, 26-35; slides/UESTC.sty:15-17 | `lang.cjk`, `font.fontspec`, `code.listings` | `ctex`; `\newfontfamily\chalkd{Times New Roman}`; `\lstset{frame=shadowbox, numbers=left}` |
| slides: pstricks picture | slides/masterThesisSlides.tex:177-198 | `art.pstricks` | inside a frame as demo content (Content-opaque) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\UnderlineCentered` | thesis-uestc.cls:1102-1115 | No | box-and-glue with leaders and `\prevdepth`; for a one-line value only, `\underline`/`\makebox[w]` would do, but the macro handles wrapped text |
| `\@addtocurcol` and `\@getpen` patches | thesis-uestc.cls:414-439 | No | output-routine internals; no lib way sets float-to-text spacing this way (`fig.placement` only sets lengths) |
| `\@makefntext`, `\footnoterule` | thesis-uestc.cls:515-549 | No | kernel/footmisc internals re-written; `fn.footmisc` options (`hang`, `\footnotemargin`) cover only part |
| CJK fake bold (`\CJKfakebold`) | thesis-uestc.cls:73-105 | No | `\special` PDF literals and `\dimen255` kern juggling; `AutoFakeBold` (xeCJK) is the published substitute but it is not the same look |
| `\@chapter` pre/app patch, `\@BODY`, `\thesiscontent` | thesis-uestc.cls:1471-1497 | No | state flag steering headers and page numbers at the first chapter; an emitter could write the header switch by hand at the first chapter, but this is zip-local logic |
| `pseudopage` counter, `\AddEverypageHook`, `\blankpage`, `\checkoddpage` flow | thesis-uestc.cls:551-561, 563-608, 1430-1437 | No | hand-rolled per-page counter and parity conditionals that decide what the folio prints and where blank pages go |
| per-page toc/lof/lot width hooks | thesis-uestc.cls:616-626 | No | `\addtocontents{toc}{\protect\cftsetpnumwidth{\widthof{\thepage}-1pt}}` on every page; no declarative `tocloft` equivalent |
| platform-conditional font block | thesis-uestc.cls:55, 107-141 | No (EXTERNAL) | `\ifwindows`/`\ifmacosx` from `ifplatform` (shell escape); the Linux branch (:128-139) alone reduces to `font.fontspec` + `lang.cjk` with the shipped fonts |
| `proof` environment | thesis-uestc.cls:1740-1750 | No (minor) | amsthm's own building blocks with kernel internals; `thm.amsthm` styles do not reach `proof` |
| `\AtBeginEnvironment` float/tabular hooks, `\ifuestcintable` | thesis-uestc.cls:30-36, 441-473 | Yes | emit `\centering`, 10.5bp font, `\arraystretch` 1.4 inside each table/longtable wrapper (`font.size-commands`, `sp.lengths`, `tbl.tabular`); the emitter knows the float context |
| abstract, toc, lof, lot, glossary page wrappers | thesis-uestc.cls:563-614, 843-894, 996-1028, 1430-1448 | Only if the page-counter hooks above are | `\fancyhf{}`/`\fancyhead[C]`/`\fancyfoot` lines plus `\pdfbookmark`; depend on `pseudopage` |
| `\makecover`, `\thetitlepage`, `\thetitlepageforprodegree` | thesis-uestc.cls:1030-1361 | Yes, except `\UnderlineCentered` | static tabular pages for one degree (`front.titlepage-env`, `tbl.tabular`, `tbl.multirow`, `box.minipage`, `fig.graphicx`) |
| `\originalitydeclaration` | thesis-uestc.cls:1369-1404 | Yes | fixed text page (`front.dedication`, `sp.setspace`, `sp.rule`) |
| metadata setters `\title`..`\Chairman`, `\setdate` | thesis-uestc.cls:648-744 | Yes | stored strings; the emitter writes the values into the cover rows (content) |
| degree and language options, `\ifchinesebook`, `\ifbachelor`... | thesis-uestc.cls:746-829 | Yes | static specialisation for one chosen option; strings go to `NEW:lang.kernel-names` and the cover rows |
| glossary and acronym styles | thesis-uestc.cls:907-994 | Yes | `idx.glossaries` published API (`\newglossarystyle`, `\newacronymstyle`) with `tbl.longtable`; needs `makeglossaries` run (see EXTERNAL above) |
| appendix, accomplishment, translation commands | thesis-uestc.cls:1509-1620, 1674-1704 | Yes | `\appendix`, `\renewcommand\the...`, `\addcontentsline`, `\markboth`, `bib.multi` with `bib.thebibliography` |
| bibliography wrappers | thesis-uestc.cls:1633-1670 | Yes | `\bibliographystyle`, `spacing` env, `\interlinepenalty`, `\@biblabel` set by length/string parameters |
| `\newcolumntype{L,C,R}` | thesis-uestc.cls:26-28 | Yes | `tbl.tabular` (`array` published API) |
| `\lstdefinestyle` x5 | thesis-uestc.cls:145-313 | Yes | `code.listings` styles with named colours (`color.xcolor`) |
| aliases `\algref`, `\citing`, `\floatcontinue`, `\bm`, `\chinesespace` and friends, `\strong`=`\heiti` | thesis-uestc.cls:321, 350, 366, 475-483, 746, 1752 | Yes | one-line aliases of lib ways (`xref.hyperref`, `mark.kernel`, `fig.subcaption` `\ContinuedFloat`, `font.unicode-math`, `font.fontspec`) |
| `thesis-uestc.bst` | thesis-uestc.bst:1-653; copy at slides/thesis-uestc.bst (differs) | Judgement | zip-local GB/T-style program (not on CTAN) that prints `\begin{thebibliography}{\bstlabelmark}` and entry layouts itself (:113-127, 407-510); the lib calls the .bst a parameter of `bib.bibtex-bst`, so I count it as a parameter, but I did not read its 653 lines through |
| `thesis-uestc.cls` itself | thesis-uestc.cls:1-1773 | See rows above | zip-local wrapper over `class.book`; not published |
| `slides/UESTC.sty` | slides/UESTC.sty:1-184 | Yes | `\setbeamertemplate`, `\setbeamercolor`, `\setbeamerfont`, `\useoutertheme` calls only (`slide.beamer-theme`, `slide.beamer-template`); `\ifx\insertsectionhead\@empty` tests sit inside template bodies |
| `silence`, `xpatch`, `\uestcwarning` | thesis-uestc.cls:5-6, 11-14 | Yes | no printed effect; the emitter can omit them |

## Content-opaque
- Cover emblem TikZ source pic/figure.tex:11-674 (build source of `logo.pdf`, not loaded by the class); `bachelor_font.pdf` cover lettering image (thesis-uestc.cls:1035)
- pstricks drawing in a frame, slides/masterThesisSlides.tex:177-198
- Algorithm body (main.tex:188-202), figure images, table cell text, longtable rows (main.tex:139-179), `thebibliography` items (main.tex:218-220)
- Shipped assets to copy with any rebuild: fonts/*.ttf (Times, SimSun, SimHei, FZ Song/Hei, STZhongsong; licence of these font files not established), pic/logo.pdf, pic/figure.pdf

## Lib changes
- New ways proposed: `NEW:lang.kernel-names` kernel name macros (`\contentsname`, `\figurename`, `\tablename`, `\bibname`, `\listfigurename`, `\listtablename`, `\appendixname`) plus `\proofname` (amsthm) and `\lstlistingname` (listings), set by `\renewcommand` with a string; engine pdf. W1 kernel and package-documented macros, W2 the value is a string, W3 any class or language, W4 preamble lines (or `\AtBeginDocument`). Searched the lib: `lang.babel` is the babel package, `lang.translator` excludes caption overrides, `lang.cjk` is the CJK engine support; none covers plain `\renewcommand` of names.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
