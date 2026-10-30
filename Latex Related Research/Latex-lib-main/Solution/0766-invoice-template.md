yes

# 0766-invoice-template: Invoice Template (letter-based invoice)

- Unverified: read from the source, not compiled.
- Source: Source/0766-invoice-template/ (origin: https://latextemplates.com/downloads/invoice-template.zip; licence: "Other (as stated in the work)" per the manifest; README.md:12-14 says the upstream example may be distributed if its referral is kept, not otherwise established)
- Kind: invoice
- Lib: v6
- Engine: pdfLaTeX-compatible (`T1` + `inputenc` utf8 + `lmodern` at main.tex:3-5; README.md:8 says "Compile with PDFLaTeX")
- Look carried by: preamble (no zip-local class or style; the kernel `letter` class supplies the letter blocks, and page margins, header/footer, colour and the item table are set in main.tex:2-20 and 27-42)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; the zip holds only main.tex and README.md)
- Read: main yes (all 48 lines), zip-local classes and styles none present

## Verdict
Yes. The whole look is one kernel class (`letter`) plus nine published packages, set by options, lengths, a colour and kernel commands, and the item table is a plain `tabular` with `booktabs` rules. The zip defines no macro, environment, counter or conditional of its own, draws nothing, and needs no tool outside TeX. No invoice package is loaded (README.md:13-14 says the upstream `invoice` package is not bundled), so no `inv.*` way is involved.

## Blockers
none

## Class setting
- Class: `class.letter` options: `a4paper` (main.tex:1)
- Class-native vocabulary used: `\signature` (main.tex:13), `\address` (main.tex:14), `\date` (main.tex:15), `letter` environment with the recipient block as its argument (main.tex:22, 47), `\opening` (main.tex:23), `\closing` (main.tex:46). The class source is not in the zip and was not read.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.letter` | a4paper |
| paper size | main.tex:1 | `page.class-options` | a4paper |
| page geometry | main.tex:2 | `page.geometry` | margin=2cm |
| encoding and font | main.tex:3-4 | `font.fontenc-t1` | fontenc T1; inputenc utf8 |
| text face | main.tex:5 | `font.lmodern` | lmodern, no options |
| colour package | main.tex:6 | `color.xcolor` | no options |
| named colour | main.tex:12 | `color.xcolor` | `\definecolor{invoiceblue}{HTML}{315A7D}` |
| header and footer | main.tex:9, 16-17 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}` clears all fields |
| header field | main.tex:18 | `hf.fancyhdr` | `\fancyhead[R]{...}`, content "INVOICE 2026--042" |
| header text colour | main.tex:18 | `color.xcolor` | `\color{invoiceblue}` inside the header field |
| header text weight | main.tex:18 | `mark.kernel` | `\textbf` |
| footer field | main.tex:19 | `hf.fancyhdr` | `\fancyfoot[C]{...}`, text with a middle dot (U+00B7, read through `inputenc`) |
| header rule | main.tex:20 | `hf.fancyhdr` | `\renewcommand{\headrulewidth}{0.4pt}` (a documented fancyhdr length) |
| link look | main.tex:10-11 | `meta.hyperref` | `\hypersetup{hidelinks}` |
| mail link | main.tex:14 | `meta.hyperref` | `\href{mailto:...}{...}` (another command of the package loaded at main.tex:10; an external link, not a cross-reference) |
| sender block | main.tex:14 | `ltr.opening` | `\address{line\\line\\line\\\href{..}{..}}` |
| signature block | main.tex:13 | `ltr.opening` | `\signature{Morgan Reed\\Harbor Light Studio}`, printed by `\closing` |
| letter date | main.tex:15 | `ltr.opening` | `\date{15 September 2026}`, a literal string |
| recipient block | main.tex:22 | `ltr.opening` | `\begin{letter}{name\\street\\city}` |
| opening line | main.tex:23 | `ltr.opening` | `\opening{...}`, argument is the invoice subject (content) |
| closing | main.tex:46 | `ltr.opening` | `\closing{Kind regards,}` |
| line breaks in blocks | main.tex:13-14, 22 | `sp.manual-space` | `\\` |
| vertical gap | main.tex:26 | `sp.manual-space` | `\vspace{8pt}` |
| centred table block | main.tex:27, 42 | `sp.ragged` | kernel `center` environment (same kernel alignment family as `\centering`) |
| table row height | main.tex:28 | `tbl.tabular` | `\renewcommand{\arraystretch}{1.35}` (documented `array` parameter) |
| item table | main.tex:7, 29-41 | `tbl.tabular` | `array` package loaded; `tabular` column spec `{p{0.47\linewidth} r r r}` |
| table rules | main.tex:8, 30, 32, 36, 39 | `tbl.booktabs` | `\toprule`, `\midrule` (twice), `\bottomrule`; a data row follows `\bottomrule` at main.tex:40, still plain `tabular` rows |
| table header and total cells | main.tex:31, 37, 40 | `mark.kernel` | `\textbf` |
| table body | main.tex:33-35, 38 | `tbl.tabular` | rows of text and numbers (content); `\%` is an escaped character; no `\multicolumn` or `\multirow` |
| body paragraphs | main.tex:24-25, 43-45 | none | running text, content |

## Bespoke code
none. Checked: main.tex has no `\newcommand`, `\renewcommand` of a zip-defined macro, `\def`, `\newenvironment`, `\newcounter`, `\newif` or `\newlength`. The only `\renewcommand` lines (main.tex:20, 28) set the fancyhdr length `\headrulewidth` and the array parameter `\arraystretch`, both published parameters. `\definecolor` (main.tex:12), `\signature`, `\address` and `\date` (main.tex:13-15) are published commands with string or colour values.

## Content-opaque
none

## Notes
- Not checked, class source absent: the kernel `letter` class may switch the first page to an empty page style when `\address` is set, so the fancyhdr header and footer (main.tex:16-20) might print only from page 2. This changes nothing for recovery: an emitter that writes the same preamble and body gets the same behaviour.
- The numbers in the table (rate, units, amount, VAT 8%, totals) are typed values, not computed; no `calctab`, `siunitx` or `fp` code is involved.
- No text addressed to an AI was found in main.tex or README.md.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
