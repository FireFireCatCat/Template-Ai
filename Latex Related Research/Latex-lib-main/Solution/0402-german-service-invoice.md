yes

# 0402-german-service-invoice: German Service Invoice

- Unverified: read from the source, not compiled.
- Source: Source/0402-german-service-invoice/ (origin: https://latextemplates.com/downloads/latex-rechnung-starter.zip; licence: GPL-2.0, README.md:13-14 and manifest)
- Kind: invoice
- Lib: v4
- Engine: pdfLaTeX-compatible (`fontenc` T1, `inputenc` utf8, `lmodern`, main.tex:4-7; no `fontspec`, no Lua; the README builds with `pdflatex main`, README.md:19; the CTAN page of `invoice` does not state pdfTeX support, its dependencies are `fp`, `calc`, `siunitx`)
- Look carried by: mixed (the page and letter fields come from the published class `scrlttr2` plus `\setkomavar` settings in the sample preamble, main.tex:15-31; the item table and totals are printed by the published package `invoice`, main.tex:11 and 41-47; nothing is zip-local except data strings, invoice-data.tex:2-21)
- Class origin: tex-distribution-unbundled (`scrlttr2` is KOMA-Script's letter class; it is not in the zip and its source was not read)
- Main file: main.tex (other samples: none)
- Read: main yes (all 58 lines), zip-local classes and styles none present (no `.cls`, `.sty`, `.def`, `.cfg` in the zip; the zip-local data file invoice-data.tex was read in full, 21 lines; README.md read in full)

## Verdict
The zip is a letter-class invoice: `scrlttr2` with letter fields set by `\setkomavar`, and the item rows, subtotal, discount and total printed by the `invoice` package, which main.tex:2 and README.md:15 say TeX Live supplies and which ctan.org/pkg/invoice lists on CTAN (LPPL 1.3c, in TeX Live and MiKTeX; read once). Nothing in the zip defines typesetting code: the only zip-local items are twenty `\newcommand` data strings (invoice-data.tex:2-21), which reduce by inline expansion. Every component maps to a lib way, one of them a proposed `inv.invoice2` (a sibling of `inv.invoice2`, a different package). There is no artwork, no external tool and no irreducible macro, so the answer is `yes`. Sensitivity: the sample's look rests on `scrlttr2` and `invoice`, whose sources were not read (neither is in the zip).

## Blockers
none

## Class setting
- Class: `class.scrlttr2` options: `a4paper`, `11pt` (main.tex:3); no `\KOMAoptions`, no `\LoadLetterOption`, no `.lco` file.
- Class-native vocabulary used: `\setkomavar` for the fields `fromname`, `fromaddress`, `place`, `date`, `fromphone`, `fromemail`, `subject`, `signature`, `location`, `firsthead`, `firstfoot` (main.tex:15-31); environment `letter{<address lines separated by \\>}` (main.tex:34-35, 57); `\opening{...}` (main.tex:36); `\closing{...}` (main.tex:56).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:3 | `class.scrlttr2` | `a4paper`, `11pt` |
| paper and size | main.tex:3 | `page.class-options` | `a4paper`, `11pt` |
| encoding | main.tex:4-5 | `font.fontenc-t1` | `fontenc` T1, `inputenc` utf8 |
| language | main.tex:6 | `lang.babel` | `ngerman` |
| text face | main.tex:7 | `font.lmodern` | `lmodern`, no options |
| default family | main.tex:14 | `font.family-default` | `\renewcommand{\familydefault}{\sfdefault}` (Latin Modern sans for all text) |
| page geometry | main.tex:8 | `page.geometry` | `margin=2cm` (loaded over the class's own text area; no other key) |
| colour package | main.tex:9 | `color.xcolor` | no options; no colour is defined or used anywhere in main.tex (load-only) |
| links | main.tex:10, 20 | `meta.hyperref` | `hidelinks`; `\href{mailto:...}{...}` in the sender e-mail field |
| invoice package load | main.tex:11 | `inv.invoice2` | `\usepackage[german]{invoice}` (option `german` is the output language of the package's own strings) |
| data file | main.tex:13; invoice-data.tex:2-21 | `struct.input` | `\input{invoice-data}`; the file holds only `\newcommand` strings (see Bespoke code) |
| sender fields | main.tex:15-22 | `ltr.opening` | `\setkomavar` fromname, fromaddress (`\\` break and `\ `), place, date (a fixed string, not `\today`), fromphone, fromemail, subject (`Rechnung <ref>`), signature |
| line breaks inside fields | main.tex:16, 24-25, 28-30 | `sp.manual-space` | `\\`, `\\[-2pt]` |
| location field | main.tex:23-26 | `ltr.opening` | `\setkomavar{location}` = `\raggedleft\small` then three lines (Rechnungsnummer, Fällig am, Steuernummer) |
| location alignment and size | main.tex:23 | `sp.ragged`, `font.size-commands` | `\raggedleft`, `\small` |
| letterhead (first-page head) | main.tex:27-30 | `ltr.opening` | `\setkomavar{firsthead}` = `\hfill` + `\parbox[t]{7cm}{...}` holding bold sender name, street, ZIP and city, phone, e-mail, web |
| letterhead box and push | main.tex:27 | `box.minipage`, `sp.manual-space` | `\parbox[t]{7cm}`, `\hfill` |
| letterhead alignment and bold | main.tex:27-28 | `sp.ragged`, `mark.kernel` | `\raggedleft`, `\textbf{\senderName}` |
| first-page foot | main.tex:31 | `ltr.opening` | `\setkomavar{firstfoot}{}` (emptied) |
| letter body wrapper and recipient | main.tex:34-35, 57 | `ltr.opening` | `\begin{letter}{company\\name\\street\\ZIP city}` |
| salutation | main.tex:36 | `ltr.opening` | `\opening{<salutation>}` |
| closing and signature | main.tex:56, 22 | `ltr.opening` | `\closing{Mit freundlichen Grüßen}`; signature string from the `signature` field |
| invoice item table | main.tex:41-47 | `inv.invoice2` | `\begin{invoice}{Euro}{0}` (currency name, VAT rate 0), `\ProjectTitle{..}` (:42), `\Fee{..}{95.00}{3}` and `\Fee{..}{95.00}{2}` (:43-44), `\EBC{..}{180.00}` (:45), `\Discount{..}{25.00}` (:46); subtotal and discount are computed by the package (README.md:6-7) |
| payment line | main.tex:52-54 | `sp.manual-space`, `mark.kernel` | `\smallskip`, `\quad`, `\textit{Zahlung an:}` |
| running head and foot on later pages | none defined in the zip | not a row | the sample sets no page style and no `\pagestyle`; the class default applies (class source not read) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| 20 data macros `\invoiceDate`, `\payDate`, `\invoiceReference`, `\invoiceSalutation`, `\customer*` (Company, Name, Street, ZIP, City), `\sender*` (Name, Street, ZIP, City, Phone, Email, Web), `\taxID`, `\accountBankName`, `\accountIBAN`, `\accountBIC` | invoice-data.tex:2-21 (preamble scope; used at main.tex:15-36 and 53-54) | yes | zero-argument `\newcommand` constants holding plain strings (names, dates, address lines, bank details): expand inline at each use, or keep as `\newcommand` aliases. No conditionals, counters or computation. `\href{mailto:\senderEmail}{\senderEmail}` (main.tex:20) becomes `\href{mailto:billing@example.org}{billing@example.org}` under `meta.hyperref` |

Not bespoke: `\ProjectTitle`, `\Fee`, `\EBC`, `\Discount` and the `invoice` environment are commands of the published package `invoice` (main.tex:11), not zip definitions. `\setkomavar` values are compositions of the ways in the table.

## Content-opaque
none (the item descriptions, rates and quantities at main.tex:42-46 and the paragraph texts at main.tex:38-39, 49-50 are content)

No text addressed to an AI was found in README.md, main.tex or invoice-data.tex.

## Lib changes
- New ways proposed: `inv.invoice2` `invoice` (CTAN, version 2018-08-06 and LPPL 1.3c per ctan.org/pkg/invoice, which also lists it in TeX Live and MiKTeX; author Oliver Corff; dependencies `fp`, `calc`, `siunitx`; the package source was not read, it is not in the zip), engine pdf (pdfTeX support not stated on the CTAN page; README.md:19 builds with `pdflatex`). Form: `\usepackage[<language>]{invoice}` (the CTAN page says ten output languages; this sample uses `german`), body environment `\begin{invoice}{<currency>}{<VAT rate>}` with row commands `\ProjectTitle{title}`, `\Fee{description}{number}{number}`, `\EBC{description}{amount}`, `\Discount{description}{amount}` (main.tex:41-47); the package totals the rows (README.md:6-7). W1: on CTAN and in TeX Live (read at ctan.org/pkg/invoice). W2: behaviour is chosen by the language option, a currency name, a rate and strings and numbers per row, with no code edits. W3: serves any service or consulting invoice, not one document. W4: one preamble line plus one body wrapper around rows. Kept apart from `inv.invoice2` on the lib's own precedent of one `inv.*` line per invoice package (`inv.simpleinvoice`, `inv.invoice2`, `inv.facture-belge`): a different package, different commands, no shared key set; the consolidator may instead fold it into `inv.invoice2` with the package as the parameter.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
