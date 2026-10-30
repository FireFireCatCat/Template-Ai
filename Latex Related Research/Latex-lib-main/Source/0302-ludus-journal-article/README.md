# LUDUS Academik Journal starter (ludusofficial)

A two-column starter for the LUDUS International Journal of Game Studies,
using the `ludusofficial` document class.

## This is a community-uploaded template, not published by LUDUS itself

This starter is based on the "Ludus Academik Journal Overleaf Template"
page in the Overleaf gallery:
https://www.overleaf.com/latex/templates/ludus-academik-journal-overleaf-template/ygpnjwmxzgbj

That page is uploaded and credited to three named individuals — **Shuai
Liu, Yewen Liu, and Siqi Yu** — who are not LUDUS or its editorial board.
The gallery page's own abstract text describes this as the "Official"
template for the journal, but that claim comes from the uploaders, not from
LUDUS; the journal's own site (https://ludusofficial.site/) does not host or
endorse a separate copy, it links back to the same Overleaf page. Do not
present this download as issued by LUDUS, and check the journal's own
current submission guidelines before relying on it for a real submission.

## Licence

`ludusofficial.cls` and the accompanying `testImg.jpg` are bundled here
because they are not part of any TeX Live distribution or CTAN package. The
class file itself contains no licence text of its own; the licence recorded
here (CC-BY-4.0) is the tag the three named uploaders gave the Overleaf
gallery page, credited to them — see `ATTRIBUTION.txt` in the download, and
keep it with the template if you redistribute it.

Two independently-hosted copies of `ludusofficial.cls` were checked before
packaging (both third-party re-hosts, not an official LUDUS repository);
they differ only in font-fallback and logo-file handling, not in visual
output for a document like this one that does not set a custom logo file or
typeset CJK text.

## Files

- `main.tex` — the article. Start here.
- `ludusofficial.cls` — the document class (bundled; see Licence above).
- `testImg.jpg` — a sample figure image; replace with your own.
- `references.bib` — bibliography, cited from `main.tex`.
- `ATTRIBUTION.txt` — required credit to the three uploaders (see Licence).

## Class options

`\documentclass[<colour>,<type>]{ludusofficial}` — colour theme is one of
`blue`/`red`/`green`/`purple`/`orange`/`cyan`; article type is one of
`fullpaper`/`letter`/`poster`/`survey`/`shortpaper`/`artpaper`.

## Building

This class supports both engines; xelatex is the default here because the
class loads `fontspec` under XeLaTeX and falls back to Latin Modern by
filename when neither of its preferred system fonts (Source Sans 3,
Helvetica Neue) is installed — verified against this compiler's fonts.

    xelatex main
    bibtex  main
    xelatex main
    xelatex main
