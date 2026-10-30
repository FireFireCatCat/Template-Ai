yes

# 0533-ojdo-thesis-defense: JD beamer theme (Johannes Dorfner's TUM thesis defence slides)

- Unverified: read from the source, not compiled.
- Source: Source/0533-ojdo-thesis-defense/ (origin: https://codeload.github.com/ojdo/thesis-defense/zip/refs/heads/master; licence: CC-BY-SA-4.0, LICENSE:1)
- Kind: presentation
- Lib: v4
- Engine: pdfLaTeX-compatible (`inputenc` utf8 and T1 fonts, tex/setup.tex:4,7; no `fontspec`, no Lua)
- Look carried by: mixed (the zip-local theme `beamerthemeJD.sty` sets colours, margins, footline, title, part, section and subsection pages and the contents entry on top of published `beamer`; the preamble in `tex/setup*.tex` adds the sans and mono fonts, packages, units and the diagram styles)
- Class origin: tex-distribution-unbundled (`beamer`, not in the zip, source not read; the theme `beamerthemeJD.sty` is zip-local: ctan.org/pkg/beamerthemejd is a 404, so by W1 it is not published)
- Main file: defense.tex (other samples: none; it `\input`s tex/setup.tex, tex/setup-colors.tex, tex/setup-settings.tex, tex/introduction.tex, tex/models.tex, tex/development.tex; defense.pdf and defense.gif are prebuilt outputs, not read as source)
- Read: main yes, zip-local classes and styles all (beamerthemeJD.sty, 244 lines, and all six `tex/*.tex` files; there is no .cls, .def, .cfg or .clo in the zip)

## Verdict
Yes, with two judgement calls. The class is the published `beamer`; the only zip-local style, `beamerthemeJD.sty`, is a list of `\definecolor`, `\setbeamercolor`, `\setbeamerfont`, `\setbeamersize` and `\setbeamertemplate` calls plus `beamercolorbox` bodies built from beamer's own `\insert...` commands, so it reduces by inlining to `slide.beamer-template` and `color.xcolor`. The five TikZ flowcharts, three pgfplots plots and their `\tikzset` styles are slide content (diagrams of this talk's argument, not the template's identity) and are held as Content-opaque. Judgement calls: (1) the `\fullframegraphic*` macros (beamerthemeJD.sty:74-132) expand to a `frame[plain]` holding one `tikzpicture[remember picture,overlay]` with two `current page` nodes, an image and a credit string, no path or shape, so they are read as the positioned-overlay way `bg.tikzpagenodes` carrying content, not identity artwork; a stricter reader who counts that overlay as template artwork would turn this into `ART/class`; (2) the `onslide` pgfkeys one-liner (tex/setup-settings.tex:29) is accepted as a content-scoped alias.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `english,11pt,aspectratio=1610,xcolor=table` (defense.tex:2). Source of beamer was not read (ships with the TeX distribution).
- Class-native vocabulary used: `frame` with optional title and subtitle `\begin{frame}{Title}{Subtitle}` (tex/introduction.tex:21), `frame[plain]` (beamerthemeJD.sty:75), `\frame{\sectionpage}` (tex/introduction.tex:4), `\tableofcontents` in a frame (defense.tex:39-41), short-form `\title[short]{long}` `\author[short]{long}` `\institute[short]{long}` `\date[short]{long}` and `\subtitle` (defense.tex:15-33), `\maketitle` (defense.tex:37), `\usetheme` (defense.tex:7), `\beamertemplatenavigationsymbolsempty` (defense.tex:8), `alertblock` (tex/introduction.tex:7; tex/models.tex:156), `columns[onlytextwidth,t]` with `\column{..}` (tex/models.tex:171-248), overlay specs `<2-5>` `<+->` `<4|handout:0>` with `\only` `\uncover` `\visible` (tex/models.tex:69,83,128,199), and the template machinery in the theme (`\setbeamertemplate`, `\setbeamercolor`, `\setbeamerfont`, `\setbeamersize`, `beamercolorbox`, `\usebeamerfont`, `\usebeamercolor`, `\insert...`).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | defense.tex:2 | `class.beamer` | english, 11pt, aspectratio=1610, xcolor=table |
| page size | defense.tex:2 | `page.class-options` | aspectratio=1610 (16:10), 11pt |
| xcolor table option | defense.tex:2 | `color.xcolor`, `tbl.colortbl` | `xcolor=table` passes `table` to xcolor; load-only, there is no tabular in any file (grep-checked) |
| theme selection | defense.tex:7; beamerthemeJD.sty:1-244 | `slide.beamer-template` | `\usetheme{JD}` names a zip-local theme, so it is not `slide.beamer-theme`; the reduction inlines the theme body as the `\setbeamer...` calls listed below (no `\usecolortheme`, `\useoutertheme`, `\useinnertheme` in the theme) |
| navigation symbols | defense.tex:8 | `slide.beamer-template` | `\beamertemplatenavigationsymbolsempty` |
| text margins | beamerthemeJD.sty:47-48 | `slide.beamer-template` | `\setbeamersize{text margin left=.4cm}`, same for right (nearest home, as in earlier solutions) |
| theme colour palette | beamerthemeJD.sty:6-27 | `color.xcolor` | `\definecolor{..}{HTML}{..}`: 8 greys ECECEC to 1A1A1A, 7 blues 0B1728 to D7E3F4, jdgreen 00AA44, jdblack 050505, jdwhite FFFFFF |
| TUM palette and carrier colours | tex/setup-colors.tex:4-98 | `color.xcolor` | `\definecolor` RGB for TUM blues, greys, accents, presentation colours, energy carriers, building types; `\colorlet` at 82, 84, 94-98 |
| beamer colour roles | beamerthemeJD.sty:30-35 | `slide.beamer-template` | structure fg=jddarkerblue; alerted text fg=jddarkblue; example text fg=jdgreen; author, institute, date in head/foot fg=jdgrey |
| block colours | beamerthemeJD.sty:37-42 | `slide.beamer-template` | starred `\setbeamercolor*`: block body bg=normal text.bg!90!jdlightgrey, alerted !90!jdlightblue, example !90!jdgreen; block title parent=structure bg=!75!jdgrey; alerted and example titles mix fg and bg with `!75!` |
| beamer fonts | beamerthemeJD.sty:51-52 | `slide.beamer-template` | title series=\bfseries; subtitle series=\normalfont |
| footline | beamerthemeJD.sty:154-171 | `hf.class-native`, `slide.beamer-template`, `sp.manual-space` | `\setbeamertemplate{footline}`: `\hbox` of two `beamercolorbox`: wd=.8\paperwidth ht=2.25ex dp=1ex left (`author in head/foot`) with `\insertshortauthor`, `\insertshortinstitute`, `\insertshorttitle`, `\insertshortdate` separated by `\qquad`; wd=.2\paperwidth right (`date in head/foot`) with `\makebox[5em][r]{\insertframenumber / \inserttotalframenumber}`; `\vskip.16cm` |
| sidebar right | beamerthemeJD.sty:144-151 | `slide.beamer-template` | `\insertlogo` and navigation symbols in `\llap`; inert in the sample: no `\logo` call anywhere (grep-checked), navigation symbols emptied (defense.tex:8), no sidebar width set |
| title page template | beamerthemeJD.sty:174-200 | `slide.beamer-template` | `beamercolorbox[sep=6pt]` for title (with subtitle line when non-empty, line 183), author, institute, date; `\inserttitlegraphic` unused (no `\titlegraphic`, grep-checked) |
| title data | defense.tex:15-33,37 | `front.class-native` | title with `\\`, subtitle "Final presentation", author short "J. Dorfner", institute short built from `\href` and `\hypersetup{urlcolor=jdgrey}` (line 24), date short 12/2016 |
| part page template | beamerthemeJD.sty:203-214 | `slide.beamer-template` | `beamercolorbox[sep=6pt]` part name and part title; inert, no `\part` in the sample (grep-checked) |
| section page template | beamerthemeJD.sty:218-228 | `slide.beamer-template` | `beamercolorbox[sep=6pt]` section name and title; used by `\frame{\sectionpage}` (tex/introduction.tex:4; tex/models.tex:4; tex/development.tex:4) |
| subsection page template | beamerthemeJD.sty:231-240 | `slide.beamer-template` | same pattern; inert, no `\subsection` in the sample |
| contents entry | beamerthemeJD.sty:243-244; defense.tex:39-41 | `slide.beamer-template`, `toc.kernel` | `section in toc`: `\quad{\small\color{jdblue}\bfseries number}~~title`; outline frame holds `\tableofcontents` |
| sectioning | tex/introduction.tex:3; tex/models.tex:3; tex/development.tex:3 | `head.kernel` | three `\section{..}` |
| frame titles | tex/introduction.tex:21; tex/models.tex:6,44 | `head.class-native` | `\begin{frame}{Title}{Subtitle}`; beamer's default frame title look (no `frametitle` template in the theme, grep-checked) |
| overlays | tex/models.tex:69-110,128-151,199,226; tex/development.tex:11-117; tex/introduction.tex:8,67 | `slide.beamer-mode` | `\only<2-5>`, `\only<4|handout:0>`, `\uncover<+->`, `\visible<4->`, `enumerate[<+->]` |
| columns | tex/models.tex:171-248,252-259,285-319 | `class.beamer` | `columns[onlytextwidth,t]`, `\column{.5\textwidth-.25cm}`, plain `columns` with `\column{\squeezethree}` |
| blocks | tex/introduction.tex:7-15; tex/models.tex:156-166 | `slide.beamer-template` | `alertblock` with a title; look from the colour lines above, default beamer block template |
| lists | tex/introduction.tex:8-14; tex/development.tex:9,16-20 | `list.kernel`, `sp.lengths` | `enumerate[<+->]` with `\itemsep9pt`; `itemize` with `\itemsep0em`, `\setlength{\leftmargini}{10pt}` inside nodes |
| display maths | tex/models.tex:124-152,158-161,206-246 | `math.amsmath`, `math.mathtools`, `math.amssymb`, `math.bm` | `align*` with `\text`, `\Big`; `\uncover` inside the display; mathtools (tex/setup.tex:15) and bm (tex/setup.tex:18) loaded; `\mathbb` (tex/setup-settings.tex:55-56) |
| units | tex/models.tex:52-53; tex/setup-settings.tex:38-50; tex/setup.tex:10 | `mark.siunitx` | options output-decimal-marker={,}, per-mode=symbol, exponent-product={\cdot}, retain-unity-mantissa=false; 13 `\DeclareSIUnit` (one in `\AtBeginDocument`, line 50); body `\si{\hour}` `\si{\MW}` |
| figures | tex/models.tex:17,19,31,254,257,289-361; tex/development.tex:181-204 | `fig.graphicx` | `\includegraphics[width=..]`, `clip=true,trim={0 0 215 0}` (tex/models.tex:254,257); images sit in frames, nodes and columns, no `figure` float; assets are PDF and one PNG under img/ |
| adjustbox keys | beamerthemeJD.sty:60 | `fig.adjustbox` | `[export]` adds `min height` and `max width` to `\includegraphics`, used only by `\fullframegraphicw`/`h` (lines 93,108), which the sample never calls |
| full-frame image slides | beamerthemeJD.sty:61-132; used tex/models.tex:262-282; tex/development.tex:170 | `bg.tikzpagenodes`, `fig.graphicx`, `slide.beamer-mode` | `frame[plain]` and `tikzpicture[remember picture,overlay]`; node at `current page.center` holding `\includegraphics[height=\paperheight,width=\paperwidth,keepaspectratio]`; optional credit node at `current page.south east` styled anchor=south east, font=\tiny, text=jdwhite, fill=jdblack, fill opacity=.5, text opacity=1, inner sep=2pt, text height=1ex, text depth=.25ex (lines 61-65); credit is a string (tex/models.tex:262-271); third argument takes extra nodes (the "Moosham" label, tex/models.tex:272-282, is content) |
| hyperlinks | tex/setup-settings.tex:91; defense.tex:24-27; tex/models.tex:262-271 | `meta.hyperref` | `colorlinks=true,linkcolor=,urlcolor=jdgreen`; local `\hypersetup{urlcolor=jdgrey}` and `{urlcolor=jdlighterblue}`; `\href` |
| urls | tex/introduction.tex:18; tex/models.tex:23,35,302,325,348,356,364 | `meta.url` | `\url{..}`, `\tiny` |
| fonts | tex/setup.tex:5-6 | `font.mono`, `font.helvet` | `beramono` scaled=0.86; `helvet` (beamer's default sans family) |
| encoding | tex/setup.tex:4,7,16 | `font.fontenc-t1` | `inputenc` utf8, `fontenc` T1, `textcomp` |
| euro glyph | tex/setup.tex:9; tex/setup-settings.tex:43 | `font.icons` | `eurosym`, `\euro` used only inside `\DeclareSIUnit\EUR` |
| language | defense.tex:2; tex/setup.tex:3 | `lang.babel` | class option `english`; `\usepackage{babel}` with no argument |
| quotation marks | tex/setup.tex:11 | `lang.csquotes` | load-only, `\enquote` never used (grep-checked) |
| listings setup | tex/setup.tex:14; tex/setup-settings.tex:79-88 | `code.listings` | `\lstset`: basicstyle jddarkgrey `\ttfamily`, identifier jddarkblue, comment jdgreen, string gred, keyword jddarkerblue, emph jdlightblue with emph={urbs,rivus}, texcl=true; load-only, no listing in the body (grep-checked); `gred` is not defined in any file (grep-checked) |
| table package (load-only) | tex/setup.tex:19 | `tbl.nicematrix` | `tabu` loaded, no table in the body |
| chemistry (load-only) | tex/setup.tex:17 | `art.content-package` | `mhchem` version=4, `\ce` never used |
| appendix numbering (load-only) | tex/setup.tex:20 | `num.appendix` | `appendixnumberbeamer` (ctan.org/pkg/appendixnumberbeamer: frame counts stop at `\appendix`, Jérôme Lelong, GPL 3, TeX Live); no `\appendix` in the sample (grep-checked) |
| file inclusion | defense.tex:3-5,43-45 | `struct.input` | six `\input{tex/...}` |
| body text shape | tex/models.tex:298,302; tex/introduction.tex:17-18; tex/development.tex:201 | `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.ragged`, `sp.manual-space` | `\tiny` `\small`, `\textbf` `\texttt`, `\textcolor{elec}{..}`, `\centering` `\raggedright`, `\vspace` `\hspace` `\qquad` `\vphantom` |
| diagrams and plots | see Content-opaque | `art.tikz` | `tikz`, `pgfplots`, libraries arrows.meta, calc, decorations.pathreplacing, positioning, shapes, fillbetween (tex/setup.tex:12-13,23-30) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `beamerthemeJD.sty` as a whole | beamerthemeJD.sty:1-244 | yes | the style is loaded by `\usetheme{JD}` (defense.tex:7); inline its calls into the preamble: `color.xcolor` (lines 6-27), `slide.beamer-template` (lines 30-52, 144-244); no counters, no loops, no output routine |
| `\ifx\insertsubtitle\@empty` | beamerthemeJD.sty:183 | yes | the same test beamer's own title page uses; an emitter prints the subtitle line only when the document has a subtitle (this one has, defense.tex:19) |
| `\ifx\relax#1\relax` credit test | beamerthemeJD.sty:80,95,110,126 | yes | an emitter writes the credit node only when a credit exists (tex/models.tex:262 has one; tex/development.tex:170 has none) |
| `\fullframegraphic`, `\fullframegraphicw`, `\fullframegraphich`, `\fullframegraphics` | beamerthemeJD.sty:74-132 | yes (judgement) | inline expansion at each call: `frame[plain]`, one `tikzpicture[remember picture,overlay]` with the image node and the optional credit node, `bg.tikzpagenodes` with the node keys listed in the map; the sample calls only `\fullframegraphic` (tex/development.tex:170) and `\fullframegraphics` (tex/models.tex:262); the `w` and `h` variants are never called |
| `ffgcaption` tikz style | beamerthemeJD.sty:61-65 | yes | declarative node keys, listed in the map |
| `\fbtitle` | tex/setup-settings.tex:35 | yes | alias of `\textbf{\textcolor{jdwhite}{#1}}` (`mark.kernel`, `color.xcolor`) |
| `\bs` `\st` `\R` `\Z` `\T` `\scenario` | tex/setup-settings.tex:53-58 | yes | aliases: `\boldsymbol`, `\mathsf{s.t.}`, `\mathbb{R}`, `\mathbb{Z}`, `^\mathsf{T}`, `\textcolor{jdgreen}{#1}`; inline expansion (`math.amsmath`, `math.amssymb`, `color.xcolor`) |
| lengths `\maxheight` `\squeezetwo` `\squeezethree` `\loosethree` | tex/setup-settings.tex:61-76 | yes | only `\squeezethree` is used (tex/models.tex:286-341), always as a column or image width: expand to `.33\paperwidth` (`sp.lengths`); the other three and the `\addtolength` chain are dead code (grep-checked); `\AtBeginDocument` only defers the definition |
| 13 `\DeclareSIUnit` | tex/setup-settings.tex:38-50 | yes | `mark.siunitx` declarations (names and unit strings) |
| `onslide` pgfkeys key | tex/setup-settings.tex:29; used tex/development.tex:30,134,137,141,149,155 | yes (judgement, content-scoped) | one line, `\only<#1>{\pgfkeysalso{#2}}`: beamer overlay (`slide.beamer-mode`) around a key list; used only inside the Content-opaque pictures, so it travels with them |
| `legend image code` `.code` (`square ybar legend`) | tex/setup-settings.tex:12-15 | yes | pgfplots legend glyph code, never used by any plot (grep-checked); drop |
| TikZ and pgfplots styles | tex/setup-settings.tex:3-32 | yes (content-scoped) | `flowbox`, `conn`, `hidden`, `concept`, `darrows`, `fb-muted`, `fb-highlight`, `tumaxisstyle`: key lists for the diagrams and plots only (`art.tikz`), carried with the content |
| `\demandts` `\windts` | tex/models.tex:41-42 | yes (content) | coordinate lists for the plot at tex/models.tex:58-66; data, not template |
| `\lstset`, `\hypersetup` | tex/setup-settings.tex:79-88,91 | yes | `code.listings`, `meta.hyperref` parameter calls |

## Content-opaque
- TikZ flowcharts with `rectangle split` boxes, braces and arrows: tex/introduction.tex:23-82 (disciplines), tex/models.tex:9-36 (model overview, embeds three images), tex/development.tex:8-118 (workflow, 10 overlay steps), tex/development.tex:124-166 (git commit graph with `pin` labels), tex/development.tex:174-208 (conclusion boxes)
- pgfplots with `fill between`, `const plot`, `y filter`: tex/models.tex:46-119 (urbs principle), tex/models.tex:174-202 and 218-237 (LP versus MILP)
- Overlay annotation "Moosham" on the aerial map slide: tex/models.tex:272-282
- The styles those pictures use: tex/setup-settings.tex:3-32 (see Bespoke code)
- Images are shipped assets: 11 PDFs under img/haag, 3 under img/rivus, 2 PDFs under img/urbs, img/techno-economic-modelling.pdf, and one PNG (img/urbs/urbs-commit-network-transp.png); the README says some come from matplotlib (README.md:3) but they are shipped as files, so nothing is generated at build time

## Lib changes
- New ways proposed: none. Nearest homes used, not proposed: `\setbeamersize` under `slide.beamer-template`; `appendixnumberbeamer` under `num.appendix` (considered: appendixnumberbeamer as its own way, rejected because it only wraps `\appendix`); `eurosym` under `font.icons`; `tabu` under `tbl.nicematrix`; `mhchem` under `art.content-package`; beamer `columns` as `class.beamer` vocabulary.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
