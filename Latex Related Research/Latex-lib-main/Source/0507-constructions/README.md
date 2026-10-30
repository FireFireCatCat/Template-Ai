# constructions-article

**This is a substitute for one bibliography component, not the whole
original.** A submission-style article in the shape of the *Constructions*
journal's own Overleaf template, on plain `article` — sections, a
numbered linguistics-style example, a table, and a resolved
bibliography.

## Files

- `main.tex` — the article. Start here.
- `references.bib` — the bibliography database.

## Building

    pdflatex main
    bibtex main
    pdflatex main
    pdflatex main

## What differs from the original template

The Constructions journal's own template (linked from
https://constructions.journals.hhu.de/information/authors) loads a
custom `constructions` document class and a linguistics-specific
BibTeX style, `unified.bst` ("Unified Style Sheet for Linguistics").
Neither file's actual source could be obtained for this starter, and
no BibTeX-compatible replacement for `unified.bst` ships in the pinned
compiler image — so this starter uses plain `article` plus
`natbib`/`plainnat` instead. The citation and reference numbering
behave like a standard author-date bibliography rather than the
journal's specific linguistics format; check the journal's current
author guidelines before submitting.

## Licence

Based on the Overleaf gallery template "Constructions"
(https://www.overleaf.com/latex/templates/constructions/vqhvxmnfgcbh),
the submission template for the open-access journal *Constructions*
(https://constructions.journals.hhu.de), LaTeX adaptation credited to
Stefan Hartmann. The upstream template's own file headers state a
per-file split:

- `main.tex` and `localstuff.tex` — CC0 (public domain), no attribution
  required.
- `unified.bst` — LPPL-1.3c.

This starter does not reproduce `unified.bst` (see above), so no LPPL
obligations attach to what ships here; the registry records LPPL-1.3c
as the most-restrictive licence named in the upstream bundle. This
starter document itself carries no additional restrictions.
