yes

# 0053-zhanghai-zju-csse-undergraduate-design-l: ZJU CS/SE undergraduate design template (thesis, proposal, interim report)

- Unverified: read from the source, not compiled.
- Source: Source/0053-zhanghai-zju-csse-undergraduate-design-l/ (origin: https://codeload.github.com/zhanghai/zju-csse-undergraduate-design-latex-template/zip/refs/heads/master; licence: not established. The class header cites LPPL 1.2+, thesis/csbachelor.cls:5-13; the bundled .bst cites GPL 2+, thesis/data/gbt7714-2005.bst:15-27)
- Kind: thesis
- Lib: v1
- Engine: needs XeLaTeX (`fontspec`, `xeCJK`, `xunicode`, `xltxtra`, `\XeTeXlinebreaklocale`; Makefile runs `latexmk -xelatex`, thesis/Makefile:2)
- Look carried by: zip-local (thesis/csbachelor.cls and csbachelor.cfg define fonts, headings, header/footer, ToC, captions, theorems; the cover, agreement, assignment and assessment pages are hand-laid in data/*.tex bodies)
- Class origin: zip-local
- Main file: thesis/main.tex (other samples: proposal/main.tex, interim/main.tex; each folder has its own, different, copy of csbachelor.cls/.cfg)
- Read: main yes, zip-local classes and styles all (thesis cls and cfg line by line; proposal cls/cfg read from line 90 on plus a full `diff` against the thesis copy; interim cls and cfg `diff`-identical to proposal's; the 1960-line `.bst` read only for its header, it is a lib parameter)

## Verdict
yes. The look is one zip-local class (`csbachelor`, not on CTAN: ctan.org/pkg/csbachelor returned 404) that is `\LoadClass{book}` plus published packages, `\titleformat`/`\titlecontents`/`fancyhdr`/`amsthm` calls and font aliases. Every zip-local macro, patch and redefinition reduces to lib ways with parameters (see Bespoke code). There is no template-defining drawing (the covers are `\includegraphics` of shipped PNGs; TikZ is only loaded in the preamble and never drawn), and no tool beyond `bibtex` is needed. Caveats, none a blocker: XeLaTeX only; the Windows fonts it names are not shipped; the `.bst` is judged a parameter of `bib.bibtex-bst`; the target of one `xpatch` could not be read offline.

## Blockers
none

## Class setting
- Class: `class.book` (loaded by zip-local wrapper `csbachelor`, thesis/csbachelor.cls:28-34) options: a4paper, 12pt, twoside, titlepage, openany (oneside variant: a4paper, 12pt, oneside, titlepage, cls:32). Sample passes `twoside,numberorder` (main.tex:1). `numberorder` only does `\def\zjubibstyle{N}` (cls:20) and nothing reads `\zjubibstyle` (grep over the zip): a dead option.
- Class-native vocabulary used: `\zjutitle{zh}{en}`, `\zjuauthor{zh}{en}{id}`, `\zjumentor`, `\zjuinfo{grade}{major zh}{major en}`, `\zjucollege`, `\zjudate` (cfg:3-40; main.tex:33-44) and their getters `\zjutitlec`, `\zjutitlee`, `\zjuauthornamec`... (cfg:1-40); page styles `frontmatter`, `mainmatter` (cls:216-227); font switches `\songti \heiti \kaiti \lishu \stfangsong`; size switches `\erhao \sanhao \sihao \xiaosi \xiaoer \wuhao \xiaowu \shisanbang`; book's `\frontmatter \mainmatter \backmatter`. Defined but unused by the sample: theorem environments `zjuhypothsis zjudefine zjutheorem zjuproposition zjuproof` (cls:255-262; grep finds no use).

## Component map
Paths are relative to Source/0053-.../ ; `cls` = thesis/csbachelor.cls, `cfg` = thesis/csbachelor.cfg, `D` = thesis/data. Rows marked (proposal) or (interim) come from the other two samples.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | cls:28-34; main.tex:1 | `class.book` | a4paper,12pt,twoside,titlepage,openany |
| paper and size | cls:29 | `page.class-options` | a4paper, 12pt |
| page geometry | cls:37 | `page.geometry` | top=38mm,bottom=38mm,left=32mm,right=32mm,includefoot (proposal/interim cls:37: top=2.0cm,bottom=2.4cm,left=3.4cm,right=2.4cm,includefoot) |
| head and foot room | cls:97-98 | `page.setlength` | \headheight=22pt, \footskip=1.3cm (proposal/interim cls:94: headheight 27pt) |
| bottom flush | cls:99 | `pg.flush` | \raggedbottom |
| engine line-breaking primitives | cls:55-56 | `sp.lengths`, `lang.cjk` | \XeTeXlinebreaklocale "zh"; \XeTeXlinebreakskip=0pt plus 1pt (values only, no logic; XeTeX primitives grouped with raw length parameters) |
| spacing parameters | cls:101-106 | `sp.lengths` | \frenchspacing; \parsep=0em, \parskip=0em, \parindent=2em, \itemsep=0em |
| widow penalty | cls:102 | `sp.penalties` | \widowpenalty=10000 |
| line spacing | cls:115 | `sp.linespread` | \baselinestretch=1.389 (comment "20pt / 14.4pt"); proposal/interim cls:112: 1.5 |
| Latin fonts | cls:49-51, 57-59 | `font.fontspec` | fontspec, xunicode, xltxtra; \setmainfont{Times New Roman}, \setsansfont{Arial}, \setmonofont{Courier New} (TeX Gyre alternatives commented out, cls:61-63) |
| CJK fonts | cls:67-75 | `lang.cjk` | xeCJK[slantfont,boldfont]; \setCJKmainfont{SimSun}, \setCJKsansfont{SimHei}, \setCJKmonofont{SimHei}; \punctstyle{kaiming} (legacy xeCJK command, a PunctStyle value) |
| CJK family aliases | cls:154-181 | `lang.cjk`, `font.fontspec` | \setCJKfamilyfont FangSong=FangSong, HeiTi=SimHei, KaiShu=KaiTi, LiShu=LiSu, SongTi=SimSun, YouYuan=YouYuan, STFangsong, STXingkai; \newfontfamily \timesnewroman \arial \couriernew; \songti=\CJKfamily{SongTi}, \heiti=\arial\CJKfamily{HeiTi}, \kaiti, \lishu, \fangsong, \youyuan=\arial\CJKfamily{YouYuan} |
| font files (assets) | install-fonts.sh:3-23, 26-30 | `font.fontspec` | not shipped: Times New Roman, Arial, Courier New, SimSun, SimHei, KaiTi, FangSong, LiSu, YouYuan, STFangsong, STXingkai; script copies them from a Windows partition. Missing asset, noted, not a blocker |
| Chinese size scale | cls:136-152 | `font.size-commands` | \fontsize{pt}{lead}\selectfont: chuhao 42/50.4, xiaochu 36/43.2, yihao 26/31.2, xiaoyi 24/28.8, erhao 22/26.4, xiaoer 18/21.6, sanhao 16/19.2, xiaosan 15/18, sihao 14/16.8, shisanbang 13/15, xiaosi 12/14.4, wuhao 10.5/12.6, xiaowu 9/10.8, liuhao 7.5/9, xiaoliu 6.5/7.8, qihao 5.5/6.6, bahao 5/6 |
| footnote size | cls:254 | `font.size-commands` | \footnotesize := \xiaowu |
| verbatim font | cls:116 | `code.verbatim`, `font.size-commands` | \verbatim@font = \normalfont\ttfamily\linespread{1}\wuhao; sample has no verbatim |
| colour package | cls:77 | `color.color` | usenames |
| chapter heading | cls:196-198 | `head.titlesec` | \titleformat{\chapter}[block]{\linespread{1}\heiti\sanhao\bfseries\filcenter}{\thechapter}{1em}{}{}; \titlespacing{\chapter}{0em}{0pt}{18pt}. Also used for \chapter*. |
| section headings | cls:200-209 | `head.titlesec` | section [hang] {\linespread{1}\heiti\sihao\bfseries}{\thesection}{1em}, spacing 0em/24pt/6pt; subsection [hang] {\linespread{1}\heiti\shisanbang}, 12pt/6pt; subsubsection [hang] {\linespread{1}\heiti\xiaosi}, 12pt/6pt (proposal/interim cls:181-202 differ: chapter xiaoer songti bold, no label; section sanhao heiti bold; spacing in \baselineskip) |
| heading depth | cls:182 | `num.secnumdepth` | secnumdepth=4 |
| heading numbers | cls:186-189; main.tex:93 | `num.counters` | \thechapter=第 \arabic{chapter} 章; \thesection=\arabic{chapter}.\arabic{section}; subsection and subsubsection chain on it; main.tex:93 sets \thechapter empty before the bibliography (persists to the acknowledgement) |
| figure/table numbering | cls:191-194 | `num.counters` | chngcntr \counterwithin{figure}{chapter}, {table}{chapter}; xpatch edits `\c@t@sin` replacing `\@nameuse{the#2}.` by `\arabic{#2}-` (read as: numbers print "chapter-n") |
| front matter numbering | cls:185; main.tex:61 | `pgnum.pagenumbering` | \frontmatter patched to \pagenumbering{Roman}; \mainmatter (main.tex:77) arabic; \backmatter (main.tex:102) |
| running heads and feet | cls:211-227 | `hf.fancyhdr` | \fancyhf{}; \headrulewidth=0.5pt; \chaptermark -> \markright{#1}; \sectionmark empty; style `frontmatter`: head L \xiaowu\songti 浙江大学计算机科学与技术学院本科毕业设计报告, head R \rightmark, foot C \songti\xiaowu\thepage; style `mainmatter`: same but head R \thechapter\hspace{1em}\rightmark |
| page style switching | main.tex:49, 63-66, 73, 79-82, 104 | `hf.fancyhdr`, `hf.pagestyle-kernel` | \pagestyle{empty} for covers and agreement; \pagestyle{frontmatter}/{mainmatter} with \let\ps@plain\ps@<style> (so chapter-opening pages use it); \thispagestyle{empty}; backmatter empty |
| table of contents | cls:198-206, 228-243; main.tex:71 | `toc.titletoc`, `toc.kernel` | \titlecontents chapter [0em] \songti\sihao label+\hspace{1em}, leaders \titlerule*[5pt]{.}; section [2em] \songti\xiaosi; subsection [4em] \songti\wuhao; tocdepth=2; \contentsname=目录; \tableofcontents re-defined (heading \chapter*{\heiti\sanhao\bfseries 目录}) |
| names of generated parts | cls:241-252 | `toc.kernel`, `cap.kernel`, `bib.bibtex-bst` | \listfigurename 图~目~录, \listtablename 表~目~录 (lists not printed by the sample); \bibname 参考文献; \figurename 图; \tablename 表 |
| captions | cls:90, 251-253 | `cap.caption` | caption2 (legacy member of the caption bundle); \captionlabeldelim empty; \captionlabelsep \hspace{1em}; \belowcaptionskip=2mm |
| figure | cls:86; D/chapter-1.tex:11-16 | `fig.graphicx` | figure[!htbp], \centering, \includegraphics[width=\linewidth,keepaspectratio], \caption, \label |
| sub-figures | main.tex:7 | `fig.subcaption` | `subfigure` loaded, not used in the thesis body |
| table | cls:88-95; D/chapter-1.tex:22-33; main.tex:11-12 | `tbl.tabular`, `tbl.longtable`, `tbl.booktabs`, `tbl.multirow`, `tbl.siunitx`, `tbl.colortbl`, `tbl.threeparttable` | table[!htbp], caption above, tabular{\|c\|c\|} with \hline; longtable, booktabs, multirow, dcolumn, colortbl, threeparttable, array loaded; \LTpre=\LTpost=1em; \arraystretch=1 (cls:117); \newcolumntype{.}{D{.}{.}{2.4}} (cls:268) |
| landscape | cls:85 | `pg.landscape` | lscape loaded, unused |
| lists | cls:108-109 | `list.enumitem` | \setlist{noitemsep} |
| bibliography | cls:111-113; D/bibliography.tex:1-3 | `bib.bibtex-bst` | \bibliographystyle{data/gbt7714-2005}; \bibliography{data/bibliography}; thebibliography wrapper sets \itemsep=0em, \parskip=0em; heading is book's \chapter*{\bibname}; \addcontentsline{toc}{chapter}{\bibname} |
| citations | cls:265-266; D/chapter-1.tex:5 | `bib.bibtex-bst`, `mark.kernel` | \cite{k} := \textsuperscript{\cite{k}} (alias) |
| cross-references | D/chapter-1.tex:9,15,20,25 | `xref.kernel` | "图~\ref{...}", "表~\ref{...}" |
| math | cls:44-46; main.tex:21-22 | `math.amsmath`, `math.amssymb`, `math.bm` | amsmath[tbtags], amssymb, mathrsfs; \DeclareMathOperator*{\argmin}{arg\,min}, \argmax |
| theorem-like | cls:255-262 | `thm.amsthm` | \newtheoremstyle{zjutheorem}{9pt}{9pt}{\ttfamily}{0pt}{\lishu}{：}{0pt}{}; \newtheorem zjuhypothsis 假设~, zjudefine 定义~, zjutheorem 定理~, zjuproposition 命题~ each [chapter]; zjuproof = proof[\textnormal{\lishu 证明~}] |
| underline | cls:53; D/cover-zh.tex:36-42 | `mark.ulem` | ulem[normalem] loaded; covers use kernel \underline{\makebox[w]{...}} |
| links and URLs | cls:82-83; main.tex:6,10 | `meta.url`, `meta.hyperref` | url + \urlstyle{tt}; hyperref[hidelinks] loaded after the class |
| nomenclature | cls:79, 246-248 | `idx.glossaries` | nomencl loaded; \makenomenclature; \nomname \centerline{术~语~表}; \nomlabelwidth=25mm; \nompreamble \vspace{1em}; no \nomenclature or \printnomenclature anywhere in the zip |
| abstract (zh, en) | D/abstract-zh.tex:1-8; D/abstract-en.tex:1-8; main.tex:68-69 | `head.titlesec`, `abs.keywords` | a numberless-in-frontmatter \chapter{摘要}/{Abstract}; keyword line in a group: \vspace{1em}, \parindent=0em, \textbf{关键词} \; ... |
| acknowledgement | D/acknowledgment.tex:1-5 | `front.dedication` | \chapter*{致谢}; \addcontentsline{toc}{chapter}{致谢}; \markright{致谢} |
| chapters and sections | D/chapter-1.tex..chapter-6.tex; main.tex:84-91 | `head.titlesec` | \chapter + \section only; main.tex:84-95 puts \cleardoublepage between chapters |
| cover, Chinese | D/cover-zh.tex:1-44; main.tex:51 | `front.titlepage-env`, `fig.graphicx`, `sp.manual-space`, `sp.ragged`, `font.size-commands`, `sp.linespread`, `mark.ulem` | hand-laid group, \parindent=0em; \includegraphics[width=108mm]{xiaoming} and [width=35mm]{xiaobiao}; \vspace*{-1em}, \vspace{-1.5em}, \vspace{1em}, \vspace{9em}; \songti\erhao\bfseries\centering title; \linespread{1} then 1.6; seven label + \underline{\makebox[\titlelength]{value}} lines, \titlelength=22em (calc: \titlelength - 2em, - 3em) |
| cover, English | D/cover-en.tex:1-46; main.tex:53 | `front.titlepage-env`, `fig.graphicx`, `tbl.tabular`, `sp.manual-space`, `font.size-commands`, `mark.ulem` | \vspace*{-2.3em}, \vspace{3.6em}, {3em}, {1.1em}; \includegraphics[width=29.5mm]; \songti\xiaoer centred lines; tabular{l l} of 6 label/\underline{\makebox[\majorlength]{value}} rows, \majorlength=16em, \linespread{2}, \sanhao; \hspace{-3em} on the College row |
| originality statement | D/agreement.tex:1-61; main.tex:56 | `front.dedication`, `tbl.tabular`, `sp.manual-space`, `font.size-commands`, `sp.linespread` | \songti\xiaoer centred titles; body \linespread{1.6}\songti\xiaosi, \parindent=2em; \underline{\kaiti\sihao\bfseries\makebox[5em]{浙江大学}}; signature tabular{@{} p{0.5\linewidth} p{0.5\linewidth} @{}}; gaps \vspace{0.6em}..{4.85em} |
| assignment sheet, assessment sheet (backmatter) | D/assignment.tex:1-43; D/assessment.tex:1-62; main.tex:106-110 | `front.titlepage-env`, `sp.manual-space`, `tbl.tabular`, `mark.ulem` | hand-laid form pages (nearest lib way; no `titlepage` env is used): \vspace blocks 13em-15.5em, \hfill signature lines, \underline{\hspace{4em}}; assessment grade table tabular{\|c\|m{4.1em}\|m{4.1em}\|m{4.1em}\|m{9.1em}\|c\|}, \arraystretch=1.5 |
| page breaks | main.tex:52-110 | `pg.break` | \cleardoublepage after each \include, \newpage (main.tex:72); \include for every part |
| TikZ in preamble | main.tex:14-18 | `art.tikz` | tikz + libraries arrows,backgrounds,fit,shapes; \tikzstyle layer, block; \tikzset{>=latex}; no picture is drawn in the thesis body (see Content-opaque) |
| cover, interim report (interim) | interim/data/cover.tex:1-40 | `front.titlepage-env`, `tbl.tabular`, `sp.manual-space`, `font.size-commands`, `sp.linespread` | \baselinestretch=2, \vspace*{6.3em}, \songti\erhao / \yihao titles; the label/\underline{\makebox[16em]{}} rows sit in a kernel `tabbing` environment (grouped under `tbl.tabular`, kernel alignment environment; the consolidator may split it) |
| page styles (proposal, interim) | proposal/csbachelor.cls:209-226; proposal/main.tex:50,56-59,64-67 | `hf.fancyhdr` | styles `toc`, `kaitibaogao`, `waiwenfanyi`: head C \songti\xiaowu 浙江大学本科毕业设计~开题报告 / ~外文翻译, foot C \thepage |
| included PDF (proposal) | proposal/main.tex:77 | `pg.include-pdf` | \includepdf[pages=-]{data/waiwenyuanwen.pdf} |
| score tables (proposal) | proposal/data/kaohe.tex:24-30,56-62,93-99 | `tbl.tabular`, `box.minipage` | tabular{\|c\|c\|c\|c\|} with \parbox[c]{3.6em}{...} cells; flushright blocks |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| metadata setters `\zjutitle \zjuauthor \zjumentor \zjuinfo \zjucollege \zjudate` and getters | cfg:1-40; cls:269-272 (`\AtBeginDocument{\input{csbachelor.cfg}}`) | yes | They only store strings that the cover pages print; the emitter writes the values into the cover text (`front.titlepage-env`). No layout logic. |
| `\zjuthesis \zjubiaozhun \gbt7714` | cfg:41-43 | yes | plain text macros, never used by the sample |
| `\ifzju@side` choosing between two `\LoadClass` calls; `\zjuside` | cls:22-34 | yes | static: the `class.book` options twoside/oneside |
| options `numberorder`, `authoryear` | cls:19-20 | yes | dead: set `\zjubibstyle`, which nothing reads |
| Chinese size macros | cls:136-152 | yes | each is `\fontsize{a}{b}\selectfont`; inline it (`font.size-commands`) |
| CJK family macros `\songti \heiti ...` | cls:154-181 | yes | `\CJKfamily{...}` and `\newfontfamily` aliases (`lang.cjk`, `font.fontspec`) |
| `\xpatchcmd{\frontmatter}{...roman}{...Roman}` | cls:185 | yes | emit `\frontmatter\pagenumbering{Roman}` (`pgnum.pagenumbering`) |
| `\xpatchcmd{\c@t@sin}{\@nameuse{the#2}.}{\arabic{#2}-}` | cls:191-194 | yes, target unread | `\renewcommand{\thefigure}{\arabic{chapter}-\arabic{figure}}` and the same for table (`num.counters`). I did not read chngcntr's source (offline), so that `\c@t@sin` belongs to chngcntr and does exactly this is an inference from the replaced text. The patch has empty success and failure hooks, so a failed patch would be silent. |
| `\renewcommand\tableofcontents` | cls:228-240 | yes | copy of book's definition with a font switch and `\@mkboth` moved out of the `\chapter*` argument; reduces to book's `\tableofcontents` + `\contentsname`=目录 under the `head.titlesec` chapter format (which `\chapter*` also takes) |
| `\let\ps@plain\ps@frontmatter` / `\ps@mainmatter` | main.tex:64-66, 80-82 | yes | `\fancypagestyle{plain}{...}` with the same header/footer settings |
| `\cite` wrapper | cls:265-266 | yes | `\newcommand`-style alias: `\textsuperscript{\cite{k}}` emitted at each citation |
| `thebibliography` wrapper | cls:111-113 | yes | `\renewenvironment` around the old one that sets two lengths (`sp.lengths`) |
| `\verbatim@font` | cls:116 | yes | font and linespread parameters of a verbatim env (`code.verbatim`); unused by sample |
| `\newcolumntype{.}{D{.}{.}{2.4}}` | cls:268 | yes | array/dcolumn column type |
| `\contentsformat`, `\newlength{\titlelength}`, `\newlength{\majorlength}` | cls:228; D/cover-zh.tex:34-35; D/cover-en.tex:34-35 | yes | named font switch / lengths set once to fixed values |
| `\renewcommand{\thechapter}{}` | main.tex:93 | yes | `num.counters` value, no logic |
| theorem style, 4 theorem envs, `zjuproof` | cls:255-262 | yes | `\newtheoremstyle`, `\newtheorem`, `proof[...]` (`thm.amsthm`) |
| `\ifthenelse{\equal{\zjuside}{T}}{\newpage\mbox{}\thispagestyle{empty}}{}` (proposal, interim) | proposal/data/cover.tex:44; proposal/data/yaoqiu.tex:33; proposal/data/kaitibaogao.tex:37; interim/data/cover.tex:40 | yes | the test is fixed by the class option; with twoside emit `\newpage\mbox{}\thispagestyle{empty}` (`pg.break`) |
| `\renewcommand{\addcontentsline}[3]{}` (proposal) | proposal/main.tex:70 | yes, changed mechanism | hides ToC entries for the translation part; the emitter can write a negative `tocdepth` through `\addtocontents{toc}{\protect\setcounter{tocdepth}{-5}}` and restore it (`toc.kernel`, `num.secnumdepth`); not identical for list-of-figures/tables entries, which the sample never prints |
| `\renewcommand{\chapter}[2]{\section*{#2}\addcontentsline{toc}{section}{#2}}` around `\bibliography` (proposal) | proposal/data/kaitibaogao.tex:32-34 | yes, weakest reduction | retargets the `\chapter*` that the kernel bibliography emits into a section-level heading; reduce to a `\section*{参考文献}` plus section-level toc entry with the heading of the bibliography suppressed through natbib's `\bibsection` hook (`bib.natbib`), a different mechanism; proposal sample only |
| `\renewcommand{\clearpage}{}`, `\renewcommand{\cleardoublepage}{}` with local `\titleformat` (proposal) | proposal/data/waiwenfanyi.tex:4-7, 19-24 | yes | the second title is a centred `\sanhao\songti\bfseries` block (`sp.ragged`, `font.size-commands`), or titlesec `\titleclass{\chapter}{straight}`; proposal sample only |

## Content-opaque
- TikZ styles `layer`, `block` and `\tikzset{>=latex}` loaded in main.tex:14-18; no `tikzpicture` is drawn in the thesis body (grep over thesis/ finds none), so nothing template-defining is drawn.
- Included PNGs: thesis/data/chapter-1.tex:13 (placeholder.png), proposal/data/waiwenfanyi.tex:32; cover emblem and name images (thesis/data/cover-zh.tex:10,24; cover-en.tex:17) are shipped PNGs placed with `fig.graphicx`, not drawings.
- Included PDF proposal/data/waiwenyuanwen.pdf (proposal/main.tex:77) is content.
- Bibliography entries (thesis/data/bibliography.bib) are data.

## Lib changes
- New ways proposed: none. Judgement calls, no new way: XeTeX line-break primitives and `\frenchspacing` placed in `sp.lengths`; `\XeTeXlinebreaklocale` also named under `lang.cjk`; kernel `tabbing` placed in `tbl.tabular`; hand-laid form pages placed in `front.titlepage-env`; `nomencl` placed in `idx.glossaries` and not treated as `EXTERNAL/package` (it needs `makeindex` only when `\nomenclature` is used, the sample never uses it, and the document does not depend on the tool to compile); the `.bst` (nju-thesis style by Haixing Hu, gbt7714-2005.bst:3-8) taken as a parameter of `bib.bibtex-bst`, as the lib states.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
