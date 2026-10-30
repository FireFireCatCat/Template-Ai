yes

# 0319-ijcai: IJCAI-ECAI 26 formatting kit (`ijcai26.sty` and `named.bst` on `article`)

- Unverified: read from the source, not compiled.
- Source: Source/0319-ijcai/ (origin: https://www.ijcai.org/sites/default/files/Guidelines/FormattingGuidelines-IJCAI-ECAI-26.zip; licence: not established. The kit's own notice allows reuse and modification if the credit lines stay: ijcai26.sty:26-28, ijcai26.tex:52-54)
- Kind: conference
- Lib: v3
- Engine: pdfLaTeX-compatible (the sample sets the pdfTeX primitives `\pdfpagewidth`, `\pdfpageheight` and `\pdfinfo`: ijcai26.tex:8-9, 70-72)
- Look carried by: mixed (`ijcai26.sty`, the conference's own house style, defines page, title block, abstract, headings, lists, floats and citation labels; the sample preamble adds Times, `caption[small]`, amsthm theorems, lineno, ijcai26.tex:16-33, 42-43)
- Class origin: publisher-official (`ijcai26.sty` and `named.bst` come from the conference's own formatting-guidelines download, ijcai26.sty:3; the document class itself is kernel `article`, tex-distribution-unbundled)
- Main file: ijcai26.tex (other samples: none; `ijcai26.docx` is the Word template, not LaTeX, not analysed)
- Read: main yes (all 635 lines), zip-local classes and styles all (`ijcai26.sty`, 335 lines, read in full; no `.cls` present). `named.bst` partly: lines 38-367 and 940-1287 read, the entry-type functions 368-939 and the journal-name MACROs not read. `ijcai26.bib` is data (88 lines: 5 `@article`, 1 `@book`, 2 `@inproceedings` by grep).

## Verdict
Yes. The sample is a kernel `article` with the publisher's own house style `\usepackage{ijcai26}` (ijcai26.tex:13) and an ordinary preamble of published packages (`times`, `soul`, `url`, `hyperref`, `inputenc`, `caption`, `graphicx`, `amsmath`, `amsthm`, `booktabs`, `algorithm`, `algorithmic`, `lineno`). Under the rubric's official-kit ruling the style is published (W1), so it is one class-like way, `class.ijcai26`, as the lib's v3 log treats house styles; every other component of the sample is an existing lib way and there is no artwork or external tool. Sensitivity: the title macros (ijcai26.sty:99-169) and the citation macros (ijcai26.sty:284-319) are hand-written typesetting code that no lib component way expresses; if a reviewer did not accept the official-kit ruling for a `.sty`, these would be `BESPOKE/class` and the answer would flip to `no`.

## Blockers
none

## Class setting
- Class: `class.article` options: none (`\documentclass{article}`, ijcai26.tex:7); the page size is set after it with `\pdfpagewidth=8.5in`, `\pdfpageheight=11in` (ijcai26.tex:8-9). House style: `class.ijcai26` (`\usepackage{ijcai26}`, ijcai26.tex:13), no options.
- Class-native vocabulary used: inside `\author{}`: `\affiliations`, `\emails` (ijcai26.tex:77-83; defined ijcai26.sty:155-164), `\and`, `\And` (ijcai26.sty:153-154; used in the `\iffalse` multi-author block, ijcai26.tex:86-103); length `\titlebox` (2.25in, ijcai26.sty:100) that grows to fit a taller title; citation commands `\cite`, `\shortcite` (ijcai26.sty:286-288; used ijcai26.tex:258, 386; also defined `\citeauthor`, `\citeyear`, ijcai26.sty:290-291, unused in the sample); `\pubnote{}` (ijcai26.sty:62-65, unused in the sample); the `abstract` environment (ijcai26.sty:170-171); the named citation labels `\citeauthoryear{author}{year}` written by `named.bst` (named.bst:1067-1069).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ijcai26.tex:7 | `class.article` | no options |
| house style (the look) | ijcai26.tex:13; ijcai26.sty:1-335 | `class.ijcai26` | no options; vocabulary under "Class setting" |
| paper size | ijcai26.tex:8-9 | `page.setlength` | `\pdfpagewidth=8.5in`, `\pdfpageheight=11in` (pdfTeX paper-size dimensions, same type as the raw page lengths; letter, which is also `article`'s default paper) |
| text block and margins | ijcai26.sty:49-54 | `page.setlength` | `\topmargin`-0.25in, `\oddsidemargin`-0.25in, `\evensidemargin`-0.25in, `\textheight` 9.0in, `\textwidth` 7.0in |
| two columns | ijcai26.sty:47, 54 | `cols.twocolumn-cmd` | `\twocolumn` in the preamble, `\columnsep` 0.25in; the title goes in as the full-width block `\twocolumn[\@maketitle]` (ijcai26.sty:105) |
| bottom alignment | ijcai26.sty:47 | `pg.flush` | `\flushbottom` |
| line breaking | ijcai26.sty:47 | `sp.hyphenat` | `\sloppy` |
| header and footer | ijcai26.sty:57-59 | `hf.pagestyle-kernel` | `\pagestyle{empty}`, `\thispagestyle{empty}`, `\headheight` 0pt, `\headsep` 0pt (no running heads or page numbers) |
| `\pubnote` running note | ijcai26.sty:62-65 | `hf.pagestyle-kernel` | `\thispagestyle{myheadings}`, `\markboth{#1}{#1}`, empty `\thepage`; unused in the sample |
| type sizes | ijcai26.sty:81-91 | `font.size-commands` | `\@setsize` (kernel compat command for `\@setfontsize`): normalsize 10/11, small and footnotesize 9/10, scriptsize 7/8, tiny 6/7, large 11/12, Large 12/14, LARGE 14/16, huge 17/20, Huge 20/23 |
| text face | ijcai26.tex:16 | `font.mathptmx` | `\usepackage{times}` |
| input encoding | ijcai26.tex:20 | `font.fontenc-t1` | `inputenc[utf8]` |
| paragraph shape | ijcai26.sty:95-96 | `sp.lengths` | `\parindent` 1em, `\parskip` 0pt plus 1pt |
| title, author, date commands | ijcai26.tex:74-83, 107 | `front.maketitle` | `\title`, `\author`, `\maketitle` (the style redefines `\maketitle`, ijcai26.sty:101-109) |
| title block layout | ijcai26.sty:99-169 | `front.class-native` | centred `\LARGE\bf` title, `\Large\bf` authors, `\Large\rm` affiliation and e-mail lines, `\vbox to \titlebox` with `\titlebox` 2.25in, grown by `\settoheight`/`\ifdim` when the measured title area is taller (ijcai26.sty:136-141) |
| author footnote marks | ijcai26.sty:103-104, 146 | `front.thanks` | `\thefootnote` as `\fnsymbol{footnote}` inside the title; `\thanks` becomes `\footnotemark` in the box; counter reset ijcai26.sty:107 (`num.counters`) |
| abstract | ijcai26.sty:170-171; ijcai26.tex:109-114 | `abs.class-native` | `\renewenvironment{abstract}`: centred `\Large\bf Abstract`, `\vspace{0.5ex}`, then a `quote` block, `\vskip 1ex` after |
| section headings | ijcai26.sty:174-181 | `head.kernel` | `\@startsection` parameters: section level 1, skip -10pt plus -3pt minus -2pt / 4pt plus 2pt minus 1pt, `\Large\bf\raggedright`; subsection level 2, -8pt plus -2pt minus -2pt / 3pt plus 2pt minus 1pt, `\large\bf\raggedright`; subsubsection level 3, -6pt plus -2pt minus -1pt / 1pt plus 1pt minus 1pt, `\normalsize\bf\raggedright`; paragraph level 4, -4pt plus -2pt minus -1pt / run-in -1em, `\normalsize\bf`. Same effect through `head.titlesec` (`\titleformat`, `\titlespacing`) if preferred |
| heading numbering depth | ijcai26.sty:182 | `num.secnumdepth` | `secnumdepth` 2 |
| unnumbered sections | ijcai26.tex:613, 617 | `head.kernel` | `\section*{Ethical Statement}`, `\section*{Acknowledgments}` |
| appendix | ijcai26.tex:611 | `num.appendix` | `\appendix` |
| lists | ijcai26.sty:203-239; ijcai26.tex:149, 374 | `list.kernel` | `itemize`, `enumerate`; margins `\leftmargini` 2em, `\leftmarginii` 2em, `\leftmarginiii` 1em, `\leftmarginiv`-`vi` 0.5em, `\labelsep` 5pt |
| list spacing | ijcai26.sty:214-233 | `sp.lengths` | level-1 `\parsep` 2pt plus 1pt minus 0.5pt, `\topsep` 4pt plus 1pt minus 2pt, `\itemsep` 2pt plus 1pt minus 0.5pt, `\partopsep` 1pt plus 0.5pt minus 0.5pt; levels 2 and 3 tighter |
| quoted blocks | ijcai26.tex:173, 324 | `quote.kernel` | `quote` |
| footnotes | ijcai26.sty:185; ijcai26.tex:130, 176, 406 | `fn.kernel` | `\footnote`; `\footnotesep` 6.65pt, `\skip\footins` 9pt plus 4pt minus 2pt (`sp.lengths`) |
| footnote rule | ijcai26.sty:186 | `sp.rule` | `\kern-3pt \hrule width 5pc \kern 2.6pt` |
| float spacing | ijcai26.sty:190-194 | `fig.placement` | `\floatsep` 12pt plus 2pt minus 2pt, `\textfloatsep` 16pt plus 2pt minus 4pt, `\intextsep` 12pt plus 2pt minus 2pt, `\dblfloatsep` 12pt plus 2pt minus 2pt, `\dbltextfloatsep` 18pt plus 2pt minus 4pt |
| display spacing | ijcai26.sty:197-200 | `sp.lengths` | `\abovedisplayskip` 7pt plus 2pt minus 5pt, `\belowdisplayskip` equal, `\abovedisplayshortskip` 0pt plus 3pt, `\belowdisplayshortskip` 4pt plus 3pt minus 3pt |
| tables | ijcai26.tex:444-459, 461-476 | `tbl.tabular` | `table` float, `\centering`, `tabular{lll}` with `\hline` and `tabular{lrr}` |
| table rules | ijcai26.tex:25, 464-472 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| centring | ijcai26.tex:445, 462 | `sp.ragged` | `\centering` in floats |
| captions | ijcai26.tex:21, 457, 474 | `cap.caption` | `caption[small]`; `\caption` below the table (`cap.kernel`) |
| images and resizing | ijcai26.tex:22, 505, 521 | `fig.graphicx` | `graphicx` loaded; `\resizebox{.91\linewidth}{!}{...}` around an equation |
| display maths | ijcai26.tex:23, 491, 498-501, 504-509 | `math.amsmath` | `equation`, `align`, `\nonumber`, `\displaystyle` |
| size switch environment | ijcai26.tex:490-494, 515 | `font.size-commands` | `tiny` environment (a bad example in the text), `\small` |
| theorem-like statements | ijcai26.tex:24, 42-43, 537-549 | `thm.amsthm` | `\newtheorem{example}{Example}`, `\newtheorem{theorem}{Theorem}`: default `plain` style, one counter each and no `within`, so numbering is global; optional title argument |
| proof | ijcai26.tex:557-559 | `thm.amsthm` | `proof` environment with the amsthm default QED square |
| algorithm | ijcai26.tex:26-27, 568-586 | `alg.algorithmicx` | `algorithm[tb]` float with `\caption`/`\label`, `algorithmic[1]`, `\STATE` `\WHILE` `\IF` `\ELSE` |
| line numbers | ijcai26.tex:28, 31 | `sp.draft-lineno` | `lineno[switch]`, `\linenumbers` (to be commented out for camera-ready) |
| hyperlinks | ijcai26.tex:19 | `meta.hyperref` | `hyperref[hidelinks]` |
| PDF info entry | ijcai26.tex:70-72 | `meta.hyperref` | raw `\pdfinfo{/TemplateVersion (IJCAI.2026.0)}`; the same entry is the hyperref key `pdfinfo` (`pdfinfo={TemplateVersion=IJCAI.2026.0}`; the key exists in the TeX Live copy of hyperref.sty:3633, checked there, not in the zip) |
| URLs | ijcai26.tex:18, 33, 130 | `meta.url` | `url`, `\urlstyle{same}`, `\url{}` |
| underline and highlight | ijcai26.tex:17 | `mark.ulem` | `soul` loaded; no `\hl`, `\ul` or `\st` call in the sample (grep) |
| inline marks | ijcai26.tex:110, 119, 180 | `mark.kernel` | `{\it }`, `{\em }`, `{\bf }`, `{\tt }`, `\emph`, `\textbf`, `\texttt` |
| cross-references | ijcai26.tex:458, 478, 588 | `xref.kernel` | `\label`, `\ref` |
| citation commands | ijcai26.sty:284-319; ijcai26.tex:258, 386, 394-401 | `bib.bibtex-bst` | the kit's own `\cite` (author, year in square brackets raised by `\@up`) and `\shortcite` (year only), `\nocite`; bracket labels in the list via `\@biblabel` (ijcai26.sty:317) |
| bibliography | ijcai26.tex:631-632; named.bst:1-1287 | `bib.bibtex-bst` | `\bibliographystyle{named}`, `\bibliography{ijcai26}`; `named.bst` writes `\bibitem[\protect\citeauthoryear{..}{..}]{key}` (named.bst:113-121, 1067-1069) inside the kernel `thebibliography` (named.bst:1272), sorted by author, year, title (named.bst:1174-1209) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newtheorem{example}`, `\newtheorem{theorem}` | ijcai26.tex:42-43 | yes | `thm.amsthm`: two independent counters, default `plain` style |
| `\iffalse ... \fi` alternative multi-author block | ijcai26.tex:86-103 | not compiled | never expanded; documentation of the `\and`/`\And` syntax, content |
| `\@maketitle`, `\titlebox`, `\titlepad`, grow-to-fit title box | ijcai26.sty:99-169 | published, not zip-local | the publisher's own kit, so part of `class.ijcai26`; not expressible with lib component ways (measures the title in a box with `\settoheight` and enlarges `\titlebox`); would be `BESPOKE/class` if the style were zip-local |
| named.sty citation macros `\cite` `\shortcite` `\citeauthor` `\citeyear` `\@citex` `\@icite` `\@biblabel` | ijcai26.sty:284-319 | published, not zip-local | same: part of the official kit, paired with `named.bst` labels; would be `BESPOKE/class` if zip-local |
| `\pubnote` | ijcai26.sty:62-65 | published; unused in the sample | `hf.pagestyle-kernel` |
| `\@setsize` size definitions | ijcai26.sty:81-91 | yes | `font.size-commands` (`\@setsize` is the kernel compat wrapper of `\@setfontsize`, latex.ltx:14300 in the local TeX Live copy) |
| `\@startsection` heading definitions | ijcai26.sty:174-181 | yes | `head.kernel` parameters above |
| `\footnoterule` | ijcai26.sty:186 | yes | `sp.rule` |
| abstract environment | ijcai26.sty:170-171 | yes | `abs.class-native` (a `\renewenvironment` over `quote`) |

## Content-opaque
none (the equations at ijcai26.tex:490-525 and the algorithm body at ijcai26.tex:574-585 are content that `math.amsmath` and `alg.algorithmicx` hold; the bibliography entries in ijcai26.bib are data)

## Lib changes
- New ways proposed: none. `class.article` and `class.ijcai26` are class ways and need no proposal (a house style is class-like per the v3 log); `\pdfinfo` is covered by `meta.hyperref` (its `pdfinfo` key), `\pdfpagewidth`/`\pdfpageheight` by `page.setlength`. Considered and not proposed: a separate way for the pdfTeX `\pdfinfo` primitive.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
