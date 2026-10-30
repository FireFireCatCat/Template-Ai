yes

# 0577-latex-base-dev: LaTeX base kernel, development pre-release (sample2e.tex)

- Unverified: read from the source, not compiled.
- Source: Source/0577-latex-base-dev/ (origin: https://mirrors.ctan.org/macros/latex-dev/base.zip; licence: lppl1.3c)
- Kind: misc (a plain sample document inside the LaTeX kernel's own source distribution; no designed look)
- Lib: v4
- Engine: pdfLaTeX-compatible (main sample). Other samples differ: `ltnews.tex` needs LuaLaTeX (`\DocumentMetadata` tagging, `lua-unicode-math`: ltnews.tex:42, ltnews.tex:65).
- Look carried by: class (the main sample loads only kernel `article`, sets no option and loads no package: sample2e.tex:6)
- Class origin: publisher-official (the zip is the LaTeX Project Team's own pre-release of the base bundle; ctan.org/pkg/latex-dev names the LaTeX Project Team as maintainer; `article` itself is not unpacked here, its source is classes.dtx)
- Main file: sample2e.tex (other samples: small2e.tex, ltnews.tex, ltnews01.tex..ltnews44.tex, source2e.tex, cmdguide.tex, usrguide.tex, clsguide.tex, cfgguide.tex, fntguide.tex, encguide.tex, modguide.tex, cyrguide.tex, idx.tex, lablst.tex, testpage.tex, ltxcheck.tex, ltx3info.tex, lppl.tex)
- Read: main yes (all 204 lines), zip-local classes and styles partly (ltnews.cls, ltxguide.cls, minimal.cls, source2edoc.cls, l3in2edoc.cls read in full; doc-2021-06-01.sty lines 44-444 of 838 read and doc-2016-02-15.sty compared by diff only; the 150-odd `.dtx` kernel sources, the guides and ltnews01-44 were not read, except the heads of ltnews.tex, source2e.tex, cmdguide.tex)

## Verdict
yes, for what the main sample defines. sample2e.tex is a plain kernel `article` document with one `\newcommand` alias, and every construct it uses (title block, sections, quote/quotation/verse, nested lists, footnote, inline and display maths, `\emph`) has a lib way; the alias reduces by inline expansion. The look is carried by the published class, so this is evidence about the class dimension, not about the component ways.
Not counted, but recorded so the result can be re-read under a wider definition: the zip also ships `source2edoc.cls` and `l3in2edoc.cls`, which are not in manifest.txt, call themselves internal hacks that will vanish, and hold irreducible code (`BESPOKE/class`). The main sample does not load them (only source2e.tex:72 and cmdguide.tex:29 do), so they are outside the rubric's scope (the class and style files the sample loads).

## Blockers
none (in scope). Outside the main sample's reach, see "Bespoke code": `source2edoc.cls`, `l3in2edoc.cls`.

## Class setting
- Class: `class.article` options: none (sample2e.tex:6)
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (sample2e.tex:9-11, 23); `\section` (29, 137); environments `quote`, `quotation`, `verse`, `itemize`, `enumerate` (142-193); `\footnote` (121).
- Other classes the zip ships, not loaded by the main sample:
  - `class.ltnews` (manifest.txt:255, published with the base bundle): loads `article` with `twocolumn,oneside` (ltnews.cls:325); options `lw35fonts` (258) and `type1fonts` (286), the paper, `titlepage` and `onecolumn` options switched off (229-238), the rest passed to `article` (317); vocabulary `\publicationmonth` `\publicationyear` `\publicationday` `\publicationissue` `\publicationdate` (437-451, 469), `\indicia` (474), `citations` environment (605), `\LaTeXNews`, logical markup `\cs` `\class` `\package` `\file` (633-640).
  - `class.ltxguide` (manifest.txt:254; already in the lib): loads `article` (ltxguide.cls:56); vocabulary `decl` environment (94), `\NEWfeature` `\NEWdescription` (197-202), `\m` `\oarg` `\arg` (172-174), `|...|` short verbatim (141-142).
  - `class.minimal` (manifest.txt:256): `\renewcommand\normalsize`, text block 6.5in x 8in, empty page style (minimal.cls:36-42).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | sample2e.tex:6 | `class.article` | no options (10pt, letter paper, one column, one side by class default) |
| page geometry | sample2e.tex:6 | `page.class-options` | none given; article defaults only |
| title block | sample2e.tex:9-11, 23 | `front.maketitle` | `\title{An Example Document}`, `\author{Leslie Lamport}`, `\date{January 21, 1994}` (a literal string), `\maketitle` |
| headings | sample2e.tex:29, 137 | `head.kernel` | `\section` only (a `\subsection` is named in a comment, 30-31); no renewcommand, class numbering |
| emphasis | sample2e.tex:101, 107, 156, 166, 190; env 104-108 | `mark.kernel` | `\emph{..}` and the `em` declaration environment; no other font switch |
| unbreakable word | sample2e.tex:117 | `box.fancybox` | `\mbox{\emph{itemnum}}`: the unframed kernel box (the `\fbox` family), used to stop hyphenation; `box.minipage` is the other candidate |
| footnote | sample2e.tex:121 | `fn.kernel` | one `\footnote{..}`, class defaults |
| inline maths | sample2e.tex:126, 128, 130, 133 | `math.kernel` | `\( .. \)` and `$ .. $`; no `amsmath` |
| display maths | sample2e.tex:200 | `math.kernel` | `\[ .. \]`; unnumbered |
| quotations | sample2e.tex:142-145, 147-154 | `quote.kernel` | `quote`, `quotation` |
| verse | sample2e.tex:181-193 | `quote.kernel` | `verse` with `\\` line breaks and blank-line stanzas |
| lists | sample2e.tex:158-179 | `list.kernel` | `itemize` containing `enumerate` (nested, 167-174); default labels |
| logo | sample2e.tex:44, 46, 94, 110, 172 | `font.icons` | kernel `\LaTeX` logo command (the same type of effect as `\hologo{LaTeX}`, which the lib's `font.icons` line names; it could equally be read as plain text) |
| inline text conventions | sample2e.tex:56-62, 64-70, 77-78, 83, 98, 114 | none: content | quote marks, dashes, `~`, `\ `, `\@`, `\,`, `\ldots`, `\$ \& \% \# \{ \}` are characters of the text, written by the text escaper |
| preamble macro | sample2e.tex:13 | none: reduced inline | `\newcommand{\ip}[2]{(#1, #2)}`; see "Bespoke code" |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\ip` alias | sample2e.tex:13 (uses 130, 200; alternative definition commented out at 17) | yes | an alias with no layout effect: expand at each use, `\ip{A}{B}` becomes `(A, B)` inside the `math.kernel` content; nothing to print in the preamble |
| `ltnews.cls` | ltnews.cls:44 | not needed: published (manifest.txt:255); not loaded by the main sample (ltnews.tex:64) | `class.ltnews`; not reduced (its section looks 539-556, list settings 582-593, logo boxes 133-221 and active `<>` 660-668 are class internals) |
| `ltxguide.cls` | ltxguide.cls:42 | not needed: published (manifest.txt:254), `class.ltxguide` is in the lib; not loaded by the main sample (usrguide.tex:31, clsguide.tex:31) | not reduced (`decl` environment 94-105, `\@starttoc` 109-116, active `<>` 149-168 are class internals) |
| `minimal.cls` | minimal.cls:34 | yes, and published (manifest.txt:256) | `font.size-commands` 10pt/12pt (36), `page.setlength` textwidth 6.5in textheight 8in (38-39), `pgnum.pagenumbering` arabic (41), `hf.pagestyle-kernel` empty (42); not loaded by any sample here |
| `source2edoc.cls` | source2edoc.cls:4-6, 10, 20-76, 126-148, 153-221 | no, `BESPOKE/class`; outside the main sample (loaded by source2e.tex:72) | not in manifest.txt; says it is a quick hack "will vanish again"; expl3 redefinitions of `l3doc` internals (20-76), hand-written `\@maketitle` (126-148), a catcode-driven comment scanner environment (153-221), `\docincludeaux` footers (100-118) |
| `l3in2edoc.cls` | l3in2edoc.cls:5, 9, 17, 21-53 | no, `BESPOKE/class`; outside the main sample (loaded by cmdguide.tex:29) | not in manifest.txt; says it is not meant for use outside the kernel documentation; builds on `l3doc` (l3kernel, not in this zip, :9) and `ltxdoc-extra.ltx` (not in this zip, :17); two `\renewenvironment` bodies with an `\ifx` that decides what prints (34-53) |
| `doc-2016-02-15.sty`, `doc-2021-06-01.sty` | doc-2016-02-15.sty:29, doc-2021-06-01.sty:45 | n/a: dated snapshots of the published `doc` package (v2.1g and v2.1n) | `dtx.doc`; the diff between them is 84 lines of version fixes; not loaded by sample2e.tex |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
