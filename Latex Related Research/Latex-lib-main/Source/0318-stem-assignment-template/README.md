# STEM Assignment Template

A heavily configurable STEM assignment layout: a title page (three
selectable styles — standard, abstract, or compact), a themeable colour
scheme, IBM Plex Serif/Sans typography, and metadata-driven toggles for
figures, per-section numbering, bibliography style and more — all set
from plain `\metaX` commands at the top of `main.tex`, no need to touch
the package internals.

## Files

- `main.tex` — the assignment. Start here — every `\metaX{...}` line at
  the top is a setting to edit.
- `assets/stemtemplate.sty` — the vendored package (patched, see below;
  not on CTAN).
- `assets/titlepage_standard.tex`, `titlepage_abstract.tex`,
  `titlepage_compact.tex` — the three selectable title-page layouts.
- `assets/frontmatter.tex` — optional front-matter (table of contents
  etc.), `\input` manually if needed.
- `assets/placeholder_logo.png` — a generic placeholder logo graphic.
- `LICENSE` — upstream MIT licence.

## Building

    xelatex main

This template requires **XeLaTeX** (fontspec-based font selection).

## Fonts — patched from upstream

By default the template loads "IBM Plex Serif"/"IBM Plex Sans" as bare
font-family names via fontspec, which goes through fontconfig. Those
families are not fontconfig-registered here even though the underlying
font files are present, so a bare-name load silently produced blank text
(no visible error). This copy patches the default-font branch only to
load the same IBM Plex fonts by OTF filename via kpathsea instead — a
custom `\metaSerifFont`/`\metaSansFont` value (if you set one) is
unaffected and behaves exactly as upstream.

## Key metadata switches

- `\metaTitlePage` — `standard`, `abstract`, or `compact`.
- `\metaShowFigures` — `true` shows real figures; `false` (upstream
  default) draws fast placeholder boxes instead, useful while drafting
  text-heavy sections. Set to `true` (as in this starter) to see the
  actual logo and any figures you add.
- `\metaThemeColour` — a hex code, named colour, or blank for the
  default blue.
- `\metaFinalDraft` — `true` for the submission-quality pass.

## Not included

The upstream repository's `assets/demo.tex`/`demo.pdf` — an internal
feature-by-feature showcase documenting every helper package the
template loads — is not part of this download. It is not referenced by
`main.tex` and is not a starter document.

## Licence

MIT, © 2026 Tyler Bignell.
Source: https://github.com/TylerBignell/LaTeX-AssignmentTemplate
