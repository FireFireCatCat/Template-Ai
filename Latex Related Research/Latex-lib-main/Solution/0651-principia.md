yes

# 0651-principia: principia (Peanese notation of Principia Mathematica, v3.4) with its manual and "List of Definitions"

- Unverified: read from the source, not compiled.
- Source: Source/0651-principia/ (origin: https://mirrors.ctan.org/macros/latex/contrib/principia.zip; licence: LPPL 1.3c)
- Kind: misc (a logic-notation package; the manifest hint says book, but the main sample is a one-chapter two-column reference list in the stock `book` class)
- Lib: v5
- Engine: pdfLaTeX-compatible (the `\Female` and `\Male` signs need the marvosym font files `mvs` installed; the zip does not ship them, the marvosym package is not loaded)
- Look carried by: preamble (stock `book` class; page, font and spacing come from preamble packages; the notation macros sit inline in the preamble and are a verbatim copy of the published `principia.sty`)
- Class origin: tex-distribution-unbundled
- Main file: List-of-Definitions.tex (other samples: principia.tex, the package manual in `article`; principia.sty is the package itself and has no `\documentclass`)
- Read: main yes, zip-local classes and styles all

## Verdict
yes. The page look is a stock `book` class plus ordinary published packages. The only zip-local code is a 674-line block of `\newcommand` notation macros copied into the preamble of both samples (List-of-Definitions.tex:28-701, principia.tex:27-700). An ordered line-by-line comparison shows every line equals principia.sty:24-697, and that package is the CTAN release itself (ctan.org/pkg/principia: "Notations for typesetting the Principia Mathematica", v3.4, 2025-03-19, LPPL 1.3c; this zip's `\ProvidesPackage` line, principia.sty:3, has the same version and date). The block therefore reduces to one preamble line `\usepackage{principia}` of a published package, with no copied macro logic. The notation is used only as math content inside table cells, so it is held as `art.content-package` and `Content-opaque`. Judgement call, stated openly: if a reviewer rules that the overprinted glyph construction is typesetting behaviour beyond the lib even when published, this flips to no.

## Blockers
none

## Class setting
- Class: `class.book` options: `12pt`, `openany`, `leqno`, `twocolumn` (List-of-Definitions.tex:1). Manual sample: `class.article` option `12pt` (principia.tex:1). Both classes ship with TeX and are not in the zip; their source was not read.
- Class-native vocabulary used: `\chapter*{\centering LIST OF DEFINITIONS}` (List-of-Definitions.tex:705; starred, so no number and no contents entry); no `\frontmatter`, no abstract. Manual: `\title` `\author` `\date` `\maketitle` (principia.tex:702-704, 707).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | List-of-Definitions.tex:1 | `class.book` | 12pt, openany, leqno, twocolumn |
| paper and type size | List-of-Definitions.tex:1 | `page.class-options` | 12pt; no paper option, class default |
| columns | List-of-Definitions.tex:1 | `cols.twocolumn-option` | twocolumn for the whole document; the chapter title and the 16 tabulars flow in two columns |
| equation number side | List-of-Definitions.tex:1 | `math.eqnumber` | leqno; inert here, no numbered display equation in the sample |
| page margins | List-of-Definitions.tex:16 | `page.vmargin` | `fullpage`, no options |
| text font | List-of-Definitions.tex:6 | `font.newtx` | `newtxtext` only; `newtxmath` is not loaded, so maths stays Computer Modern plus amssymb; `\usepackage{mathptmx}` is commented out (:7) |
| encodings | List-of-Definitions.tex:18-19 | `font.fontenc-t1` | fontenc T1, inputenc utf8 |
| symbol glyph (eight-pointed asterisk) | List-of-Definitions.tex:10, 76 | `font.icons` | `pifont`, `\ding{107}` inside `\pmast`; scaled by `\resizebox{!}{.75\height}` |
| marvosym signs | List-of-Definitions.tex:205, 650 | `font.nfss` | `\usefont{U}{mvs}{m}{n}\symbol{126}` (`\Female`) and `\symbol{124}` (`\Male`); needs marvosym font files |
| maths layout | List-of-Definitions.tex:14 | `math.amsmath` | `\text`, `\boldsymbol`, `\overset` `\underset`, `\overrightarrow` `\overleftarrow`, `array` with `\hline`, `\bigg` (macro bodies, e.g. :59-74) |
| maths symbols | List-of-Definitions.tex:11 | `math.amssymb` | `\upharpoonleft` `\upharpoonright` in macro bodies (:193-197) |
| maths alphabets | List-of-Definitions.tex:20 | `math.bm` | `mathrsfs` loaded; no `\mathscr` is used (Grep) |
| rotation of glyph pieces | List-of-Definitions.tex:12, 131, 151 | `fig.rotating` | graphicx `\rotatebox[origin=c]{180}` and other angles, inside notation macros |
| box scaling of glyph pieces | List-of-Definitions.tex:75-76, 147-148 | `fig.adjustbox` | graphicx `\scalebox{.5}[1]`, `\scalebox{1.3}[1.75]`, `\resizebox` (same type as a box-scaling package) |
| line spacing | List-of-Definitions.tex:26, 706, 910 | `sp.setspace` | `\onehalfspacing`, set before the first table and again before the 7th |
| chapter heading | List-of-Definitions.tex:705 | `head.kernel` | `\chapter*`, starred, no numbering |
| heading alignment | List-of-Definitions.tex:705 | `sp.ragged` | `\centering` inside the title argument |
| definitions list | List-of-Definitions.tex:707, 738, 770, 805, 840, 875, 911, 946, 981, 1016, 1051, 1086, 1121, 1156, 1191, 1223 | `tbl.tabular` | 16 tables `tabular{l l}`, one row per definition (number cell `&` formula cell); cells are content |
| manual spacing in cells | List-of-Definitions.tex:743, 903, 1249, 1251 | `sp.manual-space` | `\indent`, `\hspace{.3cm}`, `\hspace{2ex}`, `\hspace{0.75ex}` before a "Dft [..]" tag |
| running heads | none set (no `\pagestyle` in either .tex) | `hf.class-native` | `book` default |
| PDF links and metadata | List-of-Definitions.tex:21 | `meta.hyperref` | `hidelinks`, `pdfencoding=unicode`; no `\ref` or `\href` in the body |
| list package, load only | List-of-Definitions.tex:22-23 | `list.enumitem` | `enumitem` plus `moreenum` (CTAN, "More enumeration options", LPPL 1.3: extra enumitem label styles such as `\greek`, `\enumhex`); no list in the body, so no effect |
| underline package, load only | List-of-Definitions.tex:24 | `mark.ulem` | `ulem` with `normalem`; no `\uline` or `\sout` in the body |
| footnote package, load only | List-of-Definitions.tex:25 | `fn.footmisc` | `footmisc` options `perpage`, `symbol`; no `\footnote` in the body |
| counter package, load only | List-of-Definitions.tex:17 | `num.counters` | `perpage` (CTAN); no `\MakePerPage` call, so no effect |
| Peanese notation signs | List-of-Definitions.tex:28-701 (equals principia.sty:24-697) | `art.content-package` | `\usepackage{principia}`, no options; commands `\pm...` take formula fragments as arguments; used in math cells at List-of-Definitions.tex:708-1252 |
| manual: class and packages | principia.tex:1, 16-19, 22-25 | `class.article`, `page.vmargin`, `font.fontenc-t1`, `sp.setspace`, `math.amssymb`, `math.amsmath`, `font.icons`, `fig.rotating` | `12pt`; `fullpage`; T1 and utf8; `setspace`; `amssymb` `amsmath` `pifont` `graphicx` |
| manual: title block | principia.tex:702-704, 707 | `front.maketitle` | `\title` with `\texttt` and `\\`, `\author`, `\date`, `\maketitle` |
| manual: spacing | principia.tex:708 | `sp.setspace` | `\onehalfspacing` |
| manual: text marks | principia.tex:709-717 | `mark.kernel` | `\textit`, `\texttt` |
| manual: verbatim commands | principia.tex:713, 721-784 | `code.verbatim` | `\verb\|...\|` in the "TeX command" column |
| manual: command tables | principia.tex:719, 749, 787, 822 | `tbl.tabular` | 4 tables `@{}p{3cm} \| p{5cm} \| p{8.25cm}`, header row with `\textbf` and `\hline` (:720); `\par \hfill` in one cell (:728) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| 674-line block of `\newcommand` notation macros (`\pmimp`, `\pmnot`, `\pmsub...`, `\pmast`, ...) | List-of-Definitions.tex:28-701; principia.tex:27-700 | yes | Verbatim copy of principia.sty:24-697 (ordered line comparison, 0 differences). Replace by `\usepackage{principia}` (published CTAN package) held as `art.content-package`. The block holds no `\def`, no counter, no conditional, no `\renewcommand` of kernel internals: only `\newcommand` bodies of kernel and package commands |
| `\ooalign` overprinting for composite signs (`\pmnot` :90, `\pmimp` :92, `\pmcinc` :142, `\pmiota` :127, ...) | principia.sty:90-167 and others | yes | Inside the published package; kernel `\ooalign` with `\boldsymbol`, `\raisebox`, `\rotatebox`, `\hidewidth`; no zip-local algorithm |
| LaTeX picture arcs `\put(3, 2){\oval(4,1)[t]}` building the cap and cup signs | principia.sty:143-144 (List-of-Definitions.tex:147-148) | yes | Glyph pieces of a math symbol, scaled by `\scalebox` and overprinted by `\ooalign`; not page artwork and not a template banner or frame, so not counted as `ART`; carried by the published package |
| `\Female` and `\Male` | principia.sty:201, 646 (List-of-Definitions.tex:205, 650) | yes | `font.nfss` `\usefont{U}{mvs}{m}{n}` call; the font files come from marvosym (README line 4 and principia.sty:22 say so); note as a missing asset to ship |
| `\pmfd`, `\pmdem`, `\pmdemi` and other text macros | principia.sty:48-50 | yes | Aliases of `\rule`, `\textit`, `\indent`; defined in the package, never called by either sample |
| principia.sty itself | principia.sty:1-697 | yes | The CTAN release (v3.4, 2025/03/19, principia.sty:3); published, so its internals need no reduction. It `\RequirePackage`s `amssymb` `amsmath` `graphicx` `pifont` (:18-21) |

## Content-opaque
- The Peanese notation formulas in every table cell: List-of-Definitions.tex:708-1252 (498 rows whose number cell starts with `\pmast`, each with a `\pm...` formula) and principia.tex:721-850 (command table), plus the inline formulas at principia.tex:713. Specialised logic notation, no lib way holds it as template look, so it stays content (the same type as chemistry or music notation under `art.content-package`).

## Lib changes
- New ways proposed: none. Considered: a dedicated math way for `principia` (CTAN, LPPL 1.3c); not proposed, because `art.content-package` already holds specialised notation packages and the notation is content here.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- CTAN pages read: ctan.org/pkg/principia (W1 for the notation package) and ctan.org/pkg/moreenum (what the unused `moreenum` load is). `class.book` and `class.article` are kernel classes and were not opened.
- Neither sample loads `principia.sty`; both inline its macros. An emitter should write `\usepackage{principia}` instead.
- No text addressed to an AI was found in the zip. README (README:1-12) is plain package information.
