yes

# 0896-ncccropmark: ncctools (NCC packages by A. I. Rozhenko; overview document `ncctools.tex`)

- Unverified: read from the source, not compiled.
- Source: Source/0896-ncccropmark/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ncctools.zip; licence: LPPL, README:26)
- Kind: misc (a short guide to a bundle of 25 packages; the zip holds no document class and no `.sty`, only `.dtx` sources)
- Lib: v6
- Engine: pdfLaTeX-compatible
- Look carried by: preamble (kernel `article` at defaults; the sample's own preamble loads `hyperref`, `amsmath`, and the published NCC packages `desclist` and `tocenter`, then sets margin-note and text-area values and three small aliases)
- Class origin: tex-distribution-unbundled (`article` is the kernel class and is not in the zip)
- Main file: source/ncctools.tex (other samples: none as documents of their own; each `.dtx` carries an `ltxdoc` driver, e.g. source/desclist.dtx:13-26, which documents one package and is not a template)
- Read: main yes, zip-local classes and styles partly (no `.cls` or `.sty` ships. Read in full: source/desclist.dtx and source/tocenter.dtx, the two packages the sample loads, plus source/ncccropmark.dtx and source/ncccropbox.dtx, the zip's namesake. The other 21 `.dtx` files were only outlined by grep of `\RequirePackage` and `\DeclareOption`, because the sample does not load them)

## Verdict
yes. The sample is `article` at 11pt with `hyperref`, `amsmath`, `desclist` and `tocenter` (source/ncctools.tex:1-5). Every component it uses has a lib way: a defaults-only `article` page, a title block, 25 margin-noted paragraphs, one `itemize`, one `desclist`, inline `\verb`, four `center` blocks. The three zip-local macros (`\|`, `\Package`, `\Pack`, source/ncctools.tex:14-19) are aliases of kernel and `hyperref` commands and reduce by inline expansion. `desclist` and `tocenter` are published: ctan.org/pkg/ncctools (read once) lists the bundle as NCCtools v3.5.3, LPPL, in TeX Live and MiKTeX, and names both packages. So their code is the way's own code, not bespoke. There is no artwork in the sample. Scope note: 23 of the 25 bundle packages are not loaded by the sample (`afterpackage`, `dcounter`, `extdash`, `manyfoot`, `mboxfill`, `nccbbb`, `nccboxes`, `ncccomma`, `ncccropbox`, `ncccropmark`, `nccfancyhdr`, `nccfloats`, `nccfoots`, `nccmath`, `nccparskip`, `nccpic`, `nccrules`, `nccsect`, `nccstretch`, `nccthm`, `textarea`, `topsection`, `watermark`). The rubric scopes recovery to the sample and what it loads, so they are not judged here, and the verdict says nothing about them.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (source/ncctools.tex:1); no paper-size option, so the default letter paper stays and `\ToCenter` centres on it
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (source/ncctools.tex:10-12, 21); `itemize`, `center`, `\marginpar`, `\reversemarginpar`. No `\section`, `abstract`, `figure`, `table`, `thebibliography` or `\footnote` call in the body (the `\caption`, `\chapter`, `\section` strings at :129, :218, :283 sit inside `\verb` text)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | source/ncctools.tex:1 | `class.article` | 11pt |
| size and paper | source/ncctools.tex:1 | `page.class-options` | `11pt`; paper left at the class default (letter) |
| text area and centring | source/ncctools.tex:5, 8; source/tocenter.dtx:139-226 | `page.vmargin` | `\usepackage{tocenter}`, `\ToCenter[fm]{130mm}{220mm}`: text width 130mm, text height 220mm, margins computed so that text plus footer (`f`) plus margin notes (`m`) are centred on the sheet; no `h`. The package reads `\marginparwidth`, `\marginparsep`, `\footskip`, `\headsep`, `\headheight`, `\paperwidth`, `\paperheight`, `\if@reversemargin`, `\if@twocolumn` at call time (tocenter.dtx:146-217), so lines 6 and 7 must be emitted before line 8. Preamble only (tocenter.dtx:142) |
| margin-note width | source/ncctools.tex:7 | `page.setlength` | `\settowidth\marginparwidth{\tt afterpackage}` (a measured string width) |
| margin-note side | source/ncctools.tex:6 | `note.marginpar` | `\reversemarginpar` (notes go to the left margin) |
| margin notes | source/ncctools.tex:17 | `note.marginpar` | `\marginpar{\hfill ...}` once per `\Package` call; 25 calls (lines 30, 36, 46, 53, 63, 75, 80, 84, 92, 96, 100, 108, 126, 133, 140, 158, 168, 180, 186, 222, 226, 266, 274, 282, 289) |
| link load options | source/ncctools.tex:2 | `meta.hyperref` | `colorlinks=true`, `filecolor=blue` |
| file links | source/ncctools.tex:17 | `xref.hyperref` | `\href{<name>.pdf}{...}` to a local PDF (targets are in doc/, link only) |
| underlined package name | source/ncctools.tex:17 | `mark.ulem` | `\underbar{...}`: the kernel underline command, same type as the `ulem` underline (the package itself is not loaded) |
| font switches | source/ncctools.tex:7, 17, 19, 228-229, 248 | `mark.kernel` | `\tt`, `\it`, `\textit{...}`, italic correction `\/` |
| title block | source/ncctools.tex:10-12, 21 | `front.maketitle` | title `NCCTOOLS`; author `by Alexander I. Rozhenko`; date `Release 3.5`; no `\thanks` |
| page style | (no `\pagestyle` call; source/ncctools.tex:1-8) | `hf.pagestyle-kernel` | `article` default `plain`; the footer is real, which is why `f` in `\ToCenter` matters |
| manual spacing | source/ncctools.tex:16, 17, 58 | `sp.manual-space` | `\bigskip` before each entry, `\hfill` in the note, `\quad` between verb items |
| paragraph without indent | source/ncctools.tex:16 | `sp.lengths` | `\noindent` (per-paragraph form of `\parindent=0`) |
| centred display lines | source/ncctools.tex:57-59, 114-116, 136-138, 252-254 | `sp.ragged` | kernel `center` environment, four uses |
| loose line breaking | source/ncctools.tex:198 | `sp.hyphenat` | `{\sloppy\par}` after one list item |
| inline code | source/ncctools.tex:14 (alias), 74 lines use `\|` | `code.verbatim` | `\verb|...|` (alias `\|` expands to `\verb|`); none sits inside another command's argument |
| bulleted list | source/ncctools.tex:190-220 | `list.kernel` | `itemize`, 9 items (191, 194, 200, 203, 206, 209, 211, 214, 216) |
| definition list | source/ncctools.tex:4, 228-242; source/desclist.dtx:106-144 | `list.paralist` | `desclist` package as the parameter: `\begin{desclist}{\it}{\/}[numbering mode]` (prefix `\it`, suffix `\/`, prototype text that sets label width and hang indent through `\settowidth\leftmargin{#1#3{#2}}`, desclist.dtx:130); 4 items at 229, 232, 236, 239 |
| maths package | source/ncctools.tex:3 | `math.amsmath` | `\usepackage{amsmath}` only; no display maths in the body. The logo macro `\AmS` (lines 141, 148, 204) is not defined anywhere in the zip (grep found no definition), so it is taken to come from `amsmath`; not verified |

Not components: `\LaTeX`, `\LaTeXe`, `\AmS` logos and the text itself (content).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\|{\verb|}` | source/ncctools.tex:14 | yes | alias; write `\verb|text|` at each of the 74 lines. Uses: :30, :58, :115, :137, :253 |
| `\newcommand*\Package[1]` | source/ncctools.tex:15-18 | yes | expands to `\par` (`sp.manual-space`: `\bigskip`) `\noindent` (`sp.lengths`) `\marginpar{\hfill \href{#1.pdf}{\underbar{\tt #1}}}` (`note.marginpar`, `sp.manual-space`, `xref.hyperref`, `mark.ulem`, `mark.kernel`). `\leavevmode` follows `\noindent`, which has already started the paragraph, and `\ignorespaces` only swallows the source space after the call; an emitter writes the text directly, so both drop out |
| `\newcommand*\Pack[1]` | source/ncctools.tex:19 | yes | `{\tt #1}` (`mark.kernel`) |

Published bundle code the sample loads (not bespoke, W1 shown by the CTAN read above; recorded for completeness): `desclist` (source/desclist.dtx:106-153, a `\list` with a computed `\leftmargin`, plus a redefined `description` that the sample never calls) and `tocenter` (source/tocenter.dtx:102-226, `\ToCenter` and `\FromMargins` compute margins from lengths and the `hfm` letters). Both are chosen by lengths, letters and strings (W2), serve any document (W3) and print as one preamble line or one environment (W4).

Seen but not exercised by the sample: `ncccropmark` (source/ncccropmark.dtx:79-152) and `ncccropbox` (source/ncccropbox.dtx:87-146) draw crop corners from `picture` `\line` commands and are meant to sit inside `\watermark{...}`. If a later zip loads them the drawing would have to be judged then (`art.pstricks` or a new crop-mark way); nothing in this sample calls `\cropbox`, `\cropmark` or `\watermark`. Nothing in the zip needs a tool outside TeX: `ncctools.ins` only runs DocStrip (source/ncctools.ins:14-17, 42-66). No text addressed to an AI was found.

## Content-opaque
none (the `\href` targets doc/*.pdf are link targets, not included material)

## Lib changes
- New ways proposed: none
- Widening for the consolidator (the same type, the package is the parameter, as `font.opensans` into `font.helvet`): `list.paralist` takes `desclist` (a list-environment package with prefix, suffix and prototype arguments); `page.vmargin` takes `tocenter` (a margin package that sets margins from text size or from four margins, like `vmargin` and `anysize`). `page.geometry` with `total={130mm,220mm}`, `centering`, `includefoot`, `includemp` and `reversemp` would be the nearest geometry-based reading, not claimed to give the same margins.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
