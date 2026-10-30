yes

# 0356-sustech-homework: SUSTech Homework

- Unverified: read from the source, not compiled.
- Source: Source/0356-sustech-homework/ (origin: https://latextemplates.com/downloads/sustech-homework.zip; licence: MIT)
- Kind: assignment
- Lib: v3 (the snapshot read)
- Engine: needs XeLaTeX (`xeCJK` is loaded unconditionally, SUSTechHomework.cls:15; both files carry `% !TEX TS-program = xelatex`, main.tex:1)
- Look carried by: zip-local (the whole look, page, fonts, header and title block, is set in SUSTechHomework.cls; main.tex only gives metadata strings and content)
- Class origin: zip-local (SUSTechHomework.cls:6 is a one-file class from latextemplates.com; `https://ctan.org/pkg/SUSTechHomework` returned 404, so it is not on CTAN, and the zip is not an official release)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (SUSTechHomework.cls, 102 lines, read in full; no other .sty/.def/.cfg/.clo/.bst in the zip)

## Verdict
The zip-local class is `\LoadClass[a4paper]{article}` (SUSTechHomework.cls:8) plus published packages with options, a `geometry` call, a `fancyhdr` header, a `listings` default and a hand-laid `\maketitle` made only of kernel boxes, a rule and font switches. Every piece maps to a lib way. The only conditionals (`\if@twoside`, `\if@twocolumn`) read class options that the emitter itself writes, so the branch can be chosen at emit time; the `\sid`/`\coursecode`/`\coursename`/`\univ` macros are string stores that can be inlined. No artwork, no tool outside TeX (`listings`, not `minted`; `lastpage` needs only a second pass). The one judgment call is the redefined `\maketitle` (see Bespoke code): its body is a composition of lib ways, so it is counted reducible.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (fixed by the class, SUSTechHomework.cls:8), `onecolumn`, `oneside` (main.tex:3, forwarded to article by `\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}`, SUSTechHomework.cls:26-27)
- Class-native vocabulary used: kernel article commands `\title`, `\author`, `\maketitle`, `\section`, `enumerate`, `verbatim` (main.tex:5,7,12,14,16,36). Zip-local additions, not published: `\sid`, `\coursecode`, `\coursename` (main.tex:6,8,9) and `\univ` (default `SUSTech`, SUSTechHomework.cls:41); see Bespoke code.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | SUSTechHomework.cls:8; main.tex:3 | `class.article` | a4paper, onecolumn, oneside |
| paper size | SUSTechHomework.cls:8 | `page.class-options` | a4paper |
| page geometry | SUSTechHomework.cls:11,43-49 | `page.geometry` | left=.85in, right=.85in, top=1in, bottom=.8in, bindingoffset=.15in |
| text font | SUSTechHomework.cls:10 | `font.palatino` | `newpxtext`+`newpxmath` (Palatino-like pair; considered `font.newtx`, the same author's Times-like pair, rejected by family; the package is the parameter) |
| mono font | SUSTechHomework.cls:23 (`courier` commented out, :22) | `font.mono` | `inconsolata` |
| encoding | SUSTechHomework.cls:16 | `font.fontenc-t1` | `[T1]{fontenc}` |
| CJK support | SUSTechHomework.cls:15 | `lang.cjk` | `xeCJK`, no options, no CJK font set; sample has no CJK text |
| line spacing | SUSTechHomework.cls:52 | `sp.linespread` | `\baselinestretch` = 1.1 |
| paragraph spacing | SUSTechHomework.cls:20,51 | `sp.parskip-pkg` | `parskip` defaults; then `sp.lengths` `\parindent`=0pt |
| title block content | main.tex:5,7,12; SUSTechHomework.cls:57-64 | `front.maketitle` | `\title`, `\author`, `\maketitle`; `\date` not set, so `\@date` prints `\today` |
| title block layout | SUSTechHomework.cls:54-71 | `box.fancybox` | `\makebox[\linewidth]{...}` (kernel box family of `\fbox`) |
| | SUSTechHomework.cls:56-66 | `box.minipage` | two `minipage[b]` of .7\linewidth and .3\linewidth |
| | SUSTechHomework.cls:57,58,61 | `font.size-commands` | `\Large`, `\Huge`, `\large` |
| | SUSTechHomework.cls:57,58 | `mark.kernel` | `\textsf` (code and course name), `\textbf` (title) |
| | SUSTechHomework.cls:61-65 | `sp.ragged` | `flushright` environment for author / id and date |
| | SUSTechHomework.cls:57,59,63 | `sp.manual-space` | `\\\\`, `\hfill`, `\vspace{.5em}`, `~`; `\noindent` (:55,:68) is a no-op under parindent 0 |
| | SUSTechHomework.cls:68 | `sp.rule` | `\rule{\linewidth}{1.5pt}` |
| | SUSTechHomework.cls:70 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` on the title page |
| title in two-column | SUSTechHomework.cls:69,73-74 | `cols.twocolumn-cmd` | `\twocolumn[...]` and `\vspace{.5em}`; not exercised (sample is onecolumn, main.tex:3) |
| header and footer | SUSTechHomework.cls:17,79-93 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\headrulewidth`=0.3pt; oneside: `\lhead` author·sid (small caps), `\chead` course name∘title (small caps), `\rhead` page/last; twoside: `\fancyhead[EL,OR]`, `[EC]`, `[ER]`, `[OL]`, `[OC]` |
| header text styling | SUSTechHomework.cls:85,88,90,91 | `mark.kernel` | `\textsc` |
| page X of Y | SUSTechHomework.cls:18,84,92 | `pgnum.lastpage` | `lastpage`, `\thepage~/~\pageref{LastPage}` |
| hyperlinks | SUSTechHomework.cls:21 | `meta.hyperref` | `hidelinks` |
| headings | main.tex:14,28,52; class does not touch headings | `head.kernel` | article `\section`, defaults |
| lists | main.tex:16-26,30-50 | `list.kernel` | `enumerate`, defaults; `\textit{Solution.}` runs are `mark.kernel` |
| maths | SUSTechHomework.cls:13; main.tex:17,19-20 | `math.amsmath` | loaded with no options; inline maths only |
| graphics | SUSTechHomework.cls:12 | `fig.graphicx` | `graphicx` loaded, no figure in the sample |
| table rules | SUSTechHomework.cls:19 | `tbl.booktabs` | loaded, no table in the sample |
| code defaults | SUSTechHomework.cls:14,95-102 | `code.listings` | `\lstset{numbers=left, basicstyle=\ttfamily, frame=shadowbox, columns=flexible, xleftmargin=1.5em, xrightmargin=1em}` |
| code listing with caption | main.tex:54-66 | `code.listings` | `lstlisting[language=Python, caption=Iterative binary search]`; the caption is made by `listings` itself, no separate caption package is loaded |
| verbatim block | main.tex:36-42 | `code.verbatim` | kernel `verbatim`; the ASCII tree is content text |
| inline code | main.tex:44-45 | `mark.kernel` | `\texttt` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `SUSTechHomework` | SUSTechHomework.cls:5-102 | yes | `\documentclass[a4paper,onecolumn,oneside]{article}` plus the packages and settings in the Component map; the emitter writes them in the preamble |
| option pass-through | SUSTechHomework.cls:26-27 | yes | `\DeclareOption*` forwards every option to article: class option parameters of `class.article` |
| string stores `\sid`, `\coursename`, `\coursecode`, `\univ` and their missing-value error defaults | SUSTechHomework.cls:29-41; main.tex:6,8,9 | yes | `\gdef` stores of plain strings; no typesetting. The emitter writes the strings straight into the title wrapper and the `hf.fancyhdr` fields (or one `\newcommand` per string); the "No \sid given" error guards print nothing |
| `\mktitle` | SUSTechHomework.cls:54-71 | yes | hand-laid block of kernel boxes: `\makebox[\linewidth]` of two `minipage[b]` (.7 and .3 of `\linewidth`) joined by `\hfill`, then `\rule{\linewidth}{1.5pt}` and `\thispagestyle{empty}`. Every part is a lib way (rows above); it uses no counter, no output routine, no glue algorithm. `\@title`, `\@author`, `\@date` are kernel stores of `\title`/`\author`/`\date` and are replaced by their values |
| `\maketitle` redefinition under `\if@twocolumn` | SUSTechHomework.cls:73-77 | yes, judgment call | the flag is fixed by the class option the emitter writes (`onecolumn` here), so the emitter picks one branch: the `\mktitle` body, or `\twocolumn[\mktitle]` (`cols.twocolumn-cmd`). The redefinition replaces `\maketitle` with a composition of lib ways, not a kernel-internals rewrite like `\@maketitle` or `\@startsection` |
| header branch under `\if@twoside` | SUSTechHomework.cls:83-93 | yes | same: chosen at emit time from the `oneside`/`twoside` option; each branch is `\fancyhead` calls with strings |

## Content-opaque
none (the ASCII search tree at main.tex:36-42 is verbatim text and the Python code at main.tex:55-65 is listing content; both have lib ways)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Missing assets: none shipped. `xeCJK` needs a system CJK font only for CJK characters, which the sample has none of; `newpxtext`/`newpxmath` and `inconsolata` are TeX Live packages (not read here). Whether `newpxtext` is fine beside `fontenc[T1]` under XeLaTeX was not checked.
- `\parindent` is set to 0pt (SUSTechHomework.cls:51) after `parskip` (:20) already sets it, so the line is redundant.
- `lastpage` needs two passes (page count read back from the aux file), not an outside tool.
- No text in the zip is addressed to an AI.
