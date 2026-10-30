# jacobs-landscape-poster

**This is a substitute, not the original.** The template historically
served at this URL was "Jacobs Landscape Poster" (bardsoftware / Vel).
That original is licensed **CC-BY-NC-SA (non-commercial)**, and this
site cannot redistribute non-commercial content. This download is a
different landscape conference poster — the upstream `tikzposter`
document class, LPPL-1.2 — not a recreation of the original's design.

## Files

- `main.tex` — the poster. Start here.

## Building

    pdflatex main
    pdflatex main

Two passes are enough here (no bibliography).

## Layout

A0, landscape, three columns, using tikzposter's `Wave` layout theme
and `Britain` colour style (`BlueGrayOrange` palette). Both are
one-word changes:

    \usetheme{Basic}        % or Rays, Simple, Envelope, Board, Autumn, Desert
    \usecolorstyle{Australia}  % or Denmark, Spain, Sweden, Germany, Russia, Default

## The class is deliberately NOT included

`tikzposter.cls` ships with every modern TeX distribution, so this
download does not bundle a copy. If your distribution does not have
it: https://ctan.org/pkg/tikzposter

## Licence

`tikzposter` is licensed **LPPL-2.0** (per the class file's own header;
CTAN's catalogue metadata says 1.2, but the actual `.cls` states 2.0),
© 2014 Pascal Richter, Elena Botoeva, Richard Barnard, and Dirk
Surmann. The class is not redistributed here; see
https://ctan.org/pkg/tikzposter.

This starter document is a minimal example written for latextemplates.com
and carries no additional restrictions.
