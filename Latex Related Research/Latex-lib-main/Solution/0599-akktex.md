yes

# 0599-akktex: AkkTeX (classes akklecture, akkscript, akktecdoc and the akk* packages)

- Unverified: read from the source, not compiled.
- Source: Source/0599-akktex/ (origin: https://mirrors.ctan.org/macros/latex/contrib/akktex.zip; licence: LPPL, README:45-52)
- Kind: misc (a bundle of three classes: lecture notes, script/book, technical document; the manifest hint is misc and there is no sample to decide from)
- Lib: v5
- Engine: pdfLaTeX-compatible (three files are Latin-1, see Bespoke code)
- Look carried by: class (the three classes and the akktex packages they load are one CTAN release; there is no sample and no user preamble)
- Class origin: ctan
- Main file: none, the zip holds no .tex (other samples: none; `documentation/still to do` is an empty file)
- Read: main n/a (no sample; every .cls and .sty was read in full), zip-local classes and styles all

## Verdict
There is no sample, so the three classes and the 23 packages were analysed directly. The bundle is on CTAN and in TeX Live and MiKTeX (ctan.org/pkg/akktex: LPPL, version 0.3.2, read once), so each class is a published class way and none of its code is zip-local. Every look-defining construct also maps to a lib way or reduces to a composition of lib ways (Component map and Bespoke code), with no EXTERNAL tool and no artwork. Read as zip-local instead, no template look would rest on irreducible code either: the only token-level algorithms (source/akktex/base/akkcounterlabelpattern.sty:75-103, source/akktex/base/akkstring.sty:42-52) have no caller in the bundle. This is evidence about the class dimension, not the component ways. Weak points: the heading, list and parskip reductions assume literal lengths reproduce the class's parskip compensation (not verified), and several macros are latently broken (Bespoke code, last block).

## Blockers
none

## Class setting
- Class: `class.akklecture` options: `10pt` `11pt` `12pt` `draft` `final` go to article (source/akktex/classes/akklecture.cls:29-33); `widepage` `longpage` go to akktex (:35-36) but both are forced on (:46); unknown options are dropped (:38). `\LoadClass[a4paper]{article}` (:44).
- Class: `class.akkscript` options: `10pt` `11pt` `12pt` go to book (source/akktex/classes/akkscript.cls:27-29); `\LoadClass[a4paper]{book}` (:35); loads akktex with `longpage,widepage,twoside,intlimits` (:46).
- Class: `class.akktecdoc` options: `10pt` `11pt` `12pt` `draft` `final` go to article (source/akktex/classes/akktecdoc.cls:26-30); `widepage` `longpage` go to akktex (:32-33); `\LoadClass[a4paper]{article}` (:41); `\RequirePackage{akktex}` (:43).
- Class-native vocabulary used: no sample, so this is what the bundle defines. `\maketitle` and `\makedatetitle` (source/akktex/base/akkdoc.sty:18-26), `\subtitle` (source/akktex/classes/akkscript.cls:52-54), theorem-like environments `definition` `beispiel` `lemma` `korollar` `corollar` `theorem` `bemerkung` `proposition` `satz` (source/akktex/classes/akklecture.cls:91-101; source/akktex/classes/akkscript.cls:124-134), `proof` `Proof` `proof*` `beweis` `Beweis` `\prooflabel` `\proofend` (source/akktex/math/akkmathproof.sty:24-79), `axiomlist` `\axiom` (source/akktex/math/akkmathpaper.sty:29-70), `les` `eqsolving` (source/akktex/math/akkmathnum.sty:311-338), `\createcounterlabel` (source/akktex/base/akkcounterlabelpattern.sty:58), and the math shorthand commands.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | source/akktex/classes/akklecture.cls:44; source/akktex/classes/akkscript.cls:35; source/akktex/classes/akktecdoc.cls:41 | `class.akklecture`, `class.akkscript`, `class.akktecdoc` | options listed under Class setting |
| base class inside each class | source/akktex/classes/akklecture.cls:44; source/akktex/classes/akktecdoc.cls:41; source/akktex/classes/akkscript.cls:35 | `class.article` (akklecture, akktecdoc), `class.book` (akkscript) | a4paper |
| paper and type size | source/akktex/classes/akklecture.cls:29-31; source/akktex/classes/akkscript.cls:27-29 | `page.class-options` | a4paper fixed; 10pt, 11pt, 12pt |
| wide text block | source/akktex/layout/akkwidepage.sty:50-57,69-70 | `page.setlength` | one-sided: oddsidemargin and evensidemargin = original minus 4.25em; with option `twoside`: oddsidemargin minus 3.00em, evensidemargin minus 5.50em; textwidth = original plus 8.50em (comment: 3cm at 10pt) |
| margins restored inside the script title page | source/akktex/layout/akkwidepage.sty:59-67; source/akktex/classes/akkscript.cls:63,97 | `page.setlength` | oddsidemargin and evensidemargin set back to the original values for the title page, then to the wide values |
| tall text block | source/akktex/layout/akklongpage.sty:17-19 | `page.setlength` | voffset=-1in, topmargin=2cm, textheight=23cm |
| running head (lecture notes) | source/akktex/classes/akklecture.cls:47,52-60 | `hf.fancyhdr` | pagestyle fancy; headheight and headsep = `\baselineskip`; lhead=`\@title`, chead=`\thepage/\pageref{lastpage}`, rhead=`\@date`; lfoot, cfoot, rfoot empty; default head rule kept |
| page X/Y total | source/akktex/classes/akklecture.cls:24-26,56 | `xref.kernel` | `\label{lastpage}` at end of document, `\pageref{lastpage}` in the head (the `lastpage` package has the same effect but is not loaded) |
| head and foot in akkscript, akktecdoc | none set (the only `\pagestyle` in the bundle is source/akktex/classes/akklecture.cls:52) | `hf.pagestyle-kernel` | base-class default page style (book or article); nothing overrides it |
| paragraph skip and indent | source/akktex/layout/akkparskip.sty:159-160,198-199 | `sp.lengths` | parindent=0pt, parskip=0.71125\baselineskip plus 2pt (comment: 3mm at 10pt) |
| list spacing, all levels | source/akktex/layout/akkparskip.sty:21-69,79-108,190-209 | `sp.lengths` | per level: labelsep=original, labelwidth=leftmargin minus labelsep, rightmargin=0, listparindent=0, itemindent=0, topsep=original minus parskip, partopsep=parskip, parsep=parskip, itemsep=original minus parsep |
| original-value switch (abstract, title page) | source/akktex/layout/akkparskip.sty:113-122,147-156,170-188; source/akktex/classes/akktecdoc.cls:48-56 | `sp.lengths` | the article lengths are saved and set back inside the abstract, then the akk values are set again |
| section commands (`\section` to `\paragraph` redefined by the package the classes load; `\chapter` and `\part` stay with book) | source/akktex/layout/akkparskip.sty:223-239; source/akktex/layout/akksection.sty:22-123 | `head.class-native` | (reduction in Bespoke code, first row) section `\normalfont\Large\bfseries`, subsection `\large\bfseries`, subsubsection `\normalsize\bfseries`, paragraph `\normalfont\bfseries`; indent 0pt, block (not run-in); before = 3.5ex plus 1ex minus .2ex / 3.25ex plus 1ex minus .2ex (x2) / 2ex plus 1ex minus .2ex, each minus parskip; after = 2.3ex plus .2ex / 1.5ex plus .2ex (x2) / .3ex plus .2ex, each minus parskip |
| heading numbers and toc entry | source/akktex/layout/akksection.sty:41-76 | `num.secnumdepth`, `toc.kernel` | counters secnumdepth honoured; `\addcontentsline{toc}` with `\numberline` |
| title block, lecture notes | source/akktex/classes/akklecture.cls:20-22,70-80; source/akktex/base/akkdoc.sty:18-26 | `front.class-native` | `\maketitle` is called at begin document; one `large` bold line: title, fill, date; `\makedatetitle` is the second entry point |
| title block, script | source/akktex/classes/akkscript.cls:51-113 | `front.class-native`, `front.titlepage-env` | `titlepage` environment, `\vskip 60pt`, minipage of the original text width, centred Huge bold title, optional subtitle in `large`, Large bold author, date only for `\makedatetitle` |
| title block, technical document | source/akktex/classes/akktecdoc.cls:62-87 | `front.class-native` | centred Huge bold title, `\vspace{2.5ex}`, Large bold author, date only for `\makedatetitle`, `\vspace{2ex}` |
| title spacing and fill | source/akktex/classes/akklecture.cls:74-75; source/akktex/classes/akkscript.cls:61-62,73,79,93; source/akktex/classes/akktecdoc.cls:70,79,84 | `sp.manual-space` | `\hspace*\fill`, `\null\vfil`, `\vskip 60\p@`, `\vspace{2ex}` `{3ex}` `{2.5ex}`, strut `\makebox[0pt]{\phantom{Mg}}` |
| title type sizes and weights | source/akktex/classes/akkscript.cls:67-71,74-77,80-86; source/akktex/classes/akktecdoc.cls:65-77 | `font.size-commands`, `mark.kernel` | `\Huge` `\Large` `\large` with `\bfseries` |
| author block | source/akktex/classes/akkscript.cls:82-84; source/akktex/classes/akktecdoc.cls:73-75 | `tbl.tabular` | `tabular[t]{c}` holding `\@author` |
| title page box and notes | source/akktex/classes/akkscript.cls:57,65,58-60,99 | `box.minipage`, `front.thanks` | minipage width `\akk@orig@textwidth`; `\let\footnote\thanks`, `\footnoterule` off, `\@thanks` printed |
| abstract | source/akktex/classes/akktecdoc.cls:48-56; source/akktex/classes/akklecture.cls:65 | `abs.kernel` | article abstract run with the original paragraph and list lengths (akktecdoc); `\abstract` removed in akklecture |
| theorem-like statements, lecture notes | source/akktex/classes/akklecture.cls:88-101 | `thm.class-native` | package `theorem` (source/akktex/base/akktex.sty:39): `\theoremstyle{break}`, `\theorembodyfont{\rmfamily\upshape}`; `definition` has the counter, the other names count with it; `satz` body `\rmfamily\itshape`; names are German |
| theorem-like statements, script | source/akktex/classes/akkscript.cls:121-134 | `thm.class-native` | `\theoremstyle{changebreak}`, same body fonts, `definition` numbered within section, same shared counter |
| proofs | source/akktex/math/akkmathproof.sty:24-79,121-171 | `thm.class-native` | label string (set to Beweis), bold-italic label, end symbol `\Box` unless `\proofend` was used (boolean `proofended`), `equivproof` and `setequalproof` as itemize with arrow labels |
| axiom list | source/akktex/math/akkmathpaper.sty:29-70 | `list.kernel` | `list` with `\usecounter{axiom}`, label `\textbf{(<letter><n>)}`, labelwidth measured from `(<letter><start>)`, itemindent=0, listparindent=0 |
| custom reference text | source/akktex/math/akkmathpaper.sty:73-81 | `xref.kernel` | `\xlabel{key}{text}`: `\@currentlabel` set to the text, then `\label`; `\texttag` adds `\hfill` and the text |
| counter label patterns | source/akktex/base/akkcounterlabelpattern.sty:58-73; source/akktex/base/akknum.sty:16-21 | `num.counters` | `\createcounterlabel{counter}{name}{pattern}` writes `\the<counter>` and a label command; `\romannum` `\alphnum` wrap `\@roman` `\@alph` |
| maths packages | source/akktex/math/akkmath.sty:17,21,23-25; source/akktex/math/akkmathbasic.sty:17-19,35,37 | `math.amsmath`, `math.eqnumber`, `math.amssymb` | amsmath with `fleqn` and `intlimits` (from akkscript), amssymb, amstext, latexsym; `\allowdisplaybreaks[1]`; `\interintertext` |
| maths shorthand macros | source/akktex/math/akkmathset.sty:22-138; source/akktex/math/akkmathnum.sty:29-136; source/akktex/math/akkmathfun.sty:25-34; source/akktex/math/akkmathrel.sty:28-155; source/akktex/math/akkmathtext.sty:17-110; source/akktex/math/akkmathdisc.sty:21-22; source/akktex/cs/akkcs.sty:21-27 | `math.physics` | notation-shorthand package of the `physics` type; the package is the parameter; each command is an alias of amsmath or kernel maths and is content inside an equation |
| matrices and equation arrays | source/akktex/math/akkmathnum.sty:215-282,311-338; source/akktex/math/akkmathbasic.sty:43-45 | `math.amsmath`, `tbl.tabular` | `array` with `*{\value{MaxMatrixCols}}{c}` columns and `\newcolumntype` C L R (`>{\displaystyle}`); `smallmatrix`; `les` rows labelled by a counter and `\Romannum` |
| landscape pages | source/akktex/base/akktex.sty:37; source/akktex/classes/akkscript.cls:39 | `pg.landscape` | package `lscape`, no options |
| long tables | source/akktex/base/akktex.sty:38; source/akktex/classes/akkscript.cls:40 | `tbl.longtable` | package `longtable`, no options |
| float package | source/akktex/base/akktex.sty:40; source/akktex/classes/akkscript.cls:42 | `fig.float` | package `float`, no options |
| list label templates | source/akktex/base/akktex.sty:41; source/akktex/classes/akkscript.cls:43 | `list.enumerate-pkg` | package `enumerate`, no options |
| verbatim | source/akktex/base/akktex.sty:42; source/akktex/classes/akkscript.cls:44 | `code.verbatim` | package `verbatim`, no options |
| German support (standalone, no class loads it) | source/akktex/german/akkgerman.sty:18-20,26; source/akktex/german/akkgermanabbreviations.sty:20-43 | `font.fontenc-t1`, `lang.babel` | `inputenc` latin1, `fontenc` T1, `babel` ngerman; abbreviations are text aliases |

No component defines or sets: fonts (Computer Modern default), colour, background, bibliography, index, figures, captions, tables beyond the packages above, code listings, boxes, notes. No sample uses any of them.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\akk@startsection` clone of the kernel `\@startsection` | source/akktex/layout/akksection.sty:22-123 | yes | `head.titlesec`: `\titleformat` (block shape, the four styles) plus `\titlespacing*` with the before and after lengths of the component map; the clone only turns the run-in and indent tests into the explicit flags `false` (:236-239), so an after-skip that is negative once the parskip is subtracted is still a block heading (my estimate at 10pt with `\baselineskip` 12pt and 1ex 4.3pt: subsection, subsubsection and paragraph come out negative, section positive); kernel `\@startsection` would read a negative after-skip as run-in, so `head.kernel` does not reproduce it and `head.titlesec` is chosen; the `embedded` branch (source/akktex/layout/akksection.sty:49-60,100-116) is never selected; equal output with nonzero `\parskip` is not verified |
| parskip, list and section skips with saved original values | source/akktex/layout/akkparskip.sty:21-241 | yes | `sp.lengths` assignments for `\parskip` `\parindent` and the list lengths (`list.enumitem` `\setlist` would write the same keys); the switch is a group-local reassignment around the abstract |
| `\akk@maketitle` in three classes, `\maketitle` and `\makedatetitle` | source/akktex/classes/akklecture.cls:70-80; source/akktex/classes/akkscript.cls:56-113; source/akktex/classes/akktecdoc.cls:62-87; source/akktex/base/akkdoc.sty:18-26 | yes | hand-laid block of `front.titlepage-env` or `front.maketitle`, `sp.manual-space`, `font.size-commands`, `tbl.tabular`; the boolean `akk@datetitle` only picks between two entry points, so the emitter picks one |
| conditional aliases | source/akktex/base/akkconditional.sty:20-38 | yes | aliases of `ifthen` tests with no printed effect; used for the subtitle test (source/akktex/classes/akkscript.cls:72) and the date test (source/akktex/classes/akkscript.cls:87), both settled when the emitter writes the block |
| width and margin swap | source/akktex/layout/akkwidepage.sty:34-70 | yes | `page.setlength` values, written out |
| `\createcounterlabel` token parser | source/akktex/base/akkcounterlabelpattern.sty:58-138 | yes | no call in the zip; a call expands to `\renewcommand\the<counter>` plus `\newcommand` of the label (written in the file at :45-56): `num.counters` |
| string helpers `\firstchar` `\removefirstchar` `\extractnumber` `\centerln` `\ignore` | source/akktex/base/akkstring.sty:21-52 | yes | defined only; no class or package in the zip calls them (grep), so nothing printed depends on them; a use in a document would be evaluated by the emitter (content) |
| relation overrides `\in` `\leq` `\geq` `\neq` `\iff` `\implies` `\subset` `\=` with annotation | source/akktex/math/akkmathrel.sty:47-136 | yes | `\stackrel{\mbox{...}}{rel}` of amsmath with a `\settowidth` length for the aligned form; content inside equations |
| `\(` `\)` `\[` `\]` redefined as `\left(` `\right)` `\left[` `\right]` | source/akktex/math/akkmathbasic.sty:25-28 | yes | the emitter writes `\left(` etc. and uses `equation*` or `displaymath` for display maths, since `\[` no longer opens display maths |
| `proof` family with the `proofended` boolean | source/akktex/math/akkmathproof.sty:30-79 | yes | `thm.amsthm` proof environment with `\proofname` set to Beweis, a label argument for the bold-italic label and line break, `\qedsymbol` as `\Box`, and `\qedhere` for the early end symbol (equal output not verified) |
| `les` environment with counter-driven row labels | source/akktex/math/akkmathnum.sty:311-329 | yes | `tbl.tabular` (`array`) column decoration with `\stepcounter` and `\Romannum`, `num.counters` |
| `axiomlist`, `\axiom` | source/akktex/math/akkmathpaper.sty:29-70 | yes | `list.kernel` `list` environment (or `list.enumitem` `\newlist` with `label` and `start`) |
| about 300 shorthand `\newcommand` aliases and German text aliases | source/akktex/math/akkmathset.sty:22-138; source/akktex/math/akkmathnum.sty:29-282; source/akktex/math/akkmathtext.sty:17-110; source/akktex/german/akkgermanabbreviations.sty:20-43 | yes | inline expansion in the equation or text (aliases of `\mathbb`, `\operatorname`, `\left`, `\text`); `\renewcommand\S` and `\renewcommand\dh` (akkgermanabbreviations.sty:20,38) replace the section sign and the T1 eth glyph |

Read-only observations (not blockers, nothing was compiled):
- Latin-1 bytes (not valid UTF-8) at source/akktex/math/akkmathproof.sty:84-85, source/akktex/math/akkmathtext.sty:60-77, source/akktex/german/akkgermanabbreviations.sty:42; `inputenc` latin1 is loaded only by source/akktex/german/akkgerman.sty:18.
- Macros used but defined nowhere in the bundle: `\fns` (source/akktex/math/akkmathfun.sty:26-27) and `\folge` (source/akktex/math/akkmathnum.sty:172). Macros that need a package the classes do not load: `\infer` (source/akktex/math/akkmathproof.sty:174, a proof-tree package), `\glqq` `\grqq` (source/akktex/math/akkmathproof.sty:108-113, babel german, loaded only by source/akktex/german/akkgerman.sty:20), `\xspace` in source/akktex/math/akkmathtext.sty:108-110 (the xspace package is loaded only at source/akktex/german/akkgermanabbreviations.sty:17). `\annfont` sets an `\akk@annfont` that is never defined (source/akktex/math/akkmathrel.sty:71-73; the size is `\akk@annfontsize`, :75).
- `\ifset{akk@subtitle}` (source/akktex/classes/akkscript.cls:72) is written without the backslash, so it tests the literal text; the subtitle block would be set even when empty.
- `ifthen` and `calc` (source/akktex/base/akktex.sty:35-36) are infrastructure with no printed effect, so they are not components.

## Content-opaque
none (no sample, so no figure or table content; no TikZ, PGF or picture code in any file)

## Lib changes
- New ways proposed: none. Considered: the `theorem` package (tools bundle) as a theorem way; not proposed, because both class theorem layers are `thm.class-native` and the published class is the way. Considered: `xspace`, already rejected in lib v4 as a macro-body helper.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
