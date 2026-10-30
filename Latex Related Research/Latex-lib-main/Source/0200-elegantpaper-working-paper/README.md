# ElegantPaper working paper

A clean working-paper / preprint starter using the ElegantLaTeX
`elegantpaper` class.

- **Engine:** xelatex
- **Class:** `elegantpaper` (ships with TeX Live — not bundled here)
- **Licence:** LPPL-1.3c, Dongsheng Deng & Ran Wang — verified in the
  repo's own `License` file and the shipped `elegantpaper.cls` header.

## Notes

- **Bibliography backend:** the class defaults to biblatex+**biber**
  (`\ELEGANT@bibend=biber`), which this starter now uses unmodified — the
  compile pipeline runs biber automatically when a document's `main.bcf`
  is present. An earlier version forced the `[bibtex]` class option because
  the pipeline only ran classic bibtex at the time.
- Uses biblatex's `\addbibresource`/`\printbibliography`, not the classic
  `\bibliography`/`\bibliographystyle` pair.
- `[en]` (default) or `[cn]` selects the caption/abstract-name language.
  Under `[en]`, Chinese characters are not permitted unless you also load
  `ctex`/`xeCJK` yourself.
- Custom commands beyond standard LaTeX: `\keywords{...}` inside the
  abstract, `\version{...}` and `\institute{...}` for the title block,
  plus `\email`, `\figref`, `\tabref` helpers.
