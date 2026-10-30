no

# 0189-praecordi-praecordi-book: Praecordi Book (class for novels and short story collections)

- Unverified: read from the source, not compiled.
- Source: Source/0189-praecordi-praecordi-book/ (origin: https://codeload.github.com/Praecordi/praecordi-book/zip/refs/heads/main; licence: GPL-3.0, praecordi-book.cls:1-9)
- Kind: book
- Lib: v3
- Engine: needs XeLaTeX or LuaLaTeX (`fontspec` cls:41, `\setmainfont{Cormorant Garamond}` cls:89; the unconditional `soulpos` at praecordi-book-util.sty:22 rests on the pdfTeX/LuaTeX savepos mechanism per its CTAN page, XeLaTeX support not checked, so LuaLaTeX is the safe reading)
- Look carried by: zip-local (praecordi-book.cls and praecordi-book-util.sty define it; showcase.tex only sets title data, hypersetup and directories)
- Class origin: zip-local (`praecordi-book` is a GitHub class; https://ctan.org/pkg/praecordi-book is a 404; it `\LoadClass`es the published `scrbook`)
- Main file: showcase.tex (other samples: chapters/sample.tex, fragments/sample.tex, frontmatter/progress.tex, frontmatter/story-ideas.tex, all included by the main file)
- Read: main yes, zip-local classes and styles all (praecordi-book.cls 462 lines and praecordi-book-util.sty 393 lines, in full)

## Verdict
No. The look is defined by a zip-local class on top of `scrbook`, and most of its identity is TikZ drawn on the page: the title page, the chapter and part openers, the running head and foot rules, and the scene divider. These are `ART` with no declarative lib way. On top of that, chapter and fragment inclusion keeps its titles, subtitles and cover art in `zref` properties read back from the aux file, and a TikZ chapter opener consumes them, which is irreducible hand-rolled state. The rest (boxes, tables, fonts, colours, language, quotes, TOC styles, watermark) reduces to lib ways, so the zip would be a `yes` only if the artwork and the inclusion machinery were removed.

## Blockers
- `ART/class` title page: `\renewcommand{\maketitle}` is a `tikzpicture` overlay with positioned, `fit`-sized rounded background node at `fill opacity=0.4` (praecordi-book.cls:172-231), plus `\vignette` and `\coverart` overlays accumulated in `\@titlegraphics` by `\g@addto@macro` (praecordi-book.cls:136-170)
- `ART/class` chapter opener: `\chapterlineswithprefixformat` redrawn as a TikZ overlay with two 2pt rules, a `fit` background and a conditional full-page cover image (praecordi-book.cls:375-439, cover image at 355-373)
- `ART/class` part opener: `\partlineswithprefixformat` is a TikZ picture of two 2pt rules and centred nodes (praecordi-book.cls:441-461)
- `ART/class` running head and foot: `\lehead`, `\rohead`, `\cfoot` each hold a `tikzpicture` that draws a rule sized to the mark or page number (praecordi-book.cls:313-337)
- `ART/class` scene divider: `\divider` draws two rules and five graded dots with TikZ (praecordi-book-util.sty:190-202); used in the body at chapters/sample.tex:19
- `BESPOKE/class` chapter and fragment inclusion: `\chaptermetadata`, `\inputchapter`, `\fragmentmetadata`, `\inputfragment` store title, subtitle and cover art as `zref` properties, fetch the title for `\chapter{}` from the aux file, keep a global `\currentchapter`, and number an unnumbered `\chapter*` with `\stepcounter{chapter}` plus a hand-built `\numberline` toc entry (praecordi-book-util.sty:63-158); consumed at praecordi-book.cls:355-381
- `BESPOKE/class` `\chl` multi-line highlighter: `\ulposdef` callback with `\ifulstarttype` and `\ifulendtype` branches that call `\tcbset` and a `\newtcbox` per line fragment (praecordi-book-util.sty:30-61)
- `BESPOKE/class` progress table: `\getpagenumber` computes a chapter's page count from the `chap:<id>-start` and `-end` labels that `\inputchapter` writes (praecordi-book-util.sty:166-168, 97-117, 351-388); the table layout itself reduces (see Bespoke code)

## Class setting
- Class: `class.scrbook` loaded by the zip-local class, options `DIV=10`, `fontsize=12pt`, `twoside={\ifwip false \else semi \fi}`, `parskip=half+`, `chapterprefix=true` (praecordi-book.cls:31-37). The sample itself calls the zip-local `praecordi-book` with options `wip`, `noimage`, `darkmode`, all commented out (showcase.tex:1-5); `showframe` is also declared (praecordi-book.cls:24).
- Class-native vocabulary used: `\subtitle` (showcase.tex:8), `\frontmatter` `\mainmatter` `\part` `\chapter` (showcase.tex:38,45,50,52), `\setkomafont` `\addtokomafont` `\newkomafont` `\usekomafont` (praecordi-book.cls:91-98,124), `\KOMAoptions` (:93), `\RedeclareSectionCommand` (:263-279), `\deffootnote` (:348), `\chapterlineswithprefixformat` `\partlineswithprefixformat` `\chapterpagestyle` `\chaptermarkformat` (:174,311,375,441), scrlayer-scrpage `\automark` `\lehead` `\rohead` `\cfoot` `\headmark` `\pagemark` `\clearpairofpagestyles` `\clearmainofpairofpagestyles` (:305-337)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | praecordi-book.cls:31-37 | `class.scrbook` | DIV=10, fontsize=12pt, twoside=semi (false when wip), parskip=half+, chapterprefix=true |
| paper, size, sides | praecordi-book.cls:32-34 | `page.class-options` | fontsize=12pt, twoside=semi |
| text block | praecordi-book.cls:32,93 | `page.typearea` | DIV=10, then `DIV=current` after the font is set |
| geometry package | praecordi-book.cls:24,39 | `page.geometry` | loaded with no layout values; `showframe` passed through by a class option |
| head and foot heights | praecordi-book.cls:307-308 | `page.setlength` | headheight=30pt, footheight=75pt |
| running head and foot setup | praecordi-book.cls:305-311 | `hf.scrlayer-scrpage` | both pagestyle pairs cleared, `\automark[chapter]{chapter}`, `\chaptermarkformat` empty |
| head and foot content | praecordi-book.cls:313-337 | `art.tikz` | ART: rule under `\headmark` (0.4pt, +/-20pt), rules either side of `\pagemark` (0.5pt, 6em from the text edge) |
| page styles | praecordi-book.cls:173-174,287-288; praecordi-book-util.sty:104-105 | `hf.pagestyle-kernel` | empty, `scrheadings`, `\chapterpagestyle` plain or empty |
| main and heading font | praecordi-book.cls:41,89-92 | `font.fontspec` | `\setmainfont{Cormorant Garamond}`, `\newfontfamily\ourfont` (font not shipped) |
| heading and footnote fonts | praecordi-book.cls:91-92,97-98,124 | `head.koma-fonts` | `disposition` gets `\ourfont` and `\color{textcolor}`, `subtitle` `\color{subcolor}`, `footnote` `\normalfont\RaggedRight`, new element `quicklinks` `\small\centering` |
| line spacing | praecordi-book.cls:88 | `sp.linespread` | 1.25 |
| paragraph indent | praecordi-book.cls:117 | `sp.lengths` | `\parindent`=1em (set at `\AtBeginDocument`) |
| ragged text | praecordi-book.cls:44,116 | `sp.ragged` | `ragged2e`, `\RaggedRight` for the whole text |
| loose line breaking | praecordi-book.cls:115 | `sp.hyphenat` | `\sloppy` |
| indent after headings | praecordi-book.cls:45 | `sp.indentfirst` | load only |
| microtype | praecordi-book.cls:46 | `sp.microtype` | `babel`, `nopatch=footnote` |
| colours | praecordi-book.cls:47,52-60,62-80; praecordi-book-util.sty:344-347 | `color.xcolor` | `dvipsnames,svgnames,table`; `\colorlet` for backgroundcolor, textcolor, subcolor (white/black/darkgray, or black/white/lightgray in darkmode), tinted pairs `<name>bcolor` (`!15!`) and `<name>fcolor` (`!75!`) for nine named hues, four status colours |
| page and text colour | praecordi-book.cls:95-96 | `color.pagecolor` | `\pagecolor{backgroundcolor}` and `\color{textcolor}` |
| language | praecordi-book.cls:42 | `lang.babel` | american |
| quotation marks | praecordi-book.cls:43,103-109 | `lang.csquotes` | `\DeclareQuoteStyle[american]{english}` with curly quote glyphs, `\MakeOuterQuote{"}` |
| PDF and link setup | praecordi-book.cls:28; showcase.tex:14-18; praecordi-book-util.sty:26 | `meta.hyperref` | hyperfootnotes=false, colorlinks=true, allcolors=blue, pdfpagemode=UseOutlines |
| title data | showcase.tex:7-9 | `front.maketitle` | `\title`, `\subtitle` (KOMA), `\author` set; the layout is not this way (next row) |
| title page layout | praecordi-book.cls:172-232 | `art.tikz` | ART: node at page centre +0.2\paperheight, text width 0.55\paperwidth, "By <author>", `fit` background fill opacity 0.4 |
| cover art, vignettes | praecordi-book.cls:126-170 | `art.tikz` | ART: `/vignette/` pgfkeys (width, angle, anchor, xscale, yscale) and a page-centred full-width image; the images are content (`fig.graphicx`), none shipped, all calls commented at showcase.tex:23-28 |
| page background image | praecordi-book.cls:237-258 | `bg.eso-pic` | reducible: one image centred on every page, opacity 0.2, keepaspectratio, off under `wip` |
| draft watermark | praecordi-book.cls:294-300 | `bg.watermark` | reducible: text DRAFT, angle 60, scale 10, opacity 0.1 (wip only); mapping of opacity to the package's lightness key not checked |
| contents | praecordi-book.cls:281-289; showcase.tex:36 | `toc.kernel` | `\tableofcontents` wrapped with `hf.pagestyle-kernel` switches and `pg.break` `\clearpage`, label `fm:content` |
| contents entry styles | praecordi-book.cls:263-279 | `toc.koma` | tocindent 1em (chapter) and 2em (section), tocnumwidth=2.5em |
| heading skips | praecordi-book.cls:263-274 | `head.class-native` | `\RedeclareSectionCommand` part and chapter beforeskip=0pt, afterskip=8\baselineskip |
| chapter opener | praecordi-book.cls:375-439 | `art.tikz` | ART (see Blockers) |
| part opener | praecordi-book.cls:441-461 | `art.tikz` | ART (see Blockers) |
| part and chapter numbers | praecordi-book.cls:342-343; showcase.tex:44,53 | `num.counters` | `\thepart` and `\thechapter` arabic; `\setcounter{part}{-1}`, `\setcounter{chapter}{0}` |
| unnumbered sections | praecordi-book-util.sty:160-164; chapters/sample.tex:11,15 | `head.kernel` | `\addsection{t}{l}` = `\section*` + `\label{sec:l}` + `\addcontentsline{toc}{section}` |
| front/main matter | showcase.tex:38,50 | `class.scrbook` | native `\frontmatter`, `\mainmatter` |
| footnote layout | praecordi-book.cls:348 | `class.scrbook` | native `\deffootnote[2em]{0.5em}{1em}{\textsuperscript{\thefootnotemark}}`; no footnote is used in the sample |
| notes, idea, fragment boxes | praecordi-book-util.sty:206-312 | `box.tcolorbox` | `\newtcolorbox` with colback `<n>bcolor`, colframe `<n>fcolor`, fonttitle=\bfseries, toptitle=4pt, bottomtitle=2pt, left/right/top/bottom=1em, arc=3pt, boxrule=1pt, breakable, enhanced, `label=`, `before upper`; library options `breakable,skins` (:20) |
| story idea box | praecordi-book-util.sty:314-339; frontmatter/story-ideas.tex:3-31 | `box.tcolorbox` | 4 arguments, colours from argument 3, `\small` fonts, 0.5em padding, before and after skip 1em; title with an optional `[#2]` line via `\IfStrEq` |
| highlight box | praecordi-book-util.sty:31-46 | `box.tcolorbox` | `\newtcbox{\hlbox}` on line, minimal size, colback `ul!80`, arc=1pt (the per-line `\chl` logic is a blocker) |
| progress table layout | praecordi-book-util.sty:342,351-388; frontmatter/progress.tex:5-13 | `tbl.tabular` | `tabular` of four `L{w}` columns (0.3, 0.15, 0.15, 0.2 \textwidth), `\newcolumntype`; `fig.float` `table[H]`; `tbl.booktabs` toprule, midrule, bottomrule; `tbl.colortbl` `\cellcolor` per status colour |
| cross-reference aliases | praecordi-book-util.sty:170-188; showcase.tex:11 | `xref.hyperref` | `\hyperref[chap:..-start]{text}` and four siblings (`\fragmentref` `\noteref` `\fmref` `\idearef`) |
| labels | praecordi-book-util.sty:103,107; frontmatter/progress.tex:1 | `xref.kernel` | `\label{chap:<id>-start}`, `\label{fm:progress}` |
| aux-stored chapter metadata | praecordi-book-util.sty:63-92 | `xref.zref` | `\zref@newprop`, `\zref@labelbyprops` (the surrounding machinery is a blocker) |
| spacer macro | praecordi-book-util.sty:203 | `sp.manual-space` | `\parbreak` = `\vspace{\baselineskip}` |
| filler text | showcase.tex:20; chapters/sample.tex:8,13,17 | `draft.todo` | `blindtext` `\blindtext`, `\Blindtext`; filler content |

No abstract, list, quote, math, theorem, code, bibliography or index construct is defined or used (checked by reading every source file).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| Class options `wip`, `noimage`, `darkmode` as `\newif` booleans | praecordi-book.cls:15-25 | Yes, by fixing one variant per emit | The emitter writes one branch: darkmode is only a swap of the colour set (cls:52-60, `color.xcolor`, `color.pagecolor`); `wip` selects the boxes, watermark and toc lines. Judgment call: a conditional that drives printed output is irreducible as a live macro, but here the booleans are fixed per build |
| `\defineflexiblecolor` | praecordi-book.cls:62-70 | Yes | Two `\colorlet` lines per hue in `color.xcolor`, tint 15 and 75 over white or black |
| `draft` environment and the `\RenewDocumentEnvironment` wrappers of `notes`, `idea`, `fragment` | praecordi-book-util.sty:233-241,270-278,304-312,390-394 | Yes, by fixing the variant | wip: emit the `box.tcolorbox` of the same name; not wip: emit nothing. Read-only observation: the wrappers at :241 and :312 end with no fourth (end-code) argument, unlike :278; not tested |
| `\tableofcontents` wrapper | praecordi-book.cls:281-289 | Yes | `toc.kernel` between `hf.pagestyle-kernel` switches and `pg.break` |
| `\newtcolorbox` notes, idea, fragment, storyidea | praecordi-book-util.sty:206-339 | Yes | `box.tcolorbox` with the key lists in the Component map |
| `\addsection`, `\parbreak`, `\chapref` and four siblings | praecordi-book-util.sty:160-188,203 | Yes | `\newcommand` aliases of `head.kernel`, `sp.manual-space`, `xref.hyperref` |
| progress table environment | praecordi-book-util.sty:351-388 | Layout yes, page-count column no | Layout in `tbl.tabular`, `tbl.booktabs`, `tbl.colortbl`, `fig.float`; the count `\number\numexpr\getpagerefnumber{..-end}-..+1` needs the `\inputchapter` labels |
| `\chl` highlighter | praecordi-book-util.sty:48-61 | No | Per-line-fragment decoration code in a `soulpos` callback; the parameters of this package are code, so it fails W2 (considered: `soulpos`) |
| `\inputchapter`, `\inputfragment`, `\chaptermetadata`, `\fragmentmetadata` | praecordi-book-util.sty:63-158 | No | Aux-driven titles and a global state variable feed `\chapter`; no lib way |
| `\maketitle`, `\vignette`, `\coverart` | praecordi-book.cls:136-231 | No | TikZ artwork (`ART/class`) |
| chapter and part openers | praecordi-book.cls:355-461 | No | TikZ artwork plus the zref reads (`ART/class`, `BESPOKE/class`) |
| head and foot rules | praecordi-book.cls:313-337 | No | TikZ rules whose length follows the mark (`ART/class`) |
| `\divider` | praecordi-book-util.sty:190-202 | No | TikZ rules and dots (`ART/class`) |

## Content-opaque
- Cover, vignette, background and per-chapter cover images are user-supplied files (calls commented at showcase.tex:23-28, chapters/sample.tex:4); none is shipped.
- `blindtext` filler paragraphs (chapters/sample.tex:8,13,17; fragments/sample.tex:6,8).
- Assets not shipped: the Cormorant Garamond font (praecordi-book.cls:89-90). Noted, not a blocker.

## Lib changes
- New ways proposed: none. Considered: `soulpos` as a highlight way, rejected (its parameters are callback code, W2); KOMA `\deffootnote` recorded as class vocabulary under `class.scrbook`, not as a component way.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
