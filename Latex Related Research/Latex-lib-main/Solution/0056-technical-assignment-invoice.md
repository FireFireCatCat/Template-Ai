yes

# 0056-technical-assignment-invoice: Technical Assignment Invoice

- Unverified: read from the source, not compiled.
- Source: Source/0056-technical-assignment-invoice/ (origin: https://latextemplates.com/downloads/technical-assignment-invoice.zip; licence: not established. The manifest says "Other (as stated in the work)"; README.md:12-14 says the upstream gallery (Philip Trauner, Overleaf, README.md:10-12) does not expose a standard licence)
- Kind: invoice
- Lib: v1
- Engine: pdfLaTeX-compatible (README.md:7 "Compile with PDFLaTeX"; main.tex:3-5 `T1`, `utf8`, `lmodern`; the `simpleinvoice` source was not read, so this rests on the README)
- Look carried by: preamble (the zip is `main.tex` plus a README, with no zip-local class or style; the published, unbundled package `simpleinvoice` loaded at main.tex:6 draws the whole invoice from the declarative `\set...` values at main.tex:9-26 and `\makeinvoice` at main.tex:30)
- Class origin: tex-distribution-unbundled (kernel `article`, main.tex:1; not in the zip)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The zip adds no class, style, macro or environment of its own: `main.tex` (31 lines) loads kernel `article`, `geometry`, `fontenc`/`inputenc`, `lmodern` and the published `simpleinvoice` package, then feeds it strings through its `\set...` and `\additem` commands and calls `\makeinvoice`. `simpleinvoice` is on CTAN (ctan.org/pkg/simpleinvoice: author Mathias Lohne, GPL-3, listed under `/macros/latex/contrib/simpleinvoice`), so it passes W1, and it passes W2 to W4 as a package chosen by string values that an emitter writes as one `\usepackage`, a run of setter calls and one `\makeinvoice`. The lib has no invoice way, so one is proposed as `inv.simpleinvoice`. The caveat is that the package's own source was not read (it is not bundled, README.md:7-8, and no TeX tree is on this machine), so its internals and the exact command set are taken from the CTAN page and the README, not from code.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:1). Kernel class, not bundled, source not read.
- Class-native vocabulary used: none. The sample never calls `\maketitle`, `abstract` or `\section`; the whole page body is `\makeinvoice` (main.tex:30).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | a4paper |
| paper size | main.tex:1 | `page.class-options` | a4paper |
| page geometry | main.tex:2 | `page.geometry` | margin=1.8cm (all four sides) |
| font encoding and input | main.tex:3-4 | `font.fontenc-t1` | fontenc T1; inputenc utf8 |
| text font | main.tex:5 | `font.lmodern` | `lmodern`, no options |
| invoice engine (load) | main.tex:6 | `inv.simpleinvoice` | `\usepackage{simpleinvoice}`, no options |
| header and footer off | main.tex:7 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (the package's own footer, mentioned at main.tex:27-28, is drawn by `\makeinvoice`; its source was not read) |
| invoice title and number | main.tex:9-10 | `inv.simpleinvoice` | `\setinvoicetitle{Technical assignment invoice}`, `\setinvoicenumber{TA--2026--018}` (en-dash ligatures typed `--`) |
| recipient block | main.tex:11-12 | `inv.simpleinvoice` | `\setreceivername{...}`, `\setreceiveraddress{... \\ ...}` (line break typed `\\` inside the string) |
| sender (issuer) block | main.tex:13-16 | `inv.simpleinvoice` | `\setname`, `\setaddress{multi-line}{single-line with ' / '}` (two arguments; the second reads as the one-line form, inferred from its text, not from source), `\setphonenumber`, `\setemail` |
| references, date, terms | main.tex:17-20 | `inv.simpleinvoice` | `\setyourref`, `\setourref`, `\setinvoicedate`, `\setdeadline{30}` (a number, presumably days to pay) |
| line-item table | main.tex:21-22 | `inv.simpleinvoice` | two `\additem{description}{unit price}{quantity}{line total}` calls; the package lays out the rows |
| totals block | main.tex:23-25 | `inv.simpleinvoice` | `\setsubtotal`, `\setvat`, `\settotal` (strings, no computation by the sample) |
| payment details | main.tex:26 | `inv.simpleinvoice` | `\setaccountnumber{Account 0042042}` |
| render the invoice | main.tex:30 | `inv.simpleinvoice` | `\makeinvoice` (body, once) |
| overfull-box tolerance | main.tex:29 | `sp.lengths` | `\hfuzz=3pt`, a raw TeX length parameter set before `\makeinvoice` (comment at main.tex:27-28: the package footer is 2.2pt wider than the text block in the pinned version) |

Components the sample does not use and the zip does not define: headings, lists, quotes, theorems, floats, captions, code, bibliography, index, cross-references, language, colour, hyperlinks, metadata.

## Bespoke code
none. There is no `\newcommand`, `\def`, environment, counter or conditional in the zip. `\hfuzz=3pt` (main.tex:29) is a raw parameter assignment, reduced to `sp.lengths`. The README's "adapted simpleinvoice library" (README.md:12-15) is the upstream Overleaf original; this starter says it does not bundle it, and no such file is in the zip.

## Content-opaque
none. The sender, recipient, items and amounts are content strings; none is a figure, table float or drawing.

## Lib changes
- New ways proposed: `inv.simpleinvoice` (package `simpleinvoice`, pdfLaTeX; one-way for the invoice doc-kind, where the package lays out the title, parties, item rows, totals and bank line).
  - W1 Published: on CTAN (ctan.org/pkg/simpleinvoice, GPL-3, author Mathias Lohne) and provided by the pinned TeX image (README.md:7-8). Caveat: the CTAN page did not list `\setinvoicetitle` or `\additem` by name, and README.md:12-15 says the upstream gallery version was an adapted library. This starter says it uses the image's package, and main.tex:27-28 refers to a "pinned class version", so the way is accepted as the published one; if the pinned package turned out to be a non-CTAN fork, W1 would fail and the verdict would be `no`.
  - W2 Declarative: the behaviour is chosen by the string values of the `\set...` commands and `\additem` arguments, not by editing its code.
  - W3 Generic: it serves any invoice (the sample's fictional content has nothing specific to this document).
  - W4 Printable: an emitter writes `\usepackage{simpleinvoice}` in the preamble, then the setters and `\additem` rows and one `\makeinvoice` in the body.
  - Grep of `_Lib.md` for `invoice` found nothing; `ltr.opening` (letters and letterheads) and `front.class-native` (a class's own commands) do not cover a package that lays out a whole invoice page.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
