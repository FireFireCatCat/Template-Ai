no

# 0347-rpgtex-dnd-5e-latex-template: rpgtex DnD 5e LaTeX Template (class `dndbook`, v0.8.0 dev branch)

- Unverified: read from the source, not compiled.
- Source: Source/0347-rpgtex-dnd-5e-latex-template/ (origin: https://codeload.github.com/rpgtex/DND-5e-LaTeX-Template/zip/refs/heads/dev; licence: MIT)
- Kind: book
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:12 says pdfTeX, LuaTeX and XeTeX work; Makefile:3 defaults to `pdflatex`; `luacolor` is loaded only under LuaTeX, dndcore.def:23-26)
- Look carried by: zip-local (`dndbook.cls`, `dndcore.def` and `lib/*.sty` define the look; the sample preamble only adds caption and listings settings, example.tex:18-32)
- Class origin: zip-local (`ctan.org/pkg/dnd` and `ctan.org/pkg/dndbook` both returned 404; the zip is the GitHub `dev` branch archive, not a tagged release; `\LoadClass{book}` at dndbook.cls:9)
- Main file: example.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (`lib/dnddeprecated.sty` is not loaded by the sample, see below; the 8 files in `lib/languages/` were checked line by line for anything but `\addto\captions<lang>{\renewcommand...name}` lines: none)

## Verdict
No. The look of `dndbook` is mostly published packages (`book`, `geometry`, `titlesec`, `titletoc`, `tocloft`, `fancyhdr`, `tcolorbox`, `enumitem`, `lettrine`, `contour`) and reduces cleanly. It is blocked by two things. First, the stat-block and dice machinery is expl3 code that computes printed text (dice averages, ability modifiers, challenge-rating to XP and proficiency-bonus tables, attack sentences with `|1|` placeholder substitution), plus a word-splitting `\DndContour`. Second, three TikZ ornaments are part of the template's identity: the tapered stat-block rule, the sidebar corner triangles and the read-aloud corner dots.

## Blockers
- `BESPOKE/class` `\DndDice`: regex parse of a dice string and `\fp_eval:n` average, printed as `13 (3d8 + 3)` (lib/dndutility.sty:10, 20-49); called in the body at example.tex:159, 213, 228, 230, 242
- `BESPOKE/class` ability-score modifier computed with `\fp_eval:n` and a regex test, printed in a 6-column table (lib/dndmonster.sty:360-373, 404-425; body example.tex:163-170)
- `BESPOKE/class` challenge-rating to XP and to proficiency-bonus lookup tables, `\numprint`-formatted, driving the printed "Challenge" and "Proficiency Bonus" lines (lib/dndmonster.sty:3-44, 187-240, 245-287, 324-345; body example.tex:181-182)
- `BESPOKE/class` attack sentence assembly from keys (distance, type, reach/range, `dmg`, `plus-dmg`, `or-dmg`, `extra`) with conditionals and the `|1|` placeholder substitution `\__dnd_caption:nn` (lib/dndmonster.sty:525-654; lib/dndstrings.sty:7-19; body example.tex:205-249)
- `BESPOKE/class` `\DndContour`: splits a heading on `\newline` and on spaces and wraps every word in `\contour`, so the outline can break across lines (lib/dndfonts.sty:332-348); used by every `\part` and `\chapter` heading (lib/dndsections.sty:23-25, 30-32)
- `ART/class` stat-block rule `\DndMonsterLine`: a filled tapered triangle drawn with TikZ, no declarative way (lib/dndmonster.sty:123-130); called by `\DndMonsterBasics` and `\DndMonsterDetails` (lib/dndmonster.sty:178, 180, 351, 353)
- `ART/class` sidebar corner triangles: four `\fill` paths in the tcolorbox `overlay` (lib/dndsidebar.sty:37-43)
- `ART/class` read-aloud corner dots: `\foreach` circles in the tcolorbox `overlay` (lib/dndreadaloud.sty:35-39)

## Class setting
- Class: `class.book` (wrapped by the zip-local `dndbook`, which is `\LoadClass{book}` plus `\input{dndcore.def}`, dndbook.cls:9, 11). Options used: `letterpaper`, `twocolumn`, `openany` (example.tex:1); class-native options `nodeprecatedcode` (example.tex:1), also `bg=full|print|none`, `justified`, `nomultitoc`; unknown options go to `book` (dndoptions.clo:43-107). `dnd.sty` is the same code as a package and is not used by the sample.
- Class-native vocabulary used: from `book`: `\frontmatter`, `\mainmatter`, `\part`, `\chapter`, `\maketitle`, `\tableofcontents` (example.tex:41-51). Zip-local (not published): `\DndDropCapLine`, `\DndFeatHeader`, `\DndItemHeader`, `\DndSpellHeader`, `\DndArea`, `\DndSubArea`, `DndReadAloud`, `DndComment`, `DndSidebar`, `DndTable`, `DndMonster` with `\DndMonsterType`, `\DndMonsterBasics`, `\DndMonsterAbilityScores`, `\DndMonsterDetails`, `\DndMonsterAction`, `\DndMonsterSection`, `DndMonsterSpells`, `\DndInnateSpellLevel`, `\DndMonsterSpellLevel`, `\DndMonsterAttack`, `\DndMonsterMelee`, `\DndMonsterRanged`, `DndMonsterLegendaryActions`, `\DndDice`, `\DndSetThemeColor`, `\DndFontTableTitle` (example.tex:53-259, 270, 338, 351).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | dndbook.cls:9; example.tex:1 | `class.book` | `letterpaper`, `twocolumn`, `openany` |
| paper and columns | example.tex:1 | `page.class-options`, `cols.twocolumn-option` | `letterpaper`; `twocolumn` |
| page geometry | dndcore.def:40-47 | `page.geometry` | `hmargin=.75in`, `top=.46in`, `bottom=.8in`, `footskip=.32in`, `columnsep=.33in` |
| stat block in two columns | example.tex:153, 260 | `cols.multicol` | `{2}` inside the stat-block box |
| full-width bottom float | example.tex:22, 269 | `cols.cuted` | `stfloats`; `table*[b]` |
| multi-column contents | dndcore.def:36-37 | `toc.etoc` | option `toc`; skipped by `nomultitoc` (dndoptions.clo:78-83) |
| paragraph lengths | dndcore.def:50-52 | `sp.lengths` | `\parindent=1em`, `\RaggedRightRightskip=0pt plus 1em`, `\RaggedRightParindent=\parindent` |
| ragged right unless `justified` | dndcore.def:32, 61-62; dndoptions.clo:65-69 | `sp.ragged` | `ragged2e` `\RaggedRight` |
| line-break tolerance | dndcore.def:55-56 | `sp.hyphenat` | `\tolerance=1`, `\emergencystretch=\maxdimen` (the two parameters `\sloppy` sets) |
| no hyphenation | dndcore.def:57-58 | `sp.penalties` | `\hyphenpenalty=10000`, `\hbadness=10000` (the latter is an integer diagnostic parameter, filed here as the nearest family) |
| microtype | dndcore.def:31 | `sp.microtype` | no options |
| body text face | dndfonts.sty:12 | `font.serif-pkg` | `bookman` (psnfss), no options |
| sans text face | dndfonts.sty:13-14, 16, 19-24 | `font.helvet` | `gillius2[type1]` (switch `\gilliustwo`), `kpfonts[notext,nomath,nott]` kept for its sans, `\sfdefault=jkpss` |
| encoding | dndfonts.sty:15; example.tex:17 | `font.fontenc-t1` | `fontenc[T1]`, `inputenc[utf8]` |
| default sans family | dndfonts.sty:16 | `font.family-default` | `\renewcommand{\sfdefault}{jkpss}` |
| drop-cap face | dndfonts.sty:7, 211-213, 309-310 | `font.display` | package `Royal`, switch `\Royal` through `\LettrineFontHook` |
| degree and text symbols | dndcore.def:14 | `font.icons` | `gensymb` (`textcomp` with it) |
| font sizes per element | dndfonts.sty:36-208 | `font.size-commands` | `\Huge`, `\huge`, `\Large`, `\large`, `\LARGE`, `\small`, `\scriptsize` per element |
| shapes per element | dndfonts.sty:36-208 | `mark.kernel` | `\scshape`, `\bfseries`, `\slshape`, `\sffamily`, `\normalfont` |
| line spread per element | dndfonts.sty:43, 50, 57, 64; dndcomment.sty:17; dndreadaloud.sty:17 | `sp.linespread` | `\linespread{.9}`; `{1.1}` in read-aloud |
| colours | dndcolors.sty:8-46; dndcore.def:8, 20 | `color.xcolor` | `\definecolor` HTML: `titlered 58180D`, `titlegold C9AD6A`, `pagegold B89A67`, `bgtan F7F2E5`, `statblockbg FDF1DC`, `PhbLightGreen E0E5C1` ...; `\colorlet` themed aliases; `table` option |
| theme colour macro | dndcolors.sty:50-56; example.tex:338, 351 | `color.xcolor` | four `\colorlet` lines, reducible (see Bespoke code) |
| page background image | dndheader.sty:37-44 | `bg.eso-pic` | `img/paper` (jpg) at `\paperwidth` by `\paperheight`, centred on every page; off for `bg=print|none` |
| footer scroll image | dndheader.sty:47-66 | `bg.eso-pic` | `img/footerscroll` (pdf), height `.6in`, page width, bottom of page, mirrored on even pages (`xscale=-1`), `nearly opaque` |
| footer scroll opacity and mirror | dndheader.sty:51, 62 | `color.transparent`, `fig.graphicx`, `fig.rotating` | opacity about 0.9; `\includegraphics`; reflection |
| header and footer | dndheader.sty:8, 11, 31-34, 47-72 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\headrulewidth=0pt`, `\footrulewidth=0pt`, `LE`/`RO` foot = `\DndFontFooter\leftmark` |
| running mark | dndheader.sty:13-29 | `hf.fancyhdr` | `\chaptermark` redefined to `\markboth{\MakeUppercase{...}}{}` |
| page number | dndheader.sty:53, 64; dndfonts.sty:203-208 | `bg.eso-pic` | `\thepage` at the page's bottom corners, offsets `.28in`, `.39in`; `\scriptsize` colour `pagegold` |
| float spacing | dndsections.sty:9-11 | `fig.placement` | `\textfloatsep`, `\intextsep`, `\dbltextfloatsep` = `11pt plus 4pt minus 4pt` |
| part numbering | dndsections.sty:6 | `num.counters` | `\renewcommand{\thepart}{\arabic{part}}` |
| numbering depth | dndsections.sty:14; dndtoc.sty:8 | `num.secnumdepth` | `secnumdepth=0`, `tocdepth=1` |
| headings | dndsections.sty:20-100; dndcore.def:34 | `head.titlesec` | `\titleformat` and `\titlespacing*` for part (display, centred), chapter, section, subsection (gold `\titlerule[1pt]` after), subsubsection, paragraph and subparagraph (run-in, `[.]`); `titlesec[newparttoc]`; colours/fonts via `\DndFont...` |
| sample headings | example.tex:49-68 | `head.titlesec` | `\part` `\chapter` `\section` ... `\subparagraph` |
| contents | example.tex:45; dndcore.def:33; dndtoc.sty:5-30 | `toc.kernel`, `toc.tocloft`, `toc.titletoc` | `tocloft[titles]`; `\titlecontents` for part, chapter (dot leaders `\titlerule*{.}`), section |
| appendix toc label | dndtoc.sty:32-36 | `num.appendix` | `\g@addto@macro\appendix{\addtocontents{toc}{...\@chapapp...}}` (not exercised by the sample) |
| title block | example.tex:34-37, 43 | `front.maketitle` | `\title{... \\ \large ...}`, `\author`, `\date`; `book` default `\maketitle` |
| drop cap | dndfonts.sty:316-327; example.tex:53 | `sp.lettrine` | `lines=4`, `depth=0`, `findent=<width of a space>`, `nindent=0pt` |
| outlined heading words | dndfonts.sty:8, 332-348 | `mark.contour` | `contour[auto]`, colour `contourgray CACCBE`; the wrapper is bespoke |
| lists | dndcore.def:12, 65-66; example.tex:76-79 | `list.enumitem`, `list.kernel` | `\setlist{leftmargin=1em}`, `\setitemize{noitemsep,topsep=0.5ex,label=\footnotesize{\textbullet}}` |
| inline marks | example.tex:73, 82 | `mark.kernel` | `\textit`, `\textbf`, `\emph`, `\textsl` |
| hanging paragraph | dndcore.def:15; dndmonster.sty:117-119 | `sp.lengths` | `hang` package, `hangingpar` env around `\textit{type line}` |
| comment box | dndcomment.sty:7-37, 59-78; example.tex:129-131 | `box.tcolorbox` | `frame hidden`, `boxrule=0pt`, `breakable`, `enhanced`, `sharp corners`, `before/after skip=13pt plus 4pt minus 4pt`, `left=right=6pt`, `boxsep=3pt`, `toptitle=2pt`, `colback=colbacktitle=commentcolor`, `coltitle=black` |
| sidebar box | dndsidebar.sty:7-46, 68-87; example.tex:135-137 | `box.tcolorbox` | `borderline north/south={1pt}{-0.5pt}{black}`, `fuzzy shadow={0mm}{-3.5pt}{-0.5pt}{0.4mm}{black!60!white}`, `after skip=14pt plus 4pt minus 4pt`, key `float=!b` in the sample |
| sidebar corner triangles | dndsidebar.sty:37-43 | `art.tikz` | four filled 7pt by 5pt triangles at the frame corners (ART) |
| read-aloud box | dndreadaloud.sty:7-42, 63-80; example.tex:122-124 | `box.tcolorbox` | `enhanced jigsaw`, `breakable`, `boxsep=8pt`, `borderline west/east={1pt}{-0.5pt}{titlered}`, `colback=readaloudcolor` |
| read-aloud corner dots | dndreadaloud.sty:35-39 | `art.tikz` | `\foreach` over 4 frame corners, `circle (1.5pt)` filled `titlered` (ART) |
| stat-block box | dndmonster.sty:50-112; example.tex:152 | `box.tcolorbox` | `DndMonsterBg`: `borderline north/south` 3pt `titlered` plus 2pt `statblockribbon E69A28`, `colback=statblockbg FDF1DC`, `top=0pt`, `bottom=7pt`, `toptitle=8pt`; `DndMonsterNoBg`: `opacityback=0`; sample keys `float*=b`, `width=\textwidth + 8pt` |
| stat-block rule | dndmonster.sty:123-130 | `art.tikz` | filled wedge `(0,0)--(0,0.1)--(\linewidth,0.05)` in `rulered 9C2B1B` (ART) |
| stat-block attribute lists | dndmonster.sty:133-140, 459-466, 658-665 | `list.enumitem` | `\newlist{...}{description}{1}`, `\setlist[...]{before=\color{titlered}, font=\DndFontStatBlockBody, labelsep=<space width>, nosep}` |
| stat-block section rule | dndmonster.sty:436-456 | `sp.rule` | `\hrule height 0.6pt`; `\rule{0pt}{3.7mm}` at :409 |
| stat-block text values | dndmonster.sty:3-44, 187-287, 360-373, 525-654; dndutility.sty:20-49 | none (BESPOKE) | dice average, modifier, XP, PB, attack sentence |
| thousands separator | dndcore.def:16; dndmonster.sty:15-41, 238 | `mark.siunitx` | `numprint[autolanguage]`, `\numprint{1100}` |
| spacing and skips | dndmonster.sty:446-455; dndsections.sty:112, 123; dndtable.sty:37, 43, 63 | `sp.manual-space`, `pg.break` | `\vspace`, `\addvspace`, `\smallskip`, `\nopagebreak[4]` |
| tables | dndtable.sty:29-66; example.tex:142-147 | `tbl.tabularx` | `tabularx{\linewidth}{<spec>}`; optional `width` and `header` (title above in `\DndFontTableTitle`) |
| banded rows and header colours | dndtable.sty:49; example.tex:274 | `tbl.colortbl` | `\rowcolors{1}{}{tablecolor}`; `\rowcolor{PhbLightGreen}` etc. |
| column types | dndtable.sty:4-6; dndcore.def:10 | `tbl.tabular` | `\newcolumntype{Y}{>{\centering\arraybackslash}X}` (array) |
| caption setup | example.tex:18, 24, 270 | `cap.caption`, `cap.kernel` | `caption[singlelinecheck=false]`; `\captionsetup[table]{labelformat=empty, font={sf,sc,bf}, skip=0pt}`; `\caption{...}` and `\label{tab:colors}` |
| cross-reference | example.tex:270, 305; dndsections.sty:199, 234 | `xref.kernel` | `\label`, `\ref`, `\pageref` |
| code listings | example.tex:20, 28-32, 307-319 | `code.listings` | `basicstyle=\ttfamily`, `language=[LaTeX]{TeX}`, `breaklines=true` |
| short verbatim | example.tex:21, 26 | `code.verbatim` | `shortvrb` `\MakeShortVerb{|}` |
| language | example.tex:12; dndstrings.sty:117-143; lib/languages/*.sty | `lang.babel` | `babel[english]`; string macros overridden per language through `\addto\captions<lang>{\renewcommand...name}` (7 languages) |
| draft text | example.tex:19 | `draft.todo` | `lipsum` loaded, `\lipsum` never called in the sample |
| picture package | dndcore.def:19 | `art.tikz` | `tikz` loaded unconditionally (used only by the three ART items and the page overlays) |
| abstract, bibliography, index, theorems, figures, footnotes, math | (none in the sample or the class) | not used | the template defines none |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `dndbook` class and option keys | dndbook.cls:1-11; dndoptions.clo:43-130 | yes | `class.book` options plus the preamble below; the booleans (`bg`, `justified`, `nomultitoc`, `nodeprecatedcode`) are resolved by the emitter into one fixed preamble |
| layout block | dndcore.def:28-67 | yes | published packages only: `page.geometry`, `sp.lengths`, `sp.ragged`, `sp.hyphenat`, `sp.penalties`, `sp.microtype`, `list.enumitem`, `toc.tocloft`, `head.titlesec`, `toc.etoc` |
| `\DndSetThemeColor` | dndcolors.sty:50-56 | yes | one `\newcommand` alias of four `\colorlet` calls, or the four `\colorlet` lines emitted in a group |
| font key interface `\DndSetFonts`, `\DndFont...` | dndfonts.sty:26-304 | yes | `\newcommand` aliases of `font.size-commands`, `mark.kernel`, `sp.linespread`, `color.xcolor` switches; the sample never calls `\DndSetFonts` |
| `\DndDropCapLine` | dndfonts.sty:316-327 | yes | `sp.lettrine` with the parameters in the map |
| `\DndContour` | dndfonts.sty:332-348 | no | `seq_set_split` on `\newline` and spaces, per-word `\contour`: token-list code that drives the printed heading; `mark.contour` alone cannot break across lines. `BESPOKE/class` |
| `\DndDice` | dndutility.sty:10, 20-49 | no | regex plus `\fp_eval:n` computing a printed average. `BESPOKE/class` |
| space-width length | dndutility.sty:53-56 | yes | a length used as `labelsep`; `sp.lengths` (about one interword space of the font loaded at that point) |
| key-required check | dndutility.sty:66-74 | yes | an error message only, no output |
| ability modifier | dndmonster.sty:360-373 | no | regex plus `\fp_eval:n` floor. `BESPOKE/class` |
| CR to XP and PB tables, `\DndCRExp` | dndmonster.sty:3-44, 187-287 | no | `\str_case_e:nnTF` tables, `\numprint`-formatted. `BESPOKE/class` |
| attack and spell-level text, `|1|` captions | dndmonster.sty:468-522, 525-654; dndstrings.sty:7-19 | no | conditional sentence assembly with placeholder substitution into localised strings. `BESPOKE/class` |
| monster key commands (`Basics`, `Details`, `AbilityScores`) | dndmonster.sty:150-182, 290-355, 375-433 | no | `l3keys` interface that prints a line only when its key is set; the layout itself (description lists, table) reduces, the computed values do not |
| `DndMonsterLine`, sidebar and read-aloud ornaments | dndmonster.sty:123-130; dndsidebar.sty:37-43; dndreadaloud.sty:35-39 | no | TikZ drawings of the template's identity. `ART/class` |
| `DndComment`, `DndSidebar`, `DndReadAloud`, `DndMonster` wrappers (custom `color` key, `keys_set_known`) | dndcomment.sty:40-78; dndsidebar.sty:49-87; dndreadaloud.sty:45-80; dndmonster.sty:50-112 | yes, except the ornaments | each is `\DeclareTColorBox` plus one colour key: a `box.tcolorbox` style with the parameters in the map; the `bg` option picks `DndMonsterBg` or `DndMonsterNoBg` (dndmonster.sty:105-112) |
| `DndTable` | dndtable.sty:4-66 | yes | `tbl.tabularx` at `\linewidth`, `\rowcolors{1}{}{tablecolor}` (`tbl.colortbl`), title line above, first row in the sans bold header font: the regex and `\currentrowstyle` trick (dndtable.sty:9-14, 51-55) only restyles the first row, which an emitter writes cell by cell |
| `\DndArea`, `\DndSubArea`, refs | dndsections.sty:156-244 | yes | `\newcounter`, `\refstepcounter`, `\label`, `\pageref` (`num.counters`, `xref.kernel`) and a `\section`..`\paragraph` call (`head.titlesec`) with the number written in the heading text, level chosen at emit time |
| `\DndFeatHeader`, `\DndItemHeader`, `\DndSpellHeader` | dndsections.sty:106-150 | yes | `\subsection` or `\subsubsection`, `\textit{...}`, `\vspace{3pt}`, an `enumitem` description list with `labelsep=<space>` |
| language loader | dndstrings.sty:117-143 | yes | the string macros live in the class (dndstrings.sty:29-104); the per-language files only override them under `lang.babel`; the `\AtEndPreamble` conditional is loader plumbing |
| `\appendix` patch | dndtoc.sty:32-36 | yes, with doubt | emit `\appendix` then `\addtocontents{toc}{\protect\renewcommand{\protect\tocchapapp}{\appendixname}}`; the `\@chapapp` patch is kernel-internal, and the sample never calls `\appendix` |
| compat shim | compat.sty:7-14 | yes | a one-line alias for an old expl3 name; no output |
| deprecated aliases | dndcore.def:79-80; lib/dnddeprecated.sty (all 620 lines read) | not loaded | skipped by `nodeprecatedcode` (example.tex:1); when loaded it re-implements `\dice` and `\stat` with `fp`/`xstring` and loads `keycommand` (dnddeprecated.sty:1, 104-105, 108-141), the same irreducible logic as `\DndDice` |
| LuaTeX branch | dndcore.def:23-26 | yes | `luacolor` loaded only under LuaTeX; not needed under pdfTeX (considered: `luacolor`, no way proposed) |
| build tooling | Makefile:3, 13-14; img/Makefile:10-11; bin/bump-version | n/a | `latexmk` is a build driver; `inkscape` made `img/footerscroll.pdf` from `img/src/footerscroll.svg`, and the PDF is shipped, so not EXTERNAL for the compile |

## Content-opaque
none (the `lstlisting` blocks at example.tex:307-319 and 336-348 are code text, content; the page-background and footer images `img/paper.jpg`, `img/footerscroll.pdf` are shipped assets)

## Lib changes
- New ways proposed:
  - `toc.etoc` `multitoc` (CTAN, TeX Live; not read here, from knowledge), pdfLaTeX. Typesets the contents list in columns; load option `toc` (dndcore.def:37). W1 CTAN package; W2 load options; W3 any class; W4 one `\usepackage` line. Not `toc.etoc` (etoc/minitoc/tocbibind) and not `cols.multicol` (an environment for body text).
  - `mark.siunitx` `numprint` (CTAN), pdfLaTeX. Prints numbers with a language-dependent thousands separator: `\usepackage[autolanguage]{numprint}` and inline `\numprint{1100}` (dndcore.def:16; dndmonster.sty:15-41). W1 CTAN; W2 options and separator strings; W3 any number; W4 package line plus inline wrapper. Not `mark.siunitx` (units and numbers through `\num`, a different package); the consolidator may fold it into `mark.siunitx` as "number-printing package is the parameter".
  - `sp.lengths` `hang` (CTAN, Andreas Nolda, v2.1, LPPL: "environments for hanging paragraphs and list items", read at ctan.org/pkg/hang), pdfLaTeX. Used as `\begin{hangingpar}...\end{hangingpar}` (dndmonster.sty:117-119). W1 CTAN; W3 any paragraph; W4 body wrapper. W2 is not established: the sample passes no argument and the package manual was not read. Fallback if W2 fails: raw `\hangindent` and `\hangafter` under `sp.lengths`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
