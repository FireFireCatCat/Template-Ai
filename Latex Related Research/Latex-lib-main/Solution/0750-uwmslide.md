yes

# 0750-uwmslide: UWMSlide (a slide deck on the published `uwmslide` class)

- Unverified: read from the source, not compiled.
- Source: Source/0750-uwmslide/ (origin: https://latextemplates.com/downloads/uwmslide.zip; licence: Artistic per the manifest; the CTAN page of the class names the Perl Artistic License)
- Kind: presentation
- Lib: v5
- Engine: pdfLaTeX-compatible (assumed, not established: the sample loads only `graphicx`, and the class source is neither in the zip nor read; the class dates from 2000, and whether it sets landscape or its logo through a dvips route is unseen)
- Look carried by: class (the zip holds one `main.tex`; the preamble only loads `graphicx` and sets title, author and date, main.tex:1-7; every slide layout is a `uwmslide` environment)
- Class origin: tex-distribution-unbundled (`uwmslide` is on CTAN and listed there as in TeX Live and MiKTeX: Eric Benedict, version 2000-09-26, Perl Artistic License, read at ctan.org/pkg/uwmslide; the zip has no `uwmslide.cls` and the manifest `local_class` column is empty)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip has no .cls, .sty, .def, .cfg or other file besides main.tex; the published `uwmslide.cls` was not read)

## Verdict
yes. The zip is one 87-line sample on the published class `uwmslide`, which is a class way whose source was not read here. The sample defines no macro, environment, counter or drawing of its own (no `\newcommand`, `\def`, `\newenvironment`, TikZ or `picture`: a grep of main.tex finds only `\usepackage{graphicx}` at main.tex:3), so there is no bespoke code in the zip and no `ART` blocker. Everything else it uses is kernel commands. That the class is free of outside tools and works under pdfLaTeX is assumed from its CTAN listing, not checked in source.

## Blockers
none

## Class setting
- Class: `class.uwmslide` options: none (`\documentclass{uwmslide}`, main.tex:1). From the CTAN page only: a slide format with a PowerPoint-like look, landscape and Times Roman by default, title slide built on the standard titlepage, an optional `logo.eps` placed at the upper left of each slide if present. The sample sets no option and the zip ships no logo file; these defaults were not read from the class source.
- Class-native vocabulary used (each takes the slide title as one mandatory argument): `slide` (main.tex:20, 80), `itemslide` (main.tex:13, 74), `doubleslide` (main.tex:26), `leftitem` (main.tex:45), `rightitem` (main.tex:54), `doubleitem` (main.tex:64), and the divider `\slidedivider` inside the two-part environments (main.tex:36, 49, 57, 68). Kernel `\maketitle` gives the title slide (main.tex:11).
- Not confirmed against the class source: the CTAN page names five layouts (a plain titled page, a two-column double slide, an item slide, a left item slide, a right item slide) and does not mention `doubleitem` or a divider command. The sample uses both, so they are recorded as the sample shows them. If the class lacks either, the sample would not build, and the template would be needing a definition the zip does not hold; the README and `uwmslide.cls` are the places to check.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.uwmslide` | no options |
| graphics package | main.tex:3 | `fig.graphicx` | `\usepackage{graphicx}`, no options; loaded, but the body has no `\includegraphics` and no figure |
| title block | main.tex:5-7, 11 | `front.maketitle` | `\title{Power Electronics Lab Update}`, `\author{... \\ University of Wisconsin--Madison}` (a `\\` break inside the author), `\date{\today}`, `\maketitle` |
| plain slide, title plus text | main.tex:20-24, 80-85 | `class.uwmslide` | `slide` environment, title argument, paragraph text |
| item-list slide | main.tex:13-18, 74-78 | `class.uwmslide` | `itemslide` environment, title argument, `\item` rows |
| two-column text slide | main.tex:26-43 | `class.uwmslide` | `doubleslide` environment, title argument; text and display equation left (main.tex:27-35), `\slidedivider` (main.tex:36), table right (main.tex:37-42) |
| left-item slide | main.tex:45-52 | `class.uwmslide` | `leftitem`: `\item` rows left (main.tex:46-48), `\slidedivider` (main.tex:49), text right (main.tex:50-51) |
| right-item slide | main.tex:54-62 | `class.uwmslide` | `rightitem`: text left (main.tex:55-56), `\slidedivider` (main.tex:57), `\item` rows right (main.tex:58-61) |
| double item-list slide | main.tex:64-72 | `class.uwmslide` | `doubleitem`: `\item` rows left (main.tex:65-67), `\slidedivider` (main.tex:68), `\item` rows right (main.tex:69-71) |
| display equation | main.tex:30-32 | `math.kernel` | `\[ ... \]` with `\frac` and `\mathrm` subscripts; no `amsmath` loaded, so kernel display maths; the formula is content |
| table | main.tex:37-42 | `tbl.tabular` | `tabular`, column spec `{lr}`, four rows, no rules, no `array` or `booktabs`; cell text is content |
| vertical skip | main.tex:83 | `sp.manual-space` | kernel `\medskip` before the e-mail line |
| text symbol | main.tex:50, 51, 67, 71 | `font.fontenc-t1` | `\textdegree` (kernel text symbol, the `textcomp` family), four uses |
| page size, margins, fonts, colours, slide number, logo | none in sample | `class.uwmslide` | set inside the class (CTAN: landscape, Times Roman, optional `logo.eps`); the sample sets no option or length and the class source was not read |
| theorems, floats, captions, code, bibliography, index, cross-references, notes | none in sample | none | the sample has none |

## Bespoke code
none. main.tex:1-87 was read in full and defines nothing. The class `uwmslide` is published (CTAN, TeX Live, MiKTeX), so its code is the class way, not zip-local code; it was not read.

## Content-opaque
none

## Lib changes
- New ways proposed: none. The six slide environments and `\slidedivider` are recorded as the vocabulary of `class.uwmslide`, as any published class's own vocabulary is. Considered, not used: `slide.beamer-theme` and the other beamer lines (the class is not beamer), `slide.ppt-slides` (a package over `article`, not this class), `cols.paracol` and `cols.minipage` (how the class builds its two-part slides was not read).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
