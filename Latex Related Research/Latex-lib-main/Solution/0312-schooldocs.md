yes

# 0312-schooldocs: schooldocs (a chemistry test sheet in the `exam` page style)

- Unverified: read from the source, not compiled.
- Source: Source/0312-schooldocs/ (origin: https://latextemplates.com/downloads/schooldocs.zip; licence: LPPL-1.3, README.md:33)
- Kind: exam (the manifest hint says assignment; the sample is a timed test, "Chemistry --- Test 4", duration line, answer-key switch: main.tex:13-14, 20)
- Lib: v3
- Engine: pdfLaTeX-compatible (inputenc utf8, T1, lmodern; no fontspec; README.md:17 builds with `pdflatex`)
- Look carried by: preamble (the published CTAN package `schooldocs`, loaded at main.tex:7 and switched to its `exam` page style at main.tex:11; the zip's schooldocs.sty is its vendored v1.6 release file, so it is not zip-local)
- Class origin: tex-distribution-unbundled (kernel `article`, main.tex:1, not in the zip)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (schooldocs.sty read in full, 405 lines; no .cls/.def/.cfg/.clo in the zip)

## Verdict
yes. The sample is a stock `article` plus one published package. `schooldocs` is on CTAN at the same version the vendored file declares (v1.6, 2025-01-15: schooldocs.sty:25; ctan.org/pkg/schooldocs read once, which also lists it in TeX Live), so it passes W1 and is the existing lib way `exam.schooldocs`: the page style, title block, head and foot and default geometry are chosen by a style name, strings, lengths, colours, font-switch macros and one boolean. `main.tex` defines no macro, environment or counter of its own, there is no artwork, and nothing needs a tool outside TeX. Caveat: the vendored file was not diffed against the CTAN release (nothing downloaded); the match rests on the version line and the docstrip header (schooldocs.sty:3-8, 25).

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper`, `11pt` (main.tex:1)
- Class-native vocabulary used: `\title` `\author` `\date` `\maketitle` (main.tex:13, 15, 16, 24, with schooldocs' redefinitions below), `\section*` (main.tex:26, 37), `enumerate` (main.tex:28, 39). From the package, not the class: `\title[short]{long}` (main.tex:13), `\subtitle{}` (main.tex:14), `\pagestyle{exam}` (main.tex:11), `\correct` (main.tex:20, commented out).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | a4paper, 11pt |
| paper and base size | main.tex:1 | `page.class-options` | a4paper, 11pt |
| page geometry | schooldocs.sty:26, 35 | `exam.schooldocs` | default set by the package: geometry (loaded unless already loaded) with scale=0.75, vmarginratio=3:4, heightrounded; the sample sets none of its own |
| encodings | main.tex:3-4 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| language | main.tex:5; schooldocs.sty:33, 37-67 | `lang.babel` | english; the package's own strings (page, Correct version, Name:) are looked up by the `translations` package from the babel language (fr, de, es, it, pt tables at :45-63) |
| text font | main.tex:6 | `font.lmodern` | none |
| running head | main.tex:11; schooldocs.sty:316-319, 121-133 | `exam.schooldocs` | page style `exam`: left and right empty on page 1; from page 2 the short title (`\headtitlestyle` = `\scshape`) left and the short subject (`\headsubjectstyle` = `\scshape`) right, in `\headstyle` = `\small\color{headingcolor}`; head rule drawn only when page is not 1 (:130-133); fancyhdr inside the package, `\headheight` = `\baselineskip` (:129) |
| running foot | main.tex:11; schooldocs.sty:320-326 | `exam.schooldocs` | left: author, a line break if an author is set, then school (`\schoolstyle` = `\scshape`); centre empty; right: page label (`\pagenamestyle` = `\textnormal`); all in `\footstyle` = `\small\color{headingcolor}` |
| page X of Y | schooldocs.sty:30, 326 | `exam.schooldocs` | totpages `\pageref{TotPages}`, label word from `\pagename` ("page" in English, :41, :65); needs two passes |
| title block | main.tex:13-16, 24; schooldocs.sty:345-361 | `exam.schooldocs` | `exam` `\maketitle[rule length]`: centred (the `center` environment is hard-coded here, not `\titleflush`, :347), title in `\titlestyle` = `\LARGE\MakeUppercase` (:329), then subject in `\subjectstyle` = `\Large\bfseries` (:330, empty in the sample), date, subtitle, then a rule of `\seprulelength` 2.5cm by `\seprulewidth` 0.3pt (:110-111); `\titletopskip` 0.67cm (:327), `\titlesep` 2\bigskipamount (:328), `\titlebottomskip` \medskipamount (:109) |
| short title for the head | main.tex:13; schooldocs.sty:70-76 | `exam.schooldocs` | `\title[Chemical Bonding]{...}`: the optional argument becomes `\@headtitle` for the running head; hyperref `pdftitle` is set only if hyperref is loaded (not in the sample) |
| exam duration line | main.tex:14; schooldocs.sty:313-315, 331-332, 354-356 | `exam.schooldocs` | `\subtitle{Duration: 50 minutes}`, printed under the date in `\subtitlestyle` = `\large\slshape` |
| author and date | main.tex:15-16; schooldocs.sty:103, 352-353 | `exam.schooldocs` | author goes to the foot (:321-322), `\date{\today}` in `\datestyle` = `\large`; `\today` is kernel |
| answer-key switch | main.tex:18-20 (commented out); schooldocs.sty:335-344 | `exam.schooldocs` | `\correct` (boolean, off in the sample): appends "--- Correct version" to the head title, sets the subtitle to `\correctname`, `\titlecorrectstyle` = `\color{red}\large\scshape` (:334) |
| colours | schooldocs.sty:32, 100, 120 | `exam.schooldocs` | `titlecolor` and `headingcolor`, both named black (xcolor loaded inside the package) |
| sectioning | main.tex:26, 37 | `head.kernel` | stock `\section*`, unnumbered, no redefinition |
| lists | main.tex:9, 28, 39 | `list.enumitem` | `enumerate` with `label=\arabic*.`; second list `resume,label=\arabic*.` |
| math | main.tex:8, 34 | `math.amsmath` | loaded; the only math is one inline `CO$_2$` (content) |
| emphasis | main.tex:46 | `mark.kernel` | `\emph` |
| other page styles and title commands (not used by the sample) | schooldocs.sty:185-214 classic, 216-226 elegant, 228-266 modern, 268-304 soft, 306-310 identity, 364-402 collection; 80-99 `\school` `\institute` `\subject`; 153-166 `\makesmalltitle`; 182-183 `\seprule` | `exam.schooldocs` | same way, other values of the page-style name; `\titleflush` string (:105) used by the non-exam styles |

Not in the sample, so nothing to map: abstract, contents, theorems, floats, tables, captions, footnotes, code, boxes, bibliography, index, cross-references, appendix. `fancybox` is loaded by the package (schooldocs.sty:31) but its only use, `\boxedshape` with `\shadowbox` (:113-118), is defined and never called in the package or the sample.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `schooldocs.sty` as a whole (redefined `\title`, `\maketitle`, `\headrule`, `\correct`, `\subtitle`; page styles; default geometry) | schooldocs.sty:1-403 | not bespoke: published CTAN package v1.6 2025-01-15 (schooldocs.sty:25, README.md:34), W1 holds | one way, `exam.schooldocs`; the emitter prints `\usepackage{schooldocs}`, `\pagestyle{exam}`, `\title[..]{..}` `\subtitle` `\author` `\date`, `\maketitle`; ship the file (README.md:12-13 says it is not on a default TeX Live install, CTAN lists it in TeX Live) |
| macros, environments, counters, conditionals in `main.tex` | main.tex:1-50 | none exist | no `\newcommand`, `\def`, `\newenvironment` or counter in the sample |

Dependencies of the package, all published and loaded unconditionally (schooldocs.sty:26-33): geometry, fancyhdr, ifthen, totpages (ctan.org/pkg/totpages read: CTAN, TeX Live), fancybox, xcolor, translations (ctan.org/pkg/translations read: CTAN, TeX Live). None needs a tool outside TeX.

## Content-opaque
none

## Lib changes
- New ways proposed: none. The look fits the existing `exam.schooldocs` (lib line 374); no way outside the lib is used.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
