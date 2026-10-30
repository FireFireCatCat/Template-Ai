yes

# 0858-us-csv-invoice: US CSV Invoice

- Unverified: read from the source, not compiled.
- Source: Source/0858-us-csv-invoice/ (origin: https://latextemplates.com/downloads/us-csv-invoice.zip; licence: LPPL-1.3)
- Kind: invoice
- Lib: v6
- Engine: pdfLaTeX-compatible (main.tex:5-6 says no fontspec; the class source was not read, and the CTAN page names no engine)
- Look carried by: class (the whole page is `\printinvoice` of the published `invoice-class`; the zip adds only setter values, a three-line config file and a CSV data file)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds no .cls or .sty; its one zip-local code file, invoice.cfg, was read in full; the class is not bundled and its source was not read)

## Verdict
The sample is `\documentclass{invoice-class}` plus class-native setter commands and one `\printinvoice` (main.tex:12-36). `invoice-class` is a published class (ctan.org/pkg/invoice-class read: Alan Munn, LPPL 1.3, v1.0, in TeX Live and MiKTeX), so it is one `class.*` way and W1 holds. The zip defines no macro, environment, counter or drawing of its own: invoice.cfg holds three class setter calls with string values (invoice.cfg:5-13) and invoice.csv is data (invoice.csv:1-5). So every item reduces to class settings plus two companion files. The yes rests on the class being published: its own source was not read, so its internal layout and package list are taken from the CTAN page and the sample's comments (main.tex:1-11), not from the code.

## Blockers
none

## Class setting
- Class: `class.invoice-class` options: none (main.tex:12)
- Class-native vocabulary used: preamble setters `\InputFile{file}` (main.tex:14), `\waybill` (main.tex:15), `\shippingdate` (main.tex:16), `\toaddress` (main.tex:21-26), `\destination` (main.tex:27), `\carrier` (main.tex:28), `\weight{}{}` (main.tex:29), `\packages` (main.tex:30), `\packingcost` (main.tex:31), `\shippingcost` (main.tex:32), `\insurancecost` (main.tex:33); config-file setters `\fromaddress` (invoice.cfg:5-11), `\shipper` (invoice.cfg:12), `\location` (invoice.cfg:13); body command `\printinvoice` (main.tex:36), which prints the whole invoice from the CSV rows. The class is described on CTAN as "a standard US commercial invoice from a CSV file", multi-page, with configurable shipping addresses.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:12 | `class.invoice-class` | no options |
| page geometry, fonts, colour, header/footer, spacing, table styling, totals layout | main.tex:12-37 (the sample sets none of these; no `\usepackage`) | `class.invoice-class` | all defined inside the class (not read); no parameters given in the zip |
| item table and invoice body | main.tex:35-37 | `class.invoice-class` | body is `\printinvoice` alone; one row per CSV record, layout fixed by the class |
| data file load (database from CSV, one body per record) | main.tex:14; invoice.csv:1-5; main.tex:8-11 (comment says the class uses `\DTLloaddb` and `\DTLforeach`) | `struct.datatool` | class-internal, second-hand from the comment (class source not read); file = invoice.csv, columns Description, Country, Quantity, UnitValue, Amount |
| waybill number and shipping date | main.tex:15-16 | `front.class-native` | `\waybill{WB-2026-08412}`, `\shippingdate{2026-08-27}` (strings) |
| sender block | invoice.cfg:5-13 | `front.class-native` | `\fromaddress{...}` (five lines), `\shipper{M. Alvarez, Export Manager}`, `\location{Eugene, OR}` (strings) |
| recipient block, destination, carrier | main.tex:21-28 | `front.class-native` | `\toaddress{...}` (four lines), `\destination{Canada}`, `\carrier{Pacific Freight Lines}` (strings) |
| shipment figures | main.tex:29-30 | `front.class-native` | `\weight{412}{8}`, `\packages{6}` (numbers) |
| extra charges | main.tex:31-33 | `front.class-native` | `\packingcost{35.00}`, `\shippingcost{210.00}`, `\insurancecost{24.64}` (numbers; how the class totals them was not read) |
| line breaks inside address strings | main.tex:22-25; invoice.cfg:6-10 | `sp.manual-space` | `\\` at each line end (including the last line, main.tex:25, invoice.cfg:10) |
| companion config file `invoice.cfg` | invoice.cfg:1-13; main.tex:17-20 (comment: the class re-asserts its placeholder defaults after `\begin{document}` when this file is absent) | `class.invoice-class` | emitter writes the file next to main.tex with the three setters above |
| document body | main.tex:35-37 | `class.invoice-class` | `\begin{document}\printinvoice\end{document}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `invoice.cfg` (three setter calls) | invoice.cfg:5-13 | yes | no macro logic: only `\fromaddress`, `\shipper`, `\location` with string arguments. The emitter writes it as a companion file because the class loads it by its own hook (main.tex:17-20; the hook is class code, not read). The setters could not simply move into the preamble (the comment says the class overrides them after `\begin{document}` without the file). |
| `invoice.csv` | invoice.csv:1-5 | yes (data) | a header row and four item rows; content, shipped as an asset |
| `\newcommand`, `\def`, environments, counters, conditionals | main.tex:12-37, invoice.cfg:1-13 | none present | the zip defines none |

## Content-opaque
none (the item rows, addresses, numbers and dates are content; there is no figure, TikZ or image)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
