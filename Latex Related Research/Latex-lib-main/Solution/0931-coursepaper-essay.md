yes

# 0931-coursepaper-essay: Coursepaper Essay

- Unverified: read from the source, not compiled.
- Source: Source/0931-coursepaper-essay/ (origin: https://latextemplates.com/downloads/coursepaper-essay.zip; licence: "Other (free; CTAN does not assign an SPDX identifier)" per the manifest; the CTAN page for `coursepaper` shows "Free license not otherwise listed")
- Kind: assignment
- Lib: v6
- Engine: pdfLaTeX-compatible (README.md:13 says "Compile with PDFLaTeX"; the sample loads `fontenc` and `inputenc`, no `fontspec`; the class source was not read)
- Look carried by: class (the zip holds one sample and no class or style file; the look is the published `coursepaper` class with option `final`)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is `main.tex` plus a README. It loads the CTAN/TeX Live class `coursepaper` (Diane Gall, v2.0, read at ctan.org/pkg/coursepaper) with the option `final`, four published packages (`fontenc`, `inputenc`, `booktabs`, `hyperref`), and sets only content: title, author, date and six class-native course fields. It defines no macro, environment, counter or drawing of its own, so there is no bespoke code, no `ART`, no `EXTERNAL`. The look (page, spacing, title block, headings) is the class's. The class is not bundled, so its source was not read; by the rubric a published class is one way, `class.coursepaper`, and an emitter writes the `\documentclass` line and the class does the rest. Verdict yes, as evidence about the class dimension rather than the component ways.

## Blockers
none

## Class setting
- Class: `class.coursepaper` options: `final` (main.tex:6; the README and the comment at main.tex:3-4 describe it as the double-spaced final layout, mechanism not read)
- Class-native vocabulary used: `\college` `\coursename` `\coursenumber` `\coursesection` `\studentnumber` `\instructor` (main.tex:15-20), with the kernel `\title` `\author` `\date` `\maketitle` (main.tex:12-14, 23), the `abstract` environment (main.tex:25-33), plain `\section` (main.tex:35, 44, 73, 88) and `thebibliography` (main.tex:96-104). Whether the class restyles the last four is unread.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:6 | `class.coursepaper` | option `final` |
| page geometry, line spacing, running head and foot, page numbers | main.tex:3-6 (comment and option) | `class.coursepaper` | set inside the class by option `final`; the sample sets no length, geometry or page style; class source not read |
| fonts and encoding | main.tex:7, 8 | `font.fontenc-t1` | `fontenc` option `T1`; `inputenc` option `utf8` |
| text face | main.tex:6 (no font package loaded) | `class.coursepaper` | face is the class default, not read |
| links and PDF metadata | main.tex:10 | `meta.hyperref` | `\usepackage{hyperref}`, no options, no `\hypersetup` |
| title, author, date | main.tex:12, 13, 14, 23 | `front.maketitle` | `\title{..}` `\author{..}` `\date{..}` strings, `\maketitle`; the printed look is the class's |
| course metadata block | main.tex:15-20 | `front.class-native` | strings: `\college`, `\coursename`, `\coursenumber`, `\coursesection`, `\studentnumber`, `\instructor` |
| abstract | main.tex:25-33 | `abs.kernel` | `abstract` environment around one paragraph (class restyle, if any, is `abs.class-native`; not read) |
| headings | main.tex:35, 44, 73, 88 | `head.kernel` | `\section{..}` only, numbered, no `\renewcommand` or package; look comes from the class (`head.class-native` if the class restyles them; not read) |
| inline and display maths | main.tex:46-48, 49-51, 53-54 | `math.kernel` | `$..$`, `\[ .. \]` with `\frac`; no `amsmath` loaded by the sample |
| table float | main.tex:59-60, 71 | `tbl.tabular` | `table[ht]` float, `tabular{lrrr}` (main.tex:62) |
| table rules | main.tex:9, 63, 65, 69 | `tbl.booktabs` | `\usepackage{booktabs}`, `\toprule` `\midrule` `\bottomrule` |
| table caption | main.tex:61 | `cap.kernel` | `\caption{..}` above the tabular; look is the class's default |
| table alignment | main.tex:60 | `sp.ragged` | `\centering` inside the float |
| emphasis in references | main.tex:99, 102 | `mark.kernel` | `\emph{..}` |
| bibliography | main.tex:96-104 | `bib.thebibliography` | `thebibliography{9}`, two `\bibitem` keys `little1961` and `hopp2011`; no `\cite` in the body |

Not used by the sample, so no row: lists, quotes, notes, theorems, code, boxes, index, contents, cross-references, language packages, colour, backgrounds.

## Bespoke code
none. main.tex holds no `\newcommand`, `\def`, `\newenvironment`, counter or conditional (read in full, main.tex:1-106), and the zip has no `.cls`, `.sty`, `.def` or `.cfg`. The class is published and not bundled (README.md:8-9); its source was not read, so anything it defines is counted under `class.coursepaper`.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- README.md:3-14 is ordinary usage text (what the starter shows, that the class comes from the pinned TeX Live image, the licence uncertainty, "Compile with PDFLaTeX"); it contains no text addressed to an AI.
- Caveat for reviewers: because the class source is unread, the rows for spacing, page layout, text face and caption look name the class as the carrier without parameter values. If a later reading finds the class loads a package that needs a tool outside TeX (shell escape), the rubric's first pilot ruling would turn this into `EXTERNAL/package`; nothing in the sample or the CTAN description suggests it.
- CTAN reads used: 1 of 3 (ctan.org/pkg/coursepaper: maintainer Diane Gall, v2.0, topic essay, in TeX Live and MiKTeX, licence shown as "Free license not otherwise listed"). The page lists no options or commands.
