# Overhead foils starter (slides)

A starter for large-format presentation transparencies, using the standard
LaTeX `slides` class — the LaTeX2e successor to SliTeX.

## Files

- `main.tex` — the slides. Start here.

## The class is deliberately NOT included

`slides.cls` is part of core LaTeX and ships with every modern TeX
distribution, so this download does not bundle a copy. Shipping one would pin
you to whatever version we packaged rather than the version your own system
already has.

If your distribution does not have it: https://ctan.org/pkg/slides

## Building

    pdflatex main

One pass is enough — there are no cross-references or citations to resolve.

## When to use this rather than beamer

`slides` gives oversized sans-serif type on a plain background and nothing
else: no themes, no navigation bars, no overlays beyond the `overlay`
environment. That is the point. Use it for a high-contrast talk where the
content is the design, and reach for `beamer` when you want structure,
transitions and a theme.

Each `slide` environment is one foil. Keep them short — the large type only
helps if there is little enough on the page to read from the back of a room.

## Licence

`slides` is licensed **LPPL-1.3c**, © The LaTeX Project. The class is not
redistributed here; see https://ctan.org/pkg/slides.

This starter document is a minimal example written for latextemplates.com and
carries no additional restrictions.
