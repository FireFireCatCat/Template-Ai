no

# 0078-garrettj403-thesisplots: ThesisPlots (matplotlib style files for thesis plots, with a 68-line LaTeX demo)

- Unverified: read from the source, not compiled.
- Source: Source/0078-garrettj403-thesisplots/ (origin: https://codeload.github.com/garrettj403/ThesisPlots/zip/refs/heads/master; licence: not established)
- Kind: misc (the manifest hint "thesis" is wrong: the zip is a Python/matplotlib style set; its only LaTeX is a demo of PDF versus PGF figures)
- Lib: v1
- Engine: pdfLaTeX-compatible (the sample loads only graphicx, subcaption, xcolor, pgfplots, geometry, amssymb; the shipped examples/tex/document.pdf carries `/Producer (pdfTeX-1.40.18)`; fontspec appears only in a comment inside the matplotlib-generated examples/figures/fig1.pgf:17)
- Look carried by: mixed (the LaTeX demo is amsart defaults plus one geometry call; the look the zip actually defines is matplotlib rcParams in `*.mplstyle`, which is not LaTeX)
- Class origin: tex-distribution-unbundled
- Main file: examples/tex/document.tex (other samples: none; examples/tex/document.pdf is shipped output, examples/figures/fig1.pgf and fig2.pgf are matplotlib-generated figure content)
- Read: main yes, zip-local classes and styles none present (no `.cls`, `.sty`, `.def`, `.cfg`, `.clo`, `.bst`, `.dtx` in the zip). Also read in full: README.md, Makefile, thesis.mplstyle, subfigure.mplstyle, slim-subfigure.mplstyle, examples/plot_single.py, examples/plot_subfigure.py; fig1.pgf only in part (header and a grep for fonts and images; 2514 lines of generated drawing commands, not read line by line).

## Verdict
`no`, on the `NOTEMPLATE` ruling plus `EXTERNAL`. The zip is a Python tool: its README says it is "two matplotlib style files" (README.md:10), and the only LaTeX file is a demonstration document with no macro, class, style or template definition in it (grep for `newcommand`, `def`, `newenvironment`, `newcounter`, `RequirePackage` finds nothing in examples/tex/document.tex). Read on its own, that demo would map to published ways without difficulty (table below). That would say nothing about templates, so this zip should be replaced and not counted as evidence either way. The thing the zip defines (colour cycle, tick style, figure size, font settings for plots) lives in matplotlib configuration and is applied by Python (examples/plot_single.py:3,17-19; examples/plot_subfigure.py:3,17-18), outside TeX.

## Blockers
- `NOTEMPLATE/zip` no LaTeX template, class or style in the zip; it is a matplotlib style tool with a demo document (README.md:10; zip file list has no `.cls`/`.sty`). No one of the four scope words fits a whole-zip property, so "zip" is used.
- `EXTERNAL/body` the figures the demo shows are produced by Python and matplotlib using the style files, not by TeX (examples/plot_single.py:17-19 writes fig1.pdf, fig1.pgf, fig1.jpg; examples/plot_subfigure.py:17-18 writes fig2.pdf, fig2.pgf; Makefile:2-5 copies the styles into `~/.matplotlib/stylelib/`). The shipped `.pgf` and `.pdf` are static output, so document.tex itself needs no Python; the part of the zip that defines a look does.

## Class setting
- Class: `class.amsart` options: `11pt` (examples/tex/document.tex:1). Source not read (ships with the TeX distribution; it is not in the zip).
- Class-native vocabulary used: none. The sample has no `\title`, `\maketitle`, `abstract`, `\section` or theorem; its "headings" are plain `{\huge ...}` groups (document.tex:14,35).

## Component map
Rows for document.tex are what an emitter would need if the demo were counted. The last row is a fragment from a non-LaTeX file.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | document.tex:1 | `class.amsart` | 11pt |
| paper and size | document.tex:1,3 | `page.class-options` | 11pt (class option); `\geometry{a4paper}` |
| page geometry | document.tex:2-3 | `page.geometry` | margin=1in, a4paper (second call via `\geometry`) |
| figure float, image | document.tex:16-20,22-26 | `fig.graphicx` | placement `[h!]`, `\centering`, `\includegraphics[width=0.55\textwidth]{../figures/fig1.pdf}` |
| subfigures | document.tex:6,37-51,53-67 | `fig.subcaption` | `subfigure[b]{0.49\textwidth}` x2, each `\centering` + image/`\input`, `\caption{}` empty (label only), `\hfill` between, outer `\caption` |
| figure caption | document.tex:19,25,50,66 | `cap.kernel` | `\caption{PDF figure}` and `\caption{PGF figure}`, text only |
| caption package (implicit) | document.tex:6 | `cap.caption` | loaded by `subcaption`, no options set; subcaption source is not in the zip and was not read |
| sizes as headings | document.tex:14,29-30,35 | `font.size-commands` | `\huge` |
| colour | document.tex:7,29-30 | `color.xcolor` | `\textcolor{red}{...}`, no `\definecolor` |
| centred block | document.tex:28-31 | `sp.ragged` | `center` environment |
| manual breaks and fill | document.tex:29,43,59 | `sp.manual-space` | `\\`, `\hfill` |
| page break | document.tex:34 | `pg.break` | `\newpage` |
| math symbols | document.tex:5 | `math.amssymb` | loaded, nothing from it used in the body |
| PGF picture content | document.tex:10,24,57,63 | `art.tikz` | `pgfplots` loaded ("THIS PACKAGE IS REQUIRED"); matplotlib `.pgf` read with `\input`; inside floats, so content |
| matplotlib usetex preamble (not in the document) | thesis.mplstyle:45 | `math.amsmath`, `art.tikz`, `font.fontenc-t1` | `\usepackage{amsmath}, \usepackage{pgfplots}, \usepackage[T1]{fontenc}`; this is a string handed to LaTeX by matplotlib when `text.usetex : True` (thesis.mplstyle:44) |

Not present in the sample (so nothing to map): headers/footers, title block, abstract, contents, sectioning, numbering changes, lists, quotes, notes, display maths, theorems, tables, code, boxes, bibliography, index, cross-references (`\label`/`\ref`), language setting.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| LaTeX macros, environments, counters | examples/tex/document.tex | none exist | grep for `newcommand`, `renewcommand`, `def`, `newenvironment`, `newcounter`, `if`, `RequirePackage`, `makeatletter` finds nothing |
| matplotlib style `thesis` | thesis.mplstyle:1-45 | no (not LaTeX, no lib way) | rcParams: `axes.prop_cycle` colour list (line 4), `figure.figsize` 3.5 x 2.625 (6), tick direction in, sizes and minor ticks (9-25), line widths (28-30), `legend.frameon` False (33), `savefig.bbox` tight (36-37), `font.family` serif and `font.serif` Times New Roman (40-41), `text.usetex` True (44) |
| matplotlib style `subfigure` | subfigure.mplstyle:3-8 | no | `figure.figsize` 2.9 x 2.625, font sizes 9 |
| matplotlib style `slim-subfigure` | slim-subfigure.mplstyle:3-8 | no | `figure.figsize` 2.9 x 2.2, font sizes 9 |
| plotting scripts | examples/plot_single.py, examples/plot_subfigure.py | no | Python, numpy and matplotlib feeding figure data and saving PDF, PGF, JPG |
| install Makefile | Makefile:2-5 | no | `cp` of the three style files into `~/.matplotlib/stylelib/` |

## Content-opaque
- matplotlib PGF pictures `\input` inside figure floats (document.tex:24,57,63; examples/figures/fig1.pgf and fig2.pgf, generated, `\pgfpicture` drawing commands with `\pgftext` using `\rmfamily\fontsize{10}{12}\selectfont`, e.g. fig1.pgf:96)
- included PDF figures (document.tex:18,41,47)
- No text addressed to an AI was found in the zip.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
