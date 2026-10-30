yes

# 0694-cascadilla: cascadilla (Cascadilla Proceedings Project paper class)

- Unverified: read from the source, not compiled.
- Source: Source/0694-cascadilla/ (origin: https://mirrors.ctan.org/macros/latex/contrib/cascadilla.zip; licence: LPPL 1.3c, cascadilla.cls:5-13 and LICENSE.txt)
- Kind: conference
- Lib: v5
- Engine: pdfLaTeX-compatible (`times`, `natbib`, `titlesec`, `fancyhdr`, `geometry`, `caption`; no fontspec, no Lua)
- Look carried by: class (cascadilla.cls sets page, font, title block, footer, headings, captions and citations; example.tex adds only content and field values)
- Class origin: ctan
- Main file: example.tex (other samples: none; example.pdf is the compiled output of example.tex and was not read)
- Read: main yes, zip-local classes and styles all (cascadilla.cls in full; cascadilla.bst in full, as BibTeX code)

## Verdict
yes. The zip is the CTAN `cascadilla` bundle (class, `.bst`, example, `.bib`), so `class.cascadilla` is a published class (W1) and the bundled `cascadilla.bst` is its published BibTeX style, the parameter of `bib.bibtex-bst`. The sample's preamble is only `\documentclass{cascadilla}` and field commands; every body construct (sections, footnotes, one table with caption, citations, bibliography) maps to an existing lib way, and no artwork, external tool or content-opaque item is present. Sensitivity: if the class were read as zip-local, the one item I could not show to reduce is the kernel-internal `\@makefntext` redefinition (cascadilla.cls:210-213), and the answer would turn on it.

## Blockers
none

## Class setting
- Class: `class.cascadilla` (loads `class.article` underneath, `\LoadClass[letterpaper]{article}` or `[a4paper]`, cascadilla.cls:96-101); options used in the sample: none (example.tex:26). Options the class declares: `hyphenate` `nocopyright` `pagenums` `notimes` `a4paper` `nosignature` (cascadilla.cls:78-83, `\ProcessOptions` at :85); commented examples at example.tex:42-43.
- Class-native vocabulary used: `\title`, `\author` (redefined, cascadilla.cls:142-143), `\institution{}`, `\completed{}`, `\copyrightyear{}` (cascadilla.cls:144-146; example.tex:59-61), `\maketitle` (redefined, cascadilla.cls:151-188; example.tex:79), `\thanks` inside `\title` (redefined, cascadilla.cls:148; example.tex:48-49), `\immedsubsection` (cascadilla.cls:266; example.tex:155, 241), `\cascadillabibliography{db}` (cascadilla.cls:270; example.tex:307). `\immedsubsubsection` (cascadilla.cls:267) and `\blankline` (cascadilla.cls:132) exist but the sample does not call them directly. natbib commands `\citet` and `\cite` come with the class loading `natbib` (cascadilla.cls:124).

## Component map
| Component | Evidence | Way | Parameters |
|---|---|---|---|
| document class | example.tex:26; cascadilla.cls:96-104 | `class.cascadilla` | no options in the sample; the look is the class default (US Letter, Times, copyright footer, signature line) |
| base class | cascadilla.cls:97, 101 | `class.article` | `\LoadClass[a4paper]{article}` if `a4paper`, else `\LoadClass[letterpaper]{article}`; 10pt default |
| paper size | cascadilla.cls:97, 101 | `page.class-options` | `letterpaper` (default) or `a4paper` |
| page geometry | cascadilla.cls:103 (letter), :99 (a4) | `page.geometry` | letter: left=1.38in, right=1.38in, top=1.0in, bottom=1.0in, foot=0.75in; a4: left=3.15cm, right=3.15cm, top=2.54cm, bottom=4.29cm, foot=0.75in |
| text height, foot skip | cascadilla.cls:218, 227-230 | `page.setlength` | `\footskip`=0in (when page numbers are off); `\textheight`=8.75in at load, 9in at `\AtBeginDocument` (copyright on) |
| body font | cascadilla.cls:108-110 | `font.mathptmx` | `times` package, unless `notimes` |
| font sizes | cascadilla.cls:163, 173, 205, 257-259 | `font.size-commands` | title `\fontsize{18}{18}`, author `\fontsize{14pt}{14pt}`, `\let\footnotesize\small`, section `\fontsize{12pt}{0}`, sub-levels `\fontsize{11pt}{0}` |
| paragraph indent | cascadilla.cls:114, 202 | `sp.indentfirst`, `sp.lengths` | `indentfirst` package; `\parindent=0.25in` |
| no end-of-line hyphenation | cascadilla.cls:196-199 | `sp.penalties`, `sp.hyphenat` | `\hyphenpenalty=5000` (`sp.penalties`); `\tolerance=1000` (filed under `sp.hyphenat` as the `\sloppy` family, a judgement; skipped with option `hyphenate`) |
| title block | cascadilla.cls:151-188; example.tex:48-50, 59-61, 79 | `front.class-native` | centred block: signature statement and `\underline{\qquad...}` line (cascadilla.cls:153-161, off with `nosignature`), bold title 18pt, `\vspace{18pt}`, bold author 14pt, bold institution; inside the class: `font.size-commands`, `mark.kernel`, `sp.manual-space` (`\blankline` is `\quad\\`, :132) |
| author note | cascadilla.cls:148; example.tex:48-49 | `front.thanks` | `\thanks` inside `\title`, set as `\footnotetext[1]` with `\fnsymbol{footnote}` (invisible mark) |
| first-page copyright footer (interface) | cascadilla.cls:235-250; example.tex:59-61 | `hf.class-native` | fields `\author`, `\completed`, `\copyrightyear`; option `nocopyright` removes it; printed text `\copyright{} <year> <author> / Cascadilla Proceedings Project / Completed <date>` (cascadilla.cls:238-239) |
| copyright footer (implementation) | cascadilla.cls:236-241 | `hf.fancyhdr` | `\fancypagestyle{plain}{\fancyhf{}\fancyfoot[L]{..}\renewcommand{\headrulewidth}{0pt}}`, `\small`, `\vspace{0.1in}` or `\vspace{-0.65in}` by `pagenums` |
| page style | cascadilla.cls:216-219, 243-250 | `hf.pagestyle-kernel` | `\pagestyle{empty}` (off with `pagenums`); `\thispagestyle{plain}` on page 1 with copyright, else `\thispagestyle{empty}` |
| section headings | cascadilla.cls:256-262; example.tex:81, 103, 152, 291 | `head.titlesec` | `\titlelabel{\thetitle.\ }`; `\titleformat*{\section}{\fontsize{12pt}{0}\bf}`; subsection and subsubsection `{\fontsize{11pt}{0}\itshape}`; `\titlespacing` {0pt}{11pt}{10pt} for all three |
| heading commands | example.tex:81, 110, 168 | `head.kernel` | `\section`, `\subsection` (default article numbering); `\subsubsection` not used |
| immediate subsection | cascadilla.cls:266-267; example.tex:155, 241 | `head.class-native` | `\immedsubsection` is `\vspace{-9pt}\subsection{..}` (`sp.manual-space`) for a heading right after a heading |
| footnotes | example.tex:84, 145; cascadilla.cls:205, 210-213 | `fn.kernel` | `\footnote`; mark set flush left in a 1em box (class redefinition of `\@makefntext`), 9pt text |
| table | example.tex:181-204 | `tbl.tabular` | `table` float, `tabular` `{lrlr}`, 4 columns, no rules |
| table centring | example.tex:182 | `sp.ragged` | `\centering` |
| inline marks | example.tex:184-185, 201 | `mark.kernel` | `\emph` header cells, `\texttt{bzip2}` |
| caption | example.tex:200-203; cascadilla.cls:127 | `cap.kernel`, `cap.caption` | `\caption` below the table; `caption` package `labelfont=bf` |
| caption spacing | cascadilla.cls:222-223 | `cap.caption` | `\abovecaptionskip`=12pt, `\belowcaptionskip`=-5pt |
| label | example.tex:203 | `xref.kernel` | `\label{Bzip2}` (no `\ref` in the sample) |
| citations | cascadilla.cls:124, 273-275; example.tex:82, 97, 123 | `bib.natbib` | `\citet`, `\citet[3]`, `\cite`; `\bibpunct[:]{(}{)}{;}{a}{,}{,}` at `\AtBeginDocument` (gives (Shosted, 2006:13)); `\bibhang`=0.25in (cascadilla.cls:253) |
| bibliography | cascadilla.cls:270; example.tex:307; exampleref.bib:10-40 | `bib.bibtex-bst` | `\cascadillabibliography{exampleref}` = `\small`, `\baselinestretch`=2, `\bibliographystyle{cascadilla}`, `\bibliography{..}`; style `cascadilla.bst` (author-year, full names in labels, `\vspace{-0.9em}` after each item: cascadilla.bst:134-140, :1464-1479) |
| bibliography line spacing | cascadilla.cls:270 | `sp.linespread`, `font.size-commands` | `\renewcommand{\baselinestretch}{2}` after `\small` |

Not used by the sample and not defined by the class: abstract, contents lists, lists, quotes, maths, theorems, code, boxes, index, language and PDF metadata packages, colour, backgrounds.

## Bespoke code
All items below are inside the published `cascadilla.cls` or `cascadilla.bst` (CTAN bundle), so none is zip-local bespoke; the reductions are given in case a reviewer reads the class as zip-local.
| Item | Where | Reducible? | Reduction |
|---|---|---|---|
| `ifthen` booleans for options | cascadilla.cls:65-85 | yes | each boolean only selects a branch; the emitter writes the class option (`nocopyright`, `pagenums`, `notimes`, `a4paper`, `nosignature`, `hyphenate`) |
| `\author`, `\title` redefined | cascadilla.cls:142-143 | yes | `\gdef` copies of the arguments (also kept for the footer): `front.maketitle` fields |
| `\completed`, `\institution`, `\copyrightyear` | cascadilla.cls:144-146 | yes | string setters feeding the title block and footer |
| `\maketitle` redefined | cascadilla.cls:151-188 | yes | `center` block of `\fontsize`, `\textbf`, `\blankline`, `\vspace{18pt}`; the `haveTitle`/`haveAuthor`/`haveInstitution` tests only skip absent parts, which the emitter decides by node presence |
| `\thanks` redefined | cascadilla.cls:148 | yes | `\def\thefootnote{\fnsymbol{footnote}}\footnotetext[1]{..}`: `front.thanks`, `fn.kernel` |
| `\blankline` | cascadilla.cls:132 | yes | `\quad\\`: `sp.manual-space` |
| hyphenation parameters | cascadilla.cls:196-199 | yes | `\hyphenpenalty=5000`, `\tolerance=1000`: `sp.penalties`, `sp.hyphenat` |
| `\let\footnotesize\small` | cascadilla.cls:205 | yes | `font.size-commands` alias |
| `\@makefntext` redefined | cascadilla.cls:210-213 | open (see Verdict) | kernel-internal: `\settowidth` of the mark, `\parindent`=mark width+.75em, mark in `\makebox[1em][l]`; nearest lib way `fn.footmisc`, not shown to be exact; carried by `class.cascadilla` |
| `\CascadillaCopyright` | cascadilla.cls:235-242 | yes | one `\fancypagestyle{plain}` call: `hf.fancyhdr` |
| `\AtBeginDocument` order of `\textheight`, page style and `\bibpunct` | cascadilla.cls:229, 244-245, 273-275 | yes | ordered preamble lines: `page.setlength`, `hf.pagestyle-kernel`, `bib.natbib` |
| `\immedsubsection`, `\immedsubsubsection` | cascadilla.cls:266-267 | yes | `\vspace{-9pt}` plus `\subsection`/`\subsubsection`: `sp.manual-space`, `head.kernel` |
| `\cascadillabibliography` | cascadilla.cls:270 | yes | `\small`, `\baselinestretch`=2, `\bibliographystyle{cascadilla}`, `\bibliography`: `font.size-commands`, `sp.linespread`, `bib.bibtex-bst` |
| `cascadilla.bst` (hacked from sole.bst: no blank lines between entries, full names in the label) | cascadilla.bst:1-8, :134-140, :518-605 | yes | a `.bst` file is the parameter of `bib.bibtex-bst`; shipped as a published file of the bundle; the BibTeX stack code is not template macro logic |

## Content-opaque
none

## Lib changes
- New ways proposed: none
- Existing ways used for the first time by the lib: none needed (the consolidator computes this)
