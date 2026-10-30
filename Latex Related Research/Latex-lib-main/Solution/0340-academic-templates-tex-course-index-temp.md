yes

# 0340-academic-templates-tex-course-index-temp: LaTeX Course Index Template (academic-templates/tex-course-index-template)

- Unverified: read from the source, not compiled.
- Source: Source/0340-academic-templates-tex-course-index-temp/ (origin: https://codeload.github.com/academic-templates/tex-course-index-template/zip/refs/heads/main; licence: CC-BY-4.0)
- Kind: misc (a two-column course index; none of the listed kinds fits)
- Lib: v3
- Engine: pdfLaTeX-compatible (build comment names `pdflatex`, src/main.tex:6; no fontspec, no Lua)
- Look carried by: mixed (the preamble of `src/main.tex` plus the zip-local makeindex style `src/lib/std.ist`; there is no zip-local class or package)
- Class origin: tex-distribution-unbundled
- Main file: src/main.tex (other samples: none; `examples/sans/*.idx` are 15 more index data files for the same template, `examples/ulb/info-y114.pdf` is a PDF only)
- Read: main yes, zip-local classes and styles none present (no .cls/.sty/.def; `src/lib/std.ist` and `src/data.tex` read fully; `tool/tex-index-importer.py` read partly, lines 1-175 of 318, and it is not part of the build)

## Verdict
Yes. The document is `article` plus a short preamble: `vmargin` margins, a `fancyhdr` header and footer, `ragged2e`, `graphicx` icon aliases, a licence notice made of two stacked lines beside an image, and one `\printindex` whose layout comes from a redefined `theindex` (two `multicols`) and a declarative makeindex style file `lib/std.ist`. Every component maps to a lib way and every zip-local macro reduces by alias or call-site expansion; there is no drawing and no output-routine code. Two judgement calls are stated under "Bespoke code": the `\rate` star loop (a counter loop whose output is only repeated `$\star$`) and the makeindex step on a hand-written `.idx`. If a stricter reading counts `\rate` as counter-driven printing, the verdict would flip to `no` for that item alone.

## Blockers
none

(Recorded, not blockers: `\printindex` needs `makeindex` run on the hand-written `main.idx` before LaTeX, src/main.tex:4-8, README.md:36; this is the TeX Live index tool behind `idx.makeidx`, as BibTeX is behind `bib.bibtex-bst`, not a preprocessor that produces `.tex`. `tool/tex-index-importer.py` is an optional OCR importer that writes `.idx` lines (tool/tex-index-importer.py:6-12, 153-165); README.md:18-23 and 36 do not list it as a build step, so it is authoring help, not part of the output.)

## Class setting
- Class: `class.article` options: `a4paper`, `10pt` (src/main.tex:9). Kernel class, not bundled in the zip, source not read.
- Class-native vocabulary used: `\title` `\author` `\date` set but `\maketitle` is never called (src/main.tex:82-84; the whole body is lines 105-109), `\pagestyle`, `\thispagestyle`, kernel `theindex` environment (redefined, src/main.tex:92-101), `\printindex` from `makeidx`. No `abstract`, no sectioning, no lists, no floats, no theorems.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | src/main.tex:9 | `class.article` | a4paper, 10pt |
| paper and base size | src/main.tex:9 | `page.class-options` | a4paper, 10pt |
| page geometry | src/main.tex:13, 19-24 | `page.vmargin` | `\setmarginsrb{1.5cm}{.8cm}{1.5cm}{1cm}{1.2cm}{0.5cm}{1.2cm}{1cm}`: left 1.5cm, top 0.8cm, right 1.5cm, bottom 1cm, head height 1.2cm, head-to-text 0.5cm, foot height 1.2cm, text-to-foot 1cm (order from the comment at 20-23) |
| ragged text | src/main.tex:17 | `sp.ragged` | `ragged2e` option `document` (whole document ragged-right) |
| running head | src/main.tex:85-86 | `hf.fancyhdr` | `\fancyhf{}` then `\fancyhead[C]{\LARGE\textbf{\coursetitle}}`; default head rule |
| head font | src/main.tex:86 | `font.size-commands`, `mark.kernel` | `\LARGE`, `\textbf` |
| running foot | src/main.tex:87-89 | `hf.fancyhdr` | L: licence image; C: `\thepage` (arabic, no `\pagenumbering`); R: `\scriptsize\coursedate\\\courseversion` |
| foot nudge, line break, size | src/main.tex:87, 89 | `sp.manual-space`, `font.size-commands` | `\vskip-7pt`, `\\`, `\scriptsize` |
| page style on | src/main.tex:90 | `hf.fancyhdr` | `\pagestyle{fancy}` |
| first index page keeps the head/foot | src/main.tex:97, 102 | `hf.pagestyle-kernel`, `hf.fancyhdr` | `\thispagestyle{plain}` plus `\let\ps@plain\ps@fancy` (plain made equal to fancy) |
| title metadata only | src/main.tex:82-84 | `front.maketitle` | `\title{\coursetitle}`, `\date{\coursedate}`, `\author` only if `\indexauthor` is defined; never printed (no `\maketitle`) |
| licence notice at top of page 1 | src/main.tex:105-108 | `box.minipage`, `fig.graphicx`, `sp.manual-space`, `font.size-commands`, `sp.ragged`, `meta.url` | cc image (height 16pt) + `\hskip10pt` + a `\vbox` of two `\hbox` lines, `\scriptsize\raggedright`, `\url{...}`, then `\vskip20pt`; hand-laid (`front.doclicense` considered, not used) |
| hyperlinks | src/main.tex:18 | `meta.hyperref` | option `hidelinks` |
| index printing | src/main.tex:12, 109 | `idx.makeidx` | `makeidx` package, `\printindex`; no `\makeindex` in the file, so LaTeX does not overwrite the hand-written `main.idx` |
| index style file | src/lib/std.ist:1-11 | `idx.makeidx` | makeindex style keys: `headings_flag 1`, `heading_prefix`, `heading_suffix`, `delim_0/1/2`, `delim_r "-"`, `group_skip`, `line_max 60`, `symhead_positive "Topics"`, `numhead_positive "Categories"` |
| index group heading look | src/lib/std.ist:2-3 | `idx.makeidx`, `sp.ragged`, `font.size-commands`, `mark.kernel` | prefix `\centerline{\textbf{\LARGE{`, suffix `}}}}` then `\indexspace` |
| dotted leader to page numbers | src/lib/std.ist:4-6 | `sp.rule` | `\dotfill` for the three delimiters |
| index columns | src/main.tex:11, 93-94, 100-101 | `cols.multicol` | `multicols{2}`, `\columnseprule` 0cm, `\columnsep` 1cm |
| index paragraph lengths | src/main.tex:95-96 | `sp.lengths` | `\parindent` 0cm, `\parskip` 0cm |
| index item macro | src/main.tex:98 | `idx.makeidx` | `\let\item\@idxitem` (the kernel's own index item, as in article's `theindex`) |
| page break inside the index | src/main.idx:8, 75; README.md:113-117 | `pg.break` | `\newpage` placed in a page encapsulator |
| icon images | src/main.tex:16, 37-70 | `fig.graphicx` | `\DeclareGraphicsExtensions{.png}`; `\icon{name}` and ~30 aliases `\includegraphics[height=8pt]{lib/<file>}` (6pt for `\coin`, `\q`; 9pt for `\all`) |
| licence badges | src/main.tex:72-74, 87 | `fig.graphicx` | `\cc`, `\ccby`, `\ccbysa`: `\includegraphics[height=16pt]` |
| inline command text | src/main.tex:76-79 | `mark.kernel`, `font.size-commands` | `\textbackslash`; `\texttt{\normalsize #1}`, `\texttt{\small #1}`, `\texttt{\footnotesize #1}` |
| inline symbols | src/main.tex:35, 80 | `math.kernel` | `$\star$`, `$\to$` (kernel math symbols in inline maths) |
| blank index line | src/main.tex:31 | `sp.manual-space` | `\hspace{\linewidth}` |
| course data strings | src/data.tex:1-4; src/main.tex:26 | none needed (text strings, content) | `\coursecode`, `\coursetitle`, `\coursedate`, `\courseversion` set by `\def`, read by `\input{data.tex}` |
| index entries | src/main.idx:34-106 | `idx.makeidx` (data file) | `\indexentry{sortkey@text!sub@text|encap}{pages}` lines with literal page strings |
| fonts | (no font package loaded) | none | kernel Computer Modern defaults |

Not used by the sample: sectioning, lists, quotes, notes, maths environments, theorems, floats, tables, captions, code, bibliography, glossary.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\comment{}` empty macro; used as a page encapsulator to discard the page number `{0}` | src/main.tex:28; src/main.idx:36 | yes | alias of nothing (`\newcommand{\comment}[1]{}`); or drop those entries; the entry text itself is content |
| `\contextnotesize` = `\scriptsize` | src/main.tex:29 | yes | alias of `font.size-commands`; not called in src/main.idx (only defined) |
| `\blankline` = `\hspace{\linewidth}` | src/main.tex:31 | yes | alias of `sp.manual-space` |
| `\book{x}{y}` = `\coursecode.#1--#2`; `\lab{x}` = `L#1` | src/main.tex:32-33 | yes | text templates (content strings); an emitter writes the text into each entry |
| `\newcounter{i}` + `\rate{n}` via `forloop` | src/main.tex:15, 34-35 | yes, by expansion (judgement call) | whole effect is `n` copies of `$\star$` (`math.kernel`); the emitter writes `$\star$` repeated at each call site and needs neither the counter nor `forloop`. Defined but not called in src/main.idx (only in comment lines 15-16, 25); called 106 times in `examples/sans/*.idx`. The loop is a hand-rolled counter, so a strict reader could class it BESPOKE/preamble; it prints nothing but repeated content glyphs |
| icon aliases `\icon` `\linux` `\win` ... `\ccbysa` | src/main.tex:38-74 | yes | each is `\includegraphics[height=Npt]{lib/<file>}` (`fig.graphicx`); 38 PNGs in src/lib/ are shipped assets |
| `\bs` `\cmd` `\cmds` `\cmdxs` `\goto` | src/main.tex:76-80 | yes | aliases of `mark.kernel`, `font.size-commands`, `math.kernel` |
| `\def` course strings in data.tex | src/data.tex:1-4 | yes | string variables, content (title `C123 -- Course Title`, date `05/2018`, empty version) |
| `\ifdefined\indexauthor` choosing `\author` and ", by ..." in the licence line | src/main.tex:82, 106 | yes | presence test on a data string; the emitter decides at emit time. `\indexauthor` is defined nowhere in this zip, so the branch is off here |
| `\renewenvironment{theindex}` (multicols, lengths, `\thispagestyle{plain}`, `\let\item\@idxitem`) | src/main.tex:91-101 | yes | same skeleton as the kernel `theindex`, with `multicols` in place of `\twocolumn`: `cols.multicol` + `sp.lengths` + `hf.pagestyle-kernel`; `\@idxitem` is the kernel's own item. The emitter can write this block unchanged (composition only), or set columns and column separation through `imakeidx` options (not read here, to be checked against its docs). No output routine or box algorithm |
| `\let\ps@plain\ps@fancy` | src/main.tex:102 | yes | `hf.fancyhdr` documented route `\fancypagestyle{plain}{}` (plain page style takes the fancy fields); same intent, not compiled |
| licence notice with `\vbox` and `\hbox` | src/main.tex:105-107 | yes | `box.minipage` (`\parbox` of two unbreakable lines) + `fig.graphicx` + `sp.manual-space`; the two lines are fixed strings |
| unused `\usepackage{pdfescape}` | src/main.tex:14 | yes (nothing to reduce) | no command of it is called anywhere in src/main.tex (grep: one hit, the load line); it has no effect on output and can be omitted |
| `lib/std.ist` makeindex style | src/lib/std.ist:1-11 | yes | declarative key-value strings, integers and a heading-name pair; a parameter of `idx.makeidx` as a `.bst` is of `bib.bibtex-bst`. The three strings carry LaTeX (`\centerline`, `\textbf`, `\LARGE`, `\dotfill`, `\indexspace`) that are kernel commands |
| `tool/tex-index-importer.py` | tool/tex-index-importer.py:6-12 | not needed | OCR to `.idx` authoring helper (pyocr, tinyscript: tool/requirements.txt:1-2); not in the compile path, not template look |

Unbalanced group (note, no effect on the map): the opening `{` at src/main.tex:105 is never closed (the `}` at line 107 closes the `\vbox`), so `\vskip20pt` and `\printindex` run inside it; the zip ships a compiled `src/main.pdf`, which suggests it still builds, not checked here.

## Content-opaque
- `src/main.idx:34-106` hand-authored `\indexentry` lines (text, sort keys such as `1a@`, `20@`, `100@`, nested `!` levels, literal page ranges like `{1-10}`, and encapsulators `|book{1}`, `|comment`, `|newpage \comment` that run macros on the page number). The 15 files `examples/sans/*.idx` are the same kind of data. Page strings are typed, not computed, so an emitter writes a data file, not `\index` calls. Content, not template.
- `src/lib/*.png` (38 icon bitmaps) used inline in entries: assets to ship, not drawn artwork. No TikZ, PGF, PSTricks or `picture` anywhere in the zip.
- Stale references: README.md:155 lists `\w`, main.idx:25 mentions `\rank`, and `examples/sans/sec504.idx:565` uses `\ukey`; none is defined in src/main.tex. Content-level, outside the template.

## Lib changes
- New ways proposed: none (considered: `front.doclicense` for the licence line, which is hand-laid here, and `imakeidx` inside `idx.makeidx`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
