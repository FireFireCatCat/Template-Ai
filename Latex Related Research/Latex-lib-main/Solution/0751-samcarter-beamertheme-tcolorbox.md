no

# 0751-samcarter-beamertheme-tcolorbox: the tcolorbox inner theme for beamer and ltx-talk (package manual plus theme)

- Unverified: read from the source, not compiled.
- Source: Source/0751-samcarter-beamertheme-tcolorbox/ (origin: https://codeload.github.com/samcarter/beamertheme-tcolorbox/zip/refs/heads/main; licence: LPPL-1.3c)
- Kind: misc (the main sample is a package manual on scrartcl; what the zip ships is a beamer inner theme and an ltx-talk theme, both with the README example decks)
- Lib: v5
- Engine: pdfLaTeX-compatible (arara line names pdflatex, beamertheme-tcolorbox-doc.tex:16; needs `-shell-escape`, :18)
- Look carried by: zip-local (the manual's look is set in beamertheme-tcolorbox-doc-settings.sty on top of scrartcl; the two theme files are the CTAN package itself)
- Class origin: tex-distribution-unbundled (scrartcl is KOMA-Script; not bundled in the zip, source not read)
- Main file: beamertheme-tcolorbox-doc.tex (other samples: testing/test.tex, testing/talktest.tex)
- Read: main yes, zip-local classes and styles all (beamerinnerthemetcolorbox.sty, talkthemetcolorbox.sty, beamertheme-tcolorbox-doc-settings.sty)

## Verdict
No. The manual's own preamble file loads `minted` unconditionally and every example is a `tcblisting` that is compiled by `latexmk` through shell escape, so the document does not build without outside tools (`EXTERNAL/package`). The same file also patches the internals of `minted` (Pygments token macros, `\minted@inputpyg@inline`), which no lib way expresses (`BESPOKE/class`). Everything else in the manual maps to existing ways (KOMA, geometry, footmisc, tcolorbox, hyperref and so on), and the theme files are the published CTAN package `beamertheme-tcolorbox` (same v1.6 of 2026/09/22), so a deck using the theme needs only `\useinnertheme[...]{tcolorbox}`; the verdict does not rest on the theme.

## Blockers
- `EXTERNAL/package` `minted` loaded unconditionally by the settings style the sample loads: `\RequirePackage[cachedir=./.minted]{minted}`, `\tcbuselibrary{minted}`, `listing engine=minted`, `\newminted[samcode]`, `\newmintinline[saminline]`; needs shell escape and Pygments (beamertheme-tcolorbox-doc-settings.sty:112, :140, :154, :131-132; beamertheme-tcolorbox-doc.tex:18)
- `EXTERNAL/package` tcolorbox `compilable listing sam` runs `latexmk` from inside the document (`run latexmk={-g- -pdf -cd}`) and freezes the compiled PDFs under `./include` (beamertheme-tcolorbox-doc-settings.sty:141, :160-167; used at beamertheme-tcolorbox-doc.tex:69-72, :109-112, :134-137, :160-163, :203-206, :266-269)
- `BESPOKE/class` hook that overwrites Pygments token macros `PYG@tok@na`, `@k`, `@nb`, `@c` with `\@namedef` and `\def\PYG@tc` (beamertheme-tcolorbox-doc-settings.sty:114-123)
- `BESPOKE/class` `\patchcmd{\minted@inputpyg@inline}` that injects `\renewcommand\textcolor` and `\renewcommand\bfseries` into a package-internal macro (beamertheme-tcolorbox-doc-settings.sty:135-137)

## Class setting
- Class: `class.scrartcl` options: none on `\documentclass` (beamertheme-tcolorbox-doc.tex:23); `\KOMAoptions{parskip=half-}` later (beamertheme-tcolorbox-doc-settings.sty:198)
- Class-native vocabulary used: `\subtitle`, `\maketitle`, `\addtokomafont{sectioning}`, `\addtokomafont{date}`, `\addtokomafont{author}`, `\KOMAoptions`, `\footnotemargin` (beamertheme-tcolorbox-doc.tex:33, :44; beamertheme-tcolorbox-doc-settings.sty:198-202)
- Other classes the zip's samples use (listed so the lib's class section can be filled): `class.beamer` (testing/test.tex:1-3; `frame`, `block`, `alertblock`, `exampleblock`, `theorem`, `columns`/`column`, `\titlepage`, `\usebeamertemplate{section page}`, `\setbeamercovered`, `\AtBeginSection`, overlay specs `<2>`: testing/test.tex:53-134) and `class.ltx-talk` (testing/talktest.tex:1-2, CTAN class by Joseph Wright, LPPL 1.3c, read at ctan.org/pkg/ltx-talk; `\DocumentMetadata{}`, `\title` `\subtitle` `\author` `\institute`, `\maketitle`, `frame`, `block`, `alertblock`, `exampleblock`: testing/talktest.tex:6-32). The source of scrartcl, beamer and ltx-talk was not read.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | beamertheme-tcolorbox-doc.tex:23 | `class.scrartcl` | no options |
| paragraph spacing | beamertheme-tcolorbox-doc-settings.sty:198 | `class.scrartcl` | `\KOMAoptions{parskip=half-}` |
| page geometry | beamertheme-tcolorbox-doc-settings.sty:79 | `page.geometry` | paper=a4paper, margin=2.9cm (loaded only when the class is scrartcl, :77) |
| header/footer | beamertheme-tcolorbox-doc-settings.sty:80 | `hf.scrlayer-scrpage` | package loaded with no options; no `\pagestyle`, `\ohead` or `\cfoot` anywhere in the sample (grep) |
| serif text and maths | beamertheme-tcolorbox-doc-settings.sty:82 | `font.charter` | mathdesign with option bitstream-charter (the package is the parameter) |
| encoding | beamertheme-tcolorbox-doc-settings.sty:91 | `font.fontenc-t1` | T1 |
| mono fonts | beamertheme-tcolorbox-doc-settings.sty:93-95 | `font.mono` | inconsolata; cascadia-code scale=0.85 (scrartcl only) |
| logo package | beamertheme-tcolorbox-doc-settings.sty:99 | `font.icons` | metalogox loaded after the fonts; the sample calls no logo command (grep); package source not read |
| colour | beamertheme-tcolorbox-doc-settings.sty:22-35, :67-70 | `color.xcolor` | 13 `\definecolor` RGB values (samyellow ... samdgray), `\colorlet{themecolor}`, `\colorlet{listingcolor}`; sample passes themecolor=samteal (beamertheme-tcolorbox-doc.tex:25-27) |
| language | beamertheme-tcolorbox-doc-settings.sty:78 | `lang.babel` | english |
| links and PDF metadata | beamertheme-tcolorbox-doc-settings.sty:89; beamertheme-tcolorbox-doc.tex:35 | `meta.hyperref` | colorlinks=true, breaklinks=true, allcolors=themecolor, hyperfootnotes=false; `\texorpdfstring` in `\author` |
| URL breaking | beamertheme-tcolorbox-doc-settings.sty:88; beamertheme-tcolorbox-doc.tex:37-38 | `meta.url` | option hyphens; `\url` in the author block |
| PDF info keys | beamertheme-tcolorbox-doc-settings.sty:205-207 | `meta.pdf-params` | `\pdfsuppressptexinfo-1` behind `\ifpdftex` (iftex, :105) |
| footnote layout | beamertheme-tcolorbox-doc-settings.sty:84, :202 | `fn.footmisc` | hang, flushmargin, bottom; `\footnotemargin`=0.7em; the sample has no `\footnote` (grep) |
| footnotes in boxes | beamertheme-tcolorbox-doc-settings.sty:85-86 | `fn.bigfoot` | footnotehyper, `\makesavenoteenv{tcolorbox}` |
| widows and clubs | beamertheme-tcolorbox-doc-settings.sty:87 | `sp.penalties` | nowidow with option all |
| heading style | beamertheme-tcolorbox-doc-settings.sty:199; beamertheme-tcolorbox-doc.tex:46, :55, :93, :182, :184, :199 | `head.koma-fonts` and `head.kernel` | `\addtokomafont{sectioning}{\color{themecolor}}`; `\section`, `\subsection` unnumbered-style changes none |
| title block | beamertheme-tcolorbox-doc.tex:32-44; beamertheme-tcolorbox-doc-settings.sty:200-201 | `front.maketitle`, `front.koma-title`, `head.koma-fonts` | `\title`, `\subtitle`, `\author`, `\date`, `\maketitle`; date and author fonts set to `\normalsize` |
| cross-references | beamertheme-tcolorbox-doc.tex:47 | `xref.kernel` | `\label{intro}` (no `\ref` found) |
| lists | beamertheme-tcolorbox-doc.tex:96-105, :189-192 | `list.kernel` | `description`, `enumerate` |
| inline marks | beamertheme-tcolorbox-doc.tex:36, :40, :184 | `mark.kernel` | `\texttt`, `\textendash`, `\textbackslash` |
| page break | beamertheme-tcolorbox-doc.tex:198; beamertheme-tcolorbox-doc-settings.sty:174 | `pg.break` | `\clearpage`; `before pre={\nopagebreak[4]}` |
| boxes | beamertheme-tcolorbox-doc-settings.sty:139, :142-169; beamertheme-tcolorbox-doc.tex:58-62 | `box.tcolorbox` | `[most]`; colframe=themecolor, colback=themecolor!10, sharp corners, boxrule=0pt, top/bottom=2pt, left/right=3pt, sidebyside, center lower, righthand width=5.7cm, sidebyside gap=10pt, lower separated=false, fonttitle=\bfseries, before title={\strut}; hooks library (:173) |
| listing boxes | beamertheme-tcolorbox-doc-settings.sty:154-168; beamertheme-tcolorbox-doc.tex:69-89 | `code.tcblisting` | listing engine=minted, minted language=latex, `compilable listing sam` = listing and comment, pdf comment, freeze pdf, run latexmk (**EXTERNAL**) |
| code highlighting | beamertheme-tcolorbox-doc-settings.sty:112, :125-132; beamertheme-tcolorbox-doc.tex:59-61, :63 | `code.minted` | cachedir=./.minted, `\usemintedstyle{default}`, `\setminted{breaksymbolleft={},tabsize=2,breaklines=true}`, `samcode` env and `\saminline` (**EXTERNAL**) |
| style-tree diagrams | beamertheme-tcolorbox-doc.tex:29, :234-262 | `art.tikz` | `forest` with option edges; content, see Content-opaque |
| theme: loading (the zip's product) | beamerinnerthemetcolorbox.sty:15, :82-98; README.md:19; testing/test.tex:30-38 | `slide.beamer-theme` | `\useinnertheme[shadow,rounded,shaded,inmargin,showtitle,titlepage,blocks,buttons]{tcolorbox}`, booleans; defaults :91-98, auto-detection of other themes :101-112 |
| theme: block and title-page look | beamerinnerthemetcolorbox.sty:138-184, :193-217, :248-254 | `box.tcolorbox` and `slide.beamer-template` | enhanced, boxrule=0cm, frame hidden, top=1.5mm, bottom=0.5mm, sharpish corners or arc=1.3mm, drop fuzzy shadow=black!90, shaded title strip; `\setbeamertemplate{block begin}` and the alerted and example variants; set through `\tcbthemeset{...}` |
| theme: buttons | beamerinnerthemetcolorbox.sty:262-293 | `box.tcolorbox` | `\RenewTCBox{\beamerbutton}` with boxrule=0.4ex, left/right=1.5ex, height=3.1ex, bean arc |
| theme: ltx-talk | talkthemetcolorbox.sty:15, :52-71, :79-160; testing/talktest.tex:4 | `slide.beamer-theme` | `\usepackage[shadow,rounded,shaded,showtitle,titlepage,blocks]{talkthemetcolorbox}`; styles `block`, `alertblock`, `exampleblock`, `titlepage`, `titlepage-title` ... overridden with `\tcbset{<style>/.append style={...}}` (beamertheme-tcolorbox-doc.tex:280-294) |
| testing deck | testing/test.tex:11, :26, :28, :53-57, :61-134 | `slide.beamer-theme`, `slide.beamer-mode`, `box.tcolorbox`, `slide.beamer-section-hook`, `list.kernel` | `\usetheme{Warsaw}`; `\setbeamercovered{transparent}`; `\usepackage[most]{tcolorbox}`; `\AtBeginSection` with a plain frame holding `\usebeamertemplate{section page}`; blocks, theorem, columns and `enumerate` are `class.beamer` vocabulary |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| Pygments token-macro hook | beamertheme-tcolorbox-doc-settings.sty:114-123 | no | rewrites `PYG@tok@*` internals of `minted` through `\AddToHook`; `code.minted` takes a style name and `\setminted` options, not internal macro edits (BESPOKE/class; moot beside the EXTERNAL blocker) |
| `\patchcmd` of `\minted@inputpyg@inline` | beamertheme-tcolorbox-doc-settings.sty:135-137 | no | patches package code (colour inline code, drop bold); no declarative way (BESPOKE/class) |
| stubbed `\documentclass`, `\usepackage`, `document` in `before lower` | beamertheme-tcolorbox-doc-settings.sty:182-187 | no | `\renewcommand` of kernel commands so a listing compiles inline; branch taken only when the class is not scrartcl, so not executed for this sample and not listed as a blocker |
| xkeyval options `themecolor`, `listingcolor` | beamertheme-tcolorbox-doc-settings.sty:66-70 | yes | the sample gives themecolor=samteal (beamertheme-tcolorbox-doc.tex:26), listingcolor defaults to samlblue: emit `\colorlet{themecolor}{samteal}` and `\colorlet{listingcolor}{samlblue}` (`color.xcolor`) |
| `\samcolours` colour strip | beamertheme-tcolorbox-doc-settings.sty:37-59 | yes | defined, never called by the sample (grep); a `\foreach` loop of `\rule`, `\parbox`, `\color` that unrolls to `sp.rule`, `box.minipage`, `color.xcolor` |
| `\providecommand` aliases `\CTAN`, `\TikZ`, `\miktex`, `\texlive`, `\tikzbrick` ..., `\ConTeXt` | beamertheme-tcolorbox-doc-settings.sty:214-222 | yes | inline expansion to `mark.kernel` (`\textsc`, `\emph`) and `sp.manual-space` (`\kern`); the sample uses none (grep) |
| `\packagename`, `\blurb` | beamertheme-tcolorbox-doc-settings.sty:229-239; beamertheme-tcolorbox-doc.tex:41, :53 | yes | one stored string and one paragraph of text with `\url` and `\texttt`; inline expansion (content) |
| `\let\hrulefillx` save and restore around mathdesign | beamertheme-tcolorbox-doc-settings.sty:81-83 | yes | restores kernel `\hrulefill` (`sp.rule`) after loading mathdesign; the sample never calls it (grep) |
| `\prefix` path macro | beamertheme-tcolorbox-doc-settings.sty:141, :160 | yes | a string inside the `listing file` key of `code.tcblisting` (the listing step stays EXTERNAL) |
| `\ifpdftex` guard | beamertheme-tcolorbox-doc-settings.sty:205-207 | yes | the emitter knows the engine and writes the one line (`meta.pdf-params`) |
| theme option machinery (`beamer@tcb@if`, `\newif` switches, `/beamer@tcb/` tikzset keys, `\renewtcolorbox{beamercolorbox}`, `\apptocmd` accumulator, expl3 `titlepage-element` template) | beamerinnerthemetcolorbox.sty:22-70, :225-246; talkthemetcolorbox.sty:22-33, :194-252 | not assessed as zip-local | this is the published CTAN package `beamertheme-tcolorbox` v1.6 (ctan.org/pkg/beamertheme-tcolorbox; same version string at beamerinnerthemetcolorbox.sty:15), so the way is its load line; read as plain zip-local code it would be irreducible (pgfkeys conditionals and a rewrite of `beamercolorbox`); the verdict does not rest on it |

## Content-opaque
- `forest` trees showing the ltx-talk style names (beamertheme-tcolorbox-doc.tex:234-248, :250-262): documentation diagrams, not template identity
- code text of every `tcblisting` and `samcode` example (beamertheme-tcolorbox-doc.tex:69-89, :109-131, :134-157, :160-180, :203-230, :266-313)
- the frozen compiled-example PDFs the listings include from `./include` (beamertheme-tcolorbox-doc-settings.sty:141, :160) are not in the zip (missing assets, produced by the external `latexmk` step); `DOCUMENTATION.pdf` is shipped instead

## Lib changes
- New ways proposed:
  - `meta.pdf-params` pdfTeX primitive `\pdfsuppressptexinfo=<integer>` (pdfTeX manual; `-1` in beamertheme-tcolorbox-doc-settings.sty:206), pdf. W1: a pdfTeX primitive, documented. W2: one integer of flags. W3: any pdfTeX document. W4: one preamble line, guarded by the engine. Not `meta.glyphtounicode` (ToUnicode map) and not `meta.hyperxmp` (XMP).
  - `slide.beamer-theme` `talkthemetcolorbox` (CTAN `beamertheme-tcolorbox` v1.6, LPPL 1.3c) loaded under `class.ltx-talk` (CTAN, LPPL 1.3c): `\usepackage[shadow,rounded,shaded,showtitle,titlepage,blocks]{talkthemetcolorbox}` and `\tcbset{<style>/.append style={...}}`, pdf (talkthemetcolorbox.sty:52-71, :79-160; the theme requires `ltx-talk` and a recent kernel for `\DeclareTemplateInterface`, :197). W1: published on CTAN. W2: boolean options and tcolorbox key lists. W3: serves any ltx-talk deck, the theme name is the parameter. W4: one preamble line plus key lists. Not `slide.beamer-theme` (beamer's `\usetheme` family; a `\usepackage` theme under another class).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
