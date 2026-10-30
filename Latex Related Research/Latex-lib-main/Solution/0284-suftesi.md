yes

# 0284-suftesi: suftesi (thesis sample on the published `suftesi` class)

- Unverified: read from the source, not compiled.
- Source: Source/0284-suftesi/ (origin: https://latextemplates.com/downloads/suftesi.zip; licence: LPPL-1.3)
- Kind: thesis
- Lib: v3
- Engine: pdfLaTeX-compatible (the sample loads `fontenc` T1 and `inputenc` utf8, main.tex:3-4; suftesi's own engine needs were not read, see Verdict)
- Look carried by: class (the zip adds no class or style file and no macro; the preamble only adds `fontenc`/`inputenc`, `booktabs` and `natbib`, main.tex:3-6; headings, title, contents and page set-up are `suftesi` defaults)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; it `\input`s chapters/introduction.tex and chapters/evaluation.tex, main.tex:24-25)
- Read: main yes, zip-local classes and styles none present

## Verdict
The whole zip is four files: `main.tex`, two chapter files and `references.bib`. There is no `.cls`, `.sty` or any `\newcommand`, `\def` or environment definition (grep over all four files found none), so no bespoke code and no artwork. The look is carried by the published class `suftesi` (CTAN, version 3.2.6, LPPL 1.3, in TeX Live and MiKTeX; read on ctan.org/pkg/suftesi) which is not bundled, so its source was not read; the sample sets only the options `a4paper,twoside` (main.tex:1) and uses no suftesi-specific command. Everything else is kernel sectioning, `enumerate`, a `booktabs` table, a float with `\caption`, and `natbib` with BibTeX `plainnat`, all in the lib. The `yes` rests on the rubric's rule that a published class not bundled in the zip is one way (`class.suftesi`) and its source is declared unread; what `suftesi` does inside (heading looks, running heads, whether `abstract` is its own environment) is therefore not checked.

## Blockers
none

## Class setting
- Class: `class.suftesi` options: `a4paper`, `twoside` (main.tex:1). The class's profile (not read): "a document class for typesetting theses, books and articles", originally for the humanities (ctan.org/pkg/suftesi; author Ivan Valbusa).
- Class-native vocabulary used: `\chapter` and `\section` (chapters/introduction.tex:1,4; chapters/evaluation.tex:1,4), `\maketitle` with `\title` `\author` `\date` (main.tex:8-10,14), the `abstract` environment (main.tex:16-20), `\tableofcontents` (main.tex:22). All are standard book-family command names; no suftesi-only command or option appears in the sample.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.suftesi` | a4paper, twoside |
| paper size, sides | main.tex:1 | `page.class-options` | a4paper, twoside (margins and text block are suftesi defaults, nothing set in the sample) |
| encoding | main.tex:3 | `font.fontenc-t1` | fontenc T1 |
| input encoding | main.tex:4 | `font.fontenc-t1` | inputenc utf8 |
| title block | main.tex:8-10,14 | `front.maketitle` | `\title{Approximate Consensus Under Network Partition}`, `\author{Jane Doe}`, `\date{\today}`, `\maketitle`; the printed title look is suftesi's (unread; `front.class-native` if the class redefines `\maketitle`) |
| abstract | main.tex:16-20 | `abs.kernel` | `abstract` environment, no options (whether suftesi defines it itself, which would make it `abs.class-native`, is unread) |
| table of contents | main.tex:22 | `toc.kernel` | `\tableofcontents`, no options; entry look is the class default |
| chapters and sections | chapters/introduction.tex:1,4,11,22; chapters/evaluation.tex:1,4,24,36 | `head.class-native` | `\chapter` `\section`, no renewcommand or option; heading look is suftesi's own, unread |
| running heads | main.tex:1 | `hf.class-native` | not set by the sample; whatever `suftesi` prints under `twoside` (unread) |
| list | chapters/introduction.tex:15-20 | `list.kernel` | `enumerate`, three `\item`, default labels |
| cross-references | chapters/introduction.tex:2,17,19; chapters/evaluation.tex:2,6,12,26,33 | `xref.kernel` | `\label{ch:..}` `\label{tab:results}` `\label{fig:latency}`, `Table~\ref`, `Figure~\ref` |
| table float | chapters/evaluation.tex:9-22 | `tbl.tabular` | `table[htbp]`, `\centering`, `tabular{@{}lrr@{}}` |
| table rules | main.tex:5; chapters/evaluation.tex:14,16,20 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule`, no package options |
| figure float | chapters/evaluation.tex:29-34 | `fig.graphicx` | `figure[htbp]`, `\centering`; float only, no `\includegraphics` and no `graphicx` loaded in this sample |
| figure placeholder | chapters/evaluation.tex:31 | `sp.rule` | `\rule{0.6\textwidth}{4cm}` standing in for an image |
| captions | chapters/evaluation.tex:11,32 | `cap.kernel` | `\caption` below the figure and above the table as written; look is the class default |
| citations | main.tex:6; chapters/introduction.tex:8,24; chapters/evaluation.tex:40 | `bib.natbib` | `\usepackage{natbib}` (no options), `\citep` |
| bibliography | main.tex:27-28; references.bib:1-18 | `bib.bibtex-bst` | `\bibliographystyle{plainnat}`, `\bibliography{references}`; two entries (`@article`, `@inproceedings`) are content |

Not set by the sample (so no row): fonts beyond encoding, headers and footers, geometry, spacing, colour, language, hyperlinks, footnotes, maths, theorems, code, index, appendix. Where the class prints any of these by default, its source is unread.

## Bespoke code
none (no `.cls`, `.sty`, `\newcommand`, `\def`, environment or counter anywhere in the four files; checked by grep for `newcommand|renewcommand|def|newenvironment|newcounter|makeatletter|RequirePackage`).

## Content-opaque
none (the figure body is a `\rule` placeholder, `sp.rule`, chapters/evaluation.tex:31, not an opaque picture).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
