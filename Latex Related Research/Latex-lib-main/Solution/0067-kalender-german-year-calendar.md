yes

# 0067-kalender-german-year-calendar: Kalender German Year Calendar

- Unverified: read from the source, not compiled.
- Source: Source/0067-kalender-german-year-calendar/ (origin: https://latextemplates.com/downloads/kalender.zip; licence: not established (manifest: UNKNOWN; README.md:9-10 warns the status is unclear; kalender.sty:2-4 informally allows reuse or change if the original author is named))
- Kind: calendar
- Lib: v1
- Engine: pdfLaTeX-compatible (README.md:5 says compile with pdfLaTeX; the package uses only kernel `picture`, `ifthen`, `calc`)
- Look carried by: preamble (the whole look is one published CTAN package, `kalender`, loaded at main.tex:4, a copy of which ships in the zip; the class is plain `article` with `a4paper`)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (kalender.sty read in full, 244 lines; README.md read)

## Verdict
The sample is 14 lines: `article[a4paper]`, a few kernel lines, and one call `\Kalender{2026}`. Everything it draws comes from `kalender.sty`, which ctan.org/pkg/kalender lists (author Joerg Soehner, version 1995-03-24, path `/macros/latex/contrib/kalender`), so the file is published (W1) and is not bespoke code. An emitter writes `\usepackage{kalender}` and `\Kalender{<year>}` and copies no macro logic. The `yes` rests on one judgement: that `kalender` is a lib way (`cal.kalender`) rather than `ART` or `UNMAPPED`. Its only parameter is a year, so it is not a program or free drawing, which is what the Restricted section covers. If a reviewer does not accept a one-integer parameter as W2, the verdict flips to `no`. The zip's copy was not compared byte for byte with CTAN's.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (main.tex:1)
- Class-native vocabulary used: none (no `\maketitle`, no `abstract`, no sectioning; the sample uses only `center` and `\Large`)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1 | `class.article` | a4paper; 10pt default, one-sided default |
| page size and margins | main.tex:1 | `page.class-options` | a4paper only; no `geometry`, article default margins |
| input and font encoding | main.tex:2-3 | `font.fontenc-t1` | `inputenc` utf8, `fontenc` T1 |
| header/footer, page number | main.tex:5 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| heading line above the grid | main.tex:8-10 | `sp.ragged` | kernel `center` environment (the same mechanism as `\centering`); content text "Jahreskalender 2026" |
| heading line size | main.tex:9 | `font.size-commands` | `\Large` |
| year-at-a-glance grid (the whole page body) | main.tex:4, 13; kalender.sty:46-67 | `cal.kalender` | `\usepackage{kalender}`; body `\Kalender{2026}`; the year is the only parameter |
| grid geometry (inside the way, not a parameter) | kalender.sty:60-62, 173-188 | `cal.kalender` | `\unitlength` 0.7mm, `picture` 198 x 143 units (about 139 x 100 mm), `scriptsize`; frame lines and 28 columns as 4 repeats of Mo to So |
| rows and labels (inside the way) | kalender.sty:124-142, 199-243 | `cal.kalender` | 14 month rows, from December of the previous year to January of the next; German month and weekday names fixed in the code; bold via `\bf` |
| leap-year and weekday logic (inside the way) | kalender.sty:76-116, 150-163, 203-206 | `cal.kalender` | Gregorian rules, reference year 1900; any year works (kalender.sty:14-19) |
| credit line printed on the page (inside the way) | kalender.sty:189-192 | `cal.kalender` | `\tiny` text "(c) 1995 Joerg Soehner" and "formed and printed by LaTeX2e", always printed; no option turns it off |
| helper packages | kalender.sty:22 | `cal.kalender` | `ifthen` and `calc` are loaded by the package itself; they are internals of the way, not separate rows |

Not defined by this zip (no row): language packages, colour, fonts beyond T1 encoding, lists, theorems, floats, tables, code, bibliography, index, cross-references. The sample sets none of them.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `kalender.sty` (counters kalender.sty:23-44, `\newboolean` :28, macros `\Kalender` :46, `\modulJahr` :76, `\monatname` :124, `\setgrenze` :150, `\Kalenderrahmen` :173, `\Tage` :199, `\zeileunten`/`\linie` :211-214, `\setzemonatname` :216, `\setxkoord` :220, `\setzetage` :224) | kalender.sty:20-243 | n/a: published on CTAN (W1), so not bespoke; it is the body of `cal.kalender` | If the zip's copy turned out not to match CTAN's, this would be irreducible `BESPOKE/class` (counter-driven placement loops, `\whiledo` leap-year arithmetic) plus `ART/class` (a `picture` frame and grid), and the verdict would be `no`. kalender.sty:21 says `1995/03/25` while CTAN lists 1995-03-24; that is a one-day difference and README.md:7 says the file is the upstream one, but the files were not compared. |
| main.tex macros or environments | main.tex | none defined | main.tex defines no `\newcommand`, `\def`, environment, counter or conditional |
| Observed defects in the shipped sty (no effect on the verdict) | kalender.sty:56, 130, 189-190 | n/a | Line 56 sets a counter `Kurjahr` that is never declared (only `Kurzjahr` is, line 44), but the branch needs `Kurzjahr = 100`, which the loop at lines 54-55 rules out, so on a read it never runs. Lines 130 and 189-190 write umlauts as `"a`/`"o`, which need `babel` German shorthands; main.tex:1-4 loads no `babel`, so on a read those strings print a literal quote mark. Fixing it would add `lang.babel` (ngerman) to the preamble; that is not in the sample, so it is not mapped here. |

## Content-opaque
none (the grid is generated by the way, not drawn in the sample; the only artwork is the `picture` inside the published package, which the way covers)

## Lib changes
- New ways proposed: `cal.kalender` (component: doc-kind specific; package `kalender`, CTAN `/macros/latex/contrib/kalender`; engine pdf; preamble `\usepackage{kalender}`, body `\Kalender{<year>}`).
  - W1 Published: on CTAN (one read of ctan.org/pkg/kalender; not in TeX Live, listed as in MiKTeX; licence not stated on the page). A copy has to ship with the document, since a standard TeX Live install does not have it (README.md:7-8). That is the "ship the missing asset" note, not a blocker.
  - W2 Declarative parameters: behaviour is chosen by a value (the year, any integer, kalender.sty:14-19, 47). The look has no parameters. This is thin, but the lib already holds load-only ways (`cols.balance`, `pg.emptypage`, `math.icomma`) and fixed-look class ways.
  - W3 Generic: serves a kind of component (a one-page year grid) for any year, not one document.
  - W4 Printable: one preamble line and one body line around a year.
  - Not `art.content-package`: that row is for packages whose parameters are programs or free drawings; here the parameter is a year. Searched the lib first (`grep -i 'calendar\|kalender\|cal\.'` found only `art.pstricks`, which covers the `picture` environment as an artwork class, not this package).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
