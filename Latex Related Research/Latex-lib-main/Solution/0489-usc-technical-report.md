yes

# 0489-usc-technical-report: USC Technical Report

- Unverified: read from the source, not compiled.
- Source: Source/0489-usc-technical-report/ (origin: https://latextemplates.com/downloads/techreport.zip; licence: not established (manifest says UNKNOWN; ctan.org/pkg/techreport states none; README.md:9-11 warns of it))
- Kind: report
- Lib: v4
- Engine: pdfLaTeX-compatible (`fontenc` T1, `lmodern`, `booktabs`, `hyperref`; nothing in the sample needs XeLaTeX or LuaLaTeX)
- Look carried by: mixed (kernel `report` defaults carry chapters and page; the sample preamble sets fonts, `booktabs`, `hyperref`; the title page is hand-laid in the body; `techreport.sty` is loaded and called but prints nothing in this sample)
- Class origin: tex-distribution-unbundled (`report`; the style `techreport.sty` is a separate published CTAN file, see Verdict)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (`techreport.sty`, the only style; `report`'s own source not read)

## Verdict
yes, and the answer rests on one ruling: `techreport.sty` is published (W1). ctan.org/pkg/techreport (one read) lists it as `macros/latex209/contrib/misc/techreport.sty`, version 1.7, maintainer Steven Douglas Cochran, "style option for the USC Thesis style"; the zip's file carries the same header and version (techreport.sty:1-9). So it is not zip-local bespoke code, and an emitter loads it with `\usepackage{techreport}`. The sample uses only its three string setters, which store text that is never printed, and its `\chapter` redefinition (techreport.sty:364-379), which in this oneside sample is expected to act as report's own `\chapter` (report.cls was not read, so this is from the style's code only). Everything the page shows is `report` defaults, a hand-laid `titlepage`, a `booktabs` table, `hyperref` and `lmodern`, all lib ways. No artwork and no tool outside TeX. Risk, stated plainly: the style's own title page, preface and spine code needs the USCthesis class that this zip does not ship, and it contains a hand-rolled conditional (see Bespoke code); if a reviewer ruled the style zip-local, that code would be the thing to re-judge.

## Blockers
none

## Class setting
- Class: `class.report` options: `a4paper`, `11pt` (main.tex:1); no `twoside`, no `openright`, so the defaults are oneside, openany.
- Class-like style: `class.techreport` (a thesis-style option for one institution's thesis class; the lib's v3 log files such styles under a class way, as `class.unswcover`). No options (techreport.sty has no `\DeclareOption`, `\ProvidesPackage` or `\ProcessOptions`, it is a LaTeX 2.09 style).
- Class-native vocabulary used: from `report`: `\chapter` (main.tex:29,36,54), `titlepage` environment (main.tex:16-27), `table` float and `\caption` (main.tex:40-52). From `techreport`: `\reportnumber` (main.tex:11), `\address` (main.tex:12), `\acknowledgment` (main.tex:13). Defined by the style but not used by the sample: `\maketitle`, `\customtitlepage`, `\thecopyright`, `\printspinetrue`, `\preface` and `\endpreface` (techreport.sty:188-189,194-245,247-310,182-183,324-359).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.report` | a4paper, 11pt |
| paper and type size | main.tex:1 | `page.class-options` | a4paper, 11pt; no `geometry` or `\setlength` anywhere, class margins apply |
| USC technical-report style | main.tex:5; techreport.sty:1-9 | `class.techreport` | `\usepackage{techreport}`, no options; CTAN v1.7 |
| report metadata | main.tex:11-13; techreport.sty:163-164,168-177 | `class.techreport` | `\reportnumber{TR-2026-001}`, `\address{Research and Operations Group}`, `\acknowledgment{Prepared as a neutral example...}`; stored in `\gdef` macros, never printed (no `\maketitle` call; the title page repeats the strings by hand at main.tex:23,25) |
| chapter opening | techreport.sty:364-379 | `class.techreport` | `\chapter` redefined: `\clearpage` when the class is oneside (this sample), `\cleardoublepage` in a twoside body; then `\thispagestyle{plain}`, `\secdef\@chapter\@schapter` |
| encoding | main.tex:6 | `font.fontenc-t1` | `fontenc` T1 |
| text font | main.tex:7 | `font.lmodern` | load only |
| title page | main.tex:16-27 | `front.titlepage-env` | `titlepage` environment, hand-laid: type line "TECHNICAL REPORT", title, report number, group name, date, all typed as text |
| title page alignment | main.tex:17 | `sp.ragged` | `\centering` |
| title page spacing | main.tex:18,20,22,24 | `sp.manual-space` | `\vspace*{2cm}`, `\vspace{1.5cm}`, `\vspace{1cm}`, `\vfill` |
| title page sizes | main.tex:19,21,23 | `font.size-commands` | `\Large`, `\huge`, `\large`, each in a group closed by `\par` |
| bold title, monospace word | main.tex:21,31 | `mark.kernel` | `\bfseries`, `\texttt` |
| chapters | main.tex:29,36,54 | `head.kernel` | three `\chapter` with report defaults, numbered, no format change |
| page style | techreport.sty:374 | `hf.pagestyle-kernel` | `\thispagestyle{plain}` on chapter first pages (report's own `\chapter` is expected to set it too, report.cls not read); no `\pagestyle` in the sample |
| table float | main.tex:40-41,43,52 | `tbl.tabular` | `table[ht]`, `\centering`, `tabular{lll}` |
| table rules | main.tex:8,44,46,50 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| caption | main.tex:42 | `cap.kernel` | `\caption` above the tabular, default format |
| hyperlinks | main.tex:9-10 | `meta.hyperref` | `colorlinks=true`, `linkcolor=blue`, `urlcolor=blue` |

Not used by the sample (no row): header and footer setting, columns, spacing changes, colour definitions, abstract, contents lists, lists, quotes, notes, math, theorems, code, boxes, bibliography, index, cross-references.

## Bespoke code
The sample's own preamble and body define nothing (main.tex has only `\usepackage` lines at 5-9 and no `\newcommand`, `\def` or environment). The style is published, so its macros are not counted as bespoke. For completeness, how each item reads if a reviewer disagreed on W1:

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| whole style | techreport.sty:1-379 | n/a, published (CTAN) | loaded unchanged as `class.techreport`; the sample's effect from it is nil beyond the `\chapter` equivalence above |
| `\TechTitleSize`, `\TechRegularSize` | techreport.sty:157-158 | yes (contingent) | `\@setsize` is LaTeX 2.09 only; the intent is `font.size-commands` (`\fontsize{..}{25pt}\selectfont`, `\fontsize{..}{18pt}\selectfont`); never expanded in the sample |
| `\reportnumber`, `\address` | techreport.sty:163-164,176-177 | yes (contingent) | string aliases, inline the text |
| `\acknowledgment` | techreport.sty:168-174 | yes (contingent) | `sp.rule` (`\hrule width 2.5in`), `sp.manual-space` (`\vskip 3pt`), `box.minipage` (`\parbox{\textwidth}`), `font.size-commands` (`\footnotesize`), `math.kernel` (`$^{1}$`) |
| `\maketitle`, `\customtitlepage`, `\thecopyright` | techreport.sty:188-189,194-245,247-310 | form yes, content no (contingent) | static hand-laid `titlepage` (`front.titlepage-env`, `sp.manual-space` with `fil` glue, `box.minipage` for `\vbox to`/`\hbox to`, `page.setlength` for the `\evensidemargin` shift at 250,279); but they read `\@university`, `\@schoolname`, `\@majorfield`, `\@submitdate`, `\@volume`, `\ifthesis`, `\ifcopyright` and others (techreport.sty:205-236) that neither the style nor the sample defines, so this zip carries nothing to recover |
| spine page `\ifprintspine` | techreport.sty:182-183,281-306 | yes, off by default (contingent) | rotated text box via legacy `rotate.sty` `\rotr`, which is not shipped (techreport.sty:148-150); a `fig.rotating` `\rotatebox` is the nearest way; the sample never sets `\printspinetrue` |
| `\preface`, `\endpreface`, `\chapter` flag `\if@twosidebody` | techreport.sty:318-379 | not clearly (contingent; the one item that would put the verdict at risk) | `\pagenumbering`, `\pagestyle`, `\addtocontents` are lib ways (`pgnum.pagenumbering`, `hf.pagestyle-kernel`, `toc.kernel`), but the global flag switches the chapter opening between `\cleardoublepage` and `\clearpage` mid-document, a hand-rolled conditional that drives printing; it would reduce only by writing explicit `pg.break` before each chapter. Not used by the sample |

## Content-opaque
none

## Lib changes
- New ways proposed: none (`class.techreport` is a class-like way, written plainly as the rubric asks; considered: a separate front-matter way for `techreport`, rejected because the lib's v3 log already folds one-institution thesis styles into a class way)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
