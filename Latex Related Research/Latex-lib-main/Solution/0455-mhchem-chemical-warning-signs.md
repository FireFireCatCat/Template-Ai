yes

# 0455-mhchem-chemical-warning-signs: mhchem Chemical Warning Signs

- Unverified: read from the source, not compiled.
- Source: Source/0455-mhchem-chemical-warning-signs/ (origin: https://latextemplates.com/downloads/mhchem-signs.zip; licence: LPPL-1.3c per the manifest)
- Kind: misc (a one-page landscape warning board: two coloured hazard signs and a fill-in label strip)
- Lib: v4
- Engine: pdfLaTeX-compatible (README.md:7 says "Compile with pdfLaTeX"; no `fontspec`, no Lua)
- Look carried by: preamble (kernel `article` is loaded unchanged; the look is the `geometry` call, one `\newcommand` wrapper and the body, main.tex:1-8)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip; its source was not read)
- Main file: main.tex (other samples: none)
- Read: main yes (all 26 lines), zip-local classes and styles none present (the zip holds only main.tex and README.md)

## Verdict
yes. The zip is a 26-line sample on the kernel `article` class with no zip-local `.cls`, `.sty` or macro file. The only bespoke item is the one-line `\warning` command (main.tex:7-8), an alias of `\fcolorbox` around a centred `minipage` with font switches. It reduces by inline expansion to lib ways. The only unusual package is `mhchem`, a published CTAN package (ctan.org/pkg/mhchem: LPPL 1.3c, in TeX Live), used for two inline formulae. Those are content, not drawing (`art.content-package`, held as Content-opaque, as the other mhchem zips do). There is no TikZ or other artwork.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `landscape` (main.tex:1)
- Class-native vocabulary used: none (no `\maketitle`, no `abstract`, no sectioning, no bibliography; the title line is hand-set in the body)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | options `a4paper,landscape` |
| paper size and orientation | main.tex:1 | `page.class-options` | `a4paper`, `landscape` |
| page geometry | main.tex:2 | `page.geometry` | `margin=15mm` |
| colour | main.tex:3 (names used at 7, 15, 17, 19) | `color.xcolor` | plain `\usepackage{xcolor}`; named colours `red`, `orange`, `black`, `gray` and tints `<name>!10` (`#1!10` at 7, `gray!10` at 19) |
| header/footer | main.tex:6 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no running head or page number) |
| centring | main.tex:10, 25 (`center` env); main.tex:8, 19 (`\centering`) | `sp.ragged` | `center` environment around the whole board; `\centering` inside each sign box (the kernel `center` environment is the same family as `\centering`) |
| board title line | main.tex:11 | `font.size-commands` | `\fontsize{36}{40}\selectfont`, in a brace group closed by `\par` |
| board title line, face | main.tex:11 | `mark.kernel` | `\sffamily\bfseries` |
| subtitle line | main.tex:13 | `font.size-commands`, `mark.kernel` | `\large`; `\sffamily`; `\texttt{mhchem}` for the package name (content) |
| sign box frame and fill | main.tex:7 (macro body), 15, 17 (calls) | `box.fancybox` | `\fcolorbox{<c>}{<c>!10}{...}` with `<c>` = `red`, `orange` |
| sign box width and alignment | main.tex:7 | `box.minipage` | `\begin{minipage}[t]{.43\linewidth}` (top-aligned, 0.43 of the line) |
| sign text face | main.tex:8 | `mark.kernel`, `font.size-commands` | `\sffamily\bfseries`; `\Large` |
| sign line breaks inside text | main.tex:15, 17 | `sp.manual-space` | `\\[4pt]` between hazard word, formula and instruction |
| size reset for the instruction line | main.tex:15, 17 | `font.size-commands` | `\normalsize` |
| two signs spread apart | main.tex:16 | `sp.manual-space` | `\hfill` between the two `\warning` calls |
| vertical gaps | main.tex:12, 14, 18 | `sp.manual-space` | `\vspace{3mm}`, `\vspace{10mm}`, `\vspace{12mm}` |
| label strip frame | main.tex:19, 24 | `box.fancybox` | `\fcolorbox{black}{gray!10}{...}` |
| label strip body | main.tex:19, 23-24 | `box.minipage`, `sp.ragged` | `minipage{.84\linewidth}`; `\centering\sffamily` (via `mark.kernel`) |
| label strip captions | main.tex:20-22 | `mark.kernel` | `\textbf{Substance:}`, `\textbf{Location:}`, `\textbf{Owner:}` |
| fill-in blanks | main.tex:20-22 | `sp.rule` | `\rule{42mm}{.4pt}` twice, `\rule{35mm}{.4pt}` once |
| spacing between blanks | main.tex:20-21 | `sp.manual-space` | `\quad`; `\\[4pt]` at main.tex:22 |
| chemical formulae | main.tex:4 (load), 15, 17 (use) | `art.content-package` | `\usepackage{mhchem}` with no options; `\ce{H2O2}`, `\ce{H2SO4}` (content, see Content-opaque) |
| table package, load only | main.tex:5 | `tbl.tabular` | `\usepackage{array}`; no `tabular` appears in the body, so nothing is printed |

Nothing else is defined or used: no numbering, theorems, floats, captions, code, notes, bibliography, index or cross-references (main.tex:9-26 is the whole body).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\warning}[2]` | main.tex:7-8 | yes | Inline expansion at each of the two calls (main.tex:15, 17): `\fcolorbox{<c>}{<c>!10}{\begin{minipage}[t]{.43\linewidth}\centering\sffamily\bfseries\Large <text>\end{minipage}}`, i.e. `box.fancybox` + `box.minipage` + `sp.ragged` + `mark.kernel` + `font.size-commands`. Arguments are a colour name (`color.xcolor`) and content text. It has no counter, conditional, `\def` or redefinition of a kernel internal, so it is a pure alias. |

## Content-opaque
- `\ce{H2O2}` (main.tex:15) and `\ce{H2SO4}` (main.tex:17): mhchem formulae inside the sign text. They are the specific substances, i.e. content. The package needs no tool outside TeX. The mhchem bundle also carries `hpstatement` and `rsphrase` (hazard and risk phrases, per ctan.org/pkg/mhchem), but the sample loads neither (main.tex:4 loads `mhchem` only).
- The hazard words, safety sentences, title and subtitle text (main.tex:11, 13, 15, 17, 23) are text content.

Note on the README: README.md:1-7 is a plain description ("Replace the example substances and safety text before use"); it addresses no AI and gives no instruction beyond the pdfLaTeX note.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
