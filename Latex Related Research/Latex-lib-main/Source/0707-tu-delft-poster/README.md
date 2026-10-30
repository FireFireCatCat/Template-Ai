# tu-delft-poster

**This is a substitute for the custom class, not the whole original.**
An A0 portrait poster in TU Delft's corporate colours, on `tikzposter`
— title block with the real TU Delft logo, a two-column body, and a
contact block.

## Files

- `main.tex` — the poster. Start here.
- `tudelft-logo.png` — the official TU Delft logo, fetched directly
  from TU Delft's own corporate design page (see Licence below).

## Building

    pdflatex main
    pdflatex main

Two passes are enough (no bibliography, no cross-references).

## What differs from the original template

The upstream Overleaf template builds on a custom `tudelft-beamerposter`-
style class (not a real CTAN package) written by the Overleaf
uploader. That class file could not be obtained for this starter, so
it is built on `tikzposter` instead — which ships with TeX Live — with
a matching TU Delft colour theme (dark blue frame/title, cyan block
titles) applied by hand.

**Font substitution.** TU Delft's corporate design specifies **Roboto
Slab** for headers and **Arial** for body text. Neither resolves by
fontconfig family name in the pinned compiler image — only DejaVu and
URW base-35 families are reachable there — so requesting either by
name would silently render blank text (a clean compile, wrong output).
This starter uses the document's default sans family (DejaVu Sans in
this image) throughout instead. If you compile locally with Roboto
Slab and Arial installed, you can restore them with `fontspec` under
`xelatex`/`lualatex`.

## Licence and attribution

The template's LaTeX code (this poster's structure and layout) was
authored by **Novanext**, who also uploaded it to Overleaf:
https://www.overleaf.com/latex/templates/tu-delft-poster/ycvzjkgkrfgm
(source repository: https://gitlab.com/novanext/tudelft-poster).
Novanext is credited here as the template's actual author, not merely
its uploader.

Separately, **TU Delft** owns the corporate-design assets this poster
applies — the logo, brand colours, and layout conventions
(https://www.tudelft.nl/en/tu-delft-corporate-design). The logo file
bundled here (`tudelft-logo.png`) was fetched directly from that page.
Shipping TU Delft's branding as-is (not stripped or substituted) was
explicitly approved by the project owner for this batch.

**CC-BY-4.0** (per the gallery tag on Novanext's template).
