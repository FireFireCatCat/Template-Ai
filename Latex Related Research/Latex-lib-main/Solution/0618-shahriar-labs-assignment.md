yes

# 0618-shahriar-labs-assignment: Shahriar-Labs Assignment

- Unverified: read from the source, not compiled.
- Source: Source/0618-shahriar-labs-assignment/ (origin: https://latextemplates.com/downloads/shahriar-assignments.zip; licence: MIT per the manifest; README.md:7 says the upstream repository is MIT with exceptions whose per-directory terms were not verified)
- Kind: assignment
- Lib: v5
- Engine: pdfLaTeX-compatible (README.md:7 says compile with PDFLaTeX; the packages loaded at main.tex:2-3 are all pdfTeX packages)
- Look carried by: preamble (kernel `article` at its defaults; the look is `geometry` at main.tex:2 plus two `\newcommand` wrappers at main.tex:4-5)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex, 15 lines, and README.md, 7 lines)

## Verdict
The zip is a 15-line `article` sheet. Its only own code is two `\newcommand` wrappers (main.tex:4-5), and each reduces by inline expansion to kernel sectioning, `\hfill`, `\fbox`, `\parbox` and `\vspace`. There is no zip-local class or style, no artwork, no external tool and no counter or conditional that drives output. Every component has a lib way, so an emitter could write the preamble and the body wrappers from published packages and kernel commands alone. The look is the article default plus the preamble, so this is not a class-carried zip.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (main.tex:1). The class source is not bundled in the zip and was not read; it ships with the TeX distribution.
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (main.tex:6-9), starred `\subsection*` (main.tex:4) and `\section*` (main.tex:14), `itemize` (main.tex:14). No `abstract` environment, no bibliography, no appendix.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | option `11pt` |
| text size | main.tex:1 | `page.class-options` | `11pt` as a class option |
| page geometry | main.tex:2 | `page.geometry` | `a4paper`, `margin=2.5cm` |
| maths packages | main.tex:3 | `math.amsmath`, `math.amssymb` | loaded with no options; the inline formula `$f(x)=x^2-4x+3$` (main.tex:12) is content |
| list package | main.tex:3 | `list.enumitem` | loaded with no options; the only call is `[nosep]` at main.tex:14 |
| hyperref | main.tex:3 | `meta.hyperref` | default options, no `\hypersetup`; the body has no link, `\ref` or `\url`, so nothing shows |
| title block | main.tex:6-9 | `front.maketitle` | `\title{Course Assignment}`, `\author` of two lines split by `\\` (module name, then a student line), `\date` set to a string in place of `\today`, `\maketitle` right after `\begin{document}` |
| fill-in blanks in author and date | main.tex:7-8 | `sp.rule` | `\rule{6cm}{0.4pt}` and `\rule{4cm}{0.4pt}` |
| submission-notes paragraph | main.tex:10 | `sp.lengths`, `mark.kernel` | `\noindent` (nearest fit, see Bespoke note), `\textbf{Submission notes:}` |
| question headings | main.tex:4, 11-13 | `head.kernel`, `sp.manual-space` | unnumbered `\subsection*{title\hfill[N points]}`; `\hfill` pushes the points to the right margin; titles "Concept check", "Worked problem", "Short analysis"; points 10, 20, 20 |
| work area box | main.tex:5, 11-13 | `box.fancybox`, `box.minipage`, `sp.manual-space`, `sp.lengths` | `\noindent\fbox{\parbox{0.94\linewidth}{\vspace{h}}}`; an empty framed box whose height is the `\vspace` argument; `h` = 1.5cm (main.tex:11), 2.6cm (main.tex:12), 2.0cm (main.tex:13) |
| checklist heading | main.tex:14 | `head.kernel` | unnumbered `\section*{Marking checklist}` |
| checklist list | main.tex:14 | `list.kernel`, `list.enumitem` | `itemize` with `[nosep]`, three `\item` lines |

Not defined by the sample, so no row: fonts and encoding (Computer Modern default, no font package), colour, header and footer (article default page style), page numbering, spacing beyond the box and heading values above, numbered headings, theorems, floats, tables, captions, code, bibliography, index, cross-references, language, front matter other than the title block.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\question[2]` | main.tex:4 | yes | `\newcommand` alias. The emitter writes `\subsection*{<title>\hfill[<N> points]}` at each call: `head.kernel` (starred subsection) with `sp.manual-space` (`\hfill`). The text "points" is content. |
| `\workarea[1]` | main.tex:5 | yes | `\newcommand` alias. The emitter writes `\noindent\fbox{\parbox{0.94\linewidth}{\vspace{<len>}}}`: `box.fancybox` (`\fbox`), `box.minipage` (`\parbox`, width `0.94\linewidth`), `sp.manual-space` (`\vspace`), `sp.lengths` (`\noindent`). |

Bespoke note: `\noindent` (main.tex:5, 10) has no line of its own in the lib. It is the per-paragraph form of `\parindent`, a kernel paragraph-indentation command that adds no typesetting behaviour, so it is filed under `sp.lengths` as the nearest home. This is a stretch of that line's wording, not a new way, and it does not affect the verdict. There is no zip-local counter, conditional, class or style.

## Content-opaque
none (the one formula at main.tex:12 is ordinary inline maths, content that `math.amsmath` holds)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
