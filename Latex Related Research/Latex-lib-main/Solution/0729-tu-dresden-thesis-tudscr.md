yes

# 0729-tu-dresden-thesis-tudscr: TU Dresden thesis (tudscr, class `tudscrbook`)

- Unverified: read from the source, not compiled.
- Source: Source/0729-tu-dresden-thesis-tudscr/ (origin: https://latextemplates.com/downloads/tudscr.zip; licence: LPPL-1.3c per the manifest, and ctan.org/pkg/tudscr states LPPL 1.3c for the class bundle)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (assumed: the sample has no engine-specific command; the CTAN page for `tudscr` does not state its engines; the class source is not in the zip and was not read)
- Look carried by: class (the zip holds only a sample; every look decision comes from the published class `tudscrbook`, chosen at main.tex:1; the sample adds two packages and field values)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; the chapters `chapters/introduction.tex` and `chapters/evaluation.tex` are `\input` by it, `references.bib` is the database)
- Read: main yes (main.tex, both chapter files and references.bib in full), zip-local classes and styles none present (the zip has 4 files, no `.cls`, `.sty`, `.def`, `.cfg`, `.clo`; the class `tudscrbook` ships with TeX Live and its source was not read)

## Verdict
The zip is a thin sample over the published class `tudscrbook` (bundle `tudscr`, CTAN, TeX Live, LPPL 1.3c, built on KOMA-Script scrbook). It defines no macro, environment, counter, class or style of its own, and draws no artwork; the one drawing-like item is a `\rule` placeholder inside a figure (evaluation.tex:31), which is content held by `sp.rule`. An emitter writes the `\documentclass` line, two `\usepackage` lines, the class's thesis field commands, kernel sectioning, a booktabs table, a figure float, natbib citations and a BibTeX bibliography, all published. This is a class-carried yes: it is evidence about the class dimension, not about the component ways. Everything the class itself does (title page layout, header, fonts, colours, abstract look, heading looks) was not read and is recorded as the class's.

## Blockers
none

## Class setting
- Class: `class.tudscrbook` options: `english`, `thesis` (main.tex:1). Published class, not bundled in the zip (ships with TeX Live as part of `tudscr`; ctan.org/pkg/tudscr read once: wraps `scrbook`, KOMA-Script required, LPPL 1.3c, package list `tudscrsupervisor`, `tudscrfonts`, `fix-tudscrfonts`, `tudscrcomp`). Its source was not read.
- Class-native vocabulary used: `\thesis{master}` (main.tex:6), `\faculty` (main.tex:9), `\department` (main.tex:10), `\graduation` (main.tex:11), `\professor` (main.tex:12), `\referee` (main.tex:13), `\advisor` (main.tex:14), `\maketitle` as the thesis title page (main.tex:19), `abstract` environment (main.tex:21-25), `\tableofcontents` (main.tex:27), `\chapter`/`\section` (chapters/introduction.tex:1,4), `\bibliographystyle`/`\bibliography` (main.tex:32-33). The kernel names `\title` `\author` `\date` (main.tex:7,8,15) are the usual ones.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.tudscrbook` | options `english`, `thesis` |
| language | main.tex:1 | `lang.babel` | global class option `english`; which language package the class loads and how was not read (assumed babel, carried by the class, no `\usepackage` in the sample) |
| page geometry | none set in the sample (main.tex has no geometry or typearea call) | `class.tudscrbook` | class default; KOMA base, the class's own layout not read |
| fonts and colour | none set in the sample (main.tex:3-4 load only booktabs and natbib) | `class.tudscrbook` | corporate-design fonts and colours come from the class bundle (`tudscrfonts` named on ctan.org/pkg/tudscr); not read |
| header/footer, page numbers | none set in the sample | `hf.class-native` | the class's own running heads, no sample parameter |
| title block fields | main.tex:6-14 | `front.class-native` | `\thesis{master}`, `\faculty{Faculty of Computer Science}`, `\department{Institute of Systems Architecture}`, `\graduation{Master of Science}`, `\professor{...}`, `\referee{...}`, `\advisor{...}` (strings) |
| title, author, date, title page | main.tex:7,8,15,19 | `front.maketitle` | `\title{...}`, `\author{Jane Doe}`, `\date{\today}`, `\maketitle` (the page drawn by the class) |
| abstract | main.tex:21-25 | `abs.class-native` | `abstract` environment under the class; the class source was not read, so whether it is the class's own or forwarded from KOMA is open (if forwarded it is `abs.kernel`, the same one line in the emitter) |
| contents list | main.tex:27 | `toc.kernel` | `\tableofcontents`, no options |
| chapter and section commands | chapters/introduction.tex:1,4,11,22; chapters/evaluation.tex:1,4,24,36 | `head.kernel` | `\chapter{}` and `\section{}`, no `\renewcommand` of format or counters in the sample |
| heading looks, numbering | none set in the sample | `head.class-native` | the class's own heading looks and numbering, no sample parameter |
| lists | chapters/introduction.tex:15-20 | `list.kernel` | `enumerate` with three `\item` |
| inter-file inclusion | main.tex:29-30 | `struct.input` | `\input{chapters/introduction}`, `\input{chapters/evaluation}` (path strings) |
| table float and tabular | chapters/evaluation.tex:9,13-22 | `tbl.tabular` | `table[htbp]`, `tabular{@{}lrr@{}}`; cell contents are content |
| table rules | main.tex:3; chapters/evaluation.tex:14,16,20 | `tbl.booktabs` | `\usepackage{booktabs}`, `\toprule` `\midrule` `\bottomrule` |
| centring | chapters/evaluation.tex:10,30 | `sp.ragged` | `\centering` inside the table and the figure |
| caption | chapters/evaluation.tex:11,32 | `cap.kernel` | `\caption{...}` (written before the `tabular` in the table and after the `\rule` in the figure; the caption look is the class's) |
| figure float | chapters/evaluation.tex:29-34 | `fig.graphicx` | `figure[htbp]` with `\centering`; no `\includegraphics` in the sample |
| figure body placeholder | chapters/evaluation.tex:31 | `sp.rule` | `\rule{0.6\textwidth}{4cm}` (content stand-in for an image) |
| cross-references | chapters/introduction.tex:2,17,19; chapters/evaluation.tex:2,6,12,26,33 | `xref.kernel` | `\label{}` and `Table~\ref{}` / `Figure~\ref{}` |
| citations | main.tex:4; chapters/introduction.tex:8,24,25; chapters/evaluation.tex:40 | `bib.natbib` | `\usepackage{natbib}` (no options), `\citep{key}` |
| bibliography | main.tex:32-33; references.bib:1-18 | `bib.bibtex-bst` | `\bibliographystyle{plainnat}`, `\bibliography{references}`; two entries, an `@article` and an `@inproceedings` (content) |

## Bespoke code
none. The sample defines no `\newcommand`, `\def`, environment, counter or conditional (main.tex:1-35, chapters/introduction.tex:1-26, chapters/evaluation.tex:1-40 read in full), and the zip holds no `.cls` or `.sty`.

## Content-opaque
none. The figure body is a `\rule` (chapters/evaluation.tex:31), held by `sp.rule`; there is no TikZ, no included image and no equation.

## Lib changes
- New ways proposed: none. `class.tudscrbook` is a published class way and needs no proposal; its native vocabulary is recorded above under "Class setting".
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes:
- The zip ships no README, no logo and no font. The class (and its TU Dresden logo and corporate-design font handling) comes from TeX Live; whether the fonts or logos need installing beyond that is not established here, since the class source and its documentation were not read. A missing asset would be shipped, not a blocker.
- No text addressed to an AI was found in the zip.
