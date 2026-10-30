no

# 0138-lund-university-thesis-starter: Lund University Thesis Starter (LTH PhD thesis template)

- Unverified: read from the source, not compiled.
- Source: Source/0138-lund-university-thesis-starter/ (origin: https://latextemplates.com/downloads/lund-thesis.zip; upstream repo named at README.md:27 (gitlab.com/aoer/latex-templates); licence: Apache-2.0, LICENCE:1-2, README.md:29-30)
- Kind: thesis
- Lib: v3
- Engine: pdfLaTeX-compatible (no fontspec or Lua; `plex-sans` is from CTAN `plex`, whose page lists pdfLaTeX support; tikz only for artwork)
- Look carried by: preamble (thesis.tex preamble plus zip-local .tex files it loads: macros.tex, frontpage.tex, datasheet.tex; the zip holds no .cls or .sty, and class `book` is loaded unchanged)
- Class origin: tex-distribution-unbundled
- Main file: thesis.tex (other samples: main.tex, a 68-line compact starter; upstream-example.tex, byte-identical to thesis.tex per `cmp`)
- Read: main yes, zip-local classes and styles none present (all zip-local .tex files read: macros.tex, macros-thesis.tex, frontpage.tex, datasheet.tex, kappa/*, papers/*/*.tex; the three .bib files only skimmed, they are content)

## Verdict
No. The class is plain `book` and most of the preamble reduces to published ways, but thesis.tex carries three things that do not: a tikz "thumb-index" tab drawn in the margin of every chapter opening, whose vertical position is a hand-rolled length that grows by 2cm per call; a copy-and-edit of the kernel `\part` page (`\@part`, `\@spart`, `\@endpart`); and a whole-page "dokumentdatablad" form drawn in a `picture` environment with counters used as coordinates. The compact main.tex alone would reduce to published ways, but the README (README.md:8) and the manifest both point at thesis.tex, which is the template.

## Blockers
- `ART/preamble` margin tabs drawn with tikz in `\markmargin` and `\markmarginKappa`, one black 6cm x 2cm rectangle with rotated white "Paper N" or "Kappa" text, set into `\marginpar` (thesis.tex:153-172; hooks macros.tex:110-111; called at macros.tex:9 and :21)
- `BESPOKE/preamble` hand-rolled length state `\spiff`: `\vspace*{\spiff}` before the marginpar, `\addtolength{\spiff}{2cm}` after, so each chapter opening shifts its tab 2cm further (thesis.tex:152,154,160-161,170-171; macros.tex:112); `\apa` is declared and never set (thesis.tex:151)
- `BESPOKE/preamble` `\part` page: `\renewcommand\part` and `\@part`, `\@spart`, `\@endpart` copied from book.cls with edits to the page flow (`\null\vfil`, the `\newpage` removed) (macros.tex:35-79); no lib way is shown to reproduce that flow; `\@spart` also prints the literal word `scshape` (macros.tex:69, unused by the sample)
- `ART/body` the Lund datasheet page: a `picture` environment of `\put`, `\framebox`, `\line` and a rotated "DOKUMENTDATABLAD enl SIS 61 41 21" caption (datasheet.tex:40-180), pulled in at frontpage.tex:33 (the form is the template's identity, `art.pstricks` in the Restricted section)
- `BESPOKE/body` the datasheet's counter-as-coordinate macros: seven `\newcounter`, `\aformbox`, `\aformhline`, `\aformvline`, and 73 lines of `\setcounter`/`\addtocounter` that position each cell (datasheet.tex:1-38, 49-179); expressions like `\aformw / 2` (datasheet.tex:9-11) need an expression-evaluating `\setcounter`, and no package that provides it is loaded explicitly (not traced)

Not blockers: missing assets `LundUniversityLogo.pdf` (frontpage.tex:15,49) and `plots/*.pdf` (papers/two/background.tex:9,16) are not shipped; `pdf_to_jpeg.sh` (fish, `fd`, `pdftoppm`) is an optional print-service workaround (README.md:18-23, pdf_to_jpeg.sh:1-6), not needed to compile and not run here; BibTeX per included file is the `bib.bibtex-bst` way.

## Class setting
- Class: `class.book` options: `10pt`, `twoside`, `openright` (thesis.tex:5); main.tex:1 same options
- Class-native vocabulary used: `\frontmatter` (thesis.tex:114), `\mainmatter` (thesis.tex:142), `\backmatter` (main.tex:67), `\chapter`, `\chapter*` (kappa/main.tex:1), `\part` (thesis.tex:190, redefined), `\appendix` (main.tex:60), `\chaptername` (thesis.tex:183), `\bibname` (macros.tex:128), `\chaptermark` (macros.tex:94), `\cleardoublepage` (frontpage.tex:2,36)

## Component map
thesis.tex unless another file is named.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | thesis.tex:5 | `class.book` | 10pt, twoside, openright |
| colour options | thesis.tex:2-3, 37 | `color.xcolor`, `color.color` | `svgnames` passed to and loaded with xcolor; `usenames,dvipsnames` passed to `color` (not loaded explicitly) |
| page geometry | thesis.tex:10 | `page.geometry` | papersize={169mm,239mm}, top=10mm, bottom=10mm, textwidth=125mm, includehead, includefoot, marginparwidth=2.5cm |
| font encoding | thesis.tex:13 | `font.fontenc-t1` | T1 |
| sans text face | thesis.tex:14 | `font.helvet` | package `plex-sans` (CTAN `plex`, Bob Tennent) |
| serif text and math | thesis.tex:18-19 | `font.palatino` | `newpxtext`, `newpxmath` (Palatino-like pair, filed with the palatino family) |
| size commands | thesis.tex:24; frontpage.tex:7,9,23 | `font.size-commands` | `moresize` loaded, no command of it used; `\huge`, `\Large`, `\footnotesize` |
| microtype | thesis.tex:31 | `sp.microtype` | defaults |
| widow and club control | thesis.tex:33 | `sp.penalties` | `nowidow` with `all` (package source not read; filed here because its effect is penalty settings) |
| truncated running head text | thesis.tex:25; macros.tex:99 | `sp.truncate` | `\usepackage[fit]{truncate}`, wrapper `\truncate{.95\headwidth}{...}` |
| url | thesis.tex:34 | `meta.url` | hyphens |
| hyperlinks | thesis.tex:35, 131; kappa/main.tex:1; frontpage.tex:96-97 | `meta.hyperref` | hidelinks; `\hypersetup{linkcolor=black}` in a group around the contents; `\texorpdfstring`; `\href` |
| maths packages | thesis.tex:17 | `math.mathtools`, `math.amssymb` | `mathtools`, `amssymb`, `amsfonts` |
| theorem-like | thesis.tex:17; macros.tex:133-150 | `thm.amsthm` | plain: theorem[chapter], lemma/corollary/proposition/observation share the theorem counter; `definition` style: example, definition, remark numbered in chapter; each `\the...` set to `\arabic` |
| per-file bibliographies | thesis.tex:20 | `bib.multi` | chapterbib, option sectionbib |
| bibliography | kappa/main.tex:20-21; papers/one/main.tex:31-32; papers/two/main.tex:35-36 | `bib.bibtex-bst` | style `alpha`; `\bibname` = References (macros.tex:128); `.bib` files per paper |
| header and footer | macros.tex:93-101 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`; LE,RO: `\bfseries\thepage`; LO: italic `\rightmark`; RE: truncated italic `\leftmark`; head rule 0.5pt, foot rule 0pt; `\chaptermark` -> `\markboth{#1}{}` |
| plain page style | macros.tex:103-107 | `hf.fancyhdr` | `\fancypagestyle{plain}`: foot `\chapterFoot` (empty), head cleared, head rule 0pt |
| blank-page styles | frontpage.tex:3,32,37 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| page count | thesis.tex:23, 98; datasheet.tex:148 | `pgnum.lastpage` | `pageslts` (extends lastpage per CTAN), `\lastpageref{LastPages}` |
| chapter heads (numbered, starred) | macros.tex:8-31 | `head.titlesec` | reduction of the kernel-internal redefinition: right-aligned, `\sffamily\bfseries`, `\Huge`, no label printed (the `\@chapapp\thechapter` part is commented out), full-width rule after, spacing 10pt before and 20pt after |
| section fonts | macros.tex:115 | `head.sectsty` | `\allsectionsfont{\sffamily}` |
| chapter name | thesis.tex:183 | `head.kernel` | `\chaptername` = Paper |
| part page | macros.tex:35-79; thesis.tex:190 | none | blocker, see above |
| chapter margin tabs | thesis.tex:153-172 | `note.marginpar`, `art.tikz` | blocker, see above |
| counters and number formats | thesis.tex:65, 143-147, 182, 184; macros.tex:82 | `num.counters` | `\counterwithin{chapter}{part}`; `\thechapter` = `\Roman`; `\thesection`, `\thefigure`, `\thetable`, `\theequation` = `\arabic`; `\numberwithin{equation}{chapter}` |
| equation counter wrappers | thesis.tex:54-61 | `num.counters` | `\section` and `\subsection` wrapped to set `\theequation` to `\arabic{equation}` |
| numbering depth | thesis.tex:127-128 | `num.secnumdepth` | secnumdepth 3, tocdepth 3 |
| paper counter | macros.tex:83-87; papers/one/main.tex:7 | `num.counters`, `xref.kernel`, `xref.cleveref` | `\newcounter{rtaskno}`, `\refstepcounter` + `\label`, `\thertaskno` = `\Roman`, `\crefname`/`\Crefname` Paper/Papers |
| contents | thesis.tex:129-135 | `toc.kernel`, `toc.tocloft` | `\tableofcontents`; `\cftsetindents{chapter}{0em}{2.5em}`; list of figures/tables commented out (thesis.tex:133-134) |
| contents entries | kappa/main.tex:2; macros.tex:54,56 | `toc.kernel` | `\addcontentsline{toc}{part}{...}` |
| cross-references | thesis.tex:38-39; kappa/contribution.tex:5,7 | `xref.cleveref`, `xref.kernel` | `capitalise, noabbrev`; `\creflastconjunction` = `, and\nobreakspace`; `\ref`, `\label` |
| appendix | macros.tex:157-160; papers/two/main.tex:29-31 | `num.appendix` | `\appendixtitleon`, `\appendixtitletocon`, `\setthesection` = `\Alph{section}`, `\setthesubsection` = `\Alph{section}.\arabic{subsection}`; `subappendices` environment |
| epigraphs | thesis.tex:26-28; kappa/contribution.tex:8,15 | `quote.epigraph` | `\epigraphwidth` 0.9\textwidth, `\epigraphrule` 0pt |
| lists | kappa/contributionstatement.tex:6-11,15-17,46-52 | `list.kernel` | description, itemize with custom item labels |
| float package | thesis.tex:42; macros.tex:122 | `fig.float` | `\newfloat{paperfoot}{b}{paper}` |
| per-paper citation note | macros.tex:123-126 | `fig.float`, `sp.rule`, `sp.ragged`, `font.size-commands` | float `paperfoot` holding `\hrulefill`, `\flushleft`, `\footnotesize` |
| captions | thesis.tex:36; papers/two/background.tex:10,17 | `cap.caption`, `cap.kernel` | textfont=it, labelfont={bf,sf}; `\caption` |
| figures | papers/two/background.tex:6-20; papers/one/main.tex:12 | `fig.graphicx`, `cols.minipage`, `sp.ragged`, `sp.manual-space` | figure[t], two `minipage[c]{.48\textwidth}` joined by `\hfill`, `\centering`, `\includegraphics[width=\linewidth]`; `\graphicspath` |
| tables | kappa/contributionstatement.tex:32-41 | `tbl.tabular`, `tbl.booktabs` | `tabular{lcccc}` in `center`, `\toprule \midrule \bottomrule` |
| spacing | kappa/contributionstatement.tex:21,54,56-68; kappa/acknowledgements.tex:8-14 | `sp.manual-space` | `\vspace{1em}`, `\medskip`, `\smallskip`, `\enskip`, `\hfill` |
| todo notes | thesis.tex:46-48 | `note.todonotes` | no options (the `disable` variant is commented) |
| deferred page flow | thesis.tex:30 | `pg.afterpage` | loaded, not used |
| title page 1 and 2 | frontpage.tex:2-27, 36-62 | `front.titlepage-env`, `pg.break`, `fig.graphicx`, `sp.manual-space`, `font.size-commands` | hand-laid in `center`: `~`, `\vfill`, `\huge` title, `\Large` subtitle, "by Name", logo `width=0.25\textwidth`, degree, advisors, opponent, `\footnotesize` defence text; `\cleardoublepage`; page 2 is the same with `\color{white}` text (frontpage.tex:51) |
| text colour | frontpage.tex:51 | `color.xcolor` | `\color{white}` hides the second page's lower block |
| book metadata page | frontpage.tex:65-105 | `front.dedication`, `sp.manual-space`, `mark.kernel`, `meta.hyperref` | `flushleft`, `\vspace*{\stretch{1}}`, `\linebreak[2]`, ISBN/ISSN lines, `\href`, `\texttt`, `\textit` |
| datasheet page | frontpage.tex:31-33; datasheet.tex:40-180 | `art.pstricks`, `box.minipage`, `fig.rotating` | blocker, see above (`picture`, `\parbox[t]`, `\rotatebox{90}` at datasheet.tex:44) |
| acknowledgements, summaries | kappa/acknowledgements.tex:1; kappa/popular-summary.tex:1; kappa/contributionstatement.tex:1 | `front.dedication`, `head.kernel` | unnumbered-looking front chapters via `\chapter`, `\emph` |
| kappa opening | kappa/main.tex:1-3 | `head.kernel`, `toc.kernel`, `hf.fancyhdr` | `\chapter*`, `\addcontentsline`, `\markboth{\titlenameshort}{}` |
| sections inside chapters | kappa/introduction.tex:1; papers/one/introduction.tex:1 | `head.kernel` | `\section`, `\subsection`, `\subsection*` |
| paper abstracts | macros.tex:154; papers/one/abstract.tex:1-3 | `head.kernel` | alias environment `abstract` = `\section*{Abstract}` |
| main.tex: class, page | main.tex:1-2 | `class.book`, `page.geometry` | same options; top=14mm, bottom=14mm, no marginparwidth |
| main.tex: fonts, packages | main.tex:3-7 | `font.fontenc-t1`, `font.palatino`, `sp.microtype`, `tbl.booktabs`, `meta.hyperref` | T1, newpxtext+newpxmath, hidelinks |
| main.tex: running heads | main.tex:8-13 | `hf.fancyhdr` | LE,RO `\thepage`; RE `\leftmark`; LO `\rightmark` |
| main.tex: title block | main.tex:14-19 | `front.maketitle` | `\title`, `\author`, `\date`, `\maketitle` |
| main.tex: abstract chapter | main.tex:20-21 | `head.kernel`, `toc.kernel` | `\chapter*{Abstract}` + `\addcontentsline` |
| main.tex: equation, table, list | main.tex:40-43, 44-56, 62-66 | `math.kernel`, `tbl.tabular`, `tbl.booktabs`, `cap.kernel`, `sp.ragged`, `list.kernel` | `equation`; table[ht] with `\centering`, `lrr`; itemize |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\markmargin`, `\markmarginKappa` (tikz tab in `\marginpar`) | thesis.tex:153-172 | No | ART: drawn artwork inside a margin note |
| `\spiff` accumulator, `\apa` | thesis.tex:151-152,161,171; macros.tex:112 | No | hand-rolled state that changes what is printed on each call |
| `\@makechapterhead`, `\@makeschapterhead` | macros.tex:8-31 | Yes, except the `\markmargin` call | `head.titlesec`: `\titleformat` shape with raggedleft, sf bold `\Huge`, empty label, rule after; `\titlespacing` 10pt/20pt; starred variant likewise |
| `\part`, `\@part`, `\@spart`, `\@endpart` | macros.tex:35-79 | No (as written) | formatting alone (title between two rules, sf bold, `\Huge`) could be `head.titlesec`; the page flow is not shown expressible |
| `\thickhrulefill` | macros.tex:7 | Yes (unused) | `sp.rule`: `\leaders\hrule height 1ex` |
| `\section`, `\subsection` wrappers | thesis.tex:54-61 | Yes | `num.counters`: `\renewcommand{\theequation}{\arabic{equation}}` |
| `rtaskno`, `\paper`, `\thertaskno` | macros.tex:83-85; thesis.tex:184 | Yes | `num.counters` + `xref.kernel` + `xref.cleveref` |
| `paperfoot` float, `\paperRemark` | macros.tex:122-126 | Yes | `fig.float` with `sp.rule`, `sp.ragged`, `font.size-commands` |
| `abstract` environment | macros.tex:154 | Yes | alias for `\section*{Abstract}` (`head.kernel`) |
| `\bibpath` | macros.tex:130; papers/one/main.tex:14; papers/two/main.tex:14 | Yes | string macro; the emitter writes the relative `.bib` path |
| `\input@path`, `\graphicspath` | papers/one/main.tex:10-13; papers/two/main.tex:10-13 | Yes | file-path plumbing; the emitter writes full paths |
| `\chapterFoot`, `\Chapter` | macros.tex:109, 119 | Yes | empty hook and a `Chapter~\ref` alias, never used in the sample |
| metadata macros `\myX`, `\titlename`, `\xspace` | thesis.tex:78-106 | Yes | content strings substituted by the emitter; `xspace` is macro plumbing (considered: `xspace`, no way needed) |
| `\ifdef{\myFundingOrganization}` | frontpage.tex:81; datasheet.tex:85 | Yes | the field is defined (thesis.tex:99), so the emitter prints or drops the line; `\ifdef` is etoolbox, not loaded explicitly (which package supplies it was not traced) |
| `\paperOne`, `\paperTwo`, `\paperNotIncludedOne` | macros-thesis.tex:2-15 | Yes | content: citation strings |
| `\zeroone`, `\macrosforpaper` | papers/two/notationLocal.tex:7; papers/one/macros-local.tex:1 | Yes | content macros |
| datasheet counters and `\aform*` macros | datasheet.tex:1-38, 49-179 | No | counters as coordinates drive every cell position |
| `\creflastconjunction` | thesis.tex:39 | Yes | `xref.cleveref` conjunction string |

## Content-opaque
- Circle glyphs (full, empty, quarter, half, three-quarter) defined as tikz pictures and used as table cells and itemize labels (kappa/contributionstatement.tex:24-31, used at :37-38 and :47-51). Judged content of the example contribution table, not template identity; `\rbhead` (:23) is defined and never used.
- Included plot PDFs (papers/two/background.tex:9,16), the university logo (frontpage.tex:15,49) and all prose and bibliography entries (refLocal.bib, papers/*/refLocal.bib).

## Lib changes
- New ways proposed: `sp.truncate` `truncate` package (CTAN and TeX Live, v3.6, Donald Arseneau; read at ctan.org/pkg/truncate), pdfLaTeX. W1: published on CTAN. W2: option `fit` and a width length plus the text as arguments, nothing edited. W3: serves any single-line field (running heads, captions, table cells). W4: preamble `\usepackage[fit]{truncate}` and a wrapper `\truncate{width}{text}` around a node's text. No existing line fits: `sp.rule` and `sp.manual-space` set spacing, `hf.fancyhdr` takes the field text as content.
- Considered, not proposed: `nowidow` (filed under `sp.penalties`, source not read), `xspace` (macro plumbing), `pageslts` (filed under `pgnum.lastpage`, which already names the lastpage family).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
