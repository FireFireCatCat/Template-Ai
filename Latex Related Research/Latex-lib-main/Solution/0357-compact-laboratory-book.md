yes

# 0357-compact-laboratory-book: Compact Laboratory Book

- Unverified: read from the source, not compiled.
- Source: Source/0357-compact-laboratory-book/ (origin: https://latextemplates.com/downloads/compact-laboratory-book.zip; licence: LPPL-1.0 per `_Manifest.tsv`; the CTAN page for the class says LPPL without a version)
- Kind: book (the manifest hint `book` fits: the class is KOMA `scrbook`-based and the sample uses `\frontmatter` / `\mainmatter`, main.tex:21, 29; it is a chronological bench notebook, not a report)
- Lib: v3
- Engine: pdfLaTeX-compatible (the sample loads `inputenc` utf8 and `fontenc` T1, main.tex:5-6, and nothing XeLaTeX-only; the class source was not read, so this rests on the sample and on the class being a 2003 `scrbook`-based class)
- Look carried by: class (the zip is one 99-line main.tex; the look and every notebook command come from the published `labbook` class; the preamble only loads published packages and sets one `geometry` margin, main.tex:5-9)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes, under the rubric's ruling for a look carried entirely by a published class. The zip holds only `main.tex` (manifest: a 1493-byte zip with 1 file); `labbook.cls` is not in it, but the class is published: ctan.org/pkg/labbook (2 of the 3 allowed reads) gives "a class for typesetting laboratory journals" by Frank Küster, LPPL, directory `macros/latex/contrib/labbook`, in TeX Live and MiKTeX as `labbook`, based on KOMA-Script's `scrbook`. It passes W1, so it is one way, `class.labbook`. The sample defines no macro, environment, counter, conditional or drawing, so there is no bespoke code and no `ART`. Caveats: this is evidence about the class dimension, not the component ways; the class source and manual (`labbook.pdf`) were not read (not in the zip, not installed locally, downloads not allowed), so what `\labday`, `\experiment`, `\newexperiment` and `\printindex` print is inferred from their names, their use at main.tex:11-13, 31-95 and the CTAN description (an experiment index "generated from the sectioning commands"), and the "package loaded unconditionally that needs an outside tool" ruling could not be checked, although nothing in the sample or the CTAN text points to one.

## Blockers
none

## Class setting
- Class: `class.labbook` options: `a5paper`, `10pt`, `idxtotoc` (main.tex:1). `a5paper` and `10pt` are the usual `scrbook` options; `idxtotoc` is the older KOMA-Script name for "put the index in the table of contents". Whether `labbook` handles these itself or passes them to `scrbook`, and whether the current KOMA-Script still accepts `idxtotoc`, was not read.
- Class-native vocabulary used: `\newexperiment{key}{title}` (main.tex:11-13; three experiments `calib`, `filter`, `amp`), `\labday{date text}` (main.tex:31, 69, 89), `\experiment{key}` (main.tex:33, 38, 71, 80, 91, 95), `\printindex` (main.tex:26; the experiment index, not a `makeidx` index: no index package is loaded, main.tex:5-9), `\frontmatter` / `\mainmatter` (main.tex:21, 29; the `scrbook` base's book commands), and the kernel `\title` `\author` `\date` `\maketitle` / `\tableofcontents` (main.tex:15-17, 22-25, 27).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.labbook` | options `a5paper,10pt,idxtotoc`; vocabulary under Class setting |
| paper size and base size | main.tex:1 | `page.class-options` | `a5paper`, `10pt` (the comment at main.tex:2-3 only explains the pocket trim size) |
| page margins | main.tex:9 | `page.geometry` | `margin=1.6cm`, no other key (paper size stays the class option's) |
| input and font encoding | main.tex:5-6 | `font.fontenc-t1` | `inputenc` option `utf8`; `fontenc` option `T1` |
| experiment declarations | main.tex:11-13 | `class.labbook` (native) | `\newexperiment{calib}{Oscilloscope probe calibration}`, `{filter}{Low-pass filter characterisation}`, `{amp}{Op-amp gain stage}`: key plus title strings; no lib way for it, so it stays class vocabulary |
| title data and title page | main.tex:15-17, 22-25 | `front.maketitle` | `\title{Bench Notebook --- Analogue Filter Board}`, `\author{R.\ Voss}`, `\date{Notebook 3}`, `\maketitle`; the same three values are set twice (15-17, then 22-24 after `\frontmatter`), identical, so an emitter writes them once; the title-page look is the class's |
| front and main matter | main.tex:21, 29 | `class.labbook` (native) | `\frontmatter` before the title, `\mainmatter` before the first day; page-number switching (if any) is the class's, not set by the sample |
| experiment index | main.tex:26, 1 | `front.class-native` | `\printindex` in the front matter, with class option `idxtotoc`; the class's own experiment index (not `idx.makeidx`) |
| contents | main.tex:27 | `toc.kernel` | `\tableofcontents`, no options |
| day heading | main.tex:31, 69, 89 | `head.class-native` | `\labday{9 June}`, `{10 June}`, `{12 June}`: one argument, a date string |
| experiment heading and index entry | main.tex:33, 38, 71, 80, 91, 95 | `head.class-native` | `\experiment{key}` six times with keys `calib` `filter` `amp`; `filter` (38, 80), `amp` (71, 91) and `calib` (33, 95) each recur, which is the "several entries per experiment" case of the CTAN text; its look is the class's, no option or `\renewcommand` touches it |
| display equation | main.tex:42-44 | `math.amsmath` | `\[ ... \]` with `\frac`, `\approx`, `\text{ Hz}` (amsmath's `\text`) |
| inline maths | main.tex:39, 66, 73 | `math.amsmath` | `$\Omega$`, `$0.707\,V_{pp}$` (content) |
| maths package | main.tex:8 | `math.amsmath` | `\usepackage{amsmath}`, no options |
| table float | main.tex:49-64 | `tbl.tabular` | `table[h]`, `tabular{rr}`, one header row and six data rows |
| table centring | main.tex:50 | `sp.ragged` | `\centering` |
| table rules | main.tex:7, 52, 54, 61 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule`, no options |
| table caption | main.tex:63 | `cap.kernel` | `\caption{Filter sweep, first breadboard pass}` after the tabular; position and label look are the class's, no `caption` package and no `cap.koma` option is set |
| text subscripts | main.tex:46, 53, 73 | `mark.kernel` | `\textsubscript{pp}`, `{f}`, `{g}` (kernel text-mode markup, as `\textsuperscript` is filed in earlier solutions) |
| italic run-in label | main.tex:85 | `mark.kernel` | `\textit{Follow-up:}` |
| thin spaces and ties in values | main.tex:34, 39-40, 46, 66, 73, 76-77, 87, 93 (`\,`); 35, 36, 96 (`~`) | `sp.manual-space` | `\,` between number and unit, `~` after "probe"; nearest home, kernel spacing family (no `siunitx` loaded) |
| header and footer, spacing, base font, colour, heading numbering, language, hyperlinks | not set in main.tex | `class.labbook` | class defaults (the `scrbook` base's), not read; the sample sets none of them |

## Bespoke code
none. main.tex has no `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter`, conditional, `\write`, `\input`, TikZ or `picture` (checked by reading all 99 lines and by grep). `\newexperiment`, `\experiment`, `\labday` and `\printindex` are not defined in the zip: they belong to the published class, and the rubric counts a published unbundled class as one way and does not require reading its source.

## Content-opaque
none

## Lib changes
- New ways proposed: none. `class.labbook` is a class way and is written plainly; its native vocabulary is recorded above for the lib's class section. Considered and not used: `idx.makeidx` for `\printindex` (the sample loads no index package and CTAN describes an experiment index generated by the class). If the class's index needs a `makeindex` pass, that is a standard TeX Live step of the same kind as `bib.bibtex-bst`'s BibTeX run, not a tool outside TeX; this was not verified because the manual was not read.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
