no

# 0343-awesome-beamer: Awesome Beamer

- Unverified: read from the source, not compiled.
- Source: Source/0343-awesome-beamer/ (origin: https://latextemplates.com/downloads/awesome-beamer.zip; licence: BSD-3-Clause)
- Kind: presentation
- Lib: v3
- Engine: pdfLaTeX-compatible (T1 + lmodern + microtype, no fontspec; `remember picture,overlay` TikZ needs two passes)
- Look carried by: preamble (stock `beamer`, no theme, no zip-local file; the look is `\setbeamercolor`/`\setbeamertemplate` lines in main.tex:9-25 plus a hand-laid TikZ title frame in the body)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only README.md and main.tex; beamer's own source was not read)

## Verdict
The zip is a stock `beamer` document with no zip-local class, style or macro, and almost all of it maps to lib ways: colours, beamer colour/font/template settings, a footline, a frame-title template, a section hook, lists and an agenda. It is `no` because two template-defining TikZ drawings have no declarative lib way: the full-page ink background with an accent triangle on the title frame, and the same kind of overlay inside the `\AtBeginSection` divider frame. The hook itself is `slide.beamer-section-hook`, but its body is a drawing, not declarative beamer commands. The README says upstream style files were not copied (README.md:11-12), so the drawing is original to this starter.

## Blockers
- `ART/preamble` section-divider frame drawn with TikZ: full-page `awesomeink` rectangle plus `awesomeaccent` triangle in the corner, in the `\AtBeginSection[]` body (main.tex:25)
- `ART/body` title-page frame hand-laid with a TikZ overlay: full-page ink fill, diagonal accent triangle over the upper-right half, white rule near the lower left (main.tex:33-40, drawing at main.tex:34-38)

## Class setting
- Class: `class.beamer` options: `aspectratio=169`, `10pt` (main.tex:1). No `\usetheme` is called, so the default beamer theme is the base and only templates are overridden.
- Class-native vocabulary used: `frame` environment with a title argument (main.tex:41, 45, 56, 73) and options `plain`, `plain,noframenumbering` (main.tex:25, 33); `\title[short]{}`, `\subtitle`, `\author[short]{}`, `\institute`, `\date` (main.tex:27-31); `\section` (main.tex:44, 55, 72); `\tableofcontents` (main.tex:42); `block` environment (main.tex:46-48); `columns[T,onlytextwidth]` with `\column{width}` (main.tex:50-53); `\AtBeginSection[]` (main.tex:25); `beamercolorbox` with `wd` `ht` `dp` `leftskip` `rightskip` (main.tex:23); `\usebeamerfont{title}` (main.tex:25, 39); insert commands `\inserttitle` `\insertsubtitle` `\insertauthor` `\insertinstitute` `\insertdate` `\insertshortauthor` `\insertshorttitle` `\insertframenumber` `\inserttotalframenumber` `\insertframetitle` `\insertsectionnumber` `\insertsection` (main.tex:23-25, 39). `\titlepage` is not used; the title frame is built by hand.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.beamer` | `aspectratio=169`, `10pt` |
| paper shape and base size | main.tex:1 | `page.class-options` | `aspectratio=169` (16:9 frame), `10pt` |
| encoding | main.tex:2 | `font.fontenc-t1` | `[T1]` |
| text font | main.tex:3 | `font.lmodern` | `lmodern` |
| microtypography | main.tex:6 | `sp.microtype` | defaults, no options |
| colour definitions | main.tex:9-12 | `color.xcolor` | `\definecolor{awesomeink}{HTML}{17191C}`, `awesomeaccent` `E85D3F`, `awesomemist` `EEF0F2`, `awesomegray` `687078` |
| beamer colour roles | main.tex:13-18 | `slide.beamer-template` | `\setbeamercolor` for `normal text` (fg ink, bg white), `structure` (fg accent), `frametitle` (fg ink, bg white), `title` (fg ink), `block title` (fg white, bg ink), `block body` (fg ink, bg mist) |
| beamer fonts | main.tex:19-20 | `slide.beamer-template` | `\setbeamerfont{title}{series=\bfseries,size=\LARGE}`, `{frametitle}{series=\bfseries,size=\Large}` |
| navigation symbols off | main.tex:21 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` |
| headline empty | main.tex:22 | `slide.beamer-template` | `\setbeamertemplate{headline}{}` |
| footer (author, short title, frame x / total) | main.tex:23 | `slide.beamer-template` | `footline` template: three `beamercolorbox` in an `\hbox`, widths `.16`, `.60`, `.24` `\paperwidth`, `ht=2.6ex`, `dp=1.1ex`, `leftskip=.35cm` / `.2cm`, `rightskip=.35cm plus1fil`, colours `structure` and `normal text`, `\tiny`, inserts `\insertshortauthor`, `\insertshorttitle`, `\insertframenumber~/~\inserttotalframenumber` |
| frame title | main.tex:24 | `slide.beamer-template` | `frametitle` template: `\vskip.25cm\hskip.35cm\insertframetitle\hfill\color{awesomeaccent}\insertsectionnumber`, then an accent rule `\rule{\dimexpr\paperwidth-.7cm\relax}{1.2pt}` |
| frame title spacing and rule | main.tex:24 | `sp.manual-space`, `sp.rule` | `\vskip.25cm`, `\hskip.35cm`, `\vskip.08cm`; `\rule` width `\paperwidth-.7cm`, height `1.2pt` |
| section divider frame (hook) | main.tex:25 | `slide.beamer-section-hook` | `\AtBeginSection[]{...}`: `frame[plain,noframenumbering]`, white `\usebeamerfont{title}`, `\insertsectionnumber.\ \insertsection` between `\vfill`s. The hook is the way; its TikZ body is the ART blocker below |
| section divider artwork | main.tex:25 | `art.tikz` (**ART**) | overlay `\fill` of `current page` in ink plus `\fill` triangle in accent via `++(-4cm,0)` |
| front-matter data | main.tex:27-31 | `front.class-native` | `\title[Designing for the handoff]{...}`, `\subtitle`, `\author[Your Name]{...}`, `\institute`, `\date{\today}` |
| title page frame | main.tex:33-40 | `front.class-native` | hand-laid `frame[plain]` (no `\titlepage`): `minipage{.68\paperwidth}`, `\usebeamerfont{title}`, `\inserttitle`, `\insertsubtitle`, `\Large`, `\vspace{.2cm}` / `{.6cm}`, `\hspace{.6cm}`, `\quad · \quad` separators |
| title page artwork | main.tex:34-38 | `art.tikz` (**ART**) | `tikzpicture[remember picture,overlay]`: ink fill of `current page`, accent triangle (south east, north east, north west), white `line width=1pt` rule from `[xshift=.8cm,yshift=.8cm]` to `[xshift=5.6cm,yshift=.8cm]` |
| title page text box | main.tex:39 | `box.minipage` | width `.68\paperwidth` |
| sectioning | main.tex:44, 55, 72 | `head.kernel` | `\section{...}`; beamer prints no heading, it feeds the agenda, `\insertsectionnumber` and the hook |
| agenda | main.tex:41-43 | `toc.kernel` | `\tableofcontents` in a titled frame (beamer's own implementation, no options) |
| tikz packages | main.tex:4, 7 | `art.tikz` | `tikz`; libraries `calc`, `positioning` (no `$(...)$` calc expression and no `below=of`-style positioning appears anywhere in main.tex, checked by grep) |
| block | main.tex:46-48 | `class.beamer` (native `block`) | title `Working thesis`; look set by `block title` / `block body` colours at main.tex:17-18 |
| columns | main.tex:50-53 | `class.beamer` (native `columns`) | `[T,onlytextwidth]`, two `\column{.48\textwidth}`; `cols.minipage` considered, not used because beamer's own environment is called |
| bullet lists | main.tex:51-52 | `list.kernel` | `itemize`, 3 items per column |
| numbered list | main.tex:74-78 | `list.kernel` | `enumerate`, 3 items |
| inline emphasis | main.tex:51-52 | `mark.kernel` | `\textbf{Before}`, `\textbf{After}`, `\bfseries` (main.tex:79) |
| text colour | main.tex:39, 79 | `color.xcolor` | `\color{white}`, `\color{awesomeaccent}`, `\color{awesomegray}` |
| font sizes | main.tex:39, 79 | `font.size-commands` | `\Large`, `\normalsize` |
| closing line layout | main.tex:79 | `sp.manual-space`, `sp.ragged` | `\vfill`, `\smallskip`, `\centering` |
| booktabs | main.tex:5 | `tbl.booktabs` | loaded, no table in the sample (no `tabular` in main.tex) |

Not present in the sample: theorems, floats and captions, tables, math, code, bibliography, index, hyperref options, language setup, speaker notes or handout mode.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local `.cls` / `.sty` | none in the zip | n/a | the zip is `README.md` and `main.tex` only |
| `\newcommand`, `\def`, counters, conditionals | none in main.tex | n/a | none defined |
| `footline` template body (`\hbox` of three `beamercolorbox`) | main.tex:23 | yes | `slide.beamer-template` with beamer's published `beamercolorbox` options and insert commands; no logic |
| `frametitle` template body | main.tex:24 | yes | `slide.beamer-template` + `sp.manual-space` + `sp.rule` (the `\dimexpr` is an e-TeX length expression inside `\rule`'s argument) |
| `\AtBeginSection` frame body with TikZ overlay | main.tex:25 | no | `slide.beamer-section-hook` limits the body to declarative beamer commands; a corner triangle drawn with `\fill ... -- ++(-4cm,0) -- cycle` is a TikZ drawing, so ART |
| hand-laid title frame with TikZ overlay | main.tex:33-40 | text part yes, drawing no | text part: `front.class-native` + `box.minipage` + `slide.beamer-template` fonts; the overlay at main.tex:34-38 is ART. A full-page ink fill alone could be `\setbeamercolor{background canvas}`, but the triangle and the white rule cannot be declarative |

## Content-opaque
- TikZ diagram "One screen, three signals" inside a frame (main.tex:56-71): rounded-corner panel, three coloured label bars, text nodes and an arrow. Judged as the slide's own illustrative picture, not a repeated template element, so it is content. The verdict does not depend on this call.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
