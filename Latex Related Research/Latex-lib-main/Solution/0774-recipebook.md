yes

# 0774-recipebook: RecipeBook (class for typesetting recipes, Brad Granger)

- Unverified: read from the source, not compiled.
- Source: Source/0774-recipebook/ (origin: https://mirrors.ctan.org/macros/latex/contrib/recipebook.zip; licence: LPPL 1.3, RecipeBook.cls:5-10, manifest `lppl1.3`)
- Kind: book (a cookbook: title page, contents, one or two recipes per page, LongSample.tex:2; the manifest hint is `misc`, from the CTAN topic)
- Lib: v6
- Engine: pdfLaTeX-compatible (README:27 says it needs pdflatex for image transparency; no fontspec, no Lua, no shell escape; `tikz` with the `fadings` library, RecipeBook.cls:118-119)
- Look carried by: class (both samples contain only content and class commands; every length, colour, page style, box and image treatment is in RecipeBook.cls, which loads `article`)
- Class origin: ctan (the zip is the CTAN release; https://ctan.org/pkg/recipebook read once: Brad Granger, LPPL 1.3, version 2015-02-13, the same date as `\ProvidesClass` at RecipeBook.cls:18)
- Main file: LongSample.tex (other samples: ShortSample.tex; LongSample.pdf and ShortSample.pdf are compiled output, not read; images/ holds eight JPEG assets)
- Read: main yes (LongSample.tex 338 of 338 lines, ShortSample.tex 148 of 148), zip-local classes and styles all (RecipeBook.cls 393 of 393 lines; it is the CTAN class, so "zip-local" means "shipped in the zip", not "unpublished"; README read in full)

## Verdict
yes, on the class-carried ruling. `RecipeBook` is a class released on CTAN (W1), so it is one way, `class.recipebook`, and both samples add only content and the class's own commands (LongSample.tex:6-337, ShortSample.tex:6-147); neither defines a macro, length, counter or package, and neither draws anything (the images are shipped JPEGs). Every package the class loads maps to a lib way or is a definition helper, and nothing needs a tool outside TeX (README:29-35 names `pdfjam` only for optional 2-up printing after compiling). This `yes` is evidence about the class dimension, not about the component ways. Caveat, not a blocker under the rubric: the class internals hold TikZ fade-frame artwork (RecipeBook.cls:215-226) that no lib way expresses as parameters; were the class unpublished I would call it ART/class and answer `no` (see Bespoke code).

## Blockers
none

## Class setting
- Class: `class.recipebook` options: none; `\documentclass{RecipeBook}` (LongSample.tex:6, ShortSample.tex:6), and the class fixes its base itself, `\LoadClass[letterpaper,12pt,twocolumn]{article}` (RecipeBook.cls:20), then overrides the page size with `geometry` (RecipeBook.cls:128-130).
- Class-native vocabulary used: `\titlepage[text]{img}{img}{img}` (LongSample.tex:10-13), `\makecontents` (LongSample.tex:15), `\section{}` and `\subsection{}` redefined to print nothing and write contents entries (LongSample.tex:19-20), `\author[preamble]{text}` as a footer (LongSample.tex:22), `\title[size]{}` and `\subtitle[size]{}` that print at once (LongSample.tex:24-25), `\recipesection[size]{}` (LongSample.tex:38), environments `info`, `ingredients`, `ingredients*`, `shrink[size]` (LongSample.tex:30, 39, 192, 28), `\item[bullet]{text}` redefined as a table row, `\group{}` (LongSample.tex:41, 46), `\step{n}{text}` (LongSample.tex:59), `\hlgroup{}` (LongSample.tex:58), `\pic[pos]{img}` (LongSample.tex:176, 241), `\leftbgpic[offset][opacity]{img}` and `\rightbgpic[offset][opacity]{img}` (LongSample.tex:26, 249-250), page style `recipe` (LongSample.tex:17). Defined, not used by either sample: `environment grow` (RecipeBook.cls:73-85), `info*` (RecipeBook.cls:314-318), `\num` (RecipeBook.cls:387-392), `\hlgroup`'s first optional argument (declared at RecipeBook.cls:373, never used in its body).
- Class lengths (parameters, set with `\setlength`): `\basefontsize` 13pt, `\basefontskipsize` 14pt, `\recipetitlefontsize` 22pt, `\instrnumsize` 22pt, `\recipeheadfontsize` 17pt (RecipeBook.cls:46-55), `\pagetop` 32.5pt (RecipeBook.cls:228), `\pagebottom` 6.15in (RecipeBook.cls:246); README:137-143 lists the five font lengths.
- Class quirks and limits of this read (recorded, not blockers): the README promises a colour argument for `\hlgroup` (README:110) but the body never uses `#1` (RecipeBook.cls:373-385); ShortSample.tex:54 and 68 comment on `\ingr` and `\instr`, which the class does not define (it defines `\item` and `\step`, RecipeBook.cls:329, 358); README:181-182 says `\author` must be set for every recipe or it carries over. No text addressed to an AI was found in the zip. Nothing is compiled, so whether the class builds on a current TeX Live is not checked; the CTAN summary names no engine, so the engine tag rests on README:27 and the class's package list.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | LongSample.tex:6; RecipeBook.cls:18 | `class.recipebook` | no options |
| base class | RecipeBook.cls:20 | `class.article` | loaded by the class, not the sample; kernel source not read |
| paper and type size, columns | RecipeBook.cls:20 | `page.class-options` | `letterpaper`, `12pt` (the paper is overridden by `geometry` below) |
| two columns | RecipeBook.cls:20 | `cols.twocolumn-option` | `twocolumn` |
| page geometry | RecipeBook.cls:128-130; README:19-20 | `page.geometry` | top=0.4in, inner=0.25in, outer=0.25in, bottom=0.65in, paperheight=8.5in, paperwidth=5.5in, headheight=16pt (loaded after `hyperref`, RecipeBook.cls:127) |
| column gap | RecipeBook.cls:90 | `sp.lengths` | `\columnsep` 12pt |
| paragraph spacing, package | RecipeBook.cls:39-40 | `sp.parskip-pkg` | `parskip` with `\parskip` `\medskipamount`, overridden by the lengths row |
| paragraph spacing, lengths | RecipeBook.cls:41, 88-89 | `sp.lengths` | `\parindent` 0pt, `\parskip` 4pt; `\@minipagerestore` resets `\parskip` to `\medskipamount` inside minipages |
| left-aligned text | RecipeBook.cls:22 | `sp.ragged` | `ragged2e` with option `document` |
| bottom not stretched | RecipeBook.cls:117 | `pg.flush` | `\raggedbottom` |
| float placement | RecipeBook.cls:213 | `fig.placement` | `\@fptop` 0pt (floats sit at the top of the page) |
| text face | RecipeBook.cls:43, 45 | `font.mathptmx` | package `tgtermes`; `\rmdefault` set to `qtm` |
| family default | RecipeBook.cls:45 | `font.family-default` | `\renewcommand{\rmdefault}{qtm}` |
| encoding | RecipeBook.cls:44 | `font.fontenc-t1` | `fontenc` T1; no `inputenc`; the samples use `Saut\'{e}` (LongSample.tex:88) |
| base size and line skip | RecipeBook.cls:28-29, 46-56 | `font.size-commands` | `anyfontsize` and scrextend `\changefontsizes[14pt]{13pt}` (nearest way: a font-size command family); five size lengths as in Class setting |
| size registers | RecipeBook.cls:46-55 | `sp.lengths` | `\newlength` and `\setlength` of the five registers |
| explicit sizes | RecipeBook.cls:138, 185, 208, 285, 290, 296, 365, 389 | `font.size-commands` | `\fontsize{x}{x}\selectfont` with x = `\recipeheadfontsize`, 46pt/40pt, `\recipetitlefontsize`, 18pt, `\instrnumsize` |
| text scaling wrapper | RecipeBook.cls:59-85; LongSample.tex:28, 106; ShortSample.tex:47, 86 | `font.size-commands` | environment `shrink[1pt]` lowers the four size registers (`\instrnumsize` by twice the value) and calls `\changefontsizes`; `grow` is the mirror; the arithmetic uses `calc` (RecipeBook.cls:36, 62) |
| `calc` syntax | RecipeBook.cls:36, 62, 68, 76, 82, 363 | `sp.lengths` | `calc` in `\addtolength{..}{-#1 * 2}` and `\widthof{..}` |
| degree sign | RecipeBook.cls:33; LongSample.tex:60 | `font.icons` | `gensymb` `\degree` (a symbol-glyph package is the parameter) |
| square bullet | RecipeBook.cls:23, 329 | `math.amssymb` | `\square` in `$\square$`, the default bullet |
| inline fractions | RecipeBook.cls:31; LongSample.tex:44, 52, 72 | `math.nicefrac` | `\nicefrac{1}{4}` |
| colours | RecipeBook.cls:32, 184, 290, 296, 301, 354, 365, 390 | `color.xcolor` | tints `black!50`, `blue!60`, `black!20`, `black!80`, `black!60` (all `\color` or `\textcolor`) |
| link colours | RecipeBook.cls:125-126 | `meta.hyperref` | `colorlinks`, `\hypersetup{linkcolor=blue}` |
| hyperlinks | RecipeBook.cls:99, 207-210 | `xref.hyperref` | `\hyperlink{contents}{\arabic{page}}` page number in the foot; `\hypertarget{contents}` on the contents heading; `\phantomsection` (RecipeBook.cls:196, 202) |
| running foot and head | RecipeBook.cls:95-115 | `hf.fancyhdr` | `\fancypagestyle` `recipe` (foot R page number as a link, empty head), `titlestyle` (empty), `tocstyle` (foot C `\today`); `\headrulewidth` and `\footrulewidth` 0pt in each |
| page style selection | LongSample.tex:17; RecipeBook.cls:140, 144 | `hf.pagestyle-kernel` | `\pagestyle{recipe}`; `\thispagestyle{titlestyle}`; `\thispagestyle{tocstyle}` |
| author in the foot | RecipeBook.cls:300-302; LongSample.tex:22, 111, 181, 247 | `hf.class-native` | `\author[Author: ]{text}` sets `\lfoot{\textcolor{black!20}{..}}`; must be set again for each recipe (README:181-182) |
| date in the contents foot | RecipeBook.cls:93-94, 112 | `front.datetime` | `datetime` with `\mmddyyyydate`, printed as `\today` |
| title page | LongSample.tex:10-13; ShortSample.tex:14-17; RecipeBook.cls:143-191 | `front.class-native` | `\titlepage[Recipes]{img1}{img2}{img3}`: grey (`black!50`) 46pt/40pt centred title text 0.9in from the top (RecipeBook.cls:181-188), three images, then `\clearpage \newpage` (RecipeBook.cls:190) |
| title page overlays | RecipeBook.cls:145-188 | `bg.eso-pic` | four `\AddToShipoutPicture*` calls; image offsets `\put(0.20in,0)`, `\put(0.25\paperwidth,0)`, `\put(0.5\paperwidth,0)` with `\vspace*` 2.40in, 3.90in, 5.40in; each image in a `\parbox[b][\paperheight]{\linewidth}` |
| title page images | RecipeBook.cls:151, 163, 175 | `fig.graphicx` | `\includegraphics[width=1.05\linewidth]{#}` inside a one-node `tikzpicture` used only as a box (anchor north east, inner sep 0) |
| contents | LongSample.tex:15; RecipeBook.cls:140 | `toc.kernel` | `\makecontents` = `\tableofcontents \thispagestyle{tocstyle}` |
| contents layout | RecipeBook.cls:123, 132-139 | `toc.tocloft` | `\cftsetindents{subsection}{8pt}{0pt}`, `\cftsetindents{section}{0pt}{0pt}`, `\cftdot` emptied, `\cftsecfont` = `\bfseries` at `\recipeheadfontsize`; `\cftaddtitleline` (RecipeBook.cls:197) |
| contents heading | RecipeBook.cls:207-210 | `toc.kernel` | `\contentsname` = "Recipes", bold at `\recipetitlefontsize`, wrapped in `\hypertarget{contents}` |
| section numbers off | RecipeBook.cls:134-135 | `num.counters` | `\renewcommand\thesection{}` and `\thesubsection{}` |
| section and subsection | LongSample.tex:19-20; RecipeBook.cls:194-204 | `head.class-native` | `\section{t}`: `\newpage`, `\phantomsection`, `\cftaddtitleline{toc}{section}{t}{}`; `\subsection{t}`: `\clearpage\newpage`, `\phantomsection`, `\addcontentsline{toc}{subsection}{t}`; neither prints the title |
| page breaks | RecipeBook.cls:190, 195, 201; LongSample.tex:215, 291, 335; ShortSample.tex:83, 124, 145 | `pg.break` | `\newpage`, `\clearpage`, `\pagebreak`; the final `\clearpage` is the README:178-179 workaround for background images on the last page |
| recipe title | LongSample.tex:24; RecipeBook.cls:284-286 | `front.class-native` | `\title[22pt]{t}` prints at once in a group: `\fontsize{#1}{#1}\selectfont \bf` |
| recipe subtitle | LongSample.tex:25; RecipeBook.cls:288-292 | `front.class-native` | `\subtitle[18pt]{t}` in `black!50`; the sample indents it with `\hspace*{0.75in}` |
| recipe heading | LongSample.tex:38; RecipeBook.cls:295-297 | `head.class-native` | `\recipesection[17pt]{t}`: `\fontsize` at `\recipeheadfontsize`, `\color{blue!60}\bf\emph{t}`; unnumbered, no contents entry |
| info block | LongSample.tex:30-35; RecipeBook.cls:305-318 | `tbl.tabular` | environment `info` = `tabular{ll}` between `\vspace*{\parskip}`; `info*` the same without the spacing |
| ingredients list | LongSample.tex:39-54; RecipeBook.cls:321-329 | `tbl.tabularx` | `tabularx{\linewidth}{@{}lX@{}}`, `\arraystretch` 1.08, `\tabcolsep` 4pt; `\item[$\square$]{text}` prints `#1 & #2 \\` |
| ingredient group row | LongSample.tex:46, 50; RecipeBook.cls:352-355 | `tbl.booktabs` | `\group{t}`: `\multicolumn{2}{l}{\color{black!80}\emph{t}} \\[-2pt] \toprule` |
| shaded ingredients | LongSample.tex:192-195; RecipeBook.cls:335-350 | `box.tcolorbox` | two nested boxes: outer colback=black!4, colframe=black!2, boxrule=2pt, arc=7pt, boxsep=0pt, left=1pt, right=1pt, top=-5pt, bottom=1pt; inner colback=black!8, colframe=black!6, boxrule=2pt, arc=6pt, left=0pt, right=0pt, top=-5pt, bottom=0pt; `\fboxsep` 0pt; body via `environ` `\BODY` in a `tabularx` |
| numbered step | LongSample.tex:59; RecipeBook.cls:358-371 | `fig.wrapfig` | `\step{n}{text}`: `wraptable{L}` of width `\widthof{<numeral>}` with a one-cell `tabularx`, numeral at `\instrnumsize` in `black!60`; `\intextsep` 4pt, `\columnsep` 6pt |
| step container | RecipeBook.cls:359-369 | `box.minipage` | `minipage{\linewidth}` around the wrapped table and the text |
| step group heading | LongSample.tex:58; RecipeBook.cls:373-385 | `box.tcolorbox` | `\hlgroup{t}`: outer colback=black!7, colframe=black!3, arc=5pt, top=-7pt, bottom=-1pt, left=1pt, right=1pt; inner colback=black!12, colframe=black!10, arc=4pt, top=-7pt, bottom=-3pt; `tabular{@{}m{\linewidth}@{}}` holding `\emph{$\:$t}` |
| image float | LongSample.tex:176, 241; ShortSample.tex:84; RecipeBook.cls:272-281 | `fig.class-native` | `\pic[t]{img}`: `figure[#1]` (default `t`) with `\includegraphics[width=.92\linewidth]` in a `tikzpicture` node, edges faded by `\framenode[4pt]` |
| page background image | LongSample.tex:26, 249-250; RecipeBook.cls:229-262 | `bg.eso-pic` | `\leftbgpic[32.5pt][0.4]{img}`: `\AddToShipoutPicture*`, `\put(0.20in,0.15in)`, `tikzpicture[opacity=#2]`, `\includegraphics[width=1.05\linewidth]`, `\framenode[25pt]`; `\rightbgpic[\pagebottom][0.4]{img}`: `\put(.49\paperwidth,0.15in)`, `\framenode[30pt]` |
| background image offsets | RecipeBook.cls:228, 246 | `sp.lengths` | `\pagetop` 32.5pt, `\pagebottom` 6.15in |
| manual spacing | RecipeBook.cls:183, 306, 189; LongSample.tex:25, 137 | `sp.manual-space` | `\vspace*`, `\hspace*{0.75in}`, `\quad` |
| emphasis and weight | RecipeBook.cls:285, 296, 354, 381 | `mark.kernel` | `\bf`, `\emph` (kernel font switches) |
| loaded, not called by the samples | RecipeBook.cls:23 | `math.amsmath` | `amsmath` (the samples set no equation) |
| loaded, not called by the samples | RecipeBook.cls:30 | `cols.multicol` | `multicol` (the columns come from `twocolumn`) |
| loaded, called only by `\num` | RecipeBook.cls:30, 388 | `tbl.multirow` | `multirow`; `\num` is defined but neither sample uses it |

No abstract, bibliography, index, theorem, equation, caption, footnote, code, language or metadata component occurs: the class defines none and the samples use none.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| macros in the samples | LongSample.tex:1-338; ShortSample.tex:1-148 | n/a | none: no `\newcommand`, `\def`, environment, counter or package in either sample |
| class vocabulary: `\titlepage`, `\section`, `\subsection`, `\title`, `\subtitle`, `\recipesection`, `\author`, `\item`, `\group`, `info`, `ingredients`, `ingredients*`, `\step`, `\hlgroup`, `\makecontents`, `\contentsname` | RecipeBook.cls:140-210, 284-392 | n/a: published class vocabulary (CTAN), not bespoke | They are the native commands of `class.recipebook` (listed in Class setting). Read as a composition each is `bg.eso-pic`, `fig.graphicx`, `toc.tocloft`, `toc.kernel`, `hf.fancyhdr`, `xref.hyperref`, `tbl.tabularx`, `tbl.booktabs`, `box.tcolorbox`, `fig.wrapfig`, `box.minipage`, `font.size-commands` with the parameters in the Component map, so an emitter could write them inline. Two of them redefine kernel names: `\item` becomes a table row (RecipeBook.cls:329; I did not check what that does to kernel lists, the samples use none) and `\titlepage` becomes a command (RecipeBook.cls:143). |
| size registers and `shrink`/`grow` | RecipeBook.cls:46-85 | n/a (class vocabulary); inline reduction exists | A change of five lengths plus one `\changefontsizes` call, `sp.lengths` and `font.size-commands`; the class macros read the registers, so a document that copied the environment would carry class logic. |
| TikZ fade frame: `\tikzfading` x4 and `\framenode`, used by `\pic`, `\leftbgpic`, `\rightbgpic` | RecipeBook.cls:118-119, 215-226, 229-281 | n/a (class vocabulary); no lib parameters | Four white `path fading` rectangles along the edges of an image node, with `opacity` on the picture; no lib way draws a faded edge (`art.tikz` is a restricted way). It is template-defining artwork (README:125 "fuzzy edges"). ART/class if the class were unpublished, and then the answer would be `no`; here it is inside the published class and an emitter only writes `\pic`, `\leftbgpic`, `\rightbgpic` with their arguments. |
| `\@minipagerestore` | RecipeBook.cls:41 | yes | `\parskip` reset to `\medskipamount` inside minipages: `sp.lengths` |
| `xparse` | RecipeBook.cls:24 | n/a | Definition syntax (`\NewDocumentEnvironment`, `\DeclareDocumentCommand`); it carries no look and has no lib way, none proposed (fails W2: it is code, not parameters). |
| `environ` | RecipeBook.cls:333-335 | n/a | Body-capture helper for `ingredients*` (`\BODY`); no look, no lib way, none proposed (fails W2). |
| `picture` | RecipeBook.cls:37 | n/a | Lets `\put` take lengths with units inside the `eso-pic` overlays; it places boxes and draws nothing, so it adds no artwork beyond the fade frame row. |

## Content-opaque
none. The recipe text, the shipped photographs (images/*.jpg) and the contents entries are content; the samples hold no TikZ, pgfplots or other drawing of their own.

## Lib changes
- New ways proposed: none. `class.recipebook` is a class way and needs no proposal; its vocabulary is recorded under Class setting. Considered: `recipe.xcookybooky` (a different package, `xcookybooky`, with a `recipe` environment; this class has its own commands) and `art.tikz` (restricted; the fade frame is class-internal, see Bespoke code).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
