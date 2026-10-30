no

# 0115-concrete: Concrete (a beamer deck on the `clagrange` theme)

- Unverified: read from the source, not compiled.
- Source: Source/0115-concrete/ (origin: https://latextemplates.com/downloads/concrete-beamer.zip; licence: LPPL-1.3c)
- Kind: presentation
- Lib: v2
- Engine: pdfLaTeX-compatible (the sample loads `inputenc` utf8 and `fontenc` T1, main.tex:4-5, and nothing XeLaTeX-only; the engine needs of the theme are not established because its source is absent)
- Look carried by: zip-local (the look is the beamer theme `clagrange` named at main.tex:2; the zip does not ship its style file and ctan.org has no page for it, so by W1 it counts as an unpublished, unread style; the sample preamble adds no look of its own)
- Class origin: tex-distribution-unbundled (`beamer` is not in the zip; its source was not read; the theme is a style loaded by the class, not a class)
- Main file: main.tex (other samples: none)
- Read: main yes (all 79 lines), zip-local classes and styles none present (the zip holds only main.tex and titlepage.png, no .cls, .sty, .def, .cfg, .clo, .bbx or .cbx)

## Verdict
No. The zip is one 79-line `main.tex` and one PNG, and every look decision is delegated to `\usetheme{clagrange}` (main.tex:2). That theme's style file is not in the zip, and three reads of ctan.org/pkg (`beamertheme-clagrange`, `clagrange`, `beamerthemeclagrange`) all returned HTTP 404, so I can name no published source for it (W1) and cannot read it to show it reduces to `slide.beamer-theme` and `slide.beamer-template` calls. The rest of the deck (frames, columns, lists, one booktabs table, front matter) maps to lib ways and defines no bespoke macro. A wrong yes costs more than a wrong no, and "could an emitter write this preamble using only published packages" cannot be shown while the theme is unseen. NOTEMPLATE is arguable (the template proper, the theme, is absent); I record `UNMAPPED/class` because the class and a full sample are present and analysable. If the theme proved to be a published beamer theme, the deck would be a `yes` on the evidence below.

## Blockers
- `UNMAPPED/class` the beamer theme `clagrange` is the whole look (colours, head and foot lines, title-page layout, section navigation, item marks) and has no way I can name and justify against W1 to W4: not in the zip (only main.tex and titlepage.png), no CTAN page under three name guesses (HTTP 404 each), source unread (main.tex:2). It becomes `BESPOKE/class` if it is a zip-local style left out of this zip; irreducibility cannot be judged unseen.

## Class setting
- Class: `class.beamer` options: `xcolor={rgb}` (main.tex:1; a class option handed to `xcolor`). Source of beamer was not read (ships with the TeX distribution).
- Class-native vocabulary used: `frame` and `frame[plain]` with the title as the frame's argument (main.tex:16, 22, 32, 53, 71), `\subtitle` and `\institute` (main.tex:9, 11), `\titlepage` (main.tex:17), `\section` and `\subsection` as navigation entries (main.tex:20, 30, 51, 69), `columns[T]` and `column{0.48\textwidth}` (main.tex:33-48).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.beamer` | `xcolor={rgb}` |
| beamer theme | main.tex:2 | `slide.beamer-theme` | `\usetheme{clagrange}`; right by command type, but the named theme is unpublished and unread (see Blockers); no `\usecolortheme`, `\usefonttheme`, `\setbeamertemplate`, `\setbeamercolor` or `\setbeamerfont` in main.tex |
| input encoding | main.tex:4 | `font.fontenc-t1` | `inputenc`, option `utf8` |
| font encoding | main.tex:5 | `font.fontenc-t1` | `fontenc`, option `T1` |
| title, author, date | main.tex:8, 10, 12 | `front.maketitle` | `\title{Bridge Inspection Drones}`, `\author{Owen Bricknell}`, `\date{\today}` |
| subtitle, institute | main.tex:9, 11 | `front.class-native` | `\subtitle{A two-year pilot}`, `\institute{Department of Transport Infrastructure}` |
| title page | main.tex:16-18 | `front.class-native` | `\titlepage` inside `frame[plain]`; the layout of the title page is theme-defined (unread) |
| frames, frame titles | main.tex:16, 22, 32, 53, 71 | `class.beamer` (native) | `\begin{frame}{<title>}`, one frame per slide, `[plain]` on the first |
| sectioning | main.tex:20, 30, 51, 69 | `head.class-native` | `\section{Why Drones}`, `\subsection{Pilot Design}`, `\section{Findings}`, `\section{Recommendation}`; no `\titleformat` or `\renewcommand`; what is printed is the theme's navigation (unread) |
| two columns | main.tex:33-48 | `class.beamer` (native) | `columns[T]`, two `column{0.48\textwidth}` |
| bullet lists | main.tex:23-27, 36-39, 43-46 | `list.kernel` | `itemize`, defaults (item marks come from the theme) |
| numbered list | main.tex:72-76 | `list.kernel` | `enumerate`, defaults |
| bold run-in labels | main.tex:35, 42 | `mark.kernel` | `\textbf{Manual}`, `\textbf{Drone}` |
| table | main.tex:54-65 | `tbl.tabular` | `table` wrapper (no caption, no label), `tabular{lcc}`, one header row and three data rows |
| table rules | main.tex:6, 57, 59, 63 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| table centring | main.tex:55 | `sp.ragged` | `\centering` |

No page geometry, header or footer, spacing, font family, colour definition, language, hyperref, bibliography, theorem, code, box, figure or caption setting appears in main.tex (grep: preamble holds only lines 1-6 and the title block, 8-12).

## Bespoke code
None in main.tex (grep: no `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter`, `\newif`, TikZ, PGF, PSTricks or `picture`; the only packages are main.tex:4-6).

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `beamertheme clagrange` style (file not present) | named at main.tex:2 | not shown | cannot be judged unseen; the rubric asks for a written reduction and none can be written, so it blocks (`UNMAPPED/class`) |

## Content-opaque
- `titlepage.png` (600 x 840 PNG, 6881 bytes: a blue field with six pale arcs, viewed once). main.tex does not reference it (grep for `png`, `includegraphics`, `usebackground`: no match; `titlepage` matches only `\titlepage` at main.tex:17), so it is probably an asset of the unseen theme. Its role is unverified: used as a page or frame background it would reduce to `bg.background` or `bg.eso-pic`; drawn into the theme by TikZ it would be `ART`. It is not counted as a second blocker because the same unread theme decides it.
- Slide text, list items, table cell values and the closing paragraph (main.tex:24-26, 37-46, 58-62, 66, 73-75) are content.

## Lib changes
- New ways proposed: none (every row uses an existing way; CTAN reads used: 3 of 3, all HTTP 404)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
