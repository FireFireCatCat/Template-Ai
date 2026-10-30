# relatese

`relatese` is a small LaTeX helper package for scientific reports, lecture notes, and related academic documents.

It provides a compact set of defaults and optional modules for common report-writing tasks: page geometry presets, figure and table helpers, mathematical notation shortcuts, scientific-writing tools, bibliography setup, hyperlinks, and clever references.

The package is organized as a documented LaTeX source (`.dtx`) plus an installer (`.ins`). The generated `relatese.sty` file should be treated as a derived file.

## Status

This package is currently in early development.

The public interface is mostly stable, but option names and helper commands may still change before a first CTAN release.

## Features

The core package loads broadly useful packages and applies conservative defaults for:

- page geometry through `geometry`;
- graphics through `graphicx`;
- captions through `caption`;
- tables through `booktabs`;
- lists through `enumitem`;
- colors through `xcolor`;
- basic mathematics through `amsmath` and `bm`;
- microtypographic improvements through `microtype`.

Additional features are enabled with package options.

## Installation

For local use, place the generated `relatese.sty` file somewhere LaTeX can find it, for example in the same directory as your document:

```text
my-document/
├── main.tex
└── relatese.sty
```

Then load it with:

```latex
\usepackage{relatese}
```

For a local TeX tree installation, place the package under a suitable directory such as:

```text
~/texmf/tex/latex/relatese/
```

and refresh the filename database if your TeX distribution requires it.

## Generating the package

The package source is maintained in `relatese.dtx`.

To generate `relatese.sty`, run:

```bash
latex relatese.ins
```

To build the documentation, run:

```bash
pdflatex relatese.dtx
```

For a cleaner build, `latexmk` can be used:

```bash
latexmk -pdf relatese.dtx
```

The generated files should normally not be edited by hand. Edit `relatese.dtx` instead.

## Basic usage

A minimal document can load the core package without options:

```latex
\documentclass[a4paper]{article}
\usepackage{relatese}

\begin{document}

\section{Introduction}

This document uses the core defaults provided by \textsf{relatese}.

\end{document}
```

The paper size should be selected by the document class. The geometry presets provided by `relatese` change margins only; they do not force `a4paper` or `letterpaper`.

## Package options

Options can be combined in the usual LaTeX way:

```latex
\usepackage[math,sciencecomma,refs]{relatese}
```

### `layout`

Loads additional packages for document layout and structure, such as `changepage`, `multicol`, `authblk`, `setspace`, `indentfirst`, `tocloft`, `lastpage`, `titlesec`, and `footmisc`.

Use this option when the document layout is controlled by the author.

```latex
\usepackage[layout]{relatese}
```

### `math`

Loads additional mathematical tools and defines notation helpers for derivatives, differentials, inner products, chi-square notation, Roman numerals, prime marks, slanted parallel marks, and unit vectors.

```latex
\usepackage[math]{relatese}
```

Example:

```latex
\[
  \dd{f}{x}
  \qquad
  \ddp{f}{t}
  \qquad
  \vperp
  \qquad
  \vpar
\]
```

### `figures`

Loads figure-related tools: `float`, `subcaption`, `placeins`, `pdflscape`, and `svg`.

Use this option for subfigures, float barriers, landscape pages, forced float placement, or SVG inclusion.

```latex
\usepackage[figures]{relatese}
```

### `tables`

Loads additional table tools: `colortbl` and `makecell`.

Use this option for colored rows or cells and multi-line table cells.

```latex
\usepackage[tables]{relatese}
```

### `science`

Loads `siunitx` and `mhchem`.

Use this option for physical quantities, units, chemical formulae, and chemical reactions.

```latex
\usepackage[science]{relatese}
```

Example:

```latex
The sample thickness was \SI{10}{\micro\meter}.

\[
  \ce{H2O -> H^. + OH^.}
\]
```

### `sciencecomma`

Loads the same tools as `science`, but configures `siunitx` to use a decimal comma.

```latex
\usepackage[sciencecomma]{relatese}
```

This is useful for Portuguese and other decimal-comma conventions.

### `refs`

Loads the complete reference setup: `csquotes`, `biblatex`, `hyperref`, and `cleveref`.

```latex
\usepackage[refs]{relatese}
```

The bibliography backend is `biber`, with numeric compressed citations, sorting by order of appearance, back-references, and superscript autocitations.

Example:

```latex
\addbibresource{references.bib}

As discussed in \autocite{key}, ...

See \cref{sec:method}.

\printbibliography
```

Documents using this option should be compiled with `biber`.

### `biblatex`

Loads only `csquotes` and `biblatex`, using the package bibliography defaults.

```latex
\usepackage[biblatex]{relatese}
```

Use this when you want the bibliography setup without automatically enabling `hyperref` and `cleveref`.

### `cleveref`

Loads `cleveref`, loading `hyperref` first when needed.

```latex
\usepackage[cleveref]{relatese}
```

No explicit language option is passed to `cleveref`; language selection should be handled by `babel` or `polyglossia`.

### `drafttools`

Loads tools useful while drafting. Currently this enables `lipsum`.

```latex
\usepackage[drafttools]{relatese}
```

### `full`

Enables the main working set of modules:

```latex
\usepackage[full]{relatese}
```

This is intended for documents that use most of the package conventions. For documents subject to journal, publisher, or institutional formatting requirements, prefer enabling only the specific options needed.

## Geometry presets

Since `geometry` is part of the core package, geometry presets are always available.

Use a preset in the preamble with:

```latex
\setgeometry{standard}
```

Available presets:

| Preset | Margins | Intended use |
|---|---|---|
| `standard` | `hmargin=2.5cm, vmargin=3.5cm` | General reports and default use. |
| `compact` | `hmargin=2cm, vmargin=2.5cm` | Shorter documents or drafts with less white space. |
| `wide` | `hmargin=2cm, top=2.5cm, bottom=3cm` | Documents needing a wider text block. |
| `binding` | `inner=3cm, outer=2cm, top=3cm, bottom=3.5cm` | Printed documents that need extra inner margin for binding. |
| `draft` | `hmargin=3cm, vmargin=3.5cm` | Drafts with larger margins for notes and corrections. |

For temporary changes inside the document body, use:

```latex
\newsetgeometry{compact}
```

and return to the previous geometry with:

```latex
\restoregeometry
```

## Development workflow

A typical development cycle is:

```bash
latex relatese.ins
latexmk -pdf relatese.dtx
```

Before committing, check that:

- `relatese.sty` can be extracted from `relatese.dtx`;
- the documentation builds without errors;
- examples compile with the intended engines;
- generated auxiliary files are not committed unless intentionally tracked.

Suggested tests:

```bash
latex relatese.ins
pdflatex relatese.dtx
```

Then test small documents using:

```latex
\usepackage{relatese}
\usepackage[math,sciencecomma]{relatese}
\usepackage[full]{relatese}
```

## Repository layout

A recommended repository layout is:

```text
relatese/
├── README.md
├── LICENSE
├── relatese.dtx
├── relatese.ins
├── relatese.pdf
├── examples/
│   ├── basic.tex
│   ├── science.tex
│   └── full.tex
└── CHANGELOG.md
```

The generated `relatese.sty` may be included for convenience, but the canonical source is `relatese.dtx`.

## License

This project is intended to be distributed under the LaTeX Project Public License, version 1.3c or later.

## Author

Francisco M Neto
