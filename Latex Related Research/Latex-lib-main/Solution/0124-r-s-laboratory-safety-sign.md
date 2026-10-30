yes

# 0124-r-s-laboratory-safety-sign: R&S Laboratory Safety Sign

- Unverified: read from the source, not compiled.
- Source: Source/0124-r-s-laboratory-safety-sign/ (origin: https://latextemplates.com/downloads/r-und-s-safety.zip; licence: BSD-3-Clause)
- Kind: misc (a one-page landscape safety notice board; the manifest hint is `misc`)
- Lib: v2
- Engine: pdfLaTeX-compatible (no fontspec or unicode-math; README.md:9 says "Compile with pdfLaTeX"; the one non-ASCII character is an em dash at main.tex:10, which pdfLaTeX reads as UTF-8 by default)
- Look carried by: preamble (the sample's own preamble and body wrappers, main.tex:1-5 and main.tex:7-22; the zip holds no `.cls`, `.sty` or other local file, and the class is plain `article`)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex and README.md; the published package `r_und_s` is loaded but not bundled, so its source was not read)

## Verdict
The whole zip is a 23-line `article` document. It sets A4 landscape with `geometry`, an empty page style, and two framed `minipage` blocks coloured with `xcolor`. It loads the published CTAN and TeX Live package `r_und_s`, which supplies the safety-phrase text through `\cre`, `\crz` and `\crd`. Nothing is defined in the zip (grep for `\newcommand`, `\def`, `\newenvironment`, `\newcounter` and `\RequirePackage` in main.tex finds nothing), there is no drawing, and no external tool is involved. Every layout part maps to an existing lib way. The phrase text is content that comes from a published package, held by `art.content-package` and listed as content-opaque. I judge it content and not template artwork, because it prints plain text and draws nothing. The `yes` rests on that judgement and on `r_und_s` having no external tool or zip-local code, which I did not read in its source.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `landscape` (main.tex:1). The class is a kernel class loaded unchanged and not bundled in the zip, so its source was not read.
- Class-native vocabulary used: `center` environment (main.tex:7); no `\maketitle`, no `abstract`, no sectioning commands.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | `a4paper`, `landscape` |
| paper size and orientation | main.tex:1 | `page.class-options` | `a4paper`, `landscape` |
| page geometry | main.tex:2 | `page.geometry` | `margin=15mm` |
| colour definitions and mixes | main.tex:3, main.tex:12, main.tex:13, main.tex:17 | `color.xcolor` | `\usepackage{xcolor}`; named colours mixed inline: `red!8` (fill), `red!70!black` (text, set with `\color`), `yellow!18` (fill), `red`, `black` (frame colours) |
| safety-phrase text source | main.tex:4, main.tex:14 | `art.content-package` | `\usepackage{r_und_s}` with no option; body commands `\cre`, `\crz`, `\crd` (CTAN `r_und_s` v1.3i, in TeX Live; four language variants per its CTAN page; the commands' definitions were not read) |
| header and footer | main.tex:5 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no running head, no page number) |
| centred body wrapper | main.tex:7, main.tex:22 | `sp.ragged` | `center` environment around the whole page content |
| sign title line (hand-set text, not `\maketitle`) | main.tex:8 | `mark.kernel` | `\sffamily\bfseries` in a brace group |
| sign title size | main.tex:8 | `font.size-commands` | `\fontsize{34}{38}\selectfont` |
| subtitle line | main.tex:10 | `mark.kernel` | `\sffamily` |
| subtitle size | main.tex:10 | `font.size-commands` | `\large` |
| vertical gaps between blocks | main.tex:9, main.tex:11, main.tex:16 | `sp.manual-space` | `\vspace{3mm}`, `\vspace{9mm}`, `\vspace{8mm}` |
| red phrase box frame and fill | main.tex:12 | `box.fancybox` | `\fcolorbox{red}{red!8}{...}` |
| red phrase box content width | main.tex:12, main.tex:15 | `box.minipage` | `minipage` of width `.86\linewidth` |
| red phrase box text shape | main.tex:12-13 | `sp.ragged` | `\centering` |
| red phrase box type | main.tex:12-13 | `mark.kernel`, `font.size-commands`, `color.xcolor` | `\sffamily\bfseries`; `\fontsize{21}{26}\selectfont`; `\color{red!70!black}` |
| line breaks between the three phrases | main.tex:14 | `sp.manual-space` | `\\[3pt]` twice |
| yellow notice box frame and fill | main.tex:17 | `box.fancybox` | `\fcolorbox{black}{yellow!18}{...}` |
| yellow notice box content width | main.tex:17, main.tex:21 | `box.minipage` | `minipage` of width `.82\linewidth` |
| yellow notice box text | main.tex:17-18 | `sp.ragged`, `mark.kernel` | `\centering`; `\sffamily`; inline `\textbf{Before beginning work:}` |

Not used, so no row: fonts packages (the default Computer Modern with `\sffamily` switches), headings, lists, floats, tables, captions, bibliography, footnotes, `hyperref`, language packages.

## Bespoke code
none. main.tex defines no macro, environment, counter or conditional, and the zip holds no `.cls` or `.sty` (checked with `ls -R` and grep). The only unusual names, `\cre`, `\crz`, `\crd`, belong to the published package `r_und_s` (CTAN, TeX Live) loaded at main.tex:4. README.md:8 says the package is supplied by TeX Live and not copied into the archive, and the CTAN package page confirms it is published. Its source was not read here.

## Content-opaque
- The phrase text printed by `\cre`, `\crz`, `\crd` (main.tex:14): fixed legacy German safety-phrase strings held in the published package. Per README.md:3-6 they are historical material. The emitter loads `r_und_s` and prints the three commands, or prints the expanded text as plain text. Either way it is text, not layout.
- Running text in the title, subtitle and notice (main.tex:8, main.tex:10, main.tex:18-20), including the escaped ampersands `R\&S` and the em dash at main.tex:10.

## Lib changes
- New ways proposed: none. Considered: giving `r_und_s` a way of its own (a safety-phrase way). I rejected that because `art.content-package` already holds specialised content packages (chemistry among them), and one lib line per content package would not stay finite.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes for reviewers
- The one judgement call is `art.content-package` for `r_und_s`. That lib line is in the Restricted table, where such packages are `ART` only when they draw the template's own identity. `r_und_s` prints text and draws no shape, so I treated it as content. If a reviewer reads the phrase block as the template's identity, this zip would become `no` (`UNMAPPED/body`), and everything else in it would still map.
- The meaning of `\cre`, `\crz`, `\crd` is not established: the package source is not in the zip and the CTAN page does not document the commands. The sample's README.md:3-4 describes them as "safety advice phrases".
- The README contains no text addressed to an AI.
