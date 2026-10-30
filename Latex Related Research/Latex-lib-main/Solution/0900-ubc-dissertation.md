yes

# 0900-ubc-dissertation: UBC Dissertation (ubcdiss thesis class)

- Unverified: read from the source, not compiled.
- Source: Source/0900-ubc-dissertation/ (origin: https://latextemplates.com/downloads/ubc-thesis.zip; licence: CC0-1.0 per the manifest; ubcdiss.cls:16 says public domain)
- Kind: thesis
- Lib: v6
- Engine: pdfLaTeX-compatible (times, mathptmx, courier, helvet, natbib, tocloft, tocbibind, textcase are all 8-bit Type 1 packages; no fontspec, no Lua)
- Look carried by: mixed (zip-local `ubcdiss.cls` defines title page, committee page, contents-list look and page-number scheme; `main.tex` preamble defines fonts, natbib, hyperref)
- Class origin: zip-local (a one-line read of https://ctan.org/pkg/ubcdiss returned 404, so the class is not on CTAN; the zip is from latextemplates.com, not an official release; it is `\LoadClass[letterpaper]{book}` plus the bespoke items below)
- Main file: main.tex (other samples: none; the body is split over chapters/abstract.tex, laysummary.tex, ack.tex, introduction.tex, evaluation.tex)
- Read: main yes, zip-local classes and styles all (ubcdiss.cls 313 lines, main.tex 79, macros.tex 1, five chapter files, references.bib)

## Verdict
The look is a thin zip-local layer over the kernel `book` class. `ubcdiss.cls` only loads `book`, loads `calc`, `ifthen`, `setspace`, `textcase`, `tocbibind` and `tocloft`, sets a few lengths and float fractions, and redefines `\maketitle` as a hand-laid `titlepage` plus a committee certification page. Every one of these effects is a composition of lib ways with parameters, and the macro helpers (`\@addto`, field setters, option plumbing) reduce by inline expansion once the options and fields are known. There is no output routine, no `\halign` or box algorithm, no expl3 or Lua, no TikZ or PGF artwork and no external tool (BibTeX is the tool of `bib.bibtex-bst`). The residual risk is that a reviewer counts the redefined `\maketitle` and the `\@addto` token accumulator as irreducible class code (cls:42-47, cls:239-281); I argue they flatten to a literal `titlepage` body.

## Blockers
none

## Class setting
- Class: `class.book` (flattened from the zip-local `ubcdiss`, `\LoadClass[letterpaper]{book}` at ubcdiss.cls:91) options: letterpaper, 11pt, oneside (main.tex:1 `gpscopy` runs `\PassOptionsToClass{oneside}{book}` at ubcdiss.cls:56-58; `11pt` at ubcdiss.cls:82; `onehalfspacing` only redefines `\textspacing`, ubcdiss.cls:73-75)
- Class-native vocabulary used: zip-local `ubcdiss` commands `\previousdegree` (main.tex:18), `\degreetitle` (main.tex:20), `\institution` (main.tex:22), `\campus` (main.tex:23), `\faculty` (main.tex:25), `\department` (main.tex:26), `\submissionmonth` `\submissionyear` (main.tex:27-28), `\examiningcommittee` (main.tex:30-32), `\supervisorycommittee` (main.tex:34), `\makecommitteepage` (main.tex:45), `\textspacing` (main.tex:62); `book` commands `\chapter` `\mainmatter` `\backmatter` (main.tex:66,77); unused here: `\subtitle` (ubcdiss.cls:213), options `balanced`, `fogscopy`, `draft`, `twoside`, `singlespacing`, `doublespacing`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1; ubcdiss.cls:91 | `class.book` | letterpaper, 11pt, oneside (flattened from zip-local `ubcdiss` options `gpscopy,onehalfspacing,11pt`) |
| paper, size, sides | ubcdiss.cls:56-58, 82, 87, 91 | `page.class-options` | letterpaper, 11pt, oneside; margins are the `book` defaults, no geometry package |
| balanced margins (option, unused by sample) | ubcdiss.cls:94-99 | `page.setlength` | `\oddsidemargin` and `\evensidemargin` set from `\paperwidth-\textwidth` with `calc` infix syntax (`sp.lengths`) |
| body line spacing | main.tex:62; ubcdiss.cls:69, 73-75, 92 | `sp.setspace` | `\onehalfspacing` printed where main.tex calls `\textspacing`; front matter stays single |
| single-spaced blocks | main.tex:71-75; ubcdiss.cls:292, 310 | `sp.setspace` | `singlespace` environment (bibliography, committee page) |
| ragged bibliography, centred floats | main.tex:72; chapters/evaluation.tex:10, 30 | `sp.ragged` | `\raggedright`, `\centering` |
| lengths and calc | ubcdiss.cls:38, 143-154, 247 | `sp.lengths` | `calc` loaded; `\baselineskip`=20pt inside the title `center`; `\settowidth`, `\addtolength` on tocloft lengths |
| title page text | main.tex:16-17; ubcdiss.cls:245-276 | `front.maketitle` | `\title`, `\author` fields kept; page body is `front.titlepage-env` below |
| title page layout | ubcdiss.cls:245-276 | `front.titlepage-env` | `titlepage` env: `\null\vfil\par`, `center`, `\\[1em]` and `\vspace{2em}` gaps, `\vfill\null`; lines: title, "by", author, previous degree, "a thesis submitted ...", degree, "in", faculty, department, institution, campus, month year, copyright line |
| title page spacing and fonts | ubcdiss.cls:248-273 | `sp.manual-space`, `font.size-commands`, `mark.kernel` | `\Large`, `\large`, `\textbf`, `\bfseries`, `\textsc` |
| faculty name lower-cased in small caps | ubcdiss.cls:101, 265 | `mark.case` | `textcase` `\MakeTextLowercase` inside `\textsc` |
| front-matter page numbering | ubcdiss.cls:243, 277 | `pgnum.pagenumbering` | `\frontmatter` (book: roman) before the title page, then `\setcounter{page}{2}`; `\mainmatter` (main.tex:66) restarts arabic |
| page styles | ubcdiss.cls:180, 244, 278 | `hf.pagestyle-kernel` | `plain` (number at foot centre), `empty` around the title page |
| committee certification page | main.tex:45; ubcdiss.cls:291-312 | `front.dedication` | one page: certification sentence, title in `\large\textbf`, author, degree, department, "Examining Committee" list, "Additional Supervisory Committee Members" list, `\cleardoublepage`; names are content |
| abstract | chapters/abstract.tex:1; main.tex:47 | `head.kernel` | plain `\chapter{Abstract}` (no `abstract` environment, no `abs.*` way used) |
| lay summary | chapters/laysummary.tex:1; main.tex:50 | `head.kernel` | plain `\chapter{Lay Summary}` |
| acknowledgements | chapters/ack.tex:1; main.tex:64 | `front.dedication` | plain `\chapter{Acknowledgments}` before `\mainmatter` |
| page breaks | main.tex:48, 51, 54, 57, 60; ubcdiss.cls:311 | `pg.break` | `\cleardoublepage` |
| table of contents, lists | main.tex:53, 56, 59 | `toc.kernel` | `\tableofcontents`, `\listoftables`, `\listoffigures` |
| contents title | ubcdiss.cls:115 | `toc.kernel` | `\renewcommand{\contentsname}{Table of Contents}` (gpscopy branch) |
| contents entries | ubcdiss.cls:119-121, 143-154 | `toc.tocloft` | `[titles]`; `\cftpartdotsep` and `\cftchapdotsep` = `\cftdotsep`; `\cfttabindent`, `\cftfigindent` = 0em; `\cfttabpresnum`="Table ", `\cftfigpresnum`="Figure "; `\cfttabnumwidth` and `\cftfignumwidth` widened by the measured prefix width (the `\settowidth` result is a number) |
| contents lists in the contents | ubcdiss.cls:106-110 | `toc.etoc` | `tocbibind` with no option under gpscopy (`nottoc` otherwise): lists and the contents itself appear in the contents |
| float fractions | ubcdiss.cls:174-176; chapters/evaluation.tex:9, 29 | `fig.placement` | `\topfraction`=0.85, `\textfraction`=0.1, `\floatpagefraction`=0.75; placement `[htbp]` |
| chapters, sections | chapters/introduction.tex:1, 4, 11, 22; chapters/evaluation.tex:1, 4, 24, 36 | `head.kernel` | `\chapter`, `\section` at `book` defaults, no `titlesec` |
| enumerated list | chapters/introduction.tex:15-20 | `list.kernel` | `enumerate` |
| table float | chapters/evaluation.tex:9-22 | `tbl.tabular` | `tabular` with `@{}lrr@{}` |
| table rules | main.tex:6; chapters/evaluation.tex:14-20 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| figure float | main.tex:5; chapters/evaluation.tex:29-34 | `fig.graphicx` | `figure[htbp]`; content is a `\rule{0.6\textwidth}{4cm}` placeholder (chapters/evaluation.tex:31, content) |
| captions | chapters/evaluation.tex:11, 32 (the table caption is above the tabular, the figure caption below) | `cap.kernel` | `\caption` placed above the `tabular` (evaluation.tex:11) and below the figure body (evaluation.tex:32); kernel caption format, no `caption` package |
| fonts, serif and maths | main.tex:3 | `font.mathptmx` | `times,mathptmx` |
| fonts, mono | main.tex:3 | `font.mono` | `courier` |
| fonts, sans | main.tex:4 | `font.helvet` | `helvet` with `scaled=.92` |
| citations | main.tex:7; chapters/introduction.tex:8, 24; chapters/evaluation.tex:40 | `bib.natbib` | options `numbers,sort&compress`, `\citep` |
| bibliography | main.tex:73-74; references.bib:1-18 | `bib.bibtex-bst` | style `abbrvnat`, database `references` (BibTeX run; two entries) |
| PDF metadata and links | main.tex:9, 36-40 | `meta.hyperref` | `bookmarks,bookmarksnumbered,pdfborder={0 0 0}`; `\hypersetup{pdftitle,pdfauthor,pdfkeywords}` |
| autoref names and refs | main.tex:11-12; chapters/introduction.tex:17, 19; chapters/evaluation.tex:6, 26 | `xref.hyperref` | `\autoref`; `\chapterautorefname`="Chapter", `\sectionautorefname`="Section" |
| labels | chapters/introduction.tex:2; chapters/evaluation.tex:2, 12, 33 | `xref.kernel` | `\label` |
| file inclusion | main.tex:14, 47-69; chapters/*.tex | `struct.input` | `\input{macros}`, `\include{chapters/...}` (macros.tex holds only a comment, macros.tex:1) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\@addto` token-list accumulator | ubcdiss.cls:42-47 | yes | used only to collect repeated committee lines and previous degrees (cls:214, 285, 288); the emitter writes each collected line into the page body directly (`\par\medskip\noindent <name>\\\emph{<role>}`), so no macro is copied; the helper computes no layout, it only concatenates content |
| option plumbing (`DeclareOption`, `PassOptionsToClass`, `ExecuteOptions`, `ProcessOptions`, `ubcdiss.cfg` hook) | ubcdiss.cls:51-89 | yes | resolved at emit time to `class.book` options (letterpaper, 11pt, oneside) and one `\onehalfspacing`; no `ubcdiss.cfg` is shipped, so the hook does nothing here |
| `\textspacing` alias | ubcdiss.cls:69-78; main.tex:62 | yes | alias of `\onehalfspacing` (`sp.setspace`) |
| `balanced` margins (unused option) | ubcdiss.cls:51-52, 94-99 | yes | `page.setlength` assignments with `calc` expressions; the sample does not select it |
| gpscopy contents block | ubcdiss.cls:106-164 | yes | `toc.etoc` (`tocbibind`), `toc.tocloft` keys and lengths, `toc.kernel` `\contentsname`, `sp.lengths` (`\newlength`, `\settowidth`, `\addtolength` are kernel length commands) |
| field defaults with `\ClassError` and field setters | ubcdiss.cls:187-222 | yes | author-facing validation and aliases; the emitter always supplies every field and substitutes the strings inline |
| compatibility stubs (`\institutionaddress`, `\submitdate`, `\advisor`, `\advisortitle`, `\date`, `\iffogscopy`, `fogscopy`) | ubcdiss.cls:60-64, 225-237 | yes | only `\ClassWarning` messages and aliases; no printed effect |
| `\maketitle` redefinition with `\ifx...\empty` field tests and `\frontmatter` lock | ubcdiss.cls:239-281 | yes | flattened to `\frontmatter`, `\pagestyle{empty}`, a literal `titlepage` body (`front.titlepage-env`), `\setcounter{page}{2}`, `\pagestyle{plain}`; the subtitle and previous-degree branches are decided at emit time (sample has no subtitle, one previous degree); the `\frontmatter` error guard (cls:279-280) prints nothing and the emitter simply never writes a second `\frontmatter` |
| `\makecommitteepage` and committee macros | ubcdiss.cls:283-312 | yes | literal page body in a `singlespace` environment ending in `\cleardoublepage` (`front.dedication`, `sp.setspace`, `sp.manual-space`, `mark.kernel`, `pg.break`); the department-or-faculty test (cls:302) is resolved at emit time |
| unused `ifthen` load | ubcdiss.cls:39 | yes | no `\ifthenelse` or `\setboolean` appears anywhere in the zip; dropped |
| `macros.tex` | macros.tex:1; main.tex:14 | yes | comment only; `struct.input` of an empty file |

## Content-opaque
none (the figure body is a `\rule` placeholder at chapters/evaluation.tex:31, which `sp.rule` can hold; table cell text and citation text are content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
