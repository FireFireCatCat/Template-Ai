# Rashid Talha LaTeX Templates — hilbert (book)

The `hilbert` class from Rashid Talha's `latex-templates` collection —
"for beautiful books, not aimed to be maths-heavy". A `book`-class
extension with half-title, full title, copyright, dedication,
foreword, preface, chaptered main matter, and back-matter
acknowledgements/about-the-author sections.

## Which template this is

The upstream repo bundles six active classes: `penrose`/`salam`
(articles), `cauchy` (lecture notes/theses), `wade` (letters), and a
`beamer` theme pair, alongside `hilbert`. `hilbert` was picked as the
one purpose-built book class among them, matching this batch's book
category.

## What was changed from upstream

Upstream's own `main.tex` sample is entirely `lipsum`/lorem-ipsum
placeholder text (chapters, foreword, preface, acknowledgements,
about-the-author all lorem ipsum; dedication reads "Dedicated to
Person"; the metadata file's title is literally "Title of this Amazing
Book"). This starter is an original three-story short-fiction
collection ("The Last Call", "The Interpreter", "Postcards from
Nowhere") with real front matter (foreword, preface, dedication, about
the author) written to match, and no fake ISBN/publisher/edition-history
fields (upstream's copyright page invents a "First edition published
1889" for a document with a 2020 copyright — this starter's copyright
page states only what is actually true of the starter itself).

## Class

Not on CTAN — bundled directly (`hilbert.cls`).

## Licence

MIT, verified in the upstream repo's own `LICENSE` file. (c) 2020
rmathsphys (Rashid Talha).

## Build

```
pdflatex main && pdflatex main
```
