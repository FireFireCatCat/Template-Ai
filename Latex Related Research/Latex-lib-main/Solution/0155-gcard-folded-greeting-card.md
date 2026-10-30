yes

# 0155-gcard-folded-greeting-card: gcard Folded Greeting Card (four panels on one sheet, folded twice)

- Unverified: read from the source, not compiled.
- Source: Source/0155-gcard-folded-greeting-card/ (origin: https://latextemplates.com/downloads/gcard-formal-letter.zip; licence: LPPL-1.3c-or-later)
- Kind: misc (the manifest hint says letter, from the CTAN topic; the sample is a four-panel greeting card, which no other kind in the list fits)
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:9 says compile with PDFLaTeX; main.tex:4-5 load `inputenc`/`fontenc`; no fontspec or xe/lua package; `gcard.sty` is not in the zip and was not read)
- Look carried by: preamble (kernel `article` carries nothing; the published `gcard` package lays out the four panels; the sample's own preamble loads it, sets its four margin lengths and one colour, main.tex:3-13)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip is a 33-line `main.tex` and a README, with no `.cls`, `.sty` or other local file, and no `\newcommand`, `\def`, environment or counter is defined anywhere in it (grep of main.tex found only `\definecolor`, main.tex:13). The look is the published `gcard` package (CTAN, George McBane, LPPL, in TeX Live; one read of https://ctan.org/pkg/gcard) plus kernel `article`, `xcolor` and kernel text commands. `gcard` has no home in the lib, so I propose `card.gcard`, which passes W1 to W4 (below). The panel text is content; there is no artwork (no tikz or picture), no external tool, and no bespoke code. The one thing not checked is the inside of `gcard.sty` (not in the zip, not downloaded): what it does with paper size or rotation is taken from the CTAN summary only.

## Blockers
none

## Class setting
- Class: `class.article` options: `12pt` (main.tex:3). The class is the kernel LaTeX base class, loaded unchanged and not bundled in the zip; its source was not read.
- Class-native vocabulary used: none (no `\maketitle`, abstract, sectioning, list, float or bibliography). The vocabulary in use belongs to the `gcard` package, not the class: environments `frontcover`, `insideleft`, `insideright`, `backcover` (main.tex:15, 20, 26, 30) and lengths `\gcguttermargin`, `\gcedgemargin`, `\gctopmargin`, `\gcbottommargin` (main.tex:9-12).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:3 | `class.article` | option `12pt` |
| body type size | main.tex:3 | `page.class-options` | `12pt`; no paper-size option and no `geometry` or page `\setlength` anywhere in the sample |
| input and font encoding | main.tex:4-5 | `font.fontenc-t1` | `inputenc` option `utf8`; `fontenc` option `T1` |
| folded-card sheet: four panels placed on one sheet | main.tex:6; README.md:4-5 | `card.gcard` | `\usepackage{gcard}`, no package options |
| card margins | main.tex:9-12 | `card.gcard` | `\gcguttermargin`=10mm, `\gcedgemargin`=10mm, `\gctopmargin`=10mm, `\gcbottommargin`=10mm (set with `\setlength`; these are the package's own lengths, not page margins) |
| front cover panel | main.tex:15-19 | `card.gcard` | environment `frontcover` wrapping content |
| inside left panel | main.tex:20-25 | `card.gcard` | environment `insideleft` wrapping content |
| inside right panel | main.tex:26-29 | `card.gcard` | environment `insideright` wrapping content |
| back cover panel | main.tex:30-32 | `card.gcard` | environment `backcover` wrapping content; README.md:5-6 says panels may be left out |
| colour package | main.tex:7 | `color.xcolor` | package `xcolor`, no options |
| named colour | main.tex:13 | `color.xcolor` | `\definecolor{cardblue}{HTML}{164E63}` |
| coloured title text | main.tex:17 | `color.xcolor` | `\color{cardblue}` inside a group |
| page style | main.tex:8 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| centred lines | main.tex:16, 27, 31 | `sp.ragged` | `\centering` in the cover, inside-right and back panels |
| vertical glue and gaps | main.tex:16, 18, 21, 27, 28, 31 | `sp.manual-space` | `\vfill` (centres a block vertically in a panel), `\vspace{8mm}`, `\medskip`, `\bigskip` |
| type sizes | main.tex:17, 18, 27, 31 | `font.size-commands` | `\Huge` (title), `\large` (subtitle), `\Large` (sign-off), `\small` (web address) |
| family and weight switches | main.tex:17, 21, 28, 31 | `mark.kernel` | `\sffamily`, `\bfseries`, `\textbf{}` (kernel font switches, filed with the kernel emphasis commands) |
| front matter, headings, lists, floats, tables, maths, code, notes, bibliography, index | main.tex:15-32 | none used | the body is four panel environments of plain text and kernel spacing; no `\maketitle`, `\section`, list, float, equation, footnote or `\cite` |

## Bespoke code
none. main.tex defines no macro, environment, counter or conditional. There is no zip-local `.cls`, `.sty`, `.def` or `.cfg` (the zip holds README.md and main.tex only). `gcard` is not zip-local: README.md:8 says it ships with TeX Live and is not bundled, and CTAN lists it.

## Content-opaque
none. The panel text (main.tex:17-18, 21-24, 27-28, 31) is content.

## Lib changes
- New ways proposed: `card.gcard`, package `gcard` (CTAN; George McBane; LPPL; in TeX Live; pdfLaTeX-compatible, the CTAN page names `textpos` and `graphicx` as its dependencies and says panels are set in minipages). Command surface seen in the sample: `\usepackage{gcard}`, four length parameters `\gcguttermargin` `\gcedgemargin` `\gctopmargin` `\gcbottommargin`, and four panel environments `frontcover` `insideleft` `insideright` `backcover`. A doc-kind way (a folded greeting card).
  - W1 Published: on CTAN and in TeX Live, a CTAN package with public documentation (https://ctan.org/pkg/gcard).
  - W2 Declarative parameters: the sample's whole configuration is four lengths and four content-wrapping environments; no package code is edited or extended.
  - W3 Generic: it serves a kind of document (any greeting card of four panels folded twice), not one card; the panel text is free content.
  - W4 Printable: one preamble line plus `\setlength` lines, and four body wrappers around a node's content, so an emitter can write it as preamble lines and body wrappers.
  - Considered and not used: `ticket.sheet` (imposes many tickets, labels or cards per sheet, not the four named faces of one card), `pg.pgfpages` (n-up layouts of logical pages, no named panels), `pg.textpos` (absolute positioning; `gcard` uses it inside, which is not the way a card is described), `class.flashcard` (a class for two-sided question and answer cards), `ltr.opening` (letters). None of these has the four panel environments.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Not read: `gcard.sty` (not in the zip, not downloaded). Whether it needs landscape paper, how it rotates the upper panels, and what it does with `\pagestyle` are unverified; the sample sets no paper option (main.tex:3), so the paper is the `article` default unless the package changes it.
- The README is plain description (README.md:1-10); it contains no text addressed to an AI.
