yes

# 0380-hausarbeit-jura: hausarbeit-jura (class for juristische Hausarbeiten, German university term papers)

- Unverified: read from the source, not compiled.
- Source: Source/0380-hausarbeit-jura/ (origin: https://mirrors.ctan.org/macros/latex/contrib/hausarbeit-jura.zip; licence: LPPL 1.3, "v1.3c or later" at README.md:10)
- Kind: assignment
- Lib: v4
- Engine: pdfLaTeX-compatible (the manual says the class runs only under pdfLaTeX, hausarbeit-jura.dtx:608-611, because the base class `jurabook` fails on Unicode engines; a `fontspec` branch exists at hausarbeit-jura.dtx:716-717 but is behind `\ifPDFTeX` at hausarbeit-jura.dtx:699; the manifest hint `xelualatex` is not supported by the source)
- Look carried by: class (the whole look is the CTAN class `hausarbeit-jura`; the sample sets no look of its own, only content and the class's title-page fields)
- Class origin: ctan
- Main file: hausarbeit-jura.dtx (demo document in the `demo` block, lines 1155-1218, extracted to `hausarbeit-demo.tex` by hausarbeit-jura.ins:46; other samples: the manual driver at hausarbeit-jura.dtx:74-116, a manual of the package and not a document made with the template)
- Read: main yes, zip-local classes and styles all (the zip has no `.cls`; the class code is hausarbeit-jura.dtx:621-1119 and was read in full, as were the driver, the manual text, the `.ins` and the README; not read: the base class `jurabook`, `jurabib`, `fancyhdr`, `setspace`, which are not in the zip; the PDF manual was not opened)

Citations `hausarbeit-jura.dtx:N` are lines of Source/0380-hausarbeit-jura/hausarbeit-jura.dtx.

## Verdict
yes. The zip is the source of a published class (CTAN and TeX Live, LPPL, version 2.1.0 per ctan.org/pkg/hausarbeit-jura), and the demo document uses only that class's own vocabulary plus `blindtext` filler (hausarbeit-jura.dtx:1158-1217). One way, `class.hausarbeit-jura`, carries the look; an emitter writes `\documentclass[options]{hausarbeit-jura}` and the native commands. For the record, the class's own code (a thin layer over `jurabook` and published packages) is also decomposed below, and every piece reduces to lib ways. Caveat: where `jurabook` is hosted was not established (ctan.org/pkg/jurabook returned 404; the hausarbeit-jura CTAN page names it as the base), and `\TODO`, `\xref`, `\subtitle` are not defined in this zip (presumably in `jurabook`, not read). That is a gap in what was read, not a blocker, because the emitter never writes `jurabook`.

## Blockers
none

## Class setting
- Class: `class.hausarbeit-jura`. Options in the demo: none (hausarbeit-jura.dtx:1158); defaults `\ExecuteOptions{12bp,american,utf8,automatter}` (hausarbeit-jura.dtx:678). Available: sizes `10bp` `11bp` `12bp` `10pt` `11pt` `12pt` (hausarbeit-jura.dtx:671-677), `american` `british` `english` (hausarbeit-jura.dtx:629-643), `latin1` `utf8` `ansinew` `applemac` (hausarbeit-jura.dtx:644-647), `centerpagenumber` (hausarbeit-jura.dtx:648-651), `texgyre` `oldfonts` (hausarbeit-jura.dtx:652-655), `nosuperscriptedition` (hausarbeit-jura.dtx:656-658), `varioref` (hausarbeit-jura.dtx:659-661), `headline` `headlinetitlepageleft` (hausarbeit-jura.dtx:662-667), `automatter` `noautomatter` (hausarbeit-jura.dtx:668-670); any other option goes to `jurabook` (hausarbeit-jura.dtx:679).
- Base class loaded by the class: `jurabook` with `a4paper,oneside,showpagenumber,classiclayout` (hausarbeit-jura.dtx:682-683); not in the zip, not read.
- Class-native vocabulary used by the sample: `\title` `\subtitle` `\author` `\matrikelnummer` `\semester[Fachsemester]{..}` `\prof` `\date` `\maketitle` (hausarbeit-jura.dtx:1163-1171), `\tableofcontents` (hausarbeit-jura.dtx:1173), `\bibliography` (hausarbeit-jura.dtx:1174), `\chapter` `\section` `\subsection` `\subsubsection` `\subthreesection` to `\subeightsection` (hausarbeit-jura.dtx:1177-1212), `\TODO` (hausarbeit-jura.dtx:1178), `\cite[..]{..}` in a `\footnote` (hausarbeit-jura.dtx:1183), `\ref` `\pageref` `\xref` (hausarbeit-jura.dtx:1213-1215). Also in the class and not in the demo: `\author[short]{..}` (hausarbeit-jura.dtx:1002-1004), `\setpgfront` `\setpgmain` `\setpg` (hausarbeit-jura.dtx:978-980), `\setspacebeforechapter` `\setspaceafterchapter` `\setspacebeforesection` `\setspaceaftersection` (hausarbeit-jura.dtx:867-868, 875-876), `\frontmatter` `\mainmatter` (hausarbeit-jura.dtx:948-966), the lengths `\sectionbefore` `\sectionafter` (hausarbeit-jura.dtx:871-874).

## Component map
Part A is what the demo selects, the emitter's view. Part B is the class's own code, for the record: each row reduces to published lib ways and is not needed once `class.hausarbeit-jura` is the way.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| A. document class | hausarbeit-jura.dtx:1158 | `class.hausarbeit-jura` | no options; defaults 12bp, american, utf8, automatter |
| A. paper and size | hausarbeit-jura.dtx:671-678, 682 | `page.class-options` | `12bp` (bp-sized text, the default), `a4paper,oneside` passed to the base class |
| A. title block | hausarbeit-jura.dtx:1163-1171 | `front.class-native` | `\title{Hausarbeit}` `\subtitle{..}` `\author{..\\..}` `\matrikelnummer{123456}` `\semester[3. Fachsemester]{Wintersemester 2015/2016}` `\prof{..}` `\date{..}` `\maketitle` |
| A. review note | hausarbeit-jura.dtx:1178 | `class.hausarbeit-jura` | native `\TODO{text}` (documented at hausarbeit-jura.dtx:475; its definition is not in the zip) |
| A. contents | hausarbeit-jura.dtx:1173 | `toc.kernel` | `\tableofcontents`; entry indents come from the class (row B toc indents) |
| A. headings | hausarbeit-jura.dtx:1177-1212 | `head.class-native` | `\chapter` plus `\section` to `\subeightsection`, nine levels, look fixed by the class |
| A. footnote | hausarbeit-jura.dtx:1183 | `fn.kernel` | `\footnote{.. \cite[348, 349]{hau98}}` |
| A. citation | hausarbeit-jura.dtx:1183 | `bib.apacite` | jurabib `\cite[Stelle]{key}` (optional arguments by literature type, hausarbeit-jura.dtx:569-577) |
| A. bibliography | hausarbeit-jura.dtx:1174, 791 | `bib.bibtex-bst` | `\bibliography{hausarbeit-demo}`, style `jurabib` set by the class; `.bib` with jurabib fields `shortauthor` `shorttitle` (hausarbeit-jura.dtx:1139-1140) |
| A. cross-references | hausarbeit-jura.dtx:1177, 1213-1215 | `xref.kernel` | `\label` `\ref` `\pageref`; `\xref{label}` is a class-native shorthand (defined in the base class, not in the zip) |
| A. filler text | hausarbeit-jura.dtx:1159, 1181 | `draft.todo` | `\usepackage{blindtext}`, `\blindtext[4]` (filler content; the package is the parameter) |
| B. fonts, pdfTeX default | hausarbeit-jura.dtx:699-714 | `font.fontenc-t1` | `inputenc`, `[T1]{fontenc}`, `textcomp`, `eurosym`, `\let\texteuro\euro`, `\DeclareUnicodeCharacter{20AC}{\unspace\,\euro}` (`\unspace` is not defined in this zip) |
| B. fonts, serif | hausarbeit-jura.dtx:703 | `font.mathptmx` | `tgtermes` |
| B. fonts, sans | hausarbeit-jura.dtx:704 | `font.helvet` | `[matchlowercase]{tgheros}` |
| B. fonts, mono | hausarbeit-jura.dtx:705 | `font.mono` | `[matchlowercase]{tgcursor}` |
| B. euro sign | hausarbeit-jura.dtx:712-714 | `font.icons` | `eurosym` `\euro` |
| B. fonts, option `oldfonts` | hausarbeit-jura.dtx:707-709 | `font.mathptmx`, `font.helvet`, `font.mono` | `mathptmx`, `[scaled=0.91]{helvet}`, `courier` |
| B. fonts, non-pdfTeX branch | hausarbeit-jura.dtx:716-717 | `font.fontspec` | `\setmainfont{Times New Roman}` (not usable in practice, see Engine) |
| B. language | hausarbeit-jura.dtx:629-643, 678, 719 | `lang.babel` | `\PassOptionsToPackage{american,ngerman}{babel}` by default, `{british,ngerman}` for `british` and `english` |
| B. quotation marks | hausarbeit-jura.dtx:731-733, 1107-1108 | `lang.csquotes` | `[autostyle]`; two `\defineshorthand` calls bind the quote-open and quote-close shorthands to `\openautoquote` and `\closeautoquote`; `\let\frqq\glqq` `\let\flqq\grqq` |
| B. first-line indent | hausarbeit-jura.dtx:720 | `sp.indentfirst` | load only |
| B. ellipsis spacing | hausarbeit-jura.dtx:730 | `sp.ellipsis` | load only |
| B. microtype | hausarbeit-jura.dtx:734-735 | `sp.microtype` | `final,tracking=smallcaps,expansion=alltext,protrusion=true`; `\SetTracking{encoding=*,shape=sc}{50}` |
| B. page geometry | hausarbeit-jura.dtx:721-729 | `page.geometry` | main matter `left=7cm,right=1cm,top=1cm,bottom=1.5cm,footskip=0.5cm,marginparwidth=5cm,verbose` (plus `includehead` with `headline`), saved as `pagemainmatter`; front matter `left=2cm,right=2cm,top=2cm,bottom=2cm`, saved as `pagefrontmatter`; switched with `\loadgeometry` at hausarbeit-jura.dtx:950, 962; user macros hausarbeit-jura.dtx:978-980 |
| B. margin note width | hausarbeit-jura.dtx:1102-1105 | `sp.lengths` | after every `\geometry`: `\marginparwidth` = 0.6 `\oddsidemargin` + 1in |
| B. margin note side | hausarbeit-jura.dtx:952, 964 | `note.marginpar` | `\reversemarginpar` |
| B. line spacing | hausarbeit-jura.dtx:951, 963 | `sp.setspace` | `\onehalfspacing` (the load of `setspace` is not in this file; presumably the base class) |
| B. running head and foot | hausarbeit-jura.dtx:736-759, 953-955, 965-966 | `hf.fancyhdr` | page number right (`\rfoot{\thepage}`) or centre (`\cfoot`), `\headrulewidth` 0pt, `\fancyfootoffset[RO,RE]{2cm}`; option `headline`: `\lhead{short author -- Matrikelnummer}`, `\fancyheadoffset[L]`; `\pagestyle{fancyplain}` (no `fancyhdr` load in this file; presumably the base class) |
| B. page numbering | hausarbeit-jura.dtx:1051, 948-966 | `pgnum.pagenumbering` | `\setcounter{page}{2}` after the title page; `\frontmatter` and `\mainmatter` |
| B. title page | hausarbeit-jura.dtx:1018-1052 | `front.titlepage-env` | `titlepage` environment; centred title, subtitle, "Bei <prof>", semester, date; `\let\footnote\thanks`, `\let\footnoterule\relax` |
| B. title page author block | hausarbeit-jura.dtx:1023-1030 | `tbl.tabular` | `tabular[t]{l}`, rows author, Matrikelnummer, Fachsemester joined by `\tabularnewline`; right aligned with `\hfill`, left with `headlinetitlepageleft` |
| B. title page spacing | hausarbeit-jura.dtx:1031-1048 | `sp.manual-space` | `\null\vfil`, `\vskip` 2ex, 4ex, 1ex, 2ex, 4ex |
| B. title page notes | hausarbeit-jura.dtx:1020-1022 | `front.thanks` | footnotes on the title page turn into `\thanks` |
| B. counters | hausarbeit-jura.dtx:807-815 | `num.counters` | chapter `\Alph{chapter})`, section `\Roman{section}.`, subsection `\arabic.`, subsubsection `\alph)`, then `(\arabic)`, `(\alph)`, `(\alph\alph)`, `(\alph\alph\alph)`, `(\roman)` |
| B. chapter look | hausarbeit-jura.dtx:864-868, 984-990, 993, 996 | `head.class-native` | `\jb@chapter@style` = `\LARGE\bfseries`; space after 20pt, before 15pt; no section sign before the number; `\jb@author@style` = `\normalsize` |
| B. section look | hausarbeit-jura.dtx:871-946 | `head.kernel` | `\@startsection` per level 1 to 9: indent 0, before `-\sectionbefore` (2ex), after `\sectionafter` (1ex); font `\normalfont\Large\bfseries` (section), `\large\bfseries` (subsection), `\normalsize\bfseries` (levels 3 to 9); aliases `\subsubsubsection` and so on |
| B. heading fonts | hausarbeit-jura.dtx:884, 891, 898 | `font.size-commands` | `\Large`, `\large`, `\normalsize` |
| B. toc indents | hausarbeit-jura.dtx:817-861, 993 | `sp.lengths` | `\settowidth` of sample numbers (`III.\ `, `8.\ `, `b)\ `, ...) and `\setlength`/`\addtolength` of the toc indent lengths; entries without number bold |
| B. jurabib setup | hausarbeit-jura.dtx:761-789 | `bib.apacite` | `\jurabibsetup{annotatorfirstsep=in,bibformat=tabular,titleformat={all,commasep},commabeforerest,superscriptedition=all,howcited=all,authorformat=dynamic}` (`superscriptedition` dropped by `nosuperscriptedition`); `\jbedseplikecite`; separators `\bibatsep` `\jbaensep` `\bibbdsep` `\bibjtsep` `\bibbtsep` `\ajtsep` `\artnumberformat`; columns `\bibleftcolumn` = `\textwidth/3`, `\bibrightcolumn` |
| B. bibliography style and toc entry | hausarbeit-jura.dtx:791-792 | `bib.bibtex-bst` | `\bibliographystyle{jurabib}`, `\bibtotoc` |
| B. varioref option | hausarbeit-jura.dtx:797-804 | `xref.varioref` | `[ngerman]{varioref}`; `\reftextafter` and `\reftextbefore` = `auf S.~\thevpagerefnum`; `\xref` = `\ref{#1} \vpageref{#1}` |
| B. line breaking | hausarbeit-jura.dtx:1109, 1111 | `sp.hyphenat` | `\tolerance 1414`, `\emergencystretch 1.5em` |
| B. diagnostic thresholds | hausarbeit-jura.dtx:1110, 1112, 1115 | `sp.lengths` | `\hbadness 1414`, `\hfuzz 0.3pt`, `\vfuzz\hfuzz`; no printed effect |
| B. widows and clubs | hausarbeit-jura.dtx:1113-1114 | `sp.penalties` | `\clubpenalty=5000`, `\widowpenalty=9999` |
| B. page bottom | hausarbeit-jura.dtx:1116 | `pg.flush` | `\raggedbottom` |
| Manual driver (other sample, out of scope) | hausarbeit-jura.dtx:74-116 | `class.ltxdoc`, `dtx.doc` | `[a4paper]{ltxdoc}`, `\OnlyDescription` `\CodelineIndex` `\EnableCrossrefs` `\RecordChanges`, `\DocInput{hausarbeit-jura.dtx}`; loads babel, fontenc, libertine or lmodern, microtype, upquote, booktabs, tabularx, listings, setspace, csquotes, hologo, xcolor, hyperref (not decomposed further: manual only) |

## Bespoke code
Everything in the class file sits inside a published class, so none of it is bespoke in the rubric's sense; the reductions below show that it would reduce anyway.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| bp-sized text (`\@vpt` to `\@xxvpt` redefined to bp) | hausarbeit-jura.dtx:684-698 | yes | the `12bp` class option (`page.class-options`); without the class: `font.size-commands` with bp-valued `\fontsize` |
| `\maketitle` and `\@emptytitles` | hausarbeit-jura.dtx:1018-1086 | yes | `front.titlepage-env` + `tbl.tabular` + `sp.manual-space`; `\@emptytitles` only resets the stored fields after printing, no printed effect |
| `\author[short]` `\semester[..]` `\prof` `\matrikelnummer` | hausarbeit-jura.dtx:1001-1016 | yes | string stores (`\def`, `\gdef`) that the title page prints; the emitter passes the values as arguments |
| automatic `\mainmatter` at the first `\chapter` | hausarbeit-jura.dtx:967-976 | yes | class option `noautomatter` (hausarbeit-jura.dtx:428-437, 668-670) and explicit `\frontmatter` and `\mainmatter` (`pgnum.pagenumbering`) |
| `\frontmatter` and `\mainmatter` wrappers | hausarbeit-jura.dtx:948-966 | yes | `\loadgeometry`, `\onehalfspacing`, `\reversemarginpar`, `\fancyfootoffset` as in the rows above |
| `\geometry` wrapper | hausarbeit-jura.dtx:1102-1105 | yes | `page.geometry` then one `sp.lengths` assignment |
| section `\@startsection` renewals, counters, toc indent lengths | hausarbeit-jura.dtx:807-861, 878-946 | yes | `head.kernel`, `num.counters`, `sp.lengths` as in the rows above |
| `\@setsize` redefinition | hausarbeit-jura.dtx:1088-1100 | yes | never called in this file (a LaTeX 2.09 size command); no printed effect shown |
| `\vref@addto\extrasngerman` | hausarbeit-jura.dtx:799-801 | yes | varioref's `\reftextafter` and `\reftextbefore` set in the babel language hook |
| `\TODO`, `\xref`, `\subtitle`, `\unspace`, `\setjbooklength`, `\jb@*` | used at hausarbeit-jura.dtx:1178, 1215, 1164, 714, 867 | not judged | defined in the base class or `jurabib`, not in the zip, not read; vocabulary of the class way |
| manual scaffolding: `\DescribeOption`, `LaTeXdemo` (`listings` write-file hack), `\newinsert\bx@S` and `\@freelist` | hausarbeit-jura.dtx:188-324 | no | out of scope by decision: it typesets the package's manual, not a document made with the template. If the manual were taken as the sample this would be BESPOKE/preamble |

## Content-opaque
none. The `.bib` entries (hausarbeit-jura.dtx:1126-1154) and the `blindtext` paragraphs are content. The demo has no figure, table, equation or code.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
