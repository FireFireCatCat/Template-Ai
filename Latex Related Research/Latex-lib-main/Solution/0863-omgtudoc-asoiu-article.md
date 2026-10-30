yes

# 0863-omgtudoc-asoiu-article: omgtudoc-asoiu Article (ASOIU course-project starter)

- Unverified: read from the source, not compiled.
- Source: Source/0863-omgtudoc-asoiu-article/ (origin: https://latextemplates.com/downloads/omgtudoc-asoiu.zip; licence: LPPL-1.3c per the manifest, README.md:9 says "LPPL 1.3c or later")
- Kind: assignment (a Russian university course project, `courseproj`; the manifest hint "article" is not used)
- Lib: v6
- Engine: needs XeLaTeX or LuaLaTeX (README.md:12 "Compile with LuaLaTeX (XeLaTeX is also supported ...)"; the CTAN page of the class says it "requires XeLaTeX or LuaLaTeX")
- Look carried by: class (the zip holds only main.tex and README.md; every visible look decision is made by the published class `omgtudoc-asoiu`, the preamble only loads `amsmath` and `booktabs`)
- Class origin: tex-distribution-unbundled (README.md:8-10: "supplied by the pinned TeX distribution and are not bundled"; ctan.org/pkg/omgtudoc-asoiu read once: Danila A. Kondratenko, v1.1b of 2025-02-21, LPPL 1.3, "contained in TeX Live and MiKTeX", based on the `article` class, GOST 7.32-2017)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the class source is not in the zip and was not read)

## Verdict
The zip is a 65-line sample plus a README. All the look comes from one published class, `omgtudoc-asoiu` (CTAN, TeX Live, MiKTeX, LPPL), which is not bundled, so it is one class way and its source was not read. The sample defines no macro, environment, counter or drawing of its own: it sets one class option, fills class-native front-matter fields and then uses kernel sectioning, `abstract`, `equation` (`amsmath`) and a `booktabs` table with `\caption`/`\label`/`\ref`. An emitter could write all of it from published ways, so the answer is `yes`. This is evidence about the class dimension, not about component ways: what the class loads and sets internally (fonts, language, geometry, title-page layout, caption wording) is not decomposed here.

## Blockers
none (limit of this reading: the class source was not read, so a hidden dependency inside it cannot be excluded; the CTAN page names no external tool and the README names none)

## Class setting
- Class: `class.omgtudoc-asoiu` options: `courseproj` (main.tex:1). README.md:3-4 calls the starter "minimal document mode" while main.tex:1 passes `courseproj`; the class source was not read, so what each option switches is not known here. The CTAN page lists no options.
- Class-native vocabulary used (main.tex:6-14):
  - `\studentname{..}{..}{..}{..}{..}{..}` with six arguments (main.tex:6; they read as surname, name, patronymic and then the same three in a second case form; inferred from the content, not from source)
  - `\studentgroup{ИВТ-401}` (main.tex:7), `\studentid{260184}` (main.tex:8)
  - `\directionIVT` (main.tex:9), a no-argument direction switch
  - `\courseprojsubject{..}` (main.tex:10), `\courseprojtheme{..}` (main.tex:11)
  - `\professorvalue{доцент}` (main.tex:12), `\professorinitials{П. П. Петров}` (main.tex:13)
  - `\docyear{2026}` (main.tex:14)
  - the standard `\maketitle` (main.tex:18), `abstract` environment (main.tex:20-24) and `\section` (main.tex:26) are called as in `article`

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.omgtudoc-asoiu` | option `courseproj`; class is article-based, XeLaTeX/LuaLaTeX only |
| title block and front-matter fields | main.tex:6-14, main.tex:18 | `front.class-native` | the fields listed under "Class setting" (strings; `\directionIVT` a switch); `\maketitle` prints the class's own title block |
| abstract | main.tex:20-24 | `abs.kernel` | plain `abstract` environment; the class may restyle it (source not read, README.md:3-6 says the class sets typography) |
| headings | main.tex:26, 31, 55, 60 | `head.kernel` | four numbered `\section`, no `\subsection`; the heading look is class-set and unread (README.md:5 "numbered sections") |
| display math | main.tex:3, 34-36 | `math.amsmath` | `\usepackage{amsmath}`; one numbered `equation` with `\frac`, `\cdot`, `\,\%` |
| inline math | main.tex:32, 37 | `math.amsmath` | `$n$`, `$k$`, `$q_0$` |
| table float | main.tex:40-41, 44 | `tbl.tabular` | kernel `table[ht]`, `\centering`, `tabular{lrrr}` |
| table rules | main.tex:4, 45, 47, 51 | `tbl.booktabs` | `\usepackage{booktabs}`; `\toprule` `\midrule` `\bottomrule` |
| caption | main.tex:42 | `cap.kernel` | kernel `\caption` above the table; caption label and separator wording are class-set and unread |
| cross-reference | main.tex:43, 56 | `xref.kernel` | `\label{tab:quality}`, `Из таблицы~\ref{tab:quality}` |
| page geometry, fonts, language, colour, running heads | not in the sample | `class.omgtudoc-asoiu` | set inside the class (README.md:5-6 "typography", CTAN page "GOST 7.32-2017"); not decomposed because the source was not read |
| Cyrillic text input | main.tex:6-14, 20-63 | `class.omgtudoc-asoiu` | UTF-8 text with no language or font command in the preamble, so the class supplies them |

Not used by the sample: contents, lists, theorems, figures, code, boxes, bibliography, index, footnotes, appendix.

## Bespoke code
none. main.tex defines no `\newcommand`, `\def`, environment, counter or conditional (checked by reading all 65 lines). The class's own macros are published, so they are not zip-local bespoke code.

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Files in the zip: main.tex (65 lines) and README.md (12 lines); no .cls, .sty, .cfg or .bst. Missing assets: the fonts the class loads are not known and are not shipped (recorded, not a blocker).
- Text addressed to an AI inside the zip: none found.
