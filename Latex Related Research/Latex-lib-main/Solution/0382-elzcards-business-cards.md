yes

# 0382-elzcards-business-cards: elzcards Business Cards

- Unverified: read from the source, not compiled.
- Source: Source/0382-elzcards-business-cards/ (origin: https://latextemplates.com/downloads/elzcards.zip; licence: LPPL-1.3c-or-later, as the manifest and README.md:5 say)
- Kind: misc
- Lib: v4
- Engine: pdfLaTeX-compatible (README.md:8 says pdfLaTeX; the sample loads no fontspec or other xe/lua package; the `elzcards` source is not in the zip and was not read)
- Look carried by: preamble (the kernel `article` class carries nothing; the published `elzcards` package imposes the cards and the crop lines; the sample's own preamble sets the page, the three colours and both card faces, main.tex:4-34)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip is a 43-line `main.tex` and a README, with no `.cls`, `.sty` or other local file. The class is the kernel `article` loaded unchanged. The sheet imposition (card size, front and reverse side, crop lines) belongs to the published `elzcards` package (CTAN, TeX Live, LPPL), which the README says is not bundled (README.md:5). It is one doc-kind way, `ticket.sheet`, proposed below, with its options as parameters. The two card faces are `\newcommand` macros built only from kernel colour, size, bold, spacing and `center` commands plus `xcolor`; they reduce by inline expansion, and there is no counter, conditional, loop or drawing. The package's own source was not read, so its internals and its full option list are taken from the CTAN page and the sample's use.

## Blockers
none

## Class setting
- Class: `class.article` options: none (main.tex:1). Kernel class, not bundled in the zip; its source was not read.
- Class-native vocabulary used: none (no `\maketitle`, abstract, sectioning, list, float or bibliography; the body is two package calls, main.tex:40-41). The vocabulary in use belongs to the `elzcards` package, not the class: `\BusinessCard{front}[back]` and `\MakeBC[keys]`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | no options |
| card sheet imposition: package load | main.tex:3 | `ticket.sheet` | `\usepackage{elzcards}`, no options (loaded before `geometry`, main.tex:3-4) |
| card design: front and optional reverse side | main.tex:40 | `ticket.sheet` | `\BusinessCard{\frontcard}[\backcard]`, one argument holds the front face, the optional argument the back face (comment main.tex:38; README.md:3) |
| imposition, crop lines and card size | main.tex:41; comment main.tex:38-39 | `ticket.sheet` | `\MakeBC[lines,line thickness=0.35pt,crop color=accent]`: boolean `lines`, length `line thickness`, colour name `crop color` (the `accent` colour of main.tex:8); card size is the package default 3.5in x 2in, as the comment says (main.tex:39; README.md:3), not set by the sample |
| paper size, orientation, margins | main.tex:4 | `page.geometry` | `landscape`, `letterpaper`, `vmargin={0mm,0mm}`, `hmargin={0mm,0mm}` |
| colour package | main.tex:5 | `color.xcolor` | `\usepackage{xcolor}`, no options |
| named colours | main.tex:7-9 | `color.xcolor` | `\definecolor{ink}{HTML}{243447}`, `{accent}{HTML}{D65A31}`, `{muted}{HTML}{5F6B76}` |
| coloured text in the faces | main.tex:14, 16, 18, 20, 21, 28, 30, 32 | `color.xcolor` | `\color{accent}`, `\color{ink}`, `\color{muted}` inside a brace group around one line |
| front face text sizes | main.tex:14, 16, 18, 20-21 | `font.size-commands` | `\Large` (studio name), `\Huge` (person), `\large` (role), `\small` (e-mail, web, phone) |
| back face text sizes | main.tex:28, 30, 32 | `font.size-commands` | `\Large` (the N), `\large` (tagline), `\small` (places) |
| bold lines | main.tex:14, 16 | `mark.kernel` | `\bfseries` (a series switch, filed with the kernel font-switch commands) on the studio name and the person's name |
| vertical rhythm in the faces | main.tex:12, 15, 17, 19, 26, 29 | `sp.manual-space` | `\vspace*{7mm}`, `\vspace{3mm}`, `\vspace{1mm}`, `\vspace{6mm}` (front); `\vspace*{10mm}`, `\vspace{4mm}` (back) |
| push the last line to the foot of the back face | main.tex:31 | `sp.manual-space` | `\vfill` |
| gap between e-mail and web address | main.tex:20 | `sp.manual-space` | `\quad` |
| centred lines | main.tex:13-22, 27-33 | `sp.ragged` | the kernel `center` environment (the `\centering` family) around each face's lines |

Not defined by the sample, so no row: fonts and encoding (Computer Modern default, no font package), header and footer and page numbering (the sample sets no page style; whether `elzcards` empties the page style is in its unread source), headings, front matter, lists, maths, theorems, floats, tables, captions, code, bibliography, index, cross-references, language, hyperref. The `\par` after each styled line (main.tex:14-21, 28-30) is a plain paragraph break that closes the font group so the size sets that line's leading; it is kernel structure and needs no way. `\textbullet` (main.tex:32) is a kernel text symbol inside a string, content.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\frontcard` | main.tex:11-23 | yes | one `\newcommand` with no argument, counter, conditional or loop. Body is `sp.manual-space` (`\vspace*`, `\vspace`, `\quad`), `sp.ragged` (`center`), `color.xcolor` (`\color`), `font.size-commands`, `mark.kernel` (`\bfseries`). An emitter expands it inline as the first argument of `\BusinessCard`. |
| `\backcard` | main.tex:25-34 | yes | same type: `\newcommand` with no argument; `sp.manual-space` (`\vspace*`, `\vspace`, `\vfill`), `sp.ragged`, `color.xcolor`, `font.size-commands`. Expanded inline as the optional argument of `\BusinessCard`. |

No `\def`, environment, counter, conditional or other macro is defined in the zip. The package internals (imposition algorithm) belong to the published `elzcards` and are not zip-local code.

## Content-opaque
none (the studio name, person, role, e-mail, web address, phone number, tagline and places, main.tex:14-21 and 28-32, are plain text strings; no picture, image or drawing)

## Lib changes
- New ways proposed: `ticket.sheet` is the `elzcards` package (CTAN, TeX Live and MiKTeX, Emilio Augusto Lazo Zaia, LPPL 1.3; one read of https://ctan.org/pkg/elzcards, which describes it as typesetting business cards, index cards and flash cards with an optional reverse side, from paper size, card size, printable area and card design). Engine: pdf (README.md:8; the CTAN page does not state engines). Doc-kind way: `\usepackage{elzcards}`, body `\BusinessCard{front}[back]` and `\MakeBC[keys]` with keys `lines`, `line thickness`, `crop color` as the sample uses them (main.tex:3, 40-41); the full key list and the length parameters for paper size, card size and printable area come from the CTAN text, not from the package manual, which I did not read. W1: published on CTAN and in TeX Live. W2: behaviour is chosen by key values, lengths and a colour name; the card faces are arguments, not edits to package code. W3: it serves a kind of document part (a sheet of identical cards, business, index or flash), not this one card. W4: one preamble line plus two body calls, the faces being node content. Not `ticket.sheet` (the `ticket` package: `\ticket{}` per ticket, `\ticketNumbers` `\ticketSize`), not `card.gcard` (one folded greeting card), not `class.flashcard` (a class for two-sided question cards). It is the same type of effect as `ticket.sheet` (an imposed sheet with cut marks, the face outside the way); the consolidator may fold it into that line with the package as the parameter, as `exam.esami` was folded into `exam.questions`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- README.md:10 says "Compile with `just package elzcards` from the catalogue root". That is the catalogue's own build wrapper; `main.tex` has no shell escape, preprocessor or external tool call, so I do not record it as `EXTERNAL`. The `justfile` is not in the zip and was not read.
- Text addressed to an AI: none found in the README or `main.tex`.
