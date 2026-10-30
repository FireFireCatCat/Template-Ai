yes

# 0802-fancymag: fancymag (magazine package, "Particle Style")

- Unverified: read from the source, not compiled.
- Source: Source/0802-fancymag/ (origin: https://mirrors.ctan.org/macros/luatex/latex/fancymag.zip; licence: LPPL 1.3c for the package, SIL OFL 1.1 for the bundled fonts)
- Kind: newsletter
- Lib: v6
- Engine: needs LuaLaTeX (fontspec with local TTF files via `Path=fonts/` and `\babelfont`, fancymag.sty:26-29; README.md:43-45 says it will not work with pdflatex or xelatex; ctan.org/pkg/fancymag says "must be compiled with LuaLaTeX")
- Look carried by: zip-local (fancymag.sty, the style file shipped in the zip, defines every page design; it is not a class, and it is the published CTAN package `fancymag`; the sample adds content, a few preamble packages and cover-image overlays)
- Class origin: ctan
- Main file: fancymag-doc.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
`yes`, resting on one classification stated openly. `fancymag.sty` is the CTAN package `fancymag` v1.0 (ctan.org/pkg/fancymag read: Soumik Ghosh and Ashadul Halder, LPPL 1.3c and OFL, in TeX Live and MiKTeX), so it is published (W1). It is proposed as one whole-document-template way, `NEW:mag.fancymag`; the lib's v3 and v6 log folds house-style and whole-document packages into class-like ways in the same manner. Everything the sample adds on its own (preamble packages, cover images, header settings, accent bar, boxes, table) reduces to lib ways, and the sample defines no macro (no `\newcommand` or `\def` in fancymag-doc.tex).
The internals of the package are hand-placed TikZ page art and `\ifodd\value{page}` layouts (see Bespoke code). They are not copied zip-local code, they are the way's own code. If the consolidator holds that a package with no options fails W2 or W3, this zip becomes `no` with `ART/class` and `BESPOKE/class` (lines in Bespoke code), and no other blocker.

## Blockers
none (counted under the verdict above). Re-reading aid only, not counted: `ART/class` hexagon portrait frames, gradient bands, hatch patterns, blur shadows (fancymag.sty:164-182, 219-291, 355-416, 554-629, 683-749); `BESPOKE/class` page-parity environments (fancymag.sty:294-347, 418-475, 632-667, 751-792).

## Class setting
- Class: `class.article` options: `10pt`, `twoside` (fancymag-doc.tex:10). The sample never calls `\maketitle`, `abstract`, `\bibliography` or a theorem command.
- Class-native vocabulary used: `\section*` (fancymag-doc.tex:112), `tabular` with `\hline` (:117-125), `verbatim` (:138-149), `flushright` (:169-172), `\newpage`, `\cleardoublepage`, `\setcounter{page}`.
- Look-carrying package vocabulary used (`NEW:mag.fancymag`, defined in fancymag.sty): `fistpg` environment (:542-552), `\bgchange{img}` (:117-125), `\titlepg{title}` (:127-150), `\msg` with 8 arguments (:418-475), `\albumphoto{t}{y}{img}` (:161-186), `\interview` with 9 arguments (:632-667), `particle1` with 9 arguments (:751-792), `particle2` with 6 arguments (:294-347), `\photograph` with 7 arguments incl. `portrait|landscape` and `left|right` (:477-540), font switches `\customfontone` to `\customfontfour` and `\headrf` (:66-70), colours `accent` `accentlight` `grc` `mt` `ttl` `ttl1` (:105-110). Unused in the sample: `photoenv` (:152-159), `alumdetail` (:669-681), `\heading` (:349-353), `\fakebold` (:78).
- Assumptions an emitter must keep: `particle1` calls `tcolorbox` (fancymag.sty:784) which the package does not load, the sample loads it at fancymag-doc.tex:15; the package hard-wires `img/fancymag-msg_bg.jpg` and `img/fancymag-blank.png` (fancymag.sty:135, 195) and the 7 fonts in `fonts/`, all shipped in the zip.

## Component map
Sample level (fancymag-doc.tex):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | fancymag-doc.tex:10 | `class.article` | 10pt, twoside |
| paper and sides | fancymag-doc.tex:10 | `page.class-options` | 10pt, twoside (no paper option) |
| look-carrying package | fancymag-doc.tex:13; fancymag.sty:24 | `NEW:mag.fancymag` | `\usepackage{fancymag}`, no options |
| colour | fancymag-doc.tex:11, 20 | `color.xcolor` | `\definecolor{accent}{HTML}{0080EE}` (same value as fancymag.sty:105) |
| filler text | fancymag-doc.tex:12, 49 | `draft.todo` | `\lipsum[1-2]` |
| links | fancymag-doc.tex:14 | `meta.hyperref` | colorlinks=true, linkcolor=blue, urlcolor=cyan, citecolor=red |
| boxes | fancymag-doc.tex:15, 48-50, 115-127 | `box.tcolorbox` | `most`; colback=blue!20!white or blue!5!white, width=\textwidth, opacityfill=0.2 or 0.1 |
| columns, lists, floats loaded only | fancymag-doc.tex:16-18 | `cols.multicol`, `list.enumitem`, `fig.float` | loaded, no call in the body (multicol is used inside the package, fancymag.sty:788) |
| table | fancymag-doc.tex:19, 117-125 | `tbl.tabular` | `array`; `{l m{10cm}}`, `\hline`, `\\` |
| line breaking | fancymag-doc.tex:22 | `sp.hyphenat` | `\sloppy` |
| full-page cover and page images | fancymag-doc.tex:26-30, 37-40, 57-60, 256-260 | `bg.eso-pic` | `tikzpicture[remember picture, overlay]` node at `current page.south west` holding `\includegraphics[width=\paperwidth,height=\paperheight]{img/...}`; reduces to `\AddToShipoutPictureBG*{\AtPageLowerLeft{\includegraphics[...]}}` as `\bgchange` itself does (fancymag.sty:117-125); the image is an asset |
| cover page wrapper | fancymag-doc.tex:25-32, 35-52, 55-72, 255-262 | `NEW:mag.fancymag` | `fistpg` environment (clears header and footer, `\onecolumn`, `\clearpage`) |
| background change | fancymag-doc.tex:75, 81 | `NEW:mag.fancymag` | `\bgchange{img/fancymag-bg_all.jpg}` (the `{` at :75 has no matching `}` in the file) |
| cover text blocks | fancymag-doc.tex:41-47, 61-71 | `box.minipage`, `sp.ragged`, `font.size-commands`, `color.xcolor`, `sp.manual-space` | `minipage[l][\textheight]{0.65\textwidth}`; `center`; `\fontsize{20}{20}`, 13, 60, 20; `\textcolor{cyan}`, `white`; `\vspace{0.5cm}`, `\vskip 3cm` |
| display faces | fancymag-doc.tex:43-44, 66, 68, 120-124 | `NEW:mag.fancymag` | `\customfontone` Audiowide, `\customfonttwo` Imperial Script, `\customfontthree` Rationale, `\customfontfour` Orbitron, `\headrf` Oleo Script (fancymag.sty:66-70) |
| drop capital | fancymag-doc.tex:49, 86, 97, 181 | `sp.lettrine` | `\lettrine{L}{}`; hook colour accent, `\Huge\bfseries`, DefaultLines 3 (fancymag.sty:111-112) |
| logo image | fancymag-doc.tex:64 | `fig.graphicx` | `\includegraphics[height=3.5cm]` |
| inline marks | fancymag-doc.tex:49, 106, 118, 131 | `mark.kernel` | `\textbf`, `\textsf`, `\texttt`, `\textit` |
| page numbering | fancymag-doc.tex:82 | `pgnum.pagenumbering` | `\setcounter{page}{1}` |
| page breaks | fancymag-doc.tex:31, 76, 79, 100, 129, 254, 261 | `pg.break` | `\newpage`, `\cleardoublepage`, `\clearpage` |
| message page | fancymag-doc.tex:85, 96 | `NEW:mag.fancymag` | `\msg{name}{designation}{text}{affiliation}{photo}{signature}{3.5cm}{body}` |
| running head set in the body | fancymag-doc.tex:101-104, 239-243 | `hf.fancyhdr` | `\fancyhead[LO,RE,RO,LE]` with `\textcolor{accent}{\large\textbf{...}}`, `\thepage`; `\fancyhf{}` |
| hand-set heading line | fancymag-doc.tex:106, 130 | `font.size-commands`, `mark.kernel`, `color.xcolor` | `\fontsize{15}{15}\selectfont`, `\textbf`, `\textsf`, `\textcolor{accent}` |
| accent bar | fancymag-doc.tex:107-109 | `sp.rule`, `color.xcolor` | `\draw[fill={rgb,1:red,0;green,0;blue,0.7}] (0,0) rectangle (5cm,0.15cm)` is a filled bar, reduces to `\rule{5cm}{0.15cm}` in that colour; the same bar is inside the package at fancymag.sty:446-448 |
| spacing | fancymag-doc.tex:110, 45 | `sp.manual-space` | `\vskip 0.4cm`, `\vspace{0.5cm}` |
| album photo | fancymag-doc.tex:111 | `NEW:mag.fancymag` | `\albumphoto{title}{year}{img}` |
| section heading | fancymag-doc.tex:112 | `head.kernel` | `\section*{...}` |
| verbatim listing | fancymag-doc.tex:138-149 | `code.verbatim` | `verbatim` |
| section-divider page | fancymag-doc.tex:153, 177, 199, 237 | `NEW:mag.fancymag` | `\titlepg{title}` |
| interview page | fancymag-doc.tex:155-173 | `NEW:mag.fancymag` | `\interview{9 args}`; `flushright` inside (`sp.ragged`) |
| profile article, two columns | fancymag-doc.tex:179-196 | `NEW:mag.fancymag` | `particle1{9 args}` (abstract box, `multicols{2}` body) |
| article with side background | fancymag-doc.tex:201-233 | `NEW:mag.fancymag` | `particle2{6 args}` (`\twocolumn`, `\balance`) |
| portrait/landscape photo pages | fancymag-doc.tex:245-251 | `NEW:mag.fancymag` | `\photograph{7 args}` |
| hand-set bullets | fancymag-doc.tex:131-134, 159-166, 184-190, 215-225 | `list.kernel` | written as `\bullet` or `$\bullet$` plus `\\`; an emitter writes `itemize`; `\bullet` outside maths is a text-mode misuse, not evaluated |

Inside fancymag.sty (carried by `NEW:mag.fancymag`; read to show what the way contains and which parts have a lib home):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| language, fonts | fancymag.sty:25-29, 35, 66-70 | `lang.babel`, `font.fontspec` | no language option; `\babelfont{tt}[Path=fonts/]{FiraMono-Regular.ttf}`, `\babelfont{sf}[Path=fonts/]{Montserrat-Bold.ttf}`; five `\newfontfamily` faces |
| maths, display and size packages | fancymag.sty:30-32, 39, 61 | `math.amsmath`, `math.amssymb`, `font.display`, `font.exscale` | `amsfonts` `amsmath` `amssymb`; `calligra` (never called); `fix-cm` |
| geometry | fancymag.sty:83-87, 444, 457, 474, 659, 662, 666, 778, 781, 791 | `page.geometry` | `includehead, left=2.2cm, right=2.2cm, top=1.5cm, bottom=2cm, bindingoffset=1.5cm`; `\newgeometry{left=1.2in,right=2.5in,top=1.5in,bottom=1in}` or `right=0.7in`, `\restoregeometry`; `\headheight` 14.16103pt |
| header and footer | fancymag.sty:90-99, 114-115 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\headrulewidth` 1.5pt, page style `firstpage` with accent page number in `\headrf` 15pt; foot `\fontsize{14}{14}` in `ttl` |
| spacing | fancymag.sty:101-104 | `sp.lengths`, `sp.linespread` | `\parindent` 0pt, `\parskip` 0pt, `\columnsep` 18pt; `\baselinestretch` 1.1 |
| colours | fancymag.sty:105-110 | `color.xcolor` | accent 0080EE, accentlight 77eeff, grc 999999, mt 007777, ttl 0077aa, ttl1 005599 |
| page overlays | fancymag.sty:46, 63, 117-125, 189-191, 427-442 | `bg.eso-pic` | `\AddToShipoutPictureBG*`, `\AddEverypageHook`, `\AddThispageHook` |
| text effects | fancymag.sty:57, 59, 78 | `mark.contour` | `\textpdfrender{TextRenderingMode=FillStroke,LineWidth=0.5pt}` as `\fakebold`; `\shadowtext` with `\shadowoffset{0pt}`, `\shadowrgb{0,0,0}` (:131-132) |
| columns, floats, boxes | fancymag.sty:45, 52, 296, 450-470, 753, 784-790 | `fig.wrapfig`, `cols.balance`, `cols.twocolumn-cmd`, `cols.multicol`, `box.tcolorbox` | `wrapfigure[24]{r}` and `[38]{l}` of `0.3\textwidth`; `\balance`; `\twocolumn`; `multicols{2}`; abstract box `colback=blue!5!white, opacityfill=0.1` |
| loaded, no call found | fancymag.sty:44, 48, 49, 54, 62 | `fig.adjustbox`, `head.titlesec`, `cap.caption`, `pg.afterpage`, `pg.textpos` | no option, no command used |

Components the sample does not use: abstract, `\maketitle`, contents list, theorems, math display, bibliography, index, footnotes, captions and figure floats. Nothing to map.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| sample-level macros | fancymag-doc.tex | none exist | no `\newcommand`, `\def`, counter or conditional in the sample |
| accent bar drawn in TikZ | fancymag-doc.tex:107-109 | yes | `sp.rule` + `color.xcolor`, see map |
| cover images through a TikZ overlay | fancymag-doc.tex:26-30, 37-40, 57-60, 256-260 | yes | `bg.eso-pic`, see map |
| hexagon portrait frames, gradient bands, hatch pattern, blur shadows (`art.tikz`) | fancymag.sty:164-182, 219-291, 355-416, 554-629, 683-749, 477-540 | not to lib ways; not zip-local | published package code, carried by `NEW:mag.fancymag`; would be `ART/class` if the way is refused |
| page-parity layouts: `\ifodd\value{page}` with `\newgeometry`, hard-coded `\vspace{3.09in}` or `3.22in`, `wrapfigure[24]` or `[38]`, empty TikZ boxes in `figure[b]` to reserve column space, `\columnbreak` | fancymag.sty:294-347, 418-475, 632-667, 751-792 | not to lib ways; not zip-local | same as above; would be `BESPOKE/class` if the way is refused |
| `\photograph` branching on `\IfStrEq` of two strings (`xstring`) | fancymag.sty:477-540 | not to lib ways; not zip-local | same as above (the four layouts are fixed in the package) |
| `\titlepg`, `fistpg`, `\bgchange`, `photoenv`, `alumdetail`, `\heading`, `\fakebold` | fancymag.sty:127-150, 542-552, 117-125, 152-159, 669-681, 349-353, 78 | yes in effect (page style, `\onecolumn`, `\clearpage`, overlay, one-line aliases) | `hf.fancyhdr`, `cols.twocolumn-cmd`, `bg.eso-pic`, `pg.break`, `mark.contour`; also inside the way |
| fixed strings in the package | fancymag.sty:574, 613 ("In Conversation With..."), 673-676 ("Alumni"), 785 ("Abstract:") | n/a | strings fixed in the way, as the German names are in `cal.kalender` |

## Content-opaque
none. The images in `img/` (full-page backgrounds, logo, portraits, signatures) are assets the zip ships: fancymag-doc.tex:28, 38, 58, 64, 85, 96, 155, 179, 193, 201, 229, 245, 258.

## Lib changes
- New ways proposed: `NEW:mag.fancymag` `fancymag` (CTAN v1.0, LPPL 1.3c, in TeX Live and MiKTeX, ctan.org/pkg/fancymag read), engine `xe/lua` (LuaLaTeX only); `\usepackage{fancymag}` after `\documentclass{article}` and body `fistpg`, `\titlepg`, `\msg`, `\albumphoto`, `\interview`, `particle1`, `particle2`, `\photograph`, `\bgchange`; a magazine page set (message, interview, profile, article, photo and divider pages) with fixed look. W1: released on CTAN with public documentation (fancymag-doc.tex). W2: no package option exists; behaviour is chosen by arguments that are strings, image paths, one length (`\msg` argument 7) and closed keywords (`portrait` or `landscape`, `left` or `right`); the look itself is fixed in the package, as for `cal.kalender` and `persona.user-persona`. W3: serves any magazine content of that page type, not one document; weak points are the hard-wired strings and the bundled images. W4: one preamble line plus body wrappers around a node's content. The consolidator may fold it into a class-like way `class.fancymag` (as the v3 and v6 log does for whole-document packages), keeping the vocabulary listed under Class setting.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
