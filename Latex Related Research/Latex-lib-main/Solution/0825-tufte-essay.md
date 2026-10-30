yes

# 0825-tufte-essay: Tufte Essay

- Unverified: read from the source, not compiled.
- Source: Source/0825-tufte-essay/ (origin: https://latextemplates.com/downloads/tufte-essay.zip; licence: Apache-2.0 per the manifest, no licence file in the zip; the CTAN page of tufte-latex also states Apache-2.0)
- Kind: report (a short essay set as a Tufte handout; the manifest hint is report)
- Lib: v6
- Engine: pdfLaTeX-compatible (no fontspec, no Lua, no shell escape in the sample; the class source was not read)
- Look carried by: class (the whole look is the published `tufte-handout` class; the zip adds `booktabs` and content)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip is one 97-line `main.tex` on the published `tufte-handout` class (CTAN package `tufte-latex`, v3.5.2, in TeX Live; one ctan.org read). It holds no zip-local class, style, `\newcommand`, `\def`, counter or drawing. Every construct the sample uses is a class-native command of that class or a kernel command, plus `booktabs`. The class itself is not in the zip and its source was not read, so its internal choices (fonts, margins, running heads, caption and heading looks) are recorded as carried by `class.tufte-handout`, not decomposed.

## Blockers
none

## Class setting
- Class: `class.tufte-handout` options: none (main.tex:1 is `\documentclass{tufte-handout}`)
- Class-native vocabulary used: `\sidenote{...}` (main.tex:23, 41, 83); `marginfigure` environment holding a `tabular` and a `\caption` (main.tex:46-58); `\title` `\author` `\date{}` `\maketitle` (main.tex:3-5, 11); `abstract` environment (main.tex:13-19); `\section` (main.tex:31, 60, 73, 88)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.tufte-handout` | no options; class defaults |
| page geometry (wide margin column) | main.tex:1 (no geometry call in the sample) | `page.class-options` | none set by the sample; the layout is the class default (class source not read) |
| header/footer, running heads | main.tex:1 (no `\pagestyle` or `fancyhdr` in the sample) | `hf.class-native` | none set; whatever the class prints by default (class source not read) |
| title block | main.tex:3, 4, 5, 11 | `front.maketitle` | `\title{The Map That Ate the Territory}`, `\author{J. Okonkwo-Reyes}`, `\date{}` (empty date), `\maketitle`; the class supplies the look |
| abstract | main.tex:13-19 | `abs.kernel` | plain `abstract` environment, no options; the class styles it |
| headings | main.tex:31, 60, 73, 88 | `head.class-native` | four `\section{...}` calls, no starred form, no `\subsection`; the look is the class default, no `titlesec` or counter change in the sample |
| sidenotes | main.tex:23, 41, 83 | `note.sidenotes` | `\sidenote{text}` with no optional offset or number argument, three uses inside paragraphs |
| margin float | main.tex:46-58 | `fig.class-native` | `marginfigure` environment, no offset argument; it holds the table below and a caption (a class-provided margin float; `note.sidenotes` was considered, but a float with a caption is a figure container) |
| table | main.tex:47-55 | `tbl.tabular` | `tabular` with column spec `{ll}`, header row in `\textbf`, three body rows (cell text is content) |
| table rules | main.tex:7, 48, 50, 54 | `tbl.booktabs` | `\usepackage{booktabs}`; `\toprule`, `\midrule`, `\bottomrule` |
| caption | main.tex:56-57 | `cap.kernel` | plain `\caption{...}` inside `marginfigure`; the class sets the caption look, no `caption` package |
| inline marks | main.tex:16, 28, 29, 38, 64; 49 | `mark.kernel` | `\emph{...}` in text, `\textbf{...}` in the table header cells |

Not used by the sample, so no row: contents, lists, quotes, theorems, math, code, bibliography, index, cross-references, appendix, language and metadata packages, colour, background.

## Bespoke code
none (main.tex has no `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, counter or conditional; the zip has no `.cls`, `.sty`, `.def` or `.cfg` file).

## Content-opaque
none

## Lib changes
- New ways proposed: none. `class.tufte-handout` is already in the lib (line 42); the vocabulary above is recorded under "Class setting".
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
