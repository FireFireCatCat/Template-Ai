# Worksheet

A course-worksheet layout with an auto-numbered title, a
`scrlayer-scrpage`-based header (author and course name), and an
`exercise` environment that can annotate each question with a maximum
score, a difficulty level, learning-target references, and where the
question previously appeared — each independently togglable.

## Files

- `main.tex` — the worksheet. Start here.
- `worksheet.sty` — the vendored package (not on a default TeX Live
  install; distinct from the GitHub `kryzar/worksheet` package shipped
  elsewhere on this site under the `worksheet-kryzar` slug — same
  generic name, unrelated authors and code).

## Building

    pdflatex main

XeLaTeX also works and is the upstream's own recommendation if you want
to set the sans-serif font to Helvetica Neue or Raleway, but nothing in
the package itself requires it.

## Exercise annotations

`\begin{exercise}[\score{n}\easy|\medium|\hard\learningtargets{...}
\occurrence{...}]` attaches four optional pieces of metadata to a
question. Which of them actually print is controlled independently:
`\worksheetShowScore`/`\worksheetHideScore`, and the equivalent
`...LearningTargets`, `...Difficulty`, `...Occurrence` pairs.

## Licence

LPPL (latest version), © 2018 Benjamin Zöllner.
Source: https://ctan.org/pkg/worksheet
