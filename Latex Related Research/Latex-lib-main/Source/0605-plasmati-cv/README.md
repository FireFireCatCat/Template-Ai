# plasmati-cv

**This is a substitute, not the original.** The template historically
served at this URL was Alessandro Plasmati's two-column CV. That original
is licensed **CC-BY-NC-SA (non-commercial)**, and this site cannot
redistribute non-commercial content. This download uses `tccv`
(https://github.com/ntd/tccv), an explicit **clean-room rewrite** of the
same two-column idea — its own header states it is "based on the
original idea by Alessandro Plasmati", reimplemented from scratch as a
class, and it carries no non-commercial restriction. It is not a copy of
Plasmati's original files.

## Files

- `main.tex` — the CV. Start here.
- `tccv.cls` — the class, vendored here because it is not part of TeX
  Live.

## Building

    pdflatex main

Two passes are enough here (no bibliography, no cross-references).

## Known upstream defect: `factlist`

`tccv.cls`'s `factlist` environment subtracts a full `\baselineskip`
after every row unconditionally, which makes consecutive short rows
overlap the row below — reproducible with the class author's own
example document, not something introduced by this starter. This
starter uses a plain `description` list for "Languages and skills"
instead. If you want the class's own two-column fact/description look,
keep each `factlist` entry to only one or two very short rows and check
the render, or expect overlap.

## Licence

`tccv` is licensed **LPPL-1.3+**, © 2012--2021 Nicola Fontana. See the
class file's own header and https://github.com/ntd/tccv.

This starter document is a minimal example written for latextemplates.com
and carries no additional restrictions.
