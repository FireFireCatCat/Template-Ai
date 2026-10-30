yes

# 0616-llncsconf: llncsconf (paper-status notes and PDF crop box for Springer's llncs class)

- Unverified: read from the source, not compiled.
- Source: Source/0616-llncsconf/ (origin: https://mirrors.ctan.org/macros/latex/contrib/llncsconf.zip; licence: lppl1.3c per the manifest, and llncsconf.sty:1-11 says LPPL-1.3c+ OR BSD-2-Clause)
- Kind: conference (the manifest hint says journal; the sample is an LNCS conference paper)
- Lib: v5
- Engine: pdfLaTeX-compatible (the sample passes `pdftex` at example/example.tex:1; the crop branch uses `\pdfpagesattr` or, on newer kernels, expl3 `\pdfmanagement_add:nnn`, llncsconf.sty:52-64)
- Look carried by: mixed (the page, running heads, title block, abstract and headings come from the published class `llncs`, which is not in the zip; the package `llncsconf.sty` in the zip is the CTAN release v1.2.0 and adds the paper-status footers, the PDF crop box and the hyperref setup; the sample preamble adds only `lipsum` and three string commands)
- Class origin: tex-distribution-unbundled (llncs.cls is not in the zip; ctan.org/pkg/llncs: Springer's official class, in TeX Live and MiKTeX; `llncsconf.sty` is a package, not a class, and ctan.org/pkg/llncsconf shows it on CTAN, v1.2.0, LPPL 1.3c, A. D. Brucker, in TeX Live)
- Main file: example/example.tex (other samples: none; the ten example/example_*.pdf files are compiled outputs and were not read)
- Read: main yes, zip-local classes and styles all (llncsconf.sty read in full, 214 lines; no .cls in the zip, so llncs.cls source was not read)

## Verdict
yes. The look of the sample is the published class `llncs` plus the published CTAN package `llncsconf`; the sample's preamble defines no macro and no environment (example/example.tex:1-14). `llncsconf.sty` is the CTAN release (llncsconf.sty:13-15, CHANGELOG.md:8, README.md:7-9, origin URL on mirrors.ctan.org), so it is published (W1) and chosen by options and strings (W2), serves any LNCS paper (W3) and prints as one `\usepackage` line plus three one-argument commands (W4). It is proposed as `class.llncsconf`. Its internals (hand-laid `\ps@` footers, `\maketitle` wrappers, expl3 CropBox) are published code, not bespoke code of this zip; if the lib maintainers reject the way, those internals would have to be judged again (see Bespoke code). The `rcsinfo` and `svninfo` options need RCS or Subversion keyword expansion from outside TeX (llncsconf.sty:146-166); that is EXTERNAL only when selected, and the sample selects no option (example/example.tex:3).

## Blockers
none

## Class setting
- Class: `class.llncs` options: `final`, `runningheads`, `USenglish`, `pdftex` (example/example.tex:1). llncs.cls is not in the zip, so which of these it consumes itself is not established; options it does not consume reach the packages as global options (`pdftex` is a driver option of the `hyperref` that llncsconf loads, llncsconf.sty:18).
- Class-native vocabulary used: `\title` (example/example.tex:9), `\author` (:11), `\institute` (:12), `\maketitle{}` (:16), `abstract` environment after `\maketitle` (:17-19), `\section` (:21, :24, :27). Class internals that llncsconf.sty reads or provides: `\toc@uthor` (llncsconf.sty:47), `\@author` and `\@title` (:204-205), `\toclevel@title` and `\toclevel@author` (:210-211, only provided when missing), `\clearheadinfo` (:199).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example/example.tex:1 | `class.llncs` | final, runningheads, USenglish, pdftex (llncs.cls source not read) |
| page size and text block | example/example.tex:1 | `page.class-options` | none selected (no `a4paper`, no geometry call); the LNCS block is the class default (not read); llncsconf only reads `a4paper` to pick the crop box (llncsconf.sty:53, :59) |
| running heads | example/example.tex:1 | `hf.class-native` | `runningheads` |
| paper-state footer notes | llncsconf.sty:33-37, :98-143, :167-196; README.md:34-49 | `class.llncsconf` | state options `accepted` `submitted` `intended` `llncs` `proceedings` (none selected, example/example.tex:3); strings `\conference{name}` (example/example.tex:5), `\llncs{book info}{start page}` (:6-7), `\llncsdoi{doi}` (:8, default UNKNOWN at llncsconf.sty:44), redefinable `\copyrightnote` (llncsconf.sty:47) |
| PDF crop box to the 152x235 mm LNCS page | llncsconf.sty:26, :29-30, :49-67; README.md:25-28 | `class.llncsconf` | option `crop` or `nocrop`; CropBox [92 65 523 731] (:56) or [92 62 523 731] (:62), and an a4paper variant [92 114 523 780] (:54, :60) |
| revision-info stamp | llncsconf.sty:31-32, :72-96, :145-166; README.md:29-32 | `class.llncsconf` | options `rcsinfo` `svninfo`; loads the CTAN packages `rcsinfo` and `svninfo` (not read) |
| svninfo stamp overlay | llncsconf.sty:156-161 | `bg.eso-pic` | `\AddToShipoutPicture` with `\unitlength=1mm` and one `\put(38,28){\tiny ...}` text stamp; text only, no drawing, and only when `svninfo` is selected |
| page-style switching | llncsconf.sty:148, :150, :175, :177, :182, :184, :190 | `hf.pagestyle-kernel` | `\pagestyle{rcsinfo,intended,submitted}` and `\thispagestyle{<state>first}` after `\maketitle` |
| footer type | llncsconf.sty:73-76, :131-135 | `font.size-commands` | `\reset@font\scriptsize`, `\small` in the rcs/svn lines |
| footer emphasis and sans | llncsconf.sty:75, :107 | `mark.kernel` | `\textsf`, `\emph` |
| first page number | llncsconf.sty:43; example/example.tex:6-7 | `pgnum.pagenumbering` | `\setcounter{page}{#2}` only when option `llncs` or `proceedings` is on (page 0042 in the sample, not applied because no option) |
| last-page reference | llncsconf.sty:41, :134, :142 | `xref.kernel` | `\AtEndDocument{\label{LastPage}}` read back by `\pageref{LastPage}` in the footers; the `\label{LastPage}` at example/example.tex:29 is a comment |
| hyperref setup | llncsconf.sty:18, :200-206 | `meta.hyperref` | loaded unconditionally; draft=false, bookmarksopen=true, bookmarksnumbered=true, pdfauthor={\@author}, pdftitle={\@title} |
| contents depth | llncsconf.sty:198 | `num.secnumdepth` | `\setcounter{tocdepth}{2}` (the sample has no contents list) |
| title block | example/example.tex:9, :11-12, :16 | `front.class-native` | `\title{...}`, `\author{...}`, `\institute{Some Department, Somewhere}`, `\maketitle{}` |
| inline marks in title and book info | example/example.tex:6-7, :9 | `mark.kernel` | `\texttt`, `\emph`, `\LaTeX` |
| link inside the author | example/example.tex:11 | `xref.hyperref` | `\protect\href{http://www.brucker.ch/}{Achim D. Brucker}` |
| abstract | example/example.tex:17-19 | `abs.class-native` | llncs `abstract` environment, text only |
| headings | example/example.tex:21, :24, :27 | `head.class-native` | three `\section`, llncs default numbering and looks |
| filler text | example/example.tex:2, :18, :22, :25, :28 | `draft.todo` | `\usepackage{lipsum}`, `\lipsum[1-2]`, `[1-4]`, `[5-10]`, `[10-12]` (filler content) |

Not in the sample and not defined by the zip: floats, tables, captions, theorems, code, boxes, lists, bibliography, index, footnotes, fonts and colour beyond the class defaults.

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `llncsconf.sty` as a whole (booleans, `\DeclareOption`s, `\ps@...` page styles, `\maketitle` wrappers, expl3 crop code) | llncsconf.sty:1-214 | not bespoke: published CTAN package | one way, `class.llncsconf`; the emitter writes `\usepackage[<one state option>,crop]{llncsconf}` plus `\conference`, `\llncs`, `\llncsdoi` |
| `\conference` `\llncs` `\llncsdoi` `\copyrightnote` | llncsconf.sty:42-47 | published commands of that package | strings and a page number; `\copyrightnote` is optional and unused by the sample |
| hand-laid footers `\def\ps@<state>{...\vbox to\z@{\vss ...}}` | llncsconf.sty:72-143 | published code inside the package, so not counted as bespoke | if the way were rejected, these footers would need a `hf.fancyhdr` rewrite that has not been written here |
| `\let\old@mkttl=\maketitle` / `\def\maketitle{\old@mkttl\thispagestyle{..}}` wrappers | llncsconf.sty:149-150, :169-170, :176-177, :183-184, :189-190, :194-195 | published code inside the package | the shared name `\old@mkttl` means two of the wrapper options stacked would recurse (reading of the code, not tested), so the state options are one-at-a-time, which is how README.md:63-69 lists them |
| macros in the sample | example/example.tex:1-30 | none defined | the sample has no `\newcommand`, `\def` or environment |

## Content-opaque
none (the `lipsum` paragraphs are filler content held by `draft.todo`; the sample has no figure or table)

## Lib changes
- New ways proposed: `class.llncsconf` `llncsconf` (CTAN, TeX Live, MiKTeX, LPPL 1.3c, A. D. Brucker, v1.2.0 of 2022-04-24; ctan.org/pkg/llncsconf read), pdfTeX. `\usepackage[crop,accepted|submitted|intended|llncs|proceedings,rcsinfo,svninfo]{llncsconf}` plus `\conference{}`, `\llncs{}{page}`, `\llncsdoi{}`; it prints a paper-state or self-archiving note in the foot area (every page or the first page) and sets the PDF CropBox to the LNCS page. W1: CTAN package, the origin of this zip. W2: booleans and strings (one state option at a time). W3: serves any LNCS contribution, not one document. W4: one preamble line and three one-argument commands. A type sibling of `front.authorarchive` (a notice at the foot of the first page) and `hf.turnthepage` (a footer note); kept apart because those lines name other packages and keys, and the consolidator may fold them into one line with the package as the parameter.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
