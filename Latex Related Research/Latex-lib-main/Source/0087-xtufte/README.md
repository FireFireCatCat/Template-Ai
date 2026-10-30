# xtufte

A Unicode-engine (LuaLaTeX/XeLaTeX) fork of the classic Tufte-LaTeX
book class — margin notes, sidenotes, `newthought` paragraph openers —
extending the already-shipped `tufte-style-book` to OpenType/TrueType
fonts. A real functional gap, not a reskin: the original `tufte-latex`
does not work with Unicode fonts at all.

## What was changed from upstream

- **Bibliography backend forced to bibtex.** The class defaults to
  `biblatex` with the `biber` backend; this catalogue's compile loop
  only runs classic `bibtex`. Forced via
  `\PassOptionsToPackage{backend=bibtex}{biblatex}` before
  `\documentclass`.
- **Dropped features that need things this pipeline doesn't have.**
  The class's own `doc/sample-book.tex` uses a `filecontents` block to
  generate a helper file, the `minted-code` package (needs
  `-shell-escape`), and a bibliography fetched over the network at
  compile time (`\addbibresource[location=remote]{https://...}`).
  None of these work in a sandboxed, offline compile, so this starter
  uses none of them.

## Class

Not bundled — ships with TeX Live. Class documentation: `texdoc
xtufte`.

## Licence

Dual: the base `tufte-latex` is Apache-2.0 (Kevin Godby, Bil Kleb, Bill
Wood); the `xtufte` extension itself is LPPL-1.3, (c) 2025 Herbert Voß.
Per the upstream package's own `README` and class-file header.

## Build

```
lualatex main && bibtex main && lualatex main && lualatex main
```
