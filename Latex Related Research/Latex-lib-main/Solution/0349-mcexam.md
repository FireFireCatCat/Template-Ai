yes

# 0349-mcexam: mcexam (randomized multiple-choice exam package)

- Unverified: read from the source, not compiled.
- Source: Source/0349-mcexam/ (origin: https://mirrors.ctan.org/macros/latex/contrib/mcexam.zip; licence: LPPL 1.3c)
- Kind: exam (the zip is the CTAN package `mcexam` v0.5 with its manual and one example exam)
- Lib: v3
- Engine: pdfLaTeX-compatible (mcexam.sty:30-37 loads xkeyval, etoolbox, environ, newfile, enumitem, longtable, pgffor, xstring; no fontspec, no Lua, no shell escape). Package option `output=analysis` needs R first, see Blockers.
- Look carried by: mixed (the published package mcexam.sty, shipped in the zip, sets the question and answer lists, output types, tables and hook environments; the example's preamble adds the fancyhdr footer and the minipage wrapper hook; `article` carries nothing)
- Class origin: tex-distribution-unbundled (class `article`, kernel, not bundled; the zip adds a CTAN package, not a class)
- Main file: mcexam_example.tex (other samples: mcexam.tex, the package manual, which the manifest lists as main; it does not load mcexam and sets only an `article` look with parskip, enumitem and fancyvrb)
- Read: main yes (mcexam_example.tex 1-334 and mcexam.tex 1-701 in full), zip-local classes and styles all (no class in the zip; mcexam.sty 1-1899 read in full; README.md and mcexam_example_dataset.r read; mcexam.pdf is compiled output, not opened)

## Verdict
Yes. The look is defined by one published package, `mcexam` (CTAN, W1), chosen only by package options, booleans, permutation lists and a documented set of hook environments (W2), for a kind of component, a multiple-choice question set (W3), printable as one `\usepackage[..]{mcexam}` line plus `mcquestions` body wrappers (W4); it is proposed as `exam.questions`. Everything the example adds is an existing lib way (fancyhdr, lastpage, framed, minipage, enumitem, tabular, kernel spacing and rules); its one preamble redefinition is a documented hook that wraps a minipage. The verdict rests on accepting `exam.questions` as a way: mcexam.sty itself implements a permutation algorithm that no lib way expresses, so if W2 were read to exclude it the answer would turn into `BESPOKE/package`.

## Blockers
none
Not counted (conditional, not selected in the sample): `EXTERNAL/package` only when `output=analysis` is chosen: mcexam.sty:1441-1445 reads `\jobname.ana`, which the generated R function writes (mcexam.sty:1340-1433); the sample uses `output=concept` (mcexam_example.tex:15) and the other four output types need no tool. Compare `logbook.dmlb` option `graph`.

## Class setting
- Class: `class.article` options: a4paper (mcexam_example.tex:13); no options in the manual (mcexam.tex:13)
- Class-native vocabulary used: `\section` `\subsection` `\subsubsection`, `\title` `\author` `\maketitle`, `\tableofcontents`, `itemize` `enumerate` `description` `quote`, `center`, `tabular` (manual); `center`, `itemize`, `tabular` (example). No `abstract`, no bibliography.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | mcexam_example.tex:13; mcexam.tex:13 | `class.article` | a4paper (example); none (manual) |
| paper | mcexam_example.tex:13 | `page.class-options` | a4paper; margins and 10pt are class defaults |
| mcexam load | mcexam_example.tex:15-22; options defined mcexam.sty:65-124 | `exam.questions` | output=concept, numberofversions=4, version=1, seed=1, randomizequestions=true, randomizeanswers=true, writeRfile=true |
| output type presets | mcexam.sty:214-285; mcexam.tex:513-554 | `exam.questions` | `\mcsetupConcept/Exam/Key/Answers/Analysis{showPerVersion, showQuestionPermutationtable, showQuestionsAnalysis, showQuestionList, showCorrectAnswers, showAnswerPoints, showExplanation, showAnswerPermutationTable, showAnswersAnalysis, showNotes, showKeytable}` booleans; the sample sets none |
| version name | mcexam_example.tex:33, :74; mcexam.sty:596-602 | `exam.questions` | `\mctheversion` prints "Concept version", "Version I", "Answer Key", "Analysis" by output type; label formats `\mcversionlabelfmt` (`\Roman`), `\mcquestionlabelfmt` (`\arabic`), `\mcanswerlabelfmt` (`(\alph)`) at mcexam.sty:435-437 |
| headers and footers | mcexam_example.tex:28-34 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, headrulewidth=0pt, footrulewidth=1pt, `\lfoot{\mctheversion}`, `\rfoot{Page \thepage\ of \pageref{LastPage}}` |
| page X of Y | mcexam_example.tex:28, :34 | `pgnum.lastpage`, `xref.kernel` | package lastpage; `\pageref{LastPage}` |
| question block kept on one page | mcexam_example.tex:37-38; hook documented mcexam.tex:631-637 | `box.minipage`, `exam.questions` | `\renewenvironment{setmcquestion}`: `minipage[t]` of width `\linewidth-\labelwidth` then `\par`; width needs `calc` (considered: calc, a length-expression notation, not a component) |
| hand-set title | mcexam_example.tex:69-71 | `sp.ragged`, `mark.kernel`, `font.size-commands` | `center` env, `\bfseries`, `\LARGE`, `\texttt`; no `\maketitle` |
| version banner | mcexam_example.tex:73-75 | `box.mdframed`, `sp.ragged`, `mark.kernel`, `font.size-commands` | `framed` env (package framed, :25); `\centering\bfseries\Large\MakeUppercase{\mctheversion}` |
| selective output | mcexam_example.tex:77-93, :314-324; mcexam.sty:295-367 | `exam.questions` | `\mcifoutput[versions]{concept,exam}{text}`; text is content |
| name and ID fill-in lines | mcexam_example.tex:81-83 | `sp.rule`, `sp.manual-space`, `sp.lengths` | `\dotfill`; `\\[.5\baselineskip]`; `\noindent` (nearest home: `\parindent` off for one paragraph) |
| vertical space | mcexam_example.tex:79, :85, :316 | `sp.manual-space` | `\bigskip`, `\vspace{2\baselineskip}` |
| instructions list | mcexam_example.tex:87-91, :318-322 | `list.enumitem`, `mark.kernel` | `itemize[nosep]`; `\textbf{Instructions:}` |
| question list | mcexam_example.tex:100-308; mcexam.sty:408-425, :1556-1599 | `exam.questions` | `mcquestions[name]`, `\question`, `\question[follow]` (:161, :172; follow keeps a question next to the previous one when questions are shuffled) |
| question instruction | mcexam_example.tex:104-106, :144-146 | `exam.questions` | `mcquestioninstruction` before a `\question` |
| answer list | mcexam_example.tex:110-116, :150, :163, :174, :184, :298 | `exam.questions` | `mcanswerslist[perm]` with perm = default permuteall, `fixlast`, `ordinal`, `permutenone` or user lists `{1,2,3,4},{2,3,4,1},{3,4,1,2}`; `\answer[correct]` or `\answer[<decimal points>]` (mcexam.tex:306-390) |
| free-form answers | mcexam_example.tex:130-138, :193-201 | `exam.questions`, `tbl.tabular` | `mcanswers` with `\answer[correct]{n}{content}`, `\answernum{n}`; tabular `@{}cccc` / `cccc`, row gap `\\[0.1\baselineskip]` |
| explanation and notes | mcexam_example.tex:118-124, :157-159, :303-305; mcexam.sty:878-900 | `exam.questions` | `mcexplanation`, `mcnotes`; shown in concept, explanation also in answers, per the show booleans (mcexam.sty:226-285) |
| question references | mcexam_example.tex:145, :148, :172 | `xref.kernel` | `\label{ref1}` `\ref{ref1}`; list `ref=\mcquestionlabelfmt{*}` (mcexam.sty:441) |
| answer pictures | mcexam_example.tex:25, :132-135 | `art.tikz` | `\tikz{\draw ...}` inside answer cells: content (see Content-opaque) |
| large glyph answers | mcexam_example.tex:195-198 | `font.size-commands` | `\Huge` around inline math |
| question list look (package default) | mcexam.sty:439-444 | `exam.questions`, `list.enumitem` | `\newlist{setmcquestions}{enumerate}{1}`; label=`\mcquestionlabelfmt{*}.`, ref, itemsep=2\baselineskip, topsep=2\baselineskip; retune with `\setlist[setmcquestions]` |
| answer list look (package default) | mcexam.sty:446-449, :451-453 | `exam.questions`, `list.enumitem` | `setmcanswerslist`: label=`(\alph*)`, noitemsep; `setmcquestioninfo` description list, before=`\footnotesize\sffamily` |
| hook environments (package default) | mcexam.sty:455-500; mcexam.tex:598-629 | `exam.questions`, `sp.manual-space`, `sp.ragged`, `font.size-commands`, `sp.lengths` | `setmcquestioninstruction` (`\noindent`), `setmcquestion` (empty), `setmcanswers` (`\vspace{\baselineskip}`), permutation, analysis and key table wrappers: `center`, `\footnotesize\sffamily`, tabcolsep 10pt or 15pt |
| question and answer permutation tables | mcexam.sty:1489-1526, :1703-1732 | `exam.questions`, `tbl.longtable`, `tbl.tabular` | generated `longtable{cc*{n}{c}}` and `tabular`; shown in concept output only |
| key table | mcexam.sty:1778-1879 | `exam.questions`, `tbl.longtable` | `longtable{c*{n}{c}}` (correct mode) or `{l*{n}{c}}` (points mode); shown when `output=key` |
| permutation and shuffling | mcexam.sty:93-97, :963-1166 | `exam.questions` | `seed` -> `\pgfmathsetseed`; swaps with `\pgfmathrandominteger`; computed in TeX, output is a document, not a file |
| English and Dutch strings | mcexam.sty:509-586 | `lang.babel` | fixed English strings; Dutch set when `babel` has option `dutch` (`\@ifpackagewith`); sample loads no babel |
| R script written as a by-product | mcexam.sty:1213-1439; mcexam_example_dataset.r:2-5, :34-35 | `exam.questions` | `writeRfile` boolean writes `\jobname.r` with `newfile` streams; the package default is true (mcexam.sty:119) although the manual says false (mcexam.tex:191); read back only in `output=analysis` (mcexam.sty:1441); the PDF in other modes does not use it |
| manual: toc without heading | mcexam.tex:14-18, :47 | `toc.kernel` | `\renewcommand\tableofcontents{\@starttoc{toc}}` (see Bespoke code) |
| manual: packages | mcexam.tex:20-23 | `sp.parskip-pkg`, `list.enumitem`, `code.verbatim`, `meta.url` | parskip, enumitem, fancyvrb, url |
| manual: code listings | mcexam.tex:22, :64-92, :141 | `code.verbatim` | `\CustomVerbatimEnvironment{code}{Verbatim}{xleftmargin=1em}`; `commandchars=\!\?\;` on some uses; `\verb` throughout |
| manual: title | mcexam.tex:25-26, :32 | `front.maketitle` | `\title` `\author` (with `\url`) `\maketitle`, `\date` left default |
| manual: line breaking | mcexam.tex:31 | `sp.hyphenat` | `\sloppy` |
| manual: front blocks | mcexam.tex:36-45, :49 | `font.size-commands`, `sp.lengths`, `sp.manual-space`, `mark.kernel`, `pg.break` | `\small\noindent`; `\vspace{\stretch{1}}`; `\scriptsize\noindent\sffamily`; `\clearpage` |
| manual: contents | mcexam.tex:47 | `toc.kernel` | `\tableofcontents` as redefined above |
| manual: headings | mcexam.tex:138, :216, :219, :304, :436, :462 | `head.kernel` | article `\section`, `\subsection`, `\subsubsection`, default look |
| manual: lists | mcexam.tex:56, :95, :156, :257-259, :290, :681 | `list.kernel`, `list.enumitem` | `itemize`; `enumerate[label=\arabic{*}.,itemsep=1\baselineskip]` and `[label=\alph{*}),noitemsep]`; `description` |
| manual: quote | mcexam.tex:486-488 | `quote.kernel` | `quote` |
| manual: rendered example table | mcexam.tex:292-295 | `tbl.tabular` | `tabular{cccc}` |
| manual: cross-references | mcexam.tex:169, :462 | `xref.kernel` | `\label{sec:analysis}` `\ref` |
| manual: inline marks | mcexam.tex:63, :102, :454 | `mark.kernel` | `\textsf` `\emph` `\textit` `\texttt` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewenvironment{setmcquestion}` | mcexam_example.tex:37-38 (scope preamble) | yes | a documented hook (mcexam.tex:598-637) whose body is `box.minipage`: `[t]`, width `\linewidth-\labelwidth` (calc expression), closing `\par` |
| `\tableofcontents` redefined with `\@starttoc{toc}` | mcexam.tex:14-18 (scope preamble, manual only) | yes | kernel one-liner: the kernel's own toc call without its heading, `toc.kernel`; no layout logic is copied (an unverified alternative: `toc.etoc` with an empty title style) |
| `\CustomVerbatimEnvironment{code}{Verbatim}{xleftmargin=1em}` | mcexam.tex:22 (scope preamble, manual only) | yes | fancyvrb's own declaration, `code.verbatim` |
| commented-out solution-counter block (`\newcounter{temp}`, `\setlist[setmcquestions]{label=..\addtocounter..}`) | mcexam_example.tex:44-54 | not active | comments; if enabled it is a list label with a counter offset, `list.enumitem` plus `\newcounter`; not counted |
| mcexam.sty (1899 lines): option parsing, `\NewEnviron` body collection, csname arrays, `\pgfmathrandominteger` shuffles, `longtable` text builders, R writer | mcexam.sty:65-124, :408-425, :637-900, :963-1166, :1215-1447, :1489-1879 | published, so not bespoke by W1 | CTAN package; its permutation algorithm is not expressible with other lib ways, which is why it is one way, `exam.questions`, chosen by options (scope package; see Verdict) |

## Content-opaque
- `\tikz{\draw ...}` answer pictures inside `mcanswers` tabular cells (mcexam_example.tex:132-135): answer content, not template identity.
- Question and answer texts, the exam's questions, inline maths (`$\pi$`, `$\alpha$`) throughout mcexam_example.tex:100-308.
- The manual's R and LaTeX code examples are verbatim content (mcexam.tex:64-92, :222-255 and others).
- The fictitious student data and `source("mcexam_example.r")` call in mcexam_example_dataset.r:20-35: R data for the analysis step, not template look.

## Lib changes
- New ways proposed: `exam.questions` `mcexam` (CTAN, LPPL 1.3c), pdfLaTeX. Preamble `\usepackage[output=concept|exam|key|answers|analysis, numberofversions=<n>, version=<v>, seed=<n>, randomizequestions=<bool>, randomizeanswers=<bool>, writeRfile=<bool>]{mcexam}`, `\mcsetup<Output>{show...=<bool>}`; body `mcquestions[name]` with `\question[follow]`, `mcquestioninstruction`, `mcanswerslist[permuteall|fixlast|ordinal|permutenone|{perm},{perm}]` and `\answer[correct|<points>]`, `mcanswers` with `\answer{n}{..}` `\answernum{n}`, `mcexplanation`, `mcnotes`, `\mcifoutput[versions]{outputs}{text}`, `\mctheversion`, and the `setmc*` hook environments. W1: on CTAN. W2: behaviour is set by option values, booleans, integers and permutation lists. W3: any multiple-choice test, not one document. W4: one preamble line plus body wrappers around question and answer content. A way apart from `exam.questions` (`exam`/`examdesign`): different vocabulary, randomised versions, key table and R side file; a consolidator may fold it into `exam.questions` as a package parameter, and the rows above then read the same. Its `output=analysis` mode is EXTERNAL when selected (R).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
