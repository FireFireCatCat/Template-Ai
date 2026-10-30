# OpenCurVe Resume

A CJK-capable single-page resume: icon-linked contact header, a
photo/badge box, and coloured "brand banner" employer blocks (background
tint + accent stripe + icon glyph) for internship/work experience — styled
on top of Didier Verna's CurVe class. A distinct visual style from the
site's other CJK-capable CV (`resumecls`, plain `ctexart`-based). Upstream
is `heylong7/OpenCurve-Resume`.

## Files

- `main.tex` — sets the header/photo box, then `\input`s each section.
- `sections/*.tex` — one file per CV section.
- `open-curve.sty` — the style layer, vendored and **patched** (see below).
- `engine.txt` — `xelatex` (uses `xeCJK`/`fontspec`).

`curve.cls` itself is **not** vendored — it already ships with TeX Live
(same class as this site's plain-English `curve` template).

## The font fallback is patched — read this before touching `\setmainfont`

Upstream's `open-curve.sty` uses `\IfFontExistsTF{Times New Roman}` /
`\IfFontExistsTF{Microsoft YaHei}` to prefer those commercial fonts when
present and otherwise fall back to `TeX Gyre Termes` / `FandolHei-Regular`
— sensible in principle. On this compiler, `\IfFontExistsTF` correctly
reports both commercial fonts absent (they are real "not installed"
negatives, not a bug) and takes the fallback branch — but **the fallback
branch was also broken**: `fontspec`/`xeCJK` resolve bare family names
through `fontconfig`, and this image's `fontconfig` only registers 14 base
families (verified with `fc-list`), not TeX Live's own font tree. So
`\setmainfont{TeX Gyre Termes}` and `\setCJKmainfont{FandolHei-Regular}`
(no extension) **also** fail — fontspec logs "font cannot be found... not
loadable", and every character renders as nothing, with zero compile
errors.

Fixed here: both branches load their font by **exact filename with
extension** (`texgyretermes-regular.otf`, `FandolHei-Regular.otf`, etc),
which resolves through `kpathsea` instead of `fontconfig` and does index
the TeX Live font tree. The `\IfFontExistsTF` branch-selection itself was
removed rather than patched, since Times New Roman and Microsoft YaHei are
commercial fonts absent from any FOSS TeX Live regardless of fontconfig —
the branch they guarded was always going to hit the fallback on this
compiler. Verified against the rendered preview PNG that real Latin serif
and CJK glyphs render, not blank space.

## Building

    xelatex main
    xelatex main

Two passes resolve the layout; there is no bibliography.

## Licence

**MIT**, generic "OpenCurVe Resume contributors" holder (no individual
copyright name given). Full licence text is in upstream's `LICENSE` at
https://github.com/heylong7/OpenCurve-Resume. MIT does not require
attribution in the download.

Upstream's own example content used two **real companies' names and one
real trademarked logo image** (ByteDance, including a bundled
`assets/bytedance-color.png`) as a demonstration of the brand-banner
styling feature, plus literal "your name" / "your project name" / "please
substitute your real numbers" placeholder text. Replaced with a fully
fictional CV throughout: a placeholder name and handle, two fictional
employers using the class's own icon-glyph banner style (no logo image
needed, so the trademarked asset was dropped rather than shipped), and
concrete plausible metrics in place of fill-in-the-blank instructions.
