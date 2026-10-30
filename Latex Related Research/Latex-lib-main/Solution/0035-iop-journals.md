yes

# 0035-iop-journals: IOP Publishing journal article template (`iopjournal`, IOP's own LaTeX kit)

- Unverified: read from the source, not compiled.
- Source: Source/0035-iop-journals/ (origin: https://publishingsupport.iopscience.iop.org/wp-content/uploads/2025/07/ioplatextemplate.zip; licence: not established in the manifest; iopjournal.cls:12-20 states Copyright 2025 IOP Publishing Ltd under LPPL 1.3c)
- Kind: journal
- Lib: v1
- Engine: pdfLaTeX-compatible (the class loads only fancyhdr, xcolor, graphicx, hyperref, iopjournal.cls:33-37,57; both images are PDF, iopjournal-template.tex:43, iopjournal.cls:183; no fontspec, no shell escape)
- Look carried by: class (everything printed is defined in iopjournal.cls; the sample has no preamble, no package and no macro of its own, iopjournal-template.tex:3-8, and adds only content)
- Class origin: publisher-official
- Main file: iopjournal-template.tex (other samples: none)
- Read: main yes (lines 1-91), zip-local classes and styles all (iopjournal.cls lines 1-184; no .sty/.def/.cfg/.clo/.bst/.bbx/.cbx present). Not read: iopjournal-guidelines.pdf (4 pages, documentation only; page rendering was unavailable here), figure1.pdf and orcid.pdf (assets).

## Verdict
The look is carried entirely by `iopjournal.cls`, which came from IOP Publishing's own author-support page, so under the rubric's W1 ruling (a publisher's official kit is published, as eLife's kit is) it is the single way `class.iopjournal`. The sample passes no class option and defines nothing: it uses the class's own commands (`\articletype \title \author \affil \email \keywords \ack \funding \roles \data \suppdata \orcid`), the `abstract` environment, kernel sectioning, one figure and one `tabular`. No `ART`, `EXTERNAL` or `UNMAPPED` item was found (the Crossmark and RECEIVED/REVISED block is plain text and two grey rules in a `\marginpar`). The `yes` rests on the W1 ruling: if the class were judged zip-local, the `\if@anonymous` removal logic would be the one item with no lib way (listed under "Bespoke code"); every other class macro reduces to lib ways.

## Blockers
none

## Class setting
- Class: `class.iopjournal` options: none in the sample (iopjournal-template.tex:3). The class defines `anonymous` (iopjournal.cls:42-44; documented iopjournal-template.tex:5-6) and passes every other option to `article` (iopjournal.cls:49). It loads `article` with `a4paper` fixed (iopjournal.cls:55); that base class is an internal load, not a separate way here. Version `2024/01/31` (iopjournal.cls:29).
- Class-native vocabulary used: `\articletype{}` (template:10), `\title{}` (12), `\author{}` with `$^n$` marks and `\orcid{id}` (14), `\affil{}` repeated (16,18,20), `\email{}` (22), `\keywords{}` (24), env `abstract` (26-28), `\ack{}` (71), `\funding{}` (73), `\roles{}` (76), `\data{}` (79), `\suppdata{}` (82). No `\maketitle`: `\title` and `\author` typeset on the spot (iopjournal.cls:98-106). Redefined kernel pieces: `\section \subsection \subsubsection` (129-140), `\@makecaption` (167-175), `\tabular` (178-179), `abstract` (120-124), `\headrule \footrule` (84-89).

## Component map
Rows marked [sample] are what an emitter writes; rows marked [class] are fixed inside `class.iopjournal` and shown so the reduction is on record.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class [sample] | template:3 | `class.iopjournal` | `\documentclass{iopjournal}`, no options (`anonymous` is the only own option) |
| paper size [class] | cls:55 | `page.class-options` | `a4paper` passed to `\LoadClass{article}`; 10pt default |
| page geometry [class] | cls:60-68 | `page.setlength` | `\voffset`=-25mm, `\headsep`=10mm, `\footskip`=12mm, `\marginparwidth`=25mm, `\marginparsep`=2mm, `\textwidth`=153mm, `\textheight`=255mm; `\hoffset`, `\topmargin` left at defaults (commented out, 61-62); one column, so no columns way |
| text shape [class] | cls:71-72 | `sp.ragged`, `sp.lengths` | global `\raggedright`; `\parindent`=15pt |
| header and footer [class] | cls:33,75-89 | `hf.fancyhdr`, `color.xcolor`, `sp.rule` | `\pagestyle{fancy}`; `\fancyhfoffset[L]{27mm}`; head L `{\small\sf IOP Publishing}\hspace{5mm}{\it Journal}{\bf vv}(yyyy) aaaaaa` (placeholder text), head C and foot L,R empty, head R `Author {\it et al}`, foot C `\thepage`; `\headrulewidth`=`\footrulewidth`=0.5pt; rules recoloured `\color{gray}` by redefining `\headrule` and `\footrule` (the hook the fancyhdr manual documents) |
| colour [class] | cls:35,84,87,96,122,124 | `color.xcolor` | `\color{gray}` for rules and the Crossmark block; no `\definecolor` |
| links [class] | cls:57 | `meta.hyperref` | `colorlinks=true`, `allcolors=blue` |
| article type and margin block [sample] | template:10; cls:93-96 | `front.class-native`, `note.marginpar`, `sp.manual-space`, `sp.rule`, `font.size-commands`, `mark.kernel` | `\vspace*{-8mm}`, `\Large\sf` "Journal Name" (placeholder), `\vspace*{8mm}`, `\reversemarginpar`, `\marginpar` holding grey `\hrule`, "Crossmark", `\hrule`, `\tiny\sf RECEIVED` with `\small dd Month yyyy`, `REVISED` likewise; the argument set `\scriptsize\sf\bfseries\MakeUppercase` |
| title [sample] | template:12; cls:98-100 | `front.class-native`, `font.size-commands`, `sp.ragged`, `sp.penalties`, `fig.placement` | `\fontsize{18}{21}\selectfont\noindent\raggedright\textsf{#1}\par`; `\hyphenpenalty` and `\exhyphenpenalty` = 10000 (integer penalty parameters, as `sp.penalties` admits); kernel `\suppressfloats[t]` after it |
| authors [sample] | template:14; cls:103-106 | `front.class-native`, `sp.manual-space`, `font.size-commands` | `\vspace{5mm}`, `\fontsize{10}{12}` (no `\selectfont` in the class), `\raggedright`, `\vspace{3mm}`; `$^n$` marks and commas are content |
| ORCID icon [sample] | template:14; cls:183 | `meta.hyperref`, `fig.graphicx` | `\orcid{id}` = `\href{https://orcid.org/#1}{\includegraphics[width=8pt]{orcid}}`; orcid.pdf shipped |
| affiliations [sample] | template:16,18,20; cls:108-110 | `front.class-native`, `font.size-commands`, `sp.ragged` | `\fontsize{8}{10}\selectfont\raggedright`, one `\affil` per line |
| e-mail [sample] | template:22; cls:112-114 | `front.class-native`, `sp.manual-space`, `font.size-commands`, `mark.kernel` | `\vspace*{12pt}`, 8/10, `\bfseries` label "E-mail:", `\vspace{3mm}` |
| keywords [sample] | template:24; cls:116-118 | `abs.keywords`, `front.class-native` | `\fontsize{8}{10}`, `\raggedright`, `\bfseries` label "Keywords:" |
| abstract [sample] | template:26-28; cls:120-124 | `abs.class-native`, `sp.manual-space`, `sp.rule`, `font.size-commands`, `mark.kernel` | `\vspace{16pt plus3pt minus3pt}`, grey `\hrule`, heading `\noindent\fontsize{11}{12}\selectfont\bfseries Abstract` then `\\`, body `\rm\raggedright` (the 11/12 size is not closed, so it carries into the body: my reading), end `\vspace{3mm}` and grey `\hrule` |
| headings [class] | template:30,35,38; cls:129-140 | `head.kernel`, `head.titlesec`, `font.size-commands`, `mark.kernel` | `\@startsection` with beforeskip `-3.25ex plus -1ex minus -.2ex` for all three; afterskip `1sp` (section, subsection), `-1em plus .2em` (subsubsection, run-in); styles `\normalsize\bfseries\raggedright`, `\normalsize\itshape\raggedright`, `\normalsize\itshape`; indent 0. Reduction: `\titleformat` and `\titlespacing`, subsubsection `[runin]` |
| heading numbering [class] | cls:129-140 (no change) | `num.secnumdepth` | article defaults (`secnumdepth`=3, arabic, `\quad` after the number) |
| back-matter sections [sample] | template:71-82,85; cls:145-163 | `front.class-native`, `head.kernel` | each command is `\section*` titled in turn Acknowledgments, Funding, Data availability, Author contributions, Supplementary data, then the text; all but `\suppdata` print "Removed for anonymity" under `anonymous`; sample ends with `\section*{References}` (85), left empty |
| figure [sample] | template:41-46 | `fig.graphicx` | `figure`, `\centering`, `\includegraphics[width=0.5\textwidth]{figure1}`, `\label{fig1}` |
| captions [class] | template:44,50; cls:167-175 | `cap.kernel`, `cap.caption` | class `\@makecaption`: `\fontsize{8}{10}`, label bold followed by a period, caption set `\raggedright` when longer than a line, centred when it fits on one line; `\abovecaptionskip` and `\belowcaptionskip` kernel values. Reduction: `\captionsetup{labelfont=bf, labelsep=period, font={fontsize 8/10}, justification=raggedright, singlelinecheck=true}`. Table caption sits above the tabular, figure caption below (author's order, template:41-62) |
| table [sample] | template:49-62 | `tbl.tabular`, `font.size-commands` | `table`, `\centering`, `tabular{l c c c}`, `\hline` x4; the class wraps every `\tabular` in `\fontsize{8}{10}\selectfont` (cls:178-179) |
| cross-references [sample] | template:36,45,61 | `xref.kernel`, `meta.hyperref` | `\label`, `\ref`; link colour from hyperref above |
| external links [sample] | template:31,44 | `meta.hyperref` | `\href{url}{text}` in running text and in a caption |
| fonts [class] | cls (no font package) | `font.size-commands`, `mark.kernel` | no font package, so kernel Computer Modern; sans only through `\sf` and `\textsf` (title, article type, header); old two-letter switches `\sf \it \bf \rm` beside `\bfseries \itshape` |
| language, bibliography, lists, math, theorems, code | not in the sample or the class | none | no `babel`, no `\bibliography` or `thebibliography` (the References heading is empty, template:85), no list, equation, theorem or code construct, and the class loads no package for them |

## Bespoke code
Nothing in the sample is zip-local: the template has no preamble and no `\newcommand` (template:3-8). The macros below sit inside the official class.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| iopjournal.cls as a whole | cls:1-184 | n/a, published (IOP's official kit, W1) | `class.iopjournal`; emitter writes `\documentclass{iopjournal}` |
| `\newif\if@anonymous`, option `anonymous`, and the `\if@anonymous ... \else #1 \fi` wrappers | cls:42-44,105,109,113,147,151,155,159 | not counted: inside the published class; the conditional that drives what is printed would be irreducible if the class were zip-local | the class option `anonymous` is the parameter; the sample does not use it |
| `\renewcommand{\title}`, `\author`, new `\affil \email \keywords` (immediate typesetting, no `\maketitle`) | cls:98-118 | yes | kernel groups of `\fontsize`, `\raggedright`, `\textsf`, `\vspace`, `\suppressfloats` (rows above) |
| `\articletype` with `\reversemarginpar` and `\marginpar` block | cls:93-96 | yes | `note.marginpar` + `sp.rule` + `sp.manual-space` + `font.size-commands`; the journal name, Crossmark and RECEIVED/REVISED text are placeholders |
| `\renewcommand\section` family via `\@startsection` | cls:129-140 | yes | the kernel's own mechanism (`head.kernel`); equal to `head.titlesec` `\titleformat`/`\titlespacing` |
| `\renewcommand{\@makecaption}` with `\sbox\@tempboxa` width test | cls:167-175 | yes | `cap.caption` with `singlelinecheck=true` (centre one-liners), `justification=raggedright`, `labelsep=period`, `labelfont=bf`, 8/10 |
| `\let\oldtabular\tabular` wrapper | cls:178-179 | yes | `\fontsize{8}{10}\selectfont` as a body wrapper before each `tabular` |
| `\renewcommand{\headrule}` and `\footrule` (use `\if@fancyplain`, `\@height`, `\@width`, `\footruleskip`) | cls:84-89 | yes | `hf.fancyhdr` documented rule hook with `\color{gray}`; widths 0.5pt |
| `\renewenvironment{abstract}` | cls:120-124 | yes | `abs.class-native`; kernel `\vspace`, grey `\hrule`, `\fontsize`, `\bfseries` |
| `\ack \funding \data \roles \suppdata` | cls:145-163 | yes | `\section*` plus text; the `anonymous` branch is the only logic |
| `\orcid` | cls:183 | yes | `\href` + `\includegraphics[width=8pt]{orcid}` alias (`meta.hyperref`, `fig.graphicx`) |

## Content-opaque
- Included artwork: figure1.pdf (template:43), orcid.pdf (cls:183), both shipped.
- Table data (template:52-60), the filler text in every argument, the `\LaTeX` and `\href` examples in running text (31,36,44), the `{\tt \textbackslash begin\{table\}...}` note in the table caption (50).
- Placeholder text fixed inside the class: "Journal Name" (cls:93), header "IOP Publishing / Journal vv (yyyy) aaaaaa" and "Author et al" (cls:77,79), "Crossmark", "RECEIVED / REVISED dd Month yyyy" (cls:96). They are text, not layout; a per-journal build would replace them.

## Lib changes
- New ways proposed: none (`class.iopjournal` is a class way and needs no proposal; its native vocabulary is recorded under "Class setting").
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
