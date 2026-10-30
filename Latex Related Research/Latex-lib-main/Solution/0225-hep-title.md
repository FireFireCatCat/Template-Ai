yes

# 0225-hep-title: hep-title (title-page extensions for preprints, with its ltxdoc manual)

- Unverified: read from the source, not compiled.
- Source: Source/0225-hep-title/ (origin: https://mirrors.ctan.org/macros/latex/contrib/hep-title.zip; licence: LPPL 1.3c, README.md:20-24, hep-title-implementation.dtx:6-14)
- Kind: misc (a package source; the documented use is the title page of a physics preprint, README.md:9-10)
- Lib: v2
- Engine: pdfLaTeX-compatible (hep-title loads no fontspec or Lua code, dtx:317-345, 396, 458, 589, 894; the engine of `hep-paper`, used only by the manual at dtx:41, is not established)
- Look carried by: mixed (the title-page look is the published CTAN package `hep-title`, whose source is the .dtx; the manual's look is `ltxdoc` plus the published `hep-paper` plus a driver preamble, dtx:26-46; no zip-local class or style file exists)
- Class origin: tex-distribution-unbundled (`article` for the test samples, dtx:1016-1017; `ltxdoc` for the manual, dtx:28; neither ships in the zip and their source was not read. `hep-title` itself is `ctan`: https://ctan.org/pkg/hep-title read once, v1.5, LPPL 1.3c, "Included in TeX Live and MiKTeX")
- Main file: hep-title-implementation.dtx (abbreviated `dtx` below). It holds no standalone .tex: the DocStrip guards `testone` and `testtwo` (dtx:1013-1080) are complete `\documentclass` ... `\begin{document}` samples of the package in use (generated as hep-title-test-one.tex and hep-title-test-two.tex, hep-title.ins:32-33) and are taken as the main sample. Second sample: the `ltxdoc` manual (dtx:24-54, 83-217). Other files: hep-title.ins, README.md, bibliography.bib, license.md (the LPPL text), two built PDFs (not read). `hep-title.sty` is not in the zip; it is the DocStrip target of the `package` guard (hep-title.ins:31).
- Read: main yes (whole .dtx, lines 1-1122, plus .ins and README), zip-local classes and styles none present (no .cls or .sty file; the package code is the unprefixed lines of the .dtx, dtx:229-1009, read in full); bibliography.bib only grepped (entry types and fields)

## Verdict
Yes. The zip is the CTAN release of the `hep-title` package, so its code is published (W1) and is one new way, `front.hep-title`, whose commands take strings, label lists, font switches and pre/post hooks (no package options exist: no `\DeclareOption` in the .dtx). The test samples use only that package plus `hyperref`, `footnotebackref`, `blindtext` and kernel commands, and the manual's driver adds only font aliases, short-verb and acronym lines, a geometry call and a never-true build conditional, all reducible. The manual's look depends on `hep-paper`, which is not in the zip and was not read; it is mapped as one proposed package way, so the yes rests on that and on the published-package reading explained under "Bespoke code".

## Blockers
none

## Class setting
- Class: `class.article` options: none (testone, dtx:1016), `twocolumn` (testtwo, dtx:1017). Manual: `class.ltxdoc` options: none (dtx:28).
- Class-native vocabulary used: article: `\title` `\author` `\date` `\maketitle`, `abstract` environment, `\footnote` (dtx:1033, 1042, 1059, 1065, 1067, 1073). ltxdoc: `\DocInput` (52), `\EnableCrossrefs` (35), `\CodelineIndex` (36), `\RecordChanges` (37), `\GetFileInfo` (87), `\DescribeMacro` and `\DescribeEnv` (118-210), `\marg` `\oarg` (114-179), `\StopEventually` (220), `\PrintChanges` (222), `\changes` (76-81), `\CheckSum` (58), `\CharacterTable` (60-74), `\appendix` (225), `macro` and `macrocode` environments (231-1078), `\Finale` (1116), `\MacroFont` and `\theCodelineNo` hooks (30, 32).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (tests) | dtx:1016-1017 | `class.article` | none; `twocolumn` in testtwo |
| two columns | dtx:1017, 784, 962 | `cols.twocolumn-option` | class option `twocolumn`; hep-title tests `\if@twocolumn` at load (penalty 85 not 50 at 784, `abstract*` form at 962) |
| the package under analysis | dtx:1021; README.md:12 | `front.hep-title` | `\usepackage{hep-title}`, no options; all commands below |
| title, author, date, `\maketitle` | dtx:1033, 1042-1047, 1059, 1065 | `front.maketitle` | `\title{Title}`, five `\author`, `\date{Date}`, `\maketitle` (testtwo calls it inside `abstract*`, 967) |
| title look hooks | dtx:396-397, 403-409, 422-424, 566-574, 805-815, 936-937 | `front.titling` | `\RequirePackage{titling}`; `\thanksmarkwidth` 1.5em; `\maketitlehooka`/`b`/`c`; `\pretitle{\begin{center}\LARGE...}`, `\posttitle`, `\predate`, `\postdate` (centred blocks) |
| author lines with affiliation labels | dtx:458, 589-595, 755-764, 797-799, 821-833, 865-868 | `front.authblk` | `\RequirePackage{authblk}`; `\author[label list]{name}` and `\affil` patched by `\xpatchcmd` to print labels as `\textsuperscript` letters (`\alph{affiliation}`), affiliation block centred below the authors; `Maxaffil` unchanged |
| series line above title | dtx:1031, 368-389 | `front.hep-title` | `\series{Series}`; default centred `\Large`; `\seriesfont` `\preseries` `\postseries` |
| subtitle below title | dtx:1035, 431-449, 566-569 | `front.hep-title` | `\subtitle{Subtitle}`; default centred `\Large`; `\subtitlefont` `\presubtitle` `\postsubtitle` |
| editors line | dtx:1037-1040, 469-558 | `front.hep-title` | `\editor[labels]{name}` x3; centred `\large` tabular, italic "Editor: "/"Editors: " (`\editortitle{Editor}{Editors}`, 534-544); `\editorfont` `\preeditor` `\posteditor` |
| endorsers line | dtx:1049-1051, 648-745 | `front.hep-title` | `\endorser[label]{name}` x3; same layout as editors, title "Endorser(s): "; placed in `\maketitlehookc` (805-808) |
| affiliations | dtx:1053-1057, 770-799 | `front.hep-title` | `\affiliation[label]{text}` x5; `\Affilfont` = `\small` (774); line break allowed after each comma, penalty -50 or -85 (784-787); `\affiliationfont` |
| author notes: `\email`, `\thanks[label]` | dtx:1039-1046, 262, 986-1006 | `front.hep-title` and `front.thanks` | `\email[label]{address}` becomes a `\thanks` footnote with a `mailto` link in `\texttt` (236-238, 262); `\thanks[label]{text}` gets an optional label printed with `\@fnsymbol` (993-995) |
| preprint and reprint corner blocks | dtx:1025, 1027, 1029, 273-361 | `front.hep-title` | `\preprint{..}`, `\arxiv{id}`, `\doi{id}`, `\reprint`; two lines stacked with `\\`; upper right (preprint, `\scshape\small\raggedleft`, 309) and upper left (reprint, `\scshape\small`, 278) of page 1, set by `\AtBeginShipoutFirst` and `\put` (346-361) |
| abstract (one column) | dtx:1067-1070, 945-947 | `abs.kernel` | kernel `abstract` made to start without indent (`\noindent\ignorespaces`) |
| abstract (two columns) | dtx:1068-1071, 962-977 | `abs.abstract-pkg` and `cols.twocolumn-cmd` | `abstract*` runs `\twocolumn[\maketitle\vspace{-5ex}\begin{onecolabstract}...\vspace{.5cm}]` with `\abstitleskip` -3ex (965-969); outside twocolumn it is `\maketitle` plus `abstract` (972-976) |
| keywords line | dtx:1061, 949-956 | `abs.keywords` | `\keywords{..}` printed by `\endabstract` as `\par\medskip\noindent\textit{Keywords: ...}` |
| PDF metadata and links | dtx:1022, 884-888, 236-242, 294, 326-328 | `meta.hyperref` | `\hypersetup{pdfauthor=...}` from a plain author list at `cmd/maketitle/before`; `\online` is `\href{..}{\nolinkurl{..}}` once hyperref is loaded; `\doi` and `\arxiv` print links |
| ORCID icon in a footnote | dtx:894-895, 910-911 | `font.icons` and `color.xcolor` | `orcidlink`, `\colorlet{orcidlogocol}{black}`, `\orcmail{orcid}{mail}` (not used by the test samples) |
| footnote back-links | dtx:1023 | `fn.footnotebackref` | `\def\BackrefFootnoteTag{}` then `\usepackage{footnotebackref}`, after `hyperref` |
| footnote | dtx:1073 | `fn.kernel` | one `\footnote{Footnote}` on page 1 |
| cross-references | dtx:247-258 | `xref.kernel` | `\ref` per label, joined by `\textsuperscript,` |
| filler text and sections | dtx:1020, 1069, 1075 | `head.kernel` | `blindtext` (option `math`) `\blindtext` and `\blinddocument` supply text and default sectioning; text is content |
| manual: class and doc commands | dtx:28, 35-37, 52, 87, 220-222 | `class.ltxdoc` | vocabulary listed above; no class options |
| manual: short verbatim | dtx:33-34 | `dtx.doc` | `\DeleteShortVerb{\|}` then `\MakeShortVerb{\"}` at begin document |
| manual: page area | dtx:98 | `page.geometry` | `\newgeometry{vscale=.8, vmarginratio=3:4, includeheadfoot, left=11em, marginparwidth=4.6cm, marginparsep=3mm, right=7em}` |
| manual: house style | dtx:41, 89-92 | `class.hep-paper` | `\usepackage[parskip,oldstyle,font=10pt]{hep-paper}` (source not read); supplies `\software`, `\eg`, `\PDF`, `\tstyle`, `\codestyle`; the manual's `\subtitle` and `\email` (90-91) are hep-title commands, presumably loaded through hep-paper (unverified) |
| manual: code fonts | dtx:30-32 | `font.family-default`, `font.size-commands` and `mark.kernel` | `\ttdefault` = `clmt` inside `macrocode` through `\AtBeginEnvironment`; `\theCodelineNo` = `\rmfamily\tstyle\footnotesize\arabic{CodelineNo}`; `\MacroFont` = `\codestyle` |
| manual: acronym | dtx:44, 114 | `idx.glossaries` | `\acronym{PDF}{portable document format}`; `hep-acronym` is "an acronym extension for glossaries" (bibliography.bib:18-20), presumably loaded by hep-paper (inferred, not read) |
| manual: bibliography | dtx:42, 110, 213, 221; bibliography.bib:1-9 | `bib.biblatex-biber` | `\bibliography{bibliography}`, `\cite`, `\printbibliography`; biblatex inferred from the command names and the `subtitle`, `eprinttype`, `related` fields (bibliography.bib:3, 6, 8), backend inferred as biber (hep-paper's setting not read) |
| manual: verbatim example | dtx:153-158 | `code.verbatim` | `verbatim` environment with four lines |
| manual: headings and abstract | dtx:102-105, 112, 116, 133, 181, 194, 227 | `head.kernel` and `abs.kernel` | `\section`, `\subsection` (hep-paper may restyle them, not read); `abstract` environment |

Not a component (no printed effect): `nag` with `l2tabu, orthodox` is a diagnostics package (dtx:26). `hologo` is loaded at dtx:39 and called only inside bibliography entry titles (bibliography.bib:187, 223, 327, 342), not in the .dtx text; those logos are content (see Content-opaque).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `hep-title.sty`, DocStrip target of the unprefixed lines | dtx:229-1009; hep-title.ins:31 | not bespoke: published | the CTAN release; loaded as `\usepackage{hep-title}`, way `front.hep-title` (reading and its stricter alternative below) |
| `\theCodelineNo` and `\MacroFont` renewals | dtx:30, 32 | yes | font-switch aliases: `\rmfamily`, `\footnotesize` (`mark.kernel`, `font.size-commands`); `\tstyle` and `\codestyle` are hep-paper macros (source not read) |
| `\AtBeginEnvironment{macrocode}{\renewcommand*{\ttdefault}{clmt}}` | dtx:31 | yes | `font.family-default` set inside one environment by a hook; the package that supplies family `clmt` is not in the zip and not identified (missing asset) |
| short-verb switch | dtx:33-34 | yes | `dtx.doc` commands |
| `\acronym{PDF}{...}` | dtx:44 | yes | one `idx.glossaries` acronym entry |
| `\ifshort` conditional | dtx:49-50, 83-85, 94-96, 212-218 | yes | hand-made `\newif` that is `\shortfalse` (dtx:50) with no `\shorttrue` anywhere; it only hides the guard line 84, `\begin{document}` (95), `\printbibliography` (213) and `\end{document}` (215) during the .dtx run, so it reduces to the constant false and prints nothing of its own |

Stricter reading, for re-use of this analysis: if the package source in the .dtx were counted as zip-local code instead of the published package, it would be `BESPOKE/package` and irreducible. It copies authblk's author code into `\editor` and `\endorser` with its own counters and lists (dtx:469-516, 648-700), patches authblk internals with `\xpatchcmd` (590-595, 759-764), redefines `\@author` (821-833), makes the comma active to allow breaks (784-799), keeps a plain author list in an expl3 `seq` (840-889), redefines `\thanks` through `\AfterEndPreamble` (986-1006), places boxes at page corners with `\AtBeginShipoutFirst` and `\put` (346-361), and redraws the ORCID logo with `\tikzset` and `svg` paths (896-904, an icon, not a banner). The zip comes from CTAN (manifest url; README.md:9-12) and the package is in TeX Live, so this analysis does not take that reading, in line with the CTAN-package-source precedent of the other package zips.

## Content-opaque
- `\blindtext` and `\blinddocument` output (dtx:1069, 1075): generated filler text, headings and lists.
- The `macrocode` listings of the package, the test files and the README text (dtx:231-1078, 1086-1112): code text printed by the manual.
- bibliography.bib: 151 entries (133 `@article`, 18 `@manual`), data for the manual's bibliography; its titles call `\hologo{LaTeX}` and similar TeX-family logos (bibliography.bib:187, 223, 327, 342), content that no lib way names (closest family `art.content-package`, not used as a template look).
- The ORCID logo paths (dtx:896-904) are the internals of `font.icons`; the manual and the samples draw no picture, so no ART arises.

## Lib changes
- New ways proposed:
  - `front.hep-title`: package `hep-title` (CTAN), pdfLaTeX, series line, subtitle, editor and endorser lines, affiliation block, `\email` and `\thanks[label]` notes, preprint and reprint corner blocks on `\maketitle`, built over `titling` and `authblk`. W1: CTAN, in TeX Live (ctan.org/pkg/hep-title read once). W2: commands take strings, label lists, font switches and pre/post hook code, and the package has no options (dtx:125-131, 136-151, 162-179, 191-192, 199-210). W3: serves any preprint title page on a standard class, not one document. W4: `\usepackage{hep-title}` and commands before `\begin{document}`, body wrapper `\maketitle` or `abstract*` (dtx:1021-1071). Considered and not enough: `front.titling` and `front.authblk` (no editor or endorser lines, no corner blocks), `bg.eso-pic` (the corner blocks use `atbegshi` and `picture`, internal to the package).
  - `class.hep-paper`: package `hep-paper` (CTAN, TeX Live; ctan.org/pkg/hep-paper read once: "single style file with configurations and macros" for HEP publications, loads lightweight third-party packages), engine not established (not stated on the CTAN page), doc-kind way for a house-style package configured by options and carrying small helper macros. W1: CTAN. W2: key=value and boolean options seen at dtx:41 (`parskip`, `oldstyle`, `font=10pt`) and dtx:1019 (`lang=english`, a commented line). W3: written for HEP papers in general. W4: one `\usepackage[..]{hep-paper}` line. Weak point: its source is not in the zip and was not read, so what it sets (fonts, spacing, headings, bibliography) is not itemised; used only by the manual, not by the test samples.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
