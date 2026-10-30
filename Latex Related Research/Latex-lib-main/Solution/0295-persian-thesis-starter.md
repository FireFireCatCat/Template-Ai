yes

# 0295-persian-thesis-starter: Persian Thesis Starter

- Unverified: read from the source, not compiled.
- Source: Source/0295-persian-thesis-starter/ (origin: https://latextemplates.com/downloads/zarrabi-thesis.zip; licence: CC-BY-4.0)
- Kind: thesis
- Lib: v3
- Engine: needs XeLaTeX (`polyglossia` main.tex:4 and `fontspec` `\newfontfamily` main.tex:9-10; comment main.tex:1 says "Compile with XeLaTeX")
- Look carried by: preamble (stock kernel `book` class; the preamble adds `geometry`, `polyglossia` Farsi/English, two `\newfontfamily` calls, `booktabs`, `amsmath`, `hyperref`; no zip-local class or style)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex, README.md, ATTRIBUTION.txt)

## Verdict
yes. The whole zip is one 56-line `main.tex` on the kernel `book` class. It loads only published packages (`geometry`, `polyglossia`, `booktabs`, `amsmath`, `hyperref`) plus two `fontspec` `\newfontfamily` calls, and defines no macro, environment, counter or conditional of its own. Every component maps to an existing lib way, with no artwork and no tool outside TeX. The look is the stock `book` look in a right-to-left Farsi setting; the Farsi layout comes from `polyglossia` (which pulls in the bidi machinery itself), not from anything in this zip. The `FreeSerif` font is not shipped (an asset note, not a blocker).

## Blockers
none

## Class setting
- Class: `class.book` options: `12pt`, `a4paper`, `oneside` (main.tex:2). Published kernel class, loaded unchanged; its source was not read (ships with the TeX distribution).
- Class-native vocabulary used: `\frontmatter` (main.tex:18), `\mainmatter` (main.tex:31), `\chapter` and `\chapter*` (main.tex:20, 24, 32, 34, 51, 54), `\appendix` (main.tex:53), `\maketitle` (main.tex:19), `\tableofcontents` (main.tex:30). No `abstract` environment: the two abstracts are starred chapters.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2 | `class.book` | 12pt, a4paper, oneside |
| paper, size, sides | main.tex:2 | `page.class-options` | a4paper, 12pt, oneside |
| page geometry | main.tex:3 | `page.geometry` | paper=a4paper, margin=30mm |
| main and other language, text direction | main.tex:4-6 | `lang.polyglossia` | `\setmainlanguage{farsi}`, `\setotherlanguage{english}`; right-to-left layout is supplied by polyglossia itself (the sample does not call `bidi`) |
| Latin-script spans | main.tex:26-29, 35-50 | `lang.polyglossia` | `english` environment around the English abstract and the equation and table |
| fonts | main.tex:9-10 | `font.fontspec` | `\newfontfamily\persianfont{FreeSerif}`, `\newfontfamily\englishfont{FreeSerif}`; no `\setmainfont`; font not shipped |
| title block | main.tex:14-16, 19 | `front.maketitle` | `\title{...\\...}` (Persian line, then English line), `\author{Alex Morgan}`, `\date{۱۴۰۵}` (a literal string, not a computed date), `\maketitle` |
| forced line break in title | main.tex:14 | `sp.manual-space` | `\\` |
| front, main matter | main.tex:18, 31 | `class.book` (native vocabulary) | `\frontmatter`, `\mainmatter` |
| abstract pages (Persian, English) | main.tex:20-29 | `head.kernel` | `\chapter*{چکیده}`, `\chapter*{Abstract}`: unnumbered chapters, default heading look; not the `abstract` environment |
| contents lines for the starred chapters | main.tex:21, 25 | `toc.kernel` | `\addcontentsline{toc}{chapter}{...}` |
| table of contents | main.tex:30 | `toc.kernel` | `\tableofcontents`, defaults |
| chapter headings | main.tex:32, 34, 51, 54 | `head.kernel` | `\chapter{...}`, class defaults, no `\renewcommand` |
| appendix | main.tex:53-54 | `num.appendix` | `\appendix` then `\chapter{پیوست}` |
| display equation | main.tex:12, 37-39 | `math.amsmath` | `amsmath` loaded; `equation` environment, default numbering |
| table float | main.tex:40-41, 49 | `tbl.tabular` | `table` float, placement `ht` |
| centering in the float | main.tex:41 | `sp.ragged` | `\centering` |
| table body | main.tex:43-48 | `tbl.tabular` | `tabular`, column spec `@{}lrr@{}` |
| table rules | main.tex:11, 44-47 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| table caption | main.tex:42 | `cap.kernel` | `\caption{Illustrative measurements.}`, above the table, no `caption` package |
| hyperlinks and PDF links | main.tex:13 | `meta.hyperref` | option `hidelinks` |

Not present in the sample: header/footer (class default), colour, bibliography, index, theorems, lists, code, boxes, figures, cross-references, footnotes.

## Bespoke code
none. The preamble has no `\newcommand`, `\def`, `\newenvironment`, `\newcounter` or conditional (main.tex:1-17). `\persianfont` and `\englishfont` are `fontspec` `\newfontfamily` declarations (`font.fontspec`), not zip-local macros.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Asset: `FreeSerif` is referenced (main.tex:9-10) but not shipped; ship it, or substitute. README.md:4-5 says the starter "uses TeX Live's DejaVu fallback", but main.tex:7-8 says DejaVu Serif is not used because it lacks the Persian range and names FreeSerif; the two files disagree (not checked by compiling).
- The zip is a neutral starter "informed by" the upstream zarrabi thesis template (README.md:3), which is not bundled: README.md:5-6 says the upstream fonts, institutional marks and sample assets are left out. Only what is in this zip was analysed.
- ATTRIBUTION.txt and README.md hold no text addressed to an AI.
