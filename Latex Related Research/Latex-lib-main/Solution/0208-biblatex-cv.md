yes

# 0208-biblatex-cv: biblatex-cv (academic CV from a .bib file)

- Unverified: read from the source, not compiled.
- Source: Source/0208-biblatex-cv/ (origin: https://mirrors.ctan.org/macros/latex/contrib/biblatex-contrib/biblatex-cv.zip; licence: LPPL 1.3 (README.md:16-20; biblatex-cv.sty:3))
- Kind: cv
- Lib: v2
- Engine: pdfLaTeX-compatible (the sample's own build line is `pdflatex` + `biber`, doc/cv.tex:34-36; every package the style loads is a pdfTeX package; `\highlightname` branches on `\ifxetex` and otherwise uses the pdfTeX primitive `\pdfmdfivesum`, biblatex-cv.sty:567-579). The manual doc/biblatex-cv.tex alone needs XeLaTeX (`fontspec`, doc/biblatex-cv.tex:4-10, 410).
- Look carried by: preamble (the CV listing look is one published CTAN style package, `biblatex-cv`, loaded at doc/cv.tex:3 over plain `article`; its files are the zip, but the zip is the CTAN release itself, so they are published, not zip-local)
- Class origin: tex-distribution-unbundled
- Main file: doc/cv.tex (other samples: doc/biblatex-cv.tex, the package manual; documentation, read in full, not the template; doc/biblatex-cv.bib is its data file)
- Read: main yes, zip-local classes and styles all (biblatex-cv.sty 776 lines, biblatex-cv.bbx 736, biblatex-cv.dbx 386, biblatex-cv.cbx 3, american-cv.lbx 53, README.md 20; no .cls in the zip)

## Verdict
The main sample is 30 lines: `article`, `babel[american]`, one published package `biblatex-cv`, one `\highlightname` call, `\addbibresource`, `\nocite{*}`, and seven `\section*` plus `\printbibliography[env, resetnumbers, check]` pairs (doc/cv.tex:1-30). It defines no macro of its own. `biblatex-cv` is a CTAN package (one read of ctan.org/pkg/biblatex-cv: path `/macros/latex/contrib/biblatex-contrib/biblatex-cv`, version 0.01, LPPL 1.3, in TeX Live; the zip's `ProvidesPackage` says v0.01 2020/03/11, biblatex-cv.sty:8), so by W1 its internals are not bespoke code. An emitter writes the preamble and body lines above and copies no macro logic. The `yes` rests on two judgements: that the zip's copy equals CTAN's (not diffed), and that a biblatex style package with its own entry types, filters and `\highlightname` is a parameter of `bib.biblatex-biber`. Under a stricter reading that treated the style files as zip-local, they would be `BESPOKE/class` (see Bespoke code).

## Blockers
none

## Class setting
- Class: `class.article` options: none (doc/cv.tex:1)
- Class-native vocabulary used: `\section*` only (doc/cv.tex:10-28); no `\maketitle`, no `abstract`, no `\title`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/cv.tex:1 | `class.article` | no options; default size and paper |
| language | doc/cv.tex:2 | `lang.babel` | `american` |
| bibliography engine and options | doc/cv.tex:3; biblatex-cv.sty:13-17 | `bib.biblatex-biber` | `\usepackage{biblatex-cv}` forwards `labelnumber=true, defernumbers=true, backend=biber, style=biblatex-cv, sorting=ydnt, maxnames=999` to biblatex; unknown options pass through (sty:10-11) |
| style options of the way | biblatex-cv.bbx:13-30 | `bib.biblatex-biber` | booleans `verbose-lists`, `verbose-committee`, `verbose-education`, `verbose-teaching` (`\DeclareBibliographyOption`); the sample passes none |
| citation style | biblatex-cv.cbx:3 | `bib.biblatex-biber` | `\RequireCitationStyle{authoryear}`; the sample cites only through `\nocite{*}` (doc/cv.tex:9) |
| bibliography style base | biblatex-cv.bbx:4, 6 | `bib.biblatex-biber` | `\RequireBibliographyStyle{authoryear}`, `\DeclareLanguageMappingSuffix{-cv}` |
| data source | doc/cv.tex:6 | `bib.biblatex-biber` | `\addbibresource{biblatex-cv.bib}` (doc/biblatex-cv.bib, content) |
| custom entry types and fields | biblatex-cv.dbx:4-9, 79, 153, 184, 205, 233, 270, 308, 339 | `bib.biblatex-biber` | `\DeclareDatamodelEntrytypes` for abstract, committee, school, degree, funding, presentation, student, teaching; `\DeclareDatamodelFields`, `\DeclareDatamodelEntryfields`, `\DeclareDatamodelConstraints` (mandatory fields, regexp value lists); `--validate_datamodel` is an optional biber flag (doc/cv.tex:35) |
| per-type entry drivers | biblatex-cv.bbx:390-406, 409-675 | `bib.biblatex-biber` | `\DeclareBibliographyDriver` for 7 types, `abstract` copies the article driver; `\newbibmacro` (15 in the bbx), `\xpatchbibdriver`/`\xpatchbibmacro`/`\renewbibmacro*` on the standard drivers (bbx:91-145) |
| field formats, label date | biblatex-cv.bbx:391-400, 680-705 | `bib.biblatex-biber` | `\DeclareFieldFormat` (quotes, `\bibstring` lookups), `\DeclareLabeldate{date year eventdate origdate urldate}` |
| sorting | biblatex-cv.bbx:708-736 | `bib.biblatex-biber` | `\DeclareSortingTemplate{ydnt}`: presort, sortkey, descending sortyear/endyear, descending year, name, title |
| localised strings | american-cv.lbx:1-53 | `bib.biblatex-biber` | `\InheritBibliographyStrings{american}`, `\NewBibliographyString` (44 keys, lbx:6), `\DeclareBibliographyStrings` |
| funding duration in months | biblatex-cv.bbx:8-9, 65-84, 263-299 | `bib.biblatex-biber` | inside the style: published `datenumber` and `fp` compute months between start and end dates |
| section groups: filters | biblatex-cv.sty:49-562; doc/cv.tex:11, 14, 17, 20, 23, 26, 29 | `bib.biblatex-biber` | `\printbibliography[check=<name>]`; the sample uses 7 of the 103 predefined `\defbibcheck` names: `Education`, `Funding`, `Abstract`, `Presentation`, `Teaching`, `Committee`, `Student` (sty:139, 146, 49, 271, 552, 118, 376) |
| section groups: environments | biblatex-cv.sty:698-711; doc/cv.tex:11-29 | `bib.biblatex-biber` | `env=unnumbered` (Education, Teaching, Service, Mentoring) or `env=numbered` (Funding, Abstracts, Research Presentations); both are `\defbibenvironment`; `resetnumbers=true` restarts numbering per list |
| descending item numbers | biblatex-cv.sty:19-21, 653-674 | `bib.biblatex-biber` | inside the style: published `totcount` counters, one new per `\printbibliography` (`\xpatchcmd`), field format `labelnumber` prints total+1-n, `labelnumberwidth` in brackets |
| list geometry of the entries | biblatex-cv.sty:24, 676-696 | `sp.lengths` | `\biblabelsep` 0.5em; `\labelwidth`, `\leftmargin`, `\labelsep`, `\itemsep`, `\parsep`, `\itemindent` set from `\labelnumberwidth`, `\bibhang`, `\bibitemsep`, `\bibparsep` |
| list container | biblatex-cv.sty:699, 709; bbx:222-224 | `list.kernel` | kernel `\list{label}{settings}` / `\endlist`, used inside the two environments and the nested degree sub-list |
| bibliography heading removed | biblatex-cv.sty:25 | `bib.biblatex-biber` | `\defbibheading{bibliography}{}` (empty); the section titles come from `\section*` |
| section titles | doc/cv.tex:10, 13, 16, 19, 22, 25, 28 | `head.kernel` | `\section*{Education}`, `Funding`, `Abstracts`, `Research Presentations`, `Teaching`, `Service`, `Mentoring` (unnumbered, default look) |
| highlight the CV owner's name | doc/cv.tex:5; biblatex-cv.sty:565-612 | `bib.biblatex-biber` | `\highlightname{family}{given}{prefix}{suffix}` = `{Doe}{Jon}{}{}`; name formats patched with `\xpretonameformat`/`\xapptonameformat` |
| name emphasis | biblatex-cv.sty:595-602 | `mark.kernel` | `\textbf` on given, family, prefix and suffix of the highlighted name |
| owner's name removed from author and presenter lists | biblatex-cv.sty:27-28, 615-651 (bibmacro `nameDeleted` at 631-637) | `bib.biblatex-biber` | toggles `cv@blx:delete:author` and `:presenter` are on by default; `\DeclareNameInputHandler`/`\DeclareNameWrapperFormat` prefix "with" or "by" (strings in american-cv.lbx:6, 52, 11) |
| bibliography-wide switches | biblatex-cv.sty:27-44, 768-776; bbx:33-54 | `bib.biblatex-biber` | booleans (`\toggletrue` defaults: pubstate, funding role and status, presentation type and subtype, student and teaching institution, location, department, school years); the manual shows `\togglefalse{cv@blx:teaching:institution}` (doc/biblatex-cv.tex:405) |
| entry data inheritance, crossref hiding | biblatex-cv.sty:714-766 | `bib.biblatex-biber` | `\DeclareDataInheritance`, `\DeclareStyleSourcemap` (set `skipbib` on crossref-ed committee, teaching and degree entries) |

Not defined by this zip (no row): page geometry, header and footer, fonts and encodings, colour, spacing beyond the list lengths above, front matter, abstract, contents, theorems, floats, tables, captions, code, boxes, cross-references, hyperlinks, index. cv.tex sets none of them (article defaults).

The manual (doc/biblatex-cv.tex), documentation only, not mapped row by row: `ltxdockit` class (doc/biblatex-cv.tex:2; CTAN class, not re-checked here) with `btxdockit`, `fontspec` + Linux Libertine O (:4-10), `babel`, `csquotes`, `tabularx`, `longtable`, `booktabs`, `microtype`, `typearea` + `\areaset` (:11-21), `mdframed` (:20), KOMA font hooks (:30-35), `\lstset` (:22-29), `hyperref` and `\hypersetup` (:167-172), `\titlepage{...}` (:157-165), then `\usepackage{biblatex-cv}` and the same `\highlightname`/`\addbibresource` as cv.tex (:174-176), a `\tableofcontents`, and an `ltxcode` copy of the sample (:360-391).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| doc/cv.tex defines nothing | doc/cv.tex:1-30 | n/a | no `\newcommand`, `\def`, environment, counter or conditional |
| `biblatex-cv` package: `\highlightname` (md5 hash of name parts, `\xifinlist` against a stored hash list), name deletion by `\regex_replace_all` over the name-list string, descending numbers via `totcount` and a patched `\printbibliography`, month arithmetic with `fp` | biblatex-cv.sty:565-651, 653-674; bbx:65-84 | n/a: published on CTAN (W1), so it is the body of the way, not bespoke | If the zip's copy did not match CTAN's, or a stricter reading counted the style as zip-local, these are irreducible `BESPOKE/class`: expl3 regex over biblatex's internal name-list data (`\NewValue`, `\blx@bbl@addfield`, sty:619-627), a hash-driven conditional and counter-driven numbering. The copy was not diffed against CTAN's; the version string matches (sty:8) |
| the 103 `\defbibcheck` filters, 7 declared drivers plus the copied `abstract` driver, 15 bibmacros, data model, sorting template, strings | biblatex-cv.sty:49-562; bbx:148-736; dbx:1-386; lbx:1-53 | yes (even on the stricter reading) | each is a published biblatex declaration with field lists and tests, a composition of `bib.biblatex-biber` parameters |
| manual preamble helpers: `namesample` (box registers `\@tempboxa`, `\vrule\lower`), `nameparts`, `namedelims`, `\sorttablesetup`, `\tickmarkyes`, `\Deprecated`/`\LF`/`\CSdelim` and their `Mark` forms, `\seestyleexample`, `\fnurl`, `\exampitem`, five `\newcolumntype`s, `\RedeclareSectionCommand` | doc/biblatex-cv.tex:40-48, 67-141, 146-148, 178-182 | out of scope (documentation, not the template) | `namesample` and `nameparts` and `namedelims` are defined and never called in the manual (grep: only line 101, 91, 96); if the manual counted as the sample, `namesample` (:101-114) would be an irreducible `BESPOKE/preamble` and the engine would be XeLaTeX |
| Observed defects (no effect on the verdict) | biblatex-cv.bbx:168; american-cv.lbx:6, 34 | n/a | bbx:168 prints `\bibstring{numCites}` but the string is declared as `numcites` (lbx:34), probably a case mismatch; it runs only for an entry with `numcites`, which the sample never has. `\bibstring{honors}` (bbx:450) is not among the strings lbx:6 adds; whether biblatex's own american strings define it was not checked |

## Content-opaque
none (the entries in doc/biblatex-cv.bib are bibliographic data, content; their custom types and fields are declared by the package, dbx:79-368)

## Lib changes
- New ways proposed: none. Considered: `biblatex-cv` as its own doc-kind way (a `cv.biblatex` line). Rejected because the sample uses it only as a biblatex style with biblatex's own commands (`\addbibresource`, `\printbibliography[env,resetnumbers,check]`, `\nocite`), the style is a parameter of `bib.biblatex-biber` as a `.bst` is of `bib.bibtex-bst`, and the lib already merged style-specific packages (`bib.apacite` into `bib.apacite`). `\highlightname` is the one command outside biblatex itself. If a reviewer rules it outside the way, the proposal would be a doc-kind line `cv.biblatex` (not proposed here): CTAN `biblatex-cv`, pdf; W1 on CTAN and in TeX Live; W2 booleans `verbose-*`, toggles, filter names, `env` names; W3 serves any academic CV built from a .bib file; W4 one preamble line plus `\highlightname` and one `\printbibliography[...]` per section; the verdict stays `yes`. Also considered and not used: `cv.entries` (class entry commands such as `\cventry`; this package has none).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
