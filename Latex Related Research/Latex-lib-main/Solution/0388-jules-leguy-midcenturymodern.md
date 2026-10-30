no

# 0388-jules-leguy-midcenturymodern: Midcentury Modern (beamer theme)

- Unverified: read from the source, not compiled.
- Source: Source/0388-jules-leguy-midcenturymodern/ (origin: https://codeload.github.com/jules-leguy/midcenturymodern/zip/refs/heads/main; licence: CC-BY-4.0, LICENSE:1)
- Kind: presentation
- Lib: v4
- Engine: needs LuaLaTeX (`fontspec` at beamerthememidcenturymodern.sty:33; README.md:13 says "requires LuaLaTeX"; the line-balancing routine uses `\directlua`, sty:273-280 and 284, and is skipped under another engine, sty:301-303)
- Look carried by: zip-local (beamerthememidcenturymodern.sty, 1676 lines, defines the frame title band, blocks, title page, footline, section pages and toc markers; demo.tex adds only metadata, hooks and content)
- Class origin: tex-distribution-unbundled (class `beamer` is not in the zip; the theme `.sty` is zip-local: GitHub, individual author, ctan.org/pkg/beamerthememidcenturymodern returns 404)
- Main file: demo.tex (other samples: test/titlepage.tex, test/testing.tex)
- Read: main yes, zip-local classes and styles all (the single .sty, lines 1-1676). test/titlepage.tex lines 1-120, test/testing.tex lines 1-60 and an outline grep of the rest only; both are QA decks that call the same theme.

In this file `sty` means beamerthememidcenturymodern.sty. All paths are relative to Source/0388-jules-leguy-midcenturymodern/.

## Verdict
No. `beamer` itself is a published class, but the whole look sits in a zip-local theme that is not on CTAN (fails W1, and W3 because it serves one design). That theme is mostly irreducible code: a title page that auto-fits by retypesetting a block in 4% steps, a Lua-assisted binary search for balanced lines, a frame-title band and block boxes built from measured boxes and `\lastskip` tests, and TikZ overlays for the title page, footline, section pages and toc markers. The preamble parts (colours, fonts, beamer colour/font settings, bibliography) reduce to lib ways, but the blockers below do not.

## Blockers
- `BESPOKE/class` title-page auto-fit: loops that rebuild the block at 55-145% scale and measure it, line-count probes with `\prevgraf`, tracking-step picker (sty:152-188, 1309-1328, 1415-1419, 1425-1509)
- `BESPOKE/class` balanced-line search written in Lua (`mcm_overfull` via `\directlua`) plus a 12-step binary search on the measure (sty:270-303)
- `BESPOKE/class` frame title band: strutted copies measured, band height from line counts, `\vskip` placement, hand-drawn rule in the flow (sty:600-756)
- `BESPOKE/class` block begin/end templates: strut and overshoot arithmetic, `\lastskip` conditionals deciding the gap, two stacked colour boxes (sty:880-989)
- `BESPOKE/class` token-level case-changer wrapper `\mcm@upper` that strips `\def`s from beamer fields (sty:236-253)
- `BESPOKE/class` title-page flag and footline state: `\if@mcmtitlepage`, `\BeforeBeginEnvironment{frame}`, `\addtobeamertemplate{frametitle}` (sty:1045-1049, 1077-1079)
- `ART/class` title page: full-page colour fill, footer strip, seven scan lines with a logo gap computed by cosine modulation (sty:1520-1575, 1661-1673)
- `ART/class` footline progress bar and three tiny text nodes drawn in a `remember picture, overlay` tikzpicture (sty:1051-1075)
- `ART/class` section page and subsection page drawn as TikZ overlays (sty:1084-1106, 1111-1133)
- `ART/class` toc markers drawn as `\tikz{\fill ...}` square and circle (sty:1031, 1037)
- `UNMAPPED/class` frame-title band, block look, title-page layout, footline and section-page layout: no lib way holds them, and the theme that supplies them is not a way (not on CTAN, W1 fails; behaviour set by editing code, W2 fails; one design, W3 fails)

## Class setting
- Class: `class.beamer` options: `aspectratio=169` (demo.tex:6)
- Class-native vocabulary used: `\usepackage{beamerthememidcenturymodern}` (demo.tex:7), `frame` (also `[plain]`, `[plain,noframenumbering]`, demo.tex:32, 402, 417), `\titlepage` (demo.tex:50), `\title` `\subtitle` `\author` `\institute` `\date` `\titlegraphic` (demo.tex:16-20, 27), `\framesubtitle` (demo.tex:67), `columns`/`column` (demo.tex:68-69), `block` `alertblock` `exampleblock` (demo.tex:70, 79, 205), `\alert` (demo.tex:260), `\tableofcontents` (demo.tex:57), `\section` `\subsection` with `\AtBeginSection[]` `\AtBeginSubsection[]` and `\sectionpage` `\subsectionpage` (demo.tex:31-40), `\setbeamercolor` (demo.tex:401), `\appendix` (demo.tex:415); theme-own switches `\mcmTheme{Kraft|DeepBlue}` (demo.tex:12, sty:390), `\mcmTitleUppercasefalse` and length knobs (demo.tex:314-335, sty:557-576)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | demo.tex:6 | `class.beamer` | aspectratio=169 |
| page size | demo.tex:6 | `page.class-options` | aspectratio=169 (class option sets the slide size) |
| text margins | sty:28 | `slide.beamer-template` | `\setbeamersize{text margin left=2em, text margin right=2em}` (same beamer command family; not `page.geometry`) |
| beamer theme | sty:340-341 | `slide.beamer-theme` | `\usetheme{default}`, `\usefonttheme{professionalfonts}` |
| navigation symbols, frametitle continuation | sty:342, 38 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}`, `{frametitle continuation}{}` |
| font engine | sty:33, 36 | `font.fontspec` | `\defaultfontfeatures{Ligatures=TeX}` |
| body face | sty:47-51 | `font.fontspec` | `\setsansfont{TeX Gyre Heros}`, fallback Helvetica via `\IfFontExistsTF` |
| default family | sty:52 | `font.family-default` | `\familydefault` = `\sfdefault` |
| title face | sty:57-62 | `font.fontspec` | `\newfontfamily\mcmTitleFont{TeX Gyre Adventor}[LetterSpace=6.0]` |
| mono face | sty:71-80 | `font.fontspec` | `\setmonofont{Inconsolatazi4}[Extension=.otf, UprightFont=*-Regular, BoldFont=*-Bold, Scale=MatchLowercase, Ligatures=TeXOff]`, fallback Latin Modern Mono |
| tracked title-page families | sty:104-140 | `font.fontspec` | 14 `\newfontfamily` of Adventor (sty:122-140), `LetterSpace` 3 to 14, `FakeBold=2` for author (sty:118, 128-135), plus `\mcmFrameSubtitleFont` (sty:328); the choice among them is bespoke, see blockers |
| uppercase titles | sty:169, 313, 1097 | `mark.case` | `\MakeUppercase` (wrapped by bespoke `\mcm@upper`) |
| colour palette | sty:348-385 | `color.xcolor` | 22 `\definecolor{..}{HTML}{..}` (e.g. mcmTerracotta 9C4732, mcmDeepBlue 002d4d), `\colorlet` aliases (sty:376-385) |
| theme colours | sty:430-457, 462-467 | `slide.beamer-template` | `\setbeamercolor` for frametitle, framesubtitle, block title (alerted, example), block body, alerted text, example text, section/subsection in toc, bibliography entries, normal text, structure |
| link colours | sty:34, 456 | `meta.hyperref` | `\hypersetup{urlcolor, linkcolor, citecolor=mcmPrimary}` |
| beamer fonts | sty:478-487 | `slide.beamer-template` + `font.size-commands` | `\setbeamerfont{title}{size={\fontsize{21}{23}}, series=\bfseries}`, frametitle `\large`, block title `\normalsize`, etc. |
| theme switch | sty:390-417; demo.tex:12, 104-116 | `color.xcolor` + `slide.beamer-template` + `meta.hyperref` | `\mcmTheme` is `\ifstrequal` over ten `\colorlet` plus `\mcm@applytheme`; grouped use in body switches palette locally |
| ragged setting | sty:35, 616, 1311 | `sp.ragged` | `ragged2e` loaded, `\raggedright` (frame title), `\raggedleft` (title block) |
| frame title band | sty:645-756 | `slide.beamer-template` for the hook, band itself BESPOKE | `\setbeamertemplate{frametitle}`, lengths `\mcmFrameTitleHeight=1.10cm`, `\mcmFrameTitleLeft=0.35cm` (sty:557-576) |
| frame subtitle | demo.tex:67; sty:333-337 | `class.beamer` (command); the format macro calls the bespoke `\mcm@upper` | `\framesubtitle`, 8.5pt tracked Adventor caps, `\mcmFrameSubtitleTracking=10.0` |
| plain block | demo.tex:70; sty:938-953 | `class.beamer` (env), template BESPOKE | pip rule 3pt x 1.75ex, `\mcmBlockSep=1em`, `\mcmBlockPad=0.45em` |
| alert, example blocks | demo.tex:79, 205; sty:959-989 | `class.beamer` (env), template BESPOKE | band `accent!35!mcmBg`, body `accent!12!mcmBg`, title `accent!75!black` (sty:436-441) |
| itemize marks | demo.tex:71-75; sty:1003-1005 | `list.kernel` + `slide.beamer-template` | `\setbeamertemplate{itemize item}{\textcolor{\mcmBulletColor}{\textendash}}` at 3 levels |
| enumerate marks | demo.tex:94-100; sty:1014-1025 | `list.kernel` + `slide.beamer-template` | numerals `\bfseries` level 1, `\small` `\footnotesize` `\scriptsize` by level |
| bullet colour per block | sty:455, 470, 975, 994-997 | `slide.beamer-template` + `color.xcolor` | `\mcmBulletColor` swapped to mcmPip / mcmAlert / mcmExample inside block templates |
| contents slide | demo.tex:56-58 | `toc.kernel` | `\tableofcontents` in a frame |
| toc entry markers | sty:1029-1040 | `art.tikz` (ART) | `\tikz{\fill[mcmPip](0,0) rectangle (0.14,0.14);}`, `circle(0.055)` |
| section, subsection hooks | demo.tex:31-40 | `slide.beamer-section-hook` | `\AtBeginSection[]{\begin{frame}[plain]\sectionpage\end{frame}}`, same for subsection |
| section, subsection pages | sty:1084-1133 | `art.tikz` (ART) | `remember picture, overlay` fills, `\node` at `current page` anchors |
| footline | sty:1051-1079 | `art.tikz` (ART) | progress bar `min(1, \insertframenumber/\inserttotalframenumber)`, tiny short author, short title, frame n / total |
| title-page data | demo.tex:16-20 | `front.class-native` | `\title` `\subtitle` `\author` `\institute` `\date{\today}` |
| title-page layout | sty:1511-1674 | `art.tikz` (ART) + BESPOKE | page fill, strip `\mcmFooterHeight=4.15em`, 7 scan lines every `\mcmLineSpacing=0.15cm`, block width 0.88`\paperwidth`, auto-fit 55-145% |
| logo | demo.tex:27; sty:1513-1517 | `fig.graphicx` | `\titlegraphic{\includegraphics[height=0.8cm]{logos/your-logo-kraft.pdf}}` (PDF shipped, logos/your-logo-kraft.pdf) |
| columns | demo.tex:68-86 | `class.beamer` | `columns[T]`, `column{0.48\textwidth}` |
| inline marks | demo.tex:259-260 | `mark.kernel` | `\textbf`, `\textit`, `\alert`, `\texttt` |
| spacing, sizes | demo.tex:258, 145 | `sp.manual-space`, `font.size-commands` | `\vspace{0.5em}`, `\small` |
| bibliography | demo.tex:8-9, 385-390, 394 | `bib.biblatex-biber` | `backend=biber, style=authoryear, sorting=nyt`, `\addbibresource{demo.bib}`, `\parencite`, `\printbibliography[heading=none]` |
| cite colour | demo.tex:42 | `color.xcolor` | `\AtEveryCite{\color{mcmPrimary}}` (biblatex hook, argument is a colour) |
| closing slide colour | demo.tex:401-409 | `slide.beamer-template` + `color.xcolor` | `\setbeamercolor{normal text}{fg=mcmPrimaryFg,bg=mcmAlert!70}` |
| appendix, no numbering | demo.tex:415-417 | `num.appendix` | `\appendix`, `[plain,noframenumbering]` |
| other sample: overlays, table, footnote | test/testing.tex:605, 848, 548, 16, 922 | `slide.beamer-mode`, `tbl.tabular`, `tbl.booktabs`, `fn.kernel` | `\only<1>`, `\pause`, `tabular{lc}`, `booktabs`, `\footnotemark[1]` (outline grep only) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\mcm@lines` `\mcm@pick` `\mcm@decide` `\mcm@picknames` | sty:152-188 | no | typesets throwaway boxes, reads `\prevgraf`, picks one of three font families by line count: layout computation |
| `\mcm@balance` and Lua `mcm_overfull` | sty:270-303 | no | Lua node traversal plus binary search on the measure; no lib way |
| `\mcm@upper` `\mcm@stripdefs` `\mcm@takedef` | sty:236-253 | no | hand-rolled token processing so `\MakeUppercase` survives beamer's `\def`s |
| frame title (`\mcm@ftbuild`, `\mcm@ftcount`, `\mcm@ftifny`, template) | sty:600-756 | no | box measuring, line-count height formula, computed `\vskip`, drawn rule |
| block templates (`\mcmBlockAbove`, `\mcm@blockrefs`, `\mcm@bottrim`, `\mcm@bandbegin`) | sty:880-989 | no | `\lastskip` conditionals and strut arithmetic drive the printed gaps |
| title-page auto-fit (`\mcm@tbuild`, `\mcm@tfit`, `\mcm@tcountlines`, `\mcm@tifny`, `\mcm@tcapskip`) | sty:1309-1509 | no | rebuild-and-measure loops, scale in percent, rule position computed |
| title-page and footline flags | sty:1045-1049, 1077-1079 | no | hand-rolled `\newif` read by the footline to decide what prints |
| title/footline/section/toc TikZ | sty:1029-1040, 1051-1133, 1520-1673 | no | template-defining drawings (ART) |
| length and format knobs (`\mcmFrameTitleHeight`, `\mcmTitleFS`, `\mcmTitleMinScale`, ...) | sty:557-576, 854-870, 1179-1260, 1366-1372 | no | parameters of the irreducible code above; no published way reads them |
| `\mcmTheme`, `\mcm@applytheme` | sty:390-457 | yes | `color.xcolor` `\colorlet` aliases + `slide.beamer-template` `\setbeamercolor` + `meta.hyperref` `\hypersetup`, one palette per theme |
| colour definitions | sty:348-385 | yes | `color.xcolor` `\definecolor`/`\colorlet` |
| font fallback chain (`\IfFontExistsTF`, `\if@mcmfontspec`) | sty:43-80, 120 | yes | an emitter writes the chosen `font.fontspec` call (TeX Gyre Heros, Adventor, Inconsolatazi4) directly |
| itemize and enumerate item templates, `\mcmBulletColor` | sty:994-1025 | yes | `slide.beamer-template` item templates and colour; effect is a mark and a colour |
| load-only helpers `calc`, `etoolbox` | sty:30, 32 | not a way | supply `\dimexpr`-style helpers and `\ifstrequal`, `\BeforeBeginEnvironment` to the bespoke code; considered, not proposed |
| README logo SVGs | img/logo-light.svg, img/logo-dark.svg | n/a | documentation images, not loaded by any .tex |

## Content-opaque
- TikZ timeline (axis, ticks, three bars) inside a block in a backup frame (demo.tex:425-447).
- Logo artwork: logos/your-logo.tex is a standalone TikZ drawing (orbits and wordmark, your-logo.tex:37-83) compiled to the shipped PDFs; the theme only measures the box it is given (sty:1513-1517). Treated as an image asset, not as template.
- test/testing.tex diagram macros `\flowdiagram`, `\imgplaceholder`, `\statbadge` (testing.tex:56-94) are QA content (outline grep only).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
