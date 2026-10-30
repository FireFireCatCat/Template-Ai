no

# 0128-bookcover: bookcover (book covers and dust jackets)

- Unverified: read from the source, not compiled.
- Source: Source/0128-bookcover/ (origin: https://mirrors.ctan.org/macros/latex/contrib/bookcover.zip; licence: LPPL 1.2, README:5-13)
- Kind: misc
- Lib: v2
- Engine: pdfLaTeX-compatible (README:17-18 builds with pdflatex; bookcover-example1.tex:15 comment says contour works with pdflatex; no fontspec, no Lua; needs LaTeX 2020/10/01 or later for hooks, bookcover.dtx:24)
- Look carried by: mixed (the published class `bookcover` carries the print sheet: size from options, crop marks, named parts, the layer system; the samples' body component calls and one preamble `\newbookcovercomponenttype` carry the cover design, including raw TikZ shapes)
- Class origin: ctan
- Main file: bookcover-example1.tex (other samples: bookcover-example2.tex; the listings inside bookcover.dtx:373-1221 are documentation examples, not separate files)
- Read: main yes, zip-local classes and styles all (no .cls or .sty ships in the zip; the class source is bookcover.dtx, read in full: docs 1-1224, code 1225-2643)

## Verdict
no. The class is the published CTAN `bookcover` (ctan.org/pkg/bookcover read: v4.1, LPPL 1.2, in TeX Live), so the class, its parts and its option-driven layers (`color`, `picture`, `normal`, `center`) are one way with parameters, and every other construct the samples use maps to lib ways (one new inline way, `contour`). What blocks `yes` is template-defining artwork written as raw TikZ in the body: the two blue triangles of the second sample (bookcover-example2.tex:22-23, 26-27), which no lib way and no class-native declarative component can express, and which are the cover's design rather than figure content. The class's `tikz` and `tikz clip` component types are the general hook for such drawings (bookcover.dtx:1734-1757; documented examples draw circles and thick lines, bookcover.dtx:711-714, 1187-1194). The two semi-transparent rectangles of the first sample would reduce to `color` components with margins and `opacity`, so they would not block alone.

## Blockers
- `ART/body` blue triangles drawn as raw TikZ polygons on the back and front cover through the class's `tikz` component type: `\fill[blue!50](7/48,0)--(17.5,24.5)--(17.5,0)--cycle;` and `\fill[blue!50](0,0)--(0,24.5)--(833/48,0)--cycle;` (bookcover-example2.tex:22-23, 26-27)

## Class setting
- Class: `class.bookcover` options: `coverwidth=15cm`, `coverheight=20cm`, `spinewidth=25mm`, `flapwidth=6cm`, `wrapwidth=5mm` (bookcover-example1.tex:1-7); `spinewidth=15mm`, `markcolor=black` (bookcover-example2.tex:1-4). Defaults from bookcover.dtx:1229-1256: `cover=default` (170mm x 240mm, dtx:1347), `bleedwidth=5mm`, `marklength=10mm`, `markthick=.4pt`, `markcolor=red`, `pagecolor=white`, `hingewidth=0mm`, `hardcover=false`, `xmarks=false`, `trimmed=false`, `10pt`/`11pt`/`12pt` passed to article. The class is `\LoadClass{article}` (bookcover.dtx:1260) and requires `kvoptions` (1229), `geometry` `calc` `tikz` (1261), `fgruler` (1262; ctan.org/pkg/fgruler read: published, TeX Live, pure LaTeX).
- Class-native vocabulary used: environment `bookcover` (example1:22,90; example2:15,53,59,77); environment `bookcoverelement{type}{part}[l,b,r,t]` (example1:25-88); command `\bookcovercomponent{type}{part}[l,b,r,t]{content}` (example2:18-75); `\newbookcovercomponenttype` (example1:9-13); component types `color` `picture` `tikz` `normal` `center`; parts `above front` `bg whole` `bg whole without flaps` `bg back and wrap` `bg front and wrap` `front` `spine` `back` `front flap` `back flap` `bg back` `bg front` `bg spine` `above inside back` `inside back`; lengths `\partheight`.
- Documented, not used by either sample: options `hardcover`/`foldingmargin` `hingewidth` `bleedwidth` `marklength` `markthick` `xmarks` `trimmed` `trimmingcolor` `showonlypart` `showonlycovernum` `cover=<size name>` (bookcover.dtx:208-299); `\setbookcover` `\bookcovertrimmedpart` (423-442); `bookcoverdescription` with `\bookcoverdescgeometry` `\showbookcoverparameters` (406-421, 1454-1464); component type `ruler` (762-820); part and type definers `\newbookcoverpart` `\letnamebookcoverpart` `\newbookcovercomponenttype` and relatives (545-642, 822-870).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | bookcover-example1.tex:1-7; bookcover-example2.tex:1-4; bookcover.dtx:25,1260 | `class.bookcover` | options as under Class setting |
| sheet size | bookcover-example1.tex:2-6; bookcover.dtx:1413-1416 | `page.class-options` | paper width = 2*marklength + 2*bleedwidth + 2*coverwidth + 2*flapwidth + 2*wrapwidth + 2*hingewidth + spinewidth, height = 2*marklength + 2*bleedwidth + coverheight; the class calls `geometry` with `margin=0pt` itself; the sample sets lengths only through class options |
| crop and fold marks | bookcover-example2.tex:3; bookcover.dtx:1244,1476-1520,1589-1593 | `class.bookcover` | class-drawn marks, chosen by options only: `markcolor=black` (example2), defaults `markthick=.4pt` `marklength=10mm`; no component way applies, the options are parameters of the class way |
| page style | bookcover.dtx:1266-1267 | `hf.pagestyle-kernel` | `\pagestyle{empty}`, `\ps@plain` emptied, set by the class |
| page colour | bookcover.dtx:1245,1581 | `color.pagecolor` | class option `pagecolor` (default white), applied by `\pagecolor` at each `bookcover` start; neither sample sets it |
| one sheet per cover | bookcover-example2.tex:15,53,59,77; bookcover.dtx:1578-1596 | `front.class-native` | `bookcover` environment = `\newpage` plus a full-sheet `picture`; example2 uses two (outside, inside), example1 one |
| layered components | bookcover-example1.tex:25-88; bookcover-example2.tex:18-75; bookcover.dtx:1638-1657 | `front.class-native` | `\bookcovercomponent{type}{part}[l,b,r,t]{content}` or `bookcoverelement`; first call is the bottom layer; margins used: `[,,,5cm]`, `[2cm,2cm,2cm,2cm]`, `[1cm,1cm,1cm,2cm]`, `[1cm,2cm,1cm,2cm]`, `[22mm,20mm,22mm,40mm]`, `[22mm,10mm,22mm,30mm]` (used twice) |
| colour fill layers | bookcover-example1.tex:30-32; bookcover-example2.tex:30,66; bookcover.dtx:1728-1729 | `front.class-native` | type `color`, content = fill options: `black` on `bg whole`; `blue!50` on `bg spine` and `bg whole` |
| stretched background image | bookcover-example1.tex:35-37; bookcover.dtx:1731-1732 | `fig.class-native` | type `picture` on `bg whole without flaps`, `./figures/bookcover-bg.jpg` (2560x1600, shipped), resized to the part, aspect ratio not kept |
| semi-transparent bands | bookcover-example1.tex:40-44,47-51 | `art.tikz` | type `tikz`: `\fill[opacity=0.3,black!50]` with `rectangle` paths, 25mm and 5cm wide full-height strips; reducible to two `color` components with margins and `opacity=0.3,black!50` (not a blocker alone) |
| blue triangles (ART) | bookcover-example2.tex:22-23,26-27; bookcover.dtx:1734-1753 | `art.tikz` | type `tikz` on `bg back` and `bg front`: `\fill[blue!50]` polygon paths in cm; **ART**, see Blockers |
| remark above the cover | bookcover-example1.tex:25-27; bookcover-example2.tex:18-19,62-63; bookcover.dtx:1761,2247-2253 | `front.class-native` | type `center` on part `above front` / `above inside back` (mark zone, outside the trim); text `\textcolor{blue}{...}`, `\textcolor{red}{\textsc{...}}` |
| cover text blocks | bookcover-example1.tex:59-65,74-76,79-88; bookcover-example2.tex:38-46,49-51,69-75; bookcover.dtx:1759 | `front.class-native` | type `normal` on `front`, `back`, `front flap`, `back flap`, `inside back` with the margin lists above; content is ordinary LaTeX |
| spine title, centred | bookcover-example2.tex:33-35; bookcover.dtx:1761 | `front.class-native` | type `center` on `spine`; `\rotatebox[origin=c]{-90}{\large\bfseries ...}` |
| sample-defined component type | bookcover-example1.tex:9-13; bookcover.dtx:1695-1699 | `front.class-native` | `\newbookcovercomponenttype{center rotate}{\vfill \centering \rotatebox[origin=c]{-90}{#1} \vfill}`; body is a composition of `sp.manual-space`, `sp.ragged`, `fig.rotating` |
| spine title, rotated type | bookcover-example1.tex:68-71 | `front.class-native` | type `center rotate` on `spine`; `\color{yellow!60!black}\huge\sffamily\bfseries \contour{black}{...}` |
| rotation | bookcover-example1.tex:12; bookcover-example2.tex:34 | `fig.rotating` | `\rotatebox[origin=c]{-90}{...}` (graphicx) |
| scaling text to a height | bookcover-example1.tex:62-64 | `fig.graphicx` | `\resizebox{!}{5mm}{...}`, `\resizebox{!}{7mm}{...}` (graphicx command, same package family) |
| images on the cover | bookcover-example1.tex:55,82; bookcover-example2.tex:43 | `fig.graphicx` | `\includegraphics{./figures/bookcover-cards.pdf}`, `bookcover-dice.pdf`, `bookcover-pi.pdf`, no options, not in a float; the artwork is content |
| outlined title text | bookcover-example1.tex:15-16,62-64,70 | `mark.contour` | `\usepackage[outline]{contour}`, `\contourlength{1pt}`, body wrapper `\contour{black}{text}` |
| colour | bookcover-example1.tex:26,61,69,75,80,87; bookcover-example2.tex:19,70 | `color.xcolor` | `\textcolor{blue}`, `\color{yellow!60!black}`, `\color{white}`, `\textcolor{red}` (the class loads tikz, which loads xcolor) |
| font switches | bookcover-example1.tex:61,69; bookcover-example2.tex:19,34,40-41 | `mark.kernel` | `\sffamily` `\bfseries` `\textsc` |
| font sizes | bookcover-example1.tex:69; bookcover-example2.tex:34,40-41,45,50 | `font.size-commands` | `\huge`, `\large` |
| alignment | bookcover-example1.tex:60,82; bookcover-example2.tex:39,50,71; bookcover.dtx:1761 | `sp.ragged` | `\centering`, also inside the class's `center` type |
| spacing and fill | bookcover-example1.tex:62-64,81; bookcover-example2.tex:40,42,44,45,50,72,74 | `sp.manual-space` | `\\[26mm]` `\\[8mm]` `\\[13mm]` `\\[3mm]` `\\[5mm]`, `\vfill`, `\bigskip` |
| language | bookcover-example1.tex:17; bookcover-example2.tex:6 | `lang.babel` | `english` (example1), `latin` (example2) |
| microtypography | bookcover-example1.tex:18; bookcover-example2.tex:7 | `sp.microtype` | package with default options |
| description pages (documented only) | bookcover.dtx:406-415,1454-1464,916-942 | `page.geometry` | `\bookcoverdescgeometry{...}` feeds `\newgeometry`, default `margin=1in`; its example adds `front.maketitle` and `cols.multicol` content; neither sample uses it |
| package manual driver (not the template) | bookcover.dtx:28-29,30,31-39,40-42,49-95,115,146 | `class.ltxdoc` | `\documentclass{ltxdoc}` with `\OnlyDescription` and `\DocInput{./bookcover.dtx}` (`dtx.doc`); `page.geometry` `a4paper,margin=1in`; `lang.babel` `english`; `font.fontenc-t1` T1, `font.lmodern`; `code.listings` styles `examplelst` `commandlst`; `list.paralist`; `meta.hyperref` `colorlinks`; `pg.needspace`; title-page gradient overlay through `bg.eso-pic` with TikZ (`\AddToShipoutPictureBG*`, dtx:146), decoration of the manual only; outside the verdict |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newbookcovercomponenttype{center rotate}` | bookcover-example1.tex:9-13 | yes | a class-API call whose body is `\vfill` (`sp.manual-space`), `\centering` (`sp.ragged`), `\rotatebox[origin=c]{-90}{#1}` (`fig.rotating`); registered through the published class command (bookcover.dtx:1695-1699) |
| class internals (`\bookcover@posbox`, part definitions with `\ifdim` branches, `\bookcover@marks`, `\patchcmd` name loops, old-method `\oldsetbookcover@`) | bookcover.dtx:1468-1472,1476-1520,1806-2507,2511-2643 | not counted | published CTAN class, so `class.bookcover` is one way (rubric: Class setting); the code is the class, set only by options and component calls |
| manual-only macros and listings styles (`\bookcoversizename`, `\example`, `\BookCover`, `examplelst`, `commandlst`, `\commandinline`) | bookcover.dtx:44-110 | yes | `\colorlet` (`color.xcolor`), `\lstnewenvironment` (`code.listings`), `\newcommand` aliases; documentation only |

## Content-opaque
- images on the cover: bookcover-example1.tex:35-37 (bookcover-bg.jpg), 55 (bookcover-cards.pdf), 82 (bookcover-dice.pdf); bookcover-example2.tex:43 (bookcover-pi.pdf)
- dummy text from `kantlipsum` and `lipsum` (`\kant[1]`..`\kant[3]`, example1:75,80,87; `\lipsum[2]`, `\lipsum[1-4]`, `\lipsum[1]`, example2:46,51,75), loaded at example1:18 and example2:7; content, no template effect
- the cover wording itself (titles, "ANNALES MATHEMATICAE", author name)
- not content-opaque: the TikZ shapes (see Blockers and the table), because they are the cover's design

## Lib changes
- New ways proposed: `mark.contour` `contour` package (CTAN and TeX Live, ctan.org/pkg/contour read: v2.14, LPPL 1), pdfLaTeX; `\usepackage[outline]{contour}`, `\contourlength{len}`, wrapper `\contour{colour}{text}` prints a coloured outline around inline text. W1: on CTAN. W2: colour, length and package options only. W3: serves any text that must sit on a busy background, not one document. W4: preamble line plus a body wrapper around a node's text. Nearest lines are `mark.ulem` (underline, strike, highlight) and `font.display` (face selection); neither covers an outline, and a reviewer may prefer widening `mark.ulem` to inline text-decoration packages.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
