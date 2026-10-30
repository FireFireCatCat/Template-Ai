# Thesis cover sheet and statutory declaration (scientific-thesis-cover)

A starter for the two pages a university thesis submission is actually
prescriptive about: the cover sheet and the signed statutory declaration.
Everything else — the class, the chapters, the bibliography — is left to you.

## Files

- `main.tex` — the document. Start here.

## This is a package, not a thesis class

`scientific-thesis-cover` contributes exactly two pages and nothing else. It
does not set your page geometry, headings, fonts or bibliography style, and it
does not conflict with a class that does.

That makes it useful in a way a thesis class is not: if you already have a
thesis in `scrbook`, `memoir` or `report` and your department has just told
you the cover and declaration must follow a particular form, you add one
`\usepackage` line and two macro calls rather than porting the whole document
to somebody else's class. This starter demonstrates that by pairing the
package with a plain `report`.

## The package is deliberately NOT included

`scientific-thesis-cover.sty` ships with every modern TeX distribution, so
this download does not bundle a copy. Shipping one would pin you to whatever
version we packaged rather than the version your own system already has.

If your distribution does not have it: https://ctan.org/pkg/scientific-thesis-cover

## Building

    pdflatex main
    pdflatex main

Two passes: the first collects the table-of-contents entries, the second
typesets them. One pass leaves the contents page empty.

## Everything is set as a package option

The cover sheet reads its values from the `\usepackage[...]` key-values, not
from `\title` and `\author`. A `\title{...}` written later in the preamble is
simply not consulted, and the cover prints `title not set` — this is the most
common confusion with the package.

The keys used here are `language`, `type`, `institute`, `course`, `title`,
`author`, `examiner`, `supervisor`, `startdate`, `enddate` and
`setPageNumberToOne`.

## Three keys have a fallback you can use

`type`, `institute` and `course` each recognise a small set of short
abbreviations that expand to fixed wording, and print anything else verbatim:

- `type` — `bachelor`, `master`, `diplom`, `study`, `fachstudie`, `projectinf`
- `institute` — `ipvs`, `iaas`, `fmi`, `iste`, `iti`, `iris`, `vis`, `sec`, `fac`
- `course` — `cs`, `se`, `mcl`, `msv`, `bis`, `simtech`, `medinf`

The abbreviations are those of the University of Stuttgart computer science
faculty, where the package originated, and the `institute` ones additionally
pull in that university's postal address. Outside Stuttgart, pass your own
department and university as free text — as this starter does — and no address
is attached.

### The `type` abbreviations stay German even in English

`type=master` prints **Masterarbeit** on an otherwise English cover, and the
other five behave the same way. That is deliberate upstream: those are the
legally operative degree names in the examination regulations the package was
written for, and `language=english` does not translate them.

Outside those regulations it is just wrong, so this starter passes the wording
out in full (`type={Master's Thesis}`) and takes the verbatim path instead.
Write whatever your own regulations say.

## `language=english` is exact

Only the literal value `english` selects the English labels. Any other value,
including a misspelling or a babel-style name such as `ngerman`, falls back to
German without a warning.

## UTF-8 must be loaded first

Under pdfLaTeX, load `inputenc` (or `inputenx`) with the `utf8` option before
the package, as `main.tex` does. The package inspects which option was given
and warns on every run otherwise, because its German declaration text contains
umlauts. Under LuaLaTeX or XeLaTeX no `inputenc` is needed and no warning is
issued.

## The declaration wording is fixed

`\Versicherung` (alias `\Affirmation`) typesets the package's own German or
English declaration text, which is not editable by design. If your university
prescribes different wording, typeset that page yourself instead of patching
this one. The page ends with a rule and a place/date/signature line: it is
meant to be printed and signed in ink.

## Licence

`scientific-thesis-cover` is licensed **LPPL-1.3c**, © Oliver Kopp. The
package is not redistributed here; see
https://ctan.org/pkg/scientific-thesis-cover.

This starter document is a minimal example written for latextemplates.com and
carries no additional restrictions.
