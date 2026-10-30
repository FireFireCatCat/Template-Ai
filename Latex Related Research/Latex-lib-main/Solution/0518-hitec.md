yes

# 0518-hitec: hitec (Hi-tec style document class, Eli Billauer)

- Unverified: read from the source, not compiled.
- Source: Source/0518-hitec/ (origin: https://mirrors.ctan.org/macros/latex/contrib/hitec.zip; licence: lppl1 per the manifest, and the class header says LPPL version 1 or later, hitec.cls:4-8)
- Kind: report (technical paper for a company; the manifest hint `misc` is only the source category)
- Lib: v5
- Engine: pdfLaTeX-compatible (no package is loaded by the class; Helvetica comes from the `phv` family through `\rmdefault`, hitec.cls:36)
- Look carried by: class (the whole look is in `hitec.cls`; the sample adds a logo alias, three field strings and a default `hyperref` load)
- Class origin: ctan
- Main file: hitec_doc.tex (other samples: none; `hitec_doc.pdf` is the shipped compiled manual and was not read)
- Read: main yes, zip-local classes and styles all (`hitec.cls`, 654 lines, read in full; it is the CTAN class, not a zip-local one)

## Verdict
The zip is the CTAN release of the published class `hitec`, and its sample (66 lines) is `\documentclass{hitec}` plus content, three class-native field commands, one `\newcommand` alias and a default `hyperref` load. Every component the sample uses is realised by `class.hitec` and kernel-level lib ways, the only preamble macro (`\HT`) is a reducible alias, and there is no artwork, no external tool and no zip-local macro logic. The verdict rests on W1: the class is published (CTAN contrib, `\ProvidesClass{hitec}` at hitec.cls:33), so its internal redefinitions of `\@maketitle`, `\@oddhead` and `\@makecaption` are the class's own vocabulary and not bespoke code. See "Bespoke code" for how that would read if the class were treated as unpublished.

## Blockers
none

## Class setting
- Class: `class.hitec` options: none in the sample (hitec_doc.tex:1). The class defaults are `letterpaper,10pt,oneside,onecolumn,final` (hitec.cls:115). Declared options: paper sizes `a4paper` `a5paper` `b5paper` `letterpaper` `legalpaper` `executivepaper` `landscape` (52-73), `10pt` `11pt` `12pt` (78-81), `oneside` `twoside` (83-85), `draft` `final` (86-89), `titlepage` `notitlepage` (90-93), `onecolumn` (95), `leqno` `fleqn` (98-99), `openbib` (100-109). `twocolumn` is declared to raise `\ClassError` (110-114), so an emitter must never pass it to this class.
- Class-native vocabulary used: `\company{..}` and `\confidential{..}` (defined hitec.cls:39-46; used hitec_doc.tex:6-7), `\title` `\author` `\maketitle` (kernel names, class-defined output at hitec.cls:240-280). Defined by the class and not used by the sample: `\settextfraction{f}` (130-154, called once with 0.8 at 155), `\secshape` (330-332), `\fullcenter` (47), `\longrule` `\longthickrule` (596-599), `\footruleskip` (38).
- Convention for the map below: rows marked (class) are set inside `hitec.cls`; the lib way named is the type of command the class uses there, and the look is reproduced by `class.hitec` alone, so an emitter does not print these lines.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | hitec_doc.tex:1; hitec.cls:33-35 | `class.hitec` | no options; defaults letterpaper, 10pt, oneside, onecolumn, final (hitec.cls:115) |
| paper and type size | hitec.cls:52-81, 115, 117 | `page.class-options` | letterpaper; 10pt read from `size10.clo` through `\input{size1\@ptsize.clo}` |
| columns | hitec.cls:95, 110-114, 651 | `page.class-options` | one column only (`onecolumn` default, `\onecolumn` at the end); `twocolumn` is an error |
| text block (class) | hitec.cls:130-155 | `page.setlength` | `\settextfraction{0.8}`: `\textwidth` = 0.8 of (`\paperwidth` minus 2in), `\oddsidemargin` = `\leftmarginwidth`, the remaining 20 percent (the centring term at 144-147 is zero because `\fullwidth` is `\paperwidth` minus 2in), `\marginparwidth` = `\oddsidemargin` minus `\marginparsep` |
| running header (class) | hitec.cls:633-637, 645 | `hf.class-native` | three `\parbox` fields of `\textwidth` on every page: `\@author` left, `\@confidential` centred, `\@company` right, then `\longrule` 1pt; even page equals odd page |
| running footer (class) | hitec.cls:638-644 | `hf.class-native` | rule, then `\textit{\@title}` left (0.8 of `\fullwidth`) and `\thepage` right; `\footruleskip` = `\normalbaselineskip` |
| first-page page style | hitec.cls:250 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` inside the non-titlepage `\maketitle` |
| page numbers | hitec.cls:630, 643 | `pgnum.pagenumbering` | arabic, printed at the footer right |
| rules | hitec.cls:596-599 | `sp.rule` | `\vrule` width `\fullwidth`, height 1pt (`\longrule`) and 3pt (`\longthickrule`) |
| main text face (class) | hitec.cls:36 | `font.family-default` | `\renewcommand{\rmdefault}{phv}` (Helvetica as the roman family) |
| paragraph and line spacing (class) | hitec.cls:118-121, 125 | `sp.lengths` | `\lineskip` 1pt, `\normallineskip` 1pt, `\parskip` 0pt plus 1pt, `\headsep` = `\baselineskip` |
| baseline stretch (class) | hitec.cls:120 | `sp.linespread` | `\renewcommand\baselinestretch{}` (empty) |
| vertical flush (class) | hitec.cls:647-650 | `pg.flush` | `\raggedbottom` unless `twoside` |
| title commands | hitec_doc.tex:4-5, 10 | `front.maketitle` | `\title{The \HT class}`, `\author{Eli Billauer}`, `\maketitle`; no `\date` call, so `\@date` (printed at hitec.cls:278) keeps the kernel default |
| title block | hitec.cls:240-280 | `front.class-native` | `\@maketitle`: `\@confidential` centred above a thick rule, title in `\secshape \Large\bfseries`, thick rule, then a flushright block of slanted `\@author\@tcompany` and `\@date`; titlepage variant 205-238 (option `titlepage`) |
| company and confidential fields | hitec_doc.tex:6-7; hitec.cls:39-46 | `front.class-native` | `\company{The Company, Ltd}`, `\confidential{\textbf{-- Unlimited Distribution --}}` (strings; the same two strings also feed the header) |
| abstract (class, unused) | hitec.cls:388-395 | `abs.kernel` | `\small`, centred bold `\abstractname`, then `quotation` |
| heading look | hitec.cls:333-352; hitec_doc.tex:11, 34, 56, 61 | `head.class-native` | `\section`: indent 0, before `-3.5ex plus -1ex minus -.2ex`, after `2.3ex plus .2ex`, style `\secshape\normalfont\Large\bfseries`; `\subsection` `\large\bfseries` (337-340); `\subsubsection` `\normalsize\bfseries` (341-344); `\paragraph` and `\subparagraph` run-in bold (345-352) |
| heading shape | hitec.cls:330-332 | `head.class-native` | `\secshape`: `\leftskip=-\leftmarginwidth` (headings hang into the left margin), `\rightskip=\@flushglue`, `\hyphenpenalty=2000` |
| part heading (class, unused) | hitec.cls:296-329 | `head.class-native` | Roman part number, `\Large\bfseries` label and `\huge\bfseries` title |
| heading numbering | hitec.cls:283-295 | `num.counters` | arabic `\thesection`, dotted sub levels; `\thepart` Roman |
| numbering depth | hitec.cls:283, 502 | `num.secnumdepth` | `secnumdepth` 3, `tocdepth` 3 |
| appendix (class, unused) | hitec.cls:439-442 | `num.appendix` | `\appendix` resets section and subsection, `\thesection` becomes `\@Alph` |
| lists | hitec_doc.tex:41-55; hitec.cls:353-381 | `list.kernel` | `itemize` with `\item`; `\leftmargini` 2.5em, `\labelsep` .5em, `\labelitemi` `\textbullet`, `\labelitemii` bold en dash |
| description list (class, unused) | hitec.cls:382-387 | `list.kernel` | `\descriptionlabel` bold, `\itemindent` = `-\leftmargin` |
| quotations (class, unused) | hitec.cls:397-416 | `quote.kernel` | `verse`, `quotation` (`\listparindent` 1.5em), `quote` |
| inline marks | hitec_doc.tex:2, 7, 15, 30, 42 | `mark.kernel` | `\textsc`, `\textbf`, `\texttt`, `\emph` |
| inline verbatim | hitec_doc.tex:42, 50, 53, 57 | `code.verbatim` | `\verb+...+` |
| manual spacing and raising | hitec_doc.tex:2-3, 15-16, 18, 20, 62 | `sp.manual-space` | `\raisebox{0.1em}` and `{-0.1em}` per letter of `\HT`; `\hspace{0pt}` after `\TeX` and `\LaTeX` |
| hyperlinks and bookmarks | hitec_doc.tex:8 | `meta.hyperref` | `\usepackage{hyperref}` with no options, loaded after the class (the comment says it may be omitted) |
| footnotes (class, unused) | hitec.cls:605-612 | `fn.kernel` | `\footnoterule` `\kern-3pt`, `.4\columnwidth`, `\@makefntext` hanging 1.8em |
| float types (class, unused) | hitec.cls:452-475 | `fig.graphicx` | kernel `figure`, `figure*`, `table`, `table*` through `\@float`, default placement `tbp` (454, 466) |
| float placement (class) | hitec.cls:156-165 | `fig.placement` | `topnumber` 2, `topfraction` .7, `bottomnumber` 1, `bottomfraction` .3, `totalnumber` 3, `textfraction` .2, `floatpagefraction` .5 and the `dbl` set |
| captions (class, unused) | hitec.cls:476-489 | `cap.kernel` | `\@makecaption`: `Label: text`, centred when it fits on one line, justified otherwise; `\abovecaptionskip` 10pt, `\belowcaptionskip` 0pt |
| table lengths (class, unused) | hitec.cls:443-450 | `tbl.tabular` | `\arraycolsep` 5pt, `\tabcolsep` 6pt, `\arrayrulewidth` .4pt, `\doublerulesep` 2pt |
| contents lists (class, unused) | hitec.cls:499-556 | `toc.kernel` | `\tableofcontents` `\listoffigures` `\listoftables` over `\section*`; `\l@section` bold, `\@dottedtocline` for deeper levels |
| bibliography (class, unused) | hitec.cls:557-579 | `bib.thebibliography` | `thebibliography` as a `\section*{\refname}` plus list, `openbib` option |
| index (class, unused) | hitec.cls:580-604 | `idx.makeidx` | `theindex` in two columns (`\columnsep` 35pt), `\@idxitem` `\hangindent 40pt` |
| equation numbering (class, unused) | hitec.cls:98-99, 451 | `math.eqnumber` | options `leqno` `fleqn` through `leqno.clo` `fleqn.clo`, `\theequation` arabic |
| language strings (class) | hitec.cls:613-626 | `class.hitec` | fixed English `\contentsname`, `\figurename`, `\abstractname`... and an English `\today`; no `babel` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\HT` logo alias | hitec_doc.tex:2-3 | yes | `\textsc` (`mark.kernel`) around five `\raisebox` calls of +0.1em and -0.1em (`sp.manual-space`); inline expansion, no counter or conditional; it is body content (the product name) |
| hitec.cls macros: `\company` `\confidential` `\fullcenter` `\settextfraction` `\secshape` `\longrule` `\@maketitle` `\@oddhead` `\@oddfoot` `\@makecaption` | hitec.cls:39-47, 130-155, 265-280, 330-332, 596-599, 633-645, 476-489 | not bespoke: published | The file is the CTAN class `hitec` (W1), so these are `class.hitec` vocabulary. Counted only for a re-read under another definition (class treated as unpublished): they would be `BESPOKE/class` candidates, because they replace `\@maketitle`, the page-style hooks and `\@makecaption` with box and rule layout. No expl3, Lua, `\halign` or output routine appears in the file, so a reduction through `front.titling`, `hf.fancyhdr` and `head.titlesec` would be the first thing to test; it was not attempted here. |

## Content-opaque
none (the sample has no figure, table, equation or code listing)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The class is a hack on `article` with pieces of `refman` and `fancyhdr` (hitec.cls:12-13); it loads no package and no other class (no `\RequirePackage` or `\LoadClass`), and only reads the kernel files `size1x.clo`, `leqno.clo`, `fleqn.clo` (98-99, 117).
- The header and footer are assigned after `\pagestyle{plain}` (hitec.cls:629, then 633-645), so they apply on every page whatever page style is chosen, except where `\thispagestyle{empty}` is in force (page 1, from `\maketitle`, 250).
- The author appears on every page in the header, so the class takes one `\author` string; the sample's text says repeated `\author` calls are not supported (hitec_doc.tex:42-48).
- README (README:1-23) is the author's note; it contains no text addressed to an AI.
