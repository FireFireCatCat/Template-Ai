# nxtlatex -- LaTeX classes and themes for faculty NXT

**Version:** 1.3
**Date:** 2026-09-24
**License:** LPPL 1.3c (code), OFL 1.1 (font)
**Author:** Volker Reichenberger <volker.reichenberger@reutlingen-university.de>
**CTAN:** https://ctan.org/pkg/nxtlatex

## Description

The `nxtlatex` package provides LaTeX tools for the faculty
*NXT Nachhaltigkeit und Technologie* (Sustainability and Technology)
at Reutlingen University, Germany. It comprises three components:

- **nxtthesis** -- A thesis class based on the standard class
  `report`, so that it can produce tagged, accessible PDFs. Provides a title page with institution metadata (German or English),
  twelve font options, lists of abbreviations and symbols, an index,
  the faculty's declaration of academic integrity including the
  required statement on AI tools, and an option that switches to the
  faculty's mandatory layout rules.

- **nxtbrief** -- A letter-class option (LCO) for KOMA-Script
  `scrlttr2`. Uses the Segoe UI font family.

- **beamerthemeNXT** -- A Beamer presentation theme in the NXT
  corporate design. Uses the Segoe UI font family.

All components require **LuaLaTeX**. Two helper packages are shared by
all three: `nxtlatexcolors` (the colour palette) and `nxtlatexlogos`
(logo macros). The OpenType font `NXT_Logo.otf` contains all logos of
the faculty as glyphs -- nothing to download.

## Files

| File                       | Description                                |
|----------------------------|--------------------------------------------|
| `nxtlatex.dtx`             | Documented source (all components)         |
| `nxtlatex.ins`             | Docstrip install script                    |
| `nxtlatex.pdf`             | Package documentation (German)             |
| `ThesisanleitungNXT.pdf`   | Introduction to LaTeX using this class (German) |
| `Beispielthesis/`          | Complete example thesis with sources (see below) |
| `BeispielbriefNXT.tex/.pdf`  | Example letter                           |
| `BeispielfolienNXT.tex/.pdf` | Example presentation                     |
| `NXT_Logo.otf`             | NXT Logo Font with all faculty logos (OFL 1.1) |
| `OFL.txt`                  | SIL Open Font License 1.1                  |
| `getnxtlogos`              | Installer for university logo and skyline (macOS/Linux) |
| `getnxtlogos.ps1`          | Installer for university logo and skyline (Windows)     |
| `README.md`                | This file                                  |

`latex nxtlatex.ins` generates `nxtlatexcolors.sty`, `nxtlatexlogos.sty`,
`nxtthesis.cls`, `nxtbrief.lco` and `beamerthemeNXT.sty`.

## The example thesis

`Beispielthesis/` is a complete bachelor's thesis on assigning
production tasks to workers. It is meant to be copied and adapted, and
it exercises what the class offers: lists of abbreviations, symbols,
tables and figures, an index, tables spanning several pages and one in
landscape, figures drawn with TikZ, MetaPost and matplotlib, and
typeset source code.

Its numbers are computed, not typed. The programs in
`Beispielthesis/Code/` solve the problem for real -- exactly with GLPK
and heuristically with simulated annealing -- and generate the figures,
the tables and the numbers quoted in the running text. Colours come
from `nxtlatexcolors.sty` by the same route, so LaTeX, TikZ, matplotlib
and MetaPost all use one palette.

The generated files are included, so

```
make -C Beispielthesis pdf
```

builds the thesis with LuaLaTeX alone. Python 3 and GLPK are needed
only to recompute the results:

```
make -C Beispielthesis daten
```

## Installation

`nxtlatex` is part of TeX Live and MiKTeX; a full installation already
contains it.

From the source repository,

```
make install
```

generates the files and copies them into the user's texmf tree. (Not
`l3build install`: it empties `tex/latex/nxtlatex` first, where
`getnxtlogos` puts the logos.) By
hand, run `latex nxtlatex.ins` and copy the five generated files
together with `NXT_Logo.otf` into a directory where TeX can find them,
e.g. `~/texmf/tex/latex/nxtlatex/` (Linux) or
`~/Library/texmf/tex/latex/nxtlatex/` (macOS), then run `texhash`.

Note that the `.cls`, `.sty` and `.lco` files are **generated** from
`nxtlatex.dtx`. Edit the `.dtx`, never the generated files.

Documents are built with LuaLaTeX. A single pass is never enough --
cross-references, the bibliography, the index and the lists of
abbreviations and symbols each need their own run:

```
lualatex  Document
biber     Document
makeindex Document
lualatex  Document
lualatex  Document
```

## Usage

### nxtthesis

```latex
\documentclass[german,gyre]{nxtthesis}
\title{Title}
\author{Author Name}
\adresse{Street, ZIP City}
\matrikelnummer{1234567}
\akademischergrad{Bachelor of Science}
\studiengang{Sustainable Technology}
\abgabedatum{31 March 2027}
\erstpruef{Prof. Dr. First Examiner}
\zweitpruef{Prof. Dr. Second Examiner}
\begin{document}
\maketitle
\tableofcontents
\hauptteil          % switches from roman to arabic page numbers
...
\eigenständigkeitserklärung[ki=keine]
\end{document}
```

#### Declaration of academic integrity

`\eigenständigkeitserklärung` sets the declaration in the wording of
the faculty's guideline (version of 17 December 2025). The guideline
requires a statement on AI tools, chosen with `ki`:

| Value               | Meaning                                              |
|---------------------|------------------------------------------------------|
| `keine`             | no content-generating AI tools were used             |
| `kennzeichnung`     | use was permitted; the tools are listed in the thesis |
| `ohnekennzeichnung` | use was permitted without the duty to list them      |

If `ki` is missing, the class issues a warning. For a thesis also
submitted to a partner university, add
`partnerhochschule={Name}` and optionally `partnerordnung={...}`.
The declaration is always in German, as the guideline provides no
other wording.

#### Class options

`german` (default) or `english` for the main language. With `english`
the title page is in English as well.

Font options -- each combines a text font, a sans companion and a
matching math font:

| Option       | Text font           | Math font       |
|--------------|---------------------|-----------------|
| `gyre`       | TeX Gyre Pagella    | Pagella Math    |
| `libertinus` | Libertinus Serif    | Libertinus Math |
| `segoeui`    | Segoe UI            | Euler Math      |
| `stix`       | STIX Two Text       | STIX Two Math   |
| `fira`       | Fira Sans           | Fira Math       |
| `newtx`      | TeX Gyre TermesX    | Termes Math     |
| `times`      | Times New Roman     | Termes Math     |
| `bookman`    | TeX Gyre Bonum      | Bonum Math      |
| `charter`    | XCharter            | XCharter Math   |
| `garamond`   | EB Garamond         | Garamond Math   |
| `utopia`     | Erewhon (Utopia)    | Erewhon Math    |
| `concrete`   | CMU Concrete        | Euler Math      |

Where a font provides a semibold weight, it is used instead of bold.
`times` has no real small capitals; abbreviations are then set in the
regular shape rather than in faked small capitals, and with
`kapitaelchen` the headings are set sans-serif instead (title and
abbreviations stay serif).

Layout options:

| Option         | Effect                                            |
|----------------|---------------------------------------------------|
| `richtlinie`   | The faculty's mandatory layout: 11 pt, one-and-a-half line spacing, ragged right, 3 cm binding margin, captions 10 pt, continuous numbering of tables, figures and equations, and a prescribed title page. |
| `kapitaelchen` | Title and headings in small capitals instead of bold. |
| `logo`         | The logo "NXT Nachhaltigkeit und Technologie, Reutlingen University" centred above the title. With `richtlinie` it is there anyway, as the faculty prescribes it. |

`ThesisanleitungNXT.pdf` shows every option on the same three pages.

#### Accessibility and PDF/A

The class writes title, author and language into the PDF metadata,
gives the logos alternative texts and provides copyable text for
abbreviations and symbols. For a tagged, accessible PDF (PDF/UA), put

```latex
\DocumentMetadata{lang=de, pdfversion=2.0, pdfstandard=ua-2, tagging=on}
```

before `\documentclass`. This is why `nxtthesis` is based on `report`
since version 1.3: the KOMA-Script classes are not yet compatible with
tagging. `listings` is not compatible by itself; if a thesis uses it,
the class loads the adaptation the LaTeX team provides. The example
thesis is set this way, and veraPDF confirms PDF/UA-2 for it and for
all twelve font options. Use `lang=de` rather than `de-DE`, which
makes biblatex warn about an unknown language. For PDF/A only, use
`pdfstandard=a-2b`.

#### Coming from version 1.2

Up to 1.2 the class was based on KOMA-Script `scrreprt`. Layout and
appearance are unchanged; `\subtitle`, `\addchap` and `\addsec` still
work. Other KOMA commands such as `\KOMAoptions` or `\setkomafont` are
gone.

### nxtbrief

```latex
\documentclass{scrlttr2}
\LoadLetterOption{nxtbrief}
\usepackage[ngerman]{babel}
\begin{document}
\setkomavar{fromname}{Prof. Dr. Name}
\begin{letter}{Recipient\\Address}
\opening{Dear Sir or Madam,}
...
\closing{Kind regards}
\end{letter}
\end{document}
```

### beamerthemeNXT

```latex
\documentclass{beamer}
\usetheme{NXT}
\begin{document}
\frame{\titlepage}
\begin{frame}{Title}
  \begin{itemize}
    \item Item
  \end{itemize}
\end{frame}
\end{document}
```

## Logos

The NXT logos are glyphs in the NXT Logo Font that comes with the
package, taken unchanged from the faculty's corporate design. The
macros from `nxtlatexlogos` are available in all three components:

| Macro              | Logo                                          |
|--------------------|-----------------------------------------------|
| `\nxtzeichen`      | the NXT mark alone                            |
| `\nxtlogo`         | mark and NXT                                  |
| `\nxtlogonut`      | with "Nachhaltigkeit und Technologie"         |
| `\nxthsrtlogo`     | with "Reutlingen University" in addition      |
| `\nxtlogostandard` | standard layout: lines above, NXT below       |

Options: `width`, `height` (default: mark 1 cm high), `schema` =
`farbig` (default), `schwarz`, `weiss`, `weisseTextmarke`,
`weisseZeile`, or individual colours via `zeichenfarbe`, `nxtfarbe`,
`zeilenfarbe` (e.g. CMYK for print), `farbe` for all three, and `alt`
for the alternative text.

```latex
\nxthsrtlogo[width=7cm]
\nxtlogo[height=1cm, schema=weisseZeile]
```

The university logo (which contains the state coat of arms) and the
skyline used in the letter footer are not part of the font. They are
used only by `nxtbrief` and the Beamer theme; `\hsrtlogograu` and
`\hsrtskyline` skip them silently if missing. The installer scripts
download them from the university website and place them in the local
`texmf` tree. In TeX Live the scripts are installed with the
documentation, in `doc/latex/nxtlatex/` below the tree that
`kpsewhich -var-value TEXMFDIST` names.

```sh
sh getnxtlogos                                            # macOS, Linux
powershell -ExecutionPolicy Bypass -File getnxtlogos.ps1  # Windows
```

## The NXT Logo Font

`NXT_Logo.otf` has its own repository,
<https://gitlab.reutlingen-university.de/reichenb/nxt-logo-font>,
included here as the git submodule `font/`. `make font` builds it from
there; `make ctan` always rebuilds it and refuses to run if the
submodule is not at the latest commit of the font repository, so CTAN
always gets the current font.

## Customisation

The components are designed for Reutlingen University's NXT faculty
but can be adapted for other institutions:

- In `nxtthesis`, redefine `\fakultaet` and `\hochschule`.
- In `nxtbrief`, the return address starts with `fromname`; set
  `\setkomavar{backaddress}{...}` for a different one. The right-hand
  column holds the faculty's address; use `nxtbrief.lco` as a template.
- For other logos, redefine the logo macros after loading the class or
  theme, e.g.
  ```latex
  \renewcommand{\nxthsrtlogo}[1][]{\includegraphics[#1]{my-logo.pdf}}
  ```

## Building from source

The package is built with `l3build`:

```
l3build unpack    # generate .cls/.sty/.lco
l3build doc       # typeset nxtlatex.pdf
l3build check     # run the regression tests
l3build ctan      # build the CTAN archive
```

`make ctan` additionally rebuilds the font from the submodule, typesets
the examples and the introduction, and then calls `l3build ctan`. After
cloning, fetch the submodule with `git submodule update --init`.

## License

Copyright (C) 2025--2026 Volker Reichenberger.

This work may be distributed and/or modified under the conditions
of the LaTeX Project Public License, either version 1.3c of this
license or (at your option) any later version.

The font `NXT_Logo.otf` is licensed under the
SIL Open Font License, Version 1.1 (OFL-1.1).
