no

# 0851-serialhex-pf2e-tex: PF2e-TeX (Pathfinder 2e style book package and Spellbook sample)

- Unverified: read from the source, not compiled.
- Source: Source/0851-serialhex-pf2e-tex/ (origin: https://codeload.github.com/serialhex/PF2e-TeX/zip/refs/heads/master; licence: MIT)
- Kind: book
- Lib: v6
- Engine: needs XeLaTeX (fontspec at book/pf-fonts.sty:3; raw `\special{pdf:...}` for xdvipdfmx at book/pf-fonts.sty:117-122; readme.md:3 says "specifically XeLaTeX")
- Look carried by: zip-local (pf-book.sty and book/pf-*.sty define the whole look; the sample only sets class options, one `\chapter` hack and calls the macros)
- Class origin: tex-distribution-unbundled
- Main file: PF2e-TeX Spellbook.tex (other samples: scripts/tmpl.tex; docs/actions.tex and docs/sections.tex are chapters `\include`d by the main file, PF2e-TeX Spellbook.tex:101-102)
- Read: main yes, zip-local classes and styles all

## Verdict
No. The look lives in the zip-local, non-CTAN package `pf-book` (its CTAN page is a 404; GitHub project, not an official Paizo kit), so every macro in it must reduce to lib ways. Most do (titlesec headings, tcolorbox boxes, tabularx and caption tables, fancyhdr footers, fontspec faces, colour definitions), but the box file draws template-defining shapes with raw TikZ (parchment frame, torn paper, title-box trapezoid, example-box corner triangles, quote-box dots, the stat-block divider line) and the art file computes full-bleed page offsets by hand. The sample also rewrites the book class `\chapter` from kernel internals. Those are `ART` and `BESPOKE` blockers, so no.

## Blockers
- `ART/class` parchment frame: `framed` + TikZ `random steps` decorations and torn borders (book/pf-box.sty:95-99, 103-168)
- `ART/class` torn paper: hand-declared pgf decoration `irregular fractal line` and the `\tornpaper` path (book/pf-box.sty:192-199, 203-215, 217-250)
- `ART/class` `pf-titlebox`: trapezoid title shape from raw `frame code` / `interior code` TikZ paths (book/pf-box.sty:63-84)
- `ART/class` `pf-examplebox`: corner triangles drawn by `overlay` `\fill` paths (book/pf-box.sty:254-278, paths at 271-276)
- `ART/class` `pf-quotebox`: corner dots drawn by `overlay` `\foreach ... \draw ... circle` (book/pf-box.sty:290-310, drawing at 305-307)
- `ART/class` stat-block divider `\pfhline`, a TikZ line `\draw (0,0) -- (0,0) -- (\linewidth,0.05)` (pf-book.sty:187-195; used at book/pf-creature.sty:96,116, book/pf-spell.sty:33,81, book/pf-box.sty:21, book/pf-items.sty:63)
- `BESPOKE/class` `\pfBigArt`: full-bleed `figure*` whose offsets are chosen by `\checkoddpage`/`\ifoddpage` and `\dimexpr` sums of `\oddsidemargin`, `\evensidemargin`, `\voffset`, `\topmargin`, `\headheight`, `\headsep`, `\paperheight`, `\textheight`, with negative `\vspace*` (book/pf-art.sty:12-35); no lib way holds this arithmetic (`page.adjustwidth` takes two fixed lengths)
- `BESPOKE/class` key-presence conditionals that decide which stat-block fields print (`\newkeycommand` macros `\basics`, `\pfspellheader`, `\itemBasics`, `\degreeSuccess`) and a catcode-hack re-implementation of the `keycommand` internal `\ifcommandkey` (pf-book.sty:198-212; book/pf-creature.sty:48-121; book/pf-spell.sty:53-83; book/pf-items.sty:84-119); an emitter would have to copy this zip-local conditional logic
- `BESPOKE/preamble` `\renewcommand\chapter` built from `\@topnum`, `\@afterindentfalse`, `\secdef\@chapter\@schapter` to drop the page break (PF2e-TeX Spellbook.tex:26-31); `titlesec`'s `\titleclass` might express the page-break part, but the sample redefines it after titlesec is loaded and no lib way is shown to cover the rest, so counted irreducible
- `EXTERNAL/body` the action icons `\actionIcon` etc. include `book/img/one-action` and siblings, which exist only as `.eps` and `.svg` (book/pf-actions.sty:7-11; called at docs/actions.tex:14-21); EPS under XeLaTeX is converted by xdvipdfmx through Ghostscript, the case the lib files under `fig.epstopdf` (not verified here, secondary to the blockers above)

## Class setting
- Class: `class.book` options: 10pt, letterpaper, onecolumn, openany (PF2e-TeX Spellbook.tex:1). Kernel class, source not read. `pf-book` is zip-local, not a class (loaded by `\usepackage[bg=full]{pf-book}` at PF2e-TeX Spellbook.tex:5).
- Class-native vocabulary used: `\frontmatter` (:48), `\mainmatter` (:72), `\chapter` (:80, docs/actions.tex:1, docs/sections.tex:1), `\section` `\subsection` `\subsubsection` `\paragraph` `\subparagraph` (docs/sections.tex:36-60), `\tableofcontents` (:69), `\include` (:101).
- Option `bg=full` of pf-book (pf-book.sty:69-89) sets two toggles that no code reads (grep: `bool-bg` and `bool-footer-scroll` only set, never tested), so it has no printed effect; `justified` (pf-book.sty:111-112) is likewise unread; `nomultitoc` (pf-book.sty:114-117) is the only toggle read (book/pf-sections.sty:7).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | PF2e-TeX Spellbook.tex:1 | `class.book` | 10pt, letterpaper, onecolumn, openany |
| paper and size | PF2e-TeX Spellbook.tex:1 | `page.class-options` | letterpaper, 10pt, onecolumn |
| page geometry | pf-book.sty:8-15 | `page.geometry` | top=40pt, bottom=50pt, footskip=30pt (hmargin, bindingoffset, scale commented out) |
| small margins | pf-book.sty:23 | `page.vmargin` | `fullpage` with option `cm` |
| hyphenation off | pf-book.sty:18 | `sp.hyphenat` | `hyphenat` option `none` |
| paragraph and column lengths | pf-book.sty:156,169,178 | `sp.lengths` | parindent=15pt, parskip=0pt, columnsep=25pt; `calc` loaded at :26 |
| columns | PF2e-TeX Spellbook.tex:86-99; docs/actions.tex:3; pf-book.sty:39,54 | `cols.multicol` | `multicols{2}`; package option `colaction` |
| page breaks | PF2e-TeX Spellbook.tex:68; book/pf-sections.sty:34,52 | `pg.break` | `\clearpage` |
| page numbering | book/pf-sections.sty:42,53-54 | `pgnum.pagenumbering` | `\pagenumbering{alph}` then `{roman}`, `\setcounter{page}{0}` (in `\pfMakeLogoCover`) |
| header and footer | book/pf-pagestyle.sty:1-4,19-22,36-50 | `hf.fancyhdr` | `\pagestyle{fancy}`, headrulewidth=0pt, footrulewidth=0pt, `\fancyhf{}`, `\fancyfoot[LE]` and `[RO]` carry `\thepage` and `\nouppercase\leftmark` in `\pfFooterFont` (scshape), colour `pfFooterColor` |
| footer text placement | book/pf-pagestyle.sty:36-50 | `bg.tikzpagenodes` | `remember picture,overlay` nodes at `current page.south west/east`, xshift=±20pt, yshift=30pt and 23pt; text only, no shape drawn, so not ART |
| named page styles | book/pf-pagestyle.sty:52,55-99; book/pf-sections.sty:19,126,137; PF2e-TeX Spellbook.tex:27 | `hf.pagestyle-kernel` | `\fancypagestyle{plain}{}`, `{part}`, `{chapter}` (each of the last two defined twice, the later definition at :67 and :90 replaces the first); `\thispagestyle{part}`, `{chapter}`, `{empty}`, `{plain}` |
| page background picture | book/pf-pagestyle.sty:15-17,24-34,59,71,83,94 | `bg.eso-pic` | `\includegraphics[width=\paperwidth,height=\paperheight]{book/img/background}` on every page, odd and even (same effect as a shipout background picture) |
| cover page | book/pf-sections.sty:12-36; PF2e-TeX Spellbook.tex:51-55 | `front.titlepage-env` | hand-laid `center` page, `\thispagestyle{empty}`, key=value macro with image, logo, title, subtitle; reduces to the rows below |
| cover picture | book/pf-sections.sty:20-22,45-47 | `bg.eso-pic` | `\AddThispageHook` (`everypage`) + full-page `\includegraphics` of the cover image |
| cover logo | book/pf-sections.sty:14,24 | `fig.graphicx` | `\includegraphics[width=5in]{book/Paizo/Pathfinder-Second-Edition-Compatibility-Color}` |
| cover text effect | book/pf-sections.sty:28,32,80; book/pf-fonts.sty:112-123 | `mark.contour` | `\fillstroke{[1]}{[0]}{1.5}{...}` is PDF text rendering mode 2 (fill then stroke), stroke width 1.5 or 0.5, grey colours `[1]` and `[0]`; same type as `pdfrender`'s `\textpdfrender{TextRenderingMode=FillStroke,StrokeColor,LineWidth}` (ctan.org/pkg/pdfrender names no engine, so XeTeX use is not established) |
| cover spacing and case | book/pf-sections.sty:24,28,30 | `sp.manual-space` | `\vspace*{-15mm}`, `\vspace*{15mm}`, `\vfill`; `\MakeUppercase` is `mark.case` |
| splash header | book/pf-sections.sty:60-85; PF2e-TeX Spellbook.tex:73-78 | `fig.graphicx` | `figure*[h]`, `\makebox[\paperwidth][c]`, `\includegraphics[width=\paperwidth,height=15cm,keepaspectratio]`; offsets `\vspace*{-1.5cm}`, `\hspace*{-1.5cm}`, headerHeight=-7cm, textBodyHeight=4.5cm are `sp.manual-space` |
| copyright and licence page | PF2e-TeX Spellbook.tex:57-65; book/pf-license.sty:3-51 | `front.dedication` | text plus `\InsertORC` (a `tabularx{\linewidth}{lX}` of notice rows) and `\InsertOGL` (a long licence text, content) |
| licence table | book/pf-license.sty:43-50 | `tbl.tabularx` | `\begin{tabularx}{\linewidth}{ l X }`; rows printed when an argument is non-empty (`\ifthenelse{\equal{#2}{}}`, resolved by the emitter) |
| table of contents | PF2e-TeX Spellbook.tex:69 | `toc.kernel` | `\tableofcontents` |
| contents styling | book/pf-sections.sty:1,7-9 | `toc.tocloft` | `tocloft` option `titles`; no `\cft...` settings in the zip |
| contents in columns | book/pf-sections.sty:7-9; pf-book.sty:115-117 | `toc.etoc` | `multitoc` option `toc` (toggle default true) |
| part heading | book/pf-sections.sty:2,124-131 | `head.titlesec` | `\titleformat{\part}[display]`, format `\thispagestyle{part}\prociono\fontsize{50pt}{50pt}\selectfont\color{title1}\filcenter`, label `\partname \thepart`, sep -15pt, before `\Large`; `\titlespacing*{\part}{0pt}{-54pt}{0pt}`; option `newparttoc` |
| chapter heading | book/pf-sections.sty:135-141 | `head.titlesec` | `[display]`, format `\thispagestyle{chapter}\vspace{-80pt}\color{title1}\pfChapterFont`, label flushright uppercase `\chaptertitlename` + 50pt number, sep -1em, before `\Huge`, after `\titleline{\color{undergold}\titlerule[2pt]}\vspace{-30pt}` |
| section to subparagraph headings | book/pf-sections.sty:145-175 | `head.titlesec` | section `\LARGE`, colour title1, rule `\titlerule[0.5pt]` in undergold; subsection `\Large`, title2, rule in title2; subsubsection `\large`, title3; paragraph title3; subparagraph `[runin]` `\bfseries\slshape`, after `[.]`, `\titlespacing*{\subparagraph}{\parindent}{\parskip}{\wordsep}` |
| heading font macros | book/pf-fonts.sty:12-18 | `font.size-commands` | `\normalfont\scshape\Huge`, aliases `\pfChapterFont` ... `\pfParagraphFont` |
| section numbering depth | PF2e-TeX Spellbook.tex:34 | `num.secnumdepth` | secnumdepth=0 |
| subtitle section | book/pf-sections.sty:180-183 | `head.titlesec` | alias: `\subsubsection{#1}`, `\textit{#2}`, `\vspace{-1ex}` and `\vspace{1ex}` (`sp.manual-space`) |
| text faces | book/pf-fonts.sty:3,6,42-75,87-94 | `font.fontspec` | `\defaultfontfeatures{Ligatures=TeX}`, `\setmainfont{Manuale}` (Path=PF2e-Fonts/, UprightFont=*-Medium, BoldFont, ItalicFont, BoldItalicFont), `\newfontfamily` for LeagueGothic, Junction, Prociono, FiraSans, Alice, Pathfinder-Icons (Path=Paizo/, .ttf) |
| base font package | book/pf-fonts.sty:1 | `font.serif-pkg` | `bookman` (the main face is then set again by `\setmainfont`) |
| encoding | book/pf-fonts.sty:2; PF2e-TeX Spellbook.tex:9 | `font.fontenc-t1` | `fontenc` T1, `inputenc` utf8 |
| named NFSS families | book/pf-fonts.sty:20-23; pf-book.sty:174 | `font.nfss` | `\fontfamily{fosj}\selectfont`, `\fontfamily{lmss}\selectfont` (no file in the zip declares `fosj`) |
| box and table font macros | book/pf-fonts.sty:20-33 | `font.size-commands` | `\Large`, `\LARGE`, `\large`, `\footnotesize`, `\onehalfspacing` (`sp.setspace` loaded in pf-creature.sty:8) |
| colours | book/pf-colors.sty:1-59,65-82 | `color.xcolor` | `\definecolor{...}{HTML}{...}` (bgtan F7F2E5, title1 58180D, title2 0d2b58, title3 58390d, undergold C9AD6A ...), `\colorlet{themecolor}{commentgreen}`, `\setthemecolor` (colorlet calls); `xcolor` option `table` at pf-book.sty:21 |
| legacy colour package | book/pf-colors.sty:1 | `color.color` | `\RequirePackage{color}`, load only |
| generic box | book/pf-box.sty:27-41 | `box.tcolorbox` | `\newtcolorbox{pf-box}[2][]`: boxrule=1pt, toptitle=2mm, bottomtitle=2mm, left=8pt, right=8pt, arc=0mm, colback={#2!75!white}, colframe={#2!75!black}, colbacktitle, opacityback=0.5, fonttitle, fontupper; library `most` (pf-book.sty:34) |
| note, warning, suggestion boxes | book/pf-box.sty:44-61 | `box.tcolorbox` | aliases of `pf-box` with colours commentgreen, commentred, commentblue |
| stat-block boxes | book/pf-box.sty:6-24; book/pf-spell.sty:18-36; book/pf-creature.sty:11-29; book/pf-character.sty:12-33 | `box.tcolorbox` | enhanced, frame hidden, boxrule=0pt, breakable, boxsep=0pt, toptitle=3mm, left=0pt, right=0pt, arc=0mm, opacityback=0, colframe=title1, coltitle=creature or spell, `title={#2 \hfill #3}`, `before upper={\pfhline{}\\}` (ART, see blockers) |
| trait and rarity boxes | book/pf-traits.sty:27-44; book/pf-rarity.sty:4-13; book/pf-box.sty:283-288 | `box.tcolorbox` | `tcolorbox[hbox, sharp corners, height=7mm, valign=center, left*=2mm, right*=2mm, nobeforeafter]`, colours traitborder, traitbg, sizeColor, alignColor ...; `\tcbox[nobeforeafter,box align=base,size=fbox,height=0.6cm]` |
| framed environment | book/pf-box.sty:1,165,168 | `box.mdframed` | `framed` with `\MakeFramed`, `\FrameCommand` (carries the ART parchment drawing) |
| quotation | book/pf-box.sty:317-325 | `quote.kernel` | `quotation` with `\textit`; attribution in `flushright` (`sp.ragged`) with `\small` |
| inline emphasis | book/pf-box.sty:280-281; book/pf-actions.sty:24 | `mark.kernel` | `\textbf`, `\textit`, `\color{lightgrey}` via `color.xcolor`, `\footnotesize` |
| action and activity entries | book/pf-actions.sty:23-58,62-72 | `sp.lengths` | environments `pf-action` ... `pf-misc`: `\noindent\textbf{#1}\hspace{0.5em}`, `\hangindent=\baselineskip`; spacing is `sp.manual-space` |
| action glyphs | book/pf-actions.sty:13-17; book/pf-fonts.sty:36-40 | `font.fontspec` | `{\pfIcons\selectfont [one-action]}` ligature names of the Paizo icon font (font file not in the zip) |
| action icon images | book/pf-actions.sty:7-11; book/pf-art.sty:73-80 | `fig.graphicx` | `\raisebox{-0.2\dimexpr#1\baselineskip}{\includegraphics[height=#1\baselineskip,keepaspectratio]{...}}` (EPS, see EXTERNAL) |
| inline art, figure art | book/pf-art.sty:6-9,37-42 | `fig.graphicx` | `figurehere` sets `\@captype`; `\includegraphics[width=#1\linewidth]`, default 0.8 |
| wrapped art | book/pf-art.sty:44-69 | `fig.wrapfig` | `wrapfigure{l}` or `{r}` chosen by multicol's `\docolaction` (so `cols.multicol` option `colaction`), `\intextsep=-1ex`, `\columnsep=0em` |
| float placement fix | book/pf-art.sty:1-3; book/pf-sections.sty:5 | `fig.placement` | `dblfloatfix`; `float` is `fig.float`; `changepage[strict]` loaded |
| tables | book/pf-table.sty:32-56,58-78,128-151 | `tbl.tabularx` | `\tabularx{\linewidth}{#2}` and `\tabularx{\textwidth}{l\|c\|c\|c\|c\|c\|X}`; `\header` uses `\cellcolor` |
| table row colours | book/pf-table.sty:19,48,73,143 | `tbl.colortbl` | `\rowcolors{1}{tablecolor2}{tablecolor1}`; `\cellcolor{tabletitlebg}` |
| table captions | book/pf-table.sty:8,39-45,128-139 | `cap.caption` | `\captionsetup{margin=0pt, justification=raggedright, format=plain, singlelinecheck=false, font={pf@CaptionFont,color=tablecaption}}`, `\DeclareCaptionFont`; `\caption` is `cap.kernel`; `tablehere` sets `\@captype{table}` (same effect as `\captionof{table}`) |
| tabu weapon table | book/pf-table.sty:107-126 | `tbl.nicematrix` | `\tabu to \textwidth {l\|c\|c\|c\|c\|c\|X}`, `\taburowcolors[2]2{green!30 .. yellow!40}`, `\rowfont` (`tabu` is the parameter) |
| unused table packages | pf-book.sty:57 | `tbl.longtable` | `longtable` and `booktabs` (`tbl.booktabs`) loaded, no call |
| itemize setup | pf-book.sty:27,181-183; docs/actions.tex:13-19 | `list.enumitem` | `\setlist{leftmargin=1em}`, `\setitemize{noitemsep,topsep=0.5ex}`; bullet via `\renewcommand{\labelitemi}` (`list.kernel`) |
| image-label list | book/pf-list.sty:3-7 | `list.kernel` | `list` environment with `\includegraphics[scale=0.4]{book/img/weapons.png}` label (image not in the zip) |
| description paragraphs | pf-book.sty:125-128,60-61 | `sp.lengths` | `\noindent\hangindent=1ex\textbf{#1}~#2`; `\tightlist` sets itemsep=0pt, parskip=0pt |
| rules | book/pf-items.sty:101 | `sp.rule` | `\hrulefill` |
| hyperlinks | pf-book.sty:38 | `meta.hyperref` | `hyperref` option `hidelinks` |
| language | pf-book.sty:51; PF2e-TeX Spellbook.tex:8; book/pf-strings-captions.sty:2-25 | `lang.babel` | `babel` english; `\addto\captionsfrench{...}` string overrides |
| quotation marks | pf-book.sty:58 | `lang.csquotes` | `csquotes`, load only |
| string constants | book/pf-strings.sty:5-40,46-51 | `lang.babel` | `\newcommand\perceptionname{Perception}` ...; `\@ifpackageloaded{babel}` always true (pf-book.sty:51) |
| symbols package | book/pf-sections.sty:3 | `math.amssymb` | `amssymb`, load only |
| filler text | PF2e-TeX Spellbook.tex:12,61; docs/sections.tex:40-63 | `draft.todo` | `\lipsum[1-5]` |
| source display | docs/actions.tex:39-43; docs/sections.tex:12-18; PF2e-TeX Spellbook.tex:15 | `code.verbatim` | `verbatim`, `\verb`; `\showmacro` is `\string#1 #1` (an alias) |
| sub-file inclusion | PF2e-TeX Spellbook.tex:101-102 | `struct.input` | `\include{docs/actions}`, `\include{docs/sections}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\pfhline` | pf-book.sty:187-195 | No (ART) | tikz line with a 0.05 rise; a `\rule` would change the shape |
| parchment, torn paper, titlebox, examplebox, quotebox drawings | book/pf-box.sty:63-84,95-168,181-250,254-278,290-310 | No (ART) | raw TikZ/pgf paths and a custom decoration |
| `\pfBigArt` | book/pf-art.sty:12-35 | No | hand-rolled page-offset arithmetic |
| `\ifcommandkey` re-implementation | pf-book.sty:198-212 | No | catcode trick on `keycommand` internals; only needed by the key conditionals below |
| `\basics`, `\pfspellheader`, `\itemBasics`, `\degreeSuccess` | book/pf-creature.sty:48-121; book/pf-spell.sty:53-83; book/pf-items.sty:84-119 | Layout yes, conditionals no | the printed lines are `\textbf`, `\\`, `\nolinebreak`, `\pfhline` (`mark.kernel`, `sp.manual-space`); the field-presence guards are zip-local logic, counted irreducible (blocker) |
| `\renewcommand\chapter` | PF2e-TeX Spellbook.tex:26-31 | No | kernel-internal redefinition |
| `\fillstroke` | book/pf-fonts.sty:112-123 | Yes, with caveat | `mark.contour` (`pdfrender` FillStroke); XeTeX support of that package not established |
| `\pfMakeCover`, `\pfMakeLogoCover`, `\pfMakeSplashHeader` | book/pf-sections.sty:12-85 | Yes | `front.titlepage-env` + `bg.eso-pic` + `fig.graphicx` + `mark.contour` + `mark.case` + `sp.manual-space` + `pgnum.pagenumbering` with the key values as parameters |
| `\subtitlesection` | book/pf-sections.sty:180-183 | Yes | alias of `head.titlesec` command, `mark.kernel`, `sp.manual-space` |
| `\pfArt`, `\pfInlineArt`, `\pfWrapArt`, `figurehere` | book/pf-art.sty:6-9,37-80 | Yes | `fig.graphicx`, `fig.wrapfig` with `cols.multicol` `\docolaction` |
| `pf-table`, `pf-table*`, `pf-weapontable`, `tablehere`, `\tableheader`, `\header` | book/pf-table.sty:12-56,58-78,128-151 | Yes | `tbl.tabularx`, `tbl.colortbl`, `cap.caption` |
| box aliases, `\metatrait` family, `\pf@rarityBox`, `pf@charoption` | book/pf-box.sty:27-61,280-288; book/pf-traits.sty:27-77; book/pf-rarity.sty:4-23; book/pf-character.sty:12-56 | Yes | `box.tcolorbox` key lists (rarity file uses undefined colour `common`, :9) |
| action environments and commands | book/pf-actions.sty:7-72 | Yes | `sp.lengths`, `sp.manual-space`, `mark.kernel`, `font.fontspec` |
| `\setthemecolor` | book/pf-colors.sty:77-82 | Yes | `color.xcolor` `\colorlet` calls |
| option processing (`bg`, `justified`, `nomultitoc`) | pf-book.sty:67-121 | Yes | xkeyval internals set toggles; only `multitoc` is read, so the emitter prints `multitoc` or not |
| `\pf@deprecate` | pf-book.sty:43-45 | Yes | warning only, no printed output |
| `\showmacro`, `showenvironment` | PF2e-TeX Spellbook.tex:15-22 | Yes | `\showmacro` is an alias; `showenvironment` is unused |
| string macros, `\InsertOGL`, `\InsertORC` | book/pf-strings.sty:5-40; book/pf-license.sty:3-51 | Yes | constants and a `tbl.tabularx` table |

## Content-opaque
none that adds a blocker. The cover and splash pictures (ai-generated-cover-art.jpeg, ai-generated-splash.jpg), the page background (book/img/background.jpg) and the action SVG/EPS files are shipped image assets. Missing assets: `Pathfinder-Icons.ttf` (readme.md:20-22,33; book/pf-fonts.sty:36-40), `book/img/weapons.png` (book/pf-list.sty:4); the fonts are expected in a texmf path, not at the `Path=PF2e-Fonts/` given relative to the zip root (readme.md:29-33). No text addressed to an AI was found in the files read.

## Lib changes
- New ways proposed: none (considered: `keycommand`, `xstring`, `fp`, `ifthen`, `xparse`, `xkeyval`, `ifluatex` as macro-writing helpers, which are not a document component and need zip-local macros to be used)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
