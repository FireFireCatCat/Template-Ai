no

# 0186-siam-siamart: SIAM article class `siamart251216` (SIAM journals, official macro kit)

- Unverified: read from the source, not compiled.
- Source: Source/0186-siam-siamart/ (origin: https://epubs.siam.org/pb-assets/macros/standard/siamart_251216.zip; licence: not established. The class header siamart251216.cls:7-29 forbids changing the file and allows distribution only together with the whole kit)
- Kind: journal
- Lib: v3
- Engine: pdfLaTeX-compatible (kernel hooks `\AddToHook` at siamart251216.cls:1691; `epstopdf` needs Ghostscript, see Blockers)
- Look carried by: class (siamart251216.cls defines page, headings, title block, abstract, theorems, captions, bibliography; ex_shared.tex only loads packages and calls class commands)
- Class origin: publisher-official
- Main file: ex_article.tex (other samples: ex_supplement.tex with option `supplement`; ex_shared.tex is the preamble both `\input`, it has no `\documentclass`)
- Read: main yes, zip-local classes and styles all (siamart251216.cls 1-1956 in full, including the hyphenation list at 1705-1949; siamplain.bst only its header and the `begin.bib`/`end.bib` functions, 1-40 and 1128-1151)

## Verdict
The look is carried by one published, publisher-official class (`class.siamart`, the kit's own author page is the origin), so its internal `\@startsection`, `\@maketitle`, `\@makecaption` and `\halign` code rides inside that class way and is not zip-local bespoke. Everything the sample adds is a class-native declaration or a published package call, and each one reduces to a lib way (one new way is proposed for cross-document references). The answer is `no` on one point only: the class loads `epstopdf` unconditionally under pdfTeX (siamart251216.cls:1328) and the sample ships only `.eps` figures, so the output needs Ghostscript through shell escape, which the pilot ruling files as `EXTERNAL/package`. Without that package the rest would be `yes`.

## Blockers
- `EXTERNAL/package` `epstopdf` runs Ghostscript on the fly to turn the shipped `.eps` figures into PDF; the class loads it for every pdfTeX run and ex_shared.tex loads it again, so the document does not compile without the tool (siamart251216.cls:1326-1328, ex_shared.tex:11, ex_shared.tex:14, ex_article.tex:185; only lexample_fig1.eps and lexample_fig2.eps exist). Borderline: TeX Live allows the converter under restricted shell escape by default; I rule it as the pilot ruling reads, because a wrong `yes` costs more.

## Class setting
- Class: `class.siamart` (file `siamart251216`, v1.4.8 of 2025/12/16, siamart251216.cls:48) options used: `review` (ex_article.tex:2, line numbers and a review footer, siamart251216.cls:1602-1626), `hidelinks` (cls:1353-1354), `onefignum` and `onetabnum` (cls:1666-1674), `supplement` in ex_supplement.tex:2 (cls:545-550). Defaults forced by `\ExecuteOptions{printtrim,10pt,twoside,onecolumn,leqno,draft,notitlepage}` (cls:201).
- Class-native vocabulary used: `\headers{short title}{short authors}` (ex_shared.tex:31, cls:1588-1593); `\title` with `\thanks` and `\funding` (ex_shared.tex:35-36, cls:1158); `\author` with `\and`, `\email` (ex_shared.tex:39-43, cls:1365); `abstract`, `keywords`, `MSCcodes` environments (ex_article.tex:42-59, cls:768-771); `theorem`, `lemma`, `corollary`, `proof` (ex_article.tex:86-124, cls:1471-1496); `\newsiamthm`, `\newsiamremark` (ex_shared.tex:23-27, cls:1483-1507); `\crefname` through the class's cleveref set-up (cls:1401-1429); `\externaldocument` through the class's xr-hyper (ex_article.tex:22, cls:1296). Defined by the class but not used by the sample: `\supertitle`, `\subtitle`, `\slugger`, `\copyrightlineone`, `\orcid`, `\sameauthor`, `\appendixnotitle`, `romannum`, `remunerate`, `DOI`, `AMS`, journal-name macros `\sinum` etc., `theindex` (cls:500-618, 737-777, 821, 951, 1107-1125, 1159); the class is one column by default (cls:179, 201), so no column way is needed.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ex_article.tex:2; ex_supplement.tex:2 | `class.siamart` | options review, hidelinks, onefignum, onetabnum (+ supplement); `printtrim` default |
| page size, text block | siamart251216.cls:152-155, 268, 1569, 297-298 | `page.class-options` | class option `printtrim` = 6.75in x 10in; text block 5.125in x 598pt, side margins -.12in/-.27in (twoside), `\voffset` -.5in; set by the class, not by the sample |
| running head, folio, footer | ex_shared.tex:31; siamart251216.cls:421-437, 463-471, 1588-1593 | `hf.class-native` | `\headers` fills `myheadings`: outer-edge page number, upper-case small head text; plain-style footer with folio and a `\footercopyright` line (review note "This manuscript is for review purposes only.", cls:1624) |
| page numbers | siamart251216.cls:1163, 1578 | `pgnum.pagenumbering` | arabic; `\thepage` prefixed by `\siamprelabel` ("SM" in a supplement, cls:548-549) |
| text lengths and parameters | siamart251216.cls:246, 387, 339-350, 208 | `sp.lengths` | parindent .25in, parskip 0pt, float separations, display skips; class-set |
| penalties and breaks | siamart251216.cls:391-393, 1101 | `sp.penalties` | `\@lowpenalty` 51, `\@medpenalty` 151, `\@highpenalty` 301; `\clubpenalty` and `\widowpenalty` 4000 in the bibliography |
| hyphenation exceptions | siamart251216.cls:1705-1949 | `sp.hyphenat` | one `\hyphenation{...}` word list (US English) |
| font sizes | siamart251216.cls:206-242 | `font.size-commands` | normal 10pt/12pt, `\small` 9/11, `\footnotesize` 8/9.5, `\large`..`\Huge` redefined; no font package, Computer Modern stays |
| old font switches | siamart251216.cls:1053-1061; ex_article.tex:198 | `mark.kernel` | `\bf`, `\it`, `\sc`... re-declared with `\DeclareOldFontCommand`; sample uses `\bf` in the table header |
| colours | siamart251216.cls:1342-1346 | `color.xcolor` | `\colorlet` siaminlinkcolor green!50!black, siamexlinkcolor red!50!black, siamreviewcolor black!50 |
| PDF metadata, links | ex_article.tex:13-16; siamart251216.cls:1315-1325, 1353-1361 | `meta.hyperref` | pdftitle, pdfauthor; class sets colorlinks, allcolors, urlcolor, pdfborder, breaklinks, naturalnames=false; `hidelinks` option; sample wraps it in `\ifpdf`, constant under pdfTeX |
| URLs and e-mail | ex_shared.tex:40; siamart251216.cls:1325, 1365 | `meta.url` | `\urlstyle{same}`, `\url`, class `\email` as `\href{mailto:}` |
| title block | ex_article.tex:39; ex_shared.tex:35-43; siamart251216.cls:474-496, 554-575 | `front.class-native` | `\maketitle` prints a bold upper-case title, `\footnotesize` authors joined by `\and` as ", AND", `\subtitle` slot; `supplement` prepends "Supplementary Materials: " (cls:548) |
| author notes | ex_shared.tex:35-43; siamart251216.cls:475-481 | `front.thanks` | `\thanks` and `\footnotemark[3]`, symbols `*` `\dagger` `\ddagger` `\mathsection` |
| abstract | ex_article.tex:42-49; siamart251216.cls:748-768 | `abs.class-native` | `abstract` env: `\footnotesize`, run-in bold "Abstract." heading, parindent .2in |
| keywords | ex_article.tex:52-54; siamart251216.cls:769 | `abs.keywords` | `keywords` env, heading "Key words" (cls:1144) |
| MSC codes | ex_article.tex:57-59; siamart251216.cls:771, 1146 | `abs.classification` | `MSCcodes` env, heading "MSC codes" |
| headings | ex_article.tex:61, 75, 175, 209; siamart251216.cls:648-665, 674-693 | `head.class-native` | `\@startsection` with before skip 1.3ex plus .5ex minus .2ex, after skip -.5em (run-in heading), indent .25in, bold normalsize, trailing period; class-set, no option |
| heading in bookmarks | ex_article.tex:209 | `meta.hyperref` | `\texorpdfstring{{\boldmath$Z=X \cup Y$}}{Z = X union Y}` |
| section depth | siamart251216.cls:324, 621 | `num.secnumdepth` | secnumdepth 3, tocdepth 3 |
| numbering | siamart251216.cls:631-638, 1661-1684 | `num.counters` | `\numberwithin` of equation, table, figure, algorithm, theorem in section, switched off by `oneeqnum` `onetabnum` `onefignum` `onealgnum` `onethmnum` |
| appendix | ex_article.tex:219-221, 228; siamart251216.cls:941-972 | `num.appendix` | `\appendix` swaps `\section` for `\append`/`\sappend`: "Appendix A. Title."; `\section*` gives a plain bold title |
| lists | siamart251216.cls:352-379, 716-746 | `list.kernel` | class-set margins and label forms; sample uses no list |
| footnotes | siamart251216.cls:338-339, 1126-1133 | `fn.kernel` | `\footnoterule` .5in, `\footnotesep` 6.65pt, `\@makefntext`; used only through `\thanks` |
| equations, matrices | ex_article.tex:86-148; siamart251216.cls:72 | `math.amsmath` | `equation`, `displaymath`, `subequations`, `align`, `bmatrix`, `pmatrix`; class loads `amsmath` with `leqno` |
| equation side | siamart251216.cls:72, 201 | `math.eqnumber` | `leqno` (numbers on the left) |
| math symbols, operator | ex_shared.tex:9, 45-46 | `math.amssymb` | `amsfonts`; `\DeclareMathOperator{\diag}{diag}` is amsopn/amsmath (`math.amsmath`) |
| theorem-like statements | ex_article.tex:86-124, 223-225; siamart251216.cls:1444-1507 | `thm.class-native` | built on `ntheorem` (cls:333): theorem/lemma/corollary/proposition/definition share one counter, small-caps header, italic body; proof and remark upright with italic header; proof ends with `\proofbox` (cls:1455, 1470) |
| new theorem types | ex_shared.tex:23-27 | `thm.class-native` | `\newsiamremark{remark}{Remark}`, `\newsiamremark{hypothesis}{Hypothesis}`, `\newsiamthm{claim}{Claim}`, `\newsiamremark{fact}{Fact}` |
| algorithm float | ex_article.tex:158-171; ex_shared.tex:12; siamart251216.cls:1391-1393 | `alg.algorithmicx` | `algorithm` (class) + `algorithmic` (preamble): `\STATE`, `\WHILE`, `\RETURN`; float name "Algorithm" |
| figure float | ex_article.tex:183-188; siamart251216.cls:987-1005 | `fig.graphicx` | `figure`, `\includegraphics{lexample_fig1}`, `\DeclareGraphicsExtensions{.eps,.pdf,.png,.jpg}` (ex_shared.tex:14), default placement `tp` (cls:996) |
| EPS conversion | ex_shared.tex:11; siamart251216.cls:1328 | `fig.epstopdf` | `\usepackage{epstopdf}`; EXTERNAL when selected (Ghostscript) |
| float placement | siamart251216.cls:394-403 | `fig.placement` | topnumber 2, bottomnumber 1, totalnumber 3, topfraction .9, bottomfraction .1, textfraction .1, floatpagefraction .91 |
| centring | ex_article.tex:184, 196 | `sp.ragged` | `\centering`, `center` environment |
| table | ex_article.tex:193-205; siamart251216.cls:1006-1024 | `tbl.tabular` | `table`, `tabular{\|c\|c\|c\|}`, `\hline`, `\footnotesize` (`font.size-commands`) |
| captions | ex_article.tex:159, 186, 195; siamart251216.cls:1025-1052 | `cap.kernel` | `\caption`; look is the class's `\@makecaption`: `\footnotesize`, figure label in small caps plus italic text on one centred line, table label above the text, skips 10pt |
| cross-references | ex_article.tex:71-73, 135, 149 | `xref.kernel` | `\label`, `\cref`, `\Cref` |
| smart references | siamart251216.cls:1401-1429; ex_shared.tex:20, 25, 28 | `xref.cleveref` | options `capitalize,nameinlink`; `\crefname`, `\Crefname`, `\crefformat` for equations; sample sets `\creflastconjunction` to ", and~" and `\crefname{hypothesis}`/`{fact}` |
| cross-document references | ex_article.tex:22; ex_supplement.tex:6; siamart251216.cls:1296 | `xref.xr` | `\externaldocument[][nocite]{ex_supplement}`: prefix, `nocite` option, target file |
| dummy text | ex_shared.tex:8; ex_article.tex:67 | `draft.todo` | `lipsum` with `\lipsum[2-3]` etc. (filler content) |
| review line numbers | siamart251216.cls:1602-1626 | `sp.draft-lineno` | `lineno[mathlines]`, `\linenumbers`, `\linenumberfont` footnotesize in siamreviewcolor; patched amsmath environments |
| bibliography | ex_article.tex:232-233; siamart251216.cls:1068-1105; siamplain.bst:1136 | `bib.bibtex-bst` | style `siamplain` (publisher's own `.bst`, same kit), database `references.bib`; the class's `thebibliography` is footnotesize, heading "REFERENCES", numeric labels |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class internals (`\@sect`, `\@maketitle`, `\@makecaption`, `\ps@*`, `\halign` `eqnarray`, `\appendix`, `\renewtheoremstyle`) | siamart251216.cls:648-665, 554-575, 1030-1052, 439-471, 891-906, 946-972, 1444-1451 | not counted: published | A publisher-official class is one way (`class.siamart`); the emitter writes only `\documentclass[...]{siamart251216}` and class commands. If the class were judged zip-local these would be `BESPOKE/class` (run-in `\@sect`, `\halign` eqnarray). |
| `\newcommand{\creflastconjunction}{, and~}` | ex_shared.tex:20 | yes | `xref.cleveref` string parameter |
| `\newsiamremark`, `\newsiamthm` calls | ex_shared.tex:23-27 | yes | `thm.class-native` declarations (class commands) |
| `\crefname{hypothesis}{...}{...}` | ex_shared.tex:25, 28 | yes | `xref.cleveref` names |
| `\DeclareMathOperator{\diag}{diag}` | ex_shared.tex:46 | yes | `math.amsmath` |
| `\ifpdf ... \fi` around `\hypersetup` | ex_article.tex:12-17; ex_supplement.tex:9-14 | yes | constant true under pdfTeX; emit `\hypersetup` (`meta.hyperref`) |
| `\input{ex_shared}` split | ex_article.tex:9 | yes | emitter writes one preamble |
| `\externaldocument` | ex_article.tex:22 | yes | `xref.xr` |
| FundRef comment block | ex_article.tex:24-35 | yes | comments, no effect |

## Content-opaque
none (the two `.eps` figures are content, but their conversion is the `EXTERNAL` blocker above; data.dat is unused by the sample).

## Lib changes
- New ways proposed:
  - `xref.xr` `xr-hyper` (xr bundle: `\externaldocument[prefix][nocite]{file}` makes labels of another document's `.aux` usable by `\ref` and `\cref` with hyperref links; engine pdf). W1: published, required by the class at version 6.00 (siamart251216.cls:1296), CTAN `xr` page read confirms `\externaldocument` and prefix, it did not mention the hyperref variant; W2: prefix, option and file name; W3: any multi-part document (article plus supplement); W4: one preamble line.
  - `fig.epstopdf` `epstopdf` (CTAN; converts EPS to PDF on the fly through Ghostscript so `\includegraphics` takes `.eps` under pdfTeX; engine pdf, **EXTERNAL** when selected, as `fig.svg`). W1: CTAN page read confirms the package runs the converter on the fly and needs Ghostscript; W2: options such as `outdir`, `update`, `suffix`; W3: any EPS figure; W4: one `\usepackage` line.
- considered, not proposed: `hypcap` (load-only anchor fix for floats, loaded inside the class at siamart251216.cls:1383, carried by `class.siamart`), `ifpdf` (engine test, constant under pdfTeX).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
