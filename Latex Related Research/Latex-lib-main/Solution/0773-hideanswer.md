no

# 0773-hideanswer: hideanswer (answer-hiding package and its bilingual manual)

- Unverified: read from the source, not compiled.
- Source: Source/0773-hideanswer/ (origin: https://mirrors.ctan.org/macros/latex/contrib/hideanswer.zip; licence: MIT, hideanswer.sty:8-9 and README.md:13)
- Kind: misc (the sample is a bilingual English/Japanese package manual; the manifest hint `exam` names the package's topic, not the document)
- Lib: v6
- Engine: needs LuaLaTeX (`luatexja`, `luatexja-otf`, `luatexja-preset` at hideanswer-doc.tex:14,15,54; `fontspec` at :53); hideanswer.sty alone loads only `color`, `graphicx`, `xparse` (hideanswer.sty:16,19,22) and is pdfLaTeX-compatible
- Look carried by: preamble (hideanswer-doc.tex:13-131 sets the whole look on top of the published class jlreq; hideanswer.sty carries no look, it only switches visibility of text)
- Class origin: tex-distribution-unbundled
- Main file: hideanswer-doc.tex, 445 lines (other samples: none; hideanswer.sty, 79 lines, is the package documented; hideanswer-doc.pdf is the compiled manual, not read)
- Read: main yes, zip-local classes and styles all (hideanswer.sty is the only one; no .cls in the zip)

## Verdict
No, on one narrow blocker. The manual's look is a thin composition of published ways over the published class `jlreq`: every preamble macro reduces by inline expansion (see Bespoke code), there is no `ART`, and `hideanswer.sty` is itself a CTAN package that passes W1 to W4 as the new way `NEW:exam.hideanswer`. But the preamble loads `jlisting` (hideanswer-doc.tex:110): it is not in the zip, `https://ctan.org/pkg/jlisting` returned 404 when read, and I cannot show it is published, so by the rubric's closing rule ("if you cannot show it, the answer is no") the verdict is `no`. All four `lstlisting` blocks hold ASCII LaTeX only (:246-248, :272-284, :328-330, :357-369), so the output very likely does not depend on it, but its source was not read. If `jlisting` is shown to be on CTAN or in TeX Live, or is dropped as output-neutral, this becomes `yes`. A stricter reader could also count the two sequence counters (:60-63) as hand-rolled counters; I judged them reducible (no conditionals, kernel counters in their ordinary role).

## Blockers
- `UNMAPPED/preamble` `jlisting` (Japanese-text extension of `listings`) loaded unconditionally; not shipped, W1 not established, source not read; the component itself is covered by `code.listings` (hideanswer-doc.tex:110)

## Class setting
- Class: `class.jlreq` options: `fleqn`, `paper=a4paper`, `fontsize=10pt`, `open_bracket_pos=zenkakunibu_nibu`, `hanging_punctuation` (hideanswer-doc.tex:1-8). The class is not in the zip and its source was not read; ctan.org/pkg/jlreq (read): Noriyuki Abe, Simplified BSD, class and JFM files for LuaTeX-ja, pLaTeX and upLaTeX, in TeX Live and MiKTeX.
- Class-native vocabulary used: `\jlreqsetup{itemization_beforeafter_space=0pt, itemization_itemsep=0pt}` (:9-12; no `itemize` is used in the body), the options `open_bracket_pos` and `hanging_punctuation`, the length unit `\zw` (:50, from the Japanese engines), `\title` `\author` `\date` `\maketitle` (:142-146, :84).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | hideanswer-doc.tex:1-12 | `class.jlreq` | fleqn, paper=a4paper, fontsize=10pt, open_bracket_pos=zenkakunibu_nibu, hanging_punctuation; `\jlreqsetup` item spacing 0pt |
| paper and size | hideanswer-doc.tex:3-4 | `page.class-options` | a4paper, 10pt |
| page geometry | hideanswer-doc.tex:27-31 | `page.geometry` | truedimen, margin=30truemm, includehead |
| header and footer | hideanswer-doc.tex:33-39, :147 | `hf.fancyhdr` | `\pagestyle{fancy}`; `\rhead[t]{icon quad page/total}`, `\lhead[page/total quad icon]{t}`, `\cfoot{}`; called with author+icon and title "The hideanswer package" |
| page X of Y | hideanswer-doc.tex:32, :36-37 | `pgnum.lastpage` | `\thepage/\pageref{LastPage}` |
| first-page style | hideanswer-doc.tex:84 | `hf.pagestyle-kernel` | `\thispagestyle{fancy}` after `\maketitle` |
| line spacing | hideanswer-doc.tex:40-41, :108 | `sp.setspace` | `\setstretch{1.155}`, then `\setstretch{1.05}` (the later one stands) |
| lengths | hideanswer-doc.tex:44-50, :107, :109 | `sp.lengths` | display skips x0.125 at begin document, `\jot`=0pt, `\mathindent`=2\zw, `\fboxsep`=1em, glue `2.40554pt plus 1.49994pt minus 0.59998pt` |
| manual spacing | hideanswer-doc.tex:42-43, :85, :92, :97 | `sp.manual-space` | `\vspace{0.25\baselineskip}`, `\vspace{\baselineskip}`, `\hspace*{\fill}`, `\raisebox{1pt}`, `\\[0.25\baselineskip]` (:142-144), `\hspace*{0.14\textwidth}` (:250) |
| manual bullets | hideanswer-doc.tex:171-174 | `sp.manual-space` | `\textbullet\ item\\` lines in a bilingual block; no list environment is used |
| equation layout | hideanswer-doc.tex:2, :17, :52 | `math.eqnumber`, `math.amsmath` | `fleqn`; `amsmath`, `\allowdisplaybreaks[2]` |
| display maths (content) | hideanswer-doc.tex:275 | `math.kernel` | `\[F\]` inside a demo box |
| float parameter | hideanswer-doc.tex:51 | `fig.placement` | `\floatpagefraction`=0.75 (no float occurs in the body) |
| fonts | hideanswer-doc.tex:53 | `font.fontspec` | `fontspec[no-math]` |
| Japanese typesetting | hideanswer-doc.tex:14, :15, :54 | `lang.cjk` | `luatexja`, `luatexja-otf`, `luatexja-preset[no-math,deluxe,haranoaji]` |
| sizes and shapes | hideanswer-doc.tex:113-118 | `font.size-commands` | `\small` in listing styles |
| inline marks | hideanswer-doc.tex:21, :66, :86, :92, :115-116 | `mark.kernel` | `\textsf`, `\texttt`, `\itshape`, `\bfseries` |
| double underline | hideanswer-doc.tex:19, :21, :66, :68 | `mark.ulem` | `ulem[normalem]`, `\uuline{...}` |
| TeX logos | hideanswer-doc.tex:127, :171 | `font.icons` | `bxtexlogo` loaded (package is the parameter); `\LaTeXe` printed |
| title block | hideanswer-doc.tex:142-146, :83-90, :149 | `front.maketitle` | `\title` with `\\[0.25\baselineskip]` breaks, `\author{Yukoh KUSAKABE}`, `\date{\today}`, then a two-column English/Japanese label row |
| date format | hideanswer-doc.tex:56, :146 | `front.datetime` | `datetime2[style=iso]`, `\today` |
| bilingual blocks | hideanswer-doc.tex:55, :80-82, :151-156 | `cols.paracol` | `multicolpar` `{2}`: successive paragraphs go to successive columns (English left, Japanese right) |
| bilingual headings | hideanswer-doc.tex:60-72, :168, :184, :193, :205, :438 | `cols.paracol`, `mark.ulem`, `mark.kernel`, `num.counters`, `xref.hyperref` | `\hypertarget{key}{\mbox{}}`, two `\uuline{\raisebox{1pt}{\textsf{\S\ N\quad title}}}`, `\stepcounter`, `\vspace{\baselineskip}` |
| hand-set contents list | hideanswer-doc.tex:62-63, :73-79, :158-166 | `xref.hyperref`, `cols.paracol`, `num.counters` | `\hyperlink{key}{\S\ N\quad title}` in two columns, five entries; entry 5 targets `moreinfo` (:166) but the section key is `contact` (:438), a broken link in the sample |
| section command | hideanswer-doc.tex:20-22 | `head.titlesec`, `num.counters` | `titlesec[explicit]`, `\titleformat{\section}[hang]{}{}{0pt}{\uuline{...}}[\vspace{0.35\baselineskip}]`; `\thesection` = `\S\,\arabic{section}`; no `\section` call occurs in the body |
| hyperlinks and metadata | hideanswer-doc.tex:57, :132-141 | `meta.hyperref` | `unicode`; bookmarksnumbered, colorlinks, linkcolor=blue, urlcolor=blue, setpagesize=false, pdftitle/pdfauthor/pdfsubject/pdfkeywords |
| URLs | hideanswer-doc.tex:441-442 | `meta.url` | `\url{...}` (provided through hyperref) |
| table | hideanswer-doc.tex:440-444 | `tbl.tabular` | `{rl}` contact block, centred by `\hspace*{\fill}` |
| code listings | hideanswer-doc.tex:110-126, :246-248 | `code.listings` | `language=[LaTeX]TeX`, frame=single, breaklines, `columns=[l]{fullflexible}`, xleftmargin=xrightmargin=0.1709\textwidth, lineskip=-0.5ex, basicstyle `\ttfamily`; `jlisting` is the blocker |
| short verbatim | hideanswer-doc.tex:128-129 | `code.verbatim` | `shortvrb`, `\MakeShortVerb{\|}`; `v`-type argument of `\macroexplanation` (:91) |
| framed demo boxes | hideanswer-doc.tex:59, :94-98, :107 | `box.fancybox`, `box.minipage` | `dashbox` `\dbox{\parbox{0.625\textwidth}{...}}` (dashed frame, package is the parameter), `\fboxsep`=1em |
| page breaks | hideanswer-doc.tex:183, :236, :262, :318, :344, :403 | `pg.break` | `\newpage` |
| header icon | hideanswer-doc.tex:16, :18 | `fig.graphicx` | `\includegraphics[width=16pt]{metaphysicaicon.pdf}` (file not in the zip) |
| colour of hidden text | hideanswer.sty:16, :36-37 | `color.color` | `\color{white}` then `\color{black}` |
| answer visibility switch | hideanswer.sty:25-31; hideanswer-doc.tex:130, :219-234 | `NEW:exam.hideanswer` | `\usepackage{hideanswer}` (no option, hideanswer-doc.tex:200); boolean `\sethideanswer` / `\unsethideanswer` |
| inline and block wrappers | hideanswer.sty:35-59; hideanswer-doc.tex:237-401 | `NEW:exam.hideanswer` | `\hideanswer{}` (white text, keeps space), `\smashanswer{}` (drops text and space), environments `hideanswerdiv`, `smashanswerdiv`; star forms invert the switch |
| graphics and alternatives | hideanswer.sty:63-77; hideanswer-doc.tex:404-436 | `NEW:exam.hideanswer`, `fig.graphicx` | `\hidegraphics[opts]{file}` (`\phantom`), `\smashgraphics`, `\switchanswer{when set}{when unset}` |

Not used in the sample: abstract, `\tableofcontents`, footnotes, captions, floats, theorems, bibliography, index, `itemize`/`enumerate`.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\metaphysicaicon` | hideanswer-doc.tex:18 | yes | alias: `\raisebox{-4.0pt}{\includegraphics[width=16pt]{metaphysicaicon.pdf}}` = `sp.manual-space` + `fig.graphicx`; the PDF is a missing asset |
| `\section` wrapper (`\@ifstar`) | hideanswer-doc.tex:23-26 | yes | inline: `\vspace{0.5\baselineskip}\section{X}`; star form adds `\vspace*{-\baselineskip}` after (both call the unstarred `\originalsection`); never called in the body |
| `\thesection` | hideanswer-doc.tex:22 | yes | `num.counters` `\renewcommand` |
| `\headertitle[icon]{title}` | hideanswer-doc.tex:35-39, called :147 | yes | expand the one call into `\rhead[..]{..}`, `\lhead[..]{..}`, `\cfoot{}` (`hf.fancyhdr`, `pgnum.lastpage`) |
| `\linespace`, `\linesmash` | hideanswer-doc.tex:42-43 | yes | aliases of `\vspace` (`sp.manual-space`); only `\linespace` is used (:92) |
| display-skip scaling | hideanswer-doc.tex:44-48 | yes | `\AtBeginDocument` plus `sp.lengths` assignments |
| counters `psuedosectioncounter`, `psuedocontentscounter` | hideanswer-doc.tex:60-63 | yes | kernel `\newcounter` `\setcounter` `\stepcounter` `\the..` (`num.counters`), no conditionals; the emitter may also print the numbers literally |
| `\psuedosection{key}{en}{ja}` | hideanswer-doc.tex:64-72 | yes | inline: `\hypertarget` + `multicolpar{2}` with two `\uuline{\raisebox{1pt}{\textsf{\S\ N\quad ..}}}` paragraphs + `\stepcounter` + `\vspace{\baselineskip}` |
| `\psuedocontents{key}{en}{ja}` | hideanswer-doc.tex:73-79 | yes | inline: `multicolpar{2}` with two `\hyperlink{key}{\S\ N\quad ..}` paragraphs + `\stepcounter`; numbers depend on call order, equal to the heading numbers |
| `translateing` environment | hideanswer-doc.tex:80-82 | yes | `multicolpar{2}` then `\vspace{\baselineskip}` |
| `\maketitletranslating` | hideanswer-doc.tex:83-90 | yes | `\maketitle`, `\thispagestyle{fancy}`, spacing, a `multicolpar{2}` label row |
| `\macroexplanation` (`v` argument) | hideanswer-doc.tex:91-93 | yes | centred `\texttt` line with the text escaped (or `\verb`), then `\linespace` |
| `macroexample` (`+b` body) | hideanswer-doc.tex:94-98 | yes | inline wrapper `\noindent\hspace*{\fill}\dbox{\parbox{0.625\textwidth}{body}}\hspace*{\fill}` then `\vspace{\baselineskip}` |
| `macroexample*` | hideanswer-doc.tex:99-105 | yes | same with an inner `\begin{<env>}`; defined, never used |
| `\code`, `\commandtojskip` | hideanswer-doc.tex:106, :109 | yes | `\let\code\texttt`; glue alias (`mark.kernel`, `sp.manual-space`) |
| `\lstset` block | hideanswer-doc.tex:111-126 | yes | declarative `code.listings` keys |
| hideanswer.sty macros and `\newif` | hideanswer.sty:25-77 | not bespoke | published CTAN package (`NEW:exam.hideanswer`); its conditionals are inside the published package |

## Content-opaque
none (Japanese and English text, `\[F\]`, the contact table cells and the header icon are content or `fig.graphicx`; no TikZ, PGF or picture drawing occurs).

## Lib changes
- New ways proposed: `NEW:exam.hideanswer`: `hideanswer` (CTAN, macros/latex/contrib/hideanswer, MIT, Yukoh Kusakabe, v1.2 of 2024/11/23; loads `color`, `graphicx`, `xparse`; pdfLaTeX-compatible), `\usepackage{hideanswer}`, a global boolean `\sethideanswer` / `\unsethideanswer`, inline wrappers `\hideanswer` `\smashanswer` `\switchanswer`, environments `hideanswerdiv` `smashanswerdiv`, graphics wrappers `\hidegraphics` `\smashgraphics`, each with a star form that inverts the switch (hideanswer.sty:25-77). W1: on CTAN (manifest URL) and MIT (hideanswer.sty:8-9). W2: one boolean, no package option (hideanswer-doc.tex:200), arguments are content. W3: serves any exam, worksheet or answer-key document. W4: one preamble line, one switch line, body wrappers around the answer node. Not `mark.censor` (blacked-out boxes, other commands), not `exam.cloze` (LuaLaTeX gap fill with key=value options), not `exam.questions` (question environments and banks), not `mark.ulem`. Hidden text is only coloured white (the package says it is for paper, hideanswer-doc.tex:209-216).
- Considered, not proposed: `multicolpar` (ctan.org/pkg/multicolpar read: Max Hailperin and Mauro Orlandini, 1993, "put successive paragraphs in different columns", for translated parallel text; no licence or engine on the page) mapped to `cols.paracol` with the package as the parameter; `dashbox` mapped to `box.fancybox`; `bxtexlogo` mapped to `font.icons`; for `dashbox`, `bxtexlogo` and `luatexja` the CTAN origin rests on prior knowledge, their pages were not read; `jlisting` mapped to `code.listings` but W1 not established.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
