yes

# 0107-elsarticle: Elsevier `elsarticle` class kit (journal preprint template, author-year variant)

- Unverified: read from the source, not compiled.
- Source: Source/0107-elsarticle/ (origin: https://mirrors.ctan.org/macros/latex/contrib/elsarticle.zip; licence: lppl1.3)
- Kind: journal
- Lib: v2
- Engine: pdfLaTeX-compatible
- Look carried by: class (the template files only pick class options and fill the class's own front-matter vocabulary; no zip-local macro is loaded)
- Class origin: publisher-official
- Main file: elsarticle-template-harv.tex (other samples: elsarticle-template-num.tex, elsarticle-template-num-names.tex, the class source and ltxdoc driver elsarticle.dtx, the manual doc/elsdoc.tex)
- Read: main yes, zip-local classes and styles all

## Verdict
yes. The look is carried entirely by the published Elsevier class `elsarticle`: the main sample passes `preprint,12pt,authoryear`, loads `amssymb` and `amsmath`, and fills the class's own `frontmatter`, `abstract`, `highlights`, `keyword` vocabulary (elsarticle-template-harv.tex:20-137). The zip is Elsevier's own kit (README:1-9; the manifest origin is also a CTAN mirror), so the class source in `elsarticle.dtx` (hand-written `\@startsection` headings, `\maketitle` family, `\@makecaption`, expl3 affiliation keys) is the class way's own behaviour, not bespoke code. The zip-local documentation tooling in `doc/` (`rvdtx.sty`, `pdfwidgets.sty`, `makefile`) is irreducible and has TikZ artwork, but it is loaded only by the manual `doc/elsdoc.tex`, never by a template or by the class, so it is outside the scope the rubric sets (class, preamble and body of the sample); it is listed under Bespoke code so a stricter reading can reuse it.

## Blockers
none

Ruled out of scope, not counted as blockers (documentation build of the manual only; no template and no class code loads them):
- `BESPOKE/package` rvdtx.sty (doc/rvdtx.sty:139-201, 282-306) and pdfwidgets.sty (doc/pdfwidgets.sty:26-160), loaded at doc/elsdoc.tex:21,25 only
- `ART/package` TikZ banner and clip frames of the manual (doc/pdfwidgets.sty:168-195)
- `EXTERNAL/package` doc/makefile post-processes `elsdoc.out` with `sed` and runs `makeindex` (doc/makefile:14-29); the template needs only pdfLaTeX (plus BibTeX if the commented `\bibliography` route is used, elsarticle-template-harv.tex:257-258)

## Class setting
- Class: `class.elsarticle` options: `preprint,12pt,authoryear` (elsarticle-template-harv.tex:20); the `-num` and `-num-names` templates use `preprint,12pt` (elsarticle-template-num.tex:22, elsarticle-template-num-names.tex:20). Offered in comments: `review`, `final`, `1p`, `3p`, `5p`, `times`, `twocolumn` (elsarticle-template-harv.tex:22-32). Declared by the class: `preprint nopreprintline final review authoryear number numbers nonatbib longtitle 5p 3p 1p times endfloat endfloats numafflabel lefttitle centertitle reversenotenum doubleblind` (elsarticle.dtx:136-175); defaults `a4paper,10pt,oneside,onecolumn,number,preprint,centertitle` (elsarticle.dtx:177); every other option goes to `article` (elsarticle.dtx:178). Base class `\LoadClass{article}` (elsarticle.dtx:180), a kernel class (`class.article`), not a separate way for this zip.
- Class-native vocabulary used by the sample: `frontmatter` environment (its end calls `\maketitle`, elsarticle.dtx:1430), `\title`, `\author`, `\affiliation{organization,addressline,city,postcode,state,country}`, `\journal`, `abstract`, `graphicalabstract`, `highlights`, `keyword` with `\sep`, `\appendix` (elsarticle-template-harv.tex:50-137, 242). Documented but not exercised by the sample (comments, elsarticle-template-harv.tex:58-97 and doc/elsdoc.tex:263-289): `\tnoteref \tnotetext \fnref \fntext \corref \cortext \ead \address \PACS \MSC \JEL \newdefinition \newproof \qed \biboptions \myfooter \myfooterfont \newpageafter \abstracttitle \keywordtitle \keywordtitlesep`, and `enumerate`/`itemize` with a label template in the optional argument (elsarticle.dtx:1203-1246).
- Packages the class loads: `fontenc[T1]` always (elsarticle.dtx:112), `graphicx` always (181), `natbib` unless `nonatbib` (1340-1342); `expl3`, `xparse`, `etoolbox` when the files exist (114-120); `geometry` for `1p`/`3p`/`5p` (1358, 1380, 1402); `txfonts` or `times` for `times` (153-160); `endfloat` for `endfloat` (162-165). None needs a tool outside TeX (grep: no `write18` in elsarticle.dtx).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | elsarticle-template-harv.tex:20; elsarticle.dtx:177-180 | `class.elsarticle` | preprint, 12pt, authoryear; defaults a4paper, onecolumn, oneside, centertitle |
| page size | elsarticle-template-harv.tex:20; elsarticle.dtx:177-178 | `page.class-options` | a4paper (class default), 12pt (passed to article). Commented `1p/3p/5p` make the class call `\geometry` itself: textwidth 384/468/522pt, textheight 562/622/682pt, `centering`, `headheight=50pt`, `headsep=12pt`, `footskip=12/18/18pt`, `footnotesep=24pt plus 2pt minus 12pt` (elsarticle.dtx:1357-1417) |
| columns (commented option) | elsarticle-template-harv.tex:25-32; elsarticle.dtx:147-152, 1039-1060 | `cols.twocolumn-option` | `twocolumn`; `5p` forces two columns, `1p` forces one |
| running head and foot | elsarticle.dtx:869, 908, 1107-1135; no `\pagestyle` anywhere (grep) | `hf.class-native` | title page uses page style `pprintTitle`: empty head, foot from `\myfooter[L\|C\|R]{text}` in `\myfooterfont` (default `\footnotesize\itshape`), switched off by `nopreprintline`; sample sets none (the "Preprint submitted" line was removed, elsarticle.dtx:1122-1128); other pages keep article's default |
| line spacing (commented option) | elsarticle-template-harv.tex:22-23; elsarticle.dtx:141, 1349 | `sp.linespread` | class option `review` sets `\baselinestretch` 1.5; `preprint`/`final` 1 |
| text font (commented option) | elsarticle-template-harv.tex:27-32; elsarticle.dtx:153-160 | `font.mathptmx` | option `times`: `txfonts` (with `\ttdefault` cmtt) if installed, else `times` |
| font encoding | elsarticle.dtx:112 | `font.fontenc-t1` | `\RequirePackage[T1]{fontenc}`, unconditional |
| title block and author notes | elsarticle-template-harv.tex:54, 81, 99, 102-107, 137; elsarticle.dtx:863-893, 912-929, 1430 | `front.class-native` | title `\Large`, authors `\normalsize`, affiliations `\footnotesize\itshape`, `\hrule` above and below abstract and keywords; `\affiliation` keys (elsarticle.dtx:458-504) with separators `citysep postcodesep ...`; options `lefttitle centertitle doubleblind longtitle numafflabel reversenotenum`; `\newpageafter{title\|author\|abstract}` (857-861); `\journal{Nuclear Physics B}` (elsarticle-template-harv.tex:50; stored, not printed) |
| abstract | elsarticle-template-harv.tex:110-113; elsarticle.dtx:743-751 | `abs.class-native` | `abstract` environment boxed into `\absbox`, bold title "Abstract" (`\abstracttitle`) |
| graphical abstract and highlights | elsarticle-template-harv.tex:116-124; elsarticle.dtx:753-806, 759-771 | `abs.class-native` | environments `graphicalabstract` and `highlights`, printed on their own pages before the article by `\elsarticleprelims`; titles "Graphical Abstract" and "Highlights" in `\Large` |
| highlight items | elsarticle-template-harv.tex:122-123; elsarticle.dtx:787 | `list.kernel` | `itemize` with `\item` (the class's extended label argument is not used) |
| keywords | elsarticle-template-harv.tex:127-135; elsarticle.dtx:808-826 | `abs.keywords` | `keyword` environment, `\sep` = ", ", `\keywordtitle{Keywords}`, `\keywordtitlesep{:\ }`; italic title, ragged-right text in `\normalsize\normalfont` |
| classification codes | elsarticle-template-harv.tex:130-133; elsarticle.dtx:816-819 | `abs.classification` | `\PACS`, `\MSC[year]` (default 2000), `\JEL` inside `keyword` |
| headings | elsarticle-template-harv.tex:147, 154, 164; elsarticle.dtx:1141-1164 | `head.class-native` | section `\normalsize\bfseries\boldmath`, 18pt plus 6 minus 3 above, 9pt plus 6 minus 3 below; subsection and subsubsection `\normalsize\itshape`; paragraph run-in italic with a trailing period; number followed by "." and 0.5em; no option changes it |
| appendix | elsarticle-template-harv.tex:242-243; elsarticle.dtx:1469-1489 | `num.appendix` | `\appendix` resets section, subsection, equation; `\thesection` = "Appendix A"; figure, table, equation numbers `A.n` |
| cross-references | elsarticle-template-harv.tex:148, 151, 155 | `xref.kernel` | `\label`, `\ref` |
| math symbols and equations | elsarticle-template-harv.tex:39, 41, 170-186, 194-197 | `math.amssymb`, `math.amsmath` | `amssymb`; `amsmath` with `equation`, `equation*`, `align`, `align*` |
| kernel display maths | elsarticle-template-harv.tex:188-191, 199-202 | `math.kernel` | `eqnarray`, `eqnarray*`, `\nonumber` |
| equation alignment (commented options) | elsarticle.dtx:1395, 1417 | `math.eqnumber` | `3p`+`twocolumn` and `5p` input `fleqn.clo` (left-aligned equations) |
| theorem-like statements (not in sample) | elsarticle-template-harv.tex:43; elsarticle.dtx:1252-1336; doc/elsdoc.tex:506-512 | `thm.class-native` | kernel `\newtheorem` (bold heading, italic body, elsarticle.dtx:1291-1296), `\newdefinition` (upright body), `\newproof` (small-caps heading, no counter), `\qed` |
| amsthm and lineno (commented options) | elsarticle-template-harv.tex:43, 48, 141 | `thm.amsthm`, `sp.draft-lineno` | `\usepackage{amsthm}` overrides the class theorem macros (doc/elsdoc.tex:561-562); `\usepackage{lineno}` with `\linenumbers` |
| figure | elsarticle-template-harv.tex:229-237; elsarticle.dtx:181 | `fig.graphicx` | `figure[t]`, `\includegraphics{example-image-a}`; `graphicx` loaded by the class |
| table | elsarticle-template-harv.tex:211-223 | `tbl.tabular` | `table[t]`, `tabular{l c r}` |
| centring in floats | elsarticle-template-harv.tex:214, 232 | `sp.ragged` | `\centering` |
| captions | elsarticle-template-harv.tex:222, 235; elsarticle.dtx:1432-1441 | `cap.kernel` | `\caption{}`; the class redefines `\@makecaption`: `\footnotesize`, "label: text", centred when it fits one line, else a paragraph |
| citations | elsarticle-template-harv.tex:252; elsarticle.dtx:142-144, 1338-1347 | `bib.natbib` | class loads `natbib` with `round,authoryear` (`authoryear`) or `numbers` (default); `\biboptions{...}` adds options through `\jobname.spl`; `\citet` here, `\cite` in elsarticle-template-num.tex:254 |
| bibliography list | elsarticle-template-harv.tex:266-279 | `bib.thebibliography` | `thebibliography{00}`, `\bibitem[Lamport(1994)]{lamport94}` |
| BibTeX route (commented) | elsarticle-template-harv.tex:257-258; elsarticle-harv.bst:568-582, 1546-1579 | `bib.bibtex-bst` | `\bibliographystyle{elsarticle-harv}` (also `elsarticle-num`, `elsarticle-num-names`, elsarticle-template-num.tex:259, elsarticle-template-num-names.tex:257); each `.bst` writes `\bibitem[{label}]{key}` inside `thebibliography` |
| hyperref cooperation (not loaded by sample) | elsarticle.dtx:358-363, 1443-1467 | `meta.hyperref` | when `hyperref` is loaded the class sets link, anchor, cite, file, url, menu and page colours to blue and feeds `Hy@title` and `Hy@author` |
| secondary: class documentation driver | elsarticle.dtx:23-31; elsarticle.ins:48 | `class.ltxdoc`, `dtx.doc` | `\documentclass{ltxdoc}`, `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput{elsarticle.dtx}`, `\PrintChanges`, `\PrintIndex`; the `.ins` extracts `elsarticle.cls` with DocStrip |
| secondary: manual doc/elsdoc.tex | doc/elsdoc.tex:19-26 | `class.article` | base class only; its look comes from zip-local `rvdtx` (out of scope, see Bespoke code) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class internals: `\@startsection` headings, `\maketitle` family, `\@makecaption`, `\appendix`, extended `enumerate`/`itemize`, `\newdefinition`/`\newproof`, expl3 `\affiliation` keys | elsarticle.dtx:89-1528 | not bespoke | published class (Elsevier's own release, also on CTAN): `class.elsarticle`; the emitter writes `\documentclass[...]{elsarticle}` and the vocabulary above, never the internals |
| sample preamble and body macros | elsarticle-template-harv.tex:20-282 | none exist | only `\usepackage`, class commands and kernel environments |
| side file `\jobname.spl` | elsarticle.dtx:1339-1347 | not bespoke | TeX `\openout`/`\InputIfFileExists` inside the class; `\biboptions` takes effect from the second run; no external tool |
| `.bst` styles (3) | elsarticle-harv.bst, elsarticle-num.bst, elsarticle-num-names.bst | not bespoke | Elsevier's published BibTeX styles = `bib.bibtex-bst` (read by outline, `output.bibitem` and `begin.bib` only) |
| `rvdtx.sty` | doc/rvdtx.sty:139-201 (shipout hook, picture overlay), 282-306 (`\maketitle`), 403-415 (index) | no (out of scope) | loaded only at doc/elsdoc.tex:21; irreducible if the manual were in scope |
| `pdfwidgets.sty` | doc/pdfwidgets.sty:26-160 (`\pgfdeclareshape`), 168-195 (clip frames), 309-328 (`vquote` writes `tmp.tex`), 350-357 (`toolwrite` with `\immediate\write18`, never called: grep) | no (out of scope) | loaded at doc/rvdtx.sty:125 and doc/elsdoc.tex:25 only |
| `doc/makefile` | doc/makefile:14-29 | no (out of scope) | `sed`, `makeindex`; builds the manual only |

## Content-opaque
none (the figure's `example-image-a` is a TeX Live test image, not shipped in the zip: a missing asset, elsarticle-template-harv.tex:233)

## Lib changes
- New ways proposed: none. Considered and not claimed: `endfloat` (class option, elsarticle.dtx:162-165), which the sample does not select.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
