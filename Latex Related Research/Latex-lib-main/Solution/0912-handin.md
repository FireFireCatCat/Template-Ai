yes

# 0912-handin: handin (hand-in template for school exercise sheets)

- Unverified: read from the source, not compiled.
- Source: Source/0912-handin/ (origin: https://mirrors.ctan.org/macros/latex/contrib/handin.zip; licence: LPPL 1.3c)
- Kind: assignment (exercise-sheet hand-in: front page, problem headings, running head and foot)
- Lib: v6
- Engine: pdfLaTeX-compatible (inputenc utf8 and fontenc T1 at handin.sty:27-28, microtype `expansion` at :123-128 which needs pdfTeX or LuaTeX, no fontspec, no Lua)
- Look carried by: class (the published package `handin.sty` carries the front page, running head and foot, geometry, fonts, maths packages and the `\problem` `\pproblem` headings; example.tex only sets field strings and the page strings; no zip-local look)
- Class origin: ctan
- Main file: example.tex (other samples: handin-doc.tex, the package manual; see Verdict for why it is outside the verdict)
- Read: main yes, zip-local classes and styles all (handin.sty 1-296 and handin-doc.tex 1-330 in full; README.txt read; layout.pdf opened as a picture of the front page; example.pdf and handin-doc.pdf are compiled output and were not opened)

## Verdict
Yes. One published package, `handin`, carries the whole look: it is on CTAN and in TeX Live and MiKTeX (W1; ctan.org/pkg/handin read once: "Light weight template for creating school submissions", A. S. Strauman, v0.1.1, LPPL 1.3c; the zip is that release, same version at handin.sty:1-2 and README.txt:21). It is driven by one boolean option, `\handinsetup` keys, field strings and two body commands (W2), serves any course assignment (W3), and prints as one `\usepackage` line, field commands and heading commands (W4). The sample defines no macro, length, counter or environment of its own, so the sample holds no bespoke code, the same reading as `exam.schooldocs`, a CTAN package accepted as a way. Caveat for a re-reading that counts handin.sty as zip-local: two internals do not reduce to lib ways, a per-page flag set from a hooked `\@outputpage` (handin.sty:32-53, :77-83) and a `\vadjust` plus `\llap` box that hangs part-problem labels in the margin (:62-69); they would be `BESPOKE/package` then, and under W1 they are inside a published package, so not blockers. The manual handin-doc.tex documents the package with the tcolorbox documentation library and local changelog code (handin-doc.tex:17, :50-72); I treat it as documentation outside the verdict (the manifest main is example.tex); if it were scored as a sample it needs its own reading (`tcolorbox[all]` may load the `minted` library, not checked).

## Blockers
none (under W1; see the caveat in Verdict and the first two rows of Bespoke code)

## Class setting
- Class: `class.article` options: none (example.tex:1); kernel class, not in the zip, source not read.
- Class-native vocabulary used: `\title` `\author` `\maketitle` (wrapped or replaced by handin, handin.sty:224-233, :241-242), display maths `\[ \]` (example.tex:20). No `abstract`, no `\section`, no `\tableofcontents`: headings come from handin's `\problem`.
- "Class origin" and "Look carried by" above refer to the look-carrying published style `handin.sty` (in the zip, on CTAN); the document class `article` is tex-distribution-unbundled.

## Component map
Rows without "(in package)" are what the sample itself writes. Rows marked "(in package)" are set inside handin.sty; the emitter writes none of them (the package does), they give the decomposition so the file can be re-read under another definition.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example.tex:1 | `class.article` | no options |
| language | example.tex:2 (comment :3) | `lang.babel` | english (handin's strings also exist for german and norsk, handin.sty:178-189) |
| exercise-sheet package | example.tex:4; handin.sty:21-26 | `NEW:exam.handin` | `\usepackage{handin}`, option `light` not given (key `light/.is if`, :23-25) |
| title and author | example.tex:6-7; handin.sty:224-233 | `front.maketitle` | `\title`, `\author`; handin keeps copies `\thetitle` `\theauthor` for the head and foot |
| course fields | example.tex:8-10; handin.sty:234-239 | `NEW:exam.handin` | strings `\coursename{TST-101}` `\coursetitle{Test course}` `\institute{...}` (settable fields; `\logo` not given) |
| foot text and page count | example.tex:12-13; handin.sty:238-239, :176-177 | `NEW:exam.handin` | strings `\pagetext{Page \thepage~of \pageref{LastPage}}` `\containspages{Contains \pageref{LastPage} pages, front page included}` (the sample sets the defaults) |
| page reference | example.tex:12-13 | `xref.kernel` | `\pageref{LastPage}` |
| front page | example.tex:16; handin.sty:242-268 | `NEW:exam.handin` | `\maketitle` with default `title style=wholepage` (:144) |
| problem heading | example.tex:17; handin.sty:84-101 | `NEW:exam.handin` | `\problem{1}`: header "Problem 1" (:139, :174), TOC entry, indent of the rest of the document |
| part-problem label | example.tex:18; handin.sty:102-110 | `NEW:exam.handin` | `\pproblem{a}`: label "a)" or "1a)" (:140), hung in the margin |
| display maths | example.tex:20 | `math.kernel` | `\[ \]` with `\oiint\limits_{S}`, `\vec`, `\mathrm`, `\frac` (the equation is content) |
| text in maths | example.tex:20 | `math.amsmath` | `\text{enc}` comes from the amsmath that handin loads (handin.sty:114) |
| integral symbol (in package) | example.tex:20; handin.sty:117 | `math.amssymb` | `\oiint` from package `esint` (extended integral signs), a symbol-font package of the same type as `amsfonts`; W1 for `esint` rests on my knowledge, its CTAN page was not read |
| page geometry (in package) | handin.sty:113, :282 | `page.geometry` | paper=a4paper, bottom=3cm, top=3cm, footnotesep=3cm |
| running head and foot (in package) | handin.sty:112, :283, :286-295 | `hf.fancyhdr` | `\pagestyle{fancy}`; lhead `\@coursename~--~\thetitle`; rhead `\today`; lfoot `\theauthor`; rfoot `\@pagetext`; cfoot empty; `\headrulewidth` .3pt; `\footrulewidth` .3pt; `\fancyheadoffset{\dimexpr\extramargins/2\relax}` |
| head width (in package) | handin.sty:18-19, :286 | `sp.lengths` | `\extramargins`=4em; `\addtolength\headwidth{\extramargins}` |
| page style of title page (in package) | handin.sty:244, :284 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` on the front page; `\thispagestyle{fancy}` appended to `\maketitle` for the next page |
| page X of Y (in package) | handin.sty:30, :177, :295 | `pgnum.lastpage` | `lastpage`; string "Page \thepage~of \pageref{LastPage}" |
| paragraph indent (in package) | handin.sty:285 | `sp.lengths` | `\parindent`=0pt |
| problem lengths (in package) | handin.sty:54-61 | `sp.lengths` | `\probleminset`=3em, `\problemheadermargin`=0em, `\partproblemheadermargin`=2em, `\fullproblemmargin`=`\dimexpr -\extramargins/2+\problemheadermargin\relax` |
| front page layout, wholepage (in package) | handin.sty:243-268 | `front.titlepage-env` | hand-laid with three `center` blocks, no `titlepage` environment; title `\Large` (with logo, :251) or `\Huge` (without, :253); `\textbf{course -- course title}\\[1cm]`, `\textbf{author}\\[1cm]`, `\textbf{\today}\\[3cm]` (:258-260); `\vfill`, contains-pages string `\\[0.5cm]`, `\textsc{institute}` (:263-265); `\clearpage` (:267) |
| front page layout, small (in package) | handin.sty:269-281 | `front.titlepage-env` | logo, `\huge\textbf{course -- title \\[0.3cm] title}`, `\large author`; chosen by `\handinsetup{title style=small}` (:151-154), unused by the sample |
| front page spacing (in package) | handin.sty:247-265 | `sp.manual-space` | `\\[1.5cm]` `\\[1cm]` `\\[3cm]` `\\[0.5cm]` `\vfill` |
| front page type (in package) | handin.sty:251-265, :99 | `font.size-commands` | `\Large` `\Huge` `\huge` `\large`; `\normalfont\Large\bfseries` for problem headers |
| front page marks (in package) | handin.sty:258-265 | `mark.kernel` | `\textbf`, `\textsc` |
| page end (in package) | handin.sty:267 | `pg.break` | `\clearpage` |
| front page logo (in package) | handin.sty:29, :250 | `fig.graphicx` | `\includegraphics[width=<logo width>\textwidth]`, `logo width`=0.4 (:143); only if `\logo{file}` is given, not in the sample |
| problem header box (in package) | handin.sty:98-100 | `sp.manual-space` | `\vbox to 0pt{\hspace*{\fullproblemmargin}{\normalfont\Large\bfseries <problem header>}}` then `\vspace*{1.5\baselineskip}` |
| problem indent (in package) | handin.sty:71-72 | `list.scrextend` | `addmargin{\probleminset}` opened at the first `\problem`, closed by `\preto\@enddocumenthook` |
| contents entries (in package) | handin.sty:87, :105 | `toc.kernel` | `\addcontentsline{toc}{section}{...}` and `{subsection}`; the sample has no `\tableofcontents`, so nothing is printed |
| string table (in package) | handin.sty:119, :166-189 | `lang.translator` | per-language strings for Problem, problem, pagetext, containspages chosen by `\IfLanguageName` of `iflang` (reduces to literals, see Bespoke code) |
| input and font encoding (in package) | handin.sty:27-28 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| Latin Modern (in package) | handin.sty:129-134 | `font.lmodern` | package `cfr-lm` (Latin Modern support; its CTAN page was not read in this pass): rm and sf `{oldstyle=false,proportional=true}`, tt `{oldstyle=false,proportional=true,variable=true}`, `qt=false` |
| microtype (in package) | handin.sty:123-128 | `sp.microtype` | `babel=true`, `expansion=alltext`, `protrusion=alltext-nott`, `final` |
| maths packages (in package) | handin.sty:115-116 | `math.mathtools`, `math.bm` | load-only, no options (`amsmath` at :114 is the row above) |

Not loaded when the option `light` is true: fancyhdr, geometry, amsmath, mathtools, bm, esint, microtype, cfr-lm and the new `\maketitle` (handin.sty:111, :122, :135, :240, :296). The sample uses the default, so all of them load. graphicx, lastpage, scrextend, inputenc, fontenc, iflang, etoolbox, pgfkeys and pgfopts load in both modes (:21, :27-31, :119-121).

## Bespoke code
No bespoke code in the sample (example.tex defines nothing). The rows below are macros inside the published `handin.sty`, read independently of W1 so the result can be re-read if handin.sty were counted as zip-local.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| Per-page hook wrapped round `\@outputpage` and `\@begindvi`, resets `\@ProblemOnThisPage` each page | handin.sty:32-53, :77-83 | No: BESPOKE/package under that reading | Redefines kernel output internals; the flag decides at pagination time whether `\currentProblemIfNewPage` prints the problem number (:81-83), a label that depends on where the page breaks fall. No lib way expresses it. |
| Margin label `\@atMargin` and `\@domark` | handin.sty:62-69, :109 | No: BESPOKE/package under that reading | `\strut\vadjust{\hbox to w{\vbox to 0pt{\kern-\dp\strutbox\smash{\llap{label}}\vss}}}`, hand-built box and glue; not `note.marginnote` (own placement), not `sp.manual-space` alone. |
| `\problem` and `\pproblem` headers, TOC lines | handin.sty:84-110 | Yes except the two rows above | Zero-height `\vbox` with `\hspace*`, `\vspace*{1.5\baselineskip}`, `\Large\bfseries` text, `\addcontentsline`: `sp.manual-space`, `font.size-commands`, `mark.kernel`, `toc.kernel`. |
| `\AtFirstProblem` addmargin opened and closed through `\@enddocumenthook` | handin.sty:70-73 | Yes in effect | A body wrapper `addmargin{3em}` (`list.scrextend`) from the first problem node to the end of the document. |
| `\settable` field generator and `\title` `\author` wrappers | handin.sty:190-239 | Yes | Each field is a string known when the emitter runs; it writes the value in place. The `\ifset@logo` branch (:250-254, :274-276) is chosen at emit time; `\thetitle` `\theauthor` become literal strings in the head and foot. |
| Translation table `\set@tr` with `\IfLanguageName` | handin.sty:166-189 | Yes | Literal strings per language (Problem, Oppgave, Aufgabe; page and page-count strings) chosen at emit time, or `lang.translator`. The sample overrides the page strings anyway (example.tex:12-13). |
| `light` option through `pgfopts` and `\ifhandin@islight` | handin.sty:21-26, :111, :122, :240 | Yes | A boolean fixed at emit time; false emits everything, true skips the listed packages. |
| `\@maketitle` set to `\handin@opt@titlestyle` | handin.sty:241-242 | Yes | A hand-laid front page (`front.titlepage-env` rows above); no output routine involved. |
| pgfkeys `\handinsetup` store keys | handin.sty:138-165 | Yes | Keys store macro text (problem header, part problem header, problem TOC, part problem TOC, logo width, title style); the sample never calls it, defaults substitute as literals. The `switches` family has a missing comma after `T/.initial` (:158), unused by the sample. |
| Manual machinery `\l@version` `\l@change` `\macrotable` `\chlogtable`, `\section` wrapped by `\needspace` | handin-doc.tex:46-47, :50-72, :95-98 | not scored | Documentation of the package, outside the verdict (see Verdict). |

## Content-opaque
- Display equation `\oiint\limits_{S}\vec E\cdot \mathrm{d}\vec{S}=\frac{Q_{\text{enc}}}{\varepsilon_0}` (example.tex:20), content.
- Logo image if `\logo{file}` were given (handin.sty:250): a shipped asset; the sample gives none (handin.sty:252 only warns).

## Lib changes
- New ways proposed: `NEW:exam.handin` (section doc-kind specific) | `handin` (CTAN `/macros/latex/contrib/handin`, TeX Live and MiKTeX, LPPL 1.3c; Andreas Storvik Strauman; v0.1.1 2018/07/22; pdfLaTeX-compatible): `\usepackage[light]{handin}`, preamble `\handinsetup{problem header, part problem header, problem TOC, part problem TOC, logo width, title style=wholepage|small}`, strings `\coursename` `\coursetitle` `\institute` `\logo` `\containspages` `\pagetext`, body `\problem[*]{n}` and `\pproblem[*]{x}`, front page through `\maketitle`; English, Norwegian and German strings by the babel language. W1: on CTAN and in TeX Live (ctan.org/pkg/handin read). W2: one boolean option, string and macro-text keys, strings, lengths set inside. W3: serves any assignment divided into exercises, not one course (handin.sty:17 "school papers that are divided in exercises"). W4: one `\usepackage` line, preamble field commands, and heading commands placed before a node's content. Considered `exam.questions` (the `worksheet` entry has an `exercise` environment; handin has numbered headings and a front page only, no environment or question bank) and `exam.schooldocs` (named page styles; handin has one fixed page style); neither covers it without stretching.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
