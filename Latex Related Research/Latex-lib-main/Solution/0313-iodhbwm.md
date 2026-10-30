yes

# 0313-iodhbwm: iodhbwm (unofficial DHBW Mannheim thesis class)

- Unverified: read from the source, not compiled.
- Source: Source/0313-iodhbwm/ (origin: https://mirrors.ctan.org/macros/latex/contrib/iodhbwm.zip; licence: lppl1.3)
- Kind: thesis
- Lib: v3
- Engine: pdfLaTeX-compatible (no fontspec or Lua code; `pdfcreator = pdf\LaTeX` at tex/iodhbwm.cls:285; the optional bibliography is biblatex with the biber backend, tex/iodhbwm.cls:436)
- Look carried by: class (the look is the CTAN class `iodhbwm` on KOMA `scrreprt`, tex/iodhbwm.cls:119, plus its sibling package `iodhbwm-templates` and the `i18n/*/dhbw-*.def` page files, all in the one CTAN bundle; every example sample adds only class options, `\dhbwsetup` values and content)
- Class origin: ctan (ctan.org/pkg/iodhbwm, v1.2.2 2021-02-15, LPPL 1.3, Felix Faltin; README.md:3)
- Main file: doc/iodhbwm.tex (the manifest pick: the German manual, typeset with the CTAN class `skdoc`; it does not load `iodhbwm`) (other samples: the 20 template samples under doc/examples/, for instance doc/examples/how-to-use-iodhbwm/iodhbwm-recommended-starter.tex, iodhbwm-advanced-starter.tex, iodhbwm-simple-starter.tex; doc/examples/abstract/iodhbwm-auto-sections-with-abstract.tex; doc/examples/listings/iodhbwm-listings.tex)
- Read: main yes, zip-local classes and styles all (tex/iodhbwm.cls 474 lines, tex/iodhbwm-templates.sty 492, tex/iodhbwm-i18n.def 36, all ten tex/i18n/{english,ngerman}/dhbw-*.def, all 20 example .tex files and my-titlepage.tex, my-abstract.inc.tex; the PDFs and the `skdoc` source were not read, `skdoc` is not in the zip)

## Verdict
The zip is the CTAN bundle of `iodhbwm`, a thesis class published with public documentation (W1), chosen by key=value options (W2: `pgfopts` keys at tex/iodhbwm.cls:66-100 and `\dhbwsetup{key=value}` at tex/iodhbwm-templates.sty:107-202). So it is one way, `class.iodhbwm`, which loads `class.scrreprt` (tex/iodhbwm.cls:119). An emitter writes `\documentclass[...]{iodhbwm}`, one `\dhbwsetup{...}` and the body; the decomposition below shows every component the class sets also has a lib way, so nothing is hidden behind the class name. No `ART`, `EXTERNAL`, `UNMAPPED` or unpublished bespoke code was found. Two closest calls are recorded, not hidden: the TikZ option badges in the manual's preamble (doc/iodhbwm.tex:72-76, 94-98; a coloured band plus one icon inside a `tcolorbox` `overlay` key, in the manual and not in the thesis template) and the class's patched `\appendix` and `\addchaptertocentry` (published code, so not bespoke; it would be `BESPOKE/class` had the class been zip-local).

## Blockers
none

Recorded, not counted:
- `bib.biblatex-biber` is loaded only with class option `add-bibliography` or `add-bibliography-` (tex/iodhbwm.cls:423, 435-448), so it is not unconditional; it needs a biber run (doc/examples/how-to-use-iodhbwm/iodhbwm-recommended-starter.tex:52-53). The manual says bibtex is not supported (doc/iodhbwm.tex:339).
- `tcolorbox[most]` is loaded unconditionally (tex/iodhbwm.cls:180). My reading of tcolorbox's documentation is that `most` leaves out the `minted` library, so no shell escape is needed; this was not checked in a TeX installation here, and no `minted` or `shell-escape` text exists anywhere in the zip (grep).

## Class setting
- Class: `class.iodhbwm` options (all `pgfopts` keys under `/iodhbwm`, tex/iodhbwm.cls:66-100): `load-preamble` (default true), `load-dhbw-templates` (default false), `add-tocs-to-toc`, `add-bibliography`, `add-bibliography-`, `bib-file`, `biblatex/style` (default `numeric-comp`), `biblatex/bibstyle`, `biblatex/citestyle`, `language` (repeatable), `mainlanguage`, `print-`, `print`, `auto-intro-pages` = `none|custom|default|all`, `debug`. Any unknown option goes to the base class (cls:99, 110-119). Base class `class.scrreprt` by default with `fontsize=12pt,parskip=half-` prepended (cls:37, 114-117); switchable to `scrbook` by defining `\iodhbwm@cls@baseclass` before `\documentclass` (doc/iodhbwm.tex:654-659, listing text, cls:37 `\providecommand`).
- Class-native vocabulary used (package `iodhbwm-templates`, loaded by `load-dhbw-templates`, tex/iodhbwm.cls:186-188): preamble `\dhbwsetup{author, thesis type = SA|BA|PA, thesis title, thesis second title, student id, location, institute, institute section, institute logo, course/id, course/name, supervisor, processing period, reviewer, date, submission date, bachelor degree = BoE|BoS|BoA, bachelor degree type, dhbw location, dhbw logo, titlepage, declaration, abstract, intro/print titlepage|declaration|abstract|toc|lof|lot|all lists|all, intro/append custom content, intro/roman page numbers, titlepage/print location}` (tex/iodhbwm-templates.sty:107-200); body `\dhbwtitlepage` `\dhbwdeclaration` `\dhbwabstract` `\dhbwfrontmatter` `\dhbwmainmatter` `\dhbwprintintro` (:362-444), `\listofappendices` (:465-469), `\listappendixname`, getters `\getAuthor` `\getThesisTitle` `\getThesisSecondTitle` `\getThesisType` `\getBachelorDegree` `\getCourseName` `\getCourseId` `\getStudentId` `\getInstitute` `\getInstituteSection` `\getInstituteLogo` `\getSupervisor` `\getReviewer` `\getProcessingPeriod` `\getDate` `\getSubmissionDate` `\getLocation` `\getDHBWLocation` `\getDHBWLogo` (:218-355). Examples use all of these (doc/examples/how-to-use-iodhbwm/iodhbwm-advanced-starter.tex:23-54).
- Main-file class `class.skdoc` (published CTAN class, unbundled; source not read) with options `babel=ngerman,highlight=false` (doc/iodhbwm.tex:1). Native vocabulary used: `\package[vcs=,ctan=]{}` `\version` `\email` `\changes` `\PrintChanges` `\PrintIndex` `\DescribeMacro` `\Macro` `\pkg` `\cs` `\env` `\file` `\path` `\meta` `\marg` `\oarg` `\thepackage` `\Option` `\WithValues` `\AndDefault` `\opt` (doc/iodhbwm.tex:11-16, 179, 715; `\Option`, `\WithValues`, `\AndDefault`, `\opt` are not defined in the file, so I took them to be `skdoc`'s).

## Component map
All class rows are set inside the class, so the one `class.iodhbwm` line reaches them; the rows give the way each part reduces to.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | tex/iodhbwm.cls:30-33, :119 | `class.iodhbwm` | key=value options above; loads `class.scrreprt` |
| base class | tex/iodhbwm.cls:37, :114-119 | `class.scrreprt` | `fontsize=12pt`, `parskip=half-`, user options forwarded; one-sided by default (doc/iodhbwm.tex:646) |
| class option machinery | tex/iodhbwm.cls:35, :50-62, :66-102 | `class.iodhbwm` | `etoolbox` booleans + `pgfopts`; the option set is the class's own |
| margins, binding | tex/iodhbwm.cls:214-222 | `page.geometry` | top=3cm, right=2.5cm, bottom=3cm, left=2.5cm, bindingoffset=1cm, includeheadfoot |
| running heads, feet | tex/iodhbwm.cls:227-241 | `hf.scrlayer-scrpage` | headsepline, footsepline, plainfootsepline, clines, automark; `\automark[section]{chapter}`; `\ihead{\headmark}`; `\cfoot[-~\pagemark~-]{-~\pagemark~-}`; `\clearpairofpagestyles` |
| page style switching | tex/iodhbwm-templates.sty:396-419 | `hf.pagestyle-kernel` | front matter `\pagestyle{empty}` and `\chapterpagestyle` empty; main matter `\pagestyle{scrheadings}`, `\chapterpagestyle` plain |
| page numbers | tex/iodhbwm-templates.sty:397-398, :416 | `pgnum.pagenumbering` | arabic from main matter; `Roman` when `intro/roman page numbers` |
| front-matter pages break | tex/iodhbwm-templates.sty:412 | `pg.break` | `\cleardoubleoddpage`; title pages end `\cleardoublepage` (tex/i18n/ngerman/dhbw-titlepage-ba.def:56) |
| line spacing | tex/iodhbwm.cls:172; tex/iodhbwm-templates.sty:417, :453 | `sp.setspace` | `\onehalfspacing` from main matter; `\singlespacing` for appendix and bibliography (cls:425) |
| text fonts | tex/iodhbwm.cls:169; doc/examples/how-to-use-iodhbwm/iodhbwm-recommended-starter.tex:19 | `font.lmodern` | class loads `lmodern`; the sample adds `\usepackage[T1]{fontenc}` (`font.fontenc-t1`) |
| microtypography | tex/iodhbwm.cls:170 | `sp.microtype` | default options |
| colours | tex/iodhbwm.cls:199-209 | `color.xcolor` | `\definecolor` HTML: DHBW-red e2001a, DHBW-blue 026f93, DHBW-darkblue 23527c, DHBW-light ffffff, DHBW-light-gray f2f2f2, DHBW-font 5c6971, DHBW-dark-font 333333; xcolor options `table,dvipsnames` (cls:175-178) |
| colour tables | tex/iodhbwm.cls:175-178 | `tbl.colortbl` | `xcolor` option `table` |
| hyperlinks, PDF metadata | tex/iodhbwm.cls:276-300 | `meta.hyperref` | `pdftitle`, `pdfsubject` from `\getThesisTitle`, `pdfauthor` from `\getAuthor`, `pdfcreator`/`pdfproducer` = pdfLaTeX, `pdftoolbar=true`, `pdfmenubar=false`, `bookmarksopen=false`; `colorlinks, allcolors=DHBW-red, urlcolor=DHBW-blue`, or `hidelinks` with `print-`; `pageanchor` false in front matter (templates.sty:402, 415) |
| cross-references | tex/iodhbwm.cls:262-269; doc/examples/references/iodhbwm-references.tex:29-32 | `xref.cleveref` | `noabbrev,nameinlink` plus main language; body `\Cref`; `\label` `\ref` are `xref.kernel` |
| units and numbers | tex/iodhbwm.cls:246-257 | `mark.siunitx` | `detect-all`, `separate-uncertainty=true`, `locale=DE`, `per-mode=fraction`, `range-phrase=-`, `range-units=single` |
| maths | tex/iodhbwm.cls:173-174 | `math.mathtools` | `amsmath` option `intlimits` passed on |
| language, quotes | tex/iodhbwm.cls:139-157 | `lang.babel` | `babel` with the collected `language`/`mainlanguage` list (`main=` marks the main one); sample `\begin{otherlanguage}{english}` (doc/examples/abstract/my-abstract.inc.tex:13) |
| quotation marks | tex/iodhbwm.cls:156 | `lang.csquotes` | `autostyle` |
| graphics, tables, boxes | tex/iodhbwm.cls:179-182 | `fig.graphicx` | `graphicx`; `tbl.tabularx` (`tabularx`), `tbl.booktabs` (`booktabs`), `box.tcolorbox` (`tcolorbox` with library set `most`) loaded when `load-preamble` is true |
| captions | tex/iodhbwm.cls:309-316 | `cap.caption` | `format=hang`, `font=small`, `labelfont=bf` |
| listing captions | tex/iodhbwm.cls:333-351, :353-382 | `cap.caption` | `\DeclareCaptionFont{DHBWlisting}`, `{print}`; `\DeclareCaptionFormat{listing}`, `{listingprint}` = `\colorbox{DHBW-red}{\parbox{\dimexpr\textwidth-2\fboxsep}{#1#2#3}}`; `\captionsetup[lstlisting]{format,font={...,sf},singlelinecheck=false,margin=0pt}`; boxes are `box.fancybox` (`\colorbox`) and `box.minipage` (`\parbox`) |
| code listings | tex/iodhbwm.cls:318-331, :358-381 | `code.listings` | only with `load-dhbw-templates`: `numbers=left, showstringspaces=false, tabsize=2, breaklines=true, xleftmargin=3em, framexleftmargin=3em, aboveskip=\baselineskip, frame=tb, captionpos=t`; colour pair with `print` (black, white) or default (rulecolor DHBW-red, keywords DHBW-darkblue, strings purple, background DHBW-light-gray); `basicstyle=\scriptsize\ttfamily\color{DHBW-dark-font}` |
| code, body | doc/examples/listings/iodhbwm-listings.tex:17-18, :25, :30, :43, :54-58 | `code.listings` | `lstlisting[caption,label,language,float[=htb]]`, `\lstlistoflistings`, `\renewcommand{\lstlistingname}`, `\lstset{captionpos=b,frame=t}` |
| title page | tex/iodhbwm-templates.sty:362-367; tex/i18n/ngerman/dhbw-titlepage-ba.def:1-57 | `front.class-native` | `\dhbwtitlepage` inputs `i18n/<lang>/dhbw-titlepage[-ba\|-pa\|-sa].def` chosen by `thesis type` (templates.sty:129-140); also `titlepage = <file>` and `\maketitle` route (doc/iodhbwm.tex:631-637) |
| title page layout | tex/i18n/ngerman/dhbw-titlepage-ba.def:1-57 | `front.titlepage-env` | `titlepage` env, `\centering`; `\includegraphics[height=1.7cm]`; `minipage[c]{.25\textwidth}` pair with `\hfill`; `\rule{\textwidth}{.5mm}` twice; `\textsc{\Large}`, `\bfseries`, `\vfill`; `\small` `tabularx{\textwidth}{@{}lX@{}}` with `\toprule`; rows chosen by `\ifcsempty` (`sp.rule`, `box.minipage`, `fig.graphicx`, `tbl.tabularx`, `tbl.booktabs`, `sp.ragged`, `font.size-commands`, `mark.kernel`) |
| title page, custom | doc/examples/titlepages/my-titlepage.tex:7-15; doc/examples/titlepages/iodhbwm-custom-titlepage.tex:21 | `front.titlepage-env` | `\vfill`, `\centering`, `\Huge`; selected with `titlepage = my-titlepage` |
| logo | tex/dhbw-logo.png; tex/iodhbwm-templates.sty:101-102, :158-160 | `fig.graphicx` | `dhbw logo` default `dhbw-logo` (540x264 px, shipped); `\graphicspath{{./img/}}` (doc/examples/titlepages/iodhbwm-titlepage-logo.tex:35) |
| declaration page | tex/iodhbwm-templates.sty:370-375; tex/i18n/ngerman/dhbw-declaration.def:1-35 | `front.dedication` | `\chapter*{Erklärung}` (`\section*` without chapters), `\thispagestyle{empty}`, `\textsc`, `tabular{l}` with `\hline` for place and date |
| abstract | tex/iodhbwm-templates.sty:378-382; doc/examples/abstract/my-abstract.inc.tex:8-19 | `abs.class-native` | `\dhbwabstract` inputs the file named by `abstract`; the file is hand-set `\section*{\abstractname}`, `\thispagestyle{empty}`, `otherlanguage` |
| intro pages | tex/iodhbwm.cls:388-401; tex/iodhbwm-templates.sty:422-444 | `front.class-native` | `auto-intro-pages` runs `\dhbwprintintro` after the preamble; order: title page, declaration, abstract, `\tableofcontents`, `\listoffigures` and `\listoftables` only when `totalcount` finds floats |
| contents, lists | tex/iodhbwm-templates.sty:428-440 | `toc.kernel` | `\tableofcontents` `\listoffigures` `\listoftables` |
| lists in contents | tex/iodhbwm.cls:124-128, :411 | `toc.koma` | `add-tocs-to-toc` = `\KOMAoptions{listof=totoc}`; bibliography heading `bibintoc` |
| toc page numbers | tex/iodhbwm-templates.sty:386-391 | `toc.koma` | `\RedeclareSectionCommand[tocpagenumberformat=...]{chapter}`; toggled by `\addtocontents{toc}{\booltrue{...}}` (:403, :418) |
| list of appendices | tex/iodhbwm-templates.sty:465-469 | `toc.tocbasic` | `\DeclareNewTOC[listname={\appendixname},type=appendix,types=appendices]{atoc}` |
| headings | tex/iodhbwm.cls:119 (no `\setkomafont` or `\titleformat` anywhere in the class) | `head.kernel` | `\chapter` `\section` `\part` with the `scrreprt` default look; body use at doc/examples/how-to-use-iodhbwm/iodhbwm-recommended-starter.tex:40-41 |
| part naming | doc/examples/customizing/iodhbwm-replace-part-naming.tex:22-33 | `lang.babel` | `\addto\captionsngerman{\renewcommand{\partname}{Thema}}`; `num.counters` (`\renewcommand{\thepart}{\Alph{part}}`); `head.kernel` (`\partformat`); `toc.koma` (`\RedeclareSectionCommand[tocentrynumberformat,tocnumwidth=6em]{part}`) |
| appendix | tex/iodhbwm-templates.sty:451-460, :463, :474-490 | `num.appendix` | `\pretocmd\appendix` (`xpatch`/`etoolbox`), `\KOMAoptions{appendixprefix}`, `\appendixmore` hook rewrites `\addchaptertocentry`; body `\appendix` (doc/examples/appendix/iodhbwm-appendix.tex:59) |
| bibliography | tex/iodhbwm.cls:423-461 | `bib.biblatex-biber` | `backend=biber, bibstyle/citestyle=\iodhbwm@bib@*@opt (numeric-comp), sorting=nty, natbib=true, block=space, backrefstyle=three+, date=short, bibwarn=true, texencoding=auto, bibencoding=auto, isbn=false`; `\addbibresource{<bib-file or dhbw-source.bib>}`; `\printbibliography[heading=bibintoc]` at `\AtEndDocument` |
| bibliography, user | doc/examples/bibliography/iodhbwm-biblatex-custom-option.tex:28; iodhbwm-biblatex-rename-heading.tex:19-22; iodhbwm-biblatex-footcite.tex:23-25 | `bib.biblatex-biber` | `\ExecuteBibliographyOptions{sorting=none, doi=false}`; `\DefineBibliographyStrings{ngerman}{bibliography,references}`; `\footcite` `\footfullcite` `\nocite{*}` |
| acronyms | doc/examples/acronyms/iodhbwm-acro.tex:25, :30-34 | `idx.glossaries` | `acro` (same family as `acronym`): `\DeclareAcronym{Team}{short,long}`, `\printacronyms[name=...,heading=addchap]`, `\ac{}`; passed through `intro/append custom content` |
| tables, figures (sample) | doc/examples/abstract/iodhbwm-auto-sections-with-abstract.tex:52-62, :69-73 | `tbl.tabular` | `table[htb]`, `\centering`, `tabular{@{}ll@{}}`, `\toprule\midrule\bottomrule`, `\caption` (`cap.kernel`, `tbl.booktabs`); figure `\includegraphics[width=.5\linewidth]` (`fig.graphicx`) |
| dummy text | tex/iodhbwm.cls:469-471 | `draft.todo` | option `debug` loads `blindtext` and `lipsum` |
| manual: page | doc/iodhbwm.tex:19-20 | `page.geometry` | left=6.5cm, right=1cm, marginparwidth=2cm |
| manual: paragraph | doc/iodhbwm.tex:30 | `sp.lengths` | `\parindent` 0pt |
| manual: fonts | doc/iodhbwm.tex:2, :4, :7 | `font.fontenc-t1` | `fontenc[T1]`; `font.lmodern`; `font.icons` (`fontawesome`, `\faCode`, `\faFileO`) |
| manual: colours | doc/iodhbwm.tex:48-53 | `color.xcolor` | `\definecolor` HTML: darkgray 4D4D4D, lightgray B3B3B3, darkred 8F0D0D, lightred D34747, darkcyan 085656, lightcyan 2B7E7E |
| manual: boxes | doc/iodhbwm.tex:126-149 | `box.tcolorbox` | `\newtcolorbox{warning\|info\|hint}[2][]` with `colback=<c>!5!white, colframe, fonttitle=\bfseries, boxrule=1pt, title=\textit{...}` |
| manual: option badges | doc/iodhbwm.tex:57-99 | `box.tcolorbox` | `\newtcbox{\setupOption}`, `{\classOption}`: `enhanced,breakable,on line,boxrule=0.4pt,left=5mm,arc=1pt,boxsep=1.5pt,colframe,coltext,colback=white` and an `overlay` key that fills a 5mm band at the left frame edge with one `\fontawesome` glyph (`font.icons`); closest call, see Verdict |
| manual: code boxes | doc/iodhbwm.tex:101-123 | `code.tcblisting` | `\newtcblisting{sourcecode}`: `colframe=darkgray, colback=darkgray!5!white, left=6mm`, `listing options={language={[LaTeX]TeX}, basicstyle, commentstyle, keywordstyle, numberstyle, identifierstyle, stringstyle, style=tcblatex, numbers=left, morekeywords}` |
| manual: margin note | doc/iodhbwm.tex:150 | `note.marginpar` | `\newcommand{\Version}[1]{\marginpar[\raggedleft v#1]{\raggedright v#1}}` (an alias) |
| manual: front matter | doc/iodhbwm.tex:158, :168-172, :176 | `abs.kernel` | `\maketitle` (skdoc), `abstract` env, `\tableofcontents` (`toc.kernel`), `\clearpage` (`pg.break`), `\vspace{2\baselineskip}` (`sp.manual-space`) |
| manual: lists | doc/iodhbwm.tex:190, :230, :412 | `list.enumitem` | `description[leftmargin=!, labelwidth=3.5cm]`, `[itemsep=1pt, style=multiline, leftmargin=3cm]`, `[noitemsep,style=multiline,leftmargin=1cm]`; also `list.kernel` itemize/enumerate (:320, :552) |
| manual: refs, notes | doc/iodhbwm.tex:8, :252, :324-325 | `xref.cleveref` | `cleveref[ngerman,noabbrev,nameinlink]`, `\Cref`; `\footnote{\label{}}` and `\footref` (`fn.kernel`) |
| manual: links, code text | doc/iodhbwm.tex:211, :624, :296 | `meta.url` | `\url`, `\href`, `\hyperlink`; `\verb` is `code.verbatim` |
| manual: index, changes | doc/iodhbwm.tex:153-156, :179, :715 | `idx.makeidx` | `\changes`, `\PrintChanges`, `\PrintIndex` from `skdoc`, built with the usual makeindex runs (standard TeX tool, as `bib.biblatex-biber` uses biber) |
| manual: class | doc/iodhbwm.tex:1 | `class.skdoc` | `babel=ngerman,highlight=false` |

## Bespoke code
Everything below sits in the CTAN-published bundle, so by W1 it is not bespoke; the Reduction column says what it comes to if one decomposed it anyway.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option parsing, flags, language list (`xstring`), hook loading (`scrlfile`) | tex/iodhbwm.cls:35-157, :262-300, :388-401 | published class (W1 holds); decomposed: partly | the user-facing part is declarative keys; the glue (`\AtEndPreamble`, `\AfterEndPreamble`, `\StrBehind` for the main language) is class internals the emitter does not reproduce |
| `\patchcmd{\@hex@@Hex}{f\else}{F\else}` | tex/iodhbwm.cls:202 | published; compatibility patch for old TeX Live (xcolor), no visible effect | none needed |
| `\appendix` patch, `\appendixmore` and `\addchaptertocentry` redefinition, `atoc` | tex/iodhbwm-templates.sty:451-490 | published; decomposed: no (it rewrites KOMA internals) | the visible result is `num.appendix` + KOMA `appendixprefix` + `toc.tocbasic` `atoc`; the redefinition itself has no lib way and rests on the class being published |
| `\dhbwsetup` keys, getters, `\dhbwprintintro` | tex/iodhbwm-templates.sty:107-444 | published (same CTAN bundle) | class-native vocabulary of `class.iodhbwm` |
| titlepage and declaration `.def` files | tex/i18n/{english,ngerman}/dhbw-*.def | published; reducible | `front.titlepage-env` + `sp.rule` + `box.minipage` + `fig.graphicx` + `tbl.tabularx` + `tbl.booktabs`; field-empty tests are `\ifcsempty` |
| language table | tex/iodhbwm-i18n.def:1-36 | published; reducible | `lang.babel` plus strings; only `ngerman` and `english` are supported, other languages fall back to German with a warning (:34-36) |
| `\ifbool{iodhbwm@cls@if@templates}{\DeclareCaptionFont...}` in a sample | doc/examples/listings/iodhbwm-listings-color.tex:18-28 | yes | `cap.caption` declarations with the class flag guard dropped (`load-dhbw-templates` is set at :10); `\lstset` colours (:31-40) are `code.listings` |
| user redefinitions for parts | doc/examples/customizing/iodhbwm-replace-part-naming.tex:22-33 | yes | see the part naming row |
| `\AtBeginDocument{\hypersetup{linkcolor=...}}` | doc/examples/references/iodhbwm-hyperref.tex:25-34 | yes | `color.xcolor` + `meta.hyperref` `linkcolor` |
| `\Version` alias | doc/iodhbwm.tex:150 | yes | `note.marginpar` |
| TikZ band in `\newtcbox` overlay | doc/iodhbwm.tex:72-76, :94-98 | yes (closest call) | `box.tcolorbox` `overlay` key: one `\fill` between `frame` anchors, one `font.icons` glyph; in the manual, not in the thesis template |

## Content-opaque
- Shipped assets: tex/dhbw-logo.png (the default logo), doc/examples/titlepages/img/penguin-158298-pixabay.png (sample institute logo); the default title page and several samples use `example-image` and `example-image-a` from the `mwe` package (tex/i18n/ngerman/dhbw-titlepage.def:9; doc/examples/abstract/iodhbwm-auto-sections-with-abstract.tex:71).
- Dummy text from `\blindtext`, `\lipsum`, `\Blinddocument`; sample bibliography `biblatex-examples.bib` (not shipped; a TeX Live file).
- Listing code in doc/examples/listings/*.tex (Java and C#), the abstract text, the sample names.

## Lib changes
- New ways proposed: none. `class.iodhbwm` and `class.skdoc` are class ways and need no proposal; the class vocabulary above is for the lib's class section. `acro` is filed under `idx.glossaries` (same family as `acronym`), `blindtext` under `draft.todo`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
