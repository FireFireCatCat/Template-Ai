yes

# 0283-bankstatement: bankstatement (a LaTeX class for bank statements from csv data)

- Unverified: read from the source, not compiled.
- Source: Source/0283-bankstatement/ (origin: https://mirrors.ctan.org/macros/latex/contrib/bankstatement.zip; licence: lppl1.3)
- Kind: misc (a bank account statement; the nearest listed kind is invoice, but it is a posting list, not a bill)
- Lib: v3
- Engine: pdfLaTeX-compatible
- Look carried by: class (the published CTAN class `bankstatement`; the sample adds class options, six preamble lines and one `\bankstatement` call)
- Class origin: ctan
- Main file: bankstatement.dtx, docstrip chunk `examplefile` lines 265-284 (docstrip writes it as bankstatement-example.tex; the same text is the lstlisting at bankstatement.dtx:689-708). The zip holds no .tex file. Other samples: the `driver` chunk bankstatement.dtx:388-572, the package manual under `ltxdoc`, judged outside the template scope (see Verdict).
- Read: main yes, zip-local classes and styles none present as files (the class code, bankstatement.dtx:719-903, and the six language and format `.def` chunks, bankstatement.dtx:53-213, live in the .dtx and were read in full; the PDFs were not read)

## Verdict
Yes, with the look carried by the class. The zip is the CTAN source of the class `bankstatement` (ctan.org/pkg/bankstatement, `/macros/latex/contrib/bankstatement`, also in TeX Live), so it is a published class and the way `class.bankstatement`; the sample selects its built-in `format=csv-camt` and `language=german` by option values (bankstatement.dtx:266-272) and neither edits nor extends the class, and everything else in the sample's preamble and body is a lib way or a class-native call. The class's own internals (a `datatool` database loop and `\parbox` row layout, bankstatement.dtx:136-159, 847-894) are the published class's code, not zip-local bespoke code. The package manual's driver (bankstatement.dtx:388-572: `tikz` title-page and running-head overlays, redefined `\tableofcontents` and `theindex`) is the documentation build of the package, not the sample and not the template; it is excluded here, and if a reader counts it, it adds ART/preamble and BESPOKE/preamble and the answer becomes `no`. This is evidence about the class dimension, not about the component ways.

## Blockers
none (in scope). Out of scope but recorded: `ART/preamble` and `BESPOKE/preamble` in the manual driver only (bankstatement.dtx:437-472, 474-489, 518-524, 538-565).

## Class setting
- Class: `class.bankstatement` options: `a4paper`, `10pt` (not class keys, forwarded to article by `\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{article}}`, bankstatement.dtx:771), and class keys `bic`, `iban`, `holder`, `language`, `logo`, `format`, `logowidth`, `negativecolor` (bankstatement.dtx:266-271). Keys it also defines and the sample leaves at default: `title` (set locally instead), `referencewidth=11cm`, `sort=PostingDate`, `openingbalance`, `closingbalance`, `left` `right` `top` `bottom` all `2cm` (bankstatement.dtx:751-767). Built on `\LoadClass{article}` (bankstatement.dtx:776).
- Class-native vocabulary used: `\bankstatement[title=,openingbalance=,closingbalance=]{<csv file>}` (bankstatement.dtx:280-282, defined 847-894); global options `format` and `language`, which load `csv-camt.def` and `stmgerman.def` (bankstatement.dtx:815-816; contents 127-171 and 64-74).
- Engine evidence: `% !TEX program = pdfLaTeX` (bankstatement.dtx:2), makefile `example` target uses `pdflatex` (makefile:24-26); the sample loads `inputenc` utf8, `fontenc` T1, `bera` (bankstatement.dtx:274-277).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | bankstatement.dtx:266-272 | `class.bankstatement` | bic=BYLADEM1ERD, iban=DE70753574230240408336, holder={Josef Kleber}, language=german, logo=stmlogo, format=csv-camt, logowidth=4cm, negativecolor=red |
| base class | bankstatement.dtx:776 | `class.article` | loaded by the class with `\LoadClass{article}`; no article option set by the class itself |
| paper and size | bankstatement.dtx:266, 771 | `page.class-options` | a4paper, 10pt (forwarded to article) |
| page geometry | bankstatement.dtx:764-767, 781-782 | `page.geometry` | left=2cm, right=2cm, top=2cm, bottom=2cm (class defaults from its own keys; the sample sets none) |
| running head and foot | bankstatement.dtx:776 (no `\pagestyle` anywhere in the class chunk 719-903) | `hf.pagestyle-kernel` | inherited article default `plain`; not set by the zip |
| encodings | bankstatement.dtx:274-276 | `font.fontenc-t1` | inputenc=utf8, fontenc=T1, textcomp |
| text face | bankstatement.dtx:277 | `font.helvet` | package=bera (Bera family; the package is the parameter, as for `font.helvet` folded into this way) |
| default family | bankstatement.dtx:278 | `font.family-default` | `\renewcommand\familydefault{\sfdefault}` |
| language names and hyphenation | bankstatement.dtx:273 | `lang.babel` | german |
| class language file | bankstatement.dtx:269, 816, 64-74 | `class.bankstatement` | `language=german` loads stmgerman.def: Kontoinhaber, BIC, IBAN, Datum, Verwendungszweck, Betrag (EUR), Anfangssaldo, Endsaldo, and `\sisetup{output-decimal-marker={,}}` (class-native option, not a lib component) |
| class format file | bankstatement.dtx:270, 815, 127-171 | `class.bankstatement` | `format=csv-camt` loads csv-camt.def: key order (131-133), row layout (136-159), `\DTLsetseparator{;}` (161), header row present (163) |
| statement header (title, logo, holder, BIC, IBAN) | bankstatement.dtx:280, 751-758, 829-840 | `front.class-native` | title={Kontoauszug 12/2014} local key; logo=stmlogo, logowidth=4cm, holder, bic, iban global keys; labels come from the language file |
| header layout, outer grid | bankstatement.dtx:832-838 | `tbl.tabularx` | `tabularx{\textwidth}{XXr}`, title row `\multicolumn{3}{l}` |
| header layout, label and value pairs | bankstatement.dtx:835-837 | `tbl.tabular` | three nested `tabular{l}`, label in `\textbf` over value |
| header logo | bankstatement.dtx:820-825 | `fig.graphicx` | `\includegraphics[width=\STM@JK@logowidth]{stmlogo}`; image shipped as stmlogo.jpg (142x95) |
| header title size | bankstatement.dtx:833 | `font.size-commands` | `\Huge` |
| header labels bold | bankstatement.dtx:835-837 | `mark.kernel` | `\textbf` |
| header spacing | bankstatement.dtx:808, 824, 833, 839 | `sp.manual-space` | `\hspace{.22em}`, `\hfill`, `\vspace{0.5cm}` (headingsep default) |
| posting table | bankstatement.dtx:874-880 | `tbl.longtable` | `longtable{llr}`, heading row repeated through `\endhead` |
| table rules | bankstatement.dtx:875, 879, 886; bankstatement.dtx:154-155 | `tbl.booktabs` | `\toprule` twice around the heading, `\midrule` before the balance rows, `\bottomrule` at the end |
| column headings | bankstatement.dtx:68-70, 876-878 | `mark.kernel` | `\bfseries` on the three headings |
| posting cells | bankstatement.dtx:141-149 | `box.minipage` | `\parbox[t]{\widthof{ DD.MM.YYYY }}` for dates, `\parbox[t]{\STM@JK@referencewidth}` (11cm, line 759) for type, BIC/IBAN, recipient, CRED, MREF, EREF, reference |
| reference cell alignment | bankstatement.dtx:142 | `sp.ragged` | `\raggedright` |
| number format | bankstatement.dtx:106, 170, 73 | `mark.siunitx` | `\num{}`; `\sisetup{detect-all,round-integer-to-decimal,round-mode=places,round-precision=2}`, `output-decimal-marker={,}` |
| negative amount colour | bankstatement.dtx:106, 150, 760, 885 | `color.xcolor` | `\textcolor{\STM@JK@negativecolor}` when the amount starts with `-`; negativecolor=red (sample line 271) |
| opening and closing balance rows | bankstatement.dtx:281-282, 881-886, 151-157 | `class.bankstatement` | openingbalance={-12,34}, closingbalance={82,13}: extra labelled rows with `\midrule`; `none` (default, line 762-763) prints nothing |
| statement body command and csv loading | bankstatement.dtx:282, 847-868 | `class.bankstatement` | `\bankstatement[...]{201412.csv}`: loads the file with datatool (`\DTLloadrawdb`), sorts by `sort=PostingDate`, one longtable per call; the csv is data (see Content-opaque) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class internals: key macro `\STM@JK@define@key`, counter `STM@JK@count`, `\bankstatement`, `\STM@JK@header`, `\STM@JK@DTLforeach` hooks, helper packages `xkeyval` `xkvltxp` `datatool` `calc` `ifthen` | bankstatement.dtx:729-747, 788-811, 829-894, 136-159 | not zip-local: published CTAN class, the class is the way | `\documentclass[<options>]{bankstatement}` plus `\bankstatement[<options>]{<csv>}`; the sample sets option values only |
| `.def` extension point (copy `stmenglish.def` or `csv-mt940.def` to add a language or bank format) | bankstatement.dtx:670, 682-683 | not used by the sample | the sample takes the shipped `csv-camt` and `german` values |
| manual driver macros: tikz `\maketitle`, `\@tikzhead`, `\tableofcontents`, `theindex`, `\optitem`, `\cmd` | bankstatement.dtx:437-472, 474-489, 514-565 | outside scope (documentation build, not the sample or template); irreducible if counted | none written; see Verdict |

## Content-opaque
- csv posting data `201412.csv`, a docstrip chunk (bankstatement.dtx:41-52), read at run time by `\bankstatement` (bankstatement.dtx:282); the ways cannot hold it, it is data (cell contents).
- Assets not present as files: `bankstatement.cls`, `stmgerman.def`, `csv-camt.def` and the sample file are written by docstrip from the .dtx (`\generate` blocks, bankstatement.dtx:340-364; makefile:21-22 runs `pdftex bankstatement.dtx`). docstrip is TeX, so this is not EXTERNAL, and the class ships in TeX Live.

## Lib changes
- New ways proposed: none. Considered and not proposed: `datatool` (csv database loop; used only inside the class, the sample never calls it, so it stays inside `class.bankstatement`), `calc`, `ifthen`, `xkeyval` (logic helpers of the class, no template look).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
