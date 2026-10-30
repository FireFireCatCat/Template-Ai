no

# 0393-muhammedbuyukkinaci-data-scientist-latex: "Twenty Seconds" data-scientist CV with a photo sidebar

- Unverified: read from the source, not compiled.
- Source: Source/0393-muhammedbuyukkinaci-data-scientist-latex/ (origin: https://codeload.github.com/MuhammedBuyukkinaci/Data-Scientist-LaTeX-Resume-with-Photo/zip/refs/heads/master; licence: not established, no LICENSE file in the zip; README.md says "open-source & free")
- Kind: cv
- Lib: v4
- Engine: needs XeLaTeX or LuaLaTeX (`fontspec` at DS_class_file.cls:9 and a font file loaded by path at DS_class_file.cls:105; README.md:21 says to choose LuaLaTeX; both shipped PDFs carry a LuaTeX producer string)
- Look carried by: zip-local (the whole look is in DS_class_file.cls, which provides `twentysecondcv`; the sample preamble only adds the skill data and bubble macros)
- Class origin: zip-local
- Main file: DS_tex_file.tex (other samples: without_photo.tex, same file with the photo line commented out at without_photo.tex:64, and different skill-bar data and a few strings)
- Read: main yes, zip-local classes and styles all

## Verdict
No. The look is a hand-written zip-local class (`twentysecondcv`, not on CTAN: ctan.org/pkg/twentysecondcv is a 404; the README credits two GitHub projects as sources, README.md:11-13) that loads `article` and then draws the template's identity with TikZ: a circular photo clip, a full-height grey sidebar band and data-driven skill progress bars. None of these has a declarative lib way, so they are `ART`. The section heading macro also colours the first three letters of a title by token grabbing, which no lib way expresses. Most of the rest (page, fonts, colours, entry layout, contact table, links) reduces to lib ways.

## Blockers
- `ART/class` circular profile photo: `\includegraphics` scaled by `\imagescale` inside a TikZ `\clip (600/2,567/2) circle (567/2)` (DS_class_file.cls:114-117, DS_class_file.cls:189-193)
- `ART/class` sidebar band: TikZ `remember picture,overlay` node `fill=sidecolor, minimum width=9.2cm, minimum height=\paperheight+1cm` placed at `(-5cm,0.5cm)` from the call point, once per page (DS_class_file.cls:181-183, DS_class_file.cls:420-422); a reduction to an eso-pic page overlay with a filled rule is conceivable but is not shown here, so it counts
- `ART/class` skill progress bars: `\programming` and `\programminglanguage` self-redefine, then draw two TikZ rectangles per `item/value` pair in a `\foreach` loop (DS_class_file.cls:146-168; data at DS_tex_file.tex:49-53; printed at DS_class_file.cls:440 and DS_class_file.cls:452)
- `BESPOKE/class` section heading: `\renewcommand{\section}[1]` replaces the kernel `\section` (unnumbered, no toc entry) and `\@sectioncolor#1#2#3` colours the first three tokens of the title `mainpurple` (DS_class_file.cls:309-323)

## Class setting
- Class: `class.article` (loaded by the zip-local wrapper with `\LoadClass{article}`, DS_class_file.cls:2; the sample calls `\documentclass[letterpaper]{DS_class_file}`, DS_tex_file.tex:4). Options: `letterpaper`. The class file declares `\ProvidesClass{twentysecondcv}` (DS_class_file.cls:1); `\DeclareOption*` and `\ProcessOptions\relax` come after `\LoadClass` (DS_class_file.cls:41-42) and change nothing.
- Class-native vocabulary used (all zip-local, not published): `\cvname` `\cvsurname` `\cvjobtitle` `\cvlinkedin` `\cvgithub` `\cvnumberphone` `\cvsite` `\cvwebsite` `\cvmail` `\profilepic` `\aboutme` `\programming` `\programminglanguage` `\makeprofile` `\makeseconda` `\section`, environment `twenty` with `\twentyitem` (DS_tex_file.tex:65-105, 116-260).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | DS_class_file.cls:2; DS_tex_file.tex:4 | `class.article` | via `\LoadClass`; default 10pt |
| paper | DS_tex_file.tex:4 | `page.class-options` | letterpaper |
| page geometry | DS_class_file.cls:371 | `page.geometry` | left=7.6cm, top=0.1cm, right=1cm, bottom=0.1cm, nohead, nofoot |
| absolute sidebar blocks | DS_class_file.cls:19, 111-112, 187, 426 | `pg.textpos` | options absolute,overlay; `\TPHorizModule`=1cm, `\TPVertModule`=1cm; `textblock{6}(0.55,0.2)` on both pages |
| header/footer | DS_class_file.cls:98, 332 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| font engine | DS_class_file.cls:9 | `font.fontspec` | option quiet |
| heading face | DS_class_file.cls:105 | `font.fontspec` | `\newfontfamily\headingfont[Path = ]{segoeuib.ttf}`; the TTF is shipped in the zip (Segoe UI Bold; redistribution licence not established) |
| body face | DS_class_file.cls:10 | `font.helvet` | package ClearSans (CTAN `clearsans`), option `sfdefault`; the CTAN page lists no options and the package source is not in the zip, so what `sfdefault` does was not read |
| icons | DS_class_file.cls:16, 216-255 | `font.icons` | `fontawesome`: `\faMobilePhone` `\faGlobe` `\faInternetExplorer` `\faEnvelopeO` `\faLinkedinSquare` `\faGithub`; `marvosym` also loaded (DS_class_file.cls:25), never used |
| sizes | DS_class_file.cls:119, 198-206, 319, 347 | `font.size-commands` | `\huge` `\Huge` `\Large` `\LARGE` `\footnotesize` |
| colours | DS_class_file.cls:18, 48-95 | `color.xcolor` | `\definecolor` list (mainpurple 884EA0, sidecolor E7E7E7, gray 4D4D4D, maingray 85929E, pblue 0395DE, material* set...), `\colorlet{headercolor}{gray}`; the `\ifdefined\@cv@print` test (cls:82) has no definition of `\@cv@print` in the zip, so only the else branch applies |
| paragraph spacing | DS_class_file.cls:26, 100 | `sp.parskip-pkg`, `sp.lengths` | package defaults; `\parindent`=0pt |
| table column gap | DS_class_file.cls:334, 355 | `tbl.tabular` | `\tabcolsep`=0pt |
| justified text | DS_class_file.cls:20, 130; DS_tex_file.tex:86, 90, 94 | `sp.ragged` | `ragged2e` `\justifying` in the about-me text |
| manual spacing and breaks | DS_class_file.cls:197-208, 262-272, 317-329, 430-454; DS_tex_file.tex:66-68, 122 | `sp.manual-space` | `\vspace{2mm,1mm,0.5cm,0.7cm,8pt}`, `\hspace{5mm,-0.5cm,0.3cm}`, `\hfill`, `\newline` |
| photo (clipped) | DS_class_file.cls:189-193 | `art.tikz`, `fig.graphicx` | circle clip over `\includegraphics[width=\imagewidth]{\profilepic}`, `\imagewidth`=5cm; `graphicx` is not loaded explicitly in the class (grep), presumably pulled in by tikz (pgf source not read) |
| sidebar band | DS_class_file.cls:181-183, 420-422 | `art.tikz` | node, fill=sidecolor, 9.2cm wide, `\paperheight+1cm` high |
| name and job title | DS_class_file.cls:198-206 | `font.size-commands`, `color.xcolor`, `sp.manual-space` | name and surname `\Huge` mainpurple with `\hspace{5mm}`; job title `\Large` headercolor |
| contact table | DS_class_file.cls:211-259 | `tbl.tabular`, `font.icons`, `meta.hyperref` | `tabular{p{0.4cm} @{\hskip 0.5cm}p{20cm}}`, `\arraystretch`=2; icon cell is `$\begin{array}{l}...\end{array}$` with `\textnormal`, `\huge` or `\Huge`; `\href{https://..}`, `\href{mailto:..}` |
| sidebar labels | DS_class_file.cls:119, 265, 432, 444 | `font.size-commands`, `color.xcolor`, `sp.rule`, `sp.manual-space` | `\profilesection{title}{len}`: `\vspace{8pt}`, `\huge`, headercolor, `\rule[0.15\baselineskip]{len}{1pt}` with len=0.0cm in every call |
| skill bubbles | DS_class_file.cls:374-394, 434, 446; DS_tex_file.tex:7-30 | `art.content-package` | `smartdiagram` (CTAN) `\smartdiagram[bubble diagram]{items}`; keys `bubble center node color=pblue`, sizes 0.5cm, `bubble fill opacity=0.6`, `set color list` of 10 colours (recorded as content-opaque, see below) |
| skill bars | DS_class_file.cls:146-168 | `art.tikz` | `\foreach` rectangles 6 units wide, bar height 0.4, fill maingray, outline mainpurple; the blocker above |
| section headings | DS_class_file.cls:316-323; DS_tex_file.tex:116, 187, 218, 265, 381 | `head.kernel` | `\renewcommand{\section}[1]`: `\LARGE\headingfont\color{headercolor}`, `\vspace{\parskip}` before and after; first-three-letters colour is the blocker above; no counter, no toc, no bookmark |
| entry block | DS_class_file.cls:337-353; DS_tex_file.tex:118-181 | `tbl.tabular`, `box.minipage`, `mark.kernel`, `font.size-commands`, `sp.manual-space` | `tabular*{\textwidth}{@{\extracolsep{\fill}}ll}`; row 1: #1 & `\parbox[t]{0.83\textwidth}{\textbf{#3}\hfill{\footnotesize#4}}`; row 2: #2 & `\parbox[t]{0.83\textwidth}{#5 \\ #6}` (the `#5 \\` only when #5 is not blank, via `\ifblank`) |
| bullets | DS_tex_file.tex:125-135; DS_class_file.cls:28-29 | `list.kernel`, `list.enumitem` | `itemize`; `\setlist[itemize]{leftmargin=*}` |
| links and metadata | DS_class_file.cls:31-39; DS_tex_file.tex:123 | `meta.hyperref` | `hidelinks`, `colorlinks=false`, `allbordercolors=white`, empty `pdftitle` `pdfauthor` `pdfsubject` `pdfkeywords`; `\href` |
| page break and second page | DS_tex_file.tex:258-260 | `pg.break` | `\newpage` then `\makeseconda` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `twentysecondcv` | DS_class_file.cls:1 | partly | the package loads, colours, lengths, geometry and hyperref options reduce as in the map; the TikZ pieces and `\@sectioncolor` below do not |
| one-shot setters `\cvname` ... `\profilepic` (`\newcommand{\x}[1]{\renewcommand{\x}{#1}}`) | DS_class_file.cls:122-137, 139 | yes | the emitter writes each value where it is printed (inline expansion) |
| row guards `\ifthenelse{\equal{\cvmail}{}}{}{...}` | DS_class_file.cls:213-258 | yes | a row is emitted or omitted when the data is present or empty; no TeX logic copied |
| `\twentyitem` and `twenty`, `\ifblank` from `ifmtarg` | DS_class_file.cls:337-353 | yes | see "entry block"; `\ifblank` becomes omission of the `#5 \\` line |
| `\profilesection` | DS_class_file.cls:119 | yes | see "sidebar labels" (the rule width is always 0.0cm) |
| `\renewcommand{\section}` + `\@sectioncolor#1#2#3` | DS_class_file.cls:309-323 | no | the heading font, colour and spacing reduce, but colouring the first three letters is a token-level split of the title; an emitter would have to split the text itself, which is not a parameter of any lib way |
| `\programming`, `\programminglanguage` | DS_class_file.cls:146-168 | no | TikZ `\foreach` bar chart fed by an `item/value` list; the list is data, the drawing is the blocker |
| `\makeprofile`, `\makeseconda` | DS_class_file.cls:180-297, 418-466 | no | `pg.textpos` blocks and the text parts reduce; each also holds the band and photo ART above |
| `\mllibs`, `\pythonlibs` | DS_tex_file.tex:7-30 | yes | each is one `\smartdiagram` call with `\textbf` items padded by `~` |
| `\ProcessOptions` after `\LoadClass` | DS_class_file.cls:41-42 | yes | no effect on the output; `letterpaper` reaches `article` through `\LoadClass` |
| dead code, never called by either sample (grep) | `\arrow` with `pstricks` DS_class_file.cls:12-14; `\icon` :143; `\round` :305-307; `\subsection` :325-330; `twentyshort` and `\twentyitemshort` :358-368; `\grafico` `\supporti` `\settori` `\testo` :409-412; `\cvdate` `\cvaddress` :122, 127; `etoolbox` :21; `marvosym` :25 | yes | nothing prints from them, so they are dropped; `pstricks` is loaded unconditionally (DS_class_file.cls:14) but only `\arrow` would draw with it, and the shipped PDFs were produced by LuaTeX, so it is not recorded as `EXTERNAL` |

## Content-opaque
- Bubble diagrams of skills from `smartdiagram` (DS_tex_file.tex:7-30, printed at DS_class_file.cls:434 and 446): a published diagram package whose items are the skill list. If a reader counts them as template identity (the class sets their colours and sizes, DS_class_file.cls:375-394) it is one more `ART/class`; the verdict does not change.
- The profile photograph `mbk.jpg` is an asset (content), the circular clip around it is the `ART` above.
- Quirk not traced: the class prints the photo unconditionally (DS_class_file.cls:192) while without_photo.tex:64 leaves `\profilepic` commented out; what that does at compile time was not checked. A `\vspace{10mm}` sits in the preamble (DS_tex_file.tex:52); its effect was not checked.

## Lib changes
- New ways proposed: none (considered: `smartdiagram` as its own diagram way, kept under `art.content-package`; considered: an eso-pic overlay for the band, which is `bg.eso-pic` already in the lib but not shown to fit)
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
