no

# 0184-emersonmello-modelos-latex: IFSC LaTeX models (emersonmello/modelos-latex), main sample "nota de aula"

- Unverified: read from the source, not compiled.
- Source: Source/0184-emersonmello-modelos-latex/ (origin: https://codeload.github.com/emersonmello/modelos-latex/zip/refs/heads/master; licence: CC0-1.0 per the manifest)
- Kind: misc (course lecture notes; the zip is a collection: Beamer themes, exam, report, minutes, regulation, plan)
- Lib: v3
- Engine: pdfLaTeX-compatible (classes/ifscutils.sty:12-20 is a pdfTeX font branch; a second XeLaTeX/LuaLaTeX branch sits at :21-56; nota-de-aula/latexmkrc:27 and :31 default to pdflatex)
- Look carried by: zip-local (the sample's preamble is only `\documentclass[11pt]{ifscarticle}` and `\usepackage{ifscutils}`; all look is in classes/ifscarticle.cls, classes/ifscutils.sty, classes/ifsclistings.sty)
- Class origin: zip-local (`ifscarticle` is not on CTAN: ctan.org/pkg/ifscarticle returned 404; it is one author's GitHub repo, not an official IFSC release)
- Main file: nota-de-aula/nota-de-aula.tex (other samples: ata-reunioes/ata-de-reunioes.tex, instrucao-normativa/modelo-IN-IFSC.tex, lista-ou-prova/lista-ou-prova-exam.tex, relatorio/relatorio.tex, plano-de-ensino/plano-de-ensino.tex, apresentacao/ifsclean/demo.tex, apresentacao/ifscyan/ifscyan-template.tex, apresentacao/titulo-leve/titulo-leve.tex)
- Read: main yes, zip-local classes and styles partly (not read: apresentacao/ifscyan/beamerthemeifscyan.sty lines 600-700 and 720-868, which are `\lstdefinelanguage` blocks; apresentacao/ifsclean/ifsclean-listings.sty was read as a diff against classes/ifsclistings.sty plus its lines 355-392)

## Verdict
No. The main sample's look is carried by three zip-local files and almost all of it reduces to lib ways (article + geometry + fancyhdr, tcolorbox alert boxes, listings, booktabs, fontawesome). The blocker is template artwork: `ifscutils.sty` draws the IFSC logo with `\tikzmath` and a TikZ `pic` (ifscutils.sty:131-165) and prints it in the course header block `\cabecalhoCurso` (ifscutils.sty:368), which the sample calls on its first body line (nota-de-aula.tex:10). That is `ART`, with no declarative lib way. The other samples add more blockers (TikZ title pages and footlines in the Beamer themes, an ordinal-counter macro in `inifsc.cls`); they are recorded below and would not change the answer.

## Blockers
- `ART/class` IFSC logo drawn with `\tikzmath` constants and `pics/ifsclogo` (a circle and nine rounded squares on a 1.2-unit grid, two colour arguments), printed by `\cabecalhoCurso` (classes/ifscutils.sty:131-165, used at :368; sample call nota-de-aula/nota-de-aula.tex:10)
- `BESPOKE/class` patch of mdframed's private `\mdf@subtitlebackgroundcolor` inside a `\tikzset` style override (classes/ifscutils.sty:200); affects only the use-case frame, which this sample does not call
- Other samples, not the main sample (recorded for scope):
  - `ART/class` ifsclean theme: TikZ title page, TikZ full-page background and section pages, two more logo pics (apresentacao/ifsclean/beamerinnerthemeifsclean.sty:35-86; beamerouterthemeifsclean.sty:4-44; beamerthemeifsclean.sty:289-355)
  - `ART/class` ifscyan theme: TikZ title-page band, footline bar with a TikZ logo box (apresentacao/ifscyan/beamerthemeifscyan.sty:305-326, 425-486)
  - `ART/class` titulo-leve 2018: TikZ filled title band (apresentacao/titulo-leve/beamerthemeIFSC-LEVE2018.sty:116-120); the 2017 theme draws rules with `\pgfline` (beamerthemeIFSC-LEVE.sty:57-58, 65-69)
  - `BESPOKE/class` ordinal-below-ten numbering `\traduzir`/`\ordcard`, hooked into enumitem by `\AddEnumerateCounter` (classes/inifsc.cls:127-139)
  - `BESPOKE/class` attendee-list accumulators `\participante` (`\eappto`, `\csdef`, `\ifdefempty` joins) that decide what is printed (classes/ifscata.cls:24-48, 111-148)
  - `BESPOKE/class` Beamer frame-option patch `\defaultframeoptions` / `\define@key{beamerframe}{wide}` on `\beamer@extra@frameoptions` and `\beamer@cramped` (apresentacao/ifsclean/beamerinnerthemeifsclean.sty:8-22; same in beamerthemeifscyan.sty:200-211)

## Class setting
- Class: `class.article` (the zip-local class is `\LoadClassWithOptions{article}` at classes/ifscarticle.cls:28), options: 11pt (nota-de-aula/nota-de-aula.tex:5)
- Class-native vocabulary used: article's `\section`, `\subsection`, `\subsubsection`, `table`, `itemize`, `description`, `enumerate`. The zip-local vocabulary (not published) is `\cabecalhoCurso`, the environments `note` `tip` `important` `warning` `caution`, `\dest`, `\destx`, `\licenciamentoLivre`.

## Component map
Main sample first (rows 1-47), then the other samples (rows 48-58). Paths are relative to the zip root; `ifscutils.sty` means classes/ifscutils.sty.
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | nota-de-aula/nota-de-aula.tex:5; classes/ifscarticle.cls:28 | `class.article` | 11pt; the zip-local class inlines to the rows below |
| page size and font size | nota-de-aula/nota-de-aula.tex:5 | `page.class-options` | 11pt (a4paper comes from geometry) |
| page geometry | classes/ifscarticle.cls:42 (one-sided, used by the sample); :33 (twoside branch) | `page.geometry` | a4paper, hmargin=2cm, top=2cm, bottom=2cm, headheight=2cm, heightrounded (twoside adds `twoside`); `\if@twoside` (:32) is chosen by the emitter from the class option |
| header and footer | classes/ifscarticle.cls:25, 43-49 | `hf.fancyhdr` | `\fancyhf{}`, headrulewidth 0pt, footrulewidth 0pt, foot L `\begin{tiny}IFSC -- \textsc{Campus São José}\end{tiny}`, foot R `\begin{tiny}Página \thepage\end{tiny}`; twoside variant :34-40 (RE,LO and LE,RO) |
| page style switch | classes/ifscarticle.cls:52-53 | `hf.pagestyle-kernel` | `\pagestyle{followingpage}`; `\AtBeginDocument{\thispagestyle{followingpage}}` becomes a `\thispagestyle` after `\begin{document}` |
| size switches | classes/ifscutils.sty:368; classes/ifsclistings.sty:32 | `font.size-commands` | `\small`, `\footnotesize`, `\tiny`, `\large`, `\Huge` |
| encoding (pdfTeX branch) | classes/ifscutils.sty:14-15 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| language | classes/ifscutils.sty:16 (pdfTeX), :29 (Xe/Lua) | `lang.babel` | brazilian |
| text and math font (pdfTeX branch) | classes/ifscutils.sty:18-19 | `font.palatino` | newpxtext, newpxmath (the package is the parameter) |
| arbitrary Computer Modern sizes | classes/ifscutils.sty:17 | `font.exscale` | load only, no options |
| default family | classes/ifscutils.sty:20 | `font.family-default` | `\renewcommand*\familydefault{\sfdefault}` |
| text fonts (Xe/Lua branch) | classes/ifscutils.sty:23, 34-49 | `font.fontspec` | `\defaultfontfeatures{Ligatures=TeX,Scale=MatchLowercase,Renderer=HarfBuzz}`; mono Inconsolata Scale=0.88; main Inter Scale=.88 SmallCapsFont=*, else TeX Gyre Heros Scale=.9; `\IfFontExistsTF` picks the first font found, so the emitter writes the chosen one |
| math font (Xe/Lua branch) | classes/ifscutils.sty:24, 51-55 | `font.unicode-math` | TeX Gyre Pagella Math, else Latin Modern Math, Scale=MatchLowercase |
| Unicode characters | classes/ifscutils.sty:25-27 | `font.newunicodechar` | º to `\textordmasculine`, ª to `\textordfeminine` |
| colour definitions | classes/ifscutils.sty:74, 111-124, 399 | `color.xcolor` | verdeifsc RGB 50,160,65; vermelhoifsc 200,25,30; azul 7da6cb; amarelo f0b400; amareloinfo FEE886; vermelhoinfo e44131; verdeinfo 31a250; azulinfo 4080ec; notecolor 9,105,218; tipcolor 26,127,25; importantcolor 130,80,223; warningcolor 253,165,15; cautioncolor 207,34,46; gainsboro rgb .86 |
| icons and symbols | classes/ifscutils.sty:78-80; nota-de-aula/nota-de-aula.tex:22 | `font.icons` | fontawesome6 (`\faCircleInfo`, `\faLightbulb[regular]`, `\faExclamation`, `\faTriangleExclamation`, `\faCircleExclamation`), ccicons (`\ccby`), pifont (`\ding`) |
| hyperlinks | classes/ifscutils.sty:81-82 | `meta.hyperref` | `\PassOptionsToPackage{hidelinks}{hyperref}` |
| bookmarks | classes/ifscutils.sty:82 | `meta.bookmark` | load only |
| URLs | nota-de-aula/nota-de-aula.tex:14 | `meta.url` | `\url{...}` (provided through hyperref) |
| cross-references | nota-de-aula/nota-de-aula.tex:51, 101, 112, 128 | `xref.hyperref`, `xref.kernel` | `\autoref{intro}`, `\autoref{tab:variaveis}`; `\ref{tabelaoperadores}`; `\label` in captions |
| quotation marks | classes/ifscutils.sty:67 | `lang.csquotes` | load only |
| citation line breaking | classes/ifscutils.sty:65 | `bib.cite-pkg` | load only |
| ragged text | classes/ifscutils.sty:77, 186-188; nota-de-aula/nota-de-aula.tex:115 | `sp.ragged` | ragged2e `\RaggedLeft`, `\RaggedRight`; `\centering` |
| underline and strike | classes/ifscutils.sty:66, 71 | `mark.ulem` | soul; ulem with `normalem` |
| inline emphasis | nota-de-aula/nota-de-aula.tex:45 | `mark.kernel` | `\textit`, `\texttt`, `\textbf` |
| numbers and units | classes/ifscutils.sty:75, 91-98 | `mark.siunitx` | locale=DE, output-decimal-marker={,}, group-separator={.}, group-minimum-digits=4, per-mode=symbol, detect-all |
| tables (packages) | classes/ifscutils.sty:76, 82, 103, 186-188 | `tbl.tabular`, `tbl.booktabs`, `tbl.multirow`, `tbl.longtable` | `\arraystretch` 1.2; `\newcolumntype` R, C, L = `>{\RaggedLeft\arraybackslash}p{#1}` and the centred and ragged-right variants; longtable and supertabular are loaded, unused by the sample |
| sample tables | nota-de-aula/nota-de-aula.tex:114-123, 130-144 | `tbl.tabular`, `tbl.booktabs`, `cap.kernel` | `table[!htpb]`, `\centering`, colspecs `{lp{5cm}lp{5cm}}` and `{ll\|\|ll\|\|ll}`, `\multicolumn`, `\toprule` `\midrule` `\bottomrule` `\hline` |
| caption package defaults | classes/ifscutils.sty:61 (subcaption loads caption); :179-182 (`\captionsetup` lines commented out) | `cap.caption` | package defaults only |
| subfigures | classes/ifscutils.sty:61 | `fig.subcaption` | load only |
| graphics | classes/ifscutils.sty:64, 368 | `fig.graphicx` | `\scalebox{.20}` around the logo |
| landscape pages | classes/ifscutils.sty:62 | `pg.landscape` | load only |
| page break | nota-de-aula/nota-de-aula.tex:125 | `pg.break` | `\clearpage` |
| code listings | classes/ifsclistings.sty:5-6, 30-66; nota-de-aula/nota-de-aula.tex:53, 81 | `code.listings`, `code.upquote` | base style: backgroundcolor 250,250,250; basicstyle `\ttfamily\footnotesize` in 40,44,52; keywordstyle 0,92,197 bold; stringstyle 196,26,22; commentstyle 0,128,0; escapeinside={@*}{*@}; numbers=none; frame=single; frameround=tttt; rulecolor 220,220,220; breaklines=true; breakatwhitespace=false; tabsize=2; keepspaces; showstringspaces=false; columns=fullflexible; inputencoding=utf8; `literate` accent table; `\lstset{style=ifsclistings@base}`; sample uses `style=bash` with caption and label |
| listing names | classes/ifscutils.sty:192-193 | `code.listings` | `\lstlistlistingname` Lista de Códigos; `\lstlistingname` Listagem |
| listing languages and styles | classes/ifsclistings.sty:71-347 | `code.listings` | `\lstdefinestyle` and `\lstdefinelanguage` for bash, python, java, javascript, c, kotlin, json, yaml, docker, docker-compose, html, xml, xsd, protobuf, groovy, sql, properties; the sample uses only bash |
| alert boxes | classes/ifscutils.sty:300-354; nota-de-aula/nota-de-aula.tex:22-40 | `box.tcolorbox`, `sp.lengths` | `alertmarkdown`: arc=0mm, boxrule=0mm, leftrule=1mm, left=2mm, top=1mm, parbox=false, enhanced, opacityback=0, opacitybacktitle=0, opacityframe=0; `ghmarkdown`: `borderline west={3pt}{0pt}{colour}`, coltitle=colour, title=icon+name; defaults note (Nota, notecolor), tip (Dica, tipcolor), important (Importante, importantcolor), warning (Atenção, warningcolor), caution (Cuidado, cautioncolor); body sets `\parskip=0.3\baselineskip plus 2pt`, `\parindent=0pt` |
| info balloons (defined, not used by the sample) | classes/ifscutils.sty:247-294 | `box.tcolorbox` | `caixainfo`: auto counter, number within=section, colback=colframe, coltitle, fonttitle `\bfseries\sffamily`, boxrule=.1pt, detach title, breakable, pad at break*=0mm, enhanced, leftrule=15mm, `underlay unbroken and first` anchoring an icon as text; title shown only when non-empty (`\ifdefempty{\tcbtitletext}`, :255), which the emitter decides per node |
| inline highlight boxes | classes/ifscutils.sty:243-245; nota-de-aula/nota-de-aula.tex:56 | `box.tcolorbox` | `\dest[red]`: on line, arc=0pt, colback=#1!10!white, colframe=#1!50!black, boxsep=0pt, left/right=1pt, top/bottom=2pt, boxrule=0pt; `\destx[red]`: arc=7pt, boxrule=1pt, left/right=6pt |
| course header block | classes/ifscutils.sty:361-381; nota-de-aula/nota-de-aula.tex:10-16 | `box.fancybox`, `box.minipage`, `tbl.tabular`, `tbl.multirow`, `sp.manual-space`, `fig.graphicx` | `\fbox` around a `minipage{.98\textwidth}` with `tabular*{\linewidth}{@{} l p{9.1cm} R{6cm}@{}}`, `\multirow{2}{*}{logo}`, `\small` cells, centred title, flushright date, `\bigskip`; the logo inside is the ART row below |
| IFSC logo | classes/ifscutils.sty:131-165, 368 | `art.tikz` (ART, blocker) | `\tikzmath` constants, `pics/ifsclogo` with two colour arguments |
| sectioning | nota-de-aula/nota-de-aula.tex:19, 43, 49, 59, 99, 110, 126, 171 | `head.kernel` | `\section`, `\subsection`, `\subsubsection` with article defaults |
| lists | nota-de-aula/nota-de-aula.tex:63-96, 173-179; classes/ifscutils.sty:70 | `list.kernel`, `list.enumitem` | nested `itemize` and `description`, `enumerate`; enumitem loaded with `inline`, no keys set by the sample |
| inline maths | nota-de-aula/nota-de-aula.tex:47, 66, 140, 178 | `math.kernel` | `$\vert$`-style bars, `$\backslash$`, `$3$` |
| bottom filler and licence line | nota-de-aula/nota-de-aula.tex:182-183; classes/ifscutils.sty:206-210 | `sp.manual-space`, `font.icons`, `meta.hyperref`, `sp.ragged` | `\vspace*{\fill}`; `center` with `\ccby` and `\href{...}{\color{azulinfo}...}` |
| name line, link helper | classes/ifscutils.sty:385-387, 393 | `sp.rule`, `sp.manual-space`, `meta.hyperref`, `color.xcolor` | `\rule{.2\linewidth}{.4pt}`, `\hfill`, `\bigskip`; `\href` with colour and angle brackets |
| check-list | classes/ifscutils.sty:233-237 | `list.enumitem`, `font.icons`, `sp.manual-space` | `\newlist{todolist}{itemize}{2}`, label `\ding{111}`; `\cmark`, `\xmark` use `\rlap` (a kernel box shift, filed with `\raisebox`), `\raisebox`, `\hspace` |
| use-case frame | classes/ifscutils.sty:399-406, 409-460 | `box.mdframed`, `tbl.tabular`, `list.kernel`, `num.counters`, `xref.kernel`, `xref.hyperref` | `\newmdenv[frametitlerulewidth=.5pt, frametitlerule=true, frametitlebackgroundcolor=gainsboro, subtitlebelowskip=0pt, subtitleaboveskip=2pt]`; `\mdfsubtitle`; counter `usecase` within section, `\theusecase`; `\usecaseautorefname` |
| overfull rule | classes/ifscutils.sty:197 | `sp.lengths` | `\overfullrule=2cm` |
| TikZ setup | classes/ifscutils.sty:59-60 | `art.tikz` | `tikz`, `pgf`, `\usetikzlibrary{calc,math,positioning}`; used only by the logo and the mdframed patch |
| support packages | classes/ifscutils.sty:11, 63, 72, 73 | none (no component) | `iftex`, `etoolbox`, `xargs`, `xifthen` only serve the zip-local macros |
| minutes: class, margins, running heads | classes/ifscata.cls:103, 196-234 | `class.article`, `page.geometry`, `hf.fancyhdr`, `pgnum.lastpage`, `fig.graphicx` | a4paper, hmargin=2.3cm, top=3.5cm, bottom=2cm, headheight=3cm; styles `firstpage` (image head, "página X de Y") and `followingpage`; `\pgfuseimage{logo}` |
| regulation: class and heads | classes/inifsc.cls:19, 166-187, 209-228 | `class.memoir`, `hf.memoir-pagestyle`, `head.titlesec`, `num.counters`, `page.geometry` | `\makeoddhead`, `\makeoddfoot`; `\titleformat{\chapter}[display]`, section "Seção \thesection"; `\renewcommand\thechapter{\Roman{chapter}}` |
| regulation: legal lists | classes/inifsc.cls:145-163 | `list.enumitem` | `\newlist{artigo}{enumerate}{5}`, `\setlist[artigo,1]{resume, labelindent=\parindent, label=\textbf{Art. \ordcard*}}` and the paragrafo, inciso levels; the ordinal label uses the blocked `\ordcard` |
| exam | classes/ifscexam.cls:11, 20-37, 44-55; lista-ou-prova/lista-ou-prova-exam.tex:5 | `class.exam`, `exam.questions`, `hf.class-native`, `page.geometry` | `addpoints`; `\qformat`, `\pointpoints{ponto}{pontos}`, `\totalformat`, `\hqword`; `\pagestyle{headandfoot}`, `\lfoot`, `\rfoot` |
| report covers, bibliography | relatorio/ifscapa.sty:37-103; relatorio/relatorio.tex:16, 56 | `front.titlepage-env`, `bib.biblatex-biber`, `toc.kernel` | hand-laid `titlepage` environments (`\includegraphics[scale=0.7]`, rules, minipages); `style=abnt,noslsn,justify` (backend not stated, biblatex default is biber); `\capa` dispatch by `\ifthenelse` is resolved by the emitter |
| teaching plan | plano-de-ensino/plano-de-ensino.tex:7, 11-13 | `page.geometry`, `hf.fancyhdr` | `\geometry{a4paper,hmargin=2cm,top=3.5cm,bottom=2cm,headheight=3cm,heightrounded}`; header image via `\fancyhead[C]{\includegraphics[width=\linewidth]{...}}` |
| Beamer themes | apresentacao/ifsclean/demo.tex:4, 22-39; apresentacao/ifsclean/beamercolorthemeifsclean.sty:42-63; apresentacao/ifsclean/beamerfontthemeifsclean.sty:1-17 | `class.beamer`, `slide.beamer-theme`, `slide.beamer-template` | `\usetheme[titlefg=white, titlebg=azulclaro, ...]{ifsclean}` (kvoptions string keys); `\setbeamercolor`, `\setbeamerfont`; the title page, backgrounds and footlines are TikZ, see Blockers |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| class `ifscarticle` | classes/ifscarticle.cls:7-53 | yes | `class.article` 11pt, `page.geometry`, `hf.fancyhdr`, `hf.pagestyle-kernel` with the values above |
| engine split `\ifPDFTeX` and `\IfFontExistsTF` | classes/ifscutils.sty:11-56 | yes | the emitter writes the branch for its engine and the first available font |
| alias environments `note` `tip` `important` `warning` `caution` (`\newenvironmentx`, `ghmarkdown`) | classes/ifscutils.sty:314-354 | yes | one `\newtcolorbox` per kind with fixed key values; `xargs` only fills default optional arguments (the sample's `[Nota][\faCircleInfo][notecolor]` at nota-de-aula.tex:22 are those defaults) |
| `caixainfo` and `informacao`, `informacaoazul`, `atencao`, `cuidado` | classes/ifscutils.sty:247-294 | yes | tcolorbox keys per node, with or without `before upper={\tcbtitle\par}` |
| `\dest`, `\destx` | classes/ifscutils.sty:243-245 | yes | `\newtcbox` calls with the keys above |
| `\cabecalhoCurso` | classes/ifscutils.sty:361-381 | yes, except the logo | fbox, minipage, `tabular*`, `\multirow` as in the map; `\hbadness=10000` (:362) only silences underfull warnings and has no visible effect, so it is dropped |
| IFSC logo (`\tikzmath`, `pics/ifsclogo`, `squarednode`, `roundnode`) | classes/ifscutils.sty:131-165 | no | ART. The zip also ships classes/imagens/ifsclogo.pdf, but nothing in ifscutils.sty uses it and it was not checked to be the same drawing; swapping it in would be a substitution, not a recovery |
| `\nomealuno`, `\MYhref`, `\licenciamentoLivre`, `\plagio`, `\plagioGH` | classes/ifscutils.sty:206-226, 385-393 | yes | aliases over `sp.rule`, `meta.hyperref`, `color.xcolor`, `font.icons`, `box.tcolorbox`; `\plagio` and `\plagioGH` wrap fixed text |
| `todolist`, `\cmark`, `\xmark` | classes/ifscutils.sty:233-237 | yes | enumitem `\newlist`, pifont `\ding`, `\rlap`, `\raisebox`, `\hspace` |
| `usecase`, `cabecalhoUC`, `fluxoprincipal`, `fluxoalternativo`, `fluxoexcecao`, `\usecaseLabel` | classes/ifscutils.sty:409-460 | yes | static `\newenvironment` aliases (the class redefines the inner environments at every `usecase` start, :438-455); `\newcounter{usecase}[section]` with `\theusecase`; `\theusecase` uses `\thechapter` (:430), undefined under article, and relatorio/relatorio.tex:10 overrides it with `\thesection`; not called by the main sample |
| `\tikzset{mdfsubtitlebackground/.style=...\mdf@subtitlebackgroundcolor}` | classes/ifscutils.sty:200 | no | a bug fix written against a private mdframed macro; the emitter cannot print it without copying the zip-local patch |
| `\overfullrule=2cm` | classes/ifscutils.sty:197 | yes | raw TeX dimension, `sp.lengths` |
| listings styles and languages | classes/ifsclistings.sty:16-347 | yes | `\definecolor`, `\lstdefinestyle`, `\lstdefinelanguage`, `\lstset` are listings' own declarative API |
| `\traduzir`, `\ordcard`, `\AddEnumerateCounter` | classes/inifsc.cls:127-139 | no | BESPOKE/class: counter label printed ordinal below 10 and cardinal otherwise by `\ifnum`; other sample |
| `\participante` and list accumulators | classes/ifscata.cls:24-48, 111-148 | no | BESPOKE/class: joins names by `\eappto` and `\ifdefempty` tests; other sample |
| `\formatoquestao`, `\tf` | classes/ifscexam.cls:20-24 | yes | `\qformat` and `\fillin` of `exam` (`exam.questions`); other sample |
| `\capa`, `\maketitlemodeloone`, `\maketitlemodelotwo` | relatorio/ifscapa.sty:37-116 | yes | `titlepage` environments with fixed layout; the string dispatch is resolved by the emitter; other sample |
| Beamer frame option `wide`, `\defaultframeoptions` | apresentacao/ifsclean/beamerinnerthemeifsclean.sty:8-22 | no | edits Beamer internals; other sample |
| `censor` package (hatching of confidential text) | classes/ifscata.cls:192 | not mapped | considered: censor (CTAN); no lib way, not proposed because it is outside the main sample |

## Content-opaque
none in the main sample (no TikZ or pgfplots in its body; the shell listings are code content read from nota-de-aula/codigos/*.sh, not opened). Text in `\plagio` and `\plagioGH` that names Copilot and ChatGPT (classes/ifscutils.sty:216, 224) is student-facing content, not an instruction to a reader agent.

## Lib changes
- New ways proposed:
  - `bib.cite-pkg` `breakcites` (CTAN, "ensure that multiple citations may break at line end", read at ctan.org/pkg/breakcites), pdfLaTeX. W1 on CTAN; W2 a load-only package with no options (classes/ifscutils.sty:65); W3 serves any document with citations; W4 one preamble line. Not `bib.cite-pkg` (ordering and compression) and not `sp.hyphenat` (hyphenation).
  - `font.exscale` `fix-cm` (LaTeX base), pdfLaTeX. W1 LaTeX base; W2 a load-only switch with no options (classes/ifscutils.sty:17); W3 any CM-family document; W4 one preamble line. A sibling of `font.exscale`; not `font.size-commands`, which picks sizes and does not make CM fonts available at any size.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
