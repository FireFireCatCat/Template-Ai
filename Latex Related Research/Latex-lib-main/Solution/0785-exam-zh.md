yes

# 0785-exam-zh: exam-zh, a LaTeX template for Chinese exams

- Unverified: read from the source, not compiled.
- Source: Source/0785-exam-zh/ (origin: https://mirrors.ctan.org/macros/xetex/latex/exam-zh.zip; licence: lppl1.3c per manifest, LPPL 1.3c per ctan.org/pkg/exam-zh and tex/exam-zh.cls:3)
- Kind: exam
- Lib: v6
- Engine: needs XeLaTeX (tex/exam-zh.cls:23-24 raises a fatal error unless the engine is XeTeX; fontspec, xeCJK, xeCJKfntef, unicode-math at cls:69-71 and tex/exam-zh-font.sty:16; the CTAN page says "requires XeLaTeX")
- Look carried by: class (the zip is the CTAN `exam-zh` distribution; the sample adds only `\examsetup` key values, `siunitx`, `\everymath` and content)
- Class origin: ctan (ctan.org/pkg/exam-zh read: v0.3.6, 2026-08-01, LPPL 1.3c, authors Lijun Guo and Kangwei Xia; the zip's own class says v0.3.6 at tex/exam-zh.cls:10)
- Main file: examples/example-multiple.tex (other samples: examples/example-single.tex, examples/basic/00-minimal.tex, 01-first-exam.tex, 02-math-basic.tex, all `\documentclass{exam-zh}`; doc/exam-zh-doc.tex and doc/basic/exam-zh-doc-basic.tex use the documentation class `xdyydoc`, not analysed)
- Read: main yes (545 lines), zip-local classes and styles partly (read in full: tex/exam-zh.cls, exam-zh-question.sty, exam-zh-font.sty, exam-zh-choices.sty, exam-zh-counter.sty; partly: exam-zh-symbols.sty lines 1-100 of 1177, exam-zh-textfigure.sty lines 355-719 of 719, exam-zh-circlednumber.sty lines 1-40 of 116; not read, outline Grep only: exam-zh-math.sty, exam-zh-chinese-english.sty, doc/xdyydoc.cls)

## Verdict
yes, under the published-class ruling. The zip is the CTAN `exam-zh` class and its modules; the sample defines no macro, environment or counter of its own and only sets declarative `\examsetup` keys, loads `siunitx`, and writes class-native body vocabulary, so an emitter writes only `\documentclass{exam-zh}`, `\examsetup{...}`, published packages and the class's own commands. The class itself contains TikZ seal-line artwork, expl3 layout code and a shell-escape hook, which would block a zip-local class; here they are reached only through the class's declarative keys and are the class way, not sample code. No `minted`, pygments, Makefile or generator is used anywhere in `tex/`.

## Blockers
none

## Class setting
- Class: `class.exam-zh` options: none on `\documentclass` (main:6); the class passes `UTF8, scheme = chinese, openany` to `ctexbook` (tex/exam-zh.cls:36) and loads `ctexbook` (cls:53); all settings go through `\examsetup{key=value}` (cls:28-29), whose key families are `page`, `style`, `sealline`, `square`, `paren`, `fillin`, `solution`, `question`, `problem`, `choices`, `title`, `notice`, `list`, `draft`, `scoringbox`, `font`, `math-font` (cls:138-2152, question.sty:111-247, choices.sty:33-62, font.sty:23-60).
- Class-native vocabulary used: `\examsetup` (page/size, page/show-columnline, style/fullwidth-stop, sealline/*, square/*), `\examsquare`, `\title`, `\subject`, `\secret`, `\maketitle`, `notice` environment with `\item`, `\tableofcontents`, `\chapter`, `\section` as the question-group heading, `question[points=]`, `problem[points=]`, `choices` with `\item`, `\paren[ ]`, `\fillin[ ][ ]`, `solution`, `\score{}`, `\textfigure{text}{figure}`, `\iu` `\eu` `\uppi`, plus ctex `\heiti` `\zihao` and `enumerate` (enumitem). Unused by the sample: `select`, `lineto`, `material`, `poem`, `writingbox`, `calculations`, `multifigures`, `\draftpaper`, `\scoringbox`, `\information`, `\warning`, `\ExamPrintAnswer`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | examples/example-multiple.tex:6; tex/exam-zh.cls:10,53 | `class.exam-zh` | no options; base class `ctexbook` |
| class setting call | examples/example-multiple.tex:9-36; tex/exam-zh.cls:28-29 | `class.exam-zh` | `\examsetup{page={...}, style/fullwidth-stop=catcode, sealline={...}, square={...}}` |
| paper size, columns | examples/example-multiple.tex:10-13; tex/exam-zh.cls:444-489 | `page.class-options` | page/size=a3paper, show-columnline=false (default `a4paper`, margin 1in, headheight 0.7in at cls:481-489) |
| page geometry (class-internal) | tex/exam-zh.cls:68,1295-1310 | `page.geometry` | a3 with seal line: twoside, paper=a3paper, landscape, twocolumn, columnsep=30mm, margin=1in, inner=1.2in, outer=0.8in, headheight=0.7in |
| lengths (class-internal) | tex/exam-zh.cls:530-536,1293-1294 | `sp.lengths` | `\lineskiplimit`=.5em, `\lineskip`=.5em, `\normallineskip`=.5em, `\columnseprule` from columnline-width=0.4pt when show-columnline |
| footer | tex/exam-zh.cls:1646-1660,1852-1933 (sample keeps defaults) | `hf.class-native` | show-head=false, show-foot=true, foot-content=`数学试题第;页（共;页）`, foot-type=separate (cls:488), footer text computed 2*page-1 and 2*page for the two a3 halves (cls:1700-1729) |
| footer realisation (class-internal) | tex/exam-zh.cls:72,1854-1931 | `hf.fancyhdr` | `\fancypagestyle{plain}`, `\fancyhf{}`, `\fancyfoot[L]` and `[R]` for a3 separate, `[C]` for a4 |
| page X of Y (class-internal) | tex/exam-zh.cls:73,1713,1739-1746 | `pgnum.lastpage` | `lastpage`, `\pageref{LastPage}` |
| seal line (密封线) | examples/example-multiple.tex:15-31; tex/exam-zh.cls:841-1061,1105-1129,1329-1587 | `class.exam-zh` | sealline: show=true, scope=mod-2, circle-show=false, line-type=solid, odd-info-content={姓名 / 准考证号 / 考场号 / 座位号 rows}, odd-info-xshift=12mm, text=此卷只装订不密封, text-width=0.98\textheight, text-format=\zihao{-3}\sffamily, text-xshift=20mm; drawn by a TikZ overlay in a `shipout/background` hook, reached only by these keys |
| information squares | examples/example-multiple.tex:22-24,32-35; tex/exam-zh.cls:1590-1640 | `class.exam-zh` | `\examsquare{9}` `{2}`; square x-length=1.8em, y-length=1.6em (defaults 1.4em, 1.2em, linewidth 0.4pt at cls:1598-1604) |
| full-width stop | examples/example-multiple.tex:14; tex/exam-zh.cls:138-159 | `class.exam-zh` | style/fullwidth-stop=catcode (makes U+3002 active, cls:150-154) |
| Latin text fonts | tex/exam-zh-font.sty:23-41,69-95,653-659 | `font.fontspec` | default font=newcm: `\setmainfont{NewCM10}` `\setsansfont{NewCMSans10}` `\setmonofont{NewCMMono10}`, Extension=.otf, Upright/Bold/Italic/BoldItalic names |
| math fonts | tex/exam-zh-font.sty:16,65,380-387,443-491,653-659 | `font.unicode-math` | math-font=newcm: `\setmathfont{NewCMMath-Book}[StylisticSet=2]`, STIX Two Math for range `\complement,\bigstar`, `\unimathsetup{math-style=ISO, bold-style=ISO, partial=upright}`, Asana-Math.otf for `\varnothing` |
| CJK fonts and text | tex/exam-zh.cls:43-53,504-526; examples/example-multiple.tex:21-24,29 | `lang.cjk` | ctexbook (UTF8, scheme=chinese), xeCJK with `\defaultCJKfontfeatures{Script=CJK}`, `\setCJKsansfont{SimHei}` (windows) or `Heiti SC` (mac), `\xeCJKDeclareCharClass`; sample uses `\heiti`, `\zihao{4}`, `\zihao{-3}` |
| inline marks | examples/example-multiple.tex:21-24,29 | `mark.kernel` | `\underline`, `\sffamily` |
| manual space | examples/example-multiple.tex:21 | `sp.manual-space` | `\hspace*{8em}` |
| title block | examples/example-multiple.tex:42,44,60; tex/exam-zh.cls:679-743 | `front.class-native` | `\title`, `\subject{数学（理科）}` (letter-spread box, cls:706-725), `\maketitle` redefined as centred block (cls:728-743); title-format=\Large, subject-format=\sffamily\bfseries\huge, top-sep=-.5em plus 0.3em minus 0.2em, bottom-sep=0em plus 0.3em minus 0.2em |
| secrecy line | examples/example-multiple.tex:58; tex/exam-zh.cls:757-765 | `front.class-native` | `\secret` prints 绝密 ★ 启用前 in `\bfseries` |
| notice block | examples/example-multiple.tex:65-71; tex/exam-zh.cls:769-808 | `front.class-native` | `notice` environment: label=注意事项：, label-format=\sffamily\bfseries, top-sep and bottom-sep=.25em plus .25em minus .1em; built on `enumerate` with leftmargin=0pt, itemindent=3.5em, labelsep=0.5em, labelwidth=1.5em, align=right, label=\arabic*. |
| contents | examples/example-multiple.tex:49; tex/exam-zh.cls:273-309 | `toc.kernel` | `\tableofcontents` called plainly; class redefines it (`\patchcmd`, `\onecolumn`=`\twocolumn`, empty page style, page counter 0 then 1), a class-native front-matter effect (`front.class-native`) |
| contents depth | tex/exam-zh.cls:161-171 | `num.secnumdepth` | ctex key tocdepth=0 |
| exam heading (chapter) | examples/example-multiple.tex:51,363; tex/exam-zh.cls:161-171,395-424 | `head.class-native` | `\chapter` redefined (resets section counter and question index, optional silent entry in contents); ctex chapter: numbering=false, beforeskip=-4ex, afterskip=4ex minus 1ex |
| question-group heading | examples/example-multiple.tex:75,176,237,273; tex/exam-zh.cls:813-823 | `head.class-native` | `\ctexset{section={format=\heiti\bfseries, number=\chinese{section}, aftername={、}, beforeskip=2ex plus 1ex minus .5ex, afterskip=1ex plus .2ex minus 1ex}}` |
| multiple-choice and blank-fill question | examples/example-multiple.tex:81-90,240-245; tex/exam-zh-question.sty:111-183,271-280,381-537 | `class.exam-zh` | `question[points=2]`: index, points, show-points=auto, top-sep and bottom-sep=.25em plus .25em minus .1em, label=\arabic*., label-align=right, hang=true; kernel `\list`/`\item` inside |
| question penalties (class-internal) | tex/exam-zh-question.sty:397-400,740-743 | `sp.penalties` | clubpenalty=10000, widowpenalty=10000, interlinepenalty=301 |
| solution-type question | examples/example-multiple.tex:276-286,345-358; tex/exam-zh-question.sty:185-247,298-307,723-803 | `class.exam-zh` | `problem[points=12]`: points-separate-par=true, hang=false, points-prelabel=（, points-postlabel=分）, label-align=right |
| answer choices | examples/example-multiple.tex:84-89; tex/exam-zh-choices.sty:36-83,126-169 | `class.exam-zh` | `choices`, items split at `\item`; columns auto (0), max-columns=4, label=\Alph*., label-pos=auto, label-align=left, label-sep=.5em, column-sep=1em, show-answer=false, answer-color=red; coffins join label and item |
| answer parentheses | examples/example-multiple.tex:82,94; tex/exam-zh-question.sty:886-973 | `class.exam-zh` | `\paren[]`, `\paren`; paren/type=hfill, show-paren=true, show-answer=false (answer text in `\paren[B]` only when shown, example-single.tex:54) |
| fill-in blanks | examples/example-multiple.tex:241,251,256,267; tex/exam-zh-question.sty:1013-1066,1334-1344,1521-1537 | `class.exam-zh` | `\fillin[$1$]`, `\fillin[width = 4em][]`, `\fillin`; type=line, width=3em, no-answer-type=blacktriangle, depth=0.4em; line drawn by xeCJKfntef `\CJKunderline` (cls:71, question.sty:1590-1607) |
| worked solution and score | examples/example-multiple.tex:242-244,352-357,354; tex/exam-zh-question.sty:1983-2112,2195-2207 | `class.exam-zh` | `solution` environment, show-solution=hide (default), label-content=解答, show-qed=true, qedsymbol=$\square$, score-post-content=分, score-format=\color{red}; `\score{2}` |
| QED mark (class-internal) | tex/exam-zh-question.sty:17,2164,2186-2187 | `thm.amsthm` | `amsthm` `\pushQED{\qed}`, `\popQED` |
| hidden-solution box (class-internal) | tex/exam-zh-question.sty:20,2148-2159 | `box.tcolorbox` | `tcolorbox[most]`; `invisible, frame hidden, breakable, opacityback=0, opacityframe=0, size=minimal`; used only when blank-type=hide |
| text beside figure | examples/example-multiple.tex:318-329; tex/exam-zh-textfigure.sty:366-464,552-577 | `class.exam-zh` | `\textfigure{text}{figure}`: fig-pos=bottom-right, text-ratio=1, column-gap=1em, bottom-sep=1.5ex plus .5ex minus .5ex, coffin join |
| text and figure boxes (class-internal) | tex/exam-zh-textfigure.sty:16,558,570 | `box.minipage` | `varwidth` environments with `\centering`, widths from text-width and figure-width |
| included picture | examples/example-multiple.tex:328 | `fig.graphicx` | `\includegraphics[width=3cm]{example-image.png}` (content, see below) |
| in-question sub-lists | examples/example-multiple.tex:282-285,299-302; tex/exam-zh.cls:75,562-598; tex/exam-zh-question.sty:312-379 | `list.enumitem` | `\setlist{nosep}`; in `question` level 1 label=（\arabic*）, labelindent=\parindent, labelsep=2pt, leftmargin=*, level 2 （\alph*）, level 3 （\roman*）; in `problem` level 1 labelindent=2em, labelsep=4pt, level 2 （\roman*）, level 3 （\alph*） |
| inline maths style | examples/example-multiple.tex:40 | `math.everymath` | `\everymath{\displaystyle}` |
| piecewise maths | examples/example-multiple.tex:278-281; tex/exam-zh.cls:74 | `math.amsmath` | `cases` from `amsmath` (class loads it) |
| display maths | examples/example-multiple.tex:354 | `math.kernel` | `\[ ... \]` |
| upright constants | examples/example-multiple.tex:94,116,150; tex/exam-zh-symbols.sty:22-27 | `class.exam-zh` | `\iu`, `\eu`, `\uppi` = `\mathrm{i}`, `\mathrm{e}`, `\mathrm{\pi}`; `\frac` and `\dfrac` redefined (symbols.sty:57-98, restyle off by default, frac-add=5mu) |
| units and angles | examples/example-multiple.tex:7,262-268,324; tex/exam-zh.cls:828-833 | `mark.siunitx` | `\usepackage{siunitx}`; `\qtyproduct`, `\qty`, `\unit`, `\ang`; class provides `\unit` as `\si`, `\qty` and `\qtyproduct` as `\SI` only when absent |
| PDF links | tex/exam-zh.cls:92-102 | `meta.hyperref` | at end of preamble: bookmarksnumbered, psdextra, unicode, hidelinks |
| page-break hint | examples/example-multiple.tex:309 | `pg.break` | `\nopagebreak` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| sample macros, environments, counters | examples/example-multiple.tex | none present | the sample has only `\examsetup`, `\usepackage{siunitx}`, `\everymath` and class-native calls |
| exam-zh class and its nine modules | tex/exam-zh.cls, tex/exam-zh-*.sty | not bespoke: published on CTAN (W1) | recorded as `class.exam-zh`; its internals (TikZ seal line cls:1329-1587, expl3 coffin layouts choices.sty:448-551 and textfigure.sty:578-720, `linegoal`-patched `\fillin` question.sty:32-60,1854-1880, aux-file answers question.sty:2049-2142, catcode switch cls:150-154) would be irreducible if the class were zip-local |
| latexmk shell hook | tex/exam-zh.cls:224-269 | published class code, runs only when `\sys_if_shell_unrestricted:T` is true (full `-shell-escape`); no effect on a normal compile | part of the class way; see Notes |
| documentation class `xdyydoc` | doc/xdyydoc.cls (identical copy doc/basic/xdyydoc.cls), `\LoadClass{l3doc}` and ctex at lines 5-6 | not assessed: not loaded by the main sample or the other `examples/` files | outside this verdict; origin on CTAN not checked |

## Content-opaque
- Included picture `example-image.png` at examples/example-multiple.tex:328 (artwork; the file is not in the zip).
- Chinese question text, equations, the notice paragraphs, seal-line prompt strings and the answer data are content.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Not blockers, recorded: (1) cls:224-269 runs `latexmk -xelatex` twice and then `\stop` only under unrestricted shell escape; the default restricted mode skips it, so the sample compiles without any outside tool. A compile with full `-shell-escape` would take the other path. (2) Several XeLaTeX passes are needed (`lastpage` at cls:73, `linegoal` positions at question.sty:32-60, TikZ `remember picture` at cls:1333). (3) Fonts are not shipped: NewCM10 and NewCMMath-Book (font.sty:71,450), STIX Two Math (font.sty:231-238), Asana-Math.otf (font.sty:65, loaded at begin-document for every compile), SimHei or Heiti SC (cls:510,519) plus the ctex font set.
- Wording defaults are strings inside the class, set by keys where a key exists: 注意事项： (tex/exam-zh.cls:779), 数学试题第;页（共;页） (cls:1659), 草稿纸 (cls:2012), 得分 and 阅卷人 (cls:2042-2043), 解答 (tex/exam-zh-question.sty:2031), 分 (question.sty:2036), 参考答案 (question.sty:2120).
- Considered `exam.questions` for the question environments; not used because the question, problem, choices, `\paren` and `\fillin` vocabulary is the class's own, which the lib records under the class way (v3 merge of `exam.class-native` into a class way).
