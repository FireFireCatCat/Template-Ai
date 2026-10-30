yes

# 0846-csbulletin: csbulletin (CSTUG Bulletin article class)

- Unverified: read from the source, not compiled.
- Source: Source/0846-csbulletin/ (origin: https://mirrors.ctan.org/macros/latex/contrib/csbulletin.zip; licence: LPPL 1.3c, README:3 and ctan.org/pkg/csbulletin)
- Kind: journal
- Lib: v6
- Engine: pdfLaTeX-compatible (the class sets `\pdfpagewidth` and `\pdfpageheight` unconditionally at tex/csbulletin.cls:575, and the sample uses biblatex with the biber backend, doc/example-english.tex:7)
- Look carried by: class (the whole look is the published class `csbulletin`, tex/csbulletin.cls and the two files it loads, tex/csbulacronym.sty:1 and tex/csbulobalka.sty:1; the sample adds only content, `nowidow`, `csquotes`, `biblatex` and `hyperref`)
- Class origin: ctan (ctan.org/pkg/csbulletin read: a document class, version 2025-12-16, maintainer Vit Stary Novotny, LPPL 1.3c, in TeX Live and MiKTeX; the zip is the CTAN archive)
- Main file: doc/example-english.tex (other samples: doc/example-czech.tex, doc/example-slovak.tex, doc/csbulletin.tex, the manual written in the class)
- Read: main yes, zip-local classes and styles all (no class or style here is zip-local; all five `.cls`/`.sty` files are part of the CTAN bundle and were read in full; `doc/example-slovak.tex` and `doc/example.bib` were not read)

## Verdict
Yes. The main sample loads one published class, `csbulletin`, and calls only its native vocabulary (`\title`, `\EnglishTitle`, `\author`, `\podpis`, `\maketitle`, `abstract`, `\keywords:`, `\section`) beside four published packages (`nowidow`, `csquotes`, `biblatex` with biber, `hyperref`). No zip-local macro is called from the preamble or the body, so an emitter writes `\documentclass{csbulletin}` and package lines only. Caveat: the class itself is heavy hand-written code (a box-and-glue title block, a second contents file written with `\write`, pdfTeX page inclusion, a `picture` cover); under a strict re-reading with the class treated as zip-local that code would be `BESPOKE/class` and `ART/class`. The yes rests on the pilot ruling that a look carried entirely by a published class reaches yes, and on the class being on CTAN.

## Blockers
none

## Class setting
- Class: `class.csbulletin` options: none in the sample (doc/example-english.tex:1). Options the class declares: `oldcsbabel` (tex/csbulletin.cls:20), `newpage` (:45), `nomargins` (:49), `web` `color` `twocolor` `custom` (:53-56, passed to `csbulobalka`); size, side and paper options are swallowed without effect (:24-41); any other option goes to `article` (:60). Built on kernel `article[twoside]` (:67).
- Class-native vocabulary used: `\title`, `\EnglishTitle`, `\author`, `\podpis` (doc/example-english.tex:22-25), `\maketitle` (:26), `abstract` environment with `\keywords:` inside it (:28-31), `\klicovaslova:` (:42); `summary` environment in doc/example-czech.tex:38-41. Declared by the class and not used by the main sample: `\NovyClanek`, `\StartPage`, `\PDFclanek`, `\Obalka`, `\tiraz`, `\EnglishTOC`, `\tableofcontents` (OBSAH), `\PridejDeleni`, editor hints (`\looser` `\denser` `\shorter` `\longer` `\Shorter` `\Longer` `\PageBreak`), `\Tolerance`, `\nodoi`, `tugboat` environment, logo macros of `csbulacronym` (`\CSTUG`, `\CSTeX`, `\cmd`, ...).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | doc/example-english.tex:1; tex/csbulletin.cls:67 | `class.csbulletin` | no options; base `article[twoside]`; vocabulary as listed above |
| page size and text block | tex/csbulletin.cls:308-327 | `class.csbulletin` | fixed in the class by raw lengths: paper 148mm x 210mm, `\textwidth` 27cc, `\topmargin` and `\evensidemargin` 13mm, `\textheight` 41 baselines plus `\topskip`, `\headheight` and `\headsep` 0, `\parskip` 0; `nomargins` option zeroes the margins (:356-361) |
| PDF page size | tex/csbulletin.cls:328-331, 575 | `class.csbulletin` | `\pdfpagewidth`/`\pdfpageheight` set to the paper size at `\begin{document}` (pdfTeX primitives) |
| running foot, no running head | tex/csbulletin.cls:338-341, 354 | `hf.class-native` | page style `csbul`: empty head, page number at the outer foot (`\@oddfoot` right, `\@evenfoot` left) |
| first-page foot with DOI | tex/csbulletin.cls:343-348, 457, 484 | `hf.class-native` | `\thispagestyle{csbuldoi}` from `\maketitle`; `\doi` defaults to the placeholder `10.5300/xxxx-x/zzz`; `\nodoi` removes it (:432) |
| body size and spacing | tex/csbulletin.cls:212-222 | `class.csbulletin` | `\normalsize` redefined as 10pt on 11dd, display skips 10pt/6pt, `\lineskiplimit` -1.1dd |
| lists | tex/csbulletin.cls:224-251 | `class.csbulletin` | `\@listi` to `\@listiii`: `\parsep`, `\topsep`, `\itemsep` 0; `\partopsep` 2pt plus 1pt minus 1pt (:224) (the sample has no list) |
| text face | tex/csbulletin.cls:69-70 | `font.fontenc-t1`, `font.lmodern` | `fontenc[T1]`, `lmodern` |
| input encoding | doc/example-english.tex:3 | `font.fontenc-t1` | `inputenc[utf8]` |
| logo glyph fonts | tex/csbulletin.cls:71; tex/csbulacronym.sty:33-36 | `font.icons` | `mflogo` (METAFONT/MetaPost logos) |
| NFSS logo family switch | tex/csbulacronym.sty:33-34 | `font.nfss` | `\fontencoding{U}\fontfamily{logo}\selectfont` inside `\manual` and `\font@mp` (used only by `\MF` `\MP`, not by the sample) |
| microtypography | tex/csbulletin.cls:80-83 | `sp.microtype` | `protrusion=true, expansion=true, stretch=8, shrink=24, step=4, nopatch=item`; loaded only under `\ifpdf` and when the file exists |
| widow and club control | doc/example-english.tex:4 | `sp.penalties` | `\usepackage[all]{nowidow}`; the class also sets `\clubpenalty` `\widowpenalty` `\interlinepenalty` to `\@M` around the signature (tex/csbulletin.cls:411) |
| languages | tex/csbulletin.cls:16-18, 68, 75; doc/example-english.tex:2, 39-41 | `lang.babel` | `babel[english,slovak,czech]`; `\languageattribute{czech}{split}` and `{slovak}{split}` (dropped by `oldcsbabel`); body `\selectlanguage{english}` and `otherlanguage{czech}` |
| quotation marks | doc/example-english.tex:5 | `lang.csquotes` | load-only `csquotes` (biblatex uses it; `\enquote` is not called) |
| title block | doc/example-english.tex:22-26; tex/csbulletin.cls:388-405, 434-458 | `front.class-native` | `\title`, `\EnglishTitle`, `\author`, `\maketitle`; the class prints three rules (4pt, 2pt, 1pt), the title in 14.4pt on 15dd bold `\raggedright`, a rule with the author name in a boxed small-caps tab at the right |
| signature line | doc/example-english.tex:25; tex/csbulletin.cls:402-418 | `front.class-native` | `\podpis{text}` printed flush right in italics at `\AtEndDocument`, with club and widow penalties set to `\@M` |
| abstract | doc/example-english.tex:28-31; tex/csbulletin.cls:297 | `abs.class-native` | `abstract` redefined as `\narrower \small \noindent` |
| keyword lines | doc/example-english.tex:30, 42; tex/csbulletin.cls:299-301 | `abs.keywords` | `\keywords:` (English), `\klicovaslova:` (Czech), `\klucoveslova:` (Slovak): medskip, then bold label "Keywords:" or its translation, then the list as text |
| English summary at the end | doc/example-czech.tex:38-41; tex/csbulletin.cls:287-291 | `abs.class-native` | `summary` environment: `otherlanguage*{english}`, `secnumdepth` -1, a `\section` titled "Summary: <`\EnglishTitle`>" |
| section headings | doc/example-english.tex:33, 38; tex/csbulletin.cls:267-285, 293 | `head.class-native` | `\@startsection` for `\section` (large bold, `\raggedright`, before skip 22dd minus 6pt, after 11dd minus 3pt), `\subsection` (bold), `\subsubsection` (medium), `\paragraph` and `\subparagraph` run-in (-1em); number format "N." plus 0.5em |
| heading numbering and contents depth | tex/csbulletin.cls:554-555; doc/csbulletin.tex:10 | `num.secnumdepth` | `tocdepth` -2 and `secnumdepth` -2 (headings unnumbered); the manual raises `secnumdepth` to 2 |
| chapter stub | tex/csbulletin.cls:370-377 | `class.csbulletin` | a private `chapter` counter for minitoc, `\chapter` undefined at `\begin{document}` |
| citations | doc/example-english.tex:34 | `bib.biblatex-biber` | `\citetitle{knuth-ttp}`, `\cite{knuth-ttp}`, `\textcite{knuth-tb}` |
| bibliography | doc/example-english.tex:6-15, 36 | `bib.biblatex-biber` | `backend=biber, style=iso-numeric, sortlocale=en, autolang=other, bibencoding=UTF8, mincitenames=2, maxcitenames=2`; `\addbibresource{example.bib}`; `\printbibliography` |
| PDF and link options | doc/example-english.tex:16-19 | `meta.hyperref` | `implicit=false, hidelinks` |
| contents list (OBSAH) | tex/csbulobalka.sty:369-387, 396-424, 426-435; tex/csbulletin.cls:460-476 | `front.class-native` | `\tableofcontents` titled OBSAH, entries of type `clanek` written by `\ClanekToc` from `\title`, `\author`, `\EnglishTitle`; `\EnglishTOC` reads `\jobname.engtoc`; not called by the sample |
| index | tex/csbulletin.cls:253-265, 526-536 | `class.csbulletin` | `theindex` in two columns over `multicols`, `\makeindex` and `\printindex` redefined; not called |
| article PDF inclusion | tex/csbulletin.cls:488-517 | `class.csbulletin` | `\PDFclanek[dir]{name}` includes the pages of a finished article PDF (page-inclusion type, pdfTeX `\pdfximage`); not called |
| cover and imprint | tex/csbulobalka.sty:103-183, 205-344 | `class.csbulletin` | `\Obalka` (a `picture` cover) and `\tiraz` (imprint page), hard-wired text and logo directory `/home/zw/CsBul/pictures` (:48, :144); not called |
| colour definitions for the cover | tex/csbulobalka.sty:10, 68-101 | `color.color` | `color` package; `modra` and `cervena` set by option `web` (RGB), `custom` (cmyk), `twocolor` or `color`; not used by the sample |
| graphics | tex/csbulobalka.sty:11 | `fig.graphicx` | load-only `graphicx` for `\includegraphics` in `\PDFclanek` and `\Obalka`; the sample has no figure |
| tabular, verbatim | tex/csbulletin.cls:85-91 | `tbl.tabular`, `code.verbatim` | `array`, `fancyvrb` and `verbatim` loaded when installed; the sample has no table or code |
| page-flow helpers for editors | tex/csbulletin.cls:141-157, 167-171 | `class.csbulletin` | `\looseness`, `\enlargethispage` wrappers, `\Tolerance`, `\te`; not called |

## Bespoke code
Nothing is zip-local: `csbulletin.cls`, `csbulacronym.sty` and `csbulobalka.sty` ship in the CTAN bundle, so they are the published class way, not bespoke code. The `Reducible?` column therefore states how each item would read if the class were treated as zip-local (a strict re-reading); none of it is called by the preamble or body of the main sample.
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\section` family, `abstract`, list parameters, `\normalsize` | tex/csbulletin.cls:214-285, 297 | published; strict reading: yes | `head.titlesec` with the skips above, `abs.kernel` with `\narrower \small`, `sp.lengths`, `font.size-commands` |
| page size and text block | tex/csbulletin.cls:308-327 | published; strict reading: yes | `page.geometry` with paper 148mm x 210mm and the margins above |
| page styles `csbul`, `csbuldoi` | tex/csbulletin.cls:338-348 | published; strict reading: yes | `hf.fancyhdr` with an empty head and a page number at the outer foot, one first-page style with a DOI |
| `\maketitle`, `\author` | tex/csbulletin.cls:388-396, 434-458 | published; strict reading: no | box-and-glue: `\leaders` rules, `\vbox to 17pt` with `\vrule`, `\settowidth` boxed author tab, local `\footnote` redefinition; no lib way |
| `\podpis` at `\AtEndDocument` | tex/csbulletin.cls:407-418 | published; strict reading: partly | the `flushright` body with `\itshape` is plain kernel markup, but the `\AtEndDocument` hook and the global `\p@dpis` state that decides whether it prints are hand-rolled |
| contents list, `\ClanekToc`, `\l@clanek`, `\cl@nek` | tex/csbulletin.cls:460-476; tex/csbulobalka.sty:369-387, 396-424 | published; strict reading: no | a second contents file `\jobname.engtoc` written with `\write` and switched by `\zw@select`; hand-rolled output |
| `\PDFclanek` | tex/csbulletin.cls:488-517 | published; strict reading: no | pdfTeX `\pdfximage` page loop with `\write` of `.info` files read back at :579 |
| `\Obalka` cover | tex/csbulobalka.sty:103-183 | published; strict reading: ART | `picture` drawing with `\put`, `\framebox`, `\vsplit` of repeated text |
| `\tiraz` imprint | tex/csbulobalka.sty:205-344 | published; strict reading: no | page text chosen by year counters (`\ifnum\the\rok>2015`) |
| acronym logos | tex/csbulacronym.sty:5-76 | published; strict reading: partly | `\kern`, `\lower`, `\cal` letters (`sp.manual-space`, `mark.kernel`); content macros, only `\TeX` is used by the sample |
| `csbulobalka.cls`, `csbulv1.cls` | tex/csbulobalka.cls:1-23; tex/csbulv1.cls:1-40 | not loaded by the sample | separate imposition classes over `zwpagelayout` and `zwtools` (not in the zip); out of scope |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and not proposed: `ifpdf` (cls:72, load-only helper with no printed effect, as the lib's rejected `sys.compat-load`) and `SpecChar` (cls:94, loaded only if installed, absent from the zip, not used by the sample).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
