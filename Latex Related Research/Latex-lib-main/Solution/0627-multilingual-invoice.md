yes

# 0627-multilingual-invoice: Multilingual Invoice

- Unverified: read from the source, not compiled.
- Source: Source/0627-multilingual-invoice/ (origin: https://latextemplates.com/downloads/multilingual-invoice.zip; licence: LPPL-1.3c per the manifest row; the zip holds no licence file)
- Kind: invoice
- Lib: v5
- Engine: pdfLaTeX-compatible (`fontenc` T1 only, main.tex:13; no `fontspec`, no Lua; the `invoice` package depends on `fp`, `calc` and `siunitx`, per ctan.org/pkg/invoice, and the CTAN page states no engine)
- Look carried by: preamble (kernel `article` at 11pt carries almost nothing, main.tex:12; the published package `invoice`, loaded at main.tex:14, prints the item table, sums and totals; geometry and page style are two preamble lines, main.tex:15-16; the two heading lines are hand-set in the body, main.tex:20-21; nothing is zip-local)
- Class origin: tex-distribution-unbundled (`article` is a kernel class and is not in the zip)
- Main file: main.tex (other samples: none)
- Read: main yes (all 40 lines), zip-local classes and styles none present (the zip holds one file, main.tex, 40 lines; no `.cls`, `.sty`, `.def`, `.cfg`, and no `invoice.sty`)

## Verdict
The zip is a 40-line sample: kernel `article`, three preamble package lines (T1, `invoice` with the `english` option, `geometry`), `\pagestyle{empty}`, two hand-set heading lines and one `invoice` environment (main.tex:12-38). The `invoice` package is published (ctan.org/pkg/invoice, read once: Oliver Corff, LPPL 1.3c, version 2018-08-06, in TeX Live and MiKTeX, "10 languages") and is already the parameter of `inv.invoice2` in lib v5. That lib line names `\ProjectTitle`, `\Fee`, `\EBC` and `\Discount`; `\EFC` is another row command of the same package (the rubric says a lib line names examples of its way's type), so it is the same way. The zip defines no macro, counter, environment or file of its own, and there is no artwork and no external tool, so the answer is `yes`. Sensitivity: the package source is not in the zip and was not read, and the CTAN page names no commands, so the argument roles of `\Fee` and `\EFC` below are read from the sample and its header comment alone.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (main.tex:12); no paper option (the class default applies); no other option.
- Class-native vocabulary used: none from the class. The sample uses no `\title`, `\maketitle`, `abstract` or sectioning command; its body is two hand-set lines and the `invoice` environment (main.tex:20-38).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:12 | `class.article` | `11pt` |
| paper and size | main.tex:12 | `page.class-options` | `11pt` (no paper-size option) |
| encoding | main.tex:13 | `font.fontenc-t1` | `fontenc` with `T1`; no `inputenc`, no font package, so the default Computer Modern family stays |
| invoice package load and language | main.tex:14 | `inv.invoice2` | `\usepackage[english]{invoice}`; the option is the language of the package's own column labels (the header comment, main.tex:10, says 10 languages ship; CTAN page agrees) |
| page geometry | main.tex:15 | `page.geometry` | `margin=2.5cm` (one key) |
| page style | main.tex:16 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no running head, foot or page number) |
| heading line: title and issuer | main.tex:20 | `mark.kernel`, `font.size-commands`, `sp.manual-space`, `sp.lengths` | `\noindent\textbf{\Large Invoice}\hfill Dahlgren Consulting\\`: `\textbf` bold, `\Large` size, `\hfill` pushes the issuer name to the right, `\\` ends the line; `\noindent` is filed under `sp.lengths` as the nearest home (the per-paragraph form of `\parindent`; precedent in Solution/0009 and 0043) |
| heading line: number and date | main.tex:21 | `sp.manual-space`, `sp.lengths` | `\noindent Invoice \#2026-0071 \hfill 27 August 2026\\[1em]`: `\hfill` between number and date, `\\[1em]` ends the line with a 1em gap; the number and the date are fixed strings (content) |
| invoice table wrapper | main.tex:23, 38 | `inv.invoice2` | `\begin{invoice}{Euro}{19}` ... `\end{invoice}`: two arguments, the currency name `Euro` and the VAT rate `19` |
| project title rows | main.tex:24, 30 | `inv.invoice2` | `\ProjectTitle{<title>}` (two uses, strings: "Retail Platform Migration", "Q3 Vendor Negotiation") |
| fee rows | main.tex:25-26, 31-32 | `inv.invoice2` | `\Fee{<description>}{<number>}{<number>}`: `{950.00}{6}`, `{950.00}{2}`, `{1100.00}{3}`, `{1100.00}{2}` (a rate and a quantity by my reading of the values; the package computes the line sums, main.tex:10-11) |
| expense in base currency | main.tex:28 | `inv.invoice2` | `\EBC{<description>}{<amount>}`: `{Printed workshop materials}{84.50}` |
| expense in foreign currency | main.tex:34-35 | `inv.invoice2` | `\EFC{<description>}{<currency string>}{<amount>}{<rate>}{<converted amount>}`: main.tex:34 gives a rate and leaves the converted amount empty (`{HK\$}{210.00}{0.1175}{}`); main.tex:35 leaves the rate empty and gives the converted amount (`{HK\$}{5400.00}{}{634.50}`); the header comment (main.tex:7-9) says the package converts when a rate is given |
| discount row | main.tex:37 | `inv.invoice2` | `\Discount{Downpayment received 12 July 2026}{1500.00}` (string, amount) |
| subtotals and grand total | main.tex:10-11 (comment) | `inv.invoice2` | computed by the package; the sample types no sum |

Not a row (the sample defines nothing for it): colour, fonts beyond T1, headings and sectioning, lists, maths, theorems, other tables, floats, captions, code, bibliography, index, cross-references, hyperref, language packages (`babel`), footnotes, front matter. The package loads `fp`, `calc` and `siunitx` itself (ctan.org/pkg/invoice); the sample calls none of them directly, so they are not rows.

## Bespoke code
none. The zip contains one file; main.tex has no `\newcommand`, `\def`, `\newenvironment`, counter or conditional. `\ProjectTitle`, `\Fee`, `\EBC`, `\EFC`, `\Discount` and the `invoice` environment come from the published package loaded at main.tex:14, not from the zip.

## Content-opaque
none (the item descriptions, amounts, rates, dates, the invoice number and the issuer name at main.tex:20-37 are content; `HK\$` at main.tex:34-35 is a currency string with an escaped dollar sign)

No text addressed to an AI was found in main.tex. The header comment (main.tex:1-11) only describes the package and mentions other templates in "this batch"; it asks for nothing and was ignored.

## Lib changes
- New ways proposed: none. `invoice` is already folded into `inv.invoice2` in lib v5; `\EFC` is another command of the same package. Considered: a separate foreign-currency way, rejected because `\EFC` is a row command of the same `invoice` environment.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
