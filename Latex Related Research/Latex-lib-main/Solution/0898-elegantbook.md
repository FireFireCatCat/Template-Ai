yes

# 0898-elegantbook: ElegantBook (book template)

- Unverified: read from the source, not compiled.
- Source: Source/0898-elegantbook/ (origin: https://latextemplates.com/downloads/elegantbook.zip; licence: LPPL-1.3c per the manifest, and the CTAN page for `elegantbook` shows LPPL 1.3c)
- Kind: book
- Lib: v6
- Engine: pdfLaTeX-compatible (not established: the sample sets no `lang` or font option, the class source is not in the zip and was not read, and the CTAN page names no engine; a Chinese mode of the class, which the sample does not select, would need XeLaTeX)
- Look carried by: class (the zip holds only a 36-line sample and a one-entry `.bib`; the preamble has no `\usepackage`, no `\newcommand` and no `\def`, main.tex:1-10)
- Class origin: tex-distribution-unbundled (class `elegantbook` is not in the zip; ctan.org/pkg/elegantbook, read once: ElegantBook 4.7, dated 2026-05-01, LPPL 1.3c, "based on the standard LaTeX book class", included in TeX Live and MiKTeX)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The whole file set is a sample that loads the published class `elegantbook` with two options (`11pt`, `bibtex`), sets title-block fields with the class's own commands, and uses kernel book sectioning, `\tableofcontents` and biblatex commands in the body. There is no zip-local macro, environment, counter, class or style, and no artwork in the zip, so nothing is bespoke and nothing blocks. The class source itself was not read (the class is not bundled and the rubric treats a published class as one way); anything the class loads or draws internally (cover, headings, boxes, fonts) is carried by `class.elegantbook` and was not checked here, which is the main uncertainty behind this yes.

## Blockers
none

## Class setting
- Class: `class.elegantbook` options: `11pt` (main.tex:1), `bibtex` (main.tex:1). `11pt` is a book-class size option; what the class does with `bibtex` is not established (class source not read). The name suggests the bibtex backend of biblatex, since the body uses biblatex commands (main.tex:10, 23, 34), but the class might ignore it.
- Class-native vocabulary used: `\subtitle` (main.tex:4), `\institute` (main.tex:6), `\version` (main.tex:8), `\maketitle` (main.tex:14, the class's own title page), `\frontmatter` and `\mainmatter` (main.tex:16, 19, book-family vocabulary), `\chapter` and `\section` (main.tex:21-22, 27, 30), `\tableofcontents` (main.tex:17); biblatex vocabulary that the class is expected to load: `\addbibresource[location=local]{...}` (main.tex:10), `\textcite{key}` (main.tex:23, 32), `\printbibliography` (main.tex:34).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.elegantbook` | options `11pt`, `bibtex`; the class is the published TeX Live class, its source not read |
| paper and point size | main.tex:1 | `page.class-options` | `11pt` only; no paper option, so the class default paper |
| title block: title, subtitle, institute, version | main.tex:3-4, 6, 8 | `front.class-native` | `\subtitle{On the Configurability of Long Documents}`, `\institute{...}`, `\version{1.0}`; the strings are content |
| title block: kernel fields | main.tex:3, 5, 7, 14 | `front.maketitle` | `\title`, `\author{Noor Fatima}`, `\date{\today}`, `\maketitle`; the class redefines the look of `\maketitle`, which is carried by `front.class-native` |
| front and main matter switch | main.tex:16, 19 | `class.elegantbook` | `\frontmatter` before the contents, `\mainmatter` before chapter 1 (book-family commands the class inherits) |
| table of contents | main.tex:17 | `toc.kernel` | `\tableofcontents`, no options; the entry look is set by the class (not read) |
| chapter and section headings | main.tex:21-22, 27, 30 | `head.kernel` | `\chapter{..}`, `\section{..}`, no star forms, no optional titles |
| heading look | main.tex:21, 22 | `head.class-native` | no option set in the sample; the look is the class default (class not read) |
| citations | main.tex:23, 32 | `bib.biblatex-bibtex` | `\textcite{knuth1984texbook}` twice; backend inferred from the `bibtex` class option (main.tex:1), the biber backend if the class ignores it, same family of lib way either way |
| bibliography resource | main.tex:10 | `bib.biblatex-bibtex` | `\addbibresource[location=local]{references.bib}` |
| bibliography list | main.tex:34 | `bib.biblatex-bibtex` | `\printbibliography`, no options; style chosen by the class (not read) |
| bibliography data | references.bib:1-7 | content | one `@book` entry (Knuth, The TeXbook, 1984); data, not template |
| page geometry, headers and footers, fonts, colours, theorem and box environments, code listings, lists | not in the sample | `class.elegantbook` | none set or used by the sample; whatever the class defines is covered by the class way, and nothing is overridden in the preamble (main.tex:1-10) |

## Bespoke code
none. The grep of the zip for `\newcommand`, `\renewcommand`, `\def`, `\let`, `\usepackage`, `\RequirePackage`, `\newenvironment`, `\newcounter`, conditionals, `\input`, `\include` and `\immediate` found no match; the sample's preamble is `\documentclass`, the six field commands and one `\addbibresource` (main.tex:1-10).

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The class source (`elegantbook.cls`) is not in the zip and was not read. Its option list (including what `bibtex` does and the default of any `lang` option), its title-page construction and its loaded packages are therefore unchecked; a later reader who needs those should read the TeX Live copy of the class.
- Nothing in the zip is addressed to an AI.
