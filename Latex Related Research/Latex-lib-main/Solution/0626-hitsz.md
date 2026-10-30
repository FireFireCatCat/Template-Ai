yes

# 0626-hitsz: HITSZ beamer (Harbin Institute of Technology, Shenzhen)

- Unverified: read from the source, not compiled.
- Source: Source/0626-hitsz/ (origin: https://latextemplates.com/downloads/hitsz-beamer.zip; licence: LPPL-1.3c)
- Kind: presentation
- Lib: v5
- Engine: needs XeLaTeX (inferred, not verified: the sample prints Chinese text at main.tex:5 and loads no CJK package in its preamble, main.tex:1-3, so the unbundled theme must supply the CJK support; the CTAN page names no engine)
- Look carried by: class (the published `beamer` class plus the published theme `hitszbeamer` named at main.tex:2; the theme file is not in the zip, so the zip adds only an option, a theme name, `booktabs` and content)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip holds three files: `main.tex` (75 lines) and two logo JPEGs under `figures/`. There is no `.cls`, `.sty`, `.def` or `.cfg` in it. `main.tex` is a plain beamer deck that adds only the option `compress`, `\usetheme{hitszbeamer}` (main.tex:1-2), `booktabs` (main.tex:3) and content. The theme is not in the zip, but one read of ctan.org/pkg/hitszbeamer shows it is a published package ("Hitszbeamer, a Beamer theme for Harbin Institute of Technology, ShenZhen (HITSZ)"; v1.0.0 of 2020-03-17; LPPL 1.3c; author Jingxuan Yang; CTAN path `macros/latex/contrib/beamer-contrib/themes/hitszbeamer`; listed as in TeX Live and MiKTeX). It is therefore the theme-name parameter of `slide.beamer-theme`, and its source was not read (it is not in the zip; the rubric lets a published class or theme stand unread). Every body construct maps to an existing lib way, there is no bespoke code and no artwork in the sample. The `yes` rests on the theme being that published package and on the sample adding nothing of its own.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `compress` (main.tex:1)
- Class-native vocabulary used: `frame` environment with a title argument `\begin{frame}{Title}` (main.tex:23, 33, 48, 69) and untitled frames (main.tex:13, 17); `\titlepage` (main.tex:14); `\institute[short]{..}` (main.tex:7); optional short forms `\title[..]{..}` and `\author[..]{..}` (main.tex:5-6); `\tableofcontents` inside a frame (main.tex:18); `columns` environment holding `column{width}` (main.tex:49-64); `\usetheme{hitszbeamer}` (main.tex:2); `\section` as navigation and contents entries only (main.tex:21, 31, 67).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.beamer` | option `compress` |
| beamer theme (page layout, colours, fonts, headline and footline, logo placement) | main.tex:2 | `slide.beamer-theme` | `\usetheme{hitszbeamer}`, no options; published CTAN and TeX Live package, source not in the zip and not read, so which inner or outer themes, colours and fonts it sets is not known here |
| CJK text support | Chinese text at main.tex:5, 8, 23, 38, 69; preamble main.tex:1-3 loads no CJK package | `lang.cjk` | inferred, not read: must come from the theme (the sample loads nothing), XeLaTeX route; an emitter that loads the theme gets it |
| title, author, date fields | main.tex:5, 6, 9 | `front.maketitle` | `\title[Underwater Control]{..}`, `\author[Li Ming]{..}`, `\date{\today}` |
| institute and title page frame | main.tex:7-8, 13-15 | `front.class-native` | `\institute[HITSZ]{\small ..}`, `\titlepage` inside a `frame` |
| line breaks with extra space in title fields | main.tex:5, 6, 7 | `sp.manual-space` | `\\[2mm]` (main.tex:5), `\\[3mm]` (main.tex:6), plain `\\` (main.tex:7) |
| size switch in author and institute | main.tex:6, 7 | `font.size-commands` | `\small` |
| contents frame | main.tex:17-19 | `toc.kernel` | `\tableofcontents` in an untitled frame, no options |
| sectioning | main.tex:21, 31, 67 | `head.kernel` | `\section{..}`, three sections, no star, no depth change |
| frames with titles | main.tex:23, 33, 48, 69 | `class.beamer` | `\begin{frame}{title}` ... `\end{frame}` (class vocabulary) |
| bullet lists | main.tex:24-28, 52-55, 59-62 | `list.kernel` | `itemize`, no options |
| two columns | main.tex:49-64 | `class.beamer` | `columns` with two `column{0.48\textwidth}` (class vocabulary; the same layout type as `cols.minipage`) |
| table float | main.tex:34, 45 | `tbl.tabular` | `table` environment, no caption, no placement option |
| centring | main.tex:35, 70 | `sp.ragged` | `\centering` (main.tex:35), `center` environment (main.tex:70) |
| table body | main.tex:36-44 | `tbl.tabular` | `tabular{lcc}`, header row, three data rows |
| table rules | main.tex:3, 37, 39, 43 | `tbl.booktabs` | `\usepackage{booktabs}`, `\toprule` `\midrule` `\bottomrule` |
| bold run-in labels | main.tex:51, 58 | `mark.kernel` | `\textbf{..}` |
| large closing text | main.tex:71 | `font.size-commands` | `\Large` inside `center` |
| inline maths in a cell | main.tex:42 | `math.kernel` | `$H_\infty$` (content) |

## Bespoke code
none. `main.tex` defines no macro, environment, counter or conditional (read in full, 75 lines; a search for `\newcommand`, `\def`, `\renewcommand`, `\setbeamer*`, `\use*theme` found only `\usetheme` at main.tex:2 and `\usepackage{booktabs}` at main.tex:3). The zip contains no `.cls`, `.sty`, `.def` or `.cfg`.

## Content-opaque
none. Assets note, not a blocker: `figures/hitlogo.jpg` (blue university emblem, 431727 bytes) and `figures/hitlogo-mask.jpg` (the same emblem in grey, 431641 bytes) are not referenced by `main.tex` (no `\includegraphics` in it). They are probably read by the theme from a `figures/` path, which is an inference since the theme was not read. Ship `figures/` beside `main.tex` when rebuilding.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
