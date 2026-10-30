yes

# 0749-limecv: LimeCV (CV with a coloured sidebar)

- Unverified: read from the source, not compiled.
- Source: Source/0749-limecv/ (origin: https://latextemplates.com/downloads/limecv.zip; licence: LPPL-1.3c)
- Kind: cv
- Lib: v5
- Engine: pdfLaTeX-compatible (taken from the starter's own comment, main.tex:3-4, "verified under pdflatex"; not checked here. The CTAN page https://ctan.org/pkg/limecv titles the class "(Xe/Lua)LaTeX" and links an XeLaTeX example, so the engine tag is a claim to confirm)
- Look carried by: class (the zip holds one 85-line `main.tex`; every look decision is made by the published class `limecv`, which the zip does not ship)
- Class origin: tex-distribution-unbundled (class `limecv` v0.1.12 is on CTAN, in TeX Live and MiKTeX, LPPL 1.3c, Olivier Pieters; main.tex:2 says "ships with TeX Live — not bundled here")
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip has no `.cls`, `.sty` or other class file; the class source was not read, because it is not in the zip and only ctan.org/pkg/limecv was consulted)

## Verdict
The sample is a starter that loads the published class `limecv` with option `a4paper`, one `geometry` line, one `\cvSetLanguage` call, and class environments and commands filled with content (main.tex:5-85). It defines no macro, environment, counter, package or file of its own, so there is no bespoke code and no artwork in the zip. An emitter would print `\documentclass[a4paper]{limecv}`, the `geometry` line and the class vocabulary, so the answer is `yes`, in the "carried by a published class" sense of the rubric: this is evidence about the class dimension. The class source and its package loads were not read, so what the class loads unconditionally (an external tool would make it `EXTERNAL/package`) is unchecked; nothing on the CTAN page suggests one.

## Blockers
none

## Class setting
- Class: `class.limecv` options: `a4paper` (main.tex:5)
- Class-native vocabulary used (recorded from the sample only; the class source was not read, and the CTAN page lists no commands):
  - preamble: `\cvSetLanguage{english}` (main.tex:7); length `\cvMargin` read by `geometry` (main.tex:6)
  - sidebar: environments `cvSidebar` (main.tex:11), `cvProfile` (14), `cvContact` (20), `cvLanguages` (28), `cvInterests[short]` (34); commands `\cvID{first}{last}{}{job title}` (12), `\cvContactAddress` (21), `\cvContactEmail{mailto:..}{text}` (22), `\cvContactPhone` (23), `\cvContactWebsite{url}{text}` (24), `\cvContactLinkedin{url}{text}` (25), `\cvLanguage{name}{level}` (29-31), `\cvInterestsPersonal` (35), `\cvInterestsProfessional` (38), `\cvInterest{}{text}` (36, 37, 39)
  - main column: environments `cvMainContent` (44), `cvEducation` (46), `cvExperience` (54), `cvSkills` (66), `cvReferences` (72); commands `\cvItem{text}` (47, 50, 55, 58, 61), `\cvSkillTwo{lvl}{name}{lvl}{name}` (67-69), `\cvAddReference{key=value list}` (73-80)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:5 | `class.limecv` | option `a4paper`; vocabulary listed above |
| paper size | main.tex:5 | `page.class-options` | `a4paper` |
| page geometry | main.tex:6 | `page.geometry` | `margin=\cvMargin` (a length the class defines; its value was not read), `noheadfoot` (no header or footer space; this is the only header/footer statement in the sample, no `hf.*` way is set) |
| language / keyword names | main.tex:7 | `class.limecv` | `\cvSetLanguage{english}`, a class command (the effect on printed heading names is inferred, not read); no separate lang way is needed because it is class vocabulary |
| colour, sidebar fill, fonts | main.tex:1 | `class.limecv` | "coloured sidebar" per the comment; the sample passes no colour or font option, so these are class defaults (not read) |
| name and job title block | main.tex:12 | `front.class-native` | `\cvID{Astrid}{Lindqvist}{}{Structural Engineer}`; third argument empty (a photo slot is a guess) |
| sidebar profile text | main.tex:14-18 | `cv.entries` | `cvProfile` environment holding a paragraph |
| contact block | main.tex:20-26 | `cv.entries` | `cvContact` with address (a `\\` break inside), email and website and LinkedIn (URL plus display text), phone |
| contact and interest icons | main.tex:3-4 | `font.icons` | claim only: the comment says the class falls back to `fontawesome5` under pdflatex and uses icon fonts under Xe/LuaLaTeX; the sample never names an icon (the `\cvInterest` icon argument is empty at 36, 37, 39) |
| language levels | main.tex:28-32 | `cv.entries` | `\cvLanguage{name}{level}` with levels 5, 5, 3 (scale maximum not read) |
| interests | main.tex:34-40 | `cv.entries` | option `short`; two group switches `\cvInterestsPersonal` and `\cvInterestsProfessional`; `\cvInterest{icon}{text}` rows |
| main column and its section headings | main.tex:44, 46, 54, 66, 72 | `head.class-native` | headings are presumably printed by the `cvEducation`, `cvExperience`, `cvSkills` and `cvReferences` environments (inferred from the names; nothing sets a heading style in the sample) |
| education and experience entries | main.tex:46-64 | `cv.entries` | `\cvItem{...}` with `\\` line breaks between role, place and description; the three `\cvItem` calls in `cvExperience` end `};` (57, 60, 63) with a stray `;` that is outside the template (content or harmless, not checked) |
| small-caps employer names | main.tex:56, 59, 62 | `mark.kernel` | `\textsc{...}` |
| manual line breaks in entries | main.tex:21, 47-48, 55-56 | `sp.manual-space` | `\\` |
| skills with levels | main.tex:66-70 | `cv.entries` | `\cvSkillTwo{lvl}{name}{lvl}{name}`, two skills per call, levels 3 to 5 |
| references | main.tex:72-81 | `cv.entries` | `\cvAddReference{key=value list}` with keys `name`, `company`, `position`, `address line 1`, `address line 2`, `mobile phone`, `email` |

Not used by the sample (no row needed): floats, tables, captions, theorems, math, code, boxes, bibliography, index, cross-references, footnotes, contents, numbering, lists other than the class entries.

## Bespoke code
none (no `\newcommand`, `\def`, `\newenvironment`, counter, conditional or file of the zip's own; main.tex has no `\usepackage` other than `geometry`)

## Content-opaque
none (the text, the dates, the skill and language level numbers and the reference data are content; the level marks and the sidebar shape are drawn inside the published class, which is the class way's own rendering, not zip artwork)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
