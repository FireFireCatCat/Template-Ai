yes

# 0141-msu-thesis: MSU Thesis

- Unverified: read from the source, not compiled.
- Source: Source/0141-msu-thesis/ (origin: https://latextemplates.com/downloads/msu-thesis.zip; licence: LPPL-1.3 per the manifest)
- Kind: thesis
- Lib: v3
- Engine: pdfLaTeX-compatible (the sample loads `fontenc` T1 and `natbib`, main.tex:3-4; the class source is not in the zip and was not read, so an engine condition inside it is unchecked)
- Look carried by: class (the whole look comes from the published class `msu-thesis`; the preamble adds only `fontenc` and `natbib`, main.tex:3-4)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip holds only `main.tex` and `references.bib` (52 and 7 lines). It ships no `.cls`, `.sty` or other style file, and `main.tex` defines no macro, environment, counter or conditional. The look is carried by the published class `msu-thesis`, which `https://ctan.org/pkg/msu-thesis` lists as CTAN version 4.3b (2024-07-08), LPPL 1.3, contained in TeX Live and MiKTeX, MSU Graduate School thesis class, based on `memoir` (taken from that page, not from the class source). The sample then uses only class-native commands, kernel and `natbib` commands, so every component maps to a lib way with no bespoke code and no artwork. Caveat: `msu-thesis.cls` is not in the zip and was not read, so this `yes` is evidence about the class dimension and rests on the class being published and loaded unchanged; a package the class loads unconditionally cannot be checked here.

## Blockers
none

## Class setting
- Class: `class.msu-thesis` options: none (empty option list, main.tex:1)
- Class-native vocabulary used: `\fieldofstudy{}` (main.tex:8), `\frontmatter` (13), `\maketitlepage` (14), `abstract` environment (16-21), `\makecopyrightpage` (24), `\SingleSpacing` (27), `\tableofcontents*` (28), `\mainmatter` (30), `\chapter` (32, 40, 48); the title data come from `\title` `\author` `\date` (6, 7, 9), read by the class's title page.
- Not read: the class source (not shipped; the zip came from latextemplates.com, and the same class is on CTAN and in TeX Live). Where a row below says "class" or "class source not read", the claim about what the class does inside is an inference from the command names and the CTAN page, not from code.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.msu-thesis` | no options; the class is memoir-based per the CTAN page |
| font encoding | main.tex:3 | `font.fontenc-t1` | `fontenc` option `T1` |
| title data | main.tex:6, 7, 9 | `front.maketitle` | kernel `\title`, `\author`, `\date` (values are content); printed by the class's title page, not by `\maketitle` |
| title page and field of study | main.tex:8, 14 | `front.class-native` | `\fieldofstudy{Computer Science}`, `\maketitlepage` (no arguments) |
| front and main matter division | main.tex:13, 30 | `class.msu-thesis` | `\frontmatter`, `\mainmatter` (the class's native vocabulary; roman and arabic page numbers are the class's, source not read) |
| abstract | main.tex:16-21 | `abs.class-native` | `abstract` environment as supplied by the class; no parameters |
| page flow | main.tex:23, 26 | `pg.break` | `\clearpage` |
| copyright page | main.tex:24 | `front.class-native` | `\makecopyrightpage` (no arguments; the text comes from the class) |
| line spacing | main.tex:27 | `class.msu-thesis` | `\SingleSpacing`, a class-supplied (memoir-family spelling, inferred) spacing switch; considered: `setspace` (not used, the command is the class's own) |
| table of contents | main.tex:28 | `toc.kernel` | `\tableofcontents*`, starred form, whose meaning is the class's (source not read) |
| headings | main.tex:32, 37, 40, 48 | `head.class-native` | `\chapter`, `\section` with no options; the look is the class's own (source not read) |
| citations | main.tex:4, 33, 42 | `bib.natbib` | `\usepackage{natbib}` no options; `\citet` |
| bibliography | main.tex:44-45; references.bib:1-7 | `bib.bibtex-bst` | `\bibliographystyle{plainnat}`, `\bibliography{references}`, one `@book` entry (content) |
| appendix | main.tex:47-50 | `num.appendix` | `\begin{appendix}` ... `\end{appendix}` around `\chapter{Supplementary Material}` |
| page geometry, running heads, fonts, heading style, spacing defaults | not set in the sample | `class.msu-thesis` | defaults inside the class source (not shipped, not read); the sample sets no geometry, header or font command |

## Bespoke code
none. `grep` for `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter`, `\newif`, `\RequirePackage` finds no definition in `main.tex`; the only package loads are main.tex:3-4. The zip has no other `.tex`, `.cls` or `.sty`.

## Content-opaque
none

## Lib changes
- New ways proposed: none. (`\SingleSpacing`, `\frontmatter`, `\mainmatter` stay under `class.msu-thesis`, the lib's convention for a published class's own vocabulary.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
