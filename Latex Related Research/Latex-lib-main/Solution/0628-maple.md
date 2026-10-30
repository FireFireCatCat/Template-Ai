no

# 0628-maple: MTN, the Maple Technical Newsletter class (`mtn`)

- Unverified: read from the source, not compiled.
- Source: Source/0628-maple/ (origin: https://mirrors.ctan.org/macros/latex/contrib/maple.zip; licence: not established, the manifest says noinfo and ctan.org/pkg/maple gives only "1994 Waterloo Maple Software", as in mtn.cls:2)
- Kind: journal (an article for a technical newsletter; CTAN topic Journal)
- Lib: v5
- Engine: pdfLaTeX-compatible as far as read (the `dvips` option at MTNarticle.tex:1 and mtn.cls:47 names the latex+dvips route and is forwarded to `mapleenv`, which is not in the zip; the sample draws no graphics)
- Look carried by: class (page, running heads, headings and title block are all in `mtn.cls`; the preamble only adds `palatino`; the Maple I/O environments come from a style that is not in the zip)
- Class origin: ctan
- Main file: MTNarticle.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (`mtn.cls` is the only one present; `mapleenv.sty` is loaded at mtn.cls:51 but is not in the zip, so it was not read)

## Verdict
`no`. The look that `mtn.cls` defines is small and maps cleanly: it is `article` plus raw page lengths, a `fancyheadings` page style, four `\@startsection` redefinitions and a hand-set title block, and the class is a CTAN release, so `class.mtn` is one way. What blocks `yes` is the body vocabulary of the sample. All 100 `mapleinput`, `maplelatex` and `maplettyout` environments and all 40 `\mexpr` lines come from `mapleenv.sty`. mtn.cls:51 loads that file unconditionally, but the zip does not hold it, `ctan.org/pkg/mapleenv` is a 404, and the CTAN page for `maple` does not list its files, so it cannot be shown to be part of the published bundle. Their look and parameters cannot be read, so they cannot be shown reducible to lib ways, and a wrong `yes` costs more than a wrong `no`.

## Blockers
- `UNMAPPED/class` Maple worksheet environments `mapleinput`, `maplelatex`, `maplettyout` and inline `\mexpr{..}`, defined only in the absent `mapleenv.sty` (loaded at mtn.cls:51; used at MTNarticle.tex:68-75, 176-182, 255-258, and `\mexpr` on 40 lines from MTNarticle.tex:16 to :585). The README documents them as macros of that file (README:61-62, 72-99). Only a guess is possible: raw `^` and `#` in `mapleinput` text (MTNarticle.tex:69, 691) and inside a macro argument (`\mexpr{proc(x) sin(x)+cos(x)^2 end:}`, MTNarticle.tex:411) suggest verbatim-style catcode changes, so `code.verbatim` would be the candidate if the file were supplied and confirmed it. Nothing here proves it.

## Class setting
- Class: `class.mtn` options: `11pt` (also `10pt`, `12pt`, default `11pt`; mtn.cls:36-45), `dvips` (given at MTNarticle.tex:1, also executed by default at mtn.cls:47). Any other option is forwarded to the package `mapleenv` (mtn.cls:46). The class loads `class.article` with `[\PtSize,twoside]` (mtn.cls:50), so the page is always two-sided.
- Class-native vocabulary used: `\shorttitle{..}` (MTNarticle.tex:11), `\title` with `\\`, `\author` with `\thanks` and `\and` (MTNarticle.tex:5-10), `\maketitle` (MTNarticle.tex:12), and the loaded `mapleenv` vocabulary `mapleinput`, `maplelatex`, `maplettyout`, `\mexpr`. Defined by the class but unused in the sample: `\HEADING{title}{authors}{short}`, `\heading`, `\subheading` (mtn.cls:162-170); `\mapleplot{file.ps}` (README:99, mtn.cls:28). The README says abstracts are not used (README:18-19), and the sample has none.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | MTNarticle.tex:1; mtn.cls:34 | `class.mtn` | `[11pt,dvips]` |
| base class | mtn.cls:50 | `class.article` | `\LoadClass[\PtSize,twoside]{article}`, `\PtSize` default `11pt` (mtn.cls:36) |
| paper, size, sides | mtn.cls:36-50 | `page.class-options` | `11pt`, `twoside`; no paper option, so the article default paper |
| page geometry | mtn.cls:56-64 | `page.setlength` | `\marginparwidth`=30pt, `\marginparsep`=5pt, `\oddsidemargin`=0.5in, `\evensidemargin`=-0.5in, `\textheight`=21.5cm, `\textwidth`=6.25in, `\headheight`=`\baselineskip`, `\footskip`=1.36cm, `\topmargin`=-0.125in; `\headsep`=0pt is also set inside `\@maketitle` (mtn.cls:138), inside the title group |
| running heads and feet | mtn.cls:51, 69-76 | `hf.fancyhdr` | `fancyheadings` (a stub for `fancyhdr`, read at ctan.org/pkg/fancyheadings); `\pagestyle{fancyplain}`; `\headrulewidth`=`\footrulewidth`=0.6pt, `\plainheadrulewidth`=`\plainfootrulewidth`=0.6pt; `\lfoot[\rm\thepage]{}`, `\cfoot{}`, `\rfoot[]{\rm\thepage}` (page number at the outer foot corner) |
| head fields from `\shorttitle` | mtn.cls:155-156 | `hf.fancyhdr` | `\rhead[]{\fancyplain{}{\@shorttitle}}`, `\lhead[\fancyplain{}{\@shorttitle}]{}`: short title at the outer head corner, empty on a plain page |
| first-page style | mtn.cls:127, 140, 154 | `hf.pagestyle-kernel` | `\thispagestyle{plain}` on the title page |
| page flow | mtn.cls:172; MTNarticle.tex:275 | `pg.flush`, `pg.break` | `\raggedbottom`; `\newpage` in the body |
| text font | MTNarticle.tex:2 | `font.palatino` | `\usepackage{palatino}` (psnfss) |
| font sizes | mtn.cls:83, 87, 91, 95, 143, 147 | `font.size-commands` | title `\Huge`, authors `\Large`, section `\Large`, subsection `\large`, deeper levels `\normalsize` |
| font switches | mtn.cls:83, 87, 143, 147; MTNarticle.tex:52, 604, 741 | `mark.kernel` | `\reset@font`, `\rmfamily`, `\bfseries`, `\scshape`, `\mdseries`, `\itshape`; body `{\em ..}`, `\emph`, `\textit` |
| section, subsection | mtn.cls:80-87 | `head.kernel` | `\renewcommand\section{\@startsection{section}{1}{-0.09em}{-2ex plus -1ex minus -.2ex}{1ex plus .2ex}{..\Large\bfseries\rmfamily}}`; subsection level 2, indent `\z@`, before `-1ex plus -1ex minus -.2ex`, after `1ex plus .2ex`, `\large\bfseries\scshape` |
| subsubsection, paragraph | mtn.cls:88-95 | `head.kernel` | subsubsection level 3, before `-3.25ex plus -1ex minus -.2ex`, after `1.5ex plus .2ex`, `\normalsize\bfseries`; paragraph level 4, before `3.25ex plus1ex minus.2ex`, after `-1em` (run-in), `\normalsize\bfseries` |
| heading numbers | mtn.cls:79 | `num.secnumdepth` | `\setcounter{secnumdepth}{0}`: headings unnumbered |
| title, authors, short title | MTNarticle.tex:5-12; mtn.cls:97-99 | `front.maketitle`, `front.class-native` | `\title`, `\author`, `\maketitle`; class field `\shorttitle` |
| author notes | MTNarticle.tex:7-9; mtn.cls:100-104, 112-115, 129 | `front.thanks` | `\thanks` stores `\footnotetext` for after the title; marks `\fnsymbol{footnote}`; `\@makefnmark` and `\@makefntext` set in the title group (`\parindent` 1em, mark box 1.8em); `\setcounter{footnote}{0}` afterwards (`num.counters`) |
| title block body | mtn.cls:137-157 | `front.class-native` | `\null`, `\vbox{\vskip-2.5ex\noindent\Huge\rmfamily\mdseries\@title\par}`, `\vskip 0.5ex`, `\lineskip .5ex`, authors in `tabular[t]{c}` set `\Large\rmfamily\bfseries\itshape`, `\vskip 1.5ex`, `\hrule`, `\vskip 3ex` |
| author columns | mtn.cls:106-108, 148-150 | `tbl.tabular` | `\and` closes one `tabular` and opens `tabular[t]{c}` after `\hskip 1em plus .17fil`; the column spec is `{c}` |
| title rule and spacing | mtn.cls:143-157; MTNarticle.tex:5, 554 | `sp.rule`, `sp.manual-space` | `\hrule`; `\vskip` values above; `\\` in `\title`; `\vspace{1mm}` |
| footnote in text | MTNarticle.tex:576-578 | `fn.kernel` | one `\footnote` (arabic, after the title's symbol marks are reset) |
| display maths | MTNarticle.tex:72-74, 238-246, 265-272 | `math.kernel` | `\[ .. \]` and `eqnarray*` with `\lefteqn`, as content of `maplelatex`; `\rm`, `\displaystyle`, `\frac`, `\mbox{\hspace{200pt}}` are content-level |
| bibliography | MTNarticle.tex:724-744, 25, 32, 640 | `bib.thebibliography` | `thebibliography{10}`, three `\bibitem`, `\cite`; the heading goes through the redefined `\section*` (kernel article definition) |
| Maple input, output, tty output, inline expression | MTNarticle.tex:68-70, 71-75, 176-177, 255-258, 16 | none (UNMAPPED) | `mapleinput` 43 uses, `maplelatex` 40, `maplettyout` 17, `\mexpr` on 40 lines; defined in `mapleenv.sty`, not in the zip (see Blockers) |
| lists, theorems, floats, captions, tables in body, code, boxes, index, language, metadata | none in sample or class | none | not defined or used; no `\label` or `\ref` either |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option plumbing: `\PtSize`, `\DeclareOption{10pt,11pt,12pt}`, `\DeclareOption*`, `\ExecuteOptions{dvips}`, `\ProcessOptions` | mtn.cls:36-48 | yes | the effective call `\documentclass[11pt,twoside]{article}` (`class.article`, `page.class-options`); `dvips` is a package option for `mapleenv`, not read |
| `\renewcommand` of `\section`..`\paragraph` through `\@startsection` | mtn.cls:80-95 | yes | the same values as `head.kernel` or `head.titlesec` (`\titleformat`/`\titlespacing`), parameters in the map |
| `\title`, `\author`, `\shorttitle`, `\thanks`, `\and` | mtn.cls:97-108 | yes | the stock article definitions (kernel `\title`, `\author`, `\thanks`, `\and`) plus one string field; the short title becomes literal text in `\rhead`/`\lhead` (`hf.fancyhdr`) |
| `\maketitle` and `\@maketitle` | mtn.cls:110-157 | yes | a composition of `font.size-commands`, `mark.kernel`, `tbl.tabular`, `sp.manual-space`, `sp.rule`, `hf.pagestyle-kernel`, `front.thanks`; `front.titling` (`\pretitle`, `\preauthor`, `\postauthor`) is the printable form. Not proved: the `\headsep=0pt` and the `\rhead`/`\lhead` assignments run at title time; they reduce to preamble lines |
| aliases `\heading`, `\subheading`, `\HEADING` | mtn.cls:162-170 | yes | inline expansion; unused in the sample |
| `\typeout` banner | mtn.cls:4-30 | yes | log text only, no printed effect |
| `mapleenv.sty` environments and `\mexpr` | not in the zip; loaded at mtn.cls:51 | not shown | source not available, so no reduction can be written (blocker above) |

## Content-opaque
- Maple code in `mapleinput` and `maplettyout` (for example MTNarticle.tex:597-601, 662-669) and the display maths in `maplelatex` are content. Their wrappers are not, and sit under the blocker. No tikz or picture material, no figure, no table float.
- No text addressed to an AI was found in the README, the class or the sample.

## Lib changes
- New ways proposed: none (`class.mtn` is a class way and needs no proposal; the loaded `fancyheadings` is the stub of `fancyhdr`, so it is `hf.fancyhdr`). Considered: a way for `mapleenv`, not proposed, because its source cannot be read and so W2 to W4 cannot be argued.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
