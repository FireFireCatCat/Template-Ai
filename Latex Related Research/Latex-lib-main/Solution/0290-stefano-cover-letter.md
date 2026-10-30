no

# 0290-stefano-cover-letter: Stefano Cover Letter (friggeri-letter)

- Unverified: read from the source, not compiled.
- Source: Source/0290-stefano-cover-letter/ (origin: https://latextemplates.com/downloads/stefano-cover-letter.zip; licence: MIT)
- Kind: letter
- Lib: v3
- Engine: needs XeLaTeX (`fontspec` with `Mapping=tex-text` at friggeri-letter.cls:62,78-79, `unicode-math` at friggeri-letter.cls:65; main.tex:5-7 says the class is XeLaTeX-only)
- Look carried by: zip-local (the banner, colours and fonts are all in friggeri-letter.cls; main.tex's preamble adds only `babel`)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
No. The look is carried by the zip-local `friggeri-letter.cls`, which loads the kernel `letter` class and then redefines `\opening` to draw a full-width coloured banner with the sender's name and subtitle by a `remember picture,overlay` TikZ picture anchored at `current page.north` (friggeri-letter.cls:104-114). That banner is the template's identity and has no declarative lib way, so it is `ART`; the `\opening` redefinition around it leans on letter-class internals and is `BESPOKE`. Everything else (fonts, colours, address and recipient blocks, babel) maps to lib ways, and the class is not on CTAN (ctan.org/pkg/friggeri-letter and ctan.org/pkg/friggeri-cv both returned 404), so it is not a published way.

## Blockers
- `ART/class` TikZ overlay banner: a `minimum width=\paperwidth, minimum height=4cm` filled rectangle at `current page.north`, with the first name, last name and subtitle as nodes (friggeri-letter.cls:104-114)
- `BESPOKE/class` redefinition of the kernel letter `\opening` that mixes the banner with the kernel-internal macros `\@date`, `\toname`, `\toaddress`, `\fromaddress`, `\@empty`, a branch `\ifx\@empty\fromaddress` choosing the page style and the layout, and spacing tuned against the overlay (`\vspace{-2\parskip}`, `\headheight` reset) (friggeri-letter.cls:97-99,103-146)

## Class setting
- Class: `class.letter` options: `a4paper` (main.tex:12, forwarded to `letter` by the catch-all option at friggeri-letter.cls:6-8); `english` rides along as a global option that `babel` picks up (main.tex:12-13); `print` exists but the sample does not use it (friggeri-letter.cls:5). The zip-local wrapper class `friggeri-letter` (friggeri-letter.cls:2) sits on top of `letter` (friggeri-letter.cls:11) and is not itself a published way.
- Class-native vocabulary used: kernel letter `\address` (main.tex:19), `\letter{recipient}` used as a bare command with no `\begin{letter}` or `\end{letter}` (main.tex:24), `\opening` (main.tex:31, redefined by the zip-local class), `\closing` (main.tex:52-54); zip-local `\header{first}{last}{subtitle}` (main.tex:17, friggeri-letter.cls:14-18).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | friggeri-letter.cls:11 | `class.letter` | loaded by the zip-local wrapper, options passed through (friggeri-letter.cls:6-9) |
| paper size | main.tex:12; friggeri-letter.cls:6-8 | `page.class-options` | a4paper |
| head height / page.north | friggeri-letter.cls:99 | `page.setlength` | `\headheight` = 0pt (reset "where current page.north is") |
| language | main.tex:12-13 | `lang.babel` | no package option; `english` comes from the global class option |
| main text face | friggeri-letter.cls:62,79 | `font.fontspec` | `quiet`; `\setmainfont` Nimbus Sans, `Mapping=tex-text`, `Color=textcolor` |
| extra font families | friggeri-letter.cls:73-76,78 | `font.fontspec` | `\newfontfamily` `\bodyfont` and `\thinfont` (Nimbus Sans regular), `\headingfont` [Bold], `\positionfont` [Italic]; `\defaultfontfeatures{Mapping=tex-text}`; only `\thinfont` and `\bodyfont` are used by the banner (friggeri-letter.cls:108,112) |
| math font | friggeri-letter.cls:65,81 | `font.unicode-math` | loaded with empty options, `\setmathfont` commented out |
| font sizes | friggeri-letter.cls:107,111 | `font.size-commands` | `\fontsize{40pt}{72pt}` name, `\fontsize{14pt}{24pt}` subtitle |
| colour palette | friggeri-letter.cls:25-37,54-55 | `color.xcolor` | `\definecolor` white, darkgray, gray, lightgray, green, orange, purple, red, blue; `\colorlet{textcolor}{gray}`, `{headercolor}{gray}` |
| colour set by option | friggeri-letter.cls:39-53 | `color.xcolor` | default: `fillheader`=gray, `header`=white, `fromcolor`=red; `print` option: all accents gray, `fillheader`=white, `header`=gray (boolean switch between two colorlet sets; sample uses the default) |
| name and subtitle banner (first page top) | friggeri-letter.cls:104-114 | `art.tikz` | **ART**: overlay rectangle `fill=fillheader`, `minimum width=\paperwidth`, `minimum height=4cm` at `current page.north`; name node 40pt/72pt, subtitle node 14pt/24pt below it |
| banner data | main.tex:17; friggeri-letter.cls:14-18 | none (zip-local `\header`, rides with the banner) | `\header{Marguerite~}{Okafor}{Structural Engineer}` stores `\firstname` `\lastname` `\subtitle` |
| sender address | main.tex:19-22; friggeri-letter.cls:135-143 | `ltr.opening` | kernel `\address`; printed by the zip-local `\opening` flush right |
| sender address block layout | friggeri-letter.cls:140-142 | `sp.ragged`, `tbl.tabular`, `sp.manual-space` | `\raggedleft`, one-column `tabular{l@{}}`, `\\*[2\parskip]` gap, then `\@date` |
| date | friggeri-letter.cls:137,142 | `ltr.opening` | kernel `\@date` (the letter class's `\today`), flush right |
| first-page page style | friggeri-letter.cls:136,139 | `hf.pagestyle-kernel` | `\thispagestyle{firstpage}` (no sender address) or `{empty}` (sender address given); `firstpage` is the letter class's own style (kernel source not read) |
| recipient block | main.tex:24-29; friggeri-letter.cls:144 | `ltr.opening`, `sp.ragged` | kernel `\letter{...}` argument (name, then `\\` lines), printed by `\raggedright \toname \\ \toaddress` |
| salutation | main.tex:31; friggeri-letter.cls:146 | `ltr.opening` | `\opening{Dear Hiring Committee,}` printed after `\vspace{2\parskip}` with `\par\nobreak` |
| spacing around the head | friggeri-letter.cls:116,145 | `sp.manual-space` | `\vspace{-2\parskip}`, `\vspace{2\parskip}` |
| body paragraphs | main.tex:33-50 | none template-defined | plain paragraphs under the letter class's own defaults; `---` at main.tex:41 is content |
| closing and name | main.tex:52-54 | `ltr.opening` | kernel `\closing{Yours sincerely\\ Marguerite Okafor}` (the name typed in the closing, no `\signature`) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\opening` redefinition (banner + address/date/recipient block + page-style branch) | friggeri-letter.cls:103-146 | No (as a whole) | The part after the banner (flush-right `tabular`, `\raggedright` recipient, two `\vspace`) would be `ltr.opening` + `sp.ragged` + `tbl.tabular` + `sp.manual-space`, but the macro is one unit built on kernel letter internals and the overlay, so copying it is zip-local macro logic; the banner inside it is ART |
| `\header` and the `\firstname` `\lastname` `\subtitle` stores | friggeri-letter.cls:14-18 | Only as aliases | Plain `\def` string stores; their only consumer is the banner, so they cannot leave with it |
| option `print` and `\@cv@print` conditional | friggeri-letter.cls:5,39-53 | Yes | One boolean choosing between two `\colorlet` sets (`color.xcolor`); an emitter can pick the set at write time |
| `\rolefont` (14pt/24pt, `\positionfont`, white) | friggeri-letter.cls:91-95 | Yes | `font.size-commands` + `font.fontspec` + `color.xcolor`; defined but never called in `\opening` or main.tex |
| `\headheight` reset | friggeri-letter.cls:97-99 | Yes | `page.setlength` `\headheight` = 0pt; exists only to place the overlay |
| `\headingfont` `\positionfont` families | friggeri-letter.cls:75-76 | Yes | `font.fontspec` `\newfontfamily`; never called by `\opening` or main.tex |
| dead commented-out variant of `\opening` | friggeri-letter.cls:117-134,148 | n/a | comments, not code |

## Content-opaque
none (the TikZ picture is the template's own banner, not figure content, so it is the `ART` blocker above)

## Lib changes
- New ways proposed: none. Considered for the banner, and rejected because each still takes picture code as its content or places boxes in the text flow rather than at `current page.north`: `bg.eso-pic`, `bg.background`, `bg.tikzpagenodes` (already marked ART when it draws identity), `box.tcolorbox`. Missing assets: Nimbus Sans is a system font, not shipped in the zip (main.tex:9-11, friggeri-letter.cls:67-72 say the original Roboto family was substituted).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
