# Avinal Resume

A compact, dense one-page resume: `\combosection{title}{subtitle}{dates}{body}`
gives a consistent heading/date layout for every job, project and education
entry, with FontAwesome contact icons and a bundled Roboto family. An
`extended` class option toggles extra detail (e.g. a course list under
Education) on and off from one source file via `\ifextended`.

By [Avinal Kumar](https://github.com/avinal).

## Files

- `main.tex` — the CV. Start here.
- `comcv.cls` — the document class, vendored (not on CTAN).
- `fonts/` — the bundled Roboto family (11 weights/styles), loaded by path
  from the class.

Content is a fictional example — upstream's own `resume.tex` is the
author's real CV (employers, GitHub projects, education), which is not
appropriate to redistribute as starter content. `example.tex` from the
original repo (a bare structural skeleton with "Section 1"/"itemA"
placeholders) is not included either; this starter replaces it with a
complete, realistic CV instead.

## A patched icon package

`comcv.cls` originally loaded `fontawesome` (v4), which under XeLaTeX
resolves its glyph font via a bare fontconfig family lookup — this image's
fontconfig only knows DejaVu and the URW base-35 clones (see
`research/README.md`'s font-trap section), so that call fails and the class
does not compile. Patched to `fontawesome5` (`fixed` mode), which resolves
its glyphs via kpathsea instead; `\faEnvelope`/`\faLinkedin`/`\faGithub`/
`\faGlobe`/`\faPhone` have the same names in both versions.

## Building

    xelatex main

(LuaLaTeX also works per upstream; pdfLaTeX does not — `fontspec` is
required unconditionally.) One pass is enough for most edits; two if you
add a `\label`/cross-reference.

## Licence

**LPPL-1.3c**, Copyright 2024 Avinal Kumar. Full licence text:
https://github.com/avinal/resume/blob/main/LICENSE

The bundled Roboto font family is licensed separately under the Apache
License 2.0 — see `fonts/LICENSE.txt`.

This starter document is a fictional example written for
latextemplates.com and carries no additional restrictions.
