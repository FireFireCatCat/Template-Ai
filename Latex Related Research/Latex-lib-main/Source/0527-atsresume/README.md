# atsresume

A LaTeX class for a resume whose PDF text comes out complete and in reading
order, which is what applicant tracking systems (ATS) need to parse it.

Version 1.0.0, 2026-10-20

## What it does

The layout is a single column: your name centered at the top, section
headings in capitals over a thin rule, and places and dates on the right
margin. It's the Classic template from ReadableResume, where the same design
is available for Google Docs and Word.

The class also handles the things that make a PDF hard for a parser to read:

- Places and dates are pushed to the right margin with glue, not set in a
  table or a second column, so every line is stored left to right.
- Ligatures are off, so "fi" and "fl" come out as two letters.
- Hyphenation is off, so no word is split across two lines.
- Bullets are the text font's U+2022 character, and every glyph maps back to
  Unicode.
- A section heading or the first lines of an entry never end a page.

The example was compiled with pdfLaTeX, LuaLaTeX and XeLaTeX, on US Letter
and on A4. In each of the six PDFs, `pdftotext -layout` gave back the text
word for word and in reading order, and OpenResume, an open-source resume
parser, returned every value it reads exactly as written: the name and
contact details, each job, school and project with its dates, and every
bullet point and skills line. How well a particular ATS fills in its own
fields still depends on that system.

A resume looks like this:

```
\documentclass{atsresume}   % or \documentclass[a4paper]{atsresume}
\name{Your Name}
\contact{City, ST}
\contact{\email{you@example.com}}

\begin{document}
\makeheader

\section{Experience}
\experience{Company}{City, ST}{Job Title}{Jun 2024 – Present}
\begin{itemize}
  \item What you did, with a number if you have one
\end{itemize}
\end{document}
```

## Files

- `atsresume.cls`: the class
- `atsresume-doc.pdf` and `atsresume-doc.tex`: the documentation
- `atsresume-example.pdf` and `atsresume-example.tex`: a sample one-page
  resume

## Requirements

pdfLaTeX, LuaLaTeX or XeLaTeX, and LaTeX from November 2021 or later. The
class loads geometry, hyperref, iftex, and microtype (pdfLaTeX) or fontspec
(LuaLaTeX, XeLaTeX), and sets the text in TeX Gyre Pagella. TeX Live's small
scheme has all of these. It was tested with TeX Live 2026, and with the TeX
Live packages of Debian 12 and Ubuntu 22.04. On Debian and Ubuntu, Pagella comes in
the tex-gyre and fonts-texgyre packages, which apt installs along with
texlive-fonts-recommended unless recommended packages are turned off.

## Installation

If your TeX distribution includes atsresume, there's nothing to install.
Otherwise put `atsresume.cls` in the same folder as your `.tex` file, or in
`tex/latex/atsresume/` in your local texmf tree.

## Credits

The class, its tests and this documentation were drafted with an AI assistant. Super Lede reviewed and tested them before release.

## License

Copyright 2026 Super Lede.

This material is subject to the LaTeX Project Public License 1.3c or later.
The work has the LPPL maintenance status "maintained", and the current
maintainer is Super Lede. It consists of `atsresume.cls`,
`atsresume-example.tex` and `atsresume-doc.tex`, and the PDFs made from them.

The person, schools and companies in the example are made up.

## Contact

Super Lede, templates@readableresume.com. Questions and bug reports are
welcome by email.

Home page: https://readableresume.com
