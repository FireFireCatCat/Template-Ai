no

# 0790-b201lab-template-buku-ta-its: Template LaTeX Buku Tugas Akhir ITS (Indonesian undergraduate final-project book)

- Unverified: read from the source, not compiled.
- Source: Source/0790-b201lab-template-buku-ta-its/ (origin: https://codeload.github.com/b201lab/template-buku-ta-its/zip/refs/heads/main; licence: MIT)
- Kind: thesis
- Lib: v6
- Engine: pdfLaTeX-compatible (inputenc utf8, txfonts, biblatex with the biber backend; no fontspec)
- Look carried by: preamble (kernel `report` class; the look is in the sample preamble main.tex:6-125 plus zip-local `.tex` fragments under sampul/ and lainnya/ that main.tex `\input`s; the zip has no `.cls` or `.sty`)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (all 21 `.tex` files were read; `.bib`, `.py`, images and CI yaml are data)

## Verdict
`no`. Nearly everything reduces to lib ways: kernel `report`, `geometry`, `titlesec`, `fancyhdr`, `setspace`, `listings`, `longtable`/`tabularx`, `biblatex`+biber, and `eso-pic` for the full-page cover images. One construct does not: main.tex:40-44 uses etoolbox `\patchcmd` to rewrite the kernel's `\cleardoublepage`, so every blank page it inserts shows a vertically centred italic note. This is free-form code edited into a kernel page-flow command, so it fails W2 (not a way) and no lib way expresses "text on inserted blank pages" (`pg.emptypage` does the opposite). It is BESPOKE/preamble and irreducible. Everything else is reducible (see Bespoke code).

## Blockers
- `BESPOKE/preamble` `\patchcmd{\cleardoublepage}{\hbox{}}{\thispagestyle{empty}\vspace*{\fill}\begin{center}\textit{[Halaman ini sengaja dikosongkan]}\end{center}\vfill}{}{}` patches kernel internals; `\cleardoublepage` is called 19 times in main.tex after the patch (main.tex:40-44 is the patch; calls e.g. main.tex:141, main.tex:146, main.tex:160)

## Class setting
- Class: `class.report` options: `12pt`, `twoside` (main.tex:6); the kernel class, source not read (ships with every TeX distribution)
- Class-native vocabulary used: `\chapter` `\chapter*` `\section` `\subsection` `\subsubsection` (main.tex:226; bab/*.tex), `\tableofcontents` `\listoffigures` `\listoftables` (main.tex:188, 194, 200), `\contentsname` `\listfigurename` `\listtablename` `\refname` `\bibname` string macros (main.tex:186, 192, 198, 228, 230), `\figurename` `\tablename` (main.tex:149-150), `\pagenumbering` (main.tex:171, 204). No `\maketitle`, no `abstract` environment: the title page, approval sheet and abstract are hand-laid.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:6 | `class.report` | 12pt, twoside |
| paper and sides | main.tex:6 | `page.class-options` | `12pt`, `twoside` (a4paper comes from geometry) |
| page geometry | main.tex:9 | `page.geometry` | a4paper, top=30mm, left=30mm, right=20mm, bottom=25mm |
| per-cover geometry | sampul/sampul-luar.tex:17-22, 41; sampul/sampul-luar-tipis.tex:17-22, 38 | `page.geometry` | `\newgeometry{top=55mm,left=30mm,right=20mm,bottom=20mm}` (outer), `{top=65mm,left=30mm,right=30mm,bottom=20mm}` (thin), `\restoregeometry` |
| line spacing | main.tex:12 | `sp.setspace` | option `singlespacing` |
| cover spacing env | sampul/sampul-luar.tex:35-37; sampul/konten-id.tex:7-11 | `sp.setspace` | `\begin{spacing}{1.5}` |
| paragraph shape | main.tex:153, 156 | `sp.lengths` | `\parindent`=2em, `\parskip`=1ex |
| hyphenation list | pustaka/tanda-hubung.tex:2-9 | `sp.hyphenat` | `\hyphenation{ro-ket ...}` (6 words) |
| manual vertical space | sampul/konten-id.tex:5, 13, 20, 30; lainnya/lembar-pengesahan.tex:72 | `sp.manual-space` | `\vspace{\fill}`, `\vspace{8ex}`, `\vspace{2ex}`, `\\` |
| text font | main.tex:30 | `font.mathptmx` | `txfonts` (Times-like text and maths) |
| input encoding | main.tex:18 | `font.fontenc-t1` | `inputenc` utf8 |
| size switches | sampul/konten-id.tex:1-3, 8-10; lainnya/kata-pengantar.tex:2; lainnya/lembar-pengesahan.tex:15 | `font.size-commands` | `large` and `Large` as environments, `\small`, `\Large`, `\large` |
| cover face | sampul/sampul-luar.tex:27, 33-34 | `font.nfss` | `\fontseries{bx}\selectfont` (series by name) |
| face switches | sampul/sampul-luar.tex:27; sampul/konten-id.tex:17, 23, 34; lainnya/lembar-pengesahan.tex:3; pustaka/variables.tex:24 | `mark.kernel` | `\sffamily`, `\textmd`, `\mdseries`, `\textbf`, `\emph` |
| upper-case labels | main.tex:90-92; lainnya/lembar-pengesahan.tex:79 | `mark.case` | `\MakeUppercase` |
| underline | lainnya/lembar-pengesahan.tex:74 | `mark.ulem` | kernel `\underline` (no package) |
| colours | main.tex:21, 107-109; sampul/sampul-luar.tex:30 | `color.xcolor` | `table,xcdraw`; `\definecolor` comment RGB 0,128,0, string RGB 255,0,0, keyword RGB 0,0,255; `\color{white}` |
| cover background image | sampul/sampul-luar.tex:1-11; sampul/sampul-luar-tipis.tex:1-11 | `bg.eso-pic` | `\AddToShipoutPictureBG*{\AtPageLowerLeft{...}}` holding `\includegraphics[width=\paperwidth,height=\paperheight]{png}` with `\hspace{-3.25mm}` / `\hspace{-4mm}` and `\raisebox{0mm}`; the PNG is a shipped raster asset (logo, blue band), not a drawing |
| cover image inclusion | sampul/sampul-luar.tex:8 | `fig.graphicx` | `\includegraphics[width,height]` |
| cover content layout | sampul/sampul-luar.tex:24-39; sampul/konten-id.tex:1-40 | `sp.ragged` | `flushleft`; fill-spaced blocks; text from `\newcommand` variables |
| cover page style | sampul/sampul-luar.tex:14 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| header/footer | main.tex:47-51 | `hf.fancyhdr` | `\fancyhf{}`, `\renewcommand{\headrulewidth}{0pt}`, `\pagestyle{fancy}`, `\fancyfoot[LE,RO]{\thepage}` |
| chapter-page style | main.tex:52-53 | `hf.fancyhdr` | the two `\patchcmd{\chapter}` lines give chapter-opening pages the `fancy` style; reduction `\fancypagestyle{plain}` with the same fields (see Bespoke code) |
| unnumbered pages | lainnya/lembar-pengesahan.tex:7; lainnya/pernyataan-keaslian.tex:7 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| page numbering | main.tex:135, 171, 204 | `pgnum.pagenumbering` | `\setcounter{page}{1}`, `roman`, `arabic` |
| page breaks | main.tex:140-141, 146, 160, 208 | `pg.break` | `\clearpage`, `\cleardoublepage` |
| blank-page text | main.tex:40-44 | blocker | see Blockers: no lib way |
| chapter heading | main.tex:89, 93 | `head.titlesec` | `\titleformat{\chapter}[display]{\bfseries\Large}{BAB \centering\Roman{chapter}}{0ex}{\vspace{0ex}\centering}`, `\titlespacing{\chapter}{0ex}{0ex}{4ex}` |
| section heading | main.tex:90, 94 | `head.titlesec` | `{\bfseries\large}{\MakeUppercase{\thesection}}{1ex}{\vspace{1ex}}`, spacing `{0ex}{1ex}{0ex}` |
| subsection, subsubsection | main.tex:91-92, 95-96 | `head.titlesec` | same shape, label `\MakeUppercase{\thesubsection}`, spacing `{0ex}{0.5ex}{0ex}` |
| chapter commands | bab/1-pendahuluan.tex:1 (and line 1 of the other four bab files); main.tex:226 | `head.kernel` | `\chapter{...}` for the five chapters, `\chapter*{DAFTAR PUSTAKA}` for the bibliography; the front-matter pages in lainnya/ and abstrak/ use no chapter command, only a centred heading plus `\addcontentsline` |
| title block | main.tex:2-3, 15 | `front.maketitle` | `\title`, `\author` set before `\documentclass`; no `\maketitle`; only `\@author` is read, for the PDF field |
| cover and title pages | sampul/konten-id.tex:1-40; sampul/konten-en.tex:1-40 | `front.dedication` | hand-laid pages; strings from `\newcommand` variables (pustaka/variables.tex:4-47) |
| approval sheet | lainnya/lembar-pengesahan.tex:1-81; lainnya/lembar-pengesahan-en.tex:1-82 | `front.dedication` | `center` blocks, `\small` group |
| approval signature grid | lainnya/lembar-pengesahan.tex:41-65 | `tbl.tabularx` | `{X l}`, `\tabcolsep`=0pt |
| statement of originality | lainnya/pernyataan-keaslian.tex:1-41; lainnya/pernyataan-keaslian-en.tex:1-41 | `front.dedication` | heading, two paragraphs, signature table |
| originality tables | lainnya/pernyataan-keaslian.tex:15, 29 | `tbl.tabularx` | `{l l X}`, `{X l}` |
| foreword | lainnya/kata-pengantar.tex:1-38 | `front.dedication` | `\Large\textbf` centred heading, enumerate, right-aligned signature `tabular[b]{c}` |
| signature block | lainnya/kata-pengantar.tex:29-38 | `tbl.tabular` | `\begin{tabular}[b]{c}` inside `flushright` |
| abstract page | abstrak/abstrak-id.tex:1-28; abstrak/abstrak-en.tex:1-28 | `front.dedication` | hand-laid (not `abs.kernel`): centred `\large\textbf{ABSTRAK}`, metadata table, body paragraph |
| abstract metadata table | abstrak/abstrak-id.tex:11-21 | `tbl.tabularx` | `{l >{\centering}m{2em} X}` (array `m` and `>` column types), `\tabcolsep`=0pt; English file `m{3em}` (abstrak-en.tex:14) |
| keywords line | abstrak/abstrak-id.tex:28; abstrak/abstrak-en.tex:28 | `abs.keywords` | `Kata Kunci:` plain line, `\emph` in English file |
| contents lists | main.tex:186-201 | `toc.kernel` | `\renewcommand*\contentsname{DAFTAR ISI}`, `\listfigurename{DAFTAR GAMBAR}`, `\listtablename{DAFTAR TABEL}`, `\addcontentsline{toc}{chapter}{...}`, `\tableofcontents`, `\listoffigures`, `\listoftables` |
| toc entries of front pages | abstrak/abstrak-id.tex:5; lainnya/kata-pengantar.tex:6; lainnya/biografi-penulis.tex:6 | `toc.kernel` | `\addcontentsline{toc}{chapter}{...}` |
| float names | main.tex:149-150 | `cap.kernel` | `\figurename`=Gambar, `\tablename`=Tabel |
| figure float | bab/2-tinjauan-pustaka.tex:12-21 | `fig.float` | `figure[H]` (float package) |
| figure content | bab/2-tinjauan-pustaka.tex:16 | `fig.graphicx` | `\includegraphics[scale=0.35]`, `\centering` |
| caption | bab/2-tinjauan-pustaka.tex:19; bab/4-pengujian-analisis.tex:20 | `cap.kernel` | `\caption`, `\label`, no caption package |
| wrapped photo | lainnya/biografi-penulis.tex:10-16 | `fig.wrapfig` | `wrapfigure{L}{0.3\textwidth}`, `\includegraphics[width=0.3\textwidth]`, `\vspace{-3ex}` and `\vspace{-4ex}` |
| table | bab/4-pengujian-analisis.tex:19-31 | `tbl.longtable` | `longtable{|c|c|c|}`, caption in first row, `\hline` |
| header row shading | bab/4-pengujian-analisis.tex:23 | `tbl.colortbl` | `\rowcolor[HTML]{C0C0C0}` (xcolor `table`) |
| equation | bab/2-tinjauan-pustaka.tex:39-42 | `math.kernel` | `equation` with `\label`; no `amsmath`; `\mathbf` `\frac` `\mathrm` |
| lists | bab/1-pendahuluan.tex:25, 38, 53; bab/5-penutup.tex:11, 26; lainnya/kata-pengantar.tex:17 | `list.enumitem` | `enumerate[nolistsep]` |
| cross-references | bab/*.tex `\label`; bab/2-tinjauan-pustaka.tex:25, 36 | `xref.kernel` | `\label`, `\ref`; hyperref makes them links |
| PDF metadata and links | main.tex:15 | `meta.hyperref` | `pdfauthor={\@author}`, `bookmarksnumbered`, `pdfborder={0 0 0}` |
| code listings | main.tex:106-125; bab/3-desain-implementasi.tex:19-39 | `code.listings` | `\lstdefinestyle{codestyle}`: commentstyle, stringstyle, keywordstyle colours, `basicstyle=\footnotesize\ttfamily`, `numbers=left`, `numberstyle=\tiny`, `numbersep=5pt`, `frame=lines`, `breaklines=true`, `prebreak` hook arrow, `showstringspaces=false`, `upquote=true`, `tabsize=2`; `\lstset{style=codestyle}`; `lstlisting[language=C++,caption,label]`, `\lstinputlisting[language=Python,...]` |
| prebreak mark | main.tex:120 | `sp.manual-space` | `\raisebox{0ex}[0ex][0ex]{\ensuremath{\hookleftarrow}}` |
| bibliography | main.tex:24, 103, 233 | `bib.biblatex-biber` | `style=apa`, `backend=biber`, `\addbibresource{pustaka/pustaka.bib}`, `\printbibliography`, `\parencite` (bab/2-tinjauan-pustaka.tex:19, 35) |
| bibliography heading | main.tex:226-234 | `bib.biblatex-biber` | `\chapter*{DAFTAR PUSTAKA}` set by hand, `\refname` and `\bibname` emptied, heading of `\printbibliography` suppressed (reduction: `heading=none`) |
| date strings | main.tex:56-85; lainnya/lembar-pengesahan.tex:79; lainnya/kata-pengantar.tex:31 | `front.datetime` | month name and year of the compile date (`\MONTH`, `\ENGMONTH`, `\the\year`); reduction in Bespoke code |
| file inclusion | main.tex:98, 100, 132, 159-238 | `struct.input` | `\input{path}` of 21 fragments |
| filler text | main.tex:33; bab/1-pendahuluan.tex:6 | `draft.todo` | `lipsum` `\lipsum[n][range]` (content) |
| load-only packages | main.tex:27 | `page.adjustwidth` | `changepage` loaded, `adjustwidth` never called (grep over all `.tex`) |
| language | main.tex (no babel) | none | no `babel`; Indonesian words are typed text and string redefinitions |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\patchcmd{\cleardoublepage}` blank-page message | main.tex:40-44 | No | Rewrites the kernel macro with free-form code: inserted blank pages get empty page style, `\vspace*{\fill}`, centred `\textit{[Halaman ini sengaja dikosongkan]}`, `\vfill`. The parts are kernel commands, but the mechanism edits kernel page-flow code (W2 fails for `\patchcmd`, the lib has no patch way), and the lib's only blank-page way `pg.emptypage` does the opposite. Considered: etoolbox. BESPOKE/preamble |
| `\patchcmd{\chapter}{plain}{fancy}`, `{empty}{plain}` | main.tex:52-53 | Yes | Effect is the `fancy` footer (page number at LE,RO, no head rule, main.tex:48-51) on chapter-opening pages: `\fancypagestyle{plain}{\fancyhf{}\fancyfoot[LE,RO]{\thepage}\renewcommand{\headrulewidth}{0pt}}` under `hf.fancyhdr`. titlesec is loaded after these lines (main.tex:88) and its own `\chapter` handling was not read, so whether the patches take effect is unverified |
| `\MONTH`, `\ENGMONTH` | main.tex:56-85 | Yes | A month-name lookup by `\ifcase\the\month`, printing a string only. `front.datetime` (`\newdateformat` with `\monthname`) plus `lang.babel` Indonesian/English month names, or the date as literal text in the emitted document |
| `\def\chapter*#1{}` inside a group | main.tex:231-234 | Yes | Swallows biblatex's own `\chapter*{...}` heading; same visible effect as `\printbibliography[heading=none]` after the hand-set `\chapter*{DAFTAR PUSTAKA}` (main.tex:226) |
| `\renewcommand*\contentsname` `\listfigurename` `\listtablename` `\refname` `\bibname` `\figurename` `\tablename` | main.tex:149-150, 186, 192, 198, 228, 230 | Yes | String-macro aliases; set the strings in the emitted preamble (`toc.kernel`, `cap.kernel`) |
| `\newcommand` variables (`\name`, `\advisor`, `\tatitle`, `\nrp`, ... 40 of them) | pustaka/variables.tex:4-47 | Yes | Text aliases with no logic; inline expansion into the page text |
| `\newcommand\covercontents` / `\renewcommand\covercontents` with `\input{\covercontents}` | main.tex:131, 138, 144; sampul/sampul-luar.tex:36; sampul/sampul-luar-tipis.tex:33 | Yes | A file-name macro; the emitter writes each cover's content inline in the cover wrapper (`struct.input` if the file split is kept) |
| `pdfauthor={\@author}` | main.tex:15 | Yes | A string parameter of `meta.hyperref`. Note: `\@author` is written without `\makeatletter`, so `@` is catcode 12 and it likely reads as `\@` plus the letters "author" (not verified) |

## Content-opaque
none (the cover PNGs under sampul/gambar/ are shipped raster backgrounds placed by `eso-pic`, not TikZ or PGF, so no `ART`; elon.jpg and roketluarangkasa.jpg are figure content; `lipsum` text, the equation, the C++ and Python listings and pustaka/pustaka.bib are content). sampul/sampul-dalam.tex (37 lines, same pattern with `sampul-dalam.png`) is never `\input` by main.tex (grep over `*.tex`).

## Lib changes
- New ways proposed: none (considered: etoolbox `\patchcmd`, rejected: its parameters are search and replacement code, so W2 fails; no `NEW:` way is written in this file)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
