yes

# 0856-kfupm-math-exam: kfupm-math-exam (KFUPM mathematics department exam class)

- Unverified: read from the source, not compiled.
- Source: Source/0856-kfupm-math-exam/ (origin: https://mirrors.ctan.org/macros/latex/contrib/kfupm-math-exam.zip; licence: MIT)
- Kind: exam
- Lib: v6
- Engine: pdfLaTeX-compatible
- Look carried by: class (the exam look lives in the CTAN class `kfupm-math-exam`, whose source is only in kfupm-math-exam.dtx:113-407; the shipped sample is a plain `article` manual)
- Class origin: ctan
- Main file: kfupm-math-exam.tex (other samples: the `driver` block of kfupm-math-exam.dtx:33-45 and the usage text at kfupm-math-exam.dtx:50-106)
- Read: main yes, zip-local classes and styles all (no .cls or .sty ships; the class source is in kfupm-math-exam.dtx, read in full, with kfupm-math-exam.ins; kfupm-math-exam.pdf not read)

## Verdict
yes. What the zip compiles as its sample (kfupm-math-exam.tex, and the same driver at kfupm-math-exam.dtx:33-45) is a plain `article` manual with `inputenc`, a `\maketitle` block, two `\section`s and one `verbatim` block, and each of these is a lib way. The exam look sits in the class `kfupm-math-exam`, which is published (CTAN contrib, MIT, also in TeX Live and MiKTeX per ctan.org/pkg/kfupm-math-exam, read once), so it is the one way `class.kfupm-math-exam`, set by 17 key options and the commands `\instructions` and `\versioncover`; no zip-local bespoke code remains outside it. The yes rests on the rubric rule that a published class is one way: the class source itself holds expl3 string and page-count code and hard-coded KFUPM text (see "Bespoke code"), which would be `BESPOKE/class` if the class were counted as zip-local.

## Blockers
none

## Class setting
- Class: `class.article` for the sample (kfupm-math-exam.tex:1, no options) and `class.kfupm-math-exam` for the zip's own class (shown in use at kfupm-math-exam.tex:15-32). Options of `class.kfupm-math-exam` are string keys of a `kvoptions` family `kfupmmathexam` (kfupm-math-exam.dtx:128-163): `term` `topic` `university` `dept` `course` `quartile` `examtitle` `examdate` `numofversions` `numofquestions` `numofoptions` `studentnumber` `email` `firstexercise` `betweenquestions` `spaceafterbody` `betweenoptions`. Unknown options go to `article` (dtx:165-167), which is loaded with `a4paper, 12pt` (dtx:171).
- Class-native vocabulary used by the sample: options `course` `quartile` `examtitle` `examdate` `topic` `dept` `numofquestions` `numofversions` `numofoptions` `firstexercise` `term` `betweenquestions` (kfupm-math-exam.tex:18-31, double-braced values); `\instructions{...}` (tex:35-47); `\versioncover{1}` (tex:53); `\newpage` (tex:55). Defined by the class and not shown in the sample: `\coverpage[course][examtitle][term][examdate]` (dtx:251), `\codestr` (dtx:396), `\pagecount` (dtx:379), `\R \N \Z \Q` (dtx:345-348), `\nonl` (dtx:335).
- Option use inside the class: `term` (dtx:243, 251), `dept` (dtx:244), `course` `examtitle` `examdate` (dtx:251), `numofversions` `numofquestions` `numofoptions` (dtx:266-268, 352, 355). Declared but never read elsewhere in the source: `quartile` `topic` `university` `firstexercise` `betweenquestions` `spaceafterbody` `betweenoptions` (dtx:133-163); `studentnumber` and `email` only inside `\kme@authorProcessed` (dtx:221-222), which is never called.

## Component map
Rows marked (sample) are what the zip's own `.tex` files typeset and are the in-scope body of the recovery. Rows marked (class) are inside `class.kfupm-math-exam`: they are recorded so the class can be re-read under other definitions, and the emitter prints only the `\documentclass` line and the class-native calls.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| (sample) document class | kfupm-math-exam.tex:1 | `class.article` | no options |
| (sample) input encoding | kfupm-math-exam.tex:2 | `font.fontenc-t1` | `inputenc`, option `utf8` |
| (sample) title block | kfupm-math-exam.tex:4-7, 11 | `front.maketitle` | `\title{KFUP MATH EXAM \\ {\large version 0.1.0}}`, `\author{Mohammed Alshahrani}`, `\date{July 2022}`, `\maketitle` |
| (sample) line break and size in the title | kfupm-math-exam.tex:4-5 | `sp.manual-space`, `font.size-commands` | `\\`, `\large` |
| (sample) headings | kfupm-math-exam.tex:13, 61 | `head.kernel` | `\section{Usage}`, `\section{More Examples}`, default numbering |
| (sample) class-usage listing | kfupm-math-exam.tex:14-59 | `code.verbatim` | `verbatim` environment; its text (a `\documentclass[...]{kfupm-math-exam}` example) is code content |
| (sample) documented-source driver | kfupm-math-exam.dtx:34-40, 43, 109, 410 | `class.article`, `font.fontenc-t1`, `front.maketitle`, `dtx.doc` | same article head as the tex file; `\DocInput{kfupm-math-exam.dtx}` (43), `\StopEventually{}` (109), `\Finale` (410); no `\usepackage{doc}` is visible in the driver (dtx:34-35), not tested |
| (class) parent class and paper option | kfupm-math-exam.dtx:165-171 | `class.article`, `page.class-options` | `\PassOptionsToClass`, `\LoadClass[a4paper, 12pt]{article}` |
| (class) page geometry | kfupm-math-exam.dtx:173-180 | `page.geometry`, `sp.lengths` | paperheight=33cm, paperwidth=21.5cm, headheight=20pt, margin=2cm, tmargin=`\dimexpr 2cm - 10pt \relax`; `\addtolength{\footskip}{20pt}` |
| (class) header and footer | kfupm-math-exam.dtx:238-250 | `hf.fancyhdr` | `\setlength{\headheight}{10pt}`; `\fancyhf{}`; head L `\sffamily \small KFUPM`, C `Page \thepage ~of \pageref{LastPage}`, R `Term <term>`; foot L `/<dept>`, R `\sffamily\bfseries\thepage`; `\headrulewidth` and `\footrulewidth` 0.5pt; `\fancypagestyle{plain}` the same; `\pagestyle{fancy}` |
| (class) page reference in the head | kfupm-math-exam.dtx:242 | `xref.kernel` | `\pageref{LastPage}`; the class loads no `lastpage` package (nothing named `lastpage` in the source), so the label is not set by the class itself |
| (class) page style switched at begin document | kfupm-math-exam.dtx:329 | `hf.pagestyle-kernel` | `\AtBeginDocument{\pagestyle{myheadings}}`, after `\pagestyle{fancy}` at dtx:250 |
| (class) font switches in head and foot | kfupm-math-exam.dtx:241-245 | `mark.kernel`, `font.size-commands` | `\sffamily`, `\bfseries`, `\small` |
| (class) exam cover page | kfupm-math-exam.dtx:251-280 | `front.class-native`, `hf.pagestyle-kernel`, `sp.manual-space`, `box.fancybox`, `font.size-commands`, `mark.kernel`, `pg.break` | `\NewDocumentCommand{\coverpage}` with four optional arguments defaulting to the `course` `examtitle` `term` `examdate` options; `\thispagestyle{empty}`; `center`; `\large`; `\vspace*{2cm}` and `\vspace*{3cm}`; `\fbox{\bf\Huge EXAM COVER}`; counts of versions, questions and answers printed from options (dtx:266-268); `\vfill`; `\tiny` footer lines; `\newpage` |
| (class) version cover | kfupm-math-exam.dtx:281-324 | `front.class-native`, `box.fancybox`, `sp.rule`, `sp.manual-space`, `font.size-commands`, `mark.kernel`, `pg.break` | `\versioncover{n}`: `\thispagestyle{empty}`; two `\fbox` code boxes left and right with `\hfill` (288); fixed lines "math333", "exam 1", "182", "monday march 13", "Net Time Allowed: 120 minutes" (289-293); for n = 0 `MASTER VERSION` (299-303), else `Name:`, `ID:`, `Sec:` lines made with `\hrulefill` (305-309), "Check that this exam has `\underline{\thenumberofquestions}` questions" (313), the stored instructions (317); `\newpage` (319) |
| (class) page number text | kfupm-math-exam.dtx:321-322 | `num.counters` | `\renewcommand{\thepage}{...}` becomes a one-line head with fixed text "Term 182, math333, exam 1", `\hfill`, `\arabic{page}`, `\pagecount`, `\codestr`; `\setcounter{page}{1}`; calls the expl3 helpers listed under "Bespoke code" |
| (class) title hook | kfupm-math-exam.dtx:326-328 | `front.maketitle` | `\title{\coverpage}`, empty `\author` and `\date` |
| (class) instructions block | kfupm-math-exam.dtx:366-371 | `front.class-native` | `\instructions{#1}` stores a block, `\getInstructions` prints it |
| (class) counters | kfupm-math-exam.dtx:351-360 | `num.counters` | `\newcount\numberofversions`, `\newcounter{numberofquestions}`, `{numberofpages}`, `{examcodecounter}` with `\setcounter` |
| (class) figures | kfupm-math-exam.dtx:182, 236 | `fig.graphicx` | `\graphicspath{{figures/}}` |
| (class) maths and theorems | kfupm-math-exam.dtx:183-185, 194, 345-348 | `math.amsmath`, `math.amssymb`, `thm.amsthm`, `math.bm` | packages loaded, no `\newtheorem` in the class; `\R \N \Z \Q` as `\mathbb` aliases; `mathrsfs` |
| (class) tables | kfupm-math-exam.dtx:186-187 | `tbl.tabular`, `tbl.booktabs` | `array` and `booktabs` loaded, no table in the class |
| (class) pseudo-code | kfupm-math-exam.dtx:188-190, 332-343 | `alg.algorithm2e` | options `tworuled, linesnumbered, noend, noline`; `\SetKw{And}{and}` `\SetKw{Or}{or}` `\SetKw{To}{to}`; `\DontPrintSemicolon`; `\SetAlCapSty`, `\SetAlCapNameFnt{\scshape\hspace{.69em}}`; `\SetCommentSty` with `\footnotesize\ttfamily\textcolor{gray}` |
| (class) colour | kfupm-math-exam.dtx:191, 342 | `color.xcolor` | `gray` text colour |
| (class) lists | kfupm-math-exam.dtx:193 | `list.enumitem`, `sp.lengths` | option `shortlabels`; `\labelsep=.75cm` |
| (class) boxes and plots, loaded not called | kfupm-math-exam.dtx:197-199 | `box.tcolorbox`, `art.tikz` | `pgfplots` with `\pgfplotsset{compat=newest}`, `tcolorbox`; neither is used by any class macro |

## Bespoke code
The class is published (CTAN, TeX Live, MiKTeX), so none of this is zip-local bespoke code and none of it is counted as a blocker. It is listed so the file can be re-read if the class were treated as zip-local. The zip holds no `.cls`; README.txt:15 lists one, and `latex kfupm-math-exam.ins` writes it from the dtx (ins:27-28).

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\codestr`, `\l_concat_codenumber_str:nn` | kfupm-math-exam.dtx:384-400 | not counted (published class); if counted: no | expl3 string code that prints `MASTER` for 0, else the text `CODE` plus the last two digits of 100+n (`\str_range`); a computed printed value with no lib way |
| `\pagecount`, `\l_calc_pages_int:n` | kfupm-math-exam.dtx:372-381 | not counted; if counted: no | expl3 integer code for ceil(n/2); `\pagecount` ignores its argument and passes 15 (dtx:380) |
| `\renewcommand{\thepage}` line | kfupm-math-exam.dtx:321 | not counted; if counted: only with the two helpers above | `num.counters`, but its text calls `\codestr` and `\pagecount` and repeats fixed strings |
| `\coverpage`, `\versioncover` | kfupm-math-exam.dtx:251-324 | not counted; if counted: yes apart from the `\codestr` and `\pagecount` calls | compositions of kernel commands as in the component map |
| `\instructions`, `\getInstructions` | kfupm-math-exam.dtx:366-371 | not counted; if counted: yes | store a block, print it where called: inline the block; `\getInstructions` is declared with one parameter (369) and called with none (317), not tested |
| `\kme@sub`, `\kme@authorProcessed`, `\kme@authorsProcessed` | kfupm-math-exam.dtx:202-234 | dead code | never called; reads `\kfupmmathexam@name`, which no option declares (dtx:133-163); drop |
| `\nonl`, `\kfupmmathexam@capsty`, `\agacommfont` | kfupm-math-exam.dtx:334-343 | not counted; if counted: yes | `algorithm2e` hooks and `\newcommand` aliases |
| key options | kfupm-math-exam.dtx:128-169 | not counted; if counted: yes | `\DeclareStringOption` keys are the class options (parameters) |
| DocStrip installer | kfupm-math-exam.ins:25-29 | n/a | a TeX run (`\input docstrip`), not an outside tool; no typeset effect |

## Content-opaque
none (the `verbatim` text at kfupm-math-exam.tex:14-59 is code content; `pgfplots` is loaded at kfupm-math-exam.dtx:197 but nothing is drawn)

## Lib changes
- New ways proposed: none. (`class.kfupm-math-exam` is a class way, written plainly as the rubric says; `pgnum.lastpage` was considered for the head text at dtx:242 and not used, because the class does not load it.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
