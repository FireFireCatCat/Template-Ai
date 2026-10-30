yes

# 0950-cvsty: CVsty (CV.sty, a one-sheet CV style over article)

- Unverified: read from the source, not compiled.
- Source: Source/0950-cvsty/ (origin: https://mirrors.ctan.org/macros/latex/contrib/cvsty.zip; licence: pd, the CTAN page says "Public Domain Software")
- Kind: cv
- Lib: v6
- Engine: pdfLaTeX-compatible (`ae` and the psnfss family `ptm` are pdfTeX-era font names; no fontspec)
- Look carried by: zip-local (CV.sty carries page layout, font defaults, the section look and the `CV` list; the sample's preamble only loads packages. CV.sty is itself the CTAN package `cvsty`, in TeX Live as `cv`)
- Class origin: tex-distribution-unbundled (kernel `article`; its source is not in the zip and was not read)
- Main file: CV_dum.tex (other samples: none)
- Read: main yes, zip-local classes and styles all (CV.sty, 102 lines; the README is 10 lines of prose)

## Verdict
Yes. The look is all in the 102-line CV.sty, and every piece of it reduces to lib ways: raw page-length assignments with plain arithmetic (`page.setlength`, or `page.geometry` with the margins read from the arithmetic), NFSS default switches (`font.family-default`), a `\@startsection` call plus a one-argument `\section` wrapper (`head.kernel`, or `head.titlesec` with an after-code argument), and a kernel `list` environment with a few lengths (`list.kernel`, or `list.enumitem`). There is no counter, conditional, output routine, box algorithm, drawing or external tool. The sample body is plain kernel text, `minipage` columns, `tabular` and the `CV` list.

## Blockers
none

## Class setting
- Class: `class.article` options: `a4paper` (CV_dum.tex:1); 10pt by default.
- Class-native vocabulary used: none of article's front matter is used (no `\maketitle`, no `abstract`); only `\section` (redefined by CV.sty:81-87), `itemize`, `table`, `tabular`, `minipage`, `flushright`.
- Style-native vocabulary (CV.sty, no options): `\usepackage{CV}` (CV_dum.tex:7), environment `CV[n]{len}` (CV.sty:90), command `\specialisation{text}` (CV.sty:101).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | CV_dum.tex:1 | `class.article` | a4paper |
| paper size | CV_dum.tex:1; read back by CV.sty:29,32 | `page.class-options` | a4paper gives `\paperwidth`/`\paperheight` that CV.sty uses |
| page origin shift | CV.sty:18-19, 23-24 | `page.setlength` | `\hoffset`=-1in+1.5cm, `\voffset`=-1in+1cm (raw page-offset lengths) |
| text block | CV.sty:29-34, 42, 48-51, 65-68 | `page.setlength` | `\textwidth`=`\paperwidth`-2`\hoffset`-2in-`\oddsidemargin`, `\textheight`=`\paperheight`-2`\voffset`-2in; only `\setlength`/`\addtolength`, no conditional |
| side margins and margin notes | CV.sty:42-46, 58 | `page.setlength` | `\oddsidemargin`=-0.75cm, `\evensidemargin`=0cm, `\marginparsep`=`\marginparwidth`=`\marginparpush`=0cm |
| vertical page parameters | CV.sty:61-64 | `page.setlength` | `\topmargin`=`\headheight`=`\headsep`=`\footskip`=0cm |
| header/footer | CV_dum.tex:11 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (head and foot heights are 0 anyway, CV.sty:62-64) |
| font encoding | CV_dum.tex:6 | `font.fontenc-t1` | `[T1]`; the file holds Latin-1 bytes (CV_dum.tex:33,51) and loads no `inputenc` |
| CM-based font package | CV_dum.tex:5 | `font.lmodern` | package `ae` (Computer Modern virtual fonts, the type of `lmodern`; its rm/sf/tt defaults are overridden by CV.sty:71-73) |
| font family and shape defaults | CV.sty:71-79 | `font.family-default` | `\rmdefault`=ptm, `\sfdefault`=cmss, `\ttdefault`=cmtt, `\bfdefault`=bx, `\mddefault`=m, `\itdefault`=it, `\sldefault`=sl, `\scdefault`=sc, `\updefault`=n |
| section look | CV.sty:81-84 | `head.kernel` | `\@startsection{section}{1}{\z@}{-3.5ex plus -1ex minus -.2ex}{0.1ex}{\normalfont\Large\bfseries}` (negative before-skip: no indent after the heading) |
| section: numberless wrapper | CV.sty:85-86; used CV_dum.tex:30,61,74,85,94,100,130,135 | `head.kernel` | `\let\presection=\section`; `\renewcommand{\section}[1]{\presection*{#1}...}`: always the starred form, so no number and no contents entry; one argument only |
| section: rule under the heading | CV.sty:86-87 | `sp.rule` | `\noindent\rule{\textwidth}{1pt}` |
| section: spacing around the rule | CV.sty:86-87 | `sp.manual-space` | `\vspace{-1.5ex}` before, `\vspace*{-.5ex}` after |
| CV entry list | CV.sty:89-99 | `list.kernel` | generic `list{}{}`: `\makelabel`=`\entrylabel`=`\mbox{#1}\hfill` (label flush left), `\labelwidth`=width of "1999-1999", `\leftmargin`=42pt, `\vspace*{#1\smallskipamount}` before, `\vspace*{#2}` in the list settings |
| experience and education entries | CV_dum.tex:31-60, 62-71 | `list.kernel` | `\begin{CV}[2]{-4.5ex}`, `\item[date]` |
| publication list (hand typed) | CV_dum.tex:136-142 | `list.kernel` | `\begin{CV}[2]{-4.5ex}`, `\item[ ]`; entries are text, no cite or `.bib` mechanism, so no `bib.*` way |
| specialisation line | CV.sty:101-102; CV_dum.tex:29 | `sp.ragged` | `\centerline{\Large{\textbf{#1}}}` (a `\newcommand` alias; with `font.size-commands`, `mark.kernel`) |
| name line | CV_dum.tex:13 | `font.size-commands` | `\noindent {\Large \textsc{...}} \hfill` (with `mark.kernel` for `\textsc`, `sp.manual-space` for `\hfill`, `sp.lengths` family for `\noindent`) |
| contact block | CV_dum.tex:17-25 | `sp.ragged` | `flushright` environment; `\hfill` pairs and `\\` give left/right text on one line (`sp.manual-space`) |
| manual spacing | CV_dum.tex:15, 27, 128, 144 | `sp.manual-space` | `\smallskip`, `\vspace{2\baselineskip}`, `\vspace{1cm}` |
| three columns | CV_dum.tex:73-97 | `cols.minipage` | three `minipage` of 0.29`\linewidth`, `\hspace{0.02\linewidth}` between (CV_dum.tex:83, 92) |
| language table | CV_dum.tex:76-81 | `tbl.tabular` | `tabular{p{2.5cm}p{3cm}}` |
| computer skills list | CV_dum.tex:86-90 | `list.kernel` | `itemize`, items end with `\\` |
| page break | CV_dum.tex:98 | `pg.break` | `\pagebreak` |
| reference blocks | CV_dum.tex:105-114, 116-127 | `tbl.tabular` | kernel `table[h]` around `tabular{@{}lll@{}}`, no caption (so no `cap.*`) |
| emphasis | CV_dum.tex:33-35, 107, 118, 138 | `mark.kernel` | `\textbf`, `\textit`, `\textsc` |
| closing date | CV_dum.tex:146 | `front.maketitle` | kernel `\today` only (the date command of the `\date` family; no `\maketitle` is used) |
| loaded, not used | CV_dum.tex:3 | `tbl.tabularx` | `\usepackage{tabularx}`; no `tabularx` environment appears in the body |

Resulting a4 margins, read from the arithmetic and not measured: left 0.75cm, right 1.5cm, top 1cm, bottom 1cm, `\textwidth` 18.75cm, `\textheight` 27.7cm (page origin 1in+`\hoffset`+`\oddsidemargin` = 0.75cm from the left edge).

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| page layout block (offsets, text block, margins) | CV.sty:18-68 | yes | `page.setlength` as written; or `page.geometry`: `a4paper, left=0.75cm, right=1.5cm, top=1cm, bottom=1cm, headheight=0pt, headsep=0pt, footskip=0pt` (values from the arithmetic above; the arithmetic has no conditional and depends only on `\paperwidth`/`\paperheight`) |
| font default switches | CV.sty:71-79 | yes | `font.family-default` as written (NFSS names; `ptm` is the psnfss Times family, shipped with TeX Live) |
| `\section` as a `\@startsection` call | CV.sty:81-84 | yes | the kernel's own documented heading call with six arguments: `head.kernel`; or `head.titlesec`: `\titleformat{\section}{\normalfont\Large\bfseries}{}{0pt}{}` and `\titlespacing*{\section}{0pt}{3.5ex plus 1ex minus .2ex}{0.1ex}` |
| `\presection` alias and one-argument `\section` wrapper | CV.sty:85-87 | yes | `\let` alias plus `\renewcommand` wrapper; with titlesec it is the after-code argument `[\vspace{-1.5ex}\noindent\rule{\textwidth}{1pt}\vspace*{-.5ex}]` of `\titleformat`, and the body emits `\section*{...}`; no optional short title, which the sample never uses |
| `\entrylabel` | CV.sty:89 | yes | `\mbox{#1}\hfill`: kernel box and fill; in enumitem terms `align=left` |
| environment `CV[n]{len}` | CV.sty:90-99 | yes | no counter or conditional: kernel `list` with `\makelabel`, `\labelwidth`, `\leftmargin` and two `\vspace*`; as `list.enumitem`: `\newlist{CV}{description}{1}` with `\setlist[CV]{leftmargin=42pt, labelwidth=\widthof{1999-1999}, align=left, before=\vspace*{n\smallskipamount}\vspace*{len}}` (`sp.lengths` for `calc`) |
| `\specialisation` | CV.sty:101-102 | yes | `\newcommand` alias of `\centerline{\Large{\textbf{#1}}}` |

CV.sty is a CTAN package (cvsty, public domain), so W1 holds for it. It is analysed by reduction and not counted as one way, because it has no option interface (W2): its README invites editing the file (README:3-6). No `NEW:` way is needed.

## Content-opaque
none. Notes (not blockers): the three `\section` rules inside the minipages are `\textwidth` wide (CV.sty:87, CV_dum.tex:74,85,94), wider than the 0.29`\linewidth` boxes, so they stick out to the right; this is source behaviour recorded as read. CV_dum.tex holds two Latin-1 bytes (line 33 0xE9, line 51 0xE0) and no `inputenc`, so under a UTF-8-default LaTeX the file as shipped may not compile; an emitter writes UTF-8 text and is not affected. Nothing in the zip addresses an AI.

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
- Considered, not proposed: treating `CV.sty` as one class-like way (as the v3 and v6 change-log entries merge house-style add-ons into a class way): not needed, since the decomposition above is complete.
- Mapping notes: `ae` is filed under `font.lmodern` (a Computer Modern replacement package, the package being the parameter); `\today` under `front.maketitle` (the kernel date family); `\noindent` with the `sp.lengths` paragraph-shape family. A reviewer who files these elsewhere changes no verdict.
