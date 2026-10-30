yes

# 0304-turnthepage: the turnthepage package and its manual

- Unverified: read from the source, not compiled.
- Source: Source/0304-turnthepage/ (origin: https://mirrors.ctan.org/macros/latex/contrib/turnthepage.zip; licence: LPPL 1.3c, README:28-36)
- Kind: misc (a package manual set in `article`; the manifest hint `exam` comes from the package's purpose, README:18-26, the sample itself is not an exam)
- Lib: v4
- Engine: pdfLaTeX-compatible (no fontspec, unicode-math or luacode; the package works through the LaTeX shipout hook `shipout/background` and the `picture` package, turnpageetex.sty:34-44; the CTAN page states no engine and tags it "Tagged PDF - fully compatible"; a makeindex and a bibtex run are needed, README:59-65)
- Look carried by: mixed (kernel `article` plus a four-item preamble set the manual's look, turnthepage.tex:1-8; the one distinctive element, the "turn the page" mark at the bottom right of odd pages, comes from the package `turnthepage`, whose three `.sty` files are in the zip and are the CTAN release itself)
- Class origin: tex-distribution-unbundled (class `article` is the kernel class, not bundled; the `.sty` files are the published CTAN package `turnthepage`: ctan.org/pkg/turnthepage read, LPPL 1.3c, "included in TeX Live and MiKTeX")
- Main file: turnthepage.tex (other samples: none; turnthepage.pdf is the compiled manual, a binary, not read)
- Read: main yes, zip-local classes and styles all (three `.sty`, no `.cls`; also README and turnthepage-bib.bib)

## Verdict
Yes. The sample is the package's own manual: kernel `article` with `microtype`, `hyperref`, a BibTeX bibliography and a makeindex index, all published ways. The only template-specific effect is the "turn the page" note, which is the published CTAN package `turnthepage` (W1: README:42-43 and the CTAN page; W2: five language options and a redefinable message string; W3: any twoside document; W4: one `\usepackage[english]{turnthepage}` line). The emitter loads that package and does not copy its code. The sample's own bespoke items are two small macros that reduce (an alias and a hand-rolled index include). There is no artwork: the `\put` in the package positions a text string, it does not draw. The verdict rests on reading the package's own hook, counter and conditional logic as the published way's internals (W1), not as zip-local bespoke code; a reviewer who reads that logic as bespoke would flip it to no.

## Blockers
none

## Class setting
- Class: `class.article` options: `12pt`, `a4paper`, `twoside` (turnthepage.tex:1)
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle`, `\tableofcontents`, `\section` `\subsection`, `itemize` `enumerate` `center` `verbatim`, `\newpage`, `\cite`, `\nocite`, `\bibliographystyle` `\bibliography`; the class's `theindex` environment is filled from the `.ind` file (turnthepage.tex:111). The sample uses no `abstract`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | turnthepage.tex:1 | `class.article` | 12pt, a4paper, twoside |
| paper, size, sides | turnthepage.tex:1 | `page.class-options` | a4paper, 12pt, twoside (margins and text block are the class defaults; nothing is set) |
| odd-page turn-over note | turnthepage.tex:3; turnthepage.sty:4-8, 16-27; turnpageetex.sty:6-11, 34-44 | `hf.turnthepage` | option `english` (message `\textit{Turn the page.}`); other options `short` `francais` `nederlands` `deutsch`; message macro `\turnthepage` redefinable (documented at turnthepage.tex:47-52, shown in verbatim, not applied) |
| protrusion and spacing | turnthepage.tex:2 | `sp.microtype` | protrusion, final, verbose |
| PDF links, bookmarks, metadata | turnthepage.tex:5-8 | `meta.hyperref` | bookmarks, bookmarksnumbered, bookmarksopen, bookmarksopenlevel=1, breaklinks, colorlinks, final, menucolor=red, pdfauthor, pdfkeywords, pdftitle, pdfsubject, pdftoolbar; `\hypersetup` urlcolor=red, linkcolor=blue, citecolor=blue |
| external links and anchor | turnthepage.tex:105-108, 110 | `xref.hyperref` | `\href{mailto:...}{text}` (three); `\phantomsection` before the index |
| title block | turnthepage.tex:12-16 | `front.maketitle` | `\title` with an inline `\textbf`, three authors in one comma-separated `\author`, `\date{2024-11-15 v2.0a}` (a string) |
| contents list | turnthepage.tex:17 | `toc.kernel` | `\tableofcontents` |
| page breaks | turnthepage.tex:18, 109, 112 | `pg.break` | `\newpage` |
| headings | turnthepage.tex:19, 28, 30, 38, 57, 94, 102, 113 | `head.kernel` | `\section`, `\subsection`, class defaults |
| bullet lists | turnthepage.tex:40-46, 71-75, 96-100 | `list.kernel` | `itemize`, one nested in an `enumerate` item |
| numbered list | turnthepage.tex:58-92 | `list.kernel` | `enumerate` with `\item \verb|v1.0|:` entries |
| list counter start | turnthepage.tex:59 | `num.counters` | `\addtocounter{enumi}{-1}` makes the first item 0 |
| centred block | turnthepage.tex:32-36 | `sp.ragged` | kernel `center` environment (the environment form of `\centering`) around a verbatim line |
| verbatim and inline code | turnthepage.tex:33-35, 41-45, 49-51, 80-86 | `code.verbatim` | `verbatim`, `\verb|..|` |
| emphasis | turnthepage.tex:12, 31, 39, 42-45 | `mark.kernel` | `\textbf`, `\textit` |
| index entries | turnthepage.tex:4, 41-45 | `idx.makeidx` | `\makeindex` in the preamble; `\index{\texttt{short}}` and four more; run with makeindex (README:62) |
| index print | turnthepage.tex:110-111 | `idx.makeidx` | `\@input@{\jobname.ind}`; reduces to `\printindex` (see Bespoke code) |
| labels | turnthepage.tex:38, 57, 116 | `xref.kernel` | `\label{subsec:ao}`, `\label{sec:vh}`, `\label{biblio}`; no `\ref` is used in the body |
| citations and bibliography | turnthepage.tex:97, 99, 114-117; turnthepage-bib.bib:1-8 | `bib.bibtex-bst` | `\cite{mvd1}`, `\cite{ps}`, `\nocite{*}`, style `siam` (a standard BibTeX style name; `siam.bst` is not in the zip, I did not check the TeX tree), file `turnthepage-bib`, two `@misc` entries; bibtex run (README:63) |
| inline maths | turnthepage.tex:10, 54 | `math.kernel` | `$\epsilon$`, `$\geq$`: content |
| text-level kernel commands | turnthepage.tex:20-24, 54 | none needed (content) | `\LaTeX`, `\TeX`, `\ldots`, accents `\"u`: logo and punctuation text, no template effect |
| header/footer | not set | `hf.pagestyle-kernel` (class default `plain`) | no `\pagestyle` call; the page number stays in the default footer, the note sits at the right edge below the text block |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\providecommand{\etex}{$\epsilon$-\TeX}` | turnthepage.tex:10 (used at 54-55, 68-69, 72, 76, 78, 88, 98) | yes | an alias for inline text; expand at each use: `$\epsilon$-\TeX` (`math.kernel` inline plus a kernel logo), no counter or conditional |
| `\makeatletter\@input@{\jobname.ind}\makeatother` | turnthepage.tex:111 | yes | `\usepackage{makeidx}` and `\printindex` (`idx.makeidx`); to my knowledge `\printindex` is the same one-line `\@input@{\jobname.ind}`, but I did not read makeidx.sty here (no TeX tree on the machine) |
| `turnthepage.sty`, `turnpageetex.sty`, `turnpagewoetex.sty` (option dispatch, shipout hook, odd and not-last test, page counters) | turnthepage.sty:16-27; turnpageetex.sty:36-44; turnpagewoetex.sty:39-72 | n/a: published | These are the CTAN package, the way `hf.turnthepage` itself (W1 settled by ctan.org/pkg/turnthepage). The emitter prints the `\usepackage` line and never copies the code. Dependencies are published too: `picture`, and for old formats `atbegshi`, `everyshi`, `atveryend` (README:77-79; turnpagewoetex.sty:34-37). Oddity noticed, no effect on the verdict: turnpageetex.sty:2 calls itself `\ProvidesPackage{turnthepage}`. |

## Content-opaque
none

## Lib changes
- New ways proposed: `hf.turnthepage` - `turnthepage` (CTAN, TeX Live, LPPL 1.3c; Merciadri, van Dongen, Muench): `\usepackage[english]{turnthepage}`, options `short` `english` `francais` `nederlands` `deutsch` (one message each, closed list), message text in the redefinable command `\turnthepage`; prints that message at the bottom right of every odd physical page except the last, through a shipout background hook (needs `picture`; on formats before 2024-06-01 it falls back to `atbegshi`, `everyshi`, `atveryend`); pdfLaTeX-compatible. W1: on CTAN and in TeX Live (ctan.org/pkg/turnthepage; README:42-43). W2: chosen by an option and a string. W3: serves any twoside document (exam papers, handouts), not one document. W4: one preamble line, no body wrapper. Not `hf.fancyhdr` (its fields would need a hand-written `\ifnum` against the last page and replace the footer, not add a note beside it), not `bg.eso-pic` (free overlay material, the odd-and-not-last test would be hand-written), not `hf.extramarks` (marks read into head fields). Filed under `hf` because the note lives in the footer area (position `\footskip` below the text block, right edge, turnpageetex.sty:39-41).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
