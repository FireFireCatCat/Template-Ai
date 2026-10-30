yes

# 0026-exam-lite: exam-lite (very simple exam template, Rok Kukovec and Iztok Fister Jr.)

- Unverified: read from the source, not compiled.
- Source: Source/0026-exam-lite/ (origin: https://mirrors.ctan.org/macros/latex/contrib/exam-lite.zip; licence: CC BY-SA 4.0)
- Kind: exam
- Lib: v1
- Engine: pdfLaTeX-compatible (T1 + inputenc utf8, babel, fancyhdr, datetime, enumerate, totcount; no fontspec or Lua; `totcount` needs a second run for the total, not an outside tool)
- Look carried by: class (the sample sets only option values and data fields; the look is `exam-lite.cls` over `article`)
- Class origin: ctan (the zip is the CTAN package; `ctan.org/pkg/exam-lite` read once: "Exam-lite", version 2023-02-06, CC BY-SA 4.0, topics Exam, Class; same date as `\ProvidesClass` at exam-lite.cls:5)
- Main file: exam-lite.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (exam-lite.cls, 320 of 320 lines; no .sty/.def/.cfg/.clo/.bst in the zip; README.md and LICENSE skimmed; exam_lite.pdf not opened, no renderer available)

## Verdict
The look is carried entirely by one published CTAN class, `exam-lite`, so it is `class.exam-lite` plus option values (`english`, `exam`) and data fields (`\subject`, `\academicyear`, ...), as the rubric's published-class ruling describes. The sample defines no macro, counter or environment of its own. Every package the class loads maps to a lib way or is loaded and unused, nothing needs a tool outside TeX, and there is no TikZ or other artwork (the logo is an included user image). The class's internal conditionals are not a blocker only because the class is published (see Bespoke code); an emitter writes the class name, options, setter calls and the class's own question commands and copies no macro logic. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.exam-lite` options: `english` (or `slovene`) selects language strings and the header block (exam-lite.cls:125-244); `exam` (or `midterm`) selects the exam type (exam-lite.cls:109-115); every other option goes to article (exam-lite.cls:24); the class loads `article` with `a4paper,onecolumn` (exam-lite.cls:251). The sample passes `english, exam` (exam-lite.tex:4).
- Class-native vocabulary used: data setters `\ImagePath` `\subject` `\academicyear` `\studyprogram` `\examid` `\location` `\subacronym` `\writingtimeminutes` `\instructionstext` (exam-lite.tex:12-38; defined exam-lite.cls:27-103); `\newdate{examdate}{d}{m}{y}` is the `datetime` package's, read by the class through `\displaydate{examdate}` (exam-lite.cls:162,229,298); page commands `\makefirstpage` (exam-lite.cls:270-292) and `\makenextheaders` (exam-lite.cls:296-305); question commands `\qncounter{n}` (exam-lite.cls:311), `\question{text}{pts}{vspace cm}` (:314), `\longquestion{text}{pts}{vspace cm}` (:317), `\alinea{text}{pts}{vspace cm}` as an `\item` inside a list (:320). Defined but not used by the sample: `\namesurname`, `\studentid`, `\grade`, `\examperiod`, `\examdate` and the other `\p...` readers (exam-lite.cls:27-103).
- Class notes (not blockers): `\examtype` exists only after `exam` or `midterm`, so one of them is required (exam-lite.cls:109-115); those options are declared before `english`/`slovene`, and `\ProcessOptions` runs options in declaration order (exam-lite.cls:249). `\subacronym` is set (exam-lite.tex:26) but no class macro prints `\psubacronym` (exam-lite.cls:63-64 only). The Slovene `\examperiod` strings look swapped between exam and midterm (exam-lite.cls:128-129), a content slip that does not change the way. This is not the `exam` class (`class.exam`) and does not load the `exam` package.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | exam-lite.tex:4; exam-lite.cls:5 | `class.exam-lite` | options `english, exam` |
| underlying base class | exam-lite.cls:251 | `class.article` | `\LoadClass[a4paper,onecolumn]{article}`, loaded by the class, not by the sample |
| paper and columns | exam-lite.cls:251 | `page.class-options` | a4paper, onecolumn |
| margins and head/foot lengths | exam-lite.cls:255-260, 302, 304 | `page.setlength` | `\oddsidemargin` and `\evensidemargin` -0.800in; `\textwidth` +1.75in; `\topmargin` -0.800in; `\textheight` +1.75in; `\headheight` 12.05pt; `\headsep` 0.4in; `\footskip` 30pt |
| paragraph spacing, package | exam-lite.cls:12 | `sp.parskip-pkg` | `skip=10pt plus1pt, indent=40pt` |
| paragraph spacing, lengths | exam-lite.cls:263, 266 | `sp.lengths` | `\parindent` 0.1em, `\parskip` 1em (set after the package load at :12 and the class load at :251) |
| encodings | exam-lite.cls:13-14 | `font.fontenc-t1` | fontenc T1, inputenc utf8; no font package, so the default face |
| text sizes | exam-lite.cls:150, 217, 271, 278, 300 | `font.size-commands` | `\large`, `\LARGE` |
| language | exam-lite.cls:9 | `lang.babel` | `\RequirePackage{babel}` with no language argument; the words (Question, point, Writing time...) are strings that the `english`/`slovene` options store (cls:192-204) |
| exam data fields | exam-lite.tex:12-28; exam-lite.cls:27-103, 224-229 | `front.class-native` | setters listed under Class setting; the English header block prints Subject, Study year, Study program, exam period + id, Place, Date |
| exam date | exam-lite.tex:24; exam-lite.cls:17, 229, 298 | `front.datetime` | `\newdate{examdate}{07}{02}{2022}` printed with `\displaydate{examdate}` (the package's date objects, not `\newdateformat`) |
| first page | exam-lite.cls:270-292; exam-lite.tex:54 | `front.class-native` | `\makefirstpage`: header block, full-width rule, points total and writing time on one line, centred `\textbf{{\LARGE <type>}}`, name/student ID/grade fill-in lines, underlined INSTRUCTIONS heading, instructions text |
| first-page header: logo and info | exam-lite.cls:207-222 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\fancyhead[L]` logo, `\fancyhead[R]` info block, `\headrulewidth` 0pt, `\footrulewidth` 0pt |
| header logo | exam-lite.cls:215; exam-lite.tex:12 | `fig.graphicx` | `\includegraphics[width=6cm, height=3.5cm, keepaspectratio]{\pImagePath}` (slovene 5cm x 4cm, cls:148); shipped file `imgs/exam-lite-affl-logo.png` |
| header info layout | exam-lite.cls:217-220 | `tbl.tabular` | `\begin{tabular}[t]{l@{}}`, one left column, six lines |
| rules and fill lines | exam-lite.cls:274, 280, 283, 286 | `sp.rule` | `\rule{0.9\paperwidth}{0.4pt}` in `\makebox[\linewidth]`; `\hrulefill` after each field label |
| centred type title | exam-lite.cls:278 | `sp.ragged` | `center` environment |
| manual spacing | exam-lite.cls:154, 215, 221, 276-290, 311 | `sp.manual-space` | `\hfill`, `\raisebox{\dimexpr-\height+\baselineskip}[0pt][0pt]`, `\vspace{-1.2cm}`, `{1cm}`, `{0.5cm}`, `\vspace*{4\baselineskip}`, `{5mm}`, `{2mm}` |
| emphasis | exam-lite.cls:278, 289, 311, 314 | `mark.kernel` | `\textbf`, `\underline`, `\textsc` |
| instructions list | exam-lite.tex:31-38, 89-93 | `list.kernel` | `enumerate` with `\item ...\\`, stored by `\instructionstext`; plain choice list at :89-93 |
| sub-question list | exam-lite.tex:82-85 | `list.enumerate-pkg` | `\begin{enumerate}[i]` (the `enumerate` package, cls:18) around `\alinea` items |
| points total | exam-lite.cls:19, 245, 276 | `pgnum.lastpage` | `totcount`: `\newtotcounter{sum_pts}`, `\total{sum_pts}`, the final value of a counter read from the aux file (same family as `lastpage`/`totpages`; see Lib changes) |
| points accumulation | exam-lite.cls:314-320 | `num.counters` | `\addtocounter{sum_pts}{#2}` inside each question command |
| later-page running head and foot | exam-lite.cls:296-305; exam-lite.tex:56 | `hf.class-native` | `\makenextheaders`, realised by `hf.fancyhdr` below |
| later-page fancyhdr calls | exam-lite.cls:298-300, 303 | `hf.fancyhdr` | `\lhead{\displaydate{examdate}}`, `\chead{{\large\psubject}}`, `\rhead{\pacademicyear}`, `\cfoot{\thepage}` |
| page break before questions | exam-lite.cls:297 | `pg.break` | `\newpage` |
| page number reset | exam-lite.tex:71 | `pgnum.pagenumbering` | `\setcounter{page}{1}` |
| question label | exam-lite.cls:311; exam-lite.tex:73-95 | `class.exam-lite` | class-native `\qncounter{n}` (number passed by hand, not a counter) |
| question label, kernel part | exam-lite.cls:311 | `head.kernel` | `\paragraph{\underline{Question n}}` run-in heading from article, no restyle |
| questions with points | exam-lite.cls:314-320; exam-lite.tex:74-96 | `class.exam-lite` | class-native `\question` (parbox 14cm, points on the same line), `\longquestion` (parbox 16.5cm, points on the line below), `\alinea` (parbox 12cm, `\item \!\!)\:`); points as `\textsc{(N point/points)}`; answer space `\vspace{#3 cm}` |
| question text boxes | exam-lite.cls:314, 317, 320 | `box.minipage` | `\parbox{14cm}`, `\parbox{16.5cm}`, `\parbox{12cm}` |
| loaded, unused | exam-lite.cls:15 | `box.mdframed` | `\RequirePackage{framed}`; nothing in the class or sample uses it |

`lipsum` (exam-lite.cls:16) is loaded and never called; it supplies dummy text, which is content, so it has no row. Not defined or used: bibliography, index, table of contents, abstract, theorems, maths, code, captions, colour, hyperlinks, footnotes, floats other than the header logo.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| sample's own macros | exam-lite.tex | none defined | the sample only calls class commands; `\makeatletter` at :69 (never closed) and the `\iffalse ... \fi` comment at :40-49 print nothing |
| data setters `\def\subject#1{\def\@subject{#1}}` with `\p...` readers | exam-lite.cls:27-103 | n/a, published with the class | string fields; an emitter writes the setter call |
| `english`/`slovene` option bodies | exam-lite.cls:125-244 | n/a, published with the class | pick label strings and the header block; `english` is a class option value |
| `\aboutexam`, `\makefirstpage`, `\makenextheaders`, `\question`, `\longquestion`, `\alinea` | exam-lite.cls:207-320 | n/a, published with the class | compositions of `hf.fancyhdr`, `sp.rule`, `sp.manual-space`, `box.minipage`, `num.counters`; called, not copied |
| `\Conjugation`, `\Apply@Conjugation` (singular/plural or Slovene ending after the points) | exam-lite.cls:164-187, 231-242 | not reducible to lib ways: a hand-rolled `\ifx` conditional that decides printed text; not a blocker only because it ships inside a published class | the emitter never copies it: it calls `\question` and the class prints the ending |

If a reader refuses "published" for this class, the `\Conjugation` conditional (BESPOKE/class) would flip the verdict to `no`. The CTAN page confirms the package, so this file applies W1 and the published-class ruling as written.

## Content-opaque
none. The logo `imgs/exam-lite-affl-logo.png` is a user-supplied image set by `\ImagePath` (exam-lite.tex:12) and shipped, so it is content, not drawn artwork. The sample's commented logo paths (exam-lite.tex:10-11) and README's `imgs/logo_exam.png` (README.md:7) are not in the zip and are not needed by the active sample.

## Lib changes
- New ways proposed: none.
- Two judgement calls for the consolidator: (1) `totcount` is placed under `pgnum.lastpage` because it is the arbitrary-counter form of `lastpage`/`totpages` (the counter name is the parameter); no separate `NEW:` way was proposed. (2) exam-lite's own `\question` family is written under `class.exam-lite`, not `exam.questions`, because that way names the `exam` and `examdesign` packages, which this class does not use.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
