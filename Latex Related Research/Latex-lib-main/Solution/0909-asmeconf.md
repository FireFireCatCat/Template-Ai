yes

# 0909-asmeconf: asmeconf, a LaTeX template for ASME conference papers (v1.46, 2026/01/10)

- Unverified: read from the source, not compiled.
- Source: Source/0909-asmeconf/ (origin: https://mirrors.ctan.org/macros/latex/contrib/asmeconf.zip, CTAN `asmeconf`, also in TeX Live and MiKTeX; licence: MIT)
- Kind: conference
- Lib: v6
- Engine: pdfLaTeX-compatible (the active `\documentclass` line is the pdfTeX one, asmeconf-template.tex:111; the class also runs under LuaLaTeX, where it loads `fontspec` and `unicode-math`, asmeconf.cls:658; the LuaLaTeX options line is commented, asmeconf-template.tex:113)
- Look carried by: class (the published `asmeconf` class defines margins, fonts, headings, captions, title block, abstract, footer; the sample adds class options, `\DocumentMetadata`, `\hypersetup`, `\allowdisplaybreaks` and three text aliases)
- Class origin: ctan
- Main file: asmeconf-template.tex (other samples: examples/asmeconf-accessible-PDF-UA-2.tex, examples/asmeconf-authorgrid-example.tex, examples/asmeconf-fontspec.tex, examples/asmeconf-lualatex-ode-example.tex, examples/asmeconf-wide-equation-example/asmeconf-template-widetext.tex)
- Read: main yes, zip-local classes and styles all (asmeconf.cls 1-2636, examples/asmeconf-wide-equation-example/asmewide.sty 1-139); asmeconf.bst partly (header, ENTRY/READ outline, closing block at 1740-1801); the other samples were only grepped for loaded packages

## Verdict
The look is carried by a published class: `asmeconf` is on CTAN (ctan.org/pkg/asmeconf read: MIT, v1.46, in TeX Live), so it is one way, `class.asmeconf`, and its internal expl3 and `\@startsection` code is published code, not bespoke. The main sample only passes class options, calls the class's own commands, and uses lib ways for everything else (tabular with booktabs and dcolumn, subcaption figures, amsmath equations, BibTeX with the `asmeconf.bst` style, babel passages). Its only zip-local macros are three text aliases that reduce by inline expansion. No ART, no EXTERNAL, no new way. The one caveat: `examples/asmewide.sty` (not loaded by the main sample) is hand-written strip-and-leaders code that would be BESPOKE/package if an example were counted.

## Blockers
none (for the main sample). Out of scope, recorded only: `BESPOKE/package` examples/asmeconf-wide-equation-example/asmewide.sty:87-135 (leaders over boxes, `strip` rules), loaded only by the widetext example (examples/asmeconf-wide-equation-example/asmeconf-template-widetext.tex:34), not by asmeconf-template.tex

## Class setting
- Class: `class.asmeconf` options: colorlinks, upint, subscriptcorrection, varvw, hyphenate, balance, greek, russian, vietnamese, german (asmeconf-template.tex:111). The class loads `article` with `twoside,10pt` (asmeconf.cls:69) and passes unknown options on to babel and newtx (asmeconf.cls:501, 503). The class's own keys are balance, colorlinks, contractor, govt, govtsome, grid, lineno, loadscripts, main, nofontspec, nofoot, nohead, unboldcaption (asmeconf.cls:233-264). Note: the sample's comments name `[somegovt]` (asmeconf-template.tex:41, 533) but the class key is `govtsome` (asmeconf.cls:243).
- Class-native vocabulary used: `\ConfName` `\ConfAcronym` `\ConfDate` `\ConfCity` `\PaperNo` (asmeconf-template.tex:144-148), `\title` `\SetAuthors` with `\affil` `\JointFirstAuthor` `\CorrespondingAuthor`, `\SetAffiliation` (:156-181), `\maketitle` (:186), `\versionfootnote` and `\versionno` (:190), `\keywords` (:196), `abstract` and `abstract*` (:204, :678), `nomenclature` with `\entry` `\EntryHeading` (:216-232), `\NoCaseChange` (:156), `\section[pdf bookmark]{..}` (:450), `\hrefurl` (:237), column types `d{3.3}` and `,{3.3}` (:338), math versions `sans` and `sansbold` and `\sfalpha`-style Greek (:486), engine switches `\ifpdftex` `\ifScriptsLoaded` `\ifJapaneseLoaded` (:687, :702, :747).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | asmeconf-template.tex:111; asmeconf.cls:67-69 | `class.asmeconf` | options colorlinks, upint, subscriptcorrection, varvw, hyphenate, balance, greek, russian, vietnamese, german; base `article` twoside,10pt |
| paper size, base size | asmeconf.cls:69 | `page.class-options` | twoside, 10pt (article options inside the class) |
| page geometry | asmeconf.cls:508 | `page.geometry` | letterpaper, left=0.5in, right=0.5in, top=0.5in, bottom=1.in, footskip=0.5in, columnsep=0.38in; `\newgeometry` variants only for govt/contractor/govtsome (asmeconf.cls:1274, 1280, 1286) |
| two columns with full-width title block | asmeconf.cls:2150-2166, 2179; asmeconf-template.tex:186 | `cols.twocolumn-cmd` | `\twocolumn[title, authors, affiliations]` issued by `\maketitle`; columnsep 0.38in |
| balance last page | asmeconf-template.tex:111; asmeconf.cls:1569-1572 | `cols.balance` | option `balance` loads `flushend`, `\AtEndDocument{\flushcolsend}` (flushend is a load-only sibling of `balance`; considered: flushend, folded here) |
| line numbers (option, not selected) | asmeconf.cls:1543-1545 | `sp.draft-lineno` | option `lineno`: `lineno[switch,mathlines]`, `\linenumbers`, red footnotesize numbers |
| paragraph indent, bib spacing, footnote skips | asmeconf.cls:510, 516, 1312-1317 | `sp.lengths` | `\parindent`=0.25in, `\bibsep`=1pt plus 1pt minus 1pt, `\skip\footins`=\baselineskip, footnote rule 0.5in x 0.4pt |
| line-break tolerance | asmeconf.cls:1211-1212 | `sp.hyphenat` | `\tolerance`=2500 (the parameter `\sloppy` sets); `\emergencystretch`=3em is `sp.lengths` |
| font sizes | asmeconf.cls:1218-1220 | `font.size-commands` | `\LARGE`=16/19.2, `\large`=11/13.6 via `\@setfontsize` |
| text and math fonts (pdfTeX) | asmeconf.cls:653, 655 | `font.newtx` | `newtxtext[helvratio=.91,largesc=true]` (asmeconf.cls:391), `newtxmath` (options upint, subscriptcorrection, varvw from the class line) |
| typewriter font | asmeconf.cls:654 | `font.mono` | `inconsolata[varqu,varl,scale=1.03,hyphenate]` |
| encodings | asmeconf.cls:646 | `font.fontenc-t1` | `fontenc[T2A,T5,LGR,T1]` chosen by the language options |
| extra families for Greek, Cyrillic, Vietnamese | asmeconf.cls:2446-2628 | `font.nfss` | `\DeclareFontFamily`/`\DeclareFontShape` for T5 `qtm` `qcr`, LGR `artemisia` `maksf`, T2A `PTSerif-TLF` `PTSans-TLF` `PTMono`, scaled 0.85-0.97; also `\DeclareMathVersion` `sans` `sansbold` and `\DeclareMathSymbol` for `\sfalpha` (asmeconf.cls:1233-1250, 2339-2408) |
| LuaLaTeX font branch (not the active path) | asmeconf.cls:658, 674-709 | `font.unicode-math`, `font.fontspec` | `unicode-math[mathbf=sym]`, `\setmainfont{TeXGyreTermesX}`, Heros, Inconsolatazi4, Lete Sans Math |
| colour | asmeconf.cls:513 | `color.xcolor` | `xcolor[dvipsnames,svgnames,x11names]` |
| languages | asmeconf-template.tex:111, 640, 657-699; asmeconf.cls:650 | `lang.babel` | `babel` with options greek, russian, vietnamese, german; `\selectlanguage`, `selectlanguage` environment, `main=USenglish` (asmeconf.cls:339) |
| Japanese (LuaLaTeX only, not active) | asmeconf-template.tex:747-760; asmeconf.cls:1119 | `lang.cjk` | `luatexja-fontspec[no-math]` under class option `japanese` |
| PDF standard and language | asmeconf-template.tex:89-96 | `meta.documentmetadata` | lang=eng-US, pdfstandard=A-3u, pdfversion=1.7 (tagging lines commented); `\tagpdfsetup{table/header-rows={1}}` at :316, :337, :356 |
| PDF metadata and link look | asmeconf-template.tex:117-124; asmeconf.cls:1449-1464 | `meta.hyperref` | `\hypersetup{pdfauthor,pdftitle,pdfkeywords,pdfsubject}`; class `hyperref[psdextra]`, linkcolor/citecolor/urlcolor=blue, pdfpagelayout=SinglePage, option colorlinks |
| glyph-to-Unicode maps | asmeconf.cls:1445-1446 | `meta.glyphtounicode` | `\InputIfFileExists{glyphtounicode-cmr.tex}` and `{glyphtounicode-ntx.tex}` (pdfTeX only) |
| URL style | asmeconf.cls:1466-1468 | `meta.url` | `\urlstyle{same}`; the `doi` package prints DOI links for the .bbl (considered: doi, a class-internal load, no sample call) |
| external links | asmeconf-template.tex:237, 239; asmeconf.cls:1471 | `xref.hyperref` | `\hrefurl{url}{text}` = `\href` (hyperref link command) |
| labels and references | asmeconf-template.tex:262, 264, 280 | `xref.kernel` | `\label`, `\ref`, `\eqref` (class redefines `\eqref`, asmeconf.cls:1201) |
| conference header block | asmeconf-template.tex:144-148; asmeconf.cls:1700-1752 | `hf.class-native` | name, acronym, date, city, paper number set by strings; `nohead` option drops it |
| footer | asmeconf.cls:1255-1271, 1291-1293 | `hf.fancyhdr` | `fancyhdr`: centre `\thepage`, right "Copyright (c) year by ASME"; no rules; `nofoot`, `govt`, `contractor`, `govtsome` swap the text |
| title, authors, affiliations | asmeconf-template.tex:156-186; asmeconf.cls:2053-2084, 2150-2180 | `front.class-native` | inline author style (grid style with option `grid`, asmeconf.cls:1808-2038), `\affil{n}`, markers dagger and asterisk, footnoted corresponding author; `\title` shown in uppercase sans bold 11pt (asmeconf.cls:1747-1748) |
| version footnote, `\thanks` disabled | asmeconf-template.tex:190; asmeconf.cls:2184, 2193 | `front.class-native` | `\versionfootnote{text}` unmarked footnote |
| abstract | asmeconf-template.tex:204-206, 678-680, 689-699; asmeconf.cls:1626-1642 | `abs.class-native` | `abstract` and `abstract*` environments: `\section*{\abstractname}` then italic text |
| keywords | asmeconf-template.tex:196; asmeconf.cls:1599-1624 | `abs.keywords` | `\keywords{..}` printed after the abstract, "Keywords:" in bold sans |
| nomenclature list | asmeconf-template.tex:216-232; asmeconf.cls:1650-1680 | `front.class-native` | `nomenclature[2em][title]` over a `list`, `\entry{symbol}{meaning}`, `\EntryHeading{..}` |
| section headings | asmeconf-template.tex:236, 241, 404, 450, 566; asmeconf.cls:1332-1349, 1354-1364 | `head.class-native` | `\@startsection` redefinitions: section 12pt/1pt skips, sans bold, uppercase via `\MakeTextUppercase`; subsection title case; subsubsection run-in with `.`; `\paragraph`=subsubsection; starred sections get bookmarks |
| uppercase control in headings | asmeconf-template.tex:156, 294, 397; asmeconf.cls:1335, 1436 | `mark.case` | `\NoCaseChange{..}`, `\MakeTextUppercase`, `\AddToNoCaseChangeList{\eqref \footnote}` |
| appendices | asmeconf-template.tex:584; asmeconf.cls:1410-1427 | `num.appendix` | `\appendix` redefined: letters A, B, ... "APPENDIX A." headings, equations keep counting |
| lists and quotes | asmeconf-template.tex:606, 469-471, 503-507 | `list.kernel`, `quote.kernel` | `description`; `quote` environment |
| alignment of blocks | asmeconf-template.tex:497, 503; :338 | `sp.ragged` | `center` environment, `\raggedright` in a quote and in the `>{}` column |
| footnotes | asmeconf-template.tex:292, 397, 399; asmeconf.cls:1297-1310, 1321-1323 | `fn.kernel` | `\footnote` (also in headings), comma between consecutive notes |
| footnote indent for formats before 2025/06/01 | asmeconf.cls:1302-1309 | `fn.footmisc` | `footmisc[belowfloats]`, `\footnotemargin`=2ex (newer formats patch `\@makefntext` instead, :1300) |
| equations | asmeconf-template.tex:267-269, 455-458, 464-466, 594-599 | `math.amsmath` | `equation`, `multline`, `align`, `\allowdisplaybreaks` (:130), `\left`..`\right`, `\underbrace` |
| math packages loaded by the class | asmeconf.cls:642, 1197 | `math.mathtools`, `math.bm` | `mathtools` (loads amsmath); `bm` (pdfTeX only) |
| bold math span | asmeconf-template.tex:481-482; asmeconf.cls:1335 | `mark.kernel` | `{\mathversion{bold} ...}`; the class uses `\mathversion{sansbold}` in headings and captions; `\mathrm \mathbf \mathsf` alphabets at :465 |
| figures | asmeconf-template.tex:278-281, 420-436; asmeconf.cls:512 | `fig.graphicx` | `figure` and `figure*`, `\centering`, `\includegraphics[width=\linewidth, alt={..}]`; PDF artwork is content |
| subfigures | asmeconf-template.tex:421-434; asmeconf.cls:537 | `fig.subcaption` | `subfigure[b]{\columnwidth}`, `\subcaption`, `\hspace*{\columnsep}` |
| captions | asmeconf-template.tex:280, 314, 435; asmeconf.cls:536, 575-592, 636-637 | `cap.caption`, `cap.kernel` | `caption[labelformat=uppercasebold, labelfont={sf,bf,small}, textfont={sf,bf,small}, labelsep=colon, skip=0.5\baselineskip]`; figure captions below, table captions above; `unboldcaption` switches to medium weight |
| tables | asmeconf-template.tex:317-324, 338-346, 357-378; asmeconf.cls:522 | `tbl.tabular` | `tabular`, `tabular*{0.8\textwidth}` with `@{\extracolsep{\fill}}`, `!{\hspace*{0.5cm}}`, `>{\raggedright\hangindent=1em}p{3cm}`, `\multicolumn`, float `table[t]` and `table*` |
| table rules | asmeconf-template.tex:318-323, 358, 364; asmeconf.cls:521 | `tbl.booktabs` | `\toprule \midrule \bottomrule` |
| decimal-aligned columns | asmeconf-template.tex:338; asmeconf.cls:524-529 | `tbl.siunitx` | `dcolumn`: `\newcolumntype{d}[1]{D{.}{.}{#1}}` and `{,}[1]{D{,}{,}{#1}}` |
| rules and manual spacing in tables | asmeconf-template.tex:359, 365, 373, 377, 427 | `sp.rule`, `sp.manual-space` | `\rule{0pt}{11pt}`; `\makebox[0pt][l]{14}` (kernel box command of the `\raisebox` family), `\\[2pt]`, `\hspace*` |
| raw length in a column | asmeconf-template.tex:338 | `sp.lengths` | `\hangindent=1em` |
| inline code | asmeconf-template.tex:244-246 | `code.verbatim` | `\verb|..|` |
| citations | asmeconf-template.tex:260-261; asmeconf.cls:515 | `bib.natbib` | `natbib[sort&compress,numbers]`, `\cite`, `\nocite{*}` (:577) |
| bibliography | asmeconf-template.tex:579-580; asmeconf.bst:1749-1798 | `bib.bibtex-bst` | `\bibliographystyle{asmeconf}`, `\bibliography{asmeconf-sample}`; the style writes a `thebibliography` with `\providecommand` fallbacks for `\doi`, `\url`, `\eprint` |
| accents and symbols | asmeconf-template.tex:319, 647 | `font.fontenc-t1` | `\textdegree` (textcomp), UTF-8 letters |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand*\pdfTeX`, `\LuaLaTeX`, `\BibTeX` | asmeconf-template.tex:134-136 | yes | text aliases; expand inline (`pdf\TeX`, `Lua\LaTeX`, `Bib\TeX`), no node needs them |
| `asmeconf.cls` code (expl3 coffins, `\@startsection`, option keys, font setup) | asmeconf.cls:1-2636 | not bespoke | published on CTAN and in TeX Live; it is the way `class.asmeconf`; the emitter writes `\documentclass[..]{asmeconf}` and the class commands |
| `\ifpdftex`, `\ifScriptsLoaded`, `\ifJapaneseLoaded` branches | asmeconf-template.tex:687-760; asmeconf.cls:74, 357-358, 435 | yes | `\newif` switches of the published class choosing demo abstracts by engine; the emitter writes the one branch for its engine (pdfTeX: Greek and Russian `abstract*` under `selectlanguage`); `\IfFontExistsTF` (fontspec) and `\ClassWarning` occur only in the LuaLaTeX branch |
| `asmeconf.bst` | asmeconf.bst:1-1801 | not bespoke | BibTeX style shipped in the CTAN package, a parameter of `bib.bibtex-bst` |
| `asmewide.sty` (`widetext`) | examples/asmeconf-wide-equation-example/asmewide.sty:87-135 | out of scope | not loaded by the main sample; `cuted` `strip` plus leaders over boxes; would be `BESPOKE/package` (partly `cols.cuted` and `sp.rule`) |
| Lua code in `luacode*` and `\directlua` | examples/asmeconf-lualatex-ode-example.tex:55-91 | out of scope | other sample, content-side computation (plot data), not the main sample |

## Content-opaque
- Figure artwork sample-figure-1.pdf, sample-figure-2a.pdf, sample-figure-2b.pdf (asmeconf-template.tex:279, 423, 431), shipped assets.
- Foreign-language abstract and appendix text (asmeconf-template.tex:659-660, 679, 690, 696, 709-754); the Noto and Amiri fonts used by the LuaLaTeX branch are not in TeX Live (asmeconf-template.tex:610 footnote) and belong to an inactive path.
- `\typeout` lines (asmeconf-template.tex:646, 684) print only to the log.

## Lib changes
- New ways proposed: none (considered: flushend, folded into `cols.balance` as a load-only sibling of `balance`; doi, class-internal and never called by the sample)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
