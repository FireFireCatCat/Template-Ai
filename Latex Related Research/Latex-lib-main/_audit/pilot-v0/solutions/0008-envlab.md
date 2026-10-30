yes

# 0008-envlab: EnvLab, envelopes and mailing labels for the letter class (v1.2, 1997)

- Unverified: read from the source, not compiled.
- Source: Source/0008-envlab/ (origin: https://mirrors.ctan.org/macros/latex/contrib/envlab.zip; licence: lppl)
- Kind: letter (a package for letter-class envelopes and labels; the sample is the package's user guide)
- Lib: v0
- Engine: pdfLaTeX-compatible (the sample and the package load with pdfTeX-safe code; see Verdict for the dvips-oriented page model, not verified)
- Main file: elguide.tex (other samples: envlab.dtx documentation driver at envlab.dtx:41-99, class ltxdoc; the five `letter` + `envlab` usage listings inside verbatim at elguide.tex:159-176, 196-217, 243-257, 280-290, 766-780, 822-841)
- Read: main yes, zip-local classes and styles all (no standalone .cls/.sty: `envlab.sty`, `envlab.cfg`, `envlab.drv` exist only inside `envlab.dtx`, read whole, 1-1759, plus `envlab.ins`, `elold.ins`, `README`). Not in the zip and so not read: `ltxguide`, `ltxdoc`, `shortvrb`, `enumerate`, `graphics`, `letter`.

## Verdict
yes, with one judgement call. The zip is the CTAN distribution of the published package `envlab`; the sample (`elguide.tex`) is an ordinary kernel-LaTeX user guide on the published class `ltxguide`, and everything it defines locally is a text alias or a minipage wrapper. The package's own typesetting logic (token-scanning barcode and capitalisation code, `.aux` games, a rewritten `\opening`, dtx:782-1725) is not copied by an emitter: it writes `\usepackage[options]{envlab}` and `\makelabels`, so the package is one new way, `NEW:ltr.envlab`, that passes W1 to W4. The judgement call: if the project decided that a package which is itself the zip under analysis cannot count as a published way, this would flip to `no` with `BESPOKE` on dtx:1115-1220 (barcode scanner), dtx:1330-1399 (address capitaliser) and dtx:782-867 (page set-up). Second risk: `ltxguide.cls` is not in the zip and no TeX install was available, so that `decl`, `\NEWfeature` and `\NEWdescription` come from it is inferred (elguide.tex defines none of them: grep of 7-27) and that `ltxguide` and `ltxdoc` are in the LaTeX base is background knowledge; the one CTAN page read for it (latex-base) did not list them and ctan.org/pkg/ltxguide returned 404.

## Blockers
none

## Class setting
- Class: `NEW:class.ltxguide` options: none (elguide.tex:1)
- Class-native vocabulary used: `decl` environment (about 40 uses, first at elguide.tex:140), `\NEWfeature{Version x}` and `\NEWdescription{Version x}` (first at elguide.tex:301-302, 483), `\maketitle` look, `abstract`; `\cs`, `\marg`, `\oarg`, `\parg` are `\providecommand`ed (elguide.tex:14, 17-22) so the class may define them.
- Other sample: `NEW:class.ltxdoc` options: none (envlab.dtx:41); vocabulary `macrocode`, `macro`, `\DescribeMacro`, `\changes`, `\CheckSum`, `\StopEventually`, `\Finale`, `\GetFileInfo`, `\DoNotIndex`, `\CodelineIndex`, `\RecordChanges`, `\EnableCrossrefs`, `\PrintChanges`, `\PrintIndex` (envlab.dtx:42-96, 115, 140, 1732, 1752, 1756).
- Usage listings (inside verbatim): `class.letter` option 12pt (elguide.tex:160, 197, 244, 281, 767, 823).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (main) | elguide.tex:1 | `NEW:class.ltxguide` | no options; page geometry, running heads, heading look all left to the class |
| short verbatim | elguide.tex:5, 15 | `code.verbatim` | `shortvrb` `\MakeShortVerb{\|}`, so `\|...\|` means `\verb`; used all through the text (e.g. 55-56) |
| name aliases | elguide.tex:7-13 | `mark.kernel` | `\textsl{...}` for EnvLab, dvips, PostScript, DocStrip, mailing, graphics, ghostscript |
| syntax-marker macros | elguide.tex:14, 16-22 | `mark.kernel` | `{\ttfamily ...}` and `\em` italics, bracket and brace glyphs, `\star` as a tt asterisk |
| figure box | elguide.tex:24-25 | `box.minipage` | `figpage` = `minipage` of width 0.8\textwidth |
| title block | elguide.tex:31-36 | `front.maketitle` | `\title` with `\\` break, `\author`, literal `\date`, class look from ltxguide |
| title note | elguide.tex:32 | `front.thanks` | `\thanks{\copyright ...}` |
| abstract | elguide.tex:38-43 | `abs.kernel` | `abstract` env (look from the class; not read) |
| contents lists | elguide.tex:45-47 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables` |
| headings | elguide.tex:52-1039 | `head.class-native` | `\section`, `\subsection`, `\subsubsection` (e.g. 52, 118, 139), default numbering |
| lists | elguide.tex:59, 89, 98, 639, 676 | `list.kernel` | `itemize`, `enumerate`, default labels |
| declaration blocks | elguide.tex:140, 227, 267, ... | `NEW:class.ltxguide` | `decl` env around command syntax (class-native, see Class setting) |
| version flags | elguide.tex:301-1031 | `NEW:class.ltxguide` | `\NEWfeature{...}`, `\NEWdescription{...}` (class-native) |
| figures | elguide.tex:155, 192, 239, 276, 394, 763, 819 | `fig.graphicx` | `figure[tbp]` + `center` + `\leavevmode`; the float only, no `\includegraphics` is loaded or used |
| figure captions | elguide.tex:187, 217, 260, 293, 436, 787, 846 | `cap.kernel` | `\caption{...}`; short form `\caption[short]{long}` at 217; caption below, kernel default |
| listings in figures | elguide.tex:159, 196, 243, 280, 766, 822 | `code.verbatim` | `verbatim` inside `figpage` |
| code blocks in text | elguide.tex:958, 977, 991 | `code.verbatim` | `verbatim` (PostScript and `\AtBeginLabels` snippets) |
| tables | elguide.tex:312, 345, 441, 491 | `tbl.tabular` | `table[tbp]` + `center` + `tabular` (`cccc`, `ccc`, nine `c`), `\hline` rules, no booktabs |
| table captions | elguide.tex:324, 362, 464, 504 | `cap.kernel` | `\caption{...}` below the table |
| quotes | elguide.tex:651, 755 | `quote.kernel` | `quote` |
| footnotes | elguide.tex:57, 99, 106, 128, 234, 372, 632, 694, 803, 907 | `fn.kernel` | `\footnote` |
| references | elguide.tex:615, 633 (`\cite`), many `\label` and `\ref` | `xref.kernel` | `\label`, `\ref`, `\cite{Pub25}` |
| bibliography | elguide.tex:1076-1082 | `bib.thebibliography` | `thebibliography{1}`, one `\bibitem`, `\newblock` |
| bibliography toc entry | elguide.tex:1077 | `toc.kernel` | `\addcontentsline{toc}{section}{\protect\refname}` |
| centring and gaps | elguide.tex:156, 193, 313, 1072 | `sp.ragged` | `center` environment; `\bigskip` before the bibliography (kernel skip) |
| mixed type | elguide.tex:673 | `font.size-commands` | `\textsf{\large 12pt sans serif}` |
| usage listing: class | elguide.tex:160 | `class.letter` | 12pt (inside verbatim, code text) |
| usage listing: letter parts | elguide.tex:164-176, 767-780 | `ltr.opening` | `\address`, `\signature`, `letter` env, `\opening`, `\closing` (inside verbatim) |
| usage listing: labels and envelopes | elguide.tex:162, 199, 246, 283, 825 | `NEW:ltr.envlab` | `\usepackage[personalenvelope]{envlab}`, `[avery5061label,alwaysbarcodes]`, `[businessenvelope]`, `[avery5160label,noprintbarcodes,nocapaddress]`, `[avery5160label,re]`; `\makelabels` in the preamble (inside verbatim) |
| envelope sizes | envlab.dtx:446-457 | `NEW:ltr.envlab` | options `businessenvelope` 9.5in x 4.125in (default), `executiveenvelope`, `bookletenvelope`, `personalenvelope`, `c6envelope`, `c65envelope`, `c5envelope`, `dlenvelope` |
| label sheets | envlab.dtx:470-488 | `NEW:ltr.envlab` | `avery5160label` ... `avery5164label`, `herma4625label`, `avery5262label`, `avery5163biglabel`, `avery5164biglabel`; each fixes W, H, t, l, r, Nc, Nr |
| custom media | envlab.dtx:372-384, 393-407, 416-434 | `NEW:ltr.envlab` | `\SetEnvelope[top]{w}{h}`, `\SetLabel{W}{H}{t}{l}{r}{Nc}{Nr}`, `\SetBigLabel{...}`; later changes `\ChangeEnvelope`, `\ChangeLabel`, `\ChangeBigLabel` (dtx:1517-1598) |
| output switches | envlab.dtx:503-522, 540-542 | `NEW:ltr.envlab` | `rotateenvelopes`, `centerenvelopes`/`leftenvelopes`/`rightenvelopes`/`customenvelopes` (+ `\EnvelopeLeftMargin`), `printbarcodes`, `alwaysbarcodes`, `capaddress`, `printreturnaddress`, `pswait`, `psautotray`, `re`; defaults at 540-542 |
| label control commands | envlab.dtx:731-733, 1035-1042, 1435-1499; elguide.tex:712-750 | `NEW:ltr.envlab` | `\FirstLabel{row}{col}`, `\printreturnlabels{n}{text}`, `\suppresslabels`, `\resumelabels`, `\suppressonelabel`, `\printonelabel`, `\re{...}` |
| rotation dependency | envlab.dtx:530, 587-593, 959 | `fig.rotating` | `graphics` loaded by the package, `\rotatebox{90}`; unknown options are passed to `graphics`; not emitted separately |
| site config | envlab.dtx:570-580 (`envlab.cfg`) | `NEW:ltr.envlab` | `\ExecuteOptions{...}` + `\AtEndOfPackage{}`; a convenience file, not template look |
| class (doc driver) | envlab.dtx:41 | `NEW:class.ltxdoc` | no options |
| enumerated states | envlab.dtx:93, 1095 | `NEW:list.enumerate-pkg` | `\usepackage{enumerate}`; `\begin{enumerate}[{State} A:]` |
| index and change history | envlab.dtx:94-96, 1752, 1756 | `idx.makeidx` | `\CodelineIndex`, `\RecordChanges`, `\EnableCrossrefs`, `\PrintChanges`, `\PrintIndex` (ltxdoc/doc vocabulary; needs the `makeindex` pass, the same kind of standard TeX-distribution processor as BibTeX; not counted as EXTERNAL) |
| doc title block | envlab.dtx:115-125 | `front.maketitle` | `\GetFileInfo`, `\title` with two `\thanks`, `\author`, `\date{\filedate}` |
| doc title notes | envlab.dtx:118-121 | `front.thanks` | two `\thanks` |
| doc contents | envlab.dtx:127 | `toc.kernel` | `\tableofcontents` |
| doc headings | envlab.dtx:130, 142, 173 | `head.class-native` | `\section`, `\subsection` |
| doc short verbatim | envlab.dtx:131 | `code.verbatim` | `\MakeShortVerb{\"}`; plain `verbatim` at 633-637, 1620-1637 |
| doc code listing | envlab.dtx:145-1729 | `NEW:class.ltxdoc` | `macrocode` and `macro` environments (code text is content) |
| doc table | envlab.dtx:185-199 | `tbl.tabular` | `table` + `center` + `tabular{cccc}`, `\hline`, `cap.kernel` caption after |
| doc lists and quotes | envlab.dtx:654-668, 1066-1070, 1296-1302 | `list.kernel` | `itemize`, `quotation` (`quote.kernel` at 654, 1674) |
| doc footnote | envlab.dtx:134 | `fn.kernel` | `\footnote` |
| doc bibliography | envlab.dtx:1735-1748 | `bib.thebibliography` | `thebibliography{1}`, three `\bibitem`, `\addcontentsline` |
| doc page breaks | envlab.dtx:1734, 1750, 1754 | `pg.break` | `\clearpage` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\EL`, `\dvips`, `\PS`, `\DS`, `\mailing`, `\graphics`, `\gs` | elguide.tex:7-13 | yes | `\newcommand` aliases of `\textsl{...}` (`mark.kernel`) |
| `\cs`, `\marg`, `\oarg`, `\parg`, `\star` | elguide.tex:14, 16-22 | yes | text macros that set tt glyphs and italic argument: `mark.kernel` |
| `\meta` | elguide.tex:27 | yes | `$\langle$` + italic + `$\rangle$`; defined, never used in the body (grep) |
| `figpage` | elguide.tex:24-25 | yes | `minipage` 0.8\textwidth: `box.minipage` |
| `\SetFigFont` conditional `\gdef` | elguide.tex:397-403 | n/a | xfig export inside the figure float: Content-opaque |
| `\EL` | envlab.dtx:112 | yes | alias, as above |
| doc-driver `\DoNotIndex` lists | envlab.dtx:42-91 | yes | ltxdoc declarations: `NEW:class.ltxdoc` parameters |
| `envlab.sty` code | envlab.dtx:146-1729 | published, not bespoke | the CTAN package `envlab` itself: `NEW:ltr.envlab`. Inside it: options and `\Set*` (372-522), `\startlabels` page re-set-up with 200in logical paper (782-867), address and barcode printers (877-1042), Postnet scanner with `\futurelet` loops (1057-1282), capitaliser (1314-1399), `.aux` writes (1422-1608), `\opening` rewrite under `re` (1644-1725). All of it stays inside the package; an emitter loads the package and never prints this code |
| `envlab.ins`, `elold.ins` | envlab.ins:1-25, elold.ins:1-27 | n/a | DocStrip generators of `envlab.sty`, `.cfg`, `.drv`; a TeX run, not EXTERNAL, and not needed once the published `envlab.sty` is used |

## Content-opaque
- `picture` drawing of the label parameters W, H, t, l, r inside a figure float (elguide.tex:395-435), `art.pstricks` as content, from an xfig export.
- Inline kernel math in prose and table cells (`$9.5''\times4.125''$`, `$W$`, `$N_c$`, `$90^\circ$`; e.g. elguide.tex:342, 375, 444-502, 566, 1004).
- Letter source, PostScript `\special` and `\AtBeginLabels` snippets inside `verbatim` (elguide.tex:159-290, 766-841, 958-991): code text.
- Files named only in listings and never shipped: `lovers.dat`, `mylogo.eps` (elguide.tex:207, 218, 869-873). No image is needed by the sample.
- The whole `macrocode` source in the dtx documentation (envlab.dtx:145-1729): code text.

## Lib changes
- New ways proposed:
  - `NEW:ltr.envlab`: package `envlab` (CTAN, LPPL), pdf with dvips-oriented extras. W1: on CTAN, in TeX Live and MiKTeX, with a user guide. W2: media and behaviour chosen by package options and by `\SetEnvelope`, `\SetLabel`, `\SetBigLabel` lengths and counts; `\returnaddress` is content. W3: serves one component, mailing envelopes and label sheets for any `letter`-compatible class (the lib's `ltr.opening` covers the letter itself, not label sheets). W4: preamble `\usepackage[opts]{envlab}\makelabels`; body is the kernel `letter` environment, or `\startlabels` with `\mlabel{from}{to}`, or `\printreturnlabels{n}{text}`. Caveat: its page model uses a 200in logical paper, dvips `\special`s and `graphics` rotation, so placement under pdfTeX output is not checked here.
  - `NEW:class.ltxguide`: class `ltxguide`, pdf. W1: LaTeX base documentation class (background knowledge, not confirmed here). W2: article-like class with the `decl` environment and version-flag macros. W3: generic documentation class, as each `class.<name>`. W4: `\documentclass{ltxguide}` plus its vocabulary.
  - `NEW:class.ltxdoc`: class `ltxdoc`, pdf. W1: LaTeX base documentation class for `.dtx` drivers (background knowledge, not confirmed here). W2: options and `\DoNotIndex`, `\CodelineIndex`, `\RecordChanges` style declarations. W3: serves literate package documentation. W4: `\documentclass{ltxdoc}` plus `\DocInput{file.dtx}`.
  - `NEW:list.enumerate-pkg`: package `enumerate` (tools bundle), pdf. W1: on CTAN. W2: the label template in the optional argument (`[{State} A:]`). W3: any enumerated list. W4: `\usepackage{enumerate}` and `\begin{enumerate}[template]`. The lib's `list.enumitem` is a different package (`enumitem` keys), so it is not a home.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
