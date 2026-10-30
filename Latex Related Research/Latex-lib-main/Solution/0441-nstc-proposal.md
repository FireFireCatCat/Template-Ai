yes

# 0441-nstc-proposal: nstc-proposal (NSTC CM03, CM302 and progress-report LaTeX classes)

- Unverified: read from the source, not compiled.
- Source: Source/0441-nstc-proposal/ (origin: https://mirrors.ctan.org/macros/latex/contrib/nstc-proposal.zip; licence: LPPL 1.3c, LICENSE:1-17)
- Kind: report (grant proposal form CM03, publication list CM302, progress and final report)
- Lib: v4
- Engine: pdfLaTeX-compatible (the three classes and their samples run under pdfLaTeX through CJKutf8 and XeLaTeX through xeCJK, README.md:12-15, nstc-proposal.dtx:300-346; LuaLaTeX is not supported, dtx:298; the manual driver itself needs XeLaTeX, dtx:39-45)
- Look carried by: class (the three published classes carry every visual choice; the samples add only option `libertine` and the packages `microtype`, `hyperref[hidelinks]`, `doi`)
- Class origin: ctan (package nstc-proposal, read at ctan.org/pkg/nstc-proposal: CTAN, LPPL 1.3c, author Liang-Ting Chen)
- Main file: nstc-proposal.dtx (the only file with `\documentclass` and `\begin{document}` is the manual driver, dtx:27-51; the template samples are embedded in it: proposal.tex dtx:132-145, bibliography.tex dtx:151-163, report.tex dtx:171-202; other samples: README.md:151-167, 186-201, 209-226; compiled example/*.pdf not read)
- Read: main yes, zip-local classes and styles all (no `.cls` is in the zip: the three classes exist as DocStrip source inside nstc-proposal.dtx, which was read in full, 480 lines; nstc-proposal.ins:20-51 only names the generated files)

## Verdict
Yes. The look is carried by three published CTAN classes, `nstc-cm03`, `nstc-cm302` and `nstc-report`, each a short layer over `article`, and the samples add only a class option and three published packages. Every component reduces to a lib way: the class option line, `geometry`, `setspace`, `fancyhdr`+`lastpage`, `titlesec` run-in headings, `newtx`/`libertine`, `xeCJK`/`CJKutf8`, BibTeX. There is no artwork, no external tool beyond BibTeX, and no zip-local macro that the sample relies on. The class internals (an `\@maketitle` redefinition, a no-op `\section`, an `\everypar` trick) are published CTAN code of a class way, so they are not counted as zip-local bespoke code; see the Bespoke code table for the reduction each would have if counted.

## Blockers
none

## Class setting
- Class: `class.nstc-cm03` options: `libertine` (dtx:133); the class fixes `\LoadClass[a4paper,12pt,onecolumn,twoside]{article}` (dtx:285); option `kaiti` exists (dtx:277, 307-310, XeLaTeX only); 12 options are refused with a warning and removed (dtx:247-270); all others pass to article (dtx:283)
- Class: `class.nstc-cm302` options: none (dtx:152); same shared option handling
- Class: `class.nstc-report` options: none (dtx:172); same shared option handling
- Class-native vocabulary used:
  - `nstc-cm03`: `\ProposalBackground` `\ProposalMethod` `\ProposalPlan` `\ProposalIntegration` (dtx:137-140, defined 441-444), helper `\zhsection{title}{text}` (dtx:435); README.md:137-143 gives the plain `\section` plus `\vskip1em` alternative
  - `nstc-cm302`: no commands; the class prints the form heading and footer and swallows `\section` (dtx:393-394, 428); the sample is `\nocite{*}` and a bibliography (dtx:158-161)
  - `nstc-report`: `\frontmatter` (dtx:468-473), `\maketitle` that prints only `\title` (dtx:457-466, README.md:211-229)
- Assets (not blockers): system fonts BiauKai, BiauKaiTC, Kaiti TC, Heiti TC, `bkai00mp.ttf` from `arphic-ttf` (dtx:308-332), the `arphic` Type 1 font `c70bkai.fd` (dtx:342), `LibertinusMath-Regular.otf` (dtx:356); the manual includes `example/proposal.pdf` and `example/bibliography.pdf` (dtx:477)
- Helper loads with no printed effect: `iftex` (`\iftutex` at dtx:300, 354, 367, 410, 416), `xifthen` (dtx:291; no `\ifthenelse` is used in the file)

## Component map
The first rows (up to `microtype`) are the template: the three classes and the three embedded samples. Rows tagged `[doc]` are the manual driver, not the template look. Ways between the class rows and the sample rows are what the classes compose internally; an emitter writes the class line and the sample's own lines.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class, proposal | dtx:133 (class code dtx:21-25, 285-445) | `class.nstc-cm03` | option `libertine`; base `article` via `\LoadClass` |
| document class, publication list | dtx:152 (class code dtx:21-25, 373-445) | `class.nstc-cm302` | no options |
| document class, report | dtx:172 (class code dtx:21-25, 456-474) | `class.nstc-report` | no options |
| paper, size, columns, sides | dtx:285; dtx:259-270, 283 | `page.class-options` | `a4paper,12pt,onecolumn,twoside`; refused: landscape, titlepage, notitlepage, 10pt, 11pt, letterpaper, a5paper, b5paper, executivepaper, legalpaper, twocolumn, openright |
| page geometry | dtx:286; dtx:70-71, 84 | `page.geometry` | `margin=2cm,bottom=2.4cm`; the report leaves user `\geometry` open |
| line spacing | dtx:287-288 | `sp.setspace` | `\onehalfspacing` |
| paragraph skip (report) | dtx:289 | `sp.lengths` | `\parskip` = 0pt |
| English text and math font (default) | dtx:366-370 | `font.newtx` | `newtxtext`, `newtxmath` |
| font feature reset and font tests (XeLaTeX) | dtx:368-369, 317, 321 | `font.fontspec` | `\defaultfontfeatures{}`; `\IfFontExistsTF{BiauKai}`, `{BiauKaiTC}` |
| English font with option `libertine` | dtx:352-359 | `font.libertine` | `libertine[tt=false]`; pdfTeX math: `newtxmath[libertine]` (dtx:358) |
| Unicode math (XeLaTeX, libertine) | dtx:355-356 | `font.unicode-math` | `unicode-math`; `\setmathfont[Scale=MatchUppercase]{LibertinusMath-Regular.otf}` |
| Chinese text, XeLaTeX | dtx:306-333 | `lang.cjk` | `xeCJK[PunctStyle=plain,no-math]`; `\setCJKmainfont` chain BiauKai, BiauKaiTC, `bkai00mp.ttf`, each `[AutoFakeBold=2.5]`; option kaiti: `Kaiti TC[BoldFont=*-Bold]`, `\setCJKsansfont{Heiti TC}` |
| Chinese text, pdfLaTeX | dtx:340-345 | `lang.cjk` | `CJKutf8`; env `zh` = `CJK*{UTF8}{bkai}`; document wrapped by `\AddToHook{begindocument/end}` and `{enddocument}` |
| Chinese font shape, pdfLaTeX | dtx:342-343 | `font.nfss` | `\input{c70bkai.fd}`; `\DeclareFontShape{C70}{bkai}{b}{n}{<-> CJKb * bkaiu}{\CJKbold}` |
| math package | dtx:292 | `math.amsmath` | loaded, no options |
| theorem package | dtx:292 | `thm.amsthm` | loaded, no `\newtheorem`, not used by any sample |
| page footer (cm03, cm302) | dtx:406-422; dtx:394, 396 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\headrulewidth`=0pt, `\fancyhead{}`, `\lfoot{表 CM03}` or `{表 CM302}`, `\cfoot{}`, `\rfoot{共 \pageref{LastPage} 頁 第 \thepage 頁}`; pdfTeX wraps the fields in `zh` |
| page X of Y | dtx:406, 417, 420 | `pgnum.lastpage` | `lastpage`, `\pageref{LastPage}` |
| footer gap | dtx:418, 421 | `sp.manual-space` | `\hspace{1em}` |
| page style (report) | dtx:467 | `hf.pagestyle-kernel` | `\pagestyle{plain}` |
| form heading on page 1 | dtx:393, 395, 397-399 | `front.class-native` | `三、研究計畫內容（以中文或英文撰寫）：` (cm03), `五、著作目錄（…頁數以 2 頁為限）：` (cm302), printed at begin-document in a group |
| form heading size | dtx:399 | `font.size-commands` | `\large` |
| form and section bold | dtx:399, 382-386 | `mark.kernel` | `\bfseries` |
| section headings (cm03) | dtx:381-386 | `head.titlesec` | `\titleformat{\section}[runin]{\bfseries\normalsize}{（\zhnum{section}）}{0em}{}`; `\subsection`, `\subsubsection` the same with label `\thesubsection` or `\thesubsubsection`, sep 0.5em |
| heading size | dtx:382-386 | `font.size-commands` | `\normalsize` |
| Chinese numeral labels | dtx:380, 382 | `mark.numspell` | `zhnumber` `\zhnum{section}` (CTAN, LPPL 1.3c, read at ctan.org/pkg/zhnumber); another package of the same type (a number printed as words, language as parameter), folded in, no new way |
| form section titles and prompt text | dtx:435, 441-444; dtx:137-140 | `head.class-native` | `\zhsection{title}{prompt}` = `\section{title}prompt\vskip1em`; four titles fixed by the class |
| gap after each prompt | dtx:435 | `sp.manual-space` | `\vskip1em` |
| bibliography title (cm03) | dtx:429 | `head.kernel` | `\renewcommand{\refname}{參考文獻}` at begin-document |
| bibliography title suppressed (cm302) | dtx:428 | `head.kernel` | `\renewcommand{\section}[2]{}` at begin-document |
| bibliography | dtx:142-143, 158-161, 194-196; example/sample.bib:1-19 | `bib.bibtex-bst` | styles `plain` (cm03, report), `abbrv` (cm302); `\bibliography{sample}`; `\nocite{*}` |
| report title | dtx:457-466 | `front.class-native` | `\@maketitle`: `\newpage \null \vskip 2em`, centered `\LARGE \@title \par`, `\vskip 1.5em`; `\footnote` = `\thanks`; no author or date |
| report title call | README.md:211, 215 | `front.maketitle` | `\title{...}` and `\maketitle` (the dtx report sample calls neither) |
| report page numbering | dtx:468-473 | `pgnum.pagenumbering` | `\pagenumbering{Roman}` for the contents, then `{arabic}` |
| contents | dtx:471; dtx:193 | `toc.kernel` | `\tableofcontents`; `\addcontentsline{toc}{section}{\refname}` |
| page breaks | dtx:469, 472; dtx:191, 197 | `pg.break` | `\clearpage` |
| sectioning (report sample) | dtx:176-190 | `head.kernel` | plain `\section`, `\subsection` of article |
| appendix | dtx:198-199 | `num.appendix` | `\appendix` then `\section` |
| hyperlinks and bookmarks | dtx:153, 173; dtx:192 | `meta.hyperref` | `hidelinks`; `\phantomsection` |
| DOI links | dtx:154 | `meta.url` | `doi` (CTAN, LPPL, `\doi{}`, read at ctan.org/pkg/doi); a link-printing package of the same type as `url`; considered, not proposed |
| microtype | dtx:134, 155 | `sp.microtype` | `\usepackage{microtype}`, defaults |
| `[doc]` manual class | dtx:30 | `class.ltxdoc` | no options |
| `[doc]` documentation machinery | dtx:31-33, 48, 54-56, 229, 479 | `dtx.doc` | `\EnableCrossrefs`, `\CodelineIndex`, `\RecordChanges`, `\DocInput{\jobname.dtx}`, `\changes`, `\GetFileInfo`, `\StopEventually`, `\Finale` |
| `[doc]` line spacing | dtx:36, 38 | `sp.setspace` | `\onehalfspacing` |
| `[doc]` Chinese text | dtx:39-40, 45 | `lang.cjk` | `xltxtra`, `xeCJK[CJKspace]`, `\setCJKmainfont{bkai00mp.ttf}[AutoFakeBold=2.5]` |
| `[doc]` main font | dtx:44 | `font.fontspec` | `\setmainfont{bkai00mp.ttf}[AutoFakeBold=2.5]` |
| `[doc]` manual headings | dtx:41, 46, 63, 231 | `head.titlesec` | `\titleformat{\section}{\bfseries\Large}{\zhnum{section}、}{0em}{}`; appendix label `附錄\Alph{section}、`; `\zhnumsetup{style=Traditional}` |
| `[doc]` enumerate labels | dtx:42-43 | `list.kernel` | `\renewcommand\labelenumi{(\zhnum{enumi})}` |
| `[doc]` label printing | dtx:43 | `num.counters` | `\renewcommand\theenumi\labelenumi` |
| `[doc]` title block | dtx:57-60 | `front.maketitle` | `\title \author \date \maketitle`; `\zhdate{2026/10/19} \fileversion` |
| `[doc]` title note, date, footnote | dtx:57, 59, 61 | `front.thanks`, `front.datetime`, `fn.kernel` (one each) | `\thanks{..\url{..}}`; `\zhdate{2026/10/19}`; `\footnote{..}` |
| `[doc]` included PDFs | dtx:37, 477 | `pg.include-pdf` | `\includepdfmerge[nup=2x1, landscape]{./example/proposal.pdf, ./example/bibliography.pdf}` |
| `[doc]` url, graphicx, cross-reference | dtx:34-35, 100, 218 | `meta.url`, `fig.graphicx`, `xref.kernel` | `url` for `\url`; `graphicx` loaded, no `\includegraphics`; `\label{sec:commands}` and `\ref` |

## Bespoke code
All items below sit in the published CTAN classes (class origin ctan), so none is zip-local bespoke code under the rubric. The right-hand column says how each would reduce if the classes were counted as zip-local, so the result can be re-read under that definition.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| refused-option filter `\cmthree@warning`, `\@removeelement` | dtx:246-270 | yes | a closed list of options removed from `\@classoptionslist`; the emitter simply never writes them |
| first-page form heading via `\AddToHook{begindocument/end}` and `\everypar={{\setbox0=\lastbox}\everypar{}}` | dtx:397-399 | yes (by a body wrapper, not shown to match) | `front.class-native` string, `\large`, `\bfseries` in a group, then the next paragraph without its indent box (`\noindent`-like) |
| `\renewcommand{\section}[2]{}` in cm302 | dtx:428 | yes | `head.kernel`: a two-argument no-op; side effect: every later `\section` prints nothing |
| `\zhsection` and four `\Proposal*` commands | dtx:435, 441-444 | yes | `\section{title}` + fixed text + `\vskip1em` (`head.titlesec`, `sp.manual-space`), as README.md:137-143 shows |
| report `\@maketitle` redefinition | dtx:457-466 | yes | title-only block in `front.titling`-style hooks: `\newpage \null \vskip2em`, centered `\LARGE` title, `\vskip1.5em`, no author or date |
| `\frontmatter` | dtx:468-473 | yes | `pg.break`, `pgnum.pagenumbering` Roman, `toc.kernel`, `pg.break`, `pgnum.pagenumbering` arabic |
| `zh` environment and document wrap | dtx:341-345 | yes | `lang.cjk` `CJK*` environment opened at begin and closed at end of document |
| engine switch `\iftutex` and font fallback `\IfFontExistsTF` | dtx:300, 317-332 | yes | the emitter picks the branch for its engine and one CJK font name |

## Content-opaque
none (the Chinese prompt strings dtx:441-444 and the two BibTeX entries example/sample.bib:1-19 are content; no figure, table or drawing exists in any sample)

## Lib changes
- New ways proposed: none. Considered: `zhnumber` (folded into `mark.numspell`, a number printed as words with the language as parameter; the consolidator may widen that line), `doi` (folded into `meta.url`, a link-printing package of the same type).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this). Class ways written plainly: `class.nstc-cm03`, `class.nstc-cm302`, `class.nstc-report`, with the vocabulary under Class setting.
