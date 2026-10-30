yes

# 0162-biblatex-chem: biblatex-chem (chemistry bibliography styles for biblatex, with its manual)

- Unverified: read from the source, not compiled.
- Source: Source/0162-biblatex-chem/ (origin: https://mirrors.ctan.org/macros/latex/contrib/biblatex-contrib/biblatex-chem.zip; licence: LPPL 1.3c)
- Kind: misc (a package manual in `ltxdoc`; the package itself is four journal-style bibliography styles, so the manifest hint "journal" is only the package's subject)
- Lib: v3
- Engine: pdfLaTeX-compatible (biblatex needs a backend pass: biber for the related-entry feature, bibtex also supported by the styles)
- Look carried by: mixed (the manual's page look is the published `ltxdoc` class plus five published packages in the preamble; the bibliography look is the package's own published `.bbx`/`.cbx` styles, selected by name)
- Class origin: tex-distribution-unbundled (`ltxdoc`, LaTeX base, not in the zip; the eight `.bbx`/`.cbx` files are CTAN and TeX Live `biblatex-chem`, confirmed by one read of ctan.org/pkg/biblatex-chem)
- Main file: biblatex-chem.tex (other samples: biblatex-chem-acs.tex, biblatex-chem-angew.tex, biblatex-chem-biochem.tex, biblatex-chem-rsc.tex, which are not self-contained, see Verdict)
- Read: main yes, zip-local classes and styles all (no zip-local `.cls`/`.sty`; all four `.bbx` and all four `.cbx` read; `biblatex-chem.bib` skimmed as content; the `.pdf` files were not read)

## Verdict
Yes. The main sample is a `ltxdoc` driver whose whole preamble is `\documentclass[a4paper]{ltxdoc}` and five published packages, and its body is `\maketitle`, an abstract, lists, sections, `\DescribeEnv` aliases and a `\changes` history, all of which have lib ways (`class.ltxdoc`, `dtx.doc`). The package itself is published (CTAN `biblatex-contrib`, TeX Live), so its four styles are one existing way, `bib.biblatex-biber`, with the style name as the parameter; the macro code inside the `.bbx`/`.cbx` is the package's own internals and is not copied by an emitter. Not shown: the four demo drivers end in `\input{biblatex-chem-common.tex}`, a file that is not in the zip (biblatex-chem-acs.tex:20), so the demo documents' own preamble is unread; they hold only a style name and a description paragraph, so they are not counted as samples.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: `a4paper` (biblatex-chem.tex:11)
- Class-native vocabulary used: `\RecordChanges` (:32), `\changes{version}{date}{text}` (:175-235), `\PrintChanges` (:237), `\DescribeEnv` (aliased to `\DescribeOption`, :30, used at :103-106, :115, :121, :128, :135, :141), `\cs{...}` (:216), plus the article-style `\maketitle`, `abstract`, `\section`. The change history needs the usual makeindex pass with `gglo.ist`, a standard TeX Live tool of the same kind as the index and bibliography passes the lib already counts.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | biblatex-chem.tex:11 | `class.ltxdoc` | `a4paper` |
| paper size | biblatex-chem.tex:11 | `page.class-options` | `a4paper` |
| quotation markup | biblatex-chem.tex:12, :129, :176 | `lang.csquotes` | `\usepackage{csquotes}`, no options; `\enquote{}` in text |
| text font | biblatex-chem.tex:12 | `font.lmodern` | `\usepackage{lmodern}` |
| encoding | biblatex-chem.tex:13 | `font.fontenc-t1` | `[T1]{fontenc}` |
| micro-typography | biblatex-chem.tex:14 | `sp.microtype` | `[final]` |
| links and PDF options | biblatex-chem.tex:15, :17 | `meta.hyperref` | `\usepackage{hyperref}`, `\hypersetup{hidelinks}` |
| `\href` / `\url` links | biblatex-chem.tex:20, :72-80, :170-172 | `meta.hyperref` | `\href{mailto:...}{...}`, `\href{file:...}{...}`, `\url{...}` (commands of the same package) |
| title block | biblatex-chem.tex:19-25, :36 | `front.maketitle` | `\title`, `\author`, `\date`, `\maketitle` |
| author note | biblatex-chem.tex:19-21 | `front.thanks` | `\thanks{E-mail: ...}` |
| title footnote | biblatex-chem.tex:22-24 | `fn.kernel` | `\footnote{...}` inside `\title` |
| abstract | biblatex-chem.tex:38-54 | `abs.kernel` | `abstract` environment |
| lists | biblatex-chem.tex:44-52, :71-82 | `list.kernel` | `itemize` (one inside the abstract) |
| inline marks | biblatex-chem.tex:27-28, :42, :45-51 | `mark.kernel` | `\emph`, `\texttt` (via `\opt`), `\textsf` (via `\pkg`) |
| sectioning | biblatex-chem.tex:56, :67, :95, :148, :157, :166 | `head.kernel` | `\section`, numbered, class default look |
| margin descriptions of options | biblatex-chem.tex:30, :103-141 | `dtx.doc` | `\let\DescribeOption\DescribeEnv`, `\DescribeOption{name}` |
| change recording and history | biblatex-chem.tex:32, :175-235, :237 | `dtx.doc` | `\RecordChanges`, `\changes{v}{date}{text}`, `\PrintChanges` |
| bibliography styles (the package's subject) | chem-acs.bbx:14, chem-acs.cbx:13, chem-angew.bbx:14, chem-biochem.bbx:14, chem-rsc.bbx:14 | `bib.biblatex-biber` | `style=chem-acs` / `chem-angew` / `chem-biochem` / `chem-rsc` (each pair of `.bbx` and `.cbx` loads `numeric-comp` and adjusts it); demo drivers choose it through `\stylename` (biblatex-chem-acs.tex:11, biblatex-chem-angew.tex:11, biblatex-chem-biochem.tex:11, biblatex-chem-rsc.tex:11); the lib's bibtex-backend way also serves it (legacy branch at chem-acs.bbx:61-97) |
| style-added options | chem-acs.bbx:17-42; biblatex-chem.tex:115-146 | `bib.biblatex-biber` | `articletitle` (bool), `chaptertitle` (bool), `pageranges` (bool), `biblabel=parens\|brackets\|plain\|dot`, `subentry` (bool, from `numeric-comp`) |
| style default settings of standard options | chem-acs.bbx:45-58; chem-angew.bbx:45-56; chem-biochem.bbx:45-59; chem-rsc.bbx:45-57; chem-acs.cbx:15-20; chem-angew.cbx:15-19; chem-biochem.cbx:15; chem-rsc.cbx:15-20 | `bib.biblatex-biber` | `doi=false`, `eprint=false`, `isbn=false`, `url=false`, `date=year`, `giveninits=true`, `maxnames` (15 or 999), `maxcitenames=2`, `useprefix`, `urldate=long` (biochem), `autocite=superscript`, `autopunct=true`, `sorting=none` |
| related entries | biblatex-chem.tex:150-155; biblatex-chem.bib:148-149 | `bib.biblatex-biber` | the `related` and `relatedtype` data fields, which need the biber backend |
| example database | biblatex-chem.bib:1-502 | `bib.biblatex-biber` | a `.bib` file of 36 entries, which is content (see Content-opaque) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\opt`, `\pkg` | biblatex-chem.tex:27-28 | yes | `\providecommand` aliases of `\texttt` and `\textsf`: `mark.kernel` |
| `\let\DescribeOption\DescribeEnv` | biblatex-chem.tex:30 | yes | alias of a command of the `doc` package: `dtx.doc` |
| `\stylename`, `\styledescription` | biblatex-chem-acs.tex:11-18 (the same in the other three drivers) | yes | `\stylename` is the value after `chem-` in the `style=` key; `\styledescription` is a text paragraph (content) |
| `\input{biblatex-chem-common.tex}` | biblatex-chem-acs.tex:20, biblatex-chem-angew.tex:19, biblatex-chem-biochem.tex:20, biblatex-chem-rsc.tex:19 | not assessable | the file is not in the zip (it is listed as part of the work at biblatex-chem-acs.tex:41); only the demo drivers need it, not the main sample |
| macro code inside the four styles: `\DeclareBibliographyDriver` bodies, `\renewbibmacro*`, `\DeclareFieldFormat`, `\DefineBibliographyStrings`, and the hand-written token loops `\mkbibnocomma` (chem-angew.bbx:331-346) and `\mkgroupeddigits` (chem-rsc.bbx:235-288), `\mkbibsuperbracket` with `\DeclareCiteCommand{\supercite}` (chem-angew.cbx:22-38), `\renewbibmacro*{name:family-given}` (chem-biochem.bbx:188-220) | chem-acs.bbx:284-736 and the lines named | not bespoke by W1: published | The files are the CTAN and TeX Live package `biblatex-chem` itself; an emitter writes `style=chem-<name>` and the options above and copies none of this code. If the same code were zip-local (it is not) the token loops would be irreducible; that is why the ruling is recorded here |

## Content-opaque
none. The 36-entry `biblatex-chem.bib` is bibliographic data (content) and is read by `bib.biblatex-biber`; no TikZ, chemistry diagram or other picture appears in the manual (biblatex-chem.tex has no figure or table).

## Lib changes
- New ways proposed: none. Considered and not needed: a way of its own for the four chemistry styles (a published biblatex style is the parameter of `bib.biblatex-biber`, as a `.bst` is for `bib.bibtex-bst`); a `\changes` history way (`dtx.doc` already lists `\RecordChanges` and `\changes`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
