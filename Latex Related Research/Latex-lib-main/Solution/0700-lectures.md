no

# 0700-lectures: lectures (CTAN class for lecture notes)

- Unverified: read from the source, not compiled.
- Source: Source/0700-lectures/ (origin: https://mirrors.ctan.org/macros/latex/contrib/lectures.zip; licence: MIT, README.md:5 and README.md:195; ctan.org/pkg/lectures read: Luca Cappelletti, v1.0.7 of 2025-03-15, MIT, in TeX Live and MiKTeX)
- Kind: report (lecture notes on top of `report`; the manifest hint "misc" is not used)
- Lib: v5
- Engine: pdfLaTeX-compatible (inputenc/fontenc, no fontspec; `minted` additionally needs `-shell-escape` and Pygments, see Blockers)
- Look carried by: class (everything is defined in lectures.cls; example.tex has no preamble beyond `\documentclass[english]{lectures}`)
- Class origin: ctan (the zip is the CTAN release of the class itself; lectures.cls:13)
- Main file: example.tex (other samples: none; README.md repeats the same snippets at README.md:37-61, 139-159, 174-183; example.pdf is a binary and was not read)
- Read: main yes, zip-local classes and styles all (lectures.cls, 743 lines, read in full; there is no other .cls, .sty, .def or .cfg in the zip)

## Verdict
No. `lectures.cls` loads `minted` unconditionally (`\RequirePackage[cache=true]{minted}`, lectures.cls:484) and sets its defaults with `\setminted` (lectures.cls:487-505). By the rubric's pilot ruling this is `EXTERNAL/package` although example.tex never prints code, because no document in this class compiles without shell escape and Pygments. Apart from that, the class is the published CTAN class itself, so nothing in the zip is zip-local; its look decomposes into published packages (`geometry`, `fancyhdr`, `quotchap`, `tcolorbox`, `enumitem`, `caption`/`subcaption`, `hyperref`, `biblatex`) plus the class's own vocabulary, and there is no template-defining artwork. One item has no shown reduction if the class internals were counted as bespoke: the `\@makechapterhead` override (lectures.cls:87-98), see Bespoke code. The verdict does not rest on it.

## Blockers
- `EXTERNAL/package` `minted` loaded unconditionally by the class, with `\setminted{...}` defaults and `cache=true`; needs `-shell-escape` and Pygments (lectures.cls:484, 487-505)

## Class setting
- Class: `class.lectures` options: `english` (example.tex:1), `italian`; any other option is passed to `report` (lectures.cls:16-19). It loads `class.report` (lectures.cls:14).
- Class-native vocabulary used: `\maketitle` with nine braced arguments, in order title, authors, professors, speakers, year, CFU, degree, university, country, names separated by commas (example.tex:3-21; lectures.cls:670-681); colour-boxed theorem-like environments `theorem`, `definition`, `proof` (example.tex:29-42; lectures.cls:563-583; README.md:115-135 lists 19); `todolist` (example.tex:44-48; lectures.cls:540-542); table column types `L C R` (example.tex:23; lectures.cls:464-466); floats centred and defaulting to `[H]` (example.tex:50-61; lectures.cls:117-133); `\NewAdigraph` from `adigraph` (example.tex:52; package loaded at lectures.cls:523). Unused by the sample but defined: `\rom`, `\unit`, `\prob`, `\mean`, `\bayes`, `\buildVectorAliases` aliases, `\DisableTikz`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example.tex:1; lectures.cls:13-14 | `class.lectures` | option `english`; `\LoadClass{report}` |
| base class | lectures.cls:14, 18 | `class.report` | no `\chapter` in the sample; unknown options forwarded |
| language | lectures.cls:11, 16-19, 48 | `lang.babel` | `\RequirePackage[\defaultlanguage]{babel}`, value `english` or `italian` |
| page geometry | lectures.cls:22-28 | `page.geometry` | a4paper, total={190mm,260mm}, left=10mm, top=20mm |
| encodings | lectures.cls:30-31, 49 | `font.fontenc-t1` | `inputenc` utf8, `fontenc` T1 (loaded twice) |
| default family | lectures.cls:32 | `font.family-default` | `\familydefault` = `\sfdefault` |
| Utopia and math fonts | lectures.cls:67 | `font.fourier` | package `fourier`, no options (the comment says it is loaded for orns icons; its source is not in the zip and was not read) |
| symbol glyphs | lectures.cls:58, 68, 159 | `font.icons` | `gensymb`, `marvosym` (`\Cross` is used by `\crs`) |
| relative font size | lectures.cls:520 | `font.size-commands` | package `relsize`, load only (considered as a package-as-parameter case, not proposed) |
| micro-typography | lectures.cls:52 | `sp.microtype` | defaults |
| paragraph spacing | lectures.cls:64 | `sp.parskip-pkg` | defaults (README.md:190: blank line instead of `\\`) |
| blank pages | lectures.cls:51 | `pg.emptypage` | load only |
| header and footer | lectures.cls:77-82 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\cfoot{}`, `\rfoot{\thepage}`; header fields left at fancyhdr defaults |
| chapter-heading package | lectures.cls:84 | `head.fncychap` | package `quotchap`, option `avantgarde` (ctan.org/pkg/quotchap read: decorative chapter headings with quotations, GPL 2, v1.3, in TeX Live and MiKTeX; the page lists no options, so `avantgarde` is not confirmed there; the same type as `fncychap`, package as parameter) |
| chapter head override | lectures.cls:87-98 | `head.class-native` | `\@makechapterhead` redefined: `\raggedleft`, number in `\Huge` under `\if@mainmatter`, else `\phantom`, title `\raggedleft` with `\advance\leftmargin10em`; uses `\size@chapter`, `\sectfont`, `\chapnumfont` |
| section fonts | lectures.cls:76 | `head.sectsty` | package `sectsty`, load only (no `\allsectionsfont` or `\chapterfont` anywhere in the zip) |
| title page command | example.tex:3-21; lectures.cls:670-681 | `front.class-native` | `\RenewDocumentCommand{\maketitle}{m G{} G{} G{} G{} G{} G{} G{} G{}}`; name lists split at commas by `\SplitList` and `\ProcessList` (lectures.cls:621-668); empty fields skipped by `\ifblank` |
| title page structure | lectures.cls:683-684, 715-716 | `front.titlepage-env` | `titlepage` holding `center`; upper block (title, names, CFU), `\vfill`, lower block (year, degree, university, country, `\today`, lectures.cls:695-714) |
| title text | lectures.cls:685, 626, 635, 692 | `mark.kernel` | `\textbf{\MakeUppercase{\large{#1}}}`; authors `\textbf`; professors prefixed `Prof.\,`; CFU line bold |
| title text case | lectures.cls:685, 692 | `mark.case` | `\MakeUppercase` |
| title spacing | lectures.cls:686, 691, 693, 695 | `sp.manual-space` | `\vspace{1em}`, `\vfill` |
| title logo | lectures.cls:697-701 | `fig.graphicx` | `\IfFileExists{images/logo.png}` then `figure` with `\includegraphics[width=0.1\textwidth]{logo}` (asset not shipped in the zip) |
| contents | lectures.cls:720-724 | `toc.kernel` | `\tableofcontents` in a group with `\hypersetup{hidelinks}` |
| links | lectures.cls:59, 682, 717, 723 | `meta.hyperref` | colorlinks=true, urlcolor=blue, pdfpagelabels, hyperindex=false; `pageanchor=false` around the title page; `hidelinks` around the contents |
| colour package | lectures.cls:61, 486 | `color.xcolor` | options x11names, table, dvipsnames; `\definecolor{mintedbackground}{rgb}{0.95,0.95,0.95}` |
| table colour | lectures.cls:61 | `tbl.colortbl` | the `table` option of `xcolor` |
| colour aliases | lectures.cls:141-151 | `color.xcolor` | `\red` and `\error` = `\textcolor{red!90}`, `\blue` = `\textcolor{blue!90}` |
| display maths | lectures.cls:46, 187-193, 260-262; example.tex:31-33 | `math.amsmath` | `equation` env in the sample; `\DeclareMathOperator`, `bmatrix` in the class |
| math symbols | lectures.cls:46, 53, 56 | `math.amssymb` | `amsfonts`, `amssymb`; `centernot`, `stmaryrd` (symbol package as parameter, not proposed); `\geq`/`\leq` mapped to `\geqslant`/`\leqslant` (lectures.cls:184-185) |
| math bold | lectures.cls:46, 179-183 | `math.bm` | `bm`; `\bm` redefined as `\oldbm{\underline{#1}}` |
| math cancel | lectures.cls:66 | `math.physics` | `cancel` |
| slash fractions | lectures.cls:46 | `math.nicefrac` | `xfrac`, load only |
| tables | example.tex:23-27; lectures.cls:46, 464-467 | `tbl.tabular` | `array`; `\newcolumntype{L}{>{$}l<{$}}`, `C` (`c`), `R` (`r`); `\arraystretch` 1.25 |
| diagonal cells | lectures.cls:60 | `tbl.multirow` | `diagbox`, load only |
| theorem boxes | example.tex:29-42; lectures.cls:552-586 | `thm.tcolorbox` | 19 `\newtcolorbox[auto counter,number within=chapter]{env}[1][]` (lectures.cls:560) with `colback`, `colframe`, `coltitle`, `fonttitle=\bfseries`, `parbox=false`, `title` = name, `\thetcbcounter`, a vertical bar, the optional argument; colours per env, e.g. theorem `Chartreuse2!10`/`Chartreuse3!30`/black (lectures.cls:568), definition `Red2!10`/`Red2!40`/black (lectures.cls:566); names switch on `\defaultlanguage`; `proof` renewed as the `proofWrapper` box (lectures.cls:582-583); core `\newtcolorbox`, not `\newtcbtheorem` |
| theorem style | lectures.cls:46, 551, 593-600 | `thm.amsthm` | `\theoremstyle{definition}`; `\th@plain` and `\th@definition` set `\thm@notefont{}` with `\itshape` or `\normalfont`; no amsthm theorem is declared by the class, so no visible effect |
| figures | lectures.cls:106, 109 | `fig.graphicx` | `graphicx`; `\graphicspath{{images/}}` |
| float position | lectures.cls:55, 129-133 | `fig.float` | `float` package; `fps@figure` and `fps@table` = `H` |
| float centring | lectures.cls:117-119 | `sp.ragged` | `\centering` appended to `\@floatboxreset` |
| float spacing | lectures.cls:111 | `fig.placement` | `\intextsep` = 3pt plus 2pt minus 2pt |
| captions | lectures.cls:107; example.tex:59 | `cap.caption` | `caption` package, no options |
| caption command | example.tex:59 | `cap.kernel` | `\caption{A directed graph}` |
| subfigures | lectures.cls:108; example.tex:51-60 | `fig.subcaption` | `subcaption`; `subfigure` of width `0.49\textwidth` |
| lists | lectures.cls:539-542; example.tex:44-48 | `list.enumitem` | `[shortlabels]`; `\newlist{todolist}{itemize}{2}`; `\setlist[todolist]{label=$\square$}` |
| compact lists | lectures.cls:538 | `list.paralist` | load only (the `\setlist{nolistsep}` line is commented out, lectures.cls:541) |
| bibliography | lectures.cls:475-476 | `bib.biblatex-bibtex` | style=authoryear, sorting=ynt, backend=bibtex; `\nocite{*}`; the sample has no `\addbibresource` or `\printbibliography` |
| code | lectures.cls:484, 487-505 | `code.minted` | EXTERNAL; `\setminted{bgcolor=mintedbackground, fontfamily=tt, linenos=true, numbersep=5pt, frame=leftline, framerule=0.4pt, framesep=2mm, tabsize=4, ...}`; `cache=true` |
| algorithms | lectures.cls:485 | `alg.algorithm2e` | `algoruled`, `linesnumbered`, `titlenumbered` |
| verbatim, framed, columns | lectures.cls:50, 54, 57 | `code.verbatim` | `verbatim`; also `box.mdframed` (`framed`) and `cols.multicol` (`multicol`), all load only |
| quotation marks | lectures.cls:508 | `lang.csquotes` | load only, after minted |
| underline and strike | lectures.cls:65 | `mark.ulem` | `soul`, load only |
| sub-files | lectures.cls:63 | `pg.standalone-pkg` | package `subfiles`, load only (same type: sub-files with their own preamble; not proposed) |
| drawing packages | lectures.cls:516-518, 527-529 | `art.tikz` | `pgfplots` (`compat=1.14`, `samples=60`, `shader=interp`, `grid=both`), `tikz`, libraries `shapes,arrows,calc,positioning,matrix`; settings for figure content only |
| content packages | lectures.cls:519, 521-526 | `art.content-package` | `tikz-qtree`, `circuitikz` (`\ctikzset` tripole styles), `bodegraph`, `adigraph`; figure content only |
| helper packages | lectures.cls:21, 35-44, 47 | none | `etoolbox`, `silence` with 9 `\WarningFilter` lines (lectures.cls:36-44), `fp`, `xparse`, `iftex`: no printed effect, so not a component (as the v4 ruling on load-only helpers) |

## Bespoke code
No code is zip-local: the zip is the CTAN class itself. The rows are the class's own macros, listed because the class is read as source (rubric scope 1). "Reducible" says whether a composition of lib ways exists if the class were not available.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\@makechapterhead` override | lectures.cls:87-98 | not shown | `head.titlesec` `\titleformat{\chapter}[display]` right-aligned is plausible, but the body calls `\size@chapter`, `\sectfont` and `\chapnumfont` (none is defined in this file, lectures.cls:90-91; they come from `quotchap` or `sectsty`, whose source was not read) and branches on `\if@mainmatter` (a `book` switch, lectures.cls:93) to print the number or a `\phantom` of it, a hand-rolled conditional that drives what is printed; the sample has no chapter. It sits inside the published class, so it is `class.lectures` own code (`head.class-native`) and not a blocker under the rubric; listed so the file can be re-read under a definition that counts class internals |
| float centring hook | lectures.cls:117-119 | yes | `\centering` at the top of each figure and table (`sp.ragged`) |
| default float position `H` | lectures.cls:129-133 | yes | `[H]` on each float, or `\floatplacement` of `float` (`fig.float`) |
| colour aliases | lectures.cls:141-151 | yes | `\textcolor{red!90}{..}` (`color.xcolor`) |
| math shortcuts, operators, number sets, renewed `\hat \tilde \bar \bm \geq \leq` | lectures.cls:159-218 | yes | `\newcommand` and `\DeclareMathOperator` over `math.amsmath`, `math.amssymb`, `math.bm` |
| `\buildVectorAliases` and its 14 calls | lectures.cls:221-250 | yes | expands to 5 `\newcommand` aliases per letter (`\bm`, `\bbm`, starred and transpose forms) |
| derivative macros and `\Matrix` | lectures.cls:253-262 | yes | `\frac{d..}{d..}`, `bmatrix` (`math.amsmath`) |
| probability macros with `\ifblank` and `\IfNoValueTF` branches | lectures.cls:270-420 | yes, per call site | each branch prints a fixed `\mathbb{P}`, `\mathbb{E}` or `\text{Var}` form with `\left..\right`; reduces by expansion at each call; keeping the macro would copy its xparse logic; none is used in the sample |
| unit macros | lectures.cls:430-455 | yes | `\sqr`, `\frac`, `^\circ C` text |
| `L C R` columns, `\arraystretch` | lectures.cls:464-467 | yes | `\newcolumntype` and `\renewcommand` (`tbl.tabular`) |
| `todolist` | lectures.cls:540-542 | yes | `list.enumitem` `\newlist` and `\setlist` |
| `\createtheorem`, `\defineTheorems`, `\AtBeginDocument` | lectures.cls:553-586 | yes | 19 `\newtcolorbox` calls with the parameters above; the language switch is a string choice made at emit time; the deferral becomes preamble order (`thm.tcolorbox`) |
| amsthm style hooks | lectures.cls:593-600 | yes | `\newtheoremstyle` equivalents (`thm.amsthm`); no effect on the tcolorbox environments |
| `\rom` and `\checkmark` | lectures.cls:610, 613 | yes, and partly | `\rom` is `\uppercase` of `\romannumeral`, expanded to a string at emit time; `\checkmark` is a TikZ-drawn glyph replacing amssymb's, a glyph and not template identity, not used in the sample |
| `\maketitle` override and name processors | lectures.cls:621-718 | yes | emit-time expansion to `front.titlepage-env` with `mark.kernel`, `mark.case`, `sp.manual-space`, `\today` under `lang.babel`; the comma splitting and the blank tests depend only on the data and on `images/logo.png` existing |
| `\tableofcontents` wrapper | lectures.cls:720-724 | yes | `toc.kernel` in a group with `meta.hyperref` `hidelinks` |
| `\DisableTikz` | lectures.cls:726-743 | yes | a switch never called by the class or sample that turns `tikzpicture` into a `comment`; its only effect would be dropping figure artwork (content), omitted at emit time |
| `\defaultlanguage` options | lectures.cls:11, 16-17 | yes | a `lang.babel` option value |

## Content-opaque
- adigraph directed graph in a subfigure (example.tex:52-58), `art.content-package`.
- Loaded but not used by the sample: circuitikz, bodegraph, tikz-qtree and pgfplots drawings (lectures.cls:516-529); the class itself draws no template artwork.
- Missing asset: `images/logo.png`, tested at lectures.cls:697 and not shipped.
- Observation: the `\setminted` list has no comma between `mathescape=false` and `samepage=false` (lectures.cls:500-501); read only, it matters only under the EXTERNAL minted setup.

## Lib changes
- New ways proposed: none. Considered and kept inside existing lines: `quotchap` into `head.fncychap`, `subfiles` into `pg.standalone-pkg`, `relsize` into `font.size-commands`, `stmaryrd` and `centernot` into `math.amssymb`, `gensymb` into `font.icons`. `class.lectures` is written plainly as a class way (vocabulary under Class setting).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
