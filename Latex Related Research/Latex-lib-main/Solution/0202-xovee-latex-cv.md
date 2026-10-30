yes

# 0202-xovee-latex-cv: Xovee LaTeX CV

- Unverified: read from the source, not compiled.
- Source: Source/0202-xovee-latex-cv/ (origin: https://latextemplates.com/downloads/xovee-latex-cv.zip; licence: MIT)
- Kind: cv
- Lib: v2
- Engine: pdfLaTeX-compatible (README.md:33-35 builds with `pdflatex main`; `ebgaramond` supports pdfLaTeX, XeLaTeX and LuaLaTeX)
- Look carried by: preamble (kernel `article` plus twelve published packages and six `\newcommand` aliases, all in main.tex:5-57; no zip-local class or style exists)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; article.tex is the publications section `\input` at main.tex:202, not a standalone document)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The zip is three files (main.tex, article.tex, README.md) and holds no `.cls`, `.sty` or other zip-local package. The look is the kernel `article` class plus a preamble of published packages and six `\newcommand` aliases. Each alias is a one-line composition of lib ways. Two packages have no lib way yet, `ebgaramond` and `eqparbox`. Both are on CTAN and in TeX Live (read at ctan.org/pkg/ebgaramond and ctan.org/pkg/eqparbox) and pass W1 to W4, so they are proposed below. There is no artwork, no external tool and no irreducible code.

## Blockers
none

## Class setting
- Class: `class.article` options: none (main.tex:5). The class source is not in the zip and was not read (kernel class, ships with LaTeX).
- Class-native vocabulary used: `\section*`, `\subsection*` (starred, so unnumbered), `center`, `itemize`, `enumerate`, `\pagestyle{headings}` with `\markright`, `\today`. No `\maketitle`, no `abstract`, no `thebibliography`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:5 | `class.article` | no options |
| input and font encoding | main.tex:7, 8, 10 | `font.fontenc-t1` | `inputenc` option `utf8`; `textcomp` option `full`; `fontenc` option `T1` |
| text face | main.tex:9 | `font.serif-pkg` | `\usepackage[lf]{ebgaramond}` (lining figures); the face is the whole look of the text |
| page geometry | main.tex:14 | `page.geometry` | `a4paper`, `left=1in`, `right=1in`, `top=1in`, `bottom=1in` |
| paragraph indent | main.tex:39 | `sp.lengths` | `\parindent=2em` |
| paragraph skip | main.tex:70 | `sp.lengths` | `\parskip=3pt`, set in the body after the name block |
| indent after headings | main.tex:18 | `sp.indentfirst` | load-only |
| hanging indent on the summary paragraph | main.tex:85 | `sp.lengths` | `\hangindent=2em`, a raw TeX dimension parameter of the same type as `\parindent` |
| paragraph without indent | main.tex:73, 75, 77, 79, 255 | `sp.lengths` | `\noindent`, the one-paragraph override of `\parindent` |
| page style | main.tex:36 | `hf.pagestyle-kernel` | `headings` |
| first page empty | main.tex:52 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| running head text | main.tex:37 | `hf.pagestyle-kernel` | `\markright{\textbf{Jordan Blake}}`; kernel mark command that feeds the `headings` style; starred sections never overwrite it |
| PDF metadata and links | main.tex:22-28 | `meta.hyperref` | `hidelinks`, `pdfnewwindow=true`, `pdfauthor={Jordan Blake}`, `pdftitle={Curriculum Vitae of Jordan Blake}`, `pdfpagemode=UseThumbs` |
| link commands in body | main.tex:77; article.tex:9, 18 | `meta.hyperref` | `\href{mailto:...}{...}`, `\href{doi url}{...}` |
| url | main.tex:15, 79, 250, 256 | `meta.url` | `\usepackage{url}`, `\url{...}` |
| colour package | main.tex:16 | `color.xcolor` | option `dvipsnames` |
| colour use | main.tex:57, 258 | `color.xcolor` | `\color{red}` (in `\HL`), `\color{OliveGreen}` |
| maths package | main.tex:17 | `math.amsmath` | load-only; the body holds no maths |
| name block | main.tex:63-67 | `sp.ragged` | `center` environment (kernel sibling of `\centering`) around `\Huge` (`font.size-commands`) and `\rmfamily\textbf` (`mark.kernel`) |
| name size | main.tex:64 | `font.size-commands` | `\Huge` |
| vertical gaps | main.tex:68, 138 | `sp.manual-space` | `\vspace{20pt}` under the name, `\vspace{5pt}` after the education styles |
| contact block, two-sided lines | main.tex:73-79, 216, 220 | `sp.manual-space` | `\hfill` between left and right text |
| indented sub-lines | main.tex:97, 99, 104, 106, 147, 149, 153, 194, 198, 218, 222, 230, 250 | `sp.manual-space` | `\hspace{2em}` |
| section headings | main.tex:55 (`\cvsection`), used at main.tex:83, 92, 110, 120, 128, 143, 156, 166, 176, 206, 214, 226, 238, 246; article.tex:1 (a plain `\section*{Publication}`) | `head.kernel` | `\section*{\rmfamily #1}` (unnumbered, kernel section style kept) |
| subsection headings | main.tex:56 (`\cvsubsection`), used at main.tex:178-190; article.tex:3, 12 | `head.kernel` | `\subsection*{\rmfamily\hspace{1.6em}#1}`; the offset is `sp.manual-space` |
| date heading at the end | main.tex:258 | `head.kernel` | `\section*{\hfill\color{OliveGreen}\today}`; `\today` is the kernel date command (`front.maketitle` family), the colour is `color.xcolor` |
| fixed-width text cells | main.tex:42-50 (`\stb`), used at main.tex:132-136 | `box.fancybox` | `\makebox[<width>][l]{...}` with widths 5em, 11em, 14em; `\makebox` and `\fbox` are one kernel LR-box family |
| equal-width boxes | main.tex:19, 122-126 | `box.eqparbox` | `\usepackage{eqparbox}`; `\eqparbox[t]{program}{...}` and `\eqparbox{major}{...}` with tags `program`, `major`, `edu-univ`, `edu-year`; the width comes from the widest box with the same tag (aux file, a second LaTeX pass) |
| bold, italic, typewriter spans | `\rmfamily` main.tex:65; `\textbf` main.tex:66, 95, 192, 216 (and 37, 102, 145, 151, 196, 220, 228, 248); `\texttt` main.tex:77; `\textit` article.tex:8, 16 | `mark.kernel` | `\textbf`, `\textit`, `\texttt`, `\rmfamily` |
| highlight alias | main.tex:57; used at article.tex:19 | `mark.kernel` | `\textbf{\color{red}#1}` with `color.xcolor` |
| list package and global setup | main.tex:12-13 | `list.enumitem` | `\setlist[enumerate,1]{leftmargin=2em}` |
| bulleted list | main.tex:231-234 | `list.enumitem` | `itemize[leftmargin=5em, topsep=0pt, itemsep=0pt]` |
| numbered publication list (hand-typed, no bibliography package) | article.tex:5-10, 14-20 | `list.enumitem` | `enumerate[resume]`: numbering continues across the two lists |
| forced line break in an item | article.tex:19 | `sp.manual-space` | `\newline` (kernel line break, sibling of `\\[len]`) |
| push footer to the page end | main.tex:253 | `sp.manual-space` | `\vfill` |
| footer credit line | main.tex:255-256 | `meta.url` | `\LaTeX~CV Template: \url{...}` (text and kernel logo, content) |
| file inclusion | main.tex:202 | none needed | kernel `\input{article.tex}` splits the source, typesets nothing; an emitter writes one file |
| Chinese support (commented out) | main.tex:30-34 | not active | `CJKutf8` and `\chinese` are comment lines; if enabled it would be `lang.cjk` plus an alias; out of scope while commented |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\stb[width]{text}` | main.tex:42-44 | yes | `box.fancybox`: `\makebox[width][l]{text}`, default width 4em |
| `\mtb[width]{text}` | main.tex:45-47 | yes (never used) | same, default width 7em |
| `\ltb[width]{text}` | main.tex:48-50 | yes (never used) | same, default width 10em |
| `\cvsection{text}` | main.tex:55 | yes | `head.kernel` `\section*{\rmfamily text}` |
| `\cvsubsection{text}` | main.tex:56 | yes | `head.kernel` `\subsection*{\rmfamily\hspace{1.6em}text}` plus `sp.manual-space` |
| `\HL{text}` | main.tex:57 | yes | `mark.kernel` `\textbf{...}` with `color.xcolor` `\color{red}` |

All six are `\newcommand` aliases with no conditional, counter or box-and-glue logic. No `.cls`, `.sty` or `.def` file exists, so no BESPOKE/class item is possible.

## Content-opaque
none (the DOI links and the publication entries at article.tex:6-9 and 15-18 are text content)

## Lib changes
- New ways proposed:
  - `font.serif-pkg`: `ebgaramond` (CTAN and TeX Live, LaTeX support for EB Garamond by Bob Tennent; ctan.org/pkg/ebgaramond), engine pdf (it also runs under XeLaTeX and LuaLaTeX). W1: released on CTAN. W2: chosen by package options (`lf`, `osf`, `scaled` and similar; this zip uses `lf`). W3: it serves the text-face component of any document. W4: one preamble line `\usepackage[lf]{ebgaramond}`. Not folded into `font.charter`, `font.libertine`, `font.palatino` or `font.fourier`, because each of those lines names its own package family and none names Garamond. The consolidator may prefer one generic serif text-face way, as `font.helvet` was folded into `font.helvet`.
  - `box.eqparbox`: `eqparbox` (CTAN and TeX Live, Scott Pakin, LPPL; ctan.org/pkg/eqparbox), engine pdf. Commands: `\eqparbox[pos][height][inner]{tag}{text}`, `\eqmakebox`, `\eqboxwidth`. W1: released on CTAN. W2: behaviour is chosen by a tag string and position, height and width arguments; no code is edited. W3: it serves any layout that needs equal-width boxes (aligned columns, label rows). W4: a preamble line and a body wrapper around a node's content. Not `box.minipage` (a different package; the rubric does not let a way stretch to another package) and not `tbl.tabular`. It needs a second LaTeX pass for the aux file, but no external tool.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes for reviewers
- Mappings that rest on a family argument, not a named command in the lib line: `\makebox` under `box.fancybox` (kernel LR-box family with `\fbox`), `\hangindent` and `\noindent` under `sp.lengths` (raw paragraph-shape parameters beside `\parindent`), `\markright` under `hf.pagestyle-kernel` (kernel mark command of the `headings` style), the `center` environment under `sp.ragged` (kernel sibling of `\centering`), `\today` under `front.maketitle` (kernel date family), `\rmfamily` under `mark.kernel` (kernel font switch; the rubric names `\bfseries` and `\sf` there).
- The verdict `yes` depends on the two proposed ways being accepted. If the consolidator rejected both, the zip would be `no` with two `UNMAPPED` items.
- Nothing in the zip is addressed to an AI; the only "assistant" matches are job titles (main.tex:149, 160, 222).
- Missing assets: none shipped. The EB Garamond font files come with the TeX distribution through the `ebgaramond` package, not with the zip.
