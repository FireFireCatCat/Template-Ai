no

# 0368-sjijon-tex-templates: sjijon/TeX-templates (Simple CV, Quito beamer themes, tikzposter posters, Timeline)

- Unverified: read from the source, not compiled.
- Source: Source/0368-sjijon-tex-templates/ (origin: https://codeload.github.com/sjijon/TeX-templates/zip/refs/heads/main; licence: not established)
- Kind: cv
- Lib: v3
- Engine: pdfLaTeX-compatible (fontawesome v4, inputenc latin1/latin9; no fontspec, no Lua)
- Look carried by: mixed (main CV: preamble file CV/MySetup.tex plus body minipages; Beamer: zip-local theme .sty files; posters: tikzposter plus a zip-local .sty; Timeline: a TikZ drawing)
- Class origin: tex-distribution-unbundled (article, beamer, tikzposter and standalone are published and not in the zip; the Quito theme .sty files and aligncolsatbottom.sty are zip-local styles, not classes)
- Main file: CV/Simple-CV.tex (other samples: Beamer presentations/beamerthemequito-light/Example-quito-light.tex, Beamer presentations/beamerthemequito-dark/Example-quito-dark.tex, Tikzposter posters/Simple poster/simple-poster.tex, Tikzposter posters/Simple poster - Landscape/simple-poster-landscape.tex, Timeline/Timeline.tex)
- Read: main yes, zip-local classes and styles all (every .sty and MySetup.tex read in full; the dark theme files read in full as a diff against the light ones plus the lines that differ)

## Verdict
no. The main sample (CV) is almost entirely lib ways with reducible `\newcommand` aliases, but its photo is cropped to a circle by a TikZ `\clip` picture, which is template-defining artwork with no declarative lib way (`ART/body`). The rest of the zip adds more blockers: the Timeline is one TikZ drawing, both Quito beamer themes paint their page background with a TikZ gradient picture (`ART/class`), and `aligncolsatbottom.sty` redefines tikzposter's `\block`, `\column` and `columns` with aux-file height arithmetic (`BESPOKE/class`).

## Blockers
- `ART/body` circular photo mask: `\clip (0,0) circle (2cm) node {\includegraphics[width=4cm]{Photo}}` inside a tikzpicture (CV/Simple-CV.tex:22-24)
- `ART/body` the whole Timeline sample is one TikZ picture (standalone class, filled regions, braces, arrows, ticks), not inside a float (Timeline/Timeline.tex:15-67)
- `ART/class` Beamer background template is a tikzpicture of gradient fills and a page-dependent cover rectangle (Beamer presentations/beamerthemequito-light/beamerouterthemequito-light.sty:2-10; Beamer presentations/beamerthemequito-dark/beamerouterthemequito-dark.sty:2-10)
- `BESPOKE/class` `aligncolsatbottom.sty` replaces tikzposter's `\block`, `\column` and `columns` with code that writes column heights to the aux file with `\immediate\write\@auxout`, reads them back with `\ref`, and divides the difference over the blocks; uses `\LetLtxMacro`, `\newdimen`, `\loop`, and `\TP@` internals (Tikzposter posters/Simple poster/aligncolsatbottom.sty:36-118; loaded at Tikzposter posters/Simple poster/simple-poster.tex:7)
- `BESPOKE/class` Beamer footline template hand-lays an hbox of inserts and tests for an empty short institute through beamer internals `\beamer@ifempty` and `\beamer@shortinstitute` (Beamer presentations/beamerthemequito-light/beamerinnerthemequito-light.sty:29-60; Beamer presentations/beamerthemequito-dark/beamerinnerthemequito-dark.sty:36-67); borderline, counted as irreducible because the conditional drives what prints

## Class setting
- Class (main): `class.article` options: `a4paper`, `10pt` (CV/Simple-CV.tex:6)
- Class (other samples): `class.beamer` options `serif`, `10pt`, `aspectratio=169` (Beamer presentations/beamerthemequito-light/Example-quito-light.tex:1; the dark example drops `serif`, Beamer presentations/beamerthemequito-dark/Example-quito-dark.tex:1); `class.tikzposter` options `a0paper`, `portrait` or `landscape`, `margin=0pt`, `colspace=24pt`, `subcolspace=0pt`, `blockverticalspace=36pt`, `innermargin=50pt` (Tikzposter posters/Simple poster/simple-poster.tex:1; Tikzposter posters/Simple poster - Landscape/simple-poster-landscape.tex:1); `class.standalone` no options (Timeline/Timeline.tex:1)
- Class-native vocabulary used: article: `\section*`, `description`, `\thispagestyle`; beamer: `\title[short]` `\date[short]` `\author[short]` `\institute`, `\frame[plain]`, `\titlepage`, `theorem`, overlay specs `<1->` `alert@3`, `allowframebreaks`, `noframenumbering`, `\setbeameroption`; tikzposter: `\maketitle[keys]`, `columns`/`\column{w}`, `\block[titleleft,roundedcorners]`, `\innerblock[bodywidth]`, `\note[keys]`, `\definecolorstyle`, `\usecolorstyle`, `\usetheme{Default}`, `\tikzposterlatexaffectionproofoff`

## Component map
Main sample first (CV), then the other samples. `MySetup.tex` is CV/MySetup.tex.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | CV/Simple-CV.tex:6 | `class.article` | a4paper, 10pt |
| paper size | CV/Simple-CV.tex:6 | `page.class-options` | a4paper, 10pt |
| page geometry | CV/Simple-CV.tex:7 | `page.geometry` | vmargin=1.5cm, hmargin=1.5cm |
| input encoding, font encoding | CV/MySetup.tex:5-6 | `font.fontenc-t1` | inputenc latin1, fontenc T1 |
| language | CV/MySetup.tex:7 | `lang.babel` | english |
| icons | CV/MySetup.tex:8; CV/Simple-CV.tex:39,42 | `font.icons` | fontawesome, `\faEnvelopeO` `\faChain` |
| month name | CV/MySetup.tex:9,50 | `front.datetime` | datetime package, `\monthname` in the "Last updated" line |
| colour package | CV/MySetup.tex:10 | `color.xcolor` | usenames, dvipsnames |
| colours | CV/MySetup.tex:30-31 | `color.xcolor` | ColorOne RGB 0,110,140; ColorTwo RGB 120,0,120 (gold alternative commented, line 32) |
| links | CV/MySetup.tex:11,13; CV/Simple-CV.tex:40,43,133 | `meta.hyperref` | colorlinks=true, urlcolor=ColorTwo; `\href` (second plain `\usepackage{hyperref}` at line 13 is a repeat load) |
| photo and graphics package | CV/MySetup.tex:15; CV/Simple-CV.tex:23 | `fig.graphicx` | `\includegraphics[width=4cm]{Photo}` (the circular crop is ART, see Blockers) |
| circular photo mask | CV/Simple-CV.tex:22-24; CV/MySetup.tex:12 | `art.tikz` | tikzpicture, `\clip (0,0) circle (2cm)`: ART/body |
| page numbers off | CV/MySetup.tex:23 | `pgnum.pagenumbering` | `\pagenumbering{gobble}` |
| page style | CV/Simple-CV.tex:12 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| line spacing | CV/MySetup.tex:24 | `sp.linespread` | `\renewcommand{\baselinestretch}{1.5}` |
| paragraph indent | CV/MySetup.tex:25 | `sp.lengths` | `\parindent`=0pt |
| setspace, enumitem loaded | CV/MySetup.tex:14,16 | `sp.setspace`, `list.enumitem` | loaded, no option, no command called by the sample |
| two-column page layout | CV/Simple-CV.tex:17-18,86-92,97-98,172-173 | `box.minipage`, `fig.adjustbox` | minipage 0.3, 0.05, 0.6 of `\textwidth`; `adjustbox` key `valign=t` around each |
| gap between columns | CV/Simple-CV.tex:86,92 | `sp.manual-space` | `\hfill` |
| vertical rule | CV/MySetup.tex:40-42; CV/Simple-CV.tex:89 | `sp.rule`, `color.xcolor` | `\rule{1pt}{\textheight}` in ColorOne, via `\newcommand` alias |
| vertical gaps | CV/MySetup.tex:56-58; CV/Simple-CV.tex:26,46,56,77,151 | `sp.manual-space` | `\vskip12pt` alias `\MySkip`; `\vfill` |
| name | CV/Simple-CV.tex:29 | `font.size-commands`, `mark.kernel` | `\LARGE`, `\bfseries` |
| centred block, line breaks | CV/Simple-CV.tex:21,33-35 | `sp.ragged`, `sp.manual-space` | `center` env, `\\` |
| section headings | CV/Simple-CV.tex:49,59,99,111,130,139,145,154,163 | `head.kernel` | starred `\section*` (no numbers) |
| heading colour | CV/MySetup.tex:17,34-35 | `head.sectsty` | `\sectionfont{\color{ColorOne}}`, `\subsectionfont{\color{ColorOne}}` |
| ragged text | CV/Simple-CV.tex:50,61,101,113,132,141,147 | `sp.ragged` | `\raggedright` |
| bullet list by hand | CV/Simple-CV.tex:51-54 | `math.kernel`, `sp.manual-space` | `\textcolor{ColorOne}{$\circ$}` and `\\`; no list environment |
| dated entries | CV/Simple-CV.tex:60-75,100-108,112-127 | `list.kernel` | `description` with `\item[\normalfont \textcolor{ColorOne}{date}]` |
| publication items | CV/Simple-CV.tex:131-137 | `list.kernel`, `mark.ulem`, `mark.kernel` | `description`, `\underline`, `\textbf`, `{\it }` |
| skills tables | CV/Simple-CV.tex:155-159,164-167 | `tbl.tabular` | `{ll}` rows; `\SkillBull` wraps maths bullets (`math.kernel`) in ColorTwo (CV/MySetup.tex:69-71) |
| balanced skills columns | CV/Simple-CV.tex:153,161,168 | `cols.multicol` | `multicols{2}`, `\columnbreak` |
| contact links | CV/MySetup.tex:63-65; CV/Simple-CV.tex:40,43 | `meta.hyperref`, `color.xcolor` | `\myhref{url}{text}` = `\href` with ColorTwo text |
| last-updated footer | CV/MySetup.tex:47-51; CV/Simple-CV.tex:170 | `sp.manual-space`, `sp.ragged`, `font.size-commands`, `front.datetime` | `\vfill`, `\centering`, `\small`, `\monthname` and `\the\year` |
| beamer class, theme | Beamer presentations/beamerthemequito-light/Example-quito-light.tex:1,12 | `class.beamer`, `slide.beamer-theme` | serif,10pt,aspectratio=169; theme `quito-light` (zip-local, name is the parameter) |
| beamer title data and title frame | Beamer presentations/beamerthemequito-light/Example-quito-light.tex:2-5,17-19 | `front.class-native` | `\title[..]`, `\date[..]`, `\author[..]`, `\institute`, `\titlepage` |
| beamer notes, pgfpages | Beamer presentations/beamerthemequito-light/Example-quito-light.tex:7,9 | `pg.pgfpages`, `slide.beamer-mode` | `\setbeameroption{hide notes}` |
| beamer toc, sections | Beamer presentations/beamerthemequito-light/Example-quito-light.tex:22-24,27-28 | `toc.kernel`, `head.kernel` | `\tableofcontents`, `\section`, `\subsection` |
| beamer theorem, list, overlays | Beamer presentations/beamerthemequito-light/Example-quito-light.tex:32-34,43-47 | `thm.class-native`, `list.kernel`, `slide.beamer-mode` | `theorem` env, `itemize` with `<1->` `<3-\|alert@3>` |
| beamer references | Beamer presentations/beamerthemequito-light/Example-quito-light.tex:51-55 | `bib.bibtex-bst` | `\bibliographystyle{abbrvnat}`, `\bibliography{Biblio}`, `\nocite{*}` |
| beamer theme load | Beamer presentations/beamerthemequito-light/beamerthemequito-light.sty:6-8 | `slide.beamer-theme` | inner, outer, colour theme `quito-light` |
| beamer colours | Beamer presentations/beamerthemequito-light/beamerthemequito-light.sty:20-28 | `color.xcolor` | MyBlue 0,97,165; MyGray 120,120,120; MyGreen; MyRed 200,0,0; ColorOne..Four |
| beamer misc settings | Beamer presentations/beamerthemequito-light/beamerthemequito-light.sty:33-35 | `slide.beamer-template` | navigation symbols empty, `\setbeamercovered{transparent}`, `\addtobeamertemplate{headline}` with `\vskip 6pt` |
| beamer colour roles | Beamer presentations/beamerthemequito-light/beamercolorthemequito-light.sty:4-14 | `slide.beamer-template` | `\setbeamercolor` for structure, title page header, author, date, item, alerted text, title in head/foot, frame title |
| beamer item and toc templates | Beamer presentations/beamerthemequito-light/beamercolorthemequito-light.sty:17-21 | `slide.beamer-template` | `\setbeamertemplate` for itemize item, section in toc, subsection in toc |
| beamer fonts | Beamer presentations/beamerthemequito-light/beamerinnerthemequito-light.sty:7-14 | `slide.beamer-template` | `\setbeamerfont` sizes for title, author, date, head/foot, frametitle, framesubtitle |
| beamer frame title | Beamer presentations/beamerthemequito-light/beamerinnerthemequito-light.sty:20-24 | `slide.beamer-template`, `sp.rule`, `sp.ragged` | `\setbeamertemplate{frametitle}`: `\raggedleft`, rule 0.33`\paperwidth` x 0.5pt in ColorOne |
| beamer footline | Beamer presentations/beamerthemequito-light/beamerinnerthemequito-light.sty:29-60 | `slide.beamer-template` | `\defbeamertemplate*{footline}`: beamercolorbox with author (institute), title, date, frame n/N; internal empty-test (BESPOKE/class, see Blockers) |
| beamer blocks, notes, bibliography | Beamer presentations/beamerthemequito-light/beamerinnerthemequito-light.sty:66-83 | `slide.beamer-template` | blocks `rounded,shadow=false`, block title/body colours, note colours, empty bibliography entry templates |
| beamer title page | Beamer presentations/beamerthemequito-light/beamerouterthemequito-light.sty:16-39 | `slide.beamer-template` | `\defbeamertemplate*{title page}`: four beamercolorboxes (title, author, institute, date) with `\vfill` |
| beamer background | Beamer presentations/beamerthemequito-light/beamerouterthemequito-light.sty:2-10 | `art.tikz` | tikzpicture gradient bar, white cover from page 2: ART/class |
| beamer dark variant | Beamer presentations/beamerthemequito-dark/beamercolorthemequito-dark.sty:4-22; Beamer presentations/beamerthemequito-dark/beamerinnerthemequito-dark.sty:7-9,30-31,76-77; Beamer presentations/beamerthemequito-dark/beamerthemequito-dark.sty:22-28 | `slide.beamer-template`, `color.xcolor` | white text colours, ColorOne!45!black blocks, MyOrange 255,80,30, empty headline; same ways as light |
| beamer dark background | Beamer presentations/beamerthemequito-dark/beamerouterthemequito-dark.sty:2-10 | `art.tikz` | tikzpicture gradient fills: ART/class |
| poster class and options | Tikzposter posters/Simple poster/simple-poster.tex:1 | `class.tikzposter`, `page.class-options` | a0paper, portrait (landscape in the other poster), margin, colspace, blockverticalspace, innermargin |
| poster encoding, maths, filler | Tikzposter posters/Simple poster/simple-poster.tex:3,5,6 | `font.fontenc-t1`, `math.amsmath`, `math.amssymb`, `draft.todo` | inputenc latin9; amsmath, amssymb; `\lipsum[n]` filler |
| poster citations | Tikzposter posters/Simple poster/simple-poster.tex:4,225-227 | `bib.natbib`, `bib.bibtex-bst` | natbib `square,numbers`; `\bibliographystyle{unsrtnat}`, `\bibliography{BibPoster}`, `\nocite{*}` |
| poster font | Tikzposter posters/Simple poster/simple-poster.tex:15-16 | `font.helvet`, `font.family-default` | `helvet`; `\renewcommand{\familydefault}{\sfdefault}` |
| poster colours | Tikzposter posters/Simple poster/simple-poster.tex:19-21 | `color.xcolor` | MyOrange 0.8,0.33,0; MyBrown 0.28,0.2,0.2; MyGreen 0.33,0.42,0.18 |
| poster theme and colour style | Tikzposter posters/Simple poster/simple-poster.tex:24-53 | `poster.tikzposter` | `\usetheme{Default}`, `\definecolorstyle{MyStyle2016}` (title, background, block, innerblock, note colours via `\colorlet`), `\usecolorstyle[colorPalette=sampleColorPalette]` |
| poster credit line off | Tikzposter posters/Simple poster/simple-poster.tex:11 | `poster.tikzposter` | `\tikzposterlatexaffectionproofoff` |
| poster title block | Tikzposter posters/Simple poster/simple-poster.tex:55-60,72 | `poster.tikzposter` | `\maketitle[width=0.96\linewidth,titletoblockverticalspace=36pt,linewidth=0,roundedcorners=10]` |
| poster columns and blocks | Tikzposter posters/Simple poster/simple-poster.tex:77-78,83,128,222,242 | `poster.tikzposter` | `columns`, `\column{0.33}`/`{0.34}`, `\block[titleleft,roundedcorners=16]`, `\innerblock[bodywidth=0.6\linewidth]`, `\note[width=14cm,targetoffsetx,targetoffsety,rotate=15]` |
| poster block contents | Tikzposter posters/Simple poster/simple-poster.tex:165-172,201,224-236 | `tbl.tabular`, `fig.graphicx`, `box.minipage` | `{l\|c\|r\|}` table, `Figures/Image1`, bibliography minipage 0.73 and logo minipage 0.27 |
| poster maths | Tikzposter posters/Simple poster/simple-poster.tex:129-137 | `math.amsmath` | `\left\{ \begin{aligned}..` |
| poster column bottoms | Tikzposter posters/Simple poster/simple-poster.tex:7; Tikzposter posters/Simple poster/aligncolsatbottom.sty:36-118 | none | `colalign` option; BESPOKE/class |
| landscape poster | Tikzposter posters/Simple poster - Landscape/simple-poster-landscape.tex:1,7,78,136,184,194-198,218-241 | `class.tikzposter`, `cols.multicol`, `box.minipage`, `list.kernel` | landscape option, columns 0.25/0.5/0.25, `multicols{4}` bibliography, itemize; no aligncolsatbottom |
| timeline class, colours | Timeline/Timeline.tex:1,3,6-8 | `class.standalone`, `color.xcolor` | standalone; named dvipsnames MidnightBlue, Dandelion, Plum |
| timeline drawing | Timeline/Timeline.tex:4,12-13,15-67 | `art.tikz` | `\tikzstyle`, coordinates, fills, shade, pattern, braces, arrows, `\foreach` ticks and year labels: ART/body |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `MySetup.tex` (zip-local preamble file, loaded by `\input`) | CV/Simple-CV.tex:8; CV/MySetup.tex:1-71 | yes | Only `\usepackage` lines, `\definecolor`, `\sectionfont`, `\pagenumbering`, `\baselinestretch`, `\parindent` and five `\newcommand` aliases, all in the Component map |
| `\MyVerticalRule` | CV/MySetup.tex:40-42 | yes | `sp.rule` `\rule{1pt}{\textheight}` + `color.xcolor` `\textcolor{ColorOne}` |
| `\LastUpdate` | CV/MySetup.tex:47-51 | yes | `\vfill`, `\centering`, `\small`, `\textcolor{ColorOne}{Last updated: \monthname,~\the\year.}` (datetime) |
| `\MySkip` | CV/MySetup.tex:56-58 | yes | `\vskip12pt` (`sp.manual-space`) |
| `\myhref` | CV/MySetup.tex:63-65 | yes | `\href{#1}{\textcolor{ColorTwo}{#2}}` (`meta.hyperref`, `color.xcolor`) |
| `\SkillBull` | CV/MySetup.tex:69-71 | yes | `\textcolor{ColorTwo}{#1}` |
| circular photo mask `\clip ... circle` | CV/Simple-CV.tex:22-24 | no | TikZ drawing; no declarative lib way (ART/body) |
| Quito theme .sty files (`beamerthemequito-*`, inner, outer, color) | Beamer presentations/beamerthemequito-light/*.sty; Beamer presentations/beamerthemequito-dark/*.sty | partly | Colours, fonts, blocks, frametitle and title-page templates reduce to `slide.beamer-template` with `color.xcolor`; the TikZ background (outer theme lines 2-10) is ART/class and the footline conditional (inner theme) is BESPOKE/class |
| `\defbeamertemplate*{title page}` | Beamer presentations/beamerthemequito-light/beamerouterthemequito-light.sty:16-39 | yes | beamercolorbox stack with inserts, one `slide.beamer-template` body |
| `\defbeamertemplate*{footline}{SJ theme}` | Beamer presentations/beamerthemequito-light/beamerinnerthemequito-light.sty:30-59 | no | `\beamer@ifempty` / `\beamer@shortinstitute` internals decide whether the institute prints |
| `aligncolsatbottom.sty` (option `colalign`, `\newif`, counters, dimens, `\LetLtxMacro`, redefined `\block`, `\column`, `columns`, aux writes) | Tikzposter posters/Simple poster/aligncolsatbottom.sty:4-118 | no | Computes per-column height padding across two compiles through the aux file; a layout algorithm over tikzposter internals (BESPOKE/class) |
| `\tikzstyle{arrow}`, `susceptible`, ... | Tikzposter posters/Simple poster/simple-poster.tex:102-106 | n/a | content inside a poster block (see Content-opaque) |
| `\tikzstyle{descript}`, `activity` | Timeline/Timeline.tex:12-13 | no | part of the Timeline drawing (ART/body) |

## Content-opaque
- TikZ flowchart in a poster block: Tikzposter posters/Simple poster/simple-poster.tex:102-124 (landscape: Tikzposter posters/Simple poster - Landscape/simple-poster-landscape.tex:101-115)
- pgf plot of sin(x) in a poster block: Tikzposter posters/Simple poster/simple-poster.tex:154-158 (landscape: Tikzposter posters/Simple poster - Landscape/simple-poster-landscape.tex:146-150)
- Image assets `CV/Photo.pdf`, `Figures/Image1.pdf`, `Figures/Logo_GitHub.pdf` are shipped; Quito examples cite `Biblio.bib`, posters cite `BibPoster.bib` (latin9 characters in the .bib and poster .tex files)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
