yes

# 0038-photo-book: Photo Book

- Unverified: read from the source, not compiled.
- Source: Source/0038-photo-book/ (origin: https://latextemplates.com/downloads/photobook.zip; licence: BSD-3-Clause per the manifest; README.md:7 says the `photobook` class is 3-clause BSD)
- Kind: book
- Lib: v1
- Engine: pdfLaTeX-compatible (the sample's own preamble is pdfTeX-style: `fontenc` T1, `lmodern`, `microtype`; the class source was not read, so its own engine needs are unverified)
- Look carried by: mixed (the published `photobook` class carries page, trim, bleed and cell mechanics, main.tex:1-7 and README.md:3-4; the preamble adds only fonts, two colours, hyperref link colours and an empty page style, main.tex:8-16; no zip-local code)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is one 64-line `main.tex` plus a README. It loads the published CTAN class `photobook` (v0.1.31, 3-clause BSD, in TeX Live; one ctan.org/pkg/photobook read) with five size options, then a plain preamble of published packages. The class is not bundled in the zip, so it is one way and its source was not read. Every body construct is a kernel command, a published package command or the class's `inlinecell` environment. The one construct with no existing lib way, `inlinecell`, is proposed as `fig.class-native`. There is no zip-local macro, environment or counter, no TikZ or other artwork, and nothing that needs a tool outside TeX in the files read. Residual risk: the class's own source and manual were not read, so an unconditional external dependency inside the class (like `minted`) is not ruled out. Nothing suggests one, and it is the same unread-class assumption the rubric makes for any published class.

## Blockers
none

## Class setting
- Class: `class.photobook` options: `paperwidth=7in`, `paperheight=9in`, `blockwidth=6in`, `blockheight=8in`, `bleed=0.1in` (main.tex:1-7). CTAN describes it as an extension of the standard `book` class, so `\chapter`, `\tableofcontents` and `\maketitle` are `book` vocabulary (source of the class not read).
- Class-native vocabulary used: `inlinecell` environment with two mandatory arguments, width then height (main.tex:31, 41, 45, 50). `\imagecell[fill]{}{your-image}` is named only inside a `\verb` in the prose (main.tex:25) and is never called. The "spread helpers" are mentioned in prose only (main.tex:57-58) and are not used.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1-7 | `class.photobook` | `paperwidth=7in`, `paperheight=9in`, `blockwidth=6in`, `blockheight=8in`, `bleed=0.1in` |
| page size, type block, bleed | main.tex:2-6 | `page.class-options` | trim 7in x 9in, block 6in x 8in, bleed 0.1in (photobook's own option keys, same way as `a4paper`) |
| font encoding | main.tex:8 | `font.fontenc-t1` | `fontenc` option `T1` |
| text font | main.tex:9 | `font.lmodern` | `lmodern`, no options |
| colour definitions | main.tex:10, 13-14 | `color.xcolor` | `xcolor`; `\definecolor{night}{HTML}{17212B}`, `\definecolor{sunset}{HTML}{D97745}` |
| microtypography | main.tex:11 | `sp.microtype` | `microtype`, defaults |
| link colours and PDF links | main.tex:12, 15 | `meta.hyperref` | `colorlinks=true`, `urlcolor=sunset`, `linkcolor=night` |
| page style | main.tex:16 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no running head, no folio) |
| title block | main.tex:17-21 | `front.maketitle` | `\title{A Small Atlas of\\Everyday Light}`, `\author{Your Name}`, `\date{2026}`, `\maketitle`; the class may restyle `\maketitle` (source not read) |
| forced line break in title | main.tex:17 | `sp.manual-space` | `\\` |
| chapters | main.tex:22, 30, 49, 59 | `head.kernel` | `\chapter` (numbered), `\chapter*` (unnumbered); heading look is the class's default (not read) |
| section | main.tex:36 | `head.kernel` | `\section*` (unnumbered) |
| table of contents | main.tex:29 | `toc.kernel` | `\tableofcontents` |
| manual contents entries for unnumbered chapters | main.tex:23, 60 | `toc.kernel` | `\addcontentsline{toc}{chapter}{...}` after `\chapter*` |
| image cell container (inline) | main.tex:31-35, 41-48, 50-54 | `fig.class-native` | `\begin{inlinecell}{width}{height}`: `{\textwidth}{2.1in}`, `{0.47\textwidth}{1.35in}` (twice), `{\textwidth}{2.4in}` |
| two cells side by side | main.tex:44 | `sp.manual-space` | `\hfill` between two 0.47\textwidth cells |
| placeholder panel boxes (stand-in for photographs) | main.tex:32, 42, 46, 51 | `box.fancybox` | `\colorbox{night}`, `\colorbox{sunset}`, `\fcolorbox{sunset}{white}` |
| placeholder panel inner box | main.tex:32, 42, 46, 51 | `box.minipage` | `\parbox[c][1.9in][c]{\textwidth}`, `[c][1.15in][c]{0.47\textwidth}` (twice), `[c][2.1in][c]{0.94\textwidth}` |
| placeholder text colour | main.tex:32, 42, 46, 52 | `color.xcolor` | `\color{white}`, `\color{night}` |
| placeholder text alignment | main.tex:32, 42, 46, 51 | `sp.ragged` | `\centering` |
| placeholder text sizes | main.tex:33-34, 43, 47, 52-53 | `font.size-commands` | `\fontsize{25}{30}\selectfont`, `\normalsize`, `\Large`, `\small` |
| placeholder line spacing | main.tex:33, 34, 43, 47, 52 | `sp.manual-space` | `\\[-2pt]`, `\\[0.3em]` |
| inline code in prose | main.tex:25 | `code.verbatim` | `\verb|...|` |
| inline marks | main.tex:27 | `mark.kernel` | `\texttt{photobook}` |
| paragraphs and prose | main.tex:24-28, 37-40, 55-58, 61-63 | none (content) | body text; no spacing or indent settings are changed in the sample |

Components the sample does not use or define: columns, header/footer beyond `empty`, theorems, lists, quotes, notes, footnotes, maths, floats with captions, tables, code listings, bibliography, index, language setup, backgrounds. The sample has no `\frontmatter` or `\mainmatter`, no `\appendix` and no cross-references.

## Bespoke code
none. The only definitions in `main.tex` are the two `\definecolor` calls (main.tex:13-14), which are `color.xcolor`. There is no zip-local `.cls`, `.sty`, `\newcommand`, `\def`, environment, counter or conditional (grep of main.tex and README.md; the zip holds two files). The class and its `inlinecell` environment are published, not zip-local.

## Content-opaque
none. The four placeholder panels (main.tex:32-34, 42-43, 46-47, 51-53) are stand-ins for photographs, and every part of them maps to a lib way (rows above), so they need no opaque entry. Real photographs (`\imagecell`, main.tex:25) are assets the zip does not ship (README.md:5, 8-10).

## Lib changes
- New ways proposed: `fig.class-native` (the class's own image-cell or figure container environments and macros, set by arguments; for `photobook`: `\begin{inlinecell}{width}{height}` and the documented `\imagecell[fill]{}{image}`; engine pdf, as the sample uses it).
  - W1: the class is on CTAN and in TeX Live with a public manual (CTAN page and README.md:7).
  - W2: behaviour is chosen by two length arguments and an option, not by editing code (main.tex:31, 41, 45, 50).
  - W3: it serves a kind of component, an image or photo container in a page, and parallels `thm.class-native`, `front.class-native`, `abs.class-native`, `hf.class-native` and `head.class-native`, which are already in the lib.
  - W4: an emitter writes it as the body wrapper `\begin{inlinecell}{w}{h}...\end{inlinecell}` around a node's content, with the class's size options in `\documentclass`.
  - Caveat: the evidence is the sample's usage and the zip README only. The class source and manual were not read, so the exact cell semantics (crop, bleed, alignment) are not verified. The closest existing home, `box.minipage`, was rejected because the cell is the class's own mechanism, not a plain `minipage`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
