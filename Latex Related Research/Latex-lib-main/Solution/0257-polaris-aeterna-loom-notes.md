no

# 0257-polaris-aeterna-loom-notes: Loom, a woven notebook class for fill-in study notes

- Unverified: read from the source, not compiled.
- Source: Source/0257-polaris-aeterna-loom-notes/ (origin: https://codeload.github.com/Polaris-Aeterna/loom-notes/zip/refs/heads/main; licence: manifest says NOASSERTION, the LICENSE file itself reads MIT, LICENSE:1)
- Kind: misc (fill-in study-notes notebook class plus seven example notebooks)
- Lib: v3
- Engine: needs XeLaTeX (`libertinus-otf` loads fontspec + unicode-math, loom.cls:41; `xeCJK`, loom.cls:50; macOS system fonts Optima, Avenir Next, Menlo, Songti SC, loom.cls:43-46,51)
- Look carried by: zip-local (all of the look is in `loom.cls`; the sample adds two `\newcommand` math shorthands and content, template/main.tex:10-11,13)
- Class origin: zip-local
- Main file: template/main.tex (other samples: examples/{concentration-of-measure,demo,entropy,fourier-transform,gradient-descent,nonlinear-algebra,svd}/main.tex, overleaf/classico/main.tex, overleaf/libertinus/main.tex)
- Read: main yes, zip-local classes and styles all (root `loom.cls` in full; the nine other copies at template/, examples/*/ are byte-identical to it by md5; `overleaf/libertinus/loom.cls` read as a full diff against the root class; `overleaf/classico/loom.cls`, `loom-rail.tex`, `loom-emblem.tex` in full; example section files read in part: examples/svd/sections/01-geometry.tex and examples/nonlinear-algebra/sections/01-ideals.tex in full, the rest by grep for constructs)

## Verdict
No. The class is zip-local, and although most of it reduces to published packages (geometry, titlesec, amsthm, tcolorbox, fancyhdr, marginnote, enumitem, tabularx, booktabs, hyperref, fontspec, xeCJK), its identity is hand-drawn TikZ: a woven-tile glyph that sits in every section number, every theorem-like box and the proof end mark, a procedurally generated cover emblem, a page-background rail, and a drawn warmth gauge. Those are `ART` with no declarative lib way, and the emblem and the gauge are also loop-and-conditional code that computes what is printed.

## Blockers
- `ART/class` woven-tile glyph `\loomtile` (TikZ rectangles) drawn inside the section-number label, the three theorem box skins, the proof end mark and `\weaveid` (loom.cls:99-105 used at loom.cls:145, 198-207, 217, 222)
- `ART/class` cover emblem `\weaveemblem`, an 8x8 tri-colour plain-weave drawn procedurally and placed by `\loomcover` (loom.cls:108-123, 274)
- `ART/class` page-background selvage rail: linen band plus four hairlines painted on every page with `\AddToShipoutPictureBG` and a `remember picture` TikZ overlay, switched on by `\loomcover` / `\weave` (loom.cls:126-136, 291, 294)
- `ART/class` hand-drawn glyphs in body commands: snake-line `\looseglyph` inside `\loose` (loom.cls:242-246) and the five-square `\warmth{n}` gauge (loom.cls:249-256), both used in the main sample (template/main.tex:24, 74, 76)
- `BESPOKE/class` `\weaveemblem` computes the weave with `pgfmath` `mod`, `\def\wcolor`, `\ifnum\warpover=1` over a nested `\foreach` (loom.cls:113-121); `\warmth` chooses outlined or filled squares with `\foreach` + `\ifnum\i>#1` (loom.cls:250-255). Counter- and conditional-driven printing, not a composition of lib ways.
- `BESPOKE/preamble` `\enpunct` in the classico sample: expl3 `\regex_replace_all` rewrites Chinese punctuation inside the document body (overleaf/classico/main.tex:4-11, used at 36, 60). Secondary sample only; the main sample has no such code.

No `EXTERNAL` blocker: nothing in the class needs shell escape, biber, pygments or another tool (packages loaded at loom.cls:41-42, 50, 58, 69-79, 259, 301-303). Not blockers, recorded: macOS-only fonts Optima / Avenir Next / Menlo / Songti SC are not shipped (loom.cls:43-46, 51); the classico edition needs four URW Classico `.otf` files the user supplies (overleaf/classico/fonts/README.md:11-18).

## Class setting
- Class: `class.article` (reached through the zip-local `loom`, `\LoadClass[11pt]{article}` at loom.cls:28; unknown options are passed on to article, loom.cls:26). Options of `loom` itself: `cjk` (loom.cls:24), `letter` (loom.cls:25); the sample uses `cjk` (template/main.tex:7).
- Class-native vocabulary used: article's `\section`, `\subsection`, `\section*`, `\tableofcontents`, `titlepage` environment (used inside `\loomcover`, loom.cls:272), `\today`, `\clearpage`. Everything else the sample calls (`\loomcover`, `\runningthread`, `\warmth`, `\block`, `\trigger`, `strand`, `yourturn`, `\fillin`, `\TODO`, `\recall`, `\loose`, `\warp`, `\pick`, `\workspace`) is zip-local, not published vocabulary, and is listed under Bespoke code.

## Component map
All loom.cls lines are the root file; template/, examples/*/ hold byte-identical copies.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | loom.cls:28 | `class.article` | 11pt |
| paper and margins | loom.cls:31-38 | `page.geometry` | a4paper (letterpaper with option `letter`), top=2.0cm, bottom=2.3cm, left=2.9cm, right=3.1cm, marginparwidth=2.35cm, marginparsep=0.35cm, headsep=14pt |
| main text and math face | loom.cls:41 | `font.libertine` | `libertinus-otf` (text and math) |
| math font engine | loom.cls:41 | `font.unicode-math` | pulled in by `libertinus-otf`; `amssymb` deliberately not loaded (loom.cls:69) |
| display, voice, label faces | loom.cls:43-45 | `font.fontspec` | `\newfontfamily` `\headingfont`=Optima, `\strandfont`=Avenir Next, `\labelfont`=Avenir Next Condensed |
| mono face | loom.cls:46 | `font.fontspec` | `\setmonofont{Menlo}[Scale=0.86]` |
| heading letter-spacing | loom.cls:142 | `font.fontspec` | `\addfontfeatures{LetterSpace=3.0}` |
| font sizes | loom.cls:141, 276 | `font.size-commands` | `\fontsize{15}{18}` headings, `\fontsize{32}{36}` cover title |
| microtypography | loom.cls:42 | `sp.microtype` | defaults |
| line spacing | loom.cls:47 | `sp.linespread` | 1.06 |
| Chinese text | loom.cls:49-55 | `lang.cjk` | xeCJK, `\setCJKmainfont{Songti SC}[ItalicFont={Kaiti SC}]`, sans/mono PingFang SC, `CJKmath=true`; only with option `cjk` |
| palette | loom.cls:58-66 | `color.xcolor` | HTML inkiron 211C17, indigo 27406B, madder 9C2B2E, weld BE8A20, linen F5EFE2, thread C7BBA1, selvage 8A7F6B; default text colour `\color{inkiron}` |
| display maths | loom.cls:69; examples/svd/main.tex:14-19 | `math.amsmath` | `\DeclareMathOperator`, `aligned`, `pmatrix` in sections |
| maths tools | loom.cls:69 | `math.mathtools` | defaults (classico: `overload`, overleaf/classico/loom.cls:38) |
| footer | loom.cls:79, 82-86 | `hf.fancyhdr` | `\pagestyle{fancy}\fancyhf{}`, head and foot rules 0pt, `\fancyfoot[R]` page number, `\fancyfoot[L]` lowercased `\loom@runtitle`, `\strandfont\footnotesize\color{selvage}` |
| running title string | loom.cls:87-88; template/main.tex:13 | `hf.fancyhdr` | `\runningthread{text}` only stores a string for the footer field |
| paragraph shape | loom.cls:91-92 | `sp.lengths` | `\parindent`=0pt, `\parskip`=0.45em plus 0.2em minus 0.1em (classico: `\parindent`=2em, overleaf/classico/loom.cls:179) |
| section heading | loom.cls:143-149 | `head.titlesec` | `\titleformat{\section}[block]`, label `\textcolor{selvage}{\thesection}` after a hanging tile (ART), before-code `\MakeUppercase`, after-code `\vspace{1pt}` + madder rule; `\titlespacing*` 0pt / 20pt plus 4pt / 8pt |
| heading rule | loom.cls:148 | `sp.rule` | `\rule{\linewidth}{1.1pt}`, colour madder |
| subsection, subsubsection | loom.cls:151-159 | `head.titlesec` | both `[runin]`; subsection `\headingfont\bfseries\color{madder}`, label sep 0.55em; subsubsection `\strandfont\bfseries\color{indigo}`, no label |
| starred section in toc | examples/svd/main.tex:32-33 | `toc.kernel` | `\section*` + `\addcontentsline{toc}{section}{...}` |
| table of contents | examples/svd/main.tex:73 | `toc.kernel` | `{\small\tableofcontents}`, no restyling package |
| theorem heads | loom.cls:70, 164-175 | `thm.amsthm` | `\newtheoremstyle` x4: loomplain (indigo), loomdefn (madder), loomexm (weld!75!inkiron), loomrem (madder italic); above/below 6pt, body `\normalfont`, indent 0pt, head font `\headingfont\bfseries`, punct `.`, space 0.5em, note `\thmnote{ \normalfont\itshape(#3)}` |
| theorem list and counters | loom.cls:177-188 | `thm.amsthm` | `\newtheorem` theorem, lemma, proposition, corollary, definition, example, remark, remark* |
| theorem numbering | loom.cls:178-185 | `num.counters` | theorem numbered `[section]`; lemma, proposition, corollary, definition, example share the theorem counter |
| theorem box skins | loom.cls:71-72, 191-214 | `box.tcolorbox` | `[most]`, `skins`, `breakable`; styles `knotcommon` (enhanced, breakable, sharp corners, frame hidden, boxrule=0pt, left=12pt, right=11pt, top=8pt, bottom=8pt, before/after skip 10pt plus 2pt), `knotindigo`/`knotmadder`/`knotweld` (colback, `borderline west`={2.2pt}{0pt}{colour}); wrapped onto the amsthm environments with `\tcolorboxenvironment`; the corner tile overlay is ART |
| proof head and mark | loom.cls:217-218 | `thm.amsthm` | `\proofname` set to `\normalfont\headingfont\itshape\color{selvage}Proof`; `\qedsymbol` = `\loomtile{inkiron}` (ART) |
| `strand` intuition box | loom.cls:228-233 | `box.tcolorbox` | `\newtcolorbox`: colback `indigo!4`, `borderline west`={1.6pt}{0pt}{indigo!55}, left=11pt, right=9pt, top=6pt, bottom=6pt, before/after skip 8pt, `fontupper=\strandfont\small\color{inkiron!92!white}` |
| `yourturn` box | loom.cls:325-328 | `box.tcolorbox` | colback `weld!9!linen`, `borderline west`={2pt}{0pt}{weld}, insets 11/10/7/8pt, skips 9pt, `before upper` fixed label "Your turn." |
| inline voices | loom.cls:235-236, 307-315 | `mark.kernel` | `\whisper` (`\strandfont\small\color{indigo!78!black}`), `\keyword` (`\bfseries\color{madder}`), `\block` (`\headingfont\bfseries\color{indigo}` + `\medskip`/`\smallskip`), `\trigger` (madder "Trigger." label), `\TODO` (`[ fill in: ... ]`, madder) |
| blanks | loom.cls:318; template/main.tex:50 | `sp.manual-space` | `\fillin[w]` = `\,\underline{\hspace{w}}\,`, default 2.2cm |
| ruled writing lines | loom.cls:331-332; template/main.tex:66 | `sp.rule` | `\workspace[n]`: n repeats of `\rule{\linewidth}{0.3pt}` in `thread` plus `\vspace{9pt}` (loop from pgffor, but the output is n fixed rules) |
| margin prompts and threads | loom.cls:75, 245-246, 262-263, 321-322 | `note.marginnote` | `\recall`, `\loose`, `\warp` call `\marginnote{\raggedright\strandfont\footnotesize|\scriptsize\color{...}...}` (the snake glyph in `\loose` is ART) |
| ragged margin notes | loom.cls:245, 321 | `sp.ragged` | `\raggedright` |
| thread cross-reference | loom.cls:259, 262, 264 | `xref.hyperref` | `\phantomsection\label{warp:key}` and `\hyperref[warp:key]{...}` |
| labels and refs in body | examples/svd/main.tex:53, examples/svd/sections/01-geometry.tex:2 | `xref.kernel` | `\label`, `\ref` |
| hyperlinks | loom.cls:259-261 | `meta.hyperref` | `colorlinks=true, linkcolor=indigo, citecolor=madder, urlcolor=indigo, pdfborder={0 0 0}` |
| lists | loom.cls:73; examples/svd/main.tex:65; examples/nonlinear-algebra/sections/01-ideals.tex:31 | `list.enumitem` | `itemize [leftmargin=1.3em,itemsep=1pt]`, `enumerate [label=(\alph*),leftmargin=2em,itemsep=0pt]` |
| cheat-sheet table | template/main.tex:36-44; loom.cls:301-304 | `tbl.tabularx` | `tabularx{\linewidth}{@{}l l L@{}}`, `\newcolumntype{L}{>{\raggedright\arraybackslash}X}` |
| table rules | template/main.tex:38,40,43; loom.cls:301 | `tbl.booktabs` | `\toprule \midrule \bottomrule` |
| column spec and header cells | loom.cls:303; template/main.tex:39 | `tbl.tabular` | `array`, `\multicolumn{1}{l}{\color{indigo}...}` |
| cover page | loom.cls:271-291; template/main.tex:17-21 | `front.titlepage-env` | `titlepage`, `\thispagestyle{empty}`, `\centering`, `\vspace*{2.0cm}`, title 32/36pt indigo with LetterSpace=1.0, madder rule 4.2cm x 1.1pt, subtitle `\large`, `\vfill`, author, date, a fixed colophon line; the emblem inside is ART |
| page-background rail | loom.cls:76, 126-136 | `bg.eso-pic` | `\AddToShipoutPictureBG` with a TikZ overlay (identity artwork, see Blockers) |
| tile, emblem, gauge, snake glyph | loom.cls:77, 99-123, 242-256 | `art.tikz` | `\usetikzlibrary{calc,decorations.pathmorphing}`; template-defining artwork (ART) |
| loaded, never called | loom.cls:74 | `pg.needspace` | `\RequirePackage{needspace}`; no `\needspace` anywhere in loom.cls |
| page breaks in samples | examples/svd/main.tex:72,75 | `pg.break` | `\clearpage` |
| classico emblem and rail images | overleaf/classico/loom-emblem.tex:1; overleaf/classico/loom-rail.tex:3 | `fig.graphicx` | `\includegraphics[width=132pt]{figure/my-emblem.pdf}`; rail `rail.pdf` at width 0.5cm, height paperheight-3.9cm (placed through a TikZ page node, so still ART) |
| classico font files | overleaf/classico/loom.cls:45-52 | `font.fontspec` | `\setmainfont{URWClassico}[Path=fonts/, Extension=.otf, ...]` (files not shipped) |
| libertinus edition faces | overleaf/libertinus/loom.cls:57-59 | `font.fontspec` | `\headingfont`, `\strandfont`, `\labelfont` all become `\sffamily` of `libertinus-otf` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newif` + `\DeclareOption` for `cjk`, `letter` | loom.cls:22-27 | yes | choose `page.geometry` paper key and include or omit `lang.cjk` |
| `\runningthread`, `\loom@runtitle` | loom.cls:86-88 | yes | string written into `hf.fancyhdr` left foot |
| `\sectionheadfont`, section/subsection format | loom.cls:141-159 | yes | `head.titlesec` parameters above (tile in label is separate) |
| theorem styles, `\newtheorem`, knot skins | loom.cls:164-214 | yes, except the tile overlay | `thm.amsthm` + `box.tcolorbox`; overlay `\loomtile` node is ART |
| `\loomtile` | loom.cls:99-105 | no | TikZ drawing, ART/class; reused at loom.cls:145, 198-207, 217, 222 |
| `\weaveemblem` | loom.cls:108-123 | no | procedural pgfmath/`\foreach`/`\ifnum` drawing, BESPOKE+ART/class |
| `\loomrail`, `\weave` | loom.cls:126-136, 294 | no | page-background TikZ painting, ART/class; state switch called from `\loomcover` |
| `\weaveid` | loom.cls:221-223 | no | built on `\loomtile`; not called by any sample |
| `strand`, `yourturn` | loom.cls:228-233, 325-328 | yes | `box.tcolorbox` parameters above |
| `\whisper`, `\keyword`, `\block`, `\trigger`, `\TODO`, `\fillin` | loom.cls:235-236, 307-318 | yes | `mark.kernel`, `sp.manual-space`, `color.xcolor` aliases |
| `\workspace[n]` | loom.cls:331-332 | yes | emitter writes n rules and spaces (`sp.rule`, `sp.manual-space`) |
| `\recall`, `\warp`, `\pick` | loom.cls:262-265, 321-322 | yes | `note.marginnote`, `xref.hyperref`, `xref.kernel` |
| `\loose` | loom.cls:245-246 | no | the margin note is reducible, its `\looseglyph` (loom.cls:242-243, snake decoration) is ART |
| `\warmth{n}` | loom.cls:249-256 | no | `\foreach`/`\ifnum` choosing filled or outlined TikZ squares, BESPOKE+ART/class |
| `\loomcover` | loom.cls:271-291 | partly | page layout reduces to `front.titlepage-env`; emblem and rail activation do not |
| `\newcolumntype{L}` | loom.cls:304 | yes | `tbl.tabularx` with `array` |
| per-document math shorthands | template/main.tex:10-11 | yes | `\newcommand` aliases of `\mathbb`, content-level macros |
| classico `\maketitle` redefinition via `\@title`, `\@author`, `\@date` | overleaf/classico/loom.cls:138-167 | yes | same cover as `\loomcover` through `front.titlepage-env` (emblem still ART) |
| classico `\IfFileExists` / `\IfFontExistsTF` chains for emblem, rail, CJK fonts | overleaf/classico/loom.cls:91-103, 123-134, 184-202 | yes (asset selection) | emitter picks one branch; the placeholder and fallback branches are TikZ (ART) |
| classico `\enpunct` (expl3 regex) | overleaf/classico/main.tex:4-11 | no | text-rewriting code run in the document, BESPOKE/preamble |

## Content-opaque
none (the main sample has no figure or table-float artwork; example mains show only `pmatrix` and `aligned` maths, which are `math.amsmath` content)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

Notes: `loom` is a personal GitHub repo release, not an organisation or publisher kit, and https://ctan.org/pkg/loom returned 404, so it is zip-local by W1; the only published class it builds on is `article` (loom.cls:28). skill/SKILL.md and skill/reference/*.md are instructions for an AI assistant that writes Loom notes; they were read as data and not acted on. The README's "Every cover carries a procedurally-woven emblem" (README.md:37-38) matches the `\weaveemblem` blocker above. Nothing here was compiled.
