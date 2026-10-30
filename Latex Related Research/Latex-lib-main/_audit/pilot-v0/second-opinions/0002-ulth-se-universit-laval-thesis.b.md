yes

# 0002-ulth-se-universit-laval-thesis: ulthese (Universite Laval thesis class), MSc starter

- Unverified: read from the source, not compiled.
- Source: Source/0002-ulth-se-universit-laval-thesis/ (origin: https://latextemplates.com/downloads/ulthese.zip; licence: LPPL-1.3c)
- Kind: thesis
- Lib: v0
- Engine: pdfLaTeX-compatible (main.tex:8 says pdflatex + bibtex; class source not read, so this is the sample's own claim)
- Main file: main.tex (other samples: none; chapter files are `\include`d by main.tex)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip holds no `.cls`, `.sty`, `.def` or `.cfg` and no `\newcommand`, `\def`, counter, environment or `\usepackage` in any `.tex` file (grep over all `*.tex`, no hits). Everything the sample uses is either kernel/babel/hyperref/BibTeX vocabulary or the vocabulary of one published CTAN class, `ulthese` (LPPL 1.3c, public documentation). By the rubric a published class that is not bundled is one way, so the look is recovered by writing the same `\documentclass` line and the same class-native commands. Caveat: the `ulthese` source was not read (it is not in the zip), so what it loads internally is inferred from what the sample calls.

## Blockers
none

## Class setting
- Class: `class.ulthese` options: `MSc`, `french`, `english` (main.tex:10). Not bundled; it ships with the TeX distribution. Source not read. The CTAN page https://ctan.org/pkg/ulthese (one of the allowed reads) gives: Universite Laval Faculty of Graduate Studies thesis class, built on memoir, LPPL 1.3c, maintainers Vincent Goulet and Pierre Lasou, documentation in French. The version the zip was written against is not recorded in the zip.
- Class-native vocabulary used: `\titre` `\auteur` `\programme` `\direction` (main.tex:20-23), `\frontispice` (main.tex:29), `\frontmatter` (main.tex:27) and `\mainmatter` (main.tex:47) as inherited from the memoir/book family, `\chapter`, `\chapter*`, `\section`, `\tableofcontents` `\listoftables` `\listoffigures` (main.tex:35,38,41).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:10 | `class.ulthese` | options MSc, french, english (last babel language is the main one by babel convention, matching "English mode" at main.tex:1; how the class forwards them is unread) |
| page geometry, paper size, base font size | none set in the sample; class-internal | `page.class-options` | no geometry or size command in any file; the class applies its own layout (unread). Emitter writes only the class options |
| running heads, page style | none set in the sample; class-internal | `hf.class-native` | nothing set in the sample; look comes from the class (unread) |
| fonts, spacing, colour | none set in the sample | (class default, no lib way needed) | no font, `setspace`, colour or `\setlength` call in any file |
| title page | main.tex:20-23, 29 | `front.class-native` | `\titre{Adaptive Sampling Strategies for Environmental Sensor Networks}`, `\auteur{Alexandre Bouchard}`, `\programme{Ma\^itrise en g\'enie \'electrique}`, `\direction{Prof. Marie Tremblay, directrice de recherche}`, then `\frontispice` |
| front/main matter split | main.tex:27, 47 | `front.class-native` | `\frontmatter` ... `\mainmatter` (roman/arabic page numbering is whatever the class does; unread) |
| French resume and English abstract pages | resume.tex:1-12, abstract.tex:1-13, main.tex:31-32 | `head.kernel` | unnumbered `\chapter*{R\'esum\'e}` and `\chapter*{Abstract}`; text wrapped in `otherlanguage*`. Not the class's abstract environment, so no `abs.*` way is used |
| acknowledgement and foreword pages | remerciements.tex:1-10, avant-propos.tex:1-9, main.tex:44-45 | `front.dedication` | unnumbered `\chapter*{Remerciements}` and `\chapter*{Avant-propos}`; text in `otherlanguage*` (french, english) |
| TOC entry for each starred chapter | resume.tex:3, abstract.tex:3, remerciements.tex:3, avant-propos.tex:3 | `toc.kernel`, `meta.hyperref`, `xref.hyperref` | `\phantomsection\addcontentsline{toc}{chapter}{\nameref{<label>}}` (kernel `\addcontentsline`; `\phantomsection` from hyperref; `\nameref` from hyperref/nameref) |
| contents, list of tables, list of figures | main.tex:35,38,41 | `toc.kernel` | plain `\tableofcontents`, `\listoftables`, `\listoffigures`; the sample has no table or figure, so both lists print empty |
| page breaks between front-matter parts | main.tex:33,36,39,42 | `pg.break` | `\cleardoublepage` x4 |
| file splitting | main.tex:31,32,44,45,49-52 | `pg.break` | kernel `\include{...}` x8 (it implies `\clearpage`); no template look of its own, structure only |
| chapters and sections | introduction.tex:1,11,18; chapitre1.tex:1,5,10,15; chapitre2.tex:1; conclusion.tex:1 | `head.class-native` | `\chapter{...}` x4 and `\section{...}` x5, no `titlesec`/`\renewcommand`; look comes from the class (unread) |
| labels and refs | all chapter files line 2 (`\label{chap-...}`), `\nameref` x4 | `xref.kernel`, `xref.hyperref` | `\label` x8, `\nameref` x4 |
| hyperref | used via `\phantomsection`/`\nameref` (resume.tex:3 etc.); no `\hypersetup` in the sample | `meta.hyperref` | options are set by the class if at all (unread). The sample loads nothing itself, so hyperref must be class-loaded |
| language switching | main.tex:10, 12-16; `otherlanguage*` x8 (abstract.tex:5, avant-propos.tex:5, chapitre1.tex:4, chapitre2.tex:4, conclusion.tex:4, introduction.tex:4, remerciements.tex:5, resume.tex:5) | `lang.babel` | languages french, english; `\frenchsetup{StandardItemizeEnv=true, ThinSpaceInFrenchNumbers=true, og=«, fg=»}`; `otherlanguage*{english}` x6, `otherlanguage*{french}` x2. `\frenchsetup` is babel-french's setup command (that is from my background knowledge: the CTAN page https://ctan.org/pkg/babel-french, second allowed read, shows the package is LPPL 1.3c but does not list the command) |
| input encoding for the guillemets | main.tex:15 | `font.fontenc-t1` | the file holds UTF-8 `«` `»`; the sample loads no encoding package, so this is the kernel UTF-8 default or class-loaded. Other accents are written as `\'e` escapes (content) |
| bullet list | introduction.tex:20-29 | `list.kernel` | `itemize` with 3 items; French list look suppressed by `StandardItemizeEnv=true` (main.tex:13) |
| citations | chapitre1.tex:8,13; introduction.tex:9,14 | `bib.natbib` | `\citep{Jain2004}`, `\citep{Alippi2008}` x4. natbib is inferred, not seen: the sample loads no package, so the class must load it (unread) |
| bibliography | main.tex:18, 54; references.bib:1-17 | `bib.bibtex-bst` | `\bibliographystyle{apalike}`, `\bibliography{references}`, two `@article` entries (content). Build is pdflatex, bibtex, pdflatex x2 (main.tex:8) |

Not used by the sample, so not mapped: equations, theorems, tables, figures, captions, code, boxes, index, glossary, footnotes, margin notes, quotes, appendix, columns, backgrounds, colour, custom headers/footers.

## Bespoke code
none. No `.cls`, `.sty`, `.def`, `.cfg`, `.clo`, `.bbx` or `.cbx` in the zip. No `\newcommand`, `\renewcommand`, `\def`, `\let`, `\newenvironment`, `\newcounter`, `\newif`, `\makeatletter`, `\setlength`, `\usepackage` or `\RequirePackage` in any `.tex` file. No text addressed to an AI was found; the comments in main.tex:1-8 describe Laval's French-abstract policy and the compile order.

## Content-opaque
none

## Lib changes
- New ways proposed: none. Every component maps to an existing lib way; `class.ulthese` is a class way and needs no proposal.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
