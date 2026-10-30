no

# 0655-epfl-chili-poster-baposter: EPFL CHILI Poster (baposter)

- Unverified: read from the source, not compiled.
- Source: Source/0655-epfl-chili-poster-baposter/ (origin: https://latextemplates.com/downloads/epfl-baposter.zip; licence: LGPL-3.0 per LICENSE:1 and README.md:16; the class header itself says "Licence: GPL", baposter.cls:113)
- Kind: poster
- Lib: v5
- Engine: pdfLaTeX-compatible (`\pdfinfo` at main.tex:47 is a pdfTeX primitive; the class header says it is meant for pdftex, baposter.cls:8; no fontspec, no Lua)
- Look carried by: zip-local (baposter.cls draws the title strip, the grid placement and every block shape; main.tex only sets its keys and calls `\headerbox`)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (baposter.cls, all 1111 lines)

## Verdict
no. The look comes from `baposter.cls`, which is zip-local under the rubric's W1 rule: https://ctan.org/pkg/baposter returns 404 (not on CTAN), and the zip is a latextemplates.com copy of EPFL CHILI's GitHub pack, not the class author's own release (README.md:7-8, 20-21). The preamble of main.tex reduces to lib ways, but the class itself is a measure-then-place engine for the header boxes (`posterbox`, baposter.cls:854-981) plus TikZ-drawn block shapes, header shapes, borders, shading and title strip (baposter.cls:556-747, 986-1038, 1049-1087). That is irreducible bespoke layout code and template-defining artwork, and the lib line `poster.baposter` cannot stand in for it because this copy does not meet W1. If the project were to accept baposter as published, main.tex would map to the ways below plus `poster.baposter` and the answer would become yes with Look carried by: class; the blockers are tagged `class` so they can be re-read.

## Blockers
- `BESPOKE/class` `posterbox` measures each box's content in an `\hbox` holding a `minipage`, then computes its height and corners from the named TikZ coordinates of other boxes (`below`, `above=bottom`, `aligned`, `bottomaligned`, `height`), with the column arithmetic (baposter.cls:803-822, 879-884, 886-901, 903-981)
- `ART/class` poster block shapes: header shapes, text-box shapes, borders and shading are TikZ paths (baposter.cls:556-584, 592-648, 658-747, 986-1038), including paths the sample does not select (faded border drawn by a 100-step opacity loop, baposter.cls:643-644; coil and triangle snakes, baposter.cls:620, 623)
- `BESPOKE/class` the `poster` environment draws the eyecatcher, title, author and logo strip as TikZ nodes with computed widths (baposter.cls:1049-1087)

## Class setting
- Class: `class.article`, loaded by the zip-local `baposter.cls` (baposter.cls:116). There is no `class.baposter` way because the class is zip-local, not published. Options in main.tex:6: `landscape`, `a0paper`; both are consumed by the class's own `\DeclareOptionX` (baposter.cls:183, 213). How these global options also reach `article` and `geometry` was not traced (baposter.cls:250-252 says they are passed on).
- Class-native vocabulary used: `poster` environment with five arguments, options, eyecatcher, title, authors, logo (main.tex:56-94; baposter.cls:769); `\headerbox{title}{keys}{content}` (main.tex:96, 108, 123, 128, 142, 181, 205, 213; baposter.cls:848); box keys `name` `column` `row` `span` `below` `above` (main.tex:96-213); poster keys `colspacing` `bgColorOne` `bgColorTwo` `borderColor` `headerColorOne` `headerColorTwo` `headerFontColor` `boxColorOne` `boxColorTwo` `textborder` `headerborder` `headerheight` `headershape` `headershade` `headerfont` `boxshade` `background` `linewidth` (main.tex:57-74).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:6; baposter.cls:116 | `class.article` | loaded with no options by the zip-local class; poster options `landscape`, `a0paper` are the class's own |
| page geometry | baposter.cls:264-285, 213 | `page.geometry` | paperwidth, paperheight = 0.292 (fontscale, baposter.cls:171) times the a0paper size, i.e. 245.572mm and 347.188mm; tmargin, bmargin, lmargin, rmargin = 0.292 times 1.5cm (baposter.cls:238, 266-272); computed by the emitter |
| physical page scale | baposter.cls:287-296 | `pg.pgfpages` | `\pgfpagesuselayout{resize to}[physical paper width=..., physical paper height=...]` with the full a0paper size, width and height swapped for landscape (baposter.cls:288-290) |
| page style | baposter.cls:770 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| page background | main.tex:58-59, 73; baposter.cls:536-541 | `color.pagecolor` | `background=plain`, bgColorOne=white; the class paints it as a TikZ fill of the current page, which reduces to a page colour for `plain` only (the `shadeLR` and `shadeTB` values are TikZ shading, ART) |
| columns and grid | main.tex:57; baposter.cls:793-822 | none (`BESPOKE/class`) | 4 columns by default in landscape, colspacing=1em; width = (textwidth - colspacing*(columns-1)) / columns; not `cols.multicol`, the boxes are placed by coordinates |
| title strip | main.tex:76-94; baposter.cls:1049-1087 | none (`BESPOKE/class`) | title `\sf \vspace{5pt}` + `\papertitle` (main.tex:80-83), authors `\sf \Large \textbf{..}`, `\large`, two lines (main.tex:84-91), empty left and right logo slots (main.tex:76-79, 92-94); the class sets title at `\Huge` bold and authors at `\Large` (baposter.cls:1079-1080) |
| poster boxes | main.tex:96-217; baposter.cls:854-981 | none (`BESPOKE/class`) | `\headerbox` with name, column 0 to 3, row 0, span 1 or 2, below, above=bottom; content in a `minipage` of width boxwidth - 2*boxpadding (baposter.cls:889), padding 0.5em, cornerradius 1em (baposter.cls:367-369) |
| box shape, border, fill | main.tex:66, 72, 60, 64-65, 74; baposter.cls:571-573, 595-598, 628-630, 986-1038 | none (`ART/class`) | textborder=rounded, boxshade=plain with boxColorOne=white, borderColor=blue, linewidth=2pt |
| box header | main.tex:61-63, 67-71; baposter.cls:674-677, 700-702, 737-743, 1001-1007, 1025 | none (`ART/class`) | headershape=rounded, headerborder=open, headershade=plain with headerColorOne=skyblue, headerheight=0.12\textheight, headerfont=`\Large\textsf`, headerFontColor=black |
| fonts | main.tex:14 | `font.mathptmx` | `times`: Times roman, Helvetica sans (used by `\sf` and `\textsf`), Courier mono |
| encoding | main.tex:15; baposter.cls:159 | `font.fontenc-t1` | `inputenc` utf8; `fontenc` T1 from the class |
| font size | main.tex:21, 36, 71, 85, 87, 129, 178, 183, 194, 215 | `font.size-commands` | `\Large`, `\large`, `\small`, `\footnotesize`, `tiny` environment; `relsize` is loaded but none of its commands is used (main.tex:21) |
| inline marks | main.tex:71, 81, 85, 86, 100, 133, 190 | `mark.kernel` | `\sf`, `\textsf`, `\textbf`, `\textsc`, `\emph` |
| colour | main.tex:35, 42-45 | `color.xcolor` | `\selectcolormodel{cmyk}`; skyblue rgb 0.88,0.95,0.98; blue rgb 0.05,0.2,1; white rgb 1,1,1; black cmyk 0,0,0,1 (xcolor comes in through `tikz`) |
| PDF metadata | main.tex:47-52 | `meta.pdf-params` | `\pdfinfo{/Title (..) /Author (..) /Subject (..) /Keywords (..)}` with the four strings from `\papertitle` `\authorlist` `\papersubject` `\paperkeywords` (main.tex:30-33) |
| links | main.tex:17, 215 | `meta.url` | `url` loaded; `\url{https://github.com/example/shareless}` |
| math packages | main.tex:19, 20, 22 | `math.amsmath`, `math.amssymb`, `math.bm` | load-only; `\bm` used in main.tex:144-152 |
| display maths | main.tex:150-153 | `math.kernel` | `\[ ... \]` display, unnumbered |
| lists | main.tex:39-40, 113-120, 196-202 | `list.kernel`, `sp.lengths` | kernel `list` environment wrapped as `llist` and `llist2`: label `$\bullet$` or `$\triangleright$`, `\leftmargin=1em \itemindent=0em \parskip=0em \parsep=0pt` |
| reference list | main.tex:128-140 | `list.kernel`, `font.size-commands`, `sp.lengths` | hand-written `enumerate` inside `tiny`, `\setlength{\parskip}{-2mm}`, `\setlength\itemsep{0pt}`; no `thebibliography` |
| table | main.tex:184-192 | `tbl.tabular`, `tbl.booktabs` | `tabular{lcccc}` with `\toprule` `\midrule` `\bottomrule`, in `center` with `\small`; `array` and `multirow` are loaded, `\multirow` is not used (main.tex:23, 25) |
| figure and table captions | main.tex:178, 194 | `sp.ragged`, `font.size-commands` | no float and no `\caption`: the caption is a hand-typed `\centerline{\footnotesize Figure 1: ...}` line |
| bibliography | main.tex:16, 37 | `bib.natbib` | `natbib` with `numbers` is loaded; no `\cite` is used (the `[2]` at main.tex:111 is plain text); `\refname` is emptied with no `thebibliography` to print it |
| manual spacing | main.tex:81, 85, 90 | `sp.manual-space` | `\vspace{5pt}`, `\vspace{-3pt}`, `\vspace{0pt}` |
| other loaded packages | main.tex:18, 24, 26, 27; baposter.cls:153-164 | `cols.multicol`, `fig.graphicx`, `art.tikz` | loaded only: `multicol` and `graphicx` are never called in the sample; `tikz` also loads the class's libraries `decorations` `fadings` `snakes` `calc`; `calc`, `xkeyval` and `ifthen` are load-only helpers with no printed effect (as the rejected `sys.compat-load` in the lib log) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `baposter.cls` as a whole | baposter.cls:114-1111 | No | zip-local (not on CTAN, not an official release); the rows below say which parts reduce |
| `\LoadClass{article}`, package list, tikz libraries | baposter.cls:116, 153-164 | Yes | `class.article`, `font.fontenc-t1`, `art.tikz` |
| paper-size, margin and fontscale options, scaled geometry and pgfpages | baposter.cls:171-296 | Yes | `page.geometry` and `pg.pgfpages` with lengths the emitter computes (0.292 times paper size and margin) |
| xkeyval key tables and defaults | baposter.cls:341-514 | Yes as vocabulary | declarative keys, but they only configure the code in the rows below |
| background handlers | baposter.cls:522-548 | Partly | `plain` reduces to `color.pagecolor`; `shadeLR` and `shadeTB` are TikZ shading (ART); `user` runs arbitrary code |
| box shape, fill, border, header shape, shade and text handlers | baposter.cls:556-747 | No | TikZ path drawing, ART/class |
| `posterbox` measure-and-place engine | baposter.cls:803-981 | No | box-and-glue computation of heights and corners from other boxes' coordinates, BESPOKE/class; `poster.tcbposter` was considered for the grid, but nothing read here shows it reproduces header shapes and placement by neighbour, so no reduction is written |
| `poster` title strip | baposter.cls:1049-1087 | No | TikZ nodes with widths computed from boxes, BESPOKE/class |
| grid debug overlay | baposter.cls:1091-1107 | n/a | off by default (`grid=false`, baposter.cls:473); prints nothing |
| `\papertitle` `\authorlist` `\papersubject` `\paperkeywords` | main.tex:30-33 | Yes | inline expansion to strings (content) |
| `\captionfont` | main.tex:36 | Yes | alias of `\footnotesize`, never called; `font.size-commands` |
| `\renewcommand{\refname}{}` | main.tex:37 | Yes | no printed effect, there is no `thebibliography` |
| `llist`, `llist2` | main.tex:39-40 | Yes | `list.kernel` with `sp.lengths` as in the lists row; `llist2` is not used |
| `\definecolor{blue}`, `white`, `black` | main.tex:43-45 | Yes | `color.xcolor`; redefines names the class and TikZ also use |

## Content-opaque
- tikz picture in the Methodology box, an architecture diagram of nodes and arrows (main.tex:162-176)
- No text addressed to an AI was found in the zip.

## Lib changes
- New ways proposed: `meta.pdf-params` the pdfTeX primitive `\pdfinfo{/Title (..) /Author (..) /Subject (..) /Keywords (..)}`, engine pdf (pdfTeX only, as `meta.glyphtounicode`). W1: a primitive documented in the pdfTeX manual and shipped with TeX Live. W2: PDF Info keys and strings. W3: any document needs it. W4: one preamble line, no body wrapper. Considered `meta.hyperref` (`\hypersetup{pdftitle=...}`): a different command that needs hyperref loaded, so not a home for this line.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
