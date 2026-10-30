no

# 0848-elsevier-book: Elsevier Book (elsevierbook class family, models a02 / a08a / p04)

- Unverified: read from the source, not compiled.
- Source: Source/0848-elsevier-book/ (origin: https://latextemplates.com/downloads/elsevier-book.zip; licence: LPPL-1.3c)
- Kind: book
- Lib: v6
- Engine: pdfLaTeX-compatible (newtx, fbb/cabin/zi4 and FiraSans are Type 1 packages; no fontspec, no Lua)
- Look carried by: zip-local (the look is in sty/elsevierbook-a02.cls, sty/elsevierbook-a08a.cls and sty/elsevierbook-p04.cls; main.tex only picks a model and loads natbib)
- Class origin: zip-local (ctan.org/pkg/elsevierbook and ctan.org/pkg/elsevier-book both returned 404; the zip is a latextemplates.com repackaging whose README calls the class files "upstream", so it is not an official release by Origin)
- Main file: main.tex (other samples: none; it `\include`s titlepage, dedication, tableofcontents, preface, aboutauthors, part1, chapter1, chapter2, appendix01, appendix02 at main.tex:42-57; contributors.tex, listoffigures.tex, part.tex, references.tex are optional and not included)
- Read: main yes (main.tex and the other 14 .tex files, included or optional), zip-local classes and styles all (elsevierbook.cls, and a02, a08a, p04 line by line)

Paths below are relative to Source/0848-elsevier-book/. `a02`, `a08a`, `p04` mean sty/elsevierbook-a02.cls, sty/elsevierbook-a08a.cls, sty/elsevierbook-p04.cls. The default model is a02 (sty/elsevierbook.cls:15, main.tex:11); the other two are selected by the options at main.tex:12-14, so all three are in scope.

## Verdict
No. The wrapper class `elsevierbook` is zip-local and not published, and under all three models it carries hand-written typesetting machinery that no lib way expresses: the `aug` author and address engine with its counters, list-assessment macros and `\ifnum` separator logic (a02:211-416, same code in a08a:314-519 and p04:251-456), the `\removeDot` recursion and `\bibinfo` dispatch macros for Elsevier BibTeX markup (a02:843-865, 956-963), and a replacement of minitoc's internal `\mtc@verse` (a02:1055-1069). Model a08a also draws a TikZ arrow into every chapter, part and section heading (a08a:150-193), which is template-defining artwork. Most of the rest (titlesec headings, enumitem lists, caption, mdframed boxes, geometry, footmisc) reduces cleanly to lib ways, and no new way is needed.

## Blockers
- `BESPOKE/class` `aug` environment: author and address printing engine, counters `aug` `fadauthor` `fadaddress` `addresslabel` `addrtemp` `augtemp`, `\setbox\@tempboxa=\vbox\bgroup` capture, `\listgadd`/`\dolistloop` loops, `\csvlistassess`/`\listassess` that build `\ref{<aug>.addressid.<id>}` marks, per-author separator chosen by `\ifnum` on position, `\@footnotemark` intercepted and merged into the author superscripts (a02:211-416; a08a:314-519; p04:251-456). The sample uses it at chapter2.tex:7-17.
- `BESPOKE/class` bibliography markup macros `\bibinfo` (an `\ifx` chain on `pages`/`author`/`year`/`volume`), `\xfnm`, and the recursive `\removeDot`/`\@removeDot` (`\@car`/`\@cdr` character stripping); they appear meant for Elsevier `.bst` output that is not shipped, so that purpose is inferred (a02:843-865, 878-914, 936-955, 956-963; a08a:972-994, 1007-1043, 1085-1092; p04:916-938, 951-987, 1029-1036).
- `BESPOKE/class` minitoc internals patched: `\mtc@verse` and `\endmtc@verse` replaced by a `multicols` version with `\setcounter{collectmore}{-1}` (a02:1055-1069), `\preto\minitoc{\setcounter{mtc}{\number\c@chapter}}` (a02:1029), `\global\@mtc@lof@used@true` in `\listoffigures` (a02:1071); p04 also replaces `\minitoc@dottedtocline` (p04:1113-1129).
- `BESPOKE/class` (model a08a only) after-heading indent hack: `\@afterheading` replaced by `\@afterheadingwithindent` with `\everypar`, `\lastbox` removal, toggle `sectionbefore` that adds `\vskip1pc` before the next subsection (a08a:217-267).
- `ART/class` (model a08a only) `\charrow`: a six-coordinate TikZ polygon (`\draw[...] (A)--(B)--(C)--(D)--(E)--(F)--cycle`) used by `\chapterrule`, `\partrule` and `\sectionrule`, so it opens every chapter, part and numbered section heading (a08a:150-164, 165-193, 240-250; `\nosectionrule` switches the section one off at a08a:918-924). No declarative lib way.

Not blockers, recorded: the `\AfterPackage{index}` block runs `\immediate\write18{makeindex \jobname}` from `\AtEndPreamble` (a02:1266-1306; a08a:1379-1419; p04:1368-1408). It only fires if the document loads the `index` package; main.tex does not, so it is a conditional `EXTERNAL/package` and not counted. Elsevier `.bst` files named at main.tex:80-123 (`../bst/elsarticle-num`, vancouver, ama, saunders, acs...) and the `img/` path at main.tex:5 are not shipped (missing assets); the sample prints no bibliography (main.tex:67 is commented, references.tex is a bare `thebibliography`, references.tex:6-11).

## Class setting
- Class: `class.book` (loaded by the zip-local model class: a02:17, a08a:18, p04:17; options are passed to `book` by `\DeclareOption*`, a02:15; a08a first passes `11pt`, a08a:15). The zip-local selector `elsevierbook` maps option `a02`/`a08a`/`p04` to the model class and loads it (sty/elsevierbook.cls:15-21). No class options are used in main.tex (main.tex:11).
- Class-native vocabulary used (all zip-local, defined in the model classes): `\Frontmatter` `\Mainmatter` `\Backmatter` (main.tex:41,50,59; a02:81-111), `frontmatter` environment around each chapter opener (chapter1.tex:1-20; a02:93-107), `\subchapter` (chapter1.tex:4; a02:137), `titlepage` environment with `titlepagerule` and `\title` `\edition` `\author` `\address` (titlepage.tex:2-18; a02:965-998), `dedication` (dedication.tex:2-6; a02:1010), `abstract` and `keywords` with `\kwd` (chapter1.tex:8-18; a02:435-467), `aug` with `\author[addressrefs={..}]{\fnm{} \snm{}}` and `\address[id=..]{}` (chapter2.tex:7-17; a02:211-230, 355-379, 383-397), `chapterpoints` (chapter2.tex:23-31; a02:570), `dispquote` with `\source` (chapter2.tex:33-45; a02:548), `\source` (preface.tex:20-25; a02:1221), `biography` (aboutauthors.tex:5-14; a02:1019), `contributorslist` with `\name` (contributors.tex:6-28; a02:595), `textbox` with styles BtypeA/BtypeB (a02:1236-1259), `tabnotes` `\tabnotetext` `\tabnoteref` `\legend` (a02:639-702), `ack`/`acks` (a02:801-816), `\minitoc` (chapter1.tex:6, commented).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:11-14; sty/elsevierbook.cls:15-21; a02:17 | `class.book` | no options (a08a adds `11pt`, a08a:15); model option `a02`/`a08a`/`p04` chooses one of three zip-local classes |
| page geometry | a02:69-76; a08a:72-79; p04:71-79 | `page.geometry` | a02 `total={6in,9in}`, `body={111.5mm,185.6mm}`, `head=10pt`, `centering`; a08a `body={27pc,43pc+8pt}`; p04 `total={7.5in,9.25in}`, `body={118.71mm,185.649mm}`, `head=22pt`, `headsep=2pc`, `centering` |
| margin note lengths | p04:83-84 | `page.setlength` | `\marginparsep=1pc`, `\marginparwidth=9pc` |
| encoding | a02:59-60 | `font.fontenc-t1` | `[T1]{fontenc}`, `[full]{textcomp}` |
| text and math face | a02:61,63; p04:61,65 | `font.newtx` | `newtxtext`; `newtxmath[varvw]` |
| text and math face, model a08a | a08a:62,66 | `font.serif-pkg`, `font.newtx` | `fbb[lining,proportional]`; `newtxmath[libertine,bigdelims]` |
| sans face | a08a:63; p04:62 | `font.helvet` | `cabin[scale=.95,type1]`; `FiraSans[type1,lining]` (a02 has no sans package, `\sffamily` is the default sans) |
| mono face | a08a:64; p04:63; a02:62 | `font.mono`, `font.size-commands` | `zi4[varqu,varl]` (inconsolata); `verbatim@font` = `\ttfamily\fontsize{8}{10}` |
| maths packages | a02:65; a02:67 | `math.amsmath`, `math.amssymb`, `thm.amsthm` | `amsmath,amssymb,amsfonts`; `amsthm` loaded, no theorem declared, `\mdfsetup{theoremseparator=,theoremspace=\space\space}` at a02:1260-1264 sets mdframed theorem keys only |
| paragraph and list lengths | a02:18-26, 78-79 | `sp.lengths` | `\parindent=14pt` (a08a 15pt, a08a:81), `\parskip=0pt plus0.1pt`, `\@listi` parsep/topsep/itemsep values (a02:21-23) |
| main-matter switches | a02:81-92; main.tex:41,50,59 | `pgnum.pagenumbering`, `pg.break`, `toc.kernel` | `\pagenumbering{roman}`; `\cleardoublepage` + `\pagenumbering{arabic}` + `\setcounter{page}{1}` + `\addtocontents{toc}{\addvspace{1pc}}`; `\Backmatter` only `\let\bibsection\relax` (a02:108-111) |
| chapter opener wrapper | a02:93-107; chapter1.tex:1-20 | `pg.break`, `sp.manual-space` | `frontmatter` env = `\cleardoublepage` at start, `\par` + `\addvspace{5.292mm}` at end, first paragraph unindented |
| blank page before a part or chapter | a02:80 | `pg.emptypage` | `\patchcmd\cleardoublepage{\hbox}{\thispagestyle{empty}\hbox}` is what `emptypage` does |
| part, chapter heading | a02:114-124, 147-158 | `head.titlesec` | `\titleformat{\part}[display]` sffamily 20pt, label `\partname\ \thepart`, sep 30pt, title 26/28 bold; chapter `[display]` sffamily 15pt `\raggedright`, label `\chaptertitlename\ \thechapter`, sep 30pt, title 22/24 bold; `\titlespacing*{\chapter}{0pt}{0pt}{20pt}`; `\titleclass{..}{straight}` |
| section to subparagraph headings | a02:163-210 | `head.titlesec` | e.g. section sffamily bold 11/13, `\thesection`, sep 1em, spacing 5.292mm/2.117mm; subsection 10/13; subsubsection sffamily italic 10.5/12; paragraph 10/12; subparagraph sffamily bold italic 10/12 |
| heading depth, extra level | a02:159-162 | `num.secnumdepth`, `num.counters`, `head.titlesec` | `secnumdepth=6`; `\newcounter{subsubparagraph}`, `\thesubsubparagraph`; `\titleclass{\subsubparagraph}{straight}[\subparagraph]` |
| heading variants (model a08a) | a08a:195-212, 260-267, 296-313 | `head.titlesec`, `mark.case`, `mark.numspell` | chapter label `\MakeUppercase{\chaptertitlename}\ \NUMBERstring{chapter}` (fmtcount, same type as `numspell`); section `[block]` with `\MakeUppercase` shape; the TikZ rule and the `\@afterheading` hack are blockers above |
| heading variants (model p04) | p04:121-137, 172-187, 202-250 | `head.titlesec`, `sp.rule`, `color.xcolor`, `box.stackengine` | `\titleformat{\chapter}[block]` with `\rlap{\hskip290pt\rlap{\color{black}\rule[-8pt]{178pt}{24pt}}...}` black label bar and a 84pt chapter number in `\smash{\vtop to40pt{..}}`; `\titlerule`; run-in `subparagraph` with `\periodafter` |
| subchapter line | a02:126-146 | `font.size-commands`, `sp.manual-space` | `\sffamily\Large` after `\vskip-\chapterpostskip` + `\vskip.26\baselineskip`, then `\addvspace{\chapterpostskip}` |
| running heads and feet | a02:782-798, 1020-1027 | `hf.fancyhdr` | even head: page number (bold sans), `\quad`, `\leftmark`; odd head: `\rightmark`, `\quad`, page number; plain style: number in the foot; `\headsize` sans 8.5/10; marks from `\chaptermark`/`\partmark` with `\color{black!30}` label (a08a:899-916 head 9/9; p04:827-871 rule tabs, below) |
| p04 page-number tabs | p04:827-847 | `hf.fancyhdr`, `sp.rule`, `box.stackengine` | `\rule[12pt]{10pc}{8.5pt}` and `\rule[12pt]{\hsize}{1pt}` placed by `\rlap`/`\llap`/`\hskip` in the head fields |
| title page | titlepage.tex:2-18; a02:965-998 | `front.titlepage-env`, `sp.rule`, `font.size-commands`, `sp.manual-space` | kernel `titlepage` env; title `\sffamily\bfseries\fontsize{30pt}{34pt}` after `\vskip4\baselineskip`; rule `\hrule height5.55pt` + `\vskip4pc`; subtitle sffamily 16/18; author `\bfseries\Large`; `\edition`, `\editedby`, `\volume`, `\address` fields |
| volume number (a08a) | a08a:1131 | `mark.numspell` | `VOLUME \NUMBERstringnum{#1}` (fmtcount) |
| dedication | dedication.tex:2-6; a02:999-1018 | `front.dedication` | `\clearpage`, `center`, `\sffamily\bfseries\large`, head "Dedication" `\Large`, `\vskip4pc`/`\vskip3pc`; p04 `\cleardoublepage` + italic (p04:1076-1092) |
| contents page | tableofcontents.tex:2-6; a02:1070 | `toc.kernel` | `\chapter*{Contents}` inside `frontmatter`, then `\tableofcontents` redefined to `\@starttoc{toc}` |
| contents entry layout | a02:1086-1220 | `toc.titletoc` | per level shape (chapter sans bold 11/13, section bold 9/11, subsection 9/11), indent `\tocchapterindent=0pc`, number widths 1pc/2pc/2pc/3.5em, page number `\pnumshape` sans 9/11, `\@dotsep=1000` (dots effectively off), part entry `\tocpartshape` 13/15; p04 chapter number width 6pc, `CHAPTER`/`APPENDIX` word (p04:1176-1198, 1254-1256) |
| list of figures | listoffigures.tex:2-5 | `toc.kernel` | `\chapter*{List of Figures}`, `\listoffigures` (not included, main.tex:45 commented) |
| chapter contents | chapter1.tex:6; a02:1028-1069 | `toc.etoc` | `minitoc[tight]`; `\mtcsettitle{minitoc}{Contents}`, `\mtcsetrules{minitoc}{off}`, `\setcounter{minitocdepth}{3}`; two-column body via `multicols` is the blocker above |
| abstract | chapter1.tex:8-12; a02:417-446 | `abs.kernel`, `sp.rule`, `mark.case`, `font.size-commands` | `\newenvironment{abstract}`: `\hrule height.5pt` above and below, head `\MakeUppercase{Abstract}` `\small\bfseries\sffamily`, body `\small` (a08a:520-557 uses a `list` and `\sffamily\footnotesize`) |
| keywords | chapter1.tex:14-18; a02:447-467 | `abs.keywords` | head `\MakeUppercase{Keywords}`, `\kwd{..}` items joined by `,\space` |
| authors and addresses | chapter2.tex:7-17; a02:211-416 | none (blocker `BESPOKE/class`) | considered `front.authblk`: not equivalent, see Bespoke code |
| lists | a02:468-488 | `list.enumitem` | `\setlist{topsep=0pt,labelsep=6pt,noitemsep,leftmargin=*,itemindent=0pt}`; itemize[1] `label=\ensuremath{\bullet},topsep=4pt`; enumerate[1] `label=\arabic*.,font=\sffamily\textbf`; enumerate[2] `\alph*.`; level 3 `label={-}`; description `labelindent=0pt,labelsep=6pt,itemindent=-6pt,leftmargin=!` |
| chapter points | chapter2.tex:23-31; a02:566-582 | `list.enumitem` | `\newlist{chapterpointslist}{itemize}{1}`, `label=\ensuremath{\bullet},topsep=6pt,leftmargin=20pt,rightmargin=12pt`; head item "Chapter Points" bold 10/12, sans 8.5/10 |
| contributors list | contributors.tex:6-28; a02:583-599 | `list.enumitem` | `\newlist{contributorslist}{description}{1}`, `itemindent=-6pt,labelsep=.5em,itemsep=\smallskipamount,leftmargin=!`, `before*={\let\name\contributorname}` |
| quotes | a02:489-543, 544-565; chapter2.tex:33-45 | `quote.kernel`, `sp.ragged`, `sp.manual-space` | `quote`/`quotation` as `list` with `leftmargin=4mm`, `rightmargin=4mm`, `topsep=2.117mm`, `\fontsize{9}{11}\itshape\color{black!80}`; `dispquote` leftmargin 4mm, font 9/12 italic; `\source` right-aligned line, 9/11, `\vskip4pt` above |
| biography, source line, acknowledgements | aboutauthors.tex:5-14; a02:1019, 1221-1233, 799-816 | `sp.manual-space`, `sp.ragged`, `head.titlesec` | `biography` = `\par`; `\source` = `\vskip1pc` + `flushright`; `ack` = `\section*{Acknowledgement}` + `\fontsize{8.5}{10}` |
| appendices | main.tex:55-57; appendix01.tex:2 | `num.appendix` | kernel `\appendix`; `\chapter{Appendix title}` inside `frontmatter`; p04 also writes `\let\tocchaptername\tocappendixname` to the toc (p04:1178-1187) |
| footnotes | chapter2.tex:4; a02:766-769 | `fn.footmisc`, `fn.kernel`, `sp.rule`, `sp.lengths` | `footmisc[hang,bottom,stable]`, `\footnotemargin=1em` (p04 0em, p04:813), `\footnoterule` = `\kern-3pt\hrule height.5pt\kern2.6pt`, `\skip\footins=1pc` |
| captions | a02:600-638 | `cap.caption` | `\captionsetup[figure]{labelsep=quad,labelfont={bf,sf},font=footnotesize,name=FIGURE}`; `[table]{labelsep=space,labelfont={bf,sf},font={small,sf},name=TABLE,margin=\tabcolsep,skip=2.6pt}`; `\DeclareCaptionLabelSeparator`, `\DeclareCaptionFont` (a08a:740-755, p04:658-673 differ by values) |
| float title in label | a02:605-616, 635-638 | `cap.caption` | `\title{..}` inside a float stored for `\fnum@figure`/`\fnum@table`; reduces to a caption label format |
| float graphics | a02:30 | `fig.graphicx` | `graphicx` loaded; no figure in the sample (chapter1.tex:25-29 is commented) |
| tables | a02:720-765, 703-729 | `tbl.colortbl`, `box.mdframed`, `tbl.tabular` | `\arrayrulewidth=.5pt`, `\doublerulesep=0pt`, `\minrowclearance=2pt`, `\Hline`=`\hline\hline\hline`, `thd` gray .65, `tableframe` = `mdframed` style `table-a02` (`backgroundcolor=black!10`, inner margins 0pt/5pt/10pt, `linewidth=0pt`); header fonts `\tch` 8.5/12 bold; no table in the sample (chapter1.tex:31-35 commented) |
| table notes | a02:639-702 | `tbl.threeparttable`, `xref.kernel`, `box.minipage` | note lines as `\parbox` of width `\tablewidth-2\tabcolsep`, italic text, mark via `\label`/`\ref`; `\legend`, `\tablesource` = `Source:` line |
| text boxes | a02:1235-1265 | `box.mdframed` | `\newmdenv{textbox}`; BtypeA `hidealllines=true,backgroundcolor=black!10,innertopmargin=4pt,innerbottommargin=10pt,innerleftmargin=10pt,innerrightmargin=10pt,frametitleaboveskip=10pt`, font 8.5/10 sans; BtypeB `linewidth=.5pt` with a title rule `\rule[-5pt]{\linewidth}{.75pt}`; a08a adds `roundcorner=10pt` (a08a:1347-1378); p04 `\boxrule` (p04:1337-1367) |
| colours | a02:31, 720, 1309; a08a:150-151 | `color.xcolor` | `\definecolor{thd}{gray}{.65}`, `linkcolor` rgb 0,.502,.675, `\colorlet{charrowfillcolor}{gray!25}` |
| bibliography | main.tex:19; a02:817-822 | `bib.natbib` | `\usepackage{natbib}`; `\bibsection=\section*{\bibname}`, `\bibfont` 8/11, `\bibhang=10pt`, `\bibsep=0pt plus.1pt` |
| citation presets | a02:823-955; main.tex:20-30 | `bib.natbib` | `\bibstyle@elsarticle-num` = `\bibpunct{[}{]}{,}{n}{}{,}` + sort&compress; `-harv` round and semicolon; `ama`, `vancouver-super`, `acs-*` superscript or numeric (the `\citestyle` lines in main.tex are commented) |
| BibTeX styles | main.tex:80-123 | `bib.bibtex-bst` | commented `\bibliographystyle{elsarticle-num|vancouver|ama|saunders|acs...}`; the `.bst` files are not shipped |
| hand-written bibliography | references.tex:6-11 | `bib.thebibliography` | `thebibliography{10}` with no entries (not included) |
| index | aboutauthors.tex:9; a02:1266-1306 | `idx.makeidx` | `\index{index}` only; the `index` package block is conditional (see Blockers, not counted) |
| hyperlinks | a02:1307-1322 | `meta.hyperref` | after `hyperref` is loaded: `colorlinks=true,bookmarksnumbered=true,allcolors=linkcolor,breaklinks=true,setpagesize=false,unicode=true`; `\providecommand{\href}[2]{{#2}}` (a02:964) |
| cross references | chapter1.tex:3,23; part1.tex:2 | `xref.kernel` | `\label{chap1}`, `\label{sec1}`, `\label{part1}` |
| file inclusion | main.tex:42-57 | `struct.input` | `\include{..}` per front, main and appendix file; `\includeonly` commented at main.tex:38 |
| other packages loaded | a02:27-35, 1031 | `cols.multicol` | `etoolbox`, `calc`, `afterpackage`, `graphicx`, `xcolor`, `colortbl`, `fmtcount`, `tikz`, `textcase`, `multicol` (`tikz` only backs `mdframed[framemethod=tikz]` in a02 and p04) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| model selector `elsevierbook` | sty/elsevierbook.cls:15-21 | yes | emit the chosen model class's content; no printed effect of its own |
| `\csdef{input@path}{{sty/},{img/}}` | main.tex:1-8 | yes | file search path with no printed effect; ship the class at the root or set the path |
| `\metamacro` family and title-page hooks | a02:38-58, 965-998 | yes | each field = group, preskip, format, postskip, posthook; inline into `front.titlepage-env` with `font.size-commands` and `sp.manual-space` |
| `\@listi` redefinition | a02:18-26 | yes | `sp.lengths` (parsep, topsep, itemsep) |
| `frontmatter` env, `\Frontmatter` `\Mainmatter` `\Backmatter` | a02:81-111 | yes | `pg.break` + `pgnum.pagenumbering` + `sp.manual-space`, `\noindent` on the first paragraph |
| `\patchcmd\cleardoublepage` | a02:80 | yes | `pg.emptypage` |
| `\subchapter` | a02:126-146 | yes | `font.size-commands` + `sp.manual-space` |
| `aug`, `\author[addressrefs]`, `\address[id]`, `\fnm` `\snm` | a02:211-416; a08a:314-519; p04:251-456 | no | `front.authblk` considered: its `\author[1,2]` marks are positional while here marks resolve by `\ref` to labels created during address printing; separators (comma, "and") are chosen by `\ifnum` on position; author footnote marks are captured by redefining `\@footnotemark` and merged into the same superscripts; `\addressnolabel` conditional. Printed output depends on this macro logic, so no declarative composition |
| `abstract`, `keywords`, `\kwd`, `\kwdsep` | a02:417-467 | yes | environment of `sp.rule` + `mark.case` + font switches; `\kwdsep` first-item trick = a comma-joined string |
| quote, quotation, `dispquote`, `\source`, `\quotesource` | a02:489-565 | yes | `list` parameters (`sp.lengths`) + `\raggedleft`/`\hfill` attribution line |
| `chapterpoints`, `contributorslist`, `\contributorname`, `\listtitle` | a02:566-599, 583-595 | yes | `list.enumitem` `\newlist` with keys; a08a/p04 title line is a bold `\hbox` + empty `\item[]` |
| float `\title`, `\fnum@figure`, `\fnum@table` | a02:605-638 | yes | caption label format of `cap.caption`; the title can be folded into the label string |
| `tabnotes`, `\tabnotetext`, `\tabnoteref`, `\legend`, `\tablesource` | a02:639-702 | yes | `tbl.threeparttable` note lines with `\parbox`; mark reprint is content |
| `tableframe`, `\Hline`, `\tch` | a02:720-765 | yes | `box.mdframed` style + `tbl.colortbl` `\arrayrulecolor`, `\hline` repeats, bold 8.5/12 header |
| `\book@dottedtocline`, `\l@*`, `\tocsetup` keys | a02:1070-1220 | yes | `toc.titletoc` `\titlecontents` per level (indent, number width, shape, leaders, page-number font); `\tocsetup` only sets lengths |
| minitoc internal patches | a02:1029, 1055-1072; p04:1113-1129 | no | replaces `\mtc@verse`, writes the internal counter `mtc`, sets `\@mtc@lof@used@true`: edits a package's code, not options |
| `\bibinfo`, `\xfnm`, `\removeDot`, `\@removeDot` | a02:843-865, 878-914, 936-955, 956-963 | no | recursive character stripping and `\ifx` dispatch over `\bibinfo{field}{value}` markup; hand-written macro logic |
| `\bibstyle@*` presets (`\bibpunct` part) | a02:823-955 | yes | `bib.natbib` `\bibpunct` plus package options `numbers`, `sort&compress`, `super`, `round`, `semicolon`; the `\NAT@*` internal assignments (sort, cmprs, spacechar) have no option |
| `\ps@headings`, `\ps@plain`, `\chaptermark`, `\partmark` | a02:782-798, 1021-1027 | yes | `hf.fancyhdr` fields and mark commands |
| p04 rule bars, side tabs, `\boxrule` | p04:121-137, 172-187, 827-847, 1362 | yes (borderline) | fixed-size coloured `\rule` placed by `\rlap`/`\llap`/`\hskip`: `sp.rule` + `color.xcolor` + `box.stackengine` overlay; `\rlap` and `\smash` are not named by the lib, so this stretches `sp.manual-space` |
| p04 `\appto\appendix` aux write | p04:1178-1187 | yes | `\addtocontents{toc}{\let\tocchaptername\tocappendixname}` (`toc.kernel`) |
| a08a `\@afterheadingwithindent`, toggle `sectionbefore` | a08a:217-267 | no | `\everypar` and `\lastbox` surgery on the kernel heading hook that conditionally adds space; code that drives layout |
| a08a `\charrow`, `\chapterrule`, `\partrule`, `\sectionrule` | a08a:150-193, 240-250 | no | TikZ artwork (`ART`), no declarative lib way |
| `\AfterPackage{index}` with `\write18{makeindex}` | a02:1266-1306 | no | `EXTERNAL` when `index` is loaded; sample does not load it |
| `\AfterPackage{hyperref}` hypersetup | a02:1307-1322 | yes | `meta.hyperref` keys |
| `eqnarray` error stubs, `\let\Bbbk\relax`, `\let\openbox\relax` | a02:770-781, 64, 66 | yes | no printed effect; omit (load-order and policy fixes) |
| `\ExplSyntaxOn` | a02:1126; a08a:1238; p04:1227 | yes | catcode switch before plain `\def`s; no `\ExplSyntaxOff` found in the three files (grep), no expl3 layout code seen |

## Content-opaque
none (the sample has no figure or table; figure and table skeletons at chapter1.tex:25-35 are commented out)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
