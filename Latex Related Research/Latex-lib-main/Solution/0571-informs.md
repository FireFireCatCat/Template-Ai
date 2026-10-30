yes

# 0571-informs: INFORMS author submission template (Management Science, class informs4)

- Unverified: read from the source, not compiled.
- Source: Source/0571-informs/ (origin: https://pubsonline.informs.org/pb-assets/LaTeX/INFORMS-MNSC-Template-6-10-2024-1718048504857.zip; licence: not established)
- Kind: journal
- Lib: v4
- Engine: pdfLaTeX-compatible
- Look carried by: mixed (informs4.cls carries page, front matter, headings, floats, theorems, running heads; the sample preamble adds fonts, endnotes, algorithm, natbib and tikz packages)
- Class origin: publisher-official
- Main file: INFORMS-MNSC-Template.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
Yes, resting on the rubric's official-kit ruling. informs4.cls and eqndefns-left.sty come from INFORMS's own author page (Origin), so the class is the published way `class.informs4` and its internals (`\@startsection`, `\@maketitle`, `\@makefigurecaption`, `\FIGURE`, `\TABLE`) are class vocabulary, not bespoke code. The sample's own preamble adds only published packages (tgtermes, newtxtext/newtxmath, bm, endnotes, algorithm, algpseudocode, tikz, natbib) and a few reducible `\def` settings. No `ART` blocker: the logo is a shipped image and the only drawing is a TikZ figure inside a float (content).
Re-read note: if kit-internal code were not accepted as published, the class (BESPOKE/class: informs4.cls:1134-1170, 1980-2058, 2161-2166, 2229-2260, 2449-2479) and eqndefns-left.sty (BESPOKE/preamble: eqndefns-left.sty:107-409) would be irreducible and the answer would flip to `no`.

## Blockers
none

## Class setting
- Class: `class.informs4` options: `mnsc` (journal code, informs4.cls:32), `sglanonrev` (single anonymous review, informs4.cls:54); class defaults `letterpaper,twoside,onecolumn,fleqn,final` (informs4.cls:100). Other options the class declares: 17 journal codes plus the alias `ijaa` (informs4.cls:26-43), `copyedit`, `dblanonrev`/`blindrev`, `nonblindrev`, `openbib`, `nameyear`, `draft`, `finalbox` (informs4.cls:46-95). It has no `\LoadClass` (grep): it builds everything from the kernel and loads `amsfonts,amsmath,amssymb,ifthen,url,graphicx,color,array,theorem` (informs4.cls:6). `fleqn` is named in `\ExecuteOptions` but no `\DeclareOption{fleqn}` exists (grep), so whether equations are flush-left is not established by reading.
- Class-native vocabulary used: `\TITLE`, `\RUNTITLE`, `\RUNAUTHOR`, `\MANUSCRIPTNO`, `\ARTICLEAUTHORS` with `\AUTHOR` `\AFF` `\EMAIL`, `\ABSTRACT`, `\FUNDING`, `\KEYWORDS`, `\ACKNOWLEDGMENT`, `\FIGURE{art}{caption}{note}` inside `figure`, `\TABLE{caption}{tabular}{note}` inside `table`, `\up` `\down`, `proof` with a title argument and `\Halmos`, `\OneAndAHalfSpacedXII`, `\EquationsNumberedThrough`, `\TheoremsNumberedThrough`, `\ECRepeatTheorems` (main:16-133). Companion style from the same kit: `eqndefns-left` (main:17). Present in the sample only as comments: `\VOLUME`..`\DOI`, `\HISTORY`, `APPENDIX`/`APPENDICES` (main:65-77, 131, 312-321).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main:16; informs4.cls:2, 100-101 | `class.informs4` | `mnsc,sglanonrev` |
| page size and text block | informs4.cls:76-77, 88-91, 347-358, 931-932 | `page.class-options` | letterpaper; text 6.5in x 648pt; odd/even side margin 72bp, topmargin 36bp, headheight 28bp, hoffset and voffset -1in (class's own raw lengths) |
| trim options, crop marks | informs4.cls:84-95, 300-381 | `class.informs4` | options `draft` `final` `finalbox`; marks drawn from rules, empty under `final` (informs4.cls:357) |
| running heads | informs4.cls:1032-1046, 1078-1083, 1090-1095, 2825 | `hf.class-native` | `\pagestyle{headings}`; head: bold author + italic short title, "Article submitted to <journal>", page number, 0.5pt rule; foot empty (informs4.cls:1030); text from main:87, 92 |
| first-page head and foot | informs4.cls:1106-1125, 2831 | `hf.class-native` | empty head, 8pt centred page number in foot via `\ARTICLEfirstpage` |
| page numbering | informs4.cls:2826 | `pgnum.pagenumbering` | arabic |
| title banner | informs4.cls:1838-1850, 1861-1880, 1907-1928 | `front.class-native` | logo, journal URL, "Submitted to" at left; journal name, vol/no/month/ISSN at right (sglanonrev variant) |
| banner logo | informs4.cls:1864 | `fig.graphicx` | `\includegraphics{informs_Logo}` (informs_Logo.pdf and .eps shipped) |
| title | main:97; informs4.cls:1182, 1186-1191 | `front.class-native` | `\TITLE`; 20/24 bold sans, flush left |
| authors, affiliations | main:103-114; informs4.cls:987-995, 1198-1206 | `front.class-native` | `\AUTHOR` 11/13, `\AFF` 8/10, flush left |
| abstract | main:116-119; informs4.cls:997, 1932-1957 | `abs.class-native` | run-in bold sans "Abstract."; two minipages (.3 and .65 of textwidth), red notice text at left (informs4.cls:1938), `\hrulefill` at end |
| funding, keywords | main:121, 130; informs4.cls:1006-1007, 1021-1024 | `abs.keywords` | labels "Funding:" and "Key words:" bold sans, hangindent 1em |
| title assembly | main:133; informs4.cls:1134-1170 | `front.class-native` | `\maketitle` = top banner, title, authors, 1pt rule, abstract block |
| acknowledgments | main:324; informs4.cls:1224-1225 | `front.class-native` | `\ACKNOWLEDGMENT` heading 13/15 bold, text in `\NIN` |
| headings | main:138, 153; informs4.cls:2085-2088, 2060 | `head.class-native` | section 13/15 bold sans flush left, skip -15pt plus -5pt minus -4pt, after 0.01pt; subsection 11/13.6 bold sans; number "N." then 1em |
| section counters | informs4.cls:1965-1978 | `num.secnumdepth`, `num.counters` | secnumdepth 3; arabic `\thesection`, `\thesubsection` dotted |
| appendix (not active) | main:307-321; informs4.cls:2842-2904 | `num.appendix` | `APPENDIX`/`APPENDICES`, `\@Alph` section numbers |
| base size and line spacing | main:25; informs4.cls:447-455, 477-483, 619 | `class.informs4` | `\OneAndAHalfSpacedXII`: 12pt on 20.7pt baseline (no `sp.class-native` line in the lib) |
| penalties | informs4.cls:708-736 | `sp.penalties` | club, widow, predisplay 10000 (non-copyedit), `\hyphenpenalty` 50, `\binoppenalty` 150 |
| lengths | informs4.cls:659-687, 926, 1475 | `sp.lengths` | `\parindent` 1em, `\parskip` 0, `\footnotesep` 12pt, float and display skips |
| math glue | informs4.cls:393-398, 870-875 | `sp.lengths` | `\mathN` mu-skips; `\Dskips` display skips |
| french spacing | informs4.cls:2828 | `sp.frenchspacing` | on |
| flush bottom | informs4.cls:2829 | `pg.flush` | `\flushbottom` |
| sloppy | informs4.cls:2827 | `sp.hyphenat` | `\sloppy` |
| text fonts | main:18-20 | `font.mathptmx`, `font.newtx` | `tgtermes`; `newtxtext`, `newtxmath` |
| class font defaults | informs4.cls:103-105, 391 | `font.family-default`, `font.size-commands` | rm ptm, sf phv, tt pcr; `\fs.a.b.` = `\fontsize{a}{b}\selectfont` |
| bold math | main:21 | `math.bm` | `bm` |
| math packages | informs4.cls:6 | `math.amsmath`, `math.amssymb` | loaded unconditionally |
| equation numbering | main:47; informs4.cls:1477-1494 | `num.counters` | `\theequation` = arabic, running through the paper |
| display equations | main:141-171 | `math.amsmath` | `equation`, `equation*`, `align` with `\notag` |
| equation width check | main:17; eqndefns-left.sty:34-42, 104-211 | `class.informs4` | kit companion style, load only; boolean `\Equationvalidatetrue`; width limit 240pt for `mnsc` (eqndefns-left.sty:41) |
| theorem-like statements | main:52, 54, 173-175, 261-263, 269-275; informs4.cls:1774-1825, 2638-2696 | `thm.class-native` | styles TH (header sans small caps, body italic, 6pt skips) and EX (body roman, 0pt skips); labelsep 0.5em; one counter per environment (Theorem, Lemma, Remark, Definition...), numbered through the paper (informs4.cls:2640-2655) |
| proof | main:177-179, 265-267; informs4.cls:884, 1829-1830 | `thm.class-native` | `\proof#1` italic title, `\Halmos` = quad plus `$\square$` |
| algorithms | main:30-31, 181-196, 221-259 | `alg.algorithmicx` | `algorithm` float, `algpseudocode`, `algorithmic[1]` |
| figure float | main:198-219; informs4.cls:757-768, 2229-2260 | `fig.class-native`, `fig.graphicx` | `\FIGURE` = caption above art, centred art, optional "Note." line; `\rotate` flag uses `\rotatebox` (informs4.cls:2223, 2257) |
| float placement | informs4.cls:669-705, 759-761, 772-774 | `fig.placement` | default `tbp`; top/bottom fractions 1.0, text fraction 0 |
| captions | informs4.cls:762, 775, 2139-2148, 2169-2172, 2218-2219 | `cap.kernel` | class `\@makefigurecaption` (mnsc: centred) and `\@maketablecaption` (centred); bold sans label "Figure"/"Table" + 0.3em |
| table float | main:283-297; informs4.cls:742-744, 770-781, 1471-1472, 2449-2479 | `tbl.tabular` | `\TABLE` wraps caption, table (in 10pt `\TableSpaced`) and note; `\hline`, `\up`, `\down`; `\tabcolsep` 4pt |
| footnotes | informs4.cls:844, 941 | `fn.kernel` | no rule, `\@makefntext` with 1em indent |
| endnotes | main:22, 300, 305; informs4.cls:2822-2823 | `fn.endnotes` | `endnotes`; `\endnote`; `\theendnotes` in a group with `\parindent` 0, `\parskip` 0, `\enotesize` = `\normalsize` |
| citations | main:36-42, 140, 151 | `bib.natbib` | `\bibpunct[, ]{(}{)}{,}{a}{}{,}`; `\bibfont` `\small`; `\bibsep` `\smallskipamount`; `\bibhang` 24pt |
| bibliography (active) | main:344-360 | `bib.thebibliography` | `thebibliography{3}`, `\bibitem[{Smith(2005)}]` labels |
| bibliography (commented) | main:331-335; informs2014.bst:1-20; sample.bib:1-26 | `bib.bibtex-bst` | `informs2014`, `sample.bib`; not active in the sample |
| labels | main:138, 173, 217, 285 | `xref.kernel` | `\label` only, no `\ref` call in the sample |
| contents lists (not used) | informs4.cls:783-841 | `toc.kernel` | class `\tableofcontents`, `\listoffigures`, `\listoftables` |
| lists (not used) | informs4.cls:1658-1742 | `list.kernel` | `itemize`, `enumerate` via `\list`, itemindent 1.5em, zero leftmargin |
| quote, extract (not used) | informs4.cls:935-939, 1581-1595 | `quote.kernel` | `quote`, `quotation`, `verse`, `extract` as `\list` |
| colour, url | informs4.cls:6, 1938 | `color.color`, `meta.url` | `\textcolor{red}` on the notice |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| natbib hooks `\def\bibfont`, `\bibsep`, `\bibhang`, `\newblock`, `\BIBand` | main:38-42, scope preamble | yes | `bib.natbib` parameters (natbib hooks); `\newblock` and `\BIBand` are inert with a hand-written `thebibliography` |
| `\providecommand` of `\natexlab`, `\url`, `\urlprefix` | main:345-347, scope body | yes | aliases; `\url` is `meta.url` |
| endnote group `\parindent 0pt \parskip 0.0ex \def\enotesize{\normalsize}` | main:305, scope body | yes | `sp.lengths` plus the `fn.endnotes` size hook |
| `eqndefns-left.sty` (and `eqndefns-center.sty`, differs only at eqndefns-left.sty:239, 273 by `\hfil`/`\hfill` centring, read by diff) | main:17; eqndefns-left.sty:107-409, scope preamble | not reduced; official-kit companion | published by INFORMS with the class, so not bespoke by W1; recorded under `class.informs4` vocabulary. Internally it measures display equations in boxes and prints a red warning box and a margin note over 240pt (eqndefns-left.sty:41, 52, 56), redefining amsmath environments with amsmath internals; it also loads `tcolorbox` with `most` (eqndefns-left.sty:18; library set not checked) |
| informs4.cls internals (`\@startsection` family, `\maketitle`, caption makers, `\FIGURE`, `\TABLE`, list and theorem styles, running heads, copied dcolumn, `\Cline`) | informs4.cls:1134-1170, 1245-1366, 1658-1742, 1774-1830, 1980-2094, 2161-2260, 2449-2479, scope class | not reduced; published class | the class is the publisher's kit, so it is one way, `class.informs4` (informs4.cls:2); the sample calls it only by its documented commands |

## Content-opaque
- TikZ decision-tree picture inside the figure float (main:202-216).
- Equation bodies (main:141-171) and the `algorithmic` bodies (main:184-195, 222-258) are content.

## Lib changes
- New ways proposed: none. Considered and not proposed: `eqndefns-left` as a load-only way of its own (merged into the class vocabulary, as house-style companions are in lib v3); the `theorem` package (LaTeX tools bundle, loaded by the class at informs4.cls:6; the sample never calls it, its styles surface as `thm.class-native`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Reading notes: the PDFs (INFORMS-MNSC-Template.pdf, Style-Instructions.pdf) could not be rendered here (no PDF tool), so whether the kit documents eqndefns-left publicly is not confirmed; informs2014.bst (1502 lines, makebst-generated by Patrick W. Daly) was read only at its header, since the sample does not activate it.
