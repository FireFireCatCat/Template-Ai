no

# 0624-houluy-buptemplate: BUPT PhD thesis template (`buptthesis` class on `ctexbook`)

- Unverified: read from the source, not compiled.
- Source: Source/0624-houluy-buptemplate/ (origin: https://codeload.github.com/houluy/bupTemplate/zip/refs/heads/master; licence: GPL-3.0)
- Kind: thesis
- Lib: v5
- Engine: needs XeLaTeX (README.rst:38 "Only xelatex"; `ctexbook` with `fontset=fandol` at buptthesis.cls:87-92; `fontspec` option `no-math` at buptthesis.cls:71)
- Look carried by: zip-local (buptthesis.cls sets headings, headers, title pages, abstracts and package options on top of `ctexbook`; the sample only supplies title-page strings)
- Class origin: zip-local (`buptthesis` is not on CTAN: ctan.org/pkg/buptthesis returned 404; it comes from a student GitHub repo, not a university release). It loads the published `ctexbook` (ctex bundle, not bundled in the zip, source not read).
- Main file: main.tex (other samples: none; the chapters in Chapter/*.tex are `\include`d by it)
- Read: main yes, zip-local classes and styles all (buptthesis.cls, config/buptthesis.cfg, gbt7714.sty in full; gbt7714.dtx outlined by grep and gbt7714-unsrt.bst header only, because both are the published CTAN package's own source and style)

## Verdict
`no`. Almost everything reduces to lib ways: `ctexbook` plus published packages and `\ctexset` heading settings, with aliases and string keys that inline. One piece does not: the cover page measures the widest title line and the widest info line with expl3 sequence and box code, then underlines every line to that width (buptthesis.cls:337-397, called at 412-431). The rubric names expl3 code that computes layout as irreducible. A rewrite on `box.eqparbox` is conceivable, but it would be the analyst's re-implementation, with an aux-file second pass and padding by `\hspace`, and nothing here shows it gives the same widths. By the rubric's tie-break the answer is `no`. If a reviewer accepts that rewrite, every other item is reducible and the verdict would turn to `yes`.

## Blockers
- `BESPOKE/class` expl3 width-measuring and underlining code for the Chinese cover title and info block (buptthesis.cls:337-397; `\BUPTunderline` at 399; used by `\makechinesetitle` at 412-431)

## Class setting
- Class: `class.ctexbook` options: `UTF8`, `a4paper`, `zihao=-4`, `fontset=fandol` (buptthesis.cls:87-92, both branches of the `macos` switch identical at 80-85); the sample passes `phd` (main.tex:1), which only the zip-local `\DeclareOption` handles (buptthesis.cls:32-34); unknown options go on to `ctexbook` (buptthesis.cls:66)
- Class-native vocabulary used: `\ctexset{chapter,section,subsection,subsubsection = {format,beforeskip,afterskip,pagestyle}, contentsname, listfigurename, listtablename, today}` (buptthesis.cls:236-238, 275-304); `\zihao{n}` (e.g. buptthesis.cls:241, 277, 394), `\heiti` (277), `\kaishu` (194); book commands `\frontmatter` `\mainmatter` `\backmatter` `\chapter` (main.tex:29, 37, 43)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | buptthesis.cls:87-92; main.tex:1 | `class.ctexbook` | UTF8, a4paper, zihao=-4, fontset=fandol; zip-local option `phd` selects the doctoral branch (buptthesis.cls:226-232) |
| paper size | buptthesis.cls:88 | `page.class-options` | a4paper |
| page geometry | buptthesis.cls:184, 219 | `page.geometry` | left=2.75cm, right=2.75cm, top=3cm, bottom=3cm (twoside variant commented at 217) |
| header and footer | buptthesis.cls:187, 258-264 | `hf.fancyhdr` | style `BUPThdrstyle`: `\fancyhf{}`, head OR `\zihao{-5}\leftmark`, head EL university+degreetype+degree+thesis labels, foot C `\zihao{5}\thepage`, `\headrulewidth` 0.4pt, `\footrulewidth` 0; variants `cenhdr` at 249-256 and `draftcls` at 235-247 (not used by the sample) |
| page style switching | buptthesis.cls:267-268, 270-272, 280 | `hf.pagestyle-kernel` | `\pagestyle{empty}` at begin document; `\frontmatter` followed by `\pagestyle{BUPThdrstyle}`; chapter `pagestyle=BUPThdrstyle` through `\ctexset` |
| page numbers | buptthesis.cls:271; main.tex:29, 37 | `pgnum.pagenumbering` | `\pagenumbering{alpha}` at begin document, then the book `\frontmatter` and `\mainmatter` |
| paragraph spacing | buptthesis.cls:307-308 | `sp.lengths`, `sp.linespread` | `\parskip` 1pt; `\linespread{1.3}` |
| text encoding and families | buptthesis.cls:109-112 | `font.fontenc-t1`, `font.family-default` | `[T1]{fontenc}`; `\sfdefault`=phv, `\rmdefault`=ptm, `\ttdefault`=pcr |
| fontspec option | buptthesis.cls:71 | `font.fontspec` | `\PassOptionsToPackage{no-math}{fontspec}` (fontspec is loaded by ctex) |
| optional maths font | buptthesis.cls:116-118 | `font.newtx` | `newtxmath` only when option `txmath` is set (not in the sample) |
| Chinese fonts and sizes | buptthesis.cls:87-92, 277, 394 | `lang.cjk` | ctex `fontset=fandol`, `\zihao`, `\heiti`, `\kaishu` |
| cover big title size | buptthesis.cls:407 | `font.size-commands` | `\fontsize{32}{\p@}\bfseries` |
| colour | buptthesis.cls:167, 552; Chapter/Chapter_publication.tex:2 | `color.xcolor` | options table, usenames, svgnames, dvipsnames; `\cemph` RubineRed; `\definecolor{Maroon}{HTML}{701112}` |
| links and url | buptthesis.cls:178-181, 538-548 | `meta.hyperref`, `meta.url` | hyperref loaded when option `electronic` (default, line 67); bookmarksopen, bookmarksnumbered, pdfpagemode=UseOutlines, pdfstartview=FitH, colorlinks, citecolor=cyan, pdftitle, pdfsubject, pdfauthor, pdfkeywords |
| cross-references | Chapter/Chapter_architecture.tex:11; Chapter/Chapter_algorithm.tex:34; Chapter/Chapter_Introduction.tex:10 | `xref.kernel`, `xref.hyperref` | `\ref`, `\ref*`, `\href` |
| Chinese cover | buptthesis.cls:400-435; main.tex:3-10, 25 | `front.class-native` | `\makechinesetitle` with fields from `\BUPTthesiscntitlepage`; parts: `sp.ragged` (`flushright`, `center`), `fig.graphicx` (logo images, 12.67cm and 3.43cm), `sp.manual-space` (`\vskip\stretch{0.5}`), `tbl.tabular` (`rc`, `\arraystretch` 1.3, `\extrarowheight` 1pt), `sp.rule` (`\underline`), `pg.break` (`\cleardoublepage`); the width measuring is the blocker |
| English cover | buptthesis.cls:437-451; main.tex:14-22, 26 | `front.class-native` | `\makeenglishtitle`: `center`, `\zihao` sizes, `\vskip\stretch{2}`, `\cleardoublepage` (uses `sp.ragged`, `sp.manual-space`, `pg.break`) |
| statement and authorisation page | buptthesis.cls:460-479; main.tex:27 | `front.dedication` | `\makestatement`: centred bold titles, `\vskip` gaps, signature and date blanks as `\underline{\hbox to 100pt{\hss\hss}}` (`sp.rule`, `sp.manual-space`) |
| Chinese abstract | buptthesis.cls:482-490; Chapter/Chapter_cnabstract.tex:1-5 | `abs.class-native`, `abs.keywords` | environment `cnabstract` = `\chapter[label]{title}` + centred `\zihao{-3}\heiti\bfseries` label + `\vskip 25pt`; `\cnkeywords` = `\vspace{2ex}\noindent{\bfseries label}` |
| English abstract | buptthesis.cls:492-501; Chapter/Chapter_enabstract.tex:1-6 | `abs.class-native`, `abs.keywords` | environment `enabstract`; `\enkeywords` |
| contents lists | main.tex:32-34; buptthesis.cls:202, 311 | `toc.kernel`, `toc.etoc`, `num.secnumdepth` | `\tableofcontents` `\listoffigures` `\listoftables`; `tocbibind` (option `normaltoc` passes `nottoc,notlof,notlot`, line 57); `tocdepth`=2 |
| headings | buptthesis.cls:275-297; Chapter/Chapter_Introduction.tex:1-4 | `head.class-native`, `num.secnumdepth` | chapter `\heiti\zihao{3}\bfseries\centering`, beforeskip -1pt, afterskip 2em; section `\zihao{4}` 2em/1em; subsection and subsubsection `\zihao{-4}` 1em/1em; `secnumdepth`=5 (buptthesis.cls:95) |
| list and toc names | buptthesis.cls:300-304 | `lang.cjk` | `contentsname`, `listfigurename`, `listtablename` through `\ctexset` |
| counter numbering | buptthesis.cls:196-198 | `num.counters` | `\theequation`, `\thefigure`, `\thetable` = chapter--number; `algochapter` for algorithms (line 164) |
| lists | buptthesis.cls:135-136; Chapter/Chapter_publication.tex:5-7 | `list.enumitem`, `list.kernel` | `\setlist{nosep}`; `enumerate` |
| nomenclature and abbreviation lists | buptthesis.cls:504-525; Chapter/Chapter_abbreviation.tex:1-4 | `list.paralist`, `head.class-native` | `\chapter{title}` then `IEEEdescription` with `\IEEEsetlabelwidth{longest label}` (abbreviation) and `\IEEEusemathlabelsep` (nomenclature); label width string set by `\BUPTlongestlength` (Chapter_abbreviation.tex:1) |
| acknowledgement and publications | buptthesis.cls:531, 534; Chapter/Chapter_acknowledgement.tex:1-3; Chapter/Chapter_publication.tex:1-12 | `front.dedication`, `head.class-native` | environments that call `\chapter{label}` |
| maths | buptthesis.cls:128-134, 166, 169-170; Chapter/Chapter_algorithm.tex:5-8 | `math.amsmath`, `math.amssymb`, `math.bm`, `math.mdwmath`, `math.nicefrac`, `math.mathtools` | `align`; `bm`; `mdwmath` (no options); `xfrac`; `\DeclarePairedDelimiter{\ceil}{\lceil}{\rceil}`, `\floor` |
| figures | buptthesis.cls:139-145, 214 | `fig.graphicx`, `fig.subcaption` | `graphicx` (skipped, with `\setkeys{Gin}{draft=true}`, under `draftcls`); `\graphicspath{{Figure/EPS/}{Figure/EPS/Chapter1/}}`; `subfig` font=footnotesize, subrefformat=parens |
| captions | buptthesis.cls:193-195; Chapter/Chapter_architecture.tex:15-16 | `cap.caption`, `cap.kernel` | `\DeclareCaptionFont{kaishu}`; format=plain, labelformat=simple, labelsep=space, justification=centering, font={small,kaishu}; caption above the table |
| tables | buptthesis.cls:148-150, 167-168, 171; Chapter/Chapter_architecture.tex:13-27 | `tbl.tabular`, `tbl.colortbl`, `tbl.multirow`, `tbl.longtable` | `tabular{\|c\|c\|\|c\|c\|}`, `\hline`, `\rowcolor{LightSteelBlue}` (architecture.tex:19); `makecell`, `multirow`, `longtable`; `\newcolumntype{g}{>{\columncolor{LightSteelBlue}}c}` |
| algorithms | buptthesis.cls:159-165; Chapter/Chapter_algorithm.tex:14-28 | `alg.algorithm2e` | linesnumbered, lined, boxruled, commentsnumbered, algochapter; `\While` `\For` `\If` `\lIf` `\lElse` `\tcp` `\BlankLine` `\KwTo` |
| code | buptthesis.cls:222-223; Chapter/Chapter_architecture.tex:31 | `code.listings` | `\lstinline[language={[LaTeX]TeX}, basicstyle=\ttfamily]` behind `\latextext` |
| units | buptthesis.cls:190, 553-562; Chapter/Chapter_architecture.tex:7 | `mark.siunitx` | option binary-units; `\DeclareSIUnit` for belmilliwatt, belwatt, dBm, dBW, bits, bytes, bps, Bps; `\SI[per-mode=symbol, per-symbol=p]` |
| inline marks | Chapter/Chapter_architecture.tex:3, 7; buptthesis.cls:567-568 | `mark.kernel`, `mark.case` | `\textbf`, `\textit`; `\upperroman` = `\uppercase\expandafter{\romannumeral#1}` |
| acronym package | buptthesis.cls:156 | `idx.glossaries` | `acronym` loaded, no `\ac` use in the sample |
| bibliography | buptthesis.cls:175; gbt7714.sty:29-36, 40, 43, 66-69; main.tex:41; Chapter/Chapter_Introduction.tex:6, 10 | `bib.natbib`, `bib.bibtex-bst` | published `gbt7714` (CTAN, LPPL 1.3c, Zeping Lee; zip copy v1.1.1) with option `super`: loads `natbib` with `sort&compress`, `\citestyle{super}`, `\bibliographystyle{gbt7714-unsrt}`; `\bibliography{Bib/thesis}`; BibTeX run is part of TeX Live, not EXTERNAL |
| file structure | main.tex:30-31, 38-40, 44-46 | `struct.input` | `\include{Chapter/...}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class option switches (`\newif`, `\DeclareOption`, `\ExecuteOptions{phd,electronic}`) | buptthesis.cls:19-68 | yes | emit only the active branch; the sample uses `phd`, `electronic`; each branch is a lib way (hyperref on or off, header variant, `newtxmath`) |
| cfg file with labels and values | buptthesis.cls:204-205; config/buptthesis.cfg:12-108 | yes | `\def` strings (university name, labels, abstract labels, English date macro); inline them as content strings in the front-matter wrappers |
| key-value title fields | buptthesis.cls:314-332; main.tex:3-22 | yes | `keyval` sets `\def` strings; substitute the sample's values into the cover body |
| expl3 width measuring and underlining | buptthesis.cls:337-397, 399 | **no** | `\seq_set_split` of the title at `\\`, `\hbox_set` measuring each piece, `\dim_max`, `\hbox_to_wd` with `\hss`, `\underline`, width +20pt (title) and +40pt (info, lines 417-420); considered: `box.eqparbox`, not accepted as a proven reduction (see Verdict) |
| cover, English cover, statement macros | buptthesis.cls:400-479 | yes, apart from the measured widths | composition of `sp.ragged`, `fig.graphicx`, `sp.manual-space`, `tbl.tabular`, `sp.rule`, `pg.break` as in the map |
| degree selection | buptthesis.cls:226-232 | yes | the `phd` branch gives the strings 博士 and PhD |
| authorisation comment conditional | buptthesis.cls:454-458 | yes | content selection by `\ifx...\@empty`; it runs at class load, before the cfg file is read, so as read it always takes the `\else` branch (`~`); either way it is one string |
| `\frontmatter` wrapper | buptthesis.cls:267-268 | yes | body lines `\frontmatter` then `\pagestyle{BUPThdrstyle}` |
| `\AtBeginDocument` page setup | buptthesis.cls:270-272 | yes | first body lines `\pagenumbering{alpha}` `\pagestyle{empty}` |
| `cnabstract` `enabstract` `nomenclature` `abbreviation` `acknowledgement` `publication` | buptthesis.cls:482-534 | yes | `\chapter` plus centred label and `\vskip`, or `IEEEdescription`; wrappers around lib ways |
| `\cnkeywords` `\enkeywords` | buptthesis.cls:489-490, 500-501 | yes | `\vspace{2ex}\noindent{\bfseries label}` and text |
| `\BUPTlongestlength` | buptthesis.cls:505-506, 518; Chapter/Chapter_abbreviation.tex:1 | yes | stores a string; becomes `\IEEEsetlabelwidth{BUPTBUPTBUPT}` |
| `\latextext` | buptthesis.cls:223 | yes | alias of `\lstinline[...]` |
| `\cemph` `\upperroman` `\lowerroman` `\myvec` `\IF` | buptthesis.cls:552, 567-569; Chapter/Chapter_publication.tex:3 | yes | aliases over `\textcolor`, `\uppercase`, `\romannumeral`, `\bm{\mathrm{}}` |
| package declarations | buptthesis.cls:169-171, 194, 553-562 | yes | `\DeclarePairedDelimiter`, `\newcolumntype`, `\DeclareCaptionFont`, `\DeclareSIUnit` are parameters of published packages |
| log-only lengths | buptthesis.cls:512-514, 523-525 | yes | `\settowidth` and `\typeout` print nothing in the document; dropped |
| draft header and `today` formats | buptthesis.cls:235-247 | yes | `\ctexset{today=...}` and `\let\oldtoday\today` feed `hf.fancyhdr`; branch not used by the sample |

## Content-opaque
- Logo images `resources/name.png` and `resources/logo.png` on the cover (config/buptthesis.cfg:37-38; buptthesis.cls:405, 409) are images shipped in the zip; not drawn, so not `ART`.
- Title math `$ \text{IC}^\text{2} $` at main.tex:4 is content.
- `Figure/EPS/` named at buptthesis.cls:214 is not shipped; the sample includes no figure from it.

## Lib changes
- New ways proposed:
  - `math.mdwmath` `mdwmath` (mdwtools bundle; CTAN, TeX Live, MiKTeX, GPL; ctan.org/pkg/mdwtools was read: "some minor changes to LaTeX maths"; engine tag `pdf`, the page states no engine and the zip loads it under XeLaTeX). W1 published; W2 load-only switch with no options, like `math.icomma` and `math.subdepth`; W3 any maths document; W4 one `\usepackage{mdwmath}` line (buptthesis.cls:133). Not `math.amsmath` or `math.mathtools`, which are other packages.
  - `list.paralist` `IEEEtrantools` (IEEEtran bundle; TeX Live; W1 rests on my knowledge that `IEEEtrantools.sty` ships in the CTAN IEEEtran bundle, its page was not read): env `IEEEdescription[\IEEEsetlabelwidth{longest label}\IEEEusemathlabelsep]` with `\item[label]`. W1 published; W2 the label width is a text string and a switch; W3 any labelled list; W4 an environment wrapper (buptthesis.cls:157, 510, 521). Not `list.enumitem` or `list.paralist`, which are other packages; a consolidator may fold it into a list-package line.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
