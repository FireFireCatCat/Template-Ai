yes

# 0433-metanorma: metanorma (tex2mn, a LaTeX class for Metanorma standards documents)

- Unverified: read from the source, not compiled.
- Source: Source/0433-metanorma/ (origin: https://mirrors.ctan.org/macros/latex/contrib/metanorma.zip; licence: mit, README.md:7)
- Kind: misc (a standards-document authoring class; the manifest hint "cv" is wrong; no printed sample)
- Lib: v5
- Engine: pdfLaTeX-compatible (metanorma.cls:12-23, 60, 67 load only pdfTeX-compatible packages; the LaTeXML and XSLT files are outside TeX, see Bespoke code)
- Look carried by: class (metanorma.cls, 132 lines: `\LoadClass{article}`, nine package loads, `\parindent=0pt`, fourteen `mdframed` box environments, a few alias macros; the zip has no preamble or sample of its own)
- Class origin: ctan (the zip is the CTAN package `metanorma` v0.5.0, Ribose Inc., MIT; ctan.org/pkg/metanorma read once: topic "Class")
- Main file: none (the zip has no .tex; the LaTeX listings embedded in metanorma.adoc stand in as the sample) (other samples: none)
- Read: main none present (metanorma.adoc read in full instead, lines 1-1650), zip-local classes and styles all (metanorma.cls 132 of 132 lines; also metanorma.cls.ltxml 149 and metanorma.xsl 693, in full)

## Verdict
yes. The only LaTeX file is metanorma.cls, a published CTAN class that loads `article` and composes published packages (`mdframed`, `ulem`, `enumitem`, `subcaption`, `hyperref`, `amsmath`) with option values; every macro in it is an alias or a no-op that reduces by inline expansion, and there is no artwork. The zip's own purpose is a LaTeX to AsciiDoc conversion (README.md:11), carried by `metanorma.cls.ltxml` (LaTeXML, Perl) and `metanorma.xsl` (latexmlpost XSLT); LaTeX never loads them and they define no PDF look, so they are recorded under Bespoke code with scope and not counted. If a reader scores the zip as a converter instead, those two files are `EXTERNAL/package` and `BESPOKE/package`. The manual's direct-PDF path is acknowledged at metanorma.adoc:539.

## Blockers
none

## Class setting
- Class: `class.metanorma` options: none (every manual listing uses plain `\documentclass{metanorma}`, metanorma.adoc:68, 99, 119, 140, 169, 866, 911; the class declares no `\DeclareOption`). It loads `class.article` as its base with no options (metanorma.cls:12).
- Class-native vocabulary used (metanorma.cls, manual listings): preamble `\set{key}{value}` (cls:39, adoc:100), body `\get{key}` (cls:45, adoc:143), `\mn{attrs}` (cls:32, adoc:271), `\att[..]{..}` (cls:50); term macros `\alt{}` `\deprecated{}` `\domain{}` (cls:113-115, adoc:570-573); citation `\mncite[locus]{key}[localities]` (cls:126, adoc:986-992); strikethrough `\textst{}` (cls:63, adoc:704); environments `note` `tip` `important` `caution` `warning` (cls:83-87), `requirement` `recommendation` `permission` (cls:95-97), `specification` `measurement-target` `verification` `import` (cls:106-109), `example` `source` (cls:120-121), and the description-type list `key` (cls:130, adoc:1355).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | metanorma.cls:9-12 | `class.metanorma` | no options; base class loaded with `\LoadClass` |
| base class | metanorma.cls:12 | `class.article` | `\LoadClass{article}`, no options (kernel defaults for paper, 10pt, one-sided, headings, abstract, `\maketitle`) |
| paragraph indent | metanorma.cls:55 | `sp.lengths` | `\setlength\parindent{0pt}` (the only length the class sets) |
| document title | metanorma.adoc:69 | `front.maketitle` | `\title{..}` in the preamble; the class does not redefine `\maketitle` and the listing has no `\maketitle` call |
| document attributes (author, custom keys) | metanorma.cls:39-46; metanorma.adoc:100, 143, 170-173 | (no way needed) | `\set` stores a string, `\get` recalls it; reduced by inline expansion, see Bespoke code |
| sectioning | metanorma.adoc:223-231, 342 | `head.kernel` | `\section` to `\subparagraph`, empty title `\subsection{}`, article numbering and spacing unchanged |
| appendix | metanorma.adoc:402-410 | `num.appendix` | kernel `\appendix` |
| bold, italic, mono, small caps | metanorma.adoc:652-658, 678-684 | `mark.kernel` | `\textbf` `\textit` `\texttt` `\textsc`, switches `\bfseries` `\itshape` `\ttfamily` `\scshape` |
| superscript, subscript | metanorma.adoc:706, 708 | `mark.kernel` | kernel `\textsuperscript` `\textsubscript` (a one-argument text-markup wrapper, the same type as `\textbf`; judged within the way) |
| strikethrough | metanorma.cls:60, 63; metanorma.adoc:704 | `mark.ulem` | `\RequirePackage[normalem]{ulem}`, `\let\textst\sout` |
| paragraph alignment | metanorma.adoc:735, 750, 765 | `sp.ragged` | `flushleft`, `center`, `flushright` environments |
| term entry macros | metanorma.cls:113-115 | `font.size-commands`, `mark.kernel` | `\alt` = `{\large #1}\par`; `\deprecated` = `\textbf{DEPRECATED:} #1\par`; `\domain` = `\textbf{DOMAIN:} #1\par` |
| admonition boxes | metanorma.cls:67-87 | `box.mdframed` | `\RequirePackage[framemethod=TikZ]{mdframed}`; base style `mnbase` (frametitlerule=true, linecolor=gray); `\mdfdefinestyle` per name: linecolor blue/green/yellow/red/orange, frametitle Note/Tip/Important/Caution/Warning; `\newmdenv[style=mnbase,style=<name>]{<name>}` |
| frame title font | metanorma.cls:71 | `mark.kernel`, `font.size-commands` | `frametitlefont=\sffamily\bfseries\scshape\small` (a parameter of the box way) |
| requirement boxes | metanorma.cls:91-97; metanorma.adoc:1418, 1433, 1448, 1472-1484 | `box.mdframed` | linecolor=gray, frametitle Requirement/Recommendation/Permission; nesting is plain environment nesting |
| requirement parts | metanorma.cls:101-109; metanorma.adoc:1515-1533 | `box.mdframed` | linecolor=lightgray, frametitle Specification/Measurement target/Verification/Import |
| example and source blocks | metanorma.cls:117-121; metanorma.adoc:577-587 | `box.mdframed` | linecolor=lightgray, frametitle Example/Source |
| colour names | metanorma.cls:72, 77-81, 91-93, 101-104, 117-118 | `color.xcolor` | named colours gray, blue, green, yellow, red, orange, lightgray as `linecolor` values; the class loads no colour package, so xcolor comes in through mdframed/TikZ (that dependency was not read) |
| ordered, bullet, description lists | metanorma.adoc:1080-1084, 1100-1104, 1120-1124 | `list.kernel` | `enumerate`, `itemize`, `description` |
| figure key list | metanorma.cls:19, 130; metanorma.adoc:1355-1359 | `list.enumitem` | `\newlist{key}{description}{1}` (name, type, max depth) |
| block quotation | metanorma.adoc:1026-1028 | `quote.kernel` | `quote` environment; attribution via `\mn` is not rendered by LaTeX (adoc:1061) |
| math | metanorma.cls:17; metanorma.adoc:1164, 1175 | `math.amsmath` | `\RequirePackage{amsmath}`, `$..$` and `\[..\]` |
| tables and captions | metanorma.adoc:1206-1209, 1228-1235 | `tbl.tabular`, `cap.kernel` | `tabular{ll}`, `table` with `\label` and `\caption` |
| figures and captions | metanorma.cls:14; metanorma.adoc:1270-1274 | `fig.graphicx`, `cap.kernel` | `\RequirePackage{graphicx}`, `figure`, `\includegraphics`, `\caption`, `\label` |
| subfigures | metanorma.cls:18; metanorma.adoc:1300-1314 | `fig.subcaption` | `\RequirePackage{subcaption}`, `subfigure[b]{0.4\textwidth}`, per-subfigure `\caption` `\label`, `\qquad` between |
| footnotes | metanorma.adoc:1395 | `fn.kernel` | `\footnote` |
| cross references | metanorma.adoc:798, 808 | `xref.kernel`, `xref.hyperref` | `\label` `\ref`; `\hyperref[label]{text}` |
| hyperlinks | metanorma.cls:15; metanorma.adoc:830, 840 | `meta.hyperref` | `\RequirePackage{hyperref}` with no options; `\url`, `\href` |
| citations | metanorma.cls:126; metanorma.adoc:870, 986-992 | `bib.thebibliography` | kernel `\cite`; `\mncite[a]{k}[b]` = `\cite[a]{k}` (`[b]` dropped) |
| bibliography, hand-written | metanorma.adoc:873-882 | `bib.thebibliography` | `thebibliography{2}`, `\bibitem[ISO 7301]{ISO7301}` |
| bibliography, BibTeX | metanorma.adoc:917 | `bib.bibtex-bst` | `\bibliography{my_database.bib}`; the listing names no `\bibliographystyle`, so the style is open |
| verbatim | metanorma.cls:21 | `code.verbatim` | `\RequirePackage{verbatim}`, load only; the XSLT calls its use "temporary" (metanorma.xsl:589) |

Not defined by the class (article defaults stand): page geometry, headers and footers, fonts, spacing other than `\parindent`, contents lists, theorems, abstract, index, code listings, pdf metadata. Documented in the manual but not defined by `metanorma.cls`: environments `reviewernote` and `todo` (metanorma.adoc:1592, 1635; defined only in the LaTeXML binding, metanorma.cls.ltxml:106-107; a grep of the .cls for `todo` and `reviewernote` finds nothing). The zip defines no PDF look for them. If a reader counts them in scope, the sibling pattern at metanorma.cls:77-87 shows the reduction (`box.mdframed` with a style and a `frametitle`).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\set{k}{v}`, `\get{k}` | metanorma.cls:39-46 | yes (BESPOKE/class, reducible) | `\set` writes `\metadata@<k>` and the RDF hook; `\get` expands it; no typeset effect of its own; the emitter writes the stored string as content (a `\newcommand` alias); `\@onlypreamble` is a kernel guard |
| `\mn`, `\lxRDF`, `\lxRDFa` | metanorma.cls:29-33 | yes | empty-bodied robust commands that swallow their arguments; no PDF effect, omitted |
| `\att[o]{m}` | metanorma.cls:50 | yes | prints `#2`; inline the argument |
| `\textst` | metanorma.cls:63 | yes | `\let` alias of `\sout`: `mark.ulem` |
| `\alt`, `\deprecated`, `\domain` | metanorma.cls:113-115 | yes | `\NewDocumentCommand` aliases of `\large`, `\textbf`, `\par` (rows "term entry macros") |
| `\mncite[a]{k}[b]` | metanorma.cls:126 | yes | `\cite[a]{k}`; as read there is no `\IfNoValueTF` guard, so an omitted `[a]` would reach `\cite` as xparse's `-NoValue-` marker (read, not run); the emitter writes `\cite[a]{k}` or `\cite{k}` directly |
| mdframed styles and 14 environments | metanorma.cls:69-121 | yes | `\mdfdefinestyle` and `\newmdenv` calls: `box.mdframed` with the parameters in the component map; `framemethod=TikZ` only selects mdframed's frame engine (loads TikZ internally), it is not an authored picture, so not `art.tikz` and no ART |
| `\newlist{key}{description}{1}` | metanorma.cls:130 | yes | `list.enumitem` |
| `metanorma.cls.ltxml` (Perl, LaTeXML binding) | metanorma.cls.ltxml:14-147 (`DefEnvironment`, Perl subs at :76-95) | not in scope (BESPOKE/package if scored) | loaded by LaTeXML instead of the .cls, never by TeX; maps the same names to RDF and `ltx:` classes for the AsciiDoc path; no PDF look |
| `metanorma.xsl` (XSLT 1.0, text output) | metanorma.xsl:9-693 | not in scope (EXTERNAL/package if scored) | latexmlpost stylesheet writing AsciiDoc (`xsl:output method="text"`, metanorma.xsl:17); needs LaTeXML and an XSLT processor, outside TeX |
| `metanorma.pdf` | binary, 466924 bytes | not in scope | the manual compiled by Asciidoctor PDF 1.5.3 from metanorma.adoc (metadata read only), not by LaTeX; contents not analysed |
| `metanorma.adoc` | metanorma.adoc:1-1650 | not in scope | AsciiDoc manual; its LaTeX/AsciiDoc listing pairs were read as the sample |

## Content-opaque
none (the manual's listings refer to `example.jpg`, `left.jpg`, `right.jpg` and `my_database.bib`, which the zip does not ship: metanorma.adoc:1273, 1302, 1309, 917; assets to supply, not template)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
