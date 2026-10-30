yes

# 0945-technics: Technics (a business and technical document template with a boxed company header)

- Unverified: read from the source, not compiled.
- Source: Source/0945-technics/ (origin: https://mirrors.ctan.org/macros/latex/contrib/technics.zip; licence: LPPL 1, technics.tex:5-8 and technics.sty:5-8, CTAN page ctan.org/pkg/technics read: Joachim Nilsson, v1.0, in TeX Live and MiKTeX)
- Kind: report
- Lib: v6
- Engine: pdfLaTeX-compatible (the author's route is latex + dvips, technics.tex:151-158; the header logo is an EPS, see Verdict)
- Look carried by: zip-local (technics.sty, which is the CTAN package itself, sets page, fonts, header block and footer; the sample preamble only sets class options and six string macros)
- Class origin: tex-distribution-unbundled
- Main file: technics.tex (other samples: none; technics.pdf is a reference render, not read: no PDF renderer here)
- Read: main yes, zip-local classes and styles all

## Verdict
yes. The whole look is one 115-line style file, `technics.sty`, that only loads published packages, sets lengths, and fills `fancyhdr` fields with a `tabular`/`minipage` header block and a footer. It contains no `\def`, no output routine, no counter or conditional that drives printed output, and no kernel redefinition, so it reduces to existing lib ways with parameters. The six `\newcommand` macros are string aliases that inline. The one tool question is the header logo: `vmlinux.eps` under pdfTeX would need a converter (lib `fig.epstopdf`, EXTERNAL when an EPS is included). It is an included-image slot, which is content, and the zip ships the same logo as `vmlinux.png` (png2eps.sh:3 builds the EPS from that PNG; vmlinux.eps:2 `%%Creator: pnmtops`), so the emitter points the slot at the PNG. If a reviewer rules that the EPS must stay, this becomes `no` with `EXTERNAL/package` and nothing else changes.

## Blockers
none

## Class setting
- Class: `class.article` options: `12pt`, `twoside` (technics.tex:14); not bundled in the zip (kernel class, source not read)
- Class-native vocabulary used: `\title` `\author` `\maketitle` (no `\date`, so the date is `\today`), `\tableofcontents`, `\section`, `enumerate`, `\footnote` (technics.tex:25-31, 38-39, 48); the `abstract` environment appears only as a comment (technics.tex:33-34)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | technics.tex:14 | `class.article` | 12pt, twoside |
| page size and font size | technics.tex:14 | `page.class-options` | `12pt`, `twoside` |
| page margins | technics.sty:17 | `page.vmargin` | `\usepackage{a4wide}`, no options (legacy margin package of the `fullpage` type; its source is not in the zip and was not read; ctan.org/pkg/a4wide read: LPPL 1, in TeX Live, depends on `a4`) |
| page lengths | technics.sty:66, 69, 70 | `page.setlength` | `\headheight`=41mm, `\addtolength{\textheight}{-30mm}`, `\addtolength{\footskip}{10mm}` |
| encodings | technics.sty:18, 20 | `font.fontenc-t1` | `[T1]{fontenc}`, `[latin1]{inputenc}` (the Swedish babel line is commented out, technics.sty:19) |
| text face | technics.sty:32 | `font.mathptmx` | `\usepackage{times}` (the other faces at technics.sty:29-31, 33-35 are comments) |
| infix lengths | technics.sty:21, 74-75 | `sp.lengths` | `calc` loaded; `\newlength{\mywidth}`, `\setlength{\mywidth}{(\textwidth/2) - 5mm}` |
| paragraph indent | technics.sty:58 | `sp.lengths` | `\parindent`=1em |
| line spacing package | technics.sty:22 | `sp.setspace` | load-only, no command of it is called in the sample |
| columns package | technics.sty:23 | `cols.multicol` | load-only, no `multicols` in the sample |
| links and metadata | technics.sty:24 | `meta.hyperref` | `\usepackage{hyperref}`, no options |
| e-mail address | technics.tex:20, 92 | `meta.url` | `\url{crash@vmlinux.org}` (command comes with hyperref) |
| running head and foot | technics.sty:26, 39 | `hf.fancyhdr` | `\pagestyle{fancy}` |
| first-page style | technics.tex:30 | `hf.pagestyle-kernel` | `\thispagestyle{fancy}` (restores the head that `\maketitle` turns off on page 1) |
| head fields | technics.sty:83-101 | `hf.fancyhdr` | `\lhead{...}` holds the header block, `\chead{}`, `\rhead{}` |
| head block layout | technics.sty:84-92 | `tbl.tabular` | `tabular{ll}` with two cells, last row empty |
| head block cells | technics.sty:85-90 | `box.minipage` | `minipage[b]{\mywidth}` twice |
| head block logo | technics.sty:86, technics.tex:18 | `fig.graphicx` | `\includegraphics{\companylogo}`, file `vmlinux.eps` (shipped also as `vmlinux.png`); default `the-one.eps` is not shipped |
| head block meta table | technics.sty:93-98 | `tbl.tabular` | `tabular{\|p{\mywidth}\|p{\mywidth}\|}`, `\hline`, 2 rows of label and value; labels Prepared by, Document, Approved by, Date |
| head block type sizes | technics.sty:88-89, 94-97 | `font.size-commands` | `\scriptsize` labels, `\normalsize` values |
| head block date | technics.sty:97 | `front.maketitle` | `\today`, the kernel print command of the `\date` family |
| foot fields | technics.sty:106-110 | `hf.fancyhdr` | `\fancyfoot[LO]` and `[RE]` = `\copyright\ \copyrightyear\ \companyname`; `[RO]` and `[LE]` = `\thepage`; `[C]` empty |
| head and foot rules | technics.sty:112-113 | `hf.fancyhdr` | `\footrulewidth`=0.4pt, `\headrulewidth`=0pt |
| graphics package | technics.sty:25 | `fig.graphicx` | `\usepackage{graphics}`, no driver option |
| title block | technics.tex:25-26, 29 | `front.maketitle` | `\title{\doctitle}`, `\author{\preparedby}`, `\maketitle` |
| contents | technics.tex:31 | `toc.kernel` | `\tableofcontents`, article defaults |
| page break | technics.tex:37 | `pg.break` | `\newpage` (the `\cleardoublepage` is commented, technics.tex:36) |
| headings | technics.tex:38, 64, 77, 86 | `head.kernel` | `\section`, article default look, no `titlesec` |
| footnote | technics.tex:39 | `fn.kernel` | `\footnote` |
| list | technics.tex:48-62 | `list.kernel` | `enumerate`, 3 items |
| emphasis | technics.tex:71 | `mark.kernel` | `\emph` |
| verbatim | technics.tex:81 | `code.verbatim` | `\verb+...+` |
| manual space | technics.tex:90 | `sp.manual-space` | `\vspace{1.5cm}` |
| centred closing | technics.tex:91 | `sp.ragged` | `\centering` set outside a group, so it holds to the end |
| commented table example | technics.tex:105-117 (after `\end{document}`, not printed) | `tbl.tabular` | `tabular{\|l\|c\|l\|}`, `\hline`; with `cap.kernel` `\caption`, `xref.kernel` `\label` |
| commented figure example | technics.tex:125-129 (not printed) | `fig.graphicx` | `figure`, `\includegraphics`; with `cap.kernel` and `xref.kernel` |
| commented bibliography example | technics.tex:134-135 (not printed) | `bib.bibtex-bst` | `\bibliography{}`, `\bibliographystyle{alpha}` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `technics.sty` as a whole | technics.sty:13-115 | yes | A fixed list of `\usepackage` lines (a4wide, fontenc, inputenc, calc, setspace, multicol, hyperref, graphics, fancyhdr, times), `\pagestyle{fancy}`, six length settings, and `\lhead`/`\fancyfoot` fields; the emitter prints them in the same order (the `\mywidth` value reads `\textwidth` after `a4wide`) |
| six string macros `\doctitle` `\preparedby` `\approvedby` `\copyrightyear` `\companyname` `\companylogo` | technics.sty:76-81; set again at technics.tex:17-22 | yes | Aliases for strings: inline the sample's values into `\lhead`, `\fancyfoot`, `\title{...}`, `\author{...}`; `fancyhdr` stores field text unexpanded, so the printed values are the sample's |
| `\newlength{\mywidth}` and its calc value | technics.sty:74-75 | yes | A declared length set with `calc` syntax (`sp.lengths`); no conditional or counter |
| header block `\lhead{...}` | technics.sty:83-99 | yes | A `fancyhdr` field holding `tabular`, `minipage`, `\includegraphics`, size switches; fixed strings, no macro logic |
| `png2eps.sh`, `view-dvi.sh` | png2eps.sh:3, view-dvi.sh:1 | not template | Shell helpers (netpbm `pngtopnm` piped to `pnmtops`, and `xdvi`); not run, not read as template; the emitter does not need them when the PNG logo is used |

## Content-opaque
none (the header logo is an included image held by `fig.graphicx`; unused asset `rf-logo.zip` holds one `rf-logo.ps`; `vmlinux.png` shows the text "vmlinux.org")

## Lib changes
- New ways proposed: none. Considered: a doc-kind way for the `technics` package itself (published, but everything it does reduces to existing ways, so none is proposed); `a4wide` read as the type of `page.vmargin`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
