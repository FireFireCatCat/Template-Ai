yes

# 0612-wile-e-invoice: Wile E. Invoice (usgc-invoice class)

- Unverified: read from the source, not compiled.
- Source: Source/0612-wile-e-invoice/ (origin: https://latextemplates.com/downloads/wile-e-invoice.zip; licence: BSD-3-Clause per the manifest and main.tex:2; the zip holds no LICENSE file)
- Kind: invoice
- Lib: v5
- Engine: pdfLaTeX-compatible (main.tex:2 says pdflatex; no fontspec; the only e-TeX primitive is `\dimexpr` at usgc-invoice.cls:27, which pdfTeX has)
- Look carried by: zip-local (usgc-invoice.cls defines the whole look; main.tex has no preamble and only calls the class macros)
- Class origin: zip-local (ctan.org/pkg/usgc-invoice returned 404; the zip comes from latextemplates.com, not from the publisher's own page, so it is not treated as an official release; the verdict does not change if it were)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (usgc-invoice.cls, 109 lines, read in full)

## Verdict
The zip is two files: a 40-line sample and a 109-line class that is `\LoadClass{article}` plus `geometry`, `longtable`, `xcolor` and a set of `\newcommand`/`\newenvironment` wrappers. Every wrapper only emits `tabular`/`longtable` rows, `\hline`, `\vspace`, `\hfill`, `\raisebox` and `\textbf`, so each one reduces by inline expansion to lib ways with the arguments as content. There is no TikZ, no output-routine code, no kernel-internal redefinition and no external tool, so the answer is yes. Two oddities (an unclosed `\center` and a hand counter for row numbers) are recorded below and both reduce.

## Blockers
none

## Class setting
- Class: `class.article` (loaded by the zip-local class at usgc-invoice.cls:2, no options; `\documentclass{usgc-invoice}` at main.tex:5 passes none and the class declares and processes none)
- Class-native vocabulary used: none from article (no `\maketitle`, no sectioning, no abstract); the sample uses only the zip-local macros `\header`, `company`, `\order`, `orderTable`, `\N`, `\totals`, `\footer` (main.tex:9, 13, 20, 24, 25, 28, 38), which are bespoke and decomposed below

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | usgc-invoice.cls:2 | `class.article` | no options (default 10pt, one column); the zip-local wrapper class is decomposed, not a way |
| page geometry | usgc-invoice.cls:4 | `page.geometry` | letterpaper, margin=1in |
| default font family | usgc-invoice.cls:8 | `font.family-default` | `\familydefault` set to `\ttdefault` (monospace for the whole document; no font package, no `fontenc`) |
| colour package | usgc-invoice.cls:6 | `color.xcolor` | load-only, no options; no colour command is used anywhere in the zip (grep) |
| issuer address block | usgc-invoice.cls:17-24, 40 | `tbl.tabular`, `mark.kernel` | `tabular[t]` with `@{}l@{}`, four lines, first line `\textbf`; text is fixed content of the class |
| invoice data box | usgc-invoice.cls:26-36; main.tex:9-11 | `tbl.tabular`, `sp.manual-space`, `mark.kernel` | `tabular` with `\|ll\|`, `\hline` top and bottom (cls:29, 33), bold labels (cls:30-32); `\raisebox{\dimexpr-\height+\ht\strutbox}[0pt][0pt]` (cls:27) |
| header line layout | usgc-invoice.cls:38-44 | `sp.manual-space`, `sp.lengths` | `\noindent`, `\hfill` between address and data box (cls:39, 41), `\vspace{20pt}` (cls:43) |
| billed-to block | usgc-invoice.cls:46-55; main.tex:13-18 | `sp.lengths`, `sp.manual-space`, `mark.kernel` | group with `\parindent`=0pt (cls:48), `\obeylines` so each source line ends a line (cls:49), `\noindent`, bold "Billed To:" (cls:51), `\vspace{22pt}` after (cls:54) |
| order info block | usgc-invoice.cls:57-66; main.tex:20-22 | `tbl.tabular`, `sp.lengths`, `sp.manual-space` | `tabular` with `@{}ll@{}`, three rows (cls:60-64), `\noindent`, `\vspace{10pt}` (cls:65) |
| order table | usgc-invoice.cls:68-80; main.tex:24-36 | `tbl.longtable`, `tbl.tabular`, `mark.kernel` | `longtable` column spec `r l p{3in} @{\hspace{24pt}} r r r` (cls:74); title row `\multicolumn{6}{c}{\textbf{Order ...}}` (cls:75); bold header row (cls:76); `\hline` (cls:77); no `\endhead`, no caption |
| row numbering | usgc-invoice.cls:11-15, 70; main.tex:25-27 | `num.counters` | `\newcounter{linenum}`, `\stepcounter` and `\thelinenum` printed in the first cell; `\setcounter{linenum}{0}` at table start |
| totals rows | usgc-invoice.cls:82-98; main.tex:28-35 | `tbl.tabular`, `mark.kernel` | `\multicolumn{5}{r}{label}` plus amount cell; `\hline` (cls:83, 86, 94, 96), `\hline\hline` (cls:89); bold Total and Balance (cls:90, 97); two empty `\multicolumn{6}{r}{}` spacer rows (cls:91, 93); fixed centred text "Invoice Status: P A I D" (cls:92) |
| footer block | usgc-invoice.cls:100-108; main.tex:38 | `tbl.tabular`, `sp.ragged`, `sp.lengths` | `\noindent`, `tabular` `@{}ll@{}` with "Payment Method:" (cls:102-104); three bare `\center` calls for `***`, thank-you line and company name (cls:105-107) |
| page style | not set; article default | none defined | no `\pagestyle`, header or footer in either file (grep) |

Not defined or used by this zip: sectioning, abstract, lists, quotes, notes, footnotes, math, theorems, floats and captions, code, bibliography, index, cross-references, language setup, hyperref.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\N` and counter `linenum` | usgc-invoice.cls:11-15, 70 | yes | an alias of kernel `\stepcounter{linenum}\thelinenum`; the emitter writes the row index as cell content (`tbl.longtable`), or the same kernel counter commands (`num.counters`); it only prints a number and changes no layout |
| `\USGCAddress` | usgc-invoice.cls:17-24 | yes | a literal `tabular[t]`, `@{}l@{}` (`tbl.tabular`); the four lines are fixed content |
| `\invoiceData` | usgc-invoice.cls:26-36 | yes | literal `\raisebox{...}[0pt][0pt]{tabular \|ll\|}` (`sp.manual-space`, `tbl.tabular`); `\dimexpr` is a length value for the raise argument, not code that computes layout |
| `\header` | usgc-invoice.cls:38-44 | yes | alias: `\noindent`, address, `\hfill`, data box, `\vspace{20pt}` written inline |
| `company` environment | usgc-invoice.cls:46-55 | yes | `\parindent`=0pt, bold "Billed To:" and one line per address line (explicit paragraphs or `\\`), then `\vspace{22pt}`; `\obeylines` only turns each source line end into a break (kernel family of `sp.manual-space`), so the emitter writes the breaks directly |
| `\order` and stored `\orderNumber` | usgc-invoice.cls:57-66 | yes | `\def` stores a string that `orderTable` reuses as its default argument (cls:68); the emitter writes the string into the title row (cls:75) by inline substitution; no conditional |
| `orderTable` environment | usgc-invoice.cls:68-80 | yes | `\begin{longtable}{r l p{3in} @{\hspace{24pt}} r r r}` plus the two header rows and `\hline` as the opening, `\end{longtable}` as the closing |
| `\totals` | usgc-invoice.cls:82-98 | yes | seven arguments fill fixed `\multicolumn`/`\hline` rows; expand inline (`tbl.tabular`) |
| `\footer` | usgc-invoice.cls:100-108 | yes | a `tabular` then three centred lines. The class calls `\center` three times and never closes it with `\endcenter`; the emitter may write the same kernel calls or a proper `center` environment (`sp.ragged`); the vertical glue can differ between the two and compile behaviour of the unclosed form is not established here (nothing compiled) |
| `\ProvidesClass`, `\LoadClass`, `\RequirePackage` | usgc-invoice.cls:1-6 | yes | collapse to `\documentclass{article}` and three `\usepackage` lines (`geometry`, `longtable`, `xcolor`) |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and not used: `inv.simpleinvoice` and `inv.invoice2` (published invoice packages with their own layout; this zip loads neither, and its look is hand-set `tabular`/`longtable` code that the existing table ways already cover).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
