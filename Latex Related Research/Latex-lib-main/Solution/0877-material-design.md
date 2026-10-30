yes

# 0877-material-design: Material Design (beamer theme)

- Unverified: read from the source, not compiled.
- Source: Source/0877-material-design/ (origin: https://latextemplates.com/downloads/material-design-beamer.zip; licence: MIT)
- Kind: presentation
- Lib: v6
- Engine: pdfLaTeX-compatible (beamer, tcolorbox, tikz, xcolor, graphicx, ifthen, inputenc; no fontspec, no Lua)
- Look carried by: zip-local (the four `beamer*themematerial.sty` files define every visible part on top of the stock `beamer` class; the sample's preamble only picks colour presets)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (beamerthemematerial.sty 82 lines, beamerinnerthemematerial.sty 42, beamerouterthemematerial.sty 28, beamercolorthemematerial.sty 286; main.tex 80)

## Verdict
Yes, resting on two rulings. The class is the published `beamer` (not in the zip). The theme is zip-local (I read `https://ctan.org/pkg/beamertheme-material` and `https://ctan.org/pkg/beamerthemematerial`: both 404, so it is not established as published, and the zip is from latextemplates.com), so its code must reduce. It does: every file is `\tcbset` key lists, `\definecolor` calls, `\setbeamer*` calls, two `\defbeamertemplate*` bodies and four small wrappers, all compositions of published commands (`box.tcolorbox`, `slide.beamer-template`, `color.xcolor`) with no TikZ picture, no counter and no output-routine code. Weakest points: the `segmentation code` key holds one TikZ path (a straight divider rule, reached only by `\cardImg` with a caption, never by the sample), and the frame-title template tests `\insertframesubtitle`; both are treated as reducible below.

## Blockers
none

## Class setting
- Class: `class.beamer` options: none (main.tex:1); paper size and aspect ratio stay at the beamer default. Class source not in the zip, not read.
- Class-native vocabulary used: `frame` with a title argument (main.tex:21, 29, 42, 73), `\titlepage` (main.tex:18), `\title` `\author` `\date{\today}` (main.tex:5-7), `\section` (main.tex:27, 40, 71), `\tableofcontents` (main.tex:23), `columns[T]` and `column{0.48\textwidth}` (main.tex:43-44, 56), `\usetheme` (main.tex:9). Beamer vocabulary the theme uses: `\setbeamercolor` `\setbeamerfont` `\setbeamertemplate` `\defbeamertemplate*` `\usebeamerfont` `\usebackgroundtemplate` `\inserttitle` `\insertauthor` `\insertdate` `\insertframetitle` `\insertframesubtitle`, `\mode<presentation>`.
- Theme-native vocabulary (zip-local, not published): `\useLightTheme` `\useDarkTheme`, `\usePrimary<Name>` (19 presets) and `\usePrimary{#1}{#2}{#3}`, `\useAccent<Name>` (16 presets) and `\useAccent{#1}{#2}` (beamercolorthemematerial.sty:4-270), environments `card[title]` `cardTiny` `frameImg[width|height]{image}`, command `\cardImg[caption]{image}{width}`, `\setCardSettings` (beamerthemematerial.sty:21-80). The sample uses `\useLightTheme` `\usePrimaryTeal` `\useAccentOrange` `card` `cardTiny` (main.tex:11-13, 22, 35, 45, 57).

## Component map
Paths: `main.tex`; `sty` = beamerthemematerial.sty; `inner` = beamerinnerthemematerial.sty; `outer` = beamerouterthemematerial.sty; `color` = beamercolorthemematerial.sty.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.beamer` | no options |
| page size | main.tex:1 | `page.class-options` | beamer default sheet; templates are full-bleed with `width=\paperwidth` (inner:14, outer:15) |
| input encoding | main.tex:2 | `font.fontenc-t1` | `\usepackage[utf8]{inputenc}` |
| theme load | main.tex:9; sty:11-13 | `slide.beamer-theme` | `\usetheme{material}`; zip-local theme, so the emitter prints its content (rows below) instead of the name |
| mode guards | sty:1, 82; inner:1, 41-42; outer:1, 28; color:1, 285-286 | `slide.beamer-mode` | `\mode<presentation>` ... `\mode<all>` around definitions; no printed effect, omitted by the emitter |
| support packages | sty:4-8 | `box.tcolorbox` | `tikz`, `xcolor`, `graphicx`, `ifthen` load-only; `\RequirePackage[many]{tcolorbox}` (sty:7) |
| colour definitions | color:4-13, 29-33, 92-96, 171-174, 261-264 | `color.xcolor` | `\definecolor{..}{HTML}{..}`; sample resolves to text 000000, shadow 000000, BGgrey01 E0E0E0, BGgrey02 F5F5F5, BGgrey03 FAFAFA, BGgrey04 FFFFFF, primary 009688, primaryD 00796B, textPrimary FFFFFF, accent FF9100, textAccent 000000 |
| colour roles | color:6, 279, 281-282; inner:1, 39 | `slide.beamer-template` | `\setbeamercolor*{normal text}{fg=text}`; `{block title}{fg=primary}`; `{section in toc}` and `{subsection in toc}` `fg=primary`; `{background canvas}{bg=BGgrey03}`; `{local structure}{fg=accent}` |
| link colour | color:280 | `meta.hyperref` | `\hypersetup{linkcolor=primary}` |
| preset commands | main.tex:11-13 | `color.xcolor` | calls expand to the `\definecolor` lines above; default presets Indigo and Pink (color:274-276) are overridden by Teal and Orange |
| navigation symbols | sty:15 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` |
| title and frame-title sizes | sty:17-18 | `slide.beamer-template` | `\setbeamerfont*{title}{size=\Huge}`, `\setbeamerfont*{frametitle}{size=\large}` (sizes are `font.size-commands`) |
| title page | main.tex:17-19; inner:4-32 | `slide.beamer-template` | `\defbeamertemplate*{title page}{material}` filed as `\setbeamertemplate{title page}{..}` with free box code: `\makebox[\linewidth][c]`, `minipage[t][\paperheight]{\paperwidth}` (`box.minipage`), `\raggedright` (`sp.ragged`), one `tcolorbox` (`box.tcolorbox`): colback=primary, enhanced, sharpish corners=all, boxrule=0mm, coltext=textPrimary, four `fuzzy shadow` keys, width=\paperwidth, height=0.6\paperheight, flushright upper, valign=bottom, boxsep=0.5cm; body title (font `title`), author and date (font `author`) with `\\` between; `\vfill` (`sp.manual-space`) |
| frame title | main.tex:21, 29, 42, 73; outer:4-25 | `slide.beamer-template` | `\defbeamertemplate*{frametitle}{material}` as `\setbeamertemplate{frametitle}{..}`: same `makebox`/`minipage`/`\raggedright` frame, `tcolorbox` colback=primary, enhanced, sharpish corners=all, boxrule=0mm, coltext=textPrimary, left=6mm, right=6mm, top=2.6mm, bottom=2mm, four `fuzzy shadow`, width=\paperwidth, boxsep=2mm; title in font `frametitle`, subtitle in font `framesubtitle` when `\insertframesubtitle` is non-empty (outer:16-21) |
| list and toc markers | inner:35-37 | `slide.beamer-template` | `enumerate items`=circle, `itemize items`={\Large $\bullet$} (`font.size-commands`, `math.kernel`), `sections/subsections in toc`=circle; no list in the sample, the toc uses the last |
| title data | main.tex:5-7 | `front.maketitle` | `\title{Material Design for Slides}`, `\author{Elena Vasquez}`, `\date{\today}` |
| title slide | main.tex:17-19 | `front.class-native` | `\titlepage` inside a frame |
| sections | main.tex:27, 40, 71 | `head.class-native` | `\section{Why Cards}`, `{Results}`, `{Closing}`; they feed the toc only |
| contents | main.tex:21-25 | `toc.kernel` | `\tableofcontents` inside a frame and a card |
| card (untitled and titled) | main.tex:22, 30, 35, 45, 74; sty:21-45 | `box.tcolorbox` | `\tcbset`: colback=BGgrey04, colbacktitle=primary, coltitle=textPrimary, coltext=text, enhanced, sharpish corners=all, `fuzzy shadow` x3 (sty:25-27: {0mm}{0.9mm}{0.6mm}{0.2mm}{shadow!20!BGgrey03}, {0mm}{-0.6mm}{-0.1mm}{0.2mm}{shadow!40!BGgrey03}, {0mm}{-0.2mm}{-0.2mm}{0.2mm}{shadow!20!BGgrey03}), left=right=top=bottom=6mm, middle=4mm, title filled, boxrule=0mm; titled form adds title=#1, top=3mm, bottom=4mm, toptitle=4mm, bottomtitle=3mm (sty:41) |
| tiny card | main.tex:57-66; sty:47-52 | `box.tcolorbox` | same `\tcbset` plus colbacktitle=primary, left=right=4mm, top=bottom=2mm, middle=4mm, toptitle=4mm, bottomtitle=3mm (sty:49) |
| image card (unused by sample) | sty:55-68 | `box.tcolorbox`, `fig.graphicx` | `\cardImg`: `lower separated=false`, leftupper=rightupper=0mm, top=0mm, middle=1.5mm, boxsep=0mm, `width=#3`, `\includegraphics[width=\textwidth]{#2}`; captioned form adds `\tcblower`, leftlower=rightlower=6mm, bottom=6mm (sty:62-65) |
| card divider rule | sty:30 | `box.tcolorbox` | `segmentation code={\path[draw=BGgrey01](segmentation.west) -- (segmentation.east);}`: one straight rule in BGgrey01 between upper and lower parts; drawn only after `\tcblower` (see Bespoke) |
| full-frame image (unused by sample) | sty:70-80 | `slide.beamer-template`, `fig.graphicx` | `frameImg`: `\usebackgroundtemplate{\hspace{-0.5\paperwidth}\parbox[c][\paperheight][c]{2\paperwidth}{\centering\includegraphics[width=\paperwidth|height=\paperheight, keepaspectratio=true]{#2}}}` (`sp.manual-space`, `box.minipage`, `sp.ragged`), then `\begin{frame}` ... `\end{frame}` |
| side-by-side columns | main.tex:43-68 | `class.beamer` | beamer `columns[T]`, two `column{0.48\textwidth}` (pdf-neutral equivalent: `cols.minipage`) |
| table | main.tex:46-53, 58-65 | `tbl.tabular` | `tabular{lr}`, header row and two data rows, twice |
| table rules | main.tex:3, 47, 49, 52, 59, 61, 64 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| manual break | main.tex:75 | `sp.manual-space` | `\\[2mm]` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\setCardSettings` | sty:21-34 | yes | one `\tcbset{...}` of published keys (`box.tcolorbox`); the emitter prints it once in the preamble (the theme repeats it inside each environment, same values) |
| `card` with sentinel default `pR23s2OTKY` and `\ifthenelse{\equal{#1}{pR23s2OTKY}}` | sty:36-45 | yes | the test only asks whether the optional title was given; the emitter knows that per node and prints one branch: untitled `\begin{tcolorbox}` or titled `\begin{tcolorbox}[title=..., top=3mm, bottom=4mm, toptitle=4mm, bottomtitle=3mm]` (or `\newtcolorbox{card}[1][]`); `ifthen` is load-only |
| `cardTiny` | sty:47-52 | yes | `\begin{tcolorbox}[left=4mm, right=4mm, top=2mm, bottom=2mm, ...]` as in the map |
| `\cardImg` | sty:55-68 | yes | same sentinel test, resolved at emission; `tcolorbox` with `\includegraphics` and optional `\tcblower` caption |
| `frameImg` | sty:70-80 | yes | a group holding `\usebackgroundtemplate{...}` and a `frame`; width-or-height test resolved at emission |
| `segmentation code` TikZ path | sty:30 | yes (borderline) | a documented tcolorbox key whose value is one straight `\path[draw=BGgrey01]` between two box anchors, the same line the box would draw with `segmentation style` set to that colour (tcolorbox source not read here); not a picture, not the template's identity, and reachable only through `\tcblower` in `\cardImg` |
| `\defbeamertemplate*{title page}{material}[1][]` | inner:4-32 | yes | register by `\setbeamertemplate{title page}{...}` with the same free box code; the unused `[1][]` argument is dropped; precedent: `\defbeamertemplate*` filed under `slide.beamer-template` |
| `\defbeamertemplate*{frametitle}{material}[1][]` with `\ifx\insertframesubtitle\@empty` | outer:4-25 | yes | same registration; the `\ifx` is beamer's own emptiness test for an optional insert, kernel TeX with no counter or macro state; the emitter prints it inside the template body |
| `\useLightTheme`, `\useDarkTheme`, `\usePrimary*`, `\useAccent*`, `\usePrimary{}{}{}`, `\useAccent{}{}` | color:4-270 | yes | `\newcommand` aliases of `\definecolor{..}{HTML}{..}` and one `\setbeamercolor*`; the emitter prints the expanded lines |
| `\mode<presentation>` guards | sty:1, 82 and the three other files | yes | no printed effect in presentation mode; omitted |
| commented-out icon box | inner:20-28 | not active | a `%` block using `\iconFolder` (never defined); ignored, not part of the look |

## Content-opaque
none (the two `tabular` bodies in main.tex:46-65 are table content; the sample has no figure and no TikZ picture)

## Lib changes
- New ways proposed: none. Considered and not proposed: a `\defbeamertemplate*` way (it is the same setter family as `\setbeamertemplate`, `slide.beamer-template`), and a way for `tcolorbox`'s `segmentation code` (a key of `box.tcolorbox`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- tcolorbox option check: `\RequirePackage[many]{tcolorbox}` (sty:7) is loaded unconditionally. To my knowledge, and as the 0454-user-persona analysis records from an installed tree, `many` loads raster, skins, breakable, hooks, theorems and fitting, not `minted`, so no `EXTERNAL/package` blocker; tcolorbox.sty is not in the zip and no TeX install was available here to confirm.
- Missing assets: none for the sample; `\cardImg` and `frameImg` take image files that the user supplies, never called by main.tex.
- No text addressed to an AI was found in the zip.
