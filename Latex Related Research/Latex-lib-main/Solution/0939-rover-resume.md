yes

# 0939-rover-resume: Rover Resume (Star variant)

- Unverified: read from the source, not compiled.
- Source: Source/0939-rover-resume/ (origin: https://latextemplates.com/downloads/rover-resume.zip, upstream https://github.com/subidit/rover-resume per main.tex:3 and ATTRIBUTION.txt:4; licence: CC-BY-4.0)
- Kind: cv
- Lib: v6
- Engine: pdfLaTeX-compatible (`\pdfgentounicode` is a pdfTeX primitive, main.tex:25; README.md:18 builds with `pdflatex`; the CTAN page of `fira` lists pdfLaTeX)
- Look carried by: preamble (kernel `article` loaded unchanged; the whole look is the preamble of main.tex:14-78 plus three one-line `\newcommand` helpers)
- Class origin: tex-distribution-unbundled
- Main file: main.tex (other samples: none). The zip holds three files: main.tex, README.md, ATTRIBUTION.txt; no .cls, .sty or other style file.
- Read: main yes, zip-local classes and styles none present

## Verdict
yes. The class is the unmodified kernel `article` and every preamble line is a published package (`FiraSans`, `geometry`, `xcolor`, `enumitem`, `xhfill`, `soul`, `titlesec`, `lastpage`, `fancyhdr`, `fontawesome5`, `multicol`, `hyperref`) with option values. The four zip-local macros (`\linkicon`, `\midrule`, `\aux`, `\rside`) are `\newcommand` aliases whose bodies only call those packages and kernel font, colour and spacing commands, so each reduces (see Bespoke code). There is no drawing, no counter or conditional logic, no external tool, and the body is sections, lists and links.

## Blockers
none

## Class setting
- Class: `class.article` options: `11pt` (main.tex:11); paper size is set by `geometry`, not by the class (main.tex:15).
- Class-native vocabulary used: none of the class-specific front matter. There is no `\title`, `\author`, `\maketitle` or `abstract`; the sample uses only `\section`, `\subsection`, `\subsubsection`, `itemize`, `enumerate`, `description` and `center` (main.tex:85-185).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | main.tex:11 | `class.article` | `11pt` |
| base font size | main.tex:11 | `page.class-options` | `11pt` |
| page geometry | main.tex:15 | `page.geometry` | a4paper, margin=1in |
| text face | main.tex:14 | `font.helvet` | `\usepackage[sfdefault,semibold,lf]{FiraSans}`: a sans text-face package is the parameter (lib v1 merge of `font.opensans`); options sfdefault (sans is the default family), semibold, lf (lining figures) |
| name weight | main.tex:92 | `font.nfss` | `\fontseries{heavy}\selectfont` (selects a series name) |
| font sizes | main.tex:91; main.tex:21, 47-48, 69 | `font.size-commands` | `\fontsize{36}{12}` for the name; `\large` in headings; `\small` in footer; `\footnotesize` in `\linkicon` |
| accent and grey colour | main.tex:17-18, 57, 93; gray at main.tex:21, 69, 99 | `color.xcolor` | `\definecolor{accent}{HTML}{141E61}`; `\color{accent}`; named colour `gray`; accent also passed as the rule colour to `\xrfill` (main.tex:40) |
| section numbering off | main.tex:24 | `num.secnumdepth` | `\setcounter{secnumdepth}{0}` |
| PDF text mapping | main.tex:25 | `meta.glyphtounicode` | `\pdfgentounicode=1` only (no `\input{glyphtounicode}`) |
| list defaults | main.tex:29-32 | `list.enumitem` | `\setlist[itemize]{nosep, left=0pt .. 1.5em}`; `\setlist[enumerate]{left=0pt..1.5em}`; `\setlist[description]{itemsep=0pt}` |
| bullet and description lists in body | main.tex:112-116, 123-127, 131-134, 139-143, 163-166, 172-175, 178-182 | `list.kernel` | `itemize` with `\item`; `description` with `\item[label]` |
| unnumbered-style enumerate (certifications) | main.tex:148-151 | `list.enumitem` | `\begin{enumerate}[label=\null, left=0pt..0pt, itemsep=0pt]` |
| numbered enumerate (publications) | main.tex:156-158 | `list.kernel` | plain `enumerate`, one hand-typed reference as list content (no bibliography way is involved) |
| section heading (rule, letterspaced, caps) | main.tex:43, 47 | `head.titlesec` | `\titleformat{\section}{\large\bfseries\uppercase}{}{}{\midrule}`: empty label and separator, before-code `\midrule` receives the title |
| section spacing | main.tex:44 | `head.titlesec` | `\titlespacing{\section}{0pt}{*4}{*1}` |
| subsection heading | main.tex:45, 48 | `head.titlesec` | `\titlespacing{\subsection}{0pt}{*3}{*0}`; `\titleformat*{\subsection}{\large\bfseries\scshape}` |
| subsubsection spacing | main.tex:46 | `head.titlesec` | `\titlespacing{\subsubsection}{0pt}{*0}{*0}`; no `\titleformat` for this level, so its format is the one the class and `titlesec` give by default (not read) |
| sectioning commands in body | main.tex:109, 111, 119, 121-122, 169, 171 | `head.kernel` | `\section`, `\subsection`, `\subsubsection`; the date and role are inside the heading argument via `\aux` and `\rside` |
| upper-casing of section titles | main.tex:47 | `mark.case` | `\uppercase` in the format argument |
| inline font switches | main.tex:47-48, 53, 57, 113, 157 | `mark.kernel` | `\bfseries`, `\scshape`, `\itshape`, `\normalfont`, `\textit` |
| rule fill beside section title | main.tex:36, 40 | `sp.rule` | `xhfill`: `\xrfill[.5ex]{1pt}[accent]` twice (raise .5ex, thickness 1pt, colour accent); a rule-drawing package is the parameter, as `dashrule` is in the lib line. The CTAN page of `xhfill` (LPPL, TeX Live, Herbert Voss) says "extended macros for `\hrulefill`" with width and colour; it names no commands, the `\xrfill` signature comes from the sample, its manual was not read |
| letterspaced title text | main.tex:37, 40 | `mark.ulem` | `soul` `\so{#1}`: soul is named by this lib line; `\so` is a command of that package (spacing out, not underline), recorded here as the same package family |
| manual spacing and alignment | main.tex:40, 53, 57, 95, 99-103 | `sp.manual-space` | `~` ties, `\space`, `\hfill` (`\rside`), `\medskip`, `\quad`, `\\`, `\raisebox{1pt}` (main.tex:21); `$|$` (main.tex:53) is a glyph in a text span |
| footer (page style) | main.tex:63-66, 69, 71 | `hf.fancyhdr` | `\pagestyle{fancy}`, `\fancyhf{}`, `\renewcommand{\headrulewidth}{0pt}`, `\fancyfoot[C]{\small\color{gray} Maya Torres -- Page \thepage\ of \pageref*{LastPage}}`; `\pagestyle{empty}` at main.tex:71 is a comment (an option the author may switch on) |
| page X of Y | main.tex:62, 69 | `pgnum.lastpage` | `lastpage`, label `LastPage`, printed by `\pageref*{LastPage}` (two passes, README.md:21) |
| non-linking page reference | main.tex:69 | `xref.hyperref` | starred `\pageref*` (hyperref's form without a link) |
| PDF link options | main.tex:78 | `meta.hyperref` | `\usepackage[bookmarks=false,hidelinks]{hyperref}` |
| links in banner and projects | main.tex:99-103, 171, 177 | `xref.hyperref` | `\href{tel:...}`, `\href{mailto:...}`, `\href{https://...}{text}` |
| icons | main.tex:76; main.tex:21, 99-101, 103 | `font.icons` | `\usepackage{fontawesome5}`; `\faIcon{external-link-alt}`, `\faPhone`, `\faEnvelope`, `\faGithub`, `\faLink` (`\faHome` and `\faLinkedin` only in comments, main.tex:97, 102) |
| multicol (load only) | main.tex:77 | `cols.multicol` | `\usepackage{multicol}`; no `multicols` environment is used in the body (grep) |
| name and contact banner (title block) | main.tex:89-104 | `sp.ragged` | `center` environment holding the name set with `font.size-commands`, `font.nfss` and `color.xcolor` (main.tex:91-94), then a `\\ \medskip` break and a line of `\href` + icon items separated by `\quad`. There is no `\maketitle` or title way: the block is hand-laid body content built only from the rows above |
| project links with icon | main.tex:20-22, 171, 177 | `font.icons` | `\linkicon` = grey, small, raised `external-link-alt` icon inside `\href` (see Bespoke code) |

## Bespoke code
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `\linkicon` | main.tex:20-22 | yes (alias) | `\color{gray}` (`color.xcolor`) + `\footnotesize` (`font.size-commands`) + `\raisebox{1pt}` (`sp.manual-space`) + `\faIcon{external-link-alt}` (`font.icons`); no logic |
| `\midrule{#1}` (heading before-code) | main.tex:38-41 | yes (alias, PREAMBLE scope) | `\leavevmode` (kernel mode switch, no printed effect), `\xrfill[.5ex]{1pt}[accent]` (`sp.rule`), `~`, `\so{title}` (`mark.ulem`), `~`, `\xrfill[.5ex]{1pt}[accent]`. It is declared as a one-argument macro because `titlesec` hands the title to the last command of the before-code (`head.titlesec`); the emitter writes the same declaration. The name equals booktabs's `\midrule`; booktabs is not loaded here, but a shared preamble that also loads `tbl.booktabs` would have to rename it |
| `\aux` | main.tex:52-54 | yes (alias) | `$|$`, `\space`, group with `\normalfont\itshape` (`sp.manual-space`, `mark.kernel`) |
| `\rside` | main.tex:56-58 | yes (alias) | `\hfill` (`sp.manual-space`) then group with `\normalfont\color{accent}` (`mark.kernel`, `color.xcolor`) |

All four are in the sample's own preamble (scope preamble). There are no counters, conditionals, `\def`s, environments or expl3/Lua code (grep over main.tex finds only `\definecolor` and `\renewcommand{\headrulewidth}`).

## Content-opaque
none (no figure, table, picture or bibliography; the one publication entry at main.tex:157 is list content typed by hand)

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)

## Notes
- Judgement calls a reviewer may want to re-read: `mark.ulem` for soul's `\so` (same package as the lib line names, a different command type), `sp.rule` for `xhfill` (the lib line already admits a rule-drawing package as the parameter), `font.helvet` for `FiraSans` (the lib's sans text-face merge; its options sfdefault, semibold and lf come from the sample, the CTAN page of `fira` does not list them).
- W1 reads at ctan.org: `xhfill` (LPPL, TeX Live), `fira` (Bob Tennent; LPPL and OFL; TeX Live; pdfLaTeX, XeLaTeX, LuaLaTeX). The other packages are standard TeX Live packages and were not re-read.
- Missing assets: none. The README states the Star variant of eight upstream variants (README.md:3-10); that is data about the zip, nothing in the zip addresses an AI.
- Not claimed: any compile result or visual equality.
