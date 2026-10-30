yes

# 0497-easychair: EasyChair class kit (easychair.cls with its own guide)

- Unverified: read from the source, not compiled.
- Source: Source/0497-easychair/ (origin: https://easychair.org/publications/easychair.zip; licence: not established; easychair.cls:10 says "Copyright terms are that of easychair.org")
- Kind: conference (EasyChair proceedings papers; the manifest hint `journal` is wrong)
- Lib: v4
- Engine: pdfLaTeX-compatible (easychair.tex:564 names pdflatex as the preferred tool; no fontspec or Lua anywhere)
- Look carried by: class (easychair.cls loads `article` and sets page, running heads and title block; the sample adds only content, `\usepackage{doc}` and five text aliases)
- Class origin: publisher-official (the zip is EasyChair's own author kit; ctan.org/pkg/easychair returned 404 and easychair.tex:432 says CTAN is only planned)
- Main file: easychair.tex (other samples: none; easychair.pdf, debug.pdf, epic.pdf, chairEC.pdf, logoEC.pdf, throneEC.jpg are compiled output and images, not read as source)
- Read: main yes, zip-local classes and styles all (easychair.cls, 827 lines; easychair.bib is data, head read and grepped for macros: none)

## Verdict
`yes`, carried by the class. `easychair.cls` is the publisher's own kit class, which the rubric counts as published, so it is one way, `class.easychair`, whose options are parameters. The sample loads it unchanged and adds only content, a load-only `\usepackage{doc}` and five text aliases that reduce by inline expansion. Every package the class loads maps to a lib way, and none needs a tool outside TeX (no `minted`; the Makefile the text mentions at easychair.tex:572 is not in the zip). Sensitivity for a stricter reader: if the class were zip-local, its `\@maketitle` redefinition (easychair.cls:608-648) would be BESPOKE/class, and the `EPiCfinal` tcolorbox banner with TikZ logo nodes (easychair.cls:665-697) would be ART/class. They are scored here as internals of a published class, not as blockers.

## Blockers
none

## Class setting
- Class: `class.easychair` options: none in the sample (alternatives are commented out at easychair.tex:4-11). The class passes paper, orientation, column count and base size to `\LoadClass{article}` (easychair.cls:365), or `report` under option `thesis` (easychair.cls:361). Options defined: `letterpaper` (default), `a4paper`, `custompaper`, `portrait`, `landscape`, `onesided`, `twosided`, `onecolumn`, `twocolumn`, `10pt` (default), `11pt`, `12pt`, `singlespacing`, `lineandhalfspacing`, `doublespacing`, `withtimes`, `notimes`, `thesis`, `EPiC`, `EPiCempty`, `EPiCfinal`, `debug`, `verbose`, `frame` (easychair.cls:50-87, 101, 114-119, 247-308, 329-331); any other option is passed to `geometry` (easychair.cls:346).
- Class-native vocabulary used: `\title` (with `\thanks`), `\author` (with `\inst{n}`, `\and`, `\thanks`), `\institute{... \and ...}` with `\email{}`, `\authorrunning`, `\titlerunning`, `\maketitle` (easychair.tex:39-92). Defined but unused by the sample: `\volumeinfo` (6 arguments), `\affiliation`, `\headfootstyle`, `\indexedauthor` and the other `\indexed*` commands (easychair.cls:229, 502, 510, 778-821).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | easychair.tex:3; easychair.cls:360-367 | `class.easychair` | no options in the sample; loads `article` with twoside |
| paper size, base size | easychair.cls:238-250, 322-332 | `page.class-options` | `letterpaper` default, `a4paper`, `custompaper`; 10pt default, 11pt, 12pt; 8pt and 9pt only warn |
| columns | easychair.cls:282-286 | `cols.twocolumn-option` | option `twocolumn` (default one column) |
| page geometry | easychair.cls:446-477 | `page.geometry` | letter: papersize={8.5in,11in}; A4: papersize={210mm,297mm}; both total={145mm,224mm}, centering, twoside, includeheadfoot; custom: papersize={189mm,246mm}, total={145mm,224mm}, top=9mm, left=24mm |
| head and foot lengths | easychair.cls:322-331, 442-444 | `page.setlength` | `\headheight` 12pt, `\headsep` 16pt, `\footskip` 26pt at 10pt (11pt: 13.6, 23, 28; 12pt: 14.5, 25, 30) |
| line spacing | easychair.cls:292-308, 423 | `sp.linespread` | `\baselinestretch` 1.0; options `zerospacing` 0.0, `lineandhalfspacing` 1.5, `doublespacing` 2.0 |
| text face | easychair.cls:404-406; easychair.tex:177-179 | `font.mathptmx` | only with option `withtimes`; default is Computer Modern from `article` |
| font sizes | easychair.cls:501, 631-646 | `font.size-commands` | head/foot `\footnotesize` (`\headfootstyle` changes it); title `\LARGE`, authors `\large`, institutes `\small` |
| link colours | easychair.cls:39, 382-384 | `color.xcolor` | linkcolor RGB 170,0,0; citecolor RGB 44,160,46; urlcolor RGB 0,51,153 |
| PDF links and metadata | easychair.cls:385 | `meta.hyperref` | linktocpage, pdfcreator=easychair.cls-3.4, colorlinks=True, urlcolor, citecolor, linkcolor |
| external links | easychair.tex:123-125, 928-931 | `xref.hyperref` | `\href{url}{text}` (hyperref link command) |
| urls in text | easychair.tex:427 | `meta.url` | `\url{...}` (also loaded by hyperref) |
| cross references | easychair.tex:118, 132, 448 | `xref.kernel` | `\label`, `\ref`, `\pageref` |
| running heads | easychair.cls:196-223, 564-570; easychair.tex:82, 88 | `hf.class-native` | `\titlerunning{}` and `\authorrunning{}` strings; onesided: LO,LE title and RO,RE author; `twosided`: RE title, RO author |
| header and footer fields | easychair.cls:551-606 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhead`, `\fancyfoot[LE]` and `[RO]` carry `\normalsize\thepage`, `\headrulewidth` 0pt, `\footrulewidth` 0pt, `fancypagestyle{plain}` footer only |
| page counter | easychair.cls:526, 582-586 | `pgnum.pagenumbering` | `\thepage` in the footer; `\setcounter{page}{first page}` inside `\volumeinfo` (unused) |
| last page | easychair.cls:487, 524 | `pgnum.lastpage` | `lastpage`; `\pageref*{LastPage}` in the volume string |
| title, author, date | easychair.tex:39-55, 92; easychair.cls:157-184, 593 | `front.maketitle` | `\title`, `\author`, `\maketitle`; `\date{}`; second `\title`/`\author` ignored with a warning |
| title block layout, authors and institutes | easychair.tex:48-75; easychair.cls:122-150, 608-648 | `front.class-native` | llncs-style `\inst`, `\and`, `\institute`, `\email`; centred block, `\vspace{-1cm}` above, `\lineskip .5em`, `\vskip.35cm` below authors |
| author and title notes | easychair.tex:41, 49-54 | `front.thanks` | `\thanks` inside `\title` and `\author` |
| abstract | easychair.tex:94-99 | `abs.kernel` | `abstract` environment of `article` |
| contents | easychair.tex:105-107 | `toc.kernel` | `\tableofcontents` inside `{\small ...}` |
| contents depth | easychair.tex:105 | `num.secnumdepth` | `\setcounter{tocdepth}{2}` |
| headings | easychair.tex:117, 156, 320, 325 | `head.kernel` | `article` defaults for `\section` to `\paragraph`; the class does not restyle them |
| appendix | easychair.tex:978-979 | `num.appendix` | `\appendix` then `\section` |
| lists | easychair.tex:165-194, 436-456 | `list.kernel` | `enumerate`, `itemize` |
| quotes | easychair.tex:294-312 | `quote.kernel` | `quote` environment |
| verbatim and inline code | easychair.tex:213-254, 397-400 | `code.verbatim` | `verbatim` environment, `\verb` |
| listings (loaded, unused) | easychair.cls:413 | `code.listings` | `\RequirePackage{listings}`, no `lstlisting` in the sample |
| display and inline maths | easychair.tex:335-356 | `math.amsmath` | `\[ \]`, `equation`, `align*`, `\mathcal`; `amsmath` arrives through `empheq` (empheq source not read) |
| maths helper packages (loaded) | easychair.cls:417-419 | `math.physics` | `empheq`; `latexsym` is a math-symbol package filed with `math.amssymb`; neither used visibly |
| theorem package (loaded, unused) | easychair.cls:418 | `thm.amsthm` | `\RequirePackage{amsthm}`; the sample declares no theorem |
| tables | easychair.tex:367-386, 679-729 | `tbl.tabular` | `tabular{lrrrrrrrr}`, `\hline`, `\multicolumn`; `\tabcolsep` 6pt default, set to 5pt, 3pt, 1pt at 691, 702, 713 |
| figures | easychair.tex:136-142, 658-665 | `fig.graphicx` | `figure[tb]`, `\includegraphics[width=0.5\textwidth]{...}` |
| scaling a box | easychair.tex:777, 800, 822 | `fig.graphicx` | `\scalebox{factor}{...}` is a `graphicx` command (same package) |
| float placement | easychair.cls:541-544; easychair.tex:136, 367 | `fig.placement` | `\topfraction` 0.95, `\bottomfraction` 0.95, `\textfraction` 0.05, `\floatpagefraction` 0.8; specifiers `[tb]`, `[htp]` |
| centring in floats | easychair.tex:137, 368, 659 | `sp.ragged` | `\begin{centering}` (the `\centering` declaration used as a group), `center` |
| captions | easychair.tex:139, 383, 725 | `cap.kernel` | `\caption` and `\label` |
| footnotes | easychair.cls:378; easychair.tex:868 | `fn.footmisc` | `[bottom]` (a footnote text always at the foot); `fn.kernel` for `\footnote` |
| bibliography | easychair.tex:971-975; easychair.cls:723-734 | `bib.bibtex-bst` | `\bibliographystyle{plain}`, `\bibliography{easychair}`; the class wraps `thebibliography` with `\small`, `\parskip` 2pt, `\itemsep` 0pt |
| index (option `thesis` only) | easychair.cls:360-362, 778-821 | `idx.makeidx` | `makeidx`; the `\indexed*` commands wrap `\index` |
| series header modes (options) | easychair.cls:698-712 | `sp.rule` | `EPiC`: `\hrulefill` lines around a `\raisebox` of 36.5pt (`sp.manual-space`); `EPiCempty`: `\raisebox{0pt}[47pt][47pt]{~}` |
| EPiCfinal banner (option; server mode) | easychair.cls:650-697 | `box.tcolorbox` | `enhanced`, colback f4f5f6, colframe 79ada8, `height=73pt`, `toprule=0.5pt`; `underlay` holds two `\includegraphics` nodes via `art.tikz` (see Verdict; the class never loads tcolorbox, and `logo_chair.png`, `logo_epic.png` are not in the zip) |
| debug and frame overlays (options) | easychair.cls:736-771 | `bg.eso-pic` | `eso-pic[pscoord]` (`colorgrid` with `verbose`), `\AddToShipoutPicture` of a red `\framebox`; a diagnostic, not the template's look; the `frame` body is empty |
| `doc` package (load only) | easychair.tex:13 | `dtx.doc` | `\usepackage{doc}`; no `\DocInput` or `macrocode` in the body |
| sample text aliases | easychair.tex:27-31 | `mark.kernel` | `\textsf{easychair}`, `\texttt{Makefile}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| five `\newcommand` aliases (`\easychair`, `\miktex`, `\texniccenter`, `\makefile`, `\latexeditor`) | easychair.tex:27-31 | yes | inline expansion: `\textsf{easychair}`, `MiK{\TeX}`, `{\TeX}nicCenter`, `\texttt{Makefile}`, `LEd`; `mark.kernel` |
| `\@maketitle` redefinition, llncs-style author and institute counters, `\institutename`, single-use guards for `\title` and `\author` | easychair.cls:122-184, 608-648 | n/a: published class (publisher-official, W1); not reducible to lib ways by itself | written by `class.easychair` vocabulary: `\author{... \inst{n} \and ...}`, `\institute{... \and ...}` |
| series header branches `EPiC`, `EPiCempty`, `EPiCfinal` | easychair.cls:650-719 | n/a: published class option; `EPiCfinal` also needs tcolorbox, which the class does not load (easychair.cls:672) | option parameter of `class.easychair`; an emitter that selects `EPiCfinal` must add `box.tcolorbox` (skins library) and the two logo files |
| `thebibliography` wrapper | easychair.cls:723-734 | yes in principle | `\small` (`font.size-commands`), `\parskip` 2pt and `\itemsep` 0pt (`sp.lengths`) around the standard environment |
| running head and foot fields, parity conditionals `\ifodd\c@page` evaluated at load | easychair.cls:554-606 | yes in principle | `hf.fancyhdr` fields as in the map; both parity branches set the same page-number fields (581-587) |
| `\volumeinfo` and `\@EasyVolumeInfo` footer string | easychair.cls:510-531, 596-606 | yes in principle (unused by the sample) | footer text with `pgnum.lastpage` and `\setcounter{page}` (`pgnum.pagenumbering`); EasyChair fills it |
| `\indexed*` commands | easychair.cls:778-821 | yes in principle (unused) | `\index{..}` entries, `idx.makeidx` |
| debug and frame overlays | easychair.cls:736-771 | yes in principle | `bg.eso-pic` with a `\framebox` picture of the text block; diagnostic only |
| inert or defective code | easychair.cls:55-67 (`Kalpa` options set `\ifKalpa` and `\ifKalpaempty`, never tested; `Kalpaempty` calls an undefined `\Kalpa`), 429 (`\define@key{Ec}{lmargin}` calls undefined `\Ec@defbylen`, no `\setkeys` call), 13-27 (banner text only) | yes: no printed effect | drop |

## Content-opaque
none (the six images and the LTB results table at easychair.tex:369-382 are content held by `fig.graphicx` and `tbl.tabular`; the images are shipped in the zip; no TikZ or PSTricks appears in the sample)

## Lib changes
- New ways proposed: none. Considered and not proposed: `font.icons` for `latexsym` (the package only supplies math symbols, filed with `math.amssymb`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
