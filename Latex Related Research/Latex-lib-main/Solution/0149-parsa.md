yes

# 0149-parsa: parsa (Persian thesis and dissertation forms, XeLaTeX)

- Unverified: read from the source, not compiled.
- Source: Source/0149-parsa/ (origin: https://mirrors.ctan.org/macros/xetex/latex/parsa.zip; licence: LPPL 1.3c, README.md:24-27)
- Kind: thesis
- Lib: v3 (the snapshot read)
- Engine: needs XeLaTeX (`xepersian` with Persian system fonts, parsa-doc.tex:68-71; README.md:4 and parsa.sty:30 call it a XeLaTeX package)
- Look carried by: mixed (the doc's own page setup, headers and fonts sit in the preamble, parsa-doc.tex:4-80; the thesis forms sit in `parsa.sty`, a published CTAN package, not zip-local; the main sample does not load it, only its verbatim usage sample does, parsa-doc.tex:413)
- Class origin: tex-distribution-unbundled (`article` at parsa-doc.tex:11, `book` in the usage sample at :411; neither is in the zip. `parsa.sty` is a CTAN and TeX Live package, checked once at ctan.org/pkg/parsa: v1.3, LPPL 1.3c, so it is not zip-local)
- Main file: parsa-doc.tex (other samples: the usage sample inside a `verbatim` block, parsa-doc.tex:410-578; no other `.tex`)
- Read: main yes, zip-local classes and styles all (`parsa.sty` 655 of 655 lines; `parsa-doc.pdf` is the compiled doc and was not opened)

## Verdict
yes. The doc's preamble is only published packages with option values. `parsa.sty` is itself a published CTAN package, so it is one class-like way (`class.parsa`), as the lib v3 log merged other one-institution cover and thesis-style packages into class ways. Read the strict way instead (as if `parsa.sty` were zip-local), every macro is a string holder, a fixed-text form made of kernel boxes, tabulars and lists, or a `\cleardoublepage` redefinition that equals `emptypage`, so it still reduces and there is no irreducible code and no artwork. The one way the lib lacks is the Persian language package `xepersian`, proposed below.

## Blockers
none

## Class setting
- Class: `class.article` options: `12pt`, `twoside`, `openany`, `notitlepage`, `fleqn` (parsa-doc.tex:4-11). The usage sample uses `class.book` options `a4paper,12pt,twoside` (parsa-doc.tex:411).
- Class-native vocabulary used: none from `article` beyond `\section` `\subsection` `\tableofcontents`. The usage sample uses `book`'s `\frontmatter` `\mainmatter` `\backmatter` (commented out, :502, :545, :555), `\chapter*` (inside `parsa.sty:639`) and `\cleardoublepage`.
- Class-like package: `class.parsa` (parsa.sty), loaded as `\usepackage[thesis]{parsa}` (the usage sample has no option, :413; the options are parsa.sty:56, 62). Native vocabulary the usage sample uses (parsa-doc.tex:424-491 comments, :505-575 body): info commands with a Persian and a Latin argument `\Institute` `\InstituteLogo{}{}[w][h]` `\Faculty` `\Department` `\StudentName` `\StudentMajor` `\StudentMinor` `\StudentDegree` `\StudentID` `\StudentNumber` `\StudentEMAIL` `\ParsaTitle` `\ParsaTarget` `\ParsaCompilationDate` `\ParsaExamDate`, committee commands `\<Role>Name|Title|Affiliation|ID|EMAIL` for roles `Supervisor` `SecondSupervisor` `Cosupervisor` `SecondCosupervisor` `FirstExaminer` `SecondExaminer` `ThirdExaminer`, and `\RepresentativeName|ID|EMAIL`; page commands `\titlepageParsi` `\titlepageLatin` `\ParsaPicture{img}` `\ParsaCredit` `\ExaminationReportPa` `\ExaminationReportLa` `\ParsaCopyleft` `\ParsaDedicate{text}`; environments `ParsaAbstractParsi` `ParsaAbstractLatin` `ParsaAcknowledgment` `ParsaCV`; user-defined font `\ParsaHeaderFont` (parsa-doc.tex:416, used at parsa.sty:83, 85).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | parsa-doc.tex:4-11 | `class.article` | 12pt, twoside, openany (a `book` option, noted at :7; `article` has no chapters), notitlepage, fleqn |
| paper and size options | parsa-doc.tex:5-6; usage sample :411 | `page.class-options` | 12pt, twoside; the usage sample adds a4paper |
| page geometry | parsa-doc.tex:16-27 | `page.geometry` | papersize={210mm,297mm}, layoutsize={210mm,297mm}, layouthoffset=0mm, layoutvoffset=0mm, top=24mm, includehead, bottom=32mm, heightrounded, bindingoffset=10mm, inner=21mm, outer=31mm, marginparwidth=0mm, marginparsep=0mm (`showcrop`, `columnsep`, `showframe` are comments) |
| header and footer (doc) | parsa-doc.tex:32-36, 39-40 | `hf.fancyhdr` | `\fancypagestyle{plain}`: `\fancyhf{}`, `\fancyfoot[OL,ER]{\HeaderFont\thepage}`, `\headrulewidth` 0pt. `headings`: `\fancyhead[OL,ER]` page number, `[OR]` `\rightmark`, `[EL]` `\leftmark`, `\headrulewidth` 0.3pt. `\addtolength{\headwidth}` by `\marginparwidth` and `\marginparsep` |
| header and footer (package) | parsa.sty:73, 83-85 | `hf.fancyhdr` | the same two page styles with `\ParsaHeaderFont` in place of `\HeaderFont`; the package loads `fancyhdr` itself |
| page style switching | parsa-doc.tex:84; usage sample :503, :546, :556 | `hf.pagestyle-kernel` | `\pagestyle{plain}`, `{empty}`, `{headings}` (the last two name the package's styles) |
| blank pages before recto starts | parsa.sty:88-98 | `pg.emptypage` and `pg.break` | `\cleardoublepage` redefined so an inserted blank page gets `\thispagestyle{empty}`; the sample calls `\cleardoublepage` and `\newpage` (parsa-doc.tex:506-574) |
| language and direction | parsa-doc.tex:68; usage sample :414 | `lang.polyglossia` | `\usepackage[localise,fontsloadable]{xepersian}`; the usage sample uses `[fontsloadable]`; `parsa.sty` does not load it but calls its `\lr` (parsa.sty:174) and `latin` environment (parsa.sty:446, 485) |
| fonts | parsa-doc.tex:69-71; usage sample :415-416 | `lang.polyglossia` | `\settextfont{XB Zar}`, `\defpersianfont\HeaderFont{XB Kayhan}`, `\setlatintextfont{Times New Roman}` (xepersian font commands over fontspec; considered `font.fontspec`). The three fonts are not shipped: missing assets |
| section number separator | parsa-doc.tex:80 | `lang.polyglossia` | `\SepMark{-}`, described by the sample's own comment as the heading number separator |
| Persian-named aliases | parsa-doc.tex:85-88, 98, 101, 105, 109 | `lang.polyglossia` | with `localise`, `\عنوان` `\نویسنده` `\تاریخ` `\عنوان‌ساز` stand where `\title` `\author` `\date` `\maketitle` do; `\موکد` is an emphasis, `\زیرنویس` a footnote, `\رجوع` a reference, `\متن‌لاتین` an LTR span, `\متن‌تایپ` a typewriter span (readings from use; the xepersian source is not in the zip and was not read) |
| title block | parsa-doc.tex:85-88 | `front.maketitle` | title, author, date through the aliases above, under `notitlepage` |
| author note | parsa-doc.tex:86 | `front.thanks` | `\thanks{\href{...}{\lr{...}}}` |
| link | parsa-doc.tex:56, 86 | `meta.hyperref` and `xref.hyperref` | `\usepackage[pagebackref=false]{hyperref}`; `\href` |
| maths | parsa-doc.tex:45-47 | `math.amsmath`, `math.mathtools`, `math.amssymb` | `amsmath`; `mhsetup,mathtools`; `amsfonts,amssymb,amsbsy,amsopn,amstext` |
| theorem package | parsa-doc.tex:46 | `thm.amsthm` | loaded; no `\newtheorem` or `\theoremstyle` in the sample |
| equation numbering | parsa-doc.tex:9, 79 | `math.eqnumber` and `num.counters` | class option `fleqn`; `\numberwithin{equation}{section}` |
| section and toc depth | parsa-doc.tex:77-78 | `num.secnumdepth` | secnumdepth=5, tocdepth=2 |
| colour | parsa-doc.tex:48-49 | `color.color` and `color.xcolor` | `\usepackage{color}`; `\usepackage[usenames,dvpinames,table]{xcolor}` (the option reads `dvpinames` at :49, copied as written); `table` loads colortbl, `tbl.colortbl`, unused in the body |
| graphics | parsa-doc.tex:50-51 | `fig.graphicx` | `graphics`, `graphicx`; no image in the main body |
| float and box adjust | parsa-doc.tex:52-53 | `fig.float` and `fig.adjustbox` | `float` (`[H]` used at :369); `adjustbox` (`pagecenter` used at :369) |
| captions | parsa-doc.tex:54 | `cap.caption` | `hypcap=true`; loaded, the sample has no `\caption` |
| spacing | parsa-doc.tex:55, 76 | `sp.setspace` | `setspace` loaded, unused; `\linespread{1.33}` is a comment (`sp.linespread`, not active) |
| footnotes | parsa-doc.tex:57, 101, 109, 113 | `fn.footmisc` and `fn.kernel` | `footmisc[perpage]`; footnotes through the `\زیرنویس` alias (`lang.polyglossia`) |
| long tables | parsa-doc.tex:58 | `tbl.longtable` | loaded, unused |
| margin notes | parsa-doc.tex:59 | `note.marginnote` | `marginnote[fulladjust]`; loaded, unused |
| centred paragraph block | parsa-doc.tex:89-94 | `box.minipage` and `sp.ragged` | `center` around a `minipage` of `0.67\textwidth` |
| table of contents | parsa-doc.tex:95; usage sample :535-539 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables` |
| headings | parsa-doc.tex:96-97, 100, 120 | `head.kernel` and `toc.kernel` | `\section*` with `\addcontentsline{toc}{section}`, `\section`, `\subsection` |
| inline marks | parsa-doc.tex:98, 128-130 | `mark.kernel` and `font.size-commands` | emphasis through the alias (`lang.polyglossia`); `\small` |
| cross-reference | parsa-doc.tex:105, 171 | `xref.kernel` | `\label{ParsaInf}` and the `\رجوع` alias (`lang.polyglossia`) |
| verbatim and LTR blocks | parsa-doc.tex:102-104, 384-399, 410-578 | `code.verbatim` | `verbatim` inside `latin` (`lang.polyglossia`) and `minipage` of `0.48\textwidth` |
| table, no caption | parsa-doc.tex:369-380 | `fig.float`, `fig.adjustbox`, `tbl.tabular` | `table[H]`, `\adjustbox{pagecenter}`, `tabular{lr}` with `\lr{\texttt{...}}` cells (`lang.polyglossia`) |
| manual space | parsa-doc.tex:400 | `sp.manual-space` | `\vspace{10mm}` |
| package options | parsa.sty:54-68 | `class.parsa` | `thesis` or `dissertation` set four strings (target text and type word, Persian and Latin) |
| packages the style loads | parsa.sty:72-77 | `hf.fancyhdr`, `fig.graphicx`, `tbl.multirow`, `fig.float`, `fig.adjustbox` | `xparse` is the mechanism of `\NewDocumentCommand`; no options anywhere |
| institute and student info | parsa.sty:103-140 | `front.class-native` | `\InstituteLogo{pa}{la}[3cm][3cm]` (files, `\includegraphics[width,height]`, 1.6cm small copy), `\Institute` `\Faculty` `\Department` `\StudentName` `\StudentMajor` `\StudentMinor` `\StudentDegree` `\StudentID` `\StudentNumber` `\StudentEMAIL`: strings, default `~` |
| document info | parsa.sty:147-156 | `front.class-native` | `\ParsaTitle` `\ParsaTarget` `\ParsaCompilationDate` `\ParsaExamDate` |
| committee info | parsa.sty:163-410 | `front.class-native` | per role name, title, affiliation, id, email strings; a name command also stores a signature block (see Bespoke code) |
| Persian title page | parsa.sty:417-438 | `front.class-native` | `center` with `\\[0.25cm]`, `\\[0.5cm]`, `\\[1cm]` gaps, `{\Large\textbf ...}`, `\vfill`, logo (reduces to `front.titlepage-env`, `sp.manual-space`, `font.size-commands`, `fig.graphicx`) |
| Latin title page | parsa.sty:446-467 | `front.class-native` | the same inside `latin` (`lang.polyglossia`), `\emph` target line |
| abstracts | parsa.sty:474-477, 484-489 | `abs.class-native` | `ParsaAbstractParsi`: `\section*{چکیده}`, `\addcontentsline{toc}{chapter}`, body, `\vspace*{\fill}`; `ParsaAbstractLatin`: the same in `latin` (`lang.polyglossia`), `\section*{Abstract}` (reduces to `head.kernel`, `toc.kernel`, `sp.manual-space`) |
| picture page | parsa.sty:497 | `front.class-native` | `\newpage`, `\vspace*{\fill}`, `\includegraphics[width=\textwidth]{img}` (reduces to `fig.graphicx`, `pg.break`, `sp.manual-space`) |
| originality declaration | parsa.sty:505-520 | `front.class-native` | `minipage` of `1\textwidth`, `\section*{\centering ...}` twice, six-item `enumerate`, bold fields, `\vspace{1.5cm}` (reduces to `box.minipage`, `head.kernel`, `list.kernel`, `mark.kernel`, `sp.manual-space`) |
| examination report pages | parsa.sty:527-559, 566-598 | `front.class-native` | `table[H]` with `\adjustbox{pagecenter}` and a `tabular{ccc}` using `\multirow{3}{*}`; `minipage` blocks; `flushright`; `\bigcirc` grade marks; `\hrulefill` (reduces to `fig.float`, `fig.adjustbox`, `tbl.tabular`, `tbl.multirow`, `box.minipage`, `sp.ragged`, `sp.rule`, `math.kernel`) |
| usage rights page | parsa.sty:606-617 | `front.class-native` | `center` and `minipage` of `0.67\textwidth`, `\section*{\centering ...}`, `itemize` with `\item[$\bigcirc$]` (reduces to `box.minipage`, `head.kernel`, `list.kernel`) |
| dedication | parsa.sty:624-631 | `front.dedication` | `\vspace*{\fill}`, `center`, `\begin{Large}`, `\vspace*{\fill}` |
| acknowledgement | parsa.sty:638-641 | `front.dedication` and `head.kernel` | `\chapter*{\centering ...}`, `\addcontentsline{toc}{chapter}`, `\thispagestyle{empty}`; needs a class with chapters (the doc tells the user to choose `book`, parsa-doc.tex:101) |
| CV page | parsa.sty:648-655 | `front.class-native` | `\newpage`, `\vspace*{\fill}`, `center` around a `minipage` of `0.67\textwidth` (reduces to `box.minipage`, `sp.manual-space`, `pg.break`) |
| usage-sample order | parsa-doc.tex:497-575 | `front.class-native` | title page, abstract, picture, credit, report, copyleft, dedication, acknowledgement, toc and lists, then `\pagestyle{headings}`, back matter CV, Latin report, Latin abstract, Latin title page |

Not present in either sample: bibliography, index, glossary, theorem statements, algorithms, code listings, figures with captions, equations other than inline.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `parsa.sty` as a whole | parsa.sty:1-655 | not bespoke | published (CTAN `/macros/xetex/latex/parsa`, parsa.sty:14; TeX Live; LPPL 1.3c, parsa.sty:7-12). The emitter writes `\usepackage[thesis]{parsa}`, the info commands and the page commands |
| `\cleardoublepage` redefinition, `\blankpage` | parsa.sty:88-98 | reducible (strict reading) | `pg.emptypage` (blank pages get an empty page style) plus `pg.break` `\cleardoublepage`; the `\vspace*{\fill}{\centering ~\par}` filler prints only a space. Uses `\if@twoside`, `\c@page`, `\if@twocolumn` as the kernel's own `\cleardoublepage` does |
| data holders, `\newcommand` and `\renewcommand` pairs | parsa.sty:54-55, 103-410 | reducible (strict reading) | string assignments; the emitter prints the final values. No conditional tests a value |
| role captions set by call order | parsa.sty:117, 171, 202, 234, 266 | reducible (strict reading) | `\captiontwoPa` becomes `استادان راهنما` after `\SecondSupervisorName` (and `\captionthreePa` likewise): the emitter picks singular or plural when it writes the title page |
| signature blocks in `\<Role>Name` | parsa.sty:171-180, 202-211, 234-243, 266-275, 298-307, 330-339, 362-371, 391-402 | reducible (strict reading) | `tbl.tabular` with `p{0.17\textwidth}` and `\multicolumn{1}{c}`, `sp.rule` `\hrulefill`, `mark.kernel`, `\\[0.5mm]` (`sp.manual-space`) |
| `\NewDocumentCommand` and `\NewDocumentEnvironment` (`+b`) | parsa.sty:104, 474, 484, 638, 648 | reducible (strict reading) | kernel xparse definitions; each environment only wraps the body with the commands listed in the component map |
| title, form and page macros | parsa.sty:417-617 | reducible (strict reading) | fixed Persian and English text in kernel boxes, tabulars and lists, see the rows above; no counters, no output routine |
| zip-local macros in the doc | parsa-doc.tex | none | the doc defines no macro; it redefines the page styles `plain` and `headings` (:34, :36) and one font `\HeaderFont` (:70) |

Latent defects, no effect on the verdict: `\RepresentativeTitle` and `\RepresentativeAffiliation` renew `\RepresentativeTitlePa` and `\RepresentativeAffiliationPa`, which are never created (parsa.sty:404, 406); the doc's `headings` style uses `\ParsaHeaderFont` while the doc defines `\HeaderFont` (parsa-doc.tex:36, 70); the usage sample comment `%StudentEMAIL{}` lacks its backslash (parsa-doc.tex:437).

## Content-opaque
- Institute logos, `\InstituteLogo` files (parsa.sty:104) and the picture file of `\ParsaPicture{picture}` (parsa-doc.tex:514): images the author ships, not part of the zip.
- Persian and English form wording (parsa.sty:507-519, 547-548, 586-587, 608-613): text content.
- The Persian fonts XB Zar, XB Kayhan and Times New Roman (parsa-doc.tex:69-71): missing assets, to be shipped.
- No TikZ, PGF or `picture` anywhere; no `ART`.

## Lib changes
- New ways proposed: `lang.polyglossia`, the `xepersian` package (CTAN and TeX Live, LPPL 1.3c; checked once at ctan.org/pkg/xepersian: typesets Persian and English with XeTeX or LuaTeX), engine xe/lua. One line: `\usepackage[localise,fontsloadable]{xepersian}`, font commands `\settextfont` `\setlatintextfont` `\defpersianfont`, the `\lr` span and `latin` environment, separator `\SepMark`, and Persian-named aliases of kernel commands. W1: published on CTAN and in TeX Live. W2: option values, font names and a separator string; no code is edited. W3: serves any Persian or mixed Persian and Latin document, not one template. W4: a preamble package line plus font declarations, and body wrappers around a node's content. Considered: `lang.bidi` (the `bidi` package: direction switches only, no language, font or alias layer, and the zip does not load it) and `lang.polyglossia` (a different package); a consolidator may fold it into `lang.bidi` or `lang.polyglossia` with the package as the parameter, as `lang.babel` went into `lang.babel`. Section: lang, meta, xref.
- `class.article`, `class.book` and `class.parsa` are class ways and need no proposal; the vocabulary of `class.parsa` is under Class setting.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
