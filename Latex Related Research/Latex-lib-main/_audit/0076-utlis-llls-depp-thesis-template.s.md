refuted: no (the yes stands; nothing compiled, read-only audit)

# 0076-utlis-llls-depp-thesis-template: skeptic audit

Read: rubric, lib (v2), the solution file, master_thesis.tex 1-530 in full, graduation_thesis.tex 1-538 in full, README.md, both LaTeX readmes, the Word master readme, .gitignore, manifest row 77. One ctan.org read (jsclasses). Nothing run from the zip; one throwaway script kept outside the zip decompressed the two shipped PDFs only to read their /Producer, /Creator and font names.

## What I searched for, and found

- Bespoke code: grep of both .tex files for newcommand, renewcommand, providecommand, \def, \let, newenvironment, renewenvironment, newcounter, newif, makeatletter, \input, \include, \catcode, \special, \write18, \AtBegin, \AtEnd, \titleformat, \patch, \xpatch: no hit outside verbatim text (the only `\usepackage` hits are the verbatim copies at master_thesis.tex:124 and graduation_thesis.tex:140). No .cls/.sty/.def/.cfg in the zip (ls). The whole preamble is master_thesis.tex:21-25 (graduation_thesis.tex:31-35). No BESPOKE blocker.
- Artwork: no tikz, pgf, pstricks, picture, eso-pic, overlay. The only image is `\includegraphics{test.eps}` inside a figure (master_thesis.tex:314), content. No ART blocker.
- Tools outside TeX: no shell escape, minted, makefile, preprocessor, bibtex/biber. Only `thebibliography` (master_thesis.tex:521-525). No EXTERNAL/package blocker.
- Packages: only graphicx and enumerate (master_thesis.tex:22), both mapped (`fig.graphicx`, `list.enumerate-pkg`). Nothing missing from the map.
- Class: `jsbook` is in CTAN `jsclasses` (jsarticle, jsbook, okumacro, okuverb), contained in TeX Live; CTAN says it is designed for ASCII pTeX and names no other engine. So W1 is met, and a published unbundled class is one way (rubric). Its source is not in the zip and `\fullwidth` (master_thesis.tex:24) as a jsbook length could not be confirmed here; the file says as much.

## Engine

The shipped PDFs show `/Producer dvipdfmx (20200315)` with `/Creator TeX output 2020.12.26` for master_thesis.pdf and `dvipdfmx (20220710)` / `TeX output 2024.03.26` for graduation_thesis.pdf, with HaranoAjiMincho and HaranoAjiGothic fonts. That is the pTeX-family DVI route and confirms the file's engine call, which it had said rested only on the readme and CTAN (solution line 74). Under the rubric the engine is recorded, not a blocker, and lib v2 now has the `ptex` tag (_Lib.md:10, 176).

## Soft spots (not blockers under the rubric)

1. The solution file says "Lib: v1" and that the lib's engine column has only `pdf` and `xe/lua`, and asks the consolidator for a third tag (solution lines 9, 69). The lib now at v2 already carries `ptex` and `lang.ptex` (_Lib.md:10, 176, 389). The note is stale, harmless.
2. Consistency risk: the v2 change log records prosper's dvips toolchain as an EXTERNAL/class note (_Lib.md:389). This zip needs DVI then dvipdfmx (a TeX Live program, and the `ptex` tag says "DVI output") and, for test.eps with no driver option, an EPS to PDF conversion (Ghostscript). I read these as engine plus an image asset, not EXTERNAL, but a stricter reader could differ. The solution file mentions the EPS step only as "assumed, not checked" (lines 74).
3. `front.titlepage-env` is given for a title page that uses no `titlepage` environment (master_thesis.tex:28-54 is loose text, `center`, `\bigskip` runs). The file says so. The blank second page (master_thesis.tex:51-54, `\newpage`, one U+3000, `\newpage`) is reduced to `\null`, a kernel command no lib line names (`pg.break`, `sp.manual-space`). Content filler, minor.
4. The "language" and "fonts" rows (solution lines 57-58) are filed under `class.jsbook`, which is the document-class way; nothing in the zip sets a language or font. Honest, but those rows are not real components of this zip.

## Citation check

citationsChecked 40, wrong 1.

Matched the source: master_thesis.tex 21, 22-25, 23, 24, 27, 28-50, 29/32/36/42/50, 31, 40-41, 51-54, 52, 56-57, 59, 60, 61, 64-65, 67-69, 68, 86, 87, 9-10, 103-109, 168-178, 248, 270, 272-280, 282, 299/320/371/381, 312-317, 337-348, 354-359, 363-364, 374/391, 383/432/450/468/485/506, 420-422, 521-525, 522, 523; graduation_thesis.tex 31, 37/65/72/81, 38-62, 40/45/53-54, 74, 80/102/524, 136, 352-359, 359/365; readme-master.txt 9, 13, 17; readme-graduation.txt 9, 11, 16; the count of 16 verbatim environments (96, 116, 123, 134, 156, 184, 193, 205, 221, 253, 285, 303, 324, 377, 395, 411) is right; manifest origin and licence agree with the file.

Wrong or loose:
- Component map row "inline marks and logos" (solution line 47) lists `\TeX{}` but none of its cited lines (master_thesis.tex:70, 80, 357, 436, 453) contains it (it sits at 119, 131, 139). Counted as the 1 wrong.
- Row "title page type sizes" lists graduation as `\LARGE`, `\Large`, `\LARGE`; graduation_thesis.tex:41, 49, 55, 59 are `\LARGE`, `\Large`, `\Large`, `\LARGE`. Cited lines right, list short.
- `\verb` list (140, 213, 232) omits master_thesis.tex:214 (`\verb|\smallskip|`).
- Row "pages without a number": for graduation only 37/65/72/81 are cited; the second chapter opening (103) and the bibliography (529) also carry `\thispagestyle{empty}`, and the third chapter (524) does not.

## Verdict

No real blocker found under the rubric: no BESPOKE, ART, UNMAPPED, EXTERNAL or NOTEMPLATE. The yes rests on engine being a recorded tag and on jsbook being a published class whose source was not read.
