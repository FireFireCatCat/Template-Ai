# exam-n

A degree-examination class built for the structured, multi-field exam
headers used by UK university departments: exam banner, degree
descriptions, school/university course codes, date/time and rubric, all
laid out by `\maketitle`. Each question can carry its own `\author{}` (for
exams assembled from a bank of questions set by different people),
`\partmarks{n}` puts the mark for each part in the margin with a running
total, and `siunitx` is wired in for physics units.

## Files

- `main.tex` — the exam. Start here.

## The class is deliberately NOT included

`exam-n.cls` ships with every modern TeX distribution, so this download
does not bundle a copy. If your distribution does not have it:
https://ctan.org/pkg/exam-n

## Building

    pdflatex main

## Draft vs final

`\documentclass[draft]{exam-n}` (used here) typesets `\begin{solution}`
blocks and `\shout{}` setter notes inline, and stamps a "DRAFT + SOLUTIONS"
banner on every page — useful while writing the paper. Switch to
`\documentclass[final]{exam-n}` to produce the clean version handed to
candidates, with no solutions and no banner.

## Licence

`exam-n` is licensed **LPPL-1.3c**, © Norman Gray. The class is not
redistributed here; see https://ctan.org/pkg/exam-n.

This starter document is a minimal example written for latextemplates.com
and carries no additional restrictions.
