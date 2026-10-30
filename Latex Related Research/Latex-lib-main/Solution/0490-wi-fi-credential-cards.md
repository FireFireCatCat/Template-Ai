yes

# 0490-wi-fi-credential-cards: Wi-Fi Credential Cards

- Unverified: read from the source, not compiled.
- Source: Source/0490-wi-fi-credential-cards/ (origin: https://latextemplates.com/downloads/wifi-credential-cards.zip; licence: MIT, as stated in the manifest and in main.tex:1)
- Kind: misc (an A4 sheet of ten business-card-sized Wi-Fi cards, 2 columns x 5 rows; the manifest hint is "Business Cards")
- Lib: v4
- Engine: pdfLaTeX-compatible (main.tex:6 says no fontspec; the CTAN page for `fontawesome` lists Type1 fonts, so it needs no fontspec under pdfTeX; the CTAN page for `qrcode` does not state engine support, so this rests on the sample's own comment and is not verified)
- Look carried by: preamble (bare `article` plus three packages; the card face is the `\wificard` macro defined in the preamble at main.tex:24-39, and the sheet is a body table at main.tex:44-50)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; the zip holds this one file)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The zip is one 51-line `main.tex` on the kernel `article` class. Every part of it is a kernel command or a published package: `geometry`, `fontawesome`, `qrcode`, `minipage`, `tabular` and `\fbox`. The three `\newcommand` data strings and the `\wificard` macro have no counters, conditionals or loops, so they reduce by inline expansion. `tikz` is loaded but never used, so there is no artwork. The one component the lib lacked is the QR graphic; I propose `fig.qrcode` for it and argue W1 to W4 below. Nothing was compiled.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:13). The class source was not read: it ships with the TeX distribution and is not in the zip.
- Class-native vocabulary used: only `\documentclass`, `\begin{document}` and `\end{document}` (main.tex:13, 41, 51). The sample uses no `\maketitle`, abstract or sectioning command.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:13 | `class.article` | option `a4paper` |
| paper size | main.tex:13 | `page.class-options` | `a4paper` |
| page geometry | main.tex:14 | `page.geometry` | `margin=0.6cm` on all four sides |
| header and footer | main.tex:18 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| icon glyphs | main.tex:15, 34, 35 | `font.icons` | package `fontawesome`; `\faWifi` and `\faKey` as the row labels of the credentials table |
| QR code graphic | main.tex:16, 30 | `fig.qrcode` | package `qrcode`; `\qrcode[height=2.6cm]{<payload string>}`; the payload is content, held as a string (line 30) |
| `tikz` load | main.tex:17 | none (load only) | no `tikzpicture`, `\tikz`, `\node` or `\draw` appears in the file (checked with grep), so there is no printed effect to map |
| card box | main.tex:25, 38 | `box.minipage` | `\begin{minipage}[t][5.3cm][t]{8.4cm}`: top-aligned, height 5.3cm, inner position top, width 8.4cm |
| centred card content | main.tex:26 | `sp.ragged` | `\centering` |
| card vertical spacing | main.tex:27, 28, 29, 30 | `sp.manual-space` | `\vspace{0.2cm}`, then line breaks `\\[0.1cm]`, `\\[0.2cm]`, `\\[0.2cm]` |
| card heading and subheading type | main.tex:28, 29 | `font.size-commands`, `mark.kernel` | `\large` with `\bfseries` on the heading (28); `\small` on the subheading (29) |
| credentials table | main.tex:31-37 | `tbl.tabular` | `tabular{ll}` with two rows (icon, value); `\tabcolsep` set to 4pt (32); the whole table in a `\large` group (31, 37) |
| credential values in monospace | main.tex:34, 35 | `mark.kernel` | `\texttt{...}` (kernel font switch; no font package is loaded for it) |
| card frame | main.tex:43, 45-49 | `box.fancybox` | kernel `\fbox{...}` around each card, `\fboxsep` set to 2pt (43) |
| paragraph indent off | main.tex:42 | `sp.lengths` | `\noindent` before the grid; it is the per-paragraph form of `\parindent`, so I file it with the raw paragraph-shape parameters (a judgment; the emitter could set `\parindent` to 0pt instead) |
| sheet grid | main.tex:44-50 | `tbl.tabular` | `tabular{@{}c@{\hspace{0.4cm}}c@{}}`: two centred columns, no outer padding, 0.4cm inter-column space through an `@{}` expression (an `array` feature); five rows of two cards |
| sheet row gap | main.tex:45-48 | `sp.manual-space` | `\\[0.15cm]` after rows 1 to 4 (the last row has plain `\\`, line 49) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\ssid`, `\wifipassword`, `\authtype` | main.tex:20-22 | yes | three `\newcommand` string aliases. Inline expansion puts the literal text into the credentials table (34, 35) and the QR payload (30). They are content, not template. |
| `\wificard` | main.tex:24-39 | yes | one `\newcommand` with no argument, counter, conditional or loop. Its body is `box.minipage` containing `sp.ragged`, `sp.manual-space`, `font.size-commands`, `mark.kernel`, `fig.qrcode`, `tbl.tabular`, `font.icons` as mapped above. An emitter writes this wrapper once per cell (the same card node ten times) at lines 45-49. |
| `\fbox{\wificard}` x 10 | main.tex:45-49 | yes | ten repeats of one node inside the grid `tbl.tabular`, each wrapped by `box.fancybox`. Repetition is content, not logic. |

## Content-opaque
none. The card text, the network name, the password and the encoded payload string (main.tex:20-22, 28, 29, 30) are text content. The QR graphic is a lib way (`fig.qrcode`), not opaque.

## Lib changes
- New ways proposed: `fig.qrcode` is the `qrcode` package (CTAN, LPPL 1.3, maintainer Anders O. F. Hendrickson, v1.51 per ctan.org/pkg/qrcode): `\usepackage{qrcode}` and an inline command `\qrcode[keys]{string}` that prints a QR code graphic for a string. Engine: pdf (the sample's comment at main.tex:6; the CTAN page does not state engines). I did not read the package documentation, so I name only the key used here, `height`; the manual lists more keys, which I could not verify.
  - W1 published: on CTAN, LPPL 1.3, with a package manual. The CTAN page says it needs no PSTricks or other graphics package.
  - W2 declarative: the size is a length (`height=2.6cm`), and the encoded text is a string argument. No code is edited.
  - W3 generic: it serves any QR code in any document (cards, tickets, invoices, labels), not this card.
  - W4 printable: one preamble line and one inline command around a string.
  - Considered `art.content-package`: it is for packages whose parameters are programs or free drawings (chemistry, music, circuits). Here the parameters are one length and one string, and the graphic is data-encoded rather than drawn artwork, so I did not file it there. If the consolidator prefers that line, the string is still content and the verdict does not change, because the QR code is not a drawn part of the template's look.
  - Considered `font.icons`: it covers glyph packages that print a pictogram, and a QR code is not a font glyph.
  - Considered `ticket.sheet`: the sample does not load `ticket`; it builds the sheet from `tabular`, so I mapped it that way.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- No text addressed to an AI appears in the zip; the header comment (main.tex:1-12) is provenance and design notes only.
- Both comments about upstream (main.tex:2-6) say the original needed no external QR step; the QR code is made by `qrcode` inside TeX. I did not run it, so this is the sample author's claim plus the CTAN description.
