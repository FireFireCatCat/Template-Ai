# UNSW dissertation title page starter (unswcover)

A starter for a University of New South Wales thesis front matter — the title
page plus the Originality, Copyright and Authenticity statements UNSW requires
of a submitted dissertation — using the `unswcover` package.

## Files

- `main.tex` — the thesis. Start here.

## The package is deliberately NOT included

`unswcover.sty` ships with every modern TeX distribution, so this download does
not bundle a copy. Shipping one would pin you to whatever version we packaged
rather than the version your own system already has.

If your distribution does not have it: https://ctan.org/pkg/unswcover

## Building

    pdflatex main
    pdflatex main

Two passes: the second resolves the table of contents. Add `bibtex main` and two
further passes once you have a bibliography.

## The UNSW crest is not included, and cannot be

The package's title page ends with `\includegraphics{logo_unsw_short}`, and that
crest is a University of New South Wales trademark. TeX Live installs
`unswcover.sty` and **nothing else** — no logo file — so an unmodified
`\makeunswfrontmatter` fails outright with ``File `logo_unsw_short' not found``.

This starter therefore draws a neutral placeholder frame at the crest's exact
3 cm size, so the page balances the way it will with the real thing. To use the
real crest once you are entitled to: delete the `\begingroup`…`\endgroup`
wrapper around `\makeunswfrontmatter` and put a `logo_unsw_short.pdf` beside
`main.tex`.

The wrapper is scoped on purpose. It substitutes the placeholder for the single
`\includegraphics` inside the package and nothing else — `\includegraphics`
behaves normally again after `\endgroup`, so figures in your chapters are
unaffected.

## It is a package, not a class

`unswcover` supplies only the front matter; you choose the class. This starter
uses `report`, which is the usual choice for a thesis — `book` works the same
way. Everything after `\makeunswfrontmatter` is an ordinary document.

## What you set

`\unswschool{...}` names your school (empty by default, and it prints nothing if
you leave it so). `\unswdegree{...}` defaults to *Doctor of Philosophy*.
`\unswcotutelle{...}` is optional and adds an "in a cotutelle agreement with"
line for a joint award. The title page otherwise reads the standard `\title`,
`\author` and `\date` — and `\date` is printed again under each of the three
signature blocks, so give a submission month and year rather than `\today`.

`\unswdissertationsheet{file.pdf}` binds UNSW's own Thesis/Dissertation Sheet in
behind the title page. That form is issued by the university, so it is not
shipped here; the call is left commented out in `main.tex`.

## Before you submit

Check UNSW's current Graduate Research School requirements. The statement wording
in the package dates from 2013 and the university has revised its forms since.

## Licence

`unswcover` is licensed **LPPL-1.3**, © Olivier Mehani. The package is not
redistributed here; see https://ctan.org/pkg/unswcover. The UNSW name and crest
are trademarks of the University of New South Wales and are not redistributed
here either.

This starter document is a minimal example written for latextemplates.com and
carries no additional restrictions.
