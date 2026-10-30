yes

# 0237-abntexto-ufc: abntexto-ufc (UFC academic works class, Federal University of Ceará)

- Unverified: read from the source, not compiled.
- Source: Source/0237-abntexto-ufc/ (origin: https://mirrors.ctan.org/macros/latex/contrib/abntexto-ufc.zip; licence: LPPL 1.3c, LICENSE:1-3, manifest `lppl1.3c`)
- Kind: thesis
- Lib: v4
- Engine: pdfLaTeX-compatible (the class branches on `\ifPDFTeX`: `newtxtext`/`newtxmath` for pdfTeX, `fontspec`/`unicode-math` otherwise, abntexto-ufc.cls:292-299; the parent class `abntexto` was not read, and its CTAN page states no engine)
- Look carried by: class (the CTAN-published `abntexto-ufc.cls`; the template sample only sets `\ufcsetup` keys and calls `\ufcPrint*` commands. The package manual `abntexto-ufc.tex` is a plain `article` document with its own small preamble)
- Class origin: ctan
- Main file: abntexto-ufc.tex (the package manual, `article`; the manifest's main). The sample that shows the template is abntexto-ufc-example.tex (class `abntexto-ufc`). Both were read in full.
- Read: main yes, zip-local classes and styles all (abntexto-ufc.cls read in full, 2647 lines; the parent class `abntexto` and the packages it loads are not in the zip and were not read)

## Verdict
The look is carried by `abntexto-ufc.cls`, which is on CTAN (ctan.org/pkg/abntexto-ufc, v3.0.5, LPPL 1.3c; the zip is the CTAN download), so it is published (W1) and is the one way `class.abntexto-ufc`. The sample chooses everything through `\ufcsetup` key values and class commands (W2, W4). No unconditional package needs a tool outside TeX: `minted` is only loaded under `code=minted` (abntexto-ufc.cls:814-817), and the sample sets `code=none` (abntexto-ufc-example.tex:19). The manual's preamble is plain published packages. There is no artwork and no zip-local macro logic beyond three `\newcommand` text aliases (abntexto-ufc.tex:15-17). The verdict rests on the class being published; the parent class `abntexto` (CTAN, TeX Live) is unread.

The three lines before `\documentclass` in the manual (`\pdfinfoomitdate=1`, `\pdftrailerid{}`, `\pdfsuppressptexinfo=15`, abntexto-ufc.tex:1-3) are pdfTeX switches that make the PDF byte-reproducible. They have no printed or structural effect, so they are treated as no component (the same reasoning as the lib's rejected `sys.compat-load`); the verdict does not rest on them.

## Blockers
none

(Conditional, not selected by the sample, recorded so nothing is hidden: `code=minted` would be `EXTERNAL/package`, abntexto-ufc.cls:814-820; `glossary=glossaries` needs the glossary tool pass, abntexto-ufc.cls:837-848; `tables=tabularray` loads the unbundled `tabularray-abnt`, abntexto-ufc.cls:793-802, whose CTAN status was not checked.)

## Class setting
- Class: `class.abntexto-ufc` options: none on `\documentclass` (abntexto-ufc-example.tex:1); the class loads its parent with `\LoadClass[12pt]{abntexto}` (abntexto-ufc.cls:14, `abntexto` 1.1 or newer, checked at :17-21). The manual uses `class.article` with `11pt,a4paper` (abntexto-ufc.tex:4).
- Class-native vocabulary used: `\ufcsetup{...}` keys `type` (7 profiles: undergraduate-capstone, specialization-capstone, masters-thesis, doctoral-thesis, research-project, anonymized-research-project, scientific-article; abntexto-ufc.cls:118-155), `print-mode`, `cover`, `catalog-card`, `coat-of-arms`, `font`, `strict-font`, `tables`, `code`, `algorithms`, `glossary`, `index`, `doctoral-graduate-program`, `doctoral-degree-field`, `author`, `title`, `location`, `year`, `advisor` (abntexto-ufc-example.tex:3-23); commands `\ufcPrintCover`, `\ufcPrintTitlePage` (abntexto-ufc-example.tex:27-28). Defined by the class and not used by the sample: `\ufcPrintApprovalPage`, `\ufcPrintDedication`, `\ufcPrintAcknowledgments`, `\ufcPrintEpigraph[short|long]`, `\ufcPrintErrata`, `\ufcPrintSummary`, `\ufcPrintAbstract`, `\ufcSummaryKeywords`, `\keywords`, `\ufcPrintListOf{Illustrations,Figures,Tables,TextTables,Charts,CodeListings,Algorithms,AbbreviationsAndAcronyms,Symbols}`, `\ufcPrintTableOfContents`, `\ufcPrintCatalogCard`, `\ufcPrintArticleFrontMatter`, `\ufcPrintArticleForeignElements`, `\ufcPrintReferences`, `ﲭdBibliographyResource`, `\ufcPrintGlossary`, `\ufcPrintIndex`, environments `ufcobject`, `ufclisting`, `ufcalgorithm`, `ufclettereditems`, `ufcdashedsubitems`, `ufcdefinitionlist`, `\ufcSource`, `\ufcNote`, `\ufcInputListing`, `\ufcInputMinted` (all in abntexto-ufc.cls). Parent-class commands the class relies on: `\pretextual`, `\textual` (abntexto-ufc.cls:1646, 1646 hook), `\appendix`/`\annex`, `place`/`\definelegendplace`, `\onehalfsp`, `\singlesp`.

## Component map
Rows 1-14 are the manual (abntexto-ufc.tex); rows 15 onward are the class and its sample (abntexto-ufc-example.tex, abntexto-ufc.cls). "native" means the class sets it and the sample only chooses it by key.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| manual: class | abntexto-ufc.tex:4 | `class.article` | 11pt, a4paper |
| manual: paper and size | abntexto-ufc.tex:4 | `page.class-options` | a4paper, 11pt |
| manual: margins | abntexto-ufc.tex:8,12 | `page.geometry` | margin=2.5cm |
| manual: encodings | abntexto-ufc.tex:5-6 | `font.fontenc-t1` | fontenc T1, inputenc utf8 |
| manual: language | abntexto-ufc.tex:7 | `lang.babel` | brazilian, english |
| manual: PDF metadata, link look | abntexto-ufc.tex:9,13 | `meta.hyperref` | hidelinks, pdftitle={abntexto-ufc package manual}, pdfauthor={Tiago Guimarães Sombra} |
| manual: URLs | abntexto-ufc.tex:50,145 | `meta.url` | `\url{...}` (via hyperref) |
| manual: list spacing | abntexto-ufc.tex:10,14 | `list.enumitem` | `\setlist{nosep}` |
| manual: lists | abntexto-ufc.tex:90-98,131-140 | `list.kernel` | `itemize`, with `\item` |
| manual: framed verbatim | abntexto-ufc.tex:11,42-44,56-82 | `code.verbatim` | fancyvrb `Verbatim[frame=single]` |
| manual: title block | abntexto-ufc.tex:19-21,24 | `front.maketitle` | `\title{\pkg\\Package manual}`, `\author`, `\date{Version \version\ --- unreleased}`, `\maketitle` |
| manual: headings | abntexto-ufc.tex:26 | `head.kernel` | `\section` (default article look) |
| manual: inline code, centred block | abntexto-ufc.tex:15-16,144-146 | `mark.kernel`, `sp.ragged` | `\texttt`; `center` environment |
| manual: aliases | abntexto-ufc.tex:15-17 | `mark.kernel` | `\newcommand{\pkg}{\texttt{abntexto-ufc}}`, `\upstream`, `\version{3.0.5}`: inline expansion |
| sample: class and profile keys | abntexto-ufc-example.tex:1-23; abntexto-ufc.cls:118-254 | `class.abntexto-ufc` | type=doctoral-thesis, print-mode=single-sided, cover=auto, catalog-card=false, coat-of-arms=false, tables=native, code=none, algorithms=none, glossary=none, index=none; metadata strings (author, title, location, year, advisor, doctoral-graduate-program, doctoral-degree-field) |
| page: paper, margins | abntexto-ufc.cls:607-627,658-669,680 | `page.class-options` | native from `print-mode`: single-sided left=3cm top=3cm right=2cm bottom=2cm; double-sided inner=3cm outer=2cm top=3cm bottom=2cm (class calls geometry `\newgeometry`, i.e. `page.geometry`); base size 12pt from the parent (:14) |
| body text shape | abntexto-ufc.cls:513-515 | `sp.lengths` | `\parindent`=2cm, `\parskip`=0pt; 1.5 line spacing is the parent's `\onehalfsp` (native; the parent was not read) |
| fonts, pdfTeX path | abntexto-ufc.cls:292-295,389-413,483-503; sample :9-10 | `font.newtx`, `font.family-default`, `font.fontenc-t1` | `font=times` (also `arial`), `strict-font=false`: newtxtext+newtxmath; `\rmdefault` `\sfdefault` `\ttdefault` renewed to `ntxtlf` (or `qhv` for arial); the literal Times New Roman family `times-ttf` is used only when its font files exist (:391-396) |
| fonts, XeLaTeX/LuaLaTeX path | abntexto-ufc.cls:296-330,441-481 | `font.fontspec`, `font.unicode-math` | `\setmainfont`/`\setsansfont`/`\setmonofont` Times New Roman, falling back to TeX Gyre Termes; math TeX Gyre Termes Math, falling back to Latin Modern Math |
| microtype, language, etoolbox | abntexto-ufc.cls:35-36,290 | `lang.babel`, `sp.microtype` | babel [english,brazilian]; microtype defaults |
| cover page | abntexto-ufc.cls:1429-1457,1459-1460 | `front.class-native` | `\ufcPrintCover`: empty page style, centred bold, optional coat of arms `\includegraphics[width=2.2cm]` (:1343), upper-cased institution, centre, department, programme lines, `\vspace{2cm}`, `\vfill`, title, volume, location, year; `cover=false` switches it off |
| title page | abntexto-ufc.cls:1462-1488,1757-1762 | `front.class-native` | `\ufcPrintTitlePage`: author, `\vspace{4cm}`, bold title, nature statement in a minipage offset 8cm, advisor line, location, year; project profiles use `\ufc_project_title_page:` (:1722-1745) |
| approval page, dedication, acknowledgements, epigraph, errata | abntexto-ufc.cls:1100-1137,1140-1220 | `front.class-native` | native pages: examiner signature blocks with `\rule{8cm}{0.4pt}` (:1072); dedication and epigraph start at `.5\textheight`, minipage offset 8cm (long epigraph 4cm, 10/12pt, :1184-1186) |
| text pieces used by those pages | abntexto-ufc.cls:548,916,926,1073,1114-1115,1144-1147,1186 | `mark.case`, `box.minipage`, `sp.manual-space`, `sp.ragged`, `sp.rule`, `font.size-commands` | `\MakeUppercase`; `minipage` of width `\textwidth-8cm`; `\vspace`/`\vfill`/`\hspace*`; ragged2e `\justifying`/`\raggedleft`; `\rule`; `\fontsize{10}{12}\selectfont` |
| summary, abstract, keywords | abntexto-ufc.cls:1222-1257 | `abs.class-native`, `abs.keywords` | `\ufcPrintSummary` (Resumo), `\ufcPrintAbstract` (English, `\selectlanguage{english}`), `\ufcSummaryKeywords` ("Palavras-chave:"), `\keywords` ("Keywords:"); centred bold upper-case heading |
| article profile front block | abntexto-ufc.cls:1534-1669 | `front.class-native` | `type=scientific-article`: title, right-aligned author with `\footnote`, dates, "Resumo:" block, optional foreign title and summary; body 2cm indent, `\parskip`=0 (:1634-1646) |
| lists of figures, tables, etc. and contents | abntexto-ufc.cls:883,1259-1320,886-901,1995-2022 | `front.class-native`, `toc.kernel` | pretextual pages `\ufcstarttoc{loi|lof|lot|loq|logr|loc|loa|toc}` (= `\@starttoc`); heading "SUMÁRIO"; one unified illustration list from `loi`/`loii` entries; entry look from the parent's `\extline` |
| contents leaders | abntexto-ufc.cls:583-591 | `front.class-native` | dotted leaders `\ufctocdot` via the parent's `\hooktocsection` and `\extleaders` |
| headings | abntexto-ufc.cls:548-564,566-570,596-601 | `head.class-native` | native hooks `\sectionfont`={\bfseries\MakeUppercase}, subsection bold, subsubsection bold italic, paragraph italic, subparagraph plain; one-space separator patched in with `\patchcmd`; chapter mode refused |
| numbering depth | abntexto-ufc.cls:593-594 | `num.secnumdepth` | secnumdepth=5, tocdepth=5 |
| section breaks | abntexto-ufc.cls:629-656,686,688-710 | `pg.break` | `\clearpage`; in double-sided mode `\cleardoublepage`-like next odd page via `\hbox{}\newpage` with `\thispagestyle{empty}` |
| running heads, page numbers | abntexto-ufc.cls:1432,1387-1388,1450,1512 | `hf.pagestyle-kernel`, `hf.class-native`, `pgnum.pagenumbering` | `\thispagestyle{empty}` on every pretextual page; `\setcounter{page}` from `initial-page` (integer>0); the running page number itself comes from the parent (not read) |
| footnotes | abntexto-ufc.cls:712-727 | `fn.kernel`, `sp.rule`, `sp.lengths` | `\footnoterule`: `\kern 3pt`, `\hrule width 5cm`, `\kern 3pt`; `\@makefntext` hanging 2cm (`\hangindent=2cm`, `\hangafter=1`), small, single spacing |
| lettered and dashed lists | abntexto-ufc.cls:518-545 | `list.kernel` | `ufclettereditems` (label `a)`, left-margin 2.8cm, label-width .5cm, label-sep .3cm), `ufcdashedsubitems` (label `---`, left-margin .9cm), all vertical spacing 0pt |
| definition list | abntexto-ufc.cls:1294-1311,2032-2049 | `list.kernel` | `ufcdefinitionlist[3cm]`: kernel `list` with `\leftmargin`, `\labelwidth`=#1-.3cm, `\labelsep`=.3cm, zero item/par/top spacing (the enumitem `description` version at :1296-1306 is replaced at :2032) |
| figure/table/chart legends | abntexto-ufc.cls:1771-1808,1875-1877,1869-1873 | `fig.class-native` | `ufcobject` = the parent's `place[pos]`; `\definelegendplace` for gráfico/código/algoritmo/quadro; `\ufcSource`, `\ufcNote`; legend box width and size 1.0 |
| coat-of-arms image | abntexto-ufc.cls:1329-1356; sample :8 | `fig.graphicx` | `coat-of-arms-file` default assets/institutional/ufc-coat-of-arms.png, width=2.2cm; not in the zip (CTAN excludes it; README.md:39); the sample sets `coat-of-arms=false` |
| catalog card page | abntexto-ufc.cls:879,1491-1520 | `pg.include-pdf` | `\includepdf[pages=1,pagecommand={\thispagestyle{empty}}]`; sample sets `catalog-card=false` |
| tables | abntexto-ufc.cls:790-802,758-786 | `tbl.nicematrix` | optional: `tables=tabularray` loads `tabularray-abnt` (the package is the parameter); the sample uses `tables=native` (the parent's own tables); `\SetTblrStyle` font=\normalsize / \abntsmall |
| code listings | abntexto-ufc.cls:804-820,1888-1918 | `code.listings`, `code.minted` | optional: `code=listings` (`\lstset{basicstyle=\ttfamily\normalsize}`, `ufclisting`); `code=minted` (**EXTERNAL** when selected; `\setminted{fontfamily=tt,fontsize=\normalsize}`); sample `code=none` |
| algorithms | abntexto-ufc.cls:822-832,1920-1969 | `alg.algorithmicx` | optional: `algorithms=algpseudocodex` (`noEnd=false`; a successor of `algpseudocode`), `ufcalgorithm[pos][line-number frequency]`; sample `algorithms=none` |
| glossary, index | abntexto-ufc.cls:834-863,2585-2642 | `idx.glossaries`, `idx.makeidx` | optional: `glossaries[acronym,toc=false]` with a `list`-based style `ufc`; `imakeidx` with `\indexsetup{level=...}`; sample `none` for both |
| bibliography | abntexto-ufc.cls:25,2056-2066,2344-2366 | `bib.biblatex-biber` | biblatex backend=biber, style=abnt (`biblatex-abnt`, CTAN and TeX Live), sorting=nyt, sortcites=true, maxcitenames=3, mincitenames=1, maxbibnames=99, accite=false, extradate=true, repeatfields=true; `\printbibliography[heading=none]` under a bold centred "REFERÊNCIAS" heading, `\bibitemsep=\baselineskip`; added `\DeclareNameFormat`, `\renewbibmacro*`, `\DeclareBibliographyDriver{jurisdiction}` (:2173-2283,2379-2551) |
| anchors in contents | abntexto-ufc.cls:2350-2351,2567-2568 | `toc.kernel` | `\addcontentsline{toc}{section}{...}` with `\phantomsection` for References and post-textual headings |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\pkg`, `\upstream`, `\version` | abntexto-ufc.tex:15-17 | yes | text aliases, expand inline to `\texttt{abntexto-ufc}`, `\texttt{abntexto}`, `3.0.5` (`mark.kernel`) |
| `abntexto-ufc.cls` (expl3 key interface, hooks, legend and unified-list code, bibliography name disambiguation with property lists, `\patchcmd` and `\@makefntext` changes) | abntexto-ufc.cls:1-2647 | not applicable | the class is on CTAN, so it is published and is the way `class.abntexto-ufc`; its internals are not zip-local bespoke code. Read to check for blockers: none unconditional |
| `\ufcTocPosttextualTitle`, `\extdotleaders`, `\printlegendbox`, `\l@loii` | abntexto-ufc.cls:576-591,886-888,1774-1789 | inside the published class | class internals; the way is the class option set, not these macros |

## Content-opaque
none (the sample has no figure, table or equation; the manual has only verbatim code listings, abntexto-ufc.tex:42-44,56-82)

## Lib changes
- New ways proposed: none (every component maps to an existing way; `class.abntexto-ufc` is written plainly as a class way. Considered and not proposed: a way for the pdfTeX reproducibility switches, abntexto-ufc.tex:1-3, because they have no printed or structural effect)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Class vocabulary for the lib's class section: `class.abntexto-ufc` (CTAN, LPPL 1.3c, expl3 key interface `\ufcsetup`, loads the parent `abntexto` and `biblatex` with `biber` and `biblatex-abnt`; commands listed under "Class setting").
- Other facts for the reader: the parent class `abntexto` is on CTAN and in TeX Live (checked at ctan.org/pkg/abntexto: v1.1, public domain; its source and engine support were not read). A comment says the references are in `bibliography.def` (abntexto-ufc.cls:2559) but the zip and CHANGELOG:19 say the `.def` modules were removed (the comment is stale). Missing assets, not blockers: the UFC coat-of-arms PNG, the Times New Roman and Arial font files and `abntexto-ufc-windows.map` are not shipped, so the sample falls back to `ntxtlf` (abntexto-ufc.cls:405-411).
