yes

# 0022-lucid-cv: Lucid CV (ATS-friendly resume class, LuaLaTeX)

- Unverified: read from the source, not compiled.
- Source: Source/0022-lucid-cv/ (origin: https://mirrors.ctan.org/macros/luatex/latex/lucidcv.zip; licence: mit, lppl1.3c, ofl; LICENSE:1-20 states LPPL 1.3c for the class files, fonts/*/OFL.txt for the bundled fonts)
- Kind: cv
- Lib: v0
- Engine: needs LuaLaTeX (class aborts otherwise: lucidcv.cls:79-86; `\directlua` callback at lucidcv.cls:109-118 and :203-212; `fontspec` TTF loading; `latexmkrc:3` sets `$pdf_mode = 4`; format >= 2026-06-01, lucidcv.cls:44)
- Main file: main.tex (other samples: none; body is contents.tex, pulled in by `\input{contents}` at main.tex:115)
- Read: main yes, zip-local classes and styles all (lucidcv.cls read in full, lines 1-1781; contents.tex in full; README.md skimmed for build and warning sections only; the two PDFs and the TTF fonts are binary and not read)

## Verdict
yes, and the answer rests on one point: `lucidcv` is a published CTAN package (checked once at ctan.org/pkg/lucidcv: "Lucid CV", v1.0.0, directory /macros/luatex/latex/lucidcv; the zip is that package), so by W1 it is a class way, `class.lucidcv`, like `class.moderncv`. The sample defines nothing of its own: main.tex and contents.tex contain no `\newcommand`, `\def`, environment or counter, only class options, class-native commands, and kernel markup. An emitter writes `\DocumentMetadata`, `\documentclass[...]{lucidcv}`, a handful of class setters, then `\cvsection`/`\cventry`/`\cvtaglist` wrappers, with no copied macro logic. Caution for whoever reads this: if lucidcv were not accepted as published, the class would be a `no` (irreducible: Lua callback, expl3 contact-field engine, TikZ chips, `\MakeFramed` group rule, shipout hook); see Bespoke code. A second, smaller dependency: the bundled TTF fonts and `photo.jpg` must ship with the output.

## Blockers
none

## Class setting
- Class: `class.lucidcv` options: `10pt`, `a4paper` (not lucidcv keys: forwarded to `extarticle` by the unknown-key handler, lucidcv.cls:70), `hyper`, `photo`, `onecolumn` (main.tex:21). Other keys the class declares and the sample does not use: `compressed`, `noicons`, `headingrule`/`noheadingrule`, `twocolumn` (lucidcv.cls:58-67).
- Underlying class: `\LoadClass{extarticle}` (lucidcv.cls:73), published, not an emitter concern.
- Class-native vocabulary used:
  - preamble: `\cvaccent{1D76E2}` (main.tex:30), `\cvkeywords{...}` (main.tex:64); commented but documented: `\geometry`, `\columnratio`, `\cvnamesize`, `\cvtaglinesize`, `\nametaggap`, `\tagcontactgap`, `\cvsectionsize`, `\cvsubsectionsize`, `\cvitemsep`, `\cvitemtopsep`, `\cvsectiongapratio`, `\cvrulegaptrim`, `\cvtitle`, `\cvauthor`, `\cvsubject` (main.tex:34-63)
  - header: `\name{Adrian}{Castellanos}`, `\tagline`, `\cvphoto[4cm]{photo.jpg}`, `\CvInfoField{citizenship}{\faGlobeEurope}`, `\cvpersonalinfo{\email \phone \location \citizenship \homepage \linkedin \github}`, `\makecvheader` (main.tex:70-111)
  - body: `cvbody` env (main.tex:113-117); `\cvsection`, `\cvsubsection`, `\cventry[oneline|flushdate|askip|bskip|noscale]`, `cvgroup[rule]`, `\cvsubentry[oneline|flushdate|askip|bskip]`, `\cvdivider`, `\cvtag`, `\cvtaglist`, `\cvref`, `\cvcolumnbreak`, `justify` env (contents.tex:31-209); `\lastupdated` (commented, main.tex:120)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:21; lucidcv.cls:58-73 | `class.lucidcv` | hyper, photo, onecolumn (all booleans via `\DeclareKeys`) |
| PDF/A and tagged PDF, document language | main.tex:10-11; lucidcv.cls:92-104, 280-285 | `NEW:meta.documentmetadata` | `\DocumentMetadata{pdfstandard=A-2b,tagging=on,lang=en-US}` before `\documentclass`; `\tagpdfsetup{math/mathml/luamml/load=false}`; the class additionally sets `attach-css=false` and per-heading `para/tag` (H1/H2/H3) itself |
| paper and base size | main.tex:21; lucidcv.cls:70 | `page.class-options` | 10pt, a4paper (passed on to extarticle) |
| page geometry | lucidcv.cls:136; main.tex:34 (commented override) | `page.geometry` | left=right=top=bottom=1.2cm, columnsep=1.1cm (class default, emitted by the class; override via `\geometry{...}` after the class) |
| body columns | lucidcv.cls:65-66, 1039-1047; main.tex:35 (commented) | `class.lucidcv` | key onecolumn (twocolumn is the alternative value of the same key); `\columnratio{0.65}` is the class's own knob; inside the class the second mode is `cols.paracol` `\begin{paracol}{2}` (not emitted separately) |
| column break and page break | contents.tex:127, 133; lucidcv.cls:1059-1066 | `pg.break` | `\newpage` (kernel); `\cvcolumnbreak` is class-native (ignored in onecolumn) and covered by `class.lucidcv` |
| header/footer, page numbers | lucidcv.cls:309; main.tex:120 (commented) | `hf.class-native` | `\pagestyle{empty}` forced by the class; optional `\lastupdated` bottom-right stamp on the last page (label `\cvlastupdatedtext`, width `\cvstampwidth`=60mm, shift `\cvstampvshift`) |
| paragraph shape | lucidcv.cls:308-315; contents.tex:33-35; lucidcv.cls:402-409 | `sp.ragged` | `\raggedright` default; `justify` env (ragged2e `\justifying`, redefined by the class) used once at contents.tex:33; hyphenation off (`\hyphenpenalty=\exhyphenpenalty=10000`), `\emergencystretch=3em`, all set by the class hook |
| main and mono fonts | lucidcv.cls:225-270, 238 | `font.fontspec` | `\setmainfont{Inter}` (Light/SemiBold, Path=fonts/inter/, Extension=.ttf, WordSpace=1.0); `\setmonofont{SourceCodePro}`; `\newfontfamily` SourceSans3 Semibold and Light (WordSpace=1.15) for name, headings, entries; `\defaultfontfeatures{Ligatures=TeX}`; `\sfdefault`=`\rmdefault` (class-internal; font files are bundled in fonts/) |
| icon glyphs | lucidcv.cls:120, 658-666; main.tex:98 | `font.icons` | `fontawesome5` with option `fixed`; icons `\faAt \faPhone \faEnvelope \faMapMarker \faGlobe \faLinkedin \faGithub \faOrcid`, extra `\faGlobeEurope` (main.tex:98); `noicons` class key strips them |
| colour | main.tex:30; lucidcv.cls:124, 161-195 | `color.xcolor` | `xcolor[dvipsnames]`; `\cvaccent[HTML]{1D76E2}` derives accent, name, heading, headingrule=accent!30, grouprule=accent!45; fixed greys CVPrimary 2B2B2B, CVGrey 6A6A6A, CVSubheading 333333 |
| links and PDF metadata | lucidcv.cls:59, 145, 155-156, 790-807; main.tex:64 | `meta.hyperref` | class key `hyper`; `\hypersetup{hidelinks}`; end-of-document hook sets pdftitle/author/subject from `\name`/`\tagline`, pdfkeywords from `\cvkeywords{...}`; `\href` in the body (contents.tex:100) |
| URL style | lucidcv.cls:156 | `meta.url` | `\urlstyle{same}` |
| title block (name, tagline, contact line, photo) | main.tex:70-111; lucidcv.cls:767-1028 | `front.class-native` | `\name{Adrian}{Castellanos}` (SemiBold/Light split), `\tagline{...}`, `\cvphoto[4cm]{photo.jpg}` (diameter 4cm, circular crop), `\cvpersonalinfo{...}` with predefined fields email, phone, location, homepage, linkedin, github, plus `\CvInfoField{citizenship}{\faGlobeEurope}` (declarative field: name and icon); `\makecvheader` runs once; sizes `\cvnamesize`=38, `\cvtaglinesize`=15 |
| section headings | contents.tex:31, 39, 97, 139, 153, 173, 183, 198, 206; lucidcv.cls:1131-1165 | `head.class-native` | `\cvsection{...}`: 16pt Source Sans 3 Semibold in accent colour, 0.4pt hairline `accent!30`; options `noheadingrule`, `compressed`; knobs `\cvsectionsize`, `\cvsectiongapratio`, `\cvrulegaptrim` |
| subsection headings | contents.tex:185, 189; lucidcv.cls:1177-1183 | `head.class-native` | `\cvsubsection{...}`: 11pt, colour 333333 |
| bullet lists | contents.tex:46-51, 66-70, 87-89, 190-193; lucidcv.cls:362-364, 386-388 | `list.enumitem` | `\setlist{leftmargin=1.4em,labelsep=0.5em,itemsep=\cvitemsep(0.15em),topsep=\cvitemtopsep(0.2em),parsep=0pt,partopsep=0pt}`, `\setlist[itemize]{label=\cvitemmarker}`; the body uses kernel `itemize` (`list.kernel`) |
| CV entries | contents.tex:45, 63, 86, 99, 107, 116, 155, 175-177, 186-187, 200-201; lucidcv.cls:1315-1402 | `cv.entries` | `\cventry[oneline, flushdate, askip, bskip, noscale]{title}{side text}{date}`; oneline entries flush the date right on a dotted leader; stacked entries print the date on a second line; title font Source Sans 3 at 1.111x |
| grouped sub-entries | contents.tex:64-82, 156-168; lucidcv.cls:1474-1565 | `cv.entries` | `cvgroup[rule]` (rule width 1.25pt, indent 1.2em, `framed`'s `\MakeFramed` inside the class) with `\cvsubentry[oneline=false, flushdate=false, bskip]{...}` |
| dividers | contents.tex:105, 113; lucidcv.cls:337-345 | `cv.entries` | `\cvdivider`: dashed rule via `dashrule`, `\cvdividerskip`=0.7em, width 0.6pt, dash 0.35em, colour CVGrey!30 |
| technology chips | contents.tex:56, 73, 91, 103; lucidcv.cls:1620-1680 | `cv.entries` | `\cvtag{...}` and `\cvtaglist{a, b, {c, d}}`: rounded chip in accent!6 fill, accent!30 border, separator en-dash; the TikZ node is inside the class command, the emitter writes only the command |
| references block | contents.tex:208-209; lucidcv.cls:1711-1723 | `cv.entries` | `\cvref{name}{email}{address or affiliation}` (hanging indent 1.9em, icons from the email and mailaddress fields) |
| inline marks | contents.tex:34, 100, 108, 141-147, 158, 192 | `mark.kernel` | `\textbf`, `\emph`, `\texttt` |
| vertical space | contents.tex:55, 57, 72, 80 | `sp.lengths` | `\vspace{2pt}`, `\smallskip` (kernel skips; closest lib way) |
| quote environment | lucidcv.cls:421-427 | `quote.kernel` | restyled by the class (colour 333333, italics); not used by the sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| sample-level macros | main.tex, contents.tex | none exist | no `\newcommand`, `\def`, `\newenvironment` or counters in either file; `\CvInfoField` at main.tex:98 is a class declaration call, not new code |
| `lucidcv.cls` (1781 lines) | lucidcv.cls:1-1781 | not bespoke, because it is published (W1: CTAN package `lucidcv`) | emitter writes `\documentclass[...]{lucidcv}` plus the commands in the table above; internals are not copied. For the record, what it holds if it were treated as zip-local: Lua callback patching font ToUnicode (:109-118, :203-212); expl3 contact-field registry (:555-651); TikZ photo/placeholder/chip drawing (:699-720, :1623); `\MakeFramed` group rule (:1474-1507); shipout-hook last-page stamp with `\put` (:1754-1779); prevdepth/`\addvspace` spacing algorithm (:1131-1165). Those would be BESPOKE and ART blockers, so the `yes` is only as good as W1 for this class |
| `latexmkrc` | latexmkrc:1-7 | yes | only selects the engine (`$pdf_mode = 4`, no `.tex` generation, no preprocessor); an emitter's build driver must choose LuaLaTeX |

## Content-opaque
- Header photo `photo.jpg` (489x598 JPEG) at main.tex:79: an included image, content.
- The sample text is fictional and "AI-generated" by its own notice (contents.tex:11): a statement about the data, not addressed to a reader, nothing acted on.
- README.md mentions a `build.sh` and ATS extraction tests that are not in this zip (README.md:105-110); no `EXTERNAL` blocker arises from files that are absent and not needed to produce the PDF.

## Lib changes
- New ways proposed: `NEW:meta.documentmetadata` (LaTeX kernel `\DocumentMetadata` plus `\tagpdfsetup`, engine pdf for the PDF/A and tagging keys, the `luamml` key is LuaLaTeX-only). W1: kernel command of the LaTeX PDF-management code and the CTAN `tagpdf` package, with public documentation. W2: key=value (`pdfstandard`, `tagging`, `lang`, `pdfversion`, tagpdf keys). W3: serves any document that wants PDF/A or a tagged PDF, not one template. W4: one preamble line placed before `\documentclass`, plus a `\tagpdfsetup` line. It is not `meta.pdfx` (a different package, no tagging, loaded after `\documentclass`) and not `meta.hyperxmp`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
