yes

# 0867-imperial-college-dissertation: Imperial College Dissertation (icldt)

- Unverified: read from the source, not compiled.
- Source: Source/0867-imperial-college-dissertation/ (origin: https://latextemplates.com/downloads/icl-dissertation.zip; licence: MIT)
- Kind: thesis
- Lib: v6
- Engine: pdfLaTeX-compatible
- Look carried by: mixed (the zip-local `icldt.cls` carries the title page, front-matter pages, abstract heading, spacing and heading font over KOMA `scrreprt`; `main.tex` carries running heads, captions, hyperref, natbib and tocbibind)
- Class origin: zip-local
- Main file: main.tex (other samples: none; chapter files `chapters/*.tex` and `chapters/subcritical.tikz` are `\input` by it)
- Read: main yes, zip-local classes and styles all (`icldt.cls`, 168 lines; `jfm2.bst` partly: header, helper functions at lines 196-219, bibitem writer, end of file; the stack code in between was only outlined)

## Verdict
The whole look reduces to published ways. `icldt.cls` is `\LoadClass{scrreprt}` plus `setspace`, one `\setkomafont` line, a hand-laid `titlepage` for `\maketitle`, three `\chapter*` front-matter pages and a redefined `abstract` environment; the `\ifx` tests only switch lines on or off by field values and class-option strings, so an emitter resolves them when it writes the document. The preamble loads only published packages. The one pgfplots plot is figure content, not template artwork. The class itself is zip-local (not on CTAN), so the reduction lands on `class.scrreprt`, not on a class way for `icldt`.

## Blockers
none

## Class setting
- Class: `class.scrreprt` (via the zip-local `icldt`, `icldt.cls:87`); options after resolving the class defaults (`icldt.cls:85`): `paper=a4`, `pagesize=auto`, `12pt`, `oneside`, plus the pass-through `enabledeprecatedfontcommands` (`main.tex:12`, `icldt.cls:84`). The option is there because `jfm2.bst` writes `{\sc ..}` and `{\bf ..}` (`jfm2.bst:210`, `jfm2.bst:217`); its KOMA meaning is taken from the comment at `main.tex:6-11` and was not checked against the KOMA manual.
- Class-native vocabulary used (scrreprt): `\chapter`, `\chapter*`, `\section`, `\appendix`, `\tableofcontents`, `\listoftables`, `\listoffigures`, `\titlepagestyle`, `\setkomafont`.
- Zip-local vocabulary used (reduced below, not a published class): options `onehalfspacing|doublespacing`, `titlepagenumber=on|off`, `imperial|university`, `PhD|MSc|BSc`, `DIC=on|off` (`icldt.cls:60-86`); commands `\department`, `\supervisor`, `\declareoriginality`, `\declarecopyright`, `\acknowledgements` (`main.tex:44-48`), `\makedeclaration`, `\makecopyright`, `\makeacknowledgements` (`main.tex:53-55`), env `abstract` (`main.tex:57`).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:12; icldt.cls:87 | `class.scrreprt` | `pagesize=auto`, `paper=a4`, `12pt`, `oneside`, `enabledeprecatedfontcommands` |
| paper size and type area | icldt.cls:85,87 (geometry line commented out at icldt.cls:89-90) | `page.typearea` | `paper=a4`, `pagesize=auto`; no `DIV` or `BCOR` set, KOMA defaults |
| point size, sides | icldt.cls:85 | `page.class-options` | `12pt`, `oneside` |
| line spacing | icldt.cls:75-76,85,88; main.tex:17 | `sp.setspace` | `\onehalfspacing` run at `\AtBeginDocument` (default); `doublespacing` is the other option; `setspace` loaded by the class and again in the preamble |
| heading font | icldt.cls:98 | `head.koma-fonts` | `\setkomafont{sectioning}{\rmfamily\bfseries}` (replaces the KOMA sans default); element name as written, not checked |
| headings (chapter, section) | chapters/introduction.tex:1,43; chapters/methods.tex:1,10,24 | `head.kernel` | plain `\chapter{}` and `\section{}` with the scrreprt default numbering and layout |
| appendix | main.tex:76-77; chapters/appendix.tex:1 | `num.appendix` | `\appendix` then `\chapter` |
| running head and foot | main.tex:22,28-32 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhead{}`, `\lhead{\nouppercase{\leftmark}}`, `\footrulewidth`=0.4pt, `\cfoot{\thepage}` |
| page style of special pages | icldt.cls:104,138,148,150,156,165 | `hf.pagestyle-kernel` | `\thispagestyle{plain}` on declaration, copyright, acknowledgements, abstract; title page `\thispagestyle{\titlepagestyle}`, `\titlepagestyle`=`empty` by default (icldt.cls:78,85) |
| title data | main.tex:41-43; icldt.cls:108,122,131 | `front.maketitle` | `\title`, `\author`, `\date{September 2026}` |
| title page | icldt.cls:100-134; main.tex:52 | `front.titlepage-env` | `titlepage` env: `\par\clearpage`, `\null\vfill`, four minipages separated by `\null\vfill` (`[b]`,`[b]`,`[b]`,`[t]`, width `\textwidth`); all centred small caps; sizes `\Huge` title, `\small` degree block, `\Large` author, `\small` department, college, then `\vskip 3em` and the date |
| title page boxes | icldt.cls:106,111,120,125 | `box.minipage` | `minipage` `[b]` or `[t]`, `{\textwidth}` |
| title page type | icldt.cls:107,112,121,126 | `font.size-commands` | `\Huge`, `\small`, `\Large`, `\small` |
| title page type shape | icldt.cls:107,112,121,126 | `mark.kernel` | `\scshape` (the patch note at icldt.cls:41-44 says `\sc` was replaced by it) |
| title page alignment | icldt.cls:107,112,121,126 | `sp.ragged` | `\centering` |
| title page glue | icldt.cls:105,110,113,116,119,124,127,130 | `sp.manual-space` | `\vfill`, `\vskip 3em`, `\\` |
| degree and institution lines | icldt.cls:60-74,113-116,127-129 | `front.titlepage-env` | fixed text "Submitted in part fulfilment ...", `\@degree` (PhD/MSc/BSc string), "Imperial College London" or "the University of London", optional diploma line, `Department of \@department`; chosen at emit time |
| declaration page | icldt.cls:136-145; main.tex:46,53 | `front.dedication` | `\thispagestyle{plain}`, `\chapter*{Declaration of Originality}`, text, `\par\vspace{3cm}`, `\hfill author`, `\par \hfill date` |
| copyright page | icldt.cls:146-153; main.tex:47,54 | `front.dedication` | `\thispagestyle{plain}`, `\chapter*{Copyright Declaration}`, `\thispagestyle{plain}` again, text |
| acknowledgements page | icldt.cls:154-162; main.tex:48,55 | `front.dedication` | `\thispagestyle{plain}`, `\null\vfill`, `\chapter*{Acknowledgements}`, text, `\vskip \z@ \@plus3fill` |
| starred chapter heading on front pages | icldt.cls:139,149,158,165 | `head.kernel` | `\chapter*{...}` |
| glue on front pages | icldt.cls:141-143,157,160 | `sp.manual-space` | `\vspace{3cm}`, `\null\vfill`, `\vskip \z@ \@plus3fill`, `\hfill` |
| abstract | icldt.cls:164-165; main.tex:57-63 | `abs.kernel` | env `abstract` redefined as `\chapter*{Abstract}\thispagestyle{plain}` ... `\cleardoublepage` (reduction: `head.kernel`, `hf.pagestyle-kernel`, `pg.break`) |
| page break after abstract | icldt.cls:165 | `pg.break` | `\cleardoublepage` |
| contents and lists | main.tex:65-67 | `toc.kernel` | `\tableofcontents`, `\listoftables`, `\listoffigures` |
| bibliography in contents | main.tex:24 | `toc.etoc` | `tocbibind` with `nottoc` |
| maths | main.tex:14,20; chapters/methods.tex:14-16 | `math.amsmath` | `amsmath` loaded; one `equation` with `\frac`, `\bigg|` |
| maths symbols | main.tex:14 | `math.amssymb` | `amssymb`, `latexsym` (load only) |
| maths alphabets | main.tex:20 | `math.bm` | `mathrsfs` (load only, no `\mathscr` in the body) |
| theorem package | main.tex:14 | `thm.amsthm` | load only; no `\newtheorem` or theorem env anywhere in the zip |
| figure float | chapters/introduction.tex:21-29; main.tex:16 | `fig.graphicx` | `figure[t]`, `\centering`, `\resizebox{\linewidth}{!}{\input{chapters/subcritical.tikz}}`, `\label` after `\caption` |
| subfigure | chapters/introduction.tex:23-26; main.tex:19 | `fig.subcaption` | `subfigure[b]{0.8\textwidth}`, no caption of its own |
| table | chapters/introduction.tex:31-41 | `tbl.tabular` | `table[hp]`, `\centering`, `tabular{cccccc}`, caption below |
| table rules and gaps | chapters/introduction.tex:33,39 | `sp.rule` | bare `\hrule` before and after the table |
| table gaps | chapters/introduction.tex:33,39 | `sp.manual-space` | `\vspace{0.5em}` |
| captions | main.tex:18,26 | `cap.caption` | `caption` options `bf`, `labelsep=space`; `\captionsetup{format=plain}`; `subcaption` option `singlelinecheck=off` (main.tex:19) |
| cross-references | chapters/introduction.tex:16-19,45-48; chapters/methods.tex:19,28 | `xref.kernel` | `Figure~\ref`, `Table~\ref`, `Chapter~\ref` |
| hyperlinks | main.tex:21 | `meta.hyperref` | `linktoc=page` |
| citations | main.tex:34; chapters/introduction.tex:8,10,14; chapters/conclusion.tex:13 | `bib.natbib` | `natbib` option `sort`; `\citep`, `\citet` |
| bibliography | main.tex:73-74 | `bib.bibtex-bst` | `\bibliographystyle{jfm2}` (zip-local `.bst`, the style is the parameter), `\bibliography{bibliography}`, before `\appendix` |
| plot sizes | main.tex:36-39; chapters/subcritical.tikz:11-13 | `sp.lengths` | `\newlength\figureheight` = 7cm, `\newlength\figurewidth` = 10cm (read only by the plot) |
| diagram package | main.tex:15 | `art.tikz` | `xy` with option `all`; loaded, no `\xymatrix` or `\xy` anywhere in the `.tex` files (same type as `tikz-cd`); load only |
| plot package | main.tex:23 | `art.tikz` | `pgfplots` loaded for the plot in the figure; content, see below |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `icldt` | icldt.cls:45-166 | yes | `\documentclass[paper=a4,pagesize=auto,12pt,oneside,enabledeprecatedfontcommands]{scrreprt}` + `sp.setspace` + the rows above; no output routine, no `\@startsection`, no kernel internals touched |
| option system (`\DeclareOption`, `\ExecuteOptions`, pass-through) | icldt.cls:60-86 | yes | closed list of strings and switches (degree, university, diploma, spacing, title page style); an emitter resolves them to the literal text and switch at write time |
| field store `\@supervisor` ... `\@acknowledgements`, setters `\supervisor` ... `\acknowledgements` | icldt.cls:50-59,91-97 | yes | `\gdef` aliases; the values are content strings; `\supervisor` and `\field` are stored and never printed (`\@supervisor`, `\@field` occur only at icldt.cls:50,54,91,94) |
| `\maketitle` redefinition | icldt.cls:100-134 | yes | `front.titlepage-env` with `box.minipage`, `font.size-commands`, `mark.kernel`, `sp.ragged`, `sp.manual-space`; the `\ifx` tests (icldt.cls:115,116,127,128) only drop a line when its field is empty |
| `\makedeclaration` | icldt.cls:136-145 | yes | `front.dedication`; the test `\ifx\@declaration\@empty` (icldt.cls:137) names `\@declaration`, which the class never defines, so the page is always printed; an emitter just writes the page |
| `\makecopyright` | icldt.cls:146-153 | yes | `front.dedication`, test on `\@declarecopyright` emptiness resolved at emit time |
| `\makeacknowledgements` | icldt.cls:154-162 | yes | `front.dedication` with `sp.manual-space` |
| `abstract` redefinition | icldt.cls:164-165 | yes | `\renewenvironment{abstract}` = `head.kernel` + `hf.pagestyle-kernel` + `pg.break`, or inline at the call site |
| `\setkomafont{sectioning}` | icldt.cls:98 | yes | `head.koma-fonts` |
| `\newlength` and `\setlength` | main.tex:36-39 | yes | `sp.lengths` |
| `jfm2.bst` (BibTeX stack program, generated by `makebst` from `merlin.mbs`, author-year, natbib labels) | jfm2.bst:8-13,34-47,591-601,1519-1541 | yes | the parameter of `bib.bibtex-bst`; it needs only BibTeX, which is part of the TeX toolchain, not EXTERNAL; it writes `\bibitem[label]{key}` for natbib and the deprecated `{\sc}` `{\bf}` `{\em}` switches, hence the class option |

## Content-opaque
- pgfplots axis (matlab2tikz output, three `\addplot` curves, two legend entries, grids) inside the figure float: chapters/subcritical.tikz:8-250, included at chapters/introduction.tex:25. Figure artwork, not a template-defining drawing.
- `xy` is loaded at main.tex:15 and never called, so nothing is opaque from it.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes
- Origin check: ctan.org/pkg/icldt returned 404, and the class header credits Daniel Wagner (PrettyPrinting.net) and Joseph Maestri (icldt.cls:6-8,15-16), with main.tex:1-3 saying it was adapted from a GitHub project under MIT; the zip is not an official Imperial College kit, so the class is zip-local (W1 fails for `icldt`).
- The patch comment at icldt.cls:41-44 and the comment at main.tex:6-11 were written by the latextemplates.com maintainers about the pinned KOMA-Script; they are descriptions, not instructions, and were not acted on.
- Not compiled: how `\chapter*` interacts with the preceding `\null\vfill` (icldt.cls:157-158) and with `fancy` page style is not shown here.
