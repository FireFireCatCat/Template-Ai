no

# 0354-uwmslide: uwmslide (UW-Madison slide class)

- Unverified: read from the source, not compiled.
- Source: Source/0354-uwmslide/ (origin: https://mirrors.ctan.org/macros/latex/contrib/uwmslide.zip; licence: Perl Artistic License, README:46-48; ctan.org/pkg/uwmslide agrees)
- Kind: presentation
- Lib: v3
- Engine: pdfLaTeX-compatible in the packages it loads (kernel, epsfig, times); the output is dvips-oriented (see Blockers); pdfTeX behaviour not tested
- Look carried by: class (the whole slide look is in `uwmslide.cls`; the sample adds only `graphicx`, `colordvi` and `\title`/`\author`/`\date`, test.tex:2-6)
- Class origin: ctan
- Main file: test.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (`uwmslide.cls`, 467 lines; `README` read; `logo.eps` and `vaux.eps` are image assets, only their headers were looked at)

## Verdict
`no`, on one ground: the output is made by the latex, dvips, PostScript-to-PDF pipeline. The class writes dvips specials for the landscape rotation (uwmslide.cls:52-53), the sample colours text with `colordvi` (test.tex:3), which CTAN describes as macros for a dvips-compatible DVI driver, and the header logo is EPS (uwmslide.cls:14,70-72). Everything else is fine: the class is on CTAN, so it is the way `class.uwmslide` and its macros are not bespoke under W1, every component maps to a lib way, and there is no ART. Re-read note: if dvips is counted as part of the TeX toolchain, no blocker is left under the published-class reading; if the class were judged zip-local instead, its `\slidedivider` state machine would be `BESPOKE/class` (see Bespoke code).

## Blockers
- `EXTERNAL/class` dvips specials set the landscape orientation and paper (`\special{! /landplus90 true store}`, `\special{landscape}`, uwmslide.cls:52-53); the sample says the output is for dvips and the DVI is "non-representative" (test.tex:35-36, 127-128; README:6-10); logo and figure are EPS (uwmslide.cls:14,71; test.tex:62)
- `EXTERNAL/package` `colordvi` colour commands are dvips colour specials, so the colours exist only in dvips output (test.tex:3, 8, 109-116)

## Class setting
- Class: `class.uwmslide` options: none in the sample (test.tex:1). The class forwards every option to class `slides` (uwmslide.cls:11), which it never loads, then loads `article` (uwmslide.cls:13); so options have no declared effect as read.
- Class-native vocabulary used: environments `slide{title}`, `itemslide{title}`, `doubleslide[leftwidth]{title}`, `leftitem[leftwidth]{title}`, `rightitem[leftwidth]{title}`, `doubleitem[leftwidth]{title}` (uwmslide.cls:277,301,379,413,436,460; test.tex:12-117), the divider `\slidedivider` (uwmslide.cls:325; test.tex:61,69,76,86,103), and a `\maketitle` that makes a title slide (uwmslide.cls:238; test.tex:9). Default left width 4.25in, changed by the optional argument (test.tex:92).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | test.tex:1; uwmslide.cls:9,13 | `class.uwmslide` | no options; `\LoadClass{article}` underneath |
| paper size, orientation | uwmslide.cls:50-53 | `page.setlength` | paperheight=8.5in, paperwidth=11in; rotation by dvips specials (EXTERNAL) |
| text block | uwmslide.cls:54-59 | `page.setlength` | textwidth=9.5in, textheight=6in, hoffset=voffset=-0.25in, oddsidemargin=evensidemargin=0in |
| head and foot geometry | uwmslide.cls:61,66-67 | `page.setlength` | footskip=2bp, headheight=74bp, topmargin=-37bp |
| running head | uwmslide.cls:70-77 | `hf.class-native` | `\@oddhead`/`\@evenhead` = logo + `\hfill` + rule `\textwidth` x 0.4bp; without logo.eps the rule only, with a `\ClassWarning` |
| running foot | uwmslide.cls:79-80 | `hf.class-native` | `\@oddfoot`/`\@evenfoot` = rule 0.4pt, then `\thepage` flush right in `\rm`, same on both sides |
| title-slide foot | uwmslide.cls:228-232 | `hf.class-native` | `titlepage` redefined: foot is the rule only (no number), `\newpage` before and after |
| header logo | uwmslide.cls:14,71-72 | `fig.graphicx` | epsfig `\psfig{file=logo.eps,height=72bp}`; user-replaceable asset, shipped as logo.eps |
| rules | uwmslide.cls:71,75,79 | `sp.rule` | `\rule{\textwidth}{0.4bp}`, `\rule{\textwidth}{0.4pt}`, `\rule{1pt}{0pt}` |
| text font | uwmslide.cls:15 | `font.mathptmx` | package `times` (PS Times; test.tex:33) |
| size scale | uwmslide.cls:90-96,114-185 | `font.size-commands` | normalsize 20.74/28pt; small 17.28/19; tiny 14.4/16; large 24.88/42; Large 28.66/48; LARGE 34.4/52; huge=Huge 41.28/60; footnotesize=scriptsize=small |
| math sizes | uwmslide.cls:107-113 | `font.size-commands` | `\DeclareMathSizes` for 13.82 to 41.28 |
| paragraph and display skips | uwmslide.cls:97-106,114-183 | `sp.lengths` | per size: lineskip 2pt, parskip 30pt plus18 minus9 (normalsize), display skips set by `\@setfontsize@parms` |
| line spread, indent | uwmslide.cls:186-187 | `sp.linespread`, `sp.lengths` | `\baselinestretch` emptied; parindent=0 |
| list spacing | uwmslide.cls:195-217 | `sp.lengths` | level i parsep=.25\parskip, topsep=\parsep, itemsep=\parskip, partopsep=0; level ii parsep=.2\parskip; labelwidth from leftmargin |
| title slide | test.tex:4-9; uwmslide.cls:238-263 | `front.maketitle` | sample uses `\title` `\author` (with `\\`) `\date` `\maketitle` |
| title slide look | uwmslide.cls:238-263 | `front.class-native` | `\null\vfill`, centred title `\Large`, `\vskip 3em`, author in `\large` `tabular[t]{c}`, date `\large`, `\vfill\null` |
| title author block | uwmslide.cls:246-248 | `tbl.tabular` | `tabular[t]{c}` |
| page numbering | uwmslide.cls:255 | `pgnum.pagenumbering` | `\setcounter{page}{1}`, title slide not counted |
| slide page break | uwmslide.cls:278-284 etc. | `pg.break` | `\newpage` at the start of every slide but the first after the title |
| first-slide fix | uwmslide.cls:24-25,280 | `sp.manual-space` | `\vspace*{-1.5in}` (the author's "dirty trick") |
| slide title | uwmslide.cls:285,309,391 | `head.class-native` | `{\Huge \begin{center} #1 \end{center}}` |
| slide environments | uwmslide.cls:277-466; test.tex:28-117 | `class.uwmslide` | class vocabulary, see Class setting |
| bullet lists | test.tex:12-26,44-52; uwmslide.cls:310 | `list.kernel` | `itemize`, nested; label overridden with `\item[$\spadesuit$]` (test.tex:47,112) |
| two-column slides | uwmslide.cls:325-364,392 | `box.minipage` | `minipage[c]{leftwidth}` default 4.25in, right width = 8.5in minus left, `\hfill` between |
| space between halves | uwmslide.cls:336,343 | `sp.manual-space` | `\hfill` |
| display maths | test.tex:58 | `math.kernel` | `\[ ... \]`, `\left` `\right`, `\rm`, `\sqrt` |
| slide image | test.tex:2,62,70,75 | `fig.graphicx` | `\includegraphics[width=4in]{vaux.eps}`, no float, no caption |
| colour | test.tex:3,8,109-116 | `color.color` | `\usepackage{colordvi}`; `\textBlack` switch, `\Red{}`, `\Green{}`, ... wrappers |
| inline marks | test.tex:4,13,102 | `mark.kernel` | `\tt`, `\em` |
| inline verbatim | test.tex:95-98 | `code.verbatim` | `\verb+...+` |
| language, meta, xref, notes, bibliography, index, tables, theorems, code, floats | whole zip | none | the sample uses none (no `\label`, `\footnote`, `table`, `figure`, `thebibliography`) |

## Bespoke code
The class is on CTAN, so under W1 its macros are inside a published class and are not bespoke. The rows below are listed so the result can be re-read if the class were judged zip-local. `test.tex` defines no macro, environment or counter.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\slidedivider` and flag `\@@slidetype` | uwmslide.cls:44-45,325-364,380,414,437,461 | no (would be `BESPOKE/class`) | `\ifcase` state machine that closes and opens `minipage` and `itemize` across unbalanced `\begin`/`\end` pairs and computes the right width with `\m@ne` |
| first-slide flag `\@@slide`, `\@@adjslide` | uwmslide.cls:19-25,261,278-284 | no (would be `BESPOKE/class`) | hand-rolled counter that decides whether to `\newpage` or `\vspace*{-1.5in}`; set in `\maketitle` |
| `\@setfontsize@parms` and size redefinitions | uwmslide.cls:97-106,114-185 | the sizes yes (`font.size-commands`, values in the map); the kernel-internal redefinition (copied from slitex, uwmslide.cls:86-89) no | rewrites a kernel-internal macro that also sets skips |
| `\@oddhead` `\@oddfoot` redefinitions | uwmslide.cls:71-80,229 | yes in principle | `hf.fancyhdr`: head logo + `\hfill` + rule, foot rule + right `\thepage` |
| `titlepage` and `\maketitle` redefinition | uwmslide.cls:228-263 | partly | `front.titlepage-env` + `front.maketitle`; the flag reset at uwmslide.cls:261 is the irreducible part |
| list spacing `\@listi`..`\@listvi` | uwmslide.cls:195-217 | yes | `list.enumitem` or `sp.lengths` with the same lengths |
| item and double-slide environments | uwmslide.cls:277-313,379-466 | yes except through `\slidedivider` | `\newenvironment` over `list.kernel` and `box.minipage` |

## Content-opaque
- `vaux.eps` figure inside the slides (test.tex:62,70,75): an included image, content.
- `logo.eps` (uwmslide.cls:71): a replaceable image asset in the header slot, not drawn by the template (no TikZ or picture code), so not ART. EPS needs a PostScript-aware route (dvips, or EPS-to-PDF conversion under pdfTeX).

## Lib changes
- New ways proposed: `color.color` (`colordvi`, CTAN and the TeX Live `dvips` bundle; pdf-loadable, but the colour effect needs a dvips-compatible driver, so it carries an **EXTERNAL** marker like `fig.svg`). W1: published on CTAN and in TeX Live (ctan.org/pkg/colordvi). W2: the colour is chosen by command name (`\Red{}`, `\textBlack`), no code editing. W3: serves any text-colour component. W4: one `\usepackage{colordvi}` line plus text wrappers. Not `color.color` (that is the LaTeX `color` package with `\color`/`\textcolor`); could be folded into it as "the package is the parameter" if the consolidator prefers.
- Considered, not proposed: `epsfig` (its `\psfig` is the old interface of `\includegraphics`, same family as `fig.graphicx`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
