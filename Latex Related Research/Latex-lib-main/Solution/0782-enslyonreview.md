yes

# 0782-enslyonreview: ENSLyonReview (ENS de Lyon M2 Biosciences bibliographic review, Current Opinion format)

- Unverified: read from the source, not compiled.
- Source: Source/0782-enslyonreview/ (origin: https://mirrors.ctan.org/macros/latex/contrib/enslyonreview.zip; licence: LPPL 1.3c)
- Kind: journal
- Lib: v6
- Engine: pdfLaTeX-compatible (README.md:25 asks for pdfLaTeX + biber; the class loads inputenc, fontenc, newtx, helvet, no fontspec)
- Look carried by: mixed (the template look of enslyonreview-gabarit.tex and enslyonreview-exemple.tex is carried by the published class enslyonreview.cls; the manifest's main file, the French user guide enslyonreview.tex, is `article` plus its own reducible preamble)
- Class origin: ctan (ctan.org/pkg/enslyonreview read: "ENSLyonReview", Adama Mbaye, LPPL 1.3c, v1.1 of 2026-09-10)
- Main file: enslyonreview.tex (other samples: enslyonreview-exemple.tex, enslyonreview-gabarit.tex)
- Read: main yes, zip-local classes and styles all (enslyonreview.cls 891 lines, enslyonreview.dbx 11 lines; also read both other samples in full and the head of both .bib files, which are content)

## Verdict
yes. The template is a course review typeset as a two-column Current Opinion style journal article. The class `enslyonreview` is a package on CTAN (one `class.<name>` way), and the two template samples add only class-native metadata commands, theme or font options and standard float, table and bibliography constructs. The guide `enslyonreview.tex` is `article` with a preamble of published packages (`geometry`, `fancyhdr`, `titlesec`, `listings`, `tcolorbox`, `changepage`) and only `\newcommand` or `\newtcolorbox` aliases of them, all reducible by inline expansion. No ART, no external tool, no irreducible macro in the sample files. Under a stricter reading that counted the published class's own internals, see the note under "Bespoke code".

## Blockers
none

## Class setting
- Class: `class.enslyonreview` options: one colour theme out of 23 names (`orange` default, `orangeens`, `violet`, `blue` ... `midnight`: enslyonreview.cls:57-86) and one font switch `palatino`|`xcharter`|`stix` (enslyonreview.cls:105-110, default newtx at 177-178); every other option is forwarded to `article` (enslyonreview.cls:115); the class loads `\LoadClass[12pt,twocolumn,a4paper]{article}` (enslyonreview.cls:130). The samples use no option (enslyonreview-exemple.tex:36, enslyonreview-gabarit.tex:99).
- Class-native vocabulary used: preamble `\reviewtitle` `\reviewshorttitle` `\reviewauthor` `\reviewauthorshort` `\reviewaffiliation` `\reviewdate` `\reviewkeywords` `\reviewabstract` (enslyonreview-exemple.tex:44-71, cls:635-659), `\maketitle` (exemple:112, cls:674-692), `\addbibresource` (exemple:74), `\refspecialinterest{key}{note}` and `\refoutstandinginterest{key}{note}` (exemple:82-102, cls:383-390), body `reviewbox` and `reviewbox*` float with `\caption` (exemple:176-194, cls:830-831), `\crefcolor` `\Crefcolor` (exemple:204, cls:283-284), `\reviewnote{a}{text}` (guide:732-739, cls:789), `\printbibliography[title=References]` (exemple:526), `\balance` (exemple:531), `\noreflegend` (cls:461). Unused by the samples: the legacy `references` environment with `\bibref` `\bibdoi` `\bibpmid` `\bibpmcid` `\ofspecialinterest` `\ofoutstandinginterest` (cls:861-890). Unnumbered sections are native: `secnumdepth` is 0 (cls:752).

## Component map
Rows marked (class) are realised inside the published class; an emitter writes only `\documentclass[...]{enslyonreview}` plus the class-native commands for them. Rows marked (guide) are in the article-based user guide.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | exemple:36, gabarit:99, cls:130 | `class.enslyonreview` | no option, or theme name and font name (see Class setting) |
| base class under it (class) | cls:130 | `class.article` | 12pt, twocolumn, a4paper |
| page size, columns (class) | cls:130 | `page.class-options`, `cols.twocolumn-option` | a4paper, 12pt, twocolumn |
| page geometry (class) | cls:191-196 | `page.geometry` | left=right=1.6cm, top=bottom=2.2cm, headheight=28pt, headsep=10pt, footskip=22pt, columnsep=0.7cm |
| page flow (class) | cls:311 | `pg.flush` | `\flushbottom` |
| text font (class) | cls:177-178 / 171 / 173 / 175 | `font.newtx` / `font.palatino` / `font.charter` / `font.serif-pkg` | newtxtext+newtxmath default; mathpazo; xcharter; stix2 (the package is the parameter) |
| sans for bars (class) | cls:183 | `font.helvet` | `helvet`, `\sffamily` in header and footer text only (cls:717, 723) |
| encodings (class) | cls:162-163 | `font.fontenc-t1` | utf8, T1 |
| language (class) | cls:184-185 | `lang.babel`, `lang.csquotes` | english; csquotes load-only |
| maths (class) | cls:148 | `math.amsmath`, `math.amssymb` | amsmath, amsfonts, amssymb |
| colour themes (class) | cls:496-591, 602-606 | `color.xcolor` | `\definecolor` HTML values for colorMain, colorAccent, colorBg per theme; fixed colorAbstractBg E6E6E6 (cls:591); `xcolor[table]` (cls:159) |
| lengths helper (class) | cls:144 | `sp.lengths` | `calc` load-only; `ifthen` (cls:143) and `etoolbox` (cls:228) are macro helpers used only inside class code (the driver lookup, cls:383-405), no component of their own |
| title block (class-native) | exemple:44-71, 112; cls:674-692 | `front.class-native`, `cols.twocolumn-cmd` | `\twocolumn[{minipage of title, band, keywords, abstract}]`; strings only |
| title bands (class) | cls:665-667, 680-688 | `box.fancybox`, `box.minipage` | `\colorbox{colorBg}{\parbox{\dimexpr\textwidth-2\fboxsep}{...}}`; colorBg for author block, grey for keywords and abstract |
| abstract | exemple:62-71; cls:688 | `abs.class-native` | `\reviewabstract{...}`, set `\bfseries` in a grey band |
| keywords | exemple:59; cls:686 | `abs.keywords` | `\reviewkeywords{...}`, "Keywords:" in bold |
| running header and footer (class) | cls:707-740 | `hf.class-native` (over `hf.fancyhdr`) | `\pagestyle{fancy}`, `\fancyhf{}`, centred coloured bars, rules 0pt, plain style redefined alike |
| page count in header (class) | cls:211, 718 | `pgnum.lastpage` | `\thepage\,/\,\pageref{LastPage}` |
| headings (class) | cls:215, 754-762 | `head.class-native` (over `head.titlesec`) | `\titleformat{\section}` large bold colorMain, no label, `\titlespacing*` 10pt/4pt; subsection normalsize bold, 8pt/2pt |
| heading numbers (class) | cls:752 | `num.secnumdepth` | secnumdepth=0 |
| first-line indent (class) | cls:222 | `sp.indentfirst` | load-only after titlesec |
| lists (class) | cls:223, 773-774; exemple:179 | `list.kernel`, `list.enumitem` | itemize leftmargin=1.4em, itemsep=0.15em, topsep=0.15em; enumerate leftmargin=1.6em; `description` inside the box |
| figures | exemple:308-318, 400-410 | `fig.graphicx` | `figure*[!t]`, `\centering`, width=0.92\textwidth and 0.55\textwidth; `\graphicspath{{figures/}{./}}` (cls:154) |
| tables | exemple:440-487 | `tbl.tabularx`, `tbl.tabular`, `tbl.multirow`, `tbl.colortbl`, `sp.ragged` | `table*`, `\footnotesize`, `\arraystretch` 1.3, `\hline` `\cline{2-4}`, `\multirow{4}{2.6cm}`, `\rowcolor{colorAbstractBg}`, column prefix `>{\justifying\parindent0pt\arraybackslash}p{..}` |
| table packages (class) | cls:233-235, 240 | `tbl.booktabs`, `tbl.tabularx`, `tbl.multirow`, `sp.ragged` | load-only |
| captions (class) | cls:201-206; exemple:311, 441 | `cap.caption`, `cap.kernel` | font=small, labelfont={bf,color=colorMain}, labelsep=period, justification=justified |
| bottom floats in two columns (class) | cls:247 | `cols.cuted` | `stfloats` load-only |
| box float (class-native) | exemple:176-194; cls:811-831 | `fig.float` | `\floatstyle{boxed}` (restyled, see Bespoke code), `\newfloat{reviewbox}{tbp}{lob}`, `\floatname{reviewbox}{Box}`, caption above; `reviewbox*` free from `\newfloat` |
| table or box note (class) | cls:789 | `font.size-commands`, `mark.kernel` | `\reviewnote{a}{..}` = `\par\noindent\footnotesize\textsuperscript{a}\,..\par` |
| balance last page | exemple:531; cls:253 | `cols.balance` | `\balance` after `\printbibliography` |
| cross-references | exemple:204, 495; cls:270-284 | `xref.cleveref`, `xref.kernel` | `cleveref[capitalise,noabbrev]`, `\crefname`/`\Crefname` for figure, table, reviewbox; `\crefcolor` = bold colorMain `\cref` |
| links (class) | cls:264, 613-622 | `meta.hyperref` | hidelinks,unicode,breaklinks; then colorlinks, link/cite colorMain, url colorAccent |
| chemistry and units (class) | cls:258-259 | `art.content-package`, `mark.siunitx` | `mhchem[version=4]`, `siunitx`; load-only, no pre-set commands |
| bibliography | exemple:74, 526; cls:296-309 | `bib.biblatex-biber` | style=numeric-comp, sorting=none, backend=biber, datamodel=enslyonreview, maxbibnames=minbibnames=10, maxcitenames=2, giveninits, uniquename=false, doi/isbn/url/eprint=false |
| bibliography look (class) | cls:326, 340-365, 411, 423-453, 465-474; enslyonreview.dbx:10-11 | `bib.biblatex-biber` | `\bibfont` footnotesize, initials without periods, name alias family-given, bold colorMain brackets, an `article` driver, heading with legend, fields pmid pmcid interest interestnote |
| interest annotations | exemple:82-102; cls:383-405 | `bib.biblatex-biber` | `\refspecialinterest{key}{note}` stores two strings per key, printed under the entry |
| legacy manual references (class, unused) | cls:878-890 | `bib.thebibliography`, `list.enumitem` | `references` environment over `enumerate[leftmargin=1.8em, itemsep=0.5em, topsep=0.3em]` |
| inline maths in body | exemple:233, 238 | `math.amsmath` | `$\gamma$`, `2$'$-5$'$` (content) |
| (guide) class | enslyonreview.tex:7 | `class.article` | 11pt, a4paper |
| (guide) encodings, language, font | enslyonreview.tex:10-12, 19-22 | `font.fontenc-t1`, `lang.babel`, `lang.csquotes`, `font.newtx` | french; `\AtBeginDocument{\shorthandoff{:}}` is a babel command (line 19) |
| (guide) geometry | enslyonreview.tex:36 | `page.geometry` | margin=25mm, headheight=15pt |
| (guide) colours | enslyonreview.tex:39-55 | `color.xcolor` | 16 `\definecolor` HTML values |
| (guide) code listings | enslyonreview.tex:58-95, 330-359 | `code.listings` | `\lstdefinestyle{latexcode}` language=[LaTeX]TeX, colours, breaklines, `literate=` list, `morekeywords={[2]...}`; body `lstlisting[style=latexcode]` |
| (guide) inline code | enslyonreview.tex:367, 573 | `code.verbatim` | `\verb` |
| (guide) boxes | enslyonreview.tex:98-99, 102-128, 222 | `box.tcolorbox`, `code.tcblisting` | `\tcbuselibrary{listings, skins, breakable, most}`; `\newtcolorbox{demoinner}` (sidebyside, lefthand width, colback, colframe, margins), `astuce`, `attention` (title, `attach title to upper`), `\tcblower` in the body |
| (guide) wide demo block | enslyonreview.tex:100, 111-115 | `page.adjustwidth`, `box.tcolorbox` | `\NewDocumentEnvironment{demo}{O{}}` = `adjustwidth{-14mm}{-14mm}` around `demoinner[#1]` |
| (guide) fake renderings | enslyonreview.tex:131-169 | `box.fancybox`, `box.minipage`, `sp.rule`, `font.size-commands`, `mark.kernel` | `\simcite` `\simsection` `\simmeta` `\simabstract` `\simbar` `\simlinkbold` `\simfigbox` `\simbox`: `\colorbox`, `\fcolorbox`, `\fbox`, `\parbox{\dimexpr..}`, `\rule` |
| (guide) font and swatch helpers | enslyonreview.tex:147, 150-151 | `font.nfss`, `box.fancybox`, `sp.rule`, `sp.manual-space` | `\fontfamily{#1}\selectfont`; `\colorbox[HTML]{#1}{\rule{0pt}{5.5pt}\hspace{9pt}}` |
| (guide) header, footer | enslyonreview.tex:176-183 | `hf.fancyhdr`, `sp.rule` | `\fancyhead[L]`, `[R]` with `\leftmark`, `\fancyfoot[C]`, `\renewcommand{\headrule}{{\color{ENSorange}\hrule width\headwidth height 0.4pt}}` |
| (guide) links, refs | enslyonreview.tex:172-175, 317 | `meta.hyperref`, `xref.cleveref`, `xref.kernel` | colorlinks, pdftitle, pdfauthor; `\cref`, `\label` |
| (guide) headings | enslyonreview.tex:193-197 | `head.titlesec` | `\titleformat{\section}{\color{ENSorange}\Large\bfseries}{\thesection.}{0.5em}{}[\color{ENSorange}\rule{\linewidth}{0.6pt}]`, subsection, subsubsection |
| (guide) title page | enslyonreview.tex:204-233 | `front.titlepage-env`, `box.fancybox`, `box.tcolorbox` | `titlepage`, `\vspace*{2cm}`, `\Huge`, `\colorbox{ENSmeta}{\parbox{0.7\linewidth}..}` |
| (guide) contents | enslyonreview.tex:191, 235 | `toc.kernel`, `num.secnumdepth` | tocdepth=2 |
| (guide) tables of files | enslyonreview.tex:260-277 | `tbl.tabular`, `tbl.booktabs` | `@{}ll@{}`, `\toprule` `\midrule` `\bottomrule` |
| (guide) lists | enslyonreview.tex:311-325, 995, 1124 | `list.kernel`, `list.enumitem` | `itemize[noitemsep, topsep=3pt]`, `description[leftmargin=0pt, style=nextline]` |
| (guide) other preamble | enslyonreview.tex:185-190 | `fig.graphicx`, `sp.microtype`, `pgnum.lastpage` | `\graphicspath{{figures/}}`; microtype and lastpage load-only |
| (guide) units | enslyonreview.tex:27, 33, 1074-1077 | `mark.siunitx` | `\DeclareSIUnit{\Molar}{M}`, `\qty`, `\num` |
| (guide) page breaks, spacing | enslyonreview.tex:236, 386, 231 | `pg.break`, `sp.manual-space` | `\clearpage`, `\newpage`, `\vfill` |
| (guide) alias | enslyonreview.tex:199 | `mark.kernel` | `\newcommand{\BibTeX}{\textsc{Bib}\TeX}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\simcite` `\simsection` `\simmeta` `\simabstract` `\simbar` `\simlinkbold` `\simfigbox` `\simbox` | enslyonreview.tex:131-169 | yes | `\newcommand` aliases of `\colorbox`, `\fcolorbox`, `\fbox`, `\parbox`, `\rule` with fixed colours; expand inline (`box.fancybox`, `box.minipage`, `sp.rule`) |
| `\infont`, `\sw`, `\BibTeX` | enslyonreview.tex:147, 150-151, 199 | yes | aliases of `\fontfamily{..}\selectfont` (`font.nfss`), `\colorbox[HTML]` plus `\rule` and `\hspace`, `\textsc` |
| `demoinner`, `astuce`, `attention` | enslyonreview.tex:102-128 | yes | `\newtcolorbox` declarations, one `box.tcolorbox` key list each |
| `demo` environment | enslyonreview.tex:111-115 | yes | `\NewDocumentEnvironment` forwarding `#1` to `demoinner` inside `adjustwidth{-14mm}{-14mm}` (`page.adjustwidth` + `box.tcolorbox`); no counter, conditional or computed layout |
| class layout macros: `\@ENSfullbox`, `\maketitle`, `\@ENSheadtext`, `\@ENSfoottext`, `\crefcolor`, `\reviewnote`, the `reviewbox` float restyle `\fs@boxed` | enslyonreview.cls:283-284, 665-692, 716-729, 789, 812-829 | yes (not needed: inside a published class) | `\@ENSfullbox` = `\colorbox` + `\parbox{\dimexpr..}` (`box.fancybox`, `box.minipage`); `\maketitle` = `\twocolumn[{minipage}]` (`cols.twocolumn-cmd`); header and footer = `fancyhdr` fields (`hf.fancyhdr`); `\crefcolor` = `\textbf{\textcolor{..}{\cref{..}}}`; `\fs@boxed` (rules and `\setbox` code over float's internals) has the effect of a coloured frame with padding 6pt sides and 3pt top and bottom, protruding 6.4pt each side, caption above: `fig.float` `\newfloat` with a top caption plus a `box.tcolorbox` wrapper (colframe=colorMain, colback=white, boxrule=0.4pt, left=right=6pt, top=bottom=3pt, enlarge left and right by -6.4pt) |
| biblatex `article` driver and the interest store `\ENS@interest*` | enslyonreview.cls:381-405, 423-453 | partly (not counted: inside a published class) | The driver is biblatex's own driver API (`\DeclareBibliographyDriver`, `\printnames`, `\iffieldundef`) printing fixed fields in a fixed order; the keyed store (`\csdef`, `\ifcsundef`, `\edef`, `\ifdefstring`) is macro logic, replaceable by `interest` and `interestnote` fields in the `.bib` (the class's own fallback, cls:377-379, 396-405), which is data. If the class were treated as zip-local, this store and the `\fs@boxed` restyle above are the candidates for `BESPOKE/class`; the sample files only pass two strings to `\refspecialinterest` (exemple:82-102) |
| `enslyonreview.dbx` | enslyonreview.dbx:10-11 | yes | biblatex data model extension: `\DeclareDatamodelFields` and `\DeclareDatamodelEntryfields` for four literal fields; shipped inside the CTAN package |

## Content-opaque
- Two JPG figures in `figure*`: enslyonreview-exemple.tex:310, 402.
- Table 1 cell text with citation lists: enslyonreview-exemple.tex:445-486.
- Chemistry formula `\ce{ATP -> ADP + Pi}` in guide demo text (enslyonreview.tex:1070, 1076); `mhchem` is `art.content-package` used as inline content.
- Compiled PDF pages included as pictures of the example: enslyonreview.tex:452, 717 (the shipped file enslyonreview-exemple.pdf is an asset; ship it).
- Placeholder rule box in `\simfigbox` (enslyonreview.tex:158).
- Bibliography data: references.bib, enslyonreview-exemple.bib (50 entries, `pmid`/`pmcid` fields).
- Note: nothing here needs `minted` or shell escape. `\tcbuselibrary{most}` (enslyonreview.tex:99) is a tcolorbox bundle; from memory of the tcolorbox manual it leaves out `minted`, which the file does not name; tcolorbox itself was not read.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
