no

# 0840-achinrichs-latex-templates: ACHinrichs/LaTeX-templates (homeworkassignment class, cheatsheet class, beamer themes polynom and projektion)

- Unverified: read from the source, not compiled.
- Source: Source/0840-achinrichs-latex-templates/ (origin: https://codeload.github.com/ACHinrichs/LaTeX-templates/zip/refs/heads/master; licence: MIT in the file headers, homeworkassignment/homeworkassignment.cls:14-38; the manifest says NOASSERTION)
- Kind: misc (a collection: an assignment class, a cheat-sheet class, two 16:9 beamer presentation themes; the manifest hint "misc" kept)
- Lib: v6
- Engine: needs XeLaTeX (the beamer themes: README.org:50 says XeLaTeX and polynom/test.tex:10,20 loads fontspec with Product Sans; homeworkassignment and cheatsheet run under pdfLaTeX, homeworkassignment/homeworkassignment.cls:219-228 switches fonts on the engine)
- Look carried by: mixed (zip-local homeworkassignment.cls and the polynom and projektion beamer themes carry most of the look; cheatsheet.cls is a published CTAN class; the manifest's main todos.tex is plain article)
- Class origin: zip-local
- Main file: todos.tex, an Org-mode export of a to-do list, article only (other samples: examples/eg_assignment.tex, examples/eg_assignment_2.tex, examples/eg_assignment_3.tex, examples/eg_assignment_4.tex, polynom/docu_polynom.tex, polynom/test.tex, polynom/test_lst.tex, projektion/test_issue14.tex, and the driver in cheatsheet/cheatsheet.dtx:44-202)
- Read: main yes, zip-local classes and styles all (homeworkassignment.cls, cheatsheet.cls, the 7 polynom `.sty` and the 5 projektion `.sty`; the two `.dtx` outlined and checked against the `.cls`, the two `.ins` are DocStrip drivers, cheatsheet/cheatsheet.ins:76 and homeworkassignment/homeworkassignment.ins:76)

## Verdict
The manifest's main file todos.tex is an Emacs Org export that loads only `article` and common packages; alone it would map completely onto lib ways. The zip is a template collection and its templates decide the answer. `homeworkassignment.cls` is not on CTAN (ctan.org/pkg/homeworkassignment is a 404) and holds irreducible code: problem counters and headings tied to a grading table that is written to the `.aux` and read back, a TODO list built the same way, and TikZ punch marks. The polynom and projektion beamer themes draw their title bars, banner pages and a progress bar as TikZ page-node overlays (ART) and override beamer's `t` frame key through beamer internals. Only `cheatsheet.cls` (CTAN, v0.8, MIT, read at ctan.org/pkg/cheatsheet; the zip's copy declares v1.0 of the same date, cheatsheet/cheatsheet.cls:39-40) would be a clean `class.cheatsheet`.

## Blockers
- `BESPOKE/class` problem, subproblem, subsubproblem counters with `\setcounter` from an optional argument, `\@startsection` headings holding a point box, and `\task` redefined inside the environments, coupled to the grading table (homeworkassignment/homeworkassignment.cls:241-303, 305-385)
- `BESPOKE/class` grading table: `\edef` accumulation of column spec and rows, written with `\AtEndDocument{\immediate\write\@auxout{\gdef...}}` and typeset from `\expandafter\tabular\expandafter{...}` on the next run (homeworkassignment/homeworkassignment.cls:477-521)
- `BESPOKE/class` in-place red TODO marks and a "Table of ToDos" list: counter `todoNum`, `\xdef` accumulation, aux write-back (homeworkassignment/homeworkassignment.cls:455-476, 506-507, 518-521)
- `ART/class` punch-hole circles and a positioning mark on every page, `\AddToShipoutPictureBG*` with `\tikz{\draw ...}`, only under option `punchmark` (default false, homeworkassignment/homeworkassignment.cls:74, 543-557)
- `ART/class` polynom title page, section, subsection, subsubsection, banner and empty pages: `\tikz[overlay, remember picture]` page-edge fills, a picture node and a drawn rule (polynom/beamerinnerthemepolynom.sty:24-72, 88-93, 103-107, 159-206)
- `ART/class` projektion title, section and final pages as TikZ page overlays (projektion/beamerinnerthemeprojektion.sty:24-45, 61-103, 118-131) and a footline progress bar drawn from `\insertframenumber/\inserttotalframenumber` (projektion/beamerouterthemeprojektion.sty:52-59)
- `BESPOKE/class` `\define@key{beamerframe}{t}` redefined with beamer internals `\beamer@frametopskip`, `\beamer@framebottomskip`, `\beamer@initfirstlineunskip` (polynom/beamerouterthemepolynom.sty:19-29; projektion/beamerouterthemeprojektion.sty:16-28)

## Class setting
- Class: `class.article` (homeworkassignment, via `\LoadClass{article}`, homeworkassignment/homeworkassignment.cls:93; the wrapper class itself is zip-local, options: `problemsty` `subproblemsty` `subsubproblemsty` `tikz` `listings` `twoside`/`oneside` `twocolumn`/`onecolumn` `punchmark` `hlines` `todos` `unicodemath`, homeworkassignment/homeworkassignment.cls:62-82)
- Class: `class.cheatsheet` (published, CTAN; options `columns=<n>` default 4, `twocolumn` is an error, rest passed to article, cheatsheet/cheatsheet.cls:46-54; sample options `a4paper,landscape,columns=3`, cheatsheet/cheatsheet.dtx:44)
- Class: `class.beamer` (polynom/test.tex:5 option `t`; polynom/docu_polynom.tex:1 option `fragile`; polynom/test_lst.tex:1 `fragile=singleslide`)
- Class: `class.article` (todos.tex:2, option `11pt`); `class.ltxdoc` (homeworkassignment/homeworkassignment.dtx:41, documentation driver)
- Class-native vocabulary used: homeworkassignment `\maketitle` `\kurs`/`\subject` `\tutorium`/`\tutorial` `\abgabe`/`\deadline` `\sheetTitle` `\newproblem[n]{points}` `\newsubproblem` `\newsubsubproblem` `\solution[x]` `\proof[x]` `\makeGradingTable` (examples/eg_assignment.tex:4-30, examples/eg_assignment_4.tex:8-17); cheatsheet `\title` `\author` `\date` `\maketitle` `\section` `\columnbreak` (cheatsheet/cheatsheet.dtx:53-90); beamer `\titlepage` `\frametitle` `\framesubtitle` `\usetheme` `\setbeamertemplate{banner page}` (polynom/test.tex:40-67, 131-134)

## Component map
Section A, main file todos.tex.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | todos.tex:2 | `class.article` | 11pt |
| encoding | todos.tex:3-4,13 | `font.fontenc-t1` | inputenc utf8, fontenc T1, textcomp |
| symbol glyphs | todos.tex:14-15 | `font.icons` | marvosym, wasysym |
| load-only packages | todos.tex:6-10 | `fig.graphicx` `tbl.longtable` `fig.float` `fig.wrapfig` `fig.rotating` | loaded, no figure, table or float in the body |
| underline | todos.tex:11 | `mark.ulem` | normalem |
| math | todos.tex:12,16,46,55 | `math.amsmath` `math.amssymb` | `$\square$` `$\boxtimes$` `$\boxminus$` as check boxes |
| hyperref | todos.tex:17,22-25 | `meta.hyperref` | `\hypersetup{pdfkeywords={}, pdfsubject={}, pdfcreator={Emacs ...}}` |
| line-break tolerance | todos.tex:18 | `sp.hyphenat` | raw `\tolerance=1000` (the parameter `\sloppy` sets) |
| title block | todos.tex:19-21,28 | `front.maketitle` | author Adrian, `\today`, title todos |
| contents | todos.tex:29 | `toc.kernel` | |
| headings, labels | todos.tex:34-35,43-44,50-53 | `head.kernel` `xref.kernel` | section, subsection, `\label{sec-n}` |
| lists | todos.tex:36-40,54-106 | `list.kernel` `mark.kernel` | itemize nested 4 deep (todos.tex:54,62,73,77); `{\bfseries\sffamily TODO}` in headings |

Section B, homeworkassignment (all rows homeworkassignment/homeworkassignment.cls unless a path is given).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class base | homeworkassignment/homeworkassignment.cls:93 | `class.article` | `\LoadClass{article}`; options forwarded :83-92 |
| sides and columns | homeworkassignment/homeworkassignment.cls:70-73,83-92 | `page.class-options` `cols.twocolumn-option` | twoside default true, twocolumn default false |
| geometry | homeworkassignment/homeworkassignment.cls:175-182 | `page.geometry` | onecolumn: top=2cm, bottom=2cm, width=35em, headsep=14pt, hmarginratio={4:3}; twocolumn: top=2cm, bottom=2cm, left=2cm, headsep=14pt, hmarginratio={1:1} |
| header and footer | homeworkassignment/homeworkassignment.cls:183-215 | `hf.fancyhdr` | `firstpage`: head L tutorial, head R date, foot R page; `followingpage` twoside: head RO author, LO course+tutorial, LE sheet title+deadline, foot RO,LE page; oneside variant :204-212; headrulewidth .7pt or 0pt, footrulewidth 0pt |
| page style choice | homeworkassignment/homeworkassignment.cls:216,523 | `hf.pagestyle-kernel` | `\pagestyle{followingpage}`, `\thispagestyle{firstpage}` |
| equation numbering | homeworkassignment/homeworkassignment.cls:217 | `num.counters` | `\theequation` is `\Roman{equation}` |
| display maths | homeworkassignment/homeworkassignment.cls:47,218 | `math.amsmath` `math.eqnumber` | fleqn passed to amsmath, `\allowdisplaybreaks` |
| title block | homeworkassignment/homeworkassignment.cls:522-542 | `front.maketitle` | centred; course `\huge\textsf\textbf`, sheet title bold, "Abgabe: date", author `\normalsize`; fields stored by `\kurs` `\tutorium` `\abgabe` `\sheetTitle` :230-240 |
| title rules | homeworkassignment/homeworkassignment.cls:130-158 | `sp.rule` `sp.manual-space` | `\hrule height 2pt`, `\hrule`, `\vspace{.25cm|.5cm|.75cm}` by `hlines` = all, decreased, header, none |
| title in two columns | homeworkassignment/homeworkassignment.cls:524-530 | `cols.twocolumn-cmd` | `\twocolumn[{title}]` |
| fonts, XeLaTeX path | homeworkassignment/homeworkassignment.cls:219-223 | `font.fontspec` | `\setsansfont{TeX Gyre Adventor}`, `\setmainfont{TeX Gyre Pagella}`, `\setmonofont{Fira Mono}` |
| fonts, pdfLaTeX path | homeworkassignment/homeworkassignment.cls:224-228 | `font.helvet` `font.palatino` `font.mono` | tgadventor, tgpagella, FiraMono |
| unicode maths | homeworkassignment/homeworkassignment.cls:77-81,392-397 | `font.unicode-math` | option `unicodemath`, default true only under XeTeX |
| colour | homeworkassignment/homeworkassignment.cls:60,457,469 | `color.xcolor` | `\color{red}` for TODO |
| hyperref | homeworkassignment/homeworkassignment.cls:117 | `meta.hyperref` | default options |
| problem headings | homeworkassignment/homeworkassignment.cls:241-285 | `head.kernel` | `\@startsection` levels 1, 2, 3: indent 0, beforeskip -2em/-1em/-.5em, afterskip 1ex/.5ex/.5em, `\normalfont\Large|\large|` `\sffamily\bfseries`; the macros around it are BESPOKE |
| run-in labels | homeworkassignment/homeworkassignment.cls:286-300 | `head.kernel` | level 4, indent `\parindent`, `\normalfont\sffamily\bfseries`; labels Loesung, Zu zeigen, Gegeben, Annahme |
| point box | homeworkassignment/homeworkassignment.cls:250-251,265-266,280-281 | `box.fancybox` | `\framebox[3em]{\hfill ...}` (`\hwa@pointboxsize` :229) |
| toc entries | homeworkassignment/homeworkassignment.cls:254,269 | `toc.kernel` | `\addcontentsline{toc}{section|subsection}` |
| proof and end marks | homeworkassignment/homeworkassignment.cls:386-407,574-587 | `head.kernel` `sp.ragged` `mark.kernel` `math.amssymb` | run-in "Beweis:" label, flushright `\textsc{Qed}`, `\(\square\)`, `\(\blacksquare\)`, `\(\triangle\)`; `contradiction` adds `\lightning` (wasysym :55) |
| math operators and sets | homeworkassignment/homeworkassignment.cls:408-432 | `math.amsmath` `math.amssymb` | 18 `\DeclareMathOperator`, `\mathbb` N Z R Q C F P |
| math aliases | homeworkassignment/homeworkassignment.cls:434-454 | `math.kernel` `sp.manual-space` | `\diff` `\partdiff` `\floor` `\ceil` (`\left\lfloor`), `\forall` `\exists` wrapped in `\hskip 2pt`, `\bigforall` with `\raisebox` |
| translations | homeworkassignment/homeworkassignment.cls:46,230,588-630 | `lang.translator` | `\DeclareTranslation{German|English}{key}{text}`, `\DeclareTranslationFallback`, `\GetTranslation` |
| listings option | homeworkassignment/homeworkassignment.cls:118-128 | `code.listings` | frame=single, breaklines=true, postbreak `\raisebox{..}{\hookrightarrow}`, basicstyle=\scriptsize |
| tikz option | homeworkassignment/homeworkassignment.cls:159-173 | `art.tikz` | libraries shapes, arrows, positioning, automata..., styles treenode, normalnode, array (a figure toolbox, content) |
| punch marks | homeworkassignment/homeworkassignment.cls:543-557 | `bg.eso-pic` `art.tikz` | ART (see Blockers) |
| adjustbox | homeworkassignment/homeworkassignment.cls:56,491 | `fig.adjustbox` | `max width=\linewidth` around the grading table |
| grading table | homeworkassignment/homeworkassignment.cls:477-505 | `tbl.tabular` `fig.float` | `table[hb]`, `\centering\large`, `\hline`, `p{3em}` columns; the logic is BESPOKE |
| TODO marks and list | homeworkassignment/homeworkassignment.cls:455-476 | `color.xcolor` `list.kernel` `xref.hyperref` | red bold TODO, `\hyperref[TODOa]`; BESPOKE |
| array package | homeworkassignment/homeworkassignment.cls:51 | `tbl.tabular` | load-only |
| doc driver | homeworkassignment/homeworkassignment.dtx:41-81 | `class.ltxdoc` `dtx.doc` | `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges`, `\DocInput` |
| babel | examples/eg_assignment_2.tex:2 | `lang.babel` | ngerman |
| quotes | examples/eg_assignment_2.tex:16,127 | `lang.csquotes` | autostyle, german=guillemets, `\enquote` |
| aligned maths | examples/eg_assignment_2.tex:63-75 | `math.amsmath` | align* with `&&` blocks |
| figures | examples/eg_assignment_2.tex:171-213 | `fig.graphicx` `cap.kernel` | figure[h], `\caption`; the picture is Content-opaque |
| page break | examples/eg_assignment_2.tex:168 | `pg.break` | `\newpage` |
| code samples | examples/eg_assignment_4.tex:21-26 | `code.listings` | `lstlisting[language=bash]` |
| encoding | examples/eg_assignment_4.tex:3 | `font.fontenc-t1` | `[latin1]{inputenc}` (file is latin1) |
| draft aids | examples/eg_assignment.tex:2; examples/eg_assignment_4.tex:5 | `draft.todo` | lipsum, showframe |
| contents | examples/eg_assignment_3.tex:60 | `toc.kernel` | |

Section C, cheatsheet (published class `class.cheatsheet`; rows show what it does, all of it is reproduced by loading the class).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | cheatsheet/cheatsheet.dtx:44 | `class.cheatsheet` | a4paper, landscape, columns=3 |
| columns | cheatsheet/cheatsheet.cls:48,98-99 | `cols.multicol` | whole body inside `multicols{columns}` via `\AtBeginDocument` and `\AtEndEnvironment{document}` |
| geometry | cheatsheet/cheatsheet.cls:104-106 | `page.geometry` | top=1cm, bottom=1cm, left=1cm, headsep=14pt, hmarginratio={1:1} |
| page style, numbering | cheatsheet/cheatsheet.cls:83-84 | `hf.pagestyle-kernel` `num.secnumdepth` | empty; secnumdepth 0 |
| spacing, ragged | cheatsheet/cheatsheet.cls:85-86,101 | `sp.lengths` `sp.ragged` | parindent 0pt, parskip `0pt plus 0.5ex`, `\raggedright` |
| fonts | cheatsheet/cheatsheet.cls:58-61 | `font.fontenc-t1` `font.libertine` | T1, libertine |
| colours | cheatsheet/cheatsheet.cls:70-72 | `color.xcolor` | primaryColor cmyk 1,.72,0,.38; secondaryColor gray |
| title block | cheatsheet/cheatsheet.cls:109-131 | `front.class-native` `box.mdframed` | `\title` `\author` `\date` store macros; `\maketitle` is an mdframed (linecolor secondaryColor, linewidth 1pt, margins 0mm) plus a 1pt rule |
| headings | cheatsheet/cheatsheet.cls:132-143 | `head.kernel` | `\@startsection` levels 1-3, indent 0mm, `\large\bfseries\sffamily\color{primaryColor}` for section |
| equations | cheatsheet/cheatsheet.cls:63-64,107 | `math.amsmath` `num.counters` | fleqn; `\theequation` Roman |
| quotes, listings, links | cheatsheet/cheatsheet.cls:59,67-68,76-81 | `lang.csquotes` `code.listings` `meta.hyperref` | autostyle, german=guillemets; breaklines, postbreak hookrightarrow, basicstyle `\ttfamily\color{primaryColor}\scriptsize` |
| sample body | cheatsheet/cheatsheet.dtx:53-65,77,90,142,155,187 | `fn.kernel` `list.kernel` `cols.multicol` `quote.kernel` `head.kernel` `code.listings` | `\footnotemark`/`\footnotetext`, description, `\columnbreak`, quote, `\paragraph`, `lstlisting[language={[LaTeX]TeX}]` |
| sample packages | cheatsheet/cheatsheet.dtx:45-46,95,143 | `lang.babel` `lang.csquotes` `meta.url` | ngerman,english; `\url` |

Section D, beamer themes (polynom, projektion; zip-local, not on CTAN per README.org:9-10,48).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | polynom/test.tex:5; polynom/docu_polynom.tex:1 | `class.beamer` | `t`; `fragile` |
| theme choice | polynom/test.tex:25,40-41; polynom/beamerthemepolynom.sty:31-34 | `slide.beamer-theme` | `\usetheme{polynom}`, `\usecolortheme{polynomsecondgrade}`, `\usefonttheme[onlymath]{serif}`; inner, outer, colour, font parts |
| 16:9 page | polynom/beamerthemepolynom.sty:10; projektion/beamerthemeprojektion.sty:11 | `page.geometry` | paperwidth=33.867cm, paperheight=19.05cm |
| margins | polynom/beamerthemepolynom.sty:12-23; polynom/beamerinnerthemepolynom.sty:234-235 | `sp.lengths` `slide.beamer-template` | `\leftmargini` 1em, `\leftmarginii` 3em; `text margin left/right=.1\paperwidth` |
| colours | polynom/beamercolorthemepolynom.sty:3-9; projektion/beamercolorthemeprojektion.sty:4-25 | `color.xcolor` | `\definecolor` RGB palettes (polynom-blue 41 98 255; rwth 0 84 159) |
| colour roles | polynom/beamercolorthemepolynom.sty:17-56; projektion/beamercolorthemeprojektion.sty:28-66 | `slide.beamer-template` | `\setbeamercolor` for normal text, structure, palette primary to quaternary, block, banner page, footline, framenumber, title page bar |
| palette switch | polynom/beamercolorthemepolynomseconddegree.sty:28-50 | `slide.beamer-template` | `\setPaletteBlue|Red|Green` bundles of `\setbeamercolor` (reducible aliases) |
| font sizes | polynom/beamerfontthemepolynom.sty:17-66; projektion/beamerfontthemeprojektion.sty:14-38 | `slide.beamer-template` | `\setbeamerfont{...}{size*={22pt}{33pt}}`, title 50pt bold, itemize sizes |
| size commands | polynom/beamerfontthemepolynom.sty:19,23-38 | `font.size-commands` | `\renewcommand\normalsize{\@setfontsize\normalsize{22}{33}}` and `\small` to `\Huge` as a size table; `\fontsize{22}{33}\selectfont` at document start |
| fonts | polynom/test.tex:10,20; polynom/docu_polynom.tex:9,16 | `font.fontspec` `font.helvet` `font.mono` | `\setsansfont{Product Sans}` (not shipped); tgadventor; FiraMono scaled=0.85; `\boldmath` polynom/test.tex:27 is `mark.kernel` |
| list bullets | polynom/beamerinnerthemepolynom.sty:217-229; projektion/beamerinnerthemeprojektion.sty:136-142 | `slide.beamer-template` | `\defbeamertemplate*{itemize item}` (square under XeTeX), enumerate `\arabic{enumi}.`, `\roman{enumii}.`, `\Roman{enumiii}.` |
| footline | polynom/beamerouterthemepolynom.sty:60-89 | `slide.beamer-template` | date, `\hfill`, author, `beamercolorbox[wd=5em,ht=2.5ex,dp=1.125ex,center]{framenumber}` |
| headline, sidebars, navigation | polynom/beamerouterthemepolynom.sty:11,35,91-95 | `slide.beamer-template` | empty headline, sidebar widths 0pt, navigation symbols off, `\headsep` 0pt |
| frame title | polynom/beamerouterthemepolynom.sty:41-54; projektion/beamerouterthemeprojektion.sty:38-47 | `slide.beamer-template` `sp.rule` | stacked `\framesubtitle` over `\frametitle`, 36pt and 50pt; a 2pt vertical rule drawn with `\tikz\draw` (reducible to `\vrule`) |
| title, section, banner pages | polynom/beamerinnerthemepolynom.sty:24-72,88-107,159-206 | `bg.tikzpagenodes` `art.tikz` | ART (see Blockers) |
| section hooks | polynom/beamerinnerthemepolynom.sty:108-153 | `slide.beamer-section-hook` | `\AtBeginSection[]`, subsection, subsubsection frames `[plain,noframenumbering]`; the frame body is the ART template |
| progress bar | projektion/beamerouterthemeprojektion.sty:52-59 | `bg.tikzpagenodes` `art.tikz` | ART (see Blockers) |
| sample date and captions | polynom/test.tex:30-31,34-35 | `front.datetime` `cap.caption` | `datetime[ddmmyyyy]`, `\dateseparator{.}`; `compatibility=false`, singlelinecheck=off, justification=raggedleft, labelformat=empty, labelsep=none |
| sample titles | polynom/test.tex:45-49,55-56 | `slide.beamer-template` | `\title` `\subtitle` `\date` `\author` `\institute`, `\setbeamertemplate{title page}[polynom]{}` |
| sample listings | polynom/docu_polynom.tex:7-14; polynom/test_lst.tex:13-16 | `code.listings` | basicstyle=`\color{fg}\ttfamily`, keywordstyle polynom-blue bold, commentstyle polynom-green, stringstyle polynom-red |
| sample colour boxes | polynom/docu_polynom.tex:139-153 | `slide.beamer-template` | `beamercolorbox[wd=5em,ht=5ex,dp=1.125ex,center]` demo |
| sample figure | polynom/test.tex:145-149 | `fig.graphicx` `cap.kernel` | `\includegraphics{bracket.png}`, caption `\fontsize{16pt}{24pt}` |
| sample maths | polynom/test.tex:90-91 | `math.kernel` `math.amssymb` | display `\[ \]`, `\mathbb{R}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class option machinery (kvoptions, ifthenelse dispatch, counter-style parser) | homeworkassignment/homeworkassignment.cls:61-116,134-158,561-573 | yes | the emitter fixes each value: `problemsty` and the others become `\renewcommand\the...` (`num.counters`), `hlines` picks one of four rule variants (`sp.rule`) |
| problem counters, `\newproblem` family, `problem` environments, `\task` | homeworkassignment/homeworkassignment.cls:241-303,305-385 | no | hand-rolled counters and conditionals drive the printed number, point box, toc entry and grading-table row; `\task` also uses `framed`, which the class never loads (:357) |
| grading table | homeworkassignment/homeworkassignment.cls:477-521 | no | aux write-back and `\expandafter\tabular` with a macro-built column spec; two-pass state |
| TODO marks and list | homeworkassignment/homeworkassignment.cls:455-476,506-507 | no | counter, `\xdef` list and aux write-back; `todonotes` is a different look |
| punch marks | homeworkassignment/homeworkassignment.cls:543-557 | no | free TikZ circles and a mark at fixed page coordinates (ART) |
| title and field macros (`\hwa@maketitletext`, `\kurs`, `\tutorium`, `\abgabe`, `\sheetTitle`) | homeworkassignment/homeworkassignment.cls:230-240,522-542 | yes | values stored in macros; the emitter prints the fields in a centred block (`front.maketitle`, `sp.rule`) |
| `\keyword`, `\solution`, `\toShow`, `proof`, `contradiction`, `\QED` family | homeworkassignment/homeworkassignment.cls:286-300,386-407,574-587 | yes | inline expansion: run-in bold sans label (`head.kernel`) and flushright end mark (`sp.ragged`, `mark.kernel`) |
| math macros, `\forall`/`\exists` with `\hskip 2pt`, `\dim`, `\Im` redefinitions | homeworkassignment/homeworkassignment.cls:408-454 | yes | `\DeclareMathOperator` (`math.amsmath`), aliases expanded in place |
| translations | homeworkassignment/homeworkassignment.cls:588-630 | yes | `lang.translator` calls, strings are values |
| XeTeX or pdfTeX font switch | homeworkassignment/homeworkassignment.cls:219-228 | yes | `font.fontspec` for XeLaTeX or the three `font.*` package lines for pdfLaTeX |
| `\define@key{beamerframe}{t}` override | polynom/beamerouterthemepolynom.sty:19-29; projektion/beamerouterthemeprojektion.sty:16-28 | no | sets beamer's frame skips and `\beamer@initfirstlineunskip` by internal names; no lib way takes it |
| TikZ page-node templates (`\polynom@titlepagebox`, `\prjktn@titlepagebox`, banner pages, progress bar) | polynom/beamerinnerthemepolynom.sty:24-72,159-206; projektion/beamerinnerthemeprojektion.sty:24-131; projektion/beamerouterthemeprojektion.sty:52-59 | no | template-defining drawing from `current page` coordinates, ART |
| `\nextsectionimage` and `\insertnextsectionimage` state | polynom/beamerinnerthemepolynom.sty:100-115 | no | feeds the image into the ART section page |
| `sectiontitles` option | polynom/beamerinnerthemepolynom.sty:12-14,108-153 | yes | emit or omit the `\AtBeginSection[]` hook |
| size-command table | polynom/beamerfontthemepolynom.sty:23-38 | yes | `\@setfontsize` of fixed names and numbers; `font.size-commands` (a borderline case, kernel macros redefined) |
| `\setPaletteBlue|Red|Green` | polynom/beamercolorthemepolynomseconddegree.sty:28-50 | yes | `\setbeamercolor` bundles, aliases |
| `\everymath{... \color{primaryColor}}` | cheatsheet/cheatsheet.cls:108 | n/a | inside the published class `cheatsheet`, covered by `class.cheatsheet`; as a separate emit it would be outside the closed list of `math.everymath` |

## Content-opaque
- TikZ pictures in figures: examples/eg_assignment_2.tex:173-211, 217-261; examples/eg_assignment_3.tex:174-212, 218-262.
- TikZ style sets (`nonterminal`, `terminal`, `skip loop`): examples/eg_assignment_2.tex:26-56; the `tikz` option styles homeworkassignment/homeworkassignment.cls:164-173.
- `\usetikzlibrary{graphs}` loaded, unused: polynom/test.tex:42-43.
- Empty frames: projektion/test_issue14.tex:10-44. Shipped images: projektion/bracket.png, polynom/docu_landscape.jpg.
- Missing assets: Product Sans (polynom/test.tex:20), TeX Gyre Adventor, TeX Gyre Pagella, Fira Mono; docker/latest/Dockerfile:7-12 only installs them for CI (docker and `.gitlab-ci.yml:22-41` build an image, not part of the template).
- Documentation sources: homeworkassignment/homeworkassignment.dtx and cheatsheet/cheatsheet.dtx (text, change logs).

## Lib changes
- New ways proposed: none (considered: `fixltx2e` at todos.tex:5, a load-only package with no printed effect, as the lib's v4 rejection of `sys.compat-load` says)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
