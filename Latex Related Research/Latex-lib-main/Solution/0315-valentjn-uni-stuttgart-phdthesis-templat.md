no

# 0315-valentjn-uni-stuttgart-phdthesis-templat: valentjn/uni-stuttgart-phdthesis-template (unofficial University of Stuttgart PhD thesis, LuaLaTeX + KOMA scrbook)

- Unverified: read from the source, not compiled.
- Source: Source/0315-valentjn-uni-stuttgart-phdthesis-templat/ (origin: https://codeload.github.com/valentjn/uni-stuttgart-phdthesis-template/zip/refs/heads/master; licence: CC-BY-SA-4.0 per manifest; README.md:16 points to LICENSE)
- Kind: thesis
- Lib: v3
- Engine: needs LuaLaTeX (`luacode` + `\luaexec`/`\luadirect` tex/preamble/packages.tex:26 and tex/preamble/settings/dynamic.tex:23-30; `lua-check-hyphen` packages.tex:31; `lua-visual-debug` packages.tex:37; shell escape, Makefile:56 and tex/SConscript:15-25)
- Look carried by: preamble (the class is stock `scrbook`; every look decision sits in the 31 zip-local files under tex/preamble/ (26 in settings/) that tex/thesis.tex:2,11,14,17,20 `\input`; no zip-local .cls/.sty exists)
- Class origin: tex-distribution-unbundled
- Main file: tex/thesis.tex (other samples: gfx/tex/sparseGrid.tex is a `standalone` figure source, not a thesis sample; tex/document/*.tex are `\input`/`\include` parts of the main file)
- Read: main yes, zip-local classes and styles none present (all 46 .tex files and lua/*.lua, tools/*.py, SConstruct, SConscripts, Makefile read; gfx/py/{bsplHier,flipBook*,title}.py and py/helper/*.py are matplotlib figure generators and were not read; bib/bibliography.bib only its head)

## Verdict
no. The class is a published KOMA class and most of the page, font, float, caption, TOC and theorem settings map onto lib ways, but the template's identity is carried by preamble code that no lib way holds: a TikZ gradient disc around every chapter number, a pair of ornament images injected before every section and subsection heading through a flag-driven heading hook, mdframed boxes with hand-drawn TikZ blur shadows and a "torn page" decoration that hooks mdframed internals, and a custom glossary/notation system. It also needs three tools outside TeX (git/date through Lua `io.popen`, a Python makeindex replacement, and matplotlib-generated ornament PDFs). No text addressed to an AI was found in the zip.

## Blockers
- `ART/preamble` chapter number in a TikZ gradient circle with per-digit manual offsets (tex/preamble/settings/headings.tex:26-51)
- `ART/preamble` ornament images `ornament_1`/`ornament_2` printed before every `\section` and `\subsection` by a hook in the heading font (tex/preamble/settings/headings.tex:107-147)
- `ART/preamble` mdframed styles with 13 stacked TikZ drop shadows, used for every float and the mini-TOC (tex/preamble/settings/floats.tex:6-51; tex/preamble/settings/minitoc.tex:6-51)
- `ART/preamble` theorem frame: TikZ `extra` bar drawn at the left edge and a random-step "torn page" clip decoration at page breaks (tex/preamble/settings/theorems.tex:19-22, 25-89)
- `ART/preamble` draft watermark, page-edge line numbers 1 to 37 and flip-book corner images drawn with `everypage` + TikZ overlay (tex/preamble/settings/watermarks.tex:6-49; tex/preamble/settings/flipBook.tex:49-74); draft mode is on by default (tex/preamble/switches.tex:11-12)
- `BESPOKE/preamble` ornament flags `\ifdisableornamentsfornextheading`, `\ifbreakpagebeforenextheading` and the heading `font` hook that prints images and breaks pages (tex/preamble/settings/headings.tex:82-147)
- `BESPOKE/preamble` every float wrapped in `mdframed` by patching kernel `\@xfloat` and `\end@float`; `\let\ftype@table\ftype@figure`; sidecap and subcaption internals patched; mdframed internals `\mdf@put@frame@i` patched (tex/preamble/settings/floats.tex:61-76; tex/preamble/settings/theorems.tex:91-95)
- `BESPOKE/preamble` glossary/notation engine: custom glossary style with `\leaders`, storage keys, `\pretocmd` on every notation command, per-chapter acronym reset, unused-symbol warning at end of document (tex/preamble/settings/glossary.tex:54-219; used by tex/preamble/notation.tex:1-363 and tex/preamble/acronyms.tex:1-17)
- `BESPOKE/preamble` table colour machinery driven by a hand-rolled `\rownum` and `\@rowstyle` (tex/preamble/settings/tables.tex:23-63, 69-108)
- `BESPOKE/preamble` math hacks: `\mathcode` of `l` made active to print `\ell`; expl3 `\hms` command on siunitx internals (tex/preamble/settings/mathematics.tex:6-11, 36-66)
- `BESPOKE/preamble` KOMA `\is@thispageodd` redefinition, page counter hooks, `\@partswfalse` switch, `\isincluded` over `\@partlist`, etoolbox draft/partial-compile toggles that change which packages load (tex/preamble/settings/flipBook.tex:7-46; tex/preamble/switches.tex:11-65; tex/preamble/settings/dynamic.tex:42-52; tex/preamble/packages.tex:29-38, 172-190)
- `BESPOKE/preamble` box-measuring macros `\mathsettowidth`, `\halfhphantom`, `\lefthphantom`, `\centerhphantom`, `\righthphantom` (tex/preamble/settings/text.tex:35-79; `\righthphantom` is called at tex/document/progress.tex:11)
- `BESPOKE/preamble` internals patched: `\ALG@beginalgorithmic`, `\algorithmic`, `\theHALG@line` (tex/preamble/settings/algorithms.tex:51, 59-66); thmtools hook using `\thmt@envname` (tex/preamble/settings/toc.tex:36-39)
- `BESPOKE/preamble` (borderline) biblatex code replaced with `\renewbibmacro*` and a conditional `\MakeTitleCase` (tex/preamble/settings/bibliography.tex:73-110)
- `BESPOKE/preamble` Lua `generateTotalRow()` parses tex/document/progress.tex with `io.lines` to build the totals row (lua/progressTable.lua:1-73; tex/document/progress.tex:37-38)
- `BESPOKE/body` `\disableornamentsfornextheadingtrue` before each starred heading and list-of (tex/document/abstract.tex:3,10; tex/document/floats.tex:9-15)
- `EXTERNAL/preamble` Lua `io.popen` runs `git log`, `git describe`, `git status`, `date`, and writes compileCounter.txt; values print on the title page back and in the watermark (lua/version.lua:1-68; tex/preamble/settings/dynamic.tex:23-39; tex/document/titlepage.tex:103-104; tex/preamble/settings/watermarks.tex:16-19; Makefile:56 needs `-shell-escape`)
- `EXTERNAL/preamble` Python script replaces makeindex for the glossary (tex/SConscript:35-43; tools/buildGlossary.py:1-78; Makefile:17)
- `EXTERNAL/preamble` the ornament PDFs are generated by Python/matplotlib, they are not in the zip (gfx/py/ornament.py:1-35; gfx/SConscript:67-71; referenced at tex/preamble/settings/headings.tex:93,102,114,135)

## Class setting
- Class: `class.scrbook` options: `leqno` (tex/thesis.tex:5-8); `\KOMAoptions` fontsize=12pt, DIV=12, numbers=noendperiod, onpsinit=\onehalfspacing, listof=leveldown (tex/preamble/settings/komaTextArea.tex:6-19)
- Class-native vocabulary used: `\addchap` (tex/document/abstract.tex:1, tex/document/preface.tex:1), `\setkomafont`, `\addtokomafont` (tex/preamble/settings/headings.tex:6; tex/preamble/settings/dictums.tex:6), `\RedeclareSectionCommand`, `\chapterformat`, `\chapterlinesformat` (headings.tex:9-10, 59, 108-151), `\setchapterpreamble` (dictums.tex:10), `\chaptermarkformat` (tex/preamble/settings/headerFooter.tex:22), `\sectionnumdepth` (toc.tex:47), `\ifthispageodd` (flipBook.tex:56), `titlepage` environment, `\appendix`, `\cleardoublepage`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | tex/thesis.tex:5-8 | `class.scrbook` | leqno; KOMA options as above |
| font size | tex/preamble/settings/komaTextArea.tex:8 | `page.class-options` | fontsize=12pt (set through `\KOMAoptions`) |
| text area | tex/preamble/settings/komaTextArea.tex:10 | `page.typearea` | DIV=12 |
| page geometry | tex/preamble/settings/komaTextArea.tex:22-32; tex/preamble/packages.tex:23 | `page.geometry` | bindingoffset=10mm, inner=15mm, outer=30mm, top=20mm, bottom=30mm, includehead=true |
| header/footer | tex/preamble/packages.tex:8; tex/preamble/settings/headerFooter.tex:6-22 | `hf.scrlayer-scrpage` | markcase=upper; `\clearscrheadfoot`; `\lehead \rehead \lohead \rohead \lefoot \rofoot`; pageheadfoot font sf 9.5/12 `\lsstyle`; `\chaptermarkformat` "Chapter N: " |
| empty page style | tex/document/titlepage.tex:53; tex/document/dedication.tex:2 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| line spacing | tex/preamble/packages.tex:148; tex/preamble/settings/komaTextArea.tex:16 | `sp.setspace` | onehalfspacing; `spacing` env with 1 in TOC (toc.tex:43-44) and glossary |
| lengths | tex/preamble/settings/text.tex:6; tex/preamble/settings/floats.tex:83; tex/preamble/settings/toc.tex:51-52; tex/preamble/settings/checkMode.tex:8 | `sp.lengths` | `\parindent`=2em, `\textfloatsep`=20pt, `\@pnumwidth`=2em, `\@tocrmarg`=3em (kernel internals), `\overfullrule`=1mm |
| penalties | tex/preamble/settings/text.tex:9 | `sp.penalties` | `\interfootnotelinepenalty`=10000 |
| badness thresholds | tex/preamble/settings/text.tex:15-16 | none (log-only) | `\hbadness`, `\vbadness`=9999: change warnings only, no look |
| microtype | tex/preamble/packages.tex:59-68; tex/preamble/settings/algorithms.tex:6; tex/preamble/settings/captions.tex:15 | `sp.microtype` | final, tracking=smallcaps, stretch=10, shrink=10; `\DisableLigatures`; `\textls*` |
| manual spacing | tex/document/titlepage.tex:10-44,89-133; tex/document/dedication.tex:4,26 | `sp.manual-space` | `\vfill`, `\vspace`, `\raisebox`, `\hspace` |
| ragged text | tex/preamble/settings/dictums.tex:26-33; tex/document/dedication.tex:9-21 | `sp.ragged` | `flushleft`, `flushright` inside minipages |
| initials | tex/preamble/packages.tex:139; tex/preamble/settings/initials.tex:6-25 | `sp.lettrine` | DefaultNindent=0.5em, LettrineSecondString=X, DefaultLoversize=0.07, FontHook `\bfseries`; `\initial` wrapper never called in the sample |
| monospace font | tex/preamble/packages.tex:41-46 | `font.mono` | GoMono, type1, scale=0.88 |
| sans font | tex/preamble/packages.tex:49 | `font.helvet` | tgheros |
| font encoding | tex/preamble/packages.tex:53 | `font.fontenc-t1` | T1 |
| main text + math font | tex/preamble/packages.tex:56 | `font.charter` | mathdesign, bitstream-charter |
| font sizes | tex/preamble/settings/captions.tex:14,19,54; tex/preamble/settings/dictums.tex:18 | `font.size-commands` | `\fontsize{9.5}{12}`, `{8.8}{11}`, `{10}{12}`, `{75}{80}`, `\small`, `\Large`, `\large` |
| colours | tex/preamble/packages.tex:80; tex/preamble/settings/colors.tex:6-19 | `color.xcolor` | option table; `\definecolor` C0-C8 (rgb), anthrazit, mittelblau, hellblau (RGB) |
| contour | tex/preamble/packages.tex:83; tex/preamble/settings/graphics.tex:41 | `mark.contour` | `\contourlength{1.5pt}`; `\contour` not called in the sample |
| overlay on every page | tex/preamble/packages.tex:121; tex/preamble/settings/watermarks.tex:6-49; tex/preamble/settings/flipBook.tex:49-74 | `bg.tikzpagenodes` | `\AddEverypageHook` + `tikzpicture[remember picture,overlay]` nodes: ART (see Blockers) |
| languages | tex/preamble/packages.tex:2; tex/document/titlepage.tex:4; tex/document/abstract.tex:1,9 | `lang.babel` | ngerman, main=american; `otherlanguage`, `\foreignlanguage` |
| quotes | tex/preamble/packages.tex:5 | `lang.csquotes` | loaded for biblatex |
| PDF metadata and links | tex/preamble/packages.tex:160; tex/preamble/settings/hyperref.tex:6-24; tex/document/titlepage.tex:125 | `meta.hyperref` | pdftitle, pdfauthor, pdfcreator, pdfborderstyle={/S/U/W 1}, link border colours C1/C0, bookmarksnumbered, bookmarksopen; `\href` |
| URLs | tex/preamble/packages.tex:157 | `meta.url` | hyphens |
| bookmarks | tex/preamble/packages.tex:169; tex/document/contents.tex:2 | `meta.bookmark` | `\pdfbookmark[section]{\contentsname}{toc}` |
| cross-references | tex/preamble/packages.tex:205-212; tex/preamble/settings/crossReferences.tex:6-40; tex/document/1_introduction.tex:167-177 | `xref.cleveref` | capitalise, nameinlink, ngerman,english; `\crefname`/`\Crefname` for 12 types; `\creflastconjunction` (text.tex:83) |
| labels, `\nameref`, `\eqref` | tex/preamble/packages.tex:145; tex/preamble/settings/crossReferences.tex:43-44; tex/preamble/settings/hyperref.tex:27 | `xref.hyperref` | `\hyperlink`, `\nameref*`, `\hyperref`; `\thmref`/`\eqref` are aliases |
| `\label`, `\ref` | tex/document/2_flux_capacitor.tex:9; tex/document/abstract.tex:5 | `xref.kernel` | `\label{chap:flux_cap}` |
| title page | tex/document/titlepage.tex:1-50 | `front.titlepage-env` | `titlepage` env, centred, `\vfill` between blocks, `tabular` of examiners, logo `\includegraphics[width=60mm]`, German text |
| imprint page | tex/document/titlepage.tex:52-141 | `front.dedication` | hand-laid copyright/licence/version page, `\small`, parindent 0, hangindent badge; version text from Lua (EXTERNAL) |
| meta-data strings | tex/preamble/settings/metaData.tex:6-26 | `front.titlepage-env` | `\newcommand*` aliases holding plain text (content) |
| dedication | tex/document/dedication.tex:1-28; tex/preamble/settings/dictums.tex:17-22 | `front.dedication` | `\vspace*{\fill}`, minipages 0.865/0.65 `\textwidth`, `\hugequote` (grey 0.6 quote mark) |
| minipage boxes | tex/document/dedication.tex:6-24; tex/preamble/settings/dictums.tex:24-38 | `box.minipage` | widths 0.865, 0.65, 0.54 `\textwidth` |
| abstract | tex/document/abstract.tex:1-17 | `abs.class-native` | no `abstract` env: `\addchap` + `\section*` for English and German (flag macros in body: Blockers) |
| preface | tex/document/preface.tex:1-13 | `abs.class-native` | `\addchap{Preface}`, plain paragraphs |
| table of contents | tex/document/contents.tex:3; tex/document/floats.tex:10-16 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables`, `\listofalgorithms`, `\listofmytheorems` |
| new lists and entry styles | tex/preamble/settings/toc.tex:6-34,43-44 | `toc.tocbasic` | `\DeclareNewTOC` loa: type=algorithm, name=Algorithm, listname={List of Algorithms}, float, floattype=4, floatpos=tp, counterwithin=chapter, tocentrynumwidth=2.3em, tocentryindent=0em; lop: type=mytheorem; `\DeclareTOCStyleEntry[indent=0em]`; `\AfterTOCHead`, `\AfterStartingTOC` |
| list-of heading level | tex/preamble/settings/komaTextArea.tex:18 | `toc.koma` | listof=leveldown |
| mini TOC (defined, never called) | tex/preamble/packages.tex:133; tex/preamble/settings/minitoc.tex:58-79 | `toc.etoc` | `\localtableofcontents` in `wrapfigure` + `mdframed` |
| heading fonts | tex/preamble/settings/headings.tex:6; tex/preamble/settings/dictums.tex:6 | `head.koma-fonts` | disposition = `\normalcolor\bfseries\setstretch{1}`; dictum `\rmfamily` |
| chapter and section heading looks | tex/preamble/settings/headings.tex:9-10,59,108-151 | `head.class-native` | `\chapterformat`, `\chapterlinesformat`, beforeskip/afterskip=5em, section beforeskip, `\Large`/`\large`, paragraph beforeskip |
| chapter dictum | tex/preamble/settings/dictums.tex:8-14; tex/document/1_introduction.tex:1-5 | `head.class-native` | `\setchapterpreamble`, `\setdictum[width]{text}{author}` |
| section numbering | tex/preamble/settings/komaTextArea.tex:12; tex/preamble/settings/toc.tex:47 | `num.secnumdepth` | numbers=noendperiod; tocdepth = `\sectionnumdepth` |
| counters | tex/preamble/settings/captions.tex:76; tex/preamble/settings/theorems.tex:26-28 | `num.counters` | `\renewcommand*{\thesubfigure}{\Alph{subfigure}}` |
| appendix | tex/thesis.tex:59-62 | `num.appendix` | `\appendix` before the chapter "Proofs" |
| lists | tex/preamble/packages.tex:107; tex/preamble/settings/text.tex:26-33 | `list.enumitem` | `\setlist` leftmargin=`\parindent`, itemsep=0pt, topsep=0.5em; no list in the sample body |
| inline marks | tex/document/1_introduction.tex:14; tex/preamble/settings/algorithms.tex:10-35 | `mark.kernel` | `\texttt`, `\textbf`, `\emph` |
| units | tex/preamble/packages.tex:118; tex/preamble/settings/mathematics.tex:22-32 | `mark.siunitx` | binary-units=true; inter-unit-product, per-mode=fraction, exponent-product; `\DeclareSIUnit{\permille}` |
| maths | tex/preamble/packages.tex:14; tex/document/1_introduction.tex:30-37; tex/preamble/notation.tex:310-323,337,363 | `math.mathtools` | `gather`; `\DeclareMathOperator`; `\boldsymbol` (amsmath through mathtools) |
| display maths | tex/document/1_introduction.tex:30-37 | `math.amsmath` | `gather` numbered equations |
| equation numbers left | tex/thesis.tex:5-8 | `math.eqnumber` | class option `leqno` |
| theorem engine | tex/preamble/packages.tex:17,20; tex/preamble/settings/theorems.tex:102-167; tex/preamble/settings/mathematics.tex:14 | `thm.thmtools` | `\declaretheoremstyle` headformat/notefont/headpunct/bodyfont; `\declaretheorem` definition, theorem, proposition, lemma, shortlemma, corollary, shortcorollary with numberwithin=chapter, numberlike=definition |
| theorem and proof base | tex/preamble/packages.tex:17; tex/preamble/settings/mathematics.tex:14-19 | `thm.amsthm` | `\qedsymbol` blue `\blacksquare`; own `proof` environment |
| theorem frame style | tex/preamble/packages.tex:124; tex/preamble/settings/theorems.tex:6-23,129 | `thm.mdframed` | thmmdfstyle: inner margins 13/7/5/6pt, linewidth=1pt, linecolor=mittelblau, backgroundcolor=mittelblau!10, split skips; the TikZ parts are ART |
| frame boxes | tex/preamble/packages.tex:124; tex/preamble/settings/floats.tex:6-23,66-67; tex/preamble/settings/minitoc.tex:6-18 | `box.mdframed` | floatmdfstyle, minitocmdfstyle: margins 7/7/7/6pt, roundcorner=10pt, linewidth=1pt, linecolor mittelblau, backgroundcolor mittelblau!10, shadow=true, framemethod=tikz (shadow TikZ is ART) |
| float graphics | tex/document/1_introduction.tex:53-88; tex/preamble/settings/graphics.tex:6 | `fig.graphicx` | `figure`, `\includegraphics`, `\graphicspath{{../gfx/}}` |
| subfigures | tex/preamble/packages.tex:89; tex/document/1_introduction.tex:54-69 | `fig.subcaption` | `subfigure` width 65mm, three panels; `\thesubfigure` uppercase |
| side captions | tex/preamble/packages.tex:92; tex/preamble/settings/captions.tex:44-50 | `fig.floatrow` | `SCfigure`/`SCtable`, `\sidecaptionrelwidth`=50 |
| wrapped figure | tex/preamble/packages.tex:136; tex/preamble/settings/minitoc.tex:61 | `fig.wrapfig` | `wrapfigure` right, only inside the unused `\minitoc` |
| float placement | tex/preamble/settings/floats.tex:54-55,80 | `fig.placement` | default `tp` (`\fps@figure`, `\fps@table`), `\floatpagefraction`=0.73 |
| included PDFs | tex/preamble/packages.tex:142 | `pg.include-pdf` | loaded, never called |
| page breaks | tex/document/contents.tex:5; tex/thesis.tex:54-56 | `pg.break` | `\cleardoublepage`, `\include` of three chapters and one appendix |
| tables | tex/preamble/packages.tex:95,98,104; tex/document/1_introduction.tex:39-51; tex/preamble/settings/tables.tex:6-14 | `tbl.tabular` | `tabular`, `\newcolumntype` L, D, R (`p{#1}` with ragged variants) |
| table width | tex/preamble/packages.tex:98 | `tbl.tabularx` | loaded, not used in the sample |
| table rules | tex/preamble/packages.tex:101; tex/document/1_introduction.tex:41-47; tex/preamble/settings/tables.tex:66-67 | `tbl.booktabs` | `\toprule \midrule \bottomrule`; `\heavyrulewidth`=0.10em, `\lightrulewidth`=0.06em |
| table colours | tex/preamble/packages.tex:80; tex/preamble/settings/tables.tex:16-28 | `tbl.colortbl` | `\rowcolors`, `\rowcolor`, `\arrayrulecolor`; colours mittelblau!10/!20/!40 |
| cell packages | tex/preamble/packages.tex:86,104; tex/document/progress.tex:25-33 | `tbl.multirow` | `multirow` loaded; `cellspace` loaded for cell padding (judgement call: no lib line names it); `\multicolumn` in the progress table |
| captions | tex/preamble/packages.tex:89; tex/preamble/settings/captions.tex:6-76; tex/preamble/settings/captions.tex:45-46 | `cap.caption` | `\captionsetup` format=hang-like custom, labelformat custom (sf bold 9.5/12, uppercase, `\textls*`, mittelblau), labelsep=quad; `[sub]` set; `\AtBeginEnvironment{SCfigure}` sets format |
| algorithms | tex/preamble/packages.tex:163,166; tex/document/1_introduction.tex:90-165; tex/preamble/settings/algorithms.tex:9-57 | `alg.algorithmicx` | `[noend]`; `\algrenewcommand` for ~20 keywords (bold), `\alglinenumber` footnotesize anthrazit; `\algorithmicindent`=`\widthof{AB}`; float env comes from `toc.tocbasic` |
| bibliography | tex/preamble/packages.tex:193-202; tex/document/bibliography.tex:1-8 | `bib.biblatex-biber` | giveninits=true, date=year, style=alphabetic, maxalphanames=1; `\printbibliography[title,heading=myheading,postnote=mypostnote]`; biber (tex/SConscript:30) |
| glossary | tex/preamble/packages.tex:178-189; tex/document/glossary.tex:1 | `idx.glossaries` | toc, nopostdot, indexonlyfirst, ucmark, nohypertypes=main; `\printglossary[title=...]`; custom index builder is EXTERNAL |
| dummy text | tex/preamble/packages.tex:11; tex/preamble/settings/dummyText.tex:6-9; tex/document/1_introduction.tex:180,187,193 | `draft.todo` | `blindtext[math]` (`\blindtext`, `\blindmathpaper`); filler content |
| draft aids | tex/preamble/packages.tex:31,37; tex/preamble/settings/checkMode.tex:12; misc/hyphenationWhitelist.txt | `draft.todo` | `lua-check-hyphen[mark]` with `\LuaCheckHyphen{whitelist=...}`; `lua-visual-debug`; both LuaLaTeX-only (considered as the lib's "drafting-aid package is the parameter") |
| progress page (draft mode) | tex/document/progress.tex:1-96 | `tbl.booktabs` | `\toprule/\midrule/\bottomrule`, `@{}` spacing, `*{5}{D{8mm}}`; totals row from Lua (Blockers) |
| progress glyphs | tex/document/progress.tex:13-22 | `art.tikz` | tiny tick/cross `\tikz` drawings in cells (content-opaque) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| meta-data macros `\thetitle` ... `\theexaminerii` | tex/preamble/settings/metaData.tex:6-26 | yes | plain text aliases; content of `front.titlepage-env` |
| chapter number disc, `\mychapterlinesformat`, `\chaptertitle` | tex/preamble/settings/headings.tex:13-56 | no | TikZ shading circle with `\ifthenelse` per-digit offsets: ART/BESPOKE |
| ornament flags and heading hook, `\fillsectionornament`, `\fillsubsectionornament` | tex/preamble/settings/headings.tex:82-147 | no | flag-driven output in the heading `font` key; images from Python |
| `\longchapter`, `\longsection`, `\addlongchap` | tex/preamble/settings/headings.tex:71-79 | yes | alias of `\chapter[toc]{title}` plus `\chaptermark{mark}` (`head.class-native`, `hf.scrlayer-scrpage`) |
| `\paragraph`/`\subparagraph` appending a period | tex/preamble/settings/headings.tex:154-167 | yes | write the period in the heading text (content) |
| `\setdictum`, `\cleanchapterquote`, `\hugequote` | tex/preamble/settings/dictums.tex:9-38 | yes | `\setchapterpreamble` + nested `minipage`, `flushleft`/`flushright`, `\fontsize{75}{80}`, grey 0.6 (`head.class-native`, `box.minipage`, `sp.ragged`, `font.size-commands`, `color.xcolor`) |
| `\initial` | tex/preamble/settings/initials.tex:19-25 | yes | `\lettrine[findent=-d,nindent=d+DefaultNindent]` (`sp.lettrine`) |
| float wrapper patches (`\@xfloat`, `\end@float`, `\ftype@table`) | tex/preamble/settings/floats.tex:61-67 | no | the frame would be an explicit `mdframed` wrapper, but its style carries ART shadows and the `\ftype@table` alias has no lib way |
| `\endSC@float` and `\subcaption@minipage` patches | tex/preamble/settings/floats.tex:69-76 | no | package internals patched; the visible effect is `\centering` and 17pt less width |
| caption formats and label formats | tex/preamble/settings/captions.tex:6-76 | yes | `cap.caption` with `format=hang`, `font=small`, custom `labelformat`; the format body repeats caption's own hang code as I recall it (caption.sty is not in the zip, not re-read) |
| table row/rule colour macros `\setnumberoftableheaderrows`, `\rowstyle`, `\autorowcolor`, `\toprulec` ... | tex/preamble/settings/tables.tex:23-63, 69-108 | no | `\rownum` parity conditionals choose printed colours; defined but not called in the sample |
| algorithm internals patches | tex/preamble/settings/algorithms.tex:51, 59-66 | no | `\ALG@beginalgorithmic` and `\theHALG@line` edited |
| thmtools list-of hook | tex/preamble/settings/toc.tex:36-39 | no | uses `\thmt@envname` and `\ll@...` internals; the published alternative is `\listoftheorems`, not shown to give the same output |
| mdframed torn-page decoration, `my random steps`, `\xpatchcmd{\mdf@put@frame@i}` | tex/preamble/settings/theorems.tex:25-100 | no | `\pgfdeclaredecoration`, random seeds, clip paths hooked into mdframed internals |
| `proof` environment redefinition | tex/preamble/settings/mathematics.tex:17-19 | yes | `\noindent`, `\formatcaption` head, `\qed` (`thm.amsthm`) |
| `\mathcode` of `l` | tex/preamble/settings/mathematics.tex:6-11 | no | active math character with `\ifnum\the\mathgroup` test |
| `\hms` | tex/preamble/settings/mathematics.tex:36-66 | no | expl3 code on siunitx internals; not called in the sample |
| `\DeclareSIUnit{\permille}` | tex/preamble/settings/mathematics.tex:32 | yes | `mark.siunitx` declaration |
| `\todo`, `\dummytext`, `\currentname` | tex/preamble/settings/dynamic.tex:6,15-20; tex/preamble/settings/dummyText.tex:6-9 | yes | `\textcolor{red}{TODO: text}` plus `\blindtext`; `\GenericWarning` only writes to the log |
| version macros through Lua | tex/preamble/settings/dynamic.tex:23-39; lua/version.lua:1-68 | no | shell commands and a file counter: EXTERNAL |
| `\isincluded`, `\pagedifference` | tex/preamble/settings/dynamic.tex:9-12, 42-52 | no | conditional over `\@partlist`; never called in the sample |
| text box macros | tex/preamble/settings/text.tex:35-79 | no | `\setbox`/`\mathpalette` width measuring; `\punctfix` (text.tex:23) alone is reducible to `\hspace{-0.05em}` |
| glossary and notation engine, `\newnamecommand` | tex/preamble/settings/glossary.tex:5-234; tex/preamble/notation.tex:1-363 | no | see Blockers |
| plain math macros in the notation file (`\norm`, `\diff`, `\vec`->`\boldsymbol`, `\DeclareMathOperator` ...) | tex/preamble/notation.tex:303-363 | yes | `\newcommand` aliases of amsmath constructs (`math.amsmath`); coupling to `\newnotationcommand` is the blocker above |
| biblatex customisation | tex/preamble/settings/bibliography.tex:9-71, 113-131 | yes | `\DeclareFieldFormat`, `\DeclareNameAlias`, `\DeclareCiteCommand`, `\defbibheading`, `\defbibnote` are documented biblatex declarations (`bib.biblatex-biber`) |
| biblatex macro rewrites | tex/preamble/settings/bibliography.tex:73-110 | no (borderline) | `\renewbibmacro*{issue+date}`, `\MakeTitleCase` with `\ifentrytype` conditionals replace code |
| etoolbox toggles and partial compile | tex/preamble/switches.tex:11-65; tex/preamble/packages.tex:29-38,172-190 | no | switches choose which packages load and which pages print |
| `\is@thispageodd`, page counters, flip book index | tex/preamble/settings/flipBook.tex:7-46 | no | KOMA internal redefined |
| progress totals in Lua | lua/progressTable.lua:1-73 | no | parses the .tex source with `io.lines` |
| `\GenericWarning`/`silence`/`\msg_redirect_name` | tex/preamble/packages.tex:112-115, 151; tex/preamble/settings/theorems.tex:100 | yes | log filtering only, no printed effect; an emitter omits them |

## Content-opaque
- Figure artwork: `bsplHier_1`, `bsplHier_2` PDFs made by gfx/py/bsplHier.py (tex/document/1_introduction.tex:55,61,75); `sparseGrid.pdf` from gfx/tex/sparseGrid.tex, a `standalone` file that runs Python through the `python` package (gfx/tex/sparseGrid.tex:2-6,14-50; EXTERNAL tool, but figure content). None of these PDFs are in the zip.
- Flip-book PDFs `flipBookSG_*`, `flipBookBSpline_*` (tex/preamble/settings/flipBook.tex:60,67; produced by gfx/py/flipBook*.py); optional, off by default (tex/preamble/switches.tex:32).
- TikZ tick and cross glyphs in table cells (tex/document/progress.tex:13-22).
- Algorithm body, equations, bibliography entries (bib/bibliography.bib), dummy text.

## Lib changes
- New ways proposed: none. Considered and folded: `lua-check-hyphen` and `lua-visual-debug` into `draft.todo` (a drafting-aid package is the parameter, as `lipsum`); `everypage` into `bg.tikzpagenodes` (the hook body is a TikZ overlay); `cellspace` into `tbl.multirow` (judgement call); `\hbadness`/`\vbadness` are log thresholds with no printed effect, so no way is assigned.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
