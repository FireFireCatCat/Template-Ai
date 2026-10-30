no

# 0726-jbreitenbucher-exampleis: Wooster Independent Study thesis template (woosterthesis)

- Unverified: read from the source, not compiled.
- Source: Source/0726-jbreitenbucher-exampleis/ (origin: https://codeload.github.com/jbreitenbucher/exampleis/zip/refs/heads/master; licence: not established)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (the class branches on `\ifxetex`, woosterthesis.cls:1033-1076; the fontspec/unicode-math font block in styles/packages.tex:10-16 is XeLaTeX-only and ships no fonts)
- Look carried by: mixed (zip-local class woosterthesis.cls plus zip-local styles/woofncychap.sty and styles/lshortwooster.sty carry headings, title page, contents and the example box; the preamble files styles/theorems.tex, styles/personal.tex, styles/packages.tex add theorem styles, macros and XeLaTeX fonts)
- Class origin: zip-local (ctan.org/pkg/woosterthesis returned 404; the zip is a personal GitHub repo, not shown to be an official release)
- Main file: main.tex (other samples: none; appendices/lssym.tex is a symbol-table chapter that nothing `\input`s)
- Read: main yes, zip-local classes and styles all (woosterthesis.cls, lshortwooster.sty, woofncychap.sty, packages.tex, personal.tex, theorems.tex; chapters and appendices read, appendices/math.tex read at 1-150, 595-765, 990-1047 and grepped for definitions; appendices/lssym.tex not read because it is not loaded)

## Verdict
No. The look is carried by a hand-written zip-local class (`\LoadClass{book}`, woosterthesis.cls:116) that is mostly reducible to published ways (geometry, textpos title page, setspace, caption, listings, biblatex, theorem styles), but it ships irreducible typesetting code: the `example` environment of lshortwooster.sty that the sample uses about 46 times in its body (8 in chapters/chapter1.tex, 38 in appendices/math.tex, counted from begin/end lines; it writes its body to `\jobname.exa` and typesets it twice), the measured-rule `Euler` chapter heading of woofncychap.sty (the `euler` class option in main.tex:33 selects it), and a counter-driven contents-header injection in `\@chapter`. Two more irreducible pieces are option-gated and not exercised by the sample. No `ART` and no `EXTERNAL` blocker was found.

## Blockers
- `BESPOKE/class` `example` environment: `\newwrite`, `\immediate\openout \jobname.exa`, `\verbatim@processline` writing lines, then `\verbatiminput` and `\input` of the same file side by side in two sized minipages inside an `\fbox` (styles/lshortwooster.sty:141-194); loaded by option `lshortwooster` (main.tex:33, woosterthesis.cls:972-974); used in the body (first uses chapters/chapter1.tex:21 and appendices/math.tex:28; 16 and 76 begin/end lines respectively)
- `BESPOKE/class` `Euler` chapter heading of woofncychap: box widths and heights measured with `\settowidth`/`\settoheight`, `\rule` and `\leaders` arithmetic draw a framed chapter number (styles/woofncychap.sty:95-140, 181-190); loaded by option `euler` (main.tex:33, woosterthesis.cls:921-923); `Gauss` is the sibling (woofncychap.sty:146-173)
- `BESPOKE/class` counter-driven contents header: inside the redefined `\@chapter`, `\ifnum\value{chapter}=1` injects `\addtocontents{toc}{\protect\noindent \@chapapp \hfill \pagename\par}` once, a hand-rolled conditional that decides what is printed (woosterthesis.cls:536-539)
- `BESPOKE/class` abstract-only mode: the `abstract` environment ends by `\global\let\@end@bstract\enddocument` and `\def\@currenvir{document}% nasty trick!` (woosterthesis.cls:787-794); option `abstractonly` is not set in the sample (main.tex:33), so unexercised
- `BESPOKE/class` biblatex macro redefinition `\renewbibmacro*{journal+issuetitle}` and `{issue+date}` under option `nature` (woosterthesis.cls:992-1018); bibliography-style code, not an option value; unexercised

## Class setting
- Class: zip-local `woosterthesis` over `class.book` (`\LoadClass{book}`, woosterthesis.cls:116); options in the sample: `palatino,code,picins,tikz,kaukecopyright,openright,lshortwooster,dropcaps,verbatim,index,oneside,euler` (main.tex:33). Options not declared by the class go to book through `\DeclareOption*` (woosterthesis.cls:110-112). The default list at woosterthesis.cls:107 comes before that fallback is declared; whether those defaults reach book was not traced.
- Class-native vocabulary used: `\thesistype` `\presentdegrees` `\degreetoobtain` `\presentschool` `\academicprogram` `\gradyear` `\advisor{label}{name}` `\reader{label}{name}` `\copyrighted` `\copyrightdate` (main.tex:112-123); `\maketitle` `\disscopyright` (main.tex:146,149); `abstract` `\dedication` `acknowl` `vita` with `publist` `\pubitem` `fieldsstudy` `\majorfield` `\minorfield` `\specialization` (main.tex:158-228); `\woopic{file}{scale}` (chapters/chapter2.tex:22); `colophon` env gated by an option the sample does not set (main.tex:331-343)

## Component map
Ways below are the reductions of the zip-local class into lib ways, so each row says what an emitter would print. Rows marked (irreducible) are the blockers above.
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:33; woosterthesis.cls:116 | `class.book` | oneside, openright (to book via woosterthesis.cls:110-112) |
| paper and margins | woosterthesis.cls:201 (oneside branch), 172 (twoside) | `page.geometry` | letterpaper, marginparwidth=.6in, hmargin={1in,1in} (oneside) or {1.25in,1in} (twoside), top=1in, bottom=1in |
| paper size | woosterthesis.cls:201 | `page.class-options` | letterpaper (given to geometry) |
| line-break and widow settings | woosterthesis.cls:123-125 | `sp.penalties` | widowpenalty=100000, displaywidowpenalty=5000, hyphenpenalty=5000 |
| line-break tolerance | woosterthesis.cls:125 | `sp.hyphenat` | `\tolerance=1000` (an integer line-breaking parameter, filed beside `\sloppy`; borderline fit) |
| float spacing | woosterthesis.cls:128-131 | `fig.placement` | bottomfraction=.7, textfloatsep=11pt plus 11pt minus 3pt, floatsep=9pt plus 9pt minus 3pt, intextsep=11pt plus 11pt minus 3pt |
| core packages | woosterthesis.cls:119-120 | `fig.graphicx`, `bg.eso-pic`, `math.amsmath`, `thm.amsthm`, `math.amssymb`, `sp.setspace`, `fig.float`, `pg.textpos` | textpos options absolute,overlay; fancyhdr is loaded but no `\fancy...` call exists in any file (`hf.fancyhdr` not used) |
| name strings | woosterthesis.cls:138-157 | `head.kernel` (`\chaptername` CHAPTER, `\appendixname` APPENDIX, `\partname`), `toc.kernel` (`\contentsname`, `\listfigurename`, `\listtablename`), `cap.kernel` (`\figurename`, `\tablename`), `idx.makeidx` (`\indexname`) | kernel string redefinitions |
| date format | woosterthesis.cls:158-163 | `front.datetime` | `\today` printed as "Month day, year" by `\ifcase\month`; reducible by expansion |
| title page | main.tex:146; woosterthesis.cls:404-408, 346-402 | `front.titlepage-env`, `pg.textpos`, `sp.setspace`, `font.size-commands`, `mark.kernel` | textblocks {9}(4,1.925) title `\scshape\Large`, {7}(2.125,4.75) thesis type `\scshape`, {8}(4,6.9) fulfilment text, {7}(2.125,9.165) author, {7}(2.125,10.125) school and year, {7}(1,12.3) advisor and reader; coordinates are chosen by point size (woosterthesis.cls:237-264); the `titlepage` option branch is WoosterTitlePage (woosterthesis.cls:267-343) |
| title-page background | main.tex:147; woosterthesis.cls:1088-1098 | `bg.eso-pic` | `\AddToShipoutPicture*` of an image `.9\paperwidth`x`.9\paperheight` keepaspectratio; file W_black, scottie_head_grayscale or kauke_arch_gray by option; `\ClearShipoutPicture` after the title page |
| copyright page | main.tex:149; woosterthesis.cls:1101-1138 | `front.dedication`, `fig.graphicx` | cleardoublepage, empty page style, `\vspace*{\fill}`, centred logo `\includegraphics[scale=.4]` (kauke_wordmark), "(c) year by author, All rights reserved." in singlespace |
| front/main/back matter | main.tex:142,252,283; woosterthesis.cls:456-489 | `pg.break`, `pgnum.pagenumbering`, `hf.pagestyle-kernel`, `num.appendix` | frontmatter: roman, plain; mainmatter: arabic, headings; backmatter: `\appendix`, headings |
| running heads | woosterthesis.cls:202-227 (oneside) | `hf.pagestyle-kernel` | hand-defined `\ps@headings`: head `{\slshape\rightmark}\hfil\thepage`, empty foot; reducible to `hf.fancyhdr` fields; twoside variant 173-199 |
| line spacing | woosterthesis.cls:714-718; chapters/chapter1.tex:20 | `sp.setspace` | `\doublespacing` unless option `singlespace`; `singlespace` environment around examples and tables (chapters/chapter1.tex:20) |
| abstract page | main.tex:158-160; woosterthesis.cls:779-786 | `head.kernel`, `toc.kernel` | `\chapter*{Abstract}` + `\addcontentsline{toc}{chapter}{Abstract}` |
| dedication, acknowledgements, vita | main.tex:168,177,187; woosterthesis.cls:776,797,799 | `front.dedication`, `head.kernel`, `toc.kernel` | unnumbered `\chapter*` pages with toc lines; dedication centred between fills |
| vita lists | main.tex:216-228; woosterthesis.cls:816-832 | `list.kernel`, `sp.manual-space`, `sp.rule` | `publist` and `fieldsstudy` are centred headings with `\vskip` blocks; `datelist` (commented, main.tex:196-212) is a kernel `list` with `\dotfill` labels |
| contents, lists | main.tex:238-245; woosterthesis.cls:663-713 | `toc.kernel`, `toc.tocloft` | `\tableofcontents` `\listoffigures` `\listoftables` `\lstlistoflistings`; `\l@chapter` and `\l@section`..`\l@subparagraph` dotted-line indents `1.5em/2.3em`, `3.8em/3.2em`, `7em/4.1em`, `10em/5em`, `12em/6em`; "Figure ... Page" header line by `\@tocheadline` (woosterthesis.cls:664-667); `\let\l@table\l@figure` |
| section depth | main.tex:94-95 | `num.secnumdepth` | secnumdepth=5, tocdepth=6 |
| chapter headings (euler) | styles/woofncychap.sty:95-140,181-190; woosterthesis.cls:921-923 | (irreducible) | Euler: number `\fontsize{60}{62}`, name `\small`, title `\scshape\Large`, rule 1.5pt |
| chapter headings (default, unused with euler) | woosterthesis.cls:563-576, 587-593 | `head.titlesec` | 50pt above, title `\fontshape{sc}\fontsize{20}{22}`; the starred form (woosterthesis.cls:587-593) is still used for `\chapter*` pages |
| section headings | woosterthesis.cls:623-638, 841 | `head.titlesec` | section `\scshape\Large` skips -3.5ex/2.3ex; subsection `\scshape\large`; subsubsection `\scshape\normalsize`; paragraph `\normalfont\normalsize\scshape\bfseries` run-in; first paragraph never indented (woosterthesis.cls:597-604 copies `\@startsection` with `\@afterindentfalse`) |
| part headings | woosterthesis.cls:494-522, 840 | `head.titlesec`, `num.counters` | no bold, Roman part number (no `\part` in the sample) |
| numbering | woosterthesis.cls:842-845 | `num.counters` | `\thesubsection` etc. as dotted arabic |
| appendix | woosterthesis.cls:761-765 | `num.appendix` | chapter counter reset, `\Alph`, name APPENDIX |
| description list | woosterthesis.cls:768-773; chapters/chapter1.tex:50 | `list.enumitem` | labelwidth 0, itemindent -leftmargin, bold label |
| lists | chapters/chapter1.tex:22-42 | `list.kernel` | enumerate nested, itemize |
| theorem styles | styles/theorems.tex:21-33 | `thm.amsthm` | `\newtheoremstyle` break (italic body, bold head, `\newline` after head), scthm, itdefn, scdefn (head `\thmname{\textbf{#1}}\thmnumber{ \textbf{#2}}\thmnote{ \scshape #3:}`) |
| theorem environments | styles/theorems.tex:35-63; chapters/chapter1.tex:65,78,132 | `thm.amsthm`, `num.counters` | thm cor lem prop (break), defn (scdefn), rem ex note nts terminology numbered within chapter; `\therem`, `\thenote`, `\thents`, `\theterminology` emptied |
| boxed definition | styles/theorems.tex:67-70 | `box.fancybox`, `box.minipage`, `sp.setspace` | `lrbox` + minipage 0.9`\linewidth` + `\fbox` around `bdefn`; defined, not used in the sample |
| math | chapters/chapter1.tex:68-125; appendices/math.tex | `math.amsmath`, `math.kernel`, `math.amssymb`, `math.bm` | equation, align, subequations, alignat, cases, `\substack`, `\intertext`, displaymath; `eucal[mathscr]` loaded by lshortwooster.sty:114-117 (alphabet package) |
| math macros | styles/personal.tex:35,37,52,69 | `math.amsmath` | `\mbd` `\bvec` `\degree` `\qrfac[#1]{#2}{#3}` as `\left(..\right)_{#3}^{#1}`: reducible by expansion |
| fonts (pdfTeX) | woosterthesis.cls:864-866, 1053-1057 | `font.palatino`, `font.lmodern`, `font.fontenc-t1` | `mathpazo[sc]` with option `palatino`, else `lmodern`; `inputenc[utf8]`, `fontenc[T1]` |
| fonts (XeLaTeX) | styles/packages.tex:10-16; woosterthesis.cls:1034 | `font.fontspec`, `font.unicode-math` | `\setmainfont[Numbers=OldStyle]{Times New Roman}`, `\setmathfont{TeX Gyre Termes Math}`, Arial sans, Courier New mono; `xltxtra` also loaded (considered: no lib home, load-only extra); fonts not shipped |
| typography | woosterthesis.cls:1066 | `sp.microtype` | verbose, expansion=alltext, stretch=20 (pdfTeX branch only) |
| quotes | woosterthesis.cls:1064, 1041 | `lang.csquotes` | style=american, autopunct=true |
| foreign language | woosterthesis.cls:1037-1040, 1060-1063 | `lang.polyglossia`, `lang.babel` | only with option `foreignlanguage` (not set) |
| hyperlinks | woosterthesis.cls:1068-1074 | `meta.hyperref`, `color.xcolor` | pdftex, pdfusetitle, bookmarks, colorlinks, linkcolor=refcolor, citecolor, urlcolor, pdfpagetransition=Glitter, linktocpage, hyperindex=true; cmyk colours refcolor `{1,0.98,0,0}`, urlcolor `{0.8,0.32,0.98,0.2}`, citecolor `{0.5,1,0,0}` (1070-1073); `blacklinks` branch 1067-1068 |
| cross-references | chapters/chapter1.tex:14 | `xref.kernel` | `\label` `\ref` |
| captions | woosterthesis.cls:848-859 | `cap.caption`, `cap.kernel` | style=base, format=hang; `\DeclareCaptionStyle{woosterthesis}` font=small, labelfont={bf,small}, labelsep=colon, justification=centerlast, singlelinecheck=false |
| subfigures | woosterthesis.cls:850; chapters/chapter2.tex:207-221 | `fig.subcaption` | `\captionsetup[subfigure]{list=true,listformat=subparens}`, subrefformat=parens |
| figures | chapters/chapter2.tex:18-28; styles/personal.tex:91 | `fig.graphicx`, `box.minipage` | `\woopic{file}{scale}` = `\includegraphics[scale=#2]`, `\graphicspath{{./figures/}}`, extensions .pdf .jpg .tif .png (woosterthesis.cls:1169) |
| wrapped figure | woosterthesis.cls:967-969; chapters/chapter2.tex:47-50 | `fig.wrapfig` | `wrapfigure{r}{2.2in}`, option `picins` |
| tables | chapters/chapter2.tex:246-257, 319-334 | `tbl.tabular` | `tabular` with `\hline`, `\cline`, `\multicolumn`; `[!ht]` |
| footnotes | woosterthesis.cls:1141-1166 | `fn.kernel`, `sp.rule`, `sp.lengths`, `font.size-commands`, `num.counters` | footnote rule `\kern-3pt \hrule .4\columnwidth \kern2.6pt`; `\footnotesep` 12pt; footnotes single-spaced 10/12; `\@addtoreset{footnote}{chapter}` |
| code | woosterthesis.cls:926-959; chapters/chapter1.tex:142-150; appendices/java.tex:28-39 | `code.listings` | `\lstset{language,numbers=left,numberstyle=\tiny,basicstyle=\small,frame=trbl,frameround=tttt,framesep=6pt,xleftmargin=30pt,linewidth=.95\textwidth,breaklines,...}`, `lstlisting[mathescape,caption,label]`, `\lstinputlisting[caption,label]{source/..}`, `\lstlistoflistings` retitled "List of Listings" |
| verbatim | woosterthesis.cls:906-908; chapters/chapter1.tex:152 | `code.verbatim` | `verbatim` package |
| drop capital | woosterthesis.cls:911-913; chapters/preface.tex:5 | `sp.lettrine` | `\lettrine[lines=2, lhang=0.33, loversize=0.1]{T}he` |
| bibliography | woosterthesis.cls:1024, 1082; main.tex:103,297,300 | `bib.biblatex-biber` | `style=numeric,autolang=other,bibencoding=inputenc,hyperref=auto,backref=true,backrefstyle=two,natbib=true,sorting=nty,backend=biber`; `\addbibresource`, `\nocite{*}`, `\printbibliography[title=References,heading=bibintoc]`; `\DefineBibliographyStrings{english}{backrefpage,backrefpages}` (styles/personal.tex:97-100); other styles acs, chicago, apa, mla, nature, citeorder (woosterthesis.cls:977-1030) |
| index | main.tex:124,315-319; woosterthesis.cls:875-898 | `idx.makeidx`, `cols.twocolumn-cmd` | `\makeindex`, `\printindex`; `theindex` redefined: `\twocolumn[\@makeschapterhead{\indexname}]`, columnsep 35pt, `\parindent 0`; makeindex style wooind.ist at the zip root (wooind.ist:7-24: actual `@`, level `!`, `\dotfill` delimiters, bold centred heading prefix) is not referenced by any .tex, .cls, .sty, .md, .xml or .bat file (grep), so how it is passed to makeindex is not established |
| index and package-name macros | styles/personal.tex:53-55; styles/lshortwooster.sty:41-59 | `idx.makeidx`, `mark.kernel` | `\ip` `\ic` `\ie` `\ci` `\pai` `\ei` `\wi` print text in `\texttt`/`\textsf` and call `\index{..}`: reducible by expansion |
| manual-example boxes | styles/lshortwooster.sty:141-194 | (irreducible) | see Blockers |
| manual helper boxes | styles/lshortwooster.sty:63-100, 196-198; appendices/math.tex:599,721 | `tbl.tabular`, `box.minipage`, `sp.rule`, `sp.manual-space` | `command` (tabular `|l|` with `\hline`), `symbols` (lrbox of tabular in `\makebox[\textwidth]`), `lined`, `code`, `intro`: reducible |
| empty pages | main.tex:148,344; styles/lshortwooster.sty:201-203 | `pg.emptypage`, `pg.break`, `hf.pagestyle-kernel` | cleardoublepage with an empty-style blank page |
| colophon | main.tex:331-343; woosterthesis.cls:798 | `quote.kernel`, `sp.setspace`, `font.size-commands` | not rendered unless the option `colophon` is set |
| title block metadata | main.tex:111-123 | `front.titlepage-env` | strings for title, type, author, degree, school, program, year, advisor, reader |
| tikz | woosterthesis.cls:869-872 | `art.tikz` | `tikz` with `positioning`, loaded by option `tikz`; drawings only inside figures |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `example` environment (verbatim-to-file, two-up display) | styles/lshortwooster.sty:141-194 | no | `code.tcblisting` (tcolorbox listings library) was considered as a look-alike; it is another macro with another layout, so it does not reproduce this one |
| woofncychap `\DOCH` Euler and Gauss | styles/woofncychap.sty:95-173 | no | altered copy of published fncychap; the published styles of `head.fncychap` do not include these shapes |
| `\@chapter` counter-driven toc header | woosterthesis.cls:536-539 | no | hand-rolled conditional on the chapter counter driving printed output |
| `\@chapter` log message with `\uppercase\expandafter` | woosterthesis.cls:532-534 | yes | log output only; drop |
| `abstract` ends the document (`\@currenvir` trick) | woosterthesis.cls:779-794 | no | unexercised option `abstractonly` |
| `\renewbibmacro*` under `nature` | woosterthesis.cls:992-1018 | no | unexercised |
| `\@startsection` copy | woosterthesis.cls:599-622 | yes | `head.titlesec` with `\titlespacing*` (no indent after headings) |
| `\@makechapterhead`, `\@makeschapterhead`, `\@schapter` | woosterthesis.cls:563-593 | yes | `head.titlesec` display format with the sizes above |
| `\WoosterTitlePage`, `\WoosterInlineTitlePage`, offset macros, `\@maketitle`, `\maketitle` | woosterthesis.cls:237-453 | yes | `front.titlepage-env` + `pg.textpos` blocks with the coordinates for the chosen point size; cleanup `\global\let` lines dropped |
| `\frontmatter` `\mainmatter` `\backmatter` | woosterthesis.cls:456-489 | yes | kernel page-number and page-style commands (see map) |
| `\ps@headings` by `\@oddhead` | woosterthesis.cls:173-227 | yes | `hf.fancyhdr` fields |
| `\@part` `\@spart` | woosterthesis.cls:494-522 | yes | `head.titlesec` |
| `\tableofcontents` `\listoffigures` `\listoftables`, `\l@chapter`..`\l@subparagraph`, `\@tocheadline` | woosterthesis.cls:664-713 | yes | `toc.tocloft` indents and an `\addtocontents` header line |
| `\lstlistoflistings` wrapper | woosterthesis.cls:926-959 | yes | `code.listings` + `toc.kernel` list with the title string |
| `theindex` redefinition | woosterthesis.cls:880-897 | yes | `idx.makeidx` + `cols.twocolumn-cmd` |
| footnote macros | woosterthesis.cls:1141-1166 | yes | see map |
| `\today` | woosterthesis.cls:158-163 | yes | `front.datetime` or literal date |
| `description` env, `\descriptionlabel` | woosterthesis.cls:768-773 | yes | `list.enumitem` |
| `\dedication`, `acknowl`, `colophon`, `vita`, `datelist`, `publist`, `fieldsstudy`, `studieslist` (self-clearing `\studn@me` first-row label) | woosterthesis.cls:776-836 | yes | unnumbered chapters and kernel lists; the first-row "Studies in:" is written literally (commented out at main.tex:225-227) |
| option flags (`\newif`), `ifthen` booleans, `\AtBeginDocument` advisor check | woosterthesis.cls:13-48, 753-758; main.tex:143,315,331 | yes | resolved statically from the chosen options; the check only raises an error |
| copyright and logo macros | woosterthesis.cls:1086-1138 | yes | `front.dedication`, `fig.graphicx` |
| personal macros `\lt` `\msw` `\xt` `\fl` `\mbd` `\bvec` `\degree` `\qrfac` `\ip` `\ic` `\ie` | styles/personal.tex:12-15,35-55,69 | yes | inline expansion |
| `unnumft` counter and environment, `wooexample` | styles/personal.tex:83-89 | partly | `unnumft` reduces to `fn.kernel` + `num.counters`; neither is used in the sample; `wooexample` wraps `example` and inherits the blocker |
| manual macros `\bs` `\cih` `\ci` `\pai` `\ei` `\wi` `\X` `\W` `\Y` `\demowidth`, `symbols` `command` `lined` env | styles/lshortwooster.sty:34-100,127,196-198 | yes | expansion into `tbl.tabular`, `sp.rule`, `idx.makeidx` |
| `\cleardoublepage` redefinition | styles/lshortwooster.sty:201-203 | yes | `pg.emptypage` |
| boxed definition `boxeddefn` | styles/theorems.tex:67-70 | yes | `box.fancybox` + `box.minipage` (unused) |
| theorem styles and counters | styles/theorems.tex:21-63 | yes | `thm.amsthm` |
| option `maple` loads `maple2e` | woosterthesis.cls:901-903 | not assessed | package ships with Maple software, not read, not on the sample's path |

## Content-opaque
- TikZ pictures inside figures: chapters/chapter2.tex:79-96 (tree diagram), 111-118 (intersecting lines)
- Included images in figures (picture1 to picture3, scottie, wblack, woostercopyright): chapters/chapter2.tex:22,48,173,179; appendices/options.tex:8,14,29
- Source code listings read from source/*.java and source/*.cpp (appendices/java.tex:39-48, appendices/cpp.tex:17-25)
- The mathematics tables of appendices/math.tex:719-1040 and the references.bib entries are content

## Lib changes
- New ways proposed: none. Considered and not proposed: `code.tcblisting` as a stand-in for the `example` environment (not accepted as a reduction); `xltxtra` (load-only XeLaTeX extra, no printed effect in the pdfLaTeX path).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
