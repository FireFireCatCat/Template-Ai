yes

# 0023-korigamik-assignment: KorigamiK Assignment

- Unverified: read from the source, not compiled.
- Source: Source/0023-korigamik-assignment/ (origin: https://latextemplates.com/downloads/korigamik-assignment.zip; licence: GPL-3.0-or-later)
- Kind: assignment (university homework starter with a designed cover page)
- Lib: v1 (the snapshot read)
- Engine: pdfLaTeX-compatible (README.md:7 says pdflatex; the sample loads no fontspec or other xe/lua package, main.tex:17-50; the class source was not read, so what the class loads is not checked)
- Look carried by: class (the whole look is the published `korigamik` class; the sample only fills its title-block fields with strings, main.tex:17-27, and then uses plain article-style sectioning and BibTeX, main.tex:33-48)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip holds only `main.tex` (50 lines), `references.bib` (6 lines) and `README.md` (25 lines); there is no `.cls`, `.sty` or other local file and the sample defines no macro, so there is no zip-local code. The look is carried entirely by the published `korigamik` class (CTAN, GPL v3 or later, in TeX Live and MiKTeX, "based on the article class"; one read of https://ctan.org/pkg/korigamik; README.md:8 and main.tex:3-8 say it is not bundled). Its source was therefore not read, so I could not check what the class loads or how its cover page is built; by the rubric a published class not bundled in the zip is one way, `class.korigamik`, and the sample adds only class-native string fields, kernel sectioning and a `plain` BibTeX bibliography. Caveat: the field meanings below come from README.md:12-24 and the sample's own comments, not from the class source.

## Blockers
none

## Class setting
- Class: `class.korigamik` options: none (`\documentclass{korigamik}`, main.tex:17)
- Class-native vocabulary used: `\maketitle` (builds the designed cover page, main.tex:31; README.md:12-14), `\rollno{}` (main.tex:21), `\subject{}` (main.tex:22), `\course{}` (main.tex:23), `\semester{}` (main.tex:24), `\titlelabel{}` (corner label of the title box, main.tex:25; README.md:22-23), `\header{}` (running head on later pages, main.tex:26; README.md:23), `\bottomnote{}` (institute line under the date, main.tex:27; README.md:24). Not used by the sample: `\logoimage{path}{scale}{label}` (README.md:18-20; without it the class prints its own placeholder `<your logo here>`). No abstract, no table of contents, no appendix.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:17 | `class.korigamik` | no options; class is article-based (CTAN page; README.md:14) |
| page size, geometry | none in sample (main.tex:17-50) | `class.korigamik` | class default; no `geometry`, no `\setlength` |
| title, author fields | main.tex:19-20 | `front.maketitle` | `\title{Your Title Here}`, `\author{Ada Lovelace}` (kernel fields read by the class's `\maketitle`) |
| designed cover page (boxed title, corner label, details table, optional logo) | main.tex:21-25,27,31; README.md:3-5,12-14 | `front.class-native` | `\rollno{2026-A-001}`, `\subject{Analytical Engines}`, `\course{Computer Science}`, `\semester{Fall 2026}`, `\titlelabel{Assignment}`, `\bottomnote{Institute of Analytical Engines}`, then `\maketitle`; `\logoimage` not called (placeholder) |
| running head on later pages | main.tex:26; README.md:23 | `hf.class-native` | `\header{Your Title Here}`; footer and page-number style not set by the sample (class default, not read) |
| sectioning | main.tex:33,36,40,44; README.md:14 | `head.kernel` | four numbered `\section`, kernel look as the class falls back to article sectioning (README.md:14); no `\titleformat`, no counter changes |
| labels | main.tex:37,41 | `xref.kernel` | `\label{sec:method}`, `\label{sec:results}`; no `\ref` in the sample |
| citation | main.tex:34; references.bib:1-6 | `bib.bibtex-bst` | `\cite{knuth1984texbook}`; one `@book` entry |
| bibliography | main.tex:47-48; README.md:25 | `bib.bibtex-bst` | `\bibliographystyle{plain}`, `\bibliography{references}` (classic `bibtex`, no biber, no natbib) |

Not defined or used by the sample (so no row): fonts and encoding (class default), colour, spacing, language, hyperref, abstract, lists, quotes, maths, theorems, floats, tables, captions, code, boxes, index, notes. Body text is content.

## Bespoke code
none. The sample has no `\newcommand`, `\def`, environment, counter or conditional (main.tex:17-50 read in full), and the zip ships no class or style file. The class's own macros are published (CTAN), not zip-local.

## Content-opaque
none in the zip. Inside the unbundled published class, the cover page's box, corner label and details table (and whatever drawing code builds them) were not read; they belong to `class.korigamik`, not to a zip-local file or to the sample.

## Lib changes
- New ways proposed: none. `class.korigamik` is written plainly per the rubric; the lib's class section is filled by script. Vocabulary to record for it: `\maketitle` cover page, `\rollno`, `\subject`, `\course`, `\semester`, `\titlelabel`, `\header`, `\bottomnote`, `\logoimage{path}{scale}{label}`; article-based.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
