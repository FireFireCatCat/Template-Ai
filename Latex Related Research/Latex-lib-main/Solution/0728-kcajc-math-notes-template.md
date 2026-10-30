yes

# 0728-kcajc-math-notes-template: Math Notes Template (kcajc)

- Unverified: read from the source, not compiled.
- Source: Source/0728-kcajc-math-notes-template/ (origin: https://codeload.github.com/kcajc/math-notes-template/zip/refs/heads/main; licence: not established)
- Kind: book (course lecture notes: title page, contents, chapters, coloured theorem boxes)
- Lib: v5
- Engine: pdfLaTeX-compatible (`inputenc` utf8 at main.tex:10; no `fontspec`, no Lua; `tcolorbox` libraries `theorems,skins,breakable` at main.tex:16 need no external tool)
- Look carried by: preamble (no zip-local class or style; the look is the main.tex preamble plus the two files it `\input`s, theorems.tex and commands.tex, which sit in the preamble)
- Class origin: tex-distribution-unbundled (kernel `book`, not bundled in the zip)
- Main file: main.tex (other samples: other-templates/minimal.tex, other-templates/math-assignment-template.tex)
- Read: main yes (117 lines), zip-local classes and styles none present (no .cls/.sty/.def/.cfg in the zip); theorems.tex (309 lines) and commands.tex (2 lines) read in full; both other samples read in full

## Verdict
Yes. The zip adds no class or package: it is kernel `book` plus published packages (`tcolorbox`, `amsthm`, `geometry`, `setspace`, `float`, `babel`, `hyperref`, `xcolor`), and every zip-local macro is an alias, a wrapper or a declaration that expands inline into those ways (`\NewDocumentCommand` wrappers over `\newtcbtheorem` environments, two `\newenvironment` blocks over a `tcolorbox`). There is no counter or conditional logic in the main sample, no artwork and no external tool. The one judgement call is the proof-end mark `\textcolor{..}{\hbox{}\nobreak\hfill$\blacksquare$}` (theorems.tex:97), filed under `sp.manual-space` (kernel fill and line-break control) with `color.xcolor` and `math.amssymb`. The two other samples (other-templates/) were read in full and also reduce to lib ways, so they do not change the verdict; `thmtools`, `framed` and `environ` are loaded but never called.

## Blockers
none

## Class setting
- Class: `class.book` options: `oneside` (main.tex:1). The other samples use `class.report` (other-templates/minimal.tex:1) and `class.article` with `12pt` (other-templates/math-assignment-template.tex:1).
- Class-native vocabulary used: `\chapter` (main.tex:57), `\section` (main.tex:59, 109), `\maketitle` as the `book` title page (main.tex:49), `\tableofcontents` (main.tex:52), `oneside`. The sample sets no `\pagestyle`, so the `book` default running heads stand.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.book` | oneside |
| sides | main.tex:1 | `page.class-options` | oneside (paper and font size left to the class default) |
| page geometry | main.tex:7, 19-26 | `page.geometry` | textheight=9in, textwidth=5.5in, top=1in, headheight=12pt, headsep=25pt, footskip=30pt |
| line spacing | main.tex:6, 18 | `sp.setspace` | `\setstretch{1.2}` |
| input encoding | main.tex:10 | `font.fontenc-t1` | `inputenc` option utf8; no text-font package, so Computer Modern default |
| language | main.tex:11 | `lang.babel` | english |
| colour | main.tex:13 | `color.xcolor` | option dvipsnames; tints such as `green!20!white` at theorems.tex:28-29 |
| maths packages | main.tex:3 | `math.amsmath`, `math.amssymb` | amsmath, amssymb, amsfonts |
| operator alias | commands.tex:1 | `math.amsmath` | `\operatorname{lcm}` (alias, see Bespoke code) |
| theorem boxes (7 kinds) | theorems.tex:19-30 (definition), 45-56 (theorem), 71-82 (lemma), 112-123 (corollary), 153-164 (proposition), 194-205 (claim), 236-247 (fact) | `thm.tcolorbox` | `\newtcbtheorem` with enhanced, frame hidden, titlerule=0mm, toptitle=1mm, bottomtitle=1mm, fonttitle=\bfseries\large, coltitle=black, a colbacktitle and a colback per kind (green, cyan, violet, orange, yellow, pink, purple); definition has `number within=section` (theorems.tex:19), the other six `use counter from=mydefinition`; label prefixes defn, thm, lem, cor, prop, clm, fact; claim is used in its unnumbered form `myclaim*` (theorems.tex:209) |
| proof | theorems.tex:257-262; main.tex:91-95 | `thm.amsthm` | `proof` environment with the optional argument replacing the heading, `[\noindent\textbf{Proof.}]`; default QED square |
| proof-for-X blocks | theorems.tex:90-99, 131-140, 172-181, 214-223 | `box.tcolorbox`, `mark.kernel`, `color.xcolor`, `sp.manual-space`, `math.amssymb` | `blanker,breakable,left=5mm,parbox=false,before upper={\parindent15pt},after skip=10pt,borderline west={1mm}{0pt}{<colour>!20!white}` (skins and breakable libraries); heading `\noindent{\it \textbf{Proof for Lemma}}`; end mark `\textcolor{..}{\hbox{}\nobreak\hfill$\blacksquare$}` |
| example and remark blocks | theorems.tex:265-277, 290-302 | `box.tcolorbox`, `mark.kernel`, `sp.manual-space` | same blanker box with `borderline west={1mm}{0pt}{cyan!10!white}`; heading `\noindent\textbf{Example.}`; `\vspace{5pt}` before and after |
| inline remark | theorems.tex:286-288 | `mark.kernel`, `color.xcolor` | `{\it \color{blue!50!white}#1}` |
| title block | main.tex:43-49 | `front.maketitle`, `font.size-commands`, `mark.kernel`, `sp.manual-space` | `\title{\textbf{\LARGE{..} \vspace*{10\baselineskip}}}`, `\author`, `\date`, `\maketitle` (a title page under `book`) |
| title content variables | main.tex:29-34, 46-47 | `front.maketitle` | text held in `\notetitle`, `\noteauthor`, `\notedate` (content; see Bespoke code) |
| contents | main.tex:52 | `toc.kernel` | `\tableofcontents` |
| page breaks | main.tex:50, 53 | `pg.break` | `\newpage` after the title page and after the contents |
| headings | main.tex:57, 59, 109 | `head.kernel` | `\chapter`, `\section` at the `book` defaults |
| running heads | no call in source | `hf.pagestyle-kernel` | `book` default page style (class default, not set by the sample) |
| figure | main.tex:111-115 | `fig.graphicx`, `fig.float`, `cap.kernel`, `sp.ragged` | `figure[H]`, `\includegraphics[scale=0.1]{img/loo.jpg}`, `\caption`; `\center` (kernel alias of centring, written bare) |
| cross-reference | main.tex:88; theorems.tex:30, 56 | `xref.kernel` | `\ref{thm:mybigthm}`; the label is the tcolorbox prefix `thm:` plus the second argument |
| hyperref | main.tex:9 | `meta.hyperref` | loaded with no options |
| file inclusion | main.tex:37-38 | `struct.input` | `\input{theorems.tex}`, `\input{commands.tex}` |
| loaded, never called | main.tex:4 | `thm.thmtools` | `thmtools` loaded; `\declaretheorem` is not used anywhere in the zip |
| loaded, never called | main.tex:12 | `box.mdframed` | `framed` loaded; no `framed` or `shaded` environment is used |
| loaded, never called | main.tex:14 | considered: `environ` | `\NewEnviron` is not called anywhere in the zip; no printed effect, so no way (as the v4 rejection of load-only packages) |
| other sample: font | other-templates/minimal.tex:6 | `font.serif-pkg` | `kpfonts` loaded with no options (CTAN page read: text, sans, mono and maths fonts, text fonts derived from URW Palladio but looking different; GPL and LPPL; in TeX Live); filed as the serif face package, since `font.palatino` names `mathpazo`, `palatino` and `tgpagella` |
| other sample: theorems | other-templates/minimal.tex:14-27 | `thm.amsthm` | `\theoremstyle{definition}` then definition, theorem [chapter], lemma [theorem], proposition [theorem], corollary within theorem, starred fact; `\theoremstyle{remark}` then starred remark, claim, example, exercise, algorithm |
| other sample: code and lists | other-templates/minimal.tex:5, 8-12 | `list.enumitem`, `code.listings` | loaded; `\lstset{basicstyle=\ttfamily, mathescape}`; no list or listing is used in the body |
| other sample: title page | other-templates/minimal.tex:44-63 | `front.titlepage-env`, `font.size-commands`, `sp.manual-space`, `sp.ragged` | `titlepage` with `\centering`, `\Huge\bfseries`, `\vspace*{2cm}`, `\vfill` |
| other sample: lecture heading | other-templates/minimal.tex:35-39, 70 | `num.counters`, `head.kernel`, `color.xcolor`, `mark.kernel` | `\newcounter{lecture}`, `\stepcounter`, `\subsection*{\color{teal}\it Lecture \thelecture\ - ..}` |
| other sample: assignment | other-templates/math-assignment-template.tex:4, 12-13, 21, 30-31 | `page.geometry`, `meta.hyperref`, `hf.fancyhdr`, `math.amsmath` | `letterpaper, margin=1in`; `\pagestyle{fancy}`, `\chead{F24 MATH 101 - Assignment X}`; `\DeclareMathOperator{\im}{Im}` |
| other sample: question heading | other-templates/math-assignment-template.tex:23-26, 35 | `num.counters`, `pg.break`, `head.kernel` | `\newcounter{qcounter}`, `\setcounter{qcounter}{1}`, `\q` = `\newpage\section*{Question \theqcounter}\stepcounter{qcounter}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\notetitle`, `\def\noteauthor`, `\def\notedate` | main.tex:29-34 | yes | text aliases for the title, author and date arguments; expand inline into `\title`, `\author`, `\date` (`front.maketitle`) |
| theorem wrappers `\defn` `\defnr` `\thm` `\thmr` `\lem` `\cor` `\prop` `\clm` `\fact` (`\NewDocumentCommand`) | theorems.tex:32-42, 58-68, 84-88, 125-129, 166-170, 208-212, 249-253 | yes | each is `\begin{myXXX}{title}{label}` body `\end{myXXX}`; the emitter writes the `thm.tcolorbox` environment directly (`\clm` uses `myclaim*`) |
| proof-block pairs `\lemp` `\corp` `\propp` `\clmp` and environments `lempf` `corpf` `proppf` `clmpf` | theorems.tex:90-109, 131-150, 172-191, 214-233 | yes | theorem environment, then the blanker `tcolorbox` (`box.tcolorbox`) headed `\noindent{\it\textbf{Proof for ...}}` and closed by `\textcolor{c}{\hbox{}\nobreak\hfill$\blacksquare$}`; no counter or conditional. `\corp` declares three arguments but uses two (theorems.tex:142-149), a template slip the emitter does not carry |
| `\pf` | theorems.tex:257-262 | yes | `\begin{proof}[\noindent\textbf{Proof.}] .. \end{proof}` (`thm.amsthm`) |
| `example` environment and `\ex` | theorems.tex:265-283 | yes | `\par\vspace{5pt}\noindent\textbf{Example.}` plus the blanker `tcolorbox`, then `\vspace{5pt}` |
| `remark` environment and `\rmkb` | theorems.tex:290-308 | yes | same as `example` with the heading `Remark.` |
| `\rmk` | theorems.tex:286-288 | yes | `{\it \color{blue!50!white} text}` |
| `\lcm` | commands.tex:1 | yes | `\operatorname{lcm}` at each use (`math.amsmath`); not called in the sample |
| `\lec` and counter `lecture` (other sample) | other-templates/minimal.tex:35-39 | yes | `\newcounter{lecture}` in the preamble (`num.counters`), body wrapper `\stepcounter{lecture}\subsection*{\color{teal}\it Lecture \thelecture\ - title}`; only kernel counter commands, no conditional |
| `\q` and counter `qcounter` (other sample) | other-templates/math-assignment-template.tex:23-26 | yes | `\newcounter`, `\setcounter`, body wrapper `\newpage\section*{Question \theqcounter}\stepcounter{qcounter}` |
| `\NN \ZZ \RR \QQ \CC` aliases (other samples) | other-templates/minimal.tex:29-33; other-templates/math-assignment-template.tex:16-20 | yes | `\mathbb{..}` inline (`math.amssymb`) |

## Content-opaque
none. The figure image img/loo.jpg (main.tex:113) is content and is shipped in the zip; the lorem ipsum paragraphs (main.tex:92-98) are text.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
