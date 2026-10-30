yes

# 0576-saarland-beamer: Saarland Beamer

- Unverified: read from the source, not compiled.
- Source: Source/0576-saarland-beamer/ (origin: https://latextemplates.com/downloads/saarland-beamer.zip; licence: MIT, LICENSE:1, copyright line LICENSE:3)
- Kind: presentation
- Lib: v4
- Engine: needs XeLaTeX (`fontspec` is loaded unconditionally at beamerfontthemeSaarland.sty:2; main.tex:1 `% !TeX program = xelatex`)
- Look carried by: zip-local (five `beamer*themeSaarland.sty` files carry the look; main.tex only passes two strings to the theme and loads `booktabs`)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
Yes. The class is stock `beamer` (not in the zip; its source was not read). The look sits in a zip-local beamer theme, five small `.sty` files that only call published commands: `\definecolor`, `\setbeamercolor`, `\setbeamerfont`, `\setbeamertemplate`, `\defbeamertemplate`, `\usefonttheme`, `fontspec`'s `\setmainfont`, `\includegraphics`. Each file reduces to lib ways by writing its lines straight into the preamble, with the two option strings resolved to `saarland` and `uds`. There is no drawn artwork and no external tool. The only images are two shipped files placed with `\includegraphics`, which are assets.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `aspectratio=169` (main.tex:2)
- Class-native vocabulary used: `frame` environment with the title as its argument and the `[plain]` option (main.tex:21,25,31); `\titlepage` (main.tex:22); `\subtitle`, `\institute` (main.tex:15-16); `columns` with option `[T]` and `column` with a width (main.tex:40-48); `\tableofcontents` inside a frame (main.tex:26); `\section` (feeds the contents and navigation only; no section page is defined); theme commands `\usetheme[options]{name}` (main.tex:4-7), `\usecolortheme` `\usefonttheme` `\useinnertheme` `\useoutertheme` (beamerthemeSaarland.sty:7-10); template commands `\setbeamercolor` `\setbeamerfont` `\setbeamertemplate` `\defbeamertemplate`, `beamercolorbox`, `\usebeamerfont` `\usebeamercolor`, `\inserttitle` `\insertsubtitle` `\insertauthor` `\insertinstitute` `\insertdate` `\insertframenumber`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2 | `class.beamer` | `aspectratio=169` |
| page size | main.tex:2 | `page.class-options` | `aspectratio=169` (16:9 slide); no geometry package |
| theme selection | main.tex:4-7; beamerthemeSaarland.sty:7-10 | `slide.beamer-theme` | `\usetheme[background=saarland,logo=uds]{Saarland}` names a zip-local theme, so it is flattened (see Bespoke code); the published font theme `\usefonttheme{professionalfonts}` (beamerfontthemeSaarland.sty:5) is kept |
| colour definitions | beamercolorthemeSaarland.sty:3-10 | `color.xcolor` | `\definecolor` navyblue RGB 0,47,92; turquoise 85,179,162; brightsky 0,176,223; lightred 196,91,46; violet 73,0,130; charcoal 54,69,79; gray 128,128,128; americanrose rgb 1.0,0.01,0.24 (`brightsky` and `violet` are never used) |
| structure, title and frame-title colours | beamercolorthemeSaarland.sty:12-15,27-28 | `slide.beamer-template` | `\setbeamercolor`: structure fg=gray bg=white; frametitle, framesubtitle, title, subtitle fg=navyblue; alerted text fg=americanrose |
| block colours | beamercolorthemeSaarland.sty:18-25 | `slide.beamer-template` | `\setbeamercolor` for block, example and alerted blocks: title fg=`gray!30!white` bg=charcoal; body parent=normal text bg=gray fg=white; example title fg=`turquoise!30!white` bg=`turquoise!40!black`, body bg=turquoise; alerted title fg=`lightred!30!white` bg=`lightred!40!black`, body bg=lightred (no block is used in main.tex) |
| main font | beamerfontthemeSaarland.sty:2,17-23 | `font.fontspec` | `\setmainfont{Lato}[Extension=.ttf, UprightFont=*-Regular, BoldFont=*-Bold, ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic]`; Lato is not in the zip (note, see Bespoke code) |
| title and frame-title fonts | beamerfontthemeSaarland.sty:25-29 | `slide.beamer-template`, `font.size-commands`, `mark.kernel` | `\setbeamerfont`: title family=`\rmfamily` series=`\bfseries` size=`\LARGE`; subtitle `\rmfamily` `\mdseries` `\large`; frametitle `\rmfamily` `\bfseries` `\Large`; framesubtitle `\rmfamily` `\mdseries` `\large` |
| navigation symbols | beamerthemeSaarland.sty:12 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` (empty) |
| footer | beamerouterthemeSaarland.sty:12-24 | `slide.beamer-template`, `sp.manual-space`, `fig.graphicx` | `footline` box code: `beamercolorbox[wd=0.98\paperwidth,ht=2.25ex,dp=1ex,center]{pagenumber}` holding `\insertframenumber{}\hspace*{1ex}`, then `\llap{\includegraphics[height=0.4cm]{uds}}` (logo guarded by an option test); the colour name `pagenumber` is never set in any theme file (grep), so the box carries no colour from the theme |
| background image | beamerouterthemeSaarland.sty:27-35 | `slide.beamer-template`, `sp.manual-space`, `fig.graphicx` | `sidebar right` template: `\vskip.1\beamer@leftmargin`, `\vfill`, `\llap{\includegraphics[width=.5\paperwidth,height=.5\paperheight]{saarland}}` (guarded by an option test); image is images/saarland.png, 50x39 px RGBA (file(1)) |
| bullet marks | beamerinnerthemeSaarland.sty:3-9 | `slide.beamer-template`, `font.size-commands`, `color.xcolor`, `sp.manual-space`, `math.kernel` | `\defbeamertemplate` for `itemize item`, `itemize subitem`, `itemize subsubitem` named `circ`: `\small\raise.2ex\hbox{\color{navyblue}$\bullet$}`, `\small\raise.1ex\hbox{\color{navyblue}$\circ$}`, `\scriptsize\raise.1ex\hbox{\color{navyblue}$\bullet$}`; then `\setbeamertemplate{items}[circ]` |
| title page layout | beamerouterthemeSaarland.sty:38-46 | `slide.beamer-template`, `sp.manual-space` | `title page` template: title (font title, colour title), `\par`, subtitle, `\bigskip`, author, institute, date, each with `\usebeamerfont` |
| title page content | main.tex:13-17,21-23 | `front.maketitle`, `front.class-native` | `\author`, `\title`, `\date{\today}`; beamer `\subtitle`, `\institute`, `\titlepage` in a `[plain]` frame |
| contents | main.tex:25-27 | `toc.kernel` | `\tableofcontents` in a frame; beamer's default contents template, no override found |
| sections | main.tex:29,58,77,109 | `head.kernel` | `\section{...}` x4; no section-page hook defined |
| frame titles | main.tex:25,31,39,60,68,79,93,111,119 | `head.class-native` | `\begin{frame}{Title}`; look set by the frametitle colour and font rows above |
| lists | main.tex:32-36,43-46,50-53,61-65,112-116 | `list.kernel` | `itemize`, one level; marks come from the bullet row |
| side-by-side columns | main.tex:40-55 | `cols.minipage` | beamer `columns[T]` with two `column{0.5\textwidth}`: fixed-width boxes aligned at the top, the same type as `minipage` columns (also class vocabulary) |
| emphasis | main.tex:42,49,102 | `mark.kernel` | `\textbf` |
| display and inline maths | main.tex:69-74 | `math.kernel` | `\[ ... \]` with `\frac`, `\sum`, sub and superscripts; inline `$...$`; no `amsmath` loaded |
| table | main.tex:80-90,94-106 | `tbl.tabular`, `tbl.booktabs`, `sp.ragged` | `table` + `\centering` + `tabular{lrr}` with `\toprule` `\midrule` `\bottomrule`; `\usepackage{booktabs}` at main.tex:11 |
| caption | main.tex:105 | `cap.kernel` | `\caption{...}` under the second table; beamer's default caption template, no override |
| image search path | main.tex:9 | `fig.graphicx` | `\graphicspath{{images/}}` |
| closing frame | main.tex:119-123 | `sp.ragged`, `font.size-commands`, `sp.manual-space` | `\centering`, `\Large`, `\\[1em]`, `\normalsize` |

Components the zip does not define or use: page geometry package, running head, numbering changes, abstract, theorems, code, boxes beyond the unused block colours, notes, bibliography, index, cross-references, language setup, PDF metadata. Beamer loads `hyperref` itself and no option is set.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| theme wrapper `Saarland`: option passing and loading of the four sub-themes | beamerthemeSaarland.sty:1-15 | yes | `\DeclareOptionBeamer` / `\PassOptionsToPackage` / `\ProcessOptionsBeamer` only forward two strings (`background`, `logo`). Emit the other four files' lines in the preamble in the same order (color, font, inner, outer), then `\setbeamertemplate{navigation symbols}{}`. `\mode<presentation>`, `\mode<all>` and `\endinput` are loading plumbing and drop out. |
| colour theme | beamercolorthemeSaarland.sty:1-30 | yes | `color.xcolor` `\definecolor` lines and `slide.beamer-template` `\setbeamercolor` lines, values in the table. |
| font theme | beamerfontthemeSaarland.sty:1-29 | yes | `font.fontspec` `\setmainfont{Lato}[...]`, `slide.beamer-template` `\setbeamerfont` lines, published `\usefonttheme{professionalfonts}`. Engine becomes XeLaTeX or LuaLaTeX. The comment at :9-16 is a note about fontconfig and file names, not an instruction to anyone; it is not acted on. Missing asset: the Lato `.ttf` files are not in the zip (the comment says TeX Live ships them; not checked here). |
| inner theme: three named item templates | beamerinnerthemeSaarland.sty:3-9 | yes | Each `\defbeamertemplate{X}{circ}{body}` body is plain font, `\raise`, `\hbox`, `\color` and a math bullet; write the body as `\setbeamertemplate{itemize item}{body}` (and `subitem`, `subsubitem`), or keep the `\defbeamertemplate` plus `\setbeamertemplate{items}[circ]` lines as they are (the same beamer command family). Whether beamer's `items` template has an alternative named `circ` was not checked; the lines are emitted as read. |
| option macros and two conditionals | beamerouterthemeSaarland.sty:5-9,19-22,29-34 | yes | `\beamer@Saarland@background` and `\beamer@Saarland@logo` hold a file name, default empty; `\if ...\@empty` only decides whether one `\includegraphics` is printed. The emitter knows the values (`saarland`, `uds`) and writes the include, or nothing. No counter or layout computation is involved. |
| footline template | beamerouterthemeSaarland.sty:12-24 | yes | `\setbeamertemplate{footline}{...}`: a `beamercolorbox` with `wd` `ht` `dp` `center`, `\insertframenumber`, `\hspace*`, `\llap` and `\includegraphics`. `\llap` is a kernel positioning command filed under `sp.manual-space` with `\raisebox` and `\hspace` (considered: a new way for it, not proposed, since it takes no new kind of parameter). |
| sidebar-right background image | beamerouterthemeSaarland.sty:27-35 | yes | `\setbeamertemplate{sidebar right}{...}`: `\vskip` of 0.1 times the beamer text margin, `\vfill`, and one `\llap{\includegraphics[width=.5\paperwidth,height=.5\paperheight]{saarland}}`. `\beamer@leftmargin` is a beamer internal length: use it as written with `\makeatletter` in the preamble, or write its value. This is a shipped image placed by `\includegraphics`, not a drawing, so it is not `ART` (a watermark reduces to a declarative way). |
| title page template | beamerouterthemeSaarland.sty:38-46 | yes | `\setbeamertemplate{title page}{...}` made only of `\usebeamerfont`, `\usebeamercolor`, `\insert...` commands, `\par` and `\bigskip`. |
| `\usepackage{tikz}` | beamerouterthemeSaarland.sty:1 | yes | Load only. grep finds no `tikz`, `pgf`, `\draw` or `tikzpicture` anywhere else in the zip, so nothing is drawn; the line can be dropped or kept as a package load (it needs no external tool). |

Origin check for the theme: the zip is from latextemplates.com, not an official release, and `https://ctan.org/pkg/beamertheme-saarland` returned 404 (one name tried, no other read), so the theme files are treated as zip-local, not published (W1 fails for the theme itself; each line in it is a published command).

## Content-opaque
none (the two tables and the formula in main.tex are ordinary content; the images are shipped assets, listed above)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
