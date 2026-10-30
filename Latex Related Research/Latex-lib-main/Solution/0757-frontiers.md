no

# 0757-frontiers: Frontiers LaTeX Templates (manuscript classes FrontiersinHarvard, FrontiersinVancouver, frontiersinFPHY_FAMS; supplementary class frontiers_suppmat)

- Unverified: read from the source, not compiled.
- Source: Source/0757-frontiers/ (origin: https://www.frontiersin.org/design/zip/Frontiers_LaTeX_Templates.zip; licence: not established)
- Kind: journal
- Lib: v6
- Engine: pdfLaTeX-compatible (inputenc, `times`, psnfss `phv`; the dvips `\special{ps:` rotation macros at FrontiersinHarvard.cls:617-625 are never called by the sample)
- Look carried by: class (the four Frontiers `.cls` files set page, running heads, title block, abstract, headings, floats, captions, lists; the sample adds six packages, one font alias and five data strings)
- Class origin: publisher-official (the zip is Frontiers' own kit; `FrontiersinHarvard.cls:1` says it is based on `bioninfo.cls`, version 2.6 of 2016/11/10 at :2-3)
- Main file: frontiers.tex (other samples: frontiers_SupplementaryMaterial.tex)
- Read: main yes, zip-local classes and styles partly (FrontiersinHarvard.cls line by line; FrontiersinVancouver.cls, frontiersinFPHY_FAMS.cls and frontiers_suppmat.cls through a line diff against it with every differing line read, and for frontiers_suppmat.cls also lines 1-45, 228-263, 410-600, 828-942; the three `.cls` copies were not re-read line by line)

## Verdict
no. The look is carried by the publisher's own class, so it is one class way and its hand-written internals are not decomposed, and everything the sample adds (packages, a font alias, data strings, hand-set subfigure counters) is reducible. One blocker remains: the class loads `epstopdf` unconditionally (FrontiersinHarvard.cls:32) and its own `\@maketitle` includes `./logo1.eps` with the extension (FrontiersinHarvard.cls:486), and the sample includes `logo1.eps` and `logo2.eps` (frontiers.tex:184, 192), so the document needs the Ghostscript conversion that the lib's `fig.epstopdf` line marks EXTERNAL when an EPS file is included, and the pilot ruling on unconditional packages applies. If a reviewer rules that EPS conversion is only a shippable-asset matter (the zip ships logo1.pdf and logo2.pdf), the rest reduces and the answer would be yes; I applied the lib line as written. Also recorded: were the class judged zip-local instead, its 956 lines of kernel redefinitions would be BESPOKE/class and irreducible.

## Blockers
- `EXTERNAL/package` `epstopdf` converts EPS to PDF through Ghostscript under pdfTeX; `./logo1.eps` is included by every `\maketitle` (FrontiersinHarvard.cls:32, FrontiersinHarvard.cls:486, frontiers.tex:184, frontiers.tex:192; same in frontiers_SupplementaryMaterial.tex:62, :70 and frontiers_suppmat.cls:478)

## Class setting
- Class: `class.frontiersinharvard` options: `utf8` (frontiers.tex:14; passed to `inputenc`, FrontiersinHarvard.cls:25); defaults `a4paper,nocrop,centre,info,paper` (FrontiersinHarvard.cls:27); declared options `draft paper a4paper centre crop nocrop info noinfo final utf8` (FrontiersinHarvard.cls:16-25). Alternatives named in comments at frontiers.tex:15-16: `class.frontiersinvancouver` and `class.frontiersinfphy_fams`; the supplementary sample uses `class.frontiers_suppmat` (frontiers_SupplementaryMaterial.tex:10).
- Class-native vocabulary used: `\firstpage{n}` (frontiers.tex:46), `\title[running title]{}` (:48), `\author[running author]{}` (:50), `\address{}` (:51), `\correspondance{}` (:52), `\extraAuth{}` (:54), `\maketitle` (:58), `abstract` environment in which `\section` prints a run-in label (:61-72), the data macros `\firstAuthorLast` `\Authors` `\Address` `\corrAuthor` `\corrEmail` (:29-39, read by FrontiersinHarvard.cls:242, 498-502), `\helveticabold` (:28), the class's own `subfigure` float (:179). Class-provided and not used by the sample: `\application`, `\vol`, `\issue`, `\history`, `processtable`, `methods`, `unlist`, `\medline`, `\query`, `\sbond` `\dbond` `\tbond`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | frontiers.tex:14 | `class.frontiersinharvard` | option `utf8`; Harvard author-date manuscript |
| alternate classes (commented) | frontiers.tex:15-16; FrontiersinVancouver.cls:864-865; frontiersinFPHY_FAMS.cls:863-864 | `class.frontiersinvancouver`, `class.frontiersinfphy_fams` | the same 956 lines but `natbib` loaded with `numbers,round` and `\@biblabel` `\textbf #1.` (Vancouver), `numbers,square` and `\textbf [#1] ` (FPHY_FAMS) |
| supplementary class | frontiers_SupplementaryMaterial.tex:10; frontiers_suppmat.cls:230-246, 339, 485, 561-565, 577, 586 | `class.frontiers_suppmat` | title only, 8/10 running heads, equation, figure and table numbers prefixed `S`, small table captions; loads neither `caption` nor `subcaption` (cls:38-40 absent) |
| paper size and crop | FrontiersinHarvard.cls:11-12, 18-21, 27 (inside class) | `page.class-options` | `\paperheight 11truein`, `\paperwidth 8.5truein`, then `a4paper` passes `a4` and `centre` passes `center` to `crop`, `nocrop` passes `off` |
| page geometry | FrontiersinHarvard.cls:142-172, 159-161 (inside class) | `page.setlength` | headheight 16pt, topmargin 1.3pc minus 1in, headsep 19pt, footskip 34pt, textwidth 42pc, textheight 56 baselineskip plus topskip, oddsidemargin 4.5pc, columnsep 1.5pc, columnseprule 0pt, marginpar 35pt wide |
| columns | FrontiersinHarvard.cls:903 (class `\twocolumn`); frontiers.tex:45 | `cols.twocolumn-cmd` | the class starts two-column; the sample calls `\onecolumn` |
| running heads and feet | FrontiersinHarvard.cls:232-248, 250-262, 445 | `hf.class-native` | page style `headings`: head = Helvetica bold 11/10 italic `\firstAuthorLast` left, `\rightmark` right, 0.5pt rule; foot = 0.5pt rule, "Frontiers" left, page right; page style `opening` for the first page via `\thispagestyle{opening}`; twoside (cls:45) |
| page number and first page | frontiers.tex:46; FrontiersinHarvard.cls:266-283, 308-310 | `front.class-native`, `pgnum.pagenumbering` | `\firstpage{1}` sets the page counter and the page-range text; the class redefines `\pagenumbering` and calls `\pagenumbering{arabic}` at `\AtBeginDocument` |
| line spacing | frontiers.tex:20 | `sp.setspace` | `[onehalfspacing]` |
| paragraph and skips | FrontiersinHarvard.cls:33, 100-112 (inside class) | `sp.parskip-pkg`, `sp.lengths` | `parskip` loaded then `\parindent 3mm`, `\parskip` = `\medskipamount` (6pt plus 2pt), `\lineskip 1pt`, `\smallskipamount` `\medskipamount` `\bigskipamount` reset |
| page-breaking and widows | FrontiersinHarvard.cls:115-133, 900 (inside class) | `sp.penalties`, `pg.flush` | `\clubpenalty` `\widowpenalty` `\brokenpenalty` 10000, `\predisplaypenalty` 10000, `\postdisplaypenalty` 2500, `\interlinepenalty` 0; `\flushbottom` |
| hyphenation and tolerance | FrontiersinHarvard.cls:136-137, 894-898, 933, 935 (inside class) | `sp.hyphenat` | `\lefthyphenmin` `\righthyphenmin` 3, `\tolerance` 9999, `\vbadness` 9999, `\doublehyphendemerits` 640000, `\finalhyphendemerits` 1000000, `\hyphenation{Figure Table Figures Tables}` (loose fit: same family of TeX line-breaking parameters as `\sloppy`) |
| spaces after punctuation | FrontiersinHarvard.cls:881-882, 901 (inside class) | `sp.frenchspacing` | class redefines `\frenchspacing` (sfcode 1500 for `. ? ! : ; ,`) and calls it |
| microtype, line numbers | frontiers.tex:19, 22 | `sp.microtype`, `sp.draft-lineno` | `\usepackage{microtype}` no options; `\usepackage{lineno}` with `\linenumbers` |
| text face and encoding | FrontiersinHarvard.cls:32, 25 | `font.mathptmx`, `font.fontenc-t1` | `times`; `inputenc` with `utf8` |
| Helvetica switches | FrontiersinHarvard.cls:34-37; frontiers.tex:28 | `font.nfss` | `\helvetica` = `\fontfamily{phv}\selectfont`, `\helveticabold` adds `\bfseries`, `\helveticaitalic`, `\helveticabolditalic` |
| font sizes | FrontiersinHarvard.cls:52-88, 91-97 (inside class) | `font.size-commands` | `\normalsize` 12/12, `\small` 11/12, `\footnotesize` 8/10, `\scriptsize` 11/11, `\tiny` 10/11, `\large` 13/14, `\Large` 14/16, `\LARGE` 15/17, `\huge` 22/22, `\Huge` 30/30; old `\rm` `\bf` `\it` re-declared |
| colour | FrontiersinHarvard.cls:38, 421-423 | `color.xcolor` | `usenames,dvipsnames`; `black` cmyk 0 0 0 1, `gray` 0.25, `darkgray` 0.5 |
| title block | frontiers.tex:48-58; FrontiersinHarvard.cls:395-411, 427-509 | `front.class-native` | `\@maketitle`: logo `logo1.eps` 12pc wide, 1pt rule, title Helvetica bold 20/21, authors bold 12/15, address slanted 12/12, "Correspondence*:" block 12/10, extra authors; top skip -7pc on odd pages, -3pc on even (cls:478, uses `\checkoddpage`) |
| title data strings | frontiers.tex:29-39 | `front.class-native` | `\firstAuthorLast`, `\Authors`, `\Address`, `\corrAuthor`, `\corrEmail` are plain macros the class prints (cls:242, 498-502); `\address{}` `\correspondance{}` `\extraAuth{}` are left empty (frontiers.tex:51-54) |
| abstract | frontiers.tex:61-72; FrontiersinHarvard.cls:514-522 | `abs.class-native` | heading "ABSTRACT" in sans bold 12/12, `\section` mapped to a run-in bold label (`\absection`), `\vskip 12pt plus -2pt minus 2pt` after |
| keywords | frontiers.tex:70-71; FrontiersinHarvard.cls:514-519 | `abs.keywords` | `\tiny` then `\keyFont{ \section{Keywords:} word, ...}` inside the abstract; `\keyFont` = `\fontsize{8}{11}` + `\helveticabold` |
| headings | frontiers.tex:74, 80, 86, 88-94, 133-151; FrontiersinHarvard.cls:531-554 | `head.class-native` | section: bold Helvetica 13/13 upper case, beforeskip -10pt plus -3pt, afterskip 3pt; subsection bold 11.5/12 (4pt plus 2pt, 2pt); subsubsection Helvetica 11.5/12; paragraph and subparagraph italic 11.5/12; `\section*` used for unnumbered parts |
| heading numbers | FrontiersinHarvard.cls:527, 529, 336-340, 809 | `num.secnumdepth`, `num.counters` | `secnumdepth` 5, `tocdepth` 4; `\thesubsection` = `\thesection.\arabic{subsection}` and so on; `\@seccntformat` number plus `\quad` |
| equation | frontiers.tex:100-102; FrontiersinHarvard.cls:32, 341, 878 | `math.amsmath` | `equation` with `\label`; `\theequation` = `\arabic{equation}`; `\jot` 5pt |
| figure | frontiers.tex:170-175; FrontiersinHarvard.cls:591-598 | `fig.graphicx`, `sp.ragged` | `figure[h!]`, `center`, `\includegraphics[width=10cm]{logo1}`; class default placement `tbp` |
| subfigure | frontiers.tex:177-201; FrontiersinHarvard.cls:627-641 | `fig.class-native`, `num.counters`, `box.minipage`, `fig.subcaption` | the class's own float `subfigure` (not the `subcaption` environment, because the class redefines `\subfigure` after loading `subcaption` at cls:40); counters set by hand `\setcounter{figure}{2}` and `\setcounter{subfigure}{0|1|-1}` at frontiers.tex:177-198; two `minipage[b]{0.5\textwidth}`; `subcaption` loaded with `labelfont=bf,list=true` (cls:40, frontiers.tex:19) |
| EPS inclusion | frontiers.tex:184, 192; FrontiersinHarvard.cls:32, 486 | `fig.epstopdf` | `epstopdf` loaded by the class; `logo1.eps` and `logo2.eps` included with the extension; **EXTERNAL** (see Blockers) |
| captions | frontiers.tex:174, 199; FrontiersinHarvard.cls:39, 575-579 | `cap.kernel`, `cap.caption` | `caption` with `labelsep=quad,indention=10pt`; class `\@makecaption` prints bold "label." then `\enskip` and the text at `\normalsize`; `\textbf{(A)}` in the combined caption (frontiers.tex:199) |
| inline marks | frontiers.tex:199, 117 | `mark.kernel`, `code.verbatim` | `\textbf`; `verbatim` blocks at frontiers.tex:117-118 |
| links and URLs | frontiers.tex:19, 65, 67, 82 | `meta.hyperref`, `meta.url` | `hyperref` and `url` with no options; `\href{url}{text}` used throughout |
| cross-references | frontiers.tex:101, 105, 174, 186 | `xref.kernel` | `\label`, `\ref` |
| citations and bibliography | frontiers.tex:76, 155-157; FrontiersinHarvard.cls:850-863; Frontiers-Harvard.bst:7, 54 | `bib.natbib`, `bib.bibtex-bst` | `natbib` loaded with no options by the class; `\citep`; `\bibliographystyle{Frontiers-Harvard}` (a `merlin.mbs`-generated `.bst`, LPPL, Frontiers-Harvard.bst:7-20) and `\bibliography{test}`; the commented Vancouver style is `Frontiers-Vancouver.bst` (frontiers.tex:156) |
| class-provided, not used by the sample: lists | FrontiersinHarvard.cls:683-781 | `list.kernel` | own `itemize` and `enumerate` with optional label-width argument, `\itemsep 3pt`, `\labelsep 0.5em`, `leftmargini` 3mm, `unlist` |
| class-provided, not used: quotes, footnotes, contents | FrontiersinHarvard.cls:787-797, 842-844, 806-834 | `quote.kernel`, `fn.kernel`, `toc.kernel` | `quote` = `quotation` with 2em margin; footnote rule 0.5pt; `\l@section` and `\l@subsection` dotted lines |
| class-provided, not used: theorems, tables, appendix, margin notes | FrontiersinHarvard.cls:885-892, 939-944, 563-568, 583-589, 655-678, 870-874, 48-50 | `thm.class-native`, `tbl.tabular`, `num.appendix`, `note.marginpar` | `\th@plain` small-caps head, italic body, `proof` re-declared; `tabular` parameters, own `\toprule` `\midrule` `\botrule`, `processtable`, column type `P`; `\appendix` resets section and subsection; margin notes on the outer edge (`\reversemarginpar`) |
| packages the class loads and carries | FrontiersinHarvard.cls:32, 377-378 | `class.frontiersinharvard` | `inputenc crop graphicx amsmath array color amssymb flushend stfloats amsthm chngpage times datetime epstopdf`: `flushend` (the type of lib `balance`), `stfloats` (type of the `cuted` way), `chngpage` (type of `adjustwidth`, used by `\checkoddpage` at cls:478), `datetime` with `\newdateformat{mydate}` (not used), `crop` (options only); no separate way is needed because the class way carries them |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\keyFont` alias | frontiers.tex:28 | yes | `\fontsize{8}{11}` (`font.size-commands`) followed by the class's `\fontfamily{phv}\bfseries\selectfont` (`font.nfss`); a `\newcommand` alias |
| title data macros `\firstAuthorLast` `\Authors` `\Address` `\corrAuthor` `\corrEmail` | frontiers.tex:29-39 | yes | strings read by class-native front matter and running head (`front.class-native`); `$^{1,*}$` markers are content |
| subfigure counter settings | frontiers.tex:177-198 | yes | body wrapper of `\setcounter` calls (`num.counters`) around the class's `subfigure` float; whether the combined caption numbers correctly is not verified |
| `\begin{subfigure}` with no argument | frontiers.tex:179-201 | yes | the class's own float (cls:633-635), not the `subcaption` environment that takes a width |
| class kernel redefinitions: `\@maketitle`, `\ps@headings`, `\pagenumbering` with `\firstpage` and last-page aux write, `\@makecaption`, `processtable`, `subfigure` float, `itemize` and `enumerate`, toc lines | FrontiersinHarvard.cls:475-509, 232-262, 266-317, 575-579, 655-676, 627-641, 724-771, 813-834 | not assessed: published (publisher-official) class, one class way | would be BESPOKE/class and irreducible (box-and-glue heads, aux-file page range, hand-rolled float types) if the class were judged zip-local |
| duplicate `\def\section` | FrontiersinVancouver.cls:528-531 and 533-536 | yes (identical copies) | no effect; same heading as `head.class-native` |
| dvips rotation macros `\rotstart` `\rotl` `\rotr` | FrontiersinHarvard.cls:617-625 | not used by the sample | only reached through `processtable` when `\if@rotate` is set (cls:662-669) |

## Content-opaque
none (`logo1.eps` and `logo2.eps` at frontiers.tex:172, 184, 192 are figure artwork; `logo1.eps` in the class header at FrontiersinHarvard.cls:486 is an included image, not a drawn shape, so not ART). The Frontiers PDF examples in `PDF examples/` and `test.bib` are outputs and data, not template.

## Lib changes
- New ways proposed: none. Considered, no proposal: `crop`, `flushend`, `stfloats`, `chngpage` (loaded inside the publisher-official class, carried by the class way; the three last are the same type as existing lib lines for balancing, full-width floats and margin widening).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
