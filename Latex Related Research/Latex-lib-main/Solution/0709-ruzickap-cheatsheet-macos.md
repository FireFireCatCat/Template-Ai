yes

# 0709-ruzickap-cheatsheet-macos: macOS Cheatsheet (ruzickap/cheatsheet-macos)

- Unverified: read from the source, not compiled.
- Source: Source/0709-ruzickap-cheatsheet-macos/ (origin: https://codeload.github.com/ruzickap/cheatsheet-macos/zip/refs/heads/main; licence: Apache-2.0 per the manifest; the vendored Makefile is MIT, Makefile:6-28)
- Kind: misc (a keyboard-shortcut cheat sheet / reference card: six two-column tables flowing in two text columns; the manifest hint is also `misc`)
- Lib: v5
- Engine: pdfLaTeX-compatible (the repo's own Makefile selects `TOOLCHAIN = pdflatex`, Makefile:99; no `fontspec`, no Lua)
- Look carried by: preamble (plain `article` class; the look is the preamble's package set and the four raw page-length edits at macos_cheatsheet.tex:23-26, plus the body's `multicols`/`tabular` structure)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip; the zip holds no `.cls`, `.sty`, `.cfg` or other TeX-family file besides the one `.tex`)
- Main file: macos_cheatsheet.tex (other samples: none)
- Read: main yes (all 180 lines), zip-local classes and styles none present

## Verdict
Yes. The whole template is one 180-line `.tex` under the kernel `article` class. It loads only published packages (`xcolor[table]`, `multicol`, `booktabs`, `menukeys`, `hyperref`), changes the page by four `\addtolength` calls on kernel page lengths, and puts six tables with keyboard-key markup inside a two-column `multicols`. The sample defines no macro, environment, counter, conditional or drawing, so there is no bespoke code and no `ART`. The Makefile, `run.sh` and CI files only build and convert the PDF; they do not produce any `.tex`, so they are not an `EXTERNAL` blocker. The one point of residual doubt is the `menukeys` source, which is not in the zip and was not read (see Class setting and Lib changes).

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (macos_cheatsheet.tex:1); default 10pt, one column, `oneside`. Source of `article` not read (kernel class, not in the zip).
- Class-native vocabulary used: none of the class's own front-matter or sectioning commands are used. `\title` is declared (macos_cheatsheet.tex:19) but `\maketitle`, `\section`, `abstract` and `\bibliography` are never called; the only class-supplied constructs are `center` and `tabular` (kernel).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | macos_cheatsheet.tex:1 | `class.article` | `a4paper` |
| paper size | macos_cheatsheet.tex:1 | `page.class-options` | `a4paper` |
| page margins and text block | macos_cheatsheet.tex:23-26 | `page.setlength` | `\addtolength{\voffset}{-4.3cm}`, `\addtolength{\textheight}{7.9cm}`, `\addtolength{\hoffset}{-3.7cm}`, `\addtolength{\textwidth}{8.1cm}` (relative edits of the article/a4paper defaults, same kernel length-parameter family as `\setlength{\textwidth}`) |
| header and footer | macos_cheatsheet.tex:21 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (no running head, no page number) |
| colour package | macos_cheatsheet.tex:3 | `color.xcolor` | option `table`; gray model colour `[gray]{.8}` used at the header rows |
| columns | macos_cheatsheet.tex:4, 37, 177 | `cols.multicol` | `\begin{multicols}{2}` ... `\end{multicols}`, 2 columns, default `\columnsep`, no rule |
| block alignment wrapper | macos_cheatsheet.tex:31, 179 | `sp.ragged` | kernel `center` environment (the environment form of `\centering`) around the whole body; the tabulars inside are narrower than a column, so they are centred in it |
| font size | macos_cheatsheet.tex:35 | `font.size-commands` | `\small` inside the `center` environment, before `multicols` |
| tables: container | macos_cheatsheet.tex:39, 73, 85, 102, 114, 139 | `tbl.tabular` | six `tabular` environments, column spec `*{2}{l}` (two left-aligned columns, `array`-style repeat); no float, no `\caption`, no `\label` |
| tables: rules | macos_cheatsheet.tex:5, 40-42, 70 (and the same pattern in each table) | `tbl.booktabs` | `\toprule`, `\midrule` after every row, `\bottomrule`; default `booktabs` rule widths |
| tables: header row shading | macos_cheatsheet.tex:41, 75, 87, 104, 116, 141, 167 | `tbl.colortbl` | `\rowcolor[gray]{.8}` (via `xcolor[table]`); a second header row `MC edit keys` sits inside the last tabular at macos_cheatsheet.tex:167-168 |
| keyboard-key markup | macos_cheatsheet.tex:7, 43-165 | `mark.menukeys` | `\usepackage[mackeys=text]{menukeys}`; body `\keys{...}` around key combinations; key-name commands `\cmd` `\Alt` `\shift` `\ctrl` `\tab` `\esc` `\enter` `\return` `\backdel` `\SPACE` `\arrowkeyleft` `\arrowkeyright` `\arrowkeyup` `\arrowkeydown` (e.g. macos_cheatsheet.tex:43, 50, 61, 63-64, 79); the `mackeys=text` option makes the Mac keys print as text |
| font switch inside keys | macos_cheatsheet.tex:91, 164, 165 | `mark.kernel` | `\texttt{-}`, `\texttt{+}`, `\texttt{*}` inside `\keys{}` |
| link and PDF metadata | macos_cheatsheet.tex:9-17 | `meta.hyperref` | `citecolor=red`, `backref`, `bookmarks`, `pdfpagemode=None`, `pdftitle={macOS Cheatsheet}`, `pdfauthor={Petr Ruzicka}`, `pdfsubject={macOS Cheatsheet}`, `pdfkeywords={macOS Cheatsheet, Refcard, Cheat Sheet, macOS, mc, }`, `pdfview=FitB`; `colorlinks` is not set; `backref` and `citecolor` have no visible effect because the sample has no citation or bibliography |
| title declaration | macos_cheatsheet.tex:19, 33 | `front.maketitle` | `\title{macOS Cheatsheet}` only; `\maketitle` is never called and the title line in the body is commented out (`% {\huge macOS Cheatsheet}`, macos_cheatsheet.tex:33), so no title block is printed |

Components checked and absent (no way needed): abstract, headings and numbering, contents, lists, quotes, notes and footnotes, math and theorems, figures, captions and floats, code listings, boxes, bibliography and index, cross-references, header and footer fields, fonts (Computer Modern default, no font package), language (no `babel`), background and artwork (no `tikz` or `picture`).

Literal characters inside key labels (`\{`, `\}` at macos_cheatsheet.tex:65; `\textbackslash` at macos_cheatsheet.tex:123, 131) are content (a character to print), not a template component.

## Bespoke code
none. The sample contains no `\newcommand`, `\renewcommand`, `\def`, `\let`, `\newenvironment`, `\newcounter` or `\newif` (a search for these found only `\usepackage` at macos_cheatsheet.tex:3-9 and `\addtolength` at macos_cheatsheet.tex:23-26). The zip has no `.cls`, `.sty`, `.def`, `.cfg`, `.clo`, `.bst`, `.dtx` file.

Build and repository files (not template, listed so nothing is hidden): `Makefile` (vendored makefile4latex 0.11.1, Makefile:31; default `TOOLCHAIN = pdflatex`, Makefile:99), `run.sh` (Docker wrapper, targets `jpg pdf png svg mostlyclean`, run.sh:11), `.github/workflows/*`, linter configs, `AGENTS.md`. They compile and post-process the one `.tex`; none writes or generates `.tex` content, so they do not trigger `EXTERNAL`.

## Content-opaque
none

## Lib changes
- New ways proposed: none. Every component maps to an existing v5 way. Considered and not needed: `NEW` ways for the key-name commands (they belong to `mark.menukeys`, a package already in the lib; the lib line names `\keys{}` and the `os` option as examples, and `mackeys=text` is another option of the same package).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this).

## Notes
- W1 check for `menukeys`: one read of https://ctan.org/pkg/menukeys says it is on CTAN, in TeX Live and MiKTeX, LPPL 1.3c, "designed to format menu sequences, paths and keyboard shortcuts". The page names no `mackeys` option and no key-name commands, so the option `mackeys=text` (macos_cheatsheet.tex:7) and the key-name commands in the body are taken from the sample; the package source was not read. They are used as commands of a published package, and the sample defines none of them itself.
- Text addressed to an AI: `AGENTS.md:3-4` is a file of build and commit guidance for "AI agents working in this repo" (Docker build, commit conventions). It was quoted here and ignored; it does not affect the analysis.
- Missing assets: none; the sample includes no image or font file.
