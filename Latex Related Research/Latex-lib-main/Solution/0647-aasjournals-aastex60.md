yes

# 0647-aasjournals-aastex60: AASTeX v6.3 (AAS Journals manuscript class, sample63)

- Unverified: read from the source, not compiled.
- Source: Source/0647-aasjournals-aastex60/ (origin: https://codeload.github.com/AASJournals/AASTeX60/zip/refs/heads/main, the AAS Journals' own repository; licence: LPPL-1.3c, also stated at cls/aastex63.cls:43-47)
- Kind: journal
- Lib: v5
- Engine: pdfLaTeX-compatible (the sample's own build recipe is pdflatex plus bibtex, sample/sample63.tex:1412-1419)
- Look carried by: class (the sample's preamble holds only three `\newcommand` aliases, sample/sample63.tex:91-93; every look comes from `cls/aastex63.cls` and the AAS `.bst`)
- Class origin: publisher-official
- Main file: sample/sample63.tex (other samples: docs/aassymbols.tex with `\documentclass[twocolumn]{aastex63}` at line 1, other/natbib.tex with `\documentclass[onecolumn]{aastex63}` at line 1; other/natnotes.tex is natbib documentation under `article`, not a template; sample/widetab.tex is a table fragment)
- Read: main yes, zip-local classes and styles partly (cls/aastex63.cls: lines 1-1669, 1800-2159, 4670-4819, 5260-5289, 5500-5839, 5855-5904, 6040-6109, 6190-6339, 6855-6964 and 7060-7536 read; NOT read: 1670-1799 legacy journal-name macros, 2160-4669 and 4820-5259 and 5290-5499 table engine bodies (decimal, hide, split machinery), 5840-5854, 5905-6039, 6110-6189, 6340-6854, 6965-7059; cls/aastex631.cls and cls/aastex632.cls only diffed against aastex63 (706 and 67 differing lines) and not read, the sample loads neither; bst/aasjournal.bst only lines 1-60 and the `\providecommand` lines read)

## Verdict
yes. The sample loads the AAS Journals' own class `aastex63` with no options and adds only three `\newcommand` text aliases; every front-matter, table, figure, editing and bibliography construct it calls is the class's published vocabulary, and the bibliography is BibTeX with the publisher's `aasjournal.bst`. The class is the publisher's official kit (README: official releases live on the AAS Journals repository and website), so by the rubric it is one published way, `class.aastex63`, not bespoke code. No `ART`, `EXTERNAL`, `UNMAPPED` or irreducible `BESPOKE` item was found; the class's internal `\halign` table engine and `\@startsection` redefinitions are the published class's own code, counted inside the class way.

## Blockers
none

## Class setting
- Class: `class.aastex63`; options used by the sample: none (`\documentclass{aastex63}`, sample/sample63.tex:26). Defaults forced by the class: `\ExecuteOptions{onecolumn,onecolappendix,letteredappendix}` (cls/aastex63.cls:261). Options the class offers and the sample only lists in comments (sample/sample63.tex:28-71): `manuscript` `preprint` `preprint2` `modern` `twocolumn` `RNAAS` `astrosymb` `tighten` `times` `linenumbers` `trackchanges` `longauthor` `twocolappendix` `anonymous` (cls/aastex63.cls:158-257).
- Base class: the class does `\LoadClass[nofootinbib,showkeys,twoside,floatfix,superscriptaddress,flushbottom,10pt,aps,pra]{revtex4-1}` (12pt in the 12pt styles; `unsortedaddress` with `longauthor`) at cls/aastex63.cls:291-307 after checking the file exists (cls/aastex63.cls:280-286). revtex4-1 is a published class in the TeX distribution and is not bundled in the zip; its source was not read. It is the base of the class way, not a second way of the sample. The sample text says amsmath comes with this stack (sample/sample63.tex:1022-1024); not verified in source.
- Class-native vocabulary used by the sample:
  - front matter: `\received` `\revised` `\accepted` `\submitjournal` `\shorttitle` `\shortauthors` `\correspondingauthor` `\email` `\author[ORCID]{}` `\affiliation` `\altaffiliation` `\collaboration{n}{text}` `\nocollaboration{n}` `abstract` `\keywords` `\acknowledgments` `\facilities` `\software` (sample/sample63.tex:96-101, 149-150, 219-254, 269-294, 1172-1205)
  - sectioning: `\section` `\subsection` `\subsubsection` `\appendix` (sample/sample63.tex:311, 525, 560, 1216)
  - tables: `deluxetable` `deluxetable*` `splitdeluxetable*` `longrotatetable` `\tablenum` `\tablecaption` `\tablewidth` `\tabletypesize` `\tablehead` `\colhead` `\nocolhead` `\multicolumn2c` `\colnumbers` `\decimalcolnumbers` `\startdata` `\enddata` `\nodata` `\tablecomments`; column letters `D` (decimal), `h` (hidden), `B` (split) (sample/sample63.tex:645-673, 698-733, 1266-1347)
  - figures: `\plotone` `\gridline` `\fig` `\figsetstart` `\figsetnum` `\figsettitle` `\figsetgrpstart` `\figsetgrpnum` `\figsetgrptitle` `\figsetplot` `\figsetgrpnote` `\figsetgrpend` `\figsetend` `interactive` environment (sample/sample63.tex:740, 810-817, 859-911, 944, 997)
  - editing marks: `\added` `\deleted` `\replaced` `\explain` `\edit1` `\edit2` `\edit3` (sample/sample63.tex:1103-1106, 1122-1125)
  - units and links: `\nom` `\Eenom` `\Epnom` `\Jenom` `\Jpnom` `\nomSolarEffTemp` and the other `\nom...` constants, `\doi` (sample/sample63.tex:1366-1407, 1166)
  - bibliography: `\bibliographystyle{aasjournal}` (sample/sample63.tex:1422)

## Component map
All paths are relative to Source/0647-aasjournals-aastex60/. Rows marked "inside class" are set by the class file, not written by an emitter; they are listed so the parameters are on record.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | sample/sample63.tex:26; cls/aastex63.cls:83-84 | `class.aastex63` | no options; `\ProvidesClass{aastex63}[2019/06/03 Version 6.3/AAS markup document class]` |
| style options (one or two columns, 10 or 12 pt, spacing) | cls/aastex63.cls:158-181, 261; sample/sample63.tex:28-71 | `page.class-options` | default onecolumn 10pt single space; `manuscript` = 12pt double space, `preprint` = 12pt single, `preprint2` and `twocolumn` = two columns, `modern` = 12pt wide margins, `RNAAS` = modern without abstract; sample sets none |
| columns | cls/aastex63.cls:178, 1094-1096, 1248 | `cols.twocolumn-option` | option `twocolumn`; revtex `\twocolumngrid` / `\onecolumngrid` switch inside the class; sample stays one column |
| page geometry (inside class) | cls/aastex63.cls:590-614 | `page.setlength` | `\textwidth=7.1in`, `\columnsep=0.3125in`, `\parindent=0.125in`, `\voffset=-20mm`, `\hoffset=-7.5mm`, `\topmargin=0in`, `\headheight=.15in`, `\headsep=0.5in`, `\oddsidemargin=0in`, `\evensidemargin=0in`, `\textheight=64\baselineskip` capped at 25cm then minus 54pt |
| font sizes (inside class) | cls/aastex63.cls:358-500 | `font.size-commands` | `\normalsize` 10/12.5 (12pt styles 12/15, modern 12/16, manuscript 12/24), `\small` 9/11, `\footnotesize` 8/9.5, `\large` 12/14, `\Large` 14/18, `\LARGE` 17/22 |
| Times text (option) | cls/aastex63.cls:268-276 | `font.mathptmx` | option `times` loads `\usepackage{times}`; not used by the sample |
| line spread, list and skip lengths (inside class) | cls/aastex63.cls:333, 506-537, 601 | `sp.linespread`, `sp.lengths` | `\baselinestretch` 1.0; `\smallskipamount` 3pt, `\medskipamount` 6pt, `\bigskipamount` 12pt; `\@listi` topsep 8pt itemsep 4pt; `\parskip=0cm` |
| line-breaking tolerance | cls/aastex63.cls:603, 7101-7105 | `sp.hyphenat` | `\tolerance` 600 then 9999 (the `\sloppy` family; `\sloppy` is also called inside the bibliography list, cls/aastex63.cls:1368); with `\emergencystretch 1em` and `\hfuzz .5\p@` set through `sp.lengths` |
| colours | cls/aastex63.cls:2094-2096, 5740, 5808 | `color.xcolor` | `\usepackage{xcolor}`; `\definecolor{xlinkcolor}{cmyk}{1,1,0,0}`, `ltgray` gray .9, `ltblue` cmyk .5,.1,.1,0 |
| hyperref and links | cls/aastex63.cls:2101-2110, 7075 | `meta.hyperref` | `bookmarks=true`, `pdfnewwindow=true`, `colorlinks=true`, `linkcolor=citecolor=filecolor=urlcolor=xlinkcolor`, `final=true`; `\doi#1` = `\href{https://doi.org/#1}{https://doi.org/#1}` |
| url | cls/aastex63.cls:2078, 2099, 7073; sample/sample63.tex:313, 419 | `meta.url` | `\usepackage{url}` with `hyphens` passed in; `\urlstyle{rm}` |
| title | sample/sample63.tex:167-168; cls/aastex63.cls:779-788, 790-799 | `front.class-native` | `\title[short]{...}` with `\footnote` inside the title; format `\normalsize\bf\centering`; footnotes in the title kicked out after it (cls/aastex63.cls:747-776) |
| authors, affiliations, collaborations | sample/sample63.tex:219-254; cls/aastex63.cls:804-826, 836-868, 6231-6244, 6856-6881, 6905-6931 | `front.class-native` | author `\small\scshape\centering`; affiliation `\footnotesize\it`; `\author[ORCID]` links to orcid.org and prints `\includegraphics[width=9pt]{Orcid-ID.png}` when the file is found (cls/aastex63.cls:6237-6243); `\collaboration{1}{(...)}` limit and text; `\nocollaboration` prints a dash; `\correspondingauthor` and `\email` become unnumbered footnotes (cls/aastex63.cls:6863-6876) |
| dates and journal line | sample/sample63.tex:96-101; cls/aastex63.cls:5761-5762, 5781-5793 | `front.class-native` | `\submitjournal{AJ}` prints "Submitted to AJ"; received, revised, accepted lines |
| front-matter assembly | cls/aastex63.cls:5765-5804, 1072-1082 | `front.class-native` | `\maketitle` is run by the first `\section`; title page style `titlepage`; title block then authors, dates, abstract, keywords |
| abstract | sample/sample63.tex:269-288; cls/aastex63.cls:872-927 | `abs.class-native` | `abstract` environment boxed, heading `ABSTRACT` centred (cls/aastex63.cls:879-887), width 478pt (cls/aastex63.cls:875, 900), `\normalsize\parindent=9pt`, `\leftskip=34pt` |
| keywords | sample/sample63.tex:293-294; cls/aastex63.cls:965-991 | `abs.keywords` | `\keywords{...}` shown through option `showkeys` (cls/aastex63.cls:293); label `Keywords:` italic; `\leftskip=34pt`, `\rightskip=0.5in`, hanging indent |
| running heads | sample/sample63.tex:149-150; cls/aastex63.cls:623-635 | `hf.class-native` | `\shorttitle` = `\lefthead`, `\shortauthors` = `\righthead`; `\ps@apjheads` small-caps heads lowered 9mm, page number at the outer edge, empty feet; `anonymous` replaces the author head with "Anonymous author(s)" |
| page styles | cls/aastex63.cls:637, 5751-5756, 5773 | `hf.pagestyle-kernel` | `\pagestyle{apjheads}`; `\thispagestyle{titlepage}` on page one (head carries the watermark slot) |
| headings | sample/sample63.tex:311, 421, 469, 525, 560; cls/aastex63.cls:1072-1114, 1128, 1137-1183 | `head.class-native` | `\section` = `\@startsection{section}{1}{\z@}{9pt plus 1pt minus 1pt}{4pt}{\apjsecfont\center}`, text upper-cased (`\sec@upcase`) and numbered "N. "; `\subsection` `\normalsize\itshape\center`; `\subsubsection` `\small\itshape\center`; paragraph run-in `\small\itshape` |
| section numbering | cls/aastex63.cls:1066, 1117-1120 | `num.secnumdepth` | `\setcounter{secnumdepth}{3}`; `\thesection` `\arabic`, `\thesubsection` `\thesection.\arabic{subsection}` |
| appendix | sample/sample63.tex:1216-1232; cls/aastex63.cls:1245-1291 | `num.appendix` | `\appendix` prints a centred `APPENDIX`, resets section, subsection and equation counters, `\thesection` `\Alph`, `\theequation` `\Alph{section}\arabic{equation}`; figure and table counters continue |
| acknowledgments | sample/sample63.tex:1172; cls/aastex63.cls:1205-1228 | `front.class-native` | `\acknowledgments` followed by text up to the paragraph end; heading `\section*{Acknowledgments}`; `anonymous` replaces the text by a notice |
| facilities, software | sample/sample63.tex:1194, 1202; cls/aastex63.cls:1537-1559 | `front.class-native` | labelled lines `Facilities:` and `Software:` in `\large\it` |
| lists | sample/sample63.tex:367-401, 548-554 | `list.kernel` | nested `itemize` and `enumerate`; item spacing from the class's `\@listi` and following (cls/aastex63.cls:510-537) |
| footnotes | sample/sample63.tex:168, 283, 313, 347; cls/aastex63.cls:1049-1059 | `fn.kernel` | `\footnotesep 12pt`, `\skip\footins 24pt` (36pt in manuscript), `\footnoterule` removed, `\@makefntext` indents 3mm |
| text marks | sample/sample63.tex:285, 504, 582, 1000 | `mark.kernel` | `\textbf`, `\underline`, `\textit`, `\emph`, `{\tt\string\...}` |
| manual spacing | sample/sample63.tex:430, 780, 1193, 1362 | `sp.manual-space` | `\\`, `\break`, `\vspace{5mm}`, `\vskip12pt`, `\noindent` |
| display maths | sample/sample63.tex:1037-1078, 1225-1227; cls/aastex63.cls:1402-1419 | `math.kernel` | `equation`, `eqnarray` (class version shrinks `\arraycolsep` to 0.25, tabskip centring), `\nonumber`, `array` |
| math symbol packages | cls/aastex63.cls:325, 327 | `math.amssymb` | `\RequirePackage{latexsym}` and `\RequirePackage{amssymb}` |
| deluxetable family | sample/sample63.tex:645-673, 698-733, 1266-1347; cls/aastex63.cls:4679, 4688-4819, 5009, 5267-5268, 1817-1832, 1933-1942 | `class.aastex63` | class-native table vocabulary recorded under Class setting: `deluxetable*` with `\tablenum{1}`, `\tablewidth{0pt}` (width written to the aux file, cls/aastex63.cls:1942-1952), `\tabletypesize{\scriptsize}`, `\tablehead{\colhead..}`, column letters `c l r D h B`, `\decimalcolnumbers`, `\startdata..\enddata`, `\tablecomments` (small, `\sc Note---`) |
| long table switch | cls/aastex63.cls:2091, 4679 | `tbl.longtable` | `\usepackage{longtable}` loaded unconditionally; `\startlongtable` selects the longtable form of `deluxetable` |
| plain tabular | sample/sample63.tex:1364-1371, 1379-1384, 1391-1407; cls/aastex63.cls:2122, 1999, 2001 | `tbl.tabular` | `\usepackage{array}`; `@{\vrule height 14pt depth 6pt width0pt}lll`, `p{3in}`; `\tabcolsep` 5pt, `\doublerulesep` 1.5pt; `\hline` `\cline{5-14}` in the deluxetable head (sample/sample63.tex:709, 722) |
| strut rule | sample/sample63.tex:1364 | `sp.rule` | `\vrule height 14pt depth 6pt width0pt` |
| rotated tables | sample/sample63.tex:1266-1347; cls/aastex63.cls:5536-5565, 5570-5611 | `class.aastex63` | `rotatetable` and `longrotatetable` environments, `\movetabledown` length |
| rotation call | cls/aastex63.cls:5544, 5582 | `fig.rotating` | `\rotatebox{90}` from `graphicx`; `\pdfpageattr{/Rotate 90}` only under option `pdftex` (cls/aastex63.cls:5600-5602) |
| figure floats | sample/sample63.tex:739-746, 809-822, 913-923; cls/aastex63.cls:1572-1585 | `fig.graphicx` | `figure[ht!]`, `figure*`; `\plotone` = `\includegraphics[width=0.85\linewidth]`, `\plottwo` 0.425\linewidth each; `\RequirePackage{epsf,graphicx}` (cls/aastex63.cls:343, epsf unused: the sample includes PDF only) |
| grid figures | sample/sample63.tex:809-822; cls/aastex63.cls:5638-5666 | `class.aastex63` | `\gridline{...}` = `\hbox to\hsize`; `\fig{file}{width}{subcaption}` = `\includegraphics` plus a `\footnotesize` centred sub-caption |
| figure sets | sample/sample63.tex:859-911; cls/aastex63.cls:2066-2076 | `class.aastex63` | `\figset...` calls print only "Fig. Set N. title"; component commands print nothing (`\noprint`) |
| interactive figure frame | sample/sample63.tex:943-953, 996-1013; cls/aastex63.cls:7199-7216, 5810-5815 | `class.aastex63` | `interactive{animation\|js\|timeseries}{file}` checks its arguments then wraps the figure in `\highlightfigure`, which is `\fcolorbox{ltblue}{white}` with `\fboxrule=4pt`, `\fboxsep=12pt` (the frame is `box.fancybox` type, a declarative coloured box, not artwork) |
| framed box | cls/aastex63.cls:5810-5815 | `box.fancybox` | `\fcolorbox`, `\fboxrule=4pt`, `\fboxsep=12pt`, colours `ltblue` on `white` |
| captions | sample/sample63.tex:741-745; cls/aastex63.cls:1429-1430, 1503-1521, 1865-1882 | `cap.kernel` | `\caption`; class `\@makecaption`: `\small`, bold label, one centred line when it fits, `\abovecaptionskip` 5pt, `\belowcaptionskip` 4pt; label `Figure~N` bold `\footnotesize` |
| float placement parameters | sample/sample63.tex:739; cls/aastex63.cls:1427-1447 | `fig.placement` | `topnumber` 9, `bottomnumber` 9, `totalnumber` 20, `dbltopnumber` 9, `\topfraction` 1.0, `\bottomfraction` 1.0, `\textfraction` 0.0, `\dbltopfraction` 0.85, `\dblfloatpagefraction` 0.85, `\textfloatsep` 9pt, `\dbltextfloatsep` 0pt |
| editing marks | sample/sample63.tex:1103-1106, 1122-1125; cls/aastex63.cls:5706-5716, 5859, 5906, 5977, 6045, 6055-6088 | `class.aastex63` | `\added` `\deleted` `\replaced` `\explain` active only with option `trackchanges`; `\edit1` bold, `\edit2` italic, `\edit3` plain with colours `editcolor1..3` (all `black` in this version, cls/aastex63.cls:5701-5703); `\listofchanges` |
| strike-out for edits | cls/aastex63.cls:6040, 6090-6091 | `mark.ulem` | `\PassOptionsToPackage{normalem}{ulem}`, `\usepackage{ulem}`; `\sout` inside `\replaced` and `\deleted` |
| line numbers (option) | cls/aastex63.cls:5821-5829 | `sp.draft-lineno` | option `linenumbers` loads `lineno`, `\linenumbers*[1]`; not used by the sample |
| nominal-unit macros | sample/sample63.tex:1366-1407; cls/aastex63.cls:7111-7128 | `class.aastex63` | `\nom{Q}` = `\leavevmode\hbox{\boldmath$\mathcal{Q}^{\rm N}_{\odot}$}` and the `\Eenom` `\Epnom` `\Jenom` `\Jpnom` and `\nom...` constant macros |
| cross-references | sample/sample63.tex:311, 347, 407-415, 692 | `xref.kernel` | `\label{sec:intro}`, `\ref{sec:pubcharge}`, `\label` inside `\caption` |
| verbatim samples | sample/sample63.tex:1366-1384 | `code.verbatim` | `\verb+\nom{}+` |
| citations | sample/sample63.tex:315, 820, 1202; cls/aastex63.cls:319-330 | `bib.natbib` | `\citep`, `\citet`; `\bibpunct{(}{)}{;}{a}{}{,}` and `\@citestyle{aas}`; sorting and compression forced off (`\NAT@sort` 0, `\NAT@cmprs` 0); natbib itself comes with the base class (not read) |
| bibliography | sample/sample63.tex:1421-1422; bst/aasjournal.bst:1-3, 1781-1787; cls/aastex63.cls:1323, 1330-1379 | `bib.bibtex-bst` | `\bibliographystyle{aasjournal}` (publisher `aasjournal.bst` v1.18b), `\bibliography{sample63}{}`; class `thebibliography`: heading `REFERENCES`, two columns, `\small`, `\itemindent=-1.0em`, `\leftmargin=1.0em`, `\baselineskip=13pt plus 1pt`, labels removed; the `.bbl` carries `\providecommand{\dodoi}`, `\doarXiv`, `\doeprint` |
| reference-list breaking | cls/aastex63.cls:1313-1314, 1356-1357, 1368 | `sp.penalties`, `sp.frenchspacing` | `\hyphenpenalty=10000`, `\clubpenalty10000`, `\widowpenalty10000`; `\frenchspacing` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\vdag}{(v)^\dagger}` | sample/sample63.tex:91 | yes | inline `(v)^\dagger` (`math.kernel`); never called in the body |
| `\newcommand\aastex{AAS\TeX}` | sample/sample63.tex:92 | yes | text alias; expand inline to `AAS\TeX` at each use (sample/sample63.tex:167, 273, ...) |
| `\newcommand\latex{La\TeX}` | sample/sample63.tex:93 | yes | text alias; expand to `\LaTeX` |
| `cls/aastex63.cls` (7536 lines, hand-written, based on emulateapj and revtex4-1; redefines `\begin`/`\end` hooks at lines 553-576, `\section` at 1072, `\@sect` at 1137, `\eqnarray` at 1402, `\@makecaption` at 1865, the table engine with `\halign` at about 2160-5530) | cls/aastex63.cls | not bespoke by W1 | publisher-official kit from the AAS Journals' own repository (README.md:7-9, 17); counted as the published way `class.aastex63`, so its internals are not decomposed; ctan.org/pkg/aastex lists only AASTeX v7.0.1 (a later class generation), so `aastex63` is the publisher's v6 release and not a CTAN class |
| `cls/aastex631.cls`, `cls/aastex632.cls` | cls/aastex631.cls, cls/aastex632.cls | not bespoke by W1 | later official releases (v6.3.1, v6.3.2, README.md:3-9, 42-43); not loaded by the sample; would be `class.aastex631` and `class.aastex632` if a document chose them |
| `bst/aasjournal.bst` | bst/aasjournal.bst:1-3 | not bespoke by W1 | publisher-official BibTeX style, a parameter of `bib.bibtex-bst` |

## Content-opaque
- figure artwork: sample/cost.pdf, V2491_Cyg.pdf, HV_Cet.pdf, LMC_2009.pdf, RS_Oph.pdf, U_Sco.pdf, KT_Eri.pdf, f4.pdf, f5.pdf included at sample/sample63.tex:740, 810-817, 914, 945, 998.
- interactive-figure bundles named at sample/sample63.tex:944 (`movie.mp4`, not shipped in the zip; the class only checks that the argument is non-empty, cls/aastex63.cls:7208-7211) and sample/sample63.tex:997 (`interactive.tar.gz`, shipped as sample/interactive.tar.gz); HTML and JavaScript payloads are content.
- table data of the deluxetables (sample/sample63.tex:657-666, 719-726, 1283-1344) and the equations (sample/sample63.tex:1037-1078, 1225-1227).
- sample/sample63.bib bibliography entries; sample/orcid-ID.png icon (the class opens `Orcid-ID.png`, cls/aastex63.cls:6238, so a case-sensitive file system would not find the shipped lower-case `orcid-ID.png`; the icon is then silently omitted).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Considered, not proposed: a separate component line for a class's own table environments (the deluxetable family); the lib's practice (change log v3, v4) records a published class's own vocabulary under its class way, so the rows above name `class.aastex63` and the vocabulary sits under "Class setting".
