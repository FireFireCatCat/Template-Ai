no

# 0475-alexpovel-latex-cookbook: ACP thesis/book template ("A modern LaTeX cookbook")

- Unverified: read from the source, not compiled.
- Source: Source/0475-alexpovel-latex-cookbook/ (origin: https://codeload.github.com/alexpovel/latex-cookbook/zip/refs/heads/main; licence: MIT)
- Kind: book (a thesis/book template: manifest hint was misc; the sample is a KOMA book-style document with title page, task page, declaration, glossaries, chapters, appendix, bibliography, index)
- Lib: v4
- Engine: needs LuaLaTeX (acp.cls:20 `\RequireLuaTeX{}`; also `fontspec`/`unicode-math` at acp.cls:475-527, `\directlua` at acp.cls:591)
- Look carried by: zip-local (the look is the 3586-line zip-local class acp.cls built on `scrbook`; cookbook.tex only sets class options and title metadata)
- Class origin: zip-local (acp.cls:4 "Author (2021): Alex Povel"; acp.cls:14 `\ProvidesClass{acp}`; https://ctan.org/pkg/acp returned 404, so it is not a CTAN class; not a publisher kit)
- Main file: cookbook.tex (other samples: none; body is imported from chapters/frontmatter.tex, chapters/mainmatter.tex, chapters/backmatter.tex and the files under chapters/frontmatter/ and chapters/mainmatter/)
- Read: main partly (cookbook.tex, frontmatter.tex, mainmatter.tex, backmatter.tex, all five chapters/frontmatter/*.tex; the four mainmatter chapters read in part: base-features.tex 1-160, 515-545, 681-1060, 1222-1261; floats.tex 1-200, 2000-2092; the rest of those chapters surveyed by grep for definitions, environments and external-tool use, not read line by line), zip-local classes and styles all (acp.cls fully read; the PGF shape bodies at 2080-2195 only skimmed by outline). Not read: tests/, Makefile body beyond 1-60, pandoc/, lib/example.lua, data/matlab2tikz_table_example.tex (generated data, no `\documentclass`).

## Verdict
`no`. The look is carried by a zip-local class that unconditionally loads `minted` (Python/pygments, shell escape), `svg` (Inkscape, shell escape) and `glossaries-extra` in `record` mode (needs the Java tool bib2gls), so the document does not compile without three outside tools. The class also runs Lua with `io.popen` to read git state, and ships a library of hand-written PGF node shapes and custom glossary table styles; none of that reduces to lib ways. Much of the rest (KOMA setup, page styles, captions, floatrow, siunitx, hyperref, titlepage macros) does map to lib ways and is listed below.

## Blockers
- `EXTERNAL/package` `minted` loaded unconditionally by the class (needs Python and pygments, `autogobble` needs python, shell escape); the pilot ruling applies even if the sample never called it, and it does call it (18 `minted` environments and an `\inputminted`; acp.cls:372-379, 385; chapters/mainmatter/code-listings.tex:52, 414; chapters/mainmatter/usage.tex:50)
- `EXTERNAL/package` `svg` loaded unconditionally (runs Inkscape, needs `--shell-escape`); `\includesvg` is used in figures (acp.cls:1257-1278; chapters/mainmatter/floats.tex:9-23, 96, 117, 134)
- `EXTERNAL/package` `glossaries-extra` with `record` plus `\GlsXtrLoadResources` needs the Java tool bib2gls and a latexmk custom dependency to produce `.glstex` (acp.cls:2731-2739, 2832-2915; .latexmkrc:135-150; chapters/mainmatter/base-features.tex:1019-1030, 1222-1228)
- `BESPOKE/class` Lua in `\directlua` that calls `io.popen("git rev-parse ...")`, reads CI environment variables and defines `\GitRefName` and `\GitShortSHA` with `token.set_macro`; with the `xstring` banner built from `\luatexbanner` (acp.cls:577-582, 591-657); printed in the colophon and the PDF creator string (chapters/frontmatter/colophon.tex:33-35; acp.cls:2672). Irreducible: computed at compile time from outside TeX
- `BESPOKE/class` about a dozen hand-written PGF node shapes (`\pgfdeclareshape` for valve, threeway valve, fourway valve, controlvalve, pump, compressor, heat exchanger, radiator, sensor, levelindicator...) with anchors and background paths, plus TikZ `pic`s and style sets that use them, and `\parsenode` for "add node at x" (acp.cls:1977-2556, 1521-1975, 1513-1516). Low-level PGF path code; no lib way holds it (`art.tikz` is a restricted content way). Used only inside figures in the sample, but shipped by the class
- `BESPOKE/class` custom glossary styles that `\renewenvironment{theglossary}` into `longtabu` and redefine `\glossentry`, `\glsgroupheading`, `\glossaryheader` under `\ifglsnonumberlist` (acp.cls:3000-3161), plus `\glsdefpostname` / `\glsdefpostdesc` conditional hooks (acp.cls:2949-2968); package-internal redefinition code
- `EXTERNAL/body` pgfplots `contour gnuplot` runs gnuplot (chapters/mainmatter/floats.tex:966-972, 1135, 1148; chapters/mainmatter/usage.tex:46-48); inside figure content, recorded as content-opaque, not counted on its own
- Not counted (side path, not needed to compile cookbook.tex): Makefile, pandoc/defaults.yaml and pandoc/promote-headers.lua (a pandoc route for the README, Makefile:135-164); `.latexmkrc` calls `biber` and `bib2gls` (.latexmkrc:97, 135-150)

## Class setting
- Class: `class.acp` is zip-local, not published; it does `\LoadClass{scrbook}` (acp.cls:22, 64), so the published class underneath is `class.scrbook`. Options of the zip-local class: `language=english` (kvoptions string, acp.cls:33), `titlestyle=thesis|book` (acp.cls:34, 707, 764), `censoring=true` (bool, acp.cls:35, 1207), `a5` (acp.cls:53-57); everything else is forwarded to scrbook (acp.cls:60). Fixed pass-through to scrbook: `twoside`, `listof=totoc`, `bibliography=totoc`, `chapterprefix=true`, `open=right`, `numbers=noenddot` (acp.cls:38-48). Sample call: `language=english, titlestyle=thesis, BCOR=5mm, a4, censoring=true` (cookbook.tex:11-19).
- Class-native vocabulary used (KOMA scrbook as seen through acp): `\subtitle`, `\publishers` (cookbook.tex:45, 64), `\documenttype`, `\idnumber` (zip-local, cookbook.tex:60, 62), `\frontmatter`, `\mainmatter`, `\backmatter` (chapters/frontmatter.tex:11, chapters/mainmatter.tex:1, chapters/backmatter.tex:293), `\addchap` (chapters/frontmatter.tex:30, 59; chapters/frontmatter/preface.tex:1), `\chapter*` (chapters/frontmatter/task.tex:1), `\cleardoubleoddpage` (chapters/frontmatter/authorship_declaration.tex:4), `\setkomafont`, `\addtokomafont`, `\newkomafont`, `\usekomafont`, `\KOMAoptions`, `\KOMAoption`, `\chapterformat`, `\chaptermarkformat`, `\providecaptionname`, `\KOMAScriptVersion` (acp.cls:676-873, 95-278, chapters/frontmatter/colophon.tex:40).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | acp.cls:22, 64 | `class.scrbook` | base of acp; twoside, listof=totoc, bibliography=totoc, chapterprefix=true, open=right, numbers=noenddot |
| paper and margins | cookbook.tex:15-16; acp.cls:53-57 | `page.typearea` | BCOR=5mm; a5 gives `paper=a5` to typearea and fontsize=10pt |
| paper by class option | cookbook.tex:16; acp.cls:60 | `page.class-options` | `a4` forwarded to scrbook |
| page numbering | chapters/frontmatter.tex:7 | `pgnum.pagenumbering` | alph for the title, then `\frontmatter` roman |
| forced blank/recto pages | chapters/frontmatter/authorship_declaration.tex:4; acp.cls:898 | `pg.break` | `\cleardoubleoddpage`; KOMA `cleardoublepage=blank` |
| landscape pages | acp.cls:916; chapters/mainmatter/base-features.tex:1254 | `pg.landscape` | `pdflscape` `landscape` environment |
| running heads | acp.cls:840-873 | `hf.scrlayer-scrpage` | automark; `\lehead` `\rohead` with `\pagemark` and `\headmark`; pagehead font sffamily itshape footnotesize; pagenumber font sffamily bfseries footnotesize |
| blank-page layer | acp.cls:891-898 | `hf.scrlayer-scrpage` | `\DeclareNewLayer[foreground,textarea]{blankpage.fg}`, `\DeclarePageStyleByLayers{blank}` |
| empty page style | chapters/frontmatter/colophon.tex:4 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| header rule | acp.cls:845-852 | `sp.rule` | `\rule[-1ex]{0.1em}{3ex}` through a new length |
| line spread | acp.cls:1218-1228 | `sp.linespread` | `\linespread{1.05}`; KOMA `singlespacing=true` is class vocabulary |
| spacing in title block | acp.cls:733, 1218 | `sp.setspace` | `spacing` environment 1.1 |
| manual space and fill | acp.cls:730, 737, 756; chapters/frontmatter/colophon.tex:5 | `sp.manual-space` | `\vspace`, `\vfill`, `\hfill`, `\vspace*{\fill}` |
| ragged text | acp.cls:676, 734 | `sp.ragged` | `\raggedleft`, `\raggedright` |
| microtypography | acp.cls:910 | `sp.microtype` | defaults |
| breakable hyphens | acp.cls:908 | `sp.hyphenat` | package `extdash` with `shortcuts` (same type as hyphenat: break opportunity at a hyphen; the package is the parameter) |
| main/sans/mono/math fonts | acp.cls:488-540 | `font.fontspec` | `\setmainfont` TeX Gyre Pagella (Numbers=Lowercase); `\setsansfont` Merriweather Sans; `\setmonofont` inconsolata (AutoFakeSlant, Scale=MatchLowercase); `\newfontfamily\unitnumberfont` |
| math font | acp.cls:475-482, 515-527 | `font.unicode-math` | `\setmathfont` TeX Gyre Pagella Math; mathrm/it/sf/bf/tt=sym; NFSSFamily=tgpl; warnings-off list |
| icons and logos | acp.cls:545, 564; chapters/frontmatter/colophon.tex:33, 36 | `font.icons` | `fontawesome5`, `hologo` |
| font sizes | acp.cls:699, 709; chapters/frontmatter/colophon.tex:10 | `font.size-commands` | `\footnotesize`, `\Huge`, `\Large` |
| colours | acp.cls:312-364 | `color.xcolor` | `x11names`; `\colorlet` g1..g6; `\definecolor` darklink, rdylbu1-6, Set2A-H, mBlue.., cRed.. |
| language | acp.cls:926-942 | `lang.polyglossia` | `\setdefaultlanguage{<language>}`, `\setotherlanguages{german,english}` |
| caption names per language | acp.cls:95-278 | `lang.polyglossia` | about 60 `\providecaptionname{english\|german}{\TransX}{text}` strings (KOMA vocabulary) |
| quotation marks, display quote | acp.cls:945-950; chapters/mainmatter/base-features.tex:135 | `lang.csquotes` | `autostyle=true`; `\mkbegdispquote` adds `\itshape`; `displayquote`, `\enquote` |
| title block | cookbook.tex:39-67 | `front.maketitle` | `\author`, `\date{\DTMtoday{}}`, `\title` |
| title extras | cookbook.tex:45, 64 | `front.koma-title` | `\subtitle` (a tabular of examiners), `\publishers` |
| title page layout | acp.cls:707-814 | `front.titlepage-env` | `titlepage` + two `minipage`s (0.05 and 0.75 of textwidth, height textheight), `\rule{0.15em}{\textheight}`, `\hrulefill`, `\faGraduationCap`; two variants chosen by `titlestyle`; komafont title sffamily bfseries Huge |
| title page fields | cookbook.tex:60-62; acp.cls:3506-3530 | `front.class-native` | zip-local `\documenttype`, `\idnumber` (string stores, see Bespoke code) |
| date format | acp.cls:1196; cookbook.tex:41 | `front.datetime` | `datetime2` `useregional`, `\DTMtoday`, `\DTMnow` |
| colophon page | chapters/frontmatter/colophon.tex:4-42 | `front.dedication` | empty page style, `\vspace*{\fill}`, grey `\footnotesize` two-column tabular of build facts |
| task page, declaration page | chapters/frontmatter/task.tex:1-23; chapters/frontmatter/authorship_declaration.tex:4-12 | `front.dedication` | `\chapter*`, tabular, `\subsection*`, signature line |
| abstract | chapters/frontmatter/abstract.tex:2 | `head.kernel` | `\chapter*{\abstractname}` (no abstract environment) |
| preface | chapters/frontmatter/preface.tex:1 | `head.kernel` | `\addchap{Preface}` (KOMA vocabulary) |
| contents and lists | chapters/frontmatter.tex:22, 100-108 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables` |
| extra lists of examples, reactions | acp.cls:823-832 | `toc.tocbasic` | `\DeclareTOCStyleEntry[dynnumwidth=true]{tocline}{figure}` and `{table}`; `\DeclareNewTOC[type=example,listname=..]{loe}` |
| chapter heading | acp.cls:676-689 | `head.koma-fonts` | `\addtokomafont{chapterprefix}{\raggedleft}`; `\chapterformat` redone with `\scalebox{4.5}` and colour g3 (via `head.kernel` renewcommand) |
| sectioning in body | chapters/mainmatter/base-features.tex:784-852; chapters/mainmatter.tex:1 | `head.kernel` | chapter, section, subsection, subsubsection, paragraph |
| appendix | chapters/backmatter.tex:5-7 | `num.appendix` | `\appendix`, then `\chapter`, `\section` |
| counters | acp.cls:989-997, 2578, 1075 | `num.counters` | `\renewcommand*{\thereaction}{\thechapter.\arabic{reaction}}`, `\theContinuedFloat` as `\alph`, `\newcounter{descriptcount}` |
| lists | acp.cls:952-997 | `list.enumitem` | `inline`; `\setlist{noitemsep}`, labelindent=\parindent, label=\smblksquare, enumerate font sffamily bfseries; `\newlist{tabitemize}{itemize}{1}`, `{tabenum}`, `{enumdescript}{description}{2}` |
| plain lists in body | chapters/mainmatter/base-features.tex:946-993; chapters/frontmatter/task.tex:15 | `list.kernel` | itemize, enumerate, description |
| ordinals | acp.cls:80; cookbook.tex:54 | `mark.nth` | `[super]`, `\nth{1}` |
| inline marks | chapters/mainmatter/base-features.tex:117-125 | `mark.kernel` | `\textbf`, `\textit`, `\textsc`, `\emph` |
| units and numbers | acp.cls:2582-2637 | `mark.siunitx` | `mode=match`, propagate-math-font, text-font-command=\unitnumberfont, range-units=single, per-mode=symbol, locale DE/US via `\blockextras@german`; `\DeclareSIUnit` x6, `\DeclareSIQualifier` x3 |
| outline text | acp.cls:1233-1244 | `mark.contour` | `[outline]`, `\contourlength{0.12em}`, `\contour{white}{...}` |
| keyboard keys | acp.cls:663-665 | `mark.menukeys` | `os=win` |
| censoring | acp.cls:1206-1214; chapters/mainmatter/base-features.tex:1003, 1011 | `mark.censor` | package `censor`; `\StopCensoring` when `censoring` is false; `\censor{}`, `\censorbox{}` |
| footnotes | chapters/frontmatter/preface.tex:14; acp.cls:1007 | `fn.kernel` | `\footnote`; floatrow `footposition=bottom` |
| TODO notes | acp.cls:466-467; chapters/mainmatter/base-features.tex:1001 | `note.todonotes` | `\setuptodonotes{fancyline}` |
| filler text | acp.cls:914; chapters/frontmatter/abstract.tex:4 | `draft.todo` | `blindtext` (`\blindtext`, `\Blindtext`; the package is the parameter) |
| math packages | acp.cls:283-301, 305, 1216 | `math.mathtools` | `\newtagform{brackets}{[}{]}`, `\usetagform`, `\allowdisplaybreaks[2]`, `\DeclarePairedDelimiter` x4 |
| math extras | acp.cls:305, 1216 | `math.physics` | `empheq`, `cancel` |
| equations | chapters/mainmatter/base-features.tex (8 `equation`, 1 `gather`) | `math.amsmath` | `equation`, `gather`, `pmatrix` |
| graphics | acp.cls:1252-1255 | `fig.graphicx` | `\graphicspath{{images/bitmaps/}}`, `\scalebox`, `\includegraphics` |
| rotation | acp.cls:1170-1176 | `fig.rotating` | `\rotatebox[origin=c]{90}` in `\multirotatecell` |
| vector images | acp.cls:1257-1278 | `fig.svg` | `\svgpath{images/vectors/}`, inkscapepath=svgsubdir, inkscapelatex=false (EXTERNAL) |
| scaled icon | acp.cls:1314-1323; chapters/mainmatter/code-listings.tex:335 | `fig.adjustbox` | `\scalerel*{<object>}{X}` |
| float layout | acp.cls:1005-1022 | `fig.floatrow` | `footposition=bottom`; table `style=plaintop`, `footnoterule=none`, `footskip=.35\skip\footins`; figure `capbesideposition=right`, `capbesidesep=quad`; subfigure `style=plain`; body `\ffigbox`, `\ttabbox`, `\fcapside`, `subfloatrow`, `\floatfoot` (chapters/mainmatter/floats.tex:109, 132, 151, 2077) |
| subfloats | acp.cls:1084 | `fig.subcaption` | default; captions of subfigure/subtable set at 1060-1072 |
| captions | acp.cls:1028-1082 | `cap.caption` | format=plain, textformat=period, font=small, labelfont={sf,bf}, labelsep=slash (own `\DeclareCaptionLabelSeparator`), labelformat=simple, indention=1em; float-foot font ftfont; subfigure/subtable `list=off` |
| listing float | acp.cls:423-428 | `cap.caption` | `\SetupFloatingEnvironment{listing}{name,listname}` (newfloat route), `longlisting` as `\captionsetup{type=listing}` |
| tables | acp.cls:1166-1187; chapters/mainmatter/base-features.tex:105-127 | `tbl.tabular` | `array`; `\newcolumntype{M}`; `\arraystretch` 1.3; `@{}` column edges |
| table rules | acp.cls:1184; chapters/frontmatter/colophon.tex:32 | `tbl.booktabs` | `\toprule`, `\midrule`, `\addlinespace`, `\cmidrule` |
| multi-row cells | acp.cls:1182 | `tbl.multirow` | `\multirow{#1}{*}` in `\multirotatecell` |
| key-value tables | acp.cls:1164, 1178-1180; chapters/backmatter.tex:26-54 | `tbl.nicematrix` | `tabularray` with `booktabs` and `siunitx` libraries; `longtblr` with colspec S c X c, rowhead=1, `row{odd}`, `preto`/`appto`; `tabu` (glossaries only) |
| number columns | chapters/backmatter.tex:38 | `tbl.siunitx` | `S` column from the `siunitx` library of tabularray |
| code listings | acp.cls:372-428; chapters/mainmatter/code-listings.tex:52 | `code.minted` | `newfloat=true`; `\setminted`: autogobble, fontsize=\footnotesize, breaklines, breakbytokenanywhere, escapeinside=¬¬, frame=leftline, framerule=1pt, numbers=left, stepnumber=5, style=manni (EXTERNAL) |
| copy-safe line numbers | acp.cls:435-443 | `meta.accsupp` | `\BeginAccSupp{ActualText={}}` around `\theFancyVerbLine` |
| verbatim in body | chapters/mainmatter/floats.tex:57; chapters/mainmatter/base-features.tex (3 `verbatim`) | `code.verbatim` | `\verb`, `verbatim` |
| example boxes | acp.cls:3200-3240 | `box.tcolorbox` | `\tcbuselibrary{many}`; `\newtcolorbox[auto counter, number within=chapter, list inside=loe, crefname]{example}[2][]`; leftrule=1mm, arc is angular, breakable, enhanced, colback=g6, colframe=g1; `highlight math style` for `\tcbhighmath` |
| title page columns | acp.cls:724, 729 | `box.minipage` | `minipage[b][1\textheight]` of width 0.05 and 0.75 `\textwidth` |
| bibliography | acp.cls:1094-1154; chapters/backmatter.tex:298-310 | `bib.biblatex-biber` | `style=authoryear`, `autocite=footnote`, `sortcites`, `backref`, `url=false`, `doi=false`, `isbn=false`; `\defbibheading{notcited}`, `\defbibnote{further}`, `\defbibenvironment{bibnonum}`, `\DeclareBibliographyCategory{cited}`; body `\nocite{*}`, `\printbibliography[category=cited]`, `[notcategory=cited, heading, env, prenote]`; `\addbibresource` at cookbook.tex:33 |
| glossaries and index | acp.cls:2731-3161; chapters/frontmatter.tex:40-97; chapters/backmatter.tex:315-318 | `idx.glossaries` | `glossaries-extra` with nomain, record, abbreviations, symbols, index, numbers, toc=true; `\newglossary*`, `\glsaddkey` x6, `\GlsXtrLoadResources` x8, `\printunsrtglossary`, `\printunsrtindex[style=bookindex]` (EXTERNAL via bib2gls; styles bespoke) |
| cross-references | acp.cls:3173-3192 | `xref.cleveref` | `capitalise`, `nameinlink`, `noabbrev`; `\creflabelformat{equation}{#2#1#3}`; `\crefname{code}`, `\crefalias{listing}{code}` |
| labels | chapters/frontmatter.tex:31 | `xref.kernel` | `\label` |
| hyperlinks and PDF info | acp.cls:2646-2707 | `meta.hyperref` | `pdfusetitle`, colorlinks, allcolors=darklink, plainpages=false, pdfsubject, pdfkeywords, pdfcreator (embeds `\GitRefName`), bookmarksnumbered, pdfpagelayout=TwoPageRight, pdfdisplaydoctitle; `\pdfstringdefDisableCommands` hook |
| bookmarks | acp.cls:2712-2721 | `meta.bookmark` | open, openlevel=1, bold at level 0 through `addtohook` |
| URLs | acp.cls:918 | `meta.url` | default |
| file inclusion | cookbook.tex:72-74; chapters/frontmatter.tex:9, 14-16 | `struct.input` | `\import{chapters/}{...}`, `\subimport{frontmatter/}{...}` |
| chemistry | acp.cls:2565-2578; chapters/mainmatter/base-features.tex:524-540 | `art.content-package` | `chemmacros` with `chemformula`, `\NewChemReaction`, `reaction`, `reactions` environments (content) |
| plots, trees, 3D, pictures | acp.cls:1331-1363, 1392-1508; chapters/mainmatter/floats.tex | `art.tikz` | `pgfplots` (compat=1.16), `pgfplotstable`, `forest[edges]`, `tikz-3dplot`, tikz and pgfplots libraries (content inside figures) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| Lua git/CI metadata and engine banner | acp.cls:577-582, 591-657 | no | `\directlua` with `io.popen`, `os.getenv`, `token.set_macro`; computes text at compile time; blocker `BESPOKE/class` and needs a shell |
| PGF node shapes | acp.cls:1977-2556 | no | `\pgfdeclareshape` with `\anchor`, `\backgroundpath`, saved anchors; no lib way |
| TikZ style/pic library and `\parsenode` | acp.cls:1513-1516, 1521-1975 | no | style sets (`valve`, `pipe`, `flowarrow`, `add node at x`) over the PGF shapes; `\def\parsenode[#1]#2\pgf@nil` parses an optional argument; no lib way (`art.tikz` is restricted) |
| pgfplots styles and cycle lists | acp.cls:1369-1385, 1392-1508 | partly | key-value styles are `art.tikz` parameters; `unit code/.code 2 args` and tick-label code are programs |
| Glossary table styles and hooks | acp.cls:2949-2968, 3000-3161 | no | `\renewenvironment{theglossary}`, `\glossentry` redefinition under `\ifglsnonumberlist` |
| Glossary key aliases | acp.cls:2765-2816, 2920-2935 | partly | `\glsaddkey` and `\glsxtrnewgls` are `idx.glossaries` declarations; only usable with bib2gls (EXTERNAL) |
| Title page `\renewcommand{\maketitle}` x2 under `\ifdefstring` | acp.cls:707-814 | yes | for a given `titlestyle` the emitter writes one `titlepage` with `box.minipage`, `sp.rule`, `sp.manual-space`, KOMA fonts: `front.titlepage-env` |
| `titlestyle`, `language`, `censoring` options | acp.cls:31-36, 1207 | yes | option values resolved before emitting; `language` feeds `lang.polyglossia` and `mark.siunitx` locale |
| `\documenttype`, `\idnumber` stores | acp.cls:3506-3530 | yes | `\renewcommand` of a string macro plus `\ClassWarning`; inline the strings (cookbook.tex:60, 62) |
| `\providecaptionname` table | acp.cls:95-278 | yes | strings per language |
| `\signaturefield`, `\blankpage`, `\headerrule`, `\iecfeg`, `\sampletext`, `\adaptedfrom` | acp.cls:3536-3556, 882-889, 850-852, 557, 3581, 3500 | yes | `\newcommand` aliases of tabular/booktabs, `\rule`, `\textit`, text; expand inline |
| `\ctanpackage` | acp.cls:3565-3578 | yes | `\ifstrequal` and `\def` pick a URL; inline `\href{https://ctan.org/pkg/X}{\textcolor{DarkLinkGreen}{\texttt{\textbf{X}}}}` (`meta.hyperref`, `color.xcolor`, `mark.kernel`) |
| Maths macros (`\mean`, `\abs`, `\flow`, `\deriv`, `\fracderiv`, `\timederiv`, `\temperaturepair`, `\chemamount`...) | acp.cls:3261-3492 | yes, but tied to bib2gls | `\newcommand` / `\WithSuffix\newcommand` (package `suffix`) aliases that expand to `\glsdisp{sym.x}{math}`, `\qtyrange`, `\ensuremath`; star variants chosen statically; they need the glossary entries, so they inherit the EXTERNAL blocker |
| `longlisting`, `tabitemize`, `tabenum`, `enumdescript` | acp.cls:428, 961-997 | yes | `\captionsetup{type=listing}`; `enumitem` `\newlist`/`\setlist` keys; counter via `\newcounter`/`\stepcounter` (`list.enumitem`, `num.counters`) |
| `\floatfootskip` redefinition | acp.cls:1078-1082 | yes | `\hrulefill` with a length in a floatrow hook (`sp.rule`, `fig.floatrow`) |
| `\pdfstringdefDisableCommands` with `\expandafter\let\csname text\acp@language\endcsname\relax` | acp.cls:2705-2707 | yes | a hyperref hook that only affects PDF bookmark strings; no page effect (`meta.hyperref`) |
| `\debugtikzsvg`, `\circlednum`, `\mtlbsmlkicon` | acp.cls:1282-1308, 3290-3294, 1317-1323 | yes (content helpers) | TikZ debug grid, circled number node, scaled SVG icon; figure content |
| `scrhack`, `tracklang`, `etoolbox`, `iftex`, `kvoptions` | acp.cls:19, 31, 66, 76, 82 | yes | load-only or programming support with no printed effect (as `fixltx2e` in lib v4 change log); no way needed |

## Content-opaque
- TikZ and pgfplots pictures in figures: chapters/mainmatter/floats.tex (16 `tikzpicture`, 9 `axis`, 1 `forest`, one `pgfonlayer`), including the thermodynamic scheme at floats.tex:1919-2022; uses the class-defined shapes
- chemical reactions: chapters/mainmatter/base-features.tex:524-540, 569
- `contour gnuplot` plot data computed by gnuplot: chapters/mainmatter/floats.tex:1135, 1148
- included bitmap and SVG artwork: chapters/mainmatter/floats.tex:96, 117, 134, 140, 269; chapters/mainmatter/base-features.tex:1014; code text in the `minted` blocks
- generated glossary and bibliography data: bib/glossaries/*.bib, bib/bibliography.bib

## Lib changes
- New ways proposed:
  - `mark.censor`: `censor` (CTAN, LPPL 1.3, Steven B. Segletes; "simple tools for creating redacted documents with blacked-out text", ctan.org/pkg/censor), pdf. W1 published on CTAN; W2 a global on/off switch (`\StopCensoring`, acp.cls:1213) and wrapper commands, no code edited; W3 serves any document that needs redaction; W4 preamble load line and inline wrappers `\censor{text}` and `\censorbox{...}` around node content (chapters/mainmatter/base-features.tex:1003, 1011). Commands named from the sample; the CTAN page names none.
  - `fig.adjustbox`: `scalerel` (CTAN, LPPL 1.3, Steven B. Segletes; "scaling or stretching one object to match the size of a second object", ctan.org/pkg/scalerel), pdf. W1 on CTAN; W2 behaviour set by its arguments, no code edited; W3 serves any icon or glyph scaling; W4 body wrapper `\scalerel*{<object>}{<reference>}` around an image or symbol (acp.cls:1318-1322). Considered `fig.adjustbox`: it scales to a given length, not to a reference object's height. Weak case: used once, inside a class macro.
- Considered, not proposed: `extdash` (written as `sp.hyphenat` with the package as parameter), `blindtext` (written as `draft.todo`, as `lipsum`), `empheq` and `cancel` (in `math.physics`), `tabu` (in `tbl.nicematrix`), `scrhack`, `tracklang`, `etoolbox` (load-only or programming support).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
