# Curriculum Vitae (Sumukh Prasad)

A two-column CV: a small-caps name header with contact details flushed
right, then each section's label sits in a narrow left column beside its
content in a wider right column (`\cvsection[Label]{...}`), with a
`detail` environment for title/date-range entries underneath.

By Sumukh Prasad.

## Files

- `main.tex` — the CV. Start here.

No class file is bundled: `curriculum-vitae.cls` already ships in this
TeX Live install (`kpsewhich curriculum-vitae.cls` resolves it), and the
copy checked from CTAN is byte-identical to the one in the pinned image.

## One engine, not two

This template appeared twice in the source research data, tagged with two
different engines (lualatex and pdflatex) for what is one CTAN package. The
class unconditionally `\RequirePackage{fontspec}` and loads FiraSans
through it, so pdflatex was never actually viable — shipped here as
xelatex, the engine both listings could plausibly have meant.

## A minor cosmetic quirk

The `detail` environment's date field always prints `#2 -- #3` even when
both are left empty (e.g. a skills list with no date range) — you'll see a
bare "--" hanging in the date column. Harmless, but worth knowing before
you assume something failed to render; pass a real value or a short label
in the date argument if you want to avoid it.

## Building

    xelatex main

One pass is enough — no bibliography, no cross-references.

## Licence

**Apache-2.0**, © 2023 Sumukh Prasad. Full licence text is included
verbatim in the package's own README:
https://ctan.org/pkg/curriculum-vitae

This starter document is a fictional example written for
latextemplates.com and carries no additional restrictions.
