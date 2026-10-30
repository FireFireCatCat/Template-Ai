yes

# 0422-exercisesheets: exercisesheets (exercise sheets with solutions, points and a beamer variant)

- Unverified: read from the source, not compiled.
- Source: Source/0422-exercisesheets/ (origin: https://mirrors.ctan.org/macros/latex/contrib/exercisesheets.zip; licence: lppl1.3c)
- Kind: assignment (hint `presentation` in the manifest is wrong: the main file is the package manual, the examples are exercise sheets, one of them a beamer deck)
- Lib: v4
- Engine: needs LuaLaTeX (the `Lexercise` environment and `\includeLexercise` used by both examples, and the `fragile` option; the manual and the plain LaTeX interface of the package are pdfLaTeX-compatible)
- Look carried by: mixed (the sheet and exercise look is set by `exercisesheets.sty`, the published CTAN package that this zip is, plus the `\exshset`/geometry lines of each example's preamble; the manual's look is its own preamble over scrartcl)
- Class origin: tex-distribution-unbundled
- Main file: exercisesheets-doc.tex (other samples: examples/exshexample.tex, examples/exshexample-embedded.tex, examples/exercises/exshexample-ex1.tex, examples/exercises/exshexample-ex2.lua)
- Read: main yes, zip-local classes and styles all present (exercisesheets.sty read in full; `exsh_lexercise.lua` is named in README:14 and loaded at exercisesheets.sty:1961 but is NOT in the zip, so the Lua side of `Lexercise` is unread)

## Verdict
yes. The zip is the package `exercisesheets` itself (CTAN, LPPL 1.3c, ctan.org/pkg/exercisesheets), so W1 holds for its style file, and the package is driven by pgfkeys options (fonts, skips, strings, booleans, ranges) that an emitter prints as `\usepackage[...]`, `\exshset{...}` and `sheet`/`exercise`/`solution` wrappers; it is filed under `exam.questions` ("other question-bank packages, the package is the parameter"). Every zip-local macro in the manual and the two examples is an alias or a branch selector that reduces by inline expansion, there is no drawing, and nothing needs a tool outside TeX. Caveat, not a blocker: the Lua helper of the published package is missing from the zip, so `Lexercise` (LuaLaTeX only) rests on the package being published and on the documented table keys, not on code I read.

## Blockers
none

## Class setting
- Class: `class.scrartcl` options: DIV12, BCOR0mm (exercisesheets-doc.tex:17); `class.article` option a5paper (examples/exshexample.tex:2, second branch of `\ifbeamer`); `class.beamer` option aspectratio=169 (examples/exshexample-embedded.tex:1; first branch of examples/exshexample.tex:2).
- Class-native vocabulary used: scrartcl `\KOMAScript` logo (exercisesheets-doc.tex:173), `\maketitle` with `\and` (exercisesheets-doc.tex:105); beamer `frame`, `block`, `\pause`, `\subtitle`, `\AtBeginSection[]`, `\usetheme` family (examples/exshexample-embedded.tex:2-32,36,72-91); article: none beyond the kernel. The package itself supplies `\subject` when the class has none (exercisesheets.sty:268-271).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (manual) | exercisesheets-doc.tex:17 | `class.scrartcl` | DIV12, BCOR0mm |
| page typearea (manual) | exercisesheets-doc.tex:17 | `page.typearea` | DIV=12, BCOR=0mm, as class options |
| class (sheet example, default branch) | examples/exshexample.tex:2 | `class.article` | a5paper |
| class (beamer branch and embedded example) | examples/exshexample.tex:2, examples/exshexample-embedded.tex:1 | `class.beamer` | aspectratio=169 in the embedded example |
| paper size | examples/exshexample.tex:2,33 | `page.class-options` | a5paper (class), a4paper (geometry option, solutions branch) |
| page geometry | examples/exshexample.tex:33,35 | `page.geometry` | solutions: left=1cm,right=1cm,top=1cm,bottom=1.5cm,a4paper; exercises: left=0.7cm,right=0.7cm,top=1cm,bottom=1.5cm |
| main font | exercisesheets-doc.tex:19 | `font.helvet` | package arev (Arev Sans text and math; ctan.org/pkg/arev) |
| encodings | exercisesheets-doc.tex:20-21 | `font.fontenc-t1` | fontenc T1, inputenc utf8 |
| microtype | exercisesheets-doc.tex:22 | `sp.microtype` | activate |
| quotation marks | exercisesheets-doc.tex:23 (used 202,470,749) | `lang.csquotes` | `\enquote{}` |
| colours | exercisesheets-doc.tex:25,91-101; examples/exshexample.tex:23,26 | `color.xcolor` | blue!50!black, red!50!black, green!50!black, magenta!80!black, yellow!50!black, cyan!50!black, black!90, black!60 |
| code listings | exercisesheets-doc.tex:27-84 | `code.listings` | lstloadlanguages TeX, language=[LaTeX]TeX, basicstyle=\ttfamily\color{blue!50!black}, texcs list, texcsstyle, keywordstyle bold, keywords and keywords[2] (key lists), escapeinside={(*}{*)}, texcl, commentstyle=\itshape, breaklines, breakatwhitespace, columns=flexible, showstringspaces=false, mathescape=false |
| listing bodies | exercisesheets-doc.tex:188-190,304-326 | `code.listings` | `lstlisting` environment, `\lstinline\|..\|` |
| PDF links and metadata | exercisesheets-doc.tex:86; examples/exshexample.tex:22 | `meta.hyperref` | manual: pdfusetitle, colorlinks; example: no options |
| URLs, mail link | exercisesheets-doc.tex:120,983 | `meta.url` | `\url`, `\href{mailto:..}{..}` (hyperref) |
| date format | exercisesheets-doc.tex:103,106 | `front.datetime` | isodate options english,iso; `\printdateTeX{2024/04/23}` |
| title block (manual) | exercisesheets-doc.tex:104-109 | `front.maketitle` | `\title`, `\author{A\and B}`, `\date`, `\maketitle` |
| headings | exercisesheets-doc.tex:114,123,137,139 | `head.kernel` | `\section`, `\subsection`, `\subsection*` at the scrartcl default look |
| lists | exercisesheets-doc.tex:125-132,193-336,988-1076 | `list.kernel` | itemize, description, nested; `\optitem` and `\versitem` are `\item[..]` aliases |
| footnote | exercisesheets-doc.tex:120 | `fn.kernel` | one `\footnote` |
| cross-references | exercisesheets-doc.tex:341,370,381,422 | `xref.kernel` | `\label`, `\ref`, `Section~\ref` |
| text marks | exercisesheets-doc.tex:88-101 | `mark.kernel` | `\texttt`, `\itshape`, `\normalfont\ttfamily` |
| exercise-sheet package load | examples/exshexample.tex:11-20 | `exam.questions` | package exercisesheets; options patchenumerate=true, beamerwithheadline, patchpagenumbers=false, beamerwithfootline, beamercompatibility, exercisespath=exercises |
| package settings | examples/exshexample.tex:25-28,44,46 | `exam.questions` | `\exshset{solutions=true, task restate font={\color{black!60}}, only={1-3,5-}}`, `exauthor`, `beameruseblocks=false` |
| solution-dependent branch | examples/exshexample.tex:32-36 | `exam.questions` | package `\ifsolutions{A}{B}`; with `solutions=true` (line 25) the first geometry branch is the one in effect |
| sheet header data | examples/exshexample.tex:39-42 | `front.maketitle` | `\author`, `\date`, `\title` (the package sets its own title, exercisesheets.sty:645-677) |
| sheet header subject | examples/exshexample.tex:42; exercisesheets.sty:268-274 | `exam.questions` | `\subject{..}` stored into key subject |
| sheet environment | examples/exshexample.tex:55-81,93-114,117-127,132-166,169-283 | `exam.questions` | `sheet[note=,date=,title=,number within sheet]` |
| sheet start/end page actions | examples/exshexample.tex:85-90 | `exam.questions` | keys `sheet start page action={\pagebreak[3]\hrule}`, `sheet end page action={\vspace{4mm}\hrule\vspace{2cm}}` |
| page break, rule, vertical space inside those keys | examples/exshexample.tex:87-88 | `pg.break`, `sp.rule`, `sp.manual-space` | `\pagebreak[3]`, `\hrule`, `\vspace{4mm}`, `\vspace{2cm}` |
| exercise environment | examples/exshexample.tex:61,64,145,170,185,199,218 | `exam.questions` | `exercise[points={many, many}\|sum, firstline=, savetasks, main task font={\tiny}, subtask font={\itshape}, beamersolution]` |
| main task and subtasks | examples/exshexample.tex:148-157,221-230 | `exam.questions` | `maintask`, `subtasks`, `\subtask`, `\restatetask[1]` (lines 232-233) |
| points on items | examples/exshexample.tex:68-77 | `exam.questions` | `\points[pointsfloatright\|abbrev,bonus\|inplace]{n}` inside enumerate |
| solution environment | examples/exshexample.tex:97,121,172,188,201 | `exam.questions` | `solution[framed,fragile\|framed\|defersolutiontitle]`, `\newframe`, `\solutiontitle`; `beamersolution[defersolutiontitle]` (207) |
| sub-exercise references | examples/exshexample.tex:71,180-182; exercisesheets.sty:1316-1337 | `xref.varioref`, `xref.kernel` | `\usepackage{varioref}` (line 21), `\ref`, package `\subexnref`, `\subexlref`, `\thesubex` |
| counter set | examples/exshexample.tex:159 | `num.counters` | `\setcounter{enumi}{2}` |
| lists in sheets | examples/exshexample.tex:66-79,158-164 | `list.kernel` | nested `enumerate` (item labels patched by the package: exercisesheets.sty:1323-1347) |
| page break in a solution | examples/exshexample.tex:123 | `pg.break` | `\newpage` |
| verbatim in a solution | examples/exshexample.tex:100-111 | `code.verbatim` | `\verb\|..\|`, `verbatim` environment |
| font size and shape in keys | examples/exshexample.tex:146,219 | `font.size-commands`, `mark.kernel` | `\tiny`, `\itshape` |
| Lua exercise (LuaLaTeX only) | examples/exshexample.tex:133-144,236-281 | `exam.questions` | `Lexercise` environment with Lua table keys task, firstline, points, name, options, solution, altsolutions, subexercises, bonuspoints, pointoptions |
| exercise from file | examples/exshexample.tex:58-59; examples/exercises/exshexample-ex1.tex:1-8; examples/exercises/exshexample-ex2.lua:1-6 | `exam.questions` | `\includeexercise*{file}`, `\includeLexercise*{file}` (LuaLaTeX only), `exercisespath=exercises` |
| embedded mode | examples/exshexample-embedded.tex:54,56-63,93-109 | `exam.questions` | option `embedded`; `strings/sheet={Missions}`, `subtask environment=stlist`, `task restate font={\color{gray}}`, `sheet sectioning cmd=\sheetfancy`, `\includeexercise*[imp]`, `\includeLexercise*[vi]` |
| beamer themes | examples/exshexample-embedded.tex:2-5 | `slide.beamer-theme` | `\usetheme{Berlin}`, `\usefonttheme{professionalfonts}`, `\useoutertheme{infolines}`, `\useinnertheme{rounded}` |
| beamer templates and colours | examples/exshexample-embedded.tex:6-16; examples/exshexample.tex:7 | `slide.beamer-template` | itemize items circle, enumerate items circle, sections/subsections in toc circle, item projected bg=black, item fg=black, navigation symbols empty, footline frame number, block title bg=black, section in toc fg=red bg=white |
| section hooks | examples/exshexample-embedded.tex:18-32 | `slide.beamer-section-hook` | `\AtBeginSection[]`, `\AtBeginSubsection[]` with a block of `\tableofcontents[sectionstyle=show/shaded,subsectionstyle=hide/hide/hide]` (and `show/hide`, `show/shaded/hide`); `frame[allowframebreaks]` |
| frames and overlays | examples/exshexample-embedded.tex:72-91; examples/exshexample.tex:189-195,208-212 | `slide.beamer-mode` | `frame`, `frame[t]`, `block`, `\pause` |
| deck title | examples/exshexample-embedded.tex:35-40,72-74 | `front.maketitle` | `\author`, `\title`, `\subtitle`, `\date{compilation date: ...}` (date string is content, see Bespoke code), `\maketitle` in a frame |
| deck sectioning | examples/exshexample-embedded.tex:76,82,84,96 | `head.kernel` | `\section`, `\subsection` |
| paragraph shape | examples/exshexample-embedded.tex:66-67 | `sp.lengths` | `\parindent 0pt`, `\parskip=\baselineskip` |
| bold text | examples/exshexample-embedded.tex:79 | `mark.kernel` | `\textbf` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\ifbeamer` selector | examples/exshexample.tex:1-2,6-8,46,84-90 | yes | `\long\def\ifbeamer#1#2{#2}` only selects its second argument; it is a compile-time switch, so an emitter writes one realisation. Article realisation: `class.article[a5paper]`, `exam.questions`. Beamer realisation: `class.beamer`, `\setbeamertemplate{navigation symbols}{}` (`slide.beamer-template`), `beameruseblocks=false`. |
| `\newenvironment<>{stlist}[1][]` | examples/exshexample-embedded.tex:44-49 | yes | an environment alias: three `\setbeamertemplate{enumerate items/subitem/subsubitem}` lines (`slide.beamer-template`) then `enumerate[#1]` (`list.kernel`); passed to the package as `subtask environment=stlist` (line 59). |
| `\def\sheetfancy[#1]#2{\textcolor{red}{#2}}` | examples/exshexample-embedded.tex:104-105 | yes | an alias over `\textcolor` (`color.xcolor`) given to key `sheet sectioning cmd`; the file's own comment (line 104, "nope, nothing happens") and the example text (107-108) say beamer ignores it. |
| `imp/.style`, `vi/.style` | examples/exshexample-embedded.tex:61-62 (used 93,94,100,109) | yes | pgfkeys named option sets of the package: inline `[imp]` as `[pointsinfo=important]` and `[vi]` as `[pointsinfo=very important]`. |
| `\date{compilation date: \the\year-\two@digits{\the\month}-\two@digits{\the\day}}` | examples/exshexample-embedded.tex:38-40 | yes | kernel registers and the kernel `\two@digits` only print a date string: `\date{<string>}` (`front.maketitle`); content, no zip-local definition. |
| manual aliases `\exsh \param \maybe \mand \codestyle \optionstyle \option \optitem \vers \versitem \filename \binary \luadisp` | exercisesheets-doc.tex:88-101 | yes | `\newcommand` aliases over `\texttt`, `\textcolor`, `\normalfont\ttfamily\color{..}`, `$\langle..\rangle$`, `\item[..]`, `\xspace`; inline expansion into `mark.kernel`, `color.xcolor`, `list.kernel`. `xspace` only ends `\exsh` (line 88); filed as lib v4 ruled for `sp.xspace` (macro-body helper, reduces by inline expansion), not as a way. |
| `calc` loaded, unused | exercisesheets-doc.tex:26 | yes | load-only; no `\widthof`, `\ratio` or infix length arithmetic occurs in the file (grepped), so nothing to recover. |
| `exercisesheets.sty` internals (pgfkeys option tree, token-scanning skip engine, `\@startsection` header, expl3 helper, LuaLaTeX hooks) | exercisesheets.sty:142-489,755-872,1193,1890-1961 | not bespoke | the file is the published CTAN package (W1: zip origin is the CTAN mirror, ctan.org/pkg/exercisesheets, LPPL 1.3c; W2 options at 142-489; W3 any exercise sheet; W4 `\usepackage[opts]`, `\exshset{}` and the `sheet`, `exercise`, `solution` environments). It loads only published packages (etoolbox, scrlfile, environ, pgfkeys, keyval, kvoptions, ifthen, ifluatex, amsmath, currfile, catchfile, refcount: exercisesheets.sty:30-47) and no shell escape or external tool. |
| `exsh_lexercise.lua` | exercisesheets.sty:1961; README:14 (file absent from the zip) | unread | helper of the published package, defines `exercise{}`, `exsh_texprintlines`, `fragileframed`; not read. The rubric treats missing assets as ship-and-note; here the file belongs to the package, so it is shipped by the package, not copied by an emitter. Lua code in a published package is part of the way, not zip-local code. |

## Content-opaque
- Lexercise bodies and `exercises/exshexample-ex2.lua`: exercise and solution text inside Lua long strings (examples/exshexample.tex:133-144,236-281; examples/exercises/exshexample-ex2.lua:1-6); the text is content, the key names are the package's interface.
- Verbatim block with a stray `%`, `$`, `&`, `#` sample (examples/exshexample.tex:102-111) is code text.
- The manual's listing contents and the changelog text (exercisesheets-doc.tex:188-1076) are content.

## Lib changes
- New ways proposed: none. Considered: giving `exercisesheets` its own doc-kind line (a sibling of `exam.schooldocs`); not proposed, because `exam.questions` already admits other question-bank packages with the package as the parameter and `exercisesheets` is of that type (exercise, solution, points, hint environments; solutions switched by option; exercises reusable from files). Its engine-restricted part (`Lexercise`, `\includeLexercise`, `fragile`) is LuaLaTeX only; the consolidator may want an engine note on `exam.questions`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
