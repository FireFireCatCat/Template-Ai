yes

# 0653-gerhardt-academic-paper: Gerhardt Academic Paper (article starter, Charter body, Fira Sans headings, Chicago author-date)

- Unverified: read from the source, not compiled.
- Source: Source/0653-gerhardt-academic-paper/ (origin: https://latextemplates.com/downloads/gerhardt-academic-paper.zip; the file header names the upstream repo https://github.com/HolgerGerhardt/TeXTemplates, main.tex:3; licence: 0BSD, main.tex:4-7 and README.md:8-10)
- Kind: journal (a generic academic manuscript starter with no publisher: title, authors, abstract, four sections, author-date bibliography)
- Lib: v5
- Engine: pdfLaTeX-compatible (`inputenc` and `fontenc` at main.tex:26-27, no `fontspec`; README.md:7 says pdflatex; the bibliography needs a `biber` run, the ordinary backend step of `bib.biblatex-biber`)
- Look carried by: preamble (kernel `article` plus published packages and their options; the zip ships no .cls, .sty or .bst, main.tex:24-51)
- Class origin: tex-distribution-unbundled (kernel `article` loaded unchanged, main.tex:24)
- Main file: main.tex (other samples: none; the zip holds three files: README.md, main.tex, references.bib)
- Read: main yes (all 87 lines; README.md and references.bib also read in full), zip-local classes and styles none present

## Verdict
yes. The whole look is one `article` preamble of published packages (`FiraSans`, `FiraMono`, `XCharter`, `mathdesign`, `mweights`, `titlesec`, `abstract`, `authblk`, `biblatex` with the `chicago-authordate` style, `hyperref`), set by option values and three small hooks (two lengths and one font command of the `abstract` package). The only bespoke code is one `\newcommand` alias and those hooks, all reducible. There is no artwork and no tool outside TeX beyond `biber`, which the lib already counts as the ordinary backend of `bib.biblatex-biber`. The sample has no maths, float, list or table, so those components are not exercised.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `10pt` (main.tex:24)
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle`, `abstract` environment (taken over by the `abstract` package), `\section`, `\label`; `\affil` comes from `authblk`, and `\citeauthor` `\citeyear` `\printbibliography` from `biblatex`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:24 | `class.article` | `a4paper`, `10pt` |
| paper and base size | main.tex:24 | `page.class-options` | `a4paper`, `10pt`; no `geometry`, margins are the class defaults |
| input and font encoding | main.tex:26-27 | `font.fontenc-t1` | `inputenc` option `utf8`; `fontenc` option `T1` |
| language | main.tex:28 | `lang.babel` | option `american` |
| monospace face | main.tex:32 | `font.mono` | package `FiraMono`, options `lining`, `scale=0.88` |
| sans face (headings) | main.tex:33 | `font.helvet` | package `FiraSans` (a sans text-face package is the parameter, as the lib line says), options `book`, `semibold`, `lining`, `tabular`, `scale=0.88`, minimum date `[2018/05/23]` |
| maths face | main.tex:34 | `font.charter` | package `mathdesign`, options `charter`, `sfscaled=false`, `ttscaled=false`, `euro=false`; a Charter text-and-maths package, the package being the parameter; no maths in the body, so preamble only; its source was not read |
| serif text face (body) | main.tex:35 | `font.charter` | package `XCharter`, options `scaled=0.96`, `lining`; loaded after `mathdesign`, so it sets the body face (load-order effect on `\sfdefault` not checked, nothing compiled) |
| font weight (series) defaults | main.tex:39 | `font.family-default` | package `mweights`, load-only, no options. CTAN (read once, ctan.org/pkg/mweights: maintainer Bob Tennent, LPPL, in TeX Live) says font packages redefine `\mddefault` or `\bfdefault` and it settles the conflicts; the page does not say how, and the package source is not in the zip. Judgement call: the series counterpart of `\rmdefault`/`\sfdefault`, see Lib changes |
| heading look | main.tex:41 | `head.titlesec` | `\usepackage[sf, bf, raggedright, explicit]{titlesec}`: options only; no `\titleformat` or `\titlespacing` in the file, so headings keep titlesec's defaults with sans family, bold series, ragged-right |
| sectioning commands | main.tex:70, 74, 78, 82 | `head.kernel` | `\section{Introduction}`, `{Method}`, `{Results}`, `{Conclusion}`; numbered, one level |
| abstract | main.tex:42, 65-68 | `abs.abstract-pkg` | `\usepackage[style]{abstract}` (option `style` as written; the package source and option list were not read, the CTAN page lists none), `abstract` environment |
| abstract name font | main.tex:43 | `abs.abstract-pkg` | `\renewcommand{\abstractnamefont}{\small\sffamily\bfseries\upshape}` |
| abstract name font switches | main.tex:43 | `font.size-commands`, `mark.kernel` | `\small`; `\sffamily` `\bfseries` `\upshape` |
| abstract side indents | main.tex:44-45 | `abs.abstract-pkg` | `\setlength{\absleftindent}{\parindent}`, `\setlength{\absrightindent}{\parindent}` (both equal the paragraph indent) |
| title block | main.tex:55, 59, 63 | `front.maketitle` | `\title{\papertitle}`, `\date{\today}`, `\maketitle`; title and date use the class look |
| author and affiliation blocks | main.tex:46, 56-58 | `front.authblk` | option `max6`; two `\author{}` calls (`Ada Lovelace`, `Second Author`) and one unlabelled `\affil{...}` |
| bibliography | main.tex:48-49, 71-72, 85 | `bib.biblatex-biber` | `\usepackage[style=chicago-authordate, backend=biber]{biblatex}` (the style is from `biblatex-chicago`, named at README.md:21-28, not in the zip; CTAN read once: ctan.org/pkg/biblatex-chicago, LPPL 1.3, in TeX Live, implements Chicago author-date); `\addbibresource{references.bib}`; `\citeauthor{knuth1984texbook}` and `\citeyear{knuth1984texbook}` in text; `\printbibliography` at the end |
| links and PDF colours | main.tex:51 | `meta.hyperref` | `colorlinks=true`, `linkcolor=black`, `citecolor=black`, `urlcolor=black` (colour names are values of hyperref, no separate colour way) |
| cross-references | main.tex:75, 79 | `xref.kernel` | `\label{sec:method}`, `\label{sec:results}`; no `\ref` is called in the body |

Components the sample does not define or use: headers and footers (class default `plain`), contents list, lists, quotes, notes, maths, theorems, floats, tables, captions, code, boxes, index, appendices.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\papertitle}{Your Title Here}` | main.tex:53, used at main.tex:55 | yes | alias; expand inline to `\title{Your Title Here}` (`front.maketitle`) |
| `\renewcommand{\abstractnamefont}{...}` | main.tex:43 | yes | the font hook of the published `abstract` package (`abs.abstract-pkg`); the body is `\small` (`font.size-commands`) and `\sffamily\bfseries\upshape` (`mark.kernel`) |
| `\setlength{\absleftindent}{\parindent}` and `\absrightindent` | main.tex:44-45 | yes | two length parameters of `abs.abstract-pkg`; `\parindent` is the class value, so an emitter may write the reference or the length |

No zip-local `.cls`, `.sty`, `.bst`, `.cfg`, no `\def`, counters or conditionals. The upstream `\DeclareSourcemap` passes and the vendored `mweights` fork are named in comments (main.tex:20-23, 36-38) but are not in the zip, so they are not in scope.

## Content-opaque
none (no figure or table in the sample; references.bib:1-6 is one `@book` entry, bibliographic data and so content)

## Lib changes
- New ways proposed: none. Judgement calls, no new way: `mweights` under `font.family-default` (a load-only package for the `\mddefault`/`\bfdefault` defaults, the series counterpart of the `\rmdefault`/`\sfdefault` that line holds; `font.family-default` was considered and not proposed because the existing line holds this type of effect, with the package as the parameter); `mathdesign` with option `charter` under `font.charter`; `FiraSans` under `font.helvet`; `FiraMono` under `font.mono`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
