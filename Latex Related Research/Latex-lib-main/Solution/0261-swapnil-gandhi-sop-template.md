yes

# 0261-swapnil-gandhi-sop-template: CS PhD Statement of Purpose template (Swapnil-Gandhi/SoP-Template)

- Unverified: read from the source, not compiled.
- Source: Source/0261-swapnil-gandhi-sop-template/ (origin: https://codeload.github.com/Swapnil-Gandhi/SoP-Template/zip/refs/heads/main; licence: CC0-1.0, LICENSE.md:3 "CC0 1.0 Universal")
- Kind: misc (a graduate-school Statement of Purpose: running text, a header on every page, footnotes, a hand-typed reference list; no title block, headings, floats or lists)
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:44 says `pdflatex SoP.tex`; `T1` + `utf8` inputenc, no fontspec)
- Look carried by: preamble (the class is the unmodified kernel article; the look is margins, line spread and one `fancyhdr` header, all in the sample's preamble)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip)
- Main file: SoP.tex (other samples: none; the zip also holds README.md, LICENSE.md and the compiled SoP.pdf, 2 pages, not read as source)
- Read: main yes (all 138 lines), zip-local classes and styles none present (no .cls .sty .def .cfg .clo .bst in the zip)

## Verdict
yes. The whole template is one `\documentclass{article}` with no options, a preamble of published packages (`fontenc`, `inputenc`, `natbib`, `hyperref`, `xcolor`, `xspace`, `fancyhdr`) and kernel length and spacing commands, and a body of plain paragraphs with `\textbf`, `\underline`, `\footnote` and `\url`. The only bespoke code is a handful of preamble `\newcommand`/`\def` items (text aliases and the pieces of one running header), and each reduces to inline kernel commands plus `fancyhdr` fields. There is no artwork, no external tool and no unmapped component.

## Blockers
none

## Class setting
- Class: `class.article` options: none (default 10pt, letter, oneside; SoP.tex:1)
- Class-native vocabulary used: none. The sample does not call `\maketitle`, `\title`, `\author`, `abstract` or any `\section`; it uses only the body text and footnote commands the class provides.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | SoP.tex:1 | `class.article` | no options |
| encoding | SoP.tex:2-3 | `font.fontenc-t1` | `fontenc` option `T1`; `inputenc` option `utf8`. Text face is the default Computer Modern (no font package, no `\familydefault`) |
| line spacing | SoP.tex:6 | `sp.linespread` | `\linespread{1.18}` for the whole document |
| page margins | SoP.tex:9-14 | `page.setlength` | `\addtolength` on `\oddsidemargin` -.875in, `\evensidemargin` -.875in, `\textwidth` +1.75in, `\topmargin` -.875in, `\textheight` +1.75in (relative to the article letter defaults) |
| running header (fields) | SoP.tex:20, 45-48, 62-63 | `hf.fancyhdr` | `\usepackage{fancyhdr}` (loaded twice, no options), `\pagestyle{fancy}`, `\fancyhf{}` clears all fields, `\fancyhead[LE,RO]{...}`, `\fancyhead[RE,LO]{Statement of Purpose \| Stanford University}`, `\renewcommand\headrulewidth{0pt}`; no footer, no `\thispagestyle` |
| header right block: two right-aligned lines | SoP.tex:55-61 | `box.minipage`, `sp.manual-space` | `minipage` width 120pt, lines flushed right with `\hfill`, split by `\par` (the macro `\header`) |
| header gap and vertical bar | SoP.tex:48-54 | `sp.manual-space`, `sp.rule` | gap `\hskip` of 5pt (from skip register `\linepagesep`, SoP.tex:49); bar `\rule[-10pt]{0.75pt}{25pt}` (macro `\vfootline`); then `\thepage` |
| colour model | SoP.tex:18 | `color.xcolor` | `\usepackage{xcolor}`, no options; used only through colour expressions in `\hypersetup` (`red!50!black`, `blue!50!black`, `blue!80!black`) |
| links | SoP.tex:17, 21-26 | `meta.hyperref` | `colorlinks`, `linkcolor={red!50!black}`, `citecolor={blue!50!black}`, `urlcolor={blue!80!black}` |
| URLs in text | SoP.tex:92, 125, 130, 132 | `meta.url` | `\url{...}`, provided by `hyperref` (no separate `url` line) |
| citation package | SoP.tex:16 | `bib.natbib` | `\usepackage{natbib}`, no options; no `\cite`, `\bibliography` or `thebibliography` anywhere, so it is loaded and unused |
| reference list | SoP.tex:124-132 | `mark.kernel`, `mark.ulem` | hand-typed paragraphs "[1]" to "[4]" (the numbering is literal text, not a counter); `\textbf` for venues, `\underline` for the author's name (kernel `\underline`, the `ulem` package is not loaded); content, no heading |
| emphasis in running text | SoP.tex:69, 76-77, 81, 83, 88, 90, 92-94, 108, 111 | `mark.kernel` | `\textbf{...}` |
| footnotes | SoP.tex:88, 92, 101 (two on that line) | `fn.kernel` | `\footnote{...}`, class default numbering and layout |
| inline maths | SoP.tex:77 | `math.kernel` | `$\mathbf{P^{3} ~[1]}$`, `$P^{3}$`: kernel inline maths, no `amsmath`; content |
| space before references | SoP.tex:118 | `sp.manual-space` | `\vspace{0.125in}` |
| paragraphs, indentation | SoP.tex:69-115 | `class.article` | class defaults: first-line indent, no `parskip`, no `indentfirst` |
| front matter, headings, lists, tables, figures, theorems, code, index, language | not used | none | no `\maketitle`, `abstract`, `\section`, list, `figure`, `table`, theorem, listing, `babel` or `\appendix` in SoP.tex |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\HRule`, `\Hrule` (rules of `\linewidth`, 0.5mm and 0.3mm) | SoP.tex:28-29 | yes (and unused: no call in the file) | `\rule{\linewidth}{0.5mm}` is `sp.rule`; nothing to emit as the macros are never called |
| `\graphite`, `\wave` (text plus `\xspace`) | SoP.tex:32-33 | yes | text aliases: inline "GRAPHITE", "WAVE" at each use (SoP.tex:90-94); the `xspace` load (SoP.tex:19) then has no remaining use, so it needs no way (considered: `xspace`, not proposed) |
| `\schoolShort`, `\school`, `\schoolLong` | SoP.tex:36-38 | yes | text aliases: inline "Stanford" / "Stanford University" at SoP.tex:62, 69, 108, 110, 115 |
| `\profOne`, `\profTwo`, `\profThree` | SoP.tex:40-42 | yes | text aliases: inline the names at SoP.tex:111 |
| `\linepagesep` (`\newskip`, set to 5pt) | SoP.tex:49 | yes | one literal 5pt gap: `\hspace{5pt}` (`sp.manual-space`) |
| `\vfootline` (`\begingroup \rule[-10pt]{0.75pt}{25pt} \endgroup`) | SoP.tex:50-54 | yes | the grouping adds nothing; inline `\rule[-10pt]{0.75pt}{25pt}` (`sp.rule`) |
| `\header` (`minipage` 120pt, `\hfill` name, `\par`, `\hfill` area) | SoP.tex:55-61 | yes | inline into the `fancyhdr` field: `\begin{minipage}{120pt}\hfill Swapnil Gandhi\par\hfill CS, PhD, Fall 2022\end{minipage}` (`box.minipage` + `sp.manual-space`) |
| Whole header assembly | SoP.tex:48 | yes | `\fancyhead[LE,RO]{<minipage>\hspace{5pt}\rule[-10pt]{0.75pt}{25pt}\thepage}` with the pieces above; all kernel commands, no copied macro logic |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered `xspace` (a spacing helper used only inside the text aliases above): not proposed, since inlining the alias text removes the need for it.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
