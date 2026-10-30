yes

# 0057-hobete: Hohenheim beamer theme (hobete) with poster mode

- Unverified: read from the source, not compiled.
- Source: Source/0057-hobete/ (origin: https://mirrors.ctan.org/macros/latex/contrib/beamer-contrib/themes/hobete.zip; licence: lppl, README:28 also offers GNU)
- Kind: poster
- Lib: v1
- Engine: pdfLaTeX-compatible (beamer, beamerposter, expl3 and tikz only; no fontspec, no shell escape; hobete_doc.tex:13-18 uses `T1`/`lmodern`)
- Look carried by: mixed (published class `beamer` plus the CTAN beamer-contrib theme files shipped in the zip: hobete.sty, beamerthemehohenheim.sty, beamercolor/outer themes; the sample preamble adds `beamerposter`, column length, logo and e-mail/website strings)
- Class origin: tex-distribution-unbundled (class `beamer` is not in the zip; the theme files in the zip are NOT zip-local: ctan.org/pkg/hobete confirms "Hobete", LPPL, `/macros/latex/contrib/beamer-contrib/themes/hobete`)
- Main file: poster-test.tex (other samples: hobete_doc.tex, the slide-mode manual, read in full as a second sample)
- Read: main yes, zip-local classes and styles all (five `.sty` files read in full; none is zip-local by origin)

## Verdict
Yes, with one stated dependency. The main sample is a beamer poster that loads the CTAN theme package `hobete` with `poster=true` (poster-test.tex:16,44) plus `beamerposter` (poster-test.tex:41); everything else in its preamble and body is published packages and kernel commands, and its few `\newcommand`/`\newcolumntype`/`\newlength` lines are aliases. Even if the theme files were inlined instead of loaded, the poster path reduces to `slide.beamer-template` compositions (colour definitions, `\setbeamertemplate` headline/footline/block, `beamercolorbox` keys, one kernel counter) with no irreducible code. Caveat for the next reader: the slide-mode half of hobete.sty (frame list written to a `.frml` file, hobete.sty:104-179; tikz logo overlays on a title frame, hobete.sty:202-237) would be `BESPOKE/class` and `ART/class` if hobete were refused as a published way; it is skipped entirely when `poster=true` (hobete.sty:65 to 263 sits inside `\bool_if:NF \g_hobete_poster_bool`), and under W1 it is CTAN-published code, so it is not counted.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `final`, `hyperref={pdfpagelabels=false}` (poster-test.tex:14); the manual uses `xcolor={table}` (hobete_doc.tex:13)
- Class-native vocabulary used: `frame`, `columns`/`column` with width in `\textwidth` (poster-test.tex:66,78-79,93), `block` (through the theme's `posterblock`), `\title` `\author` `\institute[short]{}` `\date[short]{}` (poster-test.tex:48-51), `beamercolorbox` (theme files), `\setbeamercolor` `\setbeamerfont` `\setbeamertemplate` `\defbeamertemplate*` `\setbeamersize` `\beamertemplatenavigationsymbolsempty` (theme files), `\insert*` macros (title, author, institute, shortauthor, shorttitle, shortdate, framenumber, section/subsection head)
- Theme-native vocabulary (package `hobete`, hobete.sty:60-62, 284-298): option `poster=true`; environments `posterblock{title}` and `outerretainblock`; commands `\mylogo{...}`/`\insertmylogo`, `\posteremail{}`/`\insertemail`, `\posterwebsite{}`/`\insertwebsite`; slide mode only: `\sectionpage[plain=true]`, `\HohenheimLogoKlein`, `\HohenheimLogoLang`, `\HohenheimFancyTitle`, `\printframelist`, options `framelist front`/`framelist back`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | poster-test.tex:14 | `class.beamer` | `final`, `hyperref={pdfpagelabels=false}` |
| theme loader | poster-test.tex:16,44; hobete.sty:265,269 | `slide.beamer-theme` | package `hobete[poster=true]` runs `\usetheme{hohenheim}` then `\useoutertheme{hohenheimposter}`; theme `hohenheim` = `\useoutertheme{hohenheim}`, `\usefonttheme{professionalfonts}`, `\useinnertheme[shadow=true]{rounded}`, `\usecolortheme{hohenheim}` (beamerthemehohenheim.sty:13-16) |
| paper size, orientation, scale | poster-test.tex:41 | `poster.baposter` | `beamerposter[orientation=portrait,size=a0,scale=1.4,debug]`, loaded after hobete |
| colour definitions | beamercolorthemehohenheim.sty:17-36 | `color.xcolor` | `\definecolor[named]{Hohenheim}{cmyk}{1.0,0.5,0,0.45}`; `\colorlet{Hohenheimbg}{Hohenheim!20!white}`; `HohenheimBW` cmyk 0,0,0,0.6; five muted and four glowing secondary cmyk colours |
| beamer colour roles | beamercolorthemehohenheim.sty:41-76; beamerouterthemehohenheim.sty:18-24 | `slide.beamer-template` | `\setbeamercolor` for normal text (bg=brown!2!white), alerted text, palette primary..quaternary, sidebar, frametitle, block title/body (+alerted, example), titlelike, itemize item, toc entries; head/foot roles with `parent=palette ...` |
| poster block look | beamerouterthemehohenheimposter.sty:17-30 | `slide.beamer-template` | `\setbeamertemplate{block begin}`/`{block end}` with two `beamercolorbox` (title: ht=2.5cm, dp=1cm, center, leftskip=1em, colsep*=0ex, sep=2mm, rounded=true; body: leftskip=1em, colsep*=.75ex, sep=5mm, vmode, rounded=true) |
| block title numbering | beamerouterthemehohenheimposter.sty:14-15,21 | `num.counters` | `\newcounter{tgpostercount}`, `\refstepcounter`, `\thetgpostercount.~` printed before `\insertblocktitle` |
| poster headline | beamerouterthemehohenheimposter.sty:33-61 | `slide.beamer-template` | `headline` template: `beamercolorbox[wd=\paperwidth]{frametitle}` holding `columns[T]` of .02/.8/.2/.02 `\paperwidth`; title `\Huge\textbf`, author and institute `\large`, `\raggedleft`; logo via `\insertmylogo`; separator box with `\rule{0pt}{3pt}` |
| headline layout pieces | beamerouterthemehohenheimposter.sty:36-60 | `cols.minipage`, `sp.ragged`, `font.size-commands`, `mark.kernel`, `sp.manual-space`, `sp.rule` | beamer `columns`/`column`; `\raggedleft`, `\centering`; `\Huge` `\large`; `\textbf`; `\vskip5ex`, `\\[3ex]`; `\rule{0pt}{3pt}` |
| poster footline | beamerouterthemehohenheimposter.sty:65-82 | `slide.beamer-template` | `\beamertemplatenavigationsymbolsempty`; `footline` with separator box and `beamercolorbox[ht=2cm,leftskip=1em,rightskip=1em]{author in head/foot}` showing `\texttt{\insertwebsite}\hfill gg \texttt{\insertemail}` (the literal `gg` is in the template, line 74) |
| poster font sizes | beamerouterthemehohenheimposter.sty:88-92 | `slide.beamer-template` | `\setbeamerfont`: itemize/enumerate body, subbody, subsubbody = `\normalsize`; block body `\normalsize`; block title `\large` |
| frame title font | beamerouterthemehohenheim.sty:64 | `slide.beamer-template` | `\setbeamerfont{frametitle}{series=\bfseries}` |
| item and toc glyphs | beamerthemehohenheim.sty:18-22 | `slide.beamer-template` | `\setbeamertemplate{itemize items}[circle]`, `{enumerate items}[circle]`, `{section in toc}[circle]`, `{subsection in toc}[circle]`; `\setbeamerfont{section number projected}{size=\normalsize,series=\bfseries}` |
| text margins | beamerouterthemehohenheim.sty:56 | `slide.beamer-template` | `\setbeamersize{text margin left=1em,text margin right=1em}` |
| poster column | hobete.sty:286-292; poster-test.tex:67,129,134,150 | `cols.minipage`, `box.minipage`, `slide.beamer-template` | `outerretainblock` = `column{.49\textwidth}` + `beamercolorbox[center,wd=\textwidth]{postercolumn}` + `minipage[t][\columnheight][t]{.95\textwidth}`, then `\hfill` |
| column height | poster-test.tex:55-56 | `sp.lengths` | `\newlength{\columnheight}`, `\setlength{\columnheight}{105cm}` |
| poster block | hobete.sty:284; poster-test.tex:70-126,135-146 | `slide.beamer-template`, `sp.manual-space` | `posterblock{title}` = `block{title}` ... `\end{block}\vfill` |
| title, authors, institute, date | poster-test.tex:48-51 | `front.class-native` | `\title`, `\author`, `\institute[A Institite, Uni Fancyt.]{...}`, `\date[2012]{Mar 2012}`; printed by the poster headline, not by `\maketitle` |
| e-mail and website | poster-test.tex:34,38; hobete.sty:294-298 | `front.class-native` | `\posteremail{text.name}`, `\posterwebsite{www.uni-somewhere.de}` stored as strings, shown in the footline |
| logo | poster-test.tex:58; hobete.sty:60-62 | `fig.graphicx` | `\mylogo{\includegraphics[height=10cm]{<absolute path>/tiger.pdf}}`; asset not in the zip |
| language, encoding | poster-test.tex:20-21 | `lang.babel`, `font.fontenc-t1` | `babel[english]`; `inputenc[latin1]` |
| math packages | poster-test.tex:22 | `math.amsmath`, `math.amssymb`, `thm.amsthm` | `amsmath`, `amsthm` (loaded, no theorem in body), `amssymb`, `latexsym` (grouped with `amssymb`) |
| bold math default | poster-test.tex:27 | `math.kernel` | kernel `\boldmath` (no lib way for the kernel math-version switch; closest home) |
| display equation | poster-test.tex:114-116 | `math.amsmath` | `align*` |
| table | poster-test.tex:23-24,95-103 | `tbl.tabularx`, `tbl.tabular`, `tbl.booktabs`, `sp.ragged` | `array`, `booktabs` (loaded, unused), `tabularx{\linewidth}{ZZZ}`, `\newcolumntype{Z}{>{\centering\arraybackslash}X}` |
| lists | poster-test.tex:71-74,80-91 | `list.kernel` | nested `itemize` (glyphs from the theme item template) |
| two columns inside a block | poster-test.tex:78-105 | `cols.minipage` | `columns` with `column{.55\textwidth}` and `column{.44\textwidth}` |
| alias for colour | poster-test.tex:25 | `color.xcolor` | `\newcommand{\pphantom}{\textcolor{Hohenheim}}` (never used) |
| footer line in column | poster-test.tex:149 | `font.size-commands`, `sp.manual-space`, `mark.kernel` | `\tiny\hfill{...\hskip1em}`, `\texttt` |
| PDF metadata | poster-test.tex:14 | `meta.hyperref` | `pdfpagelabels=false` via class option |
| (doc sample) sectionpage | hobete.sty:67-78; hobete_doc.tex:260-261 | `slide.beamer-theme` | published `hobete` slide-mode command `\sectionpage[plain=true]`: frame with `beamercolorbox[wd=\textwidth,ht=4ex,dp=1ex,center,rounded=true,shadow=true]{titlelike}` |
| (doc sample) frame title with logo | beamerouterthemehohenheim.sty:82-88 | `slide.beamer-template`, `sp.manual-space` | `frametitle` template with `\hfill \raisebox{-2ex}[0pt][-\ht\strutbox]{\insertmylogo}` |
| (doc sample) head/foot lines | beamerouterthemehohenheim.sty:27-54 | `slide.beamer-template` | `footline` (author, short title, date and frame number / total) and `headline` (section, subsection), each three or two `beamercolorbox` with `ht=2.25ex,dp=1ex`; parts marked as copied from the beamer `infolines` theme |
| (doc sample) frame list | hobete.sty:104-179,43 | `slide.beamer-theme` | published `\printframelist` plus options `framelist front`/`framelist back` (see Bespoke code) |
| (doc sample) fancy title | hobete.sty:187-263; hobete_doc.tex:73 | `slide.beamer-theme` | published `\HohenheimFancyTitle{}` with `\HohenheimLogoKlein`/`\HohenheimLogoLang` (see Bespoke code) |
| (doc sample) fonts, code, tables | hobete_doc.tex:15-18,24,27-30,94-99,263-279 | `lang.babel`, `font.fontenc-t1`, `font.lmodern`, `meta.url`, `tbl.tabularx`, `tbl.booktabs`, `tbl.colortbl`, `code.listings` | `babel[ngerman]`, `T1`, `lmodern`, `url`, `tabularx`, `booktabs`, `xcolor={table}` with `\rowcolor`, `\lstdefinestyle{tex}{language=tex, basicstyle=..., breaklines=true}` |
| (doc sample) theorems, overlays, toc | hobete_doc.tex:294-317,320,77 | `thm.class-native`, `slide.beamer-mode`, `toc.kernel` | `alertblock`, `exampleblock`, `definition`, `theorem`, `proof`; `itemize[<+-\| alert@+>]`; `\frame{\tableofcontents}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcolumntype{Z}`, `\pphantom`, `\columnheight` | poster-test.tex:24-25,55-56 | yes | `tbl.tabularx` column type; `color.xcolor` alias; `sp.lengths` |
| `hobete` option `poster` and `\useoutertheme{hohenheimposter}` | hobete.sty:21-42,267-273 | yes (published anyway) | one bool chooses the poster outer theme; emitter writes the outer theme directly |
| `posterblock`, `outerretainblock`, `\posteremail`, `\posterwebsite`, `\mylogo` | hobete.sty:60-62,284-298 | yes (published anyway) | aliases of `block`+`\vfill`, `column`+`beamercolorbox`+`minipage`, `\newcommand` strings (`\detokenize`), a stored logo box |
| poster outer theme templates and block counter | beamerouterthemehohenheimposter.sty:14-92 | yes (published anyway) | `slide.beamer-template` compositions listed above; the counter is one kernel counter stepped inside the block title, no conditionals |
| colour theme | beamercolorthemehohenheim.sty:11-79 | yes (published anyway) | `color.xcolor` definitions plus `\setbeamercolor` calls |
| hohenheim outer theme and theme file | beamerouterthemehohenheim.sty:16-91; beamerthemehohenheim.sty:11-25 | yes (published anyway) | `\defbeamertemplate*` bodies inlined as `\setbeamertemplate{headline|footline|frametitle}`, `\setbeamersize`, `\setbeamerfont` |
| slide mode: frame list (redefined `\frametitle`, `\iow_*` write of `\jobname.frml` at `\AtEndDocument`, string-compare dedupe, `\input` of the list on the next run) | hobete.sty:104-179; hobete_doc.tex:194-195 | no, if inlined (output-affecting file I/O and `\frametitle` redefinition); not a blocker because hobete is CTAN-published and the code is skipped in poster mode | none; stays behind the published package; needs two runs |
| slide mode: logo overlays on the title frame, three variants picked by `\tl_if_empty` tests at `\AtBeginDocument` | hobete.sty:187-263 | no, if inlined (`ART/class`: tikz page-corner nodes with `fill opacity`/`text opacity`, partly a watermark but chosen by hand-rolled conditionals); same status as above | none; stays behind the published package |
| unconditional dependencies | hobete.sty:11,15 | n/a | `expl3`, `l3keys2e`, `xfrac`, `xparse`, `tikz` are pure TeX; no external tool; compile status of the 2012 expl3 code on a current TeX Live is not established (for instance `\tl_posteremail` at hobete.sty:294-298 is never declared with `\tl_new:N`) |

## Content-opaque
- Poster logo image `tiger.pdf` at an absolute path under `/usr/local/texlive/2011` (poster-test.tex:58), not shipped; the README says the university logos may not be redistributed.
- Doc sample only: pgfplots double-axis picture inside a frame (hobete_doc.tex:283-292); `phaistos` bee glyph and `\scalebox` (hobete_doc.tex:25-26), a content package (`art.content-package`).
- Doc sample only: tikz logo-overlay example in a `lstlisting` (hobete_doc.tex:156-167) is code text.

## Lib changes
- New ways proposed: none. The theme package is treated as a parameter of `slide.beamer-theme` (theme name is a parameter, as for `bib.bibtex-bst`); its own vocabulary is recorded under "Class setting". If a reviewer holds that a one-university CI theme fails W3, the lib would need a decision on published beamer themes, not a new way.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
