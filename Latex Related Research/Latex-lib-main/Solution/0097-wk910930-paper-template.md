no

# 0097-wk910930-paper-template: ML/vision conference template collection (ICML 2017, CVPR 2017, ECCV 2016, ICLR 2016/2017, NIPS 2017)

- Unverified: read from the source, not compiled.
- Source: Source/0097-wk910930-paper-template/ (origin: https://codeload.github.com/wk910930/paper-template/zip/refs/heads/master; licence: not established)
- Kind: conference
- Lib: v1
- Engine: pdfLaTeX-compatible
- Look carried by: zip-local (each venue's look is a hand-written `.sty` loaded on top of kernel `article`; ECCV uses CTAN `llncs` plus a zip-local `ruler.sty`)
- Class origin: zip-local
- Main file: ICML/icml_2017/example_paper.tex (other samples: CVPR/cvpr_2017/egpaper_final.tex, CVPR/cvpr_2017/egpaper_for_review.tex, ECCV/eccv_2016/eccv2016submission.tex, ICLR/iclr_2016/iclr2016_conference.tex, ICLR/iclr_2017/iclr2017_conference.tex, NIPS/nips_2017/nips_2017.tex)
- Read: main yes (all six samples; egpaper_for_review.tex by diff against egpaper_final.tex), zip-local classes and styles partly (read in full: icml2017.sty, nips_2017.sty, iclr2017_conference.sty (2016 is identical but for two year strings, by diff), cvpr.sty, cvpr_eso.sty, ruler.sty, eso-pic.sty, algorithm.sty, algorithmic.sty. Not read: llncs.cls beyond lines 1-60, 330-365, 785-830, 975-1012 (published); fancyhdr.sty and natbib.sty (published, byte-identical copies in three folders by md5); the five `.bst` files (headers only))

## Verdict
No. The zip is five independent venue kits, and four of them (ICML, CVPR, NIPS, ICLR) put their look in hand-written `.sty` files that are not on CTAN and that redefine kernel internals: `\@maketitle`/`\maketitle`, `\@makecaption`, `\@startsection`, plus counter-driven author/affiliation logic and a box-and-glue vertical ruler pasted on every page with `\AddToShipoutPicture`. The ruler and the title/author blocks have no lib way, so the answer is `no` even though headings, lists, captions, floats, tables, citations and the ECCV class (`llncs`) all map cleanly.

## Blockers
- `BESPOKE/class` ICML author, affiliation and notice machinery: `\icmlauthor`, `\icmlaffiliation`, `\icmlsetsymbol`, `\icmlcorrespondingauthor`, `\printAffiliationsAndNotice`; dynamically created counters numbered by first use, `forloop`, and `\ifdefined\isaccepted` branches decide what is printed (ICML/icml_2017/icml2017.sty:343-468)
- `BESPOKE/class` ICML running-title logic: `\icmltitle` measures the title in a `\vbox`, compares `\wd`/`\ht` with limits and falls back to "Title Suppressed Due to Excessive Size" (icml2017.sty:283-340)
- `BESPOKE/class` ICML vertical review ruler: `\makevruler`, `\fillzeros` loops over boxes and counters, placed by `\AddToShipoutPicture` and `\put` on every page unless `[accepted]` (icml2017.sty:664-723)
- `BESPOKE/class` CVPR vertical rulers plus corner paper-ID stamps and a "CONFIDENTIAL REVIEW COPY" banner, same box-and-glue code, drawn on every page unless `\cvprfinalcopy` (CVPR/cvpr_2017/cvpr.sty:159-219)
- `BESPOKE/class` CVPR `\@maketitle` with a `\ifcvprfinal` switch between the author block and "Anonymous CVPR submission / Paper ID" (cvpr.sty:86-110)
- `BESPOKE/class` ECCV `ruler.sty`: the same ruler algorithm and corner stamps, reading `\ECCV16SubNumber`, which the sample body defines (ECCV/eccv_2016/ruler.sty:17-76; eccv2016submission.tex:16)
- `BESPOKE/class` NIPS `\maketitle`/`\@maketitle` with 4pt and 1pt title bars, `\And`/`\AND` redefined into `tabular` pieces, a custom `noticebox` float (`\ftype@noticebox`, `\@float{noticebox}[b]`) and `\enlargethispage`; also `\patchAmsMathEnvironmentForLineno` wrappers (NIPS/nips_2017/nips_2017.sty:65-85, 244-321)
- `BESPOKE/class` ICLR `\maketitle`/`\@maketitle` with `\And`/`\AND`, `\ificlrfinal`, and `\lhead` set as a side effect of building the title (ICLR/iclr_2017/iclr2017_conference.sty:61-108; the 2016 file differs only in the year text at lines 88 and 95)

## Class setting
- Class: `class.article` for ICML, CVPR, ICLR, NIPS (no options for ICML/ICLR/NIPS; `10pt,twocolumn,letterpaper` for CVPR); `class.llncs` with option `runningheads` for ECCV. The conference look rides on zip-local styles loaded with `\usepackage`, which is why Class origin is recorded as zip-local; `article` itself is kernel and not bundled (source not read).
- Class-native vocabulary used: article: `\title` `\author` `\maketitle` `abstract` `\section`..`\subsubsection` `\paragraph` `\footnote` `\caption` `\bibliography`. llncs (eccv2016submission.tex:14-37): `\pagestyle{headings}`, `\mainmatter`, `\titlerunning`, `\authorrunning`, `\institute`, `\keywords` inside `abstract`.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class (ICML) | example_paper.tex:8 | `class.article` | no options; sizes redefined by the style |
| document class (CVPR) | egpaper_final.tex:1 | `class.article` | 10pt, twocolumn, letterpaper |
| document class (ECCV) | eccv2016submission.tex:4; llncs.cls:22-51 | `class.llncs` | runningheads; llncs loads article[twoside], multicol, aliascnt |
| paper size and class options | egpaper_final.tex:1 | `page.class-options` | letterpaper, 10pt |
| page geometry (ICML) | icml2017.sty:153-193 | `page.setlength` | paper 8.5x11in, textwidth 6.75in, textheight 9.0in, columnsep 0.25in, oddsidemargin=evensidemargin -0.23in, headheight=headsep 10pt, topmargin -20pt -0.29in, footskip 0pt (reducible to `page.geometry`) |
| page geometry (CVPR) | cvpr.sty:60-68 | `page.setlength` | textheight 8.875in, textwidth 6.875in, columnsep 0.3125in, topmargin/headheight/headsep 0, side margins -.304in, parindent 1pc |
| page geometry (ECCV) | eccv2016submission.tex:9 | `page.geometry` | width=122mm, height=193mm, left=12mm, top=12mm, paperwidth=146mm, paperheight=217mm |
| page geometry (NIPS) | nips_2017.sty:94-107 | `page.geometry` | letterpaper; `\newgeometry` textheight=9in, textwidth=5.5in, top=1in, headheight=12pt, headsep=25pt, footskip=30pt |
| page geometry (ICLR) | iclr2017_conference.sty:36-49 | `page.setlength` | 8.5x11in, oddsidemargin=evensidemargin .5in, topmargin -0.625in, headsep +0.25in, textheight 9in, textwidth 5.5in |
| two columns, full-width title block (ICML) | example_paper.tex:51-98; icml2017.sty:248 | `cols.twocolumn-option` | kernel `\twocolumn[...]` with the title in the optional argument |
| two columns (CVPR) | egpaper_final.tex:1 | `cols.twocolumn-option` | twocolumn |
| flush bottom, sloppy | icml2017.sty:248-249; nips_2017.sty:111-112; iclr2017_conference.sty:54 | `pg.flush`, `sp.hyphenat` | `\flushbottom`, `\sloppy` |
| widow/club penalties | nips_2017.sty:109-110; iclr2017_conference.sty:50-51 | `sp.penalties` | both 10000 |
| running head (ICML) | icml2017.sty:275-283 | `hf.fancyhdr` | `\fancyhf{}`, `\renewcommand{\headrulewidth}{1pt}`, `\chead{\small\bf running title}`; first page `\thispagestyle{empty}` (333) |
| running head (ICLR) | iclr2017_conference.sty:78-80, 88, 95 | `hf.fancyhdr` | `\fancyhead{}`, `\lhead{Under review as a conference paper at ICLR 2017}` or "Published as" when final |
| running head (ECCV) | eccv2016submission.tex:14 | `hf.class-native` | `\pagestyle{headings}` with `runningheads` |
| page numbering | egpaper_final.tex:24; egpaper_for_review.tex:23 | `pgnum.pagenumbering` | `\setcounter{page}{4321}`; review copy `\pagestyle{empty}` when final (`hf.pagestyle-kernel`) |
| body text paragraphs and lists | icml2017.sty:576-609; nips_2017.sty:205-242; iclr2017_conference.sty:137-174 | `sp.lengths` | parindent 0pt, parskip 6pt (ICML) / 5.5pt (NIPS) / .5pc (ICLR), topsep/partopsep/itemsep/parsep, leftmargin(i..vi), display skips (reducible: kernel list hooks set by lengths) |
| font sizes with tight leading | icml2017.sty:613-622; nips_2017.sty:115-137; iclr2017_conference.sty:179-188 | `font.size-commands` | normalsize 10/11pt, small 9/10, footnotesize 9/10, large 12/14, Large 14/16 (ICML via legacy `\@setsize`) |
| Times text font | example_paper.tex:11; egpaper_final.tex:4; iclr2017_conference.tex:2 | `font.mathptmx` | `times` |
| NIPS font families | nips_2017.sty:38-39 | `font.family-default` | `\rmdefault{ptm}`, `\sfdefault{phv}` |
| encodings (NIPS) | nips_2017.tex:15-16 | `font.fontenc-t1` | inputenc utf8, fontenc T1 |
| raw Helvetica/Times bold fonts (CVPR) | cvpr.sty:51-52 | `font.helvet` | `\font\cvprtenhv=phvb at 8pt`, `\font\elvbf=ptmb scaled 1100` (`\cvprtenhv` sets the ruler numbers and review banner at cvpr.sty:186, 215; `\elvbf` is the subsection font at 152) |
| microtype (NIPS) | nips_2017.tex:22 | `sp.microtype` | defaults |
| link colours | icml2017.sty:87-106 | `meta.hyperref` | colorlinks=true, link/cite/file/urlcolor=mydarkblue, pdfborder=0 0 0, pdfpagemode=UseNone, pdfview=FitH, pdfsubject, pdftitle/pdfauthor/pdfkeywords filled from `\icmltitle`/`\icmlauthor`/`\icmlkeywords` |
| link colour definition | icml2017.sty:71, 88 | `color.color` | `\definecolor{mydarkblue}{rgb}{0,0.08,0.45}` |
| hyperref in other samples | egpaper_final.tex:15; egpaper_for_review.tex:15 (by diff); iclr2017_conference.tex:3; nips_2017.tex:17 | `meta.hyperref`, `meta.url` | breaklinks=true, bookmarks=false; review copy pagebackref=true, colorlinks, letterpaper=true; `url` |
| title block (ICML) | example_paper.tex:51-53; icml2017.sty:338-340, 357-358 | `front.maketitle`, `sp.rule` | `\Large\bf` title centred, baselineskip 18pt between two `\hrule height1pt` bars with \vskip .25in/.22in/.3in (the bars and title reduce; the author logic does not, see blockers) |
| title block (CVPR, NIPS, ICLR) | cvpr.sty:86-110; nips_2017.sty:244-311; iclr2017_conference.sty:61-108 | `front.maketitle` | `\title` `\author` `\maketitle`; author `\and`/`\And`/`\AND` handled by the style (BESPOKE/class) |
| title block (ECCV) | eccv2016submission.tex:18-28 | `front.class-native` | `\title`, `\titlerunning`, `\authorrunning`, `\author`, `\institute` |
| author notes | iclr2017_conference.tex:10-12; nips_2017.tex:37-39 | `front.thanks` | `\thanks` |
| copyright/notice footnote (ICML) | icml2017.sty:448-467 | `fn.kernel` | `\let\thefootnote\relax\footnotetext{...}` (generation logic is BESPOKE/class) |
| abstract (ICML) | example_paper.tex:112-115; icml2017.sty:497-503 | `abs.kernel`, `quote.kernel` | `\centerline{\large\bf Abstract}`, `\vspace{-0.12in}`, `quote`, `\vskip 0.12in` |
| abstract (NIPS, ICLR, CVPR) | nips_2017.sty:324-336; iclr2017_conference.sty:110-111; cvpr.sty:112-123 | `abs.kernel`, `quote.kernel` | NIPS bold 12pt "Abstract" then quote; ICLR small caps; CVPR italic body with `\vspace*{12pt}` |
| abstract and keywords (ECCV) | eccv2016submission.tex:30-37 | `abs.class-native`, `abs.keywords` | `\keywords{...}` inside `abstract` |
| headings (ICML) | icml2017.sty:507-567 | `head.titlesec` | section `\large\bf\raggedright` skips -0.12in/0.02in; subsection `\normalsize\bf` -0.10in/0.01in; subsubsection `\normalsize\sc` -0.08in/0.01in; number run as "1. " (`\@sict`); paragraph run-in `\bf` (reduction of the redefined `\@startsection`/`\@sict`/`\@sect`) |
| headings (NIPS, ICLR, CVPR) | nips_2017.sty:141-178; iclr2017_conference.sty:114-128; cvpr.sty:145-155 | `head.kernel` | `\@startsection` calls: NIPS `\large\bf`, ICLR `\sc`, CVPR `\large\bf` and `\elvbf` with "\hskip -1em." |
| headings (ECCV) | llncs.cls:340-358 | `head.class-native` | llncs section/subsection/paragraph looks (source partly read) |
| section numbering and unnumbered sections | icml2017.sty:556-557; example_paper.tex:554 | `num.counters`, `num.secnumdepth` | `\thesection` arabic, `\thesubsection` 1.2, `\section*{Acknowledgements}` |
| footnote look | icml2017.sty:570-573; nips_2017.sty:200-203; iclr2017_conference.sty:132-135 | `fn.kernel`, `sp.rule` | footnotesep 6.65pt, `\skip\footins` 9pt, `\footnoterule` 0.8in (ICML) / 12pc (NIPS, ICLR) |
| float placement fractions | nips_2017.sty:181-184; iclr2017_conference.sty:25-26; cvpr.sty:225-233 | `fig.placement` | topfraction .85/.95/.99, bottomfraction, textfraction, floatpagefraction; CVPR totalnumber/topnumber 99 |
| figure float | example_paper.tex:394-406; nips_2017.tex:257-261; eccv2016submission.tex:321-332 | `fig.graphicx` | `figure[ht]`/`[h]`, `\centerline{\includegraphics[width=\columnwidth]{...}}`, `\vskip 0.2in`; CVPR/ICLR/NIPS use `\fbox{\rule...}` placeholders (content) |
| two-column figure | egpaper_final.tex:278-284 | `fig.graphicx` | `figure*` |
| subfigure package loaded | example_paper.tex:15 | `fig.subcaption` | `subfigure` (not used in the body) |
| captions | icml2017.sty:627-641; cvpr.sty:131-142; llncs.cls:789-798; nips_2017.sty:186-197 | `cap.caption` | single-line check then centred, else hanging or flush; label `\small\sl`, text `\footnotesize` (ICML), `\small` (CVPR, llncs bold label); `\abovecaptionskip` 7pt, `\belowcaptionskip` 0, swapped for tables (NIPS); reduction of the `\@makecaption` redefinitions |
| tables | example_paper.tex:469-498; nips_2017.tex:282-297; iclr2017_conference.tex:202-214; egpaper_final.tex:388-401; eccv2016submission.tex:258-280 | `tbl.tabular` | `lcccr`, `\hline`, `\noalign{\smallskip}`, `|l|c|` with `\hline\hline`, `\setlength{\tabcolsep}{4pt}` |
| table rules (NIPS) | nips_2017.tex:19, 282-297 | `tbl.booktabs` | `\toprule \cmidrule{1-2} \midrule \bottomrule`, `\multicolumn` |
| table struts and small caps | icml2017.sty:644-649; example_paper.tex:475-476 | `sp.rule`, `mark.kernel` | `\abovespace` = `\rule[0in]{0in}{0.20in}`, `\belowspace` = 0.10in; `small`, `sc` wrappers |
| algorithm float and pseudocode | example_paper.tex:21-22, 439-454; algorithm.sty:56-78; algorithmic.sty:85-187 | `alg.algorithmicx`, `fig.float` | `algorithm[tb]` (float package, `ruled` style), `algorithmic` with `\STATE \REPEAT \FOR \IF \UNTIL`; `\newcommand{\theHalgorithm}` alias (example_paper.tex:32) |
| bibliography (ICML) | example_paper.tex:18, 572-573; icml2017.sty:494, 135-136 | `bib.natbib`, `bib.bibtex-bst` | `\setcitestyle{authoryear,round,citesep={;},aysep={,},yysep={;}}`, `\cite`=`\citep`, `\yrcite`=`\citeyearpar`, style `icml2017` |
| bibliography (others) | iclr2017_conference.tex:267-268; egpaper_final.tex:440-441; eccv2016submission.tex:440-441; nips_2017.sty:90 | `bib.natbib`, `bib.bibtex-bst` | ICLR natbib + `iclr2017_conference.bst`; CVPR `ieee.bst`; ECCV `splncs.bst`; NIPS loads natbib unless `nonatbib` |
| cross-references | example_paper.tex:118, 161 | `xref.kernel` | `\label`, `\ref` |
| verbatim | example_paper.tex:198-202; eccv2016submission.tex:378-399 | `code.verbatim` | `verbatim`, `\verb`, wrapped in `\footnotesize` |
| mathematics | example_paper.tex:236, 243; eccv2016submission.tex:348-352; egpaper_final.tex:7-8; nips_2017.tex:20 | `math.kernel`, `math.amsmath`, `math.amssymb` | ECCV `align` and CVPR `amsmath`/`amssymb`; ICML uses inline kernel math only; NIPS `amsfonts` |
| inline fraction | nips_2017.tex:21, 73 | `math.nicefrac` | `\usepackage{nicefrac}`, `\nicefrac{1}{2}` |
| margin notes | iclr2017_conference.tex:38-39 | `note.marginpar` | `\marginpar{FIX}`, `\marginpar{NEW}` |
| review line numbers (NIPS) | nips_2017.sty:59-60 | `sp.draft-lineno` | `lineno`, `\linenumbers`, dropped with `[final]` |
| review overlay hook | icml2017.sty:75, 711-723; cvpr.sty:42, 195-219; ruler.sty:2, 53-76 | `bg.eso-pic` | `\AddToShipoutPicture`, `\AtTextUpperLeft` carry the overlay; its content is the ruler (BESPOKE/class) |
| centred text | example_paper.tex:123-125; iclr2017_conference.tex:185-188 | `sp.ragged` | `center` |
| manual spacing | example_paper.tex:395, 405, 473, 497 | `sp.manual-space` | `\vskip 0.2in`, `\vskip -0.2in`, `\vskip 0.15in`, `\vskip -0.1in` |
| page breaks | eccv2016submission.tex:426-438 | `pg.break` | `\clearpage` |
| inline emphasis | example_paper.tex:133-139 | `mark.kernel` | `\textbf`, `{\em ...}`, `\textit` |
| boxes (placeholders) | egpaper_final.tex:236; iclr2017_conference.tex:187 | `box.fancybox` | `\fbox{\rule{0pt}{2in}\rule{0.9\linewidth}{0pt}}` (content of a figure) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\icmlauthor` family, affiliation counters, `\printAffiliationsAndNotice` | icml2017.sty:343-468 | No | Hand-rolled counters, `\csname`-built names and `\forloop` decide printed text; `authblk` cannot number by order of first use |
| `\icmltitle`/`\icmltitlerunning` width and height check | icml2017.sty:283-340 | No | The `\chead` and the two 1pt rules reduce (`hf.fancyhdr`, `sp.rule`), the measure-and-fallback branch does not |
| `\@startsection`/`\@sict`/`\@sect`, `\section`..`\subparagraph` | icml2017.sty:507-567 | Yes | `head.titlesec`: `\titleformat` with the fonts and `\titlespacing` skips listed in the map |
| `\@makecaption`, `\fnum@figure`, `\fnum@table` | icml2017.sty:627-641; cvpr.sty:131-142 | Yes | `cap.caption` singlelinecheck with `font=small`/`footnotesize`, labelsep period |
| `\@setsize` size macros | icml2017.sty:613-622; iclr2017_conference.sty:179-188 | Yes | `font.size-commands` |
| list, spacing, footnote, display-skip settings | icml2017.sty:569-609 | Yes | `sp.lengths`, `fn.kernel`, `sp.rule` |
| `abstract` redefinition | icml2017.sty:497-503 | Yes | `abs.kernel` + `quote.kernel` with the skips listed |
| `\abovespace`, `\belowspace`, `\aroundspace` | icml2017.sty:644-649 | Yes | `sp.rule` struts |
| `\texitem`, `\icmlitem`, `\comment`, `\icmladdress` | icml2017.sty:473-475, 651-657 | Yes (unused) | Aliases and a null macro; not called by the sample |
| `\@copyrightspace` copyright float | icml2017.sty:218-241 | Not needed | Defined, never called (call commented out at line 500) |
| `\addcontentsline` nulled | icml2017.sty:252; iclr2017_conference.sty:58 | Yes | Emit no contents page |
| vertical ruler `\makevruler`, `\fillzeros`, page stamps | icml2017.sty:664-723; cvpr.sty:159-219; ruler.sty:17-76 | No | Box-and-glue loop over counters placed with `\put`; `sp.draft-lineno` gives a different ruler, not this one |
| CVPR `\@maketitle`, `\abstract`/`\endabstract`, `\onedot` family | cvpr.sty:86-123, 238-246 | Title: No (the `\ifcvprfinal` author/ID switch); abstract and abbreviations: Yes | Abstract = `abs.kernel` italic; `\eg \ie \etal` are text aliases (`\emph{e.g.}` etc.), content not template |
| NIPS `\@maketitle`, `\And`/`\AND`, `noticebox` float, lineno-amsmath patches | nips_2017.sty:65-85, 244-321 | No | Custom float and author-block layout; no lib way |
| ICLR `\maketitle`/`\@maketitle`, `\And`/`\AND` | iclr2017_conference.sty:61-108 | No | Title block plus side-effecting `\lhead` |
| eso-pic.sty copy patched to `\input{cvpr_eso.sty}` | CVPR/cvpr_2017/eso-pic.sty:24; cvpr_eso.sty:37-107 | Yes | Published `eso-pic` v1.1b with `everyshi` v3.00 inlined; `bg.eso-pic` |
| algorithmic.sty edited by A. Smola (extra `\INPUT`, `\FUNCTION`, `\MAIN`) | ICML/icml_2017/algorithmic.sty:46-58, 113-123 | Yes | Additive; the sample calls only the original commands; `alg.algorithmicx` |
| `.bst` files `icml2017`, `iclr2016/7_conference`, `ieee`, `splncs` | listed under ICML, ICLR, CVPR, ECCV | Yes (as a parameter) | `bib.bibtex-bst` takes the style as a parameter; headers read only (`plainnl` derivatives; `ieee` from `latex8`) |
| `\newcommand{\fix}`, `\new` | iclr2017_conference.tex:38-39 | Yes | `note.marginpar` aliases |
| `\def\ECCV16SubNumber{***}`, `\def\cvprPaperID{****}` | eccv2016submission.tex:16; egpaper_final.tex:19 | Yes | Plain macro holding a number; consumed by the ruler/stamps (BESPOKE/class) |

## Content-opaque
none (figure artwork in the samples is `\fbox{\rule...}` placeholders and shipped `icml_numpapers`/`eijkel2` images, all content)

## Lib changes
- New ways proposed: `math.nicefrac` `nicefrac` package (CTAN), `\nicefrac{1}{2}` inline slash fractions, pdf. W1 published on CTAN; W2 behaviour is the command arguments and an optional font argument, no code to edit; W3 serves inline fractions in any document; W4 printable as one package line plus a command wrapper. Grep of `_Lib.md` for `nicefrac`/`xfrac`/`frac` found no home (`math.amsmath` has `\tfrac` only).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
