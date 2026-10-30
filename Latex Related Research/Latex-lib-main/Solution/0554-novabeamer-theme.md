yes

# 0554-novabeamer-theme: NovaBeamer-Theme

- Unverified: read from the source, not compiled.
- Source: Source/0554-novabeamer-theme/ (origin: https://mirrors.ctan.org/macros/latex/contrib/beamer-contrib/themes/novabeamer-theme.zip; licence: LPPL 1.3c, LICENSE:1)
- Kind: presentation
- Lib: v4
- Engine: pdfLaTeX-compatible
- Look carried by: class (the CTAN-published beamer theme `beamerthemenovabeamer.sty` carries the look and is loaded unchanged; the sample's own preamble adds only `booktabs` and `fontawesome5`; the document class is `beamer`)
- Class origin: ctan
- Main file: examples/novabeamer-example.tex (other samples: doc/novabeamer-doc.tex, an `article` manual that only describes the theme)
- Read: main yes, zip-local classes and styles all (one style file, beamerthemenovabeamer.sty, 138 lines; there is no `.cls`)

## Verdict
The sample is a `beamer` deck that loads one theme style, and that theme is a CTAN package ("NovaBeamer-Theme" v1.1, LPPL 1.3c; ctan.org/pkg/novabeamer-theme, linked at README:55), so the theme is published (W1) and is the `slide.beamer-theme` way with the theme name as the parameter. Every body construct of the sample (frames, blocks, columns, table, theorem, figure, citation, bibliography) maps to a lib way or to `class.beamer` native vocabulary. To be safe the theme's own code was also decomposed: all of it reduces to lib ways, and its one TikZ drawing (the red frame-title band) reduces to `box.tcolorbox` (weakest reduction, see Bespoke code). Nothing needs a tool outside TeX and no new way is needed.

## Blockers
none

## Class setting
- Class: `class.beamer` options: `aspectratio=169`, `xcolor=dvipsnames` (examples/novabeamer-example.tex:5)
- Class-native vocabulary used: `frame` (with `[fragile]`, example:144), `\frametitle`, `\titlepage`, `\tableofcontents`, `\title` `\subtitle` `\author` `\institute` `\date`, `\pause`, `\alert`, `block` `alertblock` `examples`, `theorem`, `columns` with `\column{width}`. Theme side (the sty): `\setbeamercolor`, `\setbeamertemplate`, `\setbeamersize`, `\usebeamercolor`, `\usebeamerfont`, `beamercolorbox`, `\AtBeginSection`, the `\insert...` fields.

## Component map
Paths: `sty` = beamerthemenovabeamer.sty, `example` = examples/novabeamer-example.tex.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example:5 | `class.beamer` | aspectratio=169, xcolor=dvipsnames |
| theme load | example:7; README:36; sty:5 | `slide.beamer-theme` | theme=novabeamer (file `beamerthemenovabeamer.sty`; the sample writes `\usepackage{novabeamer}`, README gives `\usetheme{novabeamer}`, see Content-opaque note) |
| colours | sty:11-12 | `color.xcolor` | `\definecolor{sithred}{RGB}{159,18,18}`; black redefined RGB 0,0,0 |
| title, author, institute, date colours | sty:15-18, 122-123 | `slide.beamer-template` | `\setbeamercolor`: title fg=white bg=sithred; author, institute, date fg=black bg empty; author and date in head/foot fg=black |
| title data | example:16-22 | `front.class-native` | `\title` `\subtitle` `\author` `\institute` `\date{\today}` |
| title page | sty:31-67; example:30-32 | `slide.beamer-template`, `font.size-commands`, `sp.manual-space`, `sp.ragged`, `mark.kernel` | free box code in `\setbeamertemplate{title page}`: beamercolorbox[sep=12pt,center,shadow=true,rounded=true,wd=1\textwidth]{title}; `\bfseries`; author `\LARGE`, institute `\Huge`; `\vspace{5em}`, `\vskip` 1em/0.5em, `\vfill`; `\centering` |
| frame title band | sty:71-84; example:35 | `slide.beamer-template`, `box.tcolorbox`, `sp.manual-space` | beamercolorbox[wd=\paperwidth,ht=1cm,dp=0cm,center]{frametitle}, `\vspace{0.5cm}`; band = sithred, 5pt arc, paper wide, 2.2cm high, white centred text 3mm below band centre (see Bespoke code) |
| footline | sty:100-119 | `slide.beamer-template`, `sp.rule`, `sp.manual-space`, `sp.lengths` | rule 0.4pt over `\dimexpr\fullpagewidth-\titlehmargin*2`; beamercolorbox[sep=\titlevmargin,wd=...]{footline}; short author, short title, short date, page number separated by `\hfill`; hidden when `\value{framenumber}=0` (sty:101) |
| frame numbering | sty:124 | `num.counters` | `\setcounter{framenumber}{-1}` |
| navigation symbols | sty:22 | `slide.beamer-template` | `navigation symbols` set to empty |
| text margins | sty:89-97 | `slide.beamer-template`, `sp.lengths` | `\setbeamersize{text margin left=10mm,text margin right=10mm}`; `\newlength` `\setlength` helpers 5mm, 1mm, `\dimexpr\textwidth+2\textmargin` |
| list bullets | sty:23, 137-138 | `slide.beamer-template`, `mark.kernel`, `math.amssymb` | itemize item=[triangle]; subitem `\normalfont\textbullet`; subsubitem `\normalfont\(\square\)` (`\square` needs amssymb or latexsym, not loaded by the theme; beamer is understood to supply it, not checked here) |
| section divider frame | sty:126-135; example:40,76,100 | `slide.beamer-section-hook`, `head.kernel` | `\AtBeginSection[]` frame: `\vfill`, `\centering`, beamercolorbox[sep=8pt,center,shadow=true,rounded=true]{title}, `\insertsectionhead`; `\section{...}` in the body |
| contents slide | example:34-37 | `toc.kernel` | `\tableofcontents` in a frame |
| links | sty:26-27; example:47 | `xref.hyperref`, `mark.ulem` | `\href{url}{text}` wrapped in `\underline` (kernel underline, same effect type as ulem) |
| icons | example:9, 47 | `font.icons` | `fontawesome5`, `\faGithub` |
| blocks and highlight | example:55-69 | `class.beamer` (native vocabulary) | `block`, `alertblock` with title; `examples` (beamer's theorem-like green block); `\alert{}`; no block template set by the theme |
| theorem | example:123-129 | `thm.class-native` | `theorem` with optional title (beamer's predefined environment) |
| display and inline maths | example:63, 68, 124-128 | `math.kernel` | `\[ \]`, `\( \)`, `\frac`, `\dots`, `\quad\Longrightarrow` |
| columns | example:80-96 | `class.beamer` (native vocabulary) | `columns[c]`, `\column{.45\textwidth}` twice |
| list and overlays | example:84-90 | `list.kernel`, `slide.beamer-mode` | `enumerate`, `\pause` |
| table | example:105-116 | `tbl.tabular`, `tbl.booktabs`, `cap.kernel`, `mark.kernel` | `tabular{c c c}`, `\toprule` `\midrule` `\bottomrule`, `\caption`, `\textbf` header |
| figure | example:137-139 | `fig.graphicx` | `figure`, `\includegraphics[width=0.6\linewidth]` |
| inline code | example:144-146 | `code.verbatim` | `\verb|...|`, frame option `fragile` |
| citation and bibliography | example:148, 155-158 | `bib.bibtex-bst` | `\cite`, `\nocite{*}`, `\bibliography{examples/novabeamer-ref}`, `\bibliographystyle{apalike}`; `\footnotesize` (`font.size-commands`) |
| closing slide | example:163-167 | `sp.ragged`, `sp.manual-space`, `font.size-commands`, `mark.kernel` | `\centering`, `\vspace*{\fill}`, `\fontsize{50}{60}`, `\centerline{\textbf{...}}` |

## Bespoke code
None of it is zip-local: it all sits in the CTAN theme file. It is listed anyway so the result can be re-read if the theme's internals are counted (scope `class`).

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\textmargin` `\titlehmargin` `\titlevmargin` `\fullpagewidth` | sty:89-97 | yes | `sp.lengths`: `\newlength` + `\setlength` (10mm, 5mm, 1mm, a `\dimexpr`), or inline expansion into the footline |
| `\href` wrapped in `\underline` | sty:26-27 | yes | alias with a wrapper: emit `\underline{\href{url}{text}}` per link node (`xref.hyperref`, `mark.ulem`) |
| `\ifx\insertsubtitle\@empty` guard | sty:40 | yes | the emitter knows whether a subtitle exists and emits the subtitle line or not; or keeps the idiom as free box code in `slide.beamer-template` |
| `\ifnum\value{framenumber}=0` guard and `\setcounter{framenumber}{-1}` | sty:101, 124 | yes | a kernel counter test on beamer's own counter inside footline box code, plus `num.counters`; no counter of its own is created |
| Title page template | sty:31-67 | yes | one `slide.beamer-template` call; body is beamer boxes, font and colour inserts, kernel glue |
| Section divider frame | sty:126-135 | yes | `slide.beamer-section-hook`; the body is declarative beamer commands only (box with keys, `\insertsectionhead`) |
| TikZ band behind every frame title (`ART` if it counted) | sty:75-82 | yes, weakest reduction | `art.tikz` drawing the template's identity: `\fill[sithred, rounded corners=5pt] (0,0) rectangle (\paperwidth,-2.2)` plus a white centred node at `yshift=-1.4cm`. Reduce to `box.tcolorbox`: colback=colframe=sithred, boxrule=0pt, arc=5pt, width=\paperwidth, height=2.2cm, halign=center, valign=center, coltext=white, top=6mm, bottom=0pt (asymmetric margins give the 3mm drop of the text). Not compiled, so the exact text position is not shown to match; the band is a coloured box, the example the rubric names as reducible |

## Content-opaque
none (the figure is the shipped image examples/novabeamer-example-image.png.png, example:138, which is content).
Notes, not blockers: (1) `\usepackage{tikz}` (sty:7) is published and needs no outside tool; `\usepackage{comment}` (sty:8) is loaded but no comment environment appears anywhere in the zip (grep), so it has no printed effect. (2) The sample says `\usepackage{novabeamer}` (example:7) and the doc says `novabeamer.sty` (doc/novabeamer-doc.tex:23), but the zip ships `beamerthemenovabeamer.sty`; as written the load would not find a file, `\usetheme{novabeamer}` (README:36) is the matching call. (3) The doc says "Unlicense" (doc/novabeamer-doc.tex:61) while LICENSE:1 and README:49 say LPPL 1.3c; LPPL is used here. (4) The bundled PDFs were not read.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
