yes

# 0514-udesoftec: udesoftec (thesis class and bibliography style, University of Duisburg-Essen, SOFTEC chair)

- Unverified: read from the source, not compiled.
- Source: Source/0514-udesoftec/ (origin: https://mirrors.ctan.org/macros/latex/contrib/udesoftec.zip; licence: lppl1.3)
- Kind: thesis (the class is a thesis class; the sample is its manual, written as a short German document on the class)
- Lib: v5
- Engine: pdfLaTeX-compatible (class built for pdfLaTeX + BibTeX: `[pdftex]` driver options udesoftec.cls:551 and :1057, `\pdfminorversion=6` udesoftec.cls:68)
- Look carried by: class (udesoftec.cls and the `udesoftec-*.sty` files it loads; the sample adds only option settings, title-page field commands and content)
- Class origin: ctan
- Main file: udesoftec-doc.tex (other samples: none; the manual's own listings repeat a 4-line MWE, udesoftec-doc.tex:94-99)
- Read: main yes, zip-local classes and styles all (udesoftec.cls, -bibcommon.sty, -biblatex.sty, -bst.sty, -extra.sty read in full apart from their identical licence headers; udesoftec.bst, 1536 lines, outline only: it is a BibTeX style, the parameter of `bib.bibtex-bst`)

## Verdict
yes. The zip is the CTAN release of the `udesoftec` class (LPPL, the same package that TeX Live ships), so `class.udesoftec` is a published class way: its look is chosen by class options and by title-page field commands (udesoftec.cls:163-259). The sample loads it with options `de,omit-sd,omit-lol` (udesoftec-doc.tex:5) and adds only field commands, class vocabulary and content; its own preamble macros are an unused tikz macro, a text alias and a class hook holding two babel calls, all reducible. Every package the class loads maps to an existing lib way and no tool beyond `bibtex` and `makeindex` is needed. The class draws its chapter heading, header page-number tab and quote glyph with `picture` and tikz; under a reading in which that class source counted as bespoke code, these would be `ART/class` and the list-of-X logic `BESPOKE/class` (listed under "Bespoke code" so the result can be re-read); the verdict rests on the class being published, which `hf.class-native` and `head.class-native` exist for.

## Blockers
none

## Class setting
- Class: `class.udesoftec` options: `de`, `omit-sd`, `omit-lol` (udesoftec-doc.tex:5). Others the class accepts: `en`, `bibtex`, `biber`, `final`, `draft`, `proposal`, `mwe`, `printlayout`, `screenlayout` (default), `confidential`, `long-a`, `omit-a`, `omit-aen`, `omit-lot`, `omit-lof`, `omit-loa`, `omit-toc`, `omit-todos`, `vawiessen`, `vawibamberg` (udesoftec.cls:163-239; described udesoftec-doc.tex:109-125). Defaults udesoftec.cls:131-156.
- Base class loaded inside it: `class.scrbook` (udesoftec.cls:45), KOMA options twoside, headings=openright, numbers=noenddot, bibliography/index/listof=totoc, headlines=1.5 (udesoftec.cls:46-54).
- Class-native vocabulary used: title-page fields `\typeofdoc` `\title` `\subtitle` `\author` `\entitle` `\city` `\labelPreTopic` `\institution` `\semester` `\authorbox` `\date` (udesoftec-doc.tex:26-42; defined udesoftec.cls:249-259); `\abstract{}` and `\abstractEn{}` as one-argument commands, not the environment (udesoftec-doc.tex:44,61; udesoftec.cls:260-261); hook `\udesoftecoverride` (udesoftec-doc.tex:69; udesoftec.cls:92); `\citequotepar` `\citequote` `\citemulti` (udesoftec-doc.tex:193,201,230; udesoftec.cls:956, udesoftec-bibcommon.sty:229,247); `\parExample` (udesoftec-doc.tex:201; udesoftec.cls:985); `\todo` `\inlinetodo` (udesoftec-doc.tex:395; udesoftec.cls:1025,1041); `\acr` `\acrshort` (udesoftec-doc.tex:331; udesoftec.cls:1228); `lstlistinglatex` `lstlistingbibtex` `\lstinlinelatex` (udesoftec.cls:1168,1193,1204); `\chapterAuthor` hook string (udesoftec-doc.tex:458; udesoftec.cls:752). The class prints title page, abstract, contents and the lists itself in `\AfterEndPreamble` (udesoftec.cls:1236-1255), so the body holds no `\maketitle` or `\tableofcontents`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | udesoftec-doc.tex:5; udesoftec.cls:42 | `class.udesoftec` | options de, omit-sd, omit-lol; a published class, a word-for-word reload needs only the class and its cover PDFs |
| base class | udesoftec.cls:45 | `class.scrbook` | `\LoadClass{scrbook}` inside the class |
| two-sided switch | udesoftec.cls:46,856,859 | `page.class-options` | twoside=true by default, false in screenlayout, true in printlayout |
| heading options | udesoftec.cls:48-49 | `head.class-native` | headings=openright, numbers=noenddot |
| lists in contents | udesoftec.cls:50-52 | `toc.koma` | bibliography=totoc, index=totoc, listof=totoc |
| header height | udesoftec.cls:53 | `hf.class-native` | headlines=1.5 |
| page geometry | udesoftec.cls:854,615,654 | `page.geometry` | includehead=false, includefoot=false; title page `\newgeometry{bottom=1cm,inner=0cm,outer=0cm,top=4cm}` then `\restoregeometry` |
| type area | udesoftec.cls:857,860 | `page.typearea` | BCOR=12mm,DIV=10 (printlayout); BCOR=0mm,DIV=10 (default) |
| text face | udesoftec.cls:318 | `font.libertine` | `\usepackage{libertine}` |
| encodings | udesoftec.cls:321,355 | `font.fontenc-t1` | fontenc T1, inputenc utf8 |
| default family | udesoftec.cls:323-327 | `font.family-default` | `\familydefault` = `\sfdefault` (screenlayout, default), `\rmdefault` (printlayout) |
| face by name | udesoftec.cls:320,925 | `font.nfss` | `\fontfamily{LinuxLibertineT-TLF}`, quote font `LinuxLibertineT-LF` |
| microtype | udesoftec.cls:337 | `sp.microtype` | defaults |
| size commands | udesoftec.cls:331,747,929 | `font.size-commands` | `\fontsize{19\unitlength}{23\unitlength}\selectfont`, size 60 quote glyph, `\scriptsize` |
| heading and caption fonts | udesoftec.cls:328-331,721-723 | `head.koma-fonts` | `\setkomafont` descriptionlabel, dictumtext, disposition (`\normalfont\normalcolor\bfseries`); `\addtokomafont` chapter, sectioning, subsubsection colour |
| caption font | udesoftec.cls:331; udesoftec-doc.tex:295-296 | `cap.koma` | `\setkomafont{caption}{\normalfont\normalcolor\scriptsize}` |
| captions | udesoftec-doc.tex:295 | `cap.kernel` | `\caption[short]{long}` then `\label` |
| colours | udesoftec.cls:364-440,442-454 | `color.xcolor` | svgnames; `\definecolor{UDEblue}{RGB/cmyk}{0,76,147/1,.68,0,.12}` and others; `\colorlet` roles; link colours depend on layout |
| language | udesoftec.cls:341-345,355-356,456-457,494-495; udesoftec-doc.tex:70-72 | `lang.babel` | `[british,ngerman]` (de) or `[ngerman,british]` (en); `\providecaptionname` `\newcaptionname` and, in the sample, `\renewcaptionname` |
| quotation marks | udesoftec.cls:357,958 | `lang.csquotes` | autostyle, english=british, german=quotes; `\enquote` |
| hyphenation | udesoftec.cls:358,958 | `sp.hyphenat` | `hyphenat` (`\nohyphens`), `\sloppy` |
| keyword translations | udesoftec.cls:1090-1091 | `lang.translator` | `\deftranslation[to=ngerman]{Acronyms}{Abkürzungsverzeichnis}`, `{Glossary}{Glossar}` |
| title page | udesoftec-doc.tex:26-42; udesoftec.cls:614-717 | `front.class-native` | fields above; `\maketitle` replaced by `\udesoftecmaketitle` (VAWi Bamberg variant :657-702) |
| title page body | udesoftec.cls:616-653 | `front.titlepage-env` | `titlepage` with `center`, `\vfill`, `\vspace*`; minipages of `.7\linewidth` |
| title page cover | udesoftec.cls:613,618,590-596 | `bg.background` | `wallpaper` `\ThisCenterWallPaper{1}{udesoftec-cover-ude-de}`; cover PDFs shipped in the zip |
| title page boxes | udesoftec.cls:620,635,646 | `box.minipage` | `\begin{minipage}{.7\linewidth}` |
| author block | udesoftec-doc.tex:35-41 | `tbl.tabularx` | `\authorbox{\begin{tabularx}{.7\linewidth}{ll}...}` |
| abstract | udesoftec-doc.tex:44-66; udesoftec.cls:469-492 | `abs.class-native` | `\abstract`, `\abstractEn`; `\chapter*{\labelabstracttitle}`, second abstract on the same page unless `long-a` |
| declaration pages | udesoftec.cls:494-536,1260-1262; udesoftec-doc.tex:5 | `front.dedication` | confidentiality clause (option `confidential`, off by default :145), statutory declaration at end (removed here by `omit-sd`) |
| page assembly | udesoftec.cls:1236-1255,1086-1088 | `front.class-native` | order title, clause, abstract, contents, lists, acronyms, `\mainmatter`; glossary and declaration at `\AtEndDocument` |
| contents | udesoftec.cls:1245-1248 | `toc.kernel` | `\tableofcontents` unless `omit-toc` |
| lists of floats | udesoftec.cls:1212-1225 | `front.class-native` | printed only when a label written at the end of the previous run exists |
| numbering depths | udesoftec.cls:729-730 | `num.secnumdepth` | secnumdepth=3, tocdepth=3 |
| chapter heading | udesoftec.cls:738-763,863; udesoftec-doc.tex:458 | `head.class-native` | big chapter number, rule and small label over the title; `\chapterAuthor` replaces the label |
| unnumbered level | udesoftec.cls:725-727 | `head.kernel` | `\unnumberedsection` = `\subparagraph` |
| sectioning | udesoftec-doc.tex:81,83,183 | `head.kernel` | `\chapter` `\section` `\subsection` with `\label` |
| appendix | udesoftec-doc.tex:453 | `num.appendix` | `\appendix` |
| counters | udesoftec.cls:541-542,894-901 | `num.counters` | `chngcntr` `\counterwithout{footnote}{chapter}` |
| running heads | udesoftec.cls:777-828 | `hf.scrlayer-scrpage` | `\pagestyle{scrheadings}`, `\clearpairofpagestyles`, `\ihead` `\ohead` `\lehead` `\rohead`, `\automark`, `\defpagestyle{chapter}`, `\KOMAoption{headsepline}{.4pt}`, `\titlepagestyle`=empty, `\chapterpagestyle`=chapter |
| page-number tab | udesoftec.cls:772-773,832-842 | `hf.class-native` | blue box with white bold page number, drawn inside the class; colours `PagemarkBackground` `PagemarkText` |
| page numbering | udesoftec.cls:1238,1242,1254 | `pgnum.pagenumbering` | alph for title, Roman for front matter, `\mainmatter` |
| footnotes | udesoftec.cls:558 | `fn.footmisc` | `[marginal]` (sample has no footnote) |
| float placement | udesoftec.cls:564 | `fig.placement` | `placeins` `[section]` |
| figure | udesoftec-doc.tex:292-298; udesoftec.cls:551-552 | `fig.graphicx` | `graphicx[pdftex]`, `\graphicspath{{Images/pdf/}}`, `\includegraphics[width=.95\linewidth,keepaspectratio=true]` in `\centering` |
| tables | udesoftec.cls:574; udesoftec-doc.tex:415-420 | `tbl.tabularx` | `tabularx{\linewidth}{ll}` |
| ragged text | udesoftec.cls:574; udesoftec-bst.sty:69 | `sp.ragged` | `ragged2e`; `\bibfont`=`\raggedright` |
| lists | udesoftec-doc.tex:86,339,354 | `list.kernel` | `itemize` `enumerate` |
| list options | udesoftec.cls:581; udesoftec-doc.tex:109,369,383 | `list.enumitem` | `description[leftmargin=2.75cm,style=sameline]`, `[style=nextline]` |
| columns | udesoftec.cls:584; udesoftec-doc.tex:132,147 | `cols.multicol` | `multicols{4}`, `{3}` |
| margin notes | udesoftec.cls:872-879 | `note.marginnote` | `\marginfont`=`\scriptsize` |
| to-do notes | udesoftec.cls:1001-1052; udesoftec-doc.tex:395 | `note.todonotes` | ngerman, textsize=tiny, backgroundcolor=DocumentBright1, bordercolor=DocumentMedium1, linecolor=DocumentBright1, colorinlistoftodos; `\todo`, `\inlinetodo` |
| block quote with source | udesoftec.cls:942-967; udesoftec-doc.tex:193 | `box.mdframed` | `mdfsetup` innerleftmargin=6ex, innerrightmargin=2ex, backgroundcolor=DocumentBright2, linecolor=DocumentMedium2, linewidth=.5pt, nobreak=true; glyph: see Bespoke code |
| example box | udesoftec.cls:968-999; udesoftec-doc.tex:201,278 | `box.mdframed` | linecolor=DocumentMedium1, backgroundcolor=DocumentBright1, linewidth=.5pt, topline=true, frame title node |
| inline quote | udesoftec-bibcommon.sty:247; udesoftec-doc.tex:201 | `lang.csquotes` | `\citequote` = `\enquote{text} \citep[page]{key}` |
| code listings | udesoftec.cls:1131-1211; udesoftec-doc.tex:94,242,320,470,527 | `code.listings` | `\lstset` frame=single, basicstyle, breaklines, backgroundcolor, rulecolor, keywordstyle, stringstyle, commentstyle, framesep, rulesep=0ex, numberbychapter, captionpos=b, umlaut `literate`; `\lstnewenvironment` x2, `\lstdefinelanguage{BibTeX}`, `\lstinputlisting` |
| acronyms | udesoftec.cls:1089-1109,1228-1234; udesoftec-doc.tex:76-79,331 | `idx.glossaries` | `[acronym,nonumberlist,section=chapter,toc,nowarn]`, `\GlsSetQuote{+}`, `\makeglossaries`, `\newglossarystyle{myAcronymStyle}`, `\newacronym`, `\newglossaryentry`, `\gls` |
| cross-references | udesoftec-doc.tex:30,50,115,290; udesoftec.cls:1071-1072,1112 | `xref.hyperref` | `\autoref`, `\hyperref[..]{..}`, `\figref`; `\subsectionautorefname` set to the section name |
| link options | udesoftec.cls:1057-1065 | `meta.hyperref` | pdftex, colorlinks, link/anchor/cite/file/url colours, hyperindex, linktoc=section, pdfstartview=FitV, pdfpagelabels, bookmarks options |
| bookmarks | udesoftec.cls:1066-1070 | `meta.bookmark` | open, openlevel=1, numbered=true |
| float anchors | udesoftec.cls:1081 | `xref.hypcap` | `[all]` |
| URL and DOI links | udesoftec-bibcommon.sty:65,184-187 | `meta.url` | `uri[doipre={doi:}]` (CTAN page read: hyperlinks for URIs, LPPL 1.3c, in TeX Live; `\doi` is cited as coming from it but the CTAN page does not list it) |
| citations | udesoftec-bst.sty:59,62-63; udesoftec-doc.tex:210,217,221,230,279 | `bib.natbib` | `natbib[elide]`, `\bibpunct[,~\bblInTextPagePrefix{}]{(}{)}{;}{a}{}{}{}`; `\cite[p]{k}` `\citet` `\citeauthor` `\citetext`; `\citemulti` swaps the `\bibpunct` setting |
| bibliography | udesoftec-bst.sty:60; udesoftec-doc.tex:529; udesoftec.bst:29,1047 | `bib.bibtex-bst` | `\bibliographystyle{udesoftec}`, `\bibliography{udesoftec-doc-examplebib}`; the style adds entry type `techstandard` |
| bibliography lengths | udesoftec-bst.sty:67-68 | `sp.lengths` | `\bibhang`=1.5em, `\itemsep`=.25em |
| bibliography dates | udesoftec-bibcommon.sty:189-192,197-204 | `front.datetime` | `datetime2[useregional=text]`, `\DTMsetstyle{ddmmyyyy}`, `\DTMdate` |
| biblatex path | udesoftec-biblatex.sty:60-73,339-341; udesoftec.cls:1123-1126 | `bib.biblatex-biber` | only with option `biber`, not used by the sample: backend=biber, style=authoryear, natbib=true, sorting=nyt, maxcitenames=2, giveninits, urldate=long, maxbibnames=99; `\defbibheading{udesoftec}` |
| manual spacing | udesoftec.cls:619,630 | `sp.manual-space` | `\vspace*{30pt}`, `\vspace*{50pt}` etc. |
| rules | udesoftec.cls:671,837 | `sp.rule` | `\hrule`, `\rule` |
| inline marks | udesoftec-doc.tex:276,413,416-419 | `mark.kernel` | `\textbf`, `\emph`, `\textsf`, `\textrm` |
| page breaks | udesoftec-doc.tex:105,128,524; udesoftec.cls:502 | `pg.break` | `\pagebreak`, `\clearpage`, `\cleardoublepage` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\keystroke` tikz key-cap macro, plus `\usetikzlibrary{shadows}` | udesoftec-doc.tex:8-21 | yes (no effect) | defined once and never called (Grep finds no other use); drop both, or keep as inline `art.tikz` content if a later edit calls it; not template identity. BESPOKE/preamble if it were called |
| `\newcommand{\BibTeX}{BibTeX}` | udesoftec-doc.tex:23 | yes | alias; expand to the plain word BibTeX |
| `\renewcommand{\udesoftecoverride}{...}` | udesoftec-doc.tex:69-73 | yes | hook run at udesoftec.cls:1237; its body is two `\renewcaptionname` calls: `lang.babel` caption overrides |
| `\def\chapterAuthor{ }` | udesoftec-doc.tex:458 | yes | string for the class's chapter-label slot (udesoftec.cls:752-756): a parameter of `head.class-native` |
| `udesoftec-extra.sty` | udesoftec-extra.sty:43; udesoftec-doc.tex:6 | yes | empty file ("everything from 1.4.x is merged into main files"), part of the published bundle |
| class-internal: chapter heading by `picture` | udesoftec.cls:739-763 | published class | `head.class-native`; would be `ART/class` if the class were zip-local |
| class-internal: header page-number tab by `picture` and `\rule` | udesoftec.cls:832-842 | published class | `hf.class-native`; would be `ART/class` if zip-local |
| class-internal: open-quote glyph as tikz node, tikz frame title node | udesoftec.cls:929-931,971-973 | published class | part of `citequotepar` and `exampleBox`; would be `ART/class` if zip-local |
| class-internal: list-of-X conditional on a label from the previous run | udesoftec.cls:1212-1234 | published class | `front.class-native`; would be `BESPOKE/class` if zip-local |
| class-internal: front and back matter assembled in `\AfterEndPreamble` and `\AtEndDocument` | udesoftec.cls:1086-1088,1124-1126,1236-1262 | published class | `front.class-native`; the emitter must not add `\maketitle` or `\tableofcontents` |
| class-internal: `\chapterWithoutPageBreak` (redefines `\clearpage`) and footnote-in-minipage counters | udesoftec.cls:80-91,894-907 | published class | helpers of the abstract and `\parExample`; would be `BESPOKE/class` if zip-local |
| class-internal: version string by `xstring`, `\pdfminorversion=6`, `nag` | udesoftec.cls:58,64-68 | published class | no component: a printed version string in `\date`, a PDF version primitive, load-time warnings |
| udesoftec.bst, biblatex macros | udesoftec.bst:29-1536; udesoftec-biblatex.sty:183-622 | published style | style file as parameter of `bib.bibtex-bst`; the biblatex macros run only under option `biber` |

## Content-opaque
- tikz macro `\keystroke`, defined at udesoftec-doc.tex:9-21 and never called.
- included figure udesoftec-doc-exampleimage.pdf (udesoftec-doc.tex:294), the bibliography data (udesoftec-doc-examplebib.bib), listing text, acronym entries.
- missing asset: `\lstinputlisting{CHANGELOG.txt}` (udesoftec-doc.tex:527) but the zip ships the file as `CHANGELOG` without extension; ship it under the cited name.
- tools: `bibtex` after the first run and `makeindex` for the acronym list (udesoftec-doc.tex:431-433); both are standard TeX Live passes, like `bib.bibtex-bst` and `idx.glossaries`, with no shell escape.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
