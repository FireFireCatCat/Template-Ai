no

# 0031-nhatkhangcs-overleaf-comments: sidecomments (side-margin review comments with arrows) and four venue demos

- Unverified: read from the source, not compiled.
- Source: Source/0031-nhatkhangcs-overleaf-comments/ (origin: https://codeload.github.com/nhatkhangcs/overleaf_comments/zip/refs/heads/main; licence: MIT)
- Kind: conference (a package plus four AAAI/ACL/CVPR/ICLR demo papers; the manifest hint `presentation` is wrong)
- Lib: v1
- Engine: pdfLaTeX-compatible (aaai2027.sty:58-59 `\RequirePDFTeX`; sidecomments.sty:243-245 also handles LuaTeX; README.md:18 says pdfLaTeX, XeLaTeX, LuaLaTeX)
- Look carried by: zip-local (the comment overlay is sidecomments.sty; each venue layout is a zip-local `.sty`; every sample preamble is a thin list of `\usepackage`)
- Class origin: tex-distribution-unbundled
- Main file: examples/aaai/main.tex (other samples: examples/arr/main.tex, examples/cvpr/main.tex, examples/iclr/main.tex)
- Read: main yes, zip-local classes and styles partly. Read in full: sidecomments.sty, aaai2027.sty, acl.sty, cvpr.sty, iclr2027_conference.sty, cvpr/preamble.tex, all four main.tex. Not read in full: iclr/natbib.sty and iclr/fancyhdr.sty (CTAN copies, headers and a grep only), the four `.bst` files (heads only), iclr/math_commands.tex (head, outline, tail).

## Verdict
No. The zip's whole point is `sidecomments.sty`, an expl3 package that widens the page at `\begin{document}`, records target positions with `zref-savepos`, and at every shipout sorts, stacks and pushes comment boxes apart by two passes, then draws boxes, arrows, highlights, frames and carets with TikZ (sidecomments.sty:285-624). That is a layout algorithm plus template-defining artwork, it is not on CTAN (ctan.org/pkg/sidecomments returned 404, so it fails W1), and the main sample loads it unconditionally (examples/aaai/main.tex:24). The AAAI style also replaces `\@makecol` with extra insert registers and rebuilds `\maketitle` (aaai2027.sty:98-206, 250-287). Everything else in the main sample (fonts, geometry, headings, lists, tables, bibliography) maps to lib ways.

## Blockers
- `BESPOKE/package` sidecomments layout engine: shipout hooks, `\seq_sort`, forward and backward push passes, side and column choice, indent extents (sidecomments.sty:288-339, 351-529)
- `BESPOKE/package` reviewer-command generator and per-comment property store (`\screviewer` defines `\XY` `\XYnote` `\XYbox`; `\prop_gput` per comment id) (sidecomments.sty:80-100, 149-202)
- `ART/package` TikZ overlay that is the package's identity: comment box node, Stealth-tipped bezier arrow, highlight rectangle, dashed frame, insertion caret (sidecomments.sty:576-624)
- `BESPOKE/class` AAAI custom output routine: `\newinsert\aaai@thanksins`, `\newinsert\aaai@copyrightins`, patched `\@makecol` (aaai2027.sty:250-287), with `\@footnotetext` redirected inside `\maketitle` (aaai2027.sty:105-114)
- `BESPOKE/class` AAAI `\maketitle` and `\@maketitle`: `\twocolumn[\@maketitle]`, a measured `\sbox` compared with `\titlebox` and grown by `\ifdim` (aaai2027.sty:98-127, 130-206)
- `BESPOKE/class` AAAI `\equalcontrib` and `\corresponding`, hand-rolled counters and conditionals that drive what is printed (aaai2027.sty:132-155, 179-194)
- `BESPOKE/class` (other samples) ACL zero-fill line-number counter loop and `etoolbox` patches of amsmath environments (acl.sty:46-54, 66-95); CVPR copy of the same (cvpr.sty:368-374, 395-426); ICLR `\makevruler` box loop (iclr2027_conference.sty:206-224)
- `ART/class` (other samples) CVPR paper-ID corners and "CONFIDENTIAL REVIEW COPY" banner drawn through `\AddToShipoutPicture` and `picture` (cvpr.sty:430-442); ICLR grey ruler overlay (iclr2027_conference.sty:230-240)

Not blockers: `Makefile:8-18` and `examples/*/latexmkrc:1-3` only drive `latexmk` and `zip`; they generate no `.tex`, so no `EXTERNAL`. Two compile passes are needed for the arrows (README.md:52).

## Class setting
- Class: `class.article` options: `letterpaper` (examples/aaai/main.tex:2). Other samples: `11pt` (arr/main.tex:2); `10pt,twocolumn,letterpaper` (cvpr/main.tex:2); none (iclr/main.tex:2).
- Class-native vocabulary used: `\title` `\author` `\maketitle` `abstract` `\section` `figure` `table` `equation` `\bibliography` (all kernel article). The venue style adds `\affiliations{}` (main.tex:30; aaai2027.sty:128), option `submission` (main.tex:3; aaai2027.sty:35-39), `\nocopyright` (aaai2027.sty:27). No class source needs reading: article is the stock kernel class and is not bundled.

## Component map
Rows are for the main sample, examples/aaai/main.tex, unless a file is named. "R" means reducible bespoke code, "B" means blocker (see Bespoke code).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | aaai/main.tex:2 | `class.article` | letterpaper |
| paper size | aaai/main.tex:2 | `page.class-options` | letterpaper |
| page geometry | aaai2027.sty:79-82 | `page.setlength` | topmargin=-0.25in, oddsidemargin=-0.25in, textheight=9.0in, textwidth=7.0in, columnsep=0.375in, headheight=0pt, headsep=0pt, titlebox=2.25in (R) |
| PDF page size | aaai2027.sty:88-89; main.tex:14-15 | `page.setlength` | pdfpagewidth=8.5in, pdfpageheight=11in |
| columns | aaai2027.sty:85 | `cols.twocolumn-option` | kernel `\twocolumn` issued by the style, not a class option |
| header/footer | aaai2027.sty:84 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` `\pagestyle{empty}` |
| page fill | aaai2027.sty:85 | `pg.flush` | `\flushbottom` |
| hyphenation | aaai2027.sty:85 | `sp.hyphenat` | `\sloppy` |
| float barrier | aaai2027.sty:75, 343-344 | `pg.afterpage` | placeins `\FloatBarrier` before `\bibliography` (R) |
| font encoding | aaai2027.sty:64 | `font.fontenc-t1` | T1 |
| serif text | aaai2027.sty:69; main.tex:4 | `font.newtx` (style); `font.mathptmx` (main loads `times`) | newtxtext; times. The style forbids `times` (aaai2027.sty:65-68) and the sample loads it anyway |
| sans, mono | aaai2027.sty:71, 73; main.tex:5-6 | `font.helvet`, `font.mono` | helvet; courier |
| font sizes | aaai2027.sty:321-330 | `font.size-commands` | `\@setfontsize` table: normalsize 10/11, small 9/10, large 11/12, Large 12/14, LARGE 14/16 ... (R) |
| colour | aaai2027.sty:333 | `color.xcolor` | load only |
| sentence spacing | main.tex:13 | `sp.frenchspacing` | `\frenchspacing` |
| URL typesetting | main.tex:7, 9-10 | `meta.url` | hyphens; `\urlstyle{rm}`; `\def\UrlFont{\rm}` |
| title block | aaai2027.sty:98-127, 130-206 | `front.class-native` | `\title`, `\author`, `\affiliations{}`; LARGE bold centred title, Large bold authors, titlebox height (B) |
| title footnote marks | aaai2027.sty:139-155, 179-194 | `front.class-native` | `\equalcontrib`, `\corresponding` (B; not used by the sample) |
| copyright slug | aaai2027.sty:25-31, 36, 118 | `front.class-native` | footnotesize text inserted at the first column foot via custom insert (B) |
| abstract | aaai2027.sty:208-218 | `abs.class-native` | centred bold "Abstract", 0.5ex gap, `quote` with leftmargini=10pt, `\small`, 1ex after (R: `abs.kernel`+`quote.kernel`+`font.size-commands`) |
| headings | aaai2027.sty:230-233 | `head.kernel` | `\@startsection` args: section beforeskip -2.0ex plus -0.5ex minus -.2ex, afterskip 3pt plus 2pt minus 1pt, `\Large\bf\centering`; subsection `\large\bf\raggedright`; paragraph run-in (R) |
| heading numbering | aaai2027.sty:234; main.tex:18 | `num.secnumdepth` | style sets 0, sample resets to 2 |
| lists | aaai2027.sty:290-314 | `list.kernel`, `sp.lengths` | parindent=10pt, leftmargini=13pt, topsep, itemsep, parsep, `\@listi` to `\@listvi` redefinitions (R: `list.enumitem` setlist values) |
| display skips | aaai2027.sty:315-318 | `sp.lengths` | abovedisplayskip=7pt plus2pt minus5pt and three more |
| footnote look | aaai2027.sty:237-239 | `fn.kernel`, `sp.lengths` | footnotesep=6.65pt, skip\footins=9pt plus 4pt minus 2pt, rule width 5pc (R) |
| footnote assembly | aaai2027.sty:250-287 | none | custom inserts and `\@makecol` (B) |
| maths | main.tex:16, 63-65 | `math.amsmath` | `equation` env, `\operatorname`, `\left\right` |
| figure | main.tex:70-75 | `fig.graphicx` | `[t]`, `\centering`, width=0.85\linewidth |
| table | main.tex:17, 82-95 | `tbl.tabular`, `tbl.booktabs` | `lccc`, `\toprule` `\midrule` `\bottomrule` |
| captions | main.tex:12, 73, 93 | `cap.kernel`, `cap.caption` | `caption` loaded with no options |
| cross-references | main.tex:74, 78 | `xref.kernel` | `\label` `\ref` |
| citations | main.tex:11; aaai2027.sty:347-355 | `bib.natbib` | `\cite` as `\citep`, `\setcitestyle{aysep={}}`, bibhang=0pt |
| bibliography | main.tex:108; aaai2027.sty:354 | `bib.bibtex-bst` | `aaai2027.bst`, database `refs` |
| text marks | main.tex:38, 101 | `mark.kernel` | `\textsc` `\emph` `\textbf` `\texttt` |
| review comments | main.tex:24-26, 36-106 | none | `\usepackage{sidecomments}`, `\screviewer{KV}{Khang}{blue}`, `\KV` `\KVnote` `\KVbox` `\sccomment` `\scnote` (B) |
| page widening | sidecomments.sty:236-247 | `page.setlength` | paperwidth + 2*5.5cm, hoffset + 5.5cm, global pdfpagewidth (R alone; B with the rest) |
| comment positions | sidecomments.sty:213-228 | `xref.zref` | zref-savepos, zref-abspage; `\zsavepos` pairs |
| comment overlay | sidecomments.sty:288-290 | `bg.eso-pic` | nearest way for a per-page overlay; kernel `shipout/background` and `shipout/foreground` hooks play its role (ART) |
| comment drawing | sidecomments.sty:210-212, 576-624 | `art.tikz` | tikz, arrows.meta (ART) |
| comment box colour | sidecomments.sty:210, 584-589 | `color.xcolor` | draw=c, fill=c!6, text c!75!black, highlight c!22 |
| comment options | sidecomments.sty:35-57 | none | final/hide/draft, width=5.5cm, pad=0.3cm, gap=4pt, sides=both, font=`\footnotesize\sffamily` |
| ARR style (arr) | acl.sty:103-104, 112 | `page.geometry`, `cols.twocolumn-option` | a4paper, margin=2.5cm, heightrounded=true; `\twocolumn` |
| ARR line numbers | acl.sty:35-95 | `sp.draft-lineno` | lineno [switch,mathlines], `\linenumberfont` phvb 8pt lightgray, linenumbersep=1.6cm (the counter code is B) |
| ARR links, captions, cites | acl.sty:182-195, 300-305 | `meta.hyperref`, `cap.caption`, `bib.natbib` | colorlinks darkblue; `\DeclareCaptionFont` 10pt; natbib with `\cite` as `\citep` |
| ARR front matter | acl.sty:139-178, 201-214, 233-244 | `front.class-native`, `abs.class-native`, `head.kernel`, `bib.bibtex-bst` | `\maketitle` rebuilt (R for the look), list-based abstract, `\thebibliography` redefined, `acl_natbib.bst` |
| ARR main preamble | arr/main.tex:4-12 | `font.mathptmx`, `font.fontenc-t1`, `sp.microtype`, `font.mono` | times, latexsym, T1, utf8, microtype, inconsolata |
| CVPR style (cvpr) | cvpr.sty:30-49, 232-240 | `font.mathptmx`, `bib.natbib`, `cap.caption`, `fig.subcaption`, `page.setlength` | times; natbib numbers,sort&compress; caption format=plain labelsep=period font=small; subcaption; text 6.875in x 8.875in |
| CVPR extras | cvpr.sty:496-508; cvpr/preamble.tex:8-18 | `xref.cleveref`, `list.enumitem`, `cols.cuted`, `cap.caption` | cleveref capitalize; enumitem shortlabels noitemsep; cuted, currfile |
| CVPR links | cvpr/main.tex:8 | `meta.hyperref` | pagebackref, breaklinks, colorlinks, allcolors=cvprblue |
| CVPR page overlay | cvpr.sty:75-212, 430-442 | `bg.eso-pic` (inlined copy), ART | paper-ID corners and banner (ART/class) |
| ICLR style (iclr) | iclr2027_conference.sty:18-23, 36-54, 78-80 | `bg.eso-pic`, `hf.fancyhdr`, `bib.natbib`, `page.setlength`, `sp.penalties` | fancyhead lhead "Under review..."; setcitestyle authoryear,round; text 5.5in x 9in; widowpenalty=clubpenalty=10000 |
| ICLR headings | iclr2027_conference.sty:108-122 | `head.kernel` | `\large\sc\raggedright` etc. (R) |
| ICLR maths macros | iclr/math_commands.tex:3-508 | `math.amsmath`, `math.bm`, `math.amssymb` | amsmath, amsfonts, bm; `\newcommand`/`\def` aliases and `\DeclareMathOperator` (R) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| sidecomments layout engine | sidecomments.sty:285-529 | no | Computes layout: per-page prepare at shipout, left and right sequences sorted by target y, forward pass to push boxes down, backward pass to keep them on the page, column and indent logic for two-column pages. No lib way. Nearest published way is `todonotes` (`note.todonotes`), which does not widen the sheet, has no highlight, frame or caret, and has its own placement; the look differs. |
| `\screviewer` generator and prop store | sidecomments.sty:80-100, 149-202 | no | Defines commands on the fly from a name, a label and a colour; part of the engine. |
| TikZ comment drawing | sidecomments.sty:576-624 | no (ART) | Arrow control points come from the positions the engine computes; no declarative lib way. |
| `final` switch | sidecomments.sty:138-146, 204 | no | A boolean that ends the package early and turns each command into its argument; behaviour sits in the engine. |
| page widening | sidecomments.sty:236-247 | yes alone | `page.setlength` values; only meaningful with the engine. |
| aaai `\@makecol` patch and inserts | aaai2027.sty:250-287 | no | Custom output routine. |
| aaai `\maketitle`, `\@maketitle`, `\equalcontrib` | aaai2027.sty:98-206 | no | Measured box, `\ifdim`, counters, redirected `\@footnotetext`. |
| aaai headings, lists, sizes, abstract, footnote look | aaai2027.sty:208-218, 230-240, 290-330 | yes | Values for `head.kernel` (`\@startsection` arguments), `sp.lengths`, `font.size-commands`, `abs.kernel` + `quote.kernel`. |
| aaai package guards | aaai2027.sty:336-424 | yes | `\PackageError` for hyperref, geometry, titlesec, setspace, ulem, wrapfig, balance, authblk and others: no output effect. An emitter for this style must not emit those packages. |
| aaai bibliography hooks | aaai2027.sty:343-344, 430 | yes | `pg.afterpage` (placeins) before the bibliography; the `\endlist` alias only silences a warning. |
| aaai `links` environment | aaai2027.sty:219-227 | yes | flushleft, hangindent=10pt, parskip=2pt, `\url`; unused. |
| acl `\fillzeros`, lineno patches | acl.sty:46-54, 61-95 | no | Hand-rolled counter loop, `\pretocmd`/`\apptocmd` patches of amsmath. |
| acl front matter, sections, bibliography | acl.sty:139-244 | yes | `front.class-native` values, `head.kernel`, redefined `thebibliography` as `bib.thebibliography`-like list parameters. |
| cvpr inlined everyshi and eso-pic | cvpr.sty:75-212 | yes | `bg.eso-pic`. |
| cvpr `\fillzeros` and ruler counters | cvpr.sty:361-375 | no | Same loop as acl. |
| cvpr banner overlay | cvpr.sty:430-442 | no (ART) | `picture` in shipout; paper ID and confidentiality text. |
| cvpr `\onedot` macros | cvpr.sty:461-472 | yes | `\futurelet` plus `\xspace` text aliases (`\eg`, `\ie`, `\etal`): content shorthand. |
| iclr `\makevruler` | iclr2027_conference.sty:206-224, 229-240 | no (ART) | `\loop` over boxes under `\AddToShipoutPicture`. |
| iclr maths macros | iclr/math_commands.tex:3-508 | yes | `\newcommand` and `\def` aliases, `\DeclareMathOperator` (`math.amsmath`). |
| sample macros | cvpr/preamble.tex:26-28 | yes | `\red`, `\todo`, `\TODO` are `\textcolor` aliases (`color.xcolor`, `mark.kernel`). |

## Content-opaque
- `\includegraphics{example-image-a}` in the figure (aaai/main.tex:72); the image is from the `mwe` package, not shipped in the zip.
- Comment texts and the `refs.bib` entries (refs.bib:1-12) are content.
- docs/*.png are screenshots of the output, not template files.

## Lib changes
- New ways proposed: `sp.frenchspacing` kernel `\frenchspacing` / `\nonfrenchspacing` (aaai/main.tex:13), pdfLaTeX. W1: kernel command. W2: a single on/off switch. W3: any document sets sentence spacing. W4: one preamble line. Grepped `_Lib.md` for french, sfcode: no home, since `sp.lengths` holds dimensions and `sp.penalties` holds integer parameters. May fold into those two if the consolidator prefers.
- Not proposed: a way for `sidecomments`. It fails W1: the package is only in this single-author GitHub repo (v1.0, dated 2026/10/14, sidecomments.sty:22), ctan.org/pkg/sidecomments returned 404, and the zip is not a publisher release. It would pass W2 to W4 if it were released. `todonotes` (`note.todonotes`) is the nearest published way and does not reproduce the look.
- Origin note for the consolidator: the four venue styles (aaai2027.sty, acl.sty, cvpr.sty, iclr2027_conference.sty) are third-party GitHub copies of publisher kits, not on CTAN as far as read here (only sidecomments was checked); they are treated as zip-local. natbib.sty and fancyhdr.sty in examples/iclr are CTAN packages (LPPL headers, fancyhdr.sty:1-12, natbib.sty:1-25).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
