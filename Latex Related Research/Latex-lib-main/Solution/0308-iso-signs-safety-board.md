yes

# 0308-iso-signs-safety-board: ISO Signs Safety Board

- Unverified: read from the source, not compiled.
- Source: Source/0308-iso-signs-safety-board/ (origin: https://latextemplates.com/downloads/isosigns-safety-signs.zip; licence: LPPL-1.3c)
- Kind: misc (a one-page landscape safety notice: title, rule, three pictograms with captions, footer note)
- Lib: v3
- Engine: pdfLaTeX-compatible (every package the sample loads is a standard pdfTeX one; the `isosigns` source is not in the zip and was not read, so its own engine needs are not established, nothing in the sample uses fontspec or Lua)
- Look carried by: preamble (no zip-local class or style; the look is the sample's own preamble plus a hand-laid body over plain `article` and the published `isosigns` package)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Every construct in the 35-line sample is a published command or package: kernel `article` with `a4paper,landscape`, `geometry`, `xcolor`, `array`, kernel font switches, `\rule`, `center`, and the CTAN package `isosigns` (LPPL-1.3c, in TeX Live and MiKTeX, per ctan.org/pkg/isosigns) whose `\Isosign[scale=..]{page}` prints one pictogram. There is no zip-local class, style, macro, counter or conditional, and no drawn artwork in the zip, so there is nothing bespoke to reduce and no `ART`. The one judgement is the mapping of `isosigns` to `font.icons` (a pictogram-printing package, the package being the parameter); the choice of which signs to print is content. `yes`, with the caveat that the `isosigns` source was not read (it is not bundled; README.md:10-11).

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `landscape` (main.tex:1). Source not read (ships with the TeX distribution, not bundled).
- Class-native vocabulary used: none (no `\maketitle`, no `abstract`, no sectioning, no `\tableofcontents`; the body uses only `center`, `tabular` and font switches).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class and paper | main.tex:1 | `class.article` | a4paper, landscape |
| paper and orientation by class options | main.tex:1 | `page.class-options` | a4paper, landscape |
| page geometry | main.tex:2 | `page.geometry` | margin=1.2cm (all four sides) |
| page style | main.tex:7 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no header, footer or page number) |
| image package load | main.tex:3 | `fig.graphicx` | `\usepackage{graphicx}` loaded; no `figure`, `\includegraphics` or caption anywhere in the body (the package is not called by the sample itself) |
| colour package and named colours | main.tex:4, main.tex:12 | `color.xcolor` | `\usepackage{xcolor}`; `\color{Warning}` (a name the zip does not define; presumably an ISO 3864 safety colour supplied by `isosigns`, not read) and `\color{black}` |
| pictogram package | main.tex:5, main.tex:20-22 | `font.icons` | package `isosigns`, no load options; `\Isosign[scale=0.30]{1}`, `{2}`, `{3}` (key `scale`, argument a sign-sheet page number) |
| title block (hand-laid, not `\maketitle`) | main.tex:9-13 | `sp.ragged` | `center` environment holding the title, the subtitle and the rule |
| title face and size | main.tex:10 | `mark.kernel`, `font.size-commands` | `\sffamily\bfseries`; `\fontsize{30}{34}\selectfont` inside a brace group, closed with `\par` |
| subtitle face and size | main.tex:11 | `mark.kernel`, `font.size-commands` | `\sffamily`; `\large` |
| title block spacing | main.tex:11-12 | `sp.manual-space` | `\vspace{.15cm}` before the subtitle, `\vspace{.4cm}` before the rule |
| coloured rule under the title | main.tex:12 | `sp.rule`, `color.xcolor` | `\rule{.88\linewidth}{2pt}` set in `\color{Warning}`, then `\color{black}` |
| sign board table | main.tex:16-26 | `tbl.tabular` | `tabular` with `array` (main.tex:6) and three `m{.28\linewidth}` columns, each `>{\centering\arraybackslash}`; two rows, signs then captions; no rules, no booktabs |
| row height | main.tex:15 | `tbl.tabular` | `\renewcommand{\arraystretch}{1.35}` (an `array` parameter) |
| cell centring | main.tex:16-19 | `sp.ragged` | `\centering\arraybackslash` in the column preambles; the table sits in a `center` environment (main.tex:16, 27) |
| sign captions | main.tex:23-25 | `mark.kernel` | `\sffamily\bfseries` on three upper-case strings (content) |
| push footer to page bottom | main.tex:29 | `sp.manual-space` | `\vfill` |
| footer note | main.tex:30-34 | `sp.ragged`, `mark.kernel`, `font.size-commands` | `center` environment with `\sffamily\small`; the text is a disclaimer (content) |

## Bespoke code
none. The sample defines no `\newcommand`, `\def`, environment, counter, conditional or colour of its own; the only redefinition is `\renewcommand{\arraystretch}{1.35}` (main.tex:15), a parameter of `array`. The README (README.md:1-12) says the `isosigns` package and its sign sheet are supplied by TeX Live and are not bundled, so the zip holds no class or style file.

## Content-opaque
- The choice of pictograms: sign-sheet page numbers 1, 2, 3 (main.tex:20-22), which the README says are placeholders to replace (README.md:4-6, main.tex:31-32). The sign artwork itself comes from the `isosigns` package, not from the zip.
- Caption strings and the disclaimer text (main.tex:10-11, 23-25, 31-33).
- Line 25 ends with a single stray `\` (a typo for a row end or a control space); it is content, not template.

## Lib changes
- New ways proposed: none. `isosigns` is placed under the existing `font.icons` (the lib line covers packages whose commands print a pictogram, with the package as the parameter, as for `pifont`, `marvosym`, `hologo`). Checked against W1 to W4 for `isosigns`: W1 published (CTAN, LPPL-1.3c, TeX Live and MiKTeX, topics "Graphics symbols; Logo"); W2 one optional `scale` key and a page-number argument; W3 serves any ISO 3864, 7010 or 7001 sign, not one document; W4 one `\usepackage{isosigns}` line plus an inline `\Isosign[scale=..]{n}`. It prints from a supplied sign sheet rather than a font glyph, so a consolidator who reads `font.icons` as glyph-only could widen its text or file a separate line; I did not propose one because the lib text already admits pictogram packages. Considered: `art.content-package` (restricted way; rejected, because the signs are chosen content in table cells, not drawn template identity, and no drawing code is in the zip).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
