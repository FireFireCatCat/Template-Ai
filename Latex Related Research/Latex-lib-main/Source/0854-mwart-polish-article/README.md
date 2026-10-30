# mwart Polish article

A Polish-oriented alternative to the standard `article` class, part of
Marcin Woliński's MW bundle (`mwart`/`mwbk`/`mwrep`).

- **Engine:** pdflatex
- **Class:** `mwart` (ships with TeX Live, package `mwcls` — not bundled
  here)
- **Licence:** LPPL-1.2 (or later), (c) 2000–2025 Marcin Woliński —
  verified directly in the shipped `mwart.cls` header.

## Notes

- `mwart` itself is language-agnostic — the actual Polish localisation
  (section names, hyphenation, quotation marks, and the automatically
  translated `\today` date) comes from `babel[polish]` + `polski`, both
  loaded in this starter.
- The starter body is written in Polish (not lorem ipsum), to demonstrate
  the class genuinely renders Polish diacritics and hyphenation correctly
  — confirmed in the preview (e.g. `Streszczenie`, `Literatura`, and the
  date rendering as `27 sierpnia 2026`, not `August 27`).
- Standard `\title`/`\author`/`\maketitle`/`abstract` all work as in
  plain `article`.
- Bibliography uses classic `bibtex` with the standard `plain` style.
