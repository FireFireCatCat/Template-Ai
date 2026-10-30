no

# 0512-formation-latex-ul: Rédaction avec LaTeX (Université Laval course: manual, slides, exercise files)

- Unverified: read from the source, not compiled.
- Source: Source/0512-formation-latex-ul/ (origin: https://mirrors.ctan.org/info/formation-latex-ul.zip; licence: cc-by-4 in the manifest, README.md:10 says CC BY-SA 4.0)
- Kind: book
- Lib: v5
- Engine: needs XeLaTeX (manual: source/formation-latex-ul.tex:49-50 `fontspec`, `unicode-math`, :55 Lucida Bright OT, non-free per README.md:46-47; slides: source/formation-latex-ul-diapos.tex:16 `unicode-math`, :43 `metropolis`, :47 Fira Sans). The doc/exercice-*.tex files switch on `\iftutex` and keep a pdfLaTeX branch (doc/exercice-demo.tex:35-39).
- Look carried by: preamble (published memoir and beamer, no zip-local class or style; each document sets its look in its own preamble)
- Class origin: tex-distribution-unbundled
- Main file: doc/exercice-demo.tex (manifest main; other samples: source/formation-latex-ul.tex (the reference manual), source/formation-latex-ul-diapos.tex (the slides), doc/exercice-complet.tex, doc/exercice-gabarit.tex, doc/exercice-subcaption.tex, doc/exercice-trucs.tex and the other doc/exercice-*.tex)
- Read: main yes (doc/exercice-demo.tex whole; the manual main source/formation-latex-ul.tex whole; the slides main whole; couverture-avant.tex, couverture-arriere.tex, solutions.tex, ulthese.tex whole; doc/exercice-trucs, -complet, -gabarit, -subcaption whole), manual and slide chapter files partly (Grep only), zip-local classes and styles none present

## Verdict
no. The manifest main sample, doc/exercice-demo.tex, reduces to memoir plus published packages and a few aliases (every item is in the tables below). The answer is still no because the package's own primary documents, the reference manual and the slides (README.md:30-36), are in the zip and rest on four pieces of irreducible zip-local preamble code: the box-and-glue `texample`/`eqxample` environments (149 uses in 9 files), a patch of `answers` internals, hand-rolled `exercice`/`solution` environments driven by a counter and written files, and a forked `bibentry`. If only the manifest main sample were counted the answer would be yes. I counted the manual and slides as samples because the README names them as the package.

## Blockers
- `BESPOKE/preamble` `texample` and `eqxample` environments: `\def\producing` ends one minipage and opens another through `\hbox\bgroup ... \vbox\bgroup`, with `\dimexpr`, kerns and display-skip assignments; 149 `\begin{texample|eqxample}` in source/ (source/formation-latex-ul.tex:266-301; source/formation-latex-ul-diapos.tex:165-200)
- `BESPOKE/preamble` `\Writetofile` of the `answers` package redefined with `\@bsphack`, `\protected@iwrite`, `\afterassignment`, `\Iffileundefined` (source/formation-latex-ul.tex:241-259)
- `BESPOKE/preamble` `exercice` environment and `solution` environment: counter `exercice` numbered `\thechapter.\arabic{exercice}`, `\ifthenelse` on the optional argument, `\hypertarget` and `\Writetofile` calls that decide what the solutions chapter prints; 40 uses in 15 files (source/formation-latex-ul.tex:208-237)
- `BESPOKE/preamble` fork of the `bibentry` package: `\newif`, `\csname`, `\gdef`, a redefined `thebibliography`, `\AtBeginDocument` rewiring `\bibliography`; the author says the published package clashes with francais.bst (source/formation-latex-ul.tex:429-471)

## Class setting
- Class: `class.memoir` options: letterpaper, 11pt, english, french (doc/exercice-demo.tex:1); manual adds x11names (source/formation-latex-ul.tex:12); exercise files use 11pt, article, french (doc/exercice-complet.tex:1). Slides: `class.beamer` options aspectratio=169, 10pt, xcolor=x11names, french (source/formation-latex-ul-diapos.tex:12). Small exercises use `class.article` (doc/exercice-trucs.tex:1).
- Class-native vocabulary used: memoir `\frontmatter` `\mainmatter` `\chapter` `titlingpage` `\maxsecnumdepth` `\setsecnumdepth` `\newsubfloat` `\subcaption` `\toprule` `\midrule` `\bottomrule` (rules built into memoir, booktabs not loaded), `\chapterstyle{hangnum}` `\chaptitlefont` `\setsecheadstyle` `\setsubsecheadstyle` `\cft...leader` `\cleartorecto` `\cleartoverso` `\headwidth` `\preindexhook` `\pagestyle{companion}`; beamer `\usetheme{metropolis}` `\metroset` `beamercolorbox` `frame[fragile=singleslide]` `\frametitle`. memoir source not read (class not bundled).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (demo) | doc/exercice-demo.tex:1 | `class.memoir` | letterpaper, 11pt, english, french |
| page size (demo) | doc/exercice-demo.tex:1 | `page.class-options` | letterpaper, 11pt; no geometry call, memoir default layout |
| language (demo) | doc/exercice-demo.tex:3, 69-73, 608 | `lang.babel` | `\frenchbsetup{CompactItemize=false, ThinSpaceInFrenchNumbers=true, og=«, fg=»}`; `\ieme` |
| fonts, XeLaTeX branch (demo) | doc/exercice-demo.tex:17-34 | `font.fontspec`, `font.unicode-math` | `\setmainfont{STIXTwoText}` Extension=.otf, UprightFont=*-Regular, BoldFont=*-SemiBold, ItalicFont=*-Italic, BoldItalicFont=*-SemiBoldItalic, Scale=1, Ligatures=TeX; `\setmathfont{STIXTwoMath-Regular}` Extension=.otf, Scale=1, Ligatures=TeX |
| fonts, pdfLaTeX branch (demo) | doc/exercice-demo.tex:36-38 | `font.fontenc-t1`, `font.serif-pkg` | `inputenc` utf8, `fontenc` T1, `stix2` (text and maths bundle; source not read) |
| microtype (demo) | doc/exercice-demo.tex:4 | `sp.microtype` | babel=true |
| decimal comma (demo) | doc/exercice-demo.tex:40 | `math.icomma` | load-only, after the fonts |
| numbers (demo) | doc/exercice-demo.tex:5, 261 | `mark.siunitx` | `numprint` autolanguage; `\nombre{...}` |
| colours (demo) | doc/exercice-demo.tex:43-48 | `color.xcolor` | comments rgb 0.7,0,0; shadecolor gray 0; link 0,0.4,0.6; url 0.6,0,0; citation 0,0.5,0 (comments and shadecolor are never used in the file, Grep) |
| hyperlinks (demo) | doc/exercice-demo.tex:51-62, 145-147 | `meta.hyperref` | colorlinks, linktocpage, urlcolor=url, linkcolor=link, citecolor=citation, bookmarksopen, bookmarksnumbered, bookmarksdepth=subsubsection, pdfauthor; `\href`, `\url` |
| autoref names (demo) | doc/exercice-demo.tex:63-67, 166 | `xref.hyperref` | figure, tableau, subtable=tableau, exemple, algorithme |
| labels and refs (demo) | doc/exercice-demo.tex:124, 430, 848 | `xref.kernel` | `\label`, `\ref`, `\eqref`, `\pageref` |
| math (demo) | doc/exercice-demo.tex:6, 206-209, 247-256, 891-897 | `math.amsmath`, `math.amssymb` | equation, equation*, align*, gather* with `\intertext`, displaymath (:218), `\mathbb` (:913) |
| theorem-like (demo) | doc/exercice-demo.tex:76-87, 240 | `thm.amsthm` | plain: algorithme, thm; definition: exemple, definition, astuce*; remark: remarque*; counters within chapter; `\qed` |
| R code blocks (demo) | doc/exercice-demo.tex:90-93, 947-970 | `code.verbatim` | fancyvrb `\DefineVerbatimEnvironment{Sinput}{Verbatim}{fontshape=sl}`, Soutput `{}`, Scode `{fontshape=sl}` |
| highlight (demo) | doc/exercice-demo.tex:8, 489 | `mark.ulem` | `soul`, `\texthl{...}` (not defined in doc/, Grep; soul source not read) |
| section numbering (demo) | doc/exercice-demo.tex:101 | `num.secnumdepth` | `\maxsecnumdepth{subsection}` |
| front and main matter (demo) | doc/exercice-demo.tex:111, 121 | `class.memoir` | `\frontmatter`, `\mainmatter` |
| title page (demo) | doc/exercice-demo.tex:11-12, 113-115 | `front.maketitle`, `front.class-native` | `\title`, `\author`; `\maketitle` inside memoir `titlingpage` |
| page breaks (demo) | doc/exercice-demo.tex:116, 119 | `pg.break` | `\cleardoublepage` |
| contents (demo) | doc/exercice-demo.tex:118 | `toc.kernel` | `\tableofcontents` |
| headings (demo) | doc/exercice-demo.tex:123, 126, 197 | `head.kernel` | `\chapter` `\section` `\subsection`, memoir defaults, no chapterstyle or titleformat call |
| running heads (demo) | none set in the file | `hf.class-native` | memoir default page style; no `\pagestyle` in the sample |
| lists (demo) | doc/exercice-demo.tex:154-159, 320-344, 694-707 | `list.kernel` | itemize, enumerate nested to two levels, description with `\item[label]` |
| centred blocks (demo) | doc/exercice-demo.tex:140-143, 581 | `sp.ragged` | `center`, `\centering` |
| footnotes (demo) | doc/exercice-demo.tex:146-148, 738-743 | `fn.kernel` | `\footnote` |
| tables (demo) | doc/exercice-demo.tex:360-394, 485, 582, 1004 | `tbl.tabular` | table float; `tabular*` with `@{\extracolsep{\fill}}`; `>{$}c<{$}`; `r@{,}l`; `\multicolumn` (:368) |
| table rules (demo) | doc/exercice-demo.tex:367, 369, 375 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule`; booktabs is not loaded, memoir supplies them |
| aligned decimals (demo) | doc/exercice-demo.tex:501 | `tbl.siunitx` | `D{.}{,}{1.3}` column (dcolumn); no `dcolumn` load in the file (Grep over doc/), the emitter loads it |
| captions (demo) | doc/exercice-demo.tex:104, 361, 364 | `cap.kernel`, `cap.memoir` | `\caption`; memoir `\newsubfloat{table}` and `\subcaption` |
| side-by-side boxes (demo) | doc/exercice-demo.tex:363, 379 | `box.minipage` | `[t]`, width 0.45\linewidth, `\hfill` |
| framed symbols (demo) | doc/exercice-demo.tex:97, 630, 756 | `box.fancybox` | `\fbox` |
| manual spacing (demo) | doc/exercice-demo.tex:97, 756-760 | `sp.manual-space` | `\hspace{2pt}`, `\hspace{17.5pt}` |
| figure float (demo) | doc/exercice-demo.tex:752-766 | `fig.graphicx` | figure float only, no `\includegraphics`; the body is display maths with `\underbrace` and `\fbox` |
| inline marks (demo) | doc/exercice-demo.tex:96, 157 | `mark.kernel` | `\texttt`, `\emph` |
| citations (demo) | doc/exercice-demo.tex:2, 139, 726-727 | `bib.natbib` | default options; `\cite`, `\citep[][note]{a,b}` |
| bibliography (demo) | doc/exercice-demo.tex:107, 1352 | `bib.bibtex-bst` | `\bibliographystyle{francais}` (francais-bst, on CTAN and TeX Live per its CTAN page; the .bst is not in the zip), `\bibliography{exercices}` (doc/exercices.bib) |
| class and engine (manual) | source/formation-latex-ul.tex:12, 49-50 | `class.memoir`, `font.fontspec` | letterpaper, 11pt, x11names, english, french |
| margins (manual) | source/formation-latex-ul.tex:151-156 | `page.setlength` | marginparsep 7mm, marginparwidth 20mm then +15mm, headwidth = textwidth + marginparsep + marginparwidth |
| fonts (manual) | source/formation-latex-ul.tex:51-89 | `font.fontspec`, `font.unicode-math` | `\defaultfontfeatures{Scale=0.92}`; main Lucida Bright OT (Ligatures=TeX, Numbers=OldStyle); math Lucida Bright Math OT; mono Lucida Grande Mono DK; sans FiraSans (Extension=.otf, UprightFont=*-Book, Scale=0.95, Numbers=OldStyle); `\newfontfamily` for `\fullcaps` and seven comparison faces |
| typography (manual) | source/formation-latex-ul.tex:79-80 | `sp.microtype`, `math.icomma` | babel=true |
| colours (manual) | source/formation-latex-ul.tex:92-99 | `color.xcolor` | comments, link, url, citation, ULlinkcolor, rouge 0.90,0,0.1, or 1,0.8,0 |
| links and bookmarks (manual) | source/formation-latex-ul.tex:102-120 | `meta.hyperref`, `meta.bookmark` | colorlinks, linktocpage, pdfpagemode=UseOutlines, pdfstartview=Fit, `\XeTeXLinkMargin` 1pt; bookmarksetup open=true, depth=3, numbered=true |
| autoref names (manual) | source/formation-latex-ul.tex:126-133 | `xref.hyperref`, `lang.babel` | `\addto\extrasfrench` setting section, figure, tableau, exemple, exercice, annexe |
| contents leaders (manual) | source/formation-latex-ul.tex:136-144 | `toc.tocloft` | memoir `\cftchapterleader` etc.: leader `\hspace{1.5em}`, `\cftfigurenumwidth` 3.2em |
| chapter and section style (manual) | source/formation-latex-ul.tex:147-148, 159-162 | `head.memoir-style`, `num.secnumdepth` | `\chapterstyle{hangnum}`, `\chaptitlefont`, `\setsecheadstyle`, `\setsubsecheadstyle` (Large and large sffamily bfseries), `\maxsecnumdepth`, `\setsecnumdepth` = subsection |
| lists (manual) | source/formation-latex-ul.tex:17, 165-168 | `list.enumitem` | shortlabels; `\setlist` leftmargin=*, align, label=\alph*) and \roman*) |
| babel (manual) | source/formation-latex-ul.tex:171-180 | `lang.babel` | StandardItemizeEnv=true, ThinSpaceInFrenchNumbers=true, ItemLabeli=\mantriangleright, og/fg; `\figurename` Fig., `\tablename` Tab. |
| source listings (manual) | source/formation-latex-ul.tex:28, 183-197, 324-344 | `code.listings` | language [LaTeX]TeX, basicstyle \ttfamily, backgroundcolor LightYellow1, frame=leftline, framerule 2pt, framesep 5pt, xleftmargin 7.4pt, index classes |
| index (manual) | source/formation-latex-ul.tex:318-348, 544 | `idx.makeidx` | memoir `\makeindex`, `\printindex`, `\preindexhook` |
| bibliography (manual) | source/formation-latex-ul.tex:13, 487, 541 | `bib.natbib`, `bib.bibtex-bst` | francais, formation-latex-ul.bib |
| theorem (manual) | source/formation-latex-ul.tex:204-205 | `thm.amsthm` | definition style, exemple within chapter |
| exercise collection (manual) | source/formation-latex-ul.tex:27, 208 | `exam.questions` | `\Newassociation{sol}{solution}{solutions}`; `\Opensolutionfile{solutions}[file]` and `\Closesolutionfile` per chapter (source/bases.tex:1154, 1221) |
| icons and logos (manual) | source/formation-latex-ul.tex:19, 21-24, 26 | `font.icons`, `font.size-commands` | fontawesome5, manfnt, metalogo, mflogo, applekeys as symbol-glyph packages (sources not read); relsize `\smaller` |
| info boxes (manual) | source/formation-latex-ul.tex:25, 390-391 | `box.awesomebox` | `\awesomebox{\aweboxrulewidth}{\faYoutube}{url}{...}` |
| covers (manual) | source/couverture-avant.tex:39-123; source/couverture-arriere.tex:12-27 | `pg.textpos`, `sp.rule`, `fig.graphicx`, `color.xcolor` | `\TPGrid{8}{64}`, `textblock*` positions, red and gold `\rule` bands (:78-79), two `\includegraphics` heights, `\fontsize` title |
| page styles (manual) | source/formation-latex-ul.tex:504, 513 | `hf.pagestyle-kernel`, `hf.class-native` | `empty`; memoir `companion` |
| document structure (manual) | source/formation-latex-ul.tex:501-556 | `class.memoir`, `struct.input`, `pg.break`, `num.appendix`, `toc.kernel` | `\frontmatter` `\mainmatter`, `\include`, `\input`, `\null\cleardoublepage`, `\cleartorecto`, `\appendix`, contents, lists of tables and figures |
| class and theme (slides) | source/formation-latex-ul-diapos.tex:12, 43-44 | `class.beamer`, `slide.beamer-theme` | aspectratio=169, 10pt, xcolor=x11names, french; `\usetheme{metropolis}`, `\metroset{subsectionpage=progressbar}` |
| fonts (slides) | source/formation-latex-ul-diapos.tex:16, 47-99 | `font.fontspec`, `font.unicode-math` | `\setsansfont{Fira Sans Book}`, `\setmathfont{Fira Math}`, `mathrm=sym`, `\newfontfamily` for title faces, Lucida, CM, STIX Two |
| boxes and frames (slides) | source/formation-latex-ul-diapos.tex:162-164, 203-210 | `slide.beamer-template` | `beamercolorbox` wd=\linewidth sep=6pt `{block body example}`; `frame[fragile=singleslide]` with `\frametitle` |
| other packages (slides) | source/formation-latex-ul-diapos.tex:17-24, 128-132, 138-153 | `page.adjustwidth`, `tbl.tabularx`, `tbl.booktabs`, `font.icons`, `box.awesomebox`, `code.listings`, `fig.adjustbox`, `pg.textpos`, `meta.bookmark` | changepage, tabularx, booktabs, fontawesome5, awesomebox, listings, adjustbox[export], textpos[overlay,absolute], bookmark; usage in the slide chapters not read |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\iftutex ... \else ... \fi` engine switch | doc/exercice-demo.tex:16-39 | yes | published `iftex`; the emitter prints one branch (XeLaTeX: `font.fontspec`, `font.unicode-math`; pdfLaTeX: `font.fontenc-t1`, `font.serif-pkg`) |
| `rem` environment | doc/exercice-demo.tex:87 | yes | `thm.amsthm` remark-style `remarque*` plus `\mbox{}` (`sp.manual-space`) as first item |
| `Schunk` environment | doc/exercice-demo.tex:93 | yes | empty wrapper, dropped |
| `\code`, `\fl` | doc/exercice-demo.tex:96, 98 | yes | `mark.kernel` `\texttt`; `\mathrm{fl}` in `math.amsmath` |
| `\ieee` | doc/exercice-demo.tex:97 | yes | three `\fbox{$..$}` (`box.fancybox`) with `\hspace{2pt}` (`sp.manual-space`) |
| autoref name macros | doc/exercice-demo.tex:63-67 | yes | `xref.hyperref` name strings |
| `texample`, `eqxample` | source/formation-latex-ul.tex:266-301; source/formation-latex-ul-diapos.tex:165-200 | no | box-and-glue (`\hbox\bgroup`, `\vbox\bgroup`, kerns, display skips) around a `\producing` split inside the environment |
| `\Writetofile` redefinition | source/formation-latex-ul.tex:241-259 | no | patch of a published package's internals (`\protected@iwrite`) |
| `exercice`, `solution`, counter `exercice` | source/formation-latex-ul.tex:208-237 | no | counter, `\ifthenelse`, hyperlink targets and file writes decide what is printed; only the `answers` calls themselves map to `exam.questions` |
| `bibentry` fork | source/formation-latex-ul.tex:437-471 | no | rewrites `thebibliography` and `\bibitem` and `\bibliography`; the published `bibentry` is the author's stated starting point (:429-436) but conflicts with francais.bst |
| `\input{francaisbst.tex}`, `\let\enquote\frquote` | source/formation-latex-ul.tex:476, 480 | partly | alias reduces; francaisbst.tex belongs to francais-bst and is not in the zip |
| `\cmdprint`, `\cmd`, `\pixbsbs`, `\pixabang`, `\pixbar` | source/formation-latex-ul.tex:379-386 | yes, not relied on | index sort keys built with `\expandafter\@gobble\string`; an emitter can write `\index{key@\cs{name}}` with the key precomputed (`idx.makeidx`) |
| `demo`, `bibexample`, `vglisting` | source/formation-latex-ul.tex:263-265, 307, 310-313 | yes | `trivlist` and `minipage` wrappers (`list.kernel`, `box.minipage`); `\lstnewenvironment` of `code.listings` |
| `\doc`, `\link`, `\videobox`, `\ccbysa`, `\viewsource`, `\nolink`, `\BibTeX`, `\code`, `\fichier`, `\class`, `\pkg`, `\mat`, `\lspx` | source/formation-latex-ul.tex:355-423 | yes | aliases over `meta.hyperref`, `note.marginpar`, `font.icons`, `mark.kernel`, `box.awesomebox`, `sp.manual-space` |
| `\newlength` set for covers | source/formation-latex-ul.tex:491-495 | yes | `sp.lengths` values passed to `pg.textpos` blocks |
| `\Newassociation` in the zip | source/formation-latex-ul.tex:208 | yes | one declaration of `exam.questions` |

## Content-opaque
- `picture` environment drawing used as a teaching figure (source/tableaux+figures.tex:408-448), a listing of its code follows (:452).
- `\dirtree{...}` directory tree in an exercise (source/organisation.tex:874).
- R console blocks in `Sinput`/`Soutput` (doc/exercice-demo.tex:947-970) and display-maths diagram with `\underbrace` and `\fbox` in a figure (doc/exercice-demo.tex:752-766).
- Missing assets, not blockers: Lucida Bright OT, Lucida Bright Math OT and Lucida Grande Mono DK (non-free, README.md:46-47), `francaisbst.tex`; `solutions-*.tex` are written by the first compile through `\Opensolutionfile`, not by an outside tool.

## Lib changes
- New ways proposed: `exam.questions` `answers` (CTAN, TeX Live, LPPL 1.3c, Joseph Wright; the CTAN page titles it "Setting questions (or exercises) and answers" and names no commands, the commands below come from the sample), pdfLaTeX: `\usepackage{answers}`, preamble `\Newassociation{sol}{solution}{ext}`, body `\Opensolutionfile{ext}[file]` ... `\Closesolutionfile{ext}` around a chapter's exercises and a `sol` environment per solution; W1 CTAN package; W2 environment, extension and file names are strings; W3 serves any exercise sheet or textbook; W4 preamble line plus body wrappers. The `\Writetofile` patch and the `exercice` environment of this zip stay outside the way (BESPOKE above).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
