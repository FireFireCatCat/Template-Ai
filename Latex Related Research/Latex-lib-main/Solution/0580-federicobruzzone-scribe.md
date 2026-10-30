no

# 0580-federicobruzzone-scribe: scribe (paper class, beamer theme, poster theme, CV class)

- Unverified: read from the source, not compiled.
- Source: Source/0580-federicobruzzone-scribe/ (origin: https://codeload.github.com/FedericoBruzzone/scribe/zip/refs/heads/main; licence: Apache-2.0 per the manifest, LICENSE-MIT also in the zip)
- Kind: poster
- Lib: v5
- Engine: needs XeLaTeX (the poster theme loads fontspec and unicode-math unconditionally, beamerthemescribeposter.sty:32-33; the paper, beamer and CV samples are pdfLaTeX-compatible)
- Look carried by: zip-local (colours, headline, footline and blocks are in beamerthemescribeposter.sty; the sample preamble adds only the poster size, one font, the logos and the headline text)
- Class origin: zip-local
- Main file: example-poster/main.tex (other samples: example/main.tex with example/sects/introduction.tex, example-beamer/main.tex, example-cv/main.tex)
- Read: main yes, zip-local classes and styles all

## Verdict
no. The zip is a GitHub repo of four templates (paper class `scribe.cls`, CV class `scribecv.cls`, beamer theme, poster theme); ctan.org/pkg/scribe is a 404 and the zip is not an official release, so all four are zip-local. Nearly everything reduces to lib ways (beamer templates, tcolorbox, fancyhdr, natbib, listings, tabularx), but `scribe.cls:67-73` replaces lineno's `\makeLineNumber` with a hook that measures a position with zref-savepos and picks the number's side from it; that is a hand-rolled conditional that drives what is printed, so it is irreducible. It runs under the `lineno` plus `twocolumn` options, which example/main.tex:19 uses; the poster sample does not load `scribe.cls`. In my reading the poster sample alone (example-poster/main.tex with beamerthemescribeposter.sty) has no irreducible item, no ART and no EXTERNAL; the `no` comes from the zip's other class and is tagged so it can be re-read with the poster only.

## Blockers
- `BESPOKE/class` `\makeLineNumber` redefined with `\zsavepos{scribeLN\thelinenumber}` and `\ifdim\zposx{scribeLN\thelinenumber}sp>0.5\paperwidth` choosing `\makeLineNumberRight` or `\makeLineNumberLeft`, two-pass, only when `lineno` and `twocolumn` are both set (scribe.cls:51-73; used at example/main.tex:19). lineno's own two-column handling is what the comment at scribe.cls:54-65 rejects, so no lib way holds this.

## Class setting
- Class: `class.beamer` options: `final` (example-poster/main.tex:2); other samples: `class.beamer` `aspectratio=169` (example-beamer/main.tex:1-3), `class.article` loaded by zip-local `scribe` with options `lineno`, `letterpaper`, `twocolumn` (scribe.cls:20-22,27-29; example/main.tex:17,19) and by zip-local `scribecv` with options `sectionfill`, `header` (scribecv.cls:23-26,31-33). The zip-local classes are not published, so they are not ways; they reduce to `class.article` plus the preamble ways below.
- Class-native vocabulary used: beamer `frame[t]`, `frame[plain,noframenumbering]`, `frame[fragile]`, `frame[allowframebreaks]`, `block`, `columns[T,totalwidth=]`, `column`, `\title[short]`, `\author[short]`, `\institute`, `\subtitle`, `\date`, `\titlepage`, `\sectionpage`, `\tableofcontents`; beamerposter keys `orientation` `size` `width` `height` `scale`; article `\maketitle`, `abstract`, `\twocolumn[...]`.

## Component map
Files named without a folder are at the zip root; their copies in example/, example-beamer/, example-cv/ and example-poster/ are byte-identical (SHA-256 compared). Rows are grouped: poster (main sample), paper, beamer, CV.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| (poster) document class | example-poster/main.tex:2 | `class.beamer` | `final` |
| poster size | example-poster/main.tex:8-15 | `poster.baposter` | beamerposter orientation=landscape, size=custom, width=170, height=110 (cm), scale=1.8 |
| theme, modes | example-poster/main.tex:17; beamerthemescribeposter.sty:25,345 | `slide.beamer-theme`, `slide.beamer-mode` | `\usetheme{scribeposter}` (zip-local, reduced in the rows below); `\mode<presentation>` ... `\mode<all>` |
| text and math font | beamerthemescribeposter.sty:32-41 | `font.fontspec`, `font.unicode-math` | `\setmainfont[Extension=.otf, UprightFont=LinLibertine_R, BoldFont=LinLibertine_RB, ItalicFont=LinLibertine_I, BoldItalicFont=LinLibertine_RBI]{LinLibertine}`; `\setmathfont[Extension=.otf]{LibertinusMath-Regular}` |
| beamer font themes | beamerthemescribeposter.sty:42-43,97 | `slide.beamer-theme` | `\usefonttheme{professionalfonts}`, `\usefonttheme{serif}`, `\useinnertheme{default}` |
| handwriting font | example-poster/main.tex:20-24; beamerthemescribeposter.sty:304 | `font.fontspec` | `\newfontfamily\caveatfont[Path=font/static/, UprightFont=Caveat-Regular.ttf, BoldFont=Caveat-Bold.ttf]{Caveat}`; `\fontcaveat` is `{\caveatfont #1}`; TTFs ship in example-poster/font/ |
| language | beamerthemescribeposter.sty:44 | `lang.babel` | english |
| colours | beamerthemescribeposter.sty:49-56 | `color.xcolor` | dvipsnames; scribeaccent=MidnightBlue; scribemuted=black!55; scribecomplement RGB 72,40,88; scribetertiary RGB 140,90,20 |
| beamer colours, page background | beamerthemescribeposter.sty:58-76 | `slide.beamer-template` | background canvas bg=black!2!white; structure fg=scribeaccent; alerted text Red; headline and footline bg=scribeaccent!20!white; block title bg scribecomplement, Red!85!black, ForestGreen!85!black |
| beamer fonts | beamerthemescribeposter.sty:81-92 | `slide.beamer-template` | headline title bold `\huge`, author and institute `\Large`, date `\LARGE`; block title bold `\Large`; footline `\normalsize`; caption `\sffamily\small`; footnote `\small` |
| item markers, caption template | beamerthemescribeposter.sty:98-104 | `slide.beamer-template` | itemize item `$\bullet$`, subitem `\textendash`, subsubitem `\textperiodcentered`; navigation symbols empty; caption "name number: text" |
| block look | beamerthemescribeposter.sty:106-130 | `slide.beamer-template`, `box.tcolorbox` | block, alertblock, exampleblock each a tcolorbox: colframe scribetertiary (Red!85!black, ForestGreen!85!black), colback white, colbacktitle 25% tint (40% for alert, example), coltitle black, arc=2mm, boxrule=0.6pt, toptitle=bottomtitle=0.5em, lefttitle=righttitle=0.7em, left=right=0.7em, top=bottom=0.6em; `\vskip0.8em` before, `\vskip0.5em` after; body `\parskip` 0.5em |
| block use | example-poster/main.tex:80-87,91-93,104-110,114-119,130-137,141-145 | `class.beamer` | native `block{Title}` environment |
| headline | beamerthemescribeposter.sty:164-195; example-poster/main.tex:29-30 | `slide.beamer-template`, `fig.graphicx`, `sp.manual-space`, `font.size-commands` | beamercolorbox wd=\paperwidth, `\vskip1.8cm`, columns 0.12/0.76/0.12 of \paperwidth: logo, title/author/institute/date, logo; `\includegraphics[height=9cm]{LLVM}` and `{MLIR}` |
| footline | beamerthemescribeposter.sty:204-224 | `slide.beamer-template` | beamercolorbox wd=\paperwidth, ht=3cm, dp=0pt; `\vbox to 3cm` centred; contact (else short author), short title, date joined by `\enspace\textbullet\enspace`; links black in a group |
| frame title | beamerthemescribeposter.sty:230 | `slide.beamer-template` | empty |
| title fields | example-poster/main.tex:32-41,58 | `front.class-native` | `\title[short]`, `\author[short]{A \and B}`, `\institute`, `\date`; printed by the headline template, no `\maketitle` call |
| headline text overrides | example-poster/main.tex:44-55,61-64; beamerthemescribeposter.sty:157-162,201-202 | `mark.kernel`, `color.xcolor`, `font.fontspec` | `\renewcommand{\posterauthordisplay}`, `\posterdatedisplay`, `\postercontact` hold `\textcolor{scribecomplement}{\textbf{..}}` and `\fontcaveat{..}`; reduced by inlining into the two templates |
| columns | example-poster/main.tex:71,73,78,102,128,152-153,171,192 | `class.beamer` | native `columns[T, totalwidth=\textwidth]`; widths 0.015/0.30/0.035/0.30/0.035/0.30/0.015 of \textwidth; nested `columns[T, totalwidth=\linewidth]` 0.47/0.06/0.47 (pdf-neutral alternative: `cols.minipage`) |
| column separator | beamerthemescribeposter.sty:294-300; example-poster/main.tex:97,123 | `sp.rule`, `color.xcolor`, `sp.manual-space` | column 0.035\textwidth, `\vskip0.3cm`, `\rule{0.8pt}{\dimexpr\paperheight - 28cm\relax}` in scribetertiary!60!white |
| body centring, gaps | beamerthemescribeposter.sty:143-145; example-poster/main.tex:68,70,89 | `sp.manual-space` | `\noindent\hspace*{-\beamer@leftmargin}`; `\vskip0.8cm` |
| lists | example-poster/main.tex:82-86,132-136 | `list.kernel` | itemize; markers from the template row above |
| dingbats | beamerthemescribeposter.sty:246-249; example-poster/main.tex:133-135 | `font.icons`, `color.xcolor` | `\ding{52}` and `\ding{56}` in ForestGreen, Red, scribeaccent |
| ORCID icon | beamerthemescribeposter.sty:241 | `font.icons` | `orcidlink` is loaded; `\orcidlink` is not called in the poster (called at example-beamer/main.tex:22,31 and example/main.tex:53); considered a new way, none needed: a logo-icon package is the parameter of `font.icons` |
| equation | example-poster/main.tex:106-108; beamerthemescribeposter.sty:239 | `math.amsmath`, `math.mathtools`, `thm.amsthm` | `equation*`; `amsmath,amsthm,mathtools` loaded (`amsthm` not used) |
| callout boxes | beamerthemescribeposter.sty:254-289; example-poster/main.tex:116-118 | `box.tcolorbox` | `\tcbset` style scribebox (arc=3mm, boxrule=0mm, leftrule=4mm, colback=white, colbacktitle=scribeaccent!15!white, coltitle=black, fonttitle=\bfseries, left=lefttitle=2.5mm, right=righttitle=2mm, top=bottom=1.5mm, toptitle=bottomtitle=1mm, title=#1) and scribeboxinline (on line, arc=2mm, boxrule=0pt, leftrule=3mm, fontupper=\bfseries, boxsep=0pt); `\newtcolorbox` and `\newtcbox` for info MidnightBlue, warn BrickRed, tip ForestGreen, note BurntOrange |
| QR link boxes | example-poster/main.tex:154-168,172-186 | `box.tcolorbox`, `fig.qrcode`, `meta.url`, `font.size-commands` | title bold centred, colframe=scribetertiary, colback=white, colbacktitle=scribetertiary!25!white, coltitle=black, arc=2mm, boxrule=0.6pt, toptitle=bottomtitle=0.4em, left=right=top=bottom=0.5em, halign=center; `\qrcode[height=4cm]{url}` and `\url` in `\footnotesize` |
| link colours | beamerthemescribeposter.sty:338-343; example-poster/main.tex:151 | `meta.hyperref` | colorlinks=true, linkcolor=citecolor=urlcolor=scribeaccent; sample adds `hidelinks` |
| references | example-poster/main.tex:141-145; beamerthemescribeposter.sty:242-243 | `bib.natbib`, `bib.bibtex-bst`, `sp.lengths`, `font.size-commands` | natbib `numbers,sort&compress`; `\bibsep` 4pt; `\bibliographystyle{unsrt}`, `\bibliography{local}` inside a block under `\footnotesize` |
| paragraph spacing | beamerthemescribeposter.sty:132 | `sp.lengths` | `\parskip` 0.5em |
| filler text, marks | example-poster/main.tex:26,81,33,37 | `draft.todo`, `mark.kernel` | `\lipsum[n][range]`; `\textbf`, `\textcolor` |
| loaded, not called by the poster | beamerthemescribeposter.sty:235-240 | `fig.graphicx`, `tbl.booktabs`, `tbl.tabular`, `code.listings` | graphicx, booktabs, array, listings |
| (paper) class and page | scribe.cls:27-29,34; example/main.tex:17,19 | `class.article`, `page.geometry`, `page.class-options`, `cols.twocolumn-option` | article 11pt; margins 2.5cm on all sides; letterpaper; twocolumn (one-column branch drops it) |
| paper fonts, language | scribe.cls:37,42-45,119 | `font.fontenc-t1`, `font.libertine`, `font.mono`, `lang.babel` | T1, utf8; libertine; inconsolata; babel greek,english; `pmboxdraw` (load-only box-drawing glyphs, considered `font.icons`) |
| paper header/footer | scribe.cls:229-235; example/main.tex:40 | `hf.fancyhdr` | `\fancyhf{}`; head L `\leftmark`, head R the stored string `\scribesetrightmark{Federico Bruzzone}`; foot C `\thepage`; `\headrulewidth` 0pt |
| line numbers | scribe.cls:51-52,75,325-329; scribe.cls:66-73 | `sp.draft-lineno`, `xref.zref` | lineno [left]; `\linenumberfont` `\normalfont\footnotesize\color{red}`; `\linenumbers` at begin document; the zref-savepos side chooser is the blocker |
| title block | example/main.tex:50-60,75-91; scribe.cls:344-347,354-356 | `front.maketitle`, `cols.twocolumn-cmd`, `front.titling` | `\title{\textbf{..}}`, `\author{.. \\ ..}` with `\orcidlink`, `\href`, `\url`, `\date`; `\twocolumn[\maketitle ...]`; kernel `\@maketitle` patched with `\vspace{-1.5cm}` (`\droptitle`) |
| abstract, index terms | scribe.cls:279-305; example/main.tex:63-71 | `abs.kernel`, `abs.keywords`, `box.minipage`, `sp.ragged`, `mark.kernel` | `center` + `minipage` 0.93\linewidth, bold "Abstract" or "Index Terms" then an em dash, `\itshape`; divider after index terms |
| paper headings | example/sects/introduction.tex:1 | `head.kernel` | plain `\section` and `\label`; no redefinition in scribe.cls |
| theorem-like boxes | scribe.cls:201-219; example/sects/introduction.tex:26-34 | `thm.tcolorbox`, `num.counters`, `xref.kernel` | one counter `scribethm` within section; Theorem, Lemma, Corollary, Proposition (MidnightBlue), Definition (ForestGreen), Example (BurntOrange), Remark (BrickRed); title "Heading n.m (note)"; breakable, scribeboxbase |
| callout boxes (paper) | scribe.cls:150-186; example/sects/introduction.tex:18-22 | `box.tcolorbox` | scribeboxbase arc=2mm, boxrule=0mm, leftrule=1mm, colbacktitle=black!10!white, small paddings; inline variant on line; breakable |
| code | example/main.tex:25-37; example/sects/introduction.tex:11-16 | `code.listings`, `cap.kernel`, `xref.kernel` | `\lstdefinestyle{scribe}`: `\ttfamily\small`, keywords MidnightBlue bold, comments black!55 italic, strings ForestGreen!70!black, numbers `\tiny` black!45, showstringspaces=false, breaklines=true, captionpos=b, aboveskip=1em, belowskip=0.5em; `lstlisting[language=C, caption, label]` |
| captions | scribe.cls:116-128 | `cap.caption`, `fig.float`, `fig.subcaption` | font=sf, labelfont=bf, labelsep=colon, justification=centering; float, subcaption loaded |
| math, footnote | example/sects/introduction.tex:3-9; scribe.cls:97 | `math.amsmath`, `math.amssymb`, `fn.kernel` | `equation*` with `cases` and `\text`; `\footnote` |
| paper links, bibliography | scribe.cls:35-36,130-135,320-322; example/main.tex:98 | `meta.hyperref`, `bib.natbib`, `bib.bibtex-bst`, `sp.lengths` | colorlinks, MidnightBlue; natbib numbers,sort&compress; bibsep 2pt; unsrt |
| paper lists, loaded extras | scribe.cls:98-101,107-108,113,120,138-141 | `list.enumitem`, `tbl.booktabs`, `tbl.tabular`, `color.xcolor`, `cols.multicol`, `font.icons` | enumitem [inline], itemize and enumerate noitemsep topsep=0pt, label (\roman*); booktabs, array, dvipsnames, multicol, pifont; none called by the sample |
| file inclusion, filler | example/main.tex:22,96; example/sects/introduction.tex:3 | `struct.input`, `draft.todo` | `\input{sects/introduction}`; `\lipsum` |
| (beamer) class, theme | example-beamer/main.tex:1-5; beamerthemescribe.sty:30-37,42-48 | `class.beamer`, `slide.beamer-theme`, `font.fontenc-t1`, `font.libertine`, `font.mono`, `lang.babel` | aspectratio=169; `\usetheme{scribe}` with options noframenumbers, nosectionpages; `\usefonttheme{serif}`; T1, utf8, libertine, inconsolata, babel greek,english |
| beamer colours, fonts, markers | beamerthemescribe.sty:59-113 | `color.xcolor`, `slide.beamer-template` | accent MidnightBlue; block title bg accent, body accent!6; alert Red, example ForestGreen; title bold `\LARGE`; itemize item `\blacktriangleright`; blocks [rounded][shadow=false]; toc sections [square]; navigation symbols empty |
| beamer title page, frame title | beamerthemescribe.sty:133-152,158-169; example-beamer/main.tex:38-40 | `slide.beamer-template`, `sp.rule`, `sp.manual-space` | centred title, optional subtitle, divider, author, institute, date; frame title bold with `\rule{\textwidth}{0.6pt}` in accent |
| beamer footline, section pages | beamerthemescribe.sty:176-210 | `slide.beamer-template`, `slide.beamer-section-hook` | two beamercolorbox halves wd=.5\paperwidth, `\scriptsize`, short author left, short title and "n / total" right; `\AtBeginSection[]` frame [plain,noframenumbering] with `\sectionpage` |
| beamer body | example-beamer/main.tex:45-47,58-65,75-100,105-123,147-150 | `toc.kernel`, `list.kernel`, `class.beamer`, `box.tcolorbox`, `math.amsmath`, `code.listings`, `bib.natbib`, `bib.bibtex-bst` | outline frame; nested itemize; columns 0.5/0.5 with info, warn, tip boxes and inline boxes; `cases`; lstlisting `\ttfamily\small`, keywords `\color{scribeaccent}\bfseries`, language=C; references frame allowframebreaks, unsrt |
| (CV) class, page, spacing | scribecv.cls:31-33,38-42; example-cv/main.tex:1 | `class.article`, `page.geometry`, `sp.lengths`, `sp.linespread` | article 10pt; margins 0.75in; `\parskip` 0pt, `\parindent` 0pt; `\linespread{1.0}` |
| CV header, icons | scribecv.cls:133-141,146; example-cv/main.tex:4,29-33 | `hf.fancyhdr`, `font.icons` | head L `\leftmark`, head R only with option `header`; foot C `\thepage`; fontawesome5 `\faGithub` `\faTelegram` `\faLinkedin` `\faTwitter` `\faReddit` |
| CV title | scribecv.cls:210-248; example-cv/main.tex:19-36 | `front.maketitle`, `box.minipage`, `font.size-commands`, `mark.kernel`, `font.icons`, `sp.manual-space` | centred `\LARGE\scshape` name, ding 71, subtitle; two `minipage[t]{0.48\textwidth}` info blocks (right one `\raggedleft`); `\vskip` 4pt, 10pt, 2pt |
| CV section headings | scribecv.cls:251-277; example-cv/main.tex:52,82,95,106,117 | `sp.rule`, `font.size-commands`, `mark.kernel`, `font.icons`, `sp.manual-space` | `\vspace{8pt}`; leader rules of 0.6em x 0.5pt around ding 71 and `\large\scshape\bfseries` name, or fill-style (option `sectionfill`) with `\large\scshape` name; `\vspace{4pt}` after |
| CV entries | scribecv.cls:281-287; example-cv/main.tex:84-123 | `tbl.tabularx` | `tabularx{\textwidth}{@{} >{\raggedleft\arraybackslash}p{2.8cm} @{\hspace{8pt}} X @{}}`, bold date, optional detail row `\small\itshape` |
| CV inline bibliography | scribecv.cls:151-153,291-293; example-cv/main.tex:13-14,54-77 | `bib.bibentry`, `bib.natbib`, `bib.bibtex-bst`, `sp.lengths` | `bibentry`, `\nobibliography{cv.bib}` at begin document, `\bibentry{key}`; natbib numbers,sort&compress; bibsep 2pt; unsrt |
| CV intro, links, loaded extras | example-cv/main.tex:25-33,39-45; scribecv.cls:60,65,71-72,77-112,118-128 | `box.minipage`, `sp.ragged`, `meta.hyperref`, `meta.url`, `fig.graphicx`, `list.enumitem`, `box.tcolorbox` | center + minipage 0.7\textwidth; `\href`; hyperref options passed before orcidlink loads it, colours MidnightBlue; graphicx, enumitem, tcolorbox boxes loaded, not called |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\makeLineNumber` redefinition with zref-savepos | scribe.cls:67-73 | no | position-measured side choice for line numbers, two compiles; irreducible (BESPOKE/class) |
| `\if@scribelineno`, `\DeclareOption{lineno}`, `\DeclareOption*` pass-through | scribe.cls:17-22 | yes | the emitter writes the class options it needs (`lineno` becomes `sp.draft-lineno`) |
| `\scribenonum`, `\scribeinternalnum` | scribe.cls:85-91 | yes | lineno's `\nolinenumbers` and `\internallinenumbers` when numbering is on, nothing when off |
| `\patchcmd{\@maketitle}` and `\pretocmd{\@maketitle}` | scribe.cls:344-347,354-356 | yes (judgement) | `front.titling` `\droptitle` of -1.5cm, and `\pretitle{\nolinenumbers ...}` when numbered; titling's source was not read |
| `\renewenvironment{abstract}`, `indexterms`, `\AtEndEnvironment{indexterms}` | scribe.cls:279-305 | yes | center + minipage 0.93\linewidth + bold run-in label + `\itshape`, then the divider expansion |
| `\scribedefinebox` and the four boxes | scribe.cls:178-186; scribecv.cls:105-112; beamerthemescribe.sty:266-274; beamerthemescribeposter.sty:282-289 | yes | expand per name: `\newtcolorbox{<n>box}[1]{colframe=<c>, scribebox={#1}}` and `\newtcbox{\<n>boxinline}{colframe=<c>, scribeboxinline}` (`box.tcolorbox`) |
| `\scribedefinetheorem`, counter `scribethm` | scribe.cls:201-219 | yes | `thm.tcolorbox` `\newtcbtheorem` sharing one counter within section, or `num.counters` + `box.tcolorbox` with `\refstepcounter`; the `\ifstrempty` note test is per use |
| `\scribedefinecomment`, `\newif\ifscribeshowcomments` | scribe.cls:241-251; scribecv.cls:165-174; beamerthemescribe.sty:298-308; beamerthemescribeposter.sty:324-333 | yes (judgement) | the flag is a constant set before use; the emitter writes `\textcolor{c}{[\textbf{name}] \textit{text}}` or drops the node (`draft.todo` type, `mark.kernel`, `color.xcolor`) |
| `\scriberightmark`, `\scribesetrightmark` | scribe.cls:254-257; scribecv.cls:177-180 | yes | `\fancyhead[R]{text}` (`hf.fancyhdr`) |
| `\scribedivider` | scribe.cls:262-273; scribecv.cls:183-194; beamerthemescribe.sty:281-292; beamerthemescribeposter.sty:309-320 | yes | `\par\medskip`, `\makebox[\linewidth]` of two rules `\rule[0.75ex]{\dimexpr0.5\linewidth - 3em}{0.5pt}`, `\hfill`, `\ding{71}`, in scribeaccent for the theme versions (`sp.rule`, `sp.manual-space`, `font.icons`) |
| `\dingred` `\dinggreen` `\dingblue`, `\tool`, `\BibTeX`, `\fontcaveat` | scribe.cls:139-141,334,311-313; beamerthemescribeposter.sty:247-249,304,322 | yes | aliases: `{\color{X}\ding{#1}}`, `\textsc`, `Bib\TeX`, `{\caveatfont #1}` |
| `\@scribeblock` | beamerthemescribeposter.sty:109-130 | yes | three literal `\setbeamertemplate{block ... begin}` bodies (begin and end split across two templates), no macro left |
| `\posterbodycenter`, `\posterlogoleft/right`, `\poster*display`, `\postercontact`, headline and footline with `\ifx...\@empty` tests | beamerthemescribeposter.sty:143-224 | yes | stored `\def` content inlined into the two templates; the field-present tests are decided by the emitter, which knows which fields are set |
| `\postercolumnsep` | beamerthemescribeposter.sty:294-300 | yes | inline column with a `\rule` of `\dimexpr\paperheight - 28cm\relax` |
| theme options and flags `\if@scribeframenumbers`, `\if@scribesectionpages` | beamerthemescribe.sty:30-37,183-185,204-210 | yes | static choice; the footline and the `\AtBeginSection` hook are written or left out |
| `\scribename`, `\scribesubtitle`, `\scribeinfo`, `\maketitle` redefinition | scribecv.cls:210-248 | yes | stored strings inlined into the centred title and the two minipages; the `\ifx\@scribeinfleft\empty` test is static |
| `\scribesection` (two forms) | scribecv.cls:251-277 | yes (judgement) | `\leaders\hbox{\hss\rule[0.75ex]{0.6em}{0.5pt}\hss}\hfill` has a rule-only leader box, the `\dotfill` pattern with a rule (`sp.rule`); if a reviewer counts it as leaders over an arbitrary box it becomes BESPOKE/class |
| `\scribeentry`, `\ifblank` | scribecv.cls:281-287 | yes | the `tabularx` of the map row; the detail row is written only when the third field exists |
| `\scribenobibliography` | scribecv.cls:291-293 | yes | `\AtBeginDocument{\nobibliography{file}}` becomes the preamble line of `bib.bibentry` |
| `\scribefooter`, `\newsavebox{\scribesectionbox}` | scribecv.cls:224-225,251 | yes | dead: `\@scribefooter` and the box are never used (grep over scribecv.cls) |
| `\scribelayout` selector with `\ifx` before `\documentclass`, `\scribefrontmatter` | example/main.tex:12-20,63-71,75-91 | yes | the emitter picks one branch (default `twocolumnabstract`); the selector is only overridden on the command line by regen-docs.sh:76-77 to build previews, the default needs no outside input |

## Content-opaque
none. The logos (example-poster/LLVM.png, MLIR.png) and the Caveat TTFs are assets that ship in the zip.

## Lib changes
- New ways proposed: `bib.bibentry` `bibentry` (CTAN, part of the natbib bundle, Patrick W. Daly, LPPL 1, v1.5; read at ctan.org/pkg/bibentry; the page names no commands, `\bibentry` and `\nobibliography` come from scribecv.cls:152,292 and example-cv/main.tex:54), pdfLaTeX. W1: published on CTAN. W2: no options; the keys, the `.bib` file name and the `.bst` style are values. W3: serves any document that prints full references inside running text (CV, annotated bibliography). W4: preamble `\usepackage{bibentry}` and `\nobibliography{file}`, body `\bibentry{key}`. Not `bib.natbib` (citation commands that print a label), not `bib.cite-pkg`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this).

## Notes
- Nothing in the zip is addressed to an AI.
- Not read: the two `.bib` files per sample (content), the PDFs and PNGs, matplotlib/scribe-theme.mplstyle, and scribe_mpl.py after line 60. The matplotlib folder is a Python style kit for figures; no .tex file loads it, so it is not part of the template and not an EXTERNAL blocker.
- example-poster/Makefile:35 and regen-docs.sh:25 pass `-shell-escape` to the engine, but no loaded package needs it (grep for `minted`, `\write18`, `directlua` over all .tex, .cls and .sty files found nothing); they only chain xelatex or pdflatex, bibtex and, in regen-docs.sh, ImageMagick for preview PNGs. The Makefiles of the other samples were not read.
- scribe.cls and scribecv.cls call `\ProvidesPackage` instead of `\ProvidesClass` (scribe.cls:11, scribecv.cls:12); a defect, not a blocker.
- `tcolorbox [most]` loads libraries from the tcolorbox manual, which was not read; the zip calls no `minted` or other external-tool library.
