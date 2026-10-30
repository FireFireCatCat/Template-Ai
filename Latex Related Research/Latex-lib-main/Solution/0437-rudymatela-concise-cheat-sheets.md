no

# 0437-rudymatela-concise-cheat-sheets: Concise Cheat Sheets (the `refcard` class and its template)

- Unverified: read from the source, not compiled.
- Source: Source/0437-rudymatela-concise-cheat-sheets/ (origin: https://codeload.github.com/rudymatela/concise-cheat-sheets/zip/refs/heads/master; licence: not established in the manifest; file headers say LPPL 1.3 for refcard.cls, threecols.sty and template-refcard.tex (refcard.cls:2-14), README.md:37-38 says CC-BY-SA 3.0 or GNU FDL 1.3 for the sheets)
- Kind: misc (a landscape, three-column reference card / cheat sheet)
- Lib: v5
- Engine: pdfLaTeX-compatible (Makefile:19 runs `pdflatex`; no fontspec or Lua)
- Look carried by: zip-local (refcard.cls and threecols.sty set the class base, page, columns, footer, title and table helpers; the sample preamble adds only fontenc and the sans default, template-refcard.tex:18-20)
- Class origin: zip-local (`refcard` and `threecols` are both 404 on ctan.org/pkg/; the zip is the author's GitHub repository, not a publisher kit; the base class `extarticle` it loads is published and not bundled)
- Main file: template-refcard.tex (other samples: haskell-cs.tex, haskell-tc-cs.tex, haskell-exts-cs.tex, thaskell-cs.tex, python-cs.tex, lua-cs.tex, ctf-cs.tex, yesod-cs.tex; all `\documentclass{refcard}`)
- Read: main yes, zip-local classes and styles all (refcard.cls and threecols.sty read in full; other samples: haskell-cs.tex lines 1-130 plus a grep outline of every sample's preamble and `\begin` lines, not read in full)

## Verdict
No. The class `refcard` reduces almost completely (an `extarticle` wrapper over `geometry`, `array`, `fancyhdr`, `xcolor` and macro aliases), but it loads `threecols.sty` unconditionally and switches it on at `\begin{document}`. That style rewrites the kernel output routine (`\@opcol`, a new `\@outputtplcol`, `\@doclearpage`) to get a whole-document three-column page flow, which is a custom output routine and no lib way expresses it. The author calls it "an ugly hack" (threecols.sty:31). Nothing in the sample is artwork and nothing needs a tool outside TeX.

## Blockers
- `BESPOKE/class` three-column page flow by a zip-local rewrite of the kernel output routine: `\threecolumn` (threecols.sty:54-66), `\@opcol` (threecols.sty:69-81), `\@outputtplcol` (threecols.sty:85-123), `\@doclearpage` (threecols.sty:127-186); loaded by refcard.cls:32 and activated by `\AtBeginDocument{\threecolumn}` (refcard.cls:56). Irreducible: the nearest published ways were considered and rejected (see Bespoke code).

## Class setting
- Class: `class.extarticle` (extsizes bundle on CTAN, not bundled in the zip, its source not read), reached through the zip-local `refcard`, which is `\LoadClass[\sz]{extarticle}` (refcard.cls:27). Option `8pt` by default (`\ExecuteOptions{8pt}`, refcard.cls:25); the sample gives none (template-refcard.tex:17). Sizes `8pt` to `14pt` are mapped to `\sz` at refcard.cls:19-24.
- Class-native vocabulary used (the `refcard` class is zip-local, so this is a record and not a way): `\cright{left}{right}` and `\version[prefix]{n}` (template-refcard.tex:24-29), a redefined `\maketitle` (template-refcard.tex:34), environments `ldesc` and `Ldesc` (template-refcard.tex:49, 79), row commands `\li[label]` and `\Li[label]` (template-refcard.tex:50, 80), inline `\I` and `\C` (template-refcard.tex:60, 128). Used by other samples: `tabularlc` (haskell-cs.tex:66), `\lI` (haskell-cs.tex:127), column type `b` (haskell-cs.tex:247), `\s` (haskell-cs.tex:27), `\comm` through `\M` (haskell-tc-cs.tex:36).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | template-refcard.tex:17; refcard.cls:27 | `class.extarticle` | the zip-local `refcard` replaced by its published base; size option via refcard.cls:25 |
| base font size | refcard.cls:19-25 | `page.class-options` | `8pt` (default; `9pt`..`14pt` selectable) |
| paper, orientation, margins | refcard.cls:28 | `page.geometry` | a4paper, landscape, nohead, includefoot, margin=24pt, left=18pt, right=18pt, footskip=16pt |
| three-column page flow | refcard.cls:32, 56; threecols.sty:54-186 | none (`BESPOKE/class`; considered `cols.multicol`, rejected) | columnwidth = (textwidth - columnsep)/3, vertical rules between columns, no balancing, floats unsupported (threecols.sty:33-34, 56-58, 102-107) |
| column gap and rule | refcard.cls:36-37 | `sp.lengths` | `\columnseprule`=0.4pt, `\columnsep`=60pt |
| running head | refcard.cls:28, 39, 41-43 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\lhead{}` `\chead{}` `\rhead{}` all empty, `nohead` in geometry |
| head rule | refcard.cls:40 | `hf.fancyhdr` | `\headrulewidth`=0pt |
| footer (copyright left, version centre, licence right) | refcard.cls:44-54; template-refcard.tex:24-29 | `hf.fancyhdr` | `\lfoot{\footnotesize #1}`, `\cfoot{#1\footnotesize <title> v<n>}`, `\rfoot{\footnotesize #2}` |
| footer text sizes | refcard.cls:49-50, 53; template-refcard.tex:27 | `font.size-commands` | `\footnotesize`, `\tiny` |
| section numbering off | refcard.cls:38 | `num.secnumdepth` | `secnumdepth`=0 |
| headings | template-refcard.tex:36, 47, 110, 128 | `head.kernel` | `\section`, `\subsection` of `extarticle` at 8pt, unnumbered |
| heading with right-aligned text | template-refcard.tex:128, 138, 149 | `sp.manual-space` | `\hfill` inside `\subsection{...}` |
| title block | refcard.cls:57-62; template-refcard.tex:22, 34 | `front.maketitle` | `\title{Template\\Reference Card / Cheat Sheet}`; `\maketitle` redefined to a centred `\huge` title, no author, no date |
| title block layout | refcard.cls:58-61 | `sp.ragged` | `center` environment |
| title size | refcard.cls:59 | `font.size-commands` | `\huge` |
| font encoding | template-refcard.tex:18 | `font.fontenc-t1` | `T1` |
| default family | template-refcard.tex:20 | `font.family-default` | `\familydefault` = `\sfdefault` |
| description tables | refcard.cls:67-84; template-refcard.tex:49-54, 79-92 | `tbl.tabular` | `tabular{lC}`; `Ldesc` adds `\hline` at the start and `\\\hline` at the end; rows `\li` = `\\`, `\Li` = `\\\hline` |
| column types | refcard.cls:63-66 | `tbl.tabular` | `\newcolumntype`: C = `>{\ttfamily\arraybackslash}l`, E = same with `c`, R = same with `r`, b = `>{\bfseries\arraybackslash}l` |
| table row gap | refcard.cls:102, 112 | `sp.manual-space` | `\\[1ex]` for `\lI` and `\LI` |
| ruled auto-wrapping table | template-refcard.tex:167-175 | `tbl.tabular` | `{\|p{0.3\columnwidth}\|p{0.6\columnwidth}\|}`, `\hline` between rows |
| line counter for rows | refcard.cls:34, 68, 96-97 | `num.counters` | `\newcounter{line}`, `\setcounter{line}{0}`, `\stepcounter{line}` (used only to skip the first `\\`) |
| verbatim block | template-refcard.tex:38-44 | `code.verbatim` | `verbatim` environment |
| inline type styles | refcard.cls:85-89; template-refcard.tex:60, 70 | `mark.kernel` | `\C`=`\texttt`, `\B`=`\textbf`, `\I`=`\textit`, `\CI`=`\texttt{\textit{}}`, `\N`=`\textnormal` |
| phantom alignment spaces | refcard.cls:90-91, 115 | `sp.manual-space` | `\hphantom` (`\T`, `\D`, `\s`) |
| grey comment text | refcard.cls:31, 116-117 | `color.xcolor` | `\textcolor{gray}{}` (`\comm`), italic variant `\commi` |
| paragraph and line breaks | template-refcard.tex:94-96 | `sp.lengths` | `\noindent`, then `\\` |
| inline maths | template-refcard.tex:70-71 | `math.kernel` | `$\backslash{}$` (content) |
| other samples: rotated glyph | haskell-cs.tex:12, 143 | `fig.rotating` | `\usepackage{rotating}`, `\rotatebox{90}{...}` |
| other samples: symbols | haskell-cs.tex:13 | `math.amssymb` | `\usepackage{amssymb}` (`\Rsh`) |
| other samples: description list | haskell-cs.tex:183 | `list.kernel` | `description` |
| other samples: spanning cells | haskell-cs.tex:24-27 | `tbl.tabular` | `\multicolumn{n}{@{}C}{}` inside `\newcommand` aliases |
| floats, footnotes, bibliography, index, cross-references, theorems, abstract, contents | none in any sample | not used | threecols.sty:33-34 says floats are not supported |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\threecolumn` | threecols.sty:54-66 | No | sets `\columnwidth`, `\hsize`, `\linewidth`, `\col@number` and its own booleans globally; no lib way holds a whole-document three-column mode |
| `\@opcol` redefinition | threecols.sty:69-81 | No | replaces the kernel output-column command to choose three, two or one column output |
| `\@outputtplcol` | threecols.sty:85-123 | No | a hand-written output routine: boxes two columns, then sets three `\hb@xt@` boxes with two rules (`\vrule`) |
| `\@doclearpage` | threecols.sty:127-186 | No | copy of a kernel internal edited for three columns; the header (threecols.sty:36-46) warns it breaks when the kernel changes |
| `\AtBeginDocument{\threecolumn}` | refcard.cls:56 | No | depends on the rows above. Considered `cols.multicol` (`multicols{3}` with `\columnseprule`): not a faithful reduction, since `multicols` balances the last page and is built for parts of a page, the author's own reason for writing the hack (threecols.sty:25-28); `cols.twocolumn-cmd` and `cols.twocolumn-option` give two columns only |
| `\li` `\lI` `\Li` `\LI` with counter `line` | refcard.cls:34, 95-114 | Yes | by expansion: each call is a row start, `label &`, preceded by `\\` (`\li`), `\\\hline` (`\Li`) or `\\[1ex]` (`\lI` `\LI`) except for the first row. The conditional `\ifnum\theline>1` is positional, so an emitter that writes the rows writes the separators directly. A strict reading of "hand-rolled counters and conditionals" would count this as a second blocker; judged reducible here |
| `tabularlc`, `ldesc`, `Ldesc` | refcard.cls:67-84 | Yes | `tabular{lC}` (or the given spec), `Ldesc` = rows between `\hline` and `\\\hline` (`tbl.tabular`) |
| `\newcolumntype` C E R b | refcard.cls:63-66 | Yes | array's declarative column types (`tbl.tabular`) |
| `\cright`, `\version` | refcard.cls:48-54 | Yes | `\lfoot` `\rfoot` `\cfoot` of `fancyhdr` with `\footnotesize`; `\@title` replaced by the title string (`hf.fancyhdr`, `font.size-commands`) |
| `\maketitle` redefinition | refcard.cls:57-62 | Yes | emit `\begin{center}\huge <title>\end{center}` where `\maketitle` stood (`sp.ragged`, `font.size-commands`); `front.titling` with `\pretitle` and `\posttitle` is the other route |
| alias macros `\C \B \I \CI \N \T \D \lditem \s \comm \commi` | refcard.cls:85-94, 115-117 | Yes | alias expansion to `mark.kernel`, `sp.manual-space`, `color.xcolor`, row text |
| size options 8pt to 14pt | refcard.cls:19-27 | Yes | `\LoadClass[8pt]{extarticle}`: a class option (`page.class-options`) |
| per-sample aliases `\la \F \X \mtype \longtype \thead` ... | haskell-cs.tex:16-27, 205-206 | Yes | `\newcommand` aliases of `\textbackslash`, `\textit`, `\multicolumn`, `\textbf` |
| Makefile and bin/quiet | Makefile:19-26, 62-70; bin/quiet:15-23 | Not template code | a build wrapper: pdflatex run twice and a `-2x` target that post-processes the PDF with `pdfnup`; the `.tex` files are written by hand, so this is not an `EXTERNAL` blocker |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and rejected for the three-column flow: `cols.multicol` (see Bespoke code); the zip-local `threecols` fails W1 (not on CTAN) and its code is not declarative (W2).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
