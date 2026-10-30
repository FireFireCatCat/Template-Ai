yes

# 0392-pdfarticle: pdfArticle (a simple LuaLaTeX class for PDF documents, with its own feature sheet as the sample)

- Unverified: read from the source, not compiled.
- Source: Source/0392-pdfarticle/ (origin: https://mirrors.ctan.org/macros/luatex/latex/pdfarticle.zip; licence: MIT, README:9, pdfArticle.cls:3-21)
- Kind: misc (manifest hint: misc; the zip is the class plus a short feature sheet of it, not a journal or thesis template)
- Lib: v4
- Engine: needs LuaLaTeX (README:1-2; `fontspec` with OpenType Latin Modern at pdfArticle.cls:78-82; `unicode-math` at pdfArticle.cls:140-141; the LuaTeX primitive `\pdfvariable imageresolution` at pdfArticle.cls:87)
- Look carried by: mixed (the published class sets fonts, page geometry, verbatim, text decorations and link colours, pdfArticle.cls:78-158; the sample preamble adds only spacing lengths and `titling` hooks, pdfArticle.tex:35-41)
- Class origin: ctan (ctan.org/pkg/pdfarticle read: "pdfArticle - Class for pdf publications", MIT, path /macros/luatex/latex/pdfarticle, author R. R. Paciorek; matches the copyright and `\ProvidesClass` line at pdfArticle.cls:1, 28)
- Main file: pdfArticle.tex (other samples: none; pdfArticle.pdf is the compiled output of it and was not read)
- Read: main yes (125 lines), zip-local classes and styles all (pdfArticle.cls, 168 lines, in full; the base class `extarticle` is the published `extsizes` class, not in the zip, source not read)

## Verdict
Yes. The zip is the CTAN class `pdfArticle` (W1 met) plus a short sample that sets one class option (`fontSize=10pt`) and a few preamble lines, every one of which maps to a lib way: `titling` hooks, `\setstretch`, two raw length assignments, `hologo`, and a one-line `\newcommand` alias that expands inline. The class's own code is published, so by W1 it is not bespoke; an emitter writes `\documentclass[fontSize=10pt]{pdfArticle}` and the preamble lines below. The one tool-dependent part (`minted` and the tcolorbox `external` library) is loaded only under the class option `extra` (pdfArticle.cls:144-149), which the sample does not set, so it is not an unconditional EXTERNAL. LuaLaTeX is required, which is recorded and is not a blocker.

Stricter reading, for re-reading under other definitions: if the class were decomposed instead of used as a way, three class-internal macros would be irreducible and tagged `BESPOKE/class` (`\forceNewPageGeometry`, the `\ref` patch with the colour stack, `\namedLabel`). The sample calls none of them. They are listed in "Bespoke code".

## Blockers
none

## Class setting
- Class: `class.pdfarticle` options used by the sample: `fontSize=10pt` (pdfArticle.tex:23). Options the class defines (key=value through `kvoptions`, family `KVP`, pdfArticle.cls:30-31, 69): `fontSize` (default 11pt, forwarded to the base class, cls:34, 75), `mainFont` `mainFontFeat` `sansFont` `sansFontFeat` `monoFont` `monoFontFeat` `mathFont` (cls:35-54), `paperSize` `paperMode` `tmargin` `bmargin` `lmargin` `rmargin` (cls:57-62), boolean `twoside` (cls:63), `imgResolution` (cls:66), boolean `extra` (cls:67). Base class: `extarticle` (cls:75), sizes 8pt to 20pt (cls:34 comment).
- Class-native vocabulary used by the sample: `\ul[colour]{}` `\st[colour]{}` `\hl[colour]{}` (pdfArticle.tex:69; defined cls:120-122); `Verbatim` environment with `xleftmargin=5mm` (tex:87, 119) and inline `\Verb$...$` (tex:59-82) and `\Verb[breaklines=true]$...$` (tex:71) from the redefined verbatim layer (cls:113-116); `\hypersetup` (tex:30). Named in the sample text but not called in its body: `\FSPush` `\FSPop` `\FSTop{colors}` (tex:59; cls:90-91), `\forceNewPageGeometry` (tex:63; cls:104-110), `\pdfArticlePreHyperRef` (tex:118-124; cls:153), the `\alph` and `\Alph` redefinition (tex:71; cls:127-129). Defined and undocumented in the sample: `\namedLabel{label}{name}` (cls:160-166).

## Component map
All class-set rows come from the published class; the emitter writes `\documentclass` and does not copy them. Rows marked "loaded, unused" are packages the class loads that no line of the sample exercises.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | pdfArticle.tex:23; pdfArticle.cls:27-28, 75 | `class.pdfarticle` | `[fontSize=10pt]`; `\LoadClass[\KVP@fontSize]{extarticle}`; keyval options processed with `\ProcessKeyvalOptions*` (cls:69) |
| base font size | pdfArticle.tex:23; pdfArticle.cls:34, 75 | `page.class-options` | `fontSize=10pt` (class default 11pt), forwarded as the `extarticle` size option |
| paper, orientation, margins, sides | pdfArticle.cls:57-63, 94-99 | `page.geometry` | defaults `a4paper`, `portrait`, `tmargin=2.2cm`, `bmargin=2.5cm`, `lmargin=2.2cm`, `rmargin=2.2cm`, `twoside=true`; the sample leaves all at default |
| text fonts | pdfArticle.cls:42-53, 78-82 | `font.fontspec` | `\setmainfont{Latin Modern Roman}` with `UprightFeatures={SmallCapsFont={lmromancaps10regular}}`, `ItalicFeatures={SmallCapsFont={lmromancaps10oblique}}`, `SlantedFont=lmromanslant10regular`, `BoldSlantedFont=lmromanslant10bold`, `Ligatures=TeX` (cls:35-42); `\setsansfont{Latin Modern Sans}` `Ligatures=TeX` (cls:43-46); `\setmonofont{Latin Modern Mono Light}` with small-caps, italic and slanted font files (cls:47-53); `\defaultfontfeatures[\rmfamily,\sffamily,\ttfamily]{}` empty (cls:79) |
| maths font | pdfArticle.cls:54, 140-141 | `font.unicode-math` | `\setmathfont{Latin Modern Math}` (`mathFont`); used by the inline `$\hookrightarrow$` at pdfArticle.tex:65 |
| maths package | pdfArticle.cls:140 | `math.amsmath` | `amsmath` loaded, no options |
| colour package | pdfArticle.cls:90 | `color.xcolor` | `xcolor` loaded, no options; named colours `blue` `red` `yellow` `black` only |
| links and PDF metadata | pdfArticle.cls:156; pdfArticle.tex:30-33 | `meta.hyperref` | `unicode=true, colorlinks=true, linkcolor=black, urlcolor=blue`; `\hypersetup{pdftitle={\@title}, pdfauthor={\@author}}` |
| external link command | pdfArticle.tex:44 | `meta.hyperref` | `\href{https://ctan.org/pkg/#1}{#1}` inside `\texttt` (same package family; the `\pkgLink` alias is reduced under "Bespoke code") |
| internal reference colour | pdfArticle.cls:157-158 | `xref.hyperref` | `\ref` redefined at `\AtBeginDocument` to `\hyperref[#1]{\color{\FSTop{colors}}\oldref*{#1}}`; not used in the sample body |
| paragraph spacing | pdfArticle.tex:35 | `sp.setspace` | `\setstretch{1.0}` |
| paragraph lengths | pdfArticle.tex:35 | `sp.lengths` | `\parindent=0pt`, `\parskip=2pt` |
| title block | pdfArticle.tex:26-28, 48 | `front.maketitle` | `\title{Features of \texttt{pdfArticle} document class}`, `\author`, `\date{2019-05-05}`, `\maketitle` |
| title block restyle | pdfArticle.tex:37-41 | `front.titling` | `\usepackage{titling}`; `\maketitlehooka`, `\maketitlehookb`, `\maketitlehookd` renewed |
| title block spacing in hooks | pdfArticle.tex:38-41 | `sp.manual-space` | `\vspace{-44pt}` (hooka), `\vspace{-14pt}` (hookb), `\vspace{-13pt}` then `\vspace{-12pt}` (hookd, set twice, the second wins) |
| first-page style | pdfArticle.tex:48 | `hf.pagestyle-kernel` | `\thispagestyle{empty}`; no other page style is set, so the `extarticle` default applies on page 2 |
| page break | pdfArticle.tex:85 | `pg.break` | `\clearpage` |
| bullet list | pdfArticle.tex:52-83 | `list.kernel` | one `itemize` of 23 items (tex:53-82), no list options |
| font switches and emphasis | pdfArticle.tex:50-56 | `mark.kernel` | `\texttt` `\textrm` `\textsf` `\textit` `\textsc` |
| logos | pdfArticle.tex:43, 50, 58, 73 | `font.icons` | `\usepackage{hologo}`; `\hologo{LuaLaTeX}` `\hologo{METAPOST}` `\hologo{LaTeXTeX}` |
| underline, strike, highlight | pdfArticle.cls:119-122; pdfArticle.tex:69 | `mark.ulem` | `ulem[normalem]`; `\ul[blue]` rule `\rule[-0.6ex]{2pt}{0.17ex}`, `\st[red]` rule `\rule[0.5ex]{2pt}{0.25ex}`, `\hl[yellow]` rule `\rule[-0.6ex]{1.02pt}{2.7ex}`, all through `\markoverwith{\textcolor{..}{\rule..}}\ULon`; called with the default colour spelled out |
| verbatim blocks and inline verbatim | pdfArticle.cls:113-116; pdfArticle.tex:87-116, 119-124 | `code.verbatim` | `fancyvrb` + `fvextra`; `\DefineVerbatimEnvironment{verbatim}{Verbatim}{}`, `\let\verb\Verb`, `\fvset{breaklines=true, breakafter={/-}, breakaftersymbolpre={}, breakaftersymbolpost={\tiny\ensuremath{\ \hookrightarrow\ }}}`; sample: `Verbatim[xleftmargin=5mm]` twice, `\Verb[breaklines=true]` at tex:71 |
| graphics stack (loaded, unused) | pdfArticle.cls:85-87 | `fig.graphicx` | `graphicx`, `graphbox`; `\DeclareGraphicsExtensions{.mp, .pdf, .png, .jpg, .jpeg}`; `\pdfvariable imageresolution` = `imgResolution` (150); the sample includes no image |
| EPS conversion off | pdfArticle.cls:72 | `class.pdfarticle` | `\def\DoNotLoadEpstopdf{\relax}`: keeps the Ghostscript converter (the lib's epstopdf way, EXTERNAL when an EPS is included) switched off |
| contour (loaded, unused) | pdfArticle.cls:123 | `mark.contour` | `\RequirePackage{contour}`, no options |
| list and counter helpers (loaded, unused) | pdfArticle.cls:126-129 | `list.enumitem`, `num.counters` | `enumitem` no options; `alphalph`: `\alph#1` = `\alphalph{\value{#1}}`, `\Alph` likewise |
| boxes and wrapping (loaded, unused) | pdfArticle.cls:132, 134 | `box.minipage`, `fig.wrapfig` | `pbox` and `varwidth` (natural-width paragraph boxes, the nearest lib type is `\parbox`/`minipage`); `wrapfig` |
| tables, page and alignment helpers (loaded, unused) | pdfArticle.cls:135, 137-138, 142 | `tbl.tabular`, `tbl.siunitx`, `page.adjustwidth`, `sp.ragged`, `fig.adjustbox` | `array`, `dcolumn`; `changepage`; `ragged2e`; `adjustbox`; all no options |
| optional code and boxes (`extra=true` only, not set by the sample) | pdfArticle.cls:144-149 | `code.minted`, `box.tcolorbox` | `\RequirePackage{minted}`; `tcolorbox` libraries `many,vignette,minted,magazine,poster,external`; `minted` is EXTERNAL (pygments, shell escape) when selected, and `external` also needs a shell call |
| loaded packages with no lib way (unused) | pdfArticle.cls:90-91, 123, 133, 136 | none | considered: `shadowtext` (text shadow), `overpic` (overlay on an image), `tabto` (tab to fixed positions), `fifo-stack` (the colour stack behind `\FSPush` `\FSPop` `\FSTop`); none is called by the sample, so no way is proposed |
| class hook before hyperref | pdfArticle.cls:151-153 | `class.pdfarticle` | `\ifdefined\pdfArticlePreHyperRef\pdfArticlePreHyperRef\fi`; user-defined, empty by default; only shown inside a verbatim block at tex:118-124 |

## Bespoke code
Nothing in the zip is unpublished: pdfArticle.cls is the CTAN release, so none of its code is bespoke by W1. Rows 1 to 3 are the sample's own macros (reducible). The class-internal rows follow the same convention as other class-carried zips: listed so the result can be re-read if the class were decomposed, with the tag it would then carry.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\pkgLink{name}` alias | pdfArticle.tex:44 (used tex:53-82) | yes | inline expansion `\texttt{\href{https://ctan.org/pkg/name}{name}}`: `mark.kernel` + `meta.hyperref` |
| `\makeatletter` `\@title` `\@author` in `\hypersetup` | pdfArticle.tex:30-33 | yes | `\hypersetup{pdftitle={Features of pdfArticle document class}, pdfauthor={...}}` with literal strings: `meta.hyperref` |
| `\maketitlehookd` renewed twice | pdfArticle.tex:40-41 | yes | only the last definition acts (`\vspace{-12pt}`); the emitter writes the effective one |
| `\ul` `\st` `\hl` | pdfArticle.cls:120-122 | yes | each is `ulem` `\markoverwith` plus `xcolor` `\textcolor` plus `\rule` with fixed lengths: `mark.ulem` + `sp.rule` + `color.xcolor` |
| `\alph` `\Alph` redefinition | pdfArticle.cls:127-129 | yes | `alphalph` call: `num.counters` |
| `verbatim` and `\verb` redefinition | pdfArticle.cls:114-116 | yes | `fancyvrb` declarations: `code.verbatim` |
| `\forceNewPageGeometry` | pdfArticle.cls:104-110 | published class; as a standalone macro no (patches the `geometry` internals `\Gm@clean` `\Gm@process` `\Gm@changelayout`, sets `\pagewidth` `\pageheight`) | not called by the sample (named at tex:63). Under the stricter reading: `BESPOKE/class` |
| `\ref` patch with colour stack | pdfArticle.cls:90-91, 157-158 | published class; as a standalone macro no (replaces `\ref` at `\AtBeginDocument`, reads the `fifo-stack` top) | not called by the sample body. Under the stricter reading: `BESPOKE/class` |
| `\namedLabel{label}{name}` | pdfArticle.cls:160-166 | published class; as a standalone macro no (rewrites `\@currentlabel` inside a group) | not called by the sample. Under the stricter reading: `BESPOKE/class` |
| `\DoNotLoadEpstopdf` | pdfArticle.cls:72 | yes | a flag macro, no printed effect |

## Content-opaque
none. Everything between tex:50 and tex:124 is documentation text; the Verbatim blocks (tex:87-116, 119-124) print class-option and macro source as text. Doc/code mismatches in that text, recorded so nobody copies the example as defaults: it shows `fontSize=12pt` (tex:89) and `monoFont={Latin Modern Mono}` (tex:103), while the class defaults are `11pt` (pdfArticle.cls:34) and `Latin Modern Mono Light` (cls:53).

Missing assets: the Latin Modern OpenType files named at pdfArticle.cls:36-39, 48-51 (`lmromancaps10regular` and similar) are not shipped; they come with the TeX Live `lm` fonts. No image or other asset is referenced by the sample.

## Lib changes
- New ways proposed: none. The class way is `class.pdfarticle` (written plainly as the rubric asks). Considered and not proposed: `shadowtext`, `overpic`, `tabto`, `fifo-stack` (loaded by the class at pdfArticle.cls:90-91, 123, 133, 136; the sample calls none of them, so recovery does not need a way for them; a zip that calls them may propose one).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
