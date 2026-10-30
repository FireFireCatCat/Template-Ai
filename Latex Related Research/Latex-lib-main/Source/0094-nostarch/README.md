# nostarch

A technical-book class written for No Starch Press's own house style
by Boris Veytsman, and released **independently** under the LPPL —
this is not a proprietary publisher kit. Provides half-title, formal
title page, copyright page, dedication, foreword, index, and the usual
front/main/back-matter structure.

## Not an official No Starch Press product

Upstream's own sample document (`nssample.tex`) includes No Starch
Press's real street address, phone number, and trademark notice as
boilerplate. This starter removes all of that — no publisher branding,
address, ISBN, or trademark claims — and adds an explicit "not an
official No Starch Press publication" line to the copyright page, so
it cannot be mistaken for an endorsed product. The class also defaults
`\nostarchlocation` to "San Francisco" (No Starch's real city); this
starter overrides it to blank. The `cipblock` and
production-credits environments from the upstream sample (Publisher,
Production Editor, Compositor, etc.) are also omitted since they only
make sense for an actual imprint.

## Index

The starter includes a real index (`\index{...}` entries throughout,
`\printindex` at the end) built with `makeindex -s nostarch.ist` — the
class's own index style — via a `postbibtex.sh` hook, since the
default compile recipe does not run makeindex. A book shipping
`\printindex` with an unbuilt (empty) index would be a silent failure.

## Class

Not bundled — ships with TeX Live (`nostarch.cls`, `nostarch.ist`,
`nshyper.sty`).

## Licence

LPPL-1.3 or later, (c) 2008-2023 Boris Veytsman, verified in the
upstream CTAN package's own `nostarch.dtx` header. Independent of any
grant from No Starch Press, Inc. itself.

## Build

```
pdflatex main && bibtex main && makeindex -s nostarch.ist main.idx && pdflatex main && pdflatex main
```
