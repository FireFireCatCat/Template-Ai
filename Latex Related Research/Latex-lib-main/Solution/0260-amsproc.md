yes

# 0260-amsproc: AMS document classes (amsart, amsproc, amsbook), amscls 2.20.6

- Unverified: read from the source, not compiled.
- Source: Source/0260-amsproc/ (origin: https://mirrors.ctan.org/macros/latex/required/amscls.zip; licence: LPPL 1.3c, README:5-7)
- Kind: conference (amsproc is the AMS proceedings-article class; the kit also ships amsart and amsbook templates, the amsthm manual and `.dtx` sources)
- Lib: v3
- Engine: pdfLaTeX-compatible (OT1 and Computer Modern, `amsfonts`; no fontspec, no Lua)
- Look carried by: class (`amsproc.cls` is generated from `amsclass.dtx` by `amsclass.ins:72-77`; the template preamble only declares theorems and one counter)
- Class origin: ctan (the zip is the CTAN `amscls` bundle, which is also the AMS's own kit; no `.cls` or `.sty` is shipped, only `.dtx` and `.ins` sources)
- Main file: doc/amsproc-template.tex (the manifest `main` column says doc/amsthdoc.tex, the amsthm manual; it is read in full and analysed below as a secondary sample. Other samples: doc/amsart-template.tex, doc/amsbook-template.tex, doc/thmtest.tex, the `\documentclass{amsdtx}` drivers in the five `.dtx` files)
- Read: main yes, zip-local classes and styles partly (read: amsclass.dtx 30-2445, 2448-2627 (code lines), 2628-2830, 2942-3070, 3290-3549, 3557-3790, 3946-4205, 4235-4262, 4468-4512, 4880-5217; amsdtx.dtx 34-363 plus a layout outline of the rest; amsbooka, amsmidx, upref code lines in full. Not read: amsclass.dtx 2830-2942 book chapters, 3070-3290 toc line macros, 3790-3945 misc and book variations, 4206-4234, 4262-4468 and 4512-4880 amsthm head and QED internals; the two `.bst` files only by header and field list)

## Verdict
yes. The main sample is `\documentclass{amsproc}` plus kernel and amsthm declarations (`\newtheorem`, `\theoremstyle`, `\numberwithin`) and the class's own front-matter commands, so the emitter writes one class line, a few theorem lines and the title-block commands, and copies no macro logic. The class internals (copyright insert, `\@makecaption`, `\@startsection` redefinitions, theorem engine) are published AMS class code (CTAN `amscls`), not zip-local bespoke code. The secondary samples (amsthdoc.tex, thmtest.tex) carry documentation-only helper macros; each reduces to lib ways below, and the one arguable item is the catcode meta-syntax at doc/amsthdoc.tex:80-86, used only inside verbatim blocks.

## Blockers
none

## Class setting
- Class: `class.amsproc` options: none in the sample (doc/amsproc-template.tex:37). Defaults `leqno,centertags,letterpaper,portrait,10pt,twoside,onecolumn,final` (amsclass.dtx:1019-1020). Other options the class declares: `a4paper` `landscape` `oneside` `draft` `titlepage` `twocolumn` `nomath` `noamsfonts` `psamsfonts` `reqno` `tbtags` `fleqn` `8pt` `9pt` `11pt` `12pt` (amsclass.dtx:237-273, 366-467, 750-797). The same file produces `class.amsart` and `class.amsbook`; doc/amsart-template.tex differs from the amsproc template only in the `\documentclass` line (checked by diff). Other classes in the zip: `class.amsdtx` and `class.amsldoc` (amsdtx.ins:73-74; `LoadClass{book}` at amsdtx.dtx:134), used only by the `.dtx` drivers; amsbooka (amsbooka.dtx:74) is an add-on package of `class.amsbook`.
- Class-native vocabulary used: `\title[short]{}` `\author[short]{}` `\address` `\curraddr` `\email` `\thanks` `\subjclass[edition]{}` `\keywords` `\date` `\dedicatory`, `abstract` environment before `\maketitle`, `\maketitle` (doc/amsproc-template.tex:54-83). Defined but not used by the sample: `\contrib` `\translator` `\urladdr` `\specialsection` `\appendix` `\markleft` `\upn` `\bysame` `\MR` `\URL` `\issueinfo` `\copyrightinfo` `\pagespan` (amsclass.dtx:1319, 1519, 1366, 2677, 2780, 4995, 2320, 3360, 3386, 3403, 1790, 1804, 1815). amsbook vocabulary: `\frontmatter` `\mainmatter` `\backmatter` (amsclass.dtx:2816-2820), `\makeindex` `\printindex`, `\bibliographystyle{amsalpha}` (doc/amsbook-template.tex:66,115,123,62,128,125). amsbooka vocabulary: chapter and part `\author`, `\barefootnote`, `inchapterbibliography`, options `rhchapnum` `rhchapsec` (amsbooka.dtx:199,207,457,547,564).

## Component map
Main sample doc/amsproc-template.tex with the class code it loads. "carried by class" means the sample sets nothing and the way is the class itself.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | doc/amsproc-template.tex:37 | `class.amsproc` | no options; loads amsmath and amsfonts (amsclass.dtx:1039,1084) |
| paper, type size | amsclass.dtx:237-239, 750-761, 1019 | `page.class-options` | letterpaper, 10pt, twoside; `a4paper` adds 4pc to textheight |
| text block | amsclass.dtx:650-655, 5106-5142 | `class.amsproc` | carried by class: textwidth 30pc, textheight 50.5pc minus head, margins centred by `\calclayout` |
| paragraph and penalties | amsclass.dtx:628-630, 698, 709 | `class.amsproc` | carried by class: parindent 18pt, parskip 0pt, widow, club, broken penalties 10000 |
| running heads | amsclass.dtx:830-842, 887-897, 5154 | `hf.class-native` | pagestyle `headings`: page number and short authors left, short title right, `\scriptsize`; first page style `firstpage` (logo only when `\publname` is defined, 1743-1747) |
| title | doc/amsproc-template.tex:54; amsclass.dtx:1266, 2058-2065 | `front.class-native` | `\Large\bfseries` centered, optional short title for the head |
| authors | doc/amsproc-template.tex:59,66; amsclass.dtx:1282, 2086-2109 | `front.class-native` | centered, 11/13pt, `\and` joined |
| addresses, emails | doc/amsproc-template.tex:60-62,67-69; amsclass.dtx:1363-1366, 1418, 1426-1482 | `front.class-native` | printed at the end of the document, `\footnotesize`, address in small caps, labels "Current address", "Email address" |
| `\thanks` | doc/amsproc-template.tex:63,70; amsclass.dtx:1381, 1721, 2126 | `front.thanks` | first-page footnote |
| dedication | doc/amsproc-template.tex:78; amsclass.dtx:1490, 1685-1691 | `front.class-native` | `\footnotesize\itshape` centered |
| date | doc/amsproc-template.tex:76; amsclass.dtx:1489, 1713 | `front.maketitle` | stored; only amsart prints it (the print line at 1713 is guarded `<amsart>`) |
| subject classification | doc/amsproc-template.tex:72; amsclass.dtx:1501-1509, 2029-2040, 2117-2118 | `abs.classification` | edition option 1991, 2000, 2010 or 2020; first-page footnote |
| keywords | doc/amsproc-template.tex:74; amsclass.dtx:1492, 2019, 2119-2120 | `abs.keywords` | footnote "Key words and phrases." |
| abstract | doc/amsproc-template.tex:80-81; amsclass.dtx:2145-2172 | `abs.class-native` | `\Small` list, margins 3pc, run-in small-caps head, set after the title block |
| headings | amsclass.dtx:2739-2775, 2677-2681 | `head.class-native` | section bold centered; subsection bold run-in indented; subsubsection italic run-in; paragraph run-in; `\specialsection` `\large\scshape` centered |
| numbering depth | amsclass.dtx:2646-2657, 2957 | `num.secnumdepth` | secnumdepth 3, tocdepth 1 (carried by class) |
| equation numbers by section | doc/amsproc-template.tex:50 | `num.counters` | `\numberwithin{equation}{section}` |
| equation number side | amsclass.dtx:437-455, 1019 | `math.eqnumber` | `leqno` (numbers on the left), `centertags` |
| math packages | amsclass.dtx:1039, 1084 | `math.amsmath`, `math.amssymb` | loaded by the class unless `nomath` or `noamsfonts` |
| theorem declarations | doc/amsproc-template.tex:39-48 | `thm.amsthm` | `\newtheorem{theorem}{Theorem}[section]`; `lemma` shares the `theorem` counter; styles `plain` (default), `definition` (definition, example, xca), `remark` (remark) |
| theorem look in amsproc | amsclass.dtx:4235-4262, 4473-4501, 4089-4093 | `thm.class-native` | head small caps and indented (4247-4248), period, note in upright medium, plain body italic, definition and remark body upright, space .5`\baselineskip` |
| proof, QED | amsclass.dtx:4896-4904, 4933-4944 | `thm.amsthm` | amsproc: indented small-caps head (4937-4939); `\qedsymbol` is `\textsquare` from msam (4908-4918), `\openbox` with `noamsfonts` (4915-4917) |
| lists | amsclass.dtx:2211-2228, 2273-2310 | `list.kernel` | labels (1) (a) (i) (A); bullet, bold dash; carried by class, not used by the template |
| quotes | amsclass.dtx:2233-2258 | `quote.kernel` | quote, quotation, verse; quotation left margin 3pc as the abstract |
| footnotes | amsclass.dtx:3496-3528 | `fn.kernel` | 5pc rule, `\footnotesize` |
| captions | amsclass.dtx:3648, 3726-3776 | `cap.kernel` | head small caps, wrap width columnwidth minus 6pc, 12pt above or below |
| float placement | amsclass.dtx:3557, 3586-3590, 3640-3641 | `fig.placement` | `tbp`, topnumber 4, topfraction .97 (carried by class) |
| contents | amsclass.dtx:2978-3021 | `toc.kernel` | centered small-caps head, tocdepth 1; `\tableofcontents` used in doc/amsbook-template.tex:110 |
| appendix | amsclass.dtx:2780-2783 | `num.appendix` | `\appendix`, Alph numbering (defined by the class; not in the amsproc template) |
| book matter (amsbook template) | doc/amsbook-template.tex:66,115,123,108; amsclass.dtx:2816-2820 | `pgnum.pagenumbering` | `\frontmatter` roman, `\mainmatter` arabic, `\setcounter{page}{4}` |
| bibliography (amsbook template) | doc/amsbook-template.tex:125-126; amsclass.dtx:3337-3353 | `bib.bibtex-bst` | style `amsalpha`; `amsalpha.bst` and `amsplain.bst` ship in the kit (header lines 1-31), thebibliography is class-defined |
| index (amsbook template) | doc/amsbook-template.tex:62,128; amsclass.dtx:3464-3484 | `idx.makeidx` | `\makeindex`, `\printindex`, two-column `theindex`; `amsmidx` (amsmidx.dtx:117-173) is a multiple-index package, the package is the parameter |
| cross-reference typography | upref.dtx:66, 97-144 | `NEW:xref.upref` | `\usepackage{upref}`: references print upright; defined in the kit, loaded by no sample |
| doc driver | amsclass.dtx:37-47; amsdtx.dtx:39-54, 1015 | `class.amsdtx`, `dtx.doc` | `\documentclass{amsdtx}`, `\DocInput{file.dtx}`; `doc` loaded by the class |

Secondary samples (read in full): doc/amsthdoc.tex (class `article`) and doc/thmtest.tex.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | doc/amsthdoc.tex:33; doc/thmtest.tex:44 | `class.article` | `11pt,twoside` |
| running head | doc/amsthdoc.tex:34,105 | `hf.pagestyle-kernel` | `\pagestyle{myheadings}`, `\markboth` |
| title block | doc/amsthdoc.tex:40-43,104 | `front.maketitle` | `\title` `\author` `\date{}` |
| text block | doc/amsthdoc.tex:91-94; doc/thmtest.tex:118 | `page.setlength` | textwidth 210mm minus 2in, side margins 39pt; thmtest adds 8pt to textwidth |
| list lengths, label | doc/amsthdoc.tex:50-52,751 | `sp.lengths`, `list.kernel` | `\leftmargini` 2em, `\leftmarginii` 1.5em, `\labelitemii`, `\itemsep` |
| toc depth, contents | doc/amsthdoc.tex:96,107-110 | `num.secnumdepth`, `toc.kernel`, `font.size-commands` | tocdepth 2, `\small` group |
| links | doc/amsthdoc.tex:98-99,387,412 | `meta.url`, `meta.hyperref`, `xref.hyperref` | `breaklinks`, `\href`, `\texorpdfstring` |
| tolerances | doc/amsthdoc.tex:88 | `sp.lengths` | `\hfuzz` 4pt; `\vbadness` `\hbadness` are integer TeX parameters, nearest way `sp.penalties` (they only gate warnings) |
| page flow | doc/amsthdoc.tex:114,324,501 | `pg.break`, `pg.enlarge` | `\newpage`; `\enlargethispage{1\baselineskip}` |
| code blocks | doc/amsthdoc.tex:177-179 and 22 more verbatim blocks | `code.verbatim` | `verbatim`, `\verb+..+` |
| example tabular | doc/amsthdoc.tex:459-468 | `tbl.tabular` | `{ll}` |
| fixed-width display line | doc/amsthdoc.tex:185-186 | `box.fancybox` | `\makebox[.8\columnwidth]{..}` in `\[ \]` (kernel box family) |
| bibliography | doc/amsthdoc.tex:828-849 | `bib.thebibliography` | four `\bibitem[label]` entries |
| theorem machinery | doc/thmtest.tex:48-105,187-204 | `thm.amsthm` | `[exercise]` option file, `\newtheoremstyle` x3, `\swapnumbers`, `proof[...]`, `\qedhere` |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| amsproc.cls internals (copyright `\insert`, `\@makecaption`, `\@startsection`, amsthm engine) | amsclass.dtx:1864-1945, 3726-3770, 2448-2625, 4057-4974 | not zip-local | published class code of `class.amsproc`; the emitter never copies it, it writes `\documentclass{amsproc}` |
| amsdtx class code, amsbooka, amsmidx, upref | amsdtx.dtx:119-1015; amsbooka.dtx:182-577; amsmidx.dtx:117-220; upref.dtx:72-154 | not zip-local | published in the same CTAN bundle; `class.amsdtx` + `dtx.doc`, `class.amsbook` vocabulary, `idx.makeidx`, `NEW:xref.upref`; none is loaded by the main sample |
| `exercise.thm` style (`\def\th@exercise`) | doc/thmtest.tex:36-41 | yes | `thm.amsthm`: `\newtheoremstyle{exercise}{}{}{\normalfont}{}{\bfseries}{:}{ }{}`, same effect (body upright, head punctuation `:`) |
| `\let\lvert=|`, `\Ric` | doc/thmtest.tex:114-115 | yes | `\newcommand` alias; `math.amsmath` supplies `\lvert` and `\rvert` |
| `\qq`, `\mdash` | doc/amsthdoc.tex:45-46 | yes | `\newcommand` aliases of kernel text symbols and `sp.penalties` (`\hyphenpenalty`) |
| `\ntt`, `\cn` `\cls` `\pkg` `\opt` `\env` `\fn`, `\bslchar` | doc/amsthdoc.tex:59-69 | yes | aliases that select the typewriter family: `font.nfss` (`\fontfamily\ttdefault\selectfont`) |
| `\latex/` | doc/amsthdoc.tex:89 | yes | alias of `\LaTeX` (`font.icons` family, TeX logos) |
| `\qedsymbol` box (`\hbox`, `\vrule`, `\hrule`) | doc/amsthdoc.tex:71-75 | yes | one fixed glyph, the same box as amsthm's `\openbox` (amsclass.dtx:4896-4904), which the `amsthm` package makes `\qedsymbol` (4920, `thm.amsthm`); primitives are `sp.rule` |
| `\ntnote` | doc/amsthdoc.tex:86 | yes | alias: superscript marker plus `\hangindent` (`sp.lengths`) |
| meta-syntax: `\catcode`\|=0`, `\gdef\?#1>`, `\def\<#1>` | doc/amsthdoc.tex:80-86 | yes (arguable) | the escape is used only inside verbatim blocks (286, 334-335, 509-517) to print an italic angle-bracket placeholder; `code.verbatim` with `fancyvrb` `commandchars` plus a `\newcommand` alias gives the same printed result |
| `\rp` (`\let\PBS\\\raggedright\let\\\PBS`) | amsdtx.dtx:41 | yes | `sp.ragged` |

## Content-opaque
none (the `\renewenvironment{proof}` fragment at doc/amsthdoc.tex:636-646 is verbatim text, i.e. code content)

## Lib changes
- New ways proposed:
  - `pg.enlarge` kernel `\enlargethispage{len}` and `\enlargethispage*{len}` (pdf). W1 kernel command; W2 one length argument; W3 serves any page that needs a few more or fewer lines; W4 one body line before the content of a page. No lib line covers it: `pg.break` is breaks, `page.setlength` sets the global text block, `pg.needspace` asks for room. Used at doc/amsthdoc.tex:324,501 (secondary sample).
  - `NEW:xref.upref` `upref` (AMS kit v2.04, CTAN `amscls`; pdf). W1 published; W2 load-only switch with no options (a hyperref-aware branch is internal, upref.dtx:97-144); W3 serves any italic-heavy math text; W4 one `\usepackage{upref}` line. Not `xref.kernel` (commands) or `xref.hyperref`. Defined in the zip, loaded by no sample.
- Considered: `mdframed` and `thmtools` (named in doc/amsthdoc.tex:752,755 as other packages, not used by any sample); `amsmidx` kept as a parameter of `idx.makeidx`, `amsbooka` as `class.amsbook` vocabulary.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
