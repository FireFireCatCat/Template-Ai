no

# 0676-aidisclose: aidisclose (Generative AI disclosure checklist) and its manual

- Unverified: read from the source, not compiled.
- Source: Source/0676-aidisclose/ (origin: https://mirrors.ctan.org/macros/latex/contrib/aidisclose.zip; licence: lppl1.3c)
- Kind: misc
- Lib: v5
- Engine: pdfLaTeX-compatible (`newpx`, T1, expl3 package needing LaTeX 2022-06-01 or later at aidisclose.sty:11; `minted` needs `-shell-escape`; the `fontspec` lines at aidisclose-doc.tex:30-31 are commented out, which is probably why the manifest hint says xelualatex)
- Look carried by: mixed (kernel `article` at 11pt plus a preamble of published packages; the declaration block is drawn by the published `aidisclose.sty`, which is on CTAN and is loaded, not rebuilt, by the sample)
- Class origin: tex-distribution-unbundled (`article`; the zip ships no class; its source was not read)
- Main file: aidisclose-doc.tex (other samples: none; README.md:130-153 shows a minimal `article` example in a code fence, not a compilable file)
- Read: main yes, zip-local classes and styles partly (aidisclose.sty 1-867 and langdef/aidisclose-en.ldf read in full; the 13 other `.ldf` files were only scanned by a line pattern: every line is `\AIDstrings{` at line 2, `}` at line 101, a comment, or a `key = {text},` string, so the translated text was not read)

## Verdict
no. The sample's own preamble loads `minted` (aidisclose-doc.tex:26), defines `\newminted{latex}`, `\newmintinline{latex}` and an `ltx` wrapper over `minted` (:56, :66, :67-79), and uses them in most sections (for example :130-132, :228-232, :671-673). `minted` is `EXTERNAL` in the lib (shell escape and pygments), so the document does not build from TeX alone. Everything else maps to existing lib ways, and the package under test, `aidisclose.sty`, is published (CTAN page read: v1.12.0, LPPL 1.3c) and is the lib way `front.aidisclose`. Without the `minted` manual layer, the zip's package part would be a `yes` (README.md:130-153: `article` plus `front.aidisclose`).

## Blockers
- `EXTERNAL/preamble` `minted` loaded unconditionally in the sample preamble and used for every code example, with `\newminted{latex}` bgcolor=latexbg, fontsize=\small, breaklines, tabsize=2, autogobble (aidisclose-doc.tex:26, :56-66, :67-79; first use :130-132)

## Class setting
- Class: `class.article` options: 11pt (aidisclose-doc.tex:14)
- Class-native vocabulary used: `\title` `\author` (with `\\` and `\url`) `\date` `\maketitle` (:84-87), `abstract` environment (:89-92), `\tableofcontents` (:96), `\section` `\subsection` `\subsection*` `\subsubsection` `\paragraph` (:99, :113, :183, :224, :157), `\appendix` (:522), `itemize` `enumerate` `description` (:105, :140, :137), `\clearpage` (:517, :711)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | aidisclose-doc.tex:14 | `class.article` | 11pt |
| page size | aidisclose-doc.tex:14 | `page.class-options` | 11pt only; no geometry call, no paper option |
| font encoding | aidisclose-doc.tex:20 | `font.fontenc-t1` | fontenc T1 |
| text and math face | aidisclose-doc.tex:28 (`lmodern` commented :27; `roboto` :29 and `fontspec` :30-31 commented) | `font.palatino` | package `newpx` (newpxtext and newpxmath, the Palatino-like sibling of `newtx`; filed here because the lib line `font.newx` is Times-like) |
| colour | aidisclose-doc.tex:21, :55 | `color.xcolor` | `\definecolor{latexbg}{HTML}{F5F5EE}`; names `blue!70!black` (:51), `blue!80!black` (:529), `green!50!black` (:532) |
| URLs | aidisclose-doc.tex:22, :85, :91 | `meta.url` | package `xurl`; `\url` in the author block and body |
| links | aidisclose-doc.tex:51 | `meta.hyperref` | colorlinks, allcolors=blue!70!black |
| title block | aidisclose-doc.tex:84-87 | `front.maketitle` | `\title{The \texttt{aidisclose} package}`; `\author{name\\\url{...}}`; `\date{2026-02-21~(\aidversion)}` |
| abstract | aidisclose-doc.tex:89-92 | `abs.kernel` | kernel `abstract`, no options |
| contents | aidisclose-doc.tex:94-97 | `toc.kernel` | `\tableofcontents` set under `\footnotesize` inside `multicols{2}` |
| contents in columns | aidisclose-doc.tex:25, :94-97 | `cols.multicol` | `multicols` with 2 columns around the contents list |
| small text | aidisclose-doc.tex:95 | `font.size-commands` | `\footnotesize`; `\small` as a minted key (:58, :71) |
| headings | aidisclose-doc.tex:99, :113, :183, :224, :424, :540, :667 | `head.kernel` | stock article levels, starred forms for unnumbered; `\paragraph` restyled in the appendix (see Bespoke code) |
| appendix | aidisclose-doc.tex:522 | `num.appendix` | `\appendix` |
| lists | aidisclose-doc.tex:105-111, :140-143, :137-151 | `list.kernel` | `itemize`, `enumerate`, `description` |
| list parameters | aidisclose-doc.tex:24, :159-164, :532 | `list.enumitem` | `itemsep = 1\itemsep`, `parsep = 1\parsep`, `before`/`after` hooks that open and close `multicols{3}`; `\setlist[description]{font=\normalfont\bfseries\color{green!50!black}}` |
| list in 3 columns | aidisclose-doc.tex:162-164 | `cols.multicol` | `multicols{3}`, `\raggedcolumns` before it |
| ragged text | aidisclose-doc.tex:162 | `sp.ragged` | `\raggedright` |
| inline marks | aidisclose-doc.tex:116, :138, :90 | `mark.kernel` | `\slshape` (group :115-123), `\texttt`, `\textbf`, `\emph` |
| manual spacing | aidisclose-doc.tex:188, :415, :421 | `sp.manual-space` | `\hfill \\`; `\\[-5.5ex]`; `\smallskip` |
| line spread | aidisclose-doc.tex:411 | `sp.linespread` | `\renewcommand\baselinestretch{1.4}` inside `gaikeys` |
| key tables | aidisclose-doc.tex:37, :412 | `tbl.tabularx` | `\tabularx{\textwidth}{p{5.5em}X}` |
| table rules | aidisclose-doc.tex:23, :413-414, :419 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule` |
| long tables | aidisclose-doc.tex:38 | `tbl.longtable` | package `xltabular`, loaded and not used in the body |
| code examples | aidisclose-doc.tex:26, :56, :66, :67-79 | `code.minted` | **EXTERNAL**; `\newminted{latex}`, `\newmintinline{latex}`, `ltx` environment: bgcolor, fontsize, breaklines, tabsize=2, autogobble |
| bibliography | aidisclose-doc.tex:42, :90, :514 | `bib.biblatex-biber` | `\usepackage{biblatex}` (default backend), `\cite`, `\printbibliography`; the `.bib` is written by the package (aidisclose.sty:819-851, :853-865) |
| cross-references | aidisclose-doc.tex:100, :225, :669, :784 | `xref.kernel` | `\label`, `\ref` |
| page breaks | aidisclose-doc.tex:517, :711 | `pg.break` | `\clearpage` |
| AI declaration | aidisclose-doc.tex:47, :713-784 | `front.aidisclose` | options `autobib=true,nocite=true`; `\AIDtoolsUsed{ChatGPT-4o, Gemini 1.5 Pro, GitHub Copilot}`; 14 `\AIDactivate{key}` (:717-775); `AIDcomment` environment (:780-782); `\AIDrenderDeclaration[ncols=3,label=sec:aid_declaration, lang=en]{Jane Doe, John Smith}` (:784) |

How the published package builds its block (inside `front.aidisclose`, so no extra rows): options by `\DeclareKeys` (aidisclose.sty:23-30); loads `multicol`, `relsize`, `xcolor`, and `amssymb` unless `\checkmark` exists (:32-37); taxonomy of 9 groups and 53 keys (:216-235); checkbox list as a kernel `\list` with `\framebox` labels (:355-373); group headings in `multicols` with `\hrulefill` (:676, :683); colours by `\color` (:284, :296); strings per language from `langdef/aidisclose-<code>.ldf` (:175-186; each file is one `\AIDstrings{...}` call, aidisclose-en.ldf:2-101); the bibliography file is written with `\iow_now:Nn` at `begindocument/before` (:819-865).

Not used: `babel` (commented, aidisclose-doc.tex:16), floats and figures, footnotes in the sample (the package's own footnote at aidisclose.sty:331 and aidisclose-en.ldf:19 sits inside the way), theorems, index.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `ltx` environment over `minted` | aidisclose-doc.tex:67-79 | yes in shape, but its way is EXTERNAL | one `minted` call with the keys bgcolor=latexbg, fontsize=\small, breaklines, tabsize=2, autogobble, language latex: `code.minted`; the tool dependency is the blocker |
| `\newminted{latex}`, `\newmintinline{latex}` (`\latexinline`) | aidisclose-doc.tex:56-66 | yes in shape, EXTERNAL | declarations of `code.minted`; same blocker |
| `gaikeys` environment | aidisclose-doc.tex:408-422 | yes | `tbl.tabularx` (`{p{5.5em}X}` at `\textwidth`) + `tbl.booktabs` + `sp.linespread` 1.4 + `sp.manual-space` (`\\[-5.5ex]`, `\smallskip`); the local `\renewcommand\item[1][]{\\##1 &}` (:410) only turns `\item[key]` into a row, so an emitter writes `key & text \\` rows directly |
| `\paragraph` redefined with `\@startsection` | aidisclose-doc.tex:526-529 (inside group :524-661) | yes | `head.kernel`: the six arguments are the article defaults (level 4, indent `\z@`, before `3.25ex plus 1ex minus .2ex`, after `-1em`, font `\normalfont\normalsize\bfseries`) plus `\color{blue!80!black}`; scoped by the group, which the emitter keeps |
| `\setlist[description]` | aidisclose-doc.tex:532 | yes | `list.enumitem` key `font=` |
| `before`/`after` of the language list | aidisclose-doc.tex:159-164 | yes | `cols.multicol` wrapper (`\raggedcolumns`, `multicols{3}`, `sp.ragged`) around a plain `itemize` with `list.enumitem` spacing keys |
| `aidisclose.sty` and `langdef/*.ldf` | aidisclose.sty:1-867; langdef/aidisclose-en.ldf:1-101 | not bespoke: published | on CTAN (https://ctan.org/pkg/aidisclose read: v1.12.0 of 2026-02-21, LPPL 1.3c); the zip is the CTAN release, so W1 holds and the way is `front.aidisclose`. RELEASE_NOTES.md:14 says "not yet available on CTAN"; that is stale text, the CTAN page shows the package (read as data, not followed) |

## Content-opaque
none. The code text inside the `ltx` blocks and the taxonomy tables are content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
