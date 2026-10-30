yes

# 0018-fhj-script: FHJ-Script (FH JOANNEUM classes `fhjbook`, `fhjpaper` and package `fhjcommon`)

- Unverified: read from the source, not compiled. No TeX engine was run and none is installed here.
- Source: Source/0018-fhj-script/ (origin: https://mirrors.ctan.org/macros/latex/contrib/fhj-script.zip; licence: lppl1.3)
- Kind: thesis (the hint said journal; the bundle's main class `fhjbook` is a master-thesis class, `fhjpaper` is a short two-column paper / exposé class)
- Lib: v1
- Engine: pdfLaTeX-compatible (no `fontspec`, no Lua; needs a LaTeX format of 2023-11-01 or later: fhjcommon.dtx:22, fhjpaper.dtx:25, fhjbook.dtx:25)
- Look carried by: class (the zip is the DocStrip source of two published classes and one published package; the look is the code generated from the .dtx files by fhj-script.ins:46-48, on top of KOMA `scrartcl` and `scrbook`)
- Class origin: ctan (https://ctan.org/pkg/fhj-script, read once: "FHJ-Script", version 4.3d 2026-10-05, LPPL 1.3, listed as included in TeX Live and MiKTeX; version and date match the `\ProvidesClass` lines at fhjpaper.dtx:28 and fhjbook.dtx:28)
- Main file: none (no .tex sample exists; the zip holds fhjbook.dtx, fhjpaper.dtx, fhjcommon.dtx, fhj-script.ins, README.md and PDFs). The documentation boilerplate at fhjbook.dtx:307-317, :476-500 and fhjpaper.dtx:112-126, :367-372 stands in for a sample; the `ltxdoc` drivers at fhjcommon.dtx:26-36, fhjpaper.dtx:31-40, fhjbook.dtx:31-41 are build files, not templates. (other samples: none)
- Read: main no-sample (documentation boilerplate read), zip-local classes and styles all (no separate .cls or .sty ships; the code is the unprefixed lines of the three .dtx files, all 1467 lines read in full, plus fhj-script.ins and README.md). Not read: the three compiled .pdf manuals, the two logo PDFs, and the sources of `scrartcl`, `scrbook`, `scrlayer-scrpage`, `hyperref` (published, not bundled).

## Verdict
The zip is the CTAN release of `fhj-script`, so `fhjpaper`, `fhjbook` (classes) and `fhjcommon` (package) are published (W1) and nothing in it is unpublished. They are two class ways, `class.fhjpaper` over `class.scrartcl` and `class.fhjbook` over `class.scrbook`, whose native commands take only strings and lists (declarative, W2). An emitter writes `\documentclass[...]{fhjbook}` or `{fhjpaper}` plus the class's own commands and copies no macro logic, so this is evidence about the class dimension, not about the component ways. Every part of the class and package code also decomposes into existing lib ways (table below); the author-list formatter is the one piece that needs the class if its `\authorsnames` interface must be kept. No artwork defines the template, nothing needs a tool outside TeX, and no new way is needed.

## Blockers
none

Recorded, not counted:
- Author and affiliation list formatter (fhjpaper.dtx:216-343) is hand-rolled list logic (etoolbox `\forcsvlist` `\listadd` `\dolistloop`, a two-list zipper, a catcode switch). It would be `BESPOKE/class` if the class were zip-local; it is inside a published CTAN class, so by the rubric (W1) it is not bespoke. By components it reduces as output (see Bespoke code).
- README.md:35 names `l3build` for build and publishing; no `build.lua` ships and fhj-script.ins runs on plain DocStrip, so nothing outside TeX is needed to use the classes. Not `EXTERNAL`.
- `\printbibliography` (fhjbook.dtx:500) and `\printacronyms` (fhjbook.dtx:484) appear only in documentation boilerplate; the classes load neither `biblatex` nor an acronym package. `biber` is the usual backend for `biblatex` but the zip does not say which backend is meant.

## Class setting
- Class: `class.fhjpaper` options: every option is forwarded to `scrartcl` (fhjpaper.dtx:73-74); hard-coded base-class options `a4paper,twocolumn,fontsize=9pt,DIV=16` (fhjpaper.dtx:89). Base class `class.scrartcl`.
- Class-native vocabulary used (`fhjpaper`): preamble `\FHJProgram{code}` (fhjcommon.dtx:106, e.g. `DAT-25` at fhjpaper.dtx:125), `\title{}` redefined (fhjpaper.dtx:134), `\shorttitle{}` optional (:143-144), `\authorsnames[superscripts]{names}` (:247-255), `\authorsaffiliations{list}` (:258-263); body `\maketitle` through redefined `\@maketitle` (:375-395).
- Class: `class.fhjbook` options: every option is forwarded to `scrbook` (fhjbook.dtx:70-71); hard-coded `a4paper,DIV=14,BCOR=10mm` (fhjbook.dtx:87); `twoside` recommended, not forced (:84). Base class `class.scrbook`.
- Class-native vocabulary used (`fhjbook`): preamble `\FHJProgram{code}`, `\title`, `\subtitle` (fhjbook.dtx:232-234), `\author{First SURNAME}`, `\authorinfo{gender}{matriculation}{cohort year}` (:238-243), `\supervisor{name}{gender}` (:246-250), `\cosupervisor{name}{gender}` (:254-259), `\date`, `\FHJLocation{}` (:271-273), `\FHJAbstractDE{text}{kw,kw}` and `\FHJAbstractEN` (:404-412); body `\FHJMakeTitlePage` (:331-392), `\FHJMakeDeclaration` (from fhjcommon.dtx:303-311), `\FHJMakeAbstract` (:430-446), `\FHJThesisFrontMatter` (:457-464); inherited from `scrbook`: `\frontmatter` `\mainmatter` `\appendix` `\chapter` (fhjbook.dtx:309-314, :477-478).
- Package `fhjcommon` (published, loaded by both classes: fhjpaper.dtx:98, fhjbook.dtx:103) is not a class; its commands are listed in the map, each reduced to lib ways.

## Component map
Each row names the lib way that realises the part. An emitter reaches the class rows with one `\documentclass` line; the component ways show what the class sets inside. Base-class internals (KOMA) are inferred from the commands the .dtx calls, since their sources are not in the zip.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| paper class | fhjpaper.dtx:26-28, :73-74 | `class.fhjpaper` | forwards unknown options to `scrartcl`; own vocabulary above |
| paper base class | fhjpaper.dtx:89 | `class.scrartcl` | `a4paper,twocolumn,fontsize=9pt,DIV=16` |
| paper size, font size | fhjpaper.dtx:89 | `page.class-options` | `a4paper`, `fontsize=9pt` (KOMA option) |
| columns | fhjpaper.dtx:89 | `cols.twocolumn-option` | `twocolumn` |
| type area | fhjpaper.dtx:89 | `page.typearea` | `DIV=16` |
| footer | fhjpaper.dtx:100-101, :353-354 | `hf.scrlayer-scrpage` | `pagestyleset=standard`; `\ofoot{\FHJ@ShortTitle}` (empty when `\shorttitle` is absent, :143-144, :47-48); `\ifoot{\FHJProgramLong}`; the prose at :348 says the program name is in the header, the code sets a footer |
| section numbering depth | fhjpaper.dtx:355 | `num.secnumdepth` | `secnumdepth` 2 (subsection) |
| links | fhjpaper.dtx:102-103 (also fhjbook.dtx:104-105) | `meta.hyperref` | `hidelinks` |
| title text | fhjpaper.dtx:134, :153-157 | `front.class-native` | `\title` re-wraps its argument in braces so `\\` breaks lines (three lines advised, :130-131); fallback "Title" with a class warning |
| authors line | fhjpaper.dtx:247-255, :297-328 | `front.class-native` | `\authorsnames[1,{2,3},1]{A,B,C}`; names joined by ", " and a last separator "and" or "und"; `\textsuperscript` marks; plain names when no superscripts; count mismatch is a class error (:221-232) |
| affiliations lines | fhjpaper.dtx:258-263, :330-343 | `front.class-native` | `\authorsaffiliations{{A},{B}}`; one line per affiliation, `\textsuperscript{n}` prefix when superscripts are used |
| title block layout | fhjpaper.dtx:375-395 | `front.maketitle` + `front.class-native` | kernel `\maketitle` calls the redefined `\@maketitle`: `\cleardoublepage` (`pg.break`), three centred `minipage{\textwidth}` blocks (`box.minipage`); title `\fontsize{14}{18}\selectfont\textbf` (`font.size-commands`, `mark.kernel`); `\vspace` 1em, 1em, 2em (`sp.manual-space`) |
| paper abstract | fhjpaper.dtx:119-120 (prose only) | `abs.kernel` | no abstract code in the zip; the base class `abstract` environment applies |
| book class | fhjbook.dtx:26-28, :70-71 | `class.fhjbook` | forwards unknown options to `scrbook`; own vocabulary above |
| book base class | fhjbook.dtx:87 | `class.scrbook` | `a4paper,DIV=14,BCOR=10mm` |
| paper size | fhjbook.dtx:87 | `page.class-options` | `a4paper` |
| type area, binding | fhjbook.dtx:87 | `page.typearea` | `DIV=14`, `BCOR=10mm` |
| running heads | fhjbook.dtx:90-95 | `hf.pagestyle-kernel` | `\pagestyle{headings}` (KOMA's own heading style, set globally); `\thispagestyle{empty}` on the title page (:333) |
| links | fhjbook.dtx:104-105 | `meta.hyperref` | `hidelinks` |
| array and long tables | fhjbook.dtx:106-107 | `tbl.tabular` + `tbl.longtable` | `array`, `supertabular` loaded, unused by the class code (the acronym table at :484 uses the `supertabular` template) |
| language | fhjbook.dtx:126-135, :335-390; fhjcommon.dtx:221 | `lang.babel` + `font.fontenc-t1` | user loads `[T1]{fontenc}` and `babel` with `ngerman` or `english` only; every label is chosen by `\iflanguage` |
| title page | fhjbook.dtx:331-392 | `front.class-native` | `\FHJMakeTitlePage`: `center`; logo by language at 70mm; "MASTERARBEIT" / "MASTER'S THESIS" bold; title bold `\fontsize{16}{20}`; optional subtitle `\large`; "Eingereicht bei" / "Submitted at" `\footnotesize`; `\FHJ`, programme name; author label by gender (Autor, Autorin, Autor:in), matriculation, cohort `\FHJProgramShort`; supervisor and optional second supervisor; `\vfill`; location, date, `\hfill` "Unterschrift" / "Signature" |
| title page logo | fhjbook.dtx:335-336 | `fig.graphicx` | `\includegraphics[width=70mm]{fhjInformaticsLogo.de.img.pdf}` or `.en.`; `graphicx` is loaded by neither class nor `fhjcommon` (not in :102-110, fhjcommon.dtx:73-75), so the user preamble must load it; logos ship in the zip |
| title page spacing, boxes | fhjbook.dtx:337-391 | `sp.manual-space` + `box.minipage` + `font.size-commands` + `mark.kernel` | `\\[10mm]`, `\\[5mm]`, `\\[2mm]`, `\vspace*{15mm}`, `\vfill`, `\hfill`; `minipage{\textwidth}` for the title; `\large`, `\footnotesize`, `\textbf` |
| declaration page | fhjcommon.dtx:228-311 | `front.dedication` | `\FHJMakeDeclaration`: `\cleardoublepage` before and after, group with `\parindent` 0pt, German or English declaration of honour chosen by `\iflanguage`; text is content |
| declaration page parts | fhjcommon.dtx:229-301 | `list.kernel` + `mark.kernel` + `sp.manual-space` + `sp.lengths` + `pg.break` | `itemize`; `\underline{\textbf{}}` heading; `\vfill`, `\hfill` signature line; `\setlength{\parindent}{0pt}`; `\cleardoublepage` |
| abstract pages | fhjbook.dtx:404-412, :430-446 | `abs.class-native` | `\FHJMakeAbstract`: `\cleardoublepage`; hand-set `\textbf{\Large Kurzfassung:}\\[5mm]`, text, `\vfill`, keywords, `\clearpage`, `\textbf{\Large Abstract:}`, same again, `\cleardoublepage`; `\parindent` 0pt in a group; both languages always printed; no `abstract` environment |
| keywords line | fhjbook.dtx:414-428 | `abs.keywords` | comma list printed as `Schlüsselwörter:` / `Keywords:` in italics, items separated by a vertical bar between spaces (`\space$\vert$\space`) |
| front-matter bundle | fhjbook.dtx:457-464 | `front.class-native` | `\FHJThesisFrontMatter` = title page, declaration, abstracts |
| front and main matter | fhjbook.dtx:307-322 | `class.scrbook` | `\frontmatter` (roman page numbers), `\mainmatter` (arabic): KOMA, no zip code (`pgnum.pagenumbering` is its effect, inside the base class) |
| contents and lists | fhjbook.dtx:311-313 | `toc.kernel` | `\tableofcontents` `\listoftables` `\listoffigures` |
| appendix | fhjbook.dtx:476-481 | `num.appendix` + `head.kernel` | `\appendix`, `\chapter{Appendix}`, `\section{Source Code}` |
| acronym list | fhjbook.dtx:484 | `idx.glossaries` | `\printacronyms[template=supertabular,heading=section]`: documentation boilerplate; package not named in the .dtx and not loaded by the class (the keys `template` and `heading` look like `acro`; an acronym-package family member, inferred) |
| bibliography | fhjbook.dtx:496-500 | `bib.biblatex-biber` | `\printbibliography[heading=bibnumbered]`; user loads `biblatex`; backend not stated; the thesis guide `fhj_guide.pdf` (:492) is not in the zip |
| book headings, lists, captions, floats, maths | no zip code | `class.scrbook` | base-class defaults; `fhjbook` sets none of them |
| program name table | fhjcommon.dtx:104-142, :169-202 | none (content lookup) | `\FHJProgram{DAT-25}` sets `\FHJProgramLong` and `\FHJProgramShort` from six registered codes (:196-201); `ITP` is the institute (:107-110); `\FHJDefineProgram{code}{short}{long}` registers more; plain text substitution |
| institution names | fhjcommon.dtx:454-455 | none (content) | `\FHJ` = FH JOANNEUM, `\FHJInstitute` = IT+ |
| code libraries | fhjcommon.dtx:73-75; fhjpaper.dtx:99; fhjbook.dtx:106-109 | none (no look) | `xstring`, `ifthen`, `calc`, `etoolbox` drive the class code only |
| exercise header | fhjcommon.dtx:347-362 | `box.minipage` + `sp.manual-space` + `sp.rule` + `sp.ragged` + `font.size-commands` | `\FHJExHeader[type]{id}{topic}`: `center`; `parbox[t]` 10cm and 4cm with `\hfill`, `\raggedleft`; `\\[5mm]`, `\\[-3mm]`; `\textbf{\large}`; `\hrulefill`; defaults `\FHJClassAbbr` `\FHJClassTerm` `\FHJLecturer` (:327-329) |
| scheduled header | fhjcommon.dtx:374-385 | `lang.babel` | `\FHJExHeaderScheduled[type]{id}{topic}{date}`: header plus an English or German due-date line, `\vspace{1em}` |
| exercise sections | fhjcommon.dtx:347, :405-418 | `head.kernel` + `num.counters` | `\FHJExExample[points]{title}`: `\refstepcounter` on `exampleCounter` (reset by each header), `\subsection*{Example id.n: title (points Points)}`; the German branch without points prints "Aufgbae" (:411) |
| LLM notice box | fhjcommon.dtx:430-442 | `box.fancybox` + `box.minipage` | `\framebox[\textwidth]{minipage{\textwidth-2\fboxsep-2\fboxrule}}` (needs `calc`, loaded at :75) |
| example figure | fhjcommon.dtx:456-493 | `fig.graphicx` + `cap.kernel` | `\FHJExampleFigDE/EN`: `figure[!ht]`, `\centerline`, `\medskip`, coloured caption text; the plot is content; `tikz` and `xcolor` names `BrickRed`, `Purple`, `NavyBlue` are loaded by neither file, so the user preamble must load them |
| example table | fhjcommon.dtx:494-522 | `tbl.tabular` + `cap.kernel` | `\FHJExampleTabDE/EN`: `table[!ht]`, `\centerline`, `tabular{ll}`, bold header row, caption |
| colours in the example | fhjcommon.dtx:463-468, :471 | `color.xcolor` | dvipsnames `BrickRed`, `Purple`, `NavyBlue` used by `\color`; not loaded by the package |

## Bespoke code
None counts as bespoke under the rubric: every item sits in `fhjpaper`, `fhjbook` or `fhjcommon`, all published on CTAN (W1). The last column says what rebuilding from component ways alone would take, so the class dimension is not hidden.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| whole class and package code | fhjpaper.dtx:72-395; fhjbook.dtx:69-464; fhjcommon.dtx:73-523 | not bespoke (published) | one `\documentclass` line with options, plus the native commands |
| author and affiliation formatter, two-list zipper, catcode switch, counters | fhjpaper.dtx:216-343 | yes, as output | the emitter holds the author and affiliation lists as content: it writes the joined line (", " and "and"/"und", `\textsuperscript{n}`) and one affiliation per line in `center` blocks (`front.titlepage-env`-style body); the macro logic itself is not rebuilt, so the `\authorsnames` interface needs the class |
| separator language test at class load | fhjpaper.dtx:236-238 | yes | emitter writes the separator word; `\iflanguage` runs when the class loads, before a preamble `babel`, so whether it takes effect is not established (not compiled) |
| `\@maketitle` redefinition | fhjpaper.dtx:375-395 | yes | three centred minipages with `font.size-commands`, `sp.manual-space`, `pg.break` written in the body; or `front.titling` (`\pretitle` family), not tested |
| `\title` redefinition and fallbacks | fhjpaper.dtx:134, :153-157; fhjbook.dtx:210-229 | yes | no printed effect beyond the braces; the emitter always supplies title, author, supervisor |
| field stores (`\authorinfo`, `\supervisor`, `\cosupervisor`, `\FHJLocation`, `\FHJAbstract*`) and gender booleans | fhjbook.dtx:231-273, :404-412 | yes | field values are content; the emitter picks the label word (Autor, Autorin, Autor:in, Betreuer...) itself |
| `\FHJMakeTitlePage` | fhjbook.dtx:331-392 | yes | table rows above: `center`, `\includegraphics`, `box.minipage`, `sp.manual-space`, `font.size-commands`, `mark.kernel` |
| keyword loop | fhjbook.dtx:414-428 | yes | emitter writes `Keywords:` and the items with the separator |
| `\FHJMakeAbstract`, `\FHJThesisFrontMatter` | fhjbook.dtx:430-446, :457-464 | yes | page breaks, headings and text written in order; the second is an alias of three calls |
| `\FHJMakeDeclaration` | fhjcommon.dtx:303-311 | yes | `front.dedication` page: `pg.break`, group-local `\parindent`, itemize |
| program table | fhjcommon.dtx:104-202 | yes | text substitution of the registered long and short names |
| exercise header, example heading, LLM box | fhjcommon.dtx:347-442 | yes | rows above; the example counter is `num.counters` with `\refstepcounter` |
| example figure and table macros | fhjcommon.dtx:456-522 | yes | content macros: `figure` and `table` floats with captions; tikz plot is content-opaque |
| DocStrip driver | fhj-script.ins:18-50 | yes (no output effect) | generates `fhjcommon.sty`, `fhjpaper.cls`, `fhjbook.cls` from the .dtx files on plain TeX; a published `.cls` and `.sty` is what the emitter would use |

## Content-opaque
- tikz plot (`tikzpicture`, `plot`, `node`) inside the figure of `\FHJExampleFigDE` / `\FHJExampleFigEN` (fhjcommon.dtx:459-469, :478-488); example content in a figure float, not template artwork.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Note for the consolidator: `\printacronyms[template=...,heading=...]` (fhjbook.dtx:484) was mapped to `idx.glossaries` as an acronym-package family member; nothing was proposed because it is documentation boilerplate, not code in the zip. New class ways for the lib's class section: `class.fhjpaper` (options forwarded to `scrartcl`; `\authorsnames` `\authorsaffiliations` `\shorttitle`, `\maketitle`) and `class.fhjbook` (options forwarded to `scrbook`; `\authorinfo` `\supervisor` `\cosupervisor` `\FHJLocation` `\FHJAbstractDE` `\FHJAbstractEN` `\FHJMakeTitlePage` `\FHJMakeAbstract` `\FHJThesisFrontMatter`); `class.scrartcl` and `class.scrbook` are already in the lib.
