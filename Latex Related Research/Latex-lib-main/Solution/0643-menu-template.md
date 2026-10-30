yes

# 0643-menu-template: Menu Template

- Unverified: read from the source, not compiled.
- Source: Source/0643-menu-template/ (origin: https://latextemplates.com/downloads/menu-template.zip; upstream page https://www.overleaf.com/latex/templates/menu-template/zvvtbqkzzbyp per README.md:7 and ATTRIBUTION.txt:4; licence: CC-BY-4.0 per the manifest and ATTRIBUTION.txt:3)
- Kind: misc (a one-page restaurant menu; the manifest hint is also misc)
- Lib: v5
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (two `\newcommand` macros and three colours at main.tex:8-11, plus hand-laid body blocks at main.tex:13-26; no zip-local class or style)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip is three files (main.tex 27 lines, README.md, ATTRIBUTION.txt) and ships no class, style, font or image. Everything is kernel `article` plus `geometry`, `fontenc`, `lmodern`, `xcolor`, kernel font, colour, rule and spacing commands, and two one-line `\newcommand` aliases (main.tex:10-11) that expand to those commands. The only template-defining drawing is one TikZ rectangle that frames the page (main.tex:13). It is a plain outline set by an inset, a line width and a colour, which the rubric names as reducible (a page frame), so it reduces to an `eso-pic` overlay holding an `\fbox`-type rule box and is not an `ART` blocker. The verdict hangs on that one ruling; everything else is routine.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `12pt` (main.tex:1). The class is the kernel one and is not in the zip, so its source was not read.
- Class-native vocabulary used: none. The sample uses no `\maketitle`, no `abstract`, no `\section`; only the kernel `center` environment (main.tex:14, main.tex:25-26).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | a4paper, 12pt |
| paper and base size | main.tex:1 | `page.class-options` | a4paper, 12pt |
| page geometry | main.tex:2 | `page.geometry` | margin=20mm (all four sides) |
| header/footer | main.tex:9 | `hf.pagestyle-kernel` | `\pagestyle{empty}`: no running head, no page number |
| font encoding | main.tex:3 | `font.fontenc-t1` | `T1`; no `inputenc` line, the UTF-8 accents at main.tex:17 and the middle dot at main.tex:14 rely on the kernel UTF-8 default |
| text face | main.tex:4 | `font.lmodern` | `lmodern`; the sans face used at main.tex:10 and main.tex:14 is lmodern's `\sffamily` |
| colour | main.tex:5, main.tex:8 | `color.xcolor` | `\definecolor` in the HTML model: ink 263238, gold B7832D, wine 743B4A; applied with `\color` and `\textcolor` at main.tex:10, 11, 14, 25, 26 |
| paragraph shape | main.tex:9 | `sp.lengths` | `\parindent` = 0pt |
| tables (load only) | main.tex:6 | `tbl.tabular` | `array` is loaded and no `tabular` appears in the body; nothing to emit |
| page frame | main.tex:7, main.tex:13 | `bg.eso-pic`, `box.fancybox` | by reduction (see Bespoke code): gold rectangle outline, 1pt rule, 12mm inside each page edge |
| title block | main.tex:14 | `sp.ragged`, `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.manual-space` | `center` environment; `\vspace*{7mm}`; name in `\fontsize{30}{34}\selectfont`, `\sffamily\bfseries`, wine; `\smallskip`; tagline `\large`; gold line "Friday evening `\quad` · `\quad` Spring table" |
| section headings | main.tex:10, 15, 18, 22 | `head.titlesec` | by reduction (see Bespoke code); three unnumbered headings, `\large\sffamily\bfseries` wine, 6mm above, 2mm below, gold rule underneath |
| heading rule | main.tex:10 | `sp.rule` | `\rule{\linewidth}{0.7pt}` coloured gold by `\textcolor` |
| menu entry (dish, price, description) | main.tex:11, 16-17, 19-21, 23-24 | `mark.kernel`, `sp.manual-space`, `color.xcolor`, `font.size-commands` | `\textbf` name, `\hfill`, price in gold, `\par`, `\hspace{4mm}` indent, `\small` description, `\vspace{3mm}` (7 entries) |
| closing note | main.tex:25-26 | `sp.ragged`, `sp.manual-space`, `color.xcolor` | `center`; `\vfill` pushes the block to the page foot; note in ink; `\smallskip`; gold line with `\quad` · `\quad` |
| end of document | main.tex:12, main.tex:27 | `class.article` | plain `document` environment |

Considered, not used: `menu.menucard` (the lib's restaurant-menu package; the sample does not load it) and `bg.fancybox` (see the frame reduction).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\menusection{#1}` | main.tex:10 | yes | Whole effect is `\vspace{6mm}`, `{\large\sffamily\bfseries\color{wine}#1}`, `\par`, a gold `\rule{\linewidth}{0.7pt}`, `\vspace{2mm}`: `sp.manual-space`, `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.rule`. It stays a `\newcommand` alias, or an emitter maps a heading node to `head.titlesec`: `\titleformat{\section}[block]{\large\sffamily\bfseries\color{wine}}{}{0pt}{}[\textcolor{gold}{\rule{\linewidth}{0.7pt}}]` with `\titlespacing*{\section}{0pt}{6mm}{2mm}` and the starred (unnumbered) call. Sketch, not compiled. |
| `\dish{#1}{#2}{#3}` | main.tex:11 | yes | Whole effect is `\textbf{#1}\hfill\textcolor{gold}{#2}\par\hspace{4mm}\small #3\par\vspace{3mm}`: `mark.kernel`, `sp.manual-space`, `color.xcolor`, `font.size-commands`. A three-argument alias with no counters, conditionals or boxes. |
| `\definecolor` x3 | main.tex:8 | not bespoke | `color.xcolor` declarations. |
| TikZ page-frame overlay | main.tex:13 (`tikz` loaded at main.tex:7) | yes (`ART` considered and not raised) | One `\draw[gold,line width=1pt]` from `[xshift=12mm,yshift=-12mm]current page.north west` to `[xshift=-12mm,yshift=12mm]current page.south east`: a rectangle outline with three values (inset 12mm, rule 1pt, colour gold) and no other drawing. Reduction: `eso-pic` `\AddToShipoutPictureBG*` overlay (`bg.eso-pic`) holding a kernel `\fbox`-type box (`box.fancybox`: `\fboxrule`=1pt, `\fboxsep`=0, `\color{gold}`) of width `\paperwidth` minus 24mm and height `\paperheight` minus 24mm, placed 12mm from the lower-left corner. The `tikz` load can then be dropped. The rule is centred on the path in TikZ and drawn inside the box edge by `\fbox`, a 0.5pt offset. Sketch, not compiled; the `eso-pic` source was not read. The `fancybox` page-boxing route (`bg.fancybox`) is not chosen: its CTAN page (ctan.org/pkg/fancybox) says pages can be boxed but names no page command, so a 12mm inset to the page edge is not established through it. |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
