yes

# 0453-freeman-cover-letter: Freeman Cover Letter (jourcl, cover letter for a journal submission)

- Unverified: read from the source, not compiled.
- Source: Source/0453-freeman-cover-letter/ (origin: https://latextemplates.com/downloads/freeman-cover-letter.zip; licence: CC-BY-SA-4.0; ATTRIBUTION.txt:1-4 credits Iztok Fister Jr., upstream https://github.com/firefly-cpp/cover-letter-latex)
- Kind: letter
- Lib: v4
- Engine: pdfLaTeX-compatible (no fontspec in the class, main.tex:15; the loaded packages are jourcl.cls:5-13,55)
- Look carried by: mixed (the published class `jourcl` sets margins, header block, spacing and the field commands, jourcl.cls:53-134; main.tex adds the data fields, a rule, a framed abstract and vertical spacing, main.tex:60-99)
- Class origin: ctan
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (jourcl.cls, 321 lines, read in full; it is the zip's only class or style file)

## Verdict
`yes`. The class `jourcl` is on CTAN and in TeX Live (one read of ctan.org/pkg/jourcl: "Cover letter for journal submissions", CC BY-SA 4.0), so it is one published class way, `class.jourcl`; the zip only fills its fields and arranges them with kernel boxes, a rule and `framed`. Every body construct maps to an existing lib way, there is no artwork, and nothing needs a tool outside TeX. The one zip-local construct is `\renewcommand{\includelogo}{}` (main.tex:17), a reducible alias to empty. The CTAN copy and the zip's copy (`\ProvidesClass` date 2026/07/26, jourcl.cls:2) were not compared; if the class were read as zip-local it still reduces (see Bespoke code), so the verdict does not rest on that read.

## Blockers
none

## Class setting
- Class: `class.jourcl` options: `hidelinks` (main.tex:16). The class forwards unknown options to article (`\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}`, jourcl.cls:18) and loads `\LoadClass[a4paper,onecolumn]{article}` (jourcl.cls:53). It also declares reviewer-position options `top` `afterToEditor` `afterIntroduction` `afterAbstract` `bottom` (jourcl.cls:25-43); the sample passes none, and `\addreviewersPosition` is only defined, never read (grep over jourcl.cls and main.tex: lines 26,30,34,38,42 only).
- Class-native vocabulary used: sender fields `\NameSurname` `\AuthorOrcid` `\InstitutionName` `\StreetNo` `\CityPostal` `\Email` `\Phone` (main.tex:31-37); article fields `\JournalName` `\Title` `\Editor` `\abstract{}` (main.tex:40-47); letter parts `\toEditor` `\PersonAddressing` `\Introduction` `\final` `\declaration` `\conflictofinterest` `\valediction{\yourssincerely}` `\signature` (main.tex:49-56); reviewer slots `\FirstRecommended` `\FirstNameSurname` `\FirstInstitution` `\FirstEmail` and the Second and Third sets (main.tex:20-28); output macros `\aboutme{}` `\ptoEditor` `\pPersonAddressing` `\pIntroduction` `\pabstract` `\showreviewers` `\pfinal` `\pdeclaration` `\pconflictofinterest` `\pvalediction` `\psignature` and the `\pX` readers (main.tex:61-99; jourcl.cls:117,267,277-321); `\SpecialIssueSentence` (main.tex:51; jourcl.cls:256-260; `\SpecialIssue` is not set); `\includelogo` (main.tex:17; jourcl.cls:86-110).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:16; jourcl.cls:53 | `class.jourcl` | option `hidelinks`; the class loads article with `a4paper,onecolumn` |
| paper size, columns | jourcl.cls:53 | `page.class-options` | `a4paper`, `onecolumn`, fixed by the class (10pt article default) |
| page margins and head height | jourcl.cls:58-64 | `page.setlength` | `\addtolength` of `\oddsidemargin` and `\evensidemargin` -0.800in, `\textwidth` +1.75in, `\topmargin` -0.800in then -14.0pt, `\textheight` +1in; `\setlength{\headheight}{98.0pt}` |
| paragraph spacing | jourcl.cls:16,67,70 | `sp.lengths` | `\parindent` 0.1em (an earlier 0pt at :16 is overwritten), `\parskip` 1em |
| parskip package | jourcl.cls:7 | `sp.parskip-pkg` | no options; loaded before article (:53), and the lengths above are then set explicitly |
| input encoding | jourcl.cls:8 | `font.fontenc-t1` | `inputenc` option `utf8` |
| language | jourcl.cls:9 | `lang.babel` | option `english` |
| date format | jourcl.cls:12; main.tex:72 | `front.datetime` | `isodate` (CTAN, TeX Live) options `iso,american`; body `\today` |
| header block (letterhead) | main.tex:61-68; jourcl.cls:117-134 | `hf.class-native` | `\aboutme{}` sets `\pagestyle{fancy}` (`fancyhdr`, jourcl.cls:6), `\fancyhf{}`, `\headrulewidth` and `\footrulewidth` 0pt, head L a logo slot via `\raisebox`, head R `\large` + `tabular[t]{l@{}}` holding the sender lines; no page number |
| sender block layout | jourcl.cls:129-132 | `tbl.tabular` | one left-aligned column `l@{}`, top-aligned, used as the address stack in the head |
| icons in the header | main.tex:63,66,67; jourcl.cls:13 | `font.icons` | `fontawesome5` `\faIcon{university}`, `\faIcon{envelope}`, `\faIcon{phone-square-alt}` |
| ORCID logo | main.tex:62; jourcl.cls:55 | `font.icons` | `orcidlink` `\orcidlink{<id>}`, a hyperlinked logo from a short id string (considered as its own way, merged: a package prints a pictogram from a short argument) |
| hyperlink appearance | main.tex:16 | `meta.hyperref` | option `hidelinks`; it is passed down as a global option, and it acts only if a loaded package pulls in hyperref (that `orcidlink` does is not established: its CTAN page does not say and its source is not in the zip) |
| logo and signature images | jourcl.cls:5,75-110,319-321; main.tex:17 | `fig.graphicx` | `\includegraphics` with `scale=`, or `width=` and `height=` with `keepaspectratio`, or one of them; default `width=7cm,height=4cm`; signature `\showSignature` `width=4cm,height=4cm`. The sample draws neither: `\includelogo` is emptied (main.tex:17) and `\showSignature` is not called |
| full-width rule | main.tex:70 | `sp.rule` | `\rule{0.9\paperwidth}{0.4pt}` |
| rule box | main.tex:70 | `sp.manual-space` | `\noindent\makebox[\linewidth]{...}`, a kernel LR box set by a length (placed here as the nearest kernel box-and-length way) |
| body font size | main.tex:60 | `font.size-commands` | `\large` for the rest of the body |
| editor addressing, salutation, introduction | main.tex:49-51,74-79; jourcl.cls:245-250,277-282 | `front.class-native` | `\toEditor`, `\PersonAddressing`, `\Introduction`, `\SpecialIssueSentence`: strings stored in macros and printed in order |
| abstract | main.tex:43-47,82; jourcl.cls:285-286 | `abs.class-native` | `\abstract{}` is a string setter (it replaces article's `abstract` environment name); `\pabstract` prints it after the literal "Abstract: " |
| abstract box | main.tex:81-83; jourcl.cls:10 | `box.mdframed` | `framed` environment, no options |
| recommended reviewers row | main.tex:20-28,85; jourcl.cls:143-203,267-274 | `front.class-native` | three slots of role, name, institution, email; an empty role omits the slot |
| reviewer slot layout | jourcl.cls:194-199,269-273 | `box.minipage` | three `\parbox{.32\linewidth}` inside `center`, each holding a `tabular{p{1\linewidth}}` with `\centering` per line |
| reviewer slot lines | jourcl.cls:194-199 | `sp.ragged` | `\centering` per line; the `center` environment around the row (:269-273) |
| closing paragraphs | main.tex:52-54,89-93; jourcl.cls:289-298 | `front.class-native` | `\final`, `\declaration`, `\conflictofinterest` printed with `\newline` between them |
| valediction and signature | main.tex:55-56,97-99; jourcl.cls:301-312 | `front.class-native` | `\yourssincerely` expands to "Yours sincerely,\\" (jourcl.cls:305); it takes one ignored argument, so the `\par` that follows it (main.tex:97) is consumed as that argument |
| manual spacing and breaks | main.tex:76,87,89,91,95 | `sp.manual-space` | `\vspace*{1\baselineskip}`, `\vspace{-.7cm}`, `\newline` twice, `\vfill` |
| unused package | jourcl.cls:11 | `draft.todo` | `lipsum` loaded unconditionally, no `\lipsum` call in the class or sample; no printed effect |

Components the zip does not define or use: headings, lists, quotes, notes, footnotes, math, theorems, floats, captions, code, bibliography, index, contents, numbering, fonts beyond the defaults, colour (grep of both files shows no `\section`, `\begin{itemize}`, `\cite`, `\footnote`, `\definecolor`, `\usepackage` of a font package).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\includelogo}{}` | main.tex:17 | yes | an alias to empty: the emitter writes no logo (no `\includegraphics`), or the same one line; the head L field then holds an empty `\raisebox` |
| jourcl internals: string setters `\def\X#1{\def\@X{#1}}` with `\newcommand{\pX}{\@X}` readers | jourcl.cls:75-84,114-115,143-316 | not bespoke if the class is published (CTAN read above); if read as zip-local, yes | inline each stored string at its print site; `\newcommand` aliases are reducible by the rubric |
| `\ifcsname` branches (logo size, `\pLogoVerticalOffset`, `\SpecialIssueSentence`) | jourcl.cls:80-110,115,256-260 | same | each branch is one `fig.graphicx` option set or one sentence; the branch depends only on whether a field was set, which the emitter knows, so it is resolved at emission |
| `\ifempty` and `\RecommendedPerson` (box-size emptiness test) | jourcl.cls:138,184-203 | same | the emitter omits an empty slot and prints the `\parbox` + `tabular` otherwise; no conditional is copied |
| reviewer-position options and `\addreviewersPosition` | jourcl.cls:25-43 | yes | dead: defined, never read |
| reading note (not a blocker) | jourcl.cls:184-202 | n/a | `\ifempty` opens an `\ifx` (:184) and the two `\ifdim` (:187,:190) open two more, but only two `\fi` follow (:201,:202). From the source alone, an empty role (the sample's third slot, main.tex:28) may make TeX skip past the macro. Not compiled, so this is unverified; an emitter that omits empty slots does not meet it |

## Content-opaque
none (the logo and signature images are not shipped and are not drawn by the sample; the ORCID logo comes from the `orcidlink` package)

## Lib changes
- New ways proposed: none. Considered: `orcidlink` as a separate way; merged into `font.icons` (same effect type as `mark.hologo` merged in v3: a package prints a pictogram from a short argument). `isodate` fits `front.datetime` (a date-printing package is the parameter); its CTAN page lists the `\today` formats and gives no package options, so the options `iso,american` are recorded as the class passes them (jourcl.cls:12), not checked against the package.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes for the consolidator: the lib's class section needs `class.jourcl`; vocabulary is listed under Class setting. The CTAN page names a maintainer (Rok Kukovec) other than the zip's credited author (Iztok Fister Jr., ATTRIBUTION.txt:1); the zip and CTAN copies were not compared. No text in the zip addresses an AI.
