yes

# 0929-mooerslab-compact-poster: MooersLab Compact Poster

- Unverified: read from the source, not compiled.
- Source: Source/0929-mooerslab-compact-poster/ (origin: https://latextemplates.com/downloads/mooerslab-compact-poster.zip; licence: MIT per the manifest; README.md:15-19 says the upstream repository is MIT-licensed and that this starter bundles no upstream class, images or personal content)
- Kind: poster
- Lib: v6
- Engine: pdfLaTeX-compatible (README.md:12 gives `lualatex main.tex`, but main.tex:1-6 loads only beamer, beamerposter, tikz, lmodern, booktabs and ragged2e; no `fontspec`, `unicode-math` or `luacode`; read, not compiled)
- Look carried by: preamble (the sample's own preamble sets the palette, the beamer colour roles, one `block alerted` template pair and one `\metric` macro, main.tex:8-17, over published `beamer` and `beamerposter`; everything else is beamer defaults)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; README.md is prose and one build line)
- Read: main yes (all 97 lines), zip-local classes and styles none present (the zip holds only main.tex and README.md; the `beamer` and `beamerposter` sources are not in the zip and were not read)

## Verdict
Yes. The zip is one A1 poster on the published `beamer` class with `beamerposter`; it ships no class, style, environment, counter or conditional. Its look is the preamble: three colours, three beamer colour roles, one `block alerted begin`/`end` template pair built from `beamercolorbox` and ragged2e, and one `\metric` alias for a boxed number tile. All of it reduces to `\setbeamertemplate`/`\setbeamercolor`/`\definecolor` calls and body wrappers with lengths and names. The one TikZ picture is a data plot inside a block, not template artwork, so it is held as content. No external tool is needed.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `final` (main.tex:1)
- Class-native vocabulary used: `frame[t]` (22), `columns[t,totalwidth=0.96\paperwidth]` and `column{width}` (28-29, 47, 77), `block{title}` (32, 36, 55, 66, 80, 87), `alertblock{title}` (48), `beamercolorbox[wd,sep,rounded,leftskip,rightskip]{colour-role}` (15, 17, 23), `\title` `\author` (with `\and`) `\institute` (18-20) read back by `\inserttitle` `\insertauthor` `\insertinstitute` (24-25), `\setbeamertemplate{navigation symbols}|{block alerted begin}|{block alerted end}` (14-16), `\setbeamercolor{normal text|block title|block body}` (11-13), `\usetheme{default}` (7). The sample never calls `\maketitle`, `\titlepage` or `\frametitle`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.beamer` | option `final` |
| poster paper size and scale | main.tex:2 | `poster.baposter` | beamerposter `size=a1`, `scale=1.15`; orientation not set (package default) |
| page geometry | main.tex:2, 28-29, 47, 77 | `poster.baposter` | no `geometry` call; paper size from beamerposter; column widths are fractions of `\paperwidth` (0.31, 0.36, 0.25) |
| theme | main.tex:7 | `slide.beamer-theme` | `\usetheme{default}` |
| text font | main.tex:4 | `font.lmodern` | `\usepackage{lmodern}`, no options |
| font sizes | main.tex:17, 23-25, 92 | `font.size-commands` | `\fontsize{34}{38}\selectfont` (metric number), `\fontsize{42}{48}\selectfont` (title), `\large` (metric label, institute), `\Large` (author line), `\small` (end-of-column note) |
| bold, monospace | main.tex:17, 20, 24, 92-93 | `mark.kernel` | `\bfseries`, `\textbf`, `\texttt` |
| palette | main.tex:8-10 | `color.xcolor` | `\definecolor{ink}{HTML}{17324D}`, `{teal}{HTML}{0B7285}`, `{mist}{HTML}{E8F1F5}` (xcolor is loaded by beamer) |
| inline text colour | main.tex:17 | `color.xcolor` | `\color{teal}` inside the metric number group |
| beamer colour roles | main.tex:11-13 | `slide.beamer-template` | `normal text` fg=ink bg=white; `block title` fg=white bg=ink; `block body` fg=ink bg=mist |
| beamer chrome | main.tex:14 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` |
| alerted block frame | main.tex:15-16 | `slide.beamer-template`, `sp.ragged` | `block alerted begin`: opens `beamercolorbox[rounded=true,sep=1.2em]{block body alerted}` then `\justifying` (ragged2e); `block alerted end`: `\end{beamercolorbox}`. The begin body never calls `\insertblocktitle`, so the title argument at line 48 is not printed by this template (read, not compiled); the colour role `block body alerted` is not set by the sample (beamer's own, source not read) |
| plain blocks (6) | main.tex:32, 36, 55, 66, 80, 87 | `class.beamer` | `block` with a title string (vocabulary); the sample does not override `block begin`/`block end`, so the look is beamer's default drawn with the colour roles at 12-13 |
| alert block | main.tex:48-53 | `class.beamer` | `alertblock` with a title string; look from the alerted template row above |
| metric tile (two uses) | main.tex:17, 30, 78 | `slide.beamer-template`, `font.size-commands`, `color.xcolor`, `mark.kernel`, `sp.ragged`, `sp.manual-space` | `\metric{number}{label}` expands to `beamercolorbox[rounded=true,sep=0.7em,wd=\linewidth]{block body}` holding `\centering`, a group `\fontsize{34}{38}\selectfont\color{teal}\bfseries <number>`, `\\[-2pt]`, a group `\large <label>` (see Bespoke code) |
| title banner (box) | main.tex:23-26 | `slide.beamer-template` | `beamercolorbox[wd=\paperwidth,sep=1.4em,leftskip=2em,rightskip=2em]{block title}` |
| title banner (fields) | main.tex:18-20, 24-25 | `front.class-native` | `\title`, `\author{.. \and ..}`, `\institute{.. \quad\texttt{..}}` printed by `\inserttitle`, `\insertauthor`, `\insertinstitute`; no `\maketitle` |
| banner and body spacing | main.tex:20, 24, 25, 27, 31, 54, 79, 91 | `sp.manual-space` | `\quad`, `\par\vspace{0.3em}`, `\hfill` between author and institute, `\vspace{1.1em}` below the banner, `\vspace{0.9em}` `\vspace{0.8em}` `\vspace{0.9em}` between column items, `\vfill` before the end-of-column note |
| columns | main.tex:28-29, 47, 77, 46, 76, 94-95 | `cols.minipage` | beamer `columns[t,totalwidth=0.96\paperwidth]` with three `column` of 0.31, 0.36, 0.25 `\paperwidth` (a fixed-width side-by-side box row) |
| frame (the one page) | main.tex:22, 96 | `class.beamer` | `frame[t]`; one frame holds the whole poster |
| ordered list | main.tex:40-44 | `list.kernel` | `enumerate`, three items |
| bullet list | main.tex:81-85 | `list.kernel` | `itemize`, three items |
| list spacing | main.tex:40, 81 | `sp.lengths` | raw `\itemsep0.25em` and `\itemsep0.45em` |
| table | main.tex:68-74 | `tbl.tabular` | `tabular{lrrr}`, header and two body rows (cell text is content) |
| table rules | main.tex:5, 69, 70, 73 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule`; no caption, no float |
| centering | main.tex:56, 67 | `sp.ragged` | `\centering` inside two blocks (the plot block and the table block) |
| end-of-column note | main.tex:92-93 | `font.size-commands`, `mark.kernel`, `sp.manual-space` | `\small`, `\textbf{Code/data:}` `\textbf{Acknowledgements:}`, `\\` |
| justified text | main.tex:6, 15 | `sp.ragged` | `\usepackage{ragged2e}` and `\justifying` (loaded once, called only in the alerted template) |
| plot in a block | main.tex:57-64 | `art.tikz` | content: `tikzpicture[x=1cm,y=1cm]` with axes, a smooth curve, a dashed threshold line, a filled window and a node (see Content-opaque) |
| TikZ setup | main.tex:3 | `art.tikz` | `\usepackage{tikz}` (only the picture above uses it; no `\usetikzlibrary`) |
| running header or footer | none | n/a | no `headline` or `footline` template; no `hf.*` way |
| headings, abstract, contents, maths, theorems, floats, captions, code, notes, bibliography, index, cross-references, language, metadata | none | n/a | none in the sample or the preamble (no `hyperref`, `babel` or `\hypersetup` call; beamer loads its own; block titles replace headings) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\metric[2]` macro | main.tex:17 | yes | `\newcommand` alias with no counter or conditional: expand inline at each call (30, 78) as `slide.beamer-template` `beamercolorbox` (`rounded=true`, `sep=0.7em`, `wd=\linewidth`, role `block body`) around `sp.ragged` `\centering`, `font.size-commands` `\fontsize{34}{38}\selectfont`, `color.xcolor` `\color{teal}`, `mark.kernel` `\bfseries`, `sp.manual-space` `\\[-2pt]`, `\large`; the number and the label are the two node texts |
| `block alerted begin` / `block alerted end` templates | main.tex:15-16 | yes | two `\setbeamertemplate` lines: `beamercolorbox` opened in the begin body and closed in the end body, plus ragged2e `\justifying`; no counter, conditional or algorithm; an emitter writes them as two preamble lines |
| title banner box | main.tex:23-26 | yes | `beamercolorbox` with lengths and role around `font.size-commands`, `mark.kernel`, `sp.manual-space`; `\inserttitle` `\insertauthor` `\insertinstitute` read the `\title` `\author` `\institute` fields |
| zip-local classes, styles, environments, counters, `\def` | none | n/a | no `.cls`, `.sty`, `.def` or `.cfg` in the zip; main.tex defines only the one `\newcommand` above (line 17) |

## Content-opaque
- TikZ plot of a signal curve, a dashed threshold and a shaded window, in a `block` and not in a float (main.tex:57-64). Judged content, not `ART`: it is the poster's one data figure (README.md:18-19 calls the diagrams and examples original synthetic material), it draws no frame, banner or block shape of the template, and the template looks (blocks, bands, palette) come from beamer boxes. It uses the template colours `teal` and `ink`, which a figure emitter would have to keep defined (`\definecolor`, main.tex:8-9).
- Table cell text (main.tex:70-72), all prose, the author and institute strings (main.tex:19-20), the metric numbers and labels (main.tex:30, 78), the end-of-column note text (main.tex:92-93).

## Lib changes
- New ways proposed: none. Considered and folded: beamer's `beamercolorbox` as a box way of its own (it is a `\setbeamercolor` family element and `slide.beamer-template` already takes free box code), and beamer `columns` (filed under `cols.minipage`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Class vocabulary for the consolidator (`class.beamer`): `frame[t]`, `columns`/`column`, `block`, `alertblock`, `beamercolorbox`, `\inserttitle` `\insertauthor` `\insertinstitute`, `\setbeamertemplate` `\setbeamercolor`, `\usetheme`.
