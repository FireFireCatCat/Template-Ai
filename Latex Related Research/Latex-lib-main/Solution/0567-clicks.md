yes

# 0567-clicks: clicks (slide-deck animation package)

- Unverified: read from the source, not compiled.
- Source: Source/0567-clicks/ (origin: https://mirrors.ctan.org/macros/latex/contrib/clicks.zip; licence: MIT, LICENSE.txt:1-21)
- Kind: presentation (a package that makes an `article` document play as a click-through deck; its own manual is an `ltxdoc` document)
- Lib: v4
- Engine: pdfLaTeX-compatible (the package uses `pgfopts`, `etoolbox`, `\vspace*`, `\newpage` only, clicks.dtx:129,155,142; `xetex` is a soft dependency, DEPENDS.txt:12, not required by the code)
- Look carried by: preamble (the published package `clicks`, loaded by `\usepackage{clicks}` over an unchanged kernel class; the package source is the zip's clicks.dtx, clicks.dtx:129-214)
- Class origin: tex-distribution-unbundled (`article` in the examples, clicks.dtx:74; `ltxdoc` in the manual driver, clicks.dtx:37; neither is in the zip)
- Main file: none (the zip holds no .tex; analysed: the package code in clicks.dtx:129-214, the two documentation examples clicks.dtx:73-82 and 92-101, the manual driver clicks.dtx:36-54) (other samples: README.md:15-25)
- Read: main none (no .tex); clicks.dtx 222 of 222 lines, clicks.ins, README.md, DEPENDS.txt and LICENSE.txt read in full; zip-local classes and styles none present (`clicks.sty` is generated from clicks.dtx by clicks.ins:30, not shipped); `clicks.pdf` (the compiled manual) not read, the PDF reader here is unavailable and the file is a build product of the .dtx. `fail-fast`, `href-ul` and `clicks` read only as ctan.org/pkg pages, their sources are not in the zip.

## Verdict
The look is one published CTAN package, `clicks`: it collects blocks with `\print` and re-sets them on a new page at each `\click` (clicks.dtx:140-143, 157-160, 186-191), so a PDF viewer in full-screen mode shows the content growing. It has one option (`static`), optional integer minutes, and content as arguments, so it passes W1 to W4 and is proposed as `slide.clicks`. The manual driver adds `ltxdoc`/`doc` machinery (`dtx.doc`), `lmodern`, `bookmark`, `hyperref` options and the CTAN package `href-ul` (`meta.hyperref`). The `yes` rests on two readings, both flagged: (1) the package's own macro accumulator is the published way, not bespoke code (if W1 were read narrowly, the accumulator, `\clicks@body` and its `\ifdefined` switch, would be irreducible and the answer would flip); (2) the one-line `\RerunFileCheck` override in the driver and the CTAN package `fail-fast` have no printed effect, so they are not components. No `ART`, no `EXTERNAL`.

## Blockers
none

## Class setting
- Class: `class.article` options: none (clicks.dtx:74; README.md:16). Manual driver: `class.ltxdoc` options: none (clicks.dtx:37).
- Class-native vocabulary used: `article`: only `\documentclass`, `document` (clicks.dtx:74-81); the examples never call `\maketitle`. `ltxdoc`: `macro` and `macrocode` environments (clicks.dtx:116-119, 128-135), `\changes` (125), `\StopEventually` (121), `\Finale` (216), `\DoNotIndex` (25), `\GetFileInfo` (24) with `\filedate` `\fileversion` (59), `\CheckSum` (6), `\CharacterTable` (8-22), `\DocInput` (50), `\PrintChanges` `\PrintIndex` (51-52, 220-222), the switches `\PageIndex` `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges` (45-48).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (example deck) | clicks.dtx:74, 93; README.md:16 | `class.article` | no options |
| click-through deck: package load | clicks.dtx:75, 94; README.md:17 | `slide.clicks` | `\usepackage{clicks}`; option `static` (clicks.dtx:116-119, 132, 174, 187) is the only package option; without it each click ends a page |
| click-through deck: blocks and page ends | clicks.dtx:77-80, 96-99; README.md:19-22 | `slide.clicks` | `\print{text}` (157-160), `\click[min]` (186-191), `\flush[min]` (169-178), `\plick[min]{text}` (209-213), `\plush[min]{text}` (199-203); minutes default 1, example values 2, 3, 5, 1 (96-99) |
| elapsed-time counter | clicks.dtx:106-112, 149 | `slide.clicks` | counter `minutes`, filled by the optional arguments; may be shown in a page header (109) but the examples and driver never show it |
| page end per click (inside the package) | clicks.dtx:142 | `slide.clicks` | kernel `\vspace*{0pt}` and `\newpage` are called by the package; not emitted separately |
| text after the last flush | README.md:23 | content | plain paragraph after `\plush` |
| class (manual driver) | clicks.dtx:37 | `class.ltxdoc` | no options |
| font (manual driver) | clicks.dtx:38 | `font.lmodern` | `\usepackage{lmodern}` |
| build diagnostics (manual driver) | clicks.dtx:39 | none (considered: `fail-fast`) | CTAN `fail-fast` turns warnings into errors (ctan.org/pkg/fail-fast); no printed effect, so not a component (as lib v4 rejected `sys.compat-load`) |
| package under documentation | clicks.dtx:40 | `slide.clicks` | `\usepackage{clicks}`, no option |
| hyperref option | clicks.dtx:41 | `meta.hyperref` | `\PassOptionsToPackage{hyperindex=false}{hyperref}`; hyperref itself is loaded by `href-ul` and `bookmark`, not by a line in the driver |
| underlined links | clicks.dtx:42 | `meta.hyperref` | `\usepackage{href-ul}`, no options (CTAN: underlines hyperlinks; built on `hyperref` and `ulem`) |
| PDF bookmarks | clicks.dtx:43 | `meta.bookmark` | `\usepackage{bookmark}`, no options |
| doc switches and index | clicks.dtx:45-48, 50-52 | `dtx.doc` | `\PageIndex`, `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput{clicks.dtx}`, `\PrintChanges`, `\PrintIndex` (index and change lists need the standard `makeindex` pass, a TeX-distribution tool as for `idx.makeidx`) |
| doc source machinery | clicks.dtx:6, 8-22, 24-25, 121, 125, 216 | `dtx.doc` | `\CheckSum{0}`, `\CharacterTable`, `\GetFileInfo`, `\DoNotIndex`, `\StopEventually`, `\changes`, `\Finale` |
| macro documentation | clicks.dtx:116-119, 128-135, 138-145 | `dtx.doc` | `macro` env named `static`, `\print`, `\flush`, ...; `macrocode` env around the code lines |
| inline code in the manual text | clicks.dtx:57, 106-112 | `dtx.doc` | vertical-bar short verbatim around names (`clicks`, `\plick`); inferred to come from ltxdoc since the driver has no `\MakeShortVerb` (ltxdoc source not read) |
| title block | clicks.dtx:57-61 | `front.maketitle` | `\title{...}`, `\author{... \\ \texttt{...}}`, `\date{\filedate, \fileversion}`, `\maketitle` |
| title footnote | clicks.dtx:57 | `front.thanks` | `\thanks{... \href{url}{text}}` |
| external link | clicks.dtx:57 | `meta.hyperref` | `\href{https://github.com/yegor256/clicks}{...}`; `\href` is a hyperref command (`xref.hyperref` names `\autoref` `\nameref` `\hyperref`) |
| sectioning | clicks.dtx:63, 114, 123 | `head.kernel` | `\section{Introduction}`, `\section{Package Options}`, `\section{Implementation}`; no redefinition |
| code display | clicks.dtx:73-82, 92-101 | `code.verbatim` | `verbatim` environment holding the example documents |
| page break before indexes | clicks.dtx:218, 221 | `pg.break` | `\clearpage` before `\PrintChanges` and `\PrintIndex` |
| page, headers, numbering, lists, tables, floats, theorems, bibliography | none in the zip | none | not defined or used by the zip |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\clicks@body`, `\clicks@flush`, counter `minutes`, `\print`, `\flush`, `\click`, `\plush`, `\plick`, switch `\clicks@static` | clicks.dtx:140-143, 149, 157-160, 169-178, 186-191, 199-213, 132 | published, not counted | the package's own code, released on CTAN (ctan.org/pkg/clicks; MIT; in TeX Live and MiKTeX). It is the proposed way `slide.clicks`: the emitter writes `\usepackage{clicks}` and `\plick[n]{block}` wrappers and copies no macro. Would be irreducible if copied (an `\gappto` accumulator replayed on each page, with an `\ifdefined` switch driving output) |
| `\renewcommand{\RerunFileCheck}[3]{\AddToHook{enddocument/info}{#2}}` | clicks.dtx:44 | no printed effect; omit | zip-local one-line override in the manual driver. By the kernel hook's name it only routes a message at end of document (inferred; kernel source not read), so it prints no page material. It is not part of the deck look. An emitter drops it; kept verbatim it is a single kernel-command line |
| DocStrip driver `clicks.ins` (`\input docstrip.tex`, `\generate{\file{clicks.sty}{\from{clicks.dtx}{package}}}`, `\Msg`) | clicks.ins:4, 30-35 | published tool, no printed effect | LaTeX base DocStrip, generates the .sty from the .dtx; the emitter loads the published `clicks` instead |
| `\ProvidesPackage`, version line `[2026-10-15 0.4.4 ...]` | clicks.dtx:31-34 | metadata | no effect on the page |

## Content-opaque
none

## Lib changes
- New ways proposed:
  - `slide.clicks`: `clicks` (CTAN, TeX Live, MiKTeX, MIT; Yegor Bugayenko; v0.4.4, clicks.dtx:34), engine `pdf`. `\usepackage[static]{clicks}` over an `article`-like class; body `\print{text}`, `\click[min]`, `\flush[min]`, `\plick[min]{text}`, `\plush[min]{text}`; counter `minutes`; needs `pgfopts` and `etoolbox` (DEPENDS.txt:1-3). W1: on CTAN (ctan.org/pkg/clicks read; the zip came from the CTAN mirror, manifest url). W2: option `static`, optional integer minutes, content as arguments (clicks.dtx:132, 169, 186, 199, 209). W3: serves any document played as a click-through deck, not one document. W4: one preamble line and one body wrapper around a node's content (note: the content is an argument, so verbatim-type material cannot sit inside, clicks.dtx:157-158). Not `slide.beamer-mode` (beamer overlays), not `slide.texpower` (overlays for a slide class such as `foiltex`), not `pg.break` (it only ends pages).
  - `meta.hyperref`: `href-ul` (CTAN, TeX Live, MiKTeX, MIT; v0.5.4 per ctan.org/pkg/href-ul; the source is not in the zip), engine `pdf` (builds on `hyperref` and `ulem` per the CTAN page). `\usepackage{href-ul}`, no options seen (clicks.dtx:42). W1: on CTAN. W2: load-only switch, no code to edit. W3: any hyperref document. W4: one preamble line. Not `meta.hyperref` (hyperref options and `\hypersetup`), not `mark.ulem` (wraps a span). The consolidator may instead widen `meta.hyperref` (a package that changes the link look, as `xref.hypcap` is a load-only switch beside hyperref).
- Considered, not proposed: `fail-fast` (CTAN; warnings become errors; no printed effect, so no component).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
