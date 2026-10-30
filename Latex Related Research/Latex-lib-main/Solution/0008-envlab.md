yes

# 0008-envlab: EnvLab, envelopes and labels package (v1.2, 1997) with its User Guide

- Unverified: read from the source, not compiled.
- Source: Source/0008-envlab/ (origin: https://mirrors.ctan.org/macros/latex/contrib/envlab.zip; licence: lppl per manifest hint; elguide.tex:1067 says "same license as the current LaTeX2e package"; ctan.org/pkg/envlab read once: CTAN package, LPPL, in TeX Live)
- Kind: letter
- Lib: v1
- Engine: pdfLaTeX-compatible (both documents). The package envlab.sty itself is dvips-oriented: `\special{ps:...}` only under options `pswait`/`psautotray` (envlab.dtx:651, 677), page model `\vsize=200in` (envlab.dtx:795); pdfTeX output of envelopes unverified, as the lib already notes for `ltr.envlab`
- Look carried by: mixed (class `ltxguide` gives page, title, headings, `decl`; elguide.tex preamble adds `shortvrb` plus alias macros; the package is a published CTAN release with no zip-local class or style)
- Class origin: tex-distribution-unbundled (`ltxguide` for elguide.tex:1, `ltxdoc` for envlab.dtx:41; neither ships in the zip; the package envlab is `ctan`)
- Main file: elguide.tex (other samples: envlab.dtx documentation driver, envlab.dtx:38-101; envlab.sty, envlab.cfg and envlab.drv exist only as DocStrip targets of envlab.dtx; the letter examples inside elguide.tex are verbatim text, not samples)
- Read: main yes, zip-local classes and styles none present (no .cls/.sty in the zip; read the whole of envlab.dtx instead, all 1759 lines, README, both .ins files)

## Verdict
yes. The zip is the CTAN source of the `envlab` package plus two documents. The guide is `ltxguide` with `shortvrb` and ten trivially reducible alias macros; the dtx driver is `ltxdoc` with `enumerate`; the package itself is a published CTAN release and already a lib way (`ltr.envlab`), so its token-scanning internals (zip-code scanner, address capitalizer, barcode rules, `\startlabels` page model) are not zip-local code an emitter would copy. This verdict rests on counting the CTAN package as published (W1); if the package's own internals had to be rebuilt from other ways it would be `no` (BESPOKE/package at envlab.dtx:1115-1201, 1322-1398, 782-867). No ART: the one picture is figure content.

## Blockers
none

## Class setting
- Class: `class.ltxguide` options: none (elguide.tex:1). Second sample: `class.ltxdoc` options: none (envlab.dtx:41). Neither class source read (distribution classes).
- Class-native vocabulary used (ltxguide): `decl` environment (elguide.tex:140, 227, 267, 330, 367, 378, 469, 479, 509, 528, 561, 578, 595, 627, 646, 670, 701, 714, 731, 791, 810, 861, 882, 888, 899, 928, 941, 951), `\NEWfeature{Version 1.2}` and `\NEWdescription{Version 1.2}` (elguide.tex:301, 483, 513, 540, 545, 598, 704, 718, 734, 753, 813, 874, 891, 931, 944, 954, 974, 988, 1001, 1016, 1031), `\title` `\author` `\date` `\maketitle` `abstract` (elguide.tex:31-43).
- Class-native vocabulary used (ltxdoc): `\DoNotIndex` (envlab.dtx:42-91), `\CodelineIndex` `\RecordChanges` `\EnableCrossrefs` (94-96), `\DocInput` (98), `\CheckSum` (18), `\GetFileInfo` `\fileversion` `\filedate` (115, 119, 124), `\changes` (104-110 and about 50 more), `macro` environment and `\DescribeMacro` (150, 178), `macrocode` environment, `\StopEventually` (140), `\Finale` (1732), `\PrintChanges` (1752), `\PrintIndex` (1756), `\MakeShortVerb{\"}` (131).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (guide) | elguide.tex:1 | `class.ltxguide` | no options |
| class (dtx driver) | envlab.dtx:41 | `class.ltxdoc` | no options |
| page size and margins | elguide.tex:1 (no geometry call anywhere) | `page.class-options` | class defaults only, nothing set in the zip |
| header/footer | elguide.tex:1 (no pagestyle, no fancyhdr) | `hf.class-native` | ltxguide running heads, default |
| short verbatim | elguide.tex:5, 15; envlab.dtx:131 | `code.verbatim` | `shortvrb` `\MakeShortVerb{\|}` (guide), `\MakeShortVerb{\"}` (dtx) |
| code blocks | elguide.tex:159-185, 196-215, 243-258, 280-291, 766-785, 822-844, 958-964, 977-986, 991-994 | `code.verbatim` | `verbatim` environment (inside `figpage` minipages for the first six) |
| doc code listing | envlab.dtx `macrocode` blocks (e.g. 145-148, 157-169, 1702-1718) | `code.verbatim` | ltxdoc `macrocode`/`macro` environments, class-native; the code text is content |
| title block | elguide.tex:31-36; envlab.dtx:117-125 | `front.maketitle` | `\title` with `\\` and `\thanks`, `\author`, `\date` (guide: fixed text; dtx: `\filedate`) |
| author note | elguide.tex:32; envlab.dtx:118-121 | `front.thanks` | `\thanks{\copyright ...}` |
| abstract | elguide.tex:38-43 | `abs.kernel` | `abstract` environment, ltxguide look |
| contents and lists | elguide.tex:45-47; envlab.dtx:127 | `toc.kernel` | `\tableofcontents` `\listoffigures` `\listoftables` (guide), `\tableofcontents` (dtx); `\addcontentsline{toc}{section}{\protect\refname}` at elguide.tex:1077, envlab.dtx:1735, 1751, 1755 |
| headings | elguide.tex:52, 85, 114, 118, 139, 299, 519, 608, 698, 712, 751 | `head.class-native` | `\section` `\subsection` `\subsubsection` with ltxguide's look; no titlesec or renewcommand; dtx uses `\section` and `\subsection` the same way with ltxdoc's look |
| lists | elguide.tex:59-73, 89-111, 639-643, 676-680; envlab.dtx:1066-1070, 1296-1302 | `list.kernel` | `itemize` and `enumerate`, default labels, nested |
| lettered list labels | envlab.dtx:93, 1095 | `list.enumerate-pkg` | `\usepackage{enumerate}`, label template `[{State} A:]` |
| quotes | elguide.tex:651-656, 755-757; envlab.dtx:1616-1618, 655-668, 1674-1699 | `quote.kernel` | `quote` and `quotation` |
| text marks | elguide.tex:673, 937; throughout `\emph`, `\textsl`, `\texttt` | `mark.kernel` | `\emph`, `\textsl`, `\texttt`, `\textsf` (the `\large` at 673 is `font.size-commands`) |
| size switch | elguide.tex:673 | `font.size-commands` | `\textsf{\large ...}` |
| footnotes | elguide.tex:57, 99, 106, 128, 234, 372, 632, 694, 803, 907; envlab.dtx:134 | `fn.kernel` | `\footnote`, plain text notes |
| inline maths | elguide.tex:342, 375, 388-392, 446, 566, 1004 | `math.kernel` | inline `$...$` only (primes, `\times`, subscripts, `^\circ`); no display maths, content |
| floats (figure) | elguide.tex:155, 192, 239, 276, 394, 763, 819 | `fig.graphicx` | `figure[tbp]` float with `center` and `figpage` minipage; no `\includegraphics` in the guide itself |
| floats (table) | elguide.tex:312-327, 345-365, 441-467, 491-507; envlab.dtx:185-199 | `tbl.tabular` | `table[tbp]`, `tabular{cccc}`/`{ccc}`/`{ccccccccc}`, `\hline` only (no booktabs) |
| captions | elguide.tex:187, 217-220, 260, 293, 324, 362, 436, 464, 504, 787, 846; envlab.dtx:197 | `cap.kernel` | `\caption{...}` and `\caption[short]{long}` (217) |
| minipage wrapper | elguide.tex:24-25, 158, 195, 242, 279, 765, 821 | `box.minipage` | `figpage` = `minipage` of width `0.8\textwidth` |
| alignment and spacing | elguide.tex:156-157, 1072; throughout `\\`, `\\*` | `sp.ragged` | `center` environment, `\leavevmode` |
| manual spacing | elguide.tex:1072; envlab.dtx:1624, 1625 | `sp.manual-space` | `\bigskip`, `\\[1ex]` |
| bibliography | elguide.tex:615, 633, 1076-1081; envlab.dtx:1051, 1673, 1736-1748 | `bib.thebibliography` | hand-written `thebibliography{1}`, `\bibitem`, `\newblock`, `\cite` |
| cross-references | elguide.tex:53, 86, 104, 147, 153, 188, ... (22 `\label`/`\ref`/`\cite` lines) | `xref.kernel` | `\label`, `\ref` |
| page breaks | envlab.dtx:1734, 1750, 1754 | `pg.break` | `\clearpage` |
| index and change history | envlab.dtx:94-96, 1752, 1756 | `idx.makeidx` | closest way: `theindex` with a makeindex pass (`gind.ist`, `gglo.ist`); driven by ltxdoc's `\PrintIndex`/`\PrintChanges`, class-native; makeindex has the same status as bibtex in the lib |
| letters, envelopes, labels (the package) | envlab.dtx:146-1729 (`<*package>`), README:12-31, elguide.tex:137-856 | `ltr.envlab` | options: size `businessenvelope` `executiveenvelope` `bookletenvelope` `personalenvelope` `c6envelope` `c65envelope` `c5envelope` `dlenvelope` (446-457), `avery5160label` `avery5161label` `avery5162label` `avery5163label` `avery5164label` `herma4625label` `avery5262label` (470-483), `avery5163biglabel` `avery5164biglabel` (484-488); switches `rotateenvelopes` `centerenvelopes` `leftenvelopes` `rightenvelopes` `customenvelopes` `printbarcodes` `alwaysbarcodes` `capaddress` `printreturnaddress` `pswait` `psautotray` `re` and their `no` forms (503-522); defaults at 540-542; unknown options go to `graphics` (530). Commands: `\makelabels`, `\SetEnvelope[top]{w}{h}` (372), `\SetLabel` (393) and `\SetBigLabel` (416) with `{W}{H}{t}{l}{r}{Nc}{Nr}`, `\FirstLabel` (731), `\ChangeEnvelope`/`\ChangeLabel`/`\ChangeBigLabel` (1517-1608), `\suppresslabels` `\resumelabels` `\suppressonelabel` `\printonelabel` (1435-1499), `\printreturnlabels` (1035), `\AtBeginLabels` `\AtBeginLabelPage` (640-641), `\re` `\ReName` (1654-1664), lengths `\EnvelopeLeftMargin` etc. (305-361), `\returnaddress` (765) |
| package site config | envlab.dtx:570-580 (`cfg` target), envlab.ins:6-21 | `ltr.envlab` | `\ExecuteOptions{businessenvelope,rotateenvelopes,centerenvelopes}` `{printbarcodes,capaddress}` `{nopswait,printreturnaddress,nopsautotray,nore}` and an empty `\AtEndOfPackage{\relax}`; options only |
| letter commands shown in examples | elguide.tex:160-183, 197-214, 244-257, 281-290, 767-784, 823-843 | `ltr.opening` | `\address`, `\signature`, `letter` environment, `\opening`, `\closing`; verbatim text under `class.letter` (`[12pt]`), content here, listed so nothing is hidden |

No rows for colour, background, fonts, language, geometry, theorems, code styling, index of the guide: none in the zip (no `\usepackage` other than `shortvrb` in elguide.tex, only `enumerate` in the dtx driver).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\EL` `\dvips` `\PS` `\DS` `\mailing` `\graphics` `\gs` | elguide.tex:7-13; `\EL` also envlab.dtx:112 | yes | `\newcommand` aliases for `\textsl{...}`: `mark.kernel` |
| `\cs` `\star` `\marg` `\oarg` `\parg` | elguide.tex:14, 16-22 | yes | aliases of `\ttfamily`, `\char`, `\em` around the argument; `\providecommand` for `\cs`, `\marg`, `\oarg`, `\parg`, so a definition already in the class would win; `mark.kernel` |
| `\meta` | elguide.tex:27 | yes | `$\langle$...$\rangle$` around `\em` text; `mark.kernel` and `math.kernel` |
| `figpage` environment | elguide.tex:24-25 | yes | `minipage` of `0.8\textwidth`: `box.minipage` |
| `\SetFigFont` helper | elguide.tex:399-404 | yes | xfig export macro (`\fontsize`, `\fontfamily`, `\selectfont`); inside the figure's picture, so content-opaque |
| `\DoNotIndex` lists | envlab.dtx:42-91 | yes | declarative list of macro names for ltxdoc's index; class vocabulary |
| envlab.sty internals (switches, counters, `\startlabels`, zip-code and capitalizer scanners, barcode `\rule` bars, `\opening` redefinition, `.aux` writes) | envlab.dtx:146-1729 | not applicable: published | CTAN `envlab` v1.2 (ctan.org/pkg/envlab); the emitter writes `\usepackage[options]{envlab}` and `\makelabels`, not this code: `ltr.envlab` |
| DocStrip batch files | envlab.ins:1-21, elold.ins:1-27 | yes, nothing to emit | published `docstrip.tex` (TeX run, no outside tool); they produce envlab.sty, envlab.cfg, envlab.drv and typeset nothing; installation infrastructure, outside every lib component |
| DocStrip guards and `\iffalse` blocks | envlab.dtx:1-35, 100-102 | yes | comment-level `%<*driver>` markup read by docstrip, never typeset |

## Content-opaque
- picture environment with `\framebox`, `\vector`, `\put` in the figure "Labels parameters" at elguide.tex:397-435 (`art.pstricks`; figure content, caption at 436).
- letter and mailing-merge examples as verbatim text (elguide.tex:159-215, 243-291, 766-844) and PostScript printer code (958-994); the `mailing` package example (206-210) names `lovers.dat` and `mylogo.eps`, which the zip does not ship; neither is loaded by any compiled sample.
- the typeset package code in `macrocode` blocks (envlab.dtx:145-1724), shown as documentation text.
- prebuilt elguide.pdf and envlab.pdf (outputs, not read).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
