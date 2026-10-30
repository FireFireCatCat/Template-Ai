yes

# 0407-template-book-proposal: Template Book Proposal

- Unverified: read from the source, not compiled.
- Source: Source/0407-template-book-proposal/ (origin: https://latextemplates.com/downloads/template-book-proposal.zip; licence: CC-BY-4.0; ATTRIBUTION.txt:1-4 says it is based on José Pedro Costa's Overleaf template)
- Kind: book
- Lib: v4
- Engine: pdfLaTeX-compatible (README.md:3-4 says compile with pdfLaTeX; project.sty:3-5 loads `fontenc` T1, `inputenc` utf8, `lmodern`; no `fontspec`)
- Look carried by: mixed (kernel `book` defaults carry headings, contents and page styles; the zip-local project.sty sets A4 with 1in margins, T1 Latin Modern and loads packages; the sample preamble sets nothing visual)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; abstract.tex and chapter1.tex to chapter3.tex are `\input` body files)
- Read: main yes, zip-local classes and styles all

## Verdict
Yes. The class is the kernel `book` class with only `11pt,twoside`. The only zip-local code is project.sty (11 lines): nine `\RequirePackage` lines for published packages and one `\newcommand` alias for `\thispagestyle{empty}`. Both reduce to lib ways. The sample prints a front-matter abstract chapter, three lists of contents, two chapters with sections and a BibTeX bibliography. There is no artwork, no external tool and no irreducible macro. This is a thin starter: it is evidence about `class.book` and a handful of load-only packages, not about rich component styling.

## Blockers
none

## Class setting
- Class: `class.book` options: `11pt`, `twoside` (main.tex:1)
- Class-native vocabulary used: `\frontmatter` (main.tex:9), `\mainmatter` (main.tex:14), `\backmatter` (main.tex:18), `\chapter` and `\chapter*` (abstract.tex:1, chapter1.tex:1), `\section` (chapter1.tex:3); the class prints the bibliography heading itself (book `thebibliography`); no abstract environment (the book class has none), no `\maketitle`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.book` | 11pt, twoside |
| paper size and margins | project.sty:2 | `page.geometry` | a4paper, margin=1in |
| base size and sides | main.tex:1 | `page.class-options` | 11pt, twoside |
| font encoding | project.sty:3-4 | `font.fontenc-t1` | fontenc option T1; inputenc option utf8 |
| text and math face | project.sty:5 | `font.lmodern` | no options |
| language | project.sty:6 | `lang.babel` | no language option given (see Bespoke code notes) |
| hyperlinks and PDF metadata | project.sty:8 | `meta.hyperref` | no options, defaults; no `\hypersetup` anywhere |
| graphics loading | project.sty:7 | `fig.graphicx` | no options; the sample has no `figure` and no `\includegraphics` (grep) |
| code listings loading | project.sty:10 | `code.listings` | no options, no `\lstset` or `\lstdefinestyle`; no listing in the sample (grep) |
| first-page style | main.tex:8, project.sty:11 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` (through the alias `\prefrontmatter`); running heads and foots are the class defaults |
| front matter switch | main.tex:9 | `class.book` vocabulary | `\frontmatter`: roman page numbers, unnumbered chapters |
| abstract page | abstract.tex:1-3 | `head.kernel` | starred `\chapter*{Abstract}` followed by text; not the `abstract` environment |
| file inclusion | main.tex:10, 15-17 | `struct.input` | `\input{abstract}`, `\input{chapter1}` to `\input{chapter3}` |
| contents lists | main.tex:11-13 | `toc.kernel` | `\tableofcontents`, `\listoftables`, `\listoffigures`; no float exists, so the two lists are empty in this sample |
| main matter switch | main.tex:14 | `class.book` vocabulary | `\mainmatter`: arabic numbers restart, numbered chapters |
| chapters and sections | chapter1.tex:1,3; chapter2.tex:1,3; chapter3.tex:1,3 | `head.kernel` | `\chapter`, `\section`, class defaults, no `\renewcommand`, `titlesec` or `\setcounter` |
| back matter switch | main.tex:18 | `class.book` vocabulary | `\backmatter`: chapters unnumbered |
| bibliography | main.tex:19-20, refs.bib:1-6 | `bib.bibtex-bst` | style `plain`, database `refs`; no `\cite` or `\nocite` in the zip (grep), so the entry is not cited |
| inline monospace | chapter3.tex:4 | `mark.kernel` | `\texttt{refs.bib}` (content-level span) |
| title block | main.tex:3-6 | none | no `\maketitle` or `\title` exists; the four `\def` metadata macros are never expanded (see Bespoke code) |

Components checked and absent: lists, quotes, footnotes and notes, math, theorems, tables, figures and captions, boxes, index, cross-references (no `\label`/`\ref` in any .tex file), appendix, fonts beyond Latin Modern, colour, backgrounds.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `project` style (zip-local; ctan.org/pkg/project returns 404, so not published) | project.sty:1-11 | yes | `\ProvidesPackage` (project.sty:1) is a declaration with no effect. The nine `\RequirePackage` lines become: `page.geometry` (a4paper, margin=1in), `font.fontenc-t1` (T1, utf8), `font.lmodern`, `lang.babel`, `fig.graphicx`, `meta.hyperref`, `code.listings`; `etoolbox` has no printed effect and is dealt with below. An emitter writes these as preamble lines in the same order. |
| `\prefrontmatter` | project.sty:11, used at main.tex:8 | yes | Alias of `\thispagestyle{empty}`; expand inline as `hf.pagestyle-kernel`. Whether that call changes a printed page is not decided here (the following `\chapter*` issues its own `\thispagestyle`, so the effect may be nil); it is one kernel command either way. |
| `\projectauthor`, `\projecttitle`, `\projectmonth`, `\projectdepartment` | main.tex:3-6 | yes | Four `\def` strings that nothing expands (grep finds no other use in the .tex or .sty files); no effect on the output. If a title block were wanted they would be `front.maketitle` fields (`\title`, `\author`, `\date`), but the sample never calls `\maketitle`. |
| `etoolbox` load | project.sty:9 | yes | Load-only programming helper; no etoolbox command is called in any file (grep for `\ifdef`, `\patchcmd`, `\apptocmd`, `\pretocmd`, `\newtoggle`, `\AtBeginDocument` found none). It has no printed effect and no node to wrap, the same finding as the lib's v4 rejection of `sys.compat-load` and `sp.xspace`; the verdict does not rest on it. Considered: etoolbox. |

Notes on risk, not blockers (nothing compiled): `babel` is required with no language option (project.sty:6) and the class options `11pt,twoside` name no language. Recent babel releases fall back to a default language with a warning; older ones stop with an error. This is a parameter default of `lang.babel`, and a Flouest emitter would give it a language. `hyperref` is loaded before `listings` and `etoolbox` and with no options, as written.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
