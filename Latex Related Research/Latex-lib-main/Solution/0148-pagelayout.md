yes

# 0148-pagelayout: pagelayout (declarative page, grid, cover and graphic layout class)

- Unverified: read from the source, not compiled.
- Source: Source/0148-pagelayout/ (origin: https://mirrors.ctan.org/macros/latex/contrib/pagelayout.zip; licence: LPPL 1.3c, README.md:103)
- Kind: misc (a page-composition class for photo books, covers and print layouts; the main sample is a grid demo)
- Lib: v3
- Engine: pdfLaTeX-compatible (main sample loads only the class and `lipsum`, no `fontspec`; the class has one LuaTeX branch, tex/pagelayout.cls:74, and the author's tests default to xelatex, scripts/textestvis:406; pdfLaTeX is not established by reading; doc/banner.tex:17 and doc/quickstart.tex:17 need `fontspec`)
- Look carried by: class (the sample's preamble only assigns class lengths and a guide switch, doc/example-grid.tex:18-22; everything else is the class's own page, grid and cell vocabulary)
- Class origin: ctan (`pagelayout` 1.1.1, 2024/07/31, tex/pagelayout.cls:16; ctan.org/pkg/pagelayout read: /macros/latex/contrib/pagelayout, LPPL 1.3c)
- Main file: doc/example-grid.tex (other samples: doc/example-book.tex, doc/example-template.tex, doc/example-text.tex, doc/example-graphic.tex, doc/example-borders-and-shadows.tex, doc/quickstart.tex, doc/banner.tex, doc/pagelayout-manual-layout-guides.tex; doc/pagelayout-manual.tex is the class manual under `ltxdoc`, not a sample)
- Read: main yes, zip-local classes and styles all (tex/pagelayout.cls, 4070 lines, every line read; it is the CTAN class itself; scripts/pagelayoutapi and scripts/textestvis only grepped, plus the pagelayoutapi man page)

## Verdict
The zip is the CTAN distribution of the published class `pagelayout`, and the main sample defines nothing of its own: a `\documentclass{pagelayout}` line, `lipsum`, three length assignments, one guide switch, then `\page`/`\setgrid`/`\text`/`\graphic`/`\place` calls in the class's own vocabulary. By the rubric a published class is one way (`class.pagelayout`) whatever its internals, so there is no bespoke code in the sample and no `ART`. The class's tool bridge (`pagelayoutapi`, ImageMagick, Inkscape) runs only when `optimize`, `import`, `preflight` or a shadow is selected; the main sample selects none (tex/pagelayout.cls:3786-3809, 1456, 1730, 2338), so no `EXTERNAL` applies to it. The `yes` stands on accepting the published class as a way: its internals (a grid solver and crop engine in plain TeX) could not be rebuilt from lib component ways.

## Blockers
none

Not blockers for the main sample, recorded for the sibling samples (they opt in to the tool bridge):
- `EXTERNAL/package` when selected: `optimize`/`\optimize` and `import` call `pagelayoutapi` and ImageMagick (tex/pagelayout.cls:3949-3953, 3991-3992; doc/example-book.tex:20-21; doc/example-graphic.tex:21); `\preflight` calls it for pixel density (tex/pagelayout.cls:1730-1733; doc/example-graphic.tex:22; doc/quickstart.tex:15); a shadow with size or shift above zero calls it with Inkscape (tex/pagelayout.cls:2324-2346, 3971-3972; doc/example-borders-and-shadows.tex:23; doc/quickstart.tex:63). The helper needs `pagelayoutapi` in `shell_escape_commands` (README.md:91-93).

## Class setting
- Class: `class.pagelayout` options: none in the main sample (doc/example-grid.tex:15). Class keys in tex/pagelayout.cls:162-220: `pagewidth` `pageheight` `bleed` `safetymargin` `margin` `gutter` `spinewidth` `bindingoffset` (lengths), `grid` `safezone` `cuttingmarks` `graphpaper` `placeholder` `fillpages` `draft` `preflight` `twoside` `fanfold` `cover` `beginleft` `beginright` (switches), `optimize` `import` `turbo` (tool bridge). Each can also be a preamble command or length (doc/pagelayout-manual.tex:148-150, 195-205).
- Base chain: the class loads `pgfopts`, `tikz`, `tcolorbox` with its `magazine` library (tex/pagelayout.cls:20-23) and `\LoadClass[multi=picture]{standalone}` (tex/pagelayout.cls:227), so every `\page` is one `picture`. The `standalone` class is the base class (a TeX Live class), not a second way in the table.
- Class-native vocabulary used by the main sample: `\page[...]{}` (cls:3080), `\setgrid[width,x]{{{cell}...}...}` with row height `[n]` and fixed aspect `n!` (cls:481, 528-547), `\text[...]{}` (cls:3705), `\graphic{}` (cls:3671), `\place{r c r c}` (cls:3738), lengths `\pagewidth` `\pageheight` `\gutter` `\margin`, switch `\grid` (cls:101), page option `gutter=` (cls:2965-2968).
- Class-native vocabulary used by sibling samples: `\newtemplate` `\template` `\placeholder` (cls:3634, 3639, 3492), shortcut template codes such as `so-gs` (cls:574-581, 588-623), `\newgraphic` (cls:1271), `\newborder` `\newshadow` (cls:2238, 2294), `\newbeforepage` `\setbeforepage` (cls:2783, 2775), `\leftpage` `\rightpage` (cls:3346, 3361), `\ifspine` (cls:95), `\usetext` and `\text[breakable,name=]` (cls:3618, 2010), `\tikzgraphic` `\xput` (cls:2213, 2185), page keys `double` `front cover` `back cover` `page graphic` `page color` `before page` (cls:2957-2985).

## Component map
Rows cite the main sample doc/example-grid.tex first; rows marked (sibling) come from the other samples.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/example-grid.tex:15 | `class.pagelayout` | no options |
| filler text package | doc/example-grid.tex:16 (loaded, never called there); doc/example-text.tex:30 `\lipsum[2-3]` (sibling) | `draft.todo` | `lipsum` |
| page size | doc/example-grid.tex:18-19 | `page.class-options` | pagewidth=20cm, pageheight=20cm (class lengths, cls:74, 165-166) |
| gutter between cells | doc/example-grid.tex:20 | `page.class-options` | gutter=10mm (cls:198); margin keeps its 20mm default (cls:193) |
| page margins, bleed, spine (sibling) | doc/example-book.tex:31-36 | `page.class-options` | margin=20mm, innermargin=40mm, gutter=10mm, bleed=3mm, safetymargin=5mm, spinewidth=7mm |
| class options (sibling) | doc/example-book.tex:15-22; doc/pagelayout-manual-layout-guides.tex:15-26 | `class.pagelayout` | draft, twoside, beginright, import, optimize={...}; or key=value form `bleed=3mm,margin=10mm,page width=20cm` |
| layout guide | doc/example-grid.tex:22 | `class.pagelayout` | `\grid` switch (cls:101, 202); `safezone`, `graphpaper` in siblings (doc/example-book.tex:38; doc/banner.tex:15) |
| page wrapper | doc/example-grid.tex:26-35 (eight `\page{}` blocks, last at :136-148) | `class.pagelayout` | `\page{}` body wrapper; `\page[gutter=10mm]` at :116 |
| grid specification | doc/example-grid.tex:27-30, 38-41, 49-52, 60-63, 76-79, 98-101 | `class.pagelayout` | `\setgrid{rows of cells}`: relative widths `{{3}{2}}`, row heights `[3]`, fixed aspect `3!`, `[2!]` |
| grids with offsets | doc/example-grid.tex:117-120, 126-129, 137 | `class.pagelayout` | `\setgrid[width=0.5\width,x=\margin]`, `[width=\height]`; several grids per page |
| text cell | doc/example-grid.tex:32-34, 43-45 | `class.pagelayout` | `\text{}` in the next free cell (tcolorbox-based, cls:2031-2054); `\text[breakable]` in siblings |
| image cell | doc/example-grid.tex:69, 72, 86-94, 103-109 | `fig.class-native` | `\graphic{3x2}` etc.: file name only, scale and crop by defaults (cls:3576) |
| free placement | doc/example-grid.tex:71, 85, 144, 146 | `fig.class-native` | `\place{1 1 2 2}`, `\place{0.5 0.5 1.5 1.5}` (cls:3738) |
| template (sibling) | doc/example-template.tex:24, 30-40 | `class.pagelayout` | `\template[gutter=5mm]{so-gs}`, `\newtemplate{..}{\setgrid[height=\height-20mm]..\placeholder{0 0 1 1}}` |
| text box styling (sibling) | doc/example-text.tex:39-47 | `box.tcolorbox` | `\tcbset{boxrule=1mm, boxsep=1mm, left/right/top/bottom=2mm, colback=yellow, colframe=red!75!black, opacityframe=1, opacityback=1, arc=1mm}` |
| colours (sibling) | doc/example-text.tex:42-43 | `color.xcolor` | `yellow`, `red!75!black` expressions inside the tcolorbox keys |
| page number strip (sibling) | doc/example-book.tex:40-51 | `hf.class-native` | `\newbeforepage{primary}` with `\leftpage`/`\rightpage` `\text[center]{\thepage}`; `\setbeforepage{primary}` |
| page numbering (sibling) | doc/example-book.tex:55, 85, 87 | `pgnum.pagenumbering` | roman, arabic, `\setcounter{page}{0}` |
| sans text face (sibling) | doc/example-book.tex:25-27 | `font.helvet` | `tgheros` |
| encoding (sibling) | doc/example-book.tex:26 | `font.fontenc-t1` | `[T1]{fontenc}` |
| default family (sibling) | doc/example-book.tex:27 | `font.family-default` | `\renewcommand*\familydefault{\sfdefault}` |
| sizes (sibling) | doc/example-book.tex:54, 61 | `font.size-commands` | `\Large`; `\fontsize{42mm}{46mm}\selectfont` |
| alignment (sibling) | doc/example-book.tex:62 | `sp.ragged` | `\centering` inside a text cell |
| contents (sibling) | doc/example-book.tex:81 | `toc.kernel` | `\tableofcontents` in a text cell |
| heading (sibling) | doc/example-book.tex:93 | `head.kernel` | `\section{Introduction}` (the class wraps `\section`, cls:3775-3779) |
| microtype (sibling) | doc/banner.tex:16; doc/quickstart.tex:16 | `sp.microtype` | load only |
| main font (sibling) | doc/banner.tex:17-19; doc/quickstart.tex:17-19 | `font.fontspec` | `\setmainfont{Menlo}` (XeLaTeX or LuaLaTeX) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| none in the main sample | doc/example-grid.tex:15-150 defines no macro, counter or environment | n/a | n/a |
| `\newbeforepage`, `\newtemplate`, `\newgraphic`, `\newborder`, `\newshadow` calls (siblings) | doc/example-book.tex:40, 98; doc/example-template.tex:30; doc/example-borders-and-shadows.tex:22-23 | yes | published declaration commands of `class.pagelayout`, recorded as class vocabulary |
| the class's own engine: grid solver `\pal@processrows` and `\pal@closerows`, crop and snap code, breakable text through the aux file, shell bridge | tex/pagelayout.cls:342-431, 894-1741, 3822-3828, 3905-4034 | not applicable: published class (W1 via CTAN), not zip-local | covered by `class.pagelayout`; not rebuildable from lib component ways, which is why the verdict rests on the class being one way |

## Content-opaque
- Placeholder images `3x2`, `1x1`, `2x1` placed by `\graphic` (doc/example-grid.tex:69-72, 86-94; files doc/3x2.pdf, doc/1x1.pdf, doc/2x1.pdf ship in the zip) and the photo `kopi` (doc/example-book.tex:59, 98; doc/kopi.jpg ships).
- `\tikzgraphic` drawings in sibling samples: a pink frame rectangle on the banner (doc/banner.tex:29-31) and a rotated spine label (doc/example-book.tex:69-74). Both are one-off pictures in a cell, treated as figure content, not reusable template identity.
- Filler text (`lipsum`, doc/example-text.tex:30-32) and the grid-demo sentences (doc/example-grid.tex:33, 44).

## Lib changes
- New ways proposed: none. Considered, not proposed: a page-level class-native line for `\page`/`\setgrid` (the lib's precedent is to record a published class's own vocabulary under its class way, see the v3 change log).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
