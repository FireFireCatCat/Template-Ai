no

# 0367-rkkautsar-ui-thesis-template: UI thesis template (Universitas Indonesia skripsi/thesis, fork of ui_style)

- Unverified: read from the source, not compiled.
- Source: Source/0367-rkkautsar-ui-thesis-template/ (origin: https://codeload.github.com/rkkautsar/ui-thesis-template/zip/refs/heads/master; licence: NOASSERTION in the manifest; the zip's own template_license.txt is Creative Commons Attribution-NonCommercial-ShareAlike 1.0)
- Kind: thesis
- Lib: v3
- Engine: pdfLaTeX-compatible
- Look carried by: zip-local (the look is defined in the zip-local `_internals/uithesis.sty`, a modified copy of `fncychap.sty`, `settings.tex` and hand-laid cover and approval pages; `thesis.tex` itself only loads them)
- Class origin: tex-distribution-unbundled
- Main file: thesis.tex (other samples: none; the chapters and front matter are `\input` from src/)
- Read: main yes, zip-local classes and styles partly (uithesis.sty, hype.indonesia.tex, settings.tex, istilah.tex in full; fncychap.sty lines 1-171, 505-545 and 640-711, i.e. header, core definitions, the `ConnyRevised` option and the `\@makechapterhead` tail; not read: the other style options at fncychap.sty:172-504 and 546-639, which the sample does not load)

## Verdict
No. The look itself is made of published packages plus small `\newcommand` wrappers that reduce to lib ways, but `uithesis.sty` loads `minted` unconditionally, and the Makefile builds with `-shell-escape`: the document does not compile without Pygments, which the rubric rules `EXTERNAL/package` even though the sample would still show the look without it. Every other zip-local construct (the hyperlinked `\contentsline`, the `\@startsection` redefinition of `\section`, the `ConnyRevised` option added to `fncychap`, `\todo`, `\var`) is reducible, so `minted` is the only blocker found. Not compiled: nothing here says the reductions give the same pages.

## Blockers
- `EXTERNAL/package` `minted` loaded unconditionally by the style: `\usepackage[outputdir=out, newfloat]{minted}` (_internals/uithesis.sty:151), set up at _internals/uithesis.sty:154-162 and used in the body at src/01-body/04-bab4.tex:79 (`\mintinline`) and src/01-body/04-bab4.tex:95-128 (`minted` in a `listing` float); the build command passes shell escape (Makefile:15, `latexmk ... -shell-escape`).

Non-blocking notes: (1) the cover logo is EPS (_internals/sampul.tex:14, _internals/judul_dalam.tex:12); pdfLaTeX includes EPS only through a Ghostscript conversion, so the asset would be shipped as PDF or PNG (a missing/converted asset, not counted). (2) No text addressed to an AI was found in the zip.

## Class setting
- Class: `class.report` options: `12pt, a4paper, onecolumn, oneside, final` (thesis.tex:16). The class is the kernel report, loaded unchanged and not bundled in the zip; its source was not read.
- Class-native vocabulary used: `\chapter`, `\chapter*`, `\section`, `\subsection` (src/01-body/01-bab1.tex:2,8,22), `titlepage` environment (_internals/sampul.tex:10), `\tableofcontents` `\listoffigures` `\listoftables` (thesis.tex:80-86), `\pagenumbering`, `\addcontentsline{toc}{chapter}` (_internals/uithesis.sty:306), name strings `\chaptername` `\contentsname` `\listfigurename` `\listtablename` `\figurename` `\tablename` `\bibname` (_internals/uithesis.sty:318-336), `\appendix` (only in a commented block, thesis.tex:119-123).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | thesis.tex:16 | `class.report` | 12pt, a4paper, onecolumn, oneside, final |
| paper, size, sides | thesis.tex:16 | `page.class-options` | a4paper, 12pt, oneside, onecolumn |
| page geometry | _internals/uithesis.sty:95 | `page.geometry` | paper=a4paper, headheight=0pt, left=4cm, top=3cm, right=3cm, bottom=3cm |
| running head and foot | _internals/uithesis.sty:235-243 | `hf.fancyhdr` | `\fancyhf{}`; head R = `\thepage`; foot R = `\footnotesize \textsf{\bo{Universitas Indonesia}}`; head and foot rules 0pt; `\pagestyle{fancy}` |
| line spacing | _internals/uithesis.sty:84-85 | `sp.setspace` | `\onehalfspacing` |
| hyphenation and sloppy | _internals/hype.indonesia.tex:15-78; _internals/uithesis.sty:195 | `sp.hyphenat` | `\hyphenation{...}` Indonesian word list; `\sloppy` |
| text font | _internals/uithesis.sty:113 | `font.mathptmx` | `pslatex` (Times roman, scaled Helvetica sans, condensed Courier; a separate CTAN package, read at ctan.org/pkg/pslatex, obsolete); the package is the parameter as for `times` |
| size and shape switches | _internals/uithesis.sty:225,241,164 | `font.size-commands` | `\large\bfseries` (section), `\footnotesize`, `\tiny` (listing line numbers) |
| colours | _internals/uithesis.sty:174; :269,:271 | `color.xcolor` | `\definecolor{code_bg}{rgb}{0.95,0.95,0.95}`; `\rowcolor[rgb]{.9,.6,.6}` and `[gray]{1.}` through `colortbl` |
| PDF metadata and links | _internals/uithesis.sty:46-56 | `meta.hyperref` | colorlinks=false, pdfborder=0 0 0, linkcolor=blue, citecolor=black, bookmarksopen=false, bookmarksnumbered=true, pdfstartview=FitH, pdfview=FitH |
| URLs | _internals/uithesis.sty:67-68 | `meta.url` | `\urlstyle{same}` (used at src/01-body/02-bab2.tex:43) |
| cross-references | src/00-front_matter/04-pengantar.tex:30,33; src/01-body/03-bab3.tex:11,16 | `xref.kernel` | `\label`, `\ref` |
| cover page and inner title page | _internals/sampul.tex:10-45; _internals/judul_dalam.tex:9-46 | `front.titlepage-env` | `titlepage` + `center`, logo in a `figure` (`\includegraphics[width=2.5cm]`), `\vspace*{...}` gaps, bold lines from `\bo`, uppercase data macros |
| approval, originality, publication pages | src/00-front_matter/01-persetujuan.tex:8-31; 02-orisinalitas.tex:8-27; 03-pengesahan_sidang.tex:8-56; 05-persetujuan_publikasi.tex:6-52 | `front.dedication` | `\chapter*` heading, `tabular` blocks, centred signature blocks, `\newpage` |
| abstract pages (Indonesian, English) | src/00-front_matter/06-abstrak.tex:8-37; 07-abstract.tex:8-38 | `abs.keywords` | hand-laid under `\chapter*`: data `tabular`, `\bigskip` gaps, a plain "Kata kunci:" / "Key words:" line; no `abstract` environment is used |
| foreword and publication-licence figure | src/00-front_matter/04-pengantar.tex:2-79 | `front.dedication` | `\chapter*{Kata Pengantar}`, `enumerate`, two figures, `flushright` signature |
| front-matter toc entries | thesis.tex:41-70; _internals/uithesis.sty:306 | `toc.kernel` | `\addChapter{...}` = `\phantomsection\addcontentsline{toc}{chapter}{...}` before each page |
| contents and lists | thesis.tex:79-90 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables`, `\listoflistings` after `\phantomsection` and followed by `\clearpage` |
| toc layout and list-of styling | _internals/uithesis.sty:149-150,183-190 | `toc.tocloft` | option `titles`; `\newlistof{listing}{lol}{Daftar Kode}`; `\cftlistingpresnum`, `\cftfigpresnum`, `\cfttabpresnum`; number widths 1in |
| bibliography and index in toc | _internals/uithesis.sty:33 | `toc.etoc` | `tocbibind` |
| chapter headings | _internals/uithesis.sty:128; _internals/fncychap.sty:513-537 | `head.fncychap` | option `ConnyRevised` (zip-local modification, see Bespoke code): centred, `\large\bfseries`, name and title upper-cased |
| section headings | _internals/uithesis.sty:222-225 | `head.kernel` | `\renewcommand\section{\@startsection{section}{1}{\z@}{-3.5ex plus -1ex minus -.2ex}{2.3ex plus .2ex}{\large\bfseries}}`; `\subsection` left at report default |
| numbering depths | _internals/uithesis.sty:228,230 | `num.secnumdepth` | secnumdepth=3, tocdepth=3 |
| page numbering | thesis.tex:37,46,95 | `pgnum.pagenumbering` | roman, `\setcounter{page}{2}`, then arabic |
| counters | _internals/uithesis.sty:168-169 | `num.counters` | `\thelisting` = `\thechapter.\arabic{listing}`; `\@addtoreset{listing}{chapter}` |
| name strings (Indonesian) | _internals/uithesis.sty:318-336 | `toc.kernel` for `\contentsname` `\listfigurename` `\listtablename`; `head.kernel` for `\chaptername`; `cap.kernel` for `\figurename` `\tablename`; `bib.bibtex-bst` for `\bibname` | strings: DAFTAR ISI, DAFTAR GAMBAR, DAFTAR TABEL, BAB, Gambar, Tabel, DAFTAR REFERENSI. No babel or polyglossia is loaded. |
| lists | src/01-body/01-bab1.tex:60-68; src/00-front_matter/04-pengantar.tex:9-20 | `list.kernel` | `itemize`, `enumerate` |
| inline marks | _internals/uithesis.sty:252-264; src/00-front_matter/01-persetujuan.tex:27 | `mark.kernel` | `\f`=`\textit`, `\bo`=`\textbf`, `\bi`, `\code`=`\texttt`, `\underline`, `\uppercase` |
| display maths | src/01-body/03-bab3.tex:11-70; _internals/uithesis.sty:106-108 | `math.amsmath` | `align`, `\nonumber`, `array` inside, `\cfrac` |
| math fonts and symbols | _internals/uithesis.sty:107-108,261 | `math.amssymb` | `amsfonts`; `bm` as `math.bm` below |
| bold math | _internals/uithesis.sty:108,261 | `math.bm` | `\m{#1}`=`\bm{#1}` |
| slash fractions | _internals/uithesis.sty:146 | `math.nicefrac` | load only (no `\nicefrac` call in the sample) |
| figures | src/01-body/02-bab2.tex:117-123; _internals/uithesis.sty:78 | `fig.graphicx` | `figure`, `\centering`, `\includegraphics[width=0.50\textwidth]`, caption below |
| float placement | _internals/uithesis.sty:138-140 | `fig.float` | `\floatplacement{figure}{H}`, `\floatplacement{table}{H}` |
| new float `listing` | _internals/uithesis.sty:151,153 | `fig.newfloat` | minted option `newfloat`; `\SetupFloatingEnvironment{listing}{name=\bo{Kode}}` |
| captions | _internals/uithesis.sty:100 | `cap.caption` | font=footnotesize, format=plain, labelfont=bf, up, textfont=up |
| caption commands | src/01-body/02-bab2.tex:121,135 | `cap.kernel` | `\caption` below figures, above tables (by order in source) |
| tables | src/01-body/02-bab2.tex:10-28,137-146,158-168,175-187,194-206 | `tbl.tabular` | `tabular` with `\hline`, `\cline`, `\multicolumn`, `p{13cm}` column |
| row and column spans | _internals/uithesis.sty:73; src/01-body/02-bab2.tex:180,183,198,202 | `tbl.multirow` | `\multirow{2}{*}{...}` |
| coloured rows | _internals/uithesis.sty:133 | `tbl.colortbl` | `\rowcolor` (used in `\todo`) |
| verbatim and line numbers | src/01-body/04-bab4.tex:77,85-92; _internals/uithesis.sty:164 | `code.verbatim` | `\verb`, `verbatim`; `\theFancyVerbLine` = `{\tiny{\arabic{FancyVerbLine}}}` |
| highlighted code | _internals/uithesis.sty:151-162; src/01-body/04-bab4.tex:79,95-128 | `code.minted` | style=pastie, autogobble, linenos, fontsize=\footnotesize, breaklines, breakanywhere, python3; `outputdir=out`, `newfloat` (**EXTERNAL**) |
| code frame | _internals/uithesis.sty:173-180 | `box.mdframed` | `framemethod=TikZ`; style `code`: backgroundcolor=code_bg, roundcorner=2pt, linewidth=0pt; `\surroundwithmdframed[style=code]{minted}` |
| citations | _internals/uithesis.sty:143; src/01-body/02-bab2.tex:9,32 | `bib.natbib` | `\citep`, `\cite` |
| bibliography | thesis.tex:113-114 | `bib.bibtex-bst` | `\bibliographystyle{apalike}`, `\bibliography{pustaka}` (pustaka.bib:4-29 are entries, content) |
| included PDF pages | _internals/uithesis.sty:123,292-296; src/01-body/05-bab5.tex:55,62 | `pg.include-pdf` | `\includepdf[pages=-,pagecommand={\thispagestyle{fancy}}]` and `\includepdf[pages=-]` |
| page breaks | thesis.tex:81,84,87,90; src/00-front_matter/01-persetujuan.tex:31 | `pg.break` | `\clearpage`, `\newpage` |
| manual spacing | _internals/sampul.tex:17-35; src/00-front_matter/06-abstrak.tex:21 | `sp.manual-space` | `\vspace*{...cm}`, `\\[1.0cm]`, `\bigskip` |
| paragraph indent | src/00-front_matter/06-abstrak.tex:12 | `sp.lengths` | `\setlength{\parindent}{0pt}` inside a group |
| appendix (inactive) | thesis.tex:119-123; _internals/markLampiran.tex:8-13; src/99-back_matter/lampiran.tex:2-3 | none active | the `\appendix` block and the "LAMPIRAN" divider are commented out in the sample; `lampiran.tex` is `\addChapter` + `\chapter*` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\contentsline` redefinition (linked title and page in the toc) | _internals/uithesis.sty:208-221 | yes | `meta.hyperref` option `linktoc=all`; the hack calls `\hyper@linkstart`/`\hyper@linkend` around the entry text and the page number, which is what that option does. Equivalence not compiled. |
| `\renewcommand\section{\@startsection{section}{1}...}` | _internals/uithesis.sty:222-225 | yes | a documented `\@startsection` call with its six parameters: `head.titlesec` `\titleformat{\section}{\large\bfseries}...` with `\titlespacing*{\section}{0pt}{3.5ex plus 1ex minus .2ex}{2.3ex plus .2ex}` (or `head.kernel` as written) |
| `ConnyRevised` option inside a modified copy of `fncychap.sty` (header and options otherwise the published v1.34: _internals/fncychap.sty:55-57; the zip's file keeps the name `fncychap` although its own notice asks for a new name: _internals/fncychap.sty:1-5) | _internals/fncychap.sty:513-537 | yes | `head.titlesec`: `\titleformat{\chapter}[display]{\centering\large\bfseries}{\MakeUppercase\chaptername\ \thechapter}{0pt}{\MakeUppercase}`, numberless variant for `\chapter*`, `\titlespacing` before 10pt (_internals/fncychap.sty:663,701), after 20pt (numbered, :530) and 10pt+20pt (starred, :535 and :706). The public setters `\ChNameVar` `\ChNumVar` `\ChTitleVar` `\ChNameUpperCase` `\ChTitleUpperCase` (fncychap.sty:68,73,120,80,132) are declarative, but the vertical skips live in `\DOCH` `\DOTI` `\DOTIS`, which are not options, hence titlesec. I could not confirm against CTAN that `ConnyRevised` is absent from the release; the zip's revision notes (fncychap.sty:1-51) do not mention it. |
| `\todo`, `\todoCite` | _internals/uithesis.sty:267-288 | yes | `\newcommand` around `tabular{| p{13.5cm} |}` with `\rowcolor[rgb]{.9,.6,.6}` header row (`tbl.tabular`, `tbl.colortbl`); a callout box, used at src/01-body/01-bab1.tex:4 and src/00-front_matter/03-pengesahan_sidang.tex:46 |
| `\inpdf`, `\putpdf` | _internals/uithesis.sty:292-296 | yes | aliases of `\includepdf` (`pg.include-pdf`) with `pagecommand={\thispagestyle{fancy}}` or none |
| `\var`, `\Var` and the data in settings.tex | _internals/uithesis.sty:299,303; settings.tex:6-73 | yes | `\newcommand` definers of title-page strings; `\Var` wraps `\uppercase`; the emitter writes the strings inline (content) |
| `\addChapter` | _internals/uithesis.sty:306 | yes | `\phantomsection` (`meta.hyperref`) + `\addcontentsline{toc}{chapter}{...}` (`toc.kernel`) |
| aliases `\f \bi \bo \m \code \latex \pic \tab \equ \bslash \license` | _internals/uithesis.sty:252-264,309,339-345; istilah.tex:9-10 | yes | `\newcommand` aliases of `mark.kernel` switches, `\bm` (`math.bm`), `\LaTeX`, fixed strings |
| `\thelisting` + `\@addtoreset{listing}{chapter}` | _internals/uithesis.sty:168-169 | yes | `num.counters` (`\counterwithin`/`chngcntr` plus `\renewcommand\thelisting`) |
| `\newif\ifpdf` and `\pdfoutput=1` | _internals/uithesis.sty:197-203 | yes | `\ifpdf` is never tested (grep over the zip: only the definition); `\pdfoutput=1` is the pdfLaTeX default; nothing to emit |
| `\newlistof{listing}{lol}{Daftar Kode}` beside minted's own `listing` float | _internals/uithesis.sty:150,151,153 | yes (as `toc.tocloft` + `fig.newfloat`) | both declare the name `listing`; how they cooperate was not checked (not compiled) |
| `uithesis.sty` as a whole | _internals/uithesis.sty:1-345 | yes, except `minted` | a bundle of `\usepackage` lines, option settings and the items above; `minted` stays `EXTERNAL/package` |

## Content-opaque
none (figure images are included files: assets/pics/creative_common.png, assets/pics/mark.png; the logo `_internals/makara.eps`; the minted listing text; the `array` matrices inside `align` at src/01-body/03-bab3.tex:35-54)

## Lib changes
- New ways proposed: none. Considered and not proposed: a way for kernel name strings (`\contentsname` and the like); each string is a parameter of the kernel way of the component it labels (`toc.kernel`, `head.kernel`, `cap.kernel`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
