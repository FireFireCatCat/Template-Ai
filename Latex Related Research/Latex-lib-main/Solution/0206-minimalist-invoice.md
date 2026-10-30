yes

# 0206-minimalist-invoice: Minimalist Invoice

- Unverified: read from the source, not compiled.
- Source: Source/0206-minimalist-invoice/ (origin: https://latextemplates.com/downloads/minimalist-invoice.zip; licence: not established (manifest: "Unknown (not stated in research source)"; README.md:11-14 says the upstream licence was not exposed and the starter is newly written))
- Kind: invoice
- Lib: v2
- Engine: pdfLaTeX-compatible (README.md:7 "Compile with PDFLaTeX"; `inputenc` + `fontenc` T1 at main.tex:3-4, no `fontspec`)
- Look carried by: preamble (the whole look is in main.tex: preamble at lines 1-23 plus hand-laid `tabularx` tables in the body; the zip has no `.cls`, `.sty` or other zip-local file, README.md:5 says it does not rely on a custom class)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The invoice is the kernel `article` class plus eleven published packages, and every body construct is a `tabularx`/`tabular` table, a kernel `\rule`, `\colorbox`/`\parbox`, or a font and spacing command. The sample defines no `\newcommand`, `\def`, environment, counter or conditional, and uses no TikZ or other drawing. The coloured top band is a kernel `\rule` (`sp.rule`), not artwork. Nothing needs a tool outside TeX.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:1)
- Class-native vocabulary used: none beyond kernel `\documentclass`, `document`, and `flushright` (main.tex:45). No `\maketitle`, `abstract`, `\section`, lists, floats, captions or bibliography.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | a4paper |
| paper size | main.tex:1 | `page.class-options` | a4paper |
| page geometry | main.tex:2 | `page.geometry` | margin=1.7cm (all four sides) |
| encodings | main.tex:3-4 | `font.fontenc-t1` | fontenc T1; inputenc utf8 |
| text font | main.tex:5 | `font.lmodern` | `lmodern` (the only font package; no family-default change) |
| colour definitions | main.tex:6, 14-16 | `color.xcolor` | `xcolor` option `table`; `\definecolor` model HTML: ink=243447, mist=EEF2F5, accent=2F7D78 |
| coloured text and cells | main.tex:25, 27, 39 | `color.xcolor` | `\color{accent}`, `\color{ink}`, `\color{white}` as switches inside groups and cells |
| top accent band | main.tex:25 | `sp.rule` | `\noindent{\color{accent}\rule{\linewidth}{4pt}}\\[10pt]`; width `\linewidth`, height 4pt, colour via `xcolor` |
| invoice header row (title left, number and date right) | main.tex:26-29 | `tbl.tabularx` | `\begin{tabularx}{\linewidth}{@{}Xr@{}}`; right cell is a nested `tabular{r}` (main.tex:28, `tbl.tabular`) |
| header title text | main.tex:27 | `font.size-commands` | `\Huge` |
| bold and colour of title, labels | main.tex:27-28, 32, 34, 39, 47, 50 | `mark.kernel` | `\bfseries`, `\textbf` |
| sender / recipient block | main.tex:31-35 | `tbl.tabularx` | `{@{}X X@{}}`, two cells, lines separated by `\par`; mailto link is `meta.hyperref` (main.tex:32) |
| item table | main.tex:38-43 | `tbl.tabularx` | `{@{}>{\raggedright\arraybackslash}X r r r@{}}`; column spec uses `array` (`>{}` , `@{}`), main.tex:9 |
| item table, left-aligned wide column | main.tex:38 | `sp.ragged` | `\raggedright` plus `\arraybackslash` inside the `>{}` column hook |
| item table, header row fill | main.tex:39 | `tbl.colortbl` | `\rowcolor{ink}` with white bold text |
| item table, zebra rows | main.tex:37 | `tbl.colortbl` | `\rowcolors{2}{white}{mist}` (start row 2; odd white, even mist). The declaration sits outside any group, so it stays active for later tables (see Notes) |
| totals block alignment | main.tex:45-48 | `sp.ragged` | `flushright` environment around a `tabular{lr}` (`tbl.tabular`) |
| totals rule above TOTAL | main.tex:8, 47 | `tbl.booktabs` | one `\toprule` in the middle of the tabular, after `\\[-2pt]` (`sp.manual-space`) |
| TOTAL row type size | main.tex:47 | `font.size-commands` | `\Large` with `\textbf` |
| table cell padding | main.tex:23 | `sp.lengths` | `\setlength{\tabcolsep}{7pt}` |
| payment-terms panel | main.tex:50 | `box.fancybox` | `\colorbox{mist}{...}` (same family as `\fcolorbox`) |
| panel inner width | main.tex:50 | `box.minipage` | `\parbox{\dimexpr\linewidth-2\fboxsep\relax}{...}`; the width is a length expression, `\dimexpr` is e-TeX length arithmetic, not macro logic |
| panel inner spacing | main.tex:50 | `sp.manual-space` | `\quad`, `\\[3pt]` |
| vertical gaps between blocks | main.tex:25, 30, 36, 44, 46, 51 | `sp.manual-space` | `\vspace{14pt}`, `{18pt}`, `{8pt}`, `{10pt}`, `\\[10pt]`, `\\[-2pt]` |
| push payment panel to page foot | main.tex:49 | `sp.manual-space` | `\vfill` (kernel stretchable glue, the vertical counterpart of `\hfill`) |
| closing line type size | main.tex:52 | `font.size-commands` | `\small` after `\noindent` (see Notes on `\noindent`) |
| running footer | main.tex:11, 17-22 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}` (clears all fields), `\fancyfoot[L]{Harbor Light Studio · invoice 2026--042}`, `\fancyfoot[R]{\thepage\ / \pageref{LastPage}}`, `\headrulewidth` 0pt, `\footrulewidth` 0.3pt (both via `\renewcommand`) |
| page X of Y | main.tex:10, 20 | `pgnum.lastpage` | `lastpage` package, label `LastPage` |
| page reference | main.tex:20 | `xref.kernel` | `\pageref{LastPage}` |
| PDF links | main.tex:12-13, 32 | `meta.hyperref` | `hidelinks`; `\href{mailto:...}{...}` |
| title block | main.tex:25-29 | (none) | no `\title`/`\maketitle`; the header is the hand-laid table above, so `front.*` ways are not used |

Components the sample does not use: sectioning, lists, quotes, notes and footnotes, math, theorems, floats and captions, code, bibliography, index, table of contents, abstract.

## Bespoke code
none. The sample has no `\newcommand`, `\renewcommand` of a zip-defined macro, `\def`, `\newenvironment`, `\newcounter` or `\if...`. Its only `\renewcommand` calls (main.tex:21-22) set the kernel/`fancyhdr` rule widths `\headrulewidth` and `\footrulewidth`, which are `hf.fancyhdr` parameters.

## Content-opaque
none

## Lib changes
- New ways proposed: none. (Considered `inv.simpleinvoice`: it is not used here, the invoice is built from `tabularx`; nothing else lacked a home.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The zip is a catalogue starter whose README (README.md:9) points to an upstream GitLab project that is not bundled. That upstream was not read and nothing here depends on it.
- The README contains no text addressed to an AI; nothing was ignored.
- `\rowcolors` (main.tex:37) is not inside a group, so by the xcolor `table` documentation as I read it, it stays active for the later `tabular{lr}` at main.tex:45 and would shade that table's even rows with `mist`. An emitter has to write the declaration at the same scope. This is a parameter-scope detail of `tbl.colortbl`, not bespoke code. Not compiled, so not measured.
- `\noindent` (main.tex:25, 50, 52) is a kernel paragraph-start primitive with no lib line; the nearest home is the `\parindent` family of `sp.lengths`. It is a trivial body wrapper the emitter writes verbatim and is not proposed as a way.
- The item table header row sets `\color{white}` in each cell (main.tex:39); these are `color.xcolor` switches, nothing more.
- Missing assets: none (no images, no fonts shipped or needed beyond `lmodern`).
