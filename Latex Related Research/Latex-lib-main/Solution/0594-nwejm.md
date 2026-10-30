no

# 0594-nwejm: NWEJM (nwejm / nwejmart class bundle for the North-Western European Journal of Mathematics)

- Unverified: read from the source, not compiled.
- Source: Source/0594-nwejm/ (origin: https://mirrors.ctan.org/macros/latex/contrib/nwejm.zip; licence: lppl1.3c)
- Kind: journal
- Lib: v5
- Engine: needs LuaLaTeX (the sample aborts under any other engine, doc/french/nwejm-fr.tex:1-8; the class alone also loads under pdfTeX, source/nwejm.dtx:943-968)
- Look carried by: mixed (page, title block, headings, theorems, lists, bibliography come from the published class `nwejmart`; the documentation boxes, colours and index come from `denisbdoc`; the sample preamble adds three patches of package internals)
- Class origin: ctan
- Main file: doc/french/nwejm-fr.tex (other samples: doc/english/nwejm-en.tex, the same manual in English; source/nwejm-examples-template.dtx, docstrip source of the example articles and an issue file, no `.tex` of them in the zip)
- Read: main yes, zip-local classes and styles partly (the loaded class `nwejmart` exists only as code in source/nwejm.dtx, read as its code lines for the article side, lines 579-6760, the issue-only `%<*class>` blocks skipped; legacy tex/nwejm-2024-02-08.cls read lines 1-500 and a package outline, it is not loaded by the sample; source/nwejm-examples-template.dtx read lines 1-32 and 394-668; doc/english/nwejm-en.tex only outlined by grep)

## Verdict
`no`. The class `nwejmart` is published (CTAN and TeX Live bundle `nwejm`, LPPL 1.3c, author and maintainer Denis Bitouze; read at ctan.org/pkg/nwejm) and the documentation package `denisbdoc` is published (ctan.org/pkg/denisbdoc), so the class internals and the documentation apparatus are not blockers and every component of the sample maps to a lib way. The sample preamble, however, contains three irreducible patches of third-party package internals (`\patchcmd` on marginnote, a rewrite of listings' `\lst@DefEC`, a rewrite of tcolorbox's `\tcb@ref@doc` with a page conditional). An emitter would have to copy that macro logic, so the answer is `no`. Without those three items the sample would reach `yes`.

## Blockers
- `BESPOKE/preamble` two `\patchcmd{\@mn@margintest}{\@tempswafalse}{\@tempswatrue}{}{}` calls plus `\reversemarginpar` rewrite marginnote's margin test (doc/french/nwejm-fr.tex:20-22)
- `BESPOKE/preamble` `\def\lst@DefEC{...}` redefines a listings internal to make over 130 character codes letters (doc/french/nwejm-fr.tex:24-48)
- `BESPOKE/preamble` `\RenewDocumentCommand\tcb@ref@doc{msm}{...}` replaces a tcolorbox documentation-library internal, with a hand-written `\ifnum\getpagerefnumber{#1:#3}=\thepage` conditional deciding what is printed (doc/french/nwejm-fr.tex:51-59)

## Class setting
- Class: `class.nwejmart` options: `french`, `nolocaltoc` (doc/french/nwejm-fr.tex:10). The class declares `english` (default) `french` `german` `ngerman` `dutch` `nolocaltoc` and `10pt` `11pt` `12pt` `draft` (the last four go to `book`) (source/nwejm.dtx:792-843), and `\LoadClass{book}` (source/nwejm.dtx:866). Source for `nwejmart` is the `class-article` branch of source/nwejm.dtx (`\ProvidesExplClass{nwejmart}{2026-02-19}{2.1}`, :628-635); the zip ships no `nwejmart.cls`, only the frozen legacy release (`\DeclareRelease{}{2024-02-08}{nwejm-2024-02-08.cls}`, source/nwejm.dtx:622; tex/nwejm-2024-02-08.cls:17-19).
- Class-native vocabulary used by the sample: `\title[toc][head]{}`, `\subtitle[toc]{}`, `\author[affiliation=..,affiliationtagged=..]{Last, First}`, `abstract`, `\keywords[pdf variant]{}`, `\msc{}`, `\maketitle`, `\acknowledgments{}`, `\section[toc][head]{}`, `\printbibliography`, `\newtheorem[style=,title=,title-plural=]{}`, predefined `theorem` `corollary` `conjecture` `proposition` `lemma` `axiom` `definition` `remark` `example` `notation` `proof` (each with `*`), `\newenumeration[label=,singular=,plural=]{}`, `\renewenumeration`, `assertions` `hypotheses` `conditions`, `\cref`, `\vref`, `\articlesetup{gradient=}`, `\century`, `\aside`, `\ie` `\Ie`, `\nwejm`, math commands `\E \I \bbN..\bbK \set \norm \lnorm \llnorm \lpnorm \supnorm \abs \prt \brk \brc \leqgeq \lrangle \NewPairedDelimiter \dif \grad \Div \curl \supp \BinaryOperators \log* \lg*` and French-only `\cot \arccos \cosh \leq ...`.

## Component map
Rows marked "class" are set inside the published class; the emitter writes `\documentclass[french,nolocaltoc]{nwejmart}` and the way is recorded to show the component has a home. Paths: `S` = source/nwejm.dtx, `M` = doc/french/nwejm-fr.tex.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | M:10; S:628-635, 866 | `class.nwejmart` | french, nolocaltoc; base class `book` |
| page geometry (class) | S:1562-1563, 1711-1745, 1865-1898 | `page.geometry` | layout 170mm x 240mm = papersize; textwidth = 3/4 layoutwidth; textheight = 3/4 layoutheight; bottom=36mm; inner=23mm; headheight=5mm; footskip=10mm |
| running heads and foot (class) | S:2075-2111 | `hf.class-native` | titlesec `pagestyles` `\newpagestyle`, `\sethead`, `\setfoot`; even pages: short title in `\slshape` left, `\citeauthor` names (alias giveninits-last, maxnames 2) right; odd pages: `\slshape` "N. section title" left; foot: `\thepage` centred |
| first-page head (class) | S:2117-2165 | `hf.class-native` | page style with bold stacked journal name left and logo `nwejm-logo-NB` (1cm) right; foot `\thepage` |
| fonts (class) | S:943-968, 5804-5808, 5839 | `font.serif-pkg`, `font.fontenc-t1`, `font.unicode-math`, `font.fontspec`, `font.family-default`, `font.nfss` | pdfTeX: `fontenc[T1]`, `kpfonts[noDcommand]`, `\ttdefault`=lmtt, `\mathfrak` from eufrak; Xe/Lua: `unicode-math`, `kpfonts-otf[noDcommand]`, `\setmonofont[Scale=MatchLowercase]{Latin Modern Mono}` |
| colour | S:1008; M:68 | `color.xcolor` | xcolor; `gray!10` |
| language | S:764-776, 1174 | `lang.babel` | `main=<language option>`, `\selectlanguage` at `begindocument/end`, languages french ngerman dutch english |
| keyword translations (class) | S:1064, 6137-6244 | `lang.translator` | `translations` package: `\ProvideDictionaryFor{English}{nwejm}`, `\ProvideDictTranslation{theorem}{...}`, `\GetTranslation` |
| quotation marks | S:1033, 4163, 5707; M:1759-1773 | `lang.csquotes` | `csquotes[autostyle]`, `\DeclarePlainStyle{«~}{~»}{`}{'}`, `\SetCiteCommand{\autocite}`; body `\enquote`, `\blockcquote` |
| links and PDF metadata (class) | S:1232-1235, 1245, 1240, 3026-3029, 4049, 4122; M:1822-1828 | `meta.hyperref`, `meta.bookmark`, `xref.hypcap`, `meta.url` | `hyperref[pdfencoding=unicode,final]`, `\hypersetup{hidelinks,hypertexnames=false,breaklinks}`, `bookmark[numbered]`, `hypcap[all]`; `pdftitle` `pdfauthor` `pdfkeywords` set from title, authors, keywords; body `\url`, `\href` |
| title block | M:100-114; S:3656-3738, 4078-4104 | `front.class-native` | `\title`/`\subtitle`/`\author` as above; `\maketitle` = `\chapter[toc text]{\LARGE title \\[1ex] \Large subtitle \\[2ex] authors \\[2ex] dates}` with `\setsecnumdepth{none}`, `\thispagestyle{..article_title_ps}` |
| chapter-title format | S:5909-5912 | `head.titlesec` | `\titleformat{\chapter}[block]{\normalfont\centering}{}{0pt}{}`, `\titlespacing*{\chapter}{0pt}{0pt}{0pt}` |
| author names, affiliations | S:3872-3897; M:437-447 | `front.class-native`, `front.thanks` | names printed by biblatex `\citeauthor` in small caps (S:3869-3870); each affiliation a `\footnotemark`/`\footnotetext` |
| abstract | S:3763-3769, 4010-4028; M:539-541 | `abs.class-native` | `abstract` collected with `environ`; set as `\small`, centred bold `\abstractname`, `quotation` env |
| keywords | S:3020-3030, 3994-4005; M:543 | `abs.keywords` | `\keywords[variant]{list}`; bold titlecased "mots-clés" + colon + list |
| classification | S:3044-3048, 4006-4009; M:545 | `abs.classification` | `\msc{list}`; `\textbf{\textsc{msc}}` + colon + list |
| acknowledgments | S:3809-3811, 5724-5729; M:559 | `front.class-native` | `\acknowledgments{text}` printed by the redefined `\printbibliography` under `\section*{Acknowledgments}` |
| dates | M:12, 104-105; S:1211, 2987-3005 | `front.datetime` | `datetime2[useregional]`, `\DTMsavedate`, `\DTMusedate`, `\DTMdate` |
| headings | S:4222-4260; M:127, 227, 297 | `head.class-native`, `head.kernel` | `\section[toc][head]{}` star-aware (`\setsecnumdepth{none}`), `\subsection`, `\subsubsection` with optional toc title; look is `book` default |
| numbering | S:1190, 4078-4099, 4184, 4209; M:1871 | `num.secnumdepth`, `num.counters`, `num.appendix` | `tocvsec2` `\setsecnumdepth`; `\thesection`=`\arabic{section}`, `\Alph{section}` after `\appendix` |
| contents | M:116-117; S:1195-1201, 1968-1991, 5745-5764 | `toc.etoc`, `toc.tocloft` | `\etocarticlestylenomarks`, `\localtableofcontents`; class: `\etocsetlevel{chapter}{6}`, `\tableofcontents` at the end of a standalone article unless `nolocaltoc` |
| lists | S:1216; M:1845-1869 | `list.enumitem`, `list.kernel` | `enumitem[inline]`: `itemize*` `enumerate*` `description*` |
| class-native enumerations | S:4664-4706, 4795-4806; M:92-94, 1385-1395 | `list.enumitem` | `\newlist{name}{enumerate}{1}` + `\setlist[name]{label=(\textsf{X}$_{\arabic*}$), ref=...}` + zref-clever `\zcRefTypeSetup`; keys label, singular, plural |
| theorems | S:4437-4452, 4560-4593, 4616-4626; M:85-90, 1196-1211, 1239-1354 | `thm.class-native` | `keytheorems`: style `theorem` (inherits plain, note bold, head punctuation ` --`), `definition`, `proof` (inherits remark, note italic, unnumbered, qed `\square`); keys style, title, title-plural; `*` forms unnumbered |
| display maths | S:868, 935, 5265, 5554-5557; M:778-783 | `math.mathtools`, `math.amsmath`, `math.eqnumber` | `mathtools`; `amsmath[fleqn]`; `\allowdisplaybreaks`; `\mathtoolsset{original-intertext=false,original-shortintertext=false}` |
| math vocabulary (class) | S:4834-5256; M:766-1151 | `math.mathtools`, `math.amsmath` | `\DeclarePairedDelimiterX`, `\operatorname`, `\mathbb`; the hand-rolled spacing logic (`\BinaryOperators`, the align patches S:5278-5551) is class code |
| cross-references | S:1255, 1261, 4648, 4656; M:1594-1627, 51-59 | `xref.zref`, `xref.varioref`, `xref.hyperref`, `xref.kernel` | `zref-clever` (`\cref`=`\zcref`), `zref-vario` (`\vref`=`\zvref`); sample also `\hyperref`, `\ref*`, `\pageref*` |
| floats | S:978, 983, 1023, 1184, 2185, 4168-4169; M:322-339 | `fig.graphicx`, `fig.adjustbox`, `fig.subcaption`, `fig.placement` | `adjustbox[export]`; `\graphicspath{{images//}{../images//}}`; topnumber 3, `\topfraction` 0.8; `table[htb]` with `\centering` |
| tables | M:331-338, 929-948, 1222-1228 | `tbl.tabular`, `tbl.booktabs`, `tbl.tabularx` | `tabular{\|l\|c\|c\|c\|}` with `\hline` `\cline` `\multicolumn`; `\toprule \midrule \midrule[.75pt] \bottomrule`; `tabulary{\linewidth}{lLLL}` |
| captions | S:4334-4337; M:324-326 | `cap.caption`, `cap.kernel` | `\DeclareCaptionLabelSeparator{dash}{\nobreakspace--\nobreakspace}`, `\captionsetup{labelsep=dash}` |
| footnotes | S:993, 4174; M:119-125 | `fn.footmisc`, `fn.kernel`, `fn.fixfoot`, `sp.lengths` | `footmisc[multiple]`; `\skip\footins` +.25\baselineskip; `\DeclareFixedFootnote{\cmd}{text}` |
| margin notes | S:998, 5564-5656; M:20-22 | `note.marginnote`, `note.marginpar` | `marginnote`; `\reversemarginpar` |
| text shape | S:1206, 4179; M:327, 603 | `sp.microtype`, `font.size-commands` | `microtype[babel=true,nopatch=eqnum,final,nopatch=footnote]`; `\columnsep`=7mm; `\footnotesize` |
| code listings | S:1179; M:328-330, 1769-1773, 1886-1893 | `code.listings`, `code.tcblisting` | `listings`, `\lstset{deletekeywords=..}`, `\lstinline`; `\tcbinputlisting{samples, listing only, listing file=.., title=..}` |
| documentation apparatus | M:15, 130-145, 244-246, 437-447, 649-651 | `dtx.doc`, `box.tcolorbox` | `denisbdoc[nwejm]` (package is the parameter): `docCommand` `docKey` `docEnvironment` `dbwarning` `dbremark` `bodycode` `preamblecode`, `\refCom` `\docAuxCommand` `\meta`, `\tcbset{index format=off}`, `\tcbset{listing options={escapechar=+}}` (M:64, 66); source of `denisbdoc` not read |
| watermark | M:17, 68-70; S:5826-5831 | `bg.watermark`, `mark.case` | `draftwatermark[firstpage]`; colour `gray!10`, font size 20mm, text `\MakeUppercase{travail en cours}` |
| bibliography | S:1226-1227, 5699-5730, 6449-6760; M:72-77, 731-738, 2125 | `bib.biblatex-biber` | `biblatex[backend=biber,style=nwejm]` (nwejm.bbx over `authoryear-comp`, S:6456; nwejm.cbx with `autocite=nwejmfootcite`, S:6756); `defernumbers=true,dashed=false,uniquename=init,backref,safeinputenc`; `\addbibresource`, `\DeclareBibliographyCategory`, `\printbibliography[heading=..,category=..]` |
| index | M:62-63, 2135 | `idx.makeidx` | `\indexsetup{level=\section*,toclevel=section,noclearpage}`, `\makeindex[columns=2]`, `\printindex` (imakeidx-style commands from a package denisbdoc loads, inferred, not read) |
| acronyms | S:1250, 1281-1283; M:79-83, 1699-1735 | `idx.glossaries` | `glossaries[nowarn]`, `\setacronymstyle{long-sc-short}`, `\setglossarystyle{indexhypergroup}`, `\glsdisablehyper`; `\newacronym`, `\gls`, `\acrshort` |
| logos, symbols, attachment | M:162, 1884-1893 | `font.icons`, `meta.attachfile` | `\hologo{..}`; `\attachfile{../examples/template.tex}` (package inferred from the command name, not read) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| marginnote patch | M:20-22 | no | `\patchcmd` of `\@mn@margintest` is a code edit of a package internal; no lib way patches a command body |
| listings `\lst@DefEC` | M:24-48 | no | redefines a listings internal (letters for over 130 character codes); `code.listings` options do not express it |
| `\tcb@ref@doc` | M:51-59 | no | replaces a tcolorbox documentation-library internal with a page-number conditional |
| `\myarrow` | M:50 | yes | `font.nfss`: `\fontfamily{pzd}\fontencoding{U}\fontseries{m}\fontshape{n}\selectfont\char213` |
| engine guard (`\sys_if_engine_luatex:F` + `\msg_error`) | M:1-8 | yes | no printed effect; carried by the Engine tag |
| `\defbibheading{origsectionnotintoc}[References]{\__nwejm_section:*{#1}}` | M:722-728 | yes | `bib.biblatex-biber` `\defbibheading` with body `\section*{#1}` (`\__nwejm_section:` is the saved kernel `\section`, S:4222) |
| `\renewcommand{\thempfootnote}` | M:729, 740, 1783, 1793 | yes | `num.counters` |
| aliases `\releaseversion`, `\attachfilename`, `\attachfiletextlink` | M:13, 1884-1885 | yes | inline expansion |
| `\newtheorem`, `\newenumeration` calls | M:85-94 | yes | `thm.class-native`, `list.enumitem` as in the map |
| `\DeclareMathOperator`, `\newcommand{\mybinop}` | M:96-97 | yes | `math.amsmath` |
| `\DeclareFixedFootnote` calls | M:119-125, 1588 | yes | `fn.fixfoot` |
| class `nwejmart` own code (title and author data written to a helper `.bib` file, align and intertext patches, copy of marginnote's code, `\BinaryOperators`, theorem and enumeration builders) | S:2495-2525, 3856-3897, 4560-4562, 4795-4806, 4834-4916, 5278-5551, 5564-5656 | n/a, published | part of the published class (CTAN, TeX Live, LPPL); counted as `class.nwejmart`, not as bespoke, and recorded for transparency |
| biblatex style files `nwejm.bbx`, `nwejm.cbx`, dictionaries, `latexmkrc` | S:5966-5981, 6133-6385, 6449-6810 | n/a, published | shipped with the CTAN bundle |
| legacy class `nwejm-2024-02-08.cls` | tex/nwejm-2024-02-08.cls:17-19 | n/a | not loaded by the sample (`nwejmart` v2.1 is); issue-class cover code (tcolorbox, tikzpagenodes, tkz-berge, S:1122, 6393-6445) belongs to `nwejm`, not to the sample |

## Content-opaque
none. The sample draws no TikZ or other picture; `../examples/template.tex` named at doc/french/nwejm-fr.tex:1890 is not in the zip (only PDFs in doc/examples/), a missing asset to ship.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
