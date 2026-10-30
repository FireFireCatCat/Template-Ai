# DGUT paper/report/assignment starter (unofficial)

A Chinese-language (with English abstract) thesis/report/assignment
starter modelled on Dongguan University of Technology's (东莞理工学院)
common formatting conventions, using a custom `config` document class.

## This is an unofficial, community-authored template

This starter is based on the Overleaf gallery template "DGUT通用论文/报告/
作业模板（非官方）" ("DGUT general paper/report/assignment template
(unofficial)"):
https://www.overleaf.com/latex/templates/dguttong-yong-lun-wen-slash-bao-gao-slash-zuo-ye-mo-ban-fei-guan-fang/gkymcyhwhjhj

The uploader, credited as "Mai", labels it 非官方 (unofficial) in the
template's own title and abstract — this is not, and has never claimed to
be, an official DGUT-issued template. Check your department's own current
formatting requirements before relying on it for a real submission.

## Licence

LPPL-1.3c — stated by the author ("Mai") both in the Overleaf gallery's
licence field and in the template's own usage-guide document body ("本模板
采用 LPPL v1.3c...或其之后的版本进行许可" — "This template is licensed
under LPPL v1.3c or later"). Two independent, byte-identical copies of the
class file were found and compared before packaging, giving confidence this
is the unmodified file.

## Cover-page images not included

The upstream Overleaf project's cover page references three institutional
image files — `DGUT-logo.pdf` (university crest), `DGUT-title-CN.pdf` and
`DGUT-title-EN.pdf` (university name wordmarks). These are binary assets
that were never obtainable: Overleaf exposes no public download endpoint
for gallery template projects, and the public "View Source" panel only
shows the root `.tex` file, not project assets. This is a **source
availability gap, not a licensing decision** — if you have the originals
(or your own institution's equivalents), you can restore them by
uncommenting the `\titlePageImages` definition near the top of `main.tex`
and adding the three files alongside it. Without them the cover page still
generates correctly; it just omits the crest/wordmark graphics.

## Font substitutions

The upstream project bundled Source Han Serif CN and Source Han Sans CN as
font files under its own `fonts/` directory — also not part of the public
"View Source" text and not obtainable for the same reason as the cover
images. Substituted in `config.cls` (see the comments there) with **Fandol**
— the CJK family this TeX Live distribution actually ships and resolves via
`kpathsea` — FandolSong (serif) for Source Han Serif CN, and FandolHei
(sans/gothic) for Source Han Sans CN. `fc-list :lang=zh` reports nothing on
this compiler, which looks like "no CJK support" but is not: xeCJK resolves
CJK fonts through kpathsea, not fontconfig, and Fandol works correctly here
once addressed by its exact `.otf` filename rather than by bare family name
(a bare `\setCJKmainfont{FandolSong}` fails outright on this compiler —
verified directly).

"Times New Roman" and "JetBrains Mono", the upstream project's English
fonts, also do not resolve by family name here (this compiler's fontconfig
only resolves DejaVu and the URW base-35 by family). Substituted with TeX
Gyre Termes (a Times clone) and JetBrains Mono's own upstream OTF files —
TeX Live ships the genuine font, not a clone — both resolved by filename.

## A note on the class API

The upstream sample document (a 1200-line usage guide) was written against
an older version of `config.cls` than what could be obtained here: several
of its calls do not match this class version's actual commands (e.g. a
`\ResetCounter` command that does not exist, and `\contentPage`/cover-page
arguments that expect different argument counts and types than the sample
passes). This starter is written directly against the class as bundled here
— verified by reading `config.cls` itself — not transcribed from the
upstream sample's calling convention. See the inline comments in `main.tex`
and `config.cls` for the specific corrections.

## Files

- `main.tex` — the starter document. Start here.
- `config.cls` — the document class (bundled; see Licence above).
- `references.bib` — bibliography, cited from `main.tex`.

## Building

    xelatex main
    bibtex  main
    xelatex main
    xelatex main
