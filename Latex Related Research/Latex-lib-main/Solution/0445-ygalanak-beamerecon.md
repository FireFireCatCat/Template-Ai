yes

# 0445-ygalanak-beamerecon: BeamerEcon (Beamer template on the Nord theme)

- Unverified: read from the source, not compiled.
- Source: Source/0445-ygalanak-beamerecon/ (origin: https://codeload.github.com/ygalanak/BeamerEcon/zip/refs/heads/main; licence: GPL-3.0 for the repository (LICENSE:1-2); the three Nord theme files carry LPPL 1.3c headers, beamerthemeNord.sty:1-7)
- Kind: presentation
- Lib: v4
- Engine: needs XeLaTeX (`fontspec` and three system fonts at YGbeamer.sty:10 and 35-37; `% !TeX program = xelatex` at BeamerEcon.tex:4)
- Look carried by: mixed (class `beamer` defaults, the Nord theme whose files are bundled in the zip, and YGbeamer.sty, a zip-local preamble package that loads packages and sets the fonts)
- Class origin: tex-distribution-unbundled
- Main file: BeamerEcon.tex (other samples: none; figures/UK_economy.tex is a fragment pulled in by `\include`, not a document)
- Read: main yes, zip-local classes and styles all (YGbeamer.sty and the three `beamer*themeNord.sty` files; the zip holds no `.cls`)

## Verdict
The look is a published Beamer theme (`beamerthemeNord`, CTAN, v0.2.0 dated 2020-08-24, the same version tag as the zip's copy at beamerthemeNord.sty:9) selected as `\usetheme[style=light]{Nord}`, on the unbundled `beamer` class. The zip-local `YGbeamer.sty` is only package loads, fontspec settings, one date format, two kernel-counter macros and two unused TikZ/pgfplots helper definitions, so every in-scope component maps to a lib way and every bespoke item reduces (or is picture-support content). No `ART`, `EXTERNAL` or irreducible `BESPOKE` blocker was found. Three judgement calls (see Notes) could flip this to `no` under a stricter reading: the pgfplots filter at YGbeamer.sty:65-76, the inert `psfrag` and `animate` loads, and the frame-counter save and restore macros.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `compress`, `aspectratio=169`, `table` (BeamerEcon.tex:6); the theme option is `style=light` (BeamerEcon.tex:8)
- Class-native vocabulary used: `frame` environment with options `plain`, `noframenumbering`, `fragile` (BeamerEcon.tex:21, 28, 145); `\frametitle` and the `\begin{frame}{Title}{Subtitle}` form (BeamerEcon.tex:29, 50); `\subtitle`, `\institute`, short title `\title[..]{..}` (BeamerEcon.tex:12-15); `\maketitle` inside a frame (BeamerEcon.tex:22); `block`, `exampleblock`, `alertblock` (BeamerEcon.tex:90, 95, 100); `description` with a width argument (BeamerEcon.tex:51); `\appendix` (BeamerEcon.tex:163)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | BeamerEcon.tex:6 | `class.beamer` | compress, aspectratio=169, table |
| paper / aspect | BeamerEcon.tex:6 | `page.class-options` | aspectratio=169 |
| theme choice | BeamerEcon.tex:8; beamerthemeNord.sty:9 | `slide.beamer-theme` | `\usetheme[style=light]{Nord}`; Nord is published (CTAN, read); colour and font themes loaded by it at beamerthemeNord.sty:20-21 |
| theme option | beamerthemeNord.sty:13-16; beamercolorthemeNord.sty:37-39, 67-84 | `slide.beamer-theme` | `style=light` picks the light colour set (a closed dark/light list is a parameter) |
| text margins | beamerthemeNord.sty:25 | `slide.beamer-template` | `\setbeamersize{text margin left=8mm,text margin right=8mm}` |
| navigation symbols | beamerthemeNord.sty:23 | `slide.beamer-template` | `\setbeamertemplate{navigation symbols}{}` |
| colour palette | beamercolorthemeNord.sty:15-33 | `color.xcolor` | 16 `\definecolor{Nord..}{HTML}{..}` (2E3440 ... B48EAD) |
| colour roles (light) | beamercolorthemeNord.sty:45-47, 67-84, 91-96 | `color.xcolor` | `\colorlet` roles: background NordBrightestWhite, text NordBrightBlack, structure NordBrightCyan, title NordBrightBlue, block bodies at 20 percent tints |
| beamer colour slots | beamercolorthemeNord.sty:99-125 | `slide.beamer-template` | `\setbeamercolor*` for background canvas, normal/alerted/example text, structure, title, subtitle, frametitle, toc, itemize/enumerate item, section in head/foot, block title/body (plain, example, alerted), caption (fg=NordBrightBlue) |
| inline colour use | BeamerEcon.tex:53-64, 155, 157 | `color.xcolor` | `\textcolor{Nord..}{..}` |
| beamer font slots | beamerfontthemeNord.sty:13-29 | `slide.beamer-template` | `\setbeamerfont`: structure family=\rmfamily series=\bfseries; title \Huge; subtitle \Large; frametitle \Large; framesubtitle \large; section in head/foot \tiny; caption \footnotesize; block title \normalsize \mdseries; item \mdseries |
| font switches in templates | beamerthemeNord.sty:34, 57; beamerfontthemeNord.sty:13, 27, 29 | `mark.kernel` | `\mdseries` `\bfseries` `\boldmath` `\rmfamily` |
| font sizes | BeamerEcon.tex:32, 147, 154; beamerfontthemeNord.sty:15-25 | `font.size-commands` | `\small` `\Huge` `\large` `\Large` `\normalsize` `\tiny` `\footnotesize` |
| main/sans/mono faces | YGbeamer.sty:10, 35-37 | `font.fontspec` | `\setmainfont{Yanone Kaffeesatz}`, `\setmonofont{DejaVu Sans Mono}`, `\setsansfont[]{Fira Sans}`; fonts not shipped |
| icon glyphs | YGbeamer.sty:23, 27; BeamerEcon.tex:155, 157 | `font.icons` | `fontawesome5` (`\faTwitter` `\faEnvelope`), `ccicons[scale=2]` (loaded, unused) |
| TeX-system logo | YGbeamer.sty:8; BeamerEcon.tex:80 | `font.icons` | `metalogo`, `\XeLaTeX` (a logo-by-name package, as `hologo`) |
| language | YGbeamer.sty:7 | `lang.babel` | `[english]` |
| hyperlinks | YGbeamer.sty:12 | `meta.hyperref` | no options |
| URLs | BeamerEcon.tex:78-79 | `meta.url` | `\url{..}` (provided with hyperref) |
| title data | BeamerEcon.tex:12-16 | `front.maketitle` | `\title[ShortTitle]{..}` `\author` `\date` |
| title page extras | BeamerEcon.tex:13, 15, 21-23 | `front.class-native` | `\subtitle`, `\institute`, `\maketitle` in a `plain,noframenumbering` frame |
| title page look | beamerthemeNord.sty:54-66 | `slide.beamer-template` | `\setbeamertemplate{title page}`: title (bold, Huge, colour title), subtitle after `\\[1em]`, author, institute, date at `\\[3em]` `\\[.5em]` `\\[1.5em]` |
| footnote symbols in title page | beamerthemeNord.sty:55-56, 64-65 | `num.counters` | `\renewcommand\thefootnote{\fnsymbol{footnote}}`, `\setcounter{footnote}{1}` then reset |
| spacing in templates | beamerthemeNord.sty:41, 50-52, 58-61; BeamerEcon.tex:36, 125, 137, 149, 153 | `sp.manual-space` | `\vskip2pt` `\vskip5pt` `\vspace{5.2mm}` `\hspace{2mm}` `\hfill` `\\[1em]` `\bigskip` `\vspace*{-3em}` `\hspace*{2em}` `\quad` |
| headline | beamerthemeNord.sty:38-43 | `hf.class-native` | `\setbeamertemplate{headline}` (`slide.beamer-template`): `beamercolorbox{section in head/foot}` with `\insertnavigation{\paperwidth}`; frames are `compress`ed by the class option |
| footline | beamerthemeNord.sty:44-53 | `hf.class-native` | `\setbeamertemplate{footline}`: right-aligned `short author (short institute) . short title . [frame/total]` |
| frame numbers | beamerthemeNord.sty:49; BeamerEcon.tex:21, 145 | `class.beamer` | `\insertframenumber/\inserttotalframenumber`, frame option `noframenumbering` |
| frame title | beamerthemeNord.sty:33-37 | `head.class-native` | `\setbeamertemplate{frametitle}`: `>> ` prefix, `\boldmath\insertframetitle`, subtitle at the right via `\hfill`; `frametitle continuation` `[from second]` |
| sectioning | BeamerEcon.tex:26, 48, 68, 86, 116, 134 | `head.kernel` | `\section`, `\subsection` (feed the navigation bar) |
| contents templates | beamerthemeNord.sty:69-73 | `slide.beamer-template` | `section in toc`, `subsection in toc` (`$\ast$` bullet), `subsection in toc shaded` `[default][100]`; no `\tableofcontents` in the sample |
| lists | BeamerEcon.tex:51-65, 120-131 | `list.kernel` | `itemize`, `enumerate`, `description[Snow Storm]` |
| list bullets | beamerthemeNord.sty:30-32 | `slide.beamer-template` | itemize item, subitem, subsubitem all `$\ast$` |
| blocks | BeamerEcon.tex:88-114; beamerthemeNord.sty:76-85 | `slide.beamer-template` | `\setbeamertemplate{blocks}[rounded][shadow=false]`; `\addtobeamertemplate{block begin}` / `{block alerted begin}` / `{block example begin}` shrink the block text width |
| block width | beamerthemeNord.sty:77-85 | `page.setlength` | `\setlength{\textwidth}{0.85\textwidth}` inside the three block-begin hooks |
| block side by side | BeamerEcon.tex:106-113 | `box.minipage` | `minipage{1.0\linewidth}` and two `minipage{0.4\textwidth}` (149, 153) |
| centring | BeamerEcon.tex:106, 139, 146 | `sp.ragged` | `\centering` |
| display maths | BeamerEcon.tex:91-93, 96-98, 101-103, 109-111 | `math.kernel` | `\[ .. \]` |
| code listings | BeamerEcon.tex:32-34, 41-44, 73-77; YGbeamer.sty:9 | `code.listings` | `lstlisting[basicstyle=\ttfamily\small]` inside `fragile` frames |
| figure float | BeamerEcon.tex:138-141 | `fig.graphicx` | `figure` with `\centering`, no `\caption` in the sample |
| caption look | beamerthemeNord.sty:28; beamercolorthemeNord.sty:125; beamerfontthemeNord.sty:25 | `slide.beamer-template` | `\setbeamertemplate{caption}{\insertcaption}`, colour NordBrightBlue, size \footnotesize |
| file inclusion | BeamerEcon.tex:140 | `struct.input` | `\include{figures/UK_economy}` (a kernel `\include` forces a page break inside a frame; kept as written) |
| appendix | BeamerEcon.tex:163-169 | `num.appendix` | `\appendix` before the backup frame |
| backup frame numbering | YGbeamer.sty:44-50; BeamerEcon.tex:164, 169 | `num.counters` | save `framenumber` into a new counter `finalframe` before the backup frames, restore it after (reduction under Bespoke code) |
| class option `table` | BeamerEcon.tex:6 | `tbl.colortbl` | beamer passes `table` to xcolor (colortbl rows and cells); no table in the sample |
| loaded, unused tables | YGbeamer.sty:15-17 | `tbl.booktabs`, `tbl.multirow` | `booktabs`, `multirow`; `cellspace` is a cell-padding column modifier filed with `tbl.multirow` (package as the parameter) |
| loaded, unused subfigures | YGbeamer.sty:31 | `fig.subcaption` | `subcaption` |
| date format | YGbeamer.sty:26, 28-29 | `front.datetime` | `\newdateformat{monthyeardate}{\monthname[\THEMONTH], \THEYEAR}`; never used |
| picture engine | YGbeamer.sty:11, 13-14, 18-19, 21-22, 25, 52, 78-79 | `art.tikz` | `tikz`, `pgfplots`, `pgfplotstable`, libraries fit, tikzmark, intersections, patterns, pgfplots.fillbetween, decorations.pathreplacing, calc, arrows, decorations, pgfplots library dateplot, `\pgfplotsset{compat=newest}`; serves the figure, content |
| picture styles | YGbeamer.sty:55-63, 65-76 | `art.tikz` | `hl` tikz style and the `discard if not` pgfplots filter; defined, never called anywhere in the zip; picture support, content |
| QR code | YGbeamer.sty:24; BeamerEcon.tex:150 | `art.content-package` | `qrcode` (CTAN, read) `\qrcode[height=1in, level=M]{url}`; a generated image of the author's URL, content |
| inert loads | YGbeamer.sty:20, 30 | none | `psfrag` and `animate` are loaded and never called (see Notes) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `YGbeamer.sty` as a whole | YGbeamer.sty:6-79 | yes | emit the package loads of the map above (`lang.babel`, `font.fontspec`, `meta.hyperref`, `art.tikz`, `code.listings`, `tbl.booktabs`, `tbl.multirow`, `font.icons`, `front.datetime`, `fig.subcaption`), the three `\set..font` lines, and the two counter lines below |
| `\backupbegin`, `\backupend` | YGbeamer.sty:44-50 | yes | `\newcommand` aliases of kernel counter commands, no conditional and no arithmetic: body wrapper before the backup frames `\newcounter{finalframe}\setcounter{finalframe}{\value{framenumber}}`, after them `\setcounter{framenumber}{\value{finalframe}}` (`num.counters`); considered: `appendixnumberbeamer`, a published package for the same job, not read |
| `\newdateformat{monthyeardate}` | YGbeamer.sty:28-29 | yes | `front.datetime` call with the pattern `\monthname[\THEMONTH], \THEYEAR` |
| `hl` tikz style | YGbeamer.sty:55-63 | n/a | key=value style (align, fill, border colour, offset) for tikzmark highlights; never used; a parameter of `art.tikz` pictures, so Content-opaque |
| `discard if not` pgfplots filter | YGbeamer.sty:65-76 | n/a | `x filter/.code` with `\edef`, `\ifx`, `\def\pgfmathresult{inf}`: a program handed to pgfplots, which `_Lib.md` files under Restricted `art.tikz` ("parameters are programs"); never used in the zip, so it changes nothing the sample prints; Content-opaque, not a template look |
| Nord option processing | beamerthemeNord.sty:13-16; beamercolorthemeNord.sty:37-41, 49-88 | yes | internals of the published theme: the emitter writes `\usetheme[style=light]{Nord}`; if the theme were inlined instead, emit only the light branch (color:67-84) |
| Nord footline with `\newbox` / `\setbox` | beamerthemeNord.sty:44-53 | yes | internals of the published theme; as plain template code: `\hfill` plus the text line with `\vspace{5.2mm}` and `\vspace{1.3mm}` (`slide.beamer-template` with `sp.manual-space`); the `\ifblank` test only hides the institute when it is empty, and the sample sets it (BeamerEcon.tex:15) |
| Nord title page / frametitle `\ifx..\@empty` tests | beamerthemeNord.sty:35, 58, 60 | yes | internals of the published theme; each test only skips an unset subtitle or institute field |

## Content-opaque
- pgfplots figure `figures/UK_economy.tex:2-41` (two `axis` environments, `\addplot table` reading `figures/UK_economy.csv`), included at BeamerEcon.tex:140
- QR code `\qrcode[height=1in, level=M]{...}` at BeamerEcon.tex:150
- Unused picture helpers `hl` and `discard if not` at YGbeamer.sty:55-76 (picture support, never called)

## Lib changes
- New ways proposed: none. Considered and not proposed: `animate` and `psfrag` (loaded at YGbeamer.sty:30 and 20, never called; `psfrag` acts only on EPS through dvips, so it has no effect under XeLaTeX; both are load-only with no printed effect, as the rejected `sys.compat-load` in the v4 log, so they are not a component of this sample), `appendixnumberbeamer` (see Bespoke code).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Evidence read: the main sample in full, YGbeamer.sty in full, the three Nord theme files in full, figures/UK_economy.tex and the head of the CSV, README.md, CITATION.cff, the first lines of LICENSE. The two PDFs (BeamerEcon_DarkMode.pdf, BeamerEcon_LightMode.pdf) are rendered output and were not opened.
- Published status: `beamerthemeNord` read at ctan.org/pkg/beamerthemenord (v0.2.0, 2020-08-24, Junwei Wang, LPPL 1.3c); `qrcode` read at ctan.org/pkg/qrcode (v1.51, LPPL 1.3, pure LaTeX, no external tool). Other packages (`metalogo`, `ccicons`, `cellspace`, `animate`, `psfrag`, `datetime`, `fontawesome5`, `pgfplotstable`) are standard TeX Live or CTAN packages known to the analyst and were not re-read. The theme copy in the zip was not diffed against the CTAN source; it matches the version tag, and it reduces to beamer template, colour and font commands even if modified.
- Judgement calls that could flip the verdict under a stricter reading: (1) the `discard if not` filter is read as picture-support content because nothing in the zip calls it and `_Lib.md` makes `art.tikz` parameters programs; read as zip-local logic it would be `BESPOKE/preamble`. (2) `psfrag` and `animate` are read as inert loads, not components; read as unmapped they would be `UNMAPPED/preamble`. (3) the backup-frame macros are read as an alias of kernel counter commands; read as a hand-rolled counter driving the printed frame number they would be `BESPOKE/preamble`.
- Missing assets: fonts Yanone Kaffeesatz, Fira Sans, DejaVu Sans Mono (system-wide, not shipped; README suggests fontsquirrel). No images are used.
- No text addressed to an AI was found in the zip.
