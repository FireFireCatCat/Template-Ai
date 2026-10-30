no

# 0605-plasmati-cv: tccv two-column CV (substitute for Plasmati's CV)

- Unverified: read from the source, not compiled.
- Source: Source/0605-plasmati-cv/ (origin: https://latextemplates.com/downloads/plasmati-cv.zip; licence: LPPL-1.3+ for tccv.cls, README.md:36-42; main.tex:1-8 says the zip replaces the CC-BY-NC-SA original)
- Kind: cv
- Lib: v5
- Engine: pdfLaTeX-compatible (README.md:21 builds with `pdflatex`; tccv.cls:37-40 and :89-92 branch on `\directlua`: `bookman` and `pzc` otherwise, `fontspec` TeX Gyre Bonum, `\itshape` and the Lua `\ucwords` under LuaLaTeX)
- Look carried by: zip-local (tccv.cls defines the whole look; the sample preamble adds only `babel`, main.tex:12)
- Class origin: zip-local
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
No, because of one blocker. Everything in `tccv.cls` is a `scrartcl` load plus published packages, colours, KOMA font settings and small macros that reduce to lib ways (table below), but `\ucwords` (tccv.cls:51-67) is Lua code that computes the printed heading text under LuaLaTeX, and no lib way holds "capitalise the first letter of every word of three or more characters". Under pdfTeX the same macro returns the text unchanged (tccv.cls:53), so the pdfLaTeX build alone would reduce completely; this is a close call that turns on whether Lua-computed heading text counts as template. A wrong `yes` costs more, so the verdict is `no`.

## Blockers
- `BESPOKE/class` `\ucwords` is a `\directlua` function that splits the heading on spaces, upper-cases the first letter of each word with at least `#1` (default 3) characters and prints the result; `\section` calls it on every heading (tccv.cls:51-67, :111). `mark.case` changes the case of a whole span (`\MakeUppercase`), it does not express a per-word first-letter rule with a length threshold, and `mfirstuc` (considered) has no length threshold.

## Class setting
- Class: `class.scrartcl` options: `fontsize=10pt` (KOMA key, main.tex:11). `tccv` itself is zip-local: `\LoadClassWithOptions{scrartcl}` at tccv.cls:30, the header says "based on scrartcl" (tccv.cls:17). main.tex:10 says tccv is not in TeX Live, ctan.org/pkg/tccv returned "Not Found", and the zip comes from latextemplates.com, not the author's page, so it is not published by the W1 rule.
- Class-native vocabulary used (all tccv, zip-local, reduced below): `\part[subtitle]{name}` redefined as the CV subject (main.tex:16), `\section` redefined with capitalised text and a rule (main.tex:18, 24, 60, 74, 88), `eventlist` with `\item{dates}{company}{role}` (main.tex:26-52), `yearlist` with `\item[note]{years}{subject}{notes}` (main.tex:62-72, 76-86), `\personal[url]{address}{phone}{email}` (main.tex:54-58). Defined but unused by the sample: `factlist`, `keyvaluelist` (used inside `\personal`), `\ifjob`, option `blackwhite`.
- KOMA font elements set or added: `disposition`, `section`, new `cv` (tccv.cls:87-92); `part` is used (tccv.cls:102).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | tccv.cls:30; main.tex:11 | `class.scrartcl` | loaded with the caller's options |
| font size | main.tex:11 | `page.class-options` | `fontsize=10pt` |
| page geometry | tccv.cls:33 | `page.geometry` | hmargin=1.25cm, vmargin=1.25cm, twocolumn, columnsep=1.25cm |
| columns | tccv.cls:98-105; main.tex:16 | `cols.twocolumn-cmd` | `\twocolumn[full-width block]` once, at `\part` |
| title block (name, subtitle) | tccv.cls:98-105; main.tex:16 | `cols.twocolumn-cmd`, `sp.ragged`, `head.koma-fonts`, `sp.manual-space` | `center` env, `\vskip-\lastskip`, `{\usekomafont{part} name}\medskip\\`, `{\usekomafont{cv} Curriculum Vitae}` (default text, tccv.cls:98), `\bigskip` |
| subtitle font `cv` | tccv.cls:89-92 | `head.koma-fonts`, `font.nfss`, `font.size-commands`, `mark.kernel` | `\newkomafont{cv}`: pdfTeX branch `\fontfamily{pzc}\selectfont\Huge`; LuaLaTeX branch `\itshape\huge` |
| header/footer | tccv.cls:83 | `hf.pagestyle-kernel` | `\pagestyle{empty}` |
| paragraph indent | tccv.cls:84 | `sp.lengths` | `\parindent=0pt` |
| text colour | tccv.cls:70, 85 | `color.xcolor` | `\definecolor{foregound}{HTML}{303030}` (sic), `\color{foregound}` for the page |
| colour palette | tccv.cls:71-74, 77-79 | `color.xcolor` | url 506060, link 506060, header 801010, personal F5DD9D; option `blackwhite` sets header 1C1C1C and personal F7F7F7 (not used in the sample) |
| text font, pdfTeX branch | tccv.cls:37-39 | `font.serif-pkg` | package `bookman` (PSNFSS) |
| text font, LuaLaTeX branch | tccv.cls:40 | `font.fontspec` | `\setmainfont{TeX Gyre Bonum}` |
| links | tccv.cls:35, 86; main.tex:79 | `meta.hyperref` | `\hypersetup{colorlinks,breaklinks,urlcolor=url,linkcolor=link}`; body `\href` |
| language | main.tex:12 | `lang.babel` | `english` |
| heading numbering | tccv.cls:32 | `num.secnumdepth` | `secnumdepth=-1` |
| heading fonts | tccv.cls:87-88 | `head.koma-fonts` | `disposition` = `\color{header}`; `section` = `\scshape\Large\mdseries` |
| heading rule | tccv.cls:109-114 | `head.kernel`, `sp.rule`, `sp.manual-space` | after `\section`: `\vskip-0.7\baselineskip`, `\hrule height 0.4pt`, `\vskip 0.7\baselineskip` |
| heading text capitalisation | tccv.cls:51-67, 111 | none (blocker) | `\ucwords{#2}` inside `\section`; identity under pdfTeX (tccv.cls:53) |
| contact box | tccv.cls:136-150, 159-167; main.tex:54-58 | `box.fancybox`, `color.xcolor`, `tbl.tabularx`, `font.icons`, `font.size-commands`, `sp.manual-space`, `pg.needspace`, `meta.hyperref` | `\colorbox{personal}{tabularx{\dimexpr\linewidth-2\fboxsep}{c\|X}}`, rows icon `\ding{45}` `{37}` `{41}` `{218}` as `\raisebox{-2pt}{\Large\ding{n}}`, `\smallskip` between rows, `\needspace{0.5\textheight}`, `\href{mailto:..}` |
| experience entries | tccv.cls:177-186; main.tex:26-52 | `sp.ragged`, `mark.kernel`, `font.size-commands`, `sp.manual-space` | per entry `{\raggedleft\textsc{dates}\\[1pt]}`, company `\\[2pt]`, `{\Large\textit{role}}`, `\medskip`; `\bigskip` between entries and after the list |
| year entries | tccv.cls:196-202; main.tex:62-72, 76-86 | `tbl.tabularx`, `mark.kernel`, `sp.manual-space` | `tabularx{\linewidth}{rX}`; row `\textsc{years} & \textbf{subject}\\`, optional `& \textsc{note}\\`, `& \textit{notes}\medskip\\` |
| skills list | main.tex:96-101 | `list.kernel` | `description` with four labelled items |
| fact list (unused) | tccv.cls:211-217 | `tbl.tabularx`, `mark.kernel`, `sp.ragged`, `sp.manual-space` | `tabularx{\linewidth}{rX}`, row `\textsc{fact} & {\raggedright text\medskip\\}\\[-\baselineskip]`; the sample avoids it (main.tex:90-95) |
| bibliography heading (no bibliography in sample) | tccv.cls:222, 224-226 | `toc.koma`, `bib.biblatex-biber` | `\KOMAoption{bibliography}{totocnumbered}`; if `biblatex` is loaded, `\defbibheading{bibliography}[\refname]{\section{#1}}` |
| abstract, contents, floats, captions, theorems, code, quotes, notes, math, index | main.tex:1-103 | not used | the sample has none |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\ucwords` (Lua capitalisation) | tccv.cls:51-67 | no | Lua text function with a length threshold; blocker above |
| `\part` redefinition | tccv.cls:98-105 | yes | `\twocolumn[\begin{center}..\end{center}]` with `\usekomafont{part}` and `\usekomafont{cv}`, as in the title row |
| `\section` redefinition | tccv.cls:109-114 | yes, apart from `\ucwords` | `\old@section` is the kernel/KOMA `\section`; the added rule is `\vskip`, `\hrule`, `\vskip`; the `\newdimen\raising` is only a scratch length (value -0.7\baselineskip) |
| `\ifjob` | tccv.cls:123-126 | yes (unused) | string test on `\jobname` that picks one of two texts; the sample never calls it (grep of main.tex); an emitter writes the chosen branch |
| `keyvaluelist` and counter `KEYVALUECOUNTER` | tccv.cls:136-150 | yes | the counter only omits the separator before the first row; written statically: `\colorbox{personal}{tabularx{\dimexpr\linewidth-2\fboxsep}{c\|X} key & value \smallskip\cr ...}`; the `\setbox0=\hbox\bgroup` wrapper only captures the table for `\colorbox` |
| `\personal` with `\SYMBOL` | tccv.cls:159-167 | yes | `\needspace`, the box above, `\SYMBOL{n}` = `\raisebox{-2pt}{\Large\ding{n}}`, the url row only if the optional argument is non-empty (`\ifstrempty`, decided by the emitter) |
| `eventlist` with `\inskip` | tccv.cls:177-186 | yes | `\inskip` is `\bigskip` after the first item and empty before it; written statically as in the entries row |
| `yearlist` | tccv.cls:196-202 | yes | `tabularx{\linewidth}{rX}` rows as in the table |
| `factlist` with `\unbaseline` | tccv.cls:211-217 | yes (unused) | negative `\\[len]` after each row, `len` = -`\baselinestretch\baselineskip` |
| `\newkomafont{cv}` | tccv.cls:89-92 | yes | font element set once; engine branch picked by the emitter |
| option `blackwhite` | tccv.cls:77-79 | yes (unused) | two `\definecolor` lines replace the defaults |
| `\AtEndPreamble` biblatex hook | tccv.cls:224-226 | yes | `\defbibheading` line, emitted only when `biblatex` is in use |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered: `etoolbox` (loaded at tccv.cls:34; its commands `\ifstrempty` `\ifnumequal` `\ifdefstrequal` `\AtEndPreamble` appear only inside the zip-local macros above, which reduce by inline expansion, so there is no body node for it to wrap), `mfirstuc` (capitalises every word, has no length threshold, so it would not reproduce `\ucwords`).
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
