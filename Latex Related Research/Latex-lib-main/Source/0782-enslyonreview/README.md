# ENSLyonReview — LaTeX class for the ENS de Lyon M2 Biosciences bibliographic review

**Version 1.1** \| **License: LPPL 1.3c** \| **Author: Adama Mbaye**

A LaTeX2e class for the "Analyse bibliographique" review of the M2 Biosciences Master at ENS de Lyon (tracks: Biosciences, Biosciences-Santé, Biosciences et modélisation des systèmes complexes), in the Current Opinion journal format. Sibling package to [`enslyonstage`](https://ctan.org/pkg/enslyonstage) (M1/M2 internship reports).

It reproduces, in LaTeX, the reference LibreOffice template `review_M2.ott` supplied by F. Roudier (UE coordinator): title block, two-column body, running header/footer, figure/table/box, and an annotated reference list.

See `enslyonreview.pdf` (the full user guide — compiled from `enslyonreview.tex`, French) for detailed usage.

## Usage

``` latex
\documentclass{enslyonreview}                % official theme (default)
\documentclass[blue]{enslyonreview}          % named colour theme
\documentclass[palatino]{enslyonreview}      % Palatino instead of newtx (Times)
\documentclass[xcharter]{enslyonreview}      % Charter instead of newtx (Times)
\documentclass[stix]{enslyonreview}          % STIX Two instead of newtx (Times)
```

Start from `enslyonreview-gabarit.tex`. See `enslyonreview-exemple.tex` for a fully worked example exercising every feature (figure, table, box, list, annotated references). It reproduces, in full and verbatim (text, figures, table, all 50 references), "Antiviral restriction factors in immunity and disease" by Erika Larrahondo Rodríguez (M2 Review, Dec 2024) — the finished-document example F. Roudier already circulates alongside `review_M2.ott` — so the class can be checked page-for-page against a real, previously produced review. Authorship stays attributed to her in the title block; she has agreed to her work being distributed as this package's worked example.

## Compilation

Requires **pdfLaTeX + biber** (citations are real biblatex `\cite`s, not typed bracket numbers):

```         
pdflatex enslyonreview-gabarit
biber    enslyonreview-gabarit
pdflatex enslyonreview-gabarit
pdflatex enslyonreview-gabarit
```

On Overleaf: set the compiler to `pdfLaTeX` and the bibliography tool to `biber` (Menu → Compiler / Bibliography).

## Writing your reference list

References live in a `.bib` file (`references.bib` for the gabarit, `enslyonreview-exemple.bib` for the worked example — see that file's header comment for the exact field conventions: how to write author initials, and the custom `pmid`/`pmcid` fields). Cite with `\cite{key}` anywhere in the text — numbers are assigned automatically in first-appearance order and compress into ranges like `[8-10]`, exactly like the source `CurrentOpinion_w_DOI_PMID_PMCID.csl` Zotero style. Zotero's "Export Items… → BibTeX" gives you a ready-to-use `.bib` directly (hand-add `pmid`/`pmcid` afterwards if you want them shown — Zotero doesn't export those).

End the print call with `\printbibliography[title=References]` (or `title=References and recommended reading` to match the `.ott`'s suggested heading instead — that's the default if you omit `title=`). The "of special/outstanding interest" legend is inserted automatically.

### Marking a reference "of special/outstanding interest"

This is declared from the **.tex file**, not the `.bib` — a plain Zotero export doesn't carry it, and re-exporting later would silently wipe it if it had been hand-added to the `.bib`. Anywhere before `\printbibliography` (conventionally right under `\addbibresource`):

``` latex
\refspecialinterest{someCiteKey}{Why this paper matters.}      % •  of special interest
\refoutstandinginterest{otherCiteKey}{Why this one matters more.}  % •• of outstanding interest
```

The bullet + italic annotation is then inserted automatically right under that reference wherever it prints, keyed by citation key — no need to touch the driver or the `.bib` again if you re-export from Zotero.

Refer to a figure, table or box with `\cref{label}` / `\Cref{label}` (capitalised at the start of a sentence) instead of typing "Fig. 1" or "Table 1" by hand — it stays correct if you reorder things, and it's a clickable link. Use `\crefcolor{label}` / `\Crefcolor{label}` instead for the same reference in bold, theme-coloured text (matching the citation brackets' styling).

## Files

| File | Description |
|----------------------|--------------------------------------------------|
| `enslyonreview.cls` | The LaTeX class |
| `enslyonreview.dbx` | Biblatex data-model extension (declares the `pmid`/`pmcid`/`interest`/`interestnote` fields) — required, keep next to the `.cls` |
| `enslyonreview-gabarit.tex` | Blank review template |
| `references.bib` | Starter bibliography database for the gabarit |
| `enslyonreview-exemple.tex` | Fully worked example |
| `enslyonreview-exemple.bib` | The 50 references cited in the worked example |
| `enslyonreview.tex` / `.pdf` | Full user guide (French), built from source |
| `README.md` | This file |
| `LICENSE` | LPPL 1.3c |

## Colour themes (23)

`orange` (default, official — review_M2.ott's own rust/peach) · `orangeens` (official ENS de Lyon institutional orange, same as enslyonstage's default) · `violet` · `blue` · `red` · `green` · `teal` · `gray` · `navy` · `indigo` · `purple` · `pink` · `crimson` · `amber` · `gold` · `lime` · `forest` · `cyan` · `azure` · `slate` · `brown` · `wine` · `midnight`

## Known limitations

- The header/footer colour bars span the text width, not a full paper-edge bleed (avoids extra image assets — visually equivalent, not pixel-identical to `review_M2.ott`).
- Clicking the in-PDF link to a `Box` cross-reference may not always jump to the right place in some PDF viewers (cosmetic `hyperref`/custom-float quirk); the printed number and text are always correct.
- No `biber`/`.bib` file handy? A manual fallback still exists: `\bibref{}{} {}{}{}{}` + `\bibdoi`/`\bibpmid`/`\bibpmcid` inside a `\begin{references}...\end{references}` list, with `\ofspecialinterest{}`/ `\ofoutstandinginterest{}` for annotations. Citations then aren't clickable/auto-numbered, so `\cite` + biblatex is the recommended path.

## License

Copyright (C) 2026 Adama Mbaye. Released under the LaTeX Project Public License v1.3c or later. See `LICENSE` or <https://www.latex-project.org/lppl/lppl-1-3c/>
