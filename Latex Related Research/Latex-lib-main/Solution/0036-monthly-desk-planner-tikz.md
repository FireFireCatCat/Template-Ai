no

# 0036-monthly-desk-planner-tikz: Monthly Desk Planner (TikZ)

- Unverified: read from the source, not compiled.
- Source: Source/0036-monthly-desk-planner-tikz/ (origin: https://latextemplates.com/downloads/monthly-desk-planner-tikz.zip; licence: GPL-3.0)
- Kind: calendar
- Lib: v1
- Engine: needs XeLaTeX or LuaLaTeX (`fontspec` `\setmainfont{DejaVu Sans}`, main.tex:52-53; README.md:15 asks for lualatex)
- Look carried by: preamble (kernel `article` carries nothing; the whole sheet is the sample's own TikZ drawing in two overlay `tikzpicture`s, main.tex:68-332 and 334-368, driven by preamble colours, lengths and macros, main.tex:23-36, 71-102; the zip ships no .cls, .sty or other style file)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; README.md and LICENSE are documentation and the GPL-3.0 text)
- Read: main yes, zip-local classes and styles none present

## Verdict
No. The page has no running text: it is a landscape A4 sheet whose entire look is hand-programmed TikZ `calendar` drawing on `current page` overlays (day grid, weekday and month captions, four side panels, a three-box bottom strip, month index tabs, cut and punch marks), which is template-defining artwork with no declarative lib way. It is also driven by hand-rolled logic: a recursive `\stripzero` macro, `\newcount` and `\ifnum` conditionals that change the bottom strip height and tab positions, and Julian-date arithmetic that sets the grid. Only the class, paper, geometry, font, colour and size commands map to lib ways; nothing in the body does.

## Blockers
- `ART/body` calendar grid and weekday/month captions drawn with the TikZ `calendar` library, `day code`/`execute ... scope` hooks (main.tex:133-253)
- `ART/body` four side panels Focus / People to see / Places to go / Not to-do list, headed boxes placed with `positioning` (main.tex:255-268)
- `ART/body` bottom strip Personal Projects / Work Projects / Notes with `\foreach` ruled lines in `let ... in` coordinates (main.tex:270-322)
- `ART/body` month index tabs on the right edge: dotted rule plus rotated filled node per month, positions from the month number (main.tex:162-182)
- `ART/body` cut-corner marks and eight punch-guide dots on the page edges (main.tex:334-368)
- `BESPOKE/body` counter-driven layout: `\weekrows` counted on each Sunday, `\ifnum\the\weekrows = 5` then `\renewcommand{\notesheight}{2}`, offset from `\pgfmathsetmacro\offset{(\the\weekrows+1) * \dayh + \weekh}` (main.tex:113-115, 272-281)
- `BESPOKE/body` calendar geometry computed in the picture: Julian-date start/end of the grid (main.tex:117-128), `\bugfixspace` set by weekday conditionals (main.tex:144-148), Wednesday and Sunday `pgftransform` shifts that split each week into a left and right half (main.tex:204-217), and the `\ifnum \myBmonth > 7` branch that stacks the tabs Aug to Dec above Jan to Jul (main.tex:162-182)
- `BESPOKE/preamble` `\stripzero`, a recursive `\expandafter` zero-stripper that feeds tab arithmetic (main.tex:25-26)
- `UNMAPPED/body` no lib way holds a calendar: the `calendar` library's day layout is `day code` and `execute before/after day scope` programs (fails W2), so it stays inside restricted `art.tikz`; no new way is proposed (see Lib changes)

## Class setting
- Class: `class.article` options: `a4paper`, `landscape` (main.tex:13)
- Class-native vocabulary used: none (no `\maketitle`, `abstract`, sectioning, lists or floats appear in the body; main.tex:58-374 holds only two `tikzpicture`s)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:13 | `class.article` | `a4paper,landscape`; kernel class, source not in the zip and not read |
| paper size and orientation | main.tex:13 | `page.class-options` | `a4paper`, `landscape` (297mm x 210mm) |
| page geometry | main.tex:16 | `page.geometry` | `margin=0pt` (commented alternative `total={297mm,210mm}` at :17-21 is dead); the drawing owns the whole sheet |
| header/footer | none: no `\pagestyle`, `\thispagestyle` or `fancyhdr` (grep, main.tex) | none | the kernel default is left untouched |
| main font | main.tex:52-53 | `font.fontspec` | `\setmainfont{DejaVu Sans}`; PATCHED substitute for upstream Fira Sans Light (main.tex:46-51); the font is not shipped, it comes with the TeX distribution |
| text sizes and weight inside nodes | main.tex:35, 155, 189, 222, 252, 255 | `font.size-commands` | `\tiny`, `\footnotesize`, `\normalsize`, `\LARGE` with the kernel `\bf` switch; set as TikZ node `font=` options |
| colours | main.tex:93-102 | `color.xcolor` | `\definecolor` in `gray` model (.22, .35, .8, .6, 1) and `RGB` (58,110,143); `black!50`, `black!5` mixes (main.tex:61, 163); xcolor arrives through `tikz` |
| upper-casing of captions | main.tex:161, 171, 200, 258-284 | none (kernel command inside node text) | kernel `\MakeUppercase` around month, weekday and panel names; text content inside the `ART` nodes, no lib way named for it |
| calendar grid, captions, shading | main.tex:133-253 | `art.tikz` (**ART**) | `\calendar(cal)[dates=..., execute before day scope, execute at begin day scope, execute after day scope, day code, every day text, week bg]` with `if (Sunday)`, `if (weekend)`, `if (at most=..., at least=...)` rules; day cells 34mm x 25mm, weekday bar 5mm, 12mm gap after Wednesday |
| panels | main.tex:255-268 | `art.tikz` (**ART**) | `\tikzset{heading, headingbox}` nodes, `below= of`, heights 12mm and 31mm |
| bottom strip | main.tex:270-322 | `art.tikz` (**ART**) | second `\calendar` with empty `day code` used as a loop; `\foreach \z in {0,.5,...,\notesheight}` ruled rectangles |
| month index tabs | main.tex:162-182 | `art.tikz` (**ART**) | node `fill=indexcolor`, `minimum width=17.5mm`, `rotate=90`, `loosely dotted` rule at `current page.north east` |
| cut and punch marks | main.tex:334-368 | `art.tikz` (**ART**) | `mymarkline` 0.6pt, `\marklength` 1.5mm, `\diam` 1pt circles at `current page.north` and `.south` |
| page-relative placement | main.tex:68, 334 | `art.tikz` (**ART**) | `remember picture,overlay`, `shift={(current page.north west)}`; pgf's own page node, not the `tikzpagenodes` package, and it needs two TeX runs |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\stripzero`, `\stripzerohelp` | main.tex:25-26 | no | recursive `\expandafter` macro that strips leading zeros so a month string can be multiplied; hand-written expansion logic |
| `\termin` | main.tex:33-36 | not used | never called (only commented at :331); would place holiday names on a calendar node, so it would be `ART` if called |
| `\YYMM` | main.tex:44 | no | one data value (YYYY-MM), but it drives the whole computed grid, so it cannot be a declarative parameter without the code below |
| `\daywidth`, `\dayheight`, `\weekheight`, `\pagespace`, `\boxspace`, `\bugfixspace`, `\defaultpgflinewidth` | main.tex:71-91 | partly | plain lengths set once (declarative); `\bugfixspace` is re-set by weekday conditionals (:144-148), which is not |
| `\dayh`, `\weekh`, `\notesheight`, `\notesoffset` | main.tex:77-88 | no | numeric twins of the lengths so `\pgfmathsetmacro` can add them; `\notesheight` is renewed by a conditional (:279); `\notesoffset` is never used |
| `\monthsheetdate`, `\monthsheetweekday`, `\weekrows` counts and `\monthsheetbegin/end` | main.tex:113-128, 274 | no | Julian-date arithmetic and a Sunday counter that decide grid range and strip height; computed layout |
| `myline`, `heading`, `headingbox`, `week bg`, `every day text` TikZ styles | main.tex:130, 223, 222, 255-256 | yes, but only inside `art.tikz` | declarative key lists; they style artwork, so they do not remove the `ART` blocker |
| `every shadow`, `caption`, `plot legend` TikZ styles | main.tex:60-66 | not used | defined, never referenced (no `drop shadow` or legend in the body); `shadows` and `patterns` libraries (:29) are loaded for nothing |
| `ifthen` package | main.tex:23 | not used | loaded; no `\ifthenelse` or `\whiledo` anywhere (grep); load-only with no effect |

## Content-opaque
none. The document has no figure or table float; the drawing is the template itself, so it is recorded as `ART` above. The month (`\YYMM`) is data fed to that drawing.

## Lib changes
- New ways proposed: none. A `cal.*` way for the TikZ `calendar` library was considered and rejected: this sample sets the layout through `day code`, `execute before day scope` and `\ifdate` programs (fails W2), so it sits in the restricted `art.tikz` row. `ifthen` is not proposed because nothing in the sample uses it.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- No text in the zip is addressed to an AI.
- The sample is an upstream fragment patched by latextemplates.com (main.tex:38-51, README.md:23-32): `\YYMM` defined in the file and the font changed to DejaVu Sans. Upstream is hackl/tex-calendar (README.md:20-21). No compiled output was inspected.
