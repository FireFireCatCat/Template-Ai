yes

# 0569-eth-zurich-thesis: ETH Zurich Thesis (jb-thesis)

- Unverified: read from the source, not compiled.
- Source: Source/0569-eth-zurich-thesis/ (origin: https://latextemplates.com/downloads/eth-thesis.zip; licence: MIT per the manifest, the class file states none)
- Kind: thesis
- Lib: v4
- Engine: pdfLaTeX-compatible (T1 fontenc, microtype, no fontspec)
- Look carried by: zip-local (jb-thesis.cls on `report`: title page, headings, running heads, captions, abstract; the sample preamble only loads fontenc, natbib, booktabs, graphicx and fills the title fields)
- Class origin: zip-local (jb-thesis.cls:3-6 credits Jonathan Binas, based on ut-thesis; one CTAN read, https://ctan.org/pkg/jb-thesis, returned 404; the zip comes from latextemplates.com, not an ETH release)
- Main file: main.tex (other samples: none; chapters/abstract.tex, chapters/introduction.tex, chapters/evaluation.tex are `\input` content files)
- Read: main yes, zip-local classes and styles all (jb-thesis.cls lines 1-688; the only zip-local class or style)

## Verdict
yes. The look lives in one zip-local class, jb-thesis.cls, which is `\LoadClass{report}` plus `geometry`, `setspace` and `microtype`, plus redefinitions of kernel hooks (`\@makechapterhead`, `\@startsection` calls, `\@seccntformat`, `\@makecaption`, `\ps@*` page styles, `\part`, `\maketitle`, `abstract`). Each of those has a lib way that holds the same parameters (`head.titlesec`, `hf.fancyhdr`, `cap.caption`, `front.titlepage-env`, `page.geometry`, `sp.setspace`), and every conditional in the class tests a value the emitter already knows (the class options, the current page style), so it can be resolved when the file is written. No TikZ, PGF or picture code, no shell escape, no tool outside TeX is needed for the sample. The weakest reductions are the `\part` table-of-contents entry and the option-gated draft stamp; the sample uses neither, and both are written down below. A reduction here is a reading of the source, not something compiled.

## Blockers
none (considered, not blockers: the optional `gitinfo2` branch and the `\partextra` hook, bespoke rows 14 and 17)

## Class setting
- Class: `class.report` options: `b5paper`, `twoside` from main.tex:1, passed through by `\DeclareOption*` (jb-thesis.cls:258); class defaults `a4paper,twoside,openright` then `normalmargins,onehalfspaced,singlespacednotes` (jb-thesis.cls:264-265). The zip-local class name `jb-thesis` is not a lib class way; the whole file is reduced below.
- Class-native vocabulary used: `\chapter` `\section` `\label` `\tableofcontents` `\maketitle` (report); zip-local, reduced to strings and ways: `\degree` `\degreeabbr` `\gradyear` `\acadtitle` `\born` `\citizen` `\examiners` (main.tex:8-22), `\author` `\title` (renewed, jb-thesis.cls:327-330), `preliminary` env (main.tex:28-32), `abstract` env (chapters/abstract.tex:1).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1; jb-thesis.cls:274 | `class.report` | `\LoadClass{report}`; b5paper, twoside |
| paper, sides, chapter opening | main.tex:1; jb-thesis.cls:264 | `page.class-options` | b5paper, twoside, openright (default); `a4paper` default is passed first (264) |
| margins | jb-thesis.cls:217-219 (default, run at 265; other branches 214-225) | `page.geometry` | normalmargins, run `\AtEndOfClass`: margin=1in, left=1.25in, headsep=.5in-\headheight, footskip=.5in, marginparwidth=.75in, marginparsep=.125in |
| line spacing | jb-thesis.cls:229, 265, 279 | `sp.setspace` | `\onehalfspacing` by default (`\singlespacing`, `\doublespacing` are the other option branches, 228-230) |
| title-page single spacing | jb-thesis.cls:159, 357 | `sp.setspace` | `\setstretch{\setspace@singlespace}` inside the title page |
| note spacing | jb-thesis.cls:143-147, 233-241, 265 | `fn.kernel` | `singlespacednotes` (default): `#1\singlespacingnoskip` appended to footnote text; `\footnotesep` and `\marginparpush` kept at their saved values |
| margin-note spacing | jb-thesis.cls:240-241 | `note.marginpar` | `\@marginparreset` followed by `\singlespacingnoskip` (not used by the sample) |
| micro-typography | jb-thesis.cls:292-293 | `sp.microtype` | activate={true,nocompatibility}, tracking=true, kerning=true, spacing=true, stretch=10, shrink=10; loaded only `\IfFileExists{microtype.sty}` (reduces to an unconditional load) |
| font encoding | main.tex:3 | `font.fontenc-t1` | `T1`; no text-font package, so Computer Modern with `\sffamily` for headings and heads |
| font switches | jb-thesis.cls:559, 582, 630, 663; main.tex:8 | `font.size-commands`, `mark.kernel` | `\Large \large \huge \normalsize \small \scriptsize`; `\sffamily \bf \bfseries \scshape`; `\sc` in main.tex:8 and jb-thesis.cls:361,363 |
| running heads and feet | jb-thesis.cls:495-518 (thesis), 521-553 (prelim), 451-466 (empty, plain), 469-492 (headings), 688 (default `\pagestyle{thesis}`) | `hf.fancyhdr` | twoside thesis style: odd head `\sffamily\small\rightmark\hfil\thepage`, even head `\sffamily\small\thepage\hfil\leftmark`, empty foot, no rule. prelim style: no head, foot `\sffamily\small\hfil\thepage\hfil`. plain and empty: empty head and foot (so chapter openers carry no number). marks: `\chaptermark` = `\textbf{\@chapapp\ \thechapter}\, \ title` when secnumdepth > -1, `\sectionmark` = `\textbf{\thesection}\, \ title` when secnumdepth > 0 |
| page-style selection | jb-thesis.cls:351, 688 | `hf.pagestyle-kernel` | `\pagestyle{prelim}`, `\pagestyle{thesis}` |
| front-matter page numbers | jb-thesis.cls:350-352, 389, 391 | `pgnum.pagenumbering` | roman in `preliminary`, `\cleardoublepage` then arabic at the end; `\setcounter{page}{1}` then `{2}` around the title page |
| blank pages | jb-thesis.cls:153, 250-255, 431-436 | `pg.break` | `\cleardoublepage` and the `\clear{empty,plain,thesis,standard}doublepage` variants (page style of the inserted page); `\newpage` after the abstract (401) |
| title commands in the sample | main.tex:12, 17, 24, 29 | `front.maketitle` | the kernel names `\title` `\author` `\date` `\maketitle`; the class replaces them (327-330, 355), and `\date{\today}` prints nothing because `\maketitle` never reads `\@date` (355-392) |
| title page | main.tex:29; jb-thesis.cls:355-392 | `front.titlepage-env` | `titlepage` + `center`, `\mbox{}` and `\vfill` / `\vfill \vfill` spacing, fixed strings "Diss. ETH no.", "A thesis submitted to attain the degree of", "presented by", "born on", "citizen of", "accepted on the recommendation of"; title `\sc\Large`; fields degree, degree abbreviation in parentheses, author, acad. title, born, citizen, examiners, year |
| title fields | main.tex:8-24; jb-thesis.cls:309-343 | `front.titlepage-env` | values only: degree `{\sc Doctor of Sciences} of ETH Zurich`, abbreviation `Dr. sc. ETH Zurich`, year 2026, `MSc. ETH Zurich`, `1/1/1998`, `Switzerland`, examiners two lines separated by `\\`; `\dissno` is not set, so `\emph{(dissertation no.)}` prints (335, 361); `\department` is set to a placeholder and never printed |
| abstract | chapters/abstract.tex:1-5; jb-thesis.cls:395-401 | `abs.kernel` | heading `\section*{Abstract}`, group, `\doublespacing` when `\baselinestretch` < 1.6 (true under the default 1.5 spacing), `\par\endgroup\newpage` |
| table of contents | main.tex:30 | `toc.kernel` | `\tableofcontents`, report layout; the class changes only the part entries (620-624) |
| chapter heads | jb-thesis.cls:578-599 | `head.titlesec` | numbered: `\vspace*{50pt}`, `\raggedright`, `\parindent 0`, line 1 `\Large\sffamily\bfseries \@chapapp\space\thechapter`, `\vskip 20pt`, title `\huge` (stays sans bold), `\interlinepenalty\@M`, `\vskip 40pt`; starred: `\vspace*{50pt}`, `\huge\sffamily\bfseries`, `\vskip 40pt` |
| section heads | jb-thesis.cls:556-575 | `head.kernel` | `\@startsection` renewals, as written: section `{-3.5ex plus -1ex minus -.2ex}{2.3ex plus .2ex}{\normalfont\Large\bf\sffamily}`; subsection `{-3.25ex ...}{1.5ex plus .2ex}` `\large`; subsubsection `\normalsize`; paragraph `{3.25ex ...}{-1ex}`; subparagraph indent `\parindent`, `{-1em}`. Same values reduce to `\titleformat` and `\titlespacing` |
| hanging section numbers | jb-thesis.cls:657 | `head.titlesec` | label `\llap{\normalfont\sffamily\the<level>\quad}` (the `\@seccntformat` hook becomes the label argument) |
| part heads and part toc line | jb-thesis.cls:602-653, 620-624 | `head.titlesec`, `toc.titletoc` | `\cleardoublepage`, `\thispagestyle{plain}`, `\null\vfil`; label `\LARGE\scshape\MakeUppercase{\partname\quad\thepart}`, `\vskip 25pt`, title `\huge\sffamily\bfseries` centred, `\vskip 4in`, then the one-shot `\partextra` text; starred form left-aligned with `\vspace*{50pt}`; toc text `\llap{\makebox[0.9em][l]{\thepart}}\hspace{1.2em}title`; not used by the sample |
| numbering depth | jb-thesis.cls:478, 481, 618 | `num.secnumdepth` | report default (the class only tests `\c@secnumdepth`) |
| lists | chapters/introduction.tex:15-20 | `list.kernel` | `enumerate`, default labels |
| single-spaced quotes | jb-thesis.cls:439-442 | `quote.kernel` | `quote` or `quotation` plus `\singlespacingnoskip` (not used by the sample) |
| unnumbered footnote | jb-thesis.cls:675 | `num.counters` | `\blfootnote` = footnote with an empty mark; as `\renewcommand\thefootnote{}` in a group plus `\footnotetext` (not used by the sample) |
| dedication | jb-thesis.cls:405-407 | `front.dedication` | `flushright` paragraph, no page of its own |
| acknowledgements | jb-thesis.cls:411-416, 678-684 | `front.dedication` | `center` containing `\section*{Acknowledgements}`, then `\noindent`; in-section `\acknowledge`: `singlespace*`, `\vskip 1em`, `\emph{\small\textbf{Acknowledgment.} ...}`, `\vskip 1em` (not used by the sample) |
| acknowledge spacing | jb-thesis.cls:679-683 | `sp.manual-space` | `\vskip 1em` before and after |
| table | chapters/evaluation.tex:9-22; main.tex:5 | `tbl.tabular`, `tbl.booktabs` | `table[htbp]`, `\centering`, `tabular{@{}lrr@{}}`, `\toprule` `\midrule` `\bottomrule` |
| figure | chapters/evaluation.tex:29-34; main.tex:6 | `fig.graphicx` | `figure[htbp]`, `\centering`; `\rule{0.6\textwidth}{4cm}` stands for the image (31), so `sp.rule` is its way |
| figure content | chapters/evaluation.tex:31 | `sp.rule` | `\rule{0.6\textwidth}{4cm}` |
| captions | jb-thesis.cls:660-671; chapters/evaluation.tex:11, 32 | `cap.caption` | `\@makecaption` reduces to `\captionsetup`: `labelfont={bf,sf}` (`\textbf{\sffamily#1}`), a label separator declared as `\hspace{1.5ex}` (no colon), `width=.9\hsize`, `justification=justified`, `singlelinecheck=true` (one-line captions centred), `aboveskip` and `belowskip` = `\abovecaptionskip` and `\belowcaptionskip` |
| caption command | chapters/evaluation.tex:11, 32 | `cap.kernel` | `\caption{...}` above the table, below the figure (body order) |
| cross-references | chapters/introduction.tex:2, 17, 19; chapters/evaluation.tex:12, 33 | `xref.kernel` | `\label`, `\ref` |
| citations | main.tex:4; chapters/introduction.tex:8, 24 | `bib.natbib` | `natbib` default options, `\citep` |
| bibliography | main.tex:37-38; references.bib:1-18 | `bib.bibtex-bst` | `\bibliographystyle{plainnat}`, `\bibliography{references}` |
| bibliography head marks | jb-thesis.cls:420-425 | `hf.fancyhdr` | `\@mkboth{\sffamily\small\bibname}{\sffamily\small\bibname}`, only when the current style is `thesis`; natbib loads after the class (main.tex:4) and may replace the environment (not verified); as a `\markboth` call after the heading |
| file inclusion | main.tex:31, 34, 35 | `struct.input` | `\input{chapters/abstract}`, `\input{chapters/introduction}`, `\input{chapters/evaluation}` |
| draft stamps (option branch) | jb-thesis.cls:165-211, 454-553 | `hf.fancyhdr`, `mark.case`, `color.color` | options `draft`, `printrev`, `printrevtitle` (none selected in main.tex:1): `\raisebox{-3ex}[0pt][0pt]{\sffamily\scriptsize\color{gray}{DRAFT -- BUILT ON \MakeUppercase\today}}` in the foot via `\rlap` or `\llap`; the draft option also sets double spacing, twoside, openany |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| 1 whole class jb-thesis (report + calc, geometry, setspace, microtype) | jb-thesis.cls:116-688 | yes | `class.report` + preamble ways above; every item below is a piece of it |
| 2 option machinery, `\ExecuteOptions`, `\DeclareOption*` | jb-thesis.cls:162-268 | yes | options are the parameters named in the rows above (margin set, spacing, note spacing, cleared-page style); the emitter writes the chosen branch |
| 3 field macros `\degree` ... `\title`, empty-argument guard, placeholder defaults | jb-thesis.cls:309-343 | yes | strings printed in the title page; the guard only keeps a default when the argument is empty |
| 4 `\maketitle` as `titlepage` | jb-thesis.cls:355-392 | yes | `front.titlepage-env` with the literal lines; `\if@revtitle` (386) belongs to the draft branch |
| 5 `preliminary` environment | jb-thesis.cls:350-352 | yes | group with `\pagestyle{prelim}\pagenumbering{roman}` ... `\cleardoublepage\pagenumbering{arabic}` |
| 6 `abstract` with `\ifdim\baselinestretch pt<1.6pt` | jb-thesis.cls:395-401 | yes | the test reads the spacing option the emitter holds (1.5 spacing: true), so `\doublespacing` is written directly |
| 7 `dedication`, `acknowledgements`, `\acknowledge` | jb-thesis.cls:405-416, 678-684 | yes | kernel `flushright` and `center`, `\section*`, `singlespace*`; aliases of kernel commands |
| 8 `thebibliography` wrapper and `\if@thesispagestyle` | jb-thesis.cls:137, 420-425, 452-553 | yes | the switch is true only under style `thesis`; outside `preliminary` that is always the case, so a `\markboth` call follows the heading |
| 9 `\cleardoublepage` variants | jb-thesis.cls:153, 431-436 | yes | `{\pagestyle{x}\cleardoublepage}` groups |
| 10 `longquote`, `longquotation` | jb-thesis.cls:439-442 | yes | `quote` or `quotation` plus `\setstretch{1}` |
| 11 `\ps@empty`, `\ps@plain`, `\ps@headings`, `\ps@thesis`, `\ps@prelim` with `\@mkboth` and mark hooks | jb-thesis.cls:451-553 | yes | `\fancypagestyle` for each, `\renewcommand\chaptermark` and `\sectionmark` as in the running-heads row; `\if@twoside` (469, 495, 521) is fixed by the `twoside` option |
| 12 `\@startsection` renewals, `\@seccntformat`, `\@makechapterhead`, `\@makeschapterhead` | jb-thesis.cls:556-599, 657 | yes | `\titleformat` and `\titlespacing` with the lengths and font switches in the heading rows |
| 13 `\part`, `\@part`, `\@spart` | jb-thesis.cls:605-653 | yes (not used by the sample) | `head.titlesec` display-shaped part, `\assignpagestyle` plain, toc line through `toc.titletoc` `\titlecontents{part}` with a negative left indent for the 0.9em hanging number (the closest published parameters; exact box layout not tested) |
| 14 `\partextra`, `\setpartextra` one-shot hook | jb-thesis.cls:602-603, 636-637, 651-652 | yes (not used by the sample) | a text slot printed once under the part heading; the emitter writes that text as a paragraph after the part, no macro needed |
| 15 `\@makecaption`, `\@captionwidth` | jb-thesis.cls:660-671 | yes | `cap.caption` keys in the captions row; the width test of the original is `singlelinecheck`; caption source not read |
| 16 `\blfootnote` | jb-thesis.cls:675 | yes (not used by the sample) | empty-mark footnote through `\thefootnote` and `\footnotetext` |
| 17 draft stamp, `gitinfo2` | jb-thesis.cls:127-130, 173-211, 282-289 | yes (not selected by the sample) | stamp strings as in the draft row; `gitinfo2` (CTAN, LPPL 1.3, one read of ctan.org/pkg/gitinfo2) is loaded only if installed and gives `\gitAbbrevHash` and `\gitCommitterIsoDate` from a git hook; whether it compiles without the hook was not read, so the emitter takes the fallback `BUILT ON \MakeUppercase\today` text. Latent: `\color` (183, 202, 206, 209) needs a colour package that neither the class (277-279) nor main.tex:3-6 loads |
| 18 note-spacing hooks on `\@footnotetext`, `\@mpfootnotetext`, `\@marginparreset` | jb-thesis.cls:143-150, 233-247 | yes | `\setstretch{1}` at the end of footnote and margin-note text, written as wrapper content; `standardspacednotes` branch is the reverse |
| 19 `\singlespacingnoskip`, `\RequirePackage{calc}` | jb-thesis.cls:159, 277 | yes | `\setstretch{1}`; `calc` is a load-only helper that lets `\geometry` read `.5in-\headheight` (215-224), no printed effect |

## Content-opaque
none (the `\rule` placeholder at chapters/evaluation.tex:31 is held by `sp.rule`)

## Lib changes
- New ways proposed: none. Considered and not proposed: `calc` (load-only length arithmetic, the same type as the rejected load-only packages in the v4 change log, and the reduction can write the length as a value), `gitinfo2` (optional branch behind options the sample does not select, takes its values from a git hook), `footmisc` `\footnotelayout` (a second way to the same footnote-spacing effect, source not read).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
