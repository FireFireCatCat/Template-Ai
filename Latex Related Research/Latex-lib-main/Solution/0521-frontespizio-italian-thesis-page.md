yes

# 0521-frontespizio-italian-thesis-page: Frontespizio Italian Thesis Page

- Unverified: read from the source, not compiled.
- Source: Source/0521-frontespizio-italian-thesis-page/ (origin: https://latextemplates.com/downloads/frontespizio.zip; licence: LPPL-1.3-or-later per manifest; README.md:17 says the same, and ctan.org/pkg/frontespizio gives LPPL 1.3 for the package)
- Kind: thesis (manifest hint was misc; the sample is an Italian thesis frontispiece followed by a short body)
- Lib: v5
- Engine: pdfLaTeX-compatible (README.md:11-13 runs `pdflatex` for every pass; no fontspec, no shell escape)
- Look carried by: preamble (the look is the published `frontespizio` package loaded at main.tex:4 and filled by the environment at main.tex:8-17; the class is plain `article` and the zip adds no class, style or macro)
- Class origin: tex-distribution-unbundled (kernel `article`, not in the zip; no .cls or .sty ships)
- Main file: main.tex (other samples: none; the zip holds only main.tex and README.md)
- Read: main yes, zip-local classes and styles none present

## Verdict
Yes. The whole zip is 26 lines of `main.tex`: kernel `article`, `fontenc`, `babel`, the published CTAN package `frontespizio` with one `frontespizio` environment of field commands, then two kernel headings and `lipsum` filler. There is no zip-local macro, class, style, counter or artwork, so nothing is bespoke. The package typesets the frontispiece as a companion document and includes it on the next run (README.md:4-6, 11-13). That extra pass is a plain `pdflatex` run on a file the package writes, so it is TeX-only and not an `EXTERNAL` blocker under the rubric. The residual risk is that an emitter's build must run the companion pass; the `postbibtex.sh` hook that README.md:5 names is not in the zip (README.md:12-13) and was not analysed.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `12pt` (main.tex:1)
- Class-native vocabulary used: `\section*` and `\section` only (main.tex:19, 24); no `\maketitle`, no `abstract` environment, no `\title`/`\author`. The front matter comes from the package's own `frontespizio` environment, not from the class.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | a4paper, 12pt |
| paper size and base font size | main.tex:1 | `page.class-options` | a4paper, 12pt |
| font encoding | main.tex:2 | `font.fontenc-t1` | fontenc option T1; no `inputenc` or `textcomp` loaded |
| language | main.tex:3 | `lang.babel` | babel option italian (Italian hyphenation and caption names) |
| thesis title page, load | main.tex:4 | `front.frontespizio` | `\usepackage{frontespizio}` with no options, so the package defaults apply (none of `standard` `suftesi` `sans` `normal` `swapnames` `signatures` `noadvisor` `norules` `nouppercase` `nowrite` `driver=` is passed; the package source was not read, so the defaults are not described) |
| thesis title page, fields | main.tex:8-17 | `front.frontespizio` | environment `frontespizio` with `\Istituzione{Università delle Colline}` (9), `\Facolta{Scienze dei dati}` (10), `\Corso{Sistemi Aperti}` (11, no optional type argument), `\Titolo{...}` (12), `\Sottotitolo{...}` (13), `\Candidato{Elena Rossi}` (14, no matricola), `\Relatore{Prof. Marco Bianchi}` (15), `\Annoaccademico{2025--2026}` (16); every value is a string. Not used: `\Universita`, `\Dipartimento`, `\Scuola`, `\Titoletto`, `\Correlatore`, `\Piede`, `\Logo`, `\Filigrana`, `\Preambolo` |
| companion document and extra pass | README.md:4-6, 11-13 | `front.frontespizio` | the package writes `main-frn.tex`, which is run through `pdflatex main-frn`, then `main.tex` runs again; the way's own mechanism, not a separate way |
| unnumbered "Abstract" heading | main.tex:19-22 | `head.kernel` | `\section*{Abstract}` followed by a plain paragraph; no `abstract` environment, so not `abs.kernel` |
| numbered section heading | main.tex:24 | `head.kernel` | `\section{Introduction}`, article default numbering and look, no `titlesec`, no `\renewcommand` |
| filler paragraph | main.tex:5, 25 | `draft.todo` | `lipsum` package, `\lipsum[1]`; the text is filler content |

Not set anywhere, so kernel defaults and no way is needed: header and footer (default `plain` style), geometry, spacing, colour, lists, floats, tables, bibliography, theorems, hyperref.

## Bespoke code
none (main.tex defines no `\newcommand`, `\def`, environment, counter or conditional; no .cls, .sty, .def or .cfg ships). `postbibtex.sh` is named at README.md:5 but README.md:12-13 says its hook is omitted from the download, so there is nothing to read; it is catalogue build orchestration, not template look.

## Content-opaque
none (no figure, table, TikZ or image; README.md:8-9 says no institutional logo is bundled and the names are placeholders)

## Lib changes
- New ways proposed: none. `front.frontespizio` already exists in lib v5 and covers the package, its environment and its companion-document mechanism. The package source was not available in the zip and was not read; the CTAN page was read once (version 1.4a, LPPL 1.3, TeX Live and MiKTeX, "producing an auxiliary TeX file to be typeset on its own"), and it names no engine or shell-escape requirement.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
