no

# 0842-awesome-cookbook: Awesome Cookbook

- Unverified: read from the source, not compiled.
- Source: Source/0842-awesome-cookbook/ (origin: https://latextemplates.com/downloads/awesome-cookbook.zip; licence: CC0 for project work; bundled dependencies have separate terms)
- Kind: book
- Lib: v6
- Engine: needs LuaLaTeX (`\directlua` at awesome-cookbook.cls:902; `fontspec` :32 and `unicode-math` :53 need XeTeX or LuaTeX; README.md:4 says "It runs with LuaLaTeX")
- Look carried by: zip-local (the whole look is in awesome-cookbook.cls; main.tex adds content and three setter calls)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles partly (awesome-cookbook.cls 1-903 read in full; fontawesome.sty lines 1-120 and 660-683 read, lines 121-659 only checked by a line-shape pattern, each is one icon definition)

## Verdict
No. The look is a hand-written class (`awesome-cookbook`, zip-local; github.com/Nooby4Ever/awesome-cookbook per awesome-cookbook.cls:4; ctan.org/pkg/awesome-cookbook is a 404) on top of `book`. Its cover page, category (part) title page and recipe header banners are TikZ page-overlay drawings that carry the template's identity (`ART`), and it has irreducible helpers (a longtable-in-multicols box hack, a computed image-crop macro, an unconditional Lua `require` whose file is missing from the zip). The rest (lists, tables, ToC, page styles, fonts, colours, hyperref) reduces to lib ways, listed below.

## Blockers
- `ART/class` category (`\part`) title page: full-width filled band, 6pt rule and a 280pt part numeral drawn with `tikzpicture[remember picture,overlay]` at `current page.north` (awesome-cookbook.cls:387-411 style1, the default per :147; style2 :413-437). Used by `\category` (main.tex:8, :22).
- `ART/class` cover page `\makeCover`: header band, framed rectangle with rule, hard-coded "Family Recipes" at 90pt, footer band, all TikZ overlay (awesome-cookbook.cls:815-851). Called from `\beginCookbook` (:876, main.tex:6).
- `ART/class` recipe header banners style1, style2 and style4 drawn with TikZ (awesome-cookbook.cls:464-477, :479-491, :498-506). Reading note: the default style string is `srtyle1` (:138), which matches none of the four names tested at :464, :479, :493, :498, and main.tex passes no `style=`, so the sample as read prints no banner; the code is still part of the class.
- `ART/class` (borderline) `\info` metadata strip: five conditional `tikzpicture` blocks that place a PNG icon and a two-line text with `right=\iconsize/2 + 0.15cm` (awesome-cookbook.cls:547-595; main.tex:10, :24). A reduction to `fig.graphicx` + `box.minipage` is conceivable but the node geometry is not shown to reduce.
- `BESPOKE/class` `multicolslongtable` (awesome-cookbook.cls:185-197): `\setbox\ltmcbox\vbox`, `\col@number\@ne`, `\unpenalty`, `\unvbox` around a `longtable`, to make it flow in `multicols`. Used by `ingredientsh` (:629) and `energylist` (:802), not by the sample.
- `BESPOKE/class` `\ClipImage` (awesome-cookbook.cls:206-218) measures an image with `\settototalheight`/`\settowidth`, compares ratios with `\ifnumcomp` and computes `trim` for `\adjincludegraphics`; `\recipefigure` styles `crop` and `fullpage4` (:754-786) build on it and use `\pagewidth`/`\pageheight`, which none of the files read define. Not called by the sample.
- `BESPOKE/class` Lua: `\directlua{require("autogenerate.lua")}` runs at class load (awesome-cookbook.cls:902) and `\autoGenerate` calls `generateTex` on the recipes directory (:903). `autogenerate.lua` is not in the zip (28 files listed, none is a `.lua`), so its code was not read; it generates document structure, which no lib way expresses.

## Class setting
- Class: `class.book` options: `11pt`, `a4paper` (main.tex:1). The zip-local class passes every option to `book` through `\DeclareOption*` and `\PassOptionsToClass` (awesome-cookbook.cls:20-24), then `\LoadClass{book}` (:24). `class.awesome-cookbook` is not a published class, so it is not a way; its vocabulary is bespoke class code.
- Class-native vocabulary used: `\setFontDir` (main.tex:2), `\cookbookName` (:3), `\nCookbook` (:4), `\beginCookbook` (:6), `\beginRecipes` (:7), `\category` (:8), `\recipe` (:9), `\info` (:10), `ingredients` with `\ingredient` (:11-16), `preparation` with `\step` (:17-21), `\beginAppendices` (:35); `book`'s `\chapter` (:36).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:1; awesome-cookbook.cls:20-24 | `class.book` | `\LoadClass{book}`; options 11pt, a4paper forwarded |
| paper and size | main.tex:1 | `page.class-options` | a4paper, 11pt |
| page geometry | awesome-cookbook.cls:298 | `page.geometry` | left=2.0cm, top=1.5cm, right=2.0cm, bottom=2.5cm, footskip=1cm; `\newgeometry`/`\restoregeometry` :764, :785 |
| header/footer | awesome-cookbook.cls:301-316 | `hf.titleps` | `titlesec[pagestyles]` (:64): `\newpagestyle{normal}` empty head, foot `[\bfseries\thepage][][\scshape\parttitle]` / `{\scshape\parttitle}{}{\bfseries\thepage}`, `\settitlemarks{part}`; `appendix` style same with `\chaptertitle`, `\settitlemarks{chapter}` |
| page style switches | awesome-cookbook.cls:876, :887, :893, :393 | `hf.pagestyle-kernel` | `\pagestyle{empty}`, `{normal}`, `{appendix}`, `\thispagestyle{empty}` |
| front/main/back matter | awesome-cookbook.cls:880, :886, :892 | `class.book` | native `\frontmatter`, `\mainmatter`, `\appendix` (roman/arabic page numbers, chapter letters) |
| appendix | awesome-cookbook.cls:892; main.tex:35-38 | `num.appendix` | `\appendix` then book `\chapter` |
| paragraph spacing | awesome-cookbook.cls:58 | `sp.parskip-pkg` | no options |
| line spacing (load only) | awesome-cookbook.cls:50 | `sp.setspace` | `setspace` loaded, no command called in class or sample |
| alignment | awesome-cookbook.cls:42, :394, :655, :749, :857 | `sp.ragged` | `ragged2e` loaded; kernel `flushright`, `flushleft`, `\centering` used |
| manual spacing | awesome-cookbook.cls:608, :614, :674, :856 | `sp.manual-space` | `\vspace{-1em}`, `\vspace{3mm}`, `\vspace*{7cm}`, `\\[0.5em]` |
| length arithmetic | awesome-cookbook.cls:94, :209, :704 | `sp.lengths` | `calc`: `\ratio`, `\dimexpr`, infix in `\setlength` |
| microtype | awesome-cookbook.cls:69-72 | `sp.microtype` | activate={true,nocompatibility}, final, factor=1100, stretch=10, shrink=10; `\SetProtrusion` for sizes 6,7 digits |
| main text font | awesome-cookbook.cls:285-291 | `font.fontspec` | `\setmainfont[Path=\@fontdir, UprightFont=*-Regular, ItalicFont=*-It, BoldFont=*-Bold, BoldItalicFont=*-BoldIt]{SourceSansPro}`; `\defaultfontfeatures{Ligatures=TeX}` :51 |
| extra font families | awesome-cookbook.cls:243-282 | `font.fontspec` | `\newfontfamily` `\headerfont`, `\headerfontlight` (Roboto), `\footerfont`, `\bodyfont`, `\bodyfontlight` (SourceSansPro); only `\headerfont` is called (:627) |
| maths font | awesome-cookbook.cls:53 | `font.unicode-math` | math-style=TeX |
| icons | awesome-cookbook.cls:56; fontawesome.sty:6-14 | `font.icons` | `fontawesome`, zip-local fork v4.4.0 with `Path=fonts/`; no `\fa...` command is called in class or sample |
| text sizes | awesome-cookbook.cls:352, :395, :670, :707 | `font.size-commands` | `\large`, `\Large`, `\Huge`, `\fontsize{50}{60}\selectfont`, `\fontsize{45}{0}` |
| font switches | awesome-cookbook.cls:304, :352, :609 | `mark.kernel` | `\bfseries`, `\scshape`, `\sffamily`, `\textbf` |
| colour | awesome-cookbook.cls:100-118 | `color.xcolor` | 13 `\definecolor{awesome-*}{HTML}{...}` (awesome-red DC3522, awesome-darkgray 343434 ...); `\colorlet` awesome, base, second, text |
| language | awesome-cookbook.cls:34 | `lang.polyglossia` | load-only; no `\setmainlanguage` in class or sample |
| hyperref | awesome-cookbook.cls:323-335 | `meta.hyperref` | unicode=true, colorlinks=true, linkcolor=base, citecolor=base, filecolor=base, urlcolor=awesome, pdfauthor/pdftitle/pdfsubject from class macros, pdfproducer |
| cover page | awesome-cookbook.cls:815-851 | `art.tikz` | ART/class, blocker |
| title and copyright page | awesome-cookbook.cls:855-871 | `front.titlepage-env`, `front.dedication`, `sp.manual-space` | hand-laid: title at 50pt flushright, `\newpage`, `\vfill`, copyright line with `\the\year` and `\@author`, `\href` to the project, licence string :163-164, `\today`; `\@author` is read here and at :331 while the sample sets no `\author` |
| table of contents | awesome-cookbook.cls:881 | `toc.kernel` | `\tableofcontents` |
| ToC entry styles | awesome-cookbook.cls:345-371 | `toc.titletoc` | `\contentsmargin{0cm}`; `\titlecontents{part}[1.25cm]`, `{chapter}[1.25cm]`, `{section}[1.25cm]` with colours, `\contentslabel[\Large\thecontentslabel]{1.25cm}`, page-number fillers |
| ToC leaders | awesome-cookbook.cls:342, :355, :371 | `sp.rule` | `\leaders\hrule\@height#1\hfill` (2pt, awesome colour); `\titlerule*[0.25pc]{.}` dot leader |
| ToC depth | awesome-cookbook.cls:348 | `num.secnumdepth` | tocdepth=1 |
| category = part heading | awesome-cookbook.cls:383-437 | `head.titlesec`, `art.tikz` | `\titleformat{\part}{}{}{0pt}{...}[]` with `explicit`; before-code is the TikZ title page (ART/class) |
| recipe = section heading | awesome-cookbook.cls:444, :458-461 | `head.titlesec`, `pg.break` | `\titleformat{\section}{}{}{0pt}{}[]` (prints no title text); `\recipe` does `\clearpage` or `\cleardoublepage` (`startleft`), then `\section{#2}`; banners are ART/class |
| appendix chapter heading | main.tex:36 | `head.kernel` | book default `\chapter` (no `\titleformat{\chapter}` in the class) |
| preface | awesome-cookbook.cls:514-519 | `head.kernel` | `\chapter*{\@preface}` and a fixed closing sentence; not in sample |
| ingredients list | awesome-cookbook.cls:602-616; main.tex:11-16 | `fig.wrapfig`, `tbl.tabular`, `color.xcolor`, `sp.manual-space` | `\wraptable{r}{0.3\textwidth}`; `tabular{r@{ } l p{0.2\textwidth}}`; `\ingredient{qty}{unit}{text}` = three `\textcolor{second}` cells; heading `\textbf` |
| ingredient variants | awesome-cookbook.cls:619-661 | `cols.multicol`, `tbl.longtable`, `fig.float`, `fig.subcaption`, `tbl.tabular` | `ingredientsh` (3 columns), `ingredientsc` (`table[!h]`), `column` (`subtable[t]{.3\textwidth}`); not in sample; `ingredientsh` needs the `multicolslongtable` blocker |
| preparation steps | awesome-cookbook.cls:665-675; main.tex:17-21 | `list.enumitem`, `list.kernel` | `enumerate[label=\color{awesome}\Large\bfseries\arabic*.]`; `\step` = `\item` |
| alternatives | awesome-cookbook.cls:681-695 | `list.enumitem`, `mark.case` | `enumerate[label=\color{second}\Large\bfseries\Roman*.]`; `\refaltstep` uses kernel `\@slowromancap`, equal to `\MakeUppercase{\romannumeral n}` |
| notes | awesome-cookbook.cls:698-711 | `list.enumitem`, `tbl.tabular` | `enumerate[label=\color{awesome}\Huge\bullet]`; `\newcolumntype{?}{!{\color{base}\vrule width 1.5pt}}`; note body in `tabular[t]{?p{\dimexpr\linewidth-2\tabcolsep}}` |
| recipe figures | awesome-cookbook.cls:729-787 | `fig.graphicx`, `fig.float`, `bg.eso-pic`, `color.transparent`, `fig.adjustbox`, `fig.subcaption`, `page.geometry` | `wide`: `figure[h]`, `\makebox`, `\includegraphics[height=..\textheight]` (:747-752); `background` (opacity 0.5) and `fullpage` are one image placed on the page (:732-745); `crop` and `fullpage4` hit the `\ClipImage` blocker; `\setImageDir` = `\graphicspath` (:155); not in sample |
| energy list | awesome-cookbook.cls:794-807 | `head.kernel`, `tbl.tabular`, `cols.multicol`, `tbl.longtable` | `\chapter{\@energy}`, header tabulars, `multicols{2}`; needs `multicolslongtable`; not in sample |
| icons beside metadata | awesome-cookbook.cls:547-595 | `art.tikz`, `fig.graphicx`, `box.minipage` | ART/class (borderline); fields servings, time, energy, cost, source, urlsource; icons resources/icons/*.png |
| loaded, never called | awesome-cookbook.cls:84, :86, :90, :92 | `tbl.longtable`, `tbl.booktabs`, `fig.subcaption`, `fig.adjustbox` | load-only except where listed above; `booktabs` has no `\toprule` call |
| Lua workflow | awesome-cookbook.cls:902-903 | none | BESPOKE/class, blocker |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `awesome-cookbook` | awesome-cookbook.cls:9-903 | No | `class.book` plus the pieces in this table; blockers above |
| user setters `\cookbookName`, `\nPreface`... `\nIcons`, `\setLicense`, `\setIconSize`, `\setFontDir`, `\setRecipesDir` | awesome-cookbook.cls:128-178 | Yes | strings and lengths stored in macros; an emitter inlines the values (`\newrobustcmd` from `etoolbox` is only the definition form) |
| `\vhrulefill` | awesome-cookbook.cls:342 | Yes | `sp.rule`: `\leaders\hrule height 2pt\hfill` |
| `\category` | awesome-cookbook.cls:383 | Yes (alias) | `\part{...}` (`head.titlesec`); its title page is ART |
| part title pages style1, style2 | awesome-cookbook.cls:387-437 | No | `ART/class` TikZ overlay |
| `\recipe` with `pgfkeys` dispatch | awesome-cookbook.cls:447-507 | Partly | `\clearpage`/`\cleardoublepage` and `\section` reduce (`pg.break`, `head.titlesec`); banners style1, 2, 4 are ART; style3 is `\fontsize{45}{0}` text plus `\hrule` (`font.size-commands`, `sp.rule`) |
| `preface` | awesome-cookbook.cls:514-519 | Yes | `head.kernel` `\chapter*` and fixed text |
| `\info` | awesome-cookbook.cls:527-595 | No (not shown) | `ART/class` (borderline) |
| `ingredients`, `ingredientsc`, `column` (env-local `\ingredient`) | awesome-cookbook.cls:602-616, :637-661 | Yes | `fig.wrapfig` + `tbl.tabular` + `color.xcolor`; `fig.float` + `fig.subcaption`; the in-environment `\newrobustcmd` is a row alias |
| `ingredientsh` | awesome-cookbook.cls:619-634 | No | built on `multicolslongtable` |
| `multicolslongtable` | awesome-cookbook.cls:185-197 | No | `BESPOKE/class`: box and internal-counter hack |
| `\ClipImage` | awesome-cookbook.cls:206-218 | No | `BESPOKE/class`: computed trim |
| `\wrapfill` | awesome-cookbook.cls:224-234 | Yes (dead code) | defined, never called (call commented at :673); touches `wrapfig` internals `\WF@fudgeparshape`; an emitter omits it |
| `preparation`, `alternatives`, `notes`, `\refstep`, `\refaltstep` | awesome-cookbook.cls:665-711 | Yes | `list.enumitem` labels, `tbl.tabular` with a coloured column rule, `mark.case`; env-local `\step`, `\alternative`, `\note` are `\item` aliases |
| `\recipefigure` styles background, fullpage, wide | awesome-cookbook.cls:732-752 | Yes | `bg.eso-pic` or `fig.graphicx` with `color.transparent`; the TikZ is only an image placement |
| `\recipefigure` styles crop, fullpage4 | awesome-cookbook.cls:754-786 | No | needs `\ClipImage`; undefined `\pagewidth`; tuned `\vspace{-0.2165\pageheight}` |
| `energylist` | awesome-cookbook.cls:794-807 | No | built on `multicolslongtable` |
| `\makeCover` | awesome-cookbook.cls:815-851 | No | `ART/class` |
| `\maketitlepages`, `\beginCookbook`, `\beginRecipes`, `\beginAppendices` | awesome-cookbook.cls:855-894 | Yes (apart from the cover call) | page style, matter and title-page ways listed in the map |
| Lua `require` and `\autoGenerate` | awesome-cookbook.cls:902-903 | No | `BESPOKE/class`; `autogenerate.lua` absent |
| `fontawesome.sty` (fork of the CTAN `fontawesome`, Claud D. Park, 2015, v4.4.0) | fontawesome.sty:1-683 | Yes | one `fontspec` family, `\faicon` (lines 12-18) and 663 icon-name definitions of one shape (lines 20-682); no icon is called, so it reduces to `font.icons` load-only (CTAN `fontawesome` v4.6.3.2, LPPL 1.3, is the published package) |

## Content-opaque
- Icon images `resources/icons/time.png`, `servings.png`, `energy.png`, `source.png` (placed by `\info`, awesome-cookbook.cls:553, :560, :567, :582) and the 10.9 MB `resources/kitchen icon pack.tar` (not opened). Fonts `fonts/Roboto-*.ttf`, `fonts/SourceSansPro-*.otf`, `fonts/FontAwesome.ttf` are shipped assets. Missing asset: `autogenerate.lua`.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
