no

# 0823-latextemplates-ieee-enhanced: Enhanced IEEE conference template (latextemplates/ieee-enhanced)

- Unverified: read from the source, not compiled.
- Source: Source/0823-latextemplates-ieee-enhanced/ (origin: https://codeload.github.com/latextemplates/ieee-enhanced/zip/refs/heads/main; licence: 0BSD)
- Kind: conference
- Lib: v6
- Engine: pdfLaTeX-compatible (dual-engine: `\ifluatex` branches add fontspec, unicode-math, selnolig, impnattypo, spelling and the markdown package under LuaLaTeX, paper-basic-listings.tex:80-94,128-130,153-156,438-475; the zip's own default compiler is LuaLaTeX, .latexmkrc:1)
- Look carried by: mixed (the published class IEEEtran carries page, title block, headings and captions; the sample preamble adds fonts, microtype, links, listings, tables and review aids; no zip-local class or style)
- Class origin: tex-distribution-unbundled
- Main file: paper-basic-listings.tex (other samples: paper.tex, the minted variant; includes commands.tex)
- Read: main yes, zip-local classes and styles none present (the only zip-local style is the BibTeX style IEEEtranN-doi.bst: lines 1-80 and the DOI function outline read, not all 2780 lines; IEEEtran.cls is not bundled and was not read)

## Verdict
No. The look is a published class (IEEEtran, `class.ieeetran`) plus published packages that all map to lib ways, but the sample preamble also holds four pieces of code that are not a composition of lib ways: an end-of-document hook that tests column state (paper-basic-listings.tex:27-29), a `\patchcmd` into natbib internals (:305-308), an expl3 renderer for the markdown package (:460-474, LuaLaTeX branch only) and the `ltgexample` self-listing environment built on `\inputlineno` counters (:534-568). Under pdfLaTeX (the Flouest engine) the expl3 renderer drops out, the other three remain. The other sample paper.tex additionally loads `minted` unconditionally (paper.tex:160), which is `EXTERNAL/package`; it does not decide the verdict of the main sample.

## Blockers
- `BESPOKE/preamble` hand-written `\AtEndDocument` hook with `\if@firstcolumn\ifdim\pagetotal>\z@\newpage\hbox to\columnwidth{}\fi\fi` that forces the last page to balance (paper-basic-listings.tex:27-29)
- `BESPOKE/preamble` `\patchcmd{\NAT@test}{\else \NAT@nm}{\else \NAT@hyper@{\NAT@nm}}` edits natbib's internal macro, no option of a published package does it (paper-basic-listings.tex:305-308)
- `BESPOKE/preamble` expl3 `\ltg_markdown_link:nnnn` with `\bool_lazy_all:nTF` and `\str_if_eq_p:nn` decides how markdown links print, installed with `\markdownSetup{renderers=...}` (paper-basic-listings.tex:460-474, inside `\ifluatex`)
- `BESPOKE/preamble` environment `ltgexample`: `\LTGbeginlineexample=\numexpr\inputlineno+1\relax`, `\tcbinputlisting` with `firstline`/`lastline` from those counters and `\currfilepath`, used about 40 times in the body (paper-basic-listings.tex:534-568, e.g. :724-743)
- `EXTERNAL/package` (other sample paper.tex only, not the main sample) `\usepackage[newfloat]{minted}` loaded unconditionally, needs Python and latexminted (paper.tex:160; README.md:23)

## Class setting
- Class: `class.ieeetran` options: `conference`, `a4paper`, `english`, version check `[2015/08/26]` (paper-basic-listings.tex:16); not bundled, the sample says to use the distribution's copy (paper-basic-listings.tex:15), Texlivefile:78 lists `ieeetran`
- Class-native vocabulary used: `\IEEEauthorblockN`, `\IEEEauthorblockA`, `\and` (paper-basic-listings.tex:638-646), `abstract` environment (:679-682), `\IEEEpeerreviewmaketitle` (:692), `\section*{Acknowledgment}` (:1228); named but commented out or inside `\iffalse`: `\IEEEspecialpapernotice` (:650), `\IEEEoverridecommandlockouts`/`\IEEEpubid` (:670-676), `\IEEEtriggeratref` (:1240), `\IEEEbibitemsep` (:1245)

## Component map
Line numbers are in the file named in the row; paths are relative to Source/0823-latextemplates-ieee-enhanced/.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | paper-basic-listings.tex:16 | `class.ieeetran` | conference, a4paper, english; class source not read |
| paper size, two columns | paper-basic-listings.tex:16 | `page.class-options` | a4paper; the two-column conference layout is class-native (not read) |
| PDF backend flag | paper-basic-listings.tex:1 | `meta.pdf-params` | `\ifdefined\pdfoutput\pdfoutput=1\fi` |
| last-page column balance | paper-basic-listings.tex:23 | `cols.balance` | `flushend` (load-only; its `\flushcolsend` is used inside the bespoke hook at :27-29) |
| float placement, footnotes below floats | paper-basic-listings.tex:357-358 | `cols.cuted` | `stfloats`, `\fnbelowfloat` |
| header/footer, page numbers | paper-basic-listings.tex:655-657 | `hf.class-native` | no page numbers by default (comment); `\pagestyle{plain}` stays commented |
| code face (pdfTeX branch) | paper-basic-listings.tex:90 | `font.mono` | `newtxtt` zerostyle=b, scaled=.75 |
| encoding (pdfTeX branch) | paper-basic-listings.tex:93 | `font.fontenc-t1` | `[T1]` |
| fonts (LuaTeX branch) | paper-basic-listings.tex:81-82 | `font.fontspec`, `font.unicode-math` | `fontspec[no-math]`, `unicode-math`; no `\setmainfont` call |
| ligature control (LuaTeX branch) | paper-basic-listings.tex:86 | `sp.selnolig` | load-only |
| roman text face | paper-basic-listings.tex:16 | `class.ieeetran` | no roman font package is loaded; the face is the class default (not read) |
| protrusion, expansion | paper-basic-listings.tex:98-104,107 | `sp.microtype` | babel=true, expansion=alltext, protrusion=alltext-nott, final; `\DisableLigatures{encoding=T1, family=tt*}` |
| widows, clubs, display widow | paper-basic-listings.tex:117,120 | `sp.penalties` | `nowidow[all,defaultlines=3]`, `\displaywidowpenalty=10000` |
| last paragraph line | paper-basic-listings.tex:128-130 | `NEW:sp.impnattypo` | `impnattypo[lastparline]` under `\ifdefined\directlua` |
| rectangular paragraphs (off) | paper-basic-listings.tex:140-145 | `sp.lengths` | `\parfillskip` 0pt, `\emergencystretch` 3em; switch false (:141 commented) |
| hyphenation | paper-basic-listings.tex:603,606-610 | `sp.hyphenat` | `\input{ushyphex}` (TeX Live hyphenex file, Texlivefile:77), `\hyphenation{...}` list |
| languages | paper-basic-listings.tex:44,46,49 | `lang.babel` | `[ngerman,main=english]`; `\addto\captionsenglish{\renewcommand{\figurename}{Fig.}}`; `\languageshorthands{ngerman}\useshorthands{"}` |
| quotation marks | paper-basic-listings.tex:274,277-278,820 | `lang.csquotes` | `autostyle=true`, `\defineshorthand{"`}{\openautoquote}`, body `\enquote` |
| URLs | paper-basic-listings.tex:54,61-63 | `meta.url` | `url[hyphens]`; break list extension (see Bespoke code) |
| links, PDF view | paper-basic-listings.tex:478-489 | `meta.hyperref` | hidelinks, colorlinks=true, raiselinks=true, allcolors=black, pdfstartview=Fit, breaklinks=true, hypertexnames=false; body `\href` (:708) |
| float link anchors | paper-basic-listings.tex:492 | `xref.hypcap` | `[all]` |
| copyable PDF text (pdfTeX branch) | paper-basic-listings.tex:627-628 | `meta.glyphtounicode` | `\input{glyphtounicode}`, `\pdfgentounicode=1` |
| listing arrow hidden from copy | paper-basic-listings.tex:163,219 | `meta.accsupp` | `\BeginAccSupp{ActualText={}}` ... `\EndAccSupp{}` inside `postbreak` |
| upright quotes in verbatim | paper-basic-listings.tex:38 | `code.upquote` | load-only |
| colours | paper-basic-listings.tex:158,165-167 | `color.xcolor` | `[dvipsnames, table]`; eclipseStrings RGB 42,0,255; eclipseKeywords RGB 127,0,85; numb = magenta!60!black |
| title block | paper-basic-listings.tex:635-647,653 | `front.class-native` | `\title` with `\\`, two `\IEEEauthorblockN/A` blocks joined by `\and`, `\maketitle` |
| peer-review title | paper-basic-listings.tex:692 | `front.class-native` | `\IEEEpeerreviewmaketitle` (ignored outside peer-review mode, comment :690-691) |
| abstract | paper-basic-listings.tex:679-682 | `abs.class-native` | `abstract` environment with `\lipsum[1]` content |
| headings, numbering | paper-basic-listings.tex:694,702,716,722,1228 | `head.class-native` | `\section`, `\subsection`, `\section*` with the class's own style (not read) |
| lists | paper-basic-listings.tex:1116-1157 | `list.kernel`, `list.paralist` | itemize, enumerate; `paralist` (:284): compactitem, compactenum, inparaenum |
| footnotes | paper-basic-listings.tex:708-710 | `fn.kernel` | `\footnote{\url{...}}` |
| figures | paper-basic-listings.tex:830-835,864-872,890-898 | `fig.graphicx`, `sp.ragged` | figure and `figure*`, `\centering`, width=.75\linewidth / .8\linewidth / .5\linewidth / .6\textwidth; JPEG at :880 is shipped (figures/ulm-minster.jpg), `example-image-*` come from `mwe` (:528) |
| sub-figures | paper-basic-listings.tex:494,907-916 | `fig.subcaption`, `sp.manual-space` | `subfig[caption=false,font=footnotesize]`, `\subfloat[..]`, `\hfil`, `figure*[!t]` |
| captions | paper-basic-listings.tex:833,867-870 | `cap.kernel` | `\caption`, `\caption[short]{long}`; the style is the class's (not read); "Fig." from :46 |
| tables | paper-basic-listings.tex:837-849,994-1006 | `tbl.tabular`, `tbl.booktabs` | `tabular{ll}`, `\toprule \midrule \bottomrule` (:281); `\extrarowheight` 1pt (:340) |
| coloured cells | paper-basic-listings.tex:1018-1021 | `tbl.colortbl` | `\rowcolor{gray!20}`, `\cellcolor{green!20}` |
| diagonal header, row spans | paper-basic-listings.tex:151,334,1036 | `tbl.multirow` | `diagbox`, `multirow` |
| decimal columns, long tables | paper-basic-listings.tex:337,351 | `tbl.siunitx`, `tbl.longtable` | `dcolumn`, `longtable` loaded; no `D` column or `longtable` environment in the body |
| source code | paper-basic-listings.tex:160,172-198,200-241,1052-1108 | `code.listings`, `font.size-commands` | `\lstdefinelanguage{json}` (string, comment, literate colouring of digits), `\lstset{escapeinside={(*}{*)}, language=json, basicstyle=\footnotesize\ttfamily, breaklines, breakatwhitespace, columns=flexible, tabsize=2, numbers=left, numberstyle=\tiny, basewidth=.5em, xleftmargin=.5cm, captionpos=b, postbreak=...}`; pdfTeX branch adds `extendedchars`, `literate` accents (:247-260); body `lstlisting` with `float`, `caption`, `label` |
| inline verbatim | paper-basic-listings.tex:761,1212 | `code.verbatim` | `\verb1...1`, `\verb\|...\|` |
| units and numbers | paper-basic-listings.tex:433,804-814 | `mark.siunitx` | `siunitx[group-minimum-digits=4,per-mode=fraction]`; `\SI`, `\num` |
| bibliography | paper-basic-listings.tex:293-298,301,1248,1250 | `bib.natbib`, `bib.bibtex-bst` | `natbib[square,comma,numbers,sort]`, `\renewcommand{\bibfont}{\normalfont\footnotesize}`, style `IEEEtranN-doi` (zip-local .bst, derived from IEEEtranN.bst 1.14, IEEEtranN-doi.bst:2-8), `\bibliography{paper}`; citations `\citep` `\citet` `\cite` (:705-706,1230) |
| cross-references | paper-basic-listings.tex:511-521,698 | `xref.zref`, `xref.kernel` | `zref-clever`: `\zcsetup{cap, nameinlink=true}`, `\zcLanguageSetup{english}{type=figure, Name-sg=Fig., Name-pl=Figs., type=equation, Name-sg-ab={}, Name-pl-ab={}}`, `\zcRefTypeSetup{equation}{abbrev}`; body `\zcref`, `\Zcref`, `\label` |
| review aids | paper-basic-listings.tex:396-412,504,523,527-528 | `draft.todo` | `pdfcomment` (`\pdfcomment[color,hoffset,voffset,opacity,icon]`), `mindflow[incolumn]` (notes set apart from the text), `lipsum`, `blindtext[math]`, `mwe` |
| inline marks | paper-basic-listings.tex:428,431; commands.tex:20-22 | `mark.kernel`, `color.xcolor` | `\color{red}`, `\color{blue!60!black}`, `\textlcc` from `lccaps` (:614; CTAN: lowercased small caps) |
| TeX-system logos | paper-basic-listings.tex:529,1193 | `font.icons` | `hologo`, `\hologo{LuaLaTeX}` |
| `\powerset` symbol | paper-basic-listings.tex:571-582 | `font.nfss` | `\DeclareFontFamily{U}{MnSymbolC}{}`, `\DeclareFontShape` size ranges, `\DeclareSymbolFont`, `\DeclareMathSymbol{\powerset}{\mathord}{MnSyC}{180}` (MnSymbol files not shipped; Texlivefile:122) |
| file inclusion | paper-basic-listings.tex:603,615 | `struct.input` | `\input{ushyphex}`, `\input{commands}` |
| page enlarge helpers | commands.tex:17-18 | `pg.enlarge` | `\largepage`, `\shortpage` = `\enlargethispage{\pm\baselineskip}` |
| Markdown input | paper-basic-listings.tex:438-450,713,1169-1190 | `NEW:struct.markdown` | `markdown` options citations, hybrid, notes, inlineNotes, pipeTables, tableCaptions, tableAttributes, headerAttributes, relativeReferences, hashEnumerators; `\markdownInput{content-markdown.md}`, `markdown` environment; LuaLaTeX only (:437) |
| self-listing example box | paper-basic-listings.tex:531-532,539-567 | `code.tcblisting`, `box.tcolorbox` | `tcolorbox` libraries listings and breakable; keys breakable, colback=green!5!white, colframe=green!25, coltitle=black!90, left=8mm, title; the line counters are bespoke (see Bespoke code) |
| figure artwork | paper-basic-listings.tex:347-348,946-989 | `art.tikz` | `pgfplots` compat=1.18; tikzpicture and axis inside figures (content, see Content-opaque) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\AtEndDocument{\flushcolsend\if@firstcolumn\ifdim\pagetotal>\z@\newpage\hbox to\columnwidth{}\fi\fi}` | paper-basic-listings.tex:27-29 | no | conditional on column state and page content that changes what is printed at the end; `flushend` alone is `cols.balance`, the hook is beyond it |
| `\patchcmd{\NAT@test}{...}` | paper-basic-listings.tex:305-308 | no | edits natbib internals to hyperlink author names in `\citet`; no published option found |
| expl3 `\ltg_markdown_link:nnnn` and `\markdownSetup{renderers={link=...}}` | paper-basic-listings.tex:460-474 | no | expl3 booleans and string tests choosing `\zcref` or the default link renderer |
| `ltgexample` environment, `\newcount\LTGbeginlineexample`, `\LTGendlineexample` | paper-basic-listings.tex:534-568 | no | `\inputlineno` and `\numexpr` counters feed `firstline`/`lastline` of `\tcbinputlisting` on `\currfilepath` (`currfile`, :530); the box itself is `code.tcblisting` |
| `\g@addto@macro{\UrlBreaks}{\UrlOrds}` | paper-basic-listings.tex:61-63 | yes (equivalence not shown) | `meta.url` with the `xurl` package (breaks URLs at more characters; package not read) |
| `\newif\ifrectangularparagraphs` and its branch | paper-basic-listings.tex:140-145 | yes | static switch, value false; if enabled print `sp.lengths` `\parfillskip=0pt`, `\emergencystretch=3em` |
| markdown heading renderers `\markdownRendererHeadingOne/Two/Three` | paper-basic-listings.tex:453-455 | yes | aliases of `\section`, `\subsection`, `\subsubsection` under `NEW:struct.markdown` |
| `\NewDocumentCommand{\Zcref}{s O{} m}` | paper-basic-listings.tex:514 | yes | alias of `\zcref[S,...]` and `\zcref*[S,...]`, `xref.zref` |
| `\textcomment`, `\sidecomment`, `\todo`, `\change` | paper-basic-listings.tex:398-412 | yes | `draft.todo` (`pdfcomment`) with `\colorbox{yellow!60}`, `\color{red}` (`color.xcolor`); option values as written |
| `\@ifundefined` fallbacks | paper-basic-listings.tex:417-425 | yes | static: only `missingfigure`, `TODO`, `todofix` are undefined at that point (the rest are defined at :398-412); print those three definitions |
| `\textmarker`, `\modified` with `\xspace` | paper-basic-listings.tex:428,431,585 | yes | inline expansion to `{\color{red}#1}` and `{\color{blue!60!black}#1}` (`mark.kernel`, `color.xcolor`); `xspace` is a macro-body helper |
| `\xspaceaddexceptions{\grqq \grq \csq@qclose@i \}}` | paper-basic-listings.tex:588 | yes | goes away with inline expansion of the `\xspace` macros; names a csquotes internal |
| `\eg`, `\ie` | paper-basic-listings.tex:591-592 | yes | text aliases `e.g.,\ ` and `i.e.,\ ` |
| `\hydash` = `\penalty\@M-\hskip\z@skip` | paper-basic-listings.tex:597 | yes | alias of primitives, not used in the body (named in a comment :595) |
| `\DeclareFontFamily` ... `\DeclareMathSymbol` | paper-basic-listings.tex:571-582 | yes | `font.nfss` with the NFSS declaration commands as written |
| commands.tex macros `\RBS`, `\mathplus`, `\toindex`, `\dotcup`, `\abs`, `\largepage`, `\shortpage`, `\initialism`, `\OMG` `\BPEL` `\BPMN` `\UML` | commands.tex:2,5,8,11,14,17-18,20-26 | yes | aliases: `\let\\=\tabularnewline`, `\providecommand`, `\index`, `\mathaccent`, `\left\lvert..\right\rvert`, `pg.enlarge`, `\textlcc` |
| engine conditionals `\ifluatex`, `\ifpdftex`, `\ifdefined\directlua` | paper-basic-listings.tex:80-94,128-130,153-156,243-261,438-475,617-629,712-714,1161-1195 | yes (per engine) | published `iftex` (:31), not zip-local; an emitter for one engine prints that engine's branch; a document that stays dual-engine needs the conditionals themselves, which no lib way holds |
| `IEEEtranN-doi.bst` | IEEEtranN-doi.bst:1-8,1983-1990 | treated as the parameter of `bib.bibtex-bst` | modified published IEEEtranN.bst (DOI after the entry, names repeated instead of a dash); shipped asset, 2780 lines, only the header and the DOI function read |

## Content-opaque
- tikzpicture grid at paper-basic-listings.tex:949-954; pgfplots axes at :967-971 and :981-985 (inside figures)
- Markdown text block at paper-basic-listings.tex:1169-1190 and content-markdown.md:1-7 (text in Markdown syntax)
- listing bodies (XML, JSON, Java) at paper-basic-listings.tex:1056-1059,1075-1077,1089-1091,1103-1107; the `ltgexample` blocks print the source of each example
- considered, no printed effect: `spelling` with `\spellingoutput{off}` (paper-basic-listings.tex:154-155, package not read); `iftex` (:31) and `currfile` (:530) are helper packages

## Lib changes
- New ways proposed:
  - `NEW:sp.impnattypo` `impnattypo` (CTAN, LPPL 1.3, Raphael Pinson, v1.8, TeX Live and MiKTeX; ctan.org/pkg/impnattypo read, its page lists no options), `\usepackage[lastparline]{impnattypo}`; engine xe/lua (the sample's comment says the lastparline veto is LuaTeX only and that the pdfTeX fallback stretches `\parfillskip`, paper-basic-listings.tex:122-130). W1 CTAN; W2 option keywords; W3 any document; W4 one preamble line. Not `sp.penalties` (widow and club parameters), not `sp.hyphenat` (hyphenation).
  - `NEW:struct.markdown` `markdown` (CTAN; linked at paper-basic-listings.tex:436,1162, listed in Texlivefile:109; its CTAN page was not read), `\usepackage[citations,hybrid,notes,...]{markdown}`, `\markdownSetup{}`, body `markdown` environment and `\markdownInput{file}`; engine xe/lua (the sample guards it with `\ifluatex` and says pdfLaTeX needs shell escape, :437, which would be EXTERNAL). W1 CTAN; W2 option and key lists; W3 any text written in Markdown; W4 preamble plus body wrapper or file input. Renderer code such as :460-474 is outside the way.
- Considered, not proposed (home in an existing way): `flushend` into `cols.balance` (a column-balancing package on the last page; suggest widening the line, package is the parameter); `pdfcomment` and `mindflow` into `draft.todo`; `lccaps` into `mark.kernel` (per CTAN built on `textcase` and `microtype`); `zref-clever` into `xref.zref`; `diagbox` into `tbl.multirow`; `dcolumn` into `tbl.siunitx`; `hologo` into `font.icons`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
