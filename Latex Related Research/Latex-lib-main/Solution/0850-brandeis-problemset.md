yes

# 0850-brandeis-problemset: brandeis-problemset (COSI problem sets, Brandeis University)

- Unverified: read from the source, not compiled.
- Source: Source/0850-brandeis-problemset/ (origin: https://mirrors.ctan.org/macros/latex/contrib/brandeis-problemset.zip; licence: LPPL 1.3c)
- Kind: assignment
- Lib: v6
- Engine: pdfLaTeX-compatible (the package tests the engine at brandeis-problemset.sty:36-47 and takes a `stix2` branch under pdfLaTeX, brandeis-problemset.cls:153-158; XeLaTeX or LuaLaTeX gets the optional fontspec branch with STIX2 OTF fonts, brandeis-problemset.cls:120-152; the CTAN page says "compatible with all LaTeX flavors")
- Look carried by: class (the published class and its package set the page, header, title block, headings, lists, code styles; example.tex adds only class options, `\bpsset` keys and class commands)
- Class origin: ctan
- Main file: example.tex (other samples: brandeis-problemset.tex, the class documentation; it uses class `ltxguidex` and loads this package only)
- Read: main yes, zip-local classes and styles all

## Verdict
yes. The zip is the CTAN release of the `brandeis-problemset` class (Rebecca Turner, LPPL 1.3c; ctan.org/pkg/brandeis-problemset read: a class on CTAN, also in TeX Live and MiKTeX). The sample defines no macro, counter or environment of its own: it passes class options, `\bpsset` keys and the class's own `problem`, `solution`, `pseudocode`, `assembly`, `scheme`, `ganttschedule` environments (example.tex:1-18, 36-293). Every component maps to a lib way, the one new way (`NEW:draft.comment`) passes W1 to W4, nothing needs a tool outside TeX, and the TikZ Gantt chart is drawn by the class from data, so it is content here and not template artwork.

## Blockers
none

## Class setting
- Class: `class.brandeis-problemset` options: gantt, scheme, assembly, math, pseudocode, tabu (example.tex:1-8). Boolean options and their `no<option>` complements are declared with kvoptions (brandeis-problemset.cls:43-62); any other option goes to `article` (brandeis-problemset.cls:64); the base class is `\LoadClass[12pt]{article}` (brandeis-problemset.cls:71). The class then loads its own package with `maketitle,header,listings` (brandeis-problemset.cls:73-77), so the title block, running head and `listings` styles are on in every document.
- Class-native vocabulary used: `\bpsset{coursenumber, author, instructor, duedate, number}` (example.tex:9-15; keys defined at brandeis-problemset.sty:277-287), `\newacronyms{io, cpu}` and `\ac{..}` (example.tex:16, 77; brandeis-problemset.sty:327-335), `\maketitle` as redefined (example.tex:18; brandeis-problemset.sty:294-304), `problem[part, number, label]` (example.tex:36, 67, 223; brandeis-problemset.sty:414-419), `solution` (example.tex:136), `assembly` (example.tex:57), `pseudocode[keywords]` (example.tex:187, 199), `scheme` (example.tex:285), `ganttschedule{n}` with `\burst{pid}{length}` (example.tex:271-277), `\Th[spec]{text}` (example.tex:229, 262), the aliases `\Bf \Tt \It \Rm` (example.tex:20-22, 218-220; brandeis-problemset.cls:174-179), and the `tabu` package through class option `tabu` (example.tex:228). Not used by the sample but defined: `subproblem` (brandeis-problemset.sty:422-426), `\maketitlepage` (brandeis-problemset.sty:306-309), `java` (brandeis-problemset.sty:74), `\setcodefont` (brandeis-problemset.cls:146-152), class option `antonella` (brandeis-problemset.cls:160-167).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example.tex:1-8; brandeis-problemset.cls:64-77 | `class.brandeis-problemset` | options gantt, scheme, assembly, math, pseudocode, tabu; unknown options go to article |
| base class | brandeis-problemset.cls:71 | `class.article` | 12pt, loaded by the class |
| page size and margins | brandeis-problemset.cls:93-98 | `page.geometry` | letterpaper, margin=1.25in, tmargin=1.5in, bmargin=1.5in |
| running head | brandeis-problemset.sty:312-325 | `hf.class-native`, `hf.fancyhdr` | `\fancyhf{}`; `\lhead{author \hfill assignment (due date) \hfill instructor \hfill page}`; `\headheight` 24pt; `plain` style with empty left head; `\pagestyle{fancy}` at begin document; option `header` (always on, brandeis-problemset.cls:73-77) |
| title-page style | brandeis-problemset.sty:294 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` inside `\maketitle` |
| paragraph shape | brandeis-problemset.cls:171-172 | `sp.lengths` | `\parindent` 0em, `\parskip` 0.5em |
| widow and club control | brandeis-problemset.cls:169 | `sp.penalties` | `\widowpenalties 1 10000` |
| page flow | brandeis-problemset.cls:170 | `pg.flush` | `\raggedbottom` |
| text font, XeLaTeX or LuaLaTeX branch | brandeis-problemset.cls:130-136 | `font.fontspec` | `\setmainfont` STIX2Text, Extension=.otf, UprightFont=*-Regular, BoldFont=*-Bold, ItalicFont=*-Italic, BoldItalicFont=*-BoldItalic |
| math font, same branch | brandeis-problemset.cls:121-126, 137-145 | `font.unicode-math` | `unicode-math` with warnings-off={mathtools-colon,mathtools-overbracket}; `\setmathfont` STIX2Math, StylisticSet 1 and 8 (class option `math`) |
| text and math font, pdfLaTeX branch | brandeis-problemset.cls:153-158 | `font.serif-pkg` | `stix2` with option `upint`, then amsmath (only with `math`) |
| code font hook | brandeis-problemset.cls:146-152; brandeis-problemset.sty:285 | `font.fontspec` | `\setcodefont[opts]{font}` calls `\setmonofont` if defined; key `codefont` |
| mono font under `antonella` (not selected) | brandeis-problemset.cls:160-167 | `font.fontspec`, `font.mono` | `\setmonofont{Courier New}` or package `couriers`; also sets the instructor string |
| pseudocode symbol face | brandeis-problemset.sty:197-215 | `font.fontspec` | `\newfontface{\lmmath}{latinmodern-math.otf}` becomes `\pseudocodesymbolfont`; symbols for `<-` `->` `<=` `>=` `!=` `(/)` `inf` |
| colour | brandeis-problemset.sty:57, 63-65, 67, 258 | `color.xcolor` | line numbers gray; keywords rgb 0,.3,.7; comments rgb 0.133,0.545,0.133; strings rgb 0.75,0.49,0.07; solution `\color{blue}` |
| title block | example.tex:9-15, 18; brandeis-problemset.sty:277-304 | `front.class-native`, `front.maketitle` | keys course/assignment/instructor/duedate/author/date/number/coursenumber; `center`, `\Large`, `tabular{r\|l}` rows: assignment, by author, course, instructor, due |
| title spacing | brandeis-problemset.sty:304; brandeis-problemset.cls:195-214 | `sp.manual-space` | `\vspace*{2em}`; `\hspace*` offsets in toc entries |
| contents | example.tex:34; brandeis-problemset.cls:191-217 | `toc.kernel`, `toc.titletoc`, `font.size-commands` | `\titlecontents` part [3.8em] `\large\bfseries`; section [4.8em]; subsection [5.8em] `\small`; page number set before the entry |
| problem headings | example.tex:36, 67, 104, 223; brandeis-problemset.sty:378-419 | `head.class-native`, `head.kernel` | `problem` runs `\section` (or `\section*` when toc=false) with `\@seccntformat` emptied and the title "Problem n: title"; `subproblem` runs `\subsection`; keys title, number, label, pagebreak, toc, part (calls `\part`), partlabel |
| problem numbering | brandeis-problemset.sty:362-365, 380-385 | `num.counters` | counters `problemnumber`, `subproblemnumber` reset by `problemnumber`; key `number` overrides the printed number |
| problem body indent | brandeis-problemset.sty:340-341, 418-419 | `page.adjustwidth` | `adjustwidth{1in}{0pt}` around each problem (`\problemindent` is not defined as read: the length is `\bps@problemindent`) |
| page break before a problem | brandeis-problemset.sty:347-351, 359, 364-365 | `pg.break` | `\vfill\pagebreak`, key `pagebreak` default true for `problem`, false for `subproblem` |
| lists | example.tex:71-81; brandeis-problemset.cls:181-189 | `list.kernel`, `list.enumitem` | `\labelitemi` = ---; `\setlist[itemize,enumerate,1]{leftmargin=0em}`; `\setlist{partopsep=0em, topsep=0em, leftmargin=2em}` |
| quotation | example.tex:27-29 | `quote.kernel` | `quote` environment, default |
| inline marks | example.tex:20-22, 218-220; brandeis-problemset.cls:174-179; brandeis-problemset.sty:327-335 | `mark.kernel` | `\Sc \Rm \Up \Bf \It \Tt` = `\textsc \textrm \textup \textbf \textit \texttt`; `\ac` = `\textsc`; `\newacronyms{io, cpu}` defines `\io` and `\cpu` as `\textsc{..}` |
| display maths | example.tex:122-134; brandeis-problemset.cls:101-108, 122, 156 | `math.amsmath`, `math.mathtools` | amsmath (2013/01/14 or later), mathtools; `equation`, `split`; `\Re` renamed to `\mathbb{R}` at begin document (brandeis-problemset.cls:107) |
| tables | example.tex:227-236, 261-268; brandeis-problemset.cls:80-85; brandeis-problemset.sty:254-256 | `tbl.nicematrix`, `tbl.tabular`, `tbl.multirow`, `tbl.booktabs`, `tbl.longtable` | `tabu` with `to 0.25\linewidth`, columns `X[1,$]rr` and `@{}>{$P_\bgroup}X[1]<{\egroup$}rr@{}`; `\Th[spec]{text}` = `\multicolumn{1}{spec}{\Bf{text}}`; multirow, booktabs, longtable loaded by option `tabu` |
| table centring | example.tex:227 | `sp.ragged` | `center` environment |
| code listings | example.tex:39-46, 57-65, 187-214, 285-293; brandeis-problemset.sty:49-77, 82-155, 231-247 | `code.listings` | `\lstset{basicstyle=\ttfamily, numbers=left, numberstyle=\color{gray}\ttfamily, aboveskip=1em, belowskip=0.5em, breaklines, breakatwhitespace=true, tabsize=4, keywordstyle, commentstyle, stringstyle}`; `lstnewenvironment` `java` `scheme` `assembly` `pseudocode`; `lstdefinelanguage` Scheme[R5RS], assembly (firstnumber=-3, `numberstyle` with `\addtocounter{lstnumber}{3}x +`), Pseudocode (`literate` rules, `morecomment=[l]{\#}`); `lstlisting[language=c]`; `\lstinline` |
| Gantt chart environment | example.tex:271-277; brandeis-problemset.sty:157-191 | `fig.class-native`, `sp.lengths` | `ganttschedule{total}[title]` with `\burst{pid}{length}`; unit `\linewidth / \real{total}` (calc), counters for the running time, `fp` for the label position |
| Gantt drawing | brandeis-problemset.sty:173-183 | `art.tikz` | `tikzpicture` with `x=\bps@gantt@unit`: a rectangle, a `P_n` node and a dimension arrow per burst; chart is content (see Content-opaque) |
| solution blocks | example.tex:136-181; brandeis-problemset.sty:258-266 | `NEW:draft.comment`, `color.xcolor` | without class option `solution` (the sample's case, example.tex:1-8): `\excludecomment{solution}`; with it: environment that sets `\solutionstyle` = `\color{blue}` |
| cross references | example.tex:53, 223; brandeis-problemset.sty:409-411 | `xref.kernel` | `\label` from key `label`, `\ref{schedule}` |
| hyperlinks | example.tex:22, 28, 30; brandeis-problemset.cls:92 | `meta.hyperref` | `hyperref` loaded with no options; `\href` |

Not in the sample and not defined by the class: abstract, footnotes, theorem environments, figure and table floats and captions, bibliography, index, language packages, PDF metadata. Plumbing with no printed effect: `xparse`, `xkeyval`, `kvoptions` (brandeis-problemset.cls:25-26; brandeis-problemset.sty:6-9). The class option `fonts` is declared and never tested (brandeis-problemset.cls:62).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| macros, counters, environments of the sample | example.tex:1-17 | none exist | the preamble holds only options, `\bpsset` and `\newacronyms` |
| `problem`, `subproblem`, keys, counters | brandeis-problemset.sty:337-426 | published (class); would reduce | `\section*`/`\section` plus `page.adjustwidth`, `pg.break`, `num.counters` |
| `\maketitle`, `\bpsset` | brandeis-problemset.sty:277-304 | published (class); would reduce | `front.maketitle` plus a `center`/`tabular` block |
| running head | brandeis-problemset.sty:312-325 | published (class); would reduce | `hf.fancyhdr` with one `\lhead` |
| `\Sc \Rm \Up \Bf \It \Tt`, `\ac`, `\newacronym(s)`, `\Th` | brandeis-problemset.cls:174-179; brandeis-problemset.sty:254-255, 327-335 | published (class); alias | `\newcommand` aliases of kernel font commands and `\multicolumn` |
| `\Re` redefinition | brandeis-problemset.cls:107 | published (class); alias | `\renewcommand{\Re}{\mathbb{R}}` under `\AtBeginDocument` |
| language definitions Scheme, assembly, Pseudocode and the `\pseudocode*` symbol macros | brandeis-problemset.sty:82-155, 193-248 | published (class); would reduce | `lstdefinelanguage` and `lstnewenvironment` calls, `literate` set to the symbols |
| `ganttschedule` | brandeis-problemset.sty:157-191 | published (class); would not reduce | TeX arithmetic (`\FPeval`, counters) places TikZ shapes from data; without the class this would be `BESPOKE`; with the class it is the vocabulary of `fig.class-native` |
| engine test, `\iffontspec@ok` | brandeis-problemset.sty:36-47 | published (class) | engine switch inside the class, no emitter output |

## Content-opaque
- TikZ Gantt chart at example.tex:271-277, drawn by `ganttschedule` from the burst list (brandeis-problemset.sty:173-183); the `fig.class-native` environment is recorded, the picture is content.
- Equations at example.tex:122-134 and the listing, pseudocode and assembly texts are content.

## Lib changes
- New ways proposed: `NEW:draft.comment` `comment` (CTAN, GPL 2, Victor Eijkhout, v3.8; ctan.org/pkg/comment read), engine pdf: `\usepackage{comment}`, preamble `\excludecomment{name}` or `\includecomment{name}` makes environment `name` that is dropped or kept, body wrapper `\begin{name} ... \end{name}` (begin and end lines on their own lines). W1: on CTAN. W2: one environment name and an include/exclude choice, no code edited. W3: any document with versions (answer key and handout, draft-only passages). W4: one preamble line plus a body wrapper. No home in `draft.todo` (todonotes, changes, showframe, lipsum, anonymous-acm: marks, filler and a class switch, none removes an environment's text by name); considered `exam.questions`, not a question bank.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Missing assets: the STIX2 OTF fonts (`STIX2Text-*.otf`, `STIX2Math.otf`) and `latinmodern-math.otf` are not in the zip; TeX Live ships them. The documentation file brandeis-problemset.tex needs XeLaTeX or LuaLaTeX (`fontspec`, brandeis-problemset.tex:3), the class `ltxguidex`, the commercial font `Tiempos Text` (brandeis-problemset.tex:52) and `FiraSans`/`FiraMono` (brandeis-problemset.tex:53-54); it is documentation, not the template sample.
- `tabu` is a published package but old; whether it builds under a current LaTeX kernel was not tested here.
- No text addressed to an AI was found in the zip.
