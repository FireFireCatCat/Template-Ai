yes

# 0595-vityasyyy-template-skripsi-dike-ugm: UGM DIKE FMIPA skripsi/proposal template (class `ugmskripsi`)

- Unverified: read from the source, not compiled.
- Source: Source/0595-vityasyyy-template-skripsi-dike-ugm/ (origin: https://codeload.github.com/vityasyyy/template-skripsi-dike-ugm/zip/refs/heads/main; licence: MIT)
- Kind: thesis
- Lib: v5
- Engine: pdfLaTeX-compatible
- Look carried by: zip-local (the whole look is in the zip-local class `ugmskripsi.cls`; `main.tex` only fills metadata, loads packages and styles `listings`)
- Class origin: zip-local
- Main file: template/skripsi/main.tex (other samples: template/proposal/main.tex; both load the same class)
- Read: main yes, zip-local classes and styles all

## Verdict
The look sits in a zip-local class, `template/skripsi/ugmskripsi.cls`, that is `\LoadClass[a4paper,12pt]{report}` plus raw page lengths, `\@startsection` heading calls, `\renewcommand` of counters and caption names, and nine front-matter macros. Each macro is a straight-line run of kernel commands (`center`, `\vspace`, `\vfill`, `\includegraphics`, `tabular`, `\MakeUppercase`, `singlespace`). The `\newif` flags are set by class options, so an emitter resolves them to one branch. No output routine, no box algorithm, no expl3/Lua and no drawing is present, so every piece reduces to lib ways (reductions in the Bespoke table). Verdict is `yes` with one caveat: a reviewer who counts the class-native front-matter macros (`\cover`, `\abstractind`...) as irreducible class code would answer `no`; here they are expanded inline, not copied as macro logic.

## Blockers
none

## Class setting
- Class: `class.report` options: `a4paper,12pt` (given by the zip-local class at template/skripsi/ugmskripsi.cls:33; unknown options are passed on to report at :30). The zip-local wrapper is `ugmskripsi` (not on CTAN: ctan.org/pkg/ugmskripsi returned 404; template/skripsi/ugmskripsi.cls:2 names a UGM author; README.md:194 says the repo is "tidak berafiliasi resmi dengan UGM", although README.md:57 calls the file "resmi"), so it is zip-local and is not a way; it is reduced below.
- Class-native vocabulary used (of `ugmskripsi`, not a lib way): options `skripsi`, `indonesia` (template/skripsi/main.tex:1; the others are `proposal`, `satuspasi` `duaspasi` `satusetengahspasi`, `inggris`, template/skripsi/ugmskripsi.cls:14-28); setters `\titleind \titleeng \fullname \idnum \degree \gelar \yearsubmit \program \dept \firstsupervisor \firstexaminer \secondexaminer` (template/skripsi/main.tex:11-22; `\examdate` and `\headprogram` exist but are not called); page macros `\cover \titlepageind \approvalpage \declarepage \motto \acknowledment \preface` (template/skripsi/main.tex:83-90); `\abstractind ... \endabstractind` and `\abstracteng ... \endabstracteng` (template/skripsi/main.tex:99-111); `\lambang` (commented out, template/skripsi/main.tex:97).

## Component map
Paths: `CLS` = template/skripsi/ugmskripsi.cls (the same bytes as ugmskripsi.cls and template/proposal/ugmskripsi.cls, equal hashes); `MAIN` = template/skripsi/main.tex.
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | CLS:33 | `class.report` | a4paper, 12pt; default openany, oneside |
| paper and size | CLS:33 | `page.class-options` | a4paper, 12pt |
| page geometry | CLS:43-53 | `page.setlength` | topmargin=-0.9cm, headheight=12pt, headsep=2.3cm, topskip=1ex, oddsidemargin=evensidemargin=1.46cm, textwidth=14.3cm, textheight=22cm, footskip=1.5cm, marginparsep=marginparwidth=0 |
| paragraph indent | CLS:55 | `sp.lengths` | parindent=3em |
| indent after headings | CLS:6 | `sp.indentfirst` | no options |
| line spacing | CLS:7, CLS:17-23, CLS:469-478 | `sp.setspace` | default `\onehalfspacing` (option satusetengahspasi, CLS:31); `\singlespacing`/`\doublespacing` by option; `singlespace` env inside cover, title page, abstracts |
| text font | CLS:8-9 | `font.mathptmx` | `times` package (Times) |
| encoding | CLS:8; MAIN:27 | `font.fontenc-t1` | fontenc T1; inputenc utf8 |
| symbol fonts | CLS:10 | `math.amssymb` | `latexsym` (LaTeX base), load-only symbol-font package; filed here as the sibling of amssymb, no symbol of it is used |
| running head | CLS:60-61 | `hf.pagestyle-kernel` | `\pagestyle{myheadings}`, `\markright{}` (no text; page number at head right) |
| chapter-first-page style | CLS:66-70, CLS:89 | `hf.fancyhdr` | reduction of `\ps@chapterheading`: `\fancypagestyle{chapterheading}{\fancyhf{}\fancyfoot[C]{\thepage}\renewcommand{\headrulewidth}{0pt}}`; this equals kernel `plain`, so `\thispagestyle{plain}` also serves |
| page numbering | CLS:222-223, CLS:259-260, CLS:466 | `pgnum.pagenumbering` | roman, page=1 at the cover and title page; arabic, page=1 at the end of the English abstract |
| chapter headings | CLS:89-106 | `head.titlesec` | reduction of `\@makechapterhead`/`\@makeschapterhead`: `\titleformat{\chapter}[display]` centred, label `\large\bfseries \chaptertitlename\ \thechapter`, sep 5pt, title `\large\bfseries` with `\interlinepenalty=10000`; `\titlespacing*{\chapter}{0pt}{0pt}{20pt}`; numberless form same minus label; `\chapter` itself equals report's (`\clearpage`, `\global\@topnum\z@`, `\secdef`) |
| section headings | CLS:111-118, CLS:123-127 | `head.kernel` | `\@startsection` calls: section level 1, indent 0, before -3.5ex plus -1ex minus -.2ex, after 2.3ex plus .2ex, `\normalfont\normalsize\bfseries`; subsection level 2, -3.25ex plus -1ex minus -.2ex, 1.5ex plus .2ex, same font; subsubsection level 3 run-in (after -1em), 3.25ex plus1ex minus.2ex; `\paragraph` aliased to `\subparagraph` |
| numbering depth | CLS:75 | `num.secnumdepth` | secnumdepth=2 |
| counters | CLS:76-81, CLS:129-135 | `num.counters` | `\thechapter` `\Roman{chapter}`; `\thesection` `\arabic{chapter}.\arabic{section}`; `\thesubsection` likewise; figure, table, equation `\ifnum\c@chapter>0 \arabic{chapter}.\fi\arabic{..}` (report does the same with `\thechapter`); `\@addtoreset{equation}{chapter}` already in report |
| appendix | CLS:84-88; MAIN:131 | `num.appendix` | equals report's `\appendix` (`\appendixname`, `\Alph{chapter}`); `\thesection` stays arabic-chapter (CLS:79) |
| language, caption names | CLS:5, CLS:140-177, CLS:480-486 | `lang.babel` | `babel[english,bahasa]`; names via `\def\captionsbahasa` and `\def\captionsenglish` (`\contentsname` DAFTAR ISI, `\listfigurename`, `\listtablename`, `\abstractname` INTISARI/ABSTRACT, `\chaptername` BAB, `\appendixname` LAMPIRAN, `\refname`/`\bibname` DAFTAR PUSTAKA, `\figurename` Gambar, `\tablename` Tabel, new `\prefacename`, `\nomenclaturename`); `\selectlanguage{bahasa}` at begin document; reduces to `\addto\captions...` string overrides |
| links and URLs | MAIN:39-40 | `meta.hyperref`, `meta.url` | hyperref no options, `url` no options |
| anchor for toc entries | CLS:306, CLS:350, CLS:379, CLS:389, CLS:415, CLS:444 | `xref.hyperref` | `\phantomsection` before each `\addcontentsline` |
| cover | CLS:220-252; MAIN:83 | `front.titlepage-env` | hand-laid: `\thispagestyle{empty}`, centred `singlespace`, `\MakeUppercase` bold lines, `\vspace` 1.5cm/1.0cm, `\vfill`, `\includegraphics{logougm}`, text lines (title, name, NIM, programme, faculty, university, city, year); `\if@msproposal` picks "Proposal Tugas Akhir" or "Skripsi" (resolved at emit) |
| title page | CLS:257-297; MAIN:84 | `front.titlepage-env` | same layout plus "Diajukan untuk memenuhi ... `\@gelar`" (CLS:273-278), `\addcontentsline{toc}{chapter}{Halaman Judul}` (CLS:296) |
| approval page | CLS:302-342; MAIN:85 | `front.titlepage-env`, `tbl.tabular` | centred block; two `tabular{p{7cm}p{7cm}}` signature rows (CLS:329-339); `\vspace` 4.0cm, 3.0cm; date from `\@examdate` |
| statement page | CLS:347-371; MAIN:86 | `front.dedication`, `tbl.tabular` | fixed Indonesian declaration text; `tabular{p{7.5cm}c}` signature block (CLS:364-369); style chapterheading |
| motto, dedication pages | CLS:376-391; MAIN:87-88 | `front.dedication` | `\clearpage`, `\null\vfill` (text sits at page bottom), `\addcontentsline{toc}{chapter}{Halaman Persembahan / Motto}` |
| preface | CLS:396-399; MAIN:90-92 | `head.kernel`, `toc.kernel` | `\chapter*{\prefacename}` + `\addcontentsline`; main.tex repeats `\addcontentsline` (MAIN:91), so emit both |
| contents lists | MAIN:94-96 | `toc.kernel` | `\tableofcontents`, `\listoftables`, `\listoffigures`; no tocloft/titletoc |
| nomenclature | CLS:36-38, CLS:404-408; MAIN:97 | `idx.glossaries` | `nomencl`, `\renewcommand{\nomname}{\nomenclaturename}`, `\makeglossary`; `\lambang` = `\clearpage`, page style, `\printglossary` (unused in the sample) |
| abstracts | CLS:413-436, CLS:441-466; MAIN:99-111 | `front.titlepage-env` | hand-laid page: `\clearpage`, `\phantomsection`, `\addcontentsline`, centred `\large\textbf{\abstractname}`, title, "Oleh"/"By", name, NIM, text inside `singlespace` with `\vskip 20pt`; English one wrapped in `\selectlanguage{english}` ... `\selectlanguage{bahasa}` |
| lists | template/skripsi/chapters/bab1-pendahuluan.tex:20-24; template/skripsi/chapters/bab4-perancangan.tex:31-35 | `list.kernel` | `enumerate`, `itemize`; `enumitem` loaded with no `\setlist` (MAIN:41) so `list.enumitem` only as load |
| inline marks | template/skripsi/chapters/bab1-pendahuluan.tex:57-58; CLS:227 | `mark.kernel`, `mark.case` | `\textbf`; `\MakeUppercase` on cover, title, approval lines |
| manual spacing, centring | CLS:231, CLS:248, CLS:94 | `sp.manual-space`, `sp.ragged`, `sp.penalties` | `\vspace`, `\vfill`, `\vskip 12\p@`, `\centering`, `\interlinepenalty\@M` (`=10000`) |
| page breaks | CLS:89, CLS:303, CLS:377 | `pg.break` | `\clearpage`, `\newpage` |
| font sizes | CLS:96, CLS:419 | `font.size-commands` | `\large`, `\normalsize`; `\small`, `\tiny` in lstset (MAIN:45, MAIN:49) |
| figures | MAIN:28-29, MAIN:36; template/skripsi/chapters/bab4-perancangan.tex:10-15 | `fig.graphicx`, `fig.float` | `graphicx`, `\graphicspath{{figures/}}`; `[H]` from `float`; the one figure in the sample is commented out |
| tables, captions | template/skripsi/chapters/bab6-pengujian.tex:33-45 | `tbl.tabular`, `cap.kernel` | `table[H]`, `\caption` above, `tabular{|l|c|l|}` with `\hline`; `booktabs`, `longtable`, `tabularx`, `multirow` loaded (MAIN:32-35) and unused in the skripsi body; the proposal uses `\multirow`, `\multicolumn` (template/proposal/chapters/bab4-jadwal-penelitian.tex:15) so `tbl.multirow` |
| code | MAIN:37, MAIN:44-55; template/skripsi/chapters/bab5-pembuatan.tex:23-28; template/skripsi/lampiran/lampiran-a.tex:8-15 | `code.listings` | `\lstset{basicstyle=\ttfamily\small, breaklines, frame=single, numbers=left, numberstyle=\tiny, keywordstyle blue, commentstyle gray, stringstyle orange, showstringspaces=false, tabsize=2}`; `lstlisting[language=python, caption=...]` |
| listings languages | MAIN:58-65, MAIN:68-75 | `code.listings` | `\lstdefinelanguage{yaml}`, `{docker}` (keywords, sensitive=false, comment=[l], morecomment, morestring, alsoletter) |
| colour | MAIN:38 | `color.xcolor` | no options; `\color{blue}`, `gray`, `orange` named colours |
| maths | MAIN:30-31; template/skripsi/chapters/bab6-pengujian.tex:42 | `math.amsmath`, `math.amssymb` | `\checkmark` from amssymb; `$\bullet$` in template/proposal/chapters/bab4-jadwal-penelitian.tex:19 is `math.kernel` |
| bibliography | CLS:34-35; MAIN:126; template/skripsi/chapters/bab3-kajian-ilmiah.tex:8 | `bib.bibtex-bst`, `bib.natbib` | `\bibliographystyle{plainnat}`, `\bibliography{references}`, `\citep`; heading from `\bibname` DAFTAR PUSTAKA |
| file inclusion | MAIN:116-121, MAIN:132 | `struct.input` | `\include` of six chapter files and `lampiran/lampiran-a` |
| sectioning in body | template/skripsi/chapters/bab2-identifikasi-masalah.tex:1-5 | `head.kernel` | `\chapter`, `\section`, `\subsection` used; `\subsubsection` unused |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class wrapper | template/skripsi/ugmskripsi.cls:1-488 | yes | `class.report` a4paper,12pt + the preamble ways of the Component map; nothing outside kernel and published packages |
| option flags `\newif`, `\DeclareOption`, `\ExecuteOptions` | template/skripsi/ugmskripsi.cls:12-32 | yes | the three choices (skripsi/proposal, spacing, language) are known when emitting; emit one branch: strings on the cover, `\onehalfspacing`, babel main language; unknown options pass to report (:30) |
| `\ps@chapterheading` | template/skripsi/ugmskripsi.cls:66-70 | yes | `hf.fancyhdr` named style or kernel `plain` |
| `\renewcommand{\chapter}` | template/skripsi/ugmskripsi.cls:89-92 | yes | report's own `\chapter` (same `\clearpage`, `\@topnum`, `\secdef`), style chapterheading, `\@afterindenttrue` made moot by `indentfirst` |
| `\@makechapterhead`, `\@makeschapterhead` | template/skripsi/ugmskripsi.cls:93-106 | yes | `head.titlesec` as in the table; the `\ifnum\c@secnumdepth>\m@ne` test is report's own code and titlesec honours secnumdepth |
| sectioning `\renewcommand` | template/skripsi/ugmskripsi.cls:111-127 | yes | `head.kernel`: `\@startsection` is called with the kernel's six arguments, not redefined; `head.titlesec` would serve too |
| numbering `\renewcommand` | template/skripsi/ugmskripsi.cls:76-88, 129-135 | yes | `num.counters`, `num.appendix` |
| caption-name hooks | template/skripsi/ugmskripsi.cls:140-177 | yes | `lang.babel` string overrides (`\addto\captionsbahasa{...}`, `\addto\captionsenglish{...}`) |
| data setters `\titleind` ... `\secondexaminer` | template/skripsi/ugmskripsi.cls:182-215 | yes | `\gdef` stores of strings (content); inline the values where used |
| `\@examdate` default | template/skripsi/ugmskripsi.cls:194-197 | yes | `\ifcase\month` Indonesian month names = babel `bahasa` `\today` (inferred, babel source not read) or `\today`-like `front.datetime` format |
| page macros `\cover` `\titlepageind` `\approvalpage` `\declarepage` `\acknowledment` `\motto` `\preface` `\lambang` | template/skripsi/ugmskripsi.cls:220-408 | yes | inline expansion to kernel commands, rows above; `\expandafter{..}` at :308 and :324 is a no-op group and a one-step expansion, no effect |
| `\abstractind`/`\endabstractind`, `\abstracteng`/`\endabstracteng` | template/skripsi/ugmskripsi.cls:413-466 | yes | `\begin{singlespace}` opened in one macro, closed in the other: emit as one sequence header block, `\begin{singlespace}`, text, `\par\vfil\null\end{singlespace}`; the English one then `\selectlanguage{bahasa}\clearpage\pagenumbering{arabic}\setcounter{page}{1}` |
| `\AtBeginDocument` blocks | template/skripsi/ugmskripsi.cls:469-486 | yes | one spacing command and one `\selectlanguage`, chosen by class options |
| `\lstdefinelanguage` yaml, docker | template/skripsi/main.tex:58-75 | yes | declarative `code.listings` keys |

## Content-opaque
none (the cover logo `figures/logougm.pdf` is a shipped image, template/skripsi/ugmskripsi.cls:236 and :280; it is present at template/skripsi/figures/logougm.pdf; no TikZ, PGF or picture drawing exists in the zip)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes (not part of the layout): the zip also holds a Makefile, a Dockerfile and a GitHub workflow that only run `pdflatex` and `bibtex` (Makefile:26-38), so nothing is EXTERNAL. `nomencl` needs a `makeindex` pass only when `\nomenclature` entries exist, and the sample has none. `AGENTS.md` is written for coding agents (headed "Aturan Prioritas (WAJIB DIKUTI)", telling them to follow `pedoman_ta.pdf` and to replace the logo); it is data, was not followed, and has no bearing on the analysis. The `examples/*.pdf` files are guideline documents, not template sources. Whether the old `bahasa` babel option still defines `\captionsbahasa` in current babel was not checked (babel source not read).
