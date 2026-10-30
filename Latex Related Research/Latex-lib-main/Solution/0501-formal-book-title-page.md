yes

# 0501-formal-book-title-page: Formal Book Title Page

- Unverified: read from the source, not compiled.
- Source: Source/0501-formal-book-title-page/ (origin: https://latextemplates.com/downloads/formal-book-title-page.zip; licence: not established, the manifest says "N/A — original starter, no upstream package")
- Kind: book (a book's front cover and copyright page; the manifest hint `misc` is only the source category)
- Lib: v4
- Engine: pdfLaTeX-compatible (no fontspec, no Lua, no shell escape; the TikZ overlay as written needs two passes for `remember picture`, main.tex:14)
- Look carried by: preamble (the zip holds one file, main.tex, and no class or style; the look is its preamble, main.tex:1-7, and its body, main.tex:14-51, over kernel `article`)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes (all 53 lines), zip-local classes and styles none present (the zip holds only main.tex; `ls -R` shows no .cls .sty .def .cfg .clo)

## Verdict
yes, with one stated judgment call. The zip is a single 53-line file over kernel `article`: no zip-local macro, environment, counter or style exists (grep for `\newcommand`, `\def`, `\let`, `\newenvironment`, `\newcounter`, `\usetikzlibrary`, `\tikzset` finds nothing). The cover is written as a TikZ overlay (main.tex:14-23), which is the only construct that could be read as template artwork. It holds exactly two primitives: a rectangle filling the whole page with one colour (main.tex:15) and one centred text box (main.tex:16-22). The first reduces to `color.pagecolor`, the second to a hand-laid `titlepage` with a `minipage`, so the picture has no drawing that a lib way cannot hold. That is the "reduces to a lib way with declarative parameters" exception of the rubric's artwork rule. A stricter reader who counts any TikZ cover as ART would turn this to `no`; the same call was made for flat rectangles in 0333-e-ink-planner.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:1). Kernel class from the TeX distribution, not in the zip; its source was not read.
- Class-native vocabulary used: none (no `\maketitle`, no `abstract`, no sectioning; the two pages are hand-laid)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | `a4paper` |
| paper size | main.tex:1 | `page.class-options` | `a4paper` |
| page geometry, cover page | main.tex:3 | `page.geometry` | `margin=0cm` (text block = whole sheet, so the cover content is positioned against the paper) |
| page geometry, copyright page | main.tex:26 | `page.geometry` | `\newgeometry{margin=2.5cm}` (same package; `\newgeometry` starts the new geometry after the page break at main.tex:24) |
| colours | main.tex:4,15,16 | `color.xcolor` | `\usepackage{xcolor}`; colour expression `green!25!black` (25 percent green mixed with black); `white` for the text |
| running heads and page numbers | main.tex:7,27 | `hf.pagestyle-kernel` | `\pagestyle{empty}` for the document, `\thispagestyle{empty}` on the copyright page |
| TikZ package and overlay, as written | main.tex:5,14-23 | `art.tikz` | `tikzpicture[remember picture, overlay]` with `current page` anchors; used as a page-anchored container only, no path or shape beyond one rectangle; reduces to the next three rows, so no ART remains (see Bespoke code) |
| full-bleed cover colour (reduction of the `\fill`) | main.tex:15 | `color.pagecolor` | `\pagecolor{green!25!black}` for the cover page, `\nopagecolor` after the page break at main.tex:24 |
| cover page container (reduction of the picture) | main.tex:14-23,24 | `front.titlepage-env` | one hand-laid page: `\vspace*{\fill}` above and below the title block centres it vertically (the node sits at `current page.center`) |
| title block width (reduction of the node) | main.tex:16 | `box.minipage` | width `0.75\paperwidth`, centred on the page, text `align=center` |
| centred text | main.tex:16 | `sp.ragged` | `\centering` (the node's `align=center`) |
| title block text colour | main.tex:16 | `color.xcolor` | `\color{white}` (the node's `text=white`) |
| title block sizes | main.tex:17,18,20,21 | `font.size-commands` | `\Large` (kicker, author), `\huge` (title), `\large` (publisher) |
| title block shapes | main.tex:17,18 | `mark.kernel` | `\itshape` (kicker), `\bfseries` (title) |
| title block vertical gaps | main.tex:17-20 | `sp.manual-space` | `\\[4mm]` (kicker to title, main.tex:17), `\\[2mm]` (the break between the two title lines, main.tex:18), `\\[10mm]` (title to rule, main.tex:18), `\\[10mm]` (rule to author, main.tex:19), `\\[2mm]` (author to publisher, main.tex:20) |
| divider rule under the title | main.tex:19 | `sp.rule` | `\rule{0.35\linewidth}{0.6pt}` (width given relative to `\linewidth`; what `\linewidth` equals inside a TikZ node with `text width` was not checked here, so an emitter states the rule width as an explicit length, a parameter value; in a `minipage` it is the minipage width) |
| page break between the two pages | main.tex:24 | `pg.break` | `\newpage` |
| copyright page, as a hand-laid page | main.tex:26-51 | `front.dedication` | a copyright page: title in small caps, copyright line, rights notice, edition line, publisher address; no environment, laid out in the document flow |
| copyright page vertical centring | main.tex:29,51 | `sp.manual-space` | `\vspace*{\fill}` above and below the block |
| copyright page paragraph gaps | main.tex:33,36,43,46 | `sp.manual-space` | `\medskip` (kernel vertical skip, same family as `\addvspace`) |
| copyright page address lines | main.tex:47-49 | `sp.manual-space` | `\\` line breaks inside one paragraph |
| no first-line indent | main.tex:31,34,37,44,47 | `sp.lengths` | `\noindent` on every paragraph; equivalent to `\setlength{\parindent}{0pt}` for the page |
| small-caps title line | main.tex:31 | `mark.kernel` | `\textsc{...}` |
| copyright sign | main.tex:34 | content | `\textcopyright` is a kernel text symbol inside running text; no package, no way needed |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| TikZ overlay picture: one full-page `\fill` rectangle and one centred text node | main.tex:14-23 | yes (judgment call) | Not a drawing: a flat colour over the whole sheet is the page background colour, `\pagecolor{green!25!black}` (`color.pagecolor`), cleared by `\nopagecolor` after the page break; the node is a text block placed at the page centre, which is a `titlepage` page with `\vspace*{\fill}` above and below and a `\centering` `minipage` of width `0.75\paperwidth` (`front.titlepage-env`, `box.minipage`, `sp.ragged`, `sp.manual-space`) holding the same text with `\color{white}`, `\Large\itshape`, `\huge\bfseries`, `\rule`. `remember picture` and its second pass disappear with the picture. Nothing zip-local is copied. |
| zip-local macros, environments, counters, conditionals | none | not applicable | grep of main.tex finds only the three `\usepackage` lines (main.tex:3-5) |

## Content-opaque
none (the cover text, the rights notice and the address are text content; the TikZ picture is not content-opaque because it is the cover's own design, and it is handled above)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
