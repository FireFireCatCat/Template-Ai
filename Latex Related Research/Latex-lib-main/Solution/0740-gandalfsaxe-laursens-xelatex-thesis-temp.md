no

# 0740-gandalfsaxe-laursens-xelatex-thesis-temp: Laursen's XeLaTeX thesis template (DTU Compute)

- Unverified: read from the source, not compiled.
- Source: Source/0740-gandalfsaxe-laursens-xelatex-thesis-temp/ (origin: https://codeload.github.com/gandalfsaxe/laursens-xelatex-thesis-template/zip/refs/heads/master; licence: not established)
- Kind: thesis
- Lib: v5
- Engine: needs XeLaTeX (`fontspec` preamble/fonts.tex:5, `polyglossia` preamble/general.tex:95, `\RequireXeTeX` preamble/general.tex:8, Thesis.tex:1)
- Look carried by: preamble (memoir is loaded unchanged; the look is set in preamble/general.tex with memoir's own API, plus preamble/fonts.tex, preamble/dtucolors.sty and the hand-laid pages in prefrontmatter/)
- Class origin: tex-distribution-unbundled (memoir, CTAN; not in the zip, its source was not read)
- Main file: Thesis.tex (other samples: none; the chapters, front matter and appendix are `\include`d from chapters/, frontmatter/, appendices/, prefrontmatter/)
- Read: main yes, zip-local classes and styles all (the only zip-local style is preamble/dtucolors.sty; the preamble/*.tex files are `\input` and were read in full)

## Verdict
The class is the published memoir, and most of the preamble is memoir's own API (page layout, page styles, chapter style, captions), `fontspec`, `listings`, `biblatex`, `cleveref` and `todonotes`, all of which map to lib ways. It is a `no` because general.tex patches memoir internals (`\leavespergathering`, `\@memensuresigpages`) and redefines `\@memb@bchap`, wraps `todonotes` with a counter-driven conditional that reads its internals, and draws two TikZ/`picture` marks (a confidential stamp and a crop mark) that no declarative lib way holds. Both marks are switched off by default, but the template defines them. No `EXTERNAL` blocker: biber and `latexmk` are the ordinary `biblatex` toolchain (`bib.biblatex-biber`).

## Blockers
- `BESPOKE/preamble` memoir-internal patches that pad the book to whole gatherings and put the DTU frieze on the padding pages: `\patchcmd{\leavespergathering}{\ifnum\@memcnta<\tw@}{\ifnum\@memcnta<\@ne}` with a nested `\patchcmd{\@memensuresigpages}{\repeat}{\repeat\frieze}` (preamble/general.tex:303-310); runs unconditionally, edits code from memoir.dtx, no lib way expresses it
- `BESPOKE/preamble` `\renewcommand{\@memb@bchap}` replaces memoir's internal bibliography-heading macro (phantomsection, `\addcontentsline`, `\chapter*`, `\bibmark`, `\prebibhook`) (preamble/general.tex:247-256)
- `BESPOKE/preamble` todo layer: `\todo` and `\missingfigure` re-defined with a hand-rolled `todocounter` (`totcount`) and a section-number prefix, and `\mylistoftodos` prints the list only when `\if@todonotes@disabled` is false and `\totvalue{todocounter}>0`, reading `\@todonotes@todolistname` (preamble/general.tex:140-159; used at Thesis.tex:43)
- `ART/preamble` confidential stamp: a TikZ node (`very thick`, `rounded corners=2pt`, `rotate=-20`, tinted red, text `Confidential`) placed through `\put` and `eso-pic` shipout hooks (preamble/general.tex:265-278, 284-285); gated by `\confidential` (false by default, preamble/static.tex:23)
- `ART/preamble` crop mark: `\tmarktl` re-drawn with a `picture` of two `\line`s plus a jobname/date/time/page text (preamble/general.tex:52-62); gated by `\showtrims` (false by default, preamble/static.tex:20); borderline, a print aid more than identity, counted because the geometry is hand-drawn

## Class setting
- Class: `class.memoir` options: `\classfontsize` (10pt for b5paper, else 12pt, preamble/general.tex:5), `\papersize` (b5paper, preamble/static.tex:19), `twoside`, `showtrims`, `extrafontsizes` (preamble/general.tex:7)
- Class-native vocabulary used: `\frontmatter` `\mainmatter` `\backmatter` `\appendix` `\chapter` (Thesis.tex:36-54); `\makepagestyle` `\makeheadrule` `\makeevenhead` `\makeoddhead` `\makeevenfoot` `\makeoddfoot` `\makepsmarks` `\createmark` `\createplainmark` `\nouppercaseheads` `\copypagestyle` (preamble/general.tex:194-216); `\makechapterstyle` `\chapterstyle` `\chapnamefont` `\chapnumfont` `\chaptitlefont` `\printchaptername` `\printchapternum` `\printchapternonum` `\chapternamenum` `\afterchapternum` `\printchaptertitle` `\afterchaptertitle` `\beforechapskip` `\midchapskip` `\patchcommand` (preamble/general.tex:165-188); `\setsecheadstyle` `\setsubsecheadstyle` `\setsubsubsecheadstyle` (preamble/general.tex:219-221); `\setlrmarginsandblock` `\setulmarginsandblock` `\setheadfoot` `\settypeblocksize` `\setulmargins` `\setlrmargins` `\setmarginnotes` `\setheaderspaces` `\checkandfixthelayout` `\sideparmargin` `\pagebv` `\pageaiv` `\stockaiv` `\showtrimson` `\trimLmarks` (preamble/general.tex:10-72); `\hangcaption` `\captionnamefont` `\subcaptionlabelfont` `\captiontitlefinal` `\newsubfloat` (preamble/general.tex:113-120), `\subbottom` (chapters/Introduction.tex:50); `adjustwidth` `adjustwidth*` `\calccentering` (prefrontmatter/titlepage.tex:3-5; chapters/Introduction.tex:66); `\cleartoevenpage` `\clearforchapter` (Thesis.tex:32-42); `\HUGE` from `extrafontsizes` (preamble/general.tex:171); counter `maxsecnumdepth` (preamble/general.tex:131); `\RequireXeTeX` (preamble/general.tex:8)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | preamble/general.tex:7 | `class.memoir` | 10pt (b5paper) / 12pt, b5paper, twoside, showtrims, extrafontsizes |
| paper, size, sides | preamble/general.tex:5-7 | `page.class-options` | b5paper, 10pt, twoside |
| page geometry (b5 branch) | preamble/general.tex:13-19 | `page.memoir-layout` | `\pagebv`, `\setlrmarginsandblock{26mm}{20mm}{*}`, `\setulmarginsandblock{35mm}{30mm}{*}`, `\setheadfoot{8mm}{10mm}` |
| page geometry (a4 branch) | preamble/general.tex:22-31 | `page.memoir-layout` | `\pageaiv`, `\settypeblocksize{634pt}{448.13pt}{*}`, `\setulmargins{4cm}{*}{*}`, `\setlrmargins{*}{*}{0.66}`, `\setmarginnotes{17pt}{51pt}{\onelineskip}`, `\setheaderspaces{*}{2\onelineskip}{*}` |
| margin and head lengths | preamble/general.tex:17-19 | `sp.lengths` | `\headsep`=7mm, `\marginparwidth`=18mm, `\marginparsep`=2mm |
| layout check, side notes outer | preamble/general.tex:71-72 | `page.memoir-layout` | `\checkandfixthelayout`, `\sideparmargin{outer}` |
| trim marks on a larger stock | preamble/general.tex:35-49 | `page.memoir-layout` | `\showtrimson`, `\stockaiv`/`\stockaiii`, `\trimtop`, `\trimedge`, `\trimLmarks`, `\setmarginnotes{10pt}{95pt}{\onelineskip}` (conditional on `\showtrims`, off by default) |
| trim mark drawing | preamble/general.tex:52-68 | `art.pstricks` (ART blocker) | `\tmarktl` as `picture` with `\line`; `\tmarktm` `\tmarkml` `\tmarkmr` `\tmarkbm` emptied |
| header/footer | preamble/general.tex:193-213 | `hf.memoir-pagestyle` | `myruled`: head rule `\textwidth`/`\normalrulethickness`; even head `\thepage`..`\leftmark`, odd head `\rightmark`..`\thepage`, empty feet; `\hffont`=`\sffamily\small`; `cleared` copy; `plain` feet emptied |
| running marks | preamble/general.tex:200-210 | `hf.memoir-pagestyle` | `\makepsmarks`, `\nouppercaseheads`, `\createmark{chapter}{both}{shownumber}`, `\createmark{section}{right}`, plain marks for toc, lof, lot, bib, index, glossary |
| page style selection | preamble/general.tex:211; prefrontmatter/titlepage.tex:2; prefrontmatter/colophon.tex:2 | `hf.pagestyle-kernel` | `\pagestyle{myruled}`, `\thispagestyle{empty}` |
| page numbering by matter | Thesis.tex:30,36,45; preamble/general.tex:282 | `pgnum.pagenumbering` | `\pagenumbering{alph}` (prefrontmatter), roman in `\frontmatter`, arabic in `\mainmatter` |
| matter switches, appendix | Thesis.tex:36,45,51,54 | `num.appendix` | `\frontmatter` `\mainmatter` `\appendix` `\backmatter` (memoir) |
| clear-page commands | Thesis.tex:32,34,40,42 | `pg.break` | `\cleartoevenpage`, `\clearforchapter` |
| file inclusion | Thesis.tex:4-7,31-52 | `struct.input` | `\input` for preamble files, `\include` for pages and chapters |
| sans text face | preamble/fonts.tex:5-19 | `font.fontspec` | `\setsansfont[Ligatures=TeX,Extension=.otf,UprightFont=*-regular,BoldFont=*-bold,ItalicFont=*-italic,BoldItalicFont=*-bolditalic,Scale=0.8]{texgyreadventor}` |
| font sizes, families | preamble/general.tex:171-173,193; prefrontmatter/titlepage.tex:6,14-15 | `font.size-commands` | `\HUGE`, `\fontsize{54}{54}\selectfont`, `\fontsize{42}{42}\selectfont`, `\Huge`, `\LARGE`, `\Large` |
| font switches | preamble/general.tex:167,193; chapters/Introduction.tex:5-13 | `mark.kernel` | `\normalfont\sffamily`, `\sffamily`, `\textbf`, `\textsf`, `\textit`, `\textsc`... |
| case change | preamble/general.tex:175,273 | `mark.case` | `\MakeUppercase` |
| microtypography | preamble/general.tex:75 | `sp.microtype` | defaults |
| colours | preamble/dtucolors.sty:1,4-23; preamble/general.tex:89,176,178 | `color.xcolor` | `\definecolor` cmyk values (dtured, dtugray, s01-s14, s14a), `\color{dtugray}`, `\color{dtured}` |
| frieze overlay | preamble/general.tex:290-299; prefrontmatter/colophon.tex:3 | `bg.eso-pic` | `\AddToShipoutPicture*` with `\put(0,0)` `\parbox[b][\paperheight]{\paperwidth}` and `\includegraphics[trim=130mm 0 0 0,width=0.9\textwidth]{DTU-frise-SH-15}` (`fig.graphicx`), `\vspace*{2.5cm}` |
| frieze on padding pages | preamble/general.tex:303-310 | none (BESPOKE blocker) | patches of `\leavespergathering` and `\@memensuresigpages` |
| language | preamble/general.tex:95-96 | `lang.polyglossia` | `\setdefaultlanguage{english}` |
| quotes | preamble/general.tex:97 | `lang.csquotes` | defaults |
| PDF metadata and links | preamble/general.tex:227-244 | `meta.hyperref` | `pdfauthor` `pdftitle` `pdfsubject` from the `\thesis*` macros, `pdfdisplaydoctitle`, `bookmarksnumbered`, `bookmarksopen`, `breaklinks`, `linktoc=all`, `plainpages=false`, `unicode=true`, `colorlinks=false`, `hidelinks` plus border colours |
| hyperref load | preamble/general.tex:85 | `meta.hyperref` | `unicode=false,psdextra` |
| URL breaking | preamble/general.tex:84 | `meta.url` | `hyphens` |
| bibliography | preamble/general.tex:100-105; Thesis.tex:9,55 | `bib.biblatex-biber` | `backend=biber,style=alphabetic,abbreviate=false,dateabbrev=false,alldates=long`, `\addbibresource`, `\printbibliography`; `\DeclareSourcemap` URL clean-up (Thesis.tex:13-26) is biblatex's own declarative command |
| cross-references | preamble/general.tex:112,123-126; chapters/Introduction.tex:25 | `xref.cleveref` | `noabbrev,nameinlink,capitalise`, `\crefformat{equation}{(#2#1#3)}`, `\crefrangeformat`, `\crefmultiformat` |
| labels | chapters/Introduction.tex:30,42 | `xref.kernel` | `\label`, `\ref` through `\cref` |
| float placement | preamble/general.tex:108 | `fig.placement` | `flafter` |
| figure float | chapters/Introduction.tex:26-31 | `fig.graphicx` | `figure`, `\centering`, `\caption[short]{long}` |
| sub-floats | preamble/general.tex:116-117; chapters/Introduction.tex:48-61 | `cap.memoir` | `\newsubfloat{figure}` `\newsubfloat{table}`, `\subbottom[..]{..}`, `\subcaptionlabelfont{\bfseries}` |
| captions | preamble/general.tex:113-120 | `cap.memoir` | `\hangcaption`, `\captionnamefont{\bfseries}`, `\captiontitlefinal{.}` |
| table | chapters/Introduction.tex:35-43 | `tbl.tabular` | `tabular` with column spec `c`, rule, `r`, `l` (the rule is a spec character) |
| lists | chapters/Introduction.tex:4-14; chapters/LongTitle.tex:10-20 | `list.kernel` | `itemize` |
| math | preamble/general.tex:76; chapters/Introduction.tex:19-21 | `math.mathtools` | `mathtools` loaded; `equation*` is `amsmath` |
| units | preamble/general.tex:81 | `mark.siunitx` | `siunitx` loaded, not used in the body |
| code listings | preamble/etc.tex:19-42; chapters/Introduction.tex:66-83,128-145 | `code.listings` | `\lstset{basicstyle=\footnotesize\ttfamily,breaklines=true,captionpos=b,frame=single,language=Python,numbers=left,numbersep=5pt,numberstyle=\sffamily\tiny\color{dtugray},keywordstyle=\bfseries\ttfamily\color{s09},commentstyle=\color{s14a},stringstyle=\color{s07},rulecolor=\color{dtugray},tabsize=2,title=\lstname,escapeinside={\%*}{*)},...}` |
| listing indent into margin | chapters/Introduction.tex:66,83 | `page.adjustwidth` | `adjustwidth*{0cm}{-0.4cm}` |
| algorithm | preamble/etc.tex:6-7; chapters/Introduction.tex:88-112 | `alg.algorithmicx` | `algorithm` + `algpseudocode`, `\State` `\For` `\EndFor` `\Comment` `\Return` |
| todo notes | preamble/general.tex:139,160-161; chapters/Introduction.tex:23,25 | `note.todonotes` | `colorinlistoftodos`, `disable` when `\showtodos` is false, `\lesstodo`/`\moretodo` as `\todo[color=green!40]`/`red!40` aliases |
| todo wrapper layer | preamble/general.tex:134,140-159 | none (BESPOKE blocker) | `\newtodo`, `\newmissingfigure`, `\mylistoftodos` |
| placeholders, filler text | preamble/etc.tex:5; Thesis.tex:48; chapters/Introduction.tex:28 | `draft.todo` | `blindtext` `\blinddocument`; `\missingfigure` is `todonotes` |
| title page | prefrontmatter/titlepage.tex:2-26; Thesis.tex:31 | `front.titlepage-env` | hand-laid page (no `\maketitle`): `\thispagestyle{empty}`, `\calccentering{\unitlength}`, nested `adjustwidth*` and `adjustwidth{-0.5cm}{-0.5cm}`, `flushright` degree lines, `\vspace*{\fill}`, `\includegraphics[width=0.75\textwidth]{DTU-Compute-B-UK}`, `\HUGE`/`\Huge`, `\parbox[b]{0.5\linewidth}`, `\hfill\includegraphics[scale=0.7]{DTU-logo-CMYK}`; fields from `\def` in static.tex:9-17 |
| title page geometry | prefrontmatter/titlepage.tex:3-5,23-24 | `page.adjustwidth` | `adjustwidth*{\unitlength}{-\unitlength}`, `adjustwidth{-0.5cm}{-0.5cm}` |
| spacing, alignment | prefrontmatter/titlepage.tex:7-22; prefrontmatter/colophon.tex:4,10 | `sp.manual-space` | `\vspace*{\fill}`, `\\*[1.2cm]`, `\hfill`, `\\[0.5cm]`, `\vspace*{2.5cm}` |
| colophon page | prefrontmatter/colophon.tex:2-19; Thesis.tex:33 | `front.dedication` | `\frieze`, bold department lines, address block, `\small` |
| abstract | frontmatter/Abstract.tex:2; Thesis.tex:37 | `head.memoir-style` | `\chapter{Abstract}` in `\frontmatter` (unnumbered by memoir); no `abstract` environment |
| preface | frontmatter/Preface.tex:2-15; Thesis.tex:38 | `front.dedication` | `\chapter{Preface}`, `\vfill`, `\centering`, signature image `\includegraphics[scale=0.4]{Signature}`, `flushright` author |
| acknowledgements | frontmatter/Acknowledgements.tex:2; Thesis.tex:39 | `front.dedication` | `\chapter{Acknowledgements}` |
| contents | Thesis.tex:41; preamble/general.tex:129,257-261 | `toc.kernel` | `\tableofcontents`, `tocdepth`=1; wrapper reduces by inline expansion (see Bespoke code) |
| heading depth | preamble/general.tex:129-131 | `num.secnumdepth` | `tocdepth`=1, `secnumdepth`=2, `maxsecnumdepth`=3 |
| chapter style | preamble/general.tex:165-190 | `head.memoir-style` | `\makechapterstyle{mychapterstyle}` on `\chapterstyle{default}`; `\beforechapskip`=0mm, `\midchapskip`=1ex; name `\HUGE`, number 54pt, title 42pt, all `\normalfont\sffamily`; name upper-cased and `dtugray`, number `dtured`; title printed with `\raggedleft`; after title `\vskip0.5\onelineskip \hrule \vskip1.3\onelineskip` |
| chapter rule | preamble/general.tex:187 | `sp.rule` | bare `\hrule` between `\vskip`s |
| section heads | preamble/general.tex:219-221 | `head.memoir-style` | `\setsecheadstyle{\huge\sffamily\raggedright}`, `\setsubsecheadstyle{\LARGE...}`, `\setsubsubsecheadstyle{\Large...}` |
| sectioning in body | chapters/Introduction.tex:2,45,63 | `head.kernel` | `\chapter`, `\section`, `\subsection`; long title with `\texorpdfstring` (chapters/LongTitle.tex:4) |
| ragged | preamble/general.tex:186,219; prefrontmatter/titlepage.tex:7 | `sp.ragged` | `\raggedleft`, `\raggedright`, `flushright` |
| confidential stamp | preamble/general.tex:265-286 | `bg.eso-pic` + `art.tikz` (ART blocker) | `\AddToShipoutPictureBG{\confidentialbox{10}}`, `\AddToShipoutPictureFG*{\confidentialbox{100}}`, `vplace`, `\scalebox{1.3}`, TikZ node |
| prefrontmatter switch | preamble/general.tex:281-287 | `pgnum.pagenumbering` | `\pagenumbering{alph}` plus the stamp switch (resolved at emit time) |
| engine marker, linter | preamble/general.tex:2,8 | none (no printed effect) | `nag` with `l2tabu,orthodox`, `\RequireXeTeX`: load-only checks, like the rejected `sys.compat-load` |
| counters packages | preamble/general.tex:134 | `num.counters` | `totcount`, used only by the todo layer |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\patchcmd` of `\leavespergathering` and `\@memensuresigpages` | preamble/general.tex:303-310 | no | Edits memoir.dtx internals so that a one-leaf gathering is allowed and `\frieze` runs on each padding page; no lib way can express this. BESPOKE/preamble |
| `\renewcommand{\@memb@bchap}` | preamble/general.tex:247-256 | no | Overwrites memoir's internal bibliography heading; the visible part (a toc entry, an unnumbered chapter, `\bibmark`) is memoir's `\bibintoc`/`\chapter*` territory, but the macro itself is a kernel-internal redefinition. BESPOKE/preamble |
| `\newtodo`, `\newmissingfigure`, `todocounter`, `\mylistoftodos` | preamble/general.tex:134-159 | no | Counter-driven prefix and a conditional that reads `todonotes` internals and an aux-based total. BESPOKE/preamble |
| `\lesstodo`, `\moretodo` | preamble/general.tex:160-161 | yes | Aliases of `\todo[color=green!40,..]` and `\todo[color=red!40,..]` (`note.todonotes`); they inherit the todo-layer blocker through `\todo` |
| `\confidentialbox` and its use | preamble/general.tex:265-286 | no | TikZ-drawn stamp, `art.tikz` used for template identity. ART/preamble |
| `\tmarktl` redefinition | preamble/general.tex:52-62 | no | `picture` crop mark with text, `art.pstricks`. ART/preamble (borderline) |
| `\frieze` | preamble/general.tex:290-299 | yes | `bg.eso-pic` `\AddToShipoutPicture*` around an `fig.graphicx` image with trim and width, a body call at colophon.tex:3 |
| `\newtableofcontents` | preamble/general.tex:257-261 | yes | Inline: `\phantomsection\addcontentsline{toc}{chapter}{\contentsname}\tableofcontents*` (`meta.hyperref`, `toc.kernel`) |
| `\papersizeswitch`, `\classfontsize`, `\showtrims` switches | preamble/general.tex:4-5,35-38 | yes | Constant-string conditionals; an emitter picks the branch (b5paper here) and prints that `page.memoir-layout` block |
| `\prefrontmatter` | preamble/general.tex:281-287 | yes except the stamp | `\pagenumbering{alph}`; the `\confidential` branch is the ART item above |
| `\def\thesis*` fields, `\def\papersize` | preamble/static.tex:9-23 | yes | Strings and switches; content and parameters |
| `dtucolors.sty` | preamble/dtucolors.sty:1-23 | yes | `\RequirePackage{xcolor}` and `\definecolor` calls (`color.xcolor`) |
| chapter-style hooks (`\def\format`, `\patchcommand`, `\renewcommand*{\printchapternonum}`) | preamble/general.tex:167,176,178-182 | yes | Memoir's published chapter-style hook API (`head.memoir-style`); `\@chapapp` is a kernel macro, `\patchcommand` is memoir's own |

## Content-opaque
none (the `\missingfigure` placeholders and the listing text are content; the shipped PDFs graphics/DTU-Compute-B-UK.pdf, DTU-logo-CMYK.pdf, DTU-frise-SH-15.pdf and Signature.pdf are images the emitter must ship)

## Lib changes
- New ways proposed: none (`nag` considered and not proposed: a load-only linter with no printed effect; `etoolbox` `\patchcmd` is the bespoke patch above, not a component)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
