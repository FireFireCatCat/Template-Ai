# Hagenberg Thesis

A bachelor's/master's thesis starter using the `hgbthesis` class from the
Hagenberg Thesis Document Collection, developed at the Hagenberg campus of
the University of Applied Sciences Upper Austria (Fachhochschule
Oberösterreich).

- **Engine:** pdflatex
- **Licence:** CC-BY-4.0, (c) Wilhelm Burger and Wolfgang Hochleitner —
  verified directly in the upstream repo's `LICENSE.md` (the full legal
  text, not a metadata tag). **Attribution is required** — see
  `ATTRIBUTION.txt` in this download.
- **Package:** `hagenberg-thesis` (ships with TeX Live — the class itself is
  not bundled here).
- **Source:** https://github.com/Digital-Media/HagenbergThesis

This is a condensed single-file starter, not upstream's full tutorial
document (which spans roughly 15 `\include`d chapter files plus front/back
matter) — trimmed to a realistic minimal thesis, matching how other starters
in this catalogue are built.

## Two real upstream bugs, worked around

1. **`hgb.sty` misuses `\DocumentMetadata`.** The style file calls the
   LaTeX2e-kernel primitive `\DocumentMetadata` from inside
   `\AtBeginDocument` — code that only runs *after* `\begin{document}` —
   while `hgb.sty`'s own comment on that line says "This may only be called
   in the document preamble!" `\DocumentMetadata` is only valid *before*
   `\documentclass` in the current kernel, so calling it this late throws
   `should be used only before \documentclass` plus knock-on "already
   defined" errors. This starter does not need PDF metadata/PDF-A support,
   so `main.tex` no-ops `\DocumentMetadata` for the one call the class makes
   internally (`\let\DocumentMetadata\@gobble`), rather than patching the
   vendored class file.
2. **The default title-page theme's logo is not in TeX Live.** `theme=default`
   (the class's own default) references `hgbtheme-default-logo.pdf`, which
   ships in the upstream GitHub repo but not in the CTAN/TeX-Live package.
   Fetched from upstream (`dev/ctan/hagenberg-thesis/latex/` in the repo,
   the exact file CTAN itself ships) and bundled here — it is the FH
   Oberösterreich crest, covered by the same repo-wide CC-BY-4.0 grant as
   the class files (no separate image licence is stated anywhere in the
   repo), the same basis on which this catalogue already bundles the
   official Oxford belt crest with `oxthesis` and the EPFL logo with
   `epfl-thesis`.

## Bibliography backend

`hgbthesis.cls` unconditionally `\RequirePackage{hgbbib}`, which hardcodes
biblatex to `backend=biber` — there is no bibtex fallback at all. An earlier
packaging pass could not run biber and dropped this template for exactly
that reason. The compile pipeline now runs biber automatically when a
document's `main.bcf` is present, so this ships with a real
`\MakeBibliography` section — verified rendering a real, resolved entry, not
`[?]`.

All content in `main.tex` is fictional placeholder data.
