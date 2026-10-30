yes

# 0932-dunn-family-recipe-book: Dunn Family Recipe Book

- Unverified: read from the source, not compiled.
- Source: Source/0932-dunn-family-recipe-book/ (origin: https://latextemplates.com/downloads/dunn-family-recipe-book.zip; licence: not established, the manifest says UNKNOWN)
- Kind: book
- Lib: v6
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (the zip adds no class or style file; the colours, running head, title page and the `\recipe` macro are all in main.tex:1-14)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The zip is a 20-line `book` document with no zip-local `.cls`, `.sty` or other style file. Every preamble line is a published package or kernel command (main.tex:1-11). The one bespoke item is the five-argument `\recipe` macro (main.tex:12). It has no conditionals, counters or computation, and its whole effect is a composition of lib ways, so it reduces by inline expansion per recipe. There is no artwork and no external tool: main.tex never reads `recipes.json` (a grep for input, include, luacode, shell escape and datatool finds only the word "json" in running text at main.tex:19).

## Blockers
none

## Class setting
- Class: `class.book` options: `11pt`, `a4paper`, `openany` (main.tex:1). The class source is the kernel `book`, not bundled in the zip and not read.
- Class-native vocabulary used: `\chapter` (main.tex:15, 18), `\frontmatter` and `\mainmatter` (main.tex:14), `titlepage` environment (main.tex:14), `\tableofcontents` (main.tex:14), starred `\section*` (inside `\recipe`, main.tex:12), option `openany`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:1 | `class.book` | 11pt, a4paper, openany |
| paper and size | main.tex:1 | `page.class-options` | a4paper, 11pt |
| page geometry | main.tex:2 | `page.geometry` | margin=23mm |
| encoding | main.tex:3 | `font.fontenc-t1` | fontenc option T1 |
| text face | main.tex:4 | `font.lmodern` | `\usepackage{lmodern}`, no options |
| colour definitions | main.tex:5, 9 | `color.xcolor` | `\definecolor{plum}{HTML}{70435C}`, `\definecolor{leaf}{HTML}{627A4A}` |
| link and metadata package | main.tex:7 | `meta.hyperref` | loaded with no options, no `\hypersetup` |
| header/footer | main.tex:8, 10 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\fancyhead[LE,RO]{\small\textcolor{plum}{DUNN FAMILY RECIPES}}`, `\fancyfoot[C]{\thepage}` |
| running-head size and colour | main.tex:10 | `font.size-commands`, `color.xcolor` | `\small`; `\textcolor{plum}` |
| list layout | main.tex:6, 11 | `list.enumitem` | `\setlist{nosep,leftmargin=*}` |
| lists (ingredients) | main.tex:16, 17 | `list.kernel` | `itemize` with `\item`, inside the `\recipe` argument |
| line breaking, overfull-line tolerance | main.tex:11 | `sp.lengths` | `\setlength{\emergencystretch}{3em}` (a raw TeX length parameter) |
| line breaking, loose setting | main.tex:11 | `sp.hyphenat` | `\sloppy` |
| front-matter switches | main.tex:14 | `front.class-native` | `\frontmatter`, `\mainmatter` (book vocabulary) |
| title page | main.tex:14 | `front.titlepage-env` | `titlepage` environment holding the title, subtitle and tagline as hand-laid groups |
| title page alignment | main.tex:14 | `sp.ragged` | `\centering` |
| title page spacing | main.tex:14 | `sp.manual-space` | `\vspace*{35mm}`, `\vspace{8mm}`, `\vfill` |
| title page sizes | main.tex:14 | `font.size-commands` | `\Huge`, `\Large`, `\large` |
| title page colour | main.tex:14 | `color.xcolor` | `\color{plum}` |
| title page face | main.tex:14 | `mark.kernel` | `\sffamily\bfseries` (kernel font-switch commands) |
| contents | main.tex:14 | `toc.kernel` | `\tableofcontents` |
| chapter headings | main.tex:15, 18 | `head.kernel` | `\chapter{...}` in the book defaults, no renewed format |
| recipe heading | main.tex:12 | `head.kernel` | `\section*{#1}` |
| recipe contents entry | main.tex:12 | `toc.kernel` | `\addcontentsline{toc}{section}{#1}` (the kernel contents-writing command; the lib line names the reading commands, same kernel family) |
| recipe yield and time line | main.tex:12 | `color.xcolor`, `sp.manual-space` | `\textcolor{leaf}{#2\hfill#3}`, then `\par\medskip` |
| recipe two-column body | main.tex:12 | `box.minipage` | `minipage[t]{0.32\linewidth}` (ingredients) and `minipage[t]{0.62\linewidth}` (method), joined by `\hfill` |
| recipe column captions | main.tex:12 | `mark.kernel`, `sp.manual-space` | `\textbf{Ingredients}`, `\textbf{Method}`, each followed by `\par\smallskip` |
| recipe closing rule | main.tex:12 | `sp.rule`, `color.xcolor`, `sp.manual-space` | `\textcolor{plum}{\rule{\linewidth}{0.5pt}}`, with `\par\bigskip` before and `\par\medskip` after |
| degree sign in a method text | main.tex:17 | `font.fontenc-t1` | `\textdegree` (a text-symbol command; content) |

Not present in the sample, so no row: abstract, theorems, floats, tables, captions, code, notes, bibliography, index, cross-references, appendices, language setup. `meta.hyperref` is loaded but the sample sets no link colours or PDF metadata.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\recipe}[5]` (title, yield, time, ingredients, method) | main.tex:12 | yes | Inline expansion at each use (main.tex:16, 17): `\section*{title}` (`head.kernel`), `\addcontentsline{toc}{section}{title}` (`toc.kernel`), `\textcolor{leaf}{yield\hfill time}` (`color.xcolor`, `sp.manual-space`), `\par\medskip`, two `minipage[t]` of 0.32 and 0.62 `\linewidth` with `\hfill` between (`box.minipage`), `\textbf` captions and `\par\smallskip` (`mark.kernel`, `sp.manual-space`), then `\par\bigskip`, `\textcolor{plum}{\rule{\linewidth}{0.5pt}}`, `\par\medskip` (`sp.rule`, `color.xcolor`). No conditionals, counters, boxes measured by hand or output-routine code. |

## Content-opaque
none. (The recipe texts at main.tex:16-17 and the paragraph at main.tex:19 are content; the markdown-style backticks around recipes.json at main.tex:19 are content, not template.)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- `recipes.json` (4 lines) and `README.md` (5 lines) are not loaded by main.tex. The JSON shows a schema (name, category, serves, ingredients, method) for a generator outside this zip; the shipped document has its recipes written by hand, so it does not need an external tool.
- `recipe.xcookybooky` from the lib is not used by this zip and is not needed; the `\recipe` look is the inline expansion above.
- The only judgement call is filing `\addcontentsline` under `toc.kernel`; no lib line names it. If a reviewer rejects that, it is the single row that would need a proposal.
- No text addressed to an AI was found in the zip.
