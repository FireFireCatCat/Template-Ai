yes

# 0216-erdc-technical-report: ERDC Technical Report

- Unverified: read from the source, not compiled.
- Source: Source/0216-erdc-technical-report/ (origin: https://latextemplates.com/downloads/erdc.zip; licence: LPPL-1.3)
- Kind: report
- Lib: v2
- Engine: pdfLaTeX-compatible (the sample and the shim use nothing engine-specific; the class source was not read)
- Look carried by: class (the published `erdc` class, which the zip does not bundle, sets cover, headings, running heads, lists-of and captions; the zip adds report metadata, three body packages, one cover-art placeholder and an empty font-package stub)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (the only one is mathgifg.sty, 6 lines; erdc.cls is not in the zip and was not read)

## Verdict
Yes. The look is carried by `erdc`, a published class (CTAN `macros/latex/contrib/erdc`, LPPL 1.3, in TeX Live; README.md:6-8 says it is supplied by TeX Live and not bundled, and one read of ctan.org/pkg/erdc confirmed it). The preamble only loads `amsmath`, `booktabs` and `tabularx`, and the body uses kernel constructs. The two zip-local items are reducible: an empty `mathgifg` stub with no logic, and a four-line wrapper that makes the class's cover-art `\includegraphics` print a fixed `\rule`. There is no `ART` blocker, because the USACE cover artwork is removed rather than drawn. The one residual risk is that `erdc.cls` was not read, so the claim that the cover wrapper works rests on the sample author's own comments (main.tex:28-30).

## Blockers
none

## Class setting
- Class: `class.erdc` options: none (main.tex:1)
- Class-native vocabulary used: `\reportnum` (main.tex:11), `\program` (main.tex:12), `\subtitle` (main.tex:14), `\affiliation` (main.tex:17-19), `\reporttype` (main.tex:20), `\additionalinfo` (main.tex:21), `\contractnum` (main.tex:22), `\monitoredby` (main.tex:23-24), `\frontmatter` (main.tex:27), `\maketitle` as the class's cover (main.tex:33), `\listoffiguresandtables` (main.tex:36), `\chapter` / `\chapter*` (main.tex:38, 118). Kernel `\title`, `\author` with `\and`, `\date` are also used (main.tex:13, 15, 16).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.erdc` | no options |
| page geometry, fonts, numbering | main.tex:1 (not set by the sample) | `class.erdc` | class defaults; the sample sets no `\geometry`, font package or counter; class source not read |
| title block / cover | main.tex:11-24, 33 | `front.class-native` | `\reportnum{NRU-TR-26-014}`, `\program`, `\subtitle`, `\affiliation{...\\...}`, `\reporttype`, `\additionalinfo`, `\contractnum`, `\monitoredby{...\\...}`, printed by `\maketitle` |
| title, authors, date | main.tex:13, 15, 16 | `front.maketitle` | `\title`, `\date{August 2026}`, `\author{A \and B}` |
| front matter switch | main.tex:27 | `front.class-native` | `\frontmatter` |
| contents | main.tex:35 | `toc.kernel` | `\tableofcontents` |
| combined list of figures and tables | main.tex:36 | `front.class-native` | `\listoffiguresandtables` (a class command; `toc.kernel` covers only the kernel pair, and the lib has no `front.class-native`) |
| chapters, sections | main.tex:38, 63-64, 71, 80, 102, 112 | `head.kernel` | `\chapter`, `\section` |
| unnumbered chapter | main.tex:118 | `head.kernel` | `\chapter*{Document control}` |
| heading looks | main.tex:1 (not set by the sample) | `head.class-native` | class default look, no options passed |
| running heads and feet | main.tex:1 (not set by the sample) | `hf.class-native` | class default, no options passed; class source not read |
| math package | main.tex:3 | `math.amsmath` | `\usepackage{amsmath}`, no options |
| display equation | main.tex:74-76 | `math.amsmath` | `equation` environment (numbering is the class default) |
| tables | main.tex:49-61, 87-100 | `tbl.tabular` | `table` float `[ht]` with `tabular` `@{}lrrr@{}` (main.tex:52); the kernel `table` float is filed here (kernel family), as the lib has no separate table-float way |
| table rules | main.tex:4, 53, 55, 59, 91, 93, 98 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| full-width table | main.tex:5, 90 | `tbl.tabularx` | `tabularx{0.9\textwidth}`, column spec `@{}l r r X@{}` |
| table captions | main.tex:51, 89 | `cap.kernel` | `\caption` above the tabular; look set by the class |
| centring | main.tex:50, 88 | `sp.ragged` | `\centering` |
| bullet list | main.tex:105-110 | `list.kernel` | `itemize` |
| cover-art placeholder | main.tex:31-34 | `sp.rule` | `\rule{65pt}{40pt}`, installed through a scoped `\renewcommand` of `\includegraphics` (see Bespoke code) |

Not present in the sample: figures, theorems, code, bibliography, index, cross-references, footnotes, abstract, appendices, language setup. The sample calls no `\label` or `\ref`.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\includegraphics` override around `\maketitle`: `\let` saves the original, `\renewcommand{\includegraphics}[2][]{\rule{65pt}{40pt}}` replaces it, `\maketitle`, `\let` restores it | main.tex:31-34 (rationale main.tex:28-30) | yes (BESPOKE/body, not a blocker) | A macro alias whose whole effect is `sp.rule` with width 65pt and height 40pt, taking one optional and one mandatory argument and ignoring both. An emitter prints the four kernel lines verbatim. It stands in for the class's cover image, so the sample has no artwork. Not read in `erdc.cls`: that the cover calls `\includegraphics[opt]{file}` |
| `mathgifg.sty` compatibility stub (`\ProvidesPackage` then `\endinput`) | mathgifg.sty:5-6 (rationale mathgifg.sty:1-4, README.md:12-15) | yes (BESPOKE/package, not a blocker) | No code, so nothing to reproduce. An empty file stops the class's request for `mathgifg` failing, and the class falls back to the standard math fonts. The original `mathgifg` is on CTAN (Georgia and Franklin Gothic, per one read of ctan.org/pkg/mathgifg) but needs proprietary fonts the zip does not ship. Considered: a `mathgifg` font way; not proposed, because the sample deliberately does not use it |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Missing assets, not blockers: the original `mathgifg` fonts (Microsoft Georgia, ITC Franklin Gothic) and the USACE cover artwork are not shipped; the zip removes both on purpose (README.md:10, main.tex:28-30).
- Body text, the equation, table cells, the "Document control" paragraph (main.tex:119-120) and all metadata strings are content.
- Prompt-injection check: no text addressed to an AI was found in README.md, main.tex or mathgifg.sty.
- Network use: two reads of ctan.org/pkg (erdc, mathgifg).
