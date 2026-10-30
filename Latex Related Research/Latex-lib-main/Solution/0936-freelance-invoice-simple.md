no

# 0936-freelance-invoice-simple: Freelance Invoice (Simple)

- Unverified: read from the source, not compiled.
- Source: Source/0936-freelance-invoice-simple/ (origin: https://latextemplates.com/downloads/freelance-invoice-simple.zip; licence: MIT, Copyright (c) 2011 Trey Hunner, LICENSE:1 and invoice.cls:2)
- Kind: invoice
- Lib: v6 (the snapshot read)
- Engine: pdfLaTeX-compatible (article, geometry, parskip, fp, calc, longtable; nothing needs XeLaTeX or LuaLaTeX)
- Look carried by: zip-local (invoice.cls sets page, spacing and the whole item table; the sample body only hand-lays the letterhead and calls the class's row macros)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
no. The look is a zip-local `invoice.cls` that is `\LoadClass[12pt]{article}` plus `geometry`, `parskip`, `longtable` and a few lengths, and all of that reduces to lib ways. What does not reduce is the class's running-total machinery: four hand-rolled counters holding amounts scaled by 1000, `fp` rounding, division and multiplication, and a starred/unstarred `\subtotal` that picks what is printed and resets the counters. Every Amount cell, Subtotal and the Balance Due is produced by it, which is the rubric's "hand-rolled counters and conditionals that drive what is printed". No lib way gives that table (see Bespoke code). If the sums were treated as data the emitter computes and the table as a static `longtable`, the rest would be a `yes`; this file does not take that route.

## Blockers
- `BESPOKE/class` four counters `hours` `subhours` `cost` `subcost` filled by `\addtocounter{..}{1000 * \real{..} * \real{..}}` and printed through `\FPround` `\FPdiv` `\FPmul` (invoice.cls:49-50, 53, 56, 62-65, 69-72, 96-97)
- `BESPOKE/class` `\subtotal` with `\@ifstar` choosing between two row layouts and resetting the sub-counters (invoice.cls:75-91)
- `BESPOKE/class` row commands `\unitrow` `\feerow` `\hourrow` defined inside the `invoiceTable` begin code, with a stored default rate `\@hourlyrate` that `\hourrow` passes to `\unitrow` (invoice.cls:41-42, 59-73, 95-99)
- `BESPOKE/class` the closing "Balance Due" row prints `\total{cost}` (invoice.cls:110)

## Class setting
- Class: `class.article` options: `12pt`. The sample declares `\documentclass{invoice}` (main.tex:10); the zip-local `invoice.cls` calls `\LoadClass[12pt]{article}` (invoice.cls:27) and sets nothing else on the class. `invoice` here is not the CTAN package `invoice` (ctan.org/pkg/invoice read: Oliver Corff, LPPL 1.3c, depends on `fp`, `calc` and `siunitx`; the lib's `inv.invoice2` line names its `\Fee` and `\EBC` commands): this file is a class with `\hourrow`, `\unitrow`, `\feerow`, MIT, by Trey Hunner, and the zip comes from latextemplates.com, not an official release, so it is zip-local (the name coincides with a CTAN package, the content does not).
- Class-native vocabulary used: none of article's own (no `\maketitle`, no sectioning, no `abstract`). The zip-local vocabulary the sample uses is `\hourlyrate`, `invoiceTable`, `\feetype`, `\hourrow`, `\unitrow`, `\feerow`, `\subtotal` (main.tex:29-41).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:10; invoice.cls:27 | `class.article` | 12pt |
| page size and type size | invoice.cls:27, 29 | `page.class-options` | `12pt`; paper is set by the geometry option `letterpaper`, not a class option |
| page geometry | invoice.cls:29 | `page.geometry` | letterpaper, hmargin=0.79in, vmargin=0.79in |
| header/footer, page numbers | invoice.cls:35 | `hf.pagestyle-kernel` | `\pagestyle{empty}` ("No page numbers") |
| paragraph spacing | invoice.cls:30 | `sp.parskip-pkg` | option `parfill` |
| line spacing | invoice.cls:36 | `sp.linespread` | `\linespread{1.5}` |
| double-rule gap | invoice.cls:38 | `sp.lengths` | `\setlength{\doublerulesep}{\arrayrulewidth}` |
| calc syntax in counter updates | invoice.cls:32, 62-63, 69-70, 96-97 | `sp.lengths` | load-only `calc`; `\real{}` expressions inside `\addtocounter` (the counters they feed are the blocker above) |
| fonts | no font package in either file | none | default Computer Modern from `class.article`; nothing to emit |
| name line (title size) | main.tex:16 | `font.size-commands` | `\Huge`; centred by `\hfil{..}\hfil` (`sp.manual-space`) |
| bold labels and header text | main.tex:16, 22, 26; invoice.cls:44, 76, 82, 105, 110 | `mark.kernel` | `\bf` in main.tex and the header/total cells, `\textbf` in `\feetype` |
| letterhead vertical gap | main.tex:17 | `sp.manual-space` | `\bigskip\break` |
| rule under the name | main.tex:18 | `sp.rule` | bare `\hrule` |
| address lines | main.tex:19-20 | `sp.manual-space` | `\hfill` between left and right field, `\\` breaks |
| "Invoice To" and "Date" blocks | main.tex:22-27 | `sp.manual-space` | `\tab` is `\hspace*{3ex}` (alias, main.tex:12); labels in `mark.kernel` |
| printed date | main.tex:27 | `front.maketitle` | kernel `\today`, no package (the date command of the kernel `\date` family; the text is content) |
| item table shell | invoice.cls:33, 101-103, 107, 111 | `tbl.longtable` | colspec `@{\extracolsep{\fill}\hspace{\tabcolsep}} l r r r`, `\LTleft`=`\LTright`=0pt, repeated header via `\endhead` |
| table column gap | invoice.cls:100 | `sp.lengths` | `\renewcommand{\tabcolsep}{0.8ex}` (a length rewritten with `\renewcommand`; it sits inside the environment's begin code, so it is local) |
| table rules and header row | invoice.cls:104-106, 109 | `tbl.tabular` | `\hline`; `\hline\hline` under the header; `\hline\hline\hline` over the total; header cells `\multicolumn{1}{c}{\bf ..}`; `\\*` after the header |
| fee-type heading row | invoice.cls:43-46; main.tex:32, 37, 40 | `tbl.tabular` | one bold cell and `\\`; the wrapper `\feetype` is a `\newcommand` alias |
| item rows (date or title, quantity and unit, unit price, amount) | invoice.cls:61-73, 95-99; main.tex:33-35, 38, 41 | `tbl.tabular` | four-cell row; cell values come from the blocked arithmetic |
| subtotal rows | invoice.cls:75-91; main.tex:36, 39 | `tbl.tabular` | `\hline`, bold cells, `\\*[1.5ex]` (`sp.manual-space`); values come from the blocked arithmetic |
| balance row | invoice.cls:109-111 | `tbl.tabular` | bold "Balance Due" cell and `\$` amount; value from the blocked arithmetic |

No component in the sample for: columns, colour, background, language, abstract, contents, headings, numbering, lists, quotes, notes, math, theorems, floats, captions, code, boxes, bibliography, index, cross-references.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\tab` | main.tex:12 | yes | `\hspace*{3ex}` (`sp.manual-space`) |
| `\feetype` | invoice.cls:43-46 | yes | a bold one-cell row, `\textbf{..}\\` in `tbl.longtable` |
| `\hourlyrate`, `\@hourlyrate` | invoice.cls:41-42; main.tex:29 | no, as used | a stored default (1 until set, `\hourlyrate{1}`) that `\hourrow` feeds into the product; it is a value of the arithmetic below, not a layout |
| counters `hours` `subhours` `cost` `subcost` | invoice.cls:49-50 | no | integers holding value x 1000 as hand-rolled fixed point; they drive the printed totals |
| `\formatNumber`, `\total` | invoice.cls:53, 56 | no | `\FPround` to two decimals and `\FPdiv` by 1000 of counter values, printed as amounts |
| `\unitrow`, `\feerow`, `\hourrow` | invoice.cls:61-73, 95-99 | no | each adds to two counters and prints a computed product (`\FPmul`); `\hourrow` also adds to `hours` and `subhours` |
| `\subtotal`, `\subtotalNoStar`, `\subtotalStar` | invoice.cls:75-91 | no | `\@ifstar` conditional picks the row layout, prints a sum and zeroes the sub-counters, so output depends on earlier rows |
| `invoiceTable` environment | invoice.cls:59-112 | partly | the `longtable` shell, header and footer rows reduce to `tbl.longtable` and `tbl.tabular`; the begin code that defines the row commands per instance does not |
| `fp` package load | invoice.cls:31 | n/a | considered: `fp` (arithmetic package, ctan.org/pkg/fp not read); it is used only inside the zip-local macros above, has no component, and is not proposed |
| `calc` load | invoice.cls:32 | yes | `sp.lengths` (load-only) |

Not lib ways for the table, so no reduction through them: `inv.invoice2` (lib line: `\invoiceitem` rows with VAT, columns dropped by rule, no per-group subtotal, hours column or "Description of Services" header) and `tbl.calctab` (lib line: fixed `xcalctab` layout with its own header strings); the package sources were not read. The other `inv.*` lines are whole packages with their own layout. Replacing the macros by a static `longtable` with the sums written in by the emitter is the only reduction found, and it moves computation into the emitter.

Observation from the source, not from a compile: `\unitrow` adds to `cost` and `subcost` but not to `subhours` (invoice.cls:61-66), while the non-starred `\subtotal` prints `\total{subhours}` (invoice.cls:76), so the second `\subtotal` in the sample (main.tex:39) follows a `\unitrow` and would show a zero hours figure.

## Content-opaque
none

## Lib changes
- New ways proposed: none (considered: `fp`, a macro-body arithmetic helper with no component and no node content to wrap, as `sp.xspace` in the v4 log).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
