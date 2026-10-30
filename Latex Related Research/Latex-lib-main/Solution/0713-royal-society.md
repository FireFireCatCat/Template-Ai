yes

# 0713-royal-society: Royal Society journal template (rstransa, Phil. Trans. R. Soc. A)

- Unverified: read from the source, not compiled.
- Source: Source/0713-royal-society/ (origin: https://royalsocietypublishing.org/pb-assets/RSTA%20assets/rsta-TeX-1542035661397.zip; licence: not established)
- Kind: journal
- Lib: v5
- Engine: pdfLaTeX-compatible (the kit's own shipped log names pdfTeX, RSTA_Author_tex.log:1; no fontspec, no Lua; the only `\special{ps:...}` code, rstransa.cls:1399-1407, is never called by the sample)
- Look carried by: class (rstransa.cls sets page, fonts, colours, title page, headings, captions and running heads; the sample adds only content, three `\newtheorem` lines and class-native commands)
- Class origin: publisher-official (the zip is the publisher's own author kit; ctan.org/pkg/rstransa returns 404, so it is not on CTAN)
- Main file: rsta-new/RSTA_Author_tex.tex (other samples: rsta-new/Instructions.tex, the kit's own manual; no `\maketitle` in it)
- Read: main yes, zip-local classes and styles all (rstransa.cls lines 1-1524 in full; rsta.bst, a BibTeX style no sample calls, only its header lines 1-70 and a grep outline of its FUNCTION lines)

File names are unique in the zip, so citations use bare names: RSTA_Author_tex.tex, Instructions.tex and rstransa.cls sit in rsta-new/; rsta.bst sits at the zip root.

## Verdict
yes, under the pilot ruling that a publisher's official kit is published. `rstransa.cls` is the Royal Society's own class (W1 by the official-kit rule; W2 options and string commands such as `openacc`, `\jname`, `\Journal`; W3 serves the journal, not one paper; W4 one `\documentclass` line), so it is the one way `class.rstransa`. The sample adds three `\newtheorem` calls and body constructs from the kernel, amsmath and the class vocabulary, all mapped below. The class is a 1524-line hand-rolled class that re-implements `\@startsection`, `\@makecaption` and `\@maketitle`; if it were counted as zip-local those would be irreducible `BESPOKE/class` blockers (listed under Bespoke code), so this yes is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.rstransa` options: `openacc` (RSTA_Author_tex.tex:8). Defaults the class executes: `nocrop,a4paper,centre,openbib,Capsgreek` (rstransa.cls:51, each declared at 30-40); `twoside`, `onecolumn` and `final` are also named at line 51 but the class never declares them (no `\DeclareOption` for them in 24-49), so they do nothing and the text block is set by raw lengths (309-346). Other declared options: `usetimes usemathtime doublespace nospace link draft crop info noinfo grid` (rstransa.cls:24-38). The class never calls `\LoadClass`; it is a stand-alone class.
- Class-native vocabulary used: `\title` `\author` `\address` `\subject` `\keywords` `\corres{..\email{..}}`, environments `abstract` and `fmtext` (both stored in boxes and printed by `\maketitle`), `\maketitle`, end statements `\ethics` `\dataccess` `\aucontribute` `\competing` `\funding` `\ack` `\disclaimer` (RSTA_Author_tex.tex:22-46, 51, 99, 161-173). Documented but not used by the sample: `\jname` `\Journal` (Instructions.tex:59). Defined by the class and not used: `\supertitle` `\Doi` `\Year` `\Vol` `\artid` `\Issue` `\Pages` `\rec` `\acc` `\pub` `\onlinepub` `\Copyrightinfo` `\history` `\esm` `\others` `\citearticle` `\classification` `\shorttitle` `\startpage` `\endpage` `\printqry` `\query` `\processtable` `\tabhead` `\tabnote` `\toprule` `\midrule` `\botrule` `\tcontinued` `\bcontinued` `\source` `\leftno` `\fmbreak` `\sfrac` and the `scheme` float (rstransa.cls:78, 395-399, 405-431, 1137-1236, 867-949, 1466-1468, 1478-1499).
- Class constants: `\figurename` `\tablename` `\refname` `\abstractname` and `\today` are plain `\newcommand`s in English (rstransa.cls:1089-1103); no language package is loaded.

## Component map
Rows marked (class) are set inside `rstransa.cls`; the emitter writes nothing for them except the class line.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | RSTA_Author_tex.tex:8 | `class.rstransa` | option `openacc`: selects the CC-BY footer text and the open-access logo (rstransa.cls:38, 490-493, 1192) |
| paper size (class) | rstransa.cls:309-310 | `page.setlength` | paperheight 247truemm, paperwidth 174truemm; no geometry package; sample forbids changing margin lengths (RSTA_Author_tex.tex:10) |
| text block and margins (class) | rstransa.cls:312-346 | `page.setlength` | textwidth 135mm (324), textheight 53 baselines minus 1.9pt (326-327), oddsidemargin 19.5mm minus 1in (333-334), evensidemargin computed (335-339), topmargin 12.15mm+8pt-1in (313-315), headheight 7pt (312), headsep (318-319), footskip 23pt (321), marginpar 4.2pc (329-331), columnsep 10pt (1104) |
| page options | rstransa.cls:30-33, 51, 55 | `page.class-options` | `a4paper` and `centre` only forward `a4` and `center` to the CTAN package `crop`, default `nocrop`; the paper size is fixed by the lengths above |
| front page in two columns (class) | rstransa.cls:1303, 1350 | `cols.minipage` | side-by-side minipages 50mm (logo, journal URL, subject, keywords, correspondence) and 80mm (title, authors, abstract, first-page text), `\vbox to 242mm` and `239mm` (1305, 1351) |
| running head and foot (class) | rstransa.cls:420-423, 479-486, 488-514, 1383, 1446 | `hf.class-native` | `plain` page style on page 1: RS logo scale 0.15 plus 75mm tinted box with copyright text (489-497); `headings` style: rotated head with journal URL, `\Journal`, `\artid`, page number in a black box (483-486, 506-507); set by `\jname` `\Journal` `\Year` `\artid` strings (405-418) |
| page numbers | rstransa.cls:1107, 375-376 | `pgnum.pagenumbering` | `\pagenumbering{arabic}`; `\startpage{n}` sets the counter |
| body text face (class) | rstransa.cls:83, 85 | `font.palatino` | `\usepackage{palatino}` after `\usepackage[T1]{fontenc}` |
| encoding (class) | rstransa.cls:83 | `font.fontenc-t1` | `[T1]` |
| sans face (class) | rstransa.cls:86 | `font.helvet` | `\usepackage[scaled=0.85]{helvet}` |
| font sizes (class) | rstransa.cls:88-124 | `font.size-commands` | `\normalsize` 9/12 pt (89), `\small` 9/11, `\large` 12/14, `\LARGE` 17/22 and so on |
| sans font switches (class) | rstransa.cls:420-423, 658-660, 893-896, 1120-1127 | `font.nfss` | `\fontfamily{\sfdefault}\fontseries{m}\fontshape{n}\fontsize{16}{18}\selectfont` style lists for head, section levels, captions, title (20/22), authors (14/22), address (11/15), abstract (rm 9/12), bibliography (rm 9/11, line 1038) |
| old font switches | rstransa.cls:965-971; RSTA_Author_tex.tex:13-15, 148 | `mark.kernel` | `\DeclareOldFontCommand{\bf}`; sample uses `\bf` in theorem names and in a table cell |
| math fonts (class) | rstransa.cls:1421-1427, 1448-1450 | `font.nfss` | `\DeclareMathSizes` table; `\DeclareSymbolFont{EulerExtension}{U}{euex}{m}{n}` and `\DeclareMathSymbol` for `\intop` `\ointop` |
| colours (class) | rstransa.cls:62, 463, 470-472 | `color.color` | `\usepackage{color}`; `\definecolor` jobcolor cmyk{1,.10,0,.10}, joblightcolor, abstractcolor cmyk{.04,.04,.12,.08}, gray cmyk{0,0,0,.2} |
| abstract panel (class) | rstransa.cls:1368, 483 | `box.fancybox` | `\colorbox{abstractcolor}` on a 75mm `vbox`; black `\colorbox` behind the page number |
| title rules (class) | rstransa.cls:1360, 1362 | `sp.rule` | `\rule{80mm}{.5pt}` above and below the author line |
| ragged setting (class) | rstransa.cls:1120-1127 | `sp.ragged` | `\raggedright` inside the title, author, address, keyword and subject font lists |
| paragraph shape (class) | rstransa.cls:285-286 | `sp.lengths` | parskip 0pt, parindent 1pc; also arraycolsep 5pt, tabcolsep 6pt (857-858), jot 5pt (1429), medmuskip 4mu, thickmuskip 3.5mu (1434-1435), fboxsep 6pt (1431) |
| line-break penalties (class) | rstransa.cls:296-307, 1437-1441 | `sp.penalties` | clubpenalty and widowpenalty 10000, brokenpenalty 10000, hyphenpenalty 10000, displaywidowpenalty 100, predisplaypenalty 10000; `\doublehyphendemerits` 640000 and `\finalhyphendemerits` 1000000 (integer line-breaking parameters, nearest way) |
| tolerance and hyphenation (class) | rstransa.cls:1437-1438, 1409-1419 | `sp.hyphenat` | `\tolerance=9999`, `\vbadness=9999` (the `\sloppy` family); `\hyphenation{Table}` and ten more words |
| spacing mode (class) | rstransa.cls:1443-1444 | `sp.frenchspacing` | `\frenchspacing` |
| page flow (class) | rstransa.cls:1443 | `pg.flush` | `\flushbottom` |
| title and author block | RSTA_Author_tex.tex:22-25, 28-30, 99; rstransa.cls:1132-1142, 1153, 1244-1298, 1301-1385 | `front.class-native` | `\title{}`, `\author{}` (superscript numbers), `\address{}`, `\maketitle` after the abstract and `fmtext`; title in `\titlefont` jobcolor with bold math version (1121, 1358) |
| subject areas | RSTA_Author_tex.tex:33; rstransa.cls:1183-1187 | `abs.classification` | `\subject{..}`: line headed "Subject Areas:" in the left column (the class also has `\classification` for JEL codes, 1233-1236; nearest way, the lib line names CCS, MSC, PACS and JEL codes) |
| keywords | RSTA_Author_tex.tex:36; rstransa.cls:1176-1180 | `abs.keywords` | `\keywords{..}`: "Keywords:" label sans bold 10/14 above the list |
| corresponding author | RSTA_Author_tex.tex:39-40; rstransa.cls:1200-1204, 1242, 1476 | `front.class-native` | `\corres{name\\\email{..}}`; fixed head "Author for correspondence:"; `\email` is `\href{mailto:..}` |
| abstract | RSTA_Author_tex.tex:43-46; rstransa.cls:1155-1156 | `abs.class-native` | `abstract` environment stored in `\absbox` with `\abstractfont`, rightskip 14.2pc; printed by `\@maketitle` |
| first-page text | RSTA_Author_tex.tex:51-95; rstransa.cls:1158-1174, 1370-1373 | `front.class-native` | `fmtext` environment stored in `\fmtextbox`, hsize 18.8pc, printed under the abstract (it holds sections and equations in the sample) |
| end statements | RSTA_Author_tex.tex:161-173; rstransa.cls:1501-1510 | `front.class-native` | `\ethics` `\dataccess` `\aucontribute` `\competing` `\funding` `\ack` `\disclaimer`: jobcolor 9pt run-in label, 8/11 text, `\vskip5.5pt` |
| headings | RSTA_Author_tex.tex:52, 59, 63, 67, 101, 125, 155; rstransa.cls:658-681, 684-734 | `head.class-native` | `\section` sans 16/18 jobcolor, space -12pt/6pt; `\subsection` 14/18, 10pt/6pt; `\subsubsection` 12/14, 9pt/6pt; all via a copy of `\@startsection` and `\@sect` |
| heading numbering (class) | rstransa.cls:610-622, 662-670 | `num.counters` | section arabic with a trailing dot, subsection `(a)`, subsubsection `(i)`; `\renewcommand\thesubsection` and so on |
| numbering depth (class) | rstransa.cls:610, 977 | `num.secnumdepth` | secnumdepth 3, tocdepth 3 |
| display maths | RSTA_Author_tex.tex:72-84 | `math.amsmath` | `align` with `split`, `\label` |
| display maths, kernel | RSTA_Author_tex.tex:87-94 | `math.kernel` | `eqnarray` with `array`, `\noalign{\vskip3pt}` (90), `\notag` (92) |
| math packages (class) | rstransa.cls:56, 64-76 | `math.amssymb` | amsmath, amssymb, amsfonts, upref loaded; option `Capsgreek` maps `\Gamma` to `\varGamma` and so on |
| equation numbers (class) | rstransa.cls:865-866, 853 | `math.amsmath` | `\numberwithin{equation}{section}`; appendix numbering `A\hskip2pt n` (853) |
| theorem statements | RSTA_Author_tex.tex:13-15, 103-122; rstransa.cls:57 | `thm.amsthm` | `\newtheorem{theorem}{\bf Theorem}[section]`, `{condition}`, `{corollary}`, no `\theoremstyle` so plain; class loads amsthm and adds `\newtheorem{mythm}{mythm}[section]` (1390) |
| figure float | RSTA_Author_tex.tex:129-134; rstransa.cls:867-878 | `fig.graphicx` | `figure[!h]` with caption and label; the `\includegraphics` line is commented out (130); class default placement `tbp` (869) |
| table float | RSTA_Author_tex.tex:140-153; rstransa.cls:897-908 | `tbl.tabular` | `table[!h]`, `tabular{llll}` with `\hline`, caption above the table (141) |
| captions (class) | RSTA_Author_tex.tex:132, 141; rstransa.cls:951-964, 909-912 | `cap.kernel` | `\caption` with `\@makecaption`: bold sans head "Figure 1." then 2.5pt skip and 8.5/10 text, abovecaptionskip 6.75pt, belowcaptionskip 9pt |
| float placement (class) | rstransa.cls:348-373 | `fig.placement` | topnumber 5, bottomnumber 5, totalnumber 10, topfraction .921, bottomfraction .921, textfraction .079, floatpagefraction .887, floatsep 18pt, textfloatsep 20pt, intextsep 18pt |
| manual spacing in the body | RSTA_Author_tex.tex:127, 136, 138, 152, 156 | `sp.manual-space` | `\vspace*{-7pt}`, `{-5pt}`, `{-7pt}`, `{-4pt}`, `\vskip6pt` |
| page height tweak | RSTA_Author_tex.tex:158; Instructions.tex:6; rstransa.cls:1297 | `pg.enlarge` | `\enlargethispage{20pt}`; class adds `{-8pt}` after the title |
| bibliography | RSTA_Author_tex.tex:177-191; rstransa.cls:1034-1061 | `bib.thebibliography` | `thebibliography{9}` with four `\bibitem`; class: `\section*{\refname}`, `\bibfont` 9/11, label `n.`, clubpenalty and widowpenalty 4000, `\sloppy` |
| citation package (class) | rstransa.cls:1464 | `bib.cite-pkg` | `\usepackage[nospace]{cite}`; the sample has no `\cite` |
| BibTeX style (not used) | rsta.bst:1-14 | `bib.bibtex-bst` | `rsta.bst`, made with makebst (merlin.mbs) and edited by the publisher; the sample has no `\bibliographystyle` |
| links | RSTA_Author_tex.tex:180, 183; rstransa.cls:1515-1522 | `meta.hyperref` | `bookmarksnumbered,raiselinks,breaklinks`, `colorlinks`, citecolor, filecolor, linkcolor, urlcolor all `blue` |
| labels and references | RSTA_Author_tex.tex:72, 79, 103, 115, 133, 142 | `xref.kernel` | `\label` on equations, theorems, figure and table |
| footnotes (class, unused) | rstransa.cls:1387-1388, 1352 | `fn.kernel` | empty `\footnoterule`, 7/10 pt footnote text; `\footnote` is `\thanks` in the title column |
| endnotes (class, unused) | rstransa.cls:56 | `fn.endnotes` | `endnotes` loaded, not called |
| lists (class, unused) | rstransa.cls:736-776 | `list.kernel` | leftmargini 32.5pt, enumi `(i)`, bullet `\textbullet` |
| quotes (class, unused) | rstransa.cls:801-821, 1161-1165 | `quote.kernel` | `quote` 9pt with rightmargin 15.2pc inside `fmtext`; `verse`, `quotation` |
| contents (class, unused) | rstransa.cls:978-1031 | `toc.kernel` | `\tableofcontents` `\listoffigures` `\listoftables` |
| appendix (class, unused) | rstransa.cls:852-856 | `num.appendix` | `\appendix` with letter sections |
| margin notes (class, unused) | rstransa.cls:58, 78 | `note.marginnote` | `\query{..}` is `\marginnote` |
| table packages (class, unused) | rstransa.cls:80-81, 393, 924, 1474 | `tbl.siunitx` | `dcolumn` with `D{.}{.}{-1}`; also `colortbl` (`tbl.colortbl`), `longtable` (`tbl.longtable`), `\newcolumntype{P}` |
| graphics and rotation (class) | rstransa.cls:60-61, 1490-1491 | `fig.rotating` | `graphicx`; `rotating[figuresright]` (the rotated running head uses `turn`, 484) |
| logos (assets) | rstransa.cls:489, 1192-1193, 1305 | `fig.graphicx` | `\includegraphics` of `RS_Pubs_Logo_Line_CMYK`, `RSTA_OpenAccesslogo_RGB`, `RS_crossmark_logo`, `PHILOSOPHICAL_TRANSACTIONS_A_CMYK`; each shipped as .pdf and .eps in rsta-new/ |
| upper-casing (class) | rstransa.cls:510, 981 | `mark.case` | `\MakeUppercase` in `\sectionmark` (510) and in the contents heading (981); the headings style does not print `\rightmark`, so no effect in the sample |
| letter-spacing (class, unused) | rstransa.cls:59, 408-410 | `mark.ulem` | `soul` loaded; `\sodef\stitletrack{}{0.11em}{0.5em}{\z@}` used only by `\mytrack`, which nothing calls |
| index (class, unused) | rstransa.cls:1062-1080 | `idx.makeidx` | `theindex` environment, `\item` as `\@idxitem` (hangindent 40pt), `\subitem`, `\indexspace`; no `makeidx` package is loaded |
| last-page label (class, unused) | rstransa.cls:379-389, 401-403, 418 | `pgnum.lastpage` | the class writes its own `LastPage` label at the end; only the default of `\Pages` reads it |
| manual page style | Instructions.tex:3 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no running head in the manual) |
| manual verbatim | Instructions.tex:21, 25-51, 64-72 | `code.verbatim` | `verbatim` environments and `\verb+..+` |
| manual spacing | Instructions.tex:91 | `sp.manual-space` | `\vskip2.5pc` |

## Bespoke code
In the sample (RSTA_Author_tex.tex): only the three `\newtheorem` lines (13-15), reducible to `thm.amsthm`. No `\newcommand`, `\def` or counter of its own.

In the published class (not zip-local under the official-kit ruling, so not counted; recorded so the result can be re-read if the class is treated as zip-local):

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| copies of `\@startsection` and `\@sect` | rstransa.cls:684-734 | n/a (class) | would be BESPOKE/class: kernel sectioning internals redefined |
| `\@makecaption` | rstransa.cls:951-964 | n/a (class) | would be BESPOKE/class: kernel caption internals redefined (box measuring and a branch on width) |
| `\@maketitle` and `\maketitle` | rstransa.cls:1244-1298, 1301-1385 | n/a (class) | would be BESPOKE/class: two fixed minipages with `\vbox to 242mm`, boxes `\absbox` and `\fmtextbox`, conditionals that drive what prints |
| `\ps@plain` `\ps@headings`, `\myrunhead` | rstransa.cls:488-514, 483-486 | n/a (class) | would be BESPOKE/class: hand-built page styles with a rotated head |
| LastPage label writer | rstransa.cls:379-403 | n/a (class) | would be BESPOKE/class; the label feeds only `\Pages`, which the sample never prints |
| `\processtable`, `\toprule` family, `\midruledotfill` | rstransa.cls:916-949 | n/a (class) | would be BESPOKE/class: `\noalign` rule code and a leaders-based dotted rule; not used by the sample (it uses `\hline`) |
| `\leftno`, `\vdotsfor`, `\l` `\L` redefinitions | rstransa.cls:1483-1497, 1490-1491 | n/a (class) | would be BESPOKE/class; unused by the sample |
| `\rotstart`, `\rotl`, `\rotr` | rstransa.cls:1399-1407 | n/a (class) | dvips `\special{ps: ...}` code, defined and never called by the class or the sample (the `rotating` package is loaded instead, 61) |
| `\innerframe`, `\pressmark`, `picture` puts | rstransa.cls:449-465, 501, 1513 | n/a (class) | proofing aids: the grid draws only with option `grid` (449), the "ARTICLE IN PRESS" bar only when `\ifpressmark`, which no option sets (18, 465); inactive in the sample's build, so not template artwork |
| author-query page | rstransa.cls:1246-1268 | n/a (class) | `\input\jobname_AQ.tex` runs only after `\printqry` (395-399), which the sample does not call; the file is not shipped |

## Content-opaque
none (the figure float holds only a caption; its `\includegraphics` is commented out at RSTA_Author_tex.tex:130; equations at 72-94 are content)

## Lib changes
- New ways proposed: none. Considered and not proposed: `crop` and `vruler` (packages the class loads at rstransa.cls:54-55; `crop` defaults to `nocrop`, and no component of the sample prints their output) and `upref` (loaded at rstransa.cls:56; the v4 lib change log rejected a way for `upref` because no sample loaded it; here the class loads it, but the class way `class.rstransa` carries it, so nothing needs proposing). The CTAN pages of these three were not read.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes
- Documentation mismatch: Instructions.tex:64-72 lists `times mathtime bm url babel endfloat setspace geometry courier` and others as packages "used by the class file", but rstransa.cls loads none of them (its `\usepackage` list is at lines 54-62, 80, 83, 85-86, 393, 924, 1464, 1515); the class options `usetimes`, `usemathtime` and `doublespace` set flags that nothing reads (12-14, 24-26).
- No text addressed to an AI was found in the zip.
