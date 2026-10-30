yes

# 0667-rbt-mathnotes: rbt-mathnotes (Rebecca Turner's maths-notes package, three classes and a package manual)

- Unverified: read from the source, not compiled.
- Source: Source/0667-rbt-mathnotes/ (origin: https://mirrors.ctan.org/macros/latex/contrib/rbt-mathnotes.zip; licence: lppl1.3c)
- Kind: misc (main sample is a package manual; the zip also holds a notes class, a homework class and a formula-sheet class)
- Lib: v5
- Engine: needs XeLaTeX (main sample loads `metalogo`, "written especially for XeLaTeX users" per its CTAN page, rbt-mathnotes.tex:39; the package itself has a pdfTeX fallback, rbt-mathnotes.sty:127-131, so the three examples are pdfLaTeX-compatible)
- Look carried by: mixed (main sample: class `ltxguidex` plus the CTAN package `rbt-mathnotes` plus Fira fonts in the preamble; examples: the three CTAN classes `rbt-mathnotes`, `-hw`, `-formula-sheet`)
- Class origin: ctan (the zip is the CTAN package; `ltxguidex` is on CTAN and in TeX Live but not bundled, its source was not read)
- Main file: rbt-mathnotes.tex (other samples: examples/cheat-sheet.tex, examples/multivar.tex, examples/topology-hw-1.tex)
- Read: main yes, zip-local classes and styles all (rbt-mathnotes.cls, -hw.cls, -formula-sheet.cls, rbt-mathnotes.sty, -util.sty, -messages.sty read in full; ltxguidex and the packages it loads not read)

## Verdict
yes. Every .cls and .sty in the zip is the released CTAN package `rbt-mathnotes` (W1; the manifest origin is mirrors.ctan.org/macros/latex/contrib, and the file list in the manual header, rbt-mathnotes.tex:16-27, is exactly the zip's content), so they are class ways, not bespoke code. The only code defined by the samples themselves is `\newcommand` aliases, math-macro aliases and one preset for showexpl; all reduce to lib ways. No TikZ or other artwork, no external tool is needed to build any sample (the index option only adds `\makeindex`, rbt-mathnotes.sty:1047-1050). Two ways are new: `list.changelog` and `xref.knowledge`.
Caveat for re-reading under another definition: if the rbt-mathnotes files were treated as zip-local, the following would be BESPOKE/class: the `\maketitle` and `\thanks` text generator (rbt-mathnotes.sty:436-535, 579-626), the `problem` environment with numbering and label plumbing (rbt-mathnotes-hw.cls:178-241), the sectioning-command `(number)` override (rbt-mathnotes-hw.cls:243-312), the memoir patch (rbt-mathnotes.cls:52-58) and the option machinery (rbt-mathnotes-util.sty:73-135). Under W1 they are published, so they are not blockers here.

## Blockers
none

## Class setting
- Class: `class.ltxguidex` (main sample, no options, rbt-mathnotes.tex:34); `class.rbt-mathnotes` (examples/multivar.tex:34, option `knowledge`; memoir-based, rbt-mathnotes.cls:39-41); `class.rbt-mathnotes-hw` (examples/topology-hw-1.tex:34, options `twocolumn, noxcolor, maketitle`; loads `rbt-mathnotes`, rbt-mathnotes-hw.cls:48); `class.rbt-mathnotes-formula-sheet` (examples/cheat-sheet.tex:34; article-based, rbt-mathnotes-formula-sheet.cls:39). The package `rbt-mathnotes.sty` is the style the first class loads at rbt-mathnotes.cls:202 and the main sample loads alone; it is recorded under `class.rbt-mathnotes` (a house style is class-like).
- Class-native vocabulary used: `ltxguidex`: environments `keys`, `desc`, `LTXexample`, commands `\key`, `\m`, `\bool`, `\option`, `\package`, `\ctan`, `\https`, verbatim shorthand between bars, and the `note` environment (rbt-mathnotes.tex:80, 134-136, 263, 270; the package defines `note` only under the `theorems` option, rbt-mathnotes.sty:677, 812-817, which line 59 switches off, so `note` must come from `ltxguidex`: inferred, source not read). `rbt-mathnotes`: `\mathnotes{date,author,title,name,email,institution,course,semester,instructor}` (rbt-mathnotes.sty:381-418), `thm` `lem` `cor` `prop` `defn` `notation` `ex` and `note` `remark` `hint` `abuse-of-notation` environments, `\numberthis` `\labelthis{}` `\newacronym` `\newacronyms` `\TODO` `\email` `\Th`, symbol commands (`\R` `\Z` `\after` `\grad` `\pd` `\dd` `\vec` ...), `\knowledge`, `\reintro`. `rbt-mathnotes-hw`: `problem[number or title= label=]`, `\prob`, `\section(number){}`. `rbt-mathnotes-formula-sheet`: `\mathnotes` keys `columns` `balance columns` `width` `height`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class (main) | rbt-mathnotes.tex:34 | `class.ltxguidex` | no options; not bundled, source not read |
| class (notes, with knowledge) | examples/multivar.tex:34 | `class.rbt-mathnotes` | option knowledge |
| class (homework) | examples/topology-hw-1.tex:34 | `class.rbt-mathnotes-hw` | twocolumn, noxcolor, maketitle |
| class (formula sheet) | examples/cheat-sheet.tex:34 | `class.rbt-mathnotes-formula-sheet` | no options |
| base class of notes class | rbt-mathnotes.cls:39-41 | `class.memoir` | PassOptionsToClass openany, oneside |
| base class of formula sheet | rbt-mathnotes-formula-sheet.cls:39 | `class.article` | none |
| style package loaded under ltxguidex | rbt-mathnotes.tex:53-59 | `class.rbt-mathnotes` | nomaketitle, notitles, noxcolor, noenumitem, notheorems; fonts, stix, symbols stay true (rbt-mathnotes.sty:53-60) |
| sans text font | rbt-mathnotes.tex:61 | `font.helvet` | `\usepackage{FiraSans}`, no options (CTAN page not read) |
| mono text font | rbt-mathnotes.tex:62 | `font.mono` | `\usepackage{FiraMono}`, no options |
| TeX logos | rbt-mathnotes.tex:39, 138 | `font.icons` | `metalogo`, `\XeTeX` `\LuaTeX` |
| text and maths fonts, XeTeX/LuaTeX branch | rbt-mathnotes.sty:98-122 | `font.unicode-math` and `font.fontspec` | unicode-math warnings-off; `\setmainfont` STIX2Text (`*-Regular` `*-Italic` `*-Bold` `*-BoldItalic`, Extension .otf); `\setmathfont` STIX2Math StylisticSet 1 and 8; OTF fonts not in the zip (stix2-otf) |
| maths fonts, other engines | rbt-mathnotes.sty:127-130 | `font.mathptmx` | `stix2` with option upint |
| maths packages | rbt-mathnotes.sty:90, 95, 131 | `math.mathtools`, `math.amsmath` | amsmath 2013/01/14 or later |
| maths symbol commands | rbt-mathnotes.sty:139-272 | `math.amsmath`, `math.amssymb` | `\DeclareMathOperator` img pre Stab FixPt id curl dive; `\ProvideDocumentCommand` aliases of `\mathbb`, `\cap`, `\cup`, `\mid`, `\hookrightarrow`, `\varnothing`; `\dd` `\pd` fractions |
| equation numbering macros | rbt-mathnotes.sty:275-287; rbt-mathnotes.tex:270-293 | `math.amsmath`, `xref.kernel` | `\tag{\theequation}` plus `\refstepcounter{equation}`, optional `\label` |
| display maths in samples | rbt-mathnotes.tex:271-275; examples/topology-hw-1.tex:81-84; examples/multivar.tex:187-191, 283-285 | `math.amsmath` | `alignat*`, `gather*`, `equation`, `\intertext`, `\shortintertext`; `\mathclap` (multivar.tex:314) is `math.mathtools` |
| fractions | examples/cheat-sheet.tex:35 | `math.nicefrac` | `\usepackage{nicefrac}` |
| acronym macro | rbt-mathnotes.sty:351-379 | `mark.kernel` | `\newacronym` defines a command that prints `\textsc{text}` |
| email macro | rbt-mathnotes.sty:1052-1065; rbt-mathnotes.tex:69 | `meta.hyperref`, `mark.kernel` | `\href{mailto:..}{\texttt{..}}` when hyperref is loaded |
| links in text | rbt-mathnotes.tex:147, 467; examples/multivar.tex:485 | `meta.hyperref` | `\href` |
| to-do marker | rbt-mathnotes.sty:844-851 | `box.fancybox`, `mark.kernel` | `\framebox{\textbf{TODO: ..}}` |
| paragraph shape | rbt-mathnotes.sty:1101, 1105-1106 | `sp.lengths` | parindent 0em, parskip 1em, footnotesep baselineskip |
| contents wrapper | rbt-mathnotes.sty:1107-1118 | `toc.kernel`, `sp.lengths` | `\tableofcontents` inside a group with parskip 0pt |
| colours | rbt-mathnotes.sty:295-321 | `color.xcolor` | xcolor option rgb; `\providecolorset{HTML}` MNthmtitle 0F0066, MNthmbg EBFEFF, MNthmline 4836B3, MNsecnum 8015A1, MNlink 113DB8 and others; off in main and homework (noxcolor) |
| link colours | rbt-mathnotes.sty:889-897 | `meta.hyperref` | hidelinks, colorlinks=true, allcolors=MNlink; off under noxcolor |
| theorem environments | rbt-mathnotes.sty:679-798 | `thm.ntheorem`, `thm.mdframed` | `ntheorem[thmmarks,amsmath,amsthm]`; `\mdfdefinestyle` theorem (linewidth 1.5pt), minor-theorem (0.75pt), example, definition, note; `\mdtheorem[style=..]{thm}{Theorem}` and lem, cor, prop, defn, notation, ex; used by examples/multivar.tex:144, 164, 176 |
| note-like boxes | rbt-mathnotes.sty:812-838 | `box.mdframed` | `\newmdenv[style=note, startinnercode=..]` for note, remark, hint, abuse-of-notation; style note: topline, rightline, bottomline false, linewidth 2pt; `remark` used at examples/topology-hw-1.tex:148 |
| proof | examples/topology-hw-1.tex:134 | `thm.ntheorem` | `proof` environment (supplied through ntheorem with the amsthm option; not read) |
| homework theorem styles | rbt-mathnotes-hw.cls:50-75 | `thm.ntheorem` | undefines the mdtheorem environments, then `\theoremstyle{definition}` and `\newtheorem` for thm lem cor prop defn notation ex |
| problem environment | rbt-mathnotes-hw.cls:178-241 | `class.rbt-mathnotes-hw` | class-native: `problem[number, title, label]` over an mdframed `note` box, `\addcontentsline{toc}{chapter}`, `\prob`; used at examples/topology-hw-1.tex:57-60 |
| formula-sheet theorem labels | rbt-mathnotes-formula-sheet.cls:49-74 | `thm.class-native` | run-in bold labels Thm Lem Cor Prop Defn Ex Note Rmrk; reduces to `mark.kernel` |
| title block (main) | rbt-mathnotes.tex:69-73 | `front.maketitle`, `front.thanks` | title, author with `\thanks{\email{..}, \https{..}}`, date, `\maketitle` |
| title block (notes package) | rbt-mathnotes.sty:420-628 | `front.class-native` | centred title `\HUGE\bfseries`, author `\LARGE` in a tabular, date `\large`, skips 1em, 0.5em, 1.5em, footnote symbols, `\thispagestyle{empty}`; generated `\thanks` from `\mathnotes`; off in main (nomaketitle) |
| front-matter keys | rbt-mathnotes.sty:381-418; examples/topology-hw-1.tex:35-42; examples/multivar.tex:36-43 | `front.class-native` | `\mathnotes{instructor, name, email, course, institution, semester}` strings |
| title (formula sheet) | rbt-mathnotes-formula-sheet.cls:43-47; examples/cheat-sheet.tex:45-47, 53-56, 58 | `front.maketitle` | `\@maketitle` set to bold title, author, date on one line; key list height=4in, width=6in |
| abstract | rbt-mathnotes.tex:75-78 | `abs.kernel` | `abstract` environment; class restyling unread |
| contents | rbt-mathnotes.tex:85; examples/multivar.tex:126 | `toc.kernel` | `\tableofcontents` |
| page breaks | rbt-mathnotes.tex:87, 128, 426; examples/topology-hw-1.tex:123; examples/cheat-sheet.tex:176 | `pg.break` | `\pagebreak` |
| vertical fill | rbt-mathnotes.tex:86, 127 | `sp.manual-space` | `\vfill` |
| sections (main) | rbt-mathnotes.tex:130, 261, 378, 383, 427 | `head.kernel` | `\section`; look set by `ltxguidex` (unread) |
| numbering depth | rbt-mathnotes.cls:42-43 | `num.secnumdepth` | secnumdepth and tocdepth = subsubsection |
| chapter style | rbt-mathnotes.cls:60-96 | `head.memoir-style` | `\makechapterstyle`: number `\normalfont\huge` in MNsecnum, `\llap\makebox[\chapindent]`, title `\raggedright\huge`, after title `\vskip\onelineskip\hrule\vskip\onelineskip` |
| section styles | rbt-mathnotes.cls:98-191 | `head.memoir-style`, `color.xcolor` | `\makeheadstyles`: number format colour MNsecnum plus `\quad`; section `\bfseries\LARGE`, before skip -1\onelineskip plus -0.5 minus -0.5, after 1\onelineskip plus 0.1; subsection bold hang; subsubsection `\normalsize\bfseries`; paragraph run-in bold (after -1em); subparagraph italic with period |
| formula-sheet section | rbt-mathnotes-formula-sheet.cls:150 | `head.kernel` | `\def\section#1{\hrulefill\\\textbf{#1}\\}`; reduces to `sp.rule` plus `mark.kernel` |
| section number override | rbt-mathnotes-hw.cls:243-312, 300, 319 | `class.rbt-mathnotes-hw` | class-native `\section(number)[toc][head]{title}`; `\thesection` = `\arabic{section}`, `\counterwithout{figure}{chapter}` (`num.counters`) |
| page style | rbt-mathnotes.cls:45-48 | `hf.memoir-pagestyle` | plain style: empty feet, `\thepage` at the right of the head (even and odd) |
| page style (homework) | rbt-mathnotes-hw.cls:322-325 | `hf.memoir-pagestyle` | headings style: odd head `\@author,~\textit{\@title}` left, `\thepage` right |
| page geometry (formula sheet) | rbt-mathnotes-formula-sheet.cls:128-140 | `page.geometry` | letterpaper, margin=0.1in; paperwidth and paperheight from the width and height keys |
| page geometry (homework example) | examples/topology-hw-1.tex:47-50 | `page.geometry` | letterpaper, margin=1in |
| Kindle layout | rbt-mathnotes.sty:643-654 | `page.memoir-layout` | option kindle (off in all samples): `\setstocksize{12.2cm}{9cm}`, `\settypeblocksize`, `\setlrmargins{0cm}{*}{*}` |
| columns | examples/topology-hw-1.tex:34; rbt-mathnotes-hw.cls:316 | `cols.twocolumn-option`, `sp.lengths` | twocolumn; columnsep 3em |
| formula-sheet columns | rbt-mathnotes-formula-sheet.cls:85-116, 120-133 | `cols.multicol`, `font.size-commands` | whole body wrapped in `multicols*` (or `multicols` with key balance columns), default 3 columns, `\scriptsize` |
| formula-sheet spacing | rbt-mathnotes-formula-sheet.cls:101-102, 142 | `sp.lengths` | abovedisplayskip 0pt, belowdisplayskip 0pt, parskip 0.25em |
| bottom alignment | examples/topology-hw-1.tex:51 | `pg.flush` | `\raggedbottom` |
| ragged text | examples/cheat-sheet.tex:177 | `sp.ragged` | `\raggedright` |
| lists | rbt-mathnotes.tex:105-124, 137-152; examples/topology-hw-1.tex:68; examples/multivar.tex:293; examples/cheat-sheet.tex:204-211 | `list.kernel` | `itemize`, `enumerate` |
| compact lists | rbt-mathnotes-formula-sheet.cls:144-148; rbt-mathnotes.sty:289-290 | `list.enumitem` | `\setlist{nosep}`; enumitem otherwise on by default (off in main, noenumitem) |
| inline marks | rbt-mathnotes.tex:140, 339, 465; rbt-mathnotes.sty:848, 1054; examples/topology-hw-1.tex:69, 137 | `mark.kernel` | `\texttt`, `\textsc`, `\textbf`, `\emph` |
| boxed math | examples/multivar.tex:146 | `box.fancybox` | `\fbox` |
| footnotes | examples/multivar.tex:151 | `fn.kernel` | `\footnote` |
| footnote layout | rbt-mathnotes.sty:1095-1101 | `fn.footmisc` | option footnotes (off in all samples): `bottom, hang` |
| long table | rbt-mathnotes.tex:37, 163-196 | `tbl.longtable` | column spec `rl`, math cells |
| table option bundle | rbt-mathnotes.sty:1067-1080 | `tbl.multirow`, `tbl.booktabs`, `tbl.longtable`, `tbl.nicematrix` | option tabu (off in all samples): multirow, booktabs, longtable, tabu; `\Th` = bold `\multicolumn` |
| figure captions | rbt-mathnotes.sty:1082-1093 | `fig.graphicx`, `cap.caption` | option figures (off; no figure in any sample): `\captionsetup{format=hang, font={sf,footnotesize}, margin=1in}` |
| listings defaults | rbt-mathnotes.sty:323-346 | `code.listings` | option listings (off): basicstyle ttfamily, language Mathematica, tabsize 4, basewidth 0.55em, breaklines |
| listing look in the manual | rbt-mathnotes.tex:43-48, 51 | `code.listings` | `\lstset{basewidth=0.6em}`; showexpl preset language=[LaTeX]TeX, numbers=none |
| code-and-result examples | rbt-mathnotes.tex:270-276, 285-293, 302-322, 355-359 | `class.ltxguidex` | class-native `LTXexample` |
| option-and-key lists | rbt-mathnotes.tex:134-223, 227-259, 328-347, 402-424 | `class.ltxguidex` | class-native `keys` with `\key`, `\m`, `\bool` |
| command descriptions | rbt-mathnotes.tex:263-265, 278-280, 390-394 | `class.ltxguidex` | class-native `desc` |
| callout boxes | rbt-mathnotes.tex:80-83, 89-125 | `class.ltxguidex` | `note` environment (inferred, see Class setting) |
| wide blocks | rbt-mathnotes.tex:38 | `page.adjustwidth` | `changepage` loaded; no `adjustwidth` call in the sample |
| version history | rbt-mathnotes.tex:40, 459-473 | `list.changelog` | `\usepackage{changelog}`, `changelog[author=..]` and `version[v=, date=, short]` |
| notion links and index | rbt-mathnotes.sty:904-1033; examples/multivar.tex:34, 57-119, 336 | `xref.knowledge` | `\RequirePackage[quotation, notion, makeidx]{knowledge}`; `\knowledge{notion, index=.., url=..}` with synonym lines; `\knowledgestyle*` colours MNlink MNintro MNunknown; `\reintro*` |
| index | rbt-mathnotes.sty:1047-1050; examples/multivar.tex:59, 63, 506 | `idx.makeidx` | `\makeindex` under option index; `\index{..}`, `\printindex` (multivar sets only `knowledge`, so its index is empty without `\makeindex`) |
| appendix and back matter | examples/multivar.tex:443, 445 | `num.appendix`, `class.memoir` | `\appendix`, `\backmatter` |
| cross-references | rbt-mathnotes.tex:292 | `xref.kernel` | `\ref` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\mn` alias | rbt-mathnotes.tex:41 | yes | `\newcommand` of `\ctan{rbt-mathnotes}`, inline expansion |
| showexpl preset redefinition | rbt-mathnotes.tex:43-48 | yes | a keyval list set through a package-internal macro: `code.listings` parameters language=[LaTeX]TeX, numbers=none (showexpl and `ltxguidex` source not read) |
| `ctandescription` and `\pkg` | rbt-mathnotes.tex:64-66 | yes | defined, never used in the sample; `description` with `\item[\ctan{..}]`, `list.kernel` |
| math aliases `\normalized \gr \ddx \vl` | examples/cheat-sheet.tex:36-43; examples/multivar.tex:45-52 | yes | `\newcommand` or `\let` aliases of `\frac`, `\grad`, `\left\langle`; inline expansion, `math.amsmath` |
| math aliases `\T \basis \Ar \Ars` | examples/topology-hw-1.tex:45-46, 135-136 | yes | `\def` aliases of `\mathcal{..}` and `A_{..}`; inline expansion |
| rbt-mathnotes package and class code (expl3) | rbt-mathnotes.sty, rbt-mathnotes-util.sty:73-135, rbt-mathnotes-hw.cls:178-312, rbt-mathnotes.cls:52-58 | not applicable | published on CTAN (W1), so not bespoke; the irreducible parts are listed in the Verdict caveat |

## Content-opaque
none

## Lib changes
- New ways proposed:
  - `list.changelog` `changelog` (CTAN, TeX Live, MiKTeX, LPPL 1.3c; Rebecca Turner; ctan.org/pkg/changelog read; pdfTeX support not stated): a version-history environment. W1: on CTAN. W2: key=value options (`author`, `v`, `date`, `short` seen at rbt-mathnotes.tex:459-460; the full key list was not read). W3: serves the changelog of any project. W4: `\usepackage{changelog}` plus the `changelog` and `version` environments around entries. Not `dtx.doc` (documents DocStrip sources); not `list.kernel` (no dated, keyed entries).
  - `xref.knowledge` `knowledge` (named as `\ctan{knowledge}` at rbt-mathnotes.tex:233-234 and loaded at rbt-mathnotes.sty:919; its CTAN page and source were not read, so W1 rests on the zip's own CTAN link): hyperlinks from notions to their definition points, with an automatic index. W2: package options `quotation`, `notion`, `makeidx`, declarations `\knowledge{notion, index=.., url=..}` followed by synonym lines, `\knowledgestyle*{name}{keys}` with colour and boldface keys (multivar.tex:57-119; rbt-mathnotes.sty:977-1031). W3: any maths notes. W4: preamble lines and body quotation or `\intro`/`\reintro` wrappers. Not `xref.hyperref` (`\autoref`), not `idx.makeidx` (a plain index).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
