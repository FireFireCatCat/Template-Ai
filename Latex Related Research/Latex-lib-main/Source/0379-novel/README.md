# novel

A LuaLaTeX class for popular fiction — print-on-demand trim sizes,
PDF/X output, running heads, chapter-opening pages, and scene breaks
(`\scenebreak`). Fills a genre gap: nothing else in this catalogue is
built specifically for print-ready fiction.

Adapted from the class's own official Appendix A sample document
(`novel-documentation.html`), which is a genuine minimal working
example, not placeholder boilerplate. This starter fleshes it out into
a full front-matter sequence (half-title, also-by page, copyright
page, dedication) plus two real chapter openings of original short
fiction, using every macro the sample exercises
(`\SetTrimSize`/`\SetMargins`/`\SetParentFont`/`\SetDecoFont`/
`\ChapterStart`/`\ChapterTitle`/`\scenebreak`).

## Class and fonts

Not bundled — `novel.cls` and its decorative font `NovelDeco.otf` both
ship with TeX Live, along with the Libertinus font family the sample
uses for body/sans/mono/math.

## Licence

Dual: the class's TeX code is LPPL-1.3c; the bundled `NovelDeco.otf`
decorative font is OFL-1.1. Per the upstream README's own statement.
(c) 2017-2024 Robert Allgeyer. Per the author's own README, the class
is feature-complete but no longer actively maintained as of 2024 —
still compiles cleanly on TeX Live 2025.

## Build

```
lualatex main && lualatex main
```
