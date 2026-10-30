yes

# 0311-beamer-varbox: beamer-varbox (variable-corner beamer boxes)

- Unverified: read from the source, not compiled.
- Source: Source/0311-beamer-varbox/ (origin: https://mirrors.ctan.org/macros/latex/contrib/beamer-contrib/beamer-varbox.zip; licence: GPL and LPPL, README.md:6-7)
- Kind: presentation
- Lib: v3
- Engine: pdfLaTeX-compatible (package needs beamer, pgf, xkeyval; no fontspec or Lua; the shipped beamer-varbox.pdf records Producer pdfTeX-1.40.28)
- Look carried by: mixed (the zip is a CTAN beamer add-on whose code is the .dtx; the package overrides beamer's block templates, beamer and, for the documentation, ltxdoc carry the rest)
- Class origin: tex-distribution-unbundled
- Main file: beamer-varbox.dtx (documentation driver at lines 22-32; no .tex sample and no beamer deck in the zip; other samples: none)
- Read: main yes, zip-local classes and styles all (no .cls or .sty file exists; the package code is the unprefixed lines 89-460 of the .dtx, read in full)

## Verdict
The zip is the source of one CTAN package (`beamer-varbox`, ctan.org/pkg/beamer-varbox, version 2026-05-12, GPL and LPPL), so it is published (W1), is driven by one package option and a few template keys (W2), serves one kind of component, the beamer block box, in any deck (W3), and is printed as `\usepackage[cornerpercent=v]{beamer-varbox}` plus `\setbeamertemplate` lines (W4). That makes one new way, `slide.beamer-template`, parallel to `slide.colourchange` and `slide.pdfpc-movie`. The pgf drawing code inside is that published package's own implementation, not template artwork and not zip-local macro logic, and nothing has to be copied; the documentation driver is plain `ltxdoc` with `dtx.doc`. Verdict `yes`, with the caveat that the zip carries no deck sample beyond its documentation.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` (the .dtx driver, beamer-varbox.dtx:23) options: none. Host class of the package: `class.beamer`, required at load (beamer-varbox.dtx:92-101), no options shown anywhere in the zip. Neither class is bundled (both ship with the TeX distribution; source not read).
- Class-native vocabulary used (ltxdoc): `\DocInput` (30), `\EnableCrossrefs` (26), `\CodelineIndex` (27), `\RecordChanges` (28), `\GetFileInfo` (38), `\fileversion` `\filedate` (44-45), `\changes` (35-36), `\DoNotIndex` (40), `\NewDocElement` (41), `\DescribeOpt` (62), `\marg` (73), `\MaybeStop{\PrintIndex}` (85), `macrocode` (89, 460), `\Finale` (462), short verbatim `|...|` (63, 69, 73).
- Class-native vocabulary (beamer, used by the package code): `\defbeamertemplate*` (423-458), `\usebeamercolor` (157, 162, 173), `\usebeamerfont` (427-456), `\insertblocktitle` (427), element names `block begin`, `block end`, `block alerted begin`, `block alerted end`, `block example begin`, `block example end`.

## Component map
All paths are beamer-varbox.dtx.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (documentation) | 23 | `class.ltxdoc` | no options |
| document class (host of the package) | 92-101 | `class.beamer` | none stated in the zip; the package raises its own error unless beamer is loaded |
| DocStrip documentation driver | 22-32, 38, 62, 85, 89, 460, 462 | `dtx.doc` | `\DocInput{beamer-varbox.dtx}`, `\GetFileInfo{beamer-varbox.sty}`, `\NewDocElement{Opt}{option}`, `\DescribeOpt{cornerpercent}`, `\MaybeStop{\PrintIndex}`, `macrocode`, `\Finale`; no `\AlsoImplementation`, so the default driver stops before the Implementation section is typeset (85 vs 87) |
| index and change history | 26-28, 35-36, 85 | `dtx.doc` | `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\changes{2025-09-11}{2025-09-11}{Initial version}` and `{2026-05-12}` entry; `\PrintIndex` only (no `\PrintChanges`); a makeindex pass as with `bib.bibtex-bst`, a TeX-distribution tool |
| title block | 43-48 | `front.maketitle` | `\title{The \textsf{beamer-varbox} package...}`, `\author{Fabian Fuchs \\ \texttt{email}}`, `\maketitle` |
| author/title note | 43-45 | `front.thanks` | `\thanks{... \fileversion ... \filedate}` |
| abstract | 50-52 | `abs.kernel` | one sentence |
| headings | 54, 60, 77, 87 | `head.kernel` | four numbered `\section`, no restyling |
| inline markup | 43, 55-58, 75 | `mark.kernel` | `\textsf`, `\texttt`, `\textit` |
| manual line breaks | 46, 79, 81 | `sp.manual-space` | `\\` |
| screenshots in the doc | 25, 80-83 | `fig.graphicx` | `\usepackage{graphicx}`; four `\includegraphics[width=0.49\textwidth]` of the PNGs, inline in running text, no float, no caption |
| package load and its one option | 62-75, 105-109 | `slide.beamer-template` | `\usepackage[cornerpercent=<0..1>]{beamer-varbox}`; 0 sharp corners, 1 beamer's standard `rounded`, default 0.3; `\DeclareOptionX{cornerpercent}[0.3]` (107), `\ExecuteOptionsX{cornerpercent=0.3}` (108) |
| block-box template keys | 117-123, 152-155 | `slide.beamer-template` | `cornerpercent` (number), `shadow` (bool, default false in the three begin templates, 423, 437, 450), `width` (length, default `\textwidth`), `upper` `lower` (beamer colour element names), `scheme` |
| `variable rounded` installed as the default block template | 423-459 | `slide.beamer-template` | `\defbeamertemplate*` for `block begin`, `block end`, `block alerted begin`, `block alerted end`, `block example begin`, `block example end` (documented at 55-58) |
| per-element re-selection of the new template | 71-73 | `slide.beamer-template` | `\setbeamertemplate{<element name>}[variable rounded][cornerpercent=<value>]` |
| block colours and fonts the package reads | 152, 426-427, 440-441, 453-454 | `slide.beamer-template` | colour/font elements `block title`, `block body`, `block title alerted`, `block body alerted`, `block title example`, `block body example`; the deck sets them with `\setbeamercolor` and `\setbeamerfont`, the package only reads them |

Not defined anywhere in the zip (class defaults): page geometry, header/footer, fonts, lists, tables, theorems, code listings, bibliography.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| the whole package `beamer-varbox.sty` (generated from the .dtx by the .ins, beamer-varbox.ins:35) | beamer-varbox.dtx:89-460 | yes, to one published way | it is on CTAN, so W1 holds; emitter writes `\usepackage[cornerpercent=v]{beamer-varbox}`; the .sty is made by running DocStrip (a TeX run, not EXTERNAL) or taken from the distribution |
| `beamerboxesvariablerounded` environment, pgf outline of the box (adapted from beamer's `beamerbaseboxes`, 141-148) | beamer-varbox.dtx:149-276, 280-420 | yes, internals of that published package | controlled only by `cornerpercent`, `shadow`, `width`, `upper`, `lower`; not authored per document, so not `ART/class`; nothing copied |
| shadow fading and shading declarations | beamer-varbox.dtx:290-346, 356-364, 381-389 | yes, same | switched by the `shadow` key only |
| keys, registers, `\bmb@zero`, sharp-corner branch | beamer-varbox.dtx:112-139, 204-225, 350-374 | yes, same | `cornerpercent=0` |
| driver loads the package under `ltxdoc` | beamer-varbox.dtx:24 | n/a, documentation driver only | as read, line 92-101 would raise the package's own "needs the beamer class" error there; not part of the template; the shipped PDF's metadata says hyperref was loaded, which this driver does not do (binary beamer-varbox.pdf, `/Creator`), so the PDF was built some other way |
| possible latent defects in the package source (as read, not compiled) | beamer-varbox.dtx:130, 131, 136, 287 | n/a | `\bmb@boxheight` is used from 287 on but only `\bmbboxheight` is allocated (130); `\bmb@prevheight` is allocated twice (131, 136); an upstream matter, it does not change the way |

## Content-opaque
- four PNG screenshots of beamer blocks (default_beamer.png, point_six_option.png, default_option.png, no_rounding.png, 240x180), included inline at beamer-varbox.dtx:80-83
- the compiled beamer-varbox.pdf (output, not source)

## Lib changes
- New ways proposed:
  - `slide.beamer-template`: `beamer-varbox` (CTAN, beamer-contrib, GPL and LPPL), pdf engine, beamer add-on; preamble `\usepackage[cornerpercent=<0..1>]{beamer-varbox}` and `\setbeamertemplate{block begin}[variable rounded][cornerpercent=v,shadow=<bool>,width=<len>]` on the six block-element names.
    - W1: on CTAN (ctan.org/pkg/beamer-varbox read once, version 2026-05-12).
    - W2: one number option and a few key=value keys (bool, length, colour-element names), no code editing.
    - W3: serves one component (the beamer block, alerted block and example block boxes) in any beamer deck, not one document.
    - W4: preamble lines only, no body wrapper; the existing blocks pick it up.
    - Not folded into `slide.beamer-template`: the template name `variable rounded` exists only after the package is loaded, and the package has its own option and keys, as `slide.colourchange` and `slide.pdfpc-movie` stand apart.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
