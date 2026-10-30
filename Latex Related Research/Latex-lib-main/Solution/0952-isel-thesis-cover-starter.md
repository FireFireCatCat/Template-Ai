yes

# 0952-isel-thesis-cover-starter: ISEL Thesis Cover Starter

- Unverified: read from the source, not compiled.
- Source: Source/0952-isel-thesis-cover-starter/ (origin: https://latextemplates.com/downloads/isel-thesis.zip; licence: not established, the manifest says "UNKNOWN (licence not verified)" and README.md:3 says no verified redistribution licence exists)
- Kind: thesis (a cover and front-matter starter; the manifest hint "misc" is only the source category)
- Lib: v6
- Engine: pdfLaTeX-compatible (`fontenc` T1, `inputenc` utf8, `lmodern`; no `fontspec`, no Lua code)
- Look carried by: preamble (the published `report` class is loaded unchanged; page, font, colour and link setup sit in the one-line preamble; the cover is laid by hand in the sample body from kernel commands)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; the zip holds only main.tex and README.md)
- Read: main yes, zip-local classes and styles none present

Note on citations: main.tex is one physical line (762 characters, one newline), so every citation is `main.tex:1`. The "col" number is the 0-based character offset of the cited token on that line, measured read-only.

## Verdict
yes. The whole template is the kernel `report` class (`a4paper,12pt`) plus eight `\usepackage` lines and a hand-laid `titlepage` that uses only kernel spacing, size, rule and `tabular` commands, all of which have lib ways. The zip holds no `.cls`, `.sty` or other zip-local file and the sample defines no macro (a read-only count of `\newcommand`, `\def`, `\let`, `\newenvironment`, counters and `\input` gave 0). There is no drawing and no tool outside TeX. The `report` source was not read (it ships with the TeX distribution).

## Blockers
none

## Class setting
- Class: `class.report` options: `a4paper`, `12pt` (main.tex:1 col 0)
- Class-native vocabulary used: `\chapter`, `\chapter*`, `\tableofcontents`, and the kernel `titlepage` environment (main.tex:1 cols 218, 625, 685, 701). No `abstract` environment, no `\maketitle`, no `\title`/`\author`/`\date` is used.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 col 0 | `class.report` | a4paper, 12pt |
| paper size and base size | main.tex:1 col 0 | `page.class-options` | a4paper, 12pt |
| page geometry | main.tex:1 col 36 | `page.geometry` | margin=3cm |
| font encoding and input | main.tex:1 cols 69, 93 | `font.fontenc-t1` | `fontenc` option T1; `inputenc` option utf8 |
| text and maths face | main.tex:1 col 120 | `font.lmodern` | `\usepackage{lmodern}`, no options |
| colour | main.tex:1 cols 140, 345 | `color.xcolor` | `xcolor` with no options; `\color{teal!65!black}` (base name `teal` mixed 65 percent with black) |
| link look and PDF links | main.tex:1 cols 159, 180 | `meta.hyperref` | `hyperref` loaded, `\hypersetup{hidelinks}`; no `\ref`, `\autoref` or `\href` is called |
| cover page | main.tex:1 cols 218 to 610 | `front.titlepage-env` | `titlepage` environment holding: institution line, degree line, rule, title, subtitle, author and supervisor block, place and `\today` (kernel date command, printed as content in the last line, col 587) |
| cover alignment | main.tex:1 col 235 | `sp.ragged` | `\centering` as the first command of the environment |
| cover vertical spacing | main.tex:1 cols 245, 333, 392, 472, 581 | `sp.manual-space` | `\vspace*{1cm}`, `\vspace{2cm}`, `\vspace{.7cm}`, `\vspace{1.6cm}`, `\vfill` (the last pushes the place and date line to the foot) |
| cover text sizes | main.tex:1 cols 258, 303, 405, 438, 587 | `font.size-commands` | `\Large` (institution), `\large` (degree), `\Huge` (title), `\Large` (subtitle), `\large` (place and date), each in a group closed by `\par` |
| cover title weight | main.tex:1 col 405 | `mark.kernel` | `\bfseries` |
| cover rule | main.tex:1 col 345 | `sp.rule` | `\rule{\textwidth}{1.5pt}` inside a group that sets `\color{teal!65!black}` through `xcolor` |
| cover author block | main.tex:1 col 486 | `tbl.tabular` | `tabular` with column spec `{rl}`, two rows separated by `\\`, labels "Author / Autor:" and "Supervisor / Orientador:" (cell text is content) |
| abstract | main.tex:1 col 625 | `head.kernel` | the abstract is an unnumbered chapter, `\chapter*{Resumo / Abstract}`; not `abs.kernel`, no `abstract` environment is used |
| headings | main.tex:1 cols 625, 701 | `head.kernel` | `\chapter*` and `\chapter` at `report` defaults; no `titlesec`, no `\renewcommand` of heading format |
| contents | main.tex:1 col 685 | `toc.kernel` | `\tableofcontents`, no depth change |

Not defined by the zip, so no row: running heads (report default page styles), footnotes, lists, floats, captions, theorems, code, bibliography, index, language packages (`babel` is not loaded, the Portuguese and English text is typed directly under utf8 and T1).

## Bespoke code
none. The sample has no `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, counter, conditional or `\input` (main.tex:1, whole line scanned), and the zip has no `.cls`, `.sty`, `.def`, `.cfg` or `.clo` file.

## Content-opaque
none. The only non-text constructs are the `\rule` and the `tabular`, both mapped above. The README (README.md:1 to 3) is a plain description and holds no text addressed to an AI.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
