no

# 0654-luatexja: LuaTeX-ja bundle (Japanese typesetting for Lua(La)TeX), read through its luatexja-ruby manual

- Unverified: read from the source, not compiled.
- Source: Source/0654-luatexja/ (origin: https://mirrors.ctan.org/macros/luatex/generic/luatexja.zip; licence: modified BSD, README:4 and COPYING)
- Kind: misc (the zip is the luatexja package bundle; its only full LaTeX documents are two package manuals)
- Lib: v5
- Engine: needs LuaLaTeX (src/luatexja-core.sty:78-80 stops with "requires Lua(HB)(La)TeX" when `\directlua` is missing; the sample starts `%#! lualatex`, doc/luatexja-ruby.tex:1; it loads `luatexja-fontspec`, `lua-ul`, `luacolor`, `unicode-math`, 6-12 and 24)
- Look carried by: mixed (class `ltjsarticle` gives page size, headings, title, abstract, captions and page foot; the sample preamble sets fonts, geometry, colours, link style and a set of sample-local macros)
- Class origin: ctan (the zip is the CTAN release of luatexja, ctan.org/pkg/luatexja read: TeX Live and MiKTeX, BSD-style; `\ProvidesClass{ltjsarticle}` is at src/ltjsclasses.dtx:39; only the `.dtx` and `.ins` sources are in the zip, no generated `.cls`)
- Main file: doc/luatexja-ruby.tex (other samples: doc/lltjp-geometry.tex, the manual of a geometry patch; the `.dtx` drivers src/ltjclasses.dtx, src/ltjltxdoc.dtx and doc/luatexja.dtx were not analysed as samples)
- Read: main yes (all 1246 lines), zip-local classes and styles partly (in full: src/luatexja.sty, src/ltj-latex.sty, src/addons/luatexja-ruby.sty, src/addons/luatexja-fontspec.sty, src/addons/luatexja-otf.sty, src/patches/lltjdefs.sty, doc/jfm-ujisc33.lua, and the second sample doc/lltjp-geometry.tex; in part: src/ltjsclasses.dtx 1760-1815, 2296-2341, 2600-2650, 2684-2710, 3725-3855, 4140-4215, 4660-4710 plus a grep outline; src/luatexja-core.sty 55-270 plus greps; src/addons/luatexja-preset.sty 330-400 and 636-715 plus grep; src/patches/lltjp-geometry.sty by grep. Not read: src/ltjclasses.dtx, src/ltjltxdoc.dtx, doc/luatexja.dtx, lltjext.sty, lltjfont.sty, lltjcore.sty, ltj-base.sty, luatexja-compat.sty, luatexja-ajmacros.sty, luatexja-fontspec-29e.sty, the other lltjp-* patches, all Lua files except doc/jfm-ujisc33.lua, tool/)

## Verdict
No. The look of the sample is a published class (`ltjsarticle`, from the luatexja bundle on CTAN) plus published packages, and each maps to a lib way (two new ways are proposed: `lang.cjk` for luatexja-ruby and `code.showexpl` for `LTXexample`). But the sample's own preamble carries five hand-written macros that no lib way expresses: a node-box macro built on `\halign` (borderline), an `\@ifnextchar` dispatcher that draws boxes from `\vrule`s, a `\loop` that draws a ruler, a font-family test that redraws `\_`, and a copy of a hyperref internal. The luatexja Lua code (JFM glue, ruby line breaking) is published package code and is treated as the way itself, not as a blocker; nothing in `src/` calls an outside program (grep for `os.execute`, `io.popen`, `shell_escape`, `write18` finds nothing).

## Blockers
- `BESPOKE/preamble` `\HyRef@autoref` of hyperref is replaced by a copy that adds `\eghostguarded{}` after each reference (doc/luatexja-ruby.tex:63-68)
- `BESPOKE/preamble` `\mybox` dispatches on `\@ifnextchar` for `(`, `)`, `=` and draws `\fcolorbox` boxes with `\vrule` widths from `\dimexpr` and `\ifnum` tests (doc/luatexja-ruby.tex:74-80; used in `\@for` loops at 423, 427, 433, 441, 442)
- `BESPOKE/preamble` `\RULER` draws 20 `\vrule`s in a `\loop` with the hand counter `\@tempcnta` (doc/luatexja-ruby.tex:82-91; used at 1181, 1193)
- `BESPOKE/preamble` `\_` is redefined with the test `\ifx\f@family\ttdefault` and a drawn `\hrule` (doc/luatexja-ruby.tex:58-60)
- `BESPOKE/preamble` `\Node` draws a two-row box with `\halign` inside `\vcenter` and a `\noalign` rule, used for node diagrams (doc/luatexja-ruby.tex:47-50; used at 761-767, 796-809, 863-867, 879-915); borderline, see the Bespoke table, and the four items above decide the verdict without it

## Class setting
- Class: `class.ltjsarticle` options: `a4paper`, `10ptj` (doc/luatexja-ruby.tex:3; `\DeclareOption{a4paper}` at src/ltjsclasses.dtx:289, `\DeclareOption{10ptj}` at 394, which sets `\jsc@magscale` to 1.085). The class is a luatexja port of the jsclasses family (`\ExecuteOptions{a4paper,oneside,onecolumn,notitlepage,final}` at 705 for the article) and loads `luatexja` (193).
- Class-native vocabulary used: `\headfont` (class hook, default `\gtfamily\sffamily` at src/ltjsclasses.dtx:1484, set in the sample at doc/luatexja-ruby.tex:16); the units `\zw` and `\zh` (src/luatexja-core.sty:259-260); `\textgt` (src/patches/lltjdefs.sty:72); `\kanjifamily`, `\kanjiseries` (main:1116); `\inhibitglue` (core.sty:287); `\ltjsetparameter` (core.sty:459); `\title` `\author` `\date` `\maketitle`; `abstract`, `quote`, `description`, `figure`, `table`; `\section` `\subsection` `\paragraph` `\subparagraph`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/luatexja-ruby.tex:3 | `class.ltjsarticle` | a4paper, 10ptj |
| paper and base size | doc/luatexja-ruby.tex:3; src/ltjsclasses.dtx:289, 394 | `page.class-options` | a4paper, 10ptj |
| class default text block | src/ltjsclasses.dtx:1766-1774 | `page.class-options` | `\fullwidth` 0.76\paperwidth rounded to whole `\zw`; overridden by geometry at main:18 |
| page geometry | doc/luatexja-ruby.tex:18 | `page.geometry` | textwidth=45\zw, lines=45, footskip=2\zh (units from luatexja); the luatexja patch of geometry (src/ltj-latex.sty:99, src/patches/lltjp-geometry.sty:6) only acts for vertical classes |
| header and footer | src/ltjsclasses.dtx:2310-2315, 2327 | `hf.class-native` | the sample sets no page style; class `plain` is `\ps@plainfoot`, centred page number in the foot |
| list indents, rule widths, paragraph shape | doc/luatexja-ruby.tex:19, 36, 289, 600, 603, 925 | `sp.lengths` | `\advance\leftmargini-1\zw`, `\leftmarginii` likewise; `\fboxsep=0mm`; `\leftskip=0.5\dimexpr\textwidth-30\zw`, `\rightskip=\leftskip`; `\parindent` 1\zw and 0.25\zw; `\hsize=22\zw` |
| manual spacing | doc/luatexja-ruby.tex:161, 807, 1022 | `sp.manual-space` | `\medskip`, `\quad`, `\hskip`, `\kern`, `\hfil` |
| page break | doc/luatexja-ruby.tex:110, 572, 1085 | `pg.break` | `\newpage` |
| Japanese typesetting layer | doc/luatexja-ruby.tex:6, 9; src/ltjsclasses.dtx:193; src/luatexja.sty:55; src/patches/lltjdefs.sty:118-147 | `lang.cjk` | luatexja (the package is the parameter; considered as its own way, folded here): defaults `autospacing, autoxspacing, differentjfm=paverage` and `\ltjdefcharrange` 1-9; sample calls `\ltjsetparameter{rubypreintrusion=..., rubypostintrusion=..., prebreakpenalty=...}` (main:390, 410, 707, 1031, 1079), `\inhibitglue` (50), `\ltjjachar` (78), `\textgt` (15) |
| Japanese glyph by CID | doc/luatexja-ruby.tex:6, 1088-1089; src/addons/luatexja-otf.sty:89 | `lang.cjk` | luatexja-otf `\CID{7642}`, `\CID{7674}` |
| ghost guard for Latin text | doc/luatexja-ruby.tex:6, 17, 20, 67 | `lang.cjk` | bxghost `\eghostguarded{..}` (ctan.org/pkg/bxghost read: MIT, TeX Live; xkanjiskip helper for LuaTeX, XeTeX, pTeX) |
| Japanese and Latin fonts | doc/luatexja-ruby.tex:7-10; src/addons/luatexja-preset.sty:346-356, 670, 688 | `font.fontspec` | `fontspec[no-math]`, `luatexja-fontspec[match]`, `luatexja-preset[haranoaji]` (HaranoAjiMincho and HaranoAjiGothic presets passed to `\setmainjfont` and `\setsansjfont`), `\setmonojfont{HaranoAjiGothic-Regular.otf}`, then `\normalsize` |
| maths font | doc/luatexja-ruby.tex:11-12 | `font.unicode-math` | `\setmathfont{Latin Modern Math}` |
| extra Japanese font shape | doc/luatexja-ruby.tex:54-55, 1116 | `font.nfss` | `\DeclareFontShape{JY3}{mc}{mc}{n}{<-> [0.92487] HaranoAjiMincho-Regular:extend=0.67;jfm=ujisc33}{}`, chosen by `\kanjifamily{mc}\kanjiseries{mc}`; the JFM doc/jfm-ujisc33.lua:1-135 is a data table (`luatexja.jfont.define_jfm{...}`, classes, widths, glue, kern, no functions), shipped as an asset |
| font sizes | doc/luatexja-ruby.tex:9, 142, 269, 494 | `font.size-commands` | `\normalsize`, `\Large`, `\fontsize{48}{48}\selectfont`, `\small` |
| inline emphasis and aliases | doc/luatexja-ruby.tex:15, 17, 20-21, 93 | `mark.kernel` | `\textbf`, `\texttt`, `\textsf`, `\mdseries`, `\itshape`, `\underline`, `\smash` (aliases in the Bespoke table) |
| colours | doc/luatexja-ruby.tex:4, 25-27, 84, 822 | `color.xcolor` | `xcolor[cmyk]`; `\definecolor{green}{cmyk}{.75,0,.65,0}`, blue `{1,.45,0,0}`, b_blue `{.3,0,0,0}`; `\color{blue!50!black}` |
| LuaTeX colour support | doc/luatexja-ruby.tex:24 | `color.color` | `luacolor`, load-only (the package is the parameter) |
| underline, strike, highlight | doc/luatexja-ruby.tex:24, 33-34, 321-325, 331, 1076-1082 | `mark.ulem`, `sp.rule` | `lua-ul`: `\newunderlinetype\beginActIntr{\color{blue}\leaders\vrule height -.16\zh depth .24\zh}`, `\highLight`, `\strikeThrough`, `\underLine` (the package is the parameter; the leaders rule is a `sp.rule` rule) |
| ruby and kenten | doc/luatexja-ruby.tex:23, 111, 123-126, 307-308, 1241, 1245; src/addons/luatexja-ruby.sty:94, 224, 265 | `lang.cjk` | `\usepackage{luatexja-ruby}`, body `\ltjruby[keys]{base\|base}{ruby\|ruby}` (alias `\ruby`, sty:226), `\ltjkenten[keys]{text}` (alias `\kenten`, 227), preamble `\ltjsetruby{keys}`; keys pre post mode stretch stretchbol stretcheol stretchruby maxmargin size intergap rubysmash baseheight rubydepth kenten fontcmd intrude_* always_highlight_protrusion naka kata (sty:45-103); per-character `rubypreintrusion`, `rubypostintrusion` through `\ltjsetparameter` (sty:20-23, 272-298) |
| hyperlinks and PDF metadata | doc/luatexja-ruby.tex:38-45, 119, 20-21 | `meta.hyperref` | `unicode, colorlinks, allbordercolors=white, allcolors=blue, pdftitle={luatexja-ruby.sty}`; `\href`; `\texorpdfstring` |
| bookmarks | doc/luatexja-ruby.tex:38 | `meta.bookmark` | load-only |
| cross-references | doc/luatexja-ruby.tex:152, 159, 235, 326, 492; 61-62 | `xref.kernel`, `xref.hyperref` | `\label`, `\ref`, `\autoref`; `\def\figureautorefname{図}`, `\def\tableautorefname{表}` |
| title block | doc/luatexja-ruby.tex:70-72, 97; src/ltjsclasses.dtx:2627-2648 | `front.maketitle` | `\title`, `\author`, `\date`, `\maketitle` (class layout: centred, `\LARGE` title, `\large` author and date) |
| abstract | doc/luatexja-ruby.tex:99-106; src/ltjsclasses.dtx:4166-4200 | `abs.kernel` | `abstract` environment (class layout: `\small`, centred `\headfont` name, list with `\listparindent`) |
| contents | doc/luatexja-ruby.tex:108 | `toc.kernel` | `\tableofcontents` |
| headings | doc/luatexja-ruby.tex:16, 111, 117, 153, 1243; src/ltjsclasses.dtx:3739-3745, 3761-3764, 3809-3823, 3838-3840 | `head.class-native` | `\section[short]{long}` with ruby inside the title (111); `\headfont` set to `\normalfont\bfseries\gtfamily` (16); `\paragraph` carries `\jsParagraphMark` (class 3808) |
| lists | doc/luatexja-ruby.tex:133, 166, 383, 509, 547, 757 | `list.kernel` | `description`, `itemize`, `enumerate`; `\def\makelabel#1{\ttfamily\bfseries #1}` (167, 351) |
| list layout | doc/luatexja-ruby.tex:5, 644, 686 | `list.enumitem` | `[label=\emph{Step~\arabic*},labelindent=0pt,itemindent=*,itemsep=\medskipamount]`, `[labelindent=\zw]` |
| quotes | doc/luatexja-ruby.tex:122, 141, 155, 419 | `quote.kernel` | `quote` |
| footnotes | doc/luatexja-ruby.tex:130, 435, 476, 539 | `fn.kernel` | `\footnote` |
| maths | doc/luatexja-ruby.tex:6, 291-302, 794 | `math.amsmath` | `amsmath`: `gather*`, `cases`, `align*`, `\underbrace`, `\mbox` |
| maths, kernel display | doc/luatexja-ruby.tex:551, 855 | `math.kernel` | `\[ \]` displays |
| delimiters | doc/luatexja-ruby.tex:5, 692-693 | `math.mleftright` | `\mleft` `\mright` |
| figure float | doc/luatexja-ruby.tex:268-304, 328-344 | `fig.graphicx` | `figure[t]` with `\centering`; `\leftskip`/`\rightskip` in the caption block (289) |
| captions | doc/luatexja-ruby.tex:303, 342, 506, 848; src/ltjsclasses.dtx:4681-4688 | `cap.kernel` | `\caption`, `\label` (class `\@makecaption`: `\small`, side margins 0.0628\linewidth, centred when short) |
| tables | doc/luatexja-ruby.tex:493-508, 814-850 | `tbl.tabular` | `tabular{lll}`, `{cllll}`, `\multicolumn{1}{c}{..}` (817) |
| table rules | doc/luatexja-ruby.tex:23, 496, 816 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| table alignment | doc/luatexja-ruby.tex:494, 814 | `sp.ragged` | `\centering` |
| listing settings | doc/luatexja-ruby.tex:28-32, 316-318 | `code.listings` | `\lstset{preset=\normalsize, basicstyle=\small\ttfamily, basewidth=0.5em, explpreset={numberstyle=\tiny, numbers=left, numbersep=1em, columns=fixed}, morecomment=[l]{\%}, commentstyle=\color{green}}`; `lstlisting` (316) |
| verbatim | doc/luatexja-ruby.tex:112, 353-355, 365-374, 481-484 | `code.verbatim` | `verbatim` environment, `\verb+...+` |
| code with its result | doc/luatexja-ruby.tex:23, 195-198, 1019-1027 | `code.showexpl` | `\usepackage{showexpl}`, `LTXexample[width=0.25\textwidth, preset=\Large]`, `LTXexample[pos=t]` |
| framed example boxes | doc/luatexja-ruby.tex:222, 925-933, 944 | `box.fancybox`, `box.minipage` | `\fbox`, `\frame`, `\fcolorbox`; `\setbox0=\vbox{\hsize=22\zw ...}\fbox{\box0}` reduces to `\fbox{\begin{minipage}{22\zw}...\end{minipage}}` |
| picture in figure | doc/luatexja-ruby.tex:5, 270-287 | `art.pstricks` | `pict2e` picture (`\polygon`, `\vector`, `\line`, `\linethickness`); content inside a figure, see Content-opaque |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\HyRef@autoref` | doc/luatexja-ruby.tex:63-68 | no | copy of a hyperref internal (`\Hy@safe@activestrue`, `\HyRef@autosetref`) with `\eghostguarded{}` appended; patches a published package's code, so no declarative way |
| `\mybox`, `\mybox@@` | doc/luatexja-ruby.tex:74-80 | no | `\@ifnextchar` picks one of four box layouts drawn with `\vrule width 0pt height .88\zh depth .12\zh\kern..` inside `\fcolorbox`; a hand-rolled conditional that drives what is printed |
| `\RULER` | doc/luatexja-ruby.tex:82-91 | no | `\loop` over `\@tempcnta` drawing 20 `\vrule`s from `\dimexpr` of `\baselineskip` and `\zh`; hand-rolled counter loop |
| `\_` | doc/luatexja-ruby.tex:58-60 | no | `\ifx\f@family\ttdefault` test on a font internal, then `\kern` and `\hrule` drawing; hand-rolled conditional |
| `\Node`, `\@Node` | doc/luatexja-ruby.tex:47-50 | no (borderline) | `\vcenter{\hbox{\fcolorbox{..}{..}{\vbox{\halign{\hfil##\hfil\cr ..\noalign{\smallskip\hrule height.4pt\smallskip}..\cr}}}}}`; a `\tabular` with `\noalign` might give a similar cell, but a box-and-glue `\halign` is irreducible by the rubric's wording and sameness cannot be shown |
| `\@for\@tmp:=...\do{\mybox{\@tmp}}` | doc/luatexja-ruby.tex:423, 427, 433, 441, 442 | no | depends on `\mybox` |
| `\emph`, `\cs`, `\Param`, `\Pkg`, `\LuaTeX`, `\<..>` | doc/luatexja-ruby.tex:15, 17, 20, 21, 51, 93 | yes | aliases over `mark.kernel` (`\textbf\textgt`, `\texttt`, `\underline\smash\textsf`), `meta.hyperref` (`\texorpdfstring`), `lang.cjk` (`\eghostguarded`); inline expansion. `\<` (93) replaces luatexja's own `\<` (src/patches/lltjdefs.sty:150) |
| `\headfont` | doc/luatexja-ruby.tex:16 | yes | class hook assigned `\normalfont\bfseries\gtfamily` (`head.class-native`) |
| `\ActIntr`, `\beginActIntr` | doc/luatexja-ruby.tex:33-34 | yes | `mark.ulem` (lua-ul `\newunderlinetype`) with a `sp.rule` leaders rule and `color.xcolor` blue; the `\NewDocumentCommand` is an alias |
| `\figureautorefname`, `\tableautorefname` | doc/luatexja-ruby.tex:61-62 | yes | `xref.hyperref` name strings |
| `\advance\leftmargini-1\zw` | doc/luatexja-ruby.tex:19 | yes | `sp.lengths` |
| JY3 font shape | doc/luatexja-ruby.tex:54-55 | yes | `font.nfss` declaration; the JFM data file doc/jfm-ujisc33.lua is an asset |
| `\SX@Info=\relax` | doc/luatexja-ruby.tex:35 | yes | silences a showexpl log message, no printed effect; an emitter drops it |
| `\typeout`, `\errorcontextlines` | doc/luatexja-ruby.tex:94, 623 | yes | log and debug only, no printed effect; dropped |
| `\newcommand*{\噂}`, `\倦` | doc/luatexja-ruby.tex:1088-1089 | yes | aliases of `\CID{7642}` and `\CID{7674}` (`lang.cjk`) |
| `\rubytest`, `\sample`, `\TEST` | doc/luatexja-ruby.tex:923, 946, 1011, 1033 | yes | aliases that expand to `\ruby{..}{..}` calls (`lang.cjk`) |
| `\count@` `\loop` setting `rubypreintrusion` per code point | doc/luatexja-ruby.tex:1204-1207, 1216-1219 | yes | inside example text; unrolls to `\ltjsetparameter` calls per character (same loop in src/addons/luatexja-ruby.sty:272-285) |
| luatexja Lua and TeX code (ruby breaking, JFM glue, `\zw`, `\ltjsetparameter`) | src/*.lua, src/luatexja-core.sty:179-184, src/addons/luatexja-ruby.sty:224-245 | not bespoke | published CTAN package; treated as the ways `lang.cjk` and `lang.cjk` |

## Content-opaque
- `pict2e` picture of the baseline and ruby heights inside `figure` at doc/luatexja-ruby.tex:270-287.
- The text of the examples inside every `LTXexample` and the test boxes of Japanese text (doc/luatexja-ruby.tex:195-198, 925-1007, 1019-1245) are content: code text and sample sentences.
- Missing assets: Harano Aji fonts (`HaranoAjiMincho-Regular.otf`, `HaranoAjiGothic-Regular.otf`, main:9-10, 55) are not in the zip; ship them. The ruby add-on is two-pass (`<jobname>.ltjruby`, main:556; src/addons/luatexja-ruby.sty:228).

## Lib changes
- New ways proposed:
  - `lang.cjk` (luatexja-ruby, in the luatexja bundle: CTAN macros/luatex/generic/luatexja, TeX Live, modified BSD; v0.71 at src/addons/luatexja-ruby.sty:7; manual doc/luatexja-ruby.pdf is in the zip; engine xe/lua, LuaTeX only: core.sty:78-80, luatexja-ruby.sty:13; the CTAN page of luatexja was read but does not list the add-ons): Japanese ruby (furigana) and kenten annotation. W1 published with a manual. W2 key=value options (`pre`, `post`, `mode` bit vector, `stretch*`, `size`, `intergap`, booleans, the font-switch string `fontcmd`) and per-character reals through `\ltjsetparameter`. W3 serves any Japanese document. W4 inline wrapper `\ltjruby[keys]{base}{ruby}` and `\ltjkenten[keys]{text}` around a span, plus one preamble line. Not `mark.ulem` (rules) or `mark.kernel` (font switches). `pxrubrica` is named at main:119 as the model for the terms, not checked at CTAN, and would be the same way with another package.
  - `code.showexpl` (`showexpl`, ctan.org/pkg/showexpl read: v0.3s, Rolf Niepraschk, LPPL 1.2, TeX Live and MiKTeX; engine pdf; its source was not read): a listing plus its typeset result. W1 CTAN. W2 `pos`, `width`, `preset` and `listings` keys (`explpreset`, main:30). W3 any manual or tutorial. W4 `\usepackage{showexpl}` and an `LTXexample[keys]` environment wrapper. Not `code.listings`, which prints source only, as `code.tcblisting` is its own way beside it.
- Considered: luatexja as its own way (folded into `lang.cjk`, the Japanese counterpart of CJK/xeCJK/ctex, same engine tag); `lua-ul` (read as `mark.ulem`, package as the parameter); `luacolor` (`color.color`); `bxghost` (`lang.cjk`); considered: lltjext (`\layoutfloat`, `\pcaption` in the second sample doc/lltjp-geometry.tex:192, 207, src/lltjext.sty:198, 245; not in the main sample, no row).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
