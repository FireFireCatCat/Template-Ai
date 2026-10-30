# arabdoc — One-line Arabic RTL setup for XeLaTeX

**Version 1.0.0** (2025-01-15)

**Author:** Dr Nibras Abo Alzahab <nibras.abo.alzahab@gmail.com>

A collection of LaTeX packages that simplifies Arabic right-to-left typesetting. Replaces 15–25 lines of fragile preamble with a single `\usepackage` call.

## Overview

| Package | Type | Purpose |
| ------- | ---- | ------- |
| `arabdoc-setup` | .sty | Core RTL stack: bidi + polyglossia + fonts + captions |
| `arabdoc` | .cls | Document classes: article, book, thesis, report |
| `arabdoc-glossary` | .sty | Arabic glossary and acronym styles |
| `arabdoc-bib` | .sty | Arabic bibliography support (biblatex) |

## The Problem

Arabic LaTeX requires a specific package loading order. One mistake causes errors:

```
! Package bidi Error: Oops! you have loaded package hyperref after bidi
```

A correct preamble needs 15–25 lines with exact ordering. `arabdoc-setup` encapsulates all of this.

## Quick Start

### Minimal

```latex
% !TEX program = xelatex
\documentclass[11pt,a4paper]{article}
\usepackage[amiri,captions]{arabdoc-setup}

\begin{document}
\section{المقدمة}
هذا نص عربي.
\end{document}
```

### Using document classes

```latex
\documentclass{arabdoc-article}    % or arabdoc-book, arabdoc-thesis, arabdoc-report
\begin{document}
\section{المقدمة}
هذا نص عربي.
\end{document}
```

### With glossary and bibliography

```latex
\documentclass{arabdoc-article}
\usepackage{arabdoc-glossary}
\usepackage{arabdoc-bib}
\makeglossaries
\addbibresource{refs.bib}

\newarabicacronym{ai}{AI}{Artificial Intelligence}{الذكاء الاصطناعي}

\begin{document}
\acrfull{ai}
\printglossaries
\printbibliography[heading=arabicbib]
\end{document}
```

## Options

| Option | Default | Description |
| ------ | ------- | ----------- |
| `amiri` | yes | Use Amiri font |
| `scheherazade` | | Use Scheherazade New font |
| `lateef` | | Use Lateef font |
| `custom` | | User sets fonts manually |
| `maghrib` | yes | Western numerals (0,1,2...) |
| `arabicdigits` | | Eastern Arabic numerals (٠,١,٢) |
| `gregorian` | yes | Gregorian calendar |
| `islamic` | | Hijri calendar |
| `captions` | off | Arabic caption overrides (الفهرس، الشكل، الجدول) |
| `colorlinks` | off | Colored hyperlinks |
| `legal-sections` | off | Section prefix "المادة" |

## Requirements

- XeLaTeX (TeX Live 2021+ or MiKTeX)
- Amiri font family (or Scheherazade New / Lateef)
- TeX Gyre Termes font (for English text)
- Packages: bidi, polyglossia, fontspec, hyperref, glossaries, biblatex

## Installation

### Local

Copy `tex/` contents to your TeX tree or set `TEXINPUTS`:

```bash
# Linux/macOS
export TEXINPUTS=/path/to/arabdoc/tex:$TEXINPUTS

# Windows PowerShell
$env:TEXINPUTS = "C:\path\to\arabdoc\tex;" + $env:TEXINPUTS
```

### CTAN

```bash
tlmgr install arabdoc    # TeX Live
mpm --install=arabdoc    # MiKTeX
```

## License

LPPL 1.3c
