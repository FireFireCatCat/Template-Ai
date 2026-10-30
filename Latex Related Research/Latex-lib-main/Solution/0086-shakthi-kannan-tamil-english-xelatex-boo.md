no

# 0086-shakthi-kannan-tamil-english-xelatex-boo: Shakthi Kannan Tamil/English XeLaTeX Book

- Unverified: read from the source, not compiled.
- Source: Source/0086-shakthi-kannan-tamil-english-xelatex-boo/ (origin: https://latextemplates.com/downloads/shakthi-kannan-xetex-book-template.zip; licence: not established by the manifest, README.org:75 says "released under the MIT license")
- Kind: book
- Lib: v1 (snapshot read)
- Engine: needs XeLaTeX (fontspec, polyglossia at main.tex:4-5; example/Makefile:17 runs xelatex)
- Look carried by: mixed (main.tex: kernel `book` plus a preamble of published packages; the original project's look is in zip-local styles/config.sty, which main.tex does NOT load but example/book.tex does)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: example/book.tex, which loads styles/config.sty)
- Read: main yes, zip-local classes and styles all (styles/config.sty read in full; example/book.tex, Makefile, post-processing.el, README.org and both .org bodies also read in full; end.tex is the single line `\end{document}`)

## Verdict
The simplified `main.tex` taken alone is recoverable: every construct in it is a lib way (`class.book`, `font.fontspec`, `lang.polyglossia`, `page.geometry`, `hf.fancyhdr`...) and it has no bespoke code. But the zip also ships the original template (README.org:4-5, main.tex:47 "fuller configuration remains in styles/"): `styles/config.sty` plus `example/book.tex`. That part has two irreducible patches of package internals, pstricks ornament and frame artwork, and a body that exists only as Org-mode files converted by Emacs, so it is not a self-contained LaTeX template. By the rubric ("if you cannot show it, no") the zip as shipped is `no`; read on `main.tex` alone it would be `yes`. Scope tags below say which sample each blocker belongs to.

## Blockers
- `BESPOKE/class` `\patchcmd{\ttlh@hang}` twice (etoolbox) edits titlesec internals as a workaround for the 2016 titlesec update (styles/config.sty:8-13). The chapter format is `[block]` (config.sty:79, 166), not `[hang]`, so it may add no look of its own, but that cannot be shown without compiling. Loaded only through example/book.tex:30, not by main.tex.
- `BESPOKE/class` `\xpatchcmd{\verse}{\itemsep}{\advance\topsep-\parskip\itemsep}` rewrites the `verse` environment's code to cancel the global `\parskip=1em` (styles/config.sty:226, 43). It changes vertical spacing, and no lib way expresses a code patch.
- `ART/class` `\vectorframelandscape` and `\vectorframeportrait`: a `pspicture` with four mirrored/flipped `psvectorian` ornaments at hand-tuned `\rput` coordinates around an image, a template-defined frame (styles/config.sty:183-205; used at example/book.tex:57 inside a figure). Maps only to `art.pstricks`, so it is artwork.
- `ART/class` `\separator` and `\addornament`: `psvectorian` ornaments by number with `width`/`scale`/`flip`/`mirror` (styles/config.sty:113-117, 173-181; used as section ornaments at example/book-contents.org:163-168). `ctan.org/pkg/psvectorian` returned 404 in the one read made, so W1 (published) is not established and no `NEW:` way is proposed.
- `EXTERNAL/body` the body is Org-mode, turned into LaTeX by `emacs --batch ... org-latex-export-to-latex`, then regex-rewritten by `scripts/post-processing.el` (`\section` to `\chapter`, verse/quote wrapped in `\emph{...}`) (example/Makefile:6-12, scripts/post-processing.el:15-67, README.org:61-72). `example/book.tex:69,77,83` includes `foreword`, `book-contents` and `end`; the zip holds `foreword.org` and `book-contents.org`, not `.tex`, so book.tex does not compile without Emacs.

## Class setting
- Class: `class.book` options: `11pt,openany` (main.tex:3; example/book.tex:5)
- Class-native vocabulary used: `\frontmatter` `\mainmatter` (main.tex:26,35; book.tex:44,71), `\chapter` `\section` (main.tex:36,41,45), `\maketitle` as the book title page (main.tex:27), `\tableofcontents` (main.tex:34), `\include` (book.tex:69,77,83)

## Component map
Rows marked S1 are main.tex; S2 are example/book.tex with styles/config.sty (not loaded by main.tex).

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| class | main.tex:3 (S1); book.tex:5 (S2) | `class.book` | 11pt, openany |
| fonts, main | main.tex:4,7 (S1) | `font.fontspec` | `\setmainfont{DejaVu Serif}` (system font, not shipped) |
| fonts, Tamil switch | main.tex:8 (S1) | `font.fontspec` | `\newfontfamily\tamilfont{DejaVu Sans}`; used main.tex:30,42 |
| fonts, four families | config.sty:36-39 (S2) | `font.fontspec` | `\newfontfamily` englishfont Liberation Serif-Bold, tamilfont and tamilitalics Uni Ila.Sundaram-01/-03, devanagirifont Nakula; Scale=1.1/1.2, Ligatures=TeX (fonts not shipped) |
| fonts, Latin | config.sty:17 (S2) | `font.lmodern` | load only |
| language | main.tex:5-6 (S1); book.tex:12 (S2) | `lang.polyglossia` | S1 `\setdefaultlanguage{english}`; S2 loaded with no language call; Tamil only by font switch |
| page geometry | main.tex:9-10 (S1) | `page.geometry` | paperwidth=7in, paperheight=9in, margin=1in, twoside |
| page geometry | config.sty:6,30-32 (S2) | `page.geometry` | margin=1in, papersize={7.0in,9.0in}, twoside, footskip=0.75cm |
| header/footer | main.tex:11,17-21 (S1) | `hf.fancyhdr` | `\pagestyle{fancy}`, clear head and foot, `\fancyhead[LE,RO]{\thepage}`, `[RE,LO]{\slshape\leftmark}` |
| header/footer | config.sty:16,45-52 (S2) | `hf.fancyhdr` | same, `[RE]` prints `\booktitle`, `[LO]` `\leftmark`; `\chaptermark` gives "N. title" (config.sty:60-61) |
| empty page style | main.tex:28; book.tex:46,51; config.sty:156 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` |
| spacing | main.tex:12,16 (S1); config.sty:91, book.tex:13 (S2) | `sp.setspace` | `\onehalfspacing` |
| paragraph lengths | config.sty:42-43 (S2) | `sp.lengths` | `\parindent=4em`, `\parskip=1em` |
| list indent | config.sty:93-97 (S2) | `sp.lengths` | `\leftmargini=4.5em`, only when boolean `leftmargini` is true (book.tex:24-25 sets true) |
| line breaking | book.tex:38-42 (S2) | `sp.hyphenat` | `\hyphenchar\font=-1`, `\pretolerance=\tolerance=\hbadness=9999` (the parameters `\sloppy` sets) |
| line breaking | book.tex:42 (S2) | `sp.lengths` | `\emergencystretch=5em` |
| hyperlinks | main.tex:13 (S1) | `meta.hyperref` | no options |
| title block | main.tex:22-24,27 (S1) | `front.maketitle` | `\title`, `\author`, `\date{\today}`, `\maketitle` |
| title block, extra | main.tex:29-32 (S1) | `sp.ragged` | `center` environment, `\Large\tamilfont` text, `\\[1em]`, `\normalsize` |
| title page, hand-laid | config.sty:121-139, book.tex:47 (S2) | `front.titlepage-env` | centred bullet and Tamil invocation, double rule 1.6pt/0.4pt at 0.9\textwidth, optional subtitle, `\vfill`, author; no `\maketitle` call |
| copyright page | config.sty:141-149, book.tex:52 (S2) | `front.dedication` | `\vfill` then `\textcopyright{} 2016` and names |
| front matter | main.tex:26 (S1); book.tex:44 (S2) | `class.book` | `\frontmatter` |
| page breaks | main.tex:33; book.tex:48,53,61,65 | `pg.break` | `\cleardoublepage`, `\newpage`, `\clearpage` |
| contents | main.tex:34; book.tex:63 | `toc.kernel` | `\tableofcontents` |
| contents, load only | main.tex:15 (S1) | `toc.tocloft` | loaded with no settings |
| contents, styled | config.sty:18,56-58,214-215,224 (S2) | `toc.tocloft` | `\cftchapaftersnumb`/`\cftsecaftersnumb`/`\cftsubsecaftersnumb`=`\hspace{0.5em}`, `\cftbeforetoctitleskip`=`\cftbeforeloftitleskip`=-3em, `\cftchappagefont`=`\englishfont` |
| contents names | config.sty:209-212 (S2) | `toc.kernel` | `\renewcommand{\contentsname}`, `\listfigurename` set to Tamil text |
| headings | main.tex:36,41,45 (S1) | `head.kernel` | `\chapter`, `\section`; titlesec loaded at main.tex:14 with no `\titleformat` (`head.titlesec`, load only) |
| headings, chapter | config.sty:7,63,70-84,165-171 (S2) | `head.titlesec` | `\titleformat{\chapter}[block]{\huge\bfseries}{label}{0pt}{\formatchaptertitle}`; two branches chosen by boolean `bulletchapters` (book.tex:21-22 sets true); `\titlespacing*{\chapter}{0pt}{-70pt}{0pt}` |
| chapter title box | config.sty:65-66 (S2) | `box.minipage` | `\parbox[t]{\dimexpr\textwidth-10pt}`, `\raggedright\LARGE\scshape` (also `sp.ragged`, `mark.kernel`) |
| colour | config.sty:15,68,74 (S2) | `color.color` | `\definecolor{gray75}{gray}{0.75}`, `\textcolor` on the chapter rule "\|" |
| absolute block | config.sty:24,86-87,160 (S2) | `pg.textpos` | option `absolute`, `\TPHorizModule`=`\TPVertModule`=3cm, `\begin{textblock}{6}(0,0.45)` |
| attribution lines | config.sty:101-111 (S2) | `sp.manual-space` | `\nopagebreak`, `\raggedleft`, `\vskip-0.25cm`/`-0.7cm`, `\vspace{5mm}`, font switch; `pg.break` for `\nopagebreak` |
| blank page | config.sty:154-158 (S2) | `num.counters` | `\null`, `\thispagestyle{empty}`, `\addtocounter{page}{-1}`, `\newpage` |
| stacked fractions | config.sty:21,151-152 (S2) | `tbl.tabular` | `array` with `\hline` inside `\smash`, `\text{\itshape}` from `math.amsmath` (`amstext`), in `math.kernel` |
| emphasis | config.sty:217 (S2) | `mark.kernel` | `\renewcommand{\emph}` as a switch to `\tamilitalics` |
| verse | book.tex:14; config.sty:219-226; book-contents.org:91-120 (S2) | `quote.verse-pkg` | `verse` package: `verse` environment, `\settowidth{\versewidth}`, `\flagverse`, `\poemtitle`; `\poemtitle` redefined to a `center` environment (config.sty:219-222) |
| quote | book-contents.org:157-160; foreword.org:19-25 (S2 body) | `quote.kernel` | `quote` environment with `\flagverse` |
| dialogue | book.tex:11; book-contents.org:39-44 (S2 body) | `quote.dialogue` | `dialogue` environment, `\speak{name}` |
| figure | book.tex:55-59 (S2) | `fig.graphicx` | `figure[p]`, `\centering`, `\caption`, `\label`; `\figurename` renewed (config.sty:211-212) |
| caption package | config.sty:26 (S2) | `cap.caption` | load only, no options |
| cross-reference | book.tex:58 (S2) | `xref.kernel` | `\label{Figure:-tamilfont}` |
| footnote | book-contents.org:13,25 (S2 body, via Org export) | `fn.kernel` | `\footnote` |
| frame and tables in body | book-contents.org:60-65,150-158 (S2 body) | `box.fancybox` | `\framebox[0.7\textwidth][c]`; `tabular*` with `@{\extracolsep{\fill}}` is `tbl.tabular` |
| rupee sign | config.sty:25; book-contents.org:7 (S2 body) | `font.icons` | `tfrupee` (CTAN, read), `\rupee` in text; nearest home (a symbol-font package) |
| loaded, unused | config.sty:22-23 (S2) | `pg.afterpage` | `afterpage` loaded, no `\afterpage` call found; `varwidth` loaded, no use found |
| ornaments and frames | config.sty:113-117,173-205 (S2) | `art.pstricks` | blocker `ART/class`, see Blockers |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\patchcmd{\ttlh@hang}` x2 | config.sty:8-13 | No | Patches titlesec internals; no lib way. Probably no look effect for `[block]` chapters, unverified. |
| `\xpatchcmd{\verse}` | config.sty:226 | No | Edits the verse environment's code to cancel `\parskip`; look-affecting. |
| `\vectorframelandscape`, `\vectorframeportrait` | config.sty:183-205 | No | pspicture with `\rput` coordinates (`ART`). |
| `\separator`, `\addornament` | config.sty:113-117,173-181 | No (W1 not established for psvectorian) | `ART`. |
| `\titleTMB[opt]{a}{b}` | config.sty:121-139 | Yes | `front.titlepage-env` body wrapper: `sp.ragged` `\centering`, `sp.rule` two rules, `sp.manual-space` `\\[..]` `\vfill` `\vspace*`, `font.size-commands` `\Huge` `\LARGE`, `font.fontspec` `\tamilfont`; `\ifthenelse{\equal{#1}{}}` only decides whether the subtitle line is printed. `\newlength{\drop}` is never set. |
| `\copyrightpage` | config.sty:141-149 | Yes | `front.dedication` with `sp.manual-space` and `sp.lengths` (`\parindent 0pt`, `\parskip\baselineskip`). |
| `\attrib` `\vattrib` `\vdattrib` `\fattrib` | config.sty:101-111 | Yes | Aliases: `pg.break`, `sp.ragged`, `sp.manual-space`, font switch. |
| `\twofrac`, `\threefrac` | config.sty:151-152 | Yes | Alias over `tbl.tabular` inside `math.kernel`, with `\hline`. |
| `\blankpage` | config.sty:154-158 | Yes | `pg.break`, `hf.pagestyle-kernel`, `num.counters`. |
| `\bullettitle`, `\bullettitlevspacing`, `\bullettitlevmorespacing` | config.sty:160-163 | Yes | `pg.textpos` block plus `sp.manual-space`. |
| `\selecttoptitle`, `\formatchaptertitle`, `\hsp` | config.sty:69,65-66,165-171 | Yes | Aliases of `head.titlesec`, `box.minipage`, `sp.manual-space`. |
| booleans `bulletchapters`, `leftmargini` | book.tex:21-25; config.sty:70-97 | Yes (judgement call) | Constants set in the preamble that pick one declarative branch; an emitter prints the chosen branch. |
| `\renewcommand{\emph}` | config.sty:217 | Yes | Alias to a font switch (`mark.kernel` + `font.fontspec`). |
| `\renewcommand{\poemtitle}` | config.sty:219-222 | Yes | `center` environment around the argument. |
| `\renewcommand{\chaptermark}` | config.sty:60-61 | Yes | `head.kernel` mark format `\markboth{\thechapter.\ #1}{}`. |
| `\booktitle` | book.tex:28 | Yes | Alias to `\tamilfont{ஸ்ரீ}`. |
| `\hyphenchar`, tolerance settings | book.tex:38-42 | Yes | `sp.hyphenat`, `sp.lengths`. |
| post-processing.el, Makefile | scripts/post-processing.el; example/Makefile | No | `EXTERNAL`, see Blockers. |
| main.tex | main.tex:1-48 | n/a | No `\newcommand`, `\def`, environment or counter is defined in it. |

## Content-opaque
- `example/images/Shri-symbol.png` (120x117 PNG) included inside the ornament frame in a figure (example/book.tex:57).
- Tamil and Devanagari running text, verse and dialogue text (example/book-contents.org, foreword.org).
- `tabular*` tables with Tamil letters (book-contents.org:60-65,150-153).

Notes: fonts DejaVu Serif/Sans (main.tex:7-8) and Liberation Serif, Uni Ila.Sundaram, Nakula (config.sty:36-39) are not shipped; ship them. No text addressed to an AI was found in the zip.

## Lib changes
- New ways proposed:
  - `quote.verse-pkg` the `verse` package (CTAN, Peter Wilson; `ctan.org/pkg/verse` was NOT read, the 3 permitted reads went to psvectorian, dialogue and tfrupee, so the consolidator should confirm W1); pdf. `verse` environment with `\poemtitle`, `\flagverse`, `\versewidth`. W1 published (to be confirmed); W2 lengths and font hooks; W3 any poem; W4 preamble line plus environment wrapper. Kept apart from `quote.kernel` because it is a separate package, as `list.enumerate-pkg` is from `list.kernel`.
  - `quote.dialogue` the `dialogue` package (CTAN v1.1, GPL, "cite short passages of scripted dialogue", `ctan.org/pkg/dialogue` read); pdf. `dialogue` environment with `\speak{name}` (book-contents.org:39-44). W1 published; W2 argued only from the one use (speaker name strings), its documentation was not read; W3 any script or interview; W4 environment wrapper. No existing lib way holds scripted dialogue.
- Rejected, not proposed: `psvectorian` (`ctan.org/pkg/psvectorian` returned 404, so W1 is not established); `config` (the zip's own `\ProvidesPackage{config}` style, zip-local, not published).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
