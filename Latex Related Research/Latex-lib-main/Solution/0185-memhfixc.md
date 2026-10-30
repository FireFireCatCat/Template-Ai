no

# 0185-memhfixc: the memoir class bundle and its user manual (memman)

- Unverified: read from the source, not compiled.
- Source: Source/0185-memhfixc/ (origin: https://mirrors.ctan.org/macros/latex/contrib/memoir.zip; licence: lppl1.3c)
- Kind: book (the sample is the memoir user manual, typeset as a book with the class's own chapter styles)
- Lib: v3
- Engine: pdfLaTeX-compatible (memsty.sty:175-184 takes the `pdftex` hyperref branch; the non-pdf branch at memsty.sty:185-195 is for dvips-style output)
- Look carried by: mixed (class `memoir` with its built-in `memman` headstyle and `demo3` chapterstyle, plus zip-local `memsty.sty`, `memfonts.sty`, `memlays.sty`, `titlepages.sty` and the preamble of `memman.tex`)
- Class origin: ctan (the zip is the CTAN memoir release; `memoir.dtx:450` is `\ProvidesClass{memoir}`; `mempatch.dtx:335` is the bundled `memhfixc` package)
- Main file: doc-src/memman.tex (other samples: doc-src/trims-example.tex, a 32-line memoir page-trim demo that the manual includes as `trims-example.pdf`; `memoir.dtx` and `mempatch.dtx` are DocStrip sources of the class, not samples)
- Read: main partly (39,643 lines: lines 1-640 in full, the outline by grep, and about 15 sampled blocks; the other lines are documentation prose and `lcode` listings), zip-local classes and styles partly (`memsty.sty`, `memfonts.sty`, `memlays.sty`, `titlepages.sty` read in full; `memnoidxnum.tex` is index-entry lines only and was checked by grep; `memoir.dtx` 34,423 lines and `mempatch.dtx` 933 lines are the published class source and were outlined by grep only)

## Verdict
The class is a published CTAN class, so `class.memoir` carries the page, heading, header/footer, float, index and verse vocabulary the manual shows. The manual itself, though, is not a clean use of published ways. Its zip-local `memsty.sty` holds hand-written typesetting code: a counter-swapping chapter-style demo environment, a rewrite of the contents machinery with `\let` swaps and an inline-subsection `\l@subsection`, a hand-built vbox/hrule/vrule box, a measuring glossary item and bookmark hooks for the index. The preamble also overrides `fixme` internals with TikZ overlays, patches a package internal (memman.tex:37-43), and the body defines a `\cleaders` chain. These are irreducible, so the answer is `no`.

## Blockers
- `BESPOKE/preamble` `demochap` and `demochap*` save and restore `chapter`, `section`, `subsection`, `footnote` and `figure` counters, switch `\counterwithout*`, and `\renewcommand` `\addcontentsline`, `\thispagestyle`, `\markboth`, `\refstepcounter` inside a shaded figure; used 59 times (memsty.sty:545-605; memman.tex:33429)
- `BESPOKE/preamble` contents-list switching: `\setupshorttoc`, `\setupparasubsecs`, `\setupmaintoc` `\let`-swap tocloft internals and redefine `\l@subsection` as run-in text, called with an `\endlinechar=-1` trick (memsty.sty:92-170; memman.tex:377-381, 397)
- `BESPOKE/preamble` `boxminipage` is a hand-rolled `\vbox`/`\hbox`/`\hrule`/`\vrule` box with minipage footnote handling, used by `showtitle` (memsty.sty:870-938; memman.tex:6578)
- `BESPOKE/preamble` glossary and index back-end hooks: `\glossitem` measures a box and branches, `\doidxbookmark` and `\doglobookmark` run `\ifx` or expl3 `\str_if_eq:nnTF` plus `\pdfbookmark`, wired in through the `.ist` and `.gst` heading and item keys (memsty.sty:64-72, 1005-1039, 1100-1107; memman.ist:13-15; memman.gst:6-13; memman.tex:39583-39597)
- `BESPOKE/preamble` `sniplet` and `\sniplettoc` rewire counters, `\cftinsertcode`, `\printtoctitle` and `tocdepth` to build a sub-contents (memsty.sty:1111-1147)
- `BESPOKE/preamble` `\FXLayoutMarginNote` of `fixme` is redefined using `\@fxuseface`, `\@fxtextstd` internals and `\tikz[overlay,remember picture]` connector lines (memman.tex:163-178)
- `BESPOKE/preamble` `\patchcmd` on the internal `\f@tevenlinenonum` of `fonttable` (memman.tex:37-43)
- `BESPOKE/body` `\motif` and `\chain` use `\cleaders\hbox{...}\hfil` over an arbitrary box, which `sp.rule` excludes (memman.tex:10353-10359)

## Class setting
- Class: `class.memoir` options: `10pt`, `letterpaper`, `extrafontsizes` (memman.tex:11)
- Class-native vocabulary used: `\headstyles{memman}`, `\chapterstyle{demo3|pedersen}`, `\makepagestyle`, `\makeevenhead` `\makeoddfoot` `\makeheadrule` `\makepsmarks`, `\aliaspagestyle`, `\settrimmedsize` `\settypeblocksize` `\setulmargins` `\setlrmargins` `\setmarginnotes` `\setheadfoot` `\setheaderspaces` `\setsidefeet` `\checkandfixthelayout`, `\frontmatter` `\mainmatter` `\backmatter`, `\appendixpage*`, `\settocdepth` `\setsecnumdepth`, the built-in tocloft API (`\cftsetindents` `\setpnumwidth` `\setrmarg` `\cftchapterfont` `\newlistof` `\newlistentry` `\cftinsertcode`), `\newfloat` `\newsubfloat` `\subbottom`, `adjustwidth`, `\firmlists` `\midsloppy`, `\fancybreak`, `\sidepar`, `\makeindex[name]` `\printindex[name]` `\twocolindex` `\onecolindex` `\indexintoc`, `\makeglossary` `\glossary` `\printglossary`, `\makepagenote` `\printpagenotes`, `\newoutputstream` `\openoutputfile`, `framed` `shaded` `leftbar`, `verse` with `\versewidth`, `\prebibhook` `\preindexhook` `\begintheglossaryhook`. `memhfixc` (hyperref fixes) is loaded by hyperref itself (memsty.sty:196).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | memman.tex:11 | `class.memoir` | 10pt, letterpaper, extrafontsizes |
| page geometry | memsty.sty:1061-1077 | `page.memoir-layout` | trimmed 11in x 210mm; typeblock 7.75in x 33pc; ulmargins 4cm; lrmargins 1.25in; marginnotes 17pt/51pt/\onelineskip; headfoot \onelineskip/2\onelineskip; sidefeet 9em; `\checkandfixthelayout` |
| indented blocks | memman.tex:218, 231 | `page.adjustwidth` | adjustwidth{1in}{1in} |
| bottom flush | memman.tex:205 | `pg.flush` | `\raggedbottom` |
| running heads | memsty.sty:36-42, 47-52; memman.tex:213, 374 | `hf.memoir-pagestyle` | `plainmarkruled` (head rule, scshape marks), `index`; `\aliaspagestyle{part}{empty}` (memsty.sty:1082) |
| page style selection | memman.tex:213, 374, 39566-39567 | `hf.pagestyle-kernel` | empty, headings |
| roman text fonts | memfonts.sty:7-8 | `font.family-default` | `\rmdefault`=ppl (Palatino), `\sfdefault`=lmss, `\ttdefault`=lmtt (memfonts.sty:19-20) |
| scaled font shapes | memfonts.sty:24-100; memsty.sty:457-458 | `font.nfss` | `\DeclareFontFamily`/`\DeclareFontShape` T1 lmtt scaled 1.09, lmss scaled 1.07, bodoni |
| encoding | memsty.sty:20 | `font.fontenc-t1` | T1 |
| symbol glyphs | memsty.sty:18; memman.tex:10347 | `font.icons` | pifont `\ding{167}` |
| sizes | memman.tex:220, 238 | `font.size-commands` | `\HUGE` (extrafontsizes), `\Huge`, `\LARGE`, `\footnotesize` |
| colours | memsty.sty:15, 205-215, 940-942 | `color.xcolor` | `\definecolor` linkcolour, citecolour, urlcolour, Dark/Medium/Light, shadecolor gray |
| PDF links and metadata | memsty.sty:175-183, 217-222 | `meta.hyperref` | pdftex, plainpages=false, pdfpagelabels, bookmarksnumbered, colorlinks; `\hypersetup` pdftitle, pdfauthor, linkcolor, citecolor, filecolor, urlcolor |
| URLs | memsty.sty:11, 21 | `meta.url` | `url`, `xurl` |
| cross references | memsty.sty:1215-1234; memman.tex:534-569 | `xref.hyperref`, `xref.kernel` | `\hyperref[label]{...\ref*}` wrappers `\fref` `\tref` `\pref` `\eref` |
| list and paragraph spacing | memman.tex:14, 203-204 | `sp.lengths`, `sp.hyphenat` | `\hfuzz=5pt`, `\firmlists`, `\midsloppy` |
| half-title, title, copyright pages | memman.tex:212-370 | `front.titlepage-env`, `sp.manual-space`, `tbl.tabular` | hand-laid with `\vspace*{\fill}`, centred `\HUGE\textsf`, copyright tabular `{@{} l l}` (memman.tex:280) |
| title-page logo | memman.tex:262-266 | `fig.graphicx` | `\includegraphics[width=\droptitle]{anvil2.mps}` (MetaPost output, shipped) |
| contents lists | memman.tex:377-411 | `toc.kernel`, `toc.tocloft` | short ToC then main ToC, `\listoffigures`, `\listoftables`, `\listofegresults`; `\cftsetindents` for section to subparagraph, figure, table (memsty.sty:1050-1058); `\setpnumwidth{2.55em}` `\setrmarg{3.55em}` (memsty.sty:1046-1047); machinery is a blocker |
| new float and list-of | memsty.sty:785-788 | `fig.float`, `toc.tocloft` | memoir's own `\newfloat[chapter]{tegresult}{loe}{...}`, `\newlistof`, `\newlistentry` (same command name as the float package, but memoir's own) |
| headings | memman.tex:59, 206, 7738; memoir.dtx:11975, 10432 | `head.memoir-style` | `\headstyles{memman}`, `\chapterstyle{demo3}`, `\chapterstyle{pedersen}` |
| depth and counters | memman.tex:62, 64; memsty.sty:1089, 1112 | `num.secnumdepth`, `num.counters` | tocdepth/secnumdepth = subsection, lofdepth=2, `\counterwithin{sniplet}{chapter}` |
| appendix | memman.tex:33139-33140 | `num.appendix` | `\appendix`, `\appendixpage*` |
| lists | memman.tex:540; memsty.sty:609-612, 720-727, 850-855 | `list.kernel`, `sp.lengths` | itemize/enumerate/description, `\descriptionlabel` redefined in a group (memman.tex:534); raw `\list` with `\leftmargin`, `\labelwidth` |
| quotations | memman.tex:328, 342 | `quote.kernel` | `quote` |
| verse | memman.tex:1804-1805, 5691 | `quote.verse-pkg` | memoir `verse`, `patverse`, `\indentpattern`, `\versewidth` |
| scene breaks | memman.tex:449, 487, 10359 | `class.memoir` (native `\fancybreak`) | no component line in the lib; recorded under the class vocabulary |
| footnotes and page notes | memsty.sty:76-86; memman.tex:39545 | `fn.kernel`, `fn.endnotes` | `\makepagenote`, `\notepageref`, `\printpagenotes` (memoir's pagenote, endnote-like) |
| margin notes | memsty.sty:27-28; memman.tex:146-151 | `note.marginpar`, `note.marginnote`, `draft.todo` | `\sidepar` for `\Added`; `fixme` with `layout=marginnote` (package is the parameter; override is a blocker) |
| text hiding | memman.tex:12 | `draft.todo` (considered: `comment`; nearest home, no printed effect) | `comment` environment |
| maths | memsty.sty:16, 19; memman.tex:3622, 3901 | `math.amsmath`, `math.kernel`, `math.amssymb` | amsmath, latexsym, `displaymath`, `equation`, `array` |
| figures | memsty.sty:14, 174; memman.tex:5173 | `fig.graphicx`, `fig.subcaption`, `fig.placement` | graphicx with an `mps` rule; `\newsubfloat{figure}`; `dpfloat` `leftfullpage` `fullpage` (memman.tex:4892; considered: dpfloat) |
| tables | memman.tex:2394-2399, 20658 | `tbl.tabular`, `tbl.booktabs`, `tbl.tabularx` | tabular, `\toprule`, `ctabular`, `tabularx`; `syntax` is a `p{0.9\linewidth}` tabular (memsty.sty:521-525) |
| captions | memsty.sty:797, 1087-1088 | `cap.memoir` | `\caption`, `\subcaption` via memoir's own caption code |
| listings of code | memsty.sty:504-512, 732-739, 764-773 | `code.verbatim` | `lcode` (921 uses), `egsource`, `shadecode`, `boxedverbatim`, `\verb`, `alltt` (memsty.sty:13); wrappers set `\verbatim@startline`, `\small`, baseline = `\onelineskip` |
| boxes | memsty.sty:616-621, 731-739, 1171-1183 | `box.mdframed`, `box.fancybox`, `box.minipage` | memoir `shaded` (gray 0.9 and 0.93), `leftbar`, `framed` with `\MakeFramed`; `\fbox{\parbox{}}`; `minipage` |
| bibliography | memsty.sty:1084; memman.tex:39562 | `bib.bibtex-bst` | `\bibliographystyle{alpha}`, `\bibliography{memrefs}`, `\prebibhook` |
| index | memman.tex:67, 39566-39600; memman.ist:7-16 | `idx.makeidx` | `\makeindex`, `\makeindex[lines]`, `\printindex[lines]`, `\twocolindex`, `makeindex -s memman.ist` (doc-src/Makeidxglo:4-5); hook macros are a blocker |
| glossary | memsty.sty:58-73; memman.tex:39552 | `idx.glossaries` (nearest; memoir's own makeindex-driven glossary) | `\makeglossary`, `\glossary(key){entry}{text}`, `makeindex -s memman.gst` (doc-src/Makeidxglo:6) |
| font specimen tables | memman.tex:33, 5392-5406 | `art.content-package` | `\fonttable{pplr}` (considered: fonttable) |
| layout and heading diagrams | memman.tex:4806-4820, 4892-4926, 8665-8667 | `art.pstricks` | `layouts` package drawings and `picture` code of memlays.sty, in figure floats (content) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `demochap`, `demochap*` | memsty.sty:545-605 | no | counter swap plus redefinition of kernel and class internals inside a figure; irreducible |
| `\setupshorttoc`, `\setupparasubsecs`, `\setupmaintoc` | memsty.sty:92-170 | no | `\let` swaps of tocloft macros, run-in `\l@subsection`; irreducible |
| `boxminipage`, `showtitle` | memsty.sty:870-938 | no | primitive box code; irreducible |
| `\glossitem`, `\doidxbookmark`, `\doglobookmark`, `.ist`/`.gst` hooks | memsty.sty:64-72, 1005-1039, 1100-1107; memman.ist:13-15; memman.gst:6-13; memman.tex:39583-39597 | no | measure-and-branch and conditional bookmark code; irreducible |
| `sniplet`, `\sniplettoc` | memsty.sty:1111-1147 | no | tocdepth and `\cftinsertcode` rewiring; irreducible |
| `\FXLayoutMarginNote` override | memman.tex:163-178 | no | package internals plus TikZ overlay; irreducible |
| `\patchcmd` of `\f@tevenlinenonum` | memman.tex:37-43 | no | patches a third-party internal; irreducible |
| `\motif`, `\chain` | memman.tex:10353-10355 | no | leaders over an arbitrary box (`sp.rule` excludes it) |
| `\setlayoutscale` renewal | memsty.sty:31-33 | no | edits `layouts` internals (`\l@youtunitlength`); small, irreducible |
| `\drawchapter`, `\headerfooterdiagram`, `\drawheading` | memlays.sty:16-105, 118-205, 216-362 | no | coordinate arithmetic with `picture`; sits only in figure floats, so content-opaque, not counted as a blocker by itself |
| `\title...` pages (30 macros) | titlepages.sty:15-634 | mostly | kernel boxes, `\rule`, `\vspace`, `\parbox` reduce to `sp.manual-space`, `sp.rule`, `box.minipage`, `font.size-commands`; `\titlePM` `\titleZD` `\titleWH` (picture, `\multiput`, `webo` font), `\titleVL` (raw `\hbox`/`\vrule`) and `\titleRB` (picture frames) are figure artwork; FontSite fonts 5gm and 5bo are not shipped |
| `lcode`, `syntax`, `egsource`, `egresult`, `typeseteg`, `listeg`, `plainlist`, `shadecode`, `shadefigure`, `shadetable`, `recommended`, `caveat`, `Changed`, `Deprecated`, `note`, `hint`, `tip` | memsty.sty:504-525, 720-847, 850-855, 1171-1209 | yes | `code.verbatim` (fancyvrb options) plus `box.mdframed` shaded/leftbar, `list.kernel` with `sp.lengths`, `tbl.tabular`, `fig.float` and `cap.memoir`; each is a composition, with `\verbatim@startline` as the only internal |
| print-and-index macros (`\Lpack`, `\Lopt`, `\Ie`, `\pixfile`, `\lnc`...) | memsty.sty:297-420 | yes | `\newcommand` aliases of `mark.kernel` font switches plus `\index` entries (`idx.makeidx`) |
| logo and reference aliases, `\CTANurl`, `\README`, `maintainersig` | memsty.sty:227-295, 1151-1161, 1215-1249 | yes | `\newcommand` aliases, `xref.hyperref`, `sp.ragged` |
| `memfonts.sty` | memfonts.sty:1-104 | yes | `font.family-default` and `font.nfss` as in the map |
| `\ifMASTER` branch with svn-multi and `\addRevisionData` picture | memman.tex:72-131 | n/a | not active in the public build (`\MASTERfalse`); `\svnidlong` is a no-op (memman.tex:132) |
| `\newoutputstream{egout}` file opened but not written | memsty.sty:830-831 | yes | memoir stream opening, no printed effect |

## Content-opaque
- Page-layout, chapter-heading and header/footer diagrams in figure floats (memman.tex:4806-4820, 4892-4926, 8665-8667) drawn by `layouts` and memlays.sty.
- Hand-laid example title pages in `showtitle` floats (memman.tex:6578, 6611) from titlepages.sty.
- Included images `setpage-example.pdf` (memman.tex:5173), `trims-example.pdf` (memman.tex:29212), `anvil2.mps` (memman.tex:265).
- `picture` examples in `egresult` floats (memman.tex:34469 on) and font specimen tables (memman.tex:5392-5406).
- Not blockers, recorded: `trims-example.pdf` is not shipped and must be built first from `trims-example.tex` (memman.tex:189-190); the fonts for the FontSite title pages are not shipped; `Makeidxglo` runs `makeindex` three times and a `bibtex` pass, the standard tools of `idx.makeidx` and `bib.bibtex-bst`, so they are not counted as `EXTERNAL`.

## Lib changes
- New ways proposed: none. Considered and mapped to the nearest existing way, not proposed: `comment` (to `draft.todo`), `dpfloat` (to `fig.placement`), `fonttable` (to `art.content-package`), `layouts` (to `art.pstricks`, figure content).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
