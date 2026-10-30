yes

# 0243-exam-zh: exam-zh (Chinese exam paper, first example)

- Unverified: read from the source, not compiled.
- Source: Source/0243-exam-zh/ (origin: https://latextemplates.com/downloads/exam-zh.zip; licence: LPPL-1.3c, per the manifest and README.md:35)
- Kind: exam
- Lib: v3
- Engine: needs XeLaTeX (README.md:24-25 "requires XeLaTeX ... it will not compile under pdflatex"; the CTAN page for exam-zh says it is written with expl3 and requires XeLaTeX)
- Look carried by: class (main.tex:5 loads `exam-zh` and sets no preamble at all; the sample only uses the class's own commands)
- Class origin: tex-distribution-unbundled (README.md:13-17: the class is "deliberately NOT included" and ships with TeX Live; ctan.org/pkg/exam-zh read once: on CTAN, LPPL 1.3c, v0.3.6)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex and README.md; the class source `exam-zh.cls` is not in the zip and was not read)

## Verdict
The look is carried entirely by the published class `exam-zh`. The zip adds no preamble, no `\newcommand`, `\def`, counter or environment of its own (main.tex has no definitions at all); it only calls the class's vocabulary and, in two lines, its `\examsetup` key-value interface. Every part of the page is therefore one class way plus kernel commands, with no bespoke code and no artwork. This is class-dimension evidence (look carried by class), not evidence about component ways. Caveat: the class source was not read, so what it loads itself (fonts, geometry, header/footer) is inferred only from the commands the sample uses.

## Blockers
none

## Class setting
- Class: `class.exam-zh` options: none given (main.tex:5 is `\documentclass{exam-zh}`). Settings go through the class's key-value command `\examsetup{...}`: `question/index = 1` (main.tex:80, main.tex:101), and, commented out, `question/show-answer = true` and `solution/show-solution = show-stay` (main.tex:8-11; README.md:29-30 describes the toggle).
- Class-native vocabulary used (all from main.tex; the class source was not read, so meanings come from the sample's usage and README.md:3-6 only):
  - Title block: `\title{}` `\subject{}` `\maketitle` (main.tex:16-18), `\information{}` (main.tex:20-24)
  - Notices: `notice` environment with `\item` (main.tex:26-30)
  - Sectioning: `\section{}` used for the three question groups (main.tex:35, 79, 100)
  - Questions: `question` environment (main.tex:37, 47, 57, 67, 82, 86, 90, 94), `choices` environment with `\item` options (main.tex:39-44, 49-54, 59-64, 69-74), `\paren[B]` answer bracket with a letter (main.tex:38, 48, 58, 68), `\fillin[4]` fill-in blank with the answer in the optional argument (main.tex:83, 87, 91, 95)
  - Worked problems: `problem[points = 15]` environment (main.tex:103, 129, 159), `solution` environment (main.tex:112, 138, 168), `\score{5}` per-step partial-credit mark (main.tex:114 and following)
  - Version note: the README says the zip's site carries v0.2.6 (README.md:16) while CTAN lists v0.3.6; key and command names could differ between versions (not checked).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:5 | `class.exam-zh` | no options |
| class settings interface | main.tex:80, 101 (active); main.tex:8-11 (commented) | `class.exam-zh` | `\examsetup{question/index = 1}`; commented `question/show-answer = true`, `solution/show-solution = show-stay` (teacher/student answer toggle) |
| page geometry, header/footer, fonts, page numbers | none in sample (no preamble) | `class.exam-zh` | class defaults, not set by the sample; class source not read, so not described |
| Chinese language support | main.tex:1-200 (Chinese text, no language or font package in the sample); README.md:24-25 ("the class's CJK font handling") | `lang.cjk` | supplied by the class, nothing set in the sample; the package behind it (`ctex`/`xeCJK`) is not confirmed because the class source was not read |
| title, subject | main.tex:16-18 | `front.maketitle` | `\title{2024年春季期中考试}`, `\maketitle` |
| subject line, candidate-info line | main.tex:17, 20-24 | `front.class-native` | `\subject{数学}`; `\information{...}` carries three fill-in fields |
| notice block | main.tex:26-30 | `front.class-native` | `notice` environment, three `\item`s |
| section headings | main.tex:35, 79, 100 | `head.class-native` | `\section{...}`; heading look and any numbering are the class's, not set by the sample |
| multiple-choice question | main.tex:37-45 and 3 more | `class.exam-zh` | `question` environment + `choices` environment + `\paren[letter]` |
| fill-in-the-blank question | main.tex:82-84 and 3 more | `class.exam-zh` | `question` environment + `\fillin[answer]` (answer in the optional argument, content) |
| worked problem with points | main.tex:103-127 and 2 more | `class.exam-zh` | `problem[points = N]` + `solution` environment |
| per-step score marks | main.tex:114-124 and following | `class.exam-zh` | `\score{n}` |
| question numbering | main.tex:80, 101 | `class.exam-zh` | `question/index = 1` (via `\examsetup`) |
| answer key on/off | main.tex:8-11 (commented) | `class.exam-zh` | `question/show-answer`, `solution/show-solution = show-stay` |
| sub-question lists | main.tex:106-110, 113-125 and 4 more | `list.kernel` | `enumerate` with `\item`; label style is the class's (not set by the sample) |
| underline blanks in the info line | main.tex:21-23 | `mark.kernel` | `\underline{\hspace{6em}}`, `\hspace{4em}` (the `\hspace` part is `sp.manual-space`) |
| manual spacing | main.tex:21-23, 32 | `sp.manual-space` | `\hspace{6em}`, `\hspace{4em}`, `\vspace{1em}` |
| math in questions | main.tex:58, 68, 114, 152 | `math.amsmath` | `\dfrac` `\frac` `\sqrt` `\mathbb` in inline maths; no math package in the sample, so the class must supply it (inferred, class source not read); the equations themselves are content |
| upright pi | main.tex:87 | `font.unicode-math` | `\uppi`, a symbol the sample uses without loading anything; inferred to come from the class's math setup (class source not read); XeLaTeX-only way |

Considered and not used: `exam.questions` (the `exam`/`examdesign` environments are a different package from exam-zh's `question`/`choices`/`problem`/`solution`; per the v3 change log a class's own exam vocabulary is recorded under its class way).

## Bespoke code
none. The sample defines no macro, environment, counter or conditional (checked: no `\newcommand`, `\def`, `\newenvironment`, `\newcounter` in main.tex). The class itself is published (W1) and written in expl3 by its authors; it is one way, not zip-local code.

## Content-opaque
none (the maths and the Chinese text are content; there is no figure, table or drawing in the sample)

## Lib changes
- New ways proposed: none (`class.exam-zh` is a class way and needs no proposal; its vocabulary is recorded under "Class setting")
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
