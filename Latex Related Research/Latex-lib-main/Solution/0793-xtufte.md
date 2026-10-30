no

# 0793-xtufte: xtufte (Tufte-style book and handout classes for LuaLaTeX/XeLaTeX)

- Unverified: read from the source, not compiled.
- Source: Source/0793-xtufte/ (origin: https://mirrors.ctan.org/macros/unicodetex/latex/xtufte.zip; licence: LPPL 1.3, the tufte-latex original is Apache 2.0, README:1-3)
- Kind: book
- Lib: v6
- Engine: needs LuaLaTeX (the class aborts under pdfTeX, xtufte-common.def:20-27; `fontspec` OpenType setup and `unicode-math`, xtufte-common.def:287-347; sample header `%! HV lualatex`, doc/sample-book.tex:1; the CTAN page names LuaLaTeX and only hopes for XeLaTeX)
- Look carried by: mixed (the class carries geometry, fonts, headings, running heads, contents, sidenotes and margin floats; the sample preamble adds the epigraph, blank-page and documentation macros, all reducible)
- Class origin: ctan (the zip is the CTAN package xtufte v0.03 of 2025-11-27: ctan.org/pkg/xtufte read, latex/xtufte-book.cls:5)
- Main file: doc/sample-book.tex (other samples: doc/sample-handout.tex)
- Read: main yes, zip-local classes and styles all

## Verdict
`no`, because of one blocker. The sample loads `minted-code` (CTAN, "environments for typesetting LaTeX code with minted", its source is not in the zip and was not read) in its hook file and uses its `codeblock` environment four times; that is `code.minted`, which needs Pygments, so it is `EXTERNAL/package`. The class is a published CTAN class (`class.xtufte-book`), so its kernel-level redefinitions are covered by the class way and are not counted as zip-local bespoke code; every other component maps to a lib way and the sample's own macros reduce by expansion. No new way is needed and there is no `ART`.

## Blockers
- `EXTERNAL/package` `minted-code` `codeblock` environment (title= and colback= keys) needs minted's Pygments pass: loaded doc/sample-book.tex:19 and doc/sample-handout.tex:19, used doc/sample-book.tex:595, 617, 653, 1205 (the package source is not in the zip; the CTAN page says it is built for minted)

## Class setting
- Class: `class.xtufte-book` options: `sidenote=raggedright, marginnote=raggedright, caption=raggedright, marginals=raggedright, origFonts, natbib=false, hyperref` (doc/sample-book.tex:27-34). `natbib=false` is not a declared option (the class has `nobib`), so it falls to the catch-all that passes it on to `book` (latex/xtufte-common.def:268-271). Defaults not overridden: letterpaper, one-side, the Tufte contents design on (`toc`, 124-127), `justified` off (133-134). The `titlepage` default compares the class name with `tufte-book` (xtufte-common.def:263-265) while the class is named `xtufte-book` (xtufte-book.cls:25), so by reading the default is `notitlepage`, a title block and not the full title page the sample comment expects.
- Class-native vocabulary used: `\frontmatter` `\mainmatter` `\backmatter` (xtufte-book.cls:40, 53, 70); `\title[plain]{}` `\author[plain]{}` `\publisher{}` `\thanklessauthor` `\thanklesspublisher` (xtufte-common.def:596, 612, 639, 585-587); `\maketitle` (1463); `\newthought` (702); `\sidenote[n][offset]{}` and `\footnote` as sidenote (1000-1001); `\marginnote[offset]{}` (1006); `\margincite{}` (1944); `marginfigure` `margintable` (1048, 1056); `figure*` `table*` (1277, 1285); `fullwidth` (1293); `\caption[short][offset]{}` (1128); `\setfloatalignment` (1103); `\allcaps` `\smallcaps` redefined `\textsc` (693-698); `\nohyphenation` (1665); `\tableofcontents` `\listoffigures` `\listoftables` (1577-1654); `theindex` with `\printindex` (1689); `\setsidenotefont` and siblings (497-500, documented only).
- Assets not shipped: with `origFonts` the LuaLaTeX branch loads the commercial Bembo Book MT Pro and Gill Sans MT Pro `.otf` files (xtufte-common.def:302-325); without it, KpRoman and KpSans (328-343, TeX Live kpfonts-otf). `\setmathfont{KpMath-Sans.otf}` and `juliamono` (345-347) are TeX Live fonts. `hardwrap` (xtufte-common.def:41) is not in the zip; it is on CTAN and in TeX Live (ctan.org/pkg/hardwrap read).
- Second class in the zip, not used by the main sample: `class.xtufte-handout` (latex/xtufte-handout.cls:22-30), adds only `abstract` as a `quotation` (xtufte-handout.cls:39-41); sample-handout.tex:22 uses it with `debug=false,origFonts` and the same hook file plus `units`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/sample-book.tex:27-34 | `class.xtufte-book` | options above; loads `book` (xtufte-book.cls:22, xtufte-common.def:277) |
| page geometry | xtufte-common.def:466, 476-478 | `page.geometry` | letterpaper, left=1in, top=1in, headsep=2\baselineskip, textwidth=26pc, marginparsep=2pc, marginparwidth=12pc, textheight=44\baselineskip, headheight=\baselineskip, asymmetric (a4paper and b5paper variants at 468-474 not used) |
| margin push | xtufte-common.def:483 | `page.setlength` | `\marginparpush`=10pt |
| main, sans text faces | xtufte-common.def:295, 302-325, doc/sample-book.tex:32 | `font.fontspec` | `\setmainfont{BemboBookMTPro}[Extension=.otf,UprightFont=*-Regular,ItalicFont=*-Italic,BoldItalicFont=*-BoldIt,BoldFont=*-Bold]`, `\setsansfont{GillSansMTPro}[Extension=.otf,Scale=MatchUppercase,UprightFont=*-Medium,ItalicFont=*-MediumItalic,BoldItalicFont=*-BoldItalic,BoldFont=*-Bold]` |
| maths face | xtufte-common.def:288-289, 345 | `font.unicode-math` | `\setmathfont{KpMath-Sans.otf}`, `mathtools` loaded beside it (`math.mathtools`) |
| default family | xtufte-common.def:346 | `font.family-default` | `\AtBeginDocument{\renewcommand\familydefault{\sfdefault}}` |
| monospace face | xtufte-common.def:347 | `font.mono` | `juliamono` with Scale=MatchLowercase |
| font sizes | xtufte-common.def:388-425 | `font.size-commands` | normalsize 10/14, small 9/12, footnotesize 8/10, large 11/15, Large 12/16, LARGE 14/18, huge 20/30, Huge 24/36 |
| list indents | xtufte-common.def:427-435 | `sp.lengths` | `\leftmargini`..`\leftmarginvi`=1pc, `\labelsep`=.5pc |
| compact lists | xtufte-common.def:653-665 | `list.paralist` | `paralist` loaded; `compactenum` gets rightmargin 2em |
| description label | xtufte-common.def:737, doc/sample-book.tex:932-946 | `list.kernel` | `\descriptionlabel` italic; `description` and `itemize` used |
| paragraph shape | xtufte-common.def:440-452 | `sp.lengths` | parindent 1pc, parskip 0pt; margin text parindent 0.5pc (455-460) |
| ragged text | xtufte-common.def:442-443, 505-509, 1390 | `sp.ragged` | `\RaggedRight` with `\RaggedRightRightskip`=0pt plus 0.08\hsize (`ragged2e`) |
| display skips | xtufte-common.def:519-520 | `sp.lengths` | `\abovedisplayskip`, `\belowdisplayskip`=6pt plus 2pt minus 4pt |
| quote, verse | xtufte-common.def:710-732 | `quote.kernel` | `quote`, `quotation`, `verse` redefined at `\small` |
| double spacing | xtufte-common.def:743, doc/sample-book.tex:91, 228 | `sp.setspace` | `doublespace` environment |
| no-hyphenation switch | xtufte-common.def:1661-1667, doc/sample-book.tex:230, 930 | `sp.hyphenat` | `\nohyphenation` (a language without patterns, as `hyphenat`'s `\nohyphens`), `\sloppy` |
| letterspacing, caps | xtufte-common.def:692-698 | `sp.microtype` | `microtype` `\textls[50]`; `\allcaps`=`\textls[50]{\MakeUppercase{#1}}`, `\smallcaps` likewise with `\scshape` |
| case change | xtufte-common.def:695-696 | `mark.case` | `\MakeUppercase` `\MakeLowercase` inside the two commands |
| run-in thought opener | xtufte-common.def:702-705, 1432-1438 | `head.class-native` | `\newthought{}`: `\tuftebreak` (skip 1.0\baselineskip plus 0.5ex minus 0.2ex) then `\noindent\textsc{}` |
| headings | xtufte-common.def:1516-1550 | `head.titlesec` | chapter `[display]` label `\itshape\huge\thechapter`, title `\huge\rmfamily\itshape`, `\titlespacing*{\chapter}{0pt}{50pt}{40pt}`; section and subsection `[hang]` `\Large\itshape` and `\large\itshape`, sep 1em; paragraph `[runin]` `\itshape` |
| subsubsection disabled | xtufte-common.def:1554-1572 | `head.class-native` | `\subsubsection` and `\subparagraph` raise an error |
| numbering depth | xtufte-common.def:514, xtufte-book.cls:80 | `num.secnumdepth` | `secnumdepth`=-1, `tocdepth`=0 |
| running heads | xtufte-common.def:1343-1384, xtufte-book.cls:53-66 | `hf.fancyhdr` | `fancy` style, `\fancyhfoffset[RE,RO]{overhang}`, rules 0pt, one-side `\fancyhead[RE,RO]{\smallcaps{plaintitle}\quad\thepage}`; frontmatter `\fancyhead[RE,RO]{\thepage}` (xtufte-book.cls:40-49); `plain` and `empty` styles cleared |
| page numbers | xtufte-book.cls:43 | `pgnum.pagenumbering` | `\pagenumbering{arabic}` at `\frontmatter`, not restarted |
| blank verso pages | xtufte-common.def:1502-1511, doc/sample-book.tex:99, 160 | `pg.break` | `\cleardoublepage` redefined; `\blankpage` = `\newpage\hbox{}\thispagestyle{empty}\newpage` (`hf.pagestyle-kernel`) |
| matter commands | xtufte-book.cls:40-77, doc/sample-book.tex:157, 251, 1226 | `front.class-native` | `\frontmatter` `\mainmatter` `\backmatter` redefined |
| title block | xtufte-common.def:596-648, 1463-1488 | `front.class-native` | `\LARGE\itshape` title, `\Large\itshape` author and date, `\thispagestyle{plain}`, `\tuftebreak`; with `titlepage` the `\maketitlepage` (1444-1458) sets 18/20 author, `\vspace{11.5pc}`, 36/40 title, 14/16 publisher in `fullwidth`, author and title in darkgray |
| epigraph pages | doc/sample-book.tex:88-96, 163-185 | `front.dedication` | `\openepigraph{text}{author}`: `fullwidth`, `\sffamily\fontsize{14}{16}`, `doublespace`, `\allcaps`; three pages split by `\vfill` |
| copyright page | doc/sample-book.tex:193-216 | `front.dedication` | `fullwidth`, `~\vfill`, parindent 0pt, parskip `\baselineskip`, `\smallcaps{}`, `\url{}`, `\thanklessauthor` |
| dedication page | doc/sample-book.tex:226-236 | `front.dedication` | `~\vfill`, `doublespace`, `\fontsize{18}{22}\selectfont\itshape` |
| printed month and year | doc/sample-book.tex:80-84, 215 | `front.datetime` | `\monthyear` (an `\ifcase\month` name list); reduces to a `\newdateformat{monthyear}{\monthname[\THEMONTH] \THEYEAR}` |
| contents | xtufte-common.def:1577-1613, doc/sample-book.tex:219 | `toc.titletoc` | `\titlecontents` for part, chapter, section, subsection, paragraph in `fullwidth`, `\LARGE\rmfamily\itshape` chapters, page number after `\qquad` |
| contents and float lists | xtufte-common.def:1618-1654, doc/sample-book.tex:219-223 | `toc.kernel` | `\listoffigures` `\listoftables` as `\chapter*`, entry `\@tufte@lof@line` |
| full-width block | xtufte-common.def:526-534, 1293-1301 | `page.adjustwidth` | `adjustwidth{}{-\@tufte@overhang}` (overhang = marginparwidth + marginparsep, 559-575) |
| sidenotes | xtufte-common.def:884-1001, doc/sample-book.tex:280, 294, 430, 520 | `note.sidenotes` | `\footnote` and `\sidenote[n][offset]{}` rebuilt on `\marginpar`; mark `\tiny` in the note, footnotesize text, `sidenote=raggedright` |
| margin notes | xtufte-common.def:1006-1016, 845, 921 | `note.marginnote` | `\marginnote[offset]{}` on kernel `\marginpar` (`note.marginpar`); `marginnote=raggedright` |
| margin citations | xtufte-common.def:1944, doc/sample-book.tex:577 | `note.marginnote` | `\margincite{keys}` = `\marginnote{\textcite{}}` |
| margin floats | xtufte-common.def:1027-1058, doc/sample-book.tex:605-610 | `fig.class-native` | `marginfigure[offset]`, `margintable[offset]`: `lrbox` + `minipage` of `\marginparwidth` in `\marginpar` |
| float containers | xtufte-common.def:1146-1287, doc/sample-book.tex:363, 632, 640 | `fig.class-native` | `figure`, `table`, `figure*`, `table*` put the caption in the margin by two boxes; `\setfloatalignment`, `\forcerectofloat`, `\forceversofloat` (1103-1106) |
| float slots | xtufte-common.def:1717-1818 | `fig.class-native` | `\morefloats` (not called by the sample, text only at doc/sample-book.tex:718-727) |
| float barrier | xtufte-common.def:1022, 1029 | `fig.placement` | `placeins` `\FloatBarrier` |
| figures | doc/sample-book.tex:364, 597, 633, 641 | `fig.graphicx` | `\includegraphics`; `\setkeys{Gin}{width=\linewidth,totalheight=\textheight,keepaspectratio}`, `\graphicspath{{graphics/}}` (:12-13) |
| framed images | doc/sample-book.tex:364-370 | `box.fancybox` | kernel `\fbox{...}` around images |
| captions | xtufte-common.def:1128-1134, 1306-1318, doc/sample-book.tex:643 | `cap.kernel` | `\caption[short][offset]{}` (second optional argument is a length), text `\@tufte@caption@font` + `\RaggedRight` (`caption=raggedright`) |
| tables | doc/sample-book.tex:273-291, 331-360, 691-701 | `tbl.tabular` | `tabular`, `\multicolumn`, in `center` and `\footnotesize`, `table[h]` floats |
| table rules | doc/sample-book.tex:14, 274-278, 339 | `tbl.booktabs` | `\toprule \midrule \cmidrule(l){2-5} \addlinespace \bottomrule` |
| hanging marks in cells | doc/sample-book.tex:53, 58 | `box.stackengine` | `\hangp`, `\hangstar` = `\makebox[0pt][r]{(}` and `[l]` (kernel `\makebox`, as the v6 log notes for this way) |
| units and numbers | doc/sample-book.tex:21, 469, 695-698 | `mark.siunitx` | `\num` `\unit` `\qty[mode=text]` |
| maths | doc/sample-book.tex:10, 599 | `math.amsmath` | `amsmath` loaded; inline maths only |
| verbatim | doc/sample-book.tex:17-18, 493, 807-811, 1195-1198 | `code.verbatim` | `fancyvrb`: `\Verb`, `Verbatim`; kernel `verbatim`; `\fvset{fontsize=\normalsize}` |
| code blocks | doc/sample-book.tex:19, 595-602, 617-625, 653-658, 1205-1222 | `code.minted` | `minted-code` `codeblock[title=,colback=]` (EXTERNAL, see Blockers) |
| columns | doc/sample-book.tex:15, 1157-1184; xtufte-common.def:1688 | `cols.multicol` | `multicols{2}` around an `itemize`; `multicols{3}` in the index |
| filler text | doc/sample-book.tex:16, 43, 814 | `draft.todo` | `lipsum` `\lipsum[1]` |
| index | xtufte-common.def:1688-1711, doc/sample-book.tex:23, 1239 | `idx.makeidx` | `makeidx` `\makeindex`; `theindex` redefined (fullwidth, `\small`, 3 columns); the `%! HV xindex` line (:4) names xindex as the indexer |
| bibliography | xtufte-common.def:804, doc/sample-book.tex:38-39, 246, 577, 1202, 1237 | `bib.biblatex-biber` | `biblatex` `style=authoryear,backref`; `\addbibresource{sample-handout.bib}` and a `location=remote` resource (ctan.bib, fetched by biber at run time; the key `ctan-hyperref`, cited at :1192, is not in the local .bib, so a build needs the network); `\parencite` `\nocite` `\printbibliography` |
| links | xtufte-common.def:1927-1936, doc/sample-book.tex:36 | `meta.hyperref` | `[unicode,hyperfootnotes=false]`, `pdfborder={0 0 0}`, citecolor=DarkGreen, linkcolor=DarkBlue, urlcolor=DarkGreen; `\hypersetup{colorlinks}` |
| cross-references | doc/sample-book.tex:593, 615, 1124 | `xref.hyperref` | `\ref` `\nameref` `\pageref` (inside a float the class captures `\caption` and `\label` and replays them in the caption box, xtufte-common.def:1166-1167, 1186-1187) |
| colour | xtufte-common.def:367, doc/sample-book.tex:106, 110 | `color.xcolor` | `[dvipsnames,svgnames,x11names]`; `\textcolor{Maroon}`, `\textcolor{red}`, darkgray title |
| spacing commands | doc/sample-book.tex:270, 365, 638 | `sp.manual-space` | `\bigskip`, `\hfill`, `\vspace{3\normalbaselineskip}`, `\quad`, `\linebreak` |
| class hook files | xtufte-common.def:1921-1941, xtufte-book.cls:85-88, doc/sample-book.tex:9-24 | `struct.input` | kernel `\IfFileExists{..}{\input{..}}` of `tufte-common-local-before-hyperref.tex`, written by `filecontents` in the sample; an emitter prints the packages straight into the preamble |
| engine logos | xtufte-common.def:1947-1948 | `font.icons` | `\LuaLaTeX` `\XeLaTeX` by `\providecommand`; reducible to `hologo` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| kernel-level redefinitions: `\@footnotetext`, `\@footnotemark`, `\@makefntext`, `\@caption`, the `\@float` wrapper, `\cleardoublepage`, `\@compactenum@` | xtufte-common.def:657, 891-936, 1113-1224, 1306-1318, 1502 | n/a, published class | the code is the published CTAN class `class.xtufte-book`, so it is the class way, not zip-local bespoke code; read as zip-local it would be `BESPOKE/class` (it redefines kernel internals and float output with `lrbox`) |
| float-slot allocator `\morefloats` | xtufte-common.def:1717-1818 | n/a, published class | same ruling; `\newinsert` and `\@freelist` edits |
| `\catcode`Q` trim macro, `\gsetlength`, `\gsetboolean`, `\newlinetospace` | xtufte-common.def:359-377, 762-786, 1322-1337 | n/a, published class | class-internal helpers with no printed look of their own |
| `\hangp`, `\hangstar`, `\na`, `\measure`, `\hairsp`, `\hquad`, `\TODO`, `\ie`, `\eg` | doc/sample-book.tex:53, 58, 103, 108-113 | yes | `\newcommand` aliases of kernel boxes, spaces, `\textcolor` and `\textit`; expand inline |
| `\xPack`, `\vdqi`..`\BE`, `\TL`, `\tXeLaTeX`, `\xspace` users | doc/sample-book.tex:67-77, 114 | yes | text aliases with `\index`; `\xspace` is dropped by inline expansion (`sp.xspace` was rejected in lib v4) |
| `\monthyear` | doc/sample-book.tex:80-84 | yes | `front.datetime` date format, or printed text |
| `\openepigraph`, `\blankpage` | doc/sample-book.tex:88-99 | yes | compositions of `page.adjustwidth`, `font.size-commands`, `sp.setspace`, `mark.case`, `pg.break` |
| `\doccmd`, `\doccmddef`, `\doccmdnoindex`, `\docenv`, `\docenvdef`, `\docpkg`, `\docclsopt`, `\docclsoptdef`, `\docfilehook`, `\doccounter`, `\docmsg`, `\docopt`, `\docarg`, `\hlred`, `\hangleft` | doc/sample-book.tex:106-151 | yes | `\texttt`, `\textit`, `\textcolor{Maroon}`, `\label` and `\index` entries; the `\ifthenelse{\isempty{#1}}` only picks which index entries to write, so an emitter that knows the arguments expands each call |
| `docspec` environment | doc/sample-book.tex:142 | yes | `quotation` + `\ttfamily` + parskip 0pt + parindent 0pt (`quote.kernel`, `sp.lengths`) |

## Content-opaque
- Image figures (PDF and PNG in `doc/graphics/`): `\includegraphics` at doc/sample-book.tex:364-385, 597, 633, 641; the Asymptote sources `helix.asy` and `sine.asy` are not compiled by the document (the PDFs are shipped).
- Table cell text and the epigraph, copyright and dedication wording (doc/sample-book.tex:164-185, 199-215, 229-233).

## Lib changes
- New ways proposed: none. Considered and not proposed: `filecontents` (the emitter writes the preamble lines directly), and the load-only helper packages `xkeyval`, `xifthen`, `iftex`, `optparams`, `hardwrap`, which print nothing (as `sys.compat-load`, rejected in lib v4).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
