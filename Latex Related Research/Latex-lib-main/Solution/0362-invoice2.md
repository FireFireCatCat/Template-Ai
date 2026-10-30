yes

# 0362-invoice2: invoice2 (intelligent invoices with LaTeX3: package source and manual)

- Unverified: read from the source, not compiled.
- Source: Source/0362-invoice2/ (origin: https://mirrors.ctan.org/macros/latex/contrib/invoice2.zip; licence: GPL 3 or later, README.md:23-26, invoice2.dtx:5-9, manifest `gpl3+`)
- Kind: invoice
- Lib: v3
- Engine: pdfLaTeX-compatible (the package loads `booktabs`, `expl3`, `l3keys2e`, `longtable`, `siunitx`, `translations`, `xcolor`, `xparse`, invoice2.dtx:381-389; no `fontspec`, no Lua; the manual driver uses `inputenc` and `fontenc` T1, :23-24; not compiled)
- Look carried by: mixed (the invoice table face is printed by the published package `invoice2`, shipped here only as DocStrip source `invoice2.dtx` + `invoice2.ins`, code at invoice2.dtx:374-1171; the manual is typeset by the `l3doc` class; the driver preamble adds only documentation packages, :22-35)
- Class origin: tex-distribution-unbundled (`l3doc`, invoice2.dtx:22, is not in the zip and its source was not read; ctan.org/pkg/l3doc returned 404, so only its use by the CTAN package's own driver and the LaTeX3 tooling shipped with TeX Live establish it as published; the package itself is on CTAN: https://ctan.org/pkg/invoice2 read once, v2018-01-15, in TeX Live and MiKTeX)
- Main file: invoice2.dtx (no `.tex` sample exists; the `%<*driver>` block at :20-41 is an `l3doc` documentation build, not a template; the six invoice examples at :204-311 stand in as the sample) (other: invoice2.ins, README.md, LICENSE-gpl-3.0.md, invoice2.pdf)
- Read: main yes (all 1226 lines of invoice2.dtx), zip-local classes and styles all (no `.cls`/`.sty`/`.def` ships; the package code is the unprefixed lines :374-1171 plus the dictionary parts :1180-1220, read in full; invoice2.ins and README.md read; `LICENSE-gpl-3.0.md` not read, it is the licence text; `invoice2.pdf` is a shipped output and was not read: no PDF renderer in this session; the sources of `l3doc`, `translations`, `siunitx`, `longtable`, `booktabs` were not read)

## Verdict
The zip is the DocStrip source of `invoice2`, a package published on CTAN and in TeX Live, plus its `l3doc` manual; it holds no `.tex` document, so the manual driver and its six invoice examples stand in as the sample. The invoice face is one new way, `inv.invoice2`, which passes W1 to W4 (published with documentation, chosen by option values, one `\usepackage` line plus one `invoice` environment around item rows), and every table part it prints is already a lib way (`tbl.longtable`, `tbl.booktabs`, `tbl.colortbl`, `mark.siunitx`). The manual's own components all map to lib ways, the driver defines no macro of its own, nothing is drawn, and nothing needs a tool outside TeX (DocStrip is TeX).
Sensitivity: the `yes` rests on the W1 ruling that a CTAN package inside the zip is published. If `invoice2.dtx` were judged zip-local, the expl3 logic that chooses the columns and sums the totals (invoice2.dtx:666-674, 844-883, 1126-1146) would be irreducible hand-rolled state and the answer would flip to `no`. The manual's class `l3doc` affects only the manual, not the invoice template.

## Blockers
none

Recorded, not counted:
- Generated files: the package needs `invoice2.sty` and three `.trsl` dictionaries produced by `invoice2.ins` (invoice2.ins:47-51); a TeX Live install already has them, so the emitter only loads the package.
- Not verified: the live example at invoice2.dtx:228-232 has its body lines indented before `%`; whether `l3doc` still treats them as documentation lines was not checked (the verbatim copy at :221-227 is unaffected).

## Class setting
- Class: `class.l3doc` options: `full`, `lm-default` (invoice2.dtx:22; meanings not read, the class source is not in the zip). The package itself is not a class and loads no class.
- Class-native vocabulary used (the manual): environments `documentation` (:55) and `implementation` (:369), `function` with `syntax` (:145-151, 167-179, 181-195), `macro` (:642 and after), `variable` (:425 and after), `macrocode` (:373 and after); commands `\pkg` (:43), `\cmd` (:78), `\cs` (:147), `\marg` (:147), `\oarg` (:169); the module declaration `%<@@=invoicetwo>` (:375) and DocStrip guards `%<*driver>`, `%<*package>`, `%<*dictEnglish>` (:21, 374, 1180).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (manual) | invoice2.dtx:22 | `class.l3doc` | `full`, `lm-default` |
| DocStrip manual machinery | invoice2.dtx:38, 316, 332, 344, 1224-1225 | `dtx.doc` | `\DocInput{\jobname.dtx}`, `\changes{1.2}{2018/01/15}{...}` (and 1.1, 1.0), `\PrintChanges`, `\PrintIndex`; whether `l3doc` loads `doc` itself was not read |
| encoding (manual) | invoice2.dtx:23-24 | `font.fontenc-t1` | `fontenc` T1, `inputenc` utf8 |
| math packages (manual) | invoice2.dtx:26-27, 860-870 | `math.amsmath`, `math.amssymb` | `amsmath` (`align*` at 860 and 866), `amsfonts`; no options |
| display maths (manual) | invoice2.dtx:925-927, 947-949 | `math.kernel` | `\[ \tilde{p} = ... \]` |
| language (manual) | invoice2.dtx:28 | `lang.babel` | `USenglish`; it also selects the dictionary the package prints (see localisation row) |
| quotes (manual) | invoice2.dtx:29, 135 | `lang.csquotes` | `csquotes`, `\enquote{...}` |
| date (manual) | invoice2.dtx:30, 51 | `front.datetime` | `datetime2` options `useregional,showdow`; `\DTMDate{2018-01-15}` |
| list options (manual) | invoice2.dtx:31, 317, 333, 345, 416 | `list.enumitem` | `itemize[nosep]`, `enumerate[noitemsep, label=\alph*)]` |
| description lists (manual) | invoice2.dtx:82-115, 130-143 | `list.kernel` | `description` with `\item[key]` |
| euro symbol | invoice2.dtx:32, 92, 201-206 | `font.icons` | `eurosym` `\euro{}`; passed as `currency-symbol={\euro{}}` |
| links (manual) | invoice2.dtx:35, 47, 49 | `meta.hyperref` | `\hypersetup{hidelinks}`, `\href`, `\url`; `hyperref` is not loaded in the driver, so `l3doc` is expected to load it (not read) |
| title block (manual) | invoice2.dtx:43-53 | `front.maketitle` | `\title{..\\..}`, `\author{..\texttt{\href..}\\[.25\baselineskip]\url{..}}`, `\date{Version 1.2\\[.25\baselineskip]\DTMDate{..}}`, `\maketitle` |
| title spacing (manual) | invoice2.dtx:48, 51 | `sp.manual-space` | `\\[.25\baselineskip]` |
| inline marks (manual) | invoice2.dtx:47, 156-159 | `mark.kernel` | `\emph`, `\texttt` |
| contents (manual) | invoice2.dtx:69 | `toc.kernel` | `\tableofcontents` |
| headings (manual) | invoice2.dtx:71, 73, 315, 371 | `head.kernel` | `\part`, `\section`, `\subsection`; no renewal |
| footnotes (manual) | invoice2.dtx:59, 66, 120 | `fn.kernel` | `\footnote{\url{..}}` |
| cross-reference (manual) | invoice2.dtx:395, 1175 | `xref.kernel` | `\ref{sec:dictionaries}`, `\label` |
| example source blocks (manual) | invoice2.dtx:204-211, 221-227, 237-245, 257-264, 276-284, 297-305 | `code.verbatim` | six `verbatim` blocks |
| invoice package load | invoice2.dtx:33; 381-391 | `inv.invoice2` | `\usepackage{invoice2}`; options are the keys below, read by `\ProcessKeysOptions{invoice2}` (:637) |
| configuration keys | invoice2.dtx:601-629; doc 83-114 | `inv.invoice2` | `vat` (float, 0), `included-vat` (bool, false), `currency-symbol` (tokens, `\$`), `currency-fraction-digits` (int, 2), `currency-in-header` (bool, false), `colorize` (bool, false), `odd-color` white, `even-color` lightgray, `title-color` white, `total-color` white |
| change keys in the body | invoice2.dtx:646-648; 246, 252, 285, 291 | `inv.invoice2` | `\invoiceoptions{vat=.09}` and `\invoiceoptions{vat=.0}` between invoices |
| invoice environment | invoice2.dtx:1154-1159, 1126-1133, 1142-1146 | `inv.invoice2` | `\begin{invoice}[keys] ... \end{invoice}`; rows are collected, one table is printed at `\end`; nesting is an error (1127-1129) |
| item rows | invoice2.dtx:1008-1017, 987-998 | `inv.invoice2` | `\invoiceitem[VAT]{amount}{name}{unit price}`, `\invoicesingleitem[VAT]{name}{unit price}`; unit price without symbol (:193-194) |
| conditional columns | invoice2.dtx:666-674, 699-757, 844-851 | `inv.invoice2` | amount shown when any amount is not 1, VAT when any VAT is not 0, unit price when either holds; item and price always |
| totals rows | invoice2.dtx:1028-1115 | `inv.invoice2` | net, VAT, gross rows, or gross only when every VAT is 0; computed with `\fp_add:Nn` (:873-883) |
| table body | invoice2.dtx:384, 666-674, 1114 | `tbl.longtable` | `longtable`, column spec `c`? `l` `c`? `r` `r`? (amount, item, VAT, price, unit price) |
| rules | invoice2.dtx:381, 768, 775, 1109, 1113 | `tbl.booktabs` | `\toprule`, `\midrule` (after header and before totals), `\bottomrule` |
| column titles | invoice2.dtx:682-690 | `tbl.tabular`, `font.size-commands`, `mark.kernel` | `\multicolumn{1}{c}{\begin{scriptsize}\textbf{title}\end{scriptsize}}` |
| total labels | invoice2.dtx:1044-1053 | `tbl.tabular`, `mark.kernel` | `\multicolumn{n}{r}{\textbf{label}}` over all columns but the last |
| row and cell colours | invoice2.dtx:967-977, 685, 1047, 1051; 387-388 | `tbl.colortbl`, `color.xcolor` | `\rowcolor` alternating odd/even from row 1, `\cellcolor` on title and total cells; `\PassOptionsToPackage{table}{xcolor}`; colour names or `lightgray!50` (:300) |
| number and currency format | invoice2.dtx:787-794, 803-818, 827-835; 385 | `mark.siunitx` | `\num[round-integer-to-decimal, group-minimum-digits=4, group-separator, output-decimal-marker, round-precision, round-mode=places]`; symbol after the amount after `\,` or in the header as ` (symbol)` |
| localisation of labels | invoice2.dtx:386, 398-410, 1180-1220 | `inv.invoice2` | keys `invoice2-amount` `-item` `-vat` `-unit-price` `-price` `-net-total` `-vat-total` `-gross-total` `-thousands-sep` `-decimal-point`; English, German, Swiss German dictionaries; the package `translations` stays inside the way (considered, see Lib changes) |

Not in the zip: page geometry, headers and footers, fonts, theorems, floats with captions, bibliography and index of the user's own (the manual's `\PrintIndex` is `dtx.doc`). The manual's page layout is whatever `l3doc` sets (not read).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `invoice2.sty` generated from the `package` guard | invoice2.dtx:374-1171; invoice2.ins:47 | not bespoke | published on CTAN and in TeX Live (ctan.org/pkg/invoice2); one way `inv.invoice2` (sensitivity in Verdict) |
| expl3 state: trackers, running fp totals, row counter | invoice2.dtx:425-592 | internal to the published package | emitter writes `\invoiceitem` rows; if the package were zip-local this state would be irreducible (`BESPOKE/package` in that reading) |
| dictionaries | invoice2.dtx:1180-1220; invoice2.ins:48-51 | internal to the published package | string tables for `translations`; no layout effect |
| `\invoiceoptions`, `\invoiceitem`, `\invoicesingleitem`, `invoice` | invoice2.dtx:646, 1008, 1013, 1154 | the package's public API | the way's body commands, as in the map |
| driver preamble | invoice2.dtx:22-35 | no bespoke code | grep of the driver finds no `\newcommand`, `\def`, `\let`, `\newenvironment`, `\newcounter` or `\newif` |
| DocStrip driver | invoice2.ins:20-53 | not part of the template | `\input l3docstrip.tex` and four `\generate` calls; TeX only, no external tool |

## Content-opaque
- Item names and amounts in the examples ("Ignition!", "The TeXbook", 4087.99 ...) at invoice2.dtx:212-216, 228-232, 247-251, 265-269, 286-290, 306-310: invoice cell content.
- `macrocode` blocks that print the package's own code as manual text (invoice2.dtx:373 and after) and the formulas in `align*` and `\[ \]` (:860-870, 925-927, 947-949).
- No TikZ, PGF, PSTricks, `picture` or image anywhere (grep of every text file in the zip).

## Lib changes
- New ways proposed:
  - `inv.invoice2`: package `invoice2` (CTAN macros/latex/contrib/invoice2, TeX Live, MiKTeX, GPL 3+, PDF manual), engine pdf. An invoice item table with VAT: `\usepackage[vat=,included-vat=,currency-symbol=,currency-fraction-digits=,currency-in-header,colorize,odd-color=,even-color=,title-color=,total-color=]{invoice2}`, body `\begin{invoice}[same keys] \invoiceitem[VAT]{amount}{name}{price} \invoicesingleitem[VAT]{name}{price} \end{invoice}`, `\invoiceoptions{keys}`; it prints a `longtable` with `booktabs` rules and drops the amount, VAT and unit-price columns when every row has amount 1 and VAT 0, and sums net, VAT and gross. W1: on CTAN and in TeX Live with documentation (ctan.org/pkg/invoice2). W2: every input is a float, an integer, a boolean, a colour name, a symbol string or an item argument. W3: it serves a kind of component (an invoice item table), not one document. W4: one preamble line plus one environment wrapped around item rows. A sibling of `inv.simpleinvoice` and `inv.facture-belge` (different packages; `invoice2` prints only the item table and totals, no title, parties or bank line) and not `tbl.calctab` (a different package with `xcalctab`), `tbl.longtable` (hand-set columns, no computation) or `tbl.siunitx` (alignment only).
- Considered, not proposed: `translations` (CTAN, LPPL 1.3c, in TeX Live; ctan.org/pkg/translations read once). It is a keyword-dictionary package of the same type as `lang.translator`; here it is loaded and used only inside invoice2 (invoice2.dtx:386, 398-400), and the sample never calls `\DeclareTranslation`, so it needs no way of its own.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
