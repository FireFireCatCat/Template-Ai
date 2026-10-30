no

# 0351-cryptection-stylishcv: stylishcv (CV and cover-letter template, fork of simple-hipstercv)

- Unverified: read from the source, not compiled.
- Source: Source/0351-cryptection-stylishcv/ (origin: https://codeload.github.com/cryptection/stylishcv/zip/refs/heads/main; licence: CC BY-NC-SA 4.0 per LICENSE.md:1, manifest says NOASSERTION)
- Kind: cv
- Lib: v3
- Engine: pdfLaTeX-compatible (README.md:84 says compile with pdfLaTeX; the TikZ overlays need two passes, README.md:84 and Examples/Main_withoutsidebar.tex:89)
- Look carried by: mixed (the zip-local `stylishcv.cls` + `stylishcv.sty` define the banner, footer band, entry macros and colours; the sample preamble defines geometry, Raleway and the shaded section-header boxes)
- Class origin: zip-local (a one-read check of ctan.org/pkg/stylishcv gave 404; the zip is the author's own GitHub fork of latex-ninja's simple-hipstercv, README.md:13, not a publisher kit; the verdict does not change if it were read as an official release)
- Main file: Examples/Main_withoutsidebar.tex (other samples: Examples/Main_lightstylish.tex, Examples/Main_darkstylish.tex, Examples/Letter.tex; the pulled-in parts Examples/Letter_withoutsidebar.tex and Examples/Attachments.tex were read as part of the main sample)
- Read: main yes, zip-local classes and styles all (stylishcv.cls 155 lines, stylishcv.sty 362 lines; the lightstylish/darkstylish mains and Letter.tex only by diff against the main sample)

## Verdict
No. The look is defined by zip-local TikZ overlay artwork: a full-bleed header banner, a full-bleed footer band, a cover-letter sub-header band, a clipped circular photo frame, and two drawn widgets (hobby badge, icon cross). None reduces to a declarative lib way, so each is `ART`. Everything else the sample uses (geometry, Raleway, colours, titlesec headings, tcolorbox pills, tabular entry rows, fontawesome icons) maps cleanly to lib ways and is reducible, but the artwork blockers decide the answer.

## Blockers
- `ART/class` full-bleed header banner: `\tikz[remember picture,overlay]` rectangle `minimum width=\paperwidth` at `current page.north`, name and tagline nodes (StylishCV/stylishcv.sty:217-225; called by `\simpleheader` sty:202-213; Examples/Main_withoutsidebar.tex:90,169; Examples/Letter_withoutsidebar.tex:3; Examples/Attachments.tex:6,15)
- `ART/class` full-bleed footer band at `current page.south` (StylishCV/stylishcv.sty:308-316; `\simplefooter` sty:293-304; Examples/Main_withoutsidebar.tex:155,263)
- `ART/class` cover-letter sub-header band, `below=3.5cm` of `current page.north` (StylishCV/stylishcv.sty:335-344; `\simplesubheader` sty:320-331; Examples/Letter_withoutsidebar.tex:5)
- `ART/class` photo frame: `path picture` clips the image into a circle (square variant is a diamond) with an accent-coloured border (StylishCV/stylishcv.sty:125,127; Examples/Main_withoutsidebar.tex:98; `\squarepic` is commented out at :99)
- `ART/class` `\hobbyicon` badge: filled circle, glyph node, caption node (StylishCV/stylishcv.sty:155-161; Examples/Main_withoutsidebar.tex:232-235)
- `ART/class` `\iconcross`: two crossed lines and four labelled nodes (StylishCV/stylishcv.sty:75-84; Examples/Main_withoutsidebar.tex:245-250)
- `ART/class` more TikZ widgets defined by the class, not called by this sample: `\event` (sty:179-184), `\infobubble` and `\infobubbleright` (sty:229-247), `\skillbubble` (sty:149-153), `\dashrule` and `\dotrule` (sty:167-169), `\bubblediagram` with the `smartdiagram` settings (sty:93-120,146); `tikz`, `tikz-3dplot`, `smartdiagram` and 16 TikZ libraries are loaded unconditionally (sty:10-12,18-33)
- `BESPOKE/class` the header macro's flow is coupled to the overlay: it prints a hidden `\section*{Start}` that the banner node covers, then `\subsection*{}`, `\vspace{4em}` and `\vspace{-0.7cm}` to start the columns (StylishCV/stylishcv.sty:204,208-209,224); `\roundpic` adds `\vspace{-2.5cm}` inside `figure[H]` (sty:125). Hand-tuned negative skips with no lib way; reducible only if the banner were, and it is not.

## Class setting
- Class: `class.article` options: none passed. The zip-local class `stylishcv` is `\LoadClass[]{article}` (StylishCV/stylishcv.cls:5); its own options `darkstylish`, `lightstylish`, `withoutsidebar` are consumed by `\DeclareOption` (cls:26,66,100) and set colours and a paracol background command; other options are forwarded to article (cls:152-153). The sample picks `withoutsidebar` (Examples/Main_withoutsidebar.tex:12).
- Class-native vocabulary used: this vocabulary belongs to a zip-local class, so it is not claimed as `front.class-native` or `cv.entries`; it is decomposed below. Commands used: `\simpleheader`, `\simplesubheader`, `\simplefooter`, `\opensectionresume`, `\closesection`, `\cvevent`, `\cvdegree`, `\cvcertificate`, `\cvtag`, `\pictofraction`, `\hobbyicon`, `\iconcross`, `\roundpic`, `\bg`, `\barrule`, `\iconsize`, `\switchpage`, `\resetcolor`, `\lorem`, column types `L{}` `R{}`, colours `accentcolor` `headercolour` `iconcolour`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | StylishCV/stylishcv.cls:5; Examples/Main_withoutsidebar.tex:12 | `class.article` | wrapper class loads article with no options |
| page geometry | Examples/Main_withoutsidebar.tex:21 | `page.geometry` | margin=1cm, a4paper |
| text face | Examples/Main_withoutsidebar.tex:15 | `font.helvet` | sans text-face package `raleway`, option `default` |
| encoding | StylishCV/stylishcv.sty:2; Examples/Main_withoutsidebar.tex:14 | `font.fontenc-t1` | fontenc T1; inputenc utf8 |
| icons | StylishCV/stylishcv.sty:4; Examples/Main_withoutsidebar.tex:19,157-162 | `font.icons` | `fontawesome` (`\faMapMarker`, `\faMobile`, `\faEnvelopeO`, `\faCircle`, `\faCoffee`...) |
| font sizes | StylishCV/stylishcv.cls:24,146; StylishCV/stylishcv.sty:270; Examples/Main_withoutsidebar.tex:213 | `font.size-commands` | `\huge`/`\Large` (`\iconsize` per option), `\footnotesize`, `\tiny`, `\Huge` |
| text marks | Examples/Main_withoutsidebar.tex:110,156 | `mark.kernel` | `\textbf`, `\scshape`, `\bfseries`, `\texttt` |
| colours | StylishCV/stylishcv.cls:6-23,100-147 | `color.xcolor` | `\definecolor` HTML/rgb (accentcolor FFBA33, headercolour 0.25 grey), `\colorlet`, tints `black!30`, `headercolour!50` |
| hyperlinks | StylishCV/stylishcv.sty:5; Examples/Main_withoutsidebar.tex:159,215 | `meta.hyperref` | colorlinks=false, pdfborder={0 0 0}; `\href` mailto and URLs |
| page style | StylishCV/stylishcv.sty:44,203 | `hf.pagestyle-kernel` | `\pagestyle{empty}`, `\thispagestyle{empty}` |
| paragraph and line-break parameters | StylishCV/stylishcv.sty:6,49,263 | `sp.lengths` | `\parindent`=0cm, `\emergencystretch`=2pt; `\hbadness5000` only silences warnings (no printed effect, no better way in the lib) |
| section headings | StylishCV/stylishcv.sty:52-57; Examples/Main_withoutsidebar.tex:183,192 | `head.titlesec` | `\titleformat{\section}{\scshape\Large\raggedright}{}{0em}{}[\titlerule]`, `\titlespacing{\section}{0pt}{12pt}{5pt}`; starred `\section*` |
| letter subject line | Examples/Letter_withoutsidebar.tex:51 | `head.kernel` | `\subsection*{...}` with no titlesec rule for subsections |
| alignment | StylishCV/stylishcv.sty:56; Examples/Main_withoutsidebar.tex:102,105; Examples/Attachments.tex:9 | `sp.ragged` | `flushright`, `center`, `flushleft`, `\centerline`, `\raggedright` |
| manual spacing | Examples/Main_withoutsidebar.tex:101,114,126,142 | `sp.manual-space` | `\vspace{-1.5cm}`, `\smallskip`, `\bigskip`, `\hfill`, `\hspace`, `\raisebox{-0.7\height}` (sty:191) |
| rules | StylishCV/stylishcv.sty:187-189 | `sp.rule` | `\rule[\baselineskip]{#1\textwidth}{#2}` in a colour group |
| section-header pills | Examples/Main_withoutsidebar.tex:36-65,106,135 | `box.tcolorbox` | `\newtcolorbox`: enhanced jigsaw, colback=white!50!headercolour or white!0!headercolour, coltext=white, boxrule=0pt, arc=2mm, halign=center, auto outer arc, boxsep=3pt, left/right/top/bottom=1pt, fontupper=\scshape; package option `most` (Main:20) |
| tag chips | StylishCV/stylishcv.sty:68-70; Examples/Main_withoutsidebar.tex:122 | `box.tcolorbox` | rounded frame black!50, `\scriptsize` text, as a `\tcbox` (the TikZ node's minimum height is matched by padding keys) |
| side-by-side sections | Examples/Main_withoutsidebar.tex:134-152,182-198,201-237 | `cols.minipage` | `minipage[t]` pairs of 0.48\textwidth with `\hfill`; four across at 0.3, 0.15, 0.15, 0.2 |
| text blocks | Examples/Main_withoutsidebar.tex:103; Examples/Letter_withoutsidebar.tex:46 | `box.minipage` | `[t]` 0.75\textwidth; centred 0.9\textwidth letter body |
| entry tables | StylishCV/stylishcv.sty:250-257,288-290; Examples/Main_withoutsidebar.tex:109,121,136,184 | `tbl.tabular` | `\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}` (also C, R); `r p{0.7\textwidth} r`; `r @{\hspace{0.5em}}l` |
| CV entry rows | StylishCV/stylishcv.sty:191-195; Examples/Main_withoutsidebar.tex:122-124,130-131,174-177 | `tbl.tabular` | three cells: date; bold title, small caps org, icon plus place, grey `\footnotesize` text; logo cell. Reducible, see Bespoke code |
| rating dots | StylishCV/stylishcv.sty:131-136; Examples/Main_withoutsidebar.tex:137-140,206 | `font.icons` | n copies of `\faCircle`, `\tiny`, accentcolor or black!30 (`color.xcolor`), `\hspace{-0.1cm}` (`sp.manual-space`) |
| skill bars and name tags | StylishCV/stylishcv.sty:142,187-189; Examples/Main_withoutsidebar.tex:194-196 | `box.fancybox` | `\colorbox{headercolour!30}{...}` plus the `sp.rule` bar |
| images | StylishCV/stylishcv.sty:35; Examples/Main_withoutsidebar.tex:224; Examples/Letter_withoutsidebar.tex:69 | `fig.graphicx` | `\includegraphics` width=2cm, height=1cm, keepaspectratio, page=1; `\scalebox{0.6}` (Main:245) |
| framed picture | Examples/Attachments.tex:10 | `box.fancybox` | `\fbox{\includegraphics[width=16cm,...]}` |
| float switch | StylishCV/stylishcv.sty:13,125 | `fig.float` | `figure[H]`, used only inside `\roundpic` and `\dashrule` (ART) |
| page breaks and includes | Examples/Main_withoutsidebar.tex:86,168,280; Examples/Attachments.tex:11; StylishCV/stylishcv.sty:348 | `pg.break` | `\newpage`; `\include` (its implied `\clearpage`; the emitter inlines the files) |
| sidebar columns (other samples) | StylishCV/stylishcv.sty:7,212,260-286; Examples/Main_lightstylish.tex:91,179,217 | `cols.paracol` | `paracol{2}`, `\columnratio{0.23}[0.75]`, `\columnsep` 1.5cm, `\backgroundcolor{c[0](4pt,4pt)(0.5\columnsep,4pt)}{sidebarcolor}` lines (cls:82-87), `\switchcolumn`, `\flushpage`; not opened by the withoutsidebar sample |
| header banner | StylishCV/stylishcv.sty:202-225 | `art.tikz` | blocker, ART (see Blockers) |
| footer band | StylishCV/stylishcv.sty:293-316 | `art.tikz` | blocker, ART |
| letter sub-header band | StylishCV/stylishcv.sty:320-344 | `art.tikz` | blocker, ART |
| photo crop frame | StylishCV/stylishcv.sty:125,127 | `art.tikz` | blocker, ART |
| hobby badge, icon cross | StylishCV/stylishcv.sty:75-84,155-161 | `art.tikz` | blocker, ART |
| loaded but unused | Examples/Main_withoutsidebar.tex:16,17 | `math.amsmath`, `code.verbatim` | no options; nothing in the body uses them |
| cover letter body | Examples/Letter_withoutsidebar.tex:45-73 | `box.minipage` | kernel text, `\today`, `\vspace{2\baselineskip}`; no letter class (`ltr.opening` not used) |
| not present | whole sample | none | no lists, theorems, floats with captions, bibliography, index, language setup, running heads or contents |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class options darkstylish/lightstylish/withoutsidebar | StylishCV/stylishcv.cls:26-147 | yes | colour definitions (`color.xcolor`) and `\paracolbackgroundoptions` = paracol `\backgroundcolor` lines (`cols.paracol`); an emitter writes the chosen set directly |
| `\usepackage{stylishcv}` in the class | StylishCV/stylishcv.cls:155 | yes | the .sty is a package list plus settings; each line above has a way |
| `\cvevent` `\cvdegree` `\cvcertificate` | StylishCV/stylishcv.sty:191-195 | yes | each is one tabular row; the `\ifthenelse{\equal{#3}{}}` tests only decide whether to print the dot and the icon, which the emitter knows from the data and can omit; `\raisebox`, `\includegraphics`, `\href` as in the map |
| `\cvtag` | StylishCV/stylishcv.sty:68-70 | yes (closest fit) | `\tcbox` with arc, frame colour black!50, `\scriptsize`; baseline and minimum height only approximated, no lib way draws the node itself |
| `\pictofraction`, `\icon` | StylishCV/stylishcv.sty:131-136 | yes | pgf `\foreach` only repeats a glyph; counts are data (5/0, 1/4, 4/1), so the emitter writes the copies. Latent defect: with 0 filled dots the loop `{0,...,-1}` runs twice (not used by the sample) |
| `\barrule`, `\bg`, `\bgupper`, `\colorsection`, `\cvkeyword`, `\keyword`, `\certification` | StylishCV/stylishcv.sty:141-143,60-62,187-189,353,355 | yes | `\rule`, `\colorbox`, `\textcolor`, `\bfseries`, `\MakeUppercase`, `\faHashtag` and `\faCertificate`: `sp.rule`, `box.fancybox`, `color.xcolor`, `mark.kernel`, `font.icons` |
| `\opensectionresume` / `\closesection` | StylishCV/stylishcv.sty:250-257 | yes | `\section*{#1}\begin{tabular}{r p{#2\textwidth} r}` and `\end{tabular}`; the emitter writes the pair as one wrapper |
| `\newcolumntype` L, C, R | StylishCV/stylishcv.sty:288-290 | yes | array column definitions (`tbl.tabular`) |
| `\newtcolorbox` shadedcvbox, darkshadedcvbox | Examples/Main_withoutsidebar.tex:36-65 | yes | `box.tcolorbox` keys as in the map |
| `\opencolumnpage`, `\closecolumnpage`, `\switchtomaincolumn` | StylishCV/stylishcv.sty:260-286 | yes | paracol environment with background commands; the `\phantom{turn the page}` lines (sty:282-284) are blank spacers (`sp.manual-space`); not used by this sample |
| `\switchpage`, `\resetcolor`, `\dottedsidebarline`, `\lorem` | StylishCV/stylishcv.sty:348,350,171,122 | yes | `\color` plus `\newpage`, a line of bullet text, filler text (content) |
| `\newlength{\leftcolwidth}` `{\rightcolwidth}` | Examples/Main_withoutsidebar.tex:69-72 | yes | never used by the body; no printed effect |
| `\simpleheader` and `\simpleformatedheader` | StylishCV/stylishcv.sty:202-225 | no | TikZ overlay at `current page.north`, `ART/class`; plus the `BESPOKE/class` flow hack above |
| `\simplefooter` and `\simpleformatedfooter` | StylishCV/stylishcv.sty:293-316 | no | TikZ overlay at `current page.south`, `ART/class` |
| `\simplesubheader` and `\simpleformatedsubheader` | StylishCV/stylishcv.sty:320-344 | no | TikZ overlay, `ART/class` |
| `\roundpic`, `\squarepic` | StylishCV/stylishcv.sty:125,127 | no | TikZ `path picture` clip inside a float with negative skips, `ART/class` |
| `\hobbyicon`, `\iconcross`, `\event`, `\infobubble`, `\skillbubble`, `\dashrule`, `\dotrule`, `\bubblediagram` | StylishCV/stylishcv.sty:155-161,75-84,179-184,229-247,149-153,167-169,146 | no | drawn TikZ widgets, `ART/class`; `\skillbubble` builds its radius by pasting `0.#2` |

## Content-opaque
- Photos and badges via `\includegraphics`: Examples/Main_withoutsidebar.tex:122,224 and Examples/Attachments.tex:10,17 (images ship in Examples/resources/, nothing missing).
- Placeholder text `<Company Name>`, `\lorem` filler and empty `\href{}{...}` targets: Examples/Letter_withoutsidebar.tex:11-16,58-64 (content).

## Lib changes
- New ways proposed: none. Considered for the banner and bands: `bg.tikzpagenodes`, `bg.eso-pic` and tcolorbox bands; rejected because the lib marks an overlay that draws the template's identity as ART, and a full-bleed page-edge band cannot be written with tcolorbox keys alone. Considered for the entry macros: `cv.entries`; not used because it names published CV classes and `stylishcv` is zip-local.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
