yes

# 0341-jlreq-japanese-book: jlreq Japanese Book

- Unverified: read from the source, not compiled.
- Source: Source/0341-jlreq-japanese-book/ (origin: https://latextemplates.com/downloads/jlreq.zip; licence: BSD-2-Clause per the manifest)
- Kind: book (the title is "Japanese Book Starter", main.tex:7, README.md:1; the sample's own structure is article-like: `\section` is the top level, main.tex:15)
- Lib: v3
- Engine: needs LuaLaTeX (README.md:5 says "Compile with LuaLaTeX"; ctan.org/pkg/jlreq lists class and JFM files for LuaTeX-ja, pLaTeX and upLaTeX, so it is not a pdfTeX class)
- Look carried by: class (the look is the `jlreq` class's defaults; the preamble only adds `amsmath` and `hyperref` link colours, main.tex:3-5)
- Class origin: tex-distribution-unbundled (README.md:4: "supplied by TeX Live and is not bundled in this archive"; ctan.org/pkg/jlreq confirms a CTAN class in TeX Live, Simplified BSD licence)
- Main file: main.tex (other samples: none; README.md is a 5-line note)
- Read: main yes, zip-local classes and styles none present (the zip holds only README.md and main.tex; the `jlreq` class source is not in the zip and was not read)

## Verdict
The zip is one 33-line sample (main.tex:1-33) on the published `jlreq` class, plus `amsmath` and `hyperref`. It adds no class, style, macro, environment or counter of its own, so there is nothing bespoke and no artwork. Every part the sample uses maps to an existing lib way, so `yes`. This says something about the class dimension only: the Japanese layout (kinsoku, kanji spacing, heading and title looks) lives inside `jlreq`, whose source was not read, so the component ways here carry little weight. The engine is LuaLaTeX (or pLaTeX/upLaTeX), not pdfTeX; that is recorded, not a blocker.

## Blockers
none

## Class setting
- Class: `class.jlreq` options: `paper=a4`, `fontsize=11pt` (main.tex:1; key=value options, the class's own syntax). No other class option is given (no `book`, `twocolumn`, `tate` vertical writing or `jlreq` layout keys). The class source was not read: it ships with TeX Live, not in the zip.
- Class-native vocabulary used: none beyond the kernel set. The sample calls only the kernel commands `\title` `\author` `\date` `\maketitle` `\tableofcontents` `\section` `\subsection` (main.tex:7-13, 15, 19, 24, 30). The sample text (main.tex:20-22) says paragraph spacing, kinsoku and vertical writing are managed by the document class; the sample sets none of those switches.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.jlreq` | `paper=a4`, `fontsize=11pt`; published, not bundled |
| paper and base size | main.tex:1 | `page.class-options` | `paper=a4` (A4 paper), `fontsize=11pt` (base text size); margins and text area are the class default (no geometry call anywhere) |
| Japanese typesetting (kinsoku, kanji and Latin spacing, JFM) | main.tex:16-17, 20-22, 31; README.md:5 | `class.jlreq` | no `\kanjiskip`, `\xkanjiskip`, `\xspcode`, `\prebreakpenalty` or `\postbreakpenalty` set (so not `lang.ptex`), no `CJK`/`xeCJK`/`ctex` (so not `lang.cjk`), no babel; carried by the class and the engine |
| fonts | main.tex (no font command or package) | `class.jlreq` | no font package, no `\setmainfont`, no `\familydefault`; the face is the class and engine default (jlreq source not read) |
| page headers and footers | main.tex (no `\pagestyle`, no `fancyhdr`) | `class.jlreq` | class default running heads and page numbers (not read); nothing set in the sample |
| math package | main.tex:3 | `math.amsmath` | `\usepackage{amsmath}`, no options |
| display maths | main.tex:26-28 | `math.kernel` | `\[ ... \]` with `\sum_{k=1}^{n}` and `\frac`; the formula is content |
| hyperlinks | main.tex:4-5 | `meta.hyperref` | `colorlinks=true`, `linkcolor=blue`, `urlcolor=blue` |
| title block | main.tex:7-9, 12 | `front.maketitle` | `\title{Japanese Book Starter}`, `\author{Your Name}`, `\date{\today}`, `\maketitle`; the printed layout is the class's own `\maketitle` (not read) |
| contents | main.tex:13 | `toc.kernel` | `\tableofcontents`, no `tocdepth` change; entry looks are the class default |
| headings | main.tex:15, 19, 24, 30 | `head.kernel` | `\section` x3 and `\subsection` x1, no `\renewcommand`, no `titlesec`; heading look and numbering are the class default (`num.secnumdepth` not set) |
| inline monospace | main.tex:16 | `mark.kernel` | `\texttt{jlreq}` |
| paragraphs | main.tex:16-17, 20-22, 25, 31 | none (content) | plain paragraphs; no list, quote, theorem, figure, table, code, bibliography, index or footnote in the sample |

## Bespoke code
none (the zip defines no `\newcommand`, `\def`, environment, counter or conditional; main.tex:1-33 has none)

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
