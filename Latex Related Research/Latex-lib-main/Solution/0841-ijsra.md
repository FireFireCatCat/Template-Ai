yes

# 0841-ijsra: ijsra, class of the International Journal of Student Research in Archaeology

- Unverified: read from the source, not compiled.
- Source: Source/0841-ijsra/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ijsra.zip; licence: lppl1.3, LPPL 1.3 at ijsra.cls:8-10)
- Kind: journal
- Lib: v6
- Engine: needs XeLaTeX (`fontspec` loaded unconditionally with Libertinus and Anonymous Pro, ijsra.cls:70-83; the compile note names XeLaTeX then biber, in a commented block, ijsra.tex:451; LuaLaTeX not stated)
- Look carried by: class (ijsra.cls loads `scrbook` and every package; the sample only fills the class's data fields and shows its macros)
- Class origin: ctan (the zip is the CTAN release of `ijsra` v1.1, 2017/07/24, ijsra.cls:24, README.md:4; the CTAN page says it is in TeX Live and MiKTeX; ctan.org/pkg/ijsra read)
- Main file: ijsra.tex (other samples: none; ijsra.pdf is the compiled documentation and was not read)
- Read: main yes, zip-local classes and styles all (ijsra.cls read in full, 633 lines; it is the published class, not zip-local; the biblatex style `ijsra` it loads is a separate CTAN package and is not in the zip)

## Verdict
The zip is the CTAN release of the journal class `ijsra` plus its own documentation sample, so the look is one published class way, `class.ijsra` (a `scrbook` base with fixed options and a package set), and the sample defines nothing of its own: it fills class-native data fields (ijsra.tex:7-25) and calls published or class macros. I read the whole class and every construct reduces to lib ways; the one body construct with no lib line, the `alertmessage` boxes (ijsra.tex:12, 295, 307), is proposed as `NEW:box.alertmessage`. Residual risks, none a blocker: the packages `abbrevs`, `draftfigure` and `currfile-abspath` (ijsra.cls:95, 206, 108) and the biblatex style `ijsra` were not read, and the cover `\IJSRAtitlepage` (ijsra.cls:520-554) is never called by the sample but places its items with picture `\put`.

## Blockers
none

## Class setting
- Class: `class.ijsra` options: none active in the sample (year, month, number, volume are commented out, ijsra.tex:2-5). The class defines `draft` (passed to `scrbook`), `month`, `year`, `volume`, `number`, `titlefigure`, `completeissue` (ijsra.cls:43-49) and loads `scrbook` with parskip=half, twoside=true, open=any, chapterprefix=false, headings=optiontohead, fontsize=11pt, titlepage=on, captions=tableabove, numbers=noenddot (ijsra.cls:57-67).
- Class-native vocabulary used: data fields `\IJSRAidentifier` (ijsra.tex:7), `\authorone` (:9), `\bioone` (:11), `\maintitle` (:14), `\shorttitle` (:15), `\abstract` (:16), `\affilone` (:21), `\cmail` (:23), `\keywords` (:25), `\keywordname` (:415), version strings `\IJSRAversion` `\IJSRAversiondate` (:14); `\IJSRAopening` (:90) which also begins the document, `\IJSRAclosing` (:457) which also ends it, `\IJSRAsection` (:95), `\IJSRAsubsection` (:305), `\IJSRAseparator` (:113), environment `IJSRAabstract` (:418); `\currfilebase` from `currfile` (:7). Commands of packages the class loads: `\alertinfo` `\alertwarning`, `\lettrine`, `\blockcquote` `\foreignblockcquote`, `\foreignlanguage`, `labeling`, `\cref`, `\SIrange`, `\nocite{*}`, `lstlisting` with `\lstMakeShortInline[style=code]` (style `code` is defined at ijsra.cls:570).

## Component map
Way = the lib way the class realises the component with; the class itself is loaded as `class.ijsra`, so the rows show that its content decomposes into lib ways. Paths are relative to Source/0841-ijsra/.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ijsra.tex:6; ijsra.cls:19 | `class.ijsra` | no options active; `\IJSRAopening`/`\IJSRAclosing` wrap `\begin{document}`/`\end{document}` (ijsra.cls:439, 516) |
| base class | ijsra.cls:57-67 | `class.scrbook` | parskip=half, twoside=true, open=any, chapterprefix=false, headings=optiontohead, titlepage=on, captions=tableabove, numbers=noenddot |
| size, sides | ijsra.cls:59, 63 | `page.class-options` | fontsize=11pt, twoside=true |
| page geometry | ijsra.cls:180-190 | `page.geometry` | paper=a4paper, head=4\baselineskip, foot=4\baselineskip, bindingoffset=0.5cm, top=3cm, left=2cm, right=5cm, bottom=5cm, marginparwidth=4cm |
| spacing, lengths | ijsra.cls:58, 276 | `sp.lengths` | parskip=half (KOMA option); `\addtolength{\skip\footins}{.5\baselineskip}` |
| widows, clubs | ijsra.cls:279-281 | `sp.penalties` | \clubpenalty=10000, \widowpenalty=10000, \displaywidowpenalty=10000 |
| bottom flush | ijsra.cls:289 | `pg.flush` | `\raggedbottom` |
| microtype | ijsra.cls:86-93 | `sp.microtype` | protrusion=true, expansion=true, verbose=true, final=true, letterspace=100, babel=true |
| fonts | ijsra.cls:73-83 | `font.fontspec` | sans Libertinus Sans; main Libertinus Serif with Numbers={Monospaced,OldStyle}; mono AnonymousPro Scale=MatchLowercase, Extension=.ttf, Bold/Upright names, ItalicFont and BoldItalicFont set to the BoldItalic and Italic files as written (:79-80) |
| size and shape switches | ijsra.cls:234, 454, 263 | `font.size-commands`, `mark.kernel` | `\footnotesize` `\Large` `\Huge`; `\sffamily` `\scshape` `\itshape` `\bfseries` |
| colours | ijsra.cls:157, 161-169 | `color.xcolor` | mygold RGB 204,153,51; mybluetitle RGB 28,40,65; myblue rgb{0,0,51} as written; codeblue, codegreen, codegray, codepurple, backcolour |
| language | ijsra.cls:85; ijsra.tex:417 (real call; the listing at :409 shows it) | `lang.babel` | french, ngerman, spanish, italian, main=english; `\foreignlanguage{french}{...}` |
| quotation marks, block quotes | ijsra.cls:120-126; ijsra.tex:322, 328 | `lang.csquotes` | strict=true, style=english; `\mkccitation` and `\mkcitation` print ` (#1)`; `\blockcquote[see][112]{key}{text}`, `\foreignblockcquote{ngerman}[see][12]{key}{text}` |
| quote environment | ijsra.cls:128-132 | `quote.kernel` | `\list{}{\rightmargin=0em \leftmargin=2em}` |
| running head and foot | ijsra.cls:228-243 | `hf.scrlayer-scrpage` | headsepline, draft=false, `\pagestyle{scrheadings}`; lohead short title, rehead short author, rohead and lehead bold page number, refoot journal name, lofoot `\yearnumber`; `\automark[subsection]{section}`; pageheadfoot `\normalfont\sffamily\footnotesize` |
| head rule | ijsra.cls:271, 277 | `head.koma-fonts` | headsepline font colour mygold; `\KOMAoptions{headsepline=3pt}` |
| first-page head | ijsra.cls:246-252, 256-258 | `hf.scrlayer-scrpage`, `note.marginnote`, `fig.graphicx` | `\newpairofpagestyles[scrheadings]{ijsrachapter}`: chead journal line, `\yearnumber`, optional submission and acceptance dates, `pp.` range, margin logo `ijsra_logo` width=\linewidth, `\vspace{-5em}`; `\chapterpagestyle`, `\partpagestyle` set to these |
| heading fonts | ijsra.cls:262-272 | `head.koma-fonts` | partnumber `\normalfont\Huge`; part `\normalfont\scshape\Huge`; chapter `\LARGE`; section `\Large`; subsection and subsubsection `\normalfont`; paragraph `\normalfont\scshape`; descriptionlabel `\normalfont\sffamily`; sectioning `\linespread{1}\selectfont`; labelinglabel `\sffamily\bfseries` |
| article title block | ijsra.cls:447-473; ijsra.tex:9-23, 90 | `front.class-native` | `\chapter*{\maintitle}`; authors `\Large\scshape`; bios as `\footnote[n]{...}`; `\email` link; affiliation lines with `\textsuperscript` author symbols; `\vspace{3em}`; up to five authors |
| bio footnote marks | ijsra.cls:444, 455-459, 472 | `fn.kernel`, `num.counters` | `\footnote[1..5]`; `\thefootnote` set to `\fnsymbol{footnote}` in the block, back to `\arabic` after |
| footnote layout | ijsra.cls:274, 283-291 | `fn.footmisc` | marginal, ragged, hang, bottom; `\deffootnote{0em}{1em}{...bold sans mark}`; `\setfootnoterule{0pt}` |
| abstract and keywords | ijsra.cls:415-421, 475-479, 318-319; ijsra.tex:16-19, 25 | `abs.class-native`, `abs.keywords` | `IJSRAabstract`: `\list{}{\rightmargin\leftmargin}`, first item `\footnotesize\sffamily\textbf\keywordname: \keywords`, then `\itshape` text; `\keywordname` default Keywords |
| second abstract, other language | ijsra.tex:409-421 | `abs.class-native`, `lang.babel` | `\def\keywordname{Mots clés}`, `\foreignlanguage{french}{\begin{IJSRAabstract}...}` |
| margin section titles | ijsra.cls:302, 338-345; ijsra.tex:95, 305 | `note.marginnote`, `meta.bookmark` | `\IJSRAsection{t}` = `\marginnote{t}\pdfbookmark[1]{t}{t\IJSRAidentifier}`, `\IJSRAsubsection` level 2; `\marginfont` gold `\small\sffamily`; the sample has no `\section` |
| separator | ijsra.cls:423-426; ijsra.tex:113 | `sp.ragged` | `center` environment holding `* * *` |
| drop capital | ijsra.cls:100-104; ijsra.tex:95 | `sp.lettrine` | DefaultLines=3; `\LettrineTextFont` and `\LettrineFontHook` `\normalfont`; `\lettrine{E}{very}` |
| lists | ijsra.cls:96, 105, 107; ijsra.tex:387-395 | `list.scrextend`, `list.enumitem`, `list.paralist`, `list.enumerate-pkg` | `labeling{range phrase (1)}` with `\item[..]` (sample); enumitem option shortlabels; paralist and enumerate load-only |
| code listings | ijsra.cls:210, 566-567, 570-606; ijsra.tex:89, 100-111 | `code.listings` | style `code`: language=[LaTeX]TeX, backgroundcolor, comment/keyword/string/texcs colours, escapeinside={*@}{@*}, basicstyle `\ttfamily\footnotesize`, breaklines=true, numbers=left, numbersep=5pt, tabsize=2, literate brace colours, `\lstset{style=code}`; names Example, List of examples; `\lstMakeShortInline[style=code]\|` |
| counters | ijsra.cls:209, 211, 213-215 | `num.counters` | `\counterwithin{lstlisting}{chapter}`; `\counterwithout` for footnote, figure, table |
| captions | ijsra.cls:192-201, 557-562 | `cap.caption` | small, labelfont=bf, up, singlelinecheck=off, justification=raggedright, textfont=it; listing format `#1#2#3`, singlelinecheck=false, margin=0pt, font={sf}, size=footnotesize |
| figures | ijsra.cls:151-153, 202; ijsra.tex:343-361 (inside listings only) | `fig.graphicx`, `fig.wrapfig`, `fig.subcaption` | `\graphicspath{{figures/}}`; `figure` and `wrapfigure{O}{0.5\textwidth}` shown as code text |
| draft placeholder | ijsra.cls:43, 206 | `class.ijsra` | option `draft` goes to `scrbook`; `draftfigure` content={Figure omitted due to faster compiling.}; considered: draftfigure (not read) |
| tables | ijsra.cls:94, 154-155, 204; ijsra.tex:371 (`\captionof` in a listing) | `tbl.booktabs`, `tbl.multirow`, `tbl.colortbl` | load-only; no tabular in the sample; captions=tableabove (:65) |
| numbers and units | ijsra.cls:110-119; ijsra.tex:439 | `mark.siunitx` | detect-all, exponent-to-prefix=true, round-mode=places, group-minimum-digits=4, group-separator={,}, range-phrase={$\times$}, zero-decimal-to-integer=true, range-units=single; `\SIrange{1000}{400}{pt}` |
| ordinals | ijsra.cls:205 | `mark.nth` | load-only |
| references | ijsra.cls:630; ijsra.tex:18-19, 401 | `xref.cleveref` | `\cref{document}`, `\cref{document,abstract}` |
| article page range | ijsra.cls:306, 430-434, 473, 487 | `xref.kernel`, `xref.hyperref` | labels `firstpage\IJSRAidentifier` and `lastpage\IJSRAidentifier`; `\getpagerefnumber` in the first-page head |
| links, metadata | ijsra.cls:159-160, 613-629 | `meta.hyperref`, `meta.bookmark`, `meta.url` | unicode, colorlinks=true, urlcolor=myblue, linkcolor=myblue, citecolor=mygold, linktoc=page, pdfborder={0 0 0}, breaklinks=true, bookmarksopenlevel=2, final=true; `\urlstyle{same}` |
| bibliography | ijsra.cls:143-147, 485; ijsra.tex:29-87, 455 | `bib.biblatex-biber` | backend=biber, style=ijsra (CTAN `biblatex-ijsra`, not in the zip), `\addbibresource{\jobname.bib}`, `\printbibliography[heading=subbibliography]` inside `refsection`; the `.bib` is written by `filecontents` (content); `\nocite{*}` |
| alert boxes | ijsra.cls:98; ijsra.tex:12, 295, 307 | `NEW:box.alertmessage` | `\alertwarning{text}`, `\alertinfo{text}` |
| file identifier | ijsra.cls:106, 108; ijsra.tex:7 | `class.ijsra` | `\IJSRAidentifier` set to the string `\currfilebase` (default `\jobname`, ijsra.cls:39); `currfile` and `currfile-abspath` load-only |
| logo macro | ijsra.cls:158 | `font.icons` | `hologo` load-only (its one use is in a comment, ijsra.tex:451) |
| other load-only | ijsra.cls:171, 191, 203 | `pg.include-pdf`, `cols.multicol`, `sp.setspace` | no options |
| cover page, never called | ijsra.cls:518-554 | `color.pagecolor`, `page.geometry`, `sp.rule`, `fig.graphicx`, `pg.textpos` | see Bespoke code |

## Bespoke code
All rows sit in the published class (scope class) except the last; none is irreducible.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\IJSRAopening`, `\IJSRAclosing`, `\ifbool{issue}`, the `\undef` resets | ijsra.cls:438-516 | yes | `\begin{document}`, `\chapter*`, centred author and affiliation lines, abstract environment, `\printbibliography`; the `issue` switch and `\undef` lines serve only `completeissue` (multi-article mode) |
| `\IJSRAsection`, `\IJSRAsubsection` | ijsra.cls:338-345 | yes | alias of `\marginnote` and `\pdfbookmark` (`note.marginnote`, `meta.bookmark`) |
| `IJSRAabstract`, `\IJSRAseparator`, `\email` | ijsra.cls:415-428 | yes | kernel `\list` with `\rightmargin\leftmargin` and font switches; `center` with `* * *`; `\href{mailto:\cmail}{\cmail}` |
| author, affiliation, bio slots, `\shortauthor` | ijsra.cls:348-408 | yes | strings; etoolbox `\ifdef` only picks which of five slots exist, an emitter writes the slots that exist |
| `\ppages`, `\pagerange` | ijsra.cls:306, 430-434 | yes (guard not checked) | two `\label`s and `\getpagerefnumber` in `\chead`; an etoolbox boolean `@page` guards the print and its exact effect was not traced |
| `\ijsradate` | ijsra.cls:218-226 | yes | prints a date through `\today` after setting `\year \month \day`; submission and acceptance are empty (:175-176, 375-376), so it is not reached by the sample |
| `\IJSRAtitlepage`, `\Put` | ijsra.cls:518-554 | yes, not called | `\newgeometry` zero margins, `\pagecolor`, gold `\rule`, title figure and logo via `\includegraphics`, placed by `\makebox(0,0){\put(x,y){..}}`; the nearest lib way for the placement is `pg.textpos`; it is the one construct near ART and would need a second look if a sample called it |
| `\mypagesize`, `\mypartstyle`, `\pcref` | ijsra.cls:321-336 | yes, not called | `\newgeometry`/`\restoregeometry` (`page.geometry`), `\part`, `\cref` in `\parentext` |
| `quote` redefinition, `IJSRAquote` | ijsra.cls:128-139 | yes | `\list` margins; a deprecation notice in `\alertwarning` |
| `\lstdefinestyle{code}`, listing caption format | ijsra.cls:557-603 | yes | `code.listings` and `cap.caption` keys as listed in the component map |
| KOMA 3.18 patch, `\robustify{\DateMark}` | ijsra.cls:293, 296-300 | yes | version-guarded workaround and a robustness switch; no layout effect on other KOMA versions, droppable |
| option parsing with `xkeyval` | ijsra.cls:43-51 | yes | the class options of `class.ijsra`, plain parameters |
| sample data fields | ijsra.tex:7-25 | yes | `\def` strings of the class's own interface; no logic (body of the sample defines no macro) |

## Content-opaque
none (the listing texts at ijsra.tex:100-111 and the `.bib` records at ijsra.tex:29-87 are content; there is no TikZ, figure or table artwork)

## Lib changes
- New ways proposed: `NEW:box.alertmessage` `alertmessage` (CTAN, LPPL 1.3, v1.1 of 2015-08-04, Pierre Dupuis; ctan.org/pkg/alertmessage read; engine not stated on the page, tagged pdf as `math.mdwmath` was, the zip loads it under XeLaTeX): `\usepackage{alertmessage}` and body `\alertinfo{text}` `\alertwarning{text}` (the page names four alert kinds, informational, error, warning, success; the command names come from the sample; options and source were not read). W1 a CTAN release; W2 the message is a string and the kind is the command; W3 serves any alert or note box, no one document; W4 a preamble line plus a body wrapper around a node's text. No home in the lib: `box.awesomebox` names its own package and `box.tcolorbox` has no alert kinds.
- Considered, not proposed: `draftfigure`, `abbrevs`, `currfile-abspath` (loaded by the class, not used by the sample, not read), `scrhack` (KOMA-Script's own compatibility package, ijsra.cls:54, carried by the class way).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
