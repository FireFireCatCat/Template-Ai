no

# 0529-jlreq: jlreq (Japanese document class) and its README pandoc template

- Unverified: read from the source, not compiled.
- Source: Source/0529-jlreq/ (origin: https://mirrors.ctan.org/macros/jptex/latex/jlreq.zip; licence: bsd2, 2-clause BSD, LICENSE:1)
- Kind: misc
- Lib: v4
- Engine: needs LuaLaTeX (`lualatex` class option and `luatexja-preset`, README-template.tex:1-2; the class also runs under pLaTeX/upLaTeX, README.md:21; XeLaTeX is not stated by README.md or ctan.org/pkg/jlreq)
- Look carried by: mixed (class `jlreq` carries page, Japanese typography, heading, page-style and note defaults; README-template.tex:1-62 adds heading overrides, link colours and a boxed code style)
- Class origin: ctan
- Main file: README-template.tex (other samples: none; README.md and README-ja.md are the Markdown sources pandoc pours into `$body$`)
- Read: main yes, zip-local classes and styles partly (jlreq-helpers.sty and jlreq-complements.sty in full; jlreq.cls by outline plus lines 1-480, 3280-3370, 5476-5735, 6486-6625, 6770-6818; jlreq-trimmarks.sty and the four `.lua` files by outline and head only)

## Verdict
The zip is the CTAN release of the published class `jlreq`, so the class is one way (`class.jlreq`) and none of its files is bespoke. The only sample, `README-template.tex`, reduces completely to lib ways: its preamble is class options, `luatexja-preset`, `hyperref`, `\ModifyHeading` and a tcolorbox code box, and every macro in it is reducible. The answer is still `no`, on one blocker: the sample is a pandoc template (its whole body is the placeholder `$body$`), and the Makefile builds the documentation PDFs by running `pandoc`, which the rubric lists as EXTERNAL. If pandoc were read as content authoring, nothing else would block.

## Blockers
- `EXTERNAL/body` pandoc fills the sample's body and builds the PDFs: `$body$` (README-template.tex:67), `pandoc ... --pdf-engine=lualatex --template README-template.tex` (Makefile:181,186,189); `README-template.html` is likewise a pandoc template with `$if(lang)$` (README-template.html:2).
- Recorded, not blockers: (1) missing assets, the macOS Hiragino fonts named by `hiragino-pron` (README-template.tex:2) are not shipped; (2) the vertical JFM `jfm-jlreqv.lua` and the pTeX `.tfm`/`.vf` files are build outputs of `make` (`texlua make_variant_jfm.lua`, `makejvf`, `ppltotf`, `uppltotf`: Makefile:37,69,131,173-174) and are not in the zip; TeX Live ships them built, and the horizontal LuaLaTeX sample needs only `jfm-jlreq.lua`, which is present; (3) no package that `jlreq.cls` loads needs a tool outside TeX (jlreq.cls:467,471,1087,3498; jlreq-complements.sty:264).

## Class setting
- Class: `class.jlreq` options: `paper=a4,fontsize=11pt,jafontscale=0.92,lualatex` (README-template.tex:1; keys declared at jlreq.cls:108,136,291,296)
- Class-native vocabulary used: `\ModifyHeading{section|paragraph}{font,indent,after_label_space}` (README-template.tex:11-12; defined jlreq.cls:3286); `\zw` (README-template.tex:31, a LuaTeX-ja length, README.md:68). Vocabulary the class offers and the sample does not use: `\jlreqsetup` (jlreq.cls:437), `\NewBlockHeading` `\NewRuninHeading` `\NewTobiraHeading` `\NewCutinHeading` (jlreq.cls:2660,3140,1937,3276), `\SetBlockHeadingSpaces`, `\SaveHeading` (jlreq.cls:3313), `\NewPageStyle` (jlreq.cls:5208), `\sidenote` `\endnote` `\warichu` `\tatechuyoko` `\jidori` `\akigumi` `\jafontsize` (README.md:36-60), class options `tate` `book` `report` (README.md:21).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | README-template.tex:1; jlreq.cls:8 | `class.jlreq` | paper=a4, fontsize=11pt, jafontscale=0.92, lualatex |
| page size and text block | README-template.tex:1; jlreq.cls:136,291,407-416 | `page.class-options` | paper=a4; line_length, number_of_lines, head_space, gutter left at class defaults (empty, so 0.75 of the page, README.md:113-114); baselineskip 17zw/10 |
| Japanese layer, fonts, JFM | README-template.tex:2; jlreq.cls:458-471 | `lang.cjk` | `luatexja-preset` with jfm_yoko=jlreq, jfm_tate=jlreqv, hiragino-pron, nfssonly (the package is the parameter); class loads `luatexja` and `luatexja-adjust` |
| Japanese spacing parameters | README-template.tex:17-18; jlreq.cls:472-474 | `lang.cjk` | `\ltjsetparameter{alxspmode={`\\,allow}}`, `{`*,allow}`; class sets lineend=extended, stretch_priority kanjiskip=0 xkanjiskip=10, shrink_priority kanjiskip=0 xkanjiskip=-30 |
| links | README-template.tex:3-4 | `meta.hyperref` | unicode=true; pdfborder={0 0 0}, breaklinks=true, colorlinks=true, linkcolor=blue, urlcolor=blue |
| font encoding | README-template.tex:5 | `font.fontenc-t1` | T1 |
| paragraph indent | README-template.tex:7 | `sp.lengths` | `\parindent`=0pt |
| upright quotes in code | README-template.tex:8 | `code.upquote` | load-only; the `\IfFileExists` guard resolves to a plain load |
| section numbers | README-template.tex:9-10; defaults jlreq.cls:6526-6533 | `num.counters` | `\thesection` empty, `\thesubsection`=`\arabic{subsection}` |
| headings (section, paragraph) | README-template.tex:11-12; jlreq.cls:3286,6544,6547 | `head.class-native` | section: font=`\Huge\bfseries\sffamily`, indent=0pt, after_label_space=0pt; paragraph: indent=0pt; other keys stay at class defaults (lines=3, second_heading_text_indent) |
| typewriter family | README-template.tex:14-16; class hook jlreq.cls:1127-1132 | `font.nfss` | `\ttfamily` set to the Latin tt family through `\romanfamily\ttdefault\selectfont` (it appears to skip the class's `ttfamily` hook that links a Japanese family; read, not compiled); also `font.family-default` for `\ttdefault` |
| colours of code tokens | README-template.tex:19,32-62 | `color.xcolor` | `\textcolor[rgb]{r,g,b}` and `[HTML]{008000}`, `{0040FF}`; 31 token macros |
| token emphasis | README-template.tex:32,46,51,58-61 | `mark.kernel` | `\textbf`, `\textit` inside the token macros |
| code blocks | README-template.tex:20-31 | `code.verbatim`, `box.tcolorbox` | fancyvrb `Highlighting` (commandchars=\\\{\}); `moreverb` `\verbatimtabinput`; tcolorbox library skins; `\newtcolorbox{Shaded}{colframe=white,beforeafter skip=1\zw}`; `verbatim` redefined over `\tcbverbatimwrite` |
| page style (default) | jlreq.cls:6566-6600,6785 | `hf.class-native` | `plain`: nombre=`\thepage`, bottom-center, font `\small`; `headings`, `myheadings` via `\NewPageStyle` |
| body headings, lists, inline code, links, fenced code | README.md:1,9,18-20,193 (inferred: pandoc writes `\section`..`\paragraph`, `itemize`, `\texttt`, `\href`, `Shaded`) | `head.class-native`, `list.kernel`, `mark.kernel`, `meta.hyperref`, `code.verbatim` | `#` to `####` map to `\section` to `\paragraph`; bullets nest; no tables, images or equations in README.md (grep) |
| class-defined, unused by the sample | jlreq.cls:5497-5706,5709-5735,6618-6624; jlreq-complements.sty:93,157,219-258 | `front.class-native`, `abs.class-native`, `thm.class-native`, `bib.thebibliography`, `idx.makeidx`, `list.kernel`, `quote.kernel`, `fn.kernel`, `cap.kernel` | `\maketitle`/`titlepage`, `abstract` (abstract_with_maketitle), theorem style `jlreq` over amsthm, `thebibliography` and `theindex` redefined, itemization_* and quote_* keys, caption_* keys (the lib has no class-native caption line; considered: none, since the sample prints no caption) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\newcommand{\tightlist}{}` | README-template.tex:6 | yes | empty pandoc stub; no node uses it once pandoc is not the source of the body |
| `\DeclareRobustCommand\ttfamily{\not@math@alphabet\ttfamily\mathtt\romanfamily\ttdefault\selectfont}` | README-template.tex:14-16 | yes (judgement) | one font-switch redefinition, no counters, boxes or conditionals: `font.nfss` + `font.family-default`; it names a kernel internal (`\not@math@alphabet`) and `\romanfamily` (a LuaTeX-ja/pLaTeX command, its source not in this zip) |
| `\renewenvironment{verbatim}` + `\newtcolorbox{Shaded}` | README-template.tex:24-31 | yes | published commands only (`\tcbverbatimwrite`, `\verbatimtabinput`, `\newtcolorbox`): a `code.verbatim` body inside a `box.tcolorbox`, colframe=white |
| 31 token macros `\KeywordTok` ... `\NormalTok` | README-template.tex:32-62 | yes | each is `\textcolor[...]{...}{\textbf{#1}}` or the identity: inline expansion into `color.xcolor` + `mark.kernel` |
| `\IfFileExists{upquote.sty}{\usepackage{upquote}}{}` | README-template.tex:8 | yes | the file is in TeX Live, so a plain `code.upquote` load |
| `jlreq.cls`, `jlreq-helpers.sty`, `jlreq-complements.sty` (expl3, `\directlua`) | jlreq.cls:1,11,461; jlreq-helpers.sty:6; jlreq-complements.sty:5 | not bespoke | published on CTAN and in TeX Live, by the zip's own authors: the class is the way `class.jlreq`; its internals are not analysed for reducibility |
| `jfm-jlreq.lua`, `jfm-jlreq-jidori.lua` (Lua glue tables, read `jlreq.open_bracket_pos`) | jfm-jlreq.lua:1141-1170,1192 | not bespoke | data files of the same published package, loaded by LuaTeX-ja through `jfm_yoko=jlreq` |
| `jlreq-trimmarks.sty` | jlreq-trimmarks.sty:2,8 | not bespoke, not loaded | published companion package (trim marks, DVI drivers `dvipdfmx` `dvips` `dviout`); the sample and the class do not load it (jlreq.cls:373-375 only warn) |
| `Makefile`, `make_variant_jfm.lua`, `luajfm2pl.lua` | Makefile:37,173-181; make_variant_jfm.lua:1; luajfm2pl.lua:1 | not loaded | build tooling for JFM files and docs; the pandoc rules are the blocker above |

## Content-opaque
none (README.md holds no figure, table or equation; its fenced `latex` blocks are code text)

## Lib changes
- New ways proposed: none. `luatexja-preset` is read as `lang.cjk` with the package as the parameter (the line names `CJK`/`xeCJK`/`ctex`; the consolidator may widen its text, as `lang.xepersian` into `lang.polyglossia`). Considered and not written as new ways: `jlreq-trimmarks` (not loaded by the sample), a class-native caption line (no caption in the sample).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
