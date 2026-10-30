yes

# 0203-book-of-abstracts: Book of Abstracts

- Unverified: read from the source, not compiled.
- Source: Source/0203-book-of-abstracts/ (origin: https://latextemplates.com/downloads/book-of-abstracts.zip, upstream page https://www.overleaf.com/latex/templates/book-of-abstracts/vxxsznnfjzzj per ATTRIBUTION.txt:4; licence: CC-BY-4.0, credit José Pedro Costa, ATTRIBUTION.txt:1-8)
- Kind: book (a conference book of abstracts: title page, contents, one chapter per contribution, hand-written indexes)
- Lib: v2
- Engine: pdfLaTeX-compatible (README.md:9 says compile with PDFLaTeX; no fontspec, no unicode-math)
- Look carried by: preamble (kernel `book` defaults, plus the preamble's `geometry`, `hyperref` colours and one `\abstractentry` macro; the zip holds no class or style file)
- Class origin: tex-distribution-unbundled (`book` is a LaTeX base class, not in the zip; its source was not read)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The zip is one 60-line `main.tex` on the kernel `book` class with five published packages and one `\newcommand`. That macro, `\abstractentry` (main.tex:10-14), only composes kernel commands (`\chapter*`, `\addcontentsline`, `\textbf`, `\textit`, `\hfill`, `\smallskip`, `\medskip`) and is reducible by expanding it per entry. There is no zip-local class, style, counter, conditional or artwork, and nothing needs a tool outside TeX. The "generate this section from a CSV file with a small script" line (main.tex:25-26) is body text for the template's user, not a dependency of the document.

## Blockers
none

## Class setting
- Class: `class.book` options: `11pt`, `a4paper` (main.tex:1)
- Class-native vocabulary used: `\frontmatter` (main.tex:21), `\mainmatter` (main.tex:29), `\backmatter` (main.tex:56), `\chapter*` (main.tex:11, 23, 40, 48, 57), `\maketitle` (main.tex:22), `\tableofcontents` (main.tex:27). `\frontmatter` and `\mainmatter` also switch the page-number style by class default (the sample calls no `\pagenumbering`).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.book` | 11pt, a4paper |
| paper and base size | main.tex:1 | `page.class-options` | a4paper, 11pt |
| page geometry | main.tex:3 | `page.geometry` | margin=25mm (all four sides) |
| fonts | main.tex:4 | `font.lmodern` | `lmodern` loaded with no `fontenc`/`inputenc` line (OT1 default) |
| colour | main.tex:6 | `color.xcolor` | package loaded, no options; used by the hyperref colour expression `blue!50!black` (main.tex:8) |
| hyperlinks | main.tex:7-8 | `meta.hyperref` | colorlinks=true, linkcolor=blue!50!black, urlcolor=blue!50!black |
| title block | main.tex:16-18, 22 | `front.maketitle` | `\title{Book of Abstracts}`, `\author{Conference or Workshop Name}`, `\date{\today}`; `book` default title page |
| front matter switch | main.tex:21, 29, 56 | `class.book` (native commands) | `\frontmatter`, `\mainmatter`, `\backmatter` |
| unnumbered chapters (Welcome, Author index, Keyword index, Organiser notes) | main.tex:23, 40, 48, 57 | `head.kernel` | `\chapter*{...}` with the class default look; no `titlesec`, no `\renewcommand` |
| contents | main.tex:27 | `toc.kernel` | `\tableofcontents`, default depth |
| contents entries for starred chapters | main.tex:11, 41, 49 | `toc.kernel` | `\addcontentsline{toc}{chapter}{<title>}` (kernel toc-family command) |
| abstract entry title | main.tex:11 | `head.kernel` | `\chapter*{#1}` per contribution |
| abstract entry byline | main.tex:12 | `mark.kernel` | `\textbf{#2}` (authors) left, `\textit{#3}` (affiliation) right |
| abstract entry byline spacing | main.tex:12-13 | `sp.manual-space` | `\hfill` between authors and affiliation, `\smallskip` after the byline, `\medskip` after the keyword line |
| keyword line | main.tex:13 | `abs.keywords` | `\textit{Keywords:} #4\par` (the `\par\textbf{Keywords}` pattern with italic label) |
| abstract body | main.tex:32-33, 37-38 | content | running text and inline `$E=mc^2$`; no `abstract` environment is used |
| inline math | main.tex:33 | `math.kernel` | inline `$...$` only; no display maths, no `amsmath` (content) |
| author index and keyword index | main.tex:42-46, 50-54 | `list.kernel` | `description` environment, hand-written items (not `idx.makeidx`) |
| index list parameters | main.tex:5, 42, 50 | `list.enumitem` | `[leftmargin=!,labelwidth=35mm]` on both description lists |
| header/footer | none set (no `\pagestyle`) | `hf.class-native` | `class.book` default running heads, no command in the sample |
| bibliography, footnotes, floats, tables, theorems, code, boxes | none in the sample | none | the sample defines and uses none (main.tex:58-59 only says to add a bibliography if wanted) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\abstractentry{title}{authors}{affiliation}{keywords}` | main.tex:10-14 | yes | Expand per entry: `head.kernel` `\chapter*{title}` + `toc.kernel` `\addcontentsline{toc}{chapter}{title}`; `mark.kernel` `\textbf{authors}` + `sp.manual-space` `\hfill` + `mark.kernel` `\textit{affiliation}` + `\par\smallskip`; `abs.keywords` `\textit{Keywords:} keywords\par\medskip`. No counter, conditional or output routine. |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- No text addressed to an AI was found in `main.tex`, `README.md` or `ATTRIBUTION.txt`.
- `\addcontentsline` after `\chapter*` is used with `hyperref` loaded and no `\phantomsection` (main.tex:11, 41, 49); the emitter reproduces the same lines, so it inherits whatever link anchors that gives. Not checked by compiling.
- The README (README.md:9) tells the user to edit the `abstractentry` calls; in a Flouest emitter each contribution is one chapter-level node whose four fields fill the expansion above.
