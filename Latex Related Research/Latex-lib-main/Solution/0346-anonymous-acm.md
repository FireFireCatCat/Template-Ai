yes

# 0346-anonymous-acm: anonymous-acm (anonymisation add-on for acmart)

- Unverified: read from the source, not compiled.
- Source: Source/0346-anonymous-acm/ (origin: https://mirrors.ctan.org/macros/latex/contrib/anonymous-acm.zip; licence: LPPL 1.3, README.txt:7, anonymous-acm.sty:5-11)
- Kind: conference (a documentation paper typeset in the ACM `sigconf` proceedings format; the manifest hint `journal` is wrong)
- Lib: v3
- Engine: pdfLaTeX-compatible (no fontspec, no Lua, no shell escape in the sample or the style; acmart's own source was not read)
- Look carried by: class (the whole page look is acmart's `sigconf` format; the only zip file is a published CTAN content switch, `anonymous-acm.sty`, which changes what is printed, not how)
- Class origin: tex-distribution-unbundled (acmart is not in the zip; ctan.org/pkg/acmart read: CTAN and TeX Live, LPPL 1.3; also ACM's official kit, anonymous-acm.tex:98)
- Main file: anonymous-acm.tex (other samples: none; `anonymous-acm.pdf` is the compiled output, not read)
- Read: main yes, zip-local classes and styles all (`anonymous-acm.sty` is the only one, 78 lines, read in full; no `.cls` present)

## Verdict
yes. The class is the published `acmart` (not bundled, source not read), and the preamble only sets two class options, a copyright keyword, title and author data. The one style in the zip, `anonymous-acm.sty`, is a CTAN package (ctan.org/pkg/anonymous-acm read), so it passes W1 to W4 as one new way `draft.todo`: one boolean option plus content-wrapping commands. The sample defines no macro of its own and no artwork.

## Blockers
none

## Class setting
- Class: `class.acmart` options: `sigconf`, `balance=false` (anonymous-acm.tex:19). The class's own `anonymous` option is not used; anonymity comes from the package.
- Class-native vocabulary used: `\setcopyright{rightsretained}` (anonymous-acm.tex:21), `\title`, `\subtitle` (:25-26), `\author` with `\affiliation{\institution \city \country}` and `\email` (:29-35), `abstract` environment placed before `\maketitle` (:68-72), `\section` and `\subsection`. The `acks` environment is only shown inside `verbatim` (:263-267). Not used: `\keywords`, `\ccsdesc`, `\acmConference`, `\acmDOI`, `\bibliography`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | anonymous-acm.tex:19 | `class.acmart` | format `sigconf`, `balance=false` |
| page size, columns, fonts | anonymous-acm.tex:19 | `page.class-options` | set by the `sigconf` format inside acmart (source not read); the sample sets no geometry, no font package, no `\setlength` (grep: none) |
| running heads and bibstrip | anonymous-acm.tex:157 (doc text) | `hf.class-native` | acmart's own running heads; the sample sets nothing; the text says author names drop out of heads under anonymity |
| copyright block | anonymous-acm.tex:21 | `front.class-native` | `\setcopyright{rightsretained}` |
| title and subtitle | anonymous-acm.tex:25-26, 72 | `front.maketitle`, `front.class-native` | `\title{...}`, `\subtitle{...}`, `\maketitle` after the abstract |
| author block | anonymous-acm.tex:28-64 | `front.class-native`, `draft.todo` | five `\author`+`\affiliation{\institution,\city,\country}` groups (`\email` on one) wrapped in `\authoranon{...}` |
| anonymity switch | anonymous-acm.tex:23; anonymous-acm.sty:26-32 | `draft.todo` | `\usepackage[false]{anonymous-acm}`; option `true` or `false`, default `true` (sty:26) |
| anonymous author placeholder | anonymous-acm.sty:36-42 | `draft.todo` | on: `\authoranon{..}` prints `\author{Anonymous Author(s)}`; off: passes its argument through |
| anonymous text | anonymous-acm.sty:45-50; demo anonymous-acm.tex:163-203 (inside `verbatim`) | `draft.todo` | `\textanon{text}{placeholder}`; empty placeholder gives `<text removed for peer review>` |
| anonymous links | anonymous-acm.sty:53-65; demo anonymous-acm.tex:208-245 | `draft.todo` | `\linkanon{url}{text}`, `\textlinkanon{url}{text}`; on: `<anonymous link>` or the plain text, off: `\href` |
| anonymous citation | anonymous-acm.sty:68-73; demo anonymous-acm.tex:251-257 | `draft.todo`, `bib.bibtex-bst` | `\citeanon[note]{key}`; on: `[anonymous]`, off: `\cite`. The sample has no bibliography; the doc says it was tested with the ACM reference format only (anonymous-acm.tex:107); the `\cite` and `.bst` belong to acmart, not read |
| anonymous acknowledgments | anonymous-acm.sty:76-78; demo anonymous-acm.tex:259-267 | `draft.todo` | on: `\excludecomment{acks}` hides the acmart `acks` environment |
| abstract | anonymous-acm.tex:68-70 | `abs.class-native` | `abstract` environment before `\maketitle` |
| headings | anonymous-acm.tex:76, 79, 118 | `head.class-native` | `\section`, `\subsection`; look and numbering come from acmart, nothing set |
| lists | anonymous-acm.tex:81, 89, 97 | `list.kernel` | `itemize` |
| quotes | anonymous-acm.tex:179, 197, 224 | `quote.kernel` | `quote` |
| code and literal text | anonymous-acm.tex:122, 163, 215 | `code.verbatim` | `verbatim` environments with command demos |
| centred block | anonymous-acm.tex:153-155 | `sp.ragged` | `center` environment |
| manual spacing | anonymous-acm.tex:156, 168, 186 | `sp.manual-space` | `\vspace*{3mm}`, `\ \\` line breaks |
| paragraph indent off | anonymous-acm.tex:84, 101, 126 | `sp.lengths` | `\noindent` (the per-paragraph override of `\parindent`; a judgement call, no other lib way is closer) |
| emphasis and type switches | anonymous-acm.tex:96, 126, 154 | `mark.kernel` | `\textbf`, `\texttt` |
| cross-references | anonymous-acm.tex:95, 107 | `xref.kernel` | `\label{sec:reqs}`, `\ref{...}` |
| hyperlinks and URLs | anonymous-acm.tex:82, 233, 236; :90, 98 | `meta.hyperref`, `meta.url` | `\href{url}{text}`, `\url{...}`; hyperref is loaded by acmart (anonymous-acm.tex:109), not by the sample |

Not in the sample: figures, tables, floats, captions, theorems, equations, bibliography, index, colour, language packages, a table of contents (`\tableofcontents` is commented out, anonymous-acm.tex:74).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `anonymous-acm.sty` (`\newif\ifAnonCondition`, options, `\authoranon`, `\textanon`, `\linkanon`, `\textlinkanon`, `\citeanon`, `\excludecomment{acks}`) | anonymous-acm.sty:26-77 | not bespoke | Published CTAN package (origin URL is CTAN; ctan.org/pkg/anonymous-acm read: LPPL 1.3, depends on acmart). Used unchanged as `draft.todo`. |
| macros, environments or counters in the sample | anonymous-acm.tex | none | grep for `newcommand`, `def`, `newenvironment`, `newcounter`, `newif`, `RequirePackage`: no hit |

Notes on the package, none a blocker:
- It never loads what it uses: `\ifstrequal` (etoolbox, anonymous-acm.sty:47, 72), `\excludecomment` (comment, :77), `\href` (hyperref, :53, 57, 64). The doc relies on acmart for hyperref (anonymous-acm.tex:109); that acmart also loads etoolbox and comment was not read here. An emitter must place the `\usepackage` line after the class and, off acmart, load those three first.
- Doc and code disagree: the doc names `\usepackage[option]{anonymous}` (anonymous-acm.tex:123) while the file is `anonymous-acm`; it claims a one-argument `\linkanon` (:239-245) while the definitions take two (anonymous-acm.sty:53-57). Both are content in a verbatim demo, not template.
- Only `\authoranon` is live in the sample (anonymous-acm.tex:28); the other commands appear only inside `verbatim`, with `[false]` set (:23).
- Prose in the sample that merely describes acmart or the package is content.

## Content-opaque
none

## Lib changes
- New ways proposed: `draft.todo` (package `anonymous-acm` v1.0, 2020-05-09 per anonymous-acm.sty:2; pdfLaTeX; one preamble line `\usepackage[true|false]{anonymous-acm}` after `\documentclass{acmart}`, plus wrappers `\authoranon{}`, `\textanon{}{}`, `\linkanon{}{}`, `\textlinkanon{}{}`, `\citeanon[]{}` and a hidden `acks` environment). W1: on CTAN (ctan.org/pkg/anonymous-acm read, LPPL 1.3). W2: one boolean option (anonymous-acm.sty:29-30) and string/content arguments, no code editing. W3: serves a kind of component, double-blind anonymisation of authors, text, links, citations and acknowledgments, not one document. W4: a preamble line and body/preamble wrappers around a node's content. Considered `draft.todo` ("review aids") and not used: those add or mark content (notes, change marks, frames, filler), whereas this package replaces or removes author, text, link, citation and acknowledgment content on a boolean; a consolidator may still fold it into `draft.todo` as a review-aid package.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
