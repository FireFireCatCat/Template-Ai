yes

# 0593-ppt-slides: ppt-slides (PowerPoint-style slide deck over article)

- Unverified: read from the source, not compiled.
- Source: Source/0593-ppt-slides/ (origin: https://latextemplates.com/downloads/ppt-slides.zip; licence: MIT)
- Kind: presentation
- Lib: v5
- Engine: pdfLaTeX-compatible (assumed, not verified: the sample loads no `fontspec`, `polyglossia` or Lua code, but the sources of the five loaded packages are not in the zip and the CTAN pages of `ppt-slides` and `crumbs` state no engine)
- Look carried by: preamble (the deck look comes from the published package `ppt-slides`, loaded in the preamble with `template=9x6,scheme=light` at main.tex:5; the class stays `article` and the zip holds no `.cls` or `.sty`)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; the zip holds this one 57-line file only)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip is one 57-line `main.tex` on the kernel `article` class. It loads five published packages (`crumbs`, `qrcode`, `clicks`, `ppt-slides`, `titling`; main.tex:2-6) and defines no macro, environment, counter or conditional of its own, so there is no bespoke code and no artwork. The look lives in `ppt-slides`, which is not in the zip and was not read; an emitter writes five `\usepackage` lines, two header-field calls and the package's own body commands. One way is new, `slide.crumbs`, for the breadcrumb package loaded at main.tex:2. The verdict rests on the published packages behaving as their lib lines and CTAN pages describe (their sources are not in the zip).

## Blockers
none

## Class setting
- Class: `class.article` options: none (main.tex:1). The kernel class is not bundled in the zip, so its source was not read.
- Class-native vocabulary used: `\title` and `\author` only (main.tex:10-11). `\maketitle`, `abstract`, `\section` and `\newtheorem` are never called; the deck's title and headings come from `ppt-slides` commands, not from `article` ones. `\newpage` (main.tex:43) and `\Large` (main.tex:53) are kernel commands.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | no options |
| slide deck look (page format, fonts, header and footer bars) | main.tex:5 | `slide.ppt-slides` | load options `template=9x6`, `scheme=light`; the documented options `directory`, `nominutes`, `nocrumbs` are not set |
| page geometry | main.tex:5 | `slide.ppt-slides` | set only through `template=9x6` (what it sets is not read); the sample has no `geometry` call and no length assignment |
| colour scheme | main.tex:5 | `slide.ppt-slides` | `scheme=light`; no `\definecolor` and no `xcolor` call in the sample |
| running header fields, left and right | main.tex:12-13 | `slide.ppt-slides` | `\pptLeft{\thetitle}`, `\pptRight{\theauthor}`: two text arguments, written after `\begin{document}` (main.tex:8) and before the first slide (the lib line lists them as preamble commands) |
| breadcrumb trail in the header | main.tex:2 | `slide.crumbs` | `\usepackage[dry]{crumbs}`; one load option `dry`, its effect not read; loaded before `ppt-slides` (main.tex:5) |
| step-by-step reveal, package | main.tex:4 | `slide.clicks` | `\usepackage{clicks}`, no options (the lib line shows a `static` option; the sample does not set it) |
| reveal wrappers on slide content | main.tex:15, 25, 27, 28, 31, 33, 34, 45, 47, 48, 51 | `slide.clicks` | `\plush{...}` with no optional argument, around the title slide, the chapter and section slides, three body paragraphs and the closing slide |
| slide body paragraphs | main.tex:28-29, 34-35, 48-49 | `slide.clicks` | plain paragraphs as the `\plush` argument (the text is content) |
| QR-code package, load only | main.tex:3 | `fig.qrcode` | `\usepackage[forget]{qrcode}`; no `\qrcode` or `\pptQR` call in the body; the effect of `forget` is not read |
| document data (title, author) | main.tex:10-11 | `front.maketitle` | `\title{Customer Support Deflection}`, `\author{Hana Ibrahim}`; `\maketitle` is not called |
| title and author read back | main.tex:6, 12, 13, 19 | `front.titling` | `\usepackage{titling}`, no options; its `\thetitle` and `\theauthor` feed the two header fields and the title slide |
| title slide | main.tex:15-21 | `slide.ppt-slides` | `\pptMiddle{\pptTitle{support ops}{\thetitle}}` inside `\plush`; two text arguments to `\pptTitle`; `\pptMiddle` is called with a braced argument here, where the lib line lists it as an environment (same package, other call form) |
| contents (agenda) slide | main.tex:23 | `slide.ppt-slides` | `\pptToc[Agenda]`, one optional text argument |
| chapter divider slides | main.tex:25, 31, 45 | `slide.ppt-slides` | `\pptChapter{The Problem}`, `{The Fix}`, `{What's Next}`, each inside `\plush` |
| section headings | main.tex:27, 33, 47 | `slide.ppt-slides` | `\pptSection{...}`, each inside `\plush` |
| banner line | main.tex:37 | `slide.ppt-slides` | `\pptBanner{Deflection rate by category:}`, no colour argument, not inside `\plush` |
| wide one-column text block | main.tex:38-42 | `slide.ppt-slides` | environment `pptWideOne`; three plain sentences, no list or tabular inside |
| manual page break | main.tex:43 | `pg.break` | `\newpage` after the `pptWideOne` block |
| closing slide | main.tex:51-55 | `slide.ppt-slides` | `\pptMiddle{\Large Thank you}` inside `\plush` |
| closing slide size | main.tex:53 | `font.size-commands` | `\Large` |

No lists, theorems, floats, tables, captions, code, boxes, bibliography, index or cross-references appear in the sample. It loads no `hyperref`, `babel`, `fontenc` or `geometry` line itself; what `ppt-slides` loads is not read.

## Bespoke code
none. The sample has no `\newcommand`, `\renewcommand`, `\def`, `\newenvironment`, `\newcounter`, `\newif` or `\makeatletter` (whole file read). Every macro it calls (`\pptLeft`, `\pptRight`, `\pptMiddle`, `\pptTitle`, `\pptToc`, `\pptChapter`, `\pptSection`, `\pptBanner`, `pptWideOne`, `\plush`, `\thetitle`, `\theauthor`) belongs to a published package (`ppt-slides`, `clicks`, `titling`). The package sources are not in the zip and were not read.

## Content-opaque
none

## Lib changes
- New ways proposed: `slide.crumbs` `crumbs` (CTAN, in TeX Live and MiKTeX, MIT; Yegor Bugayenko; v0.4.2 of 2026-10-15; read at ctan.org/pkg/crumbs: it adds a breadcrumb navigation path to the header of a presentation); pdf engine tag like its sibling `slide.clicks` (the CTAN page states no engine); `\usepackage[dry]{crumbs}` is a load-only preamble line with a load option and no body wrapper in the sample; the CTAN page lists no options or commands and the source was not read. W1: on CTAN under the MIT licence. W2: behaviour chosen by a load option (`dry` seen). W3: serves the header of any presentation deck, not this one document. W4: one preamble line. Not `hf.fancyhdr` or `hf.extramarks` (they print fields you write, this builds a trail), not `slide.clicks` (reveals, no header), not `slide.ppt-slides` (a different package whose documented `nocrumbs` option only names this one). A consolidator that prefers to widen the `slide.ppt-slides` line instead loses nothing here.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Origin is latextemplates.com, not a publisher kit, but the zip carries no `.cls` or `.sty`, so the rubric's zip-local rule does not apply. `ppt-slides` (v0.8.2 of 2026-10-14, MIT, in TeX Live and MiKTeX) and `crumbs` were read at ctan.org/pkg; the CTAN pages list no options, commands, dependencies or engine. `clicks`, `qrcode` and `titling` rest on the lib's own lines for `slide.clicks`, `fig.qrcode` and `front.titling`.
- Option effects not read: `dry` (crumbs, main.tex:2), `forget` (qrcode, main.tex:3), `template=9x6` and `scheme=light` (ppt-slides, main.tex:5). They are strings or booleans, so they are parameters, not bespoke code.
- If `ppt-slides` loaded a tool-dependent package unconditionally (`minted`, shell escape), the rubric's pilot ruling would make this `EXTERNAL/package`; the lib line for `slide.ppt-slides` records no such dependency, and this analysis could not check it because the package source is not in the zip.
- No text addressed to an AI was found in the zip.
