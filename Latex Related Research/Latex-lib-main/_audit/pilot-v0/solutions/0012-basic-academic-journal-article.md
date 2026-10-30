yes

# 0012-basic-academic-journal-article: Basic Academic Journal Article (class `olplainarticle`, after SelfArx)

- Unverified: read from the source, not compiled.
- Source: Source/0012-basic-academic-journal-article/ (origin: https://latextemplates.com/downloads/basic-academic-journal-article.zip; licence: CC-BY-4.0)
- Kind: journal (the hint said misc; this is a single-column journal-style article with a coloured abstract box)
- Lib: v0
- Engine: pdfLaTeX-compatible (inputenc utf8, times/mathptmx, no fontspec; the raw `\usefont{OT1}{phv}{b}{n}` needs psnfss's Helvetica font files, which ship with TeX distributions)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (olplainarticle.cls, 204 lines, read in full; no .sty/.def/.cfg/.clo/.bbx/.cbx present)

## Verdict
Yes. Every package the zip-local class `olplainarticle` loads is a published way, and its own code reduces to compositions of lib ways. The custom `\@maketitle` is a vertical stack of text lines, vskips, one `\colorbox` and `\parbox`es, so it reduces to `front.titling` hooks plus body wrappers. The abstract-capture macro, the `lineno` option and the two bibliography patches only route content or set lengths, and each reduction is written below. There is no artwork and no external tool apart from BibTeX, which is a lib way. The weakest links are the `thebibliography` hook patch with the `\@biblabel` redefinition (cls:130, 198-205) and the `titling` plus `authblk` load order (untested, since nothing is compiled). Both are kernel-level code the emitter prints, not logic it has to invent.

## Blockers
none

## Class setting
- Class: `class.article` options: `fleqn`, `10pt` (main.tex:1). The zip-local `olplainarticle` forwards every option to article (olplainarticle.cls:17) and then `\LoadClass{article}` (cls:19). The only option it handles itself is `lineno` (cls:16); the sample does not use it (main.tex:2 is a comment).
- Class-native vocabulary used: `\author[1]{..}` and `\affil[1]{..}` (authblk, loaded at cls:31), `\keywords{..}` (zip-local, cls:135), `abstract` environment placed in the preamble before `\begin{document}` (zip-local capture, cls:137-146), `\maketitle` (cls:151), `\keywordname` (cls:187, not used in main.tex).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:1; cls:17-19 | `class.article` | options fleqn,10pt |
| type size / paper | main.tex:1; cls:17 | `page.class-options` | 10pt; paper is letter via geometry (next row) |
| display-equation layout | main.tex:1 | `math.eqnumber` | `fleqn` (flush-left displays) |
| page geometry | cls:33-38 | `page.geometry` | left=3cm, right=3cm, top=2.25cm, bottom=2.25cm, headheight=12pt, letterpaper |
| columns | cls:182 | `sp.lengths` | single column (no column way); `\columnsep`=0.55cm is set but inert in one column |
| bottom flush | main.tex:23 | `pg.flush` | `\flushbottom` |
| header/footer | cls:50-62 | `hf.fancyhdr` | `\pagestyle{fancy}`; lhead, chead, rhead, lfoot, cfoot empty; rfoot=`\small\sffamily\bfseries\thepage`; headrulewidth=0pt; footrulewidth=0pt |
| first-page style | main.tex:25; cls:153 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| page X of Y | cls:51, 60 | `pgnum.lastpage` | package loaded; its only use is commented out (cls:60), so no effect |
| text and math font | cls:20-21 | `font.mathptmx` | `times` then `mathptmx` (times also makes Helvetica the sans) |
| input encoding | cls:9 | `font.fontenc-t1` | `inputenc` utf8 only, no `fontenc` |
| sans family | cls:60, 155-169, 189-190 | `font.helvet` | `\sffamily` (phv via times) and raw `\usefont{OT1}{phv}{b}{n}` for author and affiliation fonts |
| font sizes | cls:155, 157, 161, 168, 189-190 | `font.size-commands` | `\fontsize{20}{25}`, `{12}{16}`, `{12}{14}`, `{10}{12}`; `\large`, `\small`, `\footnotesize` |
| microtype | cls:14 | `sp.microtype` | no options; loaded `\AtEndOfClass` |
| language | cls:10 | `lang.babel` | english |
| paragraph spacing | cls:27 | `sp.parskip-pkg` | no options |
| line numbers | cls:15-16, 22-23, 163, 168, 174 | `sp.draft-lineno` | package always loaded; `\linenumbers` only if option `lineno` is given (sample: off); `\nolinenumbers` and `\internallinenumbers` inside the title block |
| colours | cls:29, 185-186 | `color.xcolor` | color1 = RGB 0,0,0 (headings, ABSTRACT label, keywords label, bibliography label); color2 = RGB 182,193,251 (abstract box) |
| title and author data | main.tex:5-10, 24 | `front.maketitle` | `\title`, `\author`, `\maketitle` |
| title block look | cls:151-180 | `front.titling` | reduction of the `\@maketitle` redefinition, see Bespoke code row 3 |
| author block | main.tex:7-10; cls:31, 189-190 | `front.authblk` | `\author[n]`, `\affil[n]`; `\Authfont`=`\fontsize{12}{14}` + phv bold, `\Affilfont`=`\fontsize{10}{12}` + phv bold |
| abstract look | main.tex:14-19; cls:159-170 | `box.fancybox`, `box.minipage` | label line "ABSTRACT" (`\color{color1}\large\sffamily\textbf`) in a `\parbox` of width `\linewidth-2\fboxsep`, `\vskip10pt`, then `\colorbox{color2}` around a same-width `\parbox{\sffamily\small\vskip1ex ...}`. `\colorbox` sits with `\fcolorbox` in `box.fancybox`. |
| keywords | main.tex:12; cls:135, 173-176, 187 | `abs.keywords` | manual line in a same-width `\parbox`: `{\color{color1}Keywords:\hspace*{1em}}` then the list; preceded by `\vskip18pt`, followed by `\vskip25pt` |
| headings: section | cls:67-79, 97; main.tex uses `\section*` | `head.titlesec` | package option `explicit`; numbered: format `\color{color1}\large\sffamily\bfseries`, label `\thesection`, sep 0.5em, code `\MakeUppercase{#1}`; numberless variant (`name=\section,numberless`): empty label, sep 0em, same format and code; spacing `\titlespacing*` 0pc, `3ex plus4pt minus3pt`, 5pt |
| headings: lower levels | cls:80-100; main.tex:60 | `head.titlesec` | subsection: `\sffamily\bfseries`, label `\thesubsection`, 0.5em, `#1`, spacing 0pc, `1.5ex plus1.5pt minus2pt`, 0pt. subsubsection: `\sffamily\small\bfseries\itshape`, 0.5em, spacing 0pc, `2ex plus2.5pt minus1.5pt`, 0pt. paragraph: shape `runin`, `\sffamily\small\bfseries`, label empty, 0em, spacing 0pc, `1.5ex plus2pt minus1pt`, 10pt |
| contents layout | cls:105-124, 192-193 | `toc.titletoc` | `\contentsmargin{0cm}`; section entries `[\tocsep]`, `\small\bfseries\sffamily`, dotless, page right; subsection entries `\small\sffamily` with `\titlerule*[.5pc]{.}`; subsubsection run-in (`\titlecontents*`) `\footnotesize\sffamily`, separator `\ \textbullet\ `; `\tocsep`=1.5pc. In scope although the sample never calls `\tableofcontents`. |
| contents depth | cls:194 | `num.secnumdepth` | `tocdepth`=3 |
| lists | cls:126-127 | `list.enumitem` | loaded with no options; `\setlist{nolistsep}` is commented out; the sample has no list |
| figure float | main.tex:43-48 | `fig.graphicx` | `[ht]`, `\centering`, `\caption`, `\label` (figure body is an `\fbox` placeholder, content) |
| float package | cls:26 | `fig.float` | loaded; the sample uses `[ht]`, not `[H]` |
| captions | cls:40-42; main.tex:46, 57 | `cap.caption`, `cap.kernel` | labelfont={bf,sf}, labelsep=period, justification=raggedright; table caption written after the tabular |
| table | main.tex:50-58 | `tbl.tabular` | `l|r`, `\hline`, `\centering`, `[ht]` |
| booktabs | cls:30 | `tbl.booktabs` | loaded; the sample table uses `\hline`, not the booktabs rules |
| math | cls:28; main.tex:62-67 | `math.amsmath`, `math.amssymb` | amsmath (`\text`), amsfonts, amssymb; display math written `$$...$$` |
| frame rule | cls:183; main.tex:45 | `box.fancybox` | `\fboxrule`=0.75pt (the comment says abstract border, but the abstract uses `\colorbox`, so it only affects `\fbox`) |
| cross-references | main.tex:39, 47, 57 | `xref.kernel` | `\label`, `\ref`; hyperref is not loaded |
| citations | cls:44; main.tex:31 | `bib.natbib` | package defaults; `\citep` |
| bibliography data and style | cls:45; main.tex:81; references.bib | `bib.bibtex-bst` | `\bibliographystyle{apalike}`; `\bibliography{references}` |
| bibliography label hook | cls:130 | `bib.thebibliography` | `\renewcommand{\@biblabel}[1]{\bfseries\color{color1}\textsuperscript{[#1]}}`. Whether this changes the printed list under natbib's author-year mode was not established (natbib's source not read). It is mapped to the nearest home, the kernel `thebibliography` environment and its hooks. |
| bibliography list wrapper | cls:198-205 | `toc.kernel`, `sp.lengths` | begin-hook of `thebibliography`: `\addcontentsline{toc}{section}{\hspace*{-\tocsep}\refname}`, then `\itemsep`=0pt, `\parindent`=0pt, `\parskip`=`\baselineskip` (see Bespoke code) |
| plumbing and filler packages | cls:12, 13, 25, 196 | none | `ifthen`, `calc`, `ifpdf` are never used by a visible command here; `lipsum` only supplies dummy text. No layout effect, nothing to emit. |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| the class `olplainarticle` | cls:1-205 | yes | `class.article` (options passed through) plus the ways in the map, emitted in the class's own load order; `\DeclareOption*`/`\ProcessOptions*` (cls:17-18) is plumbing |
| `\newif\if@reqslineno`, `\DeclareOption{lineno}` | cls:15-16 | yes | an emit-time boolean. True: `\linenumbers` (cls:23), `\nolinenumbers` before the abstract box (cls:163), `\internallinenumbers` inside the abstract and keyword parboxes (cls:168, 174); all `sp.draft-lineno`. False (the sample): nothing. |
| `\renewcommand{\@maketitle}` | cls:151-180 | yes | `front.titling` plus body wrappers. Title: `\droptitle`=-36pt (cls:154), `\pretitle`/`\posttitle` = `\raggedright\sffamily\bfseries\fontsize{20}{25}\selectfont`, `\par`, `\vskip10pt` (cls:155-156). Authors: `\preauthor`/`\postauthor` = `\raggedright\sffamily\fontsize{12}{16}\selectfont`, `\par`, `\vskip18pt` (cls:157-158); authblk prints names and affiliations. No date is printed, so `\predate`/`\postdate` empty. Then the abstract label, abstract box and keywords line as in the map, closed by `\vskip25pt` (cls:178). Load order of `titling` and `authblk` and the exact spacing are untested. If they clash, the same block can be laid out directly in the body with the same fonts, since text is content. |
| `\long\def\abstract#1\end#2{...}`, `\theabstract`, `\go`, `\xabstract` | cls:137-146 | yes | Only stores the abstract so `\@maketitle` can print it later, and prints an error text if `\begin`/`\end` appear inside. It sets no look. The emitter writes the abstract node directly into the wrapper from the map, so none of this code is copied. |
| `\newcommand{\keywords}`, `\def\@keywords`, `\newcommand{\keywordname}` | cls:135, 187 | yes | a string ("Keywords:") and the keyword text, inlined in the keywords wrapper |
| `\newlength{\tocsep}`, `\setlength\tocsep{1.5pc}` | cls:192-193 | yes | the literal 1.5pc inlined in the `\titlecontents` calls and in `\hspace*{-\tocsep}` (or the same `\newlength` printed as is); `sp.lengths` |
| `\renewcommand{\@biblabel}` | cls:130 | yes | one-line redefinition of a kernel hook, a format of font, colour and superscript; printed as is under `bib.thebibliography` |
| `\let\oldbibliography\thebibliography`, `\renewcommand{\thebibliography}[1]{...}` | cls:198-205 | yes | the whole effect is one `\addcontentsline` and three length assignments (`toc.kernel`, `sp.lengths`). The emitter prints the same hook patch; no conditionals, counters or computed layout. natbib's documented `\bibsep` and `\bibfont` are the published route for the item gap and font. |
| `\@plus`/`\@minus` in `\titlespacing*` | cls:97-100 | yes | written as `plus`/`minus` in the emitter's `head.titlesec` calls |

## Content-opaque
- Placeholder figure body `\fbox{\rule{0pt}{3cm}\rule{0.7\linewidth}{0pt}}` (main.tex:45); table cell text (main.tex:52-56); display equation (main.tex:62-67); bibliography entry (references.bib:1-9). None is template-defining artwork, and no TikZ or PGF appears anywhere.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Mapping notes for the consolidator (not proposals): `bib.thebibliography` is described in the lib as "hand-written"; here it holds customisation of the kernel environment's hooks (`\@biblabel`, a `\thebibliography` begin-hook) for a BibTeX-generated list. `\colorbox` is filed under `box.fancybox` next to `\fcolorbox`. `\addcontentsline` is filed under `toc.kernel` (`tocbibind`, in `toc.etoc`, is the package alternative).
