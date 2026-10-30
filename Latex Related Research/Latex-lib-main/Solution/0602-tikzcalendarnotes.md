yes

# 0602-tikzcalendarnotes: tikzcalendarnotes (CTAN package and its manual)

- Unverified: read from the source, not compiled.
- Source: Source/0602-tikzcalendarnotes/ (origin: https://mirrors.ctan.org/graphics/pgf/contrib/tikzcalendarnotes.zip; licence: AGPL-3 and/or LPPL 1.3c, README.md:43-47)
- Kind: misc (the sample is a package manual; the package it documents typesets calendars)
- Lib: v5
- Engine: pdfLaTeX-compatible (doc/tikzcalendarnotes.tex:4 `!TEX program = pdflatex`, biber backend at :7 and :36; the package uses only expl3 and pgf, latex/tikzcalendarnotes.sty:23, with no fontspec or Lua)
- Look carried by: mixed (article class; geometry and package loads in the sample preamble, doc/tikzcalendarnotes.tex:28-52; the manual look comes from the published package `codedescribe`; the calendars come from the published package `tikzcalendarnotes`, which the zip ships as its only .sty)
- Class origin: tex-distribution-unbundled (`article`, not in the zip)
- Main file: doc/tikzcalendarnotes.tex (other samples: none; doc/tikzcalendarnotes.pdf is the compiled manual, binary, not read)
- Read: main yes, zip-local classes and styles all (latex/tikzcalendarnotes.sty, lines 1-2162; no .cls in the zip)

## Verdict
yes. The sample is a plain `article` manual whose look is `geometry`, T1/utf8/lmodern and the published `codedescribe` package (lib way `dtx.doc`), with a `biblatex`/biber bibliography and `hyperref`. The calendars are made by the published CTAN package `tikzcalendarnotes` (W1: ctan.org/pkg/tikzcalendarnotes read, in TeX Live and MiKTeX; the zip comes from the CTAN mirror), driven only by key-value commands, so it is a way of type `cal.termcal` ("another configurable calendar-grid package is the parameter"). The sample defines no macro, counter or environment and draws nothing by hand; every in-scope component maps to a lib way and no ART, BESPOKE, EXTERNAL or UNMAPPED blocker is found.

## Blockers
none

## Class setting
- Class: `class.article` options: none (doc/tikzcalendarnotes.tex:28)
- Class-native vocabulary used: `\section`, `\subsection`, `\tableofcontents`, `\newpage`, `\footnote`, `\label`/`\ref`. The title block and the abstract do not use the class's `\maketitle` or `abstract`: they are `\tstitle` and `typesetabstract` from `codedescribe` (:55, :62).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | doc/tikzcalendarnotes.tex:28 | `class.article` | no options |
| page geometry | doc/tikzcalendarnotes.tex:29 | `page.geometry` | `\RequirePackage[verbose,a4paper,marginparwidth=28mm,top=3cm,bottom=1.5cm,hmargin={45mm,25mm},marginparsep=2.5mm,columnsep=10mm,asymmetric]{geometry}`; an older value set is commented out at :39 |
| encodings | doc/tikzcalendarnotes.tex:30-31 | `font.fontenc-t1` | `[T1]{fontenc}`, `[utf8]{inputenc}` |
| text font | doc/tikzcalendarnotes.tex:32 | `font.lmodern` | `\usepackage{lmodern}` (the manual advises it for the calendars, :80) |
| manual look (package) | doc/tikzcalendarnotes.tex:33 | `dtx.doc` | `\usepackage[infograb]{codedescribe}` (CTAN, TeX Live; scontents and listings inside, per its CTAN page) |
| title block | doc/tikzcalendarnotes.tex:55-59 | `dtx.doc` | `\tstitle{author={...\footnote{...}}, date={\tsdate}, title={The tikzcalendarnotes Package \break Version \PkgInfo{tikzcalendarnotes}{version}}}` |
| title line break | doc/tikzcalendarnotes.tex:58 | `sp.manual-space` | kernel `\break` in the title string |
| author footnote | doc/tikzcalendarnotes.tex:56 | `fn.kernel` | `\footnote{\tsverb{url}}` |
| abstract | doc/tikzcalendarnotes.tex:62-68 | `dtx.doc` | `typesetabstract` environment (two paragraphs) |
| contents | doc/tikzcalendarnotes.tex:70 | `toc.kernel` | `\tableofcontents`, defaults |
| headings | doc/tikzcalendarnotes.tex:72, :103, :147, :335, :359, :377, :574 | `head.kernel` | `\section` and `\subsection`, article defaults, no `\renewcommand`; `Ti{\itshape k}Z` inside a title at :359 |
| page breaks | doc/tikzcalendarnotes.tex:82, :573, :652, :733 | `pg.break` | `\newpage` |
| code storage and display | doc/tikzcalendarnotes.tex:74-78, :85-99, :126-142 | `dtx.doc` | `codestore[name]` environments, `\tscode*[codeprefix=]{name}`, `\tsmergedcode*[calendar keys]{{demoA}[1],{demoA}[2]}` |
| code key-word styling | doc/tikzcalendarnotes.tex:116-123 | `dtx.doc` | `\setnewcodekey{calendar keys}{texcs4=, keywd=, emph=, emph2=}` (string lists) |
| code execution and result | doc/tikzcalendarnotes.tex:133, :144, :615, :649, :728, :767 | `dtx.doc` | `\tsexec{name}[n]`, `\tsresult*{name}[n]` (the stored code is run and its output shown) |
| macro and key documentation | doc/tikzcalendarnotes.tex:148-153, :368-372 | `dtx.doc` | `codedescribe` environment (`[key]` option), `codesyntax`, `\tsmacro{\cmd}[oarg]{marg}` |
| option lists | doc/tikzcalendarnotes.tex:176-191, :208-221, :242-245, :265-273, :315-328 | `dtx.doc` | `describelist*{option}` with `\describe{key}{text}` |
| remarks | doc/tikzcalendarnotes.tex:157-159, :192-200 | `dtx.doc` | `tsremark` environment, optional title `[Defaults:]` at :374 |
| inline code marks | doc/tikzcalendarnotes.tex:64, :107, :311 | `dtx.doc` | `\tsobj[pkg\|key\|marg\|oarg\|verb\|meta\|option\|keyval,sep=,comma]{...}`, `\tsverb{...}` |
| emphasis | doc/tikzcalendarnotes.tex:64, :359 | `mark.kernel` | `\emph`, `\itshape` |
| inline maths | doc/tikzcalendarnotes.tex:111, :422, :430 | `math.kernel` | `$14$`, `$90^o$`, `$45^o$`; no amsmath loaded |
| cross-references | doc/tikzcalendarnotes.tex:280, :359, :468 | `xref.kernel` | `\label{tikz-styles}`, `\label{style:counters}`, `\ref{style:counters}` |
| link and PDF metadata | doc/tikzcalendarnotes.tex:52 | `meta.hyperref` | `\RequirePackage[hidelinks,hypertexnames=false]{hyperref}`, loaded last |
| list package (load only) | doc/tikzcalendarnotes.tex:34 | `list.enumitem` | `\usepackage{enumitem}`; the sample has no `\setlist`, no `itemize` or `enumerate` (grep) |
| bibliography | doc/tikzcalendarnotes.tex:36-37, :311, :360, :770; doc/tikzcalendarnotes.bib:21-29 | `bib.biblatex-biber` | `\RequirePackage[backend=biber]{biblatex}`, `\addbibresource{tikzcalendarnotes.bib}`, `\cite{TIKZPGF:3.1}`, `\printbibliography`; one `@manual` entry |
| calendar engine (preamble) | doc/tikzcalendarnotes.tex:47-50; README.md:21-26 | `cal.termcal` | `\usepackage{tikz}`, `\usetikzlibrary{calendar}`, `\usepackage{tikzcalendarnotes}` (the package loads only `pkginfograb`, latex/tikzcalendarnotes.sty:35; the user loads tikz) |
| calendar data sets | doc/tikzcalendarnotes.tex:127-129, :578-609, :738 | `cal.termcal` | `\defnewdataset{name}`, `\setdates[set]{date=,color=,round,square,remark=,notes=,mark style=}`, `\setranges[set]{from=,to=,round,remark=}`, `\sethighlightdates[set]{dates={...}}`, `\setcountingweeks[set]{from=,to=,down,color=,starting at=}`, `\suppresscounting[set]{from=,to=}`; commands at latex/tikzcalendarnotes.sty:1562-1652 |
| calendar body | doc/tikzcalendarnotes.tex:137, :626-638, :658-714, :740-755 | `cal.termcal` | `\calendarnotes[calendar notes, month label above centered, year label left corner, day names on top, every sunday=blue, keep counters]{with notes\|without notes, year=2025, number of months=n, per line=n, starting at=n, data set={...}}` inside a `tikzpicture` wrapper; command at latex/tikzcalendarnotes.sty:1706 |
| calendar defaults inside the package | latex/tikzcalendarnotes.sty:230-305, :1861-1934, :2081-2160 | `cal.termcal` | keys `year`, `starting at`, `number of months`, `per line`, `with notes` (25/36/20 pt), `without notes` (15/17/5 pt), `day spacing`, `week spacing`, `month spacing`, `data set`, `name`; styles `calendar notes`, `day names on top`, `week starts monday\|sunday` (default Sunday, :1932), `every sunday`, `every weekend`, `year label ...`, `every year/mark/remark/counter/note`, `remarks font size`, `notes font size`, `Xshift adjust`, `Yshift adjust`, `radius adjust` |
| floats, tables, theorems, lists, boxes, code listings | none in the sample | none | the sample has no `figure`, `table`, `theorem`, `itemize`, `enumerate` or listing environment of its own (grep, doc/tikzcalendarnotes.tex) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `tikzcalendarnotes.sty` (expl3 keys, datasets, pgf styles, `\matrix` of `\calendar`) | latex/tikzcalendarnotes.sty:21-2160 | not bespoke: published on CTAN (README.md:16; ctan.org/pkg/tikzcalendarnotes read), so it is the way `cal.termcal` (package as parameter), not zip-local code | the emitter writes `\usepackage{tikz}`, `\usetikzlibrary{calendar}`, `\usepackage{tikzcalendarnotes}` and the dataset and `\calendarnotes` calls above. It relies on pgf internals (`\tikz@lib@cal@xshift` at :1009, `pgf@sh@ns@` at :1333; the author's own comment at :1326-1328 calls this non-portable), which does not change the way |
| sample-side macros, counters, environments | doc/tikzcalendarnotes.tex | none defined | grep finds no `\newcommand`, `\def`, `\renewcommand`, `\newenvironment` or `\newcounter`; `\defnewdataset` at :127 and :578-580 is the package command, and `\setlength\PreviewBorder` at :97 sits inside a `codestore` that is only displayed |
| the "Advanced use" path `\calendarnotesprepare`, `\calendarnotessetifs`, `\calendarnotesdraw` | doc/tikzcalendarnotes.tex:338-357; latex/tikzcalendarnotes.sty:1675-1691 | not used by the sample | a user who draws their own calendar between these commands would extend the package; the sample does not, so it is outside this zip's recovery |

Remark (not a blocker): the manual's stated defaults for remark and note font sizes (doc/tikzcalendarnotes.tex:456 `\fontsize{5}{6}`, :485 `\fontsize{7}{7.2}`) differ from the package code (latex/tikzcalendarnotes.sty:2091 `3.5/4.2`, :2109 `4.5/4.95`); the code values are the ones an emitter would meet.

## Content-opaque
The example calendars (doc/tikzcalendarnotes.tex:137-139, :625-638, :657-714, :739-756) are package output inside `tikzpicture` wrappers with no hand-written `\draw` or node in the sample; they are held by `cal.termcal`, not `art.tikz`. If a reviewer reads them as picture content they are Content-opaque and still not ART. Sample dates, remarks and notes (`Exams Week!`, `FIS101 - cinematics`, `Valencia!`, :590-608) and the manual's prose are content.

## Lib changes
- New ways proposed: none (considered: `tikzcalendarnotes` as its own `cal.*` way; folded into `cal.termcal`, whose lib line already takes another configurable calendar-grid package as the parameter and gives `calendar-grid` with date events and ranges as the precedent; the consolidator may split it if it judges a pgf-calendar package a different type)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
