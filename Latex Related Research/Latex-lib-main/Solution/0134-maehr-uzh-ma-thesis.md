no

# 0134-maehr-uzh-ma-thesis: University of Zurich Master Thesis Template (maehr/uzh-ma-thesis, R Markdown + pandoc)

- Unverified: read from the source, not compiled.
- Source: Source/0134-maehr-uzh-ma-thesis/ (origin: https://codeload.github.com/maehr/uzh-ma-thesis/zip/refs/heads/master; licence: MIT)
- Kind: thesis
- Lib: v3
- Engine: pdfLaTeX-compatible (the generated ma-thesis.tex branches on `\ifxetex`/`\ifluatex`, ma-thesis.tex:14-23 and 122-128, with a pdfTeX branch; the build config pins XeLaTeX, ma-thesis.Rmd:60 and ma-thesis.Rproj:13)
- Look carried by: preamble (a pandoc template, template/template.tex, plus the generated preamble in ma-thesis.tex; the kernel class `report` is used unchanged)
- Class origin: tex-distribution-unbundled
- Main file: ma-thesis.tex (other samples: ma-thesis.Rmd, the R Markdown source it is generated from; template/template.tex, the pandoc template, which is not LaTeX)
- Read: main yes, zip-local classes and styles none present

## Verdict
`no`. The look itself is plain published LaTeX: kernel `report`, `geometry`, `lmodern`, `xcolor`, `hyperref`, `longtable`, `booktabs`, a hand-laid `titlepage`, three `abstract` environments, and every in-sample component maps to a lib way. But the zip is an R Markdown / pandoc template: template/template.tex is written in pandoc's template language (`$if(...)$`, `$for(...)$`, `$body$`), ma-thesis.tex is its `keep_tex` output, and the citations and the reference list are produced by pandoc's citeproc from a CSL style named by URL. The template therefore does not produce its output without tools outside TeX (EXTERNAL); one small preamble patch is also irreducible.

## Blockers
- `EXTERNAL/preamble` the template of record is a pandoc template, not LaTeX: template-language directives at template/template.tex:4-6, 16-38, 394-396 and the `$body$` slot at template/template.tex:550; it is filled by R/knitr + pandoc from the YAML and body of ma-thesis.Rmd (ma-thesis.Rmd:58-63 `latex_engine: xelatex`, `template: template/template.tex`; README.md:32-41 says to knit in RStudio or with `knit()`)
- `EXTERNAL/body` citations and reference list are formatted outside TeX by pandoc's citeproc from `csl: https://www.zotero.org/styles/infoclio-de` and bibliography/references.yaml (ma-thesis.Rmd:35-36); the sample only holds the result, a literal footnote (ma-thesis.tex:305-307) and a `cslreferences` list (ma-thesis.tex:719-724)
- `EXTERNAL/body` code blocks are coloured token by token by pandoc's highlighter: the token macros are aliases (ma-thesis.tex:65-95, reducible) but the token stream in the blocks (ma-thesis.tex:520-704) is produced by pandoc
- `BESPOKE/preamble` `\patchcmd\longtable{\par}{\if@noskipsec\mbox{}\fi\par}{}{}` edits the internals of a published package with a code argument (W2 fails; ma-thesis.tex:100); it has no visible effect in this sample, which has no `\paragraph` before a table (ma-thesis.tex:97 comment)

## Class setting
- Class: `class.report` options: `12pt`, `nswissgerman` (global language option read by babel/polyglossia), `twoside`, `openright` (ma-thesis.tex:6-10; filled from `fontsize`, `babel-lang`, `classoption` at template/template.tex:16-38 and ma-thesis.Rmd:49,56)
- Class-native vocabulary used: `titlepage` environment (ma-thesis.tex:139), `abstract` environment with `\abstractname` renamed three times (ma-thesis.tex:189-263), `\tableofcontents` `\listoftables` `\listoffigures` (ma-thesis.tex:276-281), `\chapter` `\chapter*` `\section` `\section*` with `\addcontentsline{toc}{chapter|section}` (ma-thesis.tex:289-291, 340-342, 514-518)

## Component map
Drift note: ma-thesis.tex was not generated from the current template/template.tex. It has no `\title` `\author` `\date` (template.tex:394-410 has them) and uses `cslreferences` (ma-thesis.tex:131) where the template defines `CSLReferences` (template/template.tex:376); both are read below.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ma-thesis.tex:6-10 | `class.report` | 12pt, nswissgerman, twoside, openright |
| paper, sides, size | ma-thesis.tex:6-10 | `page.class-options` | twoside, openright, 12pt |
| page geometry | ma-thesis.tex:55 | `page.geometry` | a4paper, bindingoffset=10mm, inner=30mm, outer=30mm, top=30mm, bottom=30mm |
| zero-margin last page | ma-thesis.tex:727 | `page.geometry` | `\newgeometry{margin=0pt}` |
| declaration page (full-page PDF image) | ma-thesis.tex:728 | `fig.graphicx` | width=\paperwidth, height=\paperheight, keepaspectratio; file addendum/selbststaendigkeitserklaerung.pdf |
| forced blank pages | ma-thesis.tex:188,264,284 | `pg.break` | `\clearpage` before and after the blank page |
| blank-page body | ma-thesis.tex:188 | `box.fancybox` | `\mbox{}` (kernel frameless box) |
| blank-page style | ma-thesis.tex:188 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| running heads and feet | not set (ma-thesis.tex:265-266 commented) | `hf.pagestyle-kernel` | report default style |
| page numbers | ma-thesis.tex:270-271, 286-287 | `pgnum.pagenumbering` | roman then arabic, `\setcounter{page}{1}` |
| line spacing | ma-thesis.tex:12, 282 | `sp.setspace` | `\setstretch{1.5}` after the lists (value from ma-thesis.Rmd:50) |
| paragraph spacing | ma-thesis.tex:31-38 | `sp.parskip-pkg` | `parskip` when present |
| paragraph spacing fallback | ma-thesis.tex:35-36 | `sp.lengths` | `\parindent`=0pt, `\parskip`=6pt plus 2pt minus 1pt |
| overfull-line stretch | ma-thesis.tex:118 | `sp.lengths` | `\emergencystretch`=3em |
| protrusion | ma-thesis.tex:26-29 | `sp.microtype` | `\UseMicrotypeSet[protrusion]{basicmath}` |
| body font (pdfTeX branch) | ma-thesis.tex:11 | `font.lmodern` | Latin Modern |
| encodings | ma-thesis.tex:16-18 | `font.fontenc-t1` | fontenc T1, inputenc utf8, textcomp |
| math/text fonts (XeTeX/LuaTeX branch) | ma-thesis.tex:20 | `font.unicode-math` | no `\setmathfont` (mainfont lines commented, ma-thesis.Rmd:51-54) |
| font defaults (XeTeX/LuaTeX branch) | ma-thesis.tex:21-22 | `font.fontspec` | `\defaultfontfeatures{Scale=MatchLowercase}`, `[\rmfamily]{Ligatures=TeX,Scale=1}` |
| title-page type sizes | ma-thesis.tex:146,151,158,161 | `font.size-commands` | `\huge`, `\large`, `\Large`, `\normalsize` |
| colour | ma-thesis.tex:4,40 | `color.xcolor` | options dvipsnames, svgnames*, x11names*; `\definecolor{shadecolor}{RGB}{248,248,248}` (ma-thesis.tex:63) |
| legacy colour | ma-thesis.tex:56 | `color.color` | `color` package for `\textcolor[rgb]` in the token macros |
| language | ma-thesis.tex:127 | `lang.babel` | `shorthands=off`, `main=nswissgerman` (non-XeTeX branch) |
| language (XeTeX branch) | ma-thesis.tex:124-125 | `lang.polyglossia` | `\setmainlanguage[variant=swiss]{german}` |
| PDF metadata and links | ma-thesis.tex:2,43-53 | `meta.hyperref` | unicode; pdftitle, pdfauthor, pdflang=de-CH, pdfkeywords; colorlinks=true, linkcolor=black, filecolor=Maroon, citecolor=black, urlcolor=black; pdfcreator |
| bookmarks | ma-thesis.tex:42 | `meta.bookmark` | loaded when present, else plain hyperref |
| URLs | ma-thesis.tex:3,41,54 | `meta.url` | `hyphens` option, `xurl`, `\urlstyle{same}` |
| title page | ma-thesis.tex:139-186 | `front.titlepage-env` | `titlepage` + `center`; logo (template/uzh_logo_d_pos.pdf) at width=0.4\textwidth (ma-thesis.tex:142); title, subtitle, author, student number, degree text, referees, institute, date |
| title-page centring | ma-thesis.tex:140 | `sp.ragged` | `center` environment |
| title-page spacing | ma-thesis.tex:144,149,156,164,173,179 | `sp.manual-space` | `\vspace*{2.5cm}`, `\vspace{0.5cm}`, `\vspace{1.5cm}` x2, `\vfill`, `\vspace{0.8cm}`, `\\` |
| title-page emphasis | ma-thesis.tex:169 | `mark.kernel` | `\textbf` |
| abstracts (EN, DE) | ma-thesis.tex:189-239 | `abs.kernel` | `\renewcommand{\abstractname}{Abstract}` then `{Zusammenfassung}` |
| keyword lines | ma-thesis.tex:212,238 | `abs.keywords` | `\emph{Keywords: ...}` line inside the abstract (source ma-thesis.Rmd:21,28) |
| acknowledgements | ma-thesis.tex:241-263 | `abs.kernel` | `abstract` environment reused, `\abstractname`=Danksagung (template/template.tex:491-495) |
| contents, list of tables, list of figures | ma-thesis.tex:273-281 | `toc.kernel` | group with `\hypersetup{linkcolor=}` (ma-thesis.tex:274), order TOC, LOT, LOF |
| depths | ma-thesis.tex:121,275 | `num.secnumdepth` | `secnumdepth`=-\maxdimen (numbering off), `tocdepth`=2 |
| chapter and section headings | ma-thesis.tex:289-291, 340-342, 514-518 | `head.kernel` | `\chapter*`, `\section*`, `\chapter`, `\section`, `\addcontentsline{toc}{...}`; no titlesec, report defaults |
| bullet and numbered lists | ma-thesis.tex:408-414, 441-452 | `list.kernel` | `itemize`, `enumerate`, `\def\labelenumi{\arabic{enumi}.}`, `\tightlist` |
| footnotes | ma-thesis.tex:305-307 | `fn.kernel` | `\footnote`; the text is CSL output (EXTERNAL) |
| footnotes inside longtable | ma-thesis.tex:103-104 | `fn.bigfoot` | `footnotehyper` (fallback `footnote`), `\makesavenoteenv{longtable}` |
| figure | ma-thesis.tex:323-327 | `fig.graphicx` | `figure`, `\centering`, `\includegraphics{images/cat.jpg}`; default keys `\setkeys{Gin}{width=\maxwidth,height=\maxheight,keepaspectratio}` (ma-thesis.tex:113) |
| default float placement | ma-thesis.tex:116 | `fig.placement` | `\fps@figure`=htbp (same effect as `\floatplacement{figure}{htbp}` of `fig.float`) |
| captions | ma-thesis.tex:326,479 | `cap.kernel` | kernel `\caption`, no caption package |
| long table | ma-thesis.tex:478-495 | `tbl.longtable` | `longtable[]`, `\endfirsthead`, `\endhead`, caption + `\tabularnewline` |
| table rules | ma-thesis.tex:481-494 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| column spec | ma-thesis.tex:478 | `tbl.tabular` | `@{}lll@{}` |
| code blocks | ma-thesis.tex:57-60, 520-704 | `code.verbatim` | `fancyvrb` `\DefineVerbatimEnvironment{Highlighting}{Verbatim}{commandchars=\\\{\}}`, `\Verb` alias |
| code block shading | ma-thesis.tex:62-64 | `box.mdframed` | `framed` `snugshade` inside `Shaded`, colour shadecolor |
| straight quotes | ma-thesis.tex:25 | `code.upquote` | load-only, when present |
| reference list | ma-thesis.tex:715-724 | `bib.thebibliography` | nearest way only: hand-set entries under `\chapter*{Literaturverzeichnis}` and a `cslreferences` environment; entry format fixed by the CSL style outside TeX (EXTERNAL) |
| link targets | ma-thesis.tex:289-291 | `xref.hyperref` | `\hypertarget{vowort}{%...}` |
| labels | ma-thesis.tex:290 | `xref.kernel` | `\label{vowort}` |
| external links | ma-thesis.tex:710-712 | `xref.hyperref` | `\href{url}{text}` |
| inline emphasis, code | ma-thesis.tex:212,713 | `mark.kernel` | `\emph`, `\texttt` |
| math packages | ma-thesis.tex:13 | `math.amsmath` | load-only, no maths set in the sample body |
| math symbols | ma-thesis.tex:13 | `math.amssymb` | load-only |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\patchcmd\longtable{\par}{\if@noskipsec\mbox{}\fi\par}{}{}` | ma-thesis.tex:98-101 | no | edits a package's internals with a code argument; considered `etoolbox`, rejected as a way (W2 fails); `BESPOKE/preamble` |
| `\maxwidth`, `\maxheight` and the `Gin` defaults | ma-thesis.tex:106-113 | yes | `min(natural size, \linewidth)` is the `max width` / `max height` key of `fig.adjustbox` (`adjustbox` with `Export`), plus `keepaspectratio` of `fig.graphicx` |
| `\def\fps@figure{htbp}` | ma-thesis.tex:115-117 | yes | `fig.float` `\floatplacement{figure}{htbp}` |
| `\providecommand{\tightlist}` | ma-thesis.tex:119-120 | yes | `sp.lengths`: `\itemsep`=0pt, `\parskip`=0pt at the start of a list (or `list.enumitem` `itemsep=0pt,parsep=0pt`) |
| `\VerbBar`, `\VERB` | ma-thesis.tex:58-59 | yes | alias of fancyvrb `\Verb[commandchars=\\\{\}]` (`code.verbatim`) |
| `Shaded` environment | ma-thesis.tex:64 | yes | alias of framed `snugshade` (`box.mdframed`) with shadecolor 248,248,248 |
| 31 `\...Tok` commands | ma-thesis.tex:65-95 | yes | aliases of `\textcolor[rgb]{r,g,b}` / `\textbf` / `\textit` (`color.color`, `mark.kernel`); the token stream itself is EXTERNAL |
| `\newenvironment{cslreferences}{}{\par}`, `\cslhangindent` | ma-thesis.tex:129-133 | yes | empty wrapper, `\par` at the end; `sp.lengths` 1.5em (unused in the sample entries) |
| `\ifnum 0\ifxetex 1\fi\ifluatex 1\fi=0` engine switch, `\IfFileExists` and `\@ifundefined{KOMAClassName}` fallbacks | ma-thesis.tex:15-23, 25-42 | yes | the emitter picks one engine branch and the packages it ships; pandoc boilerplate only |
| title-page and blank-page code in the template body | template/template.tex:427-472, 545 | yes | composition of `front.titlepage-env`, `sp.manual-space`, `font.size-commands`, `pg.break`, `hf.pagestyle-kernel` as in the map |
| template branches the sample does not use: beamer (template/template.tex:26-88, 161-180, 411-421, 513-519), `listings` (246-254), `\DeclareRobustCommand{\href}` links-as-notes (293-296), `ulem` (297-301), bidi/`\beginR` RTL (348-359), natbib and biblatex (361-370, 555-585), `CSLReferences` with `\everypar` hanging indent (371-392) | template/template.tex | not analysed beyond reading | outside the sample; the RTL, links-as-notes and `CSLReferences` code would be bespoke if used |

## Content-opaque
- figure image images/cat.jpg inside the figure (ma-thesis.tex:325); table cell text (ma-thesis.tex:489-493); logo template/uzh_logo_d_pos.pdf (ma-thesis.tex:142) and declaration PDF addendum/selbststaendigkeitserklaerung.pdf (ma-thesis.tex:728) are included images, not drawn artwork, so no `ART`; shipped assets, not read as binaries
- the markdown cheat sheet shown in code blocks (ma-thesis.tex:520-704) and the shipped compiled ma-thesis.pdf (binary, not read)
- Jekyll files for the GitHub page (_config.yml, assets/css/style.scss) are not LaTeX

## Lib changes
- New ways proposed: none (considered: `etoolbox` `\patchcmd`, rejected: fails W2; `adjustbox` and `float` are existing ways `fig.adjustbox` and `fig.float`)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
