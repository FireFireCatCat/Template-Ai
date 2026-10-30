no

# 0586-texecole: texecole (a French prose-tag document language, as a LuaLaTeX class, with its manual)

- Unverified: read from the source, not compiled.
- Source: Source/0586-texecole/ (origin: https://mirrors.ctan.org/macros/luatex/latex/texecole.zip; ctan.org/pkg/texecole read once: v1.1 of 2026-07-30, author Gerard Dubard; licence: GNU GPL v3 or later)
- Kind: misc (a document-language class; the main sample is its user manual, the examples are teacher worksheets)
- Lib: v5
- Engine: needs LuaLaTeX (texecole.cls:4-9 raises a class error under any other engine; `fontspec`, `unicode-math`, `\directlua`). The manual texecole.tex alone has a pdfLaTeX-compatible preamble (texecole.tex:12-32) although its first line asks for lualatex (texecole.tex:1).
- Look carried by: mixed (the manual's own look is its preamble over `article`, texecole.tex:12-65; the template proper, the `texecole` class, is texecole.cls plus texecole.lua and 35 `texecole-*.lua` modules, and it turns the document body into a program)
- Class origin: ctan (texecole.cls is the CTAN package's own class; the manual uses kernel `article`, not bundled)
- Main file: texecole.tex (other samples: texecole-precharge.tex; exemples/*.tex, 17 files, every one `\documentclass{texecole}`)
- Read: main yes, zip-local classes and styles partly (read in full: texecole.cls, texecole.lua, texecole-style/box/list/img/section/toc/prefetch.lua, texecole-precharge.tex; read in part: texecole-table.lua 120-291, texecole-grid.lua 150-251; outline or grep only: texecole-lecteur.lua, texecole-sympy.lua, texecole-figure/plot/stats/vartab/tree/posedop.lua and the other 18 Lua modules, never opened; examples: basic1.tex in full, analyse3.tex 1-60, the rest by grep)

## Verdict
The manual texecole.tex alone is a plain `article` document and every part of it maps to lib ways (rows "manual" below). The zip's template, though, is the `texecole` class, and it is not recoverable from lib ways. It re-reads the `.tex` source at `\begin{document}`, throws the body at a French-prose parser written in Lua, compiles it to a Lua program with variables, loops and conditionals, runs it, and prints the result (texecole.cls:175-204, texecole.lua:527-814); backslashes in the body are printed as text (texecole.lua:262-263, basic1.tex:15), so the body is not LaTeX. Its computing phrases also start Python/SymPy through `os.execute` under `--shell-escape`, and the zip's own examples use them. A wrong `yes` costs more than a wrong `no`, so the answer is `no`.

## Blockers
- `BESPOKE/class` the class replaces LaTeX's body processing with a Lua transpiler and interpreter; Lua code computes the layout (grid and table-merge inference, posed operations, sign and variation tables, figures from prose). The package is on CTAN, so `class.texecole` passes W1, but its behaviour is a programmed language, not option values (W2) (texecole.cls:175-204; texecole.lua:527-798, 811-814; texecole-lecteur.lua:951-1074)
- `BESPOKE/body` the body language carries aliases with parameters, variables, `pour`/`si`/`tant que` control flow and `#{expr}` interpolation, which drive what is printed (basic1.tex:6-8, 64-87; texecole.tex:262-284, 756-783; compiled at texecole.lua:73-113, 648-703)
- `EXTERNAL/package` calculation phrases (`<Résous>`, `<Factorise>`, `<Dresse>le tableau de variations`...) write `serveur.py` and run Python 3 with SymPy/SciPy through `os.execute`, which needs `--shell-escape` (texecole-sympy.lua:174-200, 329-330; texecole.tex:113-135; analyse3.tex:3; used in algebre2.tex:66, analyse4.tex:34-52). The prefetch starts only when the body contains such phrases (texecole-prefetch.lua:226-228) and the manual says everything except the automatic computations works without Python (texecole.tex:131-135), so the manual alone does not need it; the examples do (their header comments say so, analyse3.tex:3).

## Class setting
- Class: `class.texecole` options: `marges` (mm, one value or `top;right;bottom;left`, default 20), `espacements` (default 2), `police` (default Latin Modern Roman), `math` (Latin Modern Math), `taille` (11), `interligne` (1.0), `tabulation` (8), `hauteur` (8), `decalage` (100), `precision` (-1); unknown options go to `extarticle` (texecole.cls:12-26). The class loads `class.extarticle` with `[\texecole@taille pt, a4paper]` (texecole.cls:33). The samples set `marges`, `taille`, `precision` (basic1.tex:3, analyse3.tex:4).
- Manual class: `class.article` options `11pt,a4paper` (texecole.tex:12).
- Class-native vocabulary used: tag lines `<Affiche un cadre avec ...>{...}`, `<Dresse un tableau [mc, mg] avec des bordures>{...}`, `<Dresse>une liste numérotée{...}`, `<Insère une image avec une largeur de 30 mm, dans le dossier {IMAGES}>{file}`, `<Affiche une grille avec les zones [...]>`, `<section>{..}` `<sous-section>{..}` (texecole-precharge.tex:43,49), style words `gras`, `bleu marine`, `18pt`, `centre`, `section num` and `<page suivante>`, `<3lignes>`, `<tabulation>`, `<note>{..}`, `<exposant>{..}` (basic1.tex:6-8, 62, 114-134), `soit` aliases and variables, `pour`/`si`/`sinon`, `#{expr}`, and the action tags `<Trace>` `<Soit>` `<Résous>` `<Calcule>` `<Factorise>` (analyse3.tex:31-57).

## Component map
Rows marked "manual" are the preamble and body of texecole.tex (the main sample, under `article`). Rows marked "class" are what texecole.cls sets or emits for every document. Rows marked "DSL" are what the body language prints in the examples.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| manual: class | texecole.tex:12 | `class.article` | 11pt, a4paper |
| manual: encoding | texecole.tex:14-15 | `font.fontenc-t1` | fontenc T1, inputenc utf8 |
| manual: language | texecole.tex:16 | `lang.babel` | french |
| manual: page geometry | texecole.tex:17 | `page.geometry` | margin=25mm |
| manual: colours | texecole.tex:18-22 | `color.xcolor` | svgnames; Marine 1F3A5F, FondCode F4F5F7, CadreCode D7DBE0, Accent 8A1C1C |
| manual: maths packages | texecole.tex:23-24 | `math.amsmath`, `math.amssymb` | load only |
| manual: tables | texecole.tex:25-27, 213-222 | `tbl.longtable`, `tbl.booktabs`, `tbl.tabular` | `longtable` with `@{}lll@{}`, `\toprule \midrule \bottomrule` |
| manual: lists | texecole.tex:28, 188, 317 | `list.enumitem` | `itemize[nosep]` |
| manual: code frame | texecole.tex:29, 34-42 | `code.verbatim` | fancyvrb `\DefineVerbatimEnvironment{code}{Verbatim}`: frame=single, framerule=0.4pt, rulecolor, fontsize=\small, xleftmargin=4mm, xrightmargin=4mm, framesep=3mm, formatcom |
| manual: headings | texecole.tex:30, 47-53 | `head.titlesec` | `\titleformat` part (block, \Huge\bfseries\color{Marine}), section (\Large), subsection (\large, Marine!85!black); `\titlespacing*` |
| manual: part and section numbering | texecole.tex:54, 56-57 | `num.secnumdepth`, `num.counters` | tocdepth=2; chngcntr `\counterwithin*{section}{part}` |
| manual: paragraph shape | texecole.tex:59-60 | `sp.lengths` | parindent=0pt, parskip=0.55em |
| manual: links and metadata | texecole.tex:32, 62-65 | `meta.hyperref` | colorlinks, linkcolor and urlcolor Marine, pdftitle, pdfauthor |
| manual: title page | texecole.tex:69-84 | `front.titlepage-env`, `font.size-commands`, `sp.manual-space` | `titlepage` env, `\centering`, `\Huge\bfseries\color{Marine}`, `\vspace*{3.5cm}`, `\vfill` |
| manual: contents, breaks | texecole.tex:86-87 | `toc.kernel`, `pg.break` | `\tableofcontents`, `\newpage` |
| manual: sectioning | texecole.tex:90, 93 | `head.kernel` | `\part`, `\section`, `\subsection` |
| manual: inline marks | texecole.tex:44-45, 98 | `mark.kernel`, `color.xcolor` | `\bal`=`\texttt`, `\opt`=`\texttt{\textcolor{Accent}{}}`, `\textbf`, `\emph` |
| manual: closing note | texecole.tex:944-946 | `font.size-commands`, `sp.manual-space` | `\vfill`, `\small\itshape`, `\url` |
| class: base class | texecole.cls:33 | `class.extarticle` | `\LoadClass[11pt, a4paper]` (size from `taille`) |
| class: option parser | texecole.cls:10-26 | `class.texecole` | kvoptions keys listed above |
| class: page geometry | texecole.cls:96-117 | `page.geometry` | `margin=<marges>mm` or top/right/bottom/left from `a;b;c;d` |
| class: main and maths fonts | texecole.cls:94-95, 135-158 | `font.fontspec`, `font.unicode-math` | `\setmainfont{police}`, `\setmathfont{math}`, fallback Latin Modern |
| class: line and paragraph shape | texecole.cls:83, 170-174 | `sp.lengths`, `sp.linespread`, `sp.ragged` | parindent=0pt, parskip=0.5em, `\linespread{interligne}`, lineskip 3pt, JustifyingParindent=0pt |
| class: heading spacing | texecole.cls:88-91 | `head.titlesec` | `\titlespacing*` of the three levels = 0pt 0pt 0pt |
| class: tab and line lengths | texecole.cls:84-87 | `sp.lengths` | `\texecoletab`=8mm, `\texecoleline`=8mm |
| class: loaded helper packages | texecole.cls:46-60 | `math.amsmath`, `math.amssymb`, `fig.graphicx`, `color.xcolor`, `list.enumitem`, `sp.ragged`, `mark.ulem`, `fn.footmisc`, `pg.needspace` | svgnames; ulem `normalem`; footmisc `bottom`; array and xstring load only |
| class: boxes and posters | texecole.cls:68-70 | `box.tcolorbox`, `poster.tcbposter` | tcolorbox `skins,breakable,raster` and the poster library |
| class: tables | texecole.cls:76 | `tbl.nicematrix` | tabularray |
| class: plots and sign tables | texecole.cls:73, 79-81 | `art.tikz`, `art.content-package` | pgfplots compat=1.18 with fillbetween; tkz-tab (content, see Content-opaque) |
| DSL: frame | texecole-box.lua:31-87, 94-124 | `box.tcolorbox` | `colframe`, `colback`, `boxrule`, `arc` with `rounded corners` or `sharp corners`, `breakable`/`unbreakable`, `title`, `\tcblower` at a `---` line |
| DSL: row of frames | texecole-box.lua:126-163 | `box.tcolorbox` | `tcbraster` with `raster columns`, `raster equal height`, skips |
| DSL: grid | texecole-grid.lua:192-248 | `poster.tcbposter` | `poster={columns,rows,spacing}`, `boxes`, per zone `name` `column` `row` `span` `rowspan`, in a `minipage` |
| DSL: table | texecole-table.lua:182-234 | `tbl.nicematrix` | `tblr` with `colspec` of `X[]`/`Q[]`, `width`, `colsep`, `hlines`, `vlines`, `cells`, `row{1}`, `\SetCell[c=,r=]`; the merges are inferred by Lua (see Bespoke) |
| DSL: lists | texecole-list.lua:4-17, 59-60 | `list.enumitem` | itemize or enumerate with `label=...`, `leftmargin=*`, `nosep` |
| DSL: image | texecole-img.lua:17-32, 43-66 | `fig.graphicx` | `\includegraphics[width=<mm>mm]` in a `\raisebox`; the caption is a hand-set `\\[2pt]{\small ...}` in `center`, no `\caption` |
| DSL: headings | texecole-section.lua:29-86 | `head.kernel` | `\section`/`\subsection`/`\subsubsection` with `\renewcommand\thesection{\arabic{section}}` and style wrappers |
| DSL: inline styles | texecole-style.lua:3-10, 14, 146 | `mark.kernel`, `mark.ulem`, `color.xcolor`, `sp.ragged`, `font.size-commands`, `font.fontspec` | `\textbf` `\textit` `\emph` `\textsc` `\textsf`, `\underline` `\sout`, `\textcolor{<CSS name>}`, `\raggedright` `\centering` `\raggedleft` `\justifying`, `\fontsize`, inline `\fontspec{NAME}` |
| DSL: spaces, breaks, notes | texecole-style.lua:120-136; texecole-toc.lua:12 | `sp.manual-space`, `pg.break`, `fn.kernel`, `toc.kernel` | `\hspace*{n\texecoletab}`, `\vspace*{n\texecoleline}`, `\newpage`, `\footnote`, `\tableofcontents` |
| DSL: maths notation | texecole.lua:204-260 | `math.amsmath` | `$racine(2)$` etc. rewritten to maths by `MATH.mathlite`; the equation is content, the notation is input vocabulary |
| DSL: decimal comma | texecole.lua:530-531, 744, 765 | none (Lua prints `{,}`) | `lang = "fr"` set at texecole.cls:133; `babel` is not loaded by the class |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| source re-read and `texecole.inject(body)`, then `\end{document}` | texecole.cls:175-204 | No | Lua replaces body parsing; no lib way takes a body that is not LaTeX |
| DSL transpiler to Lua, `load`, run, `tex.print` | texecole.lua:527-814; texecole-lecteur.lua:1416 | No | a program computes the layout and the text |
| aliases, parameterised macros, variables, loops, conditionals | texecole.lua:73-113, 648-703; basic1.tex:6-8, 64-87 | No | hand-rolled control flow driving what is printed |
| table merge inference from the shape of rows | texecole-lecteur.lua:951-1074; texecole-table.lua:254-263 | No | the output is `tbl.nicematrix`, the inference is code |
| SymPy/SciPy worker | texecole-sympy.lua:174-200, 329-330 | No | `EXTERNAL`, needs Python |
| `\texecolescript` | texecole.cls:92-93 | Yes | `sp.manual-space` `\raisebox` with graphicx `\scalebox`; factor from `decalage` |
| `\fint` | texecole.cls:159-165 | Yes | `math.kernel`: `\mathchoice` of `\rlap`, `\raisebox`, `\scalebox`, a fixed glyph |
| `\texecoleparallelogram` | texecole.cls:166-168 | Yes | fixed 4-point tikz glyph, `art.tikz` used as a symbol, content-opaque |
| `\texecoletab`, `\texecoleline` | texecole.cls:84-87 | Yes | `sp.lengths` |
| margin and padding string splitting (`\StrCut`) | texecole.cls:101-129 | Yes | the four values go to `page.geometry` top, right, bottom, left |
| font-name fallback and `respace` | texecole.cls:135-158; texecole.lua:816-821 | Yes | `font.fontspec` `\setmainfont` with the font chosen |
| `\bal`, `\opt` (manual) | texecole.tex:44-45 | Yes | `\newcommand` aliases of `\texttt` and `\textcolor` |
| `code` environment (manual) | texecole.tex:34-42 | Yes | fancyvrb `\DefineVerbatimEnvironment`, `code.verbatim` |

## Content-opaque
- TikZ figures drawn from prose (`<Trace>`): texecole-figure.lua:1520, 1799; sign and variation tables in TikZ with tkz-tab: texecole-vartab.lua:293; pgfplots axes: texecole-plot.lua:259-260; statistics charts: texecole-stats.lua:108; probability trees: texecole-tree.lua:137; posed operations in `tblr`: texecole-posedop.lua:88.
- Text produced by the Python/SymPy engine (solutions, derivatives, tables of variations): its computation is `EXTERNAL`, its printed result is content.

## Lib changes
- New ways proposed: none. Considered and not proposed: a way for the prose-tag language itself (`texecole`), because it fails W2 (behaviour is a program in the body, not option values) and W4 (its body is not LaTeX).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
