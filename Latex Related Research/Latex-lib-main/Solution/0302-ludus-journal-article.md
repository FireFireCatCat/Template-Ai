yes

# 0302-ludus-journal-article: LUDUS Journal Article (ludusofficial class)

- Unverified: read from the source, not compiled.
- Source: Source/0302-ludus-journal-article/ (origin: https://latextemplates.com/downloads/ludus-journal-article.zip; licence: CC-BY-4.0, the tag the Overleaf uploaders gave, ATTRIBUTION.txt:1-4; the class file itself carries no licence text, README.md:23-28)
- Kind: journal
- Lib: v4
- Engine: needs XeLaTeX (`fontspec` `\setmainfont{Source Sans 3}` in the XeTeX branch, ludusofficial.cls:15-16 and :25-27; the class has a pdfLaTeX branch with `\sfdefault`, :19-20 and :68, which gives a different face)
- Look carried by: zip-local (the whole look is in `ludusofficial.cls`; `main.tex` adds only metadata strings and content, main.tex:8-29)
- Class origin: zip-local (README.md:6-19 says it is a community upload and "not published by LUDUS itself"; README.md:23-24 says the class is not part of TeX Live or CTAN; ctan.org/pkg/ludusofficial returned 404)
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (`ludusofficial.cls`, 411 lines, read in full; README.md, ATTRIBUTION.txt and references.bib also read)

## Verdict
The class is `\LoadClass{article}` plus published packages with fixed options, a font cascade written with fontspec's own `\IfFontExistsTF`, and one redefined `\maketitle`. That `\maketitle` is only kernel commands inside `\twocolumn[...]` (rules, `\fontsize`, `\textcolor`, `\MakeUppercase`, `\vspace`), and every conditional in it (`\ifdefempty`, `\ifthenelse`, `\ifxetex`, the logo test) is decided by data the emitter already has. The redefined `thebibliography` is the stock article environment plus one `\fontsize` line. Nothing needs a new way, there is no artwork, and nothing needs an outside tool, so each bespoke item reduces by inline expansion. Residual risk: the title block reduces only when the emitter inlines it, and the fonts (Source Sans 3) are not shipped.

## Blockers
none

## Class setting
- Class: `class.article` options: `10pt,a4paper,twocolumn,twoside` (fixed inside the zip-local class by `\LoadClass`, ludusofficial.cls:10). The sample's own options `blue,fullpaper` (main.tex:8) are parameters of the zip-local class, not article options: `blue` resolves to RGB 0,85,184 and `fullpaper` to the string "FULL PAPER" (reductions in the Bespoke table).
- Class-native vocabulary used: none from a published class. Zip-local commands the sample calls: `\journalname` `\journalsubtitle` `\conferencename` `\publicationyear` (main.tex:11-14), `\shorttitle` `\shortauthor` (main.tex:21-22), `\keywords` (main.tex:48), environment `acknowledgments` (main.tex:150-153). Of these, `\journalname`, `\journalsubtitle` and `\publicationyear` are stored (ludusofficial.cls:190-191, :196, :200-201, :207) but never printed anywhere, although main.tex:10 says they appear in the header/footer.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | ludusofficial.cls:10 | `class.article` | `10pt,a4paper,twocolumn,twoside` |
| paper, size, sides | ludusofficial.cls:10 | `page.class-options` | `a4paper`, `10pt`, `twoside` |
| two columns | ludusofficial.cls:10 | `cols.twocolumn-option` | `twocolumn` |
| page geometry | ludusofficial.cls:86-97 | `page.geometry` | a4paper, top=20mm, bottom=20mm, left=15mm, right=15mm, columnsep=7mm, headsep=6mm, headheight=18pt, footskip=8mm, includeheadfoot |
| line spacing | ludusofficial.cls:101 | `sp.setspace` | `\setstretch{1.0}` |
| paragraph shape | ludusofficial.cls:104-105 | `sp.lengths` | `\parindent`=0pt, `\parskip`=5pt plus 2pt minus 1pt |
| main and sans font (XeTeX) | ludusofficial.cls:16, :25-27 | `font.fontspec` | `\setmainfont{Source Sans 3}[Scale=1.0, Ligatures=TeX]`, `\setsansfont` the same; fallbacks Helvetica Neue (:29-31), then `lmsans10-*.otf` by file (:33-42), chosen with fontspec's `\IfFontExistsTF` |
| mono font (XeTeX) | ludusofficial.cls:45-49 | `font.fontspec` | `\setmonofont{Latin Modern Mono}[Scale=MatchLowercase]`, fallback `lmmono10-regular.otf` |
| CJK fonts (only if `xeCJK.sty` exists; no CJK text in the sample) | ludusofficial.cls:17, :50-62 | `lang.cjk` | `\setCJKmainfont` `\setCJKsansfont` `\setCJKmonofont` = Hiragino Sans, else Microsoft YaHei (BoldFont=Microsoft YaHei Bold) |
| pdfLaTeX branch encoding | ludusofficial.cls:19-20 | `font.fontenc-t1` | `inputenc` utf8, `fontenc` T1 |
| pdfLaTeX branch default family | ludusofficial.cls:68 | `font.family-default` | `\familydefault` = `\sfdefault` |
| colours | ludusofficial.cls:109-114, :117-118, :170-171 | `color.xcolor` | `\definecolor` ludusblue RGB 0,85,184; ludusred 200,30,30; ludusgreen 0,130,100; luduspurple 120,50,150; ludusorange 230,90,0; luduscyan 0,160,180; darkgray 50,50,50; lightgray 120,120,120; `\colorlet{themecolor}`, `\colorlet{linkcolor}` |
| theme colour chosen by class option | ludusofficial.cls:121-146, :152-157, :167 | `color.xcolor` | `blue` gives themecolor=linkcolor=ludusblue; the other five options pick the other five colours |
| PDF links and metadata | ludusofficial.cls:174-187 | `meta.hyperref` | colorlinks=true, linkcolor/filecolor/urlcolor/citecolor=linkcolor, pdfsubject={LUDUS Official Publication}, pdftitle={} pdfauthor={} pdfkeywords={}, unicode=true, pdfencoding=auto, bookmarksnumbered=true |
| url package | ludusofficial.cls:78 | `meta.url` | load only, no options |
| running head and foot, body pages | ludusofficial.cls:221-239 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, headrulewidth=0pt, footrulewidth=0pt; head `LE` = `\@shorttitle`, head `RO` = `\@shortauthor`, both `\fontsize{7.5}{9}\selectfont\sffamily\textcolor{darkgray}`; foot `C` = `\thepage` at `\fontsize{8}{10}`, darkgray |
| first-page style | ludusofficial.cls:242-261; used at :310 | `hf.fancyhdr`, `hf.pagestyle-kernel` | `\fancypagestyle{firstpage}`: head `L` = institution string, head `R` = journal URL string, both `\raisebox{-0.3\height}` at 7.5/9 darkgray; head `C` = `\includegraphics[height=5mm]` of the logo file only if `\logofile` was called and the file exists (not set in the sample, so empty); foot `C` page number 8/10; applied with `\thispagestyle{firstpage}` |
| raised head text, spacing | ludusofficial.cls:246, :256, :314-355 | `sp.manual-space` | `\raisebox{-0.3\height}`, `\vspace{3mm}` `{4mm}` `{2mm}` `{5mm}`, `\quad`, `\noindent`, `\\[0.2cm]` (main.tex:25) |
| title block | ludusofficial.cls:307-360 | `cols.twocolumn-cmd` | `\twocolumn[ ... ]`: a full-width block above the two columns; `\begin{@twocolumnfalse}` inside it is dropped by the emitter |
| title block rules | ludusofficial.cls:313, :354 | `sp.rule` | top bar `\rule{\textwidth}{3pt}` in themecolor; bottom bar `\rule{\textwidth}{0.5pt}` in lightgray |
| article label and conference | ludusofficial.cls:317-320 | `mark.case` | `\MakeUppercase{\@articletype}` (here "FULL PAPER", from option `fullpaper`, :160), `\quad\|\quad`, `\MakeUppercase{\@conferencename}` (main.tex:13) at 8.5/10.2 darkgray |
| title and author | ludusofficial.cls:324-328; main.tex:20-29 | `front.maketitle` | kernel `\title` `\author`; title `\fontsize{21}{35}\bfseries\sffamily` in themecolor, author `\fontsize{11}{13.2}\sffamily`; the author text uses `\textbf`, `\textsuperscript`, `\mdseries\small` (main.tex:25-28) |
| title and block sizes | ludusofficial.cls:317, :324, :328, :340-348 | `font.size-commands` | `\fontsize{a}{b}\selectfont` pairs 21/35, 11/13.2, 11.5/13.8, 9/10.35, 8.5/10.2 |
| author markup | main.tex:25-28 | `mark.kernel` | `\textbf`, `\textsuperscript`, `\mdseries` (same type as `\textbf`) |
| DOI line (omitted in the sample) | ludusofficial.cls:211-212, :332-335; main.tex:17 | `front.maketitle` | printed only if `\articledoi` is non-empty: `DOI: <string>` at 8.5/10.2 darkgray; the sample leaves it out |
| abstract | main.tex:34-46; ludusofficial.cls:297-299, :339-344 | `abs.kernel` | `abstract` environment; the class captures its body (`\RenewEnviron` of `environ`) and prints it inside the title block: heading "Abstract" at 11.5/13.8 bold themecolor, text at 9/10.35 |
| abstract package | ludusofficial.cls:74 | `abs.abstract-pkg` | load only, no options; its environment is replaced at :297, so it has no printed effect |
| keywords | main.tex:48; ludusofficial.cls:302-304, :347-350 | `abs.keywords` | `\keywords{...}` stored, printed as `\textbf{Keywords:}` plus the string at 9/10.35 in the title block |
| body font size after title | ludusofficial.cls:359 | `font.size-commands` | `\fontsize{8.5}{9.5}\selectfont` after the title block |
| headings | ludusofficial.cls:264-290; main.tex:55-109 | `head.titlesec` | `\titleformat{\section}{\fontsize{11.5}{13.8}\selectfont\sffamily\bfseries\color{themecolor}}{\thesection.}{0.5em}{}`, `\titlespacing*{\section}{0pt}{10pt plus 2pt minus 1pt}{6pt plus 1pt}`; subsection 10.5/12.6 themecolor, label `\thesubsection.`, spacing `{0pt}{8pt plus 2pt minus 1pt}{5pt plus 1pt}`; subsubsection 10/12 darkgray, label `\thesubsubsection.`, no spacing line |
| acknowledgments | ludusofficial.cls:363-368; main.tex:150-153 | `front.dedication` | `\newenvironment{acknowledgments}`: `\section*{Acknowledgments}`, then `\fontsize{8.5}{9.775}\selectfont`, and `\normalsize` at the end (this resets to 10pt, so the bibliography sets its own size again) |
| figure | main.tex:104-109 | `fig.graphicx` | `figure[h!]`, `\centering`, `\includegraphics[width=\columnwidth]{testImg.jpg}` (shipped image) |
| table | main.tex:117-130 | `tbl.tabular` | `table[h!]`, `\centering`, `tabular{lcc}`, `\hline` rules, `\textbf` header cells; caption placed above by the author |
| caption text | main.tex:107, :119 | `cap.kernel` | `\caption{...}`, `\label{fig:example}` `\label{tab:patterns}` (main.tex:108, :120) |
| caption look | ludusofficial.cls:402-409 | `cap.caption` | `\captionsetup{font={small}, labelfont=bf, labelsep=period, justification=raggedright, singlelinecheck=false}` |
| cross-references | main.tex:108, :113, :120 | `xref.kernel` | `\label` and `\ref` (`Table~\ref{tab:patterns}`) |
| footnote layout (class sets it; the sample has no footnote) | ludusofficial.cls:396-399 | `fn.footmisc` | `[hang,flushmargin]`, `\footnotelayout`=`\fontsize{8}{8.8}\selectfont`, `\footnotesep`=0.6em (a length, `sp.lengths`) |
| footnote mark | ludusofficial.cls:398 | `num.counters` | `\renewcommand{\thefootnote}{\arabic{footnote}}` |
| bibliography | main.tex:159-160; ludusofficial.cls:371-393; references.bib:1-26 | `bib.bibtex-bst` | `\bibliographystyle{plain}`, `\bibliography{references}`; heading `\section*{\refname}` with `\refname`="References"; list at `\fontsize{8.5}{9.5}\selectfont`; citations `\cite` (main.tex:85, :93, :102) |
| bibliography penalties and spacing | ludusofficial.cls:384-388 | `sp.penalties`, `sp.hyphenat` | `\clubpenalty4000`, `\widowpenalty4000` (`sp.penalties`); `\sloppy` (`sp.hyphenat`) |
| multicol package | ludusofficial.cls:82 | `cols.multicol` | load only, no `multicols` environment is used in the class or the sample |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| zip-local class `ludusofficial` | ludusofficial.cls:1-411 | yes | `\LoadClass[10pt,a4paper,twocolumn,twoside]{article}` plus the rows above: no output routine, box code or kernel-internal rewrite beyond the two items below |
| class options `blue` ... `cyan`, `\setthemecolor`, `\ifthenelse` | ludusofficial.cls:121-157, :167 | yes | the option only picks one RGB triple for `themecolor` and `linkcolor`; the emitter writes `\definecolor`/`\colorlet` with the chosen values (xcolor) |
| class options `fullpaper` ... `artpaper`, `\@articletype` | ludusofficial.cls:149, :160-165, :208 | yes | a lookup from option to one printed string ("FULL PAPER" ...); the emitter writes the string inside `\MakeUppercase{...}` |
| font cascade `\ludus@setupfonts`, `\ifxetex` | ludusofficial.cls:13-21, :24-69 | yes | `\IfFontExistsTF` is a fontspec command (`font.fontspec`); the emitter writes the XeTeX branch with Source Sans 3 first and the same fallbacks, or only the first choice. The fonts are not shipped (missing asset, noted) |
| `\newcommand`/`\renewcommand` metadata store (`\journalname` ... `\shortauthor`, `\logofile`, `\articledoi`) | ludusofficial.cls:190-218 | yes | string storage only; the emitter writes each value where it is printed (header fields, title block); four of them are never printed (see Class setting) |
| `\RenewEnviron{abstract}`, `\@abstracttext`, `\keywords` store | ludusofficial.cls:293-304 | yes | capture only so the text can be printed later; the emitter places the abstract and keywords inside the `\twocolumn[...]` argument at `\maketitle` time, in the same order as the source |
| `\renewcommand{\maketitle}` | ludusofficial.cls:307-360 | yes | one `\twocolumn[...]` block of kernel commands (`\thispagestyle`, `\rule`, `\vspace`, `\fontsize`, `\textcolor`, `\MakeUppercase`); the `\ifdefempty` tests (etoolbox) are resolved by the emitter, which omits an empty field |
| `\newenvironment{acknowledgments}` | ludusofficial.cls:363-368 | yes | `\section*`, `\fontsize`, `\normalsize` composed in a wrapper |
| `\renewenvironment{thebibliography}` | ludusofficial.cls:373-393 | yes | the list code is the stock article definition (`\list`, `\@biblabel`, `\usecounter{enumiv}`, `\sloppy`, penalties 4000, `\sfcode`); the only changes are no `\@mkboth` (running heads are cleared by `\fancyhf{}`, :222) and a `\fontsize{8.5}{9.5}\selectfont` line. The emitter keeps the stock environment and wraps `\bibliography` in that font size |
| `\renewcommand{\thefootnote}`, `\footnotelayout` | ludusofficial.cls:398-399 | yes | `num.counters` and the `footmisc` hook, set by value |
| `\ifx\@logofile\undefined` / `\IfFileExists` | ludusofficial.cls:249-253 | yes | the sample sets no logo, so the centre head field is empty; with a logo the emitter writes `\includegraphics[height=5mm]{file}` |
| helper packages `ifxetex`, `etoolbox`, `ifthen`, `environ` | ludusofficial.cls:13, :79-80, :83 | yes | branch and capture helpers with no printed effect once the emitter resolves the conditionals and inlines the stored text; considered: environ, ifxetex, etoolbox, ifthen (not proposed as ways) |

## Content-opaque
none (the figure is an included JPEG, `testImg.jpg`, a shipped asset held by `fig.graphicx`)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
