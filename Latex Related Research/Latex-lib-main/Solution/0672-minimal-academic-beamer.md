yes

# 0672-minimal-academic-beamer: Minimal Academic Beamer

- Unverified: read from the source, not compiled.
- Source: Source/0672-minimal-academic-beamer/ (origin: https://latextemplates.com/downloads/minimal-academic-beamer.zip; licence: MIT, LICENSE:1-3, copyright jialefu)
- Kind: presentation
- Lib: v5
- Engine: needs XeLaTeX (`fontspec` loaded unconditionally, minimalistslides.sty:33; `\ifXeTeX\else\PackageError` guard, minimalistslides.sty:5-7; `% !TeX program = xelatex`, main.tex:1)
- Look carried by: zip-local (minimalistslides.sty sets every beamer template, colour and font, minimalistslides.sty:180-231; main.tex adds only logo, institution name and metadata strings, main.tex:13-19)
- Class origin: tex-distribution-unbundled (`beamer`, not in the zip; its source was not read)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (minimalistslides.sty, 332 lines)

## Verdict
The whole look is one zip-local style, `minimalistslides.sty`, over the published `beamer` class. The style is not published (ctan.org/pkg/minimalistslides is a 404, and the file carries latextemplates.com patch notes), so it is zip-local bespoke code. All of it reduces to published packages and beamer's own `\setbeamertemplate`, `\setbeamercolor`, `\setbeamerfont` and `\usefonttheme` calls, plus `\newcommand` aliases, `\newmdenv`, `\newtcolorbox` and `\lstdefinestyle`. The only drawings are three TikZ pictures made of axis-aligned filled rectangles or one horizontal hairline (minimalistslides.sty:245-247, 261-264, 306-309); each reduces to a coloured kernel `\rule` (`sp.rule`) and is written down below. The answer rests on that reduction: if a reviewer reads those hairlines as `ART`, it flips to `no`. There is no irreducible code, no tool outside TeX (BibTeX backend only) and no unmapped component.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `8pt` (main.tex:2); no `aspectratio`, so beamer's default page (beamer source not read).
- Class-native vocabulary used: `frame` (with title argument, and `[plain]`, main.tex:25 and minimalistslides.sty:254), `\tableofcontents` in a frame (main.tex:26), `\section` (main.tex:29), `itemize` (main.tex:37), `table` inside frames (main.tex:49), `beamercolorbox` (minimalistslides.sty:228, 238), `\usebeamerfont`, `\insertframetitle`, `\insertframesubtitle`, `\insertframenumber`, `\inserttotalframenumber`, `\insertsection`, `\insertsectionnumber` (minimalistslides.sty:229, 239-240, 260), `\setbeamertemplate`, `\setbeamercolor`, `\setbeamerfont`, `\defbeamertemplate*`, `\usefonttheme` (minimalistslides.sty:180-220, 234).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2 | `class.beamer` | `8pt` |
| page size | main.tex:2 | `page.class-options` | font size 8pt only; no geometry package |
| package loads (load-only for the sample) | minimalistslides.sty:15-33 | `color.xcolor`, `fig.graphicx`, `fig.adjustbox` (`export`), `box.stackengine`, `font.icons` (`pifont`, `fontawesome5`), `box.mdframed` (`framemethod=TikZ`), `math.amsmath`, `math.bm`, `tbl.tabular` (`array`), `code.listings`, `box.tcolorbox`, `bib.biblatex-bibtex`, `tbl.tabularx`, `tbl.booktabs`, `tbl.multirow`, `mark.ulem`, `font.fontspec` | as listed in the sty; `etoolbox` and `iftex` are helpers for the bespoke code below |
| navigation symbols | minimalistslides.sty:180 | `slide.beamer-template` | `navigation symbols` = empty |
| footer (page n/N) | minimalistslides.sty:227-231 (the `[page number]` setting at :181 is overridden) | `hf.class-native`, `slide.beamer-template`, `sp.manual-space`, `color.xcolor` | `footline` free box code: `beamercolorbox[wd=\paperwidth, ht=2.25ex, dp=1ex, leftskip=0.5cm, rightskip=0.5cm]{title in head/foot}`, `\hfill`, `\insertframenumber/\inserttotalframenumber` in `black!60`, `\hspace*{1mm}`, `\vspace*{2mm}` |
| frame title bar | minimalistslides.sty:234-250 | `slide.beamer-template`, `sp.manual-space`, `fig.graphicx`, `sp.rule`, `color.xcolor` | `frametitle` template: `\nointerlineskip`, `\vspace*{3mm}`, `\hspace*{-1mm}`, `beamercolorbox[sep=0.3cm, wd=\paperwidth, leftskip=0.5cm, rightskip=0.5cm]{frametitle}`, subtitle in `black!60`, `\hfill\raisebox{-1mm}{\includegraphics[width=13mm]{<logo>}}`, `\vskip-1.5ex`, `\vspace*{-7mm}`; underline reduced below |
| frame title colour and fonts | minimalistslides.sty:192, 211-212 | `slide.beamer-template` | `frametitle` bg empty, fg `themecolor`; font size `\large`; `framesubtitle` size `\normalsize` |
| title cover | main.tex:23; minimalistslides.sty:284-296, 269-282 | `front.titlepage-env`, `box.tcolorbox`, `tbl.tabular`, `sp.manual-space`, `color.xcolor`, `font.size-commands`, `sp.ragged` | `frame[plain]`, `\centering`, `\vspace{13mm}`, `tcolorbox[colback=themecolor!8, colframe=themecolor, arc=1mm, boxrule=0.2pt, width=0.97\textwidth]` with `\color{themecolor}\LARGE\centering`, `\vspace{7mm}`, `tabular{>{\color{themecolor}}r@{\hspace{3pt}}l}` of label and value rows, `\vspace{4mm}`, date |
| presenter, institution, date strings | main.tex:13-19; minimalistslides.sty:58-79 | (content, inlined by the emitter) | labels `Presenter`, `Institution` (sty:71, 75); values `Sofia Mendes`, `Southeast University`, `\today` |
| contents list | main.tex:25-27; minimalistslides.sty:182, 195-196, 214-215 | `toc.kernel`, `slide.beamer-template` | `section in toc` = `sections numbered`; colours fg `themecolor`, subsection fg `black!60`; fonts `\large`, `\normalsize` |
| section commands | main.tex:29, 44, 73, 101 | `head.kernel` | `\section{...}` only; beamer prints nothing itself |
| section divider frame | main.tex:31; minimalistslides.sty:253-267 | `sp.manual-space`, `tbl.tabular`, `font.size-commands`, `color.xcolor`, `sp.rule` | the container `frame[plain]` is `class.beamer` vocabulary (frames), not `slide.beamer-section-hook` (the sample calls `\makesection` by hand after each `\section`, and the hook's body is limited to declarative beamer commands); inside: `\centering`, `\vspace*{7mm}`, tabular holding `{\color{themecolor}\huge\insertsectionnumber.\ \insertsection}` and a two-tone rule 0.6\textwidth by 1pt (reduced below) |
| bullet lists | main.tex:37-41; minimalistslides.sty:185-189, 203-208 | `list.kernel`, `slide.beamer-template` | `itemize item` = `circle`, `itemize subitem` = `$\circ$`, `subsubitem` = `circle`; `enumerate subitem` = `\alph{enumii}.`, `subsubitem` = `\roman{enumiii}.`; item colours `themecolor` |
| inline highlight | main.tex:35, 87, 91; minimalistslides.sty:319-322 | `color.xcolor`, `mark.ulem` | `\textcolor{themecolor}`, `\textcolor{stronghighlightcolor}`, `\uline` variants (`\ulhighlight`, `\ulstronghighlight`, unused) |
| colour palette | minimalistslides.sty:42-46 | `color.xcolor` | `themegreen` RGB 48,95,33; `themered` RGB 95,33,48; `darkgray` = `black!70`; `stronghighlightcolor` = `themered!150!black`; `themecolor` = `themegreen` |
| sans text face | minimalistslides.sty:98-104, 121 | `font.fontspec`, `mark.kernel` | `\setsansfont{texgyreheros}` with `Extension=.otf`, `UprightFont=*-regular`, `BoldFont=*-bold`, `ItalicFont=*-italic`, `BoldItalicFont=*-bolditalic`; `\sffamily` at begin document |
| maths face | minimalistslides.sty:220 | `slide.beamer-theme` | `\usefonttheme[onlymath]{serif}` |
| other beamer fonts | minimalistslides.sty:213-219 | `slide.beamer-template`, `font.size-commands` | `block title` `\large`; `section in toc` `\large`; `subsection in toc` `\normalsize`; `caption name` and `caption` `\normalsize`; `footnote` `\tiny`; `description item` `\normalsize` |
| paragraph spacing | minimalistslides.sty:221-222 | `sp.lengths` | `\parskip` 0.5em; 0em inside `table` |
| emphasis restore | minimalistslides.sty:223 | `mark.ulem` | `\normalem` after loading `ulem` |
| block, description, caption, bibliography colours (unused by sample) | minimalistslides.sty:193-194, 197-202 | `slide.beamer-template` | `block title` bg `themecolor!8` fg `themecolor`; `description item`, `caption name`, `bibliography item` fg `themecolor`; bibliography author, title, journal, note fg `black` |
| tables | main.tex:49-61, 78-90 | `tbl.tabular`, `tbl.booktabs`, `sp.ragged`, `font.size-commands` | `table` > `\small`, `\centering`, `tabular{lrr}` and `tabular{lrrr}`, `\toprule` `\midrule` `\bottomrule`; cell highlight `\stronghighlight` (main.tex:87) |
| closing frame | main.tex:113-117 | `sp.ragged`, `font.size-commands`, `sp.manual-space` | `\centering`, `\Large`, `\\[1em]`, `\normalsize` |
| left-bar quote box (unused) | minimalistslides.sty:126-135 | `box.mdframed` | `\newmdenv{myquote}`: `hidealllines=true`, `leftline=true`, `linewidth=1pt`, `linecolor=darkgray`, `fontcolor=darkgray`, `innertopmargin=1pt`, `innerbottommargin=1pt`, `font=\normalsize` |
| code listings (unused) | minimalistslides.sty:137-177 | `code.listings` | `\lstset{basicstyle=\ttfamily\color{stronghighlightcolor}}`; styles `python` and `latex`: `keywordstyle=\color{themecolor}`, `frame=single`, `framerule=0.25pt`, `framesep=3pt`, `rulecolor=\color{themecolor}`, `numbers=left`, `numbersep=5pt`, `breaklines=true`, `escapeinside={(*@}{@*)}` |
| callout box (unused) | minimalistslides.sty:324-332 | `box.tcolorbox`, `font.icons` | `\newtcolorbox{callout}[2][]`: `colback=white`, `colframe=themecolor`, `coltitle=black`, `boxrule=0.5pt`, `arc=2pt`, `left=2pt`, `right=2pt`, `top=1pt`, `bottom=2pt`, `boxsep=2pt`, `titlerule=-1mm`, title `\faLightbulb[regular]` |
| bibliography | minimalistslides.sty:26, 224 | `bib.biblatex-bibtex` | `backend=bibtex`, `style=numeric`, `\addbibresource{reference.bib}`; no `\cite` or `\printbibliography` in the sample; `reference.bib` is not in the zip |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `minimalistslides.sty` as a whole | minimalistslides.sty:1-332 | yes | `\RequirePackage` of published packages (sty:15-33) plus `\setbeamer*`, `\newmdenv`, `\newtcolorbox`, `\lstdefinestyle` and `\newcommand` aliases, all mapped in the table above |
| `english`/`chinese` options, `\newif\ifms@chinese`, `\ExecuteOptions`, `\ProcessOptions` | minimalistslides.sty:9-13, 59-79, 106-122 | yes | the sample takes `english` (main.tex:4); the emitter prints that branch only (strings at sty:70-78); the `chinese` branch is `\providecommand` strings (sty:60-68), unused here |
| XeTeX guard | minimalistslides.sty:4-7 | yes | no printed effect; recorded as the engine tag |
| theme identity and palette setters `\setthemelogo`, `\setthemename`, `\setthemeprimaryrgb`, `\setthemeaccentrgb` | minimalistslides.sty:36-39, 48-56; main.tex:13-14 | yes | aliases of `\renewcommand`, `\definecolor`, `\colorlet`; the emitter writes the values directly (logo path `figs/logo.jpg`, shipped) |
| metadata macros `\presentationtitle` `\presentationauthor` `\presentationinstitution` `\presentationdate` and `\providecommand` defaults | minimalistslides.sty:58-81; main.tex:16-19 | yes | string holders; inlined into the cover frame |
| `\ifstrempty{\presentationinstitution}` row test | minimalistslides.sty:280 | yes | the emitter knows whether the institution string is empty and prints or drops that tabular row |
| `\AtBeginDocument{...\sffamily}` | minimalistslides.sty:105-123 | yes | `\sffamily` at the start of the document (`mark.kernel`) |
| `\AtBeginEnvironment{table}{\setlength{\parskip}{0em}}` | minimalistslides.sty:222 | yes | emit `\setlength{\parskip}{0em}` at the start of each `table` node (`sp.lengths` as a body wrapper) |
| `\defbeamertemplate*{frametitle}{}[1][]{...}` | minimalistslides.sty:234-250 | yes | `#1` is never used, so it equals `\setbeamertemplate{frametitle}{...}` with the same body; the body is `beamercolorbox` keys, kernel spacing, `\includegraphics` and the underline below |
| frame-title underline, TikZ overlay hairline (ART candidate) | minimalistslides.sty:245-247 | yes | `\draw[line width=0.2pt] (0,0) -- (\textwidth+4mm,0);` is one horizontal segment, 0.2pt thick, drawn in the colour in force; reduce to `\rlap{\rule[-0.1pt]{\dimexpr\textwidth+4mm\relax}{0.2pt}}` (`sp.rule` with width, height, raise, colour; `\rlap` is the kernel zero-width box, `sp.manual-space` family). Weakest link of the verdict, vertical offset of about 0.1pt not checked |
| `\makesection` divider frame (ART candidate) | minimalistslides.sty:253-267 | yes | two `\fill` rectangles, grey `black!30` 0.6\textwidth by 1pt and `themecolor` 0.3\textwidth by 1pt on top of the first half (sty:262-263); reduce to `\textcolor{themecolor}{\rule{0.3\textwidth}{1pt}}\textcolor{black!30}{\rule{0.3\textwidth}{1pt}}` abutting; emitted as an explicit frame after each `\section` (main.tex:31, 46, 75, 103) |
| `\makelinecover` (ART candidate, unused) | minimalistslides.sty:298-317 | yes | same two-tone rule at 0.98\textwidth by 0.5pt, `black!50` and `themecolor` (sty:307-308); `\setlength{\parskip}{0.2em}` and `\vspace{13mm}` are `sp.lengths`, `sp.manual-space` |
| `\makeboxedcover`, `\titlecolorbox`, `\presentationmetadata` | minimalistslides.sty:269-296 | yes | inline expansion into a `frame[plain]` of `tcolorbox`, `tabular`, spacing (see title cover row) |
| `\highlight`, `\stronghighlight`, `\ulhighlight`, `\ulstronghighlight` | minimalistslides.sty:319-322 | yes | `\newcommand` aliases of `\textcolor` and `\uline` |
| `\minimalistslidescallouttitlefont` | minimalistslides.sty:68, 78 | yes | `\bfseries` (english) fed to the `fonttitle` key of `callout` |

## Content-opaque
none (the sample has no figure; the logo `figs/logo.jpg` sits in the frame-title template and is an asset, shipped in the zip)

## Lib changes
- New ways proposed: none (considered: `etoolbox` for `\AtBeginEnvironment` and `\ifstrempty`, sty:222, 280; not proposed, both reduce by inline expansion as written in the Bespoke code table)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes
- Missing asset: `reference.bib` (sty:224) is not in the zip; the sample never cites. TeX Gyre Heros (`.otf`, sty:98-104) and `fontawesome5` come from the TeX distribution.
- The comments headed `PATCH (latextemplates.com)` (sty:85-97, 107-119) are patch notes about fonts; no text in the zip is addressed to an AI.
- Beamer's own source and its default templates were not read.
