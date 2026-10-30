yes

# 0152-medstarbeamer: MedStar Beamer Template (class `medstarbeamer` + colour theme `MedStarColors`)

- Unverified: read from the source, not compiled.
- Source: Source/0152-medstarbeamer/ (origin: https://mirrors.ctan.org/macros/latex/contrib/medstarbeamer.zip; licence: lppl1.3, README.txt:3 and medstarbeamer.cls:3)
- Kind: presentation
- Lib: v3
- Engine: pdfLaTeX-compatible (beamer plus kernel-family packages only; no fontspec, no Lua, no shell escape)
- Look carried by: class (medstarbeamer.cls and the colour theme it loads at medstarbeamer.cls:53 define the whole look; example.tex adds only metadata and content)
- Class origin: ctan (ctan.org/pkg/medstarbeamer exists: "Beamer template for MedStar Health presentations", author Anagha Kumar, LPPL 1.3; the zip is that CTAN package's own files)
- Main file: example.tex (other samples: none; CTAN also lists an `.rnw` sample that this zip does not contain)
- Read: main yes (50 lines), zip-local classes and styles all (medstarbeamer.cls 97 lines, beamercolorthemeMedStarColors.sty 41 lines, README.txt 13 lines)

## Verdict
Yes. The look is carried by a published CTAN class, `medstarbeamer`, which is a thin layer over beamer: `\LoadClassWithOptions{beamer}` (medstarbeamer.cls:8), a list of published packages, two `\defbeamertemplate*` blocks built from `beamercolorbox` rows, `\setbeamer*` calls, and a colour theme of three `\definecolor` plus `\setbeamercolor` lines. Every piece reduces to `class.beamer` plus `slide.beamer-template` / `slide.beamer-theme` / `color.xcolor` calls, with no artwork and no external tool. The two zip-local helper macros are numeric switches over a TOC frame and reduce to the selected branch (see Bespoke code); as written they also look unbalanced (an `\ifnum` without its `\fi`, an `\ifthenelse` with two arguments), which this read-only pass did not test, so the reduction is of the intended behaviour. The logo image `medstarlogo` named at medstarbeamer.cls:58 is not in the zip (missing asset, to be shipped).

## Blockers
none

## Class setting
- Class: `class.medstarbeamer` options: none (example.tex:1 `\documentclass{medstarbeamer}`); it passes all options on to `class.beamer` (medstarbeamer.cls:8 `\LoadClassWithOptions{beamer}`), so the paper is beamer's default and no `aspectratio` is set.
- Class-native vocabulary used: beamer's `frame` environment with a frame-title argument (example.tex:16,30,36,46), `\title[short]{}` `\author[short]{}` `\institute[]{}` `\date{}` and `\maketitle` inside a frame (example.tex:2-5,8-10), `\section` `\subsection` `\subsubsection` (example.tex:15,27-29,33-35,43-45), `\alert{}` (example.tex:23), `\tableofcontents[currentsection]`, `\insertnavigation`, `\insertsubsectionhead`, `\insertshortauthor` `\insertshorttitle` `\insertshortdate` `\insertframenumber` `\inserttotalframenumber`, `beamercolorbox`, `\usebeamerfont`. Class-own commands: `\sizecontentsoutline{1|2}` and `\sizecontentscurrent{1|2}` (example.tex:12-13).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example.tex:1; medstarbeamer.cls:7 | `class.medstarbeamer` | no options |
| base class it loads | medstarbeamer.cls:8 | `class.beamer` | `\LoadClassWithOptions{beamer}`, options inherited |
| page size | (none set) | `class.beamer` | beamer default; no `aspectratio` option in example.tex:1 |
| text margins | medstarbeamer.cls:49 | `slide.beamer-template` | `\setbeamersize{text margin left=0.5cm, text margin right=0.75 cm}` (same `\setbeamer*` family as `\setbeamercolor`; Rubric: the lib line's commands are examples) |
| margin package, loaded, unused | medstarbeamer.cls:9 | `page.vmargin` | `anysize` loaded; no `\marginsize` call anywhere in the zip |
| colours defined | beamercolorthemeMedStarColors.sty:9-11 | `color.xcolor` | `\definecolor{medstaryellow}{rgb}{0.91,0.78,0.04}`, `{medstarblue}{rgb}{0,0.18,0.33}`, `{medstarred}{rgb}{0.8,0,0}`; `xcolor` loaded at medstarbeamer.cls:13 |
| colour theme selection | medstarbeamer.cls:53 | `slide.beamer-theme` | `\usecolortheme{MedStarColors}`; the theme file is the zip's own, reduced by inlining beamercolorthemeMedStarColors.sty:9-35 (below) |
| frame title colours | beamercolorthemeMedStarColors.sty:17 | `slide.beamer-template` | `\setbeamercolor{frametitle}{fg=medstarblue, bg=medstaryellow}` |
| title page colours | beamercolorthemeMedStarColors.sty:18,19,23,24 | `slide.beamer-template` | `title`, `subtitle`, `author`, `date` all `fg=medstarblue` |
| palette colours | beamercolorthemeMedStarColors.sty:20-22 | `slide.beamer-template` | `palette primary` and `palette secondary`: `fg=white, bg=medstarblue`; `palette tertiary`: `fg=medstarblue, bg=medstaryellow` |
| head/foot colour parents | beamercolorthemeMedStarColors.sty:13-15 | `slide.beamer-template` | `date in head/foot` (starred form) parent=palette primary; `author in head/foot` parent=palette secondary; `title in head/foot` parent=palette tertiary |
| body text, alert, caption, item colours | beamercolorthemeMedStarColors.sty:25-29 | `slide.beamer-template` | `normal text` fg=medstarblue; `alerted text` fg=medstarred; `caption` and `caption name` fg=medstarblue; `item` fg=medstarblue |
| TOC entry colours | beamercolorthemeMedStarColors.sty:30-35 | `slide.beamer-template` | `section/subsection/subsubsection in toc` fg=medstarblue; the `... in toc shaded` variants fg=medstaryellow |
| footer (three-box strip) | medstarbeamer.cls:22-34 | `slide.beamer-template` | `\defbeamertemplate*{footline}{}`: one `\hbox` of three `beamercolorbox` (`wd=.3333333\paperwidth, ht=0.25cm, dp=0.2cm, center`) in colours `author in head/foot`, `title in head/foot`, `date in head/foot`; contents `\insertshortauthor`, `\insertshorttitle`, `\insertshortdate{}\hfill\insertframenumber{} / \inserttotalframenumber` |
| footer spacing | medstarbeamer.cls:32 | `sp.manual-space` | `\hfill` between date and frame number |
| header (navigation strip) | medstarbeamer.cls:37-41 | `slide.beamer-template` | `\defbeamertemplate*{headline}{}`: `beamercolorbox` in `section in head/foot` holding `\insertnavigation{\paperwidth}` |
| header spacing | medstarbeamer.cls:40 | `sp.manual-space` | `\vskip3pt` above and below the navigation |
| header subsection strip | medstarbeamer.cls:42-46, 54-55 | `slide.beamer-template` | `beamercolorbox[ht=0.25cm, dp=0.2cm, leftskip=0.5cm]{subsection in head/foot}` with `\usebeamerfont{subsection in head/foot}\insertsubsectionhead`; the guarding `\ifbeamer@theme@subsection` is set true at line 55, so the strip is always on |
| navigation symbols off | medstarbeamer.cls:61 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` |
| caption style | medstarbeamer.cls:62 | `slide.beamer-template` | `\setbeamertemplate{caption}[numbered]`; no caption is used in example.tex |
| covered overlay look | medstarbeamer.cls:60 | `slide.beamer-mode` | `\setbeamercovered{dynamic}` (beamer's overlay-covering setting); no overlay is used in example.tex |
| logo slot | medstarbeamer.cls:58 | `slide.beamer-template` | `\logo{...}`, beamer's logo element; neither class template calls `\insertlogo`, where beamer places it was not read |
| logo image | medstarbeamer.cls:58 | `fig.graphicx` | `\includegraphics[height=1cm, width=2.5cm]{medstarlogo}`; the file `medstarlogo` is not shipped (missing asset) |
| title block | example.tex:2-5, 8-10 | `front.class-native` | `\title[short]{long}`, `\institute[]{}` (empty), `\author[short]{}`, `\date{}`, frame holding `\maketitle`; the short forms feed the footer |
| sectioning | example.tex:15, 27-29 | `head.kernel` | `\section` `\subsection` `\subsubsection` (in beamer they feed the navigation, the subsection strip and the TOC; no heading prints on the slide) |
| frame structure | example.tex:16, 30, 36 | `class.beamer` | `\begin{frame}{Title}` (frame environment and title argument are class vocabulary) |
| contents frame, whole outline | example.tex:12; medstarbeamer.cls:66-78 | `toc.kernel` | frame holding `\tableofcontents` (beamer's TOC) |
| contents frame font size | medstarbeamer.cls:75 | `font.size-commands` | `\footnotesize{\tableofcontents}` when the argument is 2 |
| contents frame per section | example.tex:13; medstarbeamer.cls:82, 86, 91 | `slide.beamer-section-hook` | `\AtBeginSection{frame with \tableofcontents[currentsection]}` (with `\footnotesize` when the argument is 2), skipped for section 1 by `\ifthenelse{\thesection > 1}` at line 83 |
| lists | example.tex:17-24, 37-39 | `list.kernel` | `enumerate` and `itemize`, items written `\item{...}`; marker colour from `item` (beamercolorthemeMedStarColors.sty:29) |
| inline emphasis | example.tex:23 | `slide.beamer-template` | `\alert{...}` shows in `alerted text` = medstarred (beamercolorthemeMedStarColors.sty:26) |
| list package, loaded, unused | medstarbeamer.cls:19 | `list.enumerate-pkg` | `enumerate` loaded; example.tex:17 gives no label template |
| PDF links | medstarbeamer.cls:10 | `meta.hyperref` | `hyperref` loaded with no options (beamer also loads it) |
| maths, loaded, unused | medstarbeamer.cls:18 | `math.amsmath` | `amsmath` loaded; no equation in example.tex |
| cancel, loaded, unused | medstarbeamer.cls:17 | `math.physics` | `cancel` loaded (the lib line names `cancel`); not used |
| tables, loaded, unused | medstarbeamer.cls:14 | `tbl.booktabs` | `booktabs` loaded; no table in example.tex |
| marks, loaded, unused | medstarbeamer.cls:15 | `mark.ulem` | `soul` loaded; not used |
| background, loaded, unused | medstarbeamer.cls:16 | `bg.background` | `background` loaded; no `\backgroundsetup` or `\SetBgContents` anywhere in the zip |
| pgf, loaded, nothing drawn | medstarbeamer.cls:12 | `art.tikz` | `pgf` loaded; no picture in any zip file, so not ART |
| fonts | (none set) | none | beamer default font theme; only `\usebeamerfont{...in head/foot}` calls (medstarbeamer.cls:26,29,32,44) |
| bibliography, index, theorems, floats | (none) | none | example.tex uses none; the class sets only the caption template (medstarbeamer.cls:62) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `medstarbeamer.cls` as a whole | medstarbeamer.cls:6-98 | yes (and published) | Published on CTAN, so `class.medstarbeamer` is itself a way. Its content reduces to `\documentclass{beamer}` plus the table above: packages, two footline/headline templates, `\setbeamersize`, `\setbeamercovered`, `\setbeamertemplate`, `\logo`. |
| `beamercolorthemeMedStarColors.sty` | beamercolorthemeMedStarColors.sty:7-35 | yes | Inline: three `color.xcolor` `\definecolor` lines (beamercolorthemeMedStarColors.sty:9-11) then the `\setbeamercolor` lines (beamercolorthemeMedStarColors.sty:13-35) as `slide.beamer-template`. |
| footline `\defbeamertemplate*` body | medstarbeamer.cls:22-34 | yes | One row of three `beamercolorbox` with `wd` `ht` `dp` `center` keys and beamer `\insert*` fields; it resembles beamer's `infolines` footline (from knowledge, not read here) with its own box heights. Set as `\setbeamertemplate{footline}{...}`. No glue algorithm or computed layout. |
| headline `\defbeamertemplate*` body | medstarbeamer.cls:37-47 | yes | `\setbeamertemplate{headline}{...}` of two `beamercolorbox` (navigation, subsection strip). |
| `\newif\ifbeamer@theme@subsection` set true | medstarbeamer.cls:42,46,54-55 | yes | A constant switch that is always true; write the subsection box without the `\if`. |
| `\sizecontentsoutline{n}` | medstarbeamer.cls:66-78 | yes | A switch on a literal integer: 1 gives `\begin{frame}\tableofcontents\end{frame}`, 2 the same with `\footnotesize`. The emitter writes the chosen frame directly. As read it has two `\ifnum` and one `\fi` (medstarbeamer.cls:68,73,77), so the outer test is left open; the reduction follows the intent. |
| `\sizecontentscurrent{n}` | medstarbeamer.cls:80-96 | yes | `\AtBeginSection{frame with [\footnotesize] \tableofcontents[currentsection]}` (`slide.beamer-section-hook`), with the "not for section 1" gate expressed by placing the hook line after the first `\section` (the hook then fires for later sections only; this beamer behaviour is stated from knowledge, not read here). As read, `\ifthenelse` receives two arguments (medstarbeamer.cls:83-94) and there is one `\fi` for two `\ifnum` (medstarbeamer.cls:84,89,93); the reduction follows the intent. |
| `ifthen` package | medstarbeamer.cls:20 | yes | Used only by `\sizecontentscurrent` (medstarbeamer.cls:83); not needed once the gate is gone. |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and kept inside existing ways: `\setbeamersize` and `\logo` under `slide.beamer-template` (same `\setbeamer*`/element family), `\setbeamercovered` under `slide.beamer-mode` (overlay covering).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
