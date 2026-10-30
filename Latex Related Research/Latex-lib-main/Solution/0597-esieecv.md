yes

# 0597-esieecv: ESIEEcv (French-format CV)

- Unverified: read from the source, not compiled.
- Source: Source/0597-esieecv/ (origin: https://latextemplates.com/downloads/esieecv.zip; licence: UNKNOWN in the manifest; README.md:34-43 says no licence text was found in the upstream package, and ctan.org/pkg/esieecv lists LPPL for the package)
- Kind: cv
- Lib: v5
- Engine: pdfLaTeX-compatible (T1 + babel; README.md:45-47 builds with `pdflatex main`)
- Look carried by: preamble (a published package, `ESIEEcv`, loaded by `\usepackage` at main.tex:5 supplies the entry vocabulary; the page lengths at main.tex:7-16 are also in the preamble; the zip holds no `.cls` or `.sty`)
- Class origin: tex-distribution-unbundled (`article`; the zip ships no class)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the package source `ESIEEcv.sty` is not in the zip: README.md:5-7 says it ships with TeX Live; its source was not read)

## Verdict
A one-page French CV. It loads kernel `article`, `fontenc`, `babel` and one published package, `ESIEEcv` (CTAN and TeX Live, LPPL per ctan.org/pkg/esieecv, so W1 holds). The body is that package's `rubrique` and `sousrubrique` vocabulary plus two kernel minipages. The only code the sample defines is one string override of a package hook (main.tex:18) and raw page-length assignments (main.tex:7-16); both reduce to lib ways. There is no artwork and no external tool. The package's own source was not read, so its internal layout is taken on trust as a published package (the same ruling as for an unbundled published class); this is why the verdict rests on W1 for `ESIEEcv`, not on a reading of its code.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:1)
- Class-native vocabulary used: none of `article`'s own (no `\maketitle`, no `abstract`, no `\section`). The sample's vocabulary comes from the package `ESIEEcv`, recorded in the table under `cv.entries`: environments `rubrique{title}` and `sousrubrique`, field commands `\Titre` `\Lieu` `\Date` `\Duree` `\Descr` `\Apport` `\Competence`, hook `\PostApport` (main.tex:18, 35-89).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | a4paper |
| paper size | main.tex:1 | `page.class-options` | a4paper |
| page geometry | main.tex:7-13 | `page.setlength` | `\oddsidemargin`=`\evensidemargin`=0in, `\topmargin`=0in, `\textwidth`=`\paperwidth` then `\advance` by -2in (main.tex:9-10), `\textheight`=`\paperheight` then `\advance` by -2in (main.tex:12-13); net 1in margins on all sides |
| header and footer space | main.tex:14-16 | `page.setlength` | `\headheight`=0pt, `\headsep`=0pt, `\footskip`=0pt; no `\pagestyle` or `\thispagestyle` call in the file, so the `article` default page style is not changed |
| encoding | main.tex:3 | `font.fontenc-t1` | `fontenc` option T1; no text-font package, so the default Computer Modern |
| language | main.tex:4 | `lang.babel` | option `french` (README.md:23-32 says the old `frenchb` breaks on current babel) |
| CV package load | main.tex:5 | `cv.entries` | `\usepackage{ESIEEcv}`, no options (ESIEEcv: CTAN package by Benjamin Bayart; source not read; the package is the parameter of this way, which the lib line already describes as CV entry commands) |
| entry suffix string | main.tex:18 | `cv.entries` | `\renewcommand{\PostApport}{. }`: the string put after each `\Apport` item (role inferred from the name; source not read) |
| personal-details block, two boxes | main.tex:22-28, 29-33 | `box.minipage` | two `minipage` environments, width 0.4\linewidth each |
| personal-details block, side by side | main.tex:22-33 | `cols.minipage` | the two minipages sit on one line; leading `\noindent\hspace*{\tabcolsep}` (main.tex:22) |
| paragraph start in that block | main.tex:22 | `sp.lengths` | `\noindent`, the per-paragraph override of `\parindent` |
| manual spacing and breaks | main.tex:22-27 | `sp.manual-space` | `\hspace*{\tabcolsep}`, line breaks `\\` and `\\[3pt]` (main.tex:25) |
| name and contact styling | main.tex:23, 27 | `font.size-commands` | `\large` on the name |
| name and contact styling | main.tex:23, 27 | `mark.kernel` | `\textsc{Fabre}`, `\texttt{...}` for the mail address |
| accents and ties | main.tex:23, 25, 26, 31 | `font.fontenc-t1` | `\'e`, `\c{c}`, `~` before `:`; content-level, read under the T1 encoding |
| CV sections | main.tex:35, 53, 77 | `cv.entries` | `\begin{rubrique}{Formation}`, `{Exp\'eriences professionnelles}`, `{Langues et divers}` |
| CV entries | main.tex:36-50, 54-74, 78-89 | `cv.entries` | `sousrubrique` with `\Titre` `\Lieu` `\Date` `\Duree` `\Descr`, repeated `\Apport` (main.tex:42-43, 61-63, 72-73), `\Competence` (main.tex:79, 83) |

Not used by the sample: title block (`\maketitle`), abstract, headings, lists of its own, theorems, floats, tables, captions, code, bibliography, index, cross-references, footnotes, maths, colour. The README (README.md:5-6) says the package lays the entries out in a two-column table; that is the package's internal layout, not something the sample sets.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\PostApport}{. }` | main.tex:18 | yes | one string value for the `cv.entries` hook that follows each `\Apport`; an emitter prints it as a preamble line after `\usepackage{ESIEEcv}` |
| `\textwidth\paperwidth` + `\advance \textwidth by -2in`, same for `\textheight` | main.tex:9-10, 12-13 | yes | length arithmetic on kernel parameters; `page.setlength` as written, or `page.geometry` with margin=1in, nohead, nofoot as an equivalent |
| `ESIEEcv.sty` | not in the zip | n/a (published) | not zip-local: CTAN and TeX Live package (ctan.org/pkg/esieecv: LPPL, "included in TeX Live and MiKTeX"); no copied macro logic is needed, the emitter writes `\usepackage{ESIEEcv}` and the package's environments |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered: giving `ESIEEcv` its own CV-package way; placed under `cv.entries` because its `rubrique`/`sousrubrique` environments and `\Titre`/`\Lieu`/`\Date`/`\Descr` fields are CV entry commands of the type that line names (moderncv, altacv, awesome-cv), with the package as the parameter. The line's text could be widened to say a CV package is also the parameter.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
