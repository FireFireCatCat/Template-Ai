yes

# 0427-langsci: Language Science Press book (langscibook, minimal mode)

- Unverified: read from the source, not compiled.
- Source: Source/0427-langsci/ (origin: https://latextemplates.com/downloads/langsci-book.zip; licence: LPPL-1.3)
- Kind: book
- Lib: v4
- Engine: needs XeLaTeX (inferred, not established: the sample's comment names the OpenType fonts Libertinus, XITS and Arimo that the class loads outside `minimal` mode, main.tex:13-14; the class source was not read, so pdfLaTeX under `minimal` is not shown)
- Look carried by: mixed (the published class `langscibook` carries page, headings, contents, table, captions and bibliography; the sample's own `\maketitle` override carries the title block, main.tex:19-33)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes, on a narrow basis. The zip is two files, `main.tex` (84 lines) and `references.bib` (7 lines), and ships no class. The class `langscibook` is not bundled; it is the Language Science Press class, which `ctan.org/pkg/langsci` describes as the package for typesetting that press's monographs and edited volumes (LPPL 1.3, in TeX Live and MiKTeX), so it is one published class way whose source was not read. The sample only passes class options, uses class vocabulary, and replaces `\maketitle` with a short block that is spacing, font size and centring with no logic, which reduces to lib ways. What was not checked: what the class loads unconditionally (an `EXTERNAL/package` check is impossible without its source), and whether `\citep` and `\toprule` come from the class.

## Blockers
none

## Class setting
- Class: `class.langscibook` options: `output=book`, `minimal`, `biblatexbackend=bibtex` (main.tex:1). Proposed engine tag for the class line: xe/lua (inferred, see header).
- Class-native vocabulary used: `\subtitle` (main.tex:4), `\BackBody` (6-7), `\addbibresource` (9), `\frontmatter` `\mainmatter` (34, 37), `\chapter` `\section` (39, 41, 48, 67, 69, 75), `\citep` (44, 73), `\printbibliography` (82).
- Class-internal and not exercised by this sample, source not read: cover generation (skipped by `minimal`, per main.tex:79-80), the OpenType fonts Libertinus, XITS, Arimo (main.tex:13-14, skipped by `minimal`), and the class's own `\maketitle` that prints "You are using the minimal mode." (main.tex:14-15), which the sample overrides. Origin note: the zip comes from latextemplates.com, not from the publisher's own page, so it is not a publisher-official kit; W1 rests on CTAN and TeX Live. `ctan.org/pkg/langscibook` is a 404; the file name `langscibook` is taken from the sample and the `langsci` package description (the CTAN page lists no files).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.langscibook` | `output=book`, `minimal`, `biblatexbackend=bibtex` |
| page geometry, running heads, fonts, cover (class-set; nothing in the sample) | main.tex:1; main.tex:45-46 (prose only) | `class.langscibook` | none passed; the class's defaults, not read |
| title, author data | main.tex:3, 5 | `front.maketitle` | `\title{Notes on Open-Access Book Production}`, `\author{Noor Fatima}` |
| subtitle, back-cover text | main.tex:4, 6-7 | `front.class-native` | `\subtitle`, `\BackBody{...}` (a string; used only by the cover, skipped under `minimal`) |
| title block (override of `\maketitle`) | main.tex:19-33 | `front.titlepage-env` | hand-laid block: group, centred, title, subtitle, author, then a page end (see Bespoke) |
| title block spacing | main.tex:23, 25, 27 | `sp.manual-space` | `\vspace*{3cm}`, `\vspace{0.5cm}`, `\vspace{1.5cm}` |
| title block sizes | main.tex:24, 26, 28 | `font.size-commands` | `\LARGE` (title), `\large` (subtitle and author) |
| title block weight | main.tex:24 | `mark.kernel` | `\bfseries` on the title |
| title block alignment | main.tex:22 | `sp.ragged` | `\centering` inside `\begingroup` ... `\endgroup` (29) |
| title block page end | main.tex:30 | `pg.break` | `\clearpage` |
| front and main matter | main.tex:34, 37 | `front.class-native` | `\frontmatter`, `\mainmatter` (book-type commands as the class provides them) |
| contents | main.tex:35 | `toc.kernel` | `\tableofcontents`; entry look is the class's |
| chapters and sections | main.tex:39, 41, 48, 67, 69, 75 | `head.class-native` | `\chapter`, `\section`; look and numbering are the class's, nothing set in the sample |
| table float and body | main.tex:53-65 | `tbl.tabular` | `table[h]`, `\centering` (54), `tabular{ll}` (55) |
| table rules | main.tex:56, 58, 61 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule`; no `\usepackage{booktabs}` in the sample, so the class must load it (not confirmed) |
| table caption and label | main.tex:63-64 | `cap.kernel` | `\caption{...}`, `\label{tab:sections}`; caption look is the class's (a `caption` package load inside the class is not confirmed) |
| cross-reference | main.tex:50 | `xref.kernel` | `Table~\ref{tab:sections}` |
| inline code font | main.tex:44, 71, 79 | `mark.kernel` | `\texttt{...}` |
| bibliography | main.tex:1, 9, 44, 73, 82; references.bib:1-7 | `bib.biblatex-bibtex` | `biblatexbackend=bibtex` as a class option; `\addbibresource{references.bib}`; `\citep{knuth1984texbook}`; `\printbibliography`; the entry is a `@book` (bib:1) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\maketitle}` with `\makeatletter`, `\@title`, `\@subtitle`, `\@author` | main.tex:19-33 | yes | Inline body block, no macro: `\begingroup`, `\centering` (`sp.ragged`), `\vspace*{3cm}` (`sp.manual-space`), `{\LARGE\bfseries <title>\par}` (`font.size-commands`, `mark.kernel`), `\vspace{0.5cm}`, `{\large <subtitle>\par}`, `\vspace{1.5cm}`, `{\large <author>\par}`, `\endgroup`, `\clearpage` (`pg.break`). The `\@...` fields are replaced by the strings, so `\makeatletter` and the redefinition are not needed. No counters, conditionals or box algorithms. |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and not proposed: none (every sample construct has a home; `class.langscibook` needs no proposal).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
