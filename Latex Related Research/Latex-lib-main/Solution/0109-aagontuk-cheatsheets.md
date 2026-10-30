no

# 0109-aagontuk-cheatsheets: LaTeX cheatsheet (aagontuk/cheatsheets)

- Unverified: read from the source, not compiled.
- Source: Source/0109-aagontuk-cheatsheets/ (origin: https://codeload.github.com/aagontuk/cheatsheets/zip/refs/heads/master; licence: not established)
- Kind: misc
- Lib: v2
- Engine: pdfLaTeX-compatible
- Look carried by: mixed (stock `article` at 11pt supplies page, headings, lists and title block; the preamble adds only `upquote` and `pygmentex`, which affect code text; no zip-local class, style or macro)
- Class origin: tex-distribution-unbundled
- Main file: latext_cheat.tex (other samples: none; `latext_cheat.pdf` is a shipped build output, not a source)
- Read: main yes, zip-local classes and styles none present

## Verdict
The look is stock `article` at 11pt with the kernel title block, table of contents, sectioning, lists and footnotes, and every one of those maps to an existing lib way with no bespoke code. It is still `no`: the preamble loads `pygmentex` unconditionally and the body uses its `pygmented` environment for the one code block. `pygmentex` runs Pygments, a Python program, outside TeX, which the rubric files under EXTERNAL (as `minted`). The rubric's ruling on unconditionally loaded external-tool packages applies as well, since the package is in the preamble whether or not the block is used.

## Blockers
- `EXTERNAL/package` `pygmentex` is loaded in the preamble (latext_cheat.tex:4) and `\begin{pygmented}[lang=tex]` is used for the code block (latext_cheat.tex:149-157). Its highlighting is done by the Pygments Python tool, a pass outside TeX. The CTAN page says only that it is Python-based and uses Pygments; the two-pass workflow is from the package's own documentation, which was not re-read here.

## Class setting
- Class: `class.article` options: `11pt` (latext_cheat.tex:1). The class is not in the zip (TeX distribution); its source was not read.
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (latext_cheat.tex:6-8, 12), `\tableofcontents` (13), `\section` `\subsection` `\subsubsection` (18, 20, 48), `description` `itemize` `enumerate` (36, 65, 88-96, 105-114), `\footnote` (89, 130). No `abstract`, no `\appendix` call (the word appears only inside `\verb`, line 122), no `\part` or `\chapter` call.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | latext_cheat.tex:1 | `class.article` | `11pt` |
| page size and text size | latext_cheat.tex:1 | `page.class-options` | `11pt` only; no `geometry`, no paper option, margins are the class defaults |
| defaults not written in the sample (margins, plain page style, arabic page numbers, heading numbering and depth, list indents) | latext_cheat.tex:1 | `class.article` | none set; no `\pagestyle`, `\setcounter`, `\setlength` anywhere in the file |
| title block | latext_cheat.tex:6-8, 12 | `front.maketitle` | `\title{\LaTeX\ Cheatsheet}`, `\author{Ashfaqur Rahman}`, `\date{May 12, 2018}` (fixed date), `\maketitle`; `\today` printed inline at :124 (kernel macro, content) |
| table of contents | latext_cheat.tex:13 | `toc.kernel` | `\tableofcontents`, no depth change, no list of figures or tables |
| page break after contents | latext_cheat.tex:14 | `pg.break` | `\newpage` |
| headings | latext_cheat.tex:18, 20, 32, 48 | `head.kernel` | `\section`, `\subsection`, `\subsubsection`; stock numbering and format, no `\titleformat`, no `\renewcommand` |
| lists | latext_cheat.tex:36-40, 65-69, 88-138 | `list.kernel` | `description`, `itemize`; `enumerate` (:91-96) and `description` (:105-114) nested inside an `\item` of an `itemize`; no `enumitem` options |
| inline emphasis | latext_cheat.tex:123, 128 | `mark.kernel` | `\emph{}` and the `{\em ...}` declaration |
| footnotes | latext_cheat.tex:89, 130 | `fn.kernel` | `\footnote{}`; one is inside an `\item` (:89) |
| manual line breaks and spaces | latext_cheat.tex:73-76, 80 | `sp.manual-space` | `\\` without length (73-75), `\,` thin spaces (80), `\ ` control space (23, 28) |
| inline code | latext_cheat.tex:22, 28, 30, 38, 50 and many more | `code.verbatim` | `\verb` with `=` as delimiter; used inside `\item` and running text |
| straight quotes in verbatim | latext_cheat.tex:3 | `code.upquote` | `\usepackage{upquote}`, no options (load-only) |
| highlighted code block | latext_cheat.tex:4, 149-157 | `code.minted` | `\usepackage{pygmentex}` without options; body `pygmented` environment with `lang=tex`; EXTERNAL (Pygments) |

Kernel text macros and typed quote ligatures (`\LaTeX`, `\TeX`, `\ldots`, `\textbackslash`, ``` `` ''```; latext_cheat.tex:6, 23, 80, 125-127) are text content, not template choices; no `csquotes`.

Packages the sample does not load: `hyperref`, `babel`, `fontenc`, `inputenc`, `geometry`, `amsmath`, `graphicx`, `caption`, `fancyhdr`, `titlesec`, `enumitem`. The sample has no math, figure, table, theorem, bibliography, index or caption; `equation`, `displaymath`, `\chapter` and the like occur only as text inside `\verb` or `description` items (latext_cheat.tex:38, 112-113, 118).

## Bespoke code
none. A grep of the whole file finds no `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter` or `\if`; the only real `\usepackage` calls are latext_cheat.tex:3 and 4 (the others, at 98 and 151, are text inside `\verb` and inside the `pygmented` block). No zip-local `.cls`, `.sty`, `.def`, `.cfg` or `.clo` is present.

## Content-opaque
- The text of the `pygmented` block, a TeX snippet with `\sectionfont{\centering}` (latext_cheat.tex:150-156), is code content. It is shown, not executed: `sectsty` is never loaded by the document itself.
- `latext_cheat.pdf` is a shipped build output; it was not used as evidence of the look.
- The other 28 files (`README.md` and 27 other `.md` cheatsheets) are Markdown text, not LaTeX; a grep for `\documentclass` finds only `latext_cheat.tex`. They were not read in full, only the head of `README.md`. Nothing in the zip addressed an AI; the one hit of "ignore" is ordinary prose about LaTeX comments (latext_cheat.tex:84).

## Lib changes
- New ways proposed:
  - `code.minted` `pygmentex` (CTAN, TeX Live; LPPL 1.3, confirmed on ctan.org/pkg/pygmentex), pdfLaTeX-compatible on the TeX side, with an EXTERNAL Python/Pygments pass. Same status as the lib's `code.minted` line (an EXTERNAL way). W1: on CTAN and in TeX Live. W2: behaviour chosen by keys (`lang=tex` at latext_cheat.tex:149; the package also takes style and line-number keys, from its documentation, not read here). W3: any code listing. W4: one `\usepackage` line plus the `pygmented` environment (or inline command) as a body wrapper. It is not `code.minted` (a different package and toolchain) and not `code.listings` (pure TeX, a different mechanism and look). It is a way that carries the EXTERNAL tag, so using it keeps the verdict `no`.
  - `code.upquote` `upquote` (CTAN, TeX Live; LPPL), pdfLaTeX-compatible. A load-only switch (no options) that prints `'` and `` ` `` as straight quote glyphs in `\verb` and verbatim output. W1: on CTAN. W2: declarative, with no code editing; a load-only switch like `cols.balance`, `math.icomma` and `note.mparhack`. W3: serves every verbatim-style code component. W4: one `\usepackage{upquote}` line. Not `code.verbatim` (that way is the verbatim environments and commands themselves; upquote is a separate package that changes their glyphs, as `fn.footnotebackref` is separate from `fn.kernel`) and not `font.fontenc-t1` (it selects no encoding or font). The consolidator may fold it into `code.verbatim` if it prefers one way for all verbatim-family switches.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
