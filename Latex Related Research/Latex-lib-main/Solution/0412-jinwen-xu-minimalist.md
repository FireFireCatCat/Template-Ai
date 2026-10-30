yes

# 0412-jinwen-xu-minimalist: the `minimalist` class bundle (minimart, minimbook, einfart, simplivre)

- Unverified: read from the source, not compiled.
- Source: Source/0412-jinwen-xu-minimalist/ (origin: https://codeload.github.com/Jinwen-XU/minimalist/zip/refs/heads/main; licence: LPPL-1.3c)
- Kind: misc
- Lib: v5
- Engine: needs XeLaTeX or LuaLaTeX (main sample uses `einfart`, which loads fontspec, unicode-math and ctex: M:374, M:764, M:460; `minimart`/`minimbook` are pdfLaTeX-compatible: README.md:33)
- Look carried by: class (the published classes `einfart`, `simplivre`, `minimart`, `minimbook` with their style packages; the samples only pass class options and load ProjLib, doclicense, blindtext)
- Class origin: ctan
- Main file: einfart/demo/einfart-demo.dtx (DocStrip source: `latex einfart-demo.ins` writes six `.tex` variants; no plain `.tex` with `\documentclass` exists. Other samples: simplivre/demo/simplivre-demo.dtx, minimalist-doc.dtx)
- Read: main yes, zip-local classes and styles all
- Notes on reading: the class code is the DocStrip source minimalist.dtx, read in full; no `.cls`/`.sty` file is present because DocStrip generates them; S read in full; D partly (lines 1-460, 576-615, 1143-1190 and a grep outline). CTAN pages ctan.org/pkg/minimalist, /einfart and /simplivre were read: each is by Jinwen XU, LPPL 1.3c, in TeX Live; the zip is the author's own repository, and D:427 says the same.
- Citations: E = einfart/demo/einfart-demo.dtx, S = simplivre/demo/simplivre-demo.dtx, D = minimalist-doc.dtx, M = minimalist.dtx, all under Source/0412-jinwen-xu-minimalist/. ProjLib (`projlib-*` packages, DEPENDS.txt:1 `hard projlib`) is not in the zip and was not read.

## Verdict
`yes`, resting on class origin. The zip is the author's repository of the `minimalist` bundle: DocStrip sources of the classes `minimart`, `minimbook`, `einfart`, `simplivre` and the style packages `minimalist-{plain,default,flow,stream,classical,classicthesis}` (minimalist.ins:43-53). All of them are published on CTAN and in TeX Live, so W1 holds and each class is one `class.<name>` way. The demos define no macro, environment or counter of their own; they pass class options, load ProjLib/doclicense/blindtext and call ProjLib key-value theorem settings. The doc driver's helper macros reduce to aliases over lib ways. The TikZ and kernel patches inside the classes are class-internal (see Bespoke code) and are carried by the class way; a reviewer who counted class-internal artwork or code as the template's own would have to turn this into `no`. DocStrip and `latexmk` in MakeFile.sh (MakeFile.sh:4-18) are TeX-only build steps, not an outside tool.

## Blockers
none

## Class setting
- Class: `class.einfart` (main sample) options: `a4paper`, `11pt`, `use osf`, `use style = classical/classicthesis/flow/plain/stream` (one per generated variant), `title in boldface`, `theorem in new line`, `emphasize theorems`, `theorem numbering = section`, `simple name`, `name in link` (E:27-74); commented alternatives `use font = times`, `use indent = false`, `title in scshape`, `title in sffamily`, `number theorems separately` (E:29, E:53, E:60-61, E:71). Base class under it is `article` (M:43, M:207). Other classes in the source: `class.simplivre` (book base, S:29-76, M:52), `class.minimart` (article base, D:18, M:25), `class.minimbook` (book base, M:34).
- Style packages: the `use style` value loads `minimalist-<style>` (M:1160); `classicthesis` loads the CTAN package `classicthesis` after `\PassOptionsToPackage{tocaligned=false, dottedtoc=false, style=arsclassica}` (E:20-25, S:20-27, M:3349-3352). A thesis-style package is class-like, so it is recorded here and not as a way of its own.
- Class-native vocabulary used (E): `\address`, `\email`, `\subjclass`, `keyword` environment, `emphasis` environment, `definition` `theorem` `corollary` `examples` `example*` `proof` `proof*`, `\SwitchTheoremNumbering`, `\SetTheorem{..}{shared counter = ..}`, `\cref` `\namecref` `\labelcref`, `\today[only-year-month]`, `\index` `\printindex`, classicthesis `\spacedallcaps` (E:92). Book classes (S): `\TitlePage[style=.., color={main=.., back=..}, author info on the right]{title, author, date, info, license, license page name}` (S:98-146), `\frontmatter` `\mainmatter` `\backmatter`, `\part` `\parttext` (M:1714), classicthesis `\ctparttext` (S:157).

## Component map
Rows marked "(inside class)" are what the published class does internally; the emitter does not write them, the class way carries them. Names that need a package the zip does not ship say so.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | E:27-74 | `class.einfart` | options as in Class setting |
| document class (book) | S:29-76 | `class.simplivre` | same option set; classicthesis extras `eulerchapternumbers=true`, `floatperchapter=true` (S:24-25) |
| document class (docs) | D:18-20 | `class.minimart`, `class.minimbook` | minimart: `classical, simple name` (D:18); minimbook is defined at M:28-35 and shown only in listings (D:1151) |
| paper and size | E:27 | `page.class-options` | a4paper, 11pt (class turns `a4paper` into a geometry call, M:190, M:254-264) |
| page geometry (inside class) | M:230-264 | `page.geometry` | papersize 7in x 10in, total 5.535in x 8.300in, centering, footnotesep=2em plus 2pt minus 2pt, footskip=.5in, heightrounded; a4: total 6.5in x 9.685in; b5: total 5.535in x 8.160in |
| text and mono fonts (inside class) | M:373-446; E:34 | `font.fontspec` | `\setmainfont{TeXGyrePagellaX}` (Extension=.otf, Regular/Bold/Italic/BoldItalic, Numbers=OldStyle under `use osf`), `\setsansfont{texgyreheros}` (Scale=MatchUppercase), `\setmonofont{NewCMMono10}` (Scale=1.05); fonts not in the zip |
| fonts for minimart/minimbook (inside class) | M:337-355 | `font.palatino` | `mathpazo` + `newpxtext`, `\useosf` under `use osf`; sans via `font.fontspec` off pdfTeX (M:346) |
| math fonts (inside class) | M:760-794 | `font.unicode-math`, `math.amssymb` | `\unimathsetup{math-style=TeX, partial=upright, nabla=upright}`, `\setmathfont{KpMath-Regular.otf}` plus ranges from KpMath-Sans, latinmodern-math, texgyrepagella-math |
| CJK fonts (inside class) | M:459-485 | `lang.cjk` | `ctex` with `fontset=none, scheme=plain`; `\setCJKmainfont{SourceHanSerifSC}` with `FandolSong` fallback |
| inline font switches in a title | S:117-118, S:144 | `font.fontspec` | `\fontspec{SourceSansPro}[WordSpace={1.25,1,1}]`, `\addfontfeature{LetterSpace=2.0}`, `\addfontfeature{Numbers=Lining}` |
| NFSS digit face (inside class) | M:1587 | `font.nfss` | `\usefont{U}{zeur}{b}{n}` (Euler digits for default/flow/stream numbers) |
| language / toolkit | E:75, E:78, D:27, D:33 | `lang.projlib` | `\usepackage{ProjLib}`; `\UseLanguage{English}` (D:33, commented French E:78); class loads `projlib-paper`, `-language`, `-author`, `-theorem`, `-draft`, `-titlepage` (M:1150, M:1155, M:2420, M:2850, M:3131, M:3323) |
| quotation marks | E:89 | `lang.csquotes` | `\textquote{..}` (csquotes is loaded inside ProjLib, not in the zip, not read) |
| title block | E:85-116 | `front.maketitle` | `\title` `\author` `\date` `\maketitle`; class `\@maketitle`: centred, title `\sffamily\Large`, author `\small` in `main-text!80!paper` (M:3146-3180); classical: rules above and below, flush right (M:3183-3209) |
| author block | E:103-112, M:3322-3323 | `front.class-native` | `\address`, `\email{\href{mailto:..}{..}}`, `\thanks` and `\keywords` (commented E:106, E:110, E:112); ProjLib `amsfashion` |
| title page (book) | S:95-146, M:3131-3142 | `front.class-native` | `\TitlePage[style=academic/simple/fancy, color={main=Maroon, back=Goldenrod}, author info on the right]`, fields title, author, date, info, license, license page name (ProjLib `\ProjLibTitlePage`, not in zip) |
| date | E:113 | `front.datetime` | `\today[only-year-month]` (ProjLib datetime; `\TheDate` commented, E:114) |
| subject classification | E:111 | `abs.classification` | `\subjclass{XXXXX}` |
| abstract | E:118-120, M:3220-3243 | `abs.class-native` | class redefines `abstract`: minipage .833\textwidth, `\footnotesize`, `\parindent=2em`, colour `main-text!80!paper`, small-caps heading |
| keywords | E:122-124, M:3271-3294 | `abs.keywords` | class `keyword` environment (article classes only) |
| licence page | S:78-84, S:144 | `front.doclicense` | `type=CC, modifier=by, version=4.0, hyperxmp=false`; `\doclicenseThis` |
| contents | E:127, D:347-349 | `toc.kernel` | `\tableofcontents`, `\setcounter{tocdepth}{2}` (D:347) |
| contents entries (inside class) | M:2122-2223 | `toc.titletoc` | `\titlecontents` per level with dotted leader `\titlerule*[1em]{..}`; indents 1.5em/4.5em/9em (article), 2em/5.75em/10.5em/15.75em (book) |
| headings | E:130-132, S:159-164 | `head.class-native` | `\part` `\chapter` `\section` `\subsection`; look chosen by `use style` |
| headings (inside class) | M:1581, M:1694-2117 | `head.titlesec` | `\titleformat`, `\titlespacing`, `\titleclass` (`explicit, newparttoc`); part title `\fontsize{20}{24}` in books (M:1701) and 16pt in articles (M:1817), chapter 16pt (M:1732), `\sectionsub` level in stream (M:2081) |
| numbering depth | M:1685-1688, M:3329 | `num.secnumdepth` | secnumdepth 3 (stream 4); tocdepth 1 (flow, stream) |
| header and footer (inside class) | M:1322-1422 | `hf.fancyhdr`, `hf.extramarks`, `hf.pagestyle-kernel` | foot-only styles `fancy`, `plain`; `\fancyhfoffset{0pt}`, page number in the outer margin, `\lastleftmark`/`\lastrightmark` boxes .833\textwidth, `\headrulewidth` 0pt, `\pagestyle{fancy}` (M:1385) |
| indentation and spacing (inside class) | M:275-289, M:448 | `sp.indentfirst`, `sp.parskip-pkg`, `sp.setspace` | `indentfirst` by default; `parskip` under `use indent=false`; classical forces no indent; `\setstretch{1.07}` (einfart/simplivre) |
| widow control (inside class) | M:992-1013 | `sp.penalties`, `sp.lengths` | `lua-widow-control` with `\lwcsetup{balanced}` under LuaTeX, else `nowidow[all]`; XeTeX `\parfillskip` assignment |
| colour | M:1117, M:1134 | `color.xcolor` | `dvipsnames`; text tints `main-text!N!paper` (colours come from ProjLib `projlib-paper`, not read) |
| classical rules (inside class) | M:1583-1584, M:1856-1857 | `mark.ulem` | `\markoverwith{..}\ULon` underline-rule decoration of section headings (`normalem`) |
| lists | E:166-172 | `list.kernel` | `enumerate` inside `examples` |
| lists (inside class) | M:2228-2276 | `list.enumitem` | `inline`, `\setlistdepth{10}`, `noitemsep`, labels `1)` `i)` `a)`, bullets `$\cdot$` / French dash |
| theorem-like environments | E:136-176, E:178-187, E:81, E:157-161 | `thm.class-native` | `definition`, `theorem`, `corollary`, `examples`, `example*`, `proof`, `proof*` (stream); `\SwitchTheoremNumbering{example,examples,claim}`; `\SetTheorem{corollary}{shared counter = subsubsection / subsection}`; option `theorem numbering = section` |
| theorem styles (inside class) | M:2426, M:2460-2576, M:2850-3045 | `thm.amsthm` | `\newtheoremstyle{simple}`, `{simple-var}` (and stream `simple-newline`, `simple-inline`, `proof`), `\theoremstyle{simple}`, `\pushQED{\simpleqed}`, `qed-symbol=\customqedsymbol` |
| equations | E:80, E:148-155 | `math.amsmath`, `num.counters` | `\numberwithin{equation}{section}`, `equation`, `\eqref`; equation tag grey via `\tagform@` (M:2442); `mathtools` loaded (M:2425) |
| cross-references | E:145, E:154, E:158, E:140, E:149 | `xref.cleveref`, `xref.kernel` | `\cref` `\namecref` `\labelcref`, `\label`; options `simple name`, `name in link`; `\crefformat` per level (M:3333-3342); cleveref is loaded inside ProjLib, not read |
| emphasis box | E:144-146, E:153-155, M:3088-3111 | `box.tcolorbox` | `enhanced jigsaw, breakable, oversize, left=.5em, right=0mm, top=0.5mm, bottom=0mm, boxrule=0pt, colback=main-text!2!paper, frame hidden, borderline west={.3em}{0mm}{main-text!25!paper}, arc=0.2mm`; classical: `colback=paper`, double border (M:3101-3105); `tcolorbox[many]` M:3048 |
| quotation (inside class) | M:3114 | `quote.kernel` | `\small` at `env/quote/begin` |
| verbatim | E:175 | `code.verbatim` | `\verb\|example*\|` |
| index | E:140, E:148, E:193; M:2312-2325 | `idx.makeidx` | `imakeidx` `\makeindex[intoc]`, a `\jobname.mst` written by `filecontents*`, `\IndexDotfill`, `\IndexHeading` (M:2342-2380); makeindex is run by the user or imakeidx |
| hyperlinks (inside class) | M:2783-2791 | `meta.hyperref`, `meta.bookmark` | `hidelinks, linktoc=all`, `\bookmarksetup{numbered}`; `draft` under `fast`; `\href` at E:105 |
| draft and fast mode (inside class) | M:266-271 | `bg.watermark` | `draftwatermark`: `\DraftwatermarkOptions{text={\normalfont DRAFT}, color=paper!97!-paper}` |
| line numbers | D:22; M:1131-1145 | `sp.draft-lineno` | `\linenumbers`; `lineno` `pagewise,mathlines`, `\linenumbersep` 1em; `\LocallyStopLineNumbers` hooks on toc, bibliography, index |
| graphics, floats, captions (inside class) | M:980-985 | `fig.graphicx`, `fig.wrapfig`, `fig.float`, `cap.caption` | `\graphicspath{{images/}}`, `wrapfig2`, `float`, `\captionsetup{font=small}`; the samples use no float |
| filler text | E:76, E:119, E:190; S:86, S:142, S:228 | `draft.todo` | `blindtext` `\blindtext`, `\blinddocument` (filler content, same type as `lipsum`) |
| doc driver code listings | D:40-66, D:95-96 | `code.listings` | `\lstset{language=[LaTeX]TeX, basicstyle=\ttfamily, frame=lines, breaklines, escapeinside={(*}{*)}, ..}`, `\lstnewenvironment{code}`, `{code*}` (numbers=left) |
| doc driver box and misc | D:105-129, D:28-29, D:42-47 | `box.tcolorbox`, `tbl.longtable`, `font.icons`, `sp.setspace`, `color.xcolor` | `tip` environment (boxed title, `colframe=gray!50`, `boxrule=0.2mm`); `longtable` loaded and unused; `\hologo`; `\setstretch{1.05}`; `\definecolor{code-main}{RGB}{70,130,180}` etc. |
| doc driver title and abstract | D:158-169, D:260-264 | `front.maketitle`, `abs.kernel` | `\title` `\author` `\thanks` `\email` `\date{\TheDate{..}[only-year-month]}` `\maketitle`; `abstract` |
| math arrows (inside class) | M:855-964 | `art.tikz` | `tikz-cd` and TikZ-drawn `\xrightarrow` family under einfart/simplivre (math content) |
| part-page strip (inside class) | M:1296-1300, M:1522-1544 | `bg.tikzpagenodes` | `tikzpagenodes` shaded strip on book part pages (`current page text area`), page style `part` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| macros, environments, counters of the demos | E, S | none defined | the demos define nothing zip-local; every call is class or ProjLib vocabulary |
| `\meta`, `\classoption`, `\packageoption`, `\commandoption` | D:67, D:98-100 | yes | `\newcommand` aliases over `\textcolor`, `\texttt` (`mark.kernel`, `color.xcolor`) |
| `\minimalist`, `\minimart`, `\minimbook`, `\einfart`, `\simplivre` | D:134-138 | yes | `\providecommand` aliases of `\textsf{..}` (`mark.kernel`) |
| `code`, `code*` | D:95-96 | yes | `\lstnewenvironment` over `code.listings`; `\setstretch{1.05}` (`sp.setspace`); the two line-number wrappers are class commands (M:1138-1140) |
| `tip` environment | D:105-129 | yes | `\newenvironment` wrapping one `box.tcolorbox` call with the keys in the table |
| `\LevelOneTitle` `\LevelTwoTitle` `\LevelThreeTitle`, `\PackageVersion` | D:144-153, D:160 | yes | `\let` aliases of sectioning commands, a `\def` string |
| class internals, would be `BESPOKE/class` if the class were zip-local: `\bfseries` tinting (M:1198-1210), regex restyling of numbers (M:1593-1650), `\@maketitle` (M:3146), `\@idxitem`/`\subitem` (M:2391-2405), `\@endtheorem` patch (M:2757), XeTeX `\xpatchcmd{\@trivlist}` (M:1005-1013), `\cleardoublepage` with a shipout background text (M:2296-2307), TikZ arrows and page strip (M:855-964, M:1522-1544, M:1312, M:1865) | M | published, not counted | the code is in the CTAN/TeX Live classes `einfart`, `simplivre`, `minimart`, `minimbook`, so by W1 it is the class way (`class.einfart` and the others) and is never emitted; this is the "carried by the class" ruling, and these items are named so the result can be re-read under a stricter rule |

## Content-opaque
none that no lib way can hold. `\blinddocument` and `\blindtext` (E:119, E:190) are filler held by `draft.todo`; the equation in E:150 is content; the TikZ arrows (M:861-964) are math symbols inside the class.

## Lib changes
- New ways proposed: none. Considered and not proposed: `blindtext` (same type as `lipsum`, filed under `draft.todo`), `classicthesis` (a thesis style loaded by a class option, recorded under the class way), `embrac`, `relsize`, `anyfontsize`, `silence`, `regexpatch` (helper packages loaded only inside the class at M:308, M:1194-1195, M:227, M:1005; the sample never calls them, so the class way carries them).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
