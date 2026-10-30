yes

# 0417-gemini-poster-theme: Gemini Poster Theme (beamer + beamerposter)

- Unverified: read from the source, not compiled.
- Source: Source/0417-gemini-poster-theme/ (origin: https://latextemplates.com/downloads/gemini.zip; licence: MIT)
- Kind: poster
- Lib: v5
- Engine: needs XeLaTeX (`fontspec` is required by the theme at beamerthemegemini.sty:11 and used at :23-24, :28; LuaLaTeX is the other fontspec engine)
- Look carried by: zip-local (the `gemini` beamer theme and colour theme set every template, font and colour; main.tex adds only page size, column lengths and the content)
- Class origin: tex-distribution-unbundled (`beamer`, not in the zip; the theme files are zip-local, see Verdict)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (beamerthemegemini.sty 261 lines, beamercolorthemegemini.sty 54 lines, main.tex 115 lines)

## Verdict
Every part of the look is beamer's own interface (`\setbeamertemplate`, `\setbeamercolor`, `\setbeamerfont`, `beamercolorbox`, `columns`) filled with kernel spacing, `ragged2e`, `changepage`, `fontspec`, `exscale` and `calc`; the Gemini theme is not on CTAN (ctan.org/pkg/gemini is a 404) and is a modified copy of the GitHub theme (font substitution noted at beamerthemegemini.sty:18-22), so it is zip-local but reduces by inlining its two `.sty` files into the preamble. The macros that look like logic (`\logoleft`, `\logoright`, `\footercontent`, the `\ifdefined` and `\ifx ... \empty` guards) only store content in slots or test whether a slot is filled; an emitter knows that at emit time, so they reduce to static template text and length assignments. There is no TikZ or other drawing in the theme, only a placeholder figure in a block (content-opaque), so no ART blocker. The only extra need is a way for the load-only `calc` package (proposed `sp.lengths`).

## Blockers
none

## Class setting
- Class: `class.beamer` options: `final` (main.tex:2); page size by `beamerposter` (main.tex:6)
- Class-native vocabulary used: `frame[t]` (main.tex:30), `columns[t]` (main.tex:31), `column{width}` (main.tex:34), `block`, `exampleblock`, `alertblock` (main.tex:35, 78, 92), `\title`, `\author`, `\inst`, `\and`, `\institute[short]{}` (main.tex:19-21), `itemize` (main.tex:44), beamer template macros the theme uses: `\inserttitle` `\insertauthor` `\insertinstitute` `\insertblocktitle` `\insertenumlabel` (beamerthemegemini.sty:138-144, 170, 63)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2 | `class.beamer` | `final` |
| poster page size | main.tex:6; comment main.tex:1 | `poster.baposter` | `\usepackage[size=custom,width=118.9,height=84.1,scale=1.0]{beamerposter}` (A0 landscape; beamerposter is on CTAN, ctan.org/pkg/beamerposter) |
| text encoding and base font | main.tex:4-5 | `font.fontenc-t1`, `font.lmodern` | `[T1]{fontenc}`, `lmodern` (the theme then sets Nimbus Sans as sans family, below) |
| maths extension font scaling | beamerthemegemini.sty:8 | `font.exscale` | load-only |
| theme fonts | beamerthemegemini.sty:11, 23-24, 28 | `font.fontspec` | `\newfontfamily\Raleway{Nimbus Sans}`, `\newfontfamily\Lato{Nimbus Sans}`, `\setsansfont{Nimbus Sans}` |
| beamer font theme | beamerthemegemini.sty:26 | `slide.beamer-theme` | `\usefonttheme{professionalfonts}` |
| theme invocation | main.tex:7-8 | `slide.beamer-theme` | `\usetheme{gemini}` `\usecolortheme{gemini}`; both names are zip-local, the emitter inlines the two `.sty` files instead (rows below) |
| beamer fonts | beamerthemegemini.sty:30-37 | `slide.beamer-template` | `\setbeamerfont`: headline family=`\Raleway`; headline title size=`\Huge` series=`\bfseries`; headline author size=`\Large`; headline institute size=`\normalsize`; block title family=`\Raleway` size=`\large` series=`\bfseries`; heading family=`\Lato` series=`\bfseries`; caption size=`\small`; footline family=`\Raleway` size=`\normalsize` |
| named colours | beamercolorthemegemini.sty:8-11 | `color.xcolor` | `\definecolor` RGB: lightgray 245,246,250; blue 64,115,158; darkblue 39,60,117; lightblue 232,244,255 |
| beamer colours | beamercolorthemegemini.sty:18-22, 25-26, 29-31, 34-36, 39-41, 44, 47, 50-54 | `slide.beamer-template` | `\setbeamercolor`: palette primary/secondary/quaternary fg=black bg=white, tertiary bg=black fg=white; structure fg=darkblue; headline fg=lightgray bg=blue; headline rule bg=darkblue; block title fg=blue bg=white; block separator bg=black; block body fg=black bg=white; alerted variants bg=lightblue; example variants bg=lightgray; heading fg=black; item fg=darkblue; bibliography entries fg=black |
| title block data | main.tex:19-21 | `front.class-native` | `\title`, `\author` with `\inst{n}` and `\and`, `\institute[shortinst]{...}` |
| title block look (headline) | beamerthemegemini.sty:119-163 | `slide.beamer-template` | `\setbeamertemplate{headline}`: `beamercolorbox{headline}` holding three `columns` (logo left, title column of `\dimexpr\paperwidth-2\maxlogowidth`, logo right), title/author/institute lines each with `\usebeamerfont` and `\usebeamercolor[fg]`, `\vskip5ex` `\vskip3ex` `\vspace{5ex}`, then a full-width `beamercolorbox[wd=\paperwidth,colsep=0.5ex]{headline rule}` |
| title column width expression | beamerthemegemini.sty:133 | `sp.lengths` | `\dimexpr\paperwidth-\maxlogowidth-\maxlogowidth` (eTeX length expression) |
| institute separator | beamerthemegemini.sty:43; main.tex:21 | `sp.manual-space` | `\samelineand` is `\qquad` |
| footer text | main.tex:23-26; beamerthemegemini.sty:244 | `slide.beamer-template` | footer content passed to `\footercontent`, stored in `\insertfootercontent` and printed by the footline template |
| footer look (footline) | beamerthemegemini.sty:246-261 | `slide.beamer-template` | `\setbeamertemplate{footline}`: `beamercolorbox[vmode]{headline}`, rule `beamercolorbox[wd=\paperwidth,colsep=0.25ex]{headline rule}`, `\vspace{1.5ex}`, `\hspace{\sepwidth}`, footline font, `\centering` |
| footer links and spacing | main.tex:24-26 | `meta.hyperref`, `sp.manual-space` | `\href{https://example.org}{...}`, `\href{mailto:...}{...}`, `\hfill` x2 |
| separator and column widths | main.tex:13-17, 32, 64, 111 | `sp.lengths` | `\newlength{\sepwidth}` = 0.025`\paperwidth`, `\newlength{\colwidth}` = 0.3`\paperwidth` (main.tex:15-16); `\separatorcolumn` is an empty `column{\sepwidth}` |
| column layout | main.tex:31-34, 66, 91 | `class.beamer` | native `columns[t]` with three `column{\colwidth}` and four separator columns, all inside one `frame[t]` (main.tex:30) |
| content boxes | main.tex:35, 43, 50, 67, 78, 83, 92, 96, 100; beamerthemegemini.sty:166-241 | `slide.beamer-template` | `block begin`/`block end` (title box `beamercolorbox[colsep*=0ex,dp=2ex,center]{block title}`, separator `beamercolorbox[colsep=0.025ex]{block separator}`, body `beamercolorbox[colsep*=0ex]{block body}`, `\vskip-1.25ex`, `\vskip-0.5ex`, `\vskip-2ex`, `\vspace*{2ex}`); the same shape for `block alerted begin/end` (:190-214) and `block example begin/end` (:217-241) with colour names `... alerted` and `... example`; blocks used: `block`, `exampleblock`, `alertblock` |
| block body justification and centring | beamerthemegemini.sty:178, 202, 229; main.tex:52, 68 | `sp.ragged` | `\justifying` (ragged2e, loaded at :9) inside block bodies; `\centering` in the figure and table blocks |
| block body inset | beamerthemegemini.sty:203-209, 230-236 | `page.adjustwidth` | `adjustwidth{1ex}{1ex}` in alerted and example blocks (changepage loaded at :10); plain block has none (:177-181) |
| block paragraph spacing | beamerthemegemini.sty:179, 204, 231 | `sp.lengths` | `\setlength{\parskip}{1ex}` |
| list spacing | beamerthemegemini.sty:50-53 | `sp.lengths` | `\leftmargin\leftmargini`, `\topsep 1ex`, `\parsep 0pt plus 1pt`, `\itemsep 0.5ex` (set inside a redefinition of `\@listi`) |
| bullet list | main.tex:44-48, 101-107 | `list.kernel` | `itemize`; the References block uses `\item[{[1]}]` manual labels (main.tex:102, 104) |
| bullet markers | beamerthemegemini.sty:57-59 | `slide.beamer-template` | `itemize item/subitem/subsubitem` = `\raise0.5ex/0.3ex/0.2ex` of an `\hbox{\vrule width 0.5ex height 0.5ex}` |
| marker rule and raise | beamerthemegemini.sty:57-59 | `sp.rule`, `sp.manual-space` | `\vrule` width/height 0.5ex, `\raise` |
| enumerate markers (defined, unused) | beamerthemegemini.sty:63-65 | `slide.beamer-template` | `\insertenumlabel.` `\insertsubenumlabel.` `\insertsubsubenumlabel.` |
| bibliography templates (defined, unused) | beamerthemegemini.sty:77-81 | `slide.beamer-template` | `bibliography item` [text]; entry article/title/location/note empty |
| figure | main.tex:51-60; graphicx main.tex:9 | `fig.graphicx` | `figure` with `\centering`; artwork is content |
| figure caption | main.tex:59; beamerthemegemini.sty:71-74 | `cap.kernel`, `slide.beamer-template`, `sp.lengths` | `\caption`; `caption` template [numbered], `caption label separator` [period]; `\abovecaptionskip` 2ex, `\belowcaptionskip` 1ex |
| table | main.tex:69-76; booktabs main.tex:10 | `tbl.tabular`, `tbl.booktabs` | `tabular{lcc}` with `\toprule` `\midrule` `\bottomrule` |
| display maths spacing | beamerthemegemini.sty:68 | `sp.lengths` | `\belowdisplayshortskip` 2ex |
| navigation symbols | beamerthemegemini.sty:84 | `slide.beamer-template` | `\beamertemplatenavigationsymbolsempty` |
| inline emphasis | main.tex:37, 103, 105 | `mark.kernel` | `\texttt`, `\emph` |
| logo slots | beamerthemegemini.sty:98-116 | `sp.lengths`, `sp.lengths` | `\newlength` x3 set to 0cm (:98-103); `\logoleft`/`\logoright` measure the logo with `\settowidth`, `\addtolength{..}{10ex}` and `\setlength{\maxlogowidth}{\maxof{..}{..}}`; calc loaded at :12; the sample calls neither |
| heading helper (defined, unused) | beamerthemegemini.sty:91-95 | `sp.manual-space`, `slide.beamer-template` | `\par\bigskip`, heading font and colour, `\par\smallskip` |
| figure artwork | main.tex:11, 53-58 | `art.tikz` | placeholder `tikzpicture` inside a figure: content |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| theme `gemini` | beamerthemegemini.sty:1-261 | yes | inline into the preamble as `\RequirePackage` lines (exscale, ragged2e, changepage, fontspec, calc) plus the `\setbeamerfont`/`\setbeamertemplate` rows above; no code beyond beamer boxes, kernel spacing and the packages |
| colour theme `gemini` | beamercolorthemegemini.sty:1-54 | yes | `\definecolor` and `\setbeamercolor` calls only (`color.xcolor`, `slide.beamer-template`) |
| `\def\@listi{...}` | beamerthemegemini.sty:50-53 | yes | its whole effect is four list length assignments (`sp.lengths`); whether beamer keeps them for frame lists is not verified |
| `\samelineand` | beamerthemegemini.sty:43 | yes | alias of `\qquad`, expand inline at main.tex:21 |
| `\separatorcolumn` | main.tex:17 | yes | alias of `\begin{column}{\sepwidth}\end{column}`, expand inline |
| `\newlength` x2 and `\setlength` x2 | main.tex:13-16 | yes | `sp.lengths` assignments; the footline also needs `\sepwidth` (beamerthemegemini.sty:253, 257), so the emitter must write them before the footline template |
| `\heading` | beamerthemegemini.sty:91-95 | yes | alias of `\par\bigskip`, font, colour, `\par\smallskip`; unused by the sample |
| `\logoleft`, `\logoright`, `\insertlogoleft/right` | beamerthemegemini.sty:98-116 | yes | slot setters (a `\newcommand` inside a `\newcommand` that stores content); the emitter knows at emit time whether a logo exists, writes the logo into the headline template directly and emits `\settowidth`, `\addtolength{..}{10ex}` and the `\maxof` length (`sp.lengths`, `sp.lengths`); not called in the sample, widths stay 0cm |
| `\footercontent`, `\insertfootercontent` | beamerthemegemini.sty:244, 247, 256; main.tex:23-26 | yes | content slot: inline the footer text into the footline template; the `\ifdefined` test (:247) is resolved at emit time (footer given, so the template is emitted) |
| headline template guards | beamerthemegemini.sty:125, 137, 140, 143, 149, 159 | yes | `\ifdefined`, `\ifx ... \empty` and `\ifbeamercolorempty` only test whether a field or colour is set; resolved at emit time (title, author, institute present; headline rule bg set at beamercolorthemegemini.sty:26) |
| block, alerted and example templates | beamerthemegemini.sty:166-241 | yes | beamer `\setbeamertemplate{block begin/end}` etc. with `beamercolorbox`, fonts, kernel skips, `\justifying`, `adjustwidth`; free template box code, the type `slide.beamer-template` already takes (see the lib line of `slide.hackthefootline`) |
| footline template | beamerthemegemini.sty:246-261 | yes | as above |

Notes (not blockers): the colour names `headline title`, `headline author`, `headline institute` are used at beamerthemegemini.sty:138, 141, 144 but never set in beamercolorthemegemini.sty (it sets only `headline` and `headline rule`, :25-26); what beamer prints for an unset colour name was not checked. Raleway and Lato are not used, Nimbus Sans stands in (beamerthemegemini.sty:18-24); the font is not shipped in the zip and has to be installed (missing asset, not a blocker).

## Content-opaque
- placeholder `tikzpicture` (rectangle, dashed diagonals, node text) inside the figure float at main.tex:53-58, with `\usepackage{tikz}` at main.tex:11

## Lib changes
- New ways proposed: `sp.lengths` `calc` package (latex-tools bundle, TeX Live `tools`, LPPL 1.3c; ctan.org/pkg/calc read), engine pdf, a load-only `\usepackage{calc}` with no options that adds infix expressions to the arguments of `\setlength`, `\addtolength`, `\setcounter`, `\addtocounter`; the theme loads it at beamerthemegemini.sty:12 and relies on it for `\maxof` at :109 (that `\maxof` comes from calc was not confirmed: the CTAN page does not name it and the source was not read). W1: published on CTAN and in TeX Live. W2: behaviour is chosen by the expression written in a length argument, no code edits. W3: serves any document's length arithmetic. W4: one preamble line plus expressions inside `\setlength` arguments. Not `sp.lengths` (raw length parameters, not an expression syntax package), not `tbl.calctab` (a table package).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
