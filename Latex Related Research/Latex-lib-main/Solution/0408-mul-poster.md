yes

# 0408-mul-poster: MUL Poster

- Unverified: read from the source, not compiled.
- Source: Source/0408-mul-poster/ (origin: https://latextemplates.com/downloads/mul-poster.zip; licence: not established (manifest: "Unknown (no file-level grant verified)"; README.md:8-12 says the same and that no MUL class, logos or fonts are bundled))
- Kind: poster
- Lib: v4
- Engine: needs XeLaTeX (`fontspec` with `\setmainfont{TeX Gyre Heros}`, main.tex:4-5; LuaLaTeX would also serve); the font is not shipped in the zip (it ships with TeX Live as TeX Gyre), so note it as an asset the emitter relies on
- Look carried by: preamble (the sample's own preamble sets the palette and the beamer block templates, main.tex:8-16, over published `beamer` and `beamerposter`; everything else is beamer defaults)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; README.md is prose only)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex and README.md; the `beamer` and `beamerposter` sources are not in the zip and were not read)

## Verdict
Yes. The zip is one A0 poster written on the published `beamer` class with `beamerposter`; it ships no class, style, macro, environment, counter or conditional of its own. Its look is the preamble: three colours, beamer colour roles, one pair of `block begin`/`block end` templates built from `beamercolorbox`, and two full-width `beamercolorbox` bands in the body. All of it is `\setbeamertemplate`/`\setbeamercolor`/`\definecolor` with lengths and names. The one TikZ picture is a data plot, not template artwork, and is held as content. No external tool is needed; the only constraint is the XeLaTeX engine.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `final` (main.tex:2)
- Class-native vocabulary used: `frame[t]` (21), `columns[t,totalwidth=0.96\paperwidth]` and `column{width}` (27-28, 46, 72), `block{title}` (29, 33, 40, 47, 63, 73, 80, 84), `alertblock{title}` (58), `beamercolorbox[wd,sep,leftskip,rightskip]{colour-role}` (15, 22, 91), `\title` `\author` `\institute` (17-19) read back by `\inserttitle` `\insertauthor` `\insertinstitute` (23-24) and `\insertblocktitle` (15), `\setbeamertemplate{navigation symbols}|{block begin}|{block end}` (11, 15-16), `\setbeamercolor{normal text|block title|block body}` (12-14). The sample never calls `\maketitle`, `\titlepage` or `\frametitle`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2 | `class.beamer` | option `final` |
| poster paper size and scale | main.tex:3 | `poster.baposter` | beamerposter `size=a0`, `scale=1.12`; orientation not set (package default) |
| page geometry | main.tex:3, 27-28 | `poster.baposter` | no `geometry` call; paper size from beamerposter; column widths are fractions of `\paperwidth` |
| main font | main.tex:4-5 | `font.fontspec` | `\setmainfont{TeX Gyre Heros}`; no `\setsansfont` (beamer's own sans/serif choice is not read here) |
| font sizes | main.tex:15, 23, 24, 92 | `font.size-commands` | `\fontsize{43}{50}\selectfont` (title), `\Large` (block title, author line), `\small` (footer band); beamerposter `scale=1.12` |
| bold | main.tex:15, 23 | `mark.kernel` | `\bfseries` |
| palette | main.tex:8-10 | `color.xcolor` | `\definecolor{mulblack}{HTML}{202124}`, `{mulorange}{HTML}{E87511}`, `{mulgray}{HTML}{F3F4F5}` (xcolor is loaded by beamer) |
| beamer colour roles | main.tex:12-14 | `slide.beamer-template` | `normal text` fg=mulblack bg=white; `block title` fg=white bg=mulblack; `block body` fg=mulblack bg=mulgray |
| beamer chrome | main.tex:11 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` |
| block frame (all 8 `block`s) | main.tex:15-16 | `slide.beamer-template` | `block begin`: `beamercolorbox[wd=\linewidth,sep=0.65em]{block title}` with `\Large\bfseries\insertblocktitle`, then `\nointerlineskip`, then opens `beamercolorbox[wd=\linewidth,sep=0.9em]{block body}`; `block end`: closes it and adds `\vspace{0.9em}` |
| blocks in use | main.tex:29, 33, 40, 47, 63, 73, 80, 84 | `class.beamer` | `block` environment with a title string (vocabulary; looks come from the row above) |
| alert block | main.tex:58-61 | `class.beamer` | `alertblock` with a title string; the sample overrides only `block begin`/`block end` (15-16), not the alerted templates, so its look is beamer's default (beamer source not read) |
| title banner (box) | main.tex:22-25 | `slide.beamer-template` | `beamercolorbox[wd=\paperwidth,sep=1.7em,leftskip=2em,rightskip=2em]{block title}` |
| title banner (fields) | main.tex:17-19, 23-24 | `front.class-native` | `\title`, `\author`, `\institute` printed by `\inserttitle`, `\insertauthor`, `\insertinstitute`; no `\maketitle` |
| banner spacing | main.tex:23, 24, 26 | `sp.manual-space` | `\par\vspace{0.25em}`, `\hfill` between author and institute, `\vspace{1.2em}` below the banner |
| columns | main.tex:27-28, 46, 72 | `cols.minipage` | beamer `columns[t,totalwidth=0.96\paperwidth]` with three `column` of 0.31, 0.37, 0.25 `\paperwidth` (a fixed-width side-by-side box row; filed under `cols.minipage`, no new line needed) |
| frame (the one page) | main.tex:21, 94 | `class.beamer` | `frame[t]`, one frame holds the whole poster |
| footer band | main.tex:90-93 | `slide.beamer-template` | `beamercolorbox[wd=\paperwidth,sep=0.8em,leftskip=2em,rightskip=2em]{block title}`, text `\small ... \hfill ...`; a body box, not a page footer |
| footer spacing | main.tex:90, 92 | `sp.manual-space` | `\vfill` above the band, `\hfill` inside it |
| running header/footer | none | n/a | no `\setbeamertemplate{headline}` or `{footline}`; no `hf.*` way is used |
| ordered list | main.tex:34-38 | `list.kernel` | `enumerate` with `\itemsep0.5em` |
| bullet list | main.tex:74-78 | `list.kernel` | `itemize` with `\itemsep0.55em` |
| list spacing | main.tex:34, 74 | `sp.lengths` | raw `\itemsep` 0.5em and 0.55em |
| table | main.tex:64-69 | `tbl.tabular` | `tabular{lrrr}`, 4 columns, 3 body rows (cell text is content) |
| table rules | main.tex:6, 64-68 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule`; no caption, no float |
| centering | main.tex:48, 64 | `sp.ragged` | `\centering` inside a block and before the table |
| spacing in the method block | main.tex:57 | `sp.manual-space` | `\vspace{0.5em}` between plot and alert block |
| plot in the method block | main.tex:49-56 | `art.tikz` | content: `tikzpicture` with `x=1.25cm,y=1cm,>=Latex`, axes, two curves in mulorange and mulblack, two legend nodes (see Content-opaque) |
| TikZ setup | main.tex:6-7 | `art.tikz` | `\usepackage{tikz}`, `\usetikzlibrary{arrows.meta,positioning}` (only the picture above uses TikZ) |
| headings, abstract, contents | none | n/a | none defined or used; block titles replace headings |
| maths, theorems, code, notes, bibliography, index, cross-references, captions, language, metadata | none | n/a | none in the sample or the preamble (no `hyperref`, `babel` or `\hypersetup` call; beamer loads its own) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `block begin` template body (open-in-begin, close-in-end `beamercolorbox` pair) | main.tex:15-16 | yes | `slide.beamer-template`: two `beamercolorbox` calls with `wd=\linewidth`, `sep`, the colour roles `block title` / `block body`, `\Large\bfseries\insertblocktitle`, `\nointerlineskip`, `\vspace{0.9em}`. No counter, conditional or algorithm. `\nointerlineskip` is a one-token kernel vertical-spacing command in the body of the template (same family as `sp.manual-space`) |
| title and footer bands | main.tex:22-25, 91-93 | yes | `slide.beamer-template` (`beamercolorbox` with `wd`, `sep`, `leftskip`, `rightskip`, colour role) around `font.size-commands`, `mark.kernel` and `sp.manual-space` |
| zip-local macros, environments, counters, `\def`, `\newcommand` | none | n/a | main.tex defines none; no `.cls`, `.sty`, `.def`, `.cfg` in the zip |

## Content-opaque
- TikZ plot of two stress curves with axes and two legend nodes, in a `block` and not in a float (main.tex:49-56). Judged content, not `ART`: it is the poster's one data figure (stress against cycle), it draws no frame, banner or block shape of the template, and the template looks (blocks, bands, palette) come from beamer boxes. It uses the template colours `mulorange` and `mulblack`, which a figure emitter would have to keep defined.
- Table cell text and all prose, the author line text (main.tex:18-19), the footer string (main.tex:92).

## Lib changes
- New ways proposed: none. Considered and folded: a separate way for beamer's `beamercolorbox` (it is a `\setbeamertemplate`/`\setbeamercolor` family element and `slide.beamer-template` already takes free box code; same type of effect, as `slide.beamer-varbox` was merged there in v4) and for beamer `columns` (filed under `cols.minipage`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Class vocabulary for the consolidator (`class.beamer`): `frame[t]`, `columns`/`column`, `block`, `alertblock`, `beamercolorbox`, `\inserttitle` `\insertauthor` `\insertinstitute` `\insertblocktitle`, `\setbeamertemplate` `\setbeamercolor`.
