yes

# 0543-sciposter: SciPoster (A0 portrait scientific poster)

- Unverified: read from the source, not compiled.
- Source: Source/0543-sciposter/ (origin: https://latextemplates.com/downloads/sciposter.zip; licence: not established (manifest UNKNOWN; README.md:14-21 says CTAN tags the class LPPL but no grant text was found in the vendored copy))
- Kind: poster
- Lib: v4
- Engine: pdfLaTeX-compatible (the sample loads `inputenc`/`fontenc`, `multicol`, `booktabs`, `tikz`, `amsmath`: main.tex:31-37; the class source was not read, but the CTAN page says sciposter works with plain LaTeX, not only pdfLaTeX)
- Look carried by: mixed (the published `sciposter` class carries page size, title block and `\Section` boxes; the sample's own body wrapper `multicols{3}` supplies the columns, because the class has no column layout: main.tex:8-11, README.md:9-10)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none; README.md is documentation only)
- Read: main yes, zip-local classes and styles none present

## Verdict
The zip holds one 251-line sample and a README; there is no `.cls`, `.sty` or other zip-local code, and the sample defines no macro, environment, counter or conditional of its own. The look comes from the published `sciposter` class (on CTAN, version 1.18, and in TeX Live; the starter does not bundle it: main.tex:5-6), whose class options and native commands the sample sets, plus published packages (`multicol`, `booktabs`, `amsmath`, `inputenc`/`fontenc`, `graphicx`). The two TikZ pictures are figure content, not template identity. All components map to lib ways, so `yes`. The caveat is that the class source was not read (it is not in the zip), so what the class itself does, such as its default logo space, margins and section-box look, rests on the sample's comments and README.

## Blockers
none

## Class setting
- Class: `class.sciposter` options: `a0`, `portrait`, `final` (main.tex:30)
- Class-native vocabulary used: `\title` and `\author` (main.tex:39-40); `\theinstitute` redefined with `\renewcommand` (main.tex:41); `\printemail` redefined (main.tex:42); `\conference{...}` (main.tex:43); `\maketitle` (main.tex:46); `\Section{...}`, 13 uses, first at main.tex:50 and last at main.tex:243. Mentioned only in comments: `\sSection`, `\printleftlogo`, `\printrightlogo`, the `useleftlogo`/`userightlogo` defaults (main.tex:8-13). The class has no abstract environment: the abstract is an ordinary `\Section{Abstract}` (main.tex:50).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:30 | `class.sciposter` | a0, portrait, final |
| page size and orientation | main.tex:30 | `page.class-options` | `a0`, `portrait` (class options; no `geometry` or `\setlength` in the sample) |
| columns | main.tex:33, 48, 250 | `cols.multicol` | `multicols` environment, 3 columns, wrapping the whole body after `\maketitle`; no `\columnbreak` (the one stray break was removed: main.tex:20-21) |
| input and font encoding | main.tex:31-32 | `font.fontenc-t1` | `inputenc` utf8, `fontenc` T1 |
| graphics package | main.tex:34 | `fig.graphicx` | package loaded; no `\includegraphics` and no `figure` float in the sample (the figures are TikZ in `center`: see Content-opaque) |
| title, author | main.tex:39-40 | `front.maketitle` | `\title{...}`, `\author{...}` with `$^1$` `$^2$` affiliation marks written in the text |
| title block (institute, e-mail, conference, logos) | main.tex:41-43, 46 | `front.class-native` | `\theinstitute` and `\printemail` set to strings (the institute string uses `\quad`), `\conference{ACM SIGMOD 2026}`, `\maketitle`; the logo slots keep their empty defaults (main.tex:11-13) |
| headings and boxed sections | main.tex:50, 59, 74, 88, 119, 137, 159, 171, 188, 203, 225, 232, 243 | `head.class-native` | `\Section{title}` only; the look is the class's, no option set; it keys off `\columnwidth` (main.tex:8-10) |
| abstract | main.tex:50-57 | `head.class-native` | an ordinary `\Section{Abstract}` with a paragraph; no `abstract` environment |
| display and inline maths | main.tex:89-102, 192, 209 | `math.amsmath` | `amsmath` loaded (main.tex:37); `\[ \]` (main.tex:94-97), `\text`, `\sum`, `\max`, `\le`, `\times` |
| tables | main.tex:190-198, 205-213 | `tbl.tabular` | `tabular{lccc}` and `{lc}` inside `center` |
| table rules | main.tex:35, 191-197, 206-212 | `tbl.booktabs` | `\toprule` `\midrule` `\bottomrule` |
| figure and table captions | main.tex:154-156, 184-185, 200, 215-216 | `sp.ragged` | hand-typed text "Figure 1: ..." / "Table 1: ..." in `center` (no `\caption`, no float, so no `cap.*` way) |
| caption size | main.tex:154, 184, 200, 215 | `font.size-commands` | `\footnotesize` |
| spacing after floats | main.tex:157, 186, 201, 217 | `sp.manual-space` | `\medskip`; `\quad` in the institute string (main.tex:41) |
| no first-line indent after display maths | main.tex:99 | `sp.lengths` | `\noindent` (one use; judgement call, the per-paragraph form of `\parindent`; no other lib way is closer) |
| reference list | main.tex:233-241 | `list.kernel` | `enumerate` with 5 `\item`s inside `footnotesize`; no `thebibliography`, no `\cite`; the citations `[1]` to `[3]` are typed text (main.tex:76-80) |
| reference and acknowledgement size | main.tex:233, 241, 244, 248 | `font.size-commands` | `footnotesize` environment around the list and the acknowledgement paragraph |
| inline marks | main.tex:54, 56, 235-239 | `mark.kernel` | `\textsc{TenantLRU}`, `\textit{...}` |
| TikZ pictures | main.tex:36, 139-152, 173-182 | `art.tikz` | content, see Content-opaque |
| running heads and footers, margins, fonts, colours | not set by the sample | none | whatever `sciposter` defaults to; not read (class not in the zip) |
| cross-references, footnotes, index, bibliography engine | not used | none | `\label`, `\ref`, `\footnote`, `\cite` and `\bibliography` do not occur in main.tex |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\renewcommand{\theinstitute}{...}` | main.tex:41 | yes | sets a class-native string hook (README.md:11 names it as a field to edit): `front.class-native` with one string value (affiliation text, `\quad` and maths superscripts); no logic |
| `\renewcommand{\printemail}{...}` | main.tex:42 | yes | the same type: `front.class-native` with the string `a.researcher@somewhere.edu` |
| `\tikzstyle{box}=[...]` | main.tex:140 | yes | a TikZ key list (`draw`, `rounded corners`, `minimum width`, `minimum height`, `align`, `inner sep`) inside figure content; no template effect |
| zip-local `.cls` / `.sty` / `\newcommand` / `\def` / counters / conditionals | none | n/a | the zip has no such file and the sample defines none |

## Content-opaque
- TikZ architecture diagram, a vertical flow of six filled boxes with arrows (main.tex:139-152), with its hand-typed caption (main.tex:154-156). Judged figure content: it depicts the paper's system, not the poster's frame or blocks, and sits inside the body text.
- TikZ line plot of p99 latency over epochs with three coloured curves (main.tex:173-182), caption at main.tex:184-185. Figure content, same reasoning.
- Table cell contents and data (main.tex:190-212), the paper text, the equation (main.tex:94-97) and the five reference entries (main.tex:235-239).

## Lib changes
- New ways proposed: none. The class is written `class.sciposter` plainly, with its native vocabulary under "Class setting"; `front.class-native` and `head.class-native` already exist in the lib.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
