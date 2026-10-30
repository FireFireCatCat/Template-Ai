yes

# 0711-classic-lined-title-page: Classic Lined Title Page

- Unverified: read from the source, not compiled.
- Source: Source/0711-classic-lined-title-page/ (origin: https://latextemplates.com/downloads/classic-lined-title-page.zip; licence: LPPL-1.3c)
- Kind: journal (a short physics preprint with a masthead title page, abstract and four sections; the manifest hint "misc" is not used)
- Lib: v5
- Engine: pdfLaTeX-compatible (no fontspec, unicode-math, polyglossia or Lua code anywhere in the zip)
- Look carried by: preamble (published `hep-title` and `titling` are loaded at main.tex:2-3; the only look the sample adds itself is the pair of hook settings at main.tex:9-10; the zip has no local class or style)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip is one 80-line `main.tex` on kernel `article` (main.tex:1); the manifest counts 1 file, so there is no `.cls`, `.sty` or other local file. Every construct is a published package or a kernel command: `hep-title` (series line, arXiv corner block, `\email`, `\preseries` and `\postseries` hooks), `titling`, the `\author[n]` and `\affil[n]` syntax that `hep-title` brings through `authblk`, `siunitx`, and kernel `\section`, `abstract`, `\maketitle`. The only material the sample writes itself is the text of the two hooks at main.tex:9-10 (a `center` environment, two `\rule` calls, `\\[4pt]`, `\Large`, `\scshape`): all lib ways set by lengths, so reducible. No artwork, no external tool, no unmapped component. Caveat: the source of `hep-title`, `titling`, `authblk` and `siunitx` is not in the zip and was not read; that `\preseries` and `\postseries` are `hep-title` hooks for the series field rests on the lib line `front.hep-title` ("pre/post hooks per field") plus the cross-check in the Notes, and the zip defines neither command.

## Blockers
none

## Class setting
- Class: `class.article` options: none (main.tex:1)
- Class-native vocabulary used: `\title`, `\author`, `\date`, `\maketitle` (main.tex:15-24); `abstract` environment (main.tex:26-32); `\section` (main.tex:34, 43, 52, 71); `\today` (main.tex:20)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | no options |
| page size, margins, base font size | main.tex:1 | `page.class-options` | nothing set: article defaults; no `geometry`, no `\setlength` of the text block anywhere in the file |
| title block extension: series line, arXiv corner block | main.tex:2, 12, 13 | `front.hep-title` | `\usepackage{hep-title}` with no options; `\series{Whitmore Institute Preprint Series}`, `\arxiv{2611.04821}` |
| series masthead hooks (the "lined" frame) | main.tex:9, 10 | `front.hep-title` | `\preseries{<opening material>}` and `\postseries{<closing material>}`; the hook text is mapped in the next five rows |
| masthead centring | main.tex:9, 10 | `sp.ragged` | `center` environment opened in `\preseries` and closed in `\postseries` (kernel alignment, the family of `\centering`) |
| rules above and below the series line | main.tex:9, 10 | `sp.rule` | `\rule{0.6\linewidth}{0.4pt}` before and after the series text |
| masthead line gaps | main.tex:9, 10 | `sp.manual-space` | `\\[4pt]` after the upper rule and before the lower rule |
| series line size | main.tex:9 | `font.size-commands` | `\Large` |
| series line small caps | main.tex:9 | `mark.kernel` | `\scshape` (kernel font-switch command) |
| title restyling package | main.tex:3 | `front.titling` | `\usepackage{titling}` with no options (a second load: `hep-title` builds on it per the lib line); no `\pretitle`, `\posttitle`, `\preauthor`, `\postauthor`, `\predate` or `\postdate` call anywhere in the file |
| authors and affiliations | main.tex:16, 17, 18, 19 | `front.authblk` | `\author[1]{..}`, `\author[1,2]{..}`, `\affil[1]{..}`, `\affil[2]{..}`; `authblk` is not loaded in the sample, so the syntax comes through `hep-title` (lib line: builds on `authblk`) |
| author e-mail | main.tex:16 | `front.hep-title` | `\email{e.vasquez@example.edu}` inside the `\author` argument; `\email` is listed on the lib line |
| title, date, title page | main.tex:15, 20, 22, 24 | `front.maketitle` | `\title{..}`, `\date{\today}`, `\maketitle` |
| abstract | main.tex:26-32 | `abs.kernel` | `abstract` environment, no `abstract` package |
| headings | main.tex:34, 43, 52, 71 | `head.kernel` | four `\section`, article default look and numbering; no `\renewcommand`, no `titlesec` |
| physical units | main.tex:4, 46, 49, 50 | `mark.siunitx` | `\usepackage{siunitx}` no options; `\SI{4.2}{\second}`, `\SI{2}{\milli\meter}`, `\SI{14}{\milli\meter}` |
| inline maths | main.tex:55, 56, 59 | `math.kernel` | `$Q$` and `$Q^{-1}$` in kernel maths, no `amsmath` loaded by the sample (the symbols are content) |

Not set anywhere in the sample, so they stay at the article defaults and need no way: header and footer (no `\pagestyle`), fonts and colours (no font or `xcolor` package), paragraph spacing, lists (the "(i) (ii) (iii)" at main.tex:62-69 is running text, not a list environment), floats, tables, captions, theorems, code, boxes, bibliography, index, cross-references (no `\label` or `\ref`), language (no `babel`), PDF metadata (no `hyperref`).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\preseries{..}` and `\postseries{..}` hook text | main.tex:9, 10 | yes | Two assignments of declarative hook text, printed as two preamble lines under `front.hep-title`. `\begin{center}` is opened in the first hook and `\end{center}` closed in the second, the same pre/post pairing `titling` documents for its own fields, so no node wrapper is needed. Content: `sp.ragged` + `sp.rule` (`0.6\linewidth` by `0.4pt`) + `sp.manual-space` (`4pt`) + `font.size-commands` (`\Large`) + `mark.kernel` (`\scshape`). |

There is no `\newcommand`, `\def`, `\newenvironment`, counter, conditional, local class or local style in the zip (whole of main.tex read).

## Content-opaque
none (no figure, table, TikZ or other drawing in the sample)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- CTAN read for W1: https://ctan.org/pkg/hep-title (Jan Hajer, LPPL 1.3c, in TeX Live and MiKTeX; the page lists no commands, so the command names above come from the sample and the lib line). `titling`, `siunitx` and `authblk` were not looked up; they are long-standing CTAN and TeX Live packages.
- Cross-check, second hand: a grep of `Solution/` for `hep-title` (made to see how the lib way is used) showed that another solution file records, from the `hep-title` documented source, `\preseries` and `\postseries` as hooks of the `\series` field, `\RequirePackage{authblk}` with `\author[labels]` and `\affil` patched, and a pdfLaTeX-compatible engine. That file was not edited and no other zip was analysed; the claims here do not depend on it beyond confirming the lib line.
- The sample shows a possible overlap: `\affil` (authblk) and `hep-title`'s own `\affiliation` coexist in the package; the sample uses only `\affil`. Whether it builds cleanly is not tested here (nothing was compiled).
- Comment at main.tex:6-8 describes the intent of the rules (a "lined" masthead); it is addressed to no AI and is ignored as an instruction either way.
