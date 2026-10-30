no

# 0430-powerdot-fu-berlin-style: Powerdot FU Berlin Style

- Unverified: read from the source, not compiled.
- Source: Source/0430-powerdot-fu-berlin-style/ (origin: https://latextemplates.com/downloads/powerdot-fuberlin.zip; licence: LPPL-1.3 per manifest and FUpowerdot.cls:9-13; the images FULogo.png and FUbib.jpg are stated to be FU Berlin copyright, for students and staff only, README:4-6)
- Kind: presentation
- Lib: v5
- Engine: needs XeLaTeX or the DVI/PostScript route, not pdfLaTeX (powerdot loads PSTricks unconditionally, powerdot.cls:185-186; its `ifxetex` branch is powerdot.cls:150-178, patched for xdvipdfmx at powerdot.cls:1572-1578; the documented route is latex + dvips + ps2pdf, main.tex:8)
- Look carried by: class (FUpowerdot.cls defines every slide template and the title slide on top of the published `powerdot` class; main.tex adds only option settings, class-native field commands and content)
- Class origin: ctan (`FUpowerdot` and `powerdot-BerlinFU` are the CTAN and TeX Live package `powerdot-fuberlin`, v0.02a, Herbert Voss, LPPL 1.3, ctan.org/pkg/powerdot-fuberlin read; the version tag matches FUpowerdot.cls:16 and powerdot-BerlinFU.sty:18; the bundled powerdot.cls is v1.7 of 2021/05/19, powerdot.cls:28-29, ctan.org/pkg/powerdot read; both copies in the zip carry small local edits, listed under Bespoke code)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles partly (FUpowerdot.cls and powerdot-BerlinFU.sty in full; the bundled published powerdot.cls, 1626 lines, only lines 1-371, 440-519, 790-819, 850-877, 990-1079, 1250-1273, 1495-1626; not read: 372-439, 520-789, 820-849, 878-989, 1080-1249, 1274-1494; `powerdot-default.sty` is loaded by the class, powerdot.cls:1587-1588, but is not in the zip and was not read)

## Verdict
No. The look is the published `powerdot-fuberlin` class on the published `powerdot` class, and the sample adds only class options, class-native field commands and plain slides, so every component maps to `class.fupowerdot`, `class.powerdot` and ordinary lib ways. What blocks a `yes` is the toolchain: `powerdot` loads `pstricks` and `pst-ovl` unconditionally and places every slide part with `\rput`, and its documented route is latex, dvips and ps2pdf (PostScript pass outside TeX). Under the pilot ruling on unconditional loads that is `EXTERNAL/package`, the same type as the lib's `class.prosper` dvips note. I did not establish that the XeLaTeX branch needs no Ghostscript, and a wrong yes costs more than a wrong no. If a reader accepts that branch as TeX-only, the blocker falls away and the verdict would be yes with Engine: needs XeLaTeX.

## Blockers
- `EXTERNAL/package` `pstricks` and `pst-ovl` are loaded unconditionally by the published class (powerdot.cls:185-186) and all slide parts are placed with `\rput`; the route is latex, dvips, ps2pdf: `dvips` hyperref driver forced by FUpowerdot.cls:20 and powerdot.cls:180-181, raw PostScript `\special{!...}` powerdot.cls:229-247, `\pdfmark` bookmarks and transitions powerdot.cls:853-860 and 1253-1268, and "Powerdot uses a DVI/PostScript workflow" main.tex:8. The XeLaTeX branch (powerdot.cls:150-178, 1572-1578) is not shown to avoid Ghostscript.

Not counted as blockers, recorded for a reader who re-reads under other definitions: the two PSTricks drawings in the class templates, the frame rules (`\psline`, FUpowerdot.cls:106-107) and the grey title band (`\rput` with `\colorbox`, FUpowerdot.cls:80-84), would be `ART/class` if the class were zip-local. They sit inside the published class and are not re-emitted when the emitter writes `\documentclass{FUpowerdot}`, as a published beamer theme's shapes are not.

## Class setting
- Class: `class.fupowerdot` options: `english` (main.tex:1), forwarded to powerdot by `\DeclareOption*` (FUpowerdot.cls:21-22). It loads `class.powerdot` (FUpowerdot.cls:23), whose presets are size=11pt, style=default, orient=landscape, paper=screen, display=slides, hlentries=true, mode=present (powerdot.cls:90-92), and which loads `article` (powerdot.cls:139). Style `default` comes from `powerdot-default.sty` (powerdot.cls:1587-1588), not in the zip, not read. The class could equally be `class.powerdot` with `style=BerlinFU` (powerdot-BerlinFU.sty, the style form of the same design); the sample uses the class form.
- Class-native vocabulary used: FUpowerdot adds `\framelogo` `\titlelogo` `\fachbereich` `\subtitle` `\institute` (FUpowerdot.cls:53-70; used main.tex:5-6, 13, 15, 17). Powerdot supplies the `slide` environment with a title argument and the `[toc=]` key (main.tex:23, 28, 36; key powerdot.cls:336), `\maketitle` (powerdot.cls:798, overridden by FUpowerdot.cls:142), `\pdsetup{trans=none}` (main.tex:18; keys powerdot.cls:284, 330), `\section` turned into a section slide (powerdot.cls:1065-1067), `\tableofcontents` (powerdot.cls:997), and for style authors `\pddefinetemplate` (powerdot.cls:461) and `\setkeys[pd]{section}` (FUpowerdot.cls:132).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1; FUpowerdot.cls:21-23 | `class.fupowerdot` | option `english`; loads `class.powerdot` v1.7 (powerdot.cls:28-29) |
| slide size and orientation | powerdot.cls:90-92, 122-138, 145-148, 225-227 | `page.class-options` | paper=screen (papersize 8.25in x 11in, landscape), geometry loaded by the class with margin=0pt, mag=2000; `\slidewidth`=.5\paperwidth |
| page style | main.tex:2; powerdot.cls:219-221 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| slide footer | FUpowerdot.cls:95-103, 139-140; powerdot.cls:284, 321-322 | `hf.class-native` | `\pdsetup{lf={\tiny\color{FUblue}\insertfachbereich, \@title, \@date}}`; template keys lfpos={\FU@left,.015\slideheight}, rfpos={\FU@right,.015\slideheight}, lffont=rffont=\tiny\color{FUblue}; `rf` stays empty, so no slide number prints |
| frame logo | FUpowerdot.cls:53-62; main.tex:5-6; powerdot.cls:313-320 | `hf.class-native` | `\framelogo{}` (empty in the sample, so nothing prints); keys logohook=rt, logopos={\FU@right,0.99\slideheight}, logocmd={\insertframelogo} |
| title fields | main.tex:12, 14, 16 | `front.maketitle` | `\title` `\author` `\date{\today}` |
| title fields (class-native) | main.tex:13, 15, 17; FUpowerdot.cls:64-70 | `front.class-native` | `\subtitle` `\institute` `\fachbereich` store strings read by the title slide and the footer |
| title slide | main.tex:21; FUpowerdot.cls:72-78, 142-158 | `front.class-native` | `titleslide` template: textpos={\FU@left,.5\slideheight}, textwidth=\FU@textwidth, titlefont=\bfseries\Large\raggedright\color{FUgray}, textfont=\raggedright\color{FUblue}, textheight=.67\slideheight (landscape), .55\slideheight (portrait); body: title, `\medskip`, bold `\normalsize` subtitle, `\vskip2em`, author and `\tiny` institute, `\vskip1.5em`, `\small` date |
| title slide author block | FUpowerdot.cls:149-152 | `tbl.tabularx` | `{\pd@@textwidth}{@{} >{\pd@@textfont}X @{}}`, rows author and institute |
| title slide notes | FUpowerdot.cls:144-145, 154 | `front.thanks` | `\let\footnote\thanks`, `\@fnsymbol`, `\small\@thanks` (the sample has no `\thanks`) |
| title slide band | FUpowerdot.cls:80-84, 85-91 | `class.fupowerdot` | grey band holding the title logo and `\titlegraphic`, band width `\slidewidth-30pt`, height `\FU@image@height` (2.5cm); both logos are empty in the sample; inside the published class, see Blockers note |
| slide frame | FUpowerdot.cls:93-118; main.tex:23, 28, 36 | `class.powerdot` | templates `basic`, `slide`, `wideslide`: titlefont=\bfseries\LARGE\color{FUgray}, titlepos={\FU@left,.94\slideheight}, titlewidth=.7\slidewidth, textpos={\FU@left,.87\slideheight}, textwidth=\FU@textwidth, textheight=.82\slideheight, textfont=\color{black}, iacolor=FUblue!20!white |
| slide frame rules | FUpowerdot.cls:106-107 | `class.fupowerdot` | two full-width FUblue rules, 0.7pt, at 2.5ex and 0.88\slideheight (PSTricks, inside the published class, see Blockers note) |
| section slides | main.tex:27, 35; FUpowerdot.cls:120-132; powerdot.cls:1065-1067 | `head.class-native` | `\setkeys[pd]{section}{sectemp=sectionslide,widesectemp=sectionwideslide}`; titlehook=c, titlefont=\bfseries\LARGE\centering\color{FUred}, titlewidth=0.9\FU@textwidth, titlepos={.5\slidewidth,.6\slideheight} |
| section command | main.tex:27, 35 | `head.kernel` | `\section{...}`, which the class turns into a slide |
| contents slide | main.tex:23-25; powerdot.cls:336, 997 | `toc.kernel` | `\tableofcontents` inside `slide[toc=]` (empty `toc=` keeps the slide out of the contents) |
| bullet lists | main.tex:29-32, 37-40 | `list.kernel` | `itemize`, wrapped by the class to accept enumitem keys (powerdot.cls:188-209) |
| list layout | FUpowerdot.cls:139; powerdot.cls:272-278 | `list.enumitem` | `\pdsetup{list={labelsep=1em,leftmargin=*,itemsep=0pt,topsep=5pt,parsep=0pt}}` |
| bullet labels | FUpowerdot.cls:134-137, 26 | `font.icons` | `\labelitemi` to `\labelitemiv` set to `\ding{110}` and `\ding{117}` (`pifont`) at `\footnotesize`, `\small`, `\tiny`, `\tiny` |
| text face | FUpowerdot.cls:31, 159 | `font.helvet` | `helvet` option `scaled`; `\renewcommand\familydefault{\sfdefault}` |
| default family | FUpowerdot.cls:159 | `font.family-default` | `\sfdefault` |
| encoding | FUpowerdot.cls:24 | `font.fontenc-t1` | `fontenc` option `T1` |
| size and weight switches | FUpowerdot.cls:75, 94, 122, 134-137, 147-153 | `font.size-commands`, `mark.kernel` | `\tiny` `\small` `\normalsize` `\Large` `\LARGE` `\footnotesize`; `\bfseries` |
| ragged setting | FUpowerdot.cls:32, 75-76, 122 | `sp.ragged` | `ragged2e` option `newcommands`; `\raggedright` `\centering` in template fonts |
| manual spacing | FUpowerdot.cls:146-155 | `sp.manual-space` | `\medskip`, `\vskip2em`, `\vskip1.5em`, `\vfil` |
| colours | FUpowerdot.cls:19, 34-38 | `color.xcolor` | FUblue RGB 0,51,102; FUgreen 153,204,0; FUred 204,0,0; FUorange 255,153,51; FUgray gray 0.6; option `table` passed to xcolor (no coloured cell is used) |
| language | main.tex:1; FUpowerdot.cls:18, 25 | `lang.babel` | `ngerman` passed to babel, `english` from the class option; `\RequirePackage{babel}` (which one wins as main language was not checked) |
| hyperlinks | FUpowerdot.cls:20; powerdot.cls:152-153, 180-183 | `meta.hyperref` | `dvips,bookmarks,colorlinks` passed from the class; the class adds setpagesize=false, pdfstartview=Fit, pageanchor=false, bookmarks=false |
| slide transition | main.tex:18; powerdot.cls:284, 1253-1268 | `class.powerdot` | `\pdsetup{trans=none}`, a class key with no lib way of its own |
| load-only helpers | FUpowerdot.cls:27-30 | `class.fupowerdot` | `breakurl`, `graphicx`, `calc`, `tabularx` loaded by the class; the sample calls none of `\burl` and `\includegraphics` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| FUpowerdot.cls as a whole (templates, length registers, field macros, `\pd@maketitle`, label redefinitions) | FUpowerdot.cls:41-159 | published | CTAN `powerdot-fuberlin` v0.02a (FUpowerdot.cls:16); carried by `class.fupowerdot`, not copied. If read as zip-local: template keys are declarative `class.powerdot` vocabulary; `\FU@left` etc. (:41-49) are plain lengths (`sp.lengths`: 15pt, \slidewidth-15pt, \slidewidth-30pt, 2.5cm); `\fachbereich` `\subtitle` `\institute` (:64-70) are string macros; `\pd@maketitle` (:142-158) is a composition of font sizes, `sp.manual-space`, `tbl.tabularx` with no counter or conditional; only the two PSTricks drawings (:80-84, :106-107) have no lib way |
| local edit: logo defaults emptied | FUpowerdot.cls:53-61 (comments :54-55; the original `\global` width line is commented out :59) and powerdot-BerlinFU.sty:46, 50 shows the other default (`\includegraphics` of FULogo and FUbib) | yes | the sample itself calls `\framelogo{}` and `\titlelogo{}` (main.tex:5-6), which are class-native commands, so no default is needed; not diffed against CTAN |
| local patch: `\pd@minipage` replaced by a regular minipage | powerdot.cls:1572-1578 | yes | `box.minipage` `[t][\pd@@textheight][t]{\pd@@textwidth}`; only changes how the text box is built under xdvipdfmx, and is dropped when the published class is used; not diffed against CTAN |
| `\pd@maketitle` override using class internals `\pd@@titlefont` `\pd@@textfont` `\pd@@textwidth` `\@thanks` | FUpowerdot.cls:142-158 | yes | see first row; replaces powerdot's own title slide (powerdot.cls:799-814) |
| style `powerdot-BerlinFU.sty` (not loaded by the sample) | powerdot-BerlinFU.sty:17-151 | published | same design as the class with default logos FULogo and FUbib (sty:46, 50), titlefont `\Large` (sty:83, class :94 has `\LARGE`) and titlewidth .65\slidewidth (sty:94, class :105 has .7); loaded only by `style=BerlinFU` |

## Content-opaque
none (the sample has no figure, table or equation; FULogo.png and FUbib.jpg are used only by `powerdot-BerlinFU.sty:46,50`, which main.tex does not load, and are FU Berlin copyright, README:4-6)

## Lib changes
- New ways proposed: none. Considered: `calc` and `breakurl` (load-only helpers with no printed effect of their own; they stay under the class way, not proposed).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Notes for the consolidator: `class.fupowerdot` is the same family as `class.powerdot`; its vocabulary (`\framelogo` `\titlelogo` `\fachbereich` `\subtitle` `\institute`, `slide` with `[toc=]`, `\pdsetup` keys `lf` `list` `trans` `logohook` `logopos` `logocmd`, `\pddefinetemplate` keys `textpos` `textwidth` `titlefont` `titlepos` `titlewidth` `titlehook` `textfont` `textheight` `lfpos` `rfpos` `lffont` `rffont` `iacolor` `ifsetup`, `\setkeys[pd]{section}` `sectemp` `widesectemp`) is recorded under Class setting above.
