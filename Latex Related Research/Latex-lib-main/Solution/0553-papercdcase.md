yes

# 0553-papercdcase: papercdcase (origami-style folding paper CD case)

- Unverified: read from the source, not compiled.
- Source: Source/0553-papercdcase/ (origin: https://mirrors.ctan.org/macros/latex/contrib/papercdcase.zip; licence: lppl per manifest and ctan.org/pkg/papercdcase; the .dtx header also carries its own permissive notice, papercdcase.dtx:32-40)
- Kind: misc (a printable fold-and-cut sheet that becomes a CD case; no hint category fits)
- Lib: v4
- Engine: pdfLaTeX-compatible (the package loads only `graphicx` and `calc`, papercdcase.dtx:452-453; no fontspec, no Lua)
- Look carried by: preamble (kernel `article` carries nothing; the published CTAN package `papercdcase`, loaded by the sample's preamble at example.tex:5, draws the whole fold scheme and places four text boxes; the sample only sets strings and calls `\papercdcase*`, example.tex:14-20)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip, source not read)
- Main file: example.tex (other samples: interactive.tex, a terminal-prompt demo; papercdcase.dtx driver, the package manual)
- Read: main yes, zip-local classes and styles none present (the zip ships no .cls or .sty; papercdcase.dtx, the source of the published package, was read in full, 968 lines; interactive.tex and papercdcase.ins read in full; papercdcase.pdf is the precompiled manual and was not read)

## Verdict
`yes`. The main sample is a kernel `article` that loads one published CTAN package, `papercdcase` (ctan.org/pkg/papercdcase was read: "Origami-style folding paper CD case", LPPL, Tobias Dussa, in TeX Live and MiKTeX), plus common packages, and drives it with four text strings, an optional integer size and a star. The package's internals (a `picture` drawing, 106 `\newcounter` coordinate and control counters (papercdcase.dtx:552-714), an `\@ifstar` switch) are the published way itself, not zip-local macros an emitter would copy, so I propose it as one way, `label.mceinleger`, a sibling of `label.mceinleger` and `card.gcard`. The verdict is scoped to the main sample and the package; `interactive.tex` is a second sample whose hand-rolled `\typein` loop is not counted (see Bespoke code; if a reviewer counts it, that file alone would be `BESPOKE/body` and the answer would be `no`).

## Blockers
none (for the scope above)

## Class setting
- Class: `class.article` options: none (example.tex:1). The package manual is typeset by `class.ltxdoc` (papercdcase.dtx:47, driver, no options).
- Class-native vocabulary used: none from `article` beyond kernel `\pagestyle`; `ltxdoc` vocabulary for the manual is `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges` `\PrintChanges` `\DocInput` (papercdcase.dtx:48-55), plus `\DescribeMacro` `\changes` `\CheckSum` `\DoNotIndex` `\StopEventually` `\Finale` `\PrintIndex` and `macrocode`/`macro` environments (papercdcase.dtx:75-89, 207, 427, 448, 959-961).

## Component map
Main sample (example.tex):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | example.tex:1 | `class.article` | no options |
| input and font encoding | example.tex:3-4 | `font.fontenc-t1` | inputenc `utf8`; fontenc `T1` |
| page geometry | example.tex:6 | `page.geometry` | `a4paper`, `margin=0pt` (zero margins so the fold sheet fills the page; advised at papercdcase.dtx:335) |
| header/footer | example.tex:9 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (advised at papercdcase.dtx:336) |
| paragraph indent | example.tex:10 | `sp.lengths` | `\parindent`=0pt |
| list package (loaded, unused in this sample) | example.tex:7 | `list.paralist` | `mdwlist`; its `enumerate*` is called only in interactive.tex:74 |
| CD case sheet: fold scheme and four text boxes | example.tex:5, 14-18, 20 | `label.mceinleger` | `\usepackage{papercdcase}`; `\setcdlatchmatter{..}` (14-15), `\setcdspinematter{..}` (16), `\setcdbackmatter{..}` (17-18); `\setcdpouchmatter` not called (box stays empty, papercdcase.dtx:466); body `\papercdcase*` (20): star = A4 layout, design height 297 and pouch height 75 (papercdcase.dtx:515), plain form 279 and 64 (papercdcase.dtx:516); optional `[size]` mm, default 120 (papercdcase.dtx:738), not used here |
| centring of the sheet | example.tex:20 | `sp.ragged` | `\centering` before `\papercdcase*` (advised at papercdcase.dtx:337) |
| box text styling | example.tex:14-18 | `mark.kernel` | `\textsf`, `\textbf` around the box strings |
| box text sizes | example.tex:14-18 | `font.size-commands` | `\LARGE` (latch, back), `\Large` (spine) |
| line break inside a box | example.tex:14-15, 17-18 | `sp.manual-space` | `\\` between title and "CD 1/2" |
| package-internal rotation | papercdcase.dtx:452, 855 | `fig.rotating` | `graphicx` `\rotatebox{180}` etc. inside the way; not a sample-level component |
| package-internal arithmetic | papercdcase.dtx:453 | considered: `calc` | load-only helper for the counter sums (papercdcase.dtx:746-755); internal to the way, not a document component, no way proposed |

Package manual (papercdcase.dtx driver and documentation text; a second document, not the template look):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | papercdcase.dtx:47 | `class.ltxdoc` | no options |
| DocStrip documentation | papercdcase.dtx:48-55, 75-89, 108, 207, 427, 448, 959-961 | `dtx.doc` | `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\PrintChanges`, `\DocInput`, `\MakeShortVerb{\|}`, `\DescribeMacro`, `\changes`, `\CheckSum`, `\DoNotIndex`, `\StopEventually`, `\Finale`, `\PrintIndex` |
| index columns | papercdcase.dtx:51 | `num.counters` | `\setcounter{IndexColumns}2` |
| title block | papercdcase.dtx:60-70 | `front.maketitle` | `\title` `\author` `\date{{\footnotesize ..}}` `\maketitle` |
| title footnote | papercdcase.dtx:61-62 | `front.thanks` | `\thanks{..}` in `\title` |
| abstract | papercdcase.dtx:110-125 | `abs.kernel` | `abstract` environment |
| contents | papercdcase.dtx:127 | `toc.kernel` | `\tableofcontents` |
| headings | papercdcase.dtx:130, 176, 205, 545 | `head.kernel` | `\section`, `\subsection`, `\subsubsection` |
| lists | papercdcase.dtx:179-185, 214-218 | `list.kernel` | `enumerate`, `itemize` |
| verbatim | papercdcase.dtx:210-212, 294-317 | `code.verbatim` | `verbatim` environment, `\verb~..~` (papercdcase.dtx:66) |
| cross-references | papercdcase.dtx:205, 222 | `xref.kernel` | `\label{sec:scheme}`, `\ref{sec:folding}` |
| inline maths | papercdcase.dtx:150, 155 | `math.kernel` | `$296.9\,\hbox{mm}$`, `$\frac{11}{16}''$` (content) |
| page break and emphasis | papercdcase.dtx:128, 192 | `pg.break`, `mark.kernel` | `\newpage`, `\emph` |
| size switch and line break | papercdcase.dtx:68, 158 | `font.size-commands`, `sp.manual-space` | `\footnotesize`, `\\` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\@PCDC@*` counters (106 `\newcounter` lines), `\@PCDC@Typeset@Scheme`, `picture` drawing with `\put` `\line` `\multiput`, `\papercdcase` with `\@ifstar` | papercdcase.dtx:465-944 | n/a: published CTAN package (W1), the way itself | not reduced; the emitter writes `\usepackage{papercdcase}` and calls the commands, so the code is never copied |
| `\setcd{latch,pouch,back,spine}matter` | papercdcase.dtx:477, 484, 491, 498 | n/a: the package's own interface | the way's string parameters |
| install driver: `\input docstrip.tex`, `\generateFile{papercdcase.sty}` | papercdcase.ins:28-31 | n/a: DocStrip is TeX-only, it makes the published .sty; not a document component | the zip does not ship `papercdcase.sty`; extract it with the .ins or use the TeX Live copy (missing asset, noted) |
| `\maxilatchtext` `\maxispinetext` `\maxibacktext` `\latchtext` `\spinetext` `\backtext` | interactive.tex:12-18 (other sample) | yes | `\def` aliases; inline-expand to `\setcd*matter{\textsf{\textbf{\Large #1}}}` etc. (`mark.kernel`, `font.size-commands`, the new way) |
| `\empty` `\yes` `\msg`, `\toksdef\ta` `\tb`, `\rightappenditem`, `\erightappenditem`, `\newif\iftrackgiven`, `\loop`..`\repeat`, `\typein` prompts, the `\ifx` branches | interactive.tex:20-26, 28, 32-115 (other sample) | not counted (outside the main sample); if counted: no | hand-rolled token-list builder and loop driven by terminal input (`\typein`, interactive.tex:36-55) that needs a person at the keyboard; no typesetting behaviour beyond the lib, since after any run it reduces to the same four setter calls, `enumerate*` (`list.paralist`) and `\papercdcase[80]` or `\papercdcase` (interactive.tex:74, 90, 114). Four branches call names that are never defined, `\maxispinetexi` (70), `\maxibacktexi` (81), `\spinetexi` (94), `\backtexi` (105), so the file would stop with undefined control sequences as written |

## Content-opaque
none (the fold lines, numbers and box placement are fixed inside the way, not drawn by the sample; "Slackware Linux 10.2 CD 1/2" at example.tex:14-18 is text content)

## Lib changes
- New ways proposed: `label.mceinleger` `papercdcase` (CTAN, TeX Live, MiKTeX, LPPL; Tobias Dussa; v1.0 of 2006), engine pdf. One way for an origami-style paper CD case sheet: `\usepackage{papercdcase}`; four setters `\setcdlatchmatter{}` `\setcdspinematter{}` `\setcdbackmatter{}` `\setcdpouchmatter{}` (LaTeX text, set before the call, papercdcase.dtx:319-321); body `\papercdcase[size-mm]` (default 120, any whole millimetre) and `\papercdcase*` (A4-optimised fold layout); the fold lines, numbers and box positions are fixed in the package, the placing on paper (zero margins, empty page style, centring) is the document's. W1: the CTAN page names the package, read once. W2: the behaviour is chosen by strings, one integer and one star, no code is edited. W3: it serves any paper CD case (artist, title, tracks), not one document. W4: a preamble `\usepackage` plus body setter calls and one body command. Not `label.mceinleger` (cassette inserts, another package), `card.gcard` (greeting card), `ticket.sheet` (many tickets per sheet), `label.flabels` (binder spine labels).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
