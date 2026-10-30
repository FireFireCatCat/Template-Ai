yes

# 0084-guitartabs: guitartabs (LaTeX class for guitar tablature)

- Unverified: read from the source, not compiled.
- Source: Source/0084-guitartabs/ (origin: https://mirrors.ctan.org/macros/latex/contrib/guitartabs.zip; licence: LPPL 1.3c, README.md:20 and guitartabs.cls:8)
- Kind: misc (a song tab sheet; the main sample is the class's own documentation)
- Lib: v1
- Engine: pdfLaTeX-compatible (no fontspec or Lua; both shipped PDFs carry the producer string pdfTeX-1.40.17, TeX Live 2016; not compiled here)
- Look carried by: mixed (guitartabs.cls defines page, song header and the tab block; the main sample adds a published-package preamble, listings and titling; nothingelsematters.tex adds content only)
- Class origin: ctan (ctan.org/pkg/guitartabs read: path macros/latex/contrib/guitartabs, version 2018-05-01, LPPL 1.3c, author Andrey Babushkin)
- Main file: guitartabs-doc.tex (other samples: nothingelsematters.tex)
- Read: main yes (all 384 lines), zip-local classes and styles all (guitartabs.cls, all 297 lines; it is the CTAN class, not zip-local in the W1 sense). Also read nothingelsematters.tex (221 lines) and README.md. Not read: musixtex, harmony, tikz, intcalc, xifthen sources (published packages).

## Verdict
Yes, with two judgement calls a stricter reader could turn into no. The class is the CTAN release of `guitartabs`, so it is one published class way, `class.guitartabs`, and the zip holds no copied zip-local macro logic. Neither sample contains a drawing or a definition of its own: nothingelsematters.tex is class vocabulary plus content, and guitartabs-doc.tex adds only a titling hook pair, a `\lstset`, a table and kernel commands, all lib ways. Call 1: the staff, bar lines, time signature and note boxes are drawn with TikZ and harmony symbols by the published class's own `tabline` environment (guitartabs.cls:88-290). I treat that as class-native body vocabulary with declarative arguments (bars, time signature, tuning, per-note position, string, fret, length) and the notes as music content (`art.content-package`), as a tikzposter block is a lib way. It is not template-defining artwork authored in the zip, because the samples hold no TikZ. If `class.guitartabs` were refused as a way (W2/W3, fixed TikZ look), this flips to `no` with `ART`/`BESPOKE`. Call 2: the class loads `musixtex` unconditionally (guitartabs.cls:33). CTAN describes musixtex as a three-pass etex, musixflx, etex system for scores, but the class never calls `\startpiece`; it only uses harmony's note and rest symbols, so no external tool is exercised. I did not count it as `EXTERNAL/package` (not compiled, so unconfirmed).

## Blockers
none

## Class setting
- Class: `class.guitartabs` options: none given by either sample. Unknown options pass to article (guitartabs.cls:14-17); article is loaded with `10pt, a4paper` (guitartabs.cls:18). Class loads inputenc[utf8], geometry, xifthen, tikz, musixtex, harmony, intcalc (guitartabs.cls:21-37).
- Class-native vocabulary used: `\artistname`, `\albumtitle`, `\songname` (guitartabs.cls:44-50; nothingelsematters.tex:12-14), `\maketabheader` (guitartabs.cls:56-68; nothingelsematters.tex:17), environment `tabline{bars}{time-upper}{time-lower}{tuning list}` (guitartabs.cls:88; guitartabs-doc.tex:68), inside it `\note{num}{den}{string}{fret}` (guitartabs.cls:125), `\notel{...}{length}` with lengths 1, 2, 2.5, 4, 4.5, 8, 8.5, 16, 16.5, any other value prints `?` (guitartabs.cls:142-163; guitartabs-doc.tex:196-198), `\nextbar` (guitartabs.cls:117), `\restwhole` `\resthalf` `\restquarter` `\resteighth` `\restsixteenth` (guitartabs.cls:171-225; nothingelsematters.tex:211-215). The kernel `\title` `\author` `\date` `\maketitle` of article are kept (guitartabs-doc.tex:12-14,49); `\maketabheader` does not replace them.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | guitartabs-doc.tex:10; nothingelsematters.tex:10; guitartabs.cls:11-18 | `class.guitartabs` | no options; article underneath with 10pt, a4paper |
| paper and point size | guitartabs.cls:18 | `page.class-options` | a4paper, 10pt (fixed in the class) |
| page geometry | guitartabs.cls:24,295; guitartabs-doc.tex:16-17 | `page.geometry` | left=2.0cm, right=2.0cm, top=1.5cm, bottom=1.5cm, footskip=0cm (the doc repeats the class's line) |
| input encoding | guitartabs.cls:21 | `font.fontenc-t1` | inputenc option utf8 only; no fontenc, Computer Modern default |
| header and footer | no `\pagestyle` or `\thispagestyle` in any file (grep) | none (article default `plain`) | footskip=0cm comes from the geometry row |
| song header block | guitartabs.cls:43-68; nothingelsematters.tex:12-14,17 | `front.class-native` | `\artistname`, `\albumtitle`, `\songname` then `\maketabheader`: centred block, song `\LARGE\rmfamily\bfseries`, artist `\normalsize\rmfamily\bfseries`, album `\normalsize\rmfamily\mdseries`, `\vspace{4mm}`, `\hrule`, `\vspace{10mm}` |
| header block composition (inside the class) | guitartabs.cls:56-68 | `sp.ragged`, `font.size-commands`, `sp.rule`, `sp.manual-space` | `center` environment; `\LARGE` `\normalsize` with family/series switches; `\hrule`; `\vspace` 4mm and 10mm |
| title page (doc sample) | guitartabs-doc.tex:12-14,48-50 | `front.maketitle` | `\title{\LaTeX\ Guitar Tabs}`, `\author{Andrey Babushkin}`, `\date{June, 2018}`, `\maketitle` inside `titlingpage` |
| title hooks (doc sample) | guitartabs-doc.tex:42-44,48 | `front.titling` | `\maketitlehooka`={`\null\mbox{}\vfill`}, `\maketitlehookd`={`\vfill\null`}, `titlingpage` environment: title centred vertically |
| vertical fill in hooks | guitartabs-doc.tex:43-44 | `sp.manual-space` | `\vfill` |
| table of contents | guitartabs-doc.tex:53 | `toc.kernel` | `\tableofcontents`, article defaults |
| sectioning | guitartabs-doc.tex:56,96,97,379 | `head.kernel` | `\section`, `\subsection`, article default looks and numbering; no `\renewcommand`, no titlesec |
| page breaks | guitartabs-doc.tex:52,54,123,239,377 | `pg.break` | `\pagebreak` |
| manual spacing | guitartabs-doc.tex:127,149-152,227; nothingelsematters.tex:205 | `sp.manual-space` | `\vspace{0.5cm}`, `\hspace*{1cm}`, `\vspace{2cm}` |
| command table | guitartabs-doc.tex:129-225 | `tbl.tabular` | column spec `\|p{4cm}\|p{5cm}\|p{7cm}\|`, `\hline` after every row |
| multi-line table cells | guitartabs-doc.tex:147-216 | `box.minipage` | `\parbox[t]{4cm}` and `\parbox[t]{7cm}` with `\\` and `\hspace*{1cm}` |
| inline marks | guitartabs-doc.tex:99,131,135-224,381 | `mark.kernel` | `\textbf`, `\textit`, `\textbackslash` |
| code listings | guitartabs-doc.tex:19-40,100,107,114,121,275,309,312 | `code.listings` | `\lstset{keepspaces=false, numbers=left, language=[LaTeX]TeX, basicstyle=\tt\scriptsize, keywordstyle=\color{blue}, identifierstyle=\color{magenta}, morekeywords={*,artistname,albumtitle,songname,maketabheader,note,notel,restwhole,resthalf,restquarter,resteighth,restsixteenth}}`; `lstlisting` with `[firstnumber=1,2,5]`; `\lstinline` |
| listing font size | guitartabs-doc.tex:24 | `font.size-commands` | `\scriptsize` inside `basicstyle` |
| listing colours | guitartabs-doc.tex:25-26 | `color.xcolor` | named colours blue, magenta via `\color`; no colour package is loaded in the source, so it is implicit (tikz at guitartabs.cls:30; its source not read) |
| tab block (the song) | guitartabs.cls:88-290; guitartabs-doc.tex:68-94,231-235,244-271,345-373; nothingelsematters.tex:21-218 | `class.guitartabs` (native `tabline`), content category `art.content-package` | `tabline{3}{6}{8}{E,A,D,G,B,E}` and `{1}{4}{4}{...}`, `{1}{}{}{...}` (empty time signature, nothingelsematters.tex:209); notes `\note`/`\notel`, rests, `\nextbar`; staff look fixed in the class (see Bespoke code) |

Not present in either sample: abstract, lists, quotes, notes, footnotes, math, theorems, figures, captions, bibliography, index, cross-references, hyperref, language packages.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `guitartabs.cls` as a whole | guitartabs.cls:1-295 | not bespoke: published on CTAN (W1) | one way, `class.guitartabs`; the zip is the CTAN release (manifest url), `\ProvidesClass` 2018/05/01 (guitartabs.cls:11) matches the CTAN version |
| `tabline` environment, `\note`, `\notel`, rests, `\nextbar`, counters `tabstrings` `tabbars` `tabcstring` `tabcbar` `tabcn` `tabcdn` `flag` | guitartabs.cls:74-290 | the published class's own code; would be irreducible BESPOKE/class if the class were zip-local | `pgfmathsetlengthmacro` position arithmetic over `\textwidth - 1.4cm` (guitartabs.cls:126-133,172-179,189-196,284), `\foreach` string and bar loops (233,256,276,283), an `\ifthenelse{\lengthtest{...}}` chain mapping length values to harmony glyphs `\Ganz \Halb \Vier \Acht \Sech` rotated 180 degrees and dotted variants (145-163), tikzpicture with `note/.style={rectangle,fill=white,scale=0.7}` and `cm={0,-0.3,1,0,(0,0)}` (248-250), time signature font 1cm bold (267,272), tuning label font 0.2cm (259). Not decomposed further: it is inside the published way |
| `\artistname`, `\albumtitle`, `\songname`, `\maketabheader` | guitartabs.cls:44-68 | yes (even if the class were local) | three stored strings, then `sp.ragged` + `font.size-commands` + `sp.rule` + `sp.manual-space` |
| `\renewcommand\maketitlehooka`, `\maketitlehookd` | guitartabs-doc.tex:43-44 | yes | `front.titling` hooks holding `\null\mbox{}\vfill` and `\vfill\null` |
| `\lstset{...}` | guitartabs-doc.tex:20-40 | yes | `code.listings` parameters, listed in the table |
| `\geometry{...}` | guitartabs-doc.tex:17 | yes | `page.geometry`, a repeat of guitartabs.cls:295 |
| nothingelsematters.tex | whole file | nothing defined | class vocabulary and content only |

Note on dependencies, unconfirmed: `\rotatebox` (guitartabs.cls:146-162) needs graphicx, which the class does not load itself; I assume tikz/pgfcore supplies it (not read). Note on text aimed at an AI: none found in README.md, the class or the samples.

## Content-opaque
- Tablature note data and the staff drawn by the class (music notation, category `art.content-package`): nothingelsematters.tex:21-218; guitartabs-doc.tex:68-94,231-235,244-271,345-373. Positions, strings, frets and lengths are data; the staff drawing is the published class's TikZ, not TikZ in the sample.
- Missing assets: the musix fonts (`musix13`, per the harmony CTAN page) must be installed; they ship with TeX Live, none are in the zip.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
