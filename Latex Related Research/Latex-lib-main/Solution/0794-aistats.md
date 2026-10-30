yes

# 0794-aistats: AISTATS 2026 paper pack (aistats2026.sty over article)

- Unverified: read from the source, not compiled.
- Source: Source/0794-aistats/ (origin: https://aistats.org/aistats2026/AISTATS2026PaperPack.zip; licence: not established; the bundled fancyhdr.sty carries an LPPL clause at fancyhdr.sty:8-12)
- Kind: conference (the manifest hint says journal; the sample is the AISTATS 2026 submission instructions, sample_paper.tex:53)
- Lib: v6
- Engine: pdfLaTeX-compatible (no fontspec, no unicode-math, no Lua; the only packages are amsmath and fancyhdr, aistats2026.sty:63, 149)
- Look carried by: class (the conference's official house style `aistats2026.sty`, loaded over kernel `article`, defines the whole look; the sample preamble adds nothing but the `\usepackage` line, sample_paper.tex:3)
- Class origin: publisher-official (the zip is the AISTATS organisers' own paper pack, from their site per the manifest; no CTAN page was read; `fancyhdr.sty` v3.2 inside it is the CTAN package, fancyhdr.sty:1)
- Main file: sample_paper.tex (other samples: supplement.tex, the same style in one-column mode)
- Read: main yes, zip-local classes and styles all (aistats2026.sty 1-500, fancyhdr.sty 1-485, supplement.tex 1-73; the two .pdf files are rendered output and were not read)

## Verdict
Yes. The look is carried by the organisers' official house style, which is published under the rubric's official-kit ruling (W1), and the sample adds only content and one `\usepackage` line. Read as unpublished code, the style still reduces: it is parametric `\@startsection`, list, footnote and size settings, a `fancyhdr` set-up, one custom bottom float with a rule and a `\parbox`, and author/address rows made of centred boxes and glue, all expressible with lib ways (reductions below). There is no `ART` and no tool outside TeX. The weakest points are the copyright-notice float (kernel float internals plus a `picture` that holds only one rule and one box) and the old-style `\@setsize` size table; both reduce, but the kernel behaviour behind them was not verified.

## Blockers
none

## Class setting
- Class: `class.article` options: `twoside` (sample_paper.tex:1; supplement.tex:1); paper size is the class default, the style sets none (the `\special{papersize}` lines are commented, sample_paper.tex:22-25)
- House style (package, official kit): `aistats2026` options `accepted` (aistats2026.sty:71-73) and `preprint` (aistats2026.sty:85-89); none passed in the sample (sample_paper.tex:3; the option lines at 7 and 16 are comments)
- Class-native vocabulary used: article's `\section` to `\paragraph`, starred forms, `abstract`, `thebibliography` with `\bibitem` and `\newblock`, `\appendix`, `\twocolumn[...]`, `\onecolumn`, `figure` and `table` with `\caption`, `\footnote`, `enumerate`; house style's `\aistatstitle`, `\aistatsauthor`, `\aistatsaddress`, `\And` (sample_paper.tex:51-57, 372-373); defined but unused in the sample: `\AND`, `\ANDD`, `\runningtitle`, `\runningauthor` (aistats2026.sty:163-164, 311-317), `\acknowledgments` (aistats2026.sty:66-73)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class, sides | sample_paper.tex:1 | `class.article` | twoside |
| paper size | sample_paper.tex:22-25 (commented); aistats2026.sty (no size set) | `page.class-options` | class default (US Letter per sample_paper.tex:76 prose); twoside |
| page geometry | aistats2026.sty:93-98, 138 | `page.setlength` | evensidemargin=oddsidemargin=-0.125in, topmargin=-25pt, textheight=9.25in, textwidth=6.75in, columnsep=0.25in, headheight=10pt, headsep=15pt, footskip=0pt |
| columns | aistats2026.sty:140; sample_paper.tex:51, 371 | `cols.twocolumn-cmd` | `\twocolumn` in the style, `\twocolumn[title block]` in the body, `\onecolumn` for the appendix and for supplement.tex:43 |
| page flow | aistats2026.sty:140; sample_paper.tex:366 | `pg.flush` and `pg.break` | `\flushbottom`; `\clearpage` before the appendix |
| hyphenation | aistats2026.sty:140, 493 | `sp.hyphenat` | `\sloppy` |
| header/footer | aistats2026.sty:149, 156-160, 393 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhead{}`, `\fancyfoot{}`, `\headrulewidth`=0.5pt (the later line wins over 0pt at 157), foot empty |
| running head fields | aistats2026.sty:226, 300, 176, 249 | `hf.fancyhdr` | `\fancyhead[CE]{\small\bfseries title}`, `\fancyhead[CO]{\small\bfseries authors}`; in review mode both read "Manuscript under review by AISTATS 2026" |
| page styles | aistats2026.sty:139; sample_paper.tex:368 | `hf.pagestyle-kernel` | `\thispagestyle{empty}`, `\pagestyle{empty}`; `\thispagestyle{empty}` on the first appendix page |
| title block | aistats2026.sty:166-239; sample_paper.tex:53, 372-373 | `front.class-native` | `\aistatstitle{...}` inside `\twocolumn[...]`; `\Large\bfseries` centred title between two rules; `\\` allowed in the title |
| title rules and gaps | aistats2026.sty:473-480, 234-238 | `sp.rule` | top bar `\hrule height4pt`, bottom bar `\hrule height1pt`; gaps `\vskip .25in`; after the block `\vskip 0.25in plus 1fil minus 0.125in` (two columns) or `\vskip 0.5em` (one column) |
| spacing in the block | aistats2026.sty:235, 237, 311, 368 | `sp.manual-space` | the `\vskip` values above; `\vskip 0.3in plus 2fil minus 0.1in` after the addresses |
| author and address rows | aistats2026.sty:241-391; sample_paper.tex:55, 57 | `front.class-native` | `\aistatsauthor{A \And B \And C}` bold, `\aistatsaddress{...}` roman; `\And` spaces the blocks, `\AND` starts a new row; three variants chosen by the option (Anonymous Author, Anonymous Institution, or the real fields) |
| author boxes | aistats2026.sty:308-309, 318-322, 352-353 | `box.fancybox` | zero-width centred boxes (`\hbox to 0pt{\hss ... \hss}`) in a row of `\linewidth` with `\hskip 1in plus 2fil` between and `\hfil\hfil` at both ends |
| author cell | aistats2026.sty:309, 319, 363 | `tbl.tabular` | `\begin{tabular}[t]{c}` one column, centred, top-aligned |
| copyright notice float | aistats2026.sty:105-112, 128 | `fig.newfloat` | float type `copyrightbox` (`\ftype@copyrightbox`=8) placed `[b]`, opened at the start of the abstract |
| notice text box | aistats2026.sty:125 | `box.minipage` | `\parbox[b]{19.75pc}{\small notice}` |
| notice rule | aistats2026.sty:114-118 | `sp.rule` | 0.8in (4.818pc) rule at height 3.5pc, default 0.4pt thickness, inside a `picture` with `\unitlength`=1pc and size (20,2.5) |
| notice string | aistats2026.sty:77-80, 88 | `front.class-native` | submission: "Preliminary work. Under review by AISTATS 2026. Do not distribute."; `accepted`: proceedings line (ordinal, year, place, volume are strings at 56-59); `preprint`: empty and the float is dropped (131-133) |
| abstract | aistats2026.sty:399-401; sample_paper.tex:59-65 | `abs.kernel` | `\renewenvironment{abstract}`: notice float, `\centerline{\large\bfseries Abstract}`, `\vspace{0.5ex}`, then a `quote` body, `\vskip 1ex` after |
| abstract body | aistats2026.sty:400-401 | `quote.kernel` | `quote` environment |
| abstract heading | aistats2026.sty:400 | `sp.ragged` and `font.size-commands` | `\centerline`, `\large`, with `\bfseries` (`mark.kernel`) |
| sectioning | aistats2026.sty:404-413; sample_paper.tex:67, 97, 103, 109 | `head.kernel` | `\@startsection` per level, values in the next four rows |
| section | aistats2026.sty:404-405 | `head.kernel` | level 1, indent 0, before -2.0ex plus -0.5ex minus -.2ex, after 1.5ex plus 0.3ex minus .2ex, `\large\bfseries\raggedright` |
| subsection, subsubsection | aistats2026.sty:406-409 | `head.kernel` | before -1.8ex and -1.5ex (plus -0.5ex minus -.2ex), after 0.8ex and 0.5ex (plus .2ex), `\normalsize\bfseries\raggedright` |
| paragraph, subparagraph | aistats2026.sty:410-413 | `head.kernel` | before 1.5ex plus 0.5ex minus .2ex, after -1em (run-in), `\normalsize\bfseries` |
| numbering | (no setting in the zip); sample_paper.tex:367 | `num.secnumdepth` and `num.appendix` | article defaults; `\appendix` before the supplementary sections |
| unnumbered headings | sample_paper.tex:280, 285, 311; aistats2026.sty:68, 483 | `head.kernel` | `\subsubsection*{Acknowledgements}`, `\subsubsection*{References}`, `\section*{Checklist}` |
| acknowledgements macro | aistats2026.sty:66-73 | `head.kernel` | review mode drops the text, `accepted` prints `\subsubsection*{Acknowledgments}` plus text (not called by the sample) |
| font sizes | aistats2026.sty:462-471 | `font.size-commands` | size/leading in pt: normal 10/11, small and footnotesize 9/10, scriptsize 7/8, tiny 6/7, large 12/14, Large 14/16, LARGE 17/20, huge 20/23, Huge 25/28 |
| base font | (none loaded) | none | kernel default Computer Modern; no font package in either file |
| paragraphs | aistats2026.sty:424, 429 | `sp.lengths` | `\parindent 0pt`, `\parskip .5pc` |
| list parameters | aistats2026.sty:425-453 | `sp.lengths` | topsep 4pt plus 1pt minus 2pt, partopsep 1pt plus 0.5pt minus 0.5pt, itemsep 2pt plus 1pt minus 0.5pt, parsep 2pt plus 1pt minus 0.5pt; leftmargin i/ii 2em, iii 1.5em, iv 1em, v/vi .5em; labelsep 5pt; levels ii and iii get their own topsep, parsep, itemsep |
| display skips | aistats2026.sty:455-458 | `sp.lengths` | above 7pt plus2pt minus5pt, below equal, short above 0pt plus3pt, short below 4pt plus3pt minus3pt |
| lists in the body | sample_paper.tex:205-221, 232-278, 322-362 | `list.kernel` | `enumerate` to depth 2 with default labels; `flushleft` blocks inside items (sample_paper.tex:211-214) |
| flush and centre | sample_paper.tex:161, 178, 211 | `sp.ragged` | `\centerline`, `center`, `flushleft` |
| footnotes | aistats2026.sty:418-421; sample_paper.tex:138, 143 | `fn.kernel` | `\footnote`; `\setcounter{footnote}{0}` (`num.counters`) |
| footnote layout | aistats2026.sty:418-419 | `sp.lengths` | `\footnotesep 6.65pt`, `\skip\footins 9pt plus 4pt minus 2pt` |
| footnote rule | aistats2026.sty:420 | `sp.rule` | `\kern-3pt \hrule width 5pc \kern 2.6pt` (the prose at sample_paper.tex:142 says 1 inch, 6 picas; the style sets 5pc) |
| figure | sample_paper.tex:159-164 | `fig.graphicx` | `figure[h]` float holding `\vspace{.3in}`, `\centerline{\fbox{text}}`, `\vspace{.3in}`, caption below; no image |
| figure content | sample_paper.tex:160-162 | `box.fancybox` and `sp.manual-space` | `\fbox`, `\vspace` |
| table | sample_paper.tex:176-187 | `tbl.tabular` | `table[h]`, caption above, `center`, `tabular{ll}`, `\hline`, bold header cells (`mark.kernel`) |
| captions | sample_paper.tex:163, 177 | `cap.kernel` | kernel `\caption`; no caption package; table label and `\ref` (`xref.kernel`, sample_paper.tex:170, 177) |
| bibliography | aistats2026.sty:482-500; sample_paper.tex:292-308 | `bib.thebibliography` | hand-written entries with `\bibitem{}` and `\newblock`; no `.bib`, no natbib (the lines at 28-33 are comments) |
| bibliography layout | sample_paper.tex:293-294 | `sp.lengths` | `\itemindent` = -`\leftmargin`; `\@biblabel` redefined to print nothing (hanging author-year entries) |
| bibliography penalties | aistats2026.sty:493-497 | `sp.penalties` | `\clubpenalty4000`, `\widowpenalty4000`; `\sloppy` and `\sfcode` are inside the same environment |
| maths | aistats2026.sty:63; sample_paper.tex:398 | `math.amsmath` | `\RequirePackage{amsmath}`; the sample has one inline `$\lambda$` |
| emphasis | sample_paper.tex:69, 196, 302 | `mark.kernel` | `\textbf`, `\emph`, `\textit`, `\texttt` |

## Bespoke code
All items below sit in `aistats2026.sty` unless marked; the whole file is the organisers' official release (W1), and each item is also reducible if it were treated as unpublished. No item is irreducible.
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option switch `\statePaper`, `\Notice@String`, `accepted`, `preprint` | aistats2026.sty:71-91, 131-133 | yes | the mode is fixed when the document is emitted; write that variant's strings (fields, anonymous placeholders, notice, header text) and drop the `\ifnum` tests; the `\usepackage[...]` option is a W2 parameter if the style is shipped as is |
| running-head fit checks, `\PackageError` | aistats2026.sty:152-153, 192-228, 266-302 | yes | diagnostic only (boxes measure the head against `\textwidth`); emit `\fancyhead[CE]{\small\bfseries title}` and `[CO]` with a head text that fits (`hf.fancyhdr`) |
| `\aistatstitle` bars and gaps | aistats2026.sty:230-239, 473-480 | yes | `\hrule height4pt`, `\vskip .25in`, `{\centering{\Large\bfseries title\par}}`, `\vskip .25in`, `\hrule height1pt`, `\vskip .25in`, then the closing gap (`sp.rule`, `sp.manual-space`, `sp.ragged`, `font.size-commands`, `mark.kernel`, inside `cols.twocolumn-cmd`); the `\if@twocolumn` choice of the last gap is known at emit time |
| `\aistatsauthor`, `\aistatsaddress`, `\And`, `\AND`, `\ANDD` | aistats2026.sty:241-391 | yes | per row `\makebox[\linewidth]{\hspace{0pt plus 2fil}` then per cell `\makebox[0pt]{\begin{tabular}[t]{c}\bfseries text\end{tabular}}` joined by `\hspace{1in plus 2fil}`, closed by `\hspace{0pt plus 2fil}}`; a new row after `\vspace{0.25in plus 1fil minus 0.125in}`; the addresses use the same row with no `\bfseries` (`box.fancybox`, `tbl.tabular`, `sp.manual-space`); the macro that closes and reopens a tabular is replaced by explicit structure |
| copyright float | aistats2026.sty:105-128 | yes | `\DeclareFloatingEnvironment` (or `\newfloat`) for `copyrightbox` with placement b, body `\begin{center}` rule + `\parbox[b]{19.75pc}{\small notice}`, called at the start of the abstract (`fig.newfloat`, `sp.rule`, `box.minipage`); the `picture` holds one 0.4pt line and one box, so it is placement, not artwork |
| `abstract` redefinition | aistats2026.sty:399-401 | yes | `\renewenvironment{abstract}` made of the float call, `\centerline{\large\bfseries Abstract}`, `\vspace{0.5ex}`, `quote`, `\vskip 1ex` (`abs.kernel`, `quote.kernel`) |
| `\@startsection` redefinitions | aistats2026.sty:404-413 | yes | `\titleformat` and `\titlespacing*` per level with the values in the component map (`head.titlesec`), or the same `\@startsection` arguments (`head.kernel`) |
| `\subsubsubsection`, `\titlebox` | aistats2026.sty:414, 97 | yes | not used anywhere in the zip (grep); `\vskip 5pt` alone is `sp.manual-space`, the length is never read |
| list level macros `\@listi` to `\@listvi` and raw list lengths | aistats2026.sty:425-453 | yes | `\setlist[itemize,enumerate]{leftmargin, labelsep, topsep, partopsep, itemsep, parsep}` per level (`list.enumitem`), or the same raw assignments (`sp.lengths`) |
| size table with `\@setsize` | aistats2026.sty:462-471 | yes | `\renewcommand\normalsize{\fontsize{10}{11}\selectfont}` and the same for each size (`font.size-commands`); that the kernel `\normalsize` hook treats `\@normalsize` this way was not verified |
| `\footnoterule` and footnote lengths | aistats2026.sty:418-420 | yes | `\renewcommand\footnoterule{\kern-3pt\hrule width 5pc\kern 2.6pt}` (`sp.rule`), lengths by `sp.lengths` |
| `\renewenvironment{thebibliography}` | aistats2026.sty:482-500 | yes | the stock article list environment with the heading `\subsubsection*{\refname}` (`head.kernel`), label width of the widest label, `\clubpenalty` and `\widowpenalty` 4000 (`sp.penalties`), `\sloppy`; a copy of article's own code with the heading level changed |
| `\def\addcontentsline#1#2#3{}` | aistats2026.sty:142 | yes | contents lines are never written, so no `\tableofcontents` or `\listof...` is emitted for this template (`toc.kernel` unused); a one-line no-op of a kernel hook |
| `\providecommand{\acknowledgments}` | aistats2026.sty:66-73 | yes | emit the acknowledgements heading and text only in the `accepted` variant (`head.kernel`) |
| `\renewcommand{\@biblabel}[1]{}` and `\setlength{\itemindent}{-\leftmargin}` (body) | sample_paper.tex:293-294 | yes | kernel label hook set to empty and one raw length (`bib.thebibliography`, `sp.lengths`) |
| fancyhdr.sty (bundled) | fancyhdr.sty:1-485 | yes | published CTAN package v3.2 (`hf.fancyhdr`); the history ends at version 3.2 (fancyhdr.sty:143-146) and no AISTATS text was seen in it; not diffed against the CTAN copy |

## Content-opaque
none (the figure holds only a framed text line, sample_paper.tex:161)

## Lib changes
- New ways proposed: none (considered: the kernel `\makebox` family, filed under `box.fancybox`; `\centerline` under `sp.ragged`)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes for the reader: (1) the sample prints its own `\subsubsection*{References}` (sample_paper.tex:285) and the style's `thebibliography` also opens with `\subsubsection*{\refname}` (aistats2026.sty:483), so two headings would be produced when read as written; not compiled. (2) `\thispagestyle{empty}` is called in the style before `\pagestyle{fancy}` (aistats2026.sty:139, 156); whether page 1 then has an empty head was not verified. (3) The prose in sample_paper.tex says footnotes are 8pt, while the style sets `\footnotesize` to 9pt on 10pt (aistats2026.sty:464). (4) `supplement.tex` repeats the same style with `\onecolumn` and `\runningtitle` (supplement.tex:33, 43-45), so it adds no new way. (5) No text in the zip is addressed to an AI.
