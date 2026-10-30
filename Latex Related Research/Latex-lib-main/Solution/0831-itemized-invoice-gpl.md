yes

# 0831-itemized-invoice-gpl: Itemized Invoice (GPL), invoice2 with per-row VAT override

- Unverified: read from the source, not compiled.
- Source: Source/0831-itemized-invoice-gpl/ (origin: https://latextemplates.com/downloads/itemized-invoice-gpl.zip; licence: GPL-3.0-or-later, LICENSE.md:1-3 is GPL v3)
- Kind: invoice
- Lib: v6
- Engine: pdfLaTeX-compatible (article, T1 `fontenc`, `geometry`, `invoice2`; the CTAN page of `invoice2` names no engine and its source is not in the zip, so this rests on the lib line `inv.invoice2`, tagged `pdf`)
- Look carried by: preamble (the zip adds only `main.tex`; the table look is the published package `invoice2`, loaded at main.tex:12 and driven by the `invoice` environment options at main.tex:20; page setup is `article` + `geometry`)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only `main.tex`, 26 lines, and `LICENSE.md`; `invoice2.sty` is not bundled, so its source was not read)

## Verdict
The whole zip is a 26-line sample that loads three published packages (`fontenc`, `geometry`, `invoice2`) over kernel `article`, sets `\pagestyle{empty}`, hand-sets two header lines with kernel commands and prints one `invoice` environment. There is no zip-local class, style, macro, counter or drawing. `invoice2` is on CTAN (GPL 3+, version 2018-01-15, in TeX Live and MiKTeX; ctan.org/pkg/invoice2 read once) and is already lib way `inv.invoice2`, so the subtotal, VAT and grand total that main.tex:1-8 call "the package's own fp arithmetic" are published code, not bespoke. Every component maps to an existing lib way, so `yes`.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (main.tex:9)
- Class-native vocabulary used: none (no `\maketitle`, `abstract` or sectioning; the sample uses only the `invoice` environment from the loaded package)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:9 | `class.article` | option `11pt` |
| type size by class option | main.tex:9 | `page.class-options` | `11pt`; no paper-size or `twocolumn` option |
| font encoding | main.tex:10 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}` |
| page geometry | main.tex:11 | `page.geometry` | `margin=2.5cm` (one key, all four margins) |
| page style (no header, footer or page number) | main.tex:13 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| paragraph indent off for the two header lines | main.tex:17, main.tex:18 | `sp.lengths` | `\noindent` before each line; it is the per-paragraph switch of `\parindent`, and `\parindent=0pt` gives the same result here because every paragraph start in the body is a `\noindent` line (no other lib line holds paragraph-indent control) |
| invoice title size and weight | main.tex:17 | `font.size-commands`, `mark.kernel` | `\Large` and `\textbf` around `Invoice \#4471` (the number is text) |
| header line layout (left text, right text, line breaks) | main.tex:17, main.tex:18 | `sp.manual-space` | `\hfill` between left and right text; `\\` and `\\[1.5em]` line breaks |
| invoice item table with net, VAT and gross sums | main.tex:20-24 | `inv.invoice2` | `invoice` environment with options `vat=0.20`, `currency-symbol=\pounds`, `currency-in-header` (a boolean flag) |
| item rows | main.tex:21, main.tex:22 | `inv.invoice2` | `\invoiceitem{amount}{name}{price}`: `{4}`/`{12}`, names, `{38.50}`/`{6.20}`; the environment VAT rate applies |
| item row with VAT override | main.tex:23 | `inv.invoice2` | `\invoiceitem[0]{1}{Postage (zero-rated)}{14.00}`: optional argument `[0]` overrides the default rate for one row |
| package load | main.tex:12 | `inv.invoice2` | `\usepackage{invoice2}` with no package options (all keys sit on the environment) |
| document body wrapper | main.tex:15, main.tex:26 | `class.article` | kernel `document` environment |

Components the sample does not use: front matter and `\maketitle`, abstract, contents, headings, numbering, lists, quotes, notes, maths, theorems, floats, captions, code, boxes, bibliography, index, cross-references, language and metadata settings, colour (the `colorize` family of `invoice2` keys is not selected), backgrounds. The date `27 August 2026` (main.tex:18) is literal text, not `\today`.

## Bespoke code
none. `main.tex` defines no `\newcommand`, `\def`, `\newenvironment`, counter or conditional, and the zip has no `.cls`, `.sty` or `.def` file. The expl3 and `fp` arithmetic mentioned in the file comment (main.tex:1-8) lives inside the published `invoice2` package (CTAN, GPL 3+) and is not zip-local code.

## Content-opaque
none (the item names, quantities, prices, invoice number, party names and date at main.tex:17-23 are text content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Not read: the source of `invoice2.sty` (not in the zip). What its keys and commands do is taken from the lib line `inv.invoice2` and from the one CTAN page read (description, author Simon Dierl, version, GPL 3+, in TeX Live and MiKTeX); the CTAN page lists no dependencies and no engine.
- Missing assets: none; the page uses no fonts or images beyond TeX Live.
- No text addressed to an AI was found in the zip.
