# Pat's Resume

A dense single-column academic/technical resume: education entries with
optional GPA, a `\tech{}` wrapper for flagging technical roles, inline
`\tools{}` tags per bullet, and dedicated Publications/Honours sections.
Upstream is CTAN's `pats-resume`, by Patrick Benito.

## Files

- `main.tex` — the CV. Ships with TeX Live, so `pats-resume.cls` is not
  bundled here.

## Building

    pdflatex main
    pdflatex main

Two passes resolve the layout; there is no bibliography.

## Licence

**MIT**, © Patrick Benito (2025). Full licence text is on CTAN at
https://ctan.org/pkg/pats-resume. MIT does not require attribution in the
download, but credit is due here: thank you, Patrick Benito.

The starter content is upstream's own example — already written as
plausible (if deliberately whimsical — "Techland", "Phosphorus Valley")
placeholder content rather than lorem ipsum — with one change: the
LinkedIn and GitHub handles in upstream's example were the author's own
real accounts, swapped here for generic placeholders.
