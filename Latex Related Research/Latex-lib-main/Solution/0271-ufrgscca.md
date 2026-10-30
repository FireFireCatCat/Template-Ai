yes

# 0271-ufrgscca: ufrgscca (UFRGS Engineering School final-work class, ABNT rules)

- Unverified: read from the source, not compiled.
- Source: Source/0271-ufrgscca/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ufrgscca.zip; licence: LPPL 1.3c and/or AGPL 3, README.md:51-57)
- Kind: thesis (the class is for undergraduate final works, README.md:3-4; the only sample is the bundle's own manual)
- Lib: v3
- Engine: pdfLaTeX-compatible (pdfTeX primitives `\pdfprotrudechars` `\pdfadjustspacing` at latex/ufrgscca-abnt.sty:214-215; WinEdt pragma `pdflatex` at doc/ufrgscca.tex:5; no fontspec, no Lua; needs a LaTeX kernel of 2026/06/01 or later, latex/ufrgscca.cls:25 and README.md:16-17; `biblatex` runs with `backend=biber`, abnt.sty:189-192)
- Look carried by: mixed (the class `ufrgscca` and its always-loaded `ufrgscca-abnt` carry headings, contents, lists, captions and language; the sample's own preamble adds `geometry` and the `codedescribe` documentation package, doc/ufrgscca.tex:34,38)
- Class origin: ctan (the zip is the CTAN release; ctan.org/pkg/ufrgscca read once: Alceu Frigeri, LPPL 1.3c and AGPL 3, in TeX Live and MiKTeX)
- Main file: doc/ufrgscca.tex (other samples: none; doc/ufrgscca.pdf is the built manual and was not opened)
- Read: main yes, zip-local classes and styles partly (read in full: ufrgscca.cls, -abnt.sty, -core.sty, -cover.sty, -lists.sty, -forms.sty, -base-en.def, -base-ptBR.def, -terms-en.tex, -cover-ptBR.tex; not read in full, outline by grep only or partial: -curr.sty read at lines 48-190 and 560-756, -coord.sty, -ppc.sty, -forms.tex and -terms-ptBR.tex lines 25-60; none of those five is loaded on the sample's path)

## Verdict
The zip is the CTAN release of the published class `ufrgscca` (and its auxiliary packages), so the class is one way, `class.ufrgscca`; the code inside it (expl3 property lists, `starray`, coffin cover layout) is part of a published class and is not counted as zip-local bespoke code. The sample is the bundle's manual: class options, a `geometry` call, the published `codedescribe` documentation package, one executed `enumerate` and the class's own heading, contents and list looks; its only own macros are two `\newif` constants that an emitter flattens. `codedescribe` has no lib line and is proposed as `dtx.doc`; every other component maps to an existing way, and no `ART` or irreducible code is on the sample's path.

## Blockers
none

Recorded, not counted (read as bounds on this verdict):
- Out of path. `ufrgscca-forms`, `-coord`, `-ppc`, `-curr` are not loaded by the class (latex/ufrgscca.cls:309-318) and the sample loads them only under `\ifversiontest`, which is set false (doc/ufrgscca.tex:46-48, 51-57). They were read only in part. A sample that loads them needs its own judgement: `ufrgscca-curr.sty:662-755` draws a data-driven TikZ dependency graph (`tikzGraphSem`, `\GraphEtp`) and `ufrgscca-ppc.sty:621-627` and :434,501 draw `mdframed` TikZ boxes, which would be `ART` candidates; `ufrgscca-coord.sty` (grade, sort and calendar reports) and `ufrgscca-forms.sty:273-322` are expl3 report and form generators.
- Optional class loads not exercised by the sample: `xpacks` loads `circuitikz`, TikZ libraries, `mathtools`, `amsthm` and more (ufrgscca.cls:321-347); `xlists` loads `newfloat`, `listings`, `xcolor` (ufrgscca.cls:311-314, ufrgscca-lists.sty:67-69); `showframes` loads `showframe` and `showlabels` loads `showlabels` (ufrgscca-abnt.sty:224-234); `timesroman` loads `mathptmx` (ufrgscca.cls:256-268).
- `biber` is needed by the unconditional `biblatex` load (abnt.sty:189-192). The lib lists `bib.biblatex-biber` as an ordinary way, so it is not `EXTERNAL`; the sample has no `\printbibliography` and no `\addbibresource` (grep, doc/ufrgscca.tex), and its one `\textcite` sits in stored display code (doc/ufrgscca.tex:891).
- `\IfFileExists{local.tex}` loads a user data file at begin document (ufrgscca.cls:385-392); no `local.tex` is in the zip.

## Class setting
- Class: `class.ufrgscca` options: `article,nofontwarning,nogeometry,english,tocdepth=3,secdepth=3` (doc/ufrgscca.tex:33). Other options the class declares: `oneside`, `relnum`, `pretextontoc`, `timesroman`, `yearsonly`, `strict-abnt`, `repeatfields`, `chapternopagenum`, `nomicrotype`, `showframes`, `showlabes` (spelled so in the source, ufrgscca.cls:210), `xlists`, `xpacks`, `nolocal`, `report`, `internship`, `nonrequired`, `texlive`, `overleaf`, `miktex`, `oldrenews`; unknown options go to the base class (ufrgscca.cls:173-251). It loads `class.article` at 12pt under option `article` and `report` at `12pt,twoside,openright` otherwise (ufrgscca.cls:272-278).
- Class-native vocabulary used: `\tightul` (section titles, doc/ufrgscca.tex:109,211,518,762,822,869), `\autonameref` (:934,947, defined ufrgscca.cls:360), `\monthname` (:65,71, defined ufrgscca-abnt.sty:789), enumitem keys `tcc` `arabic` `alpha*` `miditemsep` `noitemsep` `bullet` `roman` `Roman` `parindent` `noindent` (:392-507, 937-945, defined ufrgscca-abnt.sty:586-634). Documented but only shown in stored code, not executed: `\nonum` `\notoc` (:278-279), `\mainkeyword` (:250,330; the source defines `\mainkeywords`, ufrgscca-abnt.sty:657), `mainabstract`, `otherabstract`, `\NewChapListEnv`, `\MakeCoverPages`, `\student` family, `codelist`.
- Published package vocabulary used (`codedescribe`, source not in the zip): see rows marked `dtx.doc`.

## Component map
Rows for the class name the lib way that realises the part inside the class; an emitter reaches all of them with the one `class.ufrgscca` line. Package options are read from the `\RequirePackage` lines; the sources of `codedescribe`, `titlesec`, `enumitem` and the other loaded packages are not in the zip and were not read.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/ufrgscca.tex:33 | `class.ufrgscca` | `article,nofontwarning,nogeometry,english,tocdepth=3,secdepth=3` |
| base class | latex/ufrgscca.cls:272-278 | `class.article` | `\LoadClass[12pt]{article}` (option `article`); `report` with `12pt,twoside,openright` otherwise (:277) |
| type size | latex/ufrgscca.cls:274 | `page.class-options` | `12pt`; paper comes from `geometry` |
| margins | doc/ufrgscca.tex:34; latex/ufrgscca-abnt.sty:116-122 | `page.geometry` | sample: `a4paper,margin=5cm,right=2cm,marginparwidth=3.5cm,asymmetric,top=2.5cm,bottom=1.5cm`; the class's own call (`a4paper,inner=2.5cm,outer=2.5cm,top=3cm,bottom=2cm,twoside`, :121; `strict-abnt`: inner 2cm, outer 3cm, :116) is skipped by `nogeometry` (:119) |
| running head and folio | latex/ufrgscca-abnt.sty:500-532 | `hf.titleps` | titlesec `pagestyles` commands: `\newpagestyle{main}` with `\sethead[...]{}{}{\ifthechapter{\sffamily\thepage}{}}`, `\pagestyle{main}` (:511-532); `bibliography` style (:522-530); `plain` emptied unless `chapternopagenum` (:535-538) |
| headings | latex/ufrgscca-abnt.sty:381-475; doc/ufrgscca.tex:89,106,949 | `head.titlesec` | `\titleformat`/`\titlespacing`: chapter `\sffamily\bfseries\Large` upper case, spacing 70pt plus 12pt minus 8pt before, 36pt plus 8pt minus 8pt after (:388-403); section `[hang]` `\normalfont\scshape\large` (:411-415); subsection `\sffamily\bfseries\slshape` (:433-437); subsubsection `\sffamily\slshape` (:444-448); paragraph and subparagraph `\sffamily` with `\tightul` (:455-470); section skips 27pt plus 6pt minus 6pt, 18pt plus 4pt minus 4pt (:383-384) |
| numbering depth | doc/ufrgscca.tex:33; latex/ufrgscca-abnt.sty:91-92,243-244 | `num.secnumdepth` | `tocdepth`=3 and `secnumdepth`=3 from the options (class defaults 3 and 4) |
| unnumbered headings | latex/ufrgscca-abnt.sty:246-267 | `num.secnumdepth` | `\nonum` and `\notoc` wrap a heading in a group with `secnumdepth` -1 and `\addtocontents{toc}{\protect\setcounter{tocdepth}{-1}}`; not executed in the sample body |
| contents | doc/ufrgscca.tex:87 | `toc.kernel` | `\tableofcontents` |
| contents styling | latex/ufrgscca-abnt.sty:294-333 | `toc.titletoc` | `\contentsmargin{2.2em}`, label margin 22mm, dot spacing 0.5pc; `\titlecontents` chapter (small caps) and section; `\dottedcontents` subsection, subsubsection, figure, table |
| appendix and annex | latex/ufrgscca-abnt.sty:125,339-366 | `num.appendix` | `appendix` package `[toc,page,title]`; `appendix` and `annex` environments wrap `appendices` and set the chapter format; documented only (doc/ufrgscca.tex:362-368) |
| float numbering | latex/ufrgscca-abnt.sty:480-493 | `num.counters` | `\counterwithin`/`\counterwithout` of figure, table, equation in chapter; skipped under `article` (:480) |
| lists | doc/ufrgscca.tex:937-945,392-409; latex/ufrgscca-abnt.sty:128,580-634 | `list.enumitem` | `enumitem[inline]`; keys by `\SetEnumitemKey`: `tcc`/`ppc` `leftmargin=12mm,labelindent=6mm,labelsep=2.5mm,labelwidth=!,style=nextline` (:593-594, values :580-583), `parindent` (:596), `noindent` (:598), `tight` (:600), `miditemsep` `parsep=0ex,itemsep=0.4ex` (:603-604), label keys `arabic` `roman` `Roman` `alpha` `Alpha` with `)`, parenthesis and `*` forms (:609-633), `bullet` `label=\hfill\textopenbullet` (:634); sample body uses `[tcc,arabic,miditemsep]` with nested `[tcc,alpha*,noitemsep]` |
| paragraph indent | latex/ufrgscca-abnt.sty:584 | `sp.lengths` | `\setlength{\parindent}{12mm}` |
| text font | latex/ufrgscca.cls:270 | `font.lmodern` | default (`timesroman` would load `mathptmx`, :265) |
| encodings | latex/ufrgscca.cls:56-57 | `font.fontenc-t1` | `fontenc` T1, `inputenc` utf8 |
| microtype | latex/ufrgscca-abnt.sty:203-215 | `sp.microtype` | `[tracking,kerning,spacing,babel]` unless `timesroman` or `nomicrotype`; the class also sets the pdfTeX switches `\pdfprotrudechars=2` and `\pdfadjustspacing=2` itself (:214-215), inside the class |
| underline | latex/ufrgscca-abnt.sty:221,642-646 | `mark.ulem` | `soul`: `\setul{0.355ex}{0.075ex}`, `\ul` inside `\tightul` |
| underline outline | latex/ufrgscca-abnt.sty:220,639-646 | `mark.contour` | `\contourlength{0.17ex}`, `\contournumber{96}`, `\contour{white}{#1}` |
| captions | latex/ufrgscca-abnt.sty:140 | `cap.caption` | `position=above,font=small,labelfont=bf,textfont=md,textfont+=sl,width=0.75\textwidth` (:135-138 sets the widths); no float is executed in the sample |
| source and note lines | latex/ufrgscca-abnt.sty:146-161 | `box.minipage`, `font.size-commands`, `sp.lengths` | `\sourcecitation` = `\small` line; `\note[#1]{}` = `\footnotesize`, centred `minipage` of 0.635\textwidth with a negative `\parindent` set by `\settowidth`; not executed in the sample |
| tables | latex/ufrgscca-abnt.sty:169-178 | `tbl.tabular` | `array` with `\newcolumntype` `P` `B` `C` `R` `L` `J` (`p` columns with `\raggedleft`, `\bfseries`, `\centering`, `\raggedright`); no table is executed |
| table cell spacing | latex/ufrgscca-abnt.sty:170-171 | `tbl.nicematrix` | `nicematrix` loaded, `\NiceMatrixOptions{cell-space-limits=1pt}` |
| new float type | latex/ufrgscca-lists.sty:74-84,106 | `fig.newfloat` | `\DeclareFloatingEnvironment[fileext,listname,name,placement=htb,chapterlistsgaps=off]`; `within=chapter` under `relnum`, else `none`; `codelist` env; not loaded by the sample (no `xlists`, doc/ufrgscca.tex:33) |
| listing style | latex/ufrgscca-lists.sty:89-101 | `code.listings` | `\lstset{basicstyle=\ttfamily\small,columns=fullflexible,keepspaces=true,frame=tb,inputencoding=latin1,extendedchars=true,backgroundcolor=\color{lstgray},breaklines=true}`; not loaded by the sample |
| listing colour | latex/ufrgscca-lists.sty:89 | `color.xcolor` | `\definecolor{lstgray}{rgb}{0.965,0.965,0.965}`; not loaded by the sample |
| bibliography | latex/ufrgscca-abnt.sty:184-193,545 | `bib.biblatex-biber` | `backend=biber,style=abnt,pretty,giveninits,extrayear` (+`repeatfields`); `\defbibheading{bibliography}[\refname]{\nonum\chapter{#1}\pagestyle{bibliography}}`; none printed by the sample |
| language | latex/ufrgscca-abnt.sty:100-110; latex/ufrgscca-base-en.def:37-58 | `lang.babel` | `[brazilian,main=english]` under option `english` (default `[english,main=brazilian]`); `\AtBeginDocument{\selectlanguage{english}\input{ufrgscca-base-en.def}}`; caption and term names set by `\def` (`\abstractname` Abstract, `\contentsname` Contents, `\figurename` Figure, `\tablename` Table, `\keywordsname` Keywords, `\sourcename` Source:, `\notename` Note) |
| quotation marks | latex/ufrgscca-abnt.sty:112 | `lang.csquotes` | `csquotes` loaded, no options |
| PDF links | latex/ufrgscca.cls:355 | `meta.hyperref` | `[hidelinks,hypertexnames=false]` |
| url | doc/ufrgscca.tex:64 | `meta.url` | `\url{...}` inside a footnote in the author field |
| labels and references | doc/ufrgscca.tex:539,629 | `xref.kernel` | `\label{activity-def}`, `\ref{activity-def}` |
| name references | doc/ufrgscca.tex:934,947; latex/ufrgscca.cls:360-362 | `xref.hyperref` | class `\autonameref[sep]{label}[spc]` = `\autoref{label}` + sep + `\nameref{label}`; `\annexref` = `\hyperref[#1]{\defannexname\ \ref*{#1}}` |
| title block | doc/ufrgscca.tex:63-74 | `dtx.doc` | `\tstitle{author={...\footnote{\tsfmt{\url{...}}}},date={\monthname\space\number\year},title={... Version \PkgInfo{ufrgscca}{version} ...}}`; two forms chosen by `\iffulldoc` (the sample takes the first) |
| abstract | doc/ufrgscca.tex:82-85 | `dtx.doc` | `tsabstract` environment |
| publication date | doc/ufrgscca.tex:65,71; latex/ufrgscca-abnt.sty:743-834 | `front.class-native` | class `\monthname` (`\ifcase\month`, English names under `english`, :786-795), `\today`, `\pubdate[day]{month}{year}` (:762-779); the sample prints `\monthname\space\number\year` |
| doc preamble load | doc/ufrgscca.tex:38 | `dtx.doc` | `\usepackage[infograb]{codedescribe}` |
| command and environment entries | doc/ufrgscca.tex:183-197,248-254,598-603 and throughout | `dtx.doc` | `codedescribe` environment with optional kind (`code`, `env`, `new=`, `update=`) and a comma list of names, `codesyntax` body, `\tsmacro` `\tsobj[kind]` `\tsargs[oarg\|marg]` `\tsmeta` `\tsverb` inline markup |
| option and key lists | doc/ufrgscca.tex:117-180,371-379,386-389,773-779 | `dtx.doc` | `describelist{option\|value\|key}` and the starred `describelist*` (:840,1276) with `\describe{name}{text}` |
| remark boxes | doc/ufrgscca.tex:94-104,255-257,317-319,757-759 | `dtx.doc` | `tsremark` with optional title (`[N.B.:]`, `[\color{red}Version 2.0:]`) |
| stored code and demos | doc/ufrgscca.tex:277-294,391-413,523-539 | `dtx.doc` | `codestore[st=name]` stores code, `\tscode*[emph=,codeprefix=,basicstyle=]{name}` prints it, `\tsdemo[emph=]{name}` prints and runs it |
| page break | doc/ufrgscca.tex:431 | `pg.break` | `\newpage` |
| inline marks | doc/ufrgscca.tex:90,92 and throughout | `mark.kernel` | `\emph`, `\textbf` |
| footnote | doc/ufrgscca.tex:64,70 | `fn.kernel` | `\footnote` in the author field |
| colour | doc/ufrgscca.tex:98; latex/ufrgscca-abnt.sty:233 | `color.xcolor` | `\color{red}` in a remark title; which loaded package supplies `\color` on the sample's path is not established (the class loads `xcolor` only under `xlists`, lists.sty:69) |
| inline maths | doc/ufrgscca.tex:134 | `math.kernel` | `$\dots$` |
| keywords and class abstracts | latex/ufrgscca-abnt.sty:652-726 | `abs.class-native`, `abs.keywords` | `mainabstract`/`otherabstract[lang]` = unnumbered chapter + `\abstractname`, keywords line `\textbf{\keywordsname:}` from `\mainkeywords`/`\otherkeywords` sorted by `\seq_sort:Nn`; not executed in the sample |
| cover, approval and description pages | latex/ufrgscca-cover.sty:83-233; latex/ufrgscca-cover-ptBR.tex:156-342 | `front.class-native` | `\MakeCoverPages{tccI\|tccII\|internship\|internship-opt\|class-report}`, `\SetCoverFields{type}{field}{code}`; page parts are `\vcoffin` boxes joined with offsets of 0.29, 0.42, 0.54 of `\textheight`; not called by the sample |
| student, advisor, activity data | latex/ufrgscca-core.sty:84-259,367-384 | `front.class-native` | `\student` `\studentinfo` `\advisor` `\coadvisor` `\examiner` `\NewActivity` `\ActivitySet`... fill `starray` stores printed on the cover pages; not used by the sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newif\iffulldoc`, `\fulldoctrue` | doc/ufrgscca.tex:42-44, used at 62,68,906,926,929,1547 | yes | a content switch with a constant value: emit the true branch (full title, extended sections) and drop the other |
| `\newif\ifversiontest`, `\versiontestfalse` | doc/ufrgscca.tex:46-48, used at 51-57,76-80 | yes | constant false: the branch (package loads and an expl3 `\clist_map_inline:nn` of `\PkgInfoDescription`, :77-79) is dead and is dropped |
| `\tightul`, `\nonum`, `\notoc`, `\autonameref`, `\annexref`, `\note`, `\sourcecitation`, enumitem keys, page styles, titlesec and titletoc settings | latex/ufrgscca-abnt.sty:146-161,246-267,586-646; latex/ufrgscca.cls:360-362 | not counted | published, inside `class.ufrgscca` (CTAN release); each is also a composition of lib ways listed in the map (`list.enumitem`, `mark.ulem`, `mark.contour`, `num.secnumdepth`, `xref.hyperref`) |
| `\SetHeadings` `\SetTerms` `\SetLabels` `\SetConsts` `\UseConst`, `starray` stores, coffin cover layout, `\keys_define:nn` options | latex/ufrgscca.cls:60-252; latex/ufrgscca-core.sty:84-259; latex/ufrgscca-cover.sty:83-233 | not counted | published class internals (expl3), reached through `class.ufrgscca`; nothing of it is re-implemented by an emitter |
| `silence` package, `\WarningFilter` calls | latex/ufrgscca.cls:297-306 | not counted | log filters with no effect on the printed page |
| package-info store `\pkginfograbProvidesExplClass`, `\PkgInfo` | latex/ufrgscca.cls:36-44; doc/ufrgscca.tex:66,72,92 | not counted | published (`pkginfograb`, and the `infograb` option of `codedescribe`); `\PkgInfo{ufrgscca}{version}` prints the string `2.13a` (content) |

## Content-opaque
none (the stored `lstlisting`, `starray` and expl3 snippets in `codestore` blocks, doc/ufrgscca.tex:523-588,880-922, are displayed code text; no TikZ, image or table is executed in the sample)

## Lib changes
- New ways proposed: `dtx.doc` the `codedescribe` package (CTAN and TeX Live, ctan.org/pkg/codedescribe read once: Alceu Frigeri, version 1.24c, LPPL 1.3c and AGPL 3, expl3, uses `scontents` and a listing package, no external tool), engine pdf. It documents a package or class: preamble `\usepackage[infograb]{codedescribe}` and body `\tstitle{author,date,title}`, `tsabstract`, `codedescribe`/`codesyntax`, `describelist`/`describelist*` with `\describe`, `tsremark`, `codestore` with `\tscode*` and `\tsdemo`, inline `\tsmacro` `\tsobj` `\tsargs`. W1: published on CTAN and in TeX Live. W2: chosen by one package option, environment arguments and key=value lists (`\tscode*[emph,codeprefix,basicstyle]`, `\tstitle` keys), not by editing its code. W3: serves the manual of any package or class, not this one bundle. W4: one preamble line plus body wrappers an emitter can print. It is a way apart from `dtx.doc`, which is `doc.sty` over `.dtx` sources with `\DocInput`; `codedescribe` works on a plain `.tex` manual. Its source is not in the zip and was not read, so the vocabulary is taken from how the sample uses it.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
