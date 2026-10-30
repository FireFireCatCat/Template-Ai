no

# 0783-exercisebank: exercisebank (CTAN package, v0.3.0 build 137) and its manual

- Unverified: read from the source, not compiled.
- Source: Source/0783-exercisebank/ (origin: https://mirrors.ctan.org/macros/latex/contrib/exercisebank.zip; licence: LPPL 1.3c)
- Kind: assignment
- Lib: v6
- Engine: pdfLaTeX-compatible (pdfTeX only: exercisebank.sty:22-24 stops with an error unless `\pdfstrcmp` exists, so XeLaTeX and LuaLaTeX are excluded)
- Look carried by: mixed (the manual's look is in its own preamble over `article` and tcolorbox's documentation library, exercisebank-doc.tex:16-129; the exercise-set look is in exercisebank.sty, a CTAN package that the manual does not load and example.tex does)
- Class origin: tex-distribution-unbundled
- Main file: exercisebank-doc.tex (other samples: example.zip, a nested zip not unpacked; its `example/example.tex`, `example/mathcommands.tex`, `example/exercises/mechanics/center-of-mass.tex`, `example/figures/mechanics/rod.tex` were read in memory, cited as `example.zip:example/...:line`)
- Read: main yes, zip-local classes and styles all (exercisebank.sty, 1030 lines, read in full; it is on CTAN, see ctan.org/pkg/exercisebank: author Andreas Storvik Strauman, v0.3.0 of 2019-03-18, LPPL 1.3c, in TeX Live and MiKTeX). tcolorbox, hyperref, listings and comment sources were not read.

## Verdict
No. The main sample is the package manual (exercisebank-doc.tex). Its callout box `marker` draws a folded corner and a yellow "!" bar with raw TikZ paths inside tcolorbox's `underlay` key (exercisebank-doc.tex:41-45), which is template-defining artwork with no declarative lib way, so `ART/preamble` blocks it. The rest of the manual reduces to lib ways (tcolorbox documentation library as a `dtx.doc` parameter, `code.tcblisting`, `toc.titletoc`, `pg.needspace`, inline expansion of the aux-driven thanks macros) and the package itself is a published CTAN package, so the exercise-set side (example.zip) maps to `exam.questions` with `exercisebank` as the parameter. Unverified caveat, not counted as a blocker: `\usepackage[all]{tcolorbox}` (exercisebank-doc.tex:17) may load tcolorbox's `minted` library, which would be `EXTERNAL/package` (shell escape and Pygments); the tcolorbox manual was not read here.

## Blockers
- `ART/preamble` the `marker` callout box: `enhanced` skin with `underlay={...}` TikZ `\path` drawings (fold triangle, "!" side bar) and `drop fuzzy shadow` (exercisebank-doc.tex:35-46); used at exercisebank-doc.tex:306, 331, 385, 724, 727

## Class setting
- Class: `class.article` options: `a4paper` (exercisebank-doc.tex:16; example.zip:example/example.tex:1 has no options)
- Class-native vocabulary used: `\title` `\author` `\maketitle` `\tableofcontents` `\section` `\subsection` `\subsubsection` `\clearpage` `itemize` (exercisebank-doc.tex:130-145, 624-627); no `abstract`

## Component map
A. Main sample, exercisebank-doc.tex (the manual)

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | exercisebank-doc.tex:16 | `class.article` | a4paper |
| paper size | exercisebank-doc.tex:16 | `page.class-options` | a4paper |
| page geometry | exercisebank-doc.tex:20 | `page.geometry` | loaded, no `\geometry` call; only a commented `\newgeometry{lmargin=0.7cm}` at :864 |
| paragraph shape | exercisebank-doc.tex:129 | `sp.lengths` | `\parindent`=0pt |
| title block | exercisebank-doc.tex:130-133 | `front.maketitle` | `\title{{exercisebank - manual\\ v0.3.0{\\[-0.5em]\footnotesize(build 137)}}}`, `\author{Andreas Strauman}` |
| title spacing and size | exercisebank-doc.tex:130 | `sp.manual-space`, `font.size-commands` | `\\[-0.5em]`, `\footnotesize` |
| contents | exercisebank-doc.tex:97-98, 143 | `toc.kernel` | `\tableofcontents` wrapped in a group with `\hypersetup{linkcolor=black}` (:98) |
| hand-added contents lines | exercisebank-doc.tex:313-315 | `toc.kernel` | `\addcontentsline{toc}{subsubsection}{...}` per documented item |
| headings | exercisebank-doc.tex:145, 148, 311 | `head.kernel` | default article numbering and look, no titlesec |
| space before headings | exercisebank-doc.tex:123-126 | `pg.needspace` | `\needspace{0.3\paperheight}` before `\section`, `\needspace{0.2\paperheight}` before `\subsection` |
| page breaks | exercisebank-doc.tex:144, 312 | `pg.break` | `\clearpage`, `\filbreak` (plain TeX page-flow command, same family) |
| package documentation environments | exercisebank-doc.tex:318-328, 527-530, 771 | `dtx.doc` | tcolorbox `documentation` library (considered, merged into this line as `hypdoc` and `codedescribe` were): `docCommand`, `docEnvironment`, `docKey` (via `\keyDef`), `\docCounter`, `\refCom` `\refEnv` `\refKey`, `\docAuxCommand`, `\meta` `\marg` `\oarg` |
| displayed code listings | exercisebank-doc.tex:153-165, 116, 120 | `code.tcblisting` | `dispListing` and `dispListing*{title=...}`; `\tcbset{documentation listing style=mydocumentation}` |
| listing style | exercisebank-doc.tex:24-34 | `code.listings` | `\lstdefinestyle{mydocumentation}{style=tcbdocumentation, texcsstyle=*\color{blue}, moretexcs={...}, ...}` |
| callout box | exercisebank-doc.tex:35-46, 306-310 | `box.tcolorbox` | `\newtcolorbox{marker}[1][]{enhanced, before skip=2mm, after skip=3mm, boxrule=0.4pt, left=5mm, right=2mm, top=1mm, bottom=1mm, colback=yellow!50, colframe=yellow!20!black, sharp corners, rounded corners=southeast, arc is angular, arc=3mm, drop fuzzy shadow}`; the `underlay` drawing is ART (Blockers) |
| colours | exercisebank-doc.tex:101, 26, 32 | `color.xcolor` | `\definecolor{green(munsell)}{rgb}{0.0,0.70,0.47}`; `blue`; `Definition` (colour name from the documentation library, not read) |
| link colours | exercisebank-doc.tex:98, 119-121 | `meta.hyperref` | `\hypersetup{colorlinks=true}`, `linkcolor=Definition`, `linkcolor=black`; hyperref is loaded implicitly through tcolorbox (not read) |
| margin notes | exercisebank-doc.tex:99-102 | `note.marginpar` | `\reversemarginpar`; `\updated` and `\defnew` call `\tcbdocmarginnote` (`dtx.doc` family) |
| lists | exercisebank-doc.tex:141, 624-627 | `list.kernel` | `itemize` |
| footnote without mark | exercisebank-doc.tex:70, 142 | `fn.kernel` | `\footxt` = `\@footnotetext` with empty `\@thefnmark` (see Bespoke code) |
| inline marks | exercisebank-doc.tex:152, 238 | `mark.kernel` | `\emph`, `\texttt`, `\textbf` |
| changelog table | exercisebank-doc.tex:72-95, 865-959 | `toc.titletoc` | custom toc types `version` and `change`, see Bespoke code |
| macro list | exercisebank-doc.tex:47-48, 809-861 | `toc.titletoc` | custom toc type `macro`, one entry per line, see Bespoke code |
| unused loads | exercisebank-doc.tex:19, 21 | `tbl.tabularx` | `tabularx` loaded, no `tabularx` environment in the file; `listofitems` only feeds the thanks helper at :60 |

B. The package and its example (the zip's actual template), exercisebank.sty and example.zip

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| exercise sets with solutions | exercisebank.sty:16, 727, 858-919; example.zip:example/example.tex:2, 28, 31 | `exam.questions` | package parameter `exercisebank`: `\usepackage{exercisebank}`, `\makeset{my-mechanics-set}{mechanics/center-of-mass}`, `\buildset{my-mechanics-set}` |
| package keys | example.zip:example/example.tex:20-25; exercisebank.sty:221-257 | `exam.questions` | `\exercisebanksetup{exercise directory=exercises, figure root directory=figures}`; other keys `part problems`, `problem header`, `part problem header`, `solution header`, `problem needs space`, `style margins`, `show lonely part problems` |
| problem, part-problem, solution headers | exercisebank.sty:224-227, 414, 442, 456 | `exam.questions` | defaults `{\Large\bfseries\@tr{Problem}~\theproblemcounter}`, `{\large\textbf{(\theproblemcounter\alph{partproblemcounter})}}`, `{\large{\textbf{\@tr{Solution}:}}}`; headers sit in the left margin through `\vadjust` and `\llap` |
| exercise environments | example.zip:example/exercises/mechanics/center-of-mass.tex:2, 17, 21 | `exam.questions` | `intro`, `problem`, `solution` (built on `comment`, so `\end{...}` must sit alone on a line, exercisebank.sty:20, 524-627) |
| points | example.zip:example/exercises/mechanics/center-of-mass.tex:16, 33; exercisebank.sty:966-987 | `exam.questions` | `\nextproblem{points=1}`, `\exercisepoints` |
| class | example.zip:example/example.tex:1 | `class.article` | no options |
| margin lengths | exercisebank.sty:387-403 | `exam.questions` | `\pMarginBelow` `\pMarginAbove` `\pMarginLeft` `\ppMargin` `\ppMarginBelow` `\ppMarginAbove` `\introOutdent` `\solutionMarginAbove` |
| maths | example.zip:example/mathcommands.tex:1; example.zip:example/exercises/mechanics/center-of-mass.tex:22, 25 | `math.amsmath` | `amsmath`, `align*`, `\intertext` |
| figure float | example.zip:example/exercises/mechanics/center-of-mass.tex:8-12 | `fig.graphicx` | `figure[h]`, `\centering`, body `\input{rod}` (content) |
| caption and label | example.zip:example/exercises/mechanics/center-of-mass.tex:11, 4 | `cap.kernel`, `xref.kernel` | `\caption`, `\label{fig:mechanics-rod}`, `\ref` |
| filler text | example.zip:example/example.tex:3 | `draft.todo` | `lipsum`, load-only |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `marker` underlay drawing | exercisebank-doc.tex:41-45 | no | free TikZ paths in a tcolorbox hook; ART, see Blockers |
| thanks and tester macros (`\onethankyou`, `\thankyou`, `\tester`, aux round trip) | exercisebank-doc.tex:52-68, 137-142, 963-965 | yes | the aux file only carries two strings from the end of the document to the title area; inline them: one paragraph "An extra special thanks to \gh{tristelune1} ..." and `\footnotetext` with the tester; `\thankyou` is never called (:965 is commented), `\dlog` calls are debug warnings with no output |
| `\gh`, `\ghURL` | exercisebank-doc.tex:49-50 | yes | `\newcommand` aliases of `\href`: `meta.hyperref` |
| `\href` redefinition | exercisebank-doc.tex:118-119 | yes | wraps `\href` in `\color{magenta}`; with `colorlinks=true` (:121) set `urlcolor=magenta` through `\hypersetup` |
| `\l@version`, `\l@change`, `\newversion`, `\change`, `\chlogtable` | exercisebank-doc.tex:72-94, 959 | yes, approximately | custom toc file `chlog`; entries are a bold version line (`\leftskip` 1.5em, `\addvspace{1em plus 1pt}`) and a hanging "--" item in a 0.5\textwidth minipage; reduce to `toc.titletoc` `\titlecontents{version}` and `\titlecontents{change}` plus `box.minipage`, or print the lines in place; every `\change` call leaves the optional second field empty (:868-958), so the 0.3\textwidth minipage prints nothing |
| `\l@macro`, `\macrotable` and the `mac` entries | exercisebank-doc.tex:47-48, 809-861 | yes | one `\refCom` per line (`#1\hfill\newline`), printed where `\macrotable` stands: `toc.titletoc` or an in-place list |
| `\dac`, `\mdac`, `\macroname`, `\removebs` | exercisebank-doc.tex:104-110 | yes | strips the backslash (lowercase trick) and calls `\docAuxCommand`; write `\docAuxCommand{name}` directly |
| `\keyDef`, `\optDef` | exercisebank-doc.tex:114-115 | yes | `\long\def` aliases that wrap the `docKey` and `docKey*` environments |
| `\section`, `\subsection` wrappers | exercisebank-doc.tex:123-126 | yes | `pg.needspace` call before each heading, see map |
| `\tableofcontents` wrapper | exercisebank-doc.tex:97-98 | yes | `toc.kernel` inside a group with `\hypersetup{linkcolor=black}` |
| `\footxt` | exercisebank-doc.tex:70 | yes | `\protected@xdef\@thefnmark{}\@footnotetext{#1}`: a footnote text with no mark, `fn.kernel` with the footnote mark made empty locally |
| `\updated`, `\defnew` | exercisebank-doc.tex:100-102 | yes | aliases of `\tcbdocmarginnote{\bfseries{\color{...}U}#1}` |
| `\def\input@path{{../../docs/}}` | exercisebank-doc.tex:23 | yes | file search path outside the zip; the file uses no `\input`, so drop it |
| exercisebank.sty internals: `comment`-based cut-file environments, `\everypar` re-declaration, `\filbreak` redefinition, `\At`/`\Trigger` hooks, aux-written counters | exercisebank.sty:202-207, 283-290, 338-360, 471, 524-627, 976, 1003 | n/a, published | the package is on CTAN (W1), so the emitter loads it and does not copy its code; the `\At` hooks are extension points that example.tex does not use; `\generalcomment`, `\ProcessCutFile`, `\AfterproblemComment` come from `comment.sty`, which is not in the zip and was not read |
| `\dd`, `\der`, `\uu` | example.zip:example/mathcommands.tex:4-7 | yes | aliases: `\dd` = `\qopname\newmcodes@ o{d \!}` (amsmath operator machinery), reducible in intent to `\DeclareMathOperator{\dd}{d\!}`; `\der` = `\frac{\dd#1}{\dd#2}`; `\uu` = `\underline{\underline{#1}}`; not compared output by output |

## Content-opaque
- tikz picture in figure at example.zip:example/figures/mechanics/rod.tex:16-27 (with `\tikzset{fitted node/.style=...}` using `\pgf@pathminx` at :4-14 and `\setnewlength` at :15), `art.tikz`
- the sample code shown in `dispListing` blocks (exercisebank-doc.tex:153-165, 167-175, 193-199 and many more), the changelog text (:867-958) and the exercise texts are content

## Lib changes
- New ways proposed: none. Considered: tcolorbox `documentation` library (`docCommand` and friends; merged into `dtx.doc`, whose line already takes other package-documentation packages as the parameter), `comment` (an internal helper of exercisebank.sty, not a component).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
