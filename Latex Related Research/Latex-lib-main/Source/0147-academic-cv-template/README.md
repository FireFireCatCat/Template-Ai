# Academic CV Template

A single-column academic CV: a two-column header (name/contact on the left,
Github/LinkedIn/website on the right), circled section icons via FontAwesome,
and helper macros for publications, degrees, and jobs with a comma-separated
"tech stack" tag list.

This is salmanmaq's academic fork of [Primož Godec's
my-latex-cv](https://github.com/PrimozGodec/my-latex-cv), adapted for
academic CVs (added a Summary section, thesis titles, keyword tags for jobs,
removed date-of-birth, single column instead of two).

## Files

- `main.tex` — the CV. Start here.
- `my_cv.cls` — the document class, vendored (not on CTAN).

## A patched bug

The upstream `\titletext` macro takes an email address as its third argument
but never used it — the mailto: link was hardcoded to the original author's
own address, so every CV built from this template silently mailed to
`salmanmaq@gmail.com` instead of the user's own email. Patched in
`my_cv.cls` to use the passed-in address; see the comment at the fix.

## Building

    xelatex main

This class needs XeLaTeX: it loads FontAwesome icons and the Raleway font
family via `fontspec`-based packages, both present in this TeX Live install
by filename — no substitution needed.

## Licence

`my_cv.cls` is **MIT**, © 2020 Primož Godec (original `my-latex-cv`), with
salmanmaq's academic-CV modifications carrying the same licence. Full text:
https://github.com/salmanmaq/academic-cv-template/blob/master/LICENSE

This starter document is a fictional example written for
latextemplates.com and carries no additional restrictions.
