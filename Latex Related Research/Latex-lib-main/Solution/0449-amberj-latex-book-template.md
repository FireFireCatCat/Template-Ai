yes

# 0449-amberj-latex-book-template: AmberJ LaTeX Book Template

- Unverified: read from the source, not compiled.
- Source: Source/0449-amberj-latex-book-template/ (origin: https://latextemplates.com/downloads/amberj-latex-book-template.zip; licence: ISC, stated in main.tex:4 and the manifest)
- Kind: book
- Lib: v4
- Engine: pdfLaTeX-compatible (T1, inputenc utf8, lmodern, hyperref, babel; `\dimexpr` is e-TeX, present in pdfLaTeX)
- Look carried by: mixed (the kernel `book` class carries headings, running heads, contents and numbering; the sample's own preamble adds two environments, `dedication` and `chapquote`, and one chapter-label tweak)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: book-template.tex, byte-identical to main.tex by `cmp`)
- Read: main yes, zip-local classes and styles none present (the zip holds only README.md, main.tex, book-template.tex; no .cls, .sty or other style file)

## Verdict
The look is the stock kernel `book` class with the usual front-end packages (`fontenc`, `inputenc`, `lmodern`, `hyperref`, `graphicx`, `babel`) and no package options. The only bespoke code is three small preamble items (main.tex:22-34, 41, 42-47), and each one is a composition of kernel commands (page break, empty page style, stretch spacing, minipage, `\parshape`, font switches, `\hfill`) or a one-string label change, so each reduces by inline expansion to lib ways. There is no artwork, no external tool and no unmapped component, so the verdict is yes. The one judgement call is `\renewcommand{\@chapapp}{}` (main.tex:41), a kernel-internal label word, which I treat as a string parameter and not as a redefinition of the sectioning machinery.

## Blockers
none

## Class setting
- Class: `class.book` options: `a4paper`, `11pt` (main.tex:7). Source not read, it ships with the TeX distribution; book.cls in a local TinyTeX install was grepped only to confirm the macros named below.
- Class-native vocabulary used: `\frontmatter` (main.tex:64), `\mainmatter` (main.tex:81), `\chapter`, `\chapter*` (main.tex:86, 125), `\maketitle` in its `titlepage` form (main.tex:65; book.cls maps `\footnote` to `\thanks` there, so the two title footnotes at main.tex:57 print as author-note footnotes), `\tableofcontents` `\listoffigures` `\listoftables` (main.tex:77-79), `\@chapapp` (the chapter label word, `\newcommand\@chapapp{\chaptername}` in book.cls), default page style `headings`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:7 | `class.book` | a4paper, 11pt |
| paper and size | main.tex:7 | `page.class-options` | a4paper, 11pt; no geometry, margins are the class default |
| font encoding | main.tex:8-9 | `font.fontenc-t1` | fontenc T1, inputenc utf8 |
| text font | main.tex:10 | `font.lmodern` | no options |
| language | main.tex:16 | `lang.babel` | english |
| hyperlinks | main.tex:14 | `meta.hyperref` | default options, no `\hypersetup` |
| url printing | main.tex:59, 100, 113-114, 120, 161 | `meta.url` | `\url{...}`; the command comes with hyperref, also inside footnotes and `\thanks` |
| graphics package | main.tex:15 | `fig.graphicx` | load only; no figure or `\includegraphics` in the sample |
| title block | main.tex:57, 59, 65 | `front.maketitle` | `\title{...\\...}`, `\author{...}`, `\maketitle` after `\frontmatter`, class `titlepage` layout |
| title font sizes and marks | main.tex:57, 59 | `font.size-commands`, `mark.kernel` | `\Huge`, `\huge`, `\textbf`, `\textsc` |
| title and author notes | main.tex:57, 59 | `front.thanks`, `fn.kernel` | two `\footnote` in `\title` (printed as notes by book's `\maketitle`), one `\thanks` in `\author` |
| manual line break in title | main.tex:57 | `sp.manual-space` | `\\` |
| dedication page | main.tex:22-34, 70-72 | `front.dedication` | env `dedication`: new right page, empty page style, stretch 1 above and 3 below, 0.66 text-width ragged-right block flushed right (see Bespoke code) |
| dedication page flow | main.tex:24, 33 | `pg.break` | `\cleardoublepage`, `\clearpage` |
| dedication page style | main.tex:25 | `hf.pagestyle-kernel` | `\thispagestyle{empty}`; the rest of the book keeps the class default `headings` (book.cls:734), nothing in the sample sets a page style |
| dedication spacing | main.tex:26, 32 | `sp.manual-space` | `\vspace*{\stretch{1}}`, `\vspace*{\stretch{3}}`, `\hfill` (main.tex:27) |
| dedication block | main.tex:27, 31 | `box.minipage` | `minipage[t]`, width 0.66`\textwidth` |
| dedication alignment | main.tex:28 | `sp.ragged` | `\raggedright` |
| contents lists | main.tex:77-79 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables` |
| chapter heading label | main.tex:41, 125 | `head.kernel` | `\renewcommand{\@chapapp}{}`: the word "Chapter" is blanked in chapter headings and running heads (book.cls:149, 381); label word is a string (see Bespoke code) |
| chapters | main.tex:86, 125 | `head.kernel` | `\chapter*` (unnumbered Preface), `\chapter` |
| sections | main.tex:89, 92, 95, 99, 111, 131, 152, 157, 160, 165, 171, 207, 210 | `head.kernel` | `\section*`, `\section`, `\subsection` at class defaults, no `titlesec` |
| chapter quote | main.tex:42-47, 127-129 | `sp.lengths`, `mark.kernel`, `sp.manual-space` | env `chapquote[2em]`: `\parshape 1 2em (\textwidth-4em)`, `\itshape`, closing line `\hfill-- author\hspace*{2em}`, `\bigskip` (see Bespoke code) |
| inline emphasis | main.tex:138, 146, 202 | `mark.kernel` | `\emph`; `\textit` inside the chapquote argument (main.tex:127) |
| paragraph indent switch | main.tex:119-120, 150, 205 | `sp.lengths` | `\noindent`, the paragraph-indentation family of `\parindent`; one judgement call, no lib line names `\noindent` |
| manual line breaks and blank line | main.tex:117, 132, 198 | `sp.manual-space` | `\\` between sentences, `\mbox{}\\` as an empty line |
| bullet lists | main.tex:101-105, 112-116, 199-203 | `list.kernel` | `itemize`, class default labels and spacing |
| footnotes | main.tex:100, 113-114, 150, 161, 205 | `fn.kernel` | `\footnote`, class default footnote layout, no `footmisc` |
| table float | main.tex:178, 196 | `fig.graphicx` | the kernel `table` float with placement `[ht]`; same kernel float mechanism as the `figure` float the lib line names, and the lib has no separate table-float line (no new way proposed) |
| table | main.tex:181-194 | `tbl.tabular` | `tabular{c c c c}`, `\hline\hline` double rule, row-end lengths `\\ [0.5ex]` and `\\ [1ex]`; no `booktabs` |
| table caption | main.tex:179 | `cap.kernel` | `\caption{Sample table}` above the tabular, no `caption` package |
| table centring | main.tex:180 | `sp.ragged` | `\centering` |
| label | main.tex:195 | `xref.kernel` | `\label{table:nonlin}`; no `\ref` in the sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| env `dedication` | main.tex:22-34 | yes | Inline expansion at the use (main.tex:70-72): `\cleardoublepage` (`pg.break`), `\thispagestyle{empty}` (`hf.pagestyle-kernel`), `\vspace*{\stretch{1}}`, `\hfill` (`sp.manual-space`), `\begin{minipage}[t]{0.66\textwidth}` (`box.minipage`), `\raggedright` (`sp.ragged`), text, `\end{minipage}`, `\vspace*{\stretch{3}}`, `\clearpage`. Only kernel commands and lengths; no counters or conditionals. Emitted as the `front.dedication` way. |
| `\renewcommand{\@chapapp}{}` | main.tex:41 (inside `\makeatletter`, main.tex:40-48) | yes | `\@chapapp` is `\chaptername` in book.cls:283 and prints before `\thechapter` in chapter headings and running heads (book.cls:149, 168, 381). Setting it to the empty string is a string value of a label word (`head.kernel`, a `\renewcommand` of the heading format), the same effect as blanking `\chaptername`. The sample has no `\appendix`, which would reset it (book.cls:523). The author's own comment calls it "Not necessary" (main.tex:41); read here as having the effect above. The source of book.cls was only grepped. |
| env `chapquote[2][2em]` | main.tex:42-47 | yes | Stores the argument in `\chapquote@author` (a text macro) and the indent in the kernel scratch `\@tempdima`; no conditionals, no counters, no box algorithm. Inline expansion at main.tex:127-129: `\parshape 1 2em \dimexpr\textwidth-4em\relax` (`sp.lengths`: the paragraph-shape primitive, a sibling of `\hangindent`), `\itshape` (`mark.kernel`), the quote text, `\par\normalfont\hfill-- <author>\hspace*{2em}\par\bigskip` (`mark.kernel`, `sp.manual-space`). `\dimexpr` only computes a length. `\parshape` as a member of `sp.lengths` is the second judgement call; the lib line names `\hangindent` and `\hangafter` as the paragraph-shape parameters, and `\parshape` is the same type. |

## Content-opaque
none that blocks. Text-level notes, none of which is a template component:
- `\TeX{}` and `\LaTeX{}` in running text (main.tex:113-114): kernel logo macros inside the acknowledgement sentences, read as text content; no lib way is claimed (`font.icons` names `hologo`, a package that is not loaded).
- The "numbered list" at main.tex:134-148 is plain typed paragraphs ("1. ...", "8. ..."), not an `enumerate`; it is content, no list way is used there.
- `book-template.tex` repeats main.tex (identical by `cmp`), so it adds no component.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
