no

# 0235-ieeepes: ieeepes (IEEE Power Engineering Society Transactions, LaTeX2e package)

- Unverified: read from the source, not compiled.
- Source: Source/0235-ieeepes/ (origin: https://mirrors.ctan.org/macros/latex/contrib/ieeepes.zip; licence: LPPL version 1 or later, manifest `lppl1`, README:81-84)
- Kind: journal
- Lib: v4
- Engine: pdfLaTeX-compatible (plain LaTeX2e, ieeepes.sty:59; the sample was written for latex + dvips: its figure drawings carry `\special{ps:...}`, ieeepes_check.tex:233-247, which pdfTeX does not use)
- Look carried by: class (the CTAN style `ieeepes.sty` loaded over kernel `article` sets the whole look: page, title block, headings, captions, floats, biography, summary/discussion/closure; the sample's preamble adds only option choices)
- Class origin: ctan
- Main file: ieeepes_check.tex (other samples: ieeepes_skel.tex, ieeepes_doc.tex)
- Read: main yes, zip-local classes and styles all (ieeepes.sty whole; ieeepes.bst outline plus lines 1-80, 183-262, 290-320, 594-615, 925-945, 985-1014, the rest not read; vk.eps header only, it is an image asset)

## Verdict
The zip is the CTAN release of the published style `ieeepes` (Volker Kuhlmann) used over `article`, so the template is one published way (`class.ieeepes`) plus `class.article`, with every body construct the sample shows being that package's own vocabulary or kernel/standard commands. No `ART`, no irreducible zip-local macro. The verdict is `no` on a single blocker: the main sample selects `psphotos` and prints an author photo from an EPS file (`vk.eps`), which under pdfTeX needs the Ghostscript conversion that the lib's `fig.epstopdf` line rules `EXTERNAL`. If that photo is treated as a content asset converted at import, or if `ieeepes_skel.tex` (no image is read there, `psphotos` is commented out at skel:30) is taken as the sample, the zip would read `yes`.

## Blockers
- `EXTERNAL/body` EPS author photo: `psphotos` option (ieeepes_check.tex:38) and `\begin{biography}{Volker Kuhlmann}[0mm]{vk.eps}` (ieeepes_check.tex:539) reach `\includegraphics[width=28mm,height=38.73mm]{vk.eps}` (ieeepes.sty:525); an `.eps` under pdfTeX is converted with Ghostscript (lib `fig.epstopdf`); graphicx is loaded by the option (ieeepes.sty:93-95)

## Class setting
- Class: `class.article` options: `10pt`, `twoside` (ieeepes_check.tex:31-34; `draft` and `noieeebox` are commented out there). Paper-size class options are forbidden, the package sets the paper (ieeepes_doc.tex:250-252).
- House style over it: `class.ieeepes` (CTAN, class-like per the lib's rule for a house-style package) options: `psphotos`, `photofit`, `draft` selected (ieeepes_check.tex:37-42); `PStimes` (commented, :41), `noieeebox`, `puttoc` declared (ieeepes.sty:104-115).
- Class-native vocabulary used: `\maketitle` (mandatory, ieeepes.sty:235-248), `\title`, `\author` with `\and` (ieeepes.sty:152-170), `abstract` (:262), `\section` `\subsection` `\subsubsection` (`\paragraph` and `\subparagraph` raise an error, :323-324), `Figure` and `Table` environments `[place]{label}[toc caption]{caption}` (:428-450), `\figref` `\tabref` `\fref` `\tref` `\equref` `\Equref` (:341-344, :473-474), `\Lhighlight` `\Rhighlight` (:454-457), `\setTBstruts` with `\T` `\B` (:620-621), `biography{name}[raise]{file}` (:505-534), `\columnbreak` (:540-542), `\summary`, `discussion{6 args}`, `closure{name}` (:568-609). Defined and not used by the sample: `\authors`, `\authorcolumn`, `\linefield` (:172-202), `\capwidth` (:353), `\today` as yyyy/m/d (:548-550).

## Component map
Paths: `ieeepes_check.tex` = check, `ieeepes.sty` = sty (both in Source/0235-ieeepes/).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | check:31-34 | `class.article` | 10pt, twoside |
| house style | check:37-42; sty:53-61, 118 | `class.ieeepes` | psphotos, photofit, draft; others declared not selected; requires `vmargin` (sty:69) |
| type size, sides | check:31-34 | `page.class-options` | 10pt, twoside |
| paper and margins | sty:69, 124-125 | `page.vmargin` | `\setpapersize{USletter}`; `\setmarginsrb{18mm}{25mm}{18mm}{14mm}{0pt}{0mm}{}{11mm}` (left, top, right, bottom, head, headsep, foot, footskip); `vmargin.sty` is not in the zip (README:34-38), it is on CTAN |
| columns | sty:204-214, 235-239; sty:128 | `cols.twocolumn-cmd` | `\maketitle` calls `\twocolumn[title block]`; `\columnsep` 5mm |
| paragraph shape | sty:126-127 | `sp.lengths` | `\parskip 0pt plus 1.5pt`, `\parindent 3.5mm` |
| header/footer, base | sty:129, 572, 581, 599 | `hf.pagestyle-kernel` | `\pagestyle{empty}`; `\thispagestyle{plain}\pagestyle{plain}` in summary, discussion, closure |
| draft footer | sty:75-91; check:40 | `hf.class-native` | option draft: plain page style, `\@oddfoot` = sans bold DRAFT and `\@date` footnotesize at both ends beside the page number |
| page number restart | sty:571, 580, 598 | `pgnum.pagenumbering` | `\setcounter{page}{1}` |
| PostScript Times | sty:104-106; check:41 | `font.mathptmx` | option PStimes loads `times`, `mathptm` (not selected in the sample) |
| title block | sty:152-170, 204-214, 227, 235-239; check:46-64, 71 | `front.class-native` | title `\Large\textbf`, authors `\large`, `\vspace{1cm}`, `\tabcolsep 1cm`; each `\and` author is a centred minipage of `\textwidth` with `\hspace*{-.5\textwidth}`; `\maketitle` also sets `\capwidth=0.8\columnwidth` |
| reserved IEEE box | sty:216-225, 108-110 | `front.class-native` | `figure[b]` holding an empty `\makebox(200,142.3){}` (blank space, nothing drawn, so not ART); option noieeebox removes it |
| abstract | sty:262-267; check:74-87 | `abs.class-native` | `\footnotesize\bfseries`, run-in `\textit{Abstract---}` |
| section | sty:283-292; check:91, 147 | `head.class-native` | `\Roman{section}.` + `.4em`, `\scshape` centred (`\noindent\hfil`), before `1\baselineskip plus1 minus.1`, after `.8\baselineskip plus.2` |
| subsection | sty:295-304; check:103 | `head.class-native` | `\Alph{subsection}.`, `\itshape`, same skips |
| subsubsection | sty:307-320; check:121 | `head.class-native` | `\arabic{subsubsection})`, run-in at `\parindent`, `\itshape`, a colon added by intercepting `\@svsechd` |
| numbering | sty:274, 283, 295, 307 | `num.secnumdepth` | secnumdepth 3 |
| counter formats | sty:283, 295, 307, 333, 335, 337, 468 | `num.counters` | `\thesection` Roman, `\thesubsection` `\thesection.\Alph`, `\thesubsubsection`, `\thefigure` arabic, `\thetable` Roman, `\thempfootnote` alph, `\theequation` `(n)` |
| contents list | sty:89, 112-115, 255-256; check:834 | `toc.kernel` | `\tableofcontents` is an error; printed only with options puttoc and draft |
| footnotes | check:167-186, 296-303, 357-362 | `fn.kernel` | plain `\footnote`; in a table through `minipage` (mpfootnote) |
| display math | sty:468-469; check:426-430, 657-659 | `math.kernel` | `equation`, `\label`; `\theequation` = `(\arabic{equation})`, `\@eqnnum` without a second pair of parentheses |
| cross-references | sty:341-344, 473-474; check:93-95, 372-375, 422-423 | `xref.kernel` | `\label` `\ref`; `\figref` = `\figurename~\ref`, `\tabref`, `\equref`, `\Equref` = `Equation~\ref` |
| figure float | check:220-252, 378-412; sty:360-363, 369-370, 376-382 | `fig.graphicx` | `figure` with `[b]`; contents centred by `\@floatboxreset`; `\floatsep 1\baselineskip plus.1 minus.1`, `\textfloatsep 1.1\baselineskip plus1`; `\figurename` Fig. |
| table float and tabular | check:199-213, 258-279; sty:396-402, 335-336 | `tbl.tabular` | `table` float, caption before the table, `tabular{l|l|l|l|l|l|l}`, `\hline`; `\tablename` Table |
| caption | sty:350-351, 383-415, 431, 449 | `cap.kernel` | `\@makecaption` replaced on entry to each float: figure `\footnotesize` centred "Fig. n. text" in `\parbox\capwidth`, above skip `.9\baselineskip`; table `\footnotesize\scshape`, label then text, below skip `.9\baselineskip` (the look is carried by `class.ieeepes`) |
| Figure and Table envs | sty:428-450; check:463-468, 474-485 | `class.ieeepes` | `\begin{Figure}[hbtbp]{f:Figure}{caption}`, `\begin{Table}...`: wrappers that set float, caption position and label |
| table struts | sty:620-621; check:204-211 | `sp.rule` | `\T` = `\rule{0pt}{2.6ex}`, `\B` = `\rule[-1.2ex]{0pt}{0pt}` |
| table footnote minipage | check:285-313, 323-346 | `box.minipage` | `minipage` of `\columnwidth` or `.65\columnwidth` around the tabular |
| draft width markers | sty:454-457; check:289-312 | `class.ieeepes` | `\Lhighlight` `\Rhighlight`: `\llap`/`\rlap` arrows, only under draft |
| framed content | check:264-278, 353-366, 467 | `box.fancybox` | `\fbox`; `\fboxrule` 0.8mm and `\fboxsep` 5mm set at check:465-466 |
| centring | check:202, 221, 291, 324 | `sp.ragged` | `\centering` |
| manual line break | check:540 | `sp.manual-space` | `\linebreak` |
| inline code | check:550, 554, 698 | `code.verbatim` | `\verb+...+` |
| figure drawings | check:231-248, 388-405 | `art.pstricks` | `picture` with `\put` `\line` `\vector`; content inside a float, see Content-opaque |
| bibliography | sty:480-490; check:440-444, 531; ieeepes.bst:1-80 | `bib.bibtex-bst` | style `ieeepes` set by the package (derived from ieee.bst, month names spelled out, strings ieeepes ieeetec ieeetpd ieeetps at bst:934-937); `\bibliography{ieeepes_check}`; `thebibliography` heading turned into a numbered `\section` (sty:485-490) |
| author biography | sty:503-534; check:539, 570, 592 | `class.ieeepes` | `biography{name}[raise]{file}`: `\footnotesize`, `\hangindent 30mm`, `\hangafter -12`, bold name; file `nophoto` leaves no space, an empty name argument leaves space for a pasted photo |
| biography photo | sty:93-102, 520-531; check:38-39, 539 | `fig.graphicx` | `\includegraphics[width=28mm]` (photofit adds `height=38.73mm`) raised in a `\llap{\raisebox..\parbox[t][38.5mm][t]{30mm}}`; the file is an EPS: EXTERNAL, see Blockers |
| manual column balance | sty:540-542; check:551 | `class.ieeepes` | `\columnbreak` = `\newpage` (or `\vadjust{\newpage}` in horizontal mode); wraps `pg.break` |
| summary, discussion, closure | sty:561-609; check:609-659, 680-690, 772, 778 | `class.ieeepes` | `\summary`, `discussion`, `closure`: `\clearpage`/`\cleardoublepage`, counters reset (`\reset@counters`), `\onecolumn`, `\columnwidth 88mm` and `\hsize\columnwidth` set by hand, centred `\Large\textbf` heading; the discussion takes 6 string arguments |
| secondary: manual class | ieeepes_doc.tex:28 | `class.article` | twoside, twocolumn, a4paper; the manual does not load ieeepes (doc:38) |
| secondary: manual doc tools | ieeepes_doc.tex:31-32 | `dtx.doc` | `\usepackage{doc}`, `\MakeShortVerb |` |
| secondary: manual lengths | ieeepes_doc.tex:34-36, 55-58, 89 | `sp.lengths` | `\parindent 0em`, `\parskip 1.5ex plus.5ex minus.5ex`, `\columnsep 7mm`, display skips scaled by 0 |
| secondary: manual front | ieeepes_doc.tex:45-51, 86-92, 96-110 | `front.maketitle` | `\title` `\author` `\maketitle`; `\tableofcontents` (`toc.kernel`); `abstract` (`abs.kernel`) with `\bfseries` |
| secondary: manual text | ieeepes_doc.tex:80-82, 182-228, 236-248 | `list.kernel` | `description`; `verbatim` (`code.verbatim`); `\file` = `\textsf`, `\ag` = `\textsc` (`mark.kernel`) |
| secondary: manual bibliography | ieeepes_doc.tex:62-74, 612 | `bib.thebibliography` | `filecontents` writes a `.bbl` holding one `\bibitem` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\def\Filename`, `\Fileversion`, `\Filedate` | ieeepes_check.tex:26-28 (used at :77) | yes | strings printed in abstract text; expand inline (content) |
| `\def\gobble#1{}` and `\gobble{tabular}` | ieeepes_check.tex:493-504, 511-522 | yes | test device that swallows a tabular; omit the swallowed content, the template effect is none |
| `\SetFigFont` guard inside the figure | ieeepes_check.tex:225-230, 382-387 | yes | xfig boilerplate inside figure content, never called by the picture; content-opaque |
| `\def\today{\Filedate}`, `\newcommand\file`, `\newcommand\ag` | ieeepes_doc.tex:80-82 | yes | aliases of a string, `\textsf`, `\textsc` |
| ieeepes.sty internals: `\@startsection` renewals with `\@seccntformat`/`\@xsect`/`\@svsechd` hacks (:283-320), `\@makecaption` swap (:375-415), `\@floatboxreset` patch (:369-370), active `&` author table (:180-202), hand-set `\columnwidth`/`\hsize` (:574-575, 586-587, 601-602) | ieeepes.sty | not counted | the file is the published CTAN release (W1), so it is one way, `class.ieeepes`, and the emitter writes `\usepackage[opts]{ieeepes}`; read as a zip-local file this code would be irreducible `BESPOKE/class` |
| `ieeepes.bst` BibTeX style | ieeepes.bst | not counted | part of the CTAN release; a `.bst` is the parameter of `bib.bibtex-bst` |

## Content-opaque
- two `picture` drawings with dvips `\special{ps:...}` colour calls inside figure floats (ieeepes_check.tex:231-248, 388-405)
- the EPS author photograph `vk.eps` (ImageMagick output, header read only; BoundingBox 0 0 107 150); its inclusion route is the blocker above, its pixels are content
- filler text `xxx xxx ...`, the equation `I_f = I_b = ...` (check:427-428), table cells A to G, bibliography entries (ieeepes_check.bib)

## Lib changes
- New ways proposed: none. The package is recorded as `class.ieeepes` (a house-style package is class-like, lib v3 ruling); its native vocabulary is under Class setting. `fig.epstopdf` was considered and is not a way here, the sample does not load it, it only supplies the EXTERNAL ruling.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
