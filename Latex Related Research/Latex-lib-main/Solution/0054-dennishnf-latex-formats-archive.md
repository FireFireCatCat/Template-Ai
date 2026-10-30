no

# 0054-dennishnf-latex-formats-archive: Dennis Nunez-Fernandez "LaTeX formats archive" (16 samples: report, letter, 11 conference papers, 2 posters, 2 slide decks)

- Unverified: read from the source, not compiled.
- Source: Source/0054-dennishnf-latex-formats-archive/ (origin: https://codeload.github.com/dennishnf/latex-formats-archive/zip/refs/heads/main; licence: GPL-3.0 (README.md:55-57), while individual files keep their own licences, for example LPPL in IEEEtran.cls:55 and CC BY-NC-SA 3.0 in the latextemplates headers at Poster-1-horizontal/conference_poster.tex:12 and Slides-2/presentation.tex:10)
- Kind: report (main sample Report-1-spanish; the archive is mixed: 11 conference-paper folders, 2 posters, 2 slide decks, 1 letter)
- Lib: v1
- Engine: pdfLaTeX-compatible (README.md:8,17 says Texmaker with LaTeX/pdfLaTeX and a pdfTeX output banner; no fontspec, polyglossia or Lua anywhere; the `\pdfpageattr` primitive at Slides-1/slides.tex:62 is pdfTeX-only)
- Look carried by: mixed (Report-1 by `report` class + preamble; letter, IEEE, LNCS, posters, Slides-2 by published classes; BTSym, ICML, NeurIPS and Slides-1 by zip-local class/style files)
- Class origin: zip-local (decided by the zip-local files; main sample `report` is tex-distribution-unbundled; llncs.cls, IEEEtran.cls, baposter.cls, moderncv, beamer are published; svproc.cls, icml2019/2020.sty, neurips_2019/2020.sty, beamerthemeCVC.sty are zip-local)
- Main file: Report-1-spanish/report.tex (other samples: Letter-1/cover-letter.tex; Paper-BTSym-2019/paper.tex; Paper-CIARP-2017/paper.tex, Paper-SIMBig-2019/paper.tex, Paper-SIMBig-2020/paper.tex (same body, only titles differ); Paper-ICML-2019/paper.tex, Paper-ICML-2020/paper.tex; Paper-INTERCON-2018/2019/2020/paper.tex (identical but title); Paper-NeurIPS-2019/paper_neurips.tex, Paper-NeurIPS-2020/paper_neurips.tex; Poster-1-horizontal/conference_poster.tex; Poster-2-vertical/conference_poster.tex; Slides-1/slides.tex; Slides-2/presentation.tex)
- Read: main yes (Report-1-spanish/report.tex, all 266 lines), zip-local classes and styles partly (read in full: icml2019.sty, neurips_2019.sty, beamerthemeCVC.sty; icml2020.sty and neurips_2020.sty by diff against the 2019 files; svproc.cls lines 1-~385 and 806-1240 only, the lists, toc, bibliography and index parts 386-805 not read; llncs.cls, IEEEtran.cls, baposter.cls, pgf-pie.sty, fancyhdr.sty, algorithm.sty, algorithmic.sty and the .bst files read only by header and outline because they are published stock packages; the two NeurIPS sample bodies and the ICML-2020 sample were read by diff against their 2019 twins; lorem-ipsum text lines were skipped as content)

## Verdict
no. The main sample Report-1-spanish would reach yes on its own: it loads only published packages (`report`, `fancyhdr`, `babel`, `hyperref`, `caption`, `float`...) and its preamble hacks reduce to lib ways (needing only the proposed `font.icons` for `eurosym`). But the archive also ships zip-local code that is irreducible: `icml2019.sty`/`icml2020.sty` (rewrites `\@startsection`, `\@makecaption`, the font-size table, a hand-rolled author/affiliation counter system and a vertical-ruler box macro), `neurips_2019.sty`/`neurips_2020.sty` (rewrites `\maketitle`/`\@maketitle` with anonymisation conditionals and a hand-made first-page notice float), `svproc.cls` (a full hand-written class, not on CTAN) and `beamerthemeCVC.sty` (page-number conditional backgrounds, TikZ gradient fallback, PSTricks). Slides-1 also calls the raw `\pdfpageattr` primitive, which no lib way holds. A wrong yes costs more than a wrong no, so the answer for the whole zip is no.
Per-sample reading, so the result can be re-cut: Report-1, Letter-1, Slides-2, Poster-1, Poster-2, CIARP/SIMBig 2017/2019/2020, INTERCON 2018/2019/2020 reach yes (the INTERCON footer hook is borderline, see Bespoke code); BTSym, ICML 2019/2020, NeurIPS 2019/2020, Slides-1 are no.

## Blockers
- `BESPOKE/class` icml2019.sty and icml2020.sty (Paper-ICML-2019/icml2019.sty:559-605 `\@startsection`/`\@sict`/`\@sect` copies; :679-690 `\@makecaption` with box-width test; :665-674 `\@normalsize`/`\@setsize` size table; :413-521 author/affiliation machinery with `\csname`, `\newcounter` per label, `forloop`, anonymisation conditionals; :271-294 `\@copyrightspace` float type 8 built on a `picture`; :339-393 `\icmltitle` measures the running title in a box; :716-775 `\makevruler` ruler box + `\AddToShipoutPicture`; :305 `\def\addcontentsline#1#2#3{}`)
- `BESPOKE/class` neurips_2019.sty and neurips_2020.sty (Paper-NeurIPS-2019/neurips_2019.sty:266-285 `\maketitle` redefined; :302-331 `\@maketitle` with `\if@submission` anonymous block and hand-made `\And`/`\AND` tabular separators; :334-341 `noticebox` float type `\ftype@noticebox`; :84-104 patches amsmath environments for lineno; :135-157 font-size table via `\@setfontsize`; :213-217 `table` environment redefined; :240-262 `\@listi`..`\@listvi` redefined)
- `BESPOKE/class` svproc.cls (Paper-BTSym-2019/svproc.cls:932-1043 `\maketitle` and `\@maketitle` with counters and box-measured running heads; :855-925 `\institute`, `\and`, `\inst` machinery; :815-846 `\@makecaption`, float defaults and `table` redefined; :1045-1150 `\spnewtheorem`; :1213-1234 `\ps@headings`; :61-82 `\@pnumwidth`, `\@tocrmarg` and `\@dottedtocline` toc redefinitions (:64); the class is not on CTAN (404 on ctan.org/pkg/svproc) and the zip is a personal GitHub archive, so it is zip-local by the rubric)
- `BESPOKE/class` beamerthemeCVC.sty (Slides-1/beamerthemeCVC.sty:32-56 background template switching on `\ifnum\thepage>1` and `\ifx\cvc@...\@empty`; :59-84 title page template as an `\ifx...\@empty` chain; :114-126 footline)
- `ART/class` beamerthemeCVC.sty:36-39 and :47-50 TikZ `\shade` gradient fallback background (inside a `pspicture` at :46-51); the sample supplies image files (Slides-1/slides.tex:26-27), so the branch is not reached, but the theme itself defines it
- `UNMAPPED/preamble` raw pdfTeX primitive `\pdfpageattr {/Group << /S /Transparency /I true /CS /DeviceRGB>>}` (Slides-1/slides.tex:62); no lib way holds PDF page attributes
- Note, not counted as a blocker: beamerthemeCVC.sty:8-9 loads `pstricks` and `pst-grad` unconditionally; PSTricks needs the PostScript route (dvips) to draw anything. I did not compile, so I cannot say whether a pdfLaTeX run of Slides-1 loads them cleanly; if it does not, this becomes `EXTERNAL/package`.

## Class setting
- Class: `class.report` options: a4paper,12pt,twoside,openright (Report-1-spanish/report.tex:10). Other classes in the zip: `class.moderncv` (11pt,a4paper,roman; Letter-1/cover-letter.tex:9), `class.llncs` (runningheads; Paper-CIARP-2017/paper.tex:5), `class.ieeetran` (conference; Paper-INTERCON-2018/paper.tex:1), `class.article` (Paper-ICML-2019/paper.tex:3, Paper-NeurIPS-2019/paper_neurips.tex:1), `class.beamer` (Slides-1/slides.tex:1, Slides-2/presentation.tex:18), `class.baposter` (Poster-1-horizontal/conference_poster.tex:21; landscape,a0paper,fontscale=0.285; Poster-2-vertical/conference_poster.tex:21; a1paper,portrait,fontscale=0.410). `svproc` (Paper-BTSym-2019/paper.tex:10) is zip-local, no `class.` way.
- Class-native vocabulary used: report: `\chapter`, `\appendix`, `\leftmark`/`\rightmark`, `\chaptermark`/`\sectionmark`. moderncv: `\moderncvstyle{classic}`, `\moderncvcolor{green}`, `\name`, `\title`, `\address`, `\phone[mobile]`, `\email`, `\recipient`, `\opening`, `\closing`, `\makelettertitle`, `\makeletterclosing`. llncs: `\titlerunning`, `\authorrunning`, `\institute`, `\email`, `\and`, `\keywords` inside `abstract`. IEEEtran: `\IEEEoverridecommandlockouts`, `\IEEEauthorblockN`, `\IEEEauthorblockA`, `IEEEkeywords`, `\ps@IEEEtitlepagestyle`. beamer: `\mode<presentation>`, `\usetheme`, `\frametitle`, `\titlepage`, `block`, `example`, `theorem`, `columns`/`\column`, `[fragile]`. baposter: `poster` environment with keys (headerborder, colspacing, bgColorOne/Two, borderColor, headerColorOne/Two, headerFontColor, boxColorOne, textborder, eyecatcher, headerheight, headershape, headerfont, linewidth, grid, columns, background, boxshade), `\headerbox{title}{name,column,row,span,below,above}`, `\background`.

## Component map
Rows are tagged by sample folder. `font.icons` is proposed below.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| [Report-1] class and paper | Report-1-spanish/report.tex:10 | `class.report`, `page.class-options` | a4paper, 12pt, twoside, openright |
| [Report-1] input encoding | report.tex:12 | `font.fontenc-t1` | inputenc=utf8 |
| [Report-1] language | report.tex:13 | `lang.babel` | spanish |
| [Report-1] float/list names | report.tex:53-54 | `lang.babel` | `\tablename`=Tabla, `\listtablename`=Indice de tablas (renewcommand of name macros) |
| [Report-1] math operator alias | report.tex:55 | `math.kernel` | `\renewcommand{\sin}{sen}` |
| [Report-1] urls and links | report.tex:18,20 | `meta.url`, `meta.hyperref` | colorlinks=true, linkcolor=black, urlcolor=black |
| [Report-1] math packages | report.tex:22,26 | `math.amssymb`, `math.amsmath` | defaults |
| [Report-1] euro symbol | report.tex:23 | `font.icons` | eurosym (`\officialeuro`; loaded, never used in body) |
| [Report-1] verbatim | report.tex:24 | `code.verbatim` | package loaded, unused |
| [Report-1] running heads | report.tex:25,90-97,116-123 | `hf.fancyhdr` | `\fancyhf{}`; head LO=`\leftmark`, RE=`\rightmark`, RO,LE=`\thepage`; chaptermark "N. Name", sectionmark "N.M. Name" |
| [Report-1] page styles | report.tex:63,90,116 | `hf.pagestyle-kernel` | empty (front), fancy |
| [Report-1] page numbers | report.tex:88-89,114-115 | `pgnum.pagenumbering` | roman then arabic; page counter set to 1 and 0 |
| [Report-1] empty blank pages | report.tex:79-84 | `pg.emptypage`, `pg.break` | hand `\cleardoublepage` = emptypage effect |
| [Report-1] page breaks | report.tex:75,110,126,245 | `pg.break` | `\newpage` |
| [Report-1] figures | report.tex:27-29,147-152 | `fig.graphicx`, `fig.float` | `[H]`, `\centering`, `\includegraphics[scale=0.6/0.53/0.61]`, `graphicx`, `float` |
| [Report-1] unused figure/table packages | report.tex:15,16,28,32 | `tbl.tabular`, `fig.rotating`, `pg.include-pdf`, `fig.wrapfig` | loaded only (array, rotating, pdfpages, wrapfig) |
| [Report-1] captions | report.tex:34-36,150 | `cap.caption`, `cap.kernel` | font=small; `\caption`, `\label` |
| [Report-1] title block | report.tex:39-41,58 | `front.maketitle` | title, author, date (report title page) |
| [Report-1] paragraph spacing | report.tex:60 | `sp.lengths` | `\addtolength{\parskip}{\baselineskip}` |
| [Report-1] contents | report.tex:101,255 | `toc.kernel` | `\tableofcontents`, `\addcontentsline{toc}{chapter}{Bibliografia}` |
| [Report-1] headings, appendix | report.tex:138,158,224-225 | `head.kernel`, `num.appendix` | `\chapter` x4, `\appendix` |
| [Report-1] cross references | report.tex:144,151,194 | `xref.kernel` | `\label`, `\ref` |
| [Report-1] lists | report.tex:168-192 | `list.kernel` | itemize nested to depth 3 |
| [Report-1] bibliography | report.tex:165,258,263; references.bib | `bib.bibtex-bst` | style unsrt, references.bib, `\cite` |
| [Letter-1] class | Letter-1/cover-letter.tex:9 | `class.moderncv`, `page.class-options` | 11pt, a4paper, roman |
| [Letter-1] style, colour, sender | cover-letter.tex:14-15,29-35 | `front.class-native` | moderncvstyle=classic, moderncvcolor=green, name, title, address, phone[mobile], email |
| [Letter-1] letter | cover-letter.tex:59-64,81 | `ltr.opening` | recipient, date, opening, closing, `\makelettertitle`, `\makeletterclosing` |
| [Letter-1] language, encoding | cover-letter.tex:10,20 | `lang.babel`, `font.fontenc-t1` | spanish,es-lcroman; utf8 |
| [Letter-1] margins | cover-letter.tex:24 | `page.geometry` | scale=0.75 |
| [Letter-1] justification, gap | cover-letter.tex:47,66,78 | `sp.ragged`, `sp.manual-space` | ragged2e `\justifying`; `\vspace{0.5cm}` |
| [BTSym] class | Paper-BTSym-2019/paper.tex:10 | none (zip-local `svproc`, see Blockers) | no options |
| [BTSym] title block | paper.tex:32-47 | none (svproc-native, inside the blocker) | `\titlerunning`, `\author` with `\orcidID`, `\authorrunning`, `\institute` with `\email`, `\mainmatter` |
| [BTSym] abstract, keywords | paper.tex:51-54 | none (svproc-native) | `abstract` env with `\keywords` |
| [BTSym] urls | paper.tex:16-17 | `meta.url` | `\def\UrlFont{\rmfamily}` |
| [BTSym] figures | paper.tex:76-79,109 | `fig.graphicx`, `fig.subcaption` | `[!htbp]`, `\centerline`, widths 90/100mm; subfig `\subfloat` 57mm |
| [BTSym] loaded only | paper.tex:22-23,26 | `alg.algorithmicx`, `font.fontenc-t1` | algorithm+algpseudocode (no algorithm in body); utf8 |
| [BTSym] bibliography | paper.tex:125-139 | `bib.thebibliography` | width 6, five `\bibitem` |
| [CIARP/SIMBig] class | Paper-CIARP-2017/paper.tex:5 | `class.llncs` | runningheads |
| [CIARP/SIMBig] title block | paper.tex:26-45 | `front.class-native` | `\titlerunning`, `\author`, `\authorrunning`, `\institute`, `\email` |
| [CIARP/SIMBig] abstract, keywords | paper.tex:47-51 | `abs.class-native`, `abs.keywords` | `\keywords{... \and ...}` |
| [CIARP/SIMBig] symbol | paper.tex:14,33 | `font.icons` | ifsym[misc], `\Letter` in the author line |
| [CIARP/SIMBig] floats | paper.tex:74-133 | `fig.graphicx`, `tbl.tabular`, `cap.kernel` | `[!htbp]`, widths 110/72/78/58mm; `tabular{|c|c|c|c|c|c|}`, `\hline`, `\shortstack` |
| [CIARP/SIMBig] loaded only | paper.tex:9-10,12 | `alg.algorithmicx`, `fig.subcaption` | algorithm, algpseudocode, subfig |
| [CIARP/SIMBig] headings, bibliography | paper.tex:57-140,159-171 | `head.class-native`, `bib.thebibliography` | `\section`, `\subsection`; width 8 (BibTeX with splncs04 only in comments, :153-157) |
| [INTERCON] class | Paper-INTERCON-2018/paper.tex:1-2 | `class.ieeetran` | conference; `\IEEEoverridecommandlockouts` |
| [INTERCON] title block | paper.tex:29-37 | `front.class-native` | `\IEEEauthorblockN`, `\IEEEauthorblockA`, `\maketitle` |
| [INTERCON] abstract, keywords | paper.tex:39-45 | `abs.class-native`, `abs.keywords` | `IEEEkeywords` |
| [INTERCON] title-page footer | paper.tex:16-23 | `hf.class-native` | `\ps@IEEEtitlepagestyle` oddfoot = copyright notice, `\footnotesize` |
| [INTERCON] packages | paper.tex:4-8 | `bib.cite-pkg`, `math.amsmath`, `math.amssymb`, `alg.algorithmicx`, `fig.graphicx`, `font.fontenc-t1` | cite; amsmath,amssymb,amsfonts; algorithmic (unused); graphicx; textcomp |
| [INTERCON] floats, list, table | paper.tex:70-111 | `fig.graphicx`, `list.kernel`, `tbl.tabular` | `[htbp]`, widths 78/88mm; itemize; `\multicolumn`, `\cline` |
| [INTERCON] headings, bibliography | paper.tex:51-145 | `head.class-native`, `bib.thebibliography` | width 00 |
| [ICML] class | Paper-ICML-2019/paper.tex:3 | `class.article` | no options |
| [ICML] look | paper.tex:25 | none (zip-local icml2019.sty, see Blockers) | `[accepted]`; the sty sets page, title, headings, captions, abstract, running head |
| [ICML] title and authors | paper.tex:33-80 | none (icml2019.sty-native) | `\twocolumn[...]`, `\icmltitle`, `icmlauthorlist`, `\icmlaffiliation`, `\printAffiliationsAndNotice` |
| [ICML] packages | paper.tex:6-10,16 | `font.fontenc-t1`, `sp.microtype`, `fig.graphicx`, `fig.subcaption`, `tbl.booktabs`, `meta.hyperref` | utf8; microtype; subfigure; booktabs; hyperref |
| [ICML] floats, table | paper.tex:106-127,143-164 | `fig.float`, `fig.graphicx`, `tbl.booktabs`, `font.size-commands` | `[H]` (float comes in through algorithm.sty, not loaded by the sample), `\vskip`, `\toprule`/`\midrule`/`\bottomrule`, `\small`, `sc` |
| [ICML] cross-ref fix | paper.tex:19 | `meta.hyperref` | `\newcommand{\theHalgorithm}` |
| [ICML] bibliography | paper.tex:188-189; icml2019.bst | `bib.bibtex-bst`, `bib.natbib` | style icml2019 (a plainnl modification), natbib loaded by the sty |
| [NeurIPS] class | Paper-NeurIPS-2019/paper_neurips.tex:1 | `class.article` | no options |
| [NeurIPS] look | paper_neurips.tex:15 | none (zip-local neurips_2019.sty, see Blockers) | `[nonatbib, final]` (2019); `[final]` (2020, Paper-NeurIPS-2020/paper_neurips.tex:15) |
| [NeurIPS] title block, abstract | paper_neurips.tex:37-62 | none (sty-native `\maketitle`, `\And`, `\AND`, `abstract`) | author block built from tabulars |
| [NeurIPS] packages | paper_neurips.tex:21-34 | `font.fontenc-t1`, `meta.hyperref`, `meta.url`, `tbl.booktabs`, `math.amssymb`, `math.physics`, `sp.microtype`, `fig.float`, `fig.graphicx`, `fig.subcaption`, `bib.cite-pkg` | utf8,T1; hyperref; url; booktabs; amsfonts; nicefrac (nearest family `math.physics`, the consolidator may widen it); microtype; float; graphicx; subfig; cite |
| [NeurIPS] sty-set typography | neurips_2019.sty:52-53,129-130,201-204,226-227 | `font.family-default`, `sp.penalties`, `sp.lengths` | rmdefault=ptm, sfdefault=phv; widowpenalty=clubpenalty=10000; float fractions; parskip 5.5pt (inside the blocker) |
| [NeurIPS] page | neurips_2019.sty:114-127 | `page.geometry` | letterpaper, textheight=9in, textwidth=5.5in, top=1in, headheight=12pt, headsep=25pt, footskip=30pt (inside the blocker) |
| [NeurIPS] side-by-side figures | paper_neurips.tex:118-129 | `box.minipage`, `cap.kernel` | two `minipage[b]{40mm}` each with `\caption` |
| [NeurIPS] floats, table | paper_neurips.tex:96-154 | `fig.graphicx`, `fig.subcaption`, `tbl.booktabs` | `[H]`, `\subfloat[]`, `\toprule`, `\cmidrule(r){1-2}` |
| [NeurIPS] acknowledgements | paper_neurips.tex:162; 2020 :171-173 | `head.kernel` | 2019 `\subsubsection*`; 2020 `ack` env defined by `environ` in the sty (:60-67 of neurips_2020.sty, inside the blocker) |
| [NeurIPS] bibliography | paper_neurips.tex:173-174 | `bib.bibtex-bst` | style plain |
| [Poster-1] class | Poster-1-horizontal/conference_poster.tex:21 | `class.baposter`, `page.class-options` | landscape, a0paper, fontscale=0.285 |
| [Poster-1] poster look | conference_poster.tex:54-72 | `poster.baposter` | headerborder=closed, colspacing=2em, bgColorOne/Two=white, borderColor=lightblue, headerColorOne=black, headerColorTwo=lightblue, headerFontColor=white, boxColorOne=white, textborder=roundedleft, eyecatcher=true, headerheight=0.2\textheight, headershape=roundedright, headerfont=\Large\bf\textsc, linewidth=2pt |
| [Poster-1] title row, boxes | conference_poster.tex:77-80,86,110,132,195,230,250 | `poster.baposter` | title, authors, two logos; `\headerbox{...}{name,column,row,span,below}` |
| [Poster-1] colour | conference_poster.tex:50 | `color.xcolor` | definecolor lightblue rgb 0.145,0.6666,1 |
| [Poster-1] packages | conference_poster.tex:23-35 | `lang.babel`, `font.fontenc-t1`, `fig.graphicx`, `math.amsmath`, `math.amssymb`, `tbl.booktabs`, `list.enumitem`, `font.palatino`, `cap.caption` | english; utf8; graphicspath figures/; booktabs; enumitem (loaded); palatino; caption font=small,labelfont=bf |
| [Poster-1] columns | conference_poster.tex:37-39,155-187 | `cols.multicol`, `sp.lengths` | `multicols{2}`, columnsep=1.5em, columnseprule=0mm |
| [Poster-1] compact lists | conference_poster.tex:44-48,90 | `list.kernel`, `sp.lengths` | itemize; `\compresslist` = itemsep 1pt, parskip 0pt, parsep 0pt |
| [Poster-1] figure/table captions | conference_poster.tex:98,206-217 | `cap.caption`, `tbl.tabular`, `tbl.booktabs` | `\captionof{figure}`, `\captionof{table}` |
| [Poster-2] class and look | Poster-2-vertical/conference_poster.tex:21,44-58 | `class.baposter`, `poster.baposter` | a1paper, portrait, fontscale=0.410; grid=false, columns=2, headershape=roundedright, headerfont=\Large\sf\bf, textborder=rectangle, background=user, headerborder=open, boxshade=plain |
| [Poster-2] colours | conference_poster.tex:29-33 | `color.xcolor` | definecolor RGB: bordercol 40,40,40; headercol1 186,215,230; headercol2 80,80,80; headerfontcol 0,0,0; boxcolor 186,215,230 |
| [Poster-2] page background | conference_poster.tex:37-42 | `bg.eso-pic` | image figures/background.pdf placed at the page corner (written with a TikZ overlay, but it only places an image); asset ships in figures/ |
| [Poster-2] packages | conference_poster.tex:23-27 | `cap.caption`, `tbl.booktabs`, `font.size-commands` | caption font=small,labelfont=bf; booktabs; relsize `\smaller` |
| [Poster-2] tables | conference_poster.tex:193-244 | `tbl.tabular`, `tbl.booktabs`, `font.size-commands` | `tabular{l l l l l}`, `\footnotesize` |
| [Slides-1] class, theme | Slides-1/slides.tex:1,3,26-27 | `class.beamer`, none for the theme (zip-local beamerthemeCVC.sty, see Blockers) | `\titlebackgroundfile{templates/template_title_blue}`, `\framebackgroundfile{templates/template_frame_blue}`; four PNG backgrounds ship in templates/ |
| [Slides-1] beamer look | slides.tex:28-59 | `slide.beamer-theme`, `slide.beamer-template`, `color.xcolor` | usefonttheme structurebold; setbeamercolor (author/title/section in head/foot, normal text, frametitle, toc, caption name, item/subitem/subsubitem, alerted text); setbeamerfont (block title, author, date, alerted text series=bfseries); itemize items = circle; definecolor vermell=254E68, gris=4C4C4C |
| [Slides-1] raw PDF attribute | slides.tex:62 | none (UNMAPPED) | `\pdfpageattr {/Group << /S /Transparency ... >>}` |
| [Slides-1] title, contents, sections | slides.tex:67-98,106 | `front.class-native`, `toc.kernel` | `\title[short]`, `\author[short]`, `\institute[UNI]`, `\date[...]`; `\frame{\titlepage}`; toc frame; `\section` |
| [Slides-1] packages | slides.tex:2,8-22 | `lang.babel`, `font.fontenc-t1`, `math.amsmath`, `math.amssymb`, `cap.caption`, `fig.subcaption`, `tbl.longtable`, `tbl.multirow`, `art.tikz` | spanish; utf8; caption; subfigure; longtable; multirow; pgf-pie and tikz mindmap,trees loaded, not used; `etex` is a compat shim with no look |
| [Slides-1] frames | slides.tex:110-249 | `list.kernel`, `fig.graphicx` | itemize, figure with `\includegraphics[scale=0.4]` |
| [Slides-2] class, theme | Slides-2/presentation.tex:18-77 | `class.beamer`, `slide.beamer-mode`, `slide.beamer-theme` | `\mode<presentation>{...}`, theme Madrid, other themes commented out |
| [Slides-2] packages | presentation.tex:79-80 | `fig.graphicx`, `tbl.booktabs` | graphicx; booktabs |
| [Slides-2] title, contents | presentation.tex:86-106 | `front.class-native`, `toc.kernel`, `sp.manual-space` | title[short], author, institute[UCLA], `\date{\today}`, `\medskip`; titlepage frame; toc frame |
| [Slides-2] frame content | presentation.tex:118-253 | `class.beamer`, `list.kernel`, `thm.class-native`, `tbl.booktabs`, `cap.kernel`, `code.verbatim`, `bib.thebibliography`, `font.size-commands` | native `block`, `example`, `columns` `\column{.45\textwidth}`; itemize, enumerate; `theorem[...]`; table + caption; `[fragile]` verbatim and `\verb`; thebibliography in a frame; `\footnotesize`, `\Huge` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\cleardoublepage` redefinition | Report-1-spanish/report.tex:79-84 | yes | the standard idiom for blank pages without header: `pg.emptypage` (+ `pg.break`) |
| caption3 + no-op `\DeclareCaptionOption{parskip}[]{}` | report.tex:34-35 | yes | drop; `cap.caption` font=small does the work (:36) |
| `\renewcommand` of `\tablename`, `\listtablename`, `\sin` | report.tex:53-55 | yes | name overrides under `lang.babel`; `\sin` alias under `math.kernel` |
| `\chaptermark`, `\sectionmark` formats | report.tex:96-97,122-123 | yes | `hf.fancyhdr` marks "N. Name" / "N.M. Name" |
| `\ps@IEEEtitlepagestyle`, `\mycopyrightnotice` | Paper-INTERCON-2018/paper.tex:15-23 | yes (borderline) | the class's own title-page footer hook (`hf.class-native`): oddfoot = footnotesize copyright text with `\hfill`; the text is content; it assigns `\@oddfoot`/`\@evenfoot` directly, which no lib way spells out, so an emitter needs one raw hook line |
| `\def\BibTeX` logo macro | Paper-INTERCON-2018/paper.tex:9-10 | yes | defined, never called in the body (no `\BibTeX` elsewhere); drop |
| `\compresslist` | Poster-1-horizontal/conference_poster.tex:44-48 | yes | `sp.lengths` itemsep=1pt, parskip=0pt, parsep=0pt after `\begin{itemize}` |
| `\background{tikzpicture ...\includegraphics}` | Poster-2-vertical/conference_poster.tex:37-42 | yes | baposter `background=user` + `bg.eso-pic` with the shipped image |
| `\def\UrlFont{\rmfamily}` | Paper-BTSym-2019/paper.tex:17 | yes | `meta.url` documented font hook |
| `\newcommand{\theHalgorithm}` | Paper-ICML-2019/paper.tex:19 | yes | a hyperref anchor alias, `meta.hyperref` |
| `icml2019.bst` / `icml2020.bst` | Paper-ICML-2019/icml2019.bst:1-15 | yes | `bib.bibtex-bst`, the `.bst` file is the parameter (a plainnl modification; body not read) |
| local `algorithm.sty`, `algorithmic.sty`, `fancyhdr.sty` v3.2 | Paper-ICML-2019/ | partly | stock CTAN packages (`alg.algorithmicx`, `hf.fancyhdr`); `algorithmic.sty` carries a local patch (:46-58,151-156, not read in detail); no algorithm is called in the sample body |
| icml2019.sty / icml2020.sty | Paper-ICML-2019/icml2019.sty | no | irreducible: see `BESPOKE/class` (kernel internals redefined, counters per affiliation label, ruler box) |
| neurips_2019.sty / neurips_2020.sty | Paper-NeurIPS-2019/neurips_2019.sty | no | irreducible: see `BESPOKE/class`. Parts reduce (geometry, penalties, ptm/phv, parskip, list lengths), but `\@maketitle` with anonymisation, the notice float and the lineno/amsmath patch do not |
| svproc.cls | Paper-BTSym-2019/svproc.cls | no | irreducible: see `BESPOKE/class` |
| beamerthemeCVC.sty | Slides-1/beamerthemeCVC.sty | no | irreducible: see `BESPOKE/class` and `ART/class` |
| `\pdfpageattr` | Slides-1/slides.tex:62 | no | no lib way for raw PDF page attributes |
| llncs.cls v2.20, IEEEtran.cls v1.8b, baposter.cls v2.0, pgf-pie.sty v0.2 | Paper-CIARP-2017/llncs.cls:1-22; Paper-INTERCON-2018/IEEEtran.cls:1-30; Poster-1-horizontal/baposter.cls:110; Slides-1/pgf-pie.sty:9-10 | n/a (published) | IEEEtran's header cites ctan.org/pkg/ieeetran, baposter and pgf-pie are CTAN packages by name; `llncs` on CTAN is from my background knowledge, not re-checked (the three CTAN reads were spent on svproc, neurips and icml, all 404). Not diffed against upstream, so local edits cannot be excluded |

## Content-opaque
- TikZ libraries `shapes,arrows` loaded "for a flow chart" that is never drawn (Poster-1-horizontal/conference_poster.tex:41-42).
- `pgf-pie` and TikZ `mindmap,trees` loaded, no pie or mind map in the body (Slides-1/slides.tex:19-21).
- `algorithm`/`algorithmic`/`algpseudocode` loaded, no algorithm in any body (Paper-BTSym-2019/paper.tex:22-23, Paper-CIARP-2017/paper.tex:9-10, Paper-INTERCON-2018/paper.tex:6).
- Example images (images/, figures/, templates/) are content, except Poster-2 `figures/background.pdf` and Slides-1 `templates/*.png`, which are page backgrounds and ship with the template.

## Lib changes
- New ways proposed: `font.icons` `eurosym`, `ifsym`, `marvosym`, `wasysym`, `pifont` (symbol-glyph font packages), pdf. W1: all on CTAN (eurosym, ifsym). W2: package options (`official`, `[misc]` set) choose the glyph set. W3: serves any document needing pictograms or currency glyphs. W4: `\usepackage` line plus an inline glyph command (`\officialeuro`, `\Letter`). Used here at Report-1-spanish/report.tex:23 (`eurosym`, unused) and Paper-CIARP-2017/paper.tex:14,33 (`ifsym` `\Letter` in the author line). The nearest existing id, `font.icons`, is described as `fontawesome5`/`fontawesome` only; the consolidator may instead widen `font.icons` to include symbol-font packages.
- Note for the consolidator: `nicefrac` (Paper-NeurIPS-2019/paper_neurips.tex:27, `\nicefrac{1}{2}` in the abstract text) was mapped to `math.physics` as the nearest helper-package family; no new way proposed.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
