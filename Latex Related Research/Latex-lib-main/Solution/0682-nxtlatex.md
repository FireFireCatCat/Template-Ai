yes

# 0682-nxtlatex: nxtlatex (NXT faculty Beamer theme, thesis class and letter option, Reutlingen University)

- Unverified: read from the source, not compiled.
- Source: Source/0682-nxtlatex/ (origin: https://mirrors.ctan.org/macros/latex/contrib/nxtlatex.zip; licence: LPPL 1.3c for the code, OFL 1.1 for the font NXT_Logo.otf)
- Kind: presentation
- Lib: v5
- Engine: needs LuaLaTeX (the theme loads `fontspec` and `unicode-math` and the shipped OpenType NXT_Logo.otf, nxtlatex.dtx:2028-2037, 738-739; README.md:28 says all components require LuaLaTeX)
- Look carried by: class (the published NXT Beamer theme `beamerthemeNXT`, loaded by `\usetheme{NXT}` at BeispielfolienNXT.tex:4; the sample's own preamble adds only booktabs, xcolor[table], babel and one alias macro)
- Class origin: ctan
- Main file: BeispielfolienNXT.tex (other samples: BeispielbriefNXT.tex, Beispielthesis/BeispielthesisNXT.tex)
- Read: main yes, zip-local classes and styles all

## Verdict
The zip is the CTAN package `nxtlatex` itself (also in TeX Live and MiKTeX, README.md:84-85), so its theme, class and logo packages are published (W1), not zip-local. The main sample is a plain Beamer deck: `class.beamer` plus `\usetheme{NXT}` plus ordinary frames, columns, lists, blocks, one booktabs table and verbatim, all of which map to lib ways. Even read as if the theme code were in scope, it reduces to `\setbeamertemplate`/`\setbeamercolor`/`\setbeamerfont`, `fontspec`, `unicode-math`, `geometry` and box code (table below); the only piece that is expl3 layout code is the logo macro package, which the sample calls but does not copy, and which is kept as a published package under `font.icons`.
Recorded, not blockers: LuaLaTeX only; Segoe UI (Windows system font) and the university logo and skyline PDFs are not shipped (the two macros skip missing files, nxtlatex.dtx:876-877); the thesis sample's Python/GLPK `make daten` regenerates files that are already shipped (README.md:62-80) and is outside this verdict, as are its chapter files, which were not read.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `aspectratio=169` (BeispielfolienNXT.tex:2); theme `NXT` (`slide.beamer-theme`, BeispielfolienNXT.tex:4)
- Class-native vocabulary used: `frame` (plain at :24, fragile at :200 and :220, `{title}` form at :29), `\titlepage` (:25), `\title` `\subtitle` `\author` `\date` (:15-18), `columns[T]` and `column{width}` (:31-52, :101-119, :150-172, :179-195), `block` `alertblock` `exampleblock` (:59, :66, :72), `itemize` `enumerate` (:34, :46, :103). Theme-native: `\nxtlogo` `\nxtlogonut` `\nxthsrtlogo` `\nxtlogostandard` with keys `width` `height` `schema` (nxtlatex.dtx:851-869, 770-795); `\nxtlogofont` (nxtlatex.dtx:738); `\hsrtlogograu` `\hsrtskyline` (nxtlatex.dtx:876-877); palette names `nxtgreen`, `nxtgreen.2`..`.4`, `nxt.gray0`..`nxt.gray8`, `nxt.violet` `nxt.blue` `nxt.orange` `nxt.yellow` `nxt.red` `nxt.magenta` `nxt.navy` `nxt.cyan` `nxt.olive` `nxt.lightolive` `nxt.lightblue` `nxt.darkblue` `footgray` (nxtlatex.dtx:680-710).

## Component map
Main sample (BeispielfolienNXT.tex):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | BeispielfolienNXT.tex:2 | `class.beamer` | aspectratio=169 |
| beamer theme | BeispielfolienNXT.tex:4 | `slide.beamer-theme` | `\usetheme{NXT}`: published theme file beamerthemeNXT.sty (nxtlatex.dtx:2001-2164) |
| table rules | BeispielfolienNXT.tex:5, :84-91 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| colour package | BeispielfolienNXT.tex:6 | `color.xcolor` | option `table` |
| table colour option | BeispielfolienNXT.tex:6 | `tbl.colortbl` | load-only via `xcolor[table]`; no row or cell colour command used |
| language | BeispielfolienNXT.tex:7 | `lang.babel` | ngerman |
| title and meta | BeispielfolienNXT.tex:15-18 | `front.maketitle` | `\title` `\author` `\date{\today}` |
| subtitle and title frame | BeispielfolienNXT.tex:16, :24-26 | `front.class-native` | `\subtitle`, `\begin{frame}[plain]\titlepage`; look from the theme's title-page template (row below) |
| frames, columns, blocks | BeispielfolienNXT.tex:29-76, :99-121 | `class.beamer` | native `frame`, `columns[T]`, `column{0.48\textwidth}` (also 0.55 and 0.4), `block` `alertblock` `exampleblock` (vocabulary, listed under Class setting; no separate component way) |
| lists | BeispielfolienNXT.tex:34-50, :103-111 | `list.kernel` | nested `itemize`, `enumerate`; bullets and numbers styled by the theme (rows below) |
| table body | BeispielfolienNXT.tex:81-92, :207-215, :232-235 | `tbl.tabular` | `table` float, `tabular{llr}`, `tabular{@{}ll@{}}` |
| caption | BeispielfolienNXT.tex:93 | `cap.kernel` | `\caption`; label colour set in the theme (nxtlatex.dtx:2069) |
| alignment | BeispielfolienNXT.tex:82, :114-117 | `sp.ragged` | `\centering`, `center` |
| manual spacing | BeispielfolienNXT.tex:11, :64, :70, :115, :152-159, :205 | `sp.manual-space` | `\kern1.5em`, `\bigskip`, `\medskip`, `\\[10pt]`, `\\[3pt]` |
| emphasis and font switches | BeispielfolienNXT.tex:33, :36, :60, :85 | `mark.kernel` | `\textbf`, `\emph` (redefined by the theme, nxtlatex.dtx:2154), `\texttt`, `\ttfamily` |
| font sizes | BeispielfolienNXT.tex:11, :116, :160 | `font.size-commands` | `\footnotesize`, `\LARGE` |
| logo font switch | BeispielfolienNXT.tex:116 | `font.fontspec` | `\nxtlogofont` = `\newfontfamily{\nxtlogofont}{NXT_Logo.otf}[BoldFont=*,ItalicFont=*,BoldItalicFont=*,SlantedFont=*]` (nxtlatex.dtx:738-739) |
| logo macros | BeispielfolienNXT.tex:115, :208-214 | `font.icons` | package `nxtlatexlogos`: `\nxtlogo[width=0.7\textwidth]`, `\nxtlogo[height=6mm]`, `\nxtlogonut`, `\nxthsrtlogo[height=6mm, schema=schwarz]`, `schema=weisseZeile`, `\nxtlogostandard`; keys `width` `height` `schema` (closed list) `zeichenfarbe` `nxtfarbe` `zeilenfarbe` `farbe` `alt` (nxtlatex.dtx:770-795) |
| university logo, skyline | BeispielfolienNXT.tex:233-234 | `fig.graphicx` | `\hsrtlogograu[height=6mm]`, `\hsrtskyline[height=4mm]` = `\IfFileExists{..}{\includegraphics[..]{..}}{}` (nxtlatex.dtx:876-877); PDFs not shipped |
| colour use | BeispielfolienNXT.tex:11, :116, :153-193, :214 | `color.xcolor` | `\colorbox{#1}`, `\color{nxtgreen}`, named colours from nxtlatexcolors (nxtlatex.dtx:680-715) |
| display maths | BeispielfolienNXT.tex:127-129, :134-136 | `math.kernel` | `\[ \]`; `\int`, `\mathrm{d}` are content |
| verbatim | BeispielfolienNXT.tex:208-213, :226-230 | `code.verbatim` | `\verb\|..\|`, `verbatim` in `[fragile]` frames |

Loaded by the theme (nxtlatex.dtx, not by the sample; recorded because the sample loads the theme):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| base themes | nxtlatex.dtx:2005-2010 | `slide.beamer-theme` | `\usetheme{default}` `\usecolortheme{default}` `\useinnertheme{default}` `\useoutertheme{default}` |
| page size | nxtlatex.dtx:2013 | `page.geometry` | papersize={16cm,9cm} |
| footskip | nxtlatex.dtx:2084 | `page.setlength` | `\addtolength{\footskip}{5mm}` |
| colours | nxtlatex.dtx:2018-2020, 2049-2051, 2058-2062, 2069 | `slide.beamer-template` | `\setbeamercolor`: title and frametitle fg=nxtgreen, footline fg=black bg=white, enumerate item/subitem/subsubitem fg=nxtgreen, block title nxtgreen, alerted nxt.red, example nxt.blue, caption name fg=normal text.fg |
| block title fonts | nxtlatex.dtx:2057, 2059, 2061 | `slide.beamer-template` | `\setbeamerfont{block title...}{series=\bfseries}` |
| bullets | nxtlatex.dtx:2045-2047 | `slide.beamer-template` | `\setbeamertemplate{itemize item}` = nxtgreen logo glyph; subitem and subsubitem = nxtgreen `$\blacksquare$` |
| frame title | nxtlatex.dtx:2072-2082 | `slide.beamer-template` | `beamercolorbox[wd=\paperwidth,ht=1.8ex,dp=1ex]{frametitle}`, `\hspace{1cm}`, `\nxtlogo[height=4mm]` at the right |
| footline | nxtlatex.dtx:2087-2101 | `slide.beamer-template` | `beamercolorbox[wd=\paperwidth,ht=2ex,dp=1ex]{footline}`, `\tiny`, footgray, short author, short title, date, frame number over total; omitted on frame 1 (`\ifnum\c@framenumber=1\else`) |
| title page | nxtlatex.dtx:2104-2147 | `slide.beamer-template` | `\defbeamertemplate*{title page}{simple}`: 70 % nxtgreen band (white title, subtitle, author, date) and 30 % white band with `\nxthsrtlogo[height=.12\paperheight]`, from `\colorbox`, `\parbox`, `\vbox to \paperheight`, `\offinterlineskip` |
| navigation symbols | nxtlatex.dtx:2150 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` |
| text fonts | nxtlatex.dtx:2028-2034 | `font.fontspec` | main and sans Segoe UI (bold Segoe UI Semibold), mono Source Code Pro (bold Semibold) |
| math font | nxtlatex.dtx:2036-2037, 2025 | `font.unicode-math` | `\setmathfont{Euler-Math}`; `amsmath` loaded first (`math.amsmath`) |
| raggedness | nxtlatex.dtx:2022, 2157-2162, 2077 | `sp.ragged` | `ragged2e` `\RaggedRight` inside `itemize` and `enumerate`; `\raggedright` in the frame title |
| overlay emphasis | nxtlatex.dtx:2154 | `slide.beamer-mode` | `\renewcommand<>{\emph}[1]{{\only#2{\bfseries\color{nxtgreen}}#1}}` |
| PDF output intent | nxtlatex.dtx:656-678 | `meta.documentmetadata` | `\SetKeys[document/metadata]{colorprofiles={A=sRGB.icc}}` when `\DocumentMetadata` is active; otherwise the package writes the sRGB output intent itself (see Bespoke code); no visible effect |

Other samples (read at main-file level and in the class code only; their chapter files were not read):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| letter class and option | BeispielbriefNXT.tex:2-3 | `class.scrlttr2` | `\LoadLetterOption{nxtbrief}` (published LCO, nxtlatex.dtx:1894-1995); vocabulary `\setkomavar` `\opening` `\closing` `\encl` `letter` |
| letter KOMA options | nxtlatex.dtx:1901-1908 | `ltr.opening` | fontsize=10pt, foldmarks=MPvb, backaddress=plain, pagenumber=footright, refline=nodate, parskip=half-; `\setplength` positions (nxtlatex.dtx:1927-1946) |
| letter extras | nxtlatex.dtx:1910-1923 | `font.fontspec` | Segoe UI and Source Code Pro; also `sp.microtype` stretch=10, `pgnum.lastpage`, `meta.hyperref` colorlinks, `bg.eso-pic` for the skyline (nxtlatex.dtx:1985-1989) |
| letter filler text | BeispielbriefNXT.tex:6 | `draft.todo` | `blindtext` option math (filler) |
| thesis class | BeispielthesisNXT.tex:26 | `class.nxtthesis` | options german, libertinus, logo; published class (nxtlatex.dtx:884-1889), `\LoadClass[a4paper,11pt]{report}` at nxtlatex.dtx:893; vocabulary `\adresse` `\matrikelnummer` `\akademischergrad` `\studiengang` `\abgabedatum` `\ort` `\erstpruef` `\zweitpruef` `\subtitle` `\hauptteil` `\akronym` `\Symbol` `\printsymbols` `\Index` `\addchap` `\eigenständigkeitserklärung[ki=kennzeichnung]` (BeispielthesisNXT.tex:30-43, :85-109, :225, :269, :278) |
| thesis metadata | BeispielthesisNXT.tex:5 | `meta.documentmetadata` | lang=de, pdfversion=2.0, pdfstandard=ua-2, tagging=on |
| thesis packages | BeispielthesisNXT.tex:47-49, :65-70, :80-81 | `pg.landscape` | also `fig.rotating`, `fig.graphicx`, `code.listings`, `lang.csquotes`, `mark.siunitx`, `bib.biblatex-biber` (backend=biber, style=apa) |
| thesis lists and index | BeispielthesisNXT.tex:217-221, :264 | `toc.kernel` | `\listoftables` `\listoffigures`, `\printacronyms` (class loads `acro`, nxtlatex.dtx:1496-1511: `idx.glossaries`), `\printindex` (`idx.makeidx`, nxtlatex.dtx:1489) |
| thesis structure | BeispielthesisNXT.tex:149, :227-233, :239 | `struct.input` | `\input`; `\appendix` is `num.appendix` |
| thesis box | BeispielthesisNXT.tex:168-186 | `box.fancybox` | `\fcolorbox` over `\parbox` (`box.minipage`) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\cs` colour-swatch alias | BeispielfolienNXT.tex:10-12 | yes | `\newcommand` alias for `\colorbox{c}{\kern1.5em\strut\kern1.5em}~{\footnotesize\ttfamily c}`: `color.xcolor` + `sp.manual-space` + `font.size-commands` + `mark.kernel`; inline expansion |

Published package internals read (not bespoke: the package is on CTAN, the emitter loads it unchanged; listed so the reading is visible):

| Item | Where | Note |
|---|---|---|
| expl3 logo scaling and layered glyph colours, `accsupp` alt text | nxtlatex.dtx:753-870 | layout code inside published `nxtlatexlogos`; W2 holds at its interface (keys `width` `height` `schema` `alt` and colours); W3 is the weak point (one institution), handled as `font.icons` (a symbol or logo glyph package; the package is the parameter) |
| raw `\pdfextension` output-intent code | nxtlatex.dtx:656-678 | published `nxtlatexcolors`; PDF level only |
| `\renewcommand{\@makechapterhead}`, `\@startsection` sections, `\@makecaption`, `\maketitle`, `\patchcmd{\l@chapter}` | nxtlatex.dtx:1217-1279, 1451-1454, 1650-1741 | inside published class `nxtthesis` (thesis sample only); would be irreducible if copied, so the sample is carried by `class.nxtthesis`, not rebuilt |
| `\defbeamertemplate*` title page, footline conditional | nxtlatex.dtx:2087-2147 | reducible anyway, see the theme table above |

## Content-opaque
none in the main sample. Thesis sample (not read): TikZ and MetaPost figures and Python-made tables and figures (README.md:57-65; BeispielthesisNXT.tex:50, :59).

## Lib changes
- New ways proposed: none. Considered and not proposed: a separate logo way for `nxtlatexlogos` (kept under `font.icons`; if a reviewer holds it to W3 as one-institution, the lib already treats such packages as class-like vocabulary, nxtlatex.dtx:738-870, and the verdict does not change).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
