yes

# 0772-overhead-foils-slides: Overhead Foils Slides

- Unverified: read from the source, not compiled.
- Source: Source/0772-overhead-foils-slides/ (origin: https://latextemplates.com/downloads/overhead-foils-slides.zip; licence: LPPL-1.3c per the manifest, which is the licence of the `slides` class; the starter text itself "carries no additional restrictions", README.md:41-42)
- Kind: presentation
- Lib: v6
- Engine: pdfLaTeX-compatible (the two `\pdfpagewidth`/`\pdfpageheight` lines at main.tex:23-24 are pdfTeX primitives; the README builds with `pdflatex`, README.md:21)
- Look carried by: class (the kernel `slides` class defines the foil look; the preamble adds only `fontenc` and a PDF page-size fix, and the body hand-sets centred `\Large` foil titles with kernel commands)
- Class origin: tex-distribution-unbundled (the zip ships no class file: main.tex:3-6 and README.md:10-17 say so; ctan.org/pkg/slides read: standard LaTeX2e class for overhead foils, part of the LaTeX distribution, LPPL 1.3c)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only `main.tex` and `README.md`; the source of `slides.cls` was not read)

## Verdict
The whole zip is one 98-line sample on the published kernel class `slides`. The preamble holds two lines of its own (`fontenc`, and the PDF page size set from the class's `\paperwidth`/`\paperheight`). The body uses only the class's `slide` and `overlay` environments plus kernel `center`, `itemize`, `tabular`, `\Large`, `\vspace`, `\today`. Nothing is defined in the zip (no `\newcommand`, `\def`, counter, conditional, picture or TikZ), so there is no bespoke code and no artwork, and every component has a lib way. The verdict is `yes`; it is class-carried evidence, about the class dimension more than the component ways.

## Blockers
none

## Class setting
- Class: `class.slides` options: `landscape` (main.tex:15). The look the class sets (the zip's own text says oversized sans-serif type on a plain page, main.tex:9-10 and README.md:27-28) comes from the class defaults, whose source was not read.
- Class-native vocabulary used: environment `slide` (one foil, used at main.tex:30, 45, 56, 67, 86), environment `overlay` (printed on top of the preceding slide, main.tex:82-84). The `\documentclass` option list is `landscape` only.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:15 | `class.slides` | option `landscape` (swaps `\paperwidth` and `\paperheight`, per the comment at main.tex:19-21) |
| page size and orientation | main.tex:15 | `page.class-options` | `landscape` class option; no margins or geometry set in the sample |
| PDF page size fix | main.tex:23-24 | `page.setlength` | `\pdfpagewidth=\paperwidth`, `\pdfpageheight=\paperheight` (pdfTeX paper-size dimensions assigned from the class's page dimensions, the type of the raw page lengths; the same reading as other zips' `\pdfpagewidth` lines; considered `meta.pdf-params`, whose values are integers and strings, and `page.geometry`, which the sample does not load) |
| font encoding | main.tex:17 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}` |
| typeface, sizes, running foot, page numbers | none in the sample | `class.slides` | class defaults only; the sample sets no `\pagestyle`, `\pagenumbering`, font package or size; source of `slides.cls` not read, so the defaults are not stated here beyond the README's "sans-serif" claim (README.md:27) |
| foil container | main.tex:30-43, 45-54, 56-65, 67-78, 86-96 | `class.slides` | `slide` environment, one per foil, no arguments |
| overlay foil | main.tex:82-84 | `class.slides` | `overlay` environment, no arguments; the content is one centred line |
| title block (title, author, institute, date) | main.tex:31-42 | `sp.ragged`, `font.size-commands`, `sp.manual-space` | hand-laid inside the first `slide`, no `\title`/`\maketitle`: `center` environment, `\Large` on the title (main.tex:32), `\vspace{2em}` (main.tex:34), `\vspace{1em}` (main.tex:37, 40); kernel `\today` (main.tex:41) prints the compile date and is content |
| foil headings | main.tex:46, 57, 68, 83, 87 | `sp.ragged`, `font.size-commands` | `\begin{center}\Large <text>\end{center}`; no sectioning command, so no `head.*` way |
| lists | main.tex:48-53, 61-64, 89-92 | `list.kernel` | `itemize`, default labels, no options |
| table | main.tex:70-75 | `tbl.tabular` | `tabular{lr}`, rows ended by `\\`, no rules, no `\caption`, not a float, inside `center` |
| centred blocks and spacing | main.tex:70, 94-95 | `sp.ragged`, `sp.manual-space` | `center` environment, `\vspace{2em}` before the closing line |
| closing line | main.tex:95 | `sp.ragged` | `\begin{center}Questions?\end{center}` |

Components the sample does not use and the zip does not define: columns, header/footer styles, spacing packages, colour, backgrounds, language, metadata packages, abstract, contents, sectioning, numbering, quotes, notes, math, theorems, floats, captions, code, boxes, bibliography, index, cross-references.

## Bespoke code
none (the zip defines no macro, environment, counter, conditional, class or style; the only non-package lines are the two primitive assignments at main.tex:23-24, which are the `page.setlength` row)

## Content-opaque
none (the table at main.tex:71-74 holds plain text and numbers; `\ldots` at main.tex:83 is a kernel text symbol)

## Lib changes
- New ways proposed: none (`class.slides` is a class way and needs no proposal; its native vocabulary is recorded above)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
