no

# 0151-siam-siamonline: SIAM Online macros (class siamonline250211, v1.6.5 of 2025/02/11)

- Unverified: read from the source, not compiled.
- Source: Source/0151-siam-siamonline/ (origin: https://epubs.siam.org/pb-assets/macros/online/siamonline_250211.zip; licence: not established; the class header restricts changes and redistribution to the whole kit, siamonline250211.cls:7-29)
- Kind: journal
- Lib: v3
- Engine: pdfLaTeX-compatible (`\ifpdf` branch, siamonline250211.cls:1408-1410; `\AddToHook` needs a 2020+ kernel, siamonline250211.cls:1793)
- Look carried by: class (the whole look is in siamonline250211.cls; the sample's ex_shared.tex only adds content, `\newsiam*` calls, `\setlist` and cleveref settings)
- Class origin: publisher-official (SIAM's own author-macro page; kit with docsiamonline.pdf, siamplain.bst, ex_*.tex)
- Main file: ex_article.tex (other samples: ex_supplement.tex; shared preamble ex_shared.tex)
- Read: main yes, zip-local classes and styles all (siamonline250211.cls read in full; siamplain.bst, a BibTeX style, only its header and function outline; docsiamonline.pdf could not be rendered here and was not read)

## Verdict
The look is carried by one publisher-official class, so the class itself is a published way (W1) and its internals (`\@maketitle`, `\@sect`, `\@makecaption`, the `eqnarray` `\halign`) are not counted as bespoke. Every sample construct maps to a lib way or to the class's own vocabulary, and nothing is artwork. The answer is `no` for one reason: the class loads `epstopdf` for every pdfLaTeX run (siamonline250211.cls:1408-1410), and `epstopdf` runs Ghostscript through shell escape; the sample also loads it and includes `.eps` figures through it (ex_shared.tex:11, ex_article.tex:185). Under the rubric's ruling on unconditionally loaded packages that need a tool outside TeX, that is `EXTERNAL/package`. Everything else would be `yes`.

## Blockers
- `EXTERNAL/package` the class loads `epstopdf` whenever the output is PDF, and the sample's figures are `.eps` files converted by it (siamonline250211.cls:1408-1410, ex_shared.tex:11, ex_shared.tex:13-17, ex_article.tex:185). Ghostscript is a tool outside TeX; the package needs it plus restricted shell escape. Loaded only in the `\ifpdf` branch, so under a DVI route it would not be loaded, but Flouest's engine is pdfTeX.

## Class setting
- Class: `class.siamonline250211` options: `review` (line numbers via `lineno`, footer "This manuscript is for review purposes only."; siamonline250211.cls:164, 1685-1709), `onefignum` and `onetabnum` (do not number figures and tables within sections; siamonline250211.cls:184-185, 1770-1778), `supplement` in ex_supplement.tex:2 (title prefix and SM label prefix; siamonline250211.cls:165, 604-609). Defaults forced by `\ExecuteOptions{SIADSpaper,10pt,twoside,onecolumn,leqno,draft,notitlepage}` (siamonline250211.cls:193). Other options the class declares and the sample does not use: `hidelinks`, `bakoma`, `nohypdvips`, `juq`, `oneeqnum`, `onealgnum`, `onethmnum`, `translated`, paper sizes (siamonline250211.cls:130-191).
- Class-native vocabulary used: `\title` `\author` `\and` `\thanks` `\funding` `\email` `\headers{short title}{short authors}` `\maketitle`; environments `abstract` `keywords` `MSCcodes`; `theorem` `lemma` `corollary` `proof` plus the declarers `\newsiamthm{name}{Label}` and `\newsiamremark{name}{Label}`; `\appendix`; `\bibliographystyle{siamplain}`. Defined by the class and not used by the sample: `\slugger`, `\supertitle`, `\subtitle`, `\dedication`, `\copyrightlineone`, `\appendixnotitle`, `\sameauthor`, `\URL`, `\nomathspace`, `romannum` and `remunerate` lists, journal-name macros (siamonline250211.cls:542-690, 810-819, 1025, 1222, 1228, 1760).
- Packages the class loads itself: `amsmath[leqno]`, `ntheorem`, `xr-hyper`, `ifpdf`, `hyperref`, `xcolor`, `graphics` `graphicx`, `epstopdf` (pdf), `hypcap[all]`, `algorithm`, `cleveref[capitalize,nameinlink]`, `lineno[mathlines]` (review only) (siamonline250211.cls:70, 368, 1365, 1371, 1384, 1395, 1409-1410, 1465, 1473, 1483, 1686). Considered for lib ways and not proposed: `hypcap` and `ifpdf` (class-internal plumbing, never called by the sample).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ex_article.tex:2 | `class.siamonline250211` | review, onefignum, onetabnum (supplement: ex_supplement.tex:2 adds `supplement`) |
| page size and text block | siamonline250211.cls:130-132, 193, 260, 1651 | `page.class-options` | class default `SIADSpaper` = 8.5in x 297mm; `\textwidth` 6.151in; `\textheight` 594.8005pt; `\topmargin` 0; side margins not set (lines commented out at 274-275, 289-290); no sample option |
| header and footer | ex_shared.tex:36; siamonline250211.cls:469-473, 499-513, 1671-1676 | `hf.class-native` | `\headers{An Example Article}{D. Doe, P. T. Frank, and J. E. Smith}` selects page style `myheadings`: uppercase running marks, page number in the outer corner, 2pt gray rule under the head; plain footer carries the page number (`header1` colour, `\HLsmall`) and, with `review`, the review notice |
| page numbering | siamonline250211.cls:1232, 1661 | `pgnum.pagenumbering` | arabic; `\thepage` gets the `SM` prefix under `supplement` |
| font sizes and families | siamonline250211.cls:198-234, 1722-1733 | `font.size-commands` | class-fixed: `\normalsize` 11/13.6pt, `\small` 10/12, `\footnotesize` 9/11; `\HL*` macros are aliases of `\sffamily` `\bfseries` `\itshape` plus a size (reducible, inside the class) |
| paragraph and float spacing | siamonline250211.cls:238, 313-325, 422, 429-438 | `sp.lengths` | class-fixed: `\parindent` .25in, `\parskip` 0pt, `\floatsep` 12pt, `\textfloatsep` 20pt, `\topfraction` .9, `\floatpagefraction` .91 |
| hyphenation list | siamonline250211.cls:1807-2051 | `sp.hyphenat` | one `\hyphenation{...}` list of US English exceptions, class-fixed |
| colours | siamonline250211.cls:1395-1406, 1425-1427 | `color.xcolor` | `header1` cmyk .9,.5,0,.35 (title, headings, labels); `gray` cmyk 0,0,0,.5 (rules); `siaminlinkcolor` green!50!black; `siamexlinkcolor` red!50!black; `siamreviewcolor` black!50 |
| PDF metadata and link colours | ex_article.tex:12-17; siamonline250211.cls:1386-1393, 1435-1443 | `meta.hyperref` | pdftitle, pdfauthor; class: `colorlinks=true`, `allcolors=siaminlinkcolor`, `urlcolor=siamexlinkcolor`, `pdfborder={0 0 0}`, `naturalnames=false`, `hypertexnames=false`, `breaklinks`; `\texorpdfstring` in ex_article.tex:207 |
| urls and email | ex_shared.tex:45-47; siamonline250211.cls:1394, 1447 | `meta.url` | `\urlstyle{same}`; `\email` is `\href{mailto:..}` |
| title block | ex_shared.tex:40-48; ex_article.tex:39; siamonline250211.cls:516-538, 613-661 | `front.class-native` | centered, `header1` colour, uppercase bold title with `\large` sans, authors sans with ", and" before the last (`\and`), 4pt gray rule below; `supplement` prefixes "Supplementary Materials: "; `\funding` inside `\thanks` (ex_shared.tex:41, siamonline250211.cls:1227) |
| author notes | ex_shared.tex:40-48; siamonline250211.cls:517-523, 1195-1202 | `front.thanks` | `\thanks` and `\footnotemark[3]` with `\fnsymbol` marks inside `\maketitle`; footnote text sans; 3pt/2.6pt footnote rule |
| abstract | ex_article.tex:42-49; siamonline250211.cls:821-829, 842 | `abs.class-native` | run-in label "Abstract." in `\HLsmall` `header1`, `\footnotesize`, `\parindent` .2in |
| keywords | ex_article.tex:52-54; siamonline250211.cls:843, 1213 | `abs.keywords` | `keywords` environment, label "Key words" |
| MSC codes | ex_article.tex:57-59; siamonline250211.cls:845, 1215 | `abs.classification` | `MSCcodes` environment, label "MSC codes" |
| headings | ex_article.tex:61, 75; siamonline250211.cls:719-742, 745-764 | `head.class-native` | run-in headings: indent .25in, beforeskip 1.3ex plus .5ex minus .2ex, afterskip -.5em plus -.1em, `\normalsize` `header1` sans bold (`\HLtext`), number then "." (siamonline250211.cls:721), text ends with `\@mypunct` "." (731, 740) |
| heading depth | siamonline250211.cls:359, 692 | `num.secnumdepth` | secnumdepth 3, tocdepth 3 |
| numbering | ex_article.tex:2; siamonline250211.cls:702-709, 1660-1664, 1765-1788 | `num.counters` | `\numberwithin{...}{section}` for equation, table, figure, algorithm, theorem; `onefignum`/`onetabnum` skip the figure and table ones; `\siamprelabel` prefix for supplement |
| appendix | ex_article.tex:217-218; siamonline250211.cls:1020-1046 | `num.appendix` | class `\appendix` redefines `\section` into an "Appendix A." run-in title; `\section*` stays an unnumbered title (ex_article.tex:226) |
| contents | siamonline250211.cls:1743-1745 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables` are emptied by the class; the sample prints none |
| lists | ex_shared.tex:20-22; siamonline250211.cls:786-803 | `list.enumitem` | `\setlist[enumerate]{leftmargin=.5in}`, `\setlist[itemize]{leftmargin=.5in}`; class `\leftmargini` .5in; no list in the body |
| display maths | ex_article.tex:90-93, 130-148; siamonline250211.cls:70 | `math.amsmath` | `equation`, `displaymath`, `subequations` + `align`, `bmatrix`, `pmatrix`; `\diag` via `\DeclareMathOperator` (ex_shared.tex:50-51, `amsopn`) |
| equation numbers | siamonline250211.cls:70, 193 | `math.eqnumber` | `leqno` (numbers on the left) |
| math fonts | ex_shared.tex:9 | `math.amssymb` | `amsfonts` (`\mathbb`) |
| theorem-like statements | ex_article.tex:86, 98, 114, 118, 221; ex_shared.tex:28-34; siamonline250211.cls:1525-1590 | `thm.class-native` | `theorem` (sans header in `header1`, italic body, "." separator), `lemma` `corollary` `proposition` `definition` share the theorem counter, `\newsiamthm` and `\newsiamremark` (italic header, upright body) add more, `proof` unnumbered with italic header and a `\proofbox` end mark (1537, 1549-1554), pre/post skip 1ex plus .25ex minus .1ex (1541-1542) |
| algorithm | ex_article.tex:158-171; ex_shared.tex:12; siamonline250211.cls:1473-1475 | `alg.algorithmicx` | `algorithm` float (loaded by the class, name "Algorithm", number prefixed by `\siamprelabel`) with `algorithmic` (`\STATE` `\WHILE` `\RETURN`) |
| figure | ex_article.tex:183-188; ex_shared.tex:10, 13-17; siamonline250211.cls:1061-1079 | `fig.graphicx` | `figure[htbp]`, `\centering`, `\includegraphics{lexample_fig1}`; `\DeclareGraphicsExtensions{.eps,.pdf,.png,.jpg}`; class default placement `tp` (1070) |
| EPS conversion | ex_shared.tex:11; siamonline250211.cls:1408-1410 | `fig.epstopdf` | `\usepackage{epstopdf}` with no options; EXTERNAL (Ghostscript) |
| table | ex_article.tex:193-203; siamonline250211.cls:1080-1098, 1051-1054 | `tbl.tabular` | `table[htbp]`, `\footnotesize`, `center`, `tabular{|c|c|c|}` with `\hline` and `\bf`; `\tabcolsep` 6pt, `\arrayrulewidth` .4pt |
| captions | ex_article.tex:186, 195; siamonline250211.cls:1104-1126 | `cap.kernel` | `\caption` only; look fixed by the class's `\@makecaption`: `\footnotesize`; figure label "Figure N." in `header1` plus italic text under the figure, centered when it fits; table label centered above, italic text; 10pt skips |
| footnote typography | siamonline250211.cls:1195-1202 | `fn.kernel` | `\@makefntext` .25in hang, `\footnoterule` full text width; no footnote in the body |
| cross-references | ex_article.tex:71-73, 83, 111, 149; ex_shared.tex:25, 30, 33; siamonline250211.cls:1483-1511 | `xref.cleveref` | `capitalize,nameinlink`; `\crefname{hypothesis}`/`{fact}` in ex_shared.tex:30, 33; `\creflastconjunction` = ", and~" (ex_shared.tex:25); equation formats without the word "equation" (1495-1508) |
| labels | ex_article.tex:76, 86, 130 | `xref.kernel` | `\label` |
| cross-document references | ex_article.tex:22; ex_supplement.tex:6; siamonline250211.cls:1365 | `xref.xr` | `\externaldocument[][nocite]{ex_supplement}` (prefix empty, option `nocite`) with `xr-hyper` |
| line numbers (review) | ex_article.tex:2; siamonline250211.cls:1685-1709 | `sp.draft-lineno` | `lineno[mathlines]`, `\linenumbers`, number font `\footnotesize` in `siamreviewcolor` |
| bibliography | ex_article.tex:230-231; siamonline250211.cls:1142-1174, 1663-1664; siamplain.bst:1-20 | `bib.bibtex-bst` | `\bibliographystyle{siamplain}` (the kit's own `.bst`, numeric labels, alphabetic order, names in small caps), `\bibliography{references}`; class `thebibliography`: centered "REFERENCES" in `header1`, `\footnotesize`, `\clubpenalty` and `\widowpenalty` 4000 (1167) |
| filler text | ex_shared.tex:8; ex_article.tex:67, 81, 96 | `draft.todo` | `lipsum` (`\lipsum[2-3]`...) |
| sample structure | ex_article.tex:9; ex_supplement.tex:4 | none (inline) | `\input{ex_shared}`; an emitter writes one file |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\creflastconjunction` redefinition | ex_shared.tex:25 | yes | cleveref's documented list-conjunction setting: `xref.cleveref` |
| `\newsiamremark` / `\newsiamthm` calls, `\crefname` | ex_shared.tex:28-34 | yes | class-native declarers (`thm.class-native`) and cleveref names (`xref.cleveref`) |
| `\ifpdf` guards | ex_article.tex:12-17; ex_shared.tex:13-17 | yes | drop the guard, pdfLaTeX only; the `ifpdf` package comes from the class (siamonline250211.cls:1371) |
| `\externaldocument` | ex_article.tex:22; ex_supplement.tex:6 | yes | `xref.xr`; it needs the other document's `.aux`, so two documents are built in order (not an outside tool) |
| `\@maketitle`, `\@doauth`, `\@ucnothanks` | siamonline250211.cls:613-661 | published (official kit) | carried by `class.siamonline250211`; not copied |
| `\@sect`, `\@ssect`, heading commands, `\appendix` family | siamonline250211.cls:719-764, 1020-1046 | published (official kit) | carried by the class |
| `\@makecaption` | siamonline250211.cls:1104-1126 | published (official kit) | carried by the class |
| `\ps@plain`, `\ps@myheadings`, `\f@@terwithc@pyright`, `\headers` | siamonline250211.cls:462-513, 1671-1676 | published (official kit) | `hf.class-native` |
| `eqnarray` redefinition with `\halign` | siamonline250211.cls:965-980 | published (official kit) | carried by the class; the sample does not use `eqnarray` |
| `renewtheoremstyle` blocks, `\PotEndMark` patch | siamonline250211.cls:1525-1532, 1754-1756 | published (official kit) | `thm.class-native` |
| `lineno` patch macros for amsmath | siamonline250211.cls:1692-1706 | published (official kit) | `sp.draft-lineno` through the `review` option |
| `\AddToHook` `\crefalias` fixes | siamonline250211.cls:1793-1802 | published (official kit) | carried by the class |
| `\thebibliography`, `theindex` | siamonline250211.cls:1142-1194 | published (official kit) | `bib.bibtex-bst` through the class |
| `\HL*` font aliases | siamonline250211.cls:1722-1733 | yes | compositions of kernel font switches and `\footnotesize`/`\large` |

If a reader rules instead that an official class that redefines `\@maketitle`, `\@sect`, `\@makecaption` and `\eqnarray` is not a published way, the class rows above become `BESPOKE/class` (irreducible kernel redefinitions) and the verdict is still `no`. Under the ruling used here (official kit = published), `EXTERNAL/package` for `epstopdf` is the only blocker.

## Content-opaque
- EPS figure artwork `lexample_fig1.eps` in the figure float (ex_article.tex:185); `lexample_fig2.eps` and `data.dat` are not referenced by any `.tex` file here.
- Algorithm statements inside `algorithmic` (ex_article.tex:162-169), table cells, equations and theorem texts are content.

## Lib changes
- New ways proposed:
  - `xref.xr` `xr` (CTAN, in TeX Live as part of `tools`; David Carlisle) with its hyperref-aware sibling `xr-hyper` (the class loads `xr-hyper`; not confirmed on the ctan.org/pkg/xr page, which names only `xr`), engine pdf. W1: published package. W2: one command `\externaldocument[prefix][nocite]{file}`, values are a prefix string, an option and a file name. W3: any document that cites labels of another document. W4: preamble line. Not `xref.kernel`, `xref.hyperref` or `xref.zref`, which refer within one document.
  - `fig.epstopdf` `epstopdf` (CTAN, in TeX Live; the LaTeX package is `epstopdf-pkg`), engine pdf, **EXTERNAL** when active (the ctan.org/pkg/epstopdf page says the converter uses Ghostscript; running it from TeX needs restricted shell escape, per the package documentation, not read here). W1: published. W2: package options and `\epstopdfsetup{...}` keys. W3: any document with EPS images. W4: one preamble line. Not `fig.graphicx`, which takes no EPS under pdfTeX without a converter (as `fig.svg` is separate).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
