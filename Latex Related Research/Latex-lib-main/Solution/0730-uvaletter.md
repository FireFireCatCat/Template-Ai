yes

# 0730-uvaletter: uvaletter (University of Amsterdam letterhead)

- Unverified: read from the source, not compiled.
- Source: Source/0730-uvaletter/ (origin: https://mirrors.ctan.org/macros/latex/contrib/uvaletter.zip; licence: MIT, LICENSE:1 and uvaletter.sty:4)
- Kind: letter
- Lib: v5
- Engine: pdfLaTeX-compatible (T1, inputenc, `times`, `microtype`, `fancyhdr`; no fontspec or Lua code)
- Look carried by: class (the whole look is the published house-style package `uvaletter.sty` loaded over the kernel `letter` class; the sample adds only option `pageno` and field strings)
- Class origin: ctan (`uvaletter` is on CTAN and in TeX Live and MiKTeX, read at ctan.org/pkg/uvaletter: v1.1.3, MIT; the base class `letter` is kernel and not in the zip)
- Main file: uvaletter-demo.tex (other samples: none; uvaletter-demo.pdf and screenshot.jpg are renders, not sources)
- Read: main yes, zip-local classes and styles all (the one style file, uvaletter.sty, 117 lines; the base `letter` class source was not read)

## Verdict
yes. The look is carried by one published CTAN package, `uvaletter`, which is a one-institution letterhead house style, so it is class-like (the lib's v3 note: a one-institution front-matter package or house style is recorded as a class way, with its vocabulary). The sample sets only the option `pageno` and fourteen string fields (thirteen defined by the package, plus the kernel `\date`), then wraps the body in the `letterhead` environment: all printable as preamble lines plus one body wrapper. As a second check the whole `.sty` also reduces to existing lib ways (packages with options, three length settings, one environment of minipages); the field-emptiness tests are resolved at emit time because the emitter knows which fields it has. No artwork, no external tool, no irreducible code.

## Blockers
none

## Class setting
- Class: `class.letter` options: `11pt` (demo:6). The kernel letter vocabulary (`\begin{letter}`, `\opening`, `\closing`) is not used by the sample.
- House-style package: `class.uvaletter` (style package loaded after the class, demo:7) option: `pageno` (adds a "Page X of Y" foot, sty:23). No other options exist (`\ProcessOptions`, sty:85).
- Class-native vocabulary used (uvaletter): field commands `\logo` `\recipient` `\department` `\visiting` `\postal` `\website` `\date` (kernel command read through `\@date`, sty:46) `\yourreference` `\ourreference` `\contactperson` `\phone` `\email` `\subject` `\enclosed` (demo:9-22, defined sty:90-115); environment `letterhead` wrapping the body (demo:25-39, defined sty:25-83); `\recipient` and `\department` are mandatory and non-empty, the rest optional (README.md:52). Considered: `ltr.opening` (letterhead of the `newlfm` type) for the same block; the class-like precedent is kept as the primary way and `front.class-native` is used for the block rows.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | uvaletter-demo.tex:6 | `class.letter` | 11pt |
| house-style package | uvaletter-demo.tex:7; uvaletter.sty:7 | `class.uvaletter` | pageno |
| paper size, point size | uvaletter-demo.tex:6 | `page.class-options` | 11pt (the paper is set by geometry below) |
| page geometry | uvaletter.sty:11 | `page.geometry` | a4paper, margin=3.05cm |
| encodings | uvaletter.sty:9-10 | `font.fontenc-t1` | fontenc T1; inputenc utf8 |
| text font | uvaletter.sty:12 | `font.mathptmx` | package `times` (Times roman, Helvetica sans, Courier mono) |
| microtypography | uvaletter.sty:13 | `sp.microtype` | defaults, no options |
| running head and foot | uvaletter.sty:14,21,22,88 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}` clears all fields, `\headrulewidth`=0pt |
| page number foot (option) | uvaletter.sty:23 | `hf.fancyhdr` | `\rfoot{\tabentry Page~\thepage~of~\pageref{LastPage}}` only when `pageno` |
| page X of Y | uvaletter.sty:19,23 | `pgnum.lastpage` | package `lastpage`, label `LastPage`, no options |
| reference to last page | uvaletter.sty:23 | `xref.kernel` | `\pageref{LastPage}` |
| paragraph shape | uvaletter.sty:86-87 | `sp.lengths` | `\parindent`=0pt, `\parskip`=1em plus 0.2em minus 0.2em |
| letterhead block and fields (as published) | uvaletter-demo.tex:9-22,25; uvaletter.sty:25-83,90-115 | `front.class-native` | 14 string fields (13 package commands plus `\date`), `letterhead` environment as wrapper around the body |
| logo image | uvaletter.sty:26-31 (image line 29); uvaletter-demo.tex:9 | `fig.graphicx` | `\includegraphics[width=.65\textwidth]{logo.jpg}`, drawn only when the file exists (missing asset: logo.jpg is not in the zip) |
| logo offset | uvaletter.sty:29 | `sp.manual-space` | `\vspace{-2cm}`, `\hspace{-1.31cm}` |
| letterhead boxes | uvaletter.sty:28,32,35,44,48,52,57,61,65,70,76 | `box.minipage` | widths \textwidth (logo, subject, enclosed), .4975\textwidth with `[b]` (recipient, department), .3\textwidth (the six info cells) |
| recipient block alignment | uvaletter.sty:33 | `sp.ragged` | `\raggedright` |
| department and address block alignment | uvaletter.sty:36 | `sp.ragged` | `\raggedleft` |
| body alignment | uvaletter.sty:82 | `sp.ragged` | `\raggedright` for the letter text |
| block font sizes | uvaletter.sty:36,89 | `font.size-commands` | `\small` (department block), `\scriptsize` (field labels, via `\tabentry`) |
| block font faces | uvaletter.sty:36,37,89 | `mark.kernel` | `\sffamily` (department block, labels), `\bfseries` on the department name |
| gaps and line breaks | uvaletter.sty:37-40,43,45-46,75,80 | `sp.manual-space` | `\medskip` before visiting, postal and website; four `\bigskip` before the info grid; `\bigskip` after enclosed; `\newline` under each label; `\\` |
| sectioning, lists, floats, tables, theorems, code, notes, bibliography, index, maths | uvaletter-demo.tex:24-40 | none used | the sample has no heading, list, float, table, theorem, code, note, citation or equation |
| salutation, body, closing, signature | uvaletter-demo.tex:27-37 | content | plain paragraphs; `\\` line break in the signature at demo:37 (`sp.manual-space`) |
| loaded, no printed effect | uvaletter.sty:15,17,18 | `sp.setspace`, `mark.ulem` | `setspace` and `soul` are loaded and none of their commands is used (no `\setstretch`, `\onehalfspacing`, `\ul`, `\so`, `\hl` in the file); `ifthen` is loaded for the tests in the bespoke table |

## Bespoke code
The `.sty` is not zip-local: it is the CTAN release (see Class origin), so none of it counts as bespoke under W1. The table records it anyway, with the reduction to lib ways, so the answer can be re-read under a stricter definition.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `uvaletter.sty` as a whole | uvaletter.sty:6-117 | yes | `font.fontenc-t1` (T1, utf8), `page.geometry` (a4paper, margin=3.05cm), `font.mathptmx` (times), `sp.microtype`, `hf.fancyhdr` (fancy, cleared fields, no head rule), `pgnum.lastpage`, `fig.graphicx`, `sp.lengths` (parindent 0pt, parskip 1em plus 0.2em minus 0.2em), plus the `letterhead` block below; loaded-but-unused `setspace`, `soul` can be dropped |
| `letterhead` environment | uvaletter.sty:25-83 | yes | a fixed sequence of `box.minipage` boxes with `sp.ragged`, `font.size-commands`, `mark.kernel`, `sp.manual-space` and `fig.graphicx`, as in the component map; no output routine, no `\halign`, no counters |
| emptiness tests `\ifthenelse{\equal{\@x}{}}` and `\IfFileExists{\@logo}` | uvaletter.sty:26,27,38,39,75 | yes | each only decides whether an optional field block (logo, visiting, postal, enclosed) is printed; an emitter that holds the document model knows which fields are present and which logo file it ships, so it prints or omits the block statically (inline expansion). `ifthen` is a macro-body helper with no node content to wrap, so no way is proposed (as the v4 rejection of `sp.xspace`) |
| thirteen package-defined field commands and their stores `\@logo` ... `\@enclosed` | uvaletter.sty:90-115 | yes | `\newcommand` pairs that only store a string and print it later; the emitter substitutes the strings inline (or emits the commands unchanged with the package loaded) |
| `\tabentry` | uvaletter.sty:89 | yes | alias of `\scriptsize\sffamily` (`font.size-commands`, `mark.kernel`) |
| option `pageno` | uvaletter.sty:23 | yes | one `\rfoot` call of `hf.fancyhdr` with `pgnum.lastpage` and `xref.kernel` |
| letterhead strings with `\\`, `~`, `\,` | uvaletter-demo.tex:10,13,18,19 | yes | content of the field strings (`sp.manual-space` for `\\`) |

## Content-opaque
none (the logo image `logo.jpg` named at uvaletter-demo.tex:9 is a missing asset, not shipped; the screenshot shows it was a University of Amsterdam logo; `screenshot.jpg` and `uvaletter-demo.pdf` are renders and out of scope)

## Lib changes
- New ways proposed: none. (`class.uvaletter` is written plainly as a class-like way, with the vocabulary recorded under Class setting; no `NEW:` id is used.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
