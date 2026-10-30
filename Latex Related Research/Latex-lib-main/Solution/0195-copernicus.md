yes

# 0195-copernicus: Copernicus Publications manuscript template (copernicus.cls)

- Unverified: read from the source, not compiled.
- Source: Source/0195-copernicus/ (origin: https://publications.copernicus.org/Copernicus_LaTeX_Package.zip; licence: not established)
- Kind: journal
- Lib: v4
- Engine: pdfLaTeX-compatible (class has LuaTeX branches, copernicus.cls:29-33, 1364-1377; loads `fontenc` T5,T3,T1 and `inputenc` utf8, copernicus.cls:1326, 1364; PDF page boxes through the pdfTeX `\pdfpageattr`, copernicus.cls:276-280)
- Look carried by: class (the look is defined in `copernicus.cls` with `copernicus.cfg`; `template.tex` adds only an option list and the class's own commands)
- Class origin: publisher-official
- Main file: template.tex (other samples: none)
- Read: main yes, zip-local classes and styles partly (copernicus.cls all 3156 lines; copernicus.cfg lines 1-200 and 1195-1225, the other ~1000 lines are 60 journal blocks that a pattern filter showed to hold only names, urls, logo and colour lines; copernicus.bst header and outline only; pdfscreen.sty and pdfscreencop.sty head, package list and a diff of the two, because neither is on this sample's load path)

## Verdict
The zip is the publisher's own author kit (origin is publications.copernicus.org, README_copernicus_package_7_16.txt:3-10), so `copernicus.cls` is a published class under W1 and is one way, `class.copernicus`. The sample defines no macro, package or colour of its own: its only active lines are the option list at template.tex:12 and the class's native commands, and everything the class loads unconditionally is a published package that needs no outside tool. This is the "look carried by a published class" case, so the result is evidence about the class dimension, not about component ways. Re-read note: if the publisher kit were not accepted as W1, the class internals listed under "Bespoke code" (`\@startsection`, `\@maketitle`, `\@makecaption`, `\@tabular`) would be `BESPOKE/class` and the verdict would be `no`.

## Blockers
none

## Class setting
- Class: `class.copernicus` options: `manuscript` (one-column manuscript layout, copernicus.cls:120, 171-180, 1316-1324) and the placeholder `journal abbreviation` (template.tex:12). The placeholder matches no `\DeclareOption`, so it is passed on to `article` (copernicus.cls:156); the real values are the ~60 journal codes declared in copernicus.cfg:1-93 (for example `acp`), each of which sets face, abstract and bar switches (copernicus.cfg:1-93), while names, url, logo and colours follow in `\@addjournalconfig` (copernicus.cfg:97 onward, for example the `acp` block from line 125). With `manuscript` the face and abstract switches are reset (copernicus.cls:162-167) and the colours go back to black (copernicus.cls:3040-3045). The class builds on `\LoadClass[fleqn]{article}` (copernicus.cls:169) and rejects `a4paper`, `10pt` to `12pt`, `twocolumn`, `fleqn` and the like (copernicus.cls:89-105). Other options: `noauthor` `nolastpage` `noref` `debug` `nohyperref` `online` `proof` `noline` `corrigendum` `editorialnote` `preface` `forHTML` `hvmath` (copernicus.cls:111-149), `copyediting` `proofreadingchanges` (copernicus.cfg:5-6).
- Class-native vocabulary used: `\title`, `\Author[affil][corr]{given}{surname}`, `\affil[label]{text}`, `\runningtitle`, `\runningauthor`, `\received` `\pubdiscuss` `\revised` `\accepted` `\published` `\firstpage`, `\maketitle`, `abstract`, `\copyrightstatement`, `\introduction`, `\conclusions`, `\codeavailability` `\dataavailability` `\codedataavailability` `\sampleavailability` `\videosupplement`, `\appendix` `\noappendix` `\appendixfigures` `\appendixtables`, `\authorcontribution` `\competinginterests` `\disclaimer`, `acknowledgements`, `thebibliography` with `\bibitem[AUTHOR(YEAR)]{key}` (template.tex:85-224). Documented only in comments: `\tophline` `\middlehline` `\bottomhline` `\belowtable`, `sidewaystable*`, `\chem`, `reaction`, `\unit`, `\citet` `\citep` `\citeauthor` `\citeyear` (template.tex:238-248, 285-325, 384-397).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | template.tex:12; copernicus.cls:18, 169 | `class.copernicus` | options `manuscript`, journal code; base `article[fleqn]` loaded inside the class |
| page size, margins | copernicus.cls:172-180, 228-241 | `page.class-options` | option `manuscript`: textwidth 177mm, textheight `660pt-37mm+11.4mm`, side margins 16.4mm, topmargin 10mm, headheight and headsep 0, footskip 30pt; trim 210mm x 240mm plus `\bleed` 3mm; fixed in the class, not settable by the author |
| PDF trim and bleed boxes | copernicus.cls:238-254, 276-280 | `page.class-options` | TrimBox, CropBox, BleedBox written with `\pdfpageattr` from the page offsets; no author parameter |
| page style choice | copernicus.cls:1307-1311 | `hf.pagestyle-kernel` | `\pagestyle{plain}` for manuscript (`headings` otherwise) |
| running foot, page number | copernicus.cls:399-404 | `hf.class-native` | class `\ps@plain`: empty head, foot `\reset@font\bfseries\hfil\thepage\hfil` |
| running title and author | template.tex:107, 109; copernicus.cls:551-553, 2692-2695 | `hf.class-native` | `\runningtitle`, `\runningauthor` are required (error if empty) but not printed in manuscript; used in the head of the other layouts (copernicus.cls:2696-2704) |
| first page number | template.tex:124; copernicus.cls:586, 2591 | `pgnum.pagenumbering` | `\firstpage{1}` leads to `\setcounter{page}{\@fpage}`; the setter acts only under `\if@cop@home`, which is false here, so the default 1 applies |
| French spacing | copernicus.cls:20 | `sp.frenchspacing` | `\frenchspacing` |
| widow and club penalties | copernicus.cls:21-22 | `sp.penalties` | `\clubpenalty10000`, `\widowpenalty10000` |
| paragraph and math glue | copernicus.cls:83-85, 227, 286 | `sp.lengths` | `\thinmuskip=2mu`, `\medmuskip=3mu minus 3mu`, `\thickmuskip=4mu`, `\parindent1em`, `\parskip0pt` |
| line spacing | copernicus.cls:601 | `sp.linespread` | `\gdef\baselinestretch{1.4}` after `\maketitle`, manuscript only |
| float fractions | copernicus.cls:287-291 | `fig.placement` | topfraction 1, textfraction 0, floatpagefraction .7, dbltopfraction 1, dblfloatpagefraction .7 |
| line numbers | copernicus.cls:2088-2091, 2105-2132, 682, 708 | `sp.draft-lineno` | `lineno[mathlines,modulo]`, `\linenumbers`, `\linenumberfont{\normalfont\small\sffamily}`; amsmath environments wrapped in `\linenomath`; `nolinenumbers` around the title block |
| text font | copernicus.cls:2136-2138 | `font.mathptmx` | `times` loaded when `times.sty` exists |
| encodings | copernicus.cls:1326-1327, 1364 | `font.fontenc-t1` | `fontenc[T5,T3,T1]`, `textcomp[warn]`, `inputenc[utf8]` (not under LuaTeX) |
| symbol glyphs | copernicus.cls:1328, 1592-1593, 1672, 1679, 2304 | `font.icons` | `fontawesome5` (`\faRibbon`, `\faStar` mark deceased and equal-contribution authors), `pifont` |
| upright quotes | copernicus.cls:1337 | `code.upquote` | load-only |
| extra math alphabets, symbol fonts | copernicus.cls:2276-2277, 2279-2288 | `font.nfss` | `\DeclareMathAlphabet{\mathbbs}{U}{BOONDOX-ds}{m}{n}`, `{\mathblackbold}{U}{dsrom}{m}{n}`; `\usefont{U}{zavm}{m}{it}` for `\coppa` `\Koppa` `\koppa` |
| colour | copernicus.cls:1535, 3028-3032, 3040-3045 | `color.color` | `color` package; `\definecolor` textcol black, bgcol white, barcol white (manuscript) |
| language and caption names | copernicus.cls:1382-1386, 1410-1439 | `lang.babel` | `babel` with `english` put first in the class option list; names set by `\addto\captionsenglish` (Introduction, Conclusions, Copyright statement, Code availability ...); German and French sets at 1440-1501 |
| PDF metadata, links | copernicus.cls:563, 2361, 3152 | `meta.hyperref` | `hyperref[bookmarks=false,pdfborder={0 0 0}]`, `\hypersetup{pdftitle=\@title}` inside `\title`, `pdfencoding=auto`; `\doi{}` prints `https://doi.org/` plus `\href` (copernicus.cls:1849-1881) |
| url | copernicus.cls:1844-1847 | `meta.url` | `url` with `\urlstyle{same}` |
| title block | template.tex:85, 90-95, 126; copernicus.cls:568-603, 670-708 | `front.class-native` | manuscript `\@@maketitlemanuscript`: a `\parbox` holding `\@manuscriptInfo` (empty here, its text is commented out at copernicus.cls:389-397), title `\LARGE\bfseries` with `\mathversion{bold}`, authors `\large` with `\Authfont{\normalfont}`, `\Affilfont{\normalsize\normalfont}`, `\affilsep` 4pt, bold "Correspondence:" line, `\fnsymbol` author notes with `\footnoterule` removed |
| author and affiliation commands | template.tex:90-95; copernicus.cls:1550-1657, 1683-1742 | `front.class-native` | `\Author[label][corr]{given}{surname}` feeds an authblk-style `\author`/`\affil` re-implemented in the class (it does not load `authblk`); `Maxaffil` 2, `\Authsep`, `\Authand`, `\Authands` |
| publication data | template.tex:115-119; copernicus.cls:2584-2605 | `front.class-native` | `\received` `\pubdiscuss` `\revised` `\accepted` `\published` `\firstpage` set values only under `\if@cop@home` (false in this kit, copernicus.cls:116, 159-161) and the manuscript title does not print them |
| abstract | template.tex:130-132; copernicus.cls:1204-1229 | `abs.class-native` | classical `abstract` environment: run-in bold "Abstract." (`\bfseries\abstractname.`), `\subpdfbookmark`; `\secondabstract` for a second language (copernicus.cls:1162-1177) |
| keywords | copernicus.cls:2672-2676 | `abs.keywords` | `\keywords{}` defined by the class, not used by the sample |
| statement sections | template.tex:135, 160-172, 199-203; copernicus.cls:2823-2866 | `front.class-native` | `\generateCommand` makes `\copyrightstatement` `\codeavailability` `\dataavailability` `\codedataavailability` `\sampleavailability` `\videosupplement` `\authorcontribution` `\competinginterests` `\disclaimer`: a `\list` with `\labelwidth\z@ \leftmargin\z@ \itemindent-\leftmargin`, italic run-in label, `\small`, 2 baselines above |
| acknowledgements | template.tex:205-207; copernicus.cls:2876-2883 | `front.class-native` | environment `acknowledgements` from `\generateCommand`; the singular name raises an error |
| intro, conclusions | template.tex:138, 154; copernicus.cls:2802-2805 | `head.class-native` | `\introduction[heading]` and `\conclusions[heading]` expand to `\section[..]{..}` |
| headings | template.tex:142-150; copernicus.cls:1008-1020, 1036-1053, 1083-1084 | `head.class-native` | manuscript (classical) branch: section `\@startsection{section}{1}{\z@}{-2em\@plus-1ex\@minus-.2ex}{1em\@plus.2ex}{\raggedright\normalfont\normalsize\bfseries\mathversion{bold}}`; subsection and subsubsection `{-1em\@plus-0.25ex\@minus-.2ex}{1em\@plus.2ex}` with the same font; `\paragraph` equals `\subsubsection` |
| appendix | template.tex:175-181; copernicus.cls:1747-1842 | `num.appendix` | `\appendix`: Alph section numbers, subsection `\thesection\arabic`, heading prefix "Appendix A:"; `\noappendix` restores the old section commands |
| appendix counters | template.tex:191, 193; copernicus.cls:1753-1771, 1839-1842, 2900-2921 | `num.counters` | `\@addtoreset{equation|figure|table}{section}`, `\def\thefigure{\thesection\@arabic\c@figure}`; `\appendixfigures` and `\appendixtables` restart the counters with letter prefix |
| section number depth | copernicus.cls:1752, 1833 | `num.secnumdepth` | `secnumdepth` 4 in the appendix, 0 after `\noappendix` (so References is unnumbered) |
| lists | copernicus.cls:1096-1120, 1122-1159, 3127-3139 | `list.kernel` | bullets `\labelitemi` `\labelitemii` bold en dash; `\itemize` rebuilt on `\list` with `\hss\llap` labels; class environments `itemizewithoutindent`, `plainlistindent`, `plainlist` set by lengths; the sample has no list |
| title-block footnotes | copernicus.cls:687-691, 715 | `fn.kernel` | `\thefootnote` is `\fnsymbol{footnote}`, `\@makefntext` with `\parindent1em` |
| display maths | copernicus.cls:1542, 170; template.tex:349-368 (comments) | `math.amsmath` | `amsmath[intlimits,fleqn,tbtags]`; `equation`, `align`, `matrix` shown in comments |
| equation flush left | copernicus.cls:169-170, 1542 | `math.eqnumber` | `fleqn` through `\LoadClass[fleqn]{article}` and amsmath, `\mathindent\z@` |
| math symbols | copernicus.cls:1539 | `math.amssymb` | `amssymb` |
| math add-on packages | copernicus.cls:1883, 1886 | `math.physics` | `accents`, `cancel` (closest bucket: math notation add-on packages); loaded when installed, not used by the sample |
| theorems | copernicus.cls:1549 | `thm.amsthm` | `amsthm` loaded; no `\newtheorem` or style in the class or the sample |
| algorithms | copernicus.cls:1922, 1950; template.tex:373-379 (comment) | `alg.algorithmicx` | `algorithmic`, `algorithm` loaded when installed; floats in `algorithm` |
| figures | template.tex:263-274 (comments); copernicus.cls:1527-1534, 1262-1266 | `fig.graphicx` | `graphicx`, `\DeclareGraphicsExtensions{.pdf,.png,.jpg}`; float body `\centering\small`, `\vspace*{2mm}` above; `figure` and `figure*` |
| rotated float | template.tex:315 (comment); copernicus.cls:2080-2086 | `fig.rotating` | `rotating`, `sidewaystable*` with `\@rotxdblfloat` redefined to a `\textheight` minipage |
| captions | copernicus.cls:1282-1298, 1972-1973, 1980 | `cap.kernel` | class `\@makecaption`: `{\small{\bfseries#1.} #2\par}`, `0.7\abovecaptionskip` above a figure, `\abovecaptionskip` below a table caption |
| caption package | copernicus.cls:1971-1973, 1980 | `cap.caption` | `caption` loaded in the final stage with no options; its `\@makecaption` is overwritten by `\let\@makecaption\cop@makecaption` |
| tables | template.tex:285-325 (comments); copernicus.cls:1502-1525, 2774-2795 | `tbl.tabular` | `array`; `\tophline` `\middlehline` `\bottomhline` `\hhline` are `\hline` plus `\noalign{\vspace{1mm}}`; `\@cline`, `\@arraycr`, `\@tabular` redefined to record `\tabularwidth`; `\belowtable{notes}` a `\parbox{\tabularwidth}` of `\scriptsize` notes |
| wide tables | copernicus.cls:1526 | `tbl.tabularx` | `tabularx` |
| merged cells | copernicus.cls:1889 | `tbl.multirow` | `multirow` when installed |
| long tables | copernicus.cls:1891-1919 | `tbl.longtable` | `supertabular` with wrappers adding `\clearpage\centering\small` |
| code listings | copernicus.cls:1981-1994, 1995-2003 | `code.listings` | `\lstset{basicstyle=\small, numbers=left, numbersep=0.5em, numberstyle=\footnotesize, frame=lines, keepspaces=true, xleftmargin, framexleftmargin}`; `listing` environment is a `figure` with `\setlistings` |
| reaction, chemistry, units | template.tex:384-397 (comments); copernicus.cls:2706-2761 | `class.copernicus` | class-native vocabulary: `reaction` and `rxnarray` environments with counter `reaction` (labels R1, R2), `\chem{}`, `\unit{}`, `\degree`, `\permil` |
| float kinds | copernicus.cls:1957-1970 | `class.copernicus` | class-native `\setfigures` `\setschemes` `\setplates` `\setlistings` `\setboxes` swap `\c@figure` and `\figurename` |
| bibliography list | template.tex:216-224; copernicus.cls:2052-2078 | `bib.thebibliography` | hand-written list with `\bibitem[AUTHOR(YEAR)]{key}`; class `thebibliography` with `\bibsection` (`\newpage` in manuscript, `\section*{\refname}`), `\bibsep\z@`, `\bibfont\small` |
| citations | template.tex:238-248 (comments); copernicus.cls:2039-2043 | `bib.natbib` | `natbib[authoryear,round]`, `\bibpunct{(}{)}{;}{a}{,}{,~}`, `\NAT@sort` and `\NAT@cmprs` 0 |
| BibTeX style | template.tex:226-230 (comment); copernicus.bst:1-9 | `bib.bibtex-bst` | `copernicus.bst` v1.6 (custom-bib `merlin.mbs` output); only the hand-written list is live |

## Bespoke code
The template defines no macro, counter or package (template.tex has no `\newcommand` or `\def`). The class internals below sit inside the published class way; they are listed, with scope `class`, so the result can be re-read under a stricter W1.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\@startsection`, `\@afterheading` rewrite | copernicus.cls:1036-1082 | not counted: inside `class.copernicus`; as code, irreducible (kernel internals) | the emitter writes `\section` etc. and the class does the rest |
| `\@maketitle` family, `\@@maketitlemanuscript` | copernicus.cls:670-992 | not counted: inside `class.copernicus`; as code, irreducible | `\title` `\Author` `\affil` `\maketitle` |
| `\@makecaption` | copernicus.cls:1282-1298 | not counted: inside `class.copernicus` | `\caption` |
| `\@tabular`, `\endtabular`, `\@cline`, `\@arraycr` | copernicus.cls:1503-1525, 2779-2788 | not counted: inside `class.copernicus` | `tabular` plus `\tophline` etc. |
| author machinery derived from `authblk` | copernicus.cls:1550-1742 | not counted: inside `class.copernicus` | `\Author` and `\affil` |
| `\appendix` with `\@sect` and `\@ssect` rewrite | copernicus.cls:1778-1832 | not counted: inside `class.copernicus` | `\appendix` `\noappendix` |
| `\mathbb` dispatcher by character code | copernicus.cls:2290-2302 | not counted: inside `class.copernicus` | `\mathbb{...}` |
| `reaction` built on amsmath internals | copernicus.cls:2731-2761 | not counted: inside `class.copernicus` | `reaction` environment |
| apostrophe made active, `regexpatch` on `\pr@m@s` | copernicus.cls:1338-1353 | not counted: inside `class.copernicus` | none needed |
| LastPage label written by hand | copernicus.cls:533-537 | not counted: inside `class.copernicus` | none needed |
| `long2` column code, modern and indented title blocks | copernicus.cls:604-667, 716-904 | not counted; not reached by `manuscript` | none needed |
| Branches that need `copernicuslogo.pdf`: side bars, journal heads and feet, editor notes, `mathtime`, `pdfscreencop` | copernicus.cls:405-431, 2169, 2438-2582, 2923-2997 | not reached in this kit: `\if@cop@home` is false (copernicus.cls:116, 159-161) | none needed |

## Content-opaque
none live. The `\includegraphics{FILE NAME}` lines in comments (template.tex:264, 272) are figure content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Missing assets, none reached by the manuscript path: `copernicuslogo.pdf` (copernicus.cls:116), the journal logos `*_Logo.pdf` (copernicus.cfg:134 and following), `cop_watermark.pdf` (copernicus.cls:3025, `proof` option), `CreativeCommons_Attribution_License.png` (copernicus.cls:2577). Packages the class loads only if installed (`\IfFileExists`): `ucharacters` (copernicus.cls:1366), `subfloat` (copernicus.cls:2027), `algorithm`, `algorithmic`, `supertabular`, `lineno`, `natbib`, `times`. `fontawesomesymbols-generic.tex` and `-pdftex.tex` (copernicus.cls:1330, 1334) are not in the zip and are expected from `fontawesome5`.
- `mathtime` (commercial fonts, copernicus.cls:2169) is loaded only when `copernicuslogo.pdf` exists; the public kit has no such file.
- `pdfscreen.sty` is the stock package (`\ProvidesPackage{pdfscreen}` v.1.5 2000/07/07, pdfscreen.sty:17-20); `pdfscreencop.sty` differs from it in three lines (colour of the button shadow at line 567 and 833, a label without a trailing period at line 947 by diff). It is `page.pdfscreen` and is loaded only in the `online` discussion branch (copernicus.cls:2438-2444), not by this sample.
- `etoolbox`, `iftex` and `regexpatch` are load-only helpers with no printed effect; the verdict does not rest on them. `tikz` is loaded unconditionally (copernicus.cls:2135) but the class draws nothing with it (no `tikzpicture` in copernicus.cls), so there is no `ART`; the only drawing-like code is the `\Radical` glyph (copernicus.cls:2708) and bars gated by `\if@cop@home`.
- The README names class version 10.1.34 (README_copernicus_package_7_16.txt:18) while the class file says 10.1.35 (copernicus.cls:19). No text addressed to an AI was found in the zip.
