yes

# 0049-jstrieb-homework-template: Homework template (homework.cls + hw-shortcuts.sty)

- Unverified: read from the source, not compiled.
- Source: Source/0049-jstrieb-homework-template/ (origin: https://codeload.github.com/jstrieb/homework-template/zip/refs/heads/master; licence: MIT)
- Kind: assignment
- Lib: v1
- Engine: pdfLaTeX-compatible (hyperref is loaded with the `pdftex` driver option, homework.cls:54, which ties it to pdfTeX; nothing needs fontspec or Lua)
- Look carried by: zip-local (homework.cls and hw-shortcuts.sty define the whole look; the sample preamble is only `\documentclass[...]{homework}` and `\usepackage{hw-shortcuts}`)
- Class origin: zip-local
- Main file: example.tex (other samples: none; example.pdf and example.png are rendered previews, not read as source)
- Read: main yes, zip-local classes and styles all

## Verdict
yes. `homework.cls` is a personal class (GitHub, not an official release) that is `\LoadClass{article}` plus `\RequirePackage` of published packages with options, a few `\setlength`/`\titleformat`/`\setlist` calls, and tiny alias macros. `hw-shortcuts.sty` is only `\newcommand` math aliases. There is no artwork (only `\rule`), no tool outside TeX is needed, and every bespoke item reduces to lib ways with parameters (table below). The one hand-made statement environment (`claim`) is a two-command wrapper and is reducible.

CTAN has a different package called `homework` (author Jinwen XU, with built-in theorem environments and "Page X of Y"). That is not this class: the options (`name`, `andrewid`, `course`, `num`) and the code differ. This `homework.cls` is therefore zip-local, which does not matter for the verdict because it reduces fully.

## Blockers
none

## Class setting
- Class: `class.article` options: none passed to article. `homework.cls:13` is `\LoadClass{article}` with no options, so article defaults apply (10pt, oneside). The zip-local `homework` class consumes the key=value options with xkeyval (`homework.cls:20-31`).
- Class-native vocabulary used: kernel `\documentclass`, `\begin{document}`, `\section` (through `\problem`), `\newpage`, `\today`. The sample never calls `\maketitle`, `\title`, `\author` or `abstract`; `homework.cls:59-60` sets title and author anyway. Zip-local class options carry values only: `name=Jacob\ Strieb`, `andrewid=jstrieb`, `course=69-420`, `num=4` (example.tex:1); `type`, `emaildomain` and `probword` take their defaults (homework.cls:27-29, 40-42).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | homework.cls:13 | `class.article` | no options |
| class option values (name, num, course, andrewid, type, emaildomain, probword) | homework.cls:20-31, 45-46; example.tex:1 | `front.maketitle` (strings feed `\title`/`\author`) | strings only: `\name`, `\hwnum`, `\course`, `\andrewid` baked in as literals or as `\newcommand` aliases (see Bespoke code) |
| title and author set (title page never invoked in sample) | homework.cls:59-60 | `front.maketitle` | `\title{<course> -- <type> <num>}`, `\author{<name>}` |
| PDF metadata | homework.cls:54-56 | `meta.hyperref` | driver `pdftex`, `pdfauthor={<name>}`, `pdftitle={<course> -- <type> <num>}` |
| URL breaking at hyphens | homework.cls:51, 71 | `meta.url` | `PassOptionsToPackage{hyphens}{url}`, package `url` |
| page geometry | homework.cls:68 | `page.geometry` | `letterpaper` only, no margin keys (geometry's default layout) |
| microtype | homework.cls:69 | `sp.microtype` | defaults |
| multicol (loaded, unused in sample) | homework.cls:70 | `cols.multicol` | defaults |
| strikethrough | homework.cls:74 | `mark.ulem` | `normalem` |
| font encoding | homework.cls:77 | `font.fontenc-t1` | `T1` |
| straight quotes in verbatim (loaded, unused in sample) | homework.cls:80 | `code.verbatim` | package `upquote`, load-only; filed under the verbatim family because its only effect is the quote glyph in `verbatim`/`\verb` (see Lib changes) |
| lists | homework.cls:83-85 | `list.enumerate-pkg`, `list.enumitem` | `enumerate` (defaults) and `enumitem` with `\setlist[itemize]{topsep=0pt}` (not used in sample body) |
| pandoc list compatibility | homework.cls:87 | `sp.lengths` | `\providecommand{\tightlist}{\setlength{\parskip}{0pt}}` (a compatibility alias; no pandoc run is needed) |
| paragraph indent and skip | homework.cls:90-91 | `sp.lengths` | `\parindent=0em`, `\parskip=1em` |
| math packages | homework.cls:94-95 | `math.amsmath`, `math.amssymb` | `amsfonts`, `amsmath`, `amssymb` |
| theorem/proof support | homework.cls:95; example.tex:12 | `thm.amsthm` | `amsthm` loaded for the `proof` environment; no `\newtheorem` is declared |
| body font | homework.cls:98 | `font.palatino` | `mathpazo` with `osf` |
| header and footer | homework.cls:101-111 | `hf.fancyhdr` | `\fancyhf{}`, `\fancyfoot[C]{\thepage}`, `\lhead{\name \\ \texttt{\email}}`, `\rhead{\today \\ <course> -- <type> <num>}`, `\pagestyle{fancyplain}`, `\headheight=2\baselineskip` |
| header text marks | homework.cls:108 | `mark.kernel` | `\texttt` on the e-mail line |
| section headings | homework.cls:114-116 | `head.titlesec` | `\titleformat{\section}{\large\sc\lowercase}{}{0em}{}`, `\titlespacing{\section}{0em}{1em}{1em}` |
| subsection headings | homework.cls:118-119 | `head.titlesec` | `\titleformat{\subsection}{\normalsize\sc\lowercase}{}{0em}{}`, `\titlespacing{\subsection}{0em}{0em}{1em}` (not used in sample) |
| footnotes | homework.cls:122-123 | `fn.footmisc` | options `hang`, `bottom`; `\footnotemargin=0.75em` (not used in sample) |
| figures | homework.cls:126 | `fig.graphicx` | defaults (loaded, unused in sample) |
| include PDF pages | homework.cls:127 | `pg.include-pdf` | defaults (loaded, unused in sample) |
| long tables | homework.cls:130 | `tbl.longtable` | defaults (loaded, unused in sample) |
| rules in tables | homework.cls:131 | `tbl.booktabs` | defaults (loaded, unused in sample) |
| problem heading command | homework.cls:139; example.tex:7,21,42,61,73 | `head.titlesec` | `\problem{#1}` is `\section{<probword> #1}`; the `\titleformat` label is empty |
| to-do box | homework.cls:142; example.tex:69 | `box.fancybox` | `\fbox{TO-DO}` followed by `\ \ ` |
| separator rule | homework.cls:145-146; example.tex:19 | `sp.rule`, `sp.manual-space`, `sp.ragged` | `center` environment holding `\rule{0.75\linewidth}{0.5pt}\\`, wrapped in `\vfill ... \vfill` |
| claim statement | homework.cls:149; example.tex:9,28,44,62,75 | `sp.manual-space`, `mark.kernel` | `\newenvironment{claim}{\textit{Claim.}}{\vspace{-1em}}`; equivalent form under `thm.amsthm` is not claimed, see Bespoke code |
| proof | example.tex:12,32,47,66,79 | `thm.amsthm` | `proof` environment of amsthm, default QED |
| italic ampersand | homework.cls:158-159 | `mark.kernel` | `\let\textand\&`, `\renewcommand{\&}{\textit{\textand}}` |
| `\maketitle` wrapper | homework.cls:162-168 | `front.maketitle`, `hf.pagestyle-kernel`, `sp.lengths` | `\parskip=0em`, original `\maketitle`, `\thispagestyle{empty}`, `\parskip=1em` |
| math symbol redefinitions | homework.cls:171-178 | `math.amssymb`, `math.kernel` | `\epsilon`->`\varepsilon`, `\emptyset`->`\varnothing`, `\bar`->`\overline`, `\vec`->`\mathbf`, `\arrowvec`=`\mathaccent"017E` (unused in sample) |
| math shortcut package | hw-shortcuts.sty:17-57 | `math.amsmath`, `math.amssymb`, `math.kernel` | alias macros: `\left`/`\right` pairs, `\mathbb{N,Z,R,Q,C}`, `\mathcal{P}`, `\frac`, `\mathbb{E}`/`\mathbb{P}`, `\mathrm{var,cov,lcm}`, `\mathsf{P,NP,coNP}`, `\leq^P_T`, `\overset{\text{L'H}}{=}`, Legendre symbol |
| display maths | example.tex:14,23,30,33-38,49-55 | `math.amsmath`, `math.kernel` | `$$...$$`, `align*`, `cases`, `\frac`, `\sum` (content) |
| page break | example.tex:40,59,71 | `pg.break` | `\newpage` |
| text marks in body | example.tex:82 | `mark.kernel` | `\textit` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| xkeyval options storing strings in macros, with required-option errors and defaults | homework.cls:20-42 | yes | The values are strings for title, author, header and metadata. Emit them as `\newcommand` aliases (or inline literals) in the `meta.hyperref`, `hf.fancyhdr` and `front.maketitle` parameters. `\ClassError` only validates; it prints nothing. `xkeyval` itself is a published CTAN package. |
| `\assignmentname`, `\email` | homework.cls:45-46 | yes | String-concatenation aliases (`<type> <num>`, `<andrewid>@<emaildomain>`); `\newcommand` aliases. |
| `\problem` | homework.cls:139 | yes | Alias for `\section{<probword> #1}`; `head.titlesec` with the `\titleformat` row above. |
| `\todo` | homework.cls:142 | yes | Alias for `\fbox{TO-DO}\ \ `; `box.fancybox`. |
| `\seprule`, `\separator` | homework.cls:145-146 | yes | `center` + `\rule` + `\\`, then `\vfill` around it; kernel rule, fill and centring only (`sp.rule`, `sp.manual-space`, `sp.ragged`). No box or glue algorithm. |
| `claim` environment | homework.cls:149 | yes | Two-command wrapper with no counter or conditional: begin `\textit{Claim.}` (`mark.kernel`), end `\vspace{-1em}` (`sp.manual-space`). An emitter writes the same `\newenvironment` as a body wrapper around the statement's content. It does not call `\newtheorem`, so it is not claimed to equal an amsthm statement. |
| `\&` redefinition | homework.cls:158-159 | yes | `\let` of the old symbol plus `\renewcommand` to `\textit{...}`; `mark.kernel`. |
| `\maketitle` redefinition | homework.cls:162-168 | yes | Wraps the original `\maketitle` with `\setlength{\parskip}` and `\thispagestyle{empty}`; it does not touch `\@maketitle` internals. Not called by the sample. |
| math symbol redefinitions | homework.cls:171-178 | yes | `\renewcommand` aliases onto `\varepsilon`, `\varnothing`, `\overline`, `\mathbf`, and the TeX math accent `\mathaccent"017E`; math kernel/amssymb only. |
| hw-shortcuts.sty math macros (`\lrp \lrs \lrc \lrb`, `\N \Z \R \RR \Q \C`, `\powerset`, `\ddx`, `\expect \prob \var \cov`, `\P \NP \coNP`, `\CookReducesTo`, `\KarpReducesTo`, `\Rf`, `\lh`, `\lcm`, `\leg`) | hw-shortcuts.sty:17-57 | yes | All are `\newcommand` or `\renewcommand` aliases that expand to `\left...\right`, `\mathbb`, `\mathcal`, `\mathrm`, `\mathsf`, `\frac`, `\overset`, `\text`; no logic. `\renewcommand{\P}` replaces the kernel pilcrow (hw-shortcuts.sty:41). |
| Makefile `install` target | Makefile:5-10 | n/a (not a blocker) | Only copies the two files into `~/texmf/tex/latex/local`. It does not generate any `.tex`, so it is not `EXTERNAL`. |

Pandoc is named only in comments (homework.cls:76, 79, 86); no package here calls it and no tool outside TeX is needed to build the sample.

## Content-opaque
none (the sample has no figure, table, code or drawing; the equations are content)

## Lib changes
- New ways proposed: none. `upquote` is filed under `code.verbatim` as a load-only verbatim-quote fix, the way earlier merges folded a single-purpose package into its family. If the consolidator prefers a separate load-only way, it passes W1 to W4: CTAN package, no parameters, generic, one `\usepackage` line.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
