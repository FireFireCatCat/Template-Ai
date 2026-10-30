yes

# 0057-hobete: Hobete, the (unofficial) beamer theme of the University of Hohenheim, poster mode

- Unverified: read from the source, not compiled.
- Source: Source/0057-hobete/ (origin: https://mirrors.ctan.org/macros/latex/contrib/beamer-contrib/themes/hobete.zip; licence: LPPL, README:28 says "lppl or GNU")
- Kind: poster
- Lib: v2
- Engine: pdfLaTeX-compatible (beamer, beamerposter, tikz, expl3 `l3keys2e` `xparse` `xfrac`; no fontspec, no Lua; whether the 2012 expl3 names in `hobete.sty` still load on a current kernel is not established)
- Look carried by: mixed (a published beamer theme package, `hobete`, carries the look; the sample's preamble adds only beamerposter size, column height, logo and contact strings)
- Class origin: tex-distribution-unbundled
- Main file: poster-test.tex (other samples: hobete_doc.tex, a slide-mode manual and example; `hobete_doc.pdf` is its compiled output, not read)
- Read: main yes, zip-local classes and styles all (`hobete.sty`, `beamerthemehohenheim.sty`, `beamercolorthemehohenheim.sty`, `beamerouterthemehohenheim.sty`, `beamerouterthemehohenheimposter.sty`, and `hobete_doc.tex` in full)

## Verdict
yes. There is no class in the zip: the sample loads the published `beamer` class and the `hobete` package, which is on CTAN (`/macros/latex/contrib/beamer-contrib/themes/hobete`, one ctan.org/pkg read) and in TeX Live, so its five `.sty` files are published (W1) and are not bespoke code. An emitter writes `\usepackage[poster=true]{hobete}` (the same as `\usetheme{hohenheim}` plus `\useoutertheme{hohenheimposter}`, hobete.sty:265-269) and `beamerposter`, with no copied macro logic. As a cross-check, everything the poster path executes also reduces to published beamer declarations (`\setbeamercolor`, `\setbeamertemplate`, `\setbeamerfont`, `beamercolorbox`, `columns`, `minipage`) and one kernel counter; there is no TikZ drawing on that path. The slide-mode machinery in `hobete.sty` (frame list, fancy title, section page) is skipped when `poster=true` (hobete.sty:65 to 263) and is package-internal, so it is not a blocker.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `final`, `hyperref={pdfpagelabels=false}` (poster-test.tex:14). Second sample: `xcolor={table}` (hobete_doc.tex:13).
- Class-native vocabulary used: `frame`, `columns`/`column[T]{width}`, `block`, `beamercolorbox[wd,ht,dp,center,leftskip,rounded,sep,colsep*]{name}`, `\title` `\author` `\institute[short]{}` `\date[short]{}`, `\insertframetitle` `\inserttitle` `\insertauthor` `\insertinstitute` `\insertshortauthor`, `\usebeamercolor` `\usebeamerfont`, `\ifbeamercolorempty`, `\beamertemplatenavigationsymbolsempty`, `\tableofcontents`, `alertblock` `exampleblock` `definition` `theorem` `proof` (second sample).
- Theme-native vocabulary (hobete, published): option `poster=true`; `outerretainblock`, `posterblock{title}`, `\mylogo{}`, `\posteremail{}`, `\posterwebsite{}` (poster mode); `\sectionpage[plain=true]`, `\HohenheimFancyTitle{}`, `\HohenheimLogoKlein`/`\HohenheimLogoLang`, `\printframelist`, options `framelist front` `framelist back` (slide mode).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | poster-test.tex:14 | `class.beamer` | final; hyperref option list passed through |
| PDF metadata option | poster-test.tex:14 | `meta.hyperref` | pdfpagelabels=false |
| beamer theme set | poster-test.tex:16,44; hobete.sty:265,267-269; beamerthemehohenheim.sty:13-16 | `slide.beamer-theme` | `\usepackage[poster=true]{hobete}` = usetheme hohenheim + useoutertheme hohenheimposter; inside: useoutertheme hohenheim, usefonttheme professionalfonts, useinnertheme[shadow=true]{rounded}, usecolortheme hohenheim. The second `\usepackage[poster=true]{hobete}` (poster-test.tex:44) repeats the first with the same options. |
| poster paper and scale | poster-test.tex:41 | `poster.baposter` | beamerposter: orientation=portrait, size=a0, scale=1.4, debug |
| colour definitions | beamercolorthemehohenheim.sty:17-36 | `color.xcolor` | `\definecolor[named]{Hohenheim}{cmyk}{1.0,0.5,0,0.45}`, `\colorlet{Hohenheimbg}{Hohenheim!20!white}`, HohenheimBW cmyk{0,0,0,0.6}, 5 secondary and 4 glow cmyk colours |
| beamer colour roles | beamercolorthemehohenheim.sty:41-76 | `slide.beamer-template` | `\setbeamercolor`: normal text bg=brown!2!white (page tint), palette primary..quaternary, frametitle, block title/body (+alerted, example), titlelike, item and toc colours |
| block (box) look, numbered titles | beamerouterthemehohenheimposter.sty:14-15,17-30 | `slide.beamer-template`, `num.counters` | `\setbeamertemplate{block begin}`/`{block end}`: beamercolorbox title ht=2.5cm dp=1cm center leftskip=1em sep=2mm rounded=true, text "\thetgpostercount .~\insertblocktitle"; body beamercolorbox leftskip=1em sep=5mm rounded=true; kernel counter `tgpostercount` stepped per block |
| headline | beamerouterthemehohenheimposter.sty:33-61 | `hf.class-native`, `slide.beamer-template`, `sp.ragged` | `\setbeamertemplate{headline}`: colour box wd=\paperwidth; `columns[T]` of .02/.8/.2/.02 `\paperwidth`; `\raggedleft`; `\Huge\textbf` title, `\large` author and institute; logo column `\insertmylogo`; 3pt `\rule` separation box |
| footline | beamerouterthemehohenheimposter.sty:67-82 | `hf.class-native`, `slide.beamer-template`, `sp.rule`, `sp.manual-space` | `\setbeamertemplate{footline}`: 3pt `\rule` box, colour box ht=2cm leftskip=rightskip=1em with `\texttt{\insertwebsite}` `\hfill` `\texttt{\insertemail}`; `\vskip.5cm`. Template text prints a literal "gg" between the two (line 74). |
| block and list fonts | beamerouterthemehohenheimposter.sty:88-92 | `slide.beamer-template` | `\setbeamerfont`: itemize/enumerate body, subbody, subsubbody and block body size=\normalsize; block title size=\large |
| navigation symbols off | beamerouterthemehohenheimposter.sty:65 | `slide.beamer-template` | `\beamertemplatenavigationsymbolsempty` |
| item and toc markers | beamerthemehohenheim.sty:18-22 | `slide.beamer-template`, `list.kernel` | itemize items, enumerate items, section in toc, subsection in toc = circle; section number projected size=\normalsize series=\bfseries |
| text margins | beamerouterthemehohenheim.sty:56 | `slide.beamer-template` | `\setbeamersize{text margin left=1em,text margin right=1em}` (beamer size command, same family as the `\setbeamer*` ways) |
| poster column wrapper | hobete.sty:286-292; poster-test.tex:55-56,67,134 | `cols.minipage`, `box.minipage`, `sp.lengths` | `outerretainblock` = `column{.49\textwidth}` + `beamercolorbox[center,wd=\textwidth]{postercolumn}` + `minipage[t][\columnheight][t]{.95\textwidth}`, then `\hfill`; `\columnheight`=105cm via `\newlength`/`\setlength` |
| poster block wrapper | hobete.sty:284; poster-test.tex:70-126,135-146 | `slide.beamer-template`, `sp.manual-space` | `posterblock{title}` = beamer `block{title}` then `\vfill` |
| nested columns | poster-test.tex:78-105 | `cols.minipage` | `columns`, `column{.55\textwidth}`, `column{.44\textwidth}` |
| title data | poster-test.tex:48-51 | `front.class-native` | `\title`; `\author`; `\institute[A Institite, Uni Fancyt.]{...}`; `\date[2012]{Mar 2012}` (printed by the headline template, no `\maketitle`) |
| logo | poster-test.tex:58; hobete.sty:60-62 | `fig.graphicx` | `\mylogo{\includegraphics[height=10cm]{...}}`; storage macro `\insertmylogo` is an alias (see Bespoke code) |
| contact strings | poster-test.tex:34,38; hobete.sty:294-298 | `sp.manual-space` (footline use only) | `\posteremail{text.name}`, `\posterwebsite{www.uni-somewhere.de}`: string storage, printed in the footline |
| lists | poster-test.tex:71-74,80-91 | `list.kernel` | itemize, nested itemize |
| table | poster-test.tex:23-24,95-103 | `tbl.tabular`, `tbl.tabularx`, `tbl.booktabs`, `sp.ragged` | `tabularx{\linewidth}{ZZZ}`; `\newcolumntype{Z}{>{\centering\arraybackslash}X}`; booktabs loaded, not used |
| display maths | poster-test.tex:22,112-118 | `math.amsmath`, `math.amssymb` | `align*`; amsmath, amssymb, latexsym loaded (latexsym as a symbol package) |
| theorem package | poster-test.tex:22 | `thm.amsthm` | loaded, no `\newtheorem` or statement in the body |
| bold maths | poster-test.tex:27 | `math.bm` | kernel `\boldmath` (closest home: bold maths) |
| language, encoding | poster-test.tex:20-21 | `lang.babel`, `font.fontenc-t1` | babel `english`; inputenc `latin1` (the sample file is Latin-1) |
| colour alias | poster-test.tex:25 | `color.xcolor` | `\newcommand{\pphantom}{\textcolor{Hohenheim}}`, never used in the body |
| closing line | poster-test.tex:149 | `font.size-commands`, `sp.manual-space`, `mark.kernel` | `\tiny`, `\hfill`, `\hskip1em`, `\texttt`, `\LaTeX` |
| (2nd sample) packages | hobete_doc.tex:15-18,24,27-28 | `lang.babel`, `font.fontenc-t1`, `font.lmodern`, `tbl.booktabs`, `meta.url`, `tbl.tabularx`, `math.amsmath`, `math.amssymb` | ngerman; T1; lmodern; booktabs, url, calc, tabularx |
| (2nd sample) glyph and code | hobete_doc.tex:25-26,29-30 | `font.icons`, `code.listings` | `phaistos` `\PHbee`; `\lstdefinestyle{tex}{language=tex,basicstyle={\footnotesize\ttfamily},breaklines=true}` |
| (2nd sample) theme use | hobete_doc.tex:43,56,57,73,77,194,260-261 | `slide.beamer-theme`, `slide.beamer-template`, `toc.kernel` | options `framelist front={o\ }` `framelist back={\ }`; `\HohenheimFancyTitle{}`, `\printframelist`, `\sectionpage[plain=true]` are hobete vocabulary; `\frame{\tableofcontents}` |
| (2nd sample) boxes, tables, lists | hobete_doc.tex:94-122,203-247,295-314,320 | `box.fancybox`, `tbl.tabular`, `tbl.colortbl`, `thm.class-native`, `slide.beamer-mode` | `\fcolorbox` swatches; `\rowcolor`; `alertblock` `exampleblock` `definition` `theorem` `proof`; itemize overlay specification |

## Bespoke code
The five `.sty` files are published (CTAN, TeX Live), so they are not bespoke. The rows below record what each piece reduces to, so the answer survives if a reader counts the files as zip-local instead.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `posterblock`, `outerretainblock` | hobete.sty:284-292 | yes | beamer `block` + `\vfill`; `column` + `beamercolorbox` + `minipage[t][\columnheight][t]` (rows above) |
| `\mylogo`/`\insertmylogo`, `\posteremail`/`\insertemail`, `\posterwebsite`/`\insertwebsite` | hobete.sty:60-62,294-298 | yes | one stored string or box each (`\newcommand` alias), read by the headline and footline templates |
| numbered block titles, counter `tgpostercount` | beamerouterthemehohenheimposter.sty:14-15,21 | yes | kernel `\newcounter`, `\refstepcounter`, `\the...` inside `\setbeamertemplate{block begin}` (`num.counters`); linear count, no conditional drives it |
| poster headline and footline templates | beamerouterthemehohenheimposter.sty:33-82 | yes | `\setbeamertemplate` with `columns`, `beamercolorbox`, `\rule`, `\raggedleft` |
| hohenheim outer theme templates (footline, headline, frametitle) | beamerouterthemehohenheim.sty:27-88 | yes | `\defbeamertemplate*` bodies of `beamercolorbox` rows (`\insertshortauthor` etc.); lines 27-57 are marked as copied from beamer's infolines theme; headline and footline are replaced by the poster theme (poster-theme lines 33,67) |
| option parser (`poster`, `framelist front/back`, `plain`) | hobete.sty:30-42 | yes | `\ProcessKeysOptions`: one boolean and two token lists; the poster flag only chooses which theme is loaded |
| `\sectionpage[plain]` | hobete.sty:67-78 | yes, slide mode only | `frame` with `beamercolorbox[wd=\textwidth,ht=4ex,dp=1ex,center,rounded=true,shadow=true]{titlelike}` and `\insertsection` |
| frame list (`\frametitle` wrapper, `.frml` file) | hobete.sty:104-179 | published package code, slide mode only, not run when `poster=true` | If it were zip-local it would be irreducible (expl3 token lists, `\iow_now` at `\AtEndDocument`, read back with `\input`); no lib way holds it. TeX-only, no outside tool. |
| fancy title with logo overlay | hobete.sty:187-263 | published package code, slide mode only | TikZ overlay of two user logos at page corners (`scale=1.7`, `text opacity=.07`, `scale=0.9`, `text opacity=.8`), chosen by `\AtBeginDocument` tests; closest homes `bg.tikzpagenodes`, `color.transparent`; the logos are not in the zip and the manual keeps those lines commented out (hobete_doc.tex:47-48) |

## Content-opaque
- pgfplots/TikZ plot in a frame, second sample only (hobete_doc.tex:282-293).
- Logo image: `\mylogo` points to a TeX Live 2011 documentation file outside the zip, `.../pstricks/images/tiger.pdf` (poster-test.tex:58; hobete_doc.tex:56). Missing asset: the university logo is not shipped (README:10 and README:24, logo use restricted; hobete_doc.tex:51 says the licence is unclear); a user logo goes there.
- `hobete_doc.frml` is read by `\input` (hobete_doc.tex:195) and is written by the package at the end of an earlier run, so it is not in the zip.
- Notes: no text addressed to an AI was found in the zip. `beamerposter` was not read (published, not in the zip), so its `debug` option is recorded by name only. The colour `postercolumn` has no `\setbeamercolor` in the zip (beamercolorthemehohenheim.sty:77 is commented out); how beamer treats it was not established.

## Lib changes
- New ways proposed: none. The theme's body wrappers and string macros reduce to existing ways, as listed above.
- Wording note, no way added: `slide.beamer-template` could name `\defbeamertemplate`, `\setbeamersize` and `\beamertemplatenavigationsymbolsempty` beside the three `\setbeamer*` commands it lists; this zip uses all three.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
