no

# 0263-beamertheme-spectrum: the spectrum beamer/ltx-talk theme (CTAN `beamertheme-spectrum` v0.6)

- Unverified: read from the source, not compiled.
- Source: Source/0263-beamertheme-spectrum/ (origin: https://mirrors.ctan.org/macros/latex/contrib/beamer-contrib/themes/beamertheme-spectrum.zip; licence: LPPL 1.3c)
- Kind: presentation
- Lib: v3
- Engine: pdfLaTeX-compatible (arara header names pdflatex, beamertheme-spectrum-doc.tex:16; the doc also needs shell escape, see Blockers)
- Look carried by: mixed (the slide look is in the CTAN-published theme styles beamerthemespectrum.sty and talkthemespectrum.sty, loaded by `\usetheme` / `\usepackage`; the main sample's own look is in the zip-local helper beamertheme-spectrum-doc-settings.sty plus its preamble)
- Class origin: tex-distribution-unbundled (main sample `scrartcl`, embedded decks `beamer` and `ltx-talk`; the zip holds no `.cls`)
- Main file: beamertheme-spectrum-doc.tex (other samples: three `tcblisting` decks inside it, lines 76-105, 127-163, 174-203; README.md:19-55 repeats the beamer one)
- Read: main yes, zip-local classes and styles all (beamerthemespectrum.sty 220 lines, talkthemespectrum.sty 192, beamertheme-spectrum-doc-settings.sty 223; the PDF and the JPEG were not read)

## Verdict
The theme itself is on CTAN and in TeX Live (one ctan.org read: v0.6, LPPL 1.3c, TeX Live), so a deck that loads it is `slide.beamer-theme` with the theme name and four declarative options as parameters. The answer is still `no` because the main sample is the documentation file, and the zip-local helper it loads requires `minted` (pygments, shell escape) unconditionally, runs `latexmk` from `tcolorbox`, patches minted's internals, and the doc's title carries a TikZ spectrum shading bar. Those cannot be written from published ways without an outside tool or copied macro logic.

## Blockers
- `EXTERNAL/package` minted is loaded unconditionally and drives `\saminline`, `\newminted` and the tcolorbox listings (beamertheme-spectrum-doc-settings.sty:112, :131-132, :154; beamertheme-spectrum-doc.tex:65, :72); shell escape is requested in the arara header (beamertheme-spectrum-doc.tex:18).
- `EXTERNAL/package` tcolorbox key `run latexmk={-g- -pdf -cd}` runs latexmk on every listing, with `listing file` writing `./include/<jobname>-listing-N.tex` (beamertheme-spectrum-doc-settings.sty:160-167).
- `BESPOKE/preamble` hand patches of minted internals: `\@namedef{PYG@tok@...}` token macros in an `env/MintedVerbatim/before` hook and `\patchcmd{\minted@inputpyg@inline}` (beamertheme-spectrum-doc-settings.sty:114-123, :135-137). Irreducible: it edits another package's code.
- `ART/preamble` a `\tikz{\fill[shading=titleshade,opacity=.75,shading angle=180] (0,0) rectangle (8cm,1cm);}` bar inside `\author`, its shading made by `pgf-spectra` `\pgfspectrashade(420,660){titleshade}` (beamertheme-spectrum-doc.tex:31-35, :42). Template-identity artwork of the doc title, no declarative lib way.

Not listed as blockers, recorded in "Bespoke code": the theme's own TikZ title, section and standout slides and its standout-key code (beamerthemespectrum.sty:125-217). They are inside a CTAN-published theme (W1), so `\usetheme[...]{spectrum}` is the way. If a reader refuses to count the published theme as a way, they become `ART/class` and `BESPOKE/class` and the answer stays `no`.

## Class setting
- Class: `class.scrartcl` (main sample), options none (beamertheme-spectrum-doc.tex:23). Also used by the embedded samples: `class.beamer` options `aspectratio=169`, `xcolor=dvipsnames` (:76, :127-129) and `class.ltx-talk` no options (:175), preceded by `\DocumentMetadata{}` (:174).
- Class-native vocabulary used: KOMA `\subtitle`, `\KOMAoptions{parskip=half-}`, `\addtokomafont{sectioning|date|author}` (beamertheme-spectrum-doc.tex:39; settings.sty:183-186); beamer `frame`, `\frametitle`, frame option `standout` (defined by the theme), `\institute`, `\title`, `\author`, `\maketitle`, `\AtBeginSection[]`, `\usebeamertemplate{section page}` (doc.tex:80-101); ltx-talk `\AddToHook{section/begin}`, `\UseTemplate{sectionpage}{talk}{}`, `\title[short]{}`, `\institute[short]{}`, theme package `talkthemespectrum` with keys `themecolor`, `titlegraphic`, `sectiongraphic`, `titlecredit` (doc.tex:177-190).

## Component map
Main sample (documentation article, scrartcl):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | beamertheme-spectrum-doc.tex:23 | `class.scrartcl` | no options |
| paragraph spacing | beamertheme-spectrum-doc-settings.sty:183 | `class.scrartcl` | `\KOMAoptions{parskip=half-}` (class option) |
| page geometry | beamertheme-spectrum-doc-settings.sty:79 | `page.geometry` | paper=a4paper, margin=2.9cm (scrartcl branch :77-90) |
| language | beamertheme-spectrum-doc-settings.sty:78 | `lang.babel` | english |
| header/footer | beamertheme-spectrum-doc-settings.sty:80 | `hf.scrlayer-scrpage` | package loaded, no field set anywhere in the zip |
| text and math font | beamertheme-spectrum-doc-settings.sty:81-83 | `font.charter` | `mathdesign` option bitstream-charter; `\let\hrulefill` guard around it |
| encoding | beamertheme-spectrum-doc-settings.sty:91 | `font.fontenc-t1` | T1 |
| mono font | beamertheme-spectrum-doc-settings.sty:93-97 | `font.mono` | inconsolata, then cascadia-code scale=0.85 |
| logo package | beamertheme-spectrum-doc-settings.sty:99 | `font.icons` | `metalogox` (logo-by-name family as `hologo`); no command of it is called in the doc |
| footnotes | beamertheme-spectrum-doc-settings.sty:84, :187 | `fn.footmisc` | hang, flushmargin, bottom; `\footnotemargin`=0.7em |
| footnotes in boxes | beamertheme-spectrum-doc-settings.sty:85-86 | `fn.bigfoot` | `footnotehyper`, `\makesavenoteenv{tcolorbox}` |
| widows and orphans | beamertheme-spectrum-doc-settings.sty:87 | `sp.penalties` | `nowidow` option `all`, a front end for the penalty arrays; exact equivalence not checked |
| URLs | beamertheme-spectrum-doc-settings.sty:88 | `meta.url` | hyphens |
| hyperlinks | beamertheme-spectrum-doc-settings.sty:89 | `meta.hyperref` | colorlinks=true, breaklinks=true, allcolors=themecolor, hyperfootnotes=false |
| colours | beamertheme-spectrum-doc-settings.sty:22-35, :67-68 | `color.xcolor` | 13 `\definecolor` RGB, `themecolor`=samdblue (doc.tex:26), `listingcolor`=samlblue |
| colour model | beamertheme-spectrum-doc.tex:32-35 | `color.xcolor` | `\selectcolormodel{cmyk}` in a group |
| heading colour | beamertheme-spectrum-doc-settings.sty:184 | `head.koma-fonts` | `\addtokomafont{sectioning}{\color{themecolor}}` |
| title block fonts | beamertheme-spectrum-doc-settings.sty:185-186 | `head.koma-fonts` | date, author `\normalsize` |
| title block | beamertheme-spectrum-doc.tex:38-52 | `front.maketitle`, `front.koma-title` | `\title`, `\subtitle`, `\author`, `\date`, `\maketitle` |
| title decoration | beamertheme-spectrum-doc.tex:31-35, :42 | `art.tikz`, `art.content-package` | spectrum shade bar 8cm x 1cm, opacity .75 (ART) |
| units | beamertheme-spectrum-doc.tex:30, :64 | `mark.siunitx` | `\qty{420}{nm}` |
| sections, label | beamertheme-spectrum-doc.tex:54-55, :69, :108, :166 | `head.kernel`, `xref.kernel` | `\section`, `\label{intro}` |
| footnote | beamertheme-spectrum-doc.tex:58 | `fn.kernel` | one `\footnote` holding `\url` |
| description list | beamertheme-spectrum-doc.tex:111-121 | `list.kernel` | `description`, 4 items |
| inline code | beamertheme-spectrum-doc-settings.sty:132; beamertheme-spectrum-doc.tex:65 | `code.minted` | `\newmintinline[saminline]{latex}` (EXTERNAL) |
| code listings | beamertheme-spectrum-doc-settings.sty:140, :154; beamertheme-spectrum-doc.tex:72-106 | `code.tcblisting` | `tcblisting`, listing engine=minted, language latex, `compilable listing sam` (EXTERNAL) |
| listing boxes | beamertheme-spectrum-doc-settings.sty:139, :142-159 | `box.tcolorbox` | libraries most, minted; colframe=themecolor, colback=themecolor!10, boxrule=0pt, sharp corners, sidebyside, righthand width=5.7cm, gap 10pt, top/bottom 2pt, left/right 3pt |
| no page break before box | beamertheme-spectrum-doc-settings.sty:172-175 | `pg.break` | `before pre={\nopagebreak[4]}` (tcb hooks library; not-beamer branch) |

Embedded beamer deck (the sample of the theme):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | beamertheme-spectrum-doc.tex:76, :127-129 | `class.beamer` | aspectratio=169; xcolor=dvipsnames |
| theme | beamertheme-spectrum-doc.tex:78, :131-136 | `slide.beamer-theme` | spectrum; themecolor=Aquamarine, titlegraphic=blueshade, sectiongraphic=blueshade, titlecredit={Title graphic: tcolorbox package} |
| section page frame | beamertheme-spectrum-doc.tex:80-84 | `slide.beamer-section-hook` | `\begin{frame}\usebeamertemplate{section page}\end{frame}` |
| front matter | beamertheme-spectrum-doc.tex:86-92 | `front.maketitle`, `front.class-native` | `\title`, `\author`, `\maketitle`; `\institute` is beamer-native |
| frames | beamertheme-spectrum-doc.tex:96-103 | `class.beamer` | `frame`, `\frametitle`, `[standout]` (key defined by the theme) |
| sectioning | beamertheme-spectrum-doc.tex:94 | `head.kernel` | `\section` |

Embedded ltx-talk deck:

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | beamertheme-spectrum-doc.tex:174-175 | `class.ltx-talk`, `meta.documentmetadata` | `\DocumentMetadata{}` empty |
| theme package | beamertheme-spectrum-doc.tex:177-182 | `class.ltx-talk` | `talkthemespectrum`, keys all commented out in the sample |
| section page | beamertheme-spectrum-doc.tex:184-186 | `class.ltx-talk` | `\AddToHook{section/begin}{\UseTemplate{sectionpage}{talk}{}}` |
| front matter | beamertheme-spectrum-doc.tex:188-194 | `front.class-native` | `\title[short]`, `\author[short]`, `\institute[short]`, `\maketitle` |

Inside the published theme styles (informational: what `\usetheme{spectrum}` does; not a separate emit target):

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| options | beamerthemespectrum.sty:26-32 | `slide.beamer-theme` | themecolor (default `beamer@blendedblue!75!black`), titlegraphic (default beamertheme-spectrum-bg.jpg), titlecredit, sectiongraphic |
| base themes | beamerthemespectrum.sty:46-48 | `slide.beamer-theme` | inner `rectangles`, color `orchid`, structure `named=themecolor` |
| colours | beamerthemespectrum.sty:55-59 | `slide.beamer-template` | title/subtitle fg=white; frametitle and block title bg=themecolor fg=white; head/foot fg=gray |
| fonts | beamerthemespectrum.sty:66-73 | `slide.beamer-template` | title `\Huge` bold, subtitle `\LARGE` bold, section `\LARGE` bold, standout `\Large` bold |
| navigation, footline, headline, frametitle | beamerthemespectrum.sty:80-118 | `slide.beamer-template` | symbols empty, `framenumber`, footline of date / author / title / institute split by `\hfill\vert\hfill`, frametitle in a 1.7cm `minipage` |
| title, section, standout slides | beamerthemespectrum.sty:125-204 | `art.tikz` | full-width image and coloured band drawn on `current page` (ART if the theme is not accepted as a way) |
| ltx-talk theme | talkthemespectrum.sty:50-60, :68-74, :135-164 | `class.ltx-talk` | `\geometry{tmargin=1.8cm,headsep=0.8cm}`, `\EditInstance` header/footer/titlepage-element |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| doc-settings option plumbing (`xkeyval`) | beamertheme-spectrum-doc-settings.sty:66-70 | yes | `\colorlet{themecolor}{samdblue}`, `\colorlet{listingcolor}{samlblue}` with `color.xcolor` |
| `\providecommand` text macros `\CTAN` `\TikZ` `\miktex` `\texlive` `\tikzbrick` `\tikzducks` `\tikzlings` `\tikzmarmots` `\ConTeXt` | beamertheme-spectrum-doc-settings.sty:199-207 | yes | text aliases over `mark.kernel` (`\textsc`, `\emph`) and kern; only `\CTAN`, `\texlive`, `\miktex` are reached (through `\blurb`, :219) |
| `\blurb`, `\packagename` | beamertheme-spectrum-doc-settings.sty:214-224; beamertheme-spectrum-doc.tex:48, :67 | yes | one boilerplate paragraph (content), starred variant not used |
| `\samcolours` swatch row | beamertheme-spectrum-doc-settings.sty:37-59 | not reached | defined, never called in the doc (grep) |
| `\let\hrulefillx` guard | beamertheme-spectrum-doc-settings.sty:81, :83 | yes | kernel `\let` before and after the font package |
| `\ifpdftex \pdfsuppressptexinfo-1` | beamertheme-spectrum-doc-settings.sty:190-192 | yes | one pdfTeX primitive line, no visible effect; no lib way names it |
| minted token hook and `\patchcmd` | beamertheme-spectrum-doc-settings.sty:114-123, :135-137 | no | edits minted internals; also EXTERNAL |
| `synthslant` faux slant | beamertheme-spectrum-doc-settings.sty:98, :122 | not reached | only styles minted comments; considered: `synthslant` |
| theme standout key: `\define@key{beamerframe}{standout}` opens `\begingroup`, closed in `\pretocmd{\beamer@reseteecodes}`, plus `\AtBeginEnvironment{beamer@frameslide}` | beamerthemespectrum.sty:190-217 | no, if reproduced | published CTAN code (W1 holds); would be `BESPOKE/class` |
| theme footline conditionals on `\beamer@shortdate`, `\beamer@andstripped` | beamerthemespectrum.sty:84-104 | no, if reproduced | published CTAN code; would be `BESPOKE/class` |
| theme title/section/standout TikZ overlays, `\ps@navigation@titlepage` | beamerthemespectrum.sty:121-204 | no, if reproduced | published CTAN code; would be `ART/class` |
| ltx-talk title and section templates: expl3 `\DeclareTemplateCode`, `picture` with `\put`, `\rule`, `\includegraphics` | talkthemespectrum.sty:78-133, :171-192 | no, if reproduced | published CTAN code; would be `ART/class` (`art.pstricks`) |

## Content-opaque
none beyond the frozen compiled-example PDFs the `tcblisting` boxes show (generated, EXTERNAL above); the shipped asset beamertheme-spectrum-bg.jpg (756x567 JPEG) is the theme's default title graphic, to be shipped with it.

## Lib changes
- New ways proposed: none. Considered: `nowidow` (mapped to `sp.penalties`), `synthslant` (only inside the minted hook), `metalogox` (mapped to `font.icons`), `talkthemespectrum` as an ltx-talk theme package (recorded as `class.ltx-talk` vocabulary, as `class.prosper` went into `class.prosper` in lib v2).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this).
