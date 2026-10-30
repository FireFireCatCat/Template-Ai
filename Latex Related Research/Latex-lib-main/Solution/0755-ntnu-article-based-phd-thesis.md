no

# 0755-ntnu-article-based-phd-thesis: NTNU Article-Based PhD Thesis

- Unverified: read from the source, not compiled.
- Source: Source/0755-ntnu-article-based-phd-thesis/ (origin: https://latextemplates.com/downloads/ntnu-article-thesis.zip; README.md:8 names the upstream https://github.com/frodal/PhD-thesis-Latex-template by Bjørn Håkon Frodal; licence: MIT, LICENSE:1)
- Kind: thesis (article-based PhD thesis: synopsis chapters, then the full papers via `\includepdf`)
- Lib: v6
- Engine: pdfLaTeX-compatible (`newtxtext`, `helvet`, biblatex with `backend=bibtex`, no `fontspec`: style/MyPhDThesis.sty:11,39,151; README.md:11,17)
- Look carried by: zip-local (the zip-local style `style/MyPhDThesis.sty` sets fonts, margins, title page, headings, part pages and bibliography; `memoir` supplies the book structure and the default toc and page styles)
- Class origin: tex-distribution-unbundled (`memoir`, not in the zip; the class source was not read)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (`style/MyPhDThesis.sty`, 322 lines; every `tex/*.tex`, `articles/Part*.tex` and `Appendix/Appendix1.tex` read; `style/References.bib` has 3 entries, content, not read in full)

## Verdict
`no`, on one construct. `\tocless` (style/MyPhDThesis.sty:320-322) rebinds the kernel `\addcontentsline` to a no-op inside a group and then writes a raw `\contentsline` entry by hand. No lib way expresses "suppress a kernel command", because that is editing code, not setting a parameter (W2). I cannot show that memoir's own contents settings (`\cftpart*`, tocloft style) give the same single "Part N" line with no page number, so I cannot show a reduction. Everything else maps to lib ways or reduces by inline expansion: the preamble is mostly published packages, and the title page, part banner, date printer, margin flip and `\clearpage` group reduce (see "Bespoke code"). If a reviewer accepts an emitter that copies the two kernel lines of `\tocless` as a body wrapper, the verdict would flip to `yes`; I did not take that route because the rubric says to answer `no` when a reduction cannot be shown.

## Blockers
- `BESPOKE/preamble` `\tocless` and `\nocontentsline`: `\bgroup\let\addcontentsline=\nocontentsline#1{#2}\egroup` followed by a hand-written `\addtocontents{toc}{\protect\contentsline{part}{Part \protect\numberline{\thepart}}{}{part.\thepart}}`; it suppresses the standard part entry and writes a custom "Part N" line with an empty page field (style/MyPhDThesis.sty:320-322; used at articles/Part1.tex:4 and articles/Part2.tex:4)

## Class setting
- Class: `class.memoir` options: `b5paper,10pt,twoside,openright` (main.tex:1)
- Class-native vocabulary used: `\frontmatter` `\mainmatter` (main.tex:26,59), `titlingpage` environment (style/MyPhDThesis.sty:68), `Spacing` environment (style/MyPhDThesis.sty:82, memoir's capitalised setspace form), `\setsecnumdepth` `\maxsecnumdepth` (style/MyPhDThesis.sty:262-263), starred `\tableofcontents*` (main.tex:54), `\appendixpage` (main.tex:104; the `appendix` package is also loaded), `\chapter*`, `\part`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:1 | `class.memoir` | b5paper, 10pt, twoside, openright |
| paper and size | main.tex:1 | `page.class-options` | b5paper, 10pt, twoside |
| page geometry | style/MyPhDThesis.sty:15 | `page.geometry` | left=1.6cm, right=2.5cm, top=2.5cm, bottom=2.5cm |
| title-page geometry | style/MyPhDThesis.sty:70,119 | `page.geometry` | `\newgeometry{left=4.2cm,right=4.2cm}` ... `\restoregeometry` |
| margin flip | style/MyPhDThesis.sty:254-257 | `page.geometry`, `note.marginpar` | odd/even side margins swapped, i.e. inner and outer values exchanged; `\reversemarginpar` (no margin notes in the sample) |
| main text font | style/MyPhDThesis.sty:11-12 | `font.newtx` | `newtxtext` + `newtxmath`, no options |
| sans font | style/MyPhDThesis.sty:39 | `font.helvet` | `helvet` (sans = Helvetica) |
| text symbols | style/MyPhDThesis.sty:25 | `font.fontenc-t1` | `textcomp` (no `fontenc` loaded) |
| symbol glyphs (load only) | style/MyPhDThesis.sty:8 | `font.icons` | `pifont`, no call in the sample |
| sans family on title page | style/MyPhDThesis.sty:69 | `font.nfss` | `\fontfamily{\sfdefault}\selectfont` |
| font sizes | style/MyPhDThesis.sty:75,78,83,99,317; articles/Part1.tex:14 | `font.size-commands` | `\LARGE` `\Huge` `\large` `\scriptsize`, `\fontsize{36pt}{100pt}`, `\fontsize{20pt}{30pt}` |
| micro-typography | style/MyPhDThesis.sty:21 | `sp.microtype` | defaults |
| paragraph spacing | style/MyPhDThesis.sty:6,270-271 | `sp.parskip-pkg`, `sp.lengths` | `parskip` loaded, then `\parindent`=0pt, `\parskip`=1em |
| line spread | style/MyPhDThesis.sty:269 | `sp.linespread` | `\baselinestretch`=1.1 |
| length arithmetic | style/MyPhDThesis.sty:9,16,315 | `sp.lengths` | `calc` (loaded twice) |
| float separations | style/MyPhDThesis.sty:272-274 | `fig.placement` | `\floatsep` `\textfloatsep` `\intextsep` = 10pt plus 1pt minus 1pt (no float in the sample) |
| setspace | style/MyPhDThesis.sty:22,82 | `sp.setspace` | `Spacing` environment, factor 1.0 (memoir's form) |
| manual spacing | style/MyPhDThesis.sty:73,80,92,96-97; articles/Part1.tex:7,12,16,22; tex/preface.tex:15 | `sp.manual-space` | `\vspace{.3\textwidth}`, `\vfill`, `\vspace{-.10\textheight}`, `\vspace{1cm}`, `\vspace{\fill}`, `\\` |
| colour | style/MyPhDThesis.sty:17,75,317 | `color.xcolor` | `\color{gray}` for the author line; `black` and `white` for the part box; `\PassOptionsToPackage{cmyk}` at :18 comes after the load and has no effect |
| title block | main.tex:9-13,27; style/MyPhDThesis.sty:67-121 | `front.maketitle`, `front.titlepage-env`, `front.class-native` | `\title` `\author` `\date` then `\maketitle` redefined as a hand-laid `titlingpage` page and a colophon page (see Bespoke code) |
| title-page fields | main.tex:11-12,14-18 | `front.class-native` | strings `\city` `\country` `\faculty` `\department` `\ISBNprinted` `\ISBNelectronic` `\serialNumber` (zip-local, see Bespoke code) |
| title/author after `\maketitle` | style/MyPhDThesis.sty:38,124,126 | `front.titling` | `authoraftertitle` (CTAN, M. Bilger, CC0; ctan.org/pkg/authoraftertitle read); only `\MyAuthor` `\MyDate` are used; same function as `\theauthor` `\thedate`, so inline strings also work |
| date format | style/MyPhDThesis.sty:64-66 | `front.datetime` | month name and year, via `\newdateformat` (see Bespoke code) |
| front-matter pages | tex/preface.tex:1; tex/abstract.tex:1; tex/acknowledgements.tex:1 | `front.dedication` | one `\chapter*` page each (abstract is a starred chapter, not the `abstract` environment) |
| preface signature | tex/preface.tex:16; style/MyPhDThesis.sty:122-128 | `sp.ragged` | `flushright` environment with author, city and country, date |
| front/main matter | main.tex:26,59 | `front.class-native` | `\frontmatter`, `\mainmatter` |
| page style | main.tex:31; style/MyPhDThesis.sty:71,319 | `hf.pagestyle-kernel` | `\pagestyle{plain}`; `\pagestyle{empty}` and `\thispagestyle{empty}` on title and part pages |
| page numbering | main.tex:32 | `pgnum.pagenumbering` | `roman` for front matter |
| page breaks | main.tex:38,44,50,55,80,85; style/MyPhDThesis.sty:95 | `pg.break` | `\cleardoublepage`, `\newpage` |
| contents list | main.tex:54 | `toc.kernel` | `\tableofcontents*` |
| manual toc entries | main.tex:37,43,49,69,89,91,96 | `toc.kernel` | `\addcontentsline{toc}{chapter,part,section}{...}` |
| custom part toc line | style/MyPhDThesis.sty:320-322 | `toc.kernel` (blocked) | see Blockers |
| depth counters | style/MyPhDThesis.sty:262-264 | `num.secnumdepth` | `\setsecnumdepth{subsubsection}`, `\maxsecnumdepth{subsubsection}`, `tocdepth`=2 |
| chapter headings | style/MyPhDThesis.sty:193-194 | `head.titlesec` | `\titleformat{\chapter}[hang]{\huge\bfseries}{\thechapter \hspace{20pt}}{0pt}{\huge\bfseries}`, `\titlespacing*{\chapter}{0pt}{0pt}{25pt}` |
| section spacing | style/MyPhDThesis.sty:275-277 | `head.titlesec` | `\titlespacing` for section, subsection, subsubsection: 16pt plus 2pt minus 1pt before, 4pt plus 1pt minus 1pt after |
| part heading | style/MyPhDThesis.sty:316-317 | `head.titlesec`, `box.fancybox`, `font.size-commands`, `mark.kernel` | `\titleclass{\part}{top}`; `\titleformat{\part}[display]` with a black `\colorbox` holding white `\textsc{Part} \thepart` at 36pt, label sep `.1\textheight`, title `\raggedright` 20pt bold |
| part number | style/MyPhDThesis.sty:313 | `num.counters` | `\renewcommand{\thepart}{\arabic{part}}` |
| part page content | articles/Part1.tex:5-23; articles/Part2.tex:5-24 | `box.minipage`, `sp.ragged`, `mark.kernel` | `flushleft`, `minipage{\linewidth}`, `\Large\textbf` |
| headings in body | tex/Introduction.tex:1; tex/Objectives.tex:1,4,20; tex/Summary.tex:4,9; main.tex:67 | `head.kernel` | `\chapter`, `\chapter*`, `\section` |
| heading group hack | main.tex:63-75 | `head.titlesec`, `pg.break` | see Bespoke code |
| appendix | style/MyPhDThesis.sty:175; main.tex:103-105; Appendix/Appendix1.tex:1 | `num.appendix` | `\appendix`, `\appendixpage`, `appendix` package |
| lists | tex/Objectives.tex:9; tex/Summary.tex:5,10 | `list.kernel` | `enumerate`; `itemize` with `\item[{[1]}]` |
| list package (load only) | style/MyPhDThesis.sty:13 | `list.enumitem` | no keys used |
| inline marks | style/MyPhDThesis.sty:23-24 | `mark.ulem`, `mark.nth` | `soul`; `nth` with `super`; no call in the sample |
| maths packages | style/MyPhDThesis.sty:7,10 | `math.amsmath`, `math.amssymb`, `math.bm` | `amsmath,amssymb,amstext`; `bm` |
| figures and captions (load only) | style/MyPhDThesis.sty:5,27-28,33 | `fig.graphicx`, `cap.caption`, `fig.subcaption` | `caption` and `subcaption` with `font=small,labelfont=bf`; `\graphicspath` |
| logo on title page | style/MyPhDThesis.sty:93 | `fig.graphicx` | `\includegraphics[scale=0.7]{Figures/ntnu_logo.pdf}` |
| bibliography | style/MyPhDThesis.sty:134-151,170; main.tex:84 | `bib.biblatex-bibtex` | `refsegment=chapter, style=authoryear-comp, sortcites=false, maxcitenames=2, maxbibnames=99, uniquename=init, giveninits=true, maxalphanames=1, doi=false, url=false, isbn=false, natbib=true, dashed=false, backend=bibtex`; `\addbibresource`; `\printbibliography[title=References, heading=bibliography]` |
| bibliography tweaks | style/MyPhDThesis.sty:154,156-157 | `bib.biblatex-bibtex` | `\renewbibmacro{in:}{}`, `\DeclareNameAlias{sortname}{family-given}`, `\DeclareNameAlias{default}{family-given}` |
| citations | tex/Introduction.tex:7,11 | `bib.biblatex-bibtex` | `\citep` through `natbib=true` |
| quotation marks | style/MyPhDThesis.sty:133 | `lang.csquotes` | `csquotes`, loaded for biblatex |
| links | style/MyPhDThesis.sty:152 | `meta.hyperref` | `hidelinks`, loaded after biblatex |
| labels | tex/Introduction.tex:2; articles/Part1.tex:4 | `xref.kernel` | `\label` |
| include papers | style/MyPhDThesis.sty:3; main.tex:93,98 | `pg.include-pdf` | `\includepdf[pages=-]{...}` |
| file inclusion | main.tex:36,42,48,74,76-79,90,95,105 | `struct.input` | `\input{./tex/...}` |
| dummy text (load only) | style/MyPhDThesis.sty:14 | `draft.todo` | `lipsum`, no call in the sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\faculty` `\department` `\city` `\country` `\ISBNprinted` `\ISBNelectronic` `\serialNumber` and their defaults | style/MyPhDThesis.sty:40-63 | Yes | `\gdef` string storage; the emitter writes the strings straight into the title-page body (values at main.tex:11-12,14-18) |
| defaults `\@title` `\@author` `\@date` | style/MyPhDThesis.sty:52-54 | Yes | overwritten by `\title` `\author` `\date` at main.tex:9-13; drop |
| `\printdate` | style/MyPhDThesis.sty:64-66 | Yes | `\ifcase\month` month names then `\number\year`: `front.datetime` `\newdateformat{printdate}{\monthname[\THEMONTH] \THEYEAR}` printed with `\printdate\today` |
| `\renewcommand*{\maketitle}` | style/MyPhDThesis.sty:67-121 | Yes | body `titlingpage` environment with the same kernel lines written inline: `front.titlepage-env`, `page.geometry` (`\newgeometry` `\restoregeometry`), `font.nfss`, `font.size-commands`, `color.xcolor`, `sp.setspace` (`Spacing`), `sp.manual-space`, `fig.graphicx`, `pg.break`; field macros replaced by their strings |
| `\prefaceSignature` | style/MyPhDThesis.sty:122-128 | Yes | `flushright` with author, city, country, date written inline (`sp.ragged`) |
| margin flip | style/MyPhDThesis.sty:254-257 | Yes, with a caveat | a `\let` swap of `\oddsidemargin` and `\evensidemargin` after geometry has loaded, so the effect is inner and outer margins exchanged: `page.geometry` with `inner=2.5cm,outer=1.6cm`. Whether the swap survives `\restoregeometry` (style/MyPhDThesis.sty:119) cannot be told by reading; either outcome is a `page.geometry` value pair, so the reduction holds |
| `\mylength` | style/MyPhDThesis.sty:314-315 | Yes | `\newlength` and `\setlength{\mylength}{\paperwidth-\oddsidemargin-1in+1pt-\textwidth}` with `calc`: `sp.lengths`; it is the right-margin width plus 1pt, used to push the part box to the paper edge |
| part banner | style/MyPhDThesis.sty:316-317 | Yes (judgement call) | `\colorbox{black}{\makebox(150,40){...}}` is a coloured box built from kernel box commands; the `(150,40)` form is the picture-syntax size of `\makebox` used outside any `picture` environment, so nothing is drawn; reduces to `box.fancybox` with colour black, 150pt by 40pt, white 36pt text, inside a `head.titlesec` `\titleformat{\part}[display]`. Not `art.pstricks` and not `ART` |
| `\parttext` | style/MyPhDThesis.sty:319 | Yes | prefix `\thispagestyle{empty}`; inline (`hf.pagestyle-kernel`) |
| `\nocontentsline` and `\tocless` | style/MyPhDThesis.sty:320-322 | No (cannot be shown) | rebinds a kernel command in a group and writes a raw toc line; no lib way suppresses a kernel command, and memoir's `\cftpart*` settings are not shown to give the same line (no page number, "Part " text) |
| group around Synopsis and Introduction | main.tex:63-75 | Yes, probably | group-local `\renewcommand{\cleardoublepage}{}` and `\renewcommand{\clearpage}{}` (main.tex:64-65) plus `\titlespacing*` changes (main.tex:66,73) so that `Synopsis` (`\chapter*`, main.tex:67) and the Introduction chapter share a page. Closest lib route: `head.titlesec` `\titleclass{\chapter}{straight}` around those two headings and `\titlespacing*{\chapter}{0pt}{0pt}{0pt}`; exact equivalence with the `titlesec` top class on memoir was not checked |

## Content-opaque
- `Figures/ntnu_logo.pdf`, the NTNU logo image on the title page (style/MyPhDThesis.sty:93); shipped asset
- `articles/Paper1.pdf` and `articles/Paper2.pdf`, the full papers included by `\includepdf` (main.tex:93,98); shipped assets (README.md:20-25 says they are short sample papers)
- `style/References.bib`, 3 entries (style/References.bib:1,11,21)
- Risk not decided here: memoir's documentation treats `titlesec` as not supported alongside memoir; the zip loads both (style/MyPhDThesis.sty:20, main.tex:1) and I did not check how they interact

## Lib changes
- New ways proposed: none. Considered: `authoraftertitle` (CTAN, M. Bilger, CC0; ctan.org/pkg/authoraftertitle read), a load-only package that keeps `\MyAuthor` `\MyDate` after `\maketitle`; it has a home in `front.titling` (same function as `\theauthor` `\thedate`) and inline strings, so no new way.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
