no

# 0191-cloze: cloze (LuaLaTeX package for gap-fill texts) and its ltxdoc manual

- Unverified: read from the source, not compiled.
- Source: Source/0191-cloze/ (origin: https://mirrors.ctan.org/macros/luatex/generic/cloze.zip; licence: LPPL 1.3c per the manifest and README.md:11-16)
- Kind: misc (the sample is a package manual; the manifest hint `exam` comes from the package's purpose, cloze worksheets, not from the sample's layout)
- Lib: v4
- Engine: needs LuaLaTeX (`cloze.tex:29-32` runs `\directlua` and `require('cloze')`; `cloze.lua:1684-1703` registers LuaTeX node callbacks; `cloze.sty:46` loads `luakeys`, which CTAN says is LuaTeX only; `cloze-doc.tex:4` loads `fontspec`)
- Look carried by: mixed (kernel/ltxdoc defaults, a preamble of published packages at `cloze-doc.tex:2-71`, and the published `cloze` package, whose zip-supplied files `cloze.sty`, `cloze.tex`, `cloze.lua` draw the gaps; none of the three is zip-local code, see Verdict)
- Class origin: tex-distribution-unbundled (`ltxdoc`, `cloze-doc.tex:1`; the class file is not in the zip and its source was not read)
- Main file: cloze-doc.tex (other samples: none; the `\documentclass{article}` snippets at `cloze-doc.tex:239-244` sit inside a `minted` block, they are displayed code, not samples)
- Read: main yes (all 2607 lines), zip-local classes and styles all (`cloze.sty` 190 lines, `cloze.tex` 246 lines, `cloze.lua` 1912 lines; `README.md` too)

## Verdict
The zip is the CTAN release of the `cloze` package plus its manual. The package itself is published (CTAN since 2015, TeX Live, LPPL 1.3c), is steered by key=value options, and serves any gap-fill worksheet, so it passes W1 to W4 and is proposed as the doc-kind way `exam.cloze`; its Lua node-list code is the package's implementation, not zip-local bespoke code. The verdict is `no` because the manual loads `minted` unconditionally in its own preamble (`cloze-doc.tex:59-69`) and uses it in 42 `\begin{minted}` blocks, and `minted` needs Pygments and shell escape outside TeX. Everything else maps to existing ways or reduces by inline expansion; the TikZ and forest drawings are manual illustrations and are recorded as content.

## Blockers
- `EXTERNAL/package` `minted` loaded in the sample preamble with `\usemintedstyle`, `\setminted` and an environment hook (`cloze-doc.tex:59-69`), first used at `cloze-doc.tex:224`, plus `\mintinline` at `cloze-doc.tex:588`; the document does not compile without Pygments and `-shell-escape` (way `code.minted`, listed as EXTERNAL in the lib).

Notes, not blockers:
- `cloze.lua:1905-1911` (`print_test`) also prints a `minted` block, but its comment says it is only for the author's visual test files, and `cloze.sty` never loads `minted`; so the package itself is not EXTERNAL, only the manual is.
- Missing assets: the manual selects fonts it does not ship, `\fontspec{Kalam}` (`cloze-doc.tex:747`), the `qualitype` fonts (`cloze-doc.tex:1893-1898`) and the Google fonts Coming Soon, Gluten, Kalam, Mali, Oregano (`cloze-doc.tex:1949-1992`). They would have to be shipped.
- `cloze.tex:36` does `\input farbe.tex`, a file the zip does not hold; `farbe` is on CTAN and in TeX Live (read at https://ctan.org/pkg/farbe), so it is a published dependency, as are `luakeys` (read at https://ctan.org/pkg/luakeys), `setspace` (`cloze.sty:40`) and `lparse` (`cloze.lua:42`, linked at `cloze-doc.tex:219`, not read separately).
- `cloze-doc.tex:123` calls `\GetFileInfo{cloze.dtx}`, a file that is not in the zip; there is no `.dtx`, the manual is a plain `.tex` under `ltxdoc`.
- The index (`\CodelineIndex` `cloze-doc.tex:114`, `\PrintIndex` `cloze-doc.tex:2606`) needs a `makeindex` pass, a tool shipped with the TeX distribution like `bibtex`; it is not counted as EXTERNAL.

## Class setting
- Class: `class.ltxdoc` options: none (`cloze-doc.tex:1`)
- Class-native vocabulary used: `\DescribeMacro` and `\DescribeEnv` (`cloze-doc.tex:266`, `cloze-doc.tex:551`), `\cmd` `\oarg` `\marg` `\meta` (`cloze-doc.tex:94`, `cloze-doc.tex:266`), `\GetFileInfo` (`cloze-doc.tex:123`), `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges` (`cloze-doc.tex:113-115`), `\MakeShortVerb{\|}` (`cloze-doc.tex:71`), `\PrintIndex` (`cloze-doc.tex:2606`). No `\DocInput`, no `macrocode`, no `\changes`. `ltxdoc` itself loads `doc`; its source was not read.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | cloze-doc.tex:1 | `class.ltxdoc` | no options |
| page geometry, header/footer | not set anywhere in cloze-doc.tex | `class.ltxdoc` | class defaults (the class source was not read; no row of its own) |
| cloze package load | cloze-doc.tex:2 | `exam.cloze` | `\usepackage[show]{cloze}` (package option `show`; global options are also accepted as `\usepackage[show,margin=1cm]{cloze}`, shown as code at cloze-doc.tex:240) |
| global gap settings | cloze-doc.tex:187, :1124, :1602, :1886 | `exam.cloze` | `\clozeset{hide}`, `\clozeset{thickness=3mm,line_color=yellow,text_color=magenta,margin=-2pt}`, `\clozeset{margin=3mm}`, `\clozeset{margin=7pt}`; `\clozereset` (cloze-doc.tex:1102); `\clozeshow` `\clozehide` (cloze-doc.tex:97-107); defaults at cloze.lua:114-134 |
| gap font | cloze-doc.tex:324, :337, :343, :747, :2038 | `exam.cloze` | `\clozesetfont{\Large}`, `{\ttfamily\normalsize}`, `{\itshape}`, `{\Huge\fontspec{Kalam}}`, `{}`; `\clozesetfont` at cloze.tex:147-151, `\clozefont` default `\itshape` at cloze.sty:55 |
| inline gap | cloze-doc.tex:273-278, :1505 | `exam.cloze` | `\cloze[hide, show, margin=, thickness=, distance=, spread=, text_color=, line_color=, font=, visibility=]{text}` (any of these keys); `\clozenol` (cloze-doc.tex:417, = `thickness=0pt`, cloze.lua:1760-1762) |
| fixed-width gap | cloze-doc.tex:365-367, :376, :389 | `exam.cloze` | `\clozefix[width=5cm,align=right\|center\|left]{text}` |
| gap to end of line | cloze-doc.tex:472-481, :1339 | `exam.cloze` | `\clozefil[distance=,text_color=,line_color=]{text}`; `\clozelinefil` (cloze-doc.tex:828), `\clozeline[width=1cm]` (cloze-doc.tex:810), `\clozeextend[30]` (cloze-doc.tex:539, keys `extend_count` `extend_height` `extend_width`) |
| gap paragraph | cloze-doc.tex:560-564, :1652-1655 | `exam.cloze` | `clozepar` environment, `\clozeparcapture` (cloze-doc.tex:612), `\clozeparplain` (cloze-doc.tex:1044); key `min_lines=4` (cloze-doc.tex:1640) |
| gap box and spacing | cloze-doc.tex:689-692, :1218, :777-781 | `exam.cloze` | `clozebox` and `clozebox*` with `box_height` `box_width` `box_rule`; `clozespace[spacing=2]`; `\clozestrike[text_color=red]{wrong}{right}` (cloze-doc.tex:849, :864) |
| title block | cloze-doc.tex:124-138 | `front.maketitle` | `\title` with a `\cloze` inside, `\author` with `\\`, `\url`, `\href`, `\date{v2.0.0~from 2025/07/04}`, `\maketitle\vfill` |
| title footnote | cloze-doc.tex:125-128 | `front.thanks` | `\thanks{...}` |
| contents and depth | cloze-doc.tex:142-144 | `toc.kernel` | `\tableofcontents` |
| section depth | cloze-doc.tex:142-143 | `num.secnumdepth` | `secnumdepth`=5, `tocdepth`=5 |
| headings | cloze-doc.tex:151, :203, :209, :215 | `head.kernel` | `\section` `\subsection` `\subsubsection` (also `\subsubsection*` at cloze-doc.tex:1869) with class defaults |
| paragraph headings | cloze-doc.tex:21-28 | `head.titlesec` | `\titleformat{\paragraph}[hang]{\normalfont\normalsize\bfseries}{\theparagraph}{1em}{}`; `\titleformat{\subparagraph}[hang]{\normalfont\small\bfseries}{\thesubparagraph}{1em}{}`; `\titlespacing*{\subparagraph}{0pt}{*1}{0pt}` |
| links | cloze-doc.tex:34-39 | `meta.hyperref` | `colorlinks=true`, `linkcolor=red`, `filecolor=red`, `urlcolor=red`; `\href` at cloze-doc.tex:133, :219 |
| url | cloze-doc.tex:122, :132 | `meta.url` | `\providecommand*{\url}{\texttt}` is a fallback, `\url` also comes from hyperref |
| cross-references | cloze-doc.tex:89-91, :264 | `xref.kernel` | `\label{sec:...}`, `\ref{...}` (through `\TmpSecRef`) |
| colours | cloze-doc.tex:46-48, :1532 | `color.xcolor` | `\definecolor{TmpGray}{gray}{0.95}`, `\definecolor{TmpYellow}{rgb}{0.949019608,0.839215686,0.666666667}`, `\definecolor{myclozecolor}{rgb}{0.1,0.4,0.6}`; the `TmpYellow!3` tints need xcolor, which `tikz` and `hyperref` load (those sources are not in the zip) |
| demo frames | cloze-doc.tex:45-53, :435, :446 | `box.mdframed` | `\newmdenv[backgroundcolor=TmpYellow!3,linecolor=TmpYellow!70]{TmpExample}`; `\surroundwithmdframed[backgroundcolor=TmpGray]{verbatim}`; `mdframed[backgroundcolor=gray!40]` |
| displayed code | cloze-doc.tex:59-69, :224 | `code.minted` | `\usemintedstyle{colorful}`, `\setminted{breaklines=true,fontsize=\footnotesize}`, 42 `\begin{minted}{latex\|tex\|shell}`, `\mintinline{latex}`; EXTERNAL |
| framing of code blocks | cloze-doc.tex:61-65 | `box.mdframed` | `mdframed[backgroundcolor=TmpGray!60,linecolor=gray!40]` wrapped round each `minted` by `\BeforeBeginEnvironment` / `\AfterEndEnvironment` |
| verbatim and short verb | cloze-doc.tex:160-162, :166-168, :71 | `code.verbatim` | `verbatim` environment in `minipage` (cloze-doc.tex:159, :165); `\MakeShortVerb{\|}` |
| doc commands and index | cloze-doc.tex:113-115, :123, :266, :551, :2606 | `dtx.doc` | `\DescribeMacro`, `\DescribeEnv`, `\GetFileInfo{cloze.dtx}`, `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\PrintIndex` |
| lists | cloze-doc.tex:511-522, :525-531, :593-601, :1649-1668 | `list.kernel` | `description`, `itemize`, `enumerate`; `\renewcommand{\labelenumi}{\alph{enumi})}` (cloze-doc.tex:2177) |
| compact list | cloze-doc.tex:364-368 | `list.paralist` | `compactenum` |
| columns | cloze-doc.tex:7, :685-706 | `cols.multicol` | `multicols{2}`, `\columnbreak` (many uses, e.g. cloze-doc.tex:2188-2201) |
| tables | cloze-doc.tex:879-967, :386-397, :2299-2306 | `tbl.tabular` | `tabular{lll}` with `\hline`; `tabular{p{5cm}p{4cm}}`; `tabular{ll}` with `\arraystretch`=1.5 (cloze-doc.tex:2298); `tabbing` with `\kill` and `\=` (cloze-doc.tex:1871-1882, :2220-2223) is the kernel tab-stop table, filed here as the same kernel family |
| display and inline maths | cloze-doc.tex:8, :2056, :2071, :2091, :2126, :2149 | `math.amsmath` | `multline*` (cloze-doc.tex:2149); `equation`, `displaymath`, `\[ \]`, `$$ $$` and `$...$` are `math.kernel` rows of the same demos |
| graphics package | cloze-doc.tex:3, :2173 | `fig.graphicx` | `\usepackage{graphicx}`; only `\scalebox{1.5}{$..$}` is used, no `\includegraphics`, no float |
| fonts | cloze-doc.tex:4, :747, :1887, :1937 | `font.fontspec` | `\fontspec{Kalam}`, `\fontspec{#1}` for the `qualitype` and Google fonts (assets not shipped) |
| sizes and shapes | cloze-doc.tex:324, :876, :2348, :2545 | `font.size-commands` | `\Large` `\Huge` `\footnotesize` `\scriptsize` `\normalsize` |
| inline marks | cloze-doc.tex:86, :99, :644, :1643 | `mark.kernel` | `\texttt` `\textbf` `\textit` `\emph` `\itshape` `\ttfamily` |
| spacing | cloze-doc.tex:110, :138, :644, :2173 | `sp.manual-space` | `\vspace{-0.2cm}`, `\vfill`, `\bigskip` `\medskip`, `\hspace{0.3cm}`, `\hfill` |
| alignment | cloze-doc.tex:387, :2266 | `sp.ragged` | `\raggedleft` in a `p` cell; `\center{...}` (the bare environment-start macro, closed by the enclosing `TmpExample` group) |
| page breaks | cloze-doc.tex:140, :150, :1614, :2230, :2605 | `pg.break` | `\pagebreak`, `\newpage` |
| illustrations | cloze-doc.tex:974-1052, :2394-2423, :2442-2525, :2547-2566 | `art.tikz` | content (see Content-opaque) |
| picture demo | cloze-doc.tex:2247-2258 | `art.pstricks` | `picture` environment with `\put` and `\line`, content |
| tree demo | cloze-doc.tex:2349-2359 | `art.tikz` | `forest` tree (a pgf-based package), content |

Components the zip does not use: header/footer settings, language packages (German words are content, `cloze-doc.tex:296-306`, no `babel` is loaded), theorems, floats and captions, footnotes beyond `\thanks`, bibliography, quotes, page geometry.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `cloze.sty`, `cloze.tex`, `cloze.lua` (Lua node-list callbacks, whatsit markers, pdf colour stacks) | cloze.sty:26-190, cloze.tex:29-246, cloze.lua:1207-1634, cloze.lua:1684-1703 | n/a: published | the zip is the CTAN release of `cloze`, so this is the implementation of one published way, `exam.cloze`, driven by options only; an emitter prints `\usepackage[..]{cloze}` and the `\cloze...` wrappers and never copies this code. If a reviewer rules that the package source of the zip being analysed counts as bespoke, this row would be `BESPOKE/package`, irreducible to other lib ways (callbacks that rewrite node lists after line breaking). |
| `\catcode`\_=12` | cloze-doc.tex:15 | yes | content-level: a literal `\_` for each underscore printed in text (`\tt{box_height}` at cloze-doc.tex:1201 and similar); no lib way for a catcode line, so it is dropped by inline expansion |
| `\TmpExpDesc`, `\TmpDesc` | cloze-doc.tex:77-83 | yes | inline `\hfill(\verb\|..\|)\par`: `sp.manual-space`, `code.verbatim` |
| `\def\tt#1` | cloze-doc.tex:85-87 | yes | `\texttt{#1}`, `mark.kernel` |
| `\TmpSecRef` | cloze-doc.tex:89-91 | yes | `(\rightarrow\ \ref{label})`, `xref.kernel` (`\rightarrow` is a math symbol used in text; not compiled here, not checked) |
| `\TmpOption` | cloze-doc.tex:93-95 | yes | `\texttt{[name=}\meta{value}\texttt{]}`, `mark.kernel`, `dtx.doc` |
| `\TmpHide`, `\TmpShow` | cloze-doc.tex:97-107 | yes | `\noindent\texttt{\string\clozehide}:` then `\clozehide`, `mark.kernel`, `exam.cloze` |
| `\TmpReduceVspace` | cloze-doc.tex:109-111 | yes | `\vspace{-0.2cm}`, `sp.manual-space` |
| `\newmdenv{TmpExample}`, `\surroundwithmdframed` | cloze-doc.tex:49-53 | yes | `box.mdframed` declarations (commands of the published `mdframed`) |
| `\BeforeBeginEnvironment{minted}`, `\AfterEndEnvironment{minted}` | cloze-doc.tex:61-65 | yes | etoolbox hooks (published, considered: `etoolbox`, not proposed); reduce to an `mdframed` wrapper around each `minted` block; moot, since `minted` is the EXTERNAL blocker |
| `\providecommand*{\url}{\texttt}` | cloze-doc.tex:122 | yes | dropped; hyperref supplies `\url`, `meta.url` |
| content macros `\clozelorem`, `\TmpExampleClozefil`, `\TmpOrbit`, `\TmpExampleMinlines`, `\TmpPicture`, `\TmpTabluarEnglishGerman`, `\TmpSubtraction`, `\TmpForestBach`, `\TmpTikzExampleAlignment`, `\TmpTimeline`, `\TmpNumberPyramid(s)` | cloze-doc.tex:176, :467, :746, :1642, :2245, :2296, :2169, :2345, :2393, :2442, :2546 | yes | each is a text or picture body used twice (hide then show) or once; inline expansion at each call site |
| parametrised demo macros `\TmpOptionAlign`, `\TmpOptionDistance`, `\TmpExtendCount`/`Height`/`Width`, `\TmpOptionShow`, `\TmpOptionColor`, `\TmpOptionMargin`, `\TmpOptionSpread`, `\TmpOptionThickness`, `\TmpOptionWidth`, `\TmpOptionVisibility`, `\TmpWay`, `\TmpMath` | cloze-doc.tex:1185, :1337, :1384, :1503, :1534, :1580, :1725, :1778, :1802, :1836, :644, :2172 | yes | one `\cloze...[key=value]` call per value, written out |
| `\TmpHandwritingCtan`, `\TmpHandwritingGoogle` with a `\directlua` that replaces spaces by `+` in a font name | cloze-doc.tex:1868-1889, :1918-1939 (Lua at :1923-1927) | yes | the Lua only builds a URL string for printing; evaluate it by hand per font and inline the literal text; the rest is `font.fontspec` and `\clozeset{margin=7pt}` |
| `\newcount\yearOne`, `\yearArrowLabel(##1,..)`, `\pgfmathparse`, `\ifnum`, `\foreach` | cloze-doc.tex:2451-2498 | inside content | logic inside a TikZ picture that is a demonstration, so recorded as Content-opaque, not as template code |

## Content-opaque
- TikZ pictures annotating the options, with `\cloze` inside the nodes: cloze-doc.tex:974-999, :1006-1037, :1040-1052. They sit in the body, not in a float; they are illustrations of the manual, not a cover, banner or page frame, so they are treated as content, not `ART`.
- TikZ demos: text-box alignment at cloze-doc.tex:2394-2423, timeline at cloze-doc.tex:2442-2525 (with hand-rolled `\newcount` and `\pgfmathparse` logic at cloze-doc.tex:2451-2476), number pyramid at cloze-doc.tex:2547-2566.
- `forest` tree at cloze-doc.tex:2349-2359 and `picture` environment at cloze-doc.tex:2247-2258.
- Lorem ipsum, German word lists, tables of composers, castle and timeline texts, equations (cloze-doc.tex:2049-2161) are content.

## Lib changes
- New ways proposed: `exam.cloze`: package `cloze` (CTAN, TeX Live and MiKTeX, LPPL 1.3c, Josef Friedrich; v2.0.0 of 2025/07/04 per cloze.sty:21; read once at https://ctan.org/pkg/cloze, and README.md:27-44 gives the same), gap-fill texts for worksheets and cloze tests; engine xe/lua (LuaLaTeX only); depends on `luakeys`, `farbe`, `lparse` and `setspace`, all on CTAN.
  - Preamble: `\usepackage[show|hide,<key=value>]{cloze}`, `\clozeset{<keys>}`, `\clozereset`, `\clozeshow` `\clozehide`, `\clozesetfont{<font switches>}`.
  - Body: `\cloze[keys]{text}`, `\clozenol`, `\clozefix[width,align]{text}`, `\clozefil`, `\clozeline`, `\clozelinefil`, `\clozeextend[n]`, `\clozestrike{wrong}{right}`, environments `clozepar`, `clozebox`, `clozespace`, and the capture command `\clozeparcapture`.
  - Keys (cloze.lua:335-435): `align` (left, center, right), `box_height` `box_rule` `box_width` `distance` `extend_height` `extend_width` `margin` `thickness` `width` (lengths), `extend_count` `min_lines` `debug` (integers), `spacing` `spread` (numbers), `line_color` `text_color` (colour names), `font` (a font switch), `visibility` (boolean, with `show` and `hide` as its opposite keys).
  - W1 Published: on CTAN since July 2015 and in TeX Live (README.md:27-44; CTAN page read once). W2 Declarative: the behaviour is chosen by the keys above (lengths, integers, numbers, colour names, a boolean), parsed by `luakeys` (cloze.lua:335-465), not by editing code. W3 Generic: it serves any worksheet or test that hides words behind lines (the manual shows fill-in sentences, tables, maths, trees and pictures), not one document. W4 Printable: one preamble line with options plus `\clozeset` lines, and body wrappers `\cloze[..]{..}` or environments around a node's text; the hidden text is removed from the output in `hide` mode (cloze-doc.tex:431-433). Placed with the doc-kind ways beside `exam.questions` and `exam.competences`; not `mark.*` (it also has block environments), not `exam.questions` (question banks, not gaps inside running text).
  - Not proposed: a way for an `etoolbox` environment hook (the hook reduces to a body wrapper) and for a `\catcode` line (reduces to content escapes).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
