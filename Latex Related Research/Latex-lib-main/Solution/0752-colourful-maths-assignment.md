yes

# 0752-colourful-maths-assignment: Colourful Maths Assignment

- Unverified: read from the source, not compiled.
- Source: Source/0752-colourful-maths-assignment/ (origin: https://latextemplates.com/downloads/colourful-maths-assignment.zip; licence: MIT)
- Kind: assignment
- Lib: v6
- Engine: pdfLaTeX-compatible (hyperref option `pdftex` at assignment.cls:69, `mathpazo` at :114, `fontenc` T1 at :93; no fontspec or Lua code)
- Look carried by: zip-local (assignment.cls defines the whole look; main.tex only repeats `amsmath,amssymb` and fills the class options)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
The look is carried by the zip-local `assignment.cls`, which is `\LoadClass[12pt]{article}` plus published packages with options, `\newcommand`/`\renewcommand` aliases of kernel commands, and two small environments or macros built from rules, `\vfill` and `\textit`. Every piece maps to an existing lib way and nothing is irreducible: the xkeyval option keys only store strings, which an emitter writes as `\newcommand` lines. There is no artwork, no external tool and no unmapped component. The class is not published: the CTAN package `assignment` is a different class (Madhusudan Singh, 2004, LPPL; read at ctan.org/pkg/assignment), as README.md:13-25 also says; so it counts as zip-local, and it reduces by flattening.

## Blockers
none

## Class setting
- Class: `class.article` options: `12pt` (fixed inside the zip-local class, assignment.cls:28); paper size `letterpaper` is a `geometry` option (assignment.cls:84), not a class option. The sample calls `\documentclass[...]{assignment}` (main.tex:21) with the class-local keys `name`, `regnum`, `course`, `num` (and defaults `type=Assignment`, `emaildomain`, `probword=Problem`, assignment.cls:38-44), none of which belong to `article`.
- Class-native vocabulary used: none from `article` beyond `\title` `\author` `\date` `\maketitle` `\section` `\subsection`; the sample uses the zip-local `\problem{N}`, `claim` environment and `\separator` (main.tex:28,42,44,48,60), reduced below.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | assignment.cls:28; main.tex:21 | `class.article` | 12pt; reached through the zip-local class via `\LoadClass` |
| font size / paper (class options) | assignment.cls:28 | `page.class-options` | 12pt |
| page geometry | assignment.cls:84 | `page.geometry` | letterpaper (no margins set, geometry defaults) |
| class option keys to strings | assignment.cls:35-46,49-61; main.tex:21 | none needed (flattened to `\newcommand`) | `\name`, `\assignum`, `\course`, `\regnum`, `\assignmenttype`, `\emaildomain`, `\probword`, see Bespoke code; considered: `xkeyval` |
| PDF metadata | assignment.cls:69-71 | `meta.hyperref` | pdftex, pdfauthor={\name}, pdftitle={\course{} -- \assignmentname} |
| URL breaking | assignment.cls:66,87 | `meta.url` | `\PassOptionsToPackage{hyphens}{url}`, `\RequirePackage{url}` |
| title block | assignment.cls:74-76,178-184; main.tex:26 | `front.maketitle` | `\title{\course{} -- \assignmentname}`, `\author{\name}`, `\date{\regnum}`; kernel article `\maketitle` unchanged inside the wrapper |
| title wrapper: parskip 0em then 1em, no header on page 1 | assignment.cls:178-184 | `sp.lengths`, `hf.pagestyle-kernel` | `\setlength{\parskip}{0em}`, `\thispagestyle{empty}`, `\setlength{\parskip}{1em}` |
| microtype | assignment.cls:85 | `sp.microtype` | defaults |
| loaded, unused by the sample: multicol | assignment.cls:86 | `cols.multicol` | load-only |
| strikethrough | assignment.cls:90 | `mark.ulem` | normalem |
| font encoding | assignment.cls:93 | `font.fontenc-t1` | T1 |
| upright quotes in verbatim | assignment.cls:96 | `code.upquote` | load-only |
| lists | assignment.cls:99-101 | `list.enumerate-pkg`, `list.enumitem` | `enumerate` loaded; `\setlist[itemize]{topsep=0pt}` |
| pandoc tight list | assignment.cls:103 | `sp.lengths` | `\providecommand{\tightlist}{\setlength{\parskip}{0pt}}` |
| paragraph spacing | assignment.cls:106-107 | `sp.lengths` | `\parindent`=0em, `\parskip`=1em |
| maths packages | assignment.cls:110-111; main.tex:23 | `math.amsmath`, `math.amssymb` | `amsfonts`, `amsmath`, `amssymb` (main.tex repeats `amsmath,amssymb`) |
| text and maths face | assignment.cls:114 | `font.palatino` | `mathpazo` option `osf` (old-style figures) |
| header and footer | assignment.cls:117,121-127 | `hf.fancyhdr` | `\fancyhf{}`, `\fancyfoot[C]{\thepage}`, `\lhead{\name \\ \texttt{\email}}`, `\rhead{\today \\ \course{} -- \assignmentname}`, `\pagestyle{fancyplain}` |
| head height | assignment.cls:127 | `sp.lengths` | `\setlength{\headheight}{2\baselineskip}` |
| section heading look | assignment.cls:130-132 | `head.titlesec` | `\titleformat{\section}{\large\sc\lowercase}{}{0em}{}` (empty label), `\titlespacing{\section}{0em}{1em}{1em}`; inner commands `font.size-commands` (`\large`), `mark.kernel` (`\sc`), `mark.case` (`\lowercase`) |
| subsection heading look | assignment.cls:134-135 | `head.titlesec` | `\titleformat{\subsection}{\normalsize\sc\lowercase}{}{0em}{}`, `\titlespacing{\subsection}{0em}{0em}{1em}`; `font.size-commands`, `mark.kernel`, `mark.case` |
| problem header | assignment.cls:155; main.tex:28,44 | `head.kernel` | `\section{\probword{} N}`, printed "Problem N" through the titlesec format above |
| footnotes | assignment.cls:138-139 | `fn.footmisc` | `hang, bottom`, `\footnotemargin`=0.75em (the sample has no footnote) |
| graphics and PDF pages | assignment.cls:142-143 | `fig.graphicx`, `pg.include-pdf` | load-only (no figure in the sample) |
| tables | assignment.cls:146-147 | `tbl.longtable`, `tbl.booktabs` | load-only (no table in the sample) |
| to-do marker | assignment.cls:158 | `box.fancybox` | `\fbox{TO-DO}` (not in the sample) |
| problem separator | assignment.cls:161-162; main.tex:42,60 | `sp.rule`, `sp.ragged`, `sp.manual-space` | `\vfill`, `center` environment with `\rule{0.75\linewidth}{0.5pt}\\`, `\vfill` |
| claim statement | assignment.cls:165; main.tex:48-50 | `thm.amsthm` | unnumbered, italic head "Claim.", upright body, run-in; the zip's version is `\newenvironment{claim}{\textit{Claim.}}{\vspace{-1em}}`, whose parts are `mark.kernel` and `sp.manual-space` |
| proof | assignment.cls:111; main.tex:32-40,52-58 | `thm.amsthm` | amsthm `proof` environment with its default QED tombstone |
| italic ampersand | assignment.cls:174-175 | `mark.kernel` | `\renewcommand{\&}{\textit{\&}}` (original saved with `\let`); not in the sample |
| maths symbol aliases | assignment.cls:187-188,192-194 | `math.amssymb`, `mark.kernel`, `math.kernel` | `\epsilon`->`\varepsilon`, `\emptyset`->`\varnothing`, `\vec`->`\mathbf` (math alphabet), `\bar`->`\overline`, `\arrowvec`=`\mathaccent"017E`; none of the five is called in the sample, they are class-level look |
| display maths | main.tex:36-38 | `math.kernel` | `\[ ... \]` (content: the equation) |
| cross-references | none | none | the sample has no `\label` or `\ref` (README.md:31) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `assignment.cls` as a whole (zip-local, not the CTAN `assignment`) | assignment.cls:24-194 | yes | `\documentclass[12pt]{article}` plus the packages and settings in the table; no output routine, no kernel internals touched |
| option keys `name` `num` `course` `regnum` `type` `emaildomain` `probword` through `xkeyval` `\DeclareOptionX` and `\ProcessOptionsX` | assignment.cls:35-46 | yes | each key only stores a string with `\newcommand`; the emitter writes `\newcommand{\name}{Ada\ Lovelace}` and the other six directly (values are content) |
| `\@ifundefined` ClassError checks and default fallbacks | assignment.cls:49-57 | yes | validation only; the emitter always supplies all values and substitutes defaults (`Assignment`, `iisermohali.ac.in`, `Problem`) at emit time |
| `\assignmentname`, `\email` | assignment.cls:60-61 | yes | `\newcommand` string concatenation; inline expansion |
| `\problem` | assignment.cls:155 | yes | `\newcommand{\problem}[1]{\section{Problem #1}}`, alias over `head.kernel` |
| `\todo` | assignment.cls:158 | yes | alias of `\fbox{TO-DO}` plus two `\ ` spaces |
| `\seprule`, `\separator` | assignment.cls:161-162 | yes | aliases: `center` + `\rule{0.75\linewidth}{0.5pt}\\` + `\vfill` (`sp.rule`, `sp.ragged`, `sp.manual-space`) |
| `claim` environment | assignment.cls:165 | yes | `\newenvironment` of `\textit{Claim.}` and `\vspace{-1em}`; or an amsthm `\newtheorem*` with a run-in style |
| `\&` redefinition | assignment.cls:174-175 | yes | `\textit` alias |
| `\maketitle` wrapper (`\let\origtitle`) | assignment.cls:178-184 | yes | two `\setlength` calls and `\thispagestyle{empty}` around the kernel `\maketitle`; the emitter can write the same three lines at the call site |
| `\epsilon` `\emptyset` `\bar` `\vec` `\arrowvec` | assignment.cls:187-194 | yes | `\renewcommand` aliases of kernel or amssymb math commands and one `\mathaccent` primitive; `\arrowvec` is a `\newcommand` alias |
| `\tightlist` | assignment.cls:103 | yes | `\providecommand` alias of `\setlength{\parskip}{0pt}` |

No text addressed to an AI was found in the README, main.tex or assignment.cls.

## Content-opaque
none (the proofs and the displayed `\max` formula at main.tex:36-38 are text and equations, ordinary content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
