yes

# 0348-juramisc: juramisc, German legal-text classes (jurabook, juraurtl, juraovw) and their manual

- Unverified: read from the source, not compiled.
- Source: Source/0348-juramisc/ (origin: https://mirrors.ctan.org/macros/latex/contrib/juramisc.zip; licence: LPPL 1.2 per manifest `lppl1.2`, README:14; ctan.org/pkg/juramisc read once: package "Juramisc", version 0.91, LPPL 1.2)
- Kind: misc (the main sample is a package manual; the classes it documents are for a law thesis/book, court decisions and study overviews)
- Lib: v3
- Engine: pdfLaTeX-compatible (doc/jmgerdoc.tex:24-29 selects `pdftex` under `\ifpdf`; the else branch also accepts DVI latex)
- Look carried by: mixed (class `ltxdoc` plus about twenty macros in the sample preamble, doc/jmgerdoc.tex:95-262; the zip's own classes carry the look of juramisc documents, but only the DocStrip demo in doc/jbook/jbook.dtx loads one)
- Class origin: tex-distribution-unbundled (`ltxdoc`, doc/jmgerdoc.tex:26, not in the zip; the zip's own classes jurabook, juraurtl, juraovw are `ctan`: the zip is the CTAN release, so they are published, not zip-local)
- Main file: doc/jmgerdoc.tex (other samples: doc/jbook/jbook.dtx, an ltxdoc driver (22-38) whose `demo`/`template` guards generate jbkdemo.tex and jbktmpl.tex through doc/jbook/jbook.ins:38-39; the generated files are not shipped; prebuilt doc/jmgerdoc.pdf and jmgerdoc_scr.pdf not read)
- Read: main yes (all 3375 lines, a Windows-1252 file), zip-local classes and styles partly: read fully jurabase.sty, juraovw.cls, juraurtl.cls, jbgoe.clo, jbstgallen.clo, jbtrier.clo, jbook.dtx, jbook.ins; jurabook.cls (3290 lines) lines 1-910, 915-1153, 1195-1330, 2455-2540 and 3100-3290 plus an outline grep; not read: 911-914, 1154-1194 (end of the page-style code), 1330-2455 (parts, chapters, sections, matter commands) and 2540-3100 (rest of toc entries, `\TODO`, index, web citations)

## Verdict
yes. The main sample is the German manual of the bundle, typeset with the distribution class `ltxdoc`; its look is that class plus preamble macros that are all kernel boxes, lists, lengths, fancyvrb, xcolor and hyperref settings, each reduced in the Bespoke code table, with no TikZ or picture artwork and no outside tool (`makeidx` is loaded but `\makeindex` and `\printindex` are never called). The zip's real templates, jurabook, juraurtl and juraovw (with jurabase and three title-page `.clo` files), are the CTAN release of the package, so they are published and enter as `class.<name>` ways; their hand-written internals are not reduced, and would be `BESPOKE/class` if the zip were not the CTAN release (so the `yes` rests on W1 for those classes). The only sample that loads jurabook is the DocStrip demo in jbook.dtx, which reduces to the class plus `typearea`, `jurabib`, `microtype`, `makeidx` and a makeindex style file.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: `a4paper,11pt,pdftex` (doc/jmgerdoc.tex:26; the else branch at 28 drops `pdftex`). Source not read (distribution class). Second sample: `class.jurabook` options: `12pt,a4paper,english,german,centeredpartsintoc`, version date `[2006/04/26]` (doc/jbook/jbook.dtx:103-108). Documented in the manual, loaded by no sample: `class.juraurtl` (doc/jmgerdoc.tex:2808, `[a4paper,12pt]`) and `class.juraovw` (3221-3224).
- Class-native vocabulary used (ltxdoc, with `doc`): `\MakeShortVerb{|}` (doc/jmgerdoc.tex:130), `\DescribeMacro` (398, 400, 402 and about 80 more lines), `\DescribeEnv` (424, 456, 520 and 18 more), `\meta` and `\marg` (405, 3245), `\changes` (41-72); `\cs` (1802, 1813) and `\cmd` (777) are taken to come from doc/ltxdoc (class source not in the zip, unverified). `\jbook`, `\jbase` etc. are the sample's own aliases.
- Class-native vocabulary used (jurabook, jbook.dtx demo): `\subtitle` `\subauthor` `\publishinfo` (275-280), `\frontmatter` `\mainmatter` `\backmatter` (571, 640, 823), `\overview` (573), `\rn[label]{word}` and `\rnref` (653, 676), `\part[label]{}` and `\chapter[head][breaks]{}` (648, 695, 720), `\subthreesection` `\subfoursection` (749, 754), `\hnewline` (721), `\dcs` (673), `\citeweb` `\citewebx` (680, 708), `\Index` (710), `\shortindexingon` (240), `\bibtotoc` (844), `decisionlist` with `\decision` `\newcourt` `\notyet` (860-876), `\tableofwebcites` (885), `\setjbooktext` `\setjbookstyle` `\setjbooklength` (322-364), `\onespacing` (830), switches `\ifjpdf` (716) `\ifjscreen` (157). Documented only (doc/jmgerdoc.tex): `\toc` `\sub` `\levelup` `\leveldown` `\chapterlevel` (1070-1099), `\setchaptername` (1992-2031), `\changestarchapters` (2145), `\mainmatter*` (2183), `\TODO` (2209), `\dumpoptions` (2253), 22 class options (jurabook.cls:78-406).
- Class-native vocabulary (juraurtl, documented 2813-3213; juraurtl.cls): environments `rubrum` `tenor` `tatbestand` `gruende` `gutachten` `urteilsformel` `eingerueckt` `wortlaut` (juraurtl.cls:101-208), data commands `\gericht` `\az` `\lmv` `\richter` `\urteilsart` `\angeklagt` `\straftatbestand` (68-93), `\rjust` `\gegen` `\bl` `\nextsec`, options `strafurteil` `modern` `draft` (35-37). juraovw (documented 3221-3337; juraovw.cls): `\settheme` `\merke` `\jdef` `\greybox` `\lithinweis` `\formulierung`, environments `beispiel` `hinweis` `uebersicht` `gesetzestext` `hands` `stars` `triangles` `aufzaehlung` (47-203). jurabase.sty (loaded by all three, never by a sample): `\antrag`, `forwardandback`, about 45 abbreviation commands, `\juraenum`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (manual) | doc/jmgerdoc.tex:24-29 | `class.ltxdoc` | a4paper, 11pt, pdftex; `\RequirePackage{ifpdf}` before the class (24) |
| page size, margins | 26; 112-120 | `page.class-options` | a4paper, 11pt only; no geometry in the print branch. `geometry[screen,centering]` (119) only if `\screenversiontrue`; the switch is false (113); then `page.geometry` |
| encodings, fonts | 32-34 | `font.fontenc-t1`, `font.lmodern` | inputenc `ansinew`, fontenc `T1`, `textcomp`, `lmodern` |
| language | 35; 135-136; 299-313; 1357, 1367-1372 | `lang.babel` | options `english,ngerman`; `\renewcommand*{\refname}{Verweise}` and `\figurename{Uebersicht}` (babel may reset them at `\begin{document}`, unverified); `otherlanguage{english}`; `\glqq \grqq \flqq \frqq` quotes and `"` shorthands |
| colours | 78, 91, 95-98, 101-104, 152 | `color.xcolor` | `fixpdftex`; light-blue (0.4,0.4,1.0), dark-green (0,0.5,0.4), orange (1,0.5,0), slategray (0.4,0.5,0.6); `\color` aliases |
| links, metadata | 79-89, 274-275, 367, 3353-3371 | `meta.hyperref` | pdftitle, pdfsubject, pdfkeywords, pdfauthor, colorlinks=true, linkcolor=dark-green, urlcolor=cyan, citecolor=dark-green; `\href` for mail, web and CTAN links (the same package, no separate way) |
| paragraph shape | 131-132; 293-294 | `sp.lengths` | `\parindent` 0pt, `\parskip` 2ex; contents set with `\parskip` 0pt in a group |
| page style | 134 | `hf.pagestyle-kernel` | `headings` |
| doc commands | 130, 398-3331, 41-72 | `dtx.doc` | `\MakeShortVerb{|}`, `\DescribeMacro`, `\DescribeEnv`, `\changes` (see Class setting) |
| verbatim | 36, 147-170; first use 409, 426; 2007-2009 | `code.verbatim` | fancyvrb `\DefineVerbatimEnvironment` for `codeverb` and `preverb`: formatcom colour, frame=leftline, framesep=.5\leftmargin, rulecolor=slategray, samepage=true; `cliverb` without frame (165-170); plain `verbatim` (2007, 2018); `|..|` short verb |
| syntax box | 174-187; first use 404-406 | `box.fancybox`, `box.minipage` | `\fbox{\parbox{w}{..}}` with w = #1*linewidth - 2*fboxsep - 2*fboxrule (calc), 71 uses |
| margin hints | 189-194; 803, 1485 | `note.marginpar`, `sp.ragged`, `font.size-commands` | `\marginpar{\parbox{\marginparwidth}{\raggedleft\scriptsize ..}}`, fixed German text |
| hint lists | 228-243; 254-260 | `list.kernel`, `sp.lengths` | kernel `list` with bold label ("Tip:", "Hinweis:", "Achtung!"), labelwidth = label width, labelsep = one space, leftmargin = both; `mountteidi`: label `--`, indents 0pt |
| quote | 245-251 | `quote.kernel` | `\parskip` 0ex, `\rightmargin` = `\leftmargin` |
| title block | 271-276, 288 | `front.maketitle`, `front.thanks` | `\title{{\LARGE\sffamily ..}\\{\Large\sffamily ..}}`, `\author` with `\thanks{\href{mailto:..}}` and URL, `\date` with `\today` |
| abstract | 289-291 | `abs.kernel` | `abstract` with `\noindent` |
| contents | 293-294; 674 | `toc.kernel` | `\tableofcontents`; `\addtocontents{toc}{\protect\pagebreak[4]}` |
| headings | 315, 341, 357, 371, 391, 396, 675 | `head.kernel` | `\section` `\subsection` `\subsubsection` `\paragraph` with ltxdoc's look; `\protect\bgroup\sffamily .. \protect\egroup` inside titles (315, 391, 675) |
| lists | 660, 678, 1378, 2294 | `list.kernel` | `itemize`, `enumerate`, `description`, nested |
| tables | 343-353, 558-570, 1031-1057, 2122-2133 | `tbl.tabular` | `tabular` with `l`/`r`/`c`/`p{}` columns, `\hline`, `\multicolumn` (635, 2124), `\rule{0pt}{3ex}` struts (1034-1056), `\arraystretch` (1442, 2121) |
| tabbing | 444-453, 505-517, 2078-2113 | `tbl.tabular` | judgement call: kernel `tabbing` with `\=` `\>` `\kill`, filed under the kernel table way as 0053 did; shows what `forwardandback` output looks like |
| floats, captions | 319-339, 588-640, 1029-1059, 1101-1120 | `fig.graphicx`, `cap.kernel` | `figure[ht]` and `table[ht]` without graphics, `\caption` with `\label` (338, 639, 1058, 1119) |
| boxed diagram | 321-337 | `box.fancybox`, `box.minipage` | `\fbox{\parbox[c][4ex][c]{.30\linewidth}{..}}` grid of nine boxes, `\hfil` and `\\[1ex]`/`\\[3ex]` (figure content) |
| columns | 589-638 | `cols.multicol` | `multicols{2}` in a figure, `\columnsep` 0pt; the sample has no `\usepackage{multicol}`, so it relies on ltxdoc/doc loading it (not read) |
| footnotes | 581, 698, 749, 765, 915, 1362 and 8 more | `fn.kernel` | `\footnote` |
| cross-references | 338, 1026, 1285; `\myref` 262 | `xref.kernel` | `\label` `\ref` `\pageref`, `\cite` to the hand-written list |
| marks | 144, 561-568, 764, 849 and about 45 more | `mark.kernel` | `\emph`, `\textbf`, `\texttt`, `\textsc`, `\itshape`, `\sffamily`, `\textsuperscript` |
| sizes | 301, 591, 803, 1062, 1232 | `font.size-commands` | `\footnotesize`, `\small`, `\scriptsize`, `\LARGE`, `\Large` |
| manual spacing, quote hang | 184, 307, 1184-1203, 1355-1359, 3041; 1357 | `sp.manual-space` | `\medskip`, `\vspace`, `\hspace*`, `\\[1ex]`; `\leftskip=3em\rightskip=\leftskip\noindent\llap{\glqq}` (1357, quote with hanging open quotation mark) |
| rules, leaders | 1034-1038, 1776, 2931, 3118, 3140 | `sp.rule` | `\rule{0pt}{3ex}`, `\rule{\linewidth}{.5pt}`, `\dotfill` |
| alignment | 190, 298-313, 321-337, 934, 948, 2947 | `sp.ragged` | `\raggedleft`, `\centering`, `\raggedright` |
| hanging heading demo | 930-935, 1962-1967 | `sp.lengths` | `\settowidth{\tmplen}{..}`, `\hangindent=\tmplen` (content demo of a chapter heading) |
| inline maths | 216, 224, 648-653, 966-971 | `math.kernel` | `\(\rightarrow\)` and arrow family only |
| page breaks | 296, 390, 673, 2803, 3220, 3348 | `pg.break` | `\pagebreak[4]`, `\clearpage` |
| appendix, bibliography | 3347-3373 | `num.appendix`, `bib.thebibliography` | `\appendix`; `\addcontentsline{toc}{section}{\refname}`; `thebibliography{99}` with 21 `\bibitem` |
| index package | 31 | `idx.makeidx` | load only; no `\makeindex` or `\printindex` in the sample (hits at 719, 736-737, 1690, 1859, 2579 are prose or verbatim) |
| support packages | 31 | none needed | `xspace` (alias macros), `ifthen` (`\ifthenelse` at 213, 221), `calc` (length sums at 178, 209-211): no output of their own; see Bespoke code |
| class (demo) | doc/jbook/jbook.dtx:103-108 | `class.jurabook` | 12pt, a4paper, english, german, centeredpartsintoc |
| demo packages | jbook.dtx:126-132 | `font.fontenc-t1`, `font.lmodern`, `lang.babel`, `idx.makeidx`, `page.typearea` | inputenc ansinew, T1, textcomp, lmodern, babel; `typearea[BCOR10mm,DIV12,headinclude,footexclude,mpexclude]` (130) |
| demo print/screen | jbook.dtx:154-183 | `sp.microtype`, `meta.hyperref` | print branch `microtype[protrusion=true,expansion=true]` (181); screen branch with colour and hyperref (158-179) only under `\jscreentrue`, default `\jscreenfalse` (156) |
| demo bibliography | jbook.dtx:133, 376-435, 844-851 | `bib.apacite`, `bib.bibtex-bst` | jurabib options commabeforerest, superscriptedition=switch, howcited=normal, authorformat=dynamic, annotatorformat=italic, annotatorfirstsep=in, titleformat={all,commasep}, bibformat={ibidemalt,raggedright}; separator strings `\bibbtsep` `\bibjtsep` `\bibansep` `\bibatsep` `\ajtsep` `\bibbdsep`, name fonts `\biblnfont` etc.; `\bibliographystyle{jurabib}`, `\bibtotoc` |
| demo index | jbook.dtx:219-224, 239-240, 892 | `idx.makeidx` | `\makeindex`, `\printindex`, makeindex style `jurabook.ist` (`quote`, `heading_prefix`, `heading_suffix`, `headings_flag`) written by `filecontents`; run `makeindex -s jurabook.ist -g` |
| demo frontmatter | jbook.dtx:273-281, 571-574 | `class.jurabook` | `\title` `\subtitle` `\author` `\subauthor` `\publishinfo` `\date`, `\frontmatter`, `\maketitle`, `\overview`, `\tableofcontents` |
| demo sectioning | jbook.dtx:648-796 | `class.jurabook` | `\part`, `\chapter` (short head, optional break text), `\section` to `\subfoursection`; look set by `\setjbookstyle{maketime}`, `\setjbooklength{chapterbefore}{0pt}`, `\setjbooklength{runnersspace}{3pt}` (336-364) |
| demo runner numbers, notes | jbook.dtx:653-680 | `class.jurabook` | `\rn`, `\rnref`, class footnote layout (jurabook.cls:1046-1064); runners are kernel `\marginpar` plus a counter (jurabook.cls:1236-1250) |
| demo back matter | jbook.dtx:823-894 | `class.jurabook` | `\backmatter`, `\onespacing`, `small` group, `decisionlist`, `\tableofwebcites`, `\printindex` |
| demo page balance | jbook.dtx:295-303 | `pg.flush` | `\flushbottom` if twoside, else `\raggedbottom` |
| juraurtl (documented) | doc/jmgerdoc.tex:2804-3213; juraurtl.cls:12-265 | `class.juraurtl` | `\LoadClass{scrartcl}` (42), other options passed to scrartcl (39), own options strafurteil modern draft (35-37) |
| juraovw (documented) | doc/jmgerdoc.tex:3221-3337; juraovw.cls:12-203 | `class.juraovw` | `\LoadClass[headsepline,normalheadings,pointlessnumbers]{scrartcl}` (23), loads array, pifont, fancybox, color, jurabase (14-18) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\ifpdf` switches, `\RequirePackage{ifpdf}` | doc/jmgerdoc.tex:24-29, 77-93, 100-110 | yes | published `ifpdf`; under pdfLaTeX the emitter writes the pdf branch only: class line with `pdftex`, `xcolor`, `hyperref`, `\color` aliases |
| `\ifscreenversion` | 112-120 | yes | fixed false at 113; true would add `geometry[screen,centering]` only |
| colour macros `\preamblecolor` `\codecolor` `\optcolor` `\clicolor` | 101-104 | yes | `\newcommand` aliases of `\color{light-blue}`, `\color{blue}`, `\color{orange}`, `\color{slategray}` |
| name aliases `\jmisc` `\jbook` `\jbase` `\jurtl` `\jovw` `\mysmily`, `\jmdocversion` `\jmdocdate`, `\myref`, `\dft` | 139-144, 38-39, 262, 286 | yes | `\newcommand`/`\def` aliases (`{\sffamily juramisc}\xspace`, `Abschn.~\ref{k} auf S.~\pageref{k}`); `\xspace` becomes an explicit space at each call site |
| `codeverb` `preverb` `cliverb` | 147-170 | yes | fancyvrb declarations, keys read above: `code.verbatim` |
| `syntax` | 174-187 | yes | lrbox + minipage + `\fbox{\parbox}`, width by calc: `box.fancybox`, `box.minipage` |
| `\parmsg` `\notready` `\jmwarn` | 189-194 | yes | `\marginpar` of a `\parbox`, fixed text: `note.marginpar` |
| `\jbopt` `\myclassopt` `\ele` | 196, 205-225 | yes (judgement) | `\settowidth` of a fixed string, one `\ifthenelse` on an empty optional argument that appends "-> S.~\pageref{key}"; no counter, loop or output routine. Each call site (2596-2667, 2297-2585) expands to `\makebox[\widthof{centeredpartsintoc\ }][l]{\color{orange}\sffamily name}`, "(Standard: x)" and optionally `\quad$\rightarrow$ S.~\pageref{key}` |
| `jminfo` `tip` `hinweis` `achtung` `mountteidi` | 228-242, 254-260 | yes | kernel `list` with `\settowidth` lengths: `list.kernel`, `sp.lengths` |
| `\renewenvironment{quote}` | 245-251 | yes | `quote` with `\parskip` 0ex and `\rightmargin=\leftmargin`; `\item\relax` sits inside the `\list` settings argument (247-248), not after it as in the kernel, so the exact effect is not checked here |
| `\let\labelitemi\oldlabelitemi` | 2798 | yes | `\oldlabelitemi` is never defined (the saving line is commented, 2704) and no itemize follows 2798; drop |
| `\antrag`, `forwardandback` and the abbreviation macros shown in the manual | 398-651 (verbatim and tabbing demos only) | yes in the sample | the sample only prints their source in `codeverb` (409-438, 486-551) and a hand-set `tabbing` imitation; nothing calls them. They live in jurabase.sty (published, below) |
| jurabook.cls, juraurtl.cls, juraovw.cls, jurabase.sty, jbgoe.clo, jbstgallen.clo, jbtrier.clo | jurabook.cls:11-3289; juraurtl.cls:12-265; juraovw.cls:12-203; jurabase.sty:12-426; jbgoe.clo:10-49, jbstgallen.clo:10-67, jbtrier.clo:10-57 | not applicable: published | CTAN release of juramisc (ctan.org/pkg/juramisc, v0.91, LPPL 1.2; manifest source `ctan`). The emitter writes `\documentclass[options]{jurabook}` plus `\setjbooktext/length/style` calls; the code is not reduced. If it were zip-local it would be irreducible: `\l@part`/`\l@chapter` leaders (jurabook.cls:2458-2522), runner counters with `\marginpar` (1209-1250), `\@makefntext` redefinition (1046-1064), global resets in `\@emptytitles` (950-977), the `forwardandback` list-restart engine with `fabdepth` and `\if@infablist` (jurabase.sty:74-202), `\nextsec` counter (juraurtl.cls:216-227), `\maketitle` rewrites in the `.clo` files |
| defects in the published code | jurabook.cls:925; juraurtl.cls:45; juraovw.cls:182; jbgoe.clo:45 | n/a, no sample reaches them | `\officaltitle` (sic) is defined, while the README and manual (doc/jmgerdoc.tex:1437) say `\officialtitle`; `\addtokomafont{section}{\bferies}` uses an undefined command; environment `haende` is used but only `hands` is defined (177-179); `\\\` at the end of a tabular row |
| demo aliases `\person` `\fperson` `\Gruenbuch` `\mytextpercent` `\engl` `\immer` `\beutel` | jbook.dtx:253-262, 484-486, 597-624 | yes | `\newcommand` aliases of `\index`, `\foreignlanguage{english}{..}`, `\,\%` and fixed filler text |
| `\GobbleCommaSpace` | jbook.dtx:552 | yes | one-line `\def\GobbleCommaSpace,{\ignorespaces}` used only inside `\index{..|seealso{..}}` arguments (558); index markup under `idx.makeidx` |
| twoside test | jbook.dtx:295-303 | yes | `\if@twoside` resolves from the class default (twoside): `\flushbottom`; oneside would give `\raggedbottom` |
| `\AddTo\bibsgerman{\def\bibidem..}`, `\nextcitenotitle`, `\renewcommand{\jbaensep}` | jbook.dtx:422-435 | yes | documented jurabib name strings and hooks: parameters of `bib.apacite` |
| `filecontents` files `jurabook.ist`, `jdemo.bib` | jbook.dtx:219-224, 449-468 | yes | data files written by the kernel; consumed by the makeindex and bibtex passes the lib already has (`idx.makeidx`, `bib.bibtex-bst`); no outside tool |
| DocStrip batch | doc/jbook/jbook.ins:15-39 | yes, nothing to emit | published `docstrip.tex` run in TeX; produces jbkdemo.tex and jbktmpl.tex, typesets nothing |

## Content-opaque
- none that blocks a way. Data and filler only: the two `jdemo.bib` records (jbook.dtx:449-468), the Brehm paragraph in `\beutel` (597-624), the 21 bibitem texts (doc/jmgerdoc.tex:3351-3371), and the prebuilt manual PDFs (outputs, not read).

## Lib changes
- New ways proposed: none. Judgement calls, no new way: kernel `tabbing` placed in `tbl.tabular` (as 0053); `\href` placed in `meta.hyperref`; jurabook's own runner numbers, decision list and web-citation list recorded under `class.jurabook`, with the vocabulary under Class setting; `class.juraurtl`, `class.juraovw` and `class.jurabook` written as class ways without proposal. jurabase.sty is a published package with no lib way and is not proposed, because no sample loads it directly.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
