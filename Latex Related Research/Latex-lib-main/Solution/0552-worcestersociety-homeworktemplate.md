no

# 0552-worcestersociety-homeworktemplate: awe-homework (WorcesterSociety/HomeworkTemplate)

- Unverified: read from the source, not compiled.
- Source: Source/0552-worcestersociety-homeworktemplate/ (origin: https://codeload.github.com/WorcesterSociety/HomeworkTemplate/zip/refs/heads/master; licence: CC0-1.0, LICENSE:1)
- Kind: assignment
- Lib: v4
- Engine: pdfLaTeX-compatible (nothing in the class needs XeTeX or fontspec; the Makefile builds with `xelatex -shell-escape`, Makefile:2, and `minted` needs the shell escape, see Blockers)
- Look carried by: zip-local (awe-homework.cls: `article` plus 15 published packages, a fancyhdr header, a hand-laid title block and a `\question` rule wrapper; example.tex adds only content and three string settings)
- Class origin: zip-local
- Main file: example.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
The look is a thin zip-local class over `article`, and every macro in it reduces to published ways (see Bespoke code). It is still `no`: the class loads `minted` unconditionally (awe-homework.cls:48), so the document does not compile without shell escape and Pygments, and the sample uses `minted` as well (example.tex:16). That is `EXTERNAL/package` under the pilot ruling. Nothing else blocks: the one component with no lib way, `mathpartir`, is proposed below as a published, declarative way.

## Blockers
- `EXTERNAL/package` `minted` loaded unconditionally and needing shell escape and Pygments (awe-homework.cls:48; used at example.tex:16-25; `-shell-escape` at Makefile:2; Pygments requirement at README.md:14-15)

## Class setting
- Class: `class.article` options: `11pt` at example.tex:1; the zip-local `awe-homework` forwards every option to `article` (awe-homework.cls:13-16) and then `\LoadClass{article}` (awe-homework.cls:17). `awe-homework` is not on CTAN (ctan.org/pkg/awe-homework returned 404), so it is zip-local, not a way; it reduces to `class.article` plus the rows below.
- Class-native vocabulary used: none from `article` beyond `\documentclass`; the zip-local commands `\doctitle` `\name` `\email` `\makeheader` `\question` (reduced under Bespoke code).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | awe-homework.cls:13-17; example.tex:1 | `class.article` | option 11pt; options passed through `\PassOptionsToClass{\CurrentOption}{article}` |
| paper and size option | example.tex:1 | `page.class-options` | 11pt |
| page geometry | awe-homework.cls:36,80 | `page.geometry` | margin=1in |
| header and footer | awe-homework.cls:34,83-86 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\lhead` = document title string; `\rhead` = name string; `\cfoot{\thepage}`; no `\fancyhf` reset, no rule length set |
| first-page style | awe-homework.cls:123 | `hf.pagestyle-kernel` | `\thispagestyle{plain}` inside `\makeheader` |
| title block (`\makeheader`) | awe-homework.cls:122-129; example.tex:10 | `sp.ragged` | `center` environment (kernel `\centering` family) |
| title block size | awe-homework.cls:125 | `font.size-commands` | `{\Large <title>}` |
| title block line breaks | awe-homework.cls:125-127 | `sp.manual-space` | `\\` after title, name and email (also one trailing `\\` before `\end{center}`) |
| title block strings | awe-homework.cls:66-73; example.tex:4-6 | content | three `\def` slots (title, name, email) hold text only; inlined by the emitter |
| question wrapper (`\question{n}{text}`) | awe-homework.cls:131-135; example.tex:12,27,39 | `sp.manual-space`, `sp.rule`, `mark.kernel`, `sp.lengths` | `\vspace{.25in}` `\hrule` `\vspace{0.5em}` `\noindent` `{\bf n.}` text `\vspace{0.5em}` `\hrule` `\vspace{.25in}` (`\hrule` is the kernel rule primitive; `\bf` a kernel font switch; `\noindent` is the one-paragraph override of `\parindent`) |
| colours | awe-homework.cls:28,58-59 | `color.xcolor` | `\definecolor{belize-hole}{RGB}{41,128,185}`, `\definecolor{code}{RGB}{241,240,236}`; legacy `color` is also loaded (`color.color`, awe-homework.cls:28) |
| links and metadata | awe-homework.cls:38,89-95 | `meta.hyperref` | `colorlinks=true`, `linkcolor=black`, `citecolor=black`, `filecolor=black`, `urlcolor=belize-hole` |
| inline hyperlink | example.tex:28 | `xref.hyperref` | `\href{url}{text}` (a hyperref link command, same package family as `\autoref`/`\hyperref`; no `\url` used) |
| footnote number format | awe-homework.cls:98 | `num.counters` | `\renewcommand{\thefootnote}{[\arabic{footnote}]}`; the sample has no footnote |
| description list font | awe-homework.cls:32,101 | `list.enumitem` | `\setlist[description]{font=\normalfont}` |
| ordered list | example.tex:41-45,48-52 | `list.kernel` | `enumerate` |
| list in columns | awe-homework.cls:112-120; example.tex:41 | `list.enumitem`, `cols.multicol` | `\SetEnumitemKey{twocol}{before=\raggedcolumns\begin{multicols}{2},after=\end{multicols}}` and `threecol` (3 columns); sample uses `[threecol]`; the `multicol` package is loaded at awe-homework.cls:50 |
| enumerate package | awe-homework.cls:30 | `list.enumerate-pkg` | load-only; sample passes no label template |
| code highlighting | awe-homework.cls:48,104-105; example.tex:16-25 | `code.minted` | `\setminted{autogobble, bgcolor=code}`, `\setmintedinline{bgcolor=white}`, `minted` env with language `scala`; **EXTERNAL** |
| hyphenation package | awe-homework.cls:40 | `sp.hyphenat` | load-only, no options |
| microtype | awe-homework.cls:46 | `sp.microtype` | load-only, no options |
| maths packages | awe-homework.cls:24,26,42 | `math.amsmath`, `math.amssymb` | `amsmath`; `amssymb`; `mathabx` (package is the parameter of `math.amssymb`, as in Solution/0176-presentations.md:72); sample has no formula |
| inference rules package | awe-homework.cls:44 | `math.inference` | `\usepackage{mathpartir}` with no options; sample uses no `\inferrule` |
| TikZ | awe-homework.cls:52 | `art.tikz` | load-only; the comment says it is for state-machine pictures (awe-homework.cls:51); no picture in the sample and none in the class |
| page break | example.tex:37 | `pg.break` | `\pagebreak` |
| sectioning, abstract, contents, floats, tables, theorems, bibliography, index | none | none | not defined by the class and not used by the sample (article defaults only) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `awe-homework.cls` (class) | awe-homework.cls:5-135 | yes | `class.article` (11pt) + `\RequirePackage` list (awe-homework.cls:24-52) + the settings in the rows above; no output routine, no kernel redefinition |
| `\name` `\doctitle` `\email` setters, `\getname` etc. getters | awe-homework.cls:66-73 | yes | string slots; the emitter writes the title and name text straight into `\lhead`, `\rhead` and the title block |
| `\makeheader` | awe-homework.cls:122-129 | yes | `\thispagestyle{plain}` + `center` env with `{\Large title} \\ name \\ email \\` (`hf.pagestyle-kernel`, `sp.ragged`, `font.size-commands`, `sp.manual-space`) |
| `\question` | awe-homework.cls:131-135 | yes | inline expansion around the question text (see row above); no counter is stepped, the number is an argument |
| `\SetEnumitemKey{twocol}`, `{threecol}` | awe-homework.cls:112-120 | yes | enumitem's documented key declaration (`list.enumitem`) whose `before`/`after` open and close a `multicols` environment (`cols.multicol`); or the emitter wraps the list in `multicols` directly |
| `\hypersetup`, `\setlist`, `\setminted`, `\geometry`, `\definecolor`, `\renewcommand\thefootnote` | awe-homework.cls:58-59,80,89-105 | yes | declarative calls into the ways above |

## Content-opaque
none (the Scala text in the `minted` block, example.tex:17-24, is code content; the way `code.minted` is the blocker, not the text)

## Lib changes
- New ways proposed: `math.inference` `mathpartir` (CTAN, version 1.3.2 per ctan.org/pkg/mathpartir; pdfLaTeX): `\usepackage{mathpartir}` and, in the body, the `\inferrule[label]{premises}{conclusion}` macro and `mathpar` environment for inference rules and sets of rules. W1: published on CTAN. W2: behaviour is set by arguments (premises, conclusion, label) and load options; the package source was not read here. W3: serves any document that typesets inference rules, not this class. W4: one preamble line plus a body wrapper around the premises and conclusion. A home in `math.physics` was considered and rejected: that line lists physics, bra-ket, cancel and equation-layout packages, none of which typesets rules. The sample does not call it (it is only loaded, awe-homework.cls:44), so the verdict does not rest on it.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Considered and not used: `front.maketitle` (the title block does not call `\maketitle`), `front.titlepage-env` (no `titlepage` environment), `meta.url` (no `\url`), `math.bm` for `mathabx` (the 0176 analysis files it under `math.amssymb`).
- Header rule and footer: only `\lhead`, `\rhead` and `\cfoot` are set (awe-homework.cls:84-86); the rest of the `fancyhdr` defaults are not in the source and are not asserted here.
- No text addressed to an AI was found in the zip.
