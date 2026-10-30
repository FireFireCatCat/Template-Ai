yes

# 0230-gridslides: gridslides (free-form slides with blocks on a 32x24 grid)

- Unverified: read from the source, not compiled.
- Source: Source/0230-gridslides/ (origin: https://mirrors.ctan.org/macros/latex/contrib/gridslides.zip, CTAN page https://ctan.org/pkg/gridslides lists it as version 0.1.1 of 2017-11-28; licence: GPL2 or LPPL1.3 at your option, README.md:83-85, gridslides.sty:7)
- Kind: presentation
- Lib: v2
- Engine: pdfLaTeX-compatible (no fontspec, no Lua; the author's driver calls `pdflatex`, compile.pl:32)
- Look carried by: mixed (the class `gridslides` carries the mechanism: 128x96 mm page, 4 mm grid, `\block` placement, slide steps; the sample's preamble carries the look: `style` environment, colour and the two border bands, example.tex:22-40)
- Class origin: ctan (gridslides.cls is a 2-line shim: `\LoadClass{article}` then `\RequirePackage{gridslides}`, gridslides.cls:9-10; all code is in gridslides.sty, which is the CTAN package itself, not a zip-local rewrite)
- Main file: example.tex (other samples: none; example.pdf and gridslides.pdf are prebuilt outputs, figures/*.pdf and figures/*.png are image content, none read as source)
- Read: main yes, zip-local classes and styles all (gridslides.cls 10 lines, gridslides.sty 235 lines; no .def/.cfg/.clo/.bbx/.cbx; also read README.md, Makefile and compile.pl as data)

## Verdict
Yes. The class is the published CTAN `gridslides`; the sample uses only its documented vocabulary (README.md:18-72) plus a preamble of `\newcommand` aliases, one `\definecolor`, a `style` environment that places class blocks, and published packages (`cmbright`, amsmath family, `enumerate`). The one piece of artwork that defines the template, the two border bands drawn with `\tikz\fill` (example.tex:23-26), is a solid rectangle and reduces to a coloured `\rule` of the same box size (`sp.rule`, `color.xcolor`), so it is not an ART blocker. Judgement calls for a stricter re-reading: (1) `class.gridslides` is accepted as one published class way, so its 235 lines of overlay and placement code are not counted as bespoke (as `class.beamer` is); (2) `compile.pl` and the `Makefile` are an optional per-slide speed driver and a documentation build, not a producer of the look, because the class itself loops `\clearpage` once per step (gridslides.sty:162-175) and counts slides itself (gridslides.sty:159-160,174), so they are noted but not EXTERNAL; (3) the border reduction to `\rule` is argued from the box model (a `\tikz` picture sits on the baseline with its bounding box, as a rule does), not compared by output.

## Blockers
none

## Class setting
- Class: `class.gridslides` options: none (example.tex:9). It loads kernel `article` with no options (gridslides.cls:9), so type size is article's 10pt default; paper size is overridden by geometry (gridslides.sty:20). Published on CTAN, so the way is the class itself; its source was read here.
- Class-native vocabulary used:
  - environments `slide{headline}` (example.tex:52,61,82; gridslides.sty:206), `rawslide` (example.tex:44; gridslides.sty:208), `style` (example.tex:34; gridslides.sty:207);
  - placement commands `\block(x,y,w){...}` (example.tex:24,25,37,47,53,72,77,89), `\txt(x,y){...}` (example.tex:36,38,39,46,48,49,64,66,83,101,104,106), `\fig(x,y,w){file}` (example.tex:62,63,70,75,86,87,100,103), `\eq(x,y){...}` (example.tex:67,71,84,107), each on a 32x24 grid of 4 mm cells (gridslides.sty:58, README.md:41);
  - step annotations `<2->` and `<n-m>` on commands (example.tex:66,67,89) and `\only<3>{...}` (example.tex:69,99); `\alt<..>{..}{..}` exists (gridslides.sty:111-125) but the sample does not use it;
  - metadata macros `\institute`, `\theauthor`, `\thetitle`, `\thedate`, `\theinstitute`, `\theheadline`, `\theslide` (example.tex:32,37-39,47-49; gridslides.sty:210-214, 190);
  - defined by the class and not used in the sample: `\bg{file}` (gridslides.sty:177-187), `\rgb{HEX}` (gridslides.sty:149), the debug switches for a grid overlay and block outlines, both off (gridslides.sty:33-45, 179-186).
  - Commands the class removes (gridslides.sty:216-235): `\section` family, `\chapter`, `\paragraph`, `\maketitle`, `\tableofcontents`, `\listoffigures`, `\listoftables`, `\footnote`, `\pagestyle`, the `figure` and `table` floats, `\bf` `\it` `\cal` `\tt`. So no headings, floats, footnotes or contents exist in this class.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example.tex:9; gridslides.cls:9-10 | `class.gridslides` | no options; base `article` |
| page size and margins | gridslides.sty:20 | `page.geometry` | margin=0mm, paperwidth=128mm, paperheight=96mm (4:3) |
| grid and block placement | gridslides.sty:47-67 | `class.gridslides` (native) | `\block(x,y,w)`: node `anchor=north west`, `inner sep=0pt`, `text width=w*4mm`, at (4mm*x, 4mm*y) from the page's north-west corner, inside a `tikzpicture[overlay]`; internal to the class, nothing drawn |
| slides and steps | gridslides.sty:79-127, 162-175, 192-208; example.tex:66,67,69,89,99 | `class.gridslides` (native) | one page per step through a `\clearpage` loop; `\only<a-b>`, `<n->` compare a step counter; `slide` counter is stepped once per slide (gridslides.sty:159-160,174) |
| blank page style | gridslides.sty:30 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (then `\pagestyle` is undefined, gridslides.sty:228) |
| paragraph spacing | gridslides.sty:165-166 | `sp.lengths` | `\parindent`=0pt, `\parskip`=0pt, set at the start of every slide |
| per-slide template (running content) | example.tex:34-40; gridslides.sty:189,207 | `hf.class-native` | `style` body is run on every `slide`: `\border`; `\txt(28,1.5){\logo}`; `\txt(1,22.8){\color{white}\theslide}`; `\txt(4,22.9){\color{white}\scriptsize\theauthor~$\cdot$~\thetitle}` (slide number and "author, title" strip in the bottom band) |
| slide headline | example.tex:37, 52, 61, 82; gridslides.sty:192-194 | `head.class-native` | argument of `slide{...}` is stored in `\theheadline`; printed by the style as `\block(1.5,2,26){\LARGE\theheadline}`; no `\section` exists |
| title slide | example.tex:29-32, 44-50 | `front.class-native`, `front.maketitle` | `\author{Author}`, `\title{Presentation Title}`, `\date{\today}` (kernel storage) and `\institute{Institute~$\cdot$~University}` (class); a `rawslide` places `\thetitle` `\LARGE` at `\block(2,5,28)`, `\theauthor~$\cdot$~\thedate` at `\txt(2,9.5)`, `\theinstitute` `\footnotesize` at `\txt(2,11.7)`, logo at `\txt(28,1.5)`; `\maketitle` is not used (undefined, gridslides.sty:225) |
| outline bookmarks and PDF title | gridslides.sty:24, 198, 201 | `meta.hyperref` | options `pdfusetitle`, `bookmarksopen`; `\pdfbookmark[0]{headline}` per slide, `\pdfbookmark[1]{Step n}` when a slide has more than one step |
| language | gridslides.sty:12 | `lang.babel` | `ngerman` (German hyphenation and names, so `\today` at example.tex:31,48 prints in German form; not checked by compiling) |
| input encoding | gridslides.sty:9 | `font.fontenc-t1` | `inputenc` option `utf8`; no `fontenc` loaded |
| text face | example.tex:11 | `font.helvet` | `cmbright` (CM Bright sans text and math family; the package is the parameter) |
| type sizes | example.tex:27,37,39,49,91 | `font.size-commands` | `\Large`, `\LARGE`, `\scriptsize`, `\footnotesize` |
| bold text | example.tex:27; gridslides.sty:151 | `mark.kernel` | `\textbf` (the class wraps it to accept `\textbf<n>{..}`, plain form unchanged); also `\textit`, `\emph`, `\underline` wrapped the same way (gridslides.sty:152-154) |
| colours | example.tex:22,27,38,39,72,77,90; gridslides.sty:149,156 | `color.xcolor` | `\definecolor{bordercolor}{HTML}{23373b}`; `\color{bordercolor}`, `\color{white}`, `red!90!black`, `blue!90!black`, `draw=red` (callout frame) |
| border bands (template identity) | example.tex:23-26 | `sp.rule`, `color.xcolor` | `\block(0,0,32){...}` top band 128mm x 2mm and `\block(0,22,32){...}` bottom band 128mm x 8mm, both fill `bordercolor`; reduction `\textcolor{bordercolor}{\rule{128mm}{2mm}}` and `\rule{128mm}{8mm}` (a `\tikz` picture on the baseline has the same width and height box); see Bespoke code |
| logo | example.tex:27,36,46 | `font.size-commands`, `mark.kernel`, `color.xcolor` | `\Large\textbf{\color{bordercolor}\TeX}` placed with `\txt(28,1.5)` |
| list | example.tex:53-58; gridslides.sty:22 | `list.enumerate-pkg` | `enumerate` package, label template `[1.]`, two items, inside `\block(1.5,5,29)` |
| figures | example.tex:62,63,70,75,86,87,100,103; gridslides.sty:69 | `fig.class-native` | `\fig(x,y,w){name}` is `\block(x,y,w){\includegraphics[width=\textwidth]{name}}`; widths 9 to 16 cells; no float, no caption (the `figure` environment is removed) |
| image lookup | gridslides.sty:31, 69 | `fig.graphicx` | `\graphicspath{{figures/}}`, `\includegraphics[width=\textwidth]`; the sty does not load `graphicx` by name, so it relies on a package loaded through `tikz` (pgf loads it; from knowledge of pgf, not read here) |
| displayed formulas | example.tex:67,71,76,84,107; gridslides.sty:71-75 | `math.amsmath` | `\eq(x,y){...}` is `\block(x,y,32){$\begin{aligned}...\end{aligned}$}`: inline-math `aligned`, unnumbered; uses `\left` `\right` `\sum` `\frac` `\boldsymbol` `\text` `\qquad` `\widehat` `\mathcal` `\phantom` |
| math symbols | example.tex:16 | `math.amssymb` | `\intercal`; `\dag` is kernel |
| annotation callouts over figures | example.tex:72-73, 77-78, 89-97 | `box.fancybox`, `color.xcolor` | sample writes `\tikz \node[...]{...}`; the same boxes are `\setlength{\fboxsep}{0.5mm}\colorbox{white}{\textcolor{red!90!black}{non-trivial}}` and `\fbox` with `\fboxsep`=1mm and a red frame colour around `\scriptsize` text and an `aligned` formula; see Bespoke code and Content-opaque |
| loaded by the class, not called by the sample: contents of math packages | gridslides.sty:10,11,13,16 | `math.amsmath`, `thm.amsthm`, `math.mathtools`, `math.physics`, `math.bm` | `amsmath`, `amsthm`, `amssymb`, `mathtools`, `braket`, `dsfont`; no `\newtheorem`, no bra-ket or `\mathds` anywhere in the sample (grep) |
| loaded by the class, not called by the sample: text packages | gridslides.sty:14,17,18 | `mark.siunitx`, `sp.microtype`, `sp.ragged` | `siunitx`, `microtype` (default options, active on the whole document), `ragged2e` (no `\RaggedRight` or `\Centering` in the sty or the sample, grep) |
| helper packages inside the class | gridslides.sty:15, 21, 23, 25 | none (class-internal) | `xspace` (used by the sample's aliases only), `xstring` (`\IfSubStr` etc. in `\alt`, gridslides.sty:112-124), `environ` (`\NewEnviron` for `slide`, `style`, `rawslide`, gridslides.sty:206-208), `\usetikzlibrary{calc}`; none sets a look |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `gridslides.cls` and `gridslides.sty` (placement, steps, `\alt`, `\only`, `style`, wrappers around `\textbf` `\textit` `\emph` `\underline` `\color` `\rgb`, removal of article commands) | gridslides.cls:9-10; gridslides.sty:9-235 | not bespoke: published CTAN package | one way, `class.gridslides`; the emitter writes `\documentclass{gridslides}` and the class's own commands, it does not copy the code |
| `\border` (two `\block`s with TikZ rectangles) | example.tex:23-26 | yes | `\block(0,0,32){\textcolor{bordercolor}{\rule{128mm}{2mm}}}` and `\block(0,22,32){\textcolor{bordercolor}{\rule{128mm}{8mm}}}`: `sp.rule` + `color.xcolor` in two class blocks; this is the template-defining artwork, not an ART blocker because a solid rectangle is a coloured rule |
| `\logo` | example.tex:27 | yes | alias for `\Large\textbf{\color{bordercolor}\TeX}` |
| math aliases `\hcterm` `\nodag` `\hc` `\trans` `\nohc` `\OpH` `\HH`, redefinition of `\vec` | example.tex:13-20 | yes | `\newcommand` aliases of `\text`, `\phantom`, `\dag`, `\intercal`, `\mathcal`, `\widehat`, `\boldsymbol` (`math.amsmath`, `math.amssymb`), with `\xspace` only managing the space after the macro; math content |
| `style` environment body | example.tex:34-40 | yes | a list of class `\block` and `\txt` calls and the `\border` alias, no conditionals or counters of its own |
| TikZ callout nodes (three) | example.tex:72-73, 77-78, 90-96 | yes | boxes with a frame or fill and coloured text: `box.fancybox` (`\colorbox`, `\fbox`, `\fboxsep`) with `color.xcolor`; sample content, annotations over figures |
| `compile.pl` and `Makefile` | compile.pl:25-79; Makefile:10-22 | not a template component | optional driver: builds a format with `mylatexformat` (compile.pl:60), compiles each slide with `pdflatex`/`biber` (compile.pl:32), joins with `pdfjoin` (compile.pl:72), watches the file with `inotifywait` (compile.pl:76); the `Makefile` runs it (Makefile:10-11) and builds `gridslides.pdf` from README with `pandoc` (Makefile:16-17), which is documentation. It only sets `\setcounter{slide}{N}` (compile.pl:25), which a single run does by itself; recorded as a risk, not a blocker |

## Content-opaque
- TikZ callout nodes over figures (example.tex:72-73, 77-78, 90-96): sample content, annotations; they also reduce to `box.fancybox`, so nothing here needs `art.tikz`.
- Included figures figures/*.pdf and figures/*.png (example.tex:62,63,70,75,86,87,100,103): image content held by `fig.class-native`; assets ship in the zip.
- The formulas at example.tex:67,71,76,84,107 and the slide text are content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Note for the consolidator: class vocabulary to record under `class.gridslides` is the "Class-native vocabulary used" list above; `class.gridslides` has no options.
