yes

# 0930-flowfram-newsletter: Flowfram Newsletter

- Unverified: read from the source, not compiled.
- Source: Source/0930-flowfram-newsletter/ (origin: https://latextemplates.com/downloads/flowfram-newsletter.zip; licence: LPPL-1.3)
- Kind: newsletter
- Lib: v6 (the snapshot you read)
- Engine: pdfLaTeX-compatible (geometry, flowfram, xcolor, lmodern, microtype, fancyhdr, hyperref; no fontspec, no Lua)
- Look carried by: preamble (the zip holds one `main.tex` and a README; no `.cls`, `.sty` or other file; the look is `flowfram` frames plus a `fancyhdr` page style and two colours, all declared in main.tex:1-21)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip; the package `flowfram` is also not in the zip, README.md:9-10 says it is supplied by TeX Live and is on CTAN, https://ctan.org/pkg/flowfram, README.md:7)
- Main file: main.tex (other samples: none)
- Read: main yes (all 73 lines), zip-local classes and styles none present

## Verdict
yes. The whole template is one 73-line `main.tex` on kernel `article`: the layout is `page.flowfram` (one flow frame and one static frame, set by lengths), the page style is `hf.fancyhdr`, and the rest is published packages and kernel commands. There is no `\newcommand`, `\def`, environment, counter or drawing in the file (a search for them finds only two `\definecolor` calls and the fancyhdr length at main.tex:10, 11, 17), so no bespoke code and no `ART`. Two things could not be settled by reading (flowfram's source is not in the zip): whether the fancyhdr head and foot print without `\makedfheaderfooter`, and that the bare `1` in `\setstaticcontents{1}` names the unlabelled static frame; neither changes what an emitter would print, since both are the source lines reproduced unchanged.

## Blockers
none

## Class setting
- Class: `class.article` options: `10pt` (main.tex:1)
- Class-native vocabulary used: none (no `\title`, `\maketitle`, `abstract`, `\section`; the title and subheads are set by hand in the body, main.tex:43-50)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:1 | `class.article` | `10pt` |
| page geometry | main.tex:2 | `page.geometry` | `a4paper`, `margin=18mm` |
| page frames, flow frame | main.tex:3, 20 | `page.flowfram` | package loaded with no options; `\newflowframe{0.67\textwidth}{0.82\textheight}{0pt}{0pt}` (width, height, x, y; no `[pages]`, no label) |
| page frames, static frame | main.tex:21 | `page.flowfram` | `\newstaticframe{0.25\textwidth}{0.82\textheight}{0.74\textwidth}{0pt}` (no `[pages]`, no label) |
| sidebar contents | main.tex:24-40 | `page.flowfram` | body wrapper `\setstaticcontents{1}{...}`, same package family as the lib's `staticcontents*` and `\setdynamiccontents*`; argument `1` is the frame number (unlabelled frame); the argument is content set with the rows below |
| colour definitions | main.tex:4, 10-11 | `color.xcolor` | `\definecolor{ink}{HTML}{203040}`, `\definecolor{accent}{HTML}{C85A32}` |
| colour use | main.tex:14, 15, 25, 27, 35, 37, 42, 46 | `color.xcolor` | `\color{ink}` / `\color{accent}` as switches in the sidebar, header fields and body; `\color{ink}` at 42 sets the main text colour |
| text face | main.tex:5 | `font.lmodern` | load-only, no options |
| microtypography | main.tex:6 | `sp.microtype` | defaults, no options |
| header and footer | main.tex:7, 12-17 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`; `\fancyhead[L]` "FIELD NOTES" in `\sffamily\small`, ink (14); `\fancyhead[R]` "ISSUE 08" in `\sffamily\small`, accent (15); `\fancyfoot[C]` `\sffamily\small\thepage` (16); `\renewcommand{\headrulewidth}{0pt}` (17) |
| link options | main.tex:8 | `meta.hyperref` | `hidelinks` |
| mail link | main.tex:39 | `xref.hyperref` | `\href{mailto:notes@example.org}{notes@example.org}` (hyperref link command, same package as the option row) |
| title block | main.tex:43-46 | `font.size-commands` | `\fontsize{30}{32}\selectfont` on the two title lines (43, 44); `\small` on the kicker line (46); no `\maketitle`, so `front.maketitle` is not used |
| title and kicker faces | main.tex:43, 44, 46 | `mark.kernel` | `\sffamily`, `\bfseries` (title lines); `\sffamily` (kicker); each line closed with `\par` |
| subheads | main.tex:25, 28, 50 | `font.size-commands`, `mark.kernel` | 50: `\sffamily\Large\bfseries`; 25: `\color{accent}\sffamily\bfseries`; 28: `\textbf{Three signals}`; hand-set, no sectioning command |
| run-in labels and deck | main.tex:52, 62, 68 | `mark.kernel` | `\textit{...}` (52), `\textbf{What we noticed.}` (62), `\textbf{The next experiment.}` (68) |
| rules | main.tex:35, 48 | `sp.rule` | `\rule{\linewidth}{1pt}` in accent (35); `\rule{\linewidth}{1.5pt}` (48) |
| vertical spacing and breaks | main.tex:26, 34, 36, 38, 45, 47, 49, 51, 55, 61, 67 | `sp.manual-space` | `\smallskip` (26, 36, 51), `\medskip` (45, 47, 49, 55, 61, 67), `\vfill` (34, pushes the contact block to the frame foot), `\\\\` (38, two line breaks) |
| paragraph start | main.tex:48, 52 | `sp.lengths` | `\noindent` (per-paragraph override of `\parindent`; closest home in the lib, not a new way); body paragraphs at 56-59, 62-65, 68-71 are plain text with blank lines and `\par` (content structure) |
| sidebar list | main.tex:29-33 | `list.kernel` | `itemize`, three `\item`s, no options |

Not present in the sample, so no row: sectioning commands, abstract, contents, floats, tables, captions, theorems, code, footnotes, bibliography, index, cross-references, language setup, maths.

## Bespoke code
none. The only definitions are `\definecolor` (declarations, main.tex:10-11) and `\renewcommand{\headrulewidth}{0pt}` (a length of `fancyhdr`, main.tex:17); both are parameter settings of lib ways.

## Content-opaque
none

## Lib changes
- New ways proposed: none. `page.flowfram` (already in the lib) covers both frame commands and `\setstaticcontents`; every other row is an existing way. Considered and not written as a way: `\noindent` and `\par` (kept under `sp.lengths` and as paragraph content).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes for reviewers
- Risk not settled by reading: `flowfram` replaces the output routine (lib line `page.flowfram`), and its manual provides `\makedfheaderfooter` to give header and footer their own frames (the lib line names it). main.tex does not call it, so the `fancyhdr` fields at main.tex:14-16 may not print in the real output. The emitter's task is unchanged (print the same preamble lines), but a compile is needed to see the effect. Also unsettled: the interaction of `hyperref` and `microtype` with the flowfram output routine.
- The frame sizes are written relative to `\textwidth` and `\textheight`, which come from `geometry` (main.tex:2): flow frame 0.67 of the width, static frame 0.25 of the width starting at 0.74, both 0.82 of the height. Emitter order matters: geometry before the frame commands (main.tex:2, 20-21).
- README.md:1-10 is a plain description (no text addressed to an AI).
