yes

# 0019-stylish-article: "Stylish Article" slot, filled by a substitute using the published `lebhart` class

- Unverified: read from the source, not compiled.
- Source: Source/0019-stylish-article/ (origin: https://latextemplates.com/downloads/stylish-article.zip; licence: LPPL-1.3c)
- Kind: misc (a generic colourful article class; the manifest hint "calendar" does not fit, and the zip is not the original SelfArx "Stylish Article": README.md:3-9)
- Lib: v0
- Engine: needs XeLaTeX or LuaLaTeX (the class loads `fontspec` and TeX Gyre fonts: README.md:15-20, main.tex:10-15; CTAN page of lebhart: "compiles with either XeLaTeX or LuaLaTeX")
- Main file: main.tex (other samples: none; the zip holds only main.tex and README.md, and main.tex:11 mentions an engine.txt that is not in the zip)
- Read: main yes (all 98 lines), zip-local classes and styles none present (the class and its dependency are deliberately not bundled: README.md:35-39). Source of `lebhart`, `ProjLib` and `colorist-fancy` was NOT read; only the CTAN pages of `lebhart` and `projlib` were read (2 of 3 allowed reads).

## Verdict
yes. The sample is a published class (`lebhart`, CTAN, LPPL-1.3c, part of the colorist series) loaded unchanged, plus one preamble line of ProjLib vocabulary and standard kernel body constructs. There is no zip-local `.cls`/`.sty`, no artwork, and no external tool. The one zip-local definition is a kernel `\providecommand` string alias that an emitter can print verbatim. The whole look comes from the unread published class, so this `yes` rests on the rubric rule that a published class not bundled is one way (class options are parameters); what the class does inside was not inspected.

## Blockers
none

## Class setting
- Class: `class.lebhart` options: none (`\documentclass{lebhart}`, main.tex:18). Not bundled, ships with TeX Live (README.md:37-39); source not read.
- Class-native vocabulary used: `\UseLanguage{English}` (main.tex:21), `\TheDate{2026-01-15}` (main.tex:32), `keyword` environment (main.tex:43-45, from `colorist-fancy.sty` per README.md:28), native `theorem` environment with optional title (main.tex:62, "native theorem environments and multilingual support" main.tex:7-8), `\Cref` (main.tex:67). ProjLib is named as the class's dependency (README.md:37), so `\usepackage{ProjLib}` at main.tex:19 is probably a redundant second load (inferred, not read).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:18 | `class.lebhart` | no options; page size, margins, colours, header/footer and heading looks are all set by the class and are not claimed individually (class source not read) |
| language | main.tex:19, 21 | `NEW:lang.projlib` | package `ProjLib`; `\UseLanguage{English}` |
| fonts | main.tex:10-15, README.md:17-20 | `font.fontspec` | set by the class, not by the sample: TeX Gyre Pagella (`TeXGyrePagellaX`) main, TeX Gyre Heros sans, via fontspec `.fontspec` configs |
| title block | main.tex:30-32, 35 | `front.maketitle` | `\title{...}`, `\author{Sam Okafor}`, `\date{...}`, `\maketitle`; look supplied by the class |
| title date format | main.tex:32 | `front.class-native` | `\TheDate{2026-01-15}` (ISO date string, class/ProjLib date command) |
| abstract | main.tex:37-42 | `abs.kernel` | `abstract` environment with plain text; look supplied by the class |
| keywords | main.tex:43-45 | `abs.keywords` | class-native `keyword` environment, comma-separated list; heading label string `\keywordname` = "Keywords" (see Bespoke code) |
| headings | main.tex:47, 55, 57, 70, 75, 81, 92 | `head.class-native` | `\section`, `\subsection`, default numbering; looks set by the class (not read) |
| theorem | main.tex:62-65 | `thm.class-native` | `theorem` environment, optional title `[Cache-aside invariant]`, `\label{thm:aside}` |
| label | main.tex:62 | `xref.kernel` | `\label{thm:aside}` |
| cross-reference | main.tex:67 | `xref.cleveref` | `\Cref{thm:aside}`; no `\usepackage{cleveref}` in the sample, so the command comes from the class or ProjLib (inferred, not read) |
| list | main.tex:83-90 | `list.kernel` | `itemize` with three `\item`s, default parameters |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\providecommand{\keywordname}{Keywords}` | main.tex:28 | yes | Kernel `\providecommand` defining one label string, a workaround for a version mismatch between `colorist-fancy.sty` and `projlib-author` (main.tex:23-27, README.md:26-33). The emitter prints the line verbatim in the preamble, before `\begin{keyword}`; it carries no layout logic. It is the `\keywordname` string parameter of `abs.keywords`. |

No zip-local class, style, environment, counter or conditional exists.

## Content-opaque
none

## Lib changes
- New ways proposed: `NEW:lang.projlib` ProjLib package (CTAN `projlib`, LPPL-1.3c, in TeX Live; engine not established: its CTAN page states no engine requirement and its source was not read; here it is used under XeLaTeX/LuaLaTeX, so tag it xe/lua until a pdfLaTeX use is seen), with the command `\UseLanguage{<language name>}` that sets up the document language and its date/keyword names (main.tex:19-21; README.md:28-33 names its `projlib-author` module). W1: published on CTAN with public documentation (CTAN page: "configure multilingual settings"). W2: the language is chosen by a name argument, not by editing code. W3: ProjLib is a toolkit usable with any class, not tied to this document. W4: one preamble line (`\usepackage{ProjLib}`, `\UseLanguage{...}`). Why not `lang.babel`: no evidence ProjLib uses babel for English (unread). It could alternatively be filed as a `lang.class-native` way, which the lib lacks; the consolidator may fold it into whichever fits once a ProjLib-using zip with readable source is analysed.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
