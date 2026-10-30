yes

# 0864-exam-ltr: exam-ltr (typed-question exam builder, English, left-to-right)

- Unverified: read from the source, not compiled.
- Source: Source/0864-exam-ltr/ (origin: https://latextemplates.com/downloads/exam-ltr.zip; licence: LPPL-1.3c)
- Kind: exam
- Lib: v6
- Engine: pdfLaTeX-compatible (the sty loads only xcolor, tcolorbox with `skins` and `breakable`, expl3 and xparse, exam-ltr.sty:25-29; no fontspec; the CTAN page names pdfLaTeX, LuaLaTeX and XeLaTeX)
- Look carried by: preamble (a published CTAN package, `exam-ltr`, is loaded and parameterised from the preamble and body of main.tex:1-15; the vendored exam-ltr.sty is that package's CTAN-generated file, not a zip-local style)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
`yes`, and the whole answer rests on W1 for `exam-ltr`. The sample is `article` plus `geometry` plus one published package, `exam-ltr` (CTAN, in TeX Live and MiKTeX: ctan.org/pkg/exam-ltr read once; Nadeer Aljaroudi, LPPL 1.3c, v1.0, the same v1.0 2026/08/20 as exam-ltr.sty:23), which supplies a typed `Question` wrapper with `MC`, `TF`, `FillBlank`, `Matching`, `ShortAnswer`, `Essay` environments, student/teacher modes and a seeded shuffle. That is the lib way `exam.questions` (question-bank packages, the package is the parameter). main.tex defines no macro, counter or environment of its own (no `\newcommand`, `\def` or `\newenvironment` in main.tex), there is no artwork and no external tool, so an emitter writes `\usepackage{exam-ltr}` plus the mode switches and body calls and copies no zip-local logic.

Sensitivity: exam-ltr.sty is expl3 code that computes layout (width arithmetic, `\seq_shuffle:N`, answer-key accumulation). Had it been an unpublished zip-local style, it would be BESPOKE/class and irreducible. It is not, because the same package is on CTAN. I did not diff the vendored file against the CTAN file (nothing is downloaded here); its docstrip header names `exam-ltr.dtx` and its version string equals the CTAN version (exam-ltr.sty:7, 23). If the vendored file were found to be modified, the verdict would have to be re-read.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:1). Kernel class, not bundled in the zip, its source was not read.
- Class-native vocabulary used: none (no `\maketitle`, `abstract`, sectioning or `\bibliography`; the title is a hand-laid `center` block, main.tex:19-21). No page style is set, so the class default applies.
- Package-native vocabulary used (exam-ltr, way `exam.questions`; no package options exist, exam-ltr.sty has no `\DeclareOption`):
  - modes and switches: `\StudentMode` (main.tex:8; `\TeacherMode` is commented out at :9), `\ShowMarks` `\ShowDifficulty` `\ShowType` `\ShowCorrection` (main.tex:11-14), `\ExamID{7421}` (main.tex:15)
  - wrapper: `\begin{Question}{type}{difficulty}{marks}{instruction}` (main.tex:27, 55, 68, 83, 96, 107); `type` is one of a closed list of eight names (exam-ltr.sty:53-60)
  - `MC[cols]` with `\MCQuestion{text}{correct index}` and `\MCOption{text}` (main.tex:28-48)
  - `TF` with `\TFQuestion{text}{True|False}` (main.tex:56-61)
  - `FillBlank[true|false]` with `\WordBank[separator]{comma list}`, `\FillQuestion{text}{answer}`, `\Blank[width]` (main.tex:69-76)
  - `Matching[left fraction]` with `\MatchPair{left}{right}` (main.tex:84-89)
  - `ShortAnswer[true|false]` with `\ShortQuestion[lines]{text}{answer}` (main.tex:97-100)
  - `Essay[true|false]` with `\EssayQuestion[lines]{text}{answer}` (main.tex:108-110)
  - defined by the package but not used by the sample: `Ordering` with `\OrderQuestion` `\OrderOption` `\OrderAnswer` (exam-ltr.sty:601-787) and `ReadingPassage` (exam-ltr.sty:1078-1113)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | a4paper |
| paper size | main.tex:1 | `page.class-options` | a4paper |
| page geometry | main.tex:2 | `page.geometry` | margin=1in |
| exam question package (load) | main.tex:3; exam-ltr.sty:22-23 | `exam.questions` | package=exam-ltr v1.0 (2026/08/20), no options |
| modes and tag switches | main.tex:8-9, 11-14; exam-ltr.sty:69-81 | `exam.questions` | `\StudentMode`; `\ShowMarks`, `\ShowDifficulty`, `\ShowType` (print the `[Type] [Difficulty] [N marks]` tag, exam-ltr.sty:188-195), `\ShowCorrection` (answer boxes only with `\TeacherMode`, exam-ltr.sty:200-204) |
| seeded shuffle | main.tex:15; exam-ltr.sty:83-92, 290, 851 | `exam.questions` | `\ExamID{7421}`; seed = ID*1000 + question number; shuffles MC options and the matching right column |
| exam title | main.tex:19-21 | `sp.ragged` | `center` environment around the title line (no `\maketitle`) |
| exam title size | main.tex:20 | `font.size-commands` | `\Large` |
| exam title weight | main.tex:20 | `mark.kernel` | `\bfseries` |
| question header | main.tex:27, 55, 68, 83, 96, 107; exam-ltr.sty:137-206 | `exam.questions` | `Question{MC}{Medium}{4}{...}`, `{TF}{Easy}{2}`, `{FillBlank}{Medium}{4}`, `{Matching}{Medium}{4}`, `{ShortAnswer}{Easy}{3}`, `{Essay}{Hard}{10}`; bold "Question N:" label, bold instruction in a `\parbox`, right-aligned `\footnotesize` tag; sizes and skips are fixed in the package |
| multiple choice | main.tex:28-48; exam-ltr.sty:236-368 | `exam.questions` | `MC[4]` (four columns); `\MCQuestion{..}{1|2|3}`, four `\MCOption`; letter labels `a)`..; options shuffled by the seed |
| true/false | main.tex:56-61; exam-ltr.sty:390-451 | `exam.questions` | `TF` default style `bracket` (a `( )` box after each statement); `\TFQuestion{..}{True|False}` |
| fill in the blank | main.tex:69-76; exam-ltr.sty:464-515 | `exam.questions` | `FillBlank[true]` (word bank shown); `\WordBank[\qquad]{Sahara, Andes, ...}` (boxed list, separator optional argument); `\Blank` default width 4.25em |
| matching | main.tex:84-89; exam-ltr.sty:812-930 | `exam.questions` | `Matching` default `[0.5]`; four `\MatchPair`; left items `1)`.., right items `a)`.. in shuffled order |
| short answer | main.tex:97-100; exam-ltr.sty:1017-1076 | `exam.questions` | `ShortAnswer[true]` (ruled lines); `\ShortQuestion[2]` and `[1]` (number of ruled lines, capped at 2) |
| essay | main.tex:108-110; exam-ltr.sty:948-999 | `exam.questions` | `Essay[true]` (ruled lines); `\EssayQuestion` default 4 lines |
| manual break in an answer string | main.tex:109 | `sp.manual-space` | `\\[1ex]` inside the answer argument (shown only in teacher mode with corrections) |
| answer-key box (teacher mode only) | exam-ltr.sty:94-131, 200-204 | `box.tcolorbox` | loaded dependency inside `exam.questions`, not emitted separately: enhanced, breakable, colback=white, colframe=black, arc=0pt, boxrule=1pt, top/bottom/left/right=10pt, title "Answer Key" attached top left (xshift=5mm, yshift=-3.5mm) |
| reading-passage box (not in sample) | exam-ltr.sty:1078-1113 | `box.tcolorbox` | same dependency; titled box, `fontupper=\linespread{1.4}\selectfont`, title attached top centre |
| named colours | exam-ltr.sty:25, 98-107 | `color.xcolor` | dependency only: white and black named colours inside the tcolorbox keys; no colour is set by main.tex |

Not set by main.tex or the package, so no row: fonts (Computer Modern default), headers and footers, language, front matter, abstract, contents, headings, math display, floats, tables, captions, code, bibliography, index, cross-references. The `$\Rightarrow$` in answer lines (exam-ltr.sty:347, 447) is inline kernel math inside the package.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| macros, environments, counters in the sample | main.tex (none; only `\usepackage` lines at :2-3) | n/a | nothing to reduce |
| `exam-ltr.sty` as a whole (expl3 environments, seeded shuffle, width arithmetic, answer accumulator) | exam-ltr.sty:22-1115 | n/a, published (CTAN v1.0, TeX Live, MiKTeX) | emitted as `\usepackage{exam-ltr}`, never copied; its internals are not zip-local bespoke because W1 holds |
| `\PrintNumber` (`\number#1`), the only `\newcommand` in the sty | exam-ltr.sty:35 | n/a, inside the published package | none needed |
| undefined message names on error paths (`ord`/`no-options`, `matching`/`empty-pair`, `odd-number`; only `mc`/`no-options` is created at :370) | exam-ltr.sty:662, 835, 840, 370 | n/a, not reached by the sample (every MC has options, matching has pairs) | none needed |

## Content-opaque
none

## Lib changes
- New ways proposed: none. The package is placed in `exam.questions` ("other question-bank packages ... the package is the parameter"; pdfLaTeX-compatible). considered: a separate line for exam-ltr, rejected because the engine tag is `pdf` and the type is the same. The lib's `exam.rtl-questions` has the same typed `Question` vocabulary but is tagged `xe/lua` with Arabic labels; this zip's labels are English and its engine is pdf. Whether the two lines should be one is left to the consolidator.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Note for the emitter: the package is dated 2026, so an older TeX distribution may lack it; ship `exam-ltr.sty` beside the document. Option and match order depend on the TeX engine's random generator and expl3 version (`\sys_gset_rand_seed:n`, exam-ltr.sty:85, 91), so the same `\ExamID` is reproducible only on the same toolchain (not tested).
