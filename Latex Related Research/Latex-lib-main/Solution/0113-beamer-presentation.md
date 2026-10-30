yes

# 0113-beamer-presentation: Beamer Presentation (metropolis starter deck)

- Unverified: read from the source, not compiled.
- Source: Source/0113-beamer-presentation/ (origin: https://latextemplates.com/downloads/beamer-presentation.zip; licence: Apache-2.0). README.md:3-8 says the zip is a substitute: klb2/beamer-presentation-template on the metropolis theme.
- Kind: presentation
- Lib: v2
- Engine: needs LuaLaTeX (`fontspec` `\setsansfont`/`\setmonofont` by OTF file name, main.tex:23-29; magic comment `% !TeX program = lualatex`, main.tex:1; README.md:27)
- Look carried by: mixed (published `beamer` class plus the published `metropolis` theme set the slide structure, main.tex:2,31; the preamble and the `\input` setup files add colours, fonts, a title-page template and a rule macro, setup-colors.tex, setup-beamer.tex)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; `example-content.tex` is `\input` by main.tex:68 and holds the demo frames)
- Read: main yes, zip-local classes and styles none present (no `.cls`, `.sty`, `.def`, `.cfg`, `.clo` in the zip; all four `setup-*.tex` files, `example-content.tex` and `README.md` read in full)

## Verdict
Yes. There is no zip-local class or package: the look is the published beamer class with the published metropolis theme (ctan.org/pkg/beamertheme-metropolis exists and is in TeX Live), plus declarative `\setbeamercolor`, `\setbeamerfont`, `\setbeamertemplate`, `\definecolor`, `fontspec` and `\newtheorem` calls. The only zip-local macros are `\seprule`, a replacement title-page template and math aliases; each is a composition of lib ways and is written down as reducible below. The closest call is the title-page template (setup-beamer.tex:15-29), judged reducible because its body is a fixed order of `\usebeamertemplate*` calls in a `minipage`. No artwork defines the template: the pgfplots axis sits inside a `figure` and is content. Fira fonts are not shipped in the zip (missing asset, not a blocker).

## Blockers
none

## Class setting
- Class: `class.beamer` options: `english`, `sections numbered`, `xcolor=dvipsnames`, `aspectratio=169` (main.tex:2-7). The effect of the option `sections numbered` was not established (not read from the beamer source).
- Class-native vocabulary used: `frame` (with title argument, `[fragile]`, `[standout]`), `columns[T,onlytextwidth]` with `\column{w}`, `block` / `alertblock` / `exampleblock`, `\alert`, `\inst`, `\institute[]`, `\maketitle`, `\appendix`, `\metroset{block=fill}` (metropolis), `\usebeamertemplate*`, `\inserttitle` family (setup-beamer.tex:15-29).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2-7 | `class.beamer` | english, sections numbered, xcolor=dvipsnames, aspectratio=169 |
| page size / aspect | main.tex:6 | `page.class-options` | aspectratio=169 |
| slide theme (frame title bar, progress bar, footline, section page, Fira font theme) | main.tex:31 | `slide.beamer-theme` | `\usetheme[progressbar=frametitle]{metropolis}` |
| theme option set in the body | example-content.tex:128 | `slide.beamer-theme` | `\metroset{block=fill}` (metropolis key-value option, same package as the theme) |
| standout frame | example-content.tex:161 | `slide.beamer-theme` | frame option `standout` (metropolis) |
| slide colours | setup-colors.tex:8-36 | `slide.beamer-template` | `\setbeamercolor` for normal text (fg=fgcolor, bg=bgcolor), alerted text, palette primary, block title/body, block title alerted/example, with `use=` and `x.bg` references |
| slide fonts | setup-beamer.tex:1-12 | `slide.beamer-template` | `\setbeamerfont` block body/title reference size=\scriptsize; description item series=\mdseries; alerted text series=\bfseries\boldmath; bibliography item/entry fonts size=\small, shape, series |
| title page layout | setup-beamer.tex:15-29 | `slide.beamer-template` | `\setbeamertemplate{title page}{...}`: title graphic, title, subtitle, title separator, author, date, institute in that order |
| title page container and fill | setup-beamer.tex:16,18,26,27 | `box.minipage`, `sp.manual-space` | `minipage[b][\textheight]{\textwidth}`; `\vfill`, `\vfil`, `\vspace*{1mm}` |
| colour definitions | setup-colors.tex:2-5, 41-45 | `color.xcolor` | `\definecolor{...}{HTML}{...}`: accent 7EBDC2, bgcolor FCFCFF, bgcolorAlt ECF1FC, fgcolor 222244; plot0-plot4 (Paul Tol); option `xcolor=dvipsnames` at main.tex:5 |
| front matter | main.tex:57-63,66 | `front.maketitle`, `front.class-native` | `\title`, `\author`, `\date`, `\maketitle`; `\inst{n}` and `\institute[]{...}` are beamer's |
| date format | main.tex:12 | `front.datetime` | `isodate` with `american` (a date-format package for `\today`, ctan.org/pkg/isodate; `\today` is never called, main.tex:63 is a literal). considered: widening `front.datetime` rather than a new way |
| language | main.tex:3,9 | `lang.babel` | `babel`, language `english` from the class option |
| quotes | main.tex:11 | `lang.csquotes` | option `babel` |
| microtype | main.tex:10 | `sp.microtype` | option `babel` |
| font encoding | main.tex:14 | `font.fontenc-t1` | `[T1]` |
| text fonts | main.tex:23-29 | `font.fontspec` | `\setsansfont{FiraSans-Light}[BoldFont=FiraSans-Regular, ItalicFont=FiraSans-LightItalic, BoldItalicFont=FiraSans-Italic]`; `\setmonofont{FiraMono-Regular}[BoldFont=FiraMono-Medium]` |
| sectioning | example-content.tex:18,44 | `head.kernel` | `\section{Math Expressions}`, `\section{Elements}`; section pages come from the theme |
| appendix | example-content.tex:166 | `num.appendix` | `\appendix` before the backup frame |
| lists | example-content.tex:3,76,82,88 | `list.kernel` | `itemize`, `enumerate`, `description`; bold-off item via `\setbeamerfont{description item}` |
| columns | example-content.tex:73-91,112-142 | `class.beamer` | beamer `columns[T,onlytextwidth]`, `\column{0.33\textwidth}`, `\column{0.45\textwidth}`; no `cols.*` way matches (beamer vocabulary) |
| blocks | example-content.tex:114-140 | `class.beamer` | `block`, `alertblock`, `exampleblock`; looks set by `slide.beamer-template` colours (setup-colors.tex:21-36) and `\metroset{block=fill}` |
| separator rule | setup-beamer.tex:30 | `sp.rule`, `sp.manual-space`, `color.xcolor` | `\par\color{bgcolorAlt!90!fgcolor}\hrulefill\par\vspace*{1ex plus 0pt minus .5ex}`; used at example-content.tex:7,28 |
| emphasis marks | example-content.tex:54,60-68 | `mark.kernel` | `\emph`, `\textbf`, `\textit`, `\textsc`, `\texttt`; `\alert` is beamer's (colour from alerted text) |
| centred line | example-content.tex:51 | `sp.ragged` | `center` environment |
| math packages | main.tex:39-41,44-46 | `math.amsmath`, `math.amssymb`, `math.bm`, `math.mathtools` | amsmath, amssymb, amsfonts, bm, dsfont (`\mathds`, setup-math.tex:18-20), mathtools |
| display maths | example-content.tex:20-26,38-40 | `math.amsmath` | `equation`, `align` |
| math operators and delimiters | setup-math.tex:2-5,14-15 | `math.mathtools`, `math.amsmath` | `\DeclarePairedDelimiter` abs, norm, ceil, floor; `\DeclareMathOperator*` argmax, argmin |
| theorem-like statements | setup-math.tex:30-34; main.tex:42 | `thm.amsthm` | `\theoremstyle{plain}`; `\newtheorem` thm=Theorem, lem=Lemma, prop=Proposition, cor=Corollary (counters not shared, no `[section]`); used at example-content.tex:36 |
| tables | example-content.tex:30-33,94-106 | `tbl.tabular`, `tbl.booktabs` | `tabular{rl}`, `tabular{@{} lr @{}}`, `\toprule \midrule \bottomrule`; `tabularx` loaded, never used (main.tex:50) |
| table caption | example-content.tex:95 | `cap.kernel` | `\caption` in a `table` float |
| figure float | example-content.tex:145-158 | `fig.graphicx` | `figure` environment; `graphicx` loaded (main.tex:34), no `\includegraphics` in the sample |
| plot styling and plot (content) | setup-plots.tex:1-32; example-content.tex:146-157 | `art.tikz` | pgfplots `compat=newest`, `betterplot` style, `lineplot cycle` cycle list, legend style; used only for the plot inside the figure |
| code | example-content.tex:47-49,171 | `code.verbatim` | `verbatim` in a `[fragile]` frame, `\verb` |
| siunitx | main.tex:43 | `mark.siunitx` | loaded; no unit or number command in the sample |

Not present in the sample: overlays (`slide.beamer-mode`), `\AtBeginSection`, footnotes, bibliography (only its fonts are set, setup-beamer.tex:7-12), index, `\label`/`\ref`, and any `hyperref` option (beamer loads it; no `\hypersetup`).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\seprule` | setup-beamer.tex:30 | yes | `\newcommand` alias for `sp.rule` (`\hrulefill`) in an `xcolor` mixed colour, with `sp.manual-space` (`\vspace*`); the emitter prints the alias or inlines it |
| title-page template | setup-beamer.tex:15-29 | yes | `\setbeamertemplate{title page}` whose body is `\usebeamertemplate*{title graphic|title|subtitle|title separator|author|date|institute}` in a `minipage[b][\textheight]` with `\vfill`/`\vfil`/`\vspace*`. The `\ifx...\@empty` guards (lines 17,19,20,23-25) only skip empty fields; an emitter that knows which fields exist writes only those calls, so no zip-local logic is copied. The `\@empty` and `\beamer@shortauthor` internals are read outside `\makeatletter` in the preamble (effect not verified) |
| math alias macros | setup-math.tex:7-12,18-20,23-26 | yes | `\newcommand*` aliases over `\ensuremath`, `\left \right`, `\mathrm`, `\mathds`, `\mathbb`, `\mathcal`: kernel and `math.amsmath` / `math.bm` pieces; they carry content symbols, not layout |
| paired delimiters | setup-math.tex:2-5 | yes | published `mathtools` `\DeclarePairedDelimiter` (`math.mathtools`) |
| math operators | setup-math.tex:14-15 | yes | published `amsmath` `\DeclareMathOperator*` (`math.amsmath`) |
| pgfplots styles | setup-plots.tex:1-32 | yes | only published pgfplots/pgf key commands (`\pgfplotsset`, `\pgfplotscreateplotcyclelist`, `/tikz/every even column/.append style`); styles only plots inside the figure float (content) |

## Content-opaque
- pgfplots `axis` with two `\addplot` calls inside `figure` (example-content.tex:146-157), and its preamble styling and Paul Tol plot cycle (setup-plots.tex:1-32, setup-colors.tex:41-45). Judgement: it styles figure content only, not the slide look, so it is not `ART`; the `plot0`-`plot4` colours are still `color.xcolor` definitions.
- Missing assets: the Fira Sans and Fira Mono OTF files named at main.tex:24-29 are not in the zip (the comment at main.tex:16-22 says TeX Live supplies them by file name); ship them.

## Lib changes
- New ways proposed: none. (`\metroset` and the `standout` frame option sit under `slide.beamer-theme`; beamer `columns` and the three block environments are `class.beamer` vocabulary; `isodate` is a date-format package filed under `front.datetime`, whose line could name it as a parameter, as `font.helvet` does for sans packages.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
