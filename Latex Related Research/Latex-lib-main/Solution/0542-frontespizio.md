yes

# 0542-frontespizio: frontespizio (Italian thesis frontispiece package, v1.4a)

- Unverified: read from the source, not compiled.
- Source: Source/0542-frontespizio/ (origin: https://mirrors.ctan.org/macros/latex/contrib/frontespizio.zip; licence: LPPL 1.3, README:35-41, ctan.org/pkg/frontespizio)
- Kind: thesis
- Lib: v4
- Engine: pdfLaTeX-compatible (needs e-TeX, frontespizio.dtx:1172-1185; also XeLaTeX, or latex plus dvips for an EPS frontispiece, frontespizio.dtx:2074-2082; the sample build uses pdflatex, frontespizio.dtx:1132-1149)
- Look carried by: mixed (the manual's look is the published class `ltxdoc` plus the driver preamble, frontespizio.dtx:28-72; the frontispiece look is the published package `frontespizio`, whose source is this zip's own .dtx, frontespizio.dtx:1172-2164)
- Class origin: tex-distribution-unbundled
- Main file: frontespizio.dtx (documentation driver with `\documentclass` at :30 and `\begin{document}` at :69; other samples: examplea to examplee, five example documents embedded in the .dtx at :933-948, :964-982, :998-1020, :1035-1055, :1086-1107 and extracted by frontespizio.ins:45-51)
- Read: main yes, zip-local classes and styles none present (no .cls or .sty file in the zip; the package code inside the .dtx, frontespizio.dtx:1172-2171, was read in full; README and frontespizio.ins read; frontespizio.pdf is compiled output and was not read)

## Verdict
The zip is a CTAN package distribution, not a class: its look is the `frontespizio` package, published on CTAN (v1.4a, LPPL 1.3, TeX Live and MiKTeX, read at ctan.org/pkg/frontespizio), so I propose it as one new way `front.frontespizio` that an emitter writes as `\usepackage[options]{frontespizio}` plus one body environment of string fields, lengths and font hooks. The manual around it is `class.ltxdoc` with `dtx.doc`, and the eight driver macros are aliases or static expansions that reduce by inline expansion; the example logo drawing is content, so there is no ART and no irreducible code.
- Considered, not charged: the frontispiece page is a second document, `\jobname-frn.tex`, which the package writes itself (frontespizio.dtx:1360) and which needs a separate engine run before the main file is rerun (frontespizio.dtx:2105-2118, README:68-74). I did not call this EXTERNAL because it is the same TeX engine on a file the package writes, with no shell escape and no non-TeX program, as `xref.xr` needs another document built first. A reviewer who counts a separate engine job as EXTERNAL would tag it EXTERNAL/package and flip the verdict to no. Without that second job the main run still ends, with a package warning and an empty frontispiece page (frontespizio.dtx:2143-2145).

## Blockers
none

## Class setting
- Class: `class.ltxdoc` (the manual, frontespizio.dtx:30) options: none of its own; `a4paper` is handed to article by `\PassOptionsToClass{a4paper}{article}` (frontespizio.dtx:29). The example documents use `class.book` with `a4paper,titlepage` (frontespizio.dtx:933), and the generated frn document uses `class.article` with `titlepage` (frontespizio.dtx:1385).
- Class-native vocabulary used (ltxdoc and its `doc` package; class source not in the zip, not read): `\DocInput` (:70), `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges` (:66-68), `\CheckSum` (:75), `\CharacterTable` (:77-91), `\changes` (:93-99), `\GetFileInfo` with `\fileversion` `\filedate` (:100, :142-146), `\DoNotIndex` (:102-124), `\cs` (:41), `\marg` (:407), `\oarg` (:425), `\meta` (:599), bar-delimited short verbatim (:255), `macro` / `environment` / `macrocode` environments (:1199-2169), `\StopEventually{\PrintChanges\PrintIndex}` (:1156), `\Finale` (:2171).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class, manual | frontespizio.dtx:29-30 | `class.ltxdoc` | `\documentclass{ltxdoc}`; no class options |
| paper size | frontespizio.dtx:29 | `page.class-options` | `a4paper` passed to article |
| document class, examples | frontespizio.dtx:933, :964, :998, :1035, :1086 | `class.book` | `a4paper,titlepage` |
| document class, generated frn document | frontespizio.dtx:1385 | `class.article` | `titlepage` |
| encoding | frontespizio.dtx:31 | `font.fontenc-t1` | `[T1]`; no inputenc in the driver; the file holds 8-bit bytes (:230, :749-764); the package copies the host's inputenc option into the frn file (:1386-1390) |
| microtype | frontespizio.dtx:33 | `sp.microtype` | no options |
| language | frontespizio.dtx:32, :149-175, :1163 | `lang.babel` | `[english,italian]`; `otherlanguage*{english}`; `\selectlanguage{english}` |
| graphics, example images | frontespizio.dtx:33, :58-60, :956 | `fig.graphicx` | `\includegraphics[scale=.3]{examplea-frn}` inside `center` and `\fbox`, `\fboxsep=0pt` |
| frontispiece package load | frontespizio.dtx:34, :934, :965, :999, :1036, :1087 | `front.frontespizio` | options: none, `sans,nouppercase`, `swapnames`, `nouppercase`, `suftesi` |
| frontispiece of the manual | frontespizio.dtx:126-138 | `front.frontespizio` | env `frontespizio`: `\Universita` `\Facolta` `\Corso[Laurea]` `\Titoletto` `\Titolo` `\Rientro{2cm}` `\NCandidato{Autore}` `\Candidato` `\Relatore` `\Correlatore` `\Annoaccademico` |
| frontispiece fields (standard shape) | frontespizio.dtx:937-947, :968-981, :1002-1019, :1039-1054 | `front.frontespizio` | `\Candidato[145822]{..}` (matricola), `\Dipartimento`, `\Corso[Dottorato di Ricerca]`, `\Istituzione` `\Divisione` `\Scuola`, `\Sottotitolo`, `\NRelatore{Coordinatore}{}`, `\NCorrelatore{..}{..}`, `\Punteggiatura{}`, `\Piede{..}` |
| frontispiece shapes and look options | frontespizio.dtx:1259-1272, :1719-1863, :1871-2015 | `front.frontespizio` | `standard` or `suftesi`; `swapnames` `signatures` `noadvisor` `norules` `nouppercase` `sans` `noinputenc` `nowrite` `onlyinclude` `driver=` |
| frontispiece geometry, margins, logo | frontespizio.dtx:1397-1402, :1523-1525, :1577, :1585-1596 | `front.frontespizio` | geometry loaded inside the frn document: standard `a4paper,left=1cm,bottom=1.5cm,right=1cm,top=1cm`, suftesi `textwidth=312pt,textheight=624pt,right=90pt,vmarginratio=1:2`; `\Margini{l}{b}{r}{t}`, `\Rientro{len}`, `\Logo[1.5cm]{file}` (e: `\Logo{fakelogo}` :1091), `\Filigrana[height=10cm,before=1,after=1]{file}` |
| frontispiece fonts, spacing, colour | frontespizio.dtx:1652-1660, :1681-1684, :1272, :1414, :1933 | `front.frontespizio` | font hooks set with kernel font commands (title `\fontsize{17}{21}\bfseries`, institution `\fontsize{14}{17}\bfseries`, names `\fontsize{12}{14}\bfseries`...), `\frontcandidatesep` 3ex, `\frontrelcorrelsep` 1ex, `\frontlogosep` 6pt, `\fronttitlecolor` Maroon (suftesi) over xcolor `svgnames` |
| frontispiece placement | frontespizio.dtx:2138-2149, :2089-2098 | `front.frontespizio` | page included at the upper-left of a `titlepage` page by the shipout hook; extra blank verso for amsbook (:2089-2092) and twoside (:2148); memoir `titlingpage` (:2093-2097) |
| extra frn preamble | frontespizio.dtx:1003-1006, :1517-1520 | `font.fourier` | `\Preambolo*` holds `\usepackage{fourier}` (frn file only) and a text alias `\newcommand{\compring}{anelli compatti}` |
| title block | frontespizio.dtx:141-147 | `front.maketitle` | `\title{..}`, `\author{.. \\ \texttt{..}}`, `\date{\filedate}`, `\maketitle` |
| title footnote | frontespizio.dtx:141-143 | `front.thanks` | `\thanks{..}` in the title |
| sections | frontespizio.dtx:150, :177, :883, :1164, :1187 | `head.kernel` | `\section`, `\section*`, `\paragraph`, `\subsection`; class default look |
| inline markup | frontespizio.dtx:141, :173, :263 | `mark.kernel` | `\textsf`, `\textsc`, `\emph`, `\texttt`, `\textdagger` (:46) |
| inline math | frontespizio.dtx:307, :330, :384, :1166 | `math.kernel` | `$0$`, `${}\mid{}$`, `\langle\mathit{driver}\rangle`, `$\varepsilon$` |
| footnotes | frontespizio.dtx:258-259, :593-595, :632-634 | `fn.kernel` | `\footnote{..}` |
| cross-references | frontespizio.dtx:254, :266, :338, :642, :665, :745 | `xref.kernel` | `\label` `\ref` |
| code listings | frontespizio.dtx:202, :239, :271, :932 | `code.verbatim` | `verbatim`, bar-delimited short verbatim (:255) |
| table floats | frontespizio.dtx:265, :663 | `tbl.tabular` | kernel `table[tp]` and `table[ht]`, `\centering` (:267, :664); table 2 holds `tabular{lll}` (:667) |
| table 1, boxed verbatim sample | frontespizio.dtx:268-290 | `box.minipage` | `lrbox{0}` with `minipage{.75\textwidth}` around `verbatim` (`code.verbatim`), shown by `\fbox{\usebox{0}}` with `\fboxsep=1em` (`box.fancybox`), `\bigskip` (`sp.manual-space`) |
| table 2, rules and size | frontespizio.dtx:666-706 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` (:668, :670, :700, :705), `\footnotesize` (`font.size-commands`), `\medskip` and `\\[3pt]` (`sp.manual-space`) |
| captions | frontespizio.dtx:266, :665 | `cap.kernel` | `\caption{..}\label{..}` |
| alignment | frontespizio.dtx:58, :814, :1122 | `sp.ragged` | `center`, `flushleft`, `\ttfamily` |
| page flow | frontespizio.dtx:927, :958, :992, :1029, :1064, :1116 | `pg.break` | `\clearpage`, `\newpage` |
| manual spacing | frontespizio.dtx:954, :988, :58 | `sp.manual-space` | `\vspace{4ex}`, `\vfill` |
| XeTeX logo in text | frontespizio.dtx:62-64, :776-795 | `sp.manual-space` | `\Xe` is boxes and kerns around `\reflectbox{E}` (`fig.rotating`); reduction under Bespoke code |
| DocStrip manual machinery | frontespizio.dtx:66-71, :75-124, :1156, :1199-2171 | `dtx.doc` | `\DocInput`, `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\CheckSum`, `\changes`, `\DoNotIndex`, `macro` / `macrocode`, `\PrintChanges\PrintIndex` |

Not in the sample: no abstract, contents list, bibliography, index package, list environments (grep of frontespizio.dtx finds no itemize, enumerate or description), no theorem, algorithm or figure float.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\pack` `\env` `\file` `\opt` | frontespizio.dtx:36-39 | yes | aliases of `\mbox{\sffamily..}` and `\texttt` and a quoted `\texttt`; inline expansion (`mark.kernel`) |
| `\frontcommand` | frontespizio.dtx:40-48 | yes | a starred `\subsection*{\cs{..}..}` plus a suffix chosen by `\ifx#1o` or `\ifx#1s`; every call (:407-582) has a literal `o`, `s` or none, so each expands to the heading plus `(*)`, `(\textdagger)` or nothing (`head.kernel`); no counter, no layout computation |
| `\frontenvironment` | frontespizio.dtx:49-52 | yes | one call (:599); expands to one `\subsection*` with `\cs{begin}` lines (`head.kernel`) |
| `\frontoption` | frontespizio.dtx:57 | yes | alias of `\subsection*{\texttt{..}}` |
| `\ttchar` | frontespizio.dtx:56 | yes | a group with `\normalfont\ttfamily` and `\char` prints one brace in typewriter face; replace by `\texttt{\{}` (`mark.kernel`) |
| `\meta@font@select` | frontespizio.dtx:53-55 | yes | one `\def` of the doc package's font hook for `\meta`, value `\normalfont\itshape`; emitted as a preamble line between `\makeatletter` and `\makeatother`, a parameter of `dtx.doc` |
| `\includeex` | frontespizio.dtx:58-60 | yes | `\par\vfill`, `center`, `\fboxsep=0pt`, `\fbox{\includegraphics[scale=.3]{..}}` (`sp.manual-space`, `sp.ragged`, `box.fancybox`, `fig.graphicx`) |
| `\Xe` | frontespizio.dtx:62-64 | yes | `\leavevmode X` then a lowered `\hbox{\kern-0.15em\reflectbox{E}}` and a kern; inline expansion with `\raisebox` and graphicx `\reflectbox` (`sp.manual-space`, `fig.rotating`), or a TeX-logo-by-name command (`font.icons`) |
| `\compring` | frontespizio.dtx:1005, :1012 | yes | text alias inside the frn preamble; inline expansion |
| `\unit` (not defined in the zip) | frontespizio.dtx:713, :730, :740 | not established | used as `\unit{ex}` and `\unit{pt}`; nothing in the zip defines it, so it is not zip-local; its source (a loaded package) was not established because no TeX tree was available to read |
| package internals `front@*` | frontespizio.dtx:1172-2164 | not bespoke | the published package's own code (token lists, `\write` of the frn file, shipout hooks via atbegshi); W1 holds (CTAN), and the emitter writes none of it, only the load line and the environment |
| `makedoc.sh` text | frontespizio.dtx:1131-1150 | yes | a docstrip-generated build script for the manual (pdflatex, mpost, epstopdf, makeindex); it is not template look, see Verdict |
| `frontespizio.ins` | frontespizio.ins:25-54 | yes | docstrip driver generating the .sty, the examples and `makedoc.sh`; distribution machinery, not typeset |

## Content-opaque
- Example frontispiece images `\includeex{examplea-frn}` to `examplee-frn` (frontespizio.dtx:956, :990, :1028, :1063, :1115): PDFs produced by compiling the generated frn documents; not in the zip, so missing assets to ship.
- MetaPost drawing `fakelogo.mp` (frontespizio.dtx:1067-1079), the sample logo used as `\Logo{fakelogo}` (frontespizio.dtx:1091); an image for a content slot, not the template's identity; `mpost` and `epstopdf` make it (frontespizio.dtx:1140-1141), so ship `fakelogo.pdf` as an asset.
- Example text: thesis titles, names, years (frontespizio.dtx:937-947 and the other examples), and the implementation listing shown in `macrocode`.

## Lib changes
- New ways proposed: `front.frontespizio` `frontespizio` (CTAN, v1.4a, LPPL 1.3, TeX Live and MiKTeX; pdfLaTeX, XeLaTeX or latex plus dvips): `\usepackage[options]{frontespizio}`, body environment `frontespizio` with field commands `\Universita` `\Istituzione` `\Facolta` `\Dipartimento` `\Divisione` `\Interfacolta` `\Corso[type]{..}` `\Scuola` `\Titoletto` `\Titolo` `\Sottotitolo` `\Candidato[matricola]{..}` `\Relatore` `\Correlatore` `\Annoaccademico` `\Piede`, label and length commands `\NCandidato` `\NCandidati` `\NRelatore` `\NCorrelatore` `\Punteggiatura` `\Rientro` `\Margini` `\Logo[height]{file}` `\Filigrana[height,before,after]{file}`, preamble pass-through `\Preambolo{..}` and `Preambolo*`, options `standard` `suftesi` `sans` `normal` `swapnames` `signatures` `noadvisor` `norules` `nouppercase` `noinputenc` `nowrite` `onlyinclude` `driver=`, font-hook and spacing macros `\fronttitlefont` and the like; the frontispiece is typeset as a second document `\jobname-frn.tex` and included at shipout. W1: on CTAN (ctan.org/pkg/frontespizio). W2: options, strings, lengths and kernel font commands in hooks; `\Preambolo` only repeats other lib ways (font packages) for the second document. W3: any Italian or similar formal thesis frontispiece, the institution is a string (not `class.ulthese`, one university; not `front.uni-titlepage`, KOMA title styles; not `front.titlepic`, one picture slot). W4: one load line and one body environment around the field commands.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
