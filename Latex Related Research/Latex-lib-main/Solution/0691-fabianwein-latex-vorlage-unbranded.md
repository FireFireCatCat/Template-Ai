yes

# 0691-fabianwein-latex-vorlage-unbranded: LaTeX-Vorlage-Unbranded (German Bachelor/Master thesis and project-report template)

- Unverified: read from the source, not compiled.
- Source: Source/0691-fabianwein-latex-vorlage-unbranded/ (origin: https://codeload.github.com/FabianWein/LaTeX-Vorlage-Unbranded/zip/refs/heads/main; licence: GPL-3.0 per the manifest, LICENSE file in the zip)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible (`inputenc` utf8, `fontenc` T1, `mathptmx`, BibTeX; no fontspec or Lua)
- Look carried by: preamble (kernel `article` unchanged; the look is Main.tex's package list and page style, plus hand-laid front-matter pages in separate `.tex` files)
- Class origin: tex-distribution-unbundled
- Main file: Main.tex (other samples: none; the sample PDF Beispielausgabe.pdf is an author-made output, not read)
- Read: main yes (every `\input`/`\include` file read in full), zip-local classes and styles partly (no `.cls`, `.sty`, `.def` in the zip; the one zip-local style-like file, deIEEEtran.bst, 2428 lines, was read at lines 1-120 and 222-297 and by greps; lines 121-221 and 298-2428 were not read)

## Verdict
yes. The document class is the unchanged kernel `article` and every package is published (CTAN or TeX Live): the page, header, spacing, font, float, caption, acronym and bibliography settings are package options and kernel commands (Main.tex:2-43, 61, 65-82). The only zip-local code is one `\newcommand` for a cross-reference target (Main.tex:49-57), which reduces to `\phantomsection\label` plus a `\hyperref` with the link text, and a `.bst` that is IEEEtran.bst with German string constants. There is no artwork: the two logos are image files placed with `textpos`.

## Blockers
none

## Class setting
- Class: `class.article` options: `ngerman`, `a4paper`, `12pt`, `oneside` (Main.tex:2); `ngerman` is also given to `babel` as its own option (Main.tex:12). The class source was not read (it ships with the TeX distribution).
- Class-native vocabulary used: `\section` `\subsection` `\subsubsection` (Main.tex:136, Einfuehrung.tex:1,9, Zielsetzung.tex:1,4,5), `\tableofcontents` `\listoffigures` `\listoftables` (Main.tex:120,150,156), `\contentsname` `\listfigurename` `\listtablename` `\refname` `\figurename` (Main.tex:119,130,149,155,164). `\maketitle`, the `abstract` environment and `\appendix` are not used: the title page, the abstracts and the appendix heading are hand-laid.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | Main.tex:2 | `class.article` | ngerman, a4paper, 12pt, oneside |
| paper, size, sides | Main.tex:2 | `page.class-options` | a4paper, 12pt, oneside |
| page geometry | Main.tex:10 | `page.geometry` | left=3cm, right=2cm, top=2.5cm, bottom=2cm |
| column gap length (no columns are used) | Main.tex:5 | `sp.lengths` | `\columnsep`=10mm |
| multicolumn package (loaded, not called) | Main.tex:42 | `cols.multicol` | load only |
| running head and foot | Main.tex:16,65-75 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\lhead{\nouppercase\leftmark}`, `\chead{}`, `\rhead[\leftmark]{\thepage}`; `\lfoot{}` `\cfoot{}` `\rfoot{}` empty; `\headrulewidth`=0.4pt |
| page-style switches in the body | Main.tex:86,104,124,129,142 | `hf.pagestyle-kernel` | `empty` for the title page, `plain` for front and back matter, `fancy` for the main part |
| page numbering | Main.tex:94,103,106,117,128,143,147 | `pgnum.pagenumbering` | `Roman`, `gobble`, `arabic`; `\setcounter{page}` 4 and 6 |
| line spacing | Main.tex:31,82,87-90,108-113,118-121,145-151,153-158 | `sp.setspace` | `\setstretch{1.5}` document-wide; `singlespace` environment around the title page, acronym list, contents and lists of floats |
| paragraph indent | Main.tex:80 | `sp.lengths` | `\parindent`=0pt |
| hyphenation exception | Main.tex:46 | `sp.hyphenat` | `\hyphenation{Bei-spiel-tren-nung}` |
| manual spacing | Main.tex:109, Titelseite_Abschlussarbeit.tex:8,17,26, Erklaerung_Abschlussarbeit.tex:4,6,10,16, Erklaerung_Projektarbeit.tex:23, Zusammenfassung.tex:3,10, Anhang.tex:4 | `sp.manual-space` | `\vspace`, `\vspace*`, `\hspace{7cm}` (1cm, 3.5cm, 4mm, 5mm, 10mm...) |
| signature rule | Erklaerung_Abschlussarbeit.tex:19, Erklaerung_Projektarbeit.tex:23,26,30 | `sp.rule` | `\rule{1.0\textwidth}{0.4pt}`; kernel `\underline{\hspace{7cm}}` and `{10cm}` as a ruled blank (not read as `mark.ulem`: no text is underlined) |
| page breaks | Main.tex:98,102,105,115,122,132,135,141,146,157,161,166 | `pg.break` | `\newpage`, `\cleardoublepage`, `\clearpage` |
| text font | Main.tex:19,24 | `font.lmodern`, `font.mathptmx` | `lmodern` then `mathptmx`; the later package should set Times for text and maths (not verified by compiling) |
| encodings | Main.tex:13,22,25 | `font.fontenc-t1` | `inputenc` utf8, `textcomp`, `fontenc` T1 |
| euro glyph package (loaded, not called) | Main.tex:32 | `font.icons` | `eurosym`, load only |
| font sizes and shapes in hand-laid headings | Erklaerung_Abschlussarbeit.tex:1,8, Zusammenfassung.tex:1,8, Anhang.tex:1,6, Main.tex:111 | `font.size-commands`, `mark.kernel` | `\LARGE`, `\Large`, `\large`, `\Huge`, `\normalsize`; `\textbf`, `\textit` |
| colour package (loaded, no colour used) | Main.tex:11 | `color.color` | load only |
| language | Main.tex:2,12 | `lang.babel` | `ngerman`; `\glqq ... \grqq` quotes at Anhang.tex:10 |
| caption-name overrides | Main.tex:119,130,149,155,164 | `lang.babel` | `\renewcommand` of `\contentsname`=Inhaltsverzeichnis, `\figurename`=Abb., `\listfigurename`=Abbildungsverzeichnis, `\listtablename`=Tabellenverzeichnis, `\refname`=Literaturverzeichnis |
| PDF link options | Main.tex:41 | `meta.hyperref` | `hidelinks` |
| URLs | Main.tex:15, Einfuehrung.tex:27,33 | `meta.url` | `url`; `\url{...}` |
| labels and references | Einfuehrung.tex:2,19,26,62,65,69, Anhang.tex:3,11 | `xref.kernel`, `xref.hyperref` | `\label`, `\autoref{tab:...}` `\autoref{abb:...}`, `\nameref{kap:Einfuehrung}` (Anhang.tex:10), `\nameref{label:Anhang}` |
| link anchors for unnumbered headings | Main.tex:110,148,154,163, Erklaerung_Abschlussarbeit.tex:1, Zusammenfassung.tex:1,8, Anhang.tex:1 | `xref.hyperref` | `\phantomsection` before `\addcontentsline` |
| title page | Titelseite_Abschlussarbeit.tex:1-52, Main.tex:89 | `front.titlepage-env` | hand-laid: `center` around a one-cell `tabular{p{\textwidth}}` holding `center` blocks, `\LARGE\textbf` title, `\Huge` university name, a `tabular{lll}` of examiners and dates (Titelseite_Abschlussarbeit.tex:38-48); `\include` (Main.tex:89) inside `singlespace` and `\pagestyle{empty}` |
| logo placement on the title page | Titelseite_Abschlussarbeit.tex:4-6, Main.tex:28 | `pg.textpos` | `textpos[absolute]`; `\begin{textblock*}{50mm}(20mm,15mm)` holding `\includegraphics[height=2cm]` |
| alternative project-report title page (not included by Main.tex) | Titelseite_Projektarbeit.tex:1-71 | `front.titlepage-env`, `pg.textpos`, `tbl.tabular` | two `textblock*`: {40mm}(20mm,15mm) and {25mm}(170mm,15mm); `table[H]` with `tabular{ccc}` of four authors (:37-46) |
| declaration page | Erklaerung_Abschlussarbeit.tex:1-21, Main.tex:96 | `front.dedication` | hand-laid heading, statement text, rule and caption line |
| declaration page, project variant (not included) | Erklaerung_Projektarbeit.tex:1-33 | `front.dedication`, `tbl.tabular` | `table[H]`, `tabular{lll}`, `\multicolumn{3}{c}` |
| abstract pages (German and English, no `abstract` environment) | Zusammenfassung.tex:1-11, Main.tex:100 | `front.dedication` | hand-laid headings (`\LARGE\textbf`), `\par` text, `\newpage` between the two (:7) |
| contents lists | Main.tex:120,150,156 | `toc.kernel` | `\tableofcontents`, `\listoffigures`, `\listoftables` |
| manual contents entries | Main.tex:110,148,154,163, Erklaerung_Abschlussarbeit.tex:2, Zusammenfassung.tex:2,9, Anhang.tex:2 | `toc.kernel` | `\addcontentsline{toc}{section}{...}` |
| acronym list | Main.tex:61,108-113, acronym.tex:1-4, Einfuehrung.tex:11 | `idx.glossaries` | `acronym` package with empty options; `acronym[AMIU]` environment, `\acro{Bsp}{Beispiel}`, `\ac{Bsp}` |
| section headings | Main.tex:136, Einfuehrung.tex:1,9, Zielsetzung.tex:1,4,5 | `head.kernel` | default article `\section` `\subsection` `\subsubsection`; `titlesec` is loaded (Main.tex:34) but no `\titleformat` or `\titlespacing` appears in any file |
| section numbering | Main.tex:2 | `num.secnumdepth` | article defaults, not changed |
| list package (loaded, no list in the sample) | Main.tex:30 | `list.enumitem` | load only |
| display maths | Einfuehrung.tex:34,39-42,44-51 | `math.amsmath` | `equation`, `split`, `\frac`, `\dots`, `\cr` as the row break in `split` (:46-47); inline `$..$` |
| maths symbol packages | Main.tex:23,26,27 | `math.amssymb`, `math.amsmath` | `amssymb`, `amsfonts`, `amsmath`, no options |
| figure float | Main.tex:7,35, Einfuehrung.tex:58-63, Anhang.tex:7-12 | `fig.graphicx`, `fig.float` | `figure[H]`, `\centering`, `\includegraphics[width=40mm]` and `[width=\textwidth]`, `\label` |
| wrapped figure | Main.tex:43, Einfuehrung.tex:77-83 | `fig.wrapfig` | `wrapfigure{r}{45mm}`, `\includegraphics[width=30mm]` |
| subfigure setup (no subfigure used) | Main.tex:36-37 | `fig.subcaption` | `\captionsetup[subfigure]{font=normal, labelfont=bf, labelformat=brace, position=top}` |
| table float | Einfuehrung.tex:16-24, Titelseite_Projektarbeit.tex:37-46 | `tbl.tabular`, `fig.float` | `table[H]`, `\centering`, `tabular{ll}`, `\cline{2-2}`, `\multicolumn{1}{l|}` |
| table packages (loaded, not called) | Main.tex:8,9,14,17,38 | `tbl.tabularx`, `tbl.multirow`, `tbl.booktabs`, `tbl.longtable`, `tbl.colortbl` | load only; the sample table uses kernel rules |
| captions | Main.tex:20,39, Einfuehrung.tex:18,61,80, Anhang.tex:10 | `cap.caption` | `caption` package, `justification=centering` (Main.tex:39); `\caption`, `\caption*` for the unnumbered appendix caption |
| landscape and included PDF pages (loaded, not called) | Main.tex:21,40 | `pg.landscape`, `pg.include-pdf` | `pdflscape`, `pdfpages`, load only |
| dummy-text package (loaded, not called) | Main.tex:18 | `draft.todo` | `blindtext`, load only; the sample's filler is typed Lorem ipsum (Einfuehrung.tex:75,85-91) |
| bibliography | Main.tex:162,165, deIEEEtran.bst | `bib.bibtex-bst` | `\bibliographystyle{deIEEEtran}`, `\bibliography{Literaturverzeichnis}`; `\cite{Beispiel}` (Einfuehrung.tex:67); `\refname` overridden (Main.tex:164) and a hand `\addcontentsline` entry (:163) |
| German bibliography support package (loaded; none of its commands called) | Main.tex:29 | `bib.bibtex-bst` | `bibgerm`; considered: `germbib` bundle (ctan.org/pkg/germbib is a CTAN and TeX Live bundle of German BibTeX styles and packages; that it holds `bibgerm.sty` is inferred from its README.bibgerm link, not confirmed) |
| file inclusion | Main.tex:89,96,100,112,133,167, Einfuehrung.tex:6 | `struct.input` | `\include` (title page), `\input` (the rest) |
| appendix | Anhang.tex:1-12, Main.tex:167 | `fig.graphicx`, `font.size-commands` | hand-laid heading, no `\appendix`; a figure holding `\includegraphics[width=\textwidth]{Anhang/Beispielanhang.pdf}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\labelText{text}{label}` with counter `mylabelcounter`: prints `#1`, steps the counter and writes a `\newlabel` line to the aux file whose name field is `#1` | Main.tex:49-57; used once at Anhang.tex:1; consumed once by `\nameref{label:Anhang}` at Einfuehrung.tex:69 | yes (`BESPOKE/preamble`, reducible) | print the heading text as content, put `\phantomsection\label{label:Anhang}` at the target (`xref.kernel`, `xref.hyperref`) and write the reference as `\hyperref[label:Anhang]{Anhang}`, i.e. a cross-reference node with explicit link text. The macro's hard-coded number `{1}` (Main.tex:54) is wrong for `\ref` but no `\ref` or `\autoref` points at this label, so nothing prints it. No conditional or output-routine logic. |
| `deIEEEtran.bst`: IEEEtran.bst v1.13 (Michael Shell, LPPL 1.3 per its header, deIEEEtran.bst:2-4,39-44) with German string constants | deIEEEtran.bst:232-257 (`bbl.and`="und", `bbl.editor`="Hrsg.", `bbl.edition`="Aufl.", `bbl.pages`="S."...), :277-288 (month macros, e.g. `dec`="Dez.") | yes (parameter of `bib.bibtex-bst`) | the lib treats the `.bst` as the parameter of `bib.bibtex-bst`; the edited parts read are strings only. Unread: lines 121-221 and 298-2428, so further edits are not excluded; the emitted `\providecommand` block (deIEEEtran.bst:1081-1118) matches the published style's design. The `.bst` ships with the zip. |
| nothing else: a search of every `.tex` file finds `\newcommand`, `\newcounter` and `\makeatletter` only at Main.tex:49-57; the other `\setlength` and `\renewcommand` lines are kernel length and string settings (Main.tex:5,75,80,119,130,149,155,164) | Main.tex | yes | mapped above to `sp.lengths`, `hf.fancyhdr`, `lang.babel` |

## Content-opaque
none that block. Images used as content: Titelseite_Abschlussarbeit.tex:5 and Titelseite_Projektarbeit.tex:5 (images/UNI_Logo.png), Titelseite_Projektarbeit.tex:10 and Einfuehrung.tex:60,79 (images/Quadrat.png); a PDF page included as a figure at Anhang.tex:9 (Anhang/Beispielanhang.pdf). All referenced assets are present in the zip. Text, the equations (Einfuehrung.tex:39-51), the one table and the one `.bib` entry (Literaturverzeichnis.bib:3-10) are content.

## Lib changes
- New ways proposed: none (considered: `germbib`/`bibgerm`, kept under `bib.bibtex-bst`; `filecontents` at Main.tex:33 is loaded and never used, so it is not a component; `blindtext` kept under `draft.todo`)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
