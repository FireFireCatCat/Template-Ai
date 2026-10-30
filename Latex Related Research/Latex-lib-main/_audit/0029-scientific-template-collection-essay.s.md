refuted=false

# 0029-scientific-template-collection-essay: skeptic audit (read-only, nothing compiled)

Analyst verdict under review: `yes`. Result: could not refute it.

## What I searched

- Whole zip: `ls -la` shows exactly two files, `README.md` (12 lines) and `main.tex` (78 lines). `_Manifest.tsv:30` agrees (files=2, main=main.tex, docclass=article, local_class empty, licence MIT). No hidden files, no `.cls`/`.sty`/`.bib`/image/script.
- `file` reports both files as plain ASCII; no non-ASCII, no tabs, no control characters, so no hidden text and nothing addressed to an AI.
- grep of `main.tex` for `\def \newcommand \renewcommand \let \input \include \write \immediate \catcode \makeatletter \patchcmd \xpatchcmd \AtBeginDocument \newcounter \setcounter \newif tikz minted shell lstinputlisting bibliography`: only hits are the five `\usepackage` lines (main.tex:4-8). No kernel-internal redefinitions, no custom counters or conditionals, no output routine, no TikZ/picture/PSTricks, no `\write18` or minted, no preprocessor.
- Packages loaded: `geometry` (main.tex:4), `amsmath` (5), `booktabs` (6), `microtype` (7), `hyperref` (8). All five are in the analyst's component map and all five are on CTAN. No package is missing from the map.
- Ways named by the analyst checked in `_Lib.md`: `class.article` (:29), `page.class-options` (:64), `page.geometry` (:65), `sp.ragged` (:112), `sp.microtype` (:113), `sp.manual-space` (:117), `meta.hyperref` (:177), `xref.kernel` (:184), `front.maketitle` (:194), `abs.kernel` (:201), `head.kernel` (:221), `math.amsmath` (:266), `tbl.tabular` (:299), `tbl.booktabs` (:302), `cap.kernel` (:308). All exist and say what the analyst uses them for.

## Citations compared with the source (18 checked, 0 wrong)

main.tex:3 (`article`, `11pt,a4paper`), :4 (`geometry`, `margin=2.7cm`), :5, :6, :7, :8 (the four other `\usepackage`; hyperref last, no `\hypersetup` anywhere), :10-12 and :15 (`\title`, `\author`, `\date{\today}`, `\maketitle`), :11 (`\\` inside `\author`), :17-21 (`abstract`), :23/:31/:42/:64/:72 (five `\section`), :34-38 (inline `$T_0$ $T_1$` on 34, `equation` 36-38), :43 (`Table~\ref{tab:results}`), :47-62 (`table[ht]`), :48 (`\centering`), :49 (`\caption` above tabular), :50 (`\label`), :51 (`{lrrr}`), :52/:54/:60 (`\toprule \midrule \bottomrule`), :14-78 (body), README.md:11 (MIT), README.md:11-12 (PDFLaTeX). Also "78-line main.tex" matches `wc -l`.

Only imprecision: "main.tex:53-59 table cell values" also spans the `\midrule` on line 54 (header row is 53, data rows 55-59). Harmless, not counted as wrong.

## Nits (none is a blocker under the rubric)

- The file says `Lib: v1`; `_Lib.md` header now reads v2. Every way the file uses exists in both, so nothing changes.
- `\\` in `\author` is mapped to `sp.manual-space`, whose lib line is about `\\[len]` set by lengths. It is a bare line break inside the author argument, i.e. content-level. Nearest home is fine.
- The `table` float wrapper and its `[ht]` specifier have no lib line of their own; the file folds them into `tbl.tabular` (kernel `tabular`). `fig.placement` (`_Lib.md:297`) is about `placeins` and placement parameters, not the `[ht]` spec. Weak spot in the lib's wording, not a missing way.
- `Look carried by: mixed` is defensible (margin change via `geometry` is in the preamble). A stricter reading of the rubric's "class-carried" ruling could call it `class` plus option-level packages; this affects only how the summary counts it, not the verdict.
- The analyst already says this is near-stock `article`, so it is weak evidence for component ways beyond the common ones. Agreed.

## Conclusion

No zip-local code, no artwork, no external tool, no unmapped component, no wrong citation found. Rubric's own test ("could an emitter write this preamble and body using only published packages and kernel commands, with no copied zip-local macro logic?") is answered yes by main.tex:3-8 and the body at main.tex:14-78. `yes` stands.
