yes

# 0241-smflatex: smflatex (SMF classes `smfart` / `smfbook`, packages `smfthm` / `smfenum`, BibTeX styles)

- Unverified: read from the source, not compiled.
- Source: Source/0241-smflatex/ (origin: https://mirrors.ctan.org/macros/latex/contrib/smflatex.zip; licence: lppl1.3c)
- Kind: journal
- Lib: v3
- Engine: pdfLaTeX-compatible
- Look carried by: mixed (the published class `smfart` carries title block, abstracts, headings, lists, bibliography, theorems; the sample preamble adds a first-page copyright footer, `\tolerance` values and alias macros)
- Class origin: ctan
- Main file: smf-fdoc.tex (other samples: smf-edoc.tex, the same document in English; its preamble differs only at smf-edoc.tex:1,27,28,35)
- Read: main yes, zip-local classes and styles partly (the zip holds no .cls or .sty, only the DocStrip source smflatex.dtx and smflatex.ins; read in full: smflatex.ins, smf-fdoc.tex, smf-edoc.tex, README; smflatex.dtx lines 1-3125 and 4305-4404, i.e. `smfart` and `smfbook` code, `smfhyperref`, `smfthm`, `smfenum`, head of `smfgen`, `smfbull`; not read: the rest of `smfgen` and the journal styles `asterisque` `bulletin` `courspe` `courspeedp` `documents` `memoires` `panoramas` `seminaires`, `smfmulti`, `smfbib`, `smfbourbaki`, `upitparen`, and the two .bst bodies, smflatex.dtx:3125-4304 and 4405-8531; none is loaded by the sample)

## Verdict
yes. The look is carried by `class.smfart`, a published class (CTAN package `smflatex`, also in TeX Live, from the Societe mathematique de France; `smfart.cls` is generated from smflatex.dtx by smflatex.ins:39-43), with its sibling package `smfthm` and published `babel`, `fontenc`, `amssymb`, `url`, `xspace`. Every sample-local macro (aliases, the `\ps@copyright` footer, `\tolerance`, two string slots) reduces to lib ways; there is no artwork and no tool outside TeX. The yes counts the class's hand-rewritten internals (`\@startsection` smflatex.dtx:1566, `\@sect` :1610, `\@maketitle` :1252, `\@makecaption` :2346-2376, `\@begintheorem` :2430) as the published class way `class.smfart`, not as zip-local bespoke code; read as zip-local they would be BESPOKE/class. The sample is a user's guide, so it shows no figure, float, display equation or index.

## Blockers
none

## Class setting
- Class: `class.smfart` options: `11pt,francais` (smf-fdoc.tex:1). Class defaults from `\ExecuteOptions{leqno,centertags,a4paper,portrait,10pt,twoside,onecolumn,final,francais}` (smflatex.dtx:798-801). Other options the class declares: `letterpaper`, `draft` (black overfull rules), `reqno`, `fleqn`, `boldmath`, `12pt`, `14pt`, `english` (smflatex.dtx:631-794). `smfart` does not load `article`; it loads `amsgen`, `amsfonts`, `amsmath`, `amsthm` and, if present, `multicol` (smflatex.dtx:260, 809-810, 2386, 2223).
- Class-native vocabulary used by the sample: `\title`, `\author`, `\date`, `\address`, `\email`, `\urladdr`, `\keywords` (smf-fdoc.tex:27-35); `abstract` and `altabstract` environments before `\maketitle` (:40-49); `\tableofcontents` (:51); `\Subsection`, `\Subsection*` (:82, :374); `\smaller[3]` (:662); the name slots `\smfbyname` (:38) and `\refname` (:677); page style `copyright` (:11-12). Described but only shown in verbatim: `\alttitle`, `\altkeywords`, `\subjclass`, `\translator`, `\dedicatory`, `\frontmatter` `\mainmatter` `\backmatter`, `\appendix`, `\bibliographystyle{smfplain|smfalpha}` (smf-fdoc.tex:322-372, 461, 473).
- Sibling package `smfthm` (smf-fdoc.tex:6; smflatex.dtx:2792), vocabulary of the same house kit, recorded here: environments `theo` `prop` `conj` `coro` `lemm` `defi` `rema` `exem` on one counter `smfthm` reset per `section`, `\NumberTheoremsIn`, `\NumberTheoremsAs`, `\SwapTheoremNumbers`, `\NoSwapTheoremNumbers`, generic `enonce` and `enonce*` (smflatex.dtx:2836-2904). The sample uses `conj` (smf-fdoc.tex:559-562).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | smf-fdoc.tex:1; smflatex.dtx:247 | `class.smfart` | `11pt`, `francais` |
| paper and size | smf-fdoc.tex:1; smflatex.dtx:631, 751 | `page.class-options` | `a4paper` (class default), `11pt`; the 13 cm x 21.5 cm text block is fixed inside the class (smflatex.dtx:434-435, 487) |
| running heads | smflatex.dtx:547-554, 2696 | `hf.class-native` | page style `headings`: bold page number and `\leftmark`/`\rightmark` in `\normalfont\scriptsize`, empty foot |
| first-page footer | smf-fdoc.tex:10-13; used by smflatex.dtx:1252 | `hf.pagestyle-kernel` | kernel `\ps@copyright` redefinition on top of `\ps@empty`: right-aligned `\small\copyright 1997, \SMF` in `\@oddfoot` (reduction written under Bespoke code) |
| title block | smf-fdoc.tex:27-35, 38, 49; smflatex.dtx:1252-1282, 1307-1317 | `front.class-native` | `\title` `\author` `\date` `\address` `\email` `\urladdr`; boxed 55 mm head with rules, bold upper-case title, author line; `\smfbyname` emptied; date, address, e-mail and URL printed at document end by `\AtEndDocument{\smf@enddoc}` |
| abstracts | smf-fdoc.tex:40-48; smflatex.dtx:1078-1084, 1147-1160, 1182-1201 | `abs.class-native` | `abstract` (French) and `altabstract` (English) set in `\footnotesize`, margins `\abstractmargin`=1cm, run-in head with dash |
| keywords | smf-fdoc.tex:35; smflatex.dtx:1022-1027, 1299 | `abs.keywords` | class `\keywords{}`, printed as a first-page footnote |
| contents | smf-fdoc.tex:51; smflatex.dtx:1962-1986, 2126-2133 | `toc.kernel` | `\tableofcontents`; look and indents are the class's (`tocdepth`=1, dotted leaders) |
| headings | smf-fdoc.tex:53, 82, 164, 374; smflatex.dtx:1849-1871 | `head.class-native` | `\section` bold centred; `\subsection` bold run-in; `\Subsection` bold display; number then `.` and an enspace (smflatex.dtx:1630-1635) |
| heading depth and counters | smflatex.dtx:1685, 1953, 1689-1706 | `num.secnumdepth` | `secnumdepth`=5, `tocdepth`=1 |
| section counters | smflatex.dtx:1689-1706 | `num.counters` | `\thesection` arabic, `\thesubsection` = section.sub |
| bullet lists | smf-fdoc.tex:84-112, 120-126; smflatex.dtx:1460-1471 | `list.kernel` | `itemize`; level-1 label bold `--`; list margins set at `\begin{document}` (smflatex.dtx:1518-1532) |
| verse blocks | smf-fdoc.tex:322-372, 379-384; smflatex.dtx:1477-1480 | `quote.kernel` | `verse`, indent -1.5em |
| indented group | smf-fdoc.tex:326 | `sp.lengths` | `{\advance\leftskip 1.5em ...}` |
| centred blocks | smf-fdoc.tex:443-453, 535-550 | `sp.ragged` | `center` environment |
| simple tables | smf-fdoc.tex:444-452, 535-550 | `tbl.tabular` | `tabular{ll}`, `tabular{lccc}`; row rules by `\noalign{\hrule height .08em\vskip.65ex}` |
| table rules and gaps | smf-fdoc.tex:536-549 | `sp.rule` | bare `\hrule height .08em` and `.05em` |
| table row gaps | smf-fdoc.tex:536-549, 61, 276 | `sp.manual-space` | `\vskip.65ex`, `\vskip .4ex`, `\smallskip`, `\medskip`, `\bigskip` |
| text marks | smf-fdoc.tex:17, 303, 329 | `mark.kernel` | `\scshape`, `\textsl`, `\emph`, `{\em }`, `{\it }`, `\texttt` |
| verbatim | smf-fdoc.tex:78, 86 | `code.verbatim` | `\verb\|...\|` |
| theorem statements | smf-fdoc.tex:6, 559-562; smflatex.dtx:2501-2510, 2857-2882 | `thm.class-native` | `smfthm` env `conj` with optional note `[Fermat]`; style `plain` from the class: bold italic head, `\MakePointrait` dash, no pre/post skip; shared counter `smfthm` reset per section, `\NoSwapTheoremNumbers` |
| proof | smf-fdoc.tex:521-523, 513; smflatex.dtx:2468-2492 | `thm.amsthm` | `proof[Idee de la demonstration]`, `\qedsymbol`; the class re-defines `proof` over `amsthm` (smflatex.dtx:2386) |
| inline maths | smf-fdoc.tex:19, 146, 154 | `math.kernel` | `$...$`, `\mathcal`, `\cdots`, `\langle` |
| maths packages | smflatex.dtx:809-810; smf-fdoc.tex:6 | `math.amsmath` | loaded by the class with `leqno` (smflatex.dtx:658-659); no display equation in the sample |
| symbol fonts | smf-fdoc.tex:6 | `math.amssymb` | `\usepackage{amssymb}` |
| encoding | smf-fdoc.tex:3 | `font.fontenc-t1` | `[T1]`; no text-font package, so the default Computer Modern family (EC fonts under T1) |
| size commands | smf-fdoc.tex:12, 662; smflatex.dtx:342-352, 370-386 | `font.size-commands` | `\small`; class `\larger[n]` / `\smaller[n]` over the 11pt size table (smflatex.dtx:751-758) |
| language | smf-fdoc.tex:4; smflatex.dtx:2600-2633 | `lang.babel` | `[english,francais]`, French main language; French `\og` `\fg` (smf-fdoc.tex:80, 132); class adds caption names by `\addto\captionsfrench` |
| URLs | smf-fdoc.tex:6, 391, 700 | `meta.url` | `\usepackage{url}`, `\url\|...\|` |
| line breaking | smf-fdoc.tex:23-24 | `sp.hyphenat` | `\tolerance 400`, `\pretolerance 200` (the parameters `\sloppy` sets, smflatex.dtx:2292); discretionary `\-` in `\SmF` (smf-fdoc.tex:15) |
| class penalties and stretch | smflatex.dtx:405-407, 2702 | `sp.penalties` | `\widowpenalty`, `\clubpenalty`, `\brokenpenalty` = 10000 set by the class; `\emergencystretch 2em` is `sp.lengths` |
| no-break after table head | smf-fdoc.tex:534 | `sp.penalties` | `\par\nobreak` (`\nobreak` is `\penalty10000`) |
| bibliography | smf-fdoc.tex:677-735; smflatex.dtx:2150-2213 | `bib.thebibliography` | `thebibliography{99}` with `\bibitem`, title slot `\refname` set by `\def`; the class sets label width from the aux file, items in `\small` |
| citations | smf-fdoc.tex:239, 311 | `bib.thebibliography` | `\cite[Appendix B]{lamport94}` with the class's `\@cite` (bold key in brackets, smflatex.dtx:2187) |
| cross references | smf-fdoc.tex:59, 316, 479, 525, 627 | `xref.kernel` | `\label`, `\ref` |
| inline-macro spacing | smf-fdoc.tex:6, 21 | `NEW:sp.xspace` | `\usepackage{xspace}`, `\xspace` in `\resp` |

Not exercised by the sample, so no row: floats and captions (`\@makecaption`, smflatex.dtx:2346), index (`theindex`, :2232), `\appendix` (:1811), `\footnote` as such, hyperref (`smfhyperref` loads only when `hyperref` is present, :2690), BibTeX styles `smfplain.bst`, `smfalpha.bst` (`bib.bibtex-bst`; shown only in verbatim, smf-fdoc.tex:473).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\meta`, `\myast` | smf-fdoc.tex:8-9 | yes | `\newcommand` aliases over `math.kernel` (`$\langle$ $\rangle$`, `$\star$`) and `mark.kernel` (`\it`) |
| `\ps@copyright` override | smf-fdoc.tex:10-13 | yes | kernel page style `copyright` (`hf.pagestyle-kernel`): `\ps@empty` plus `\@oddfoot{\hfil\small\copyright 1997, \SMF}`; equal to `hf.fancyhdr` `\fancypagestyle{copyright}{\fancyhf{}\fancyfoot[R]{\small\copyright\ 1997, SMF}}`. Overrides the class default `\let\ps@copyright\ps@empty` (smflatex.dtx:577) and is selected by `\thispagestyle{copyright}` inside the class `\@maketitle` (smflatex.dtx:1252) |
| `\SmF`, `\SMF` | smf-fdoc.tex:15-16 | yes | text aliases with `\-` discretionary hyphens (`sp.hyphenat`) |
| `\BibTeX`, `\T`, `\AMS` | smf-fdoc.tex:17-20 | yes | aliases over `mark.kernel` (`\scshape`), `sp.manual-space` (`\kern`, `\lower` as `\raisebox`) and `math.amssymb` (`\mathcal`) |
| `\resp` | smf-fdoc.tex:21 | yes | `\emph{resp}.` plus `NEW:sp.xspace`; or expanded inline with no package |
| `\tolerance`, `\pretolerance` | smf-fdoc.tex:23-24 | yes | `sp.hyphenat` integer parameters |
| `\def\smfbyname{}` | smf-fdoc.tex:38 | yes | sets the class's "by" name slot (`par`/`by`, smflatex.dtx:2548, 2587) to empty: a string parameter of `class.smfart`, read at smflatex.dtx:1269 |
| `\def\refname{...}` | smf-fdoc.tex:677; smf-edoc.tex:602 | yes | string slot of `bib.thebibliography` (class default `R\'ef\'erences`, smflatex.dtx:2565) |
| class `smfart` internals | smflatex.dtx:247-2703 | not counted | published class (CTAN, TeX Live): the way is `class.smfart`; see Verdict |
| package `smfthm` internals | smflatex.dtx:2792-2912 | not counted | published package of the same CTAN bundle (generated by smflatex.ins:47); its `enonce` environment re-declares `smfenonce` with `\newtheorem` at each use (smflatex.dtx:2893-2904), recorded as house vocabulary under `thm.class-native` |

## Content-opaque
none

## Lib changes
- New ways proposed: `NEW:sp.xspace` `xspace` (LaTeX tools bundle on CTAN; pdfLaTeX): load-only package whose `\xspace` at the end of a macro body adds a space unless punctuation or a closing token follows; `\xspaceaddexceptions{tokens}` is the one extension point. W1 published (tools bundle); W2 no options, the exception list is a token list; W3 serves any macro, not one document; W4 a preamble `\usepackage{xspace}` plus the command at the end of a macro body. Home searched and rejected: `sp.manual-space` (lengths and kerns set by hand), `sp.frenchspacing` (a space-factor switch), `sp.ellipsis` (names an `xspace` option only for `\dots`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
