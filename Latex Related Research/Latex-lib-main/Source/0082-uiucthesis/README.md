# UIUC Thesis

A dissertation/thesis class formatted to the University of Illinois
at Urbana-Champaign Graduate College's deposit requirements — title
page, committee front matter, `abstract`/`dedication` environments,
`\frontmatter`/`\mainmatter`/`\backmatter` structure, and a
`symbollist` environment for a List of Abbreviations. It ships with
this TeX Live install (`uiucthesis.cls`, v2.25), so nothing is
vendored here.

## Files

- `main.tex` — the thesis. Start here.
- `references.bib` — a small sample bibliography (classic `bibtex`).

## Building

    pdflatex main
    bibtex main
    pdflatex main
    pdflatex main

Confirm the bibliography resolves to real entries (not `[?]`) — this
pipeline runs classic `bibtex`, not `biber`; `\bibliographystyle{plain}`
and a plain `.bib` file are chosen deliberately for that reason.

## Licence

No licence statement could be found anywhere in the upstream package
(`uiucthesis.dtx`, `.ins`, `README`) — CTAN tags it `lppl`, but no
LPPL grant text, or any other licence text, exists in the files
themselves. The only "copyright" occurrences in the class are the
`\copyrightnotice` macro, which stamps a rights-reserved notice onto
the *student's own finished thesis* (`\copyright~YEAR by AUTHOR. All
rights reserved.`) — that licenses the output document, not the
class, and is not a grant covering this template. Authors, per the
upstream README: Peter Czoschke, based on the original version by
David Hull.
