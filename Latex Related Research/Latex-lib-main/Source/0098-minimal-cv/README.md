# Minimal-CV

A one-page poster-layout CV: a full-bleed A4 built from three `tcolorbox`
poster panels (a dark header band, a light left sidebar for contact/personal
details, a white main column for education/experience/publications).
Contact and language rows use small hand-drawn vector icons and flags
instead of image files, so nothing needs a photo to look finished.

By [Fabio Matti](https://github.com/FMatti), dedicated to Carl Friedrich
Gauss. This starter replaces Matti's own Gauss-themed example content with a
generic professional CV, keeping the same layout and icon set.

## Files

- `main.tex` — the CV. Start here.
- `icons/` — vector icons (address, phone, email, birthday, nationality,
  GitHub, LinkedIn, scholar, website), each a small standalone TikZ picture.
- `flags/` — vector flags for the language-competence rows (14 countries).
- `images/image.tex` — the vector portrait silhouette used in place of a
  photo. Swap in a real `\includegraphics` if you have a photo — the line
  to uncomment is right above it in `main.tex`.

## Colour schemes

Four colour schemes ship as commented-out `\definecolor` triples near the
top of `main.tex` (default black, blue, green, red) — uncomment one and
comment out the active one to switch.

## Long lines overflow the page

The main-column table has no wrapping column type (plain `r`/`l`, not `p{}`),
so a long institution name or bullet point runs straight off the right edge
of the A4 page with no warning in the compile log — caught in this starter
by an overlong university name and a long interests bullet, both shortened.
Keep entries short, or wrap the offending cell in a `\parbox` / `p{width}`
column if you need the full text.

## Building

    pdflatex main

One pass is enough — no bibliography, no cross-references.

## Licence

**MIT**, © 2021-2023 Fabio Matti. Full licence text:
https://github.com/FMatti/Minimal-CV/blob/main/LICENSE

This starter's CV content is a fictional example written for
latextemplates.com and carries no additional restrictions.
