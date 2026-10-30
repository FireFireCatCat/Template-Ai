yes

# 0760-simonwaldherr-howto-deploy-latex-documen: HowTo Deploy LaTeX Documents (pandoc-style article preamble)

- Unverified: read from the source, not compiled.
- Source: Source/0760-simonwaldherr-howto-deploy-latex-documen/ (origin: https://codeload.github.com/SimonWaldherr/HowTo-Deploy-LaTeX-Documents/zip/refs/heads/master; licence: CC BY-SA 4.0 per LICENSE:1-3 and README.md:34, the manifest says NOASSERTION)
- Kind: misc (a how-to guide set in plain `article`; no title block is printed)
- Lib: v6
- Engine: pdfLaTeX-compatible (the preamble branches on `\ifxetex`/`\ifluatex` at HowtoDeployLatexDocs-DE.tex:46-58; the pdfTeX branch needs no XeTeX; .travis.yml:22-23 calls `pdflatex`, .latex.yml:2 names `xelatex` for the online editor)
- Look carried by: preamble (kernel `article` unchanged; page lengths, colours, `listings` style and spacing are set in the sample's own preamble, DE.tex:1-100)
- Class origin: tex-distribution-unbundled
- Main file: HowtoDeployLatexDocs-DE.tex (other samples: HowtoDeployLatexDocs-EN.tex, same preamble, `letterpaper`, translated text)
- Read: main yes (DE and EN read in full), zip-local classes and styles none present (the zip holds no .cls, .sty, .def, .cfg, .clo, .bst or .dtx)

## Verdict
yes. The look is kernel `article` plus a preamble of published packages (`lmodern`, `listings`, `color`, `microtype`, `upquote`, `hyperref`) and raw length settings, and every item maps to a lib way. The zip-local macros (`\tightlist`, `\def\labelenumi`, the `\paragraph` wrappers, `\euro`, the engine switch, the `\IfFileExists` guards) are aliases or load-time conditionals that reduce to lib ways, and there is no artwork. Nothing the samples need lies outside TeX: the pandoc step of the CI recipe (.travis.yml:16-18) builds `README.tex`, which is not in the zip and is not an analysed sample. One soft spot: the XeTeX branch loads three legacy helpers (`mathspec`, `xltxtra`, `xunicode`) that no lib way names, and the pdfTeX branch does not use them (see Bespoke code and Lib changes).

## Blockers
none

## Class setting
- Class: `class.article` options: `10pt,a4paper` (DE.tex:1); `10pt,letterpaper` (EN.tex:1)
- Class-native vocabulary used: `\title` `\author` `\date{}` declared (DE.tex:91,102-103) but `\maketitle` is never called (grep over both .tex files: no match); `\section` `\subsection` (DE.tex:107,145,223,229); `itemize` and `enumerate` (DE.tex:119,147); no `abstract`, no `\tableofcontents`. The `\paragraph` and `\subparagraph` wrappers (DE.tex:93-100) are defined but never used in the body.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | DE.tex:1; EN.tex:1 | `class.article` | 10pt; a4paper (DE), letterpaper (EN) |
| paper and base size | DE.tex:1; EN.tex:1 | `page.class-options` | a4paper / letterpaper, 10pt |
| page geometry | DE.tex:7-10 | `page.setlength` | `\addtolength` of `\voffset` -35pt, `\hoffset` -35pt, `\textheight` +70pt, `\textwidth` +70pt |
| input encoding, font encoding | DE.tex:2,47-48 | `font.fontenc-t1` | `inputenc` utf8 (loaded at line 2 and again at line 48); `fontenc` T1 (pdfTeX branch) |
| text font | DE.tex:3 | `font.lmodern` | load-only `\usepackage{lmodern}` |
| XeTeX/LuaTeX font branch | DE.tex:50-56 | `font.fontspec` | `fontspec` (line 54, LuaTeX branch only; the XeTeX branch loads `mathspec` and `xltxtra,xunicode` at lines 51-52 and has no `fontspec` line of its own), `\defaultfontfeatures{Mapping=tex-text,Scale=MatchLowercase}` (line 56, both non-pdfTeX engines); considered: `mathspec`, `xltxtra`, `xunicode` (load-only, never called) |
| colour definitions | DE.tex:12,14-19 | `color.color` | `color` package; `\definecolor{..}{rgb}{..}`: mygray 0.4,0.4,0.4; mygreen 0,0.8,0.6; myorange 1.0,0.4,0; myblue 0.2,0.4,1; mylightgray 0.98,0.98,0.98; mymauve 0.58,0,0.82 (unused); `blue` and `magenta` are `color`'s predefined names (DE.tex:79-81) |
| paragraph shape | DE.tex:84-86 | `sp.lengths` | `\parindent` 0pt; `\parskip` 6pt plus 2pt minus 1pt; `\emergencystretch` 3em |
| tight list spacing | DE.tex:87-88 | `sp.lengths` | alias `\tightlist` = `\itemsep` 0pt + `\parskip` 0pt; used at DE.tex:120,149,154,170,193 |
| body paragraph spacing | DE.tex:110,140-141 | `sp.lengths` | raw `\parskip 42pt` (after the first heading), then `\parskip 12pt` and `\parindent 0pt` |
| microtype | DE.tex:62-65 | `sp.microtype` | `\UseMicrotypeSet[protrusion]{basicmath}`; wrapped in `\IfFileExists{microtype.sty}` |
| upright quotes | DE.tex:60 | `code.upquote` | load-only; wrapped in `\IfFileExists{upquote.sty}` |
| PDF and link options | DE.tex:66-72,74-82 | `meta.hyperref` | load options `unicode=true` (non-XeTeX) or `setpagesize=false,unicode=false,xetex`; `\hypersetup{breaklinks=true, bookmarks=true, pdfauthor={}, pdftitle={}, colorlinks=true, citecolor=blue, urlcolor=blue, linkcolor=magenta, pdfborder={0 0 0}}` |
| URL font | DE.tex:83 | `meta.url` | `\urlstyle{same}` |
| external links in text | DE.tex:113-114,136-137,156,159,179,188,207,217,233 | `meta.hyperref` | `\href{url}{text}` |
| title metadata | DE.tex:91,102-103 | `front.maketitle` | `\title{HowTo Deploy LaTeX Documents}` `\author{Simon Waldherr}` `\date{}`; declared only, `\maketitle` is never called, so no title block is printed |
| heading numbering | DE.tex:89 | `num.secnumdepth` | `secnumdepth` 0: `\section` and `\subsection` print unnumbered |
| headings | DE.tex:107,145,223,229 | `head.kernel` | `\section`, `\subsection`, default article format |
| paragraph headings | DE.tex:93-100 | `head.kernel` | `\renewcommand` of `\paragraph` and `\subparagraph` that appends `\mbox{}` (never used in the body) |
| labels | DE.tex:108,145,223,229 | `xref.kernel` | `\label` after each heading; no `\ref` anywhere |
| lists | DE.tex:119-129,147-219 | `list.kernel` | `itemize`, `enumerate`, nested up to 3 levels (DE.tex:147,153,192) |
| enumerate label | DE.tex:148 | `list.kernel` | `\def\labelenumi{\arabic{enumi}.}` (the article default value) |
| inline marks | DE.tex:131,163-164 | `mark.kernel` | `\textbf`, `\emph`, `\texttt`; `\LaTeX` kernel logo macro in running text (DE.tex:107,114) |
| page breaks | DE.tex:143,221,227 | `pg.break` | `\newpage` |
| listing style | DE.tex:21-44 | `code.listings` | `\lstset`: `literate` (a long string to `{$...$}`, plus `<` to `$\langle$`, `>` to `$\rangle$`, DE.tex:22), `backgroundcolor=\color{mylightgray}`, `basicstyle=\footnotesize`, `breaklines=true`, `captionpos=b`, `commentstyle=\small\color{mygreen}`, `deletekeywords={...}`, `escapeinside={\%*}{*)}`, `extendedchars=true`, `keepspaces=true`, `keywordstyle=\color{myblue}`, `otherkeywords={*,os:,language:,...}`, `numbers=left`, `numbersep=5pt`, `numberstyle=\tiny\color{mygray}`, `showspaces/showstringspaces/showtabs=false`, `stepnumber=1`, `stringstyle=\color{myorange}`, `tabsize=2`, `title=\lstname` |
| listing body | DE.tex:225; EN.tex:220 | `code.listings` | `\lstinputlisting[language=PHP]{.travis.yml}` (the listed file is a shipped asset, content) |
| colour inside listing keys | DE.tex:23,27,32,36,41 | `color.color` | `\color{..}` from the six defined colours |

Not used by the sample (so no way): header/footer (default page style, nothing set; grep finds no `\pagestyle`), table of contents, floats, tables, captions, math, theorems, bibliography, index, footnotes, `babel` (the German file sets no language package, DE.tex:1-100). The other files in the zip (.travis.yml, .latex.yml, DESCRIPTION, .gitignore, .github/FUNDING.yml, README.md) are CI, editor and repository files, not classes or styles; .travis.yml is also the file shown by `\lstinputlisting`. Nothing addressed to an AI was found.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\providecommand{\tightlist}` | DE.tex:87-88 | yes | alias of two raw length settings: `sp.lengths` `\itemsep` 0pt and `\parskip` 0pt, written after `\begin{itemize}`/`\begin{enumerate}` (DE.tex:120,149,154,170,193) |
| `\def\labelenumi{\arabic{enumi}.}` | DE.tex:148 | yes | the article default label; `list.kernel` as written, or `list.enumitem` `label=\arabic*.` |
| `\let\oldparagraph` + `\renewcommand{\paragraph}[1]{\oldparagraph{#1}\mbox{}}`, same for `\subparagraph`, inside `\ifx..\undefined\else` guards | DE.tex:93-100 | yes | a wrapper around the published `\paragraph`, not a change of `\@startsection`; as written it is `head.kernel`, or `head.titlesec` `\titleformat{\paragraph}[block]` for a free-standing heading; the guard is always true under `article`; dead in this sample (no `\paragraph` in the body), exact equivalence of the titlesec form not checked |
| `\newcommand{\euro}{€}` | DE.tex:57 | yes | alias of a Unicode character in the XeTeX/LuaTeX branch, never used; `font.icons` (`eurosym`) is the published form |
| engine switch `\ifnum 0\ifxetex 1\fi\ifluatex 1\fi=0 ... \else \ifxetex ... \else ... \fi \fi` with `ifxetex` and `ifluatex` | DE.tex:5,46-58 | yes | picks between two lib ways; an emitter knows its engine and writes one branch: `font.fontenc-t1` (pdfLaTeX) or `font.fontspec` (XeTeX/LuaTeX); the conditional drops out by inlining |
| `\IfFileExists{upquote.sty}`, `\IfFileExists{microtype.sty}` guards | DE.tex:60,62-65 | yes | unconditional `\usepackage` of `code.upquote` and `sp.microtype` |
| `\usepackage{mathspec}`, `{xltxtra,xunicode}` (XeTeX branch only) | DE.tex:51-52 | yes, with a caveat | published legacy load-only helpers with no call in the sample (`mathspec`: ctan.org/pkg/mathspec read, LPPL 1.3c, XeLaTeX, in TeX Live, sets maths fonts through `fontspec`, but the sample issues no maths-font command; `xltxtra` and `xunicode` not read); no lib way names them; not emitted for pdfLaTeX, and an XeTeX emission would use `font.fontspec` alone; whether the XeTeX output stays identical without them is not checked |
| pandoc-template preamble as a whole | DE.tex:46-100 | yes | stock pandoc LaTeX template text (inferred from the idioms, the zip does not say so), committed as plain source; each part is reduced in the rows above and the samples compile without a pandoc run |
| `literate` key with a long base64-like string | DE.tex:22 | yes | a `listings` key value (string, replacement, length), part of `code.listings`; the string does not occur in .travis.yml, so it replaces nothing there; quoted here only because it looks like encrypted text, it is not addressed to anyone |

## Content-opaque
none (the file shown by `\lstinputlisting`, .travis.yml, is code text, i.e. content)

## Lib changes
- New ways proposed: none. Considered and not proposed: `mathspec`, `xltxtra`, `xunicode` (load-only legacy XeTeX helpers in a branch the pdfTeX emission does not take, no command of them called; the verdict does not rest on them, as the v4 rejection of `sys.compat-load`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
