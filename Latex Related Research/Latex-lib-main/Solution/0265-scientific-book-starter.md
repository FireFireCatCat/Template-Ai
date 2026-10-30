yes

# 0265-scientific-book-starter: Scientific Book Starter

- Unverified: read from the source, not compiled.
- Source: Source/0265-scientific-book-starter/ (origin: https://latextemplates.com/downloads/scientific-book-starter.zip; licence: MIT, README.md:30-31, manifest)
- Kind: book
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:36 builds with `pdflatex main`; every package loaded at main.tex:20-26 works in pdfLaTeX)
- Look carried by: preamble (stock `book` defaults, a seven-line package preamble, and a hand-laid `titlepage` in the body; the zip holds no class or style file)
- Class origin: tex-distribution-unbundled (`book` at main.tex:18 is the LaTeX base class, not in the zip; its source was not read; no ctan.org read was needed)
- Main file: main.tex (other samples: none; the five files in chapters/ are `\include`d content, not samples)
- Read: main yes (all 60 lines, and all five chapter files, 125 lines), zip-local classes and styles none present (the zip has only README.md, main.tex and chapters/*.tex)

## Verdict
yes. The zip is a plain `book` document: no zip-local `.cls`, `.sty`, `\newcommand`, `\def`, counter or conditional exists (grep over the whole zip finds none). Its preamble loads only published packages (`fontenc`, `xcolor`, `graphicx`, `amsmath`/`amssymb`/`amsthm`, `tikz`, `hyperref`) and two `\newtheorem` calls, and its body uses kernel sectioning, a hand-laid `titlepage`, `\tableofcontents` and cross-references. Each of these maps to a lib way with parameters. The one TikZ picture (a diagram of this book's chapters, chapters/00_concept_map.tex:13-24) is the author's own content, not template identity, so it is recorded as Content-opaque and not as `ART`; this is a judgement call, noted under Content-opaque. The README's remark about upstream's Ruby gem and `softcover.sty` describes files that are not in this zip (README.md:10-23), so no `EXTERNAL` blocker applies.

## Blockers
none

## Class setting
- Class: `class.book` options: `10pt` (main.tex:18); no paper, side, column or title-page option, so the class defaults apply (source of `book` not read)
- Class-native vocabulary used: `\frontmatter` (main.tex:45), `\mainmatter` (main.tex:51), `\backmatter` (main.tex:56), `\chapter` and `\chapter*` (chapters/00_concept_map.tex:2, chapters/00_preface.tex:2, chapters/01_fundamentals.tex:2, chapters/02_estimation.tex:2, chapters/99_answers.tex:2), `\section`, `titlepage` environment (main.tex:33-43), `\tableofcontents` (main.tex:46)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:18 | `class.book` | `10pt` |
| paper, size, page geometry | main.tex:18 (no `geometry`, `\setlength` or paper option anywhere) | `page.class-options` | class defaults; only `10pt` is set |
| header/footer, page style | none set (no `\pagestyle`, `fancyhdr`) | `hf.class-native` | the `book` class's own running heads and plain chapter-opening pages |
| encoding, text font | main.tex:20 | `font.fontenc-t1` | `fontenc` option `T1`; no text-face package, so the default Computer Modern |
| colour | main.tex:21, used at main.tex:26 | `color.xcolor` | option `svgnames`; colour name `DarkBlue` |
| graphics loading | main.tex:22 (no `\includegraphics` and no `figure` anywhere in the zip) | `fig.graphicx` | `graphicx` loaded with no options, unused by the sample |
| maths packages | main.tex:23; `\text` at chapters/02_estimation.tex:20-22 | `math.amsmath`, `math.amssymb` | no options |
| theorem-like statements | main.tex:23, 28-29; chapters/01_fundamentals.tex:12-15, 23-29; chapters/02_estimation.tex:15-25 | `thm.amsthm` | `amsthm` loaded; `\newtheorem{definition}{Definition}[section]` and `\newtheorem{example}{Example}[section]`; no `\theoremstyle`, so the default `plain` style; optional title argument `[Falsifiable claim]`, `[How many leaves are on a large oak tree?]` |
| hyperlinks | main.tex:26 | `meta.hyperref` | `colorlinks`, `linkcolor=DarkBlue`, `urlcolor=DarkBlue` |
| TikZ loading | main.tex:24-25 | `art.tikz` | `tikz` with library `positioning`; used only by the one picture (Content-opaque) |
| title page | main.tex:33-43 | `front.titlepage-env` | `titlepage` environment with title, subtitle, author and year laid by hand; no `\title`, `\author` or `\maketitle` |
| title page alignment | main.tex:34, chapters/00_concept_map.tex:12 | `sp.ragged` | `\centering` in the title page; `center` environment around the diagram |
| title page spacing | main.tex:35, 37, 39, 41 | `sp.manual-space` | `\vspace*{3cm}`, `\vspace{0.5cm}`, `\vspace{2cm}`, `\vfill` |
| title page sizes | main.tex:36, 38, 40, 42 | `font.size-commands` | `\Huge`, `\Large`, `\large`, `\large`, each in a group closed by `\par` |
| title page bold | main.tex:36 | `mark.kernel` | `\bfseries` |
| front, main and back matter | main.tex:45, 51, 56 | `front.class-native` | `\frontmatter`, `\mainmatter`, `\backmatter`: the class switches page numbering (roman, then arabic) and chapter numbering on and off; no explicit `\pagenumbering` |
| table of contents | main.tex:46 | `toc.kernel` | `\tableofcontents` only; no list of figures or tables |
| chapters and sections | chapters/01_fundamentals.tex:2, 9, 31; chapters/02_estimation.tex:2, 12, 27; chapters/99_answers.tex:2 | `head.kernel` | `\chapter`, `\section` with the class's default look; no `\titleformat`, no counter changes; the answers chapter is unnumbered because `\backmatter` precedes it (main.tex:56) |
| unnumbered chapters in the contents | chapters/00_concept_map.tex:2-3; chapters/00_preface.tex:2-3 | `head.kernel`, `toc.kernel` | `\chapter*{...}` followed by `\addcontentsline{toc}{chapter}{...}` |
| cross-references | chapters/01_fundamentals.tex:3, 10, 32; chapters/02_estimation.tex:3, 13, 28; chapters/99_answers.tex:3, 5-11 | `xref.kernel` | `\label{ch:...}`, `\label{sec:...}`, `\ref` after `Chapter~` and `Section~`; the links are coloured by `meta.hyperref` |
| emphasis marks | chapters/01_fundamentals.tex:13, 38; chapters/99_answers.tex:5, 11 | `mark.kernel` | `\emph`, `\textbf` |
| multi-file assembly | main.tex:48-49, 53-54, 58 | `pg.break` | `\include{chapters/...}` of five files; the file split is assembly, not a look, and its only page effect is the `\clearpage` that `\include` performs before and after each file; the emitter can write the same content inline |
| concept-map diagram | chapters/00_concept_map.tex:12-25 | `art.tikz` | `tikzpicture` with `box/.style`, `node distance=2.2cm`, `right=of`, `below=of`; Content-opaque, see below |

Components the zip does not use (nothing to map): lists, quotes, footnotes and margin notes, tables and captions, figure floats, code, boxes, bibliography and index, appendix, language packages, running-head customisation, abstract and keywords.

## Bespoke code
none. Checked by grep over the whole zip for `\newcommand`, `\renewcommand`, `\def`, `\setlength`, `\pagestyle`: no match. The two `\newtheorem` lines (main.tex:28-29) are reducible to `thm.amsthm`; the TikZ style `box/.style` (chapters/00_concept_map.tex:15) belongs to the content-opaque picture.

## Content-opaque
- `tikzpicture` of three boxes and three arrows showing how this book's chapters relate (chapters/00_concept_map.tex:13-24), set inside a `center` environment and not inside a `figure` float. Judgement: it illustrates the author's chapter structure, and it is not repeated or required by the template as a banner, frame or sidebar would be, so it is content (`art.tikz`), not `ART`. If a reviewer reads it as template identity (the README lists the "concept map" among the structure it keeps, README.md:4 and README.md:19), it would become `ART/body` and the verdict would turn to `no`.
- The filename comments `%!TEX root = ../main.tex` (chapters/*.tex:1) are editor hints with no typeset effect.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
