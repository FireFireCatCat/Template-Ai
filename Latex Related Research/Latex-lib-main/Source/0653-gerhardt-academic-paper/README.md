# Gerhardt Academic Paper

An academic-manuscript starter with a Charter/Fira Sans font pairing
(serif body and math, bold sans-serif headings), from Holger Gerhardt's
academic LaTeX template set.

- **Engine:** pdflatex
- **Licence:** 0BSD — "Permission to use, copy, modify, and/or distribute
  this software for any purpose with or without fee is hereby granted",
  verified directly in the repo's own `LICENSE` file.
- **Source:** https://github.com/HolgerGerhardt/TeXTemplates
  (`Template_Paper.tex`)

## About this starter

The upstream repo is a **multi-template collection** — CV, dissertation,
paper, poster, and five presentation variants, all built from roughly a
dozen shared `\input{}` preamble fragments. Only the Paper template is
packaged here.

**Restored to upstream's citation style:** the original preamble uses
`biblatex-chicago` with `backend=biber`. An earlier version of this starter
fell back to plain `natbib` + `bibtex` because the compile pipeline only ran
classic `bibtex`; the pipeline now runs `biber` automatically when a
document's `main.bcf` is present, so this starter ships `biblatex-chicago`
(`chicago-authordate` style) as upstream intended, alongside the template's
real visual identity — Fira Sans headings, Charter body/math via `XCharter` +
`mathdesign`, and an `authblk`-based multi-author block.

Upstream's own preamble also carries around ten `\DeclareSourcemap` regex
passes; those exist to normalise messy bibliographic data pulled in from
reference managers (Zotero/EndNote export quirks) and are not needed for a
clean, hand-written starter `.bib`, so they are not carried over.

**In-text citation command:** the starter uses `\citeauthor{...}
(\citeyear{...})` rather than `\parencite{...}`. `chicago-authordate.cbx`'s
own `\parencite` does not print the year in this TeX Live version (renders
`(Knuth)` with no date — traced to the bibliography's `labelyear` field not
being populated even though `year`/`date` are set correctly in the `.bbl`);
`\citeauthor`/`\citeyear` are core biblatex commands unaffected by that and
render a correct `Knuth (1984)`. The bibliography itself (`\printbibliography`)
is unaffected and renders the full Chicago-style entry correctly.

All fonts and packages used here (`FiraSans`, `FiraMono`, `mathdesign`,
`XCharter`, `mweights`, `authblk`, `titlesec`, `abstract`) ship in the
pinned TeX Live image — nothing is bundled.
