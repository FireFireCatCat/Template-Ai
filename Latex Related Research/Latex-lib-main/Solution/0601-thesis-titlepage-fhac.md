no

# 0601-thesis-titlepage-fhac: fhACtitlepage (diploma thesis title page, Fachhochschule Aachen)

- Unverified: read from the source, not compiled.
- Source: Source/0601-thesis-titlepage-fhac/ (origin: https://mirrors.ctan.org/macros/latex/contrib/thesis-titlepage-fhAC.zip; licence: lppl1.3)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (the author's profile runs pdflatex, pdf_with_figbig_and_glossar.tco:5; the doxygen header also loads dvips-route packages `epsfig[dvips]` and `psfrag`, doxygen_header.dtx.input:45,49, not checked under pdfLaTeX)
- Look carried by: mixed (class `scrreprt` carries headings, abstract and contents; the style `fhACtitlepage`, shipped in this CTAN package as docstrip code at fhACtitlepage.dtx:106-401, carries the title page, the declaration page and the optional heading colours; `figbib_add` and `gloss_add` add a figure-source list and a glossary)
- Class origin: tex-distribution-unbundled
- Main file: none standalone (no .tex holds `\documentclass` and `\begin{document}`). The sample is the example chunk fhACtitlepage.dtx:406-446 (docstrip tag `example`, extracted as diplomArbeit.ltx by fhACtitlepage.ins:18). Other samples: doxygen_header.dtx.input:12-125 (extracted as doxygen_header.tex, fhACtitlepage.ins:21) and the ltxdoc driver fhACtitlepage.dtx:56-75.
- Read: main yes (example, doxygen header and driver read in full), zip-local classes and styles all (there is no .cls or .sty file; every code chunk of the .dtx, `gloss_add.dtx.input` and `doxygen_header.dtx.input` was read; `figbib.sty`, `gloss.sty` and KOMA `scrreprt.cls` are published, not in the zip, not read)

## Verdict
The title-page look is a published CTAN package (`fhACtitlepage`, with its two add-ons `figbib_add` and `gloss_add`) over `scrreprt`. Its code is fixed kernel typesetting (a hand-laid `titlepage`, rules, sizes, one colour set) with three booleans, so the primary example is recoverable with two new ways, `class.thesis-titlepage-fhac` and `fig.figbib`, and no ART. The answer is still `no`, because the second shipped sample (the doxygen header) loads a `doxygen` package unconditionally, and by its name, the comment at doxygen_header.dtx.input:102 and README:50-52 it belongs to the output of the Doxygen program, not to TeX (EXTERNAL/package under the pilot ruling; judged from the zip, CTAN was not checked for it). If the doxygen header is read as out of scope, the rest would be `yes`; the scope tags below allow that re-reading.

## Blockers
- `EXTERNAL/package` `\usepackage{doxygen}` is loaded unconditionally by the doxygen header sample; `doxygen.sty` is not in the zip; the header is written for Doxygen (comment "fuer doxygen" at doxygen_header.dtx.input:102, README:50-52), so the package and the document body are taken to come from the Doxygen program, a tool outside TeX (doxygen_header.dtx.input:103; not verified beyond the zip). Scope: secondary sample only; the example at fhACtitlepage.dtx:406-446 does not load it.

## Class setting
- Class: `class.scrreprt` options: german, a4paper, abstracton, titlepage, bibtotoc, idxtotoc, liststotoc, pointlessnumbers, openright, twoside, 12pt (fhACtitlepage.dtx:408-418); the doxygen header uses a4paper, 11pt, titlepage, abstracton, german, twoside, bibtotocnumbered, idxtotoc, liststotoc, pointlessnumbers, openright (doxygen_header.dtx.input:14-16).
- Class-native vocabulary used: `\title` `\author` `\maketitle` (renewed by the package, fhACtitlepage.dtx:297), `\subject` (doxygen_header.dtx.input:100; docs fhACtitlepage.dtx:200-205), `abstract` environment shown by `abstracton` (fhACtitlepage.dtx:436-438), `\tableofcontents`, `\pagenumbering`. The package leans on KOMA internals that are not in the zip: `\sectfont`, `\raggedsection`, `\size@subsection`, `\size@subsubsection` (fhACtitlepage.dtx:182-193) and `\next@tpage` (fhACtitlepage.dtx:314,393); the `scrreprt` source was not read, so that `\next@tpage` is defined there is assumed, not checked.

## Component map
Rows marked "inside package" decompose the code of `fhACtitlepage` into lib ways; the sample reaches them through `class.thesis-titlepage-fhac`.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | fhACtitlepage.dtx:408-418 | `class.scrreprt` | options listed above |
| paper, size, sides | fhACtitlepage.dtx:409,417-418 | `page.class-options` | a4paper, 12pt, twoside |
| heading look by class option | fhACtitlepage.dtx:415-416 | `head.class-native` | pointlessnumbers, openright |
| contents-list options | fhACtitlepage.dtx:412-414 | `toc.koma` | bibtotoc, idxtotoc, liststotoc |
| language | fhACtitlepage.dtx:408,422; 148-159,163 | `lang.babel` | package `german`; the style reads the class option `german` through `\ProcessOptions*` and swaps its fixed strings |
| input encoding | fhACtitlepage.dtx:421 | `font.fontenc-t1` | inputenc, latin1 |
| graphics package | fhACtitlepage.dtx:419 | `fig.graphicx` | `\includegraphics` of the logo, `LogoFH` (LogoFH.pdf, .png, .eps, .tif shipped) |
| title page and declaration page | fhACtitlepage.dtx:423; 207-285; 297-319; 452-469 | `class.thesis-titlepage-fhac` | `\usepackage[declaration,colored]{fhACtitlepage}` (also `sectionheader`, `german`); string fields `\uniname` `\abtname` `\deptname` `\profname` `\thesistype` `\logofile` `\obtaining` `\principaladvisor` `\submitdatetown` (`\submitdate` obsolete); `\title` `\author` `\subject`; body `\maketitle`; the fields are read from fhACtitlepage.cfg when present (289-291) |
| title page as hand-laid page (inside package) | fhACtitlepage.dtx:297-319,324-374 | `front.titlepage-env` | `\maketitle` renewed as `titlepage` holding `\@titlep` and, with `declaration`, `\@declarationp` |
| title page text block geometry (inside package) | fhACtitlepage.dtx:299-311 | `page.setlength` | headheight 0mm, headsep `\footskip`, voffset and hoffset -1in, oddsidemargin 20mm, evensidemargin 25mm, topmargin 20mm, textwidth = paperwidth minus both side margins, textheight = paperheight minus headheight minus headsep |
| title page sizes (inside package) | fhACtitlepage.dtx:328,336,338,343,352,357-358 | `font.size-commands` | `\Huge` university, `\LARGE` location and thesis type, `\Large` department, professor, title, author, `\normalsize` labels |
| title page font switches (inside package) | fhACtitlepage.dtx:328,347,353 | `mark.kernel` | `\bf` `\sffamily` |
| title casing (inside package) | fhACtitlepage.dtx:343 | `mark.case` | `\uppercase` on the title |
| title rules and boxes (inside package) | fhACtitlepage.dtx:342,344 | `sp.rule` | `\parbox{\textwidth}{\hrulefill}` above and below the title (box part: `box.minipage`) |
| title page spacing and centring (inside package) | fhACtitlepage.dtx:326-327,332,334,341,342,348,350,355,361,369,371 | `sp.manual-space` | `\vskip1ex`, `\vskip10ex`, `\vskip 3em`, `\vskip0.5ex`, `\\[1.75ex]`, `\vfill`; centring with the `center` environment (`sp.ragged`, also `\centering` at 363,365) |
| title page style (inside package) | fhACtitlepage.dtx:325,380 | `hf.pagestyle-kernel` | `\pagestyle{empty}`, `\thispagestyle{empty}` |
| title page colours (inside package) | fhACtitlepage.dtx:167-176,328 | `color.color` | `color` package; with `colored`: sectcolor rgb 0,0.2,0.4, ssectcolor rgb 0.0157,0.3804,0.9804, sssectcolor rgb 0,0.4,1.0; otherwise all black; `\color{sectcolor}` on the fields |
| declaration page (inside package) | fhACtitlepage.dtx:379-395 | `box.minipage` | `minipage[t]{.95\textwidth}`, `\vspace*{3ex}`, `\hfill`, `\vfil`; signature block `tabular{l@{}c}` (`tbl.tabular`) with `\parbox{6cm}{\hrulefill}` |
| page clearing | fhACtitlepage.dtx:314,393,396,439,441 | `pg.break` | `\cleardoublepage` under twoside; `\clearemptydoublepage` defined as `\newpage{\pagestyle{empty}\cleardoublepage}` |
| heading colours, option `sectionheader` (inside package; not used by the samples) | fhACtitlepage.dtx:178-194 | `head.kernel` | `\renewcommand\subsection` and `\subsubsection` via `\@startsection` (level 2 and 3, indent `\z@`, before -3.25ex plus -1ex minus -.2ex, after 1.5ex plus .2ex, font `\normalfont` + size + `\bssectfont` or `\bsssectfont` = `\sffamily\bfseries\color{..}`); `\minisec` redefined (`\vskip 1.5ex`, `\parindent \z@`) |
| section font hook (inside package) | fhACtitlepage.dtx:182 | `head.koma-fonts` | `\renewcommand{\sectfont}{\sffamily\bfseries\color{sectcolor}}` (legacy KOMA font command) |
| page numbering | fhACtitlepage.dtx:435,444 | `pgnum.pagenumbering` | roman then arabic, `\setcounter{page}{1}` |
| abstract | fhACtitlepage.dtx:436-438 | `abs.class-native` | `abstract` shown through `abstracton` |
| contents | fhACtitlepage.dtx:440 | `toc.kernel` | `\tableofcontents` |
| figure-source list | fhACtitlepage.dtx:424-427,480-531; doxygen_header.dtx.input:70-76 | `fig.figbib` | `\usepackage[center,nocaptionlist]{figbib_add}`; per figure `\fbEntry{key}` after `\label{figbib:key}` (497-502); list `\fbTheFigs`, directory `\def\fbDirectory{bilder}` (doxygen header 75-76); BibTeX run on `*.figbib.aux` (build.xml:44-49, pdf_with_figbig_and_glossar.tco:9) |
| list entry layout in the add-on | fhACtitlepage.dtx:504-530 | `xref.kernel` | `\item[\ref{figbib:#1}]`, caption (`#6`) or title (`#2`), `\dotfill`, `\pageref`, `\newline`, source after `\figbibFrom` (inside `fig.figbib`) |
| glossary | fhACtitlepage.dtx:429-430; gloss_add.dtx.input:13-24; doxygen_header.dtx.input:79-80 | `idx.glossaries` | package `gloss` (BibTeX glossary, CTAN) with `\makegloss{}`; `gloss_add` adds the alias `\glosstex{key}` = `\gloss[nocite]{key}` (21); BibTeX run on `*.gls.aux` (build.xml:37-43) |
| documentation driver | fhACtitlepage.dtx:58 | `class.ltxdoc` | plain `ltxdoc` |
| documentation typesetting | fhACtitlepage.dtx:63-65,68-73 | `dtx.doc` | `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput` of three files, `\PrintIndex`, `\PrintChanges`; `\DoNotIndex` list (80) |
| documentation packages | fhACtitlepage.dtx:59-62 | `font.fontenc-t1` | inputenc latin1; also `graphicx[final]` (`fig.graphicx`), `german` (`lang.babel`), `url` (`meta.url`) |
| documentation title, abstract, contents | fhACtitlepage.dtx:81-99 | `front.maketitle` | `\title` with `\thanks` (`front.thanks`), `\author`, `\date`, `abstract` (`abs.kernel`), `\tableofcontents` (`toc.kernel`) |
| doxygen header: class | doxygen_header.dtx.input:14-16 | `class.scrreprt` | options as above |
| doxygen header: fonts | doxygen_header.dtx.input:20-22 | `font.mathptmx` | `mathptmx`; `helvet[scaled=.9]` (`font.helvet`); `courier` (`font.mono`) |
| doxygen header: margins | doxygen_header.dtx.input:25 | `page.geometry` | left=20mm, bottom=30mm |
| doxygen header: language | doxygen_header.dtx.input:27,31 | `lang.babel` | `ngerman`; inputenc latin1 (`font.fontenc-t1`) |
| doxygen header: floats | doxygen_header.dtx.input:33-35 | `fig.float` | `\restylefloat{figure}`, `\restylefloat{table}` |
| doxygen header: maths and theorems | doxygen_header.dtx.input:38,41,90-97,111 | `thm.amsthm` | `amsmath` (`math.amsmath`), `amsthm`; `\newtheorem{defi}{Definition}[chapter]` and seven kinds sharing the `defi` counter; `\proofname` = Beweis |
| doxygen header: graphics | doxygen_header.dtx.input:44-46 | `fig.graphicx` | `graphicx`, `epsfig[dvips]`, `\graphicspath{{./bilder}}` |
| doxygen header: algorithms | doxygen_header.dtx.input:52 | `alg.algorithm2e` | german, vlined, boxed |
| doxygen header: index, verbatim, array, url | doxygen_header.dtx.input:60-62,116 | `idx.makeidx` | `makeidx` and `\makeindex`; `verbatim` (`code.verbatim`), `array` (`tbl.tabular`), `url` (`meta.url`) |
| doxygen header: running heads | doxygen_header.dtx.input:64-67 | `hf.scrlayer-scrpage` | `scrpage` (KOMA predecessor of `scrlayer-scrpage`; availability in current TeX Live not checked) `\deftripstyle{Kopfzeile}{\rightmark}{}{\pagemark}{}{}{}`, `\pagestyle{Kopfzeile}` |
| doxygen header: fancyhdr, hyperref | doxygen_header.dtx.input:102,106 | `hf.fancyhdr` | `fancyhdr` load-only; `hyperref` load-only (`meta.hyperref`) |
| doxygen header: counters | doxygen_header.dtx.input:113-114 | `num.secnumdepth` | tocdepth 1, secnumdepth 2 |
| doxygen header: title | doxygen_header.dtx.input:99-100 | `class.thesis-titlepage-fhac` | `[colored]` only; `\subject{Beschreibung der Programmierschnittstelle}` (class `\subject`, `front.koma-title`), printed by the style at fhACtitlepage.dtx:346-349 |
| doxygen header: doxygen package | doxygen_header.dtx.input:103 | none | EXTERNAL, see Blockers |
| doxygen header: body | doxygen_header.dtx.input:118-124 | `pgnum.pagenumbering` | `\maketitle`, `\clearemptydoublepage`, roman, `\tableofcontents`, arabic |
| figbib and gloss in the header | doxygen_header.dtx.input:70-76,79-80 | `fig.figbib` | as in the example; `gloss` loaded without the add-on (`idx.glossaries`) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `fhACtitlepage` option switches `\if@declaration` `\if@colored` `\if@sectionheader` | fhACtitlepage.dtx:123-137,168-176,181,315 | yes | published CTAN package (way parameters); alone, resolve the switch when emitting: `colored` picks the colour values (`color.color`), `declaration` adds the declaration page |
| field setters `\uniname` ... `\principaladviser` (`\newcommand` + `\gdef`) | fhACtitlepage.dtx:207-285 | yes | aliases that store strings; the strings are the way's field parameters, or literal text in the title layout |
| `\maketitle` renewal, `\@titlep` | fhACtitlepage.dtx:297-319,324-374 | yes | `front.titlepage-env` + `page.setlength` + `font.size-commands` + `color.color` + `sp.rule` + `sp.manual-space` (rows above); the `\ifx` tests for an empty logo, subject or adviser (330,346,359) are decided by which fields are filled |
| `\@declarationp` | fhACtitlepage.dtx:379-395 | yes | `box.minipage` + `tbl.tabular` + `sp.rule` |
| `\clearemptydoublepage` | fhACtitlepage.dtx:396 | yes | alias of `pg.break` + `hf.pagestyle-kernel` |
| `sectionheader` heading redefinitions | fhACtitlepage.dtx:181-194 | yes | `head.kernel` (`\@startsection` parameters) + `head.koma-fonts`, parameters listed in the map; no sample turns it on |
| string table swapped by `german` | fhACtitlepage.dtx:141-163 | yes | fixed strings (Diplomarbeit, vorgelegt von, betreut von, Unterschrift, declaration text); content |
| `fhACtitlepage.cfg` loaded by `\InputIfFileExists` | fhACtitlepage.dtx:289-291,452-469 | yes | the demo values (`\title`, `\author`, `\uniname`, `\logofile`, ...) written directly in the preamble |
| `figbib_add`: `\fbEntry`, redefined `\figbibitem`, `\figbib@WriteEntry`, switch `\if@figbiblistcaption` | fhACtitlepage.dtx:484-531 | not reduced from the zip alone | treated as published because it ships in the CTAN package and is driven by options (`nocaptionlist`, pass-through to `figbib`, 485-487) and `\fbEntry{key}`; it overrides figbib internals (`\figbib@aux`, `\figbib@noexpands`, aux protocol `\figbibdefmain`, 505-511) that are in the unread `figbib.sty`. If it were judged zip-local it would be BESPOKE/class; this is the second-weakest call after the doxygen blocker |
| `gloss_add` alias `\glosstex` | gloss_add.dtx.input:21 | yes | `\gloss[nocite]{#1}` |
| documentation title: `\ifnum\language=2` text choice inside `\thanks` | fhACtitlepage.dtx:81-89 | yes | choose one of the two texts when emitting; content of the manual |

## Content-opaque
none. (The logo is an included image, `\includegraphics{\@logofile}` at fhACtitlepage.dtx:333, content shipped as LogoFH.*; README:36-38 asks to respect the logo's copyright. `psfrag` is loaded but never called, doxygen_header.dtx.input:49: no printed effect, not treated as a component.)

## Lib changes
- New ways proposed:
  - `class.thesis-titlepage-fhac`: `fhACtitlepage` (CTAN package `thesis-titlepage-fhac`, TeX Live and MiKTeX, LPPL 1.3; J. A. Lamers; ctan.org/pkg/thesis-titlepage-fhac read); pdfLaTeX; `\usepackage[declaration,colored,sectionheader,german]{fhACtitlepage}`, string commands `\uniname` `\abtname` `\deptname` `\profname` `\thesistype` `\logofile` `\obtaining` `\principaladviser` `\submitdatetown`, class fields `\title` `\author` `\subject`, body `\maketitle`; a diploma-thesis title page and optional declaration page for `scrreprt`. W1: CTAN page read. W2: three booleans and strings, no code to edit. W3: weakest test, since the CTAN page names one institution, but the code holds no institution (every field is a string, the logo a file). W4: preamble lines plus `\maketitle`. The v3 consolidation folded one-institution cover packages into class-like ways, so the consolidator may do the same here.
  - `fig.figbib`: `figbib` (CTAN, TeX Live, MiKTeX, LPPL; ctan.org/pkg/figbib read: figure databases in BibTeX, a list of figures with more than the caption) with the add-on `figbib_add` shipped in this CTAN package; pdfLaTeX plus a BibTeX pass (BibTeX is the tool of `bib.bibtex-bst`, not EXTERNAL); `\usepackage[center,nocaptionlist]{figbib_add}`, body `\fbEntry{key}`, `\fbTheFigs`, `\fbDirectory`. W1: CTAN page read for `figbib`; `figbib_add` ships in the CTAN package of this zip. W2: options, a BibTeX database, key strings. W3: any document with figures. W4: preamble line plus one body call per figure. `figbib.sty` was not read; the command names above are those seen in the zip.
- Considered, not proposed: `gloss` (CTAN page ctan.org/pkg/gloss read: BibTeX glossary with `\gloss` for `\cite`, TeX Live) as its own way; it prints a glossary and marks terms like the other members of `idx.glossaries`, so it sits there with the package as the parameter. `psfrag` (no printed effect in the sample).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Author tooling, not template: build.xml (ANT with `ant_latex.jar`, :9-11), antrc_pre.bat (Java class paths), pdf_with_figbig_and_glossar.tco (TeXnicCenter profile; its `jxGlossar.exe` step, :10, feeds glossary data from `glossar-softwareentwicklung.xml`, which is not shipped). None is needed by the example, which calls neither `\gloss` nor `\fbEntry`; a document that fills the glossary through that Java step would be EXTERNAL.
- README:41-42 lists `addons.dtx` and `addons2.dtx`, which are not in the zip (their content sits in `gloss_add.dtx.input` and `doxygen_header.dtx.input`).
- The files are Latin-1 encoded (inputenc latin1, fhACtitlepage.dtx:421).
