# SimpleCV

A minimal, classic CV: a two-column contact header, an italic-dated
`topic` list environment for entries, and a numbered bibliography section
for publications. Upstream is CTAN's `simplecv`, by Jean-Marc Lasgouttes.

## Files

- `main.tex` — the CV. Ships with TeX Live, so `simplecv.cls` is not
  bundled here.

## Building

    pdflatex main
    pdflatex main

Two passes resolve the bibliography numbering; there is no external
`.bib` file — references are entered directly via `thebibliography`.

## Licence

**LPPL-1.2**, © Jean-Marc Lasgouttes (2007), verified directly in the
class file's own header. Full licence text:
http://www.latex-project.org/lppl.txt. LPPL does not require attribution
in the download, but credit is due here: thank you, Jean-Marc Lasgouttes.

Worth noting: the class's own docstrip header records that it was
deliberately named `simplecv` rather than `cv` specifically to avoid
colliding with an unrelated CTAN package of that name.

Upstream's own example (`testcv.tex`) was a thin, whimsical fictional
William Shakespeare CV — replaced with a more substantive plausible
original CV (an environmental engineer) exercising the same header/topic/
bibliography structure.
