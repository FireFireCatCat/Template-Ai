yes

# 0006-gsemthesis: GSEM PhD thesis class (Geneva School of Economics and Management)

- Unverified: read from the source, not compiled.
- Source: Source/0006-gsemthesis/ (origin: https://mirrors.ctan.org/macros/latex/contrib/gsemthesis.zip; licence: lppl1.3)
- Kind: thesis
- Lib: v0
- Engine: pdfLaTeX-compatible (inputenc utf8, T1 only for `fr`; `biblatex` needs the biber program, which the lib already accepts as `bib.biblatex-biber`)
- Main file: gsemthesis.dtx (no standalone `.tex` and no `.cls` file in the zip: the class is generated from the `.dtx` by `gsemthesis.ins`; the only sample is the minimal working example printed inside the `.dtx` at gsemthesis.dtx:269-326; other samples: none; `README:25-26` says the full example lives in the GitHub repo, not in this zip)
- Read: main yes, zip-local classes and styles all (the whole 968-line `.dtx` was read; `.ins` and README read; `gsemthesis.pdf` is the typeset manual and was not opened)

## Verdict
yes. `gsemthesis` is a published CTAN class (also in TeX Live and MiKTeX, per ctan.org/pkg/gsemthesis and README:14), so `\documentclass[...]{gsemthesis}` plus its class-native commands is itself a way (`NEW:class.gsemthesis`, W1 to W4 below). Independently of that, every line of the class source reduces to existing lib ways plus two small published additions (`NEW:front.datetime`, `NEW:pg.emptypage`): the class is `book` plus ordinary packages with declarative options, a hand-laid cover, and four option toggles that an emitter resolves before printing. No irreducible code and no template-defining artwork were found.

## Blockers
none

## Class setting
- Class: `NEW:class.gsemthesis` options: `fr` (French), `draft` (hides committee, thesis number, dedication, acknowledgements, abstracts), `custombib` (drops the class's biblatex setup), `b5paper` (gsemthesis.dtx:354-374). It is built on `class.book` with `a4paper,12pt,twoside` (gsemthesis.dtx:338).
- Class-native vocabulary used (MWE gsemthesis.dtx:270-325): `\title`, `\date`, `\authorFirstname`, `\authorLastname`, `\thesisField`, `\thesisCommitteeA` to `F` (title, first name, last name, role), `\thesisNumber`, `\acknowledgements`, `\abstractEN`, `\abstractFR`, `\dedication`, `\addbibresource`, `\printcoverpage`, `\printfrontmatter`, `\startintroduction`, `\startconclusion`, `\chapter`, `\label`, `\listoftables`, `\listoffigures`, `\printbibliography`, plus `itemize*` (gsemthesis.dtx:958).
- W1: on CTAN, v0.9.4 of 2015-02-09 (gsemthesis.dtx:23). W2: look chosen by the four options and by string arguments of the class commands. W3: serves the kind "GSEM thesis", the same grain as `class.llncs` or `class.moderncv`. W4: one `\documentclass` line plus body command calls.

## Component map
Rows marked (class) are the published-class way; rows marked (reduction) show the same look rebuilt from the class source with lib ways only. Both views are given so the verdict does not rest on one reading.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (class) | gsemthesis.dtx:21,338 | `NEW:class.gsemthesis` | options fr / draft / custombib / b5paper |
| document class (reduction) | gsemthesis.dtx:338 | `class.book` | a4paper, 12pt, twoside |
| paper, size, sides | gsemthesis.dtx:338 | `page.class-options` | a4paper, 12pt, twoside |
| page geometry | gsemthesis.dtx:378 | `page.geometry` | top=2.5cm, bottom=2.5cm, left=2.5cm, right=2.5cm (twoside, so inner/outer) |
| input encoding | gsemthesis.dtx:342 | `font.fontenc-t1` | inputenc utf8 |
| French font encoding | gsemthesis.dtx:505 | `font.fontenc-t1` | fontenc T1, only with `fr` |
| text font | gsemthesis.dtx:346 | `font.lmodern` | lmodern, default |
| cover title spacing | gsemthesis.dtx:382,746-748 | `sp.setspace` | `spacing` environment, factor 0.8 |
| colours | gsemthesis.dtx:388-391 | `color.xcolor` | erblue=HTML 126199, erorange=HTML FF7F00, gsemblue=HTML 465F7F |
| graphics | gsemthesis.dtx:396 | `fig.graphicx` | option `final` (forced even in draft) |
| float placement | gsemthesis.dtx:397 | `fig.float` | package defaults |
| subfigures | gsemthesis.dtx:398 | `fig.subcaption` | the old `subfigure` package, defaults |
| links | gsemthesis.dtx:403,411-418 | `meta.hyperref` | colorlinks=true, linkcolor=black, filecolor=erblue, citecolor=erblue, urlcolor=erblue, final |
| url font | gsemthesis.dtx:422-423 | `meta.url` | `\urlstyle{sf}` |
| maths | gsemthesis.dtx:428 | `math.amsmath`, `math.amssymb` | amssymb, amsmath, amsfonts defaults |
| running heads | gsemthesis.dtx:447-453 | `hf.fancyhdr` | `\pagestyle{fancy}`; LE and RO = `\thepage`; RE = `\nouppercase{\leftmark}`; LO = `\nouppercase{\rightmark}`; feet empty |
| plain, empty, cover, unnumberedchapter styles | gsemthesis.dtx:457-490 | `hf.fancyhdr` | `\fancypagestyle` with headrulewidth 0pt (plain, empty, unnumberedchapter), 0.5pt head and foot rules (cover). `cover` and `unnumberedchapter` are defined but no active line applies them (grep) |
| blank page before a chapter with no header | gsemthesis.dtx:494-499 | `NEW:pg.emptypage` | package `emptypage`, no options (the class redefines `\cleardoublepage` with `\thispagestyle{empty}`) |
| language | gsemthesis.dtx:503-509 | `lang.babel` | `english`, or `francais` with `fr` |
| quotes | gsemthesis.dtx:512 | `lang.csquotes` | defaults |
| cover date format | gsemthesis.dtx:516-517,811 | `NEW:front.datetime` | package `datetime`, `\newdateformat{monthyeardate}{\monthname[\THEMONTH] \THEYEAR}`, printed with `\monthyeardate\today` (non-draft); draft prints `\@date` |
| bibliography | gsemthesis.dtx:523-527,323 | `bib.biblatex-biber` | backend=biber, natbib=true, style=authoryear-comp, sorting=nymdt, maxbibnames=99, mincitenames=1, maxcitenames=2, uniquelist=false; `\addbibresource`, `\printbibliography` |
| custom sort order | gsemthesis.dtx:531-567 | `bib.biblatex-biber` | `\DeclareSortingScheme{nymdt}` over presort, sortkey, name, year, month, day, title, volume (biblatex's own declaration command; its name differs across biblatex major versions, not checked) |
| cover page | gsemthesis.dtx:737-817 | `front.titlepage-env` | `\thispagestyle{empty}`, `center`, `\rule{\linewidth}{0.4pt}` top and bottom, `\vspace*` 1.2cm / 1.2cm / 0.4cm / 0.8cm / 0.8cm / 0.2em ... 1.4cm / 0.1cm, `\vfill` before the committee block |
| cover type | gsemthesis.dtx:744-758 | `font.size-commands`, `mark.kernel` | title `\huge` + `\scshape`; author `\large`; last name `\textsc`; draft mark `\emph` |
| cover labels | gsemthesis.dtx:573-609 | `front.titlepage-env` | fixed English or French strings, inlined by the emitter |
| thesis metadata fields | gsemthesis.dtx:618-732 | `front.class-native` | values stored by `\authorFirstname` ... `\thesisNumber`; committee line = `#1~#2~\textsc{#3},~#4`, omitted when the last name is empty |
| acknowledgements | gsemthesis.dtx:861-872 | `front.dedication`, `head.kernel`, `toc.kernel` | `\chapter*{Acknowledgements}` + `\addcontentsline{toc}{chapter}{...}`, `\thispagestyle{plain}` |
| EN and FR abstracts | gsemthesis.dtx:876-904 | `abs.class-native`, `head.kernel`, `toc.kernel` | two unnumbered chapters (Abstract, Résumé), order set by `fr`, each `\thispagestyle{plain}` and in the ToC |
| table of contents | gsemthesis.dtx:907 | `toc.kernel` | `\tableofcontents` |
| dedication | gsemthesis.dtx:909-919 | `front.dedication`, `sp.ragged`, `font.size-commands` | `\cleardoublepage`, `\vspace*{4cm}`, `\em\raggedleft ...\par`, `\thispagestyle{plain}` |
| front/main matter | gsemthesis.dtx:861,922 | `class.book` | `\frontmatter`, `\mainmatter` (roman then arabic page numbers) |
| page breaks | gsemthesis.dtx:874,883,897,910,919 | `pg.break` | `\newpage`, `\cleardoublepage` |
| unnumbered introduction and conclusion | gsemthesis.dtx:932-949 | `head.kernel`, `toc.kernel`, `hf.fancyhdr` | `\chapter*`, `\addcontentsline{toc}{chapter}`, `\label`, `\markboth{}{Introduction}` / `{Conclusion}` |
| chapters, labels | gsemthesis.dtx:307-308 | `head.kernel`, `xref.kernel` | `\chapter{...}`, `\label{ch:...}` |
| back matter lists | gsemthesis.dtx:318-319 | `toc.kernel` | `\listoftables`, `\listoffigures` |
| compact list | gsemthesis.dtx:958-964 | `list.kernel`, `sp.lengths` | `itemize` with `\itemsep=0pt`, `\parskip=0pt`, `\vspace{-2mm}` before and after |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| the class `gsemthesis` as a whole | gsemthesis.dtx:20-967 | yes | published on CTAN, so `NEW:class.gsemthesis`; also decomposes row by row in the map above |
| toggles `fr`, `draft`, `custombib` and every `\iftoggle` branch | gsemthesis.dtx:354-365,503-509,523-531,575-609,767-811,860-920 | yes | the toggles only choose between fixed strings or fixed blocks; the options are fixed per document, so the emitter prints the chosen branch (2 x 2 x 2 option sets). No branch computes layout |
| `\DeclareOption{b5paper}` | gsemthesis.dtx:369-371 | yes | a paper-size parameter of `page.class-options`. Reading note only: it passes the option to `book` after `\LoadClass` has already run (338 before 369), so by reading it may have no effect; not tested |
| `\def\cleardoublepage` | gsemthesis.dtx:494-499 | yes | kernel `\cleardoublepage` with `\thispagestyle{empty}` added, which is what package `emptypage` does: `NEW:pg.emptypage`. The stray `\clearpage{\pagestyle{empty}\cleardoublepage}` at line 499 runs at class load; no template look depends on it |
| label macros `\theFaculty`, `\thesisLocationLabel`, `\thesisByLabel`, `\thesisFieldLabel`, `\thesisCommitteeLabel`, `\thesisNumberLabel` | gsemthesis.dtx:573-609 | yes | strings; the emitter inlines the English or French text into the cover block |
| value macros `\authorFirstname`, `\authorLastname`, `\thesisField`, `\thesisCommitteeA-F`, `\thesisNumber`, `\acknowledgements`, `\abstractEN`, `\abstractFR`, `\dedication` | gsemthesis.dtx:621-851 | yes | `\def` storage of content; the emitter writes the content at the place it is printed. The `\ifx&#3&` empty test (646-722) means "skip a blank committee member" |
| `\printcoverpage` | gsemthesis.dtx:737-817 | yes | kernel `center`, `\rule`, `\vspace*`, `\vfill`, `\huge`, `\scshape`, `spacing` only: `front.titlepage-env`. The two `\rule` lines are plain typographic rules, not a drawing |
| `\printfrontmatter` | gsemthesis.dtx:858-923 | yes | sequence of `\chapter*`, `\addcontentsline`, `\thispagestyle`, `\newpage`, `\tableofcontents`, `\cleardoublepage`, dedication block (rows above) |
| `\startintroduction`, `\startconclusion` | gsemthesis.dtx:932-949 | yes | `\chapter*` + `\addcontentsline` + `\label` + `\markboth` |
| `itemize*` | gsemthesis.dtx:958-964 | yes | `\newenvironment` alias of `itemize` with `\setlength`; alternative: `list.enumitem` with `itemsep=0pt, parsep=0pt, before=\vspace{-2mm}, after=\vspace{-2mm}` |
| `\DeclareSortingScheme{nymdt}` | gsemthesis.dtx:532-566 | yes | a declarative biblatex sort specification (field list with padding), a parameter of `bib.biblatex-biber` |
| `monthyeardate` | gsemthesis.dtx:517 | yes | `\newdateformat` of package `datetime`: `NEW:front.datetime` |
| documentation driver (`ltxdoc`, own geometry left=4.5cm right=3.5cm, `itemize*`) | gsemthesis.dtx:26-49 | out of scope | typesets the manual, not the thesis template; not mapped, no way proposed |

## Content-opaque
none (no figure, table, TikZ or code sample in the thesis template; the manual's own verbatim blocks are documentation text)

## Lib changes
- New ways proposed:
  - `NEW:class.gsemthesis`: class `gsemthesis`, pdf. W1: CTAN, TeX Live, MiKTeX, public manual. W2: options fr/draft/custombib/b5paper and string arguments of its commands. W3: serves one kind of document (a GSEM-style thesis cover and front matter), same grain as `class.llncs`. W4: `\documentclass[...]{gsemthesis}` plus command calls in the body. Profile: `\printcoverpage`, `\printfrontmatter`, `\startintroduction`, `\startconclusion`, `\abstractEN`/`\abstractFR`, `\thesisCommitteeA-F`.
  - `NEW:front.datetime`: package `datetime` (CTAN, LPPL; ctan.org lists it as superseded by `datetime2`, so the way covers `datetime`/`datetime2`), pdf. W1: CTAN. W2: `\newdateformat{name}{pattern}` is a declarative format string. W3: any document that prints a date in a chosen format. W4: a preamble line plus `\name\today` in the body. Searched the lib for date formatting: only `front.maketitle` (`\date`) exists and it cannot change the format.
  - `NEW:pg.emptypage`: package `emptypage` (CTAN, LPPL, in TeX Live and MiKTeX per ctan.org/pkg/emptypage), pdf. W1: CTAN. W2: no options, loading it is the switch (a boolean). W3: any two-sided document with fancyhdr or headings. W4: one `\usepackage` line. `pg.break` lists `\cleardoublepage` as a command to call, not a patch of it, so it does not cover this.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Research observation: a published-class zip makes the answer `yes` through one `class.<name>` way, and such ways grow with the number of class zips. The decomposition above is the check that does not depend on that: here it needs only two small extra published ways.
- Reading observations, not tested: `gsemblue` and `erorange` are defined (gsemthesis.dtx:390-391) but the active `\hypersetup` uses `erblue` (411-418; the `gsemblue` version at 404-410 is commented out); non-draft cover prints the compile-time month and year, so `\date` is ignored there (811); `subfigure` is an old package and `datetime` is superseded.
- Nothing in the zip was addressed to an AI.
