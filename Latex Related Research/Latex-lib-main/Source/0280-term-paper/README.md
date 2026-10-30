# term-paper

A student term-paper report on the IEEEtran class — abstract,
sections, an appendix for supporting material, and a resolved
bibliography.

## Files

- `main.tex` — the paper. Start here.
- `references.bib` — the bibliography database.

## Building

    pdflatex main
    bibtex main
    pdflatex main
    pdflatex main

## The class is deliberately NOT included

`IEEEtran.cls` and `IEEEtran.bst` ship with every modern TeX
distribution, so this download does not bundle copies. If your
distribution does not have them: https://ctan.org/pkg/ieeetran

## Licence and attribution chain

Based on the Overleaf gallery template "Term Paper Template"
(https://www.overleaf.com/latex/templates/term-paper-template/qncvpymncwxc),
whose own source header credits a three-step chain:

- Original by **Michael Sheel**, published on the IEEEtran support
  site: http://www.michaelshell.org/tex/ieeetran/
- Modified by **Francisco Tovar**
- Further adapted for student term papers by Overleaf user **blowe**,
  "Published to Overleaf under CC BY 4.0"

This starter uses `IEEEtran.bst` (bibtex) rather than the upstream
Overleaf sample's `biblatex`/`biber` setup, to match this pipeline's
bibtex-only compile pass — no change to the document's content or
structure.

## Licence

**CC-BY-4.0**, per the chain above. `IEEEtran` itself is licensed
LPPL-1.3 and is not redistributed here; see
https://ctan.org/pkg/ieeetran.
