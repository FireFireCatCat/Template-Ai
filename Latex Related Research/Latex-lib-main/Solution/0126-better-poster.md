yes

# 0126-better-poster: Better Poster

- Unverified: read from the source, not compiled.
- Source: Source/0126-better-poster/ (origin: https://latextemplates.com/downloads/betterposter.zip; licence: GPL-3.0, header at betterposter.cls:2)
- Kind: poster
- Lib: v2
- Engine: pdfLaTeX-compatible
- Look carried by: zip-local (betterposter.cls defines page, fonts, colours, the three-column layout and the heading looks; main.tex adds only content and the options `a0paper,fleqn`)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
Yes, by a judgement call on one point (see the last paragraph). `betterposter.cls` is zip-local (ctan.org/pkg/betterposter is a 404; the zip comes from latextemplates.com, not the author's own page), so its whole effect has to reduce. It does: it is `\LoadClass{article}` plus published packages, `\geometry`, `\setlist`, `\definecolor`, `\setlength` and `\newcommand` macros that expand to kernel `minipage`, `\colorbox`, `\fontsize`, `\vspace` and `\textbf`. The class has no `\def`, no internal `@` macro, no conditional, no counter, no `\setbox`/`\halign` and no TikZ or picture code (grep over `betterposter.cls`). The coloured columns are `\colorbox` around minipages (cls:136), not drawn shapes, so there is no `ART`.
Judgement call: the three-column page (`\betterposter`, `\column`, `\centeredpage`, cls:119-158) is a multi-argument layout macro with `\dimexpr` arithmetic on kernel lengths. It is read as a `\newcommand` alias for nested published boxes, which the rubric calls reducible. A stricter reading that counts it as hand-rolled layout logic would turn this into `no`.

## Blockers
none

## Class setting
- Class: `class.article` (loaded by the zip-local class at betterposter.cls:13; options in main.tex:2: `a0paper` is declared by the zip-local class at cls:99-101, `fleqn` falls to `\DeclareOption*` at cls:103 and is an article option). `class.betterposter` is not a way: not published (W1).
- Class-native vocabulary used (all zip-local, none published): `\betterposter{main}{left}{right}` (main.tex:5, 11, 44), `\title`, `\author` twice, `\institution` (main.tex:14-17), `\section` (main.tex:19, 26, 33, 41, 47, 52). Each reduces to kernel wrappers below. Defined but not called by the sample: `\maincolumn`, `\qrcode`, `\compactqrcode`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:2; betterposter.cls:13 | `class.article` | `\LoadClass{article}`, options `fleqn` |
| paper, orientation, margins | betterposter.cls:19-26, 99-101 | `page.geometry` | `a0paper`, `landscape`, `margin=0in`; options `a1paper`/`a2paper` (cls:81-97) re-set the paper and pick a smaller size set |
| page style | betterposter.cls:14 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| text and math face (CM Bright) | betterposter.cls:29 | `font.helvet` | package `cmbright` (sans text face, package is the parameter) |
| text face (Lato) | betterposter.cls:30 | `font.helvet` | package `lato`, option `default` (source of `lato` not read) |
| encoding | betterposter.cls:31 | `font.fontenc-t1` | `fontenc` option `T1` |
| size set | betterposter.cls:75-79; a2: 83-87; a1: 92-96 | `font.size-commands` | a0: standard `\fontsize{32}{50.50}`, main `{116}{220}`, title `{80}{120}`, author `{48}{68}`, section `{48}{68}`; a2 and a1 give other numbers |
| list spacing | betterposter.cls:34-37 | `list.enumitem` | `\setlist{nolistsep}`, `\setenumerate{noitemsep}`, `\setitemize{noitemsep}` |
| itemize | main.tex:27-31 | `list.kernel` | `itemize`, three `\item` |
| paragraph indent | betterposter.cls:38 | `sp.lengths` | `\parindent=0pt` |
| colour definitions | betterposter.cls:41-46 | `color.xcolor` | `imperialblue` RGB 0,62,116; `empirical`, `theory`, `methods`, `intervention` defined, never used by the class |
| colour roles | betterposter.cls:48-51 | `color.xcolor` | side columns white on black text; main column `imperialblue` with white text (aliases, inlined by the emitter) |
| graphics package | betterposter.cls:54 | `fig.graphicx` | loaded; `\includegraphics` only inside the unused QR macros (cls:178, 182, 192) |
| maths packages | betterposter.cls:57-59 | `math.amsmath`, `math.amssymb` | `amsmath`, `amsfonts`, `amssymb`; no equation in the sample |
| equation alignment | main.tex:2 | `math.eqnumber` | class option `fleqn` |
| poster lengths | betterposter.cls:66-71, 107-112 | `sp.lengths` | `\leftbarwidth`=`\rightbarwidth`=0.2`\paperwidth`; column margins 0.025`\paperheight`; main-column margins 0.07`\paperheight` (constants, inlined) |
| three columns side by side | betterposter.cls:119-131 | `cols.minipage` | `\noindent`, then three `minipage[t][\textheight][t]`: widths `\leftbarwidth`, `\textwidth-\leftbarwidth-\rightbarwidth`, `\rightbarwidth`; contents main.tex:11-44 (left), 5-11 (main), 44-57 (right) |
| column background and text colour | betterposter.cls:134-143 | `box.fancybox`, `color.xcolor` | `\colorbox{bg}{minipage[t][\textheight][t]{\textwidth-0\fboxrule-2\fboxsep}{\leavevmode\color{fg}...}}` (`\colorbox` read as the `\fcolorbox` family) |
| column inner margins | betterposter.cls:146-158 | `box.minipage`, `sp.ragged` | `minipage[c][\textheight][c]{\textwidth}`, `center`, inner `minipage[t][\textheight-2mv][t]{\textwidth-2mh}`, `\fontsizestandard` |
| main-column finding text | main.tex:8-10 | `mark.kernel`, `sp.manual-space` | `\textbf{...}`; forced breaks `\\`; set at the standard size, because the sample does not call `\maincolumn` |
| `\maincolumn` (not used by sample) | betterposter.cls:161-173 | `font.size-commands`, `sp.manual-space`, `box.minipage` | `\vfill`, `\fontsizemain` text, `\vspace{1em}`, `minipage[t][0.25\textheight][b]` |
| `\qrcode`, `\compactqrcode` (not used) | betterposter.cls:176-196 | `fig.graphicx`, `cols.minipage` | minipages 0.30/0.12/0.50 and 0.3`\textwidth` with `\includegraphics` |
| title | main.tex:14; betterposter.cls:208-213 | `font.size-commands`, `mark.kernel`, `sp.manual-space` | `{\fontsize{80}{120}\textbf{\leavevmode T}}\\`, printed where called, in the left column |
| authors | main.tex:15-16; betterposter.cls:216-221 | `color.xcolor`, `font.size-commands`, `sp.manual-space` | `\color{gray}`, `\fontsize{48}{68}`, `\\[-1.0em]`; one block per `\author` call |
| institution | main.tex:17; betterposter.cls:224-230 | `sp.manual-space`, `color.xcolor` | `\vspace{-1em}`, `\color{gray}`, `\\[-1.0em]`; standard size |
| section headings | main.tex:19, 26, 33, 41, 47, 52; betterposter.cls:199-205 | `head.kernel` | `\renewcommand{\section}[1]`: unnumbered, `\vspace{2em}`, `\fontsize{48}{68}`, `\textbf{\leavevmode #1}`, `\\[0.5em]` (a `head.titlesec` form is an equivalent reduction) |
| table | main.tex:34-39 | `tbl.tabular` | `tabular{lcc}`, one `\hline`, no `booktabs` |
| references list | main.tex:52-56 | none needed | plain paragraphs under a section heading; no `thebibliography`, no bibliography way |

Components absent in sample and class: abstract, contents, theorems, captions and floats, footnotes, code, index, cross-references, language and metadata packages.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| whole class `betterposter` (zip-local, not on CTAN) | betterposter.cls:9-230 | yes | `class.article` + `page.geometry` + `font.helvet` + `font.fontenc-t1` + `list.enumitem` + `color.xcolor` + `fig.graphicx` + `math.amsmath`/`math.amssymb`, as listed above |
| `\betterposter`, `\column`, `\centeredpage` with `\dimexpr` widths | betterposter.cls:119-158 | yes | `\newcommand` alias for nested `minipage`, `\colorbox`, `center`; the emitter writes the nested boxes with the same length expressions, or numbers for a0 landscape; no counters, conditionals or box primitives (BESPOKE/class, reducible) |
| `\section`, `\title`, `\author`, `\institution` as printing macros | betterposter.cls:199-230 | yes | body wrappers of font size, `\textbf`, `\color`, `\vspace`, `\\[len]`; no `\@startsection` or `\@maketitle` (BESPOKE/class, reducible) |
| options `a2paper`, `a1paper`, `a0paper` | betterposter.cls:81-104 | yes | a preset of one `\geometry` paper plus five `\fontsize` pairs; the emitter chooses the preset when it writes the file |
| `\newlength` poster lengths, colour-role macros, font-size macros | betterposter.cls:48-51, 66-71, 75-79, 107-112 | yes | named constants; inline their values |
| `\maincolumn`, `\qrcode`, `\compactqrcode` (unused by sample) | betterposter.cls:161-196 | yes | minipages, `\vfill`, `\vspace`, `\includegraphics` with lengths |

Reading notes: (1) `\textwidth` and `\textheight` are used inside the nested minipages (cls:122, 126, 139, 147, 150, 152). Inside a `minipage` these normally keep the page value (`\linewidth` is what changes), so the columns may not size as the author meant; not checked, nothing is compiled, and it does not change reducibility. (2) `\LoadClass{article}` (cls:13) runs before `\ProcessOptions` (cls:104), so `fleqn` is most likely read by article directly; either way it is an article option. (3) The whole document body is the three arguments of `\betterposter` (main.tex:5-57), so a Flouest document model needs a way to assign nodes to the left, main and right column; that is a model matter, not a lib way. (4) No text in the zip is addressed to an AI.

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and not needed: e-TeX `\dimexpr` (a length value inside `sp.lengths` and box width arguments, not a component), `front.class-native` (the class is zip-local, so its front commands count only through the reduction above), `poster.tcbposter` (published, but the class does not use it).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
