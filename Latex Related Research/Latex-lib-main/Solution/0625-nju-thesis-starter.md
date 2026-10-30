yes

# 0625-nju-thesis-starter: NJU Thesis Starter (a compact `book` starter, plus the bundled NJUThesis class)

- Unverified: read from the source, not compiled.
- Source: Source/0625-nju-thesis-starter/ (origin: https://latextemplates.com/downloads/njuthesis.zip; licence: LPPL-1.3c)
- Kind: thesis
- Lib: v5
- Engine: needs XeLaTeX (main.tex:1 `% !TEX program = xelatex`; `xeCJK` at main.tex:5 is XeTeX-only; the bundled class accepts XeLaTeX or LuaLaTeX only, njuthesis.cls:61-64)
- Look carried by: mixed (main.tex: kernel `book` plus preamble packages; the bundled upstream-example.tex: the published CTAN class `njuthesis` through class options and `\njusetup`)
- Class origin: ctan
- Main file: main.tex (other samples: upstream-example.tex, which is byte-identical to template/njuthesis-sample.tex; test/test.tex with test/chapters/*.tex and test/test-xetex-*.tex, test/test-luatex.tex; root and source/ copies of njuthesis.cls and the three njuthesis-*.def files, and root and template/ copies of njuthesis-setup.def, are byte-identical, so root paths are cited)
- Read: main yes, zip-local classes and styles all (njuthesis.cls 2165 lines, the three njuthesis-*.def files, njuthesis-setup.def and source/njuthesis-doc.cls read in full; njuthesis.dtx, 8384 lines, only grepped, it is the documented source from which njuthesis.ins:53-57 generates the .cls and .def files read here)

## Verdict
Yes. The main sample main.tex is the kernel `book` class, six published packages (geometry, fontspec, xeCJK, microtype, booktabs, hyperref) and kernel body commands; it defines no macro of its own, so every part maps to a lib way. The zip also bundles NJUThesis 1.5.1 (njuthesis.cls:27), which is on CTAN (ctan.org/pkg/njuthesis: v1.5.1 of 2026-05-30, LPPL 1.3c, /macros/unicodetex/latex/njuthesis); it is therefore published, one way `class.njuthesis`, and its sample upstream-example.tex only sets class options and `\njusetup` keys, so its expl3 internals are not bespoke. The one irreducible zip-local item, the manual's class njuthesis-doc.cls, is loaded by no template sample and is outside the rubric's scope (flagged in "Bespoke code"). Nothing was compiled.

## Blockers
none

## Class setting
- Class: `class.book` options: 11pt, a4paper, oneside (main.tex:2); a kernel class that ships with the TeX distribution, its source was not read.
- Class-native vocabulary used: `\frontmatter` (main.tex:13), `\mainmatter` (main.tex:25), `\appendix` (main.tex:47), `\chapter`, `\chapter*`, `\section`, `\maketitle`, `\tableofcontents`, `\addcontentsline{toc}{chapter}{..}` (main.tex:14-48).
- Also bundled and used by upstream-example.tex: `class.njuthesis` (it loads `ctexbook`, njuthesis.cls:803) options: `fontset = win` (upstream-example.tex:48); the other options are commented (upstream-example.tex:32-46).
- Class-native vocabulary of `class.njuthesis` used there: `\njusetup[info]`, `[bib]`, `[image]`, `[abstract]`, `[tableofcontents/dotline]` (njuthesis-setup.def:13,121,150,166,185); `\njusetformat` `\njusetname` `\njusetlength` (defined njuthesis.cls:769-780, only in comments at njuthesis-setup.def:242-257); environments `abstract`, `abstract*`, `acknowledgement` (upstream-example.tex:83,87,137), `notation` (commented, upstream-example.tex:107); `\maketitle`, `\tableofcontents`, `\mainmatter`, `\appendix`, `\cite`, `\printbibliography`; `\njuchapter`, `\njupaperlist` (commented, upstream-example.tex:146-148).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (main.tex) | main.tex:2 | `class.book` | 11pt, a4paper, oneside |
| paper and size | main.tex:2 | `page.class-options` | a4paper, 11pt, oneside |
| page geometry | main.tex:3 | `page.geometry` | a4paper, margin=30mm |
| fonts | main.tex:4 | `font.fontspec` | package loaded, no `\setmainfont` call, no font chosen |
| CJK support | main.tex:5 | `lang.cjk` | `xeCJK`, no options, no font commands |
| typography | main.tex:6 | `sp.microtype` | defaults |
| table rules package | main.tex:7 | `tbl.booktabs` | loaded; the body table uses no `\toprule` |
| links | main.tex:8 | `meta.hyperref` | hidelinks |
| title block | main.tex:9-11,14 | `front.maketitle` | `\title` with a `\\` break, `\author`, `\date{2026}`, `\maketitle` |
| front/main matter | main.tex:13,25 | `class.book` | `\frontmatter`, `\mainmatter` |
| unnumbered abstract chapters | main.tex:15,19 | `head.kernel` | `\chapter*{摘要}`, `\chapter*{Abstract}`; no `abstract` environment |
| manual contents entries | main.tex:16,20 | `toc.kernel` | `\addcontentsline{toc}{chapter}{..}` |
| contents list | main.tex:24 | `toc.kernel` | `\tableofcontents` |
| headings | main.tex:26,29,31,44 | `head.kernel` | `\chapter`, `\section`, default numbering |
| appendix | main.tex:47-48 | `num.appendix` | `\appendix`, then `\chapter` |
| inline maths | main.tex:32-33 | `math.kernel` | `$n$`, `$T(n)=T_0+rn$` (content) |
| table float | main.tex:34-43 | `tbl.tabular` | `table[ht]`, `tabular{lr}`, no rules |
| centering | main.tex:35 | `sp.ragged` | `\centering` |
| caption | main.tex:36 | `cap.kernel` | `\caption` above the tabular |
| list | main.tex:49-53 | `list.kernel` | `itemize`, three items |
| njuthesis: class and options | upstream-example.tex:29-50; njuthesis.cls:619-683,803 | `class.njuthesis` | `fontset=win`; defaults `type=bachelor`, `degree=academic`; keys `type` `degree` `nl-cover` `decl-page` `draft` `anonymous` `minimal` `oneside` `twoside` `latin-font` `cjk-font` `math-font` |
| njuthesis: paper and encoding | njuthesis.cls:788-794 | `page.class-options` | `a4paper`, `UTF8`, `scheme=chinese`, `fontset=none` passed to `ctexbook` |
| njuthesis: page geometry | njuthesis.cls:1330-1336 | `page.geometry` | vmargin=2.54cm, hmargin=3.18cm, headheight=15pt; `showframe` under `draft` |
| njuthesis: Latin fonts | njuthesis.cls:993-1000,1329 | `font.fontspec` | fontset win: Times New Roman, Arial, Courier New (`Scale=MatchLowercase`) |
| njuthesis: CJK | njuthesis.cls:684-685,1054-1066 | `lang.cjk` | `ctexbook` `zihao=-4`; SimSun, SimHei, FangSong, KaiTi, `AutoFakeBold=2.17` |
| njuthesis: maths font | njuthesis.cls:673,806-807,1252-1271,1902 | `font.unicode-math` | `math-font=xits` default, `math/style=GB` default; keys `integral` `partial` `vector` etc. (njuthesis.cls:1798-1898) |
| njuthesis: line spread | njuthesis.cls:685 | `sp.linespread` | `linespread=1.625` passed to `ctexbook` |
| njuthesis: header and footer | njuthesis.cls:1337-1391; njuthesis-undergraduate.def:269; njuthesis-graduate.def:587 | `hf.class-native` | keys `header/content`, `footer/content` (commented at njuthesis-setup.def:229-243); page style `plain` (bachelor) or `headings` (graduate); fancyhdr under the hood |
| njuthesis: page numbers | njuthesis.cls:1392-1409 | `pgnum.pagenumbering` | Roman in front matter, arabic in main matter |
| njuthesis: cover page | upstream-example.tex:76; njuthesis-setup.def:13-118; njuthesis.cls:1972-1979; njuthesis-undergraduate.def:106-112 | `front.class-native` | `\maketitle` runs the cover hooks; `\njusetup[info]` keys title, title*, author, author*, department, major, supervisor, grade, student-id, keywords, submit-date; graduate cover also clc, udc, chairman, reviewer |
| njuthesis: cover logos | njuthesis.cls:1937-1971; njuthesis-setup.def:150-163 | `fig.graphicx` | `\includegraphics[width=..]` of shipped nju-emblem-*.pdf and nju-name-*.pdf; `nju-logo-color=black\|purple` |
| njuthesis: abstract | upstream-example.tex:83-89; njuthesis.cls:2001-2044; njuthesis-setup.def:166-168 | `abs.class-native` | `abstract`, `abstract*`; `abstract/toc-entry=false`; `title-style=strict\|centered\|natural` |
| njuthesis: keywords | njuthesis-setup.def:29-35; njuthesis.cls:1980-1999 | `abs.keywords` | `keywords`, `keywords*` comma lists printed after each abstract |
| njuthesis: contents list | upstream-example.tex:92; njuthesis.cls:1456-1482 | `toc.kernel` | `\tableofcontents` redefined to a chapter-style list; `\listoffigures`, `\listoftables` commented (upstream-example.tex:94-96) |
| njuthesis: contents look | njuthesis-setup.def:185; njuthesis.cls:1483-1495 | `front.class-native` | `tableofcontents/dotline = chapter`; `toc-entry` booleans |
| njuthesis: headings | njuthesis.cls:1441-1455; njuthesis-undergraduate.def:262-263,274-280 | `head.class-native` | `ctex` chapter and section formats from `\njusetformat`; chapter beforeskip 10pt, afterskip 60pt |
| njuthesis: figure, table, equation numbers | njuthesis.cls:1699-1708 | `num.counters` | `label-sep` keys, default `-` (chapter-number) |
| njuthesis: appendix | upstream-example.tex:155 | `num.appendix` | `\appendix` |
| njuthesis: captions | njuthesis.cls:1689-1697 | `cap.caption` | style `njucap`: `font={small,bf}`, `labelsep=quad`; figure caption below, table caption above |
| njuthesis: tables | njuthesis.cls:822,1665 | `tbl.booktabs` | package loaded; `\njusetformat{tabular}` font hook before each tabular |
| njuthesis: lists | njuthesis.cls:707,1709 | `list.enumitem` | `\setlist{noitemsep}` |
| njuthesis: footnotes | njuthesis.cls:708,798,1599-1662 | `fn.footmisc` | `perpage`; `footnote/style = plain\|pifont\|circled`, `hang` |
| njuthesis: theorem keys | njuthesis.cls:1714-1788; njuthesis-setup.def:204-217 | `thm.class-native` | `\njusetup[theorem]{define,...}` makes axiom, corollary, definition, example, lemma, proof, theorem; not active in the sample |
| njuthesis: theorem engine | njuthesis.cls:706,800,1755-1757 | `thm.ntheorem` | `ntheorem[amsmath,thmmarks,noconfig]`, `\theoremstyle` `\theoremheaderfont` `\theorembodyfont` |
| njuthesis: cross references | njuthesis.cls:705,799,1566-1598 | `xref.cleveref` | `capitalise,nameinlink,noabbrev`; Chinese `\crefformat` strings |
| njuthesis: PDF and links | njuthesis.cls:827,1542-1565 | `meta.hyperref` | `bookmarksnumbered`, `psdextra`, `unicode`, `hidelinks`, pdftitle/pdfauthor from `info` |
| njuthesis: link in text | upstream-example.tex:138 | `meta.hyperref` | `\href{url}{text}` inside `acknowledgement` |
| njuthesis: bibliography | upstream-example.tex:131; njuthesis.cls:1499-1541; njuthesis-setup.def:121-147 | `bib.biblatex-biber` | `biblatex` `style=gb7714-2015` (numeric) or `gb7714-2015ay`; `resource=njuthesis-sample.bib`; `\printbibliography` heading `njubibintoc`; backend not set by the class, so the biblatex default (biber); the style package is not in the zip and was not read |
| njuthesis: acknowledgement, preface, declaration | upstream-example.tex:137-139; njuthesis.cls:2045-2050; njuthesis-undergraduate.def:113-132 | `front.dedication` | `acknowledgement`, `preface` environments; `decl-page` option adds a declaration page |
| njuthesis: symbol list | njuthesis.cls:2151-2162 | `front.class-native` | `notation`, `notation*` over kernel `\list`; commented in the sample (upstream-example.tex:107-110) |
| njuthesis: paper list | njuthesis.cls:2098-2099 | `bib.biblatex-biber` | `\njupaperlist[title]{keys}`; commented in the sample (upstream-example.tex:146-148) |
| njuthesis: bottom alignment | upstream-example.tex:81 | `pg.flush` | `\raggedbottom` |
| njuthesis: blank pages | njuthesis.cls:829 | `pg.emptypage` | `emptypage` loaded under `twoside` |
| njuthesis: CJK underline | njuthesis.cls:830-839 | `mark.ulem` | `xeCJKfntef` `\CJKunderline` (XeTeX) or `lua-ul` (LuaTeX) as `\njuline` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| macros in the main sample | main.tex:1-54 | none defined | none |
| `njuthesis.cls` internals: expl3 box and glue helpers, xtemplate cover-page instances, hooks, `\@makefntext` and `\l@chapter` redefinitions | njuthesis.cls:117-542,1486-1493,1654-1661 | not bespoke: published class (CTAN v1.5.1, the version in the zip) | the emitter writes `\documentclass[..]{njuthesis}` and `\njusetup{..}` (`class.njuthesis`); the code would be BESPOKE/class if the class were zip-local |
| `njuthesis-undergraduate.def`, `-graduate.def`, `-postdoctoral.def`, `njuthesis-setup.def` | njuthesis-undergraduate.def:32-287; njuthesis-graduate.def:32-605; njuthesis-postdoctoral.def:32-284; njuthesis-setup.def:13-257 | not bespoke: installed with the published class (generated by njuthesis.ins:53-56); the setup file is `\njusetup` key lists | `class.njuthesis` keys as in the map above |
| `njuthesis-doc.cls` (the manual's class: rewrites ctxdoc internals, loads `njuvisual` and `codehigh`, which are not in the zip) | source/njuthesis-doc.cls:32-307 | irreducible, if it were in scope | out of scope, not a blocker: generated by the same njuthesis.ins:57 for the manual (njuthesis.dtx:143 is the manual driver), loaded by neither main.tex nor upstream-example.tex, so rubric scope 1 to 3 does not reach it; flagged because a stricter reading would make it BESPOKE/class |
| developer tooling: scripts/*.py, scripts/*.sh, scripts/generate-img.tex, build.lua, install-unix.sh, install-win.bat, source/latexmkrc | scripts/generate-img.tex:3,6,8; build.lua:1-35 | not template code | loaded by no sample; generate-img.tex needs `--shell-escape` and `njuvisual`, but its output PDFs (nju-emblem-*.pdf, nju-name-*.pdf) are shipped, so nothing runs at compile time |

## Content-opaque
- none in main.tex or upstream-example.tex.
- Other samples only: `chemfig` scheme and `mhchem` `\ce` text (test/chapters/Specific.tex:94-98,153-161, `art.content-package`); the entries of njuthesis-sample.bib.
- Missing assets, not content: no CJK or Latin font is shipped (main.tex:4-5 name none; fontset=win needs SimSun, SimHei, FangSong, KaiTi, STZhongsong, Times New Roman, Arial, Courier New, njuthesis.cls:995-1063,1193-1219). The emblem and name PDFs are shipped.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
