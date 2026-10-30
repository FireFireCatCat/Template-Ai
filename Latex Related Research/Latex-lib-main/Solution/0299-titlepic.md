yes

# 0299-titlepic: titlepic, a picture on the \maketitle page (package v1.2, 2017) with its manual

- Unverified: read from the source, not compiled.
- Source: Source/0299-titlepic/ (origin: https://mirrors.ctan.org/macros/latex/contrib/titlepic.zip; licence: pd per manifest, README.md:17 "Public Domain"; ctan.org/pkg/titlepic read once: CTAN package, Public Domain Software, in TeX Live and MiKTeX)
- Kind: misc (a package's own source and manual, not a document template; the manual is a short `article` that doubles as the usage example, titlepic-manual.tex:1-2)
- Lib: v4
- Engine: pdfLaTeX-compatible (kernel `article`, `titlepic` and boxes only; no font or Unicode package)
- Look carried by: mixed (kernel `article` with `titlepage` gives headings, lists, quotes and page; the published package `titlepic` gives the title page; both come from the preamble, titlepic-manual.tex:4-6; no zip-local class or style, `titlepic.sty` is the CTAN release itself)
- Class origin: tex-distribution-unbundled (`article`, not in the zip; the package `titlepic` is `ctan`)
- Main file: titlepic-manual.tex (other samples: none; the package source is titlepic.sty, the README is README.md, titlepic-manual.pdf is the compiled manual and was not read)
- Read: main yes (119 lines), zip-local classes and styles all (titlepic.sty read in full, 90 lines; README.md read in full; it is the published package, not a zip-local style)

## Verdict
yes. The zip is the CTAN source of the `titlepic` package plus its manual. The manual is kernel `article` with the `titlepage` option, one `\usepackage[cc]{titlepic}` and ordinary kernel front matter, headings, lists, quotes and verbatim text, each a lib way. The package itself is published (W1: on CTAN, TeX Live and MiKTeX) and is the existing lib way `front.titlepic`, with three layout options as parameters, so its internal `\maketitle` override (titlepic.sty:32-68) is the way's own code and not zip-local code an emitter would copy. The only zip-local macro is the manual's `\placeholder`, a stand-in for the image that goes in the picture slot; it is content and also reduces by inline expansion to boxes. No `ART`. The verdict rests on counting the published package as a way, as in the precedent of 0008-envlab; if `titlepic`'s internals had to be rebuilt from other ways it would be `no` (BESPOKE/package at titlepic.sty:31-90).

## Blockers
none

## Class setting
- Class: `class.article` options: `titlepage` (titlepic-manual.tex:4). The kernel class source is not in the zip and was not read.
- Class-native vocabulary used: `\title` `\author` (with `\\` and `\thanks`) `\date` `\maketitle` (titlepic-manual.tex:20-25, 30); `\section` (titlepic-manual.tex:32, 38, 47, 71, 84, 114); `itemize`, `description`, `quote`, `verbatim` (titlepic-manual.tex:41-45, 75-82, 51-53, 88-112). The `titlepage` option is read by the package at load time (`\if@titlepage`, titlepic.sty:31), so it selects the package's code branch.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | titlepic-manual.tex:4 | `class.article` | `titlepage` |
| title-page picture slot (the package) | titlepic-manual.tex:6, 26; titlepic.sty:15, 26-27 | `front.titlepic` | `\usepackage[cc]{titlepic}`; `\titlepic{...}` with one content argument, set in the preamble before `\maketitle` |
| title-page vertical layout | titlepic-manual.tex:6, 73-82; titlepic.sty:18-22 | `front.titlepic` | package option `cc` (explicit; also the default, `\ExecuteOptions{cc}` titlepic.sty:21): top space `\null\vfil`, gap `\vskip 3em`; the other values are `tt` (no top space, `\vskip 3em`) and `tc` (no top space, `\vfil`), titlepic.sty:18-20; options act only in the `titlepage` branch (manual comment, titlepic-manual.tex:92) |
| title-page build (fixed inside the package) | titlepic.sty:32-68 | `front.titlepic` | `titlepage` environment: title `\LARGE`, 3em gap, author in a one-column `tabular` `\large`, 1.5em gap, date `\large`, then the centred `\titlepic` content, `\vfil`, `\@thanks`; `\footnote` made `\thanks`, footnote rule removed (titlepic.sty:34-36, 39-53); counters and commands reset after use (55-67); not an option, so not a parameter of the way |
| title page without `titlepage` option | titlepic.sty:69-90 | `front.titlepic` | the same way's other branch (`\@maketitle` with the picture below the date, titlepic.sty:70-89); the sample does not take it, titlepic-manual.tex:4 |
| title block | titlepic-manual.tex:20-25, 30 | `front.maketitle` | `\title{\LaTeX{} \texttt{titlepic} Manual}`, `\author{...}` with `\\` breaks, `\date{March 14, 2017}` (fixed text), `\maketitle`; own page from the `titlepage` option and the package override |
| author note | titlepic-manual.tex:22 | `front.thanks` | `\thanks{\texttt{<ttencate@gmail.com>}}` |
| headings | titlepic-manual.tex:32, 38, 47, 71, 84, 114 | `head.kernel` | `\section`, default numbering and look; no `\renewcommand`, no `titlesec` |
| bullet list | titlepic-manual.tex:41-45 | `list.kernel` | `itemize`, three `\item`, default markers |
| description list | titlepic-manual.tex:75-82 | `list.kernel` | `description` with `\item[\tt{tt}]` labels (old switch `\tt` in the label) |
| quotations (code lines shown as quotes) | titlepic-manual.tex:51-53, 57-59, 63-65 | `quote.kernel` | `quote` environment, content is a `\verb` line |
| inline code and verbatim code | titlepic-manual.tex:34, 36, 52, 58, 64, 117 (`\verb$...$`); 88-112 (`verbatim` environment) | `code.verbatim` | `\verb` with `$` as the delimiter; `verbatim` environment holding a sample preamble and body; code text is content |
| inline font and emphasis | titlepic-manual.tex:20, 22 (`\texttt`), 36 (`\textbf{Note:}`), 76-80 (`\tt`) | `mark.kernel` | kernel font switches only |
| picture placeholder (the picture is content) | titlepic-manual.tex:10-18, 26 | `box.fancybox`, `box.minipage`, `sp.rule`, `sp.ragged` | `\framebox[width]{...}` with `\fboxsep` set to 0pt in a group, two `\parbox`es, `\rule{0pt}{height}`, `\centering`; the inline expansion is written in the Bespoke table; this is the manual's stand-in for the image (its text says "The picture goes here", titlepic-manual.tex:15) |
| documented real picture in the slot | titlepic-manual.tex:55-65, 95, 103 (verbatim text, not run) | `fig.graphicx` | `\usepackage{graphicx}` and `\includegraphics[width=\textwidth]{cover.png}` as the `\titlepic` argument; shown as prose and verbatim only, not loaded in the sample's preamble |
| page geometry | none set | n/a | no `geometry`, no `\setlength`; class defaults |
| header/footer | none set | n/a | no `\pagestyle`, no `fancyhdr`; the `titlepage` environment is the kernel's (page without number) |
| fonts, colour, spacing | none set | n/a | no font, `xcolor`, `setspace` or `microtype` package loaded |
| language, metadata, cross-references, contents | none | n/a | no `babel`, `hyperref`, `\label`, `\tableofcontents`; the URL at titlepic-manual.tex:117 is plain `\verb` text |
| math, theorems, floats, tables, bibliography, index, notes | none | n/a | not in the sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `titlepic.sty` (`\titlepic`, `\renewcommand\maketitle`, `\def\@maketitle`, options `tt` `tc` `cc`) | titlepic.sty:18-90 | not bespoke: published CTAN package (W1), the way `front.titlepic` | emitter writes `\usepackage[cc]{titlepic}` and `\titlepic{<content>}`; if the file were zip-local its `\maketitle` and `\@maketitle` override would be `BESPOKE/class` (titlepic.sty:32-68, 70-89), so this row is the one the verdict rests on |
| `\placeholder{w}{h}` | titlepic-manual.tex:10-18 (called at 26 as `\placeholder{\textwidth}{0.75\textwidth}`) | yes (and it is content) | inline expansion at the call: `\noindent{\setlength{\fboxsep}{0pt}\framebox[\textwidth]{\parbox{0pt}{\rule{0pt}{0.75\textwidth}}\parbox{\textwidth}{\centering The picture goes here.}}}`, that is `box.fancybox` (`\framebox`, `\fboxsep`), `box.minipage` (`\parbox`), `sp.rule` (`\rule`), `sp.ragged` (`\centering`); `\noindent` is a kernel paragraph command carried as written inside the content argument; no conditional, counter or loop |

## Content-opaque
none. The argument of `\titlepic` is a picture (content): here a placeholder frame that reduces to ways (above), in real use an `\includegraphics` (titlepic-manual.tex:64). It is not template-defining artwork: it stands in for the author's image and carries no identity of the template (titlepic-manual.tex:8, 15).

## Lib changes
- New ways proposed: none. `front.titlepic` already exists in lib v4 (accepted v2).
- Note for the consolidator, not a proposal: the existing `front.titlepic` line does not mention the package options `tt` `tc` `cc` (default `cc`, titlepic.sty:18-21), which are parameters of the same way, nor that the package only overrides the title page of the kernel classes `article`, `report` and `book` (titlepic-manual.tex:36; README.md:13-14).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
