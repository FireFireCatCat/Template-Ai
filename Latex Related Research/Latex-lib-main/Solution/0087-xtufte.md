yes

# 0087-xtufte: xtufte-book (Tufte-style book, Unicode-engine fork)

- Unverified: read from the source, not compiled.
- Source: Source/0087-xtufte/ (origin: https://latextemplates.com/downloads/xtufte.zip; licence: LPPL-1.3 for the xtufte extension, Apache-2.0 for the base tufte-latex, README.md:29-33)
- Kind: book
- Lib: v1
- Engine: needs LuaLaTeX (or XeLaTeX): the class is a Unicode-engine fork for OpenType/TrueType fonts (README.md:3-7, main.tex:1-3); the build line is `lualatex` (README.md:38). The CTAN page names LuaLaTeX as supported and XeLaTeX as expected.
- Look carried by: class (the zip holds one sample that loads the published class `xtufte-book` with two options, plus `booktabs` and one biblatex option; no zip-local class, style or macro)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip ships only main.tex, references.bib, README.md; the class ships with TeX Live and is not bundled, README.md:24-27)

## Verdict
The look is carried entirely by the published class `xtufte-book` (CTAN package `xtufte`, v0.03, LPPL-1.3, in TeX Live; one ctan.org read, class source not read). The zip adds only two class options (`justified`, `notoc`), one `\PassOptionsToPackage` for biblatex, `booktabs`, and content. There is no zip-local macro, no artwork and no tool outside TeX (the one sample that needed `minted-code`, shell escape and a remote bibliography was dropped, main.tex:9-14, README.md:16-22). The result is `yes` under the rubric's published-class ruling, as evidence about the class dimension rather than the component ways. Caveat: nothing the class itself defines (page layout, running heads, title page, toc and heading looks, sidenote and margin-float internals) was read, so those rows record what the sample calls, not what the class does inside.

## Blockers
none

## Class setting
- Class: `class.xtufte-book` options: `justified`, `notoc` (main.tex:20)
- Class-native vocabulary used: `\title[short]{..}` and `\author[short]{..}` with optional arguments (main.tex:24-25); `\publisher{}` (main.tex:26, empty); `\maketitlepage` (main.tex:32); `\chapter`, `\section` (main.tex:36, 57, 82); `\sidenote{..}` (main.tex:39, 61); `\newthought{..}` (main.tex:46); `marginfigure` environment (main.tex:52-55); `\addbibresource` and `\printbibliography` (main.tex:28, 90; the class loads biblatex and defaults to the biber backend, README.md:11-13). Option meanings (`justified`, `notoc`) are not documented in the zip and were not read from the class; they are recorded as parameters only.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:20 | `class.xtufte-book` | options `justified,notoc`; the class is a Unicode-engine fork of tufte-latex (README.md:3-7) |
| text alignment | main.tex:20 | `class.xtufte-book` | class option `justified` (a parameter of the class, not a separate package; its meaning is not read from the class) |
| page geometry (wide text column plus margin column) | not set by the sample; defined inside the class | `class.xtufte-book` | no paper-size or geometry option passed; class default layout, not read |
| header/footer (running heads, page numbers) | not set by the sample; defined inside the class | `hf.class-native` | none passed; class default, not read |
| fonts | not set by the sample; the class supports OpenType/TrueType fonts (README.md:3-7) | `font.fontspec` | no font command in the sample; class default fonts not read; listed because it fixes the engine (xe/lua) |
| title page | main.tex:24-26, 32 | `front.class-native` | `\title[Notes on Attention]{Notes on Attention}`, `\author[Owen Marsh]{Owen Marsh}`, `\publisher{}` (empty), `\maketitlepage` |
| contents | main.tex:20, 34 | `toc.kernel` | `\tableofcontents` after `\maketitlepage`; class option `notoc` (class-side effect not read) |
| chapter and section headings | main.tex:36, 57, 82 | `head.class-native` | `\chapter{..}`, `\section{..}`; looks set by the class, no options passed |
| paragraph opener | main.tex:46 | `class.xtufte-book` | class command `\newthought{Notification design}`; a class-native body wrapper, internals not read |
| sidenotes | main.tex:39, 61 | `note.sidenotes` | `\sidenote{..}`; the class's Tufte sidenotes, no optional offset used |
| margin figure | main.tex:52-55 | `class.xtufte-book` | class-native `marginfigure` float holding only a `\caption` (no image) |
| captions | main.tex:53, 69 | `cap.kernel` | `\caption{..}` inside `marginfigure` and `table`; caption look set by the class |
| table float | main.tex:67-80 | `tbl.tabular` | `table`, `\centering`, `tabular` with column spec `@{}lr@{}` |
| table centring | main.tex:68 | `sp.ragged` | `\centering` inside the `table` float |
| table rules | main.tex:22, 71-78 | `tbl.booktabs` | `\usepackage{booktabs}`; `\toprule`, `\midrule`, `\bottomrule` |
| citations | main.tex:41, 63 | `bib.biblatex-bibtex` | `\cite{simon1971designing}`, `\cite{mark2008cost}` (biblatex citation command) |
| bibliography | main.tex:19, 28, 90; references.bib:1-16 | `bib.biblatex-bibtex` | `\PassOptionsToPackage{backend=bibtex}{biblatex}` before `\documentclass` (the class loads biblatex), `\addbibresource{references.bib}`, `\printbibliography`; biblatex style left at the class default (not read) |

## Bespoke code
none. The sample defines no `\newcommand`, `\def`, environment, counter or conditional (grep of main.tex found only `\PassOptionsToPackage`, `\documentclass`, `\usepackage{booktabs}` at preamble level). No zip-local class or style exists.

## Content-opaque
none. The `marginfigure` at main.tex:52-55 holds no artwork, only a caption; the table at main.tex:67-80 is plain text cells.

## Lib changes
- New ways proposed: none. `\newthought` and `marginfigure` are class-native vocabulary, so they are recorded under `class.xtufte-book` as the rubric's "Class setting" rule says; no `fig.class-native` or `mark.class-native` is proposed because the class way is their home.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Origin check: https://ctan.org/pkg/xtufte (v0.03, 2025-11-27, Herbert Voss, LPPL-1.3, in TeX Live and MiKTeX) settles W1 for the class; https://ctan.org/pkg/tufte-latex only says the upstream package provides two Tufte-inspired classes. Neither page documents the class commands or options, so every class-side claim above is limited to what the sample calls.
- Engine note: Flouest's engine is pdfTeX, so this class needs the xe/lua engine; that is recorded, not a blocker.
- Not a blocker, recorded: the class defaults to biblatex with biber (README.md:11-13); the sample forces the bibtex backend (main.tex:19). Both backends are lib ways (`bib.biblatex-biber`, `bib.biblatex-bibtex`) and neither is an outside tool in the rubric's sense.
- Unconditional-load check: the zip's comments say it was `minted-code` in the class's own doc/sample-book.tex that needed shell escape (main.tex:9-14, README.md:16-22), which points to the sample and not the class loading `minted`. This is inferred from the zip's own text; the class source was not read, so an unconditional `minted` load by the class is not excluded by reading.
- No text addressed to an AI was found in the zip.
