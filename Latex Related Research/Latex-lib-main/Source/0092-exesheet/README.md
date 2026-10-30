# exesheet

An exercise/exam-sheet package with margin-boxed point values per
exercise and sub-part, an `output=questions`/`output=answers` toggle to
produce either a clean student copy or a correction copy with worked
answers from the same source file, and margin grading notes for markers.

## Files

- `main.tex` — the worksheet. Start here.

## The package is deliberately NOT included

`exesheet.sty` ships with every modern TeX distribution, so this download
does not bundle a copy. If your distribution does not have it:
https://ctan.org/pkg/exesheet

## Building

    pdflatex main

## Package, not class

`exesheet` ships as both a document class (`exesheet.cls`) and a package
(`exesheet.sty`), loaded here as a PACKAGE on top of plain `article`. The
class additionally requires the `schooldocs` package for its page layout;
the package form used here has no such dependency.

## Points and margins

Point values use `\points{n}` inside an exercise/subpart's optional
argument (e.g. `\exercise[\points{10}]`) — a bare number there is typeset
as literal heading text, not a point value. `\marginpar`-based point
boxes and grading notes need a wide margin to render at all, so this
starter sets `\geometry{hmarginratio=2:1,marginparwidth=2.5cm}`, following
the package's own documented recipe.

## Question / answer toggle

`\usepackage[output=questions]{exesheet}` (used here) hides every
`\answer{}`. Switch to `output=answers` to typeset a correction copy with
every answer shown, from the same source file.

## Licence

LPPL-1.3 or later, © 2020-2025 Antoine Missier.
Source: https://ctan.org/pkg/exesheet
