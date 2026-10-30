yes

# 0081-uithesis: uithesis (Universitas Indonesia thesis class)

- Unverified: read from the source, not compiled.
- Source: Source/0081-uithesis/ (origin: https://mirrors.ctan.org/macros/latex/contrib/uithesis.zip; licence: LPPL 1.3c, `lppl1.3c` in the manifest, uithesis.dtx:3-17)
- Kind: thesis (undergraduate, master's and doctoral theses, internship and Kampus Merdeka reports; also a one- or two-column "journal" layout, README.txt:7-9)
- Lib: v1
- Engine: pdfLaTeX-compatible (uithesis-doc.dtx:1559 says the class targets pdflatex and that XeLaTeX and LuaLaTeX are untested; `inputenc`, `pslatex` and `CJKutf8` at uithesis.dtx:423, 491, 598; `biber` backend, see Blockers)
- Look carried by: class (the zip is the class's own DocStrip source: `uithesis.ins` extracts `uithesis.cls` from the unprefixed lines of `uithesis.dtx`, uithesis.ins:31-33, uithesis.dtx:40-4111; the zip holds no document that uses it)
- Class origin: ctan (https://ctan.org/pkg/uithesis read once: version 3.0.0, 2026-08-20, LPPL 1.3c, listed as contained in MiKTeX, TeX Live not mentioned; matches `\ProvidesClass` at uithesis.dtx:93 and README.txt:34-43)
- Main file: none (no `.tex` sample exists; the documentation `uithesis-doc.dtx` stands in, its user guide at uithesis-doc.dtx:155-1570 lists the class-native vocabulary; the drivers at uithesis.dtx:22-33 and uithesis-doc.dtx:22-40 are `l3doc` documentation builds, not templates) (other samples: none)
- Read: main none present (documentation `.dtx` read at :1-1570 and :3700-3847; its maintainer guide :1580-3700 only by heading outline, it describes code that was read directly), zip-local classes and styles all (the class code, `uithesis.dtx` lines 40-4111, read in full; `uithesis.ins` read; the two PDFs and the two PNGs were not opened as text)

## Verdict
`yes`, on the class dimension only. The zip is the source of `uithesis`, a class published on CTAN (W1 met, README.txt:43, ctan.org/pkg/uithesis), so it is one way, `class.uithesis`, whose parameters are its xkeyval options and whose native vocabulary is the metadata and front-matter commands listed below. An emitter writes `\documentclass[format=...,type=...,jenjang=...,lang=...]{uithesis}`, the metadata commands, `\makefrontmatter`, the body, `\makebibliography`, and copies no macro logic; no component is exercised by a sample, because the zip holds none. Nothing in the zip is unpublished, so nothing counts as bespoke under the rubric. The class's internal code is still large and in two places not reducible to component ways (page-parity logic and counting patches of the table-of-contents machinery); those are recorded under Blockers and Bespoke code so the class dimension is not hidden. This is evidence about the class dimension, not about the component ways.

## Blockers
none

Recorded, not counted (all sit inside the published class; the rubric counts the class as one way):
- `BESPOKE/class` (not counted) physical-page counter driven by `\EveryShipout` and odd/even logic that inserts unnumbered blank pages and switches running heads (uithesis.dtx:876-881, 1199-1204, 1337-1400, 2058-2063, 3059)
- `BESPOKE/class` (not counted) the class replaces kernel internals `\@writefile`, `\addcontentsline`, `\addtocontents`, `\contentsline` to count entries per list, writes the counts to the `.aux` at `\AtEndDocument`, and decides next run whether each list page is printed (uithesis.dtx:620-630, 1898-2098, 4009-4105); needs two or more runs after structural edits (uithesis.dtx:3045-3046)
- `EXTERNAL/package` (not counted; the lib already holds `bib.biblatex-biber`) `biblatex` is loaded unconditionally with `backend=biber` (uithesis.dtx:493-504); the doc states biber must be on the PATH (uithesis-doc.dtx:304-306)
- `EXTERNAL/package` (not counted; soft failure, lib way `idx.glossaries`) in the default monograph format `glossaries-extra` is loaded with `automake` and `\makeglossaries` (uithesis.dtx:575-577), which asks the indexer to run through shell escape; without it the document still compiles and the glossary needs a manual `makeglossaries` run (uithesis-doc.dtx:1460-1463)

## Class setting
- Class: `class.uithesis` options (xkeyval, uithesis.dtx:128-263): `format=monograph|journal` (:142), `type=Skripsi|Tesis|Disertasi|Laporan Kerja Praktik|Kampus Merdeka` (:150), `jenjang=Sarjana|Magister|Doktor` (:164), `lang=indonesian|english` (:171), `columns=1|2` (journal only, :178), `spacing=semantic|calibrated` (:193), `paragraph=noindent|indent` (:198), `plagiarismcheck=true|false` (:207), `print=oneside|twoside` (monograph only, :213), `citation=apa|ieee|acm|vancouver|mla|harvard|chicago|turabian|acs|nature|science|aip|oscola|custom` (:237); value-less shortcuts `monograph journal Skripsi Tesis Disertasi KP MBKM Sarjana Magister Doktor indonesian english indent noindent` (:246-259); every other option goes to `report` (:262). Base class `\LoadClass[12pt,a4paper,onecolumn,twoside,final]{report}` (:266), so `class.report` is the inherited base.
- Class-native vocabulary used (documented usage, no sample): preamble metadata `\judul \judulInggris \penulis \npm \programStudi \fakultas \gelar \bulanTahun \pembimbing \penguji \tanggalSiapSidang \tanggalLulus \kota \tahunAkademik \pengesahanPDF \namaTipeTesis \setmakaraimage \kampusMerdekaType \mitra \aiplatform \tujuanai` (uithesis-doc.dtx:461-625; dtx:3134-3256); citation overrides `\setuicitationpreset \setuicitestyle \setuibibstyle \setuibiblatexstyle \setuicitationmapping \setuibiblatexoptions` (doc:411-447; dtx:404-413); `\bibliography{file}` redefined to `\addbibresource` (dtx:511-520); page-content environments collected before `\begin{document}`: `abstrakID`+`\katakunci`, `abstractEN`+`\keywords`, `kataPengantar`, `pernyataanOrisinalitas`, `persetujuanPublikasi`, `pernyataanAI`, `suratPernyataan` (doc:690-754; dtx:2278-2298); `\makefrontmatter`, `\makebibliography`, `\makeglossarypage` (doc:729-763); content aliases `\bab \sect \pic \tab \equ \lst \apdx`, `\f \bo \bi \code \m \mc \todo \captionsource \captionsourcecont \inpdf \putpdf \blankpage \addequtotoc \minimumListEntries` (doc:847-942; dtx:1819-1891); page control `\clearchapter \forceclearchapter \setfirstheaderfooter \setoddevenheader \setoddevenfooter \enableboldchapterintoc \disableboldchapterintoc \CAPinToC \noCAPinToC \enablechapterseparatorspaceinlists` (doc:946-1001); `\newUIlist{ext}{type}{label}{title}` (doc:1005-1018; dtx:2171-2239); `UIlongtable` with seven setup commands (doc:1022-1047; dtx:1107-1178); `lampiranBab` (doc:1271-1282; dtx:3324-3344); column types `P L B U C O E R T` (doc:1302-1321; dtx:1792-1808); journal `UIwidetable UIwidefigure UIwideblock UIlandscape UIfullwidthpages` (doc:1366-1399; dtx:1022-1100); glossary `\gls \newglossaryentry \newacronym` (doc:1446-1455); listings `\lstinputlisting`, `lstlisting` (doc:1505-1515).

## Component map
Each row names the lib way that realises the part inside the class; an emitter reaches all of them with the one `class.uithesis` line. Nothing is compiled; load-only means the package is loaded and the class code never calls it (checked by grep).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | dtx:93, 128-263 | `class.uithesis` | xkeyval choice keys listed above; policy booleans `\ifUI@calibratedspacing`, `\ifUI@twosideprint`, `\ifUI@paragraphindent`, `\ifUI@plagiarismcheck` (dtx:100-110) |
| base class | dtx:266-267 | `class.report` | `12pt,a4paper,onecolumn,twoside,final`; `\raggedbottom` |
| paper, size, binding | dtx:266, 213-221 | `page.class-options` | a4paper, 12pt on the base; `print=oneside|twoside` is the class's own flag for blank pages and footers |
| margins | dtx:427-433, 3075, 3106 | `page.geometry` | monograph left=top=right=bottom=3cm, headheight=14.5pt; journal left=right=2cm, top=bottom=3cm; journal front matter `\newgeometry{left=3cm,top=3cm,right=3cm,bottom=3cm}` then `\restoregeometry` |
| top margin tweak | dtx:435 | `page.setlength` | `\addtolength{\topmargin}{-14.5pt}` |
| bottom alignment | dtx:267 | `pg.flush` | `\raggedbottom` |
| line spacing | dtx:269-276, 2417, 2506 | `sp.setspace` | `\setstretch{1.4}` (calibrated) or `\onehalfspacing` (semantic); `singlespace*`, `\singlespacing`, `\doublespacing` on front pages |
| paragraph shape | dtx:279-287, 887 | `sp.lengths` | noindent: `\parindent` 0pt, `\parskip` 12pt; indent: `\parindent` 1.5em, `\parskip` 0pt; journal `\parskip` 0pt unless indent; `\emergencystretch` 1.5em (:443) |
| first-paragraph indent | dtx:582-584 | `sp.indentfirst` | journal with `paragraph=indent` only |
| hyphenation looseness | dtx:426 | `sp.hyphenat` | `\AtBeginDocument{\sloppy}` |
| manual spacing | dtx:2424-2447, 2503-2508, 2816-2817 | `sp.manual-space` | `\vspace*{<named lengths>}`, `\\[len]`, `\vfill` in the cover, approval, declaration pages; named lengths set once at dtx:1409-1551 (`sp.lengths`) |
| rules | dtx:2539, 2816 | `sp.rule` | `\rule{0.85\linewidth}{0.4pt}` signature line; two `\hrule height 1.5pt` on the publication page |
| text font | dtx:423 | `font.mathptmx` | `pslatex` (Times roman, Helvetica sans, Courier mono; the package is the parameter) |
| footer and page-number fonts | dtx:112-121 | `font.size-commands` | footer `\fontsize{10}{12}`, `\fontfamily{phv}`, `\bfseries`; page number `\fontsize{12}{15}`, `\fontfamily{ptm}` |
| sans family for footer | dtx:115, 423 | `font.helvet` | family `phv` supplied by `pslatex` |
| encodings | dtx:491 | `font.fontenc-t1` | `inputenc` utf8 (no `fontenc`) |
| colour | dtx:488, 634-640 | `color.xcolor` | `xcolor[dvipsnames]`; `\definecolor` codegreen (0,.5,0), codegray (.35,.35,.35), codepurple (.58,0,.82); `\colorlet` keywordcolor=NavyBlue, typecolor=teal, greencomments=OliveGreen |
| chapter heading, monograph | dtx:709-810 | `head.class-native` | "BAB" + number and uppercase title, bold, single-spaced (`\UI@chapterHeadingStyle`), tuned negative `\vspace*` (-4.5em, -1em, -4em), ConnyRevised after `fncychap`; unnumbered chapters centred and uppercased (:804-809) |
| chapter heading, journal | dtx:905-938 | `head.class-native` | unnumbered, uppercase, `\fontsize{12}{15}\bfseries`, inline flow, 1.2 `\baselineskip` before, 6pt after |
| section levels | dtx:865-874, 939-984 | `head.kernel` | `\renewcommand\section` ... `\subparagraph` via `\@startsection`; monograph levels 1-5, indent 0pt, beforeskip 0pt, afterskip `1pt plus -1pt minus 1pt`, style `\normalfont\fontsize{12}{15}\bfseries`; journal levels 0 and 1 with beforeskip `-1.5ex plus -.5ex minus -.1ex`; star form wrapped by `\RenewDocumentCommand` |
| numbering depth | dtx:862-863, 889-890 | `num.secnumdepth` | monograph secnumdepth 3, tocdepth 3; journal secnumdepth -1, tocdepth 3 |
| appendix numbering | dtx:719-724, 4019-4028 | `num.appendix` | `\appendix` resets chapter and section, letters via `\@Alph`; patched at begin document to add a "LAMPIRAN/APPENDIX" separator page (monograph) |
| counters | dtx:877-881, 1906-1910, 2195 | `num.counters` | `\newcounter{chapterpagecount}[chapter]`, `UI@physicalpage`, per-list entry counters, `\counterwithin{<type>}{chapter}` for `\newUIlist` |
| header, footer | dtx:1184-1310 | `hf.fancyhdr` | `\fancyhf{}`, `\headrulewidth` 0pt, `\headwidth=\textwidth`; page styles `plain`, `standard`, `first-pages`, `onlypage`, `journal-front`, `lampiran-first`, `lampiran`; page number bottom centre, "Universitas Indonesia" bottom outer side (monograph twoside) or top-right number plus bottom-right text (journal); `plagiarismcheck` blanks all |
| page numbering | dtx:2979, 3066, 3072, 3108 | `pgnum.pagenumbering` | roman for front matter (start page 2 or 3 by type), arabic for the body; journal restarts arabic at 1 on the abstract |
| page breaks, blank pages | dtx:1337-1400 | `pg.break` | `\clearpage`, `\newpage`, blank verso page `\null\thispagestyle{empty}\addtocounter{page}{-1}`; parity logic is the BESPOKE item above |
| landscape | dtx:571, 1094-1100 | `pg.landscape` | `pdflscape` `landscape` inside `UIlandscape` |
| include PDF pages | dtx:449, 1865-1866, 3012 | `pg.include-pdf` | `\includepdf[pages=-,pagecommand=...]` for `\inpdf`, `\putpdf`, `\pengesahanPDF` |
| language | dtx:436-440, 664-673, 4030-4050 | `lang.babel` | `[indonesian,english]` or `[english,indonesian]` (main language last); `\addto\captionsindonesian` and `\captionsenglish` set Gambar/Figure, Tabel/Table, Kode/Code; begin-document renames `\bibname \contentsname \listfigurename \listtablename \lstlistlistingname \glossaryname` |
| quotation marks | dtx:492 | `lang.csquotes` | package, no options (needed by biblatex with babel) |
| CJK support | dtx:598 | `lang.cjk` | `CJKutf8`, loaded and never called; the lib tags `lang.cjk` as xe/lua, `CJKutf8` itself runs under pdfTeX |
| PDF metadata, links | dtx:452, 606-619 | `meta.hyperref` | `a4paper,colorlinks=false,pdfborder=0 0 0,linkcolor=blue,citecolor=black,bookmarksopen=false,bookmarksnumbered=true,plainpages=false,pdfpagelabels=true,hypertexnames=false,pdfstartview=FitH,pdfview=FitH` |
| URLs | dtx:453-454 | `meta.url` | `\urlstyle{same}` |
| cross-references | dtx:1884-1891 | `xref.kernel` | `\label`, `\ref`; aliases `\bab \sect \pic \tab \equ \lst \apdx` expand to the label word |
| cover page | dtx:2415-2453 | `front.class-native` | `\UI@typeset@sampul`: `titlepage` + `singlespace*` + `center`; logo `\includegraphics[width=2.5cm]` (`fig.graphicx`), bold "UNIVERSITAS INDONESIA", title, work type, authors, faculty, programme, city, month-year, spaced by `\vfill` and named lengths |
| inner title page | dtx:2456-2498 | `front.class-native` | same layout plus "submitted as one of the requirements ..." and `\gelar` |
| originality, AI-use, declaration letter, preface, publication consent | dtx:2501-2517, 2710-2778, 2781-2875 | `front.dedication` | boxes of fixed text per language (labels dtx:1599-1771) with a signature `tabular` (`\UI@sigTable`, dtx:2325-2354); heading via `\@makeschapterhead` (monograph) or centred bold (journal) (dtx:2302-2318); override bodies through collector environments |
| approval pages | dtx:2520-2707 | `front.class-native` | four variants (internship, Kampus Merdeka, Doktor, S1/S2) from `tabularx`, `longtable` (Doktor board) and `tabular`; or an external signed PDF (`pg.include-pdf`) |
| abstracts | dtx:2878-2967 | `abs.class-native` | monograph: `\chapter*` + `tabularx` metadata block + body; journal: centred title block + justified text; Indonesian and English versions; bodies collected by `environ` (dtx:2292-2293) |
| keywords | dtx:2289-2290, 2913, 2919, 2954, 2960 | `abs.keywords` | `\katakunci`, `\keywords` print "Kata kunci:" and "Keywords:" lines |
| front-matter flow | dtx:2974-3127 | `front.class-native` | `\makefrontmatter`: per format and `type` the pages in fixed order (cover, inner title, approval, originality, AI-use, declaration, preface, publication consent, abstracts, lists) |
| metadata store | dtx:3134-3256 | `front.class-native` | `\penulis \npm \programStudi \pembimbing \penguji` fill numbered slots with counters; scalar setters `\judul \fakultas \gelar \kota ...` |
| contents | dtx:446-447, 2135-2144, 4071-4073 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables` inside `\addDefaultListPage` |
| contents styling | dtx:447, 2101-2110, 4071-4083 | `toc.tocloft` | `tocloft[titles]`; `\cftchapleader`, `\cftdotsep`, `\cftfignumwidth` 70pt, `\cfttabnumwidth` 60pt, `\cftfigpresnum` `\pic~`, bold chapter entries toggled by `\addtocontents{toc}` |
| contents extras | dtx:446 | `toc.etoc` | `tocbibind` (bibliography and lists in the ToC) |
| custom lists | dtx:2171-2266, 2246-2254, 3309-3315 | `toc.tocloft` | `\newlistof{<type>}{<ext>}{<title>}` for equations (`loe`), appendices (`lox`) and every `\newUIlist`; `\renewcommand\cft<type>indent` 0pt, `numwidth` measured from the label, `aftersnum` `.`; list of listings through `\lstlistoflistings` (`code.listings`) |
| captions | dtx:679-682, 1872-1882 | `cap.caption` | `\DeclareCaptionJustification{centering}`, `\DeclareCaptionFont{uicaption}{\fontsize{12}{15}\selectfont}`, `\captionsetup{labelfont=normalfont,textfont=normalfont,font=uicaption,justification=centering,parindent=0pt}`; `\captionsource` adds a 10pt "Sumber:" line |
| figures | dtx:468-472, 474-475, 996-997 | `fig.graphicx` | `\setkeys{Gin}{width=\UI@maxwidth,keepaspectratio}` caps images at `\linewidth`; `float` with `\floatplacement{figure}{H}` and `{table}{H}` (`fig.float`) |
| subfigures, wrap figures | dtx:474, 569 | `fig.subcaption` | `subcaption` loaded; `fig.wrapfig` `wrapfig` loaded; neither is called in the class |
| wide floats, full-width blocks | dtx:587-593, 1022-1072 | `fig.placement` | `dblfloatfix` (two-column journal); `UIwidetable`/`UIwidefigure` wrap `table*`/`figure*` |
| tables | dtx:457-464, 1000, 1792-1811 | `tbl.tabular` | `array` with `\newcolumntype` P L B U C O E R T (p/m/b with ragged or centred); `\AtBeginEnvironment{table}{\centering}` (`sp.ragged`) |
| table packages | dtx:457-464 | `tbl.booktabs` | `booktabs`; `tbl.multirow` `multirow`; `tbl.tabularx` `tabularx`; `tbl.colortbl` `colortbl` (`\rowcolor` in `\todo`, dtx:1835-1862) |
| long tables | dtx:459-460, 1107-1178 | `tbl.longtable` | `UIlongtable`: `longtable` with `\LTleft`/`\LTright` `0pt plus 1fill` (monograph) or `mpsupertabular` (two-column journal), head/foot set by seven commands |
| code listings | dtx:487, 641-661 | `code.listings` | `\lstdefinestyle{uistyle}`: basicstyle `\ttfamily\small`, keywordstyle NavyBlue, commentstyle codegreen, stringstyle codepurple, numbers=left, numbersep=5pt, breaklines, breakindent=1em, columns=fullflexible, captionpos=b, tabsize=2, showspaces/tabs/stringspaces false; `\lstset{style=uistyle}` |
| language definitions | dtx:3431-4003 | `code.listings` | about 30 `\lstdefinelanguage` and `\lstalias` blocks (ABS, acceleo, CSS, D, Dart, Docker, FSharp, GDScript, GLSL, HLSL, Java dialects, Groovy, Kotlin, JavaScript, Julia, Clojure, Scheme, Markdown, PowerShell, Rust, Scala, Solidity, Swift, TOML, YAML) |
| inline markup | dtx:1819-1830 | `mark.kernel` | `\f`=`\textit`, `\bi`, `\bo`=`\textbf`, `\code`=`\texttt` (the doc says `\lstinline`, uithesis-doc.dtx:1518; the code says `\texttt`, dtx:1828), `\latex` |
| maths | dtx:482-484, 570, 1825-1826 | `math.amsmath` | `amsmath`; `math.amssymb` `amsfonts`, `amssymb`; `math.bm` `bm`; `\m`, `\mc` bold-math wrappers |
| lists | dtx:565, 858-859 | `list.enumitem` | `\setlist[itemize]{nosep,leftmargin=*}`, `\setlist[enumerate]{nosep,leftmargin=*}` (monograph) |
| glossary | dtx:576-581, 2071-2085, 3357-3364 | `idx.glossaries` | `glossaries-extra[automake,acronyms,symbols,nonumberlist,nomain]` + `\makeglossaries` (monograph) or without `automake` (journal); `\printglossaries` in `\makeglossarypage` |
| bibliography | dtx:493-504, 3369-3382 | `bib.biblatex-biber` | `backend=biber,citestyle,bibstyle,natbib=true,url=true,doi=true,language=british,alldates=long,texencoding=utf8`; `\printbibliography[heading=bibintoc,title={Daftar Referensi}|{References}]` |
| citation presets | dtx:294-415 | `bib.biblatex-biber` | presets map to `citestyle`/`bibstyle` pairs (apa, ieee, numeric-comp/numeric, authoryear, authortitle, chicago-authordate, chicago-notes, chem-acs, nature, science, phys, oscola, acm) with `\IfFileExists` fallbacks to numeric or authoryear |
| Indonesian bibliography strings | dtx:524-562 | `bib.biblatex-biber` | `\DeclareLanguageMapping{indonesian}{<mapping>}`, `\DefineBibliographyStrings` month names and "Diakses pada tanggal", ordinal suffixes switched off |
| appendices | dtx:3274-3344, 3388-3411 | `hf.fancyhdr` | `lampiran-first` and `lampiran` page styles (two-line head: number and "Lampiran A: title (lanjutan)", `\headheight` enlarged to `2\baselineskip+1em`); separator page `titlepage` with `\Huge` "LAMPIRAN" at 6cm (`front.titlepage-env`, `font.size-commands`) |
| two-column journal | dtx:3120-3125, 589-593, 1324-1335 | `cols.twocolumn-option` | `\twocolumn` after the front matter (class-level switch), `\columnsep` 0.25in, `\tabcolsep` 4pt; `cols.cuted` `cuted` `strip` in `UIwideblock`; `cols.balance` `balance` and `flushend`, with `\clearpage` redefined to `\balance` first |
| other loaded packages (load-only) | dtx:463, 465 | `cols.multicol` | `multicol` loaded; `box.tcolorbox` `tcolorbox[most]` loaded; neither is called |
| TikZ (load-only) | dtx:476-479 | `art.tikz` | `tikz` with `positioning`, `chains`; `bg.tikzpagenodes` `tikzpagenodes`; grep finds no `tikzpicture`, `\tikz`, `\node` or `\draw` anywhere in the class, so nothing is drawn and nothing is ART |

## Bespoke code
None counts as bespoke under the rubric: every definition below sits inside `uithesis`, published on CTAN (W1) and carried as `class.uithesis`. The last column says what rebuilding from component ways alone would take.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| whole class code | uithesis.dtx:40-4111 | not bespoke (published) | one `\documentclass` line with options |
| xkeyval option layer, policy booleans | dtx:100-263 | yes | emitter resolves the options and writes the chosen branch |
| ConnyRevised chapter head `\@makechapterhead`, `\@schapter`, `\@makeschapterhead` | dtx:709-810 | yes | `head.titlesec` (or `head.fncychap`) with uppercase bold format and `\titlespacing` carrying the negative offsets |
| `\@startsection` renewals, star-form wrapper | dtx:865-874, 939-984 | yes | `head.kernel` or `head.titlesec` |
| `UI@physicalpage` counter via `\EveryShipout`, `\clearchapter`, `\forceclearchapter`, `\UI@insertdummyblank*`, `\UI@showOnPhys*` | dtx:876-881, 1199-1204, 1337-1400 | no, by components | hand-rolled counter and parity conditionals; `\cleardoublepage` with `pg.emptypage` approximates the blank pages but not the unnumbered-blank numbering or the parity-switched heads; needs the class |
| counting patches of `\@writefile`, `\addcontentsline`, `\addtocontents`, `\contentsline`; previous-run counts via `\AtEndDocument`; `\UI@condListPage` | dtx:620-630, 1898-2098, 4009-4105 | no, by components | patches kernel macros and runs a two-pass `.aux` protocol to drop a list page below a threshold; `toc.tocloft` and `toc.tocbasic` cannot express it; needs the class |
| `\newUIlist` | dtx:2171-2239 | yes (apart from counting above) | `toc.tocloft` `\newlistof` + `\cft*` settings + `cap.caption` `\caption*` |
| front-matter page typesetters, `\makefrontmatter` flow, `\strcompare`, `\UI@IfSingleAuthor` | dtx:823-853, 2325-3127 | yes, for a fixed choice of format, type, level, language and author count | write the resolved page with `front.titlepage-env`, `tbl.tabularx`, `tbl.longtable`, `sp.manual-space`; the branching only selects content |
| content collectors (`NewEnviron`) and metadata accumulators | dtx:2292-2298, 3149-3256 | yes | plain text and macros at the call site; counters only pick a slot |
| citation preset resolver | dtx:223-415 | yes | `bib.biblatex-biber` `citestyle`/`bibstyle` and `\DeclareLanguageMapping` written directly |
| journal helpers, `\clearpage` override | dtx:1022-1100, 1324-1335 | yes | `figure*`/`table*`, `cols.cuted`, `pg.landscape`, `cols.balance` |
| `UIlongtable` | dtx:1107-1178 | yes | `tbl.longtable` (`longtable` or `supertabular`) with `\endfirsthead`, `\endhead`, `\endfoot`, `\endlastfoot` |
| `lampiranBab`, `\makeappendixseparator` | dtx:3324-3344, 3388-3411 | yes | `hf.fancyhdr` styles + `toc.tocloft` `\newlistof` + `titlepage` |
| listings style and language definitions | dtx:641-661, 3431-4003 | yes | `code.listings`; one `\lst@definelanguage[Scheme]{Lisp}` call uses the package's low-level name (dtx:3816), same effect as `\lstdefinelanguage` |
| `\newcolumntype` set, `\tabitem`, `\todo`, `\var`, `\Var`, `\m`, `\mc`, label aliases | dtx:1792-1891 | yes | `tbl.tabular`, `tbl.colortbl`, `mark.kernel`, `math.bm`, aliases written as text |
| begin-document renames and `\cft*` settings | dtx:4009-4084 | yes | `lang.babel` string renames, `toc.tocloft` settings |
| support packages with no component and no lib way | dtx:128, 489, 566-568 | not a component | `xkeyval`, `xparse`, `everyshi`, `environ`, `etoolbox` only program the class; their parameters are code, so they fail W2 and are not proposed as ways |

## Content-opaque
none (no figure or table artwork in the zip). The cover logo is a shipped image, `uithesis-makara.png` (646 x 642 PNG) used at dtx:2421 and 2462 through `\includegraphics`, so it is an asset and not drawn artwork. `uithesis-makara-kuning.png` (1217 x 1221 PNG) ships but is referenced only by the doc (uithesis-doc.dtx:1556), as the alternative logo for `\setmakaraimage`. Not shipped: the `example/`, `config/` and `internals/` folders and `latexmkrc` that README.txt:21 and the doc (uithesis-doc.dtx:1438, 1462, 1501) name; the images sit at the zip root.

## Lib changes
- New ways proposed: none. Notes for the consolidator: `font.mathptmx` was used for `pslatex` (package is the parameter); `cols.balance` was used for both `balance` and `flushend` (same job, load-only); `lang.cjk` is tagged xe/lua in the lib but `CJKutf8` works under pdfTeX; `idx.glossaries` is used with `automake`. `class.uithesis` is a class way, written plainly.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
