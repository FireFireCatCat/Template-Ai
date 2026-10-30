yes

# 0116-envelope-letter: envelope-letter (fold a letter into its own envelope)

- Unverified: read from the source, not compiled.
- Source: Source/0116-envelope-letter/ (origin: https://mirrors.ctan.org/macros/latex/contrib/envelope-letter.zip; licence: GPL v3 or later, README:8)
- Kind: letter
- Lib: v2
- Engine: pdfLaTeX-compatible (tikz, pgfopts, geometry, graphics, pifont, fp are all pdfTeX packages, envelope-letter.sty:6-11; it uses `\AddToHook`, so it needs a recent LaTeX kernel with hook management, version not checked)
- Look carried by: mixed (the documentation's own look is the preamble over `article`, envelope-letter-documentation.tex:1-10; the envelope page is drawn by envelope-letter.sty, a CTAN package shipped in the zip, so not zip-local)
- Class origin: tex-distribution-unbundled (`article`; the zip's one style, envelope-letter.sty, is a CTAN package, checked at ctan.org/pkg/envelope-letter: v1.1, 2025-08-28, topic Letter)
- Main file: envelope-letter-documentation.tex (other samples: none; envelope-letter-documentation.pdf is the compiled manual, not read)
- Read: main yes (140 lines), zip-local classes and styles all (envelope-letter.sty, 209 lines, read in full; README read)

## Verdict
yes, with one judgement call stated openly. The zip is the CTAN package `envelope-letter` plus its manual. The manual is an ordinary `article` built from published ways (geometry, hyperref, xurl, siunitx, kernel front matter, lists, footnotes, sections). The envelope layout (a TikZ fold-line drawing with computed angles) lives entirely in envelope-letter.sty, which is published (W1), driven by pgfkeys options and strings (W2), serves any letter-compatible class (W3) and is printed as one preamble line plus a `\makeenvelope[...]` body call (W4), the same shape as `ltr.envlab`, `ltr.formlett` and `cal.kalender`. It is therefore proposed as `ltr.envelope-letter`. If a reviewer rules that a published package whose whole content is fixed TikZ artwork and `fp` arithmetic is `ART/package` rather than a way, this flips to `no` (envelope-letter.sty:79-146, 194-204). The one hand-drawn picture in the manual (tex:50-76) is a preview illustration, recorded as content-opaque.

## Blockers
none

## Class setting
- Class: `class.article` options: none (envelope-letter-documentation.tex:1)
- Class-native vocabulary used: `\title` (with `\\\Large`), `\author` with `\thanks`, `\maketitle`, `abstract`, `\tableofcontents`, `\section`, `\footnote` (tex:12-13, 16, 18-24, 28, 34)
- Letter vocabulary the package reads but the sample does not use: `letter` environment, `\opening`, `\toname`, `\toaddress`, `\fromaddress` (envelope-letter.sty:47-57, 159-166, 189-191; tex:35, 41). The package builds an empty `letter` environment when none exists (sty:47-48). Under `article` it hooks `env/letter/begin` (sty:56).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | envelope-letter-documentation.tex:1 | `class.article` | no options |
| page geometry | envelope-letter-documentation.tex:3 | `page.geometry` | a4paper, margin=1.7cm |
| hyperlinks and metadata | envelope-letter-documentation.tex:4 | `meta.hyperref` | colorlinks=true, linkcolor=black, urlcolor=blue |
| link commands | envelope-letter-documentation.tex:41, 131 | `xref.hyperref` | `\href{url}{text}` |
| URL breaking | envelope-letter-documentation.tex:5, 123 | `meta.url` | `xurl`; `\url{...}` |
| units | envelope-letter-documentation.tex:6, 91 | `mark.siunitx` | inter-unit-product={\cdot}; `\unit`, `\qty` |
| envelope page (the package the manual documents) | envelope-letter-documentation.tex:7, 35; envelope-letter.sty:181-208 | `ltr.envelope-letter` | `\usepackage{envelope-letter}`; keys grammage, fold lines mode, lines, ticks, no lines, steps, no steps, instructions, no instructions, full, eco, empty, auto, manual, to, from; `\envelopesetup{}`, `\setstamp{}`, `\makeenvelope[]` (tex:85-120; sty:13-45) |
| paragraph spacing | envelope-letter-documentation.tex:9 | `sp.lengths` | \parskip=0.7\baselineskip |
| `\optarg` alias | envelope-letter-documentation.tex:10 | `mark.kernel` | `$\langle$\textit{#1}\,$\rangle$` (see Bespoke code) |
| title block | envelope-letter-documentation.tex:12-13, 16 | `front.maketitle` | two-line title, second line `\Large`; author |
| title font size | envelope-letter-documentation.tex:12 | `font.size-commands` | `\Large` |
| author note | envelope-letter-documentation.tex:13 | `front.thanks` | `\thanks{E-mail: ...}` |
| abstract | envelope-letter-documentation.tex:18-24 | `abs.kernel` | `abstract` environment |
| vertical fill | envelope-letter-documentation.tex:26, 30 | `sp.manual-space` | `\vfil` around the contents |
| contents | envelope-letter-documentation.tex:28 | `toc.kernel` | `\tableofcontents` |
| page breaks | envelope-letter-documentation.tex:32, 45 | `pg.break` | `\clearpage` |
| headings | envelope-letter-documentation.tex:34, 47, 84, 122, 130, 133 | `head.kernel` | `\section`, default look |
| cross-references | envelope-letter-documentation.tex:41, 82, 84 | `xref.kernel` | `\label{sec:options}`, `\ref{sec:options}` |
| inline code | envelope-letter-documentation.tex:19, 35-43, 85-120 | `code.verbatim` | `\verb\|...\|` |
| bullet lists | envelope-letter-documentation.tex:90-103, 106-112, 116-119, 124-128 | `list.kernel` | `itemize`, default labels |
| definition list | envelope-letter-documentation.tex:134-138 | `list.kernel` | `description`, bold label with `\textnormal{(date)}` |
| emphasis, typewriter | envelope-letter-documentation.tex:19, 91, 131 | `mark.kernel` | `\emph`, `\textit`, `\textbf`, `\texttt` |
| footnotes | envelope-letter-documentation.tex:35, 78, 91, 123 | `fn.kernel` | `\footnote` |
| inline maths | envelope-letter-documentation.tex:125-127 | `math.kernel` | `$\frac{1}{8}$`, `$\frac{7}{8}$` |
| stamp box in the preview | envelope-letter-documentation.tex:61 | `box.fancybox`, `sp.rule` | `\fbox{\rule[-0.13cm]{0pt}{0.6cm}...}` (argument of `\setstamp`, inside the content-opaque preview) |

What the package itself loads and does, all inside the one way `ltr.envelope-letter` (published code, listed so nothing is hidden): `tikz` pictures and nodes (sty:79-146, 194-204), `pgfopts` keys (sty:19-41), `geometry` `\newgeometry{margin=0cm}` and `\restoregeometry` (sty:185, 205), `pifont` `\ding` glyphs for step numbers and scissors (sty:128-146), `fp` `\FPeval` for fold angles and paper-mass arithmetic (sty:76-77, 150-157), kernel hooks `\AddToHook` (sty:51-60), `\typeout` log summary of letter mass (sty:161-176, log only, prints nothing on the page).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\optarg}[1]` | envelope-letter-documentation.tex:10 | yes | alias for `mark.kernel` (`\textit`) plus `math.kernel` (`\langle` `\rangle`) |
| `\def\fromname` `\fromaddress` `\toname` `\toaddress` | envelope-letter-documentation.tex:55-59 | yes (content) | text assignments for the preview picture; the same data the package reads from `class.letter`, or takes through the `to=` and `from=` keys (tex:117-118) |
| `\setlength{\el@l}` `\el@L`, `\makeatletter` ... `\makeatother` | envelope-letter-documentation.tex:50-53, 76 | yes (content) | assignments to the package's own lengths, needed only by the preview picture (content-opaque, below) |
| `envelope-letter.sty` as a whole | envelope-letter.sty:1-209 | not bespoke: published | CTAN package (v1.1), so its internals (pgfkeys option code, `\FPeval` angles, TikZ fold drawings, `\makeenvelope`, hooks, letter-mass log) are the implementation of `ltr.envelope-letter`. Had it been zip-local these would be irreducible (`BESPOKE/class`, `ART/class`). |

## Content-opaque
- Preview of the default envelope: a `tikzpicture` inside `center`, drawn by hand from the package's internal macros `\el@plotfoldlines`, `\el@foldsteps`, `\el@openinginstructions` and lengths `\el@l`, `\el@L` after `\makeatletter` (envelope-letter-documentation.tex:50-76, picture at 63-74). It illustrates the package's output in the manual (`art.tikz` as figure content); the manual's own look does not depend on it. If a reviewer reads it as template artwork instead, it is `ART/body` there and the verdict becomes `no`.
- Reading note, not used in the verdict: envelope-letter.sty:155 has `pow(-6,10)`, which looks like a typo for 10^-6. It only affects the mass figure written to the log.

## Lib changes
- New ways proposed: `ltr.envelope-letter` is the `envelope-letter` package (CTAN, macros/latex/contrib, v1.1 of 2025-08-28; pdfLaTeX): `\usepackage{envelope-letter}` and a body call `\makeenvelope[options]` right after `\begin{letter}` (tex:35) that adds one borderless first page with fold lines, step marks, scissors marks, recipient and sender addresses and an optional stamp. W1: on CTAN (ctan.org/pkg/envelope-letter, topic Letter) and in this zip's origin URL. W2: behaviour is chosen by the pgfkeys options and the strings `to`, `from`, `grammage` and `\setstamp` (tex:89-120, sty:19-45). W3: it serves any letter-compatible class (`letter`, `lettre`, or `article` with the keys, tex:41), not one document. W4: one preamble line plus one body call. Not `ltr.envlab` (that is the `envlab` package, with `\SetEnvelope` and `\makelabels`; the two share no commands) and not `ltr.opening` (letter commands and letterhead). Considered `art.tikz`: rejected, because the drawing is inside the published package and the document passes only options.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
