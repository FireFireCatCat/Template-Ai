yes

# 0701-refman: refman (document classes refart and refrep, Reference Manual layout)

- Unverified: read from the source, not compiled.
- Source: Source/0701-refman/ (origin: https://mirrors.ctan.org/macros/latex/contrib/refman.zip; licence: LPPL 1, manifest `lppl1`, refman.ins:10-13)
- Kind: report
- Lib: v5
- Engine: pdfLaTeX-compatible
- Look carried by: mixed (the published class `refart` defines page, headings, margin notes, title, footnotes and wide-page environments; the preamble adds T1 fontenc, the `ae` face, `german`, `makeidx` and a few settings)
- Class origin: ctan
- Main file: layout_d.tex (other samples: layout_e.tex, the English twin with `\pagestyle{myfootings}` at layout_e.tex:29; lay_d2.tex and lay_e2.tex, `\input` by the two mains; refman.dtx doc driver on `ltxdoc`, refman.dtx:69-143)
- Read: main yes, zip-local classes and styles all (refman.dtx code lines, refman.ins, pagepc.sty; layout_e.tex and lay_e2.tex only grepped for preamble and macros, not read through)

## Verdict
The look is carried by the class `refart`, which is on CTAN and in TeX Live (ctan.org/pkg/refman read: LPPL 1, in TeX Live). The zip is that CTAN bundle: it ships `refman.dtx` and `refman.ins`, not the generated `.cls` (refman.ins:41-43), so class files must be produced by running TeX on `refman.ins` (docstrip, TeX only, not EXTERNAL). The sample's own preamble loads only published packages (`fontenc`, `ae`, `makeidx`, `ifthen`, `german`; `ae` and `german` read on CTAN) and defines aliases that expand inline. The only bespoke body code is the helper macro set that draws the page-layout diagram (lay_d2.tex:146-361); it works from literal numbers and sits inside a `figure`, so it is figure artwork, hence content. The `yes` rests on that reading: if helper macros around a figure were counted as body code, this would become `no` (BESPOKE/body).

## Blockers
none

## Class setting
- Class: `class.refart` options: `twoside`, `a4paper` (layout_d.tex:7). Class defaults `letterpaper,10pt,oneside,onecolumn,final` are overridden by these (refman.dtx:497); `twocolumn` is an error (refman.dtx:409-415). Other options the class declares and the sample does not use: `landscape`, `square`, `smallborder`, `pagesize`, `dvips`, `pdftex`, `titlepage`, `fleqn`, `leqno`, `openbib` (refman.dtx:230-441).
- Class-native vocabulary used: `\settextfraction` (layout_d.tex:48), `\marginlabel` (layout_d.tex:83), `\seealso` (layout_d.tex:137), `\attention[..]` and `\attentionsymbol` (lay_d2.tex:708-726), environments `fullpage` (lay_d2.tex:141-463) and `maxipage` (lay_d2.tex:755-759), `description` with labels in the left margin (layout_d.tex:202), `theindex` through `\printindex` (layout_d.tex:779), page style `plain` by default (refman.dtx:3840) and `myfootings` in the English twin, `\markboth` (layout_d.tex:35-36). Not used here: `\condbreak`, `\noparskip`, `example`, `\pageperchapter` (refrep only), `\secshape` (refman.dtx:3660-3661, 2007).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | layout_d.tex:7; refman.dtx:46 | `class.refart` | twoside, a4paper; source not a `.cls` in the zip (refman.ins:41) |
| paper and sides | layout_d.tex:7; refman.dtx:230-232,371-372 | `page.class-options` | a4paper (210mm x 297mm), twoside (even and odd margins equal, marginpar always left) |
| text block and left note column | layout_d.tex:48; refman.dtx:728-816,830-861 | `class.refart` (native `\settextfraction`) | fraction 0.7 of `\fullwidth` (paper minus 2 x `\papermarginwidth` 1in), rest is `\leftmarginwidth`; `\textheight` a whole number of lines; `\marginparpush` 0 |
| font encoding | layout_d.tex:9 | `font.fontenc-t1` | fontenc option T1 |
| text face | layout_d.tex:10 | `font.serif-pkg` | package `ae` (virtual T1 fonts over CM; ctan.org/pkg/ae read, in TeX Live; considered `font.lmodern`, not used because the package is `ae`) |
| language | layout_d.tex:13; also shorthands such as `"a` `"s` `"-` throughout | `lang.babel` | package `german` (old German support, ctan.org/pkg/german read, LPPL 1, in TeX Live); shorthands are content |
| index | layout_d.tex:11,38,779; `\index` at 83,164 | `idx.makeidx` | `\makeindex` in preamble, `\printindex` at end; class `theindex` is two-column inside `fullpage`, `\columnsep` 35pt (refman.dtx:3349-3388); makeindex is run after TeX, as BibTeX is for `bib.bibtex-bst` |
| line breaking | layout_d.tex:30 | `sp.lengths` | `\emergencystretch` 1em |
| running head and foot | layout_d.tex:32-34 (commented out); refman.dtx:1070-1084,3840 | `hf.class-native` | page style `plain`: number flush outer in the foot (twoside), no head; `myfootings` rule above foot with slanted mark (refman.dtx:1372-1397, used at layout_e.tex:29) |
| marks | layout_d.tex:35-36 | `hf.pagestyle-kernel` | `\markboth{Layout-Aenderungen mit LaTeX}{same}`; inactive under `plain` (`\@mkboth` is `\@gobbletwo`, refman.dtx:1072) |
| title block | layout_d.tex:21-29,51; refman.dtx:1519-1577,1591-1606 | `front.maketitle` | `\title`, `\author` with `\\` lines, empty `\date{}`, `\maketitle`; no `titlepage` option |
| title look | refman.dtx:1591-1606,3591-3592 | `front.class-native` | new page, thick rule, title in `\secshape \Large\bfseries`, thick rule, author flush right slanted, date |
| author note | layout_d.tex:25 | `front.thanks` | `\thanks{..}`; class sets symbol marks (refman.dtx:1522-1531) |
| abstract | layout_d.tex:53-60; refman.dtx:2361-2371 | `abs.kernel` | `abstract` env; class look: `\small`, centred bold `\abstractname`, `quote` body |
| contents | layout_d.tex:66; lay_d2.tex:7 | `toc.kernel` | `\tableofcontents`, `\addcontentsline{toc}{section}{Anhang}`; class entries bold for sections (refman.dtx:3121-3149) |
| contents depth | layout_d.tex:47 | `num.secnumdepth` | `\setcounter{tocdepth}{2}` (class default 3, refman.dtx:2982) |
| headings | layout_d.tex:73,75,451; lay_d2.tex:6,11,468 | `head.kernel` | `\section`, `\subsection`, `\subsubsection`, `\section*` |
| heading look | refman.dtx:2007-2046 | `head.class-native` | `\secshape`: `\leftskip=-\leftmarginwidth`, `\rightskip=\@flushglue`, `\hyphenpenalty=2000`; section `\large\bfseries` before -2ex after 0.5ex; subsection `\normalsize\bfseries`; subsubsection `\normalsize\mdseries` |
| appendix | lay_d2.tex:9; refman.dtx:2499-2502 | `num.appendix` | `\appendix`, letters for `\thesection` |
| lists | layout_d.tex:127-159 (enumerate), 289-303 (itemize), 202-251 and lay_d2.tex:19-90 (description) | `list.kernel` | class `description` puts the label in the left margin, flags `\descriptioncolon`, `\descriptionleft` (refman.dtx:2311-2330); `\leftmargini` 2.5em, `\parsep` `\parskip`, `\topsep` and `\itemsep` 0 (refman.dtx:2103,2171-2174) |
| display lines | lay_d2.tex:94-102,108-115,119-124,670-673 | `quote.kernel` | `verse` environment lines ended with `\\*[2pt]` |
| manual spacing | lay_d2.tex:95-101; layout_d.tex:666,725 | `sp.manual-space` | `\\*[2pt]`, `\vspace{0pt plus 1cm}` |
| paragraph shape | refman.dtx:607-608 | `class.refart` | `\parskip` 0.5`\baselineskip` plus 2pt, `\parindent` 0 (class default, sample sets none) |
| page breaks | layout_d.tex:68,571,640; lay_d2.tex:4,460 | `pg.break` | `\newpage`, `\pagebreak[2]`, `\nopagebreak`, `\clearpage` |
| inline marks | layout_d.tex:55,78,174,224,271; lay_d2.tex:132-133 | `mark.kernel` | `\texttt`, `\textbf`, `\emph`, `{\it ..\/}`, `{\tt ..}`, `{\sc ..}`, `\textrm` |
| margin notes | layout_d.tex:83,137,190; lay_d2.tex:126,708-726; refman.dtx:3504-3539,3568-3574 | `note.marginpar` | `\marginlabel{..}` = `\marginpar{\raggedleft ..}`, `\seealso{..}` = `\marginpar{\small $\rightarrow$ ..}`, `\attention[sym]` = `\marginpar{\raggedleft sym}`; class `\@addmarginpar` puts every note in the left margin |
| attention symbol | lay_d2.tex:711,718,726 | `class.refart` | `\renewcommand{\attentionsymbol}{..}` and the optional argument: strings (class parameter, default `\large\bfseries ! $\rightarrow$`) |
| footnotes | layout_d.tex:186-188,196-197,258-260; refman.dtx:3426-3429,3478-3484 | `fn.kernel` | `\footnote`; class footnote rule 0.4 column width, text unindented with 1em first-line indent |
| wide page | lay_d2.tex:141,463; refman.dtx:3628-3643 | `class.refart` | `fullpage` environment: `\clearpage`, text width = `\fullwidth`, left note column 0, no `\marginpar` |
| wide block | lay_d2.tex:755-759; refman.dtx:3614-3627 | `class.refart` | `maxipage` environment: full-width minipage with rules above and below (`\maxipagerule` true) |
| math | layout_d.tex:230,653-655 | `math.kernel` | inline `$..$`, `displaymath`; `$\rightarrow$` in class macros |
| verbatim | layout_d.tex:90,537-540,572-577,590-601 | `code.verbatim` | `\verb`, `verbatim` |
| cross references | layout_d.tex:138,162; lay_d2.tex:367,775-776 | `xref.kernel` | `\label`, `\ref`, `\pageref` |
| figure float | lay_d2.tex:363-457; refman.dtx:2725-2745 | `fig.graphicx` | kernel `figure` only (no `\includegraphics`, no graphicx loaded); default placement `tbp`; sits inside `fullpage` |
| caption | lay_d2.tex:366-367; refman.dtx:2831-2851 | `cap.kernel` | `\caption{Seiten-Layout}`; class: centred if one line, else paragraph; `\abovecaptionskip` 10pt |
| figure block | lay_d2.tex:369-370 | `sp.ragged` | `center` environment |
| figure type size | lay_d2.tex:370 | `font.size-commands` | `small` environment |
| file inclusion | layout_d.tex:775 | `struct.input` | `\input lay_d2` (plain TeX syntax, one file name) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\cs` robust alias | layout_d.tex:16 | yes | `\texttt{\char`\\name}`: `mark.kernel` span with a backslash character; inline expansion |
| `\bs` | layout_d.tex:17 | yes | defined, never called (grep: one hit) |
| `\zB`, `\dH` | layout_d.tex:18-19 | yes | text abbreviations `z.\,B.` and `d.\,h.`, expand inline |
| `\attentionsymbol` redefinitions | lay_d2.tex:711,718 | yes | change of a class-native parameter string (`class.refart`) |
| `\X` | lay_d2.tex:146 | yes | `{#1}\index{{#1}}`, text plus `idx.makeidx`; defined, never called with an argument |
| `\NAMEBOX` `\HARROW` `\VARROW` `\VRULE`, `\newcount\T`, constants and `\xdef` sums, `\ifthenelse` | lay_d2.tex:151-361 (macros 162-207, `\ifthenelse` at 171,174,186,189,200,203) | content, not template | Wrappers over `picture` commands (`\put` `\framebox` `\vector` `\line` `\makebox`); every `\xdef` is arithmetic on literal numbers (lay_d2.tex:234-276), so each value is a constant; they build the page-layout diagram inside a `figure`. Carried with the figure as Content-opaque; `\VRULE` is never called |
| class internals redefined (`\@addmarginpar`, `\@makecaption`, `\@makefntext`, `\@startsection` calls) | refman.dtx:3504-3539,2831-2851,3478-3484,2019-2069 | not counted | published class (CTAN, TeX Live): one way `class.refart`; the source was read and holds no `\RequirePackage` or external tool |
| `pagepc.sty` | pagepc.sty:31-93 | not loaded, out of scope | zip file of the bundle; the sample never loads it; it needs `\chapter` (pagepc.sty:31-39), so it cannot load under `refart`; it redefines `\@chapter`, `\appendix`, `\@wrindex` (pagepc.sty:43-52,81-93), which would be irreducible kernel hooks if loaded |
| `refman.ins` | refman.ins:17-43 | yes | docstrip script that writes `refart.cls` and `refrep.cls` from `refman.dtx`; TeX only |

## Content-opaque
- Page-layout diagram: `picture` in `figure` at lay_d2.tex:372-454 with its helper macros (lay_d2.tex:146-361); way `art.pstricks` (picture environment) used as content, not as the template's identity.
- `ifthen` (layout_d.tex:12) serves only the `\ifthenelse` calls of those helpers; no component way (a load-only logic package; considered, not proposed).
- Verbatim listings of class and kernel code (layout_d.tex:572-577, 590-601, 681-687, 702-706, 716-722, 742-752, 755-757) and `\verb` spans.
- Logos `\LaTeX`, `\LaTeXe`, `\TeX`, index entries (`\index{..}`), `german` shorthand text.

## Lib changes
- New ways proposed: none (the `ae` face uses `font.serif-pkg`; the margin commands use `note.marginpar`; the wide-page environments are class vocabulary under `class.refart`)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
