yes

# 0776-ub-mannheim-sci-work-course: UB Mannheim "Scientific Writing" LaTeX test document

- Unverified: read from the source, not compiled.
- Source: Source/0776-ub-mannheim-sci-work-course/ (origin: https://codeload.github.com/UB-Mannheim/sci-work-course/zip/refs/heads/master; licence: MIT, LICENSE:1)
- Kind: misc (a 23-line LaTeX installation smoke test inside a Git/GitHub course repository; the manifest hint `thesis` / `master-thesis` probably reflects the empty placeholder `latex-src/thesis.tex`, which holds no text)
- Lib: v6
- Engine: pdfLaTeX-compatible (no `\usepackage` at all in the sample, doc/LatexExample/testDocument.tex:1-23; BibTeX is the bibliography tool)
- Look carried by: class (the kernel `article` class at its defaults draws everything visible, doc/LatexExample/testDocument.tex:1; the only preamble line is `\bibliographystyle{alpha}` at :3; the zip ships no .cls, .sty, .def, .cfg or .bst)
- Class origin: tex-distribution-unbundled (kernel `article` from the LaTeX base, not in the zip; its source was not read; no CTAN read was needed)
- Main file: doc/LatexExample/testDocument.tex (other samples: none; `latex-src/thesis.tex` is a 0-byte file)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is a Git/GitHub exercise for a scientific-writing course (README.md:1-34, birth-date text files, GitHub Actions scripts). Its only LaTeX content is `doc/LatexExample/testDocument.tex` (23 lines, read in full), a `references.bib` with one entry, and a `goal.pdf` showing the expected output. The sample is the kernel `article` class with no options, no packages, a title block, an abstract, one `\section`, one `\cite` and a BibTeX bibliography with the `alpha` style. It defines no macro, environment, counter or class of its own and draws no artwork, so every component is a published way. `latex-src/thesis.tex` and `latex-src/literature.bib` are empty (0 bytes), so there is no thesis template to recover. This is thin evidence about the class dimension (`class.article`), not about the component ways. `NOTEMPLATE` was considered and not chosen, because the sample is a real, complete LaTeX document with its own bibliography.

## Blockers
none

## Class setting
- Class: `class.article` options: none (doc/LatexExample/testDocument.tex:1, `\documentclass{article}`), so the class defaults apply to paper, base size and page style
- Class-native vocabulary used: `\title{}` `\author{}` `\maketitle` (doc/LatexExample/testDocument.tex:7-9); `abstract` environment (:11-13); `\section{}` (:15); `\cite{}` (:18); `\bibliographystyle{}` (:3) and `\bibliography{}` (:21), which are kernel commands. `\date` is not called, so `\maketitle` prints `\today`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/LatexExample/testDocument.tex:1 | `class.article` | no options |
| paper and base size | doc/LatexExample/testDocument.tex:1 | `page.class-options` | none set; the article defaults are inherited, nothing to emit (no `geometry` loaded) |
| page margins, spacing, running heads, page numbers | not set in the sample | `class.article` | inherited article defaults (no `\pagestyle`, no `fancyhdr`, no spacing package); nothing to emit |
| fonts and encoding | not set in the sample | `class.article` | no font, `fontenc` or `inputenc` package loaded; the kernel default Computer Modern family is inherited |
| title block | doc/LatexExample/testDocument.tex:7-9 | `front.maketitle` | `\title{My Title}`, `\author{My Name}`, no `\date` (default `\today`), `\maketitle` |
| abstract | doc/LatexExample/testDocument.tex:11-13 | `abs.kernel` | `abstract` environment, one sentence of text; no `abstract` package |
| section heading | doc/LatexExample/testDocument.tex:15 | `head.kernel` | `\section{Section 1}`; article default numbering and heading look, no `\renewcommand`, no `titlesec` |
| body paragraph | doc/LatexExample/testDocument.tex:16-17 | `class.article` | plain paragraph and a `%` comment line; content is text, not template |
| citation | doc/LatexExample/testDocument.tex:18 | `bib.bibtex-bst` | `\cite{Eckert2007}`; the key resolves to doc/LatexExample/references.bib:1; no `natbib`, no `cite` package, so the label is the plain BibTeX label |
| bibliography | doc/LatexExample/testDocument.tex:3, 21 | `bib.bibtex-bst` | `\bibliographystyle{alpha}` (placed before `\begin{document}`), `\bibliography{references}`; one `@inproceedings` entry with author, booktitle, title, year, pages (doc/LatexExample/references.bib:1-7); a BibTeX pass is part of the build (doc/install-windows.md:56-57 names the .tex and .bib pair) |

## Bespoke code
none. The whole sample was read (doc/LatexExample/testDocument.tex:1-23) and holds no `\newcommand`, `\renewcommand`, `\def`, `\let`, `\newenvironment`, `\newcounter`, `\newif`, `\makeatletter` or `\input`. The zip holds no .cls, .sty, .def, .cfg, .clo or .bst file. The other TeX-related files are `latex-src/thesis.tex` and `latex-src/literature.bib`, both 0 bytes. The .github workflows, `reset-birth-dates.sh` and `data/birth-dates/*.txt` belong to the Git exercise (a grep for tex, bib and pdf in them finds only the .gitignore template lines and base64 data) and produce no LaTeX, so they are not an `EXTERNAL` blocker.

## Content-opaque
none. The bibliographic entry (doc/LatexExample/references.bib:1-7) and the sentences at doc/LatexExample/testDocument.tex:12 and :16 are content. `doc/LatexExample/goal.pdf` is a binary expected output; it could not be rendered here (no PDF rasteriser), so it was not read. The two LaTeX snippets in doc/faq.md (`\includegraphics[bb=...]`, a `tabular` with a `p{}` column, doc/faq.md:109 and :118) are documentation examples in a Markdown FAQ, not part of the sample, and are out of scope.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
