yes

# 0457-randexam: randexam (exam paper class with randomised variants)

- Unverified: read from the source, not compiled.
- Source: Source/0457-randexam/ (origin: https://mirrors.ctan.org/macros/latex/contrib/randexam.zip; licence: LPPL 1.3c, README:3 and randexam.cls:5)
- Kind: exam (the manifest hint `calendar` is wrong; the samples are a maths exam paper and the class manual)
- Lib: v4
- Engine: pdfLaTeX-compatible on the English path (read: the class loads no XeTeX-only package unless the `chinese`/`ctex`/`sourcehan` options are set, randexam.cls:1427-1467); the shipped files carry `% !TEX program = xelatex` (randexam-a-answer.tex:2)
- Look carried by: class (randexam.cls defines every element; the exam samples add only class options, one seed and content; the manual randexam.tex adds a documentation preamble of published packages, randexam.tex:3-48)
- Class origin: ctan (zip is the CTAN release of `randexam`, randexam.cls:5; author Jianrui Lyu, README:2)
- Main file: randexam-a-answer.tex (other samples: randexam.tex = the class manual and the manifest's `main`; randexam-a-blank.tex, randexam-b-answer.tex, randexam-b-blank.tex = 6-line wrappers)
- Read: main yes (randexam-a-answer.tex 361 lines and randexam.tex 864 lines in full), zip-local classes and styles all (randexam.cls, 1508 lines, in full; it is the only .cls/.sty; it is a published CTAN class). Not read: the source of the packages it loads (`functional`, `mathdesign`, `tabularray`, `freealign`, `medmath`, `codehigh`, `arevtext`, `ninecolors`); a `randexam.cfg` is looked for (randexam.cls:1419) but none ships.

## Verdict
yes. `randexam` is a published CTAN class, so it is one way, `class.randexam`. Every exam sample uses it through class options (`12pt`, `math=all`, `plain`, `noanswer`, `random`, `seed`) and its own vocabulary, plus kernel `tabularx` and `amsmath`. The manual's extra macros are aliases and a two-digit date pad that reduce to lib ways. The heavy code (question shuffling, the `abcd` layout, the answer-table generator) sits inside the published class, not in a sample or a zip-local file, so an emitter writes `\documentclass[...]{randexam}` and body wrappers without copying any macro logic. No ART, no EXTERNAL, no NOTEMPLATE.

Reading note for other definitions: if a reviewer treated randexam.cls as zip-local, the shuffle machinery (randexam.cls:689-725, 869-916, 1176-1198), the `abcd` `\halign` layout (1115-1174) and the answer-table generator (953-988) would be `BESPOKE/class`. Under the rubric (W1: on CTAN) they are class internals.

## Blockers
none

## Class setting
- Class: `class.randexam` options: `12pt` (passed on to article, randexam.cls:128), `math=all|most|many` (cls:104-110; sample uses `all`, randexam-a-answer.tex:3; manual uses `most`, randexam.tex:3), `plain` (cls:93), `noanswer` (cls:98), `random` (cls:97), `seed` (cls:613-616, set by `\SetExamOption`, randexam-a-answer.tex:7-9), `a3paper`/`a3input` (cls:94-95), `oneside` `evaluator` `mathdesign` `freealign` `medmath` `moremath` `language` `theme` `chinese` `ctex` `solidot` `sourcehan` (cls:96-126, 355-357). Base class: article (cls:132).
- Class-native vocabulary used: `\examtitle{name,date,version}` (randexam-a-answer.tex:13), `\gradetable[total,strut,evaluator]` (:15), `\exampart{type}[points]` (:17), `\answertable[total,column,strut,notice]` (:20), environments `question[points=]` (:22) and `solution` (:181), `abcd` choice environment (:82), `\fillout` (:26), `\pickout` (:81), `\points{n}` (:182), `\examdata{caption}` (:350), `\SetExamOption` (:7), `\SetExamTranslation` (:312); unused but defined: `\tickin` `\tickout` `\fillin` `\pickin` `\answer` `abcd*`, `\DeclareExamTemplate` `\SelectExamTemplate` `\DeclareExamTheme` `\SelectExamTheme` `\DeclareExamTranslation` `\SetExamValue` `\ExamFill*`, boolean helpers (cls:33-55, 197-357, 363-377, 1015-1046). Through `math=all` the class also provides the freealign alignment markers `\?` `\+` `\<` (used at randexam-a-answer.tex:182-183, cls:1213-1215) and the `moremath` macros `\e` `\dx` `\d` `\va` `\vb` `\vc` `\widebar` (used at :23, :31, :176, :300; cls:1267-1413).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | randexam-a-answer.tex:3; randexam.tex:3 | `class.randexam` | options as listed under Class setting |
| base class inherited | randexam.cls:132 | `class.article` | `\LoadClass{article}`; unknown options go to article (cls:128); gives `\section`, `\tableofcontents` used by the manual |
| type size | randexam-a-answer.tex:3 | `page.class-options` | 12pt |
| page geometry | randexam.cls:138-144 | `page.geometry` | a4paper, left=30mm, right=30mm, top=25mm, bottom=25mm, headheight=17pt |
| page geometry, manual | randexam.tex:4 | `page.geometry` | b5paper, margin=2cm |
| A3 two-up mode | randexam.cls:138-139, 161-169 | `page.geometry` and `pg.include-pdf` | a3paper, landscape, twocolumn, columnsep=60mm, margins 30/25mm; `pdfpages` loaded for `a3input` (the manual shows `\includepdf[pages=-,nup=2x1]` only inside a code block, randexam.tex:579-583) |
| running head and foot | randexam.cls:496-604 | `hf.class-native` | six slot templates `headleft`/`headcenter`/`headright` and `footleft`/`footcenter`/`footright` in `empty`/`plain`/`fancy` variants; head: exam name left, "Solutions" or "Name: ____" right; foot: date, "Page x of y", "Version"; shown from page 2 on (cls:552-554) |
| running head and foot, machinery | randexam.cls:152, 573-601 | `hf.fancyhdr` | `\fancypagestyle` for `plain`, `fancy` and `fancyfirst`, `\headrulewidth` 0.4pt or 0pt, `\fancyhead`/`\fancyfoot` |
| page style choice | randexam.cls:604; randexam.tex:10 | `hf.fancyhdr` | `plain` option gives `\pagestyle{plain}`; manual `\cfoot{\small\thepage}` |
| page X of Y | randexam.cls:153, 525-527 | `pgnum.lastpage` | `zref-lastpage`, `\zpageref{LastPage}` |
| paragraph and line spacing | randexam.cls:184-186, 1260-1265; randexam.tex:12-13 | `sp.lengths` | `\parindent`=0, `\lineskiplimit`=4pt, `\lineskip`=4pt, display skips 4pt minus 2pt / 2pt; manual `\parskip`=7pt plus 1pt minus 1pt |
| line stretch, array stretch | randexam.tex:27-28 | `sp.linespread` and `tbl.tabular` | `\baselinestretch`=1; `\arraystretch`=1.3 |
| Utopia text and math | randexam.cls:171-175 | `font.fourier` | `mathdesign` with option `utopia` (the Utopia family that `font.fourier` names; the package is the parameter); `\bfdefault`=bx |
| sans text face (manual) | randexam.tex:15, 25 | `font.helvet` and `font.family-default` | `arevtext` (a sans text-face package); `\familydefault`=`\sfdefault` |
| math font accent | randexam.cls:1312-1318 | `font.nfss` | `\DeclareFontFamily{U}{mathx}`, `\DeclareFontShape`, `\DeclareSymbolFont`, `\DeclareMathAccent{\widebar}` (only with `moremath`) |
| colours | randexam.cls:155, 395, 660-662, 1017 | `color.xcolor` | `\colorlet{part~number}{black}`, `{question~number}{blue!80!black}`, `{solution~name}{blue!80!black}`; answers `\color{blue}`; title in answer mode `red!80!black` |
| named colour set (manual) | randexam.tex:17, 41-48 | `color.xcolor` | `ninecolors` (named colours `blue3` `green3`...) used by `\textcolor` |
| exam title block | randexam-a-answer.tex:13; randexam.cls:387-417 | `front.class-native` | keys name, date (`\today`), version; answer mode prints name and "Solutions" in red, blank mode prints name and "Name: ____" (`\underspace{6em}`); `random` turns version A into B (cls:408-415) |
| grade table | randexam-a-answer.tex:15; randexam.cls:425-490 | `front.class-native` | keys total, strut=2.5em; `tabularx` with `Y` columns and rows Part/Score (and Evaluator with `evaluator`) |
| grade table, table machinery | randexam.cls:475, 181 | `tbl.tabularx` | `tabularx{\linewidth}` with a boxed column spec of `c` then `n` `Y` columns then `Y`, `\newcolumntype{Y}{>{\centering\arraybackslash}X}` |
| part heading | randexam-a-answer.tex:17, 74, 173; randexam.cls:738-772 | `head.class-native` | `\exampart{type}[points]`; bold "Part I: type (points)"; counter `\Roman` (cls:638-642) |
| appendix data heading | randexam-a-answer.tex:350; randexam.cls:774-787 | `head.class-native` | `\examdata{caption}`: centred bold "Appendix" and caption |
| answer table | randexam-a-answer.tex:20, 77; randexam.cls:932-1006 | `exam.questions` | keys total, column, strut, notice; a tabularx grid of question numbers with blank answer cells (generator at cls:953-988) |
| question environment | randexam-a-answer.tex:22-26; randexam.cls:815-842 | `exam.questions` | numbered description-list item, bold sans label in `blue!80!black`, key `points=` printed as "(n points)" (cls:804-813); number reset per part (`resetnumber`, cls:82) |
| question item list | randexam.cls:827 | `list.enumitem` | `\description[leftmargin=\hanglength,labelwidth=0pt,labelsep=0pt,topsep=0pt,parsep=0pt]` |
| solution environment | randexam-a-answer.tex:181-186; randexam.cls:844-861 | `exam.questions` | bold sans "Solution." label in `blue!80!black`; name set by `\SetExamTranslation{solution-Solution=Proof}` (randexam-a-answer.tex:312) |
| step points | randexam-a-answer.tex:182-185; randexam.cls:1224-1246 | `exam.questions` | `\points{n}` prints dots and red "n points" at the right edge; in display maths `\eqno` or `\tag*` |
| answer tokens | randexam-a-answer.tex:26, 81; randexam.cls:1015-1088 | `exam.questions` | `\fillout` (full-line underline), `\fillin`, `\pickout` (dots and boxed letter at the edge), `\pickin`, `\tickin`/`\tickout`; `\answer` hides text with `\phantom` |
| choice layout | randexam-a-answer.tex:82-87; randexam.cls:1115-1198 | `exam.questions` | `abcd` environment sets the four choices in 1, 2 or 4 rows by measured width; labels `(A)`..`(D)` |
| random variants | randexam.cls:613-629, 689-736, 869-916, 1176-1198; randexam-b-answer.tex:5 | `exam.questions` | option `random` and key `seed`: shuffles questions inside each part and swaps choices; seed 19061116 (randexam-a-answer.tex:8) |
| answer hiding | randexam.cls:98, 920-922; randexam-a-blank.tex:5 | `exam.questions` | option `noanswer` (set with `\PassOptionsToClass{noanswer}{randexam}`) excludes `solution` with the `comment` package and phantoms `\answer` |
| wrapper files | randexam-a-blank.tex:5-6; randexam-b-answer.tex:5-6; randexam-b-blank.tex:5-6 | `struct.input` | kernel `\input{randexam-a-answer}` after `\PassOptionsToClass` (a class option, so a parameter of `class.randexam`) |
| translations of keywords | randexam.cls:216-280, 1480-1501; randexam-a-answer.tex:312 | `class.randexam` | keyword table `\DeclareExamTranslation{english}{...}`, `\SetExamTranslation`, `\SelectExamTranslation`: strings only (same type as `lang.translator`, class-native here) |
| Chinese path (not used by the samples) | randexam.cls:1425-1467 | `lang.cjk` and `font.fontspec` | `ctex` options `cs4size,UTF8,noindent`; `\setCJKmainfont` Source Han; XeLaTeX or LuaLaTeX only |
| display maths | randexam.cls:146, 159, 1221-1222 | `math.amsmath` | `tbtags`; `\allowdisplaybreaks[4]` with `plain` |
| medium-size operators | randexam.cls:1252-1254 | `math.physics` | `medmath` (a fork of `nccmath` mediummath, per its CTAN page) loaded by `medmath`, `math=most` or `math=all` |
| formula alignment across lines | randexam.cls:1213-1215; randexam-a-answer.tex:182-185, 224, 239 | `class.randexam` | option `freealign` loads `freealign`; markers `\?` `\+` `\<`; considered: freealign as its own way, not proposed because the sample reaches it only through the class option |
| extra math macros | randexam.cls:1267-1413 | `math.mathtools` and `class.randexam` | `moremath` loads `mathtools` and `extarrows` (cls:1379-1380) and defines `\e` `\dx` `\va` `\widebar`...; content-level aliases |
| tables in the exam | randexam-a-answer.tex:352-359 | `tbl.tabularx` | `tabularx{\linewidth}{*{4}{>{$}X<{$}}}`, `\hline` |
| tabularray and diagbox | randexam.cls:156-157 | `tbl.nicematrix` and `tbl.multirow` | `tabularray` with `\UseTblrLibrary{diagbox}`, loaded unconditionally, not used by the samples |
| fill rules | randexam.cls:363-377 | `sp.rule` | `\xleaders` with a dot box or an underline box (`\ExamFillCdot`, `\ExamFillUline`, `\ExamFillUlineText`) |
| vertical space and breaks | randexam-a-answer.tex:28, 72, 188 | `sp.manual-space` and `pg.break` | `\bigskip` `\smallskip` `\vfill`; `\newpage` (in `random` mode the class redefines them to stay attached to a question, cls:895-899) |
| underlined word | randexam-a-answer.tex:147 | `mark.ulem` | kernel `\underline{wrong}` (same type, underline) |
| manual: contents and headings | randexam.tex:65, 67, 77 | `toc.kernel` and `head.kernel` | `\tableofcontents`, `\section`, `\subsection` |
| manual: cross references | randexam.tex:96, 545, 590 | `xref.kernel` | `\ref{opt:random}`, `\label` |
| manual: hyperlinks | randexam.tex:18-23, 60, 75 | `meta.hyperref` and `meta.url` | `colorlinks=true, urlcolor=blue3, linkcolor=blue3`; `\url`, `\href` |
| manual: tables | randexam.tex:30-31, 55-62, 505-526 | `tbl.booktabs` and `tbl.tabularx` | `\toprule \midrule \bottomrule`; boxed title table with `\ExamFillUlineText` and `\arraystretch`=2 |
| manual: code blocks | randexam.tex:33-37 | `code.verbatim` | `\DefineVerbatimEnvironment{code}{Verbatim}{formatcom=\color{blue!50!red}}` (fancyvrb) |
| manual: verbatim in arguments | randexam.tex:39, 43, 46-47 | `code.verbatim` | `\fakeverb` (not defined in the zip; taken to come from `codehigh`, whose CTAN page does not name it, so unverified) |
| manual: boxed demo title | randexam.tex:747-753 | `box.fancybox` | `\fbox` inside `\DeclareExamTemplate{examtitle}{myschool}` |
| manual: rules and spacing | randexam.tex:474, 477, 645 | `sp.rule` and `sp.manual-space` | `\hrule`, `\vskip0.5em`, `\vspace` |
| manual: font switches | randexam.tex:43-44, 183 | `mark.kernel` | `\ttfamily`, `\textsf`, `\textcolor` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\myversion` | randexam.tex:6 | yes | literal text "2024F" in the title box |
| `\mydate`, `\mylpad` | randexam.tex:7-8 | yes | prints `\the\year-MM-DD`; the `\ifnum` only pads to two digits; `front.datetime` (`\newdateformat` ISO) or a literal date |
| `\mypkg \myopt \mycmd \myenv \myfile \mykey \myval \myelem` | randexam.tex:41-48 | yes | `\NewDocumentCommand` aliases of `\textcolor` (`color.xcolor`), `\mbox`, `\ttfamily` (`mark.kernel`) and `\fakeverb` (`code.verbatim`); inline expansion |
| `code` environment | randexam.tex:35-37 | yes | `\DefineVerbatimEnvironment` call: `code.verbatim` with `formatcom=\color{...}` |
| wrapper files | randexam-a-blank.tex:5-6; randexam-b-answer.tex:5-6 | yes | `\PassOptionsToClass` with `noanswer` or `random` equals the class option in `\documentclass[...]{randexam}`; `\input` is `struct.input` |
| `\DeclareExamTemplate{examtitle}{myschool}` | randexam.tex:747-753 | yes | a template body of `\fbox`, `\UseExamValue` and `\quad` (`box.fancybox`, class vocabulary); one call plus `\SelectExamTemplate` |
| template, value, theme and translation registries | randexam.cls:197-357 | published class internals | not bespoke under W1 (CTAN); they are `\tlSet` string stores behind the class vocabulary |
| question shuffle (`\NewEnviron` capture, `pgfmath` seed, list removal) | randexam.cls:689-736, 869-916 | published class internals | would be irreducible if zip-local; reached through option `random` and key `seed` only |
| `abcd` layout and choice swap (`\halign`, `\parshape`, `\csdef` tables) | randexam.cls:1048-1056, 1115-1198 | published class internals | as above; reached through the `abcd` environment |
| answer-table generator (counters, `\whileboolexpr`) | randexam.cls:953-988 | published class internals | as above; reached through `\answertable[...]` |
| `\points` (math-mode test, `\eqno` or `\tag*`) | randexam.cls:1224-1246 | published class internals | reached through `\points{n}` |

## Content-opaque
none (the exam samples have no figures; the question text, formulas, determinants and the data table are content: randexam-a-answer.tex:22-359)

## Lib changes
- New ways proposed: none. Considered and not written as ways: `freealign` (a class option of `class.randexam`), `medmath` (maps to `math.physics`, a fork of `nccmath`), `codehigh` (only `\fakeverb` is used, `code.verbatim`), `comment` (loaded by the class to hide `solution`, part of `exam.questions` behaviour).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Note for the consolidator: `exam.questions` is used for a question-bank class with seeded shuffling and a student or teacher switch, the same type as `esami` and `mcexam` that v4 folded into it; the class vocabulary itself is recorded under `class.randexam`.
