no

# 0331-egel-uek-latex-thesis-class: UEK thesis class (Cracow University of Economics)

- Unverified: read from the source, not compiled.
- Source: Source/0331-egel-uek-latex-thesis-class/ (origin: https://codeload.github.com/egel/uek-latex-thesis-class/zip/refs/heads/master; licence: MIT, LICENSE:1-3; the style file's header text refers to LPPL, uekthesis.sty:6-8)
- Kind: thesis
- Lib: v3
- Engine: pdfLaTeX-compatible (hyperref `pdftex` driver, uekthesis.cls:104; biber is the standard biblatex backend, not a blocker)
- Look carried by: zip-local (the look is set in uekthesis.cls and uekthesis.sty over kernel `report`; the zip has no sample preamble)
- Class origin: zip-local (ctan.org/pkg/uekthesis returned 404; a single author's GitHub master archive, not a publisher kit or a release)
- Main file: none (no .tex in the zip; the only usage example is README.md:45; variants: uekthesis-archival.cls, uekthesis-archival.sty)
- Read: main partly (no sample exists; README read in full), zip-local classes and styles all (uekthesis.cls and uekthesis.sty read line by line; the two `-archival` files read as a full diff against them, differences cited below)

## Verdict
no. Almost everything reduces to published ways: the class is `\LoadClass{report}` plus `titlesec`, `fancyhdr`, `tocloft`, `geometry`, a hand-laid title page and option-driven switches. Two pieces of zip-local macro logic have no lib way and cannot be written with published commands alone: the stateful first-letter-lowercasing cross-reference macros (`\lnameref`, `\fnameref`, `\nmu`) and the list-of-listings hack that gobbles `\newcounter` under `\globaldefs`. Because of these two, an emitter would have to copy zip-local macro logic.

## Blockers
- `BESPOKE/class` `\lnameref`, `\fnameref` and helper `\nmu`: group-local `\let\nmu\MakeLowercase` (and a self-redefining `\def\nmu{\let\nmu\MakeLowercase}`) so that `\nameref` lowercases only the first letter, or every letter after the first `\nmu`, of a heading; headings must carry `\nmu` markup in their titles for it to work (uekthesis.sty:53-65, same lines in uekthesis-archival.sty)
- `BESPOKE/class` list of listings and list of algorithms built with `\newlistof` inside `\begingroup\let\newcounter\@gobble\let\setcounter\@gobbletwo \globaldefs\@ne \let\c@loldepth\@ne ... \endgroup`, then `\let\l@lstlisting\l@listings` (uekthesis.sty:276-301; archival adds font commands inside the title argument, uekthesis-archival.sty:279). The `\newlistof` and `\cftsetindents` calls reduce to `toc.tocloft`, but the guard that neutralises counter creation is kernel-internal code copied from a StackExchange answer (comment at uekthesis.sty:272); it is not shown that a plain `\newlistof` gives the same result, so it is treated as irreducible

## Class setting
- Class: `class.report` (loaded by the zip-local class) options: `a4paper,12pt,oneside,openright` (uekthesis.cls:18); the archival variant asks for `9pt` (uekthesis-archival.cls:18), which is not one of kernel report's size options (10pt, 11pt, 12pt), so its effect is not established by reading. Unknown options are passed on to `report` (uekthesis.cls:17).
- Class-native vocabulary used (zip-local, not published): `\globalFullAuthor` `\globalShortAuthor` `\globalFullTitle` `\globalShortTitle` `\globalFullUniversity` `\globalShortUniversity` `\globalDepartment` `\globalDegreeprogramme` `\globalThesisType` `\globalUnderTheSupervisonOf` `\globalSupervisor` `\globalAcknowledgements` `\globalFileVersion` `\globalIndexNumber` `\globalCity` `\globalYear` `\globalKeywords` (uekthesis.cls:22-38), the `\print*` aliases (cls:41-56), `\titlepages` (cls:294); options `male` `female` `twoside` `indexNumber` `fileVersion` `authorStatement` `keywords` `thanks` (README.md:45, cls:126-232). `\globalDegreeprogramme` is stored (cls:33) but never printed by `\titlepages`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | uekthesis.cls:18 | `class.report` | a4paper, 12pt, oneside, openright |
| paper size | uekthesis.cls:18 | `page.class-options` | a4paper |
| page geometry | uekthesis.cls:93, 128, 149; uekthesis-archival.cls:128 | `page.geometry` | oneside: lmargin=30mm, rmargin=20mm, tmargin=30mm, bmargin=30mm, foot=10mm, head=10mm; twoside: twoside=true, lmargin=3cm, rmargin=3cm, bindingoffset=0cm; archival: lmargin=15mm, rmargin=10mm, tmargin=20mm, bmargin=18mm |
| page style selection | uekthesis.cls:338 | `hf.pagestyle-kernel` | `\pagestyle{fancy}` |
| running head and foot | uekthesis.cls:96, 132-143, 151-158, 339-343 | `hf.fancyhdr` | oneside: head L `\small\textit\rightmark`, head R `\bfseries\thepage`, foot RO `\small` author + `\textit` short title; `plain` style emptied, rules 0pt; twoside: head RE,LO `\textsl{\small\rightmark}`, head RO,LE `\bfseries\thepage`, foot LE,RO as oneside; `\chaptermark` -> `\markboth{\thechapter.\ #1}{}`, `\sectionmark` -> `\markright{\thesection.\ #1}`; headrulewidth=footrulewidth=0.2pt |
| line spacing | uekthesis.cls:243; uekthesis-archival.cls:229 | `sp.linespread` | 1.3; archival 1.0 |
| space after period | uekthesis.cls:345 | `sp.frenchspacing` | `\frenchspacing` |
| line breaking | uekthesis.cls:346 | `sp.hyphenat` | `\sloppy` |
| penalties | uekthesis.cls:347-352 | `sp.penalties` | widow 9999, club 9996, broken 4991, predisplay 10000, postdisplay 1549, displaywidow 1602 |
| flush bottom | uekthesis.cls:353 | `pg.flush` | `\flushbottom` |
| first-paragraph indent | uekthesis.cls:110, 120 | `sp.indentfirst` | (load only; loaded twice) |
| encodings | uekthesis.cls:88, 90, 121 | `font.fontenc-t1` | inputenc utf8, fontenc T1, textcomp |
| text fonts | uekthesis.cls:91, 105, 106 | `font.mathptmx`, `font.lmodern`, `font.mono` | `times`, `lmodern`, `courier` loaded in that order; which family each default ends on is not established without compiling |
| symbol glyphs | uekthesis.cls:121 | `font.icons` | `gensymb` (`\degree` etc.) |
| colour | uekthesis.cls:94-95 | `color.color`, `color.xcolor` | `color[usenames]`, `xcolor[dvipsnames]` |
| colour macros | uekthesis.sty:214-219 | `color.xcolor`, `box.fancybox` | `\red` `\yellow` `\green` (text colour RedOrange, Dandelion, LimeGreen), `\RED` `\YELLOW` `\GREEN` (`\colorbox`) |
| language | uekthesis.cls:108-109 | `lang.babel` | `babel[polish]` + `polski` |
| quotes | uekthesis.cls:89; uekthesis.sty:80 | `lang.csquotes` | autostyle=true; `\DeclareQuoteAlias{croatian}{polish}` |
| caption and list names | uekthesis.sty:240-248 | `lang.babel` | `\addto\captionspolish`: figurename Rysunek, tablename Tabela, listtablename Spis tabel, lstlistlistingname Spis kodów źródłowych |
| PDF metadata and links | uekthesis.cls:61-84, 104 | `meta.hyperref` | `hyperref[pdftex]`; in `\AtBeginDocument`: unicode, pdfencoding, pdftoolbar, pdfmenubar, pdffitwindow=false, pdfstartview=FitH, pdftitle/author/subject/creator/producer/keywords from the `\print*` values, pdfnewwindow, linktoc=page, colorlinks, linkcolor=Maroon, citecolor=PineGreen, filecolor=Magenta, urlcolor=MidnightBlue |
| urls | uekthesis.cls:97 | `meta.url` | `url[hyphens]` |
| cross-reference by name | uekthesis.cls:111 | `xref.hyperref` | `nameref` (`\nameref`); the lowercasing variants are BESPOKE (blocker 1) |
| title page | uekthesis.cls:294-325 | `front.titlepage-env` | `\titlepage` hand-laid: `center` with `\sffamily\LARGE\scshape` university, `\large\scshape` department, logo, `\LARGE` author, optional index number, `\LARGE\bfseries` title, `\large` thesis type + optional version; supervisor block; `\vfill`; `\centerline{\large city year}`; vspace 2mm/15mm/10mm |
| logo | uekthesis.cls:305 | `fig.graphicx` | `\includegraphics[width=7cm]{lib/university-logo}` (png shipped; path assumes the class folder is named `lib`) |
| title-page spacing, supervisor block | uekthesis.cls:264-269, 297-323 | `sp.manual-space`, `sp.ragged` | `\vspace*`, `\vfill`, `\quad`; `flushright` |
| title-page fonts | uekthesis.cls:299-315 | `font.size-commands`, `mark.kernel` | `\LARGE` `\large`, `\scshape` `\sffamily` `\bfseries` |
| author statement page | uekthesis.cls:179-207, 327-330 | `front.dedication` | `\titlepage`; vspace 20mm; `\noindent\textit{\large ...}` fixed Polish text with male/female verb forms; `\hfill` + dotted line; option `authorStatement` |
| keywords line | uekthesis.cls:212-216, 328 | `abs.keywords` | `\noindent\large Słowa kluczowe:` + `\textit` keywords; option `keywords` |
| acknowledgements page | uekthesis.cls:220-232, 332 | `front.dedication` | `\titlepage`, `\vspace*{15cm}\vfill`, `flushright` + `minipage` 10cm, `\large\textit`; option `thanks` |
| minipage in thanks | uekthesis.cls:225 | `box.minipage` | width 10cm |
| first body page number | uekthesis.cls:238-239, 189, 204, 229, 324, 334 | `pgnum.pagenumbering`, `num.counters` | `\setcounter{page}{\value{introPageCounter}}`; counter starts at 1, +1 per front page (reduces to an emit-time constant) |
| headings | uekthesis.cls:275-287; uekthesis-archival.cls:259-273 | `head.titlesec` | `\titleformat` block, `\bfseries` at `\Large`/`\large`/`\normalsize`, `\filright`, number + ". ", sep 0ex; `\titlespacing` chapter 0pt/17mm/19mm, section 0/8mm plus 0 minus 1mm/4mm plus 0 minus 1mm, subsection 0/6mm/2.5mm, subsubsection 0/3mm/1.5mm; archival: chapter `\bfseries\large` with `\MakeUppercase`, sections `\MakeLowercase`, all spacing 6pt |
| contents and lists | uekthesis.cls:99, 358-366; uekthesis-archival.cls:99, 343-365; uekthesis.sty:230 | `toc.tocloft` | leaders `\cftdotfill{\cftdot}` for chap/sec/subsec, `aftersnum` ".", cftparskip 2pt (archival 2mm), cftbeforechapskip 0mm, before/after toc title skip 20mm/19mm (archival 0mm), cftsecnumwidth 10mm; archival: `tocloft[titles]`, `\cftchappagefont`, lof/lot title fonts `\bfseries\large\MakeUppercase` |
| list-of-listings entries | uekthesis.sty:276-288 | `toc.tocloft` | `\newlistof{listings}{lol}{...}`, `\cftsetindents{listings}{1.5em}{2.3em}`; guard is blocker 2 |
| list-of-algorithms entries | uekthesis.sty:292-305 | `toc.tocloft` | `\newlistof{algorithms}{loa}{\listalgorithmname}`, `\cftsetindents{algorithms}{1.5em}{2.3em}`; same guard (blocker 2); the `algorithm` package itself is not loaded here |
| spacing in the lists | uekthesis.sty:46-47, 282 | `toc.kernel` | `\addtocontents{lol}{\protect\addvspace{10pt}}` before each chapter and at begin of document |
| bullet list | uekthesis.cls:247 | `list.kernel` | `\labelitemi` = "--" |
| list packages | uekthesis.cls:112-113 | `list.enumerate-pkg`, `list.enumitem` | load only |
| continuous footnotes | uekthesis.sty:20, 235 | `num.counters` | `chngcntr`, `\counterwithout{footnote}{chapter}` |
| maths | uekthesis.cls:100-102 | `math.amsmath`, `math.amssymb` | `amsmath`, `amsfonts`, `amssymb` |
| numbered cases | uekthesis.cls:122 | `math.physics` | `cases` (`numcases`); filed with the lib's maths add-on packages, as `empheq`/`nccmath` |
| theorem-like statements | uekthesis.cls:103; uekthesis.sty:253-266 | `thm.amsthm` | plain: `thm` "Twierdzenie" within section, `lem` shares thm "Lemat", `prop` shares thm "Założenie", `cor*` "Wniosek"; definition: `defn` shares thm "Definicja", `conj` "Przypuszczenie" and `exmp` "Przykład" within section; remark: `rem*` "Spostrzeżenie", `note*` "Notka" |
| floats and captions | uekthesis.cls:92; uekthesis.sty:35-37, 94-101 | `fig.graphicx`, `fig.subcaption`, `cap.caption` | `caption[font=small, format=hang, labelformat=simple, justification=justified, singlelinecheck=false, labelsep=colon]` (the package is also loaded without options at sty:36) |
| caption plus source | uekthesis.sty:70-76 | `cap.kernel`, `cap.caption` | `\captionsource{caption}{source}`: `\caption[{#1}]{#1\\\hspace{\linewidth}Źródło: #2}` (alias, reducible) |
| tables | uekthesis.cls:114-118 | `tbl.multirow`, `tbl.longtable`, `tbl.tabularx`, `tbl.nicematrix`, `tbl.tabular` | `multirow`, `longtable`, `tabularx`, `tabu`, `hhline` (load only; `hhline` extends the kernel `\hline`/`\cline` rules of `tabular`, tools bundle like `array`) |
| code | uekthesis.cls:119; uekthesis.sty:124-209 | `code.listings` | `\lstset`: footnotesize ttfamily, frame=tb, numbers=left, breaklines, tabsize=2, captionpos=t, style=LaTeX2e, Polish `literate` table; `\lstdefinelanguage{Biblatex}` (sty:124-141), `\lstdefinestyle{LaTeX2e}` (145-153), `\lstdefinestyle{Bash}` (157-167) |
| framed output box | uekthesis.sty:24-31 | `box.mdframed` | `mdframed[framemethod=tikz]`; `\newmdenv[skipabove=0.2cm, skipbelow=0, nobreak=true]{outputbox}` |
| bibliography | uekthesis.sty:81-90 | `bib.biblatex-biber` | style=numeric, sorting=nty, language=polish, isbn=true, firstinits=true, abbreviate=true, autolang=hyphen, backend=biber; build order in README.md:159-162 |
| to-do notes | uekthesis.cls:123 | `note.todonotes` | load only |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\global*` setters and `\print*` aliases | uekthesis.cls:22-56 | yes | `\gdef` string stores; the emitter writes the literal text where `\print*` is used and in `\hypersetup` (`meta.hyperref`) |
| option set `pdflatex` `oneside` `twoside` `male` `female` `authorStatement` `keywords` `thanks` `indexNumber` `fileVersion`, `\ExecuteOptions` | uekthesis.cls:16-17, 126-232, 259-260, 336 | yes | each option picks a geometry and header set or switches a body block on; the emitter decides at emit time. `authorStatement` is declared inside `male`/`female` (cls:180, 195), no runtime need. `\ifpdflatex` is declared (cls:13) and never read (dead). Option routing order (cls:18 against cls:336) is not established without compiling |
| `\thesisHeaders` | uekthesis.cls:132-158, 343 | yes | `hf.fancyhdr` calls as in the map |
| `\titlepages` | uekthesis.cls:294-335 | yes | `front.titlepage-env`, `front.dedication`, `abs.keywords` as in the map |
| `introPageCounter` | uekthesis.cls:238-239, 334; author TODO at cls:211 | yes | the counter is an emit-time constant; emit `\setcounter{page}{N}` with the real number of front pages (the TODO says the class miscounts for the statement page) |
| `\titleformat` and `\titlespacing` calls, tocloft `\renewcommand`s | uekthesis.cls:275-287, 358-366 | yes | `head.titlesec`, `toc.tocloft` with the values above |
| `outputbox`, `\captionsource`, colour macros | uekthesis.sty:27-31, 70-76, 214-219 | yes | aliases and one `\newmdenv`, as in the map |
| `\lstdefinelanguage`, `\lstdefinestyle`, `\lstset` | uekthesis.sty:124-209 | yes | `code.listings`; the Biblatex language hard-codes the demo's cite keys `Kun` `Popper84` `man:` `url:` (sty:137-140), which is content |
| `\let\Chapter\chapter \def\chapter{...\Chapter}` | uekthesis.sty:46-47 | yes | emit `\addtocontents{lol}{\protect\addvspace{10pt}}` before each `\chapter` (`toc.kernel`) |
| `\def\l@lstlisting` with `\@dottedtocline` | uekthesis.sty:43 | yes | superseded by `\let\l@lstlisting\l@listings` (sty:281) and `\cftsetindents` (sty:288) |
| `\lnameref`, `\fnameref`, `\nmu` | uekthesis.sty:53-65 | no | none: token-level stateful case change that depends on `\nmu` markup in heading text (blocker 1) |
| `\newlistof` guard with `\globaldefs`, `\let\newcounter\@gobble` | uekthesis.sty:276-305 | no (unestablished) | `\newlistof` + `\cftsetindents` reduce to `toc.tocloft`; the guard is copied kernel-internal code (blocker 2) |
| `xpatch` | uekthesis.cls:107 | n/a | loaded "for biblatex settings", but every `\xpatchbibdriver` use is commented out (uekthesis.sty:316-335); no printed effect, no way needed |

## Content-opaque
none (the zip has no sample document; `university-logo.png` is a shipped image asset used at uekthesis.cls:305, not artwork drawn in TeX)

## Lib changes
- New ways proposed: none. Considered and not proposed: `hhline` (kept under `tbl.tabular`, it only extends `\hline`/`\cline`), `cases` (kept under `math.physics`), `xpatch` (no printed effect).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
