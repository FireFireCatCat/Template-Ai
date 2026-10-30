yes

# 0133-exam-lite: exam-lite (exam / midterm starter)

- Unverified: read from the source, not compiled.
- Source: Source/0133-exam-lite/ (origin: https://latextemplates.com/downloads/exam-lite.zip, repackaging https://github.com/firefly-cpp/exam-lite-latex per ATTRIBUTION.txt:4; licence: CC-BY-SA-4.0, ATTRIBUTION.txt:3)
- Kind: exam
- Lib: v2
- Engine: pdfLaTeX-compatible (the sample uses nothing engine-specific; the class source was not read, so the class's own requirements are not established)
- Look carried by: mixed (the published class `exam-lite` carries the exam look; the sample's preamble overrides the class hook `\aboutexam` at main.tex:7-20 with fancyhdr declarations)
- Class origin: tex-distribution-unbundled (the zip holds no `.cls`; `exam-lite` is a published package: CTAN `/macros/latex/contrib/exam-lite`, version 2023-02-06, also TeX Live and MiKTeX package `exam-lite`; one ctan.org/pkg read plus one follow-up read)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip is two files: ATTRIBUTION.txt, 10 lines, and main.tex, 71 lines)

## Verdict
The look is carried by the published class `exam-lite` (CTAN, TeX Live, MiKTeX), which the zip does not bundle, so its source was not read and it counts as one way, `class.exam-lite`, with its native vocabulary recorded below. The only code the sample adds is one `\renewcommand{\aboutexam}` (main.tex:7-20), whose whole body is `fancyhdr` declarations, a `tabular` wrapper and kernel spacing, so it is reducible to lib ways. The question commands are class-native and need one proposed class-native way, `class.exam-lite`, parallel to `fig.class-native`. No `ART`, `EXTERNAL`, `UNMAPPED` or irreducible bespoke item is visible in the sample. The residual uncertainty is what the unread class loads and computes internally (for example the automatic point total the CTAN page mentions); that is covered only because the class is published.

## Blockers
none

## Class setting
- Class: `class.exam-lite` options: `english` (language; the sample comment lists `slovene, english`), `exam` (document kind; the comment lists `exam, midterm, seminar`) (main.tex:5)
- Class-native vocabulary used: front block `\subject` `\academicyear` `\studyprogram` `\examid` `\location` `\subacronym` `\writingtimeminutes` (main.tex:25-32), `\instructionstext{...}` (main.tex:34-41), `\makefirstpage` (main.tex:43), `\makenextheaders` (main.tex:44), `\aboutexam{...}` hook (main.tex:7, redefined), `\question{text}{points}{vspace cm}` (main.tex:48, 50, 58, 64), `\longquestion{text}{points}{vspace}` (main.tex:54), `\alinea{text}{points}{vspace}` inside `enumerate`/`itemize` (main.tex:60-61); the `\newdate` call at main.tex:30 is the `datetime` package's command, which the class is presumed to load (not verified, class unread). The argument roles are taken from the sample's own comments at main.tex:47, 52-53, 56-57.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:5 | `class.exam-lite` | options `english`, `exam`; source not read |
| language | main.tex:5 | `class.exam-lite` (option) | `english`; which package the class loads for it is not established (class unread) |
| exam kind (exam / midterm / seminar) | main.tex:5 | `class.exam-lite` (option) | `exam` |
| first-page head and foot style | main.tex:9-13 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\fancyfoot{}` (all fields cleared), `\headrulewidth`=0pt, `\footrulewidth`=0pt |
| head height | main.tex:14 | `hf.fancyhdr` | `\setlength{\headheight}{85pt}` (a fancyhdr parameter) |
| right head field holding the exam info block | main.tex:15-18 | `hf.fancyhdr` | `\fancyhead[R]{...}` with `\leavevmode`, `\large`, argument `#1` supplied by the class |
| head block layout | main.tex:16-18 | `tbl.tabular` | `\begin{tabular}[t]{l@{}} #1 \end{tabular}`, one left column, no trailing space |
| head block font size | main.tex:15 | `font.size-commands` | `\large` |
| spacing after the head block | main.tex:8, 19 | `sp.manual-space` | `\vspace*{2\baselineskip}`; `\noindent` and `\leavevmode` taken as the same kernel spacing family (judgement call, no value) |
| exam metadata block | main.tex:25-29, 31-32 | `front.class-native` | subject, academic year, study program, exam id, location, acronym, writing time (minutes) as string and number arguments |
| exam date | main.tex:30 | `front.datetime` | `\newdate{examdate}{14}{01}{2027}`; loading package inferred from the command, class unread |
| instructions text | main.tex:34-41 | `front.class-native` | `\instructionstext{<list>}`; the list inside is the next row |
| instructions list | main.tex:35-40 | `list.kernel` | `enumerate` with four `\item`s |
| first-page and next-page headers | main.tex:43-44 | `front.class-native` and `hf.class-native` | `\makefirstpage` builds the exam head block; `\makenextheaders` sets the running heads of later pages |
| page counter reset | main.tex:45 | `pgnum.pagenumbering` | `\setcounter{page}{1}` |
| question (points beside it) | main.tex:48, 50, 58, 64 | `class.exam-lite` | `\question{text}{points}{vspace in cm}`, e.g. `{2}{1}`; points `0` on the multi-part lead-in (main.tex:58) |
| long question (points below it) | main.tex:54 | `class.exam-lite` | `\longquestion{text}{points}{vspace}` = `{5}{3}` |
| sub-question inside a list | main.tex:60-61 | `class.exam-lite` | `\alinea{text}{points}{vspace}` = `{3}{2}`, `{2}{2}` |
| roman-labelled list | main.tex:59-62 | `list.enumerate-pkg` | `\begin{enumerate}[i]`: label template in the optional argument; whether the class loads `enumerate` or `enumitem[shortlabels]` is not established (class unread, so `list.enumitem` is the alternative) |
| lettered answer choices | main.tex:65-69 | `list.kernel` | `enumerate` with `\item[a)]`, `\item[b)]`, `\item[c)]` (kernel optional labels) |
| inline maths | main.tex:48, 61, 66-68 | (content, no way) | `$n$`, `$V$`, `$E$`, `$\mathcal{O}(\log n)$`: kernel inline maths, content not template |
| institution logo | main.tex:1-3 | (dropped by the sample) | the upstream `\aboutexam` calls `\includegraphics` through `\ImagePath{...}`; the sample removes it and ships no image |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\aboutexam}[1]{...}` (replaces a class hook, one argument) | main.tex:7-20 | yes | `hf.fancyhdr` (`\fancyfoot{}`, `\headrulewidth`=0pt, `\footrulewidth`=0pt, `\pagestyle{fancy}`, `\fancyhf{}`, `\headheight`=85pt, `\fancyhead[R]`) + `tbl.tabular` (`[t]`, `{l@{}}`) + `font.size-commands` (`\large`) + `sp.manual-space` (`\noindent`, `\leavevmode`, `\vspace*{2\baselineskip}`). No counter, conditional, `\def` or box code. How the class calls it (one argument, the exam info block) is the class's contract and was not read. |
| zip-local `.cls` / `.sty` | none present | n/a | `exam-lite.cls` is not in the zip; it is the published package named in Class origin |

## Content-opaque
none (no figure, no table float, no TikZ or picture code in main.tex; the only picture the upstream class draws, the logo, is removed at main.tex:1-3)

## Lib changes
- New ways proposed: `class.exam-lite` (a published class's own exam-question commands; pdfLaTeX-compatible as far as the sample shows). W1: the class `exam-lite` is published (CTAN, TeX Live, MiKTeX). W2: behaviour is chosen by arguments only: text, integer points, vspace in cm (main.tex:47-61). W3: serves any exam's questions, not one document. W4: an emitter writes `\question{..}{..}{..}`, `\longquestion{..}{..}{..}` and `\alinea{..}{..}{..}` as body wrappers around a node's content. Searched `exam.` and `*.class-native` in the lib: `exam.questions` names the `exam`/`examdesign` packages, `exam.rtl-questions` and `exam.schooldocs` are other packages with their own lines; the lib's convention for a class's own commands is a `*.class-native` way (`fig.class-native`, `front.class-native`, `thm.class-native`), so no existing line fits. Considered: `exam.questions` (a different package's commands; not stretched).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
