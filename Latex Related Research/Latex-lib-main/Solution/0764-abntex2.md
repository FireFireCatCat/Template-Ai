yes

# 0764-abntex2: abnTeX2 (class abntex2, citation package abntex2cite, ABNT model documents)

- Unverified: read from the source, not compiled.
- Source: Source/0764-abntex2/ (origin: https://mirrors.ctan.org/macros/latex/contrib/abntex2.zip; licence: lppl1.3)
- Kind: thesis
- Lib: v6
- Engine: pdfLaTeX-compatible (only the book model has an optional XeLaTeX branch behind `\ifxetex`, L:44-67; the manifest hint "xelualatex" comes from it)
- Look carried by: class (tex/abntex2.cls, a CTAN class that is a set of memoir settings, defines the ABNT layout; the samples add package options, a few memoir settings and, in the book model, a page style and a chapter style)
- Class origin: ctan
- Main file: doc/examples/abntex2-modelo-trabalho-academico.tex (the canonical thesis model; the manifest names doc/abntex2.tex, an ltxdoc manual, which was also read in full; other samples: doc/examples/abntex2-modelo-{artigo,glossarios,livro,projeto-pesquisa,relatorio-tecnico,slides}.tex, doc/examples/abntex2-modelo-include-comandos.tex, doc/abntex2cite.tex, doc/abntex2cite-alf.tex)
- Read: main yes (thesis model and manifest main in full), zip-local classes and styles all (abntex2.cls, abntex2cite.sty, abntex2abrev.sty in full; `.bst` files and abntex2-options.bib only their headers; other samples: slides, include-comandos, livro, relatorio, glossarios in full or nearly, artigo 20-400 of 498, projeto-pesquisa 20-279 of 417, the two cite manuals preamble plus grep)
- Cited as (paths relative to Source/0764-abntex2/): K = tex/abntex2.cls, U = tex/abntex2cite.sty, V = tex/abntex2abrev.sty, B = tex/abntex2-alf.bst, T = doc/examples/abntex2-modelo-trabalho-academico.tex, I = doc/examples/abntex2-modelo-include-comandos.tex, A = doc/examples/abntex2-modelo-artigo.tex, G = doc/examples/abntex2-modelo-glossarios.tex, L = doc/examples/abntex2-modelo-livro.tex, R = doc/examples/abntex2-modelo-relatorio-tecnico.tex, P = doc/examples/abntex2-modelo-projeto-pesquisa.tex, S = doc/examples/abntex2-modelo-slides.tex, M = doc/abntex2.tex, C = doc/abntex2cite.tex, CA = doc/abntex2cite-alf.tex

## Verdict
The zip is the abnTeX2 bundle itself, taken from CTAN, so the class, the citation package and the BibTeX styles are published (W1) and the look is carried by `class.abntex2` (memoir-based). Every sample reduces to `\documentclass[opts]{abntex2}` (or `ltxdoc`, `beamer`), published packages with options, and the class's own vocabulary; the small zip-local items in the samples (aliases, a `verbatim` redefinition through `listings`, a memoir float, a LaTeX2HTML shim) are all reducible. No artwork defines the template and no tool outside the usual BibTeX/makeindex toolchain is needed. Judgment calls: (1) the internals of the published class and package (for example the sorting macros at U:1186-1299 and the TOC hooks at K:473-483) are not counted as bespoke because W1 holds; (2) `makeindex` and `makeglossaries` (G:341) are treated like BibTeX, as `bib.bibtex-bst` already does, not as EXTERNAL.

## Blockers
none

## Class setting
- Class: `class.abntex2` options: `12pt,openright,twoside,a4paper,english,french,spanish,brazil` (T:31-47; the last language is the main one), `article,11pt,oneside` (A:30-45), `a5paper,10pt,sumario=tradicional` (L:20-35), class-own `chapter=TITLE` `section=TITLE` `subsection=TITLE` `subsubsection=TITLE` `subsubsubsection=TITLE` (K:55-59) and `sumario=tradicional|abnt-6027-2012` (K:68-73), `twocolumn` (K:36-40); every other option goes to memoir (K:77-79). Base class: `class.memoir` (`\LoadClass{memoir}`, K:81).
- Class-native vocabulary used: data commands `\titulo \autor \data \local \instituicao \preambulo \orientador \coorientador \tipotrabalho \tituloestrangeiro` (K:694-740; T:97-113; A:96-108); `\imprimircapa`, `\imprimirfolhaderosto[*]` (K:1037-1123; T:206,213); environments `capa fichacatalografica errata folhadeaprovacao dedicatoria agradecimentos epigrafe resumo resumoumacoluna siglas simbolos citacao alineas subalineas incisos apendicesenv anexosenv` (K:750-868, 882-937, 976-997); `\pretextual \textual \postextual \phantompart \partapendices \partanexos \pretextualchapter \subsubsubsection \IBGEtab \fonte \nota \assinatura` and the hooks `\ABNTEXchapterfont \ABNTEXfontereduzida \ABNTEXcaptiondelim \ABNTEXcitacaorecuo` (K:233-259, 333-385, 551-557, 654-684, 942-957, 1016-1026); memoir commands the samples call (`\setlrmarginsandblock`, `\makepagestyle`, `\chapterstyle`, `\newfloat`, `\newlistof`, `\thelastpage`, `\legend`, `\chapterprecis`, `titlingpage`). Other classes in the samples: `class.ltxdoc` (M:20, C:21, CA:21), `class.beamer` (S:30).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | T:31-47; K:26,81 | `class.abntex2` | options above; the class loads `ifthen textcase hyperref bookmark babel[brazil] enumitem calc` (K:27,104,126,132,138,202,207) |
| base class | K:81; T:157-167 | `class.memoir` | all memoir options and commands pass through (K:77-79) |
| manual and slide classes | M:20; S:30 | `class.ltxdoc`, `class.beamer` | `a4paper`; `aspectratio=169` |
| paper and size | T:33-36; A:32-35; L:21-24 | `page.class-options` | 12pt openright twoside a4paper; article 11pt oneside; book 10pt a5paper |
| page geometry | K:213-215; A:145-147; L:183-185 | `page.memoir-layout` | `\setlrmarginsandblock{3cm}{2cm}{*}`, `\setulmarginsandblock{3cm}{2cm}{*}`, `\checkandfixthelayout`; article 3cm/3cm; book 2.5cm/3.5cm |
| columns | K:36-40,841-846; R:68; L:77 | `cols.twocolumn-option`, `cols.multicol` | `twocolumn` passed to memoir (citation indent 1.8cm, K:971-975); `onecolabstract` (`resumoumacoluna`); `multicol` loaded |
| page breaks | K:298,782,856; T:449 | `pg.break` | `\cleardoublepage`, `\clearpage` |
| running heads | K:642-650,655-658,673,675; L:160-175 | `hf.memoir-pagestyle` | `\makepagestyle{abntheadings}`, `\makeevenhead`/`\makeoddhead` with `\ABNTEXfontereduzida\thepage` and `\textit\leftmark`/`\rightmark`, `\makeheadrule{..}{\textwidth}{\normalrulethickness}`, `abntchapfirst`, `\aliaspagestyle{chapter}{..}`, `\nouppercaseheads`; the book model re-declares both styles (L:160-167) |
| page style switches | K:656,670,764; L:500 | `hf.pagestyle-kernel` | `\pagestyle{empty}`, `\pagestyle{plain}` (article), `\thispagestyle{empty}` |
| last page number | T:243 | `pgnum.lastpage` | memoir `\thelastpage` |
| line spacing | K:221,765,784,981; A:161 | `sp.setspace` | memoir `\OnehalfSpacing` default, `\SingleSpacing`, environments `SingleSpacing`, `Spacing{1.0}`, `SingleSpace` |
| paragraph and class lengths | T:175,178; K:310-311,970-975,1003-1010 | `sp.lengths` | `\parindent=1.3cm`, `\parskip=0.2cm`; `\footmarkwidth=1.2em`, `\ABNTEXcitacaorecuo=4cm`, `\ABNTEXsignwidth=8cm`, `\ABNTEXsignthickness=1pt`, `\ABNTEXsignskip=0.7cm`; `calc` (K:207) |
| first paragraph indent | T:55 | `sp.indentfirst` | load-only |
| microtype | T:58 | `sp.microtype` | load-only |
| space after period | T:196 | `sp.frenchspacing` | `\frenchspacing` |
| absolute line distance | L:82-83 | `sp.linespread` | `\usepackage{leading}`, `\leading{13pt}` (ctan.org/pkg/leading read: Will Robertson, LPPL 1.3c, an absolute baseline distance that replaces `\linespread`; same type, no new way) |
| drop capital | L:319 | `sp.lettrine` | `\lettrine[nindent=0.35em,lhang=0.40,loversize=0.3]{E}{ste documento}` |
| manual space and fill | T:233,311,317; K:1042,1076 | `sp.manual-space` | `\vspace*{\fill}`, `\hspace{.45\textwidth}`, `\vfill` |
| rules | K:1021 | `sp.rule` | `\rule{\ABNTEXsignwidth}{\ABNTEXsignthickness}` (signature line) |
| alignment | K:1039-1040; T:348; L:204-212 | `sp.ragged` | `\center`, `\centering`, `\raggedright`, `\raggedleft` |
| fonts (pdfLaTeX) | T:52-54; M:21-23 | `font.lmodern`, `font.fontenc-t1` | `lmodern`, `[T1]{fontenc}`, `[utf8]{inputenc}` |
| fonts, book model | L:61-66 | `font.newtx`, `font.serif-pkg`, `font.helvet`, `font.mono`, `font.mathastext`, `font.fontenc-t1` | `newtxmath`; `Alegreya`; `AlegreyaSans`; `[lf]{FiraMono}`; `[italic]{mathastext}`; `[utf8]{inputenc}` |
| fonts, book model, XeLaTeX branch | L:48-57 | `font.fontspec` | `mathspec` with `\setmathsfont(Digits,Latin,Greek){Minion Pro}`, `\setmathrm`, `\setmainfont[Numbers=OldStyle]`, `\setsansfont[Scale=0.9]{Myriad Pro}`, `\setmonofont[Scale=MatchLowercase]{Consolas}` (mathspec is a fontspec add-on, folded in; fonts not shipped) |
| fonts, slides | S:58 | `font.mathptmx` | `txfonts` |
| type sizes and families | K:233,243-259 | `font.size-commands`, `mark.kernel` | chapter `\sffamily\Huge`, section `\Large`, subsection `\large`, deeper `\normalsize`, reduced size `\footnotesize` |
| span marks | T:350,410 | `mark.kernel` | `\textit`, `\textbf`, `\emph` |
| upper-casing | K:104-110 | `mark.case` | `textcase` `\MakeTextUppercase` for the `*=TITLE` options |
| colour | M:47-53; T:56,121 | `color.color` | `color`, `\definecolor{blue}{RGB}{41,5,195}`, `thered thegreen thegrey theshade theframe` |
| colour, book model | L:73,210 | `color.xcolor` | `[dvipsnames]{xcolor}`, `\textcolor{blue}` |
| language and caption names | K:138,159-197; T:43-46,193,415-422 | `lang.babel` | `[brazil]{babel}`, `\addto\captionsbrazil` and `\captionsenglish` (names, autoref names), `\selectlanguage{brazil}`, `otherlanguage*` |
| language, XeLaTeX | L:55-57 | `lang.polyglossia` | `\setmainlanguage{brazil}`, `\setotherlanguages{french,english,spanish,german,italian}` |
| glossary strings | G:471-478 | `lang.translator` | `\providetranslation{Glossary}{Glossário}` and seven more |
| PDF metadata and links | K:126-127; T:125-138; M:102-115 | `meta.hyperref` | `\hypersetup{pdftitle,pdfauthor,pdfsubject,pdfcreator,pdfkeywords,colorlinks=true,linkcolor,citecolor,filecolor=magenta,urlcolor,bookmarksdepth=4}`; `\pdfstringdefDisableCommands{\def\\{, }\def\and{; }}` |
| back references | T:70,80-91; A:74-92 | `meta.hyperref` | `\usepackage[brazilian,hyperpageref]{backref}` from the hyperref bundle, same feature as the `pagebackref` option; hook `\backrefalt` set to three strings (none, one page, many pages) |
| PDF bookmarks | K:132,271-286,676; T:447,455,463,491 | `meta.bookmark` | `bookmark`, `\pdfbookmark[0]{..}{..}`, `\bookmarksetup{startatroot}` |
| URLs | U:101,292-296; I:298 | `meta.url` | `url` loaded by abntex2cite, `\urlstyle{same}`, `\UrlLeft{<}` `\UrlRight{>}` |
| cross-references | I:461-467; T:581-582 | `xref.kernel`, `xref.hyperref` | `\ref`, `\pageref`; `\autoref`, `\nameref`, `\autopageref`; autoref words K:166-170 |
| title block | K:694-710; A:96-109,189; M:91-100,128 | `front.maketitle` | `\titulo`/`\autor`/`\data` forward to `\title`/`\author`/`\date`; `\maketitle` in article and manuals |
| author notes | A:99-105 | `front.thanks` | `\thanks{..}` inside `\autor` |
| cover and title page | K:750,1037-1123; T:206,213; P:178,184 | `front.class-native` | `\imprimircapa`, `\imprimirfolhaderosto` and `*`, `\folhaderostocontent` |
| catalogue card, errata, approval sheet | K:763-785,1016-1026; T:231-340 | `front.class-native` | `fichacatalografica` (single spaced, `\footnotesize`), `errata`, `folhadeaprovacao` with `\assinatura` lines |
| matter switches | K:654-684; T:501,654 | `front.class-native` | `\pretextual` (empty page styles), `\textual` (`abntheadings` or `plain`), `\postextual` (`\phantompart`) |
| hand-laid covers (book) | K:750; L:200-242 | `front.titlepage-env` | memoir `titlingpage` (class `capa` is `titlingpage` plus `\cleardoublepage`) |
| dedication pages | K:790-810; T:346-391 | `front.dedication` | `dedicatoria`, `agradecimentos`, `epigrafe` (optional title, bookmark only if untitled) |
| abstracts | K:817-846; T:399-441; A:197-224 | `abs.class-native` | `resumo[name]` and `resumoumacoluna` over memoir `abstract` and `onecolabstract`; `\absleftindent=0cm`, `\absrightindent=0cm`, `\absparindent=0pt`, `\abstracttextfont{\normalfont\normalsize}`, `\absparsep=18pt` (T:399) |
| abstract in manuals | M:130-137; C:242-246 | `abs.kernel` | `abstract` |
| keyword line | T:410,421 | `abs.keywords` | `\textbf{Palavras-chave}: ...` |
| contents and lists | T:447-449,463-465,491-493; M:139-141 | `toc.kernel` | `\listoffigures*`, `\listoftables*`, `\tableofcontents*`, `\tableofcontents`, `\listoftables` |
| contents styling | K:431-453,486-533 | `toc.tocloft` | memoir's built-in tocloft commands: `\cftsetindents` (0em, `\cftlastnumwidth`), `\cftchapterfont{\bfseries}`, `\cftpartfont{\bfseries\large}`, `\cftfigureaftersnum{\hfill\textendash\hfill}`, `\cftchapterdotsep`, `\cftbeforechapterskip`, `\cftinsertcode`, `\settocpreprocessor` (option `sumario=abnt-6027-2012`, default) |
| new list-of | T:158-159,164-165 | `front.class-native` | memoir `\newlistof{listofquadros}{loq}{..}`, `\newlistentry{quadro}{loq}{0}`, `\cftquadroname`, `\cftquadroaftersnum` |
| chapter and part look | K:566-635; L:147 | `head.memoir-style` | `\makechapterstyle{abnt}` (chapter and part title fonts, `\chapternamenum`, `\printchaptertitle`, `\printchapternum`), `\chapterstyle{abnt}`; book `\chapterstyle{veelo}` |
| section look | K:588-591,427-428 | `head.memoir-style` | `\setsecheadstyle`, `\setsubsecheadstyle`, `\setsubsubsecheadstyle`, `\setsubsubsubsecheadstyle`, `\setafterparaskip`, `\setparaheadstyle` |
| heading options and hooks | K:55-59,243-259,422-425 | `head.class-native` | `chapter=TITLE` etc.; `\ABNTEXchapterfont`, `\ABNTEXsectionfontsize` and siblings; fifth level `\subsubsubsection` = `\paragraph` |
| numbering depth | K:415-419 | `num.secnumdepth` | `\setsecnumdepth{paragraph}`, `\settocdepth{paragraph}`, `tocdepth=5`, `secnumdepth=5`, `\maxsecnumdepth{paragraph}` |
| counters | K:320-327; T:163 | `num.counters` | `\counterwithout{figure}{chapter}`, `{table}{chapter}` (article: `section`/`chapter`, `figure`/`section`), `\counterwithout{quadro}{chapter}` |
| appendices and annexes | K:882-957; T:677-728 | `num.appendix` | `\apendices`/`apendicesenv`, `\anexos`/`anexosenv` over `\appendix`; `\appendixname` set to `\apendicename` or `\anexoname`; `\partpage` over `\appendixpage*` |
| lists | M:200,299; T:471-485; K:851-868 | `list.kernel` | `description`, `itemize`, `enumerate`; `siglas` and `simbolos` are memoir `symbols` (a description-type list) after a `\pretextualchapter` |
| enumitem lists | K:202,991-997 | `list.enumitem` | `\newlist{alineas}{enumerate}{2}`, `\setlist[alineas,1]{label={\alph*)},topsep=0pt,itemsep=0pt,leftmargin=\parindent+\labelwidth-\labelsep}`, level 2 `label={--}`, `subalineas`, `incisos` |
| long quotation | K:976-985; I:49-54 | `quote.kernel` | class env `citacao[lang]`: a `list` with `\leftskip` + 4cm, `\ABNTEXfontereduzida`, `SingleSpace`, italics and `\selectlanguage` when a language is given |
| footnotes | I:90-100; K:310-315 | `fn.kernel`, `fn.footmisc` | `\footnote`; memoir `\footmarkwidth=1.2em`, `\footmarksep=0em`, `\footmarkstyle{\footnotesize{\textsuperscript{#1}}\hfill}`, `\foottextfont{\ABNTEXfontereduzida}` |
| maths | L:40-42; I:280-295 | `math.mathtools`, `math.amssymb`, `math.bm`, `math.kernel` | `mathtools`; `amsfonts`; `mathrsfs`; `equation`, `\[ \]` |
| figures | T:57; I:223-229,239-255 | `fig.graphicx`, `box.minipage` | `graphicx`, `\includegraphics[scale=0.5]{..}`; two `minipage{0.4\textwidth}` in one figure |
| new float type | T:157,162,167 | `fig.newfloat` | memoir `\newfloat[chapter]{quadro}{loq}{\quadroname}`, `\setfloatadjustment{quadro}{\centering}`, `\setfloatlocations{quadro}{hbtp}` (memoir command, same type as `\DeclareFloatingEnvironment`) |
| float tuning | T:146; M:27 | `fig.placement` | `\setlength{\@fptop}{5pt}` (kernel float length); `morefloats` (load-only, float capacity; folded in) |
| rotated tables and wide tables | L:75 | `fig.rotating`, `tbl.tabularx` | `rotating`, `tabularx` |
| captions | K:333-335,406-408; I:112,127,169,200 | `cap.memoir`, `cap.kernel` | `\hangcaption`, `\captiondelim{~\textendash~}`, `\ABNTEXcaptionfontedelim`, memoir `\legend{..}`; `\caption` above, source line below |
| source and note lines | K:342-385 | `cap.memoir` | `\fonte[label]{..}` and `\nota[label]{..}` (via memoir `\@makecaption`, `\captiondelim{:~}`); `\IBGEtab{caption}{tabular}{legend}` is a `\parbox` of the measured table width (K:351-364) |
| caption package hook | K:390-404 | `cap.caption` | applies only when the author loads `caption` (`format=hang`, `labelseparator`, `justification=justified`); no sample loads it |
| tables | I:114-126; T:281-287 | `tbl.tabular` | `tabular` with `p{..}` columns, `\hline` |
| table rules | I:141-149; L:419-482 | `tbl.booktabs` | `\toprule \midrule \bottomrule \cmidrule(r){1-2}` (memoir has them built in; L:75 also loads `booktabs`) |
| merged cells | R:69,513-548 | `tbl.multirow` | `multirow`, `\multirow{4}{10cm}[24pt]{..}`, `\multicolumn` |
| code listings (manuals) | M:55-81; C:100-126; CA:93-119 | `code.listings` | `\lstset{language=[LaTeX]TeX,columns=flexible,basicstyle=\ttfamily\small,backgroundcolor=\color{theshade},frame=single,tabsize=2,rulecolor=..,title=\lstname,escapeinside={\%*}{*)},breaklines=true,commentstyle=..,keywords=[0]{..},keywordstyle=[0]..,breakatwhitespace=true,alsoother={0123456789_},inputencoding=utf8,extendedchars=true,literate=..}` and `\lstnewenvironment{verbatim}[1][]{\lstset{##1}}{}` |
| verbatim | I:58-63; M:495-497 | `code.verbatim` | `verbatim` in the models (in the manuals the same name is rebound to `listings`) |
| boxes | T:235; L:263-279 | `box.fancybox`, `box.mdframed` | `\fbox{\begin{minipage}[c][8cm]{13.5cm}..}`; `mdframed` around the CIP card |
| citations | T:71; M:83; C:81; CA:66; U:96 | `bib.apacite` | `\usepackage[alf]{abntex2cite}` (also `num`, `overcite`, `versalete`, `abnt-*` options via `\citeoption`); commands `\cite \citeonline \citeyear \citeauthor \apud \Idem \Ibidem \opcit \cfcite` (U:927-1098,1301-1344); the companion `abntex2abrev.sty` is loaded by it (U:99, V:21-124) |
| bibliography | T:660; U:375-424; B:1-24 | `bib.bibtex-bst` | `\bibliography{abntex2-modelo-references}` with no `\bibliographystyle`: the package writes `abntex2-alf` or `abntex2-num` at the end (U:420-424) and adds `abntex2-options.bib` (U:375-398) |
| index | T:183,734; R:163,498 | `idx.makeidx` | `\makeindex`, `\printindex`, `\index{..}` (memoir built-in; makeindex pass) |
| glossary | G:66,145-186,190,308-314,462-495 | `idx.glossaries` | `glossaries[subentrycounter,seeautonumberlist,nonumberlist=true]`, `\makeglossaries`, `\newglossaryentry`, `\glsseeformat`, `\setglossarystyle{tree}`, `\glossaryname`, `\glossarypreamble`, `\printglossaries`; `nomencl` loaded in A:59 and C:39 |
| file inclusion | T:556; G:440; R:378 | `struct.input` | `\include{abntex2-modelo-include-comandos}` |
| filler text | T:64,600-602 | `draft.todo` | `lipsum`, `\lipsum[2-3]` |
| slide theme | S:32-34 | `slide.beamer-theme` | `\usetheme{Pittsburgh}`, `\usecolortheme{default}`, `\usefonttheme[onlymath]{serif}` |
| slide colours | S:39-47 | `slide.beamer-template` | nine `\setbeamercolor{..}{fg=..,bg=..}` |
| slide overlays | S:123,239 | `slide.beamer-mode` | `\pause`; `frame[allowframebreaks]` |
| manual markup | M:117-123,486,2751-2759; C:141-143 | `dtx.doc` | `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\changes{v1.0}{2013/02/01}{..}`, `\DescribeMacro`, `\DescribeEnv`, `\PrintChanges`, `\PrintIndex`, `\StopEventually{\PrintIndex}`, short verbatim `|..|`; `\citeoption`/`\nocite` lists in C |
| manual paragraph and table packages | M:25-27; C:41-42 | `sp.parskip-pkg`, `tbl.booktabs`, `sp.lengths` | `parskip` (M:25); `booktabs` (C:41); `\setlength{\belowcaptionskip}{6pt}` (C:42); the manuals also load `lmodern`, `[T1]{fontenc}`, `[utf8]{inputenc}`, `microtype` (M:21-26) as in the font and spacing rows |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class `abntex2` | K:1-1125 | not bespoke (published, CTAN) | `\documentclass[opts]{abntex2}` plus its native commands; internals (`\fonte` over `\@makecaption` K:369-382, `\@switch` aux write K:883-884, TOC preprocessor K:473-483) stay inside the class |
| package `abntex2cite` and `abntex2abrev` | U:1-1347; V:1-124 | not bespoke (published, same CTAN bundle) | `\usepackage[alf]{abntex2cite}`; sort and group macros (U:1186-1299), `\bibitem` and `\cite` redefinitions (U:469-530,614-912) are package internals |
| BibTeX styles `abntex2-alf`, `abntex2-num` | B:1-24; tex/abntex2-num.bst | not bespoke (published, merlin-derived) | named by `\bibliographystyle` (written by the package) |
| `verbatim` rebound to listings | M:79-80; C:124-125; CA:117-118 | yes | `code.listings` with the `\lstset` of M:57-78 and `\lstnewenvironment{verbatim}` |
| conditional load of listings | M:55-81 | yes | listings is a TeX Live package; the emitter just loads it |
| aliases `\abnTeX`, `\abnTeXSite`, `\abnTeXForum`, `\optiondefaultval`, `\OKs`, `\quaseOKs`, `\nadaOK`, `\VerbL`, `\LatL`, `\quadroname`, `\listofquadrosname` | M:87-89; C:85-87,220-222; CA:81-82,138-140; T:154-155 | yes | inline expansion to text, `\url{..}`, `\underline{\texttt{..}}`, lengths (`sp.lengths`) |
| CVS helpers `\Versao`, `\Data` | C:89-90 | yes | never called; dropped |
| LaTeX2HTML shim (`html.sty` if found, else `comment` plus `\html`, `\latex`, `\htmladdnormallink`, `\latexhtml`) | C:52-78; CA:37-63 | yes | for PDF: `\latex{x}` becomes x, `\latexhtml{a}{b}` becomes a, `\htmladdnormallink{a}{b}` becomes `\href{b}{a}` (`meta.hyperref`); the html-only environments are only mentioned in comments (C:231-238; CA:149-154) |
| `\backrefalt` redefinition | T:84-91; A:85-92; L:98-105 | yes | the documented hook of `backref`, three strings selected by the count (`\ifcase`); the emitter prints it as a fixed hook value |
| memoir float and list-of for "quadro" | T:154-167 | yes | `fig.newfloat`, `front.class-native`, `toc.tocloft`, `num.counters` as in the map |
| `\@fptop` and `\@title` use | T:145-147,124-139 | yes | `fig.placement` length; `pdftitle` and `pdfauthor` as `meta.hyperref` strings |
| `\ifxetex` branch of the book model | L:44-67 | yes | emit one branch: pdfLaTeX (L:61-66) or XeLaTeX (L:48-57, fonts Minion Pro, Myriad Pro, Consolas are not shipped) |
| `\renewcommand{\textual}` in the book model | L:170-175 | yes | `hf.memoir-pagestyle` (`\pagestyle`, `\aliaspagestyle`, `\nouppercaseheads`) and `meta.bookmark` (`\bookmarksetup{startatroot}`) at the matter switch |
| page styles `abntbookheadings`, `abntbookchapfirst` | L:160-167 | yes | `\makepagestyle`, `\makeevenhead`, `\makeoddhead`, `\makeheadrule` calls with the same arguments |
| `xspace` loaded, never called | L:79 | yes | load-only; considered, no way needed (lib v4 rejected `sp.xspace`) |

## Content-opaque
- `picture` drawing of lines inside a figure (I:171-198), `\includegraphics` of abntex2-modelo-img-grafico.pdf and abntex2-modelo-img-marca.pdf (I:226,245,252; L:209,234; S:80,159), `example-image-a` from the TeX Live `mwe` bundle (L:394); all inside floats or title pages.
- Table cell text, example `.bib` data (doc/examples/abntex2-modelo-references.bib, doc/abntex2-doc*.bib), the verbatim example listings of the manuals, and the `\lipsum` filler.
- Missing assets: the book model's XeLaTeX fonts Minion Pro, Myriad Pro and Consolas (L:51-53); the jpg images named in README are not referenced by any `.tex` read.

## Lib changes
- New ways proposed: none. Considered and folded into existing ways (no proposal): `leading` into `sp.linespread` (CTAN page read), `morefloats` into `fig.placement`, `mathspec` into `font.fontspec`, `backref` into `meta.hyperref`, the `comment`/`html` shim by inline expansion, `xspace` load-only.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
