# einfart minimal article

A clean, minimal article class with careful typography and built-in CJK
support — the plain face of Jinwen XU's "minimalist" class series.

- **Engine:** xelatex (fontspec-based; lualatex also works)
- **Class:** `einfart` (ships with TeX Live — not bundled here)
- **Licence:** LPPL-1.3c, (c) 2021–2026 Jinwen XU — verified directly in
  the shipped `einfart.cls` header.

This is the deliberate **plain** counterpart to the already-catalogued
"Stylish Article" substitute (which uses `lebhart` — the **colourful**
face of the same class series, same author, same licence). Where
`lebhart` adds coloured section rules and boxed theorem environments,
`einfart` is intentionally unstyled.

## Notes

- Purely a typography/font layer over plain `article` — no custom
  title-page or theorem machinery like `lebhart` has. Standard
  `\title`/`\author`/`\maketitle`/`abstract` all work unchanged.
- Loads `ctex` unconditionally, so Chinese text renders correctly inside
  an otherwise English document with no extra setup — demonstrated in the
  starter (`这是一段中文示例文字`, real glyphs via Fandol/kpathsea, not
  tofu boxes).
- Default body font is TeX Gyre Pagella (Palatino-like), resolved by
  fontspec directly rather than a bare fontconfig lookup.
- Bibliography uses classic `bibtex` with the standard `plain` style.
