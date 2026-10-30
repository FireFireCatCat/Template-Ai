yes

# 0679-abntex2: abnTeX2 (ABNT dissertation sample)

- Unverified: read from the source, not compiled.
- Source: Source/0679-abntex2/ (origin: https://latextemplates.com/downloads/abntex2.zip; licence: LPPL-1.3)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (main.tex:3-4 load `fontenc` T1 and `inputenc` utf8; no `fontspec`, no Lua code; the class source was not read)
- Look carried by: class (the published class `abntex2` sets page, fonts, spacing, headings, contents, cover, title page and abstract layout; the sample's preamble only adds encodings, `babel`, `booktabs` and `abntex2cite`, and fills the class's own data commands)
- Class origin: tex-distribution-unbundled (`abntex2` is on CTAN and in TeX Live and MiKTeX: ctan.org/pkg/abntex2 shows v1.9.7 of 2018-11-24, LPPL 1.3; the zip ships no `abntex2.cls`)
- Main file: main.tex (other samples: none; chapters/introducao.tex and chapters/avaliacao.tex are `\input` chapters, referencias.bib is the database)
- Read: main yes, zip-local classes and styles none present (the zip has no `.cls`, `.sty`, `.cfg` or `.bst`; `abntex2.cls`, `abntex2cite.sty` and the `.bst` file are not in the zip and were not read)

## Verdict
The zip is a four-file sample dissertation (main.tex, two chapters, a `.bib`) written on the published CTAN class `abntex2`, which the zip does not bundle, so the class is one way, `class.abntex2`, whose source was not read. The sample defines no macro, environment, counter, length or conditional (a grep for `\newcommand`, `\renewcommand`, `\def`, `\let`, `\newenvironment`, `\newcounter`, `\newif`, `\makeatletter`, `\setlength`, `\pagestyle`, `\bibliographystyle` over the whole zip finds none; the only `\usepackage` and `\input` lines are at main.tex:3-7 and 53-54), draws nothing, and every body construct is a class-native command, a kernel construct, or a published package (`babel`, `booktabs`, `abntex2cite`). No blocker, so `yes`. This is evidence about the class dimension, not about the component ways. The residual risk is that the class internals (memoir base, ABNT patches) and the `.bst` it selects were not read.

## Blockers
none

## Class setting
- Class: `class.abntex2` options: `12pt`, `twoside`, `a4paper`, `chapter=TITLE` (main.tex:1). `chapter=TITLE` is an abntex2 option (it is listed on the lib's `class.abntex2` line); what it does inside the class was not read.
- Class-native vocabulary used: title data `\titulo` `\autor` `\local` `\data` `\instituicao` (lines split with `\\`) `\tipotrabalho` `\preambulo` `\orientador` (main.tex:9-16); printers `\imprimircapa` and `\imprimirfolhaderosto*` (main.tex:20-21); environment `resumo` with an optional title argument (main.tex:23, 34); matter switches `\pretextual` `\textual` `\postextual` (main.tex:47, 51, 56); the source line `\fonte{..}` under a float (chapters/avaliacao.tex:23, 36); the length `\onelineskip` (main.tex:28, 40; a memoir length used by other memoir-based zips in this project, here an assumption since nothing was read); `\chapter` and `\section` (chapters/introducao.tex:1, 4), `\tableofcontents` (main.tex:49) and `\bibliography` (main.tex:58), which the class restyles.

## Component map
Rows marked "(class)" name the lib way for a part the class sets. The class source was not read, so the parameters in those rows are what the sample passes, not what the class does inside.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.abntex2` | 12pt, twoside, a4paper, chapter=TITLE |
| paper, size, binding | main.tex:1 | `page.class-options` | `a4paper`, `12pt`, `twoside` |
| margins, fonts, line spacing (class) | main.tex:1 | `class.abntex2` | not visible in the sample; set inside the unread class |
| running heads, page numbers (class) | main.tex:1, 47, 51 | `class.abntex2` | not visible in the sample (no `\pagestyle`, no `fancyhdr`); set by the class and its `\pretextual` `\textual` switches |
| encodings | main.tex:3-4 | `font.fontenc-t1` | `\usepackage[T1]{fontenc}`, `\usepackage[utf8]{inputenc}`; accents are written as TeX escapes (`\^a`, `\c{c}`, `\~a`), which is content |
| language | main.tex:5, 34-35, 44 | `lang.babel` | `\usepackage[brazil]{babel}`; `otherlanguage*` with `english` around the English abstract (only `brazil` is in the load options, so whether `english` is loaded was not established) |
| cover data and cover page | main.tex:9-14, 20 | `front.class-native` | `\titulo` `\autor` `\local` `\data` `\instituicao` `\tipotrabalho`, printed by `\imprimircapa` |
| title page | main.tex:15-16, 21 | `front.class-native` | `\preambulo`, `\orientador`, printed by `\imprimirfolhaderosto*` (starred form) |
| matter division | main.tex:47, 51, 56 | `front.class-native` | `\pretextual` `\textual` `\postextual` |
| abstract, Portuguese | main.tex:23-32 | `abs.class-native` | `resumo` environment, default title |
| abstract, English | main.tex:34-45 | `abs.class-native` | `resumo[<title>]` with the title argument `\begin{otherlanguage*}{english}Abstract\end{otherlanguage*}` |
| keywords line | main.tex:30-31, 42-43 | `abs.keywords` | hand-set `\noindent \textbf{Palavras-chave}: ...` and `\textbf{Keywords}: ...` (not a class command) |
| paragraph indent off | main.tex:30, 42 | `sp.lengths` | kernel `\noindent`, a paragraph-shape switch of the family of `\parindent`; a judgement call, not a new way |
| bold labels | main.tex:31, 43 | `mark.kernel` | `\textbf` |
| space before keywords | main.tex:28, 40 | `sp.manual-space` | `\vspace{\onelineskip}` |
| contents | main.tex:49 | `toc.kernel` | `\tableofcontents`; entry look set by the class (unread) |
| file inclusion | main.tex:53-54 | `struct.input` | `\input{chapters/introducao}`, `\input{chapters/avaliacao}` |
| chapters and sections | chapters/introducao.tex:1, 4, 11, 22; chapters/avaliacao.tex:1, 4, 26, 39 | `head.class-native` | `\chapter` `\section`; look set by the class and the option `chapter=TITLE` (main.tex:1) |
| cross-references | chapters/introducao.tex:2, 17, 19; chapters/avaliacao.tex:2, 7, 13, 28, 35 | `xref.kernel` | `\label{ch:..}` `\label{tab:..}` `\label{fig:..}`, `Tabela~\ref{..}`, `Figura~\ref{..}` |
| list | chapters/introducao.tex:15-20 | `list.kernel` | `enumerate`, three items |
| table float and table | chapters/avaliacao.tex:10-24 | `tbl.tabular` | `table[htbp]`, `\centering`, `tabular{@{}lrr@{}}` |
| table rules | main.tex:6; chapters/avaliacao.tex:15, 17, 21 | `tbl.booktabs` | `\usepackage{booktabs}`, `\toprule` `\midrule` `\bottomrule` |
| figure float | chapters/avaliacao.tex:31-37 | `fig.graphicx` | `figure[htbp]` with `\centering`; no `\includegraphics` (a rule stands in for the image) |
| centring | chapters/avaliacao.tex:11, 32 | `sp.ragged` | `\centering` in both floats |
| placeholder image | chapters/avaliacao.tex:33 | `sp.rule` | `\rule{0.6\textwidth}{4cm}` |
| captions | chapters/avaliacao.tex:12, 34 | `cap.kernel` | `\caption{..}` above the tabular in the table (line 12 before 14) and below the rule in the figure (line 34 after 33), source order as written; caption look set by the class (unread) |
| source line under a float | chapters/avaliacao.tex:23, 36 | `class.abntex2` | `\fonte{Elaborado pelo autor.}`, after the caption in both floats; not defined in the zip, so a class-native command (recorded under Class setting) |
| citation package | main.tex:7 | `bib.apacite` | `\usepackage[alf]{abntex2cite}` (option `alf`; `abntex2cite` is the standard-specific citation package that the lib's v1 log merged into this way) |
| citations | chapters/introducao.tex:8, 24, 25; chapters/avaliacao.tex:43 | `bib.apacite` | `\cite{lamport1998part}` `\cite{ongaro2014search}` |
| bibliography | main.tex:58; referencias.bib:1, 12 | `bib.bibtex-bst` | `\bibliography{referencias}`; the zip has no `\bibliographystyle`, so the `.bst` is chosen elsewhere (presumably by `abntex2cite` option `alf`, an `abntex2-alf` style from the abntex2 bundle; neither file is in the zip and neither was read); entry types `article` (referencias.bib:1) and `inproceedings` (referencias.bib:12) |

## Bespoke code
none. No `\newcommand`, `\renewcommand`, `\def`, `\let`, `\newenvironment`, `\newcounter`, `\newif`, `\makeatletter` or `\setlength` appears in main.tex, chapters/introducao.tex or chapters/avaliacao.tex (grep over the zip), and the zip has no `.cls`, `.sty`, `.cfg` or `.bst`. Commands that look zip-local (`\fonte`, `\onelineskip`, `\imprimircapa`, `\pretextual`) are not defined here, so they come from the published class or its packages. No text in the zip is addressed to an AI.

## Content-opaque
none (the figure holds a `\rule` placeholder at chapters/avaliacao.tex:33, which `sp.rule` covers and which stands in for figure artwork; the bibliography entries, table cells and Portuguese text are content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
