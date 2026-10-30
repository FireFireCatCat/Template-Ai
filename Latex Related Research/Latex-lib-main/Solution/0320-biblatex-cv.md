yes

# 0320-biblatex-cv: BibLaTeX CV

- Unverified: read from the source, not compiled.
- Source: Source/0320-biblatex-cv/ (origin: https://latextemplates.com/downloads/biblatex-cv.zip; licence: LPPL-1.3c)
- Kind: cv
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:8 "Engine: pdflatex"); the bibliography is processed by biber, the backend that `biblatex-cv` fixes (main.tex:9-11, README.md:16-17)
- Look carried by: preamble (the sample's preamble loads the published package `biblatex-cv`, whose own data model and drivers print every CV section; the zip adds no zip-local class, style or macro logic beyond one empty-macro line)
- Class origin: tex-distribution-unbundled (kernel `article`, main.tex:15; `biblatex-cv` is a CTAN / TeX Live package, not bundled: README.md:11-12)
- Main file: main.tex (other samples: none; data file cv.bib)
- Read: main yes, zip-local classes and styles none present (the zip holds only main.tex, cv.bib, README.md; the source of `biblatex-cv` is not in the zip and was not read)

## Verdict
Yes. The document is `article` plus `geometry`, `babel`, `parskip` and one published package, `biblatex-cv` (CTAN, TeX Live, LPPL, author Daniel E. Shub; one ctan.org/pkg read), which is a thin wrapper that loads `biblatex` with the biber backend and prints each CV section from typed `.bib` entries. Every body construct is a kernel command or a `\nocite` / `\printbibliography[...]` call with option values. The only zip-local code is a one-line empty-macro initialisation that works around an upstream bug and has no typesetting effect, so it is reducible. No zip-local class or style, no artwork. The one judgement call is the way for `biblatex-cv` itself (see Lib changes): it is filed under `bib.biblatex-biber` with the wrapper package as the parameter, not as a new way.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (main.tex:15)
- Class-native vocabulary used: `\section*` only (main.tex:41,51,55); no `\maketitle`, no `abstract`, no `\bibliography` (the sample prints no title block through the class; the header is hand-set, main.tex:35-39).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:15 | `class.article` | `11pt` |
| font size / page size by class option | main.tex:15 | `page.class-options` | `11pt` (no paper option, so the class default paper) |
| page geometry | main.tex:16 | `page.geometry` | `margin=1in` |
| language | main.tex:17 | `lang.babel` | option `american` |
| bibliography engine and CV entry model | main.tex:28-29, README.md:16-23 | `bib.biblatex-biber` | `\usepackage{biblatex-cv}` (hardcodes `backend=biber`, own bibliography style, own entry types `@school` `@degree` `@presentation`, own `.dbx`: main.tex:5-9, README.md:16-23), `\addbibresource{cv.bib}` |
| paragraph spacing | main.tex:31 | `sp.parskip-pkg` | no options (loaded after `biblatex-cv`) |
| CV header block (name, department, e-mail) | main.tex:35-39 | `sp.ragged` | kernel `center` environment (same family as `\centering`) |
| header block: name size and weight | main.tex:36 | `font.size-commands` | `\LARGE` |
| header block: name weight, e-mail face | main.tex:36,38 | `mark.kernel` | `\bfseries`, `\texttt` |
| header block: gap after the name | main.tex:36 | `sp.manual-space` | `\\[2pt]` |
| section headings (Education, Publications, Invited Talks) | main.tex:41,51,55 | `head.kernel` | `\section*` (unnumbered), class default look |
| Education section (school with linked degree) | main.tex:48-49 | `bib.biblatex-biber` | `\nocite{schoolPhD,degreePhD}`; `\printbibliography[heading=none,resetnumbers=true,check=Education]`; `check=` is a `\defbibcheck` filter named by the package (README.md:49-51); entries `@school`, `@degree` with `degreelist`, `crossref` (cv.bib:1-17) |
| Publications section (numbered list) | main.tex:52-53 | `bib.biblatex-biber` | `\nocite{cvArticleOne,cvArticleTwo}`; `\printbibliography[heading=none,resetnumbers=true,env=numbered,type=article]`; `env=numbered` is the package's descending-number list style (README.md:45-48); `@article` with mandatory `numcites` (cv.bib:19-36) |
| Invited Talks section | main.tex:56-57 | `bib.biblatex-biber` | `\nocite{cvTalkOne}`; `\printbibliography[heading=none,resetnumbers=true,check=Presentation]`; `@presentation` with `entrysubtype`, `presentationtype`, `presenter` (cv.bib:38-47) |

Not set by the zip (class defaults only): headers and footers, fonts (no font package; Computer Modern default), colour, lists, floats, tables, theorems, code, index, cross-references, hyperref. Nothing was added for them.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\cv@blx@highlightname@hash@list}{}` inside `\makeatletter` / `\makeatother`, with `\usepackage{etoolbox}` | main.tex:24-27 (reason: main.tex:18-23, README.md:25-35) | yes | An empty macro that initialises a list the package's `\highlightname` feature reads. It prints nothing and holds no logic: kernel `\newcommand` (or `\providecommand`, safer if a package version already defines it) in the preamble of the `bib.biblatex-biber` way when the wrapper package is chosen. It depends on a package-internal control sequence and on the package version (the README calls it an upstream bug), so the emitter must tie it to that package. `etoolbox` is published and only a load; it has no lib component line and is not a way. |

## Content-opaque
none (the `.bib` entries, cv.bib:1-47, and the header text, main.tex:36-38, are content; the entry types they use are required by `biblatex-cv`)

## Lib changes
- New ways proposed: none.
- Considered, not proposed: `biblatex-cv` as a separate CV way beside `cv.entries`. `cv.entries` names class entry commands (moderncv, altacv, awesome-cv); this zip has no entry command, its entries are `.bib` records (content) printed by a biblatex driver. The package describes itself as using BibLaTeX and biber (ctan.org/pkg/biblatex-cv), and its entry types, drivers and filters are a biblatex data-model and style extension, so it is filed as the parameter of `bib.biblatex-biber`, as `bib.bibtex-bst` takes a `.bst` as a parameter. The consolidator may widen that line to name biblatex wrapper packages, or decide a `cv.*` line is wanted; a reviewer should note the stretch.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- The document runs under biber, not bibtex (main.tex:9-11). The lib already counts that toolchain as `bib.biblatex-biber`, so it is not `EXTERNAL` here.
- README.md:45 says Publications uses `check=Education`; main.tex:53 actually uses `type=article`. main.tex is the authority.
- Not read: the source of `biblatex-cv` (`.sty`, `.bbx`, `.dbx`), so the package options and the exact look of each driver are not established from this zip; the look is recovered by naming the published package and its entry types.
- No text addressed to an AI was found in any file.
