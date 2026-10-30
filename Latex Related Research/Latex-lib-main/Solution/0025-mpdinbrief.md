yes

# 0025-mpdinbrief: mpdinbrief (DIN 676 German business letter class)

- Unverified: read from the source, not compiled.
- Source: Source/0025-mpdinbrief/ (origin: https://mirrors.ctan.org/macros/latex/contrib/mpdinbrief.zip; licence: nosell, CTAN "Do Not Sell Except by Arrangement")
- Kind: letter
- Lib: v1
- Engine: pdfLaTeX-compatible (no fontspec/Lua/XeTeX dependency; 1990s LaTeX 2.09/2e dual-mode code, behaviour under a current kernel not tested; lego.eps must be converted to PDF for pdfLaTeX, see Content-opaque)
- Look carried by: mixed (the published class `mpdinbrief` defines the DIN 676 layout; the example's own preamble file `mpbrfkopf.tex` defines the letterhead and `isotoday.sty` the date format)
- Class origin: ctan
- Main file: mpdinbrief.dtx, guard `mpexample` lines 6066-6157 (docstrip output `mpexample.tex`, see mpdinbrief.ins:166-168); there is no standalone .tex, .cls or .sty in the zip. Other samples: guard `mpbrfkopf` 6013-6061, `isotoday` 6673-6681, `brfbody` 6163-6314, `test` 6386-6463 and the `10pt/11pt/12pt/norm` drivers 6318-6382, `dinbriefold` 6475-6665 (old `dinbrief` API, loads class `dinbrief`, not analysed further), user guide guard `documentation` 439-1623 (article + `german`)
- Read: main yes, zip-local classes and styles all (the class is the unprefixed code of mpdinbrief.dtx 1644-5988, about 1990 code lines, all read; the old-API example 6475-6665 only skimmed; the German user guide 511-955 read, the rest not)

## Verdict
The example letter is `\documentclass[11pt]{mpdinbrief}` plus German language support, a letterhead built from boxes in a preamble file, a one-macro date format and class-native letter commands. `mpdinbrief` is on CTAN (ctan.org/pkg/mpdinbrief, v1.66, maintainer Markus Pilzecker, a minor enhancement of `dinbrief`), so it passes W1 and is one class way, `class.mpdinbrief`. Every zip-local macro in the example reduces to lib ways, there is no ART and nothing needs a tool outside TeX. The yes hangs on the rubric's class rule: if `mpdinbrief` were judged zip-local instead, its box-and-glue page furniture, state counter and own output-time placement (see Bespoke code row 1) would be `BESPOKE/class`, irreducible, and the answer would be no.

## Blockers
none

## Class setting
- Class: `class.mpdinbrief` options: `11pt` (mpdinbrief.dtx:6074). Class defaults `a4paper,10pt,onecolumn,final` (2248); other options `12pt`, `norm` (DIN 2107/2142 line grid, `\GZA`=1in/6, 2421-2422, 2624-2634), `a5paper` `b5paper` `letterpaper` `legalpaper` `executivepaper` (2132-2149), `twoside` (2164), `draft` `final` (2174-2175), `onecolumn` `twocolumn` (2188-2189). Source not bundled as .cls: it is produced from the .dtx by docstrip (`tex mpdinbrief.ins`, a TeX run, so not EXTERNAL).
- Class-native vocabulary used by the sample: `\signature` (6053, class 4403), `\address` (6055, 4418), `\backaddress` (6111, 2899), `letter` environment whose argument is the receiver address (6113, 4192-4286), `\subject` (6124, alias of `\concern` 5605-5611), `\opening` (6126, 3385-3419), `\closing` (6140, 3584-3658), `\ps` `\encl` `\cc` (6142-6149, 3739-3795), `\bottomtext` (6100, 4591), `\date` (6108, 4484), `\enabledraftstandard` (6093, 5737), `\nowindowtics` (6094, 2887), `\pagestyle{contheadings}` (6084, 5009-5041). Present but commented out in the sample: `\makelabels`, `\labelstyle{deskjet}` (6081-6082), `\phonemsg`, `\signmsgnew`, `\yourmailmsg` (6096-6098), `\yourmail`, `\centeraddress` (6121-6122), `\place`, `\phone` (6054, 6056). Other class vocabulary not used: `\sign`, `\writer`, `\postremark`, `\handling`, `\stdaddress`, `dinquote`, `\enclright`, `\windowrules`, `\nowindowrules`, `\setlabel*`, `\spare`, `\footer`, `\disabledraftstandard`, deprecated German-named aliases (5757-5896).

## Component map
Evidence is in mpdinbrief.dtx (all paths relative to Source/0025-mpdinbrief/).
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | mpdinbrief.dtx:6074, 1780 | `class.mpdinbrief` | `11pt`; the 6072 `\documentstyle[german]` branch is the LaTeX 2.09 fallback and is not emitted |
| page size and type area | 2132-2150, 2248, 2733-2804, 6074 | `page.class-options` | `11pt`, `a4paper` (class default); class fixes textwidth 165mm (2802), textheight 254mm (2801), topmargin -5mm (2740), oddsidemargin 0in (2733), `\raggedbottom` (2808); the sample's `\setlength{\topmargin}{-15pt}` is commented (6110) |
| columns | 5982, 2188-2189 | `class.mpdinbrief` | `\onecolumn` default; `twocolumn` option exists, not used (labels use `\twocolumn` internally, 4096) |
| header and footer | 6084, 5009-5041 (also 4865-5000) | `hf.class-native` | `\pagestyle{contheadings}`: running head "An <receiver> <date> Seite n" in slanted type, continuation foot "--- n+1 ---", first page foot empty (4911-4951) |
| text sizes | 2429-2689, 6030, 6034, 6046 | `font.size-commands` | class size tables per option (normal 12pt/13.6pt/15pt, `norm` = 1in/6 baseline); sample uses `\huge`, `\large`, `\footnotesize` in the letterhead |
| font family | 6090-6091 (6088 `\fontencoding{T1}` commented) | `font.family-default` | `\fontfamily{cmss}\selectfont` (Computer Modern sans) |
| language | 6075, 5572-5575, 3690-3703 | `lang.babel` | German (`german.sty`, CTAN, is the legacy package for the same role; emit babel `ngerman`; source text uses the `"a` `"s` shorthands). Class itself sets `\today`, `\pagename`, `\ccname`, `\enclname`, `\psname` in German |
| letterhead (sender block) | 6025-6051, 6055 | `ltr.opening` | `\address{\briefkopf}`; the block is a composition of `box.minipage`, `sp.manual-space`, `sp.ragged`, `font.size-commands` and `fig.graphicx` (rows below) |
| letterhead boxes | 6026-6050 | `box.minipage` | `\vbox`/`\hbox to \textwidth` become `\parbox`/`\makebox[\textwidth]`, width `\textwidth`, right block `\raggedleft` |
| letterhead spacing | 6027-6049, 6019, 6021-6022, 6034 | `sp.manual-space` | `\vskip3mm`, `\vskip6mm`, `\hskip7mm`, `\hfill`, `\raise13mm`, `\raise.125ex`, `\raise.3ex`, `\kern.2em`, `\kern-.0375em` (as `\raisebox`/`\hspace`/`\vspace`) |
| letterhead alignment | 6040 | `sp.ragged` | `\raggedleft` |
| letterhead logo | 6017, 6032 | `fig.graphicx` | `\psfig{scale=1.0, file=lego.eps}` (epsfig) as `\includegraphics`, natural size, in a 30mm wide box raised 13mm |
| back address (window line) | 6057, 6111, class 2899, 3200-3217 | `ltr.opening` | `\backaddress{\FS}`; class prints it at 8/9pt between 85mm window rules |
| back address strut and fills | 6057 | `sp.rule` | `\rule[-1ex]{0pt}{0pt}` strut; `\hfil` fills as `sp.manual-space` |
| date format | 6079, 6108, 6674-6680 | `front.datetime` | `\ISOtoday` = two-digit year, month, day, hyphen raised .125ex, as a `\newdateformat`; printed with `\date{...}` into the class's date field (4484) |
| signature and sender data | 6053, 4403, 3619-3622 | `ltr.opening` | `\signature{Markus Pilzecker}`; printed by `\closing` in `\footnotesize` |
| receiver address window | 6113-6119, 3188-3274 | `ltr.opening` | `letter` argument lines split on `\\`; window 85mm wide, 40mm high, with window rules (default `\windowrules`, 2868-2871) |
| receiver vertical placement | 6113, 6118 | `sp.manual-space` | `\null\vss\null\vss...` stretchable glue, 3/5 above and 2/5 below (comments 6113, 6118); `\vspace*{\stretch{3}}`/`{\stretch{2}}`; class alternative `\centeraddress` (4390) |
| fold marks | 6094, 2885-2888, 3107-3132 | `ltr.opening` | `\nowindowtics` switches the fold/punch marks off (default on) |
| reference line and date | 6093, 5672-5747, 3280-3301 | `ltr.opening` | `\enabledraftstandard` selects the DIN 676 draft-1991 reference line `\@answertonew` (fields at 7pt/9pt) instead of `\@answertoold` |
| subject line | 6124, 5605-5611 | `ltr.opening` | `\subject` bold (`bx`) hanging paragraph |
| salutation and closing | 6126, 6140, 3584-3658 | `ltr.opening` | `\opening{Sehr geehrter Herr Christiansen,}`, `\closing{...}`: three baselines then typed signature |
| postscript, enclosure, distribution | 6142-6149, 3739-3795 | `ltr.opening` | `\ps`, `\encl`, `\cc`; bold `bx` labels PS / Anlage(n) / Verteiler followed by ":" |
| business footer on first page | 6100-6106, 4580-4604, 3138-3171 | `ltr.opening` | `\bottomtext{...}`; content `\vskip3mm` (`sp.manual-space`), `\makebox[\textwidth][c]` as centred line (`sp.ragged`), `\footnotesize`, `$\cdot$`; class reserves the space with `\enlargethispage` (3395) |
| paragraph and list spacing | 5066-5095, 5123-5192 | `class.mpdinbrief` | class-native: `\parskip .7em`, `\parindent 0pt`, `\topsep .4em`, `\itemsep .4em`, `\leftmargini 2.5em` (not overridden by the sample) |
| lists (test body) | 6183-6241, 5216-5297 | `list.kernel` | itemize, enumerate, description, nested; label forms `\labelenumi` etc. and bullets set by the class |
| quote, quotation, verse (test body) | 6243-6292, 5312-5354 | `quote.kernel` | class redefines the three list-based environments (`\listparindent 1.5em`, `\itemindent -15pt`) |
| display equation (test body) | 6294-6297, 5449-5450 | `math.kernel` | `equation`; number `\arabic`, reset per letter (`\@addtoreset{equation}{letter}`) |
| verbatim and old font switches (test body) | 6183-6203, 2363-2405 | `code.verbatim` | `\verb|...|`; `{\bf ...}` as `mark.kernel` (class keeps `\bf` through `\DeclareOldFontCommand`) |
| label sheets (class feature) | 3820-4160, 4790-4846; sample 6081-6082 commented | `class.mpdinbrief` | `\makelabels`, `\labelstyle{plain\|deskjet\|C6\|DL\|C6/C5}`, `\setlabel*`, `\spare`; not used by the sample |
| footnotes and floats (class-defined, unused) | 5484-5543, 2838-2854, 5556-5565 | `class.mpdinbrief` | `\footnoterule`, `\@makefntext`, float separations and fractions; the sample has no footnote, float or caption |

Not present in the sample, so no row: colour, background, sectioning, abstract, contents, theorems, tables (the test body only prints the heading "Testing tabular", 6299-6301), bibliography, index, cross-references, hyperref.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class `mpdinbrief` (var store 1842-2036, own font tables 2429-2689, window rules and fold marks 2868-3132, address window 3188-3274, `\opening` 3385-3419, `\closing` 3584-3658, state counter `lt@state` 4178-4286, label generator 3820-4160, `\document`/`\enddocument` 4633-4756, page styles 4865-5041) | mpdinbrief.dtx:1644-5988 | n/a: published on CTAN, counted as one class way, not bespoke | listed for transparency only; as lib code it is not a composition of ways (box-and-glue placement, hand-rolled counters and conditionals, redefined kernel internals), so the verdict depends on its CTAN status |
| `\briefkopf` letterhead macro | mpbrfkopf guard, mpdinbrief.dtx:6025-6051 | yes | `\address{...}` with `\parbox`/`\makebox`, `\raisebox{13mm}`, `\hspace`, `\hfill`, `\raggedleft`, `\huge \large \footnotesize`, `\includegraphics`; no counters or conditionals, only lengths |
| `\rdash`, `\tel`, `\facs` | 6019-6022 | yes | aliases for a raised hyphen and phone numbers: `\raisebox{.125ex}{-}`, `\raisebox{.3ex}{\footnotesize +}49\,6251\,39415` |
| `\FS` back address text | 6057 | yes | text with `\hfil`/`\hfill` fills and a `\rule[-1ex]{0pt}{0pt}` strut, passed to `\backaddress` |
| `\ISOtoday` / `isotoday.sty` | 6674-6680, loaded 6079 | yes | `front.datetime`: `\newdateformat` with two-digit year-month-day and raised hyphens. The `\loop`/`\advance\year by -100` only reduces the year to two digits and prints no layout |
| `\documentclass`/`\documentstyle` fork | 6071-6076 | yes | emit only the `\documentclass[11pt]{mpdinbrief}` and `\usepackage` branch; the fork picks the LaTeX 2.09 route when `\documentclass` is undefined |
| `\originalTeX` call | 6032 | yes | drop it: it restores catcodes switched by `german.sty` so that `\psfig` sees a plain file name; `\includegraphics` needs no such guard |
| receiver address glue | 6113-6119 | yes | `\vspace*{\stretch{n}}` before and after, or the class's own `\centeraddress` |

## Content-opaque
- `lego.eps` letterhead logo (mpdinbrief.dtx:6032): an included EPS image, example content of the sender's letterhead, not a drawing by the template. It is shipped in the zip. Under pdfLaTeX it needs an EPS-to-PDF conversion (TeX Live's `epstopdf-base` does this through restricted shell escape, or ship a converted PDF); recorded as an asset note, not a blocker.
- Letter text, the German verse, the quotation and the equation in the test body are content.

## Lib changes
- New ways proposed: none. The class is `class.mpdinbrief` (written plainly, per the rubric), with native vocabulary above. `german.sty` was mapped to `lang.babel` rather than proposed as a way of its own: it is a CTAN package (LPPL, maintainer Bernd Raichle) for the same component, and an emitter would write babel `ngerman`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this).

## Notes
- Redistribution: the .ins preamble (mpdinbrief.ins:125-141) forbids changing the file and taking money for it beyond a copying charge; shipping `mpdinbrief.cls` with Flouest would have to respect this (licence column: nosell).
- README (mpdinbrief.README) lists two known bugs under LaTeX 2e (`\enclright`, `dbold`); neither is used by the sample.
- The class is not in the zip as a .cls; the emitter must ship the docstrip output of mpdinbrief.dtx or rely on an installed copy.
- No text addressed to an AI was found in the zip.
