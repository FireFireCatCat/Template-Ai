# Die TeXnische Komoedie (dtk)

Article template for *Die TeXnische Komödie*, the quarterly journal of
DANTE e.V. (the German-speaking TeX Users Group). The class is official —
maintained by the journal's own typesetters — but check DANTE e.V.'s current
author guidelines before submitting, since a bundled starter can go stale.

- **Engine:** LuaLaTeX only. The class refuses to load under pdflatex or
  XeLaTeX.
- **Language:** the journal publishes primarily in German; this starter uses
  `\documentclass[ngerman]{dtk}` with babel.
- **Bibliography:** the class hardcodes biblatex's `biber` backend
  (`\RequirePackage[backend=biber]{biblatex}`). This starter ships a real
  `main.bib` and compiles via the full `lualatex → biber → lualatex →
  lualatex` cycle.
- The `dtk` class itself is not included — it ships with any current TeX Live
  install (and with the compiler behind this site), so bundling a copy would
  only risk shipping an older version than you already have.

Licence: LPPL-1.3c, (c) Rolf Niepraschk, Herbert Voß. See
<https://ctan.org/pkg/dtk>.
