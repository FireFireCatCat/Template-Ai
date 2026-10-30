yes

# 0853-planetary-research-article: Planetary Research Article

- Unverified: read from the source, not compiled.
- Source: Source/0853-planetary-research-article/ (origin: https://latextemplates.com/downloads/planetary-research.zip; licence: MIT)
- Kind: journal
- Lib: v6
- Engine: pdfLaTeX-compatible (inputenc/fontenc T1, biblatex with biber, no fontspec; the CTAN page of `orcidlink` does not state pdfLaTeX support, and orcidlink.sty:61 uses `\XeTeXLinkBox`, which `hyperref` is expected to supply; not checked)
- Look carried by: zip-local (planetary.cls carries the whole look; main.tex adds only metadata macros and content)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (planetary.cls 228 lines and orcidlink.sty 78 lines, both read in full)

## Verdict
The look sits in a 228-line zip-local class, `planetary.cls`, that is `\LoadClass{article}` plus published packages, one `\captionsetup`, one `\fancypagestyle` and `\newcommand` string macros. Every piece reduces to lib ways with parameters (reductions below). The two kernel redefinitions (`\maketitle`, `\@makecaption`) sit in the `final` option branch, which the sample does not select, and reduce to `front.titling` and `cap.caption`. There is no artwork drawn by the template: the header logo is an included image, and the ORCID logo is drawn inside the published `orcidlink` package and never called by the sample. The answer is `yes` only on the reading that an emitter resolves the `final`/`review` class option and the article-type option to one flat parameter set.

## Blockers
none

## Class setting
- Class: `class.article` options: `12pt,a4paper` when `final` is absent (the sample's case, planetary.cls:37), `11pt,a4paper` with `final` (planetary.cls:35). planetary.cls is not published: ctan.org/pkg/planetary returned 404, the zip is from latextemplates.com, and README.md:3-6 only calls it "the upstream planetary class" from an MIT repository, with no publisher kit shown. So it is zip-local and reduces to `class.article` plus the ways below.
- Class-native vocabulary used (all zip-local, reduced below, none is a published way): options `review` (not declared, forwarded to article by planetary.cls:30) and `article` (planetary.cls:16); `\shorttitle` (main.tex:5), `\setcorrespauth` `\setcorrespmail` (main.tex:10-11), `\correspondingauthor` `\submissiondate` `\mstype` `\abstractwordcount` (main.tex:17-20), page style `firstpage` (main.tex:16), `\mytablestyle` (main.tex:49).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1; planetary.cls:34-38 | `class.article` | 12pt, a4paper (review); 11pt, a4paper (final) |
| paper and size by options | planetary.cls:35,37 | `page.class-options` | a4paper, 12pt or 11pt chosen by the `final` switch |
| page geometry | planetary.cls:43-44, 197 | `page.geometry` | margin=2.5cm; final adds left=3.8cm |
| head height | planetary.cls:113 | `page.setlength` | `\headheight`=48pt |
| encodings, text symbols | planetary.cls:41-42, 63 | `font.fontenc-t1` | inputenc utf8, fontenc T1, textcomp |
| text face | planetary.cls:79 | `font.family-default` | `\familydefault`=`\sfdefault` (no text-face package; math stays Computer Modern) |
| paragraph spacing | planetary.cls:94 | `sp.lengths` | `\parskip`=0.5em |
| indent after headings | planetary.cls:65 | `sp.indentfirst` | load-only |
| line numbers | planetary.cls:49, 188-192 | `sp.draft-lineno` | `\linenumbers` at begin of document unless `final` (on in the sample) |
| first-page header | planetary.cls:116-121; main.tex:16 | `hf.fancyhdr` | `\fancypagestyle{firstpage}`: `\fancyhf{}`, `\lhead{\includegraphics[height=1.2cm]{assets/journal_logo}}`, headrulewidth=0pt, footrulewidth=0pt; selected by `\thispagestyle{firstpage}` |
| logo in header | planetary.cls:118 | `fig.graphicx` | height=1.2cm, assets/journal_logo.pdf |
| page style elsewhere | planetary.cls:125; main.tex:16 | `hf.pagestyle-kernel` | `\pagestyle{plain}`, `\thispagestyle` |
| colours | planetary.cls:46 | `color.xcolor` | options dvipsnames, table (`\PassOptionsToPackage`) |
| links | planetary.cls:60, 70-75 | `meta.hyperref` | colorlinks=true, linkcolor=citecolor=urlcolor=MidnightBlue |
| url package | planetary.cls:59 | `meta.url` | load-only |
| title block (review) | main.tex:4, 12, 15 | `front.maketitle` | kernel `\title` `\date{}` `\maketitle` |
| authors, affiliations | planetary.cls:52, 124; main.tex:6-9 | `front.authblk` | `\author[n]`, `\affil[n]`, `\Affilfont`=`\normalfont\footnotesize` |
| title block (final) | planetary.cls:201-215 | `front.titling` | see Bespoke code |
| metadata lines | planetary.cls:129-164; main.tex:17-20 | `mark.kernel` | `\noindent\textbf{Label:} text` per line (corresponding author, submission date, manuscript type, abstract word count) |
| size switch in metadata | planetary.cls:162; main.tex:18 | `font.size-commands` | `\small`, written in `\submissiondate` outside any group |
| abstract | main.tex:22-27 | `abs.kernel` | article `abstract` environment |
| sectioning | main.tex:29, 35, 47, 68, 75 | `head.kernel` | article `\section` look, unchanged |
| numbering depth | planetary.cls:179-183 | `num.secnumdepth` | secnumdepth=3 (0 for the `letter` option) |
| counter helper package | planetary.cls:67 | `num.counters` | `chngcntr`, load-only (no `\counterwithin` use found) |
| display equation | main.tex:40-43; planetary.cls:48 | `math.amsmath` | `equation`, `\eqref` |
| cross-references | main.tex:42, 60, 64, 69 | `xref.kernel` | `\label`, `\ref`, `\eqref` |
| table float | main.tex:48-61 | `tbl.tabular` | `table[ht]`, `tabular{lrr}`, `\arraystretch`=1.5 via `\mytablestyle` |
| centering, size in table style | planetary.cls:97-101 | `sp.ragged` | `\centering` |
| table size | planetary.cls:100 | `font.size-commands` | `\small` |
| table rules | main.tex:52, 54, 58 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| table packages | planetary.cls:57, 62, 46 | `tbl.tabularx` | `tabularx` load-only; `multirow` is `tbl.multirow`, used in `\license`; `table` option of xcolor is `tbl.colortbl` |
| caption format | planetary.cls:66, 104-110 | `cap.caption` | font={sf,small}, labelfont=bf, labelsep=planetarybar (` | `, declared at line 104), justification=justified, singlelinecheck=false, oneside |
| caption command | main.tex:50 | `cap.kernel` | `\caption` |
| bibliography | planetary.cls:56; main.tex:2, 73, 79 | `bib.biblatex-biber` | style=authoryear, maxbibnames=99, backend=biber; `\addbibresource`, `\parencite`, `\printbibliography` |
| ORCID link package | planetary.cls:53, 137; orcidlink.sty:74 | `font.icons` | package `orcidlink` (`\orcidlink{id}` prints the logo as a link); `\orcid` is an alias; not called in main.tex |
| filler text package | planetary.cls:55 | `draft.todo` | `lipsum`, load-only |
| spacing package | planetary.cls:54 | `sp.setspace` | `setspace`, load-only (no `\onehalfspacing` found) |
| verbatim package | planetary.cls:61 | `code.verbatim` | load-only |
| small caps off | planetary.cls:77 | `mark.kernel` | `\textsc` becomes identity: the emitter writes no `\textsc` |
| micro symbol | planetary.cls:155 | `font.fontenc-t1` | textcomp `\textmu` inside `\text` (amsmath), see Bespoke code |
| licence block | planetary.cls:166-176 | `tbl.tabular` | `p{..}` columns, `\cline{1-5}`; not called in main.tex |
| licence block, merged cell | planetary.cls:174 | `tbl.multirow` | `\multirow{2}{*}{\parbox{0.43\textwidth}{..}}` |
| licence block, parbox and link | planetary.cls:174 | `box.minipage` | `\parbox{0.43\textwidth}`; link text is `\href` of `meta.hyperref` |
| licence block, icons | planetary.cls:175 | `fig.graphicx` | `\includegraphics[height=1.5em]` of assets/cc.png and assets/by.png (files absent from the zip) |
| licence block, spacing and size | planetary.cls:167-173 | `sp.manual-space` | `\vfill`, `\vspace{1mm}`, `\hspace{0.15em}`; `\scriptsize` is `font.size-commands` |
| final caption | planetary.cls:218-224 | `cap.caption` | see Bespoke code |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\articletype`, `\setarticletype`, nine article-type `\DeclareOption`s | planetary.cls:11-24 | yes | a stored string whose only reader is the test at line 179; the emitter turns the option into `\setcounter{secnumdepth}{0}` for `letter` and `{3}` otherwise (`num.secnumdepth`) |
| `\IfStrEq` test with `xstring` | planetary.cls:64, 179-183 | yes | a compile-time test of an option string; the emitter picks the branch, so `xstring` disappears (considered: `xstring`, no lib way, a macro-body helper only) |
| `\newif\ifprfinal`, `final` option, `\ifprfinal` blocks | planetary.cls:28-29, 34-38, 188-197 | yes | the emitter picks one branch: review gives 12pt, line numbers; final gives 11pt, `\geometry{left=3.8cm}`, the title and caption reductions below |
| `\DeclareRobustCommand{\textsc}[1]{#1}` | planetary.cls:77 | yes | alias to identity; the emitter never writes `\textsc` (`mark.kernel`) |
| `\shorttitle`, `\insertshorttitle` | planetary.cls:82-91 | yes | `\insertshorttitle` is not called in the class or the sample, so the stored string prints nothing; the emitter can drop it |
| `\mytablestyle` | planetary.cls:97-101 | yes | alias: `\renewcommand{\arraystretch}{1.5}` (`tbl.tabular`), `\centering` (`sp.ragged`), `\small` (`font.size-commands`) inside the float group |
| `\DeclareCaptionLabelSeparator{planetarybar}` | planetary.cls:104 | yes | the `caption` package's own declaration of a separator string ` | `; one `cap.caption` parameter |
| `firstpage` page style | planetary.cls:116-121 | yes | `hf.fancyhdr` call listed in the map |
| helper macros `\correspmail` `\setcorrespmail` `\correspauth` `\setcorrespauth` `\correspondingauthor` `\stitle` `\summary` `\mstype` `\abstractwordcount` `\summarycharactercount` `\letterwordcount` `\methodswordcount` `\specialissue` `\submissiondate` `\revisiondate` `\accepteddate` | planetary.cls:129-164 | yes | each is `\noindent\textbf{Label:} text` (`mark.kernel`); the `\set...` pair only stores a string that `\correspondingauthor` prints; the emitter writes the line with the text inlined. `\submissiondate` and the two other date macros start with an ungrouped `\small`, so in the sample (main.tex:18) `\small` stays in force for the rest of the body (Unverified); the emitter writes it as a switch at that point (`font.size-commands`) |
| `\upmu` (declared twice) | planetary.cls:155, 157 | yes | `\ifmmode\text{\textmu}\else\textmu\fi`: textcomp symbol, `\text` from amsmath; not called in the sample |
| `\orcid` | planetary.cls:137 | yes | alias of `\orcidlink` of the published package |
| `\license` | planetary.cls:166-176 | yes | one `tabular` with `\cline`, `\multirow`, `\parbox`, `\href`, two `\includegraphics`; the map rows list the ways; not called in the sample; cc.png and by.png missing |
| final `\maketitle` | planetary.cls:201-215 | yes | `front.titling`: `\pretitle{\begin{flushleft}\LARGE\bfseries}`, `\posttitle{\par}`, `\preauthor{\vskip 1em\large}`, `\postauthor{\par}`, `\predate{\vskip .5em\normalsize}`, `\postdate{\par\end{flushleft}\par\vskip 2em}`, `\maketitlehooka{\thispagestyle{firstpage}\let\footnote\thanks}` (`front.thanks`); the custom version never prints `\thanks` text, so the reduction is a superset of it; unused by the sample (review mode) |
| final `\@makecaption` | planetary.cls:218-224 | yes | `cap.caption`: font=small, labelfont=bf, labelsep=period, justification=justified, singlelinecheck=false, with `\abovecaptionskip` and `\belowcaptionskip` as lengths (`sp.lengths`); the redefinition is applied after `caption` loads, so which of the two wins in a compiled final run is not established; unused by the sample |
| `orcidlink.sty` | orcidlink.sty:22-23, 58-74 | yes (published) | the CTAN package `orcidlink` (LPPL, Leo C. Stein; the zip carries its generated file, orcidlink.sty:7-19); it loads `hyperref` and `tikz` (orcidlink.sty:28-29) and draws the logo as a `tikz` pic (orcidlink.sty:36-43), which belongs to the package and is not template artwork |

## Content-opaque
- assets/journal_logo.pdf, the header logo image (planetary.cls:118), a binary file not read.
- The equation at main.tex:40-43 and the table cells at main.tex:51-59, bibliography entry references.bib:1-9.
- Missing assets: assets/cc.png and assets/by.png (planetary.cls:175) are not in the zip; ship them if `\license` is used.

## Lib changes
- New ways proposed: none (considered: `xstring`, a conditional helper that disappears when the emitter resolves the class option)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
