yes

# 0358-sjtu-thesis: SJTU Thesis

- Unverified: read from the source, not compiled.
- Source: Source/0358-sjtu-thesis/ (origin: https://latextemplates.com/downloads/sjtuthesis.zip; licence: LPPL-1.3c per the manifest)
- Kind: thesis
- Lib: v3
- Engine: needs XeLaTeX (the sample says so in its magic comment, main.tex:1; the class's own source was not read)
- Look carried by: class (the zip holds only a sample: class options, `\sjtusetup` values, content, and three published packages; no class or style file is in the zip)
- Class origin: tex-distribution-unbundled (`sjtuthesis` is the thesis class of the CTAN/TeX Live package `sjtutex`, LPPL 1.3c; it is not in the zip)
- Main file: main.tex (other samples: none; the chapters are `\input` files, chapters/introduction.tex, chapters/results.tex, chapters/acknowledgements.tex)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip adds no class, style or macro of its own: there is no `\newcommand`, `\def`, environment or counter anywhere in it (grep over all `.tex`). Everything the look needs is in a published class, `sjtuthesis`, which ships with the TeX distribution and is not bundled, so its source was not read; the sample only sets its options and `\sjtusetup` fields and loads `natbib`, `graphicx` and `booktabs`. Every body construct maps to a lib way, there is no artwork, and nothing needs a tool outside TeX in the sample. `yes` rests on the class being a published, declarative class; its internals (page layout, fonts, running heads, cover) are unverified here.

## Blockers
none

## Class setting
- Class: `class.sjtuthesis` options: `type=master`, `lang=en` (main.tex:2)
- Class-native vocabulary used: `\sjtusetup{info = {...}}` with keys `en / title`, `en / keywords`, `en / author`, `id`, `en / supervisor`, `en / department`, `en / major`, `en / degree`, `en / date` (main.tex:4-16); `\maketitle` (main.tex:24); `\copyrightpage` (main.tex:25); `\frontmatter`, `\mainmatter`, `\backmatter` (main.tex:27, 41, 49); `abstract` environment with a language argument `\begin{abstract}[en]` (main.tex:29-35); `\chapter` / `\section` sectioning (chapters/introduction.tex:1, 7). The class's source was not read, so the vocabulary is taken from the sample alone. Class origin was settled with ctan.org/pkg/sjtutex (it names `sjtuthesis`, `sjtuarticle`, `sjtureport`; version 2.3.1 at the time of reading); ctan.org/pkg/sjtuthesis is a 404, so the class is published under the package name `sjtutex`. Which release the sample was written for is not established.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2 | `class.sjtuthesis` | type=master, lang=en |
| title block and metadata | main.tex:4-16, 24 | `front.class-native` | `\sjtusetup` info keys: title, author, id, supervisor, department, major, degree, date (`\today`, main.tex:14), set per language with the `en /` prefix; printed by `\maketitle` |
| copyright page | main.tex:25 | `front.class-native` | `\copyrightpage`, no arguments |
| front/main/back matter switches | main.tex:27, 41, 49 | `front.class-native` | `\frontmatter`, `\mainmatter`, `\backmatter` (book-style vocabulary of the class; their effect on page numbers and heading numbers is inside the class, unread) |
| abstract | main.tex:29-35 | `abs.class-native` | `abstract` environment, optional argument `en` selects the language |
| keywords | main.tex:7 | `abs.keywords` | `en / keywords` set in `\sjtusetup`, printed by the class |
| table of contents and lists | main.tex:37-39 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables` (look defined by the class, unread) |
| chapters and sections | chapters/introduction.tex:1, 7, 14, 25, 28, 34; chapters/results.tex:1, 4, 24, 36 | `head.kernel` | `\chapter`, `\section`; heading look comes from the class (`head.class-native`, unread) |
| heading look | not set in the sample | `head.class-native` | defined inside the class; nothing in the zip |
| unnumbered chapter in the contents | chapters/acknowledgements.tex:1-2 | `front.dedication` | `\chapter*{Acknowledgements}` plus kernel `\addcontentsline{toc}{chapter}{...}`, placed after `\backmatter` (main.tex:49-51) |
| contents entry for the starred chapter | chapters/acknowledgements.tex:2 | `toc.kernel` | `\addcontentsline{toc}{chapter}{Acknowledgements}` |
| list | chapters/introduction.tex:18-23 | `list.kernel` | `enumerate`, three `\item`s, default labels |
| cross-references | chapters/introduction.tex:2, 20, 22; chapters/results.tex:12, 33 | `xref.kernel` | `\label`, `\ref` (`ch:`, `tab:`, `fig:` prefixes) |
| table | chapters/results.tex:9-22 | `tbl.tabular` | `table[htbp]`, `\centering`, `tabular{@{}lrr@{}}` |
| table rules | main.tex:20; chapters/results.tex:14, 16, 20 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| figure float | main.tex:19; chapters/results.tex:29-34 | `fig.graphicx` | `figure[htbp]`, `\centering`; the picture is a `\rule{0.6\textwidth}{4cm}` placeholder (content); `graphicx` loaded, `\includegraphics` not called |
| captions | chapters/results.tex:11, 32 | `cap.kernel` | `\caption` above the table, below the figure; look from the class (unread) |
| citations | main.tex:18; chapters/introduction.tex:11, 30; chapters/results.tex:40 | `bib.natbib` | `\citep`, no options |
| bibliography | main.tex:46-47; references.bib:1-18 | `bib.bibtex-bst` | style `plainnat`, database `references` |
| header, footer, page numbers | not set in the sample | `hf.class-native` | defined inside the class; nothing in the zip |

## Bespoke code
none. The zip has no `.cls`, `.sty`, `.def` or `.cfg`; main.tex and the three chapter files define no macro, environment, counter or conditional (grep for `newcommand`, `renewcommand`, `\def`, `newenvironment`, `newcounter`, `newif` returned nothing).

## Content-opaque
none (the figure body is a `\rule` placeholder at chapters/results.tex:31, plain content, no drawing code)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The class source is not in the zip and was not read, so page layout, fonts, language and CJK handling, running heads, the cover and the copyright page text are not decomposed here; they sit inside `class.sjtuthesis`. A class that needs fonts the zip does not ship (Chinese or logo assets) would be a missing-asset note, not a blocker.
- The abstract text (main.tex:33-34) says the template does not mandate `biblatex`; the sample chooses `natbib` with BibTeX (main.tex:18, 46-47).
- Nothing in the zip is addressed to an AI.
