no

# 0920-sylvainhalle-papershell: PaperShell v3 (multi-publisher paper shell, sample set to Springer LNCS)

- Unverified: read from the source, not compiled.
- Source: Source/0920-sylvainhalle-papershell/ (origin: https://codeload.github.com/sylvainhalle/PaperShell/zip/refs/heads/v3; licence: not established). All paths below are relative to that folder; the zip has its own inner `Source/` directory, so `Source/paper.tex` is the sample.
- Kind: conference (the sample is an LNCS paper; the manifest hint `misc` is wrong)
- Lib: v6
- Engine: needs LuaLaTeX (generator pass only: `\directlua` at Source/tex/papershell.tex:8-12 and the `\ifLuaTeX` gate at Source/paper.tex:19; the generated preamble has a pdfLaTeX branch, Source/tpl/lncs/preamble.tpl:11-15)
- Look carried by: mixed (page look and front matter come from the llncs class; the preamble that loads it, and every publisher choice, is produced by a zip-local Lua template engine)
- Class origin: ctan (llncs; zip copy is v2.21 of 2022/01/12, Source/sty/lncs/llncs.cls:1,22; ctan.org/pkg/llncs lists the package, at a newer version 2.26)
- Main file: none holds `\documentclass`. Source/paper.tex is the sample body, its `\documentclass` and `\begin{document}` live only in the generated `gen/preamble.inc.tex`, which the zip does not ship (other samples: none)
- Read: main yes, zip-local classes and styles partly (llncs.cls, cas-sc.cls, llncsdoc.sty, myclass.cls all read; cas-dc.cls lines 1-80 of 187; acmart.cls, acmart-tagged.cls, IEEEtran.cls, cas-common.sty only outlined with Grep; .bst/.bbx/.cbx/.dbx/.dtx not read)

## Verdict
no. The sample has no `\documentclass` of its own: `Source/paper.tex:18-26` loads a Lua generator (`Source/tex/papershell.tex`, `papershell.lua`, `template_engine4.lua`) that must run once under LuaLaTeX and writes `gen/preamble.inc.tex`, `midamble` and `postamble` from `.tpl` files that contain Lua control flow. That is code that computes the preamble and front matter, which the rubric calls irreducible. For the fixed setting `publisher=lncs` the generated text is a short preamble over published packages plus `class.llncs`, and it would map to lib ways, but the zip's identity is the generator, not that output. The alternate publisher templates add a file-copy abstract hack (cas) and a kernel internals patch (IEEE).

## Blockers
- `BESPOKE/preamble` Lua template engine and key-value bridge that compute the whole preamble, midamble and postamble from `\papershellsetup{...}` (Source/tex/template_engine4.lua:250-375; Source/tex/papershell.lua:23-116; Source/tex/papershell.tex:3-15; Source/paper.tex:18-26, 69, 71)
- `BESPOKE/preamble` Lua loops and conditionals inside the templates choose packages and print author blocks (Source/tpl/lncs/preamble.tpl:21-25, 33-42; Source/tpl/cas/preamble.tpl:67-84; Source/tpl/ieeetran/preamble.tpl:27-56)
- `BESPOKE/preamble` `\CASCopyFile` copies `abstract.tex` into `\jobname.abs` with `\newread`/`\newwrite`/`\loop` and hooks `\maketitle`, alternate publisher cas-sc only (Source/tpl/cas/preamble.tpl:25-50)
- `BESPOKE/preamble` `\let\l@ENGLISH\l@english` patch of a kernel internal, alternate publisher ieeetran only, no lib way (Source/tpl/ieeetran/preamble.tpl:82-84)

## Class setting
- Class: `class.llncs` (loaded as `sty/lncs/llncs`, no options: Source/tpl/lncs/preamble.tpl:6). The class loads `article` with `twoside` (Source/sty/lncs/llncs.cls:51) and requires `multicol` and `aliascnt` (:52-53). Options it declares: `envcountreset` `citeauthoryear` `oribibl` `orivec` `envcountsame` `envcountsect` `runningheads` `openbib` (:26-40); none is passed.
- Class-native vocabulary used: `\title`, `\author` with `\inst{n}` and `\and`, `\institute` (Source/tpl/lncs/preamble.tpl:33-47; defined llncs.cls:851,877,996), `\maketitle` (llncs.cls:906), `abstract` environment (llncs.cls:1178), `\bibliographystyle{splncs04}` (Source/tpl/lncs/midamble.tpl:6), `\section` (llncs.cls:340). Declared but unused: `\keywords` (llncs.cls:889), `\spnewtheorem` environments (llncs.cls:1044-1157), `\orcidID` (llncs.cls:878).
- Other publisher classes carried by the zip (not loaded by the sample): `class.acmart` (v2.16 2025/08/27, Source/sty/acmart/acmart.cls:41-42; option `acmsmall`, tpl/acmart/preamble.tpl:6), `class.ieeetran` (V1.8b, IEEEtran.cls:206; option `conference`), `class.cas-sc` and a double-column sibling cas-dc (CAS bundle v2.4 2024/05/04, cas-sc.cls:20-24; matches CTAN els-cas-templates v2.4 2024-05-04). `Source/sty/acmart/acmart-tagged.cls` is not referenced by any template. `Source/sty/foo/myclass.cls` is a one-line stub, `\ProvidesClass{foo}` (myclass.cls:1).

## Component map
Sample = publisher `lncs` (Source/settings.tex:5), with the generated preamble written out as the template prints it. Rows marked "alt" come from the unused publisher templates.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | Source/tpl/lncs/preamble.tpl:6; Source/settings.tex:5 | `class.llncs` | no options |
| page layout | Source/sty/lncs/llncs.cls:55-56, 217-221 | `page.class-options` | set inside the class, no options passed: textwidth 12.2cm, textheight 19.3cm, side margins 63pt, headsep 16pt |
| headers/footers, page numbers | Source/sty/lncs/llncs.cls:1191-1212, 930 | `hf.class-native` | `runningheads` not given, so `\ps@empty`; first page `\thispagestyle{empty}` |
| front matter (title, authors, institutes) | Source/tpl/lncs/preamble.tpl:33-47, 51; llncs.cls:906-1021 | `front.class-native` | `\author{A\inst{1}\and B\inst{2}}`, `\institute{Name\\City, Country\and ...}`, `\title`, `\maketitle`; the author and institute lists are filled by Lua loops |
| abstract | Source/tpl/lncs/preamble.tpl:53-55; Source/abstract.tex:5-6; llncs.cls:1178-1186 | `abs.class-native` | `\begin{abstract}\input{abstract.tex}\end{abstract}`; the heading is `\abstractname`, "Abstract." (llncs.cls:80) |
| headings | Source/paper.tex:38, 49; llncs.cls:340-357 | `head.class-native` | `\section` and `\subsection` in `\@startsection`, large or normal bold, `secnumdepth` 2 (llncs.cls:227) |
| theorem-like statements | llncs.cls:1044-1157 (not used in the sample); Source/includes.tex:56 (commented `\newtheorem`) | `thm.class-native` | `\spnewtheorem` environments with caption and body fonts |
| figure with caption | Source/paper.tex:55-60 | `fig.graphicx` | `\centering`, `\includegraphics[width=0.4\textwidth]{square-circle}`, `\graphicspath{{fig/}}` (preamble.tpl:30) |
| caption format | Source/paper.tex:58; llncs.cls:789-802 | `cap.kernel` | class `\@makecaption`, label "Fig." (llncs.cls:93, 802), small text, centred when it fits |
| cross-reference | Source/paper.tex:59 | `xref.kernel` | `\label{fig:square-circle}`; `\fig{...}` at :62 is undefined (see Bespoke code) |
| float placement | Source/includes.tex:40-54 | `fig.placement` | `\topfraction` 0.9, `\bottomfraction` 0.8, `\textfraction` 0.07, `\floatpagefraction` 0.7, `\dbltopfraction` 0.9, `\dblfloatpagefraction` 0.7, counters topnumber 2, bottomnumber 2, totalnumber 4, dbltopnumber 2 |
| subfigures | Source/includes.tex:10 | `fig.subcaption` | `\usepackage{subfig}`, never called; the comment at includes.tex:7-9 names LIPICS, which the zip does not ship |
| citations | Source/paper.tex:42, 51; Source/tpl/lncs/preamble.tpl:18 | `bib.cite-pkg` | `\usepackage{cite}`; llncs also redefines `\@citex` for numbers (llncs.cls:696-715) |
| bibliography | Source/paper.tex:70; Source/tpl/lncs/midamble.tpl:6; llncs.cls:665-691 | `bib.bibtex-bst` | style `splncs04` (Source/sty/lncs/splncs04.bst, not read), `\bibliography{paper}` |
| input encoding and font encoding | Source/tpl/lncs/preamble.tpl:9, 14 | `font.fontenc-t1` | `[utf8]{inputenc}`, `[T1]{fontenc}` on the pdfLaTeX branch |
| font loading under LuaLaTeX | Source/tpl/lncs/preamble.tpl:10-13 | `font.fontspec` | `\usepackage{fontspec}`, no font selected; emitted only on the first (generator) pass |
| text font | Source/tpl/lncs/preamble.tpl:21-25; Source/settings.tex:131 | `font.lmodern` | default branch, `options.times` is commented out |
| text font, alternate | Source/tpl/lncs/preamble.tpl:22 | `font.newtx` | `newtxtext,newtxmath` when `options.times` is true |
| language | Source/tpl/lncs/preamble.tpl:16 | `lang.babel` | `[english]` (llncs also hooks babel for names, llncs.cls:882-888) |
| microtype | Source/tpl/lncs/preamble.tpl:20 | `sp.microtype` | `\usepackage{microtype}` |
| maths packages | Source/includes.tex:5 | `math.amsmath`, `math.amssymb` | `amsmath`, `amsfonts`, `amssymb` |
| colour | Source/includes.tex:20 | `color.xcolor` | `\usepackage{xcolor}` |
| review notes | Source/includes.tex:21 | `note.todonotes` | `\usepackage{todonotes}`, never called (the custom `\todo...` aliases are commented, includes.tex:22-27) |
| block comments | Source/tpl/lncs/preamble.tpl:19 | `draft.todo` | `\usepackage{comment}` (a draft aid, same family as `todonotes`; never called) |
| image placeholder | Source/includes.tex:32 | `box.fancybox` | `\framebox(200,200){IMAGE}` behind `\newcommand{\imagevide}`, never called |
| class-internal lists, footnotes, toc, index, tables, parts, chapters | llncs.cls:240-338, 478-527, 777-787, 807-820 | `class.llncs` | defined by the class, not used by the sample; no further ways needed |
| alt acmart: class | Source/tpl/acmart/preamble.tpl:6 | `class.acmart` | `acmsmall` |
| alt acmart: abstract, keywords | tpl/acmart/preamble.tpl:28-35 | `abs.class-native`, `abs.keywords` | `\keywords{...}` from the Lua variable `keywords` |
| alt acmart: CCS and acknowledgements | Source/acm-ccs.tex:10-26; Source/acm-bottom.tex:5-15 | `abs.classification` | `CCSXML` block, `\ccsdesc[500]{..}`; `acks` and `\grantsponsor` are class vocabulary (`class.acmart`) |
| alt acmart: column balance | tpl/acmart/preamble.tpl:13 | `cols.balance` | `\usepackage{flushend}`, the `balance` type of load-only switch (the lib line names `balance`, flushend is its sibling) |
| alt cas: class | Source/tpl/cas/preamble.tpl:6 | `class.cas-sc` | `a4paper,fleqn`; class loads `geometry` paperwidth=192mm paperheight=262mm (cas-sc.cls:172-180) |
| alt cas: citations | Source/tpl/cas/preamble.tpl:16 | `bib.natbib` | `[numbers]` |
| alt cas: front matter | Source/tpl/cas/preamble.tpl:58-100; midamble.tpl:7,10 | `front.class-native` | `\shorttitle`, `\author[n]{..}[orcid=..]`, `\cormark`, `\ead`, `\affiliation[n]{organization,city,country}`, `\title[mode=title]`, `highlights`, `keywords` with `\sep`, `\printcredits`, style `cas-model2-names` |
| alt ieeetran: class | Source/tpl/ieeetran/preamble.tpl:6 | `class.ieeetran` | `conference`; front matter by `\IEEEauthorblockN` and `\IEEEauthorblockA` (preamble.tpl:50-51, `front.class-native`) |
| alt ieeetran: fonts and links | Source/tpl/ieeetran/preamble.tpl:10, 17, 18, 62 | `font.fontenc-t1`, `font.helvet`, `meta.hyperref`, `font.newtx` | `[T1]`; `[scaled]{helvet}`; `[bookmarks=false]{hyperref}`; `newtxtext,newtxmath` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| Lua template compiler (`<% %>` and `<< >>` blocks turned into Lua source and run with `load` under a sandbox table) | Source/tex/template_engine4.lua:250-375 | no | computes text from code; no lib way. Blocker. |
| key-value parser and file writer for `gen/*.inc.tex` | Source/tex/papershell.lua:23-116 | no | `io.open`/`lfs.mkdir` file generation inside LuaTeX. Blocker. |
| `\papershellsetup`, `\papershellapply` | Source/tex/papershell.tex:3-15 | no | `\gdef\ps@kv` plus `\directlua` bridge. Blocker. |
| gate that stops the build until the generator has run | Source/paper.tex:19-26 | no | `\ifLuaTeX ... \IfFileExists{gen/preamble.inc.tex}{}{\errmessage{...}}`; part of the generator blocker. |
| earlier engine, not loaded | Source/tex/template.lua:1-79 | not applicable | unreferenced (papershell.lua:2 requires `template_engine4`). |
| engine branch for fonts | Source/tpl/lncs/preamble.tpl:10-15 | yes | emitter picks one branch: `font.fontenc-t1` for pdfLaTeX. |
| times or lmodern switch | Source/tpl/lncs/preamble.tpl:21-25 | yes | emitter picks `font.newtx` or `font.lmodern`. |
| author and institute loops | Source/tpl/lncs/preamble.tpl:33-42 | yes for fixed data | printed text is `\author{..\inst{n}\and ..}` and `\institute{..\and ..}` of `front.class-native`; the loop itself is the generator blocker. |
| `\nospellcheck` | Source/includes.tex:15 | yes | identity alias `\newcommand{\nospellcheck}[1]{#1}`; no printed effect. |
| `\imagevide` | Source/includes.tex:32 | yes | alias of a kernel `\framebox` in picture form; `box.fancybox`. |
| `\fig{undefined-figure}` | Source/paper.tex:62 | cannot tell | no definition anywhere in the zip (Grep over .tex .cls .sty .tpl .md finds only this use); with the neighbouring `\cite{somethingundefined}` (:51) it reads as a deliberate undefined-reference demo. Recorded, not counted as a blocker. |
| `\CASCopyFile`, `\setexternalabstract`, `\renewenvironment{abstract}{}{}` | Source/tpl/cas/preamble.tpl:25-50 | no | file read and write loop with `\pretocmd{\maketitle}`; alt publisher. Blocker. |
| `\def\floatpagepagefraction{1}`, `\def\textpagefraction{.001}` | Source/tpl/cas/preamble.tpl:54-55 | yes | raw parameter defs, `fig.placement`; the names are not LaTeX float parameters. |
| `\let\l@ENGLISH\l@english` | Source/tpl/ieeetran/preamble.tpl:82-84 | no | `\makeatletter` alias fix for a kernel/babel internal; no lib way. Blocker (alt publisher). |
| `texio.write_nl` debug print | Source/tpl/ieeetran/preamble.tpl:70-72 | not applicable | Lua log output, no printed effect. |
| `midamble.tpl` placeholders `{{ bibstyle }}` | Source/tpl/acmart/midamble.tpl:6-8; Source/tpl/ieeetran/midamble.tpl:6-8 | not applicable | the engine only matches `<` blocks (template_engine4.lua:320-351), so `{{ bibstyle }}` looks to be left verbatim; read only, not run. |
| stub class `foo` | Source/sty/foo/myclass.cls:1; Source/tpl/foo/preamble.tpl:1 | yes | empty class, `\begin{document}` only; adds nothing. |
| published class code (`\halign` symbols, `\@startsection`, `\@makecaption`, `\spnewtheorem`) | Source/sty/lncs/llncs.cls:340-357, 388-440, 789-799, 1044-1157 | not bespoke | published class, covered by `class.llncs`. |

## Content-opaque
- Included image `fig/square-circle.pdf` (Source/paper.tex:57); lorem-ipsum text and the unbreakable word run (Source/paper.tex:53); the `.bib` data (Source/paper.bib, Source/other.bib); the CCSXML block (Source/acm-ccs.tex:10-23).
- Not part of any template output and not read: `Tools/` (Lua, PHP and shell maintenance scripts, including `export.php` and the theme downloader `psmod.lua`) and `Test/`. Readme.md:261-266 lists PHP as optional, so none of them is a blocker on its own.
- `minted` appears only in two `\AtBeginEnvironment` hooks (Source/sty/acmart/acmart.cls:938-940), never as a package load, so no `EXTERNAL/package` blocker. The manifest hint `xelualatex,minted` is therefore not borne out.
- Considered and not tagged `EXTERNAL`: the generator runs inside LuaTeX (Readme.md:146-157), not in an outside tool. `Source/latexmkrc:5-9` sets `lualatex`, `TEXINPUTS` and `BSTINPUTS` for `sty//` only as a build driver.
- Settings the Lua parser reads but `tpl/lncs/*` never prints: `year`, `keywords`, author `email`, `orcid`, `corresponding` (Source/settings.tex:17-18, 35, 82, 89; no match in Source/tpl/lncs/).
- The 113-file zip holds no `gen/` folder, so the sample cannot be read as a stand-alone `.tex`. The generated preamble was reconstructed from `tpl/lncs/*.tpl` with the `settings.tex` values.

## Lib changes
- New ways proposed: none. `class.llncs`, `class.cas-sc` are class ways and need no proposal (the zip's llncs vocabulary is recorded above). Considered: `iftex` (the engine gate is reducible by choosing a branch, not a way), `comment` (kept under `draft.todo`), `flushend` (kept under `cols.balance`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
