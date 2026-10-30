yes

# 0555-yet-another-invoice-template: Yet Another Invoice Template

- Unverified: read from the source, not compiled.
- Source: Source/0555-yet-another-invoice-template/ (origin: https://latextemplates.com/downloads/yet-another-invoice-template.zip; licence: CC0-1.0 per the manifest; the zip ships no licence file, and the comment at main.tex:1 says "CC0 upstream")
- Kind: invoice
- Lib: v4
- Engine: pdfLaTeX-compatible (article, geometry, xcolor, array, tabularx and `helvet` all run under pdfTeX; no `fontspec`, no shell escape, no external tool)
- Look carried by: preamble (the zip is one 42-line `main.tex` and nothing else; no zip-local class or style; the look is the package lines at main.tex:3-9 plus hand-laid body blocks and tables at main.tex:11-41)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The whole zip is `article` plus seven published or kernel packages and commands: `geometry`, `xcolor[table]`, `array`, `tabularx`, `helvet`, the kernel page style and kernel spacing, alignment and font commands. The sample has no `\newcommand`, `\def`, environment, counter, conditional or drawing, so there is no bespoke code and no `ART`. Every component maps to an existing lib way, and no way is proposed. The invoice look comes from generic table ways (`tbl.tabularx`, `tbl.colortbl`), not from an `inv.*` package.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:3). The class is a kernel class, not in the zip; its source was not read.
- Class-native vocabulary used: none of the front-matter vocabulary. The sample has no `\maketitle`, `\title`, `abstract` environment or `\section`; the title block is hand-laid (main.tex:11-16). The only class-adjacent command is the kernel `\today` (main.tex:14).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:3 | `class.article` | `a4paper` |
| paper size | main.tex:3 | `page.class-options` | `a4paper` |
| page geometry | main.tex:4 | `page.geometry` | `margin=22mm` (all four margins) |
| colour package | main.tex:5 | `color.xcolor` | `\usepackage[table]{xcolor}`; the `table` option also loads the `tbl.colortbl` row and rule colours |
| named colour | main.tex:9 | `color.xcolor` | `\definecolor{invoicegray}{gray}{0.18}` |
| colour use in text and cells | main.tex:12, 25 | `color.xcolor` | `\color{invoicegray}`, `\color{white}` (colour switches inside a group and inside four cells) |
| tint mix | main.tex:23 | `color.xcolor` | `gray!7` (xcolor mixing expression) beside `white` |
| text face | main.tex:7 | `font.helvet` | `\usepackage{helvet}` (Helvetica-compatible sans through PSNFSS) |
| default family | main.tex:7 | `font.family-default` | `\renewcommand{\familydefault}{\sfdefault}`, so the whole page is sans |
| header and footer | main.tex:8 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no running head, no page number) |
| title block "INVOICE" | main.tex:11-16 | `sp.ragged` | `flushright` environment around the block; no `\maketitle`; the same block also holds the number, date and terms lines in the next rows of this table |
| title size and weight | main.tex:12 | `font.size-commands`, `mark.kernel` | `\Huge`; `\bfseries` (a kernel font switch) |
| title gap and line breaks | main.tex:12-15 | `sp.manual-space` | `\par\medskip`, then `\\` between the invoice number, issue date and terms lines |
| invoice number, date, terms | main.tex:13-15 | content | text lines; `\today` (main.tex:14) is a kernel command that prints the compile date, a field value with no parameter, not a layout choice |
| vertical gaps between blocks | main.tex:17, 22, 30 | `sp.manual-space` | `\vspace{8mm}`, `\vspace{12mm}`, `\vspace{7mm}` |
| parties table (seller left, client right) | main.tex:18-21 | `tbl.tabularx` | `tabularx` at `\linewidth`, spec `@{}Xr@{}`: one stretching column `X`, one right-aligned `r`, no outer padding; `\tabularnewline` ends the first row (main.tex:19) |
| column spec of the same table | main.tex:6, 18 | `tbl.tabular` | `array` package loaded (`\usepackage{array,tabularx}`); `@{}` and `r` are `array` column vocabulary |
| bold party labels | main.tex:19 | `mark.kernel` | `\textbf` |
| line-item table | main.tex:24-29 | `tbl.tabularx` | `tabularx` at `\linewidth`, spec `@{}Xrrr@{}`: description stretches, three right-aligned numeric columns; rows end with `\\`; no `\\` on the last row |
| zebra row colours | main.tex:23 | `tbl.colortbl` | `\rowcolors{2}{gray!7}{white}` (alternating fill from row 2; defined by `xcolor[table]`) |
| header row fill and text | main.tex:25 | `tbl.colortbl`, `color.xcolor`, `mark.kernel` | `\rowcolor{invoicegray}`; `\color{white}` in each cell; `\textbf` on each heading |
| totals block aligned right | main.tex:31-38 | `sp.ragged` | `flushright` environment around the totals table |
| totals table | main.tex:32-37 | `tbl.tabular` | `tabular` spec `lr`: label left, amount right; `\hline` above the total row (main.tex:35) |
| total rule colour | main.tex:35 | `tbl.colortbl` | `\arrayrulecolor{invoicegray}` before `\hline` (the colour applies to rules from that point on in this table) |
| bold total row | main.tex:36 | `mark.kernel` | `\textbf` on label and amount |
| push closing note to the page foot | main.tex:39 | `sp.manual-space` | `\vfill` |
| closing note | main.tex:40-41 | content | plain paragraph text (thank-you line, payment instruction, contact address) |

## Bespoke code
none. The sample has no `\newcommand`, `\renewcommand` of a zip-local macro, `\def`, `\newenvironment`, counter or conditional. The one `\renewcommand` (main.tex:7) sets the kernel parameter `\familydefault`, which is the lib way `font.family-default`, not zip-local code. `\definecolor` (main.tex:9) is a published declaration.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- considered: the lib's invoice ways `inv.simpleinvoice`, `inv.invoice2` and `tbl.calctab` are invoice packages in the lib, but this sample loads none of them; its tables are hand-set with `tabularx` and `tabular`, and the amounts are typed, not computed.

## Notes
- No text addressed to an AI was found in the zip (the two comment lines at main.tex:1-2 address the template user: replace the fictional details before sending).
- Missing assets: none (no images, no fonts shipped or needed; `helvet` is in TeX Live).
- The totals (main.tex:26-28, 33-36) are typed numbers in table cells, so they are content; nothing in the sample computes a sum.
