yes

# 0504-utrechtuniversity-uucls: UU house-style classes (report, letter, beamer theme)

- Unverified: read from the source, not compiled.
- Source: Source/0504-utrechtuniversity-uucls/ (origin: https://codeload.github.com/UtrechtUniversity/uucls/zip/refs/heads/main; licence: CC0-1.0 for the software, UU branding reserved, README.md:81-89)
- Kind: report
- Lib: v5
- Engine: pdfLaTeX-compatible
- Look carried by: zip-local (uureport.cls defines geometry, page styles, title page, headings and contents; the sample preamble only fills title fields, lib/examples/uureport_template.tex:6-16)
- Class origin: zip-local
- Main file: lib/examples/uureport_template.tex (other samples: lib/examples/uuletter2_template.tex, lib/examples/uubeamer.tex)
- Read: main yes, zip-local classes and styles all

## Verdict
yes. `uureport.cls` is a `\LoadClass{report}` wrapper (lib/classes/uureport.cls:104) whose every redefinition (raw page lengths, two page styles, `\maketitle`, `\@startsection` calls, `\@makechapterhead`, `\l@*` contents lines) is a composition of lib ways with fixed values, written out below; its conditionals (`\if@dutch`, `\if@opensans`, emptiness tests, the `\dividelength` rounding of `\textheight`) are evaluated once at emit time, so no zip-local macro logic is copied. There is no ART and no tool outside TeX (`lib/scripts/uucls.sh` only installs the classes through git, lib/scripts/uucls.sh:33). The letter class and the beamer theme (not loaded by the main sample) also reduce; their weakest points are the logo-table loop (beamerinnerthemeuubeamer.sty:157-185, reduced by emit-time expansion) and the TikZ yellow page fill (beamercolorthemeuubeamer.sty:50-55, reduced to a background colour), which a stricter reviewer could tag `BESPOKE/class` and `ART/class`. The two-line chapter entries in the contents are reproduced approximately (see the toc rows).

Origin check: ctan.org/pkg/uureport returned 404, and README.md:61-65 says the classes were written for personal use with no further documentation (README.md:21-24), so the class is zip-local, not an official kit. `opensans` and `merriweather` are CTAN packages (merriweather page read: LPPL and OFL, pdfLaTeX supported).

## Blockers
none

## Class setting
- Class: `class.report` (loaded by `\LoadClass{report}` inside the zip-local `uureport`, lib/classes/uureport.cls:104; the sample calls `\documentclass[dutch]{uureport}`, lib/examples/uureport_template.tex:1). Options: `a4paper` (default, uureport.cls:91), `dutch` (language: labels and babel, uureport.cls:41-46); 10pt, oneside and openany are report's defaults. Pass-through options: 10pt, 11pt, 12pt, oneside, twoside, draft, final, titlepage, notitlepage, openright, openany, onecolumn, leqno, fleqn, openbib (uureport.cls:51-77); font options `opensans` (default) and `merriweather` (uureport.cls:81-82, 91).
- Class-native vocabulary used: `\chapter` `\section` `\subsection` `\subsubsection` `\tableofcontents` `\maketitle` `figure` `itemize` (kernel report). Zip-local front vocabulary (not published, reduced below): `\title[subtitle]{}` (uureport_template.tex:6), `\sender[sub]{}` (8-10), `\titlepageinfo{}` (11-14), `\version{}` (15), `\imgcaption{}` (57).
- Other samples: `class.letter` (uuletter2 re-implements a letter class, `\opening` `\closing`, uuletter2.cls:81, 359-375) and `class.beamer` (uubeamer.tex:1).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | uureport.cls:104 | `class.report` | as above |
| paper | uureport.cls:51, 91 | `page.class-options` | a4paper |
| page geometry | uureport.cls:146-190 | `page.setlength` | voffset=-1in+1cm; topmargin=0; headheight=4.504cm-0.5in (:142, 149-150); headsep=1em; hoffset=-0.5in; oddsidemargin=evensidemargin=0.5in; textwidth=paperwidth-2in; marginparwidth=1in-2em; marginparsep=1em; marginparpush=0.5em; textheight=floor((paperheight-1in-voffset-topmargin-headheight-headsep-0.75in)/baselineskip)*baselineskip; footskip=0.5in+the remainder |
| spacing | uureport.cls:134-138, 192-199 | `sp.lengths` | lineskip=normallineskip=1pt; parskip=baselineskip (alias `\@leading`); parindent=0 |
| line stretch | uureport.cls:199 | `sp.linespread` | `\baselinestretch` emptied |
| encodings | uureport.cls:112-113 | `font.fontenc-t1` | utf8, T1 |
| body font | uureport.cls:91, 114-122 | `font.helvet` | `opensans` with option `default`; alternative `font.serif-pkg` = `merriweather` (:115) |
| language | uureport.cls:126-130; uureport_template.tex:1 | `lang.babel` | dutch; strings Versie, Inhoudsopgave, Universiteit Utrecht (uureport.cls:44-46) |
| title-page head | uureport.cls:207-211, 523-542 | `hf.fancyhdr` | style `uureport@title`: head = `\hspace*{-1in}` + logo + sender block, foot empty |
| title-page logo | uureport.cls:43, 524 | `fig.graphicx` | `\includegraphics{UU_logo_2021_NL_RGB.png}` |
| sender block | uureport.cls:535-542, 544-556; uureport_template.tex:8-14 | `box.minipage` | `[b][4.504cm][t]` width linewidth+1in-11.413cm; `\vspace{headheight-5\normalbaselineskip}` (`sp.manual-space`); `flushright`/`\raggedleft` (`sp.ragged`) |
| running head | uureport.cls:212-223, 241 | `hf.fancyhdr` | raisebox 0.5\headheight, parbox linewidth, `\small` title left, "Universiteit Utrecht[, subsender]" right; applied with `hf.pagestyle-kernel` `\pagestyle` |
| running foot | uureport.cls:213-215, 224-240 | `hf.fancyhdr` | right half: page number left, date and version ("Versie 1.0", :558-563) right; twoside swaps sides |
| page numbering | uureport.cls:203, 251 | `pgnum.pagenumbering` | arabic; page set to 1 at the title page |
| title page | uureport.cls:247-279; uureport_template.tex:20 | `front.titlepage-env` | `\thispagestyle{uureport@title}`, `\null\vfil`, `\rule{4cm}{0pt}` + minipage of textwidth-4cm, `\raggedright`; title `\LARGE`, subtitle `\Large`, 2pt gap, authors `\large` in `tabular[t]{@{}l}` (`tbl.tabular`, :266-268); `\vfil\null`; `\thanks` text (`front.thanks`, :270) |
| title block, no titlepage | uureport.cls:280-324 | `front.titlepage-env` | same block after `\vskip 2em`, `\vskip 1.5em`; kept for the `notitlepage` option |
| date | uureport.cls:504-505; uureport_template.tex:16 | `front.datetime` | `\today` prints D-M-YYYY (no leading zeros) |
| spacing after period | uureport.cls:506 | `sp.frenchspacing` | on |
| contents title | uureport.cls:450-468; uureport_template.tex:22 | `toc.tocloft` | title `\Large` + label text, not a chapter heading; `\parskip` 0 inside the list; `\clearpage` first (`pg.break`) |
| contents levels | uureport.cls:448-449, 469-502 | `toc.tocloft` | dots off (`\@dotsep`=1000); chapter `\large`, left skip 1.5em, no number, before-skip 0.5\@leading; section indent/numwidth 2.5em/4em, subsection 3.5/5.5, subsubsection 4.5/7, paragraph 5.5/8.5, subparagraph 6.5/10; part-type lines `\large\bfseries`, before-skip 2.25em plus 1pt |
| contents "Chapter N" lines | uureport.cls:396 | `toc.kernel` | body wrapper `\addcontentsline{toc}{part}{\chaptername\ N}` before each numbered `\chapter` (the emitter knows N); approximate |
| tocdepth, secnumdepth | uureport.cls:326, 449 | `num.secnumdepth` | secnumdepth=3, tocdepth=3 |
| counter printing | uureport.cls:327-331 | `num.counters` | `\thesection`=`\thechapter.\arabic{section}.`, each deeper level appends its counter and a dot |
| chapter heading | uureport.cls:387-416; uureport_template.tex:24, 53, 68 | `head.titlesec` | display; label bold "chaptername N" at normal size; title `\LARGE\bfseries`, `\raggedright`, parindent 0; after-skip \@leading (12pt at 10pt); `\clearpage` before (`pg.break`, :388) |
| unnumbered chapter | uureport.cls:417-426 | `head.titlesec` | numberless: `\LARGE\bfseries`, same after-skip |
| section | uureport.cls:427-430; uureport_template.tex:30, 48, 60, 77 | `head.titlesec` | level 1, indent 0, before 2em plus .5em minus .5em, after 1pt, `\normalfont\bfseries` |
| subsection, subsubsection | uureport.cls:431-438; uureport_template.tex:39, 44, 86, 90 | `head.titlesec` | levels 2 and 3, indent 0, before 1em plus .5em minus .5em, after 1pt, `\normalfont\itshape` |
| paragraph, subparagraph | uureport.cls:439-446 | `head.titlesec` | run-in (after -1em), before 3.25ex plus 1ex minus .2ex; subparagraph indent `\parindent`; not used by the sample |
| part | uureport.cls:332-386 | `head.titlesec` | `\part`: 6cm hanging indent, `\huge` label, `\Huge` title, page to itself; toc line via `\addcontentsline{toc}{part}`; not used by the sample |
| list | uureport_template.tex:80-84 | `list.kernel` | itemize with report defaults (the class does not change lists) |
| figure | uureport_template.tex:55-58; uureport_template.tex:4 | `fig.graphicx` | `figure[h]`, `\includegraphics[width=\linewidth]{sample-image.png}`, `\graphicspath{{./resources}}` |
| figure text | uureport_template.tex:57; uureport.cls:567-568 | `font.size-commands` | `\imgcaption` = `\scriptsize\itshape` text (no `\caption`, no number); `\itshape` is `mark.kernel` |
| label | uureport.cls:508 | `xref.kernel` | `\label{@lastpage}` at end; nothing in the class reads it, dropped |
| letter: class and page | uuletter2_template.tex:1; uuletter2.cls:78-81, 111-131 | `class.letter` | dutch, opensans, 10pt; `page.setlength`: paperwidth 210mm, paperheight 297mm, voffset -1in, textwidth 170mm, textheight 221mm, oddsidemargin 0, footskip 1cm, headheight 46mm, headsep 0; secnumdepth 0 (`num.secnumdepth`); parskip=baselineskip (`sp.lengths`) |
| letter: fonts, language | uuletter2.cls:92-108 | `font.helvet` | `opensans[default]`, `font.fontenc-t1`, `lang.babel` dutch; `meta.hyperref` colorlinks=false (:88) |
| letter: head | uuletter2.cls:220 | `hf.fancyhdr` | `\hspace*{-1in}` + logo (`fig.graphicx`) |
| letter: foot | uuletter2.cls:221-227, 372 | `hf.fancyhdr` | reference left, "Pagina X van Y" right; Y from `\pageref*{lastpage:N}` (`xref.hyperref`), label per letter, page reset to 1 (:319) |
| letter: address block | uuletter2.cls:317-357; uuletter2_template.tex:8-24, 33 | `ltr.opening` | three `parbox`es (`box.minipage`) 10.5cm/6.5cm/10.5cm wide, 5.48cm/5.48cm/5.35cm high; `tabular{@{}p{2.97cm}@{}p{7.53cm}@{}}` (`tbl.tabular`) of label rows; empty rows left out at emit time |
| letter: closing | uuletter2.cls:363-375; uuletter2_template.tex:37 | `ltr.opening` | closing, signature (`\includegraphics[width=3.5cm]`, :306), name, function; keep-together via `pg.needspace`; `\clearpage` (`pg.break`) |
| letter: lists, quote | uuletter2.cls:151-218 | `list.kernel` | leftmargini 2.5em, topsep=itemsep .4em, parsep 0 (`sp.lengths`); `quote.kernel` quote and quotation |
| letter: filler | uuletter2_template.tex:26, 35 | `draft.todo` | `lipsum` |
| beamer: class, theme | uubeamer.tex:1, 7; beamerthemeuubeamer.sty:20-57 | `class.beamer` | 10pt; the zip-local theme is written out as `slide.beamer-template` setters (not `slide.beamer-theme`: the name is zip-local) |
| beamer: margins, footline | beamerouterthemeuubeamer.sty:77-109 | `slide.beamer-template` | text margins 0.1\paperwidth; headline and navigation symbols empty; footline of four minipages (logo scale 0.2, footline text, date, frame number) |
| beamer: title page | beamerinnerthemeuubeamer.sty:60-114; uubeamer.tex:26-49 | `slide.beamer-template` | logo scale 0.4, headline `\tiny`, date, title/subtitle/author/institute minipages; `fig.graphicx`, `box.minipage` |
| beamer: colours | beamercolorthemeuubeamer.sty:24-37 | `color.xcolor` | 12 `\definecolor` in RGB (uu-yellow 255,205,0 ... uu-purple); structure fg=uu-black via `slide.beamer-template` |
| beamer: fonts | beamerfontthemeuubeamer.sty:24-37 | `font.serif-pkg` | `merriweather[rm]` + `font.helvet` `opensans[defaultsans]`; title italic serif `\LARGE`, author bold, frametitle bold `\Large`, title page `\scriptsize` (`slide.beamer-template`) |
| beamer: yellow page | beamercolorthemeuubeamer.sty:47-56; beamerinnerthemeuubeamer.sty:137-140 | `slide.beamer-template` | `\setbeamercolor{background canvas}{bg=uu-yellow}` on title and disclaimer frames in place of the full-page TikZ rectangle (the `white` option omits it) |
| beamer: items, theorem | beamerinnerthemeuubeamer.sty:115-130; uubeamer.tex:56-93 | `thm.class-native` | beamer's own `theorem` and `proof`; `slide.beamer-template` itemize items circle, theorem begin/end through a `block`; `list.kernel` |
| beamer: disclaimer frame | beamerinnerthemeuubeamer.sty:131-192 | `slide.beamer-template` | explicit last frame: payoff logo (scale 0.5, beamerouterthemeuubeamer.sty:72), disclaimer `\tiny` in minipage 0.6\paperwidth, `\rule{0.6\paperwidth}{0.5pt}` (`sp.rule`), partner logos width 0.15\paperwidth in `tabular{ccc}` (`tbl.tabular`), no headline/footline |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| uureport.cls as a whole | uureport.cls:17-592 | yes | `class.report` plus the rows above; no output routine, no box algorithm |
| language/font flags `\if@dutch` `\if@opensans` `\if@merriweather`, label macros | uureport.cls:22-46, 81-82, 114-130 | yes | one language and one font package chosen at emit time, label strings written out |
| `\dividelength`, `\multiplylength`, `\@tempdima` rounding of `\textheight` | uureport.cls:97-98, 168-190 | yes | static lengths: the emitter computes textheight and footskip for the chosen font size (baselineskip at class load, uureport.cls:138) |
| length aliases `\@leading` `\@logowidth` `\@logoheight` | uureport.cls:134-142 | yes | inline lengths |
| page styles `\ps@uureport@title` `\ps@uureport@running` | uureport.cls:207-241 | yes | `hf.fancyhdr` styles with the field text above |
| `\title` `\maketitle` `\@maketitle` `\sender` `\titlepageinfo` `\version`, `\@print@*` | uureport.cls:244-324, 523-563, 577-592 | yes | field values inlined; emptiness tests (`\if &\@sender&`) decided at emit time; `\global\let ...\relax` is kernel plumbing only |
| `\imgcaption` | uureport.cls:567-568 | yes | `{\scriptsize\itshape text}` |
| `\IfImageExists` and the logo-not-found box | uureport.cls:512-527 | yes | plain `\includegraphics`; file presence is a packaging matter |
| `\@chapter`, `\@makechapterhead`, `\@schapter` | uureport.cls:392-426 | yes | `head.titlesec` format and `\addcontentsline` wrapper (toc rows) |
| `\part` `\@part` `\@spart` `\@endpart` | uureport.cls:332-386 | yes | `head.titlesec` part format; twoside blank page by `pg.break` |
| `\tableofcontents`, `\l@part` `\l@chapter` `\l@section` ... | uureport.cls:450-502 | yes | `toc.tocloft` lengths and fonts (two-line chapter entry approximate) |
| `\AtBeginDocument` `\today`, `\frenchspacing`; `\AtEndDocument` label | uureport.cls:504-508 | yes | `front.datetime` format, `sp.frenchspacing`; label unused |
| uuletter2.cls (field macros, `\@makeheader`, `\opening`, `\closing`, `\@clearcaches`, `\newcounter{letter}`) | uuletter2.cls:231-375 | yes | field values inlined into the boxes; one `lastpage:N` label per letter, N counted by the emitter |
| `\startbreaks` `\stopbreaks` (redefine `\par`, `\\`, `\vspace`) | uuletter2.cls:133-150, 364, 373 | yes | `pg.needspace` before the closing block (short block, height known); approximate |
| list and quote re-declarations in uuletter2.cls | uuletter2.cls:151-218 | yes | `sp.lengths` values on `list.kernel`/`quote.kernel` |
| partner-logo collector `\partnerlogos` (recursion, `\csname`, token loop, 3 per row by `\divide`/`\multiply`) | beamerinnerthemeuubeamer.sty:16-32, 157-185 | yes | logos are static data: the emitter writes `tabular{ccc}` with `\\` after every third |
| `\headline` `\footline` `\disclaimer` stores, `\if@white` `\if@nodisclaimer` | beamerinnerthemeuubeamer.sty:20-48; beamerouterthemeuubeamer.sty:15-25 | yes | values inlined into title page and footline templates; switches resolved |
| `\AtEndDocument` disclaimer frame | beamerinnerthemeuubeamer.sty:131-192 | yes | explicit last frame |
| TikZ full-page fill on title and disclaimer pages | beamercolorthemeuubeamer.sty:50-55; beamerinnerthemeuubeamer.sty:137-140 | yes | one-colour page background (`slide.beamer-template` background canvas); not drawn identity, no shape or logo drawn |
| `\ps@uuslides@titlepage` and `...@disclaimer` | beamerinnerthemeuubeamer.sty:50-59 | yes | intent is empty headline, footline and navigation symbols on those two frames (`slide.beamer-template`) |

## Content-opaque
- pgf-pie chart on a demo slide (`\pie` in `tikzpicture`, uubeamer.tex:98-121, `art.tikz`): it shows the `uu-*` palette; the palette itself is mapped above.
- Lorem ipsum text (uureport_template.tex:26-92), `sample-image.png` (uureport_template.tex:56), Rolle theorem text (uubeamer.tex:76-80).
- Missing asset path: `\graphicspath{{./resources}}` (uureport_template.tex:4) points at lib/examples/resources, which is not in the zip; the logos and sample image sit in lib/resources/. Ship them with the document (not a blocker).

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
