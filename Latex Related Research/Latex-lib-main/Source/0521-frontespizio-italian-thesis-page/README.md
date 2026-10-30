# frontespizio starter

This Italian thesis-frontispiece starter uses the CTAN `frontespizio` package.
The package writes a small companion source and renders its generated PDF on
the title page; `postbibtex.sh` performs that documented companion compile in
the catalogue's fixed build loop.

The university, course, candidate, and adviser names are fictional placeholders
and no institutional logo is bundled.

For a local build, run `pdflatex main.tex`, then `pdflatex main-frn`, and run
`pdflatex main.tex` again. The catalogue build performs that companion pass
automatically; its internal hook is intentionally omitted from the download.

Upstream source: https://ctan.org/pkg/frontespizio

Upstream licence: LPPL-1.3-or-later, as stated in the package header.
