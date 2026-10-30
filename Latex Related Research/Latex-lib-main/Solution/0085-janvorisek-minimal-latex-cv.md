no

# 0085-janvorisek-minimal-latex-cv: Minimal LaTeX CV (Jan Vorisek)

- Unverified: read from the source, not compiled.
- Source: Source/0085-janvorisek-minimal-latex-cv/ (origin: https://codeload.github.com/janvorisek/minimal-latex-cv/zip/refs/heads/master; licence: MIT, LICENSE.md:1-5, manifest)
- Kind: cv
- Lib: v1
- Engine: pdfLaTeX-compatible (`inputenc` utf8 + `fontenc` T1, minimal-latex-cv.tex:14,41; `raleway` is tagged Type1 on CTAN and `fontawesome` needs fontspec only under XeTeX/LuaTeX per its CTAN page; neither page states pdfLaTeX outright)
- Look carried by: preamble (the zip has no class or style file; `article` is loaded unchanged and the whole look is the sample's own preamble macros plus its body, minimal-latex-cv.tex:6-260)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip; its source was not read)
- Main file: minimal-latex-cv.tex (other samples: none; minimal-latex-cv.pdf is the author's preview, not read)
- Read: main yes (372 of 372 lines), zip-local classes and styles none present

## Verdict
No. Everything in the page setup, fonts, header/footer, title block, section headings and the experience/education entry list reduces to lib ways (`page.geometry`, `hf.fancyhdr`, `font.helvet`, `font.icons`, `box.fancybox`, `box.minipage`, `tbl.tabular`). The template's two signature graphics do not: a stacked skills bar chart and a bubble chart are zip-local TikZ environments and macros that compute coordinates with `\pgfmathparse` and hand-rolled counters, are not inside any float, and are part of what the CV looks like. That is `ART` plus irreducible `BESPOKE` in the preamble, so the answer is `no`.

## Blockers
- `ART/preamble` skills bar chart: environment `barchart` with inner `\baritem` drawing stacked rectangles and labels in `tikzpicture` (minimal-latex-cv.tex:144-185)
- `ART/preamble` bubble chart: `\bubble` and `\bubbles` draw circles with labels in a `tikzpicture[scale=3]` and a `\foreach` loop (minimal-latex-cv.tex:190-209)
- `ART/body` the two charts are invoked as free-standing parts of the CV, outside any figure or table float (minimal-latex-cv.tex:300-307, 310-312)
- `BESPOKE/preamble` drawing logic that drives what is printed: counters `a`, `b`, `c`, `barcount` (:128-131), `\pgfmathparse` arithmetic stored with `\let` (:156-172), `\baritem` defined by `\newcommand` inside the environment's begin code (:146-180), `\addtocounter` per item (:179), `\foreach` with counters (:201-207). No lib way takes this as declarative parameters; `art.tikz` is Restricted (its parameters are programs).

If the charts were instead read as figure content, the `BESPOKE/preamble` blocker would still stand: `barchart` and `\bubbles` are macros that exist only in this zip, and rebuilding them from `pgfplots` would be a new program, not a lib way with parameters.

## Class setting
- Class: `class.article` options: `10pt`, `A4` (minimal-latex-cv.tex:6). `A4` is not a kernel `article` paper option as far as I know (the kernel names it `a4paper`); the effective paper is set by `geometry` `a4paper` at :54.
- Class-native vocabulary used: kernel only. `document`, `center` (:310), `minipage`, `tabular*`; no `\maketitle`, no `\section`, no `abstract`, no bibliography.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | minimal-latex-cv.tex:6 | `class.article` | 10pt, A4 (see above) |
| input encoding | :14 | `font.fontenc-t1` | `inputenc` utf8 |
| font encoding | :41 | `font.fontenc-t1` | `fontenc` T1, loaded after the font package |
| text typeface | :33 | `font.helvet` | package `raleway`, option `default` (a sans text-face package is the parameter; other faces listed as comments :30-37 are not loaded) |
| default family | :40 | `font.family-default` | `\renewcommand*\familydefault{\sfdefault}` |
| extra sizes | :44 | `font.size-commands` | `moresize` (CTAN, read) provides `\HUGE`, used at :268 |
| font sizes used | :251, :268, :270, :273, :286 | `font.size-commands` | `\footnotesize`, `\HUGE`, `\LARGE`, `\small` (global `\small` at :286) |
| icon font | :47, :100, :274-282 | `font.icons` | `fontawesome` (CTAN, read); icons MapMarker, Phone, At, Globe, Github, Twitter |
| page geometry | :54, :57 | `page.geometry` | a4paper, top=2cm, bottom=2cm, left=2cm, right=2cm |
| header height | :64 | `page.setlength` | `\headheight` = -5pt (a negative value; `geometry`'s `headheight` key would set the same length) |
| header and footer | :60-69, :110, :113 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\lhead{}` `\chead{}` `\rhead{}` empty, `\headrulewidth` 0pt, `\footrulewidth` 0pt; `\cfoot` left default |
| page number off | :116 | `num.counters` | `\renewcommand{\thepage}{}`, which empties the default centred footer `\thepage` |
| section number off | :119 | `num.counters` | `\renewcommand{\thesection}{}`; the sample never calls `\section`, so this is inactive |
| paragraph indent | :72 | `sp.lengths` | `\parindent` = 0mm |
| table column sep | :237 | `sp.lengths` | `\tabcolsep` = 0pt |
| colours | :100, :220, :251, :268, :300 | `color.xcolor` | named `black`, `white`, `red`; `\textcolor`, `\colorbox`. Neither `xcolor` nor `color` is loaded by the sample, they arrive through `tikz` (:79), so an emitter must load `xcolor` itself |
| links | :22, :276-282 | `meta.hyperref` | `hidelinks`; `\href{mailto:...}` and `\href{https://...}` |
| title block (hand-laid) | :267-283 | `cols.minipage`, `sp.rule` | three `minipage[t]` of 0.45, 0.3, 0.3 `\textwidth`; each starts with `\hrule height 0pt width 0pt` to fix the top baseline |
| name in black box | :268-270 | `box.fancybox`, `color.xcolor`, `mark.kernel`, `font.size-commands`, `sp.manual-space` | `\colorbox{black}` around white bold `\MakeUppercase` name at `\HUGE`; `\vspace{1mm}` then `\LARGE` job title |
| contact lines with icons | :100-103, :274-282 | `font.icons`, `box.fancybox`, `box.minipage`, `sp.manual-space` | black 12x12 `\makebox(12,12)` in `\colorbox` with white `\large` icon, `\hspace{0.2cm}`, text at `\small`, lines ended by `\\` |
| section headings | :219-225, :293, :314, :336, :356, :363, :368 | `box.fancybox`, `color.xcolor`, `mark.kernel`, `sp.manual-space` | `\colorbox{black}` of white `\MakeUppercase{\textbf{title}}`, then `\\\\`; the headings are not `\section` |
| intro row (text beside chart) | :294-308 | `cols.minipage`, `sp.manual-space`, `sp.rule` | `minipage[t]` 0.4 `\textwidth`, `\hfill`, `minipage[t]` 0.5, `\vspace{-10pt}` |
| skills bar chart | :144-185, :300-307 | `art.tikz` | ART (see Blockers); `tikz` loaded with libraries `shapes`, `backgrounds` (:79-80) |
| bubble chart | :190-209, :310-312 | `art.tikz`, `sp.ragged` | ART (see Blockers); wrapped in the kernel `center` environment |
| experience and education entries | :237-253, :315-353 | `tbl.tabular`, `box.minipage`, `mark.kernel`, `font.size-commands`, `sp.manual-space`, `color.xcolor` | `tabular*{\textwidth}[t]{@{\extracolsep{\fill}}ll}`; cell 1 `\parbox[t]{3.5cm}`, cell 2 `\parbox[t]{14cm}` with bold title, `\hfill`, `\footnotesize` bold right text, `\\`, description. Fixed widths total 17.5cm against a 17cm text width |
| inline separator and mono tags | :255-257, :321 | `sp.manual-space`, `mark.kernel` | `\hspace{2mm}/\hspace{2mm}`; `\texttt{...}` |
| bottom three blocks | :355-370 | `cols.minipage`, `sp.rule`, `box.fancybox`, `mark.kernel`, `sp.manual-space` | three `minipage[t]` of 0.3 `\textwidth`, separated by `\hspace{0cm}` and `\hspace{2cm}`; each with a heading box; language names in `\textbf` |
| logic helper packages | :20-21 | none (loaded, never used) | `xifthen`, `calc`: no `\ifthenelse`, `\isempty`, `\widthof` or similar anywhere in the file (grep), so they carry no look |
| other unused loads and macros | :80, :84-86, :235 | none | `tikz` libraries `shapes` and `backgrounds`; `\vcenteredinclude` is defined but never called; `tabularx` is loaded but only `tabular*` is used |
| not present | whole file | none | no lists, theorems, math, floats, captions, footnotes, code, bibliography, index, abstract, table of contents |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\vcenteredinclude` | :84-86 | n/a | defined, never called; no effect |
| `\vcenteredhbox` | :90-91 | yes | measures an `hbox` and wraps it in a `\parbox` of that width, which centres it vertically: `box.minipage` (`\parbox[c]` of natural width, `calc`'s `\widthof` is already loaded); medium confidence, verdict does not depend on it |
| `\icon` | :100 | yes | `\csname fa#1\endcsname` is name indirection only, fixed per use: `box.fancybox` (`\colorbox{black}` + `\makebox(12,12)` picture-style box, no drawing) around `color.xcolor` white `font.icons` command at `\large` |
| `\icontext` | :101-103 | yes | `\icon` + `\hspace{0.2cm}` + black text, each in `\vcenteredhbox` |
| `\cvsection`, `\cvsect` | :219-225 | yes | `box.fancybox` `\colorbox{black}` of white `\MakeUppercase{\textbf{}}` plus `\\\\`; an emitter could also bind it as a heading style, but the sample does not |
| `\lorem` | :230 | yes | text alias (content) |
| `entrylist` environment | :238-242 | yes | `tbl.tabular` `tabular*` with `@{\extracolsep{\fill}}ll` |
| `\entry` | :244-253 | yes | two `box.minipage` `\parbox[t]` cells with bold, `\hfill`, `\footnotesize` pieces and `\\\\` row end |
| `\slashsep` | :255-257 | yes | `sp.manual-space` `\hspace{2mm}/\hspace{2mm}` |
| counters `a` `b` `c` `barcount` | :128-131, :182, :201-202 | no | hand-rolled counters that set bar positions and bubble x positions; `\theb` is never set, `\thec` never read |
| `barchart` environment and `\baritem` | :144-185 | no | TikZ program: `\pgfmathparse` of sizes and offsets (:156-172), `\filldraw` rectangles (:174-176), label `\node` with `\colorbox` (:178), inner `\newcommand` per environment (:146-180) |
| `\bubble`, `\bubbles` | :190-209 | no | `\foreach \p/\t` loop with `\addtocounter` and `\bubble{\thea/2}{...}{\p/25}` circles at computed x; `\definecolor{tmpcol}` (:191) is never used |

## Content-opaque
- Chart data rows (minimal-latex-cv.tex:301-306, :311) and the lorem and CV text are content. The chart drawing machinery itself is not treated as content, see Blockers.

## Lib changes
- New ways proposed: none. Mapped to existing ways: `raleway` to `font.helvet`, `moresize` to `font.size-commands`, `fontawesome` to `font.icons`, kernel `\colorbox`/`\makebox` to `box.fancybox`, `center` to `sp.ragged`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes: no text addressed to an AI was found in the zip. CTAN pages read: `moresize`, `raleway`, `fontawesome` (all on CTAN). The preview PDF and the kernel `article` source were not read.
