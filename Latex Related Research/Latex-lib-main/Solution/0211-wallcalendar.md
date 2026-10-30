no

# 0211-wallcalendar: wallcalendar (Lua/TikZ wall-calendar class, CTAN) with its manual and 18 example calendars

- Unverified: read from the source, not compiled.
- Source: Source/0211-wallcalendar/ (origin: https://mirrors.ctan.org/macros/luatex/latex/wallcalendar.zip; licence: lppl1.3 (LICENSE.txt:9), bundled Lua modules are MIT (wallcalendar-csv.lua:15, wallcalendar-date.lua:7))
- Kind: calendar
- Lib: v2
- Engine: needs LuaLaTeX (class loads `luacode` and calls `\luadirect`: wallcalendar.cls:171,999; examples use `fontspec`; the manual is built with `lualatex -shell-escape`: doc/latexmkrc:3)
- Look carried by: mixed (calendar samples: CTAN class wallcalendar.cls plus hook values in the sample preamble; manifest main, the manual: zip-local doc/memoir-article.cls and doc/local.sty)
- Class origin: ctan (wallcalendar, README.md:200-202; the manual's class `memoir-article` is zip-local: ctan.org/pkg/memoir-article is a 404, see Class setting)
- Main file: doc/wallcalendar.tex (the manifest's main: the user manual, an Org export, wallcalendar.tex:1-3). The component map below covers it and the template samples, chiefly doc/examples/cal-photo-and-notes.tex (other samples: the 17 other doc/examples/cal-*.tex; include files doc/examples/forest.tex, frog*.tex)
- Read: main yes (doc/wallcalendar.tex 1-1820, cal-photo-and-notes.tex 1-218), zip-local classes and styles all (wallcalendar.cls 1-3462, doc/memoir-article.cls, doc/local.sty, doc/examples/local-{english,hungarian,japanese}.sty, i18n/wallcalendar-english.tex and -japanese.tex); wallcalendar-helpers.lua read in full, wallcalendar-csv.lua and wallcalendar-date.lua (third-party MIT libraries) only their headers and function outline

## Verdict
No. The calendar look is carried by the published CTAN class `wallcalendar`, and the showcase sample cal-photo-and-notes.tex alone is class options, `fontspec` and colour lines, hook values and one raw TikZ day overlay. But the manifest's main sample, the manual, loads the zip-local doc/local.sty, which loads `minted` unconditionally (EXTERNAL), and the zip-local doc/memoir-article.cls hand-redefines `\@maketitle` and `\backmatter` and patches `titletoc` internals (BESPOKE). Two other samples copy hand-written layout macros that read class state under conditionals (the thumbnails page, `\YearPlannerPage`). A wrong yes costs more, so I did not narrow the answer to the one clean sample.

## Blockers
- `EXTERNAL/preamble` `minted` loaded unconditionally by the zip-local style the main sample loads; `verbatim` is redefined to a minted environment, so every code block runs pygments; the build uses `-shell-escape` (doc/local.sty:36,41,43-48; doc/wallcalendar.tex:4; doc/latexmkrc:3)
- `BESPOKE/class` zip-local doc/memoir-article.cls hand-writes `\@maketitle` with a conditional that prints `\docVersion`, `\today`, `\docUrl` (doc/memoir-article.cls:308-322)
- `BESPOKE/class` zip-local doc/memoir-article.cls redefines `\backmatter` through memoir internals `\@memback@floats`, `\ifartopt`, `\@mainmatterfalse` (doc/memoir-article.cls:324-329)
- `BESPOKE/class` zip-local doc/memoir-article.cls patches package internals: `\let\ttll@appendix\ttll@chapter`, `\renewcommand\chapternumberline` and `\partnumberline` (doc/memoir-article.cls:201-206)
- `BESPOKE/preamble` copied page macros `\ThumbWithCaptionLeftSide`, `\ThumbWithCaptionRightSide`, `\ThumbsPage`: pgfkeys reads of class state, `\ifx..\empty` fallback, `\ifvarnishmask`, `\ifdimcomp` computed `\thumbSep` (doc/examples/cal-thumbnails.tex:13-179; same code printed at doc/wallcalendar.tex:1009-1189)
- `BESPOKE/preamble` user rewrite of the class's Lua call `\@wall@plm` and a user Lua `format func` (doc/wallcalendar.tex:892-898, 650-663)

## Class setting
- Class: `class.wallcalendar` options: `year`, `language`, `eventsCsv`, `moonsCsv`, `markDefaultsCsv`, `imageFolder`, `paperWidth`/`paperHeight`, `hMargin` `leftMargin` `rightMargin` `topMargin` `bottomMargin`, `trimSpace`, presets `a2Paper` `a3Paper` `a4Paper` `a4PaperLandscape` `a5Paper` `choralOctavoPaper`, booleans `showtrims` `showframe` `varnishmask` `sundayFirst` `gridSurround` `loadBabel`, `dateAnnotations`, `translationsInputFile` (wallcalendar.cls:58-115; the sample sets year, language, eventsCsv, markDefaultsCsv, imageFolder, paperWidth=11in - 15mm, paperHeight=8.5in - 15mm, trimSpace=15mm, topMargin=15mm at cal-photo-and-notes.tex:1-12). Unknown options go to memoir (wallcalendar.cls:119-121), which it loads as `\LoadClass[11pt,oneside]{memoir}` (wallcalendar.cls:138).
- Class-native vocabulary used: `\SetPhoto[bleed,file,xOffset,yOffset,thumbFile,caption,disabled]{Month}`, `\SetQuote[xOffset,yOffset]{Month}{text}`, `\SetCalendar[bg/.style]{Month}`, `\SetEvents{Month}{tikz marks}{text}`, `\MonthPage[layout=..., put photo=..., put quote=...]{Month}`, `\TitlePage{image}{overlay height}{text}`, `\parseMonthMarksDayTextInlineUsing{csv}`, `\parseMonthInlineNotes`, `\semicolonEndTikzCalendar`, `\calDayNumberNode`, `\setTestDateTime`, hook macros `\monthFmt` `\yearFmt` `\dayLetterFmt` `\dayLetterTextFmt` `\dayTextFmt` `\quoteFmt` `\headingFmt` `\calendarFmt` `\eventsFmt` `\photoAndNotesFmt` `\notepadContent`; other samples add `\YearPlannerPortrait` `\YearPlannerLandscape` `\YearPlannerLandscapeGridPage` `\YearPlannerCompact` `\plannerEvents` `\plannerWeeklyNotes` `\plannerWeeklyImages` `\parseMonthEvents[format cmd,filter pred,format func]`, `\SetTxt`/`\txt`.
- The manual's class is the zip-local `memoir-article` (`\LoadClass{memoir}`, doc/memoir-article.cls:45), not a published way; its reduction is in the Bespoke table.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (template) | cal-photo-and-notes.tex:1-12; wallcalendar.cls:13,58-115 | `class.wallcalendar` | options listed under Class setting |
| underlying class | wallcalendar.cls:119-121,138 | `class.memoir` | 11pt, oneside, unknown options passed through |
| month page: photo, quote, calendar grid, events, notepad | cal-photo-and-notes.tex:70-131,210-216; wallcalendar.cls:846-938,1693-1915 | `class.wallcalendar` | `\SetPhoto` file=green-mountains-crop-us-letter bleed=3mm; `\SetQuote` xOffset=0pt yOffset=-15mm; `\SetCalendar[]`; `\MonthPage` layout=photo and notes, put photo=full page; other layouts full page, small landscape, large calendar (wallcalendar.cls:915-920) |
| year planners (portrait, rows, grid, compact) | doc/examples/cal-year-planner.tex:62; cal-year-planner-rows.tex:47; cal-year-planner-grid.tex:48; cal-year-planner-compact.tex:118; wallcalendar.cls:3060-3235 | `class.wallcalendar` | one class command per planner; `dateAnnotations`, `moonsCsv`, a4Paper/a4PaperLandscape, margins |
| event and moon data from CSV, marks | cal-photo-and-notes.tex:4-5,127,130; wallcalendar-helpers.lua:7-14,223-258,399-437 | `class.wallcalendar` | `eventsCsv`, `markDefaultsCsv`, `moonsCsv`, `\parseMonth*`; the CSV files are content |
| language, month and day names | cal-photo-and-notes.tex:3; wallcalendar.cls:3286-3336; i18n/wallcalendar-english.tex:3-44 | `class.wallcalendar` | `language=english`, `translationsInputFile`, `\SetTxt`; 20 name files i18n/*.tex |
| optional babel | wallcalendar.cls:151-153,177-179 | `lang.babel` | `loadBabel=true` loads `babel` with the calendar language; `microtype` gets `babel=true` |
| title page over a full photo | cal-photo-and-notes.tex:203-208; wallcalendar.cls:3244-3281 | `front.class-native` | image, overlay height 60mm, title text (white overlay opacity 0.4 is fixed in the class) |
| title page overlay mechanism | wallcalendar.cls:164,3248 | `bg.eso-pic` | `\AddToShipoutPictureFG*` with a fixed offset of -3mm |
| paper, margins, trims, crop marks | wallcalendar.cls:245-267 | `page.memoir-layout` | `\setstocksize`, `\settrims`, `\setlrmarginsandblock{l}{r}{*}`, `\setulmarginsandblock{t}{b}{*}`, `\quarkmarks` for showtrims, `\setheadfoot{0pt}{0pt}` |
| page style, empty heads and feet | wallcalendar.cls:1132-1138,3246 | `hf.memoir-pagestyle` | `\makepagestyle{month}` with six empty fields; `\thispagestyle{empty}` is `hf.pagestyle-kernel` |
| base font size | wallcalendar.cls:274-285 | `font.size-commands` | `\@setfontsize\normalsize` 11/13.6, colour `textbody` |
| paragraph and box lengths | wallcalendar.cls:291-294 | `sp.lengths` | `\parskip`=0pt, `\parindent`=0pt, `\fboxsep`=0pt |
| main font and families | cal-photo-and-notes.tex:29-36 | `font.fontspec` | `\defaultfontfeatures{Ligatures={TeX}}`, `\setmainfont{TeX Gyre Pagella}`, `\newfontfamily\dejaVuSans{DejaVu Sans}`, `\newfontfamily\josefinSans[Path={./fonts/}]{JosefinSans-Regular.ttf}` |
| emoji and tracking (other samples) | cal-year-planner-compact.tex:20; cal-year-planner-grid.tex:24 | `font.fontspec` | `\newfontfamily\EmojiFont{Noto Color Emoji}[Renderer=Harfbuzz]`; tracking is the next row |
| letterspacing | cal-photo-and-notes.tex:47; cal-year-planner-grid.tex:24; wallcalendar.cls:178-180 | `sp.microtype` | `microtype` [final]; `\textls*`; `\SetTracking[spacing={350,100,}]{encoding=*, family=...}{120}` |
| colours | cal-photo-and-notes.tex:24-25; wallcalendar.cls:204-241 | `color.xcolor` | `\colorlet{mooncolor}{darkgold}`, `\colorlet{sunday}{red}`; class cmyk gold/darkgold, gray levels |
| page background colour (planner grid) | wallcalendar.cls:3208 | `color.pagecolor` | `\pagecolor{pagebgcolor}` |
| hook fonts and sizes (sample) | cal-photo-and-notes.tex:40-52 | `font.size-commands` | `\LARGE`, `\small`, `\tiny`, `\fontsize{6}{8}\selectfont` inside `\renewcommand*` of class hooks |
| hook alignment (sample) | cal-photo-and-notes.tex:49-52 | `sp.ragged` | `\centering`, `\raggedright`, `\setlength{\parindent}{0pt}` |
| hook lengths (sample) | cal-photo-and-notes.tex:53-59 | `sp.lengths` | `\@t@calendar@minimumHeight`=`\calPaperHeight - 30mm`, `\@t@calendar@hmargin`=20pt, `\@t@calendar@verticalSpacing`=30mm (documented at doc/wallcalendar.tex:1800-1806) |
| notepad dotted lines | wallcalendar.cls:1641-1667 | `sp.rule` | `\dotfill\par` repeated 2, 4 or 6 times, colour black!40, `\parskip`=10pt |
| graphics and image path | wallcalendar.cls:158-160; cal-photo-and-notes.tex:98 | `fig.graphicx` | `\DeclareGraphicsExtensions{.pdf,.png,.jpg}`, `\graphicspath`, `\includegraphics[width=...]` |
| underline for planner notes | wallcalendar.cls:163,2974-2994 | `mark.ulem` | `soul` `\ul`, `\setul`, `\setulcolor` |
| moon phase glyphs | wallcalendar.cls:167,750-753 | `font.icons` | `wasysym` `\CIRCLE` `\LEFTcircle` `\Circle` `\RIGHTcircle` |
| multicolumn event notes (rows planner) | cal-year-planner-rows.tex:55-60; wallcalendar.cls:166 | `cols.multicol` | `multicols{5}` |
| manual: class, layout | doc/wallcalendar.tex:3; doc/memoir-article.cls:45,161-174 | `class.memoir` | `\stockaiv`, `\setlrmarginsandblock{0.1\paperwidth}{*}{3}`, `\setulmarginsandblock`, `\setheadfoot`, `\setfootins`, `\setmarginnotes{17pt}{45mm}{20pt}` (layout part is `page.memoir-layout`) |
| manual: language and fonts | doc/memoir-article.cls:47-79 | `lang.babel` | `[british]`; fonts: `font.fontspec` `\setmainfont[ItalicFont=Crimson Italic,...Numbers=Lining]{Crimson Roman}`, `mathdesign[bitstream-charter]`, `amsmath` |
| manual: headings | doc/memoir-article.cls:298-376 | `head.memoir-style` | `\makechapterstyle{vinaya-class}`, `\setsecheadstyle`, `\setbeforesecskip`, `\hangsecnum`, `\headstyles` |
| manual: contents | doc/memoir-article.cls:198-257; doc/frontpage.tex:172 | `toc.titletoc` | three `\titlecontents`, `\contentsmargin{0pt}`; `\tableofcontents*` is `toc.kernel` |
| manual: running heads | doc/memoir-article.cls:378-382 | `hf.memoir-pagestyle` | `\makepagestyle{normalpage}` page number outer |
| manual: lists | doc/memoir-article.cls:105-113; doc/wallcalendar.tex:32,1567 | `list.enumitem` | `\setlist[itemize]{leftmargin=15pt,itemsep=3pt,...}`; the lists themselves are `list.kernel` |
| manual: links and bookmarks | doc/memoir-article.cls:85-103; doc/wallcalendar.tex:5-17,1295 | `meta.hyperref` | `colorlinks=true`, `linkcolor=link`, `unicode=true`, `\hypersetup{pdfauthor,pdftitle}`; `bookmark[open,openlevel=2]`; `\hyperref[..]` is `xref.hyperref` |
| manual: title block | doc/wallcalendar.tex:8-10,20; doc/memoir-article.cls:311-322 | `front.maketitle` | `\title` `\author` `\date` `\maketitle`; the printed look is the bespoke `\@maketitle` |
| manual: code listings | doc/local.sty:36-48 | `code.minted` | `\setminted{bgcolor=code-bg, fontsize=\footnotesize}`, `\newminted{tex}{frame=single}`, `verbatim` redefined (**EXTERNAL**) |
| manual: captions | doc/memoir-article.cls:262-263 | `cap.memoir` | `\captionnamefont{\footnotesize}`, `\captiontitlefont{\footnotesize}` |
| manual: columns, wide blocks, example pages | doc/wallcalendar.tex:1235; doc/memoir-article.cls:84,265-277; doc/local.sty:50-70; doc/frontpage.tex:19-168 | `cols.multicol` | `multicols{2}` with `\columnbreak`; `fullwidth`, `extrafullwidth`, `\twocol` are `box.minipage` of fixed width |
| manual: images of the examples | doc/frontpage.tex:30-163; doc/wallcalendar.tex:91-93 | `fig.graphicx` | `\frame{\includegraphics[width=5cm]{...}}` (pictures are content) |
| manual: hyphenation and sloppiness | doc/memoir-article.cls:115-119 | `sp.hyphenat` | `\hyphenation{...}`, `\midsloppy` |
| manual: underlined section heads | doc/memoir-article.cls:288-301 | `mark.ulem` | `ulem[normalem]`, `\ULdepth`, `\ULthickness` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\@maketitle` with `\ifshowdocinfo` | doc/memoir-article.cls:308-322 | No | hand-written kernel-internal title block with a conditional that prints three macros |
| `\backmatter` redefinition | doc/memoir-article.cls:324-329 | No | uses memoir internals `\@memback@floats`, `\ifartopt` |
| titletoc and memoir internal patches | doc/memoir-article.cls:201-206 | No | `\let\ttll@appendix\ttll@chapter` and two `\renewcommand` of number lines work around package internals |
| `minted` and `verbatim` redefinition | doc/local.sty:36-48 | No | needs pygments and shell escape (EXTERNAL); no lib way avoids the tool |
| thumbnails page macros | doc/examples/cal-thumbnails.tex:13-179 | No | macro logic over pgfkeys state with `\ifdimcomp`, `\ifx..\empty`, `\ifvarnishmask`; an emitter would have to copy it |
| `\@wall@plm` rewrite, Lua `format func` | doc/wallcalendar.tex:892-898,650-663 | No | user Lua code, outside the lib |
| `\YearPlannerPage` and pre/post hooks | doc/examples/cal-year-planner.tex:24-72 | Yes, with varnishmask off | `sp.lengths` on `\markNumberAbove` etc., `sp.manual-space`, `sp.ragged`, then the class command; the `\ifvarnishmask` branch is a conditional, so not reducible when that option is on |
| hook overrides in the sample | doc/examples/cal-photo-and-notes.tex:40-66 | Yes | `font.fontspec`, `font.size-commands`, `sp.microtype`, `sp.ragged`, `sp.lengths` values inside class hook slots |
| compact planner page composition | doc/examples/cal-year-planner-compact.tex:77-180 | Yes | `bg.eso-pic` `\AddToShipoutPictureBG*` + `box.minipage` + three filled rectangles as `sp.rule` in `color.xcolor` colours + class commands |
| `\emoji` alias | doc/examples/cal-year-planner-compact.tex:23 | Yes | `font.fontspec` family switch |
| `\SeptMarks` mark string | doc/examples/frog-english.tex:9-12 | Yes | string argument of `\SetEvents` plus `font.fontspec` glyph switch |
| memoir-article packages, fonts, heads, toc | doc/memoir-article.cls:47-103,214-257,298-376 | Yes | `lang.babel`, `font.fontspec`, `math.amsmath`, `list.enumitem`, `meta.hyperref`, `meta.bookmark`, `toc.titletoc`, `head.memoir-style` |
| `fullwidth`, `extrafullwidth`, `\fullpage`, `\includemap`, `summary`, `\twocol` | doc/memoir-article.cls:188-194,265-286,384-393; doc/local.sty:50-70 | Yes | `box.minipage`, `sp.manual-space`, `bg.eso-pic`, `fig.graphicx`; `summary` is unused by the manual |
| solarized colours | doc/local.sty:5-34 | Yes | `color.xcolor` |
| local-english/hungarian/japanese styles | doc/examples/local-english.sty:3-6; local-japanese.sty:3-23 | Yes | `font.fontspec` families; hook renewals as above |
| wallcalendar.cls, its three Lua modules | wallcalendar.cls:1-3462; wallcalendar-helpers.lua; wallcalendar-csv.lua; wallcalendar-date.lua | n/a, published | CTAN code, so the class is a way, not bespoke; it computes layout with Lua, `\calendar` day scopes and coffins (wallcalendar.cls:999,2192-2346) |

## Content-opaque
- Raw TikZ in `\SetEvents`: a photo node, a white circle and a white box (opacity 0.6) placed on 18 September (cal-photo-and-notes.tex:93-130), and the same in the manual (doc/wallcalendar.tex:797-825). Day-level decoration of one document, so content; `art.tikz` is the restricted way.
- Data and artwork: photos (doc/examples/photos/), CSV events and moon data (doc/examples/data/*.csv), shipped PDFs and JPGs, the class's own TikZ drawing (wallcalendar.cls:658-762,2150-2507) which lives inside the published class.
- Generators, shipped outputs only: Org source to wallcalendar.tex (doc/export-init.el:1-10, doc/doc-setup.org), moon CSVs from a PyEphem script (doc/examples/scripts/generate_moon_phases.py:14-16), Makefile with `pdftk` bursts (doc/examples/Makefile:21,24). None is needed to compile a sample.
- Missing assets: TeX Gyre Pagella, DejaVu Sans, Noto Color Emoji, IPAPMincho and Alegreya Sans are not shipped (only JosefinSans-Regular.ttf is).

## Lib changes
- New ways proposed: `class.wallcalendar` the `wallcalendar` class vocabulary, LuaLaTeX, with `\SetPhoto` `\SetQuote` `\SetCalendar` `\SetEvents` `\MonthPage` `\YearPlanner*` and class options. W1: CTAN, TeX Live since 2018 (README.md:200-202). W2: class options, key lists (`layout`, `put photo`, `bleed`, offsets, `bg/.style`), CSV paths and font/length hooks are values; writing a new layout handler macro or a Lua `format func` is outside the way and is bespoke. W3: any wall, desk or year-planner calendar. W4: one `\documentclass[...]` line, `\Set*` lines in the preamble and `\MonthPage[...]{Month}` in the body. A way apart from `cal.kalender` (one German grid, year the only value).
- Considered, not proposed: `xcoffins` (page parts joined as coffins, used only inside the class, wallcalendar.cls:173,1148-1155; an emitter never writes it); `\enlargethispage` (doc/wallcalendar.tex:1001,1055,1213: one kernel page-height command with no exact home, nearest `sp.manual-space`, not stretched).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this).

## Notes
- No text addressed to an AI was found in the zip.
- Bespoke rows: 15 listed plus the published-class row (not counted); 6 irreducible, 1 reducible only with varnishmask off, 8 reducible.
- If the main sample were only cal-photo-and-notes.tex the look would be class-carried (`class.wallcalendar`, `class.wallcalendar`, hook values) with the raw TikZ overlay as content; the no comes from the manifest main (manual) and from other samples in the zip.
