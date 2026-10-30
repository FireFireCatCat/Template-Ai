no

# 0617-beamertools: beamertools (programming tools for beamer; package source and manual)

- Unverified: read from the source, not compiled.
- Source: Source/0617-beamertools/ (origin: https://mirrors.ctan.org/macros/latex/contrib/beamertools.zip; licence: LPPL 1.3c)
- Kind: misc (a macro-support package for beamer, not a template; the manifest hint `presentation` is wrong: the zip holds a package and its manual, no slide deck)
- Lib: v5
- Engine: pdfLaTeX-compatible (the shipped beamertools.pdf carries `/Producer (pdfTeX-1.40.26)` and `/Creator(LaTeX with hyperref)`, read from the file bytes; the package code at beamertools.dtx:235-266 uses no engine-specific command; `bidicode`, loaded by the manual driver, was not read)
- Look carried by: mixed (the only look in the zip is the manual's: class `ltxdoc` plus the driver preamble at beamertools.dtx:84-105 plus macros of `bidicode`, which is not in the zip; the package `beamertools.sty` itself prints nothing)
- Class origin: tex-distribution-unbundled (`ltxdoc`, LaTeX base; not in the zip, source not read)
- Main file: none as a `.tex`. The only `\documentclass` and `\begin{document}` sit in the docstrip `driver` block of beamertools.dtx:83-106 (other samples: none; beamertools.ins:22-41 is a docstrip batch file that generates `beamertools.sty`)
- Read: main yes (no `.tex`; beamertools.dtx lines 1-282, beamertools.ins and README read in full), zip-local classes and styles none present (`beamertools.sty` exists only as docstrip output of the `.dtx`; its code at beamertools.dtx:235-266 was read)

## Verdict
The look in this zip is a package manual typeset with `ltxdoc` (title block, a red boxed notice, two listings, a macrocode section); most of that reduces to lib ways (`class.ltxdoc`, `dtx.doc`, `sp.microtype`, `meta.hyperref`, `color.xcolor`, `box.fancybox`, `box.minipage`, `code.listings`). The verdict is `no` because the driver loads `bidicode` (beamertools.dtx:85) and the body uses its macros `\Lcs`, `\Largb` and `BDef` (beamertools.dtx:96, 181, 199-201): the package is not in the zip, I could not establish that it is published (ctan.org/pkg/bidicode is a 404 and ctan.org/pkg/bidi does not name it), and its source was not read, so W1 and the reduction of those macros cannot be shown. The package's own code (`\redefbeamertemplate`, beamertools.dtx:237-266) is published on CTAN (read at ctan.org/pkg/beamertools: LPPL 1.3c, in TeX Live and MiKTeX), prints nothing by itself, and no sample loads or calls it, so it is not a blocker and no way is proposed for it. If `bidicode.sty` is confirmed as a published TeX Live or CTAN package whose macros are documentation markup, the consolidator may fold it into `dtx.doc` as a package parameter and this file would flip to `yes`.

## Blockers
- `UNMAPPED/preamble` `bidicode` (loaded at beamertools.dtx:85; macros `\Lcs` at beamertools.dtx:96,181 and `\Largb`, `BDef` at beamertools.dtx:199-201): not shipped in the zip, W1 not established, source not read; the manual's `lstlisting` use (beamertools.dtx:158,163) and `\definecolor` (beamertools.dtx:87, where no package other than `bidicode` could have loaded a colour package before it) imply that it also loads `listings` and a colour package, which cannot be confirmed.

## Class setting
- Class: `class.ltxdoc` options: none (beamertools.dtx:84)
- Class-native vocabulary used: `\GetFileInfo` (beamertools.dtx:111), `\DocInput` (102), `\EnableCrossrefs` (98), `\CodelineIndex` (99), `\PrintIndex` (103), `\StopEventually` (205), `\CheckSum` (210), `\CharacterTable` (211-225), `macrocode` environment (234, 267), `\Finale` (273); present but commented out: `\RecordChanges` (100), `\PrintChanges` (104)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | beamertools.dtx:84 | `class.ltxdoc` | no options; article-based manual class loading `doc` |
| .dtx documentation driver | beamertools.dtx:83-106, 102 | `dtx.doc` | `\DocInput{\jobname.dtx}`; docstrip guards `%<*driver>` (83) and `%<*beamertools.sty>` (229, closed at 269) |
| doc hypertext features | beamertools.dtx:88 | `dtx.doc` | `hypdoc` with option `numbered` (the package is the parameter) |
| doc cross-references and index | beamertools.dtx:98-99, 103 | `dtx.doc` | `\EnableCrossrefs`, `\CodelineIndex`, `\PrintIndex`; index built by makeindex with `gind.ist` (beamertools.dtx:79) |
| doc markup package | beamertools.dtx:85 | `dtx.doc` (parameter `bidicode`, W1 not established, source not read) | no options; supplies `\Lcs`, `\Largb`, `BDef` (blocker) |
| code section | beamertools.dtx:205-210, 234-273 | `dtx.doc` | `\StopEventually{}`, `\CheckSum{0}`, `\CharacterTable`, `macrocode`, `\Finale`; the code text is content |
| micro-typography | beamertools.dtx:86 | `sp.microtype` | `\usepackage{microtype}`, no options |
| colour definitions | beamertools.dtx:87, 120, 163 | `color.xcolor` | `\definecolor{niceblue}{rgb}{0.2,0.4,0.8}`; `\color{red!85!black}`; `blue!30` (the `!` mixing is xcolor syntax) |
| PDF metadata and link colours | beamertools.dtx:89-94 | `meta.hyperref` | `\hypersetup{pdfauthor={Vafa Khalighi}, linkcolor=niceblue, urlcolor=niceblue, citecolor=niceblue}` |
| PDF bookmark string alias | beamertools.dtx:95-97 | `meta.hyperref` | `\pdfstringdefDisableCommands{\renewcommand\Lcs[1]{\textbackslash#1}}` (renews the `\Lcs` of `bidicode`) |
| title block | beamertools.dtx:111-115 | `front.maketitle` | `\title{The \textsf{beamertools} Package}`, `\author{Vafa Khalighi}`, `\date{Version 0.1\quad\today}`, `\maketitle`; `\GetFileInfo` is `dtx.doc` |
| boxed notice on the title page | beamertools.dtx:117-143 | `box.fancybox` | `{\color{red!85!black}\fbox{...}}` |
| width of the notice | beamertools.dtx:120, 142 | `box.minipage` | `\begin{minipage}{\dimexpr\textwidth-2\fboxsep-2\fboxrule}` |
| vertical glue and skips | beamertools.dtx:119, 124, 127, 131, 135, 138, 145, 149 | `sp.manual-space` | `\vskip 0pt plus 3fill` twice, `\medskip`, `\bigskip` |
| paragraph indent | beamertools.dtx:118 | `sp.lengths` | `\parindent 0pt` inside `\begingroup ... \endgroup` (117, 151) |
| centred URL lines | beamertools.dtx:125, 136 | `sp.ragged` | `\centerline{\url{...}}` (centring one line, the type of `\centering`) |
| links and URLs | beamertools.dtx:125, 136, 186 | `meta.url` | `\url{https://github.com/xepersian/beamertools/issues}` and two more |
| page break | beamertools.dtx:153 | `pg.break` | `\clearpage` |
| contents | beamertools.dtx:154 | `toc.kernel` | `\tableofcontents` |
| headings | beamertools.dtx:155, 196-197, 202, 206 | `head.kernel` | `\section`, `\subsection`, class defaults, no redefinition |
| footnote | beamertools.dtx:186 | `fn.kernel` | `\footnote{\url{https://ctan.org/pkg/bidi}}` |
| inline marks | beamertools.dtx:150, 186 | `mark.kernel` | `\emph{...}`, `\textsf{bidi}` |
| code listings | beamertools.dtx:158, 163 | `code.listings` | `lstlisting[gobble=1,numbers=none]`; `lstlisting[gobble=1,numbers=none,backgroundcolor=\color{blue!30},frame=none,framexleftmargin=1mm]`; package loaded by `bidicode` (inferred, not read); listing text is content |
| doc-markup macros in body | beamertools.dtx:181, 199-201 | `dtx.doc` (parameter `bidicode`) | `\Lcs{defbeamertemplate}`, `\begin{BDef}\Lcs{usepackage}\Largb{beamertools}\end{BDef}` (blocker) |

No header/footer, geometry, font, language, list, table, float, theorem, bibliography or cross-reference commands are set or used by the driver or the manual body (checked by reading beamertools.dtx:83-282 in full); defaults of `ltxdoc` apply and its source was not read.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\redefbeamertemplate` and helpers `\beamer@redefbeamertemplate`, `\beamer@redef@sbtoo`, `\beamer@redef@sbto`, `\beamer@@redef@sbto`, `\beamer@@@redef@sbto`, `\beamer@@@@redef@sbto` | beamertools.dtx:237-266 | not applicable: published (CTAN package beamertools, read at ctan.org/pkg/beamertools), not zip-local | An emitter would load the package, not copy its logic. The code is `\@ifnextchar` option parsing, a token register `\beamer@sbttoks`, constructed names `\csname beamer@@tmpop@#1@#2\endcsname` and `\csname beamer@@tmpl@#1\endcsname` that reach into beamer internals, and `\PackageError` when the template is undefined. It prints nothing and no sample loads or calls it. Considered as a way: `beamertools`, not proposed (see Lib changes). If a sample called it, `\redefbeamertemplate{e}{o}{code}` followed by `\setbeamertemplate{e}[o]` would reduce by inline expansion to `\setbeamertemplate{e}{code}`, which is `slide.beamer-template` |
| docstrip driver code (live TeX lines of the `.dtx`) | beamertools.dtx:48-77 | yes | kernel `docstrip` (`\input docstrip.tex`, `\generate`, `\preamble`), no look; part of the `dtx.doc` way |
| shell-escape lines | beamertools.dtx:78-80 | yes, no look | `\immediate\write18{mv README.txt README}` and two `makeindex` calls sit in the `%<*internal>` maintainer block (73-81); `mv` only renames a side file, `makeindex` builds the index as for `idx.makeidx`; the driver output does not depend on `mv`; not counted as EXTERNAL |
| `\pdfstringdefDisableCommands{\renewcommand\Lcs[1]{\textbackslash#1}}` | beamertools.dtx:95-97 | yes as an alias | `meta.hyperref` bookmark-string alias of `\textbackslash` plus the argument; its target `\Lcs` comes from `bidicode` (blocker) |
| `\typeout` banner | beamertools.dtx:276-280 | yes, no look | log message after `\Finale`, prints nothing in the document |

## Content-opaque
none (the error-message transcript in the second listing at beamertools.dtx:164-174 and the code in `macrocode` at beamertools.dtx:235-266 are code text, content)

## Lib changes
- New ways proposed: none. Considered: `beamertools` (`\redefbeamertemplate`; not proposed because no sample loads or calls it, as the lib's rejection of `xref.upref` reasons; its arguments are the same code slots as beamer's `\defbeamertemplate`); `bidicode` as a `dtx.doc` parameter (W1 not established: ctan.org/pkg/bidicode 404, ctan.org/pkg/bidi does not name it).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
