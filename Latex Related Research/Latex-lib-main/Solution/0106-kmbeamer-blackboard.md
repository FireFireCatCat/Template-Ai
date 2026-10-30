no

# 0106-kmbeamer-blackboard: KMBeamer (Blackboard)

- Unverified: read from the source, not compiled.
- Source: Source/0106-kmbeamer-blackboard/ (origin: https://latextemplates.com/downloads/kmbeamer.zip; licence: MIT, LICENSE:1-18, same notice in each .sty header)
- Kind: presentation
- Lib: v2
- Engine: pdfLaTeX-compatible (`inputenc` utf8 and `fontenc` T1 at main.tex:4-5; the background is a PDF included with `\includegraphics`)
- Look carried by: zip-local (the look is the zip-local beamer theme `Blackboard`, beamerthemeBlackboard.sty plus beamercolorthemeBlackboard.sty, kmbeamer_common.sty and kmbeamer_color.sty; main.tex adds only `\usetheme{Blackboard}` and content)
- Class origin: tex-distribution-unbundled (`beamer`, not in the zip; its source was not read). The theme files are not published: ctan.org/pkg/kmbeamer returned 404, and the zip is from latextemplates.com, not an official kit, so they are zip-local under W1.
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (4 files, 152 lines, every line read; kmbeamer_bg_Blackboard.pdf is an asset, not read as source)

## Verdict
The class is the published `beamer` and nearly all of the zip-local theme reduces to `slide.beamer-template`, `slide.beamer-theme` and `color.xcolor` calls with parameters. Two template bodies carry TeX conditionals that decide what is printed: the footline prints the section label only when `\insertsectionnumber>0` (beamerthemeBlackboard.sty:26), and the title page prints the institute in parentheses only when it is non-empty (beamerthemeBlackboard.sty:45). No lib way holds a conditional, and a proposed way for one would fail W2 because its parameter is a program, so this is irreducible bespoke code and the answer is `no`. If the project later admits such guards inside a `\setbeamertemplate` body, this zip would need only the shipped background PDF (below) to be accepted as an asset to flip to yes.

## Blockers
- `BESPOKE/class` footline template: `\ifnum\insertsectionnumber>0 ... \fi` guard decides whether "N. Section" prints (frames before the first `\section`, here the title and Outline frames, print no label); the box registers around it are reducible but the guard is not (beamerthemeBlackboard.sty:26)
- `BESPOKE/class` title-page template: `\ifx\insertinstitute\@empty\else(\insertinstitute)\fi` prints the institute in parentheses only when one is set; the sample sets one (main.tex:12), so the empty branch is not exercised (beamerthemeBlackboard.sty:45)

## Class setting
- Class: `class.beamer` options: none (main.tex:1), so the beamer default paper size and default 4:3 page are used; nothing in the zip sets `aspectratio`.
- Class-native vocabulary used: `frame` environment with a title argument (main.tex:21, 27, 37, 56, 66, 84, 95, 103), `\titlepage` (main.tex:18), `\title` `\subtitle` `\author` `\institute` `\date` (main.tex:9-13), `\tableofcontents` (main.tex:22), `\section` (main.tex:25), `columns[T]` and `column{0.5\textwidth}` (main.tex:38-52), `block{title}` (main.tex:57), `table` with `\caption` inside a frame (main.tex:67-79); theme-side: `\usetheme` `\usecolortheme` `\usefonttheme` `\setbeamercolor*` `\setbeamerfont` `\setbeamertemplate` `\setbeamersize` `\usebeamercolor` `\mode<presentation>` and the `\insert...` macros (`\insertframetitle`, `\insertsection`, `\insertsectionnumber`, `\insertframenumber`, `\inserttotalframenumber`, `\inserttitle`, `\insertsubtitle`, `\insertauthor`, `\insertinstitute`, `\insertdate`).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.beamer` | no options |
| theme selection | main.tex:2; beamerthemeBlackboard.sty:12; kmbeamer_common.sty:11 | `slide.beamer-theme` | `\usetheme{Blackboard}` and `\usecolortheme{Blackboard}` name zip-local themes, so an emitter inlines their bodies into the rows below; the one published name is `\usefonttheme{professionalfonts}` |
| beamer modes | beamerthemeBlackboard.sty:8,56; beamercolorthemeBlackboard.sty:8,19 | `slide.beamer-mode` | `\mode<presentation>` ... `\mode<all>` wrapping each theme file |
| page margins | beamerthemeBlackboard.sty:14 | `slide.beamer-template` | `\setbeamersize{text margin left=6mm,text margin right=6mm}` (a `\setbeamer*` setter of the same family; this placement is a judgement) |
| colour definitions | kmbeamer_color.sty:11-52 | `color.xcolor` | 28 `\definecolor{name}{HTML}{hex}`; the four the theme uses: water A9CEEC (:17), bottlegreen 264435 (:27), snow F1F1F1 (:40), midyellow FAD43A (:44); the rest are unused palette |
| colour names | kmbeamer_color.sty:8 | `color.color` | `\RequirePackage{svgcolor}` (standalone CTAN package of SVG colour names, checked ctan.org/pkg/svgcolor); load-only, names redefined locally |
| colour roles | beamercolorthemeBlackboard.sty:12-17 | `slide.beamer-template` | `\setbeamercolor*`: background canvas bg=bottlegreen, normal text fg=snow, alerted text fg=midyellow, structure fg=water, title fg=water |
| page background | beamerthemeBlackboard.sty:21 | `slide.beamer-template` + `fig.graphicx` | `background canvas` = `\includegraphics[width=\paperwidth,height=\paperheight,keepaspectratio=false]{kmbeamer_bg_Blackboard}`; shipped asset (see Content-opaque) |
| fonts: beamer font roles | beamerthemeBlackboard.sty:16-19 | `slide.beamer-template` | `\setbeamerfont`: title, frametitle, block title `size=\normalsize,series=\bfseries`; footline `size*={5}{\z@},series=\bfseries` |
| fonts: typeface and math | kmbeamer_common.sty:11; main.tex:4-5 | `slide.beamer-theme` + `font.fontenc-t1` | `professionalfonts`; `inputenc` utf8, `fontenc` T1; no font package, so beamer's default sans |
| headline | beamerthemeBlackboard.sty:24 | `slide.beamer-template` + `hf.class-native` + `sp.manual-space` | `headline` = `\vspace{4mm}` |
| footline | beamerthemeBlackboard.sty:25-33 | `slide.beamer-template` + `hf.class-native` + `sp.manual-space` + `mark.kernel` | left "N. Section" (guarded, BLOCKER), right `frame/total` (`\insertframenumber$/$\inserttotalframenumber`); `\vspace{5.2mm}`, `\hspace{4mm}`, `\hfill`, `\vspace{1.3mm}`; `\boldmath`; box height 1mm, depth 0mm |
| navigation symbols | kmbeamer_common.sty:14 | `slide.beamer-template` | `navigation symbols` = empty |
| frame title | beamerthemeBlackboard.sty:23; main.tex:21 | `slide.beamer-template` + `head.class-native` + `mark.kernel` | `frametitle` = `\boldmath\insertframetitle` |
| title page | beamerthemeBlackboard.sty:34-54 | `slide.beamer-template` + `front.class-native` + `sp.ragged` + `font.size-commands` + `mark.kernel` + `sp.manual-space` + `num.counters` | `center` blocks separated by `\vfill`; title `\usebeamercolor[fg]{structure}\bfseries\boldmath`; subtitle `\scriptsize`; author plus guarded `(institute)` (BLOCKER); date `\small`; footnote marks switched to `\fnsymbol` with `\setcounter{footnote}{1}` and restored to `\arabic` and 0 at lines 52-53 |
| title-page content | main.tex:9-13,17-19 | `front.class-native` | `\title` `\subtitle` `\author` `\institute` `\date{\today}` then `\titlepage` in a frame |
| contents | main.tex:21-23; kmbeamer_common.sty:13 | `toc.kernel` + `slide.beamer-template` | `\tableofcontents`; `sections/subsections in toc` = `[sections numbered]` (followed by an empty `{}` group, a no-op) |
| sectioning | main.tex:25,35,82,93 | `head.kernel` | `\section{...}` x4 (beamer navigation entries, shown in toc and footline) |
| lists | main.tex:28-32,41-44 | `list.kernel` + `slide.beamer-template` + `math.kernel` | `itemize`; marker `itemize item` = `\usebeamercolor[fg]{structure}$\circ$` (beamerthemeBlackboard.sty:22) |
| columns | main.tex:38-52 | `class.beamer` (native) | `columns[T]`, `column{0.5\textwidth}` x2 |
| block | main.tex:57-60; beamerthemeBlackboard.sty:18 | `class.beamer` (native) + `slide.beamer-template` | `block{Divide and conquer}`; title font bold `\normalsize` |
| emphasis | main.tex:40,47 | `mark.kernel` | `\textbf` |
| maths | main.tex:49-50,61-63 | `math.kernel` + `math.amsmath` | inline `$...$`, display `\[ ... \]`; `\implies` is amsmath, which beamer loads by default (from its manual, beamer source not read) |
| proof end mark | kmbeamer_common.sty:15 | `slide.beamer-template` | `qed symbol` = empty (no proof in the sample) |
| table | main.tex:67-79; main.tex:7 | `tbl.tabular` + `tbl.booktabs` + `cap.kernel` + `sp.ragged` | `table`, `\centering`, `tabular{lccc}`, `\toprule` `\midrule` `\bottomrule`, `\caption{...}` |
| closing frame | main.tex:103-107 | `sp.ragged` + `font.size-commands` + `sp.manual-space` | `\centering`, `\Large`, `\\[1em]`, `\normalsize` |
| images | main.tex:6 | `fig.graphicx` | package loaded, no figure in the sample; also used for the background above |
| bibliography, index, code, headings numbering, language, hyperref options | none in the sample or theme | none | not defined here (beamer's own hyperref load is the class default) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| theme `Blackboard` as a unit | beamerthemeBlackboard.sty:6-59; beamercolorthemeBlackboard.sty:6-22 | Reducible except two guards | inline as `slide.beamer-template` and `slide.beamer-theme` calls per the table; not a published theme |
| `kmbeamer_color` palette | kmbeamer_color.sty:6-54 | Yes | 28 `\definecolor{..}{HTML}{..}` (`color.xcolor`) plus `svgcolor` (`color.color`) |
| `kmbeamer_common` | kmbeamer_common.sty:6-17 | Yes (box registers) | `\usefonttheme`, three `\setbeamertemplate` calls; the two `\newbox` registers (:8-9) go away when the footline boxes are inlined |
| footline boxes `\kmbmr@tmpboxa/b` | kmbeamer_common.sty:8-9; beamerthemeBlackboard.sty:26-31 | Yes in principle | `\setbox`, `\ht`, `\dp`, `\box` equal inline `\raisebox{0pt}[1mm][0mm]{...}` (`sp.manual-space`) between `\hspace{4mm}` and `\hfill` |
| footline guard `\ifnum\insertsectionnumber>0` | beamerthemeBlackboard.sty:26 | No | conditional that drives what prints; no lib way; `BESPOKE/class` |
| title-page guard `\ifx\insertinstitute\@empty` | beamerthemeBlackboard.sty:45 | No | same reason; `BESPOKE/class` |
| footnote-symbol switch | beamerthemeBlackboard.sty:35-36,52-53 | Yes | `\renewcommand\thefootnote{\fnsymbol{footnote}}`, `\setcounter{footnote}{1}`, then restore `\arabic` and `\setcounter{footnote}{0}` (`num.counters`); fixed text, no logic |

## Content-opaque
- Background artwork, beamerthemeBlackboard.sty:21: `kmbeamer_bg_Blackboard.pdf` is a 5188-byte vector PDF with no raster image objects, Producer LuaTeX-0.81.1 (from grep of the file; not rendered, no PDF renderer here). Its drawing source is not in the zip. It is treated as a shipped image asset reached through `\includegraphics`, not as ART, because no TikZ/PGF/picture code exists in the zip. A reviewer who reads a compiled background as template artwork would add `ART/preamble` here.
- Otherwise none (the sample has no figure floats or code).

## Lib changes
- New ways proposed: none. Considered: `etoolbox` conditionals for the two guards, rejected (W2: its parameters are programs).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
