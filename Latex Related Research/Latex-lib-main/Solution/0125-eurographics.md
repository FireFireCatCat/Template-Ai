yes

# 0125-eurographics: Eurographics publications style (egpubl, Computer Graphics Forum and EG proceedings)

- Unverified: read from the source, not compiled.
- Source: Source/0125-eurographics/ (origin: https://www.eg.org/wp/wp-content/uploads/2024/12/egPublStyle-cgf.zip; licence: not established)
- Kind: journal
- Lib: v2
- Engine: pdfLaTeX-compatible (the class branches on ifpdf/ifxetex/ifluatex, egpubl.cls:2290-2488; the Adobe Type 1 Times, Helvetica and Courier fonts come from psnfss and are not in the zip)
- Look carried by: class (egpubl.cls fixes page, type sizes, title block, abstract, headings, running heads, captions, lists and the bibliography environment; the sample adds only class-native switches and kit packages)
- Class origin: publisher-official
- Main file: EGauthorGuidelines-cgf-fin.tex with EGauthorGuidelines-body.inc (other samples: EGauthorGuidelines-cgf-fin-cc-by.tex, EGauthorGuidelines-cgf-fin_with_teaser.tex with EGauthorGuidelines-body_with_teaser.inc, EGauthorGuidelines-cgf-sub.tex with EGauthorGuidelines-body-sub.inc)
- Read: main yes, zip-local classes and styles all (egpubl.cls lines 1350-1839, the per-publication-type page styles, were skimmed with repeated lines filtered; the two `.bst` files were read only at their headers and by diff)

## Verdict
The zip is the publisher's own kit (eg.org author page), so `egpubl.cls`, `dfadobe.sty`, `egweblnk.sty`, the `.fd` files, `EG.bbx` and the `.bst` styles are published under W1, and the sample adds only class-native commands, published packages and no macro of its own. Every component of the sample maps to `class.egpubl` or a lib way, no artwork defines the template, and nothing needs a tool beyond TeX and BibTeX or biber. The answer rests on the W1 ruling that an official kit is published: egpubl.cls is a hand-written LaTeX 2.09-style class that redefines `\@startsection`, `\@maketitle` and `\@makecaption`, and would be `BESPOKE/class` if it were zip-local.

## Blockers
none

## Class setting
- Class: `class.egpubl` options: none given (`\documentclass{egpubl}`, EGauthorGuidelines-cgf-fin.tex:5). The class reads old-style `\ds@` options `draft`, `twocolumn`, `onecolumn`, `galley` (egpubl.cls:140-145); the sample uses none. The publication type is chosen by a command instead: `\JournalPaper` (EGauthorGuidelines-cgf-fin.tex:20), licence by `\CGFStandardLicense` (:49).
- Class-native vocabulary used: `\JournalPaper`, `\CGFStandardLicense` (variant `\CGFccby`), `\electronicVersion`, `\PrintedOrElectronic`, `\BibtexOrBiblatex` (variant `\biberVersion`), `\title[short]{long}`, `\author[short]{...}`, `\orcid{id}`, `\thanks`, `\maketitle`, `abstract`, `CCSXML`, `\ccsdesc[weight]{...}`, `\printccsdesc`, `\teaser{...}` (variant sample only), `figure*`. Defined by the class but not used by the sample: about 30 other publication-type switches (`\ConferencePaper`, `\STAR`, `\WsPaper`, ... egpubl.cls:1159-1845), `\volume` `\issue` `\pStartPage` `\ConfName` `\ConfEditors` `\EGyear` `\ConfYear`, `\keywords`, `classification`, `\CCScat`, `proof`, `\appendix`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | EGauthorGuidelines-cgf-fin.tex:5; egpubl.cls:6-7 | `class.egpubl` | no options; type `\JournalPaper` (egpubl.cls:1180); the class ends by calling `\JournalSubmission` as default (egpubl.cls:2528), overridden by the sample |
| page geometry, two sides, two columns | egpubl.cls:137-145, 196-220 | `class.egpubl` | fixed in the class: `\@twosidetrue`, `\@twocolumntrue`, `\textwidth 42pc`, `\textheight 57\baselineskip`+`\topskip`, side margins -23pt, `\topmargin -1pc`, `\headheight 11pt`, `\headsep 11pt`, `\footskip 22pt`, `\columnsep 2pc` |
| type sizes and paragraphing | egpubl.cls:151-188, 257-267, 2513-2515 | `class.egpubl` | 9pt on 11pt (`\@setsize\normalsize{11pt}\ixpt`, :154), `\small` 8/10, `\parindent 1em`, `\parskip 5.5pt plus 1pt minus 1.5pt`, `\clubpenalty=0`, `\widowpenalty=10000`, `\flushbottom`, `\frenchspacing` |
| font encoding | EGauthorGuidelines-cgf-fin.tex:57 | `font.fontenc-t1` | `fontenc` option `T1` |
| default font families | dfadobe.sty:11-13; EGauthorGuidelines-cgf-fin.tex:58 | `font.family-default` | `\rmdefault`=ptm, `\sfdefault`=phv, `\ttdefault`=pcr, set by `\usepackage{dfadobe}` |
| font families and math fonts | dfadobe.sty:14-24, 32-46; dfT1ptm.fd:14, 59-61; dfT1phv.fd:13, 16, 63; dfT1pcr.fd:13, 41, 59-60 | `font.nfss` | T1 families ptm, phv, pcr with a condensed series `mc`; Helvetica scaled `[.9]`; `\DeclareSymbolFont`, `\DeclareMathAlphabet`, `\DeclareMathSizes` for Times math |
| title block | EGauthorGuidelines-body.inc:6-25, 47; egpubl.cls:711-785, 882-890 | `front.class-native` | `\title[short]{long}`, `\author[short]{\parbox{\textwidth}{\centering ...}}`; title `\huge\bfseries` centred (:756), authors `\normalsize` then `\small\rmfamily` (:758, :780), gaps 10pt, 35pt, 46pt |
| title above two columns | egpubl.cls:716-717 | `cols.twocolumn-cmd` | `\twocolumn[\vspace*{27pt}\@maketitle]` |
| author notes, ORCID icon | EGauthorGuidelines-body.inc:13-14; egpubl.cls:714-715, 790 | `front.thanks` | `\thanks` printed with `\fnsymbol` marks; printed after the abstract box (egpubl.cls:801); `\orcid{id}` = `\href{https://orcid.org/id}{\includegraphics{orcid}}` (orcid.pdf shipped) |
| teaser image slot (variant sample) | EGauthorGuidelines-body_with_teaser.inc:39-45; egpubl.cls:699-702, 766-773 | `front.class-native` | `\teaser{\includegraphics[width=0.9\linewidth]{eg_new}\centering\caption{...}}`; class sets `\@captype{figure}`, gaps `\titlespace`=-10pt, `\teaserspace`=12pt |
| abstract | EGauthorGuidelines-body.inc:49-98; egpubl.cls:793-806, 848 | `abs.class-native` | `abstract` in two-column mode is a full-width box between two 0.25pt rules (`\SFB@widerule`); `\list` margins 2pc, bold "Abstract" then italic text |
| CCS concepts | EGauthorGuidelines-body.inc:72-97; egpubl.cls:818-819, 823-839 | `abs.classification` | `\ccsdesc[300]{...}` (weight above 499 bold, above 299 italic), `\printccsdesc` prints `\section*{CCS Concepts}`; `CCSXML` is dropped by `\excludecomment` |
| headings | EGauthorGuidelines-body.inc:100, 110, 115, 379; egpubl.cls:348-367, 370-439 | `head.class-native` | section and subsection 9pt bold flush left, before `-11pt plus -5.5pt minus -1pt`, after `0.001pt`; number "1." plus 0.5em (:386); `\subsubsection*` through `\SFB@ssect` (:420); paragraph run-in `-0.5em` |
| numbering depth | egpubl.cls:368, 1886 | `num.secnumdepth` | `secnumdepth` 5, `tocdepth` 2 |
| running heads and feet | egpubl.cls:1180-1201, 1851-1863, 2512 | `hf.class-native` | odd head `\small\hfill\itshape author / title\hfill` plus page of total; first page style `titlepage`: "Volume, Number, pp. first--LastPage" and journal name "COMPUTER GRAPHICS forum" (:922, :1189-1193), `\tiny` copyright block in a 20pc parbox (:1195-1196); licence text from `\CGFStandardLicense` (:1010-1028), `\CGFccby` (:1031-1043, used in EGauthorGuidelines-cgf-fin-cc-by.tex:50) |
| page numbers | egpubl.cls:1125-1139, 2503, 2517 | `pgnum.lastpage`, `pgnum.pagenumbering` | `\thepage\ of \pageref*{LastPage}` (`lastpage` loaded at :1125); `\pagenumbering{arabic}`; `\setcounter{page}{\j@pStartPage}` |
| PDF links and metadata | EGauthorGuidelines-cgf-fin.tex:63, 72-73; egpubl.cls:730-731, 2390-2426, 2491-2497 | `meta.hyperref` | `hyperref[pdftex, pagebackref=true, colorlinks, linkcolor=blue, citecolor=blue, urlcolor=blue, bookmarks=false, pdfpagemode=UseNone, pdftitle, pdfauthor, pdfsubject, pdfkeywords={Computer Graphics Forum, EUROGRAPHICS}]`; print version: black links, `pagebackref=false` (:2427-2436) |
| web-link commands | EGauthorGuidelines-cgf-fin.tex:79; egweblnk.sty:7-25; EGauthorGuidelines-body.inc:326-355 | `meta.url`, `xref.hyperref` | `\DeclareUrlCommand\webLink{\urlstyle{df}}`, `\UrlFont`=`\ttfamily\fontseries{mc}\fontshape{n}\selectfont`; `\httpAddr` `\httpsAddr` `\ftpAddr` `\URL` `\MailTo` `\MailToNA` = `\href` plus `\webLink` |
| lists | EGauthorGuidelines-body.inc:230-239, 326-355; egpubl.cls:472-562 | `list.kernel`, `sp.lengths` | `itemize`, `description`; look fixed by the class (`\leftmargini 1em`, `\itemsep 0pt plus .1pt`, bold description label :559); local `\itemsep 1ex` (EGauthorGuidelines-body.inc:326) and `\noindent` |
| figures | EGauthorGuidelines-body.inc:187-192, 255-273, 479-503; EGauthorGuidelines-cgf-fin.tex:76-77; egpubl.cls:297-308 | `fig.graphicx` | `figure[htb]`, `figure*[tbp]`, `graphicx[pdftex]`, `\includegraphics[width=.8\linewidth]{sampleFig}`, `\centering`; default placement `tbp` (:287-288 for non-galley) |
| captions | EGauthorGuidelines-body.inc:189, 271-272, 493-502; egpubl.cls:304, 310-318 | `cap.kernel` | class `\@makecaption`: bold "Figure N:" then italic text, centred on one line if it fits, else justified; `\vskip 6pt` above and below |
| boxes and alignment | EGauthorGuidelines-body.inc:13, 19, 266-269, 481-492 | `box.minipage`, `sp.ragged`, `sp.manual-space` | `\parbox{\textwidth}{\centering ...}`, `\parbox[t]{.9\columnwidth}{...}`, `\mbox{}\hfill`, `\newline` |
| inline marks and page break | EGauthorGuidelines-body.inc:182, 201, 226, 476 | `mark.kernel`, `xref.kernel`, `pg.break` | `\textbf`, `\emph`, `\texttt`, `\ref`, `\label`, `\newpage` |
| inline maths | EGauthorGuidelines-body.inc:130-131, 281, 292-295 | `math.kernel` | `$...$` only; no `amsmath`; class redefines `\eqnarray` (egpubl.cls:664-677), unused |
| footnotes | EGauthorGuidelines-body.inc:218; egpubl.cls:2043-2068 | `fn.kernel` | class: `\footnote` issues a warning (:2065), `\fnsymbol` marks (:2048-2058), rule 0.4`\columnwidth` (:2045); the sample asks for none |
| code blocks | EGauthorGuidelines-body.inc:385-387, 395-421; egpubl.cls:2082-2254 | `code.verbatim` | `verbatim` (class carries its own copy of `verbatim.sty`), font `\reset@font\small\ttfamily` (:2254) |
| bibliography (main sample) | EGauthorGuidelines-cgf-fin.tex:60, 63; EGauthorGuidelines-body.inc:468-469; egpubl.cls:1994-2015 | `bib.bibtex-bst`, `bib.cite-pkg` | `\bibliographystyle{eg-alpha-doi}`, `\bibliography{egbibsample}`, `cite`; environment: `\subsection*{References}`, 8/9pt, `\itemsep 4pt plus 1pt minus 1pt`, `\leftmargin 1em`, labels "[key] " (egpubl.cls:2012) |
| bibliography (biber variants) | EGauthorGuidelines-cgf-fin_with_teaser.tex:62-65; EGauthorGuidelines-body_with_teaser.inc:471; EG.bbx:6-7, 47-66 | `bib.biblatex-biber` | `biblatex[backend=biber, bibstyle=EG, citestyle=alphabetic, backref=true]`, `\addbibresource{egbibsample.bib}`, `\printbibliography`; EG.bbx options `labelalpha, sorting=anyt, maxnames=4, minnames=3, maxalphanames=4, minalphanames=3, useprefix=true`; EG-sub.bbx:7 uses 10/5/10/5 |
| tabular defaults (class) | egpubl.cls:617-637, 759 | `tbl.tabular` | `\tabcolsep 6pt`, `\arrayrulewidth .5pt`, `\hline` redefined; `tabular[t]{@{}c@{}}` holds the authors |
| theorem and proof look (class, unused) | egpubl.cls:593-608 | `thm.class-native` | `\@begintheorem` list-based, bold header; `proof` env ends with a 6.5pt framed square |
| quotes (class, unused) | egpubl.cls:568-586 | `quote.kernel` | `quote`, `quotation` margins 1.5pc; `verse` |
| contents lists (class, unused) | egpubl.cls:1883-1945 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables` in one column, `tocdepth` 2 |
| appendix, index, keywords (class, unused) | egpubl.cls:441-449, 2026-2034, 843-846 | `num.appendix`, `idx.makeidx`, `abs.keywords` | `\appendix` gives "Appendix A:" headings; `theindex` 8pt hanging; `\keywords` run-in bold "Keywords: " |
| PDF compression | EGauthorGuidelines-cgf-fin.tex:76 | none (no look effect) | pdfTeX primitive `\pdfcompresslevel=9` inside the `\ifpdf` branch; changes file size only, not look or structure, so no way is proposed |
| driver conditional, input split | EGauthorGuidelines-cgf-fin.tex:76-77, 82 | none (structure of the sample file) | `\ifpdf ... \else dvips \fi` and `\input{...body.inc}`; an emitter writes the pdf branch and one file |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `egpubl.cls` as a whole: `\@startsection` and `\@sect`, `\@maketitle`, `\@makecaption`, per-type `\ps@titlepage`, own `verbatim` copy, `\tabular` and `\eqnarray` redefinition, `.lbl` page-range file | egpubl.cls:310-318, 370-439, 711-785, 1159-1845, 2082-2254, 2519-2526 | not counted: it is the publisher's official class, so it is the way `class.egpubl`; irreducible (`BESPOKE/class`) only if the official-kit ruling were not applied | none |
| class-internal parameter settings | egpubl.cls:196-282 | yes | `page.setlength`, `sp.lengths`, `sp.penalties`, `sp.frenchspacing`, `pg.flush`, `fig.placement`, `font.size-commands` |
| `dfadobe.sty` | dfadobe.sty:10-46 | yes | `font.family-default` (rm=ptm, sf=phv, tt=pcr), `font.nfss` (families and math fonts), muskips (:25-27) as `sp.lengths`; also published as part of the kit |
| `dfT1ptm.fd`, `dfT1phv.fd`, `dfT1pcr.fd` | dfT1ptm.fd:14, dfT1phv.fd:13, dfT1pcr.fd:13 | yes | `font.nfss` (`\DeclareFontFamily`, `\DeclareFontShape` only) |
| `egweblnk.sty` (documented by `egWebLnk.dtx`) | egweblnk.sty:7-28 | yes | `meta.url` (`\DeclareUrlCommand`, `\urlstyle`), `xref.hyperref` (`\href`), `font.nfss` (`\fontseries{mc}`); the other commands are `\def` aliases |
| `EG.bbx`, `EG-sub.bbx` | EG.bbx:6-94 | yes | the biblatex style named by `bibstyle=EG` in `bib.biblatex-biber`, as a `.bst` is the parameter of `bib.bibtex-bst`; official kit; used only in the biber variants |
| `eg-alpha.bst`, `eg-alpha-doi.bst` | eg-alpha-doi.bst:1-9 | yes | the style parameter of `bib.bibtex-bst` (urlbst-extended, alpha labels, small-caps names) |

## Content-opaque
- `CCSXML` block, the ACM CCS XML export, swallowed by the class (EGauthorGuidelines-body.inc:72-90).
- Images in figures: `sampleFig` (EGauthorGuidelines-body.inc:259, 484, 491), `eg_new` in the teaser (EGauthorGuidelines-body_with_teaser.inc:40).
- Prose, command listings in `verbatim`, and the bibliography entries in egbibsample.bib.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Note: missing assets are standard (Adobe Times, Helvetica, Courier Type 1 and `ptm8t` style metrics from psnfss); `orcid.pdf`, `sampleFig.jpg` and `eg_new.jpg` are in the zip. The kit must be shipped with the output (`egpubl.cls`, `dfadobe.sty`, `egweblnk.sty`, the three `dfT1*.fd`, `orcid.pdf`, and `EG.bbx` or the `.bst` for the chosen bibliography route).
