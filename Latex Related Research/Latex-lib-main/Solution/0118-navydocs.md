yes

# 0118-navydocs: navydocs (US Navy technical report title page and Technical Components page)

- Unverified: read from the source, not compiled.
- Source: Source/0118-navydocs/ (origin: https://mirrors.ctan.org/macros/latex/contrib/navydocs.zip; licence: LPPL 1.3 (README.txt:33-34; manifest `lppl1.3`))
- Kind: report
- Lib: v2
- Engine: pdfLaTeX-compatible (`\dimexpr` is e-TeX, in pdfTeX; the PNG logo at navydocs.dtx:1144 needs pdfTeX/XeTeX/LuaTeX, so the DVI route in Makefile:59-61,92 is stale)
- Look carried by: zip-local (the whole title-page and Technical Components look is in the package code of navydocs.dtx:593-1282; that package is also the CTAN-published `navydocs` v1.1, so it counts as published under W1)
- Class origin: tex-distribution-unbundled
- Main file: navydocs.dtx (the `sample` module, lines 472-565, is written out as sampleNavyReport.tex by navydocs.ins:74-76; no .tex, .cls or .sty file ships) (other samples: the documentation driver navydocs.dtx:46-67, which also sets a title page and the Carderock page at 399-441)
- Read: main yes, zip-local classes and styles none present (no .cls or .sty ships; the package module navydocs.dtx:593-1282 was read in full, and so was the rest of the .dtx, the .ins, the Makefile and README.txt; navydocs.pdf was not opened)

## Verdict
`navydocs` is a CTAN and TeX Live package (v1.1, 2017-07-01, ctan.org/pkg/navydocs, read this session), and the zip is its own CTAN release, so it passes W1. The sample only loads it and fills in strings (eight field setters, a form id, an optional margin title) and calls two page macros, so an emitter needs `\usepackage{navydocs}` plus body wrappers and no copied macro logic. I propose it as `class.navydocs`; the borderline point is W3, because `\MakeCarderockDivPage` has one division's text fixed in it (same pattern as `cal.kalender` and `notebook.ftc`). The package's inner algorithms (a `\lastbox` line counter for the margin title) would be irreducible BESPOKE/package if the package were treated as zip-local; that is recorded in "Bespoke code" so the verdict can be re-read, but under W1 they are published code and not counted.

## Blockers
none

Considered and not counted:
- `EXTERNAL`: the Makefile runs `latex`, `dvips`, `ps2pdf` and `makeindex` for the documentation (Makefile:56,83,89,92) and docstrip as `latex navydocs.ins` (Makefile:95). Docstrip is TeX itself, `makeindex` only builds the documentation's index and change list, and the sample needs none of them. `make test` points at a file the zip lacks, `sample298.tex` (Makefile:59-61).
- `ART`: the margin title is text placed with eso-pic `\AddToShipoutPicture*{\put(...)}` (navydocs.dtx:1082-1086), a rotated parbox and no drawing, so it is `bg.eso-pic` and not `art.pstricks`. The rules are `\rule`/`\hrule` (`sp.rule`).
- Missing assets: none. The logo `graphics/navy-logo-102.png` ships (ls: graphics/navy-logo-102.png, 1800 x 1800) and the package hard-codes that relative path (navydocs.dtx:1144), so the document needs a `graphics/` folder beside it.

## Class setting
- Class: `class.article` options: `twoside` (navydocs.dtx:486); documentation driver: `class.ltxdoc` option `letterpaper` (navydocs.dtx:48). Neither class is bundled (they ship with the TeX distribution; source not read).
- Class-native vocabulary used: `\tableofcontents`, `\section`, `\pagenumbering`, `\cleardoublepage`, `\setcounter{page}` (navydocs.dtx:544-557); `titlepage` environment inside the package (navydocs.dtx:1094). The package reads `\if@twoside`, `\c@page`, `\textheight`, `\topmargin`, `\oddsidemargin`, `\leftmargin`, `\marginparwidth` (navydocs.dtx:889-895,1053).

## Component map
Rows 1 to 12 are what the sample (sampleNavyReport.tex, navydocs.dtx:486-561) states itself. Rows 13 to 31 show what the package code does inside (informational: the emitter reaches all of it through `class.navydocs`). Rows 32 to 41 are the documentation driver, not the template.

| # | Component | Evidence | Way | Parameters |
|---|---|---|---|---|
| 1 | class | navydocs.dtx:486 | `class.article` | twoside |
| 2 | page geometry | navydocs.dtx:487 | `page.geometry` | margin=0.75in |
| 3 | page lengths | navydocs.dtx:497,499-502 | `page.setlength` | \marginparwidth=64pt, \paperwidth=8.5in, \textwidth=6.5in, \oddsidemargin=0in, \evensidemargin=0in |
| 4 | paragraph indent | navydocs.dtx:498 | `sp.lengths` | \parindent=5ex |
| 5 | title page fields | navydocs.dtx:512-521 | `class.navydocs` | \NavyDivision, \NavyDivisionLocation, \NavyReportNumber, \NavyReportDate, \NavyReportType, \NavyReportTitle, \NavyAuthor: one string each, `\\` for line breaks; \NavyDistributionStatement unset, so default "Approved for public release; distribution is unlimited." (navydocs.dtx:816-818) |
| 6 | margin title | navydocs.dtx:526-529 | `class.navydocs` | \NavyMarginTitle{two-line string}; optional [xmargin][ymargin] omitted, so computed defaults (navydocs.dtx:899-903) |
| 7 | form id (page-2 footer) | navydocs.dtx:531 | `class.navydocs` | \NavyFormID{NDW-DTRC 5602/51 (Rev. 7-93)} |
| 8 | title page | navydocs.dtx:542 | `class.navydocs` | \NavyTitlePage, no arguments |
| 9 | technical components page | navydocs.dtx:546 | `class.navydocs` | \MakeCarderockDivPage, no arguments |
| 10 | page numbering | navydocs.dtx:544,550,551 | `pgnum.pagenumbering` | roman, then arabic, \setcounter{page}{1} |
| 11 | contents, page breaks | navydocs.dtx:548,549 | `toc.kernel`, `pg.break` | \tableofcontents; \cleardoublepage |
| 12 | headings | navydocs.dtx:553,557 | `head.kernel` | \section, default look |
| 13 | package loads | navydocs.dtx:635-636,649-666,679-680,692-693,705-706,719-720 | `bg.eso-pic`, `fig.rotating`, `box.mdframed`, `hf.fancyhdr`, `sp.setspace` | each guarded by `\IfFileExists` and `\PackageError`; relsize and xparse also loaded; relsize commands are never called (grep) |
| 14 | left vertical rule | navydocs.dtx:649-666,1098 | `box.mdframed` | linewidth=4pt, middlelinecolor=black, middlelinewidth=0.4pt, roundcorner=1pt, topline/rightline/bottomline=false, skipabove/skipbelow=0pt, leftmargin=0cm, innerleftmargin=1cm, other inner margins 0pt |
| 15 | title page frame | navydocs.dtx:1094-1105 | `front.titlepage-env`, `box.minipage` | titlepage > minipage[t]{\textwidth} > mdframed > parbox[t][0.98\textheight][t]{\textwidth} |
| 16 | division and location | navydocs.dtx:1106-1108 | `mark.kernel`, `font.size-commands` | \textbf{\large division}; \vskip3mm; \textbf{\small location} |
| 17 | thick and thin rules | navydocs.dtx:1110-1112,1148,1156 | `sp.rule` | \rule{\textwidth}{4pt}; \vskip-8pt; \rule{\textwidth}{2pt}; \hrule height 4pt twice |
| 18 | number, date, type, title, author | navydocs.dtx:1118-1133 | `sp.manual-space`, `font.size-commands`, `mark.kernel` | \vspace{4mm}; \vspace{1.7cm}; {\Large \textbf{title}}; \vspace{1cm}; \normalsize "by" author |
| 19 | logo and distribution box | navydocs.dtx:1142-1157 | `fig.graphicx`, `box.minipage`, `sp.manual-space` | \includegraphics[width=21mm]{graphics/navy-logo-102.png}; \hspace{0.6in}; minipage{0.75\textwidth}; \vfill |
| 20 | margin title overlay | navydocs.dtx:1081-1087 | `bg.eso-pic`, `fig.rotating` | \AddToShipoutPicture* + \put(\xmargin,\ymargin){\rotatebox{90}{\scalebox{1}{\parbox[t]{\textheight}{\textbf{\small title}}}}}, only if \ifmargin |
| 21 | blank back page (twoside) | navydocs.dtx:1052-1057 | `pg.break`, `hf.pagestyle-kernel` | \newpage; if twoside and even page: \null \thispagestyle{empty} \newpage |
| 22 | form-id footer style | navydocs.dtx:937-940,1212 | `hf.fancyhdr`, `hf.pagestyle-kernel` | \fancypagestyle{NavyFormIDStyle}{\fancyhf{} \headrulewidth=0pt \fancyfoot[L]{\scriptsize id}}; \thispagestyle on the page |
| 23 | reverse-video page title | navydocs.dtx:1219-1221 | `color.xcolor`, `mark.kernel`, `font.size-commands` | \section*{\sffamily \colorbox{black}{\bfseries \textcolor{white}{\large ...}}}; \vspace{8ex}. navydocs loads no colour package itself; the colour commands come in through another loaded package (not verified, source not in the zip) |
| 24 | line spacing | navydocs.dtx:1223,1234 | `sp.setspace` | \doublespace around the table, then \singlespace |
| 25 | codes table | navydocs.dtx:1224-1233 | `tbl.tabular` | tabular{lrl}, no rules |
| 26 | report types box | navydocs.dtx:1240-1270 | `box.fancybox`, `box.minipage`, `sp.manual-space` | \vfill; \fbox{minipage{\textwidth}}; center heading; \vspace{2ex} and {1ex} |
| 27 | numbered list | navydocs.dtx:1250-1266 | `list.kernel` | enumerate inside \parbox{0.97\textwidth} |
| 28 | fixed text and page flow | navydocs.dtx:1225-1232,1246-1265,1276 | `class.navydocs` | Carderock text is part of the macro, not an argument (stated at navydocs.dtx:1200-1204); \newpage at the end |
| 29 | default date | navydocs.dtx:610-624,779 | `class.navydocs` | `\number\day~\MONTH~\number\year`; replaced by \NavyReportDate |
| 30 | stored report number | navydocs.dtx:761-769 | `class.navydocs` | \NavyReportNumber{} with empty argument returns the stored number; used at navydocs.dtx:527-528 |
| 31 | fonts, language, metadata, bibliography | whole file | none needed | no font, language, hyperref or bibliography setting anywhere in the package or sample |
| 32 | doc class | navydocs.dtx:48 | `class.ltxdoc` | letterpaper |
| 33 | doc driver | navydocs.dtx:57-66,77-98,120-136,567,1285 | `dtx.doc` | \EnableCrossrefs, \RecordChanges, \CodelineIndex, \PrintChanges, \PrintIndex, \DocInput, \DoNotIndex, \CheckSum, \CharacterTable, \StopEventually, \Finale |
| 34 | doc title, abstract | navydocs.dtx:138-157 | `front.maketitle`, `fn.kernel`, `abs.kernel` | \title with \footnote, \author, \date, \maketitle; abstract |
| 35 | doc contents, headings | navydocs.dtx:159-160,162,257 | `num.secnumdepth`, `toc.kernel`, `head.kernel` | tocdepth=2; \section, \paragraph |
| 36 | doc field table | navydocs.dtx:201-254 | `tbl.tabular`, `cap.kernel` | float table[h], tabular{lcccccc}, \hline, caption and label |
| 37 | doc bibliography | navydocs.dtx:574-579 | `bib.thebibliography` | one \bibitem |
| 38 | doc page numbers | navydocs.dtx:107-117 | `hf.pagestyle-kernel` | \@oddfoot redefined to a centred \thepage; the test on label fig:form never fires, since no such label exists (grep) |
| 39 | doc page-number restore | navydocs.dtx:53,391,416-417 | `num.counters` | \newcounter{savepage}; \setcounter{page}{\thesavepage}; \addtocounter{page}{2} |
| 40 | doc text height | navydocs.dtx:51-52 | `page.setlength`, `sp.lengths` | \advance\textheight 2\baselineskip; \hfuzz=26pt |
| 41 | doc afterpage | navydocs.dtx:50 | `pg.afterpage` | package loaded, no `\afterpage` call (grep) |

## Bespoke code
All package items below are published code (CTAN `navydocs`), so W1 does not count them as bespoke. The "if zip-local" column gives the answer under the stricter reading, for re-reading.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\countlines` (`\setbox\lastbox` loop with `\unskip\unpenalty`, result in `\numlines`) | navydocs.dtx:841-852 | no, if zip-local: BESPOKE/package | box-and-glue algorithm; no lib way counts lines of a box |
| `\getmargintextheight` (`\newdimen` inside a macro, `\dimexpr` division by `\numlines`), `\marginoffset`, `\navy@xmargin`, `\navy@ymargin` | navydocs.dtx:863-871,886-897 | no, if zip-local: BESPOKE/package | computed overlay coordinates through `\LenToUnit`; parameters are the optional [xmargin][ymargin] numbers |
| `\ifmargin` switch | navydocs.dtx:886-887,906-909,1081 | yes | an empty margin title turns the overlay off: a boolean parameter of `class.navydocs` |
| `\navy@checkfield`, `\navy@undefined`, `\ifnavy@undef`, `\AtEndDocument` | navydocs.dtx:946-1006 | yes (no printed effect) | only `\typeout` warnings for empty required fields |
| `\MONTH`, `\navy@ReportDate` default | navydocs.dtx:610-624,779 | yes | day-month-year string from `\day`, `\month`, `\year`; or a date string given by the author |
| `\eg` alias | navydocs.dtx:609 | yes | `\providecommand` alias for an italic "e.g." |
| field setters `\NavyDivision` ... `\NavyAuthor`, `\NavyDistributionStatement` (`\renewcommand` of internal macros, `#1\hfill`) | navydocs.dtx:735-815 | yes | string parameters of `class.navydocs` |
| `\NavyReportNumber` getter (`\ifx&#1&`) | navydocs.dtx:761-769 | yes | string parameter and a reference to the stored string |
| `\NavyFormID` | navydocs.dtx:937-940 | yes | `hf.fancyhdr` (row 22) |
| `\NavyTitlePage` (`\global\let\thanks\@gobble`) | navydocs.dtx:1029-1032 | yes | makes `\thanks` in a shared title text vanish on the title page |
| `\MakeNavyTitlePage` page composition | navydocs.dtx:1043-1166 | yes | rows 14 to 21 |
| one-shot clean-up `\global\let ... \relax`; several names (`\Location`, `\ReportNumber`, `\ReportTitle`, `\NavyRelease`, `\MarginTitle`, `\MakeNavyCoverPage`) do not match any defined command | navydocs.dtx:1174-1193 | yes | frees memory only; the stale names do nothing |
| `\MakeCarderockDivPage` page composition | navydocs.dtx:1211-1277 | yes | rows 22 to 28 |
| sample page lengths | navydocs.dtx:497-502 | yes | `page.setlength`, `sp.lengths` (rows 3 and 4) |
| documentation-only macros `\Lopt` `\Lfile` `\Lpack` `\ie` `\n` `\d` `\p` `\s` `\S` | navydocs.dtx:71-73,100,203-212 | yes | aliases for `\textsf`, `\texttt`, `\smash\lower`, `\phantom`, `\footnotesize` |
| documentation `\@oddfoot` hack | navydocs.dtx:107-117 | yes | centred page number (row 38) |
| Makefile and `navydocs.ins` | Makefile:1-95; navydocs.ins:74-76 | n/a | build tooling for the documentation and for docstrip; not part of the output (see Blockers) |

## Content-opaque
- `\lipsum[1]` and `\lipsum[2]` filler text from the `lipsum` package (navydocs.dtx:488,555,559); text is content.
- No figure, TikZ picture or chart. The Navy logo (navydocs.dtx:1144) is a template image and is mapped to `fig.graphicx` in row 19.

## Lib changes
- New ways proposed: `class.navydocs` navydocs (CTAN and TeX Live, LPPL 1.3; pdfLaTeX): `\usepackage{navydocs}` (no options), setters `\NavyDivision` `\NavyDivisionLocation` `\NavyReportNumber` `\NavyReportDate` `\NavyReportType` `\NavyReportTitle` `\NavyAuthor` `\NavyDistributionStatement` `\NavyFormID`, `\NavyMarginTitle[xmargin][ymargin]{text}`, and pages `\NavyTitlePage` and `\MakeCarderockDivPage`; loads eso-pic, rotating, mdframed, fancyhdr, relsize, setspace, xparse. W1: on CTAN (v1.1, 2017-07-01) and the zip is its CTAN release. W2: behaviour comes from strings and two optional numbers; nothing is chosen by editing code. W3: a kind of component, the Navy technical-report front pages (borderline, since the Technical Components text is one division's; the README at README.txt:22-23 says other organisations copy and edit the macros, which is extending the code and is not a parameter). W4: one preamble line plus body setters and two page macros. Same pattern as `cal.kalender`, `inv.simpleinvoice` and `notebook.ftc`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
