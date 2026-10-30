yes

# 0866-pdfpc: pdfpc (package manual under ltxdoc, plus the pdfpc.sty package)

- Unverified: read from the source, not compiled.
- Source: Source/0866-pdfpc/ (origin: https://mirrors.ctan.org/macros/latex/contrib/pdfpc.zip; licence: GPL 3 or later, pdfpc.sty:1-16 and pdfpc-doc.tex:94)
- Kind: misc (a package manual set with `ltxdoc`; the package it documents serves presentations, the manifest hint `presentation` is the package's topic, not the sample's look)
- Lib: v6
- Engine: pdfLaTeX-compatible (the sample loads `babel`, `hyperref`, `enumitem`, `iftex`; pdfpc.sty has separate pdfTeX, XeTeX and LuaTeX branches, pdfpc.sty:157-203)
- Look carried by: mixed (the `ltxdoc` class defines page, headings, title and abstract; the preamble adds `noitemsep` lists and two font-switch aliases, pdfpc-doc.tex:42-44,54; `pdfpc.sty` prints nothing)
- Class origin: tex-distribution-unbundled (`ltxdoc`, LaTeX base; not in the zip, its source was not read)
- Main file: pdfpc-doc.tex (other samples: none; README.md:37-65 holds a short beamer example that loads `pdfpc`, not a standalone file)
- Read: main yes, zip-local classes and styles all (`pdfpc.sty` read in full; it is a published CTAN package, not zip-local code)

## Verdict
`yes`. The zip is the CTAN directory of `pdfpc` (manifest source `ctan`; ctan.org/pkg/pdfpc read: v0.7.1, 2023-10-21, GPL 3+, requires `kvoptions`, `xstring`, `iftex`, `hyperxmp`). The only sample, `pdfpc-doc.tex`, is a short `ltxdoc` manual with standard preamble packages, a `table`, three `itemize` lists, an abstract, starred sections and the doc end machinery, and every part maps to a lib way. Its two zip-local macros are font-switch aliases and reduce by inline expansion. `pdfpc.sty` is published (W1) and is mapped as the proposed way `NEW:slide.pdfpc`; the sample never loads it, so the verdict does not rest on that proposal. `iftex` (pdfpc-doc.tex:34) is a load-only test package with no printed effect and no call in the sample, so it is not a component (the lib rejected `sys.compat-load` on the same ground in v4).

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: `11pt` (pdfpc-doc.tex:32)
- Class-native vocabulary used: `\cmd{...}` for command names (pdfpc-doc.tex:110,134,139,140,146,150; used with no local definition, so it comes from `ltxdoc`/`doc`); `\StopEventually{...}`, `\PrintChanges`, `\Finale` (pdfpc-doc.tex:159-161,164). The sample has no `macrocode`, `\DescribeMacro`, `\changes` or `\RecordChanges` (searched), so the change history `\PrintChanges` prints is empty.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | pdfpc-doc.tex:32 | `class.ltxdoc` | `11pt` |
| page size and text size | pdfpc-doc.tex:32 | `page.class-options` | `11pt` only; paper size and margins are `ltxdoc` defaults (source not read) |
| language | pdfpc-doc.tex:36 | `lang.babel` | `english` |
| PDF metadata and links | pdfpc-doc.tex:38,52 | `meta.hyperref` | default options; `\hypersetup{pdftitle={The pdfpc package}, pdfauthor={Evgeny Stambulchik}}` |
| external link | pdfpc-doc.tex:61 | `meta.hyperref` | `\href{https://pdfpc.github.io}{text}` (a link command of `hyperref`) |
| URL text | pdfpc-doc.tex:48,61 | `meta.url` | `\url{...}` (supplied by `hyperref`) |
| title block | pdfpc-doc.tex:47-50,57 | `front.maketitle` | `\title{...}`, `\author{Evgeny Stambulchik}`, `\date{2023/10/21 (v0.7.1)}`, `\maketitle` |
| title line break and subtitle size | pdfpc-doc.tex:47-48 | `sp.manual-space` | `\\` inside `\title` |
| title line break and subtitle size | pdfpc-doc.tex:48 | `font.size-commands` | `{\large \url{...}}` |
| title page without number | pdfpc-doc.tex:58 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| abstract | pdfpc-doc.tex:60-62 | `abs.kernel` | `abstract` environment, one paragraph |
| footnotes | pdfpc-doc.tex:61,139 | `fn.kernel` | `\footnote{\url{...}}` inside the abstract; a plain-text footnote |
| page breaks | pdfpc-doc.tex:65,105,162 | `pg.break` | `\clearpage` |
| headings | pdfpc-doc.tex:67,90,108 | `head.kernel` | `\section*{...}` (unnumbered); `\part{The documentation}` at pdfpc-doc.tex:107; look is the class default |
| bullet lists | pdfpc-doc.tex:73-79,83-87,98-102 | `list.kernel` | three `itemize` lists |
| list spacing | pdfpc-doc.tex:40,54 | `list.enumitem` | `\setlist{noitemsep}` |
| list font | pdfpc-doc.tex:74,84 | `mark.kernel` | `\sffamily` as first line of two lists |
| inline font marks | pdfpc-doc.tex:42,44,101,119-128 | `mark.kernel` | `\textsf`, `\textit`, `\rmfamily`, `\mdseries`, `\texttt`, `\emph` |
| table float | pdfpc-doc.tex:113-131 | `tbl.tabular` | `table[h]` float, no `\caption`; `tabular{ l l }`; `\hline` at 116,118,129 |
| table centring | pdfpc-doc.tex:114 | `sp.ragged` | `\centering` |
| text symbols | pdfpc-doc.tex:92,134 | `font.fontenc-t1` | `\textcopyright`, `\ldots` (text symbol glyphs) |
| angle brackets of `\param` | pdfpc-doc.tex:44 | `math.kernel` | `\ensuremath{\langle}` ... `\ensuremath{\rangle}` (inline kernel maths symbols; the text-symbol alternative `\textlangle` is `font.fontenc-t1`) |
| command-name markup | pdfpc-doc.tex:110,134,139,140,146,150 | `class.ltxdoc` | `\cmd{...}` (class-native) |
| doc end machinery | pdfpc-doc.tex:159-161,164 | `dtx.doc` | `\StopEventually{\clearpage \PrintChanges}`, `\Finale`; the class loads this same package |
| speaker notes and presenter-console metadata (the package the zip ships) | pdfpc.sty:51-60,97,154-203 | `NEW:slide.pdfpc` | options `duration` `starttime` `endtime` `enduserslide` `lastminutes` `notesposition` `defaulttransition` (strings), `hidenotes` `overridenote` `disablemarkdown` (booleans); `\pdfpcsetup{keys}`; body `\pdfpcnote<spec>{text}` |

Not present in the sample (searched): fonts or colour packages, theorems, `\label` and `\ref`, captions, code listings, bibliography, index, `geometry`, `fancyhdr`.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\sty` | pdfpc-doc.tex:42 | yes | `\newcommand*{\sty}[1]{\textsf{#1}}` is an alias of `\textsf` (`mark.kernel`); emit `\textsf{pdfpc}` inline |
| `\param` | pdfpc-doc.tex:43-44 | yes | `\def` of one argument that expands to `\textit{\rmfamily\mdseries\ensuremath{\langle}#1\ensuremath{\rangle}}`: `mark.kernel` font switches around `math.kernel` symbols; emit inline |
| `pdfpc.sty` (kvoptions keys, XMP schema hook on `hyperxmp`, `pgfpages` guesswork, annotation code per engine) | pdfpc.sty:37-203 | not bespoke | a published CTAN package (this zip is its CTAN directory), so its internals are not copied macro logic; the emitter writes `\usepackage[...]{pdfpc}` and `\pdfpcnote{...}`, see `NEW:slide.pdfpc` |

## Content-opaque
none

## Lib changes
- New ways proposed: `NEW:slide.pdfpc` `pdfpc` (CTAN, GPL 3+; Evgeny Stambulchik; v0.7.1; engine pdf, with XeTeX and LuaTeX branches at pdfpc.sty:157-203; needs `kvoptions` `xstring` `iftex` `hyperxmp`): speaker notes and presenter-console metadata for the pdfpc PDF viewer; `\usepackage[duration=5,lastminutes=2,notesposition=right,defaulttransition=...,hidenotes,overridenote,disablemarkdown]{pdfpc}`, `\pdfpcsetup{keys}`, body `\pdfpcnote<overlay>{text}` (README.md:39-45,59). W1: on CTAN, and this zip is the package's own CTAN directory. W2: seven string options and three booleans (pdfpc.sty:51-60). W3: serves any slide deck, not one document. W4: preamble lines plus a body wrapper around the note text. Not `meta.hyperxmp` (hyperxmp's own keys; pdfpc adds a separate `pdfpc:` XMP schema through its hook, pdfpc.sty:128-151), not `slide.pdfpc-movie` (a movie link), not `slide.beamer-mode` (beamer's own `\note`; `overridenote` only redirects `\note` to this command). Caveat: pdfpc.sty:84,155,158,174,190 use beamer's `\newcommand<>` and `\only` unconditionally, and the CTAN page names no class, so use with a non-beamer class is not established.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
