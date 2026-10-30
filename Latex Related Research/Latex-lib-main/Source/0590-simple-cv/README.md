# Simple CV

A minimalistic, multi-page academic CV with a proper `biblatex` publications
list. Section macros (`\entrybig`, `\entrymid`, `\denseouterlist`, ...) give
a consistent two-column date/detail layout throughout — education,
experience, teaching, skills/languages side by side, projects, awards, and
volunteering.

By [Doruk Çetin](https://github.com/dcetin), distinct slug from the
catalogue's existing `simple-resume-cv` (a different upstream — collision
avoided on purpose).

## Files

- `main.tex` — the CV. Start here.
- `simplecv.sty` — the document's helper package, vendored (not on CTAN).
- `sections/*.tex` — one file per CV section, `\import`ed from `main.tex`.
- `papers.bib` — publications, printed via `biblatex`.

All CV content (name, jobs, education, publications, awards) is a fictional
example — upstream's own repository ships the actual author's real CV data,
which is not appropriate to redistribute as starter content.

## Two patches

1. **Bibliography backend.** Upstream loads plain
   `\usepackage[style=ieee,...]{biblatex}`, which defaults to `biber` — this
   pipeline runs classic `bibtex`. `main.tex` forces the backend explicitly
   with `\PassOptionsToPackage{backend=bibtex}{biblatex}` before
   `\documentclass`; the rendered PDF's publication entry was confirmed to
   show the real citation, not `[?]`.
2. **FontAwesome.** `simplecv.sty` originally loaded `fontawesome` (v4),
   whose XeLaTeX code path resolves its glyph font through a bare fontconfig
   family lookup — this image's fontconfig only knows DejaVu and the URW
   base-35 clones, so that call fails. Patched to `fontawesome5` (`fixed`
   mode), which resolves its glyphs via kpathsea instead; the `\faEnvelope`
   / `\faGlobe` / `\faGithub` / `\faLinkedin` commands used in `main.tex`
   have the same names in both versions.

## Adding a photo

Uncomment the `\headingphoto{...}{...}{photo.png}` block in `main.tex` (and
comment out `\headinginline`) after dropping a `photo.png` next to
`main.tex` — no photo is bundled with this download.

## Building

    xelatex main
    bibtex main
    xelatex main
    xelatex main

(`just compile` in this repo runs exactly this sequence.)

## Licence

**MIT**, © Doruk Çetin. Full licence text:
https://github.com/dcetin/Simple-CV/blob/main/LICENSE

This starter document is a fictional example written for
latextemplates.com and carries no additional restrictions.
