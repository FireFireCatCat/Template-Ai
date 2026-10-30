yes

# 0418-beamertheme-csh: CSH Beamer Theme (Complexity Science Hub Vienna)

- Unverified: read from the source, not compiled.
- Source: Source/0418-beamertheme-csh/ (origin: https://mirrors.ctan.org/macros/latex/contrib/beamer-contrib/themes/beamertheme-csh.zip; licence: LPPL 1.3c)
- Kind: presentation
- Lib: v5
- Engine: pdfLaTeX-compatible
- Look carried by: class (the four theme style files, which are the CTAN package beamertheme-csh; the sample's preamble only sets title, subtitle, author, institute and date strings)
- Class origin: ctan
- Main file: example-csh.tex (other samples: none; README.md has a usage snippet only, README.md:20-42)
- Read: main yes, zip-local classes and styles all (beamerthemecsh.sty, beamerinnerthemecsh.sty, beamerouterthemecsh.sty, beamercolorthemecsh.sty, each read in full)

## Verdict
The look is carried by the CSH beamer theme. Its four `.sty` files are the CTAN package `beamertheme-csh` v1.1 (the zip is its CTAN release, the manifest URL is a CTAN mirror path, and ctan.org/pkg/beamertheme-csh was read: LPPL 1.3c, directory macros/latex/contrib/beamer-contrib/themes/beamertheme-csh), so the theme is published (W1) and is one existing way, `slide.beamer-theme` with the name `csh`. The sample adds only `\documentclass[aspectratio=169]{beamer}`, `\usetheme{csh}`, content strings, standard beamer constructs and the theme's two own commands, `\source` and `\cshclosingslide`, so an emitter copies no zip-local macro logic. The theme's internals do contain TikZ artwork and a flag-counter conditional (see "Bespoke code"); they sit inside the published package, and the `yes` rests on W1 for the whole theme, not on reducing those internals. Under a stricter reading that treated the theme as zip-local, the same items would be `ART/class` and `BESPOKE/class`.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `aspectratio=169` (example-csh.tex:2). Beamer is not in the zip (tex-distribution-unbundled; source not read). The theme styles that carry the look are the CTAN package (Class origin: ctan).
- Class-native vocabulary used: `frame` with `[fragile]` and `{title}` argument (example-csh.tex:13, 17, 109), `\titlepage` (14), `\subtitle` `\institute` (6, 8), `\tableofcontents` in a frame (18), `block` `alertblock` `exampleblock` (34-44), `columns` and `column{0.48\textwidth}` (89-106), `\section` driving section slides.
- Theme-native vocabulary used (published with the theme): `\source{text}` (example-csh.tex:120), `\cshclosingslide{name}{email}{url}` (example-csh.tex:138); theme macros `\institutionlogomain` and `\institutionlogosmall` (beamerinnerthemecsh.sty:18-19), `\sectionpage` (beamerinnerthemecsh.sty:126).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example-csh.tex:2 | `class.beamer` | aspectratio=169 |
| page size / aspect | example-csh.tex:2 | `page.class-options` | aspectratio=169 (16:9 frame size) |
| theme selection | example-csh.tex:3; beamerthemecsh.sty:20-22 | `slide.beamer-theme` | usetheme=csh; it loads useinnertheme=csh, useoutertheme=csh, usecolortheme=csh; carried by the published theme |
| navigation symbols, text margins | beamerthemecsh.sty:24, 27 | `slide.beamer-template` | navigation symbols={}; `\setbeamersize` text margin left=1.8em, text margin right=3em |
| blocks | beamerthemecsh.sty:25; example-csh.tex:34-44 | `slide.beamer-template` | blocks=[rounded][shadow=true]; environments block, alertblock, exampleblock are class-native |
| colour definitions | beamercolorthemecsh.sty:14-19 | `color.xcolor` | `\definecolor` RGB: primary 0,97,210; secondary 69,137,255; tertiary 183,225,255; dark 0,0,0; light 235,236,237; accent 162,169,176 |
| beamer colour roles | beamercolorthemecsh.sty:22-59 | `slide.beamer-template` | `\setbeamercolor`: palettes fg=accent (22-25); normal text, titles, frametitle, items, toc, bibliography fg=dark (27-31, 36-38, 44-59); alerted text fg=secondary (32); block title alerted fg=primary (41); description item fg=accent (35) |
| text face | beamerthemecsh.sty:16 | `font.helvet` | `tgheros` (TeX Gyre Heros) |
| default family | beamerthemecsh.sty:17 | `font.family-default` | `\renewcommand{\familydefault}{\sfdefault}` |
| front matter strings | example-csh.tex:5-9 | `front.class-native` | `\title`, `\subtitle`, `\author`, `\institute`, `\date{\today}` (content strings) |
| title page | example-csh.tex:13-15; beamerinnerthemecsh.sty:93-114 | `slide.beamer-template` | `\defbeamertemplate*{title page}{csh}`: beamercolorbox sep=0pt, wd=12cm (title `\huge\textbf`, subtitle `\large\textbf`), wd=10cm (author, institute), wd=8cm (date); `\vskip` 4.0cm, 10pt, 10pt, 8pt; all text `dark` |
| frame title | beamerouterthemecsh.sty:14-31 | `slide.beamer-theme` | outer theme csh internals: TikZ white rectangle 0.625 paperwidth by 1.2, title node anchor west at x=0.5, `\Large\bfseries`, optional subtitle node `\small` (not decomposed, published theme) |
| page background, logos, frame number | beamerinnerthemecsh.sty:38-90 | `slide.beamer-theme` | inner theme csh internals: TikZ fill `tertiary` on first slide, last slide and section slides; big logo `height=1.2cm` at north west; on normal slides `\insertframenumber` at south and small logo `height=0.55cm` at south east (not decomposed, published theme) |
| sections | example-csh.tex:21, 47 | `head.kernel` | `\section{Introduction}`, `\section{Content}` |
| section-slide hook | beamerinnerthemecsh.sty:127-129 | `slide.beamer-section-hook` | `\AtBeginSection{...\begin{frame}\sectionpage\end{frame}...}` |
| section page look | beamerinnerthemecsh.sty:118-126 | `slide.beamer-template` | `\setbeamertemplate{section page}`: beamercolorbox wd=12cm sep=0pt, `\huge\insertsectionhead`, `\vfill` above and below; `\def\sectionpage` aliases `\usebeamertemplate*{section page}` |
| contents | example-csh.tex:18; beamercolorthemecsh.sty:51-52 | `toc.kernel` | `\tableofcontents` in an "Overview" frame; section/subsection in toc fg=dark |
| bullet lists | example-csh.tex:26-30, 92-96, 100-104 | `list.kernel` | `itemize` |
| numbered list | example-csh.tex:50-54 | `list.kernel` | `enumerate` |
| list markers | beamerinnerthemecsh.sty:24-26 | `slide.beamer-template` | itemize item `\(\bullet\)`, subitem `\(\circ\)`, subsubitem `\textbullet` |
| inline marks | example-csh.tex:24, 78, 81, 91, 127 | `mark.kernel` | `\textbf`, `\textit` |
| math | example-csh.tex:58-62 | `math.kernel` | inline `$E = mc^2$`, display `\[ \sum_{i=1}^{n} ... \]` (content) |
| figure | example-csh.tex:66-70 | `fig.graphicx` | `figure`, `\centering`, `\includegraphics[width=0.3\textwidth]{csh-logo-web}` |
| caption | example-csh.tex:69, 84 | `cap.kernel` | `\caption` in figure and table |
| caption look | beamerinnerthemecsh.sty:27-28; beamercolorthemecsh.sty:34 | `slide.beamer-template` | caption label separator `: `, caption [numbered], caption name fg=dark |
| table | example-csh.tex:74-85 | `tbl.tabular` | `table` `\centering`, `tabular{lcc}`, `\hline` x3, bold header cells |
| columns | example-csh.tex:89-106 | `class.beamer` | beamer `columns` and two `column{0.48\textwidth}` |
| code | example-csh.tex:109-115 | `code.verbatim` | frame option `fragile`, `verbatim` environment |
| source citation | example-csh.tex:117-121; beamerthemecsh.sty:31-36 | `slide.beamer-theme` | theme command `\source{text}`: TikZ overlay node at current page south west, xshift=12pt, yshift=12pt, `\tiny`, colour `dark` (published theme command) |
| bibliography | example-csh.tex:123-135 | `bib.thebibliography` | `thebibliography{9}`, two `\bibitem` entries (content) |
| bibliography item look | beamerinnerthemecsh.sty:30; beamercolorthemecsh.sty:54-59 | `slide.beamer-template` | bibliography item [triangle]; entry colours fg=dark |
| closing slide | example-csh.tex:137-138; beamerthemecsh.sty:40-83 | `slide.beamer-theme` | theme command `\cshclosingslide{name}{email}{url}`: group-local background (tertiary fill + logo), sidebar right empty, `frame[plain]` with `columns` 0.4/0.55 `\textwidth`, "Thank You!" and contact text (published theme command) |
| QR code on closing slide | beamerthemecsh.sty:15, 60 | `fig.qrcode` | `qrcode` package, `\qrcode[height=3cm]{#3}` (string argument) |

## Bespoke code
All items below are inside the CTAN package `beamertheme-csh` (published, W1), so none is counted as a zip-local blocker. The right-hand column says how each would fall if the theme were treated as zip-local, so the result can be re-read under another definition.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| whole theme (four `.sty` files) | beamerthemecsh.sty:9; beamerinnerthemecsh.sty:9; beamerouterthemecsh.sty:9; beamercolorthemecsh.sty:9 | published, not bespoke | emit `\usetheme{csh}`; if the package is not installed ship the four `.sty` files and the two logo PDFs next to the document |
| `sectionslide` flag counter set to 1 around the section frame | beamerinnerthemecsh.sty:21-22, 127-129 | published; if zip-local then `BESPOKE/class`: the flag decides which background prints (beamerinnerthemecsh.sty:63, 74) | the hook is `slide.beamer-section-hook`; the flag has no lib way |
| background template with `\ifnum` on `framenumber`, `\totvalue` (package `totcount`), `\thepage` and `sectionslide` | beamerinnerthemecsh.sty:11-12, 38-90 | published; if zip-local then `BESPOKE/class` and `ART/class` (TikZ fill and logo nodes that draw the template's identity) | a per-frame `\setbeamercolor{background canvas}` gives the fill, but the first, last and section switching has no lib way |
| frame title drawn in TikZ | beamerouterthemecsh.sty:14-31 | published; if zip-local then `ART/class` | a `beamercolorbox` frame title would approximate it; not shown to be equal |
| `\source` | beamerthemecsh.sty:31-36 | published; if zip-local then a small `ART/class` overlay | absolute placement of one text (`pg.textpos` type) would do |
| `\cshclosingslide` | beamerthemecsh.sty:40-83 | published; if zip-local then `ART/class` for the TikZ background; the columns, `fig.qrcode` and text parts reduce | local background template is the only part with no lib way |
| `\def\institutionlogomain` and `\def\institutionlogosmall` | beamerinnerthemecsh.sty:18-19 | yes (file-name alias macros) | two string values, `csh-logo-web` and `csh-logo-star-crop` |
| `\def\sectionpage` | beamerinnerthemecsh.sty:126 | yes (alias) | `\usebeamertemplate*{section page}` |
| `lastpage` loaded, no `\pageref{LastPage}` use found | beamerthemecsh.sty:13 | not applicable | load-only; grep for LastPage found only this line |

## Content-opaque
none (the two logo PDFs, csh-logo-web.pdf and csh-logo-star-crop.pdf, are assets the theme references at beamerinnerthemecsh.sty:18-19 and the sample at example-csh.tex:68; they ship in the zip. The QR code is generated from a string by `qrcode`, not drawn.)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
