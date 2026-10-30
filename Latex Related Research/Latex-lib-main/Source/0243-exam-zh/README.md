# exam-zh

A modern Chinese exam layout: title block with name/class/seat-number
fields, a numbered notice section, multiple-choice questions with letter
answer marking, fill-in-the-blank questions, and worked problems with
per-step partial-credit scoring and a toggleable teacher answer key.

## Files

- `main.tex` — the exam. Start here (this is the upstream package's own
  first-example, a genuine Chinese high-school maths mid-term).

## The class is deliberately NOT included

`exam-zh.cls` ships with every modern TeX distribution, so this download
does not bundle a copy. This site's TeX Live currently carries v0.2.6; if
you need a newer feature, get the latest from CTAN:
https://ctan.org/pkg/exam-zh

## Building

    xelatex main

This template requires **XeLaTeX** (Chinese typesetting via the class's
CJK font handling) — it will not compile under pdflatex.

## Teacher / student mode

Uncomment the `\examsetup{question/show-answer = true, solution/show-solution
= show-stay}` block near the top to typeset the answer key and worked
solutions into the same PDF.

## Licence

`exam-zh` is licensed **LPPL-1.3c**, © Xia Kangwei and Zeping Lee. The
class is not redistributed here; see https://ctan.org/pkg/exam-zh.

This starter document is the upstream package's own example, used as-is
under the same LPPL terms.
