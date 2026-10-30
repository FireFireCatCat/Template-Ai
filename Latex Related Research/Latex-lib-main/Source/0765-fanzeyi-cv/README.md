# fanzeyi cv

A modern minimal CV with a dark sidebar, skill sliders and clean
sans-serif typography, from `github:fanzeyi/cv` (LPPL-1.3c). Single
self-contained file — no vendored class.

## Files

- `main.tex` — start here.

## Engine

Requires **xelatex** — loads `fontspec` unconditionally, and sets
Raleway (all weights) as the main typeface.

## Font resolution

Upstream's `\newfontfamily`/`\setmainfont` calls resolved "Raleway" by
fontconfig family name, which is not registered in this pipeline's
image. TeX Live itself ships the actual Raleway `.otf` files
(`texmf-dist/fonts/opentype/impallari/raleway/`) — patched to load each
weight by its exact kpathsea-resolvable filename (`Extension=.otf`)
instead of asking fontconfig to resolve a family name.

## Licence

LPPL-1.3c, (c) Zeyi Fan. Verified in the source `.tex` header comment.
