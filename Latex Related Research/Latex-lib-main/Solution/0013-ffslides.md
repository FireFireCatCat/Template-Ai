yes

# 0013-ffslides: ffslides (freeform slides on the article class)

- Unverified: read from the source, not compiled.
- Source: Source/0013-ffslides/ (origin: https://latextemplates.com/downloads/ffslides.zip; licence: LPPL-1.3)
- Kind: presentation
- Lib: v1
- Engine: pdfLaTeX-compatible (the sample loads `inputenc` utf8 and `fontenc` T1, main.tex:3-4, and nothing XeLaTeX-only; the class source was not available, so this rests on the sample, not on a check of the class)
- Look carried by: class (the zip is one 46-line main.tex; every slide command it calls comes from the published `ffslides` class, and its preamble only sets input and font encoding)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes, under the rubric's ruling for a look carried entirely by a published class. The zip holds only `main.tex` (732-byte zip, 1 file, `_Manifest.tsv` row 0013); `ffslides.cls` is not in it, but the class is published: ctan.org/pkg/ffslides (1 of the 3 allowed reads) describes "freeform slides built on the article class", Mark A. Wolters, version 2015-11-19, LPPL 1.3, in TeX Live as `ffslides`, with `ffslides-doc.pdf`, so it passes W1 and the zip's own package is one way, `class.ffslides`. The sample defines no macro, environment, counter, conditional or drawing (no `\newcommand`, `\def`, TikZ or picture anywhere in the 46 lines), so there is no bespoke code and no `ART`. Caveats for a stricter re-reading: this is evidence about the class dimension, not the component ways; the class source and manual were not read (no copy in the zip, none installed locally, downloads not allowed), so what `\blankpage`, `\ctext` and `\normalpage` do is inferred only from their use at main.tex:8-44, and ruling 1 (an unconditional package load that needs an outside tool) could not be checked, though nothing in the sample or the CTAN description points to one.

## Blockers
none

## Class setting
- Class: `class.ffslides` options: none (`\documentclass{ffslides}`, main.tex:1). CTAN describes it as a small set of macros added to `article`, plus a template file; its source was not read.
- Class-native vocabulary used: `\blankpage` (main.tex:8, 43; no argument), `\ctext{a}{b}{c}{content}` (main.tex:9, 10, 44; three decimal numbers then the content; the numbers' meaning is not read, the values 0.1 / 0.35 or 0.45 or 0.4 / 0.8 look like page fractions for left offset, vertical position and width, since 0.1 + 0.8 + 0.1 = 1, but that is an inference), `\normalpage{title}{body}` (main.tex:12, 20, 25, 35; a slide title argument and a body argument holding ordinary LaTeX).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.ffslides` | no options; vocabulary under Class setting |
| input and font encoding | main.tex:3-4 | `font.fontenc-t1` | `inputenc` option utf8; `fontenc` option T1 |
| title slide (blank page, then placed text) | main.tex:8-10 | `front.class-native` | `\blankpage`, then `\ctext{0.1}{0.35}{0.8}{...}` for the title and `\ctext{0.1}{0.45}{0.8}{...}` for the subtitle |
| closing slide | main.tex:43-44 | `front.class-native` | `\blankpage`, then `\ctext{0.1}{0.4}{0.8}{\centering\Large Thank you}` |
| free positioning of text on a slide | main.tex:9, 10, 44 | `class.ffslides` (native) | the first three `\ctext` arguments per call (0.1/0.35/0.8, 0.1/0.45/0.8, 0.1/0.4/0.8); declarative numbers, meaning not read; no lib way for it, so it stays class vocabulary |
| content slide (page wrapper) | main.tex:12, 20, 25, 35 | `class.ffslides` (native) | `\normalpage{<title>}{<body>}`, four slides, like a beamer frame |
| slide title | main.tex:12, 20, 25, 35 | `head.class-native` | first argument of `\normalpage`: "Why Redesign", "Two Flows Compared", "Checkout Time, Before and After", "What We Recommend"; its look is the class's, no option set |
| text size inside placed text | main.tex:9, 10, 44 | `font.size-commands` | `\Large`, `\normalsize` |
| bold switch on the title | main.tex:9 | `mark.kernel` | `\bfseries` (kernel font-series switch) |
| centred text | main.tex:9, 10, 44 | `sp.ragged` | `\centering` inside `\ctext` content |
| bold run-in labels | main.tex:21-22 | `mark.kernel` | `\textbf{Old flow}`, `\textbf{New flow}`; `\par` between the two paragraphs |
| bullet list | main.tex:13-17 | `list.kernel` | `itemize`, three `\item`, inside `\normalpage` |
| numbered list | main.tex:36-40 | `list.kernel` | `enumerate`, three `\item`, inside `\normalpage` |
| table | main.tex:26-32 | `tbl.tabular` | `tabular{lcc}`, one `\hline` under the header row, no float, no caption, no `booktabs` |
| page geometry, header/footer, colour, base font, heading numbering, language | not set in the sample | `class.ffslides` | class defaults, not read; the sample sets none of them |

## Bespoke code
none. main.tex defines no `\newcommand`, `\def`, environment, counter or conditional (checked by reading all 46 lines). The three slide commands belong to the published class; the rubric counts a published unbundled class as one way and does not require reading its source.

## Content-opaque
none

## Lib changes
- New ways proposed: none. `class.ffslides` is a class way and is written plainly; its native vocabulary is recorded above for the lib's class section.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
