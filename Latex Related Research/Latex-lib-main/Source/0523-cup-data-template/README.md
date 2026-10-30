# CUP Data Template starter (CUP-JNL-DTM)

A starter for the Cambridge University Press "Data/Math" journal family —
Glasgow Mathematical Journal, Data and Policy, Psychometrika, Forum of
Mathematics (Pi/Sigma), and others — using the `CUP-JNL-DTM` document class.

## This is a community/third-party template, not an official CUP kit

This starter is based on the "CUP Data Template" page in the Overleaf
gallery, byline "Cambridge University Press and Overleaf":
https://www.overleaf.com/latex/templates/cup-data-template/kwrskzvmfxbq

That page is maintained by an `@overleaf.com` address, not published by
Cambridge University Press itself — the same situation as this catalogue's
separate `cup-journal` template (a different class, the CUP "Medium
Template"). Do not present this download as an official CUP-issued
authoring kit, and check CUP's own current submission portal and author
guidelines for your target journal before relying on this template for a
real submission — journal requirements change, and only the publisher's own
current instructions are authoritative.

## Licence

`CUP-JNL-DTM.cls` is bundled here because it is not part of any TeX Live
distribution or CTAN package (checked both). Its own header carries **no
licence grant for the class itself**: the header text is generic
LaTeX2e/LPPL docstrip boilerplate about the LaTeX base system (not this
class), and the only Creative Commons string anywhere in the file is inside
a macro (`\copytext`) that stamps a CC-BY copyright notice onto the
**author's own published article** when the class typesets output — it is
not a licence for the class file. This is the same pattern already
documented for the Cambridge Medium Template (`cup-journal` in this
catalogue) and for MDPI's class.

No other licence text was found for this class in any copy checked
(including a second, independently-sourced copy used to cross-check the one
bundled here — see below). It is shipped here as a widely-redistributed
Overleaf/CUP-branded authoring template, on an explicit product decision to
carry institutional/publisher-branded templates as-is; it is not shipped on
the strength of a licence grant, because none was found.

`CUP_Logo.pdf` (the Cambridge University Press logo, printed in the page
header by the class) and `Fig.pdf` (a sample figure) are bundled unmodified
alongside the class, sourced the same way.

## Files

- `main.tex` — the article. Start here.
- `CUP-JNL-DTM.cls` — the document class (bundled; see Licence above).
- `CUP_Logo.pdf` — Cambridge University Press logo, used in the page header.
- `Fig.pdf` — a sample figure image, not used by this starter's own content
  but kept alongside the class since some CUP-DTM starters reference it by
  default; safe to delete if you do not need it.
- `references.bib` — bibliography, cited from `main.tex`.

## Choosing your journal

Set the `journal=` class option in `\documentclass[journal=...]{CUP-JNL-DTM}`
to your target journal's code — see the comment block above `\documentclass`
in `main.tex` for the full list. The option also selects your bibliography
toolchain automatically (bibtex+natbib for some journals, biblatex for
others) — see the comment above `\bibliography` near the end of `main.tex`
for what to change if you pick a biblatex journal.

## Building

    pdflatex main
    bibtex   main
    pdflatex main
    pdflatex main
