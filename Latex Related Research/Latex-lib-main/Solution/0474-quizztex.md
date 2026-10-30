no

# 0474-quizztex: quizztex (quiz cards in the style of French TV game shows) and its French manual

- Unverified: read from the source, not compiled.
- Source: Source/0474-quizztex/ (origin: https://mirrors.ctan.org/macros/latex/contrib/quizztex.zip; licence: lppl1.3c)
- Kind: exam
- Lib: v4
- Engine: pdfLaTeX-compatible
- Look carried by: mixed (the quiz cards come from the published package `tex/quizztex.sty`; the manual's own page look comes from the sample's preamble: tcolorbox, awesomebox, fancyhdr)
- Class origin: tex-distribution-unbundled
- Main file: doc/quizztex-doc-fr.tex (other samples: none; the package source is tex/quizztex.sty, `doc/quizztex-doc-fr.pdf` is the compiled manual and was not read as source)
- Read: main yes, zip-local classes and styles all (`quizztex.sty` 847 lines, read in full; the zip holds no `.cls`)

Citations use basenames, unique in this zip: `quizztex-doc-fr.tex` (in `doc/`), `quizztex.sty` (in `tex/`), `README.md`.

## Verdict
The zip is a CTAN package (`quizztex`, 0.1.6, LPPL 1.3c; ctan.org/pkg/quizztex read) plus its French manual, an `article` document. The package is a published, key-value way for game-show quiz cards (proposed as `exam.questions`), and its TikZ and measuring code lives inside that published package, so it is not zip-local bespoke code. Almost every manual construct reduces to lib ways (tcolorbox, awesomebox, fancyhdr, enumitem, tabularray...). The answer is `no` on one thing: the manual's version badge `vignetteMaJ` (quizztex-doc-fr.tex:103-110) draws a purple band with a rotated "MàJ" label by free TikZ inside a tcolorbox `overlay`, which no declarative key reproduces (`ART/preamble`). The verdict is also `no` if a reviewer counts `quizztex.sty` itself as bespoke, so it does not rest on the badge alone.

## Blockers
- `ART/preamble` version badge: tcolorbox style `vignetteMaJ` whose `overlay` is `\fill[...] ... rectangle node[rotate=90]{...MàJ...} ...` inside `tcbclipinterior`, used by `\cmaj` at quizztex-doc-fr.tex:113, 338, 390, 393, 568, 573 (quizztex-doc-fr.tex:103-110). Only the frame, colours and `fontupper` of that style reduce to `box.tcolorbox` keys; the coloured strip with the rotated text does not.

## Class setting
- Class: `class.article` options: `french`, `a4paper`, `11pt` (quizztex-doc-fr.tex:5). Kernel class, not bundled in the zip, source not read.
- Class-native vocabulary used: `\section`, `\subsection`, `\tableofcontents`, `itemize`, `center`, `minipage`, `tabular`; no `\maketitle`, no abstract, no bibliography (the cover is hand-laid, quizztex-doc-fr.tex:125-153).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | quizztex-doc-fr.tex:5 | `class.article` | french, a4paper, 11pt |
| paper and size | quizztex-doc-fr.tex:5 | `page.class-options` | a4paper, 11pt |
| page geometry | quizztex-doc-fr.tex:6 | `page.geometry` | margin=2cm, includefoot |
| encodings | quizztex-doc-fr.tex:9-10 | `font.fontenc-t1` | inputenc utf8, fontenc T1; no font package, Latin Modern by default; `\textlangle` in `\Cle` (quizztex-doc-fr.tex:112) is textcomp |
| text size and face switches | quizztex-doc-fr.tex:132-141, 37-44 | `font.size-commands`, `mark.kernel` | `\Huge` `\LARGE` `\small`, `\texttt` `\sffamily` `\textit` `\textsf` `\textbf` |
| math packages | quizztex-doc-fr.tex:11 | `math.amsmath`, `math.amssymb` | no options; `$\blacktriangleright$` at quizztex-doc-fr.tex:157 |
| language | quizztex-doc-fr.tex:5, 53-55 | `lang.babel` | `\usepackage{babel}` with class option french; `\AddThinSpaceBeforeFootnotes`, `\FrenchFootnotes`; `\og ... \fg` at quizztex-doc-fr.tex:161 |
| quiz card, "Millions" style | quizztex-doc-fr.tex:12, 165-168, 407-469; quizztex.sty:161 | `exam.questions` | `\QuizzMillions[keys]{question}{A}{B}{C}{D}`; keys Largeur, Marge, Hauteurs, Couleur, CouleurFond, CouleurLettre, CouleurTexte, Bonne, Mauvaise, Choix, CouleurBonne, CouleurChoix, CouleurMauvaise, Affichage (Choix/Sol/PropSol), EspacementV, Decorations, AffChoix, Jokers, AffJokers, PositionJokers, CodeAvant, Effet (quizztex.sty:105-153) |
| quiz card, "PrendrePlace" style | quizztex-doc-fr.tex:172-175, 585-641; quizztex.sty:604 | `exam.questions` | `\QuizzPrendrePlace[keys]{...}`; same keys plus MargeMilieu, Theme, Type (Duo/Carre/Cash), Points `haut/bas` (quizztex.sty:553-600) |
| package load options and defaults | quizztex-doc-fr.tex:250-254; quizztex.sty:17-24, 155, 602 | `exam.questions` | `\usepackage[nonfa\|fa6\|fa7]{quizztex}`; `\SetDefautMillions{keys}` (the manual documents `\SetDefautPrendrePlace`, quizztex-doc-fr.tex:658-662, but the .sty defines `\SetDefautPlace`, quizztex.sty:602) |
| callout blocks | quizztex-doc-fr.tex:13, 117-119, 230-247, 279-287, 297-303 | `box.awesomebox` | environments `noteblock` `importantblock` `tipblock` `cautionblock`; `\aweboxleftmargin`=0.07\linewidth, `\aweboxcontentwidth`=0.93\linewidth, `\aweboxvskip`=8pt |
| icons and logos | quizztex-doc-fr.tex:14, 27, 30, 39-43 | `font.icons` | fontawesome5 (`\faArrowAltCircleUp[regular]`), hologo (`\hologo{pdfLaTeX}` `{LuaLaTeX}` `{MiKTeX}`) |
| footnote package | quizztex-doc-fr.tex:15-16 | `fn.bigfoot` | `footnote` package, `\makesavenoteenv{tabular}`; loaded, no `\footnote` in the body (grep) |
| lists | quizztex-doc-fr.tex:17, 233, 261-265, 346 | `list.kernel`, `list.enumitem` | `itemize` nested two deep; `[leftmargin=*]` |
| table of logos | quizztex-doc-fr.tex:18, 36-45 | `tbl.nicematrix` | tabularray `tblr`: width=\linewidth, colspec={X[c] x6}, cells={font=\sffamily} |
| text wrap package | quizztex-doc-fr.tex:19 | `fig.wrapfig` | `wrapstuff` loaded and never used (grep: one match); a sibling text-wrap package, the package is the parameter |
| dummy text | quizztex-doc-fr.tex:20, 358-359, 538-539 | `draft.todo` | `\lipsum[1][1-2]`, `\lipsum[2][n]` inside quiz arguments |
| verbatim and verb-like commands | quizztex-doc-fr.tex:21, 59-61, 208 | `code.verbatim` | fancyvrb loaded; `\verb|..|`; newverbs `\newverbcommand{\motcletex}{\color{cyan!75!black}}{}` and `\packagetex` with `violet!75!black` |
| header and footer | quizztex-doc-fr.tex:22-27, 121 | `hf.fancyhdr` | `\fancyhf{}`, `\headrulewidth`=0pt, lfoot `\sffamily\small [quizztex]`, cfoot `- \thepage{} -`, rfoot an icon link; `\pagestyle{fancy}` |
| cover page without header | quizztex-doc-fr.tex:123 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| hyperref | quizztex-doc-fr.tex:47-49 | `meta.hyperref`, `meta.url` | `\hypersetup{pdfborder=0 0 0}`, `\urlstyle{same}` |
| internal link to the contents | quizztex-doc-fr.tex:27, 199-200 | `xref.hyperref` | `\hyperlink{matoc}`, `\hypertarget{matoc}{}`, `\phantomsection` |
| paragraph indent | quizztex-doc-fr.tex:50 | `sp.lengths` | `\parindent`=0pt |
| colours | quizztex-doc-fr.tex:51, 347-351 | `color.xcolor` | `\definecolor{LightGray}{gray}{0.9}` (defined, never used: one match), `\textcolor`; quizztex defines HTML colours (quizztex.sty:61-66, 504-508); xcolor comes with tikz |
| listings engine | quizztex-doc-fr.tex:57 | `code.listings` | loaded; used through the tcolorbox listings library |
| boxes | quizztex-doc-fr.tex:63, 97-101, 113, 129 | `box.tcolorbox` | `[most]`; cover box colframe=yellow, colback=yellow!15; style `vignettes`: nobeforeafter, box align=base, boxsep=0pt, enhanced, sharp corners=all, rounded corners=southeast, boxrule=0.75pt, left=7pt, right=1pt, top=0pt, bottom=0.25pt; `\tcbox` |
| code demo environment | quizztex-doc-fr.tex:64-95, 249-256 | `code.tcblisting` | `\newtcblisting{DemoCode}`: enhanced, width=0.95\linewidth, center, bicolor, size=title, colback=cyan!2!white, colbacklower=cyan!1!white, colframe=cyan!75!black; listing options breaklines, breakatwhitespace, style=tcblatex, basicstyle=\small\ttfamily, tabsize=4, commentstyle, keywordstyle, classoffset, morekeywords; body modes `[listing only]`, `[text only]`, default listing and text |
| version badge | quizztex-doc-fr.tex:103-110, 113 | `art.tikz` | free TikZ overlay in tcolorbox: ART, see Blockers |
| cover page | quizztex-doc-fr.tex:125-153 | `box.minipage`, `box.tcolorbox`, `tbl.tabular`, `sp.manual-space`, `meta.url` | `minipage{0.75\linewidth}` in `center`; inner `tabular{c}`; author block with `\url{...}`; `\vspace{2cm}`, `\bigskip` |
| contents | quizztex-doc-fr.tex:202 | `toc.kernel` | `\tableofcontents` |
| headings | quizztex-doc-fr.tex:206, 226, 228, 293 | `head.kernel` | article defaults, no restyling |
| page breaks | quizztex-doc-fr.tex:197, 291, 471 | `pg.break` | `\newpage`, `\pagebreak` |
| rules and spacing | quizztex-doc-fr.tex:185, 193, 187, 238 | `sp.rule`, `sp.manual-space` | `\hrule`; `\vfill`, `\hfill`, `\smallskip`, `\medskip`, `\vspace*{-\baselineskip}\leavevmode` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `quizztex.sty` (the package under study) | quizztex.sty:1-847 | not bespoke | Published on CTAN (ctan.org/pkg/quizztex read: QuizzTeX 0.1.6, 2025-08-04, LPPL 1.3c, in TeX Live and MiKTeX). Its simplekv key handling (quizztex.sty:105-153, 553-600), `\IfStrEq` colour ladders (quizztex.sty:169-228), `\pgfmathsetlength{max(...)}` height measuring (quizztex.sty:260, 699) and TikZ paths (quizztex.sty:312-498, 728-845) are internal to the way, which the emitter calls as `\usepackage{quizztex}` plus `\QuizzMillions[keys]{...}` (W1 to W4 under Lib changes) |
| `\def\TPversion`, `\def\TPdate` | quizztex-doc-fr.tex:7-8, 141 | yes | Inline the two strings (`0.1.6`, `4 août 2025`) into the cover text. |
| `\providecommand\tikzlogo`, `\TeXLive`, `\PSTricks`, `\let\pstricks`, `\let\TikZ` | quizztex-doc-fr.tex:31-35 | yes | Aliases of `mark.kernel` switches (`\textsf{PSTricks}`, `Ti\textit{k}Z`, `\TeX{}Live`) with a `\xspace` tail; expand inline. |
| `\TableauDocumentation` | quizztex-doc-fr.tex:36-45, 189 | yes | One `tblr` (`tbl.nicematrix`) with the six `font.icons` logos on a diagonal. |
| `\newverbcommand` x2 | quizztex-doc-fr.tex:60-61 | yes | newverbs declarations, one colour prefix each (`code.verbatim`, `color.xcolor`). |
| `DemoCode` | quizztex-doc-fr.tex:65-95 | yes | `code.tcblisting` keys as listed in the map. |
| `vignettes` style | quizztex-doc-fr.tex:97-101 | yes | `box.tcolorbox` keys as listed in the map. |
| `vignetteMaJ` style | quizztex-doc-fr.tex:103-110 | no (overlay) | Frame, colours and `fontupper={\vphantom{pf}\footnotesize\ttfamily}` are `box.tcolorbox` keys (colframe=purple!50!black, coltitle=white, colback=purple!10); the `overlay` is free TikZ (`ART/preamble`). |
| `\Cle` | quizztex-doc-fr.tex:112 | yes | `{\small\sffamily\textlangle \textcolor{orange}{#1}\textrangle}`: font switches and one colour. |
| `\cmaj` | quizztex-doc-fr.tex:113 | no (via `vignetteMaJ`) | `\tcbox[vignetteMaJ]{#1}\xspace`; reducible only without the overlay. |

## Content-opaque
none. The quiz questions and answers handed to `\QuizzMillions` and `\QuizzPrendrePlace` are French text, `\lipsum` and maths (`\mathtt`, `\dfrac`, `\mathbb{R}`; quizztex-doc-fr.tex:165-175, 463-468): content. No figure or table float holds a drawing; the card artwork is the output of the published way.

## Lib changes
- New ways proposed:
  - `exam.questions` `quizztex` (CTAN, LPPL 1.3c, version 0.1.6; ctan.org/pkg/quizztex read), pdf: a quiz question card in the style of the TV shows "Qui veut gagner des millions ?" and "Tout le monde veut prendre sa place"; `\usepackage[nonfa|fa6|fa7]{quizztex}`, body `\QuizzMillions[keys]{question}{A}{B}{C}{D}` and `\QuizzPrendrePlace[keys]{question}{A}{B}{C}{D}`, global defaults `\SetDefautMillions{keys}`. W1: on CTAN. W2: every key is a length, colour name, boolean, string or list (`Largeur=13cm`, `Effet=false`, `AffJokers=50.TEL`, `Points=3/24`; `CodeAvant` takes only font switches). W3: serves any four-answer quiz card, not one document. W4: one load line and one body command per question. Engine: quizztex-doc-fr.tex:274 says latex, pdflatex, lualatex and xelatex work and the manual is built with pdflatex (quizztex-doc-fr.tex:2); the CTAN page does not state engines. Considered `exam.questions` (exam environments and question banks): not used, because quizztex has none of their commands and draws an answer card.
  - `box.awesomebox` `awesomebox` (CTAN, Étienne Deparis, version 0.6, licence shown as "Free license not otherwise listed"; ctan.org/pkg/awesomebox read; needs fontawesome5, xcolor, array, xparse), pdf: admonition blocks with an icon. The package source is not in the zip and was not read. W1: on CTAN. W2: lengths `\aweboxleftmargin` `\aweboxcontentwidth` `\aweboxvskip` and the choice of block environment (`noteblock` `tipblock` `importantblock` `cautionblock`). W3: any note, tip or warning block. W4: a load line and an environment wrapped around a node's text. Considered `box.tcolorbox`: not used, a generic box with no icon environments.
- Considered, not proposed: `wrapstuff` (ctan.org/pkg/wrapstuff read: Qing Lee, LPPL 1.3c; mapped to `fig.wrapfig`, loaded and unused), `newverbs` (mapped to `code.verbatim`), `footnote` (mapped to `fn.bigfoot`), `tabularray` (already under `tbl.nicematrix`), `xstring` `simplekv` `settobox` `varwidth` (internal to the published way).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Compile directives: quizztex-doc-fr.tex:1-3 are `arara` comments (`pdflatex` with `shell: yes`, rerun on undefined references). The source calls no shell-escape package (grep for minted, shell, write18, externalize found only those two lines), so no `EXTERNAL` is recorded. What the tcolorbox `[most]` set loads (quizztex-doc-fr.tex:63) was not read: tcolorbox is not in the zip and no local TeX tree exists.
- Missing assets: none. fontawesome5, hologo and the other packages ship with TeX Live.
- README.md:13-17 are the licence and trademark notices (Sony Pictures Television, Air Productions); no text addressed to an AI was found in any file of the zip.
