# attinormativi

LaTeX class for typesetting Italian normative acts: municipal
regulations, resolutions, statutes, ordinances and similar documents.

Version 1.2 — 25 May 2026  
Author: Federico Gallo <gallofede75@gmail.com>  
Licence: LPPL 1.3c (maintained)

---

## Description

The `attinormativi` class provides a complete typographic framework for
Italian normative acts. It manages the hierarchical structure typical of
such documents (books, titles, chapters, sections, articles, paragraphs),
the institutional title page, dedicated indexes (articles, annexes,
definitions), draft mode with editorial notes, and optional integration
with the `cleveref` package for Italian-language cross-references.

From version 1.2 onwards, the class supports the production of PDFs
conforming to the **PDF/UA-1** standard (ISO 14289-1) via the
`accessible` class option, in compliance with Directive (EU) 2016/2102.
This feature requires LuaLaTeX and TeX Live 2023 or later; all other
engines and all other class features remain available without
restrictions with pdfLaTeX, XeLaTeX and LuaLaTeX.

The class is built on top of the standard `book` class.

---

## Package contents

attinormativi.cls          Class file
attinormativi.dtx          Documented source
attinormativi.ins          Installation file
attinormativi-doc.pdf      Class manual
attinormativi-esempi.tex   Usage example (source)
attinormativi-esempi.pdf   Usage example (compiled)
README.md                  This file
LEGGIMI.md                 Readme in Italian
LICENSE                    Text of the LPPL 1.3c licence

---

## Requirements

### Standard features

TeX Live 2020 or later (or equivalent MiKTeX distribution).  
Supported engines: **pdfLaTeX**, **XeLaTeX**, **LuaLaTeX**.

Required packages (all included in standard distributions):
`iftex`, `tgtermes`, `tgheros`, `tgcursor` (pdfLaTeX only),
`fontspec` (XeLaTeX/LuaLaTeX only), `geometry`, `babel` (with Italian
language support), `microtype`, `xcolor`, `titlesec`, `chngcntr`,
`enumitem`, `hyperref`.

For pdfLaTeX, `inputenc` and `fontenc` are also required; both are
included in the kernel of any standard installation.

The `xparse` package is loaded automatically only on installations with
a LaTeX kernel older than 1 October 2020; on later versions it is
superfluous as the corresponding commands are native.

The optional `cleveref` package enables automatic Italian-language
formatting of cross-references.

### The `accessible` option (PDF/UA-1)

The `accessible` option requires **all three** of the following
prerequisites:

- **LuaLaTeX** as the typesetting engine. With pdfLaTeX or XeLaTeX,
  PDF/UA tagging is not fully supported by the current kernel: the
  class issues a `\ClassWarning` and automatically disables tagging;
  compilation continues without fatal errors but the resulting PDF is
  not tagged.
- **TeX Live 2023 or later** (LaTeX kernel ≥ 2023-06-01), which
  includes the automatic tagging framework and the `tagpdf` package.
- **The `\DocumentMetadata` declaration** inserted *before*
  `\documentclass` in the `.tex` file (see the section
  "Usage with the `accessible` option" below). If `\DocumentMetadata`
  is absent, the class issues a `\ClassWarning` and automatically
  disables tagging; compilation again continues without fatal errors.

---

## Fonts

The class uses the **TeX Gyre** family, available in any standard
TeX Live or MiKTeX installation without additional dependencies.

- **Serif**: TeX Gyre Termes (Times New Roman clone)
- **Sans-serif**: TeX Gyre Heros (Helvetica clone)
- **Monospaced**: TeX Gyre Cursor (Courier clone)

With **pdfLaTeX**, the packages `tgtermes`, `tgheros` and `tgcursor`
are loaded. With **XeLaTeX** and **LuaLaTeX**, the corresponding
OpenType fonts are selected via `fontspec`.

---

## Installation

### TeX Live and MiKTeX (normal case)

The class is distributed via CTAN and is included in **TeX Live** and
**MiKTeX**. If you use one of these distributions, no manual file
copying is required: simply update your packages using the distribution
manager.

With TeX Live (from the terminal):

    tlmgr update attinormativi

With MiKTeX: open the **MiKTeX Console**, go to «Updates» and update
the `attinormativi` package, or run from the terminal:

    miktex packages update attinormativi

### Local installation for a single project

For occasional use, it is sufficient to copy `attinormativi.cls` into
the same folder as the `.tex` file to be compiled, without modifying
the TEXMF tree.

### Regenerating from source

To regenerate `attinormativi.cls` from the documented source:

    latex attinormativi.ins

---

## Basic usage

```latex
\documentclass[draft, serif, simplex, 12pt]{attinormativi}

\autoritaatto{Municipality of Esempiopoli}
\tipoatto{Regulation}
\numeroatto{3}
\dataatto{17 May 2026}
\titoloatto{Regulation for the management of public spaces}
\oggettoatto{Rules governing the use and temporary concession of municipal public spaces}

\begin{document}
\frontespizioatto
\bozzainfo
\tableofcontents
\indicearticoli

\titolo{General provisions}

\articolo{Purpose and scope}[art:purpose]
\comma{This regulation governs the use of public spaces owned by
the Municipality of Esempiopoli.}

\entrataInVigore{This regulation enters into force on the day
following its publication on the official online notice board.}

\end{document}
```

The complete documentation is available in `attinormativi-doc.pdf`.
Usage examples are in `attinormativi-esempi.pdf`.

---

## Usage with the `accessible` option

To produce a PDF/UA-1 compliant PDF, add the `\DocumentMetadata`
declaration *before* `\documentclass` and include the `accessible`
option:

```latex
\DocumentMetadata{
  pdfversion  = 1.7,
  pdfstandard = UA-1,
  lang        = it-IT,
}
\documentclass[accessible]{attinormativi}
```

The standard class options (`bozza`, `serif`, `sansserif`, `simplex`,
`duplex`, margin options) are all compatible with `accessible`.

The conformance of the resulting PDF can be verified with PAC 2024
(PDF Accessibility Checker, free, Windows) or with Adobe Acrobat Pro
(Tools → Accessibility → Full Check).

---

## Class options

| Option         | Description                                                          |
|----------------|----------------------------------------------------------------------|
| `bozza`        | Draft mode: editorial notes become visible                           |
| `accessible`   | PDF/UA-1 structural tagging — LuaLaTeX + TeX Live 2023+ only         |
| `serif`        | TeX Gyre Termes — all engines (default)                              |
| `sansserif`    | TeX Gyre Heros — all engines                                         |
| `simplex`      | Single-sided layout (default); alias: `oneside`                      |
| `duplex`       | Double-sided layout with asymmetric margins; alias: `twoside`        |
| `left=<dim>`   | Overrides the left margin (default: 35 mm)                           |
| `right=<dim>`  | Overrides the right margin (default: 30 mm)                          |
| `top=<dim>`    | Overrides the top margin (default: 25 mm)                            |
| `bottom=<dim>` | Overrides the bottom margin (default: 25 mm)                         |

---

## Compilation workflow

### Standard workflow (all engines)

At least two compilation passes are needed to populate all indexes
correctly. Replace `lualatex` with `pdflatex` or `xelatex` according
to the engine of your choice:

    lualatex document.tex
    makeindex -s gind.ist document.idx
    makeindex -s gglo.ist -o document.gls document.glo
    lualatex document.tex
    lualatex document.tex

### Workflow with the `accessible` option (LuaLaTeX only)

With the `accessible` option active, compilation must use LuaLaTeX
exclusively. Running `makeindex` for the secondary indexes (`.art`,
`.alg`, `.dfn`) is not required, as they are updated automatically:

    lualatex document.tex
    lualatex document.tex
    lualatex document.tex

### Corrupted auxiliary files

If compilation is interrupted abnormally, the `.aux` file may be
truncated and the subsequent compilation will produce the error:

    File ended while scanning use of \@writefile

The solution is to delete all auxiliary files (`.aux`, `.toc`, `.idx`,
`.glo`, `.art`, `.alg`, `.dfn`, `.out`) and start again from scratch.

---

## Licence

This work may be distributed and/or modified under the conditions of
the LaTeX Project Public License, either version 1.3c or (at your
option) any later version.

https://www.latex-project.org/lppl.txt

This work has the LPPL maintenance status `maintained`.  
The Current Maintainer is Federico Gallo <gallofede75@gmail.com>.

---

## Version history

**v1.2 (25 May 2026)**  
Migration of fonts from the Latin Modern family to the TeX Gyre family:
TeX Gyre Termes (serif), TeX Gyre Heros (sans-serif), TeX Gyre Cursor
(monospaced). With pdfLaTeX the packages `tgtermes`, `tgheros` and
`tgcursor` are loaded; with XeLaTeX and LuaLaTeX the corresponding
OpenType fonts are selected via `fontspec`.  
Added `accessible` option for PDF/UA-1 structural tagging via `tagpdf`
and the LaTeX kernel tagging framework (requires LuaLaTeX + TeX Live
2023+). Structured tagging of the title page (roles `Title` and `P`),
paragraphs (role `P`), normative lists (role `OL`), the `definizioni`
environment (roles `DL`/`DT`/`DD`), the `preambolo` and `relazione`
environments (role `Sect`), annexes (roles `Sect`/`Caption`) and
secondary indexes (role `TOC`). Editorial notes are marked as
`Artifact`. The structural hierarchy `\libro`–`\articolo` is mapped to
heading roles `H1`–`H5`.

**v1.1 (17 May 2026)**  
First stable release with Latin Modern fonts, `duplex` option,
customisable margin options, `\maketitle` alias, `cleveref` support
with Italian names, and various typographic corrections.

**v1.0 (8 May 2026)**  
First public release.
