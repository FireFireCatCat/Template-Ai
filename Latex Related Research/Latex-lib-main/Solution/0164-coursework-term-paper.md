yes

# 0164-coursework-term-paper: Coursework Term Paper

- Unverified: read from the source, not compiled.
- Source: Source/0164-coursework-term-paper/ (origin: https://latextemplates.com/downloads/coursework-term-paper.zip; licence: MIT)
- Kind: assignment (a short philosophy essay with a one-line byline "author, date, for course"; the manifest hint said report)
- Lib: v3
- Engine: pdfLaTeX-compatible (class and style branch on `\ifPDFTeX` / `\ifXeTeX`; the XeTeX/LuaTeX branch only swaps in `fontspec`: coursework.sty:111-137)
- Look carried by: zip-local (page, header/footer and title block in term-paper.cls; theorem/box/list looks in coursework.sty; the sample's own preamble only adds biblatex)
- Class origin: zip-local (`term-paper.cls` and `coursework.sty` are neither on CTAN nor an official release: ctan.org/pkg/term-paper and ctan.org/pkg/coursework are both 404; the zip is from latextemplates.com)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
Yes, with two small proposals. `term-paper.cls` is `\LoadClass[letterpaper,10pt]{article}` plus `geometry`, a `fancyhdr` page style and a redefined `\maketitle` that stores title, author, date and course in expl3 token lists; nothing in it computes layout, so it reduces to `class.article` + `page.geometry` + `hf.fancyhdr` + `front.titling`. `coursework.sty` loads published packages and declares theorem styles, tcolorbox wrappers and list environments; each is a composition of lib ways. The only tool-dependent packages (`minted`, `circuitikz`, `chemfig`) are loaded behind the `code` and `diagram` class options, which the sample does not pass, so the unconditional-load ruling does not apply. The weakest reductions are the spacing of the redefined `proof` and the `\parshape` in `subproof` (see Bespoke code); both are length parameters of lib ways, written down below, but only approximated, and none of it was compiled.

## Blockers
none

(Recorded, not blocking: `EXTERNAL/package` `minted` + `algorithm` + `algpseudocode` if the `code` option is selected (coursework.sty:72-98); content packages `tikz` `pgfplots` `circuitikz` `chemfig` if the `diagram` option is selected (coursework.sty:100-108). The sample selects neither: term-paper.cls:63-64 only set the option strings, main.tex:1 passes no options.)

## Class setting
- Class: `class.article` options: `letterpaper`, `10pt` (term-paper.cls:71, loaded by the zip-local class; every other option falls through to article, term-paper.cls:66). The zip-local class options `cover` (term-paper.cls:62; sets a flag that is never read, grep finds it only at :54, :58, :62), `code`, `diagram` (term-paper.cls:63-64) are not used by main.tex.
- Class-native vocabulary used: kernel `\title`, `\author` (redefined by the class to fill token lists, term-paper.cls:44,46), zip-local `\course` and `\due` (term-paper.cls:50,48; `\date` is an alias of `\due`, :49), `\section`, `\emph`, biblatex `\parencite` and `\printbibliography`. `\maketitle` is not called in main.tex: the class calls it at `\AtBeginDocument` (term-paper.cls:154-158).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | term-paper.cls:71; main.tex:1 | `class.article` | via zip-local wrapper: `letterpaper`, `10pt` |
| paper and base size | term-paper.cls:71 | `page.class-options` | `letterpaper`, `10pt` |
| page geometry | term-paper.cls:137-146 | `page.geometry` | letterpaper, top=1.45in, bottom=1.35in, inner=1.9in, outer=1.9in, marginparwidth=1.4in, marginparsep=0.25in, footnotesep=1cm |
| running head/foot | term-paper.cls:84, 91-116 | `hf.fancyhdr` | `\fancypagestyle{normal}`: headrulewidth=0pt; head C = title (pdf branch: `\lsstyle\footnotesize\MakeTextUppercase`; XeTeX branch: `\scshape\MakeTextLowercase`); foot L = `\footnotesize\thepage`; foot R = author, due date in `\footnotesize\scshape`; head L, R and foot C empty |
| page style switch | term-paper.cls:121, 156 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` on the title page, `\pagestyle{normal}` after it |
| title block | term-paper.cls:39-41, 119-131, 154-155 | `front.titling` (+ `front.maketitle`) | `\pretitle`/`\posttitle` = flushleft, `\LARGE\bfseries\sffamily`; author field = byline `\large` of lower-cased author, due date, `\small\textit{for}`, lower-cased course in `\scshape`; `\postauthor` ends flushleft and adds `\vspace*{4ex}`; `\date{}` empty; `\maketitle` called first in the body |
| case of title and byline text | term-paper.cls:40, 85, 99, 101 | `mark.case` | `\MakeTextLowercase` (byline), `\MakeTextUppercase` (running head, pdf branch) |
| small caps, bold, sans, italic | term-paper.cls:40, 108, 124 | `mark.kernel` | `\scshape`, `\bfseries`, `\sffamily`, `\textit` |
| font sizes | term-paper.cls:40, 95, 101, 124 | `font.size-commands` | `\large`, `\small`, `\footnotesize`, `\LARGE` |
| first paragraph unindented | term-paper.cls:157 | `sp.lengths` | `\noindent` once after the title (a one-paragraph `\parindent` override; closest home, same paragraph-indent family) |
| letter-spacing | coursework.sty:114, 127, 129; term-paper.cls:101, 107 | `sp.microtype` | `letterspace=20` (pdfTeX) or 100 (LuaTeX), `\lsstyle` in head and foot |
| text font, pdf branch | coursework.sty:112-115 | `font.fontenc-t1`, `font.lmodern` | `inputenc utf8`, `fontenc T1`, `lmodern` |
| text font, XeTeX/LuaTeX branch | coursework.sty:119, 126-137 | `font.fontspec` | `no-math`; `\renewfontfamily\ipafont{#1}` in `\setipafont` |
| sectioning, numbering | main.tex:23, 43, 68, 89 | `head.kernel` | article defaults: no `\titleformat`, `secnumdepth` or counter change anywhere in the zip |
| emphasis | main.tex:30, 47 | `mark.kernel` | `\emph` |
| abstract, contents, lists, floats in the sample | main.tex | none used | the sample has no abstract, toc, list, figure, table or code |
| bibliography | main.tex:8-9, 99 | `bib.biblatex-bibtex` | `style=authoryear`, `backend=bibtex`, `\addbibresource{refs.bib}`, `\printbibliography` |
| citations | main.tex:15, 64 | `bib.biblatex-bibtex` | `\parencite{strathern1997}`, `\parencite{ashby1956}` |
| links and PDF options | coursework.sty:39, 154-159; term-paper.cls:134 | `meta.hyperref` | sty sets `colorlinks=true` with link/cite red and url blue; class overrides `colorlinks=false` (net: uncoloured) |
| footnotes | term-paper.cls:88, 149; coursework.sty:277 | `fn.kernel`, `fn.footmisc` | `footmisc` with no options; class restores the kernel `\footnote` (`\let\footnote\oldfootnote`), so the margin footnote of coursework.sty:277-289 is not active here |
| margin notes | coursework.sty:44, 269-275 | `note.marginnote` | `noadjust`; `\note[offset]{text}` = `\marginnote{\footnotesize\textit{..}}[offset]` |
| widow/orphan control | coursework.sty:45 | `sp.penalties` | `\usepackage[all]{nowidow}` |
| float flow | term-paper.cls:86 | `pg.afterpage` | `afterpage`, no options |
| colours | coursework.sty:40, 148-152, 407-414 | `color.xcolor` | `table`, `dvipsnames`; `linkblue` `linkgold` `linkred` `covergrey` (HTML), `background*`/`border*` gold, grey, red, green (RGB) |
| indented definition blocks | coursework.sty:42, 437-485 | `page.adjustwidth` | `adjustwidth{1cm}{1cm}` around `definition`, `notation`, `abuse`; `\vspace*{-\baselineskip}` (`sp.manual-space`) |
| boxed theorem-likes | coursework.sty:43, 416-434, 487-597 | `box.tcolorbox` | libraries `breakable,skins,xparse`; `edgebox`: boxrule=0.3pt, boxsep=0.4cm, sharp corners, before=`\par\vskip 7pt`, colframe/colback from the colour pairs; `flagbox`: boxrule=0pt, leftrule=4pt, same else |
| theorem styles | coursework.sty:59, 355-371 | `thm.thmtools` | `lemma` (bold head, italic body, spaceabove=0.5\baselineskip), `remark` (small sans, headpunct `\hspace{5pt}---`, postheadspace=5pt), `definition` (bold head, upright body) |
| theorem declarations | coursework.sty:376-403 | `thm.thmtools` | `\declaretheorem` with `style`, `numberwithin=section`, `sibling=lemma`, `numbered=no`, `name`/`title`, `postheadhook=\leavevmode` for lemma, theorem, corollary, conjecture, proposition, definition, notation, abuse, problem, exercise, example, remark, warning, claim, question (starred variants unnumbered) |
| proof, QED symbol | coursework.sty:57, 260-266, 601-637 | `thm.amsthm` | `\qedsymbol` = `$\blacksquare$` (pdf) or U+220E (XeTeX); proof, subproof, solution: see Bespoke code |
| lists | coursework.sty:50, 292-308, 650-685 | `list.enumitem` | `inline`; `parts`: `label=\textup{(\alph*)}`, labelwidth=4.5em, labelsep=0.5em, itemsep=0ex; `problems`: `label=\textbf{Problem~\arabic*.}`, `wide`, `labelwidth=!`, `labelindent=0pt` |
| tables | coursework.sty:40, 51-52 | `tbl.booktabs`, `tbl.tabularx`, `tbl.colortbl` | load-only; `xcolor[table]` |
| figures | coursework.sty:41 | `fig.graphicx` | load-only |
| captions | coursework.sty:53 | `cap.caption` | `labelfont=bf` |
| spacing | coursework.sty:47, 140 | `sp.setspace`, `sp.linespread` | `setspace` load-only; `\tightspacing` = `\baselinestretch` 0.8 |
| length arithmetic | coursework.sty:46, 621 | `sp.lengths` | `calc` (`\widthof`) used by `subproof` |
| maths packages | coursework.sty:56-61, 64-66 | `math.amsmath`, `math.mathtools`, `math.amssymb`, `math.physics`, `mark.siunitx` | load-only; `stmaryrd` is filed under `math.amssymb` (math symbol font family) and `tensor` under `math.physics` (notation helper family), closest homes, neither used by the sample |
| operators | coursework.sty:209-233 | `math.amsmath` | `\DeclareMathOperator{\Hom}{\collection{Hom}}` and 15 more (`Aut Inn Syl Gal Mat GL SL lcm cis id Char Set Group Grp Vect Ab Top`) |
| code, only if `code` option | coursework.sty:72-98 | `code.minted`, `alg.algorithmicx` | `minted` (`\usemintedstyle{tango}`), `algorithm`, `algpseudocode`; **EXTERNAL when selected**; not selected here |
| diagrams, only if `diagram` option | coursework.sty:100-108 | `art.tikz`, `art.content-package` | `tikz`, `pgfplots` (compat 1.16), `circuitikz`, `chemfig`; content, not selected here |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| expl3 metadata store (`\g_pset_*_tl`, `\tl_gset:Nn`, `\tl_if_empty:NF`) | term-paper.cls:28-51, 109-114 | yes | data storage only; values are known at emit time, so the emitter writes the strings into `\author{..}` and the fancyhdr fields and drops the empty-field tests |
| `\RenewDocumentCommand\title/\author/\date`, `\assignment`, `\name`, `\due`, `\course`, `\byline` | term-paper.cls:44-51 | yes | aliases that fill the store; map to kernel `\title` `\author` `\date` plus the byline string (see title block row) |
| redefined `\maketitle` + `\AtBeginDocument{\maketitle\pagestyle{normal}\noindent}` | term-paper.cls:119-131, 154-158 | yes | `front.titling` `\pretitle` `\posttitle` `\preauthor` `\postauthor` `\predate` `\postdate`, then `\thispagestyle{empty}`; body starts with `\maketitle`, `\pagestyle{normal}`, `\noindent`. No `\@maketitle` internals are touched |
| engine branches `\ifXeTeX`, `\ifPDFTeX` | term-paper.cls:98-102, 107; coursework.sty:90, 111-137, 261-265 | yes | the emitter picks the branch for its engine (pdfTeX: `\lsstyle` + uppercase head, `inputenc`/`fontenc`/`lmodern`) |
| never-read flags and log filters: `cover` option, `nothmnum` option, colour `covergrey`, `\WarningFilter` lines (`silence`) | term-paper.cls:54, 58, 62; coursework.sty:23-30, 35, 142-145, 152 | yes | no printed effect (grep: the flags are set but never read); omitted |
| option plumbing (`\DeclareOption*`, `\PassOptionsToClass`, list of options passed to `coursework`) | term-paper.cls:62-78; coursework.sty:28-32 | yes | the emitter writes `\documentclass[...]{article}` and the package list directly |
| XeTeX-only constant `\edef\marginnotetextwidth{11.8966390917cm}` | coursework.sty:489-491, 505-507, 521-523 | yes | outside the pdfTeX branch, omitted; under XeTeX it is a length assignment tuned to this geometry |
| `\footnote` override with `cfootnote` counter, hyperlinks and margin text | coursework.sty:277-289 | yes | not active here (term-paper.cls:149 restores the kernel footnote); as written it is `num.counters` + `xref.hyperref` (`\hyperlink`, `\hypertarget`) + `note.marginnote` |
| `\note` | coursework.sty:269-275 | yes | `note.marginnote` call, as in the table |
| `definition`, `notation`, `abuse` wrappers | coursework.sty:437-485 | yes | body wrapper: `adjustwidth{1cm}{1cm}`, `\vspace*{-\baselineskip}`, the thmtools environment, and when a title is given `\leavevmode\note{title}\leavevmode\ignorespaces`; the `\IfValueTF` test is resolved at emit time |
| `problem`, `exercise`, `example`, `remark`, `warning`, `claim`, `question` wrappers (and starred) | coursework.sty:487-597 | yes | body wrapper: `edgebox` or `flagbox` (tcolorbox, colour pair by name) around the thmtools environment; `\setlength{\parindent}{0.5cm}` inside edgebox (`sp.lengths`) |
| `edgebox`, `flagbox` | coursework.sty:416-434 | yes | `\DeclareTColorBox` with `box.tcolorbox` keys; `#1` only picks a colour pair |
| redefined `proof` (copy of the amsthm body with `\topsep0.5\baselineskip`, `\partopsep0pt`, `\vspace{-0.25\baselineskip}` before and after) | coursework.sty:601-614 | yes, approximate | thmtools style with `headfont=\itshape`, `headpunct={.}`, `headindent=\labelsep`, `postheadspace=\labelsep`, `spaceabove`/`spacebelow` of 0.5\baselineskip less the 0.25\baselineskip pulls, `qed=\qedsymbol`; or amsthm's own `proof` between two `\vspace{-0.25\baselineskip}` (`sp.manual-space`). Only the stretch of `\topsep` (amsthm: 6pt plus 6pt) is lost; every difference is a length |
| `subproof` (`\parshape=1 \spleftmar ...`, `\widthof{\textit{Proof.~}}`, `\qedsymbol` = `$\square$`) | coursework.sty:617-632 | yes, approximate | `adjustwidth{w}{w}` with `w` = `\widthof{\textit{Proof.~}}` (`page.adjustwidth` + `sp.lengths`), `\renewcommand\qedsymbol{$\square$}` (`thm.amsthm`); `\parshape` shapes the first paragraph only, adjustwidth every paragraph of the proof, so it is a parameter-level approximation |
| `solution` | coursework.sty:635-637 | yes | `proof` with the name argument `Solution` |
| `parts` environment and `\part` redefinition (kernel `\part` turned into `\item`) | coursework.sty:292-308 | yes | `enumerate` with the enumitem keys listed above; `\item` or `\item\label{..}` (`xref.kernel`) |
| `problems` environment (`\let\problem\relax`, inner `\NewDocumentCommand\problem`, stored label string) | coursework.sty:648-685 | yes | inline `enumerate[label=\textbf{Problem~\arabic*.}, wide, labelwidth=!, labelindent=0pt]`; a titled item is `\item[\refstepcounter{enumi}\textbf{Problem~\number\value{enumi}~\textmd{(title)}.}]` (`num.counters`); the rebinding is only an alias for `\item` and is inlined |
| linguistics macros `\ipa`, `\phon`, `\allo`, `\orth`, `\lex`, `\lem`, `\den`, `\exref` | coursework.sty:163-188 | yes | aliases of `\textup{\normalfont\ipafont #1}` (`mark.kernel`; `\ipafont` is `\relax` on pdfTeX, a `fontspec` family on XeTeX) and `\ensuremath{...}` with `\llbracket` (stmaryrd); inlined. `\exref` calls `\getfullref`, which is not defined anywhere in the zip (grep); a latent error if called, not called by the sample |
| maths aliases: `\O`, `\field`, `\C \E \F \N \Q \R \Z`, `\collection`, `\map`, `\category`, arrows, relations (`\let\cong\equiv`, `\let\asymp\simeq`), `\floor`, `\normal`, `\charsg` | coursework.sty:193-258 | yes | aliases of `\mathbf`, `\mathrm`, `\mathsf`, `\mathcal`, `\lhook\joinrel\twoheadrightarrow`, `\left\lfloor`; notation inside equation content, inlined by the emitter |
| `\semicolon` (raw `\nobreak\mskip2mu\mathpunct{}\nonscript\mkern-\thinmuskip{;}\mskip6muplus1mu`) | coursework.sty:243-244 | yes | a fixed run of math-spacing glue inside equation content; the emitter writes the same glue where the model holds a semicolon in maths (content notation, not layout) |
| `\NewDocumentCommand\tightspacing` | coursework.sty:140 | yes | `\renewcommand{\baselinestretch}{0.8}` (`sp.linespread`) |

## Content-opaque
none in the sample. Option-gated, not selected: tikz/pgfplots/circuitikz/chemfig pictures (coursework.sty:100-108), minted listings (coursework.sty:72-98).

## Lib changes
- New ways proposed:
  - `mark.case` kernel `\MakeUppercase` / `\MakeLowercase` and the `textcase` package's `\MakeTextUppercase` / `\MakeTextLowercase` (term-paper.cls:40, 85, 99, 101), engine pdf, wraps a span of text and changes its case. W1: kernel commands and a CTAN package. W2: no code is edited; the choice is upper or lower and the wrapped text. W3: serves any title, byline, running head or caption. W4: a body or header-field wrapper, plus an optional `\usepackage{textcase}`. The lib has no case-change line (grep for case, textcase, MakeUppercase found nothing); `mark.kernel` is font switches only, and the rubric forbids stretching it.
  - `sp.penalties` `nowidow` package (coursework.sty:45), engine pdf: `\usepackage[all]{nowidow}` sets widow and club control for the document, with per-paragraph `\nowidow[n]` `\noclub[n]`. Read only from the one-line `\RequirePackage[all]{nowidow}`; the package source is not in the zip. W1: CTAN. W2: option values and counts. W3: any document. W4: a preamble line. Considered: `sp.penalties`, whose lib line names the raw TeX parameters (`\widowpenalty`, `\clubpenalty`), not a package with its own commands and options.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
