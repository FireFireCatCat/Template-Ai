no

# 0415-ijmart: ijmart, LaTeX class for The Israel Journal of Mathematics

- Unverified: read from the source, not compiled.
- Source: Source/0415-ijmart/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ijmart.zip; licence: LPPL 1.3 or later, manifest `lppl1.3`, ijmart.dtx:4-12)
- Kind: journal
- Lib: v5
- Engine: pdfLaTeX-compatible (the class sets the paper size with pdfTeX primitives under `\ifpdf`, ijmart.dtx:783-788; the manual describes a latex plus dvips route, ijmart.dtx:234-242)
- Look carried by: class (the published class `ijmart` sets page, running heads, title block, contents, headings, theorem styles and captions; the sample only declares theorems and notation aliases and loads no package itself, `\usepackage` does not occur in ijmsample.tex)
- Class origin: ctan
- Main file: ijmsample.tex (other samples: the documentation driver inside ijmart.dtx:656-670, a second document set with `ltxdoc`)
- Read: main yes, zip-local classes and styles all (ijmart.dtx class code and documentation in full, ijmart.ins in full, ijmart.bst in full; there is no shipped .cls, it is generated from ijmart.dtx by ijmart.ins:14-15; the base class `amsart` is not in the zip and was not read)

## Verdict
no. The class itself is a published CTAN class, so the zip's look reduces to `class.ijmart` (on `class.amsart`) plus reducible preamble lines (`\newtheorem`, notation aliases) and BibTeX with the bundled `ijmart.bst`. One construct in the sample body does not reduce: ijmsample.tex:1728-1746 redefines the kernel output routine's `\@makecol` to draw vertical rules beside every column box on the pages that follow, a layout-debugging device inherited from the amsmath test file. No lib way sets output-box internals, so it is recorded as a blocker with scope `body`. Without it, this zip would read yes with the look carried by the class.

## Blockers
- `BESPOKE/body` `\@makecol` redefinition adding `\vrule width\marginrulewidth` on both sides of every column box, with the zip-local `\newdimen\marginrulewidth` set to .1pt and later 0pt (ijmsample.tex:1733-1745, 2302)

## Class setting
- Class: `class.ijmart` options: none in the sample (ijmsample.tex:16). The class accepts `french` (ijmart.dtx:683-685), warns and ignores `8pt` to `12pt` (ijmart.dtx:691-698), passes every other option to `amsart` (ijmart.dtx:705), reads an optional `ijmart.cfg` (ijmart.dtx:710-714, none in the zip). It loads `class.amsart` with `10pt` (ijmart.dtx:727-728) and the packages `ifpdf`, `fancyhdr`, `lastpage` (ijmart.dtx:733).
- Class-native vocabulary used: `\title[short]{full}` (ijmsample.tex:107), `\author[abbr]{name}` once per author (109, 117, 119), `\address{lines with \\}` (110, 122), `\email` (115), `\date` (127), `\issueinfo{vol}{num}{month}{year}` (128), `\doiinfo` (129), `abstract` environment before `\maketitle` (130-134), `\thanks` inside title, author and email (108, 115, 117, 119), `\tableofcontents` (135), `namedprop` and `namedprop*` (1146-1172), `proof` and `\qed` (525, 1056), `\appendix` (1750), `\bibliographystyle{ijmart}` (2305). Defined by the class but not used by the sample: `\pagespan`, `\shortauthors`, `\curraddr`, `\urladdr`, `\centeredsection`, `\qedhere`, `\mqedhere`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ijmsample.tex:16; ijmart.dtx:641-642 | `class.ijmart` | no options; version 1.7 of 2013/06/23 |
| base class | ijmart.dtx:727-728 | `class.amsart` | `\PassOptionsToClass{10pt}{amsart}` then `\LoadClass{amsart}`; source not read |
| paper size | ijmart.dtx:768-769, 783-788 | `page.class-options` | fixed by the class, no option: `\paperheight` 636.77bp, `\paperwidth` 429.41bp; under `\ifpdf` `\pdfpageheight`, `\pdfpagewidth`, `\pdfvorigin`=0.9in, `\pdfhorigin`=1in |
| text block and margins | ijmart.dtx:798, 808, 818-822, 832-848, 856-870 | `page.class-options` | class-fixed (raw `\setlength` inside the class): headheight 32pt, footskip 42pt, topmargin 50bp based, textheight an integer number of lines plus `\topskip`, odd and even side margins 43bp, right margin 43bp |
| type sizes | ijmart.dtx:750-755; ijmsample.tex:1713, 1754 | `font.size-commands` | class table `\@typesizes` with `\normalsize` 10pt on 14pt; the sample uses `\Large` and `\large` |
| paragraph shape | ijmart.dtx:877, 1485-1486 | `sp.lengths` | `\parindent`=1em; first paragraph after a heading not indented (`\@afterindentfalse`) |
| overfull tolerance | ijmsample.tex:32 | `sp.lengths` | `\hfuzz`=1pc |
| running heads | ijmart.dtx:892-907, 913-920; ijmsample.tex:128-129 | `hf.class-native` | odd pages: `Vol. N, year`, short title, page; even pages: page, short authors, `Isr. J. Math.`; first page style `firstpage`: tiny centred journal line with volume, year, start and end page, and `DOI:`; values come from `\issueinfo` and `\doiinfo` |
| head mechanism inside the class | ijmart.dtx:733, 892-893, 900-920 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhead[LO,CO,RO,LE,CE,RE]` all `\footnotesize`, `\fancyfoot{}`, `\headrulewidth`=0pt, `\footrulewidth`=0pt, `\fancypagestyle{firstpage}` |
| page numbering | ijmart.dtx:1025-1033 | `pgnum.pagenumbering` | `\pagespan{first}{last}` sets `\pagenumbering{arabic}` or `{roman}` and `\setcounter{page}`; default `\pagespan{1}{}` |
| last page number | ijmart.dtx:733, 1031 | `pgnum.lastpage` | `\pageref{LastPage}` printed in the first-page head |
| title block | ijmsample.tex:107-129, 134; ijmart.dtx:938-960, 1174-1180, 1191-1229, 1239-1245 | `front.class-native` | title in uppercase `\Large` on 14pt; `BY` and `AND` tiny; authors `\normalsize\scshape`; addresses `\small\itshape`; `\date` as an unnumbered `\small` footnote; `\andify` without the serial comma (ijmart.dtx:1125-1126) |
| title footnotes | ijmsample.tex:108, 115, 117, 119; ijmart.dtx:1053-1057, 1084-1103 | `front.thanks` | `\thanks` text `\small`; marks `*`, `**`, dagger, double dagger; `\footnoterule` 2in; `\@makefntext` hangindent 2em |
| abstract | ijmsample.tex:130-133; ijmart.dtx:983-1014 | `abs.class-native` | placed before `\maketitle`; tiny uppercase name, `\Small` text in a list with `\leftmargin` 3pc |
| contents | ijmsample.tex:135; ijmart.dtx:1280-1327 | `toc.kernel` | `\tableofcontents`, heading `\contentsnamefont` = `\scshape\footnotesize` (ijmart.dtx:1269), body `\small` in a list with margins 2.4pc |
| contents entry look | ijmart.dtx:1334, 1342-1361, 1372-1385 | `front.class-native` | dotted leaders with `\@dotsep` 4.5, section entries bold only when `tocdepth` > 1, subsection indent 2.8pc, subsubsection 4.6pc (toc look is recorded under `front.class-native` by lib v3) |
| contents depth | ijmart.dtx:1263; ijmsample.tex:104 | `num.secnumdepth` | `tocdepth`=1; the sample's `\setcounter{tocdepth}{5}` is commented out |
| headings | ijmsample.tex:138; ijmart.dtx:1412, 1427-1471 | `head.class-native` | section bold, 20pt plus 4pt minus 4pt before, `0.5\linespacing` after; subsection small caps run-in; subsubsection italic run-in; paragraph and subparagraph run-in normal font; `\@secnumfont` empty |
| appendix | ijmsample.tex:1750; ijmart.dtx:1499-1502 | `num.appendix` | `\appendix` with `\thesection` as `\@Alph`, TOC measure disabled |
| lists | ijmsample.tex:514-522, 549-558, 645-657 | `list.kernel` | `enumerate` with `\renewcommand{\labelenumi}{(\roman{enumi})}` (515, 550, 646) |
| quotation | ijmsample.tex:1289-1295 | `quote.kernel` | `quotation` environment |
| footnote | ijmsample.tex:755-756 | `fn.kernel` | one `\footnote` in running text |
| text marks | ijmsample.tex:23-31, 131-132, 191, 504, 1754 | `mark.kernel` | `\normalfont\ttfamily`, `\textsf`, `\texttt`, `\textit`, `\emph`, `\textbf` |
| manual space | ijmsample.tex:700, 706 | `sp.manual-space` | `\vspace{5cm}` as the figure body |
| math environments | ijmsample.tex:154-157, 341-350, 1236-1241, 1559-1565, 1581-1600, 1767-1783, 1874-1896, 2074-2081, 2119-2124, 2242-2248 | `math.amsmath` | `equation`, `equation*`, `multline`, `split`, `gather`, `align`, `alignat`, `cases`, matrix family, `\substack`, `subarray`, `\genfrac`, `\cfrac`, `\boxed`, `\pmb`, `\boldsymbol`, `\overset`, `\sideset`, `\xrightarrow`, `\hdotsfor` (299, 1648), `\eqref`, `\tag` (1949), `\multlinegap` set to 0pt (936), `\DeclareMathOperator` (75-84) |
| display parameters | ijmsample.tex:1855, 1873 | `math.kernel` | `\delimiterfactor750` inside a group; `\ctagsplit@true` is an amsmath switch, the sample's own text names the `centertags` option (1850-1854) |
| theorem declarations | ijmsample.tex:37-49 | `thm.amsthm` | `\newtheorem{thm}{Theorem}[section]`; `cor`, `lem`, `prop` share `thm`; `ax` own counter; `\theoremstyle{definition}` with `defn`[section], `rem`[section], `notation*`; `\theoremstyle{remark}` with `step` |
| theorem styles | ijmart.dtx:1531-1552 | `thm.amsthm` | class redefines `\newtheoremstyle` for `plain` (body `\slshape`, head `\scshape`), `definition` (body `\upshape`, head `\slshape`), `remark` (body `\upshape`, head `\scshape`); space above and below `0.5\linespacing`, head punctuation `:`, head space 0.5em, note `\upshape (..)` |
| proof | ijmsample.tex:525-564, 660-670; ijmart.dtx:1561-1570 | `thm.amsthm` | `proof` environment renewed, head `\slshape`, `\topsep` 6pt plus 6pt |
| QED and named propositions | ijmsample.tex:1056, 1146-1172; ijmart.dtx:1581-1608, 1613-1677 | `thm.class-native` | `\qed` placed after the last line at `\qquad` distance, `\qedsymbol` = `\rule[0.47pt]{4pt}{6pt}`; `namedprop{style}{numbered-as}{name}[note]` and `namedprop*{style}{name}[note]` |
| figure and caption | ijmsample.tex:699-707; ijmart.dtx:1400 | `fig.graphicx` | `figure` float with `\vspace{5cm}` and no `\includegraphics`; class sets `\@captionheadfont` to `\normalfont` |
| caption | ijmsample.tex:701, 706 | `cap.kernel` | `\caption[]{...}` with an empty short title |
| cross references | ijmsample.tex:53-55, 212, 467 | `xref.kernel` | `\label`, `\ref`, `\pageref`; aliases `\thmref`, `\secref`, `\lemref` |
| verbatim | ijmsample.tex:160-162, 1391 | `code.verbatim` | `verbatim` environment and `\verb` with several delimiters |
| page breaks | ijmsample.tex:1726, 1807, 1849, 1871, 1927, 1979, 2071, 2116, 2173, 2239, 2283, 2301 | `pg.break` | `\newpage` |
| bibliography | ijmsample.tex:179, 905, 2304-2305; ijmart.dtx:1688-1690; ijmart.bst:1195 | `bib.bibtex-bst` | `\bibliographystyle{ijmart}` (bundled style, amsplain based: full first names, `\textsl` titles, `\textbf` volume, `fjournal` field, numeric labels, sorted), `\bibliography{ijmsample}`, `\cite[2.5.16]{..}`; the `References` head is a centred section (`\@bibtitlestyle`) |
| doc driver class (secondary) | ijmart.dtx:658 | `class.ltxdoc` | no options |
| doc driver package (secondary) | ijmart.dtx:62-63, 599, 663-668, 1702-1707 | `dtx.doc` | `\MakeShortVerb` (vertical bar), `\GetFileInfo`, `\PageIndex`, `\CodelineIndex`, `\RecordChanges`, `\EnableCrossrefs`, `\DocInput`, `\StopEventually`, `\Finale`, `\PrintChanges`, `\PrintIndex`; `array` is also loaded (659) but no table occurs |
| doc driver links (secondary) | ijmart.dtx:661-662 | `meta.hyperref` | `breaklinks`, `colorlinks`, `linkcolor=black`, `citecolor=black`, `pagecolor=black`, `urlcolor=black`, `hyperindex=false` |
| doc driver packages (secondary) | ijmart.dtx:660 | `meta.url` | `\usepackage{url,amsfonts}`; `amsfonts` is `math.amssymb` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\@makecol` redefinition, `\newdimen\marginrulewidth`, `\setlength` to .1pt then 0pt | ijmsample.tex:1728-1746, 2302 | no | rewrites the kernel's column assembly to wrap each column box in two `\vrule`s; the sample's comment calls it a device to show margins (ijmsample.tex:1730-1731). A `bg.eso-pic` overlay of `\put` and `\rule` would only imitate it with picture code (the restricted `art.pstricks` family) and does not reproduce the output-box mechanism, so it is not accepted |
| `ijmart.cls` from ijmart.dtx:671-1699 (redefines `\@startsection` calls, `\@starttoc`, `\@tocline`, `\@maketitle`, `\@settitle`, `\@setauthors`, `abstract`, `proof`, `\qed`, `namedprop`) | ijmart.dtx:671-1699 | not counted | published CTAN class (LPPL, maintainer Boris Veytsman, ijmart.dtx:4-17), so it is the way `class.ijmart` and its vocabulary is recorded above, not zip-local code |
| `\ntt` `\cn` `\pkg` `\fn` `\env` `\bslash` | ijmsample.tex:18-31 | yes | alias macros for documentation typography; expand inline to `\normalfont\ttfamily` text (`mark.kernel`) |
| `\thmref` `\secref` `\lemref` | ijmsample.tex:53-55 | yes | inline `Theorem~\ref{..}`, `\S\ref{..}`, `Lemma~\ref{..}` (`xref.kernel`) |
| notation aliases `\A` ... `\wh`, `\interval`, `\envert`, `\enVert`, `\abs`, `\norm` | ijmsample.tex:60-73, 88, 97-102 | yes | inline expansion to `\mathcal`, `\widetilde`, `\widehat`, `\left\lvert..\right\rvert` (`math.amsmath`) |
| `\eval` with an `\ifx` test | ijmsample.tex:93-94 | yes | the test only decides whether `\left.` is emitted; each call site expands to `\left.<arg>\right\rvert` or `<arg><opt>\rvert` at emit time (`math.amsmath`) |
| `\ctagsplit@true` in a group | ijmsample.tex:1855 | yes | a call to an amsmath internal switch, nothing defined; same effect as the `centertags` option the sample names at 1850-1854 (amsmath not read) |
| `\iffalse ... \fi` block | ijmsample.tex:2021-2067 | n/a | dead code, prints nothing |
| doc driver `\DescribeOption`, `\PrintDescribeOption`, `\SpecialOptionIndex`, `\DescribeOptions` | ijmart.dtx:45-60 | yes | marginpar plus `\index` entries per call, expanded at each call site (`note.marginpar`, `idx.makeidx`), documentation only |

## Content-opaque
none (the two figures are empty `\vspace{5cm}` boxes with captions, ijmsample.tex:699-707; display mathematics is content).

## Lib changes
- New ways proposed: none. Considered: `ifpdf` (load-only engine switch with no printed effect, like the rejected `sys.compat-load`); `fancyhdr` and `lastpage` are existing ways.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
