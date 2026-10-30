yes

# 0500-yathesis: yathesis (French doctoral thesis class, sample thesis)

- Unverified: read from the source, not compiled.
- Source: Source/0500-yathesis/ (origin: https://latextemplates.com/downloads/yathesis.zip; licence: LPPL-1.3c)
- Kind: thesis
- Lib: v4
- Engine: pdfLaTeX-compatible (the sample's own preamble uses T1 `fontenc` and utf8 `inputenc`, main.tex:3-4; the class's own engine requirement is not stated on its CTAN page and its source was not read)
- Look carried by: class (`\documentclass{yathesis}` at main.tex:1; the zip adds only class-native metadata commands, content, `booktabs`, `natbib`)
- Class origin: tex-distribution-unbundled (`yathesis` is on CTAN, Denis Bitouzé, LPPL 1.3c, a class based on `book`, read at ctan.org/pkg/yathesis; `yathesis.cls` is not in the zip)
- Main file: main.tex (other samples: none; chapters/related-work.tex and chapters/evaluation.tex are `\input` fragments of it, not separate samples)
- Read: main yes, zip-local classes and styles none present (the zip holds no .cls, .sty, .def, .cfg, .clo, .bst; the published class source was not read)

## Verdict
yes. The zip is four files: a main sample, two `\input` chapter fragments and a `.bib`. It defines no macro, environment, counter or style of its own (no `\newcommand`, `\def`, `\renewcommand` in any file). Its whole look is carried by the published CTAN class `yathesis`, loaded unchanged at main.tex:1, so it is one class way plus the class's native vocabulary; the rest is `booktabs`, `natbib` with a `.bst`, and kernel table, figure and sectioning commands. Caveat: because `yathesis.cls` was not read, what the class loads and sets internally is taken on trust from the rubric's rule for a published class that is not bundled; the sample cannot show it.

## Blockers
none

## Class setting
- Class: `class.yathesis` options: none passed (`\documentclass{yathesis}`, main.tex:1). The CTAN page states it is based on `book` and works with optional `biblatex` and `glossaries`; the sample uses neither (it loads `natbib`, main.tex:6).
- Class-native vocabulary used (source not read, signatures as written in the sample; every optional first argument is passed empty `[]` and its meaning was not read):
  - Title-page data: `\author[]{first}{last}` (main.tex:8), `\title[]{..}` (main.tex:9), `\academicfield[]{..}` (main.tex:10), `\speciality[]{..}` (main.tex:11), `\date{d}{m}{y}` (main.tex:12), `\institute[]{..}` (main.tex:13), `\doctoralschool[]{..}` (main.tex:14), `\laboratory[]{name}{address lines}` (main.tex:15-20), `\supervisor[]{first}{last}` (main.tex:21), `\referee[]{first}{last}` twice (main.tex:22-23), `\committeepresident[]{first}{last}` (main.tex:24), `\examiner[]{first}{last}` (main.tex:25), `\keywords{french list}{english list}` (main.tex:26).
  - Front-matter commands: `\maketitle` (main.tex:30), `\makekeywords` (main.tex:32), two `abstract` environments one after the other then `\makeabstract` (main.tex:34-44), `\tableofcontents[depth=chapter,name=Sommaire]` (main.tex:46), `\mainmatter` (main.tex:50, book vocabulary).
  - Kernel chapter commands under the class: `\chapter`, `\chapter*`, `\section`, `\addcontentsline` (main.tex:52-53, 63-64).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.yathesis` | no options; book-based (CTAN) |
| page geometry | main.tex:1 | `page.class-options` | no option passed; page size and margins are the class's defaults (not read) |
| default text face and language handling | main.tex:1, main.tex:46 | `class.yathesis` | class defaults, not read; the sample loads no `babel`, `polyglossia`, `fontspec`; `name=Sommaire` renames the contents title |
| font and input encoding | main.tex:3-4 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}`, `\usepackage[utf8]{inputenc}` |
| header and footer, running heads | main.tex:1 | `hf.class-native` | class defaults, no command in the sample sets them |
| title page and thesis metadata | main.tex:8-25, 30 | `front.class-native` | `\author` `\title` `\academicfield` `\speciality` `\date{d}{m}{y}` `\institute` `\doctoralschool` `\laboratory` `\supervisor` `\referee` `\committeepresident` `\examiner`, then `\maketitle`; values are strings, a date triple and names |
| keywords | main.tex:26, 32 | `abs.keywords` | `\keywords{fr}{en}` then `\makekeywords` (class commands) |
| abstracts, two languages | main.tex:34-44 | `abs.class-native` | two `abstract` environments, then `\makeabstract` |
| contents lists | main.tex:46-48 | `toc.kernel` | `\tableofcontents`, `\listoftables`, `\listoffigures` |
| contents options of the class | main.tex:46 | `front.class-native` | optional keys `depth=chapter`, `name=Sommaire` (the kernel `\tableofcontents` takes no optional argument, so the keys come from the class or a package it loads; source not read) |
| front and main matter switch | main.tex:50 | `class.yathesis` | `\mainmatter` (book vocabulary) |
| chapter and section looks | chapters/evaluation.tex:1, 4, 25, 37; chapters/related-work.tex:1, 4, 11 | `head.class-native` | `\chapter{..}`, `\section{..}`, no option passed; looks are the class's defaults |
| unnumbered chapters with contents entry | main.tex:52-53, 63-64 | `head.kernel` | `\chapter*{Introduction}` and `\chapter*{Conclusion}` each followed by `\addcontentsline{toc}{chapter}{..}` (the contents entry itself is `toc.kernel`) |
| file inclusion | main.tex:60-61 | `struct.input` | `\input{chapters/related-work}`, `\input{chapters/evaluation}` |
| cross-references | chapters/evaluation.tex:2, 7, 13, 27, 34; chapters/related-work.tex:2 | `xref.kernel` | `\label{ch:..}` `\label{tab:..}` `\label{fig:..}`, `\ref` with `~` before it |
| table float | chapters/evaluation.tex:10-12 | `tbl.tabular` | `table[htbp]`, `\centering`, caption above the table |
| table body | chapters/evaluation.tex:14-22 | `tbl.tabular` | `tabular` with column spec `@{}lrr@{}` |
| table rules | main.tex:5; chapters/evaluation.tex:15, 17, 21 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| caption | chapters/evaluation.tex:12, 33 | `cap.kernel` | kernel `\caption`, no `caption` package loaded; look is the class's |
| figure float | chapters/evaluation.tex:30-34 | `fig.graphicx` | `figure[htbp]`, `\centering`, caption below; the float is kernel, no `\includegraphics` appears |
| figure body placeholder | chapters/evaluation.tex:32 | `sp.rule` | `\rule{0.6\textwidth}{4cm}` (a blank box standing in for artwork) |
| centring | chapters/evaluation.tex:11, 31 | `sp.ragged` | `\centering` inside the two floats |
| citations | main.tex:6, 57, 68; chapters/related-work.tex:7 | `bib.natbib` | `\usepackage{natbib}` with no option, `\citep{key}` |
| bibliography | main.tex:70-71; references.bib:1, 12 | `bib.bibtex-bst` | `\bibliographystyle{plainnat}`, `\bibliography{references}` (the `.bst` is a parameter; two entries, an `article` and an `inproceedings`, are content) |

Components the sample does not use and that therefore need no way: lists, quotes, notes, footnotes, mathematics, theorem-like statements, code, boxes, colour, backgrounds, index, appendix.

## Bespoke code
none. No `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter` or conditional appears in main.tex, chapters/evaluation.tex or chapters/related-work.tex, and the zip holds no `.cls` or `.sty`. The `\\` line breaks inside the `\laboratory` address argument (main.tex:16-19) are content of a class-native argument.

## Content-opaque
none (the figure holds only a `\rule` placeholder, chapters/evaluation.tex:32, mapped to `sp.rule`; the `.bib` entries are content).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- `class.yathesis` is a class way, written plainly as the rubric requires; the vocabulary the sample uses is recorded above under "Class setting".
