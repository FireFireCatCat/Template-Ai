yes

# 0639-scientific-style-book-template: Scientific Style Book Template

- Unverified: read from the source, not compiled.
- Source: Source/0639-scientific-style-book-template/ (origin: https://latextemplates.com/downloads/scientific-style-book-template.zip, packaged from the Overleaf template by Jue Xu named at ATTRIBUTION.txt:1-4; licence: CC-BY-4.0, ATTRIBUTION.txt:3)
- Kind: book
- Lib: v5
- Engine: pdfLaTeX-compatible (README.md:5 says to compile with pdfLaTeX; every package loaded is a pdfTeX package)
- Look carried by: preamble (kernel `book` class loaded unchanged; the look is the packages, one `\definecolor` and the `\newtheorem` calls in main.tex:2-15, plus a hand-laid `titlepage` at main.tex:17-26)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip is three files: `main.tex` (82 lines), `README.md` and `ATTRIBUTION.txt`. It has no zip-local `.cls`, `.sty` or other style file. The class is the kernel `book` class (source not read, it ships with the TeX distribution). Every preamble line is a published package with options, a `\definecolor` or a `\newtheorem`. The only bespoke item is the alias `\vect`, which is a reducible `\newcommand` and is never used in the body. The title page is built from kernel spacing, font, colour and `\rule` commands, with no TikZ or `picture` artwork, so there is no ART blocker.

## Blockers
none

## Class setting
- Class: `class.book` options: `11pt`, `twoside` (main.tex:1); the source of the class was not read (kernel class, not bundled in the zip)
- Class-native vocabulary used: `\frontmatter` (main.tex:27), `\mainmatter` (main.tex:33), `\backmatter` (main.tex:75), `\chapter` and `\chapter*` (main.tex:28, 34, 43, 70, 77, 80), `titlepage` environment (main.tex:17-26), `\tableofcontents` (main.tex:32), `\appendix` (main.tex:76), `[chapter]` as the counter name for `\newtheorem` (main.tex:13)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.book` | 11pt, twoside |
| paper size and base font size | main.tex:1 | `page.class-options` | `11pt`, `twoside` (paper size left to the class default) |
| font encoding and input | main.tex:2-3 | `font.fontenc-t1` | `fontenc` option `T1`; `inputenc` option `utf8` |
| text font | main.tex:4 | `font.libertine` | `\usepackage{libertine}`, no options (text face only; maths stays Computer Modern) |
| page geometry | main.tex:5 | `page.geometry` | `margin=1in` |
| maths packages | main.tex:6 | `math.amsmath` | `amsmath` loaded, no options; the body holds no display equation |
| maths symbols | main.tex:6 | `math.amssymb` | `amssymb` loaded, no options |
| maths tools | main.tex:6 | `math.mathtools` | `mathtools` loaded, no options |
| table rules | main.tex:7, 64, 66 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| list package | main.tex:8, 45 | `list.enumitem` | `enumerate` with `[label=\arabic*.]` |
| colour package | main.tex:9 | `color.xcolor` | `xcolor` loaded, no options |
| colour definition | main.tex:12 | `color.xcolor` | `\definecolor{scigreen}{HTML}{356859}` |
| links and PDF options | main.tex:10 | `meta.hyperref` | `hidelinks` |
| smart cross-references | main.tex:11, 41 | `xref.cleveref` | `nameinlink`, `capitalise`; body `\cref{ch:methods}` |
| plain cross-references | main.tex:34, 43, 50, 62, 69 | `xref.kernel` | `\label{ch:questions}`, `\label{ch:methods}`, `\label{thm:estimate}`, `\label{tab:measurements}`, `Table~\ref{tab:measurements}` |
| theorem and definition setup | main.tex:13-14 | `thm.amsthm` | `\newtheorem{theorem}{Theorem}[chapter]`; `\newtheorem{definition}[theorem]{Definition}` (shared counter; no `\theoremstyle`, so the default plain style) |
| definition block | main.tex:36-39 | `thm.amsthm` | `definition` environment, no optional argument |
| theorem block | main.tex:50-53 | `thm.amsthm` | `theorem` environment with optional note `[A transparent estimate]` and a label |
| proof block | main.tex:54-58 | `thm.amsthm` | `proof` environment (provided by amsthm), end-of-proof mark from the package default |
| bold-math alias | main.tex:15 | `math.amsmath` | `\newcommand{\vect}[1]{\boldsymbol{#1}}`: `\boldsymbol` is amsmath's; never called in the body |
| cover page | main.tex:17-26 | `front.titlepage-env` | `titlepage` environment, hand-laid with the rows below |
| cover alignment | main.tex:18 | `sp.ragged` | `\centering` |
| cover vertical spacing | main.tex:19, 21, 22, 23, 24, 25 | `sp.manual-space` | `\vspace*{0.85in}`, `\vspace{15pt}`, `\vspace{20pt}`, `\vfill`, `\vspace{6pt}`, `\vspace{0.5in}` |
| cover font sizes | main.tex:20, 21, 24, 25 | `font.size-commands` | `\Huge`, `\Large`, `\large`, `\small` |
| cover bold title | main.tex:20 | `mark.kernel` | `\bfseries` |
| cover coloured rule | main.tex:22 | `sp.rule` | `\rule{0.72\textwidth}{2pt}`, colour by `\textcolor{scigreen}{...}` (`color.xcolor`) |
| cover version line | main.tex:25 | `front.titlepage-env` | text "Version 1.0", `\textbullet{}` symbol and `\the\year` (kernel number primitive that prints the compile year; content, as `\today` would be; no counter or conditional drives layout) |
| front and back matter switching | main.tex:27, 33, 75 | `class.book` | `\frontmatter`, `\mainmatter`, `\backmatter` (class-native: roman page numbers then arabic; chapters unnumbered after `\backmatter`) |
| unnumbered chapters | main.tex:28, 80 | `head.kernel` | `\chapter*{Overview}`, `\chapter*{Acknowledgements}` |
| numbered chapters and sections | main.tex:34-35, 43-44, 59, 70-71 | `head.kernel` | `\chapter`, `\section`, no `\renewcommand` of format or counters |
| table of contents | main.tex:32 | `toc.kernel` | `\tableofcontents` placed after the Overview chapter, inside `\frontmatter` |
| lists | main.tex:45-49 | `list.kernel` | `enumerate` with three `\item` (labels through `list.enumitem`) |
| table float | main.tex:60-68 | `tbl.tabular` | `table[ht]` float, `tabular{lrrr}` with a header row and three data rows |
| table centring | main.tex:61 | `sp.ragged` | `\centering` inside the float |
| table caption | main.tex:62 | `cap.kernel` | `\caption{Illustrative measurements}` above the tabular, then `\label`; no `caption` package |
| appendix | main.tex:76-77 | `num.appendix` | `\appendix` followed by `\chapter{Notation and conventions}`; `\backmatter` (main.tex:75) comes before `\appendix`, so by the usual `book` behaviour (class source not read) that chapter prints unnumbered; an emitter keeps the same order |
| running heads and page numbers | none set in main.tex (a Grep for `\pagestyle` finds no call in the zip) | `hf.class-native` | no `\pagestyle` or `\pagenumbering` call; the class defaults apply (source of the class not read); the roman and arabic page numbers come from `\frontmatter` and `\mainmatter` (main.tex:27, 33), listed under `class.book` above |
| language | none set in main.tex | none | no `babel`; the class default English names |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\vect` alias | main.tex:15 | yes | `\newcommand` alias of amsmath's `\boldsymbol{#1}` (`math.amsmath`); not called anywhere in the body, so an emitter may omit it or inline `\boldsymbol` |
| `scigreen` colour | main.tex:12 | yes | `\definecolor` with the `HTML` model (`color.xcolor`) |
| theorem and definition environments | main.tex:13-14 | yes | `\newtheorem` calls with a within-counter and a shared counter (`thm.amsthm`) |

No zip-local `.cls`, `.sty`, `.def`, `.cfg` or `.clo` exists. There is no `\def`, no counter or conditional of the sample's own, and no expl3 or Lua code. `README.md` and `ATTRIBUTION.txt` are plain description and licence text; nothing in the zip is addressed to an AI.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
