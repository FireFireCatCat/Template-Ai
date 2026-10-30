yes

# 0495-envlab-envelope-and-mailing-label: EnvLab Envelope and Mailing Label

- Unverified: read from the source, not compiled.
- Source: Source/0495-envlab-envelope-and-mailing-label/ (origin: https://latextemplates.com/downloads/envlab-envelope-letter.zip; licence: LPPL-1.3c per manifest; README.md:8 says the envlab package is under the LaTeX Project Public License)
- Kind: letter (the manifest hint `journal` is wrong: main.tex:2 is the kernel `letter` class)
- Lib: v4
- Engine: pdfLaTeX-compatible (README.md:9-10 says "Compile with PDFLaTeX"; that is the zip's own statement, not checked here. The lib already notes that `ltr.envlab` is dvips-oriented and pdfTeX output is unverified)
- Look carried by: mixed (the kernel `letter` class carries the letter page and its fields, main.tex:2; the published `envlab` package, loaded in the preamble, carries the label sheet, main.tex:4-5, 32-34; nothing is zip-local)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes (all 35 lines), zip-local classes and styles none present (the zip holds only main.tex and README.md; `letter.cls` and `envlab.sty` are not bundled, README.md:9, and their source was not read)

## Verdict
yes. The zip is a 35-line sample: `\documentclass[12pt]{letter}`, two published packages (`fontenc`, `envlab`) and letter-class commands with their content. It defines no macro, environment, counter or style of its own, and draws nothing. Every part maps to an existing lib way (`class.letter`, `ltr.envlab`, `ltr.opening`), so an emitter can write the preamble and body from published packages and kernel class commands alone. The result rests on counting the CTAN `envlab` package as published (W1: ctan.org/pkg/envlab read once, LPPL, in TeX Live) and on `ltr.envlab` covering the package's other commands (`\startlabels`, `\mlabel`), as the rubric says commands of one package are one way; the envlab source was not read.

## Blockers
none

## Class setting
- Class: `class.letter` options: `12pt` (main.tex:2); no paper option, so the class default paper
- Class-native vocabulary used: `\name` (main.tex:7), `\signature` (8), `\address` (9), `\telephone` (10), `\date` (11), `letter` environment with the recipient block as its argument (14-20, 29), `\opening` (21), `\closing` (27), `\encl` (28)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2 | `class.letter` | `12pt` |
| text size | main.tex:2 | `page.class-options` | `12pt` class option; no paper size, no `geometry` or length setting anywhere in the file |
| font encoding | main.tex:3 | `font.fontenc-t1` | `fontenc` option `T1`; no font package, so the text face stays the class default |
| envelope and label package | main.tex:4 | `ltr.envlab` | `\usepackage[avery5160label]{envlab}`: one option, the label sheet type; no `\SetEnvelope`, `\SetLabel` or other option is set, so package defaults apply |
| automatic labels from the letter | main.tex:5 | `ltr.envlab` | `\makelabels` in the preamble, no arguments (README.md:5 says labels come automatically from the letter) |
| manual label sheet | main.tex:32-34 | `ltr.envlab` | `\startlabels` then `\mlabel{return address}{recipient address}`; two string arguments, lines split with `\\` (README.md:5-6 names both commands) |
| sender fields | main.tex:7-11 | `ltr.opening` | `\name{Northbridge Research Studio}`, `\signature{Morgan Ellis}`, `\address{three lines}`, `\telephone{+44 ...}`, `\date{29 August 2026}`: strings only |
| recipient block | main.tex:14-20 | `ltr.opening` | argument of `\begin{letter}{...}`, five address lines (content) |
| opening, closing, enclosure | main.tex:21, 27, 28 | `ltr.opening` | `\opening{Dear Alex,}`, `\closing{Best wishes,}`, `\encl{Project brief}`: strings |
| address line breaks | main.tex:9, 15-19, 33-34 | `sp.manual-space` | `\\` as a line separator inside address fields, no length argument |
| page style | no line (grep for `pagestyle` finds none) | `hf.class-native` | letter class default head and foot; nothing set |

No rows for colour, background, language, headings, lists, floats, tables, maths, code, bibliography or index: the file has none of them (grep for `\usepackage` finds only main.tex:3-4).

## Bespoke code
none. A search of main.tex for `newcommand`, `renewcommand`, `\def`, `\let`, `newenvironment`, `newcounter` finds no line. `\makelabels`, `\startlabels` and `\mlabel` are called, not defined, here; their code lives in the published `envlab` package (not bundled, README.md:9), which is the CTAN release the README names (README.md:3-4).

## Content-opaque
none. The address blocks (main.tex:9, 14-20, 33-34) and the body paragraph (23-25) are text content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
