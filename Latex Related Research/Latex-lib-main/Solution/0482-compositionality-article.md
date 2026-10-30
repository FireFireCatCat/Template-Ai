no

# 0482-compositionality-article: Compositionality Article

- Unverified: read from the source, not compiled.
- Source: Source/0482-compositionality-article/ (origin: https://latextemplates.com/downloads/compositionality.zip; licence: LPPL-1.3c)
- Kind: journal
- Lib: v4
- Engine: pdfLaTeX-compatible (the class checks `\pdfoutput` and errors without it: compositionalityarticle.cls:262-278; no fontspec, no Lua)
- Look carried by: zip-local (the whole look is in `compositionalityarticle.cls`; `main.tex` only loads packages and sets the issue and DOI strings)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
`no`. Most of the class reduces to lib ways, but two parts of the title block are irreducible. The title size is chosen by measuring the title in saved boxes (compositionalityarticle.cls:1099-1121). The author, affiliation and extras block is driven by hand-rolled counters and per-author lists (compositionalityarticle.cls:1125-1319).

The class is treated as zip-local under the rubric. The zip comes from latextemplates.com, and its README says the starter is original to the catalogue and the class is redistributed. `ctan.org/pkg/compositionalityarticle` and `ctan.org/pkg/compositionality` both returned 404 (read for this analysis). The README's claim that the class is the journal's own (README.md:7-9) could not be checked. If the owner rules the journal's class publisher-official, the answer becomes `yes` through `class.compositionalityarticle`; that is a different ruling from the rubric as written.

## Blockers
- `BESPOKE/class` the title font size is computed: the title is set at `\Huge` in a `parbox` and on one line, both saved in boxes, and their heights are compared to choose `\Huge` or `\huge` (compositionalityarticle.cls:1086-1121). The result depends on font metrics and line breaking, so an emitter cannot know it in advance.
- `BESPOKE/class` the author, affiliation and extras block is built by counters and etoolbox lists (compositionalityarticle.cls:1125-1319): label to affiliation-number maps, comma/"and" joins computed from `\the@authorcounter`, superscripts only when more than one affiliation, `\llap` numbering with `\leftskip` set by `\settowidth`, and per-author email/homepage/ORCID/thanks lines inserted by `\insert\footins` (compositionalityarticle.cls:1163-1182, 1240-1272). The printed output is driven by the counters and conditionals. This is neither `front.authblk` nor `front.titling`.
- `BESPOKE/class` the two-column `widetext` environment is leaders-and-box code adapted from revtex (compositionalityarticle.cls:1018-1052). It is the class's default mode (`twocolumn`, compositionalityarticle.cls:237), but the sample is one-column, where `widetext` is empty (compositionalityarticle.cls:1054). Unexercised by the sample, so the verdict does not rest on it. It calls `\prep@math@patch`, which this class never defines (compositionalityarticle.cls:1040); I did not establish where it comes from.

## Class setting
- Class: zip-local `compositionalityarticle` v3.3 (compositionalityarticle.cls:21-24), not a lib way. It is a fork of `article.cls` (header comment compositionalityarticle.cls:9-10; it `\input`s `size1x.clo` at compositionalityarticle.cls:252 and never calls `\LoadClass`). The reduction base is `class.article`. Options in the sample: `a4paper,onecolumn,10pt,allowtoday` (main.tex:1). Class defaults: `10pt,oneside,twocolumn,notitlepage,final` (compositionalityarticle.cls:237).
- Class-native vocabulary used by the sample: `\title`, `\date{}`, `\author`, `\email`, `\homepage`, `\affiliation`, `\maketitle` (main.tex:21-30); `abstract` (main.tex:32-37); author-set strings read by the class: `\authorsforheader`, `\compositionalityIssue`, `\compositionalityVolume`, `\paperdoinumber`, `\paperdoi`, `\receiveddate`, `\accepteddate` (main.tex:11-17); `\pdfoutput=1` (main.tex:2).
- Vocabulary supported but unused by the sample: `\orcid`, `\thanks[..]`, `\keywords` (metadata only: compositionalityarticle.cls:1405-1407, 533), `\address`, `\affil`, `\collaboration`, `\altaffiliation`, `\ead`, `\acknowledgments`, `acknowledgements` environment (compositionalityarticle.cls:1193-1235, 1348-1356, 858-862, 1493); `\appendix{...}` taking its body as an argument (compositionalityarticle.cls:713-719); class options `accepted`, `unpublished`, `noarxiv`, `shorttitle`, `issue`, `volume` (the last three are stored and never used: compositionalityarticle.cls:201-203), `allowfontchangeintitle`, `nopdfoutputerror`, and the revtex-compatibility options (compositionalityarticle.cls:204-210, 1419-1489).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class base (reduction) | compositionalityarticle.cls:9-10, 252 | `class.article` | the fork re-implements article's lists, toc, footnotes, floats; the differences are rows below |
| paper, size, columns, sides | main.tex:1; compositionalityarticle.cls:38-43, 81, 85, 94, 237 | `page.class-options` | a4paper (297x210mm), 10pt, onecolumn, oneside, notitlepage, final |
| page geometry | compositionalityarticle.cls:287-289 | `page.geometry` | one-column: margin=3cm, bottom=3cm (two-column branch: margin=2cm, bottom=3cm) |
| running header and footer | compositionalityarticle.cls:954-972 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\headrule` empty; head L = `\authorsforheader` (sffamily, scriptsize, compositionalitypink), head R = title (same style); foot L = `\logo` + "Compositionality, Volume, Issue (\the\year)" (sffamily, scriptsize, pink); foot R = page number (sffamily, pink) |
| footrule | compositionalityarticle.cls:958 | `sp.rule` | `\leaders\hrule\hfil` in `white` over `\headwidth` in a zero-height vbox (invisible rule; colour via `color.xcolor`) |
| first-page style | compositionalityarticle.cls:430-448, 492 | `hf.fancyhdr` | `\fancypagestyle{firststyle}`: chead "ISSN 2631-4444", lhead `\biglogo` + minipage (journal name, `\href` URL), rhead "Volume, Issue (year)", lfoot DOI line with `\href{\paperdoi}{\paperdoinumber}`; `\thispagestyle{firststyle}` called inside `\maketitle` |
| journal logo | compositionalityarticle.cls:1330-1331 | `fig.graphicx` | `\includegraphics[width=0.065\textwidth]` (header) and 0.035\textwidth (footer) in `\raisebox`; the file is `logo.eps`, and the zip ships `logo-eps-converted-to.pdf`; see Content-opaque and notes |
| logo raise and size | compositionalityarticle.cls:1330-1331 | `sp.manual-space` | `\raisebox{-0.3cm}[0.1cm]`, `\raisebox{-0.15cm}[0.1cm]` |
| page numbering | compositionalityarticle.cls:1007 | `pgnum.pagenumbering` | arabic |
| bottom flush | compositionalityarticle.cls:1008 | `pg.flush` | `\raggedbottom` when oneside |
| line and paragraph spacing | compositionalityarticle.cls:292-295, 953 | `sp.lengths` | `\lineskip` 1pt, `\normallineskip` 1pt, `\parskip` 0pt plus 1pt, `\footnotesep` = `\baselineskip` |
| baseline stretch | compositionalityarticle.cls:294 | `sp.linespread` | `\baselinestretch` emptied |
| list, toc, footnote and tabular lengths | compositionalityarticle.cls:609-627, 720-727, 782-785, 926-934 | `list.kernel` | values as in `article.cls` to my knowledge (article's own source was not read here), except `tocdepth` 3 (article: 2); `\leftmargini` 2.5em one-column, `\labelsep` .5em, penalties `-\@lowpenalty` |
| float placement parameters | compositionalityarticle.cls:381-390, 489, 731, 746 | `fig.placement` | topnumber 2, topfraction .7, bottomnumber 1, bottomfraction .3, totalnumber 3, textfraction .2, floatpagefraction .5, dbl* equivalents; default placement `tbp`; `\global\@topnum\z@` in `\maketitle` keeps floats off the top of page 1 |
| title hyphenation | compositionalityarticle.cls:518 | `sp.penalties` | `\hyphenpenalty=5000` inside the title group |
| footnote marks in the title group | compositionalityarticle.cls:482-486 | `num.counters` | `\thefootnote` set to `\@fnsymbol\c@footnote` while `\maketitle` runs (symbols, not numbers) |
| fonts | compositionalityarticle.cls:321-323; main.tex:4-5 | `font.lmodern` | loaded when `lmodern.sty` exists (else `type1ec`/cm-super check) |
| encodings | main.tex:4-5 | `font.fontenc-t1` | `inputenc` utf8, `fontenc` T1 |
| sans text and sizes | compositionalityarticle.cls:511, 518, 587-597, 1099-1121 | `mark.kernel` | `\sffamily` for title block and sections 1-3 |
| font sizes | compositionalityarticle.cls:518, 587-597 | `font.size-commands` | `\huge`/`\Huge` title, `\Large` section, `\large` subsection and authors, `\footnotesize` affiliations, `\scriptsize` header/footer |
| colours | compositionalityarticle.cls:346-349 | `color.xcolor` | `compositionalitypink` RGB 255,90,95; `compositionalitydarkpink` RGB 255,70,76; `compositionalitygray` HTML 555555 |
| sectioning | compositionalityarticle.cls:584-607 | `head.kernel` | `\@startsection`: section {-3.5ex plus -1ex minus -.2ex}{2.3ex plus .2ex} `\normalfont\Large\sffamily`; subsection {-3.25ex ..}{1.5ex plus .2ex} `\large\sffamily`; subsubsection `\normalsize\sffamily`; paragraph `\bfseries` run-in -1em |
| numbering depth | compositionalityarticle.cls:540, 785 | `num.secnumdepth` | secnumdepth 3, tocdepth 3 |
| number formats | compositionalityarticle.cls:547-552, 728 | `num.counters` | `\thepart` Roman, `\thesection` arabic, `\thesubsection` `\thesection.\arabic`, `\theequation` arabic |
| title block shell | compositionalityarticle.cls:510-527, 480-507 | `front.maketitle` | `\title` `\author` `\date{}` `\maketitle`; `\vskip 3.5em`, title minipage, `\vskip 1.5em`, authors, `\vskip 1em`, affiliations; date in `\footnotesize` gray when not empty |
| title as hyperlink | compositionalityarticle.cls:1059-1082 | `meta.hyperref` | `\href{\paperdoi}{...}` inside a `\raggedright` minipage, colour `compositionalitypink` (non-`unpublished` mode) |
| title font size choice | compositionalityarticle.cls:1086-1121 | none: blocker | computed by box measurement, see Blockers |
| author and affiliation block | compositionalityarticle.cls:1125-1319 | none: blocker | counter and list driven, see Blockers |
| abstract | compositionalityarticle.cls:664-671; main.tex:32-37 | `abs.kernel` | `\renewenvironment{abstract}` as `\vskip 1em` + `quotation` + `\noindent\ignorespaces` ... `\endquotation\vskip 2em` |
| abstract wrapper | compositionalityarticle.cls:683-689, 666-669 | `quote.kernel` | `quotation` environment (listparindent 1.5em) |
| abstract skips | compositionalityarticle.cls:666, 669 | `sp.manual-space` | `\vskip 1em` before, `\vskip 2em` after |
| quote, verse | compositionalityarticle.cls:673-694 | `quote.kernel` | article's definitions |
| lists | compositionalityarticle.cls:628-648 | `list.kernel` | `itemize`, `enumerate`, `description` with article's labels |
| equations | main.tex:7, 48-51, 77 | `math.amsmath` | `equation`, `\label`, `\eqref` |
| math symbols | main.tex:7 | `math.amssymb` | package loaded |
| `\openone` | compositionalityarticle.cls:330-345 | `math.bm` | `\DeclareRobustCommand\openone{\mathds{1}}` (dsfont; the class falls back from `bbm` to `dsfont` to overstruck 1) |
| figure float | main.tex:57-72; compositionalityarticle.cls:729-742 | `fig.graphicx` | `figure[ht]`, kernel `\@float` |
| figure centring | main.tex:58 | `sp.ragged` | `\centering` |
| caption text | main.tex:70 | `cap.kernel` | `\caption` |
| caption look | compositionalityarticle.cls:1501-1505 | `cap.caption` | `\PassOptionsToPackage{font={small,sf}}{caption}`, loaded `\AtEndPreamble`, so it replaces the class's own `\@makecaption` (compositionalityarticle.cls:763-770) |
| labels and refs | main.tex:50, 71, 77 | `xref.kernel` | `\label`, `\ref` through `\eqref` |
| hyperref | main.tex:8; compositionalityarticle.cls:1368-1379, 1385-1387 | `meta.hyperref` | `colorlinks=true`, `hyperindex`, `allcolors=compositionalitydarkpink` (gray when unpublished), `breaklinks=true` when `\pdfoutput` is not 0 |
| PDF metadata | compositionalityarticle.cls:529-536 | `meta.hyperref` | `\hypersetup{pdftitle, pdfauthor, pdfkeywords, pdfcreator}` taken from the title, authors and `\keywords` |
| language | main.tex:6 | `lang.babel` | english |
| bibliography | main.tex:86-90; compositionalityarticle.cls:867-899 | `bib.thebibliography` | article's `thebibliography` plus `\itemsep` 0pt plus 0.3ex; `\bibitem` and `\cite` (main.tex:55, 87) |
| bibliography penalties | compositionalityarticle.cls:890-893 | `sp.penalties` | `\clubpenalty` 4000, `\widowpenalty` 4000 |
| bibliography sloppy | compositionalityarticle.cls:890 | `sp.hyphenat` | `\sloppy` |
| DOI link in entry | main.tex:89 | `meta.hyperref` | `\href{https://doi.org/..}{doi:..}` |
| DOI link style, natbib and biblatex | compositionalityarticle.cls:1389-1401 | `bib.natbib` | unused by the sample: `\bibsep` 0pt plus 0.3ex and a `\doi` link command when natbib is loaded; `bib.biblatex-bibtex` also named there (`doi=true`, DOI field format) |
| revtex compatibility mode | compositionalityarticle.cls:1419-1489 | `bib.natbib` | unused by the sample: options `aps pra prb pre prl prx aip` pass `numbers`, `sort&compress` to natbib and wrap `\bibliography` to default to `plainnat` (`bib.bibtex-bst`) |
| table of contents | compositionalityarticle.cls:796-855 | `toc.kernel` | unused by the sample: article's entries; `\tocless` hides the heading from the toc (starred sections never write one) |
| tables | compositionalityarticle.cls:720-722, 744-757 | `tbl.tabular` | unused by the sample: article's lengths (tabcolsep 6pt, arraycolsep 5pt, arrayrulewidth .4pt, doublerulesep 2pt) |
| footnotes | compositionalityarticle.cls:926-934 | `fn.kernel` | unused by the sample: article's `\footnoterule` and `\@makefntext` |
| index | compositionalityarticle.cls:904-924 | `idx.makeidx` | unused by the sample: `theindex` environment, article-like |
| two-column mode | compositionalityarticle.cls:287-288, 354-361, 1009-1013 | `cols.twocolumn-option` | unused by the sample: class default; loads `ltxgrid` and redefines `\twocolumn` and `\onecolumn` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| title font size by measured boxes | compositionalityarticle.cls:1086-1121 | no | needs TeX to measure; a fixed size changes the look |
| author, affiliation and extras block | compositionalityarticle.cls:1125-1319 | no | hand-rolled counters, lists and `\footins` inserts decide what prints |
| `widetext` (two-column) | compositionalityarticle.cls:1018-1052 | no (unexercised) | leaders and boxes with `\onecolumngrid`; sample is one-column |
| `\usepackage` patch and package blacklist | compositionalityarticle.cls:254-291, 1507-1549 | yes | guard only: a `\usepackage` of `titlesec`, `geometry`, `fancyhdr` or `authblk` is silently skipped (no message set: compositionalityarticle.cls:279-282, 285, 291, 955, 1196) and a listed font package raises `\ClassError` (compositionalityarticle.cls:1507-1549); the sample loads none of them, and the guard prints nothing, so omit it |
| `\pdfoutput` guards | main.tex:2; compositionalityarticle.cls:239-250, 1551 | yes | diagnostic only; pdfLaTeX already has `\pdfoutput=1`; emit a paper size and nothing else |
| `\today` guard | compositionalityarticle.cls:300-314, 947-950 | yes | warning or error only; the sample never calls `\today` |
| `\text` stub | compositionalityarticle.cls:1495-1499 | yes | error stub; `amsmath` (`math.amsmath`) already defines `\text` |
| elsarticle stubs, `\ead` | compositionalityarticle.cls:1348-1365 | yes | `\ead` aliases `\email`/`\homepage`; the rest are error stubs |
| `\appendix{...}`, `\acknowledgments{..}`, `acknowledgements` | compositionalityarticle.cls:713-719, 858-862, 1493 | yes | `\setcounter{section}{0}`, `\gdef\thesection{\@Alph\c@section}`, `\section*{Appendix}` (`num.appendix`, `num.counters`, `head.kernel`); the other two are `\section*{Acknowledg..}` (`head.kernel`) |
| `\tableofcontents` with `\tocless` | compositionalityarticle.cls:794-801 | yes | `toc.kernel`: the trick is redundant, a starred section writes no toc line |
| class option set with empty dummies | compositionalityarticle.cls:110-153, 171-187 | yes | no effect; options are accepted and ignored |
| `keywords` | compositionalityarticle.cls:1405-1407 | yes | only fills `pdfkeywords` (`meta.hyperref`); nothing is printed |
| dead code: `@titleforurl`, `@compositionalityacceptedbox`, `@issue`, `@volume`, `@shorttitle` | compositionalityarticle.cls:1066-1069, 1335-1339, 201-203 | yes | values are computed or stored and never printed |
| page style `headings` and `myheadings` | compositionalityarticle.cls:392-424 | yes | replaced by `\pagestyle{fancy}` (compositionalityarticle.cls:956); `hf.pagestyle-kernel`, not in effect |
| helper packages `xkeyval`, `etoolbox`, `ltxcmds`, `xstring` | compositionalityarticle.cls:25-26, 352, 1327 | yes | load-only helpers for the class's own macros, no printed effect (the v4 change log rejected `sys.compat-load` for the same reason); not needed once the macros are gone |

## Content-opaque
- TikZ picture inside a figure (main.tex:59-69), `art.tikz`; content, not template.
- `logo.eps` (compositionalityarticle.cls:1330-1331) is a vector image included by the class in the header and footer of every page (the `accepted` toggle is true by default: compositionalityarticle.cls:197). It is a shipped asset. The zip also ships `logo-eps-converted-to.pdf`, the cached `epstopdf` output, so the reduction should point `\includegraphics` at that PDF directly and avoid the Ghostscript conversion (`fig.epstopdf` is EXTERNAL when an EPS must be converted). `ORCIDiD_iconvector.pdf` is shipped for the unused `\orcid` path (compositionalityarticle.cls:1260).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Compile-date dependence: header and footer print `\the\year` (compositionalityarticle.cls:440, 967), so the issue year follows the compile date, not a template value.
- The README claims the class comes from the Compositionality GitHub repository (README.md:7-9); not checked, as network use was limited to ctan.org pages.
- Nothing in the zip was addressed to an AI.
