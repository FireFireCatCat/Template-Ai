yes

# 0904-swiss-qr-bill-invoice: Swiss QR-Bill Invoice

- Unverified: read from the source, not compiled.
- Source: Source/0904-swiss-qr-bill-invoice/ (origin: https://latextemplates.com/downloads/qrbill-swiss-invoice.zip; licence: LPPL-1.3c per the manifest; the sample's header comment and the CTAN page for `qrbill` give BSD-3-Clause and LPPL 1.3c for the package)
- Kind: invoice
- Lib: v6
- Engine: pdfLaTeX-compatible (only because the sample loads `qrbill` with `font/custom`, which its own comment says avoids `fontspec`, main.tex:7-12 and :20; the default branch of `qrbill` loads `fontspec` and would need XeLaTeX or LuaLaTeX; `qrbill.sty` was not read and the CTAN page names no engine)
- Look carried by: preamble (one 107-line `main.tex`: kernel `article`, `geometry`, `array`/`booktabs`, minipages and a `tabular` for the invoice page, and the published package `qrbill` for the payment slip; no zip-local class, style or macro)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is one `main.tex` over the kernel `article` class. Its first page is hand-laid with `minipage`, `tabular` and `booktabs`. Its second page is the Swiss QR-bill payment slip, which the published package `qrbill` (CTAN and TeX Live) prints from one `\qrbillsetdata{key=value,...}` call and `\QRbill`. The zip defines no macro, environment, counter or class of its own and draws no template artwork, so every construct reduces to lib ways. The only gap is the `qrbill` package itself, proposed as `NEW:inv.qrbill`; its source was not read, so W2 to W4 for it rest on the sample's use and the CTAN page.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:18). The class is the kernel one, not bundled, source not read.
- Class-native vocabulary used: none (no `\maketitle`, no `abstract`, no sectioning; the sample uses only `\documentclass`, `\clearpage` and body text).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:18 | `class.article` | `a4paper` |
| paper size | main.tex:18 | `page.class-options` | `a4paper` |
| page geometry | main.tex:19 | `page.geometry` | `a4paper`, `margin=2cm` |
| header/footer | main.tex:22 | `hf.pagestyle-kernel` | `\pagestyle{empty}`, so no running head or page number on either page |
| Swiss QR-bill payment slip (receipt part, payment part, QR code, scissors line, amount and reference fields) | main.tex:20, main.tex:69-104, main.tex:105 | `NEW:inv.qrbill` | package option `font/custom`; body `\qrbillsetdata{QRType=SPC, Version=0200, CodingType=1, Account=, CR-AddressType=S, CR-Name, CR-Address1, CR-Address2, CR-PostalCode, CR-City, CR-Country, UCR-*, Amount, Currency=CHF, UD-*, ReferenceType=QRR, Reference, Message, invoicenum, invoicedate, vat, conditions}` then `\QRbill` |
| payment-slip font | main.tex:7-12, main.tex:20 | `NEW:inv.qrbill` | `font/custom` clears the package's default `font` key (initial value Liberation Sans, per the comment), so the slip uses `\normalfont` and `fontspec` is not loaded |
| QR code of the payment data | main.tex:105 (produced inside `\QRbill`) | `NEW:inv.qrbill` | built by the package from the data keys (CTAN lists `qrcode` as a dependency; the sample calls no `\qrcode` itself, so `fig.qrcode` is not used by the sample) |
| invoice head, sender and recipient blocks | main.tex:27-33, main.tex:34-43 | `box.minipage` | `[t]{0.5\textwidth}` and `[t]{0.4\textwidth}`, joined by `\hfill` |
| right-aligned recipient block | main.tex:35 | `sp.ragged` | `\raggedleft` inside the second minipage |
| invoice item table | main.tex:47-60 | `tbl.tabular` | `array` loaded (main.tex:21); column spec `@{}p{7.2cm}rrr@{}`; `\multicolumn{3}{r}{...}` for the Subtotal, VAT and Total rows (main.tex:56-58) |
| table rules | main.tex:21, main.tex:48, main.tex:50, main.tex:55, main.tex:59 | `tbl.booktabs` | `\toprule`, `\midrule` (twice), `\bottomrule` |
| bold labels and totals | main.tex:28, 36, 39, 49, 58 | `mark.kernel` | `\textbf` |
| vertical and horizontal spacing | main.tex:33, 38, 45, 62 | `sp.manual-space` | `\hfill`, `\\[1em]`, `\vspace{1.5em}` (twice) |
| page break before the slip | main.tex:66 | `pg.break` | `\clearpage` |

No component is defined for fonts (beyond the slip), colour, language, metadata, front matter, abstract, contents, headings, numbering, lists, quotes, notes, math, theorems, floats, captions, code, boxes other than the minipages, bibliography or index: `main.tex` loads no package for them and its body (main.tex:24-107) uses none. The sample has no `inputenc` or `fontenc` line; the non-ASCII letters at main.tex:28-30 are content, and whether `qrbill` loads an encoding package was not read.

## Bespoke code
none. A search of main.tex for `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter`, `\newif` and `\ExplSyntaxOn` finds none; I read all 107 lines. The zip holds no `.cls`, `.sty`, `.cfg` or other TeX file.

## Content-opaque
none. The QR code and slip layout are printed by the published package from data keys (main.tex:69-105); the sample draws no TikZ, PGF or `picture` artwork and includes no image.

## Lib changes
- New ways proposed: `NEW:inv.qrbill` (doc-kind, beside `inv.simpleinvoice`, `inv.invoice2`, `inv.zugferd` and `inv.facture-belge`). `qrbill` (CTAN, TeX Live and MiKTeX, 3-clause BSD and LPPL 1.3c, v2.01 of 2023-07-24; Alex Antener and Marei Peischl; ctan.org/pkg/qrbill read; loads `expl3`, `fontspec` (not when a custom font setup is used), `graphicx`, `scrbase`, `qrcode`, `iftex`, `l3keys2e`, `numprint`): the Swiss QR-bill payment slip, `\usepackage[font/custom]{qrbill}`, `\qrbillsetup{key=value}`, `\qrbillsetdata{key=value,...}` and the body command `\QRbill`; engine `pdf` with the `font/custom` option (the default font branch uses `fontspec`, so XeLaTeX or LuaLaTeX); the commands come from the sample and its comments, `qrbill.sty` was not read, and the CTAN page lists no commands or options.
  - W1: released on CTAN and in TeX Live (the zip itself ships no copy, main.tex:5, so the zip is not the source of the way).
  - W2: behaviour is chosen by package options and by the key=value data list (strings for names, address lines, account, reference and message; `Amount`, `Currency`, `ReferenceType` values; main.tex:69-104).
  - W3: it serves any Swiss QR-bill invoice or payment slip, not this one invoice; the creditor, debtor, amount and reference are all data.
  - W4: an emitter prints one preamble line (`\usepackage[font/custom]{qrbill}`) and one body block (`\qrbillsetdata{...}` followed by `\QRbill`).
  - Not `fig.qrcode` (a bare QR code of one string; the slip adds receipt and payment parts, amount and reference fields), not `inv.zugferd` (an XML attachment, no visible slip), not `art.tikz` (the slip is produced by the package).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
