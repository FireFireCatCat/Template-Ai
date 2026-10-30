# Conference Booklet / Book of Abstracts

A `scrbook`-based conference book-of-abstracts starter: title page,
about section, coloured timetable, tagged talk abstracts (Keynote /
Invited / Contributed), a poster list, and useful-information pages.

## Adapted from upstream

Adapted from [maximelucas/AMCOS_booklet](https://github.com/maximelucas/AMCOS_booklet)
(GPL-3.0). Simplified from upstream:

- **Dropped the online/print dual-compile switch** (`\ifOnline`, two
  parallel sets of abstract files under `abstracts/tex/`) — this
  starter ships one straightforward version.
- **Dropped the cover page**, which upstream includes as an external
  PDF ("our cover was produced with canva.com" — not something this
  starter can redistribute without that design tool). Replaced with a
  simple title page drawn directly in LaTeX.
- **Real abstract content.** Upstream's example abstracts are
  Jane-Austen-style filler text under placeholder names (Tremblay,
  Fournier, Doe, ...). This starter's four talk abstracts and three
  poster titles are original, invented conference content (a fictional
  "Complex Networks in Motion" workshop) so every macro in the abstract
  environment is exercised with real-looking material.

Kept the coloured side-bar page style, the chapter-heading bar, and the
KL/IS/CT talk-type tag circles.

## Licence

GPL-3.0, verified in the upstream repo's own `LICENSE` file (full GPLv3
text). Original authors: Maxime Lucas, Pau Clusella.

## Build

```
pdflatex main && pdflatex main
```
