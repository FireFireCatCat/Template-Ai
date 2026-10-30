yes

# 0908-aip-conference-proceedings: REVTeX 4.2f kit with the AIP substyle (sample: aipsamp.tex)

- Unverified: read from the source, not compiled.
- Source: Source/0908-aip-conference-proceedings/ (origin: https://cdn.journals.aps.org/test/345f0cd4-cab7-4271-9a46-7331fb57618a/revtex-tds-2023-05-30.zip; licence: not established in the manifest, the files state LPPL 1.3c at tex/latex/revtex/aip4-2.rtx:27-30)
- Kind: journal (the sample picks the J. Math. Phys. substyle `jmp`; the zip's title names the AIP Conference Proceedings substyle `cp`, an option of the same class)
- Lib: v6
- Engine: pdfLaTeX-compatible (the class only tests `\pdfoutput` to choose link code, tex/latex/revtex/revtex4-2.cls:1992; figure artwork ships as EPS, see Content-opaque)
- Look carried by: class (tex/latex/revtex/revtex4-2.cls plus the AIP substyle tex/latex/revtex/aip4-2.rtx; the sample adds only class options and graphicx, dcolumn, bm)
- Class origin: publisher-official
- Main file: doc/latex/revtex/sample/aip/aipsamp.tex (other samples: doc/latex/revtex/sample/aip/aiptemplate.tex; other class users are documentation or other societies: doc/latex/revtex/aip/aipguide4-2.tex, doc/latex/revtex/auguide/auguide4-2.tex, doc/latex/revtex/auguide/summary4-2.tex, doc/latex/revtex/aps/apsguide4-2.tex, sample/aps, sample/aapm, sample/sor)
- Read: main yes, zip-local classes and styles partly

The manifest names doc/latex/revtex/auguide/auguide4-2.tex as main. That file is the APS author guide (options `aps,prl`, doc/latex/revtex/auguide/auguide4-2.tex:11-15) and loads the doc-only `docs.sty`; it is not the AIP template, so aipsamp.tex is analysed instead. Files read: aipsamp.tex and aiptemplate.tex in full; aip4-2.rtx in full; revsymb4-2.sty, aps10pt4-2.rtx, docs.sty and README in full; revtex4-2.cls partly (header, class options, front matter, abstract, sectioning, floats, tables, bibliography, appendix, widetext, option processing; not the ltxgrid page-builder body, about lines 3150-5000, nor the tabular internals 924-1400). Not read: ltxutil/ltxfront/ltxgrid/ltxdocext `.sty` (separate copies; the class inlines the `kernel` and `options` parts of the first three, revtex4-2.cls:8-14, and never loads them), the `.dtx` sources, the other `.rtx` substyles (aps, aapm, sor, apsrmp, 11pt, 12pt), the five `.bst` files beyond their id line.

## Verdict
The sample is a manuscript that sets only class options (`aip,jmp,amsmath,amssymb,reprint`) and loads graphicx, dcolumn and bm (aipsamp.tex:22-34); it defines no macro, environment or counter of its own. Every look decision (title block, abstract, headings, running heads, captions, table rules, bibliography style, page geometry) is made by the published class `revtex4-2` and its AIP substyle, which come from the APS/AIP official kit, so under the rubric's W1 ruling for official kits they are published and the zip reaches `yes` with `Look carried by: class`. The kit's internals (own output routine, replaced `\@startsection` and `\@makecaption`) would be irreducible BESPOKE/class if the kit were treated as zip-local code; the `yes` rests on the official-kit ruling, not on a reduction of that code. No ART, EXTERNAL or UNMAPPED item was found.

## Blockers
none

## Class setting
- Class: `class.revtex4-2` options: `aip` (society, loads aip4-2.rtx, revtex4-2.cls:6220-6230, 6335-6340), `jmp` (journal substyle, aip4-2.rtx:99, 702-707), `reprint` (aipsamp.tex:27; revtex4-2.cls:5896-5900), `amsmath`, `amssymb` (aipsamp.tex:25; revtex4-2.cls:6123-6137). Commented alternatives: `preprint`, `author-year`, `author-numerical` (aipsamp.tex:26, 28-29). The template uses `[aip,graphicx]` and an alternative `[aip,reprint]` (aiptemplate.tex:13-14). Other substyle options exist: `jcp pop rsi jap apl apm cha pof bmf rse jmp adv sd jor cp` (aip4-2.rtx:89-103). The option `cp` (AIP Conference Proceedings) forces one column, `\textwidth 39pc`, centred headings `\large\bfseries`, abstract heading "Abstract.", `secnumdepth` 0, caption name `FIGURE` (aip4-2.rtx:1012-1222); the sample does not use it.
- Class-native vocabulary used: `\preprint`, `\title[short]{long}`, `\author`, `\altaffiliation[text]{}`, `\email`, `\homepage`, `\affiliation`, `\date`, `\thanks`, `\maketitle`, `abstract`, `\keywords`, `quotation` (re-bound to the lead-paragraph environment), `widetext`, `ruledtabular`, `acknowledgments`, `\appendix`, `\onlinecite`, `\footnotemark[n]`/`\footnotetext[n]` in tables, `\bibliography` with `aipnum4-2.bst`, `\nocite{*}`, `\openone` `\alt` `\agt` (from revsymb4-2).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/latex/revtex/sample/aip/aipsamp.tex:22-30 | `class.revtex4-2` | aip, jmp, amsmath, amssymb, reprint; date macro `\today` re-set by the substyle (aip4-2.rtx:633-640) |
| paper, type size | tex/latex/revtex/revtex4-2.cls:5896-5900, 5968; tex/latex/revtex/aps10pt4-2.rtx:40-41, 113-114 | `page.class-options` | letterpaper default, `reprint` selects 10pt (`\@xpt` on 11.5pt) |
| text block (jmp reprint) | tex/latex/revtex/aip4-2.rtx:819-858 | `page.class-options` | substyle sets lengths inside the class: `\textheight=53.5pc`, `\textwidth 33pc`, `\oddsidemargin 28pt`, `\topmargin -17pt` (aip4-2.rtx:829-847); no geometry package |
| columns | tex/latex/revtex/revtex4-2.cls:5896-5900; tex/latex/revtex/aip4-2.rtx:702-707, 824-826; doc/latex/revtex/sample/aip/aiptemplate.tex:14 | `cols.twocolumn-option` | `reprint` sets two columns; `jmp` switches back to one column in the main sample; the template's alternative `[aip,reprint]` is two-column |
| running head, first-page head and foot | tex/latex/revtex/aip4-2.rtx:187-193, 203-212, 320-336; sample title short form aipsamp.tex:42 | `hf.class-native` | `\ps@article`: page number, `\checkindate`, running title = optional short title; `titlepage` style carries `\preprint` numbers and "Typeset by REV\TeX and AIP" |
| title block | aipsamp.tex:40-59, 71; revtex4-2.cls:3127-3143; aip4-2.rtx:250-291 | `front.class-native` | `\preprint{AIP/123-QED}`; title sans bold raggedright (`\Large` only in reprint); authors `\sffamily`; affiliation italic; `\altaffiliation[Also at ]`, `\email[Electronic mail: ]`, `\homepage`; date `\today` |
| title note | aipsamp.tex:43; revtex4-2.cls:3139 | `front.thanks` | `\thanks` mapped to `\frontmatter@thanks` |
| abstract | aipsamp.tex:62-67; revtex4-2.cls:2548-2574, 3143; aip4-2.rtx:224-233 | `abs.class-native` | `abstract` environment; substyle: no heading (`\frontmatter@abstractheading{}`), indent 0.5in, `\parindent1em` |
| keywords | aipsamp.tex:69; revtex4-2.cls:2513-2516; aip4-2.rtx:180, 316-319 | `abs.keywords` | `\keywords{...}` shown because `\showKEYS@sw` is true; text `Keywords: ` (revtex4-2.cls:7510) |
| lead paragraph | aipsamp.tex:73-80; aip4-2.rtx:360-374 | `quote.kernel` | `quotation` is re-bound to `Lead@inParagraph` (bold, rule under) until the first sectioning command; recorded as class vocabulary |
| headings | aipsamp.tex:82, 103, 122, 162; aip4-2.rtx:375-433 | `head.class-native` | section: `\@startsection{section}{1}{\z@}{0.8cm \@plus1ex \@minus .2ex}{0.5cm}{\normalfont\small\sffamily\bfseries\raggedright}`, title upper-cased (aip4-2.rtx:392); subsection same size; subsubsection adds `\itshape`; `\paragraph` run-in italic `-1em` |
| heading numbers | revtex4-2.cls:6528-6552, 6677; aip4-2.rtx:375 | `num.counters`, `num.secnumdepth` | section Roman, subsection Alph, subsubsection arabic, `secnumdepth` 4, label "number." + `\quad`; `secnumarabic` alternative (revtex4-2.cls:6068-6071) |
| case switch in heading | aipsamp.tex:83 | `mark.case` | `\lowercase{via}` inside an upper-cased heading |
| appendix | aipsamp.tex:548-550; revtex4-2.cls:7372-7388; aip4-2.rtx:557-573 | `num.appendix` | `\appendix` (starred form `\appendix*`, revtex4-2.cls:7382); heading "Appendix A: Title"; equation prefix `\thesection` |
| acknowledgments | aipsamp.tex:542-546; revtex4-2.cls:6578-6588, 7505 | `front.class-native` | `acknowledgments` environment opens an unnumbered section "Acknowledgments" |
| displayed maths | aipsamp.tex:187-200, 206-211, 219-222, 229-269, 285-299, 594-602 | `math.kernel`, `math.amsmath` | `eqnarray`, `eqnarray*`, `equation`, `\[ \]`, `\nonumber` (kernel); `subequations`, `\tag`, `\text` (amsmath, loaded by class option, revtex4-2.cls:6132-6137) |
| math symbols and bold | aipsamp.tex:25, 34, 177-180, 196; revsymb4-2.sty:53, 69-70; revtex4-2.cls:7604-7607 | `math.amssymb`, `math.bm` | amssymb through the class option; `\usepackage{bm}`; revsymb4-2 (loaded by the class) supplies `\openone` `\alt` `\agt`, considered under `math.amssymb` as a symbol package |
| wide equation | aipsamp.tex:310-324; revtex4-2.cls:7399-7412, 7429-7458, 7465-7469 | `class.revtex4-2` | class-native `widetext`; full-width only in two-column; in the `jmp` one-column case it is a plain list (revtex4-2.cls:7469) |
| figures | aipsamp.tex:373-384; revtex4-2.cls:6694-6699, 6750 | `fig.graphicx` | `figure`, `figure*`, `\includegraphics{fig_1}`; default placement `tbp`; graphicx loaded at aipsamp.tex:32 |
| captions | aipsamp.tex:375, 382; revtex4-2.cls:6706-6745, 6749, 6780, 7498, 7500 | `cap.kernel` | class `\@makecaption`: `\small\rmfamily`, centred when one line; "FIG. 1." and "TABLE I." (figures arabic, tables Roman); `\abovecaptionskip` 10pt, `\belowcaptionskip` 2pt |
| tables | aipsamp.tex:339-355, 404-423, 437-458, 495-533; revtex4-2.cls:6773-6780, 6789-6791, 6901-6926 | `tbl.tabular` | `table`, `table*`, `tabular`, `\multicolumn`, class wrapper `ruledtabular` (class vocabulary): double top and bottom rules `\hline\hline`, columns stretched to `\hsize`; `\@floatboxreset` sets `\small` |
| decimal columns | aipsamp.tex:33, 413; revtex4-2.cls:6894-6900 | `tbl.siunitx` | `dcolumn` loaded in the preamble, column type `d` defined as `D{.}{.}{-1}` by the class |
| table notes | aipsamp.tex:348, 418, 449, 476-490, 505-532; revtex4-2.cls:6927-6943 | `fn.kernel` | `\footnote` in `tabular` gives lowercase-letter notes under the table; `\footnotemark[n]` and `\footnotetext[n]` for shared notes |
| footnotes | aipsamp.tex:42, 165; aip4-2.rtx:545-556, 713, 748-760 | `fn.kernel` | `\footnote`; numerical style puts footnotes into the bibliography (class option `footinbib`, true in the substyle) |
| cross-references | aipsamp.tex:82, 116-117, 337 | `xref.kernel` | `\label`, `\ref`, `\pageref` |
| citations | aipsamp.tex:125-139; revtex4-2.cls:7042, 7069; aip4-2.rtx:744-745 | `bib.natbib` | natbib `[sort&compress]` loaded by the class; `\cite`, `\onlinecite`; `\bibpunct{}{}{,}{s}{}{\textsuperscript{,}}` (superscript numbers) |
| bibliography | aipsamp.tex:605-606; aip4-2.rtx:574-583, 740-743; bibtex/bst/revtex/aipnum4-2.bst:39 | `bib.bibtex-bst` | `\bibliography{aipsamp}`, `\nocite{*}`; `.bst` = `aipnum4-2` (numerical) or `aipauth4-2` (`author-year`, aip4-2.rtx:719-721); heading "References" as starred section (aip4-2.rtx:575-583) |
| links | aipsamp.tex:88; revtex4-2.cls:6450 | `meta.url` | `\url{...}`; the `url` package is loaded by the class |
| verbatim | aipsamp.tex:75, 558-566, 577-579 | `code.verbatim` | `\verb+...+`, `verbatim` environment |
| inline markup | aipsamp.tex:79, 245 | `mark.kernel` | `\textit`, `\textbf`, `\emph`, `\texttt` |
| draft aid | doc/latex/revtex/sample/aip/aiptemplate.tex:16; revtex4-2.cls:6052-6056, 7527-7530 | `class.revtex4-2` | `\draft` is an obsolete alias of class option `draft` (rule on overfull lines) |
| page builder | revtex4-2.cls:3237-3250 | `class.revtex4-2` | ltxgrid output routine inlined in the class; no author-visible parameter |

Not used by the sample, so not mapped: lists, theorems, code listings, index (`theindex` is defined, aip4-2.rtx:597-613), `lineno` (commented out, aipsamp.tex:35-36).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| sample preamble and body macros | aipsamp.tex:22-38 | none exist | only `\documentclass` and three `\usepackage` lines; no `\newcommand`, `\def`, counter or environment |
| `revtex4-2.cls` (7681 lines: own output routine, replaced `\@startsection`, `\@makecaption`, tabular, footnote and float code) | tex/latex/revtex/revtex4-2.cls:3237-3250, 795, 6706, 924-1384 | not assessed: published official kit | `class.revtex4-2` with options; if the kit were zip-local this code would be irreducible BESPOKE/class |
| `aip4-2.rtx` (AIP substyle; `\def\section` etc., `\halign` for preprint numbers) | tex/latex/revtex/aip4-2.rtx:337-356, 377-433 | not assessed: published official kit | option `aip` (+ `jmp`/`cp`) of `class.revtex4-2` |
| `revsymb4-2.sty`, `ltx*.sty`, `aps10pt4-2.rtx` | tex/latex/revtex/revsymb4-2.sty:30; tex/latex/revtex/aps10pt4-2.rtx:29 | not assessed: published official kit | loaded by the class through the class options |
| `docs.sty` (guide helper) | doc/latex/revtex/auguide/docs.sty:1-129 | not part of the template | loaded only by the guides (doc/latex/revtex/aip/aipguide4-2.tex:18), never by aipsamp.tex or aiptemplate.tex |

## Content-opaque
- Figure artwork `fig_1` and `fig_2` (aipsamp.tex:374, 381), shipped as `.eps` only (sample/aip/fig_1.eps, fig_2.eps); under pdfTeX they must be converted or replaced (asset, not a template issue; `epstopdf` is not loaded by the sample).
- Table cell data (aipsamp.tex:347-353, 413-420, 444-455, 501-525), the equations and the `.bib` entries (doc/latex/revtex/sample/aip/aipsamp.bib).

## Lib changes
- New ways proposed: none. Considered and not proposed: a `cols.class-native` or `tbl.class-native` line for `widetext` and `ruledtabular`; they are recorded as vocabulary of `class.revtex4-2` instead (rubric: class-native vocabulary goes under "Class setting").
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
