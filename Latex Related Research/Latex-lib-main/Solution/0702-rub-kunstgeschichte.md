yes

# 0702-rub-kunstgeschichte: rub-kunstgeschichte (RUB art history term-paper class)

- Unverified: read from the source, not compiled.
- Source: Source/0702-rub-kunstgeschichte/ (origin: https://mirrors.ctan.org/macros/latex/contrib/rub-kunstgeschichte.zip; licence: LPPL 1.3c)
- Kind: assignment (a seminar term paper, "Hausarbeit", for the art history institute KGI at Ruhr University Bochum; the manifest hint `book` is wrong)
- Lib: v5
- Engine: pdfLaTeX-compatible (no `fontspec`; biblatex runs with the biber backend; the class needs a LaTeX kernel of 2022-06-01 or later for `\DeclareKeys`)
- Look carried by: class (the whole look is in the published class: `.dtx` lines 322-510 set base class, packages and options, lines 580-756 the title page and `\appendix`; the sample's preamble adds only babel, graphicx, float and bibliography data)
- Class origin: ctan (ctan.org/pkg/rub-kunstgeschichte read: v0.5.0 of 2025-02-04, LPPL 1.3c, in TeX Live; the zip is the CTAN contrib zip)
- Main file: rub-kunstgeschichte-example.tex (other samples: none; `rub-kunstgeschichte.dtx` is the class source and its own `ltxdoc` documentation driver, not a sample)
- Read: main yes, zip-local classes and styles all (there is no `.cls` file in the zip; the class is generated from `rub-kunstgeschichte.dtx` by `rub-kunstgeschichte.ins:55`, and every code line of the `.dtx` was read, lines 246-832; the two PDFs were not opened)

## Verdict
The look is carried entirely by the published CTAN class `rub-kunstgeschichte`, which loads `article` at 12pt and sets `geometry`, `setspace`, `parskip`, `hyperref` and `biblatex` (style `arthistory-bonn`, biber) with fixed options. The sample adds only `babel`, `graphicx`, `float`, a `.bib` file and class-native commands. Each package the class loads is published (CTAN pages read for the class, `boxedminipage` and `biblatex-arthistory-bonn`), and the class's own macros are its published vocabulary, recorded below. No artwork, no external tool beyond biber (`bib.biblatex-biber` is a lib way), no unmapped component. This is evidence about the class dimension: an emitter writes `\documentclass{rub-kunstgeschichte}` and the class-native commands, with no zip-local macro logic copied.

## Blockers
none

## Class setting
- Class: `class.rub-kunstgeschichte` options: none in the sample (rub-kunstgeschichte-example.tex:24). The class defines keyval options `biblatex=` (extra biblatex options, overriding the defaults), `hyperref=` (load-time hyperref options), `parskip`, `noparskip` (rub-kunstgeschichte.dtx:261-264, 272-275, 294-304; processed at :311). The base is `\LoadClass[12pt]{article}` (dtx:322), so `class.article` is the base class.
- Class-native vocabulary used: `\title` `\author` `\date` (kernel, read by the class title page), `\configureTitlepage{email=...}` (sample:29-31), `\maketitle[keys]` redefined as a full title page (sample:114; dtx:580-583), `\subtitle` (dtx:723-729, not used by the sample), `\appendix` redefined to set `secnumdepth` to 0 (sample:150; dtx:742-756), `\printbibliographies[heading,heading-primary,heading-secondary]` (sample:162; dtx:525-550), `\figuresource{text}` inside `figure` (sample:177; dtx:765-767), `\printfiguresources[heading]` (sample:181; dtx:775-786), `\autocite`/`\autocites` (biblatex, footnote mode, sample:127, 142-144). Title-page keys: `email` `matricnum` `author-semester` `seminar-semester` `seminar-lecturer` `seminar-name` `seminar-degree` `seminar-module` `seminar-cp` (dtx:682-705; defaults are CAPS placeholder strings, dtx:694-705). Translated strings (english and german): Primary Bibliography, Secondary Bibliography, Figure Sources (dtx:813-824).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | rub-kunstgeschichte-example.tex:24 | `class.rub-kunstgeschichte` | no options given; own options `biblatex` `hyperref` `parskip` `noparskip` |
| base class (inside the class) | rub-kunstgeschichte.dtx:322 | `class.article` | `\LoadClass[12pt]{article}` |
| paper and font size | rub-kunstgeschichte.dtx:322, 441 | `page.class-options` | `12pt` (class option of article), `a4paper` (geometry option) |
| page geometry | rub-kunstgeschichte.dtx:440-443 | `page.geometry` | a4paper, top=2cm, left=2cm, bottom=2cm, right=4cm (4cm right correction margin; the example text says so at sample:127) |
| title-page geometry | rub-kunstgeschichte.dtx:597, 677 | `page.geometry` | `\newgeometry{left=2.5cm,top=2.5cm,bottom=2cm,right=2.5cm}`, then `\restoregeometry` |
| line spacing | rub-kunstgeschichte.dtx:429 | `sp.setspace` | `\RequirePackage[onehalfspacing]{setspace}` |
| paragraph shape | rub-kunstgeschichte.dtx:285-289, 453-455 | `sp.parskip-pkg` | loaded unless `noparskip` is given (switch default true) |
| links and PDF behaviour | rub-kunstgeschichte.dtx:481, 485; sample:103 | `meta.hyperref` | `\hypersetup{hidelinks}` in the class; `\hypersetup{ngerman=true}` in the sample |
| language | rub-kunstgeschichte-example.tex:101 | `lang.babel` | option `ngerman` (translates the bibliography headings) |
| translated strings | rub-kunstgeschichte.dtx:494, 813-824 | `lang.translator` | `translations` package, `\DeclareTranslation{english\|german}{key}{text}` for three keys, read with `\GetTranslationWarn` (dtx:555, 558, 561, 791) |
| title block | rub-kunstgeschichte-example.tex:27-31, 114; rub-kunstgeschichte.dtx:580-678 | `front.class-native` | fields via `\title` `\author` `\date` and the nine `\configureTitlepage` keys; the page text is fixed German (dtx:613-628, 638, 661-666) |
| title page wrapper | rub-kunstgeschichte.dtx:595, 669 | `front.titlepage-env` | kernel `titlepage` environment (page style empty, one full page) |
| title page, university and seminar table | rub-kunstgeschichte.dtx:611-629 | `tbl.tabularx` | `tabularx` `{\linewidth}{@{}lX}`, `\multicolumn{2}{@{}l}` rows |
| title page, author table | rub-kunstgeschichte.dtx:660-667 | `tbl.tabular` | `{@{}ll}`, `\href{mailto:..}` for the email (`meta.hyperref`, dtx:663-664) |
| title page, top-left block | rub-kunstgeschichte.dtx:604-610 | `box.minipage` | `minipage[t]` of width `\dimexpr\textwidth-5.03cm-0.5cm\relax` |
| title page, grade box | rub-kunstgeschichte.dtx:634-639, 510 | `box.fancybox` | `boxedminipage[t][3.78cm][t]{5.03cm}` (framed minipage; `boxedminipage` is on CTAN, page read: framed minipage of a given total width) |
| title page, vertical and horizontal fill | rub-kunstgeschichte.dtx:610, 632, 637-638, 642, 649, 656 | `sp.manual-space` | `\vspace{0pt}`, `\hfill`, `\vspace{1em}`, `\hspace{1em}`, `\vfill`, `\vskip 2em` |
| title page, title and author sizes | rub-kunstgeschichte.dtx:645-654 | `font.size-commands` | `\LARGE` title, `\Large` subtitle, `\large` author, in a `center` environment |
| title page, ragged text | rub-kunstgeschichte.dtx:602, 659 | `sp.ragged` | `\raggedright` groups |
| title page has no number, counts as page 1 | rub-kunstgeschichte.dtx:595, 673 | `hf.pagestyle-kernel` | `titlepage` makes the page style `empty`; the other pages keep article's `plain` |
| page counter after title page | rub-kunstgeschichte.dtx:673 | `pgnum.pagenumbering` | `\setcounter{page}{2}` |
| contents | rub-kunstgeschichte-example.tex:117 | `toc.kernel` | `\tableofcontents`, article default depth |
| headings | rub-kunstgeschichte-example.tex:123, 138, 152, 165 | `head.kernel` | article `\section`, no redefinition in the class |
| appendix without numbers | rub-kunstgeschichte-example.tex:150; rub-kunstgeschichte.dtx:742-756 | `num.appendix` | kernel `\appendix` kept as `\oldappendix` and followed by `\setcounter{secnumdepth}{0}` (`num.secnumdepth`) |
| section numbering depth | rub-kunstgeschichte.dtx:755 | `num.secnumdepth` | `secnumdepth=0` after `\appendix` |
| page breaks | rub-kunstgeschichte-example.tex:120, 148, 158, 161, 164 | `pg.break` | `\clearpage` |
| bibliography engine and style | rub-kunstgeschichte.dtx:337-362, 372-401, 409, 417 | `bib.biblatex-biber` | `backend=biber`, `singletitle=true`, `autocite=footnote`, `autopunct=true`, `style=arthistory-bonn` (`biblatex-arthistory-bonn`, CTAN, page read), `firstcitefull=true`, `enddot=true`, `namelinked=true`; class option `biblatex=` appends more |
| bibliography data | rub-kunstgeschichte-example.tex:39-92, 96 | `bib.biblatex-biber` | kernel `filecontents` writes the `.bib`, `\addbibresource`; entries are content, `keywords = {source}` marks primary sources (sample:58, 67) |
| citations as footnotes | rub-kunstgeschichte-example.tex:127, 142-144, 157, 166 | `bib.biblatex-biber` | `\autocite[prenote][postnote]{key}`, `\autocites`; printed through footnotes (`fn.kernel` effect of `autocite=footnote`) |
| split bibliography | rub-kunstgeschichte-example.tex:162; rub-kunstgeschichte.dtx:525-550 | `bib.biblatex-biber` | `\printbibliographies` = `\addcontentsline{toc}{section}{..}`, `\printbibheading[heading=bibliography,title=..]`, `\printbibliography[keyword=source,heading=subbibliography,title=..]` and `notkeyword=source` |
| footnote | rub-kunstgeschichte-example.tex:134 | `fn.kernel` | `\footnote` |
| inline marks | rub-kunstgeschichte-example.tex:124, 130 | `mark.kernel` | `\textsf`, `\textit` |
| verbatim | rub-kunstgeschichte-example.tex:134, 142 | `code.verbatim` | `\verb\|..\|` |
| figure float | rub-kunstgeschichte-example.tex:106-107, 172-178 | `fig.graphicx` | `graphicx`, `\includegraphics[width=0.8\linewidth]{example-image-golden}`, `\centering` |
| figure placement | rub-kunstgeschichte-example.tex:107, 172 | `fig.float` | `float` package, placement `[H]` |
| caption and label | rub-kunstgeschichte-example.tex:175-176 | `cap.kernel` | `\caption` (no `\captionsetup`), `\label` (`xref.kernel`) |
| figure reference | rub-kunstgeschichte-example.tex:169 | `xref.hyperref` | `\autoref{fig:exampleArtwork}` |
| figure source list | rub-kunstgeschichte-example.tex:177, 181; rub-kunstgeschichte.dtx:765-767, 775-799 | `fig.class-native` | `\figuresource{text}` stores a string per figure number, `\printfiguresources[heading=]` prints a section "Abbildungsnachweise" and one line "Abbildung N: text" per figure (macro logic stays inside the class) |
| class helper packages | rub-kunstgeschichte.dtx:464, 471 | none | `etoolbox` and `forloop` are loaded for the figure-source macros only (load helpers inside the class, no printed component) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| the class itself | rub-kunstgeschichte.dtx:246-830 | n/a, published | CTAN class (page read), so `class.rub-kunstgeschichte`; not zip-local, so not bespoke |
| `\maketitle` redefinition, `\configureTitlepage`, `\subtitle` | rub-kunstgeschichte.dtx:580-729 | yes, if it had to be expanded | `titlepage` + `tabularx` + `tabular` + `minipage` + `boxedminipage` + `\newgeometry`/`\restoregeometry` + `\setcounter{page}{2}`, all lib ways above; only strings change |
| `\printbibliographies` | rub-kunstgeschichte.dtx:525-571 | yes | biblatex `\printbibheading` and two `\printbibliography` calls with `keyword`/`notkeyword`, plus `\addcontentsline`; heading strings from `translations` |
| `\appendix` redefinition | rub-kunstgeschichte.dtx:742-756 | yes | kernel `\appendix` then `\setcounter{secnumdepth}{0}` |
| `\figuresource`, `\printfiguresources` | rub-kunstgeschichte.dtx:765-799 | no, if the class were not a way | a hand-rolled counter loop (`forloop` over `figure`) reading dynamically named macros (`\csgdef`, `\ifcsdef`) that decides what is printed; kept inside `class.rub-kunstgeschichte` as published class vocabulary, so it is no blocker here |
| `\DeclareKeys` option and title-key machinery | rub-kunstgeschichte.dtx:261-311, 682-705 | yes | kernel keyval options; values are strings and booleans |

## Content-opaque
none (the included image `example-image-golden` at rub-kunstgeschichte-example.tex:174 is figure content held by `fig.graphicx`; it comes from the TeX distribution's `mwe` files, not from the zip, so it is a missing asset to ship; the bibliography entries at :39-92 are content)

## Lib changes
- New ways proposed: none. (Considered `boxedminipage` for a new box way and filed it under `box.fancybox`, whose line names framed boxes; it is used once, inside the class.)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
