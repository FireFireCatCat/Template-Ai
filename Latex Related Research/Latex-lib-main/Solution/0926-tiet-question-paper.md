yes

# 0926-tiet-question-paper: TIET Question Paper

- Unverified: read from the source, not compiled.
- Source: Source/0926-tiet-question-paper/ (origin: https://latextemplates.com/downloads/tiet-question-paper.zip; licence: MIT)
- Kind: exam
- Lib: v6
- Engine: pdfLaTeX-compatible
- Look carried by: class (the sample sets only the class options and the title-field commands; the page, lists, title block and rules are all defined in tiet-question-paper.cls)
- Class origin: ctan
- Main file: main.tex (other samples: none)
- Read: main yes, zip-local classes and styles all

## Verdict
The look is carried by `tiet-question-paper`, a class that is on CTAN and in TeX Live (MIT, v2024-06-22; one read of ctan.org/pkg/tiet-question-paper), so it is one way, `class.tiet-question-paper`. The zip's copy has one documented one-line patch (cls:143-154), which reduces to a class-native call. Read as if the class were zip-local, it still reduces: it loads `article` and published packages, and the redefined `\maketitle` is built from `\rule`, `\parbox`, `\hfill`, `\vspace` and `\MakeUppercase`. The sample adds only field values, nested `enumerate` lists with `resume`, `align*` maths and rules, with no artwork, external tool or irreducible code, so the verdict is yes.

## Blockers
none

## Class setting
- Class: `class.tiet-question-paper` options: `11pt,a4paper,onecolumn` (main.tex:4). The class forwards every option to `article` (cls:20, 21) and then loads `article` with the same three options fixed (cls:22). Parent: `class.article`.
- Class-native vocabulary used: field setters `\date` (kernel), `\institute`, `\schoolordepartment`, `\examname`, `\coursecode`, `\coursename`, `\timeduration`, `\maxmarks`, `\faculty` (main.tex:5-15; defined cls:130-187); the redefined `\maketitle` (main.tex:18; cls:281-304); the rule command `\bvrhrule[<thickness>]` (main.tex:25, 49, 62, 95, 105, 128; cls:198-200). Defined but not used by the sample: `\instlogo`, `\abbrevinst`, `\instaddress`, `\cohort` (cls:136-167), `\bvrskipline` (cls:202-204), `\footnotenoless` (cls:310-314), the abbreviation macros `\eg \ie \cf \etc \vs \wrt \dof \etal` (cls:325-344). `\abbrevinst`, `\instaddress` and `\cohort` are stored but never printed (their only occurrences are the definitions at cls:136-137, 140-141, 166-167).

- Origin check: ctan.org/pkg/tiet-question-paper loads (MIT, v2024-06-22, shipped in TeX Live and MiKTeX per that page). README.md:10-12 calls the file vendored and "not on a default TeX Live install", and README.md:28 mentions a CTAN distribution; the zip is not an official release, so W1 rests on the CTAN page.

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:4; tiet-question-paper.cls:13-15, 20-22 | `class.tiet-question-paper` | options 11pt, a4paper, onecolumn; field vocabulary above |
| parent class | tiet-question-paper.cls:20-22 | `class.article` | `\LoadClass[11pt,a4paper,onecolumn]{article}`; `\DeclareOption*` passes options on |
| paper size, point size | main.tex:4; tiet-question-paper.cls:22 | `page.class-options` | a4paper, 11pt, onecolumn (the article default, one column) |
| page geometry | tiet-question-paper.cls:28-34 | `page.geometry` | a4paper, left=1in, top=0.5in, right=0.75in, bottom=0.75in |
| header/footer | none set (no `\pagestyle` in main.tex or the class) | `hf.pagestyle-kernel` | article default `plain` only; recorded as a default, nothing is set |
| title block | main.tex:18; tiet-question-paper.cls:281-304 | `front.class-native` | `\maketitle` rebuilt: roll-number line and bold date, course line, faculty line, centred institute block, rule, spacing (layout read in the rows below) |
| title fields | main.tex:5-15; tiet-question-paper.cls:130-187 | `front.class-native` | `\institute`, `\schoolordepartment`, `\examname`, `\coursecode`, `\coursename`, `\timeduration`, `\maxmarks`, `\faculty` set strings; `\instlogo` empty by default (cls:154) |
| date | main.tex:5; tiet-question-paper.cls:283 | `front.maketitle` | kernel `\date{8 December 2026}`, printed by the class as `\bfseries\@date` |
| rules | tiet-question-paper.cls:198-200, 282, 302; main.tex:25, 49, 62, 95, 105, 128 | `sp.rule` | `\rule{\linewidth}{0.4pt}` (`\bvrhrule[0.4pt]` between questions); `\rule{5cm}{0.4pt}` roll-number line; `\rule{\textwidth}{0.4pt}` under the title block |
| manual spacing | tiet-question-paper.cls:282, 287-288, 293, 303, 260, 263, 204; main.tex:33, 46, 55-59 | `sp.manual-space` | `\hfill` (roll-number line, course/time line, `\hfill [n marks]` in the questions), `\hspace{0.3em}`, `\vspace*{\baselineskip}`, `\vspace*{0.5\baselineskip}`, `\vspace*{0.2\baselineskip}` twice, `\vspace{#1\baselineskip}` (`\bvrskipline`, unused) |
| institute block | tiet-question-paper.cls:256-265 | `box.minipage` | `\parbox[t][][t]{\linewidth}{...}` holding institute, department and exam name |
| logo cell | tiet-question-paper.cls:268-272 | `box.minipage` | `\parbox[t][][t]{\linewidth}{\raggedright ...}`; used only when `\instlogo` is set, not by the sample |
| alignment | tiet-question-paper.cls:257, 269 | `sp.ragged` | `\centering` (institute block), `\raggedright` (logo cell) |
| type size and weight | tiet-question-paper.cls:257-258, 283, 286-289; main.tex:19 | `font.size-commands` | `\large` on the institute block and the course line |
| inline marks | tiet-question-paper.cls:258, 283, 286-290; main.tex:19, 30-31 | `mark.kernel` | `\bfseries`, `\textbf{}` on course, time, marks, "Instructions:", vectors (`\textbf{b}_0`) |
| exam name case | tiet-question-paper.cls:264 | `mark.case` | `\MakeUppercase\tiet@examname` |
| logo image | tiet-question-paper.cls:71, 270 | `fig.graphicx` | `\includegraphics[width=11.5mm,...]{\tiet@instlogo}`; logo branch only, not run by the sample |
| logo alignment | tiet-question-paper.cls:107, 270 | `fig.adjustbox` | `\RequirePackage[export]{adjustbox}`, key `valign=t`; logo branch only |
| logo table | tiet-question-paper.cls:99, 297-299 | `tbl.tabularx` | `\begin{tabularx}{\textwidth}{Xp{18mm}}` with institute block and logo; logo branch only |
| paragraph spacing | tiet-question-paper.cls:58 | `sp.parskip-pkg` | `\RequirePackage{parskip}`, no options (no indent, paragraph gap) |
| lists | tiet-question-paper.cls:78-81; main.tex:20, 26, 28, 50, 52, 63, 65, 96, 98, 106, 108 | `list.enumitem` | `[inline,sizes]`, `\setlist{nosep,leftmargin=*}`, `\setlist[enumerate,2]{label=\alph*)}`; sample uses `enumerate`, `[resume]`, level 2 labelled `a)` |
| sectioning fonts | tiet-question-paper.cls:121-123 | `head.sectsty` | `\allsectionsfont{\sffamily}`, `\paragraphfont{\sffamily}`; the sample has no heading |
| maths | tiet-question-paper.cls:40; main.tex:35-44, 69-74, 81-92, 114-122 | `math.amsmath` | `align*`, `bmatrix`, inline `$...$` (`\forall`, `\equiv`, `\mathbf`, `\theta=\pi/4`) |
| font sizes at any size | tiet-question-paper.cls:87 | `font.exscale` | `\RequirePackage{anyfontsize}`, load-only, no options; same type as `fix-cm` (CTAN page read: lets `\fontsize` take sizes not in the `.fd` file) |
| dummy text | tiet-question-paper.cls:46 | `draft.todo` | `\RequirePackage{blindtext}`, load-only, "for debugging" (cls:43-45); never called |
| footnote without mark | tiet-question-paper.cls:310-314 | `fn.kernel` | `\footnote{#1}` with `\thefootnote` set to `\relax`; unused by the sample |
| footnote counter | tiet-question-paper.cls:311-313 | `num.counters` | `\let\thefootnote`, `\addtocounter{footnote}{-1}` restores the count |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| patched logo default `\let\tiet@instlogo\@empty` | tiet-question-paper.cls:143-154 | yes | One-token bug fix of a published class (README.md:18-31). The same state is reached by emitting `\instlogo{}` with an empty argument in the preamble (cls:155 sets the macro to its argument; the empty macro matches `\@empty` in the `\ifx` at cls:294). Reasoned from the source, not compiled. |
| field variables and setters `\def\tiet@...`, `\def\institute#1{\gdef...}` | tiet-question-paper.cls:130-187 | yes | String storage for the title fields. An emitter writes `\institute{..}` and the other setters with the document's values (`front.class-native`). |
| `\renewcommand\maketitle` | tiet-question-paper.cls:281-304 | yes | A fixed sequence of lib ways: `\noindent Roll No.`, `sp.rule` 5cm, `sp.manual-space` `\hfill`, bold `\@date`, `\large` course line with `\textbf` fields, `Faculty:` line, `\vspace*`, institute block (`box.minipage`, `sp.ragged`, `mark.kernel`, `mark.case`), `\rule{\textwidth}{0.4pt}`, `\vspace*`. The `\ifx\tiet@instlogo\@empty` branch (cls:294-300) chooses between two fixed layouts, and the emitter knows statically whether a logo is set (the sample sets none). No counters, no box-and-glue measuring, no output routine. |
| `\writeexamdetails`, `\drawinstlogo` | tiet-question-paper.cls:254-272 | yes | `\DeclareRobustCommand` wrappers around one `\parbox` each; inline expansion into `box.minipage` with the formatting listed in the map. |
| `\bvrhrule`, `\bvrskipline` | tiet-question-paper.cls:198-204 | yes | `\rule{\linewidth}{<t>}` (`sp.rule`) and `\vspace{<n>\baselineskip}` (`sp.manual-space`); inline expansion. |
| `\footnotenoless` | tiet-question-paper.cls:310-314 | yes | `\let` of `\thefootnote`, kernel `\footnote`, `\addtocounter{footnote}{-1}` (`fn.kernel`, `num.counters`); no conditional, inline expansion. Unused by the sample. |
| `\onedot` and the abbreviation macros `\eg \ie \cf \etc \vs \wrt \dof \etal` | tiet-question-paper.cls:320-344 | yes | `\futurelet` and `\ifx` only decide a trailing period and a space after an abbreviation; the emitter writes the abbreviation as text (`\emph{e.g.}` and a space) with the next character known. Same ruling as the lib's rejected `sp.xspace` (inline expansion). Unused by the sample. |
| `ifmtarg`, `linegoal` | tiet-question-paper.cls:52, 93 | yes | Load-only helper packages that the class never calls (grep of the whole zip: only the `\RequirePackage` lines). No printed effect, so the emitter can omit them; `linegoal` uses pdfTeX `\pdfsavepos` through `zref-savepos` (CTAN page read) only when `\linegoal` is called, and it never is. Not components, so no way is needed. |
| commented-out code (setspace, paracol, `\graphicspath`, `qenum` list with `\ifbvrfirstq`) | tiet-question-paper.cls:64-65, 72, 79, 115, 206-246 | not active | Comments only; nothing is loaded or defined. |

## Content-opaque
none

## Lib changes
- New ways proposed: none. Considered and not proposed: `anyfontsize` is the same type as `fix-cm` under `font.exscale`; `blindtext` is a dummy-text package under `draft.todo`; `ifmtarg` and `linegoal` have no printed effect and need no way.
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
