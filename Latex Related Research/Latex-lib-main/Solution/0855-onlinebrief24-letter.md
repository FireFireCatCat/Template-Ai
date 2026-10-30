yes

# 0855-onlinebrief24-letter: OnlineBrief24 Letter (modern DIN 5008 letter with visible guides)

- Unverified: read from the source, not compiled.
- Source: Source/0855-onlinebrief24-letter/ (origin: https://latextemplates.com/downloads/onlinebrief24-letter.zip; licence: LPPL-1.3c, text in LICENSE:4; the CTAN page of the class also states LPPL 1.3c)
- Kind: letter
- Lib: v6
- Engine: pdfLaTeX-compatible (onlinebrief24.cls:53-66 branches on `\ifPDFTeX`: T1 + `tgheros` under pdfTeX, `fontspec` with Arial or TeX Gyre Heros otherwise; the manifest hint "xelualatex" is only a hint; not compiled)
- Look carried by: class (the whole look is the `onlinebrief24` class and its options; main.tex only chooses options and fills string fields)
- Class origin: ctan (https://ctan.org/pkg/onlinebrief24 read once: "A LaTeX letter class for DIN 5008 type-B business letters", based on KOMA-Script scrlttr2, author Francesco Luciano, LPPL 1.3c, version 2026-04-17, topics Letter and Standard conform; the version equals the `\ProvidesClass` date at onlinebrief24.cls:2; the bundled file was not compared byte by byte with the CTAN copy)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (onlinebrief24.cls read in full, 761 lines)

## Verdict
The class `onlinebrief24` is a published CTAN class (the zip's `.cls` carries the same version date as the CTAN page), so under the rubric's ruling for published classes it is one way, `class.onlinebrief24`. The sample adds no macro, package or definition of its own: it chooses five class options and sets string fields with the class's own setters, then uses `letter`, `\opening` and `\closing` (main.tex:9-45). An emitter writes `\documentclass[...]{onlinebrief24}`, the setter lines and the letter body, with no copied macro logic. The class's own internals (TikZ guide overlay, reimplemented `\opening`, conditional footer and info-block builders) are published class code selected by declarative options, so they are recorded below but are not zip-local blockers. This is evidence about the class dimension, not about component ways.

## Blockers
none

## Class setting
- Class: `class.onlinebrief24` options: `modern` (modern sender heading and footer row), `guides` (TikZ guide overlay on page 1), `footercenter` (footer row centred instead of right-aligned), `infoblock` (DIN information block), `lang=german` (key-value, becomes babel `main=`) (main.tex:9; declared at onlinebrief24.cls:9, 16-19). Unused class options: `basic`, colour schemes `blue` `orange` `green` `red` `purple` `grey` `burgundy` `black` (cls:20, 24-31; the default scheme is grey, cls:23); any other option is passed to `scrlttr2` (cls:33).
- Base class loaded by the class: `class.scrlttr2` with `fontsize=11pt, parskip=half` (cls:37); KOMA letter parts it disables: `addrfield=false, firsthead=false, firstfoot=false, foldmarks=false` (cls:69-74), `\setplength{sigindent}{0pt}` (cls:75).
- Class-native vocabulary used by the sample: `\setfromfirstname` `\setfromlastname` `\setfromaddress` `\setfromlandline` `\setfromphone` `\setfromemail` `\setfromweb` `\setfromlinkedin` (main.tex:11-18); `\setreturnaddress` `\setrecipient` (main.tex:20-21); `\setsubject` `\setplace` `\setdate` (main.tex:23-25); `\setyourref` `\setyourmessage` `\setourref` `\setcontactname` `\setcontactphone` `\setcontactemail` (main.tex:26-31); `letter` environment with an empty recipient argument, `\opening{..}`, `\closing{..}` (main.tex:34, 35, 45). Defined by the class but not used here: `\setourmessage` `\setcontactfax` `\setfromname` `\setinfoblocktopoffset` `\setinfoblockrightedge` `\setinfoblockcolwidths` `\addinfoblockrow` `\addfooteritem` (cls:142-156, 257-278, 371, 439).

## Component map
Rows marked "(via class)" are what the class realises from its option settings; the sample states only the options and fields.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:9 | `class.onlinebrief24` | options modern, guides, footercenter, infoblock, lang=german |
| base letter class (via class) | onlinebrief24.cls:37, 69-76 | `class.scrlttr2` | fontsize=11pt, parskip=half; addrfield, firsthead, firstfoot, foldmarks all false; sigindent 0pt; `\raggedsignature` = `\raggedright` |
| page geometry (via class) | onlinebrief24.cls:43, 80-87 | `page.geometry` | paper=a4paper, top=25mm, bottom=25mm, left=25mm, right=20mm, footskip=10mm (fixed in the class, no sample parameter) |
| language (via class) | main.tex:9; onlinebrief24.cls:42, 164-171 | `lang.babel` | main=german (from `lang=german`), provide=*; German info-block labels chosen by `\languagename` |
| text face, modern style (via class) | onlinebrief24.cls:329 | `font.helvet` | sourcesanspro, options default, light, semibold (a sans text-face package is the parameter) |
| text face, base and encoding (via class) | onlinebrief24.cls:54-56 | `font.fontenc-t1` | fontenc T1 (pdfTeX branch); `tgheros` in the same branch is also `font.helvet` |
| default family (via class) | onlinebrief24.cls:56 | `font.family-default` | `\familydefault` = `\sfdefault`; in the modern style `sourcesanspro[default]` is loaded later (cls:329), so its face decides the text family (not compiled) |
| font selection, non-pdfTeX branch (via class) | onlinebrief24.cls:58-65 | `font.fontspec` | `\setmainfont` and `\setsansfont` Arial, else TeX Gyre Heros, Ligatures=TeX; not taken under pdfLaTeX |
| font sizes (via class) | onlinebrief24.cls:283-284, 414, 528-529, 556 | `font.size-commands` | return address 5.8pt/6.4pt; info block 8pt/9.5pt; header name 18pt/20pt; recipient 11pt/13pt |
| colour (via class) | onlinebrief24.cls:46, 333-347 | `color.xcolor` | color0 rgb 0,0,0; color2 rgb .45,.45,.45; color1 by scheme (default grey .55,.55,.55, not set in the sample) |
| icons in footer (via class) | onlinebrief24.cls:330, 587-591 | `font.icons` | fontawesome5 `\faPhone` `\faMobile` `\faEnvelope` `\faGlobe` `\faLinkedin` |
| sender heading | main.tex:11-13; onlinebrief24.cls:383-394, 566-578 | `front.class-native` | `\setfromfirstname{Freya}` `\setfromlastname{Lindqvist}` `\setfromaddress{..}`; first name in color1!50, last name color1, address 10pt in color2!50 |
| return address and recipient window | main.tex:20-21; onlinebrief24.cls:539-549, 553-559 | `front.class-native` | `\setreturnaddress`, `\setrecipient`; window x=20mm, 72mm wide, zone 1 at 50mm and 2mm high, zone 3 at 73mm and 20mm high |
| subject, place and date line | main.tex:23-25; onlinebrief24.cls:241-256, 402-412 | `front.class-native` | `\setsubject`, `\setplace{München}`, `\setdate{\today}` (the setters also copy into the KOMA variables `date` and `place` with `\setkomavar`, cls:241-248); subject bold sans 0.60 `\textwidth`, date right-aligned 0.36 `\textwidth` |
| DIN information block | main.tex:26-31; onlinebrief24.cls:126-130, 413-484 | `front.class-native` | option `infoblock`; rows Your ref, Your message, Our ref, Contact name, phone, email; label 30mm, sep 2mm, value 43mm, right edge 200mm, top offset 50mm |
| fold marks | onlinebrief24.cls:500-501, 562-563 | `front.class-native` | marks at 105mm and 205mm from the top, 5mm long (KOMA's own are off, cls:73) |
| footer contact row | main.tex:14-18; onlinebrief24.cls:581-594 | `hf.class-native` | option `footercenter`; `\footnotesize` sans color2; items landline, mobile, email, web, LinkedIn joined by `\textbar` (cls:352) |
| layout guides overlay | main.tex:9; onlinebrief24.cls:600-704 | `class.onlinebrief24` | boolean option `guides`; the drawing is inside the class |
| page overlay mechanism (via class) | onlinebrief24.cls:45, 706-708 | `bg.eso-pic` | `\AddToShipoutPictureBG*` of the first-page overlay |
| first page style | onlinebrief24.cls:747 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` inside `\opening` |
| letter body commands | main.tex:34-35, 45; onlinebrief24.cls:315-325, 745-759 | `ltr.opening` | `letter{}`, `\opening{Sehr geehrter Herr Kern,}` (class sets 85mm top skip, cls:79, 751), `\closing{Mit freundlichen Grüßen}` |

Not used by the sample: headings, lists, quotes, notes, math, theorems, floats, tables, captions, code, boxes, bibliography, index, cross-references, table of contents.

## Bespoke code
Nothing in the zip is unpublished: main.tex defines no macro (main.tex:1-47), and `onlinebrief24.cls` is the CTAN class (see Class origin). For information, the class internals that a reviewer might look at:

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `letter` patch with field validation and `\ClassError` | onlinebrief24.cls:288-310, 315-325 | n/a, published class code | not needed: the emitter writes `\begin{letter}{}` |
| `\opening` reimplemented over KOMA internals (`\@foldmarks`, `\@firstheadfootfield`, `\@addrfield`) | onlinebrief24.cls:745-759 | n/a, published class code | with the sample's fields it is `\thispagestyle{empty}`, `\vspace*{85mm}`, two `\parbox`es, salutation: `hf.pagestyle-kernel`, `sp.manual-space`, `box.minipage` |
| conditional footer and info-block builders (`\ifdefempty`, first-item flag, `\gappto`) | onlinebrief24.cls:359-364, 421-443 | n/a, published class code | the option and field values drive them; the emitter writes only those values |
| TikZ guides overlay (zones, dimension arrows, fold-mark notes) | onlinebrief24.cls:600-704 | n/a, published class code | one boolean class option `guides`. Caveat: if the project later counts class internals, this is `ART/class` and `\opening` would be `BESPOKE/class`; under the published-class ruling neither counts |
| positioned page overlay for return address, recipient, header, footer, info block | onlinebrief24.cls:532-597, 706-708 | n/a, published class code | `bg.eso-pic` plus `\put` and a TikZ node; set by the class options and fields |

## Content-opaque
none

## Lib changes
- New ways proposed: none (`class.onlinebrief24` is written plainly as a class way; no `NEW:` way is used)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
