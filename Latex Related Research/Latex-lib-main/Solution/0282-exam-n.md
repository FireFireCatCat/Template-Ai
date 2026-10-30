yes

# 0282-exam-n: exam-n (degree-examination class, Norman Gray, University exam paper with banner, course codes, per-question authors and part marks)

- Unverified: read from the source, not compiled.
- Source: Source/0282-exam-n/ (origin: https://latextemplates.com/downloads/exam-n.zip; licence: LPPL-1.3c, README.md:35-36 and the manifest)
- Kind: exam
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:21-23 builds with `pdflatex main`; the sample loads no fontspec or Lua package, main.tex:4-20; the class source was not read, so what the class itself loads is not checked)
- Look carried by: class (the published `exam-n` class lays out the exam header, the questions, the part marks and the solutions; main.tex sets option values, setter strings and one placeholder box, and adds `siunitx`)
- Class origin: tex-distribution-unbundled (README.md:15-19 says the class is not bundled; `ctan.org/pkg/exam-n` read once: exam-n by Norman Gray, version 1.4.0, LPPL-1.3c, in TeX Live and MiKTeX)
- Main file: main.tex (other samples: none)
- Read: main yes (all 116 lines), zip-local classes and styles none present (the zip holds only main.tex and README.md; `exam-n.cls` is not in it and no TeX installation was available to read it)

## Verdict
The look is carried by one published class, `exam-n`, that ships with the TeX distribution, so it is `class.exam-n` plus the option `draft`, the class's own setter commands (`\exambanner`, `\coursetitle`, `\examdate`, ...) and its question vocabulary (`question`, `\part`, `\partmarks`, `solution`, `\shout`). The only code the zip adds is one `\renewcommand{\UniLogo}` that turns a text placeholder into an empty box with a rule above and below; it has no conditional, counter or algorithm and reduces to `box.minipage` + `sp.rule` + `sp.manual-space`. There is no artwork and no outside tool. Caveat: `exam-n.cls` was not read, so everything the class does internally is taken from the README and the sample; this is evidence about the class dimension, not about the component ways. If a reviewer counts the `\UniLogo` override as irreducible, the answer flips to `no`.

## Blockers
none

## Class setting
- Class: `class.exam-n` options: `draft` (main.tex:4). README.md:27-31 says `draft` typesets `solution` blocks and `\shout{}` notes inline and stamps a "DRAFT + SOLUTIONS" banner on every page, and `final` gives the clean version with no solutions and no banner; main.tex:1-3 says the same. No other option is passed. The base class the exam-n source loads is not known (not read).
- Class-native vocabulary used:
  - header setters (preamble): `\exambanner` (main.tex:6), `\degreedescriptions` with `\\` between lines (main.tex:7), `\schoolcoursecode` (main.tex:8), `\universitycoursecode` (main.tex:9), `\coursetitle` (main.tex:10), `\examdate` (main.tex:12), `\examtime` (main.tex:13), `\rubric` (main.tex:15-16), `\numquestions` (main.tex:18); printed by `\maketitle` (main.tex:36; README.md:3-6).
  - questions (body): `\begin{question}{<marks>}` (main.tex:38, 63, 90) with a per-question `\author{...}` (main.tex:38, 63, 90; README.md:6-7), `\part` (main.tex:39, 48, 56, 67, 75, 82, 95, 101, 109), `\partmarks{n}` (main.tex:42, 50, 57, 69, 76, 84, 103, 110) and its starred form `\partmarks*{5}` (main.tex:96; its effect is not documented in the sample or README), `solution` environment (main.tex:43-46, 51-54, 58-60, 70-73, 77-80, 85-87, 104-107, 111-113), setter note `\shout{...}` (main.tex:91). README.md:8-9: `\partmarks{n}` puts the mark of each part in the margin with a running total.
  - `\UniLogo{<width>}` is a class-internal macro (named at main.tex:23, 29), redefined in the preamble; see Bespoke code.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:4 | `class.exam-n` | option `draft` |
| exam header block (banner, degree lines, course codes, title, date and time, rubric, logo box) | main.tex:6-18, 36; README.md:3-6 | `front.class-native` | setters `\exambanner{Examination for the degree of Bachelor of Science}`, `\degreedescriptions{Physics 3\\Physics with Astrophysics 3}`, `\schoolcoursecode{PHYS3021}`, `\universitycoursecode{PHYS3021}`, `\coursetitle{Classical Mechanics}`, `\examdate{Monday, 8 December 2026}`, `\examtime{9:30 -- 11:30}`, `\rubric{...}`, `\numquestions{3}`; `\maketitle` |
| inline emphasis in the rubric | main.tex:15 | `mark.kernel` | `\textbf{all}` |
| draft banner on every page | README.md:27-29; main.tex:4 | `hf.class-native` | "DRAFT + SOLUTIONS" stamp chosen by the class option `draft`; the mechanism inside the class is not read |
| question blocks | main.tex:38, 63, 90 | `class.exam-n` | `question` environment, one argument = total marks (20, 30, 25) |
| per-question setter | main.tex:38, 63, 90; README.md:6-7 | `class.exam-n` | `\author{J. Halliday}` inside `question` |
| parts | main.tex:39, 48, 56, 67, 75, 82, 95, 101, 109 | `class.exam-n` | `\part` followed by the part text; a question may open with a lead-in paragraph (main.tex:64-65) |
| part marks in the margin, running total | main.tex:42, 96; README.md:8-9 | `class.exam-n` | `\partmarks{6}`, `\partmarks{8}` ...; starred `\partmarks*{5}` |
| worked solutions | main.tex:43-46 and 7 more blocks (see Class setting); README.md:27-28 | `class.exam-n` | `solution` environment, shown under `draft`, hidden under `final` |
| setter note | main.tex:91; main.tex:1-3 | `class.exam-n` | `\shout{...}`, printed only under `draft` |
| physical units | main.tex:20, 48, 49, 52, 53, 59 | `mark.siunitx` | `\usepackage{siunitx}`; `\SI{0.2}{\metre}`, `\SI{4}{\second^{-2}}`, `\si{\second^{-1}}`, `\si{\second}`, `\SI{3.14}{\second}`; README.md:9 says the class wires siunitx in, so the line at main.tex:20 may repeat a load (class not read) |
| display equation | main.tex:97-99 | `math.kernel` | `\[ I = \tfrac{1}{3}mL^2. \]`, unnumbered |
| inline maths | main.tex:39-41, 44-45, 48-49, 52-53, 59, 64-65, 67-68, 72, 75, 78-79, 82, 86, 92, 101, 105-106, 112 | `math.kernel` | `$...$`; the equation text is content |
| `\tfrac` | main.tex:98, 105 | `math.amsmath` | `\tfrac` is an amsmath command; the sample loads no amsmath, so the class (or siunitx) must supply it (class not read) |
| inline spacing | main.tex:52, 59, 78, 79 | `sp.manual-space` | `\,` and `\ ` in the text of solutions |
| page geometry, fonts, colour, running heads and numbers, question and part numbering | none in main.tex | `class.exam-n` | all set inside the class; main.tex sets none of them (class source not read) |

Not defined or used by the sample: lists, headings, floats, tables, captions, code, boxes (other than the `\UniLogo` box below), bibliography, index, hyperlinks, cross-references, footnotes, theorems, language packages.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\UniLogo}[1]{\vbox to 15.5mm{\hrule \vss \hbox to #1{\hss\hss} \vss \hrule}}`: replaces the class's "no logo available" text placeholder with an empty box of width #1 and height 15.5mm, ruled at top and bottom (scope: preamble) | main.tex:22-33 | yes, with a caveat | One static box and two rules, no conditional, counter or computation. Written with lib ways: `box.minipage` (`\parbox[c][15.5mm]{#1}{...}`) around `sp.rule` (`\hrule` top and bottom) and `sp.manual-space` (`\vfill` between). The emitter prints this one preamble line after the class load. Caveat: how the class calls `\UniLogo` (what #1 is, the baseline alignment) is in `exam-n.cls`, not read; the sample's own comment (main.tex:22-28) says the text is "baked into the class". The cleaner route, if the template supplies a logo, is to pass the logo through the class and omit the override; the class command for that is not shown in the sample. |
| the class's internal macros, counters and conditionals (question and mark counters, draft and final switches, `\maketitle`) | exam-n.cls, not in the zip | not assessed | published with the class (CTAN, TeX Live); under the rubric's published-class ruling an emitter calls the class commands and copies nothing |

No text addressed to an AI was found in main.tex or README.md (the comments at main.tex:1-3 and 22-28 are ordinary notes about the draft option and the logo box).

## Content-opaque
none

## Lib changes
- New ways proposed: none.
- Judgement for the consolidator: the exam-n question vocabulary (`question`, `\part`, `\partmarks`, `solution`, `\shout`) is recorded under `class.exam-n`, not under `exam.questions`, because that way names the `exam` and `examdesign` packages and exam-n is a different class with its own commands (the same call as `class.exam-lite`, lib v3 change log).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
