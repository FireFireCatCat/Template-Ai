yes

# 0028-prometheuscv: prometheusCV

- Unverified: read from the source, not compiled.
- Source: Source/0028-prometheuscv/ (origin: https://latextemplates.com/downloads/prometheuscv.zip; licence: MIT, (c) Christian Bock 2020 per README.md:48-50)
- Kind: cv
- Lib: v1
- Engine: needs XeLaTeX (`fontspec` `\setmainfont` and `\newfontfamily` with TTF file names, main.tex:21-41; README.md:16 says `xelatex`)
- Look carried by: mixed (the zip-local class sets the section/subsection looks and the dated-entry macros, prometheus_cv.cls:6-65; the sample preamble sets fonts, colours, geometry, header and links, main.tex:3-54; title.tex hand-lays the title block)
- Class origin: zip-local (`prometheus_cv` is a vendored copy of the GitHub repo chrisby/prometheusCV, README.md:7,15; https://ctan.org/pkg/prometheus_cv returned 404, so it is not on CTAN; the zip is not an official release)
- Main file: main.tex (other samples: none; the section bodies are `\input` from title.tex, education.tex, publications.tex, honors.tex, skills.tex, service.tex, extra.tex)
- Read: main yes, zip-local classes and styles all (prometheus_cv.cls is the only one, 66 lines; all seven `\input` files and README.md read too)

## Verdict
Yes. The only zip-local code is a 66-line class that is `\LoadClass{article}`, `titlesec` calls (`\titleformat`, `\titlespacing`, `\titleclass`) and two `\newcommand` entry macros. Those macros only compose kernel boxes, glue, size and shape switches and a `titlesec` heading, with no conditionals, loops or output-routine code, so they reduce to body wrappers over lib ways. The rest is sample preamble using published packages (`geometry`, `xcolor`, `hyperref`, `fontspec`, `fontawesome5`, `fancyhdr`). There is no artwork, no external tool, and no unmapped component. The fragile spots (a negative-`\hspace*` hack, state that leaks because `\centering` and `\raggedright` are never grouped) are parameters and ordering, written down below.

## Blockers
none

## Class setting
- Class: `class.article` (reached through the zip-local wrapper `prometheus_cv`, prometheus_cv.cls:1; no `\DeclareOption`, no options passed at main.tex:1, so article defaults: 10pt, one column; paper size is set by `geometry`, not by the class)
- Class-native vocabulary used: the wrapper's own `\datedsubsection{date}{place}{title}{text}` and `\datedsubsectionnarrow` (zip-local, see Bespoke code). From article: `\section`, `\subsection`, `enumerate`, `\footnotemark`, `\footnotetext`. No `\maketitle`, `abstract`, `\tableofcontents`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1; prometheus_cv.cls:1 | `class.article` | no options; wrapper adds only the rows for `head.titlesec` below |
| input encoding | main.tex:2 | `font.fontenc-t1` | `inputenc` option utf8 (a no-op under XeLaTeX, still a published load) |
| page geometry | main.tex:3 | `page.geometry` | a4paper, total={5.3in,10in}, top=2cm |
| main font | main.tex:35-39 | `font.fontspec` | `\setmainfont` Cormorant Garamond by file name: Regular, BoldFont=Bold, ItalicFont=Italic, BoldItalicFont=BoldItalic (.ttf) |
| light font | main.tex:40-41; used prometheus_cv.cls:23,36 | `font.fontspec` | `\newfontfamily\GaramondLight{CormorantGaramond-Light.ttf}`; alias `\textlf[1]` = `{\GaramondLight #1}` (see Bespoke code) |
| colours | main.tex:5-8 | `color.xcolor` | `\definecolor` HTML: highlight 283559, highlight2 1A2640, link 5C6273 (`link` is never used) |
| links | main.tex:14-19; title.tex:22-38; skills.tex:5 | `meta.hyperref` | colorlinks=true, linkcolor=urlcolor=citecolor=highlight; `\href` with http, mailto and tel targets |
| icons | main.tex:12; title.tex:22,25,29,33,37 | `font.icons` | `fontawesome5`: `\faHome`, `\faEnvelope[regular]`, `\faMobile*`, `\faLinkedinIn`, `\faGraduationCap`, each inside `\begin{tiny}` |
| header and footer | main.tex:48-54 | `hf.fancyhdr` | `\fancyhf{}`; `\rhead{Curriculum Vit\ae}`; `\lhead{Sofia Marchetti}`; `\rfoot{Page \thepage}`; headrulewidth 0.5pt; footrulewidth 0pt |
| page styles | main.tex:57-58 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` for page 1, then `\pagestyle{fancy}` |
| alignment, document wide | main.tex:64; prometheus_cv.cls:27,40 | `sp.ragged` | `\centering` in the body before `\input{title.tex}` is never closed; `\raggedright` inside the entry macros is also ungrouped (see Bespoke code, order matters) |
| manual spacing | main.tex:63,70; title.tex:5,10,15,19 | `sp.manual-space` | `\vspace*{-1cm}`, `\vspace*{0.4cm}`, `\vspace*{-0.10em}`, `\vspace*{0.25em}`, `\vspace*{-1ex}`, `\vspace*{0.4cm}`, `\quad`, `~` |
| title block (hand-laid, no `\maketitle`) | title.tex:1-41 | `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.manual-space`, `meta.hyperref`, `font.icons` | centred lines: `scriptsize` "curriculum vit\ae~of" in black; `Large` name; `scshape` + `footnotesize` keyword lines in highlight2 (`$\cdot$` separators); `footnotesize` contact row of icon + `\href` pairs |
| section headings | prometheus_cv.cls:9-13; main.tex:71,77,83,89,96,103 | `head.titlesec` | `\titleformat{\section}` format=`\large\scshape\raggedright`, label empty, sep=0em, before empty, after=`[\titlerule]` (a rule under the heading); spacing left at the article default |
| subsection headings | prometheus_cv.cls:16-19; publications.tex:4,13 | `head.titlesec` | `\titleformat{\subsection}` format=`\normalsize\scshape\raggedright`, label empty, sep=0em, before empty; spacing left at the article default |
| entry heading levels `cvsubsection`, `cvsubsectionnarrow` | prometheus_cv.cls:50-56, 59-65 | `head.titlesec`, `num.counters` | `\newcounter{cvsubsection}`; `\titleclass{..}{straight}[\part]`; `\titleformat{..}{\raggedright}{}{0em}{}`; `\titlespacing*{..}{0pt}{3.5ex plus 1ex minus .2ex}{-2.5ex}` for `cvsubsection`, `{0pt}{0pt}{-2.5ex}` for the narrow one |
| dated entry (body wrapper) | prometheus_cv.cls:22-32, 35-45; used education.tex:1,9; service.tex:1,7; extra.tex:1; honors.tex:1,8,15 | `head.titlesec`, `box.minipage`, `sp.manual-space`, `font.size-commands`, `mark.kernel`, `font.fontspec`, `sp.ragged` | per entry: `\cvsubsection[place]{title \hfill \small{\textlf{\scshape place}}}` then `minipage{5cm}` holding `\vspace*{-.7ex}\hspace*{-3cm}\footnotesize date`, then `\raggedright`, then `small` body text; the narrow variant calls `\cvsubsectionnarrow` and is otherwise the same |
| publications lists | publications.tex:6-18 | `list.kernel`, `num.counters` | two `enumerate` lists; numbering continued across them with `\newcounter{publicationCounter}`, `\setcounter{publicationCounter}{\value{enumi}}`, `\setcounter{enumi}{\value{publicationCounter}}` (publications.tex:3,10,15,17) |
| equal-contribution mark | main.tex:44; publications.tex:7 | `mark.kernel` | `\ec` = `\textsuperscript{\textdagger}` |
| text marks | education.tex:5,7; publications.tex:7-16; skills.tex:1-3 | `mark.kernel` | `\textbf`, `\textit`, `\texttt`, `\scshape` |
| footnote | skills.tex:1,5 | `fn.kernel` | `\footnotemark` in the paragraph, `\footnotetext{...}` with an `\href` after it |
| units package (loaded, unused) | main.tex:11 | `mark.siunitx` | load only; no `\SI`, `\num` or `\qty` anywhere |
| ordinals package (loaded, unused) | main.tex:13 | `mark.nth` | `\usepackage[super]{nth}`; `\nth` is never called |
| multi-file assembly | main.tex:65,72,78,84,90,97,104 | (kernel `\input`, not a way) | each section is `\section{...}` in main.tex followed by `\input` of a content file; no template effect |

Components the sample does not use and the zip does not define: abstract, table of contents, display maths, theorems, floats, tables, captions, code, boxes beyond the minipage, bibliography (the publications are a hand-typed list), index, cross-references (no `\label`, `\ref`, `\cite`).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class `prometheus_cv` as a whole | prometheus_cv.cls:1-65 | yes | `class.article` plus `head.titlesec` calls plus the entry wrapper below; no `\@startsection`, `\@maketitle` or `\@makecaption` is redefined, no `\DeclareOption` |
| `\datedsubsection{date}{place}{title}{text}` (`#1` date, set small in the minipage and pulled 3cm left; `#2` place, set at the right end of the heading in light small caps; `#3` title; `#4` text; see education.tex:1-7) | prometheus_cv.cls:22-32 | yes | body wrapper over `head.titlesec` (`\cvsubsection` with `[place]` as its short title), `sp.manual-space` (`\hfill`, `\vspace*{-.7ex}`, `\hspace*{-3cm}`), `box.minipage` (5cm), `font.size-commands` (`\small`, `\footnotesize`), `mark.kernel` (`\scshape`), `font.fontspec` (`\textlf`), `sp.ragged` (`\raggedright`). No conditionals, counters or computed lengths: every value is a literal |
| `\datedsubsectionnarrow` | prometheus_cv.cls:35-45 | yes | same as above with `\cvsubsectionnarrow`, whose before-skip is 0pt (cls:65) |
| `\cvsubsection`, `\cvsubsectionnarrow` and their counters | prometheus_cv.cls:50-65 | yes | `titlesec`'s documented `\titleclass`, `\titleformat`, `\titlespacing*` with literal lengths; the counters are created only because `\titleclass` needs one (labels are empty, so they never print) |
| `\textlf` | main.tex:41 | yes | alias of a `font.fontspec` family switch; the class macros call it but the class does not define it, so the emitter must put it in the preamble before the class macros are used |
| `\highlight` | main.tex:43 | yes | alias of `\textcolor{highlight}{\textbf{#1}}` (`color.xcolor`, `mark.kernel`); never called |
| `\ec` | main.tex:44 | yes | alias of `\textsuperscript{\textdagger}` (`mark.kernel`) |
| `publicationCounter` | publications.tex:3,10,15,17 | yes | the counter only copies a number: the emitter can write `\setcounter{enumi}{N}` (`num.counters`) with N taken from the model, or the declarative `enumitem` `resume` key (`list.enumitem`); no logic decides what is printed |
| ungrouped `\centering` and `\raggedright` | main.tex:64; prometheus_cv.cls:27,40 | yes (ordering only) | both are kernel switches left open to the end of the document, so the first `\datedsubsection` flips the alignment of everything after it; the emitter reproduces this by emitting the same commands in the same order, or by grouping them and setting the alignment explicitly. Recorded as an observation, not a blocker |

## Content-opaque
- `lipsum` is loaded (main.tex:10) and never called in any `.tex` file (grep), so it is a placeholder-text generator with no template effect.
- Contact data, link targets, dissertation titles and entry text (title.tex, education.tex, publications.tex, honors.tex, service.tex, extra.tex) are content.
- Inline `$\cdot$` separators in the keyword lines (title.tex:13,16) are content.
- Missing assets: the five Cormorant Garamond `.ttf` files named at main.tex:36-40 are not in the zip. README.md:33 says they ship in TeX Live (catharsis). The sample loads them by file name, where upstream used family names (README.md:20-22); either form is `font.fontspec`. The `fontawesome5` fonts come from that package.
- No text addressed to an AI was found. The long comment at main.tex:22-34 and the README are notes by the zip's curator about font loading.

## Lib changes
- New ways proposed: `mark.nth` `nth` (CTAN, public domain, maintainer Donald Arseneau; ctan.org/pkg/nth read once), pdfLaTeX-compatible, `\usepackage[super]{nth}` plus inline `\nth{n}` for English ordinals. W1: on CTAN. W2: behaviour comes from package options (superscript form, treatment of negative numbers) and the number argument, not from editing code. The CTAN page does not name the `super` option; main.tex:13 uses it as written. W3: it serves a kind of mark (ordinal numbers), not one document. W4: one preamble line plus an inline command around a number. In this zip it is loaded but never called, so if the consolidator treats unused loads as out of scope, the row can be dropped and the verdict stays `yes`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
