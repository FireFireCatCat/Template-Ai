yes

# 0478-jpeisenbarth-srs-tex: SRS-Tex (Software Requirements Specification, IEEE style)

- Unverified: read from the source, not compiled.
- Source: Source/0478-jpeisenbarth-srs-tex/ (origin: https://codeload.github.com/jpeisenbarth/SRS-Tex/zip/refs/heads/master; licence: GPL-3.0, LICENSE:1-2 and srs.tex:1-10)
- Kind: report
- Lib: v4
- Engine: pdfLaTeX-compatible (the Makefile builds with xelatex, Makefile:1-3, but nothing in srs.tex needs it: scrreprt, listings, underscore, hyperref, inputenc, babel)
- Look carried by: mixed (KOMA `scrreprt` defaults give headings and contents; srs.tex:24-36 sets hyperref colours and PDF metadata; the cover page is laid out by hand in the body, srs.tex:45-62)
- Class origin: tex-distribution-unbundled
- Main file: srs.tex (other samples: none; the zip is srs.tex, Makefile, README.md, LICENSE)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The zip is one 320-line sample on the published KOMA class `scrreprt` with no zip-local class, style or option file. Every preamble line is a published package (`listings`, `underscore`, `hyperref`, `inputenc`, `babel`) and every body construct is a kernel command (sectioning, `tabular`, `flushright`, `\rule`, `\vspace`, size and font switches). The one `\def` is a single-use text macro that reduces by inline expansion, there is no drawing, and the Makefile only calls xelatex (it generates no `.tex`). `underscore` has no home in the lib, so one new way is proposed (it passes W1 to W4).

## Blockers
none

## Class setting
- Class: `class.scrreprt` options: none (srs.tex:18). The class source is not in the zip and was not read (KOMA-Script ships with the TeX distribution).
- Class-native vocabulary used: `\chapter`, `\chapter*`, `\section`, `\subsection` with the KOMA report default look; `\tableofcontents` (KOMA contents with its default entries). No `\setkomafont`, `\KOMAoptions`, `\subject`, `\publishers`, `\titlehead`, `\addchap`, `abstract` or `titlepage` use.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | srs.tex:18 | `class.scrreprt` | no options (class defaults for paper, size, margins, running heads) |
| page geometry, columns, header/footer, spacing, fonts, colour (document-wide) | srs.tex:18-43 | none set | nothing is set in the preamble; all come from `class.scrreprt` defaults (no geometry, no pagestyle, no font package, no `\color`) |
| input encoding | srs.tex:22 | `font.fontenc-t1` | `inputenc` with option `utf8` (no `fontenc` line) |
| language | srs.tex:23 | `lang.babel` | language `english` |
| text-mode underscore | srs.tex:20 | `sp.underscore` | `underscore` package, no options; load-only, no `_` appears in the sample body |
| code listings (loaded, unused) | srs.tex:19 | `code.listings` | `\usepackage{listings}`, no `\lstset`, no `lstlisting` or `\lstinline` in the body |
| PDF metadata and link colours | srs.tex:21, 24-36 | `meta.hyperref` | load option `bookmarks=true` (21), then `\hypersetup`: `bookmarks=false` (25, last value wins), `pdftitle={Software Requirement Specification}` (26), `pdfauthor={Jean-Philippe Eisenbarth}` (27), `pdfsubject={TeX and LaTeX}` (28), `pdfkeywords={TeX, LaTeX, graphics, images}` (29), `colorlinks=true` (30), `linkcolor=blue` (31), `citecolor=black` (32), `filecolor=black` (33), `urlcolor=purple` (34), `linktoc=page` (35); a second plain `\usepackage{hyperref}` at 42 loads nothing new |
| date field | srs.tex:38 | `front.maketitle` | `\date{}` set, but `\maketitle` is never called, so it prints nothing; `\today` on the cover (60) is the kernel date command of the same family, printed in the babel `english` format |
| cover block alignment | srs.tex:45, 62 | `sp.ragged` | `flushright` environment around the whole cover |
| cover top rule | srs.tex:46 | `sp.rule` | `\rule{16cm}{5pt}` then `\vskip1cm` |
| cover vertical gaps | srs.tex:46, 49, 51, 53, 55, 57, 59 | `sp.manual-space` | `\vskip1cm`, `\vspace{1.9cm}` (six times), `\\` line breaks |
| cover bold text | srs.tex:47, 61 | `mark.kernel` | `bfseries` used in its environment form, `\begin{bfseries}` ... `\end{bfseries}` |
| cover type sizes | srs.tex:48, 54 | `font.size-commands` | `\Huge{SOFTWARE REQUIREMENTS\\ SPECIFICATION}`, `\LARGE{Version ... approved}` |
| cover as front matter | srs.tex:45-62 | composed from `sp.ragged`, `sp.rule`, `sp.manual-space`, `font.size-commands`, `mark.kernel` | a plain body block, not a `titlepage` environment (so `front.titlepage-env` is not used); there is no explicit `\newpage`, so what follows the cover is decided by the KOMA defaults of `\tableofcontents` (class source not read) |
| table of contents | srs.tex:64 | `toc.kernel` | `\tableofcontents`; link style from `meta.hyperref` `linktoc=page`; no `tocdepth` change |
| unnumbered chapter | srs.tex:67 | `head.kernel` | `\chapter*{Revision History}` (starred, so no number and no contents entry) |
| numbered headings | srs.tex:81, 83, 229 (35 numbered heading lines in all: 6 `\chapter`, 26 `\section`, 3 `\subsection`) | `head.kernel` | `\chapter`, `\section`, `\subsection`; no `secnumdepth`, no `\titleformat`, no `\renewcommand` of a heading |
| appendix | srs.tex:304-316 | `head.kernel` | "Appendix A: Glossary" and so on are `\section` titles with the letter typed in the text; no `\appendix` (so no `num.appendix`) |
| revision table | srs.tex:69-79 | `tbl.tabular` + `sp.ragged` | `center` environment, `tabular` with column spec `{|c|c|c|c|}`, `\hline` rules; no booktabs, no `\caption`, no float |
| inline angle brackets | srs.tex:52, 56, 58, 84 (and so on) | content | `$<$` and `$>$` math-mode signs inside text; template prompt text, not a template construct |

No list, theorem, figure, caption, footnote, bibliography, index, code block, box or cross-reference (`\label`, `\ref`, `\cite`) appears in the sample body (checked by reading srs.tex:1-320).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\myversion{1.0 }` | srs.tex:37, used once at srs.tex:54 | yes | a text macro with no arguments, no conditional and no counter; expand inline to the text `1.0 ` in the `\LARGE` line (content) |
| Makefile (`xelatex srs.tex` twice, then `rm` of aux files) | Makefile:1-10 | yes (not a blocker) | a build driver only: it generates no `.tex` and calls no tool outside TeX; the engine named there is not required by the source |

## Content-opaque
none

## Lib changes
- New ways proposed: `sp.underscore` `underscore` (CTAN, in TeX Live and MiKTeX; Donald Arseneau, LPPL 1.3, read at ctan.org/pkg/underscore), pdfLaTeX-compatible: `\usepackage{underscore}` makes `\_` print an underscore in text mode without blocking hyphenation next to it, with one option that sets the hyphenation point after the underscore. W1: on CTAN. W2: behaviour is an option, not edited code. W3: serves any text that holds identifiers, not one document. W4: one preamble line. A load-only text-character fix of the same type as `sp.ellipsis`, `code.upquote` and `math.icomma` (not `font.fontenc-t1`: that line is encodings and text symbol glyphs; not `code.verbatim`: it does not set a verbatim face). Considered: filing it under `font.fontenc-t1`; rejected because the package changes how a text character breaks and hyphenates, not how a glyph is encoded.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
