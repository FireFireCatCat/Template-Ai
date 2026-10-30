no

# 0176-presentations: Präsentationen mit LaTeX (DANTE-Edition example files, H. Voß)

- Unverified: read from the source, not compiled.
- Source: Source/0176-presentations/ (origin: https://mirrors.ctan.org/info/examples/Presentations_de.zip; licence: lppl1.3, repeated in each example header, 01-01-1.ltx2crop:8-12)
- Kind: presentation
- Lib: v3
- Engine: pdfLaTeX-compatible for the `.ltx`, `.ltx2`, `.ltxb`, `.ltx2crop` files (README:3-6); the 64 `.ltxps` `.ltx2ps` `.ltxbps` `.ltxpd` files are run latex -> dvips -> ps2pdf (README:7-10, see Blockers). README:11-13 also names `xltx`, `lux`, `ltxE` runs; no such file is in the zip.
- Look carried by: mixed (about 230 independent book examples; each sample's look comes from a published presentation class (beamer in 144 files, powerdot in 54, plus prosper, foils, seminar, slidenotes, FUbeamer, FUpowerdot) and from its own preamble overrides; no zip-local class or style file)
- Class origin: tex-distribution-unbundled (beamer, powerdot, prosper, foils, seminar, slidenotes ship with TeX Live/CTAN; FUbeamer, FUpowerdot and the BerlinFU theme/style are on CTAN as `beamer-fuberlin` and `powerdot-fuberlin`, ctan.org pages read; none of them is bundled here; `articlereport` has no source anywhere, see Blockers)
- Main file: none single. The manifest names images/beamer/beamernavsymbols.tex (40 lines, a figure-source for one beamer navigation-symbol picture). The real samples are the numbered files `NN-NN-N.ltx*` (other samples: 01-01-6.ltx2, 02-10-6.ltxpd, 04-20-4.ltxb, 04-25-4.ltxb, 05-02-1.ltxb, 07-05-1.ltxbps; fragments `beamer-demo.tex`, `beamer-demo2.tex`, `pd-demo.tex`, `pd-demo-default.tex`, `Textdemo.tex` have no `\documentclass` and are `\input` by the examples, e.g. 04-25-5.ltxb:31, 02-14-1.ltxpd:29)
- Read: main partly (all 7 top-level and images `.tex` files in full; every `.ltx`, `.ltx2*`, `.ltxps`, `.ltxpd` and `.ltxbps` example read by preamble and command lines; all `.ltxb` preambles via a deduplicated scan plus the body command lines of 04-01 to 05-03; the prose text and the 18 near-identical style/theme wrappers 02-14-3..16, 04-25-6..37, 04-26-* only by their `\use...theme`/`\input` lines), zip-local classes and styles none present (no `.cls` `.sty` `.def` `.cfg` `.bst` in the zip)

## Verdict
No. The zip is a book's collection of one-off examples, and four of them redefine the internals of published classes or packages (pdfscreen panel in 01-01-6.ltx2, powerdot TOC macros in 02-10-6.ltxpd and 03-03-2.ltxpd) or write a data file at compile time (02-08-1.ltxpd), which are irreducible bespoke code. Several powerdot template definitions are drawn with PSTricks (`ART`), 64 files need the dvips/ps2pdf toolchain, and two helpers (`articlereport`, `sem-dem`) have no source to analyse. The beamer, powerdot-option and xcolor files alone would map to lib ways (`class.beamer`, `slide.beamer-*`, `color.xcolor`), so this is evidence about the class dimension plus a few real blockers, not about the component ways.

## Blockers
- `BESPOKE/preamble` pdfscreen navigation panel rebuilt by hand: `\font\CVxx=contnav`, `\def\NavigationPanel`, `\long\def\panel` with `\if@paneltoc`, `\def\@panel`, `\long\def\chapter` (01-01-6.ltx2:37-129)
- `BESPOKE/preamble` powerdot internals redefined: `\def\pd@tocslide`, `\pd@tocdisplay`, `\pd@tochighlight` with `\ifx\@tempa\empty` branches (02-10-6.ltxpd:27-39); `\def\pd@tocsimple#1#2` with `\settowidth` and `\@tempdima` arithmetic (03-03-2.ltxpd:38-52)
- `BESPOKE/preamble` compile-time file writer: `\newwrite`, `\immediate\openout\TimeLineFile=sinus.txt`, `\multido` of `\immediate\write` lines, feeding `animate` `timeline=` (02-08-1.ltxpd:24-30, 37)
- `ART/preamble` template-defining PSTricks drawing inside `\pddefinetemplate`: green and blue bars `\psframe*` (02-10-1.ltxpd:22-28), grey full-slide fill (02-10-3.ltxpd:22-30), blue rules `\psline` (03-03-1.ltxpd:32-35), shaded side panel plus rules and `\rput` (03-03-3.ltxpd:25-45), logo placed by `\rput[lt]` in a template (02-01-3.ltxpd:33-35)
- `ART/preamble` navigation symbol drawn with `pgfpicture` by `\def\insertdocappnavigationsymbol` (images/beamer/beamernavsymbols.tex:8-13)
- `EXTERNAL/class` the zip's own run recipe sends every `.ltxpd` (55 files, powerdot), `.ltxps`, `.ltx2ps` (incl. prosper with `pdf,ps2pdf`, 01-01-5.ltx2ps:17) and `.ltxbps` through latex -> dvips -> ps2pdf (README:7-10), not pdfLaTeX; the lib change log keeps this as an EXTERNAL/class note for prosper-type classes
- `EXTERNAL/package` `pstricks`, `pst-node`, `pstricks-add` (PostScript output path) loaded by 04-06-4.ltxbps:22, 07-05-1.ltxbps:27, 07-05-2.ltxbps:24, 02-04-2.ltxpd:26, 06-01-1.ltx:26
- `EXTERNAL/preamble` pdfcrop post-processing of the PDF (01-01-1.ltx2crop:20, 01-01-2.ltx2ps:20, README:6)
- `UNMAPPED/class` `articlereport` (01-01-6.ltx2:17): no source in the zip and ctan.org/pkg/articlereport answers 404
- `UNMAPPED/package` `sem-dem` and its commands `\SeminarOutlinePresentation`, `\SeminarHeader`, `\HLe`, `\DingListSymbolA` (01-01-2.ltx2ps:27-31, 39): not bundled, publication not established, so no reduction can be written
- Missing assets, not blockers: font `contnav` (01-01-6.ltx2:37), font family `dante` (02-07-1.ltxpd:25), `buch.bib` (02-12-1.ltxpd:30, 04-25-2.ltxb:30), `polylog-Typo-Art.mp4` (images/beamer/multimedia.tex:7)

## Class setting
- Class: `class.beamer` options (through `\PassOptionsToClass` or `[..]`): `ngerman` (01-02-1.ltxb:17), `12pt` (05-00-1.ltxb:17), `size=12pt`, `t`, `t,smaller,compress` (05-01-1.ltxb:17), `xcolor={table,dvipsnames}` and `hyperref={bookmarks,colorlinks}` (04-01-1.ltxb:17), `width=1.75cm` (05-03-1.ltxb:17), `presentation` (04-24-2.ltxb:17), `dvips` (04-06-4.ltxbps:17)
- Class: `class.powerdot` options: `size=12pt|11pt`, `paper=screen|a4paper`, `mode=present`, `display=slidesnotes|notes`, `style=` simple, aggie, bframe, ciment, clemson, elcolors, fyma, horatio, husky, ikeda, jefka, klope, paintings, pazik, sailor, tycja, upen, BerlinFU (02-14-1.ltxpd:17 to 02-14-18.ltxpd:17), `nopagebreaks`, `blackslide`, `fleqn`, `hlsections` (02-10-6.ltxpd:17), `ngerman`; the 55 `.ltxpd` files
- Class: `class.prosper` `slideColor,colorBG,time,pdf,ps2pdf` (01-01-5.ltx2ps:17); `class.foils` `20pt` (01-01-3.ltx2:17), `landscape` (01-01-4.ltx2:17); `class.seminar` `landscape,rules` (01-01-2.ltx2ps:17); `class.slidenotes` `landscape,rules` (01-01-1.ltx2crop:17); `class.fubeamer` (05-01-1.ltxb:18); `class.fupowerdot` `english,ngerman` (03-01-1.ltxpd:17); `class.article` in 24 files (01-03-3.ltx:17, `a5paper,12pt` 04-03-2.ltx2:17)
- Class-native vocabulary used: beamer `frame` (`[plain]` `[t]` `[fragile]` `[allowframebreaks]` `<1-2>` `[label=]`, 05-00-1.ltxb:26, 04-05-1.ltxb:26), `\frametitle` `\framesubtitle` `\titlepage` `\title[short]` `\subtitle` `\institute` `\inst` `\and` `\titlegraphic` `\logo` (04-04-1.ltxb:26-36), `\section<presentation>*` `\part<presentation>` (beamer-demo.tex:3,9), `columns`/`column` (04-14-1.ltxb:27), `block` `alertblock` `exampleblock` (04-11-3.ltxb:29-35), `theorem` `proof` `example` with overlay and name (04-07-1.ltxb:27-33), `beamercolorbox` (04-11-1.ltxb:29), `\hyperlink` `\hypertarget` `\beamergotobutton` (04-15-1.ltxb:33), `\note`, `\mode<article>`, `\animate`/`\animatevalue` (04-09-1.ltxbps:29-31), `\movie` (images/beamer/multimedia.tex:7); powerdot `slide` `wideslide` `emptyslide` `blackslide` `note` (02-03-2.ltxpd:26, 02-03-3.ltxpd:26, 02-03-4.ltxpd:25, 02-13-3.ltxpd:25), `\pdsetup{lf,rf,logohook,logopos,logocmd,trans}` (02-01-3.ltxpd:30), `\pddefinetemplate` (02-10-5.ltxpd:23), `\twocolumn{..}{..}` (02-06-1.ltxpd:28), `\onslide{1-2}{..}` `\onslide*` `\onslide+` (02-04-4.ltxpd:36), `\item<2->`, `itemize[type=1]` (02-04-3.ltxpd:26), `\fachbereich` `\titlegraphic` (03-01-1.ltxpd:29-30); prosper `\overlays{3}{..}` `\fromSlide*` `\slideCaption` `\institution` (01-01-5.ltx2ps:24-31); foils `\foilhead` `\leftheader` `\rightheader` `\Restriction` (01-01-3.ltx2:27-37); seminar `\slideheading` (01-01-2.ltx2ps:38); slidenotes `slide[title]` `\slidesubtitle` (01-01-1.ltx2crop:32,39)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | 04-01-1.ltxb:17-18 and 143 more `.ltxb`/`.ltxbps` files | `class.beamer` | see Class setting |
| class | 02-01-1.ltxpd:17 and 53 more `.ltxpd` files | `class.powerdot` | see Class setting |
| class | 01-01-5.ltx2ps:17; 01-01-3.ltx2:17; 01-01-2.ltx2ps:17; 01-01-1.ltx2crop:17 | `class.prosper`, `class.foils`, `class.seminar`, `class.slidenotes` | one sample each, options above |
| class | 05-01-1.ltxb:18; 03-01-1.ltxpd:17 (not bundled; CTAN `beamer-fuberlin`, `powerdot-fuberlin`) | `class.fubeamer`, `class.fupowerdot` | `english,ngerman`; `\titlegraphic`, `\fachbereich` |
| class | 01-03-3.ltx:17 (24 files), 04-03-2.ltx2:17 | `class.article` | `[]`, `a5paper,12pt` |
| page size and margins | 02-01-2.ltxpd:17 (`paper=a4paper`), 02-01-1.ltxpd:17 (`paper=screen`) | `page.class-options` | powerdot `paper=` |
| page margins | 04-03-1.ltxb:23 (`\mode<article>`) | `page.vmargin` | `fullpage` |
| page margins | 07-03-1.ltx:23 | `page.setlength` | `\textwidth=200pt` |
| screen page and side panel | 01-01-6.ltx2:21, 134, 136 | `page.pdfscreen` | options `pdftex,screen,rightpanel,code,paneltoc,sectionbreak`; `\panelwidth=3.5in`, `\margins{.75in}x4`, `\screensize{220mm}{297mm}`, `\paneloverlay{..}`, `\overlay{..}`; the panel body itself is bespoke (Blockers) |
| running heads and feet | 02-01-2.ltxpd:26; 01-01-3.ltx2:27 | `hf.class-native` | powerdot `lf=ZEDAT,rf=FU-Berlin`; foils `\leftheader` `\rightheader` |
| page style, page number | 01-01-1.ltx2crop:18-19 | `hf.pagestyle-kernel`, `pgnum.pagenumbering` | `\pagestyle{empty}`, `\setcounter{page}{6}` |
| beamer footline, header, logo | 04-12-2.ltxb:23-31; 04-20-4.ltxb:25-47; 04-08-1.ltxb:23-27 | `slide.beamer-template` | `footline`, `frametitle` (with `beamercolorbox` `wd=\paperwidth,ht=4.5ex`), `logo`, `sidebar left`, `navigation symbols` set to empty |
| beamer themes | 04-03-1.ltxb:26; 04-06-9.ltxb:22; 04-08-1.ltxb:23; 04-25-5.ltxb:24 | `slide.beamer-theme` | `\usetheme` Warsaw, Malmoe, Hannover, Antibes, PaloAlto, BerlinFU (05-02-1.ltxb:23)...; `\usecolortheme` dove, crane, dolphin, rose; `\useoutertheme[width=42pt,left]{sidebar}`; `\useinnertheme` circles, inmargin; `\usefonttheme[onlysmall]{structurebold}` |
| beamer colour, font, size, template | 01-04-5.ltxb:19-20; 04-20-4.ltxb:22-24; 04-20-1.ltxb:22-23; 04-22-3.ltxb:32; 04-11-2.ltxb:31-34 | `slide.beamer-template` | `\setbeamercolor*{background canvas}{bg=black!30}`, `{normal text}{fg=white}`, `\setbeamerfont{titlelike}{series=\bfseries}`, `\defbeamertemplate{list item}{rarrow}`, `bibliography item` `[triangle]` `[article]` `[book]`, `blocks` `[rounded][shadow=true]`, `\setbeamersize{text margin left=10pt}` (04-20-2.ltxb:25), `\setbeamercovered{transparent}` (04-06-5.ltxb:28) |
| slide background | 04-03-1.ltxb:25; 04-19-2.ltxb:26-28; 04-20-5.ltxb:36, 42 | `slide.beamer-template` | `background canvas` `[vertical shading][bottom=red!10,top=blue!10]`; `\includegraphics[width=\paperwidth,height=\paperheight]{TU}`; `background` `[grid][step=0.5cm,color=red!20]` |
| draft canvas text | 04-20-5.ltxb:28-29 | `bg.watermark` | reduction: text `DRAFT`, colour `gray!20`, angle 45, scale 5 (now `\put` + `\rotatebox` + `\scalebox` inside a `background canvas` template) |
| overlays and modes | 04-06-2.ltxb:31, 43; 04-16-1.ltxb:27; 04-06-11.ltxb:27; 04-25-2.ltxb:23; 04-24-2.ltxb:27-35; 04-03-2.ltx2:23-28 | `slide.beamer-mode` | `\pause`, `\only`, `\onslide<..>`, `\uncover`, `\visible`, `\alert<>`, `[<+->]`, `[<+-\| alert@+>]`, `\beamerdefaultoverlayspecification{<+->}`, `\mode<article>`/`<presentation>`, `beamerarticle[envcountsect]` |
| notes | 04-21-1.ltxb:22,29-36; 04-21-4.ltxb:22-29; 04-23-2.ltxb:22-23 | `slide.beamer-mode`, `pg.pgfpages` | `\setbeameroption{show notes}`, `{show notes on second screen=right}`, `{previous slide on second screen=left}`, `\note<1-2>[item]{..}`, `\setbeamertemplate{note page}[plain]`, `\AtBeginNote{\insertslideintonotes{0.25}}` |
| section hook | 04-03-1.ltxb:35-36; 04-13-2.ltxb:35-37 | `slide.beamer-section-hook` | `\AtBeginSubsection[]{frame with \tableofcontents[current,currentsubsection]}`, `\AtBeginSection{.. [currentsection]}` |
| overlay package for foils/seminar | 01-01-4.ltx2:23, 29-47 | `slide.texpower` | `\usepackage[display]{texpower}`; body `\pause`, `\stepwise{}`, `\parstepwise{}`, `\step{}`, `\restep{}`, `\switch{}{}` |
| overlays (other classes) | 02-04-4.ltxpd:36-48; 01-01-5.ltx2ps:31-42 | `class.powerdot`, `class.prosper` | `\onslide{1-2}{..}`, `\onslide*`, `\onslide+`, `\item<2->`; `\overlays{3}{..}`, `\fromSlide*{n}{..}` |
| title block | 04-04-1.ltxb:26-38; 03-01-1.ltxpd:24-31; 01-01-5.ltx2ps:24-30; 01-01-3.ltx2:24-31 | `front.class-native` | beamer `\title[Beamer]`, `\author[Voß]{..\inst{1} \and ..}`, `\institute[FU-Berlin]`, `\date[\TeX\ 2010]`, `\frame{\titlepage}`; powerdot `\subtitle` `\institute` `\titlegraphic` `\fachbereich` `\maketitle`; prosper `\subtitle` `\email` `\institution` `\slideCaption`; foils `\maketitle` |
| title block | 01-01-1.ltx2crop:26-31 | `front.maketitle` | `\title \author \date{\today} \maketitle` |
| abstract | 01-01-3.ltx2:32-35 | `abs.kernel` | `abstract` env |
| contents | 04-03-1.ltxb:33-36; 02-02-1.ltxpd:23; 02-03-1.ltxpd:25-26 | `front.class-native` | beamer `\tableofcontents[part=1,pausesections]`, `[current,currentsubsection]`; powerdot slide options `toc=`, `toc={Folie 1}`, `bm=F1`; `\tableofcontents` |
| headings | beamer-demo.tex:3,9,11,35; 04-13-1.ltxb:26,35; 02-04-4.ltxpd:34 | `head.class-native` | `\section`, `\subsection[short]{..}`, `\section<presentation>*`, `\part<presentation>`, `\frametitle{}` |
| lists | 04-16-1.ltxb:27; 01-03-2.ltxb:32; 02-04-3.ltxpd:26; beamer-demo.tex:22-33 | `list.kernel` | `itemize`, `enumerate`, `description[<+-\| alert@+>]` (04-13-2.ltxb:56), custom labels `\item[$\bigoasterisk$]`, `\parskip=1.5ex` |
| list environment | 04-20-1.ltxb:24-25, 36 | `list.kernel`, `slide.beamer-template` | kernel `\list{\usebeamertemplate{list item}}{\usecounter{bcnt}}`, `\addtobeamertemplate{list item}{\thebcnt: }{}` |
| blocks, theorems | 04-11-3.ltxb:29-35; 04-07-1.ltxb:27-33; 04-25-4.ltxb:22-29; beamer-demo2.tex:94, 104 | `thm.class-native`, `num.counters` | `block`, `alertblock`, `exampleblock`, `theorem<1->[Pythagoras]`, `proof<2>`, `example<3>[..]`; numbered definitions by `\newcounter{definition}[section]`, `\resetcounteronoverlays`, `\setbeamertemplate{theorem begin}` |
| coloured boxes | 04-11-1.ltxb:28-35 | `slide.beamer-template` | `beamercolorbox[sep=1em,wd=5cm]{BoxFarbe}`, `beamerboxesrounded[upper=headerCol,lower=bodyCol,shadow=true]` |
| columns | 04-14-1.ltxb:27-43; 07-03-4.ltxb:31-37; 02-06-1.ltxpd:28 | `cols.minipage` | beamer `columns[b]`/`column{.4\textwidth}` (built on minipages by the class); powerdot `\twocolumn{..}{..}` |
| math | 02-01-2.ltxpd:21, 34; 04-25-1.ltxb:28-33; beamer-demo.tex:14-18 | `math.amsmath` | `amsmath` `align`, `\tag`, `\notag`, `\underset`, `\label{green}` |
| math symbols | 02-01-2.ltxpd:21; 01-03-2.ltxb:20 | `math.amssymb` | package is the parameter: `esint` (`\iiint` `\oiint`, in 97 files), `mathabx` (`\bigoasterisk`, `\blacktriangleright`); this stretches the line's `amssymb`/`amsfonts` to other math-symbol packages |
| equation layout | 02-01-1.ltxpd:17 | `math.eqnumber` | powerdot option `fleqn` |
| tables | 04-06-2.ltxb:29, 43; 04-06-3.ltxb:30; 04-01-1.ltxb:17 | `tbl.tabular`, `tbl.colortbl` | `array` columns `>{\ttfamily}l`, `l<{\onslide<2->}`; class option `xcolor=table` |
| images | 04-19-1.ltxb:27-29; 02-03-3.ltxpd:26-27; 04-20-4.ltxb:36-37 | `fig.graphicx` | `\includegraphics<1->{..}`, `width=\slidewidth,height=\slideheight`; `emptyslide` holds the image; `\pgfdeclareimage`/`\pgfuseimage` (04-12-2.ltxb:23-27, 04-19-1.ltxb:31) reduces to `\includegraphics` |
| code | 02-04-1.ltxpd:23, 27; 02-04-2.ltxpd:31-39; beamer-demo2.tex:55; 02-07-1.ltxpd:31 | `code.listings`, `code.verbatim` | `lstlisting` `basicstyle=\ttfamily\small`, `escapechar=\|`, `language=[LaTeX]TeX`, `xrightmargin=-2cm`, `literate=`; `semiverbatim`, `verbatim`; frame option `[fragile]` |
| bibliography | 04-22-2.ltxb:31-40; beamer-demo2.tex:173-175; 02-12-2.ltxpd:30-36 | `bib.thebibliography` | `thebibliography{99}`, `\bibitem<2->[Voß, 2010]{..}`, `\beamertemplatebookbibitems` |
| bibliography | 02-12-1.ltxpd:30; 04-25-2.ltxb:30 | `bib.bibtex-bst` | `\bibliographystyle{plain}`, `\bibliography{buch}` (BibTeX run, `.bib` not shipped) |
| cross-references, links | 02-01-2.ltxpd:34-38; 04-15-1.ltxb:33-36; 04-15-2.ltxb:36 | `xref.kernel`, `xref.hyperref` | `\label{green}` `\ref`, `\label<3>{Marke}`, `\hyperlink`/`\hypertarget`/`\beamergotobutton` |
| PDF options | 04-01-1.ltxb:17; 01-01-2.ltx2ps:28; 01-01-4.ltx2:23 | `meta.hyperref`, `meta.url` | `hyperref={bookmarks,colorlinks}`, `\hypersetup{pdfpagemode=UseOutlines}`; `url` |
| language, encoding | 01-02-1.ltxb:17; 02-01-2.ltxpd:22; 05-02-1.ltxb:19-20 | `lang.babel`, `font.fontenc-t1` | `ngerman`, `english,ngerman`; `inputenc` `utf8` (195 files), `fontenc` `T1` |
| fonts | 01-01-1.ltx2crop:22; 02-04-4.ltxpd:21; 02-07-1.ltxpd:24; 06-01-1.ltx:24; 07-05-1.ltxbps:22-23; 01-01-6.ltx2:23 | `font.helvet`, `font.mono`, `font.libertine`, `font.family-default` | `helvet[scaled]`; `luximono[scaled]`, `beramono`; `libertine[scaled=1.05]`; `\familydefault=\sfdefault` |
| font switching | 05-02-1.ltxb:29; 02-07-1.ltxpd:25; 04-06-10.ltxb:19; 01-03-1.ltxb:28 | `font.nfss`, `font.size-commands` | `\fontfamily{zapfino}\selectfont`, `\usefont{OT1}{dante}{m}{n}`; `\AtBeginDocument{\Large}`, `\tiny` |
| colour | 06-01-3.ltx:22-27; 06-01-4.ltx:23-26; 06-01-5.ltx:24-28; 06-05-1.ltx:25-31; 06-04-1.ltx:23 | `color.xcolor` | `dvipsnames,prologue`, `\definecolor` (cmyk, named, gray, HTML), `\colorlet`, `\definecolorset`, `\providecolorset`, `\definecolorseries`, `\resetcolorseries`, `\convertcolorspec`, `\textcolor`, `\colorbox`, `\fcolorbox` |
| framed boxes in colour demos | 06-04-2.ltx:27-28; 06-04-3.ltx:26 | `box.fancybox` | `\colorbox`, `\fcolorbox`, `\fboxsep=10pt`, `\fboxrule=6pt` |
| spacing, alignment | 06-01-1.ltx:20; 01-03-1.ltxb:42; 05-00-1.ltxb:28-40; 01-03-2.ltxb:34; 07-03-4.ltxb:24, 36; 01-03-3.ltx:26 | `sp.lengths`, `sp.manual-space`, `sp.ragged`, `sp.rule` | `\parindent=0pt`, `\parskip=1.5ex`; `\vfill`, `\vspace{-\fill}`, `\vspace{\textheight}`; `\raggedleft`, `ragged2e` `\RaggedRight`; `\rule{1cm}{1cm}` |
| page assembly | 04-21-2.ltxb:22; images/beamer/beamernavsymbols.tex:5 | `pg.pgfpages`, `pg.include-pdf` | `pgfpages` for second-screen notes; `pdfpages` loaded (its `\includepdf` call is commented out, :16) |
| footnote | 01-01-2.ltx2ps:43 | `fn.kernel` | `\footnote` (inside `\VerbatimFootnotes`, `sem-dem`) |
| PSTricks overlays in slides | 02-04-2.ltxpd:35, 48; 07-05-1.ltxbps:36-78 | `art.pstricks` | content in a slide body (see Content-opaque); inside `\pddefinetemplate` it is `ART` (Blockers) |
| pgf drawing | images/beamer/beamernavsymbols.tex:9-12 | `art.tikz` | `pgfpicture` for a navigation symbol: `ART`, listed in Blockers |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| pdfscreen panel (`\NavigationPanel`, `\panel`, `\@panel`, `\chapter`, font `contnav`) | 01-01-6.ltx2:37-129 | no | hand-built boxes with `\Acrobatmenu`, `\if@paneltoc`, `\ifnum\thepage` button states; BESPOKE/preamble |
| `\pd@tocslide`, `\pd@tocdisplay`, `\pd@tochighlight` | 02-10-6.ltxpd:27-39 | no | replaces powerdot's own TOC drawing with PSTricks circles and `\psframebox` |
| `\pd@tocsimple` | 03-03-2.ltxpd:38-52 | no | `\settowidth` and `\@tempdima` arithmetic inside the class's TOC |
| `\newwrite` timeline file | 02-08-1.ltxpd:24-30 | no | writes `sinus.txt` while compiling |
| template drawings (`\psframe*`, `\psline`, `\rput`) | 02-10-1.ltxpd:25-27; 02-10-3.ltxpd:29; 03-03-1.ltxpd:34-35; 03-03-3.ltxpd:36-45; 02-01-3.ltxpd:34-35 | no | ART/preamble; 02-10-2.ltxpd:23-25 (`\rput{45}` `\psscalebox{7}{Entwurf}` in `\color{black!10}`) alone would reduce to `bg.watermark` |
| `\def\insertdocappnavigationsymbol` | images/beamer/beamernavsymbols.tex:8-13 | no | `pgfpicture` with beamer's internal `beamerdocnavstrong` objects |
| `\newcommand*\Q`, `\diff` | beamer-demo.tex:1; 02-01-2.ltxpd:23-24 | yes | aliases for `\frac{\partial}{\partial}` and `\mathop{}\!\mathrm{d}` (`math.amsmath`) |
| `\newcommand\GreenI`, `\GreenII` | 02-04-5.ltxpd:28-37 | yes | alias of a content `align` block |
| `\newcommand\bfrm`, `\Text`, `\bsp`, `\col`, `\CBox` | 04-06-2.ltxb:23; 04-06-5.ltxb:23; 07-03-2.ltx:25-26; 06-01-3.ltx:28; 06-01-2.ltx:23-25 | yes | text/colour aliases over `mark.kernel`, `color.xcolor`, `\xspace` |
| `\AtBeginDocument{\renewcommand\today{..}}`, `\newcommand\Datum[1][\today]` | 02-04-2.ltxpd:22-24 | yes | date text alias (`front.datetime` `\newdateformat`) |
| `\newcommand\DANTE{..\usefont{OT1}{dante}{m}{n}..}` | 02-07-1.ltxpd:25 | yes | `font.nfss` call (font not shipped) |
| `\newcounter{definition}[section]` + `theorem begin` template | 04-25-4.ltxb:22-29 | yes | `num.counters` plus `thm.class-native` hook with `\refstepcounter`; one `\ifx\inserttheoremaddition\@empty` test taken from the beamer manual's own idiom |
| `\newenvironment{bList}` with `\list` and `\usecounter{bcnt}` | 04-20-1.ltxb:24-25 | yes | kernel list over beamer's list-item template: `list.kernel` + `slide.beamer-template` |
| `\newcommand*\bp{\thebeamerpauses}` | 04-16-3.ltxb:22 | yes | alias of a beamer counter (`slide.beamer-mode`) |
| `\newlength\offset`, `\newcount\Angle` | 04-09-1.ltxbps:23 | yes | registers for beamer's `\animatevalue` driving a PSTricks picture (Content-opaque) |
| `\def\ChartDemo`, `\pBox` | 07-05-2.ltxbps:25-39; 02-04-7.ltxpd:27 | yes | wrappers around PSTricks content (Content-opaque) |
| `\def\FileDate` `\FileInfoB` `\FileVersion`, `\MySeminarOutlinePresentation` | 01-01-2.ltx2ps:23-31 | no | call into unavailable `sem-dem`; UNMAPPED/package |

## Content-opaque
- PSTricks node overlays and plots in slide bodies: `\rnode`, `\nccurve`, `\psframebox` (02-04-2.ltxpd:35, 48; 02-04-7.ltxpd:27-55; 04-06-4.ltxbps:28-35), `pspicture` with `\psplot` `\psaxes` (04-09-1.ltxbps:32-37), process diagram with `\psshadowbox` and `\ncangle` (07-05-1.ltxbps:36-78), `\psChart` pie chart (07-05-2.ltxbps:25-56)
- Whole-sample pictures with no document around them: `pspicture` page-geometry drawing (02-06-2.ltxps:26-78), `pspicture` slide/output diagram (02-09-1.ltxps:28-43), `\psframebox` (06-02-1.ltxps:25-29)
- `animateinline` frames and `\multiframe` (02-08-1.ltxpd:37-49), considered: `animate` (a published package; the frames are PSTricks content and the timeline file is bespoke, so no way proposed)
- Picture-mode `\put` overlays on a column rule (04-14-1.ltxb:37, 41; 02-06-1.ltxpd:37, 40)
- `\movie[autoplay,width=200pt,height=150pt]` with a movie file that is not shipped (images/beamer/multimedia.tex:7)
- `multido` loops that generate colour swatches (01-03-3.ltx:26-28; 06-01-5.ltx:32-35; 06-01-6.ltx:31-37); considered: `multido` (a macro loop with no lib home; used only to make demo content)

## Lib changes
- New ways proposed:
  - `slide.texpower` `texpower` (CTAN `texpower`, Stephan Lehmke; ctan.org page not re-read here, listing from memory), pdfLaTeX-compatible: dynamic-presentation overlays for `foils`/`seminar`/article, body wrappers `\step{}` `\stepwise{}` `\parstepwise{}` `\restep{}` `\switch{}{}`, option `display`. W1 published on CTAN; W2 options and content arguments only; W3 serves any foils/seminar-style class (not one document); W4 one `\usepackage` line plus body wrappers. `slide.beamer-mode` is beamer-only, so it has no home.
  - `page.pdfscreen` `pdfscreen` (CTAN `pdfscreen`, ctan.org page not re-read here, listing from memory), pdfLaTeX-compatible: screen-format page with an optional side panel; options `screen` `rightpanel` `code` `paneltoc` `sectionbreak`, lengths `\panelwidth`, `\margins{..}x4`, `\screensize{w}{h}`, `\paneloverlay{file}`, `\overlay{file}`. W1 published on CTAN; W2 declarative options and lengths; W3 a kind of component (on-screen page layout); W4 preamble lines. Only its options are in the way; the hand-rebuilt panel in 01-01-6.ltx2:37-129 stays `BESPOKE/preamble`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
