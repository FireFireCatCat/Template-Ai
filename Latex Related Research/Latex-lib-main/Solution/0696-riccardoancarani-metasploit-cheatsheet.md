yes

# 0696-riccardoancarani-metasploit-cheatsheet: Metasploit Cheat Sheet (two-column landscape reference card)

- Unverified: read from the source, not compiled.
- Source: Source/0696-riccardoancarani-metasploit-cheatsheet/ (origin: https://codeload.github.com/RiccardoAncarani/metasploit_cheatsheet/zip/refs/heads/master; licence: MIT)
- Kind: misc (cheat sheet)
- Lib: v5
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (a plain `article`; the look is the sample's own preamble: landscape geometry, `\@startsection` heading renewals, `multicols{2}`, `\footnotesize`; no zip-local class or style)
- Class origin: tex-distribution-unbundled
- Main file: metasploit.tex (255 lines; other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Every in-scope component maps to a lib way: `class.article`, `page.geometry`, `cols.multicol`, `head.kernel`, `tbl.tabular`, `code.verbatim` and a few kernel switches. The zip has no `.cls` or `.sty`, no artwork, no external tool and no content that no way can hold. Its bespoke items are three `\@startsection` calls (the kernel's own declarative interface, not a rewrite of kernel internals), a paper-width `\ifthenelse` that selects between `\geometry` parameter sets, and three dead definitions with no printed effect. All reduce, so the answer is `yes`. A stricter reader could contest only the `\@startsection` renewals (metasploit.tex:21-34); the reduction below shows they are the six-argument call that `head.kernel` covers.

## Blockers
none

## Class setting
- Class: `class.article` options: `10pt`, `landscape` (metasploit.tex:1). The class is the kernel article, not bundled in the zip (its source was not read).
- Class-native vocabulary used: `\section`, `\subsection`, `\subsubsection` (metasploit.tex:69, 83, 165, 167). The sample does not use `\maketitle`, `abstract`, `\tableofcontents`, `itemize`, floats or `\bibliography`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | metasploit.tex:1 | `class.article` | 10pt, landscape |
| paper size and orientation | metasploit.tex:1 | `page.class-options` | `10pt`, `landscape` (no paper option, so the class default letter paper, rotated) |
| page geometry | metasploit.tex:5, 9-14 | `page.geometry` | package option `landscape`; margins `top=.5in,left=.5in,right=.5in,bottom=.5in` (line 10, the letter branch); the A4 and fall-through branches both give `top=1cm,left=1cm,right=1cm,bottom=1cm` (lines 12-13) |
| columns | metasploit.tex:2, 54, 254 | `cols.multicol` | `multicols{2}` around the whole body; `\premulticols`=1pt, `\postmulticols`=1pt, `\multicolsep`=1pt, `\columnsep`=2pt (lines 60-63, set inside the environment); `\columnseprule` only in a comment (line 59) |
| header and footer | metasploit.tex:17 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| paragraph spacing | metasploit.tex:44-45 | `sp.lengths` | `\parindent`=0pt, `\parskip`=0pt plus 0.5ex |
| alignment | metasploit.tex:52 | `sp.ragged` | `\raggedright` for the body |
| font sizes | metasploit.tex:53, 66, 247 | `font.size-commands` | `\footnotesize` for the body, `\Large` for the title, `\scriptsize` for the copyright line; `\large` `\normalsize` `\small` inside the heading styles (lines 25, 29, 33) |
| title block (hand-set, no `\maketitle`) | metasploit.tex:65-67 | `sp.ragged` | `center` environment holding one line |
| title block, size and weight | metasploit.tex:66 | `font.size-commands` | `\Large`; no `\title` `\author` `\date` anywhere |
| title block, weight | metasploit.tex:66 | `mark.kernel` | `\textbf{Metasploit Cheat Sheet}` |
| title block, trailing break | metasploit.tex:66 | `sp.manual-space` | `\\` at the end of the centred line |
| headings (3 levels) | metasploit.tex:22-33 | `head.kernel` | `\renewcommand` of `\section` `\subsection` `\subsubsection` as `\@startsection{name}{level}{indent}{beforeskip}{afterskip}{style}`; see the Bespoke table for the values |
| heading numbering | metasploit.tex:41 | `num.secnumdepth` | `secnumdepth`=0 (no numbers printed) |
| heading text styles | metasploit.tex:25, 29, 33 | `mark.kernel` | `\normalfont` and `\bfseries` in each style argument |
| section content | metasploit.tex:69, 83, 107, 128, 140, 153, 165, 166, 167, 187, 201, 210, 223, 234 | `head.kernel` | two `\section` (69, 165), eleven `\subsection`, one `\subsubsection` (167); titles are content |
| command tables | metasploit.tex:70-81 (and 84-102, 108-126, 129-137, 141-150, 155-162, 169-185, 189-197, 203-208, 212-220, 225-230, 236-243) | `tbl.tabular` | colspec `@{}ll@{}` (two left columns, no outer padding); no rules, no `\hline`, no `booktabs` |
| blank row and label rows inside tables | metasploit.tex:94, 95, 214, 217 | `sp.manual-space` | a bare `\\` row and one-cell text rows ending in `\\` |
| line break after a table | metasploit.tex:150-151 | `sp.manual-space` | `\end{tabular}\\` then a text line |
| command text | metasploit.tex:71 (102 lines use it) | `code.verbatim` | `\verb!...!` with `!` as delimiter, inside tabular cells |
| closing rule | metasploit.tex:246 | `sp.rule` | `\rule{0.3\linewidth}{0.25pt}` |
| copyright line | metasploit.tex:247-249 | `font.size-commands` | `\scriptsize` then plain text with the kernel `\copyright`; the wording is content |
| hyperlinks and PDF | metasploit.tex:6 | `meta.hyperref` | `\usepackage{hyperref}` with no options; no `\href`, `\url`, `\ref` or `\label` in the body (Grep) |

Not set by the zip (nothing to emit): text face (no font package; class default), colour, background, language (no `babel`), abstract, contents, lists, floats and captions, maths, theorems, notes, bibliography, index.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\section}{\@startsection{section}{1}{0mm}{-1ex plus -.5ex minus -.2ex}{0.5ex plus .2ex}{\normalfont\large\bfseries}}` | metasploit.tex:21-25 (`\makeatletter` at 21) | yes | `head.kernel`: the kernel's documented sectioning-command builder called with level 1, indent 0mm, beforeskip `-1ex plus -.5ex minus -.2ex`, afterskip `0.5ex plus .2ex`, style `\normalfont\large\bfseries`. It calls `\@startsection`; it does not redefine it. An equivalent `\titleformat` and `\titlespacing*` pair gives the same look because `\parindent` is 0pt (line 44), so the negative beforeskip's no-indent effect is moot |
| `\renewcommand{\subsection}{\@startsection{subsection}{2}{0mm}...}` | metasploit.tex:26-29 | yes | `head.kernel`: level 2, indent 0mm, beforeskip as above (typed `-1explus -.5ex minus -.2ex` at line 27, which TeX reads as `-1ex plus -.5ex minus -.2ex`), afterskip `0.5ex plus .2ex`, style `\normalfont\normalsize\bfseries` |
| `\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{0mm}...}` | metasploit.tex:30-34 (`\makeatother` at 34) | yes | `head.kernel`: level 3, indent 0mm, beforeskip as above, afterskip `1ex plus .2ex`, style `\normalfont\small\bfseries` |
| `\ifthenelse{\lengthtest{\paperwidth = 11in}}{\geometry{...}}{\ifthenelse{...297mm...}{...}{...}}` | metasploit.tex:9-14 (`ifthen` loaded at 4) | yes | `page.geometry`, by partial evaluation on the paper: with no paper option and `landscape`, `\paperwidth` is 11in, so the first branch gives `top=.5in,left=.5in,right=.5in,bottom=.5in`; A4 (297mm) and any other paper give `top=1cm,left=1cm,right=1cm,bottom=1cm` (the two inner branches are identical). The test chooses between declarative key lists and has no other effect. `ifthen` is a LaTeX base (tools) package, so printing the lines unchanged would also be allowed. The author's own `metasploit.log` records margins of 36.135pt (0.5in) on an 11in-wide page (metasploit.log:256-258); that is a leftover file, not a check made here |
| `\def\BibTeX{...}` | metasploit.tex:36-38 | yes (dead code) | No printed effect: Grep finds `\BibTeX` only in the comment at line 36 and the definition at line 37, never in the body. Drop it. If a node ever used it, it is a TeX-logo macro, which a logo-by-name package such as hologo prints |
| `\newlength{\MyLen}` and eight `\settowidth{\MyLen}{\texttt{...}}` calls | metasploit.tex:104-105, 154, 168, 188, 202, 211, 224, 235 | yes (dead code) | `\MyLen` is only ever set, never read (Grep over the file), so nothing printed depends on it. Drop them; they are left over from the LaTeX cheat sheet this file was cut from |

`calc` (metasploit.tex:3) is loaded but no infix expression is used anywhere in the preamble or the body (the lengths at lines 44-45, 60-63 and the rule at 246 are plain TeX dimensions), so it has no printed effect.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- considered: `ifthen` and `calc` as load-only ways: not proposed (no printed effect once the paper test at lines 9-14 is evaluated; the test reduces to `page.geometry` parameters)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
