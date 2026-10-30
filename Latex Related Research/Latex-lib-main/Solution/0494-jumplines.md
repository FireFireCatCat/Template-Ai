yes

# 0494-jumplines: jumplines (teaser articles continued later, with links)

- Unverified: read from the source, not compiled.
- Source: Source/0494-jumplines/ (origin: https://mirrors.ctan.org/macros/latex/contrib/jumplines.zip; licence: LPPL 1.3, README:7-9, manifest `lppl1.3`)
- Kind: newsletter (newspaper-style teaser articles; the manifest hint `journal` is not kept. The main file is the package manual, jumplines_doc.tex, and the second sample, jumplines_example.tex, is the newspaper layout)
- Lib: v4
- Engine: needs LuaLaTeX (README:24-25 and the CTAN page say correct colour inside a split box is LuaLaTeX only; the source itself has no unconditional LuaTeX-only load, `luacolor` is guarded by `\ifluatex` at jumplines.sty:43-49, so pdfLaTeX loads it by the source but a coloured break is not kept; both shipped PDFs have `/Producer(LuaTeX-0.79.1)`)
- Look carried by: preamble (published package `jumplines`, CTAN and TeX Live, shipped in the zip as jumplines.sty; the teaser and continued layout comes from its body commands; the classes are kernel `article` and `ltxdoc`; the manual's own look is published packages plus small zip-local aliases)
- Class origin: tex-distribution-unbundled (kernel `article`, jumplines_example.tex:21; `ltxdoc`, jumplines_doc.tex:22; no class file in the zip)
- Main file: jumplines_doc.tex (other samples: jumplines_example.tex; jumplines.sty is the package source, not a sample)
- Read: main yes (jumplines_doc.tex 1-298), second sample yes (jumplines_example.tex 1-71), zip-local classes and styles all (jumplines.sty 1-562, README read; no .cls, .def, .cfg ships; the two PDFs were not read; the sources of `ltxdoc`, `tcolorbox` and its `documentation` library are not in the zip and were not read)

## Verdict
The zip is the CTAN package `jumplines` (https://ctan.org/pkg/jumplines, LPPL 1.3, in TeX Live and MiKTeX) with its manual and an example. The package passes W1 to W4 as one new doc-kind way, `news.jumplines`: published; behaviour set by keys, lengths, strings and booleans; serves any newspaper-style teaser page; printed as one preamble line and body wrappers (`\JumplineArticle[keys]{content}`, two shipout commands, two list commands). Everything else in both samples is a lib way, and the manual's zip-local macros are aliases and a `\newtcolorbox` call that reduce by inline expansion. There is no artwork and no tool outside TeX.

## Blockers
none

## Class setting
- Class: `class.ltxdoc` options: `12pt,english` (jumplines_doc.tex:22). Used as a plain article-like class; no `.dtx` construct is used. And `class.article` options: `12pt,a4paper,twocolumn,languages=english` (jumplines_example.tex:21; `languages=english` is a global option read by the package's `\ProcessOptionsX`, jumplines.sty:28-36).
- Class-native vocabulary used: the article-style `\section`, `\subsection` and `\tableofcontents` (jumplines_doc.tex:99,110,135); the example uses no sectioning and no front matter. Nothing of `ltxdoc`'s own vocabulary (`macrocode`, `\DescribeMacro`) is used; the manual's `docCommand` family comes from the tcolorbox library, not from `ltxdoc`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (manual) | jumplines_doc.tex:22 | `class.ltxdoc` | 12pt, english |
| class (example) | jumplines_example.tex:21 | `class.article` | 12pt, a4paper, twocolumn, languages=english |
| paper and size options | jumplines_doc.tex:22; jumplines_example.tex:21 | `page.class-options` | 12pt; a4paper |
| page geometry | jumplines_doc.tex:24 | `page.geometry` | lmargin=3cm, rmargin=3cm, a4paper |
| columns | jumplines_example.tex:21 | `cols.twocolumn-option` | twocolumn (the articles are split inside a two-column page) |
| header/footer | jumplines_doc.tex:23,104,105 | `hf.scrlayer-scrpage` | `\pagestyle{scrheadings}`, `\setheadsepline{2pt}[\color{blue}]` |
| cover page style | jumplines_doc.tex:71 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| paragraph shape | jumplines_doc.tex:69 | `sp.lengths` | `\parindent`=0pt |
| font sizes | jumplines_doc.tex:75; jumplines_example.tex:45,52,58 | `font.size-commands` | `\large`, `\Large`, `\Huge` |
| font switches | jumplines_doc.tex:75,78; jumplines_example.tex:45,52 | `mark.kernel` | `\bfseries`, `\textsc`, `\textbf`, `\sffamily` |
| colour | jumplines_doc.tex:74,105; jumplines_example.tex:50-58; jumplines.sty:24 | `color.xcolor` | `\textcolor`, `\color`; blue, red, `yellow!30!white`, violet, brown, Green, GoldenRod; the package loads xcolor with `dvipsnames,x11names` |
| symbol glyphs | jumplines_doc.tex:26,47,48,50 | `font.icons` | `bbding`: `\ding{41}`, `\ding{43}`, `\Writinghand` |
| language | jumplines_doc.tex:22,38,65; jumplines_example.tex:21,26,54; jumplines.sty:39 | `lang.babel` | `\selectlanguage{english}` / `{spanish}`; the package loads babel with `strings,ngerman,english,<languages>`; string tables via `\StartBabelCommands` at jumplines.sty:63-109 (inside the published package) |
| quotation marks | jumplines_doc.tex:33,190; jumplines_example.tex:30 | `lang.csquotes` | `[babel,style=english]`, `\enquote` |
| hyperlinks | jumplines_doc.tex:62,173; jumplines_example.tex:28; jumplines.sty:44 | `meta.hyperref` | `breaklinks=true`; package option `bookmarksopen=true`; `\href` |
| bookmarks | jumplines_example.tex:29; jumplines.sty:45,125-139 | `meta.bookmark` | load only; `\bookmark` used by the package |
| cross-references | jumplines_doc.tex:129,234 | `xref.kernel` | `\ref`, `\label` |
| date | jumplines_doc.tex:31,66,84 | `front.datetime` | `datetime` package, predefined `\mmddyyyydate`, printed by `\today` |
| title block | jumplines_doc.tex:73-96 | `front.titlepage-env` | hand-laid on the first page, no `\maketitle`: `center`, one tcolorbox, one tabular, then `\clearpage` (:98) |
| title box | jumplines_doc.tex:74 | `box.tcolorbox` | boxrule=1mm, arc=4mm, colback=`yellow!30!white`, width=`0.8\textwidth` |
| title text rows | jumplines_doc.tex:36,40,77-89 | `tbl.tabular` | `array` column `C{0.7\textwidth}` (centred p column), rows ended by `\tabularnewline` |
| author footnote | jumplines_doc.tex:86,87,93,94,107 | `fn.kernel` | `\footnotetext`, with `\fnsymbol{footnote}` marks |
| footnote counter | jumplines_doc.tex:86,93,107 | `num.counters` | `\addtocounter{footnote}{2}`, `\renewcommand{\thefootnote}{\fnsymbol{footnote}}`, `\setcounter{footnote}{0}` |
| inline maths | jumplines_doc.tex:87; jumplines_example.tex:53 | `math.kernel` | `\( ... \)`, `\mathrm` |
| contents | jumplines_doc.tex:99 | `toc.kernel` | `\tableofcontents` |
| headings | jumplines_doc.tex:110,127,133,135,152,227,234,243,270 | `head.kernel` | `\section`, `\subsection` with the class defaults |
| lists | jumplines_doc.tex:137-144,245-254 | `list.kernel` | `itemize` |
| enumerated list | jumplines_doc.tex:30,159 | `list.enumitem` | `enumerate[label={\textcolor{blue}{\#\arabic*}}]` |
| page breaks | jumplines_doc.tex:98,232,268,289,292; jumplines_example.tex:41,63,67 | `pg.break` | `\clearpage` |
| manual spacing | jumplines_doc.tex:285 | `sp.manual-space` | `\vspace{2\baselineskip}` |
| index | jumplines_doc.tex:32,47,48,57,296 | `idx.makeidx` | `imakeidx`, `\makeindex`, `\index{Package!...}`, `\printindex` |
| package-documentation macros | jumplines_doc.tex:42,43,153,157,162,229 | `dtx.doc` | tcolorbox library `documentation` is the parameter (as `codedescribe`): `docCommand`, `docKey`, `docCounter`, `\refKey`, `\refCom`, `\oarg`, `\marg`, `\cs`; `\tcbset{color command={blue}}` |
| arguments box | jumplines_doc.tex:52 | `box.tcolorbox` | `\newtcolorbox{docCommandArgs}[1]` with colbacktitle=blue, coltitle=white, title text |
| framed package names | jumplines_doc.tex:47,48 | `box.fancybox` | `\fbox` around a coloured bold name |
| filler text | jumplines_doc.tex:29,115,118; jumplines_example.tex:25,47,50-58 | `draft.todo` | `blindtext` (`\blindtext[n]`), as `lipsum`; the text is content |
| article images | jumplines_example.tex:24,46,52,58 | `fig.graphicx` | `\includegraphics[scale=0.3]{example-image-a}` inside an article, not a float |
| teaser articles | jumplines_doc.tex:38,114-124; jumplines_example.tex:26,44-58,66,69 | `news.jumplines` | `\usepackage[languages=...]{jumplines}`; `\JumplineArticle[keys][toc text]{content}`; keys TeaserHeight, ArticleHeadline, ArticleAuthor, ContinuedOnTopskip, ContinuedOnBottomskip, TeaserHeaderContent, ContinuedArticleHeaderContent, TeaserHeaderColor, BookmarkEntry, emptyarticleintoc, emptyarticleinbookmarks, autobookmark (jumplines.sty:146-275); then `\ShipoutArticleTeasers` and `\ShipoutArticleHangingArticles` |
| lists of articles | jumplines_example.tex:37,38; jumplines_doc.tex:211-225 | `news.jumplines` | `\listofarticle`, `\listofcontarticle`, names `\listofarticlesname` and `\listofcontinuedarticlesname`; built on `\newlistof` (jumplines.sty:121,122) |
| teaser and continued header bars | jumplines.sty:279-291,461-468,494-500 | `box.tcolorbox` | inside the way: options string TeaserHeaderOptions / ContinuedArticleHeaderOptions (`breakable`, `boxrule=0pt`, `arc=0pt`, `colbacktitle=black`, `coltitle=white`, `toptitle=2mm`, `bottomtitle=2mm`), passed by `\pgfkeysalsofrom` |
| list-of machinery | jumplines.sty:41,121,122 | `toc.tocloft` | inside the way: `\newlistof{article}`, `\newlistof{contarticle}` |
| "continued" notes and links | jumplines.sty:470-473,482,495,502-503 | `xref.kernel` | inside the way: `\label`, `\pageref`, `\hypertarget` for the forward and backward links |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `jumplines.sty` (whole package) | jumplines.sty:1-562 | not bespoke: published | CTAN package (https://ctan.org/pkg/jumplines); one way `news.jumplines`. Its `\vsplit` box split (:333), box lists (:311-317) and key handlers are the published package's own code, not zip-local code. |
| `\myquotes` | jumplines_doc.tex:34; jumplines_example.tex:32 | yes | alias of `\enquote` (`lang.csquotes`): write `\enquote{...}` at each use (doc:190) |
| `\newcolumntype{C}` | jumplines_doc.tex:40 | yes | `tbl.tabular` column spec `>{\centering\arraybackslash}p{0.7\textwidth}` written inline (`sp.ragged` `\centering`) |
| `\tcolorboxdoclink`, `\PackageDocName`, `\packageversion` | jumplines_doc.tex:46,59,55 | yes | text strings: expand inline (a URL for `\href`, a name, `0.2`) |
| `\packagename` | jumplines_doc.tex:47 | yes | `\fbox{\textcolor{blue}{\textbf{\ding{41}~name}}}\index{Package!name}` inline: `box.fancybox`, `color.xcolor`, `mark.kernel`, `font.icons`, `idx.makeidx` |
| `\classname` | jumplines_doc.tex:48 | yes (never called) | same shape with `\Writinghand`, brown; unused, so nothing to emit |
| `\handrightnote` | jumplines_doc.tex:50 | yes (never called) | alias of `\tcbdocmarginnote{\ding{43}}`; unused |
| `docCommandArgs` environment | jumplines_doc.tex:52 | yes | `\newtcolorbox` with `colbacktitle=blue`, `coltitle=white`, `title={Description of arguments of command \cs{#1}}` (`box.tcolorbox`, `dtx.doc`) |
| `\makeatletter` around an e-mail address | jumplines_doc.tex:92-95,266 | yes | kernel catcode toggle with no printed effect on the `@` sign in text; drop it |
| `savesym`, `\savesymbol{Cross}` | jumplines_doc.tex:25,27 | yes | considered: `savesym`; a name-clash fix, `\Cross` is never used (only :27 mentions it), no printed effect, so nothing to emit |

## Content-opaque
- Article bodies (blindtext, red/blue/violet coloured spans, `E=mc^2`, quotation line): content (jumplines_example.tex:44-58; jumplines_doc.tex:115,118).
- Images `example-image-a`, `-b`, `-c` inside articles (jumplines_example.tex:46,52,58): content; the files are not shipped in the zip (TeX Live's `mwe` package supplies them, not read here). Missing assets: ship them when emitting this sample.
- No TikZ, PGF, PSTricks or `picture` anywhere in the zip.

## Lib changes
- New ways proposed: `news.jumplines` `jumplines` (CTAN, TeX Live, MiKTeX, LPPL 1.3, Christian Hupfer, v0.2); engine xe/lua (correct colour inside a split box needs LuaLaTeX, README:24-25; `luacolor` is loaded only under LuaTeX, jumplines.sty:43-49, so pdfLaTeX loads it by the source); `\usepackage[languages=list]{jumplines}`, body `\JumplineArticle[keys][toc text]{content}` (stores the article, `\vsplit` at `TeaserHeight` into a teaser and a continued part, jumplines.sty:320-343), `\ShipoutArticleTeasers`, `\ShipoutArticleHangingArticles`, `\listofarticle`, `\listofcontarticle`; the header bars are tcolorbox keys (TeaserHeaderOptions, ContinuedArticleHeaderOptions), the links and "Continued on page" lines are hyperref and babel strings inside the package. W1: CTAN and TeX Live (https://ctan.org/pkg/jumplines). W2: lengths (TeaserHeight, the skips), strings (ArticleHeadline, ArticleAuthor, BookmarkEntry), colours, booleans (emptyarticleintoc, autobookmark) and tcolorbox key lists, never code. W3: serves any newspaper-style teaser page, not one document. W4: one preamble line plus body wrappers around the article node's content, plus two document-level shipout commands (the teasers first, then the continued parts, doc:124 and example:66-69). Not `cols.cuted` (full-width material in columns), not `box.tcolorbox` (one box, no split and no continuation links), not `toc.tocloft` (list styling only). Constraint on content: no floats inside an article (jumplines_doc.tex:150).
- Considered, not proposed: `savesym` (no printed effect, see Bespoke code).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
