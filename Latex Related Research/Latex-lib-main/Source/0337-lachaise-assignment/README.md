# lachaise-assignment

**This is a substitute, not the original.** The template historically
served at this URL was "Lachaise Assignment" (Vel / mursisoy). That
original is licensed **CC-BY-NC-SA (non-commercial)**, and this site
cannot redistribute non-commercial content. This download is a
different problem-set/assignment class — the upstream `homework` class,
LPPL-1.3c — not a recreation of the original's design.

## Files

- `main.tex` — an example problem set. Start here.

## Building

    pdflatex main
    pdflatex main

Two passes resolve the cross-reference (`\cref`) and the numbered
problems/solutions.

## What you get

`homework` gives numbered `problem`, `solution`, `answer`, `proof`,
`lemma` and `fact` environments with automatic QED marks, plus
`\DNF<...>` for a problem you haven't solved yet. `main.tex` shows
common patterns: a single problem+solution, a proof with `\qedhere`, a
part-by-part problem, and a QED-less fact via `\proofless`. See
https://github.com/Jinwen-XU/homework for the full option list
(colours, logo, manual numbering, multilingual labels, etc.).

## The class is deliberately NOT included

`homework.cls` ships with TeX Live, so this download does not bundle a
copy. If your distribution does not have it: https://ctan.org/pkg/homework

## Licence

`homework` is licensed **LPPL-1.3c**, © Jinwen XU. The class is not
redistributed here; see https://ctan.org/pkg/homework.

This starter document is a minimal example written for latextemplates.com
and carries no additional restrictions.
