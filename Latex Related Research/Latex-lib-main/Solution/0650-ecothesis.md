yes

# 0650-ecothesis: ecothesis (Universidade Federal de Viçosa thesis template, Brazilian Portuguese)

- Unverified: read from the source, not compiled.
- Source: Source/0650-ecothesis/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ecothesis.zip; licence: lppl1.3c)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (the zip has no .cls or .sty; the look is main.tex:9-42 plus plain kernel-command page files in preambulo/ that main.tex inputs at main.tex:49-73)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: ecothesis.tex, the user guide on `article`; capitulos/cap01/introduction.tex, capitulos/cap02/cap02.tex, capitulos/cap03/cap03.tex, chapter sub-files that each carry their own `\documentclass`)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The kernel `report` class is loaded with `12pt` (main.tex:9), and everything else is published packages with options (geometry, fancyhdr, titlesec, tocloft, mathpazo, natbib, chapterbib, hyperref) or plain kernel commands. The only zip-local code is a set of `\newcommand` text aliases (dados.tex, res_abs.tex), which reduce by inline expansion. There is no `\def`, conditional, counter, output routine or drawing. Every component maps to an existing lib way and no new way is proposed. The README says chapters are compiled separately for per-chapter `.bbl` files (ecothesis.tex:138); that is a TeX-family bibtex run (`bib.bibtex-bst`), not an outside tool. Read-only analysis: nothing compiled, and the standalone-package behaviour for `\include` of sub-files rests on the lib line for `pg.standalone-pkg`, not on its manual.

## Blockers
none

## Class setting
- Class: `class.report` options: `12pt` (main.tex:9; each chapter sub-file repeats it, e.g. capitulos/cap01/introduction.tex:1). The guide ecothesis.tex:1 uses `class.article` with no options.
- Class-native vocabulary used: `\chapter` (capitulos/cap01/introduction.tex:14), `\section` and `\section*` (capitulos/cap01/introduction.tex:18; preambulo/dedicatoria.tex:13), `\tableofcontents` `\listoffigures` `\listoftables` (main.tex:62-67), `\chaptertitlename` inside the titlesec call (main.tex:20). Not used: `titlepage` option, `abstract` environment, `\appendix`, `\frontmatter`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:9 | `class.report` | 12pt |
| guide document class | ecothesis.tex:1, ecothesis.tex:13 | `class.article` | no options; `\title` `\author` `\maketitle` (ecothesis.tex:5,7,13) |
| input and font encoding | main.tex:10, main.tex:39, main.tex:13 | `font.fontenc-t1` | inputenc `utf8`; fontenc `T1`; `textcomp` in the package list |
| language | main.tex:11 | `lang.babel` | options `brazilian,brazil` |
| page geometry | main.tex:12 | `page.geometry` | a4paper, left=4cm, right=3cm, bottom=2.5cm, top=2.8cm |
| header height | main.tex:34 | `page.setlength` | `\headheight` = 14.50pt |
| body font | main.tex:37 | `font.palatino` | `mathpazo`, option `sc` |
| line spread | main.tex:38 | `sp.linespread` | `\linespread{1.05}` |
| line spacing per block | capa.tex:4, capa.tex:16, preambulo/dedicatoria.tex:2, preambulo/resumo.tex:14, preambulo/resumo.tex:18 | `sp.setspace` | `spacing` environment `{1}`, `\singlespacing`, `\onehalfspacing`; package loaded main.tex:13 |
| running heads and feet | main.tex:89-93, preambulo/dedicatoria.tex:5-11 | `hf.fancyhdr` | `\pagestyle{fancy}`; fields cleared with `\fancyhead{}` `\fancyfoot{}` (main.tex:90-91); main body: foot `[L,RO]` = `\thepage`, foot `[LO,C]` = `Capítulo \thechapter` (main.tex:92-93); front pages: head `[R,L]` or `[RO,L]` = `\thepage`, foot fields empty (preambulo/dedicatoria.tex:6-11) |
| head rule | main.tex:26 | `hf.fancyhdr` | `\headrulewidth` = 0pt |
| dead header settings | main.tex:80-81 | `hf.fancyhdr` | `\fancyhead[RO,L]{\titulo}` and `\fancyfoot[CO,R]{\nome}`, emptied again by main.tex:90-91 (read from fancyhdr semantics, not compiled) |
| per-page page style | capa.tex:2, preambulo/aprovacao.tex:2 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| page numbering | capa.tex:3, preambulo/aprovacao.tex:5, preambulo/dedicatoria.tex:3-4, preambulo/agradecimentos.tex:2-3, main.tex:87-88 | `pgnum.pagenumbering` | page 0 (cover), 1 (approval), roman with page 2 and page 4, then arabic with page 1 |
| page and line breaks | main.tex:63, main.tex:66, main.tex:75, preambulo/dedicatoria.tex:1, preambulo/agradecimentos.tex:18 | `pg.break` | `\newpage`, `\clearpage` |
| chapter heading | main.tex:18-25 | `head.titlesec` | `\titleformat{\chapter}[display]`; format `\vspace*{-0.7cm}\bfseries\Huge`; label `\filleft{\chaptertitlename}\Huge~\thechapter`; sep `1ex`; before-code `\titlerule\vspace{2ex}\filright`; after-code empty |
| section heading (numbered) | capitulos/cap01/introduction.tex:18, capitulos/cap02/cap02.tex:27 | `head.kernel` | default `report` `\section` look, no titlesec rule for it |
| unnumbered front headings | preambulo/dedicatoria.tex:13, preambulo/epigrafe.tex:10, preambulo/agradecimentos.tex:13, preambulo/resumo.tex:11, preambulo/abstract.tex:11 | `head.kernel` | `\section*{\hfill Title}` (right-aligned by `\hfill`) |
| cover page | preambulo/capa.tex:2-36 | `front.titlepage-env` | hand-laid page: author, title (uppercase bold), a right-aligned minipage statement, city, state and year; composed of rows below (no `\maketitle`) |
| approval sheet | preambulo/aprovacao.tex:1-69 | `front.dedication` | declaration page: author, title, statement minipage, `APROVADA: \aprovacao.` (line 28), five signature rules in minipages |
| dedication, epigraph, acknowledgements | preambulo/dedicatoria.tex:13-18, preambulo/epigrafe.tex:10-15, preambulo/agradecimentos.tex:13-17 | `front.dedication` | heading by `head.kernel`; text `flushright` or plain; `\vspace*{\fill}` pushes the text down |
| Resumo and Abstract pages | preambulo/resumo.tex:11-23, preambulo/abstract.tex:11-23 | `head.kernel` | `\section*{\hfill ...}` heading, a citation-style header paragraph, text at `\onehalfspacing` after `\hspace*{-0.8cm}`; the `abstract` environment is not used (`abs.kernel` is not this) |
| contents entries | preambulo/resumo.tex:13, preambulo/abstract.tex:13, main.tex:65, main.tex:68 | `toc.kernel` | `\addcontentsline{toc}{section}{...}` |
| contents and lists | main.tex:61-68 | `toc.kernel` | `\normalsize`, `\tableofcontents`, `\listoffigures`, `\listoftables` |
| contents title fonts | main.tex:15-17 | `toc.tocloft` | `\cfttoctitlefont` `\cftloftitlefont` `\cftlottitlefont` = `\Large\bfseries\hfill` |
| font sizes and switches | main.tex:15-19, main.tex:61 | `font.size-commands` | `\Large`, `\Huge`, `\normalsize` |
| font switches | main.tex:15-19, preambulo/capa.tex:12, preambulo/capa.tex:21 | `mark.kernel` | `\bfseries`, `\textbf`, `\textit` |
| upper-casing | preambulo/capa.tex:7, preambulo/capa.tex:12, preambulo/capa.tex:27-31, preambulo/aprovacao.tex:9 | `mark.case` | `\MakeUppercase` |
| alignment environments | preambulo/capa.tex:5, preambulo/capa.tex:17, preambulo/aprovacao.tex:17, preambulo/dedicatoria.tex:16 | `sp.ragged` | `center`, `flushright` |
| manual spacing | preambulo/capa.tex:6, preambulo/capa.tex:11, preambulo/capa.tex:15, preambulo/capa.tex:24, preambulo/aprovacao.tex:11, preambulo/aprovacao.tex:15, preambulo/aprovacao.tex:24, preambulo/resumo.tex:16, preambulo/resumo.tex:21 | `sp.manual-space` | `\vspace*{-0.5cm}`, `{8cm}`, `{4cm}`, `{4.2cm}`, `{2.6cm}`, `{1.3cm}`, `\vfill`, `\hfill`, `\bigskip`, `\hspace*{-0.8cm}` |
| signature rules | preambulo/aprovacao.tex:36, preambulo/aprovacao.tex:43, preambulo/aprovacao.tex:49, preambulo/aprovacao.tex:55, preambulo/aprovacao.tex:63 | `sp.rule` | `\rule{\linewidth}{0.1mm}` |
| signature and statement boxes | preambulo/capa.tex:18, preambulo/aprovacao.tex:18, preambulo/aprovacao.tex:33, preambulo/aprovacao.tex:61 | `box.minipage` | widths `7.5cm`, `0.45\linewidth` |
| hyperlinks | main.tex:28-33 | `meta.hyperref` | `colorlinks`, `linkcolor={red!50!black}`, `citecolor={blue!50!black}`, `urlcolor={blue!80!black}`; hyperref loaded main.tex:13 |
| colours | main.tex:13, main.tex:27, main.tex:28-33 | `color.xcolor` | `xcolor` loaded twice, expressions `red!50!black` `blue!50!black` `blue!80!black` |
| legacy colour package | main.tex:13 | `color.color` | `color` loaded, no call in the sample |
| dummy text | res_abs.tex:8, res_abs.tex:14, capitulos/cap01/introduction.tex:16, capitulos/cap02/cap02.tex:16, capitulos/cap03/cap03.tex:16 | `draft.todo` | `\lipsum[1-2]`, `\lipsum[2-4]`, `\lipsum[2-10]`; filler content |
| line numbers | capitulos/cap01/introduction.tex:9-10, capitulos/cap02/cap02.tex:9-10, capitulos/cap03/cap03.tex:9-10, main.tex:13 | `sp.draft-lineno` | `\linenumbers`, `\modulolinenumbers[3]` |
| table | capitulos/cap02/cap02.tex:17-26 | `tbl.tabular` | `table[]` float, `centering`, `tabular{lll}`, `\hline` |
| caption and label | capitulos/cap02/cap02.tex:19-20 | `cap.kernel` | `\caption{...}`; `\label{my-label}` is `xref.kernel` |
| label | capitulos/cap02/cap02.tex:20 | `xref.kernel` | `\label{my-label}`, never referenced in the sample |
| citations | capitulos/cap01/introduction.tex:17, capitulos/cap02/cap02.tex:29, capitulos/cap03/cap03.tex:17 | `bib.natbib` | `\citep`, `\cite`; natbib loaded with defaults (main.tex:13) |
| bibliography per chapter | capitulos/cap01/introduction.tex:29-30, capitulos/cap02/cap02.tex:34-35, capitulos/cap03/cap03.tex:25-26 | `bib.bibtex-bst` | `\bibliography{referencias.bib}`, `\bibliographystyle{apalike}` |
| chapter-wise bibliographies | main.tex:14, capitulos/cap01/introduction.tex:5 | `bib.multi` | `chapterbib` option `sectionbib` |
| file inclusion | main.tex:41-42, main.tex:49-57, main.tex:71-73, main.tex:101-105 | `struct.input` | `\input` of dados, res_abs and the preambulo pages; `\include` of three chapters |
| sub-files with own preamble | main.tex:13, capitulos/cap01/introduction.tex:1-6 | `pg.standalone-pkg` | `standalone` loaded with no options; chapter files carry `\documentclass`, packages and `\begin{document}` |
| loaded, not exercised | main.tex:13 | `fig.float`, `fig.graphicx`, `pg.landscape`, `tbl.longtable`, `tbl.colortbl`, `tbl.booktabs`, `tbl.multirow`, `math.amsmath`, `math.amssymb`, `box.mdframed`, `fn.footmisc`, `pg.include-pdf` | each loaded with no options (`float`, `graphicx`, `lscape`, `longtable`, `colortbl`, `booktabs`, `multirow`, `amsmath`, `amssymb`, `framed`, `footmisc`, `pdfpages`); the only `\includepdf` is a comment (main.tex:113) |
| `xspace` | main.tex:13 | none needed | loaded, `\xspace` never called, no printed effect; same ruling as the rejected `sp.xspace` in the lib change log |
| guide front matter | ecothesis.tex:5, ecothesis.tex:7, ecothesis.tex:13 | `front.maketitle` | `\title` with `\\` and `\texttt`, `\author`, `\maketitle` |
| guide lists | ecothesis.tex:20-52, ecothesis.tex:60-62 | `list.kernel` | nested `itemize`, `description`; `\ttfamily` is `mark.kernel` |
| guide headings | ecothesis.tex:15, ecothesis.tex:56, ecothesis.tex:136 | `head.kernel` | `\section`, `\subsection`, `\subsubsection` |
| guide language and encoding | ecothesis.tex:2-3 | `lang.babel` | `brazil`; inputenc `utf8` is `font.fontenc-t1` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| data aliases `\nome` `\tipo` `\titulo` `\curso` `\programa` `\titulop` `\cidade` `\estado` `\mes` `\ano` `\aprovacao` `\instituicao` `\membroa` to `\membroe` `\nomecite` `\titulacao` `\orientador` `\aprovacaoPT` `\aprovacaoEng` `\tituloEng` | dados.tex:2-27 | yes | `\newcommand` text aliases with no logic; expand inline into the cover, approval sheet and Resumo and Abstract text (document data fields) |
| header-line aliases `\tituloresumo` `\tituloabstract` | res_abs.tex:3-4 | yes | text built from the aliases above plus `\textbf` (`mark.kernel`); expand inline |
| body aliases `\resumoPT` `\resumoEng` | res_abs.tex:6-16 | yes | each holds `\lipsum[1-2]` (`draft.todo`) or the author's text; content |
| `\modelo` | ecothesis.tex:9 | yes | `\texttt{\textbf{ecothesis}}` alias in the guide, `mark.kernel`; expand inline |
| hand-set page counters | capa.tex:3, preambulo/aprovacao.tex:5, preambulo/dedicatoria.tex:4, preambulo/agradecimentos.tex:3, main.tex:88 | yes | kernel `\setcounter{page}` calls (`pgnum.pagenumbering`), no counter is defined |
| chapter sub-file preambles | capitulos/cap01/introduction.tex:1-6, capitulos/cap02/cap02.tex:1-6, capitulos/cap03/cap03.tex:1-6 | yes | `class.report` 12pt plus `font.fontenc-t1`, `lang.babel`, the package list and `bib.multi` chapterbib `sectionbib`, as in main.tex:9-14 minus geometry and fonts; emitted as `pg.standalone-pkg` sub-files |

No zip-local `.cls`, `.sty`, `.def`, `\def`, `\newenvironment`, `\newcounter`, `\newif`, TikZ or `picture` code exists in any .tex file.

## Content-opaque
none (the `.bib` files hold 4 entries each as data: capitulos/cap01/referencias.bib, capitulos/cap02/referencias.bib, capitulos/cap03/referencias.bib; `ecothesis.pdf` and `main.pdf` are built outputs and were not read)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
