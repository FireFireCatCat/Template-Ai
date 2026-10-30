no

# 0342-arthurbernard-arthur-cv-latex: Arthur-CV-LaTeX (arthur-cv CV class and arthur-cover-letter class)

- Unverified: read from the source, not compiled.
- Source: Source/0342-arthurbernard-arthur-cv-latex/ (origin: https://codeload.github.com/ArthurBernard/Arthur-CV-LaTeX/zip/refs/heads/master; licence: MIT, LICENSE.txt:1)
- Kind: cv
- Lib: v3
- Engine: needs XeLaTeX or LuaLaTeX (class loads `fontspec` unconditionally, arthur-cv.cls:14; README.md:211 says "LuaLaTeX (prefered) or XeLaTex")
- Look carried by: zip-local (the whole look, header, sidebar, headings, entry rows, is in arthur-cv.cls; the sample preamble only sets language, optional colours and profile fields)
- Class origin: zip-local (a personal GitHub repo; ctan.org/pkg/arthur-cv is a 404; not a publisher kit; it is `\LoadClass{article}` plus bespoke code, arthur-cv.cls:7)
- Main file: examples/example_cv.tex (other samples: examples/Arthur_Bernard_CV_En.tex, examples/Arthur_Bernard_CV_Fr.tex, examples/Two_Pages_CV.tex, examples/example_cover_letter.tex)
- Read: main yes, zip-local classes and styles all (arthur-cv.cls and arthur-cover-letter.cls in full; the other four samples read, En/Fr only by diff for the parts that repeat)

## Verdict
No. Most of the CV class reduces cleanly to lib ways (textpos blocks, two minipages, a tcolorbox heading, an enumitem list, tabular/parbox entry rows, fontawesome icons, ClearSans). What stops a `yes` is the template's own artwork: a full-height tinted sidebar band and an offset picture frame, both drawn with TikZ in the class (`ART/class`), and two macros that eat the first tokens of their argument to change colour or size (`BESPOKE/class`). A tcolorbox-in-textpos stand-in for the band is conceivable, but the band is a `remember picture,overlay` node anchored to the text-flow origin and runs past the page foot, so its placement cannot be shown equal without compiling; it is counted as ART.

## Blockers
- `ART/class` left sidebar colour band: tikz overlay node `fill=leftcolorband`, 8cm x 27cm, at (0,-3.2cm) (arthur-cv.cls:82-84); repeated per page as 8cm x 30.5cm at (0,0.5cm) (arthur-cv.cls:263-265)
- `ART/class` profile-picture frame: hand-drawn tikz polygon, 0.5mm `boxcolor` line, 3.15cm square, offset 0.05cm from the image node (arthur-cv.cls:174-177; same in arthur-cover-letter.cls:156-159)
- `BESPOKE/class` section heading colour: `\def\@sectioncolor#1#2#3` takes the first three tokens of the heading title as arguments and colours them `maincolor`, the rest stays `secondcolor` (arthur-cv.cls:220-224, called at :231)
- `BESPOKE/class` cover-letter `\capit`: `\def\@capsize#1#2{\normalsize #1\small #2}` consumes two tokens, first at `\normalsize`, the rest left at `\small` with no group (arthur-cover-letter.cls:217, 223); secondary sample only

## Class setting
- Class: `class.article` (base, through `\LoadClass{article}` in the zip-local `arthur-cv`, arthur-cv.cls:7) options: `a4paper` (example_cv.tex:1; a global option, the zip-local class declares no options and does not call `\ProcessOptions`)
- Class-native vocabulary used: `\title`, `\author` are set (example_cv.tex:2-3) but `\maketitle` is never called; the zip-local, unpublished layer used by the sample is `\makeprofile`, `\cvname` `\cvjobtitle` `\cvmail` `\cvlinkedin` `\cvgithub` `\cvnumberphone` `\cvaddress` `\cvsite` `\cvyearsold` `\profilepic` (example_cv.tex:24-33), `\sectionleft`, `\subsectionleft` (example_cv.tex:47-63), a redefined `\section`, `rightenv`, `\subsectionright` (example_cv.tex:73-97), `textblock` (from textpos, example_cv.tex:39) and `\newcvpage` (Two_Pages_CV.tex:132)

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | arthur-cv.cls:7; example_cv.tex:1 | `class.article` | base class of the zip-local `arthur-cv`; `a4paper` |
| paper size | example_cv.tex:1 | `page.class-options` | `a4paper` |
| page geometry (CV) | arthur-cv.cls:273 | `page.geometry` | left=0cm, top=0cm, right=0cm, bottom=0cm, nohead, nofoot (the page is laid out by textpos) |
| page geometry (letter) | arthur-cover-letter.cls:243 | `page.geometry` | left=2.5cm, top=3.5cm, right=2.5cm, bottom=1cm, head=3.5cm, foot=2.5cm |
| absolute positioning | arthur-cv.cls:20, 67-68, 90, 170; example_cv.tex:39; Two_Pages_CV.tex:134 | `pg.textpos` | options absolute,overlay; `\TPHorizModule`=1cm, `\TPVertModule`=1cm; header block {20.5}(0.25,0.25), picture block {3.5}(17.25,0.25), body block {20.5}(0.25,3.5) (second page (0.25,0.0)) |
| two-column body | example_cv.tex:41, 67 | `cols.minipage` | `minipage[t]` 0.37\textwidth and 0.61\textwidth joined by `\hfill` |
| header columns | arthur-cv.cls:92, 142 | `box.minipage` | `minipage[t]` 0.38\textwidth (contacts), 0.43\textwidth (name, title, address, age) |
| text font | arthur-cv.cls:14; example_cv.tex:6 | `font.fontspec` | `fontspec` option quiet (class); loaded again in the sample |
| sans face | arthur-cv.cls:15 | `font.helvet` | package `ClearSans`, option sfdefault (package source not read) |
| icons | arthur-cv.cls:16, 102, 110, 118, 126, 134 | `font.icons` | `fontawesome` (v4 names): `\faMobile` `\faGlobe` `\faEnvelopeO` `\faLinkedin` `\faGithub`, sized `\LARGE`/`\Large`, three tinted with `\textcolor{yt|test|linkedin}` |
| microtype | example_cv.tex:7 | `sp.microtype` | defaults |
| paragraph spacing | arthur-cv.cls:18 | `sp.parskip-pkg` | defaults |
| language | example_cv.tex:5; Arthur_Bernard_CV_Fr.tex:10 | `lang.babel` | english (sample), french (Fr sample) |
| colours | arthur-cv.cls:34-43 | `color.xcolor` | `\definecolor` HTML: yt c71610, test 0077be, linkedin 0085AE, leftcolorband E7E7E7, boxcolor 0E5484, maincolor 1a4c70, secondcolor 4d4d4d, thirdcolor 0E5484; the sample may override (commented, example_cv.tex:13-17) |
| links | arthur-cv.cls:19, 112, 120, 128, 136 | `meta.hyperref` | option hidelinks; `\href{http://..}`, `\href{mailto:..}`, `\href{https://www.linkedin.com..}`, `\href{https://www.github.com/..}` |
| title block | example_cv.tex:2-3, 36 | `front.maketitle` | `\title{}` `\author{}` declared, `\maketitle` not used; header printed by zip-local `\makeprofile` (see Bespoke) |
| header contact table | arthur-cv.cls:96-139 | `tbl.tabular` | `\arraystretch`=1.4; `tabular{p{1.1cm} @{\hskip 0.3cm}p{6.2cm}}`; icon cell is a math `array{l}` with `\hspace{2.5mm..4mm}` and `\textnormal{}` |
| name and job title | arthur-cv.cls:150-160 | `font.size-commands`, `color.xcolor`, `sp.manual-space` | name `\Huge\color{maincolor}`; title `\Large\color{secondcolor}\textbf`; `\vspace{3mm}` `{5mm}`; address and age lines |
| profile image | arthur-cv.cls:75, 175 | `fig.graphicx` | `\includegraphics[width=\imagewidth]` with `\imagewidth`=3cm; sits inside the tikz overlay node (ART below) |
| sidebar band and picture frame | arthur-cv.cls:82-84, 174-177, 263-265 | `art.tikz` | **ART** (see Blockers) |
| left-bar section heading | arthur-cv.cls:188-189, 192-200 | `box.tcolorbox` | `\tcbuselibrary{most}`, `\tcbset{enhanced}`; colframe=boxcolor, colback=boxcolor!10!white, shadow={0.7mm}{-1mm}{0mm}{black!50!white}, sharpish corners, boxrule=0.8mm; contents `\centering\LARGE\textbf`; `\par\vspace{3.5mm}` above, `{2mm}` below |
| left-bar item | arthur-cv.cls:203-213 | `list.enumitem` | `itemize[label=\textbullet, font=\Large, leftmargin=7mm, parsep=0mm, itemsep=0mm, partopsep=0mm, topsep=0mm]`, `\item \large#1 #2`, then `\vspace{2mm}` |
| item paragraph shape | arthur-cv.cls:206, 239 | `sp.hyphenat` | kernel `sloppypar` wrapper |
| right-column section heading | arthur-cv.cls:227-234 | `head.kernel` | `\renewcommand{\section}[1]`: no number, no counter, no toc entry; `\par\vspace{2.8mm}`, `\textbf{\huge\color{secondcolor}..}`, `\vspace{1.5mm}`; three-token colour is BESPOKE (see Blockers) |
| entry list | arthur-cv.cls:237-242, 245-252 | `tbl.tabular`, `box.minipage` | `\tabcolsep`=2pt; `tabular{@{\extracolsep{\fill}}p{1.6cm} l}`; per row: date in `\footnotesize`, then `\parbox[t]{10.5cm}` holding level, title `\textbf{\large\color{thirdcolor}}`, `\hfill`, firm in `\textit`, location in `\footnotesize`, description in `\normalsize`; blank-argument tests are resolved by the emitter |
| in-line emphasis | example_cv.tex:76; Two_Pages_CV.tex:88 | `mark.kernel` | `\textbf` inside the descriptions (content) |
| new CV page | arthur-cv.cls:258-267 | `pg.break` | `\newpage`, then the band again (ART) |
| loaded, never called | arthur-cv.cls:17, 21, 24 | `sp.ragged`, `head.titlesec`, `tbl.multirow` | `ragged2e`, `titlesec`, `multirow` loaded with no option and no call in the class or any sample (grep found no `\titleformat`, `\multirow`, `\justifying`) |
| page numbers | arthur-cover-letter.cls:244 | `pgnum.pagenumbering` | `\pagenumbering{gobble}` (letter class only; the CV class sets no page style) |
| letter address blocks | arthur-cover-letter.cls:173-211 | `pg.textpos` | `textblock{4}` at (14.5,5) address, (2.5,6) recipient, (14.5,4.5) location; French variants at swapped positions |
| letter body spacing | arthur-cover-letter.cls:219-222 | `sp.manual-space` | `\subject` `\vspace{0.5cm}`, `\opening` `\vspace{0.3cm}`, `\closing` `\vspace{0.3cm}` before, `\signing` `\vspace{0.5cm}\hspace{12cm}` |
| letter rules | arthur-cover-letter.cls:227-237 | `sp.rule` | two horizontal lines 16cm long, 0.5mm, colour secondcolor, drawn as `\draw` in a tikzpicture; the same effect as `\rule{16cm}{0.5mm}` under `\color{secondcolor}`; `\vspace{3.5cm}` and `{0.5cm}` around the text |
| letter link | arthur-cover-letter.cls:224 | `meta.hyperref`, `mark.kernel`, `color.xcolor` | `\href{#1}{\color{colhyperlink}{\textit{#2}}}` |
| letter filler text | examples/example_cover_letter.tex:9, 54 | `draft.todo` | `lipsum` `\lipsum[1-3]` (filler content) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\cvname` `\cvmail` `\cvlinkedin` `\cvgithub` `\cvnumberphone` `\cvaddress` `\cvsite` `\cvjobtitle` `\cvyearsold` `\profilepic` (self-redefining `\newcommand{\x}[1]{\renewcommand{\x}{#1}}`) | arthur-cv.cls:51-60 | yes | data fields; the emitter writes the values straight into the header, no setter needed |
| `\makeprofile` (header: contact table, name block, picture slot) | arthur-cv.cls:79-182 | yes except the tikz parts | `pg.textpos` + `box.minipage` + `tbl.tabular` + `font.icons` + `meta.hyperref`; the `\ifthenelse{\equal{..}{}}` tests decide only whether a row is printed, so the emitter resolves them; the band (:82-84) and the frame (:174-177) are ART |
| `\imsize`, `\imagewidth`, `\imagescale`, `\pgfmathsetlength` | arthur-cv.cls:71-76 | yes | one 3cm length; `\imsize` and `\imagescale` are never used |
| `\sectionleft` | arthur-cv.cls:192-200 | yes | `box.tcolorbox` with the parameters in the table |
| `\subsectionleft` | arthur-cv.cls:203-213 | yes | `list.enumitem` itemize in `sloppypar`, as in the table |
| `\section` redefinition | arthur-cv.cls:227-234 | partly | reducible to `head.kernel` as in the table, except the three-token colour |
| `\@sectioncolor#1#2#3` | arthur-cv.cls:220-224 | no | the colour split depends on the tokenisation of the heading text (first three tokens), not on a declared style; an emitter would have to cut the title string itself; `BESPOKE/class` |
| `rightenv`, `\subsectionright` (`\newcommandx` six arguments, three optional, `\ifblank` tests) | arthur-cv.cls:238-252 | yes | tabular + `\parbox` as in the table; the optional-argument and blank tests vanish because the emitter knows which fields exist (`xargs` is published; `\ifblank` is not required explicitly by the class) |
| `\newcvpage` | arthur-cv.cls:258-267 | partly | `\newpage` (`pg.break`) reduces; the second band is ART |
| left sidebar band | arthur-cv.cls:82-84, 263-265 | no | `ART/class`; a tcolorbox in a textpos block is a possible stand-in, not shown equal |
| picture frame | arthur-cv.cls:174-177; arthur-cover-letter.cls:156-159 | no | `ART/class`; offset 0.05cm polygon, no declarative way |
| `\address` `\recipient` `\location` and French variants | arthur-cover-letter.cls:173-211 | yes | `pg.textpos` blocks at fixed coordinates (`\center` inside) |
| `\subject` `\opening` `\closing` `\signing` | arthur-cover-letter.cls:219-222 | yes | text plus `sp.manual-space` (they are not the kernel letter commands: the class is article-based) |
| `\hlink` | arthur-cover-letter.cls:224 | yes | `\href` + `\color` + `\textit` |
| `coverletter` environment | arthur-cover-letter.cls:227-237 | yes | `sp.rule` rules and `sp.manual-space` skips around the body |
| `\capit` / `\@capsize` | arthur-cover-letter.cls:217, 223 | no | two-token capture with a size switch left open; `BESPOKE/class` (secondary sample) |

## Content-opaque
none (the profile image slot is filled from shipped files, pictures/qrcode_github.jpeg and pictures/photo_arthur_bernard.jpeg, used at examples/Arthur_Bernard_CV_En.tex:27 and examples/Arthur_Bernard_CV_Fr.tex:25; shipped assets, no lib change)

## Lib changes
- New ways proposed: none.
- Considered and not used for the band: `bg.background`, `bg.eso-pic`, `bg.tikzpagenodes` (their parameter is a tikz or picture drawing, so the band stays ART); `cv.entries` (names the moderncv/altacv/awesome-cv family of published classes; `arthur-cv` is zip-local, so its entry commands are reduced to `tbl.tabular` and `box.minipage` instead).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
