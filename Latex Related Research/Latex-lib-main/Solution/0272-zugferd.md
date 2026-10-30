no

# 0272-zugferd: ZUGFeRD (e-invoice package with a demo invoice, `zugferd` + `zugferd-invoice`)

- Unverified: read from the source, not compiled.
- Source: Source/0272-zugferd/ (origin: https://mirrors.ctan.org/macros/latex/contrib/zugferd.zip; licence: LPPL 1.3c)
- Kind: invoice
- Lib: v3
- Engine: pdfLaTeX-compatible (by reading only: neither `zugferd-invoice.sty` nor `zugferd.dtx` tests for or calls an engine; both demos open with a `% !TeX Program=lualatex` magic comment, DEMO-rechnung-zugferd.tex:1; needs a LaTeX kernel of 2024-11-01 or later, zugferd.dtx:22)
- Look carried by: mixed (visible invoice = the example style `zugferd-invoice.sty` loaded on `scrartcl` + `scrletter`; the data and XML attachment = the published `zugferd` package driven from the sample's `\SetZUGFeRDData` block)
- Class origin: tex-distribution-unbundled (`scrartcl`, KOMA-Script, not in the zip; `zugferd-invoice.sty` is a style file, not a class)
- Main file: DEMO-rechnung-zugferd.tex (other samples: DEMO-rechnung-zugferd-Kleinunternehmen.tex)
- Read: main yes, zip-local classes and styles all (zugferd-invoice.sty in full; zugferd.dtx partly: lines 1-130, 290-1440, 1680-1970, 2496-2810, 3066-3195 read, the rest outlined by grep; the XML element writers, the trade-party key tables and the l3doc driver code were not read line by line)

## Verdict
no. The whole visible look of this zip (the item table, the per-VAT-rate sums, the letter-based invoice) is written in `zugferd-invoice.sty`, expl3 code that accumulates floating-point sums per tax rate, replays a stored item list through `\seq_map_inline`, branches on `\keys_if_choice_exist`, and writes the XML as a side effect of the same pass; that is irreducible typesetting logic, not a composition of lib ways. The package's own text says this file is an example that "should not be used in production" and is meant to be copied and rewritten (zugferd.dtx:343-351), and the `.ins` generates only `zugferd.sty`, so `zugferd-invoice.sty` is not an installed package an emitter could just load. The published `zugferd` package itself (options, `\SetZUGFeRDData` keys, XML attachment) is a clean way and is proposed as `inv.zugferd`; the rest of the preamble and the letter commands map to existing ways.

## Blockers
- `BESPOKE/class` `\PrintInvoiceTabular`: stateful expl3 table builder (first-run flag that disables XML writing on later passes, per-rate accumulators zeroed by `\seq_map_inline`, `\noalign{\global\let\PrintTableCurrency...}` toggles) (zugferd-invoice.sty:106-151)
- `BESPOKE/class` `\PrintInvoiceItem`: rounds `amount * price`, adds into per-rate base and tax accumulators, branches between standard-rate and exempt-category rows, writes one XML item per row (zugferd-invoice.sty:188-216)
- `BESPOKE/class` `\PrintInvoiceTotal`: sums net, tax per rate, gross, writes tax entries and the monetary summation to the XML (zugferd-invoice.sty:153-184)
- `BESPOKE/class` `\InitVAT`, `\InitVATExempt`, `\AddInvoiceItem`: create floating-point registers and constant functions by name (`\fp_new:c`, `\cs_new:cn`) and collect items in a sequence for later replay (zugferd-invoice.sty:44-69, 79-86, 90-95)

## Class setting
- Class: `class.scrartcl` options: `parskip=half-`, `german` (DEMO-rechnung-zugferd.tex:26)
- Class-native vocabulary used: KOMA-Script `scrletter` package loaded by the style (zugferd-invoice.sty:32): `\setkomavar{invoice|date|title|firsthead}` (DEMO-rechnung-zugferd.tex:32-34; Kleinunternehmen.tex:79), `letter` environment with an address argument, `\opening`, `\closing` (DEMO-rechnung-zugferd.tex:75-77, 92); KOMA font elements `\newkomafont`, `\usekomafont` (zugferd-invoice.sty:104, 122-126). Page geometry, headers, footers and fonts are not set anywhere: all class defaults.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | DEMO-rechnung-zugferd.tex:26 | `class.scrartcl` | parskip=half-, german |
| paragraph spacing | DEMO-rechnung-zugferd.tex:26 | `class.scrartcl` (class option) | parskip=half- |
| PDF/A, version, language metadata | DEMO-rechnung-zugferd.tex:19-25 | `meta.documentmetadata` | `\RequirePackage{pdfmanagement}` then `\SetKeys[document/metadata]` with pdfversion=1.7, pdfstandard=a-3b, lang=de (the author uses it instead of `\DocumentMetadata`, comment at line 19; same key set, kernel family) |
| language | DEMO-rechnung-zugferd.tex:26; zugferd-invoice.sty:35 | `lang.babel` | class option german passed on to babel |
| e-invoice data and attached XML | DEMO-rechnung-zugferd.tex:28-30, 36-67; zugferd.dtx:437-492, 663-668, 930-975 | `inv.zugferd` | package option format=xrechnung3.0; `\SetZUGFeRDData{id=komavar, subject=komavar, fromaddress=komavar, unit=hour, seller/*, buyer/*, currency, payment-terms, due-date, payment-means/type, iban, account-holder, bic}`; Kleinunternehmen adds `tax/add-exemption-reason-auto` (Kleinunternehmen.tex:72) |
| printed access to the data | DEMO-rechnung-zugferd.tex:33, 75; Kleinunternehmen.tex:80-83 | `inv.zugferd` | `\InsertZUGFeRDData[set-today]{date}`, `[AddressData]{buyer}`, `\UseZUGFeRDAddressItem{seller}{taxid}`, `\InsertZUGFeRDData{payment-means/iban}` |
| letter frame | DEMO-rechnung-zugferd.tex:32-34, 75-77, 92-94 | `ltr.opening` | komavars invoice=2024:1337, title=Rechnung, date; `\opening`, `\closing`; Kleinunternehmen sets firsthead (Kleinunternehmen.tex:79-84) |
| item rows and totals table | zugferd-invoice.sty:106-151, 153-184, 188-216 | none (blocker `BESPOKE/class`) | five columns Pos., Std., Beschreibung, Einzelpreis, Gesamtpreis; sums netto, USt per rate, brutto |
| table float type | zugferd-invoice.sty:41, 113-119, 129-131 | `tbl.longtable` | `xltabular` over `\linewidth`, `\endhead`, `\endfoot` with a "Fortsetzung auf der nächsten Seite" line, `\endlastfoot` |
| table rules | zugferd-invoice.sty:42, 120, 127, 130-131, 147 | `tbl.booktabs` | `\toprule[\lightrulewidth]`, `\midrule[\heavyrulewidth]`, `\bottomrule` |
| column spec | zugferd-invoice.sty:88, 113-119, 130 | `tbl.tabular` | `@{}` ends, `r`, `\newcolumntype{P}{r<{\PrintTableCurrency}}`, `\multicolumn{5}{@{}p{\textwidth}@{}}` |
| numeric columns | zugferd-invoice.sty:115, 112 | `tbl.siunitx` | `S[round-mode=none]` amount column, table-number-alignment=right |
| number formatting | zugferd-invoice.sty:112, 201, 228, 242; zugferd.dtx:1318, 1325-1339 | `mark.siunitx` | `\sisetup{round-precision=2, round-mode=places, round-pad=false, minimum-decimal-digits=2, mode=text}`, `\num`, locale=DE under german |
| ragged description column | zugferd-invoice.sty:33, 116 | `sp.ragged` | `>{\RaggedRight}X` via `ragged2e` |
| table head font | zugferd-invoice.sty:104, 122-126 | `font.size-commands`, `mark.kernel` | `\small\itshape` (declared with `\newkomafont{tablehead}`) |
| continuation note | zugferd-invoice.sty:130 | `font.size-commands`, `sp.manual-space` | `\footnotesize`, `\hspace*{\fill}` |
| item number zero padding | zugferd-invoice.sty:44, 229 | `num.counters` | counter `invoiceitem`, `\renewcommand*{\theinvoiceitem}` printing a leading 0 below 10 |
| currency and VAT labels | zugferd-invoice.sty:97-102, 237-242 | `mark.siunitx` | strings Pos., Std., Beschreibung, Einzelpreis, Gesamtpreis, USt., Summe (Netto), Summe (Brutto); `\TableCurrency`=`\,€`; `\printVAT` |
| headers, footers, fonts, colour, geometry, floats, bibliography | whole zip | not used | scrartcl defaults; no package loads them |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\PrintInvoiceTabular`, `\PrintInvoiceItem`, `\PrintInvoiceTotal` | zugferd-invoice.sty:106-216 | no | expl3 fp accumulators, sequence replay, key-choice branching, global first-run state, XML writes in the same pass; `tbl.calctab` sums amounts but does not do per-rate VAT groups, a five-column xltabular layout or the XML calls |
| `\InitVAT`, `\InitVATExempt`, `\SetDefaultVAT` | zugferd-invoice.sty:49-69, 76 | no | `\fp_new:c`/`\cs_new:cn` build registers from a string; the calls are one-line string arguments but the definitions are code |
| `\AddInvoiceItem` | zugferd-invoice.sty:82-86 | no | stores the five arguments in a sequence read back later by the table builder |
| `\newcolumntype{P}` with `\PrintTableCurrency` toggled by `\noalign{\global\let...}` | zugferd-invoice.sty:88, 121, 128 | no (part of the table builder) | the column type alone is `tbl.tabular`; the toggles that print the currency only in body rows are global state |
| `\PrintSum`, `\PrintInvoiceSum`, `\PrintVatSum`, `\invoicesumvatname` | zugferd-invoice.sty:220-233 | yes as typeset rows, fed by the blocker above | `\multicolumn{1}{r}{label}` plus a right-aligned `\num` cell: `tbl.tabular`, `mark.siunitx` |
| `\InvoiceTabular*`, `\invoicesum*name`, `\TableCurrency`, `\printVAT` | zugferd-invoice.sty:97-102, 237-242 | yes | string aliases; `mark.siunitx` and plain text |
| `\newkomafont{tablehead}` | zugferd-invoice.sty:104 | yes | group wrapper `{\small\itshape ...}`: `font.size-commands`, `mark.kernel` |
| `\theinvoiceitem` redefinition | zugferd-invoice.sty:229 | yes alone | `num.counters`; its use inside the blocker stays |
| `\PrintPositionenVAT` | zugferd-invoice.sty:244-247 | yes, unused | old row command, never called by either sample |
| package options `format`, `default-vat` | zugferd-invoice.sty:17-24 | yes | `format` is `\PassOptionsToPackage{format=#1}{zugferd}`: the `inv.zugferd` option; `default-vat` is a string (initial 19) |
| `not-for-production` warning | zugferd-invoice.sty:26-30 | yes | prints a load-time warning, no typeset effect |

## Content-opaque
none that matters. Item rows, party addresses, bank data and the letter text are content. The XML attachment is written by `zugferd` itself (`\iow_open`, `\pdffile_embed_file:nnn`, zugferd.dtx:934, 959), with no external tool; `minted` appears only in the `.dtx` documentation driver (zugferd.dtx:39), not in the package, the style or the samples, so it is not an EXTERNAL blocker.

## Lib changes
- New ways proposed: `inv.zugferd`: package `zugferd` (CTAN and TeX Live, LPPL 1.3c; engine pdf by reading), `\usepackage[format=...]{zugferd}` and `\SetZUGFeRDData{key=value}` with `\InsertZUGFeRDData` and the `ZUGFeRD` environment; embeds a Factur-X/XRechnung XML invoice in the PDF. W1: released on CTAN and in TeX Live with a manual (zugferd.dtx documentation part). W2: package options are a choice (`format`: xrechnung3.0, xrechnung2.3, basic, minimum) and booleans/strings (`zugferd`, `write-xml`, `xml-file`, `auto-exemption`, `unknown-value-warning`, zugferd.dtx:437-537); the data are keys (document-type, id, date, currency, seller/*, buyer/*, payment-means/*, unit, tax/*). W3: serves any German or EU e-invoice, not one document. W4: preamble `\usepackage` plus `\SetZUGFeRDData`, body `\InsertZUGFeRDData` wrappers. Limit: the per-item and per-sum XML calls (`\zugferd_write_Item:...`, zugferd.dtx:1269-1275) must be made by the invoice package the author writes (zugferd.dtx:1859), so the way covers the data and the attachment, not a visible invoice layout.
- Considered and not proposed: treating `zugferd-invoice.sty` as a published whole-invoice way like `inv.simpleinvoice`. Reasons: it is documentation example code "not to be used in production" (zugferd.dtx:343-351), `zugferd.ins` builds only `zugferd.sty` (zugferd.ins:13-17), the CTAN page does not list it, and its behaviour is changed by editing it (W2). A reviewer who counts it as published would turn the verdict to yes; I did not, because a wrong yes costs more.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
