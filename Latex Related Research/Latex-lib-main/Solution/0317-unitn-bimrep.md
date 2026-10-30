yes

# 0317-unitn-bimrep: University of Trento bimonthly report (unitn-bimrep)

- Unverified: read from the source, not compiled.
- Source: Source/0317-unitn-bimrep/ (origin: https://mirrors.ctan.org/macros/latex/contrib/unitn-bimrep.zip; licence: MIT, LICENSE.md:1-3)
- Kind: report (a fixed one-page-form progress report for PhD students: header block, then research, courses, publications)
- Lib: v3
- Engine: pdfLaTeX-compatible (babel, T1 fontenc, libertine, geometry, framed, biblatex with the default biber backend; JPEG logo)
- Look carried by: class (the sample only sets author, title, advisor, cycle and fills three class environments; everything visible is in unitn-bimrep.cls)
- Class origin: ctan (ctan.org/pkg/unitn-bimrep, MIT, path /macros/latex/contrib/unitn-bimrep, read once; the zip is the CTAN contrib zip)
- Main file: examples/example.tex (other samples: examples/example_bib.tex, option `bib` with biblatex)
- Read: main yes, zip-local classes and styles all (the only class file, unitn-bimrep.cls, 228 lines, read in full; examples/example_bib.tex and example_bib.bib read in full)

## Verdict
The look is carried entirely by a published CTAN class, `class.unitn-bimrep`, and the samples add only metadata strings and class-environment content, so the pilot ruling for class-carried zips applies. Reading the class anyway: its page, font, language, frame, rule, list and bibliography settings all map to lib ways, and the only non-trivial code (the `TNenvflag` order checker, the three-argument `\item` redefinition, the `\@noitemerr` switch, the auto `\maketitle`) either prints nothing (error checks) or composes lib ways with literal strings. No ART, no external tool.

## Blockers
none

## Class setting
- Class: `class.unitn-bimrep` options: `bib` (unitn-bimrep.cls:6, used at examples/example_bib.tex:1); every other option is passed on, nothing else is declared (cls:7). The class loads kernel `report` with `a4paper,12pt` (cls:9), so `class.report` is its base.
- Class-native vocabulary used: preamble `\author` `\title` (kernel storage, cls:11-12), `\advisor{}` and `\cycle{}` (cls:43-44, examples/example.tex:3-6); the header block prints by itself at `\begin{document}` (cls:98-100); body environments, in this fixed order, `research` or `research*` (cls:119, 134), `school` or `school*` (cls:145, 168), `production` or `production*` (cls:185, 209); inside `school` and `production` a three-argument `\item{a}{b}{c}` (cls:160, 200; examples/example.tex:16, 20); with option `bib`: `\addbibresource`, `\nocite`, `\printbibliography` (examples/example_bib.tex:3, 22-23; cls:35-36).

## Component map
Rows marked (class) are set inside the published class, not by the sample.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | examples/example.tex:1; examples/example_bib.tex:1 | `class.unitn-bimrep` | option `bib` or none |
| base class (class) | unitn-bimrep.cls:9 | `class.report` | `a4paper,12pt` |
| paper size (class) | unitn-bimrep.cls:9 | `page.class-options` | a4paper, 12pt |
| page geometry (class) | unitn-bimrep.cls:20-28 | `page.geometry` | a4paper, top=1cm, bottom=1cm, left=1.4cm, right=1.4cm, marginparwidth=0pt, headheight=0pt, footskip=0pt |
| page numbers (class) | unitn-bimrep.cls:40 | `pgnum.pagenumbering` | `\pagenumbering{gobble}` (kernel `\@gobble` style, prints no number; report default page style `plain` stays) |
| language (class) | unitn-bimrep.cls:18 | `lang.babel` | english |
| encoding (class) | unitn-bimrep.cls:19 | `font.fontenc-t1` | T1 |
| text font (class) | unitn-bimrep.cls:31 | `font.libertine` | `libertine` package, no options |
| header block (class) | unitn-bimrep.cls:77-95, 98-100 | `front.class-native` | `\maketitle` is redefined and run automatically at `\begin{document}`; fixed school name and deadline text, then a framed row with Student Name, Cycle/Year, Thesis, Supervisor, Date |
| header block layout (class) | unitn-bimrep.cls:79-87 | `tbl.tabular` | one `{c}` column inside a `centering` group; `\\` rows, `\vspace{0.3cm}`, `\hspace{\linewidth}` |
| centred group (class) | unitn-bimrep.cls:79 | `sp.ragged` | `\begin{centering}` |
| logo (class) | unitn-bimrep.cls:81 | `fig.graphicx` | `\includegraphics[scale=0.5]{unitn-bimrep.jpg}` (JPEG shipped in the zip, README.md:8-9) |
| header box and whole-page frame (class) | unitn-bimrep.cls:32, 89-94, 98-109 | `box.mdframed` | `framed` environment, default rule; one around the header fields, one opened by `\AtBeginDocument` (cls:101) and closed by `\AtEndDocument` (cls:109) around the whole body |
| header field fonts (class) | unitn-bimrep.cls:82-93 | `mark.kernel` | `\textsc`, `\bfseries`, `\textit`, `\textbf`; `\hfill` in the field rows |
| header field spacing (class) | unitn-bimrep.cls:84-86, 91-93 | `sp.manual-space` | `\vspace{0.3cm}`, `\hspace{\linewidth}`, `\hfill`, `\\` |
| date (class) | unitn-bimrep.cls:93 | `front.maketitle` | kernel `\today` in the Date field (not the `datetime` package) |
| section headings (class) | unitn-bimrep.cls:127, 142, 161, 182, 201, 223 | `font.size-commands` | `\noindent{\large\textbf{...}}` as a hand-set heading, no `\section` |
| heading bold (class) | unitn-bimrep.cls:127, 161, 201 | `mark.kernel` | `\textbf` |
| divider rule (class) | unitn-bimrep.cls:45, 161, 182, 201, 223 | `sp.rule` | `\noindent\makebox[\linewidth]{\rule{\linewidth}{0.4pt}}` then `\vspace{0.2cm}` |
| heading and block spacing (class) | unitn-bimrep.cls:161, 182, 201, 206, 223, 226 | `sp.manual-space` | `\vspace{0.2cm}` |
| research section | cls:119-143; examples/example.tex:10-13 | `front.class-native` | `research` (bullets) or `research*` (paragraph, a trailing `\\`) |
| school section | cls:145-183; examples/example.tex:15-17 | `front.class-native` | `school` or `school*`; item text `\emph{#1}, #2 (#3)` (cls:160) |
| production section | cls:185-227; examples/example.tex:19-21 | `front.class-native` | `production` or `production*`; item text `{\small#1}:\\ \emph{#2}\\ {\small#3}` (cls:200) |
| bullet lists (class) | unitn-bimrep.cls:115-117, 128, 162, 202 | `list.kernel` | `itemize` wrapped in `TN may be empty itemize` |
| item font sizes (class) | unitn-bimrep.cls:200 | `font.size-commands` | `\small` on the authors and the venue lines |
| array package (class) | unitn-bimrep.cls:30 | `tbl.tabular` | `array` loaded beside the kernel tabular used in the header block |
| bibliography (class, option `bib`) | unitn-bimrep.cls:33-37; examples/example_bib.tex:3, 22-23 | `bib.biblatex-biber` | `refsection=none`, `style=ieee`, `indexing=false`; `\printbibliography` re-defined to pass `heading=none`; `.bib` read by `\addbibresource{example_bib.bib}` |
| citations without cite (sample) | examples/example_bib.tex:22 | `bib.biblatex-biber` | `\nocite{ref:1,ref:2}` |
| order and presence checks (class) | unitn-bimrep.cls:16, 47-59, 103-108, 120-126 | `num.counters` | counter `TNenvflag` and `\ClassError` calls only; no typeset output (see Bespoke code) |
| cross-references, numbering, floats, maths, theorems, code, index | none in the class or the samples | n/a | not used |

## Bespoke code
All items below sit inside a class that is published on CTAN (W1), so by the rubric they are part of the way `class.unitn-bimrep`, not zip-local bespoke code. They are listed, and given a reduction, so the question can be re-read if the class were counted as zip-local.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `TNenvflag` counter, `\@TNcheckvariables`, `\@TNcheckenvs`, end-of-document check, environment-order `\ClassError`s | unitn-bimrep.cls:16, 47-73, 103-108, 119-227 | yes | Only raises errors on a wrong order or a missing field; it prints nothing. An emitter writes the sections in order, so the checks are dropped. `\@TNcheckenvs` (cls:60) is never called anywhere in the file (grep: no other use of the name). |
| redefined `\maketitle` with fixed text, auto-called by `\AtBeginDocument` | cls:77-100 | yes | A body block: `tbl.tabular` with `fig.graphicx` logo and `mark.kernel` lines, then a `box.mdframed` with the four fields; literal strings. |
| whole-body `framed` opened and closed in the begin/end-document hooks | cls:98-109 | yes | A `box.mdframed` (`framed`) wrapper around the body content. |
| three-argument `\item` redefinition inside `school` and `production` | cls:159-160, 199-200 | yes | Local `\renewcommand{\item}[3]` that only composes `\item` with `mark.kernel` (`\emph`) and `font.size-commands` (`\small`); an emitter writes the item text directly. |
| `TN may be empty itemize` (`\@noitemerr` switched off and on) | cls:112-117 | yes | Only silences the kernel's "empty list" error so a section can have no items; an emitter omits an empty list. It does not change printed output otherwise. |
| `\@TNhlinenew` rule macro | cls:45 | yes | `sp.rule`: `\rule{\linewidth}{0.4pt}` in a full-width `\makebox`. |
| `\advisor`, `\cycle`, `\let\@author\@empty` slots | cls:11-14, 43-44 | yes | `\def` string slots printed in the header; these are the class's own metadata commands (`front.class-native`). |
| `\pagenumbering{gobble}` | cls:40 | yes | Kernel `pgnum.pagenumbering` with the kernel's `\@gobble`; the same effect as an empty page number. |

## Content-opaque
none. (The JPEG logo `unitn-bimrep.jpg` is an image the class includes, not a drawing; it is a shipped asset that must sit next to the main file, README.md:8-9. Nothing is drawn with TikZ, PGF, PSTricks or `picture`.)

## Lib changes
- New ways proposed: none. (`class.unitn-bimrep` is a class way and needs no proposal; its native vocabulary is recorded under "Class setting".)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
