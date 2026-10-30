# exam-ltr

A multi-question-type exam builder: Multiple Choice, True/False, Fill in
the Blank, Matching, Short Answer, Essay, Ordering and Reading Passage,
all driven by one `Question` wrapper with a type, difficulty, mark value
and instruction line. A student/teacher mode switch shows or hides answer
keys from the same source file, and `\ExamID{}` fixes the random seed so
shuffled multiple-choice/matching order is reproducible.

## Files

- `main.tex` — the exam. Start here.
- `exam-ltr.sty` — the vendored package (extracted from the upstream
  `.dtx`/`.ins` source via `tex exam-ltr.ins`; not on a default TeX Live
  install).
- `LICENSE.txt` — upstream LPPL licence.

## Building

    pdflatex main

## Modes

- `\StudentMode` / `\TeacherMode` — hide or show answer keys.
- `\ShowMarks`, `\ShowDifficulty`, `\ShowType` — print the `[N marks]
  [Difficulty] [Type]` tag after each question's instruction line.
- `\ShowCorrection` — show answer boxes (only with `\TeacherMode`).
- `\ExamID{number}` — fixes the seed for shuffled options/matching order,
  so the same ID always reproduces the same layout.

## Question types demonstrated

Multiple Choice, True/False, Fill in the Blank, Matching, Short Answer and
Essay. The upstream package also supports Ordering and Reading Passage —
see `exam-ltr.pdf` in the CTAN distribution for their syntax.

## Licence

LPPL-1.3c or later, © 2026 Nadeer Aljaroudi.
Source: https://ctan.org/pkg/exam-ltr
