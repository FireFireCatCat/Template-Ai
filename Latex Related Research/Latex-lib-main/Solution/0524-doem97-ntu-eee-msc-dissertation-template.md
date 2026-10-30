no

# 0524-doem97-ntu-eee-msc-dissertation-template: NTU EEE M.Sc. Dissertation Template

- Unverified: read from the source, not compiled.
- Source: Source/0524-doem97-ntu-eee-msc-dissertation-template/ (origin: https://codeload.github.com/doem97/NTU-EEE-MSc-Dissertation-Template/zip/refs/heads/main; licence: not established)
- Kind: thesis
- Lib: v4
- Engine: pdfLaTeX-compatible (README.md:11 recommends pdfLaTeX; `inputenc`, `mathptmx`, no fontspec; `minted` needs shell escape and Pygments, see Blockers)
- Look carried by: preamble (kernel `report` class; every look decision is the package list and `\fancypagestyle` in main.tex:7-48, plus five hand-laid `titlepage` files under Title/)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; Preview.pdf and Chapter1/Preview.pdf are binary previews, not read)
- Read: main yes, zip-local classes and styles none present (the zip has no .cls, .sty, .def, .cfg, .clo, .bst or .dtx; every .tex file, References.bib, sample.py and README.md were read in full)

## Verdict
no. Apart from two EXTERNAL items the whole template reduces to lib ways: kernel `report`, a `geometry` call, a `fancyhdr` page style, `setspace` blocks, hand-laid `titlepage` environments, `appendix` and `tocbibind`, and BibTeX `unsrt`. There is no zip-local macro, class or artwork. The blocker is `minted`: main.tex loads it unconditionally and the appendix calls `\inputminted`, so the document does not compile without shell escape and Pygments (pilot ruling for `code.minted`). A second EXTERNAL item is the `.eps` figure under pdfLaTeX. Without them this would be `yes`.

## Blockers
- `EXTERNAL/package` `\usepackage{minted}` loaded unconditionally in the preamble (main.tex:14) and used by `\inputminted[tabsize=4, breaklines, fontsize=\scriptsize]{python}{Appendix/sample.py}` (Appendix/appendix.tex:20-24); needs shell escape and Pygments
- `EXTERNAL/body` an EPS file is included under pdfLaTeX: `\includegraphics[width=4in, fbox]{Chapter1/boundingbox.eps}` (Chapter1/Chapter1.tex:46); `epstopdf` is not loaded by the sample (main.tex:19 loads only `graphicx`), so the conversion relies on TeX Live's automatic hook and Ghostscript; reasoned from the `fig.epstopdf` lib line, not tested; the verdict does not rest on it

## Class setting
- Class: `class.report` options: `12pt` (main.tex:7); default `oneside`, default paper from `geometry`
- Class-native vocabulary used: `\chapter`, `\chapter*`, `\section`, `\subsection` (Chapter1/Chapter1.tex:4,10; Chapter6/Chapter6.tex:20), `titlepage` environment (Title/coverpage.tex:1), `\tableofcontents` `\listoffigures` `\listoftables` (main.tex:68,78,83), `\bibname` `\contentsname` `\listfigurename` `\listtablename` name macros (main.tex:67,77,82,100), `\appendix`-style chapters via the `appendices` environment (Appendix/appendix.tex:3). No `abstract` environment, no `\maketitle`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:7 | `class.report` | 12pt |
| page geometry | main.tex:10 | `page.geometry` | a4paper, top=3cm, bottom=3cm, left=3.5cm, right=3cm, marginparwidth=1.75cm, headheight=22pt |
| header and footer | main.tex:28,36-42 | `hf.fancyhdr` | `\fancypagestyle{plain}`: `\fancyhf{}`, `\fancyhead[R]{\bf \small \textsl{\nouppercase{\leftmark}} \vspace{0.1in}}`, `\fancyfoot[R]{\thepage}`, `\headrulewidth`=2pt |
| page style switch | main.tex:48 | `hf.pagestyle-kernel` | `\pagestyle{plain}` (the redefined plain style) |
| running-head text | Front/Abstract.tex:6; Front/Acknowledgement.tex:6; Front/Acronyms.tex:5; Front/Symbols.tex:5; Appendix/appendix.tex:7,16 | `hf.fancyhdr` | `\markboth{<name>}{}` sets `\leftmark` by hand on the front pages and appendix chapters; chapters carry no `\markboth` (the `\chaptermark` override is commented out, main.tex:49) |
| header font switches | main.tex:38 | `mark.kernel` | `\bf`, `\textsl`; size `\small` in `font.size-commands` |
| header vertical space | main.tex:38 | `sp.manual-space` | `\vspace{0.1in}` |
| page numbering | main.tex:65,91 | `pgnum.pagenumbering` | roman for front matter, arabic for the main part |
| paragraph shape | main.tex:45; Chapter1/Chapter1.tex:6 (line 6 in Chapter2 to Chapter6 too); Front/Abstract.tex:10; Front/Acknowledgement.tex:8; Front/Acronyms.tex:7; Front/Symbols.tex:7 | `sp.lengths` | `\parindent`=0in; `\parskip`=0.3in inside each chapter and front page |
| line spacing | main.tex:24,26; Chapter1/Chapter1.tex:5; Title/SoO.tex:9; main.tex:102-104 | `sp.setspace` | `\usepackage{setspace}` (twice); `spacing` environment: 1.5 for chapters, front pages and the bibliography, 2 for the declaration pages |
| interword space | main.tex:54 | `sp.lengths` | `\fontdimen2\font=0.5em` right after `\begin{document}`; one literal primitive dimension assignment; judgement call, see Bespoke code |
| text font | main.tex:32 | `font.mathptmx` | `mathptmx` (Times text and math) |
| mono font | main.tex:13 | `font.mono` | `courier` |
| input encoding | main.tex:31 | `font.fontenc-t1` | `inputenc` option `utf8` |
| font sizes | Title/coverpage.tex:13-23; Title/titlepage.tex:4-15 | `font.size-commands` | `\Huge`, `\LARGE`, `\normalsize`, `\large`, `\Large` (SoO.tex:4) |
| bold marks | Title/coverpage.tex:13; Front/Abstract.tex:17; Front/Acronyms.tex:15 | `mark.kernel` | `\textbf`, `\bf`, `\texttt` (Chapter1/Chapter1.tex:32) |
| upper-case marks | Title/titlepage.tex:6,8,9 | `mark.case` | `\MakeUppercase` around name, school, degree lines |
| cover page | Title/coverpage.tex:1-25; main.tex:56 | `front.titlepage-env` | `titlepage` with `\centering`, a `figure[h!]` holding `\includegraphics[width=1\textwidth]{Title/NTU_logo.png}` and an empty `\caption*{}`, `\vspace{1.5in}`, `\\[2.5in]`, `\\[0.5in]`, `\\[0.2in]` |
| cover page figure | Title/coverpage.tex:3-8 | `fig.graphicx`, `cap.caption`, `xref.kernel` | `figure[h!]`, `\includegraphics`, starred `\caption*{}`, `\label{fig:entropy}` |
| title page | Title/titlepage.tex:1-17; main.tex:57 | `front.titlepage-env` | `titlepage` + `center`, `\vspace*{2in}`, `\\[2.5in]`, `\\[1in]`, `\\[0.5in]`, `\\[0.75in]` |
| manual vertical space and line gaps | Title/titlepage.tex:3-9; Title/coverpage.tex:10-17 | `sp.manual-space` | `\vspace`, `\vspace*`, `\\[len]` |
| centred blocks | Title/titlepage.tex:2; Title/SoO.tex:3 | `sp.ragged` | `center` environment, `\centering` |
| declaration pages | Title/SoO.tex:1-21; Title/SDS.tex:1-19; Title/AAS.tex:1-21; main.tex:58-60 | `front.titlepage-env`, `front.dedication` | `titlepage` env: centred `\Large{\bf{...}}` heading, `\vspace{0.2in}`, `spacing{2}` text, `\vspace{2.5cm}`, signature row |
| signature lines | Title/SoO.tex:18-19 (SDS.tex:16-17, AAS.tex:18-19) | `sp.rule`, `box.fancybox`, `sp.manual-space` | `\makebox[4cm]{\dotfill}` `\hfill` `\makebox[4cm]{Date}`; `\makebox` is filed with the kernel `\fbox` family, a judgement call |
| split front pages | main.tex:56-60,71-74,92-97,107 | `struct.input` | `\include{path}` (new page before and after) |
| table of contents | main.tex:67-69 | `toc.kernel` | `\renewcommand*\contentsname{\centering Table of Contents}`, `\tableofcontents`, `\newpage` |
| contents-list extras | main.tex:17 | `toc.etoc` | `tocbibind` options `nottoc,notlot,notlof` |
| contents entries for unnumbered pages | Front/Abstract.tex:12; Front/Acknowledgement.tex:10; Front/Acronyms.tex:9; Front/Symbols.tex:9; main.tex:79,84 | `toc.kernel` | `\addcontentsline{toc}{chapter}{...}` |
| list of figures and tables | main.tex:77-85 | `toc.kernel` | `\renewcommand{\listfigurename}{\centering List of Figures}`, `\listoffigures`; same for tables |
| abstract page | Front/Abstract.tex:3-19 | `head.kernel`, `abs.keywords`, `sp.setspace`, `sp.lengths` | `\chapter*{\centering Abstract}` (not an `abstract` environment), `spacing{1.5}`, `\parskip`=0.3in, keyword line `\par\textbf{Keywords:}` |
| acknowledgement page | Front/Acknowledgement.tex:5-15 | `front.dedication`, `head.kernel` | `\chapter*{\centering Acknowledgements}` |
| acronym and symbol lists | Front/Acronyms.tex:11-24; Front/Symbols.tex:11-21 | `tbl.tabular`, `sp.ragged` | `table[ht]`, `\centering`, `tabular{ll}`, bold first column, no caption; symbols are inline maths (`math.amsmath`) |
| chapters | Chapter1/Chapter1.tex:4 (Chapter2 to Chapter6 same line) | `head.kernel` | default `report` `\chapter`, no `titlesec` |
| sections | Chapter1/Chapter1.tex:10; Chapter6/Chapter6.tex:18-20 | `head.kernel` | default `\section`, `\subsection` |
| bullet lists | Chapter1/Chapter1.tex:38-41 | `list.kernel` | `enumerate` with two items |
| table | Chapter1/Chapter1.tex:17-30; main.tex:20 | `tbl.tabular`, `tbl.booktabs`, `cap.kernel` | `table[ht]`, `\centering`, `\caption`, `tabular[t]{lcc}`, `\toprule` `\midrule` `\bottomrule` |
| caption style | main.tex:18 | `cap.caption` | `labelfont=bf`, `textfont=bf` |
| figure | Chapter1/Chapter1.tex:44-49; main.tex:16,19 | `fig.graphicx`, `fig.adjustbox`, `sp.lengths` | `figure[ht]`, `\includegraphics[width=4in, fbox]`; the `fbox` key comes from `adjustbox` option `export` (main.tex:16); frame width `\fboxrule`=0.5pt (main.tex:47) |
| EPS inclusion | Chapter1/Chapter1.tex:46 | `fig.epstopdf` | automatic conversion of `boundingbox.eps` (EXTERNAL, see Blockers) |
| float package (loaded, not used) | main.tex:23 | `fig.float` | `float`, no `[H]` placement in any file |
| subfigures (loaded, not used) | main.tex:25 | `fig.subcaption` | `subfigure`, no `\subfigure` in any file |
| table width package (loaded, not used) | main.tex:30 | `tbl.tabularx` | `tabularx`, no `tabularx` environment in any file |
| dummy text package (loaded, not used) | main.tex:27 | `draft.todo` | `lipsum`, no `\lipsum` in any file |
| cross-references | Chapter1/Chapter1.tex:15,20,36,48,51,54 | `xref.kernel`, `xref.hyperref` | `\label`; `\autoref{tabelsample}`, `\autoref{fig:boundingboxexample}`, `\autoref{eq:euler}` |
| hyperlinks | main.tex:22,29; Chapter1/Chapter1.tex:58 | `meta.hyperref`, `meta.url` | `hyperref` with no options; `url`; `\url{...}` |
| math | main.tex:11; Chapter1/Chapter1.tex:51-56 | `math.amsmath` | `amsmath`; `equation` with `\label`; inline `$...$` |
| footnotes | main.tex:21; Chapter1/Chapter1.tex:58 | `fn.kernel`, `fn.footmisc` | `\footnote{\url{...}}`; `footmisc` option `bottom` |
| citations | main.tex:12; Chapter1/Chapter1.tex:13 | `bib.cite-pkg` | `cite`; `\cite{ronneberger2015unet}` |
| bibliography | main.tex:100-104; Ref/References.bib:1-7 | `bib.bibtex-bst` | `\bibliographystyle{unsrt}`, `\bibliography{Ref/References}` inside `spacing{1.5}`, `\renewcommand\bibname{References}` |
| appendices | main.tex:15,107; Appendix/appendix.tex:3-26 | `num.appendix` | `appendix` package option `titletoc`; `appendices` environment with `\chapter` entries (Appendix A, B) |
| code listing | main.tex:14; Appendix/appendix.tex:20-24 | `code.minted` | `\inputminted[tabsize=4, breaklines, fontsize=\scriptsize]{python}{Appendix/sample.py}` (EXTERNAL, see Blockers) |
| page breaks | main.tex:69,80,85,105; Chapter1/Chapter1.tex:34,80; Front/Abstract.tex:3,19 | `pg.break` | `\newpage` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| redefinition of `plain` page style | main.tex:36-42 | yes | `\fancypagestyle` call of `hf.fancyhdr` with the fields and `\headrulewidth` above |
| `\renewcommand` of `\contentsname`, `\listfigurename`, `\listtablename`, `\bibname` | main.tex:67,77,82,100 | yes | kernel name macros redefined to a string (two with a leading `\centering`); parameters of `toc.kernel` and `bib.bibtex-bst` |
| `\fontdimen2\font=0.5em` | main.tex:54 | yes, judgement call | one literal dimension assignment to the interword-space font parameter, no computation; filed under `sp.lengths` (raw TeX dimension assignment). Sibling analyses 0223 and 0240 found no way for `\fontdimen` because there it is computed per size and shape; here it is one value. Considered: a separate `\fontdimen` way, not proposed. If `sp.lengths` is ruled not to cover font parameters, this is a one-line gap, not an irreducible block |
| `\caption*{}` plus `\label{fig:entropy}` inside the cover `titlepage` | Title/coverpage.tex:6-7 | yes | starred caption of `cap.caption` with an empty argument, a kernel label; no counter is used |
| zip-local macros, environments, counters, conditionals | none: no `\newcommand`, `\def`, `\newenvironment` or `\newcounter` anywhere in the zip (the only `\renewcommand` calls are the ones above, and `\let\cleardoublepage\clearpage` at main.tex:63 is commented out) | n/a | none |

## Content-opaque
- Included image `Title/NTU_logo.png` on the cover (Title/coverpage.tex:5) and EPS artwork `Chapter1/boundingbox.eps` (Chapter1/Chapter1.tex:46): shipped assets, figure content, not template drawing code.
- Code sample text in `Appendix/sample.py:1-9` (a Python file whose body contains a destructive-looking shell string); it is only typeset by `\inputminted`, it was read and not executed. Nothing in the zip addresses an AI.
- No TikZ, PGF or `picture` drawing anywhere in the zip, so no `ART` item.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
