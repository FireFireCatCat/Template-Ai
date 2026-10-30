# prometheusCV

A banner-header academic CV: a centred serif title block with a keyword
line and icon-linked contact row, then dated `\datedsubsection` entries for
Education, Publications, Honors, Skills, Service and Extracurricular
Activities — set in Cormorant Garamond, a distinctive contrast to the
sidebar/skill-bar CVs already on this site. Upstream is `chrisby/prometheusCV`
by Christian Bock.

## Files

- `main.tex` — sets fonts/colours, then `\input`s each section file.
- `title.tex`, `education.tex`, `publications.tex`, `honors.tex`,
  `skills.tex`, `service.tex`, `extra.tex` — one file per CV section.
- `prometheus_cv.cls` — the document class, vendored.
- `engine.txt` — `xelatex` (the class uses `fontspec`).

## The font is patched — read this before touching `\setmainfont`

Upstream selects Cormorant Garamond **by family name**:
`\setmainfont[...]{Cormorant Garamond Regular}`. On this compiler, that
silently renders a **blank page**: fontspec resolves family names through
`fontconfig`, and this image's `fontconfig` only registers 14 base families
(DejaVu, URW, Nimbus, etc — verified with `fc-list`) — it does not scan TeX
Live's own font tree. The compile finishes with **zero errors**; the log
only shows "Missing character" warnings against `nullfont`, so a clean
compile is not proof the CV rendered.

Fixed here: fontspec also accepts an **exact filename** in place of a
family name, which resolves through `kpathsea` instead of `fontconfig` —
and kpathsea does index TeX Live's font tree. Cormorant Garamond ships in
this TeX Live as
`texmf-dist/fonts/truetype/catharsis/cormorantgaramond/*.ttf`, so
`\setmainfont{CormorantGaramond-Regular.ttf}` (with `BoldFont=`,
`ItalicFont=` etc set to sibling filenames the same way) renders the real
typeface. Verified against the rendered preview PNG, not just a clean
compile. The same technique applies to any other named Google/system font
that TeX Live ships as a file but this image's fontconfig doesn't register
by name.

## Building

    xelatex main
    xelatex main

Two passes resolve the layout; there is no bibliography.

## Licence

**MIT**, © Christian Bock (2020). Full licence text is in upstream's
`LICENSE` at https://github.com/chrisby/prometheusCV. MIT does not require
attribution in the download, but credit is due here: thank you, Christian
Bock.

Upstream's own example content was an elaborate Prometheus/Greek-mythology
joke CV (with `\lipsum` placeholders in two sections) rather than plausible
content a user would edit — replaced entirely with an original CV for a
fictional CS PhD. An unused `prometheus_header.png` (a README screenshot,
not referenced by any `.tex` file) was dropped from the vendored tree.
