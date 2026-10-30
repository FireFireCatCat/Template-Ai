yes

# 0610-hletter: hletter (letter class with user-defined letterhead keywords, v4.2)

- Unverified: read from the source, not compiled.
- Source: Source/0610-hletter/ (origin: https://mirrors.ctan.org/macros/latex/contrib/hletter.zip; licence: lppl1.2 per manifest, LPPL 1.2 or later per hletter.cls:6-8; mergeh.sty carries no licence line, it derives from McKinstry's `merge`, mergeh.sty:1-17)
- Kind: letter
- Lib: v5
- Engine: pdfLaTeX-compatible (Helvetica through `OT1`/`phv` fixed fonts, hsetup.sty:92-94; `.jpg` logos are used, the `.eps` copies are not needed)
- Look carried by: mixed (hletter.cls and hsetup.sty draw the layout; the zip-local `.clo` config files hold the letterhead values)
- Class origin: ctan
- Main file: Testletter1.tex (other samples: Testletter2.tex, Testletter3.tex, Testmerge.tex, Testheader.tex, which is the manifest's main file and is a header-only test under `article`)
- Read: main yes, zip-local classes and styles all (`Hletter.pdf`, the manual, was not read; the `.eps`/`.jpg` files are assets)

## Verdict
yes. The look is carried by `hletter`, a published class (CTAN macros/latex/contrib/hletter, also in TeX Live and MiKTeX, LPPL 1.2; read at ctan.org/pkg/hletter), so `class.hletter` plus the kernel letter commands is the way. The zip adds only `.clo` config files made of class-native setters (strings, lengths, file names, an option number) and `mergeh.sty`, which ships in the same CTAN bundle (README:10) and is used by one sample. The letterhead is drawn with a `picture` environment inside the published class (hsetup.sty:149-228); the template supplies only strings, lengths and file names to it, so it reduces to the class's declarative setters and is not counted as ART. The only component with no lib home is the mail merge, proposed as `ltr.formlett`. The `yes` rests on treating the published class and its bundled `mergeh.sty` as W1: the same picture, box and `\read` code would be irreducible if it were zip-local.

## Blockers
none

## Class setting
- Class: `class.hletter` options: `10pt`/`11pt`/`12pt` and any other option are passed on to `letter` (hsetup.sty:62); language `english` `german` `french` (hsetup.sty:58-60); `draft` (hsetup.sty:61); letterhead variants `private` `signit` `bruni` `test` declared by the user in hdefine.clo:25-28 through the class's `\newoption{name}{number}` (hsetup.sty:32). Samples: `[11pt,french,bruni]` (Testletter1.tex:6), `[10pt,english]` (Testletter2.tex:1), `[10pt,private]` (Testletter3.tex:1), `[12pt,english,signit]` (Testmerge.tex:2).
- Base class: `class.letter`, loaded with `a4paper` by the class (hsetup.sty:64); its `letter` environment, `\opening`, `\closing`, `\signature`, `\address`, `\cc`, `\encl` are inherited and partly redefined (hletter.cls:71-123).
- Header-only entry: package `hhead` (hhead.sty:23) under `class.article` (Testheader.tex:2, 8). It loads the same hsetup.sty (hhead.sty:36), so it is recorded in the `class.hletter` vocabulary (a package of one class bundle), with `\heading[text]`, `\barlength`, `\border`.
- Class-native vocabulary used: `\signature{..}` (Testletter1.tex:15), `\reference{..}` (hletter.cls:125; Testletter1.tex:17), `\date{..}` (Testletter1.tex:19), `letter` environment with the address argument (Testletter1.tex:21), `\opening[top-right text]{salutation}` (hletter.cls:90; Testletter1.tex:27), `\closing{..}` (hletter.cls:102), `\closingtwo{..}` with two signees separated by `&` (hletter.cls:117; Testletter2.tex:6, 80), `\cc{..}` `\encl{..}` (Testletter1.tex:133, 135), `\sign[height]{file}` (hletter.cls:59; Testmerge.tex:19), `\logo[height]{file}` (hsetup.sty:31), `\border[pos]{height}{file}` (hsetup.sty:37), `\barlength{len}` (hhead.sty:32), `\centrepos{len}` (hsetup.sty:34), `\addressA..C`, `\extraA..C`, `\centreA..F`, `\bottomL`/`\bottomC`/`\bottomR` (hsetup.sty:96-110), `\heading` (hhead.sty:41-43), merge: `\usepackage{mergeh}` and `merge` environment (Testmerge.tex:5, 23).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | Testletter1.tex:6 | `class.hletter` | 11pt, french, bruni; see Class setting for the other samples |
| base letter class | hsetup.sty:64 | `class.letter` | `\LoadClass[a4paper]{letter}`; unknown options forwarded (hsetup.sty:62) |
| header-only test class | Testheader.tex:2 | `class.article` | 11pt, a4paper, twocolumn; with package `hhead[german,bruni]` (Testheader.tex:8) |
| paper and type size | hsetup.sty:64; Testletter1.tex:6 | `page.class-options` | a4paper fixed by the class; 10pt, 11pt or 12pt chosen by the sample |
| columns | Testheader.tex:2 | `cols.twocolumn-option` | twocolumn |
| full-width head over columns | hhead.sty:42 | `cols.twocolumn-cmd` | `\twocolumn[\dohead{..}..]`, package-internal, used only when `twocolumn` is on |
| column rule | Testheader.tex:19 | `sp.lengths` | `\columnseprule`=.4pt |
| page margins (class-internal) | hletter.cls:63-68 | `page.setlength` | `\headsep`=25pt, `\topmargin`=12pt, `\textwidth`+30pt, `\oddsidemargin` and `\evensidemargin` -15pt |
| bottom flush | hletter.cls:69 | `pg.flush` | `\raggedbottom` |
| paragraph shape (class-internal) | hletter.cls:65; hsetup.sty:53, 57, 74, 65 | `sp.lengths` | `\parskip`=0pt plus 1pt, `\parindent`=1.5em (`\pindt`), `\overfullrule`=5pt under `draft` |
| interline penalty (class-internal) | hletter.cls:78 | `sp.penalties` | `\interlinepenalty`=200 |
| baseline reset around the head (class-internal) | hsetup.sty:120-121, 232 | `sp.linespread` | `\baselinestretch`=1.0 while the head is set, then restored |
| page breaks per letter (class-internal) | hletter.cls:72, 80; hsetup.sty:117 | `pg.break` | `\newpage`, `\pagebreak`, `\cleardoublepage` |
| page style | hsetup.sty:117; hletter.cls:115 | `hf.pagestyle-kernel` | `\thispagestyle{empty}` on the head page and on the closing page |
| page counter | hletter.cls:76; hhead.sty:43 | `pgnum.pagenumbering` | page counter reset to 1 per letter; `\setcounter{page}{1}` after `\heading` |
| letterhead (logo, right block, centre block, rule, window address, fold marks) | hsetup.sty:117-233 | `front.class-native` | `\logo[24mm]{GCCS}` (hdefine.clo:23), `\addressA..C` `\extraA..C`, `\centreA..F`, `\centrepos`, `\border`, `\barlength`; picture-drawn inside the class, 94mm x 44mm address window with warnings (hsetup.sty:213-221) |
| header-only block | Testheader.tex:21, 129; hhead.sty:41-43 | `front.class-native` | `\heading[\textsc{confidential}]`, bar of `\barlength{\textwidth}` (Testheader.tex:15) |
| first-page foot line | hsetup.sty:197-199; hlete.clo:34-35, 71-73 | `hf.class-native` | `\bottomL` `\bottomC` `\bottomR` strings, set at the bottom of the head picture |
| subject line | Testletter1.tex:17; hletter.cls:94-99 | `front.class-native` | `\reference{text}`: centred bold below the salutation for English, above it for German and French |
| recipient address | Testletter1.tex:21-24; hsetup.sty:80-82, 224 | `ltr.opening` | `letter{address}` argument set in an `@{}l@{}` tabular and placed in the window |
| sender block of a private letter | hlete.clo:38-44; Testletter3.tex:1 | `ltr.opening` | kernel `\address{..}` set top left (hsetup.sty:200-204) |
| date | Testletter1.tex:19; hsetup.sty:230 | `ltr.opening` | `\date{..}` printed right-aligned by `\hfill\@date` |
| top-right text | Testletter1.tex:27; hsetup.sty:159 | `ltr.opening` | optional argument of `\opening`; the line that prints it is commented out in this version |
| salutation | Testletter1.tex:27; hletter.cls:90-99 | `ltr.opening` | `\opening{..}`, set with `\noindent`, then a `\smallskip` or `\medskip` |
| closing and signature | Testletter1.tex:15, 130; hletter.cls:102-115 | `ltr.opening` | `\signature{..}`, `\closing{..}`, signature image from `\sign[height]{file}` (Testmerge.tex:19; set by the `bruni` French case at hletf.clo:88) |
| two signees | Testletter2.tex:6, 80; hletter.cls:117-123 | `ltr.opening` | `\closingtwo{..}`, tabular `@{}c@{\hspace{8\tabcolsep}}c@{}` with 15mm gap |
| copies and enclosures | Testletter1.tex:133, 135; hsetup.sty:71-72 | `ltr.opening` | `\cc{..\\..}`, `\encl{..\\..}`; French names `\enclname`=en annexe, `\ccname`=copie à |
| language | hsetup.sty:67-72; Testletter1.tex:6 | `lang.babel` | babel with three languages, the chosen one last (`british` selected at begin document for English, hsetup.sty:68) |
| letterhead fonts | hsetup.sty:91-94; hlete.clo:76-77 | `font.nfss` | `\DeclareFixedFont` `\newfa` phv bx n 10pt, `\newfb` phv bx n 8pt, `\newfc` phv m n 8pt; `bruni` sets phv m n 12pt and phv m sl 10pt |
| sizes in head and private address | hsetup.sty:121; hlete.clo:41-44 | `font.size-commands` | `\small`, `\normalsize` |
| logo and signature images | hsetup.sty:170; hletter.cls:106-107 | `fig.graphicx` | `\includegraphics[height=\logoheight]{\logoname}`, `[height=\signatureheight]{\signatureimage}`; files Gccs, Bruennhilde, signat |
| head and closing tables | hsetup.sty:174, 188; hletter.cls:110 | `tbl.tabular` | `@{}r@{}`, `@{}l@{}`, `c`; `\arraystretch`=0.7 |
| rules | hsetup.sty:178, 192; hlete.clo:67 | `sp.rule` | `\rule{0pt}{.8em}` strut, `\rule[.5ex]{16mm}{1pt}` centre-block divider |
| emphasis | Testletter1.tex:44; Testletter3.tex:13; Testheader.tex:21 | `mark.kernel` | `\emph`, `\textbf`, `\textsc` |
| footnotes | Testletter1.tex:60, 66; Testletter2.tex:53 | `fn.kernel` | `\footnote`, counter reset per letter (hletter.cls:77) |
| manual spacing | Testletter1.tex:132; Testletter2.tex:82; Testheader.tex:23 | `sp.manual-space` | `\vfill`, `\vspace{2cm}`, `\vspace*{20mm}`; in the class `\smallskip` `\medskip` `\bigskip` `\hspace*{\fill}` (hletter.cls:95, 102, 110) |
| heading in the header test | Testheader.tex:24 | `head.kernel` | `\subsection*{..}` with a footnote |
| config file loading (class-internal) | hsetup.sty:55, 111-113 | `struct.input` | `\input hdefine.clo`; `\InputIfFileExists{hlet<lang>.clo}` with fallback to hlete.clo |
| mail merge | Testmerge.tex:5, 23-52; mergeh.sty:103-144 | `ltr.formlett` | `\usepackage{mergeh}`; `\begin{merge}{testmerge.dat}` around one letter body; the data file holds `{address}` and opening pairs (Testmerge.dat:1-54) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| letterhead config files `hdefine.clo`, `hlete.clo`, `hletf.clo`, `hletg.clo` (zip-local; the README lists them as example definition files to copy and modify, README:12-14, and hdefine.clo:3 says they should be rewritten by the user) | hdefine.clo:23-28; hlete.clo:26-107; hletf.clo:40-121; hletg.clo:26-106 | yes | Per letterhead the emitter writes `hdefine.clo` (`\logo`, four `\newoption{name}{n}`) and one `hlet<e,f,g>.clo` with the class-native setters (`\addressA..C`, `\extraA..C`, `\centreA..F`, `\centrepos`, `\bottomL..R`, `\sign`, `\logo`, `\address`) and `\DeclareFixedFont` calls (`font.nfss`). Only the selected case needs printing. |
| `\ifcase\hltype ... \or ... \fi` in the `.clo` files | hlete.clo:26-107; hletf.clo:40-121; hletg.clo:26-106 | yes | A selector among declarative blocks; it prints nothing itself. Flatten to the chosen case, or keep the class's own file format. |
| `\newoption{private}{1}` .. `{test}{4}` | hdefine.clo:25-28; hsetup.sty:32 | yes | A class option name and a number: parameters of `class.hletter`. |
| `hletter.cls`, `hsetup.sty`, `hhead.sty` | whole files | not bespoke (published) | CTAN `hletter`, in TeX Live. They redefine `letter`, `\opening`, `\closing` and draw `\dohead` with `picture`; this is class internals covered by `class.hletter`. |
| `mergeh.sty` | mergeh.sty:76-144 | not bespoke (published) | Ships in the CTAN bundle (README:10), a renamed `merge` with one comment-skipping change (mergeh.sty:15-17). Raw `\read` loop and box store; used only as `\usepackage{mergeh}` and `merge` environment (`ltr.formlett`). |
| macros or environments defined in the samples | Testletter1.tex, Testletter2.tex, Testletter3.tex, Testmerge.tex, Testheader.tex | none | A search finds no `\newcommand`, `\def` or `\newenvironment` in any sample. |

## Content-opaque
- Logo, signature and border images and the merge data records; the text of the letters. No figure or table float is used.
- Missing assets, shipped with the template: `../border.jpg` (Testheader.tex:16); `test`, `testsig` (hlete.clo:80, 98) and `GlogoCol` (hletg.clo:79), used only by the unused `test` option; the options `special`, `brian`, `zora` in commented lines (Testheader.tex:4; Testletter1.tex:2, 4) are not declared in hdefine.clo.
- `Hletter.pdf` (the manual) is documentation, not template.

## Lib changes
- New ways proposed: `ltr.formlett` `mergeh` (a renamed `merge` by G. McKinstry, shipped in the CTAN `hletter` bundle; the CTAN page of `hletter` says it works with the `merge` package), pdfLaTeX. W1: released on CTAN inside `hletter` (README:10). W2: the behaviour is chosen by a data file name and the records of that file (strings), not by editing code. W3: serves any letter-compatible class (mergeh.sty:150-166). W4: `\usepackage{mergeh}` in the preamble and `\begin{merge}{file}` ... `\end{merge}` around the letter body, with the data file written beside it. It is the same type of effect as `ltr.formlett` (one letter body per data record); the line of `ltr.formlett` names its own placeholders and does not say the package is the parameter, so it is proposed separately and may be folded into `ltr.formlett` if that line is widened.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
