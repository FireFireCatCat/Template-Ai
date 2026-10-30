yes

# 0560-pat-s-resume: Pat's Resume

- Unverified: read from the source, not compiled.
- Source: Source/0560-pat-s-resume/ (origin: https://latextemplates.com/downloads/pats-resume.zip; licence: MIT)
- Kind: cv
- Lib: v4
- Engine: pdfLaTeX-compatible (README.md:15 builds with `pdflatex main`; the class source was not read, so this is the README's statement, not checked in code)
- Look carried by: class (the sample adds only a flag, string settings and content; every visual rule lives in the published class `pats-resume`, which is not in the zip)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles none present (the zip holds only `main.tex` and `README.md`; `pats-resume.cls` is not bundled, README.md:10)

## Verdict
Yes, with a limit on the evidence. The whole look is the published class `pats-resume` (CTAN page https://ctan.org/pkg/pats-resume: Patrick Benito Eberhard, MIT, version 2025-03-02, listed in TeX Live and MiKTeX), which passes W1 to W4 as one `class.*` way. The sample sets no class option, defines no macro, environment or counter, and its only own code is one `\def` used as an on/off flag for the class. There is no artwork, no external tool and no zip-local file. The class source was not read, so the way each class command realises its look (fonts, colours, margins, rules) is not decomposed here.

## Blockers
none

## Class setting
- Class: `class.pats-resume` options: none (`\documentclass{pats-resume}`, main.tex:1)
- Class-native vocabulary used (commands the sample calls; the CTAN page documents none, so the names come from the sample and the argument roles are inferred from the sample's content only):
  - Header strings (preamble): `\setname{}` `\setemail{}` `\setphone{}` `\setlinkedin{}` `\setgithub{}` (main.tex:8-12)
  - Section heading: `\ResumeSection{title}` (main.tex:16, 36, 71, 77, 89)
  - Entry: `\entry{item}{role or authors}{place or empty}{dates or status}`, four arguments (main.tex:18, 24, 30, 37, 45, 53, 61, 72, 74, 79, 81, 83, 85, 87)
  - Entry bullets: `\details{\item ...}` (main.tex:19-22 and following)
  - Wrappers: `\tech{...}` around `\details` (main.tex:38-43, 46-51, 54-59), `\gpa{...}` around an item or a phrase (main.tex:21, 27, 32), inline tag `\tools{a, b}` (main.tex:49, 50, 56, 58, 64, 65)
  - Skills row: `\skill{label}{text}{}{}`, four arguments, the last two empty (main.tex:91, 93, 95)
  - Flags set with `\def`: `\techFlag` (on, main.tex:4), `\consultingFlag` and `\gpaFlag` (off, commented, main.tex:5-6)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.pats-resume` | no options; page size, margins, fonts, colours, rule and spacing are all inside the unread class |
| page, fonts, colour, spacing (not set by the sample) | main.tex:1 | `class.pats-resume` | the sample sets none of these; the class decides them (not read) |
| name and contact header | main.tex:8-12 | `front.class-native` | name "Patrick Benito Eberhard", email, phone, linkedin and github handle as strings; printed by the class (no `\maketitle` in the body, main.tex:14-98) |
| section headings | main.tex:16, 36, 71, 77, 89 | `head.class-native` | `\ResumeSection{Education}`, `{Experience}`, `{Publications}`, `{Honours and Awards}`, `{Skills and Interests}`; no `\section`, no `\titleformat` |
| education and experience entries | main.tex:18, 24, 30, 37, 45, 53, 61 | `cv.entries` | `\entry{institution}{degree or role}{city, country}{date range}`; four string arguments |
| publication and honour entries | main.tex:72, 74, 79, 81, 83, 85, 87 | `cv.entries` | same `\entry`, third argument empty `{}`; second argument holds the authors or the awarding body, fourth the status or date |
| entry bullets | main.tex:19-22, 25-28, 31-33, 39-43, 47-51, 55-59, 62-67 | `cv.entries` | `\details{ \item ... }` wrapper; the `\item` lines imply a list environment inside it, whose kind (kernel itemize or a list package) is decided in the unread class |
| bullet list items | main.tex:20-21, 26-27, 32, 40-42, 48-50, 56-58, 63-66 | `list.kernel` | `\item` only, no optional labels (inferred from the sample; the class's list package was not read) |
| optional GPA text | main.tex:21, 27, 32; flag main.tex:6 | `cv.entries` | `\gpa{...}` around content; shown or hidden by the class flag `\gpaFlag` (here commented out, off) |
| technical-role marker | main.tex:38-43, 46-51, 54-59; flag main.tex:4 | `cv.entries` | `\tech{\details{...}}`; styling switched by `\techFlag`, defined empty (on) |
| inline tool tags | main.tex:49, 50, 56, 58, 64, 65 | `cv.entries` | `\tools{comma-separated list}` at the end of an item |
| skills rows | main.tex:91, 93, 95 | `cv.entries` | `\skill{label}{text}{}{}`: three rows (labels "Languages", "Interests", "Programming Languages"), the last two arguments empty in each |
| italic project names | main.tex:42, 63 | `mark.kernel` | `\textit{...}` |
| manual vertical gap | main.tex:75 | `sp.manual-space` | `\vspace{5pt}` before the Honours section |
| dashes, `\%` | main.tex:18, 24, 48 | (content) | `--`, a Unicode en dash followed by `-`, and `\%`; text, not template |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\techFlag{}` | main.tex:4 | yes | An empty definition used as a boolean the published class tests; a preamble line the emitter prints as is when the "technical roles" style is on and omits when off (a W2 boolean parameter of `class.pats-resume`). The sample defines no code behind it. |
| `\consultingFlag`, `\gpaFlag` | main.tex:5-6 (commented out, inactive) | yes | Same switch type, off here; the emitter would write the `\def` line only when set. |

No `\newcommand`, `\renewcommand`, `\newenvironment`, counter, conditional or `\makeatletter` appears in main.tex (checked by grep for `\def`, `\newcommand`, `\usepackage`, `\RequirePackage`: only main.tex:4 matches).

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Note for the consolidator: the lib's class section has no `class.pats-resume` line yet. Profile: `pats-resume` (CTAN and TeX Live, MIT, Patrick Benito Eberhard); one-page CV; `\setname` `\setemail` `\setphone` `\setlinkedin` `\setgithub`, `\ResumeSection`, `\entry`, `\details`, `\gpa`, `\tech`, `\tools`, `\skill`, flags `\techFlag` `\consultingFlag` `\gpaFlag`; no class options used in this sample.

## What was not read
- `pats-resume.cls` (not in the zip, no local TeX distribution on the analysing machine, and the rules allowed only ctan.org/pkg page reads, which do not show the source). Its fonts, margins, colours, hyperlink handling, package loads and the exact effect of the three flags are unknown. The verdict follows the rubric's rule for a published class that is not bundled (one way, source not read) and the pilot ruling for a look carried entirely by a published class.
- Unconfirmed from the source: whether the class loads any package that needs a tool outside TeX. README.md:15-18 says two `pdflatex` runs and no bibliography, which points away from one, but that is the README's claim.
