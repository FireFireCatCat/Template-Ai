yes

# 0746-ozan-kiratli-ats-cover-letter: Ozan Kiratli ATS Cover Letter

- Unverified: read from the source, not compiled.
- Source: Source/0746-ozan-kiratli-ats-cover-letter/ (origin: https://latextemplates.com/downloads/ozankiratli-cover-letter.zip; licence: LPPL-1.3c)
- Kind: letter
- Lib: v5
- Engine: pdfLaTeX-compatible (T1 + lmodern, no fontspec; README.md:15 says "Compile with PDFLaTeX")
- Look carried by: preamble (kernel `article` plus geometry, fancyhdr, parskip, one colour and one `\newcommand`, all in main.tex:1-14; the zip ships no class or style)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The zip is two files, `main.tex` (57 lines) and a README. It loads the kernel `article` class and published packages only, with no zip-local `.cls` or `.sty`. The one bespoke item, `\newcommand{\ruleline}` (main.tex:14), is a fixed string of kernel and `xcolor` calls with one call site, so it reduces by inline expansion to `sp.manual-space`, `color.xcolor` and `sp.rule`. The letter layout (sender block, date, recipient, salutation, sign-off) is hand-set with `flushright`/`flushleft` and `\\` breaks, and each piece maps to an existing way. There is no artwork and no tool outside TeX. `ltr.opening` was considered and not used: the sample never calls `\opening`, `\closing` or a letter class. README.md says the upstream ATS classes and fonts are not bundled, and the sample uses plain `article`.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (main.tex:1). The class source is not in the zip (LaTeX base) and was not read.
- Class-native vocabulary used: none. The sample uses no `\maketitle`, `abstract` or sectioning command. Everything in the body is a kernel environment (`flushright`, `flushleft`) or a package command.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | 11pt |
| type size by class option | main.tex:1 | `page.class-options` | 11pt (no paper-size option; `a4paper` is passed to geometry) |
| page geometry | main.tex:2 | `page.geometry` | a4paper, margin=0.85in |
| encoding | main.tex:3 | `font.fontenc-t1` | fontenc option T1 |
| text font | main.tex:4 | `font.lmodern` | lmodern, no options |
| colour package and accent colour | main.tex:5, main.tex:13 | `color.xcolor` | `xcolor` no options; `\definecolor{accent}{HTML}{334E68}`; named colours `gray` (main.tex:12) and `black` (main.tex:14) |
| link look and metadata package | main.tex:6 | `meta.hyperref` | hidelinks |
| paragraph spacing | main.tex:7 | `sp.parskip-pkg` | no options (also governs the gaps between the body paragraphs, main.tex:33-53) |
| header and footer | main.tex:8-12 | `hf.fancyhdr` | `\pagestyle{fancy}` (main.tex:9); `\fancyhf{}` clears header, footer and page number (main.tex:10); `\headrulewidth`=0pt (main.tex:11); `\fancyfoot[C]{...}` (main.tex:12) |
| footer text styling | main.tex:12 | `font.size-commands`, `color.xcolor`, `sp.manual-space` | `\small`; `\color{gray}`; `\enspace` before and after the `\|` bar (plain-TeX kernel space) |
| sender block alignment | main.tex:16-22 | `sp.ragged` | `flushright` environment, lines ended by `\\` (`sp.manual-space`) |
| sender name | main.tex:17 | `font.size-commands`, `mark.kernel`, `color.xcolor` | `\Large`, `\bfseries`, `\color{accent}` in one group |
| sender role and city | main.tex:18-19 | content | plain text lines |
| contact links | main.tex:20-21 | `xref.hyperref` | `\href{mailto:...}{...}` and `\href{https://...}{...}`; `\href` is a hyperref command not named on the lib line, so it counts as the same way, as the rubric's rule on commands of one package says (the other candidate is `meta.hyperref`, same package; no new way either way) |
| rule under the letterhead | main.tex:14, main.tex:23 | `sp.rule`, `sp.manual-space`, `color.xcolor` | `\ruleline` expanded at its single call: `\par`, `\vspace{5pt}`, `\color{accent}`, `\rule{\linewidth}{1.2pt}`, `\color{black}`, `\vspace{12pt}` |
| date and recipient block | main.tex:24-29 | `sp.ragged`, `sp.manual-space` | `flushleft` environment; `\\[8pt]` after the date (main.tex:25) |
| space before salutation | main.tex:30 | `sp.manual-space` | `\vspace{7pt}` |
| salutation and body paragraphs | main.tex:31-53 | content | plain paragraphs; no template construct beyond the spacing above |
| closing and signature | main.tex:55-56 | `sp.manual-space`, `mark.kernel` | `\\[8pt]` after "Sincerely,"; `\bfseries` on the name |
| not defined and not used | main.tex:1-57 | none | title block (`\maketitle`), abstract, headings and numbering, lists, quotes, notes, maths, theorems, floats, tables, captions, code, boxes, bibliography, index, language support, page numbers (suppressed by `\fancyhf{}`) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\ruleline}` | main.tex:14 (used once, main.tex:23) | yes | No arguments, no conditionals, no counters. Inline expansion gives `\par\vspace{5pt}\color{accent}\rule{\linewidth}{1.2pt}\color{black}\vspace{12pt}`: `sp.manual-space` for the two `\vspace` values (5pt, 12pt), `color.xcolor` for the accent and black switches, `sp.rule` for `\rule` (width `\linewidth`, height 1.2pt, colour accent). An emitter writes these at the one body position. |

No zip-local class, style, `\def`, counter or conditional exists (the folder holds only README.md and main.tex).

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
