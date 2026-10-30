# BibLaTeX CV

An academic CV where every section — education, publications, invited talks
(and, if you add entries, funding, teaching, committee service) — is
generated from entries in a single `.bib` file, using Daniel E. Shub's
`biblatex-cv` package.

- **Engine:** pdflatex
- **Licence:** LPPL-1.3c, (c) Daniel E. Shub — verified in the shipped
  `biblatex-cv.sty` header.
- **Package:** `biblatex-cv` (ships with TeX Live — not bundled here).
  https://ctan.org/pkg/biblatex-cv

## Why this template was skipped before, and why it works now

`biblatex-cv` hardcodes `backend=biber` inside its own `\PassOptionsToPackage`
call — there is no bibtex fallback at all, because its entire feature set
(custom entry types like `@school`, `@degree`, `@presentation`, `@funding`,
each with mandatory-field constraints and their own `\printbibliography`
driver) is built on biblatex's biber-only datamodel machinery. An earlier
packaging pass confirmed this was incompatible by direct testing and skipped
it. The compile pipeline now runs biber automatically whenever a document's
`main.bcf` is present, so this ships.

## A real upstream bug, worked around

`biblatex-cv.sty`'s `\highlightname` feature (for bolding one person's name
throughout the CV) calls etoolbox's `\listxadd`/`\xifinlist` on
`\cv@blx@highlightname@hash@list` without ever initialising that list macro
first — etoolbox's list commands require the control sequence to already
exist. This throws `Undefined control sequence` even in a CV that never
calls `\highlightname`. Worked around in `main.tex` by pre-declaring the
list as an empty macro (inside `\makeatletter`/`\makeatother`) before
`\usepackage{biblatex-cv}` loads — a standard etoolbox fix for an
uninitialised list, and it does not touch the package's own files.

## How the sections work

- **Education** (`@school` + `@degree`, linked by `crossref`): `\nocite` both
  the `@school` entry and its `@degree` entry. The `school` driver prints the
  institution/dates and then walks the school's `degreelist` field to print
  each linked degree — `crossref` on the `@degree` entry (pointing back at
  the `@school` key) additionally suppresses that degree from *also* being
  printed as its own standalone entry, so it appears exactly once.
- **Publications** (`@article`, `check=Education` — note: standard entry
  types like `article` are NOT modified by biblatex-cv beyond adding a
  mandatory `numcites` field): printed with `env=numbered`, using the
  package's descending-number list style.
- **Invited Talks** (`@presentation`): printed with `check=Presentation`, one
  of the package's built-in `\defbibcheck` filters that selects only
  `@presentation`-type entries.

All content in `cv.bib` and `main.tex` is fictional placeholder data.
