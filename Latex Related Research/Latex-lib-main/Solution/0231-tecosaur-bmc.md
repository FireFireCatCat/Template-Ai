no

# 0231-tecosaur-bmc: BMC, the Bespoke Multipurpose Class (tecosaur)

- Unverified: read from the source, not compiled.
- Source: Source/0231-tecosaur-bmc/ (origin: https://codeload.github.com/tecosaur/BMC/zip/refs/heads/master; licence: LPPL-1.3c)
- Kind: report (a house class on KOMA `scrreprt` with chapter openers; the sample is the class's own manual, a long chaptered report)
- Lib: v4
- Engine: pdfLaTeX only, and not plain: `minted` needs `-shell-escape` and pygments, `biblatex` needs biber, `glossaries` is loaded with `automake`; pdfTeX primitives `\pdfsave` `\pdfsetmatrix` (bmc-fonts.sty:304-307) and hyperref option `pdftex` (bmc.cls:158) rule out XeTeX and LuaTeX
- Look carried by: zip-local (everything visible is set in `bmc.cls` and its six `bmc-*.sty` files; the sample's own preamble adds only footmisc, ulem, biblatex and one alias, bmc.tex:8-15)
- Class origin: zip-local (`bmc` is not on CTAN: ctan.org/pkg/bmc is a 404; it is the author's own GitHub class, README.md:5, 9; it loads published KOMA `scrreprt`/`scrartcl`, not bundled in the zip, source not read)
- Main file: documentation/bmc.tex (other samples: none; documentation/bmc.pdf is a rendered PDF, not read)
- Read: main yes, zip-local classes and styles all (bmc.cls, bmc-boxes, bmc-color, bmc-fonts, bmc-maths, bmc-ref, bmc-sectioning, infoBulle, marginInfoBulle, yMainColor, yMarginDesign; bmc-color.sty:358-569 are twelve `\newpalette` blocks of `\definecolor` hex values, checked structurally only, not value by value)

## Verdict
No. The look is carried by a zip-local class, and the sample sets option `code`, so `minted` is loaded (bmc.cls:601-602; bmc.tex:1), which needs shell escape and pygments: `EXTERNAL/package`. The class also holds irreducible code: a rewrite of booktabs/array internals for the table head, a patch of KOMA's `\scr@@startchapter` with a hand-positioned mini-contents, per-character faux small caps with font probing, raw `\pdfsetmatrix` slant boxes, custom pgfplots keys and a custom chemfig arrow. The chapter opener and the box icon badges are template-defining TikZ artwork (`ART`). Most of the rest (page, fonts, colours, headers, headings, captions, biblio, glossary, hyperref, PDF/A) reduces to lib ways.

## Blockers
- `EXTERNAL/package` `minted` loaded because the sample passes `code`; every code block and `\mintinline` of the sample goes through it; `\mintinline` is also rebuilt with `\DeclareTotalTCBox` (bmc.cls:601-602, 605-624, 659-669; bmc.tex:1, 152-155, 545-563)
- `BESPOKE/class` table-head fill: `\renewcommand{\toprule}`, `\patchcmd` of booktabs `\@BTrule`, `\renewcommand*{\@arraycr}` with the TeXbook "master counter" trick, plus a dummy `tabular` at begin-document to prime colortbl (bmc.cls:708-765)
- `BESPOKE/class` chapter opener: `\xapptocmd{\scr@@startchapter}{\printMiniToc\vfill\newpage}` patches KOMA internals; the mini-contents is placed with `\vspace*{12cm}` and `\hspace*{\dimexpr...}`; the chapter entry in the contents overprints a page-number `\parbox` with `\vspace*{-1.48cm}` and a `\parshape` frame built on `\MakeFramed` (bmc-sectioning.sty:183-201, 206-219, 248)
- `ART/class` chapter page TikZ overlay: a solid 7.5cm side panel or a 1mm stripe filled against `current page`, and the chapter number and title placed as nodes at fixed page offsets (bmc-sectioning.sty:89-98, 229-243)
- `ART/class` box icon badge: a TikZ circle or hexagon holding an icon glyph in every box title, and tcolorbox `overlay` draws for the side bar and the continued-box header (bmc-boxes.sty:39-41, 52-61, 81-98, 112-117)
- `BESPOKE/class` faux small caps: `\textsc` redefined with an `\ifcsname \f@encoding/\f@family/\f@series/sc\endcsname` font probe, `\fauxschelper` walking the text character by character with `\scalebox`, `\fauxfontheavier` comparing `\the\font` after `\sbox` probes; `\acr` is built on it (bmc-fonts.sty:256-297; bmc.cls:909; used at bmc.tex:60, 213)
- `BESPOKE/class` slanted upright d: `\makesl` saves a box and applies `\pdfsave` `\pdfsetmatrix{1 0 0.2 1}` `\pdfrestore`; `\dd` depends on it (bmc-maths.sty:54-68; used at bmc.tex:362, 453-455)
- `BESPOKE/class` pgfplots keys `v asym` and `h asym` (`unbounded coords`, `/utils/exec` with `\foreach` and `\xdef`, `y filter`, `execute at end plot visualization` drawing dashed lines) and the axis-arrow `execute at end axis` path code (bmc.cls:219-239, 266-292; used at bmc.tex:515, 527)
- `BESPOKE/class` chemfig arrow type `-X>` through `\definearrow9` written against chemfig internals `\CF@arrow@...` (bmc.cls:352-397; used at bmc.tex:599)

## Class setting
- Class: `class.scrreprt` as loaded by the zip-local `bmc` (`\LoadClass[numbers=noenddot]{scrreprt}`, bmc.cls:132; `class.scrartcl` when option `article` is given, bmc.cls:129-130). `bmc` itself is zip-local and is not a lib way: its content is the rows below. Options given by the sample: `solid,math,chem,code,plot,gloss` (bmc.tex:1), all `kvoptions` switches of `bmc` (bmc.cls:45-81); any other option is forwarded to the KOMA class (bmc.cls:83-89).
- Class-native vocabulary used: KOMA `\titlehead` `\subtitle` `\title` `\author` (bmc.tex:3-6), `\chapter` `\section` `\subsection` `\paragraph` `\subparagraph` (bmc.tex:75-79, 356), `\section*` (bmc.tex:28); behind the class: `\addtokomafont` `\setkomafont` `\RedeclareSectionCommands` `\sectionformat` `\chapterformat` `\chapterlinesformat` `\sectionlinesformat` (bmc-sectioning.sty:76-134); bmc's own `\fancytoc`, `\acr`, `\newBmcBox`, `\newpalette`, `\usepalette`, `\newdefinedacronym`, boxes `example` `critical` `question` `info` `check` `warning` `tip` `maths` `proof` `theorem` `lemma` `corollary` `definition` `axiom` `proposition`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | bmc.cls:129-133 | `class.scrreprt` | `numbers=noenddot`; `class.scrartcl` with `article` |
| paper, margins | bmc.cls:561-581 | `page.geometry` | a4paper, ignoreheadfoot, left=2.5cm (1cm if twoside), right=2.7cm (1cm with `notes`, plus includemp, marginparwidth=5cm, marginparsep=5mm; otherwise marginparwidth=0cm), top=2cm, bottom=3.5cm, headsep=1cm; showframe in draft |
| title-page geometry | bmc.cls:794, 850 | `page.geometry` | `\newgeometry{left=4cm,right=2.7cm,top=1.5cm}` ... `\restoregeometry` |
| paragraph shape, notes spacing | bmc.cls:583-590 | `sp.lengths` | `\skip\footins`=1cm, `\footnotesep`=2mm, `\parskip`=1ex, `\parindent`=0pt (old value kept as `\tindent`) |
| `\indent` restored | bmc.cls:590 | `sp.manual-space` | `\renewcommand{\indent}{\hspace*{\tindent}}` |
| line spacing | bmc-fonts.sty:219, 70; bmc-sectioning.sty:215 | `sp.linespread`, `sp.setspace` | `\linespread{1.15}`; `setspace` loaded, `spacing` environment 1.1 in the mini-contents |
| microtypography | bmc-fonts.sty:68-69; bmc.cls:909 | `sp.microtype` | `activate={true,nocompatibility}`, final, kerning=true, spacing=true, factor=2000; `\microtypecontext{spacing=nonfrench}`; `\textls*[70]` |
| penalties | bmc-fonts.sty:220-221 | `sp.penalties` | `\@beginparpenalty`=10000, `\hyphenpenalty`=500 |
| hyphenation limits | bmc-fonts.sty:223-224 | `sp.hyphenat` | `\lefthyphenmin`=2, `\righthyphenmin`=3 (integer hyphenation parameters; nearest home, not penalties) |
| encodings | bmc-fonts.sty:65-66 | `font.fontenc-t1` | `fontenc` T1, `inputenc` utf8 |
| text faces | bmc-fonts.sty:84-90 | `font.serif-pkg`, `font.helvet`, `font.mono` | IBM Plex through the CTAN bundle `plex` (ctan.org/pkg/plex states LaTeX and pdfLaTeX support; the style names `plex-serif` `plex-sans` `plex-mono` are the bundle's own files, named from knowledge, not shown on that page; the fonts are not shipped in the zip); option `noto` loads `noto` instead (bmc-fonts.sty:85) |
| bold series, default family | bmc-fonts.sty:93-95, 226-234 | `font.nfss`, `font.family-default` | `\def\bfseries@rm{sb}` (also sf, tt); `\familydefault` = `\rmdefault`/`\sfdefault`/`\ttdefault` by option `body` |
| heading family | bmc-fonts.sty:239-250 | `font.family-default` | `\headingsFont` and `\titleFont` aliases of `\sfdefault` (option `headings`), used as `\fontfamily{\headingsFont}` |
| font series and sizes | bmc-sectioning.sty:77, 83; bmc.cls:819-880 | `font.nfss`, `font.size-commands` | `\fontseries{tx,sb,mb,m,l}`, `\fontsize{1.7cm}{1.4cm}`, `\fontsize{6.5cm}{1ex}`, `\fontsize{2cm}{4em}` |
| maths letters in text face | bmc-fonts.sty:110-212 | `font.mathastext` | `[basic,italic,symbolgreek]` and 52 (serif) or 25 (sans) `\MTsetmathskips{x}{l}{r}` values in mu |
| maths symbol face | bmc-maths.sty:24-26; bmc-fonts.sty:74 | `font.palatino`, `font.nfss` | `newpxmath` option `varbb` (omitted with `nofont`); `\DeclareMathAlphabet{\mathcal}{OMS}{cmsy}{m}{n}` |
| icon font | bmc.cls:326; bmc-fonts.sty:97 | `font.icons` | `fontawesome5`; glyphs `\faClipboard` `\faTimes` `\faQuestion` `\faInfo` `\faCheck` `\faExclamation` `\faLightbulb` (bmc-boxes.sty:124-130), `\faList` (bmc-sectioning.sty:210) |
| colour package | bmc-color.sty:14-25 | `color.xcolor` | `[dvipsnames,svgnames,table,hyperref]`; `gray` in draft, `cmyk` with `print`, else `natural` |
| theme colours | bmc-color.sty:46-68 | `color.xcolor` | light page #FFFFFF text #000000; dark page #222222 text #FCFCFC; primary #019875; contrastColour #E8F1F2; tertiary #C47238; secondary #C6B53C; quaternary #BD3E4C; alternativePrimary #13293D; primaryVariant `primary!75!Cream>twheel,-3,360` (bmc-color.sty:60) |
| palettes | bmc-color.sty:75-205, 607 | `color.xcolor` | `de` (default) and 14 more are lists of `\definecolor{..}{HTML}{..}` plus derived `\colorlet` Light/Dark mixes (132-168); selection resolves statically |
| box and link colours | bmc-color.sty:85-100, 610-618 | `color.xcolor` | `\colorlet` of infoBulleBackground=page!98!text, criticalColor=Red, questionColor=Purple, informationColor=Green, checkColor=Blue, warningColor=Orange, tipColor=Purple, exampleColor=Blue, mathematicalColor=Orange, codeColor=Grey; href=tertiary, inlinemath=secondary!50!text |
| page and text colour | bmc-color.sty:54-55; bmc.cls:903-906 | `color.pagecolor` | `\pagecolor{page}`, `\color{text}` at begin document |
| running head and foot | bmc.cls:180; bmc-sectioning.sty:274-326 | `hf.scrlayer-scrpage` | `automark, draft=false, headwidth=textwithmarginpar, footwidth=head`; `\clearpairofpagestyles`, `\cfoot*`, `\chead{..\headmark}`, `\addtokomafont{pagehead,pagenumber}`; background layer `my.head.background` (`\DeclareLayer[background,topmargin,addheight=\headheight]`, filled `\rule`), `\AddLayersAtBeginOfPageStyle`, `\ModifyLayer[addvoffset=-.5in-.5\voffset-.5\topmargin]`; draft rulers 254-272 |
| page number and head as links | bmc-sectioning.sty:275, 278-280 | `meta.hyperref` | `\hyperlink{contents}{\pagemark}`, `\hyperlink{chapter.N}{\headmark}`; the `\hypertarget{contents}` is commented out (181) |
| cover page | bmc.cls:786-855 | `front.titlepage-env`, `front.koma-title` | `titlepage` environment, `\pagecolor{primary}` (solid), `\titlehead` in `\textsc` `\LARGE`, title `\fontsize{2cm}{4em}\fontseries{sb}`, 2pt `\rule`, `\@subtitle` `\huge`, author `\fontseries{l}`, date `\Large`; uses `sp.rule`, `color.pagecolor` |
| article title | bmc.cls:856-898 | `front.maketitle` | hand-laid `\maketitle` in `\centering` (option `article`) |
| date format | bmc.cls:686-693 | `front.datetime` | zero-padded day, ordinal suffix as `\textsuperscript`, month name, year (reducible to a `\newdateformat`; not called by the sample except through the cover `\@date`, bmc.cls:848) |
| sample title block | bmc.tex:3-6 | `front.koma-title`, `front.maketitle` | `\titlehead`, `\title` with `\texorpdfstring` (meta.hyperref), `\subtitle`, `\author` with `\newline` |
| footnote marks | bmc.tex:8-9 | `fn.footmisc`, `num.counters` | `symbol*`; `\renewcommand{\thefootnote}{\fnsymbol{footnote}}`; body `\footnote` `\footnotetext` `\footref` (bmc.tex:213, 439, 468) with `fn.kernel` |
| contents | bmc-sectioning.sty:152, 156-165, 176-180 | `toc.titletoc`, `toc.kernel`, `num.secnumdepth` | `\tableofcontents` in a group with `\let\clearpage\relax`; `tocdepth`=0; `\contentsname` empty (book) or Contents (article); `\hypersetup{linkcolor=text}` |
| contents side word | bmc-sectioning.sty:166-169 | `pg.textpos`, `fig.rotating` | `textblock*{5cm}(1.6cm,6cm)`, `\fontsize{4cm}{2em}`, `\rotatebox[origin=c]{90}{Contents}`; package `textpos` with `absolute,overlay` (154) |
| headings | bmc-sectioning.sty:102-123, 134 | `head.koma-fonts`, `head.class-native` | `\addtokomafont{section,subsection,subsubsection,paragraph,subparagraph}` colour primary (primary!70!text for the last two), `\Huge` `\huge` `\LARGE`, `\fontseries{sb,mb}`, `\fontfamily{\headingsFont}`; `\sectionformat` etc. = italic sb number, `\autodot`, `\enskip`; `\RedeclareSectionCommands[indent=0em]` |
| chapter heading look | bmc-sectioning.sty:76-86 | `head.koma-fonts`, `head.class-native` | `\addtokomafont{chapter}` 1.7cm/1.4cm tx colour alternativePrimary; `\chapterformat` 6.5cm number, `m` series, colour page (solid) or primary |
| article section rule | bmc-sectioning.sty:125-132 | `head.class-native` | `\sectionlinesformat` with `\hfill`, `\rule{\textwidth}{.4pt}` in primary |
| display paragraph heads | bmc-sectioning.sty:137-146 | `head.class-native` | `\paragraph`/`\subparagraph` followed by `\mbox{}` (equals KOMA `\RedeclareSectionCommands[runin=false]`) |
| chapter page panel | bmc-sectioning.sty:93-97, 230-243 | `bg.tikzpagenodes` | **ART**: `\fill[fill=primary] (current page.south west) rectangle ++(7.5cm,\paperheight)` or 1mm stripe at 7.42cm; nodes at `[yshift=-7.5cm,xshift=8.7cm]` and `[yshift=-4.8cm,xshift=7.7cm]` |
| chapter contents entry, mini-contents | bmc-sectioning.sty:183-227, 248 | `toc.titletoc` | **BESPOKE**: `\titlecontents{chapter}` / `{psection}` / `{psubsection}` with `\startcontents[chapters]` `\printcontents`, plus the overprint layout and the `\scr@@startchapter` patch (see Blockers) |
| tables | bmc.cls:313-315 | `tbl.booktabs`, `tbl.tabularx`, `tbl.longtable` | plain loads; sample uses `tabular` with `\toprule` `\midrule` `\bottomrule` (bmc.tex:97-130), `longtable` with `\endfirsthead` `\endhead` `\endfoot` `\endlastfoot` (bmc.tex:902-939) |
| table colours | bmc.cls:598, 702, 761; bmc.tex:923-925 | `tbl.colortbl` | `\AtBeginEnvironment{tabular}{\color{text}}` (etoolbox hook, reduces to a cell colour switch), `tableheadcolor`=text!5!page, `\rowcolors{1}{tableheadcolor}{tableheadcolor}`, `\rowcolor`, `\hiderowcolors`, `\arrayrulecolor` |
| table head fill | bmc.cls:708-765 | `tbl.booktabs` | **BESPOKE** (see Blockers) |
| captions | bmc.cls:323-324, 593-595 | `cap.caption`, `cap.koma` | `caption` option `hypcap=true`; `subcaption`; `\setkomafont{caption}{\fontfamily{\headingsFont}\small\color{text}}`, `captionlabel` `\fontseries{tx}\upshape`; `\captionsetup{justification=raggedright,singlelinecheck=true}`; floats `table` `[!htb]` with `\caption` `\label` (bmc.tex:97-130) |
| graphics loading | bmc.cls:320-321, 323 | `fig.graphicx`, `fig.subcaption` | `graphicx`, `grffile`, `subcaption` |
| columns | bmc.cls:317; bmc.tex:333-343, 408-426 | `cols.multicol` | `multicols{2}` with `\columnbreak` |
| lists | bmc.tex:82-86, 505-509 | `list.kernel` | `enumerate`, `itemize` with `\item[]` |
| admonition boxes | bmc-boxes.sty:25-63, 124-131 | `box.tcolorbox` | `tcbset{bmcbox}`: enhanced, `fonttitle=\large\fontfamily{\headingsFont}\fontseries{sb}`, `coltitle=text`, `colback=colbacktitle=colframe=infoBulleBackground`, toprule=4pt, titlerule=0pt, other rules 0pt, segmentation hidden, sharpish corners, before/after skip `\baselineskip`, boxsep=2pt, top=6pt bottom=4pt left=8pt right=6pt, breakable; `extras middle and last` for the continued header; `\DeclareTColorBox[auto counter]` per box with args `O{} O{} O{\thetcbcounter}`, `label=<prefix>:##3` |
| theorem-like boxes | bmc-boxes.sty:100-121, 132-140 | `thm.tcolorbox` | same `\newBmcBox` for maths, proof, theorem, lemma, corollary, definition, axiom, proposition, colour mathematicalColor, icon `\pi`, prefixes mth prf thr lem cor def axi prop; `\tcb@cnt@<env>autorefname` set for `\autoref` |
| box side bar and icon badge | bmc-boxes.sty:39-41, 92-98 | `art.tikz` | **ART** (see Blockers) |
| code blocks | bmc.cls:601-657 | `code.minted`, `box.tcolorbox` | **EXTERNAL**: `\setminted{...}` (linenos, breaklines, tabsize=4, xleftmargin=3.5em, styles autumn or monokai, ...) wrapped by `\BeforeBeginEnvironment{minted}` in a breakable `tcolorbox` (`many` library) with a line-number strip overlay |
| inline code, verbatim | bmc.cls:659-669; bmc.tex:42 | `code.minted`, `code.verbatim` | `\mintinline` as a `tcbox`; `\verb` |
| maths packages | bmc-maths.sty:23-29 | `math.amsmath`, `math.amssymb`, `math.nicefrac`, `math.physics`, `math.mathtools` | `amsmath` `amssymb`, `xfrac` (`\sfrac`), `cancel[makeroom]`, `mathtools` |
| delimiters, operators | bmc-maths.sty:32-37, 89-92 | `math.mathtools`, `math.amsmath` | `\DeclarePairedDelimiter` abs norm ceil floor round; `\DeclareMathOperator` Lap Var Cov E |
| bibliography | bmc.tex:14-15, 1243; bmc.cls:955-970 | `bib.biblatex-biber` | `style=apa,backend=biber`, `\bibliography{refs}`, `\printbibliography`; `\defbibenvironment{bibliography}` as a `list` (leftmargin=`\bibhang`, itemindent=-leftmargin, itemsep=`\bibitemsep`, parsep=`\bibparsep`) with `\newpage` for solid/stripe, `\vspace*{2cm}` else |
| glossary, acronyms | bmc.cls:910-950; bmc.tex:19-23, 207, 1244 | `idx.glossaries` | `[automake,smallcaps,numberedsection=nolabel,style=long3col]`, `\makeglossaries`, style `mylist` (`longtable` with widths 0.28/0.64/0.08 `\textwidth`, `\glossentry` redefined), `\acronymfont`→`\acr`, `\newdefinedacronym`; `automake` calls makeindex (note, not counted) |
| hyperref | bmc.cls:152-172; bmc-ref.sty:115-136 | `meta.hyperref` | `pdfa, unicode=true, pdfencoding=unicode, psdextra, pdftex, backref, bookmarks, bookmarksopen, pdfpagemode=UseNone, pdftoolbar=false, pdfmenubar=true, pdffitwindow=false, pdfdisplaydoctitle, pdfborder={1 1 0}, breaklinks, colorlinks, hyperindex`; `\hypersetup` linktoc=all, link/anchor/cite/run/url/file colour=href, menucolor=primary |
| PDF/A, PDF/X | bmc.cls:173-177 | `meta.pdfx` | `[a-3u,pdf17]`, or `[x-3,pdf17]` with `print`; reads a `<jobname>.xmpdata` that the zip does not ship (note, missing asset) |
| outline strings | bmc-ref.sty:21-111 | `meta.hyperref` | `\pdfstringdefDisableCommands` mapping ~90 commands to literals |
| url style | bmc-ref.sty:138; bmc.tex:326 | `meta.url` | `\urlstyle{same}`; body `\url` |
| cross-references | bmc.tex:12, 223 | `xref.hyperref`, `xref.kernel` | `\fullref`=`\hyperref[#1]{\ref*{#1} \nameref*{#1}}`, `\autoref`, `\label`, `\thispdfpagelabel` (bmc.tex:27) |
| strike-through variant | bmc.tex:10, 604-605 | `mark.ulem` | `ulem[normalem]`, `\ULthickness`=1pt, `\soutt` = `\ULdepth=-.45ex \ULset` |
| chemistry, plots, drawings | bmc.cls:196-311, 334-344; bmc.tex:309-312, 477-601 | `art.tikz`, `art.content-package` | `pgfplots` theme, `mhchem[version=4]`, `chemfig` with `\setchemfig{..}`: content (see Content-opaque), except the custom keys and arrow, which are blockers |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option parsing, `\ifdefstringx` | bmc.cls:39-123 | yes | `kvoptions` switches are static for a given sample; the emitter picks the branch |
| table-head fill (`\toprule` `\@arraycr` `\@BTrule`) | bmc.cls:708-765 | no | rewrites array/booktabs internals; no lib way expresses a coloured head band that also shades the rule spacing |
| chapter opener (`\scr@@startchapter` patch, mini-contents, contents entry) | bmc-sectioning.sty:183-219, 248 | no | KOMA-internal patch plus overprinted boxes with negative skips |
| chapter panel overlay `\titleBackground` | bmc-sectioning.sty:229-243 | no | `ART`: TikZ page-anchored fill and nodes |
| `\newBmcBox` | bmc-boxes.sty:100-121 | partly | expands to `\DeclareTColorBox` (`box.tcolorbox`, `thm.tcolorbox`); the title's `\ifstrempty` conditionals become per-instance `title=`; blocked by the icon badge (`ART`) |
| icon badge `\faAbstractIcon`, `/infoBulle/icon/*` pgfkeys | bmc-boxes.sty:67-98 | no | `ART`: TikZ circle or hexagon around a glyph; the key tree needs `interfaces-base` (below) |
| `interfaces-base` and `\LoadInterface{pgfkeys}` | bmc-boxes.sty:21-22 | unknown | not in the zip; ctan.org/pkg/interfaces-base is a 404, so W1 is not established; the loaded pgfkeys interface is used only by the icon key tree |
| faux small caps, `\textsc` redefinition, `\acr` | bmc-fonts.sty:256-297; bmc.cls:909 | no | font-existence probe and per-character `\scalebox` recursion |
| inline-maths colour `\(` | bmc-fonts.sty:311-313; bmc.cls | yes | per-node wrapper `\(\color{inlinemath}...\)` with `\colorlet{inlinemath}` set in each heading, box, caption and head context (bmc-sectioning.sty:102-111, bmc-boxes.sty:104, 114) |
| slant box `\makesl`, `\dd`; `\fauxsl` (never called) | bmc-maths.sty:51-69; bmc-fonts.sty:299-308 | no | raw `\pdfsave` `\pdfsetmatrix` `\pdfrestore` |
| `\dv`, `\pdv`, `\RR` ... `\HH`, `\EE`, `\Lap`, `\qed`, `\qedhere`, `\leq`→`\leqslant` | bmc-maths.sty:39-47, 70-102 | yes | aliases and `\frac`/`\mathbb` expansions; `\dd` stays bespoke |
| matrix alignment `\env@matrix[1][r]` | bmc-maths.sty:105-107 | yes | emit `bmatrix*` with `[r]` from `mathtools`; the override copies amsmath internals |
| `\RN` `\Rn`, `\ditto`, `\let\circledS\undefined` | bmc-fonts.sty:99, 79, 316-319 | yes | `\RN` equals the kernel `\@Roman` pattern (`\Roman`); `\ditto` an alias; the `\undefined` is a load-order workaround with no printed effect |
| palette machinery `\newpalette` `\usepalette` `\ensurepalettecomplete` | bmc-color.sty:75-168 | yes | expand the chosen palette to `\definecolor` and `\colorlet` lines; mid-document `\usepalette` (bmc.tex:1020, 1056) emits the same lines in place |
| pgfplots keys `v asym` `h asym` and axis arrows | bmc.cls:219-239, 266-292 | no | pgfkeys code with `\xdef`, `\foreach`, `/utils/exec` and drawn paths |
| chemfig arrow `-X>` | bmc.cls:352-397 | no | uses chemfig internals; a commented-out `\CF@chemfig@iii` patch (399-554) is dead code |
| `\today` redefinition | bmc.cls:686-693 | yes | `front.datetime` `\newdateformat` (ordinal suffix) |
| glossary style `mylist`, `\newdefinedacronym` | bmc.cls:919-950 | yes | the package's own `\newglossarystyle` and `\newglossaryentry` calls with `longtable` |
| `\defbibenvironment{bibliography}` | bmc.cls:959-967 | yes | biblatex declaration with a `list` |
| `\pdfstringdefDisableCommands` list | bmc-ref.sty:21-111 | yes | hyperref hook with literal strings |
| sample `\setrow` `\rowmac` `\clearrow`, `\ifbool{tabularTitleRow}` (bool never set true) | bmc.tex:94-110; bmc.cls:700-701 | yes | inline per-cell font switch (`\ttfamily\scriptsize`, `\fontseries{..}`) |
| sample `\fullref`, `\soutt`, `\colorBox*`, `\demoPalette` | bmc.tex:12, 605, 309-312, 988-1034 | yes | alias, `mark.ulem` parameters; the swatches are TikZ content |
| not loaded by the class or sample: `infoBulle.sty`, `marginInfoBulle.sty`, `yMainColor.sty`, `yMarginDesign.sty` | bmc.cls:328 (commented); infoBulle.sty:40-53 | n/a | read; compositions of `mdframed`, `listings`, `marginnote`, `changepage`, `tikz` with `\NewDocumentEnvironment`; out of scope for this sample (the `\GetTranslation` calls at marginInfoBulle.sty:108 need `translations`, which is not loaded) |

## Content-opaque
- TikZ colour swatches and the colour-association table cells drawn with `\tikz` (bmc.tex:309-312, 988-1034, 1164-1177)
- pgfplots axes and plots (bmc.tex:490-535)
- chemfig molecules and the reaction scheme (bmc.tex:571-575, 598-601)
- kernel `tabbing` in a zero-width `\parbox` used as a two-line comparison (bmc.tex:166-170, 377-383); no lib way names `tabbing`, treated as demo content
- the minted listings' text and the bibliography entries (documentation/refs.bib), the Plex weight table cell text (bmc.tex:112-126)

## Lib changes
- New ways proposed: `font.mathastext` `mathastext` (CTAN, Jean-Francois Burnol, TeX Live; the CTAN page was not read in this run because the three allowed reads went to `bmc`, `plex` and `interfaces-base`), pdfLaTeX. It sets maths letters, digits and Greek in the current text face: `\usepackage[basic,italic,symbolgreek]{mathastext}` and per-letter spacing `\MTsetmathskips{x}{left}{right}`. W1: on CTAN. W2: option keywords and mu-valued spacing lengths. W3: serves any document whose maths should follow its text font. W4: one preamble line plus `\MTsetmathskips` lines. Not `font.newtx`/`font.palatino` (those load a font's own maths set), not `math.bm`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
