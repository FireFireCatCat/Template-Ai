no

# 0648-estamos-ntua-ece-thesis-template: NTUA ECE diploma thesis template (Greek, ntua-thesis class)

- Unverified: read from the source, not compiled.
- Source: Source/0648-estamos-ntua-ece-thesis-template/ (origin: https://codeload.github.com/estamos/NTUA-ECE-Thesis-Template/zip/refs/heads/master; licence: MIT)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (ntua-thesis.cls:3 "pdfLaTeX version"; `LGR,T1` fontenc and babel greek, ntua-thesis.cls:34-36)
- Look carried by: zip-local (the whole look is in `ntua-thesis.cls`, a `\LoadClass{book}` class of 1850 lines; `main.tex` only sets data fields, colours and options)
- Class origin: zip-local (`ntua-thesis` is not on CTAN: ctan.org/pkg/ntua-thesis returned 404; the zip is a third-party GitHub repo by E. Stamos, "adopted from the NTUA template", ntua-thesis.cls:5-9, not an NTUA kit)
- Main file: main.tex (other samples: none; chapters are `\include`d from front_matter/, body_matter/, back_matter/)
- Read: main yes, zip-local classes and styles partly (ntua-thesis.cls all 1850 lines; every front/body/back .tex file all; ntua.bst lines 1-130 and 1340-1538 read, the entry-type functions 130-1340 only outlined by Grep; `references.bib` not read, content)

## Verdict
No. The class draws its cover banner, chapter banners, part pages, footer page-number boxes and the CD label and cover with TikZ overlays at `current page` (template-defining artwork with no declarative lib way), the sample only avoids them by passing the `plain` option. The class also carries hand-rolled computed layout (signature tables whose column width is computed from a comma-split name list), patches of amsmath, float and listings internals, and it loads `epstopdf` unconditionally while the logo is an EPS with no converted PDF, so the document needs Ghostscript. Most of the rest (titlesec chapter format, fancyhdr, caption, newfloat, lettrine, babel, hyperref, bibtex with a `.bst`) reduces cleanly to lib ways, so the "no" rests on the blockers below, not on missing component ways.

## Blockers
- `ART/class` cover-page overlay: shaded strip, grey band and logo node drawn in a nested `tikzpicture[remember picture,overlay]` at `current page.north west` when `plain` is not set (ntua-thesis.cls:345-369)
- `ART/class` cover title in a rounded, shaded TikZ node (ntua-thesis.cls:394-405)
- `ART/class` chapter-opening banner: grey rectangle across the page and a rounded filled node holding label and title, overlay at `current page.north west` (ntua-thesis.cls:1489-1517)
- `ART/class` part page: circle node and rounded title node on a page-wide band, for body parts and for appendices (ntua-thesis.cls:1560-1606)
- `ART/class` footer page number as `\tikz\node[fill=...]` (ntua-thesis.cls:1028, 1063, 1068)
- `ART/class` CD label (two circles, `text along path` arc text, barcode frame) and CD cover (frames, dashed cut line), disabled only by `plain`; the sample calls both (ntua-thesis.cls:1252-1434; main.tex:314, 319)
- `BESPOKE/class` `\signaturestable`, `\extractname`, `\acksignatures`: author count from `\StrCount` on a comma list, column fraction `min(0.85/n, 0.3)` by `calculator` `\DIVIDE` and `\MIN`, `\foreach` loops that build one `\parbox` per name, `\ifx\n\numberofauthorsGR` conditionals that decide `\hfill` (ntua-thesis.cls:883-928, 1084-1128)
- `BESPOKE/class` amsmath internal `\tagform@`/`\maketag@@@` redefined to colour the equation number (a box in the non-plain branch, coloured text in `plain`) inside a macro run at end of preamble (ntua-thesis.cls:253-264)
- `BESPOKE/class` new `float` style `coloruled` written by redefining `\@fs@pre`, `\@fs@post`, `\@fs@mid`, `\@fs@capt` (ntua-thesis.cls:1212-1219)
- `BESPOKE/class` Greek letters added to listings' letter set by patching the internal `\lst@DefEC` under `\catcode0=12` (ntua-thesis.cls:1224-1232)
- `BESPOKE/class` `\footacknowledgement` swaps the kernel `\@makefntext` around a `\footnotetext` (unused by the sample) (ntua-thesis.cls:1076-1083)
- `EXTERNAL/package` `epstopdf` is loaded unconditionally (ntua-thesis.cls:1636); the NTUA logo is EPS only (`logo/pyrforos.eps`, path set at ntua-thesis.cls:191-200, drawn at ntua-thesis.cls:321, 800) and no `-eps-converted-to.pdf` ships for it, so Ghostscript is needed; `figures/peerArchitecture.eps` (body_matter/chap4.tex:23) has a shipped converted PDF, which does not help the logo

## Class setting
- Class: `class.book` options: `a4paper,11pt,english,greek,twoside` fixed by the zip-local class (ntua-thesis.cls:32); the options the sample gives the zip-local class are `modern,hyperref,watermark,histinit,noindex,plain,newlogo` (main.tex:43), declared as `\newif` switches at ntua-thesis.cls:613-656 (the line-30 catch-all passes unknown options on to `book`)
- Class-native vocabulary used: data setters `\title[cover]{..}` `\subtitle` `\toutis` `\authorNameCapitalGR` `\authorNameGR` `\authorNameEN` `\supervisor` `\supervisorTitle` `\supervisorMaleFemale` `\thesisPlaceDate` `\ackPlaceDate` `\examinationDate` `\declarationDate` `\copyrightYear` `\firstExaminer` `\secondExaminer` (+ `Title` forms) (main.tex:73-183); colours `\chaptercolor` `\appendixcolor` `\hyperlinkcolor` `\titlecolor` `\titlebackgroundcolor` (main.tex:191-205); `\coverpageimage` (main.tex:237); environments `abstract` `abstracteng` `keywords` `keywordseng` `acknowledgements` `preface` `Illustration` (front_matter/abstract.tex:1,28,36,59; front_matter/acknowledgements.tex:8; front_matter/preface.tex:1; back_matter/appE.tex:4); commands `\beginfrontmatter` `\beginmainmatter` `\appendices` `\thesisDedication` `\includeabbreviations` `\includeglossary` `\printindices` `\InitialCharacter` `\indexGR` `\indexEN` `\en` `\tl` `\src` `\gloss` `\abbrevGR` `\abbrevEN` `\createcdlabel` `\createcdcover` (main.tex:252-319). `class.ntua-thesis` is not a way (zip-local); its parts are mapped below.

## Component map
Rows give the branch the sample selects (`modern,hyperref,watermark,histinit,noindex,plain,newlogo`) unless stated.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | ntua-thesis.cls:32 | `class.book` | a4paper, 11pt, twoside, english, greek |
| paper and size | ntua-thesis.cls:32 | `page.class-options` | a4paper, 11pt |
| page geometry | ntua-thesis.cls:152-159 | `page.setlength` | oddsidemargin=7mm, evensidemargin=0mm, textwidth=150mm, topmargin=10pt then `\advance` by -headheight -headsep, textheight=245mm, headheight=50pt (+2pt at :1034, topmargin -2pt at :1036) |
| header, footer | ntua-thesis.cls:28, 51, 1004-1036 | `hf.fancyhdr` | `\fancyhf{}`; head RO/LE `\footnotesize` coloured `\rightmark`/`\leftmark` (:1032-1033); foot LE,RO `\colorbox{chapter colour}{\color{white}\textbf{\thepage}}` (:1022-1024); with `watermark`+`plain` also foot LO/RE italic Greek text "Diplwmatik'h Ergas'ia" (:1005-1020) |
| plain / indexpage page styles | ntua-thesis.cls:1037-1071 | `hf.fancyhdr` | `\fancypagestyle{plain}` (no rules, page box in foot), `\fancypagestyle{indexpage}` (head = `\indexname`) |
| coloured page box | ntua-thesis.cls:1008, 1023 | `box.fancybox` | `\colorbox` with white bold page number |
| running heads text | ntua-thesis.cls:996-1002 | `hf.fancyhdr` | `\chaptermark` -> `\markboth{\mbox{\selectlanguage{greek}\@chapapp} \thechapter.  #1}{}`; `\sectionmark` -> `\markright{\thesection  #1}{}` (reducible, see Bespoke) |
| page style switches | ntua-thesis.cls:149, 1176, 1264 | `hf.pagestyle-kernel` | `\thispagestyle{empty}`, `\pagestyle{empty}` |
| blank pages | ntua-thesis.cls:977-994 | `pg.emptypage` | `\cleardoublepage` redefined to emit an empty-style page |
| page breaks | ntua-thesis.cls:149, 1175, 1184 | `pg.break` | `\newpage`, `\cleardoublepage`, `\pagebreak` |
| page numbering | ntua-thesis.cls:962-971, 1725-1731 | `pgnum.pagenumbering` | with `hyperref` the front matter calls `\mainmatter`, so arabic throughout (:1726-1727); without it roman then arabic (:964, 969) |
| line spacing | ntua-thesis.cls:1763 | `sp.linespread` | `\baselinestretch`=1.2 |
| spacing env | ntua-thesis.cls:897, 917, 1441 | `sp.setspace` | `spacing{1}` inside the signature boxes |
| first-line indent | ntua-thesis.cls:1637 | `sp.indentfirst` | load only |
| hyphenation | ntua-thesis.cls:1641; main.tex:242 | `sp.hyphenat` | `hyphenat` (`\nohyphens`, :898); `\hyphenation{ο-ποί-α}` |
| rules and fills | ntua-thesis.cls:488, 826 | `sp.rule` | `\rule{\textwidth}{1.5pt}` in the colour; `\dotfill` signature lines |
| manual spacing | ntua-thesis.cls:318-330, 388-389, 408-422 | `sp.manual-space` | `\vspace{-2cm}`, `\vspace{0.5cm}`, `\vfill`, `\\[10pt]`, `\hfill` |
| drop capitals | ntua-thesis.cls:1742-1749; body_matter/intro.tex:2 | `sp.lettrine` | `\lettrine[lines=2]{\color{..}\scalebox{1.3}{#1}}{}` (modern); `\InitialCharacter{Ο}` |
| encodings | ntua-thesis.cls:35-36 | `font.fontenc-t1` | inputenc utf8; fontenc LGR,T1 |
| text and maths font | ntua-thesis.cls:687 | `font.serif-pkg` | `kmath,kerkis` (kerkis: CTAN, LPPL 1.3c; URW Bookman with Greek) in `modern`; `classic` keeps Computer Modern (:690-692) |
| mono font | ntua-thesis.cls:688 | `font.mono` | `beramono` with `scaled=.75` |
| font sizes | ntua-thesis.cls:171-175, 391, 1443-1449 | `font.size-commands` | `\huge` `\Large` `\LARGE` `\Huge` `\small`; relative scale `\textscale{0.93}{..}` from `relsize` (considered: relsize, mapped here, same type of effect with the package as parameter) |
| case | ntua-thesis.cls:435-436 | `mark.case` | `\MakeUppercase` on the English author name |
| inline marks | ntua-thesis.cls:324-326, 392, 411 | `mark.kernel` | `\textsc` `\textbf` `\textit` `\tt` (`\src`, :1766) |
| colour | ntua-thesis.cls:1631-1632; main.tex:191-205 | `color.xcolor` | `\definecolor{ntua_red}{RGB}{190,65,65}`, `{lightgray}{RGB}{233,233,233}`; user colours `gray!50!brown`, `brown!60!orange`, `blue`, `white`, `gray!60!brown`; derived `\colouredtextcolor`=`<chapter>!70!black` (:247); xcolor arrives through tikz (:1238) |
| language | ntua-thesis.cls:34, 1774-1776, 609-611 | `lang.babel` | `[greek,english]`; `\selectlanguage{greek}`; `\addto\captionsgreek` renames the illustration list; `\foreignlanguage` via `\en` (:41), `\textlatin` via `\tl` (:38) |
| hyperlinks | ntua-thesis.cls:725-728, 766-773 | `meta.hyperref` | `[unicode]`; `colorlinks=true`, link/url/cite colour = `\@thesisurlcolor`, `pdfencoding=auto`, `pdfauthor`, `pdftitle`, `pdfcreator` |
| bookmarks | ntua-thesis.cls:727-728 | `meta.bookmark` | `\bookmarksetup{startatroot}` |
| urls | ntua-thesis.cls:48 | `meta.url` | `[hyphens]` |
| anchors at floats | ntua-thesis.cls:773 | `xref.hypcap` | `[all]` |
| cross-references | body_matter/chap4.tex:25,28; body_matter/chap8.tex:23,26 | `xref.kernel` | `\label`, `\ref` |
| cover page | ntua-thesis.cls:307-407, 441-493 | `front.titlepage-env` | `titlepage` with institution/department/division (`\Large\textsc`, `\large\textsc`), title in `\huge\textbf` scaled, subtitle `\Large\textit` + 3cm rule, "Diplomatiki Ergasia", author lines, cover image `\includegraphics[scale=0.8]{figures/rdf.png}` (main.tex:237), supervisor in `tabbing`, place/date, 1.5pt rule; `plain` branch only (the TikZ branch is ART, see Blockers) |
| logo block | ntua-thesis.cls:316-330 | `fig.graphicx` | `newlogo`+`plain`: `tabular{ll}` of `\includegraphics[width=2.5cm]{logo/pyrforos}` and a `minipage[c]{15cm}` (EPS, see `fig.epstopdf`) |
| title back page | ntua-thesis.cls:495-553, 796-830 | `front.titlepage-env` | `minipage` with logo and names (:798-819), centred title/subtitle, `tabular{ccc}` signature block with `\dotfill` (:822-830) |
| copyright page | ntua-thesis.cls:556-576, 930-958 | `front.dedication` | three `minipage`s (upper, middle, lower back); copyright text, plagiarism declaration (:832-873), signatures table (:883-928, BESPOKE) |
| dedication | ntua-thesis.cls:1174-1185; main.tex:257 | `front.dedication` | `\thesisDedication`: empty page, `flushright` italic text |
| acknowledgements | ntua-thesis.cls:1129-1138; front_matter/acknowledgements.tex:8-17 | `front.dedication` | `\chapter*` + `\addcontentsline{toc}{chapter}` + signatures (:1084-1128, BESPOKE); starred form omits signatures |
| preface | ntua-thesis.cls:1139-1143; front_matter/preface.tex:1-3 | `front.dedication` | `\chapter*`, `\addcontentsline` |
| abstract (Greek, English) | ntua-thesis.cls:1144-1154; front_matter/abstract.tex:1,36 | `abs.kernel` | `abstract` and `abstracteng` redefined as `\chapter*{\abstractname}` + `\addcontentsline` (`\chapter*` from `head.kernel`, `\addcontentsline` from `toc.kernel`); ends with `\par\vfil\null\endtitlepage` |
| keywords | ntua-thesis.cls:1074-1075; front_matter/abstract.tex:28,59 | `abs.keywords` | `keywords` env = `\section*{\color{..}\keywordsname}` |
| contents lists | main.tex:261-267 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listofillustrations`, `\listoftables` |
| list-of entry layout | ntua-thesis.cls:1718-1722 | `toc.tocloft` | `\l@figure`, `\l@table`, `\l@illustration` = `\@dottedtocline{1}{1em}{3.2em}`; as tocloft `\cftfigindent=1em`, `\cftfignumwidth=3.2em` |
| toc spacing | ntua-thesis.cls:970, 1169 | `toc.kernel` | `\addtocontents{toc}{\protect\addvspace{1em}}`, `{\bigskip}` |
| chapter headings (plain) | ntua-thesis.cls:1452-1487 | `head.titlesec` | `titlesec[explicit]`; `\titleformat{\chapter}[display]`, format `\bfseries\color{..}`, label = chapter name plus `\colorbox` number, then `\huge\textscale{0.93}{#1}`, sep 0pt, before-code `\vspace{-10pt}\rule{\textwidth}{1pt}`; numberless variant; `\titlespacing{\chapter}{0pt}{35pt}{20pt}` and `{35pt}{10pt}` |
| part headings (plain) | ntua-thesis.cls:1525-1558 | `head.titlesec` | same pattern for `\part` and `\part*` |
| chapter and part headings, default branch | ntua-thesis.cls:1489-1517, 1560-1606 | `art.tikz` (ART) | TikZ page banners, see Blockers |
| sections | body_matter/intro.tex:65,110; body_matter/chap2.tex:7-8; body_matter/chap4.tex:36 | `head.kernel` | `\section`, `\subsection`, `\subsubsection` unchanged from `book` |
| parts in body | main.tex:279, 282, 288 | `head.titlesec` | `\part{Θεωρητικό Μέρος}` etc. |
| appendices | ntua-thesis.cls:1610-1628; main.tex:291 | `num.appendix` | `\part*{Παραρτήματα}`, `\appendix`, switches to the appendix colour |
| counters | ntua-thesis.cls:1189, 1653-1658, 1196 | `num.counters` | `\@addtoreset{algorithm}{chapter}`; `\thetheorem` etc. = `\arabic{chapter}.\arabic{..}`; `\thealgorithm` |
| theorems | ntua-thesis.cls:1644-1652, 687, 690-691 | `thm.amsthm` | `\newtheorem{definition}{Ορισμός}` and 8 more Greek names (not used in the sample body) |
| maths | ntua-thesis.cls:687, 690-692; body_matter/chap8.tex:21-24 | `math.amsmath` | `amsmath`; `equation` with label; inline and `\displaystyle` formulas (chap8.tex:11-14) |
| maths symbols | ntua-thesis.cls:687, 692, 1639 | `math.amssymb` | `amssymb`; `latexsym` same type (package as parameter) |
| equation tag colour | ntua-thesis.cls:253-264 | BESPOKE | see Bespoke (no way) |
| figures | body_matter/chap4.tex:22-26; back_matter/appB.tex:24-26 | `fig.graphicx` | `figure[!ht]`, `\centering`, `\includegraphics{figures/peerArchitecture.eps}`, `{figures/2.png}`; caption below, `\label` |
| EPS under pdfTeX | ntua-thesis.cls:1636 | `fig.epstopdf` | `\usepackage{epstopdf}` no options; EXTERNAL (Ghostscript) |
| illustration float | ntua-thesis.cls:602-611, 1702-1714; back_matter/appE.tex:4-9 | `fig.newfloat` | `\DeclareFloatingEnvironment[fileext=loi,name=Eik'ona,placement=tbhp,within=chapter]{illustration}`; wrapper env `Illustration` adds `\capstart` under hyperref |
| float styles | ntua-thesis.cls:1193-1194, 1218-1219 | `fig.float` | `float`; `\floatname{algorithm}{..}`; `\floatstyle{coloruled}` + `\restylefloat{algorithm}` (style code BESPOKE) |
| captions | ntua-thesis.cls:1664-1668 | `cap.caption` | `\captionsetup[figure]`, `[table]`, `[illustration]`, `[algorithm]` each `{labelfont={color=<text colour>},textfont={it}}` |
| caption command | body_matter/chap7.tex:45; body_matter/chap4.tex:24 | `cap.kernel` | `\caption` |
| tables | body_matter/chap7.tex:43-63; back_matter/appC.tex:3-31 | `tbl.tabular` | `table[!tb]`, `tabular` with four centred columns and vertical rules, `\hline`, `\small`, `\arraystretch`=1.3; `array` loaded (ntua-thesis.cls:46) |
| tabbing blocks | back_matter/abbreviations.tex:1-9; back_matter/glossary.tex:1-23; body_matter/chap2.tex:19-33 | `tbl.tabbing` | `tabbing` with a `\kill` row of `a` strings; `\abbrevGR`, `\abbrevEN`, `\gloss` are `\newcommand` rows `#1 \> #2\\` (ntua-thesis.cls:1671-1672, 1683) |
| lists | body_matter/chap4.tex:16-20; body_matter/intro.tex:70-88 | `list.kernel` | `itemize`, `enumerate` |
| algorithms | ntua-thesis.cls:1191, 1197-1210; body_matter/chap8.tex:60-75 | `alg.algorithmicx` | `algorithm`, `algorithmicx`, `algpseudocode`; `\algorithmicrequire`..`\algorithmicreturn` renewed to Greek or bold Latin words; `\Require \Ensure \State \While` |
| code | ntua-thesis.cls:1222-1223; body_matter/chap8.tex:83-104 | `code.listings` | `listings`, `\lstset{extendedchars}`, `\lstset{language=C}`; Greek letter patch is BESPOKE |
| verbatim | ntua-thesis.cls:1638 | `code.verbatim` | `verbatim` package, load only |
| bibliography | ntua-thesis.cls:1640, 1160-1171; main.tex:298; ntua.bst:2 | `bib.bibtex-bst` | `\bibliographystyle{ntua}` (zip-local `.bst` modified from hellas.bst; the style is the parameter); `\bibliography{references}` wrapped with `\cleardoublepage`, `\addtocontents{toc}{\bigskip}`, `\addcontentsline{toc}{chapter}{Βιβλιογραφία}` |
| citations | body_matter/intro.tex:13,72,82 | `bib.bibtex-bst` | `\cite{key}`, numeric labels from `\bibitem` (ntua.bst:85-90, 1524) |
| index (disabled by `noindex`) | ntua-thesis.cls:694-724; back_matter/appD.tex:5-8 | `idx.makeidx` | `imakeidx`; `\makeindex[name=greek,..]` and `[name=english,..]` with `title=..,intoc,columnseprule`; `\indexGR`, `\indexEN` = `\index[..]{..}` |
| file inclusion | main.tex:255-302 | `struct.input` | `\include{front_matter/abstract}` ... `\include{back_matter/appE}`; `\input` inside `\includeabbreviations` (ntua-thesis.cls:1678) |
| abbreviations, glossary chapters | ntua-thesis.cls:1673-1699; main.tex:300-302 | `head.kernel` | `\chapter*` + `\addcontentsline` + `\markboth` + `\input` (with `toc.kernel`, `struct.input`, `pg.break`) |
| minipage boxes | ntua-thesis.cls:499-501, 561-575, 798-819; 1093 | `box.minipage` | `minipage` and `varwidth` (shrink-to-fit minipage; package as parameter) |
| CD label, CD cover | ntua-thesis.cls:1239-1250 (plain: no-ops), 1252-1434 | `art.tikz` (ART) | see Blockers; main.tex:312-319 |
| watermark (non-plain) | ntua-thesis.cls:782-790 | `bg.background` | `\backgroundsetup{contents={\selectlanguage{greek}Diplwmatik'h Ergas'ia},angle=90,vshift=2.6cm,scale=3.4,color=gray}`; loaded only when `watermark` is on and `plain` is off, so inactive in the sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option switches `\newif`, `\DeclareOption` x9 | ntua-thesis.cls:613-656 | yes | resolved at emit time; the emitter writes the branch the options select |
| colour defaulting and derived colours (`\preprocess`) | ntua-thesis.cls:169-251 | yes | `\colorlet`/`\definecolor` values written out (`color.xcolor`) |
| data setters `\def\@x{}` `\def\x#1{\gdef\@x{#1}}` | ntua-thesis.cls:54-132 | yes | content slots of the cover, filled by the emitter |
| `\title[cover]{..}` override, `\compileauthors`, `\formatauthorstring*` | ntua-thesis.cls:270-306 | yes | the emitter prints two title strings and an author string with `\break` (`front.titlepage-env`); PDF title as a plain `pdftitle` string (`meta.hyperref`) |
| `\title` PDF-title stripper (`\StrDel`, language commands nulled) | ntua-thesis.cls:732-760 | yes | `pdftitle={..}` given as plain text, or `\texorpdfstring` (`meta.hyperref`) |
| `\maketitle` (plain branch) | ntua-thesis.cls:307-586 | yes for the selected branch | `titlepage` laid out with `sp.manual-space`, `sp.rule`, `tbl.tabbing`, `box.minipage`, `fig.graphicx`, `mark.kernel`; the non-plain branch is ART |
| `\approval`, `\middletitleback`, `\declaration*`, `\signature` | ntua-thesis.cls:822-881, 930-958 | yes | strings in `tabular`, `minipage`, `\dotfill` (`tbl.tabular`, `sp.rule`); the only logic is the single/multi author text choice (`\IfSubStr`), chosen by the emitter |
| `\signaturestable`, `\extractname`, `\acksignatures` | ntua-thesis.cls:883-928, 1084-1128 | no | width computed in TeX from a name count (`calculator`, `xstring`, `\foreach`); kept as BESPOKE/class because the layout is driven by computed counters |
| `\tagform@` redefinition | ntua-thesis.cls:253-264 | no | amsmath internal; no lib way colours or boxes the equation tag |
| float style `coloruled` | ntua-thesis.cls:1212-1219 | no | extends `float` by redefining its `\@fs@*` hooks (W2 fails) |
| listings `\lst@DefEC` patch | ntua-thesis.cls:1224-1232 | no | internal macro patch of `listings` (W2 fails) |
| `\footacknowledgement` | ntua-thesis.cls:1076-1083 | no | swaps kernel `\@makefntext`; unused by the sample |
| `\cleardoublepage`, `\myemptypage`, `\frontmatter`, `\mainmatter`, `\backmatter` | ntua-thesis.cls:962-994 | yes | `pg.emptypage`, `pg.break`, `pgnum.pagenumbering`, `\addtocontents` |
| `\chaptermark`, `\sectionmark` | ntua-thesis.cls:996-1002 | yes | `\markboth`/`\markright` text under `hf.fancyhdr` |
| `\bibliography` wrapper | ntua-thesis.cls:1160-1171 | yes | `pg.break`, `bib.bibtex-bst`, `toc.kernel` lines |
| environments `abstract`, `abstracteng`, `keywords`, `acknowledgements`, `preface` | ntua-thesis.cls:1074-1075, 1129-1154 | yes | `\chapter*` + `\addcontentsline` (+ `\@mkboth`), `abs.keywords` |
| `Illustration` wrapper, `\l@figure` etc. | ntua-thesis.cls:1702-1722 | yes | `fig.newfloat`, `toc.tocloft` values |
| `\beginfrontmatter`, `\beginmainmatter` | ntua-thesis.cls:1725-1738 | yes | option-dependent choice of `\mainmatter`/`\frontmatter`, resolved at emit time |
| `\InitialCharacter` | ntua-thesis.cls:1741-1759 | yes | `sp.lettrine` or plain text |
| `\includeabbreviations`, `\includeglossary`, `\gloss`, `\abbrev*` | ntua-thesis.cls:1671-1699 | yes | see map; one `\kill` `tabbing` row set |
| `\printindices`, `\indexEN`, `\indexGR` | ntua-thesis.cls:695-723 | yes | `idx.makeidx` (no-ops under `noindex`) |
| `\appendices` | ntua-thesis.cls:1610-1628 | yes | `num.appendix` with colour switch |
| `\tl` `\tg` `\en` `\src` `\bkslash` `\set` `\To` `\xml` | ntua-thesis.cls:38-41, 1659-1661, 1766-1769 | yes | `\newcommand` aliases of `lang.babel` and `mark.kernel` |
| `\@addtoreset`, theorem number renewals | ntua-thesis.cls:1189, 1653-1658 | yes | `num.counters` |
| `ntua.bst` | ntua.bst:1-1538 | yes (as the lib reads it) | `bib.bibtex-bst`: the `.bst` is the parameter; extra entry fields `foreign-author`, `original-title`, `translator` (ntua.bst:14-30), Greek month macros (ntua.bst:1302-1324); entry-type functions 130-1340 not read |
| `\AtEndPreamble{\preprocess\compileauthors\setpdfproperties}` | ntua-thesis.cls:1773-1774 | yes | resolved at emit time into the preamble values |

## Content-opaque
- Figure artwork: `figures/peerArchitecture.eps` (body_matter/chap4.tex:23), `figures/2.png` (back_matter/appB.tex:25), `figures/frog.jpg` (back_matter/appE.tex:6), cover image `figures/rdf.png` (main.tex:237)
- XML snippet in a `tabbing` block (body_matter/chap2.tex:19-33), C code in `lstlisting` (body_matter/chap8.tex:84-104), pseudo-code in `algorithmic` (body_matter/chap8.tex:63-74), display formulas (body_matter/chap8.tex:11-24)
- Commented-out TikZ example for `\coverpageimage[tikz]` (main.tex:226-235) is a comment, not used

## Lib changes
- New ways proposed: none. Considered: `relsize` (mapped to `font.size-commands`, same type of effect with the package as parameter), `varwidth` (mapped to `box.minipage`), `latexsym` (mapped to `math.amssymb`), `calculator` and `xstring` (support packages of the BESPOKE code, no component of their own).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
