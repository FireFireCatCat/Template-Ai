yes

# 0710-ifacmtg: ifacmtg (Elsevier Science preprint style for IFAC meetings)

- Unverified: read from the source, not compiled.
- Source: Source/0710-ifacmtg/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ifacmtg.zip; licence: other-nonfree, CTAN lists "License that prevents distribution", Elsevier Science copyright, README.1st:1, ifacmtg.cls:13-16)
- Kind: conference
- Lib: v5
- Engine: pdfLaTeX-compatible (no fontspec, no Lua; nothing in the class or sample needs XeLaTeX or LuaLaTeX)
- Look carried by: class (the whole look is the published class `ifacmtg`; the sample adds content, one `harvard` load and a `.bst` name)
- Class origin: ctan (ctan.org/pkg/ifacmtg: "Elsevier Science preprint style for IFAC meetings", maintainer Simon Pepping; it is also Elsevier's own kit for IFAC authors, README.1st:23-24)
- Main file: ifacsam.tex (other samples: ifacsam-letter.tex, identical except line 1, `\documentclass[letterpaper]{ifacmtg}`; the manifest hint names this one; data file ifacsam.bib; instraut.pdf/.dvi/.ps are the instructions for authors, not analysed)
- Read: main yes, zip-local classes and styles partly (ifacmtg.cls read in full, lines 1-1676; ifac.bst, 1320 lines, read only in the header 1-80, the output.bibitem part 690-738, begin.bib/end.bib 1290-1320 and a Grep outline of its FUNCTIONs; its per-entry-type formatting bodies were not read)

## Verdict
yes. The class `ifacmtg` is released on CTAN and is Elsevier's official kit for IFAC meeting papers, so under W1 it is one published class way, `class.ifacmtg`. The sample defines no macro, counter or environment of its own (Grep of ifacsam.tex finds no `\newcommand`, `\def`, `\let`, `\newenvironment`, `\newcounter`); its only preamble lines are `\bibliographystyle{ifac}` and `\usepackage[dcucite]{harvard}`, and everything else is class-native Elsevier markup, kernel floats and content. Per the pilot ruling this is evidence about the class dimension, not about the component ways. The yes depends on ruling the class published: it is a hand-written, kernel-redefining class (see Bespoke code), and if it were judged zip-local it would be `BESPOKE/class`, irreducible.

## Blockers
none

## Class setting
- Class: `class.ifacmtg` options: none in ifacsam.tex (default `a4paper` through `\ExecuteOptions{a4paper}`, ifacmtg.cls:35); the letter variant passes `letterpaper` (ifacsam-letter.tex:1; ifacmtg.cls:32-34). Version 3.2ModD of 2002/04/18 (ifacmtg.cls:19-20), docstrip output of pergamon.dtx and esl.dtx (ifacmtg.cls:7, 43). Two columns are forced inside the class (`\@twocolumntrue\@TwoColumntrue`, ifacmtg.cls:1617), not by an option.
- Class-native vocabulary used by the sample: `\runauthor` (ifacsam.tex:5), `frontmatter` environment (ifacsam.tex:6,30), `\title` (7), `\author[ref]{}` (8-10), `\thanksref` (8), `\address[ref]{}` (11-13), `\thanks[ref]{}` (14), `abstract` environment (15-26), `keyword` environment (27-29), `\section` `\subsection`, `table`, `figure`, `figure*`.
- Class-native vocabulary defined but not used by the sample: `\subtitle`, `\collab`, `\received` `\revised` `\accepted` `\communicated` `\dedicated`, `\articletype`, `\volume` `\issue` `\pubyear` `\firstpage` `\lastpage`, `\ack` and `\appendix` (ifacmtg.cls:302-327), `pf` proof environment and theorem-like environments `thm` `cor` `lem` `defn` `rem` ... via `theorem` (ifacmtg.cls:548, 586-629), `algorithm` float (617-626), `\tableofcontents` `\listoffigures` (634-655), `\conttablecaption`, `\MSC` `\PACS` inside `keyword` (1195-1196).
- Packages the class loads: `theorem` and `newlfont` (ifacmtg.cls:548-549), both LaTeX base/tools; `natbib` with `plainnat` only when `harvard` is not loaded (ifacmtg.cls:1633-1637), so not loaded for this sample; an optional `ifacmtg.cfg` is read if present (ifacmtg.cls:1490), none in the zip.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ifacsam.tex:1 | `class.ifacmtg` | no options; letter variant `letterpaper` (ifacsam-letter.tex:1) |
| paper size | ifacmtg.cls:29-36; ifacsam-letter.tex:1 | `page.class-options` | `a4paper` default, `letterpaper` option |
| page geometry | ifacmtg.cls:1550-1553, 1616 | `class.ifacmtg` | fixed in the class, no emitter output: textwidth 159mm, textheight 252mm, voffset -10.5mm, topskip reduced by 1cm |
| columns | ifacmtg.cls:1617, 1558 | `class.ifacmtg` | two columns forced by the class, columnsep 0.3in, no option passed |
| header/footer | ifacmtg.cls:1620-1626, 1627-1631, 1641-1653; ifacmtg.cls:968 | `hf.class-native` | page style `ifacmtg` has empty heads and feet (no page number printed); first page uses `\thispagestyle{copyright}`, whose head is a blank 5-line box; `\runauthor` (ifacsam.tex:5) is stored but never printed under these styles |
| spacing and shape | ifacmtg.cls:1588-1589, 1494-1501, 92 | `class.ifacmtg` | parindent 0em, parskip 6pt, widowpenalty and clubpenalty 10000, `\frenchspacing`; fixed in the class |
| fonts and sizes | ifacmtg.cls:129-149, 1569 | `class.ifacmtg` | Computer Modern default, `\normalsize` 10/12 and a redefined size ladder, title `\@Point{10}{12}\bfseries`; no font package; fixed in the class |
| title block | ifacsam.tex:6-13; ifacmtg.cls:1039-1066, 1654-1658 | `front.class-native` | `frontmatter` environment, `\title` (bold 10/12, set in capitals by `\MakeUppercase`, 1in above), `\author[ref]` (bold upright, superscript marks), `\address[ref]` (italic, 24pt above, ifacmtg.cls:1570, 1613-1615), front matter width 125mm (ifacmtg.cls:1555-1556) |
| author notes | ifacsam.tex:8,14; ifacmtg.cls:915-928, 1600-1601 | `front.thanks` | `\thanks[label]{text}` with `\thanksref{label}`; marks are `*`, `**`, ... from `\@fnsymbol` |
| abstract | ifacsam.tex:15-26; ifacmtg.cls:1180-1190, 1555, 1565 | `abs.class-native` | `abstract` environment in a 125mm minipage, `\normalsize`, run-in label "Abstract: " |
| keywords | ifacsam.tex:27-29; ifacmtg.cls:1191-1205, 1564 | `abs.keywords` | `keyword` environment (class command), heading "Keywords: ", `\sep` separator, not justified |
| headings | ifacsam.tex:32,105,150,161,166; ifacmtg.cls:1580-1587, 1659-1662, 1599 | `head.class-native` | `\section`: centred, capitals, above 18pt plus `\@bls` minus 4pt, below 6pt plus 1pt minus 2pt, number "1." then half an em (ifacmtg.cls:233); `\subsection`: italic, number "1.1" without a dot; headings never hyphenated (ifacmtg.cls:1590-1592) |
| section numbering | ifacmtg.cls:541-545, 1493 | `head.class-native` | arabic, `secnumdepth` 5; set by the class, not by the sample |
| lists | ifacsam.tex:33-38; ifacmtg.cls:369, 384-392, 346-349 | `list.kernel` | `itemize` redefined by the class: bullet `$\bullet$`, zero item and top separation |
| footnotes | ifacsam.tex:175; ifacmtg.cls:930-931, 1603-1605 | `fn.kernel` | `\footnote`; rule 2in wide, 12pt kern below |
| display and inline maths | ifacsam.tex:108-112, 163-164; ifacmtg.cls:446-454, 1619 | `math.kernel` | `equation` redefined by the class (hbox centred, number at the right), mathindent 0em; the formula is content |
| table float | ifacsam.tex:65-82; ifacmtg.cls:822-829, 817 | `tbl.tabular` | `table[htbp]` with `tabular*{\hsize}{lllll}` and `\hline`; float body `\small`; `\tabcolsep` 6pt, rule 0.4pt (ifacmtg.cls:484-485); default placement `tbp` |
| figure floats | ifacsam.tex:83-91, 152-159; ifacmtg.cls:807-814, 803 | `fig.graphicx` | `figure` and `figure*` (two-column wide) floats, default placement `tbp`; the body is a placeholder box, see Content-opaque |
| captions | ifacsam.tex:66-68, 88-89, 157; ifacmtg.cls:1505-1520, 1595-1598, 86-87 | `cap.kernel` | table caption above the table, centred or in a 0.8 line-width minipage, names "Table" and "Fig."; figure caption below, hanging indent 2em |
| cross-references | ifacsam.tex:93,106,151 | `xref.kernel` | `\label` `\ref` |
| bibliography style | ifacsam.tex:2,189; ifac.bst:1-30, 695-709, 1304-1315 | `bib.bibtex-bst` | style `ifac` (Silvano Balemi, based on a modified agsm.bst, shipped in the CTAN package; it writes `\harvarditem[..]{..}{year}{key}` entries); data file ifacsam.bib |
| citations | ifacsam.tex:3,39 | `bib.apacite` | `\usepackage[dcucite]{harvard}`, `\cite` author-year citations (the class would load `natbib` instead if harvard were absent, ifacmtg.cls:1633-1637) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| macros, counters, environments in the sample | ifacsam.tex (none found by Grep) | n/a | nothing to reduce |
| `ifacmtg.cls` internals (not counted: the class is published on CTAN, so it is the way `class.ifacmtg`) | ifacmtg.cls:248-300 (`\@sect`, `\@ssect`, `\@startsection`), 446-479 (`equation`, `eqnarray` as `\halign`), 690-706 (`\@citex`), 938-1024 (front-matter boxes with `\vsplit`), 1505-1537 and 1595-1598 (`\@make...caption`) | not assessed; irreducible if the class were zip-local | the emitter writes `\documentclass{ifacmtg}` and its native commands instead of copying this code |
| `ifac.bst` | ifac.bst:1-1320 | yes, a BibTeX style is the parameter of `bib.bibtex-bst` | `\bibliographystyle{ifac}` with `\bibliography{...}` and `harvard` |

## Content-opaque
- Placeholder figure boxes (`\hrule`, `\vbox to 8cm{\vfill \hbox to \hsize{\hfill FIGURE\hfill}\vfill}`, `\hrule`) at ifacsam.tex:84-87 and 154-156; an emitter replaces each with `\includegraphics`, the box is not template.
- The equation (ifacsam.tex:108-112) and inline formula (163-164), table cell text (72-79), and the Latin body text and bibliography entries (ifacsam.bib) are content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
