no

# 0600-beamer-tut-pt: Beamer tutorial in Portuguese (article-class tutorial plus a Berkeley-theme beamer example deck)

- Unverified: read from the source, not compiled.
- Source: Source/0600-beamer-tut-pt/ (origin: https://mirrors.ctan.org/info/portuguese/beamer.zip; licence: GNU FDL 1.2 per src/LEIAME:3-8, the manifest says "gpl")
- Kind: presentation (the zip is a tutorial article about beamer plus one beamer deck; the deck is the template-bearing sample, the tutorial is plain article)
- Lib: v5
- Engine: pdfLaTeX-compatible (the deck); the tutorial was built through latex + dvipdfm because it includes `.ps` images, see Blockers
- Look carried by: class (article defaults for the tutorial; beamer with `\usetheme{Berkeley}` for the deck; the preambles only pick language, encoding, theme and a logo image)
- Class origin: tex-distribution-unbundled (article is LaTeX base, beamer is on CTAN; neither is in the zip)
- Main file: src/tutorialbeamer.tex (other samples: src/exemplo/exemplo.tex)
- Read: main yes, zip-local classes and styles none present (the zip holds no .cls, .sty, .def, .cfg; both .tex files, README and src/LEIAME were read in full; the beamer, article and pgf sources were not read)

## Verdict
No. Nothing in the zip is bespoke: there is no `\newcommand`, `\def`, environment, counter, class or style, and no template-defining artwork. Every component maps to a lib way (one new way is proposed for slide transitions). The one blocker is `EXTERNAL/body`: the tutorial includes 18 `.ps` PostScript pictures with plain `graphicx` and no `epstopdf` (src/tutorialbeamer.tex:216 and 17 more calls), so it only builds through the DVI route (the shipped `tutorialbeamer.pdf` says `/Producer(dvipdfm 0.13.2c ...)` and `/Creator( TeX output 2006.04.24:2159)`); the lib rules that an EPS inclusion under pdfTeX is EXTERNAL (`fig.epstopdf` line). If an included picture's file format were counted as figure content only, this zip would read `yes`; I followed the lib ruling and the rule that a wrong `yes` costs more.

## Blockers
- `EXTERNAL/body` 18 `\includegraphics[...]{*.ps}` calls over 17 GIMP-exported PostScript files (src/tutorialbeamer.tex:216, 280, 432, 432, 434, 434, 467, 468, 470, 471, 473, 474, 484, 485, 487, 488, 490, 491); pdfTeX cannot read `.ps`, so the document needs latex + dvips/dvipdfm, or a Ghostscript conversion (`fig.epstopdf`, itself EXTERNAL); the pictures are content (screenshots of slides), the format is the problem

## Class setting
- Class: `class.article` options: `12pt` (src/tutorialbeamer.tex:1); `class.beamer` options: none (src/exemplo/exemplo.tex:1), so beamer's defaults for size and aspect apply (beamer source not read)
- Class-native vocabulary used (`class.beamer`, src/exemplo/exemplo.tex): `\frame{}` and `frame` env (with title argument), `\frametitle`, `\titlepage`, `\logo`, `block` env with overlay argument `<1->`, `columns[t]` and `column{5cm}` envs, `\uncover<..>`, overlay specs `<1->` `<1,3->` `<1- | alert@1>`, `\setbeamercovered{transparent|invisible}`, `\AtBeginSection[]`, `\tableofcontents[currentsection]`, `\transdissolve`, `\transsplitverticalout[duration=2]`, `\usetheme{Berkeley}`, pgf image commands `\pgfdeclareimage` `\pgfuseimage` (beamer loads pgf).
- `class.article` vocabulary used (src/tutorialbeamer.tex): `\title` `\author` `\maketitle` `\section`, `itemize`, `figure`, `center`, `tabular`, `verbatim`; no `\date`, no `abstract`.

## Component map
Tutorial (class.article), src/tutorialbeamer.tex:

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | src/tutorialbeamer.tex:1 | `class.article` | 12pt |
| paper and size | src/tutorialbeamer.tex:1 | `page.class-options` | 12pt only; no geometry, no page style, no spacing changes (article defaults) |
| language | src/tutorialbeamer.tex:3 | `lang.babel` | brazil |
| input encoding | src/tutorialbeamer.tex:4 | `font.fontenc-t1` | `inputenc` with latin1; `fontenc` is not loaded |
| first-line indent | src/tutorialbeamer.tex:5 | `sp.indentfirst` | load-only |
| URLs | src/tutorialbeamer.tex:6, used at 26 and 30 | `meta.url` | `\url{}` in running text, no options |
| graphics package | src/tutorialbeamer.tex:7 | `fig.graphicx` | no options |
| title block | src/tutorialbeamer.tex:9-10, 14 | `front.maketitle` | `\title` (holds `\LaTeX`), `\author`, `\maketitle`; no `\date`, so `\today` |
| headings | src/tutorialbeamer.tex:16, 70, 142, 453, 501 | `head.kernel` | `\section` only, article numbering and format |
| inline marks | src/tutorialbeamer.tex:19-20, 38 | `mark.kernel` | `\emph`, `\texttt` |
| lists | src/tutorialbeamer.tex:55-68, 327-333, 443-449 | `list.kernel` | `itemize`, one level |
| code display | src/tutorialbeamer.tex:75-87 (verbatim), 39 and 42-45 (`\verb+..+`) | `code.verbatim` | `verbatim` env and `\verb`; the beamer source shown is content |
| figures | src/tutorialbeamer.tex:214-219, 278-283, 429-439, 464-479, 481-496 | `fig.graphicx` | `figure` env, default placement, `\includegraphics[width=14cm]` alone or `[width=7cm]` inside a tabular |
| figure centring | src/tutorialbeamer.tex:215, 279, 430, 465, 482 | `sp.ragged` | `center` env |
| figure grids | src/tutorialbeamer.tex:431-436, 466-476, 483-493 | `tbl.tabular` | `tabular{cc}`, `\multicolumn{2}{c}{label}` |
| captions | src/tutorialbeamer.tex:218, 282, 438, 478, 495 | `cap.kernel` | `\caption{}` below the figure |
| labels and refs | src/tutorialbeamer.tex:218, 210, 256, 425, 462 | `xref.kernel` | `\label`, `\ref` after a tie `~` |
| picture files | src/tutorialbeamer.tex:216 and 17 more | (none: blocker) | `.ps` files, see Blockers |

Deck (class.beamer), src/exemplo/exemplo.tex:

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | src/exemplo/exemplo.tex:1 | `class.beamer` | no options |
| frame size and font size | src/exemplo/exemplo.tex:1 | `page.class-options` | none given; beamer defaults |
| language and encoding | src/exemplo/exemplo.tex:2-3 | `lang.babel`, `font.fontenc-t1` | brazil; inputenc latin1 |
| theme | src/exemplo/exemplo.tex:6 | `slide.beamer-theme` | `\usetheme{Berkeley}`; no colour, font, inner or outer theme call and no `\setbeamertemplate`, `\setbeamercolor`, `\setbeamerfont` (grep: only `\setbeamercovered` at 68 and 86) |
| sidebar, headline, footline, navigation symbols | src/exemplo/exemplo.tex:6 | `hf.class-native` | none set by the sample; they come with the Berkeley theme (theme source not read) |
| title page | src/exemplo/exemplo.tex:10-11, 16 | `front.maketitle`, `front.class-native` | `\title`, `\author`, `\frame{\titlepage}`; no `\date`, no `\institute` |
| logo | src/exemplo/exemplo.tex:13-14 | `front.class-native`, `fig.graphicx` | `\logo{..}` holding the image `ufpellogo` at height=1.5cm (reduction below) |
| contents frame | src/exemplo/exemplo.tex:18-21 | `toc.kernel` | `\tableofcontents` inside a frame |
| per-section contents | src/exemplo/exemplo.tex:23-29 | `slide.beamer-section-hook` | `\AtBeginSection[]` with a frame of `\frametitle` and `\tableofcontents[currentsection]` |
| sections | src/exemplo/exemplo.tex:30, 67, 88, 171, 183 | `head.kernel` | `\section{}` only |
| frames and titles | src/exemplo/exemplo.tex:18-19, 31-32, 89 | `head.class-native` | `\frame{\frametitle{..}}`, `\begin{frame}` with `\frametitle`, `\begin{frame}{title}` |
| lists | src/exemplo/exemplo.tex:33-40, 101-105, 124-129 | `list.kernel` | `itemize` (nested at 36-39), `enumerate` |
| overlays | src/exemplo/exemplo.tex:34-38, 54-62, 74-82, 125-128 | `slide.beamer-mode` | specs `<1->`, `<1,3->`, `<1- | alert@1>` on `\item`, on `block` and `\uncover` |
| covered material | src/exemplo/exemplo.tex:68, 86 | `slide.beamer-mode` | `\setbeamercovered{transparent}` then `{invisible}` |
| blocks | src/exemplo/exemplo.tex:54-64, 71-84, 174-180 | `slide.beamer-theme` | `block{title}` env; its look comes from the theme (block env is `class.beamer` vocabulary) |
| columns | src/exemplo/exemplo.tex:110-138, 145-167 | `cols.minipage` | `columns[t]`, `column{5cm}`: fixed-width, top-aligned side-by-side boxes (beamer's own env, same type as a minipage row) |
| images in frames | src/exemplo/exemplo.tex:113-120, 148-149 | `fig.graphicx`, `slide.beamer-mode` | `\pgfdeclareimage[width=5cm]` + `\pgfuseimage{..}<n>` reduce to `\includegraphics<n>[width=5cm]{automatoN}` (beamer gives `\includegraphics` an overlay spec) |
| slide transitions | src/exemplo/exemplo.tex:143, 173 | `slide.beamer-transition` | `\transdissolve`; `\transsplitverticalout[duration=2]` |
| maths | src/exemplo/exemplo.tex:72-82, 102-104, 125-128, 154-157, 172-179 | `math.kernel` | inline `$..$`, `\mathbf`, `\bigcup`, arrows; no `amsmath` |
| emphasis | src/exemplo/exemplo.tex:72 | `mark.kernel` | `\emph` |
| bibliography frame | src/exemplo/exemplo.tex:193-195 | `bib.bibtex-bst` | `\nocite{bib:blauth}`, `\bibliography{campani}`, style `plain` |
| state diagrams | src/exemplo/exemplo.tex:4, 97-100, 131-134, 160-163 | `art.content-package` | `xy` with option `all`; `\xymatrix` automaton diagrams inside frames (content, see below) |

Note: the kernel logo macros `\LaTeX{}` `\TeX{}` in the tutorial text (src/tutorialbeamer.tex:9, 18) are running-text content, with no way of their own.

## Bespoke code
none. Grep over both `.tex` files for `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter`, `\makeatletter`, `\setlength`, `\input`, `\include` finds nothing; the zip has no `.cls`, `.sty`, `.def`, `.cfg`. The only reduction is the pgf image commands to `\includegraphics` (src/exemplo/exemplo.tex:13-14, 113-120, 148-149), a published-command substitution, not zip-local code.

## Content-opaque
- `xy` automaton diagrams in frames (`art.content-package`): src/exemplo/exemplo.tex:97-100, 131-134, 160-163.
- Pictures: 17 GIMP-exported `.ps` screenshots of slides in the tutorial figures (src/tutorialbeamer.tex:216, 280, 432-434, 467-474, 484-491) and 5 `.jpg` automaton images plus the logo `.jpg` in src/exemplo/ (src/exemplo/exemplo.tex:13, 113-120, 148).
- Code text: the beamer sources shown in `verbatim` blocks (for example src/tutorialbeamer.tex:75-87, 104-125, 258-276, 394-424).
- Missing asset (not a blocker): `campani.bib` (src/exemplo/exemplo.tex:194) is not in the zip, so the bibliography frame has no entries.

## Lib changes
- New ways proposed: `slide.beamer-transition` beamer (CTAN, user guide section on slide transitions), pdf engine; PDF page-transition effect for one frame: `\transdissolve`, `\transsplitverticalout[duration=2]`, `\transblindshorizontal` and the other `\trans*` commands. W1: part of beamer, which is on CTAN with public documentation. W2: the effect is chosen by command name and its options (`duration`, direction and motion keys are values; only `duration=2` was seen here). W3: serves any beamer deck. W4: one line inside a frame body. Not `slide.beamer-mode` (overlays and handout/notes, which change what is on the slide, not the viewer effect between slides); the consolidator may merge it there if transitions are read as presentation mode. The beamer source was not read.
- Considered, not proposed: pgf `\pgfdeclareimage` / `\pgfuseimage` (pgfcore): the effect is an image at a size, which `fig.graphicx` with beamer's overlay spec already holds; `xy` (xypic): a content diagram package, held by `art.content-package`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
