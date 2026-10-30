yes

# 0338-spie-optical-engineering-article: SPIE Optical Engineering Article

- Unverified: read from the source, not compiled.
- Source: Source/0338-spie-optical-engineering-article/ (origin: https://latextemplates.com/downloads/opteng.zip; licence: LPPL-1.3 per the manifest and the CTAN label; the grant is not in the archive, README.md:5)
- Kind: journal
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:7 says "Compile with PDFLaTeX"; the `opteng` source is not in the zip, so this is the README's claim, not checked)
- Look carried by: class (a published house-style package, `opteng`, loaded on kernel `article` with option `optengjnl`, main.tex:1-2; treated as class-like by the lib v3 house-style ruling; the zip holds no zip-local code at all)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; README.md is a note, not a sample)
- Read: main yes, zip-local classes and styles none present (the zip has only main.tex and README.md; `opteng.sty` and its documentation were not read)

## Verdict
The zip is 90 lines of content plus one `\usepackage[optengjnl]{opteng}` (main.tex:2). It defines no macro, environment, counter, class or style of its own (grep for `\newcommand`, `\def`, `\renewcommand`, `\newenvironment`, `\setlength`, `\geometry`, `\pagestyle`, tikz found nothing in main.tex). Everything that gives the page its look sits in the published `opteng` package, which is one class-like way, `class.opteng`; the sample adds only option settings, front-matter strings and standard constructs. Every body construct the sample uses maps to an existing lib way, so an emitter could write the preamble and body wrappers from published parts only. Limit of this reading: the internals of `opteng` (columns, margins, running heads, fonts, heading and caption looks) were not read, only inferred from the README (README.md:3); under the rubric a published class-like package is one way and its source is not analysed, but that is why this is a `class`-carried yes and not evidence about the component ways.

## Blockers
none

## Class setting
- Class: `class.article` options: `10pt`, `letterpaper` (main.tex:1). The look package is `class.opteng` option: `optengjnl` (main.tex:2), the Optical Engineering journal mode (README.md:3).
- Class-native vocabulary used (all from `opteng`, none defined in the zip): `\subjterm{...}` (main.tex:5), `\loginfo{...}` (main.tex:6), `\doi{...}` (main.tex:7), `\address{...}` (main.tex:13), `\email{...}` (main.tex:14). Kernel `\title` and `\author` (main.tex:11-12) and the kernel `abstract` environment (main.tex:16-24) are used with it. The sample never calls `\maketitle` (grep count 0), and the title, author, address and email come after `\begin{document}` (main.tex:9, 11-14), so `opteng` must print the title block itself (probably when the abstract starts); that is an inference, not read.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | `10pt`, `letterpaper` |
| paper and base size | main.tex:1 | `page.class-options` | `letterpaper`, `10pt` |
| journal look (page, columns, running heads, fonts, heading and caption looks) | main.tex:2; README.md:3 | `class.opteng` | option `optengjnl`; two-column layout is stated in README.md:3 and is not set in main.tex:1 (no `twocolumn` option); the internal ways are not read |
| table rules | main.tex:3, 60-65 | `tbl.booktabs` | `\toprule`, `\midrule`, `\bottomrule`; no options |
| subject terms (keyword line) | main.tex:5 | `abs.keywords` | `\subjterm{optical sensing, calibration, field instrumentation}`, a comma-separated string |
| manuscript log line | main.tex:6 | `front.class-native` | `\loginfo{Example manuscript compiled \today}`; `\today` is the kernel date |
| DOI | main.tex:7 | `front.class-native` | `\doi{10.0000/example.opteng}` |
| title and author | main.tex:11-12 | `front.maketitle` | `\title{...}`, `\author{Avery Morgan}`; no `\maketitle` call |
| affiliation and e-mail | main.tex:13-14 | `front.class-native` | `\address{...}`, `\email{...}` |
| abstract | main.tex:16-24 | `abs.kernel` | `abstract` environment, one paragraph; `opteng` may restyle it (unread) |
| section headings | main.tex:26, 33, 51, 73 | `head.kernel` | `\section{...}` only, four numbered, no subsections; the look is `opteng`'s (unread) |
| display equation and label | main.tex:37-40 | `math.kernel` | `equation` environment, `\label{eq:normalized-response}`; no `amsmath` loaded; inline maths and `\frac` are content |
| cross-references | main.tex:39, 48, 52, 58, 74 | `xref.kernel` | `\label`, `\ref` with `~` |
| figure float | main.tex:43-49 | `fig.graphicx` | `figure` float with placement `[t]`; the kernel float, no `\includegraphics` in this sample |
| centring in floats | main.tex:44, 56 | `sp.ragged` | `\centering` |
| placeholder frame in the figure | main.tex:45 | `box.fancybox`, `sp.rule` | `\fbox{...}` around `\rule{0pt}{28mm}\rule{0.82\columnwidth}{0pt}` (kernel box and rules; the real figure artwork would be content) |
| table float | main.tex:55-67 | `tbl.tabular` | `table` float `[t]`, `tabular` with column spec `lrr` |
| captions | main.tex:46-47, 57 | `cap.kernel` | `\caption{...}`; figure caption below the figure, table caption above the tabular; the caption look is `opteng`'s (unread) |
| bibliography | main.tex:80-88 | `bib.thebibliography` | `thebibliography` with widest label `9`, two `\bibitem` entries; no `\cite` in the text |
| inline emphasis | main.tex:82, 86 | `mark.kernel` | `\emph` |

Not set by the sample, so no row: header and footer, page geometry values, fonts, spacing, colour, lists, theorems, notes, code, index, language and PDF metadata (none of `hyperref`, `geometry`, `fancyhdr`, `babel` is loaded in main.tex:1-3). If `opteng` sets any of them it does so inside `class.opteng`.

## Bespoke code
none (no zip-local `.cls`, `.sty`, `\newcommand`, `\def` or environment: main.tex:1-90 and the file list show only `main.tex` and `README.md`)

## Content-opaque
none (the figure body at main.tex:45 is a framed rule placeholder built from `\fbox` and `\rule`, and the table body at main.tex:59-66 is a plain `tabular`; neither needs a way outside the lib)

## Lib changes
- New ways proposed: none. `class.opteng` is written as a class-like way (a house-style package, per the lib v3 ruling that a house style is class-like, with its vocabulary recorded under "Class setting"); no component line is proposed.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Class origin: `opteng` is on CTAN and in TeX Live (ctan.org/pkg/opteng, version 1.0, LPPL); README.md:5 says it "is not copied into this starter"; the zip comes from latextemplates.com, not an SPIE author page, so it is not publisher-official.
- README.md:5 and the manifest say the licence grant is not in the archive; the CTAN label is LPPL. The `opteng` package is a shipped-elsewhere asset: TeX Live provides it, the zip does not (missing asset, noted, not a blocker).
- The ctan.org page for `opteng` describes it as a template for estimating page length of Optical Engineering and Optical Engineering Letters manuscripts. It lists no commands, so the vocabulary above is taken only from what main.tex calls.
- Text addressed to an AI: none found in main.tex or README.md.
