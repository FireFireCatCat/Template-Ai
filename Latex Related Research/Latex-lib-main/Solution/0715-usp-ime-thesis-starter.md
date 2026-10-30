no

# 0715-usp-ime-thesis-starter: USP/IME Thesis Starter (IME-USP thesis, article, slides, poster and cheat-sheet kit)

- Unverified: read from the source, not compiled.
- Source: Source/0715-usp-ime-thesis-starter/ (origin: https://latextemplates.com/downloads/usp-ime-thesis.zip; licence: MIT for the code, CC-BY-4.0 for the example text)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (`\ifPDFTeX` branches at imegoodies.sty:459 and imelooks.sty:481; a fontspec/unicode-math branch exists for XeLaTeX/LuaLaTeX at imegoodies.sty:484 and imelooks.sty:491-499)
- Look carried by: zip-local (imegoodies.sty and imelooks.sty over the kernel `book`, `article` and `beamer` classes; main.tex:49-50)
- Class origin: tex-distribution-unbundled (`book` is a kernel class, not in the zip; `article`, `beamer` likewise)
- Main file: main.tex, byte-identical to tese.tex (same SHA-256). The manifest names poster.tex as main (class article); the thesis is taken as primary because latexmkrc:1 and Makefile:18 build `tese`. Other samples: artigo.tex, apresentacao.tex, poster.tex, colinha.tex.
- Read: main yes (main.tex and every `\input` file under conteudo/), zip-local classes and styles all (imelooks.sty, imegoodies.sty, evenragged.sty, lstpseudocode.sty, plainnat-ime/beamer-ime .bbx .cbx .dbx). Not read: the two `.bst` files (no sample loads them), texlogsieve (7112-line Lua log filter), bibliografia.bib, grafico.py, grafico.gnuplot, euclid.psc, the pre-generated figure files beyond their first lines.

## Verdict
No. The look is defined by two zip-local style files, not by a published class. Their code is mostly declarative (published packages with options), but the thesis cover, title and verso pages are an expl3 and dimension-arithmetic engine with nested toggles (imelooks.sty:2590-2772, 2904-3339), the default bibliography style is a zip-local biblatex style that redefines bibliography macros (plainnat-ime.bbx, plainnat-ime.cbx), the pseudocode language is a zip-local listings aspect file (lstpseudocode.sty), and footnotes and a caption box redefine kernel and framed internals. None of these reduces to a lib way with parameters, so an emitter could not write them without copying zip-local macro logic. Every published package the styles load maps to a lib way (one new way is proposed for a beamer add-on); the blockers are only the bespoke parts.

## Blockers
- `BESPOKE/class` thesis front-matter engine: expl3 key parsing, nested degree/language/gender toggles, cover and title pages positioned by computed margins (imelooks.sty:2590-2772, 2300-2583, 3001-3034, 2904-2969, 3178-3339)
- `BESPOKE/class` footnote paragraph shape through `\@makefntext` with `\parshape` and `\patchcmd\maketitle` (imelooks.sty:910-964)
- `BESPOKE/class` `programruledcaption` environment: framed-box construction with saved caption box and per-segment continuation frames (imelooks.sty:1340-1407)
- `BESPOKE/package` zip-local biblatex styles `plainnat-ime` (default for theses, imelooks.sty:772) and `beamer-ime`: `\renewbibmacro*`, `\xpatchbibdriver`, `\xpatchbibmacro*`, a type-driven `\NoChangeOrSentenceCase` (plainnat-ime.bbx:25, 99-112, 116-135, 181-212, 220-230; plainnat-ime.cbx:33-84; beamer-ime.bbx:12-19)
- `BESPOKE/package` `lstpseudocode.sty`, a listings aspect and language file that patches listings internals (`\lst@BeginAspect`, `\lst@DelimOpen`); used by the sample (lstpseudocode.sty:53-242; conteudo/anexo-exemplo-pseudocodigo.tex:17-18, 41-42)
- `BESPOKE/package` `evenragged.sty` `\evenJustified`: expl3 and regex line-count algorithm that measures a box; not on CTAN (ctan.org/pkg/evenragged is a 404); no sample calls it (evenragged.sty:112-195)
- `BESPOKE/package` patches into published package internals with no look of their own: todonotes `\@todo` (imegoodies.sty:1038-1042), lineno build hook (imegoodies.sty:797-815), amsthm/hyperref head under parskip (imelooks.sty:1002-1008), beamer `\beamer@tocact` (imelooks.sty:1724), hyperref `\hyper@refstepcounter` bug workaround (imelooks.sty:3363-3374)

## Class setting
- Class: `class.book` options: a4paper, 12pt, twoside, english, brazilian (main.tex:31). Other samples: `class.article` (artigo.tex:32 a4paper,12pt,twoside; poster.tex:9 a1paper; colinha.tex:7 10pt,twoside), `class.beamer` (apresentacao.tex:13-17: xcolor/hyperref pass-through options, 12pt, aspectratio=149).
- Class-native vocabulary used: book: `\frontmatter` (main.tex:209), `\mainmatter` (343), `\backmatter` (420), `\chapter`, `\chapter*` (233), `\appendix` (390), `\cleardoublepage` (248). article: `\maketitle`, `\thanks`, `abstract` (artigo.tex:99-131). beamer: `frame` (plain, standout, allowframebreaks, t), `\titlepage`, `block`, `columns`, `\pause`, `\AtBeginSection` (apresentacao.tex:43, 168, 181, 210, 236, 307).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| page options | main.tex:31 | `page.class-options` | a4paper, 12pt, twoside; poster.tex:9 a1paper |
| page geometry | imelooks.sty:1024-1034 | `page.geometry` | textwidth=152mm, hmarginratio=12:17, textheight=237mm, vmarginratio=8:7, headsep=11mm, headheight=21mm, footskip=10mm, marginpar=20mm, marginparsep=5mm; poster left=1.5cm,right=1.5cm,top=0cm,bottom=0cm (imelooks.sty:1863); cheat sheet a4paper,landscape,textheight=192mm,textwidth=277mm (colinha.tex:12-19) |
| columns | conteudo/05-exemplo-exemplos.tex:27-53; colinha.tex:51-53 | `cols.multicol` | multicols{2}; multicols{3} with columnsep=20pt, columnseprule=.2pt |
| double-float placement | imegoodies.sty:676 | `cols.cuted` | `stfloats` loaded, no options |
| page breaks | main.tex:248, 295, 386; conteudo/05-exemplo-exemplos.tex:646; colinha.tex:146 | `pg.break` | `\cleardoublepage`, `\clearpage`, `\pagebreak`, multicol `\columnbreak` |
| flush bottom | imelooks.sty:985; main.tex:267-268 | `pg.flush` | `\flushbottom` globally, `\raggedbottom` in a group around the lists |
| enlarge page | conteudo/05-exemplo-exemplos.tex:116, 192; conteudo/03-exemplo-latex.tex:32 | `pg.enlarge` | `\enlargethispage{\baselineskip}`, `{.8\baselineskip}` |
| landscape, PDF pages, empty pages | imegoodies.sty:847, 866, 218 | `pg.landscape`, `pg.include-pdf`, `pg.emptypage` | loaded, no options; no call in the thesis body |
| running heads and feet | imelooks.sty:1957, 2016, 2031-2033, 2036-2042, 2045-2116 | `hf.fancyhdr` | page styles mainmatter, unnumberedchapter, appendix, backmatter, plain; headrulewidth=0pt; headwidth widened by right margin minus 10mm; number `\raisebox{8mm}{\footnotesize\bfseries\thepage}` at RO and LE; `\scriptsize\MakeTextUppercase{\rightmark}` at LO, `{\leftmark}` at RE; `\chaptermark`/`\sectionmark` redefined with `\markboth`/`\markright` |
| page style switches | main.tex:211, 345, 351, 353, 388, 403, 422 | `hf.pagestyle-kernel` | `\pagestyle{plain}`, `{mainmatter}`, `{unnumberedchapter}`, `{appendix}`, `{backmatter}`; colinha.tex:22 `\pagestyle{empty}` |
| page numbering | main.tex:226 | `pgnum.pagenumbering` | roman |
| line spacing | imegoodies.sty:206; main.tex:213, 348; imelooks.sty:1858 | `sp.setspace` | `\onehalfspacing` front matter, `\singlespacing` main matter; poster `\setstretch{1.1}` |
| paragraph skips | imelooks.sty:999, 973, 991 | `sp.parskip-pkg`, `sp.indentfirst`, `sp.frenchspacing` | parskip `indent,parfill`; indentfirst; `\frenchspacing` |
| TeX parameters | imegoodies.sty:161, 163, 166-171; imelooks.sty:1012; poster imelooks.sty:1856-1857 | `sp.lengths` | tolerance=800 (raw parameter filed here), emergencystretch=1.5em, hfuzz=1pt, vfuzz, hbadness=1000, vbadness=1000, parfillskip=30pt plus .9\linewidth minus 30pt, parindent=0pt, parskip=0pt |
| penalties | imegoodies.sty:162; imelooks.sty:813, 1540, 1942 | `sp.penalties` | `\hyphenpenalty` 100, 400 (ragged bibliography), 600 (slides, poster) |
| ragged text | imegoodies.sty:175, 184-186, 203; evenragged.sty:34-41; imelooks.sty:2191 | `sp.ragged` | ragged2e `newcommands`, centering restored to kernel; `\evenRaggedRight` sets `\RaggedRightRightskip`, `\RaggedRightParfillskip` (reducible, see Bespoke); `FlushRight` environment |
| microtype | imegoodies.sty:62 | `sp.microtype` | no options |
| manual space and rules | imelooks.sty:2189, 2946; colinha.tex:46 | `sp.manual-space`, `sp.rule` | `\vspace*{140mm plus 0mm minus 100mm}`; `\rule[.6ex]{.2\textwidth}{1pt}` |
| text face | imelooks.sty:476, 479, 486 | `font.libertine`, `font.mono` | libertinus `mono=false`; libertinust1math (pdfTeX); sourcecodepro `scale=.85` |
| maths face (Xe/Lua) | imelooks.sty:492-498 | `font.unicode-math` | `\setmathfontface\mathit{Libertinus Serif Italic}` |
| encodings and Latin Modern | imegoodies.sty:460, 513, 523, 533-545, 484 | `font.fontenc-t1`, `font.lmodern`, `font.exscale`, `font.nfss`, `font.fontspec` | T1; lmodern; fix-cm; `\DeclareFontShape` substitutions for bold small caps and small caps italic; fontspec only when not pdfTeX |
| ToUnicode map | imegoodies.sty:478-479 | `meta.glyphtounicode` | `\input glyphtounicode.tex`, `\pdfgentounicode=1` |
| sizes and family | imelooks.sty:2263, 1860 | `font.size-commands`, `font.family-default` | `\footnotesize`; poster `\familydefault` set to `\sfdefault` |
| ornament and logos | conteudo/03-exemplo-latex.tex:111; imelooks.sty:3571-3572 | `font.icons` | `froufrou` `\froufrou` (CTAN, LPPL 1.3c; ctan.org/pkg/froufrou read; package is the parameter), `hologo` `\hologo{XeLaTeX}` |
| colours | imegoodies.sty:238; imelooks.sty:15-28, 681-686 | `color.xcolor` | options hyperref, svgnames, x11names, table; `\definecolor` imeblue RGB 20,45,105, imeyellow 230,175,60, imered 130,20,60, imesoftblue 0,100,160, Blackish, SandyPaper, BrownishGreen, InterSCity, DarkInterSCity, PastelGreen; link colours citecolor=DarkGreen, linkcolor=NavyBlue, urlcolor=DarkRed |
| language | imegoodies.sty:361-362; main.tex:67, 87-89; imelooks.sty:359-363, 1268-1279 | `lang.babel` | babel with brazilian, english; `\babeltags{br=brazilian,en=english}`; `\babelhyphenation`; `\addto\captionsbrazilian` renames list names |
| quotes and keywords | imegoodies.sty:992, 366, 1016-1017, 1068 | `lang.csquotes`, `lang.translator` | csquotes; `\providetranslation[to=Portuguese]`, `\deftranslation` |
| PDF metadata and links | imegoodies.sty:224-233, 724, 777; imelooks.sty:670-699 | `meta.hyperref`, `meta.hyperxmp` | unicode, pdfencoding=unicode, plainpages=false, pdfpagelabels, bookmarksopen, breaklinks, hyperindex=false; colorlinks / hidelinks / border links; hyperxmp |
| url style | imegoodies.sty:728-736; imelooks.sty:522 | `meta.url` | `\DeclareUrlCommand\httpurl`, `\urlstyle{sf}` |
| float anchors | imelooks.sty:555 | `xref.hypcap` | `all` |
| cross references | main.tex:430; conteudo/05-exemplo-exemplos.tex:12, 131-135 | `xref.kernel` | `\label`, `\ref`, `\pageref`, `\eqref` |
| cover, title, verso pages | main.tex:98-194, 215; imelooks.sty:2904-3339 | none (bespoke) | `\title[sub]`, `\translatedtitle`, `\author[fem]`, `\orientador`, `\coorientador`, `\banca`, `\tipotese{...}`, `\defesa{...}`, `\apoio`, `\direitos`, `\fichacatalografica`; see Blockers |
| dates in cover | imelooks.sty:2302-2306 | `front.datetime` | datetime2 `useregional`, `\DTMusemodule{brazilian}{portuges}`, style month-year |
| dedication page | main.tex:219-222; imelooks.sty:2183-2203 | `front.dedication` | environment of `box.minipage` 100mm x 100mm, `sp.ragged` FlushRight, italic, `\vspace*` before and after |
| epigraph | main.tex:234; imelooks.sty:2129-2169 | `quote.epigraph` | epigraphwidth=.85\textwidth, epigraphrule=0pt, `\textflush`/`\sourceflush` set to a list-based environment with rightmargin 2em |
| resumo and abstract pages | conteudo/resumoabstract.tex:7-9, 14, 33; imelooks.sty:2215-2294 | none (bespoke) | `\palavraschave`, `\keywords`, `\resumo`, `\abstract`, `IMEabstract` (list with 4em margins, `description` keyword line); reducible, see Bespoke |
| contents lists | main.tex:301, 305, 311, 314, 425; imelooks.sty:586, 576, 591 | `toc.kernel`, `toc.etoc`, `num.secnumdepth` | `\listoffigures`, `\listoftables`, `\listof{program}`, `\tableofcontents`, `\addtocontents{toc}{\vspace{...}}`; tocbibind `nottoc,notlot,notlof`; secnumdepth=2, tocdepth=2 |
| headings | imelooks.sty:568; colinha.tex:28-37; imelooks.sty:600-659 | `head.titlesec` | titlesec `raggedright`; `\titleformat{\section}[hang]{\scshape\bfseries}{\thesection}{0.7em}{}`, `\titlespacing`; `\chapter**` family is bespoke but reducible |
| appendices | main.tex:390, 394, 405; imelooks.sty:3352-3353 | `num.appendix` | appendix package, `\noappendicestocpagenum`, `\addappheadtotoc` |
| lists | imelooks.sty:562; colinha.tex:26; imelooks.sty:1913-1939 | `list.kernel`, `list.enumitem` | enumitem `inline`; `\setlist[description]{itemsep=0pt,parsep=1pt,leftmargin=0pt}`; poster `\setlist[itemize,1..3]` labels and `left` |
| marks | imelooks.sty:2041-2042, 526, 531-538; imegoodies.sty:250, 995, 999 | `mark.kernel`, `mark.case`, `mark.ulem`, `mark.contour` | `\MakeTextUppercase`; `\setul{1.4pt}{.5pt}`; contour `outline`, `\contourlength{1.1pt}` |
| numbers | imegoodies.sty:1008-1019; conteudo/apendice-exemplo-faq.tex:13 | `mark.siunitx` | `\sisetup{mode=text,round-mode=places}`, decimal marker comma, `\qty{1.5}{s}` |
| footnotes | conteudo/00-exemplo-introducao.tex:58; imegoodies.sty:212, 215 | `fn.kernel`, `fn.footmisc` | footmisc `stable,bottom`; fnpct |
| review notes | imegoodies.sty:1023-1024, 1028-1035 | `note.todonotes` | `textsize=scriptsize,colorinlistoftodos,textwidth=2.5cm`, colour orange!40!white, `\hltodo` |
| display maths | conteudo/05-exemplo-exemplos.tex:138-150, 206-219; imegoodies.sty:49-58, 966 | `math.amsmath`, `math.amssymb`, `math.mathtools`, `math.physics` | equation, gather, split, displaymath; `\cancel` |
| theorem-like | imegoodies.sty:51, 54; conteudo/05-exemplo-exemplos.tex:170-190, 194-195, 222-223, 239-240, 202, 236 | `thm.amsthm`, `thm.thmtools` | `\newtheoremstyle{smile}` and `{maybe}` (3pt, 3pt, `\itshape`, `\bfseries`, .5em), `\theoremstyle`, `\newtheorem{absurd}{Pegadinha}`, `{theorem}{Teorema}`, `{conjecture}{Conjectura}`, `proof`, `\qedsymbol` emptied; thmtools loaded, no call |
| figures | imegoodies.sty:684, 834, 852; main.tex:60; conteudo/05-exemplo-exemplos.tex:299-320 | `fig.graphicx`, `fig.adjustbox`, `fig.rotating` | graphicspath; adjustbox `export`; rotating `figuresright,clockwise`; `turn` at 313, `sidewaystable` at 782 |
| subfloats | imegoodies.sty:856; conteudo/05-exemplo-exemplos.tex:302-317, 481-521 | `fig.subcaption` | subfigure widths .4\textwidth, .45, .5; subtable .45, .37 |
| float types | imegoodies.sty:626, 631-632; imelooks.sty:1298-1303, 1312-1321 | `fig.floatrow`, `fig.float` | floatplacement htbp; `\DeclareNewFloatType{program}{placement=htbp,fileext=lop,within=chapter}`, `\floatsetup[program]{style=ruled,precode=customrule}`; `\newfloat{program}{htbp}{lop}[chapter]` fallback |
| float placement | imegoodies.sty:595-614, 643, 646 | `fig.placement` | topfraction .8, floatpagefraction .66, dblfloatpagefraction .66, topnumber 3, bottomnumber 2, totalnumber 5; flafter; fewerfloatpages |
| tables | imegoodies.sty:907, 931-946, 949, 919, 922, 926, 876, 888; conteudo/05-exemplo-exemplos.tex:486-495, 764-767 | `tbl.tabular`, `tbl.booktabs`, `tbl.colortbl`, `tbl.longtable`, `tbl.multirow`, `tbl.threeparttable` | array `\newcolumntype{M,L,R,J}`; booktabs `\heavyrulewidth=.08em`, `\lightrulewidth=.05em`, `\cmidrulewidth=.03em`, rule seps; `\rowcolors{2}{lightgray!70}{white}`; longtable with `\endfirsthead`..`\endlastfoot`; `\makecell`, `\rothead`; threeparttable notes `\footnotesize\itshape` (imelooks.sty:898-899); tablefootnote |
| numeric table columns | imegoodies.sty:1008; conteudo/05-exemplo-exemplos.tex:554-571 | `tbl.siunitx` | `S` columns, table-format=1.4 and 2.4, round-precision=4, table-number-alignment=left |
| captions | imelooks.sty:1043-1047, 1053, 1324 | `cap.caption`, `cap.kernel` | font=small, format=plain, labelfont={bf,up}, textfont={normalfont,it}; `\captionsetup*[longtable]{position=bottom}`; `[program]{style=ruled,position=top}`; `\caption` at conteudo/05-exemplo-exemplos.tex:305 |
| source code | imelooks.sty:1163-1164, 1185-1263; conteudo/05-exemplo-exemplos.tex:394-407; conteudo/anexo-exemplo-pseudocodigo.tex:16-26 | `code.listings` | listings and lstautogobble; `\lstset` (numbers=left, stepnumber=1, numbersep=20pt, breaklines, tabsize=2, framesep=5pt, accented-letter `literate` table); styles wider, nocolor; XML language; `lstinputlisting`; pseudocode language is bespoke |
| verbatim | imegoodies.sty:789-790; conteudo/00-exemplo-introducao.tex:71 | `code.verbatim` | verbatim, fvextra |
| boxes | imelooks.sty:1341, 2192, 3143, 3209, 3240, 3326 | `box.mdframed`, `box.minipage` | framed (only inside `programruledcaption`); minipages 100x100mm, 160x20mm, 96x56mm, 160x130mm, 80x55mm |
| bibliography | main.tex:76, 429-433; imelooks.sty:796-803, 772, 791, 794 | `bib.biblatex-biber` | `\addbibresource`, `\printbibliography[title=\refname,heading=bibintoc]`; style=plainnat-ime (theses), beamer-ime (slides, posters), numeric (article); natbib=true, hyperref=true, autolang=hyphen, backref=true, block=ragged; latexmkrc:55 `$bibtex_use=2` |
| index | main.tex:322-335, 435; imelooks.sty:3485, 3489-3503, 3533-3563 | `idx.makeidx` | imakeidx `\makeindex[noautomatic,intoc,options=-s mkidxhead.ist -l -c]`, `\index{...|see{...}}`, `\printindex`, style file written by filecontents*; latexmkrc:43 runs makeindex |
| file inclusion | main.tex:241, 352-358, 396, 411, 413 | `struct.input` | `\input{conteudo/...}` |
| slide theme | imelooks.sty:1466-1469, 1479, 1487-1488 | `slide.beamer-theme` | metropolis `sectionpage=progressbar,subsectionpage=none,numbering=fraction,progressbar=frametitle`; font themes professionalfonts, structurebold; inner theme circles |
| slide templates | imelooks.sty:1464, 1482-1485, 1494-1514, 1733-1782 | `slide.beamer-template` | caption numbered; text margins .03/.05 of paperwidth; item fonts and glyphs; colours for blocks, structure, palette (blue, green and sandy schemes) |
| slide modes | apresentacao.tex:168, 181, 236, 307, 331 | `slide.beamer-mode` | `plain`, `standout`, `allowframebreaks`, `\pause`, `\appendix` |
| section hook | apresentacao.tex:43-47 | `slide.beamer-section-hook` | frame `[t]{Overview}` calling `\intermezzo` (bespoke macro, reducible) |
| appendix frame count | imelooks.sty:1816 | `num.appendix` | `\usepackage{appendixnumberbeamer}`, no options |
| QR code slide | imelooks.sty:1577, 1589, 1609; apresentacao.tex:121 | `fig.qrcode` | qrcode `\qrcode[height=.8\paperheight,level=H]{url}`, `height=.27\paperheight` |
| poster | poster.tex:118-314; imelooks.sty:1866-1911 | `poster.tcbposter` | `tcbposter` with `poster={rows=6,columns=12,colspacing=1.2cm,rowspacing=.8cm}`; `\posterbox[opts]{name,below,above,between,column,span,rowspan}`; `\tcbposterset{fontsize=32pt,no coverage}`; `\tcbset` skin=enhanced, colframe, colback; styles titlebox, footerbox, smallmargins |
| poster boxes | imelooks.sty:1866-1911 | `box.tcolorbox` | skin=enhanced, borderline south/north, grow sidewards by=1.5cm, sharp corners |
| poster footer logo | imelooks.sty:1846-1853 | `bg.tikzpagenodes` | `\tikz[overlay,remember picture]` node at `current page.south east` shifted -1.5cm, 3mm; the image is user content (reducible) |
| figure drawings | conteudo/05-exemplo-exemplos.tex:365-385, 436, 441; figuras/grafico-pgfplots.tex:1-53 | `art.tikz` | content inside figures: pgfgantt chart, gnuplot `.tkz`, matplotlib `.pgf`, pgfplots axis (see Content-opaque) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option parser with toggles `IME/looks` | imelooks.sty:30-310 | yes | only selects packages; the emitter writes the chosen lib ways directly |
| `\IMEcheckLangLoaded`, language check | imelooks.sty:324-377 | yes | error check only; drop, set `lang.babel` options |
| `\btul` underline under descenders | imelooks.sty:533-538 | yes | `mark.ulem` (`\setul`) plus `mark.contour` (`\contourlength`, `\contour`) |
| `\unnumberedchapter` and starred-star `\chapter**` family | imelooks.sty:600-659 | yes | inline `\chapter*{T}`, `\phantomsection`, `\addcontentsline{toc}{chapter}{T}`, `\chaptermark{T}` (`head.kernel`, `toc.kernel`, `meta.hyperref`, `hf.fancyhdr` marks) |
| `\@makefntext` redefinition and `\patchcmd\maketitle` | imelooks.sty:910-964 | no | kernel-internal redefinition with `\parshape`, `\hbox to \z@{\hss\@makefnmark}`; `fn.footmisc` parameters do not express it |
| `\detachedfootnote` | imegoodies.sty:1090-1096 | yes | `fn.kernel` `\footnotetext[0]` with `\fnsymbol` through `num.counters` |
| `\hltodo` | imegoodies.sty:1028-1035 | yes | `note.todonotes` `\todo` plus `mark.ulem` `\texthl` |
| todonotes `\@todo` patch (spacing .5 in notes) | imegoodies.sty:1038-1042 | no | package-internal patch; no `\todo` call in any sample |
| lineno hook rewrite, parskip/amsthm patch, hyperref counter workaround | imegoodies.sty:797-815; imelooks.sty:1002-1008, 3363-3374 | no | version-specific bug workarounds on package internals; no look of their own |
| `program` float and its list name | imelooks.sty:1268-1279, 1298-1303, 1317-1328 | yes | `fig.floatrow` `\DeclareNewFloatType` and `\floatsetup`; `cap.caption` `\captionsetup*[program]` |
| `programruledcaption` environment | imelooks.sty:1340-1407 | no | box-and-glue with a saved caption box (to stop framed from stepping the counter), custom first/mid/last frame commands and `cont` markers |
| `\@IMEcharscale` | imelooks.sty:1456-1460 | yes | `fig.graphicx` `\scalebox` and `\resizebox` with calc `\totalheightof{\strut}` |
| beamer title page, `\titlebgimage`, `\logos`, `\maketitle` | imelooks.sty:1661-1705 | yes | `slide.beamer-template` background, `box.minipage`, `fig.graphicx` |
| `\overview`, `\intermezzo`, `\showqrcode`, toc column split | imelooks.sty:1579-1659 | yes | static branch on `\@IMEtocColumnSplit`: emit `\tableofcontents[sections={1-N}]` in `columns` directly |
| beamer `\beamer@tocact` strut patch | imelooks.sty:1724 | no | beamer-internal patch |
| `\AtBeginEnvironment{theorem}{\setbeamercolor...}` | imelooks.sty:1798-1814 | yes | `slide.beamer-template` colour settings in a wrapper |
| `\footimage` | imelooks.sty:1846-1853 | yes | `bg.tikzpagenodes` positioned overlay of user content |
| page styles and `\formataNumPaginas`, `\formataCabecalhosDinamicos` | imelooks.sty:2035-2116 | yes | aliases of `\fancyhead` calls; `hf.fancyhdr` |
| `epShiftLeft` | imelooks.sty:2139-2161 | yes | `list` with zero margins, `sp.ragged` FlushRight, `sp.manual-space` |
| `dedicatoria` | imelooks.sty:2183-2203 | yes | composition of `box.minipage`, `sp.ragged`, `sp.manual-space`, `pg.break` (`\if@openright` resolved from the class option) |
| `\resumo`, `\abstract`, `IMEabstract`, keyword commands | imelooks.sty:2211-2294, 2721-2745 | yes | `box.minipage`/list with margins 4em, `description` keyword line, `\hypersetup{pdfsubject,pdfkeywords}`; the sequence joins are literal strings once data is known |
| `\@IMEremoveLinebreaksEtc` (text_purify and regex) | imelooks.sty:2780-2801 | yes | the emitter supplies plain strings to `meta.hyperref` pdftitle, pdfauthor |
| thesis front-matter engine: `\tipotese`, `\defesa`, `\banca`, `\coorientador`, `\direitos` and the cover, title page, verso | imelooks.sty:2300-2583, 2590-2772, 2803-2969, 3001-3339 | no | expl3 key handling, nested `\iftoggle`/`\ifdefstring` texts by degree, language and gender, `\int_while_do` over coadvisors, margins from `\dimgdef` of geometry registers, strut-aligned minipages; a hand-laid rebuild is not shown here |
| `\addappheadtotoc`, `\annex`, appendix names | imelooks.sty:3395-3470 | yes | inline `\addtocontents{toc}{...}` lines (`toc.kernel`, `sp.manual-space`, `pg.break`) and `\renewcommand\appendixname`; `\Hy@appendixstring` is a hyperref internal set to a literal |
| `mkidxhead.ist` through `filecontents*` | imelooks.sty:3533-3563 | yes | static file shipped with the document; `idx.makeidx` option `-s mkidxhead.ist` |
| `evenragged.sty`: `\evenRaggedRight`, `\evenRaggedLeft`, `\evenCentering` | evenragged.sty:34-57 | yes | `sp.ragged` skip registers (`\RaggedRightRightskip` etc.) as `sp.lengths` |
| `evenragged.sty`: `\evenJustified` and `even*` environments | evenragged.sty:59-195 | no | expl3 and regex line-count algorithm measuring a box; no sample calls it |
| `lstpseudocode.sty` aspects `simulatex`, `invisibledelims`, `pseudocode`, languages base/english/brazilian | lstpseudocode.sty:53-242 | no | extends listings (`\lst@Key`, patches `\lst@DelimOpen`, `\lst@DelimClose`); the `\lstdefinestyle{pseudocode}` call that uses it is reducible (imelooks.sty:1430-1444) |
| zip-local biblatex styles `plainnat-ime`, `beamer-ime`, data model `plainnat-ime.dbx` | plainnat-ime.bbx:14-243; plainnat-ime.cbx:8-85; beamer-ime.bbx:8-52; beamer-ime.cbx:8; plainnat-ime.dbx:2 | no | `\renewbibmacro*{cite}`, `{name:andothers}`, `\xpatchbibdriver`, `\defbibenvironment`, `\NoChangeOrSentenceCase` by entry type; only `\DeclareNameAlias`, `\ExecuteBibliographyOptions`, `\DefineBibliographyStrings` lines are declarative |
| `\thickhline` | conteudo/05-exemplo-exemplos.tex:771-779 | yes | inline `\noalign` length swap around `\hline` (`tbl.tabular`, `sp.lengths`) |
| `\cmd`, `\pkg`, `\ltxcmd`, `\sla`, `\disablenewpage` | conteudo/04-exemplo-tutorial.tex:8-19; main.tex:262 | yes | aliases of `mark.kernel` and kernel `\let\clearpage\par` in a group |
| `coloredblock` environment in the slides sample | apresentacao.tex:50-57 | yes | `slide.beamer-template` `\setbeamercolor` plus `\begin{block}` |
| support libraries for the bespoke code (etoolbox, expl3, xparse, filehook, iftex, regexpatch, letltxmacro, calc) | imegoodies.sty:15-43 | yes | no printed effect (the lib rejected this class as `sys.compat-load`); needed only while the bespoke code exists |

## Content-opaque
- pgfgantt chart in a figure (conteudo/05-exemplo-exemplos.tex:365-385)
- gnuplot `.tkz` and matplotlib `.pgf` graphics in subfigures (conteudo/05-exemplo-exemplos.tex:436, 441); pgfplots file (figuras/grafico-pgfplots.tex:1-53, commented out at conteudo/05-exemplo-exemplos.tex:437)
- trigonometric data rows in the longtable (conteudo/05-exemplo-exemplos.tex:638-687) and the `sidewaystable` form (conteudo/05-exemplo-exemplos.tex:782-800)
- listings body text and the imported `conteudo/euclid.psc` (not read)
- Missing assets: logos/ ships only bg-ime.svg, but apresentacao.tex:89-90, 104-106, 117 and poster.tex:144, 152, 248 include bg-ime, ime-logo, usp-logo, ccsl-logo, cc-by as PDF or PNG; `\includegraphics` takes no SVG (`fig.svg` is EXTERNAL and is not what the sample uses). Ship converted files.
- Build tooling, not template: Makefile and latexmkrc call latexmk, biber and makeindex (TeX-distribution programs, the type of `bib.biblatex-biber` and `idx.makeidx`) and set `\RequirePackage[1.7]{bxpdfver}` before the document (latexmkrc:23); texlogsieve and texlogsieverc only filter log text (latexmkrc, texlogsieverc:1-10); grafico.py and grafico.gnuplot produce the shipped figure files and are not needed to compile.

## Lib changes
- New ways proposed: `num.appendix` `appendixnumberbeamer` (CTAN, GPL-3, v1.2.1, maintainer Jerome Lelong; read at ctan.org/pkg/appendixnumberbeamer), pdfLaTeX. W1: on CTAN. W2: load-only, the CTAN page lists no options or commands. W3: serves any beamer deck that has an appendix. W4: one `\usepackage` line, the appendix itself starts with the kernel `\appendix`. Not `slide.beamer-mode` (overlays, handout, notes) nor `slide.hackthefootline` (a footline); it changes only which frames the total frame counter includes. Used at imelooks.sty:1816 (slides branch); apresentacao.tex:331 is the call site.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Considered and not proposed: a fleuron way for `froufrou` (filed under `font.icons`, a symbol-glyph package printing a pictogram); `class.beamer` and the poster class vocabulary need no proposal.
