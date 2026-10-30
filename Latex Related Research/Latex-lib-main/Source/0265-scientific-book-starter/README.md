# Scientific Book Starter

A plain `book`-class starter for a short non-fiction/science book:
title page, a concept-map-style "how this book is organized" page,
preface, two content chapters (each with definition/example theorem
boxes), and a back-matter answers/notes section.

## Adapted from upstream

Adapted from [minireference/sample-book](https://github.com/minireference/sample-book)
(MIT). Simplified significantly: upstream's actual build path requires
a Ruby gem (`softcover`, `polytexnic`) to pre-process the `.tex` source
before LaTeX ever runs — the repo's own README install instructions
are `gem install`/`bundle exec rake install` steps, not `pdflatex` —
and its 221-line `softcover.sty` (plus five auxiliary style files)
loads `fontspec` (needing XeLaTeX/LuaLaTeX) alongside Type1
`helvet`/`courier` fonts (a pdflatex assumption), an inconsistency
that only resolves because the Ruby preprocessor rewrites the source
first. This starter keeps the STRUCTURE (concept map, fundamentals
chapter, an estimation chapter, answers back matter) as a plain,
self-contained `book` document with ordinary LaTeX packages
(`amsthm`, `tikz`, `hyperref`) and no Ruby dependency. The chapter
content itself is entirely original — the real repo's chapters are
Minireference Co.'s own published book prose, not licensed for reuse
as a generic starter's placeholder text even under the MIT grant on
the surrounding tooling.

## Licence

MIT, verified in the upstream repo's own `LICENSE` file. (c) 2020
Minireference Co.

## Build

```
pdflatex main && pdflatex main
```
