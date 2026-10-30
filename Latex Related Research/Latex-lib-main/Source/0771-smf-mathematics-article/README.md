# SMF mathematics article

A starter for submissions to journals of the Société mathématique de
France (Astérisque, Bulletin, Mémoires, etc.), using the official
`smfart` document class.

- **Engine:** pdflatex
- **Class:** `smfart` (ships with TeX Live, package `smflatex` — not
  bundled here)
- **Licence:** CTAN tags `smflatex` LPPL-1.3c (Société mathématique de
  France, 1999–2021; maintainer Antoine Chambert-Loir). No licence or
  copyright grant text was found in any vendored file (`smfart.cls`,
  `smfbook.cls`, or any of the `smf*.sty` support files) — shipped on
  CTAN's own attested licence and holder.

## Notes

- `[english]` (or `[french]`/`[francais]`) is a **required** class option:
  the class sets no default language before processing its own options, so
  a bare `\documentclass{smfart}` leaves the internal language switch
  undefined.
- `\subjclass{...}` takes **one plain brace group only** — unlike amsart's
  `\subjclass[2020]{...}`, passing a `[year]` optional argument here leaks
  stray text into the preamble and fails with "Missing \begin{document}".
- No theorem environments are predeclared (unlike amsart) — the starter
  adds `\newtheorem{theorem}{Theorem}` explicitly.
- The bundled `references.bib` wraps the book title in **double** braces
  (`{{The \TeX{}book}}`) — the class's `smfplain.bst` case-folds
  unprotected title text, which turns `\TeX` into `\tex` (undefined) with
  only single-brace protection.
- Bibliography uses classic `bibtex` with the bundled `smfplain.bst` style
  — not biblatex/biber.
