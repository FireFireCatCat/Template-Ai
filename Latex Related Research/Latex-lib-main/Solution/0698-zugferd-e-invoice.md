yes

# 0698-zugferd-e-invoice: ZUGFeRD e-Invoice (German KOMA letter invoice with an embedded XRechnung XML)

- Unverified: read from the source, not compiled.
- Source: Source/0698-zugferd-e-invoice/ (origin: https://latextemplates.com/downloads/zugferd-einvoice.zip; licence: LPPL-1.3c per the manifest, which main.tex:3-8 says was checked against the upstream GitHub LICENSE; the zip holds only main.tex and no .sty)
- Kind: invoice
- Lib: v5
- Engine: needs LuaLaTeX (main.tex:11-14: the zip author's note that the PDF/A-3 attachment path through l3pdf/pdfmanagement did not compile cleanly under pdflatex in their image; the CTAN page for `zugferd` states no engine and the lib tags `inv.zugferd` as pdf, so this is the author's observation, not tested here)
- Look carried by: mixed (the published class `scrartcl` plus the published wrapper package `zugferd-invoice` that main.tex:38 loads; the zip itself adds only class options, one `\usepackage`, KOMA variables, data keys and item rows, with no zip-local code)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip is one 104-line main.tex; `scrartcl`, `zugferd-invoice` and `zugferd` are not in it and their source was not read)

## Verdict
The zip is a single 104-line `main.tex` that sets the KOMA class `scrartcl`, the kernel `\DocumentMetadata`, one package load (`zugferd-invoice`), KOMA letter variables, `\SetZUGFeRDData` keys and four `\AddInvoiceItem` rows. A grep for `\newcommand`, `\def`, `\newenvironment`, `\newcounter`, `\newif`, `\setlength`, `\pagestyle` and `tikz` finds nothing, and the only `\usepackage` is main.tex:38, so there is no bespoke code and no ART. Every part maps to an existing lib way, so no new way is needed. The residual risk is W1 for the wrapper: its source was not read and its place in the CTAN `zugferd` bundle rests on main.tex:8-9 (see Lib changes), so a stricter reading of W1 for that one package would turn this into `no`.

## Blockers
none

## Class setting
- Class: `class.scrartcl` options: `parskip=half-` (KOMA paragraph skip of half a line, no indent), `german` (a global language option; main.tex loads no language package, so its printed effect depends on what the wrapper loads, not read) (main.tex:36)
- Class-native vocabulary used: `\setkomavar{invoice}`, `\setkomavar{date}`, `\setkomavar{title}` (main.tex:40-42); the `letter` environment with a recipient argument, `\opening`, `\closing` (main.tex:84, 86, 101, 103). main.tex never loads `scrletter`, so the `letter` environment under `scrartcl` must come from the wrapper (inferred from main.tex:16-17 "KOMA-Script \letter integration"; source not read). No `\LoadLetterOption`, `\setkomafont` or `\KOMAoptions`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class, paragraph skip, language option | main.tex:36 | `class.scrartcl` | parskip=half-, german |
| PDF/A and language metadata | main.tex:31-35 | `meta.documentmetadata` | pdfversion=1.7, pdfstandard=a-3b, lang=de; placed before `\documentclass` |
| e-invoice attachment, package load | main.tex:38 | `inv.zugferd` | `\usepackage[format=xrechnung3.0]{zugferd-invoice}`; the `format` option is forwarded to `zugferd` (inferred from the wrapper description at main.tex:16-18) |
| e-invoice data keys | main.tex:54-82 | `inv.zugferd` | `\SetZUGFeRDData{...}`: id=komavar, subject=komavar, fromaddress=komavar (55-57); unit=hour (58); seller/name, postcode, city, country, address, vatid, contact, email (59-66); buyer/reference, name, postcode, city, country, address, vatid, email (67-74); currency=EUR (75); payment-terms (76); due-date=20260910 (77); payment-means/type=58, iban, account-holder, bic (78-81) |
| call placement | main.tex:46-53 | `inv.zugferd` | `\SetZUGFeRDData` is called after `\begin{document}`; the author's comment says that from the preamble, with two or more `\AddInvoiceItem` calls, a spurious "Missing \begin{document}" error appears (a placement rule for the emitter, not code) |
| data read back into the letter | main.tex:41, 84 | `inv.zugferd` | `\InsertZUGFeRDData[set-today]{date}` followed by `\today` inside the KOMA date variable; `\InsertZUGFeRDData[AddressData]{buyer}` as the recipient argument of `letter` (what each option prints is inferred from its name; source not read) |
| letter variables | main.tex:40-42 | `ltr.opening` | KOMA variables invoice=2026:0842, date, title=Rechnung |
| letter frame | main.tex:84-86, 101-103 | `ltr.opening` | `letter` environment with recipient, `\opening{Sehr geehrte Damen und Herren,}`, `\closing{Mit freundlichen Gr\"u{\ss}en,}` |
| invoice item table with VAT and sums | main.tex:38, 91-96 | `inv.invoice2` | the item-table package is the parameter (`zugferd-invoice`, as the lib line allows `invoice`); body `\AddInvoiceItem{quantity}{description}{unit price}` four times (18/95, 1/450, 22.5/95, 4/140) and one `\PrintInvoiceTabular`; the column labels "MwSt.", "Summe (Netto)", "Summe (Brutto)" and the euro sign are fixed in the package (main.tex:19-22), so the zip chooses only rows and the `inv.zugferd` data |
| paragraph text | main.tex:88-89, 98-99 | content | two intro and two closing paragraphs of plain text, German umlauts written as `\"u` and `\ss` (main.tex:94, 99, 101) |
| page geometry, headers and footers, fonts, colour, headings, lists, floats, captions, bibliography | none set | n/a | main.tex loads no `geometry`, `fancyhdr`, font, colour or other package (the single `\usepackage` is line 38) and sets no `\pagestyle` or length; page and letterhead come from the class and wrapper defaults, which were not read |

## Bespoke code
none (no definition command anywhere in main.tex; the one package load, main.tex:38, is a published package)

## Content-opaque
none. The XML that `\SetZUGFeRDData` builds and attaches is produced by the package from the keys, so it is data held in the `inv.zugferd` parameters, not hidden content.

## Lib changes
- New ways proposed: none. Considered and not proposed: a separate way for the `zugferd-invoice` wrapper. Its visible table is an item-table package with VAT sums and fixed labels, which is the parameter clause of `inv.invoice2` ("another item-table package is the parameter"; the letter fields come from the class, here KOMA variables, main.tex:40-42); its XML attachment and data keys are the `inv.zugferd` way. The consolidator may instead widen the `inv.zugferd` line to name the wrapper, since the wrapper is the invoice package that line says the author otherwise writes. What the wrapper prints beyond the table (main.tex:98-99 speaks of "das unten genannte Konto", an account named below) was not read; it is the wrapper's fixed output, chosen by the `payment-means` keys, not zip code.
- W1 evidence for the wrapper: main.tex:8-9 says the package ships with TeX Live under `tex/latex/zugferd`; main.tex:1, 16-17 name `ctan:zugferd` and the TeXhackse/LaTeX-ZUGFeRD repository and say the sample is adapted from that project's own demo. ctan.org/pkg/zugferd was read: LPPL 1.3c, v0.13 of 2026-07-23, Marei Peischl, in TeX Live and MiKTeX, no engine statement, and it lists no style files, so `zugferd-invoice` is not confirmed there; ctan.org/pkg/zugferd-invoice is a 404 (it has no page of its own).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
