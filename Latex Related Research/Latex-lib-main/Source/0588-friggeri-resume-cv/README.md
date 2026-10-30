# Friggeri Resume/CV (A4)

An A4 port of Adrien Friggeri's widely-circulated CV design: a colored
sidebar for contact/languages/skills, and a dated two-column entry list for
everything else. This starter uses the **A4** port
(`depressiveRobot/friggeri-cv-a4`); the original is US Letter only.

## Files

- `main.tex` — the CV. Start here.
- `friggeri-cv-a4.cls` — the document class, vendored (see below).

## The class is vendored, the fonts are not

`friggeri-cv-a4.cls` is not on CTAN, so it is bundled directly from
upstream. Upstream's own repo also bundles copies of Lato and TeX Gyre
Heros (a free Helvetica-alike) as font files sitting next to the class —
this download does not carry those, because the class already references
them as bare filenames with extensions (`texgyreheros-regular.otf`,
`Lato-Light.ttf`), and `fontspec` resolves a name shaped like a filename
through kpathsea rather than through fontconfig. Both fonts are already in
this TeX Live install, verified with `kpsewhich texgyreheros-regular.otf`
and `kpsewhich Lato-Light.ttf` inside the pinned compiler image, so no
`Path=` or bundled copy is needed. (Contrast this with `deedy-resume-cv` in
this catalogue, whose class called `\fontspec{Lato-Light}` with no
extension — a bare name, which fontspec looks up via fontconfig instead and
silently fails to load.)

## Building

    xelatex main

This class needs XeLaTeX (via `fontspec`); it will not compile under
pdflatex. One pass is enough (no bibliography, no cross-references — the
upstream version's optional publications section, which draws on
`biblatex`/`biber` against a `.bib` file, has been removed from this
starter for simplicity; the class still supports it if you add a `.bib`
file, `\addbibresource{...}` and the `\section{publications}` block back
in — compile with `biber`, not `bibtex`, if you do).

## A licence note

Do not trust this template's own header comment: the `.tex` file upstream
carries a comment claiming "CC BY-NC-SA 3.0", copied forward from an
earlier, unrelated site's re-licensing of Friggeri's work. The repository's
actual `LICENSE` file is **MIT**, covering both Adrien Friggeri's original
and Marvin Frommhold's A4 fork, and is the one that governs use of this
download.

## Licence

`friggeri-cv-a4.cls` is licensed **MIT**, © 2012 Adrien Friggeri (original),
© 2017 Marvin Frommhold (A4 fork). Full licence text is in the repository's
`LICENSE` file at https://github.com/depressiveRobot/friggeri-cv-a4.

This starter document is a minimal example written for latextemplates.com
and carries no additional restrictions.
