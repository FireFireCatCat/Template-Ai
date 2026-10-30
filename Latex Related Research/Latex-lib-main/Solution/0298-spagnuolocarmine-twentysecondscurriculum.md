no

# 0298-spagnuolocarmine-twentysecondscurriculum: Twenty Seconds Curriculum Vitae (class `twentysecondcv`)

- Unverified: read from the source, not compiled.
- Source: Source/0298-spagnuolocarmine-twentysecondscurriculum/ (origin: https://codeload.github.com/spagnuolocarmine/TwentySecondsCurriculumVitae-LaTex/zip/refs/heads/master; licence: MIT, LICENSE and twentysecondcv.cls:6)
- Kind: cv
- Lib: v4
- Engine: pdfLaTeX-compatible (ClearSans, fontawesome, marvosym, tikz, textpos: no fontspec, no Lua)
- Look carried by: zip-local (the whole look is in twentysecondcv.cls; each sample preamble is one `\documentclass` line, Twenty-Seconds-Icons_cv.tex:13)
- Class origin: zip-local
- Main file: Twenty-Seconds-Icons_cv.tex (other samples: Twenty-Seconds_cv.tex)
- Read: main yes, zip-local classes and styles all

## Verdict
No. The look is a zip-local class on top of `article`, and four pieces of it are template-defining TikZ drawings or hand-rolled macros that no lib way expresses: the section heading macro, which boxes the first three characters of the title and alternates the box colour with a private counter, the skill-bar chart, the full-height sidebar band, and the circle-cropped photo. The fonts, colours, geometry, tabular entry lists and the `textpos` placement all map to lib ways, and the Makefile is only a `pdflatex` loop (no external tool), so the blockers are `ART` and `BESPOKE`, not `EXTERNAL`.

## Blockers
- `BESPOKE/class` `\section` is redefined to take the first three tokens of the title into a `\round` box (`\def\@sectioncolor#1#2#3`, `\round{#1#2#3}`), print the rest of the title as plain text, and `\stepcounter{colorCounter}`; box colour is `mainblue` or `maingray` by `\ifodd\value{colorCounter}`. `\sectionicon` does the same. A token-slicing macro with a counter that drives what is printed (twentysecondcv.cls:238-261, 263-272)
- `ART/class` skill bar chart: `\foreach` over `name/value` pairs draws a grey bar, a blue bar of width `1.2*value`, name node, and 11 tick marks alternating by `\ifodd` (twentysecondcv.cls:138-159, printed at 222-224)
- `ART/class` full-height sidebar band: TikZ overlay node `fill=asidecolor`, 9.9cm wide, `\paperheight+1cm` tall, placed at fixed coordinates relative to the text position; a CV sidebar shape (twentysecondcv.cls:180-182)
- `ART/class` profile photo cropped to a circle by TikZ `\clip ... circle` with a computed scale (twentysecondcv.cls:96-101, 189-192)
- `ART/class` `\icon` (filled circle node) and `\round` (filled rounded-rectangle node), the contact-row icons and the section-title chips (twentysecondcv.cls:126-135, used 206-214 and 242)

## Class setting
- Class: zip-local `twentysecondcv` (ctan.org/pkg/twentysecondcv returned 404; GitHub author repo, not a publisher kit), which does `\LoadClass{article}` with no options (twentysecondcv.cls:17) and passes unknown options to `article` (twentysecondcv.cls:45-47). Base way `class.article`. Class options: `icon` (loads `fontawesome`, twentysecondcv.cls:40-43, 49), `print` (swaps colours to grey, twentysecondcv.cls:44, 71-79); the main sample uses `[icon]` (Twenty-Seconds-Icons_cv.tex:13), the other sample `[]` (Twenty-Seconds_cv.tex:12).
- Class-native vocabulary used: `\profilepic` `\cvname` `\cvjobtitle` `\cvdate` `\cvaddress` `\cvnumberphone` `\cvmail` `\cvsite` `\aboutme` `\skills` `\skillstext` `\makeprofile` (Twenty-Seconds-Icons_cv.tex:20-44); `\section`, `\sectionicon`; environments `twentyicon` with `\twentyitemicon`, `twentyshort` with `\twentyitemshort`, `twentyshorticon` with `\twentyitemshorticon`, `twenty` with `\twentyitem` (Twenty-Seconds-Icons_cv.tex:66-145). README.md names the about-me command `\about`; the class defines `\aboutme` (twentysecondcv.cls:110).

## Component map
Paths: `cls` = twentysecondcv.cls, `main` = Twenty-Seconds-Icons_cv.tex. Row text in the "Way" column names the lib way; "BESPOKE" and "ART" rows are the blockers above.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main:13; cls:16-17 | `class.article` | `\LoadClass{article}` under a zip-local wrapper; no options forwarded in the samples |
| page geometry | cls:350 | `page.geometry` | left=7.3cm, top=0.1cm, right=0.5cm, bottom=0.2cm, nohead, nofoot (paper size stays the article default) |
| header/footer | cls:282 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| encoding | cls:24 | `font.fontenc-t1` | T1 |
| text face | cls:23 | `font.helvet` | package `ClearSans`, option `sfdefault` (a sans text-face package is the parameter); whether `sfdefault` also sets the document family is in the package source, not read; not set anywhere in the zip (no `\familydefault` in cls) |
| icon glyphs, contact rows | cls:33, 206-214 | `font.icons` | `marvosym` `\Info` `\Letter` `\Telefon` `\Mundus`, and `@` |
| icon glyphs, entry rows | cls:49, 310, 341; main:68, 74, 80, 86, 97, 119, 123 | `font.icons` | `fontawesome` loaded when class option `icon` is on; `\faicon{graduation-cap}`, `\faicon{battery-3}`, `\faBook` |
| colours | cls:56-69, 71-87 | `color.xcolor` | `\definecolor`: sidecolor E7E7E7, mainblue 0E5484, maingray B9B9B9, cerulean 007BA7, gray 4D4D4D and others; `\colorlet` headercolor, textcolor, asidecolor, fillheader, header; `print` branch maps accent colours to gray |
| paragraph spacing | cls:34 | `sp.parskip-pkg` | no options |
| alignment | cls:28, 110, 165, 185, 198 | `sp.ragged` | `ragged2e` `\justifying` (about-me), `flushleft`, `flushright` |
| type sizes | cls:103, 195, 199, 206, 226, 256, 266, 277, 298 | `font.size-commands` | `\huge` `\Huge` `\Large` `\LARGE` `\large` `\scriptsize` `\footnotesize` |
| table/placement lengths | cls:92-93, 201, 287, 302, 321, 333 | `sp.lengths` | `\TPHorizModule`=1cm, `\TPVertModule`=1cm, `\arraystretch`=1.6, `\tabcolsep`=0pt |
| manual spacing | cls:103, 232, 260, 275, 279, 295-299 | `sp.manual-space` | `\hspace{5pt}`, `\hspace{3pt}`, `\vspace{\parskip}`, `\vspace{.5\parskip}`, `\hfill` |
| title rule in sidebar | cls:103 | `sp.rule` | `\rule[0.15\baselineskip]{#2}{1pt}`, widths 3.2cm and 5cm (cls:218, 222) |
| sidebar placement | cls:27, 184-231 | `pg.textpos` | `[absolute,overlay]`, `textblock{6}(0.5, 0.2)` |
| sidebar band | cls:180-182 | `art.tikz` (ART) | node fill=asidecolor, minimum width 9.90cm, height `\paperheight+1cm`, at (-5cm,0.5cm) |
| profile photo | cls:96-101, 189-192; main:20 | `fig.graphicx` and `art.tikz` (ART) | `\includegraphics[width=\imagewidth]{alice.jpeg}` inside a TikZ circle clip; `\imagewidth`=5cm |
| name and job title | cls:195-200 | `font.size-commands`, `color.xcolor`, `sp.ragged` | `\Huge` mainblue; `\Large` black!80 in `flushright` |
| contact table | cls:204-215 | `tbl.tabular`, `meta.hyperref`, `art.tikz` (ART, `\icon`) | `{c @{\hskip 0.2cm} p{5cm}}`; empty fields skipped by `\ifthenelse` (bespoke); `\href` on site and mail |
| about me | cls:110, 218-219; main:29-32 | `sp.ragged` | `\justifying`, heading "About me" via `\profilesection` |
| skill bars | cls:138-159; main:37 | `art.tikz` (ART) | pairs `{name/value}`, value 0 to 6, bar width `1.2*value` cm |
| skill text list | cls:163-175; main:42 | reducible, see Bespoke code | prints `name $\star$ value` per pair inside `flushleft` |
| section headings | cls:238-261; main:57, 60, 116, 128, 147 | none: BESPOKE (nearest `head.kernel`) | first three tokens of the title in a `\round` box, alternating mainblue and maingray, rest of the title `\LARGE` in headercolor; unnumbered, no toc entry |
| section heading with icon | cls:263-272; main:97 | none: BESPOKE (nearest `head.kernel`), `font.icons` | `\sectionicon{\faBook}{publications}` |
| subsection | cls:274-280 | `head.kernel` | `\renewcommand{\subsection}`: `\large`, headercolor, `\vspace{.5\parskip}` before and `.25\parskip` after (not used in either sample) |
| entry lists | cls:288-345; main:66-145 | `tbl.tabular`, `box.minipage`, `sp.manual-space`, `font.size-commands` | `tabular*{\textwidth}{@{\extracolsep{\fill}}ll}`; second cell `\parbox[t]{11.5cm}` (11.2cm in `twentyicon`) holding title, `\hfill`, place in `\footnotesize`, description |
| inline marks | cls:206; main:72, 70 | `mark.kernel` | `\textsc`, `\emph`, `\normalfont` |
| bold redefinition | cls:293, 308, 327, 339 | `mark.kernel`, `color.xcolor` | `\renewcommand{\bfseries}{\color{headercolor}}`: item titles print in headercolor; the author's shipped Twenty-Seconds_cv_icons.jpg shows them gray, not bold (read as a picture, not a compile of mine) |
| links | cls:351 | `meta.hyperref` | `\RequirePackage{hyperref}` last, no options |

Not defined or used by the zip: sectioning numbers, contents lists, headers and footers beyond `empty`, footnotes, lists, quotes, maths, theorems, floats, captions, code, bibliography, index.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| option handling `icon`, `print`, `DeclareOption*` | cls:40-49 | yes | one boolean: load `fontawesome` and use the `print` colour set; unknown options go to `class.article` |
| colour set and `print` switch | cls:56-87 | yes | `color.xcolor` `\definecolor` and `\colorlet`; the `\ifdefined` picks one of two colour sets |
| profile field setters and defaults (`\cvname` ... `\givencvjobtitle`) | cls:105-123 | yes | string values printed in `\makeprofile`; the emitter writes the strings inline, skipping empty ones |
| `\profilesection` | cls:103 | yes | `\huge`, `black!80`, `\rule[0.15\baselineskip]{w}{1pt}` (`font.size-commands`, `color.xcolor`, `sp.rule`) |
| `\icon` | cls:126-128 | no (ART) | TikZ circle node, fill and draw mainblue, text white, `inner sep=1pt`; a filled circle around a glyph has no declarative lib way (an `\tcbox` with a large `arc` is a circle only for a square content) |
| `\round` | cls:131-135 | no (ART) | TikZ rounded rectangle node, `inner sep=1.6pt`, `minimum size=5.5mm`, `text height=3.6mm`; close to a `\tcbox[arc=..]` of `box.tcolorbox`, but sized by node dimensions and used inside the section macro below |
| `\skills` | cls:138-159 | no (ART) | pgffor loop with `count`, `\ifodd` tick lengths, bar width from the value |
| `\skillstext` | cls:163-175 | yes | pairs printed as `name $\star$ value` in `flushleft`; the emitter writes the loop out |
| `\makeprofile` | cls:177-233 | no (ART inside) | `textblock` plus tabular plus text pieces reduce (`pg.textpos`, `tbl.tabular`, `sp.ragged`), but it also draws the band, the clipped photo and the icon nodes |
| picture size lengths `\imsize`, `\imagewidth`, `\imagescale` | cls:96-101 | no (ART) | `\pgfmathsetlength` scale for the TikZ clip; `\imsize` is defined twice and never used |
| `colorCounter` and `\@sectioncolor` | cls:238-251 | no | counter parity chooses the box colour; `#1#2#3` slices the first three tokens of the title |
| `\section` redefinition | cls:253-261 | no | uses `\@sectioncolor`; titles under three tokens or with braces change what is boxed |
| `\sectionicon` | cls:263-272 | no | same macro with an icon in front |
| `\subsection` redefinition | cls:274-280 | yes | `head.kernel`: `\large`, headercolor, two `\vspace` lengths |
| `twenty` and `\twentyitem` | cls:288-301 | yes | `tbl.tabular` `tabular*` with `\tabcolsep`=0pt; cell 1 `\hspace{5pt}#1`; cell 2 `\parbox[t]{11.5cm}` with title in headercolor, `\hfill`, `\footnotesize` place, `\\`, description, `\vspace{\parsep}` |
| `twentyicon` and `\twentyitemicon` | cls:303-316 | yes | same with `\faicon{#1}` and `\hspace{3pt}`, `\hspace{2pt}`, 11.2cm box |
| `twentyshort` and `\twentyitemshort` | cls:322-332 | yes | two columns, title only, 11.5cm box |
| `twentyshorticon` and `\twentyitemshorticon` | cls:334-345 | yes | same with icon and `\hspace{3pt}` |
| `\renewcommand{\bfseries}{\color{headercolor}}` (four times) | cls:293, 308, 327, 339 | yes, with a caveat | write `\textcolor{headercolor}{title}` at each use; the global redefinition also changes every `\textbf` in the body, which the emitter would have to repeat |
| `\TPHorizModule`, `\TPVertModule` | cls:92-93 | yes | `sp.lengths` set to 1cm, units of `pg.textpos` |

Considered and not used: `cv.entries` (moderncv family; `twentysecondcv` is not published, so its commands are not that way), `bg.eso-pic` for the band (would need a hand-built rectangle; the sidebar shape is the rubric's own example of ART, and the verdict does not rest on this item alone), `box.tcolorbox` `\tcbox` for `\round`.

## Content-opaque
none (alice.jpeg is a shipped profile photograph asset used at Twenty-Seconds-Icons_cv.tex:20; its circular crop is the template's, listed under Blockers). The Makefile only loops `pdflatex` over `*.tex` (Makefile:9) and generates no source, so it is not `EXTERNAL`.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
