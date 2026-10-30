# Pseudomanifold CV

A minimal single-column academic CV: small-caps section headers, a
`\years{}` macro that typesets durations as Tufte-style margin notes, and
distinct sans-serif/monospace faces for publication titles and software
names. No custom document class — just `article` and a handful of standard
packages. Upstream is `Pseudomanifold/latex-cv` by Bastian Rieck.

## Files

- `main.tex` — the CV (upstream's own example, a fictional CV styled after
  historical physicist Georges Lemaître).
- `engine.txt` — `lualatex` (the class uses `fontspec`).

## The fonts are patched — read this before touching `\setmainfont`

Upstream selects three fonts **by family name**:
`\setmainfont{Minion Pro}`, `\setsansfont{Cabin Regular}`,
`\setmonofont{Fira Mono}`. Two problems, found while packaging:

1. **Minion Pro is a commercial Adobe font** with no free-redistribution
   licence — it was never going to resolve on any system without a paid
   Adobe font install, this compiler included.
2. Even for freely-licensed faces, **family-name lookup silently fails on
   this compiler**: fontspec resolves family names through `fontconfig`,
   and this image's `fontconfig` only registers 14 base families (verified
   with `fc-list` — DejaVu, URW, Nimbus, etc), not TeX Live's own font
   tree. The compile finishes with **zero errors**; the log only shows
   "Missing character" warnings against `nullfont`, i.e. every character
   silently renders as nothing.

Fixed here: substituted **EB Garamond** for Minion Pro — a genuinely free,
widely-used equivalent old-style serif with small caps and old-style
figures, the exact features this template's own comments ask for — and
loaded all three fonts by their **exact TeX Live filename**
(`EBGaramond-Regular.otf`, `Cabin-Regular.otf`, `FiraMono-Regular.otf`,
etc) instead of family name. A filename resolves through `kpathsea`, which
does index the TeX Live font tree, bypassing the fontconfig gap entirely.
Verified against the rendered preview PNG that real glyphs appear.

## Building

    lualatex main
    lualatex main

Two passes resolve the layout; there is no bibliography.

## Licence

**MIT**, © Bastian Rieck (2019). Full licence text is in upstream's
`LICENSE.md` at https://github.com/Pseudomanifold/latex-cv. MIT does not
require attribution in the download, but credit is due here: thank you,
Bastian Rieck.

The starter content is upstream's own example: a CV styled after the
historical physicist Georges Lemaître, with fictional contact details
(`lemaitre@example.com`) — already free of any real personal data, used
as-is.
