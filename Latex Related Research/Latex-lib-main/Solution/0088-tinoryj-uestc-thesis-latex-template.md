no

# 0088-tinoryj-uestc-thesis-latex-template: UESTC thesis template (thesis-uestc class, with a Beamer defence theme)

- Unverified: read from the source, not compiled.
- Source: Source/0088-tinoryj-uestc-thesis-latex-template/ (origin: https://codeload.github.com/tinoryj/UESTC-Thesis-Latex-Template/zip/refs/heads/main; licence: MIT per LICENSE:1, the .bst header says LPPL 1.3 (thesis-uestc.bst:5-8); the shipped fonts are not covered)
- Kind: thesis
- Lib: v1
- Engine: needs XeLaTeX (`\RequireXeTeX` thesis-uestc.cls:9; fontspec cls:67; xeCJK cls:51; unicode-math cls:49)
- Look carried by: zip-local (thesis-uestc.cls defines the whole look; main.tex:1-27 only passes the degree option and metadata)
- Class origin: zip-local (community GitHub kit by one author, not a UESTC release; ctan.org/pkg/thesis-uestc returned 404)
- Main file: main.tex (other samples: slides/masterThesisSlides.tex with slides/UESTC.sty; pic/figure.tex and pic/logo.tex only rebuild the emblem PDF)
- Read: main yes, zip-local classes and styles all (thesis-uestc.cls 1-1773, thesis-uestc.bst 1-653, slides/UESTC.sty 1-184; slides/thesis-uestc.bst by diff against the main copy; pic/figure.tex lines 1-40 of 674, TikZ path data of an image asset)

## Verdict
No. The look lives in a 1773-line zip-local class on top of `book`. Much of it is declarative (titlesec, tocloft, caption, fancyhdr, geometry, listings styles), but it also holds irreducible code: a multi-line underline box algorithm on the title page, patches of kernel float and footnote internals, a raw-PDF fake-bold hack, a page-hook-driven pseudo page counter, an implicit front-matter-to-body switch hooked into `\@chapter`, hand-built glossary styles, a hand-written BibTeX style, and `ifplatform` (shell escape) loaded unconditionally. Each of these alone makes the answer `no`.

## Blockers
- `BESPOKE/class` `\UnderlineCentered`: adjustbox + `\xleaders` + `\prevdepth` algorithm that rules every baseline of the value; used for classification number, secrecy class and UDC on the title page (thesis-uestc.cls:1102-1115, used 1123-1124 and 1243-1244)
- `BESPOKE/class` kernel float output patches: `\patchcmd{\@addtocurcol}` twice and `\patchcmd{\@getpen}{\@M}{\@Mi}` (thesis-uestc.cls:414-439)
- `BESPOKE/class` footnote internals: `\def\@makefntext` copy with `\footnotelayout` and a `\vfill` `\footnoterule` (thesis-uestc.cls:515-549)
- `BESPOKE/class` CJK fake bold through raw `\special{pdf:literal direct 2 Tr ...}` and `\lastkern` save/restore, then `\emph` rebuilt on it (thesis-uestc.cls:73-105; used 1127, 1132, 1247, 1251)
- `BESPOKE/class` pseudo page counter: `\AddEverypageHook{\stepcounter{pseudopage}}`, `\blankpage` with `\addtocounter{pseudopage}{-1}`, and per-page `\addtocontents{toc|lof|lot}{\cftsetpnumwidth{\widthof{\thepage}-1pt}}` hooks; the printed Roman page numbers come from it (thesis-uestc.cls:551-561, 574, 616-626, 847)
- `BESPOKE/class` implicit switch from front matter to body on the first `\chapter`: `\pretocmd`/`\apptocmd` on `\@chapter` with an `\@BODY` flag and `\thesiscontent` (thesis-uestc.cls:1471-1497)
- `BESPOKE/class` three `\newglossarystyle` bodies, `\newacronymstyle`, `\defglsentryfmt` that redefine `\glossentry`, `\glossaryheader`, `\genacrfullformat` with `\ifglshaslong`/`\ifglsused` logic (thesis-uestc.cls:907-994)
- `BESPOKE/class` `\renewenvironment{proof}` rebuilt on `\trivlist`, `\pushQED`, `\@addpunct`, heading font `\strong` (thesis-uestc.cls:1740-1750)
- `BESPOKE/class` zip-local BibTeX style, a 653-line stack program with custom entry types (`digital`, `newspaper`, `thesis`, `patent`, `standard`, `onlynote`), Chinese-name branch on `language`, string find/replace, and its own `thebibliography` header (thesis-uestc.bst:47-651; reference.bib:3-20 uses those types); the copy in slides/ differs in five hunks
- `EXTERNAL/package` `ifplatform` is loaded unconditionally (thesis-uestc.cls:55) and needs shell escape to detect the OS (CTAN page for ifplatform, read once); it selects the fonts at cls:107-141, and latexmkrc:2-3 runs with `--shell-escape`. `glossaries[automake]` (cls:47) runs makeindex through shell escape and latexmkrc:7-18 adds a makeglossaries rule (from knowledge of the package, not re-checked)

## Class setting
- Class: `class.book` options: 12pt, openany, twoside (thesis-uestc.cls:3, loaded by the zip-local class; the sample passes only `master`, main.tex:1). The zip-local `thesis-uestc` is not a way (W1 fails). Slides sample: `class.beamer` (slides/masterThesisSlides.tex:1).
- Class-native vocabulary used: options `bachelor|master|promaster|doctor|engdoctor|english` (cls:747-829); `\title{zh}{en}`, `\author`, `\advisor`, `\coAdvisor`, `\school`, `\major`, `\studentnumber`, `\ProfessionalDegreeArea`, `\ClassificationNumber`, `\ClassifiedClass`, `\UDCNumber`, `\Chairman`, `\setdate[submit|oral|confer]` (main.tex:3-17); `\makecover`, `\originalitydeclaration`, `chineseabstract`/`englishabstract`, `\chinesekeyword`/`\englishkeyword`, `\thesistableofcontents`, `\thesisfigurelist`, `\thesistablelist`, `\thesisglossarylist`, `\thesissymbollist`, `\thesisacknowledgement`, `\thesisbibliography[large]`, `\thesisappendix`, `thesistheaccomplish`, `\thesistranslationoriginal`/`\thesistranslationchinese`, `\citing`, `\algref`, column types `L{}` `C{}` `R{}` (main.tex:31-229).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | cls:3 | `class.book` | 12pt, openany, twoside |
| class options | cls:3 | `page.class-options` | 12pt, twoside, openany |
| page geometry | cls:377-381 | `page.geometry` | a4paper, inner=3cm, outer=3cm, top=3cm, bottom=3cm, bindingoffset=0cm; `\headheight` 15pt |
| header/footer | cls:342, 383-384, 1418-1428 | `hf.fancyhdr` | pagestyle fancy; headrulewidth 0.75pt; CE degree title, CO `\leftmark`, foot `\thepage` 9bp; `\fancyhf{}` restyle per front page (cls:571, 598, 845, 998) |
| page numbers | cls:564, 1098, 1476, 1493 | `pgnum.pagenumbering` | Roman front, arabic body, `\setcounter{page}{0|1}`; the printed front number is the bespoke pseudopage |
| spacing | cls:38, 385, 1372, 1636 | `sp.linespread` `sp.setspace` | linespread 1.391; `spacing` 2.14 (declaration), 1.667 (bibliography); `\setstretch{1}` in tables |
| lengths | cls:322, 386, 402-404, 1757-1760 | `sp.lengths` | parindent 24pt; floatsep/textfloatsep/intextsep 6bp; display skips 6pt; baselineskip 20pt |
| indent, microtype, flush | cls:338, 45, 369 | `sp.indentfirst` `sp.microtype` `pg.flush` | `\raggedbottom` |
| penalties | cls:1512, 1635 | `sp.penalties` | `\interlinepenalty` 0 and 10000 (same family as the listed integer parameters) |
| rules, manual space | cls:1134, 1138, 1203, 1386 | `sp.rule` `sp.manual-space` | `\rule{6.05in}{.5pt}`, `\vspace{2.3cm}`, `\hspace{28pt}`, `\\[24bp]` |
| ragged | cls:26-28 | `sp.ragged` | `\raggedright\arraybackslash`, `\centering\arraybackslash` in column types |
| text fonts | cls:67, 103-140 | `font.fontspec` | CJK main fzsong.ttf (Path=fonts/, AutoFakeBold); Latin times.ttf with BoldFont/ItalicFont/BoldItalicFont; `\newfontfamily` `\heiti` `\titlefont` `\codefont`; Windows and macOS branches by `ifplatform` |
| math font | cls:49, 138 | `font.unicode-math` | math-style=ISO, bold-style=ISO, `\setmathfont[Path=fonts/]{times.ttf}` |
| CJK, Chinese numerals | cls:51, 323, 392 | `lang.cjk` | xeCJK; `zhnumber` `\zhnumber{\arabic{chapter}}` (CJK numeral package, filed with the CJK family) |
| font sizes | cls:29, 488-501, 507-509 | `font.size-commands` | `\fontsize{15bp}{15bp}` chapter, 14bp section, 12bp subsubsection; `\small` 10.5bp/12.6bp; `\footnotesize` 9bp/10.8bp |
| symbol glyphs | cls:324, 511-513 | `font.icons` | pifont `\ding{172}`.. as footnote marks (nearest home: a symbol-font package) |
| colour | cls:16, 57-66, 208-210, 247-252 | `color.xcolor` | usenames, dvipsnames, svgnames, table; RGB listing colours |
| links and urls | cls:326-336, 368 | `meta.hyperref` `meta.url` | colorlinks=true, cite/link/url black, bookmarksnumbered, bookmarksdepth=4, hyperfootnotes=false; xurl[hyphens], `\urlstyle{rm}` |
| cover, title pages | cls:1030-1100, 1118-1361 | `front.class-native` `front.titlepage-env` | `\makecover` picks one of three layouts by degree option; body is tabular + `\cline` + multirow + minipage + `\includegraphics` (bespoke wrapper, see below) |
| title data | cls:648-744; main.tex:3-17 | `front.class-native` | bilingual setters stored in macros |
| cover blocks | cls:1047-1088, 1205-1236 | `tbl.tabular` `tbl.multirow` `box.minipage` `fig.graphicx` | `>{\fontsize{16bp}{16bp}\selectfont}l`, `\cline{2-2}`, `\multirow[t]{2}{10cm}`, `minipage[t][1.52cm]`, logo.pdf 180bp x 180bp |
| declaration page | cls:1369-1404; main.tex:32 | `front.dedication` | spacing 2.14; 14.04pt text; signature rules |
| included PDF pages | cls:358, 1363-1414 | `pg.include-pdf` | `\includepdf[pages=-]` for signed declaration and cover |
| abstracts | cls:563-614; main.tex:35-43 | `abs.class-native` `abs.keywords` | `chineseabstract`, `englishabstract`; `\chinesekeyword` (48pt hangfrom), `\englishkeyword` (2.1cm) |
| contents | cls:362, 628-646, 1430-1452; main.tex:45 | `toc.kernel` `toc.tocloft` `toc.etoc` | tocloft[titles]; cftdotsep 0.4; cftchapnumwidth +25pt; `\cftsetindents` section 21pt/22pt, subsection 44pt/31pt, subsubsection 76pt/41pt; tocbibind[nottoc]; tocdepth 2 |
| lists of figures, tables | cls:841-894; main.tex:46-47 | `toc.kernel` `toc.tocloft` | cftfigindent 0pt, cftfigpresnum `\figurename`, num width +12pt |
| headings | cls:343, 387-390, 488-501 | `head.titlesec` | `\titleformat` block; titlespacing chapter {0pt}{0pt}{18pt}, section {18pt}{6pt}, subsection and subsubsection {12pt}{6pt} |
| chapter mark | cls:1454 | `head.kernel` | `\markboth{\thechapter\hspace{5.25pt}#1}{}` |
| depth | cls:485-486 | `num.secnumdepth` | secnumdepth 3, tocdepth 2 |
| counters | cls:392-397, 1525-1535 | `num.counters` | thechapter 第`\zhnumber`章; thesection chapter.section; equation, table, figure as chapter-n |
| appendix | cls:344, 1509-1536 | `num.appendix` | appendix pkg; `\appendix`; thechapter 附录`\Alph` |
| lists | cls:50, 347, 1753-1754 | `list.enumitem` `list.enumerate-pkg` | `\setlist{noitemsep}`, `\setlist{nolistsep}` |
| marks | cls:346 | `mark.ulem` `mark.kernel` | ulem[normalem]; `\textsuperscript` |
| footnotes | cls:503-509, 515 | `fn.footmisc` `fn.kernel` | hang, perpage; footnotemargin 13.5pt; footnotesep +0pt; rule 5.05cm x 0.02cm |
| maths | cls:41-42, 1756-1771 | `math.amsmath` `math.amssymb` `math.bm` | amsmath[tbtags]; allowdisplaybreaks[4]; `\DeclareMathAlphabet` mathbb (msb), mathcal (cmsy); `\bm` as `\mathbfit` |
| theorems | cls:43, 1706-1738 | `thm.amsthm` | `\newtheoremstyle{dotless}{0pt}{0pt}{\normalfont}{24pt}{\strong}{}{ }{}`; seven statements sharing the theorem counter within chapter; qedsymbol black square; `\proofname` 证明 |
| algorithms | cls:349, 897-904; main.tex:188-204 | `alg.algorithm2e` `alg.algorithmicx` | algochapter, boxruled, linesnumbered; `\SetAlgorithmName`, `\thealgocf`; algpseudocode only loaded (cls:53) |
| figures | cls:17, 340, 353, 360, 441-443; main.tex:67-116 | `fig.graphicx` `fig.float` `fig.newfloat` `fig.adjustbox` | graphicspath {./pic/}; `\@floatboxreset{\centering}`; float, newfloat loaded without use; adjustbox only inside `\UnderlineCentered` |
| subfigures | cls:363-365; main.tex:89-113 | `fig.subcaption` | labelformat=simple; thesubfigure (a); font small, belowskip 6pt, width 40pt, centering |
| captions | cls:18, 407-410 | `cap.caption` | font={doublespacing,small}, labelsep=space, skip=6bp; width=`\textwidth`-84pt; figureposition=bottom, tableposition=top |
| tables | cls:20-36; main.tex:118-132 | `tbl.tabular` `tbl.booktabs` | `\newcolumntype` L C R as `m{#1}`; heavyrule 1.5pt, lightrule/arrayrule/cmidrule 0.75pt; arraystretch 1.4; 10.5bp |
| long table | main.tex:134-179 | `tbl.longtable` | `\LTleft`/`\LTright` 0pt, `\LTcapwidth`=`\textwidth`; head, firsthead, foot, lastfoot |
| multirow | cls:40, 54 | `tbl.multirow` | multirow, makecell |
| code | cls:68, 145-313, 341, 410 | `code.listings` `code.verbatim` | five `\lstdefinestyle` (c++, shell, json, python, solidity): frame=trbl, frameround=tttt, numbers=left, backgroundcolor yellow!5, breaklines, keyword classes, literate colours; fancyvrb loaded |
| bibliography | cls:1633-1670; main.tex:210 | `bib.bibtex-bst` | `\bibliographystyle{thesis-uestc}` (zip-local .bst); `[large]` sets labelsep 3pt and `\bstlabelmark` loo |
| citations | cls:69, 345, 1752; main.tex:55 | `bib.cite-pkg` | cite[noadjust]; `\citing` = superscript `\cite` |
| second bibliography | cls:354, 1672-1704; main.tex:216-221 | `bib.multi` `bib.thebibliography` | multibib[resetlabels], `\newcites{accomplish}`; `thesistheaccomplish` = `thebibliography{lo}` with hand `\bibitem` |
| glossary, symbols | cls:47, 996-1028; main.tex:25-27, 49-50 | `idx.glossaries` | sort=use, nopostdot, style=long, automake, acronym; `\printglossary[type=\acronymtype, style=uestc-chinese, nonumberlist, nogroupskip]` |
| cross-refs | cls:350; main.tex:84, 204 | `xref.kernel` `xref.hyperref` | `\label` `\ref`; `\hyperref[#1]{...}` in `\algref` |
| page breaks | cls:555-561, 1097, 1473 | `pg.break` | `\newpage`, `\clearpage`, `\cleardoublepage` |
| slides class, themes | slides/masterThesisSlides.tex:1-2; UESTC.sty:9, 111 | `class.beamer` `slide.beamer-theme` | `\usefonttheme[onlymath]{serif}`; smoothbars outer [footline=authorinstitutetitle, subsection=true]; circles inner |
| slides templates | UESTC.sty:14-60, 69-97, 115-171 | `slide.beamer-template` | title page, headline, footline templates with `\insertsectionnavigationhorizontal`; `\setbeamercolor` uestc `#115EA2`; blocks rounded shadow |
| slides overlays | masterThesisSlides.tex:53, 263, 390 | `slide.beamer-mode` | `[<+-\| alert@+>]`, `\pause`, `allowframebreaks` |
| slides misc | masterThesisSlides.tex:3, 7, 26-35, 399; UESTC.sty:15-17, 116-118 | `lang.cjk` `font.fontspec` `font.display` `code.listings` `thm.kernel` | ctex; Times New Roman family; calligra; listings frame=shadowbox; `\newtheorem{lem|thm|define}` |
| slides bibliography | masterThesisSlides.tex:391-394 | `bib.bibtex-bst` | thesis-uestc.bst (slides copy), `\nocite{*}` |
| figure artwork | masterThesisSlides.tex:178-198 | `art.pstricks` | `pspicture` inside a frame (content) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\UnderlineCentered` | cls:1102-1115 | no | rubric: leaders over arbitrary boxes are bespoke; single-line values could be approximated with `\makebox` + `sp.rule`, which is not the same behaviour |
| float patches `\@addtocurcol` `\@getpen` | cls:414-439 | no | rewrites the kernel output routine; no lib way |
| `\@makefntext`, `\footnoterule` | cls:515-549 | no | kernel internal redefinition; `fn.footmisc` hang options may cover the layout, but the copy was not checked against footmisc |
| CJK fake bold, `\emph` redefinition | cls:73-105 | no | raw PDF operators and kern bookkeeping |
| pseudopage counter, `\blankpage`, toc width hooks | cls:551-561, 616-626 | no | per-page output hooks drive printed numbers and toc geometry |
| `\@chapter` pre/post hooks, `\thesiscontent` | cls:1471-1497 | no | stateful hook on a kernel internal; no lib way |
| glossary styles and acronym style | cls:907-994 | no | macro redefinitions of glossaries internals (W2 fails) |
| proof environment | cls:1740-1750 | no | amsthm exposes only `\proofname` and `\qedsymbol`; the head font and spacing here need kernel list code |
| thesis-uestc.bst | thesis-uestc.bst:1-653 | no | zip-local program (W1 fails); published styles would change output and entry types |
| `ifplatform` OS branches | cls:55, 107-141 | no (EXTERNAL) | an emitter could emit the shipped-font branch (cls:127-140) only, but the package is loaded unconditionally |
| degree options, three cover layouts, `\ifbachelor` `\ifchinesebook` | cls:747-829, 1030-1361 | yes, except two items above | pick the branch at emit time; each branch is tabular, multirow, minipage, fontsize, rule, includegraphics (`front.titlepage-env`) plus `\UnderlineCentered` and the fake-bold title |
| bilingual data setters | cls:648-744 | yes | values go straight into the hand-laid pages |
| table style hooks `\ifuestcintable`, `\AtBeginEnvironment` | cls:29-36, 441-473 | yes | per-table wrapper: `\fontsize{10.5bp}{10.5bp}`, `\setstretch{1}`, arraystretch 1.4, extrarowheight 0 (`font.size-commands`, `sp.setspace`, `tbl.tabular`); etoolbox/xpatch hooks themselves are code patchers (W2 fails) and are not proposed as ways |
| front-matter wrappers (abstract, toc, lof, lot, glossary lists) with `\checkoddpage` | cls:563-608, 843-894, 996-1028, 1430-1448 | yes, apart from the pseudopage counter | `\cleardoublepage` + `pg.emptypage` + `\fancyhf{}` + `\fancyhead`/`\fancyfoot` |
| appendix, acknowledgement, translation, accomplishment, bibliography wrappers | cls:1456-1470, 1509-1704 | yes | `\appendix`, `\chapter*`, `\addcontentsline`, `\markboth`, counter renewals, `thebibliography`, `\newcites` |
| counter and name renewals | cls:392-397, 832-839, 1525-1535 | yes | `num.counters`, `\renewcommand` of names |
| `\lstdefinestyle` x5 | cls:145-313 | yes | `code.listings` keys and colours (solidity style has a missing comma at cls:306, a source defect) |
| `\newtheoremstyle{dotless}`, `\newtheorem` x7 | cls:1706-1738 | yes | `thm.amsthm` |
| `\citing`, `\floatcontinue`, `\algref`, `\strong`, `\heiti`, `\chinesecolon` etc., `\bm` | cls:366, 350, 746, 475-483, 321, 1752 | yes | aliases of kernel, caption, hyperref and xeCJK commands |
| `\DeclareMathAlphabet` for mathbb, mathcal | cls:1762-1767 | yes | kernel NFSS declarations, parameters only (`math.bm`) |
| `\thefootnote` via `\ifcase` and `\ding` | cls:511-513 | yes | counter format; the nesting at cls:513 looks mis-braced, a source defect |
| slides/UESTC.sty templates | slides/UESTC.sty:23-97 | yes with caveat | beamer template API; the footline `\ifx\insertsectionhead\@empty` branches (82-90) are template code, not decisive here |
| `silence`, `xpatch`, `etoolbox`, `everypage`, `ifoddpage`, `xspace`, `ifxetex` | cls:5-11, 352-357 | n/a | infrastructure with no printed effect of its own |

## Content-opaque
- Included images pic/figure.pdf and logo.pdf in floats (main.tex:68-113); the algorithm text (main.tex:188-202); `pspicture` in a beamer frame (slides/masterThesisSlides.tex:178-198).
- Assets: the university emblem is shipped as logo.pdf (cls:1045) and its TikZ source pic/figure.tex is not loaded by any sample, so it is an asset, not ART. Fonts are shipped in fonts/ (cls:103-139; the Microsoft and Founder faces are not freely redistributable). bachelor_font.pdf is shipped in pic/ (cls:1035).

## Lib changes
- New ways proposed: none. Considered and folded: `zhnumber` into `lang.cjk`, pifont `\ding` into `font.icons`; rejected: etoolbox/xpatch `\patchcmd` `\pretocmd` `\AtBeginEnvironment` (W2 fails: they edit code).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
