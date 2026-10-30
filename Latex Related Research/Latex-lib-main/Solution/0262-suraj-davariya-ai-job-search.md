no

# 0262-suraj-davariya-ai-job-search: CareerForge CV (cfcv) and cover letter (cfcl) templates

- Unverified: read from the source, not compiled.
- Source: Source/0262-suraj-davariya-ai-job-search/ (origin: https://codeload.github.com/suraj-davariya/ai-job-search/zip/refs/heads/main; licence: MIT, per manifest and cv/cfcv.cls:4, cover_letters/cfcl.cls:4)
- Kind: cv (the zip is a whole job-application repo; only `cv/` and `cover_letters/` hold LaTeX; the Next.js dashboard, docs site, i18n, scripts and Markdown docs are not templates and were not analysed as such)
- Lib: v3
- Engine: pdfLaTeX-compatible for the main sample by reading (cfcv.cls needs no fontspec; the authors compile it with lualatex, cv/cfcv.cls:5 and cv/main_example_two_col.tex:4); the sibling cover-letter class needs XeLaTeX (fontspec, cover_letters/cfcl.cls:15)
- Look carried by: mixed (zip-local class `cv/cfcv.cls` carries colours, section rule, list style, entry macros; the sample's own preamble carries the paracol layout, the page divider, `\sidesection`, `\jobentry` and `\skillbar`)
- Class origin: zip-local
- Main file: cv/main_example_two_col.tex (other samples: cv/main_example.tex, cover_letters/main_example.tex)
- Read: main yes, zip-local classes and styles all (cv/cfcv.cls 170 lines, cover_letters/cfcl.cls 114 lines, both samples in full)

## Verdict
No. Almost everything is a `\LoadClass{article}` class plus `\newcommand` compositions of published packages, which reduce to lib ways. The main sample, however, draws three pieces of the template's own identity with TikZ: the skill progress bars, the full-height column divider laid over every page, and (in the class) the filled rounded skill tag. They are hand-built drawings, not declarative parameters of a lib way, so they are `ART`. A rule-based re-expression is conceivable (see Bespoke code), but it would be a new hand-made construction, nothing was compiled to show equal output, and a wrong yes costs more.

## Blockers
- `ART/body` skill progress bar `\skillbar`: two `\fill` rectangles in a `tikzpicture`, fraction of `\linewidth` as argument, used eight times (cv/main_example_two_col.tex:63-68, 256-267)
- `ART/preamble` column divider: `\AddToShipoutPictureBG` with a `tikzpicture[remember picture,overlay]` line from `current page.north west` to `south west`, shifted `0.350\paperwidth`, `accent!22`, 0.4pt (cv/main_example_two_col.tex:44-50)
- `ART/class` skill tag `\cvtag`: `\tikz[baseline]\node[draw=accent,rounded corners,fill=accent,inner xsep,inner ysep,text height,text depth]` (cv/cfcv.cls:127-130); not called by any sample, but the class defines it (and `\splitoncomma`, cv/cfcv.cls:132-133, which feeds it)

## Class setting
- Class: `class.article` via zip-local `cfcv` (cv/cfcv.cls:16-17) and `cfcl` (cover_letters/cfcl.cls:11-12). Options: `10pt, a4paper` given at cv/main_example_two_col.tex:27. cfcv.cls has no `\DeclareOption` or `\ProcessOptions` and loads article with no options (cv/cfcv.cls:17), so whether article receives them is not established from the source. cfcl passes them itself: `\LoadClass[10pt, a4paper]{article}` (cover_letters/cfcl.cls:12). Not on CTAN: ctan.org/pkg/cfcv returned 404.
- Class-native vocabulary used: none from article beyond `document`. The zip-local vocabulary is `\name` `\tagline` `\personalinfo` `\makecvheader` `\cvsection` `\company` `\education` `\skillset` `\cvachievement` `\button` `\divider` `\mailaddress` `\phone` `\linkedin` `\github` `\location` and the `\...symbol` icon aliases (cv/cfcv.cls:37-165); for cfcl `\clname` `\cltagline` `\primarycontact` `\secondarycontact` `\clheadrule` `\clsection` `\recipient` `\letterdate` `\opening` `\closing` `\citem` (cover_letters/cfcl.cls:52-109).

## Component map
Main sample `cv/main_example_two_col.tex` (main) and its class `cv/cfcv.cls` (cls). Other samples marked cv1 = `cv/main_example.tex`, cl = `cover_letters/cfcl.cls` and `cover_letters/main_example.tex`.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main:27; cls:17 | `class.article` | 10pt, a4paper |
| paper and size | main:27; cl cfcl.cls:12 | `page.class-options` | a4paper, 10pt |
| page geometry | cls:18; main:28; cl cfcl.cls:14 | `page.geometry` | class default margin=2cm; main override left=1.0cm,right=1.2cm,top=0.9cm,bottom=0.9cm; cfcl all four 1.2cm |
| text font | main:29; cv1:19 | `font.helvet` | package lato, option default (a sans text-face package is the parameter) |
| fonts from files (cover letter) | cfcl.cls:15,32-37 | `font.fontspec` | `\setmainfont` Lato-Regular.ttf, Bold/Italic/BoldItalic files, Path=OpenFonts/fonts/Lato/ (TTFs shipped in the zip) |
| icon font families (cover letter) | cfcl.cls:39-40,44-49 | `font.fontspec` | `\newfontfamily\FAsolid`, `\FAbrands` with Path=...FontAwesome6Free/; glyphs by `\char"F0E0` etc. (`font.icons` with fontawesome5 would print the same glyphs) |
| icons (CV) | cls:36-48; main:111-114,144-148,178 | `font.icons` | package fontawesome (FA4); `\faAt \faPhone \faGlobe \faMapMarker \faLinkedinSquare \faGithub \faEnvelope \faExternalLink \faCertificate \faCalendar` |
| microtype | cls:19; cfcl.cls:17 | `sp.microtype` | no options |
| colours | cls:22,25-33; cfcl.cls:23-28 | `color.xcolor` | HTML: DodgerBlue 4F83FF, Black 000000, SlateGrey 2E2E2E, LightGrey 555555, VividPurple 2E64FE, AzureRadiance 00ABFF, ElectricViolet 9F00FF; `\colorlet{accent}{DodgerBlue}`, `\colorlet{body}{Black!80}` |
| default text colour, empty page style, ragged | cls:167-170; cfcl.cls:55-56 | `hf.pagestyle-kernel`, `color.xcolor`, `sp.ragged` | `\pagestyle{empty}`, `\color{body}`, `\raggedright` in `\AtBeginDocument` |
| skip and indent lengths | cls:68-71; main:35-37; cfcl.cls:57-58 | `sp.lengths` | `\smallskipamount` 3pt to 2pt, `\medskipamount` 4pt to 3pt, `\bigskipamount` 5pt to 3pt, `\parindent`=0pt, cfcl `\parskip`=7pt |
| parskip package (cover letter) | cfcl.cls:19 | `sp.parskip-pkg` | no options |
| line spread | main:84,131,168,175,189; cls:102,105 | `sp.linespread` | 1.35, 1.50, 1.5, 1.45; `\baselinestretch` 1.2 then 1.1 in `\cvsection` |
| two-column layout | main:30,40-41,89,289 | `cols.paracol` | `paracol` env 2 columns, `\columnratio{0.32}`, `\setlength{\columnsep}{0.65cm}` |
| synchronised column switch | main:100,121,200 | `cols.paracol` | `\switchcolumn*` twice, then `\switchcolumn`; `\vfill` at main:164,185,278 (`sp.manual-space`) |
| column divider | main:31,44-50 | `bg.eso-pic` + `art.tikz` | **ART**: full page height line, x=0.350\paperwidth, accent!22, 0.4pt |
| header block (hand-laid) | main:103-117 | `box.minipage`, `sp.ragged`, `sp.rule`, `font.size-commands`, `mark.kernel`, `font.icons`, `meta.hyperref` | minipages 0.54 and 0.44 \linewidth, `\hfill`, `\Large \small \scriptsize`, `\raggedleft`, `\rule{\linewidth}{1.2pt}`, `\href{mailto:...}` |
| header block (class macro) | cls:63-65,83-91; cv1:26-35 | same composition as above | `\makecvheader`: centred name `\Large\bfseries` uppercase, tagline `\small\bfseries` accent, info `\footnotesize\bfseries`, rule 1.2pt accent |
| contact items | cls:51-60; cv1:29-33 | `font.icons`, `color.xcolor`, `sp.manual-space`, `meta.hyperref` | `\printinfo`: icon in accent + `\hspace{0.4em}` + text + `\hspace{1.8em}`; `\href{mailto:}` `\href{tel:}` |
| hyperlinks | cls:21; main:32,113,144-148; cl cfcl.cls:18 | `meta.hyperref` | no options, no `\hypersetup` |
| sidebar section heading | main:53-56,130,143,152,167,174,188 | `head.titlesec` (reduction target) | `\sidesection`: `\vspace{0.40cm}`, `\small\bfseries` accent uppercase, rule 1.2pt, `\smallskip`; expands to `sp.manual-space`, `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.rule` |
| main-column section heading | cls:100-105; main:204,225,240,254,270,281; cv1:38 | `head.titlesec` (reduction target) | `\cvsection`: `\bigskip`, `\small\bfseries` accent uppercase, rule 1.2pt, `\medskip`, `\baselinestretch` 1.2 then 1.1 (`sp.linespread`) |
| entry blocks | main:73-86,206-251,283-287 | `box.minipage`, `font.size-commands`, `mark.kernel`, `color.xcolor`, `sp.linespread` | `\jobentry`: minipage[t] 0.33 and 0.66 \linewidth, `\footnotesize` bold uppercase org, `\scriptsize` location and dates, `\linespread{1.35}` description |
| entry blocks (class) | cls:118-123,144-150,154-156,136-140; cv1:47,87,69-71 | `sp.manual-space`, `font.icons`, `color.xcolor`, `font.size-commands` | `\company`, `\education`, `\skillset`, `\project`: `\hfill` rows, `\faMapMarker`, `\faCalendar` |
| icon rows | main:59-60,155-156 | `font.icons`, `color.xcolor`, `sp.manual-space` | `\iconitem`: accent icon, `\hspace{0.35em}`, `\footnotesize` body colour, `\vspace{0.07cm}` |
| skill progress bars | main:63-68,256-267 | `art.tikz` | **ART**: grey `black!10` track and accent fill rectangles, 3.5pt high, fraction of `\linewidth` |
| skill tags | cls:126-133 | `art.tikz` | **ART**: filled rounded `\node`, white `\bfseries\scriptsize` text; list splitter `\SplitList{,}` and `\ProcessList` (xparse) |
| lists | cls:108-114; cv1:51-54,96-99 | `list.kernel`, `list.enumitem` | `\setlist{leftmargin=*,labelsep=0.8em,nosep,itemsep=0.15\baselineskip,after=\vskip0.15\baselineskip,before=\vskip0.15\baselineskip}`; itemize `label=\itemmarker` (accent `\small\textbullet`); main has no real list, bullets are `$\bullet$` text (main:169-171,272-274) |
| certificate row | cls:159-165; cv1:75-79 | `tbl.tabularx`, `tbl.multirow`, `tbl.tabular` | `\cvachievement`: `tabularx` `@{}p{2em} @{\hspace{1ex}} >{\raggedright\arraybackslash}X@{}`, `\multirow{2}{*}` icon |
| link button | cls:74-76; cv1:81 | `box.tcolorbox` | `\tcbox[colback=white, colframe=accent, coltext=black, boxrule=0.5mm, arc=1mm, boxsep=4pt, left=5pt, right=5pt, top=2pt, bottom=2pt]` |
| dashed dividers | cls:94-96; cv1:56 | `sp.rule` | `\hdashrule{\linewidth}{0.8pt}{0.5ex}` accent; `\dividergray` 0.4pt `body!50` |
| two-column block (single-column CV) | cv1:20,85-100 | `cols.multicol` | `multicols{2}`, `\columnbreak` |
| skills in two blocks | main:256-267 | `box.minipage` | two `minipage[t]` of 0.48 \linewidth with `\hfill` |
| cover letter header, recipient, date, opening, closing | cfcl.cls:62-83,95-109; cover_letters/main_example.tex:20-45,67-73 | `tbl.tabularx`, `sp.ragged`, `sp.rule`, `sp.manual-space`, `font.size-commands`, `mark.kernel`, `color.xcolor` | `\recipient` `tabularx{\linewidth}{@{}X r@{}}`; `\closing` `\vspace{20pt}`; footer `\vfill` + `\rule{\linewidth}{1.2pt}` |
| cover letter section line | cfcl.cls:87-91; cover_letters/main_example.tex:42 | `sp.rule`, `mark.kernel`, `color.xcolor` | `\clsection`: uppercase `\small\bfseries` accent, rule 1.2pt |
| title/abstract/toc/bib/index/theorems/floats/captions/code/math | none | not used | the samples hold no such component |

Notes on the mapping. `\MakeUppercase` (cv/main_example_two_col.tex:55, cv/cfcv.cls:85,103) is a kernel text-case command; it is filed under `mark.kernel` as the nearest kernel inline command, flagged for the consolidator. `\ifx&#3&\else...\fi` in `\jobentry` (main:78,83) only omits an empty piece, which the emitter does by not printing it.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `cfcv.cls` as a whole | cv/cfcv.cls:16-170 | yes | `class.article` + `page.geometry` + `sp.microtype` + `box.tcolorbox` + `meta.hyperref` + `color.xcolor` + `font.icons` + `list.enumitem` + `tbl.tabularx` + `tbl.multirow` + `sp.rule`; every macro below is a `\newcommand` composition. Not complete, because of the TikZ rows |
| `\name \tagline \personalinfo \makecvheader` | cv/cfcv.cls:63-65,83-91 | yes | values stored with `\def\@name`; the emitter prints the header expansion directly |
| `\printinfo` and the contact macros | cv/cfcv.cls:51-60 | yes | `\mbox{\textcolor{accent}{icon}\hspace{0.4em}text\hspace{1.8em}}` |
| `\cvsection`, `\sidesection` | cv/cfcv.cls:100-105; main:53-56 | yes | `head.titlesec`: `\titleformat` colour accent, `\small\bfseries`, uppercase, rule 1.2pt, `\titlespacing` |
| `\company \education \skillset \project \cvachievement \button \divider` | cv/cfcv.cls:95-96,118-165 | yes | compositions listed in the map |
| `\jobentry`, `\iconitem` | main:59-60,73-86 | yes | minipages and font switches as in the map; the empty-argument `\ifx` is decided by the emitter |
| `\AtBeginDocument{...}` | cv/cfcv.cls:167-170 | yes | `\pagestyle{empty}`, `\color{body}`, `\raggedright` as preamble lines |
| `\splitoncomma`, `\cfcvtag` | cv/cfcv.cls:132-133 | yes, as a list iterator | `\NewDocumentCommand` with `>{\SplitList{,}} m` and `\ProcessList` (xparse, kernel since 2020); unrolled by the emitter into one `\cvtag{x}` per item. Still depends on `\cvtag` |
| `\cvtag` | cv/cfcv.cls:127-130 | no (ART/class) | a TikZ node. `\tcbox[colback=accent,colframe=accent,arc=...,left=1ex,right=1ex,top=0.75ex,bottom=0.75ex]` is the nearest lib way, but `text height=1.2ex`, `text depth=.2ex` and `baseline` alignment have no tcolorbox key; not accepted |
| `\skillbar` | main:63-68 | no (ART/body) | conceivably `\textcolor{black!10}{\rule{\linewidth}{3.5pt}}\hspace{-\linewidth}\textcolor{accent}{\rule{#2\linewidth}{3.5pt}}` (`sp.rule`, `sp.manual-space`, `color.xcolor`); a hand-built negative-skip overlay, not shown equal, so treated as ART |
| page divider | main:44-50 | no (ART/preamble) | conceivably `bg.eso-pic` `\AtPageLowerLeft{\hspace*{0.35\paperwidth}\textcolor{accent!22}{\rule{0.4pt}{\paperheight}}}`; again a hand-built construction and the 0.2pt line-centre offset differs; treated as ART |
| `cfcl.cls` macros | cover_letters/cfcl.cls:44-109 | yes | `\citem`, `\clname`, `\cltagline`, `\primarycontact`, `\secondarycontact`, `\clheadrule`, `\clsection`, `\recipient`, `\letterdate`, `\opening`, `\closing` are `\newcommand` compositions of lib ways; `\opening` and `\closing` are not the kernel letter commands |
| `cfcl.cls` as a whole | cover_letters/cfcl.cls:11-58 | yes | `class.article` + `page.geometry` + `font.fontspec` + `color.xcolor` + `sp.microtype` + `meta.hyperref` + `sp.parskip-pkg` + `tbl.tabularx`; no TikZ |

## Content-opaque
none (the TikZ items above are template artwork, not figure content; no figure or table float exists in any sample)

## Lib changes
- New ways proposed: `sp.rule` `dashrule` (CTAN, checked at ctan.org/pkg/dashrule), pdfLaTeX; `\hdashrule[raise][colour]{width}{height}{dash pattern}` draws a dashed rule. W1 published on CTAN; W2 width, height, colour and dash pattern are lengths and a list; W3 any dashed divider, not one document; W4 a single body command, plus a load line. `sp.rule` names only the kernel rule commands, so it does not cover a package; the consolidator may fold it into `sp.rule` (a rule-drawing package is the parameter) as was done for `font.helvet` into `font.helvet`.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
