# esami

An exam-construction package: multiple-choice questions with shuffled
answer order, randomised numeric parameters drawn per compile, and a
per-question points tally with a running total. Built by the upstream
authors around generating several exam VERSIONS from a bank of exercise
files — this starter runs that same machinery for a single version.

## Files

- `main.tex` — the exam driver. Start here.
- `mcq-dice.tex`, `mcq-median.tex` — one multiple-choice question each.
- `problem-stderr.tex`, `problem-coinflip.tex` — one worked fill-in problem
  each, with randomised numeric parameters.
- `esami-xyz.cfg` — page layout, title-block fields and instruction text
  (edited from the upstream template — see below).
- `esami.sty`, `es-UKenglish.lng` — the vendored package (not on CTAN's
  default TeX Live install path used here).

## Building

    pdflatex main

## How exercises are organised

Each question lives in its own file and is pulled into the exam with
`\esercizi{filename}`. This is not a cosmetic choice: `\esercizi{}` shows
exactly ONE `\newproblem{}` block from the file it reads (it is a variant
bank for generating different randomised exam versions, not a container of
"every exercise in this file") — so one file per question is how the
package expects to be used. Writing exercises directly inline in `main.tex`
instead of through `\esercizi{}` was tried first and reliably corrupted the
class's internal list state the moment a multiple-choice section was
followed by a worked-problem section in the same document; going through
`\esercizi{}` with separate files (as the upstream examples themselves
always do) avoids it entirely.

To add a question, drop a new `.tex` file with one `\newproblem{...}` block
next to `main.tex` and add its name to an `\esercizi{...}` call.

## Multiple exam versions

Set `\numcompiti` above 1 to generate several shuffled/randomised versions
in one PDF (the upstream use case) — each version gets a fresh seed via
`\FPeval\seme{...}`, a full answer-order shuffle (`\permuta`), and fresh
random numeric parameters.

## Instruction text

The stock `esami-xyz.cfg` ships literal placeholder instruction text
("Write here your instructions" / "two" / "three" and "Some other
instructions."). This copy replaces `\istruzionii`/`\istruzioniii` with real
exam instructions — edit those two macros in `esami-xyz.cfg` for your own
exam.

## Licence

LPPL (LaTeX Project Public License, version 1 or later), per the header of
`esami.sty`: "This program can be redistributed and/or modified under the
terms of the LaTeX Project Public License ... either version 1 of the
License, or (at your option) any later version." © 2008-2024 Grazia
Messineo and Salvatore Vassallo. Source: https://ctan.org/pkg/esami
