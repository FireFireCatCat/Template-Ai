no

# 0386-bizcard: bizcard (a sheet of ten business cards: package source, documentation and one example)

- Unverified: read from the source, not compiled.
- Source: Source/0386-bizcard/ (origin: https://mirrors.ctan.org/macros/latex/contrib/bizcard.zip; licence: GNU GPL version 2 or later, per bizcard.dtx:167-170 and bizcard.ins:13-16, and "GNU General Public License" on https://ctan.org/pkg/bizcard)
- Kind: misc (a sheet of business cards; the manifest hint `misc` agrees, and no listed kind fits a card sheet)
- Lib: v4
- Engine: pdfLaTeX-compatible (the driver loads `ltxdoc`, bizcard.dtx:5; the example loads `article` and `bizcard`, bizcard.dtx:131-133; the package code uses only `ifthen`, `geometry`, `lrbox` and `picture`, bizcard.dtx:263-292; no fontspec or other xe/lua package anywhere)
- Look carried by: mixed (documentation look: the published class `ltxdoc`, bizcard.dtx:5; card sheet and corner marks: the published package `bizcard`, whose source is the code lines bizcard.dtx:203-292; card face: `picture` commands in the example body, bizcard.dtx:137-155)
- Class origin: tex-distribution-unbundled (`ltxdoc` at bizcard.dtx:5 and `article` at bizcard.dtx:131 are LaTeX base classes, not in the zip; the zip holds no `.cls`)
- Main file: bizcard.dtx (other samples: none as a file; the example embedded at bizcard.dtx:131-157 is written out as `bizex.tex` by bizcard.ins:32, which the zip does not ship; `bizex.pdf` and `bizcard.pdf` are prebuilt output)
- Read: main yes, zip-local classes and styles all (there is no standalone `.cls` or `.sty`; the package source is the code lines of bizcard.dtx, 203-292, read in full, as is `bizcard.ins`; the two PDFs were not read)

## Verdict
no. The zip is the source of the published CTAN package `bizcard` (CTAN: version 1.1, GPL, in TeX Live and MiKTeX), a DocStrip driver and two prebuilt PDFs; it has no `.cls`, `.sty` or `.tex` file. Everything except the card face maps to a lib way: the documentation is `class.ltxdoc` with `dtx.doc` and kernel front matter, and the sheet is a new doc-kind way `ticket.sheet` that passes W1 to W4. The one blocker is the card face. The package defines no face; the only way to give one is `picture` commands (bizcard.dtx:117-121, "you have to"), and the example places eleven text boxes with `\put(x,y){\makebox(w,h)[pos]{...}}` (bizcard.dtx:140-154). `picture` is held by the restricted `art.pstricks`, and no unrestricted lib way holds absolute-coordinate text in a picture. It is a close call because the face draws no rule or shape; Notes says how the answer flips.

## Blockers
- `ART/body` card face laid out by absolute `picture` coordinates: `\put(19,38){\makebox(50,5){...}}` and `\put(19,32){...}` (bizcard.dtx:140-141), three `\put(7,y){\makebox(79,4)[tl]{...}}` lines (bizcard.dtx:143-145), and six `\put(43|57,y){\makebox(10|25,4)[tr]{...}}` cells (bizcard.dtx:147-154); the only home is the restricted `art.pstricks`

## Class setting
- Class: `class.ltxdoc` options: none (bizcard.dtx:5, the documentation driver). LaTeX base class, not bundled in the zip; its source was not read.
- Class-native vocabulary used (`ltxdoc`): `\DocInput` (bizcard.dtx:11), `macrocode` environments (bizcard.dtx:129-159, 201-206, 210-212, 216-218 and the other code blocks), `\changes` (bizcard.dtx:34-36), `\StopEventually` (bizcard.dtx:182), `\Finale` (bizcard.dtx:296), the `|...|` short verbatim (bizcard.dtx:76-77, 95-96, 119), docstrip module guards `%<*driver>`, `%<*example>`, `%<*package>` (bizcard.dtx:4, 130, 202). `\CheckSum` and `\CharacterTable` are written `%%` and are inert (bizcard.dtx:17-32).
- Class: `class.article` options: `a4paper` (bizcard.dtx:131, the embedded example). Kernel class, not bundled; source not read.
- Class-native vocabulary used (`article`): none (the example body is one `bizcard` environment, bizcard.dtx:137-155).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class, documentation | bizcard.dtx:5 | `class.ltxdoc` | no options |
| DocStrip documentation input | bizcard.dtx:11, 34-36, 182, 296 | `dtx.doc` | `\DocInput{bizcard.dtx}`, `\changes{1.0}{1999/08/30}{..}` and `{1.1}{1999/09/04}{..}`, `\StopEventually`, `\Finale`; no `\RecordChanges`, `\CodelineNumbered`, `\EnableCrossrefs` or `\DoNotIndex` |
| title block | bizcard.dtx:38-47 | `front.maketitle` | `\title{..}` (with `\bizcard`, `\LaTeXe`), `\author{..\\ \texttt{..}}`, `\date{\filedate}`, `\maketitle` |
| title footnote | bizcard.dtx:39-40 | `front.thanks` | `\thanks{This file has version number \fileversion, last revised \filedate.}` |
| abstract | bizcard.dtx:49-56 | `abs.kernel` | `abstract` environment |
| footnote in the abstract | bizcard.dtx:51-54 | `fn.kernel` | `\footnote{..}` |
| sectioning | bizcard.dtx:58, 80, 93, 99, 115, 125, 161, 184, 195 and 197, 208, 256, 271 | `head.kernel` | `\section`, `\subsection`; no `\renewcommand` of the headings, no title package |
| quotations | bizcard.dtx:63-65, 75-78 | `quote.kernel` | `quote` environment (a path and two URLs) |
| option list | bizcard.dtx:104-113 | `list.kernel` | `description` with four `\item[\texttt{..}]` |
| docstrip module table | bizcard.dtx:189-193 | `tbl.tabular` | `\begin{tabular}[t]{ll}`, two columns, three rows |
| inline maths | bizcard.dtx:55, 69, 73, 83, 119-120 | `math.kernel` | `\(2''\times 3.5''\)`, `\(179\,\mathrm{mm}\times 255\,\mathrm{mm}\)`, `\(1\,\mathrm{mm}\)`, `\(89\times51\)` |
| inline font switches | bizcard.dtx:7, 73 and `\texttt` throughout | `mark.kernel` | `\textsf`, `\emph`, `\texttt` |
| short verbatim text | bizcard.dtx:76-77, 95-96, 119 | `code.verbatim` | `\|http://..\|`, `\|bizcard.ins\|`, `\|\unitlength\|` through the short-verb character that doc/ltxdoc enable (not declared in the file; ltxdoc source not read) |
| document class, example | bizcard.dtx:131 | `class.article` | `a4paper` |
| paper size | bizcard.dtx:131 | `page.class-options` | `a4paper` (the example's own preamble has no `geometry` or `\setlength`) |
| card sheet package and corner marks | bizcard.dtx:133, 211-253 | `ticket.sheet` | `\usepackage[flat]{bizcard}`; the option is one of a closed list: `star` (default, 231-234, 251), `none` (217), `frame` (223-225), `flat` (240-245); `flat` draws 5-unit ticks outside the sheet at every card boundary after `\thinlines` |
| sheet of ten cards | bizcard.dtx:123, 277-292 | `ticket.sheet` | the `bizcard` environment wraps the face; one card is `picture(89,51)` at `\unitlength`=1mm (280-282), the sheet is `picture(178,255)` (287), two `\multiput` columns at x=0 and x=89, five rows with y step 51 (288-289); all sizes fixed in the package |
| text-area enlargement | bizcard.dtx:82-91, 263-268 | `page.geometry` | done by the package itself, not by the sample: `[body={178.8mm,255mm},noheadfoot]{geometry}[1998/04/08]`, only when `\textwidth<178.8mm` or `\textheight<255mm` (tested with `ifthen`); an emitter may print the same `geometry` call or leave it to the package |
| empty page style on the card sheet | bizcard.dtx:286 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` inside the environment (package-internal) |
| card face font family | bizcard.dtx:138 | `mark.kernel` | `\sffamily` (a kernel font-switch command, set once at the head of the face) |
| card face sizes and weight | bizcard.dtx:140-141 | `font.size-commands`, `mark.kernel` | `\Large` (name), `\large` (tagline); `\bfseries` (name) |
| card face layout | bizcard.dtx:140-154 | `art.pstricks` | **ART**: `\put(x,y){\makebox(w,h)[pos]{text}}` at (19,38) w50 h5 and (19,32) w50 h5 (centred); (7,14) (7,10) (7,6) w79 h4 `[tl]`; (43,14) (43,10) (43,6) w10 h4 `[tr]`; (57,14) (57,10) (57,6) w25 h4 `[tr]`; this is the `ART/body` blocker |

Not defined or used, so no row: fonts and encoding (Computer Modern default, no font package), colour, running heads other than the empty page style, page numbering, lists in the example, floats, captions, theorems, code listings, bibliography, index, cross-references (no `\label` or `\ref`), language, hyperref, backgrounds.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\fileversion{1.1}`, `\def\filedate{1999/09/04}` | bizcard.dtx:1-2 | yes | two string macros used in `\thanks`, `\date` and `\ProvidesPackage` (bizcard.dtx:39-40, 45, 204-205); expand inline into `front.thanks` and `front.maketitle` |
| `\newcommand*{\bizcard}{\textsf{bizcard}}` | bizcard.dtx:7 | yes | an alias of `\textsf{bizcard}`, `mark.kernel`; documentation driver only |
| `\bizcard@marks`, four `\DeclareOption`s, `\ExecuteOptions{star}`, `\newsavebox`, `\newenvironment{bizcard}` | bizcard.dtx:211-292 | not bespoke by the rubric: this is the published CTAN package `bizcard` (W1 by CTAN and by the mirrors.ctan.org origin), so this code is the internals of `ticket.sheet` | the emitter prints `\usepackage[opt]{bizcard}` and the `bizcard` wrapper and never copies this code. If a reader ruled the copy zip-local instead, it would not reduce to other lib ways (a fixed `picture`-based imposition, so `art.pstricks` again), and the verdict would stay `no` |
| conditional `geometry` load | bizcard.dtx:265-268 | package-internal (same row as above) | printed as `page.geometry` with `body={178.8mm,255mm},noheadfoot` if the emitter wants it explicit |
| `bizcard.ins` | bizcard.ins:3-32 | yes, no typesetting | a DocStrip driver (`\input docstrip.tex`, three `\generateFile` lines) that runs under TeX itself and writes the `.sty`, a `.drv` and `bizex.tex`; the emitter never needs it because the package ships with TeX Live. Not `EXTERNAL`: no tool outside TeX |

## Content-opaque
- Card text strings: name, tagline, address, e-mail, phone and fax (bizcard.dtx:140-154), with `\"o` and `\ss` accents (143) and `\,` thin spaces in the numbers (151, 154); plain content.
- The documentation prose, the legal text (bizcard.dtx:161-180) and the URLs (76-77) are content.
- Not content-opaque, but the blocker: the `\put` and `\makebox` coordinates of the face (see Blockers).

## Lib changes
- New ways proposed: `ticket.sheet`, package `bizcard` (CTAN macros/latex/contrib/bizcard, in TeX Live and MiKTeX; Sebastian Marius Kirsch, adapted from Silvano Balemi's `card.sty`; GPL; pdfLaTeX-compatible). Command surface: `\usepackage[star|none|frame|flat]{bizcard}` and a body environment `bizcard` that takes the card face as `picture` commands in millimetres and prints one sheet of ten cards (two columns, five rows) with star, frame or crop-style marks. A doc-kind way (a sheet of business cards), a sibling of `ticket.sheet`, `card.gcard` and `label.flabels`.
  - W1 Published: on CTAN (https://ctan.org/pkg/bizcard, read once: version 1.1, GPL, maintainer Sebastian Marius Kirsch, in TeX Live and MiKTeX), and the zip came from mirrors.ctan.org (manifest).
  - W2 Declarative parameters: the only option is one value from a closed list of four (bizcard.dtx:99-113, 217-251); the grid and the card size are fixed in the package (bizcard.dtx:282, 287-289); no package code is edited.
  - W3 Generic: it serves any business-card sheet, not one card; the face is whatever the author puts in the environment.
  - W4 Printable: one preamble line and one body wrapper around the face content. The face is outside the way, as for `ticket.sheet` (content, or `ART` when it draws the template's identity).
  - Considered and not used: `ticket.sheet` (package `ticket`, with `\ticket`, `\ticketNumbers`, `\ticketSize`; bizcard has none of these and a fixed grid), `card.gcard` (one folded greeting card), `label.flabels` (binder spine labels), `class.flashcard` (question and answer cards), `pg.pgfpages` (n-up of logical pages), `pg.textpos` (page-absolute text blocks; the face here sits in an `lrbox` inside a `picture`, so it cannot be moved to `textpos`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Judgment call, recorded so it can be re-read. Reading A (used): `bizcard` is published, the face is `picture` content that is the card's own look, so `art.pstricks` makes it `ART/body` and the answer is `no`. Reading B: if the package copy were ruled zip-local, the sheet is an irreducible fixed picture imposition, also `no`. Reading C: if the project rules that a text-only `\put` and `\makebox` face is the author's content (the package defines no face; the name and address are personal data), the zip becomes `yes` with `ticket.sheet` as the only new way. I did not choose C because `picture` is listed under the restricted `art.pstricks`, the face is the one thing a business-card template is for, and a new way for positioned text would only relabel the restricted one. A wrong `yes` costs more than a wrong `no`.
- The marks are drawn with `\multiput`, `\line` and `\makebox` inside the published package (bizcard.dtx:223-245) and are chosen by an option value; they are the way's parameters, not the sample's artwork, so they are not part of the blocker.
- Size discrepancy, not decisive: the documentation says the card is 2 by 3.5 inch and the picture is 89 by 51 units of 1 mm (bizcard.dtx:55, 69, 119-120, 282); the CTAN summary gives 76.2 mm by 50.8 mm. I used the source.
- Not read: `bizcard.pdf` (5 pages) and `bizex.pdf` (1 page) are prebuilt output; the Read tool could not render PDFs here (pdftoppm is missing). The `ltxdoc` and `article` class sources are not in the zip and were not read. Nothing was compiled, so I do not state that the `geometry` call fires for an A4 `article` or how the sheet looks.
- No text addressed to an AI was found in the zip.
