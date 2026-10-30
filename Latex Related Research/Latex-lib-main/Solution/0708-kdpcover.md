no

# 0708-kdpcover: kdpcover, a LaTeX class for Amazon KDP book covers

- Unverified: read from the source, not compiled.
- Source: Source/0708-kdpcover/ (origin: https://mirrors.ctan.org/macros/latex/contrib/kdpcover.zip; licence: MIT, kdpcover.dtx:3, kdpcover.ins:8, manifest `mit`)
- Kind: misc (a one-page wrap-around book cover; the manifest hint `misc` agrees)
- Lib: v5
- Engine: pdfLaTeX-compatible, but needs `--shell-escape` and the external tools `qpdf` and `git` (kdpcover.dtx:92-94, 268-269, 472; README.md:17-19)
- Look carried by: class (the sample passes only class options and the class's own `\put...` commands; the whole look is in the class code, kdpcover.dtx:233-507)
- Class origin: ctan (manifest source `ctan`, url under mirrors.ctan.org/macros/latex/contrib/; ctan.org/pkg/kdpcover read: v0.7.1 of 2026-10-16, MIT, Yegor Bugayenko; README.md:4 and 23; kdpcover.ins:6 `\usedir{macros/latex/contrib/kdpcover}`)
- Main file: kdpcover.dtx (no `.tex` and no `.cls` in the zip; the sample is the `docshot` example at lines 73-87; the documentation driver is lines 36-57; the class is generated from the `class` guard of the `.dtx` by kdpcover.ins:30). Other samples: README.md:26-34, kdpcover.dtx:103-107 (`pages=120`), 120-124 (`pdf=book.pdf`), 136-142 (custom size), 161-165 (`barless`).
- Read: main yes, zip-local classes and styles all (the class code is the unprefixed lines of kdpcover.dtx, read in full; no `.cls` or `.sty` is shipped)

## Verdict
No. The look is carried by one published class, `class.kdpcover` (W1 holds: it is on CTAN, and this zip is its own distribution), and its internals reduce to lib ways (`pg.textpos`, `page.geometry`, `sp.rule`, `fig.rotating`, `fig.graphicx`). The answer is still `no` under the pilot ruling: the class loads `iexec` unconditionally (kdpcover.dtx:253), a package whose job is to run shell commands, and the class documentation and the CTAN page both say `pdflatex` must be run with `--shell-escape` so that LaTeX can execute `qpdf` (kdpcover.dtx:92-94). That is `EXTERNAL/package` even though the sample passes `pages=200` (kdpcover.dtx:74) and so never reaches the `qpdf` call. The sample's `\putVersion` also runs `git` through `\iexec` whenever a `.git` entry exists in the working directory (kdpcover.dtx:471-481).

## Blockers
- `EXTERNAL/package` the class loads `iexec` unconditionally; `iexec` executes shell commands and the documentation requires `--shell-escape` (kdpcover.dtx:253, 92-94; README.md:17-19). The CTAN page of `iexec` does not itself name shell escape, so this need rests on the class documentation
- `EXTERNAL/class` option `pdf=<file>` runs `qpdf --show-npages ... | tr` and reads the count back from `kdpcover-pages-count.txt` (kdpcover.dtx:264-274); not used by the sample, which gives `pages=200`
- `EXTERNAL/class` `\putVersion` calls `git log -n 1` through `\iexec` when `.git/HEAD` or `.git` exists (kdpcover.dtx:471-473, 477-479); the sample calls `\putVersion{0.7.1}` (kdpcover.dtx:78)

## Class setting
- Class: `class.kdpcover` options: `pages=<n>` (default 100, kdpcover.dtx:243, 287-289), `pdf=<file>` (264-274), `6x9` (default, 275-278; 151), `7x10` (279-282), `8x10` (283-286), `barless` (263); options go through `pgfopts`/`pgfkeys` (259-291). The sample uses `pages=200,6x9` (kdpcover.dtx:74). The class loads `class.article` as its base (kdpcover.dtx:236).
- Class-native vocabulary used: `\putSpine[logo]{text}` (76), `\putVolume{n}` (77), `\putVersion{text}` (78), `\putPrice{text}` (79), `\putCopyright{year}{name}` (80), `\putTitle{text}` (81), `\putAuthor{text}` (82), `\putTLDR{text}` (83-84), `\putPicture{file}` (85); documented and not in the sample: `\putBack{text}` (222-225), lengths `\kdpxsize` `\kdpysize` (136-142). No abstract, sectioning, bibliography, floats, header or footer: the class sets no `\pagestyle`, so article's defaults stand.

## Component map
Rows 1 to 20 describe the cover (sample plus class code). Rows 21 to 31 describe the documentation driver (`ltxdoc`), a secondary sample that is not the cover's look. All paths are kdpcover.dtx.

| Component | Evidence | Way | Parameters |
|---|---|---|---|
| 1 document class | kdpcover.dtx:74, 32-34 | `class.kdpcover` | `pages=200,6x9`; version 0.7.1 |
| 2 base class (loaded by the class, not chosen by the document) | kdpcover.dtx:236 | `class.article` | `\LoadClass{article}`; its `\maketitle` and sectioning are unused |
| 3 paper size from options | kdpcover.dtx:74, 275-289 | `page.class-options` | `6x9` sets `\kdpxsize=6in`, `\kdpysize=9in`; `pages=200` sets `\kdp@pages`; custom size by lengths (138-139) |
| 4 page geometry (class-internal) | kdpcover.dtx:328, 330-343 | `page.geometry` | `paperwidth` = 0.125in + 6in + 0.125in + 6in + 0.0025in*pages (12.75in for 200 pages), `paperheight` = 0.125in + 9in + 0.125in (9.25in), `left=right=top=bottom=0pt`; set in hook `begindocument/before` |
| 5 absolute placement | kdpcover.dtx:344, 351-352 | `pg.textpos` | `\PassOptionsToPackage{absolute}{textpos}`, `\TPGrid{16}{16}`; each `\put...` is a `textblock` with width, anchor and (x,y) in grid units, e.g. `{4}(10,2)` at 389 |
| 6 spine bar | kdpcover.dtx:360-368 | `sp.rule` | black rectangle 2.4 `\TPHorizModule` wide, 16 `\TPVertModule` tall in `textblock{2.4}[0.5,0](8,0)` (361), drawn as a TikZ node (363-365); dropped by `barless` (360); reduction in the Bespoke table |
| 7 spine text | kdpcover.dtx:369-376 | `fig.rotating` | white text rotated 270 degrees, `\Large` (373), in `textblock{1}[0.5,0](8,2)`; written as a TikZ node, reduces to `\rotatebox` |
| 8 spine logo | kdpcover.dtx:377-379 | `fig.graphicx` | `\includegraphics[width=0.32in]{#1}` in a `\centerline`, default file `kdpcover-signature` (359); shipped in the zip |
| 9 volume figure | kdpcover.dtx:399-404 | `fig.graphicx` | `\includegraphics[height=0.4in]{kdpcover-vol-#1}` after `\raggedleft`, in `textblock{2}[1,1](15,14)`; files `kdpcover-vol-1..4.pdf` shipped |
| 10 front picture | kdpcover.dtx:388-392 | `fig.graphicx` | `\includegraphics[width=\textwidth]{#1}` inside `textblock{4}(10,2)`; the picture is content |
| 11 cover texts | kdpcover.dtx:411-415, 422-426, 433-437, 444-448, 455-459, 474-481, 489-494 | `front.class-native` | `\putPrice` `\putBack` `\putTitle` `\putAuthor` `\putTLDR` `\putVersion` `\putCopyright`, each a `textblock` at a fixed grid position (for example title `{5}(10,9)` at 434); fixed strings `by `, `TL;DR `, `(c)~` |
| 12 font sizes | kdpcover.dtx:373, 413, 424, 435, 446, 491 | `font.size-commands` | title `\fontsize{32}{32}\selectfont`; `\small`, `\large`, `\Large` |
| 13 any-size fonts | kdpcover.dtx:297 | `font.exscale` | `\RequirePackage{anyfontsize}`: load-only, lets any `\fontsize` work (ctan.org/pkg/anyfontsize read: LPPL 1.2, in TeX Live, no options named); the same type as `fix-cm`, which the lib folds into this way |
| 14 text face | kdpcover.dtx:500-501 | `mark.kernel` | `\ttfamily` applied to the whole document at `\AtBeginDocument` (the same effect as `\familydefault`=`\ttdefault`, `font.family-default`) |
| 15 alignment | kdpcover.dtx:378, 401, 502 | `sp.ragged` | `\raggedright` (502), `\raggedleft` (401), `\centerline` (378) |
| 16 paragraph shape | kdpcover.dtx:503-504 | `sp.lengths` | `\parindent=0pt`, `\parskip=0pt` |
| 17 line spacing | kdpcover.dtx:307-308 | `sp.setspace` | `\setstretch{1.2}` |
| 18 penalty | kdpcover.dtx:505 | `sp.penalties` | `\interfootnotelinepenalty=10000` |
| 19 microtype | kdpcover.dtx:299 | `sp.microtype` | loaded with defaults |
| 20 colour | kdpcover.dtx:300, 363, 371 | `color.xcolor` | `fill=black`, `color=white` only |
| 21 doc driver class | kdpcover.dtx:37 | `class.ltxdoc` | `\documentclass{ltxdoc}` |
| 22 doc driver fonts | kdpcover.dtx:38 | `font.lmodern` | `\usepackage{lmodern}` |
| 23 doc driver microtype | kdpcover.dtx:40-41 | `sp.microtype` | `\microtypesetup{protrusion=false}` added to hook `env/verbatim/begin` |
| 24 doc driver links | kdpcover.dtx:42-43, 60 | `meta.hyperref` | `\PassOptionsToPackage{hyperindex=false}{hyperref}`, `href-ul`, and `\href` in the title note |
| 25 doc driver bookmarks | kdpcover.dtx:44 | `meta.bookmark` | `\usepackage{bookmark}` |
| 26 doc driver DocStrip typesetting | kdpcover.dtx:46, 48-55, 98-111, 227, 510 | `dtx.doc` | `\PageIndex` `\EnableCrossrefs` `\CodelineIndex` `\RecordChanges`, `\DocInput`, `\PrintChanges`, `\PrintIndex`, `macro` environments, `\StopEventually`, `\Finale`; `docshots` (`dtx,margin=0,small`, `docshot[prerequisite=cactus.pdf]` at 73) is a package-documentation package, the parameter of this way (not read here; whether it needs a shell tool is not established) |
| 27 doc title block | kdpcover.dtx:60-64 | `front.maketitle` | `\title`, `\author`, `\date{\filedate, \fileversion}`, `\maketitle` |
| 28 doc title note | kdpcover.dtx:60 | `front.thanks` | `\thanks{The sources are on GitHub at ...}` |
| 29 doc title logo | kdpcover.dtx:60, 47 | `fig.graphicx` | `\includegraphics[width=0.75in]{yb-book-logo.pdf}` |
| 30 doc sectioning | kdpcover.dtx:66, 96, 171, 229 | `head.kernel` | `\section{...}`, class defaults |
| 31 doc verbatim listings | kdpcover.dtx:103-107, 120-124, 136-142, 161-165 | `code.verbatim` | `verbatim` environments (inside `%<*verb>` guards) |

## Bespoke code
The class is published (CTAN), so these items sit inside one published class way and are not blockers by themselves; they are listed so the result can be re-read if the class were treated as zip-local. Scope is `class` for all of them.

| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| lengths and counter `\kdp@pages`, `\kdpxsize`, `\kdpysize`, `\kdp@width`, `\kdp@height` | kdpcover.dtx:242-247, 318-319 | yes | the emitter evaluates the sums and writes constants: `page.geometry` paperwidth and paperheight |
| `pgfkeys` option parser (`barless`, `pages`, `6x9`, `7x10`, `8x10`) | kdpcover.dtx:259-291 | yes | class options as parameters of `class.kdpcover`; the emitter picks one size |
| `begindocument/before` hook with `calc` arithmetic, `\geometry`, `\TPGrid{16}{16}` | kdpcover.dtx:330-345 | yes | `page.geometry` paperwidth=12.75in, paperheight=9.25in, margins 0pt, and the `pg.textpos` grid 16 by 16; `calc` (302) is an implementation helper (considered, no lib line), not needed after evaluation |
| `\putSpine` (conditional bar, rotated white text, logo) | kdpcover.dtx:359-380 | yes | `pg.textpos` blocks holding `sp.rule` (black, 2.4 by 16 grid modules), `fig.rotating` (270 degrees) with `color.xcolor` white text, and `fig.graphicx`; the TikZ nodes (362, 370) serve as boxes for a filled rectangle and a rotated text, so no `ART` is raised; exact placement of the rotated node (minimum height `\TPHorizModule`) is not checked, nothing is compiled |
| `\ifdefined\kdp@barless` | kdpcover.dtx:360, 368 | yes | the emitter includes or omits the bar block |
| `\putPicture` `\putVolume` `\putPrice` `\putBack` `\putTitle` `\putAuthor` `\putTLDR` `\putCopyright` | kdpcover.dtx:388-459, 489-494 | yes | each is `pg.textpos` + `fig.graphicx` or text with `font.size-commands` and `sp.ragged` |
| `\AtBeginDocument` block | kdpcover.dtx:500-506 | yes | `mark.kernel` (`\ttfamily`), `sp.ragged`, `sp.lengths`, `sp.penalties` |
| `\putVersion`, `\kdp@gitdate` | kdpcover.dtx:471-481 | no (needs `git`) | `EXTERNAL/class`; the date comes only from a shell command; a literal date string would be content |
| `pdf` option (`qpdf`, `kdpcover-pages-count.txt`, `\openin`/`\read`) | kdpcover.dtx:264-274 | no (needs `qpdf`) | `EXTERNAL/class`; the emitter would give `pages=` instead |
| `kdpcover.ins` DocStrip driver | kdpcover.ins:4-36 | yes | TeX-only generation of `kdpcover.cls` from the `class` guard (ins:30); not external; an emitter would name the published class instead |
| doc driver `\renewcommand{\RerunFileCheck}[3]{\AddToHook{enddocument/info}{#2}}` | kdpcover.dtx:45 | no lib way; no printed effect | redirects a rerun message to the end-of-document log; documentation driver only, not counted as a blocker (judgement call); the emitter would omit it |
| doc driver `fail-fast` | kdpcover.dtx:39 | no lib way; no printed effect | load-only package (considered, no home; cf. rejected `sys.compat-load` in v4); not the template's look |

## Content-opaque
`cactus.pdf` front picture (kdpcover.dtx:73, 85), the class-shipped artwork `kdpcover-signature.pdf` and `kdpcover-vol-1..4.pdf` (kdpcover.dtx:186, 377-379, 402), `yb-book-logo.pdf` (kdpcover.dtx:60); all are shipped image files, not TeX drawings. The pre-built `kdpcover.pdf` is an output, not source.

## Lib changes
- New ways proposed: none. Considered and not proposed: a separate way for `anyfontsize` (folded into `font.exscale`, as `fix-cm` was in lib v4), `calc` (evaluates to constants), `fail-fast` (no printed effect), `pgfopts` (class-internal option parser).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- CTAN reads (3 of 3): ctan.org/pkg/kdpcover (class, MIT; states `--shell-escape` and `qpdf` are required), ctan.org/pkg/iexec (runs a shell command and inserts its output, MIT; the page is silent on shell escape), ctan.org/pkg/anyfontsize (any `\fontsize`, LPPL 1.2). `docshots` was not read.
