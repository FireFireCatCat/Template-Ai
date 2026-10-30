# LoLaTeXcv

A section/subsection/description-list CV class with a compact `lltxJob`
environment for dated entries (title, employer, dates, location, then a
bullet list) and a `\lltxdotfill` leader for education/timeline rows.
Upstream is `kryzar/LoLaTeXcv` by Antoine Leudière.

## Files

- `main.tex` — the CV (a fictional structural engineer; upstream's own
  example was written as a running joke among mathematicians and was
  replaced with plausible content a real user would edit).
- `LoLaTeXcv.cls` — the document class, vendored (GPL-3.0 requires
  redistributing the licence with the work; see below).
- `LICENSE.md` — the GPL-3.0 licence text, vendored alongside the class.

## Building

    pdflatex main
    pdflatex main

Two passes resolve section numbering; there is no bibliography.

## Licence

`LoLaTeXcv.cls` is licensed **GPL-3.0**, per `LICENSE.md` in upstream's
repository at https://github.com/kryzar/LoLaTeXcv. GPL requires that this
licence text travel with the class, so `LICENSE.md` is included in this
download. Credit is due to the original author, Antoine Leudière.

This starter document is original content for this download and carries no
additional restrictions.
