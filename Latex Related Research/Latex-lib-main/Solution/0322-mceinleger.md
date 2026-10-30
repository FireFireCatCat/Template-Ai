yes

# 0322-mceinleger: mceinleger (cassette covers and inserts)

- Unverified: read from the source, not compiled.
- Source: Source/0322-mceinleger/ (origin: https://mirrors.ctan.org/macros/latex/contrib/mceinleger.zip; licence: gpl per manifest and ctan.org/pkg/mceinleger; the file header at mceinleger.sty:3-8 carries its own copyright and no-modified-redistribution notice, so the terms are mixed)
- Kind: misc (documentation of a package that prints music-cassette covers and inserts; closest lib family is `label.*`)
- Lib: v3
- Engine: pdfLaTeX-compatible (`inputenc` latin1, kernel `picture`, `rotating`; nothing needs XeLaTeX or LuaLaTeX)
- Look carried by: mixed (the sample's own look is the `article` class defaults plus two preamble lines, main.tex:10-12; the template proper is the published package `mceinleger.sty`, which the sample does not load, main.tex:11-12)
- Class origin: tex-distribution-unbundled (`article` is the kernel class and is not in the zip; the style file in the zip is the CTAN package itself, ctan.org/pkg/mceinleger, in TeX Live and MiKTeX)
- Main file: mceinleger.tex (other samples: none; mceinleger.pdf is the shipped manual, binary, not opened)
- Read: main yes, zip-local classes and styles all (one file, mceinleger.sty, 36 lines)

## Verdict
Yes. The sample is a plain `article` documentation page (title, contents, sections, a `description` list, four small `picture` diagrams) and every part of it maps to a lib way. The package `mceinleger.sty` is on CTAN (ctan.org/pkg/mceinleger, one read), so it is not bespoke; it is proposed as one way, `label.mceinleger`, which passes W1 to W4: its only inputs are four or six strings and a position-letter list, and all sizes are fixed inside the package, as with `cal.kalender`. The four picture diagrams in the sample body are illustrations of the panel layout, recorded as content-opaque and not as template artwork. This is a judgement: a reviewer who reads them as template-defining would turn the verdict to `ART/body`.

## Blockers
none

## Class setting
- Class: `class.article` options: `12pt`, `a4paper` (mceinleger.tex:10)
- Class-native vocabulary used: `\title` `\author` `\maketitle` (mceinleger.tex:17-19), `\tableofcontents` (:21), `\section` `\subsection` (:23, :66), `description` (:79). No `abstract`, no bibliography, no `\date` (so `\maketitle` prints the default date).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | mceinleger.tex:10 | `class.article` | 12pt, a4paper |
| paper and base size | mceinleger.tex:10 | `page.class-options` | a4paper, 12pt |
| input encoding | mceinleger.tex:11 | `font.fontenc-t1` | `inputenc` with `latin1`; no `fontenc` loaded (the source file is ISO-8859, `file` says so) |
| language | mceinleger.tex:12, :27, :30 | `lang.babel` | `ngerman` support package, then `\glqq` German quote command. I did not confirm on CTAN that `ngerman.sty` ships in the `german` bundle (ctan.org/pkg/german does not mention it); mapped to babel as sibling zip 0025 did |
| title block | mceinleger.tex:17-19 | `front.maketitle` | `\title{Musikkassetten--Einleger}`, `\author{Florian Benischke}`, `\date` left out |
| contents | mceinleger.tex:21 | `toc.kernel` | `\tableofcontents`, default depth |
| headings | mceinleger.tex:23, :41, :66, :93, :108, :135, :161 | `head.kernel` | `\section`, `\subsection`, default format and numbering |
| page breaks | mceinleger.tex:39, :64, :133 | `pg.break` | `\clearpage` |
| forced line break with space | mceinleger.tex:33, :111 | `sp.manual-space` | `\\*[2ex]` |
| paragraph indent off | mceinleger.tex:53, :68, :90, :95 | `sp.lengths` | `\noindent`. Judgement: the lib has no line for it; I read it as the per-paragraph switch of `\parindent` |
| size switches | mceinleger.tex:35 | `font.size-commands` | `\huge`, `\normalsize` |
| emphasis marks | mceinleger.tex:35-37, :43, :68-70 | `mark.kernel` | `\textbf`, `\emph`, `\texttt` |
| description list | mceinleger.tex:79-88, :148-157 | `list.kernel` | `description` with `\item[t]` ... `\item[r]` labels (six items each) |
| inline maths used as text glyphs | mceinleger.tex:68-70, :95-97, :137-139, :163-165 | `math.kernel` | `$\backslash$`, `$\{$`, `$\}$` in text |
| layout diagrams in the body | mceinleger.tex:21, :47-51, :57-62, :117-121, :126-131 | `art.pstricks` | kernel `picture` (15.0,15.0), `\put`, `\framebox`; `\unitlength` set to 0.5cm at :21. Content-opaque, see below |
| cassette cover, 3 panels | mceinleger.sty:18-24 | `label.mceinleger` | body `\huelle{back}{spine}{front}{pos}`; the first two arguments are text turned 270 degrees, the third text in a centred 6.4cm `parbox`, the fourth a `\framebox` position list (`t b c s l r`, listed in the sample at mceinleger.tex:76-88); panel sizes 2.5, 1.3 and 6.4 by 10.2 are fixed |
| cassette insert, 4 panels | mceinleger.sty:26-33 | `label.mceinleger` | body `\einleger{back}{spine}{front}{pos}{flap}{flap-pos}`; adds a fourth 6.4 by 10.2 panel at x=11.2 (:31) |
| unit length of the package | mceinleger.sty:17 | `label.mceinleger` | `\unitlength` set to 1.0cm at load time; inside the way, an emitter does not write it |
| needs `rotating` | mceinleger.sty:9, :20-21, :28-29; mceinleger.tex:35-37 | `fig.rotating` | `\usepackage{rotating}` must be written before `\usepackage{mceinleger}`; the style does not load it (no `\RequirePackage`, grep) and uses `turn` with angle 270 |
| package loading | mceinleger.sty:13-15 | `label.mceinleger` | `\usepackage{mceinleger}`, no options (`\ProvidesPackage`, `\NeedsTeXFormat`) |

Not defined or used by the zip: header/footer (article default), abstract, bibliography, index, floats, tables, captions, code, theorems, notes, colour, fonts beyond the defaults.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\huelle` (4 arguments) | mceinleger.sty:18-24 | not bespoke | part of the published CTAN package; it is the way `label.mceinleger`, not zip-local code |
| `\einleger` (6 arguments) | mceinleger.sty:26-33 | not bespoke | same |
| `\RInfo` version string | mceinleger.sty:11 | not bespoke | package metadata only, no effect on output |
| macros in the sample | mceinleger.tex | none defined | the sample has no `\newcommand`, `\def`, environment or counter (grep) |

Observed defects in the shipped files (read only, no effect on the verdict): mceinleger.tex:139 documents `\huelle` with six arguments A to F, but mceinleger.sty:18 takes four; mceinleger.tex:165 names `\huelle` in the `einleger` section while mceinleger.sty:26 defines `\einleger`; the German diagram at mceinleger.tex:48 draws a 3.5 wide first panel while mceinleger.sty:20 uses 2.5; the fourth panel in mceinleger.sty:31 ends at x = 11.2 + 6.4 = 17.6, beyond the 15.0 wide picture opened at :27. The sample never calls `\huelle` or `\einleger`; it only prints their names as text (mceinleger.tex:68-70, :95-97).

## Content-opaque
- Four free-standing `picture` diagrams of the panel layout: mceinleger.tex:47-51, :57-62, :117-121, :126-131 (not in a float, but they only illustrate the layout the text describes; the article look does not depend on them). Judgement, see the verdict.

## Lib changes
- New ways proposed: `label.mceinleger` `mceinleger` (CTAN `macros/latex/contrib/mceinleger`, TeX Live, pdfLaTeX, needs `rotating`): `\usepackage{mceinleger}` and body `\huelle{back}{spine}{front}{pos}` or `\einleger{back}{spine}{front}{pos}{flap}{flap-pos}`, a music-cassette cover or insert of framed panels with rotated side text. W1: on CTAN and in TeX Live (ctan.org/pkg/mceinleger). W2: the arguments are strings and a `\framebox` position list; the sizes are fixed in the package, as `cal.kalender` fixes its grid. W3: serves a kind of component (cassette covers and inserts), not one document. W4: one preamble line and one body command per cover. Considered and not used: reading `\huelle` as bespoke `picture` code (`art.pstricks` plus `fig.rotating` plus `box.minipage`), rejected because the package is published, which is also why this file has no `ART` blocker.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
