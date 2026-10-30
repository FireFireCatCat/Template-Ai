yes

# 0852-petiteannonce: petiteannonce (tear-off phone-strip adverts)

- Unverified: read from the source, not compiled.
- Source: Source/0852-petiteannonce/ (origin: https://mirrors.ctan.org/macros/latex/contrib/petiteannonce.zip; licence: LPPL, petiteannonce.cls:9-13 and manifest `lppl`)
- Kind: misc (a one-page notice-board advert with the phone number repeated on cut-off strips; the manifest hint is `misc`/`advert`)
- Lib: v6
- Engine: pdfLaTeX-compatible (graphicx `\rotatebox`, `.jpg` image, siunitx; no fontspec or Lua)
- Look carried by: class (the whole advert layout is `\petiteannonce` of the CTAN class; the example sample adds only content, `margin=3mm` and body tabular markup)
- Class origin: ctan (ctan.org/pkg/petiteannonce read: Vincent Belaïche, LPPL, in TeX Live and MiKTeX; the zip is the CTAN bundle, class v1.001 of 2012/04/10 at petiteannonce.cls:27)
- Main file: petiteannonceexample.tex (other samples: petiteannonce.doc.tex, the package manual on `article`; the manifest names the manual as main, both were read in full and both are mapped below)
- Read: main yes, zip-local classes and styles all (the one `.cls` read in full; it is the published class itself, not a zip-local copy)

## Verdict
`yes`. The look is carried entirely by the published CTAN class `petiteannonce` (W1 holds: on CTAN and in TeX Live, LPPL). Its behaviour is chosen by the class option `margin=<len>` and the keys of one command (`cols` `count` `skip` `cutvspace` `telcolsep` `telrulewidth` `telvspace` `texthspace` `textvspace` `width`), so an emitter writes `\documentclass[margin=3mm]{petiteannonce}` and one `\petiteannonce[keys]{tel}{content}` per advert, with no copied macro logic. Everything else in the two samples (tabular, siunitx, graphicx, eurosym, pdfpages, fancyvrb, kernel sectioning and lists) is a lib way with parameters. Stricter re-reading: if the class's own code (strip counting with `\divide` of dimens, a `\loop`, rotated boxes, cls:165-287) were counted as bespoke, this would be BESPOKE/class and irreducible; I do not count it because a published class is a way (rubric, "Class setting").

## Blockers
none

## Class setting
- Class: `class.petiteannonce` options: `margin=3mm` (class-own key, default 1mm; passed by `\DeclareOption*` to keyval, petiteannonceexample.tex:1, petiteannonce.cls:41-48); also `10pt` (default via `\ExecuteOptions{10pt}`) `11pt` `12pt` (petiteannonce.cls:31-39). Documentation: `class.article` without options (petiteannonce.doc.tex:1).
- Class-native vocabulary used: `\petiteannonce[keys]{phone number}{advert text}` with keys `cols=2`, `count=4` (petiteannonceexample.tex:8-9; the other keys keep their defaults: `cutvspace` 10pt, `skip` 0, `telcolsep` 10pt, `telrulewidth` 0.5pt, `telvspace` 10pt, `textvspace` 10pt, `texthspace` 20pt, `width` `\textwidth`, petiteannonce.cls:118-138); `\petiteannoncewidth{factor}` (petiteannonceexample.tex:14,22; defined petiteannonce.cls:289-295) and `\petiteannonceaddtowidth{len}` (petiteannonceexample.tex:12; defined petiteannonce.cls:297-303). The class defines no sectioning command, no `\maketitle`, no abstract and no float; it loads only `graphicx` and `keyval` (petiteannonce.cls:25-26) and `size1x.clo` (petiteannonce.cls:50).
- Class-internal realisation (published, not re-emitted): A4 text block of 210 by 297 mm minus twice `margin` with zero header, footer and margin-note lengths (petiteannonce.cls:72-94), `\pagestyle{empty}` (petiteannonce.cls:100), old font commands `\rm` `\bf` ... (petiteannonce.cls:56-64), each advert a `\framebox` around a `minipage` with text, a `\dotfill` cut line and a row of rotated, `\vrule`-separated copies of the number (petiteannonce.cls:231-272), laid out `count` times, `\newline` after every `cols` adverts (petiteannonce.cls:278-286). The frame is a plain `\framebox`, adjustable by `\fboxsep` and `\fboxrule` (petiteannonce.doc.tex:87-88; the class does not set them, grep of petiteannonce.cls).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (sample) | petiteannonceexample.tex:1 | `class.petiteannonce` | margin=3mm |
| document class (manual) | petiteannonce.doc.tex:1 | `class.article` | no options |
| page size and margins | petiteannonceexample.tex:1; petiteannonce.cls:41-43,72-94 | `page.class-options` | class option margin=3mm (all four margins); A4 fixed by the class; the raw length assignments are class-internal |
| base font size | petiteannonce.cls:31-39,50 | `page.class-options` | 10pt default (11pt, 12pt available); the sample leaves the default |
| header/footer | petiteannonce.cls:75-79,100 | `hf.pagestyle-kernel` | `\pagestyle{empty}` set by the class; no running head or foot |
| old-style font commands | petiteannonce.cls:56-64 | `mark.kernel` | `\rm` `\bf` `\it` `\sc` `\sf` `\tt` `\sl` `\cal` `\mit` redefined by `\DeclareOldFontCommand` (class-internal, not used by the sample) |
| advert block (whole page body) | petiteannonceexample.tex:8-24; petiteannonce.cls:165-287 | `class.petiteannonce` | `\petiteannonce[cols=2, count=4]{tel}{text}`, other keys default |
| repeated phone number strip | petiteannonceexample.tex:9; petiteannonce.cls:231-253 | `class.petiteannonce` | first mandatory argument `02 99 yy yy yy`, a string; rotated 90 degrees by the class |
| advert width helpers | petiteannonceexample.tex:12,14,22 | `class.petiteannonce` | `\petiteannonceaddtowidth{-2\tabcolsep}`, `\petiteannoncewidth{0.5}` |
| table column gap | petiteannonceexample.tex:11 | `sp.lengths` | `\tabcolsep=10pt` |
| ad text layout table | petiteannonceexample.tex:13-23 | `tbl.tabular` | `tabular` with `@{}m{..}m{..}@{}` columns (`array` loaded, petiteannonceexample.tex:4), `\multicolumn{2}{@{}c@{}}`, `\hline` |
| title size | petiteannonceexample.tex:15 | `font.size-commands` | `\Large` |
| dotted fill beside the title | petiteannonceexample.tex:15 | `sp.rule` | `\dotfill` twice |
| line breaks in the cell | petiteannonceexample.tex:17-19 | `sp.manual-space` | `\newline` |
| dimensions and price | petiteannonceexample.tex:2,18-20 | `mark.siunitx` | `\SI{80}{\centi\metre}`, `\si{~}` |
| inline maths for the size | petiteannonceexample.tex:18-19 | `math.kernel` | inline `\( ... \times ... \)` only |
| euro sign | petiteannonceexample.tex:5,20 | `font.icons` | `eurosym`, `\euro` |
| product photo | petiteannonceexample.tex:3,22 | `fig.graphicx` | `\includegraphics[width=\petiteannoncewidth{0.5}]{baignoire.jpg}` inline in a table cell, no float and no caption |
| manual: title block | petiteannonce.doc.tex:4-5,8 | `front.maketitle` | `\title` `\author` `\maketitle`, no `\date` |
| manual: headings | petiteannonce.doc.tex:9,17,26,31,75,85,90 | `head.kernel` | `\section`, `\subsection` of article, default numbering |
| manual: lists | petiteannonce.doc.tex:35-73 | `list.kernel` | `itemize` and kernel `list` environment `\begin{list}{}{}` with `\item[key]` labels |
| manual: font marks | petiteannonce.doc.tex:36,38,39,47 | `mark.kernel` | `\textit` `\em` `\textsuperscript` |
| manual: verbatim | petiteannonce.doc.tex:2,19,97 | `code.verbatim` | `\verb!...!`, `fancyvrb` `\VerbatimInput{petiteannonceexample.tex}` |
| manual: units | petiteannonce.doc.tex:3,20,24 | `mark.siunitx` | `\SI{1}{\milli\metre}` |
| manual: inline maths | petiteannonce.doc.tex:39-40,77 | `math.kernel` | inline `\( ... \)` only |
| manual: text symbols and accents | petiteannonce.doc.tex:5,13,31,75 | `font.fontenc-t1` | `\texttrademark`, `\textbackslash`, `\"\i` (kernel text commands; no package options) |
| manual: cross-references | petiteannonce.doc.tex:79,83,91 | `xref.kernel` | `\label{sec:sample-code}`, `\ref` |
| manual: included example page | petiteannonce.doc.tex:2,101 | `pg.include-pdf` | `pdfpages`, `\includepdf{petiteannonceexample}` (the shipped `petiteannonceexample.pdf`) |
| manual: paragraph start | petiteannonce.doc.tex:24 | `sp.lengths` | `\noindent` (per-paragraph switch for `\parindent`; judgement call, no other lib way fits) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\petiteannonce` with its keyval keys, strip count and loop | petiteannonce.cls:118-138,165-287 | not bespoke: published CTAN class code | carried by `class.petiteannonce`; the emitter prints the call with its key list (petiteannonceexample.tex:8). Irreducible if it had been zip-local (see Verdict). |
| `\petiteannoncewidth`, `\petiteannonceaddtowidth` | petiteannonce.cls:289-303 | not bespoke: same published class | printed as calls in the body (petiteannonceexample.tex:12,14,22) |
| `\tabcolsep=10pt\relax` in the body | petiteannonceexample.tex:11 | yes | `sp.lengths` assignment inside the advert text argument |
| zip-local `.sty`, `\newcommand`, counters, environments in the samples | petiteannonceexample.tex, petiteannonce.doc.tex | none exist | the samples define no macro, counter or environment of their own |

## Content-opaque
none. Notes, not blockers: the sample names `baignoire.jpg` (petiteannonceexample.tex:22) but the zip ships `baignoire.JPG` (a case mismatch that only matters on a case-sensitive file system; ship the image under the referenced name); the manual `\includepdf` needs the shipped `petiteannonceexample.pdf` to exist (petiteannonce.doc.tex:101), which is a shipped asset and not an external tool. The page text (the advert wording, the phone number) and the photo are content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
