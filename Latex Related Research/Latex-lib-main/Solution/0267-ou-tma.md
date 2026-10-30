yes

# 0267-ou-tma: ou-tma (Open University Tutor Marked Assessment answer package)

- Unverified: read from the source, not compiled.
- Source: Source/0267-ou-tma/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ou-tma.zip; licence: lppl1.3c)
- Kind: assignment (manifest hint says exam; the sample is a student's worked answers to numbered questions, parts and sub-parts)
- Lib: v3
- Engine: pdfLaTeX-compatible
- Look carried by: mixed (the CTAN package `ou-tma`, source in ou-tma.dtx:407-909, sets page, header, numbering, title strings and maths macros on top of kernel `article`; the sample preamble adds only documentation noteboxes, SampleTMA.tex:19-38)
- Class origin: tex-distribution-unbundled (`article` is LaTeX base, not in the zip; the style `ou-tma` is on CTAN, ctan.org/pkg/ou-tma read, LPPL 1.3c, "A package to aid in the writing of Tutor Marked Assessments for the Open University", this zip is that release)
- Main file: SampleTMA.tex (other samples: none; ou-tma.dtx:22-50 is the driver of the package manual, not a template sample)
- Read: main yes (251 lines), zip-local classes and styles all (the style exists only as ou-tma.dtx, 913 lines, read in full; no .sty or .cls file is in the zip, ou-tma.ins read; ou-tma.pdf is the compiled manual, not read)

## Verdict
Yes, with one proposed way. The whole TMA look is one published CTAN package (`ou-tma`) loaded by `\usepackage[pdfbookmark,roman,cleveref]{ou-tma}` (SampleTMA.tex:3). It passes W1 to W4 as a doc-kind way like `inv.simpleinvoice` or `exam.schooldocs`, so its question, part and sub-part logic is loaded, not copied, and is not bespoke. Everything else it loads (geometry, fancyhdr, lastpage, amsthm, hyperref, cleveref, isodate) and everything in the sample preamble (tcolorbox, cancel) is an existing lib way. No artwork, no external tool. The yes rests on the W1 ruling: if `ou-tma` were treated as zip-local, its counter-override and same-line logic (ou-tma.dtx:763-791) would be irreducible.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `12pt` (SampleTMA.tex:1)
- Class-native vocabulary used: `\maketitle` (SampleTMA.tex:41), `\date` (SampleTMA.tex:15); no `abstract`, no `\section`.
- Package-native vocabulary of `ou-tma` used by the sample: `\myname` (:8), `\mypin` (:9), `\mycourse` (:13), `\mytma` (:14), `\setquestionstring` (:87), environment `question[n]` (:89, :194), `\qpart[n]` (:90, :123), `\qsubpart` (:124, :151), `\deriv` (:198, :222, :225), `\e` (:215, :244), `\nth` (:50). Declared but not used by the sample: `\setdate`, `\marginnote`, `\marginnotes`, `\vect`, `\ve`, `\dd`, `\ii`, number sets, `\comb`, `\perm`, operators, option `legacy`/`alph`.

## Component map
All paths relative to Source/0267-ou-tma/; `D` = ou-tma.dtx, `S` = SampleTMA.tex.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | S:1 | `class.article` | a4paper, 12pt |
| paper and type size | S:1 | `page.class-options` | a4paper, 12pt |
| TMA answer-document package | S:3, D:27-28 | `class.ou-tma` | options pdfbookmark, roman, cleveref (declared: alph default, legacy; D:641-655) |
| student and module identity | S:8-14, D:466-475 | `class.ou-tma` | `\myname{Peter McFarlane}`, `\mypin{A1234567}`, `\mycourse{\LaTeX 101}`, `\mytma{sample}` stored as expl3 token lists (D:427-440) |
| title block | D:483-484, S:41 | `front.maketitle` | `\title{\textbf{TMA: \course-\tma}}`, `\author{\textbf{\name\space\pin}}`, kernel article `\maketitle` |
| date | S:15, D:474-475, D:498 | `front.maketitle` | `\date{30 Sep, 2025}` overrides; package default `\setdate{\today}` |
| date format | D:522-523 | `front.datetime` | `isodate` (package is the parameter) option UKenglish, `\cleanlookdateon` (drops st/nd/rd/th) |
| page geometry | D:535-545 | `page.geometry` | headheight=10mm, headsep=5mm, bottom=25mm, footskip=15mm, left=30mm, right=30mm, marginparwidth=0mm, marginparsep=0mm, includemp |
| optional margin notes | D:557-565 | `note.marginpar`, `page.geometry` | `\marginnote{m}` is `\marginpar{m}`; `\marginnotes` re-sets marginparwidth=40mm, marginparsep=5mm, left=20mm, right=15mm (not used by sample) |
| header and footer | D:898-903 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, L `\textrm{\name\ \pin}`, C `\textrm{\course\ TMA-\tma}`, R `\textrm{Page \thepage\ of \tma@pageref{LastPage}}`, `\headrulewidth`=0pt |
| page X of Y | D:516, D:902, D:740 | `pgnum.lastpage` | `lastpage`; `\pageref*` when pdfbookmark is on |
| paragraph spacing | D:887-888 | `sp.lengths` | `\parindent`=0pt, `\parskip`=2ex plus 0.3ex minus 0.2ex |
| question block | D:763-772, S:89, S:194 | `class.ou-tma` | `question[n]`: "Q n" label in a right-aligned zero-width `\makebox` in the left margin (`\large`, `\hspace{0.3em}`), `\par\vspace{3em}` at the end |
| question label string | D:492-494, D:746, S:87 | `class.ou-tma` | `\setquestionstring{Question}` (default Q) |
| part and sub-part markers | D:774-791, S:90, S:123, S:124, S:151 | `class.ou-tma` | `\qpart[n]` "(i)" at `\makebox[0pt][r]` with `\hspace{1.5em}`; `\qsubpart[n]` "(a)" in `\hspace{-2em}\makebox[2em][l]`; same line as the part when it follows directly (D:788-789) |
| question, part, sub-part counters | D:581-587, D:629-630, D:702-708 | `num.counters` | `question`, `qpart[question]`, `qsubpart[qpart]`; `\thequestion` arabic; with option roman `\theqpart` roman and `\theqsubpart` alph (default alph/roman) |
| equation numbering | D:886 | `math.amsmath` | `\numberwithin{equation}{question}` |
| footnote marks | D:885 | `fn.kernel`, `num.counters` | `\thefootnote` is `\fnsymbol{footnote}` (no footnote in sample) |
| theorem-like statements | D:511, D:870-871 | `thm.amsthm`, `thm.kernel` | `\newtheorem{lemma}{Lemma}`, `\newtheorem{theorem}{Theorem}`, amsthm default plain style (not used in sample) |
| QED mark | D:872-875, S:121, S:149, S:185 | `thm.amsthm`, `font.icons` | `\qedsymbol` redefined to `\blacksmiley` (`wasysym`, D:512) |
| PDF metadata and link colour | D:710-723 | `meta.hyperref` | under pdfbookmark: `hyperref[pdfencoding=unicode,psdextra]`, `\hypersetup{colorlinks=true, linkcolor=blue, urlcolor=blue, pdfstartview=FitH, pdftitle, pdfauthor, pdfkeywords, pdfsubject}` |
| PDF bookmarks | D:739-743, D:766-767, D:777-778, D:786-787 | `meta.hyperref` | `\pdfbookmark[0/1/2]` per question, part, sub-part |
| automatic references | D:727-736, D:757-761 | `xref.cleveref` | `cleveref` after `hyperref`; `\crefname` question/part/section; `\refstepcounter` on the three counters |
| labels and equation refs in answers | S:168, S:175, S:178, S:197, S:217 | `xref.kernel`, `math.amsmath` | `\label`, `\ref`, `\eqref` |
| OU maths macros | D:802-851, S:198, S:215 | `class.ou-tma` | `\dd \e \ii \N \Z \Q \R \Complex \Rr \vect \ve \comb \perm \rect \deriv \pderiv \psderiv`, ten `\DeclareMathOperator` names (D:834-843), legacy `\vec` `\C` (D:854-860) |
| ordinal indicators | D:821-824, S:50 | `class.ou-tma` | `\st \nd \rd \nth` as `\textsuperscript` |
| maths packages loaded | D:509-514 | `math.amsmath`, `math.amssymb`, `thm.amsthm`, `font.icons`, `math.bm` | amsmath, amssymb, amsthm, wasysym, bm, upgreek (upright Greek filed under `math.bm`, a math alphabet package as parameter) |
| figures (loaded, unused) | D:515 | `fig.graphicx` | `graphicx`, no figure in sample |
| verbatim | D:518, S:55-67, S:78, S:191 | `code.verbatim` | `verbatim` package, `\verb` |
| displayed maths in answers | S:94, S:137-145, S:164, S:196 | `math.amsmath` | `gather*`, `gather` with `\notag`, `aligned`, `align`, `\intertext`, `equation` |
| noteboxes (documentation device) | S:19, S:25-38, S:46 | `box.tcolorbox` | `\tcbset{notebox/.style={colback=cyan!10, colframe=cyan!30, width=0.5\linewidth, arc=3mm, auto outer arc, boxrule=3pt, enhanced}}`, `\newtcolorbox{notebox}[1][]{notebox,#1,before=\begin{center},after=\end{center},}`; `[most]` option; the emitter can use the `skins` library that `enhanced` needs |
| strike-out in text | S:20, S:50 | `math.physics` | `cancel`, `\cancel{...}` |
| strike colour | S:21-22 | `color.xcolor` | `xcolor`, `\renewcommand{\CancelColor}{\color{red}}` |
| inline fbox and spacing | S:43, S:121 | `box.fancybox`, `sp.manual-space` | `\fbox{...}`, `\hfill`, `\\[1cm]` |
| list in sample | S:70-76 | `list.kernel` | `itemize` |
| emphasis and sans | S:48, S:72 | `mark.kernel` | `\textsf`, `\emph` |
| centring | S:190 | `sp.ragged` | `\centering` |
| page break | S:82 | `pg.break` | `\pagebreak` |
| support packages (internal to the way) | D:517, D:521 | `class.ou-tma` | `xifthen` (`\ifthenelse`) and `calc` (`#1-1` in `\setcounter`) serve the counter logic, not a look |
| manual driver (documentation, not the sample) | D:30-48 | `class.ltxdoc`, `dtx.doc`, `font.fontenc-t1`, `page.geometry`, `hf.fancyhdr` | `ltxdoc[a4paper,11pt]`, `fontenc[T1]`, `\EnableCrossrefs`, `\CodelineIndex`, `\DocInput`, `geometry{left=1mm,marginparwidth=40mm,marginparsep=1mm}`, fancyhdr L `ou-tma` R page; `\hfuzz`=15pt; `\hbadness` is a log threshold (no printed effect); considered: `dtxdescribe` (CTAN documentation helper, D:32, documentation only) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `ou-tma.sty` (generated by docstrip from ou-tma.dtx) | D:26-28, D:407-909, ou-tma.ins:42 | n/a, published (CTAN) so not bespoke (W1) | loaded as `class.ou-tma`; every other part is the existing ways in the map |
| `question`, `\qpart`, `\qsubpart` optional-number override and same-line test | D:763-791 | not reduced; published, loaded not copied | `\ifthenelse{#1>0}{\setcounter{..}{#1-1}}` (D:764, 775, 784) and `\ifthenelse{\value{qsubpart}>1}{\par}{}` (D:788-789) are counter-driven layout logic; they would be irreducible if an emitter had to copy them |
| option booleans, `\ProcessOptions` and `\typeout` log lines | D:605-663, D:671-692, D:702-744 | n/a, same package | `\DeclareOption` flags only; `\typeout` prints to the log, not the page |
| expl3 token-list constants | D:427-479 | n/a, same package | strings only (name, tma, course, pin, date); no layout computed |
| `notebox` (tcolorbox style and environment) | S:25-38 | yes | `box.tcolorbox`: `\tcbset` style plus `\newtcolorbox` with the keys in the map |
| `\CancelColor` redefinition | S:22 | yes | `color.xcolor`: one `\renewcommand` of the `cancel` colour hook to `\color{red}` |
| manual helpers `\ItemDescribeVariable`, `\stma`, `\TMA`, `\OU`, `\code`, `\main`, `\NewDocElement` | D:55-71, D:75-77, D:94-95 | yes (documentation only) | `\newcommand` aliases over `doc`/`dtxdescribe` calls and `dtx.doc` `\NewDocElement`; the else branch at D:62-66 (doc not loaded) is not taken under `ltxdoc` |
| `ou-tma.ins` (docstrip) | ou-tma.ins:19, ou-tma.ins:42, README.md:26 | n/a | plain TeX run by `pdflatex ou-tma.ins`, not an external tool; the `.sty` is not in the zip, so ship the CTAN `ou-tma.sty` or run the `.ins` (missing asset, noted) |

## Content-opaque
none (the sample has no figure, table or drawing; displayed equations in answers are content)

## Lib changes
- New ways proposed: `class.ou-tma` `ou-tma` (CTAN, LPPL 1.3c, pdfLaTeX): a Tutor Marked Assessment answer document: `\usepackage[alph|roman,cleveref,pdfbookmark,legacy]{ou-tma}`, strings `\myname` `\mypin` `\mycourse` `\mytma` `\setdate` `\setquestionstring`, body `question[n]`, `\qpart[n]`, `\qsubpart[n]`, OU maths macros; it fixes a geometry, a fancyhdr header and the question counters inside. W1: on CTAN (ctan.org/pkg/ou-tma read), this zip is the CTAN release. W2: behaviour set by the five options, string arguments and optional numbers, never by editing code (D:466-475, D:641-655, D:763-791). W3: serves any TMA answer document, not this sample (a doc-kind way, sibling of `exam.schooldocs` and `inv.simpleinvoice`). W4: preamble `\usepackage` line plus string commands, body wrappers `question` / `\qpart` / `\qsubpart`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
