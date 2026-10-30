yes

# 0055-uiucredborder: the `uiucredborder` class (v1.00, 2000), UIUC red-bordered form filler

- Unverified: read from the source, not compiled.
- Source: Source/0055-uiucredborder/ (origin: https://mirrors.ctan.org/macros/latex/contrib/uiucredborder.zip; licence: lppl1.2 per manifest, uiucredborder.dtx:6-12 says LPPL 1.2 or later; ctan.org page not read, the CTAN origin path settles W1)
- Kind: misc (a one-page fill-in of a pre-printed graduate-college form that accompanies a thesis; the manifest hint says thesis, but the output is not a thesis)
- Lib: v1
- Engine: pdfLaTeX-compatible (kernel commands, `geometry`, kernel `size1x.clo`; no fontspec, no tool outside TeX)
- Look carried by: class (the whole look is the class `\maketitle`, uiucredborder.dtx:287-305; the sample adds only `\title` `\author` `\degreemonth` `\degreeyear` `\phdthesis` and an option)
- Class origin: ctan (zip is the CTAN source, DocStrip `.dtx` + `.ins`; the generated `.cls` is not in the zip)
- Main file: uiucredborder.dtx (the usage example is the verbatim block at uiucredborder.dtx:136-148; the compiled-documentation driver at uiucredborder.dtx:25-36 is a second sample, `class.ltxdoc`; other samples: none)
- Read: main yes, zip-local classes and styles none present (no `.cls` or `.sty` in the zip; I read the whole of uiucredborder.dtx, 347 lines, including all of the `<class>` code at 160-344, and the whole of uiucredborder.ins; uiucredborder.pdf, the 12-page compiled documentation, was not read)

## Verdict
yes. The zip is the CTAN source of one small published class, so the look is `class.uiucredborder` (W1 met). The usage sample is a single `\maketitle` with four fields. Independently of the "published class" ruling, I read the whole class code and it is straight-line constants (kernel `\vspace*` `\hspace*` `\parbox` `minipage`, mm lengths, `\textbf{\MakeUppercase{...}}`, `geometry` with zero margins, `\thispagestyle{empty}`) with no counters, loops, conditionals that drive layout, or output routine, so it reduces to existing ways even if it were treated as zip-local. No `ART`: the class draws no border, rule or colour; the red border is on the pre-printed paper form, and the class only types text into its blanks (uiucredborder.dtx:65-71, 188-195).

## Blockers
none

## Class setting
- Class: `class.uiucredborder` options: `11pt` in the sample (uiucredborder.dtx:137); the class accepts `10pt` (default), `11pt`, `12pt`, `linecentered` (uiucredborder.dtx:113-122, 315, 322-324). Second sample: `class.ltxdoc` options: none (uiucredborder.dtx:26); ltxdoc source not read (distribution class).
- Class-native vocabulary used (uiucredborder): `\degreemonth{May}` `\degreeyear{2001}` `\phdthesis` (or `\msthesis`) and `\maketitle` (uiucredborder.dtx:138-147; definitions 170-172, 182, 287-305), with the kernel `\title` `\author` read as `\@title` `\@author` (287-305); hook `\formattext` (one argument, default bold uppercase, redefinable with `\renewcommand`, 126-130, 279). No `\date`, no sectioning, no abstract in the class: it defines none.
- Class-native vocabulary used (ltxdoc, driver only): `\EnableCrossrefs` `\CodelineIndex` (27-28), `\DocInput` (34), `\changes` (41), `\CheckSum` (43), `\DoNotIndex` (61-63), `\DescribeMacro` (80-95), `macro` and `macrocode` environments (159-344), `\StopEventually{\PrintIndex}` (150), `\Finale` (346), `\cmd` (80-105).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | uiucredborder.dtx:18-20, 137 | `class.uiucredborder` | `11pt` in the sample; options `10pt` (default) `11pt` `12pt` `linecentered` |
| paper size | uiucredborder.dtx:21-22 | `page.setlength` | `\paperwidth`=8.5in, `\paperheight`=11in, set before `geometry` loads |
| page geometry | uiucredborder.dtx:23, 337-339 | `page.geometry` | `noheadfoot`, `letterpaper`, `marginparsep=0pt`, `lmargin=0mm` `rmargin=0mm` `tmargin=0mm` `bmargin=0mm` (zero margins so every later length is measured from the paper corner, 335) |
| font size | uiucredborder.dtx:113-117, 321-330 | `page.class-options` | `10pt`/`11pt`/`12pt` pick the kernel `size10.clo`/`size11.clo`/`size12.clo` through `\@ptsize`; default `10pt` |
| header/footer | uiucredborder.dtx:288 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| title-block data | uiucredborder.dtx:138-140, 285 | `front.maketitle` | kernel `\title{A \LaTeX\ Class ...}` and `\author{Scott Pakin}` used as the title and name fields; `\date` unused |
| form fields | uiucredborder.dtx:141-143, 170-172, 182, 287-305 | `front.class-native` | `\degreemonth{May}` `\degreeyear{2001}` `\phdthesis` (prints "Doctor of Philosophy"; `\msthesis` prints "Master of Science"); `\maketitle` fills date, name, title, degree; body is only `\maketitle` (110-111, 145-147) |
| field positions | uiucredborder.dtx:236-239, 259-262, 290-304 | `sp.manual-space` | `\vspace*{65mm}` then `\hspace*{\date@indent}`; `\vspace*{22mm}` then `\hspace*{\author@indent}`; `\hspace*{\title@indent}`; `\vspace*{-1mm}` then `\hspace*{\degree@indent}`; indents 127/60/60/60 mm (default) or 127/39/60/73 mm (`linecentered`) |
| field widths and boxes | uiucredborder.dtx:241-244, 264-267, 291, 294, 297, 304 | `box.minipage` | `\parbox[t]{\date@width}` 63mm; `\parbox[t]{\author@width}` 130mm (150mm with `linecentered`); `minipage[t][3\baselineskip]{\title@width}` 130mm; `\parbox[t]{\degree@width}` 130mm (118mm with `linecentered`) |
| line spacing and indent | uiucredborder.dtx:289, 299 | `sp.lengths` | `\baselineskip`=11mm, `\parindent`=0pt (set twice, inside the title `minipage` too) |
| centring of the title field | uiucredborder.dtx:298-301 | `sp.ragged` | `center` environment around `\formattext{\@title}` (kernel counterpart of `\centering`) |
| centring of the other fields | uiucredborder.dtx:292, 295, 304 | `sp.manual-space` | `\hfil ... \hfil` inside each `\parbox` (the kernel fill-glue pair) |
| text mark | uiucredborder.dtx:126-130, 279 | `mark.kernel` | `\formattext` = `\textbf{\MakeUppercase{#1}}`, applied to every field |
| doc driver: class | uiucredborder.dtx:26-35 | `class.ltxdoc` | no options; `\EnableCrossrefs`, `\CodelineIndex`, `\DocInput{uiucredborder.dtx}` |
| doc driver: title block | uiucredborder.dtx:30-33 | `front.maketitle` | `\title` with `\textsf`, `\author` with `\\`, fixed `\date`, `\maketitle` |
| doc: abstract | uiucredborder.dtx:65-71 | `abs.kernel` | `abstract` environment, ltxdoc look |
| doc: headings | uiucredborder.dtx:73, 75, 113, 124, 132, 152, 163, 186, 272, 309, 333 | `head.class-native` | `\section` and `\subsection`, ltxdoc look, no `\renewcommand` of headings |
| doc: lists | uiucredborder.dtx:79-92, 190-195 | `list.kernel` | `description` and `itemize`, default labels |
| doc: verbatim | uiucredborder.dtx:136-148, 101-107, 127-130 | `code.verbatim` | `verbatim` environment for the example, `|...|` short-verb spans (class-native from doc/ltxdoc) |
| doc: code listing | uiucredborder.dtx:159-344 | `code.verbatim` | ltxdoc `macrocode` and `macro` environments; the code text is content |
| doc: index | uiucredborder.dtx:28, 150 | `idx.makeidx` | closest way: ltxdoc's `\CodelineIndex` and `\PrintIndex` need a makeindex pass (`gind.ist`), as in 0008-envlab; documentation only, not part of the form |
| doc: text marks | uiucredborder.dtx:30, 69, 254 | `mark.kernel` | `\textsf`, `\texttt`, `\textit`, `\LaTeX`; `\noindent` at 94 |
| doc: inline maths | uiucredborder.dtx:121 | `math.kernel` | `3$\:$cm`, content |

No rows for colour, fonts, language, theorems, floats, tables, captions, bibliography, footnotes, cross-references, code styling: neither the class nor the sample uses them (no `\usepackage` in the sample; the class loads only `geometry`).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\phdthesis` `\msthesis` `\degreeyear` `\degreemonth` | uiucredborder.dtx:170-172, 182 | yes | `\def` string setters (`\@degree`, `\@degreeyear`, `\@degreemonth`); class vocabulary, reduces to the printed strings: `front.class-native` |
| length registers, `\center@lines`, `\center@globally` | uiucredborder.dtx:204-207, 220-223, 235-245, 258-268, 314-315 | yes | eight `\newlength` registers and two fixed tables of eight mm `\setlength` values, chosen by one boolean option (`linecentered`); no arithmetic: `sp.lengths` plus option |
| `\@ptsize` size selection | uiucredborder.dtx:321-330 | yes | the standard-class pattern (`\newcommand\@ptsize`, `\DeclareOption{10pt,11pt,12pt}`, `\input{size1\@ptsize.clo}`) : `page.class-options` |
| `\formattext` | uiucredborder.dtx:279 | yes | `\textbf{\MakeUppercase{#1}}` : `mark.kernel` |
| `\maketitle` (redefines the kernel one) | uiucredborder.dtx:287-305 | yes | straight-line constants, no counters, loops or conditionals: `hf.pagestyle-kernel` (`\thispagestyle{empty}`), `sp.lengths` (`\baselineskip`, `\parindent`), `sp.manual-space` (`\vspace*` `\hspace*` `\hfil`), `box.minipage` (`\parbox`, `minipage`), `sp.ragged` (`center`), `mark.kernel`. Not counted as zip-local because the class is the CTAN release; the reduction is written so the verdict does not depend on that ruling |
| class internals overall | uiucredborder.dtx:160-344 | not applicable: published | CTAN `uiucredborder` v1.00 (2000/11/02, uiucredborder.dtx:19-20); the emitter writes `\documentclass[11pt]{uiucredborder}` and the field commands, not this code: `class.uiucredborder` |
| DocStrip batch file | uiucredborder.ins:19-42 | yes, nothing to emit | `\input docstrip` run through TeX (no outside tool); `\generate` writes uiucredborder.cls from the `<class>` guard; installation infrastructure that typesets nothing |
| DocStrip guards and `\iffalse` blocks | uiucredborder.dtx:1-37, 160, 343 | yes | comment-level `%<class>`, `%<*driver>` markup read by docstrip, never typeset |

Note for an emitter: `\@degree` is undefined, so the run fails, unless `\msthesis` or `\phdthesis` is called (documented requirement, uiucredborder.dtx:95-99); `\degreemonth`, `\degreeyear`, `\title`, `\author` must also be set (77-92). The output only makes sense on the pre-printed paper form.

## Content-opaque
none (the example in the verbatim block at uiucredborder.dtx:136-148 is documentation text; no figures, no pictures; uiucredborder.pdf is the compiled output, not read)

## Lib changes
- New ways proposed: none (`class.uiucredborder` is a class way and needs no proposal)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
