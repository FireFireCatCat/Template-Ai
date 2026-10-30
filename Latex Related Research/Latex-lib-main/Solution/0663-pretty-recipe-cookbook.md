yes

# 0663-pretty-recipe-cookbook: Pretty Recipe Cookbook (half-letter recipe book)

- Unverified: read from the source, not compiled.
- Source: Source/0663-pretty-recipe-cookbook/ (origin: https://latextemplates.com/downloads/pretty-recipe-cookbook.zip; licence: GPL-3.0, LICENSE:1-2 is the GNU GPL v3 text)
- Kind: book (a cookbook: report class with chapters of recipes; the manifest hint `misc` is only the source category)
- Lib: v5
- Engine: pdfLaTeX-compatible (fancyhdr, multicol, hyperref, geometry, xcolor, graphicx, transparent; no fontspec or Lua)
- Look carried by: zip-local (the whole look is `recipe.sty`, a zip-local style loaded over the unchanged `report` class; main.tex adds no preamble line)
- Class origin: tex-distribution-unbundled (`report`, kernel class, not in the zip; its source was not read)
- Main file: main.tex (other samples: quinoa.tex and cookies.tex, the two recipes it `\input`s)
- Read: main yes, zip-local classes and styles all (recipe.sty read in full; quinoa.tex, cookies.tex and LICENSE head also read)

## Verdict
yes. The class is the published `report`; the only zip-local code is `recipe.sty` (186 lines), which loads published packages and defines `\newcommand` aliases over `fancyhdr` fields, one `\newenvironment` of `multicols` with paragraph-shape glue, and two environments that print numbered steps with an `\everypar` hook. Each reduces to lib ways with parameters (see Bespoke code). No artwork, no external tool, no unmapped component. The one judgement call is the `\everypar`/`\llap`/counter numbering of `method` and `notes` (recipe.sty:156, 181): the rubric lists hand-rolled counters as an example of irreducible code, but here the whole printed effect is a numbered list with a left-aligned 2em label, which `list.enumitem` expresses, so the emitter copies no macro logic. A stricter reading of that line would turn this into `no`.

## Blockers
none

## Class setting
- Class: `class.report` options: none (main.tex:6); paper and margins come from `geometry` in recipe.sty, not from class options
- Class-native vocabulary used: `\chapter` (main.tex:17, main.tex:19), `\section` (inside `\recipe`, recipe.sty:78), `\tableofcontents` (main.tex:14), `\newpage` (main.tex:12, recipe.sty:72). `report` has no `\frontmatter`/`\mainmatter`; recipe.sty defines them (recipe.sty:33-40, "Borrowed from book.cls")

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:6 | `class.report` | no options; default 10pt, oneside, Computer Modern (no font package anywhere in the zip) |
| page geometry | recipe.sty:10-17 | `page.geometry` | papersize={5.5in,8.5in} (12), margin=0.75in (13), top=0.75in (14), bottom=0.75in (15); `a5paper` (11) and `twoside` (16) are commented out |
| running heads and feet | recipe.sty:7, recipe.sty:186 | `hf.fancyhdr` | `\pagestyle{fancy}` with fancyhdr's default fields (rules and page number in the centre foot, fancyhdr source not read) |
| head and foot fields per recipe | recipe.sty:53-68, recipe.sty:89-94, cookies.tex:2-5, quinoa.tex:2-5, main.tex:13 | `hf.fancyhdr`, `font.size-commands`, `color.xcolor`, `mark.kernel` | `\lhead{George C.}`, `\chead{Serves 6}` / `\chead{Makes 24 Cookies}`, `\lfoot{Prep Time: 20 min}`, `\rfoot{Cook Time: 8-10 min}`; the unused tags `\rhead{\large\color{vegcolor}\textbf{V}}` (54), `\lhead{...M}` (57), `\rhead{...D}` (60); `\chead{}` clears the centre head on the contents page (main.tex:13) |
| colour presets | recipe.sty:19, recipe.sty:44-46 | `color.xcolor` | vegcolor rgb(0,.42,.24), meatcolor rgb(.82,.1,.26), dairy rgb(.57,.36,.51); the named colour `red` for the three block headings (115, 143, 168) |
| multi-column settings | recipe.sty:8, recipe.sty:24-26 | `cols.multicol` | `\raggedcolumns`, `\multicolsep`=0pt, `\columnseprule`=1pt (a 1pt rule between the two ingredient columns) |
| link look | recipe.sty:9 | `meta.hyperref` | option `hidelinks` (the contents entries are links with no boxes) |
| graphics package | recipe.sty:20, recipe.sty:104 | `fig.graphicx` | `\includegraphics[width=#1]` only inside `\showit`, which the sample never calls; no image shipped, none needed |
| transparency package | recipe.sty:21 | `color.transparent` | load-only; no `\transparent` call anywhere in the zip (Grep) |
| front matter and main matter | main.tex:10, main.tex:16, recipe.sty:33-40 | `pg.break`, `pgnum.pagenumbering` | `\cleardoublepage` then `\pagenumbering{roman}` before the contents, `\cleardoublepage` then `\pagenumbering{arabic}` after |
| contents list | main.tex:14 | `toc.kernel` | `\tableofcontents` (page break before it: main.tex:12) |
| chapter headings | main.tex:17, main.tex:19 | `head.kernel` | `\chapter{Main Dishes}`, `\chapter{Desserts}`, report look |
| recipe title | recipe.sty:78, cookies.tex:1, quinoa.tex:1 | `head.kernel` | `\section{<title>}`, numbered as chapter.section by `report` |
| new page per recipe | recipe.sty:72-77 | `pg.break`, `hf.fancyhdr` | `\newpage`, then `\lhead{}` `\chead{}` `\rhead{}` `\lfoot{}` `\rfoot{}` before the title |
| attribution line | recipe.sty:79-84, cookies.tex:1, quinoa.tex:1 | `sp.ragged`, `box.minipage`, `mark.kernel` | `center` environment holding `\parbox{0.75\linewidth}{\raggedright\itshape <text>}`, printed only when the optional argument is given |
| block heading words | recipe.sty:115, recipe.sty:143, recipe.sty:168 | `font.size-commands`, `mark.kernel`, `color.xcolor` | `{\color{red}\Large\textbf{Ingredients}}`, `...{Notes}`, `...{Instructions}` |
| ingredient list | recipe.sty:122-137, cookies.tex:6-19, quinoa.tex:6-20 | `cols.multicol`, `sp.lengths`, `sp.manual-space` | `multicols{2}`; `\parindent`=0pt, `\leftskip`=1em, `\rightskip`=0pt plus 3em, `\parskip`=0.25em, `\hangindent`=2em per item (raw paragraph-shape glue, same family as `\parindent` `\hangindent`); `\smallskip` after the heading, `\medskip` after the columns; one ingredient per source line |
| method steps | recipe.sty:165-184, cookies.tex:21-35, quinoa.tex:22-30 | `list.enumitem`, `sp.lengths`, `mark.kernel`, `sp.manual-space` | numbered "1." "2." ... label at the left margin, 2em label field, text at 2em; between steps 0.25em; optional italic pre-step line `\noindent\emph{Preheat the oven to ...}` before the first step; `\smallskip` after the heading |
| notes steps (defined, not used in sample) | recipe.sty:140-159 | `list.enumitem`, `sp.lengths`, `mark.kernel`, `sp.manual-space` | same parameters as method steps, heading "Notes" |
| temperature | recipe.sty:95-99, cookies.tex:21, quinoa.tex:22 | `math.kernel` | `$350^\circ$F`, `$#1^\circ$C` (inline maths, no amsmath) |
| gap between ingredients and method | cookies.tex:20, quinoa.tex:21 | `sp.manual-space` | `\vspace{.5in}` |
| picture with italic line (defined, not used in sample) | recipe.sty:101-110 | `fig.graphicx`, `sp.ragged`, `sp.manual-space`, `mark.kernel` | `center`, `\bigskip`, `\includegraphics[width=1in]`, `\medskip`, `\emph{<caption text>}`; no float, no `\caption` |
| recipe files | main.tex:18, main.tex:20 | `struct.input` | `\input{quinoa.tex}`, `\input{cookies.tex}` |
| inline fractions | cookies.tex:7, quinoa.tex:12 | `math.kernel` | `\(\frac{1}{2}\)`; content (literal "½" at quinoa.tex:23 is text) |

No bibliography, index, theorem, table, float, footnote, abstract, title block or cross-reference exists in the zip.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `recipe.sty` as a whole | recipe.sty:1-186 | yes | Preamble: `hf.fancyhdr` + `cols.multicol` + `meta.hyperref[hidelinks]` + `page.geometry[papersize={5.5in,8.5in},margin=0.75in,top=0.75in,bottom=0.75in]` + `color.xcolor` + `fig.graphicx` + `color.transparent` (load only), three `\definecolor`, `\raggedcolumns`, `\setlength{\multicolsep}{0pt}`, `\setlength{\columnseprule}{1pt}`, `\pagestyle{fancy}`. Not a published package (the CTAN package named `recipe` is Maurizio Loreti's different class, so the same name does not make it published); the file header says it adapts Jake Chanenson's "Pretty Recipe Package" and TeX.SE user sgmoye's `recipe.sty` (recipe.sty:1-4) |
| `\frontmatter`, `\mainmatter`, `\if@mainmatter` | recipe.sty:28-41 | yes | `\cleardoublepage\pagenumbering{roman}` and `\cleardoublepage\pagenumbering{arabic}` (`pg.break`, `pgnum.pagenumbering`). The flag is set at recipe.sty:30, 35, 39 and read nowhere in the zip (Grep for `mainmatter`), so it drives nothing printed |
| `\vegetarian`, `\meat`, `\dairy` | recipe.sty:53-60 | yes | Aliases of `\rhead{\large\color{vegcolor}\textbf{V}}`, `\lhead{...M}`, `\rhead{...D}`; emit the `\rhead`/`\lhead` call where used (not used in the sample) |
| `\serves`, `\contrib`, `\preptime`, `\cooktime` | recipe.sty:63-68, recipe.sty:89-94 | yes | Aliases of `\chead{Serves 6}`, `\lhead{<prefix><name>}`, `\lfoot{Prep Time: ...}`, `\rfoot{Cook Time: ...}`; the default label strings ("Serves", "Prep Time", "Cook Time") are expanded at emission. Header text is set in body order after `\newpage`, so the emitter keeps that order |
| `\recipe` and its `\if###1##` test | recipe.sty:71-85 | yes | `\newpage`, five empty field calls, `\section{<title>}`, and, only when the node has an attribution, the `center`/`\parbox`/`\raggedright\itshape` block. The empty-argument test is decided when the emitter writes the file |
| `\temp`, `\tempC` | recipe.sty:95-99 | yes | Inline expansion to `$<n>^\circ$F` and `$<n>^\circ$C` |
| `\showit` | recipe.sty:101-110 | yes | Inline expansion: `center`, `\bigskip`, `\includegraphics[width=1in]{file}`, `\par`, `\medskip`, `\emph{text}`, `\par` (unused in sample) |
| `\ingredients` | recipe.sty:113-119 | yes | With an empty optional argument it prints the red `\Large\textbf` word "Ingredients"; the `ingreds` environment never passes an argument (recipe.sty:125), so the `\emph{#1}` branch cannot occur through it |
| `ingreds` environment, `\obeylines`, `\everypar={\hangindent2em}` | recipe.sty:122-137 | yes | `\obeylines` only makes each source line a paragraph, so the emitter writes one paragraph per ingredient; `\everypar={\hangindent2em}` becomes `\hangindent2em` at the start of each item paragraph (`sp.lengths`); the rest is `multicols{2}` with the glue values listed in the component map |
| `method` and `notes` environments, counter `stepnum`, `\everypar={\llap{\stepcounter{stepnum}\hbox to2em{\thestepnum.\hfill}}}` | recipe.sty:140-161, recipe.sty:165-184 | yes (judgement, see Verdict) | The hook numbers each paragraph and sets the number in a 2em box left of the text indent. Equivalent: `\begin{enumerate}[label=\arabic*.,leftmargin=2em,labelwidth=2em,labelsep=0pt,align=left,itemsep=0pt,parsep=0.25em,topsep=0pt]` with one `\item` per step (`list.enumitem`); heading and optional italic pre-step line written before the list, as at recipe.sty:168-176. The counter reset (`\setcounter{stepnum}{0}`) is the list's own counter reset |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and not proposed: `\everypar` and `\obeylines` as ways (both disappear when the emitter writes one paragraph per item with `\hangindent2em`, so no way is needed); `recipe.xcookybooky` (the lib line for the `xcookybooky` and `cooking` packages) does not apply, because `recipe.sty` is zip-local, not a published recipe package
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
