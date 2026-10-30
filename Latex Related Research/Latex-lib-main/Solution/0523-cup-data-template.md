no

# 0523-cup-data-template: CUP Data Template (CUP-JNL-DTM, Glasgow Mathematical Journal starter)

- Unverified: read from the source, not compiled.
- Source: Source/0523-cup-data-template/ (origin: https://latextemplates.com/downloads/cup-data-article.zip; licence: not established, the README says the class carries no licence grant, README.md:22-40)
- Kind: journal
- Lib: v5 (the snapshot read)
- Engine: pdfLaTeX-compatible (no fontspec/Lua; `journal=gmj` takes the BibTeX route; the biblatex journal codes use biber, CUP-JNL-DTM.cls:661, 1101)
- Look carried by: zip-local (the whole look is in CUP-JNL-DTM.cls; main.tex adds only theorems and hyperref)
- Class origin: zip-local (the README says it is a community Overleaf-gallery template, not an official CUP kit, README.md:7-20; the class is in neither CTAN nor TeX Live, README.md:24-25; ctan.org/pkg/cup-jnl-dtm returns 404)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (CUP-JNL-DTM.cls, lines 1-1877)

## Verdict
No. Every ordinary part of the page (geometry, sizes, headings' parameters, lists, captions, running heads, theorems, tables, natbib bibliography) reduces to lib ways, but the zip-local class hand-writes three things no lib way expresses. The first is the first-page block: `\@maketitle`/`\maketitle` with author, address and affiliation-number machinery driven by counters and aux-file labels. The second is a patched kernel `\@startsection`. The third is the `fntable` table-footnote mechanism, which patches kernel footnote internals. The class also carries a biblatex style-patching branch (dormant for `journal=gmj`). A wrong yes costs more than a wrong no.

## Blockers
- `BESPOKE/class` first-page block: `\renewcommand{\@maketitle}` vbox with article type, title, authors, addresses, keywords and the abstract inside it (CUP-JNL-DTM.cls:523-548), `\maketitle` rewritten with `\twocolumn`/`\newpage` branch, `\enlargethispage{-38pt}`, `\opshortpage` and global `\let` disabling (551-587); author punctuation and affiliation numbers from counters `\aucount` `\punctcount` (399-402, 405-429) and aux-written labels `\jmkLabel` `\Newlabel` `\jmkRef` (392-394, 455-471)
- `BESPOKE/class` heading engine: `\@startsection` is redefined with a level-dependent `\vskip0pt`/`\vskip1pt` inside the `\if@nobreak` branch (CUP-JNL-DTM.cls:1294-1309, patch at 1302-1304) and `\@sect` is re-copied with a period added in the run-in case (1232-1263, period at 1255); a kernel-internal edit, not a `\renewcommand\section` call
- `BESPOKE/class` table footnotes: `fntable` environment (minipage whose `\@makefnmark`, `\@xfootnotemark`, `\@xfootnotenext`, `\@makefntext` are replaced so a footnote mark is a free string, CUP-JNL-DTM.cls:1588-1613); used at main.tex:141-154
- `BESPOKE/class` biblatex branch (not taken by `journal=gmj`): `\cambridge` patches many drivers with `\xpatchbibdriver`, `\renewbibmacro*`, `\DeclareSourcemap` (CUP-JNL-DTM.cls:683-1098), loaded by `\cambridgea` for six journal codes (wet, dap, dce, eds, prm, jnw; 623-657, 1100-1103); code editing, so W2 fails; it would block those codes

## Class setting
- Class: `class.article` options: twoside, fleqn (the base the zip-local class loads, CUP-JNL-DTM.cls:83). The zip-local `CUP-JNL-DTM` is not a published class, so it is not a way; its content is in the Bespoke table. The sample's own option `journal=gmj` (main.tex:31) is read by `xkeyval` (CUP-JNL-DTM.cls:108-113).
- Class-native vocabulary used (zip-local, not published): `Frontmatter` and `Backmatter` environments (main.tex:48, 190), `\title[short]{}` (50), `\author[aff]{}` (52-53), `\authormark` (55), `\address[n]{\orgdiv \orgname \orgaddress \city \postcode \country \email}` (57-58), `\keywords[label]{}` and `\codes[level]{}` (60, 62), `\abstract{}` (64), `\jname` `\articletype` `\jyear` (42-44), `\TBL` `\TCH` `fntable` `\botrule` (137-150), `\bibliography` (222).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | CUP-JNL-DTM.cls:83 | `class.article` | twoside, fleqn |
| sides | CUP-JNL-DTM.cls:83 | `page.class-options` | twoside |
| page geometry | CUP-JNL-DTM.cls:194-205 | `page.geometry` | paperwidth=174mm, paperheight=247mm, top=57pt, headheight=7pt, headsep=19.5pt, textwidth=144mm, textheight=612.5pt, marginparsep=3mm, marginparwidth=10mm, bindingoffset=6mm, footskip=0mm |
| margin, foot, maxdepth lengths | CUP-JNL-DTM.cls:208-217 | `sp.lengths` | \marginparsep=3mm, \marginparwidth=10mm, \footskip=0pt, \maxdepth=0pt, \footnotesep=5.75pt, \skip\footins=8pt plus 4pt minus 0pt, \parindent=12pt |
| line and paragraph spacing | CUP-JNL-DTM.cls:222-225 | `sp.lengths`, `sp.linespread` | \lineskip=1pt, \normallineskip=1pt, \parskip=0pt, \baselinestretch empty |
| penalties and demerits | CUP-JNL-DTM.cls:228-254, 1873 | `sp.penalties` | clubpenalty=10000, widowpenalty=10000, displaywidowpenalty=100, predisplaypenalty=10000, postdisplaypenalty=0, brokenpenalty=10000, interlinepenalty=0, linepenalty=100, \@lowpenalty=51, \@medpenalty=151, \@highpenalty=301, doublehyphendemerits=1000000, finalhyphendemerits=1000000 (demerits are the same TeX integer-parameter family; a stretch of the lib line, noted) |
| hyphenation, tolerance | CUP-JNL-DTM.cls:247-248, 257-258, 299, 1868 | `sp.hyphenat` | \tolerance=9999, \vbadness=9999, \lefthyphenmin=3, \righthyphenmin=3, \hyphenation{Figure ... Lemma}, \sloppy |
| french spacing | CUP-JNL-DTM.cls:1869 | `sp.frenchspacing` | on |
| flush bottom | CUP-JNL-DTM.cls:1870 | `pg.flush` | \flushbottom |
| font sizes | CUP-JNL-DTM.cls:129-176 | `font.size-commands` | normalsize 10/12, small 9/11, footnotesize 7/8, scriptsize 9/9, tiny 5/6, large 12/14, Large 16/18, LARGE 17pt/22, huge 20pt/25, Huge 25pt/30; extra \medsize \scrisize \larg |
| math sizes | CUP-JNL-DTM.cls:178-180 | `font.size-commands` | \DeclareMathSizes for 9, 10, 11pt (kernel command; closest lib home) |
| display and list skips per size | CUP-JNL-DTM.cls:131-166 | `sp.lengths` | \abovedisplayskip 9.5pt plus 2pt, \topsep, \parsep, \itemsep per size |
| old font switches | CUP-JNL-DTM.cls:119-126, 182-185 | `mark.kernel` | \rm \sf \tt \bf \it \sl \sc \cal \mit, \textsubscript (kernel-like copies) |
| fonts and encoding | main.tex:35; CUP-JNL-DTM.cls:374-382 | `font.fontenc-t1` | T1; text face is the default \rmdefault, no font package; title 16/18 bold, authors 10/12, address 8/10, keywords 8/10, abstract 9/11 |
| letter-spaced article type | CUP-JNL-DTM.cls:348-350 | `mark.ulem` (soul `\sodef`) | \sodef\letterspacetwty{}{.1em}{.4em plus1em}{.5em plus 1em minus1em} |
| article type, journal, year strings | main.tex:42-44; CUP-JNL-DTM.cls:349-370 | none (feeds the BESPOKE block; the strings themselves are `hf.fancyhdr` fields) | \articletype{Research Article}, \jname, \jyear{2026} |
| title, authors, addresses, affiliation numbers | main.tex:50-58; CUP-JNL-DTM.cls:387-471, 523-548 | none (`BESPOKE/class`) | nearest `front.authblk` and `front.titling` do not give this layout or the label-to-number map |
| keywords and MSC | main.tex:60, 62; CUP-JNL-DTM.cls:511-514 | `abs.keywords`, `abs.classification` | \addvspace{5pt}, 8/10 font, bold "Keywords:" label, \codes = italic level + " -- " + codes; printed inside the blocked title block |
| abstract | main.tex:64-70; CUP-JNL-DTM.cls:494-504 | none (inside the `BESPOKE/class` block) | 9/11 text, "Abstract" run by `\abstracthead*` (a `\@startsection`, spacing -22pt plus 2ex, after 0.0001pt, 9/11 bold) |
| running heads | CUP-JNL-DTM.cls:1147-1153, 363, 486 | `hf.fancyhdr` (reduction target; the class writes `\ps@headings`) | even: \thepage\qquad \textit{rightmark} (author mark); odd: \textit{leftmark} (journal name)\qquad\thepage; 10/12 font; empty foot |
| opening-page header | CUP-JNL-DTM.cls:1166-1181, 570 | `hf.fancyhdr`, `fig.graphicx`, `tbl.tabular` | CUP_Logo.pdf at scale .75 right, 7/9 font journal line (name, year, volume:article id, first page--\pageref*{LastPage}), DOI line; needs graphicx loaded by the sample (main.tex:33) |
| last page label | CUP-JNL-DTM.cls:1165 | `pgnum.lastpage` | \AtEndDocument{\label{LastPage}} |
| page numbers | CUP-JNL-DTM.cls:1867 | `pgnum.pagenumbering` | arabic |
| section numbering | CUP-JNL-DTM.cls:1186-1196 | `num.secnumdepth`, `num.counters` | secnumdepth=3, \thesection arabic, \thesubsection dotted, part Roman, extra counter chapter[part] |
| heading looks | CUP-JNL-DTM.cls:1265-1292 | `head.kernel` | section -18pt plus -2ex / 6pt / 10/12 bold ragged; subsection -18pt / 6pt / 10/12 bold italic; subsubsection -12.5pt / 0.001pt / 9.5/11.5 bold; paragraph 12.5pt plus 1ex minus .2ex / 0.0001pt / 9.5/11.5 italic; number then period, 0.5em |
| heading engine | CUP-JNL-DTM.cls:1232-1263, 1294-1309 | none (`BESPOKE/class`) | patched `\@startsection` and `\@sect` |
| part | CUP-JNL-DTM.cls:1198-1230 | `head.kernel` | copy of the kernel `\part`, unused by the sample |
| backmatter text and headings | main.tex:190-210; CUP-JNL-DTM.cls:1123-1135 | `head.kernel`, `font.size-commands` | 8/10 text; section -12pt plus -2ex / 3pt / 10/12 bold; paragraph 2.25ex plus 1ex minus .2ex / -.5em (run-in) / 8/10 bold; \bibfont 8/10 |
| lists | CUP-JNL-DTM.cls:1314-1466 | `list.enumitem` | leftmargin from label width, labelsep=.5em, topsep=6pt, itemsep=parsep=partopsep=0, listparindent=\parindent; bullets \textbullet \textendash; labels `1.` `(a)` `(i)` `(A)`; extra `unenumerate` (itemindent -10pt, labelsep 0); optional argument is a widest-label sample (not used by the sample) |
| quote, quotation, verse, description | CUP-JNL-DTM.cls:1468-1489, 1731-1734 | `quote.kernel`, `list.enumitem` | leftmargin=1em, topsep=6pt; description bold labels |
| equations | main.tex:93-97, 108-110, 180-182 | `math.amsmath` | equation + \label + \eqref, \text, \[ \]; fleqn from the class |
| eqnarray | CUP-JNL-DTM.cls:305-327 | `math.kernel` | looks like the kernel eqnarray copied (kernel source not in the zip, compared from memory); drop it; not used by the sample |
| math packages | main.tex:34 | `math.amssymb` | amsmath, amssymb, amsfonts, amsthm |
| theorem, remark | main.tex:38-40, 102-118 | `thm.amsthm` | \newtheorem{theorem}{Theorem}[section]; \theoremstyle{definition}; \newtheorem{remark}[theorem]{Remark}; optional title `[Discrete spectral convergence]` |
| proof | main.tex:120-127 | `thm.amsthm` | `proof[Proof sketch]` |
| table body | main.tex:135-155; CUP-JNL-DTM.cls:1564-1570, 1555-1559, 1585 | `tbl.tabular`, `tbl.booktabs`, `sp.lengths` | tabular* {\textwidth}{@{\extracolsep{\fill}}lccc@{}}, \tabcolsep=0pt, 10/12 body and column-head font, \arraystretch=1; `\TBL` = caption, then the body in the table font |
| table rules | main.tex:142-150; CUP-JNL-DTM.cls:1552-1553, 1616-1656 | `tbl.booktabs` | \cmidrulewidth=.15pt; \toprule 0pt, .15pt rule, 5pt below; \midrule 3pt above, .15pt, 5pt below; \botrule 3pt above, .15pt (booktabs-like internals rewritten; parameter equality read, not checked) |
| table footnote | main.tex:141, 152-153; CUP-JNL-DTM.cls:1588-1613 | none (`BESPOKE/class`) for `fntable`; `fn.kernel` for \footnotetext | mark 5pt superscript, text 7/8 raggedright, no rule, \vspace{-0.75\skip\footins} |
| captions | main.tex:137-140; CUP-JNL-DTM.cls:1507-1515, 1520-1521, 1538-1547, 1575-1582, 1493-1494 | `cap.kernel`, `cap.caption` | labelfont bold italic 10/12, textfont italic 10/12, trailing period, label "Table 1." with .5em; centred when the caption fits one line, justified when not (`singlelinecheck`), skips above 2.25pt / below 3pt |
| figure macro | main.tex:33; CUP-JNL-DTM.cls:1531-1533 | `fig.graphicx` | \FIG = centred content then caption; the sample has no figure (Fig.pdf unused) |
| float parameters | CUP-JNL-DTM.cls:263-297 | `fig.placement`, `sp.lengths` | totalnumber=10, topnumber=5, bottomnumber=5, topfraction=.921, bottomfraction=.921, textfraction=.13, floatpagefraction=.887, dbltopfraction=.88, dblfloatpagefraction=.88; \floatsep 18pt plus 2pt minus 2pt, \textfloatsep 19pt..., \intextsep 18pt... |
| footnotes | CUP-JNL-DTM.cls:1835-1844, 214-215 | `fn.footmisc` | rule .15pt x 5pc with kern 2pt/4.5pt, superscript mark, text hskip 8pt, \footnotesep 5.75pt |
| contents lists | CUP-JNL-DTM.cls:1662-1720, 1725-1726 | `toc.kernel`, `toc.etoc` | tocdepth=3, \@pnumwidth 1.55em, \@tocrmarg 2.55em, \@dotsep 4.5, \l@ entries by kernel `\@dottedtocline`; `etoc` with \etocarticlestylenomarks; unused by the sample |
| index | CUP-JNL-DTM.cls:1811-1829 | `idx.makeidx` | \columnsep 35pt, \hangindent 40pt, subitem 20pt, subsubitem 30pt; unused |
| hyperlinks | main.tex:36; CUP-JNL-DTM.cls:1847-1850 | `meta.hyperref`, `xref.hypcap`, `meta.url` | colorlinks, allcolors=blue; hypcap loaded after hyperref; \UrlFont \rmfamily; `url` loaded (CUP-JNL-DTM.cls:86) |
| e-mail and DOI helpers | CUP-JNL-DTM.cls:440-445, 1760-1800, 1860 | `meta.url`, `meta.hyperref` | \email = "E-mail:" + blue url text; `\DOI` is an inline copy of the CTAN `doi` package (considered: doi); \doi = \quad\url; none called by the sample except `\email` (main.tex:58) |
| cross-references | main.tex:96, 103, 115, 131, 140, 157 | `xref.kernel` | \label, \ref, \eqref |
| appendix | main.tex:170-188 | `num.appendix` | \begin{appendix} ... \end{appendix}, sections lettered |
| citations and bibliography | main.tex:80, 222; CUP-JNL-DTM.cls:615-620, 1114-1118, 1852-1857 | `bib.natbib`, `bib.bibtex-bst` | natbib [numbers]; \bibliographystyle{amsplain}; \citep; \bibsection = \section*{\refname}\vspace*{3pt}; \bibliography{references} |
| other-journal bibliography | CUP-JNL-DTM.cls:659-681, 1100-1103 | `bib.biblatex-biber` (loads) plus bespoke patches | style=apa or nejm or authoryear-comp, backend=biber, natbib, maxcitenames=2, maxbibnames=99, giveninits, uniquename=init; not taken for gmj |
| name strings | CUP-JNL-DTM.cls:332-341 | none needed | all strings equal the kernel English defaults |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| journal key and dispatcher | CUP-JNL-DTM.cls:99-114, 594-620, 1105-1118 | yes | for gmj: `bib.natbib` [numbers] + `bib.bibtex-bst` amsplain; the `crop` options (63-69, 81) pass options to a package never loaded, no effect |
| font, size, geometry, spacing, penalty and float settings | CUP-JNL-DTM.cls:119-299 | yes | `font.size-commands`, `page.geometry`, `sp.lengths`, `sp.penalties`, `sp.hyphenat`, `fig.placement` as in the map |
| `\eqnarray` | CUP-JNL-DTM.cls:305-327 | yes | kernel copy; omit (`math.kernel`) |
| first-page block and author/address machinery | CUP-JNL-DTM.cls:387-587 | no | counters, `\@for` loop and aux label map choose what is printed; a `\@maketitle` rewrite; `front.authblk` + `front.titling` give a different model |
| meta macros `\jname` `\jyear` `\articletype` ... | CUP-JNL-DTM.cls:349-370, 486 | yes | strings in `hf.fancyhdr` fields and the first-page block |
| `\ps@headings`, `\ps@titlepage` | CUP-JNL-DTM.cls:1147-1181 | yes | `hf.fancyhdr` + `pgnum.lastpage` + `fig.graphicx` + `tbl.tabular`; `\vbox to 0pt`/`\rlap` become `\raisebox`/`\makebox` |
| `\@startsection` and `\@sect` patch | CUP-JNL-DTM.cls:1232-1263, 1294-1309 | no | level-dependent vskips in the no-break branch; the `\renewcommand\section` calls (1273-1292) are `head.kernel` and reduce |
| `Backmatter`, `Frontmatter` environments | CUP-JNL-DTM.cls:1121-1135 | `Backmatter` yes; `Frontmatter` follows the title block | `Backmatter`: `head.kernel` redefinitions in a group + `font.size-commands`; `Frontmatter` calls `\maketitle`, so it is blocked with it |
| list and quote environments | CUP-JNL-DTM.cls:1314-1489, 1731-1734 | yes | `list.enumitem` lengths and labels; `quote.kernel` |
| caption macros `\@makecaption`, `\@figurecaption`, `\@tablecaption` | CUP-JNL-DTM.cls:1507-1547, 1575-1582 | yes | `cap.caption` with `singlelinecheck`, `labelfont`, `textfont`, `labelsep=period`, `textformat=period`, `skip` |
| `\TBL`, `\TCH`, `\FIG` | CUP-JNL-DTM.cls:1531-1533, 1564-1570, 1585 | yes | aliases: caption then body in a font group |
| `fntable` environment | CUP-JNL-DTM.cls:1588-1613 | no | rewrites `\@xfootnotemark` and `\@xfootnotenext` so a mark is a free string; `tbl.threeparttable` has another model |
| booktabs rule rewrites | CUP-JNL-DTM.cls:1616-1656 | yes (parameters read, not compared run) | `tbl.booktabs` \heavyrulewidth, \lightrulewidth, \aboverulesep, \belowrulesep, \cmidrulewidth, `\botrule` as `\bottomrule` alias |
| toc, list-of and index redefinitions | CUP-JNL-DTM.cls:1662-1726, 1811-1829 | yes | `toc.kernel`, `toc.etoc`, `idx.makeidx` parameters; unused by the sample |
| footnote marks and rule | CUP-JNL-DTM.cls:1835-1844 | yes | `fn.footmisc` plus `sp.lengths` |
| `\DOI` (doi.sty copy), `\doi`, `\email`, `\orcid` | CUP-JNL-DTM.cls:432-445, 1760-1800, 1860 | yes | `\usepackage{doi}` (CTAN) or `meta.url`/`meta.hyperref`; `\orcid` needs `orcid_logo`, not shipped, never called |
| biblatex style patches `\cambridge` | CUP-JNL-DTM.cls:683-1098 | no (dormant for gmj) | `\xpatchbibdriver` and `\renewbibmacro*` edit driver code; W2 fails |
| `\copytext`, `\printcopyright`, `\opshortpage` | CUP-JNL-DTM.cls:1155-1163 | yes | the copyright footer is commented out (1180); only a length stays |

## Content-opaque
none (table cells, equations and bibliography entries are content; `Fig.pdf` is shipped and not used, `orcid_logo` is not shipped)

## Lib changes
- New ways proposed: none (the `doi` package and the soul letter-spacing fit `meta.hyperref`/`meta.url` and `mark.ulem`; considered: doi, tbl.threeparttable, front.authblk, front.titling, hf.titleps)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
