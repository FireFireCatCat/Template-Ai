yes

# 0144-geode: Geode (beamer theme)

- Unverified: read from the source, not compiled.
- Source: Source/0144-geode/ (origin: https://latextemplates.com/downloads/geode-beamer.zip; licence: LPPL-1.3c)
- Kind: presentation
- Lib: v3
- Engine: pdfLaTeX-compatible (tikz, xcolor, helvet; `\NewDocumentCommand` and `\fpeval` at beamertheme-geode.sty:45-57 need a recent LaTeX kernel, version not checked)
- Look carried by: mixed (published `beamer` class plus the published style package `beamertheme-geode` 1.0.0, bundled in the zip as a copy; the preamble adds only `tikz`, main.tex:2-5)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
yes, resting on one ruling. `beamertheme-geode.sty` is the CTAN package beamertheme-geode (ctan.org/pkg/beamertheme-geode: version 1.0.0, Camille Jaret, LPPL-1.3c, listed as in TeX Live and MiKTeX; the zip's `\ProvidesPackage` line says 1.0.0, beamertheme-geode.sty:2), so under the rubric's W1 case for latextemplates.com zips it is published, and its low-poly TikZ background (beamertheme-geode.sty:158-428) is selected by package options, not edited. The emitter prints `\documentclass[10pt]{beamer}`, `\usepackage{tikz}`, `\usetikzlibrary{positioning}` and `\usepackage[diamond]{beamertheme-geode}`; the sample defines no macro of its own and its one TikZ diagram is content. Risk: the zip copy was not diffed against CTAN, and the CTAN page shows no file list, so the colour-theme file is assumed to belong to the same bundle (if it is zip-local it reduces to seven `\definecolor` calls, so the verdict does not change). If a reviewer treated the style as zip-local, the four hand-drawn background variants would be `ART/class` and the answer `no`.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `10pt` (main.tex:1); paper size and aspect ratio not set (beamer default)
- Class-native vocabulary used: `frame` env, `\frametitle`, `\titlepage` and `\sectionpage` (called inside the theme's wrappers), `\section`, `\subsection`, `\subsecname`, `columns[T]` / `column{width}`, `definition` (beamer's built-in theorem-like block), `itemize`; beamer colour/template vocabulary used by the theme: `\setbeamercolor*`, `\setbeamertemplate`, `\defbeamertemplate*`, `beamercolorbox`, `\usebeamerfont`, `\insertshortauthor`, `\inserttitle`, `\insertframenumber`, `\inserttotalframenumber`
- Theme-native vocabulary (package `beamertheme-geode`, not the class): options `amethyst citrine obs phos pquartz diamond lowpoly ultralowpoly highpoly` (beamertheme-geode.sty:92-100), body commands `\geotitle` `\geosection` `\geosubsec` (beamertheme-geode.sty:110-132), preamble command `\custompalette{key}{r}{g}{b}` (beamertheme-geode.sty:45-90). Only the `diamond` colour theme file ships in the zip; the other five option names point at colour-theme files that are not in it (assets to ship).

## Component map
Rows without "inside" are what the emitter prints in the preamble or body. Rows marked "inside" are the decomposition of the published package, listed for the record; the emitter does not print them.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.beamer` | option `10pt` |
| base size | main.tex:1 | `page.class-options` | `10pt` (the page stays beamer's default 4:3; the theme's background coordinates assume it, beamertheme-geode.sty:173-175) |
| theme load | main.tex:5 | `slide.beamer-theme` | `\usepackage[diamond]{beamertheme-geode}` (a theme package loaded with `\usepackage`, which then calls `\usecolortheme`, beamertheme-geode.sty:142); option `diamond`, background variant left at default |
| colour palette | beamercolorthemegeode-diamond.sty:8-16 | `slide.beamer-theme` | colour theme `geode-diamond`, chosen at beamertheme-geode.sty:97; contents are `color.xcolor` `\definecolor` rgb values: accent .408 .545 .8; geode .714 .875 .933; dot .408 .545 .8; bg1 .945 .969 .984; bg2 .851 .922 .957; bg3 .796 .89 .941; bg4 .81 .89 .941 |
| TikZ for body picture | main.tex:2-3 | `art.tikz` | `\usepackage{tikz}`, `\usetikzlibrary{positioning}`; the package also loads tikz itself (beamertheme-geode.sty:14) |
| title data | main.tex:7-9 | `front.maketitle` | `\title`, `\author`, `\date{\today}` |
| title slide | main.tex:13 | `front.class-native` | `\geotitle`: a frame holding beamer's `\titlepage` (beamertheme-geode.sty:110-116) |
| section slides | main.tex:17, 61 | `head.class-native` | `\geosection`: a frame holding beamer's `\sectionpage` (beamertheme-geode.sty:118-124); `\section` at main.tex:15, 59, 87 and `\subsection` at main.tex:36 only set the names |
| frame titles | main.tex:20, 39, 64, 90 | `head.class-native` | `\frametitle{...}` (`\subsecname` or a literal); look set by the theme's frametitle template |
| definition block | main.tex:22-25 | `thm.class-native` | beamer's built-in `definition` env, drawn as a block |
| bullet lists | main.tex:29-33, 42-47, 50-53 | `list.kernel` | `itemize`; item colour from the theme (beamertheme-geode.sty:148) |
| two columns | main.tex:40-56 | `class.beamer` | beamer-native `columns[T]` with two `column{0.48\textwidth}` (minipage-like side-by-side boxes, recorded as class vocabulary) |
| inline emphasis | main.tex:23 | `mark.kernel` | `\textbf` |
| vertical fill, line break | main.tex:26, 28, 66, 68, 91 | `sp.manual-space` | `\vfill`, `\\[1em]` |
| centring | main.tex:69-84 | `sp.ragged` | `center` environment |
| display maths | main.tex:67 | `math.kernel` | `$$ ... $$`; `\text{}` inside is amsmath (loaded by beamer, not read) -> `math.amsmath` |
| coloured text | main.tex:67 | `color.xcolor` | `\textcolor{accent}{6}`, theme colour name |
| inside: sans font | beamertheme-geode.sty:16-17 | `font.helvet` | `helvet`, no options (loaded twice) |
| inside: colour package | beamertheme-geode.sty:15 | `color.xcolor` | `\RequirePackage{xcolor}` |
| inside: colour elements | beamertheme-geode.sty:145-152 | `slide.beamer-template` | `\setbeamercolor*`: title page header fg=white, author fg=white, date fg=white, item fg=accent, footline fg=accent, frametitle fg=accent, block title fg=accent bg=geode, block body bg=geode!5 |
| inside: navigation symbols | beamertheme-geode.sty:153 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` |
| inside: block shape | beamertheme-geode.sty:154 | `slide.beamer-template` | `\setbeamertemplate{blocks}[rounded][shadow=true]` |
| inside: page background | beamertheme-geode.sty:158-428 | `slide.beamer-template` | `\setbeamertemplate{background}` whose body is `art.tikz` triangles in bg1 to bg4; four variants picked by option: ultralowpoly 10 triangles (160-177), lowpoly 24 (179-210), highpoly 157 (212-376), default 39 (378-424); white bands and a geode-coloured tab (opacity .5) drawn only while `\ifbg` is true (172-176, 205-209, 371-375, 419-423) |
| inside: frame title template | beamertheme-geode.sty:431-433 | `slide.beamer-template` | `\vspace{0.14cm}`, `\hspace{-0.6cm}`, font element `accent`, `\insertframetitle` |
| inside: footline | beamertheme-geode.sty:436-447 | `slide.beamer-template` | `beamercolorbox[ht=2.5ex,dp=1.125ex,leftskip=.25cm,rightskip=.25cm plus1fil]{footer}`, short author / title / `framenumber / totalframenumber`, `\footnotesize`, `\vskip0.38cm`, shown only when `\ifnum\thepage>1` |
| inside: title page template | beamertheme-geode.sty:454-471 | `slide.beamer-template` | `\defbeamertemplate*{title page}{accent}`: `\vskip2.7cm`, `beamercolorbox[wd=12cm,leftskip=3cm,sep=8pt]`, centred bold `\huge` title, author and date in accent, `\vskip1cm` / `2.5cm` |
| inside: section page template | beamertheme-geode.sty:474-483 | `slide.beamer-template` | `\defbeamertemplate*{section page}{accent}`: same box, centred bold `\huge\secname` |
| inside: sizes, spacing | beamertheme-geode.sty:439, 459, 479 | `font.size-commands`, `sp.manual-space` | `\footnotesize`, `\huge`; `\vskip`, `\vfill`, `\hfill` |

Components the sample does not use: floats and captions, tables, code, notes, bibliography, index, cross-references, header fields other than the footline, overlays.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `beamertheme-geode.sty` (option switches `\ifbg` `\iflowpoly` `\ifultralowpoly` `\ifhighpoly`, option processing, `\geotitle` family, templates, TikZ background) | beamertheme-geode.sty:1-483 | not bespoke: published (CTAN and TeX Live package beamertheme-geode 1.0.0, same version string) | the emitter prints the `\usepackage[diamond]{beamertheme-geode}` line, a `slide.beamer-theme` way with options; the code inside is not copied |
| `\custompalette` colour dispatcher with `\fpeval` arithmetic | beamertheme-geode.sty:45-90 | published (same package); not called by the sample | if used, the emitter would resolve the arithmetic itself and print `\definecolor` (`color.xcolor`) |
| `beamercolorthemegeode-diamond.sty` | beamercolorthemegeode-diamond.sty:8-16 | yes, if it is not part of the CTAN bundle (membership not shown on the CTAN page) | `color.xcolor` `\definecolor` x7 with the rgb values in the component map |
| macros, environments, counters in the sample | main.tex | none defined | none |

## Content-opaque
- tikz picture with five nodes and four edges in a frame at main.tex:70-83 (`positioning` library, styles using the theme colours `accent` and `bg1`)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
