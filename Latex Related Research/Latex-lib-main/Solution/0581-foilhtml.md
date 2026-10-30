no

# 0581-foilhtml: FoilHTML (sectioning commands for FoilTeX and LaTeX2HTML conversion)

- Unverified: read from the source, not compiled.
- Source: Source/0581-foilhtml/ (origin: https://mirrors.ctan.org/macros/latex/contrib/foilhtml.zip; licence: LPPL, as the manifest and ctan.org/pkg/foilhtml state)
- Kind: presentation
- Lib: v4
- Engine: pdfLaTeX-compatible (the package code is plain LaTeX2e macros; the documented foils usage passes the `dvips` driver option, foilhtml.dtx:271, and ctan.org/pkg/foiltex says nothing about pdfTeX, so pdfTeX support of the foils class is not established)
- Look carried by: mixed (the documentation driver's look is the published class `ltxdoc`, foilhtml.dtx:37; the look the package adds to foils decks is defined by the `foilhtml.sty` code inside foilhtml.dtx:854-1592, a published CTAN package whose source ships here)
- Class origin: tex-distribution-unbundled (`ltxdoc` for the driver; `foils` from CTAN `foiltex` for the documented usage; neither is in the zip)
- Main file: none (no .tex; the only LaTeX document is the documentation driver inside foilhtml.dtx:36-146; the usage example is foilhtml.dtx:270-273; other samples: none)
- Read: main n/a (no sample file; the whole of foilhtml.dtx, lines 1-1608, plus foilhtml.ins and readme.v12, was read), zip-local classes and styles all (no .cls or .sty file ships; the style code inside foilhtml.dtx was read in full; the `foils` class source is not in the zip and was not read)

## Verdict
no. The zip is the CTAN package `foilhtml`, an add-on with two halves. The LaTeX half (`foilhtml.sty`, foilhtml.dtx:854-1592) is a published package with options and commands, and with `class.foils` it maps to one proposed way, `slide.foilhtml`. The other half is three Perl plug-ins for the LaTeX2HTML translator (foilhtml.dtx:461-847) whose job is to make HTML and `images.tex` outside TeX, so the `EXTERNAL/package` blocker applies and the answer is `no`. If the Perl half were ruled out of scope (a PDF-only reading), the LaTeX half would need only `class.foils` plus the proposed way, and the answer would flip to `yes`.

## Blockers
- `EXTERNAL/package` the headline function is conversion to HTML through LaTeX2HTML, done by Perl scripts generated from the `foils`, `foils-97` and `foilhtml` docstrip streams: `%<*foilhtml|foils-97|foils>` ... `%</foilhtml|foils-97|foils>` (foilhtml.dtx:461-847), `$FOILHEADLEVEL`, `$FOILCLASS`, `$FOILOPTIONS` (494-523), `make_latex` rewriting `images.tex` (533-560, 568-666, 673-803), `&ignore_commands` (822-841); the install steps require LaTeX2HTML and Perl (foilhtml.dtx:214-219, 241-244; readme.v12:30-45)
- `EXTERNAL/package` the style carries a branch used only by that external pass: when no `\foilhead` exists (the `images.tex` run under `article`) it stubs the FoilTeX commands (foilhtml.dtx:919-944), and the example loads LaTeX2HTML's own `html` package (foilhtml.dtx:272; not read, not in the zip)

## Class setting
- Class (driver): `class.ltxdoc` options: none (foilhtml.dtx:37)
- Class (documented usage): `class.foils` options: `20pt`, `dvips` (foilhtml.dtx:271); the package also reads the global option `landscape` (foilhtml.dtx:904). Source of `foils` not in the zip, not read.
- Class-native vocabulary used: `ltxdoc`: `\DescribeMacro` (281), `\changes` (457), `\DoNotIndex` (38-88), `\CodelineIndex` `\RecordChanges` `\EnableCrossrefs` (91-93), `\OnlyDescription` (99), `\GetFileInfo` (154), `\StopEventually` (426), `\Finale` (1595), `\PrintChanges` (1597), `\PrintIndex` (1599), `macro` and `macrocode` environments (858-1592), `\cs` (277), `\meta` (1335), `\oarg` (516), `\bslash` (1286). `foils`: `\foilhead[skip]{title}` and `\rotatefoilhead[skip]{title}` called by the package (957, 960, 1052-1219), `\foilheadskip` (957, 960), and the ignored FoilTeX commands `\MyLogo` `\Restriction` `\LogoOn` `\LogoOff` `\rightfooter` `\rightheader` `\leftheader` `\newnonfloat` (822-841, 926-943).

## Component map
Part A: the documentation driver, the only LaTeX document in the zip. Part B: what an emitter writes for a foils deck that uses the package.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (driver) | foilhtml.dtx:37 | `class.ltxdoc` | no options |
| documentation machinery | foilhtml.dtx:38-93, 99, 144, 154, 426, 457-459, 1595-1599 | `dtx.doc` | `\DocInput{foilhtml.dtx}`, `\CodelineIndex`, `\RecordChanges`, `\EnableCrossrefs`, `\OnlyDescription` (driver mode), `\DoNotIndex` lists, `\StopEventually`, `\Finale`, `\PrintChanges`, `\PrintIndex` |
| label template package | foilhtml.dtx:90 | `list.enumerate-pkg` | loaded; the `enumerate` lists carry no optional label (193, 205, 229) |
| title block | foilhtml.dtx:156-165 | `front.maketitle` | `\title` with two `\thanks`, `\author`, `\date{\filedate}`, `\maketitle` |
| author notes | foilhtml.dtx:158-163 | `front.thanks` | `\thanks` x3 |
| abstract | foilhtml.dtx:167-180 | `abs.kernel` | `abstract` environment |
| contents | foilhtml.dtx:182 | `toc.kernel` | `\tableofcontents` |
| headings of the manual | foilhtml.dtx:94, 100, 184-186 | `head.kernel` | `\partname` set to "Part" (94); `\part` swallowed in driver mode, `\renewcommand{\part}[2][dummy]{}` (100); `\part`, `\section`, `\subsection` |
| lists | foilhtml.dtx:193-202, 222-227, 1285 | `list.kernel` | `enumerate`, `itemize`, `description` |
| verbatim usage example | foilhtml.dtx:270-273 | `code.verbatim` | `verbatim` environment |
| quotes of classes.dtx | foilhtml.dtx:1228, 1400 | `quote.kernel` | `quote`, `quotation` |
| footnotes | foilhtml.dtx:247-253, 275 | `fn.kernel` | `\footnote` |
| bibliography of the manual | foilhtml.dtx:428-451 | `bib.thebibliography` | `thebibliography{1}`, four `\bibitem`; `\cite` at 190-191, 967 |
| cross-references | foilhtml.dtx:284, 323 | `xref.kernel` | `\label{sec:config}`, `\ref` |
| inline marks | foilhtml.dtx:149-151, 215 | `mark.kernel` | `\textsf`, `\texttt`, `\emph` |
| page break in the manual | foilhtml.dtx:427, 454, 1596 | `pg.break` | `\clearpage` |
| class for the example deck | foilhtml.dtx:271 | `class.foils` | `20pt`, `dvips` |
| package load and options | foilhtml.dtx:269-273, 862-864, 904, 909 | `slide.foilhtml` | `\usepackage[pagesintoc|nopagesintoc,landscape]{foilhtml}`; default `nopagesintoc` (864, 889) |
| site configuration file | foilhtml.dtx:876-879, 885-893 | `slide.foilhtml` | `foilhtml.cfg`: `\ExecuteOptions{nopagesintoc}`, `\AtEndOfPackage{\setcounter{secnumdepth}{0}}` |
| orientation switch | foilhtml.dtx:902-904, 955-960 | `slide.foilhtml` | body `\portraitfoils`, `\landscapefoils` and starred forms (a flag `\if@portraitfoils` picks `\foilhead` or `\rotatefoilhead`) |
| part, chapter, section as foils | foilhtml.dtx:1033-1075, 1084-1126, 1134-1191 | `slide.foilhtml` | each title on its own foil: part `\Huge\bfseries` with `\partname~\thepart` in `\huge`; chapter `\huge\bfseries` with `\chaptername` in `\LARGE`; section `\Large\bfseries`; `\clearpage` first (1034, 1085, 1135) |
| subsection placement | foilhtml.dtx:1141-1152, 1183, 1191, 1199-1219 | `slide.foilhtml` | centred `\large\bfseries` heading; new foil unless it directly follows a section title (flag `\if@subnewfoil` reset by `\everypar`) |
| lower headings | foilhtml.dtx:1234-1267 | `head.kernel` | `\@startsection`: subsubsection level 3 indent `\z@` before `-3.25ex plus -1ex minus -.2ex` after `1.5ex plus .2ex`; paragraph level 4 before `3.25ex plus 1ex minus .2ex` after `-1em`; subparagraph level 5 indent `\parindent`; style `\normalfont\normalsize\bfseries` |
| numbering depth | foilhtml.dtx:871, 1298 | `num.secnumdepth` | `secnumdepth` 0 (no heading numbered), `tocdepth` 3 |
| counters and their printing | foilhtml.dtx:988-994, 1012-1018 | `num.counters` | `\newcounter` for part...subparagraph with resets; `\thepart` `\@Roman`, others `\@arabic` |
| contents page | foilhtml.dtx:1328-1331, 1580-1582 | `toc.kernel` | `\tableofcontents` = `\section*{\contentsname}` + `\@starttoc{toc}` + `\clearpage`; `\contentsname` "Outline", `\partname`, `\chaptername` |
| contents entries | foilhtml.dtx:1295-1297, 1310-1321, 1346-1534 | `slide.foilhtml` | `\l@part` `\Large\bfseries`, `\l@chapter` `\large\bfseries`, `\l@section` `\bfseries`, lower via `\@dottedtocline` (page numbers) or the new `\@nopagetocline`; `\@pnumwidth` 1.55em, `\@tocrmarg` 2.55em, `\@dotsep` 4.5; indents 1.5em, 3.8em, 7em, 10em |
| bibliography heading restored | foilhtml.dtx:1546-1569 | `bib.thebibliography` | `\section*{\refname}` put back before the list; `\clubpenalty4000`, `\widowpenalty4000`, `\sloppy` |
| running heads of sections | foilhtml.dtx:1066, 1167-1176, 1190 | `mark.case` | `\markboth{\MakeUppercase{..}}{..}` (the marks are kernel `\markboth`, which the foils class may not print; not read) |
| HTML plug-ins and `html` package | foilhtml.dtx:272, 461-847 | none (EXTERNAL) | see Blockers |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\FH`, `\Perl`, `\latextohtml` aliases | foilhtml.dtx:149-151 | yes | `mark.kernel` (`\textsf`, `\texttt`) around a string |
| `\FoilTeX` logo | foilhtml.dtx:152 | yes | `mark.kernel` font switches `\sffamily` `\rmfamily` `\normalfont` plus a `\kern-.03em` (`sp.manual-space`) |
| `\renewcommand{\part}[2][dummy]{}` | foilhtml.dtx:100 | yes | a no-op `\part` in driver mode; the emitter omits the heading (`head.kernel`) |
| `filecontents{foilhtml.ins}` | foilhtml.dtx:104-141 | yes | writes a file at compile time, prints nothing; no lib way, so it is recorded under Content-opaque |
| `foilhtml.sty` flags `\if@portraitfoils`, `\if@subnewfoil` with `\everypar`, `\@nopagetocline`, `\l@...`, `\@part` family | foilhtml.dtx:902-904, 955-960, 1033-1219, 1310-1534 | not counted as bespoke (W1) | published CTAN package, loaded by name; internally these are hand-rolled conditionals that drive page breaks and orientation, so they cannot be rebuilt from other lib ways and need their own way, `slide.foilhtml` |
| Perl plug-ins `foils.perl`, `foils-97.perl`, `foilhtml-96.perl` | foilhtml.dtx:461-847 | no | Perl for LaTeX2HTML, not LaTeX: `EXTERNAL/package` |

## Content-opaque
- `filecontents{foilhtml.ins}` writes the install script to disk during the documentation run (foilhtml.dtx:104-141); no printed effect.
- Perl `make_latex` strings that embed LaTeX (`\lthtml...` macros) for the LaTeX2HTML `images.tex` pass (foilhtml.dtx:568-666, 673-803); they belong to the EXTERNAL blocker.

## Lib changes
- New ways proposed: `slide.foilhtml` `foilhtml` (CTAN macros/latex/contrib/foilhtml, LPPL, Boris Veytsman, v1.2, in TeX Live and MiKTeX per ctan.org/pkg/foilhtml), pdf engine tag (plain LaTeX2e macros): a load-time add-on for `foils` decks that gives them sectioning commands and a contents list. W1: CTAN package. W2: options `pagesintoc`, `nopagesintoc`, `landscape`, counters `secnumdepth` and `tocdepth`, the string `\contentsname`, a site `.cfg` file. W3: serves any `foils` deck, not one document. W4: preamble `\usepackage[opts]{foilhtml}` and body wrappers `\portraitfoils` and `\landscapefoils` (starred forms). Not `slide.texpower` (overlays), not `head.class-native` (a class's own look) and not `class.foils` (a different file). Only the LaTeX half is the way; the Perl plug-ins are outside it (EXTERNAL).
