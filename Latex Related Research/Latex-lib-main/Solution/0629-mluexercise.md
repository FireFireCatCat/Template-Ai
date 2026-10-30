yes

# 0629-mluexercise: mluexercise (exercise-sheet class, Martin Luther University Halle-Wittenberg)

- Unverified: read from the source, not compiled.
- Source: Source/0629-mluexercise/ (origin: https://mirrors.ctan.org/macros/latex/contrib/mluexercise.zip; licence: MIT, README.md:12 and mluexercise.dtx:7-27)
- Kind: assignment
- Lib: v5
- Engine: pdfLaTeX-compatible (mluexercise.dtx:2 `%!TEX program = pdfLaTeX`; no fontspec, no shell escape)
- Look carried by: class (the whole look is in the `class` module of mluexercise.dtx:109-805, which loads `scrartcl`; the zip adds no sample, no style file and no preamble)
- Class origin: ctan (ctan.org/pkg/mluexercise read: v2.0 of 2020-11-12, MIT, path macros/latex/contrib/mluexercise)
- Main file: none. The zip has no `.tex` sample. The only use of the class is the one-line listing `\documentclass{mluexercise}` at mluexercise.dtx:146 (other samples: none). The documentation driver is at mluexercise.dtx:70-108 (class `ltxdoc`).
- Read: main none present (no `.tex` sample); zip-local classes and styles all (`mluexercise.cls` is not shipped, it is generated from the `class` module by mluexercise.ins:27-29, so the whole mluexercise.dtx lines 1-813, mluexercise.ins and README.md were read; mluexercise.pdf is the compiled manual and was not read, no PDF renderer here)

## Verdict
The look is one published CTAN class, `mluexercise`, a thin layer over KOMA `scrartcl`. The class is on CTAN under MIT, so it is a way of its own (`class.mluexercise`, W1 to W4 hold: options `english` `ngerman` `dataminingstyle`, metadata macros, one kind of document). Read as source it also decomposes into lib ways (geometry, fonts, KOMA fonts, `scrlayer-scrpage`, listings, algorithm2e, ...), with one new way for the maths font package `eulervm`. There is no artwork and no tool outside TeX, so the answer is `yes`, resting on the class being published (see "Bespoke code" for the two class-internal items that would block under a zip-local reading).

## Blockers
none

## Class setting
- Class: `class.mluexercise` (base `class.scrartcl` via `\LoadClass{scrartcl}`, mluexercise.dtx:296); options: `english`, `ngerman`, `dataminingstyle` (mluexercise.dtx:157-168, 285-289); every other option is passed to `scrartcl` (mluexercise.dtx:294-295). With no language option English is used (mluexercise.dtx:163).
- Class-native vocabulary documented (no sample uses it): preamble `\lecture{}` (alias `\title`), `\semester{}` (default computed from the date), `\exercise{}`, `\task{}`, `\group{}`, `\date{}`, `\studentname{}` (alias `\author`), `\studentnumber{}`, `\studentsymbol{}` (mluexercise.dtx:174-214, 334-365); body `\maketitle` (455-464); sections print as "Task n", "a)", "(i)" (436-441); text macros `\strong \italic \code \Underline \plural \pl \query \domain \email \textttsmall` (404-411, 421-424); maths macros and operators (496-579); column types `L R C` (587-589); environments `calculus` `eqcalc` `seqcalc` (598-643); algorithm2e keyword set (650-660); listings languages `zhaskell` `massembler` (711-736).

## Component map
Rows 1 to 32 are the class (the `class` module, mluexercise.dtx:109-805). Rows 33 to 40 are the documentation driver and manual (mluexercise.dtx:70-108 and the `%` text), a second document under class `ltxdoc`.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| 1 class | mluexercise.dtx:279, 294-296 | `class.mluexercise` | options `english` `ngerman` `dataminingstyle`; rest to `scrartcl` |
| 2 base class | mluexercise.dtx:296 | `class.scrartcl` | no options of its own; KOMA vocabulary used by the class: `\setkomafont` `\addtokomafont` `\usefontofkomafont` `\autodot` `\ihead` `\chead` `\ohead` `\ofoot` |
| 3 encodings | mluexercise.dtx:302-303 | `font.fontenc-t1` | `inputenc` utf8, `fontenc` T1 |
| 4 page geometry | mluexercise.dtx:374-383 | `page.geometry` | a4paper, inner=2cm, outer=2cm, top=3cm, bottom=3cm, head=0.75cm, headsep=0.25cm, foot=0.75cm |
| 5 line spacing | mluexercise.dtx:384 | `sp.linespread` | `\baselinestretch` 1.15 |
| 6 paragraph shape | mluexercise.dtx:385-386 | `sp.lengths` | `\parindent` 0em, `\parskip` 1ex |
| 7 text face | mluexercise.dtx:394 | `font.libertine` | `libertine`, no options |
| 8 maths face | mluexercise.dtx:395 | `font.math-face` | `eulervm`, loaded after the text face, no options |
| 9 mono face | mluexercise.dtx:396 | `font.mono` | `sourcecodepro` with option `ttdefault` |
| 10 microtype, ligatures | mluexercise.dtx:397-398 | `sp.microtype` | `microtype`; `\DisableLigatures{family=tt*}` |
| 11 colours | mluexercise.dtx:307, 676-679 | `color.xcolor` | `\definecolor` lsnumber 0,0,0; lscomment 0.25,0.5,0.35; lskeyword 0.5,0,0.35; lsstring 0.6,0,0 |
| 12 language | mluexercise.dtx:314 | `lang.babel` | `babel` without option; language comes from the class option (english or ngerman) |
| 13 quotation marks | mluexercise.dtx:412 | `lang.csquotes` | autostyle=true, german=quotes |
| 14 PDF metadata | mluexercise.dtx:306, 793-796 | `meta.hyperref` | `hyperref` loaded; `\hypersetup` pdfauthor = student name, pdftitle = exercise string and lecture |
| 15 link and URL font | mluexercise.dtx:418-424 | `meta.url` | `\UrlFont` set to `\ttsmallfont`; `\domain` and `\email` wrap `\href` (`meta.hyperref`) |
| 16 relative size | mluexercise.dtx:418-419 | `font.size-commands` | `relsize` `\smaller` inside `\ttsmallfont` = `\ttfamily\smaller` (same type as `\small`; the package is the parameter) |
| 17 text-style macros | mluexercise.dtx:404-411 | `mark.kernel` | `\strong`=`\textbf`, `\italic`=`\textit`, `\code`=`\texttt`, `\plural`=`\textsuperscript{\underline{}}`; `\Underline`=`\underline{\underline{}}` (kernel `\underline`, filed under `mark.ulem`) |
| 18 heading fonts | mluexercise.dtx:430-435 | `head.koma-fonts` | sectioning `\sffamily\mdseries`; section `\LARGE`; subsection `\Large`; subsubsection and paragraph `\large`; subparagraph `\normalsize` |
| 19 heading numbers | mluexercise.dtx:436-442, 772 | `num.counters` | `\thesection` = bold upright "Task n" ("Aufgabe n" in German); `\thesubsection` = "a)"; `\thesubsubsection` = "(i)"; `\autodot` empty (`head.class-native`); section counter starts at `\task` minus 1 |
| 20 title block | mluexercise.dtx:451-464 | `front.class-native` | `\maketitle` centred: lecture name (title font), then date, semester and optional group in roman numerals; title font `\sffamily\bfseries\huge\centering`, date font `\sffamily\large\centering` (`head.koma-fonts`) |
| 21 student fields | mluexercise.dtx:334-365, 780-787 | `front.class-native` | name, number and symbol printed in the running head, not in the title block |
| 22 header and footer | mluexercise.dtx:470, 472-476, 780-787 | `hf.scrlayer-scrpage` | options headsepline, footsepline; `\pagestyle{scrheadings}`; `\clearscrheadfoot`; fonts pageheadfoot and pagenumber `\sffamily`; ihead = name, chead = bold exercise string, ohead = number / symbol, ofoot = "page von total" |
| 23 page x of y | mluexercise.dtx:471, 476 | `pgnum.lastpage` | `totpages`, `\ref{TotPages}` |
| 24 maths | mluexercise.dtx:485-490, 496-579 | `math.amsmath` | `amsmath`, `amstext`; `\DeclareMathOperator` for im id sel dom ran Hom End indeg outdeg var Var cov Cov Bin Exp Dir Mult; symbol aliases by `\newcommand`; swaps of `\mod` `\emptyset` `\epsilon` `\phi` by `\let` (536-539) |
| 25 maths symbols and cancel | mluexercise.dtx:487, 490 | `math.amssymb` | `amssymb`; `cancel` is filed under `math.physics` |
| 26 proof end | mluexercise.dtx:486, 525 | `thm.amsthm` | `amsthm` loaded, no `\newtheorem` anywhere; `\qed` redefined to `\nopagebreak\hfill\ensuremath{\square}` |
| 27 tables | mluexercise.dtx:489, 587-589, 744 | `tbl.tabular` | `array` with `\newcolumntype` L, R, C (maths-mode columns); `booktabs` is `tbl.booktabs` |
| 28 pseudocode | mluexercise.dtx:650-660 | `alg.algorithm2e` | options vlined, linesnumbered; `\DontPrintSemicolon`; `\SetKwProg` `\SetKwComment` `\SetCommentSty{itshape}` `\SetKw` `\SetKwBlock`; `\SetNlSty{tiny}{}{}`; `\SetNlSkip{0.5em}`; `\SetAlgoNlRelativeSize{0}`; `\SetAlFnt{\footnotesize}` |
| 29 listings | mluexercise.dtx:669-703, 711-736 | `code.listings` | `listings` and `listingsutf8` (UTF-8 `\lstinputlisting`, same family); `\lstset` language=C, basicstyle=\ttfamily, breaklines, prebreak, numbers=left, numbersep=0.5em, colours, tabsize=2; `\lstdefinelanguage` zimmermann-haskell and Molitor-Assembler, `\lstalias`, `\lstdefinestyle` |
| 30 floats and figures | mluexercise.dtx:745-747, 750 | `fig.graphicx` | `graphicx`; `float` is `fig.float`; `subcaption` is `fig.subcaption`; `rotating` is `fig.rotating` |
| 31 drawing packages | mluexercise.dtx:748-758 | `art.tikz` | loaded toolbox only: `tikz`, `pgfplots` (compat=1.16), libraries positioning, automata, trees, `\tikzset{>=latex, font=\sffamily}`; no picture is drawn by the template, so content when used, not ART |
| 32 hook before document | mluexercise.dtx:766-802 | `class.mluexercise` | `\AtEndPreamble` block that sets section counter, head fields and hyperref data (class code, not a way of its own) |
| 33 driver class | mluexercise.dtx:71 | `class.ltxdoc` | a4paper, english |
| 34 driver fonts and encodings | mluexercise.dtx:72-77 | `font.libertine` | `inputenc` utf8 and `fontenc` T1 (`font.fontenc-t1`), `babel` (`lang.babel`), `libertine`, `eulervm` (`font.math-face`), `sourcecodepro[ttdefault]` (`font.mono`) |
| 35 driver links and sizes | mluexercise.dtx:78-83 | `meta.hyperref` | `colorlinks=false`; `relsize` (`font.size-commands`); `\ttsmallfont`; `\UrlFont` (`meta.url`); `\texttt` redefined; `\MacroFont` = `\ttfamily\footnotesize` |
| 36 driver listings | mluexercise.dtx:84, 88-100 | `code.listings` | language=TeX, basicstyle=\ttfamily\footnotesize, breaklines, prebreak, numbers=left, numberstyle=\scriptsize, numbersep=1pt, keepspaces, tabsize=4, xleftmargin=1em |
| 37 driver quotes, tables, headings | mluexercise.dtx:85-87 | `lang.csquotes` | `csquotes`; `booktabs` (`tbl.booktabs`); `titlesec` with options sf, bf (`head.titlesec`) |
| 38 doc machinery | mluexercise.dtx:101-106, 134-135, 139, 808-812 | `dtx.doc` | `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges` `\DocInput`, `\changes`, `\DescribeMacro`, `macrocode`, `\StopEventually`, `\PrintChanges`, `\Finale`; docstrip modules (45-69, 143-150) |
| 39 manual front matter and sections | mluexercise.dtx:115-128, 137, 261, 271 | `front.maketitle` | `\title{\sffamily\bfseries ...}` `\author` `\date` `\maketitle` (125), `\tableofcontents` (`toc.kernel`, 126), `\section` `\subsection` `\paragraph` (`head.kernel`), footnotes (`fn.kernel`, 115, 119) |
| 40 manual lists, table, listing | mluexercise.dtx:220-224, 231-259, 145-147 | `list.kernel` | `itemize`; one `table` with `\caption` (`cap.kernel`) and `\label` (`xref.kernel`), `tabular{lll}` with `booktabs` rules; `lstlisting[gobble=4]` (`code.listings`) |

## Bespoke code
Outside the published class (the zip's own, in the documentation driver preamble):

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\ttsmallfont` | mluexercise.dtx:80 | yes | `\ttfamily\smaller` = `font.mono` + `font.size-commands` |
| `\renewcommand{\texttt}` | mluexercise.dtx:82 | yes | alias of kernel `\texttt` with a size switch (`mark.kernel`) |
| `\renewcommand{\UrlFont}` | mluexercise.dtx:81 | yes | `meta.url` font hook set to `\ttsmallfont` |
| `\renewcommand{\MacroFont}` | mluexercise.dtx:83 | yes | font hook of `ltxdoc`/`doc` set to `\ttfamily\footnotesize` (`dtx.doc`) |

Inside the published class (not bespoke by W1, because `mluexercise` is on CTAN; recorded with scope `class` so a reader can re-apply the zip-local definition):
- `\maketitle` redefined with a measured-width test (`\settowidth` then `\lengthtest{...>\textwidth}` then `\addtokomafont{title}{\LARGE}`), mluexercise.dtx:454-464: irreducible, layout computed from font metrics; would be BESPOKE/class.
- `calculus`, `eqcalc`, `seqcalc` (pgfkeys keys, a hand-rolled counter, a `tabular` whose `@{}` prefix steps the counter, `\let` of a computed control sequence), mluexercise.dtx:598-643: irreducible; no sample uses them; would be BESPOKE/class.
- `\semester` default computed from `\month` and `\year`, mluexercise.dtx:340-348: reducible, the emitter writes `\semester{WS 2025/2026}`.
- `\IfGerman` and language-dependent `\thesection`, `\@exercisestring`, mluexercise.dtx:316-317, 436-437, 773-774: reducible by inline expansion once the language is known (`iflang` considered, not a way).
- `\@checkoption` error checks (325-333), `\AtEndPreamble` hook (766-802), `\ifdataminingstyle` (285-289, 568-569): diagnostics, a hook and a class option; reducible (a class parameter).
- Alias macros (404-411, 421-424, 496-579), `\let` swaps (536-539), `\Rom` (448): `\newcommand`/`\let` compositions of kernel and `amsmath` commands; reducible.
- Quirk: the class file calls `\ProvidesPackage` instead of `\ProvidesClass` (mluexercise.dtx:279); no layout effect.
- Helper packages with no printed effect, used only inside the class's macro bodies: `ifthen`, `etoolbox`, `iflang`, `calc`, `pgfkeys` (mluexercise.dtx:304-305, 315, 373, 599); not components, no way.

## Content-opaque
none (the class draws nothing; `tikz` and `pgfplots` are only loaded, mluexercise.dtx:748-758)

## Lib changes
- New ways proposed: `font.math-face` `eulervm` (CTAN, LPPL 1.1, v4.0; ctan.org/pkg/eulervm read): `\usepackage{eulervm}` after the text-face package; virtual Euler + Computer Modern maths fonts for a text font that has no maths set; one option on the CTAN page (the 95 % scale; not otherwise read); engine pdf (the source states pdfLaTeX at mluexercise.dtx:2 and loads it with `libertine` at 75-76 and 394-395). W1 CTAN; W2 option and load order only; W3 serves any text face (not one document); W4 one preamble line. Not `font.newtx`, `font.mathptmx`, `font.palatino` (each loads one named text-and-maths bundle), not `font.mathastext` (borrows the text face), not `math.bm` (alphabets), not `font.serif-pkg` (a text face). Used in rows 8 and 34.
- Considered, not proposed: `relsize` (mapped to `font.size-commands`, a relative size switch of the same type), `listingsutf8` (mapped to `code.listings`, same family), `iflang`, `etoolbox`, `ifthen`, `calc`, `pgfkeys` (helpers without printed effect).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
