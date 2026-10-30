yes

# 0110-invoice-class: invoice-class (US Commercial Invoice class)

- Unverified: read from the source, not compiled.
- Source: Source/0110-invoice-class/ (origin: https://mirrors.ctan.org/macros/latex/contrib/invoice-class.zip; licence: lppl1.3, stated at invoice-class.cls:4-10)
- Kind: invoice
- Lib: v2
- Engine: pdfLaTeX-compatible (the class loads only pdfTeX-safe packages, invoice-class.cls:20-28; the two sample invoices use no other package). Only the class manual doc/invoice-class.tex needs XeLaTeX, for `fontspec` (doc/invoice-class.tex:5-8); the fonts Linux Libertine O and Linux Biolinum O are not shipped.
- Look carried by: class (invoice-class.cls fixes every printed word, rule and column; the sample adds only strings, numbers and a CSV file name)
- Class origin: ctan (ctan.org/pkg/invoice-class: `/macros/latex/contrib/invoice-class`, v1.0, LPPL 1.3, in TeX Live; the zip is that CTAN package)
- Main file: doc/ducks.tex (other samples: doc/duck-invoice.tex, doc/invoice-class.tex). The manifest names doc/invoice-class.tex as main, but that file is the class manual set in plain `article` and never loads the class, so the invoice sample is doc/ducks.tex; the manual is mapped as well, below.
- Read: main yes (ducks.tex, duck-invoice.tex, invoice-class.tex, duck-invoice.cfg, both CSV files, README.md), zip-local classes and styles all (invoice-class.cls, 167 lines, whole)

## Verdict
Yes. The look is carried entirely by the published class `invoice-class` (CTAN and TeX Live), so it is one class way, `class.invoice-class`, with its own vocabulary (`\waybill`, `\InputFile`, `\printinvoice`...); the sample adds only strings, numbers and a CSV file name (doc/ducks.tex:2-13). The class source itself holds no hand-written typesetting algorithm: it is `\LoadClass{article}` plus published packages (`geometry`, `fancyhdr`, `multicol`, `tabularx`, `longtable`, `dcolumn`, `datatool`) and one fixed `\printinvoice` macro, and the CSV is read inside TeX by `datatool`, so no tool outside TeX is needed. The manual's own preamble (doc/invoice-class.tex:1-45) is all existing lib ways. The result is evidence for the class dimension, not for the component ways.

## Blockers
none

## Class setting
- Class: `class.invoice-class` options: none given by the sample (doc/ducks.tex:1); the class fixes `\LoadClass[11pt]{article}` (invoice-class.cls:20)
- Class-native vocabulary used: `\InputFile{csv}` (doc/ducks.tex:2); `\waybill` `\carrier` `\destination` `\toaddress` `\packages` (doc/ducks.tex:3-8); `\weight{lb}{oz}` (doc/ducks.tex:7); `\shippingcost` `\packingcost` `\insurancecost` (doc/ducks.tex:9-11); `\printinvoice` (doc/ducks.tex:13); `\ConfigPrefix` (doc/duck-invoice.tex:2); in a config file or the preamble `\fromaddress` `\shipper` `\location` (doc/duck-invoice.cfg:2-10); `\shippingdate` (default `\today`, invoice-class.cls:61). The CSV needs the column headings Description, Country, Quantity, UnitValue, Amount (doc/invoice-class.tex:110-114).

## Component map
Rows marked [emitted] are what an emitter writes for this zip. Rows marked [inside class] describe the published class's source (what `class.invoice-class` does); the emitter does not write them. Rows marked [manual] map doc/invoice-class.tex.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| [emitted] class | doc/ducks.tex:1 | `class.invoice-class` | no options; 11pt fixed inside the class (invoice-class.cls:20) |
| [emitted] invoice header fields | doc/ducks.tex:3-8 | `front.class-native` | `\waybill{8273205776}`, `\carrier{FedEx}`, `\destination{Brazil}`, `\toaddress{lines split by \\}`, `\weight{1}{1}`, `\packages{1}`: strings, printed by `\printinvoice` (invoice-class.cls:97-118) |
| [emitted] sender block | doc/duck-invoice.cfg:2-10; invoice-class.cls:70-80 | `front.class-native` | `\fromaddress{multi-line}`, `\shipper{Prof. van Duck}`, `\location{Somewhere, MI}`; read from `<prefix>invoice.cfg` (`\ConfigPrefix{duck-}`, doc/duck-invoice.tex:2), else the class default text (cls:72-80, which doc/ducks.tex gets: no `invoice.cfg` ships) |
| [emitted] item data source | doc/ducks.tex:2 | `class.invoice-class` | `\InputFile{ducks.csv}`; the rows are content (doc/duck-invoice.csv:1-31) |
| [emitted] cost lines | doc/ducks.tex:9-11 | `class.invoice-class` | `\shippingcost{40.00}`, `\packingcost{0.00}`, `\insurancecost{10.00}` (defaults 0, invoice-class.cls:58-60) |
| [emitted] invoice body | doc/ducks.tex:13 | `class.invoice-class` | one `\printinvoice` (invoice-class.cls:96-167) |
| [inside class] base class and size | invoice-class.cls:20 | `class.article`, `page.class-options` | `\LoadClass[11pt]{article}` |
| [inside class] page geometry | invoice-class.cls:21 | `page.geometry` | margin=1in |
| [inside class] default family | invoice-class.cls:30, 95 | `font.family-default`, `mark.kernel` | `\rmdefault` := `\sfdefault`; `\sffamily` for the body |
| [inside class] running head and foot | invoice-class.cls:28, 83-94 | `hf.fancyhdr` | `\pagestyle{fancy}`; lhead, rhead, lfoot, rfoot empty; chead `\Large\sffamily\bfseries Commercial Invoice`; cfoot `\sffamily\thepage`; headrulewidth 0.4pt, footrulewidth 0pt; headheight 18pt |
| [inside class] paragraph indent | invoice-class.cls:84 | `sp.lengths` | `\parindent=0pt` |
| [inside class] waybill box | invoice-class.cls:35-36, 97 | `box.fancybox`, `mark.kernel` | `\fbox{\textbf{Waybill Number:} ...}` |
| [inside class] From and To columns | invoice-class.cls:23, 98-109 | `cols.multicol`, `font.size-commands`, `mark.kernel` | `multicols{2}`, `\columnbreak`; labels `\Large\bfseries` |
| [inside class] shipment summary table | invoice-class.cls:24-25, 111-118 | `tbl.tabularx`, `tbl.tabular` | `tabularx{\linewidth}{\|*{4}{>{\centering}X\|}}`; `\extrarowheight`=9pt (array); headings `\textbf{\scriptsize ...}` (`font.size-commands`) |
| [inside class] item and totals table | invoice-class.cls:26-27, 33-34, 122-143 | `tbl.longtable`, `tbl.siunitx` | `longtable{\|p{2.1381in}\|>{\centering}p{1in}\|r\|d\|d\|}`, `\endhead`, `\endfoot`, `\extrarowheight`=3pt; column `d` = dcolumn `D{.}{.}{6.2}`; `\multicolumn{4}{\|r\|}` total rows |
| [inside class] CSV loop and sums | invoice-class.cls:22, 120-141 | `class.invoice-class` | `datatool` `\DTLloaddb`, `\DTLsumcolumn`, `\DTLforeach`, `\DTLdecimaltocurrency`, `\DTLaddall` (considered: datatool; no lib way, carried by the class) |
| [inside class] notes block | invoice-class.cls:144-153 | `sp.manual-space`, `font.size-commands`, `mark.kernel` | `\vskip 5ex`, `\Large\bfseries Notes:`, `\footnotesize` fixed legal text |
| [inside class] signature block | invoice-class.cls:155-166 | `sp.manual-space`, `tbl.tabular`, `font.size-commands` | `\bigskip`, `tabular{\|p{3in}\|p{1.75in}\|}`, `\extrarowheight`=18pt, `\hskip`, `\scriptsize` labels |
| [manual] class | doc/invoice-class.tex:1 | `class.article` | 11pt |
| [manual] title block | doc/invoice-class.tex:2-4, 10, 43, 48 | `front.maketitle`, `front.titling` | `\title \author \date \maketitle`; `\droptitle`=-1in; author email `\href` (meta.hyperref) |
| [manual] fonts | doc/invoice-class.tex:5-8 | `font.fontspec` | `\setmainfont` Linux Libertine O; `\setsansfont` Linux Biolinum O; `\setmonofont` Linux Libertine Mono O, Scale=MatchLowercase |
| [manual] page geometry | doc/invoice-class.tex:9 | `page.geometry` | lmargin=1in, rmargin=1in, tmargin=1.25in, bmargin=1in |
| [manual] headings | doc/invoice-class.tex:16, 50, 53, 77 | `head.titlesec`, `head.kernel` | `titlesec` option `sf`; `\section`, `\subsection` |
| [manual] page style | doc/invoice-class.tex:17-20, 49 | `hf.titleps`, `hf.pagestyle-kernel` | `\newpagestyle{main}{\setfoot{\itshape Invoice Class}{}{\thepage}}`; `\pagestyle{main}`; `\thispagestyle{empty}` |
| [manual] tables | doc/invoice-class.tex:11, 56-118 | `tbl.tabularx`, `tbl.booktabs`, `tbl.tabular` | `tabularx{.8\textwidth}`, column specs `>{\ttfamily\bs}l<{\{\}}X`; `\toprule \midrule \bottomrule`; `\multicolumn` |
| [manual] captions and labels | doc/invoice-class.tex:13, 74, 99, 117 | `cap.caption`, `xref.kernel` | `\captionof{table}{...}` with `\label` |
| [manual] list settings | doc/invoice-class.tex:12, 40-42 | `list.enumitem` | `\setitemize[1]` and `[2]` label={}; `\setdescription{font={\normalfont}}`; no list environment is used in the body |
| [manual] code | doc/invoice-class.tex:14, 24, 27-37, 120, 123, 126 | `code.listings`, `code.verbatim` | `\lstset{basicstyle=\ttfamily\small, commentstyle=\itshape\ttfamily\small, showspaces=false, showstringspaces=false, breaklines=true, breakautoindent=true, frame=single, captionpos=t, language=TeX}`; `\lstinputlisting` x3; fancyvrb `\DefineShortVerb{\|}` |
| [manual] links | doc/invoice-class.tex:14, 22 | `meta.url`, `meta.hyperref` | `url`; `hyperref` colorlinks=true |
| [manual] included PDF | doc/invoice-class.tex:15, 131 | `pg.include-pdf` | `\includepdf[]{ducks.pdf}` (the shipped PDF of doc/ducks.tex) |
| [manual] page break | doc/invoice-class.tex:121 | `pg.break` | `\clearpage` |
| [manual] loaded, unused | doc/invoice-class.tex:11 | `cols.multicol` | `multicol` loaded, no `multicols` in the body |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\gdef` setters `\waybill` ... `\location` | invoice-class.cls:40-54 | yes | the published class's vocabulary; the emitter writes the commands with string arguments (`class.invoice-class`, `front.class-native`) |
| `\printinvoice` fixed layout | invoice-class.cls:96-167 | yes | one call into the class way; internally a fixed stack of `box.fancybox`, `cols.multicol`, `tbl.tabularx`, `tbl.longtable`, `tbl.tabular`, `sp.manual-space` (rows above); no counters, no output routine, no `\@startsection`-style redefinition |
| config loader | invoice-class.cls:69-81 | yes | `\AtBeginDocument` + kernel `\InputIfFileExists` with a default text; the emitter may write `\fromaddress`, `\shipper`, `\location` straight in the preamble (allowed by doc/invoice-class.tex:86) or ship the `.cfg` |
| `\invc@BL` signature rule | invoice-class.cls:31 | yes | defined and never called (the only grep hit is the definition); `sp.rule` if it were |
| `\invc@NL`, `\invc@mc`, `\newcolumntype{d}` | invoice-class.cls:32-34 | yes | aliases of `\tabularnewline`, `\multicolumn{1}{c\|}`, dcolumn `D{.}{.}{6.2}` |
| `\invc@waybill` | invoice-class.cls:35-36 | yes | `\fbox` of bold label plus value |
| `\bs`, `\pkg` aliases | doc/invoice-class.tex:25, 39 | yes | `\textbackslash`; `\texttt{#1}\xspace` (considered: xspace, a content-spacing helper, not a template look) |
| `\lstset` block | doc/invoice-class.tex:27-37 | yes | `code.listings` options; line 34 `frame=single` has no trailing comma before `captionpos=t` (line 35), a source typo, not a template construct |

## Content-opaque
- item data: doc/ducks.csv (201 bytes, UTF-8 BOM, CR line ends) and doc/duck-invoice.csv:1-31 (CSV read by `datatool` at invoice-class.cls:120)
- the sample invoice text printed by `\printinvoice` (names, addresses, amounts)
- compiled doc/ducks.pdf included at doc/invoice-class.tex:131; source listings at doc/invoice-class.tex:120, 123, 126

## Lib changes
- New ways proposed: none. Considered and not proposed: `datatool` (CSV import and loop; the class way carries it and the emitter never writes it), a `tbl.class-native` parallel to `fig.class-native` (the class's table is recorded under `class.invoice-class`), `xspace`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
