yes

# 0671-droit-fr-french-legal-thesis: droit-fr French Legal Thesis (starter for the CTAN `droit-fr` class)

- Unverified: read from the source, not compiled.
- Source: Source/0671-droit-fr-french-legal-thesis/ (origin: https://latextemplates.com/downloads/droit-fr.zip; licence: LPPL-1.3 per the manifest; README.md:9 says the `droit-fr` bundle is LPPL 1.3 or later)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (the sample loads `fontenc` T1 and no `fontspec`, main.tex:2; the class source was not read, so its own engine needs are inferred; the CTAN page says the class assumes biber and BibLaTeX)
- Look carried by: class (the zip holds only a starter `main.tex` and `references.bib`; the page look, title page, heading hierarchy and numbering come from the published class `droit-fr`, README.md:3-8, main.tex:1)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (no `.cls`, `.sty`, `.bst`, `.cfg` in the zip; the `droit-fr` class source was not read)

## Verdict
The zip adds only a short sample document on top of the published `droit-fr` class (CTAN, Yves de Saint-Pern, LPPL 1.3, v1.2 of 2016-02-20, also in TeX Live and MiKTeX; one read of https://ctan.org/pkg/droit-fr). The class is one way, `class.droit-fr`, and the sample's own preamble is four published packages (`fontenc`, `microtype`, `hyperref`, `biblatex` with biber) with plain options. The zip defines no macro, environment or counter and has no artwork. The class's internals were not read, so what it loads itself (running heads, heading look, babel) is inferred, not seen; that is a limit of this analysis, not a blocker. This is evidence about the class dimension, not about the component ways.

## Blockers
none

## Class setting
- Class: `class.droit-fr` options: `a4paper,12pt,french,twoside,footnotereset=true,versetitle=true` (main.tex:1). `footnotereset` and `versetitle` are class-native boolean options; the rest are standard paper, size, language and side options.
- Class-native vocabulary used: metadata commands `\author{first}{last}` (main.tex:11), `\university` (main.tex:13), `\school` (main.tex:14), `\speciality` (main.tex:15), `\approvaldate` (main.tex:16), `\director{civility}{first}{last}{position}` (main.tex:17), `\reportera` `\reporterb` (main.tex:18-19), `\membera` `\memberb` (main.tex:20-21), title page command `\maketitlepage` (main.tex:24), book-style `\frontmatter` `\mainmatter` (main.tex:26, 34), French legal hierarchy `\partie` (main.tex:35, 69), `\titre` (main.tex:41), `\chapitre` (main.tex:47), `\paragraphe` (main.tex:62), numbered-paragraph command `\verset{}` (main.tex:36, 42, 48, 54, 63, 70); standard `\title` (main.tex:12), `\chapter*` (main.tex:27), `\section` (main.tex:53), `\tableofcontents` (main.tex:32), `\footnote` (main.tex:59).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.droit-fr` | options `a4paper,12pt,french,twoside,footnotereset=true,versetitle=true` |
| paper, size, sides | main.tex:1 | `page.class-options` | `a4paper`, `12pt`, `twoside` |
| language | main.tex:1 | `lang.babel` | class option `french`; inferred, the class's own loading of the language package was not read |
| font encoding | main.tex:2 | `font.fontenc-t1` | `[T1]` |
| microtypography | main.tex:3 | `sp.microtype` | no options |
| hyperlinks and PDF metadata | main.tex:4, 9 | `meta.hyperref` | default options; `\hypersetup{pdftitle={Une étude sur la preuve numérique},pdfauthor={Claire Martin}}` |
| bibliography | main.tex:7-8, 76; references.bib:1-15 | `bib.biblatex-biber` | `style=numeric,backend=biber,indexing=cite`; `\addbibresource{references.bib}`; `\printbibliography` (the numeric style replaces the class's own 2016 style, main.tex:5-6, README.md:13-15) |
| thesis metadata and title page | main.tex:11-21, 24 | `front.class-native` | author, university, school, speciality, approval date, director, two reporters, two members as arguments; `\maketitlepage` |
| front and main matter | main.tex:26, 34 | `front.class-native` | `\frontmatter`, `\mainmatter`; the page-number switch they bring is inferred (class unread) |
| summary page | main.tex:27-31 | `head.class-native` | `\chapter*{Résumé}`, an unnumbered chapter, no `abstract` environment |
| table of contents | main.tex:32 | `toc.kernel` | `\tableofcontents`, no options |
| legal hierarchy and numbered paragraphs | main.tex:35, 36, 41, 47, 53, 62, 69, 70 | `head.class-native` | `\partie`, `\titre`, `\chapitre`, `\section`, `\paragraphe`, `\verset{}`; look set by option `versetitle=true` (main.tex:1) |
| footnote | main.tex:59-60 | `fn.kernel` | `\footnote{...}`; numbering restart by class option `footnotereset=true` (main.tex:1) |
| running heads, heading format, numbering depth | main.tex:1 (no setting in the sample) | `hf.class-native` | carried by the class; the sample sets no page style, so nothing to read; class source not read |

## Bespoke code
none

The sample has no `\newcommand`, `\def`, environment, counter or conditional (main.tex:1-77). The zip holds no class or style file. `droit-fr` is a published class, not zip-local bespoke code.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Considered and rejected: a `legal.*` way. `legal.contract` (`contract`/`scrjura`) is numbered clauses, not the French thesis hierarchy; those commands are `droit-fr` vocabulary, recorded under the class way.
- The README (README.md:1-15) and the comment at main.tex:5-6 say the starter replaces the class's own bibliography style with `biblatex` numeric because the 2016 style fails with the pinned biblatex. The look of the references list is then biblatex's, not the class's.
- No text addressed to an AI was found in the zip.
