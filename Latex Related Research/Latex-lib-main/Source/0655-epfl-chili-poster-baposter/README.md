# EPFL CHILI Poster (baposter)

An A0 landscape conference poster in the classic `baposter` grid layout: a
narrow left column (abstract, introduction, acknowledgements, references),
a wide centre column (methodology with a TikZ architecture diagram,
results with a table), and a right column (conclusion, demo link). Built
on Brian Amberg and Reinhold Kainhofer's `baposter` class, via EPFL
CHILI's paper/poster/slides pack.

Edit `\papertitle`/`\authorlist` and each `\headerbox{...}{name=...,
column=..., ...}` block in `main.tex`. `column`/`row`/`span`/`below`/
`above` control box placement in the grid.

## Licence

LGPL-3.0, per the upstream repository's own `LICENSE` file (included in
this download). The vendored `baposter.cls` itself carries only a bare
copyright comment (Brian Amberg 2007-2011, Reinhold Kainhofer 2011), no
separate licence statement of its own — the repository's LGPL-3.0 grant is
the operative one. Source:
https://github.com/chili-epfl/paper-poster-presentation-template

## Patch

Upstream's own example is a stub ("Abstract Here.", "Introduction Here.",
...) — replaced with a real federated-learning research poster (a
zeroth-order federated fine-tuning protocol, with a TikZ architecture
diagram, a results table, and real citations). Also dropped a dependency
on `bibspacing.sty`, which is not in TeX Live and was only used for one
`\setlength{\bibspacing}{...}` call controlling a `\bibliography{}`
bibliography — this starter inlines its references as a plain enumerate
instead, so neither the package nor that length are needed.
