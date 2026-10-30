yes

# 0413-sageep: SAGEEP (EEGS annual meeting papers, Boris Veytsman)

- Unverified: read from the source, not compiled.
- Source: Source/0413-sageep/ (origin: https://mirrors.ctan.org/macros/latex/contrib/sageep.zip; licence: LPPL 1.3, sageep.dtx:6-8 and manifest `lppl1.3`)
- Kind: conference (annual meeting papers, README:1-12; the manifest hint `journal` is not followed)
- Lib: v4
- Engine: pdfLaTeX-compatible (Type 1 font packages only, sageep.dtx:345-347; the package Makefile builds with `pdflatex`, Makefile:20,34)
- Look carried by: class (the whole look is in `sageep.cls`, which is not shipped and is generated from `sageep.dtx` by `sageep.ins`; the sample adds only `lipsum`, `graphicx` and content, sample.tex:2-3)
- Class origin: ctan (ctan.org/pkg/sageep read once: "SAGEEP, Format papers for the annual meeting of EEGS", LPPL 1.3, in TeX Live and MiKTeX, CTAN directory `macros/latex/contrib/sageep`)
- Main file: sample.tex (other samples: none; `sageep.dtx` is the class source and documentation)
- Read: main yes, zip-local classes and styles all (no `.cls` or `.sty` is shipped; the class source `sageep.dtx` read in full, 515 lines; `sageep.bst` read partly: header and the `@MANUAL` edits, the rest is makebst output)

## Verdict
The look is set by a class that is published on CTAN (`class.sageep`), and the sample only adds `lipsum`, `graphicx` and content, so under the pilot ruling it is a class-carried `yes`. The answer does not rest on that ruling: every class-internal line (`sageep.dtx:313-496`) is a plain call of a kernel command or a published package (`geometry`, `mathptmx`, `helvet`, `courier`, `indentfirst`, `caption`, `natbib`, `\@startsection` parameters) or a small redefinition that reduces to them (`\maketitle`, repeatable `\author`, `\let\cite=\citep`). There is no artwork, no tool outside TeX (BibTeX is the `bib.bibtex-bst` way) and no unmapped component. Not compiled; the reductions of `\maketitle` below are read from the code, not checked against the `titling` hook internals.

## Blockers
none

## Class setting
- Class: `class.sageep` options: none in the sample (sample.tex:1). The class accepts `8pt`..`12pt` only to warn that they are ignored (sageep.dtx:313-320); every other option is passed to `book` (sageep.dtx:326), which is never loaded (the class loads `article`, sageep.dtx:335), so such options have no effect. Base: `\LoadClass[12pt]{article}` (sageep.dtx:335).
- Class-native vocabulary used: `\author{name, affiliation, city}` repeatable, one call per author (sample.tex:7-8; sageep.dtx:392-398); `\maketitle` after `\title` and `\author` (sample.tex:9; sageep.dtx:407-419); `\section` and `\subsection` unnumbered (sample.tex:11,15,19,54,58; sageep.dtx:431-448); `\cite` equal to natbib `\citep` (sample.tex:22-25; sageep.dtx:496); table `\caption` placed before the `tabular` (sample.tex:35; sageep.dtx:210-215); `\bibliographystyle{sageep}` (sample.tex:63; sageep.dtx:251-253).

## Component map
Rows name what the class loads or sets internally (the ways it realises), so the map reads the same whether the class is counted as one way or taken apart.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | sample.tex:1; sageep.dtx:281 | `class.sageep` | no options in the sample |
| base size | sageep.dtx:335 | `page.class-options` | `\LoadClass[12pt]{article}`; size options 8pt..12pt only warn (sageep.dtx:313-320) |
| page geometry | sageep.dtx:357 | `page.geometry` | top=0.75in, left=0.75in, right=0.75in, bottom=1in |
| paragraph indent | sageep.dtx:364 | `sp.lengths` | `\parindent`=0.5in |
| indent after headings | sageep.dtx:370 | `sp.indentfirst` | no options |
| serif font | sageep.dtx:345 | `font.mathptmx` | `mathptmx` (Times text and math) |
| sans font | sageep.dtx:346 | `font.helvet` | `helvet`, option `scaled` |
| mono font | sageep.dtx:347 | `font.mono` | `courier` |
| header and footer | sageep.dtx:379 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| title, author, maketitle commands | sample.tex:5-9 | `front.maketitle` | `\title`, `\author` twice, `\maketitle`; no `\date`, none printed (sageep.dtx:407-419) |
| repeatable author list | sageep.dtx:392-398 | `front.class-native` | each `\author{..}` appends to `\authors` joined by `\and` |
| title block layout | sageep.dtx:407-419 | `front.class-native` | one centred group; title then authors then a blank line each; date and `\thanks` handling absent |
| title case | sageep.dtx:412 | `mark.case` | `\MakeUppercase{\@title}`; headings are not changed in case (sageep.dtx:193-200) |
| title and author faces | sageep.dtx:412,417 | `font.size-commands` | title `\large`; authors `\normalfont` |
| title and author shape | sageep.dtx:412,417 | `mark.kernel` | title `\bfseries`; authors `\itshape` |
| title centring | sageep.dtx:409 | `sp.ragged` | `\centering` inside a group |
| title spacing and author break | sageep.dtx:412,416-417 | `sp.manual-space` | `\vspace{\baselineskip}` after title and after authors; `\let\and=\linebreak` between authors |
| abstract | sample.tex:11; sageep.dtx:202-203 | `head.kernel` | an ordinary unnumbered `\section{Abstract}`; no `abstract` environment; a first-section convention only |
| section heading | sageep.dtx:438-439 | `head.kernel` | `\renewcommand\section{\@startsection{section}{1}{0pt}{\baselineskip}{\baselineskip}{\normalfont\centering\large\bfseries}}` |
| subsection heading | sageep.dtx:447-448 | `head.kernel` | `\@startsection{subsection}{2}{0pt}{\baselineskip}{1sp}{\normalfont\normalsize\itshape\bfseries}` |
| heading numbering | sageep.dtx:431 | `num.secnumdepth` | `secnumdepth`=0 (no numbers) |
| footnote | sample.tex:24 | `fn.kernel` | plain `\footnote`, kernel look |
| figure | sample.tex:28-32; sample.tex:3 | `fig.graphicx` | `figure[bhp]`, `\includegraphics{sageep_graphic2009}` (shipped jpg), not centred |
| table | sample.tex:34-48 | `tbl.tabular` | `tabular{lll}` with `\hline` rules only; `table[htbp]` |
| caption look | sageep.dtx:460,465 | `cap.caption` | `labelfont=bf`, `indent=0pt`, `singlelinecheck=off` |
| table caption position | sageep.dtx:470; sample.tex:35 | `cap.caption` | `\captionsetup[table]{position=above}`; the body puts `\caption` first |
| float placement | sageep.dtx:477-481 | `fig.placement` | `\textfraction`=0.05, `\topfraction`=0.95, `\bottomfraction`=0.95, `\floatpagefraction`=0.35, counter `totalnumber`=5 |
| labels | sample.tex:31,36 | `xref.kernel` | `\label` only; the sample prints no `\ref` |
| citations | sageep.dtx:491,496; sample.tex:22-25 | `bib.natbib` | `\RequirePackage[round]{natbib}`; `\let\cite=\citep` |
| bibliography | sample.tex:62-63 | `bib.bibtex-bst` | `\bibliography{sageep}`, style `sageep.bst` (makebst output, hand-edited `@MANUAL`, sageep.bst:7-8) |
| references heading | sample.tex:62 | `bib.natbib` | natbib's default `\bibsection` (`\section*{\refname}`), so it takes the class section look; not read in natbib's source |
| filler text | sample.tex:2,13,51,56,60 | `draft.todo` | `lipsum` with `\lipsum[1]`, `[2-5]`, `[5-8]`, `[9-10]` (content) |

## Bespoke code
The class is published, so under the rubric none of this is bespoke. The items are listed for the stricter reading (class code counted as zip code); each reduces, so the verdict does not change. Scope on that reading: `class`.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| size-option warning macro `\sageep@size@warning` | sageep.dtx:313-320 | yes | no printed effect (a log warning); the emitter fixes 12pt through `page.class-options` |
| option pass-through to `book` | sageep.dtx:326-327 | yes | no effect (`book` is never loaded, sageep.dtx:335); the emitter omits it |
| repeatable `\author` with `\authors` and `\g@addto@macro` | sageep.dtx:392-398 | yes | the emitter writes one `\author{A \and B}` from the model's author list (`front.maketitle`), or calls the class's `\author` once per author (`front.class-native`) |
| `\def\maketitle` | sageep.dtx:407-419 | yes | `front.titling` hooks `\pretitle` `\posttitle` `\preauthor` `\postauthor` holding `\begingroup\centering`, `\large\bfseries`, `\itshape`, `\vspace{\baselineskip}`, `\let\and\linebreak` and a closing `\endgroup`, with `\MakeUppercase` around the title text (`mark.case`); or the same kernel commands written once in the body. The two `\ifx\@empty` guards only skip empty fields. Not checked against `titling`'s hook internals |
| `\section` and `\subsection` redefinitions | sageep.dtx:438-439, 447-448 | yes | `head.kernel` (the kernel's own `\@startsection` with its six documented arguments), or `head.titlesec`: `\titleformat{\section}{\normalfont\centering\large\bfseries}{}{0pt}{}` with `\titlespacing*`, and the same for `\subsection`; the first paragraph is indented by `indentfirst` either way (sageep.dtx:370) |
| `\let\cite=\citep` alias | sageep.dtx:496 | yes | the emitter writes `\citep` (natbib) |
| `sageep.bst`, makebst `merlin.mbs` output edited so that a `@MANUAL` without author uses its organization for printing, sorting and labels | sageep.bst:7-8, 632-633, 1111-1130, 1322-1323, 1446-1447 | yes | the `.bst` file is the parameter of `bib.bibtex-bst`; the edit changes nothing for the sample, whose manual entries all have an `author` (sageep.bib:8-32) |
| `sageep.ins` DocStrip driver that writes `sageep.cls` from the `class` guard | sageep.ins:14-15 | yes | TeX only (`pdflatex sageep.ins`, Makefile:31); not outside TeX. The emitter ships the CTAN `sageep.cls` |
| the package Makefile (pdflatex, bibtex, makeindex) | Makefile:19-39 | yes | builds the package manual and the sample only; not part of the template. `bibtex` is `bib.bibtex-bst`; `makeindex` serves only the `.dtx` manual |

## Content-opaque
none. (The figure image `sageep_graphic2009.jpg`, sample.tex:29, is a shipped asset held by `fig.graphicx`; the bibliography entries in `sageep.bib` are content.)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
