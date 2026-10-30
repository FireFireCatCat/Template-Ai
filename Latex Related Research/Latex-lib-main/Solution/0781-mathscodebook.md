yes

# 0781-mathscodebook: MathsCodeBook (maths-and-code book starter)

- Unverified: read from the source, not compiled.
- Source: Source/0781-mathscodebook/ (origin: https://latextemplates.com/downloads/mathscodebook.zip; licence: CC0-1.0)
- Kind: book
- Lib: v6
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (the kernel `book` class plus one preamble of published packages and their option settings, main.tex:1-22; the zip has no class or style file)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is one 97-line `main.tex` and a README. It loads the kernel `book` class and eleven published packages (`fontenc`, `inputenc`, `lmodern`, `geometry`, `amsmath`, `amssymb`, `amsthm`, `listings`, `xcolor`, `booktabs`, `hyperref`) at main.tex:2-10. Every look-defining line is a package option, a `\definecolor`, a `\lstset`, a `\hypersetup`, a `\geometry` or a `\newtheorem` call (main.tex:11-22). There is no `\newcommand`, `\def`, counter, conditional or zip-local `.cls`/`.sty`, no artwork, and no tool outside TeX (`listings`, not `minted`). Each component maps to an existing lib way, so the answer is `yes`.

## Blockers
none

## Class setting
- Class: `class.book` options: `11pt` (main.tex:1); source not bundled in the zip and not read (the class ships with the TeX distribution)
- Class-native vocabulary used: `\frontmatter` (main.tex:27), `\mainmatter` (main.tex:34), `\backmatter` (main.tex:89), `\chapter` and `\chapter*` (main.tex:29, 35, 52, 68, 86, 90), `\appendix` (main.tex:85), `\tableofcontents` (main.tex:33), `\maketitle` (main.tex:28), `thebibliography` (main.tex:91). The `\newtheorem{..}{..}[chapter]` counters (main.tex:20-22) use the book class's `chapter` counter.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.book` | 11pt; the other book defaults (twoside, chapter opening) are not set by the file |
| type size option | main.tex:1 | `page.class-options` | 11pt |
| paper and margins | main.tex:5, main.tex:11 | `page.geometry` | paperwidth=6.5in, paperheight=9.5in, margin=0.8in |
| encodings | main.tex:2-3 | `font.fontenc-t1` | fontenc option T1; inputenc option utf8 |
| text and maths face | main.tex:4 | `font.lmodern` | `\usepackage{lmodern}`, no options |
| named colours | main.tex:8, main.tex:12-14 | `color.xcolor` | `\definecolor` model HTML: codebg=F1F5F9, codeink=1E293B (defined, never used again in the file), accent=7C3AED |
| link colours | main.tex:10, main.tex:15 | `meta.hyperref` | colorlinks=true, linkcolor=accent, urlcolor=accent, citecolor=accent |
| title block | main.tex:23-25, main.tex:28 | `front.maketitle` | `\title{Patterns for Mathematical Computing}`, `\author{Your Name}`, `\date{2026}`, `\maketitle` inside `\frontmatter` |
| front, main, back matter | main.tex:27, main.tex:34, main.tex:89 | `class.book` | `\frontmatter`, `\mainmatter`, `\backmatter` (class-native; the numbering change in front matter is the class's own) |
| unnumbered chapters | main.tex:29, main.tex:90 | `head.kernel` | `\chapter*{How to read this book}`, `\chapter*{References}` |
| numbered chapters | main.tex:35, main.tex:52, main.tex:68, main.tex:86 | `head.kernel` | `\chapter{..}` with the class's default heading look; no `titlesec`/`fncychap`, no `\renewcommand` of heading format |
| contents | main.tex:33 | `toc.kernel` | `\tableofcontents`, no options; no list of figures or tables |
| appendix | main.tex:85-86 | `num.appendix` | `\appendix` before one `\chapter{Notation guide}` |
| page style | main.tex:1 | `hf.pagestyle-kernel` | not set by the file (no `\pagestyle`, `\thispagestyle` or `fancyhdr`); the class's default style applies |
| display equation | main.tex:37-39 | `math.amsmath` | `equation` environment with `amsmath` loaded (main.tex:6); no `\numberwithin`, no `leqno`/`fleqn` |
| blackboard letter in text | main.tex:87 | `math.amssymb` | `\mathbb{N}` from `amssymb` (main.tex:6) |
| theorem-like statements | main.tex:6, main.tex:20-22, main.tex:40-43, main.tex:48-51, main.tex:64-67 | `thm.amsthm` | `\newtheorem{theorem}{Theorem}[chapter]`, `\newtheorem{exercise}{Exercise}[chapter]`, `\newtheorem{remark}{Remark}[chapter]`; no `\theoremstyle` call, so each one has the default style, three counters each reset by chapter |
| proof | main.tex:44-47 | `thm.amsthm` | `proof` environment of `amsthm`, no argument, default QED mark |
| code listing setup | main.tex:7, main.tex:16-19 | `code.listings` | `\lstset{backgroundcolor=\color{codebg}, basicstyle=\ttfamily\small, keywordstyle=\color{accent}\bfseries, commentstyle=\color{gray}, frame=single, rulecolor=\color{gray!35}, columns=fullflexible, language=Python, showstringspaces=false}` |
| code listing | main.tex:55-63 | `code.listings` | `lstlisting` environment, no options, inherits the `\lstset` values (the code text is content) |
| colours inside the listing keys | main.tex:16-18 | `color.xcolor` | `\color{codebg}`, `\color{accent}`, `\color{gray}`, expression `gray!35` |
| code font and size | main.tex:16 | `mark.kernel` | `\ttfamily`, `\bfseries` (kernel font switches inside listing keys) |
| code font size | main.tex:16 | `font.size-commands` | `\small` |
| table float | main.tex:69-70, main.tex:81-82 | `tbl.tabular` | `table` float with placement `[ht]`, `tabular` with column spec `@{}rr@{}` (main.tex:72) |
| table rules | main.tex:73, main.tex:75, main.tex:80 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule`; no `\cmidrule`, no rule-width changes |
| table centring | main.tex:70 | `sp.ragged` | `\centering` inside the float |
| caption | main.tex:71 | `cap.kernel` | `\caption{Partial sums for $r=1/3$.}` above the tabular; no `caption` package |
| bibliography | main.tex:90-96 | `bib.thebibliography` | `thebibliography{9}`, two `\bibitem` entries (keys knuth, strang; neither is cited in the file), heading from `\chapter*{References}` |
| emphasis in entries | main.tex:92, main.tex:94 | `mark.kernel` | `\emph{..}` for the book titles |

Not used by the file (so no row): `\label`, `\ref`, `\cite`, footnotes, figures with `\includegraphics`, lists, quotes, an abstract, an index.

## Bespoke code
none. The file defines no macro, environment, counter or conditional. The only declarations are `\definecolor` (main.tex:12-14), `\hypersetup` (main.tex:15), `\lstset` (main.tex:16-19), `\newtheorem` (main.tex:20-22) and `\geometry` (main.tex:11), all calls of published packages that the component map records with their values.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- README.md:1-9 is a short description (a starter "inspired by" the upstream MathsCodeBook; the upstream work is not bundled). It holds no instructions to an AI.
- The sample has no missing assets (no images, no external fonts); `lmodern`, `listings`, `booktabs` and the AMS packages ship with TeX Live.
- `listings` with `language=Python` uses the built-in language definition, no external highlighter (so not `code.minted`).
