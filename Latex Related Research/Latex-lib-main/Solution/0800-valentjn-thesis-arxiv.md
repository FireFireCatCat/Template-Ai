no

# 0800-valentjn-thesis-arxiv: Julian Valentin's PhD thesis (arXiv version), a KOMA-Script scrbook thesis

- Unverified: read from the source, not compiled.
- Source: Source/0800-valentjn-thesis-arxiv/ (origin: https://codeload.github.com/valentjn/thesis-arxiv/zip/refs/heads/develop; licence: NOASSERTION in the manifest, README.md:12 states CC BY-SA 4.0)
- Kind: thesis
- Lib: v6
- Engine: pdfLaTeX-compatible (thesis.tex:2 `\pdfoutput=1`, Makefile:3 runs pdflatex; the draft/check switches load LuaLaTeX-only `lua-check-hyphen` and `lua-visual-debug`, packages.tex:28,34, both off in the shipped setting, switches.tex:61-65)
- Look carried by: preamble (no class or style file ships; the look is `scrbook` plus `thesis.tex` and `tex/preamble/*`)
- Class origin: tex-distribution-unbundled
- Main file: thesis.tex (other samples: none; body is in tex/document/*.tex via `\include`/`\input`)
- Read: main yes (thesis.tex whole; every file in tex/preamble except notation.tex, all front-matter files in tex/document, chapters 10 and 20 whole, 21 and 24 in parts, the other chapters only by grep; notation.tex partly, about 500 of 1851 lines plus a grep outline), zip-local classes and styles none present

## Verdict
`no`. The class is published (`scrbook`) and most of the preamble is plain composition of published packages, but the thesis's identity is carried by TikZ artwork and by hand-written kernel patches. The chapter-number gradient disc, the flip-book overlay on every page, the torn-page theorem frames and the 13-layer shadow stack of the float frames are `ART`. The ornament-before-heading hack, the float-wrapping patches, the `\rownum`-driven table colour system, the glossary/notation machinery, the `l` to `\ell` math hack and the expl3 `\hms` are irreducible `BESPOKE`. The glossary is also sorted by a Python script (`tools/buildGlossary.py`), which is `EXTERNAL`.

## Blockers
- `ART/preamble` chapter number drawn as a TikZ gradient disc (`shading=axis`, `left color=mittelblau`, `right color=hellblau`, circle 5mm) inside `\chapternumber` (tex/preamble/settings/headings.tex:26-51)
- `ART/preamble` flip book: a TikZ `remember picture,overlay` node placed on every page from `\AddEverypageHook`, image chosen by a page counter (`flipBookSG_n`, `flipBookBSpline_n`, 258 shipped PDFs) (tex/preamble/settings/flipBook.tex:35-74)
- `ART/preamble` theorem frames: "torn page" bottom/top edge from a custom pgf decoration `my random steps`, a random-seed counter and a `\clip` run at the start of every `tikzpicture`, plus a TikZ thick left bar in `extra` (tex/preamble/settings/theorems.tex:19-22, 26-89)
- `ART/preamble` float and mini-contents frames: `mdframed` with a hand-built `mdfshadow` of 13 stacked opaque `drop shadow` layers (tex/preamble/settings/floats.tex:28-49; tex/preamble/settings/minitoc.tex:28-49)
- `ART/preamble` draft-mode watermark and 1-37 line-number ruler as TikZ nodes on every page (inactive in the shipped setting, draftMode false, tex/preamble/switches.tex:12) (tex/preamble/settings/watermarks.tex:6-49)
- `BESPOKE/preamble` ornament image `\includegraphics{ornament_1}`/`{ornament_2}` injected before every `\section`/`\subsection` through the KOMA `font=` hook, steered by the hand-made flags `\ifdisableornamentsfornextheading` and `\ifbreakpagebeforenextheading` (tex/preamble/settings/headings.tex:82-87, 91-147; set by hand in tex/document/floats.tex:9-15 and tex/document/abstract.tex:3,38; 23 call sites of the flag setters and `\fill*ornament` in 13 body files by grep)
- `BESPOKE/preamble` every float wrapped in an `mdframed` by patching kernel internals: `\apptocmd{\@xfloat}`, `\pretocmd{\end@float}`, `\xpatchcmd{\endSC@float}`, `\let\ftype@table\ftype@figure`, `\apptocmd{\subcaption@minipage}` (tex/preamble/settings/floats.tex:61-76)
- `BESPOKE/preamble` table colour system: row parity read from `\rownum` (`\ifnum\rownum<1`, `\ifodd\rownum`), custom column types `=` and `+` with `\gdef\@rowstyle`, and rule macros whose gap colour is computed from the neighbouring rows (tex/preamble/settings/tables.tex:23-63, 69-108; 16 `\setnumberoftableheaderrows` calls in the body)
- `BESPOKE/preamble` symbol and acronym glossary engine: `\newnotationcommand` makes every notation macro call `\usenotation` through `\pretocmd`, with the flag `\ifinglossary`, storage keys `myused`/`myisacronym`, `\forglsentries` loops that reset acronyms at each chapter via `\addtokomafont{chapter}{\resetacronyms}`, an end-of-document warning, and a rebuilt `theglossary` environment with dot leaders (tex/preamble/settings/glossary.tex:54-223; about 520 `\newnotation*`/`\makecommandnotation` calls in tex/preamble/notation.tex)
- `BESPOKE/preamble` `\mathcode`l="8000` plus an active-character `\gdef~` that prints `\ell` for every `l` in math (tex/preamble/settings/mathematics.tex:6-11)
- `BESPOKE/preamble` expl3 `\hms` with `\SplitArgument` and branching on empty fields to choose units and zero padding (tex/preamble/settings/mathematics.tex:36-66; 12 body uses by grep)
- `BESPOKE/preamble` list of theorems filled through thmtools internals `\thmt@envname` and `\ll@...` in `\addtotheorempostheadhook` (tex/preamble/settings/toc.tex:23-39); `thm-listof` was rejected by the author (toc.tex:25-27)
- `BESPOKE/body` restated theorems hidden from that list with `\addtocontents{lop}{\protect\iffalse}` ... `\protect\fi`, and `\isincluded` built on `\@partlist` and `\if@partsw` (tex/document/a10proofs.tex:12-16; tex/preamble/settings/dynamic.tex:40-49)
- `BESPOKE/preamble` `\is@thispageodd` of KOMA redefined with a private counter and `.aux` labels (tex/preamble/settings/flipBook.tex:7-32), part of the flip book
- `EXTERNAL/preamble` the glossary file `thesis.gls` is built by `python3 tools/buildGlossary.py`, a replacement for makeindex that sorts the entries and invents the group headings from the `zzzz...` sort-key prefixes (Makefile:5; tools/buildGlossary.py:44-62); the built `thesis.gls` ships, but cannot be regenerated without Python
- Not blockers, recorded: `tools/filterOutput.py` only filters the pdflatex log (Makefile:1-3); `hyphenationWhitelist.txt` for `\LuaCheckHyphen` is not in the zip (tex/preamble/settings/checkMode.tex:12, check mode off); `tex/document/progress.tex` is missing and `\currentTimeShort`/`\gitCommitTimeShort` are undefined (thesis.tex:41, watermarks.tex:17,19), so draft mode would not build.

## Class setting
- Class: `class.scrbook` options: `leqno`, `a4paper` (thesis.tex:8-13); `\KOMAoptions{fontsize=12pt, DIV=12, numbers=noendperiod, onpsinit=\onehalfspacing, listof=leveldown}` (tex/preamble/settings/komaTextArea.tex:6-19). The class source is not in the zip and was not read.
- Class-native vocabulary used: `\addchap` (abstract.tex:1, preface.tex:1, floats.tex:1 via `\addlongchap`), `\chapter`, `\appendix` (thesis.tex:73), `\setkomafont`/`\addtokomafont` (elements `disposition`, `dictum`, `pageheadfoot`, `pagenumber`, `chapter`), `\RedeclareSectionCommand` (headings.tex:59, 108, 129, 150-151), `\RedeclareSectionCommands` (minitoc.tex:68), `\chapterformat`, `\chapterlinesformat`, `\chaptermarkformat`, `\setchapterpreamble`, `\chapterheadendvskip`, `\listofalgorithms`/`\listofmytheorems` (floats.tex:14,16), `\Ifthispageodd` (flipBook.tex:56), `\cleardoubleevenpage` (bibliography.tex:16), `\sectionnumdepth` (toc.tex:47), `\pagemark`, `\headmark`, `\clearscrheadfoot`, `\lehead`..`\rofoot` (headerFooter.tex:13-19).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | thesis.tex:8-13 | `class.scrbook` | leqno, a4paper |
| engine flag | thesis.tex:2 | `meta.pdf-params` | `\pdfoutput=1` |
| paper size | thesis.tex:10-12 | `page.class-options` | a4paper |
| type area, font size | tex/preamble/settings/komaTextArea.tex:6-19 | `page.typearea` | DIV=12, fontsize=12pt |
| page geometry | tex/preamble/settings/komaTextArea.tex:22-29; tex/document/bibliography.tex:19-25 | `page.geometry` | bindingoffset=25mm, inner=10mm, outer=20mm, top=20mm, bottom=30mm, includehead=true; `\newgeometry` all margins 0mm on the last page |
| equation numbers left | thesis.tex:9 | `math.eqnumber` | leqno |
| languages | tex/preamble/packages.tex:2; tex/document/titlepage.tex:4; tex/document/abstract.tex:37 | `lang.babel` | ngerman, american; `otherlanguage{ngerman}`, `\foreignlanguage` (abstract.tex:1, preface.tex:34) |
| quotation package | tex/preamble/packages.tex:8 | `lang.csquotes` | load-only |
| encodings | tex/preamble/packages.tex:5, 50 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| main text and math face | tex/preamble/packages.tex:59 | `font.charter` | `mathdesign` option bitstream-charter (package is the parameter) |
| sans face | tex/preamble/packages.tex:46 | `font.helvet` | `tgheros` |
| mono face | tex/preamble/packages.tex:38-43 | `font.mono` | `GoMono` type1, scale=0.88 |
| micro-typography | tex/preamble/packages.tex:62-71; tex/preamble/settings/algorithms.tex:6 | `sp.microtype` | final, tracking=smallcaps, stretch=10, shrink=10; `\DisableLigatures{encoding=*,family=tt*}` |
| font sizes | tex/preamble/settings/captions.tex:14,54; tex/preamble/settings/dictums.tex:18 | `font.size-commands` | `\fontsize{9.5}{12}`, `{8.8}{11}`, `{10}{12}`, `{75}{80}`, `\small`, `\Large` |
| line spacing | tex/preamble/packages.tex:157; tex/preamble/settings/headings.tex:6; tex/document/titlepage.tex:2 | `sp.setspace` | onehalfspacing; `\setstretch{1}`; `spacing` environment |
| paragraph indent | tex/preamble/settings/text.tex:6; tex/document/titlepage.tex:122-123 | `sp.lengths` | `\parindent`=2em; `\hangindent=29mm`, `\hangafter=0` |
| penalties, badness | tex/preamble/settings/text.tex:9, 15-16 | `sp.penalties` | `\interfootnotelinepenalty`=10000, `\hbadness`=`\vbadness`=9999 |
| manual spacing | tex/document/titlepage.tex:10, 40; tex/document/dedication.tex:1 | `sp.manual-space` | `\vfill`, `\vspace`, `\vspace*{\fill}`, `\raisebox`, `\hspace` |
| flush right quote block | tex/preamble/settings/dictums.tex:24-38 | `sp.ragged` | `flushright`/`flushleft` inside nested `minipage` |
| colours | tex/preamble/settings/colors.tex:6-19; tex/preamble/packages.tex:83 | `color.xcolor` | `[table]`; C0..C8 rgb; anthrazit, mittelblau, hellblau RGB |
| text outline | tex/preamble/packages.tex:86; tex/preamble/settings/graphics.tex:44 | `mark.contour` | `\contourlength{1.5pt}` |
| upper case | tex/preamble/settings/captions.tex:15,20 | `mark.case` | `\MakeUppercase` |
| inline marks | tex/document/10introduction.tex:28 | `mark.kernel` | `\emph` through `\term` (notation.tex:1764), `\textbf`, `\texttt` |
| numbers and units | tex/preamble/packages.tex:121; tex/preamble/settings/mathematics.tex:22-32 | `mark.siunitx` | binary-units=true; inter-unit-product, per-mode=fraction, exponent-product; `\DeclareSIUnit{\permille}`; `\num` (180 uses), `\SI` (93) |
| running head and foot | tex/preamble/packages.tex:11; tex/preamble/settings/headerFooter.tex:6-22 | `hf.scrlayer-scrpage` | markcase=upper; `\lehead`/`\rohead`/`\rehead`/`\lohead`, no foot; font 9.5/12 sf `\lsstyle`; `\chaptermarkformat` "Chapter X:" |
| page style | tex/document/titlepage.tex:53; tex/document/bibliography.tex:14 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| page numbers | tex/document/cover.tex:2-3, 12-13 | `pgnum.pagenumbering` | roman then arabic, `\setcounter{page}{1}` |
| last page | tex/preamble/packages.tex:74 | `pgnum.lastpage` | `LastPage` label |
| count of remaining pages | tex/preamble/packages.tex:77; tex/preamble/settings/dynamic.tex:9-11; tex/document/preface.tex:46-49 | `NEW:xref.refcount` | `\getpagerefnumber{LastPage}` minus `\getpagerefnumber{page:preface}` inside `\numexpr` |
| heading fonts and skips | tex/preamble/settings/headings.tex:6, 59, 150-151 | `head.koma-fonts` | `disposition` = `\normalcolor\bfseries\setstretch{1}`; chapter beforeskip=afterskip=5em; paragraph 2ex plus 1ex minus .2px; subparagraph 1ex plus 1ex minus .2px |
| chapter heading layout | tex/preamble/settings/headings.tex:9-23, 54-56 | `head.class-native` | `\chapterformat`, `\chapterlinesformat`, centred `minipage`, number then title in mittelblau, no number: black title |
| chapter dictum | tex/preamble/settings/dictums.tex:6-14, 17-22; tex/document/10introduction.tex:1-6 | `head.class-native` | `\setchapterpreamble` with `dictum` font `\rmfamily`, width 0.54\textwidth default; 75pt grey opening quote |
| unnumbered chapters | tex/document/abstract.tex:1-4; tex/document/preface.tex:1 | `head.class-native` | `\addchap{...}`, `\section*{Abstract}` |
| section numbering | tex/preamble/settings/komaTextArea.tex:12; tex/preamble/settings/toc.tex:47 | `num.secnumdepth` | numbers=noendperiod; tocdepth = `\sectionnumdepth` |
| appendix | thesis.tex:73-78 | `num.appendix` | `\appendix` |
| drop capitals | tex/preamble/settings/initials.tex:6-14, 19-25; tex/document/10introduction.tex:11 | `sp.lettrine` | `\DefaultNindent`=0.5em, `\LettrineSecondString`=X, `\DefaultLoversize`=0.07, bold hooks; `\initial` = `\lettrine[findent,nindent]` |
| lists | tex/preamble/settings/text.tex:26-33 | `list.enumitem` | leftmargin=\parindent, itemsep=0pt, topsep=0.5em |
| list environments | tex/document/10introduction.tex:116-133 | `list.kernel` | `itemize` (21), `enumerate` (11) |
| table of contents | tex/document/contents.tex:2-3 | `toc.kernel` | `\tableofcontents` after `\pdfbookmark[section]` |
| list-of options | tex/preamble/settings/komaTextArea.tex:17-18 | `toc.koma` | listof=leveldown |
| list-of entry styles and new lists | tex/preamble/settings/toc.tex:6-7, 11-21, 28-34, 43-44, 51-52 | `toc.tocbasic` | `\DeclareTOCStyleEntry[indent=0em]`; `\DeclareNewTOC` `loa` (algorithm float, floattype=4, floatpos=tp, counterwithin=chapter) and `lop`; `\AfterTOCHead`; `\@pnumwidth`=2em |
| lists of floats page | tex/document/floats.tex:9-16 | `toc.kernel` | `\listoffigures`, `\listoftables`, `\listofalgorithms`, `\listofmytheorems` |
| mini contents | tex/preamble/packages.tex:142; tex/preamble/settings/minitoc.tex:60-79; tex/document/21nodalSpaces.tex:4 | `toc.etoc` | `\localtableofcontents`, `\etocsettocstyle{}{}`, `\etocsetnexttocdepth{subsection}` |
| wrapped mini contents | tex/preamble/settings/minitoc.tex:61-78 | `fig.wrapfig` | `wrapfigure[#3]{r}[15mm]{#2}` |
| frame boxes | tex/preamble/settings/minitoc.tex:6-27; tex/preamble/settings/floats.tex:6-27 | `box.mdframed` | `mdfdefinestyle` margins 7pt, roundcorner=10pt, linewidth=1pt, linecolor mittelblau, backgroundcolor mittelblau!10, shadow=true (shadow drawing is `ART`) |
| front title page | tex/document/titlepage.tex:1-50 | `front.titlepage-env` | `titlepage` env, `\vfill` spacing, bold `\huge` title, `tabular` of examiners, logos |
| imprint page | tex/document/titlepage.tex:53-147 | `front.dedication` | `\thispagestyle{empty}`, `tabular` with `p` columns, licence badge hung by `\smash{\rlap{}}`, `\href` links |
| dedication page | tex/document/dedication.tex:1-38 | `front.dedication` | `\vspace*{\fill}`, centred image and quote, disclaimer |
| preface | tex/document/preface.tex:1-63 | `front.dedication` | `\addchap{Preface}`, prose, signature image |
| cover page | tex/document/cover.tex:6 | `pg.include-pdf` | `\includepdf{coverPublishedScreen}` |
| page breaks | tex/document/cover.tex:9; tex/document/abstract.tex:35; tex/document/bibliography.tex:13-16 | `pg.break` | `\cleardoublepage`, `\newpage`, `\pagebreak[0]`, `\cleardoubleevenpage` |
| file inclusion | thesis.tex:5, 16-25, 62-70; tex/preamble/switches.tex:40-53 | `struct.input` | `\input`, `\include` (12 chapters), `\includeonly{}` empty |
| graphics | tex/preamble/settings/graphics.tex:6-9; tex/preamble/packages.tex:80 | `fig.graphicx` | `\graphicspath{{gfx/}}`, extensions .pdf,.jpg,.png; 254 `\includegraphics` |
| float placement | tex/preamble/settings/floats.tex:54-55, 80, 83 | `fig.placement` | `\fps@figure`=`\fps@table`=tp; `\floatpagefraction`=0.73; `\textfloatsep`=20pt |
| sub-figures | tex/preamble/packages.tex:92; tex/document/24boundary.tex:412-419 | `fig.subcaption` | `\subcaptionbox{...}[35mm]{...}` (130 uses) |
| side-caption figures | tex/preamble/packages.tex:95; tex/preamble/settings/captions.tex:44-50; tex/document/21nodalSpaces.tex:171-181 | `fig.floatrow` | `SCfigure` (23), `\sidecaptionrelwidth`=50 |
| captions | tex/preamble/settings/captions.tex:6-41, 53-73 | `cap.caption` | `\captionsetup` format (hang), labelformat (uppercase sf bold mittelblau `\textls*`), labelsep=quad; `[sub]` set; `\thesubfigure`=`\Alph` (captions.tex:76) |
| caption command | tex/document/24boundary.tex:251-267, 398-408 | `cap.kernel` | `\caption[short]{long}` |
| tables | tex/preamble/settings/tables.tex:6-14; tex/document/24boundary.tex:227-250 | `tbl.tabular` | `\newcolumntype{L}{D}{R}` p-columns; `tabular` with `>{\kern\tabcolsep}=l<{\kern7mm}+r`; considered: `cellspace` (loaded, packages.tex:89, used only as modifier `C` in tables.tex:35-36 with default limits, no printed effect) |
| table rules | tex/preamble/settings/tables.tex:66-67, 71-99 | `tbl.booktabs` | `\heavyrulewidth`=0.10em, `\lightrulewidth`=0.06em, `\specialrule` |
| table colours | tex/preamble/settings/tables.tex:17-21, 25-28 | `tbl.colortbl` | `\rowcolors{1}`, `\rowcolor`, `\arrayrulecolor`; mittelblau!10/!20/!40 (the parity logic is `BESPOKE`) |
| row spans | tex/preamble/packages.tex:107 | `tbl.multirow` | loaded; `\multirow` 4 uses |
| algorithms | tex/preamble/packages.tex:169-172; tex/preamble/settings/algorithms.tex:9-57; tex/document/24boundary.tex:350-409 | `alg.algorithmicx` | `algpseudocode[noend]`; `\algrenewcommand` bold keywords, `\alglinenumber` footnotesize anthrazit tt, indent `\widthof{AB}`; float from `toc.tocbasic` `loa` |
| theorem declarations | tex/preamble/packages.tex:20; tex/preamble/settings/theorems.tex:103-167 | `thm.thmtools` | `\declaretheoremstyle` (headformat with `\formatcaption`, notefont, headpunct={}, bodyfont `\itshape`); `\declaretheorem` definition (numberwithin=chapter), theorem, proposition, lemma, shortlemma, corollary, shortcorollary (numberlike=definition); `restatable` (14 uses, 24boundary.tex:203-217) |
| proof and QED | tex/preamble/packages.tex:17; tex/preamble/settings/mathematics.tex:14-19 | `thm.amsthm` | `\qedsymbol` = mittelblau `\blacksquare`; own `proof` environment |
| theorem frames | tex/preamble/settings/theorems.tex:6-23, 126-167 | `thm.mdframed` | `thmmdfstyle`: margins 13/7/5/6pt, linewidth=1pt, linecolor mittelblau, backgroundcolor mittelblau!10, splittopskip=19pt; set by `mdframed={style=...}` (edge and bar drawing is `ART`) |
| math packages | tex/preamble/packages.tex:14; tex/preamble/notation.tex:1806-1808 | `math.mathtools` | `\DeclarePairedDelimiter`, `\coloneqq`, `\mathclap` |
| display math | tex/document/24boundary.tex:210-216 | `math.amsmath` | `equation` (250), `align`, `gather`, `subequations`, `cases`, `\DeclareMathOperator` (notation.tex:569-605) |
| cross-references | tex/document/10introduction.tex:9, 32 | `xref.kernel` | `\label`, `\ref` (51 uses by grep) |
| named references | tex/preamble/packages.tex:211-216; tex/preamble/settings/crossReferences.tex:6-40; tex/preamble/settings/text.tex:83 | `xref.cleveref` | capitalise, nameinlink; `\crefname`/`\Crefname` for 12 types; `\creflastconjunction`=", and"; `\cref` (592) |
| link references | tex/preamble/packages.tex:154, 166; tex/preamble/settings/crossReferences.tex:43-44; tex/preamble/settings/hyperref.tex:27 | `xref.hyperref` | `\hyperlink`, `\nameref*`, `\hyperref` in `\eqref` |
| PDF metadata and links | tex/preamble/settings/hyperref.tex:6-24 | `meta.hyperref` | pdftitle, pdfauthor, pdfborderstyle={/S/U/W 1}, link border colours C1/C0, bookmarksnumbered, bookmarksopen |
| bookmarks | tex/preamble/packages.tex:175; tex/document/contents.tex:2 | `meta.bookmark` | `\pdfbookmark[section]{\contentsname}{toc}` |
| URLs | tex/preamble/packages.tex:163 | `meta.url` | hyphens |
| footnotes | tex/document/21nodalSpaces.tex:28-34 | `fn.kernel` | `\footnote` (53) |
| bibliography | tex/preamble/packages.tex:199-208; tex/preamble/settings/bibliography.tex:6-131; tex/document/bibliography.tex:1-8; Makefile:4 | `bib.biblatex-biber` | giveninits=true, date=year, style=alphabetic, maxalphanames=1; `\DeclareCiteCommand` for `\cite`/`\multicite`, `\defbibheading` with `\addchap`, `\defbibnote`, `\DeclareFieldFormat`, `\renewbibmacro*`, name delimiters, `\bibfont`=`\small`, `\bibsetup`=`\singlespacing`; biber run with `--input-directory bib` |
| glossary of symbols and acronyms | tex/preamble/packages.tex:184-195; tex/document/glossary.tex:1; tex/preamble/acronyms.tex:2-17 | `idx.glossaries` | toc, nopostdot, indexonlyfirst, ucmark, nohypertypes=main; `\printglossary[title=...]`; 13 `\newgacronym` (engine is `BESPOKE` and `EXTERNAL`, see above) |
| glossary table | tex/preamble/settings/glossary.tex:76-98 | `tbl.longtable` | `longtable` `{@{}L{0.15\textwidth}@{}L{0.85\textwidth}@{}}`, header row, `\LTpre`=`\LTpost`=0pt |
| per-page overlay hook | tex/preamble/packages.tex:130; tex/preamble/settings/flipBook.tex:36, 50 | `bg.eso-pic` | `\AddEverypageHook` of `everypage` (same type of per-page hook; the hook bodies are `ART`) |
| flip-book overlay | tex/preamble/settings/flipBook.tex:49-74 | `art.tikz` | `tikzpicture[remember picture,overlay]`, nodes at `current page.south east`/`south west`, `\includegraphics` trimmed (**ART**) |
| chapter number disc | tex/preamble/settings/headings.tex:26-51 | `art.tikz` | `\fill[shading=axis,left color,right color,shading angle=135] circle (5mm)` (**ART**) |
| heading ornaments | tex/preamble/settings/headings.tex:108-147 | `head.koma-fonts` | `font={...}` hook with `\includegraphics{ornament_1}` and flags (**BESPOKE**) |
| theorem edge and bar | tex/preamble/settings/theorems.tex:19-22, 30-89 | `art.tikz` | `execute at begin picture`, `\pgfdeclaredecoration`, `\pgfmathsetseed` (**ART**) |
| float frame shadow | tex/preamble/settings/floats.tex:28-49 | `art.tikz` | 13 `drop shadow` layers (**ART**) |
| float frame wrapper | tex/preamble/settings/floats.tex:61-76 | `box.mdframed` | `\apptocmd{\@xfloat}{\begin{mdframed}...}` (**BESPOKE**) |
| TikZ setup | tex/preamble/packages.tex:136; tex/preamble/settings/graphics.tex:12-34 | `art.tikz` | libraries arrows.meta, calc, decorations.*, fadings, shadows; line width 1pt; arrow tip Stealth (support for the figures and the artwork above) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| toggles `draftMode`, `checkMode`, `debugMode`, `flipBookMode`, `partialCompileMode`, `\@partswfalse` | tex/preamble/switches.tex:11-73 | yes | the emitter writes the resolved branch (flipBook on, all others off) and omits `\includeonly` |
| partialCompile glossary stubs | tex/preamble/settings/glossary.tex:9-50 | yes | dropped with the toggle |
| `\mychapterlinesformat`, `\chaptertitle`, `\chaptertitlenonumber` | tex/preamble/settings/headings.tex:13-23, 54-56 | yes | `head.class-native` `\chapterlinesformat` with `box.minipage`, `sp.ragged`, `color.xcolor`; the disc inside is `ART` |
| `\chapternumber` | tex/preamble/settings/headings.tex:26-51 | no | TikZ artwork, per-digit `\hspace` kerning by `\ifthenelse` on the digit (headings.tex:40-46) |
| ornament flags and `font=` hack | tex/preamble/settings/headings.tex:82-147 | no | hand-made conditionals drive what is printed before headings |
| `\longchapter`, `\longsection`, `\addlongchap` | tex/preamble/settings/headings.tex:71-79 | yes | `\chapter[toc]{title\chaptermark{m}}\chaptermark{m}` (`head.class-native`, `hf.scrlayer-scrpage` marks) |
| `\paragraph`/`\subparagraph` with period | tex/preamble/settings/headings.tex:154-167 | yes | the emitter appends the period to the heading text |
| `\setdictum`, `\cleanchapterquote`, `\hugequote` | tex/preamble/settings/dictums.tex:9-38 | yes | `\setchapterpreamble` + nested `minipage`, `flushright`, `\fontsize{75}{80}`, grey `\color[rgb]` |
| `\initial` | tex/preamble/settings/initials.tex:19-25 | yes | `\lettrine[findent=-w, nindent=w+\DefaultNindent, ...]` |
| `\minitoc` | tex/preamble/settings/minitoc.tex:60-79 | no | `wrapfigure` + `mdframed` + `etoc` composes, but the frame carries the 13-layer shadow (minitoc.tex:28-49, `ART`) |
| float wrapper patches | tex/preamble/settings/floats.tex:61-76 | no | edits kernel and sidecap internals (`\@xfloat`, `\end@float`, `\endSC@float`, `\subcaption@minipage`) |
| caption formats and label formats | tex/preamble/settings/captions.tex:6-26, 44-58 | yes | the format body equals caption's own `hang`; `format=hang`, `font=small`, `labelformat` with `\MakeUppercase`, `\textls*`, `\textcolor` |
| `\rownum` table colour system, `\toprulec`/`\midrulec`/`\bottomrulec`, column types `=` `+` | tex/preamble/settings/tables.tex:23-108 | no | counter-driven conditionals pick background colours for rule gaps |
| mdframed `\xpatchcmd{\mdf@put@frame@i}` (x3), `\WarningFilter` | tex/preamble/settings/theorems.tex:93-100 | no | package internals, part of the theorem frame artwork |
| torn-page edge | tex/preamble/settings/theorems.tex:26-89 | no | `ART` |
| theorem list hook (`\thmt@envname`) | tex/preamble/settings/toc.tex:37-39 | no | thmtools internals; `thm-listof` rejected by the author (toc.tex:25-27) |
| `\addtocontents{lop}{\protect\iffalse}`, `\isincluded` | tex/document/a10proofs.tex:12-16; tex/preamble/settings/dynamic.tex:40-49 | no | conditional text written to a toc file, kernel `\@partlist` |
| `\is@thispageodd` redefinition, `currentpagenumber` counter, `flipbookindex` | tex/preamble/settings/flipBook.tex:7-46 | no | KOMA internals and page-driven image selection |
| notation macros `\newnotation`, `\newnotationcommand(optarg)`, `\makecommandnotation`, `\usenotation`, `\hidenextnotation`, `\ifinglossary` | tex/preamble/settings/glossary.tex:105-163 | no | `\pretocmd` injects glossary use into every notation macro; flag-driven |
| `\newgacronym`, `\hidegacronym`, `\resetacronyms`, end-of-document check | tex/preamble/settings/glossary.tex:179-219 | no | `\forglsentries` loops and conditionals in a chapter font hook |
| glossary style `longraggedfixed` | tex/preamble/settings/glossary.tex:54-99 | no | dot leaders over a custom `\hbox` (sp.rule admits only rule or dot leaders), `\renewenvironment{theglossary}` |
| about 520 notation definitions | tex/preamble/notation.tex:16-1851 | yes | `\newcommand` aliases of `math.amsmath` and `math.mathtools` constructs (`\mathbb`, `\DeclareMathOperator`, `\DeclarePairedDelimiter`); the glossary hook on them is the row above |
| `\containsvector`, `\ifempty`, `\ifnotempty` | tex/preamble/notation.tex:8-10, 1767-1769 | yes | each call resolves statically to bold or plain form at emit time |
| `\*` redefined to `\vec`, `\subset`/`\supset` redefined | tex/preamble/notation.tex:1772-1785 | yes | alias of `\boldsymbol`; `\subseteq` |
| `\yes`, `\no` TikZ ticks | tex/preamble/notation.tex:1839-1848 | n/a | cell content, see Content-opaque |
| `l` to `\ell` in math | tex/preamble/settings/mathematics.tex:6-11 | no | `\mathcode` plus active `~` with `\mathgroup` test |
| `proof` environment | tex/preamble/settings/mathematics.tex:17-19 | yes | `\noindent`, `\formatcaption`, `\qed` |
| `\hms` | tex/preamble/settings/mathematics.tex:36-66 | no | expl3 branching on empty fields (inline expansion to `\SI` would be possible at each of 12 sites, but no wrapper holds it) |
| `\eqref` | tex/preamble/settings/hyperref.tex:27 | yes | `\hyperref[..]{\textup{\tagform@{\ref*{..}}}}`, link around the parentheses |
| `\thmref`, `\Thmref` | tex/preamble/settings/crossReferences.tex:43-44 | yes | `\hyperlink` + `\cref*` + `\nameref*` |
| `\pagedifference` | tex/preamble/settings/dynamic.tex:9-11 | yes | `\number\numexpr\getpagerefnumber{b}-\getpagerefnumber{a}\relax` with `NEW:xref.refcount` |
| `\halfhphantom`, `\lefthphantom`, `\centerhphantom`, `\righthphantom`, `\mathsettowidth` | tex/preamble/settings/text.tex:37-79 | yes | `\mathrlap{a}\hphantom{b}`, `\hphantom{b}\mathllap{a}`, `\mathmakebox[\widthof{b}][c]{a}` (`math.mathtools`, `sp.lengths` with calc) |
| `\punctfix` | tex/preamble/settings/text.tex:23 | yes | `{\hspace{-0.05em}#1}`, `sp.manual-space` |
| algorithmic patches | tex/preamble/settings/algorithms.tex:51, 63-66 | yes | `\small\ttfamily` moved to the float wrapper; the `\theHALG@line` counters only make hyperref anchors unique, no printed effect |
| `\todo`, `\dummytext`, `\currentname`, version strings | tex/preamble/settings/dynamic.tex:6-37; tex/preamble/settings/dummyText.tex:6-9 | yes | never called in the body by grep (except the version strings at titlepage.tex:111-112, plain `\texttt` text); `\dummytext` needs `blindtext`, which is not loaded |
| `\edef\bfseries@rm` fix, `\msg_redirect_name:nnn` | tex/preamble/packages.tex:54-56, 116-118 | yes | no printed effect (an arXiv workaround and a warning silencer) |
| `\centerarc` | tex/preamble/settings/graphics.tex:39-41 | yes | TikZ helper for figure content |

## Content-opaque
- TikZ figures in floats: tex/document/71model.tex:129, tex/document/82algorithms.tex:165 (with the local `circlescope` environment, :155), tex/document/64results.tex:69,123.
- `\yes` and `\no` tick glyphs drawn by TikZ and used in table cells (tex/preamble/notation.tex:1839-1848).
- 522 PDF and 12 JPG figure and logo files in gfx/ (matplotlib plots, logos, signature, cover, `sunset.jpg` on the last page, tex/document/bibliography.tex:30); text, equations and the BibTeX entries in bib/bibliography.bib.

## Lib changes
- New ways proposed: `NEW:xref.refcount`: `refcount` (CTAN, LPPL 1.3, Heiko Oberdiek, in TeX Live; ctan.org/pkg/refcount read), `\usepackage{refcount}` and expandable `\getrefnumber{label}` `\getpagerefnumber{label}` (also `\setcounterref`, `\addtocounterref`), pdfTeX-compatible. W1: on CTAN. W2: no options, behaviour chosen by the label argument. W3: serves any document that needs a number taken from a label. W4: one preamble line and an inline call. Not `xref.kernel` (`\ref` and `\pageref` print, they give no number to compute with).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
