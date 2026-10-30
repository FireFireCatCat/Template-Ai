no

# 0925-bibliogon-comic-book: Bibliogon Comic Book (comic-book starter)

- Unverified: read from the source, not compiled.
- Source: Source/0925-bibliogon-comic-book/ (origin: https://latextemplates.com/downloads/bibliogon-comic-book.zip; licence: MIT)
- Kind: book
- Lib: v6
- Engine: pdfLaTeX-compatible (README.md:6 says to compile with pdfLaTeX; no fontspec or unicode-math is loaded)
- Look carried by: preamble (no zip-local class or style exists; colours, running heads and the two TikZ macros `\panel` and `\speech` are all defined in main.tex:1-32 over the stock `book` class)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; the zip holds only main.tex and README.md)
- Read: main yes, zip-local classes and styles none present

## Verdict
The page setup, colours, running heads, title page, sectioning, contents, lists and the boxed caption all map to lib ways (`class.book`, `page.geometry`, `hf.fancyhdr`, `color.xcolor`, `head.kernel`, `box.fancybox` and others). The template's identity, though, is the comic panel and the speech balloon, and both are drawn with TikZ inside two zip-local `\newcommand` macros (main.tex:20-32). They are template-defining artwork with no declarative lib way (`art.tikz` is a Restricted way: ART when it draws the template's identity). The balloon tail is a hand-written `\draw` path (main.tex:31). The answer is `no`.

## Blockers
- `ART/preamble` `\panel`: comic panel frame, a TikZ node with a border and a corner label tab, used for every panel (main.tex:20-27; used at main.tex:53, 54, 59, 60)
- `ART/preamble` `\speech`: speech balloon, a rounded TikZ node plus a hand-drawn triangular tail path `\draw[ink, thick] (b.south west) -- ++(-5pt,-8pt) -- (b.south east)` (main.tex:28-32, tail at main.tex:31; used at main.tex:56, 57)

## Class setting
- Class: `class.book` options: `11pt` (main.tex:1). The class is a published LaTeX base class that is not bundled in the zip; its source was not read.
- Class-native vocabulary used: `\frontmatter` (main.tex:34), `\mainmatter` (main.tex:50), `\backmatter` (main.tex:81), `\chapter` (main.tex:51, 64) and `\chapter*` (main.tex:45, 74, 82), `\section` (main.tex:65, 71) and `\section*` (main.tex:52, 58), `titlepage` environment (main.tex:35-44), `\tableofcontents` (main.tex:49), `\addcontentsline{toc}{chapter}{..}` (main.tex:75).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.book` | 11pt; `\frontmatter` `\mainmatter` `\backmatter` switch page numbering and chapter numbering (class behaviour, no source line beyond the three commands) |
| paper and size | main.tex:1 | `page.class-options` | `11pt` (no paper option, so the class default) |
| page geometry | main.tex:2 | `page.geometry` | margin=0.7in |
| colour definitions | main.tex:4, 9-11 | `color.xcolor` | `\definecolor` model HTML: ink=17202A, paper=FFF9ED, accent=D35400 |
| page background colour | main.tex:12 | `color.pagecolor` | `\pagecolor{paper}` |
| default text colour | main.tex:13 | `color.xcolor` | `\color{ink}` |
| running heads | main.tex:6, 14-19 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}` clears all fields; head `[LE,RO]` = page number, `[RE]` = `\nouppercase{\leftmark}`, `[LO]` = `\nouppercase{\rightmark}`; `\headrulewidth`=0.4pt; no footer fields |
| head field fonts | main.tex:16-18 | `font.size-commands`, `mark.kernel` | `\small` (size); `\sffamily` (kernel font-switch) |
| microtype | main.tex:7 | `sp.microtype` | load-only, no options |
| hyperlinks | main.tex:8 | `meta.hyperref` | option `hidelinks` |
| graphicx | main.tex:5 | `fig.graphicx` | load-only; the sample has no `\includegraphics` or figure float |
| TikZ package | main.tex:3 | `art.tikz` | loaded for the two macros below (ART) |
| comic panel macro | main.tex:20-27 | `art.tikz` | node: `draw=ink`, `line width=1.2pt`, `fill=white`, `minimum width=0.43\textwidth`, `minimum height=2.7cm`, `align=center`, `inner sep=8pt`, text `\sffamily\Large #1`; label node: `anchor=south west` at `(p.south west)`, `fill=ink`, `text=white`, `font=\scriptsize\sffamily`, `inner sep=3pt`, text `#2` (ART) |
| speech balloon macro | main.tex:28-32 | `art.tikz` | `baseline=(b.base)`; node: `draw=ink`, `fill=white`, `rounded corners=5pt`, `inner sep=5pt`, `text width=0.30\textwidth`, `align=center`, text `\sffamily #1`; tail: `\draw[ink, thick]` SW corner, `++(-5pt,-8pt)`, SE corner (ART) |
| panel grid in body | main.tex:53-55, 59-61 | `sp.lengths`, `sp.manual-space` | `\noindent` (per-paragraph indent switch, nearest way `sp.lengths`), `\hfill` between two `\panel` calls, `\par\medskip`; the panels themselves are ART |
| balloon row in body | main.tex:56-57 | `sp.lengths`, `sp.manual-space` | `\noindent`, `\hfill` between two `\speech` calls |
| title page | main.tex:35-44 | `front.titlepage-env` | `titlepage` environment laid out by hand; no `\maketitle`, `\title` or `\author` is used |
| title page alignment and spacing | main.tex:36-37, 39-41, 43 | `sp.ragged`, `sp.manual-space` | `\centering`; `\vspace*{1.3in}`, `\\[4pt]`, `\vspace{12pt}`, `\vspace{22pt}`, `\vfill`, `\vspace{6pt}` |
| title page type | main.tex:38, 40, 42-43 | `font.size-commands`, `mark.kernel` | `\fontsize{42}{46}\selectfont`, `\Large`, `\large`; `\sffamily\bfseries`, `\textbullet`; `\the\year` prints the compile year (a TeX primitive value, treated as content text) |
| title page rule | main.tex:39 | `sp.rule`, `color.xcolor` | `\rule{0.72\textwidth}{4pt}` inside `\textcolor{accent}{..}` |
| unnumbered front chapters | main.tex:45, 74, 82 | `head.kernel` | `\chapter*{Credits}`, `\chapter*{Issue notes}`, `\chapter*{Colophon}`; default `book` chapter look, no heading package |
| numbered chapters and sections | main.tex:51, 52, 58, 64, 65, 71 | `head.kernel` | `\chapter`, `\section`, `\section*`; no `\titleformat`, no counter changes |
| contents list | main.tex:49, 75 | `toc.kernel` | `\tableofcontents`; `\addcontentsline{toc}{chapter}{Issue notes}` adds the starred chapter by hand |
| description list | main.tex:66-70 | `list.kernel` | `description` with `\item[label]` |
| itemize list | main.tex:76-80 | `list.kernel` | `itemize`, default bullets |
| caption box | main.tex:62-63 | `box.fancybox`, `box.minipage`, `sp.ragged`, `mark.kernel` | `\fbox{\parbox{0.82\textwidth}{\centering\sffamily\itshape ..}}` inside a `center` environment |
| logo and symbol commands | main.tex:43, 83 | `mark.kernel` | `\textbullet`, `\LaTeX{}` (kernel text commands) |
| fonts | main.tex (none) | none needed | no font package: kernel default Computer Modern, `\sffamily` for sans |

Not present in the sample: abstract, math, theorems, floats and captions, tables, code, notes, bibliography, index, cross-references.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\panel[2]` (TikZ comic panel: bordered node plus corner label tab) | main.tex:20-27 | No (ART) | Not shown reducible. `box.tcolorbox` with `attach boxed title to bottom left` was considered, but an inside-corner tab with a fixed outer width is TikZ node anchoring, and `overlay` code is TikZ, not declarative. Not claimed. |
| `\speech[1]` (TikZ rounded node plus hand-drawn tail) | main.tex:28-32 | No (ART) | No lib way draws a speech-balloon pointer; the tail is a three-point `\draw` path (main.tex:31). |
| `\definecolor` x3 | main.tex:9-11 | Yes | `color.xcolor`, HTML values above |
| `\fancyhf` and `\fancyhead` settings | main.tex:15-19 | Yes | `hf.fancyhdr`, fields above |

## Content-opaque
none (the panel captions, dialogue, credits, story-bible text and the title string are text content; the two TikZ macros are template artwork, listed as blockers, not content)

## Lib changes
- New ways proposed: none (considered: `tcolorbox` for the panel, not proposed; the existing `box.tcolorbox` does not remove the speech-balloon ART blocker)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
